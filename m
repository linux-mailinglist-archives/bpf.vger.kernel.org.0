Return-Path: <bpf+bounces-45411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B43D9D53E8
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 21:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B63D0B23725
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5F1D5157;
	Thu, 21 Nov 2024 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkyW/0gJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEB843AA1
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732220470; cv=none; b=W4rnUvF5QjshXKlt3dWJxfycKHk1u2E3+iGRvWhQk1FbBy8Nd/kglzTU5yLmZmkob5TsUOuTfsQYtmN02qxMdOl5JJYnkYVRkuRvGu7HO99gk5wp+woCf7lIO7jP4qluACuVmMMvAw6yQ5xAI4X0KEZBa8k5jWarOcjVW0/KRG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732220470; c=relaxed/simple;
	bh=d3Z97F88nILCk3ZGfgFMB22Ulk9JFXwSfRf7CEYMmUg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o8CY0VrknwfOAKBxlhx9s2EgEUVSlEKNpV6EPbKNITs+x1byxuzdNqZ6zlDyQP7Vs+8gToU2RD8J3Eo2k8nUnrJIDQrDQKFa0oA4/diK38J8U0vCQ6cHfWkxY27eEgK/nwKYsXVbKkNK1Uhs7EaUzK2ljKOQ2qhLgTNMI3eoxbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkyW/0gJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7248c1849bdso1419447b3a.3
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 12:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732220468; x=1732825268; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SLC+PApReZLOEgNPWheVo82I0O60Tq8pui30yy0WjZc=;
        b=ZkyW/0gJoxbHaqfcZagoAoOCNhbJ71rcEPFw8YvyJZvJnOq7vr9Kd3AEmo/1k4VHYd
         mK8bivflfrn1/Fkhr3i0eERuFMQWngnuLdmXYUZiCmm8agzctJYvKv1Wkuc/Q5xZt1//
         BwIjfbzt6qeBKXsYgCcFao+DudkUdI6uxGJznkEoSVj3ShD1sy/eLZhEqjjV4u3mSIED
         W2uoJbZqTH6yy4L93F0wdIxeVmbHoDyPwG3mB99gQhS55F84WawW8ZpK8jpj2FOALT+Z
         rN3dzfGkYOIE9IFtfkHGvJqdz8wGfx6dbIYKBjKnivKFCvhEHVcDpU7Wt1QMaxTEj3Us
         UUMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732220468; x=1732825268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SLC+PApReZLOEgNPWheVo82I0O60Tq8pui30yy0WjZc=;
        b=ML51s/B/O/VbQiu5zcfXBcjrjJvyvgrT/qSLIVWrWF8f8T4tNNtXxcxta4yRbhvOAI
         99ng7sdULFU5G28Nl9f1wuIFIx/k7+WbfM/W3T2YwNgZPufgQBWWn3uXDz5d1389j01j
         nUuzSFf3KMK1Q4rVStKWPFWghWmUr4ZKVEebIJZKrTyxoNuIX32r4Vb7+bZnD6ySP4zT
         IcTwkL/EJ2VFFrPNl/spanNy+yNbBNXP2T/579JdG0lw+QQH21XbVD3Ywi4bqj6PKugM
         EYzKOv4kra+FuvYwkSvMhB3vEpIJWUzrB7MeKzuyth4iH8psz8vBPJ9+s6WnBtEue3T9
         pAQg==
X-Forwarded-Encrypted: i=1; AJvYcCVkfdgl+9kQsiXUO9U4M0yXQGJ7QffFv8tYWzPev/nyNVrw3VWALxsmacTEecASQlKpNOs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/ci2KUpN//2Lo8JFoidhjK3IptgxbJn9+A7cEAy1aURaT/Cka
	rbwF5AWYZyCgAAIwk9z0g+rWeN3w3rMJ1FGFndxMS7QP2DlIXaVF
X-Gm-Gg: ASbGncsHU/NKdds+W6rVqilmzECm2IIwKd4P5GrqAuVYkVhyRI3OOyLIs6ucPtWl5Lc
	WivFEyCnI/f5YvqYlLeJpN69ImGDryHyPidbIefUpH8n4J5U7EjyceHm22KRtcQ+kTEnhWa5OJh
	/sytZXjcBx8uVHqmbrAQ2KL4p4CNASVA0JcElmJNkzP2U2csj04Bq2n4laRLHiZBJJcG1n9ZdGl
	o/ilUo72QFS7/cl/WQ03ZNe31LlqDrxqdrxxET7iHt8NkI=
