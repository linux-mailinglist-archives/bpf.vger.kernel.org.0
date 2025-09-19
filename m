Return-Path: <bpf+bounces-68910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A54E5B88027
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 08:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DE811B26633
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28402299AAF;
	Fri, 19 Sep 2025 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dLze8TYA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3B34BA52
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 06:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758263754; cv=none; b=gwClZ77Fccu6n9qp2FscHHDragJBSbWMjlvApz3lF1R3txPxtp/66t0tKnqS0IEn7eowGrqmR4urr93PD4CtLt414RTJRW+aGXahluFYmYHs9YvsKtkk07yUnjTTR6Bf4sEnzPdNWMzbjCPUlo4jMTFrehmweFxEb6jIe3P0IHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758263754; c=relaxed/simple;
	bh=m4l3xMNkXMiGS6DwFcRQGal1maLn8n6pHdHBVbU9hGI=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UfwqlJNmQ+5u0D+jhtbX6dznGqpU/MdAqMh6gsRMw/Fj5RmFOS3b90+TuTv6p71qvAWJTeCx8/+HYgL5PkzZ24OwkmxEUPwR9qxNgm68LOiTiymWWka6hn6zi5vZ4nqzS/jOkafkD8DrtOjQOLW7/w7ynRMygDf/hmy+Ee5yDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dLze8TYA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf605b1so23638235ad.2
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 23:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758263753; x=1758868553; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GESUdAACU1qui92rt3fvZHTWEf1f51TqzsNGyhLpq0g=;
        b=dLze8TYAlWDgoBYnugAcELZH907IKo7i4DdKj2iQzW/5Gwcs2PrdasBtdzQfm+NTxG
         923ZXOPN67cQP7eX8WhyW94Pu/td3SkE95kFLL2Y5h+6u39DPkCqGPZqmzK8n+xIU9vf
         jXyyveC9hTFHPyDUqevetGckUgK4pgXkr1jVXW37/QkXJWbGHNCnlDHDRpVCooT1R/TL
         H/QHSpTilF6HOBRz2DCSmX8i8UJyeH8pyyI8Ac1AmINfJni0Kq4k7mxWNcPOTea8uZzq
         JWTVabvIbJ9bQX+plibrElGTHzlFb1rg/xur9sU98Hk2gI9Gx9/OyXIW5W+HHYJjEcKg
         BcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758263753; x=1758868553;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GESUdAACU1qui92rt3fvZHTWEf1f51TqzsNGyhLpq0g=;
        b=cmgtaY5FtRyfESqeTvUqzuj0GrmQK4ggJoSP36EtVBrjA75KscX9KKW2KP08sbQh98
         eai9EvpoOjZiY3ndCPGz1rZiCIsDy9qZPhflFG8qnJYvTjIG83UOau3eH8ZI1huUSTPL
         AbToT5gaRpbbcR2X3oH8zQYCfmt+NRALrp2hsPMgOCaTScyX2Gz2SWDnFNLdAspBAR6H
         vj6EmXEGKj7xi1/Qt9AbMJWGlMQGwDbEx4ODAJkicxU8VqV6xM55V8ujDC5Pgfcae2Bx
         Ar94bt4eAuKHCLg2+TXL4N95wbxqdjPjgAVoxrFkivtqcC0raGFgzT1CVxDSxH1g/vAX
         zJEg==
X-Forwarded-Encrypted: i=1; AJvYcCWeNc14fJj9V228bG7jaUDI9HwAl/fxtRXiI/XI5AbvKHXhw/LeZjVx7afPt8eIuafjlFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2rZRS/U1O0AQttdghN0QKLb95fUUEbivyqTlwCsw4Sq50yPK
	3hNrnjxC5Kwat1vq88aBjsQY1ZLDW8sLUvvdQ/Lm6+7Ll/0iTvwgUuQY
