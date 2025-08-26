Return-Path: <bpf+bounces-66493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B66AB3515C
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDFA5E1EFD
	for <lists+bpf@lfdr.de>; Tue, 26 Aug 2025 02:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9C41F1313;
	Tue, 26 Aug 2025 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="AQqGOdtc"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD251FC3
	for <bpf@vger.kernel.org>; Tue, 26 Aug 2025 02:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173936; cv=none; b=IgPdWJ2dv/7U9BLwmLsPos+VvqSLvsmF9GtXIp7N1ykN8c7M+MMQAoCEzZVZ9K/8Ss3bfXbTT/1C+rce7hr2VUtTYHjYmp+fW3E429PNifk5O0enKJ5KG9rGVtu7GBoCmD9NGHGMTMVFCEz31PGHDXhH9tSByKTAejOPeTW/CIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173936; c=relaxed/simple;
	bh=r7GgSqRXBCbQrfPSvfmodqYz9sn8ph267VrXZuI9glc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEIMvd+ZUYwJFGuaBNmgXVg7RCKO+d83E+ypRRd4S3Mjikpw40BLX+aHBwVAP8DOealTZirzt5f0GnwBIqopn4wURoyipR5gMih2V/60nopBZ/Xt6sQ25hepzvIEYfgK7HVVQKR5Jun+YhJqe2H6t2MdLAoP9GWQfwQFU9mHdgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=AQqGOdtc; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.193.135])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 97B7044CA3;
	Tue, 26 Aug 2025 02:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756173929;
	bh=r7GgSqRXBCbQrfPSvfmodqYz9sn8ph267VrXZuI9glc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AQqGOdtcCz+s6HSMBpS5xbbtFSG0eU4OQ3pAKEAiJNpNBYPTXp8MaTVxaEouTwNTL
	 1dJgJljAVtHTU4XIzxbWFtsM/NKIdouKQyI4kx1muCURgth7qSCcgRp1XPk+qTzhoI
	 EecsOmth74llyetEBOFppQTiI6Swu/rpeCXORYEwpVvojQZZ4CUWgjkSeh2/02UwVv
	 ycKxhDB9rygElmlygJEDy4l0aL7JkVLMJV/o6xk+lc5madsEz8vvSzmROUFuLKd0T1
	 H+jd1AIHMeGdKQbQeA/ab7/JTe+pugtsOmHiQeHNwTE7sDjpEWhoHn0X7e6DMZeSPK
	 epMnI/x8Cwrsw==
Message-ID: <787555a1-1b18-4a76-8741-0fab4282f6f2@nandakumar.co.in>
Date: Tue, 26 Aug 2025 07:35:25 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, bpf <bpf@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Jakub Sitnicki <jakub@cloudflare.com>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
References: <20250825172946.2141497-1-nandakumar@nandakumar.co.in>
 <CAADnVQK4nhBTCOjP2dw85v9WSUW5rs_oThk9ME-TWBTjLwnspg@mail.gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <CAADnVQK4nhBTCOjP2dw85v9WSUW5rs_oThk9ME-TWBTjLwnspg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/25 06:19, Alexei Starovoitov wrote:
> On Mon, Aug 25, 2025 at 10:30 AM Nandakumar Edamana
> <nandakumar@nandakumar.co.in> wrote:
>> This commit addresses a challenge explained in an open question ("How
>> can we incorporate correlation in unknown bits across partial
>> products?") left by Harishankar et al. in their paper:
>> https://arxiv.org/abs/2105.05398
> Either drop this paragraph or add the details inline.

Okay, I'll drop it from the commit message and add it to the code like 
this, since it's useful information:

diff --git a/kernel/bpf/tnum.c b/kernel/bpf/tnum.c
index c98aa148e666..4c82f3ede74e 100644
--- a/kernel/bpf/tnum.c
+++ b/kernel/bpf/tnum.c
@@ -116,7 +116,7 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
         return TNUM(v & ~mu, mu);
  }

-/* Perform long multiplication, iterating through the trits in a:
+/* Perform long multiplication, iterating through the bits in a using 
rshift:
   * - if LSB(a) is a known 0, keep current accumulator
   * - if LSB(a) is a known 1, add b to current accumulator
   * - if LSB(a) is unknown, take a union of the above cases.
@@ -132,6 +132,11 @@ struct tnum tnum_xor(struct tnum a, struct tnum b)
   *    xx            00            11
   * ------        ------        ------
   *   ????          0011          1001
+ *
+ * Considering cases LSB(a) = known 0 and LSB(a) = known 1 separately and
+ * taking a union addresses a challenge explained in an open question ("How
+ * can we incorporate correlation in unknown bits across partial 
products?")
+ * left by Harishankar et al. in their paper: 
https://arxiv.org/abs/2105.05398
   */
  struct tnum tnum_mul(struct tnum a, struct tnum b)
  {

>> When LSB(a) is uncertain, we know for sure that it is either 0 or 1,
>> from which we could find two possible partial products and take a
>> union. Experiment shows that applying this technique in long
>> multiplication improves the precision in a significant number of cases
>> (at the cost of losing precision in a relatively lower number of
>> cases).
>>
>> This commit also removes the value-mask decomposition technique
>> employed by Harishankar et al., as its direct incorporation did not
>> result in any improvements for the new algorithm.
> Please rewrite commit using imperative language.

This will be my new message:

   bpf: Improve the general precision of tnum_mul

   Drop the value-mask decomposition technique and adopt straightforward
   long-multiplication with a twist: when LSB(a) is uncertain, find the
   two partial products (for LSB(a) = known 0 and LSB(a) = known 1) and
   take a union.

   Experiment shows that applying this technique in long multiplication
   improves the precision in a significant number of cases (at the cost
   of losing precision in a relatively lower number of cases).

Using uppercase for the character after "bpf: " this time, just to be 
consistent with other commits.

Similar changes for PATCH 2/2.

> "trit" is not used anywhere in the code.
> Use "ternary digit" instead.

Changing it to "bits" since other comments in the file already use it to 
mean trit (also, "digit" could be confused for a decimal thing). With 
another clarification, "iterating through the trits in a" now becomes 
"iterating through the bits in a using rshift". Hope it's okay.

I'll send v6 after waiting for a while for further feedback, if any.

> Keep acks when respining.
Sorry, I didn't get this. Is this something I need to do?

-- 
Nandakumar


