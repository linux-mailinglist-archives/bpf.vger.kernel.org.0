Return-Path: <bpf+bounces-74436-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F98C59DEE
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 20:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1030A4E2176
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56576319850;
	Thu, 13 Nov 2025 19:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJ2LuuiH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B29176026
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 19:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763063826; cv=none; b=RM04KDVNHpWP73na2JkQ8g5U1L18Zk2ambJWfPcSs3BcCYmNWTOH5+JS5VzJXKwPmE4unrW2uEX+XdwwT4kyYNub/Bi8fwY0RfyeT5JqU3gbXmWyMsGsqqvjDfjfOxI8nZeE6sVBppou1w8L8rnJCuNeFIxeMDJ65Ktrbg0WweA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763063826; c=relaxed/simple;
	bh=pRLqqA73j2r4uVTICQlBz7DmuiMAredniB3WkkfM13Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pZY5mvTyD6B/dTMZdJKj65hu+B2m4w9WKD12F1nryshF7oELh3FqiPAi0/NT+tTs/XAyLOTEtDcMnGJ6jP9S7bqbQmdIhsNtEriNvd6GhBkosLUA9Bqhf/sNsd9/mnw1NSR01iwKmSAKkvwcSR1c6FHhBuK7SOuEM5ioPmQiPb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJ2LuuiH; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29568d93e87so11132685ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763063825; x=1763668625; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+Ib7O9YZx7+gUTq2VNTCgAjHRJtzgOQbUEDJzWiiiMc=;
        b=dJ2LuuiHtCK0VK6L4aZUtMN4cRA0035bS6Ahvtbwn8YjFrpikOxi0fckinB9USjVlS
         MrpJTaggxcN7dQ+ObZyJ1l4hZUcgJy0FB02f///Qf4+R7CKKS4qb8Po2ilN5vjngPWyt
         7EouuR0WOgWV+Gp3F+2GHzo+ml2mGAe78ft6f18soV+hqgElj3Nt0BYoQTsEwMFELoTo
         1xQqVuwbHv9c57MmBc5kWNyBuk99Bb1f6KSzC5q26X9XJ9guLU4ikqltKfXVqFAPmNHa
         cN7q2Fa6ogO3F+By0uG2viZaL2Necsh+D/Ojp6vLP8QDOvoJ376bjlt1sC4goB0xSBrY
         lwxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763063825; x=1763668625;
        h=mime-version:user-agent:references:in-reply-to:date:cc:to:from
         :subject:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+Ib7O9YZx7+gUTq2VNTCgAjHRJtzgOQbUEDJzWiiiMc=;
        b=oOEiC+zzh8ex/THZg/61WJmnxYIVAy/C/pFlk4qgRomH9UVDXXkhfNw18vH3h3woN6
         PxU7T6uHXh/oXK9DbBsgyAviIzip/9gBS0mRqZ950sFyjxvg+ocdX3/+UosDx33gvR9S
         0Zmncqp3OoKMp5D4lxwEk1vAsp1WHeMLrvgUH8UaiJWyNHcowao8XoQWQM9mxMKRH3Rs
         SfDWLSN8NFBJqMzGngTyQHqgd0rgElgPthj9ZEp0vBnOvBhNzj4MDy0IATSd1e9dTeyq
         kOxMVfjiaXvZNLlvBQ6ctFfPj7YNWRMnYzy53wf8c3vCEWrjdqEUBDRlr8YcwqXk4wRR
         2/RA==
X-Forwarded-Encrypted: i=1; AJvYcCWxqgnAg48jW+QsT0ecupSAECXIlQyGdyQ6Jxy+O34UUdY1AJAI5QXA+hTxRZ/hMF7R8Z0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4srTDz0z8/Y0v3E7IeCa02EJmyhEw5mmsBX/r73aLACYuZEFF
	ut1L6zUJQk3GAc/4v0wTHfITZVhsEVAmEHtdvQssxCAVR/lovDomkL2d
