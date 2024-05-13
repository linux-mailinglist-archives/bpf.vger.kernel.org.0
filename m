Return-Path: <bpf+bounces-29640-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3FC98C426B
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 15:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB921C210FA
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8055154426;
	Mon, 13 May 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QkG5EBcN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497A8153564;
	Mon, 13 May 2024 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607913; cv=none; b=KJrDXkeWU/8xwwZfJjriiHt7IjWXITy9jEeUfG2zIRCiBlNosp/U1wtEVaWlFrOMxN73/piuWjFpoxeCwqr8GjsmbYAI5bDjphqEmqicaf321R5VCG3PkEr3PhugRRNleyCWwfplu/Vo8vev+2eeLeCZ/WRR7La/D08DUQeKkIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607913; c=relaxed/simple;
	bh=0OPkApgRov8qvD1jHolUK0luWxRoF9g85rL/jafbLxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pQRZpYuVDv0U7Zqya/szWX3k3K7L/3Nx75XYuwlHqbXBHxUtuAnyW7x5LGn0i98g75w3vnqyLPUPRmoJeAaa8KmgF4RVkM6qM61ffdRFMbKmoUkhw6qzwGIC4esFOQzk+ARb8TYhH2B06geDSykzMSAHykxlEGWUAJrEDaSI8nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QkG5EBcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65EFCC113CC;
	Mon, 13 May 2024 13:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715607913;
	bh=0OPkApgRov8qvD1jHolUK0luWxRoF9g85rL/jafbLxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QkG5EBcNWYeh9tbEoiVl9HJdVNZN4gpae58eTqCEMqen9cDTE2vj9bd46jHtbR0By
	 u8QFCfJJj2Dg91vqbZM6F11LqLJ47YsxvBJmM5XoP4ugHL5OCJS1BzPtu/YjYu5pww
	 vDPo5h3ARLy/u4KGG2WTPImyRWHp9CJ8/E9dMOoD9Bgq1n8ofcbI7pvZPnUvz1ikmL
	 nlmX+6/OoskIslj7kotU0LefHGBdA5lxWKxGVn3W9f0aOEw8HU7SPGuE5tAFaFU9pH
	 3QZGtfpwvRrJiMbYHv4LNaJ/1ntp2/xGTi4s8x3j/zQW76W0KjTWHjevAA9jFLzt4G
	 c93k+dRGKBdSA==
Date: Mon, 13 May 2024 19:14:58 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Hari Bathini <hbathini@linux.ibm.com>, bpf@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, paulmck@kernel.org, 
	puranjay12@gmail.com
Subject: Re: [PATCH bpf v3] powerpc/bpf: enforce full ordering for ATOMIC
 operations with BPF_FETCH
Message-ID: <wlslraxtexuncmqsfen6gum4sg4viecu4zx73pvlfztjmwxenl@fcoal5io4kse>
References: <20240513100248.110535-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513100248.110535-1-puranjay@kernel.org>

On Mon, May 13, 2024 at 10:02:48AM GMT, Puranjay Mohan wrote:
> The Linux Kernel Memory Model [1][2] requires RMW operations that have a
> return value to be fully ordered.
> 
> BPF atomic operations with BPF_FETCH (including BPF_XCHG and
> BPF_CMPXCHG) return a value back so they need to be JITed to fully
> ordered operations. POWERPC currently emits relaxed operations for
> these.
> 
> We can show this by running the following litmus-test:
> 
> PPC SB+atomic_add+fetch
> 
> {
> 0:r0=x;  (* dst reg assuming offset is 0 *)
> 0:r1=2;  (* src reg *)
> 0:r2=1;
> 0:r4=y;  (* P0 writes to this, P1 reads this *)
> 0:r5=z;  (* P1 writes to this, P0 reads this *)
> 0:r6=0;
> 
> 1:r2=1;
> 1:r4=y;
> 1:r5=z;
> }
> 
> P0                      | P1            ;
> stw         r2, 0(r4)   | stw  r2,0(r5) ;
>                         |               ;
> loop:lwarx  r3, r6, r0  |               ;
> mr          r8, r3      |               ;
> add         r3, r3, r1  | sync          ;
> stwcx.      r3, r6, r0  |               ;
> bne         loop        |               ;
> mr          r1, r8      |               ;
>                         |               ;
> lwa         r7, 0(r5)   | lwa  r7,0(r4) ;
> 
> ~exists(0:r7=0 /\ 1:r7=0)
> 
> Witnesses
> Positive: 9 Negative: 3
> Condition ~exists (0:r7=0 /\ 1:r7=0)
> Observation SB+atomic_add+fetch Sometimes 3 9
> 
> This test shows that the older store in P0 is reordered with a newer
> load to a different address. Although there is a RMW operation with
> fetch between them. Adding a sync before and after RMW fixes the issue:
> 
> Witnesses
> Positive: 9 Negative: 0
> Condition ~exists (0:r7=0 /\ 1:r7=0)
> Observation SB+atomic_add+fetch Never 0 9
> 
> [1] https://www.kernel.org/doc/Documentation/memory-barriers.txt
> [2] https://www.kernel.org/doc/Documentation/atomic_t.txt
> 
> Fixes: 65112709115f ("powerpc/bpf/64: add support for BPF_ATOMIC bitwise operations")

As I noted in v2, I think that is the wrong commit. This fixes the below 
four commits in mainline:
Fixes: aea7ef8a82c0 ("powerpc/bpf/32: add support for BPF_ATOMIC bitwise operations")
Fixes: 2d9206b22743 ("powerpc/bpf/32: Add instructions for atomic_[cmp]xchg")
Fixes: dbe6e2456fb0 ("powerpc/bpf/64: add support for atomic fetch operations")
Fixes: 1e82dfaa7819 ("powerpc/bpf/64: Add instructions for atomic_[cmp]xchg")

> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Cc: stable@vger.kernel.org # v6.0+

I have tested this with test_bpf and test_progs.
Reviewed-by: Naveen N Rao <naveen@kernel.org>


- Naveen


