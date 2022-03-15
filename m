Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298024DA2FA
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 20:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351297AbiCOTGO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351391AbiCOTEv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:51 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027ACB7F;
        Tue, 15 Mar 2022 12:03:15 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id s11so407327pfu.13;
        Tue, 15 Mar 2022 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZaAUf36wy+zyCzd7ZqoHqZ/0IIkM1TVPdclUXF4mkE=;
        b=RZGSwuYdBhGEZZlHlV7YGxZr5LLFVv4d1VaWOFpmrU7S0PTZrePuyM8iHU9Aw3ttCi
         1feExChqyT5dno+xcN81w1Kx2u9R93ev0QwX5z5PWTF973Os48vOXKUIeRvZT2k7K9Q4
         E+mZPy+M4eloI/g7aE08NffB5sdpanQXZXjbUtMHlBEBCFO4P/EqIETQhCAPpRa3yOky
         Mh3Y2bbVusXtA2BzLCY+tDc667d2tO94H9IyRSCMn6L/S9DkHYnvWzwYiaBUjiJiPum6
         YK02sFABucji2xmF+sH9inGtkQar2HeO5DVsxPzvgMLTIRajJShjCTPOcYcsFFIHblTx
         8mJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZaAUf36wy+zyCzd7ZqoHqZ/0IIkM1TVPdclUXF4mkE=;
        b=XtslDMXCcMCVRwdD/CymBG/klyZhnAgVC0Dm7cSCUPno48b2CdMd1qCDKIQJluAlCK
         TrydRcHiCsoZVXWcPUukA70jXoqAI3hStDPV8sgqNmxQIS9s8DN/Vhius1W/VBA6hOKn
         u9OW1COFzFolMfBlWc1I8w7K8rF7iBBOfGnlK4ZsRtufTxIs7hSm8NWb9wU5rFdbmEfC
         NhB5LHUMLvLjb7sg/4aKyVE5oNzlAMbHb8NWw/eAgmwF0ViQdcwPUm+TZ39lKcTnq7UT
         JfJZBUpDcm8VB23U84c/VsXLarGh+dZboVBmACc2Pbx8C2EA7jxc8guaYQuPpDZzh3oh
         0/sA==
X-Gm-Message-State: AOAM530G0sOibiUvxebv+ciEa6iPNeQou2o/ZTi3p4ADfJQyXpHI1jqJ
        qrD+01ZbGzXICc/7p5XR2BlTNCYP1DcO0bqo7XwZ/CvT
X-Google-Smtp-Source: ABdhPJxHGrdaXBmC/R8i51YwFlI9MFHPTpkJ3bWLJpxYfVIWuUNnyq58BY8R5uiEbHbWwdaehWkSoMFBhmDf9Z9gtf4=
X-Received: by 2002:aa7:805a:0:b0:4f6:dc68:5d41 with SMTP id
 y26-20020aa7805a000000b004f6dc685d41mr29924894pfm.69.1647370995298; Tue, 15
 Mar 2022 12:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk> <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk> <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
 <CAADnVQJSMqcv3GPmUDcNKs23veqU-HWQQA5ECqdriMtjTpdv3w@mail.gmail.com>
In-Reply-To: <CAADnVQJSMqcv3GPmUDcNKs23veqU-HWQQA5ECqdriMtjTpdv3w@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Mar 2022 12:03:04 -0700
Message-ID: <CAADnVQKttOMcfYdnCVtEm1HVYUf8ed-jMoTkeu1XgGMzW342Ww@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Hao Luo <haoluo@google.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 11:59 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 10:27 AM Hao Luo <haoluo@google.com> wrote:
> >
> > On Mon, Mar 14, 2022 at 4:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > On Mon, Mar 14, 2022 at 10:07:31AM -0700, Hao Luo wrote:
> > > > Hello Al,
> > >
> > > > > In which contexts can those be called?
> > > > >
> > > >
> > > > In a sleepable context. The plan is to introduce a certain tracepoints
> > > > as sleepable, a program that attaches to sleepable tracepoints is
> > > > allowed to call these functions. In particular, the first sleepable
> > > > tracepoint introduced in this patchset is one at the end of
> > > > cgroup_mkdir(). Do you have any advices?
> > >
> > > Yes - don't do it, unless you really want a lot of user-triggerable
> > > deadlocks.
> > >
> > > Pathname resolution is not locking-agnostic.  In particular, you can't
> > > do it if you are under any ->i_rwsem, whether it's shared or exclusive.
> > > That includes cgroup_mkdir() callchains.  And if the pathname passed
> > > to these functions will have you walk through the parent directory,
> > > you would get screwed (e.g. if the next component happens to be
> > > inexistent, triggering a lookup, which takes ->i_rwsem shared).
> >
> > I'm thinking of two options, let's see if either can work out:
> >
> > Option 1: We can put restrictions on the pathname passed into this
> > helper. We can explicitly require the parameter dirfd to be in bpffs
> > (we can verify). In addition, we check pathname to be not containing
> > any dot or dotdot, so the resolved path will end up inside bpffs,
> > therefore won't take ->i_rwsem that is in the callchain of
> > cgroup_mkdir().
> >
> > Option 2: We can avoid pathname resolution entirely. Like above, we
> > can adjust the semantics of this helper to be: making an immediate
> > directory under the dirfd passed in. In particular, like above, we can
> > enforce the dirfd to be in bpffs and pathname to consist of only
> > alphabet and numbers. With these restrictions, we call vfs_mkdir() to
> > create directories.
> >
> > Being able to mkdir from bpf has useful use cases, let's try to make
> > it happen even with many limitations.
>
> Option 3. delegate vfs_mkdir to a worker and wait in the helper.

I meant _dont_ wait, of course.
