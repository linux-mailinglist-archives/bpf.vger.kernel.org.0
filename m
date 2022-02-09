Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634264AFDFD
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 21:05:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiBIUFw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 15:05:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiBIUFt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 15:05:49 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533D8E0536CD
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 12:05:46 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id on2so3111963pjb.4
        for <bpf@vger.kernel.org>; Wed, 09 Feb 2022 12:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SSV+JDnPodBI99sJ6DzBVZxzHgbnyx6G98xAxDPVFOs=;
        b=baRjyJ7fOmhsPgmUEYISwgTD9Wu4t6A+9iX2Z9XHrkqc9SmBRWfHVwWSUjvNDEhFjB
         cMGbUqtTHy4sXSRWBb46XszTwkuqw1PusBbqwxl/vQIeIq9ZY18K6noVic1x6Bam/iMh
         2SpR1WEBnE2nW289bw/D/0jQ2p5JAaADlGhpa7bOljcrgiMTpyWHfbl5IB8EUO3hUuR8
         I3wiRjBo8BNqnx+PQ2UDoZ7BHuHcAwhTt1FdGqlTaKjokx8n7ZxF6rfvAwX09lVqCcB/
         jxNfsQNsAQvXtoTGtpQAefn6aex6rvBFRFYqcoEfRw2dnASlrn+NW5MVKeHHa1JUOgAN
         bAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SSV+JDnPodBI99sJ6DzBVZxzHgbnyx6G98xAxDPVFOs=;
        b=xXQ/7CqUNwllXUj/n/HCD3j5iD0oe25D/slJXXpABD8GHrN368xcv43zCifupchILh
         zOolupYgbyhilh4m3v9jZon9ynMvD8+X2JSA3g2zM+cgBHha4H9PWeKhavOCc0RZfYdV
         wUCImAb/MVDOR5gY4OiaC02Wxqz9nIX3EQRPO5Erc74c0dYxW7U4MuYikEQd31V6Ykbp
         838FTq1RVKVn7yR+ntu3wJIQlghTjH7ZrFhdJiSF7+6lo+Ho/eV7prYg6BDQI9dLMycV
         7JNVNbMBTPZghdDPwntqdFvZTMVQDVsVG0NYmq+jGsNhmFIrR/9q7U2Sh/6yZHGTFEtP
         l+EA==
X-Gm-Message-State: AOAM532RR55G1TuDftFoslIOXmaIHw3Hea0SNcFhpOEd5T7fjeMzHTv9
        gbH6dEqLfOFJ8MUCxDGftWNX3jpUOPK2ow==
X-Google-Smtp-Source: ABdhPJyKBUu7G8EP4YyxIMZ4edG7RiaSGjxUP8B7mKPAlRCJJE2yUFvE6M2eHlAGSweESgeNUCppag==
X-Received: by 2002:a17:90a:d58b:: with SMTP id v11mr5343058pju.100.1644437145629;
        Wed, 09 Feb 2022 12:05:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id h4sm20533235pfv.166.2022.02.09.12.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 12:05:45 -0800 (PST)
Date:   Thu, 10 Feb 2022 01:35:42 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Message-ID: <20220209200542.u6zdxqn3mvgjurjj@apollo.legion>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-6-alexei.starovoitov@gmail.com>
 <20220209062235.ddrxjpua2xshoryq@thp>
 <CAADnVQK_YDBtDtgTchDFYJmZVPjH6u_+=Cw__5tFtZxfKEOkEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQK_YDBtDtgTchDFYJmZVPjH6u_+=Cw__5tFtZxfKEOkEw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 09, 2022 at 10:04:18PM IST, Alexei Starovoitov wrote:
> On Tue, Feb 8, 2022 at 10:22 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Wed, Feb 09, 2022 at 11:13:15AM IST, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > The main change is a move of the single line
> > >   #include "iterators.lskel.h"
> > > from iterators/iterators.c to bpf_preload_kern.c.
> > > Which means that generated light skeleton can be used from user space or
> > > user mode driver like iterators.c or from the kernel module or the kernel itself.
> > > The direct use of light skeleton from the kernel module simplifies the code,
> > > since UMD is no longer necessary. The libbpf.a required user space and UMD. The
> > > CO-RE in the kernel and generated "loader bpf program" used by the light
> > > skeleton are capable to perform complex loading operations traditionally
> > > provided by libbpf. In addition UMD approach was launching UMD process
> > > every time bpffs has to be mounted. With light skeleton in the kernel
> > > the bpf_preload kernel module loads bpf iterators once and pins them
> > > multiple times into different bpffs mounts.
> > >
> > > Acked-by: Yonghong Song <yhs@fb.com>
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > > ---
> > >  kernel/bpf/inode.c                            |  39 ++----
> > >  kernel/bpf/preload/Kconfig                    |   7 +-
> > >  kernel/bpf/preload/Makefile                   |  14 +--
> > >  kernel/bpf/preload/bpf_preload.h              |   8 +-
> > >  kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
> > >  kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
> > >  .../preload/iterators/bpf_preload_common.h    |  13 --
> > >  kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
> > >  kernel/bpf/syscall.c                          |   2 +
> > >  9 files changed, 70 insertions(+), 247 deletions(-)
> > >  delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
> > >  delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
> > >  delete mode 100644 kernel/bpf/preload/iterators/iterators.c
> > >
> > > [...]
> > >
> > > -static int __init load_umd(void)
> > > +static int __init load(void)
> > >  {
> > >       int err;
> > >
> > > -     err = umd_load_blob(&umd_ops.info, &bpf_preload_umd_start,
> > > -                         &bpf_preload_umd_end - &bpf_preload_umd_start);
> > > +     err = load_skel();
> > >       if (err)
> > >               return err;
> > > -     bpf_preload_ops = &umd_ops;
> > > +     bpf_preload_ops = &ops;
> > >       return err;
> > >  }
> > >
> > > -static void __exit fini_umd(void)
> > > +static void __exit fini(void)
> > >  {
> > > -     struct pid *tgid;
> > > -
> > >       bpf_preload_ops = NULL;
> > > -
> > > -     /* kill UMD in case it's still there due to earlier error */
> > > -     tgid = umd_ops.info.tgid;
> > > -     if (tgid) {
> > > -             kill_pid(tgid, SIGKILL, 1);
> > > -
> > > -             wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> > > -             umd_cleanup_helper(&umd_ops.info);
> > > -     }
> > > -     umd_unload_blob(&umd_ops.info);
> > > +     free_links_and_skel();
> > >  }
> > > -late_initcall(load_umd);
> > > -module_exit(fini_umd);
> > > +late_initcall(load);
> >
> > Since load_skel invokes the loader which resolve kfuncs, and if the module is
> > builtin, btf_vmlinux's kfunc_set_tab is not fully populated yet (other
> > register_btf_id_kfunc_set calls may also happen in late_initcall), so I think it
> > may be a problem.
> >
> > When I worked on it we didn't have this case where BPF syscall can be invoked at
> > this point, but obviously that is true now. So I think ordering it later than
> > late_initcall (or moving register_btf_id_kfunc_set invoking initcalls before) is
> > required. WDYT?
>
> Good point. Probably best to convert register_btf_kfunc_id_set invocations
> to core_initcall.
> I can follow up with a trivial patch later or you can beat me to it.

Cool, I'll post it after this is merged.

--
Kartikeya
