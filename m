Return-Path: <bpf+bounces-20763-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584F842BF6
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29648281C5D
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B1678B5F;
	Tue, 30 Jan 2024 18:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="q22q/g6p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="q22q/g6p";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CPWMIBhF"
X-Original-To: bpf@vger.kernel.org
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9192E78B5E
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 18:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706639995; cv=none; b=AzdoEd+JlOJTiHOOTajwdKH0cNw7F/fAI7vJDNbvUkN6alZ+8KbFK65SAfcgGgTtn/zYXa0rc71zrgXoQ9ReQuITlq4BmyWeMslLvWGItBRAXZAVevHz7DtGNj8ENX3i9k1dCN1PYkFbUVfp9KLK7VwrqsulwwZR3PU6BHG9Et4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706639995; c=relaxed/simple;
	bh=u7z3Cz4wffe+lLvslbVno36P6qmNmOX0I2xQejqE0ZA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Subject:Content-Type; b=Cidny8cpBA41hjvKLQdWr9av4i+sECPrKpvo6kCt9P4HU3husU8Oy4f6zAefc6sM8SEAKgXlzYJFoQfz8GtppBiRUPju44QQ+rVKYcg+W/QfGoySvqp5h9vcjpnpgzaZ+7JJhDYcXw5TpEXnZv7TkTmfZYzGFMsz+gHlWToE8bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=q22q/g6p; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=q22q/g6p; dkim=fail (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CPWMIBhF reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C8140C15106A
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706639992; bh=u7z3Cz4wffe+lLvslbVno36P6qmNmOX0I2xQejqE0ZA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=q22q/g6pZwqD/IFKgkG9VxXBcNg3Wg8hKNvMMp/EYU/uymqZMSVam/5qPbiFIKSit
	 x92Z485uoCwMw7QaxJ/0IReA0WS1vhaHeIAv72yL4RmEGaojIuX+7KFsfVIZe98uVS
	 ZPnICq54oxnglSXmZ5WPQqksWUO4C2YKbijRS2cI=
X-Mailbox-Line: From bpf-bounces@ietf.org  Tue Jan 30 10:39:52 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id A2864C14F618;
	Tue, 30 Jan 2024 10:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1706639992; bh=u7z3Cz4wffe+lLvslbVno36P6qmNmOX0I2xQejqE0ZA=;
	h=Date:To:Cc:References:From:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=q22q/g6pZwqD/IFKgkG9VxXBcNg3Wg8hKNvMMp/EYU/uymqZMSVam/5qPbiFIKSit
	 x92Z485uoCwMw7QaxJ/0IReA0WS1vhaHeIAv72yL4RmEGaojIuX+7KFsfVIZe98uVS
	 ZPnICq54oxnglSXmZ5WPQqksWUO4C2YKbijRS2cI=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 39B8EC14F5ED
 for <bpf@ietfa.amsl.com>; Tue, 30 Jan 2024 10:39:51 -0800 (PST)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -7.107
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (1024-bit key)
 header.d=linux.dev
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5LpgR8QX7bNr for <bpf@ietfa.amsl.com>;
 Tue, 30 Jan 2024 10:39:46 -0800 (PST)
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com
 [IPv6:2001:41d0:203:375::aa])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 903FFC14F5FD
 for <bpf@ietf.org>; Tue, 30 Jan 2024 10:39:45 -0800 (PST)
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <073001da539a$ec1e2b00$c45a8100$@gmail.com>
X-Migadu-Flow: FLOW_OUT
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/kS_-JU5WhhN7x2_y6jJyPiEUZwU>
Subject: Re: [Bpf] ISA: BPF_MSH and deprecated packet access instructions
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>


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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

