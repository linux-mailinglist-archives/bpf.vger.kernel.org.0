Return-Path: <bpf+bounces-15756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D5F7F615E
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 15:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D41C7281756
	for <lists+bpf@lfdr.de>; Thu, 23 Nov 2023 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D832FC49;
	Thu, 23 Nov 2023 14:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi1RObOe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8371BE
	for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 06:25:37 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-548d4fc9579so1798143a12.1
        for <bpf@vger.kernel.org>; Thu, 23 Nov 2023 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700749536; x=1701354336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zQyIJbYP7XKIa6MiV4DV+jqi5a2hpLOMpb8HxGWl3VQ=;
        b=Qi1RObOeLlvtwJVgXU2Qv7apRtuyTntSPTGgIyNtIYTH8iH8SQ1uYJlp2WQZYDpvAt
         7mpE0HykKC7eLQTAOTDg4ItL2hsMv9FFfO+rKpjZpympELKI+vc78LuQtU9hzTaBHck+
         cvt+UDC1nisnXQC69TabotykcLg7YTrY7FjqGAKu0DfynMALhpwxcRxc0Q2sDLB2wddi
         P+D9S1fWQJGmSHsk+RZxT1dKY7sKTCaYP0YMtfttSMs2uFcMmtzqI7Ovux5CJ4rWfyHK
         tgDAHF03Ys0TRiZa5NEn4BFfVs6tzIZsOX1NLem9ZWj5kafYAqXyTC74A7pAsPzlYKQF
         TwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700749536; x=1701354336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQyIJbYP7XKIa6MiV4DV+jqi5a2hpLOMpb8HxGWl3VQ=;
        b=gjcDjFN2HnbQyvwUcr+SjsTJhDdcERjbP+dGW4t5RJU1NsO90RzaCl4IGzyPODUuBA
         /ZEKiGO/VFnodGB7oYbBbRUcO7yvZdl4RZQ5FYgGMaNcI1Hh3jbVR08jlOjZwQpuKEi5
         bLGIqykMBwAdpTG39DrCVqCIcafDVk9i+n6/E8BfSJ/0v2gM7ekuWEmDlG7KOWeI/ksj
         aw9ahwRgYQ9Ndpm5xd3ru72YNYRMLIwSEIFeB2ZG4NskWK9hY+79c2gDE9pRtKcEaSU4
         iKKX3qcPu9ZaXQy6NOUV707F9LFAT3OW5ndPramddVyrlp+/5o8wwKlCkK9BSfG7AwW/
         ieMg==
X-Gm-Message-State: AOJu0YyIiD2M8IYgW8Znrv5Nr1hrUHid+2OkzC/iY+70plITiHbCBKLv
	YfJrJP1qcLch352BvmVVnt4=
X-Google-Smtp-Source: AGHT+IHpCS+Sm/Cz9VGE2oYH48JFpmtnBloyL3F9Dj4rAjnNs0Vs1eS3CE5A7LKJuQr0oCvGxERO0A==
X-Received: by 2002:aa7:c655:0:b0:548:e132:ca7b with SMTP id z21-20020aa7c655000000b00548e132ca7bmr2610699edr.17.1700749535682;
        Thu, 23 Nov 2023 06:25:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7c752000000b005488a15b25asm703841eds.70.2023.11.23.06.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 06:25:35 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 23 Nov 2023 15:25:33 +0100
To: Dmitrii Dolgov <9erthalion6@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, dan.carpenter@linaro.org
Subject: Re: [RFC PATCH bpf-next v2] bpf: Relax tracing prog recursive attach
 rules
Message-ID: <ZV9g3ZJQrwhSw-kQ@krava>
References: <20231122191816.5572-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122191816.5572-1-9erthalion6@gmail.com>

