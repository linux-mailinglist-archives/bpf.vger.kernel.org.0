Return-Path: <bpf+bounces-46311-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A19E781B
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391BD282B52
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91141CF5DF;
	Fri,  6 Dec 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6prhrZL"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B58C2206AA;
	Fri,  6 Dec 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509854; cv=none; b=fb3PYpumBAGaXhUnMrvbRGau3GUQbHPjzBixnS2vSjdIQCMzArySXQ65x5j37yQ+ePUM57DV7ol5Gt+1ts9R+XV1mYu8kurEd8moTelBqUxXyafL9+TkIPN9fu8qHLeu/h97oTadb6/kVmjnGx7jgswyMKWMvsE0TfrWV4dBT4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509854; c=relaxed/simple;
	bh=2Wp24oJjXS/c9KQXLyDUphzW/qraZohmgTe7ujYSFSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aK9aRFejcaPL64fu9QQ98xM/zzlERrzwuGEF6TyesS6OVP1OwIH7CugB1mD+BIaK2n6ngYEHFwz5z21t0nHX/JD2crNzZNjpDqaUC0vhHTP/fbAEjicHXCI+ObKBi/Xohl9DQit5gUSpbvX86FWB+nBMW5XQkR+qEyAMj+6qZZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6prhrZL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7A3C4CED1;
	Fri,  6 Dec 2024 18:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733509854;
	bh=2Wp24oJjXS/c9KQXLyDUphzW/qraZohmgTe7ujYSFSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6prhrZLaqnpL2CAavS5gfQsS2iZ/mKrbFnfjXGjIgbqbeyqNK/0u/6QnENJ3DAd/
	 su2+OTszv4DMwkmJEdjwpW3x4LE8V31DDnf4hZVWQTfNQmKtacfbKWB+BWcaYXtxL9
	 1+FQEeAu0VR0Kn291m+BeWvfNLUiVpmwUBuAcmQeX6ijIq6104g1B0xSjauIIBXNVD
	 RRfpw2KzwugF27IgLzFOJpOMvfJjWNHFYU8LqaLUd1sA0x+2DM6rFBzTOr5RnlW1UG
	 UXyXF5SO+S9fpGgbdq7zxKNXm99gfG3IUSbVs75fsxuollXzXJHixb+DH4WGQ7XusT
	 O5LyaoMKe4NSg==
Date: Fri, 6 Dec 2024 15:30:50 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: Jiri Olsa <olsajiri@gmail.com>, dwarves@vger.kernel.org,
	bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com,
	andrii@kernel.org, mykolal@fb.com
Subject: Re: [RFC PATCH 0/9] pahole: shared ELF and faster reproducible BTF
 encoding
Message-ID: <Z1NC2og1Gvm55yz1@x1>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me>
 <Z028YOBN_EnUA9Qm@krava>
 <fikVGe8GqZ4_KsZX_M0ZKNEqN-lRzqCvhrqjTP3P5QyV9g3Ath6VcnHrS45P8GNSaTOa-W83VHgjrqlTDSPUIeoCWNhAFnkJJsQaYthVR2k=@pm.me>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fikVGe8GqZ4_KsZX_M0ZKNEqN-lRzqCvhrqjTP3P5QyV9g3Ath6VcnHrS45P8GNSaTOa-W83VHgjrqlTDSPUIeoCWNhAFnkJJsQaYthVR2k=@pm.me>

On Fri, Dec 06, 2024 at 06:19:24PM +0000, Ihor Solodrai wrote:
> On Monday, December 2nd, 2024 at 5:55 AM, Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > 
> > 
> > On Thu, Nov 28, 2024 at 01:23:44AM +0000, Ihor Solodrai wrote:
> > 
> > SNIP
> > 
> > > Test results for this patch series:
> > > 
> > > 1: Validation of BTF encoding of functions; this may take some time: Ok
> > > 2: Default BTF on a system without BTF: Ok
> > > 3: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfunc), ignoring
> > > WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonly_cast already with attribute (bpf_kfunc), ignoring
> > > pahole: type 'nft_pipapo_elem' not found
> > > pahole: type 'ip6t_standard' not found
> > > pahole: type 'ip6t_error' not found
> > > pahole: type 'nft_rbtree_elem' not found
> > > pahole: type 'nft_rule_dp_last' not found
> > > pahole: type 'nft_bitmap_elem' not found
> > > pahole: type 'fuse_direntplus' not found
> > > pahole: type 'ipt_standard' not found
> > > pahole: type 'ipt_error' not found
> > > pahole: type 'tls_rec' not found
> > > pahole: type 'nft_rhash_elem' not found
> > > pahole: type 'nft_hash_elem' not found
> > > Ok
> > > 4: Pretty printing of files using DWARF type information: Ok
> > > 5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
> > 
> > 
> > hi,
> > when trying selftests with this change, I'm getting wrong .BTF
> > on bpf selftest bpf_testmod.ko module
> > 
> > $ bpftool btf dump file ./bpf_testmod.ko
> > Error: failed to load BTF from ./bpf_testmod.ko: Invalid argument
> 
> Hi Jiri, thank you for testing.
> 
> I think the reason for this failure is that changes in the last patch
> of the series [1] don't handle correctly a situation when the number
> of CUs is lesser than the number of jobs. I was too focused on trying
> to speed up vmlinux encoding.
> 
> I am going to try implementing a clear queueing interface between
> dwarf_loader and pahole_stealer. Hopefully it will make it harder to
> introduce bugs like this.
> 
> I've started working on the v2 of this series which I hope to submit
> sometime next week.

Thanks for working on this! I'll try to join the reviewers team soon.

- Arnaldo
 
> [1] https://lore.kernel.org/dwarves/20241128012341.4081072-10-ihor.solodrai@pm.me/
> 
> > 
> > jirka
> > 
> > > Alan Maguire (3):
> > > btf_encoder: simplify function encoding
> > > btf_encoder: store,use section-relative addresses in ELF function
> > > representation
> > > btf_encoder: separate elf function, saved function representations
> > > 
> > > Ihor Solodrai (6):
> > > dwarf_loader: introduce pre_load_module hook to conf_load
> > > btf_encoder: introduce elf_functions struct type
> > > btf_encoder: collect elf_functions in btf_encoder__pre_load_module
> > > btf_encoder: switch to shared elf_functions table
> > > btf_encoder: introduce btf_encoding_context
> > > pahole: faster reproducible BTF encoding
> > > 
> > > btf_encoder.c | 661 ++++++++++++++++++++++++++++++-------------------
> > > btf_encoder.h | 6 +
> > > dwarf_loader.c | 18 +-
> > > dwarves.c | 47 ++--
> > > dwarves.h | 16 +-
> > > pahole.c | 265 +++++++++-----------
> > > 6 files changed, 567 insertions(+), 446 deletions(-)
> > > 
> > > --
> > > 2.47.0

