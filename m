Return-Path: <bpf+bounces-74434-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3D7C59BBD
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 20:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D10643AF9D4
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD09431A812;
	Thu, 13 Nov 2025 19:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRRo5/ko"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7407B316907
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 19:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061676; cv=none; b=L28pMf27uHr9IUCZGqAufVcuzcKDDpJw/CtSLqPixXWEVoIzotYZmaHtIl53QNgtgCAq2Oi+jxr2KdgKsaQJKxa2lIyI0pCmt0ht3WP2dz+9Kyc593A6jBh2xnvjWZOL5US1uj7tsuw8j+g/PyMoxXGyV8FqNFH24FGgFacBpac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061676; c=relaxed/simple;
	bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IcHD2V4WPgMQg8dB2A4zVbGNhnugSCIgtkXfY/SsUzXuORzANwtfq8hdO0QCaGzABo+RHuLmZmR7wIQ/no6k2NUyXcXS6jycgbFY/3aif0U8EJDHQP8+zF8L6vsioEBEelBNsTe8uNycRi2nbHzTlD89aSZPek3sgOJKyEKHRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRRo5/ko; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-340bcc92c7dso2111306a91.0
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 11:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763061673; x=1763666473; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
        b=hRRo5/ko0m+0C3//rh0YIVeTifJukWDpcKaN7C9Wwcfkqi5QNW4blQOzYlHll5pvnB
         xAbRvySqMLlA7lHg3zEHrzK3UPpmLUgrpl4F3SZ7z0JuYWsOE6+eQJcoldQwThagkroK
         ZbOoWL98/j+CeeX/f6dN5fBRNgo9OMYw4KhHRzXZNV6Z901lf2kbR4mxB6QmDdGHoKS2
         wLdh+Z0uHjL3DJTHn5zLMaspz65wDvYjT3bJ0/nR/XnUODcYtUrHxw1a15NvkSuHHUT2
         XBQqfdgjrktY2+rpW/+t3ljqyCco+m8ggVZtoNYsMWyxLHcdvNchEaAmySjkBalxB7yf
         SXIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061673; x=1763666473;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YV6sOxoXq6hGnFV0FtR8Pqna/c3no8BjtpDPc+tesEA=;
        b=hQddYQMEMxDW7hp2QJfAtkwvWzkQSqRkEkn2fImILdPDnXAyr2b9aafTLk3dxoJddI
         OKfZ4vengFi1YfWiICTTjfeQLFAlsIKV0066MKtz4mxgoy7MnsYSdKyOjbmFV1SJswrb
         QAnsgxoWhZYHkjpwA5XT2DTkHp85VXPFwqR4HJh8F5o0PJ90xvrUZR+DvAsB/sYVTd8P
         3JTg/z96PCMrZFvonJaY2xqBA+zI3zagTdusveLj/YTgAVB5MJMq9cciMzG+B7iB44wN
         yJ3ouZCkBqn4wVzraesTldznJfkwXmFMTW7SqVVNZnQ3lyJcKZy2XpCeaMcy++lW28WZ
         +K9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4hc//vhjZHU0dgvjTf05c91K7UM/JVUL0r6MQwYx/xXucVpz84Rrp8Ft4axd9Tr8MK0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXoKxjcLa+orHd/eDk14YMXrvxEqOz5lbJOzGkFLPjp0IFDXjj
	Srn8+/BcaoXGhKUkgxeYP6FisPhw+Lzcyt5mafWQTuRaFnf+78P7+K7K
X-Gm-Gg: ASbGncvI0tFztlI+TxLcrj8BG+3Sue/3cKUv7s94HObJeRdPeufMH4TTfBLQrI0OULa
	6Fi251MYVzilFDuudd7bDO4kInUtV4t//R0c3T1sf+zzunWs2CXeL7NNVhm8MNcIGDY5TLW6kDq
	SAiQB8s2xrXEpZPgjlKY9aLj21QFWL/g/Zof8ORjLc1JNLFoB0w5+gnmkh0HGHPESEX45YR876w
	6WwsnLfk+yGjogXDJexZQfqRqwerYfCaEcKpsBPXUcEQnZhW5dTQWIEGvHJfdpyorK41tPIRTul
	TqWOxL5pOk5XO8u9jC/06OU4N8H+4NoOnxQdyHjFMwbdkBECGfracin/l1HV74Dt7Ld9Vm2UTYN
	GBV65hS+IUSR5KqsATt/MUvogM2/Ob2KJcuErs+SAbrooCHAO7ai4FnVWIjEv6sW5upioJhQe0U
	oIm5yt0fpR
X-Google-Smtp-Source: AGHT+IHz5MAfkUB8H2U+X4Opj6NB0ta/4SEepskdKyPG77Ty3LlkB8Uvny/o7z5fI2DcCEhkb3ZvSg==
X-Received: by 2002:a17:90b:1802:b0:343:747e:2ca4 with SMTP id 98e67ed59e1d1-343f9177d72mr696406a91.9.1763061673216;
        Thu, 13 Nov 2025 11:21:13 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07b4b23sm6822395a91.13.2025.11.13.11.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:21:12 -0800 (PST)
Message-ID: <351b27a15b9222a48f720de17093ab24d14ec391.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] libbpf: fix BTF dedup to support recursive
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
Date: Thu, 13 Nov 2025 11:21:09 -0800
In-Reply-To: <bf00857b1e06f282aac12f6834de7396a7547ba6.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
	 <bf00857b1e06f282aac12f6834de7396a7547ba6.1763037045.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 13:39 +0100, Paul Houssel wrote:
> Handle recursive typedefs in BTF deduplication
>=20
> Pahole fails to encode BTF for some Go projects (e.g. Kubernetes and
> Podman) due to recursive type definitions that create reference loops
> not representable in C. These recursive typedefs trigger a failure in
> the BTF deduplication algorithm.
>=20
> This patch extends btf_dedup_ref_type() to properly handle potential
> recursion for BTF_KIND_TYPEDEF, similar to how recursion is already
> handled for BTF_KIND_STRUCT. This allows pahole to successfully
> generate BTF for Go binaries using recursive types without impacting
> existing C-based workflows.
>=20
> Co-developed-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Signed-off-by: Martin Horth <martin.horth@telecom-sudparis.eu>
> Co-developed-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Signed-off-by: Ouail Derghal <ouail.derghal@imt-atlantique.fr>
> Co-developed-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Signed-off-by: Guilhem Jazeron <guilhem.jazeron@inria.fr>
> Co-developed-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Signed-off-by: Ludovic Paillat <ludovic.paillat@inria.fr>
> Co-developed-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Signed-off-by: Robin Theveniaut <robin.theveniaut@irit.fr>
> Suggested-by: Tristan d'Audibert <tristan.daudibert@gmail.com>
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
>=20
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

