Return-Path: <bpf+bounces-58676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BABABFDC9
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 22:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3D707B670A
	for <lists+bpf@lfdr.de>; Wed, 21 May 2025 20:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6981B28FA98;
	Wed, 21 May 2025 20:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UeE79+8u"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF12B28A1C5;
	Wed, 21 May 2025 20:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747858941; cv=none; b=mGgCPPAbgau3JMCXfzdM6HdlpWcM+ULb0jSk6OXrNd+IjjG2E7lkZyobC63kxpRtfMJSILsD+D74iicdnTRjYLz8c99wBBiczUve7a4bD2TvSIk0eBfxMuodmQIONAE5FAhA/OJKFL9d/xO/m6QxcSfNp+/hxozeH6l0EVTt924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747858941; c=relaxed/simple;
	bh=tsdI9CwQatpCL3BcPkeJNkdunmx7uLx4pQWRvggtIoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LMDwir+CVQNsXHHnI29fpen41s+a0sg5xYwpjNd8WkXCW4U9jChYwBEsZZXazBTpNdr0/+lLlJsN4L7nvAQ3qOCqucgPQZmanU3r6fwccTxhitfVIcOILd4G/6FPs9DydH340bPkIIflp2y49GxgVVHacF5Suz++l1SyVSxDbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UeE79+8u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207B5C4CEEA;
	Wed, 21 May 2025 20:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747858940;
	bh=tsdI9CwQatpCL3BcPkeJNkdunmx7uLx4pQWRvggtIoI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=UeE79+8uCJNzmAjV9GRBgVnB1PfeQCoamEhuYgG6Zr+DIQTd4j6LD5MVilJwZn0KR
	 nSrhFc3iF1oPws/eQT7gjE0mD7OOWeA+DsFjQf8Imve798jFVii/v2qw3qRwl9yRW5
	 wunsD2NbOAJzTxI29swnm9Kk1e/PKunIpzfGcTt75QvQ1LIOXQeN4nXFD+nRIf0vu5
	 iCVVtlTi9Oyc7ztft4wBiAyhTxO/0scs4kfqmx8t2okrVUZIwVHVQqX8IILLC97O1t
	 gU4oLbb+Q0T9LLAC8G328HJt8L+Es6vtvBGnLr6Wt66P9ocfWWH8+98EY+rSUZrBNV
	 psLZqi75aExjg==
From: Puranjay Mohan <puranjay@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: Peilin Ye <yepeilin@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong
 Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, "Stanislav
 Fomichev" <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: verifier: support BPF_LOAD_ACQ in
 insn_def_regno()
In-Reply-To: <m2v7ptd8dk.fsf@gmail.com>
References: <20250521183911.21781-1-puranjay@kernel.org>
 <80ef5e2e-c2d9-45b7-9a48-f8c1a4767eae@gmail.com>
 <CAADnVQLgPBcRAqKfCXQwZae2jKDfp=xSFZCgzHgg-jcBTYp-yw@mail.gmail.com>
 <m2v7ptd8dk.fsf@gmail.com>
Date: Wed, 21 May 2025 20:22:16 +0000
Message-ID: <mb61pbjrlhfyf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eduard Zingerman <eddyz87@gmail.com> writes:

> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> [...]
>
>> I suspect it was already fixed by commit
>> fce7bd8e385a ("bpf/verifier: Handle BPF_LOAD_ACQ instructions in
>> insn_def_regno()")
>
> I see, series [1] is not a part of the tag [2] tested by syzbot, thank you.
>
> [1] "bpf, riscv64: Support load-acquire and store-release instructions"
>     https://lore.kernel.org/all/cover.1746588351.git.yepeilin@google.com/
> [2] 172a9d94339c ("Merge tag '6.15-rc6-smb3-client-fixes'")


Yes, sorry for missing this. The fix is in bpf-next but syzkaller was
testing mainline.

Thanks,
Puranjay

