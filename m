Return-Path: <bpf+bounces-62552-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92226AFBBB0
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 21:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DD09188DF93
	for <lists+bpf@lfdr.de>; Mon,  7 Jul 2025 19:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9092673AF;
	Mon,  7 Jul 2025 19:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWqFKVFh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEAF262FFF
	for <bpf@vger.kernel.org>; Mon,  7 Jul 2025 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916539; cv=none; b=IRmji3+o702l4ZGdbkcn0jBeOWXZcRWTwMbeVCX8U7OY7WdHUrgzMJ4OVAgVKMIAfK90qi6RuedGyG1ajhQeFe33RZd/EO9VbppdyJDTXF/3BIygwjhl/1lAa/1DCEEBx3Rp+hr8dm7oNi+tnuP0xS8sQ36Eq4q0V71u+4k+Cqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916539; c=relaxed/simple;
	bh=GBxCBChzXJvvanBimODP1t6LT1KMBlbyvjWEuegwfrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFR7/gOPcHfDzgwYeXG3yWFbtzkZLGd76aN5yk4gFYLmpz1K6ldTe19OuBxEH04cvGaK+6uFkAyUBUrPPDNbMSTiEVePJX/x5SQaAMVDJjgtFVZi5V4XCLia99phVnz0nXKg1IdZXCqWaPpkU+Yw8LTwOeb/S1lVbuco/UUvFeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWqFKVFh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-453066fad06so25043225e9.2
        for <bpf@vger.kernel.org>; Mon, 07 Jul 2025 12:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751916536; x=1752521336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ncS2DP+t4Fe3zDlzbKFIkjdyw7uZudBFeNfmawDeyQ=;
        b=jWqFKVFhOyc6fCoQH7mRoCROwTNpZh5qYNOkvZisyTULii0+cNo80UHIHE5447zTn0
         qQplpTNfZDv4bjFYD/EoHHIgHIYeiTYfPU7Wp98FBcuAeC3326Ikh1V98WCjEc3LmqZZ
         CTi5Tjy/KIRU8RPy1b/ANi+EfZsbX0fk/lYkbm9nsuZ0i/tXcQatCj1zsJSw+gJMz56v
         cc9nqqy22h78aQy2rw/XcyaXfm5s7FrdIEbfPC6zWsfx4FH852hiGcZhimRjF9BcXqSm
         4tqmmmCGobLkc1Vq6FwaeP+NcMK7+0V4DpmUw+QDULca/AS4GA8DykIXrQsYbx05kEBr
         zeDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751916536; x=1752521336;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ncS2DP+t4Fe3zDlzbKFIkjdyw7uZudBFeNfmawDeyQ=;
        b=SjukKHGMTqjCfAirTDoSC7Qmftk6zmkyycFrIjiQqrjaX+1CUAhSEyZN9f/k/cHPUM
         bvGcTUhL/SvJxWxst9Qf3uEeVMSpvFKAUFp+OJB21IWOEb/+C4E31OjWIROl5vQFzlKZ
         3eoglUu2MiAcCtG/5r8vFR9enuyxgDYzieKR56XFSL98Mv27e2zGbk1TbUfyobnme8/Z
         m9kI3Ak/wZtn98iVVdZSFQ8b5ND3zERe8ONuhUKojOu//nMBWX21B5EotGTa5J0cA3YF
         zisswyYnJMCQYrSqMLabIM9rEwOu17ITXPY+Jic1xhtmhfIYVau8FcKQ7ZgtD/1RqpSB
         PNVw==
X-Forwarded-Encrypted: i=1; AJvYcCWfNMdJZ7d3TYjyiez7SDg2kufJeJRa8cIJDtCSqAZGU8d7424GzXX/wg0pIK9UzLdl9wM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA8TiGiz8CK9KpDeVGI5l0k6Qr1JmF06Mx7Wlo09SHICbSlCHQ
	zbZK6aFsyYv1S/WyrBRaNWVlj0R75taxu4j1b90sgSTQ1FROCvr4Ug/h
