Return-Path: <bpf+bounces-55480-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E836A814D5
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 20:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C86017B2823
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 18:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F1B23E35C;
	Tue,  8 Apr 2025 18:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MgFgflu6"
X-Original-To: bpf@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647CB20FA83
	for <bpf@vger.kernel.org>; Tue,  8 Apr 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744137677; cv=none; b=JeCtfj0aWPZGjkkJg64cTxiaZjsUWu9XADoOSiLCHdJe7JkcgYHgSVueBltQ3rxIOSNuWs2A/VfZAzhwSYdmrmQgNVnpz0ivdgmlUUzpP4w96Cy6Evq4OTY8k+xCDWsLfD7Iccl3mtSPMK9uVrOmxZeearrmysqbqyKG5N6hupM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744137677; c=relaxed/simple;
	bh=bZvzt96Zp4RjiGtXBqIhCZqsKKtFoqIdU0+4Utszp3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMtvNN0aMMU4Dvp4gOX9E2xQ3z/lYEmutfhSS00wqHOpZrcxhFRGQ0IOjt14zEzx1L0rg3WpIGNXWaDJZ5FEB/rtOzS+jht4ZrXX1zK8rWz0xF9fw7g17NIlUFXSlBM3t8pJ4rsIukzKYQYndFQYzeSf8KqZgECzBc2J6oxcwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MgFgflu6; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744137672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yuFlAKi86HFuahtreKRLJDL3TXgxNcQBKy3nJVD0LNU=;
	b=MgFgflu6lER0I6M56dPzdq4vKEf4V2lugmBxBG+X4SMezmXC7eN+007Onkqin+fOZENs0e
	34ebrZG7TgAXHuHBc6oMKC5wapZTDrQZX0U2rXtiQ97qLJ12GYQn24Pol50UU41SUW6JbK
	+0RQqRkR2/r71KgSsXaTmuaoXl+164k=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH] libbpf: check for empty BTF data section in btf_parse_elf
Date: Tue,  8 Apr 2025 11:41:04 -0700
Message-ID: <20250408184104.3962949-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A valid ELF file may contain a SHT_NOBITS .BTF section. This case is
not handled correctly in btf_parse_elf, which leads to a segfault.

Add a null check for a buffer returned by elf_getdata() before
proceeding with its processing.

Bug report: https://github.com/libbpf/libbpf/issues/894

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 38bc6b14b066..90599f0311bd 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1201,6 +1201,12 @@ static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
 		goto done;
 	}
 
+	if (!secs.btf_data->d_buf) {
+		pr_warn("BTF data is empty in %s\n", path);
+		err = -ENODATA;
+		goto done;
+	}
+
 	if (secs.btf_base_data) {
 		dist_base_btf = btf_new(secs.btf_base_data->d_buf, secs.btf_base_data->d_size,
 					NULL);
-- 
2.49.0


