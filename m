Return-Path: <bpf+bounces-59643-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57900ACE21D
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 18:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7861E3A5179
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 16:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E2A1DF27F;
	Wed,  4 Jun 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H76lsaDM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC5B339A1;
	Wed,  4 Jun 2025 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749054129; cv=none; b=jMhyamVn6M8R3XwmzT7QoDtdAgx2joS5oBRj64Z5W+4ae9E8EZV4gmjUm5vLrg07KjnQvPDGQ5lSTlt1TPeCS2brjGfkSeJhIDgQf/f4XFADyMMJ9RE5XHBYD7RWJXs0e75pcJ467ZGX88lDSrFVrANb2I9TJbjAEETgpHEI0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749054129; c=relaxed/simple;
	bh=NwyhNX9L7Xq2ErWehfIalz8JzuMef0oO/ln44trXpA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gui4qMYhcfRWqIA4xziXBu5Oa3Kc06ASm9RapvP4lP8D/Qn3ehQeXuKL7T29Pkyepwm8uMlFkG7PaDx5CudMQjoZ/y0D5oC8zp8Vk8eXsEpWP5Vy8NQ10xGcViuUOMwUOkaB3gLgDj3gxidt+eKcRBbyqLHO2iRERJQXVk3fcNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H76lsaDM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2569C4CEE4;
	Wed,  4 Jun 2025 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749054128;
	bh=NwyhNX9L7Xq2ErWehfIalz8JzuMef0oO/ln44trXpA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H76lsaDMCV/V1fSovSqUD3ZgpyfaAK1GSAcEleRzyy09LC73xwV/QIc5PtBoh9sIp
	 kG8LzOzST625ooMG9JTmodtSLCJhJOoItoVy/NQK94w8L14M/wOScCcprXSwV6tUFL
	 D5z6yam1/tUrHUK5r5r0NXnjaPSZEESwIqJs2J1m9eJ3lq/veABA/7m/8ItlkpJlYg
	 F+B7FDrBIErALMwEN91J7NCms86WbbIgV6mJ3eKQJ3Pxt3t+Q8sqK/iMZ/Xo3NrnOv
	 XoezvNldvYykhgLZ8BNfqsTyaGtlBlhKxUcMNTlc6/TnPOQyBEd3yTZSoeN+w+Po1X
	 IMspJI66V/OxA==
Date: Wed, 4 Jun 2025 19:22:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Paul Moore <paul@paul-moore.com>, zeffron@riotgames.com,
	xiyou.wangcong@gmail.com, kysrinivasan@gmail.com, code@tyhicks.com,
	linux-security-module@vger.kernel.org, roberto.sassu@huawei.com,
	James.Bottomley@hansenpartnership.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Quentin Monnet <qmo@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Anton Protopopov <aspsk@isovalent.com>,
	Jordan Rome <linux@jordanrome.com>,
	Martin Kelly <martin.kelly@crowdstrike.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Matteo Croce <teknoraver@meta.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/3] BPF signature verification
Message-ID: <aEByrCJ1R_OYDYxH@kernel.org>
References: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528215037.2081066-1-bboscaccy@linux.microsoft.com>

On Wed, May 28, 2025 at 02:49:02PM -0700, Blaise Boscaccy wrote:
> As suggested or mandated by KP Singh
> https://lore.kernel.org/linux-security-module/CACYkzJ6VQUExfyt0=-FmXz46GHJh3d=FXh5j4KfexcEFbHV-vg@mail.gmail.com/,
> this patchset proposes and implements an alternative hash-chain
> algorithm for signature verification of BPF programs.
> 
> This design diverges in two key ways:
> 
> 1. Signature Strategy
> 
> Two different signature strategies are
> implemented. One verifies only the signature of the loader program in
> the kernel, as described in the link above. The other verifies the

Describe "the one" briefly, despite having the link.  Label them A and
B, and also, why there are two strategies. Then you can use those labels
as references later on in this description.

> program’s maps in-kernel via a hash chain.  The original design
> required loader programs to be “self-aborting” and embedded the
> terminal hash verification logic as metaprogramming code generation
> routines inside libbpf. While this patchset supports that scheme, it
> is considered undesirable in certain environments due to the potential
> for supply-chain attack vectors and the lack of visibility for the LSM
> subsystem.  Additionally, it is impossible to verify the code
> performing the signature verification, as it is uniquely regenerated
> for every program.
> 
> 2. Timing of Signature Check
> 
> This patchset moves the signature check to a point before
> security_bpf_prog_load is invoked, due to an unresolved discussion
> here:
> https://lore.kernel.org/linux-security-module/CAHC9VhTj3=ZXgrYMNA+G64zsOyZO+78uDs1g=kh91=GR5KypYg@mail.gmail.com/
> This change allows the LSM subsystem to be informed of the signature
> verification result—if it occurred—and the method used, all without
> introducing a new hook. It improves visibility and auditability,
> reducing the “trust me, friend” aspect of the original design.
> 
> 
> Blaise Boscaccy (3):
>   bpf: Add bpf_check_signature
>   bpf: Support light-skeleton signatures in autogenerated code
>   bpftool: Allow signing of light-skeleton programs
> 
>  include/linux/bpf.h            |   2 +
>  include/linux/verification.h   |   1 +
>  include/uapi/linux/bpf.h       |   4 +
>  kernel/bpf/arraymap.c          |  11 +-
>  kernel/bpf/syscall.c           | 123 +++++++++++++++++++-
>  tools/bpf/bpftool/Makefile     |   4 +-
>  tools/bpf/bpftool/common.c     | 204 +++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/gen.c        |  66 ++++++++++-
>  tools/bpf/bpftool/main.c       |  24 +++-
>  tools/bpf/bpftool/main.h       |  23 ++++
>  tools/include/uapi/linux/bpf.h |   4 +
>  tools/lib/bpf/libbpf.h         |   4 +
>  tools/lib/bpf/skel_internal.h  |  28 ++++-
>  13 files changed, 491 insertions(+), 7 deletions(-)
> 
> -- 
> 2.48.1
> 

BR, Jarkko