X-Gm-Gg: ASbGncvNwnK4+tI2MhGNOV3D5MiW5Q7m/bef1dg1anVoCqQ5O2RNap1YUw4592XWTeg
	RsnXgHeHz+ADDN+NUPe3/r1rbcW2k+zpagA5kIkW8UzNxW6F9tY/Hq2oIIUc7yylPCyEvLUNrmu
	wrRoS+fGVGeT5CcREEmK/J50dOOh6VczqlnXHhm2QgcobySPQV9OtK7SoSZxF95s4LFtBpkRPKg
	w2UOlgkh/O6z5uaNi+9mGHfuo8SKrm6F9xFQB6O8hVw9yNyAxxDlKSeyBOh2qPorZ9wHZ0rMcrK
	1g1XEGoItXHLkbJ6l1YVkM5QLcG+IGEKQuWdJe275aqKol2izA9igBWOO48kDjsNUjtLG15rdpp
	3elHqztJ7
X-Google-Smtp-Source: AGHT+IH1cO5YltZdV6eQkln+Q7DfW9lTgWlx639NmwB5L/1L1q9gHfpwAx/lii0iIwLMvo/Z8Vn9Jg==
X-Received: by 2002:a05:600c:8b27:b0:453:b44:eb71 with SMTP id 5b1f17b1804b1-454cd51868fmr167945e9.19.1751916536147;
        Mon, 07 Jul 2025 12:28:56 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454cd4a68ebsm388105e9.39.2025.07.07.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 12:28:55 -0700 (PDT)
Date: Mon, 7 Jul 2025 19:34:47 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Quentin Monnet <qmo@kernel.org>
Subject: Re: [RFC bpf-next 8/9] libbpf: support llvm-generated indirect jumps
Message-ID: <aGwhV6erIeV9Eowg@mail.gmail.com>
References: <20250615085943.3871208-1-a.s.protopopov@gmail.com>
 <20250615085943.3871208-9-a.s.protopopov@gmail.com>
 <1c17cd755a3e8865ad06baad86d42e42e289439a.camel@gmail.com>
 <f8bc4e5469e73b99943ff7783fbe4a7758bbbe32.camel@gmail.com>
 <aF5v8Yw5LUgVDgjB@mail.gmail.com>
 <454128db01c0a01f3459783cd5a0ea37af01c34e.camel@gmail.com>
 <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8a7a143ad1ebb087ff06032068201023aa893f4.camel@gmail.com>

On 25/07/07 12:07PM, Eduard Zingerman wrote:
> On Thu, 2025-07-03 at 11:21 -0700, Eduard Zingerman wrote:
> 
> [...]
> 
> > > > >   .jumptables
> > > > >     <subprog-rel-off-0>
> > > > >     <subprog-rel-off-1> | <--- jump table #1 symbol:
> > > > >     <subprog-rel-off-2> |        .size = 2   // number of entries in the jump table
> > > > >     ...                          .value = 1  // offset within .jumptables
> > > > >     <subprog-rel-off-N>                          ^
> > > > >                                                  |
> > > > >   .text                                          |
> > > > >     ...                                          |
> > > > >     <insn-N>     <------ relocation referencing -'
> > > > >     ...                  jump table #1 symbol
> 
> [...]
> 
> I think I got it working in:
> https://github.com/eddyz87/llvm-project/tree/separate-jumptables-section

Awesome! I will try to use it tomorrow.

