Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCAA2DC14C
	for <lists+bpf@lfdr.de>; Wed, 16 Dec 2020 14:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgLPNaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Dec 2020 08:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgLPNaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Dec 2020 08:30:10 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92C4C06179C
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 05:29:14 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m12so48345458lfo.7
        for <bpf@vger.kernel.org>; Wed, 16 Dec 2020 05:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sgvygWZRMVMdlNQXwO6BqVOaC+KEYfDLNNKaI08jAK4=;
        b=svacateK/IpFDtM5xAfELt7SJGco0sGhWrVSJflCr7lx9mfC9Ak0mrPwHA7DFnT0I0
         4n8hVDZI83ZmDEx0+ft7lL/lljlB2d8Yd4M9gpv5p2S/1n+z92Tef0ntriqTGZq9M/KP
         YvP4Lc+JRvoW+ZnbH9D/UBOBFNkAiW2QOazzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sgvygWZRMVMdlNQXwO6BqVOaC+KEYfDLNNKaI08jAK4=;
        b=rHMGiiIhqZ/pG80c/zSg1YuTjd2cYe5asfqFBVvaJgddIZ2NyOlTo4FzvzrKyX67dY
         HJYUoa2mMbwF+n7ovFyWTAu832q1xVv97kzSpOcqjHSuUnmFYAH2Dfi20C68FDiR2/df
         y+FV2G8uYlNhYw2JIIpROC0Fuo8JMJmjs2MHrWOzMZAF+CrmE3GssGcm3cRnZLx8ReMm
         QIFx3SGhDbwqhsGxob+vwIGYhQzS9XpSsdp/zgoxoTv167CCvKmhFbECEDQSQj6bbul8
         n+pEvoViiTYcLZCbUSqcrDpPncqvE8pvu0piDlobBgUwigoGhU+syMf8DwxYTJ2/S132
         NU4w==
X-Gm-Message-State: AOAM530e2VZydMdxDOfqMsCIJeswd/lWI70m1kbRRziTcGN9KovYTJo6
        BOzvVxBA2r1i57YinZeKpq2RhSvgE9Ig5AadbyZ8qXbilIYYVKsI
X-Google-Smtp-Source: ABdhPJxZLDgZdiKNkraveGDZt34rgNgZ/34De9ox48EXsZ253b6ptSVv7h4A+IV0oC236V0o5UJXlLqZu//ZqjZpf4k=
X-Received: by 2002:a2e:8e3b:: with SMTP id r27mr15099651ljk.196.1608125352986;
 Wed, 16 Dec 2020 05:29:12 -0800 (PST)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 16 Dec 2020 14:29:02 +0100
Message-ID: <CACAyw98GbSi6UWDoN+A-B7Fct7fHsdgP67D5qf1oQVbUjdo1Fw@mail.gmail.com>
Subject: Can we share /sys/fs/bpf like /tmp?
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jakub Sitnicki <jakub@cloudflare.com>,
        kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We're currently in the process of deploying our BPF socket dispatch
control plane. This is the first piece of code where we persist maps
my pinning them into a bpffs. We tried using /sys/fs/bpf but ran into
permission problems:

    $ ls -ld /sys/fs/bpf
    drwx-----T 2 root root 0 Dec 10 21:48 /sys/fs/bpf

For various reasons our program has a dedicated user, so we can't
access /sys/fs/bpf. I did some digging into how the mode came about.
In our environment the mount is done by systemd:

* First, systemd mounted without explicit mode set [1]. I think this
means originally the mode was 1777.
* Second, systemd changed this to 0700 [2]. The commit references some
discussion with BPF folks, but I can't find a source for this
discussion.

What were the reasons for changing the mode to 0700? Would it be
reasonable to mount /sys/fs/bpf with 1777 nowadays?

Thanks
Lorenz

1: https://github.com/systemd/systemd/commit/43b7f24b5e0dd048452112bfb344739764c58694
2: https://github.com/systemd/systemd/commit/39f305a901934dfcc064cffd4e419b92d90b02c0
--
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
