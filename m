Return-Path: <bpf+bounces-45807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A76ED9DB211
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 05:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6867728278B
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 04:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8757D1369AE;
	Thu, 28 Nov 2024 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7UWdXCz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A038134BD
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732767214; cv=none; b=rLJ4btu0K9FYIBAiWXQgxsMY6Xj5v2hktNtYIbzvXIDwctPicGf6WZFWH4MEgobvlmXN1irChUlOsrjR7na5fzHoh/Z4oh/J3w6RrxQDfiM+cMePBQlRcNMNYNVLbFSQTObnBouYh21dGv6i4kDKwTVuWRVOgq6Rr0j1b6HRmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732767214; c=relaxed/simple;
	bh=HcbKp7BBFPYS9Qniu0p6mWDzmi6ea/Povn2qqiEcVGA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EYpkiGUuhqi0L34okFS3q7fmiR5mv750Z+Fa3AZcXLRknlTfect5mJMoRGtVB6UG8sKCX+ieKEDG1uTWmC1l4JAnFdnj/65RkqfvtC7X3YLT1or6pJRplKUHhDM2mBw0ZZRxsdzMSYXMDEHBK2STGpL5BtA0dbvGAhg3r+YvPCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7UWdXCz; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724ffe64923so478783b3a.2
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 20:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732767212; x=1733372012; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hGvbgDTyoAL6tiw35sKSH1L6USmsKhStuFzk1pO8Wgc=;
        b=W7UWdXCz7LLpBW48j/h7eXZUQYe868HYx2wciLWA4iQ3+XyHkyuu+TrFUy785vSKMx
         L8dgDOnan/Q9BRjlKv32ulq0AEq6jeu+poRp0fQHjWMxUWB7A5RGjA4v6XeZ/bzirGwp
         b3VO0fip3EnAEM4anwP66hlW1esoti97CvipSe8qoFusIB1PWNjX+0Btcb5ms0HQlsA1
         CQnn4nOq6J+q6gjZsWBrKWQ29qEOI76fL3dCUnpgy9lcUbCVckZCmAV3q+eSt9XUR/8m
         iPE7IdgO8rFml6xSK6b+pheZOTGeW4WMidT8HHBJy8w9J8eOURweZgNDKbjNpDfY0FBd
         BNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732767212; x=1733372012;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGvbgDTyoAL6tiw35sKSH1L6USmsKhStuFzk1pO8Wgc=;
        b=H/5jbKXi73dNxpjtQkm6zE/yPX7NaWth6JEn4hJJhM97GqedSbDf5npdzskA7lq4qX
         xLMn9qepSJGq0mKAbDsC7UtoV6zRBD7QjR9k28Xd1yIJ38MNtU5l28x2t3nHwkpbKFRN
         wNJyyI3Rlc+FvTVob64PG8VNWDLt9eUJHZNWu5XEwD8Q203rxVCdyOCNKnvF67IQXVFC
         HR1PVd+lNXxnJrCF9ODCEPp5L7YVtxMEg6CEXuMtwgfRjL7YHUvQ9z8DyHjt3e/NTxGZ
         fVpaxM4hFygSoXAKbRrgJzskd6UcH6NTHfyK5Sr/jFHwmKtwoJa++R0rsR8JxBtogpvN
         L8og==
X-Forwarded-Encrypted: i=1; AJvYcCUAiULogBKuEfcyiG7aWmu85Smim7qhc7dCcsII8XlJzVEiojwgY93m49GKdn9ij8ehzPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3sy+h5ofoX+oeWtDPptu4690B5OepIO5OvfEQxnXneUtF+ew
	3Dgl1DsPMmw542E/u0Pael7h0kCdI90Jen5pS30rCLdiwm1KdKW0
X-Gm-Gg: ASbGnctS9RhnzqfaxVe/ZD3CMCxl7gwgv5lYyMgtRh4/bUZeRjpqbjTO8EEC4DJp6mh
	lePXholcuh/3NpDAtlNAgn/J1g9+bL5qaaBGhZp+zQzyVv5rragblHvCJLmok/ioOVYidh4kUYK
	ziGIX932NG7GCjb3vXquAzKXJQzFpMKY9slLQpxFfAd4OZu2yrXJkkL1nn+MHfylmmJYhCbyJzT
	h3/p5mGeaHMgiUOAo8wMdAgTOurZHSeTfii/ySCdVnUJGM=
X-Google-Smtp-Source: AGHT+IHcoiVQylQ152hFQJIvF+Jps+a0dJvC+xcYZfkH7J9XCWh71fPscBmpHgsmC+R4NR95Q5DL1A==
X-Received: by 2002:a17:902:ea02:b0:20c:e8df:251a with SMTP id d9443c01a7336-21501d65b31mr55790335ad.45.1732767211770;
        Wed, 27 Nov 2024 20:13:31 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219afd1asm3632155ad.228.2024.11.27.20.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 20:13:31 -0800 (PST)
