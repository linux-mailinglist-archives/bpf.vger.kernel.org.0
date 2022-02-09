Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AA754AEA51
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 07:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiBIGaP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 01:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbiBIG1e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 01:27:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE560E03B53F
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 22:27:29 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id r64-20020a17090a43c600b001b8854e682eso1363911pjg.0
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 22:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FyOJZPaqRLQmw/cjS+5PTOMbS04bOnmkwWmvCsTHRLA=;
        b=hXhVkot5ki/bdghN1CF8WlWHQYqBDPXirLTxWg1Dxdvu+9jwlHmb8hCcubiVcJx/7p
         889ndL138r1UIhkLcL9/m0zKOFBbC/c6LYnOJH/uaOOK9n+ohsFldPzNK+Q45xgNPZVM
         xUljqOMgwuzwkI4maWJos71bL43XqVDLQYKQLbpYiWDLvSJaqernHJBG+ReAhnti6uWG
         MvmUxQebkTm2LOrBGsPT0wzBIntpw8siMQrwA8y5ofvj98yUo6ZHOIzV2D9n2whFDPft
         c7HtHexC3t5QofV4uK4DekQ1cmThC1zM1QSQyAiFSvoCQkmfqA8DIvfZx7rXaAI/wfyC
         xLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FyOJZPaqRLQmw/cjS+5PTOMbS04bOnmkwWmvCsTHRLA=;
        b=p/5gpP026brLI+iKkgPCwbrv0a1nJYzm6GfkdX27xAtxvymLrGOehiTxpi3Rw5M8g+
         oKi3ntB9xKovlDoISPLtbsszpGiwD8WDb9iLyhrEhXh6mSxA9JrxDiYVsKrNvXhzOkFB
         ouNzqFoBjx+OJd2RriDNwQQDS5vnLmI8wYqWFAxg0nQm9Jsu5rPJZpl2aMwuJQBwfkSR
         8YG/pAqc2LPg45qezacNLAqJb94bPpt6TXOu+rOZu09LF/e8ASE7uroAWmunPJrDXszZ
         KunLqPFmKN57xbtrz/FGsj5sn6Lt1DjaEclIg5q9qaUsNsFLvlmEavax2bvZzzDU1uRN
         o2zw==
X-Gm-Message-State: AOAM5314zWoiIFDjOBR5QyGiR3DJX3zUNe9U2qnaqugDmkAlzyhj9YZv
        g5ix2MEdVyCXDdrb01vyx4M=
X-Google-Smtp-Source: ABdhPJwxS0oouxSHAGbgzJjh80zDpo1H5gbzLdCA4+0MrkUNuOGkDN4SeqvB8YZyA8KV0OIrm5ARpQ==
X-Received: by 2002:a17:902:b68b:: with SMTP id c11mr802891pls.116.1644388049196;
        Tue, 08 Feb 2022 22:27:29 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id y5sm2718987pfw.165.2022.02.08.22.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:27:28 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:57:26 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Message-ID: <20220209062726.sp3cbxpqv6fx3eoe@apollo.legion>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-6-alexei.starovoitov@gmail.com>
 <20220209062235.ddrxjpua2xshoryq@thp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209062235.ddrxjpua2xshoryq@thp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 09, 2022 at 11:52:35AM IST, Kumar Kartikeya Dwivedi wrote:
> On Wed, Feb 09, 2022 at 11:13:15AM IST, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The main change is a move of the single line
> >   #include "iterators.lskel.h"
> > from iterators/iterators.c to bpf_preload_kern.c.
> > Which means that generated light skeleton can be used from user space or
> > user mode driver like iterators.c or from the kernel module or the kernel itself.
> > The direct use of light skeleton from the kernel module simplifies the code,
> > since UMD is no longer necessary. The libbpf.a required user space and UMD. The
> > CO-RE in the kernel and generated "loader bpf program" used by the light
> > skeleton are capable to perform complex loading operations traditionally
> > provided by libbpf. In addition UMD approach was launching UMD process
> > every time bpffs has to be mounted. With light skeleton in the kernel
> > the bpf_preload kernel module loads bpf iterators once and pins them
> > multiple times into different bpffs mounts.
> >
> > Acked-by: Yonghong Song <yhs@fb.com>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/inode.c                            |  39 ++----
> >  kernel/bpf/preload/Kconfig                    |   7 +-
> >  kernel/bpf/preload/Makefile                   |  14 +--
> >  kernel/bpf/preload/bpf_preload.h              |   8 +-
> >  kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
> >  kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
> >  .../preload/iterators/bpf_preload_common.h    |  13 --
> >  kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
> >  kernel/bpf/syscall.c                          |   2 +
> >  9 files changed, 70 insertions(+), 247 deletions(-)
> >  delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
> >  delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
> >  delete mode 100644 kernel/bpf/preload/iterators/iterators.c
> >
> > [...]
> >
> > -static int __init load_umd(void)
> > +static int __init load(void)
> >  {
> >  	int err;
> >
> > -	err = umd_load_blob(&umd_ops.info, &bpf_preload_umd_start,
> > -			    &bpf_preload_umd_end - &bpf_preload_umd_start);
> > +	err = load_skel();
> >  	if (err)
> >  		return err;
> > -	bpf_preload_ops = &umd_ops;
> > +	bpf_preload_ops = &ops;
> >  	return err;
> >  }
> >
> > -static void __exit fini_umd(void)
> > +static void __exit fini(void)
> >  {
> > -	struct pid *tgid;
> > -
> >  	bpf_preload_ops = NULL;
> > -
> > -	/* kill UMD in case it's still there due to earlier error */
> > -	tgid = umd_ops.info.tgid;
> > -	if (tgid) {
> > -		kill_pid(tgid, SIGKILL, 1);
> > -
> > -		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> > -		umd_cleanup_helper(&umd_ops.info);
> > -	}
> > -	umd_unload_blob(&umd_ops.info);
> > +	free_links_and_skel();
> >  }
> > -late_initcall(load_umd);
> > -module_exit(fini_umd);
> > +late_initcall(load);
>
> Since load_skel invokes the loader which resolve kfuncs, and if the module is
> builtin, btf_vmlinux's kfunc_set_tab is not fully populated yet (other
> register_btf_id_kfunc_set calls may also happen in late_initcall), so I think it
> may be a problem.
>
> When I worked on it we didn't have this case where BPF syscall can be invoked at
> this point, but obviously that is true now. So I think ordering it later than
> late_initcall (or moving register_btf_id_kfunc_set invoking initcalls before) is
> required. WDYT?
>

To be more clear, I know this series is not using kfuncs anywhere, but this is
probably the right time to fix it, while we are changing the assumptions.

> > [...]
>
> --
> Kartikeya

--
Kartikeya
