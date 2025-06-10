Return-Path: <bpf+bounces-60230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 520ADAD42BF
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 21:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27320189ECFE
	for <lists+bpf@lfdr.de>; Tue, 10 Jun 2025 19:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B99263F42;
	Tue, 10 Jun 2025 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MlkH3uZp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBBF29D19
	for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 19:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749583103; cv=none; b=ZfVN7YtC7xX1ic1fHjxsc78NzJlFaQtCDCZKc4gKYOIa56JAfND1Wsd76QUjUde82jfzqNsFHA1YtwXhanylHwGkJGShgQzklm2GH87wkOMGvsRacrPulluP175g0xAuOwulWc8qDSoHXAermiJ6890pDxaoONN2dC4bIqU4Y20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749583103; c=relaxed/simple;
	bh=JG0GNNgCehB165q4X5B6hfFoPnyPkaUu3ltox9eQG0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oLgNqN1lsmUUzLGFImJ5k22D9987D0nnaEpe3Q0/1kfOZX3dpeCzvnP8+VO+XX6AxpMNBxs5TDvGIAmfF2bFcs5/sOnYUqy6Wcaq1Z1/49UFiJj0+LFvIA2v3JxjX9CIUUrH9+ZRjFGLhE0pt1OfzbTc8AvR/kGbUmcPY271ED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MlkH3uZp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade4679fba7so555529366b.2
        for <bpf@vger.kernel.org>; Tue, 10 Jun 2025 12:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749583100; x=1750187900; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmDk4a3JTrCq4wi+JtQecU/19EMvC5rXn/D5aY7R9z0=;
        b=MlkH3uZpKOSA8nNLJzGNpahpU1Px7ylHg2ZZ7aLj3fDscS3d98CZTehgcfB9Pp98c6
         kxZ4gqA1NZZgkAHo0lTd8b3DUdKos1g9BxPtBNBHpLQIN05bh414SU5b8rFQvTk8tvfK
         y+cMBNgFYO3zWiBn/cd57DFdcznltejwDL0tFiWBALmHxnL2OU4vfcSdWQRF49tCJhlz
         RShmbLpizSUyCaKEGUPRSARhn6Dj4dRpAnHLvmd79jlkAD3LU1jwiAmFBU7CoLTH6SEr
         r+gEwKpy06+cXRALfx3ECeVkR2Z36XGu/PLNFzoTlNLNk41v4W1TYZ9Deby23i3nztLA
         mSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749583100; x=1750187900;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZmDk4a3JTrCq4wi+JtQecU/19EMvC5rXn/D5aY7R9z0=;
        b=fRqkWTZKk4PEuaQCXDfSXBoDWTwothCcSBtyUPZQl+6a6zdRhAHZFn02h8PmZOiQGR
         B+StL8B2JpQfc5CWvvZa4Q5VjMbK5BQdxU7df1Ts891Gx0x29MozGbBCNgR2e76D6H7u
         B1WdrfcG7pJpD+sR+ymI4C0MZuFilLV4TIrTA2b1RyuBCDbM0m0JzSf5NlWhB3Ad+5Yp
         W6eYbt/EmUNOGfAkKVLZ+yxAXk9OyCXi8MiBvqZXKFx2HLrhC08AJJbIFGt3qcY03wpR
         QvpkcJXacF+3KDFnfPtaaBnRdo+CCf6qQxhyd9HCSCy3HxvJi7sIg5OoyZBlacqW4fwS
         cuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXQm8qXXdKbcLX683frJPpt5GbSvJPD4pWOGeWsIyMoWXLS0FIcLvfnyz0EI2iQhyzNu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6lt6M6xS2uhChyjovacZfn8+dyJcUpGZjWU44ufxQcNqovGg
	ZIlO9CeyPCAaQEtX//Fq+Vf7+e3KrYGREusQ0WCKBjqR4tXE8uPHiY09naAOEyoZY5k=
