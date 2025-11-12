Return-Path: <bpf+bounces-74330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE51C54778
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 21:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CC44C4EC47D
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 20:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853C02C2376;
	Wed, 12 Nov 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INNtNYiP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21492C15A0
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979327; cv=none; b=NFeaBdAE9GuqsOEPsdl2FrPpbPbbGXsqNNAkG4FUvLInCX/7DB9bNizQktto6ZBwZdj02LDgqkOjAq5mnqIvV4lBAPAS6nBivIu/zN/0uGJ0Qli/Q/9i+AIbKQfrwbNJ9ZkYz2+DBgo7t6RVdCx2QSavo8+m+4su6npkVtAETMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979327; c=relaxed/simple;
	bh=Xu+yEaLVtWCfJzBUT+z3hYhvz60Mhv4zLSmf0rk5aRc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIEFbrMVS0GQ6bSTGQQ1xH+wsez5W/Tcj9W1mJ/kr5EqErgNxrZWb+DQnZrYTRPpqzsAgVxgDpeCUHWCS/30r1TBCIGnNJB18DSJzIFRgmYszRbtE+vAcdYQQJYwSSsbmL9iTOsujGDy6k2/ChWfvnYISkczjZyqnZjqo+s3wxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INNtNYiP; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7af603c06easo109097b3a.0
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 12:28:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762979325; x=1763584125; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EXUXjWIi+7Ihj+So2mzA9gPJc0sAWdTrFlXIRql1P6g=;
        b=INNtNYiPcCBevHzQCh4YHjLdscgucSaCtNVpcTu/kBMmaNRetStmBjVKvdjkgPpzG4
         pjKSaN8E4HsGfzMwmRn9oF7Xs45+nj+bjDDPKKoGwjA8OxnvhvqkpA6un4wBWvTO/Z5c
         AwTwpVg9Zny0LwF+E19FhMeS1tgHN5bF8iGdrK4rA8wIFTwu8Y3XmtGZQ4dIKsPMr/AM
         Ar8hWtCiThXJw02/v3mQdyMsNQuvj+6nQmmYFx0XJyO3irB7u1Q/JlbHzGkvrcBZVjaR
         qV1FHMZhr8GCy6o2ETU7EsP2WwaAkxle2Ft052M/pUxADAlXh/3mWslYy6V+6UH0hMAO
         GVdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762979325; x=1763584125;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXUXjWIi+7Ihj+So2mzA9gPJc0sAWdTrFlXIRql1P6g=;
        b=fD1P++SX0MgGgFzmSkCrUMznujTTGaSWD8TWr8mqRWyxPBsRuD1AHjF7c2t5UN+tQg
         DPKFeu4BjfgDOJiRZLOJOKdqeL4h6CdF7PoZTpkaooHf0BVIyTBfU48mWI+IV+MG9SpG
         ZGB0EFEApAFQS0/9LvjLHyyaDzB1IcdN4AV1r4DHV8dw1x4ZZgCj43tZnBlOd9thL0se
         QLA3uNYMew0Bl6jMhGmHfw/7u/m/vtVTmBm2Fs6BMTVSrdDAtWxELX74HDaOTAYG8UiG
         kpOG0z/jpMXq0AfkPhuWdHIcVXA8Nyv+nbkpwFa81VykGkrwhv+HZfbtmzdj3P3aEaLw
         n3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVMr/IHitJrgf9AH+p4Vi3HAjr+PU7fThS1mPvQK7tV4M6T4hP4T4t5pYGugbS7zySbknk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaFizImB8qqUe7zGWSggu1lOsADjAtZx+ctiarX/hBF2ucL9Dd
	HHRxbSO6N4myuK3jCKI3WmErclVWlNfhGp5+Umu5Q3TUUQMhhlIqHK49
X-Gm-Gg: ASbGncvdlMSI70g1GtcbWMn9eFMh0ZBarXnewbGuK0Lx+AbBMMvzhwGeK03hoguOTO+
	g39up38qBJQFB4Koy1e7sdvvl4gIKvC678GPszpOC3Frtla6PU1O8WRHOFaDzUMFqXGBvWZ+F+J
	nS7ZjE6L6Mm7GIoCS0sdtXClO+Rw9F0MhW52qgpcLIpTxLW15J5GfD1LTHno7SF6yaQ9i41cHTe
	69Q4eRP6q/8TYQG1JjC2qvOSQ+Red4jYx7HmhQ5yJprbwX5a2zmu7FXU9umrxkgPN6N/xcbJsGf
	IcZqS+wDg5ynG3DaryWToJx6lFIsuqMeD3o2NIX2NxCT+HJVMXIojgZgBmPZuDuua+tjIMBV3Bh
	tKpxMjqt6+hI406TcnrHM7jdiVVzPC/k95NKm2ZCOuGOSAhKxV4deZXk+CHskRd+ut53AeZ6LLT
	1LiRweHo6apylAUHsDmi4vGB7GVA==
X-Google-Smtp-Source: AGHT+IGDp2IxCpCnzdDE7zKRUSkwZPlpf28ExrTE3D1p+WEOXeHGb8C4KPt8ilZzRNPZb5dIwT7Jnw==
X-Received: by 2002:a05:6a20:394a:b0:347:1a7c:dea7 with SMTP id adf61e73a8af0-35a52789993mr924155637.31.1762979324727;
        Wed, 12 Nov 2025 12:28:44 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:3e6d:747b:3d83:10e8? ([2620:10d:c090:500::6:aa7e])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc208695cf1sm1091377a12.7.2025.11.12.12.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:28:44 -0800 (PST)
Message-ID: <a2578a0ee81f5e5bde327192b1544d5d1c9840fb.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] selftests/bpf: add BTF dedup tests for recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Wed, 12 Nov 2025 12:28:41 -0800
In-Reply-To: <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
References: <cover.1762956564.git.paul.houssel@orange.com>
	 <c381ca44fccbde23fec1d67131c13fec162603d7.1762956565.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-11-12 at 15:11 +0100, Paul Houssel wrote:

Lgtm, one nit below:

> +{
> +	.descr =3D "dedup: recursive typedef",
> +	/*
> +	 * This test simulates a recursive typedef, which in GO is defined as s=
uch:
> +	 *
> +	 *   type Foo func() Foo
> +	 *
> +	 * In BTF terms, this is represented as a TYPEDEF referencing
> +	 * a FUNC_PROTO that returns the same TYPEDEF.
> +	 */
> +	.input =3D {
> +		.raw_types =3D {
> +			/*
> +			 * [1] typedef Foo -> func() Foo
> +			 * [2] func_proto() -> Foo
> +			 */
> +			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
> +			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */

Nit:
Maybe repeat the above two types, just to make sure that deduplication happ=
ens?

> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0Foo"),
> +	},
> +	.expect =3D {
> +		.raw_types =3D {
> +			BTF_TYPEDEF_ENC(NAME_NTH(1), 2),	/* [1] */
> +			BTF_FUNC_PROTO_ENC(1, 0),		/* [2] */
> +			BTF_END_RAW,
> +		},
> +		BTF_STR_SEC("\0Foo"),
> +	},
> +},

[...]

