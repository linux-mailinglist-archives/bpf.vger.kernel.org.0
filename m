Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8149AC73
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 07:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353970AbiAYGhO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 01:37:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343777AbiAYGXX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 01:23:23 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5C2C0544F1
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:43:04 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id n32so9181339pfv.11
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 20:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jW5BFXl3yzMIYHW+lvkQuXPjopT4xywi+/J99pfueuk=;
        b=HH7ggx39JWCtxYrm1DZc2kf2GEJBr/OojzZXoowyJmBfgmImkII8tXir1k2w3qPStH
         GHJFsVHbHIqdd+PA7uHtgppDpE0oJl5cDi0wyykCBlmoo5mASLYCm8nwkqpADDWwwblk
         Pg9O1UgPVW7dDEPJVu3VBWUH9oKHUmJFmohK2aiuzpjYdklN8OiyrPUXzWFQ++Q0EfRJ
         b91SDJK2CDnT5hnz4p/aHFdDO4RIZ8EW0ZFRbz3btxmMYXAXgNJl2yV7MAq4J3kHAHUg
         AfcKMCA52QsKtilEpFY1+d/AQcwulc4FA7iA1I/GC+P2DjJDwXVoipiEXEzzhmsgGUde
         Z3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jW5BFXl3yzMIYHW+lvkQuXPjopT4xywi+/J99pfueuk=;
        b=uwJWT2jpSzuM9GBTx0tBjleryI0wRIWZUGpwMmt8Ro4btIsgYUbsQnlUEAm0HO6fYS
         6KuFGyEUhYwA7KlBvmJU4WyiLT8MCpg1Et5lWx0rkOLkFyUvZZkYpBaQW2vnctQiGjUp
         O7xvllLa8ewUjIWmKm504AEkj8r8+Mt8vtMAGBzerPPB6g+pwePx4G1oe9+NRIy1CpUH
         0OHaYC5CuJiBYHJihBFgkw3P9vraSnklH55GPnod5bXN6zZ9ePPOznS4bvNsWFIc1QoO
         B9vDbzPc91qHtPLQYn6DGIRvsKSVJ2tUiyBgoz7Z4OtGCE4UfLIIODQqOEyfc3oWSZLD
         e1iw==
X-Gm-Message-State: AOAM5317tIyJDZpDZzStVao9dFrpTK/eekZQctxYFPqp2xXy/P2T6m2a
        h3dZgGhqeXMCAPxA8w7TPEwVWJR2sgi5r5p9jRbZs9TTb8E=
X-Google-Smtp-Source: ABdhPJyFqnF+Ogxitu/OrhWdhRsO1VqXmttPiASsD+q4g4YJYT/0Z0rSoam/t3G8AUNvh/yn6G1Q56Nm0jz5EVeE+i8=
X-Received: by 2002:a62:1cd6:0:b0:4c7:f6ae:2257 with SMTP id
 c205-20020a621cd6000000b004c7f6ae2257mr11240181pfc.59.1643085783915; Mon, 24
 Jan 2022 20:43:03 -0800 (PST)
MIME-Version: 1.0
References: <YeadK5ykhh7slnXL@debian.home> <CAADnVQ+SqfhWP_wG8N3d-LH_ZZKAbudTnmBbOhCV2f-nJax_BQ@mail.gmail.com>
 <CAGnuNNtC0y02d02dM-g1RC0DP4JmV+if+H=cz3UqbkDpse11uQ@mail.gmail.com>
 <CAADnVQ+afo+VPusoxOMQR+gY1v-+NrtZoVkTX+97b85uenX=sA@mail.gmail.com> <CAGnuNNsn9HOpTP9pB_0MbS812y4teJALDDBqRHgDBkSnPXwvmA@mail.gmail.com>
In-Reply-To: <CAGnuNNsn9HOpTP9pB_0MbS812y4teJALDDBqRHgDBkSnPXwvmA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 24 Jan 2022 20:42:52 -0800
Message-ID: <CAADnVQ+MPCmDnyWBP9rm_WDVrDqiTDYSej+ZfN_Z2K_TYYZKnA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Add bpf_copy_from_user_remote to read a
 process VM given its PID.
To:     Gabriele <phoenix1987@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 23, 2022 at 2:47 AM Gabriele <phoenix1987@gmail.com> wrote:
>
> On Fri, 21 Jan 2022 at 02:09, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > How would bpf prog know the pid of the python interpreter?
> > Then how would it know the pids of the threads?
> > I'm not against exposing find_get_task_by_vpid(), but
> > we need to understand the real usage first.
> > If we do end up exposing find_get_task_by_vpid(), it's probably
> > best to do via refcnt-ed kfunc approach (unstable helpers).
> > For example: https://lore.kernel.org/all/20220114163953.1455836-7-memxor@gmail.com/
>
> This is a simple but somewhat unrealistic example but hopefully it
> will give the idea. Suppose we are tracing sys_kill on entry and that
> we have an application that uses it to check if a process exists by
> sending the 0 signal to its PID. During the handling of this event, we
> might want to read a certain area of the VM (which we would have
> identified a priori from user-space) of the process identified by the
> PID passed to the syscall.

Fair enough. Pls prepare a patch to make find_get_task_by_vpid
into refcnted unstable helper for certain prog types.
Probably sleepable only.