> Changes on top of Yonghong's work.
> An example is in the attachment the gist is:
> 
> -------------------------------
> 
> $ clang --target=bpf -c -o jump-table-test.o jump-table-test.c
> There are 8 section headers, starting at offset 0xaa0:
> 
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>   ...
>   [ 4] .jumptables       PROGBITS        0000000000000000 000220 000260 00      0   0  1
>   ...
> 
> Symbol table '.symtab' contains 8 entries:
>    Num:    Value          Size Type    Bind   Vis       Ndx Name
>      ...
>      3: 0000000000000000   256 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.0
>      4: 0000000000000100   352 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.1
>      ...
> 
> $ llvm-objdump --no-show-raw-insn -Sdr jump-table-test.o
> jump-table-test.o:      file format elf64-bpf
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo>:
>        ...
>        6:       r2 <<= 0x3
>        7:       r1 = 0x0 ll
>                 0000000000000038:  R_BPF_64_64  .jumptables
>        9:       r1 += r2
>       10:       r1 = *(u64 *)(r1 + 0x0)
>       11:       gotox r1
>       ...
>       34:       r2 <<= 0x3
>       35:       r1 = 0x100 ll
>                 0000000000000118:  R_BPF_64_64  .jumptables
>       37:       r1 += r2
>       38:       r1 = *(u64 *)(r1 + 0x0)
>       39:       gotox r1
>       ...
> 
> -------------------------------
> 
> The changes only touch BPF backend. Can be simplified a bit if I move
> MachineFunction::getJTISymbol to TargetLowering in the shared LLVM
> parts.

