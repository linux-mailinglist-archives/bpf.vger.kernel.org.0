Return-Path: <bpf+bounces-39634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5638197590B
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 19:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898C71C23081
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 17:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8F01AF4D7;
	Wed, 11 Sep 2024 17:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLycDx/N"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA8156993
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726074461; cv=none; b=mjXIuKp+jEiuSsR1nCgYbdiq0IUxVOHktqUW4ebcZLLVDCqsvtamYlgQcENYeNNtNn3P3S0M2DS72dhSk0ClEsX5VyAgSK9ZHMiFkq8epDAFhrqteZiwvSO7PsiXSi3ApBJsuxU/Cfbnr/MjXo1Arj1CKcFRhdm1bGwJ01IB7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726074461; c=relaxed/simple;
	bh=kfrMd54Rv/tbx21SsUF9VnOm9SWGmYotr1h3DVHPyMU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nRj4gpV0Psm8HeVJ6C75O+o7dy8pYvo55XwFXiBV5kNnPYNhVGu5EdOQ4Y4HqAD/lWXOPh38ftIzbKjeRqTm2xld60TimsQ/ryGAOmCTXbCronAJZnepBarU9LUcKtnwx2pXL0eu7APCMJ6PLoZ6aXd448oSc4QuxZCtYv+QZv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLycDx/N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-205659dc63aso1291815ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 10:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726074459; x=1726679259; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zF9LoJCEnED01Pht5QgiZ9Hpag4b3bpwdJaTk8J38Zw=;
        b=TLycDx/NFw3mZrdXkk3u0QEKbxvcRVpnvIMvvrcS5HlHQmukRoFnPSngUXnNelnKAc
         Iyd/e1Alz7eG1iTUJ+xTCyoLOKZ0fIcC+oW9qkY4OA5tEG+P+DAwZy1w563Lj8NqACuZ
         LZuW4ZVeRZfzOzN6E3qghajUNIm2iTr94BQFZZvAljSgNKTvKLv//agVj5YBXT2rJsws
         SEYLenN2F+GGUcYm5syjEqXbZzKLpjVYNeCiyd9J0hMgquS1ColBQJhYvLMtDv1Zhlkx
         dc37j7UL/Rz/8SW/sMZJWqs010J+y62i1SQBboPGCDFNIWZi38fGu4eA66vAlSF45M0k
         5GXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726074459; x=1726679259;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zF9LoJCEnED01Pht5QgiZ9Hpag4b3bpwdJaTk8J38Zw=;
        b=UUuiORRKBTcGANgljitSf/wcyy/xRyrSAbe5Vwx1g9cl1k0NGbFMSh6wJH/1Ft9Elv
         eYC11Fo3AXqK5n8kkNY1zM0jtxMXInfiWW66iDV4EZgj4aulnIExRu1xxcMKOViZA/yn
         a90j8ziL5si/D8b+LnTW4k5WwLYYnH46jzc0CjPV2QxnBKTIr2j65evT/q9C9bM+CLRr
         svQEEnX9zW33Mw6KwvpOWfSyWJnLl/vO3Iu2iDzb7o0a4RH1LBxY5v1fO2APNtmtGbTv
         KgGp0qq/HTTA+kd87nfos2Ig7OxEFIAp/guIXxV9InsEZe7a2V7smY8YLE/llFUvogAB
         hgKA==
X-Forwarded-Encrypted: i=1; AJvYcCXl7ro6CyDVmCPK036RHr5hSIDNAwCjjO6XQeNqbX/mXN5b1IfQf1jIhASmYjfDthneX2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcUGgbB8oeGdEyLEszhgg3/VqjbhvVAmQkl9VHW1eSwTGraGI
	ZvJsupAmoHIfLJDOH9Ura7+3y9oXGwfIWCuEAdrOJB6444Sy4dsV
X-Google-Smtp-Source: AGHT+IFpABIqDd5iG10twknQYGKQPUFF21BR0iELbixv2DQNdT0uVtR8PDpaU/xopjiYPgKYUtBKeg==
X-Received: by 2002:a05:6a21:3a84:b0:1cf:4705:9483 with SMTP id adf61e73a8af0-1cf5e1570b0mr5901028637.36.1726074459062;
        Wed, 11 Sep 2024 10:07:39 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090ae309sm3193388b3a.164.2024.09.11.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 10:07:38 -0700 (PDT)
Message-ID: <4a46fa4393545f54a76f0ffd2fa19d3f0a978d1f.camel@gmail.com>
Subject: Re: [RESEND][PATCH bpf 2/2] selftests/bpf: Add more test case for
 field flattening
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hou Tao <houtao@huaweicloud.com>, bpf@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Song
 Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Kui-Feng Lee
 <thinker.li@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Date: Wed, 11 Sep 2024 10:07:33 -0700
In-Reply-To: <20240911110557.2759801-3-houtao@huaweicloud.com>
References: <20240911110557.2759801-1-houtao@huaweicloud.com>
	 <20240911110557.2759801-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-09-11 at 19:05 +0800, Hou Tao wrote:

[...]

> diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/=
testing/selftests/bpf/progs/cpumask_failure.c
> index a988d2823b52..e9cb93ce9533 100644
> --- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
> +++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
> @@ -10,6 +10,21 @@
> =20
>  char _license[] SEC("license") =3D "GPL";
> =20
> +struct kptr_nested_array_2 {
> +	struct bpf_cpumask __kptr * mask;
> +};
> +
> +struct kptr_nested_array_1 {
> +	/* Make btf_parse_fields() in map_create() return -E2BIG */
> +	struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];

Hi Huo,

I think some headers are missing, I see the following error when
compiling this test:

progs/cpumask_failure.c:19:33: error: use of undeclared identifier 'BTF_FIE=
LDS_MAX'; did you mean 'BTF_KIND_MAX'?
   19 |         struct kptr_nested_array_2 d_2[BTF_FIELDS_MAX + 1];
      |                                        ^~~~~~~~~~~~~~
      |                                        BTF_KIND_MAX

[...]


