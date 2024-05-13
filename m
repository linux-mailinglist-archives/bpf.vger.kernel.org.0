Return-Path: <bpf+bounces-29657-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047C18C46FE
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 20:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACD941F21D1E
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038D039FFE;
	Mon, 13 May 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="vDOpUjwA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+rC8Uyt"
X-Original-To: bpf@vger.kernel.org
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965951BF2A;
	Mon, 13 May 2024 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715625553; cv=none; b=G2EYS3ahSy5W/2+ACrXJz5YYMLAceHqNZ0ULkNrHfUJ6Sam07kfAv+5rekahKcAbuoVyaADowVIQ9PkP3qUYHC3xlDWed4AluM2wrTrgJWkU4deGFkaGLAStf0bpCk4mRvCOzdJ/6K3Xf8aZrbsEWbz5gFwfYTgED3MtpGsxtBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715625553; c=relaxed/simple;
	bh=m8R7nWxm71bMXjsYfnz7mU8geGrDX6SswEUf/Xk8bJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tIse9MHQUfJGSd9AK9CrA0bdDMV6l8kjO2MtKzp/0UZwFG97o+E1H765YOLIvGQl2WY8Fip0xaOR3YuO4A5M6pvGD6/C27kyn/Q38MixgIVLRGWaJsBuRZY85nKYU2W5kpJicsc/47kAs0OM8NAJCFms0GFiVVrySSCxALdzbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=vDOpUjwA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h+rC8Uyt; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 256A61800153;
	Mon, 13 May 2024 14:39:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 May 2024 14:39:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1715625549; x=1715711949; bh=O8Ls5VMkKDiXpfxNPLZEw
	kjr2NHHS8FZM/mcfdqCmuk=; b=vDOpUjwAllkpPSKbfTQUQcAYV6TwWyNhBT1PT
	JRsmraP9ewCklKYVc7pDb4Cps0pCjw435H0PtunRQ6C/nf1a+SDA0HkVRMDQKlCk
	D6FePa5kzZZ+o3BKvxIRY8E20vghNuXsc6DXhzYi/9Lpc9IkmtV9GeEmGNqpgpqZ
	0G0DkwKoHlQ2U+TW6LzfxhhEhDFW2bIEtAXeCLLW9q/LqmRfgGUOvPTK3AyfqvWS
	uj5cJUPDHQsUAn+MYFdipn68rG9AhUm4C8qY+zKYidPj+8jvfiSRVPsODotAwkWy
	WqDjgSSb3ysPBUpZE28xH7Xj+EEczGiw473vJW0hCV56OqYYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715625549; x=1715711949; bh=O8Ls5VMkKDiXpfxNPLZEwkjr2NHH
	S8FZM/mcfdqCmuk=; b=h+rC8UytYoJ3vCyijsSey5eYa5LBlbPSIJPTWu9ZEDXm
	f9wQf7H7c4iZ6MMAmjoonhin5Qlb+HTB+7yA9CXDUpQQ3Dj+st5/ack6QzhGCW9o
	V283bzyvlestF4QpF6QZzYmC4AUgWD+AliznidLBST8tPr/a2sgO0lV5Bdw+21Nn
	BGETNQuGRfUWd5WuJy5u3l2xvZgR2XV10DOaCsQch4PoOweROI//ldT4reOHmDmw
	jilKSPD1SbUSFUzA7naRwQxDLr0nvm9p0GP6mEXhLLq4w9ehHsWqpv2lGHxz5GXV
	pNfmvYHiFzMWgOxMl0k690OdpbKwNpRdVGqUdZ2baA==
X-ME-Sender: <xms:TV5CZl4oDUszujwYT57kIIfybAgPttrCd05d5yWFrMb1mx9qYQBIuA>
    <xme:TV5CZi7AfMnIGrL849aRz1Zf9MLyMb4fvV9XZmAR0XgQddoZyTRNjrOTbf6DdbXol
    6PvaeAOhYkRl8Ti3w>
X-ME-Received: <xmr:TV5CZsd_j-R7qSzKQIlPcBdeBu2KCPtQBLt8_Ujv9VedNiVqV4J4NHUkOQ8u50hkDbGTYrlqTlWg0H7l8VaOt4TP3ROge6UYUnDry84P6REmzA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdejtddmnecujfgurhephf
    fvvefufffkofgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpedvgefgtefgleehhfeufe
    ekuddvgfeuvdfhgeeljeduudfffffgteeuudeiieekjeenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:TV5CZuKdPeAlh2H3c6wU_bDCwotxcxa7g4F1_W6178KVTQh9_fg73g>
    <xmx:TV5CZpIJsZroPvq7W0o232DwIxWiSmya_Cj4q_gVN1mnVr70HPIQ6Q>
    <xmx:TV5CZnzbeNs01h-SGY-smsDY20wQxc787BTxE5o2fgISjzW0fvs8rg>
    <xmx:TV5CZlJtlFgNm_ezlawz57roxaawvzS-F9y_uK6e158_Or98ZQ9lYA>
    <xmx:TV5CZmAklU-2e1R3L9xv7RjSVy4bh7sPG7dGye-9rngtKYKGEIlO-IQq>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 14:39:08 -0400 (EDT)
From: Daniel Xu <dxu@dxuuu.xyz>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	andrii@kernel.org,
	olsajiri@gmail.com,
	quentin@isovalent.com,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: kernel-team@meta.com
Subject: [PATCH bpf-next v3 0/2] bpf: bpftool: Support dumping kfunc prototypes from BTF
Date: Mon, 13 May 2024 12:38:57 -0600
Message-ID: <cover.1715625447.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset enables both detecting as well as dumping compilable
prototypes for kfuncs.

Users will be able to look at BTF inside vmlinux (or modules) and check
if the kfunc they want is available.

For developer convenience, we also support dumping kfunc prototypes from
bpftool.

=== Changelog ===
From v2:
* Update Makefile.btf with pahole flag
* More error checking
* Output formatting changes
* Drop already-merged commit

From v1:
* Add __weak annotation
* Use btf_dump for kfunc prototypes
* Update kernel bpf_rdonly_cast() signature

Daniel Xu (2):
  kbuild: bpf: Tell pahole to DECL_TAG kfuncs
  bpftool: Support dumping kfunc prototypes from BTF

 scripts/Makefile.btf    |  2 +-
 tools/bpf/bpftool/btf.c | 54 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 1 deletion(-)

-- 
2.44.0


