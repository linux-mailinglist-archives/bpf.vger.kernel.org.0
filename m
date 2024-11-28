Return-Path: <bpf+bounces-45777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F39DB09D
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 02:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBD0FB21251
	for <lists+bpf@lfdr.de>; Thu, 28 Nov 2024 01:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E717557;
	Thu, 28 Nov 2024 01:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkKkDrf6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE46A847B
	for <bpf@vger.kernel.org>; Thu, 28 Nov 2024 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732756162; cv=none; b=IwbhHN6BXJNlWoZi46L9+Fq3Ckn7Qmq4SWCKSPw1Iev7Lm4atB+tEdE9dh5Mga5WHQh0EW3VQLLrT+Ci2z4MPrL2NjUhGwewyZVXUAMMNSpqaaICdne6I2IS4FCeIJSoMG+jKzoTxaa8/jxp3kqoO8mpTGFWZTcsiMTsUdJFOB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732756162; c=relaxed/simple;
	bh=Vd77kV78VrjbeUkIwfR5kGRPLxPsbFOmQmPvzyc5rVo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MMtDgEx06QM/uytJ9Jm9khdE4p69bKtuTWegXUxPveSwlwuHkKqAzYWoyMnYoL+JmpYPhdjlv4yVY6d+Mmsdx4eLcObK2/NoyNCSQ9XNfl4byTA5id+lBAnki8/KRuO9P0fpkft5lvI4lxdKO+XOMuOqxsIs3D52FRyQ1TsPG3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkKkDrf6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-724f1ce1732so309919b3a.1
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 17:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732756160; x=1733360960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TBEEuSmu4w8BmwQmEHUTBAFKkvSCtgK/tuW67azMV28=;
        b=KkKkDrf6Cohl6zd0c5GzIox6/lMivmdXR9aQO+RgHQDPZ1ntdCVls/V38bUmP4VSzb
         4G5HysZFwiA77mxvKtzlQAWegf2b9Rz5IVmxbOKlKo7u53czwANl8YiwdoK7Cn4MB5YY
         NbyPpIgGx+KTve1aQmkFNs5ocC9jQoY5+fiMDhiz1QCwhA2WAS1Ff1WznEURoExoXEr2
         hwFeSO16o9nPfiflU0RvcqlwJhWFL2zBaANDQSfitjfJZRE2uMHaMdWByXPrLDQyIgQF
         6ZCvukKK1+o0S8ZXBHyXfAIkP/lg8dwmn61NU4RW759vo1Bor+J51FnpgP9qCSmSMPD3
         ZpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732756160; x=1733360960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBEEuSmu4w8BmwQmEHUTBAFKkvSCtgK/tuW67azMV28=;
        b=Qf0TLVi1NdVwuc+JrDHkGnBVDM3LSGaZUjYntKEBhwcBa90SJQO5RChYTXJnhNQc0X
         dqWhlp0SIvHaiUZ3JMgh1CmjhlQJso0opr8KCVX/7dEd1jRi67/DNXHnJnU6uGIYxBjB
         Gl/75md7O43PzraFt+HXqtGtFgu1luZHH4E6dLX5U4gUQy+TujKoV3Ns7YZQnfws4O4U
         vfdhDvC4pqrrWfHOra4VDb+M4tLWCfVn+70wA5mI1Q2h+9i8kcIsovEXl0WDSeJRwcny
         destW9ouQeRh6BX8e60XpQmZgQ+R0cZiI6auxkDDsTCfor7L8+ChzkkSZ4L2nzOea1GK
         CtIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/4PDlm+Z6/5x1kwGbb2/YwzZ9WGYuERQr8xO3XujcYcsDf8jbRPfqzvZkGAqFDVyZefY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz09+0vPqGfzq88cbMVbXNEbRceE9bdjDlA4EL7CQoDsXffe8Xn
	+VFHM/CGmsfF0JdHqWAZqmT9N0FhrT6CXwhMeoD2Mri8pzSb48xA
X-Gm-Gg: ASbGnct5h/YOwPGip7BhG+H2GiD69WuKZbZtzfyI+nYUtLMystWHoFJqj4ylQcZU8T7
	B1B+5SOpwD3DP/v6T3TQ0CFpC9WqOK45zNCqR3egDGGZNri2NBr/ltFKXeN4mYA2+/7tnWHxue5
	2JmYngbXDDocJyi777fHfLShLqeLyJjfRdXFrxabeTIaOnSiR5d8xIbDxyVAmcxEZHuez84jObO
	aJj5dtWq+kVqm0bJmuP5VCQeEebiXLICditioo6NR3rHEk=
