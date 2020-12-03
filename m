Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04BB2CE046
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:02:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgLCVCT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLCVCS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 16:02:18 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98864C061A4F;
        Thu,  3 Dec 2020 13:01:38 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id r127so3313639yba.10;
        Thu, 03 Dec 2020 13:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+eQGGEOMVXRPEoq8s6lQdLNuBt3JK/5yXKT7IpNr4IQ=;
        b=oROLXir8WRNqBkWEEUeU5/8JdCypCPu9aKHIVMtntYeXFFBwcFWRowKCkVeU8edlya
         UViecJWVPjManvSQDHtzvakIOT6b7ra+J8ANOI7A1usWwj1ASdZYMPxkkDPw6l6zMKMC
         dBtXyQqYvN9NzIQhUQKSHf1YSvi7FePJ3zXJ0TCwFYky8fbgI+/xoGVvicLkCrqECjXF
         zU+8SaD2nVFjAM/WvE9b67qTsOB1elfOQUczIDDZdqIQbPkRAhCZeE+RuDVf6mI6EH2Y
         8GeX2PkxCk79PA83jA2YZMPOHHxlm6hOeJ+9KHIMzAE1Sgss/sCxh8WHF7P+DKKU2yNr
         5CPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+eQGGEOMVXRPEoq8s6lQdLNuBt3JK/5yXKT7IpNr4IQ=;
        b=RcB4Mnr6RZ683eYe8zvCjunEpm7Gj7GsE0Dm2Rlp/kIQvISzGxB3MvLyZsfHQub/l9
         zz1ao6X/ImAmVkjul/ee+cuVp8XDZ20/XtGwW00VzXFn7xORHAYEiAUuc1VsO5lkYoeN
         IQRU5x0GqGFncd02wSdDP7IXzcgFB9uRQ8/MXudACWcxAa8s/j0STxFEtr2hm2wSRUzG
         i+JTZPvUrb2ACd9RM/tiMTbJe/qAv3aMvc80rzifH5FvgAnv/5QjZiQkCCzZJuRZiyTa
         VgBjBiJqNYYGr0iv0P/GCdm5i+wFRO/2C/WedVDxfHObT9MUng4tgxS9TGyiuxrZ1238
         Mqaw==
X-Gm-Message-State: AOAM5320aFvYOeFcxSMGVemohPpzMoc3fCNNP68OJ+vw+JOdpMJhliQY
        l2XmvzFNGGAQpA/XHPIczHah2RwnwitwXHWV8FM=
X-Google-Smtp-Source: ABdhPJy4L7Kpx4H0kEhxp/2oPxCTtdtezLaECzgxFzEJeTiPa8bqGMUmCbGmTnZ8hbDuqX2FBTrvtL+xk5a2zv+kli8=
X-Received: by 2002:a25:c7c6:: with SMTP id w189mr1363230ybe.403.1607029297953;
 Thu, 03 Dec 2020 13:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20201203160245.1014867-1-jackmanb@google.com> <20201203160245.1014867-13-jackmanb@google.com>
In-Reply-To: <20201203160245.1014867-13-jackmanb@google.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 3 Dec 2020 13:01:27 -0800
Message-ID: <CAEf4BzbEfPScq_qMVJkDxfWBh-oRhY5phFr=517pam80YcpgMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 12/14] bpf: Pull tools/build/feature biz into
 selftests Makefile
To:     Brendan Jackman <jackmanb@google.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        open list <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 3, 2020 at 8:07 AM Brendan Jackman <jackmanb@google.com> wrote:
>
> This is somewhat cargo-culted from the libbpf build. It will be used
> in a subsequent patch to query for Clang BPF atomics support.
>
> Change-Id: I9318a1702170eb752acced35acbb33f45126c44c

Haven't seen this before. What's this Change-Id business?

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---
>  tools/testing/selftests/bpf/.gitignore |  1 +
>  tools/testing/selftests/bpf/Makefile   | 38 ++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)

All this just to detect the support for clang atomics?... Let's not
pull in the entire feature-detection framework unnecessarily,
selftests Makefile is complicated enough without that.

[...]
