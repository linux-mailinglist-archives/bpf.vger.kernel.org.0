Return-Path: <bpf+bounces-5865-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B67622D4
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 21:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8D802819EB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3783F26B29;
	Tue, 25 Jul 2023 19:59:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A2626B17
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 19:59:32 +0000 (UTC)
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [91.218.175.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3BA128
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 12:59:31 -0700 (PDT)
Message-ID: <2115ae11-b10c-5b4d-dcd6-cb4742f4bc92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690315169; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3GjeF6/lPN43TSIaICiOwbjaOZKaZCYHwOPQrY5Mbo=;
	b=Rf0iIBs3oLPz/JuWjI7PGTPnRLG/uOy4gNCEEsLMe9W9Hd9EFVIjLksY3PqDJDPJ7pJVQU
	74wCoZ0i2NoQLv2tsYtIp0ka1SGWeAyI9CMw0A3u4AV2x6Qji593cx6t91aOJsfDIQezCa
	6aH9n6z+Yr9TS4fNwyU9h1vFr5/UOmM=
Date: Tue, 25 Jul 2023 12:59:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: Register encoding in assembly for load/store instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
References: <87ila7dhmp.fsf@oracle.com>
 <5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev> <87o7jzbz0z.fsf@oracle.com>
 <87edkvbybo.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <87edkvbybo.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/25/23 12:11 PM, Jose E. Marchesi wrote:
> 
>>> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>>>> Hello Yonghong.
>>>> We have noticed that the llvm disassembler uses different notations
>>>> for
>>>> registers in load and store instructions, depending somehow on the width
>>>> of the data being loaded or stored.
>>>> For example, this is an excerpt from the assembler-disassembler.s
>>>> test
>>>> file in llvm:
>>>>     // Note: For the group below w1 is used as a destination for
>>>> sizes u8, u16, u32.
>>>>     // This is disassembler quirk, but is technically not wrong, as
>>>> there are
>>>>     //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>>>     //
>>>>     // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
>>>>     // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
>>>>     // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
>>>>     // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
>>>>     r1 = *(u8*)(r2 + 42)
>>>>     r1 = *(u16*)(r2 + 42)
>>>>     r1 = *(u32*)(r2 + 42)
>>>>     r1 = *(u64*)(r2 + 42)
>>>> The comment there clarifies that the usage of wN instead of rN in
>>>> the
>>>> u8, u16 and u32 cases is a "disassembler quirk".
>>>> Anyway, the problem is that it seems that `clang -S' actually emits
>>>> these forms with wN.
>>>> Is that intended?
>>>
>>> Yes, this is intended since alu32 mode is enabled where
>>> w* registers are used for 8/16/32 bit load.
>>
>> So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is still
>> alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?
> 
> Sorry my keyboard num-lock activated mid-sentence.
> 
> I meant 'r1 = (u8*)(r2 + 42)'.
> Why supporting that syntax as well as 'w1 = (u8*)(r2 + 42)'?

alu32 mode. Original intention is that if
   w1 = *(u8 *)(r2 + 42)
is specified that the hardware will actually only load
the value to the 32-bit sub-register. And then hardware
will be doing 32-to-64 zero extension automatically.

This is different from
   r1 = *(u8 *)(r2 + 42)
where the value will actually load into the 64-bit
register by insn itself.

> 
>>
>>> Note that for newer sign-extended loads, even at alu32 mode,
>>> only r* register is used since the sign-extension extends
>>> upto 64 bits for all variants (8/16/32).
>>
>> Yes we noticed that :)
>>
>>>
>>>
>>>
>>>>

