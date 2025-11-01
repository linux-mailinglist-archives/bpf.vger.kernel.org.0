Return-Path: <bpf+bounces-73243-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117DC2829A
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 17:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EA184E8233
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B5E248883;
	Sat,  1 Nov 2025 16:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S68dsn7w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85112264CD
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762014386; cv=none; b=V6kgamEg0oSy73b0/4Y0NcLxOqEVeljTS4TQ0HuL/AwbFnwiFOIgB9p1GWQDTNAuTGcpjdBhkCYd1QRUb6WrlVZOnvToSgH2eFATkZhkMqoT6GEQ5UJJP/TbjtBlr6WHmOkJrz3w52UKjphDhrO9DIhRSjt0Ge37vky0Emr1mJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762014386; c=relaxed/simple;
	bh=XbG+Llu5A0dvQdQ26eSSMelKP62yJW7oMBERvNbIl5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NugEYS9YKFovdIDIjENIXH6bgtHCUHMIIBlbnD2Q2vjbtM4M1bHc7hTyYz4+oOLF9FVvafV4UIyKhABK7dulS3f3wQr1Nql3U38N4YPOT4tJ6Yx+Z1yk1GZ6YYlVqdtVC/uG4EP/K3kBA3XNqrfVQc/yrH2CgQBTJdnAQCfJNoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S68dsn7w; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso18743605e9.0
        for <bpf@vger.kernel.org>; Sat, 01 Nov 2025 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762014383; x=1762619183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PWU4RXOKneCJtWyYdF8SALvcI5VYi/IWN5kQU1AOcBw=;
        b=S68dsn7wgDe4xVeIo119dTYGiAVCKScZ0dLyIYoBFvkuiHf5Hg6aYIUHBlMJUSSEk3
         MihGFVhiieT3/19mbXR5D0acnbbArnOIfIbEC5yxWBt6eRk2DmUE0umrvTl2wBIUFOZ+
         CgGo3R+NZjt5e4U2f0MaQtD+ZKAGnEr3P6UTpGwc7G0Kp+H3wQQaon6GjRTpg+iBqED0
         brmyFnLdpHdB4wtgoIm+/2W9Y46bYBN4ZGt8FjAr6eIZPumYGYtneshJj0vbg6ujWRCM
         iqJUD2CuamZR6mmuYE6HbuaMYUrtuYqE+wemnij25Hl65UnJYE5sYesvbwT+3vQ5Fw4N
         fboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762014383; x=1762619183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWU4RXOKneCJtWyYdF8SALvcI5VYi/IWN5kQU1AOcBw=;
        b=DC+EeobJCksHv+8r7f3NnNH4udUvu9pBPp/IUucFnyI64uK9uK47tl9NaHSCARTHvO
         VRZQLTGRAvZxa9jNwdJorE3Y7LBOyXAaUk8dCMhtpTyohsNNqeZ9mxbm9xrmr+Tgllr2
         B43E/CdGOCODcqklwYrfrM0ZFmyXBZerHSppdW2y5CGkwMeyofCYqRE8xJSY8JL+UzyZ
         Iv4ndlLtQS+uXOalJwqGI3Y0xCUbGGuvXCm7/kSmSpTwrymTXLLFuwx4baQ4GL4w+bMN
         BGiaZkbrbbUnTpK+HQVsqQnwi4RHq7n8Ow9lWFU1/bDzuwoD5Lq2Yxxs0BYi1zWC+anr
         JyNA==
X-Gm-Message-State: AOJu0YwgcRvPCvWrk1GfUNy0MSnirx/wD+6/94yOFS/hNaoEY03VfilO
	1uGrb/3l2wXnOUbqGv3Hqq4YUaUvhYrykO+rOqX67dhrQRd7OgvVQzIG
X-Gm-Gg: ASbGncvMlRTV93hTCO4cPdPS6mbV7fiCnf+NlFiJSU+ShOYMWOmLqhHsIOGxoBEWcJU
	TC8DzkDEuGKZSWfsNzx3pdXiAAgNop+luDMQNh2PyLTLOXveiMSwWPIEE6wgpl6FBDYnE1c7XhB
	p7Lc2NTxMQg6jntSY7/DC4eRCIbvGTnU1LdxM3FstQ3A7DMvxKA3UFGDhu3zc9gP2XaaCjYvaC3
	agXItNCPoAmXkTaOvWICernW+Fjb4W17vSo61Bp6ema6BP04Yk8AAlUjgvfw34ftB+kuVg/ecFv
	UZwpdsDBAvbYpyCi6O/0h5ObxVGQ/7JtMYD4BapfaojVByBEEmuShU3V+mRkBKhdIDVjGyUIIqL
	hhBvsx5tSNVfOkZFzf6SVCKrMdfphFz34gR4mvJXuUoAGFYzd1Ak+992Z5raVSKtCPessv7UTei
	wH/ihbOu/+ErzJSs74ruTt
X-Google-Smtp-Source: AGHT+IFdawxKLXBUiEfUAunkzifOn2314PAOc/QGXe0fHRTh6EWgIRrRu24V2+1AFhOF4s10LJysXQ==
X-Received: by 2002:a05:600c:6303:b0:46e:4be1:a423 with SMTP id 5b1f17b1804b1-477307b7e7amr58052825e9.1.1762014382719;
        Sat, 01 Nov 2025 09:26:22 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773c4ac18bsm56311165e9.5.2025.11.01.09.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:26:22 -0700 (PDT)
Date: Sat, 1 Nov 2025 16:32:46 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	aspsk@isovalent.com, daniel@iogearbox.net, eddyz87@gmail.com,
	qmo@kernel.org, yonghong.song@linux.dev, martin.lau@kernel.org,
	clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH v9 bpf-next 01/11] bpf, x86: add new map type:
 instructions array