X-Gm-Gg: ASbGncuYldbG/7JwsJSH3qpXlK/K+C0FkDIeWc42ZTltYCeY37a9ahvp4t0nWLhw3yD
	J+RiMgk8jxfDx8fOorGdzt3h8z4lQE4GOizq88LUN4qpKb7WyosbQvly0i6fS74xrh0aVDeJmnA
	LCMZqz3/VQ1GxrXCXZCXO/G5ZZXQwM+dPK/FVkt3YmF+Crd4i1NGTgxsjrmQDerrc7u2xYwRosh
	mPTV3Re1d6Jbtit1f0E/Wq/7T86GSsW5VaZYdFexcUnO8iwZe1e5sOMpGM3OqpNF6guIyV0Hvit
	A3td0POomTZMViznKUq5U4jzrrsJfsvXineanHoZdxQr+UBVi0HWvi5ufq3ADtRwgg1ndfXH7EG
	ZVX3SSSgAmmOQaM7Aol6S/MvCIhYlEII/YCPV6/kcq7d216auzgXJifjSu3h9jBzTcugsAE8uQg
	==
X-Google-Smtp-Source: AGHT+IFS5UevwFDxv0uKAOtYA5jPo+G/y2mq9Lsp8DexuPCLfOJGkE1zdWN79GG76FkE5cBTKMWuSw==
X-Received: by 2002:a17:902:f60e:b0:295:b46f:a6c2 with SMTP id d9443c01a7336-2986a73b741mr2501355ad.37.1763063824695;
        Thu, 13 Nov 2025 11:57:04 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2345e3sm34132395ad.1.2025.11.13.11.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:57:04 -0800 (PST)
Message-ID: <f3f7858c0a54c6eef670fe36f7cd15cc1f7dae16.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: verifier: initialize imm in kfunc_tab
 in add_kfunc_call()
From: Eduard Zingerman <eddyz87@gmail.com>
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Puranjay Mohan <puranjay12@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Martin KaFai Lau	 <martin.lau@kernel.org>, Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, 	kernel-team@meta.com
Date: Thu, 13 Nov 2025 11:57:01 -0800
In-Reply-To: <20251113104053.18107-1-puranjay@kernel.org>
References: <20251113104053.18107-1-puranjay@kernel.org>
Content-Type: multipart/mixed; boundary="=-FocWArNV+10y6EEvQDor"
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

--=-FocWArNV+10y6EEvQDor
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-11-13 at 10:40 +0000, Puranjay Mohan wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1268fa075d4c..31136f9c418b 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3273,7 +3273,7 @@ static int add_kfunc_call(struct bpf_verifier_env *=
env, u32 func_id, s16 offset)
>  	struct bpf_kfunc_desc *desc;
>  	const char *func_name;
>  	struct btf *desc_btf;
> -	unsigned long addr;
> +	unsigned long addr, call_imm;
>  	int err;
> =20
>  	prog_aux =3D env->prog->aux;
> @@ -3369,8 +3369,20 @@ static int add_kfunc_call(struct bpf_verifier_env =
*env, u32 func_id, s16 offset)
>  	if (err)
>  		return err;
> =20
> +	if (bpf_jit_supports_far_kfunc_call()) {
> +		call_imm =3D func_id;
> +	} else {
> +		call_imm =3D BPF_CALL_IMM(addr);
> +		/* Check whether the relative offset overflows desc->imm */
> +		if ((unsigned long)(s32)call_imm !=3D call_imm) {
> +			verbose(env, "address of kernel func_id %u is out of range\n", func_i=
d);
> +			return -EINVAL;
> +		}
> +	}

Instead of having this logic in two places, how about moving the
desc->imm setup down to sort_kfunc_descs_by_imm_off()?
I think it the only consumer of desc->imm in verifier.c.
E.g. as in the diff attached.

> +
>  	desc =3D &tab->descs[tab->nr_descs++];
>  	desc->func_id =3D func_id;
> +	desc->imm =3D call_imm;
>  	desc->offset =3D offset;
>  	desc->addr =3D addr;
>  	desc->func_model =3D func_model;
> @@ -22353,17 +22365,15 @@ static int specialize_kfunc(struct bpf_verifier=
_env *env, struct bpf_kfunc_desc
>  	}
> =20
>  set_imm:
> -	if (bpf_jit_supports_far_kfunc_call()) {
> -		call_imm =3D func_id;
> -	} else {
> +	if (!bpf_jit_supports_far_kfunc_call()) {
>  		call_imm =3D BPF_CALL_IMM(addr);
>  		/* Check whether the relative offset overflows desc->imm */
>  		if ((unsigned long)(s32)call_imm !=3D call_imm) {
>  			verbose(env, "address of kernel func_id %u is out of range\n", func_i=
d);
>  			return -EINVAL;
>  		}
> +		desc->imm =3D call_imm;
>  	}
> -	desc->imm =3D call_imm;
>  	desc->addr =3D addr;
>  	return 0;
>  }

