Return-Path: <bpf+bounces-55688-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2AEBA84C18
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6621BA165A
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 18:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65428CF59;
	Thu, 10 Apr 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jg5w0OB7"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358B72857CB
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744309712; cv=none; b=Y4dja7p7MqpBT8WFaJ5kZVPHAFl3FfnPoyZj8pxZdh7fnAxlBkUjqeWn2I9Go+4Rz8ZwwFIOKgkScgvVZlkOsisdhXErBW2JtNszSPNlPWctFjicgQvWGpJBx5hGRP4USY4NMH4uJTYWrV4+MAXs/OirW2Ay2e8KtSJ84LwtgS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744309712; c=relaxed/simple;
	bh=/BnKlXJvhUz9buot2udoeMw7GHCWQXxORqzLsDjY7jI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ED5Zi7kchkuZOoL3viKquq4kJqZM35KvZXhDFW/HJbDiklP6iZ6M+m62IhvowYtOTCNK80Rr0SkyPK+P5GV5Zexoy7mAaDCT66CPXD2AkR/ZkMjIoyB4OR0aGOSeikeKMuOpgUG9fpcMXZd4f0H2SSh8Ryev+ZB1SswMAq6RiMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jg5w0OB7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744309708;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b/5+Pkee7y01U7yc3FWGKpZG6sTW7FAG9nzjBKB6sAU=;
	b=jg5w0OB781EIudlEm4l75NnctwmAnNOGtonh7K+r75zK0MtLzCC0t49b5wp6C6gkse8oJP
	GVvCnW8i0fcPpKWe8ac6YvrvJ2t2v04dH0HamRdWBNrWFUmQa6ek5HoACNdDxTGo91abMK
	amcMRlwSkCaTED7r/MT1JpWxvHOm1xM=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com
Cc: bpf@vger.kernel.org,
	mykolal@fb.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2] libbpf: verify section type in btf_find_elf_sections
Date: Thu, 10 Apr 2025 11:28:23 -0700
Message-ID: <20250410182823.1591681-1-ihor.solodrai@linux.dev>
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

Before attempting to load BTF section data, check that the section
type is SHT_PROGBITS, which is the expected type for BTF data.  Fail
with an error if the type is different.

Bug report: https://github.com/libbpf/libbpf/issues/894
v1: https://lore.kernel.org/bpf/20250408184104.3962949-1-ihor.solodrai@linux.dev/

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/btf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 38bc6b14b066..24fc71ce5631 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1148,6 +1148,12 @@ static int btf_find_elf_sections(Elf *elf, const char *path, struct btf_elf_secs
 		else
 			continue;
 
+		if (sh.sh_type != SHT_PROGBITS) {
+			pr_warn("unexpected section type (%d) of section(%d, %s) from %s\n",
+				sh.sh_type, idx, name, path);
+			goto err;
+		}
+
 		data = elf_getdata(scn, 0);
 		if (!data) {
 			pr_warn("failed to get section(%d, %s) data from %s\n",
-- 
2.49.0


