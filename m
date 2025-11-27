Return-Path: <bpf+bounces-75650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C9DC8F8A0
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A853A21DB
	for <lists+bpf@lfdr.de>; Thu, 27 Nov 2025 16:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9283358A6;
	Thu, 27 Nov 2025 16:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epKgoxfa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D379332EB4
	for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764261625; cv=none; b=kFLRBbqvk+MLl68a5sJTEVxO3IF8fbvEVLFXW3f7R231eZ8N4v70QFcgIKI5vfKNr1AAbPB6+S/JmGTAavzHC7RKzRL9vPwGmudqandECeNM+K65vHK4I7c8E7sRTHyWD8jxR+My631Mdg4x3mL0d4dVUYIHfwFaSKY53ekMvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764261625; c=relaxed/simple;
	bh=3BUY4/8S2GIcjOEMf4d3TnjvGdsZu4ClmB8+Y6xciu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEjWWsNYKMWNYz4SanwrEgcB6QrQXVFUShIUo2tqtUqLL6fZJJw4m09BPugFJmPj6LgdZYQ6PS0ZbK4gwxcK5eRtVQWhc8jKG+R8i8GFawAGvJcbnqN3TerhNh0+Xh6gcsrOkyh/aXYJ+dLd4sERgvGFqeNztP7nZHqX0X73sIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epKgoxfa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4775ae77516so10485575e9.1
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 08:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764261621; x=1764866421; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpbhA4kahscunG1miMdjeqKrdb/ww9Rjv354nn7xuNE=;
        b=epKgoxfauouvGU7obiLQ5dANeG3Hv/LSn/r19oJmvjm+87hlXw8Urivcr/PLPYgNly
         TZlcyz/wUuYNn8wSu80YpMYje6rybkwFosBhkAj7gd9m3y5ph107rEeJSm90NR5oAw11
         mCva3MkF09Acxm/uP/4+Ywik8CYjFua290H+Ua4oWtyet71pjNMP8KIQVwwUFMEB1LeZ
         alqvuyVBvFeCPBqwUS4Q5tCxJpp/Gsn6y7NggHu4Vsph+TlMEJyfdyov1+uSGOtA4SCe
         fyaG1EvItYLr+zG8X1VUFkRw75CXMvi13iIaPAfvNZlHD2A3//y0+1NFIPM3ipREoJ02
         Mzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764261621; x=1764866421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpbhA4kahscunG1miMdjeqKrdb/ww9Rjv354nn7xuNE=;
        b=pYu8u3NRUB7qOVVuRHLIM5GF+zXk/NEkkdVyyhraADoDgVvHQH1M/dgqFWbsXHNOV7
         SERQ1Z4XvAyX5rZvQPNkPjY16WWZ9XKagW1gr1f2ZJzviDFb3Nu0WFjYijinSacZUc7I
         vO3qGc04AN1FZcpTLbMFaYLql5elQSoObcYaBVTLkZ/FtZVpOvjwtrTfiFNbgiyaTQSU
         uVYh9mWuNT9ZtnPUHq03gdECdDVFTzeOZPlu0RAh3KyRcNrEx+/SxiXgGo4R8nHH7tTF
         Hny4OeSNLtlWiyJrWNLOdszBrqX7BCng0ghlWKTgeJ4eOuVb2UvMuBSuAm+Jy+fX5fs7
         ayAQ==
X-Gm-Message-State: AOJu0YyYk/MJXevkQdGIzP/ISIhSt5J7dvFhJLr9LnMLLOND5/BS4inK
	YzdoJFunKMUExf/daTpg6UpWjbHaZsSABW0/UuNYkyeXWax09UBY5g8J
