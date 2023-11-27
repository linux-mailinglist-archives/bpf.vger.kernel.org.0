Return-Path: <bpf+bounces-15900-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 684517FA059
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98FE11C20DC8
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99B72D02B;
	Mon, 27 Nov 2023 13:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAUYTIBn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF3182
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 05:09:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40b473dce26so5742615e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 05:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701090591; x=1701695391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BsLflszgIhvvxcWvrgC+2G5WpiuLF5WzuhHOPuw4FBk=;
        b=TAUYTIBnboQ4z6sKkl6SJdzy0GEf93mGIUYhKgGkzwSp6Wfto1lt85DwvaIG5OQCpp
         RiOOPqegg5lBPlKmgxtef8+uUhkJp+tBaR+oNI8ws1pxB+64QnX/wxP653zfBsVQSrlB
         snuHlrQOCzE3e04Ksp17DOjC/IKoBMdY7TbT3PZnOAfaqrrFNHZy/aAEiE0xa861dKdz
         rKWiTgxqQWlrKKXivjgehApdeguSWK3exOd/GoqDKZMK9li/r2SewY54nKA9XHT3K3CV
         e62CKPLo+HaCLeqcUPWj2tL4oYSV9UZsNCZamXd16Yb61IKTZ//inobGfZ8yKyldsd8a
         Lv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701090591; x=1701695391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsLflszgIhvvxcWvrgC+2G5WpiuLF5WzuhHOPuw4FBk=;
        b=OXDBihITYocDhe8CQfZvbDmWE+FDDQKD0xeRUBu9fTH9dKuoWnUqofp1beKT43Gds0
         eWokH9EugPVrVV630oUoYt1ZJ1l3rTZJY+jqy19sUjjgK6rZ0J1hX0H+k1zNoq5M3wgd
         RxfD669Flu2emj2z23WE9x6LMMPPR9yzJpY4xZmz/o56snUGUeYh9BqO/MjAtg7Rdpr8
         v+/r6laoAVtbg4a8RzPaWm8wlCxG4rlASZc4KUOWqcpZUh3+ojbtqmBJEuFHfaCDCiTB
         NtFIMDcZclD7ZVwEXkcngzO8OKfJTi2VqrjoDGdL7OojgIagJcdxMu01JhD5SW9e5Fjs
         hqRg==
X-Gm-Message-State: AOJu0YysXJ6v7s9RPkXXC17x+Fx6wjzJ8usYQUslNsUc+Z5R28ghtMD+
	jdeHN9Etpe+mneTsc+xgreM=
X-Google-Smtp-Source: AGHT+IFbe+dng+CHyqc0R50sNr1UfCnO6JmoWI/zTaxig2EINwD9yTCFNz1scvGbFRMqtl9XYANTZA==
X-Received: by 2002:a05:600c:31a9:b0:405:770b:e90a with SMTP id s41-20020a05600c31a900b00405770be90amr8253784wmp.34.1701090590686;
        Mon, 27 Nov 2023 05:09:50 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id o7-20020a05600c510700b0040b36ad5413sm13719237wms.46.2023.11.27.05.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 05:09:50 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 27 Nov 2023 14:09:48 +0100
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Lee Jones <lee@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com,
	bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf, x64: Fix prog_array_map_poke_run map poke update
Message-ID: <ZWSVHMDZVciU8uMX@krava>
References: <20231127094525.1366740-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127094525.1366740-1-jolsa@kernel.org>

