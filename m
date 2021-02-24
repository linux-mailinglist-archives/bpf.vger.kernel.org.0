Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAD83244BE
	for <lists+bpf@lfdr.de>; Wed, 24 Feb 2021 20:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234022AbhBXTpD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Feb 2021 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhBXTpC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Feb 2021 14:45:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C0CC061574
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 11:44:22 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id c131so3016190ybf.7
        for <bpf@vger.kernel.org>; Wed, 24 Feb 2021 11:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=5bQWuq1BWH4yyi1eDlsRA90lWB8xlpUYqQvaqVE48Z0=;
        b=dbkNX4tInLOW0uZrOUEN0ynR7r9Sko8L121wzCLQwgKjrtR898b1dFX9EgXcOQXd/1
         27YEr8NGfedPsDjRr/0myIEw2RKbZRUrcUHLHh1VspamlN94FfldFrWq0GC1qins9RQ7
         DjMXLyfIqY5nmK7jrmTSqHn5zLiiHK1i3e4rP1LMhK3gXXJhhFC2l5Vctidfv+arbhYm
         vNeMpgBCgb53CIrWmzGoihvqse9LDrQdu6C2GPoK3CMi7Ya0LLvVx2RUfI3GNE1lKDca
         +VEleyvVoYupnhcnd6aEbPtYoE4ASrdU0oYYAG1nVEUAkXKEtx/JlR3ovJB0BWUkaoUg
         ZrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=5bQWuq1BWH4yyi1eDlsRA90lWB8xlpUYqQvaqVE48Z0=;
        b=SToOUZynWSlgdIp4EvpGmQ4yD8VlkYee8+CvkcHWajGy8XRsDTsAUzKWNkuSdHKzK9
         mqb8rHIvcTuHOCuIaSVhx7Oo4BKtATMsBGQyz+nRXbemX/gIwVOFedQoCorBKxL0iTMD
         aTB2vVlY2paQPxVbm0XqTHDPD/G5q6WdcDYqDMWd+7pIluVSvuhJeA9QpQhcJ+2BCAJA
         GxnsIESAY5yj9RgqHVHMDco2seS5758uPJ9iAOu+vm9ycSfovW7ChGlFz7vcbRTppwfo
         wum1l73liGzLB1RlKMPmoZgdnzUQRkAZyl5dF98bQDgR9+pbIB9RnJqYHcRVTYAsLiko
         H3DA==
X-Gm-Message-State: AOAM530BCuX3wyrK+eOk3hXx58d4fOoFff7fGY4Gl03a+R3G9krAoT1X
        e5QT/JnmZJR3vRk+9ZwwPdhkTjOcGjU1R3nVD7wddSOi7Nw=
X-Google-Smtp-Source: ABdhPJxojcP7fV2AwRb4CaEmur8+tOYvf/HhlldjUHTJet6OFEqr1v8xXgr/vs1l5dWngDDLjRf/sj6ezNno6iJaZtA=
X-Received: by 2002:a25:c6cb:: with SMTP id k194mr48412820ybf.27.1614195861291;
 Wed, 24 Feb 2021 11:44:21 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 24 Feb 2021 11:44:10 -0800
Message-ID: <CAEf4BzZ+jJs7-HtjVLzcevmGf78PHxEsrk66FwKvy6FCsiU=nQ@mail.gmail.com>
Subject: libbpf: the road to v1.0
To:     bpf <bpf@vger.kernel.org>
Cc:     Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

So I've been ruminating on getting libbpf to 1.0 version for a while
now and finally got to write down most of the major (and not so much)
things I wanted to change and/or break, given v1.0 gives an
opportunity to break API/ABI compatibility, where necessary.

I decided to share this with the community in the form of a Google Doc
(check [0]), open to commenting by anyone, because there are many
different things, quite often completely independent from each other.
So email doesn't feel like the right medium to have a discussion given
the amount of people that might be interested about just pieces of the
plan.

The overarching idea is to streamline APIs, make them overall more
consistent throughout, as well as eliminate some very common pitfalls.
Any such changes means potentially more pain for existing users during
the transition period. I realize that, but I hope everyone will keep
in mind the longer term goal of making libbpf easier to use both for
the new and existing users.

My intent is to spend some time in discussions and see what I have
missed and what would be argued to be too drastic/problematic. So the
plan is not set in stone and can/will be adjusted (within reason, of
course, I don't believe everyone is going to converge and be happy
about all the changes, but that's OK). But once decided on the plan, I
(and hopefully others will help) will start implementing changes, will
probably create a wiki page documenting API migration paths, etc, etc.
My current thinking is to do a gradual transition, rather than a big
bang breaking change in 1.0 release. This should give people more time
to find any possible breakages and adopt their code base gradually, so
that by the 1.0 time there isn't much surprise left. But feel free to
argue the other way.

BTW, that document is only describing potentially breaking changes, it
doesn't mean libbpf won't get any other new functionality. I still
plan a bunch of other (new) features to be added before v1.0. E.g.,
stuff like BPF static linking support (merging together multiple BPF
.o files) and declarative PROG_ARRAY map initialization pops to mind
immediately.

So, please check the document, leave comments, make yourself aware of
upcoming changes. Thank you!

  [0] https://docs.google.com/document/d/1UyjTZuPFWiPFyKk1tV5an11_iaRuec6U-ZESZ54nNTY/edit?usp=sharing

-- Andrii
