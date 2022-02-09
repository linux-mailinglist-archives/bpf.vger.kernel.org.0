Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF0934AEA45
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 07:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiBIGZF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 01:25:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235702AbiBIGWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 01:22:40 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF99E019D25
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 22:22:44 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id d187so2530022pfa.10
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 22:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9GmSDEQQMRjF3jkh1ngRjPH0qFcOiaYpSH1C/mQheVQ=;
        b=MUKInI+W44CttXmCA0eg5zdUMgTOWKqSEAZ1rjELfzQQzM/EY4cEtVwA03kHZbdleu
         5DnjeKPmFr+ONH5bSfTPy0Gacf4AFAFn6Sz5KwcvkjPbDYm7Nse1QiEyGzBJPzu4PWe2
         8kkLxvYI0f8irMuyc0b2Q2YPWY7QVMX475dLAI2WHt0yTJoPWIWBArM7UEj+Iu/Ws5nN
         ohIpYe4gI3prcYVracsY+10YEP5iG7s1ovg+XZROVDYMIW2JZDasLe/7P25u6Dr9LBqn
         C49kopmTT54zURIXXckIhiTYyVdyNURdAXne1KDD8k4FHTuz3f9qafmG7VrqZHwKoMcY
         exqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9GmSDEQQMRjF3jkh1ngRjPH0qFcOiaYpSH1C/mQheVQ=;
        b=YORq6PpF82nGOin80R3FKgnrxeEokWr9Fl9uqVYXKKbW3wtptwyKJS66tF4jr70hgx
         peE8/4rMSjyBZlINa8IKUGI9j4AoV7QArmBbB4J68zf+D6EXYPYQNn76inqkXVZ8ggk1
         iFxAGkI+i70/7oOfH3WBUVvQGTrEjYPUcMgNkPtQpjkgXDpdD5/cH9DoFUwEjBU7k6Mx
         TPWlpTR3dSXpMQ4tpL0t0SSVf3cuI6551gDMLQnTLR/xmtTnot23nHkT0+Yq693yOXFc
         EsGmIBuOU7CmyPsfM/OSdEu9qQU02kDPpULCTNYe6NEODa56eh+3iyO/GIhyLwckxCoD
         GypQ==
X-Gm-Message-State: AOAM532doXHKAJSRUagl62E7uU3NVMNmkCvTLjm7FKLx7uabPNlK4/3I
        ub2jo98mnA/F9d2GPnrH6Wy2nv/KBGk=
X-Google-Smtp-Source: ABdhPJwzVmCTz4ZDDBQtBBpfE1R3ZJR2n04sRd77cNVH+6C2lC5PzdMjZk2DcsiZ+R6eyk8pzD8L+Q==
X-Received: by 2002:a63:4e58:: with SMTP id o24mr747238pgl.374.1644387760899;
        Tue, 08 Feb 2022 22:22:40 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:1fb1:21a:3dae:742c])
        by smtp.gmail.com with ESMTPSA id b14sm18296892pfm.17.2022.02.08.22.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 22:22:40 -0800 (PST)
Date:   Wed, 9 Feb 2022 11:52:35 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     davem@davemloft.net, daniel@iogearbox.net, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v3 bpf-next 5/5] bpf: Convert bpf_preload.ko to use light
 skeleton.
Message-ID: <20220209062235.ddrxjpua2xshoryq@thp>
References: <20220209054315.73833-1-alexei.starovoitov@gmail.com>
 <20220209054315.73833-6-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209054315.73833-6-alexei.starovoitov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 09, 2022 at 11:13:15AM IST, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> The main change is a move of the single line
>   #include "iterators.lskel.h"
> from iterators/iterators.c to bpf_preload_kern.c.
> Which means that generated light skeleton can be used from user space or
> user mode driver like iterators.c or from the kernel module or the kernel itself.
> The direct use of light skeleton from the kernel module simplifies the code,
> since UMD is no longer necessary. The libbpf.a required user space and UMD. The
> CO-RE in the kernel and generated "loader bpf program" used by the light
> skeleton are capable to perform complex loading operations traditionally
> provided by libbpf. In addition UMD approach was launching UMD process
> every time bpffs has to be mounted. With light skeleton in the kernel
> the bpf_preload kernel module loads bpf iterators once and pins them
> multiple times into different bpffs mounts.
>
> Acked-by: Yonghong Song <yhs@fb.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/inode.c                            |  39 ++----
>  kernel/bpf/preload/Kconfig                    |   7 +-
>  kernel/bpf/preload/Makefile                   |  14 +--
>  kernel/bpf/preload/bpf_preload.h              |   8 +-
>  kernel/bpf/preload/bpf_preload_kern.c         | 119 ++++++++----------
>  kernel/bpf/preload/bpf_preload_umd_blob.S     |   7 --
>  .../preload/iterators/bpf_preload_common.h    |  13 --
>  kernel/bpf/preload/iterators/iterators.c      | 108 ----------------
>  kernel/bpf/syscall.c                          |   2 +
>  9 files changed, 70 insertions(+), 247 deletions(-)
>  delete mode 100644 kernel/bpf/preload/bpf_preload_umd_blob.S
>  delete mode 100644 kernel/bpf/preload/iterators/bpf_preload_common.h
>  delete mode 100644 kernel/bpf/preload/iterators/iterators.c
>
> [...]
>
> -static int __init load_umd(void)
> +static int __init load(void)
>  {
>  	int err;
>
> -	err = umd_load_blob(&umd_ops.info, &bpf_preload_umd_start,
> -			    &bpf_preload_umd_end - &bpf_preload_umd_start);
> +	err = load_skel();
>  	if (err)
>  		return err;
> -	bpf_preload_ops = &umd_ops;
> +	bpf_preload_ops = &ops;
>  	return err;
>  }
>
> -static void __exit fini_umd(void)
> +static void __exit fini(void)
>  {
> -	struct pid *tgid;
> -
>  	bpf_preload_ops = NULL;
> -
> -	/* kill UMD in case it's still there due to earlier error */
> -	tgid = umd_ops.info.tgid;
> -	if (tgid) {
> -		kill_pid(tgid, SIGKILL, 1);
> -
> -		wait_event(tgid->wait_pidfd, thread_group_exited(tgid));
> -		umd_cleanup_helper(&umd_ops.info);
> -	}
> -	umd_unload_blob(&umd_ops.info);
> +	free_links_and_skel();
>  }
> -late_initcall(load_umd);
> -module_exit(fini_umd);
> +late_initcall(load);

Since load_skel invokes the loader which resolve kfuncs, and if the module is
builtin, btf_vmlinux's kfunc_set_tab is not fully populated yet (other
register_btf_id_kfunc_set calls may also happen in late_initcall), so I think it
may be a problem.

When I worked on it we didn't have this case where BPF syscall can be invoked at
this point, but obviously that is true now. So I think ordering it later than
late_initcall (or moving register_btf_id_kfunc_set invoking initcalls before) is
required. WDYT?

> [...]

--
Kartikeya
