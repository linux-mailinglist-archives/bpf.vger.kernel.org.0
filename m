Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17E3C9AF3
	for <lists+bpf@lfdr.de>; Thu, 15 Jul 2021 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbhGOJGM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Jul 2021 05:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbhGOJGM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Jul 2021 05:06:12 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61171C06175F
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 02:03:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id f30so8635281lfj.1
        for <bpf@vger.kernel.org>; Thu, 15 Jul 2021 02:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=u8CkpBKLYS7g2kO3mPeqyQBaVJz6+nB6V6ow/bpW7pk=;
        b=P/QIKJMNlhFR9TKmTti0CEPE5wY8Wc71cyfH4IjYTxA8SLs2H8JIHjIfPUSTwE8GwO
         27ZyXIyaObTVF4FVOby6rSn3JMkPzvzXZ8b6NQsJtxT8qC4UeWz5xkIgQbbD1cE9wWBx
         vktEkHxHYXZ0h4lF8sV5CnkoORHt5MOknv7LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=u8CkpBKLYS7g2kO3mPeqyQBaVJz6+nB6V6ow/bpW7pk=;
        b=dxOJ3R+GEkdLAQ8+TP4qKYBhZgE2ihCvkfxrqwIN1Z0yfkdjMi3EpxJEvVbLY6Dpab
         zoYe21EXkoEWoPCYpF8kwk0gBqNjabRMcIBB2eMMuPz4wu0dfyZCw0RgD/77RLFNN3UV
         5XruKkuutgCGI/ikPYx0WRAKSymS10585u02VxnrnuOoDH/L7Af/tskV9RTYsUd96dSr
         J/Qn7bJIQNkJCbdU13AM96F5LafeJxzBngrBKk8JktSJK15n7GhLOeJBX5l46cBP0CX4
         SpHbXVrMg4C121nCZPCqBriNJV6y7oD3ZXyneZdxiB1uQZ7rNCyL74UiE/sSXq2eWkVP
         yBsg==
X-Gm-Message-State: AOAM530HIgk1PDDz91qsIfq5oDQIC1AP071YFBzuaACp9tgvsz6RFOfJ
        XyC8OF+2uHtw+9QqBl2NQ+gzaiLtqSztkcg31wZUcQ==
X-Google-Smtp-Source: ABdhPJzgMu4/Qp1tVDiuAXAxSfBipQaSsAsiAFMWntUrkjHAeUlI59lzyd3bYaE3gng5t7ecOWHgU8IbNGpidquNrn4=
X-Received: by 2002:a05:6512:3225:: with SMTP id f5mr2520707lfe.97.1626339797585;
 Thu, 15 Jul 2021 02:03:17 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 15 Jul 2021 10:03:06 +0100
Message-ID: <CACAyw99ZrBRr9QydPVvuWNksGfOckq-giTUR29sjzZDfdx5MFA@mail.gmail.com>
Subject: Can't build 5.13 selftests against clang-12 nor clang-13
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

I'm trying to build 5.13.2 selftests for github.com/cilium/ci-kernels.
With clang-12:

    libbpf: failed to find BTF for extern 'tcp_reno_cong_avoid' [38] section: -2
    Error: failed to open BPF object file: No such file or directory
    libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
    Error: failed to open BPF object file: No such file or directory

Arnaldo has hit this problem before:
https://www.spinics.net/lists/dwarves/msg01332.html So I tried to
recompile with clang-13 (Ubuntu clang version
13.0.0-++20210629083512+c4de78e91c93-1~exp1~20210629184258.496):

    libbpf: ELF relo #0 in section #15 has unexpected type 2 in
/home/lorenz/dev/ci-kernels/build/linux-5.13.2/tools/testing/selftests/bpf/bpf_cubic.o

Aka my clang-12 is too old, my clang-13 is too new. In the past we've
stubbed out some tests based on clang version, can we do the same
here?

This build breakage tends to happen with every major kernel release.
Is there a way to avoid this? FWIW some CI builds fail because of
this, however I have no idea where these reports go / why they aren't
taken into account: https://lkml.org/lkml/2021/6/22/987

It would be nice if there was some combination of (easily available
clang release) x (stable kernel versions) that allows to compile BPF
selftests successfully.

Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
