Return-Path: <bpf+bounces-51194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E92DA31A2A
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 01:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A082166B70
	for <lists+bpf@lfdr.de>; Wed, 12 Feb 2025 00:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB25A957;
	Wed, 12 Feb 2025 00:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGFfO78K"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51E5A50;
	Wed, 12 Feb 2025 00:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318899; cv=none; b=sAcx4wfO5plNmmICJz3WMB2k3ZZQuFzsp74FXJfsi4/lnhLOZAiAKBuDDnWpSArXGVN1TTgEm9AmDSh1bE6L4imP2Au4Bo138gSwlsl69SFSBNvUuBfPKNM8PyINeGKpHxhX331dxDTIseHKzwUQufzDupWKH4IjPk/Chw0jj3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318899; c=relaxed/simple;
	bh=SOiiH8gjnTYqlwwhwyE7E5lB0LJ6lqMXcORsFzst4v0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3uC5QsJXPkMJYGwcdBLxu33/COm9Y33O7Z/SJmN3j7NAyr/CvSbn1CA9FU2uPToZIF2y1DJcSYgTHtvY4wlgmKMk7HPQ2FTKOPbLeOiFZiHIsQoraOoqfi2KQiNaRD0DZOcgexud1l8JVO5d1SKLLQCBF8VHo+jXnYSQJ8Mius=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGFfO78K; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2fa44590eebso7285789a91.3;
        Tue, 11 Feb 2025 16:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739318896; x=1739923696; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N5Nlmn6/JbbUIilhIlDhPJ4VAV6ahFXWJyAmErbF/kY=;
        b=RGFfO78Kcmg5RXn1YrKc97fkMqC1nPREZ5HQLjMQRbcMdRVd/c6u2ecoVspF6N+vq5
         MTKZiiMiS5dGR9pt41Z/INc49i0scS7Tr8HUs14N/wANtknU+uGlwJJ6zgn4X7SfHBeN
         mVD7UR7cMaCBoMMmaJFjLxowS8HKd7Gpgr7LlOhwJiadOfdjEwVGYFwRL2pcPt1jAc0a
         vWQrh5Gx/ip2eJ5K/IugEeotZgV2sz4+qO6SXqfeo2SllwRzdoIxZHdXzV/sJtg+Rmye
         RndsaBaQ1VccrPzExJSZ/aor/dqCkcQ/WgNfXjR44HaL1IxTgv7VpMS7kxdjppu6WmKk
         j9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318896; x=1739923696;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5Nlmn6/JbbUIilhIlDhPJ4VAV6ahFXWJyAmErbF/kY=;
        b=YHSika2IwanR0MWiKe7OyzYEcQ3nkv04Ahcx6WQX2x2fBbZMdk8tVyAVZuUNuC8Dys
         3oW0sXUG/tbXc3TJq1Tvtvs5ZTt4ouUTFdpLPIzSWoXgMkTaSHUD91apRuRFQScCOrIJ
         yAcPLPo+QLz8JgkWHJA08CvDahljlefTxAaI1M/46gwq+VdpTMF7FesJCZ+FBijLXwfE
         5HkHQtqlzy/IG6F018mGYiE7HF7PEgWsSmagXL8tMTKVY6e5w89QCMMC9GRVEfsgTC8B
         ZI9GQgvqBAykOZMbcQV3DJnAYg13jquvGQyNtVP91wzxaBKDkSGcp2+8d1XDT3pku+vx
         KzAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVFsjTljFaofKk5/TOfCK/YRBKfPL9+Po+wMhcPVz8f01R7WOcNkE38/8PRJOTjQTZVH/O9Kidlgu0QMu4@vger.kernel.org, AJvYcCXbqTUyWdyx7stX/79j4gV/Osp9qy4k/fgoWoDe5GKPH7M8+/6kIlgvc8535F2eJPoO2/0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1bdfdnX6cwk/IKq2setzKAnc7kmW8RzJdwW0kKD5EAEtCGz5t
	wcBTD4ya/8whmsB22HX7PGmRVgGMzET3SkYq9CSyTBFHUDFUCGUx
