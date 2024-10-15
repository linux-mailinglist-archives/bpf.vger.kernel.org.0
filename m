Return-Path: <bpf+bounces-42095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25899F8F4
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 23:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC2502832B1
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2024 21:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B4F1FBF69;
	Tue, 15 Oct 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6PXr5i6"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ACE1FBF42
	for <bpf@vger.kernel.org>; Tue, 15 Oct 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027085; cv=none; b=o6tkr6b10YjPvjhoNaFok26tLBGqUsSGxpLyPrsPUTK4oVej3WYjOjC0y2cu+IckTXDaFG61Y+oyhmcZwkU9oKEpnx2qpdp24puykUJ++mVV8cAQ4TfD2FT8HsNp3zG1BQ7pyUmjISjk+jP+y24DqyBjPbOGf3bP0/z6fLeEu8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027085; c=relaxed/simple;
	bh=onm/JbO/nP1k0cTinwLB0u0pCxZGBRR/yU8LJf5WBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qe6W6w/R8eN/3H/J5LgPTaQKyZ7LN4SASNlyZR0QkU2VuAN2VogPIP7vqfi0gQvZOBUEnaz6FaGRSyX0F5QC+1/5HeoepdgqF/uR4j84iSfq2fcjyNmEzDnwVfmRHW6HDczjybwFYmLugo12tHOR25UrdiA3YzomO95YO1Yw4Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6PXr5i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B62BC4CEC6;
	Tue, 15 Oct 2024 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729027085;
	bh=onm/JbO/nP1k0cTinwLB0u0pCxZGBRR/yU8LJf5WBZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S6PXr5i6899/dXOdUPLWO/Ltsv8SlttK8nufPZ8Ykcd75T2LbexZjbOZEKHykKDXP
	 MC8FLnwPqHOJPa6EIUyBD3z8hk9qOK4Nhsuil2zOw2p+ZK07EWcKIdYNclm/V1zxO6
	 GV7WR3shVUfb78KCZimk17dxA3YjS/f70BY4hpNsyi8DJPXZWAlpQy36L6V05OMWDm
	 TquVWILsR24Jk1unRgwrNyKUxGVRqIPIKAqFpmVqunh6oIuxTpdnyJnXHgbc4a9huP
	 STaq0q0R7IrrvNHfDF/o3b6nen8EcCQzR46Vq4cp2BcJr7cdmNFsn72kHAdk+49siE
	 FlAEcEVU9lekA==
Date: Tue, 15 Oct 2024 11:18:04 -1000
From: Tejun Heo <tj@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kernel Team <kernel-team@fb.com>,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v4 07/10] bpf: Support calling non-tailcall bpf
 prog
Message-ID: <Zw7cDCpYE_WyFPSM@slm.duckdns.org>
References: <20241010175552.1895980-1-yonghong.song@linux.dev>
 <20241010175628.1898648-1-yonghong.song@linux.dev>
 <CAADnVQJMuR_riNLghmr0ohrEZSj-8ngcFQRn3VkdDyJAFakqKQ@mail.gmail.com>
 <96556ec2-f98c-444b-b0aa-ddf71e185c7d@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96556ec2-f98c-444b-b0aa-ddf71e185c7d@linux.dev>

Hello,

On Thu, Oct 10, 2024 at 09:12:19PM -0700, Yonghong Song wrote:
> > Let's get priv_stack in shape first (the first ~6 patches).
> 
> I am okay to focus on the first 6 patches. But I would like to get
> Tejun's comments about what is the best way to support hierarchical
> bpf based scheduler.

There isn't a concrete design yet, so it's difficult to say anything
definitive but I was thinking more along the line of providing sched_ext
kfunc helpers that perform nesting calls rather than each BPF program
directly calling nested BPF programs.

For example, let's say the scheduler hierarchy looks like this:

  R + A + AA
    |   + AB
    + B

Let's say AB has a task waking up to it and is calling ops.select_cpu():

 ops.select_cpu()
 {
	if (does AB already have the perfect CPU sitting around)
		direct dispatch and return the CPU;
	if (scx_bpf_get_cpus(describe the perfect CPU))
		direct dispatch and return the CPU;
	if (is there any eligible idle CPU that AB is holding)
		direct dispatch and return the CPU;
	if (scx_bpf_get_cpus(any eligible CPUs))
		direct dispatch and return the CPU;
	// no idle CPU, proceed to enqueue
	return prev_cpu;
 }

Note that the scheduler at AB doesn't have any knowledge of what's up the
tree. It's just describing what it wants through the kfunc which is then
responsible for nesting calls up the hierarhcy. Up a layer, this can be
implemented like:

 ops.get_cpus(CPUs description)
 {
	if (has any CPUs matching the description)
		claim and return the CPUs;
	modify CPUs description to enforce e.g. cache sharing policy;
	and possibly to request more CPUs for batching;
	if (scx_bpf_get_cpus(CPUs description)) {
		store extra CPUs;
		claim and return some of the CPUs;
	}
	return no CPUs available;
 }

This way, the schedulers at different layers are isolated and each only has
to express what it wants.

Thanks.

-- 
tejun

