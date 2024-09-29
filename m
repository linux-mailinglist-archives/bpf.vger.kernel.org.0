Return-Path: <bpf+bounces-40484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC4C9893E0
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 10:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8F0BB21543
	for <lists+bpf@lfdr.de>; Sun, 29 Sep 2024 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5845813E41D;
	Sun, 29 Sep 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBYeiBTN"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387D42AB1;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727599684; cv=none; b=LTo7yrDN4VIrypRf3hKlLesqB5dpdwMkR0hC+zq4xvywVt0pLRyANgRvU1Cp9iioHTEWnigtGTB2sCU1RCBZ1Cf3SBhqUKIEomS0LVmhuhg0Lhg7xLkVgazmCKE4d2QW/2J2rF+nbWRqu1mHF6R8W7ywPTDkPBrwjMCetDSXluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727599684; c=relaxed/simple;
	bh=SY9yDh1j+sDu6ngzI+1uKP6IbvRduNrKEKOhmrxEIuo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=F43CYY8NXnSn8aPt+EAptUgIHAoVMonxiGa0U4fs7U+JSCi8nTxj/7VoEqgOFuc3dQopNKBESBSsdW2ZgQ4RK87ECYLVCpM23I+lU2JIY5wKw+sOX8voYGBUCulkplfliBibIU9NctT02o8ljQdfIzei7yU3A78uIc39OZXNpAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBYeiBTN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6FB85C4CEC5;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727599684;
	bh=SY9yDh1j+sDu6ngzI+1uKP6IbvRduNrKEKOhmrxEIuo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DBYeiBTNhK1ZkbRSBBtbJnlGsEA2Jn7AYwYgVXBrJv94R+X0D1uDtsSQiIP+Q4QXW
	 pKiK3wRANrsjpBGe4GnJtlu+MGi3s8Lc9Sufkt3+JyWDJu6psf6jfqvJCHlnuKmS8/
	 9lChV5ZYt80FPKbXNGcE2+Bi6Yr6Jbi48mi2CkvtSM7CvTWXlakIgnheqxb4zVdCZv
	 /bUGJ70x25ciioyAVs7bnQC7NibZ7eYQoSLQMM76h1V1MwZ7lUJ0pDkCoNgv42slHL
	 PImHS4FpEy4dh27YbuQeJ+xOFMO8eSbOTXN1Smv5roefrsqngsyKH5k24QQg11u8mL
	 spXKo8FqHiBlg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A194CF6497;
	Sun, 29 Sep 2024 08:48:04 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Subject: [PATCH bpf-next 0/2] BPF static linker: fix failure when
 encountering duplicate extern functions
Date: Sun, 29 Sep 2024 16:47:59 +0800
Message-Id: <20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD8U+WYC/x2MQQqEMAwAvyI5G7BBUPcr4sHaVAOSLa2KIP7d6
 nFgZi5IHIUT/IoLIh+S5K8ZTFnAtIw6M4rLDFRRXXXU4SrWBo9uD8jnxlHR7zolbBvjazs6MkS
 Q6xDZy/mde3gLzToM9/0A4zpswnMAAAA=
X-Change-ID: 20240929-libbpf-dup-extern-funcs-871f4bad2122
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1327; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=SY9yDh1j+sDu6ngzI+1uKP6IbvRduNrKEKOhmrxEIuo=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGk/RZzE6515jy8JWXfJ48X8E1/sQ99mTtWRVfy2qM6mI
 bRmf2tbRwkLgxgXg6yYIsuWw3/UEvS7Ny3hnlMOM4eVCWQIAxenAEwk/RUjwwW7qQrR+YdPXJfc
 OPvv1LmXUw6a+LksZYguL5P8zlZeU8Lw4/iGaZkpcw4fmZihk5wqeVXSqiGAlefqU/tELru6ReI
 8AA==
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

Currently, if `bpftool gen object` tries to link two objects that
contains the same extern function prototype, libbpf will try to get
their (non-existent) size by calling bpf__resolve_size like extern
variables and fail with:

	libbpf: global 'whatever': failed to resolve size of underlying type: -22

This should not be the case, and this series adds conditions to update
size only when the BTF kind is not function.

Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Eric Long <i@hack3r.moe>
---
Eric Long (2):
      libbpf: do not resolve size on duplicate FUNCs
      selftests/bpf: make sure linking objects with duplicate extern functions doesn't fail

 tools/lib/bpf/linker.c                             | 24 +++++++++++++---------
 tools/testing/selftests/bpf/Makefile               |  3 ++-
 .../selftests/bpf/prog_tests/dup_extern_funcs.c    |  9 ++++++++
 .../selftests/bpf/progs/dup_extern_funcs1.c        | 20 ++++++++++++++++++
 .../selftests/bpf/progs/dup_extern_funcs2.c        | 18 ++++++++++++++++
 5 files changed, 63 insertions(+), 11 deletions(-)
---
base-commit: 93eeaab4563cc7fc0309bc1c4d301139762bbd60
change-id: 20240929-libbpf-dup-extern-funcs-871f4bad2122

Best regards,
-- 
Eric Long <i@hack3r.moe>



