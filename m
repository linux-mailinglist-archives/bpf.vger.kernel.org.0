Return-Path: <bpf+bounces-78711-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C452D18F37
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 13:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D71423034A19
	for <lists+bpf@lfdr.de>; Tue, 13 Jan 2026 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55F938E5FB;
	Tue, 13 Jan 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="UJCF6D6L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D605138E5DB
	for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768308740; cv=none; b=XD1IEdMjJCabO/mLotoFlIGfVq2Wug0lJtYbbDchYMUPFylD/2Yk/k+aUiCrK5fgYdiGmjeGJPKkwLyUobq/Z3l8iliYPuWmNho4eadC4kPZW8HWUuTED3jcgFPzmyLvAJLx7beVEfpOGYeimQ9c+k5EpKxdj+GKCIO0i7cvLaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768308740; c=relaxed/simple;
	bh=M3cd1ChoyL/JPoUh1TebMNfZNb0CMOQ+wKlup/AKWzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d8+xXMldUYZRoKFopKzLXkTZp/aic/zuznCTgy3i0faVTHhcT3/uFHFZsQ06DIedZERUF0G17w+MGkURSsKyzF5Br5FC3sYm6LbtFv2ueZrWQSf69tEVgnD+UsdnjBRn6Y/OrAEbSEzMgm3ThIXTqszyQTRAY8ZF2RcdXNj33rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=UJCF6D6L; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8719aeebc8so349962266b.3
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 04:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768308737; x=1768913537; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uEb4fpri3npogF5JFpOtWuoL+P7ayMQsw+8rwNvJPCI=;
        b=UJCF6D6LC6b8pKI37H8H6uwCtxnY+bmQP6DMaYddWTbJSgZpLHhTbQM358bn5S5xS4
         qIgDKfHKxt5ShNajmTZNOhEI6lk6dyOQlTDrirBc/A8rsebRG2RSVrBTNrtAR/k50ezj
         AB+B9ZIrmnZaUo5Vu04Dm+3jgdsJRSOCRFDr4H5yrjPn7XTa+kAMk/t9Y5NDkRDalhwr
         e4+ATGp6OfT6Aq2vke/Sp/Vc/a4sn0E/FUdSLjGXS/ugfe72mM9LiZFsoQwavbbTYCpf
         GsUqSfYGJKTk+3x7IhEJJyA7wHrHwyORGItLVyEzl8TDBE/0z6oGOgxGBlnYiq7omenn
         i3tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768308737; x=1768913537;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEb4fpri3npogF5JFpOtWuoL+P7ayMQsw+8rwNvJPCI=;
        b=wvGz0Jpq+TejO53+ZGrGQOoQv0wZdeBlAMY13z6fN5JivwSOIyqTb9/iyiopotR5lK
         HgkEfSyUOotYVISIxrWtv/xZ9kBVEG8t4xfCyrG/SkbQC+3a/yHGhdDv1OPy8MORj7yu
         NaUVWZATgpTQQZm/ET+yGQnXd2GsT8Sc0ZaN0IsWZce7pcB9kqn9OQoYfwXxHf+mSg+w
         rXFt5YX4V+aUcyZBLoOWoFejKeRg5KYuuR1Th7gDcLWA+/Tdm2j25wXzBBD35+viSUF3
         i7aWfuoPhmI2NAhvMdzxacSgUYWOoOgKqpLk4DeQ/GrYXmiDGI00Sz3pk/508yqLrbT3
         5Juw==
X-Forwarded-Encrypted: i=1; AJvYcCW9QeCg8da+GQfAxxQQQxtdMAWLeubpzB1FhCbAs9wdeYLrvfvYRzf+ecLsLp77KX/EGv0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6g8KSJ0Zh6BRggup+DpJhBvzo2yZWkfWjVedjK/lJDk/FfVms
	kAvoj87G01aYKlY0npmMmyJ8N8HBhwAc9e/4hvHmIegBEV0BSPJHYhVLhjOIAgnM5J4=
