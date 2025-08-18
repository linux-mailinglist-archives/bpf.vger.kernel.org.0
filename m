Return-Path: <bpf+bounces-65892-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7E8B2AB88
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 16:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAE2B7A7A59
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0908521C195;
	Mon, 18 Aug 2025 14:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="UnXjeXl8"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A572153ED
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 14:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528647; cv=none; b=PX8L26mDN+wdnFDye4NiA9qoUh9V9MzFH+VTRCqgPncuNhwjA4HjCLAw9+WmsrEuk/pFowHVudur2cJYcpC8AY1s1bAIEmpz156AeFrDLi04bwCMQi0eiTCB9OcXq4MNaPnb87Ivja1kmxzyy41kL+CeU60S9oQytB8p2+lxMlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528647; c=relaxed/simple;
	bh=9H1J344v3Pc6fnXus5KJLzucRAqVHHf2xcsC9+7dt9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CI9UcyiWbx52cb0jfZTn3Bw91BZVxB5Igv6OhIo/+A1utmVoK3YnP3KQdorMft3CiT10LcyUWHwPbydUGxaWNR5BjxClZm0z1XbzLZ0R2OR6dMxk+RigWyOmGMFJwW5K8TN4gPYOfj+mrETsKWDPAlkzWZoVcLuiKTOiajZk5pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=UnXjeXl8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Pi1wHffZyWE9x5oZ4ptrOVZZgsqpLEOiLVbR27jScvM=; b=UnXjeXl84zhaD5Bxb0gvyuzcJ8
	eS2h7ptzTuP5OqEl+hE8Vv58myi121eN8u3NCfHz5K7m2Cg3Y/g7V1EIbc+LQcBiMdKqyPfk5jBde
	C0EQWthO0jkwkPl+D5bb4FvvgDqCfjqfWjMU8UqzATpaU23yhd8anhVDlfb8bJNs5mioUTE8WuImd
	dcgzLmWw4SN6NKC7TemhPNRAhGwkbQrOBPZQaDPgm1Q4VuMZgLOFgJ75f7k32npC0EjKYU0ZvyKbY
	46Z54DmPSS4UgmWB9f1JdSQnzoEDoGz6E8ADt1DvHvn2NdVG7Adu1VXcwkZybXqhVbB+ER8XE9Z5p
	TIu3H6Lg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1uo1C7-00007F-13;
	Mon, 18 Aug 2025 16:50:43 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy03.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1uo1C6-000DoX-28;
	Mon, 18 Aug 2025 16:50:42 +0200
Message-ID: <729e6325-da97-4f01-97b7-3fc966c3fda7@iogearbox.net>
Date: Mon, 18 Aug 2025 16:50:42 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bpftool: add kernel.kptr_restrict hint for no
 instructions
To: Quentin Monnet <qmo@kernel.org>, Vincent Li <vincent.mc.li@gmail.com>,
 bpf@vger.kernel.org
References: <20250808145133.404799-1-vincent.mc.li@gmail.com>
 <d9e524a6-6296-4a5a-941e-65cca7d72bcd@kernel.org>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <d9e524a6-6296-4a5a-941e-65cca7d72bcd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.0.7/27736/Mon Aug 18 10:27:28 2025)

On 8/8/25 5:49 PM, Quentin Monnet wrote:
> Please run ./scripts/get_maintainer.pl and Cc all maintainers for your
> future submissions, in this case: all BPF maintainers/reviewers.
> 
> On 08/08/2025 15:51, Vincent Li wrote:
>> from bpftool github repo issue [0], when Linux distribution
>> kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
>> instructions returned", this message can be puzzling to bpftool users
>> who is not familiar with kernel BPF internal, so add small hint for
>> bpftool users to check kernel.kptr_restrict setting. Set
>> kernel.kptr_restrict to expose kernel address to allow bpftool prog
>> dump jited to dump the jited bpf program instructions.
>>
>> [0]: https://github.com/libbpf/bpftool/issues/184
>>
>> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
>> ---
>>   tools/bpf/bpftool/prog.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
>> index 9722d841abc0..7d2337511284 100644
>> --- a/tools/bpf/bpftool/prog.c
>> +++ b/tools/bpf/bpftool/prog.c
>> @@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mode mode,
>>   
>>   	if (mode == DUMP_JITED) {
>>   		if (info->jited_prog_len == 0 || !info->jited_prog_insns) {
>> -			p_info("no instructions returned");
>> +			p_info("no instructions returned: set kernel.kptr_restrict to expose kernel addresses");

Can we align this to sth similar as we have further below in that same function?

   p_err("error retrieving jit dump: no instructions returned or kernel.kptr_restrict set?");

(I presume the former we'll see for interpreter-only case.)

>>   			return -1;
>>   		}
>>   		buf = u64_to_ptr(info->jited_prog_insns);
> 
> 
> Thank you Vincent!
> 
> We have the same hint for the xlated dump some 7 lines further in the
> file. As we discussed off-list, this hint was initially printed for both
> cases, JITed and xlated dump, since commit 7105e828c087 ("bpf: allow for
> correlation of maps and helpers in dump") from Daniel, back in 2017. It
> was kept for the xlated dump only after commit cae73f233923 ("bpftool:
> use bpf_program__get_prog_info_linear() in prog.c:do_dump()"), I believe
> by accident.
> 
>  From what I understand, the kptr restriction should not be relevant in
> the case of xlated dump (it does change the information we can print -
> it prevents us from retrieving __bpf_call_base from ksyms - but should
> not prevent bpftool from retrieving instructions entirely). Daniel, it's
> been a while, but do you remember why you printed it for xlated dumps
> too? If not, we should probably just keep the hint for the JITed case.

Indeed been a while - my understanding is that we don't return xlated in
case of not having the right capabilities or when the program got constant
blinded so we don't want to expose the latter from the kernel back to user
space when kptr_restrict is set.

