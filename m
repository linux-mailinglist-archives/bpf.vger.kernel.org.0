Return-Path: <bpf+bounces-45810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D229DB22F
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 652681673E3
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E8213777E;
	Thu, 28 Nov 2024 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxuIYt0Q"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9317C322B
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732768317; cv=none; b=L1hGzvyAfmkI/HI22Xu7+34DIQjXWaGcYLg8LPVBXm8JDK1ZUQiIMknDFBpC7NCKhf+yvlI/92Fzkb0kjoowWONQ0b/fJt4X7R+10wL959SDEMrFhHCjkKxTzhxVPQDkByMPiTBCmqjvp7nqK5YHKBdbegQCGKSv2JpUxypb7gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732768317; c=relaxed/simple;
	bh=P8Bjb6lbm5aOCSAIt6H35G2xFVyku0vpmgKytuKKz6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tk4fVQ6sBM3esBmvzJCNjiMsW4RQUUtmiaQe0RnS5rBIaQVno73DQbSbozuHOET6RTk/Oqhk3q87v/TNZPXoJV6BJdbCoP1xA4c98Umdzsb01xN7t9nbQo4s7+SsYU4PGP7UuQ2bG/pBAFG4d1LOdsBKbOvbkMGZ/npd/Dfldvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BxuIYt0Q; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2129fd7b1a5so3249875ad.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732768315; x=1733373115; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BJKFYMbw7iCB1oS4WEMpdB9mEcFKyoKK6thPetpaPnY=;
        b=BxuIYt0Qy4XtZITURuBGubiHLll82qhcaz6K57xp/VI7ypS4ixEk67v5GXig2CA0DK
         RUOjXwUdZ33FL054Y7bTPcnpAxFGbSfMQMe1D0DKIDXBNV/OVrecPfdgCO4u5q8nTlqN
         t5qwg0vAxwyLdPay2eHMVFMbyzbK0pVFfKXqlndH7QIc8Rc6zUiF6kgX55wQaKziWBul
         SE0NZBr+E4Z5DfLn+YMIdUav9dTTWWIwkQ88jOVkUdQELALpZDufXHi+Dw4QmsX+hMRu
         jbJtf7hynmCfLWeuEpatRvqLnsJuRg53XYB2CMYjFHRqQ12aYLq6ugBC6khc09Juxwjk
         GjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732768315; x=1733373115;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BJKFYMbw7iCB1oS4WEMpdB9mEcFKyoKK6thPetpaPnY=;
        b=Aom9li716VBTm1q2jxKW9f62r52UbT0OExZxfNaBsp4APhHpuoOd5Vkzx5JmWxrlLT
         kGJ1ZkDiYzJ+5vhAzOljcfzls9NPLf+Vf/kZ7As7w9KxqoncVftt49ncIUTpZnle5Mqn
         WNYQqG0LxxZaFQcaJjrOgk2ExGiakluNhrXr+yG1BRqPNfiz10zgF+b9OOSIBHAPm/mA
         bGjFcLOFds7DAZORPGJwgkjOVWr8VfoDbrYwfbC2bkMgIcvUpMFPV/x3cl8YQrpo9bWu
         2Buz9Ow+hZEwN9YRPycpGEMjY94300hQPDOt3olA97j3ds03jDyKfC3r/enoHcOOS+ml
         kMMg==
X-Forwarded-Encrypted: i=1; AJvYcCXlM8fZCMjfAd2vaMDtZS1xui1SPeNAkpJLK9GxVYojenoD/9LiInzSqTXz4o8gsL8ACCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiwPZ+deiiTl9DWFbtuS1JsOFK/Tdqt0rep0iAj38AY6f6nEv
	7aiD1uZJMZ4sX+jHrzqdRS4CPZRAZKnzS0Fynm8bQ+biMey1VJME
X-Gm-Gg: ASbGnctA/lZg8Lg1+4e63d3I4wXkqnom9WEslQy0snR1sEJbifCndJOj0d15SUUhqlv
	cpFY8V15mLCsioZAFM2wcgvwNECAMZJqcBJWym/n7I732J3NJnKFcPNnvr9wXMrQzrC3e+v848w
	v24W0nOBFXrg7E+XJmrWhYqIVzuBQap4bJWz9nZRyz9b5almwqp4B0d6TLDNXckzrVowq84k9ku
	N3LPaoBgPBtkBNv7OZs1Si6vjtOWMCq1ztaMfo4jIYjToY=