X-Gm-Gg: ASbGnctGV5U3MgACyLF0AfBS4eXxS5O6u/S6C3qTdWWktZ0YvBIc81uIELNtTperHY7
	74t6j0ShxUafou2utuA1Q74BLQkpRGQ673ac7rg6sVQ9AlheXZ1zNCy/vbIS2B342GAVIMxghbs
	wXqebE26gCKvbUbRLnuM+F9bHwVAvgg8G5zis9vo7NRZuAZEDBrezrsFh5v3LCOAoKQLYnleq4V
	D0YVy81i0GfV78n3pJyCrsBoFcaW8bpooU0eYok6Xu7cD8IGu2V9I9H09837ff8PQH1oI00i2xT
	N/aurmOTlB0Wkzhicz0h8j4vgfUf8iDBzfnVMHyrNZiN0cZG4Xcm1bcpup8MoW8ocCGhfgorVSQ
	DV8YybsRUp02u5ckO6EFiHpk/PbwV5EOVIbfgZSM5QpzT3LIDDelnu9TMvQ2T193IyM44N9yf1K
	ASah/sTqIfapMlOQDoYurt
X-Google-Smtp-Source: AGHT+IExwv94bddp1cM9WpyoXvqWAnSsuOod2CiDunnc8SENlRexxhyrc4l8iWtFxFNN93WisrkE9A==
X-Received: by 2002:a05:600c:a07:b0:477:a219:cdb7 with SMTP id 5b1f17b1804b1-477c10523aamr280626535e9.0.1764261620427;
        Thu, 27 Nov 2025 08:40:20 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0cc1d6sm102382765e9.12.2025.11.27.08.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 08:40:19 -0800 (PST)
Date: Thu, 27 Nov 2025 16:46:49 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH bpf-next] bpf: arm64: Fix panic due to missing BTI at
 indirect jump targets
Message-ID: <aSiAeTnrh9JQ0EGh@mail.gmail.com>
References: <20251127140318.3944249-1-xukuohai@huaweicloud.com>
 <aSh4QCd27MUHMVdp@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSh4QCd27MUHMVdp@mail.gmail.com>

