Return-Path: <bpf+bounces-72302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD948C0C7AB
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 09:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44C3134B9B9
	for <lists+bpf@lfdr.de>; Mon, 27 Oct 2025 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5170F30E0E9;
	Mon, 27 Oct 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwMTYGAW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384130E857
	for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554910; cv=none; b=jBUmOfFd9Xhg9Zj3yRl7WJkbHHS7EfZZrU5hDMBH61gcup/8fW9wsA9Yaz2T4GuQetWpeTDHc9iQ3QirMOOIEsu040xK/L27k/9ii2l+sRnzH4m7/hUVZCvimlDvONX2AhhOrIVcoKA0DbvHrXbibTvpnYwMN0BFteW5xzjEId4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554910; c=relaxed/simple;
	bh=PmYS6PWxr9X5njumKahKuZHCdaqOv/MkOKIGh/4DVSQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APhOUF6nV0LdNOpk4FzQMCMRo0oGskYpjgcCZ/F09bvI+PHpa1wKWn1azsIjPh2vwm6oO0Ebaq8SligJN+RMCXumxSmWvxcRWGwwMRdjC/ANTbIMHviY45mrkWwCY+5MawqEN3r4EF2+rhO/NTzBt82aPaodIBpD6YLAY5gFQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwMTYGAW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-471b80b994bso62311295e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 01:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761554907; x=1762159707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FHn4VCXJ8SziL5HVs3tOncztpHETMhRaig+hCm1znNA=;
        b=lwMTYGAWb99TokaCQqpwCaBPW/gX12s6MlcZNow0YudLP8bl/uTaOyjhFrwsZXsiaZ
         So7FIqDiFwJf0eF+Tre895PY+Ye0WT5iOeeyQ33RPLPCuzdigjV5ALXIDPvjiQLzi7tf
         afh2Qk8BdqAwF5DA1PECXgT/qLFruyDnYI/axfe0nrs5L08bien/BESoXdTA3Z+n2vKi
         zLPC/VhFQkiTk7uQxvuMfHd/qPLAGnxnZFIIUxKJiE3hi68uKeAB3TcHzgWwhk8DNXcQ
         GoL0W5yj2YQh/7Ctyu3gLrOtIul+2ZfMdXsfgbE/yFXY0xQYDZs53xCrj4HhfMASG/Xi
         5sFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761554907; x=1762159707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHn4VCXJ8SziL5HVs3tOncztpHETMhRaig+hCm1znNA=;
        b=UUiZyJToAOgUbSqDz1b5A45ORQd4pG1JHUNZrBRUg7lweCGXlpniRoPUQAzFMZR2qr
         DUzReNtmXs84WqYqDRWyzsASDXqKIlXtLPno5dWaqttibvuDK5DvOC2Xw/i5BR8+Lfg6
         pzZE7PkJtE+tOrHNjTqGkG30Qf7ggx6aIUAfIFovA8gC1nw50fSmb45iOiRPFeX98TQf
         g8t1hRdzqN+2J4PJ6PHJsc8AakTaJ5gTiPVebsIAX1i6QjoHJ5umY37UmG0OQY9pCTHT
         Goq1rO54ieKNE/4wDDnnwzZ1COHoX2jnodKgoKV7BclTMgppMkccVkap8AosI9V8ojDQ
         fE2Q==
X-Gm-Message-State: AOJu0YyQcpEwXtNBk9QJYizuXiGDhp24Zk7vWgi5VqctLUV+y0J3NbOK
	c5ov//BJGU8wJDvGhdv+8rpUbAipqlXzGXQVItEe8F3VloNwSA1fwuCf
