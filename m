Return-Path: <bpf+bounces-60804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354FADC579
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CC79177FEA
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 08:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BC7290D9E;
	Tue, 17 Jun 2025 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ERlgbIpC"
X-Original-To: bpf@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD1428FAB7;
	Tue, 17 Jun 2025 08:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750150591; cv=none; b=X6Ie/0AJGH2usOlfZxGDUWEQiyk22rmu5XoRHxCWZS7zU121t+nSqVgDX3/hJ+9ipWH2WrtVRGxdX/46ZK6Ln5vCYu5vm0SFRsPd7L9URzcs37kpq4PTJW1xbHS4Z/yx56ntu8330ad7r0bswid0jlLsWecG/gkAt+VJVof0Cjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750150591; c=relaxed/simple;
	bh=He8BCNKdPuKH0D46/gvWlngycTOL/h+LPBWUoNA1WU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MFVAbAEk9yjLL7IXRLewt26hdHyU4z3Jblya1xNn8r+8brKreV+SaTp45N+di2atqJ/5VoIRmDHlivIe00grGNOwz+zjxZd2jan6PQ5nODHDZ2ojKZwrX4QUoxGQIkVUXUcuMQU5ZHr4fCLF5On6rkXHwWlhqx76i+eawxFfO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ERlgbIpC; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1Y
	12eBGHsfNjV1u69yyF5T3SGl2ObArOXEL31mmuTEw=; b=ERlgbIpCPtgbz3JPhk
	mWyU2Yn2z3k88lr1/EsHv6FMC0PuShMXM0NrtdbdhaELGNEgnOBRRPLYPdSG9XJa
	aW5DSQzLBVa5oM/3wfOOXods0IAXFzfWkFG+4fmRPQa7HEzJJPpjPvt2wV+iEf8w
	AVl4dJO3Qrga8OVgXR3HhOIFo=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wD3l+ChLVFo16MKIw--.4488S2;
	Tue, 17 Jun 2025 16:56:02 +0800 (CST)
From: chenyuan <chenyuan_fl@163.com>
To: ast@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chenyuan_fl@163.com,
	chenyuan <chenyuan@kylinos.cn>
Subject: [PATCH] libbpf: Fix null pointer dereference in btf_dump__free on allocation failure
Date: Tue, 17 Jun 2025 16:55:54 +0800
Message-Id: <20250617085554.51882-1-chenyuan_fl@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3l+ChLVFo16MKIw--.4488S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtryDGw4rKFyrAr1kCr1ftFb_yoWDAFb_GF
	48ZrsrJrW5Wayavw1jkFZavryfGFW5Ka10qrn5KrnxKayUG3WUJrZIva4IyrW3G395tFy7
	CasYkF93tr4UGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRtKsUJUUUUU==
X-CM-SenderInfo: xfkh05pxdqswro6rljoofrz/1tbiURJvvWhRLHQbEgAAs5

From: chenyuan <chenyuan@kylinos.cn>

When btf_dump__new() fails to allocate memory for the internal hashmap
(btf_dump->type_names), it returns an error code. However, the cleanup
function btf_dump__free() does not check if btf_dump->type_names is NULL
before attempting to free it. This leads to a null pointer dereference
when btf_dump__free() is called on a btf_dump object.

Fix: 351131b51c7a ("libbpf: add btf_dump API for BTF-to-C conversion")
Signed-off-by: chenyuan <chenyuan@kylinos.cn>
---
 tools/lib/bpf/btf_dump.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 7c2f1f13f958..80b7bec201f7 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -227,6 +227,9 @@ static void btf_dump_free_names(struct hashmap *map)
 	size_t bkt;
 	struct hashmap_entry *cur;
 
+	if (IS_ERR_OR_NULL(map))
+		return;
+
 	hashmap__for_each_entry(map, cur, bkt)
 		free((void *)cur->pkey);
 
-- 
2.25.1


