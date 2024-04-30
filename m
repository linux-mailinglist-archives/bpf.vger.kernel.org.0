Return-Path: <bpf+bounces-28310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2B88B8374
	for <lists+bpf@lfdr.de>; Wed,  1 May 2024 01:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4564E1F27754
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 23:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBC91C65E9;
	Tue, 30 Apr 2024 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jhhSd70I"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66FD1C233E
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 23:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714521304; cv=none; b=ITsS+TJuf3OqDOEE9Rx0KNY0vcjpMGrtG/vSzhO/9H6LIG+NYonETFkoWPqrfb+FTY8KpoWtIekqajM1sPianlgGEM6SEVkaw2SNZ1c5iURBA+1s3D6liMecOaRbFZ0rwmJ9Mqx70CLUgjaPS224vLPmyexxEqvVRpr6GsXWVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714521304; c=relaxed/simple;
	bh=ThoQt15WpeNFltu2V0X86NV1vFlyfE3UZtIkEd8iTTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auTUdacz/W5SzIBGjPQmDTCAY2+JQcgEIJfAPUBISR4N+KK+XGLA5m7np3mpepotgUQ388JyC6xilOJyqUfdmpksklf7riEiKBNTUpk6Fz53mehDfHaA9iaJDY6/adQ4MyQawIMMR7PsPR2L+3aUHN6/2BN855jFXOYCINwUVMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jhhSd70I; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso4999855b3a.1
        for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714521302; x=1715126102; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W9eGBFxtlNly27WBXKjXCpXsSt5mzvuglvrSdcyLd2U=;
        b=jhhSd70I/DGZY2/Y96NOJpaqXt68lfoEoonHCnsvW76lvHT4uOhTc1E7HfyWua6sWS
         reQQ6G/0/ry7itoJqXmRDKFOfyqLda2yHYVVLYjbVC3F2lPrNdJC2sXURMqVkk685c+j
         Htabt8oAiXSygnQzzoBqbuDVHbpxVAqvkwDpX7zoTj7UfJIvTZ+OdBfZucBWNLM3M+Lo
         SG7LvahwCC3LFaHKQZKr2heE9tj3NaVY0do8fa7DySs6lVAHQS39a/zTkVpDCmEbg9rz
         F3AJBopYosLfo43Qf58MBwDRbQ7De0PNjgYkOsK1bkFPWh0qg4kaVmdPJiv5WoSqMUTS
         CMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714521302; x=1715126102;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W9eGBFxtlNly27WBXKjXCpXsSt5mzvuglvrSdcyLd2U=;
        b=hRux5/g8hIqTJqgkA2fQtu+KyWzTbGeSOX11/R9fO4bIaP/PD5wHkwws2xkOU/hXEd
         mmlBJQOrvpo9rastI0/ioY2HIQEeCqAPBElyr3o09WMUDNrJMDepQ1LeF42ZkTGbEw6M
         5oZ4mOiHoFuzFl8WIgzT+FpeisOpxARJMiQO9EgN8wrDfL5ycd6lbNAu12GxnASCkwk7
         nQeh6ORp2OMkgTZpS1QNnxQlckFOgnl1zU9EvdpptXwdrA81K7DAOcRS8fH+TsPw6I89
         lu4EzuO64S/2YptnF/lAJ/DQnNlY9onTXqUJijfutzV2tmCvDQdRDfyy2GTv7BhBfRHN
         BgLg==
X-Forwarded-Encrypted: i=1; AJvYcCX4myJHrtdS4dnNzXKtSbvk+W23bSRu9JqdOSdpSW6v6e1Xh+4/OvQGgYHIlxT70fm0FlIRpIdsb2XTHPJm56XuGGu3
X-Gm-Message-State: AOJu0YwPyBK7sEzSucQgFOuGWaFbVm+HP2hGUGRJH32h3s5sGgpMQPNK
	TWl/r+TWM69H/otKq+oAcSRHqI4Dmdnz+a1EfhuB62fmBDZWSdEcHzbnkVkW
