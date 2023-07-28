Return-Path: <bpf+bounces-6228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3438176729E
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 19:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D59A1C20ACF
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 17:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A310015498;
	Fri, 28 Jul 2023 17:00:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8059B10792
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 17:00:02 +0000 (UTC)
Received: from out-94.mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E14635B8
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 09:59:50 -0700 (PDT)
Message-ID: <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690563588; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRv1R5exIhZcc4SJcUdoXjOJ+Jp8NpyOb2e2xO8445Y=;
	b=GNRnamIqE1lIZFem9kDZsojWXh2Qbi2iBfyDU/wmi6Y8O/bP/YGquVvbWT4+JpLzj0ZVRB
	HYv5ZL7K+arVbicbD65w7V2v3gQM9KxR+74rgTZSqQRoR721FYpivSgVUx1mdhYcfKHFdN
	ikyQjlLzKplaYGC/+Se77G7fz9POQo8=
Date: Fri, 28 Jul 2023 09:59:46 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: GCC and binutils support for BPF V4 instructions
Content-Language: en-US
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
References: <878rb0yonc.fsf@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <878rb0yonc.fsf@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
> 
> Hello.
> 
> Just a heads up regarding the new BPF V4 instructions and their support
> in the GNU Toolchain.
> 
> V4 sdiv/smod instructions
> 
>    Binutils has been updated to use the V4 encoding of these
>    instructions, which used to be part of the xbpf testing dialect used
>    in GCC.  GCC generates these instructions for signed division when
>    -mcpu=v4 or higher.
> 
> V4 sign-extending register move instructions
> V4 signed load instructions
> V4 byte swap instructions
> 
>    Supported in assembler, disassembler and linker.  GCC generates these
>    instructions when -mcpu=v4 or higher.
> 
> V4 32-bit unconditional jump instruction
> 
>    Supported in assembler and disassembler.  GCC doesn't generate that
>    instruction.
> 
>    However, the assembler has been expanded in order to perform the
>    following relaxations when the disp16 field of a jump instruction is
>    known at assembly time, and is overflown, unless -mno-relax is
>    specified:
> 
>      JA disp16  -> JAL disp32
>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
> 
>    Where Jxx is one of the conditional jump instructions such as jeq,
>    jlt, etc.

Sounds great. The above 'JA/Jxx disp16' transformation matches
what llvm did as well.

> 
> So I think we are done with this.  Please let us know if these
> instructions ever change.
> 
> Relevant binutils bugzillas (all now resolved as fixed):
> 
> * Make use of long range calls by relaxation (jal/gotol):
>    https://sourceware.org/bugzilla/show_bug.cgi?id=30690
> 
> Relevant GCC bugzillas (all now resolved as fixed):
> 
> * Make use of signed-load instructions:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110782
>    
> * Make use of signed division/modulus:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110783
> 
> * Make use of signed mov instructions:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110784
> 
> * Make use of byte swap instructions:
>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110786
> 
> Salud!
> 

