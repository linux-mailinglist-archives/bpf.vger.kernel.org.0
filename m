Return-Path: <bpf+bounces-28641-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E08E8BC497
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 00:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F90F1C209DA
	for <lists+bpf@lfdr.de>; Sun,  5 May 2024 22:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A7913FD89;
	Sun,  5 May 2024 22:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVcs4MQY"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F161663A5
	for <bpf@vger.kernel.org>; Sun,  5 May 2024 22:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714948816; cv=none; b=cZ14QyUj5Kkbel1IXG73SErXQ55Nh0lGjWmk/k3Q4SRHHxmp0QO5r/8pfqe8xJj240Xm3sMM3hnsrcn5xAVSjdwFHYo+Hr9KeYUK4pRDvilza6Bl5kIfZMWh7rhCIw/Tj4+ITkpy9EkvUQzgpk3hZ39Oe8cmsUf9bSNIsYh3t4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714948816; c=relaxed/simple;
	bh=cY67q3Htp1F3PnW4lYX7M2WO2OjIbSwp6v3VLyM6JHo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sSFM5q8yI03aOjBF5y09hx44cAS7TcbyVTQ8VN2+Xt86oM2G90kHWSbo+ypRMn1EFxxLcm0iRL4lLBIZPLU2ADFT+iBvqNbZ+vKdc3QTLsizOpZ+RYjXYdJ0/49PgUN3LNVhyc58Kth4rr758qXyPcPhu8AlfSrbSp2BehQjIGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVcs4MQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E011C113CC;
	Sun,  5 May 2024 22:40:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714948815;
	bh=cY67q3Htp1F3PnW4lYX7M2WO2OjIbSwp6v3VLyM6JHo=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=aVcs4MQY2ggvPLtNMyxNj1ZnhScUytHF499euH8Tr9BfGasMaQNcKxOYW1N7YX6j6
	 o9EjgKpNvmKAfQ6AUocdBHGae7SJ0ED/L5dzmMAVIzsfGvXZy4vq0nZHMQNG0bcaUb
	 3+5uWmI1Xr/rQ51kLiLffzeBrBmrAD2FWaNcASsWTBoJ5RiyA2Whgvf85yYAFWxpwK
	 9sxvsashFDUnCGMX6Jg5lKGv4odjaCIQobNs/25BTECyhx03RfbnP7fRzMXo0Iunjc
	 PWzn/BLxD37wIJnJNMR6ANNsBX5wIq85YR3nGdhSI2gjHAEcZOysSom52lM15AdLBj
	 InSFj5JwUAOtg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Pu
 Lehui
 <pulehui@huawei.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 bpf@vger.kernel.org, Naveen N. Rao <naveen.n.rao@linux.ibm.com>, Ilya
 Leoshkevich <iii@linux.ibm.com>, Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH bpf] riscv, bpf: make some atomic operations fully ordered
In-Reply-To: <20240505201633.123115-1-puranjay@kernel.org>
References: <20240505201633.123115-1-puranjay@kernel.org>
Date: Sun, 05 May 2024 22:40:00 +0000
Message-ID: <mb61p34qvq3wf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Puranjay Mohan <puranjay@kernel.org> writes:

> The BPF atomic operations with the BPF_FETCH modifier along with
> BPF_XCHG and BPF_CMPXCHG are fully ordered but the RISC-V JIT implements
> all atomic operations except BPF_CMPXCHG with relaxed ordering.

I know that the BPF memory model is in the works and we currently don't
have a way to make all the JITs consistent. But as far as atomic
operations are concerned here are my observations:

1. ARM64 and x86
   -------------

JITs are following the LKMM, where:

Any operation with BPF_FETCH, BPF_CMPXCHG, and BPF_XCHG is fully
ordered.

On x86, this is by the virtue of its memory model where locked
instructions are fully ordered. ARM64 is emitting explicit instructions
to make sure the above are fully ordered.


2. RISCV64
   -------

JIT was emitting all atomic instructions with relaxed ordering, the
above patch fixes it to follow LKMM.


3. POWERPC
   -------

JIT is emitting all atomic instructions with relaxed ordering. It
implements atomic operations using LL and SC instructions, we need to
emit "sync" instructions before and after this sequence to make it
follow the LKMM. This is how the kernel is doing it.

Naveen, can you ack this? if this is the correct thing to do, I will
send a patch.


4. S390
   ----

Ilya, can you help with this?

I see that the kernel is emitting "bcr 14,0" after "laal|laalg" but the
JIT is not.


5. Loongarch
   ---------
   
Tiezhu, can you help with this?

I see that the JIT is using am*.{w/d} instructions for all atomic
accesses. I see that there are am*_db.{w/d} instructions in the ISA that
also implement the data barrier function with the atomic op. Maybe
these need to used for BPF_FETCH, BPF_XCHG, and BPF_CMPXCHG as the
kernel is using them for arch_atomic_fetch_add() etc.


Thanks,
Puranjay

