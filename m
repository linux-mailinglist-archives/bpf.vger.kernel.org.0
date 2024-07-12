Return-Path: <bpf+bounces-34671-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634A92FFF7
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 19:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1001F23124
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2805E176AD1;
	Fri, 12 Jul 2024 17:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="pfPtWqKY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F591401B
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 17:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720806540; cv=none; b=mrcRvDBYDiOBijxYy8XHHUW72ma2QG9yw0vMgO5/jTNE234sHN8rMrtAgqVtiH1CGYAMx502tfyMTxxwn17njIZssaLFC0CRobi6JnOrgoWjrDYB9ZCmYZMBEG/adNCVuZHMSqwy8txTt0Uh9UyPJlqfmxaLmsKcjicez3fZr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720806540; c=relaxed/simple;
	bh=HzfQ5vcFAZCzI1rN0NPEIe7tJ8Hxm5Ur1shc4TZLekA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WOyhZ5PQ95wKDMRjusagNY6Jiv4Ro1S9XBKAa4GR5L4QzeoFF4z7MNe4o3j6GpI5dfguXWw+W4ShWLiz0k1/4Uh6YY2L/nbE1xHFejp4sfBKPln8xc7QSwO7jLyj15NErn/XjJLcLjtBKbY/ivxKfRiiZ+Jyx5yF1eNKoORdjnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=pfPtWqKY; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1720806537; x=1721065737;
	bh=o2FnAe34WSr08yoq6kdZ4Q+Cqs3hKPv3NQ+kuI7oQoY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pfPtWqKYr9MXmhJUmwN3qIwkxCukFeyw0++QLSHn632tfSl78xSf8eLeUEXiI3Mbk
	 xlPYgf0ayxZcwh9QPQmuU698YHr3lGn55p5XgQU6WPEtfcAu58KxVB7K5ZZZXTc3te
	 h6k4c5ZMMqonRBaOXw9aRVJh9M2c/ewB1cBMWhliYLiQCHzJ7U1+9LBdMYGoQQEY45
	 rTD/6wskfQM3DpzgedXIsIcInIEp3HNgKyUooRKh4uzxQJJ5FyVRECSS1iatfvMQ7C
	 +xkfEfDBASv0we0m2IFFMlgtJScFtIjQ48H/YgNA9lnhzrwiPijTQC3MpuM+Kr70Js
	 O6mtmNTwfpedA==
Date: Fri, 12 Jul 2024 17:48:52 +0000
To: Daniel Borkmann <daniel@iogearbox.net>
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org" <ast@kernel.org>, "andrii@kernel.org" <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "mykolal@fb.com" <mykolal@fb.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: use auto-dependencies for test objects
Message-ID: <R36QrBuK6nQziAeE9Xb-8295ISr8B1ofPVAdWaR3rygfaDiHUl2I5EmG2xoCrEskurmOmclGak3JXWwxso43KR9M1LHsdOIt48XS6xe3PVI=@pm.me>
In-Reply-To: <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
References: <gJIk-oNcUE6_fdrEXMp0YBBlGqfyKiO6fE8KfjPvOeM9sq1eCphOVjbBziDVRWqIZK1gZZzDhbeIEeX41WA34qTz82izpkgG-F6EFTfX4IY=@pm.me> <dcbf532f-bf17-bb8c-f798-987bce607e5d@iogearbox.net>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: c9e1b803ca98fd180bb5dd4b09461a88e34a4976
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 12th, 2024 at 8:26 AM, Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:

[...]

> Looks like BPF CI trips over this and various tests are failing :
>=20
> https://github.com/kernel-patches/bpf/actions/runs/9902529566/job/2735666=
4649
>=20
> [...]
> Tests exit status: 1
> Notice: Success: 538/3821, Skipped: 62, Failed: 5
> Error: #66 core_reloc
> Error: #66/4 core_reloc/flavors
> Error: #66/4 core_reloc/flavors
> run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
> Error: #66/5 core_reloc/flavors__err_wrong_name
> Error: #66/5 core_reloc/flavors__err_wrong_name
> run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
> Error: #66/6 core_reloc/nesting
> Error: #66/6 core_reloc/nesting
> run_core_reloc_tests:FAIL:btf_src_file unexpected error: -1 (errno 2)
> Error: #66/7 core_reloc/nesting___anon_embed
> Error: #66/8 core_reloc/nesting___struct_union_mixup
> Error: #66/9 core_reloc/nesting___extra_nesting
> [...]

I've made a mistake when I removed $(TRUNNER_BPF_OBJS) as a
prerequisite for $(TRUNNER_TEST_OBJS:.o=3D.d)

I assumed it is covered by:

  $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)

Apparently there are .bpf.o files for which skels are not generated,
yet they are used in tests.

Fixed in v3.



