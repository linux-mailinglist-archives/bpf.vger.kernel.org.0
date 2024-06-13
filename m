Return-Path: <bpf+bounces-32124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A012907D2F
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 22:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2040A2828B2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D286137921;
	Thu, 13 Jun 2024 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CykakbA/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DA136E1D
	for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 20:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718309406; cv=none; b=ZA9XXUM++vEdd0oz0hcr+CTR2G/gzd/xrnHmqaxGs0caxlJTNpTwvpG3ppzRkEQBHhvibb0SWkNitAQcmrrDumqIuv20zc+JARQHjp8zhO66DHv1cHGqPmRamfK9+NttzwQiUkIS7dXnwC82efnfZj4UyEzsAgZfUqqMo5TFY/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718309406; c=relaxed/simple;
	bh=0HJVhZW/lX+6fNJHl/MCkIekg2DzZsSd5bCmyazimvY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=euv4amqkhuyGBaoP3kG/3ZdLPmsm7GtPKsztCRRCCZC74NxIF5FToiX0PditZTMalWTyCfO1BrJbAM7rXt4LV5An1CCYDtmw2m9Gmv7U5xE9U6FrybfzNvG3sFxA7HIUHkGlkijf4OMk4AOsFa8ctOwfEs2nF4FKulEXc9wUHGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CykakbA/; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1f6da06ba24so13536215ad.2
        for <bpf@vger.kernel.org>; Thu, 13 Jun 2024 13:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718309405; x=1718914205; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYtr27yEpf8qu1sM+piGOkZN86Gu4jSL0ADFFJM4eZU=;
        b=CykakbA/cEWdJkew9Ec2yeWOd7Q8701M0vOAo4Aa4WLht8pE0q+BVS74LfM/LTkwpI
         UlZ5y7n6Ft+gPRWvxmxo5ZTixnfS5ZuIWpn14qsmi/lnafLETiapcMXZeAG7qACmHvEM
         0Fwn5XMib1R42B0/Orua5Vcz2HnkUJeU9Etwop3WTGOB2yha1KY7gGxsrZJclhv6EIxJ
         ZOKBIwMuq0HLirYA2hl2ddDgBJE4tmwV3BGdJa+YBRdPm+OR0PNLC9by78mDbC8dnTIM
         pUxoBYr8IWdSry5hPz0c622C9KlnM856PoW7gLZIatSIg901s3jEs7TQgDNWSCTHJ9t9
         f2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718309405; x=1718914205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYtr27yEpf8qu1sM+piGOkZN86Gu4jSL0ADFFJM4eZU=;
        b=O/eNFtocr14EE6sr4tPPRT1t2xbaMmHG8YtHik5F/9+ooM5HIs9iZ84ifR5/sgYShI
         Gr62XD2QQJwxKPY2vQBAGMvpn5lnwpynr8QIiaIA3cyqPZJR2SNvkjQ5IMpQfIIrsnRV
         EuvbbWL40RN1+W9cDfpjcgvG8MlkPVyP5akmp7QUkMxljF1vg8iOQ5kd/sO1h/F0s1tQ
         M2RaWWmZ+HoT9YBMqkMjm1DNSXFqfz6szF2kBXE37xw4CSWt9QDKRSZ9rjEZxpB8iCS+
         mpF9MkcdXjsFIgv5yyZDrxbC/P2zGtJAD49/bVjGTO3CO8qhlEoThCvDy/pntnIoLCXk
         nlZg==
X-Forwarded-Encrypted: i=1; AJvYcCXOtyyUY9LQSqTkJqb51WwMFsM/x/jOcbacTxyVomYU8z+zkhS0WSJ5Vbln+x+eNjFxnm2aLBZa0fM9k9szZBm6J7Sl
X-Gm-Message-State: AOJu0YzJJF7U4qv5TUp+8xOr7+OXsU/JgTkcNs4iAFpRx5ydbCW79r4F
	81ETw1w3Yz7ca8eL5hCtY6SJuA+kIETGYnLEqaSFjKqaeAK2RwDh
X-Google-Smtp-Source: AGHT+IGqBEQtnKNk6fm4ktEADphwjmbteIvoCUYUjdub9iqrqgLKwsFwlLd3+Tf6S79ZuIOpXHnRuQ==
X-Received: by 2002:a17:902:ecc3:b0:1f7:12c9:943f with SMTP id d9443c01a7336-1f862a03db3mr9142155ad.61.1718309404534;
        Thu, 13 Jun 2024 13:10:04 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e70efdsm18130345ad.89.2024.06.13.13.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 13:10:03 -0700 (PDT)
Message-ID: <6786876cd4b7eaf6c249bf5ed1e4ebf02f26aad7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Match tests against
 regular expression
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 13 Jun 2024 13:09:58 -0700
In-Reply-To: <20240613152037.395298-3-cupertino.miranda@oracle.com>
References: <20240613152037.395298-1-cupertino.miranda@oracle.com>
	 <20240613152037.395298-3-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 16:20 +0100, Cupertino Miranda wrote:
> This patch changes a few tests to make use of regular expressions.
> Fixed tests otherwise fail when compiled with GCC.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

The two tests below are __naked inline assembly,
so there is no need to change alloc_insn for them.

>  SEC("sk_skb")
>  __description("bpf_map_lookup_elem(sockmap, &key)")
> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>  __naked void map_lookup_elem_sockmap_key(void)
>  {
>  	asm volatile ("					\
> @@ -819,7 +819,7 @@ __naked void map_lookup_elem_sockmap_key(void)
> =20
>  SEC("sk_skb")
>  __description("bpf_map_lookup_elem(sockhash, &key)")
> -__failure __msg("Unreleased reference id=3D2 alloc_insn=3D6")
> +__failure __regex("Unreleased reference id=3D2 alloc_insn=3D[0-9]+")
>  __naked void map_lookup_elem_sockhash_key(void)
>  {
>  	asm volatile ("					\