X-Gm-Gg: ASbGncsvXNqqg27yS5qr3OC4Sjm8f0pcKaGs0aE5DXAOIvDpNt71JR6trkA58IlLJMn
	f6uRbM2668hvDdeRz4C74gyCJOggZIjNPuZVXKrY9+vpdfUJn6LSrrCWbL6/qYqvfu3aNX3tqor
	FUZBb5SMcToA9I5m7ZjIMFoKs/RRJXgzAiTQrtgyzXKVxmZ0p3OUE4EWfnhWkMDUZDgs2f3Vh84
	49fVVpsM7GHST9tKLcuU652KZSgi/gicFfBaUFkD1Bj7xNcTWb2MQA0XjGlF6JwJkQgRWdRs4Sv
	/aAmCKomqJFSaSripZkGv8O5WkA6qn8JSYldGGS9KPNGQzfYEXcTlCY6avM560xQF+c95AywLfU
	Y+qfa6WT5Nz+DFL69w1WAIIIWpeP/74OkhQ==
X-Google-Smtp-Source: AGHT+IFmV8Yhzk34tcxH5ScAzNLvJanN44RZgAj/ic3pEDJY5gncEjjGEPIqamb20SyFrfBytsA+7g==
X-Received: by 2002:a17:907:7e86:b0:ad8:af1f:938d with SMTP id a640c23a62f3a-ade8971ab02mr49568366b.37.1749583099765;
        Tue, 10 Jun 2025 12:18:19 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:a583:5a70:b94e:b183? ([2620:10d:c092:500::5:1505])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1db57695sm761983066b.70.2025.06.10.12.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 12:18:19 -0700 (PDT)
Message-ID: <255cad34-3d50-4762-b5aa-fc87b8b2a1ee@gmail.com>
Date: Tue, 10 Jun 2025 20:18:18 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/bpf/bpf_jit_disasm.c: fix potential negative index
 dereference after readlink failure
To: =?UTF-8?B?0KDRg9GB0LvQsNC9INCh0LXQvNGH0LXQvdC60L4=?=
 <uncleruc2075@gmail.com>, bpf@vger.kernel.org
References: <CAMxyDH3hfsN47sXqg1ZpRib=LpxV2ym32bnYj8gxi8eDGFtMLg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAMxyDH3hfsN47sXqg1ZpRib=LpxV2ym32bnYj8gxi8eDGFtMLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/10/25 17:12, Руслан Семченко wrote:
>  From d1adf16aa1c43b44b536532a8053521d119f2f11 Mon Sep 17 00:00:00 2001
> From: RuslanSemchenko <uncleruc2075@gmail.com>
> Date: Tue, 10 Jun 2025 15:24:10 +0000
> Subject: [PATCH] tools/bpf/bpf_jit_disasm.c: fix potential negative index
>   dereference after readlink failure
>
> If readlink() fails, len is -1, which could cause tpath[-1]=0 out-of-bounds
> write. Set len=0 if readlink fails, to avoid this.
>
> Signed-off-by: RuslanSemchenko <uncleruc2075@gmail.com>
> ---
>   tools/bpf/bpf_jit_disasm.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/tools/bpf/bpf_jit_disasm.c b/tools/bpf/bpf_jit_disasm.c
> index 1baee9e2aba9..5ab8f80e2834 100644
> --- a/tools/bpf/bpf_jit_disasm.c
> +++ b/tools/bpf/bpf_jit_disasm.c
> @@ -45,6 +45,8 @@ static void get_exec_path(char *tpath, size_t size)
>          assert(path);
>
>          len = readlink(path, tpath, size);
> +       if (len < 0)
> +               len = 0;
>          tpath[len] = 0;
>
>          free(path);
> --
I'm not sure if maintainers will be able to apply this patch.
Maybe try to resend it with `git send-email --to bpf@vger.kernel.org 
path/to/patch`
Subject, From, Date should not be in the mail body.