Message-ID: <aQY2LvmzFfzNxm1Q@mail.gmail.com>
References: <20251101110717.2860949-2-a.s.protopopov@gmail.com>
 <d383a192daaee1666c5a3dec3d07020dfcb4b4caa2434e73e3f911f629e35f45@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d383a192daaee1666c5a3dec3d07020dfcb4b4caa2434e73e3f911f629e35f45@mail.kernel.org>

On 25/11/01 11:29AM, bot+bpf-ci@kernel.org wrote:
> 
> ```
> commit 77dc1e7091f8bbd42ffa1730c0339642333528c6
> Author: Anton Protopopov <a.s.protopopov@gmail.com>
> 
> bpf, x86: add new map type: instructions array
> 
> This patch adds BPF_MAP_TYPE_INSN_ARRAY to track instruction offset
> mappings (original -> xlated -> jitted) during BPF program verification
> and JIT compilation.
> 
> > diff --git a/kernel/bpf/bpf_insn_array.c b/kernel/bpf/bpf_insn_array.c
> > new file mode 100644
> > index 000000000..d29f38721
> > --- /dev/null
> > +++ b/kernel/bpf/bpf_insn_array.c
> 
> [ ... ]
> 
> > @@ -0,0 +1,286 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2025 Isovalent */
> > +
> > +#include <linux/bpf.h>
> > +
> > +struct bpf_insn_array {
> > +	struct bpf_map map;
> > +	atomic_t used;
> > +	long *ips;
> > +	DECLARE_FLEX_ARRAY(struct bpf_insn_array_value, values);
> > +};
> > +
> > +#define cast_insn_array(MAP_PTR) \
> > +	container_of((MAP_PTR), struct bpf_insn_array, map)
> > +
> > +#define INSN_DELETED ((u32)-1)
> > +
> > +static inline u32 insn_array_alloc_size(u32 max_entries)
> > +{
> > +	const u32 base_size = sizeof(struct bpf_insn_array);
> > +	const u32 entry_size = sizeof(struct bpf_insn_array_value);
> > +
> > +	return base_size + max_entries * (entry_size + sizeof(long));
>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +}
> 
> Can this overflow u32? With entry_size=16 and sizeof(long)=8 on 64-bit,
> max_entries around 200 million would cause: 200M * 24 = 4.8B which wraps
> to around 504MB when cast to u32. The subsequent bpf_map_area_alloc()
> would then allocate only 504MB, but later accesses to values[150000000]
> would be out of bounds. Should this function return u64 instead, or
> should insn_array_alloc_check() validate an upper bound on max_entries?
> 
> [ ... ]

Yes, it can now, thanks AI. (The latest verion removed the limit check
for the max_entires, set previously to 256.) I will convert types to
u64 in insn_array_alloc_size as all the call sites use u64 in any case.

> > +static int insn_array_alloc_check(union bpf_attr *attr)
> > +{
> > +	u32 value_size = sizeof(struct bpf_insn_array_value);
> > +
> > +	if (attr->max_entries == 0 || attr->key_size != 4 ||
> > +	    attr->value_size != value_size || attr->map_flags != 0)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> > +void bpf_prog_update_insn_ptrs(struct bpf_prog *prog, u32 *offsets, void *image)
> > +{
> > +	struct bpf_insn_array *insn_array;
> > +	struct bpf_map *map;
> > +	u32 xlated_off;
> > +	int i, j;
> > +
> > +	if (!offsets || !image)
> > +		return;
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
> > +
> > +			insn_array->values[j].jitted_off = offsets[xlated_off];
> > +			insn_array->ips[j] = (long)(image + offsets[xlated_off]);
> > +		}
> > +	}
> > +}
> 
> Does this handle programs with function calls correctly? When
> jit_subprogs() in the verifier splits a program with function calls, it
> creates separate bpf_prog structures for the main program and each
> subprogram. During JIT compilation, bpf_int_jit_compile() calls
> bpf_prog_update_insn_ptrs() for each subprogram separately.
> 
> However, subprograms don't have used_maps copied to their aux structure

They have. However, this change is introduced in a later commit.
One thing the robot is right about is that it should have been done
as part of this patch. Will move these chunks here.

> (see jit_subprogs() in verifier.c). So when bpf_prog_update_insn_ptrs()
> is called on a subprogram, prog->aux->used_map_cnt is 0 and the loop
> doesn't execute.
> 
> When called on the main program (func[0]), prog->len only covers the
> main program's instructions (not subprograms), so any tracked instruction
> with xlated_off >= prog->len (i.e., in a subprogram) hits the continue
> statement and doesn't get its ips[] field set.
> 
> Then bpf_insn_array_ready() checks if ips[i] is NULL and returns -EFAULT,
> causing program load to fail. Should this function iterate through all
> func[] entries and handle each subprogram, or should the main program's
> used_maps be copied to subprograms so this works as-is?
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> 
> [ ... ]
> 
> > @@ -2853,6 +2854,23 @@ static int bpf_prog_verify_signature(struct bpf_prog *prog, union bpf_attr *attr
> >  	return err;
> >  }
> >
> > +static int bpf_prog_mark_insn_arrays_ready(struct bpf_prog *prog)
> > +{
> > +	int err;
> > +	int i;
> > +
> > +	for (i = 0; i < prog->aux->used_map_cnt; i++) {
> > +		if (prog->aux->used_maps[i]->map_type != BPF_MAP_TYPE_INSN_ARRAY)
> > +			continue;
> > +
> > +		err = bpf_insn_array_ready(prog->aux->used_maps[i]);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> 
> [ ... ]
> 
> 
> ```
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> In-Reply-To-Subject: `bpf, x86: add new map type: instructions array`
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/18995945884


