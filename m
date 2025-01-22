Return-Path: <bpf+bounces-49432-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369AEA18A47
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 03:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9045C16B738
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2025 02:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578B114B092;
	Wed, 22 Jan 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="brSyH9dJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98164219FC
	for <bpf@vger.kernel.org>; Wed, 22 Jan 2025 02:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737514400; cv=none; b=OI7//mNyzHuLJ6YzrSIL26NV0eCT447r8RVq7vPQL/6e/LgqMu5nkzbpYTdv4/7dTIVOj8BtZhoGsD4cyVvf/WAjdWM0l96YY+Y/ouLlGp3TSHl98wra3wkN6sBuBWeLtgb/K0pZ5lph2U3RxzJY6rtG1wsAX+KDmLujBgwmhZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737514400; c=relaxed/simple;
	bh=ZLLndwjbCAcOc9TH7LnFN/dyUzObTylzR7VJq6zWEN8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Olv9fR+QdenFpyeHwGNmE0Qw32nTqUKnFMbas6ifaXShNVVXDhpIFfPiXgUiteslvQnGkbWvtImpzU5QbyXAdEmaZtme66Q2Ev1GE+m8FVBVaZq+Zqji0daDIfOy2epF8wvVpEGUHThATDCgig3iDXKBrYicwlPXUOvDjmTqK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=brSyH9dJ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1737514396; x=1737773596;
	bh=7T4ipMlrXnKvQ5xnqw1LZ2lQff6AxaqcLG8BEAznqjg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=brSyH9dJ5y2mkDUilOPhMvHoJRdJ7Pt+Sbqq6nA/bDcbqpywHXg9j3JQLcJG6xlUV
	 eX9/v9HcgWsq96nVfaSp1yWh70v1Gf3amVHKwQ3k/xZlH/EoCnWWYtYU83dh0OnZHN
	 /fSS1HeIYbpW4goiPimc2IQwvDuUcbK1Ztyca/W7Zz2TMv3b0j3htAk3yFBrHPW8pw
	 zz1GBM6XRGmQ9PQAX1sR7W0M4YoewHKaGteZHnLoKtiHCrvgdCWW5NTxAc070oovcV
	 8AFNeO4e9cffRCRYai7R2IEuHCmwsP6oFqhain8Y+863Pz+rSpSSYBmBdVRH0IrFJp
	 27IruIwxYwWZA==
Date: Wed, 22 Jan 2025 02:53:11 +0000
To: bpf@vger.kernel.org
From: Ihor Solodrai <ihor.solodrai@pm.me>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, jose.marchesi@oracle.com
Subject: [PATCH bpf-next 0/5] BTF: arbitrary __attribute__ encoding
Message-ID: <20250122025308.2717553-1-ihor.solodrai@pm.me>
Feedback-ID: 27520582:user:proton
X-Pm-Message-ID: 4cc41bc56e124dfacaad4b5198e218514f3d12a7
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patch series extends BPF Type Format (BTF) to support arbitrary
__attribute__ encoding.

Setting the kind_flag to 1 in BTF type tags and decl tags now changes
the meaning for the encoded tag, in particular with respect to
btf_dump in libbpf.

If the kflag is set, then the string encoded by the tag represents the
full attribute-list of an attribute specifier [1].

This feature will allow extending tools such as pahole and bpftool to
capture and use more granular type information, and make it easier to
manage compatibility between clang and gcc BPF compilers.

[1] https://gcc.gnu.org/onlinedocs/gcc-13.2.0/gcc/Attribute-Syntax.html

Ihor Solodrai (5):
  libbpf: introduce kflag for type_tags and decl_tags in BTF
  libbpf: check the kflag of type tags in btf_dump
  selftests/bpf: add a btf_dump test for type_tags
  bpf: allow kind_flag for BTF type and decl tags
  selftests/bpf: add a BTF verification test for kflagged type_tag

 Documentation/bpf/btf.rst                     |  27 +++-
 kernel/bpf/btf.c                              |   7 +-
 tools/include/uapi/linux/btf.h                |   3 +-
 tools/lib/bpf/btf.c                           |  87 +++++++---
 tools/lib/bpf/btf.h                           |   3 +
 tools/lib/bpf/btf_dump.c                      |   5 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 148 +++++++++++++-----
 tools/testing/selftests/bpf/test_btf.h        |   6 +
 10 files changed, 234 insertions(+), 77 deletions(-)

--=20
2.48.1



