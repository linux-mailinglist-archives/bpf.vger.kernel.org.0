Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC832A5ACA
	for <lists+bpf@lfdr.de>; Wed,  4 Nov 2020 00:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbgKCXy7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 3 Nov 2020 18:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKCXy6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 3 Nov 2020 18:54:58 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BC1C0613D1
        for <bpf@vger.kernel.org>; Tue,  3 Nov 2020 15:54:58 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id 184so24653306lfd.6
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2020 15:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8lDrxUTIF40KHfIpRwkvY1S7iDIUJT3T+Woc9vm4rpE=;
        b=eHqqkExJVG/Kbrb2ftfhiDFEisqnHGDoETG962QThYzW8ZWaaGhMFZdSJvf0EzFHf8
         z1Op1WiCjJESYO9KUwHo4NWR/MwQttB3swBrDDKkCVHVe3zqiJvYy8OgWlKFhs8OMDNr
         bWGtXcAsu06cMdQcc8z2HELDz4WC6B0WuX0xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8lDrxUTIF40KHfIpRwkvY1S7iDIUJT3T+Woc9vm4rpE=;
        b=fHIulhDW2YwdN5gSSbcETFeqS4id40P4yz2IOhYcsY5qOFmZrw1IL3szFAh2FYx8l9
         ayzQUKOCdUAL9i2Bf36kR/mjm+VKhIQtiLPMKDSpcob9fb3+3SVSKg6v3jO9t6OMWwLR
         9b4CFjore2WdduZQ4ClVcsrH4sWAop4mLYeqos+0GBooUfXxc3e/mSAC3U0W8n5j17la
         0TZA4q7Cs1HbyWIy8inbE+48HQq8a7sr4eF+uE7GMmGPSVheILPgFroN6b01+cAtO8pm
         yLedPh9Slrc7qDHv/w4vxxCmXgjDyM0g92PqX1FbOBW5iGrC4Nbx24l/tyOnfbZcGLHN
         kcFg==
X-Gm-Message-State: AOAM533tE7nBdiIjjN80tqiWfk7DZKE5lg9kF2DkfmyAuwfO0AztCFD+
        kB5S0nL04nRVXUCKAsY8M5wFvI+6JGNduau1xM3F8Q==
X-Google-Smtp-Source: ABdhPJww2euBrCXNELLlitwDHFuj0AgG3E35CiIl+6Q/lbTawO90n4zWgzxXPUvsgMTpMC2KZ2AhpbjUuNCA8SEWc8U=
X-Received: by 2002:a05:6512:3102:: with SMTP id n2mr8262163lfb.153.1604447697030;
 Tue, 03 Nov 2020 15:54:57 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-2-kpsingh@chromium.org> <B5563E63-BA82-4D15-8480-354FA733ED43@fb.com>
In-Reply-To: <B5563E63-BA82-4D15-8480-354FA733ED43@fb.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Wed, 4 Nov 2020 00:54:46 +0100
Message-ID: <CACYkzJ79KVG6-W3ChGUC-AX8iU4Qt9gA=D2ht6UU+XThC5yJ2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/8] bpf: Implement task local storage
To:     Song Liu <songliubraving@fb.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 4, 2020 at 12:47 AM Song Liu <songliubraving@fb.com> wrote:
>
>
> > On Nov 3, 2020, at 7:31 AM, KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Similar to bpf_local_storage for sockets and inodes add local storage
> > for task_struct.
> >
> > The life-cycle of storage is managed with the life-cycle of the
> > task_struct.  i.e. the storage is destroyed along with the owning task
> > with a callback to the bpf_task_storage_free from the task_free LSM
> > hook.
> >
> > The BPF LSM allocates an __rcu pointer to the bpf_local_storage in
> > the security blob which are now stackable and can co-exist with other
> > LSMs.
> >
> > The userspace map operations can be done by using a pid fd as a key
> > passed to the lookup, update and delete operations.
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
>
> Acked-by: Song Liu <songliubraving@fb.com>
>
> with a few nits:
>
> > ---
> > include/linux/bpf_lsm.h        |  23 +++
> > include/linux/bpf_types.h      |   1 +
> > include/uapi/linux/bpf.h       |  39 ++++
> > kernel/bpf/Makefile            |   1 +
> > kernel/bpf/bpf_lsm.c           |   4 +
> > kernel/bpf/bpf_task_storage.c  | 313 +++++++++++++++++++++++++++++++++
> > kernel/bpf/syscall.c           |   3 +-
> > kernel/bpf/verifier.c          |  10 ++
> > security/bpf/hooks.c           |   2 +
> > tools/include/uapi/linux/bpf.h |  39 ++++
> > 10 files changed, 434 insertions(+), 1 deletion(-)
> > create mode 100644 kernel/bpf/bpf_task_storage.c
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index aaacb6aafc87..326cb68a3632 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -7,6 +7,7 @@
> > #ifndef _LINUX_BPF_LSM_H
> > #define _LINUX_BPF_LSM_H
> >
> > +#include "linux/sched.h"
>
> vscode?

Yep, turns out it was clangd (which I use in vscode) and I needed to
pass "--header-insertion=never"
when starting the clangd server, I fixed all other instances as well.

- KP
