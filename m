Return-Path: <bpf+bounces-49902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A774AA201C7
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1CD23A4516
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8671DDA31;
	Mon, 27 Jan 2025 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OS8nhtf0"
X-Original-To: bpf@vger.kernel.org
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9195156F57
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021208; cv=none; b=fFbtpHs6oGx1MrVnkUXp8CaMA5iLFl9+nvxy9Ng1kxWPR4OER4bb61lQauOHi97eLmhUCyqMtpFg/KWNS8VrME2UAXo1Kwc2++lz6cNnfLt/YM+WdAW7x6ZCN1emdsP2sIh9OFDzLHg5f80Kn+/7VFtpRpd3sMrd71c27dbBxrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021208; c=relaxed/simple;
	bh=4bM4oG8Ght9YO4Vji8P1JrKmqRaUDr4SitB/OrjAORk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sPbo+gR8RGRVz76fFPYDfS1y8MrGPOIJfa4g6pn2FNJLHbsSQV+qa4f7kNrYXYFaKtkZTvvmze8+3RxvFo53RexkGfi4KawZVYxcb1gc9Tit4gaV7OWDeu3OxjiKgXSVDwf3pWc5dTaLRjt710p61hLUoj8tQrZdKodhJyX8dRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OS8nhtf0; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=4Fg22PJir/fCBUq9b22XB30XX3vpJzeh9niOp5GsaIU=;
	b=OS8nhtf0/WZiZBDfD3wzYDesLbef1HwoQ2fDpAY5Ct4IMxOYQbOJH7ZODAywUtoFiC8kEQ
	p8BZrrLjbpAuEu4AYafqwDHrA+5F1o97oGab/x+uZ4uGU5lXg0us5PzNIhuH6qy8wdds+S
	GxYPCjskmwLYEQ3cOieqnrdPB5i5icM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 0/6] BTF: arbitrary __attribute__ encoding
Date: Mon, 27 Jan 2025 15:39:49 -0800
Message-ID: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

v1->v2:
  - When checking for specific BTF tags in the verifier, make sure the
    tag's kflag is 0
  - Split docs and libbpf changes into separate patches
  - Various renames, as suggested by Andrii and Eduard

v1: https://lore.kernel.org/bpf/20250122025308.2717553-1-ihor.solodrai@pm.me

Ihor Solodrai (6):
  libbpf: introduce kflag for type_tags and decl_tags in BTF
  docs/bpf: document the semantics of BTF tags with kind_flag
  libbpf: check the kflag of type tags in btf_dump
  selftests/bpf: add a btf_dump test for type_tags
  bpf: allow kind_flag for BTF type and decl tags
  selftests/bpf: add a BTF verification test for kflagged type_tag

 Documentation/bpf/btf.rst                     |  25 ++-
 include/uapi/linux/btf.h                      |   3 +-
 kernel/bpf/btf.c                              |  26 ++--
 tools/include/uapi/linux/btf.h                |   3 +-
 tools/lib/bpf/btf.c                           |  86 +++++++---
 tools/lib/bpf/btf.h                           |   3 +
 tools/lib/bpf/btf_dump.c                      |   5 +-
 tools/lib/bpf/libbpf.map                      |   2 +
 tools/testing/selftests/bpf/prog_tests/btf.c  |  23 ++-
 .../selftests/bpf/prog_tests/btf_dump.c       | 147 +++++++++++++-----
 tools/testing/selftests/bpf/test_btf.h        |   6 +
 11 files changed, 244 insertions(+), 85 deletions(-)

-- 
2.48.1