On Wed, Nov 22, 2023 at 08:18:09PM +0100, Dmitrii Dolgov wrote:
> Currently, it's not allowed to attach an fentry/fexit prog to another
> one of the same type. At the same time it's not uncommon to see a
> tracing program with lots of logic in use, and the attachment limitation
> prevents usage of fentry/fexit for performance analysis (e.g. with
> "bpftool prog profile" command) in this case. An example could be
> falcosecurity libs project that uses tp_btf tracing programs.
> 
> Following the corresponding discussion [1], the reason for that is to
> avoid tracing progs call cycles without introducing more complex
> solutions. Relax "no same type" requirement to "no progs that are
> already an attach target themselves" for the tracing type. In this way
> only a standalone tracing program (without any other progs attached to
> it) could be attached to another one, and no cycle could be formed. To
> implement, add a new field into bpf_prog_aux to track the fact of
> attachment in the target prog.
> 
> As a side effect of this change alone, one could create an unbounded
> chain of tracing progs attached to each other. Similar issues between
> fentry/fexit and extend progs are addressed via forbidding certain
> combinations that could lead to similar chains. Introduce an
> attach_depth field to limit the attachment chain, and display it in
> bpftool.
> 
> [1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Previous discussion: https://lore.kernel.org/bpf/20231114084118.11095-1-9erthalion6@gmail.com/
> 
> Changes in v2:
>     - Verify tgt_prog is not null
>     - Replace boolean followed with number of followers, to handle
>       multiple progs attaching/detaching
> 
>  include/linux/bpf.h            |  2 ++
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 12 +++++++++++-
>  kernel/bpf/verifier.c          | 19 ++++++++++++++++---
>  tools/bpf/bpftool/prog.c       |  2 ++
>  tools/include/uapi/linux/bpf.h |  1 +
>  6 files changed, 33 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4001d11be151..1b890f65ac39 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1394,6 +1394,8 @@ struct bpf_prog_aux {
>  	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
>  	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
>  	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
> +	u32 attach_depth; /* position of the prog in the attachment chain */
> +	u32 follower_cnt; /* number of programs attached to it */
>  	u32 ctx_arg_info_size;
>  	u32 max_rdonly_access;
>  	u32 max_rdwr_access;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 7cf8bcf9f6a2..aa6614547ef6 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6465,6 +6465,7 @@ struct bpf_prog_info {
>  	__u32 verified_insns;
>  	__u32 attach_btf_obj_id;
>  	__u32 attach_btf_id;
> +	__u32 attach_depth;
>  } __attribute__((aligned(8)));
>  
>  struct bpf_map_info {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 0ed286b8a0f0..1809595958ef 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3038,9 +3038,12 @@ static void bpf_tracing_link_release(struct bpf_link *link)
>  
>  	bpf_trampoline_put(tr_link->trampoline);
>  
> +	link->prog->aux->attach_depth--;

should we just set it to 0 ? the number is assigned from tgt_prog, so I think we'll
endup with wrong up number here after detach (for both tgt_prog or kernel function)

>  	/* tgt_prog is NULL if target is a kernel function */
> -	if (tr_link->tgt_prog)
> +	if (tr_link->tgt_prog) {
> +		tr_link->tgt_prog->aux->follower_cnt--;
>  		bpf_prog_put(tr_link->tgt_prog);
> +	}
>  }
>  
>  static void bpf_tracing_link_dealloc(struct bpf_link *link)
> @@ -3235,6 +3238,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
>  	if (err)
>  		goto out_unlock;
>  
> +	if (tgt_prog) {
> +		/* Bookkeeping for managing the prog attachment chain. */
> +		tgt_prog->aux->follower_cnt++;
> +		prog->aux->attach_depth = tgt_prog->aux->attach_depth + 1;
> +	}

missing cleanup/dec if the next bpf_trampoline_link_prog call fails?
probably better move that accounting after that call

> +
>  	err = bpf_trampoline_link_prog(&link->link, tr);
>  	if (err) {
>  		bpf_link_cleanup(&link_primer);
> @@ -4509,6 +4518,7 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	if (prog->aux->btf)
>  		info.btf_id = btf_obj_id(prog->aux->btf);
>  	info.attach_btf_id = prog->aux->attach_btf_id;
> +	info.attach_depth = prog->aux->attach_depth;
>  	if (attach_btf)
>  		info.attach_btf_obj_id = btf_obj_id(attach_btf);
>  
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9ae6eae13471..de058a83d769 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20329,6 +20329,12 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	if (tgt_prog) {
>  		struct bpf_prog_aux *aux = tgt_prog->aux;
>  
> +		if (aux->attach_depth >= 32) {
> +			bpf_log(log, "Target program attach depth is %d. Too large\n",
> +					aux->attach_depth);
> +			return -EINVAL;
> +		}
> +
>  		if (bpf_prog_is_dev_bound(prog->aux) &&
>  		    !bpf_prog_dev_bound_match(prog, tgt_prog)) {
>  			bpf_log(log, "Target program bound device mismatch");
> @@ -20367,9 +20373,16 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			bpf_log(log, "Can attach to only JITed progs\n");
>  			return -EINVAL;
>  		}
> -		if (tgt_prog->type == prog->type) {
> -			/* Cannot fentry/fexit another fentry/fexit program.
> -			 * Cannot attach program extension to another extension.
> +		if (tgt_prog->type == prog->type &&
> +			(prog_extension || prog->aux->follower_cnt > 0)) {
> +			/*
> +			 * To avoid potential call chain cycles, prevent attaching programs
> +			 * of the same type. The only exception is standalone fentry/fexit
> +			 * programs that themselves are not attachment targets.
> +			 * That means:
> +			 *  - Cannot attach followed fentry/fexit to another
> +			 *    fentry/fexit program.
> +			 *  - Cannot attach program extension to another extension.

would be great to have tests for this

>  			 * It's ok to attach fentry/fexit to extension program.
>  			 */
>  			bpf_log(log, "Cannot recursively attach\n");
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 7ec4f5671e7a..24565e8bb825 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -554,6 +554,8 @@ static void print_prog_plain(struct bpf_prog_info *info, int fd)
>  		printf("  memlock %sB", memlock);
>  	free(memlock);
>  
> +	printf("  attach depth %d", info->attach_depth);
> +

I think we should print only if the value != 0 like we do for other fields

jirka


>  	if (info->nr_map_ids)
>  		show_prog_maps(fd, info->nr_map_ids);
>  
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 7cf8bcf9f6a2..aa6614547ef6 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6465,6 +6465,7 @@ struct bpf_prog_info {
>  	__u32 verified_insns;
>  	__u32 attach_btf_obj_id;
>  	__u32 attach_btf_id;
> +	__u32 attach_depth;
>  } __attribute__((aligned(8)));
>  
>  struct bpf_map_info {
> 
> base-commit: 100888fb6d8a185866b1520031ee7e3182b173de
> -- 
> 2.41.0
> 
> 