On 25/11/27 04:11PM, Anton Protopopov wrote:
> On 25/11/27 10:03PM, Xu Kuohai wrote:
> > From: Xu Kuohai <xukuohai@huawei.com>
> 
> This patch doesn't apply to bpf-next due to
> https://lore.kernel.org/bpf/20251125145857.98134-2-leon.hwang@linux.dev/T/#u
> 
> > When BTI is enabled, the indirect jump selftest triggers BTI exception:
> > 
> > Internal error: Oops - BTI: 0000000036000003 [#1]  SMP
> > ...
> > Call trace:
> >  bpf_prog_2e5f1c71c13ac3e0_big_jump_table+0x54/0xf8 (P)
> >  bpf_prog_run_pin_on_cpu+0x140/0x468
> >  bpf_prog_test_run_syscall+0x280/0x3b8
> >  bpf_prog_test_run+0x22c/0x2c0
> >  __sys_bpf+0x4d8/0x5c8
> >  __arm64_sys_bpf+0x88/0xa8
> >  invoke_syscall+0x80/0x220
> >  el0_svc_common+0x160/0x1d0
> >  do_el0_svc+0x54/0x70
> >  el0_svc+0x54/0x188
> >  el0t_64_sync_handler+0x84/0x130
> >  el0t_64_sync+0x198/0x1a0
> > 
> > This happens because no BTI instruction is generated by the JIT for
> > indirect jump targets.
> > 
> > Fix it by emitting BTI instruction for every possible indirect jump
> > targets when BTI is enabled. The targets are identified by traversing
> > all instruction arrays used by the BPF program, since indirect jump
> > targets can only be read from instruction arrays.
> > 
> > Fixes: f4a66cf1cb14 ("bpf: arm64: Add support for indirect jumps")
> > Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> > ---
> >  arch/arm64/net/bpf_jit_comp.c | 20 ++++++++++++++++
> >  include/linux/bpf.h           | 12 ++++++++++
> >  kernel/bpf/bpf_insn_array.c   | 43 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 75 insertions(+)
> > 
> > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> > index 929123a5431a..f546df886049 100644
> > --- a/arch/arm64/net/bpf_jit_comp.c
> > +++ b/arch/arm64/net/bpf_jit_comp.c
> > @@ -78,6 +78,7 @@ static const int bpf2a64[] = {
> >  
> >  struct jit_ctx {
> >  	const struct bpf_prog *prog;
> > +	unsigned long *indirect_targets;
> >  	int idx;
> >  	int epilogue_offset;
> >  	int *offset;
> > @@ -1199,6 +1200,11 @@ static int add_exception_handler(const struct bpf_insn *insn,
> >  	return 0;
> >  }
> >  
> > +static bool maybe_indirect_target(int insn_off, unsigned long *targets_bitmap)
> 
> Why "maybe"? (But also see below.)
> 
> > +{
> > +	return targets_bitmap && test_bit(insn_off, targets_bitmap);
> > +}
> > +
> >  /* JITs an eBPF instruction.
> >   * Returns:
> >   * 0  - successfully JITed an 8-byte eBPF instruction.
> > @@ -1231,6 +1237,9 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx,
> >  	int ret;
> >  	bool sign_extend;
> >  
> > +	if (maybe_indirect_target(i, ctx->indirect_targets))
> > +		emit_bti(A64_BTI_J, ctx);
> > +
> >  	switch (code) {
> >  	/* dst = src */
> >  	case BPF_ALU | BPF_MOV | BPF_X:
> > @@ -2085,6 +2094,16 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >  	memset(&ctx, 0, sizeof(ctx));
> >  	ctx.prog = prog;
> >  
> > +	if (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) && bpf_prog_has_insn_array(prog)) {
> > +		ctx.indirect_targets = kvcalloc(BITS_TO_LONGS(prog->len), sizeof(unsigned long),
> > +						GFP_KERNEL);
> 
> It's allocated here on every run, but freed below only when 
> !prog->is_func || extra_pass.
> 
> > +		if (ctx.indirect_targets == NULL) {
> > +			prog = orig_prog;
> > +			goto out_off;
> > +		}
> > +		bpf_prog_collect_indirect_targets(prog, ctx.indirect_targets);
> > +	}
> > +
> >  	ctx.offset = kvcalloc(prog->len + 1, sizeof(int), GFP_KERNEL);
> >  	if (ctx.offset == NULL) {
> >  		prog = orig_prog;
> > @@ -2248,6 +2267,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> >  			prog->aux->priv_stack_ptr = NULL;
> >  		}
> >  		kvfree(ctx.offset);
> > +		kvfree(ctx.indirect_targets);
> >  out_priv_stack:
> >  		kfree(jit_data);
> >  		prog->aux->jit_data = NULL;
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index a9b788c7b4aa..c81eb54f7b26 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -3822,11 +3822,23 @@ void bpf_insn_array_adjust_after_remove(struct bpf_map *map, u32 off, u32 len);
> >  
> >  #ifdef CONFIG_BPF_SYSCALL
> >  void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image);
> > +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap);
> > +bool bpf_prog_has_insn_array(const struct bpf_prog *prog);
> >  #else
> >  static inline void
> >  bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
> >  {
> >  }
> > +
> > +static inline bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
> > +{
> > +	return false;
> > +}
> > +
> > +static inline void
> > +bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
> > +{
> > +}
> >  #endif
> >  
> >  #endif /* _LINUX_BPF_H */
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > index 61ce52882632..ed20b186a1f5 100644
> > --- a/kernel/bpf/bpf_insn_array.c
> > +++ b/kernel/bpf/bpf_insn_array.c
> > @@ -299,3 +299,46 @@ void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
> >  		}
> >  	}
> >  }
> > +
> > +bool bpf_prog_has_insn_array(const struct bpf_prog *prog)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +		if (is_insn_array(prog->aux->used_maps[i]))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> 
> I think a different check is needed here (and a different function
> name, smth like "bpf_prog_has_indirect_jumps"), and a different
> algorithm to collect jump targets in the chunk below. A program can
> have instruction arrays not related to indirect jumps (see, e.g.,
> bpf_insn_array selftests + in future insns arrays will be used to
> also support other functionality). As an extreme case, an insn array
> can point to every instruction in a prog, thus a BTI will be
> generated for every instruction.
> 
> In verifier it is used a bit differently, namely, all insn arrays for
> a given subprog are collected when an indirect jump is encountered
> (and non-deterministic only in check_cfg). Later in verification, an
> exact map is used, so this is not a problem.
> 
> Initially I wanted to have a map flag (in map_extra) to distingiush between
> different types of instruction arrays ("plane ones", "jump targets",
> "call targets", "static keys"), but Andrii wasn't happy with it,
> so eventually I've dropped it. Maybe it is worth adding it until
> the code is merged to upstream? Eduard, Alexei, wdyt?

