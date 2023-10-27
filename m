Return-Path: <bpf+bounces-13416-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E707D94BC
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8526F1F23571
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 10:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B7C17993;
	Fri, 27 Oct 2023 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="kG9V+Tlb"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71D17998
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 10:08:27 +0000 (UTC)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D6194
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 03:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1698401300;
	bh=cEQzeRUXv06MDDaWaCL3j8A2cyadnKJYI/xOqlzkLb8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=kG9V+TlbtxYc6/VtuMoWuvBZZA96pY4nS+XT7Nk8tNGzXDS0qUTJDw/iom4amzGUs
	 o5mf0oL6rVs5GyxnE2jxhg++oQteRkEejCVvNm/DQnoQRDlMJ4ETcOqg7kX0b0MhHA
	 ZPH6Vvd1Aj528Vy5h1it58MVthf85Mu6xu1t/2v/bTtrTPXuRbuftFMCW0lS6EuFCF
	 npUrn+8EMpsdjyGdcULpKW8b9OkQSVaV+7Vki9jN8aZwzVfjM5Sy/+n+V+rm05kD4g
	 laosIOu2TNnig+8K9IYQq5RytOfrHgJf0UO4Lsv/e4jvFJalxkVeiBuRWrX9grNYjR
	 BjoGVMRreDrMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyzS0qnXz4xWm;
	Fri, 27 Oct 2023 21:08:20 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, bpf@vger.kernel.org, Hari Bathini <hbathini@linux.ibm.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Song Liu <songliubraving@fb.com>, Christophe Leroy <christophe.leroy@csgroup.eu>
In-Reply-To: <20231020141358.643575-1-hbathini@linux.ibm.com>
References: <20231020141358.643575-1-hbathini@linux.ibm.com>
Subject: Re: [PATCH v7 0/5] powerpc/bpf: use BPF prog pack allocator
Message-Id: <169840079686.2701453.13107509549614413199.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:59:56 +1100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

On Fri, 20 Oct 2023 19:43:53 +0530, Hari Bathini wrote:
> Most BPF programs are small, but they consume a page each. For systems
> with busy traffic and many BPF programs, this may also add significant
> pressure on instruction TLB. High iTLB pressure usually slows down the
> whole system causing visible performance degradation for production
> workloads.
> 
> bpf_prog_pack, a customized allocator that packs multiple bpf programs
> into preallocated memory chunks, was proposed [1] to address it. This
> series extends this support on powerpc.
> 
> [...]

Applied to powerpc/next.

[1/5] powerpc/code-patching: introduce patch_instructions()
      https://git.kernel.org/powerpc/c/465cabc97b42405eb89380ea6ba8d8b03e4ae1a2
[2/5] powerpc/bpf: implement bpf_arch_text_copy
      https://git.kernel.org/powerpc/c/6efc1675acb88eef45ef0156b93f95d66a8ee759
[3/5] powerpc/bpf: implement bpf_arch_text_invalidate for bpf_prog_pack
      https://git.kernel.org/powerpc/c/033ffaf0af1f974ecf401db3f70aae6fe1a90fc5
[4/5] powerpc/bpf: rename powerpc64_jit_data to powerpc_jit_data
      https://git.kernel.org/powerpc/c/de04e40600ae15fa5e484be242e74aad6de7418f
[5/5] powerpc/bpf: use bpf_jit_binary_pack_[alloc|finalize|free]
      https://git.kernel.org/powerpc/c/90d862f370b6e9de1b5d607843c5a2f9823990f3

cheers

