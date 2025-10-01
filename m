Return-Path: <bpf+bounces-70174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D88BB212B
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 01:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F18687B2CC7
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 23:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB5D29CB52;
	Wed,  1 Oct 2025 23:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rT9TYikp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281213594A;
	Wed,  1 Oct 2025 23:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759361590; cv=none; b=tkAEegDCMto6RfyIYxtCpeIgoCRkGnay2h7twQ+ZcmD48/I4BlOpSXwB2Z63Uqy+Y+CqGnBYAgv5MWQAKdDJcEMAb7W8ba0Ytkczp03HSNdULQG098lOWmtXVoTLRkOwxElVMOILrMrbkkXYG8YMIGaDk/3nQaKLEo0nn5gVhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759361590; c=relaxed/simple;
	bh=nxjPZTH2cboLxbGeiqKY+KyNbeP3fDF19+MMfWultYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JkmtjCT90EPvVu20QjeS1BbVEQQlFF6X/xaIFY5Wd3V5fxOXcUCrzt5f5PYthO9d+lq78jwAGUVHx2SQifESI8bAtktn49Sa7GSREQShniXftvgsHAlzkNRsADxWZwZkbuJUt2ZDwOnmQBWaSUW17NxGZEH8L6ZkZi16hrItmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rT9TYikp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC82C4CEF1;
	Wed,  1 Oct 2025 23:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759361586;
	bh=nxjPZTH2cboLxbGeiqKY+KyNbeP3fDF19+MMfWultYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rT9TYikpnEFDxMjYQQWZZR4Ir7wV22Zs3w1t2MoF5lCYuLy0mDTXYoILShTNUw29l
	 PcHuvYLkLYMsPhNIk+e0JnttkxbVrIZGQ3LdD1uWusS0T/GoBS0tf14P17U6mlVtSp
	 8I/LP2CmDq9VamgT9bWizCFm8SjA0BO9OFvmwDg+1mYgO97iOrsWtjCFhnfohycu8i
	 hgGj9jrwi2gTjMJzIhPFtPacaH23qhoglsaWQ+gx8tW1CP727a0almdHSjbkJKgSVE
	 Y84DV0bR0qpFjrdUvhyhMvf8UrVhR0EEakpqUs+QiQo+RaKtcC/HFayf9tks4B0SNG
	 /BC1RlTkDKawA==
Date: Wed, 1 Oct 2025 16:33:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	bpf <bpf@vger.kernel.org>,
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH iproute2-next v2] lib/bpf_legacy: Use userspace SHA-1
 code instead of AF_ALG
Message-ID: <20251001233304.GB2760@quark>
References: <20250929194648.145585-1-ebiggers@kernel.org>
 <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQKKQEjZjz21e_639XkttoT4NvXYxUb8oTQ4X7hZKYLduQ@mail.gmail.com>

On Wed, Oct 01, 2025 at 03:59:31PM -0700, Alexei Starovoitov wrote:
> On Mon, Sep 29, 2025 at 12:48 PM Eric Biggers <ebiggers@kernel.org> wrote:
> >
> > Add a basic SHA-1 implementation to lib/, and make lib/bpf_legacy.c use
> > it to calculate SHA-1 digests instead of the previous AF_ALG-based code.
> >
> > This eliminates the dependency on AF_ALG, specifically the kernel config
> > options CONFIG_CRYPTO_USER_API_HASH and CONFIG_CRYPTO_SHA1.
> >
> > Over the years AF_ALG has been very problematic, and it is also not
> > supported on all kernels.  Escalating to the kernel's privileged
> > execution context merely to calculate software algorithms, which can be
> > done in userspace instead, is not something that should have ever been
> > supported.  Even on kernels that support it, the syscall overhead of
> > AF_ALG means that it is often slower than userspace code.
> 
> Help me understand the crusade against AF_ALG.
> Do you want to deprecate AF_ALG altogether or when it's used for
> sha-s like sha1 and sha256 ?

Altogether, when possible.  AF_ALG has been (and continues to be)
incredibly problematic, for both security and maintainability.

> I thought the main advantage of going through the kernel is that
> the kernel might have an optimized implementation for a specific
> architecture, while the open coded C version is generic.
> The cost of syscall and copies in/out is small compared
> to actual math, especially since compilers might not be smart enough
> to use single asm insn for rol32() C function.

Not for small amounts of data, since syscalls are expensive these days.

(Aren't BPF programs usually fairly small?)

BTW, both gcc and clang reliably lower rol32() to a single instruction.

> sha1/256 are simple enough in plain C, but other crypto/hash
> could be complex and the kernel may have HW acceleration for them.
> CONFIG_CRYPTO_USER_API_HASH has been there forever and plenty
> of projects have code to use that. Like qemu, stress-ng, ruby.
> python and rust have standard binding for af_alg too.
> If the kernel has optimized and/or hw accelerated crypto, I see an appeal
> to alway use AF_ALG when it's available.

Well, userspace programs that want accelerated crypto routines without
incorporating them themselves should just use a userspace library that
has them.  It's not hard.

But iproute2 should be fine with just the generic C code.

As for why AF_ALG support keeps showing up in different programs, it's
mainly just a misunderstanding.  But I think you're also overestimating
how often it's used.  Your 5 examples were 4 bindings (not users), and 1
user where it's disabled by default.

There are Linux systems where it's only iproute2 that's blocking
CONFIG_CRYPTO_USER_API_HASH from being disabled.  This patch is really
valuable on such systems.

- Eric