X-Gm-Gg: ASbGncui6BE7mxl28trYQcaRvyP9BhhFr4D1Aq0AXQvYNOl5zBgfU+q53gASi5s9RhE
	e8YOlKwq/p/cq3tDBFbBT+mNShCEWSNbVyjwQkA3Mz7U92ByF1Z0PyibqjqHtkPHFBrYoUY4GGC
	gnLP1PGddNtuSaXhcyrZbIC18/vHl71S8QQUQ0YhpLU5bywvu+aSzVpMT4n2KT/LvXI5rvXWIw6
	YTx6l1zRH3s8js/w/GRodh6urNYAGPNCwTaRYfZMmLzmRM39BgQXBMfJfcOhn49jv0vLKT0Qw+9
	ZSXVW/NOdvYC
X-Google-Smtp-Source: AGHT+IGu8j/EzScz0NFTYCfLtaLVKyGEmTfu1DpkFlHI3iawnU2/6heLbUWvmDL7IZ0vX/fA3qGKJw==
X-Received: by 2002:a17:90b:520e:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2fbf5c6a1b6mr1460208a91.32.1739318895906;
        Tue, 11 Feb 2025 16:08:15 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98d05cesm140479a91.18.2025.02.11.16.08.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 16:08:14 -0800 (PST)
Message-ID: <a10a2865242dc217e71de54f75fa4289aefb2fa9.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 24/26] bpf: Implement verifier support for
 rqspinlock
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra	
 <peterz@infradead.org>, Will Deacon <will@kernel.org>, Waiman Long	
 <llong@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Tejun Heo	 <tj@kernel.org>, Barret Rhoden <brho@google.com>, Josh Don
 <joshdon@google.com>,  Dohyun Kim <dohyunkim@google.com>,
 linux-arm-kernel@lists.infradead.org, kernel-team@meta.com
Date: Tue, 11 Feb 2025 16:08:09 -0800
In-Reply-To: <20250206105435.2159977-25-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
	 <20250206105435.2159977-25-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 02:54 -0800, Kumar Kartikeya Dwivedi wrote:
