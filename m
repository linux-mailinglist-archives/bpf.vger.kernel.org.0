Return-Path: <bpf+bounces-33703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE3924C29
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 01:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CC0E284E08
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22E17A5AB;
	Tue,  2 Jul 2024 23:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fs1/yN75"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AC31DA332;
	Tue,  2 Jul 2024 23:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719963357; cv=none; b=nzR2GWoy5DN4zZ5Mt/ND43Sha+qvn0r9mBUnzenbt8+LDiR2WG2IDuAZviGiZGy+96EIcmhsgMfpHxforPX2Isj9DG9PnlOxO4zKsw9k8of+D2i7RCV47AmbEIonZCk0/Oe4lCi3VkHGwYPzsUVCH0Z2ugeZMyE31/aBKi7OIno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719963357; c=relaxed/simple;
	bh=s1dNurZZUgAMZEUw/CDVR+LX8oLjdjongL+x2frTR5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4Yl1jRgBSSsmSJ8C0hE1V9ZtLlbDH8O3nz3tbeHQaUn+fyum3mYyomPNPGZ421SGGNqpCT/uTjQeMjr+1mIT+f2tTexzcQ9xifPscYp12RfprXdSk/MxkWHwJB60L0JqqwJnCh2OvtzYUlAsaThB+2F4DGDo6rZiVxyLZL74o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fs1/yN75; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4EC116B1;
	Tue,  2 Jul 2024 23:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719963356;
	bh=s1dNurZZUgAMZEUw/CDVR+LX8oLjdjongL+x2frTR5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fs1/yN75HGcu1NEnU+H5/xO+uu/v41imPVXqvhAMKWZywmdNZTrkkRU0ipd7bpl7I
	 n2ku0Xcy5EYGC5HmqfIpej4al1TCRlIsltPUzM1zeEirQPeo5n0uqYQm9A2FxSX1Y2
	 fhfqDoSwrEyAL0JtcM83ZHyd4pmDD7RuplWGij/bQi8Gf8n28LhSi8N/4aUnNnZEN0
	 70EvzcdDkBiVi9qn6OpvfdYZWogtczh6tnR2uBkgl0aUKt5MceJQbQ7gMLSa9Jj0SN
	 MgNFWIn/dgwVpYjnT5Cx2/a7em0NdKW5AgLfueQdp5xNYu+xl2YaX3PQCPXBak2z+e
	 VyRn4fAb5Re+A==
Date: Tue, 2 Jul 2024 16:35:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org,
	mingo@redhat.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v2] perf,x86: avoid missing caller address in stack
 traces captured in uprobe
Message-ID: <20240702233554.slj6kh7dn2mc2w4n@treble>
References: <20240702171858.187562-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240702171858.187562-1-andrii@kernel.org>

On Tue, Jul 02, 2024 at 10:18:58AM -0700, Andrii Nakryiko wrote:
> When tracing user functions with uprobe functionality, it's common to
> install the probe (e.g., a BPF program) at the first instruction of the
> function. This is often going to be `push %rbp` instruction in function
> preamble, which means that within that function frame pointer hasn't
> been established yet. This leads to consistently missing an actual
> caller of the traced function, because perf_callchain_user() only
> records current IP (capturing traced function) and then following frame
> pointer chain (which would be caller's frame, containing the address of
> caller's caller).
> 
> So when we have target_1 -> target_2 -> target_3 call chain and we are
> tracing an entry to target_3, captured stack trace will report
> target_1 -> target_3 call chain, which is wrong and confusing.
> 
> This patch proposes a x86-64-specific heuristic to detect `push %rbp`
> (`push %ebp` on 32-bit architecture) instruction being traced. Given
> entire kernel implementation of user space stack trace capturing works
> under assumption that user space code was compiled with frame pointer
> register (%rbp/%ebp) preservation, it seems pretty reasonable to use
> this instruction as a strong indicator that this is the entry to the
> function. In that case, return address is still pointed to by %rsp/%esp,
> so we fetch it and add to stack trace before proceeding to unwind the
> rest using frame pointer-based logic.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Should it also check for ENDBR64?

When compiled with -fcf-protection=branch, the first instruction of the
function will almost always be ENDBR64.  I'm not sure about other
distros, but at least Fedora compiles its binaries like that.

-- 
Josh