X-Google-Smtp-Source: AGHT+IGI80Qk2WWRW0RTdEVwV7nOIJWNwjS+ssVpjpfFEGljw18ekeWbpSuek6lozt91cKSNKLODDw==
X-Received: by 2002:a05:6a00:ace:b0:6ed:6f25:f361 with SMTP id c14-20020a056a000ace00b006ed6f25f361mr1281795pfl.29.1714521302153;
        Tue, 30 Apr 2024 16:55:02 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160:313a:f4fd:13d2:b9eb? ([2604:3d08:6979:1160:313a:f4fd:13d2:b9eb])
        by smtp.gmail.com with ESMTPSA id fv7-20020a056a00618700b006f3f5d3595fsm5715766pfb.80.2024.04.30.16.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 16:55:01 -0700 (PDT)
Message-ID: <d73031b51394b8db13556177e42820674dcc8157.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 03/13] selftests/bpf: test distilled base,
 split BTF generation
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, andrii@kernel.org, ast@kernel.org
Cc: jolsa@kernel.org, acme@redhat.com, quentin@isovalent.com,
 mykolal@fb.com,  daniel@iogearbox.net, martin.lau@linux.dev,
 song@kernel.org,  yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org,  sdf@google.com, haoluo@google.com, houtao1@huawei.com,
 bpf@vger.kernel.org,  masahiroy@kernel.org, mcgrof@kernel.org,
 nathan@kernel.org
Date: Tue, 30 Apr 2024 16:55:00 -0700
In-Reply-To: <20240424154806.3417662-4-alan.maguire@oracle.com>
References: <20240424154806.3417662-1-alan.maguire@oracle.com>
	 <20240424154806.3417662-4-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-24 at 16:47 +0100, Alan Maguire wrote:


[...]

> +static void test_distilled_base(void)
> +{
>=20

[...]

> +
> +	VALIDATE_RAW_BTF(
> +		btf1,
> +		"[1] INT 'int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=3DSIGNED=
",
> +		"[2] PTR '(anon)' type_id=3D1",
> +		"[3] STRUCT 's1' size=3D8 vlen=3D1\n"
> +		"\t'f1' type_id=3D2 bits_offset=3D0",
> +		"[4] STRUCT '(anon)' size=3D12 vlen=3D2\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0\n"
> +		"\t'f2' type_id=3D3 bits_offset=3D32",
> +		"[5] INT 'unsigned int' size=3D4 bits_offset=3D0 nr_bits=3D32 encoding=
=3D(none)",
> +		"[6] UNION 'u1' size=3D12 vlen=3D2\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0\n"
> +		"\t'f2' type_id=3D2 bits_offset=3D0",
> +		"[7] UNION '(anon)' size=3D4 vlen=3D1\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0",
> +		"[8] ENUM 'e1' encoding=3DUNSIGNED size=3D4 vlen=3D1\n"
> +		"\t'v1' val=3D1",
> +		"[9] ENUM '(anon)' encoding=3DUNSIGNED size=3D4 vlen=3D1\n"
> +		"\t'av1' val=3D2",
> +		"[10] ENUM64 'e641' encoding=3DSIGNED size=3D8 vlen=3D1\n"
> +		"\t'v1' val=3D1024",
> +		"[11] ENUM64 '(anon)' encoding=3DSIGNED size=3D8 vlen=3D1\n"
> +		"\t'v1' val=3D1025",
> +		"[12] STRUCT 'unneeded' size=3D4 vlen=3D1\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0",
> +		"[13] STRUCT 'embedded' size=3D4 vlen=3D1\n"
> +		"\t'f1' type_id=3D1 bits_offset=3D0",
> +		"[14] FUNC_PROTO '(anon)' ret_type_id=3D1 vlen=3D1\n"
> +		"\t'p1' type_id=3D1",
> +		"[15] ARRAY '(anon)' type_id=3D1 index_type_id=3D1 nr_elems=3D3");

Sorry, one more thing,
maybe add a a FUNC_PROTO referencing a struct and refer to this proto from =
btf2?
To check that FUNC_PROTOs are visited as appropriate.

> +
> +	btf2 =3D btf__new_empty_split(btf1);
> +	if (!ASSERT_OK_PTR(btf2, "empty_split_btf"))
> +		goto cleanup;
> +

[...]

