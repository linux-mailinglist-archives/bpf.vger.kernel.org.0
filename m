Return-Path: <bpf+bounces-66328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B308BB32575
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 01:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DF9C1CE8755
	for <lists+bpf@lfdr.de>; Fri, 22 Aug 2025 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D952877E6;
	Fri, 22 Aug 2025 23:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="qSRAJSCA"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61FE1B041A
	for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755906544; cv=none; b=nDD1f8hFlprSRSpm3vFjA8THhpgnQGplQ32Gw2kKXx5Rf+s0DjPvj5mnqcnuQLSX1RVkgoYVhmBf618E7DlsAN3b0b7Rk7NHjI8tiouBD9N+3vXzTQKtWDV/oxU7m1LuaxBGMkBX0en5jWcAy37bdkphNEatfzfJj7cV2EJm/rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755906544; c=relaxed/simple;
	bh=AssGBvnGXD5Vk2qj1KDrxitnt5zTWdqc2iZ2zMJzNnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nX1VvsUefLxMV3YkzpMlFK6MLxRgYAavwG7IH0UXRHQd7oJBph9XXzhGrRPbt7JWz5o6n5TFYoYh678sBsc/aZURKOBufGePO0J3TWmSP/HbLbsMJfDpl0Df/Ga7xY+Jy0q/1wdUt4EgVVcMG5sqYgmbLdvk036U4IDpDZDMKHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=qSRAJSCA; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.193.92])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id B903944CA7;
	Fri, 22 Aug 2025 23:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1755906538;
	bh=AssGBvnGXD5Vk2qj1KDrxitnt5zTWdqc2iZ2zMJzNnw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qSRAJSCACU9hNmSyliT2/tdPgflalSfWk4Yn65s5RRAl5u1jHkTBFaYTeMSu8dZdq
	 bWjsPGfA/QekRq2cxubDsFBEWs9AhaUC2QdcW5yzv3q9ubJwfoLycgQkmAaYwWnByO
	 QoKa58SsOzBzP3o9U4knWU59/X53NbHzOqHnPT8U8JmnF66dHaxBU0Lps+AerwiaTi
	 RSITWx7hKdJm2KlUDeBLtK9t4Fc6JSNWEYIuDSZDN7On+b0/BUDA5J70yWpHv8j3Ji
	 TV9539UBJV4EJHux9DbSVHhizkx7qlCKj6q07kUpVNL42/gbUt0CeQtc68mzEXosvU
	 WXh4Wi1aZ5GIw==
Message-ID: <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
Date: Sat, 23 Aug 2025 05:18:50 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/08/25 03:20, Eduard Zingerman wrote:
> It is not practical to do such sum tree exploration, of course,
> but I stumbled upon the following simple optimization:
>
>    @@ -17,7 +17,7 @@ struct tnum tnum_union(struct tnum a, struct tnum b)
>            return TNUM(v & ~mu, mu);
>     }
>     
>    -struct tnum tnum_mul_new(struct tnum a, struct tnum b)
>    +struct tnum __tnum_mul_new(struct tnum a, struct tnum b)
>     {
>            struct tnum acc = TNUM(0, 0);
>     
>    @@ -43,6 +43,14 @@ struct tnum tnum_mul_new(struct tnum a, struct tnum b)
>            return acc;
>     }
>     
>    +struct tnum tnum_mul_new(struct tnum a, struct tnum b)
>    +{
>    +       struct tnum ab = __tnum_mul_new(a, b);
>    +       struct tnum ba = __tnum_mul_new(b, a);
>    +
>    +       return __builtin_popcountl(ab.mask) < __builtin_popcountl(ba.mask) ? ab : ba;
>    +}
>    +
>
> For the 8-bit case I get the following stats (using the same [1] as
> before):
>
>    Patch as-is                 Patch with above modification
>    -----------                 -----------------------------
>    Tnums  : 6560
>    New win: 30086328    70 %   31282549    73 %
>    Old win: 1463809      3 %   907850       2 %
>    Same   : 11483463    27 %   10843201    25 %
IIUC, this is same as what my test program [1] does with the 
`--commutative` option, and yes, it improves the precision slightly. 
There is one more possibility: run both the new tnum_mul() and the old 
tnum_mul(), and then pick the best one (still doesn't become optimal, 
based on experiments).
> Looks a bit ugly, though.
> Wdyt?

Well, I was afraid of the same and that's why it wasn't included in the 
patch.

It is clear that picking the best like this doesn't make it unsound. If 
my understanding is correct, tnum_mul is not something that is called 
very often in usual cases. So it shouldn't affect performance either. 
Then it boils down to the beauty of it. I personally don't think 
`best(a*b, b*a)` is ugly. What about `best(oldprod, newprod)`, where 
oldprod and newprod are each found like this, using the old tnum_mul and 
the new tnum_mul respectively?

[1] https://github.com/nandedamana/improved-tnum-mul

-- 
Nandakumar


