Return-Path: <bpf+bounces-73296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7876DC2A057
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 05:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BA61889FC6
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 04:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8964D1F09AD;
	Mon,  3 Nov 2025 04:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ih5A14+F"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A146611CA0
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762143378; cv=none; b=jfDALDII6EL6uRiwbsxS7MAxsVgoqEsmRCo/OjcYkBFg7Zv6gwUq/b0QAGLAFxB++Wwr8H6WcSn8+hMTPiiiTqO9DoNUCSzZpIVfLjxUx8CO807Fkga8l+DrOBmzogJ99Cw3xEzbNNC0NRZrnZ5rF2akFT/Fj1YNO4VqqYIcZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762143378; c=relaxed/simple;
	bh=YAOdws8pW/yJa909ukm00OBZkTKBSAb7til9CHxkHow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oH4LMY2NsJFY+Tdf3++QwKJ8O3Fj2bsONmUwp97X/OepCjKBZb3SOUTAcbbD4mosP9Mm1WR3E+9Jk1FjC3bOoFFEaVOUT/F7CD0KrbytWTkqZ3GQUqGsAUYZ3urdUS8Nc0TS4CNYNjvCvHGfxmmROygDB6TeAhEBSsuqkcKrwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ih5A14+F; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3b07e879-9905-4161-88e0-05ed54bdb628@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762143369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVIMSry9tqV3rj+Q531Zyu56UbgoO7VHySurjakZ7Uc=;
	b=Ih5A14+FNxvNG7EY/4mqqjPDUL48kOYqFjmjYYAjtpnW+N1ZIAHPlSHvEgUV9lmJJpmFpD
	WMiBFsM8lvK9DgEbHIONtxOqR8znN8RwW3zXJ1L9tZsQaSoF2Fgdqs3MEx6ScrWeBsCl0l
	SkjtWEOUWw1+Rf0OF0Dx3+Lwy9askm4=
Date: Sun, 2 Nov 2025 20:15:41 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 bpf-next 08/11] libbpf: support llvm-generated indirect
 jumps
To: Eduard Zingerman <eddyz87@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
References: <20251028142049.1324520-1-a.s.protopopov@gmail.com>
 <20251028142049.1324520-9-a.s.protopopov@gmail.com>
 <68754a9c03b960d5057de816b217e824e51021a1.camel@gmail.com>
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <68754a9c03b960d5057de816b217e824e51021a1.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 10/29/25 2:31 PM, Eduard Zingerman wrote:
> On Tue, 2025-10-28 at 14:20 +0000, Anton Protopopov wrote:
>> For v4 instruction set LLVM is allowed to generate indirect jumps for
>> switch statements and for 'goto *rX' assembly. Every such a jump will
>> be accompanied by necessary metadata, e.g. (`llvm-objdump -Sr ...`):
>>
>>         0:       r2 = 0x0 ll
>>                  0000000000000030:  R_BPF_64_64  BPF.JT.0.0
>>
>> Here BPF.JT.1.0 is a symbol residing in the .jumptables section:
>>
>>      Symbol table:
>>         4: 0000000000000000   240 OBJECT  GLOBAL DEFAULT     4 BPF.JT.0.0
>>
>> The -bpf-min-jump-table-entries llvm option may be used to control the
>> minimal size of a switch which will be converted to an indirect jumps.
>>
>> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
>> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>> ---
> The update looks good to me, but I noticed one more thing.
>
> I'm seeing the following messages when rebuilding bpf_gotox using
> llvm main, where Yonghong added __BPF_FEATURE_GOTOX.
>
>      CLNG-BPF [test_progs-cpuv4] bpf_gotox.bpf.o
>      GEN-SKEL [test_progs-cpuv4] bpf_gotox.skel.h
>    libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
>    libbpf: elf: skipping relo section(13) .rel.jumptables for section(6) .jumptables
>
> Looking at the llvm-readelf results for the object file:
>
>    Relocation section '.rel.jumptables' at offset 0x5a28 contains 263 entries:
>        Offset             Info             Type               Symbol's Value  Symbol's Name
>    0000000000000000  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>    0000000000000008  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>    0000000000000010  0000000300000002 R_BPF_64_ABS64         0000000000000000 syscall
>    ...
>
> Note the number of entries (263) above.
> When compiled with -S instead of -c, jump tables are printed as:
>
>          .section        .jumptables,"",@progbits
>    BPF.JT.4.0:
>          .quad   LBB4_5
>          .quad   LBB4_4
>          ...
>
> Counting these LBBs gives 263 as well, so I assume the relocations are
> for label references.
>
> Given that relocation addend is always zero, I don't think we need
> these relocations, but I can't figure at the moment, on how to
> convince llvm not to emit these.
>
> Yonghong, do you have any ideas?
> This is done for OutStreamer->emitValue(Value: LHS, Size: EntrySize);
> entries in BPFAsmPrinter::emitJumpTableInfo().

I think it is pretty hard to remove those .rel.jumptables relocation
sections. Since we are using addresses (e.g. LBB4_5) so relocation
is needed. It just in this case, the symbol value is 0 so it contributes
nothing. But relocation is an integrated system and linker may
touch it. So the only thing we can do is to remove it after linker
touching that and not sure backend has any hook to remove it or not.

If we do not want to have relocation, we need to have difference between
two labels (e.g. LBB4_5 - LBB4_0) but it has its own limitation w.r.t.
the verifier.

>
> Or I might be wrong and addend is not guaranteed to be zero.
> Then we need to handle these on libbpf side.
> Spent two hours trying to figure this out, no definite answer yet,
> will continue investigation later.
>
> [...]
>


