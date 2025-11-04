Return-Path: <bpf+bounces-73477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C43C32784
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 18:56:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B023BC63B
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 17:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94410279DA2;
	Tue,  4 Nov 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4sz7gmL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501F33BBDC;
	Tue,  4 Nov 2025 17:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278895; cv=none; b=RUHiQr36HkKVaAWENgNNNBCGiICDVSEGinmny/0laRka9HRZr/u4jZ3fTe8Hr5q1ljmcPAayswZbBqyJm6cHBIULClwBxjZ0u/pa2gw5kklfsK3UywknhvkulCZkx4yDnDKvN94f/8HvgiDX4xO2KOynnz0DV/r3vM/QcSIVftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278895; c=relaxed/simple;
	bh=NswZYZJCmI+sWPtjL3n0khZGAn5kVnjdknLatIP4M8I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MU1nMT1jKEP1RXl2ueYA9cLCN7HWEUYEVoHr7K33iRpew89kdZ9DRUHsJdAWgmINzsLi0F0ygS1RRaPHEZrRLl+j8XkYRnKannUe+o8f1xCVxwu7TKdLPiGUCLVrkla18axf70hoxfRsk08xzZEU0ue5AnB8NER0LdX3wraA8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4sz7gmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5470C4CEF7;
	Tue,  4 Nov 2025 17:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762278894;
	bh=NswZYZJCmI+sWPtjL3n0khZGAn5kVnjdknLatIP4M8I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=K4sz7gmLPydAmHDGzrJip2R2ldcu5W+YzcYvJKq8jTjhlxFw1YRyG0xYWoxLQrldk
	 icqNBWmrg9yKV1Z72qsXKXnR9m1r8FCg+9IbMDUwAtzoQQnbIGTNSza5NHYzgP0pEH
	 wdmhy1h/RRGaFWtAmgsz0VGDt9NTI5p8LO6422DLIQUzUaAfHaeNEpt9Lzu0SQRMJ6
	 YGv0h9phaGomjqiCJyjD2s2mFptgXQD6/x5UHCIcA5/hhl3n7Sg1ClCU0Q5HmbZfe+
	 K3MhuOOZymcHUpwqdmCQTpSmjlpxZ0YyLNxtCgpH7t5BWjcq63bgEWhixzrKmpK1Ee
	 /ryqXRPVZAg3g==
Content-Type: multipart/mixed; boundary="===============4486680838687049863=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e9468bb9f2cc62c69d9364a4ce2ab5ee08fafa6576d6be6a121b04a80a379094@mail.kernel.org>
In-Reply-To: <20251104172652.1746988-3-ameryhung@gmail.com>
References: <20251104172652.1746988-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Support associating BPF program with struct_ops
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,tj@kernel.org,martin.lau@kernel.org,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  4 Nov 2025 17:54:54 +0000 (UTC)

--===============4486680838687049863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a47d67db3..0f71030c0 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h

[ ... ]

> @@ -2026,6 +2028,9 @@ static inline void bpf_module_put(const void *data, struct module *owner)
>  		module_put(owner);
>  }
>  int bpf_struct_ops_link_create(union bpf_attr *attr);
> +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map);
> +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog);
> +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux);
>  u32 bpf_struct_ops_id(const void *kdata);

[ ... ]

> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index a41e6730e..0a19842da 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c

[ ... ]

> @@ -1394,6 +1413,77 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
>  	return err;
>  }
>
> +int bpf_prog_assoc_struct_ops(struct bpf_prog *prog, struct bpf_map *map)
> +{
> +	struct bpf_map *st_ops_assoc;
> +
> +	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +	st_ops_assoc = prog->aux->st_ops_assoc;
> +
> +	if (st_ops_assoc && st_ops_assoc == map)
> +		return 0;
> +
> +	if (st_ops_assoc) {
> +		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +			return -EBUSY;
> +
> +		WRITE_ONCE(prog->aux->st_ops_assoc, BPF_PTR_POISON);
> +	} else {
> +		if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +			bpf_map_inc(map);
> +
> +		WRITE_ONCE(prog->aux->st_ops_assoc, map);
> +	}
> +
> +	return 0;
> +}
> +
> +void bpf_prog_disassoc_struct_ops(struct bpf_prog *prog)
> +{
> +	struct bpf_map *st_ops_assoc;
> +
> +	guard(mutex)(&prog->aux->st_ops_assoc_mutex);
> +
> +	st_ops_assoc = prog->aux->st_ops_assoc;
> +
> +	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
> +		return;
> +
> +	if (prog->type != BPF_PROG_TYPE_STRUCT_OPS)
> +		bpf_map_put(st_ops_assoc);
> +
> +	WRITE_ONCE(prog->aux->st_ops_assoc, NULL);
> +}
> +
> +/*
> + * Get a reference to the struct_ops struct (i.e., kdata) associated with a
> + * program.
> + *
> + * If the returned pointer is not NULL, it must points to a valid and
> + * initialized struct_ops. The struct_ops may or may not be attached.
> + * Kernel struct_ops implementers are responsible for tracking and checking
> + * the state of the struct_ops if the use case requires an attached struct_ops.
> + */
> +void *bpf_prog_get_assoc_struct_ops(const struct bpf_prog_aux *aux)
> +{
> +	struct bpf_map *st_ops_assoc = READ_ONCE(aux->st_ops_assoc);
> +	struct bpf_struct_ops_map *st_map;
> +
> +	if (!st_ops_assoc || st_ops_assoc == BPF_PTR_POISON)
> +		return NULL;
> +
> +	st_map = (struct bpf_struct_ops_map *)st_ops_assoc;
> +
> +	if (smp_load_acquire(&st_map->kvalue.common.state) == BPF_STRUCT_OPS_STATE_INIT) {
> +		bpf_map_put(st_ops_assoc);
                ^^^^

Does bpf_prog_get_assoc_struct_ops() need to call bpf_map_put() here?

The function comment says "Get a reference to the struct_ops struct"
but the function never calls bpf_map_get/inc() to acquire a reference.
It only reads aux->st_ops_assoc via READ_ONCE().

When the state check fails (INIT state), the function calls bpf_map_put()
which drops the reference that was acquired in bpf_prog_assoc_struct_ops().
But on the success path below, it returns kdata without any refcount
operation.

This creates an imbalance:
- INIT state path: drops a reference, returns NULL
- Non-INIT path: no refcount change, returns kdata

The caller has no way to know whether the reference count was modified.
Also, the function is EXPORTED but doesn't document the reference counting
semantics clearly.

> +		return NULL;
> +	}
> +
> +	return &st_map->kvalue.data;
> +}
> +EXPORT_SYMBOL_GPL(bpf_prog_get_assoc_struct_ops);

Can this function race with bpf_prog_disassoc_struct_ops()?

Since bpf_prog_get_assoc_struct_ops() reads aux->st_ops_assoc via
READ_ONCE() without holding the mutex or acquiring a reference, there's
a window where:

Thread A: reads st_ops_assoc pointer
Thread B: calls bpf_prog_disassoc_struct_ops()->bpf_map_put() (drops last ref)
Thread A: dereferences st_map->kvalue.common.state (use-after-free)

For non-struct_ops programs, bpf_prog_assoc_struct_ops() holds a
reference via bpf_map_inc(). This reference is dropped in
bpf_prog_disassoc_struct_ops() when the program is freed. Without
acquiring a new reference in bpf_prog_get_assoc_struct_ops(), the map
can be freed during the race window above.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/19077679684

--===============4486680838687049863==--

