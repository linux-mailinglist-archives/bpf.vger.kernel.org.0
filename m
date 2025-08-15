Return-Path: <bpf+bounces-65772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F402B28134
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 16:04:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA27F58483B
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 14:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D5519ADBA;
	Fri, 15 Aug 2025 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSKFht4b"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D018715ECD7;
	Fri, 15 Aug 2025 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755266482; cv=none; b=Yb0ICpKmZsphJfjHwdgZlqwnyRoS0BLkUIwBHZLHCsP14U1TDZRXTDPJI4W0Zfb3UzJYIvVBoLnfgQoZUXSiiFs4bekCDmtLMLiNrAuikDGoqvFBZhGDR/70PcWR52veeYZbfThEv8PTUUTy4JkqKmRWpK3Yi6Rc2XA5E3Rulqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755266482; c=relaxed/simple;
	bh=skS0HIs2v5vTHHIpHmAGLv/El95Pa4L+GCcYF6GXMd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVzOvmRB3iMwXZAbJ04UeKeqMREqed3mtZjjv7jmK/GiguvvLjGFYnjC9xFwrWlJwS/AAA4dbMCji+atAUhSnXoD7Bfbxhk3MphQGUGQhra/oaxISJzJycKEh9H6oXgBdTmF/7sZlfW0ikhrbVVms0bbI/wOqVHPPhCRHnAeqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSKFht4b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3304C4CEEB;
	Fri, 15 Aug 2025 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755266482;
	bh=skS0HIs2v5vTHHIpHmAGLv/El95Pa4L+GCcYF6GXMd8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iSKFht4bNG0Zxcrzot6TWVgG93pguYaNTqkda5W8BXAVUX8RA6nqCaTYjwM8GeR42
	 5/DDBkCGlf2kGWIlmbC+l+f69oYR+9eCdr7aBE4dIgWS/pQeWG4gBPRUTOFQ5DbhaO
	 N78iG/ObPhKn6WAnXG2p17Pd2qJZjV1hLEdJVObjEC/EDbXXpW6zl72mOYn7chpVM6
	 ropI+yfUYlcPXm+oGtP4XqN50rWu9VJ04B4hfIXVkFLTvJJWCxTrXoxKKZv/mm9lX+
	 sBfa9kOqB3WiTyczqPjYh+fS/R30TsTYhFRUw7kPXW9NfDIqjUPKeQnFm72fmgkPgD
	 1i9LFIlORW/5w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>, Puranjay Mohan
 <puranjay@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre
 Ghiti <alex@ghiti.fr>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] riscv, bpf: fix reads of thread_info.cpu
In-Reply-To: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
References: <20250812090256.757273-2-rkrcmar@ventanamicro.com>
Date: Fri, 15 Aug 2025 16:01:19 +0200
Message-ID: <87tt2865w0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Radim!

Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com> writes:

> Hello,
>
> These patches are related to a recently queued series [1] that fixes the
> same bugs in normal code.  That series finishes with a patch that would
> have exposed the BPF bugs, but luckily it won't get merged until v6.18.
>
> I don't know enough about BPF to verify that it emits the correct code
> now, so any pointers are welcome.
>
> 1: https://lore.kernel.org/linux-riscv/20250725165410.2896641-3-rkrcmar@v=
entanamicro.com/

Apologies for the slow review!

For the series:

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU


