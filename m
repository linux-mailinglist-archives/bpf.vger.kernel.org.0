Return-Path: <bpf+bounces-50160-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C30EA234EA
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 21:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716C83A6AE6
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 20:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49DFE1F12FA;
	Thu, 30 Jan 2025 20:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rG7vOfuG"
X-Original-To: bpf@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105C41F12F6
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738267972; cv=none; b=FdxHZvDfOT6R1MV8fbTAOVyIExklKa8+NY30kHSGWuxiLjxK/CamZjLoF+Kt4Rv7J/k5IaDcNdc/1yeImSZrOdX/9vOCkGrN8Z6uQ38C5/2hmLmElAvsUMdMoRvBixNZ73QTWz5RQyWyQlh6t0xc+OPBv5d9AkecArUwdN3m2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738267972; c=relaxed/simple;
	bh=zitOUnCdQzASiUQhB/96oir+cdsIY2AQdpQQU3TLmDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aPYfG+Wmmtayj5Bopc22107eQvo3lU1X+SirgAmeGubwixTmTrP6jgFdc2Y4+wPjyCNq7pG5wprquTJ16WMQeUUcLj9jNeVjVakX9olRWBV3UeB5vGsyKdhlgSJP100VXP6UoLh7C0iIflBae3qV162ciod6fM+7BJjA0myOVdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rG7vOfuG; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738267969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e//Gg4AaBC5Cbb/wzOecC107hJRLRv6acyEBSkgvqms=;
	b=rG7vOfuGp55RTysLjHy1+myUz56DFTbkAlJYUQJ38YaidrmzvjXcqvjozvBEpb7NC4MFT9
	woH//+oKGGge1mv5f0iV1zorWGskvTq+slq/aKNIjlBx5IudrFckPhk4hpixGM89w5DZUM
	XU3tjfhFeb1hMIpCLfztEDXYxmE6+i8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v3 3/6] libbpf: check the kflag of type tags in btf_dump
Date: Thu, 30 Jan 2025 12:12:36 -0800
Message-ID: <20250130201239.1429648-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
References: <20250130201239.1429648-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

If the kflag is set for a BTF type tag, then the tag represents an
arbitrary __attribute__. Change btf_dump accordingly.

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/btf_dump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index a3fc6908f6c9..460c3e57fadb 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -1494,7 +1494,10 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 		case BTF_KIND_TYPE_TAG:
 			btf_dump_emit_mods(d, decls);
 			name = btf_name_of(d, t->name_off);
-			btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
+			if (btf_kflag(t))
+				btf_dump_printf(d, " __attribute__((%s))", name);
+			else
+				btf_dump_printf(d, " __attribute__((btf_type_tag(\"%s\")))", name);
 			break;
 		case BTF_KIND_ARRAY: {
 			const struct btf_array *a = btf_array(t);
-- 
2.48.1