> Introduce verifier-side support for rqspinlock kfuncs. The first step is
> allowing bpf_res_spin_lock type to be defined in map values and
> allocated objects, so BTF-side is updated with a new BPF_RES_SPIN_LOCK
> field to recognize and validate.
>=20
> Any object cannot have both bpf_spin_lock and bpf_res_spin_lock, only
> one of them (and at most one of them per-object, like before) must be
> present. The bpf_res_spin_lock can also be used to protect objects that
> require lock protection for their kfuncs, like BPF rbtree and linked
> list.
>=20
> The verifier plumbing to simulate success and failure cases when calling
> the kfuncs is done by pushing a new verifier state to the verifier state
> stack which will verify the failure case upon calling the kfunc. The
> path where success is indicated creates all lock reference state and IRQ
> state (if necessary for irqsave variants). In the case of failure, the
> state clears the registers r0-r5, sets the return value, and skips kfunc
> processing, proceeding to the next instruction.
>=20
> When marking the return value for success case, the value is marked as
> 0, and for the failure case as [-MAX_ERRNO, -1]. Then, in the program,
> whenever user checks the return value as 'if (ret)' or 'if (ret < 0)'
> the verifier never traverses such branches for success cases, and would
> be aware that the lock is not held in such cases.
>=20
> We push the kfunc state in check_kfunc_call whenever rqspinlock kfuncs
> are invoked. We introduce a kfunc_class state to avoid mixing lock
> irqrestore kfuncs with IRQ state created by bpf_local_irq_save.
>=20
> With all this infrastructure, these kfuncs become usable in programs
> while satisfying all safety properties required by the kernel.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Apart from a few nits, I think this patch looks good.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 32c23f2a3086..ed444e44f524 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -115,6 +115,15 @@ struct bpf_reg_state {
>  			int depth:30;
>  		} iter;
> =20
> +		/* For irq stack slots */
> +		struct {
> +			enum {
> +				IRQ_KFUNC_IGNORE,

Is this state ever used?
mark_stack_slot_irq_flag() is always called with either NATIVE or LOCK.

> +				IRQ_NATIVE_KFUNC,
> +				IRQ_LOCK_KFUNC,
> +			} kfunc_class;
> +		} irq;
> +
>  		/* Max size from any of the above. */
>  		struct {
>  			unsigned long raw1;

[...]

> @@ -8038,36 +8059,53 @@ static int process_spin_lock(struct bpf_verifier_=
env *env, int regno,
>  	}
> =20
>  	rec =3D reg_btf_record(reg);
> -	if (!btf_record_has_field(rec, BPF_SPIN_LOCK)) {
> -		verbose(env, "%s '%s' has no valid bpf_spin_lock\n", map ? "map" : "lo=
cal",
> -			map ? map->name : "kptr");
> +	if (!btf_record_has_field(rec, is_res_lock ? BPF_RES_SPIN_LOCK : BPF_SP=
IN_LOCK)) {
> +		verbose(env, "%s '%s' has no valid %s_lock\n", map ? "map" : "local",
> +			map ? map->name : "kptr", lock_str);
>  		return -EINVAL;
>  	}
> -	if (rec->spin_lock_off !=3D val + reg->off) {
> -		verbose(env, "off %lld doesn't point to 'struct bpf_spin_lock' that is=
 at %d\n",
> -			val + reg->off, rec->spin_lock_off);
> +	spin_lock_off =3D is_res_lock ? rec->res_spin_lock_off : rec->spin_lock=
_off;
> +	if (spin_lock_off !=3D val + reg->off) {
> +		verbose(env, "off %lld doesn't point to 'struct %s_lock' that is at %d=
\n",
> +			val + reg->off, lock_str, spin_lock_off);
>  		return -EINVAL;
>  	}
>  	if (is_lock) {
>  		void *ptr;
> +		int type;
> =20
>  		if (map)
>  			ptr =3D map;
>  		else
>  			ptr =3D btf;
> =20
> -		if (cur->active_locks) {
> -			verbose(env,
> -				"Locking two bpf_spin_locks are not allowed\n");
> -			return -EINVAL;
> +		if (!is_res_lock && cur->active_locks) {

Nit: having '&& cur->active_locks' in this branch but not the one for
     'is_res_lock' is a bit confusing. As far as I understand this is
     just an optimization, and active_locks check could be done (or dropped=
)
     in both cases.

> +			if (find_lock_state(env->cur_state, REF_TYPE_LOCK, 0, NULL)) {
> +				verbose(env,
> +					"Locking two bpf_spin_locks are not allowed\n");
> +				return -EINVAL;
> +			}
> +		} else if (is_res_lock) {
> +			if (find_lock_state(env->cur_state, REF_TYPE_RES_LOCK, reg->id, ptr))=
 {
> +				verbose(env, "Acquiring the same lock again, AA deadlock detected\n"=
);
> +				return -EINVAL;
> +			}
>  		}

Nit: there is no branch for find_lock_state(... REF_TYPE_RES_LOCK_IRQ ...),
     this is not a problem, as other checks catch the imbalance in
     number of unlocks or unlock of the same lock, but verifier won't
     report the above "AA deadlock" message for bpf_res_spin_lock_irqsave()=
.

The above two checks make it legal to take resilient lock while
holding regular lock and vice versa. This is probably ok, can't figure
out an example when this causes trouble.

> -		err =3D acquire_lock_state(env, env->insn_idx, REF_TYPE_LOCK, reg->id,=
 ptr);
> +
> +		if (is_res_lock && is_irq)
> +			type =3D REF_TYPE_RES_LOCK_IRQ;
> +		else if (is_res_lock)
> +			type =3D REF_TYPE_RES_LOCK;
> +		else
> +			type =3D REF_TYPE_LOCK;
> +		err =3D acquire_lock_state(env, env->insn_idx, type, reg->id, ptr);
>  		if (err < 0) {
>  			verbose(env, "Failed to acquire lock state\n");
>  			return err;
>  		}
>  	} else {
>  		void *ptr;
> +		int type;
> =20
>  		if (map)
>  			ptr =3D map;

[...]