X-Google-Smtp-Source: AGHT+IEmBNYhPwpMUgSQWJ3nctPKCzL2960sLKzbJd3mJG46IUcKBe7XkQf1vvOBMJHVf24/OxUk5A==
X-Received: by 2002:a17:902:c945:b0:20c:5bf8:bd6e with SMTP id d9443c01a7336-21501f68618mr71147315ad.48.1732768314675;
        Wed, 27 Nov 2024 20:31:54 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521985773sm3927385ad.199.2024.11.27.20.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:31:54 -0800 (PST)
Message-ID: <8559a9a9892311772778268eb9cee7c533a576d0.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf: Introduce support for
 bpf_local_irq_{save,restore}
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, kernel-team@fb.com
Date: Wed, 27 Nov 2024 20:31:49 -0800
In-Reply-To: <20241127165846.2001009-5-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 08:58 -0800, Kumar Kartikeya Dwivedi wrote:
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
> Renumber the enums for REF_TYPE_* to simplify the check in
> find_lock_state, filtering out non-lock types as they grow will become
> cumbersome and is unecessary.
>=20
> To track a dynamic number of IRQ-disabled regions and their associated
> saved states, a new resource type RES_TYPE_IRQ is introduced, which its
> state management functions: acquire_irq_state and release_irq_state,
> taking advantage of the refactoring and clean ups made in earlier
> commits.
>=20
> One notable requirement of the kernel's IRQ save and restore API is that
> they cannot happen out of order. For this purpose, when releasing referen=
ce
> we keep track of the prev_id we saw with REF_TYPE_IRQ. Since reference
> states are inserted in increasing order of the index, this is used to
> remember the ordering of acquisitions of IRQ saved states, so that we
> maintain a logical stack in acquisition order of resource identities,
> and can enforce LIFO ordering when restoring IRQ state. The top of the
> stack is maintained using bpf_verifier_state's active_irq_id.
>=20
> The logic to detect initialized and unitialized irq flag slots, marking
> and unmarking is similar to how it's done for iterators. No additional
> checks are needed in refsafe for REF_TYPE_IRQ, apart from the usual
> check_id satisfiability check on the ref[i].id. We have to perform the
> same check_ids check on state->active_irq_id as well.
>=20
> The kfuncs themselves are plain wrappers over local_irq_save and
> local_irq_restore macros.
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Sorry, two more nits below.

[...]

> +static int unmark_stack_slot_irq_flag(struct bpf_verifier_env *env, stru=
ct bpf_reg_state *reg)
> +{
> +	struct bpf_func_state *state =3D func(env, reg);
> +	struct bpf_stack_state *slot;
> +	struct bpf_reg_state *st;
> +	int spi, i, err;
> +
> +	spi =3D irq_flag_get_spi(env, reg);
> +	if (spi < 0)
> +		return spi;
> +
> +	slot =3D &state->stack[spi];
> +	st =3D &slot->spilled_ptr;
> +
> +	err =3D release_irq_state(env->cur_state, st->ref_obj_id);
> +	WARN_ON_ONCE(err && err !=3D -EACCES);
> +	if (err) {
> +		verbose(env, "cannot restore irq state out of order\n");

Nit: maybe also print acquire_irq_id and an instruction where it was acquir=
ed?

> +		return err;
> +	}
> +
> +	__mark_reg_not_init(env, st);
> +
> +	/* see unmark_stack_slots_dynptr() for why we need to set REG_LIVE_WRIT=
TEN */
> +	st->live |=3D REG_LIVE_WRITTEN;
> +
> +	for (i =3D 0; i < BPF_REG_SIZE; i++)
> +		slot->slot_type[i] =3D STACK_INVALID;
> +
> +	mark_stack_slot_scratched(env, spi);
> +	return 0;
> +}
> +
> +static bool is_irq_flag_reg_valid_uninit(struct bpf_verifier_env *env, s=
truct bpf_reg_state *reg)
> +{
> +	struct bpf_func_state *state =3D func(env, reg);
> +	struct bpf_stack_state *slot;
> +	int spi, i;
> +
> +	/* For -ERANGE (i.e. spi not falling into allocated stack slots), we
> +	 * will do check_mem_access to check and update stack bounds later, so
> +	 * return true for that case.
> +	 */
> +	spi =3D irq_flag_get_spi(env, reg);
> +	if (spi =3D=3D -ERANGE)
> +		return true;

Nit: is it possible to swap is_irq_flag_reg_valid_uninit() and
     check_mem_access(), so that ERANGE special case would be not needed?

> +	if (spi < 0)
> +		return false;
> +
> +	slot =3D &state->stack[spi];
> +
> +	for (i =3D 0; i < BPF_REG_SIZE; i++)
> +		if (slot->slot_type[i] =3D=3D STACK_IRQ_FLAG)
> +			return false;
> +	return true;
> +}

[...]


