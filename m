Return-Path: <bpf+bounces-12623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 404177CEC35
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5C7E280DA3
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C2D3E007;
	Wed, 18 Oct 2023 23:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ezWv7vI2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117C15AFB
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:41:07 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD67395
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=TctgYXk4XdLLV71nRuQoEDnhgTF+kPhAoBLa+8gjjeo=; b=ezWv7vI2iirYjE5UIKGvKC4QCg
	ArQCgwLyCnFuHUJHwNMt78C35FVbupf54zyZvjiF4ODyMER5Q7kHkBtE8iSo8wXAzPpdysAG15XDn
	o+UWKbtvdN9Mh13ZEYxB5uZGa5jQCCi/+J3wquU7teFsFVqIRAv/KtIOTAHI3JSLU+2bN53sg30/C
	8Aeyq5v45gmCidglwKPZmW6VMhGKINKrESvjnyxGkzVadK7E1UPbV4/nP1zIvbnmztGdgviNCYziu
	cp1wQdZCWsA5dfNkFExU9Q6OVWFjOpjPbVtRy1KIYM0R91VjYgS7f2tIDygaBPXDikJoRi9sRRrHJ
	N00nfH/w==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qtG9r-000Oth-7n; Thu, 19 Oct 2023 01:40:59 +0200
Received: from [178.197.248.24] (helo=linux.home)
	by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1qtG9q-0004YK-VZ; Thu, 19 Oct 2023 01:40:59 +0200
Subject: Re: [PATCH bpf-next] bpf, docs: Define signed modulo as using
 truncated division
To: Eduard Zingerman <eddyz87@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
 <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <e2943b75-e47a-01f2-6b3f-a3ce666008cd@iogearbox.net>
Date: Thu, 19 Oct 2023 01:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27065/Wed Oct 18 09:49:14 2023)

On 10/19/23 12:34 AM, Eduard Zingerman wrote:
> On Tue, 2023-10-17 at 20:30 +0000, Dave Thaler wrote:
>> From: Dave Thaler <dthaler@microsoft.com>
>>
>> There's different mathematical definitions (truncated, floored,
>> rounded, etc.) and different languages have chosen different
>> definitions [0][1].  E.g., languages/libraries that follow Knuth
>> use a different mathematical definition than C uses.  This
>> patch specifies which definition BPF uses, as verified by
>> Eduard [2] and others.
>>
>> [0]: https://en.wikipedia.org/wiki/Modulo#Variants_of_the_definition
>> [1]: https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/
>> [2]: https://lore.kernel.org/bpf/57e6fefadaf3b2995bb259fa8e711c7220ce5290.camel@gmail.com/
>>
>> Signed-off-by: Dave Thaler <dthaler@microsoft.com>
>> ---
>>   Documentation/bpf/standardization/instruction-set.rst | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst b/Documentation/bpf/standardization/instruction-set.rst
>> index c5d53a6e8c7..245b6defc29 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -283,6 +283,14 @@ For signed operations (``BPF_SDIV`` and ``BPF_SMOD``), for ``BPF_ALU``,
>>   is first :term:`sign extended<Sign Extend>` from 32 to 64 bits, and then
>>   interpreted as a 64-bit signed value.
>>   
>> +Note that there are varying definitions of the signed modulo operation
>> +when the dividend or divisor are negative, where implementations often
>> +vary by language such that Python, Ruby, etc.  differ from C, Go, Java,
>> +etc. This specification requires that signed modulo use truncated division
>> +(where -13 % 3 == -1) as implemented in C, Go, etc.:
>> +
>> +   a % n = a - n * trunc(a / n)
>> +
>>   The ``BPF_MOVSX`` instruction does a move operation with sign extension.
>>   ``BPF_ALU | BPF_MOVSX`` :term:`sign extends<Sign Extend>` 8-bit and 16-bit operands into 32
>>   bit operands, and zeroes the remaining upper 32 bits.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

Eduard, do we have some test cases in BPF CI around this specifically (e.g. via test_verifier)?
Might be worth adding if not.

Thanks,
Daniel