On Mon, Nov 27, 2023 at 10:45:25AM +0100, Jiri Olsa wrote:
> Lee pointed out issue found by syscaller [0] hitting BUG in prog
> array map poke update in prog_array_map_poke_run function due to
> bpf_arch_text_poke error return value.
> 
> There's race window where bpf_arch_text_poke can fail due to missing
> bpf program kallsym symbols, which is accounted for with check for
> -EINVAL in BUG_ON.
> 
> The problem is that in such case we won't update the tail call jump
> and cause imballance for the next tail call update check which will
> fail with -EBUSY in __bpf_arch_text_poke.
> 
> I'm hitting following race during the program load:
> 
>   CPU 0                                   CPU 1
> 
>   bpf_prog_load
>     bpf_check
>       do_misc_fixups
>         prog_array_map_poke_track {}
> 
>                                           map_update_elem
>                                             bpf_fd_array_map_update_elem
>                                               prog_array_map_poke_run
> 
>                                                 bpf_arch_text_poke returns -EINVAL
> 
>     bpf_prog_kallsyms_add
> 
> After bpf_arch_text_poke (CPU 1) fails to update the tail call jump,
> the next poke update fails on expected jump instruction check in
> __bpf_arch_text_poke with -EBUSY and triggers the BUG_ON in
> prog_array_map_poke_run.
> 
> Similar race exists on the program unload.
> 
> Fixing this by calling directly __bpf_arch_text_poke and skipping the bpf
> symbol check like we do in bpf_tail_call_direct_fixup. This way the
> prog_array_map_poke_run does not depend on bpf program having the kallsym
> symbol in place.
> 
> [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Fixes: ebf7d1f508a7 ("bpf, x64: rework pro/epilogue and tailcall handling in JIT")
> Reported-by: syzbot+97a4fe20470e9bc30810@syzkaller.appspotmail.com
> Tested-by: Lee Jones <lee@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

hum, this breaks non x86 builds.. will send new version

jirka


> ---
>  arch/x86/net/bpf_jit_comp.c |  4 ++--
>  include/linux/bpf.h         |  2 ++
>  kernel/bpf/arraymap.c       | 31 +++++++++++--------------------
>  3 files changed, 15 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 8c10d9abc239..35c2988caf29 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -391,8 +391,8 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
>  	return emit_patch(pprog, func, ip, 0xE9);
>  }
>  
> -static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> -				void *old_addr, void *new_addr)
> +int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> +			 void *old_addr, void *new_addr)
>  {
>  	const u8 *nop_insn = x86_nops[5];
>  	u8 old_insn[X86_PATCH_SIZE];
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 6762dac3ef76..c28a8563e845 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3174,6 +3174,8 @@ enum bpf_text_poke_type {
>  
>  int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
>  		       void *addr1, void *addr2);
> +int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
> +			 void *old_addr, void *new_addr);
>  
>  void *bpf_arch_text_copy(void *dst, void *src, size_t len);
>  int bpf_arch_text_invalidate(void *dst, size_t len);
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 2058e89b5ddd..0b5afa2ec17a 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -1044,20 +1044,11 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  			 *    activated, so tail call updates can arrive from here
>  			 *    while JIT is still finishing its final fixup for
>  			 *    non-activated poke entries.
> -			 * 3) On program teardown, the program's kallsym entry gets
> -			 *    removed out of RCU callback, but we can only untrack
> -			 *    from sleepable context, therefore bpf_arch_text_poke()
> -			 *    might not see that this is in BPF text section and
> -			 *    bails out with -EINVAL. As these are unreachable since
> -			 *    RCU grace period already passed, we simply skip them.
> -			 * 4) Also programs reaching refcount of zero while patching
> +			 * 3) Also programs reaching refcount of zero while patching
>  			 *    is in progress is okay since we're protected under
>  			 *    poke_mutex and untrack the programs before the JIT
> -			 *    buffer is freed. When we're still in the middle of
> -			 *    patching and suddenly kallsyms entry of the program
> -			 *    gets evicted, we just skip the rest which is fine due
> -			 *    to point 3).
> -			 * 5) Any other error happening below from bpf_arch_text_poke()
> +			 *    buffer is freed.
> +			 * 4) Any error happening below from __bpf_arch_text_poke()
>  			 *    is a unexpected bug.
>  			 */
>  			if (!READ_ONCE(poke->tailcall_target_stable))
> @@ -1073,33 +1064,33 @@ static void prog_array_map_poke_run(struct bpf_map *map, u32 key,
>  			new_addr = new ? (u8 *)new->bpf_func + poke->adj_off : NULL;
>  
>  			if (new) {
> -				ret = bpf_arch_text_poke(poke->tailcall_target,
> +				ret = __bpf_arch_text_poke(poke->tailcall_target,
>  							 BPF_MOD_JUMP,
>  							 old_addr, new_addr);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> +				BUG_ON(ret < 0);
>  				if (!old) {
> -					ret = bpf_arch_text_poke(poke->tailcall_bypass,
> +					ret = __bpf_arch_text_poke(poke->tailcall_bypass,
>  								 BPF_MOD_JUMP,
>  								 poke->bypass_addr,
>  								 NULL);
> -					BUG_ON(ret < 0 && ret != -EINVAL);
> +					BUG_ON(ret < 0);
>  				}
>  			} else {
> -				ret = bpf_arch_text_poke(poke->tailcall_bypass,
> +				ret = __bpf_arch_text_poke(poke->tailcall_bypass,
>  							 BPF_MOD_JUMP,
>  							 old_bypass_addr,
>  							 poke->bypass_addr);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> +				BUG_ON(ret < 0);
>  				/* let other CPUs finish the execution of program
>  				 * so that it will not possible to expose them
>  				 * to invalid nop, stack unwind, nop state
>  				 */
>  				if (!ret)
>  					synchronize_rcu();
> -				ret = bpf_arch_text_poke(poke->tailcall_target,
> +				ret = __bpf_arch_text_poke(poke->tailcall_target,
>  							 BPF_MOD_JUMP,
>  							 old_addr, NULL);
> -				BUG_ON(ret < 0 && ret != -EINVAL);
> +				BUG_ON(ret < 0);
>  			}
>  		}
>  	}
> -- 
> 2.43.0
> 

