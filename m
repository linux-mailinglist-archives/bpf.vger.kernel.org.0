Return-Path: <bpf+bounces-62564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47480AFBDCA
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 23:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C770421A29
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A40288536;
	Mon,  7 Jul 2025 21:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="T6KXsxUc"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B641C6FE1
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751924695; cv=none; b=ftDPmYU+nJmc11rwB1cDSUkwRCp+zL1hMIu4HaY2XjMBAmu/tXyAML1Ht5ln8AF2LM27Lbv8OCwPJIS7Nc0SAUxeAWJ8gqlZjE4nSe1xzJCMXIDJh7jC6E4wnhSwhwwMZ74jsSxf4g84kypbjC+zlzO4RuH2p9RYeRH68nKsHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751924695; c=relaxed/simple;
	bh=A1M4Ll9ctFQmJqgw6P+e0SfvzWFfBS1x6KQmEVQmYRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZfrbFVuxOOkuCBC87+flYFA5h7fYWMyZFXRuBY5r/DxN2dHI60H22Wh60byR8mVh+enteadXAku9BGdlSV6pT5JRun+n7Uf/ZdvmPod6uYhCadpaUWC6uRslsvkfYhbXrLhgu2RFqL1xJxZ9e+vgkUyEtfIbNgpW1pY5Sa+hwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=T6KXsxUc; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <25525af2-1dfc-466c-be0c-6c51bab4e605@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751924688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2lgwHvToi7T9zrkA6bcJ/K4QxGttECGrOtqgBVi6qM0=;
	b=T6KXsxUcPwKlNw8Ib8lSw9K0cGZAyz0R3aiwzQ6744iJ63nENjaJI3WsP6fbavYIX/LGxI
	Ot1LXBAJLoRwDBcNdLbeQFZ+C5bwjX1yp3lgiWBPGhP/2CHhSN2SZPE5Xh3MwjW75rdscP
	OA9d9a5mhPaL5P/FkHYYqyt/cQVcXWI=
Date: Mon, 7 Jul 2025 14:44:40 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Quentin Monnet <qmo@kernel.org>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
 <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/7/25 12:07 PM, Eduard Zingerman wrote:
> On Thu, 2025-07-03 at 11:21 -0700, Eduard Zingerman wrote:
>
> [...]
>
>>>>>    .jumptables
>>>>>      <subprog-rel-off-0>
>>>>>      <subprog-rel-off-1> | <--- jump table #1 symbol:
>>>>>      <subprog-rel-off-2> |        .size = 2   // number of entries in the jump table
>>>>>      ...                          .value = 1  // offset within .jumptables
>>>>>      <subprog-rel-off-N>                          ^
>>>>>                                                   |
>>>>>    .text                                          |
>>>>>      ...                                          |
>>>>>      <insn-N>     <------ relocation referencing -'
>>>>>      ...                  jump table #1 symbol
> [...]
>
> I think I got it working in:
> https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section
>
> Changes on top of Yonghong's work.
> An example is in the attachment the gist is:
>
> -------------------------------
>
> $ clang --target=bpf -c -o jump-table-test.o jump-table-test.c
> There are 8 section headers, starting at offset 0xaa0:
>
> Section Headers:
>    [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>    ...
>    [ 4] .jumptables       PROGBITS        0000000000000000 000220 000260 00      0   0  1
>    ...
>
> Symbol table '.symtab' contains 8 entries:
>     Num:    Value          Size Type    Bind   Vis       Ndx Name
>       ...
>       3: 0000000000000000   256 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.0
>       4: 0000000000000100   352 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.1
>       ...
>
> $ llvm-objdump --no-show-raw-insn -Sdr jump-table-test.o
> jump-table-test.o:      file format elf64-bpf
>
> Disassembly of section .text:
>
> 0000000000000000 <foo>:
>         ...
>         6:       r2 <<= 0x3
>         7:       r1 = 0x0 ll
>                  0000000000000038:  R_BPF_64_64  .jumptables
>         9:       r1 += r2
>        10:       r1 = *(u64 *)(r1 + 0x0)
>        11:       gotox r1
>        ...
>        34:       r2 <<= 0x3
>        35:       r1 = 0x100 ll
>                  0000000000000118:  R_BPF_64_64  .jumptables
>        37:       r1 += r2
>        38:       r1 = *(u64 *)(r1 + 0x0)
>        39:       gotox r1
>        ...
>
> -------------------------------
>
> The changes only touch BPF backend. Can be simplified a bit if I move
> MachineFunction::getJTISymbol to TargetLowering in the shared LLVM
> parts.

Thanks, Eduard. I actually also explored a little bit and came up with
the below patch:
   https://github.com/yonghong-song/llvm-project/tree/br-jt-v6-seperate-jmptable
the top commit is the addition on top of https://github.com/llvm/llvm-project/pull/133856.
I tried to leverage existing llvm infrastructure and it will support ELF/XCOFF/COFF
and all backends.

Anton, besides Eduard's patch, please also take a look at the above patch.


