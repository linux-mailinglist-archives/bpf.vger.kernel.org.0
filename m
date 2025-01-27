Return-Path: <bpf+bounces-49905-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9A0A201CA
	for <lists+bpf@lfdr.de>; Tue, 28 Jan 2025 00:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1133A4FE7
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39531DE2AE;
	Mon, 27 Jan 2025 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RstSVUsj"
X-Original-To: bpf@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C51DC9BE
	for <bpf@vger.kernel.org>; Mon, 27 Jan 2025 23:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021212; cv=none; b=gMjub6tmOueuhZG1iJSXJVBMXqMIVpr8+/Ld1Y4sMi+G4hQEqvr0FJKDhRtXLy3rRIBlBMb2OUYpLMXuYS0GDo30jXwGtMB5HPbyi/F54vyK8yOcCkvcf2KU4hexbcg48r2sF6SD4YTsRFKohZgOf4u8qDw8Gexd4nUB7ipanr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021212; c=relaxed/simple;
	bh=rpkbCdfTxmIRYmSExqf0cnLqvM7WIi/71M/ulYMWsHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S14dS2wwITNR8CEBehokggPbuvUPgORSYY9hQiSlge/fAf8Xzyu5IsiOk21bfy2uxJx4eiUxyFLsbnwpvxOAUTDX2M1hnj4Kfyk4chx38Y/VZUG2ljJi4IXu+A1KHTNzMT3OemMvVdLttDMajZG3LTA9knfX2BIbRuzJU2jZdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RstSVUsj; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738021207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhjpJoz+gldrb29KBrFyJBdFe7Iv8fDNIPNAHD3d22w=;
	b=RstSVUsjko400gqZFeoh4BOLpXU0gxKLj50QhzjzrNf3k3BnteIe1yVMITQmvfkLEKaSyb
	+wuuZQFPkkECnLSKwk8GDNMdJoXgALZgV190dplXZmKtNcG2rRlKT9TB1PK6Xgyo5M50aS
	Lc3/AQ319NHqoYbpuL7nj/xZsl7smD0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	mykolal@fb.com,
	jose.marchesi@oracle.com
Subject: [PATCH bpf-next v2 3/6] libbpf: check the kflag of type tags in btf_dump
Date: Mon, 27 Jan 2025 15:39:52 -0800
Message-ID: <20250127233955.2275804-4-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev>
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


