Return-Path: <bpf+bounces-29645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CF68C44B6
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92566B218CB
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3B155325;
	Mon, 13 May 2024 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxzXKmne"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2598154423;
	Mon, 13 May 2024 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616003; cv=none; b=fJzTlJQYpQssTehy1lT7xsM8yvQubxj/SVCgXz30VY0yrQ6prPr7vV4/C8G4XrtwgUD1+3Sq1jLeM9Grcf9QV9Dl7iv66E/nQ5xZG8729uVqeRPoCCRlkJj6h4TBQmM1iHeaUTdDDVnny/QK/Jbg9kA5KIFF96RPCR3SiGuvOtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616003; c=relaxed/simple;
	bh=k2zBO/pJSJJXeGK42+0QmyGneLPTwY0zTIWbg5TCzdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ao1COASCgMuLQ2rJuQZEXx89twU7V+2NcbMir1DBxJ3hxjuVspQOzvAZq4ionwKNz9Df1IbV8ON5WU/SJFQA5kQDBx1cKirC564yZJqlygo2LdPK3Yzr0XWr+yKRwhq3qtqSB4gmsGXQ5MIzHaSeHx9BscUmkQFUv3gIOKBWiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxzXKmne; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA2CC113CC;
	Mon, 13 May 2024 16:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616002;
	bh=k2zBO/pJSJJXeGK42+0QmyGneLPTwY0zTIWbg5TCzdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MxzXKmne4Q0q7RCI54pTOJidMsN+RsKt47FFBV47KtxcReD+agKNZ6QuIZwlpKDFJ
	 r7yNAphTKeaym1EwZwOCBxaOgl5UEw6eU/Wqgt7Az4e/Cb6LQHLV8/zZwH+cr39xBd
	 Zr/NVoF7f5wlVCSibtXWRnuXdQjfxA57MiNn3SE1Hfcot+QSY+2klBOWg35QQTVkgT
	 vcXW86bdIXkeMIMJbvSlybzmJOVEz5qLXccq8tZYcsw1GyYNgEWonvAhs7vSqpAFqV
	 MgdAUAzCSspNpFY3ExqbVGhDRCNGnDaf2xfHBtzPuLk9oRzZN03heKLaKSOCbqjciN
	 WpY42C+27A/yw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Naveen N Rao <naveen@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Hari Bathini
 <hbathini@linux.ibm.com>, bpf@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@kernel.org
Subject: Re: [PATCH bpf v3] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
In-Reply-To: <wlslraxtexuncmqsfen6gum4sg4viecu4zx73pvlfztjmwxenl@fcoal5io4kse>
References: <20240513100248.110535-1-puranjay@kernel.org>
 <wlslraxtexuncmqsfen6gum4sg4viecu4zx73pvlfztjmwxenl@fcoal5io4kse>
Date: Mon, 13 May 2024 15:59:59 +0000
Message-ID: <mb61pwmnxhfcw.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Naveen N Rao <naveen@kernel.org> writes:

> On Mon, May 13, 2024 at 10:02:48AM GMT, Puranjay Mohan wrote:
>> The Linux Kernel Memory Model [1][2] requires RMW operations that have a
>> return value to be fully ordered.
>> 
>> BPF atomic operations with BPF_FETCH (including BPF_XCHG and
>> BPF_CMPXCHG) return a value back so they need to be JITed to fully
>> ordered operations. POWERPC currently emits relaxed operations for
>> these.
>> 
>> We can show this by running the following litmus-test:
>> 
>> PPC SB+atomic_add+fetch
>> 
>> {
>> 0:r0=x;  (* dst reg assuming offset is 0 *)
>> 0:r1=2;  (* src reg *)
>> 0:r2=1;
>> 0:r4=y;  (* P0 writes to this, P1 reads this *)
>> 0:r5=z;  (* P1 writes to this, P0 reads this *)
>> 0:r6=0;
>> 
>> 1:r2=1;
>> 1:r4=y;
>> 1:r5=z;
>> }
>> 
>> P0                      | P1            ;
>> stw         r2, 0(r4)   | stw  r2,0(r5) ;
>>                         |               ;
>> loop:lwarx  r3, r6, r0  |               ;
>> mr          r8, r3      |               ;
>> add         r3, r3, r1  | sync          ;
>> stwcx.      r3, r6, r0  |               ;
>> bne         loop        |               ;
>> mr          r1, r8      |               ;
>>                         |               ;
>> lwa         r7, 0(r5)   | lwa  r7,0(r4) ;
>> 
>> ~exists(0:r7=0 /\ 1:r7=0)
>> 
>> Witnesses
>> Positive: 9 Negative: 3
>> Condition ~exists (0:r7=0 /\ 1:r7=0)
>> Observation SB+atomic_add+fetch Sometimes 3 9
>> 
>> This test shows that the older store in P0 is reordered with a newer
>> load to a different address. Although there is a RMW operation with
>> fetch between them. Adding a sync before and after RMW fixes the issue:
>> 
>> Witnesses
>> Positive: 9 Negative: 0
>> Condition ~exists (0:r7=0 /\ 1:r7=0)
>> Observation SB+atomic_add+fetch Never 0 9
>> 
>> [1] https://www.kernel.org/doc/Documentation/memory-barriers.txt
>> [2] https://www.kernel.org/doc/Documentation/atomic_t.txt
>> 
>> Fixes: 65112709115f ("powerpc/bpf/64: add support for BPF_ATOMIC bitwise operations")
>
> As I noted in v2, I think that is the wrong commit. This fixes the below 

Sorry for missing this. Would this need another version or your message
below will make it work with the stable process?

> four commits in mainline:
> Fixes: aea7ef8a82c0 ("powerpc/bpf/32: add support for BPF_ATOMIC bitwise operations")
> Fixes: 2d9206b22743 ("powerpc/bpf/32: Add instructions for atomic_[cmp]xchg")
> Fixes: dbe6e2456fb0 ("powerpc/bpf/64: add support for atomic fetch operations")
> Fixes: 1e82dfaa7819 ("powerpc/bpf/64: Add instructions for atomic_[cmp]xchg")
>
> Cc: stable@vger.kernel.org # v6.0+

Thanks,
Puranjay

