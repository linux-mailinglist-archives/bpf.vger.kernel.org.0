Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E764DA2D0
	for <lists+bpf@lfdr.de>; Tue, 15 Mar 2022 19:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbiCOTBB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Mar 2022 15:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343730AbiCOTBA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Mar 2022 15:01:00 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DF650E32;
        Tue, 15 Mar 2022 11:59:48 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id e3so255626pjm.5;
        Tue, 15 Mar 2022 11:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P75noemU3nNM9QREmpWEOIwo6AUAf43zc7dC9ZROgxU=;
        b=ieoeLFUClHFCNmE61XYmhfqH7JJ9Y6zrtBkhzQvZc/mecvz4an6xlpq4SFiDPrN3Ga
         Dnm9xmvDjgGJf2MJtScduCG7fQlWJ4eXHclFNRPyswzAyro8UryJAnQD+N06b+7BKqp/
         8WFC8eLzZiLB8dWerH2e40Zs6h+1UV7LfToNHVO9tGakihPBLG2vgOaoVfGtAa/5iegr
         kcp/jkm7hFDZ99GMAu3d3l2JE3HvS+nJwMrrAWu60POVVSE5ascgZjj8PYqbRB+koYw/
         furxvYiQ2zosuFLWXlANqaqK+rvAGE+868qVRctXNOykYG66OEBj8UPGibuqfJNU41q4
         6gxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P75noemU3nNM9QREmpWEOIwo6AUAf43zc7dC9ZROgxU=;
        b=4z3NUxGsrqGqxOpr+NeOJjJtlqOOFdLxHyRlOpKeGFsS6tazDIhY5/yWWf3f+GvUZw
         i2M+u4FFdy9Z+WxReN0Xu6c9pA9hRaQDZrFmjQoWrQc8HQSJnOkt/2Oqt+tF8WOpH6iO
         TAIsbZSwVZdIHxzjqoXknYMFgSRQ/YAEU3Jb7kDVehL5/Ksumo6e2dJOUAClKVcuBRVv
         2Ot2IK8V7xhDiF0Rdw7/kvjzoA7VW2cvVPTmYmJ/npW7iXO08+99N9HHP/KTvmtwUHyb
         TimWPZwDWEbigAqGKiYcI14UmZ2CQ8MHCcG7U46uwp9iLHx8GfGzvRoAN5iK2LybQNhD
         4tHQ==
X-Gm-Message-State: AOAM5331qVmPJMtfy22yh+LTJ1KN1EoeuLmVF8rbLaZ1fh6pHCEiWUrQ
        I9crjV/khUDwl+J/lqNQP4w6yx/x2ruJ1xG/9Ec=
X-Google-Smtp-Source: ABdhPJyqwD5pEKOAOgA9+l/w1ne5fuCUngwds7DQol2eaWRZcg4mrm9sqF19+ahu81x1RdeiECyWYI4RF/sdosJZFmE=
X-Received: by 2002:a17:903:32d2:b0:153:9c6a:5750 with SMTP id
 i18-20020a17090332d200b001539c6a5750mr4104519plr.34.1647370787936; Tue, 15
 Mar 2022 11:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk> <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
 <Yi/LaZ5id4ZjqFmL@zeniv-ca.linux.org.uk> <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
In-Reply-To: <CA+khW7jhD0+s9kivrd6PsNEaxmDCewhk_egrsxwdHPZNkubJYA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 15 Mar 2022 11:59:36 -0700
Message-ID: <CAADnVQJSMqcv3GPmUDcNKs23veqU-HWQQA5ECqdriMtjTpdv3w@mail.gmail.com>
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

On Tue, Mar 15, 2022 at 10:27 AM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Mar 14, 2022 at 4:12 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Mon, Mar 14, 2022 at 10:07:31AM -0700, Hao Luo wrote:
> > > Hello Al,
> >
> > > > In which contexts can those be called?
> > > >
> > >
> > > In a sleepable context. The plan is to introduce a certain tracepoints
> > > as sleepable, a program that attaches to sleepable tracepoints is
> > > allowed to call these functions. In particular, the first sleepable
> > > tracepoint introduced in this patchset is one at the end of
> > > cgroup_mkdir(). Do you have any advices?
> >
> > Yes - don't do it, unless you really want a lot of user-triggerable
> > deadlocks.
> >
> > Pathname resolution is not locking-agnostic.  In particular, you can't
> > do it if you are under any ->i_rwsem, whether it's shared or exclusive.
> > That includes cgroup_mkdir() callchains.  And if the pathname passed
> > to these functions will have you walk through the parent directory,
> > you would get screwed (e.g. if the next component happens to be
> > inexistent, triggering a lookup, which takes ->i_rwsem shared).
>
> I'm thinking of two options, let's see if either can work out:
>
> Option 1: We can put restrictions on the pathname passed into this
> helper. We can explicitly require the parameter dirfd to be in bpffs
> (we can verify). In addition, we check pathname to be not containing
> any dot or dotdot, so the resolved path will end up inside bpffs,
> therefore won't take ->i_rwsem that is in the callchain of
> cgroup_mkdir().
>
> Option 2: We can avoid pathname resolution entirely. Like above, we
> can adjust the semantics of this helper to be: making an immediate
> directory under the dirfd passed in. In particular, like above, we can
> enforce the dirfd to be in bpffs and pathname to consist of only
> alphabet and numbers. With these restrictions, we call vfs_mkdir() to
> create directories.
>
> Being able to mkdir from bpf has useful use cases, let's try to make
> it happen even with many limitations.

Option 3. delegate vfs_mkdir to a worker and wait in the helper.
