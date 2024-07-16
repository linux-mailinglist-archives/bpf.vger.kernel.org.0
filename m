Return-Path: <bpf+bounces-34933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13493343E
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 00:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6E2817E4
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 22:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24A13CA95;
	Tue, 16 Jul 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qUX6AzrA"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF1914A84
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169142; cv=none; b=Lecd4LQsHWjhsXdAQEQvUxqXhC2t4H7l3ISFuy+pnwCunDKGugnOl0SMidW/v+WwSsZKQ+xNTl812Wgi+dTEoJ4SNimsCMO6Jc9zoFWu0RaP6QYJtmQ0h+PgopIl+ot84jzL2vGGlQyvQUp9hg2UJ9WfwF+ev/T+mZD47OsN/7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169142; c=relaxed/simple;
	bh=zzeaUajOArXOd/CP1rc/kFyfY4SlQTzKQp9Yy1fTMwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YBEkQZuqq1c27zhR++G0myhFUBoRGGxWXM2dPXdZVUDbnjcFQTnRWAiqg7OXxVlOSgCZoipOk6ooFWQZadKQQExrNUoa79UnCXBLRArZF5PTtgAZNkygNMQoU04BJ2YkFyhDD+h+Qe7IwwMP0rBwJq9aVf6d9OcC368EoYNbPz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qUX6AzrA; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: eddyz87@gmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721169138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rfQwRFS1w0oh63l5whJjN0IhyciiIJVQC4SeLRyub5Q=;
	b=qUX6AzrATzie0p+yRJN5iJ3TVCabsOL8a6+rb8GtlJm+NDEsnfrBkfjOw7jYzztyaIptaX
	lTv/FEapPkJwKmYsUL6Mndv9T/Gb5t5WO5bosCtJgczDqn/B4z3aqY8OVR7G7jyrZX5vLy
	U8EG6Cfs/VroP4ipFEftKBSV8UpE9Pk=
X-Envelope-To: bpf@vger.kernel.org
X-Envelope-To: ast@kernel.org
X-Envelope-To: andrii@kernel.org
X-Envelope-To: daniel@iogearbox.net
X-Envelope-To: kernel-team@fb.com
X-Envelope-To: martin.lau@kernel.org
Message-ID: <a22346ee-5c99-4fba-8774-6ce78502d575@linux.dev>
Date: Tue, 16 Jul 2024 15:32:12 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add tests for ldsx of pkt
 data/data_end/data_meta accesses
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
 Martin KaFai Lau <martin.lau@kernel.org>
References: <20240715201828.3235796-1-yonghong.song@linux.dev>
 <20240715201833.3236556-1-yonghong.song@linux.dev>
 <7b985aa45f8277036c8b2ec50277daf987929fcc.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <7b985aa45f8277036c8b2ec50277daf987929fcc.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/16/24 12:54 PM, Eduard Zingerman wrote:
> On Mon, 2024-07-15 at 13:18 -0700, Yonghong Song wrote:
>
> [...]
>
>> +SEC("xdp")
>> +__description("LDSX, xdp s32 xdp_md->data")
>> +__failure __msg("invalid bpf_context access")
>> +__naked void ldsx_ctx_1(void)
>> +{
>> +        asm volatile (
>> +        "r2 = *(s32 *)(r1 + %[xdp_md_data]);"
> Nit: this test fails at the first instruction,
>       hence there is no need to include it's tail.
>       I think it would be good to keep these tests minimal.

Okay, I will shorten the test to have minimum instructions
to reproduce the issue.

>
>> +        "r3 = *(u32 *)(r1 + %[xdp_md_data_end]);"
>> +        "r1 = r2;"
>> +        "r1 += 8;"
>> +        "if r1 > r3 goto l0_%=;"
>> +        "r0 = *(u64 *)(r1 - 8);"
>> +"l0_%=:"
>> +	"r0 = 0;"
>> +        "exit;"
>> +	:
>> +        : __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
>> +	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
>> +        : __clobber_all);
>> +}
> [...]

