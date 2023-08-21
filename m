Return-Path: <bpf+bounces-8180-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7292D78310A
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 21:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A414F1C2099D
	for <lists+bpf@lfdr.de>; Mon, 21 Aug 2023 19:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A81911719;
	Mon, 21 Aug 2023 19:47:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050C04A10
	for <bpf@vger.kernel.org>; Mon, 21 Aug 2023 19:47:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1362C433C8;
	Mon, 21 Aug 2023 19:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692647233;
	bh=gwInEFrUgNPaOzndjIQl4NZj8jTnx6pbvKKMC94/cjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H1gQqgl5fL/yvLWDiPMdzFmF3ZK/pNr2EMgh+4GDVpqkf7gUiXSWptyaJwmEC89hH
	 QO2nJDrxEPgoNJyFlf7/CKJjOJCrLWi/9KJeGs98AKFCpyCO+k2TFf+DsOvUyFDiTa
	 0vd4vnUJCfa/CCfZP3A9VSZVJQg1NTZb82cCD+gPniwERKxdRPS4vtJpvLDKHNKxdJ
	 W33DykXDaQ//vMQHjklzbDKH6n34wahqF7rC2ronqjGdQLamEDDYV5yo9lgrFJXtfh
	 UAgV5zcOR0D6HQ85wGagXZ1sy5yfr2pRNwO7GeX84BcBU5pSNz7NJ4TDrQikUsijZC
	 0EMbTv6YqeuRQ==
Date: Mon, 21 Aug 2023 12:47:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Shubham Bansal
 <illusionist.neo@gmail.com>, Johan Almbladh
 <johan.almbladh@anyfinetworks.com>, Paul Burton <paulburton@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang
 <xi.wang@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, bpf
 <bpf@vger.kernel.org>
Subject: Re: bpf: Request to add -mcpu=v4 support for
 ARM/MIPS/NFP/POWERPC/RISCV/S390/SPARC/X86_32
Message-ID: <20230821124711.15babfee@kernel.org>
In-Reply-To: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
References: <79d3c797-17ba-bc9e-b1f9-44ad024b576f@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Aug 2023 18:41:30 -0700 Yonghong Song wrote:
> Hi,
> 
> A new set of bpf insns have been recently added in llvm with flag
> [-mcpu=v4](https://reviews.llvm.org/D144829). In the kernel,
> x86_64 and arm64 have implemented -mcpu=v4 support:
>    x86_64: 
> https://lore.kernel.org/all/20230728011143.3710005-1-yonghong.song@linux.dev/
>    arm64: 
> https://lore.kernel.org/bpf/20230815154158.717901-1-xukuohai@huaweicloud.com/
> 
> The following arch's do not have -mcpu=v4 support yet:
>    arm, mips, nfp, powerpc, riscv, sc90, sparc and x86_32
> 
> If you have a chance, could you take a look at what
> x86_64/arm64 does and add support to the above arch'es?

Louis, is anyone on your side still working on BPF for NFP?
div/mod and the jump will be impossible but there may be instructions
for sign extend or bswap?

