Return-Path: <bpf+bounces-46303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D46F9E77FA
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD248285D2D
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 18:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD40A1F3D5E;
	Fri,  6 Dec 2024 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="X0VB8UZt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E988256E;
	Fri,  6 Dec 2024 18:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733509187; cv=none; b=CR1zlwR9rDL/XS8RyDQQbKceMq9wMqFvskx4suVTdl9tDj4E5IVilIg5N7h+J7L8zgI26MdpnIWB/3Ea6AyH3UwOXWeOCqvQriUYxOSk70eXhxSr+WuGTYZRNOxK5ET4P3PfGoRlX5UoLHibH8T2+cSftFirA0E0df25ED9bJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733509187; c=relaxed/simple;
	bh=gDhBHxu2UN2SJqYmKxQv8z50jnxUVO5lKBpTJhtg/Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jl0YI8jOH32jUQCm4rnmiqq2j+mpTVAxCj+u7KKIpU6FiiJXNpZCKiSxpIHUU157dcWW4WFxcJXNWf0fAX8d9EIpjjm0yIKulEAwOomjWf2prlTQP418Uyl2gknDE6AO5vAxob9sMxvXHLKQRgmmpFduKcg5DdcnIq93d7X5pec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=X0VB8UZt; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1733509169; x=1733768369;
	bh=gDhBHxu2UN2SJqYmKxQv8z50jnxUVO5lKBpTJhtg/Io=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=X0VB8UZtqym5fClTHNpGe9571AlI3jaAkHaP8Z7IXaAZ0GDd9QXXy8nhHy77w9Fib
	 gTNE2n5dTKXFmtEA8HqsI6tRbSncWJS0tEdFZxAPWKJRMS9ym+Ec0sabz/j3hKsXw5
	 kXxemAvgTws+n6W8Bc5It7db22/fy8k8VHHOv5Bl5edEQ+HEWlB3HwZKD8PBI0/8J4
	 rEophTg48LXVA9AJqSw2tOgH8YKwwMbhheJWqmCUovyPmPBMy9/+sZq88xy3NfHIfg
	 Dc2DVnn3sjX7EH5TQOQVgbPDeTxLVEIP2rGmayemJZNBUq/IM3oE+Mlm+UdgWx+MMP
	 /6lD2FkvoEyTw==
Date: Fri, 06 Dec 2024 18:19:24 +0000
To: Jiri Olsa <olsajiri@gmail.com>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: dwarves@vger.kernel.org, acme@kernel.org, bpf@vger.kernel.org, alan.maguire@oracle.com, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com
Subject: Re: [RFC PATCH 0/9] pahole: shared ELF and faster reproducible BTF encoding
Message-ID: <fikVGe8GqZ4_KsZX_M0ZKNEqN-lRzqCvhrqjTP3P5QyV9g3Ath6VcnHrS45P8GNSaTOa-W83VHgjrqlTDSPUIeoCWNhAFnkJJsQaYthVR2k=@pm.me>
In-Reply-To: <Z028YOBN_EnUA9Qm@krava>
References: <20241128012341.4081072-1-ihor.solodrai@pm.me> <Z028YOBN_EnUA9Qm@krava>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 8e958742b27542a6e8a57f6bbdcb4979106c93c9
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, December 2nd, 2024 at 5:55 AM, Jiri Olsa <olsajiri@gmail.com> wr=
ote:

>=20
>=20
> On Thu, Nov 28, 2024 at 01:23:44AM +0000, Ihor Solodrai wrote:
>=20
> SNIP
>=20
> > Test results for this patch series:
> >=20
> > 1: Validation of BTF encoding of functions; this may take some time: Ok
> > 2: Default BTF on a system without BTF: Ok
> > 3: Flexible arrays accounting: WARNING: still unsuported BTF_KIND_DECL_=
TAG(bpf_fastcall) for bpf_cast_to_kern_ctx already with attribute (bpf_kfun=
c), ignoring
> > WARNING: still unsuported BTF_KIND_DECL_TAG(bpf_fastcall) for bpf_rdonl=
y_cast already with attribute (bpf_kfunc), ignoring
> > pahole: type 'nft_pipapo_elem' not found
> > pahole: type 'ip6t_standard' not found
> > pahole: type 'ip6t_error' not found
> > pahole: type 'nft_rbtree_elem' not found
> > pahole: type 'nft_rule_dp_last' not found
> > pahole: type 'nft_bitmap_elem' not found
> > pahole: type 'fuse_direntplus' not found
> > pahole: type 'ipt_standard' not found
> > pahole: type 'ipt_error' not found
> > pahole: type 'tls_rec' not found
> > pahole: type 'nft_rhash_elem' not found
> > pahole: type 'nft_hash_elem' not found
> > Ok
> > 4: Pretty printing of files using DWARF type information: Ok
> > 5: Parallel reproducible DWARF Loading/Serial BTF encoding: Ok
>=20
>=20
> hi,
> when trying selftests with this change, I'm getting wrong .BTF
> on bpf selftest bpf_testmod.ko module
>=20
> $ bpftool btf dump file ./bpf_testmod.ko
> Error: failed to load BTF from ./bpf_testmod.ko: Invalid argument

Hi Jiri, thank you for testing.

I think the reason for this failure is that changes in the last patch
of the series [1] don't handle correctly a situation when the number
of CUs is lesser than the number of jobs. I was too focused on trying
to speed up vmlinux encoding.

I am going to try implementing a clear queueing interface between
dwarf_loader and pahole_stealer. Hopefully it will make it harder to
introduce bugs like this.

I've started working on the v2 of this series which I hope to submit
sometime next week.

[1] https://lore.kernel.org/dwarves/20241128012341.4081072-10-ihor.solodrai=
@pm.me/

>=20
> jirka
>=20
> > Alan Maguire (3):
> > btf_encoder: simplify function encoding
> > btf_encoder: store,use section-relative addresses in ELF function
> > representation
> > btf_encoder: separate elf function, saved function representations
> >=20
> > Ihor Solodrai (6):
> > dwarf_loader: introduce pre_load_module hook to conf_load
> > btf_encoder: introduce elf_functions struct type
> > btf_encoder: collect elf_functions in btf_encoder__pre_load_module
> > btf_encoder: switch to shared elf_functions table
> > btf_encoder: introduce btf_encoding_context
> > pahole: faster reproducible BTF encoding
> >=20
> > btf_encoder.c | 661 ++++++++++++++++++++++++++++++-------------------
> > btf_encoder.h | 6 +
> > dwarf_loader.c | 18 +-
> > dwarves.c | 47 ++--
> > dwarves.h | 16 +-
> > pahole.c | 265 +++++++++-----------
> > 6 files changed, 567 insertions(+), 446 deletions(-)
> >=20
> > --
> > 2.47.0

