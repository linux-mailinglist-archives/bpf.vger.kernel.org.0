Return-Path: <bpf+bounces-13159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2315A7D5CD5
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 23:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C0EB2108C
	for <lists+bpf@lfdr.de>; Tue, 24 Oct 2023 21:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F6A3D96C;
	Tue, 24 Oct 2023 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYQ9FJpQ"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB913CD06
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 21:01:11 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A010CE
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:01:08 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9936b3d0286so744331566b.0
        for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 14:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698181267; x=1698786067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZwEqgxa/rn40uywRIrD6s1/h9VNtZNqCJAYr7dambtI=;
        b=FYQ9FJpQeqrnw/CvTaeNjjlZVcfqrINm/KKv3giFBi7wdIOHKCU+87P/7H5cM5nQa3
         UUkfHFlE3IMt8UM6g4/raXFA+BAe82f/Z+cMUepnJpcWoSo2QRoDcTtlMf5oYsk3rP3f
         PkTPsUzABY+xFNcuteyB1vjZDIDeo19MfOPADpBcW0EepBsLUcXN/WvtsBzCity30//V
         hI2HaGk2zeUTO5uRKSGl3WcyLvq3evMUbcro6NsEZL/U08UHWsA/vl+K11XwQ+1bJW54
         AkdMBw3g2JQnisDXDIcG7xFuUHmkWzJ0AX7jJDCRcvWiGOhNAhPUUH5Ti0oIhcd8hr6I
         eASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698181267; x=1698786067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwEqgxa/rn40uywRIrD6s1/h9VNtZNqCJAYr7dambtI=;
        b=lxZY6PIxYC1S673T5dji/9QVXK1Tjons2n2H3iBVd4qqaA7H/iezGCa2WAFjc7HhW9
         JfmQZKITJZvr8/f4SMZKdhVYtcyg6ypgaDrOBIh+FOW3wgmMJyWem5i7dMJJJyCJjMpa
         nLUrVkE5N+YbFe2swKGpr0tWHMXKrFi3WX0aUVROXsJf094mFleVtaypaN2665pGOXlU
         v+gtfa227uJ+8P++G1Jq68lhe2NyyyVCpSDfTZ1Q6ZkYSiiiHANtXA64OTQIfpvWNx5y
         fYkv3RmLHJVDucnxcKFQKiIacgXJo3ddIns4JbyajVJ/x092cmNIt08YKIx9OtRxKxNX
         kQmQ==
X-Gm-Message-State: AOJu0YzTMb0J3lpzaXfHeh4xWjQ3LvX+nOiDN7KsWSnDY9j3fRuFF/Ex
	qmqV5QDh3R0AYZxnLtP++TA=
X-Google-Smtp-Source: AGHT+IGRoPGCAvMzhSddqW5tJN3pJGLWLpYIT59bgOOzH9pY3luD+IkArpy+9UY5DtakOCWEFMw8yQ==
X-Received: by 2002:a17:907:a03:b0:9c7:5b43:a8ee with SMTP id bb3-20020a1709070a0300b009c75b43a8eemr10176626ejc.74.1698181266270;
        Tue, 24 Oct 2023 14:01:06 -0700 (PDT)
Received: from krava ([83.240.62.184])
        by smtp.gmail.com with ESMTPSA id 30-20020a170906209e00b009a1b857e3a5sm8750213ejq.54.2023.10.24.14.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:01:05 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 24 Oct 2023 23:01:04 +0200
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, martin.lau@kernel.org, kernel-team@meta.com,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v4 bpf-next 6/7] bpf: Use arch_bpf_trampoline_size
Message-ID: <ZTgwkGP5z519re/0@krava>
References: <20231018180336.1696131-1-song@kernel.org>
 <20231018180336.1696131-7-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018180336.1696131-7-song@kernel.org>

