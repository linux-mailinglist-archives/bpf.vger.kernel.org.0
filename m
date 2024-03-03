Return-Path: <bpf+bounces-23272-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C436A86F576
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0B9E1C20A63
	for <lists+bpf@lfdr.de>; Sun,  3 Mar 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91665A0F2;
	Sun,  3 Mar 2024 14:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lhYve8ns"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19A8A957
	for <bpf@vger.kernel.org>; Sun,  3 Mar 2024 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709475151; cv=none; b=Q4iU8p8aied02tUiPf5pZXGq8dvE8XRj8p0i14iy3gtMoDbnaaFEGm74B2O6t45SNHoo8WBjvnHm4QpXsm8SVvPE3DGxpKx2hX05HiynNTNrKlgcXDI63vtZ8T+s3doY7MCqGAL5R2nPqNGu+wuqt8vylWEZZAuiuvrSQtaob6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709475151; c=relaxed/simple;
	bh=tNF8GyI53oDnAG6hBZOFTiSzfJXmr+VAx0U+L7Kqhq8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QyBHsYpezxG/fTWwOZU+UztIapKLHRm4X1EAGqbBn9Kn5gTZeX2bHU3ANMaYTXiH0TpD1jZGGVlfdPagaNplINQfb+/TIA9sPdY9XOiw1w+kgZxgnb7X/vhkXWFaMugOs1wQWi7SZLpKp0thfM1qjOKpLCHkLEosDk6coEYb5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lhYve8ns; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56694fdec74so4236883a12.1
        for <bpf@vger.kernel.org>; Sun, 03 Mar 2024 06:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709475148; x=1710079948; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+HiEyhU0EypI+vfh4OJIbB6KGSmkaOA0tY5aLw7P7HE=;
        b=lhYve8nsEwG0X938eKGZ1TeND1ueUFGNJuuAdLwNF0YcGvhBKRgI9UePp7cK4fGnSz
         j9Fbe9IPj48U5UryYZOSPoZ0BWNa/e9sCtJBGSdr2VX1we+OPJQ5wJ6EgwIQdb4xxWxd
         2X/whAwNNFduCq66YmMNGHK6rKXBSMrU/vao55Syt1JrMNVpuXp6asPnEUvhahCRCoWj
         ZVtiBo3dzcCZF0YRkoh1wDahd9uLd8aUE/JkcRuRaSyMO8cYXJkwnGXfktWa6he92I2S
         xP9u82YuRcLWEo6KFuZ2EI/a/AEqqjtVxfviyC/g4ASCdqBbjUJhQLRso9v9tth2VEHU
         lLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709475148; x=1710079948;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HiEyhU0EypI+vfh4OJIbB6KGSmkaOA0tY5aLw7P7HE=;
        b=ni14KC9LVNu98O+c5trBwU3ratKAWE8abxzoCkjV5AMeiAteCPUBr333YwB7hyuF3s
         DhfrpVP2VnH6zs4tLzzcygyyHocdSKxp8U/NsZ1VTMO7JgYA66qgJuz8qaxpCf91MsoL
         98ofOZD7NxjMiT/9o/TEwUWk65cegMd8TfDRpEerkmEhsHYv1rIV3RrNVz9h42URmwd2
         4VnCEh52f0nkrskEyRJGxptDLtf2KwR7QHFkhi6shbmvD0VOdshgociSLaJ52y4WgGB+
         NluTMN+z16pJRpF+8hg0mALX1a+Aa5KasDCWqS/zEzqHw541V5G5UtHRrEbyqk2/A4Pp
         Bc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVMp4c2YdGHwInjZYGDAfuEUD8Qhp8CbyPOOZW9SrHBwUfDkxYGumPvrEezGW3UVzCF2dGwMUqUnJEsVydUJIcAKirZ
X-Gm-Message-State: AOJu0YxMLElH2J0HSNqfR+bbBkYomZLiv/GAPONB03jxfDcYISha9GE8
	lkuPftrBu0s+qmoOK9OSiaot56h31cxb3/zJBRHxBFKHr7XfvSGL
X-Google-Smtp-Source: AGHT+IGHQQlmt9jjM6+PxzrBrE1bvdw2hQbJh4GQd3SeCpeA74wl3xFGI73Qlz99e2CwEujE87ofxQ==
X-Received: by 2002:aa7:d80e:0:b0:566:4895:c582 with SMTP id v14-20020aa7d80e000000b005664895c582mr4879060edq.15.1709475148033;
        Sun, 03 Mar 2024 06:12:28 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id r18-20020aa7cb92000000b005653c441a20sm3547548edt.34.2024.03.03.06.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 06:12:27 -0800 (PST)
Message-ID: <136a8fbc350dacbb8b8a4a4c0236c11f1c49d4cb.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/4] bpf: Recognize that two registers are
 safe when their ranges match
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, john.fastabend@gmail.com, kernel-team@fb.com
Date: Sun, 03 Mar 2024 16:12:26 +0200
In-Reply-To: <20240302020010.95393-3-alexei.starovoitov@gmail.com>
References: <20240302020010.95393-1-alexei.starovoitov@gmail.com>
	 <20240302020010.95393-3-alexei.starovoitov@gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-03-01 at 18:00 -0800, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> When open code iterators, bpf_loop or may_goto is used the following two =
states
> are equivalent and safe to prune the search:
>=20
> cur state: fp-8_w=3Dscalar(id=3D3,smin=3Dumin=3Dsmin32=3Dumin32=3D2,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
> old state: fp-8_rw=3Dscalar(id=3D2,smin=3Dumin=3Dsmin32=3Dumin32=3D1,smax=
=3Dumax=3Dsmax32=3Dumax32=3D11,var_off=3D(0x0; 0xf))
>=20
> In other words "exact" state match should ignore liveness and precision m=
arks,
> since open coded iterator logic didn't complete their propagation,
> but range_within logic that applies to scalars, ptr_to_mem, map_value, pk=
t_ptr
> is safe to rely on.
>
> Avoid doing such comparison when regular infinite loop detection logic is=
 used,
> otherwise bounded loop logic will declare such "infinite loop" as false
> positive. Such example is in progs/verifier_loops1.c not_an_inifinite_loo=
p().
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

I think this makes sense, don't see counter-examples at the moment.
One nit below.

Also, I'm curious if there is veristat results impact,
could be huge for some cases with bpf_loop().

[...]

> @@ -17257,7 +17263,7 @@ static int is_state_visited(struct bpf_verifier_e=
nv *env, int insn_idx)
>  		 */
>  		loop_entry =3D get_loop_entry(&sl->state);
>  		force_exact =3D loop_entry && loop_entry->branches > 0;
> -		if (states_equal(env, &sl->state, cur, force_exact)) {
> +		if (states_equal(env, &sl->state, cur, force_exact ? EXACT : NOT_EXACT=
)) {

Logically this checks same condition as checks for calls_callback() or
is_iter_next_insn() above: whether current state is equivalent to some
old state, where old state had not been tracked to 'exit' for each
possible path yet.
Thus, 'exact' flags used in these checks should be the same:
"force_exact ? RANGE_WITHIN : NOT_EXACT".

>  			if (force_exact)
>  				update_loop_entry(cur, loop_entry);
>  hit:


