Return-Path: <bpf+bounces-20420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064683E1A1
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 19:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83A9AB22347
	for <lists+bpf@lfdr.de>; Fri, 26 Jan 2024 18:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70B61EF1E;
	Fri, 26 Jan 2024 18:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="snGyR5ob"
X-Original-To: bpf@vger.kernel.org
Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C291DFF9
	for <bpf@vger.kernel.org>; Fri, 26 Jan 2024 18:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294117; cv=none; b=NeJGkLZk3B81R48Q16gVNQefzd3Hv3OFpYyjDK10/VU/jI3fZ1boluF1s5HeOXZwSwC21vI0zXUFt4TRMTKPenmchvlpYjdtXfn2BWJD60kTB6UeE52c68Fwza5h4zWos+q/EHV7V4PTQqf5t2VeiBSBhiF13fSU0t48hvPCvxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294117; c=relaxed/simple;
	bh=7YSjkjRSODnD7qNzbp/sum6x231ygUtL4p6OztVgbCc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=gICubpqsdRfBXzVr9LRjDLz5TVirqjUI0KKx2UzATu/P2wWK2Gf33wQ00fdW3xgymQZd0/PtGMfOZLZ1aNMnxBxU9aQNgRiVMotNB6F2bjzCqWHpTX10s6/pMn4bNEiJCT/hEUO0H3Nhz0F/3gEO7ZhwQruh+hBUAsEgNGLeZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=snGyR5ob; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <db983da6-73f1-4c46-a12f-702fe5a624f4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706294112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBGSwzrBymaKKARrmGZWA6+j5K8bceB8A2cAP44en0c=;
	b=snGyR5obvTGaXAR6mLXQIE2isZjpSqjUdQNhB1fG44v/+zbjaqLpL329v5aVXnwK8x/tNa
	ygA3hY9uGCcfXjfthCZlSdGB1ymVG6C7N2QEckrghB1eSE8KGUn11eKq++6Px+nr/0KKHT
	So6XWn5ANy7oU0PNlseTjPRa3kg4vKM=
Date: Fri, 26 Jan 2024 10:35:05 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: BTF generation and pruning (notes from office hours)
Content-Language: en-GB
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
To: David Faust <david.faust@oracle.com>, bpf@vger.kernel.org
Cc: "Jose E. Marchesi" <jose.marchesi@oracle.com>,
 Cupertino Miranda <cupertino.miranda@oracle.com>,
 Indu Bhagat <indu.bhagat@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>
References: <a513d5c8-cae1-4c5d-a0aa-170c678c278b@oracle.com>
 <4c1efbc9-7f4e-4d83-bc3c-2e7ebf027537@linux.dev>
In-Reply-To: <4c1efbc9-7f4e-4d83-bc3c-2e7ebf027537@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 1/26/24 10:10 AM, Yonghong Song wrote:
>
> On 1/25/24 2:56 PM, David Faust wrote:
>> This morning in the BPF office hours we discussed BTF, starting from
>> some specific cases where gcc and clang differ, and ending up at the
>> broader question of what precisely should or should not be present
>> in generated BTF info and in what cases.
>>
>> Below is a summary/notes on the discussion so far. Apologies if I've
>> forgotten anything.
>>
>> Motivation: there are some cases where gcc emits more BTF information
>> than clang, in particular (not necessarily exhaustive):
>>    + clang does not emit BTF for unused static vars
>>    + clang does not emit BTF for variables which have been optimized
>>      away entirely
>>    + clang does not emit BTF for types which are only used by one
>>      of the above
>>    (See a couple of concrete examples at the bottom.)
>
> that is correct.
>
[...]
>
>> - This also comes with some drawbacks, in some cases BTF will not
>>    be emitted when it is desired. There is a BTF_TYPE_EMIT macro to
>>    work around that. It isn't a perfect solution.
>
> This is due to dwarf. The type most likely not in dwarf,
> I will take a look.