X-Google-Smtp-Source: AGHT+IEMA39ioZFKR25J9PV+saxJwIAQj7Sm9fz0eKhvuWsfankH7roCXY9vqHTSulPoPRRIvduglg==
X-Received: by 2002:a17:90b:38c9:b0:2ea:61de:3903 with SMTP id 98e67ed59e1d1-2eb0e865fe5mr162180a91.27.1732220468463;
        Thu, 21 Nov 2024 12:21:08 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ead02ea680sm3688939a91.8.2024.11.21.12.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 12:21:07 -0800 (PST)
Message-ID: <c49e756f6e4ef492a68b7cd3b856240282963f8e.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 5/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 12:21:02 -0800
In-Reply-To: <20241121005329.408873-6-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-6-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> Teach the verifier about IRQ-disabled sections through the introduction
> of two new kfuncs, bpf_local_irq_save, to save IRQ state and disable
> them, and bpf_local_irq_restore, to restore IRQ state and enable them
> back again.
>=20
> For the purposes of tracking the saved IRQ state, the verifier is taught
> about a new special object on the stack of type STACK_IRQ_FLAG. This is
> a 8 byte value which saves the IRQ flags which are to be passed back to
> the IRQ restore kfunc.
>=20
> To track a dynamic number of IRQ-disabled regions and their associated
> saved states, a new resource type RES_TYPE_IRQ is introduced, which its
> state management functions: acquire_irq_state and release_irq_state,
> taking advantage of the refactoring and clean ups made in earlier
> commits.
>=20
> One notable requirement of the kernel's IRQ save and restore API is that
> they cannot happen out of order. For this purpose, resource state is
> extended with a new type-specific member 'prev_id'. This is used to
> remember the ordering of acquisitions of IRQ saved states, so that we
> maintain a logical stack in acquisition order of resource identities,
> and can enforce LIFO ordering when restoring IRQ state. The top of the
> stack is maintained using bpf_func_state's active_irq_id.
>=20
> The logic to detect initialized and unitialized irq flag slots, marking
> and unmarking is similar to how it's done for iterators. We do need to
> update ressafe to perform check_ids based satisfiability check, and
> additionally match prev_id for RES_TYPE_IRQ entries in the resource
> array.
>=20
> The kfuncs themselves are plain wrappers over local_irq_save and
> local_irq_restore macros.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

I think this matches what is done for iterators and dynptrs.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -263,10 +267,16 @@ struct bpf_resource_state {
>  	 * is used purely to inform the user of a resource leak.
>  	 */
>  	int insn_idx;
> -	/* Use to keep track of the source object of a lock, to ensure
> -	 * it matches on unlock.
> -	 */
> -	void *ptr;
> +	union {
> +		/* Use to keep track of the source object of a lock, to ensure
> +		 * it matches on unlock.
> +		 */
> +		void *ptr;
> +		/* Track the reference id preceding the IRQ entry in acquisition
> +		 * order, to enforce an ordering on the release.
> +		 */
> +		int prev_id;
> +	};

Nit:  Do we anticipate any other resource kinds that would need LIFO acquir=
e/release?
      If we do, an alternative to prev_id would be to organize bpf_func_sta=
te->res as
      a stack (by changing erase_resource_state() implementation).

[...]

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 751c150f9e1c..302f0d5976be 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3057,6 +3057,28 @@ __bpf_kfunc int bpf_copy_from_user_str(void *dst, =
u32 dst__sz, const void __user
>  	return ret + 1;
>  }
> =20
> +/* Keep unsinged long in prototype so that kfunc is usable when emitted =
to
> + * vmlinux.h in BPF programs directly, but since unsigned long may poten=
tially
> + * be 4 byte, always cast to u64 when reading/writing from this pointer =
as it
> + * always points to an 8-byte memory region in BPF stack.
> + */
> +__bpf_kfunc void bpf_local_irq_save(unsigned long *flags__irq_flag)

Nit: 'unsigned long long' is guaranteed to be at-least 64 bit.
     What would go wrong if 'u64' is used here?

> +{
> +	u64 *ptr =3D (u64 *)flags__irq_flag;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	*ptr =3D flags;
> +}

[...]

> @@ -1447,7 +1607,7 @@ static struct bpf_resource_state *find_lock_state(s=
truct bpf_func_state *state,
>  	for (i =3D 0; i < state->acquired_res; i++) {
>  		struct bpf_resource_state *s =3D &state->res[i];
> =20
> -		if (s->type =3D=3D RES_TYPE_PTR || s->type !=3D type)
> +		if (s->type < __RES_TYPE_LOCK_BEGIN || s->type !=3D type)

Nit: I think this would be easier to read if there was a bitmask
     associated with lock types.

>  			continue;
> =20
>  		if (s->id =3D=3D id && s->ptr =3D=3D ptr)

[...]