On Wed, Oct 18, 2023 at 11:03:35AM -0700, Song Liu wrote:
> Instead of blindly allocating PAGE_SIZE for each trampoline, check the size
> of the trampoline with arch_bpf_trampoline_size(). This size is saved in
> bpf_tramp_image->size, and used for modmem charge/uncharge. The fallback
> arch_alloc_bpf_trampoline() still allocates a whole page because we need to
> use set_memory_* to protect the memory.
> 
> struct_ops trampoline still uses a whole page for multiple trampolines.
> 
> With this size check at caller (regular trampoline and struct_ops
> trampoline), remove arch_bpf_trampoline_size() from
> arch_prepare_bpf_trampoline() in archs.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>  # on s390x
> ---
>  arch/arm64/net/bpf_jit_comp.c   |  7 -----
>  arch/riscv/net/bpf_jit_comp64.c |  7 -----
>  include/linux/bpf.h             |  1 +
>  kernel/bpf/bpf_struct_ops.c     |  7 +++++
>  kernel/bpf/trampoline.c         | 49 +++++++++++++++++++++------------
>  5 files changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index a6671253b7ed..8955da5c47cf 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2079,13 +2079,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>  	if (nregs > 8)
>  		return -ENOTSUPP;
>  
> -	ret = arch_bpf_trampoline_size(m, flags, tlinks, func_addr);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret > ((long)image_end - (long)image))
> -		return -EFBIG;
> -
>  	jit_fill_hole(image, (unsigned int)(image_end - image));
>  	ret = prepare_trampoline(&ctx, im, tlinks, func_addr, nregs, flags);
>  
> diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
> index 35747fafde57..58dc64dd94a8 100644
> --- a/arch/riscv/net/bpf_jit_comp64.c
> +++ b/arch/riscv/net/bpf_jit_comp64.c
> @@ -1052,13 +1052,6 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
>  	int ret;
>  	struct rv_jit_context ctx;
>  
> -	ret = arch_bpf_trampoline_size(im, m, flags, tlinks, func_addr);
> -	if (ret < 0)
> -		return ret;
> -
> -	if (ret > (long)image_end - (long)image)
> -		return -EFBIG;
> -
>  	ctx.ninsns = 0;
>  	/*
>  	 * The bpf_int_jit_compile() uses a RW buffer (ctx.insns) to write the
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 2ed65b764aab..17bd3dbd2636 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1122,6 +1122,7 @@ enum bpf_tramp_prog_type {
>  
>  struct bpf_tramp_image {
>  	void *image;
> +	int size;
>  	struct bpf_ksym ksym;
>  	struct percpu_ref pcref;
>  	void *ip_after_call;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index e9e95879bce2..4d53c53fc5aa 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -355,6 +355,7 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>  				      void *image, void *image_end)
>  {
>  	u32 flags;
> +	int size;
>  
>  	tlinks[BPF_TRAMP_FENTRY].links[0] = link;
>  	tlinks[BPF_TRAMP_FENTRY].nr_links = 1;
> @@ -362,6 +363,12 @@ int bpf_struct_ops_prepare_trampoline(struct bpf_tramp_links *tlinks,
>  	 * and it must be used alone.
>  	 */
>  	flags = model->ret_size > 0 ? BPF_TRAMP_F_RET_FENTRY_RET : 0;
> +
> +	size = arch_bpf_trampoline_size(model, flags, tlinks, NULL);
> +	if (size < 0)
> +		return size;
> +	if (size > (unsigned long)image_end - (unsigned long)image)
> +		return -E2BIG;
>  	return arch_prepare_bpf_trampoline(NULL, image, image_end,
>  					   model, flags, tlinks, NULL);
>  }
> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 285c5b7c1ea4..7c0535edab3f 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
> @@ -254,8 +254,8 @@ bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bool *ip_a
>  static void bpf_tramp_image_free(struct bpf_tramp_image *im)
>  {
>  	bpf_image_ksym_del(&im->ksym);
> -	arch_free_bpf_trampoline(im->image, PAGE_SIZE);
> -	bpf_jit_uncharge_modmem(PAGE_SIZE);
> +	arch_free_bpf_trampoline(im->image, im->size);
> +	bpf_jit_uncharge_modmem(im->size);
>  	percpu_ref_exit(&im->pcref);
>  	kfree_rcu(im, rcu);
>  }
> @@ -349,7 +349,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
>  	call_rcu_tasks_trace(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
>  }
>  
> -static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
> +static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key, int size)
>  {
>  	struct bpf_tramp_image *im;
>  	struct bpf_ksym *ksym;
> @@ -360,12 +360,13 @@ static struct bpf_tramp_image *bpf_tramp_image_alloc(u64 key)
>  	if (!im)
>  		goto out;
>  
> -	err = bpf_jit_charge_modmem(PAGE_SIZE);
> +	err = bpf_jit_charge_modmem(size);
>  	if (err)
>  		goto out_free_im;
> +	im->size = size;
>  
>  	err = -ENOMEM;
> -	im->image = image = arch_alloc_bpf_trampoline(PAGE_SIZE);
> +	im->image = image = arch_alloc_bpf_trampoline(size);
>  	if (!image)
>  		goto out_uncharge;
>

hi,
there's call in here to add the image symbol

  bpf_image_ksym_add(image, ksym);

which sets:

  ksym->end = ksym->start + PAGE_SIZE;

we should set it to 'ksym->start + size' now

and I think that can probably screw up the bpf_prog_ksym_find
and it might be the reason why I'm getting now the crash below

jirka


---
[  612.320127][  T685] BUG: kernel NULL pointer dereference, address: 0000000000000038
[  612.320828][  T685] #PF: supervisor read access in kernel mode
[  612.321379][  T685] #PF: error_code(0x0000) - not-present page
[  612.321927][  T685] PGD 150962067 P4D 150962067 PUD 150961067 PMD 0
[  612.322515][  T685] Oops: 0000 [#1] PREEMPT SMP DEBUG_PAGEALLOC NOPTI
[  612.323114][  T685] CPU: 0 PID: 685 Comm: test_progs Tainted: G           O       6.6.0-rc5+ #15 ed76d9b9137159229594dbc9e36565a3806e48da
[  612.324214][  T685] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
[  612.325063][  T685] RIP: 0010:bpf_stack_walker+0x4a/0x80
[  612.325550][  T685] Code: ff 84 c0 75 17 8b 4d 18 85 c9 0f 94 c3 89 d8 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 4c 89 e7 89 c3 e8 aa ed fc ff 83 45 18 01 <48> 8b 40 38 8b 50 2c 85 d2 75 d8 31 db 48 89 45 00 4c 89 6d 08 89
[  612.327074][  T685] RSP: 0018:ffffc90003e33ba8 EFLAGS: 00010202
[  612.327597][  T685] RAX: 0000000000000000 RBX: 00000000a0000b01 RCX: 0000000000000000
[  612.328280][  T685] RDX: ffff88817fa04010 RSI: 0000000000001b26 RDI: ffffffffa0000bee
[  612.328971][  T685] RBP: ffffc90003e33c70 R08: 00000000ffffffff R09: 0000000000000001
[  612.329662][  T685] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffa0000bee
[  612.330351][  T685] R13: ffffc90003e33ca8 R14: ffffc90003e33cd0 R15: ffffc90003e33d48
[  612.331037][  T685] FS:  00007f6fa0729d00(0000) GS:ffff88846ce00000(0000) knlGS:0000000000000000
[  612.331797][  T685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  612.332352][  T685] CR2: 0000000000000038 CR3: 0000000150b8a001 CR4: 0000000000770ef0
[  612.333055][  T685] PKRU: 55555554
[  612.333384][  T685] Call Trace:
[  612.333685][  T685]  <TASK>
[  612.333972][  T685]  ? __die+0x1f/0x70
[  612.334323][  T685]  ? page_fault_oops+0x176/0x4d0
[  612.334763][  T685]  ? __lock_acquire+0x63c/0x2470
[  612.335189][  T685]  ? do_user_addr_fault+0x73/0x870
[  612.335633][  T685]  ? exc_page_fault+0x81/0x250
[  612.336049][  T685]  ? asm_exc_page_fault+0x22/0x30
[  612.336469][  T685]  ? bpf_trampoline_6442480557+0x32e/0x1000
[  612.336964][  T685]  ? bpf_trampoline_6442480557+0x32e/0x1000
[  612.337456][  T685]  ? bpf_stack_walker+0x4a/0x80
[  612.337878][  T685]  ? bpf_stack_walker+0x46/0x80
[  612.338303][  T685]  ? __pfx_bpf_stack_walker+0x10/0x10
[  612.339502][  T685]  arch_bpf_stack_walk+0x59/0xb0
[  612.339935][  T685]  ? bpf_trampoline_6442480557+0x32e/0x1000
[  612.340436][  T685]  bpf_throw+0x4f/0xe0
[  612.340805][  T685]  bpf_trampoline_6442480557+0x32e/0x1000
[  612.341292][  T685]  bpf_test_run+0x198/0x330
[  612.341715][  T685]  ? bpf_test_run+0xfb/0x330
[  612.342159][  T685]  ? kmem_cache_alloc+0x364/0x400
[  612.342656][  T685]  ? slab_build_skb+0x1f/0x120
[  612.343074][  T685]  ? __ksize+0x57/0x140
[  612.343509][  T685]  bpf_prog_test_run_skb+0x373/0x6e0
[  612.344033][  T685]  __sys_bpf+0x305/0x2860
[  612.344495][  T685]  __x64_sys_bpf+0x1a/0x30
[  612.344937][  T685]  do_syscall_64+0x38/0x90
[  612.345410][  T685]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
[  612.346001][  T685] RIP: 0033:0x7f6fa08f1b4d
[  612.346455][  T685] Code: c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 8b 92 0c 00 f7 d8 64 89 01 48
[  612.348235][  T685] RSP: 002b:00007fffb123a118 EFLAGS: 00000202 ORIG_RAX: 0000000000000141
[  612.348860][  T685] RAX: ffffffffffffffda RBX: 00007fffb123c118 RCX: 00007f6fa08f1b4d
[  612.349430][  T685] RDX: 0000000000000050 RSI: 00007fffb123a150 RDI: 000000000000000a
[  612.350068][  T685] RBP: 00007fffb123a130 R08: 0000000000000001 R09: 00007fffb123a150
[  612.350770][  T685] R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000001
[  612.351430][  T685] R13: 0000000000000000 R14: 00007f6fa0a39000 R15: 000000000121cdb0
[  612.352088][  T685]  </TASK>
[  612.352364][  T685] Modules linked in: bpfilter bpf_testmod(O) intel_rapl_msr intel_rapl_common crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel kvm_intel rapl iTCO_wdt iTCO_vendor_support i2c_i801 i2c_smbus lpc_ich drm loop drm_panel_orientation_quirks zram [last unloaded: bpf_testmod(O)]
[  612.354380][  T685] CR2: 0000000000000038
[  612.354723][  T685] ---[ end trace 0000000000000000 ]---
[  612.355122][  T685] RIP: 0010:bpf_stack_walker+0x4a/0x80
[  612.355517][  T685] Code: ff 84 c0 75 17 8b 4d 18 85 c9 0f 94 c3 89 d8 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc 4c 89 e7 89 c3 e8 aa ed fc ff 83 45 18 01 <48> 8b 40 38 8b 50 2c 85 d2 75 d8 31 db 48 89 45 00 4c 89 6d 08 89
[  612.361072][  T685] RSP: 0018:ffffc90003e33ba8 EFLAGS: 00010202
[  612.361522][  T685] RAX: 0000000000000000 RBX: 00000000a0000b01 RCX: 0000000000000000
[  612.362174][  T685] RDX: ffff88817fa04010 RSI: 0000000000001b26 RDI: ffffffffa0000bee
[  612.362883][  T685] RBP: ffffc90003e33c70 R08: 00000000ffffffff R09: 0000000000000001
[  612.363562][  T685] R10: 0000000000000001 R11: 0000000000000000 R12: ffffffffa0000bee
[  612.364246][  T685] R13: ffffc90003e33ca8 R14: ffffc90003e33cd0 R15: ffffc90003e33d48
[  612.364943][  T685] FS:  00007f6fa0729d00(0000) GS:ffff88846ce00000(0000) knlGS:0000000000000000
[  612.365719][  T685] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  612.366287][  T685] CR2: 0000000000000038 CR3: 0000000150b8a001 CR4: 0000000000770ef0
[  612.366978][  T685] PKRU: 55555554
[  612.367316][  T685] Kernel panic - not syncing: Fatal exception in interrupt
[  612.367990][  T685] Kernel Offset: disabled
[  612.368357][  T685] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