X-Gm-Gg: ASbGncuXjHkKrthQzxrIJdXsWa7l2HgwOMQbDMMhm1mhDYQjFSxGYecs8i4Kwr8zpE1
	DFB4sg6DZ8C/D+ZaaJOJ1XSmjszrqKwcHisJgMIyvce4uI0wjM8KxSaAfSUNVqwahrcgXFUYfRr
	zvdcsgZODSWIB5nPN9VLr9c+uj0ghhMGVU/AtCiaptsg8a77mD85r2AuYQZpI8CNws8GxWctZMs
	ZhfOB0vLj018UZan+jGlWG6B7fZk4fCsBKtrEnPu3Gzx15cO4IoGyf2i1rKTzEdRsRU/0coeC22
	BPYAGlgRbGiW90r3Hvn5GyQ3XXJC/8VCtkubQgS7L53mNF9t7GRPpLJiMdRTYPXQrhXOBDaqm5E
	WA4kVBcB7VUb8i8wCVrjg2FjehZroYgaf3LM+4vzo5dABYZj0TQ==
X-Google-Smtp-Source: AGHT+IHGcNgsZtpIZ/JkOF1/9PEl8oxrEAXu3mnuSHi1k7QQS73tGtoaR+vym+DbF4opCAfLJwPmKw==
X-Received: by 2002:a05:600c:3548:b0:471:131f:85aa with SMTP id 5b1f17b1804b1-471178a74a2mr226893315e9.13.1761554907197;
        Mon, 27 Oct 2025 01:48:27 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbc16sm12690740f8f.15.2025.10.27.01.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 01:48:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Oct 2025 09:48:25 +0100
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	live-patching@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, rostedt@goodmis.org,
	andrey.grodzovsky@crowdstrike.com, mhiramat@kernel.org,
	kernel-team@meta.com, olsajiri@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3 bpf 1/3] ftrace: Fix BPF fexit with livepatch
Message-ID: <aP8x2VthUhZf4QVv@krava>
References: <20251026205445.1639632-1-song@kernel.org>
 <20251026205445.1639632-2-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026205445.1639632-2-song@kernel.org>

On Sun, Oct 26, 2025 at 01:54:43PM -0700, Song Liu wrote:
> When livepatch is attached to the same function as bpf trampoline with
> a fexit program, bpf trampoline code calls register_ftrace_direct()
> twice. The first time will fail with -EAGAIN, and the second time it
> will succeed. This requires register_ftrace_direct() to unregister
> the address on the first attempt. Otherwise, the bpf trampoline cannot
> attach. Here is an easy way to reproduce this issue:
> 
>   insmod samples/livepatch/livepatch-sample.ko
>   bpftrace -e 'fexit:cmdline_proc_show {}'
>   ERROR: Unable to attach probe: fexit:vmlinux:cmdline_proc_show...
> 
> Fix this by cleaning up the hash when register_ftrace_function_nolock hits
> errors.
> 
> Also, move the code that resets ops->func and ops->trampoline to
> the error path of register_ftrace_direct().
> 
> Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
> Cc: stable@vger.kernel.org # v6.6+
> Reported-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Closes: https://lore.kernel.org/live-patching/c5058315a39d4615b333e485893345be@crowdstrike.com/
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Acked-and-tested-by: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  kernel/bpf/trampoline.c | 5 -----
>  kernel/trace/ftrace.c   | 6 ++++++
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 5949095e51c3..f2cb0b097093 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -479,11 +479,6 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
>  		 * BPF_TRAMP_F_SHARE_IPMODIFY is set, we can generate the
>  		 * trampoline again, and retry register.
>  		 */
> -		/* reset fops->func and fops->trampoline for re-register */
> -		tr->fops->func = NULL;
> -		tr->fops->trampoline = 0;
> -
> -		/* free im memory and reallocate later */
>  		bpf_tramp_image_free(im);
>  		goto again;
>  	}
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..725c224fb4e6 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6048,6 +6048,12 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	ops->direct_call = addr;
>  
>  	err = register_ftrace_function_nolock(ops);
> +	if (err) {
> +		/* cleanup for possible another register call */
> +		ops->func = NULL;
> +		ops->trampoline = 0;

nit, we could cleanup also flags and direct_call just to be complete,
but at the same time it does not seem to affect anything

jirka


> +		remove_direct_functions_hash(hash, addr);
> +	}
>  
>   out_unlock:
>  	mutex_unlock(&direct_mutex);
> -- 
> 2.47.3
> 

