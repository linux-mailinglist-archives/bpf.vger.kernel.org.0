Return-Path: <bpf+bounces-69942-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82CABA8BD0
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 11:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D254189F8F4
	for <lists+bpf@lfdr.de>; Mon, 29 Sep 2025 09:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9F42E542C;
	Mon, 29 Sep 2025 09:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9z1KylJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068D2E5405
	for <bpf@vger.kernel.org>; Mon, 29 Sep 2025 09:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759139351; cv=none; b=uWV87wOGL87wMhBhUhP5qZgdzYbEW1mLOj03UgOuMyF2yrjVIOr3CcThD7kO04vFOVnRgt4EsfUThdxDNv96WM13g4EMtXZxV+rIj8e1eODIT4z8hGoqG75wpVNNEbJp/gTLP5uCMmJtz64+LBtZqPvFEVKLoVg/s+me3vObCNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759139351; c=relaxed/simple;
	bh=4bQtwwqiwbalnzLQYd4Y/n6mpDu2/MojfzId1ldvJ9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SNoRBESocs+y8r7/3RX9NVoCWL39W30zu6kKPntLnmKsQFhSz0KxLMRSjUlNA9X7AoMlvl33p7nRlWqqA6H9q2VmqvqliXE6+KmfHskadZzi3SbwY6XER+AbszzTuWTAYpWhY235qzjv7axiuUcdgwIj2LIx32bNsx8b901v8rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9z1KylJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7A2C4CEF4;
	Mon, 29 Sep 2025 09:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759139350;
	bh=4bQtwwqiwbalnzLQYd4Y/n6mpDu2/MojfzId1ldvJ9Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m9z1KylJhJtEunV/hqjWWnmeE/rvgQosny3db2YwiPIjco6aIxQeyvxQY4lhBGdsc
	 bQrtvcW7vhM0bSGztlkEPvQ3XrAp3jfSXrDuyFiLnneSVBfhWx4nTo7/FN6fTCBtwC
	 hejuKQ83PXY4vHpYiu6MHnLgFJMpCd3M2yFdKhXLomT2/30HJCjjaTnRWgh1fN6fGf
	 AqwX6K0QIm3tJhoYZ5sEt1k1z6S/7yz+T59I+JmHjkvADWr1SOARMu46/uMGX7G+4r
	 O8xsZgSw7tDWtbrTSYWrNAJC0ekrD9rO4fIh30qpL7zhRzvPr8oSPrtRNm4qmPjDnm
	 EIcnDYXt/doYA==
Message-ID: <0140f268-7590-4cb8-84a6-67972e2bd28e@kernel.org>
Date: Mon, 29 Sep 2025 10:49:08 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] bpftool: Formatting defined by user:fmt: decl tag
To: Nick Zavaritsky <mejedi@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Yonghong Song <yonghong.song@linux.dev>
References: <20250921132503.9384-1-mejedi@gmail.com>
 <20250921132503.9384-2-mejedi@gmail.com>
 <fccfa1f1-75a6-4094-9389-7e01b20833b2@kernel.org>
 <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <3EB389B2-437D-40AF-8D6A-9332795C0587@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2025-09-25 13:11 UTC+0200 ~ Nick Zavaritsky <mejedi@gmail.com>
> 
> 
>> On 23. Sep 2025, at 13:22, Quentin Monnet <qmo@kernel.org> wrote:
>>
>> Note: For future submissions please make sure to add the maintainers in
>> copy for your message, "./scripts/get_maintainer.pl tools/bpf/bpftool/"
>> will give you the list.
>>
>>
>> 2025-09-21 13:24 UTC+0000 ~ Nick Zavaritsky <mejedi@gmail.com>
>>> Certain data types get exceptionally unwieldy when formatted by bpftool,
>>> e.g. IP6 addresses.
>>>
>>> Introduce custom formatting in bpftool driven by user:fmt: decl tag.
>>> When a type is tagged user:fmt:ip, the value is formatted as IP4 or IP6
>>> address depending on the value size.
>>>
>>> When a type is tagged user:fmt:be, the value is interpreted as a
>>> big-endian integer (2, 4 or 8 bytes).
>>
>>
>> Hi, thanks for this!
>>
>> I'm not sure I understand correctly. The 'user:fmt:*' tags are not used
>> yet, correct? So you're proposing to add it to existing code to get a
>> fancier bpftool output. Do you mean adding it to your own executables?
>> Or to existing kernel structures/types?
> 
> I don’t intend to touch existing kernel types. This feature targets ebpf
> projects that wish to make it easier for humans to process bpftool dumps
> of their maps.
> 
> By having it in bpftool, we eliminate the need for custom post
> processing. Bpftool can “make it easier for humans” more reliably since
> it has access to BTF (and tags). It is hard to write a generic post
> processor that improves the presentation of e.g. IP addresses.
> Pattern-matching will work for IPv6 addresses. For ports and IPv4
> addresses not so much, unless wrapper structures are introduced (e.g.
> struct{__be32 ip4addr;}). Wrapper structures will make ebpf code using
> them look funny.
> 
> How can this feature get discovered? Having annotated types declared in
> bpftool headers will surely help.


Yes, discoverability is one of my main concerns here. I'm not convinced
it's a good idea to introduce a new convention for tags just for
bpftool. If this gets adopted, this should be documented at a larger
scale for other tooling to pick it up, too; and the defined formats
should probably not be proper to bpftool. What "bpftool headers" are you
talking about, exactly?

(My other concern would be security and the risk of obfuscating map
contents from bpftool dumps, but given that formatting strings are
defined in bpftool - not in user programs - and you have checks on
lengths to associate format strings to pieces of data, I think we're
good and I don't see a way for users to exploit this and hide some bytes
from the formatted output.)

Quentin