X-Gm-Gg: AY/fxX4w9lyd/saxaPsrtIfE0NNf6Po2BIZEJk/U4vStyPy3zYucsdTsm3CK4thIJKs
	6nk2ErDH4Wiyl4M8bUOvXjdWtEFf9c14CSUfovgK53SJ04wTsmXvHmcvRkfJAUhtXjv2DYUzIhR
	tOUW6LHFKXpz6ztnlUI8qwwpf2G6qn7EsaTBQ0ROIjv11xAbrLcahHj6xEQKgX5OjG5VGTwVk/q
	n5jh1E4I5dGNAA4/6oNM07w49PJlzyb4BNOsCEt+3XiMnuZHjSNsyNDYsRcvSoSSVwOfeUhnh3V
	KNyDwfgbrTz4XDjROAh7YmbSIOIMcq00+9Od2AatuxcDMc8uc/wPQOW7Z0wWmuQrIM5jZtDok1n
	ILmKpxcJrEg959yN0S6XO4UgTmxWSwuuGKgwCw0iy/cnJr9RfU8wK6zWofV8eDKyVJMqKqUVQYk
	XtUbO4rtzo8NyQ
X-Google-Smtp-Source: AGHT+IFX81GRz/hwINL72rPQLm6j5tregnFNpNUvMTj08WVBOxYe/hO3B2KEOTqbE2tiVZ7xDeaggw==
X-Received: by 2002:a17:907:7293:b0:b87:2fcd:1955 with SMTP id a640c23a62f3a-b872fcd1bf1mr388012666b.50.1768308737057;
        Tue, 13 Jan 2026 04:52:17 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:1cb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm780426066b.16.2026.01.13.04.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:52:16 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Michael Chan
 <michael.chan@broadcom.com>,  Pavan Chebbi <pavan.chebbi@broadcom.com>,
  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Saeed Mahameed <saeedm@nvidia.com>,  Leon
 Romanovsky <leon@kernel.org>,  Tariq Toukan <tariqt@nvidia.com>,  Mark
 Bloch <mbloch@nvidia.com>,  Alexei Starovoitov <ast@kernel.org>,  Daniel
 Borkmann <daniel@iogearbox.net>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  John Fastabend <john.fastabend@gmail.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  intel-wired-lan@lists.osuosl.org,
  bpf@vger.kernel.org,  kernel-team@cloudflare.com
Subject: Re: [PATCH net-next 07/10] mlx5e: Call skb_metadata_set when
 skb->data points past metadata
In-Reply-To: <4261e437-84b2-4d0d-af52-c5ee7fcf07cb@gmail.com> (Tariq Toukan's
	message of "Tue, 13 Jan 2026 08:08:48 +0200")
References: <20260110-skb-meta-fixup-skb_metadata_set-calls-v1-0-1047878ed1b0@cloudflare.com>
	<20260110-skb-meta-fixup-skb_metadata_set-calls-v1-7-1047878ed1b0@cloudflare.com>
	<4261e437-84b2-4d0d-af52-c5ee7fcf07cb@gmail.com>
Date: Tue, 13 Jan 2026 13:52:15 +0100
Message-ID: <873449wu80.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 13, 2026 at 08:08 AM +02, Tariq Toukan wrote:
> On 10/01/2026 23:05, Jakub Sitnicki wrote:
>> Prepare to copy the XDP metadata into an skb extension in skb_metadata_set.
>> Adjust the driver to pull from skb->data before calling skb_metadata_set.
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>> b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>> index 2b05536d564a..20c983c3ce62 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/rx.c
>> @@ -237,8 +237,8 @@ static struct sk_buff *mlx5e_xsk_construct_skb(struct mlx5e_rq *rq, struct xdp_b
>>   	skb_put_data(skb, xdp->data_meta, totallen);
>>     	if (metalen) {
>> -		skb_metadata_set(skb, metalen);
>>   		__skb_pull(skb, metalen);
>> +		skb_metadata_set(skb, metalen);
>>   	}
>>     	return skb;
>> 
>
> Patch itself is simple..
>
> I share my concerns about the perf impact of the series idea.
> Do you have some working PoC? Please share some perf numbers..

Sorry, nothing to show yet. I've shared more context in my reply to
Jakub [1].

The series itself is an interface cleanup, whether we end up needing it
for the metadata effort or not. Hence I wanted to salvage it from [2].

[1] https://lore.kernel.org/all/87bjixwv41.fsf@cloudflare.com/
[2] https://lore.kernel.org/r/20260107-skb-meta-safeproof-netdevs-rx-only-v3-0-0d461c5e4764@cloudflare.com