--=-FocWArNV+10y6EEvQDor
Content-Disposition: attachment; filename="kfunc-desc-imm.diff"
Content-Type: text/x-patch; name="kfunc-desc-imm.diff"; charset="UTF-8"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvdmVyaWZpZXIuYyBiL2tlcm5lbC9icGYvdmVyaWZpZXIu
YwppbmRleCAxMjY4ZmEwNzVkNGMuLjdmZmU1MjZjMzRjYiAxMDA2NDQKLS0tIGEva2VybmVsL2Jw
Zi92ZXJpZmllci5jCisrKyBiL2tlcm5lbC9icGYvdmVyaWZpZXIuYwpAQCAtMzM5MSwxNiArMzM5
MSw0NCBAQCBzdGF0aWMgaW50IGtmdW5jX2Rlc2NfY21wX2J5X2ltbV9vZmYoY29uc3Qgdm9pZCAq
YSwgY29uc3Qgdm9pZCAqYikKIAlyZXR1cm4gMDsKIH0KIAotc3RhdGljIHZvaWQgc29ydF9rZnVu
Y19kZXNjc19ieV9pbW1fb2ZmKHN0cnVjdCBicGZfcHJvZyAqcHJvZykKK3N0YXRpYyBpbnQgc2V0
X2tmdW5jX2Rlc2NfaW1tKHN0cnVjdCBicGZfdmVyaWZpZXJfZW52ICplbnYsIHN0cnVjdCBicGZf
a2Z1bmNfZGVzYyAqZGVzYykKK3sKKwl1bnNpZ25lZCBsb25nIGNhbGxfaW1tOworCisJaWYgKGJw
Zl9qaXRfc3VwcG9ydHNfZmFyX2tmdW5jX2NhbGwoKSkgeworCQljYWxsX2ltbSA9IGRlc2MtPmZ1
bmNfaWQ7CisJCXJldHVybiAwOworCX0gZWxzZSB7CisJCWNhbGxfaW1tID0gQlBGX0NBTExfSU1N
KGRlc2MtPmFkZHIpOworCQkvKiBDaGVjayB3aGV0aGVyIHRoZSByZWxhdGl2ZSBvZmZzZXQgb3Zl
cmZsb3dzIGRlc2MtPmltbSAqLworCQlpZiAoKHVuc2lnbmVkIGxvbmcpKHMzMiljYWxsX2ltbSAh
PSBjYWxsX2ltbSkgeworCQkJdmVyYm9zZShlbnYsICJhZGRyZXNzIG9mIGtlcm5lbCBmdW5jX2lk
ICV1IGlzIG91dCBvZiByYW5nZVxuIiwKKwkJCQlkZXNjLT5mdW5jX2lkKTsKKwkJCXJldHVybiAt
RUlOVkFMOworCQl9CisJfQorCWRlc2MtPmltbSA9IGNhbGxfaW1tOworCXJldHVybiAwOworfQor
CitzdGF0aWMgaW50IHNvcnRfa2Z1bmNfZGVzY3NfYnlfaW1tX29mZihzdHJ1Y3QgYnBmX3Zlcmlm
aWVyX2VudiAqZW52KQogewogCXN0cnVjdCBicGZfa2Z1bmNfZGVzY190YWIgKnRhYjsKKwlpbnQg
aSwgZXJyOwogCi0JdGFiID0gcHJvZy0+YXV4LT5rZnVuY190YWI7CisJdGFiID0gZW52LT5wcm9n
LT5hdXgtPmtmdW5jX3RhYjsKIAlpZiAoIXRhYikKLQkJcmV0dXJuOworCQlyZXR1cm4gMDsKKwor
CWZvciAoaSA9IDA7IGkgPCB0YWItPm5yX2Rlc2NzOyBpKyspIHsKKwkJZXJyID0gc2V0X2tmdW5j
X2Rlc2NfaW1tKGVudiwgJnRhYi0+ZGVzY3NbaV0pOworCQlpZiAoZXJyKQorCQkJcmV0dXJuIGVy
cjsKKwl9CiAKIAlzb3J0KHRhYi0+ZGVzY3MsIHRhYi0+bnJfZGVzY3MsIHNpemVvZih0YWItPmRl
c2NzWzBdKSwKIAkgICAgIGtmdW5jX2Rlc2NfY21wX2J5X2ltbV9vZmYsIE5VTEwpOworCXJldHVy
biAwOwogfQogCiBib29sIGJwZl9wcm9nX2hhc19rZnVuY19jYWxsKGNvbnN0IHN0cnVjdCBicGZf
cHJvZyAqcHJvZykKQEAgLTIyMzIwLDEwICsyMjM0OCwxMCBAQCBzdGF0aWMgaW50IHNwZWNpYWxp
emVfa2Z1bmMoc3RydWN0IGJwZl92ZXJpZmllcl9lbnYgKmVudiwgc3RydWN0IGJwZl9rZnVuY19k
ZXNjCiAJYm9vbCBpc19yZG9ubHk7CiAJdTMyIGZ1bmNfaWQgPSBkZXNjLT5mdW5jX2lkOwogCXUx
NiBvZmZzZXQgPSBkZXNjLT5vZmZzZXQ7Ci0JdW5zaWduZWQgbG9uZyBhZGRyID0gZGVzYy0+YWRk
ciwgY2FsbF9pbW07CisJdW5zaWduZWQgbG9uZyBhZGRyID0gZGVzYy0+YWRkcjsKIAogCWlmIChv
ZmZzZXQpIC8qIHJldHVybiBpZiBtb2R1bGUgQlRGIGlzIHVzZWQgKi8KLQkJZ290byBzZXRfaW1t
OworCQlyZXR1cm4gMDsKIAogCWlmIChicGZfZGV2X2JvdW5kX2tmdW5jX2lkKGZ1bmNfaWQpKSB7
CiAJCXhkcF9rZnVuYyA9IGJwZl9kZXZfYm91bmRfcmVzb2x2ZV9rZnVuYyhwcm9nLCBmdW5jX2lk
KTsKQEAgLTIyMzUxLDE5ICsyMjM3OSw2IEBAIHN0YXRpYyBpbnQgc3BlY2lhbGl6ZV9rZnVuYyhz
dHJ1Y3QgYnBmX3ZlcmlmaWVyX2VudiAqZW52LCBzdHJ1Y3QgYnBmX2tmdW5jX2Rlc2MKIAkJaWYg
KCFlbnYtPmluc25fYXV4X2RhdGFbaW5zbl9pZHhdLm5vbl9zbGVlcGFibGUpCiAJCQlhZGRyID0g
KHVuc2lnbmVkIGxvbmcpYnBmX2R5bnB0cl9mcm9tX2ZpbGVfc2xlZXBhYmxlOwogCX0KLQotc2V0
X2ltbToKLQlpZiAoYnBmX2ppdF9zdXBwb3J0c19mYXJfa2Z1bmNfY2FsbCgpKSB7Ci0JCWNhbGxf
aW1tID0gZnVuY19pZDsKLQl9IGVsc2UgewotCQljYWxsX2ltbSA9IEJQRl9DQUxMX0lNTShhZGRy
KTsKLQkJLyogQ2hlY2sgd2hldGhlciB0aGUgcmVsYXRpdmUgb2Zmc2V0IG92ZXJmbG93cyBkZXNj
LT5pbW0gKi8KLQkJaWYgKCh1bnNpZ25lZCBsb25nKShzMzIpY2FsbF9pbW0gIT0gY2FsbF9pbW0p
IHsKLQkJCXZlcmJvc2UoZW52LCAiYWRkcmVzcyBvZiBrZXJuZWwgZnVuY19pZCAldSBpcyBvdXQg
b2YgcmFuZ2VcbiIsIGZ1bmNfaWQpOwotCQkJcmV0dXJuIC1FSU5WQUw7Ci0JCX0KLQl9Ci0JZGVz
Yy0+aW1tID0gY2FsbF9pbW07CiAJZGVzYy0+YWRkciA9IGFkZHI7CiAJcmV0dXJuIDA7CiB9CkBA
IC0yMzQ0MSw3ICsyMzQ1Niw5IEBAIHN0YXRpYyBpbnQgZG9fbWlzY19maXh1cHMoc3RydWN0IGJw
Zl92ZXJpZmllcl9lbnYgKmVudikKIAkJfQogCX0KIAotCXNvcnRfa2Z1bmNfZGVzY3NfYnlfaW1t
X29mZihlbnYtPnByb2cpOworCXJldCA9IHNvcnRfa2Z1bmNfZGVzY3NfYnlfaW1tX29mZihlbnYp
OworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CiAKIAlyZXR1cm4gMDsKIH0K


--=-FocWArNV+10y6EEvQDor--