In yesterday's bpf office hour meeting, Alexei mentioned that struct
bpf_timer needs "BTF_TYPE_EMIT(struct bpf_timer)" to force dwarf
generating an entry although there are usages of "struct bpf_timer"
in the kernel.

I checked and found the only usage of "struct bpf_timer" is
sizeof(...) and __alignof__(...).

e.g.,
helpers.c:      BUILD_BUG_ON(sizeof(struct bpf_timer_kern) > sizeof(struct bpf_timer));
helpers.c:      BUILD_BUG_ON(__alignof__(struct bpf_timer_kern) != __alignof__(struct bpf_timer));

and unfortunately dwarf is not generated for such cases. The frontend
resolves the above sizeof(...) and __alignof__(...) as the constant before
generating debug info inside the compiler.

For example,

$ cat t2.c
struct bpf_timer {
         int a;
         int b;
};
                                                                                                                                      
int foo() {
   int v1, v2;
   v1 = sizeof(struct bpf_timer);
   v2 = __alignof__(struct bpf_timer);
   return v1 + v2;
}
$ clang -O2 -g -c t2.c
$ llvm-dwarfdump t2.o
t2.o:   file format elf64-x86-64
                                                                                                                                      
.debug_info contents:
0x00000000: Compile Unit: length = 0x00000046, format = DWARF32, version = 0x0005, unit_type = DW_UT_compile, abbr_offset = 0x0000, a
ddr_size = 0x08 (next unit at 0x0000004a)
                                                                                                                                      
0x0000000c: DW_TAG_compile_unit
               DW_AT_producer    ("clang version 19.0.0git (https://github.com/llvm/llvm-project.git 6d0080b5de26d8a8682ec6169851af3d0
4e30ccb)")
               DW_AT_language    (DW_LANG_C11)
               DW_AT_name        ("t2.c")
               DW_AT_str_offsets_base    (0x00000008)
               DW_AT_stmt_list   (0x00000000)
               DW_AT_comp_dir    ("/home/yhs/tmp10/btf")
               DW_AT_low_pc      (0x0000000000000000)
               DW_AT_high_pc     (0x0000000000000006)
               DW_AT_addr_base   (0x00000008)

0x00000023:   DW_TAG_subprogram
                 DW_AT_low_pc    (0x0000000000000000)
                 DW_AT_high_pc   (0x0000000000000006)
                 DW_AT_frame_base        (DW_OP_reg7 RSP)
                 DW_AT_call_all_calls    (true)
                 DW_AT_name      ("foo")
                 DW_AT_decl_file ("/home/yhs/tmp10/btf/t2.c")
                 DW_AT_decl_line (6)
                 DW_AT_type      (0x00000045 "int")
                 DW_AT_external  (true)

0x00000032:     DW_TAG_variable
                   DW_AT_const_value     (8)
                   DW_AT_name    ("v1")
                   DW_AT_decl_file       ("/home/yhs/tmp10/btf/t2.c")
                   DW_AT_decl_line       (7)
                   DW_AT_type    (0x00000045 "int")

0x0000003b:     DW_TAG_variable
                   DW_AT_const_value     (4)
                   DW_AT_name    ("v2")
                   DW_AT_decl_file       ("/home/yhs/tmp10/btf/t2.c")
                   DW_AT_decl_line       (7)
                   DW_AT_type    (0x00000045 "int")

0x00000044:     NULL

0x00000045:   DW_TAG_base_type
                 DW_AT_name      ("int")
                 DW_AT_encoding  (DW_ATE_signed)
                 DW_AT_byte_size (0x04)

0x00000049:   NULL

>
>>
>> So, the question is twofold:
>> 1. What ought to be represented in BTF for a BPF program?
>> 2. Is that/should that be followed for non-BPF program cases, such
>>     as generating BTF for vmlinux?
>>
[...]