> $ cat jump-table-test.c
> struct simple_ctx { int x; };
> 
> int bar(int v);
> 
> int foo(struct simple_ctx *ctx)
> {
> 	int ret_user;
> 
>         switch (ctx->x) {
>         case 0:
>                 ret_user = 2;
>                 break;
>         case 11:
>                 ret_user = 3;
>                 break;
>         case 27:
>                 ret_user = 4;
>                 break;
>         case 31:
>                 ret_user = 5;
>                 break;
>         default:
>                 ret_user = 19;
>                 break;
>         }
> 
>         switch (bar(ret_user)) {
>         case 1:
>                 ret_user = 5;
>                 break;
>         case 12:
>                 ret_user = 7;
>                 break;
>         case 27:
>                 ret_user = 23;
>                 break;
>         case 32:
>                 ret_user = 37;
>                 break;
>         case 44:
>                 ret_user = 77;
>                 break;
>         default:
>                 ret_user = 11;
>                 break;
>         }
> 
>         return ret_user;
> }
> 
> $ clang --target=bpf -c -o jump-table-test.o jump-table-test.c
> There are 8 section headers, starting at offset 0xaa0:
> 
> Section Headers:
>   [Nr] Name              Type            Address          Off    Size   ES Flg Lk Inf Al
>   [ 0]                   NULL            0000000000000000 000000 000000 00      0   0  0
>   [ 1] .strtab           STRTAB          0000000000000000 000a31 00006b 00      0   0  1
>   [ 2] .text             PROGBITS        0000000000000000 000040 0001e0 00  AX  0   0  8
>   [ 3] .rel.text         REL             0000000000000000 000540 000030 10   I  7   2  8
>   [ 4] .jumptables       PROGBITS        0000000000000000 000220 000260 00      0   0  1
>   [ 5] .rel.jumptables   REL             0000000000000000 000570 0004c0 10   I  7   4  8
>   [ 6] .llvm_addrsig     LLVM_ADDRSIG    0000000000000000 000a30 000001 00   E  7   0  1
>   [ 7] .symtab           SYMTAB          0000000000000000 000480 0000c0 18      1   6  8
> Key to Flags:
>   W (write), A (alloc), X (execute), M (merge), S (strings), I (info),
>   L (link order), O (extra OS processing required), G (group), T (TLS),
>   C (compressed), x (unknown), o (OS specific), E (exclude),
>   R (retain), p (processor specific)
> 
> Symbol table '.symtab' contains 8 entries:
>    Num:    Value          Size Type    Bind   Vis       Ndx Name
>      0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT   UND 
>      1: 0000000000000000     0 FILE    LOCAL  DEFAULT   ABS jump-table-test.c
>      2: 0000000000000000     0 SECTION LOCAL  DEFAULT     2 .text
>      3: 0000000000000000   256 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.0
>      4: 0000000000000100   352 NOTYPE  LOCAL  DEFAULT     4 .BPF.JT.0.1
>      5: 0000000000000000     0 SECTION LOCAL  DEFAULT     4 .jumptables
>      6: 0000000000000000   480 FUNC    GLOBAL DEFAULT     2 foo
>      7: 0000000000000000     0 NOTYPE  GLOBAL DEFAULT   UND bar
> 
> $ llvm-objdump --no-show-raw-insn -Sdr jump-table-test.o
> jump-table-test.o:	file format elf64-bpf
> 
> Disassembly of section .text:
> 
> 0000000000000000 <foo>:
>        0:	*(u64 *)(r10 - 0x8) = r1
>        1:	r1 = *(u64 *)(r10 - 0x8)
>        2:	w1 = *(u32 *)(r1 + 0x0)
>        3:	*(u64 *)(r10 - 0x18) = r1
>        4:	if w1 > 0x1f goto +0x13 <foo+0xc0>
>        5:	r2 = *(u64 *)(r10 - 0x18)
>        6:	r2 <<= 0x3
>        7:	r1 = 0x0 ll
> 		0000000000000038:  R_BPF_64_64	.jumptables
>        9:	r1 += r2
>       10:	r1 = *(u64 *)(r1 + 0x0)
>       11:	gotox r1
>       12:	w1 = 0x2
>       13:	*(u32 *)(r10 - 0xc) = w1
>       14:	goto +0xc <foo+0xd8>
>       15:	w1 = 0x3
>       16:	*(u32 *)(r10 - 0xc) = w1
>       17:	goto +0x9 <foo+0xd8>
>       18:	w1 = 0x4
>       19:	*(u32 *)(r10 - 0xc) = w1
>       20:	goto +0x6 <foo+0xd8>
>       21:	w1 = 0x5
>       22:	*(u32 *)(r10 - 0xc) = w1
>       23:	goto +0x3 <foo+0xd8>
>       24:	w1 = 0x13
>       25:	*(u32 *)(r10 - 0xc) = w1
>       26:	goto +0x0 <foo+0xd8>
>       27:	w1 = *(u32 *)(r10 - 0xc)
>       28:	call -0x1
> 		00000000000000e0:  R_BPF_64_32	bar
>       29:	w0 += -0x1
>       30:	w1 = w0
>       31:	*(u64 *)(r10 - 0x20) = r1
>       32:	if w0 > 0x2b goto +0x16 <foo+0x1b8>
>       33:	r2 = *(u64 *)(r10 - 0x20)
>       34:	r2 <<= 0x3
>       35:	r1 = 0x100 ll
> 		0000000000000118:  R_BPF_64_64	.jumptables
>       37:	r1 += r2
>       38:	r1 = *(u64 *)(r1 + 0x0)
>       39:	gotox r1
>       40:	w1 = 0x5
>       41:	*(u32 *)(r10 - 0xc) = w1
>       42:	goto +0xf <foo+0x1d0>
>       43:	w1 = 0x7
>       44:	*(u32 *)(r10 - 0xc) = w1
>       45:	goto +0xc <foo+0x1d0>
>       46:	w1 = 0x17
>       47:	*(u32 *)(r10 - 0xc) = w1
>       48:	goto +0x9 <foo+0x1d0>
>       49:	w1 = 0x25
>       50:	*(u32 *)(r10 - 0xc) = w1
>       51:	goto +0x6 <foo+0x1d0>
>       52:	w1 = 0x4d
>       53:	*(u32 *)(r10 - 0xc) = w1
>       54:	goto +0x3 <foo+0x1d0>
>       55:	w1 = 0xb
>       56:	*(u32 *)(r10 - 0xc) = w1
>       57:	goto +0x0 <foo+0x1d0>
>       58:	w0 = *(u32 *)(r10 - 0xc)
>       59:	exit
> 


