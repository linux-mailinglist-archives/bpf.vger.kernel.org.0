Return-Path: <bpf+bounces-37742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B40695A31B
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3BA1F22D6D
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C581898E1;
	Wed, 21 Aug 2024 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjzcmrmw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9769E14884F
	for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 16:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258800; cv=none; b=LuBxnq092LymetIPMtyDsIq919XWCrO3wXco5McdNTlbdxpxwI+DYUrrDKdvPhQUBNIIOChZ4rXnbOrwWgBc15EFucvVF76WE/6P3VvQisUxpsLX7M/NTW09FM0tZC0xpRY2AnNGQYUEJlRCjlLWZRQ4ox1uQnqm+Cu8F/N++oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258800; c=relaxed/simple;
	bh=q34/UIArUifRM6XQFF2THU4J85S0yPYL4xoHFfTtDDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h8LfKRRh8MLOyRVGQlkUdJxN5qyOQCg6QALpHks3yTDynvK5YZC8A6S596by+qxI97DZyXQbBVaI71a8gs+TQLvBmJK4LkZBasx14vFN4+rxckwZTTLNPkBtyVX6TJvMK/wLCNT6tZgV/Z317t6tLLQLLb74Pi8OD9LfJPnuQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjzcmrmw; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2020ac89cabso42587415ad.1
        for <bpf@vger.kernel.org>; Wed, 21 Aug 2024 09:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724258798; x=1724863598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mpZPgzt0YrwjJWhxWGKJvXeeg7+TiDBON9hImZ0JreU=;
        b=mjzcmrmwpeBuh1+aRL5ZjHx7ESyfvyufnE5D2f3sI+FH6aqbXXpRoxlvsNgogaCpVi
         0XUAmp235ZOZOBm9HzQXKNAs3wpauYB7LeaMb4Joans/pTeEr1AhkEY4k6qq8s2OprMl
         em7+lX6mBIWJqCFuTahJ5yODEgwAtHRrzyJv62+1wRJx7vEBwYVHR/PQSuOOpiYxvivt
         zuDHoqFFOHk8Jw9B+8qskLVBj+6WEj9JgM4j4gtmO0agZeeJVM8rha5tqnxqJc1WUcQ2
         mlX+PdeneaiJ5Hg781kkSFqIx5cOj7PjUgtjHJg3vjSfd4qxAMUtXk+zQyW9OwQnM5vV
         x6JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258798; x=1724863598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mpZPgzt0YrwjJWhxWGKJvXeeg7+TiDBON9hImZ0JreU=;
        b=GQcBwMG6G175IhcGw/rUE8647oM75hNlStZTJJ3y3SPt8rEteWiw8T6n8gzcdr8uTV
         p4GFDgpH3peND4+Zji8rWbVVBe8OdCodC1SOhtam51P2cr7SKjN1XztylPx9PXBbr7bT
         EckjuIF8cciG9Vns78oUhG+9I/ID9pNAT63M8/277KEycfpJJTgXsTDcBiHkCSE1QADw
         6DIpLcEAvC/KyY03K67xd1yXqgXDbZ8Nf7TB2BqyP+yNlMmAq5Yv72bNE0VM+NgsD2lz
         /NHHOtLZRWzq/tp4TIt8R0Pynw2NutzMfgVE3S364yXqHIe+K8SqLF5JlyNxJr7DaXvB
         slEA==
X-Gm-Message-State: AOJu0YyxtE+1e0S2kz7DT7pMBLfjrr21hKCMSw0tg/r6jkJeXrG2SK2Z
	tzkrp1uxhe8j9yI25T77R+G2PnBuEZm3AZMH4Ufi3YkgqbewUb8KejTUAjHk
X-Google-Smtp-Source: AGHT+IH4TVENdWbR6onlMpq2Z7dO6wNFcTlrXyVHhT9Qf1rrNo+mMu9pWIaheI74gZH60SDdSewm7w==
X-Received: by 2002:a17:902:e889:b0:201:fd52:d4e7 with SMTP id d9443c01a7336-20367d3f868mr34888205ad.2.1724258798027;
        Wed, 21 Aug 2024 09:46:38 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f030350csm95650055ad.22.2024.08.21.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:46:37 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Liu RuiTong <cnitlrt@gmail.com>
Subject: [PATCH bpf-next] bpf: bpf_core_calc_relo_insn() should verify relocation type id
Date: Wed, 21 Aug 2024 09:46:20 -0700
Message-ID: <20240821164620.1056362-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of malformed relocation record of kind BPF_CORE_TYPE_ID_LOCAL
referencing a non-existing BTF type, function bpf_core_calc_relo_insn
would cause a null pointer deference.

Fix this by adding a proper check, as malformed relocation records
could be passed from user space.

Simplest reproducer is a program:

    r0 = 0
    exit

With a single relocation record:

    .insn_off = 0,          /* patch first instruction */
    .type_id = 100500,      /* this type id does not exist */
    .access_str_off = 6,    /* offset of string "0" */
    .kind = BPF_CORE_TYPE_ID_LOCAL,

See the link for original reproducer.

Fixes: 74753e1462e7 ("libbpf: Replace btf__type_by_id() with btf_type_by_id().")
Reported-by: Liu RuiTong <cnitlrt@gmail.com>
Closes: https://lore.kernel.org/bpf/CAK55_s6do7C+DVwbwY_7nKfUz0YLDoiA1v6X3Y9+p0sWzipFSA@mail.gmail.com/
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/relo_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 63a4d5ad12d1..a04724831ebc 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -1297,6 +1297,11 @@ int bpf_core_calc_relo_insn(const char *prog_name,
 
 	local_id = relo->type_id;
 	local_type = btf_type_by_id(local_btf, local_id);
+	if (!local_type) {
+		pr_warn("prog '%s': relo #%d: bad type id %u\n",
+			prog_name, relo_idx, local_id);
+		return -EINVAL;
+	}
 	local_name = btf__name_by_offset(local_btf, local_type->name_off);
 	if (!local_name)
 		return -EINVAL;
-- 
2.45.2