X-Google-Smtp-Source: AGHT+IHl81ITLmLkCWIZ9niH+3TYbJE7Iqx+cXXvoKrD8U2sqqFoqNwh6vl7h4u/9Y9Kj/4rQlcWcA==
X-Received: by 2002:a17:902:d50e:b0:212:20c2:5fcd with SMTP id d9443c01a7336-21501385212mr57209805ad.26.1732756160045;
        Wed, 27 Nov 2024 17:09:20 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521983555sm1848695ad.172.2024.11.27.17.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 17:09:19 -0800 (PST)
Message-ID: <c5f49bb4acabf88539eb28cd8f93446be5f326d8.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/4] bpf: Don't relax STACK_INVALID to
 STACK_MISC when not allow_ptr_leaks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, Andrii
 Nakryiko <andrii@kernel.org>
Cc: Tao Lyu <tao.lyu@epfl.ch>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 Mathias Payer	 <mathias.payer@nebelwelt.net>, Meng Xu
 <meng.xu.cs@uwaterloo.ca>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Date: Wed, 27 Nov 2024 17:09:14 -0800
In-Reply-To: <20241127212026.3580542-2-memxor@gmail.com>
References: <20241127212026.3580542-1-memxor@gmail.com>
	 <20241127212026.3580542-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 13:20 -0800, Kumar Kartikeya Dwivedi wrote:
> Inside mark_stack_slot_misc, we should not upgrade STACK_INVALID to
> STACK_MISC when allow_ptr_leaks is false, since invalid contents
> shouldn't be read unless the program has the relevant capabilities.
> The relaxation only makes sense when env->allow_ptr_leaks is true.
>=20
> Currently, the condition is inverted (i.e. checking for true instead of
> false), simply invert it to restore correct behavior.
>=20
> Update error strings of selftests relying on current behavior's verifier
> output.
>=20
> Fixes: eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spill=
s")
> Reported-by: Tao Lyu <tao.lyu@epfl.ch>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c                          |  2 +-
>  .../selftests/bpf/progs/verifier_spill_fill.c  | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 10 deletions(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1c4ebb326785..f9791a001e25 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1209,7 +1209,7 @@ static void mark_stack_slot_misc(struct bpf_verifie=
r_env *env, u8 *stype)
>  {
>  	if (*stype =3D=3D STACK_ZERO)
>  		return;
> -	if (env->allow_ptr_leaks && *stype =3D=3D STACK_INVALID)
> +	if (!env->allow_ptr_leaks && *stype =3D=3D STACK_INVALID)

This change makes sense, but it contradicts a few things:
- comment on top of this function;
- commit message for [0]
  (there is my ack on that commit, but I have no memory of this place...).

Andrii, do you remember why STACK_INVALID had to be changed to STACK_MISC
for unprivileged case?

Kumar argues that the following program should be rejected when unprivilege=
d:

    0: (b7) r2 =3D 1                        ; R2_w=3D1
    1: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
    2: (07) r6 +=3D -8                      ; R6_w=3Dfp-8
    3: (73) *(u8 *)(r6 +0) =3D r2           ; R2_w=3D1 R6_w=3Dfp-8 fp-8=3D?=
??????1
    4: (79) r2 =3D *(u64 *)(r6 +0)
    invalid read from stack off -8+1 size 8

(which makes sense). But on master we have:

    0: (b7) r2 =3D 1                        ; R2_w=3D1
    1: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
    2: (07) r6 +=3D -8                      ; R6_w=3Dfp-8
    3: (73) *(u8 *)(r6 +0) =3D r2           ; R2_w=3D1 R6_w=3Dfp-8 fp-8=3Dm=
mmmmmm1
    4: (79) r2 =3D *(u64 *)(r6 +0)          ; R2_w=3Dscalar() R6_w=3Dfp-8 f=
p-8=3Dmmmmmmm1
    5: (b7) r0 =3D 0                        ; R0_w=3D0
    6: (95) exit

(which makes much less sense).

Also, technically speaking, there is no longer a need in replacing
STACK_INVALID with STACK_MISC at all, only STACK_SPILL should be replaced.
(Because in privileged mode reads from STACK_INVALID are allowed).

[0] eaf18febd6eb ("bpf: preserve STACK_ZERO slots on partial reg spills")

>  		return;
>  	*stype =3D STACK_MISC;
>  }

[...]


