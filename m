Return-Path: <bpf+bounces-12624-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3D17CEC36
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 01:41:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B93E28151B
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 23:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562F83E000;
	Wed, 18 Oct 2023 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="p72Yghl7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xOxFsZXX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="ezWv7vI2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721E15AFB
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 23:41:11 +0000 (UTC)
Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9395995
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:41:10 -0700 (PDT)
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 148BDC15154A
	for <bpf@vger.kernel.org>; Wed, 18 Oct 2023 16:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1697672470; bh=RH/LRHUuQtfxKYDEDJlAWG7P58eMajykKc80K0/aeL0=;
	h=To:Cc:References:Date:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=p72Yghl7qDQEegMvNxStic1ss4s+kq1aJmlIpyK/vCdLep/PBkgzmM2lgihYuwOkD
	 75mdDBuD6V6z0DZsInCDp8eSoSBuN7Eg3KdWpiXhor7ns0swZGvrGBNCzbVncg+VRT
	 cC1/BGujhnfJriT3vkVnxxcYzM9JW3eFUaModqWM=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id C9BC0C14CE3F;
 Wed, 18 Oct 2023 16:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1697672469; bh=RH/LRHUuQtfxKYDEDJlAWG7P58eMajykKc80K0/aeL0=;
 h=To:Cc:References:From:Date:In-Reply-To:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=xOxFsZXXflKnZCKFt5sCiVkmH82SrAXeUuUGtMQksFKOikIsat4V0IDwpgxZyhBBl
 YUYJhn9hW6QGjVD77oWsvypdEZktMoGj8ToEQgma2BizugquzycSWFqenWHDKAaDkm
 a/cJQXH7yrq5rDGsGEgVriM5t4M13maB0fMWqGgY=
X-Original-To: bpf@ietfa.amsl.com
Delivered-To: bpf@ietfa.amsl.com
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 7D968C14CE3F
 for <bpf@ietfa.amsl.com>; Wed, 18 Oct 2023 16:41:09 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Score: -7.197
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=iogearbox.net
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KfHAWHK5nLoa for <bpf@ietfa.amsl.com>;
 Wed, 18 Oct 2023 16:41:04 -0700 (PDT)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 3E753C14CF1C
 for <bpf@ietf.org>; Wed, 18 Oct 2023 16:41:02 -0700 (PDT)
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
 (Exim 4.94.2) (envelope-from <daniel@iogearbox.net>)
 id 1qtG9r-000Oth-7n; Thu, 19 Oct 2023 01:40:59 +0200
Received: from [178.197.248.24] (helo=linux.home)
 by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1qtG9q-0004YK-VZ; Thu, 19 Oct 2023 01:40:59 +0200
To: Eduard Zingerman <eddyz87@gmail.com>,
 Dave Thaler <dthaler1968@googlemail.com>, bpf@vger.kernel.org
Cc: bpf@ietf.org, Dave Thaler <dthaler@microsoft.com>
References: <20231017203020.1500-1-dthaler1968@googlemail.com>
 <d1a0907588e9d809aebba260377b6188897bd383.camel@gmail.com>
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
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27065/Wed Oct 18 09:49:14 2023)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/MnkY65rdUphW3HE1sfvzadejpTo>
Subject: Re: [Bpf] [PATCH bpf-next] bpf,
 docs: Define signed modulo as using truncated division
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: Discussion of BPF/eBPF standardization efforts within the IETF
 <bpf.ietf.org>
List-Unsubscribe: <https://www.ietf.org/mailman/options/bpf>,
 <mailto:bpf-request@ietf.org?subject=unsubscribe>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Subscribe: <https://www.ietf.org/mailman/listinfo/bpf>,
 <mailto:bpf-request@ietf.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: Daniel Borkmann <daniel@iogearbox.net>
From: Daniel Borkmann <daniel=40iogearbox.net@dmarc.ietf.org>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