Message-ID: <0b2e84f96227c62ef4da7eda44ee31d42800fccd.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf: Refactor
 {acquire,release}_reference_state
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko	
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau	 <martin.lau@kernel.org>, kernel-team@fb.com
Date: Wed, 27 Nov 2024 20:13:26 -0800
In-Reply-To: <20241127165846.2001009-3-memxor@gmail.com>
References: <20241127165846.2001009-1-memxor@gmail.com>
	 <20241127165846.2001009-3-memxor@gmail.com>
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

Overall looks good, but please take a look at a few notes below.

[...]

> @@ -1349,77 +1350,69 @@ static int grow_stack_state(struct bpf_verifier_e=
nv *env, struct bpf_func_state
>   * On success, returns a valid pointer id to associate with the register
>   * On failure, returns a negative errno.
>   */
> -static int acquire_reference_state(struct bpf_verifier_env *env, int ins=
n_idx)
> +static struct bpf_reference_state *acquire_reference_state(struct bpf_ve=
rifier_env *env, int insn_idx, bool gen_id)
>  {
>  	struct bpf_verifier_state *state =3D env->cur_state;
>  	int new_ofs =3D state->acquired_refs;
> -	int id, err;
> +	int err;
> =20
>  	err =3D resize_reference_state(state, state->acquired_refs + 1);
>  	if (err)
> -		return err;
> -	id =3D ++env->id_gen;
> -	state->refs[new_ofs].type =3D REF_TYPE_PTR;
> -	state->refs[new_ofs].id =3D id;
> +		return NULL;
> +	if (gen_id)
> +		state->refs[new_ofs].id =3D ++env->id_gen;

Nit: state->refs[new_ods].id might end up with garbage value if 'gen_id' is=
 false.
     The resize_reference_state() uses realloc_array(),
     which allocates memory with GFP_KERNEL, but without __GFP_ZERO flag.
     This is not a problem with current patch, as you always check
     reference type before checking id, but most of the data strucures
     in verifier are zero initialized just in case.

>  	state->refs[new_ofs].insn_idx =3D insn_idx;
> =20
> -	return id;
> +	return &state->refs[new_ofs];
> +}

[...]

> -/* release function corresponding to acquire_reference_state(). Idempote=
nt. */
> -static int release_reference_state(struct bpf_verifier_state *state, int=
 ptr_id)
> +static void release_reference_state(struct bpf_verifier_state *state, in=
t idx)
>  {
> -	int i, last_idx;
> +	int last_idx;
> =20
>  	last_idx =3D state->acquired_refs - 1;
> -	for (i =3D 0; i < state->acquired_refs; i++) {
> -		if (state->refs[i].type !=3D REF_TYPE_PTR)
> -			continue;
> -		if (state->refs[i].id =3D=3D ptr_id) {
> -			if (last_idx && i !=3D last_idx)
> -				memcpy(&state->refs[i], &state->refs[last_idx],
> -				       sizeof(*state->refs));
> -			memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> -			state->acquired_refs--;
> -			return 0;
> -		}
> -	}
> -	return -EINVAL;
> +	if (last_idx && idx !=3D last_idx)
> +		memcpy(&state->refs[idx], &state->refs[last_idx], sizeof(*state->refs)=
);
> +	memset(&state->refs[last_idx], 0, sizeof(*state->refs));
> +	state->acquired_refs--;
> +	return;
>  }

Such implementation replaces element at 'idx' with element at 'last_idx'.
If the intention is to use 'state->refs' as a stack of acquired irq flags,
the stack property would be broken by this trick.
E.g. consider array [a, b, c, d] where 'idx' points to 'b',
after release_reference_state() the array would become [a, d, c].
You need to do 'memmove' instead.

[...]

> @@ -9666,21 +9659,41 @@ static void mark_pkt_end(struct bpf_verifier_stat=
e *vstate, int regn, bool range
>  		reg->range =3D AT_PKT_END;
>  }
> =20
> +static int release_reference_nomark(struct bpf_verifier_state *state, in=
t ref_obj_id)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < state->acquired_refs; i++) {
> +		if (state->refs[i].type !=3D REF_TYPE_PTR)
> +			continue;
> +		if (state->refs[i].id =3D=3D ref_obj_id) {
> +			release_reference_state(state, i);
> +			return 0;
> +		}
> +	}
> +	return -EINVAL;
> +}
> +
>  /* The pointer with the specified id has released its reference to kerne=
l
>   * resources. Identify all copies of the same pointer and clear the refe=
rence.
> + *
> + * This is the release function corresponding to acquire_reference(). Id=
empotent.
> + * The 'mark' boolean is used to optionally skip scrubbing registers mat=
ching
          ^^^^^^
Nit: this is probably a remnant of some older patch revision,
     function no longer takes 'mark' parameter.

> + * the ref_obj_id, in case they need to be switched to some other type i=
nstead
> + * of havoc scalar value.
>   */
> -static int release_reference(struct bpf_verifier_env *env,
> -			     int ref_obj_id)
> +static int release_reference(struct bpf_verifier_env *env, int ref_obj_i=
d)
>  {

[...]


