Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0B84CC570
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235807AbiCCSvs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 13:51:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235726AbiCCSvr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 13:51:47 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744B019CCE5
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 10:51:01 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id b20so4634914qkn.9
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 10:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OmjzlX5jm7yAuQTwyoKeVgQEjRjg2Q+W3Y3CU0H5AZg=;
        b=ZvDjpQdk9BXTHFp/78l5h3k+//+41UyrWKaq7UFUkhveBR6xXXLaAUtWbXpJ4cM901
         IXl7QhBOAOoYm4S37JOXlHDAWhZdLZ3IJ/61XuDz0GRk/esJ4b5hRfmG2EoHyZbqlf/a
         Xgt4lBtTvI29xbon6PwZR5C4Whu3qOqwizVa6Tc1mr+DO5lG0FeVNliXD1JfkNAS8m9h
         VwuwpCFyVsGFRDiHc0rEMg7lQ938xOmLImR3R5RdHt5c8+1FpZ9Bn9id4rqiDxvuMse3
         7K6u78+zVfPRR+/MA7WoCzFpZ24D8pN1LPu8CshTEs7TYsbHFAV15E+l6SoX68zAMOcG
         kHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OmjzlX5jm7yAuQTwyoKeVgQEjRjg2Q+W3Y3CU0H5AZg=;
        b=TuwQlDyymyDGXomYRC/T1/dX7C3ZEd95Pa4P4Q2YjMfEuHqabGmaPjb59SnVT5qGcY
         n+Gb4JA/4iF2NRU4jE5GkAjJS33EXUL15cRhoGDkNtPv1xiJMTGBppmAjYAUusoUlF0H
         AnqdHryDVigeJOLAyaxrDNAVDqZPweKeQTqxXR9Vhq4RERjuWf9FKFo2j/6cv8ISFLkK
         P6i8hUlyVjfDui8y2chbrlvVAJCocr6S4w4KpuFjGP+2KVTfPLr9zLfdHbuL7N9218AJ
         l2sOO3BT75uM7RIp/QA8WDy4htS3Xo2LOHiPkjnHitwtbrgou8GReAERNVDO8tllXjlt
         Vxxg==
X-Gm-Message-State: AOAM5332l/Fmt4IC2HqasApH4C9WMHG39oDOat7kPJ/2wSlm/UGmni6G
        UTuBXOaGXfFS9SzSRZf2DEX5toA9gS26hdQm8/AjEg==
X-Google-Smtp-Source: ABdhPJxv5RvZfHXJjc4SavJZrs+AssKFtwAuXCIHtahDXfbZsSc+T7czxtBY5EfU8AzIXNt6KfhXIeFJmnwH0o1purk=
X-Received: by 2002:ae9:c10c:0:b0:663:2047:2eed with SMTP id
 z12-20020ae9c10c000000b0066320472eedmr362812qki.221.1646333460306; Thu, 03
 Mar 2022 10:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion> <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
 <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 10:50:48 -0800
Message-ID: <CA+khW7goNwmt2xJb8SMaagXcsZdquQha8kax-LF033wFexKCcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 2, 2022 at 11:34 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Feb 28, 2022 at 02:10:39PM -0800, Hao Luo wrote:
> > Hi Kumar,
> >
> > On Sat, Feb 26, 2022 at 9:18 PM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Sat, Feb 26, 2022 at 05:13:31AM IST, Hao Luo wrote:
> > > > This patch allows bpf_syscall prog to perform some basic filesystem
> > > > operations: create, remove directories and unlink files. Three bpf
> > > > helpers are added for this purpose. When combined with the following
> > > > patches that allow pinning and getting bpf objects from bpf prog,
> > > > this feature can be used to create directory hierarchy in bpffs that
> > > > help manage bpf objects purely using bpf progs.
> > > >
> > > > The added helpers subject to the same permission checks as their syscall
> > > > version. For example, one can not write to a read-only file system;
> > > > The identity of the current process is checked to see whether it has
> > > > sufficient permission to perform the operations.
> > > >
> > > > Only directories and files in bpffs can be created or removed by these
> > > > helpers. But it won't be too hard to allow these helpers to operate
> > > > on files in other filesystems, if we want.
> > > >
> > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > ---
> > > > + *
> > > > + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> > > > + *   Description
> > > > + *           Attempts to create a directory name *pathname*. The argument
> > > > + *           *pathname_sz* specifies the length of the string *pathname*.
> > > > + *           The argument *mode* specifies the mode for the new directory. It
> > > > + *           is modified by the process's umask. It has the same semantic as
> > > > + *           the syscall mkdir(2).
> > > > + *   Return
> > > > + *           0 on success, or a negative error in case of failure.
> > > > + *
> > > > + * long bpf_rmdir(const char *pathname, int pathname_sz)
> > > > + *   Description
> > > > + *           Deletes a directory, which must be empty.
> > > > + *   Return
> > > > + *           0 on sucess, or a negative error in case of failure.
> > > > + *
> > > > + * long bpf_unlink(const char *pathname, int pathname_sz)
> > > > + *   Description
> > > > + *           Deletes a name and possibly the file it refers to. It has the
> > > > + *           same semantic as the syscall unlink(2).
> > > > + *   Return
> > > > + *           0 on success, or a negative error in case of failure.
> > > >   */
> > > >
> > >
> > > How about only introducing bpf_sys_mkdirat and bpf_sys_unlinkat? That would be
> > > more useful for other cases in future, and when AT_FDCWD is passed, has the same
> > > functionality as these, but when openat/fget is supported, it would work
> > > relative to other dirfds as well. It can also allow using dirfd of the process
> > > calling read for a iterator (e.g. if it sets the fd number using skel->bss).
> > > unlinkat's AT_REMOVEDIR flag also removes the need for a bpf_rmdir.
> > >
> > > WDYT?
> > >
> >
> > The idea sounds good to me, more flexible. But I don't have a real use
> > case for using the added 'dirfd' at this moment. For all the use cases
> > I can think of, absolute paths will suffice, I think. Unless other
> > reviewers have opposition, I will try switching to mkdirat and
> > unlinkat in v2.
>
> I'm surprised you don't need "at" variants.
> I thought your production setup has a top level cgroup controller and
> then inner tasks inside containers manage cgroups on their own.
> Since containers are involved they likely run inside their own mountns.
> cgroupfs mount is single. So you probably don't even need to bind mount it
> inside containers, but bpffs is not a single mount. You need
> to bind mount top bpffs inside containers for tasks to access it.
> Now for cgroupfs the abs path is not an issue, but for bpffs
> the AT_FDCWD becomes a problem. AT_FDCWD is using current mount ns.
> Inside container that will be different. Unless you bind mount into exact
> same path the full path has different meanings inside and outside of the container.
> It seems to me the bpf progs attached to cgroup sleepable events should
> be using FD of bpffs. Then when these tracepoints are triggered from
> different containers in different mountns they will get the right dir prefix.
> What am I missing?
>

Alexei, you are perfectly right. To be honest, I failed to see the
fact that the sleepable tp prog is in the container's mount ns. I
think we can bind mount the top bpffs into exactly the same path
inside container, right? But I haven't tested this idea. Passing FDs
should be better.

> I think non-AT variants are not needed. The prog can always pass AT_FDCWD
> if it's really the intent, but passing actual FD seems more error-proof.

Let's have the AT version. Passing FD seems the right approach, when
we use it in the context of container.