Actually, this is even better to mark a map as containing indirect
jump targets in check_indirect_jump(). This will be the most precise
set of targets, and won't require any userspace-visible changes/flags.

Something like this:

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 6498be4c44f8..c2d708213330 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -292,6 +292,10 @@ struct bpf_map_owner {
 	enum bpf_attach_type expected_attach_type;
 };
 
+/* map_subtype values for map_type BPF_MAP_TYPE_INSN_ARRAY */
+#define BPF_INSN_ARRAY_VOID		0
+#define BPF_INSN_ARRAY_JUMP_TABLE	1
+
 struct bpf_map {
 	u8 sha[SHA256_DIGEST_SIZE];
 	const struct bpf_map_ops *ops;
@@ -331,6 +335,7 @@ struct bpf_map {
 	bool frozen; /* write-once; write-protected by freeze_mutex */
 	bool free_after_mult_rcu_gp;
 	bool free_after_rcu_gp;
+	u32 map_subtype; /* defined per map type */
 	atomic64_t sleepable_refcnt;
 	s64 __percpu *elem_count;
 	u64 cookie; /* write-once */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 766695491bc5..60bbd32e793a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20293,6 +20293,12 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
 		return -EINVAL;
 	}
 
+	/*
+	 * Explicitly mark this map as a jump table such that it can be
+	 * distinguished later from other instruction arrays
+	 */
+	map->map_subtype = BPF_INSN_ARRAY_JUMP_TABLE;
+
 	for (i = 0; i < n - 1; i++) {
 		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
 					  env->insn_idx, env->cur_state->speculative);

> > +
> > +/*
> > + * This function collects possible indirect jump targets in a BPF program. Since indirect jump
> > + * targets can only be read from instruction arrays, it traverses all instruction arrays used
> > + * by @prog. For each instruction in the arrays, it sets the corresponding bit in @bitmap.
> > + */
> > +void bpf_prog_collect_indirect_targets(const struct bpf_prog *prog, unsigned long *bitmap)
> > +{
> > +	struct bpf_insn_array *insn_array;
> > +	struct bpf_map *map;
> > +	u32 xlated_off;
> > +	int i, j;
> > +
> > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +		map = prog->aux->used_maps[i];
> > +		if (!is_insn_array(map))
> > +			continue;
> > +
> > +		insn_array = cast_insn_array(map);
> > +		for (j = 0; j < map->max_entries; j++) {
> > +			xlated_off = insn_array->values[j].xlated_off;
> > +			if (xlated_off == INSN_DELETED)
> > +				continue;
> > +			if (xlated_off < prog->aux->subprog_start)
> > +				continue;
> > +			xlated_off -= prog->aux->subprog_start;
> > +			if (xlated_off >= prog->len)
> > +				continue;
> > +			__set_bit(xlated_off, bitmap);
> > +		}
> > +	}
> > +}
> > -- 
> > 2.47.3
> > 