X-Gm-Gg: ASbGncvMIgpkWNxCbzPr+baNeihf5+iuBfy0gtzGPTBOaYGqD0pVCGqsYqYecPNwgv1
	DJ6mTWmtimXFp8MxnoSc/kn0eyg2U7Hqa8FRzbPvkw06g+DDeIQcuFWR8vXI2Go/+PeT++YeXKV
	r1vMTPpOkN2nTcDV97hvKMByRoj0brGBhtk3W75rCnZ0XCUcfHyUYa5liST2U1l+IjqC/pyj5H4
	CgFpwIlQMROoFnGeYXcrj3CbeXz2ASqZpoz2CKi7ZxT8FBYObAp8/MVvSMNIq6ms5PGRe1dxhHh
	X40jWiVvkCU4i5brB3nA9JF6zR/yriepv7/pI0LpKe0IdtIjcvqd97ooGUdwidtV5NGnDPeB3Zs
	9zCU7MratOOsEUtiaep0=
X-Google-Smtp-Source: AGHT+IHlosiPn5tcjj8VVxR48zt56zduNW/nZYCzwDEgKaoPZq+OIUiCR5EwxeLy0WMt/pSvktNCQw==
X-Received: by 2002:a17:902:ccca:b0:251:a3b3:1580 with SMTP id d9443c01a7336-269ba40c7b9mr38507325ad.6.1758263752633;
        Thu, 18 Sep 2025 23:35:52 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980329745sm44517135ad.121.2025.09.18.23.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 23:35:52 -0700 (PDT)
Message-ID: <0be32d7a07dbcc54b77fe8d9ffd283977126c0ff.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/13] bpf: support instructions arrays with
 constants blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 18 Sep 2025 23:35:49 -0700
In-Reply-To: <20250918093850.455051-6-a.s.protopopov@gmail.com>
References: <20250918093850.455051-1-a.s.protopopov@gmail.com>
	 <20250918093850.455051-6-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 09:38 +0000, Anton Protopopov wrote:

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a7ad4fe756da..5c1e4e37d1f8 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21578,6 +21578,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  	struct bpf_insn *insn;
>  	void *old_bpf_func;
>  	int err, num_exentries;
> +	int old_len, subprog_start_adjustment =3D 0;
> =20
>  	if (env->subprog_cnt <=3D 1)
>  		return 0;
> @@ -21652,7 +21653,7 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>  		func[i]->aux->func_idx =3D i;
>  		/* Below members will be freed only at prog->aux */
>  		func[i]->aux->btf =3D prog->aux->btf;
> -		func[i]->aux->subprog_start =3D subprog_start;
> +		func[i]->aux->subprog_start =3D subprog_start + subprog_start_adjustme=
nt;
>  		func[i]->aux->func_info =3D prog->aux->func_info;
>  		func[i]->aux->func_info_cnt =3D prog->aux->func_info_cnt;
>  		func[i]->aux->poke_tab =3D prog->aux->poke_tab;
> @@ -21705,7 +21706,15 @@ static int jit_subprogs(struct bpf_verifier_env =
*env)
>  		func[i]->aux->might_sleep =3D env->subprog_info[i].might_sleep;
>  		if (!i)
>  			func[i]->aux->exception_boundary =3D env->seen_exception;
> +
> +		/*
> +		 * To properly pass the absolute subprog start to jit
> +		 * all instruction adjustments should be accumulated
> +		 */
> +		old_len =3D func[i]->len;
>  		func[i] =3D bpf_int_jit_compile(func[i]);
> +		subprog_start_adjustment +=3D func[i]->len - old_len;
> +
>  		if (!func[i]->jited) {
>  			err =3D -ENOTSUPP;
>  			goto out_free;

This change makes sense, however, would it be possible to move
bpf_jit_blind_constants() out from jit to verifier.c:do_check,
somewhere after do_misc_fixups?
Looking at the source code, bpf_jit_blind_constants() is the first
thing any bpf_int_jit_compile() does.
Another alternative is to add adjust_subprog_starts() call to this
function. Wdyt?


