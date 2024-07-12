Return-Path: <bpf+bounces-34700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C17493019E
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 23:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F8FB1C22B1D
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F054AEDA;
	Fri, 12 Jul 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wv6+fFH1"
X-Original-To: bpf@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF938DE4
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 21:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720819790; cv=none; b=SKsMBHrnqtUeOyUjyF2j9CjA3aBUDjKr9x3iZ1sqC7HYIXcLbvISIZjiJh9GT7F0H4nWaEo3lt8dXDHfCNHa1IWCSHyLxI1qPOt6hjUvnKe9KuNE5kTDCp6Nh41WoDxXSeBmSl8BP7wO0mfMAIn+BnOc/IRwBBPJVi8uqMBqSkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720819790; c=relaxed/simple;
	bh=ZrTc03es/iD+OzAQCjhq9b5HJJb0kuQwTeehZcbuavs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=huzKi3tDlDhwUQQS7rw89hFCXiPzvf+rx8ClH8RPOJH2DWEaEdm3GVqEMw0LAazAscWKtLv60Lfcaqk2822phPYIQ57l7epmTiS9YixSZLBYhTqxN0wX0EGSLdYZfpkm6DIjmBNkjLENlPifvHgmPbhwHSxH5z5dWem7vG+ieLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wv6+fFH1; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720819786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAxcEBiFq2WbTeB3C0shj1xsdJSXwYgH1K4BntmOBXs=;
	b=Wv6+fFH19wjf94wOXEq/KYZ9x54NJg2hquIzBY/oUIQGzSPLdUNpEuSFgBlgnWPK+qmFfc
	REHWXn2lnoVb2iCfeSd1UDJxj/X53BbsmzNzyCV4GwAKMCTIzMiqx38mZJ76+VccHM/aRe
	i3TABaf8xFjwn+15EZ287vo2vNFg8u4=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <aaf8bfd8-40bf-49a8-9bff-66461f4f24f3@linux.dev>
Date: Fri, 12 Jul 2024 14:29:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Get better reg range with ldsx and
 32bit compare
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240712202815.3540564-1-yonghong.song@linux.dev>
 <e05bd24690aab17ec0764e6318d13bf5690f6bdd.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e05bd24690aab17ec0764e6318d13bf5690f6bdd.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/12/24 1:49 PM, Eduard Zingerman wrote:
> On Fri, 2024-07-12 at 13:28 -0700, Yonghong Song wrote:
>
> [...]
>
>> +
>> +	/* Here we would like to handle a special case after sign extending load,
>> +	 * when upper bits for a 64-bit range are all 1s or all 0s.
>> +	 *
>> +	 * Upper bits are all 1s when register is in a rage:
>> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_ffff_ffff]
>> +	 * Upper bits are all 0s when register is in a range:
>> +	 *   [0x0000_0000_0000_0000, 0x0000_0000_ffff_ffff]
>> +	 * Together this forms are continuous range:
>> +	 *   [0xffff_ffff_0000_0000, 0x0000_0000_ffff_ffff]
>> +	 *
>> +	 * Now, suppose that register range is in fact tighter:
>> +	 *   [0xffff_ffff_8000_0000, 0x0000_0000_ffff_ffff] (R)
>> +	 * Also suppose that it's 32-bit range is positive,
>> +	 * meaning that lower 32-bits of the full 64-bit register
>> +	 * are in the range:
>> +	 *   [0x0000_0000, 0x7fff_ffff] (W)
>> +	 *
>> +	 * It this happens, then any value in a range:
>> +	 *   [0xffff_ffff_0000_0000, 0xffff_ffff_7fff_ffff]
>> +	 * is smaller than a lowest bound of the range (R):
>> +	 *   0xffff_ffff_8000_0000
>> +	 * which means that upper bits of the full 64-bit register
>> +	 * can't be all 1s, when lower bits are in range (W).
>> +	 *
>> +	 * Note that:
>> +	 *  - 0xffff_ffff_8000_0000 == (s64)S32_MIN
>> +	 *  - 0x0000_0000_ffff_ffff == (s64)S32_MAX
>> +	 * These relations are used in the conditions below.
>> +	 */
>> +	if (reg->s32_min_value >= 0) {
>> +		if ((reg->smin_value >= S32_MIN && reg->smax_value <= S32_MAX) ||
>> +		    (reg->smin_value >= S16_MIN && reg->smax_value <= S16_MAX) ||
>> +		    (reg->smin_value >= S8_MIN && reg->smax_value <= S8_MAX)) {
> Sorry, maybe there is still something I don't understand.
> Why do we need 3 different checks here?
> - S32_MIN <= r <= S32_MAX (R32)
> - S16_MIN <= r <= S16_MAX (R16)
> -  S8_MIN <= r <=  S8_MAX (R8)
>
> If R8 or R16 is true then R32 is true, so it seems this condition is redundant.

You are right! I changed from '==' to '>=' but missed this.
Will make changes in the next revision.

>
>> +			reg->smin_value = reg->umin_value = reg->s32_min_value;
>> +			reg->smax_value = reg->umax_value = reg->s32_max_value;
>> +			reg->var_off = tnum_intersect(reg->var_off,
>> +						      tnum_range(reg->smin_value,
>> +								 reg->smax_value));
>> +		}
>> +	}
> [...]

