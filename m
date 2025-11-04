Return-Path: <bpf+bounces-73529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFAC33651
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 83C6134D0FA
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC975346FDD;
	Tue,  4 Nov 2025 23:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kum2pEpw"
X-Original-To: bpf@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D8C32E741
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762299366; cv=none; b=USQOeeAEyoiUJPWfGmDnRB3yi0FHX2pHxrBBfULCEm71mLxN94j5wMa7MVhcNICptqE3ptLD4XWGOmRzfkMhHPYqKQecUdBdD9beg8DjjHkGR05QlhGre05RceOdnkxdRTdU0e19N8dsNGTL/4bWYrMjJEmH7k38+cFGfqsWVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762299366; c=relaxed/simple;
	bh=j46UobsjmgOp4qid0EdYnVcLSVN1rB3AXlEpsUVP69o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CuBy3vOYgowFP1+icjG6VLtgXELKssSzzZ/Yjb5DHQtuHidWdT7cQuCZdCUU+JBq25fPCDI0WE6msfnLOMBpNCNP3IpgUMBf4yd4yFFM/nAkhNJ4DhD3z+CsE65VZ5H2Oxr/vXDHNWN27ETxUoAqnOKu7VPpCIEYCtC19BrKdL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kum2pEpw; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762299350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SdxXfOrHeutJFYGlsdMunkP+GNQ5NgQ13gCRunrLukY=;
	b=kum2pEpwKiw+1t68UAuBfEW7zOYRpXLaAo0qNLAmdedx+YaxidKpZNAmNjSDDU+W8VhwSP
	FtQpcFQh8g/LtWnT+DFaTkL4gso3FByDE1kDHqXK9w5Fc/OAm5LzDH4Vw4tmMDNSlBRYEW
	tIm9UPaThDNX50bmJFRLviOT275m3BU=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: dwarves@vger.kernel.org,
	alan.maguire@oracle.com,
	acme@kernel.org,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	andrii@kernel.org,
	ast@kernel.org,
	kernel-team@meta.com
Subject: [PATCH dwarves v2 0/2] btf_encoder: refactor emission of BTF funcs
Date: Tue,  4 Nov 2025 15:35:30 -0800
Message-ID: <20251104233532.196287-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This series refactors a few functions that handle how BTF functions
are emitted. The first patch splits btf_encoder__add_func_proto() into
two functions by input. The second patch separates BPF kfunc handling
from generic function handling.

v1: https://lore.kernel.org/dwarves/20251029190249.3323752-2-ihor.solodrai@linux.dev/

Ihor Solodrai (2):
  btf_encoder: refactor btf_encoder__add_func_proto
  btf_encoder: factor out btf_encoder__add_bpf_kfunc()

 btf_encoder.c | 171 +++++++++++++++++++++++++++++---------------------
 1 file changed, 101 insertions(+), 70 deletions(-)

-- 
2.51.1


