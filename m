Return-Path: <bpf+bounces-66404-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91789B347FB
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 18:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959671893E2F
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 16:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5993009DF;
	Mon, 25 Aug 2025 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b="ghVxC5g0"
X-Original-To: bpf@vger.kernel.org
Received: from mx2.nandakumar.co.in (mx2.nandakumar.co.in [51.79.255.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EF2797A3
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.79.255.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756140981; cv=none; b=uW9EdDnm+hpumJRbXz/4XPp0T1Qp78VYZKLpx9rCVsK5Covu1yUchKetqKERLV+2YStjY5BTFuca+CxSUCXeDTC5oa4JH5TaH9S6NRZiszAghBiBVRV27GlWnCn80KHooa0foawoIrF8qOnxjaq7iEQAw+EqsXo64/K0Xh5GnCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756140981; c=relaxed/simple;
	bh=MzdempL3bNXAFkTQSY5yqtTaNI12vuf5i3SVX4Fjihg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHVLgT77CceUKyTL+RWnPZJ8mJ4lG04ddLo+5stDOzKyIyD9uvnfbPPI4QRsEJ8kr9tsAdcaHVL5uhX2NCfItAvkhJBnNVY0wkWQU4ql/hjYUcNG1O4qbA/99v4FM8HMd4IbdgPvZdiFfMFo0eEvKH+bF7uMbba8ivK41qoeBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in; spf=pass smtp.mailfrom=nandakumar.co.in; dkim=pass (2048-bit key) header.d=nandakumar.co.in header.i=@nandakumar.co.in header.b=ghVxC5g0; arc=none smtp.client-ip=51.79.255.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nandakumar.co.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nandakumar.co.in
Received: from [192.168.29.2] (unknown [49.47.192.16])
	by mx2.nandakumar.co.in (Postfix) with ESMTPSA id 4BDBA4400A;
	Mon, 25 Aug 2025 16:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nandakumar.co.in;
	s=feb22; t=1756140975;
	bh=MzdempL3bNXAFkTQSY5yqtTaNI12vuf5i3SVX4Fjihg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ghVxC5g0SirGS8DgmednJZ3+/LjwXFN/Nyk1W+jyUjK4GxhobwMnWuloD9jHz9MSM
	 HXxekXMNIpJhDytX9cJlRSzRlf7gTEkpXpnD/3rEedvrpj0+OomYSm1ftY6MPI+c31
	 ND6CNlHLwYeoPEscYo7Dy1uqjdurezh9ublnEHg/DmNIMBzUUBrXtQuXDPhFgKwzwv
	 Gr1kzSyagqd29xptkMONw40IhOAXJMyPigcXMguTqPTUnc8QYf6f4hyAAXA7hUv1xx
	 1KKqNfJMw+fw/gPwkCwBDrctAQZSagW9K/nEzKUoIlj0i+wYClClxqXCv6u5/+mA1m
	 Wde7W5thktS3A==
Message-ID: <176c9fbe-2d0e-467e-86b2-358ec7a9d7cb@nandakumar.co.in>
Date: Mon, 25 Aug 2025 22:26:11 +0530
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
 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
 <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
 <132d5874-9a1f-496f-a08c-02b99918aa59@nandakumar.co.in>
 <5d15719140555e1213192aee9078efbd3ee43507.camel@gmail.com>
Content-Language: en-US
From: Nandakumar Edamana <nandakumar@nandakumar.co.in>
In-Reply-To: <5d15719140555e1213192aee9078efbd3ee43507.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 25/08/25 21:54, Eduard Zingerman wrote:
> On Mon, 2025-08-25 at 09:46 +0530, Nandakumar Edamana wrote:
>> Status as of now:
>>
>> DECIDED:
>>
>> 1. Replace the current outer comment for the new tnum_mul() with a
>>      cleaner explanation and the example from the README of the test
>>      program.
>>
>> 2. (Related to PATCH 2/2) Drop the trivial tests.
>>
>> UNDECIDED:
>>
>> Instead of just doing tnum_mul(a, b),
>>
>> a) whether to do best(tnum_mul(a, b), tnum_mul(b, a))
>> b) whether to do best(best(tnum_mul(a, b), tnum_mul(b, a)),
>>                         best(tnum_mul_old(a, b), tnum_mul_old(b, a)))
> I'd drop both undecided points.
Shall I send v5 with the decided changes then?

-- 
Nandakumar


