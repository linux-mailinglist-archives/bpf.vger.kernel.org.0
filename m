Return-Path: <bpf+bounces-20762-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFC3842BF7
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38D7EB23809
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735B78B46;
	Tue, 30 Jan 2024 18:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPWMIBhF"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83DE5B5CA
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639988; cv=none; b=oJc8rKJQdzhOrTByR0thOnp4s5CLTNpnVr8nAqAO5QN2ISzbJAUVSgwkIFcQVZ2cfud9wTj7hYw3gdSEHxO6+IUlVSy8GHkpA8ccPFyfFGObIvQYen5ey2gace5dbqYKgJXPlyz1DyIfJ5jOkzAsPVwCJGC2Yr1bX/LJSy5SZHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639988; c=relaxed/simple;
	bh=oizNWJNaLAqU8TuHJWQ08NMsdsen3E+KdEBYVZ4RZGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnA0mniT+ltwaIxHQG7M+vFyhqt6VQ0AhNniCRxoZXO9Vp+trImRgyMKNM1jmNYlE5kduQsq/PP3ns77GhUGiueSn9RmSlT1z+a3i4/V/AaYVBh+QPDMQRGebCWtuJ5RD+9HiyPLI9fWhdvTqPTsqbmTU/v/goFQsHYAWWbbwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPWMIBhF; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e6d233c1-2b01-4615-b1fb-1fa33bf158e3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706639983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nn18nsWZ6HbHZdAa3rlNeyimosKsX30JlRq3QM/Eodg=;
	b=CPWMIBhFaTRcGW/mYYtJyHDPpJnTxO+PRsXm2XWMWpIHnAUrqhOZ8GAH8vVn0cIQFezIhk
	9m2S6T0ZPPRDfV1/KEAhcZCzqERSMbMTy/HA6hPSW3/J6SaAw7LJRDaMmDipWUC17m1mdU
	95+rrwxvWy1ZwY8Z/fGfwI0QJRsZQk8=
Date: Tue, 30 Jan 2024 10:39:36 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
Content-Language: en-GB
To: dthaler1968@googlemail.com, bpf@ietf.org, 'bpf' <bpf@vger.kernel.org>
Cc: "'Jose E. Marchesi'" <jose.marchesi@oracle.com>,
 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
References: <006601da5151$a22b2bb0$e6818310$@gmail.com>
 <877cjutxe9.fsf@oracle.com> <8734uitx3m.fsf@oracle.com>
 <01e601da51b7$92c4ffa0$b84efee0$@gmail.com>
 <CAADnVQK8JegsSxgbQbO=DR71cRgkvN-y9LH_ZQYxmj1a-hCz5g@mail.gmail.com>
 <071b01da5394$260dba30$72292e90$@gmail.com>
 <073001da539a$ec1e2b00$c45a8100$@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 1/30/24 8:39 AM, dthaler1968@googlemail.com wrote:
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>> [...]
>>>> Although the Linux verifier doesn't support them, the fact that gcc
>>>> does support them tells me that it's probably safest to list the DW
>>>> and LDX variants as deprecated as well, which is what the draft
>>>> already did in the appendix so that's good (nothing to change there,
>>>> I think).
>>> DW never existed in classic bpf, so abs/ind never had DW flavor.
>>> If some assembler/compiler decided to "support" them it's on them.
>>> The standard must not list such things as deprecated. They never
>>> existed. So nothing is deprecated.
>> Ack, I will remove the ABS/IND + DW lines from the appendix.
>>
>>> Same with MSH. BPF_LDX | BPF_MSH | BPF_B is the only insn ever existed.
>>> It's a legacy insn. Just like abs/ind.
>> Should it be listed in the legacy conformance group then?
>>
>> Currently it's not mentioned in instruction-set.rst at all, so the opcode is
>> available to use by any new instruction.  If we do list it in instruction-set.rst
>> then, like abs/ind, it will be avoided by anyone proposing new instructions.
> Here's my understanding of this thread so far:
>
> * (IND/ABS) | (W/H/B) | LD : these are accepted by the Linux verifier and are supported
>     by clang and gcc.  They should be in the legacy conformance group of deprecated
>     instructions.
>
> * (IND/ABS) | DW | (LD/LDX) : these are not accepted by the Linux verifier and were
>     never used.  Clang doesn't generate them but gcc did which is now removed
>     based on this discussion.  They should NOT be in the legacy conformance group of
>     deprecated instructions because they were never defined in the first place, and
>     instruction-set.rst should be updated to clarify this.
>
> * (IND/ABS) | (W/H/B) | LDX : these are not accepted by the Linux verifier and were
>     never used.  Clang doesn't generate them but gcc does. They should NOT
>     be in the legacy conformance group of deprecated instructions because they were
>     never defined in the first place, and instruction-set.rst should be updated to clarify this.
>
> * (IND/ABS) | (W/H/B/DW) | (ST/STX): these are not accepted by the Linux verifier and were
>     never used.  I don't know whether clang or gcc generates them.  They should NOT
>     be in the legacy conformance group of deprecated instructions because they were
>     never defined in the first place, and instruction-set.rst should be updated to clarify this.
>
> * MSH | B | LDX: this existed in classic BPF but does not exist in (e)BPF since it is not accepted
>     by the Linux verifier.  I don't know whether clang ever generated them, but gcc never did.

clang never generated this insn either.

>     The "Legacy BPF Packet access instructions" section of instruction-set.rst says
>     > BPF previously introduced special instructions for access to packet data that were carried
>     > over from classic BPF. However, these instructions are deprecated and should no longer be used.
>     I read Alexei's comment "It's a legacy insn. Just like abs/ind" as a possible argument that MSH|B|LDX
>     should be mentioned in instruction-set.rst, pointing to the above section, like IND/ABS do.
>     But Yonghong argued that it was never accepted by the verifier, so need not be mentioned.

It is just my opinion. Standardization is complicated. I guess adding it to the legacy insn
is okay to prevent anybody using the same opcode.

>
> * MSH | (W/H/DW) | (LD/ST/STX): These are not accepted by the Linux verifier and were
>     never used.  They should NOT be in the legacy conformance group of deprecated instructions
>     because they were never defined in the first place.
>
> Let me know if any of the above is incorrect and I can submit a doc patch.
>
> Dave
>

