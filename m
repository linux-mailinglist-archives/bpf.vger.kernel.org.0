Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B97B11618A6
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2020 18:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728952AbgBQRRU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Feb 2020 12:17:20 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbgBQRRU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Feb 2020 12:17:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=qeiA2zNy+KX8mcg4wbgxxGNyHshOOJC4Sg9lsLuNiz0=;
        b=HyTx+hSaO8pHSb8BNsOI4UzjzUWbrAcLnVQm1FeFu5Tjh1Yq4NlQ/CyJ/gyygebuPWAMpG
        wuqSxyCMrb1VcTM+r/uMYMqP+bxLX/F3fXQSf1J1CctyOB5/Mv3HF+8r5kTYFpHjwhdx7o
        rPWP7BTH5J8aIV/asZcxiQy9xclQAQo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-3-61q2ZZamMFKUEtXLmFUodg-1; Mon, 17 Feb 2020 12:17:17 -0500
X-MC-Unique: 61q2ZZamMFKUEtXLmFUodg-1
Received: by mail-lf1-f71.google.com with SMTP id f26so1727598lfh.15
        for <bpf@vger.kernel.org>; Mon, 17 Feb 2020 09:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeiA2zNy+KX8mcg4wbgxxGNyHshOOJC4Sg9lsLuNiz0=;
        b=RtffSKZ4i/LnXrmQ0DmcDkAP8X1QCRN3a6mSMeDGCsEz4VlL2gWUVZ38xotPWPae3k
         p3/Z1cNh8OpxHVjzv7H4Ks4V11OCcEgmGjAX/rfJ6/2VSS+KkCZrTl7tAfLyTPXNfuZP
         MbndHmOb1rasmQ0Uht5CCci5yTlDuIjbKDAiQHFcqaW/js6kH/ps1YmSvbeWq1ytEo9P
         Uy9D7qsWqT0SHZLSsj+rrJwn7Z1dA7v9FtM/iUc+Xu5g1zBy+eFyY38pS7uEDvC9kwcg
         okAav8WJz3uvp+WFypn9JOquYZbG0/C/yxd4zxMF/96le7fjaGVu4K6zn4x2gb61S7Vs
         W9LA==
X-Gm-Message-State: APjAAAWUt0z2zsgy0NeA6sqqApQs04CKsYUv9ld1mmBt++9RUg3PEaMY
        h+0zA3yM5yoEWxyi6srIIRP08iw3zD7yEPcT8S6LGIrrgmTMzm7Vy1R88z27gPFCrUOsxWBPM3P
        VDwb9bF8SZCw3
X-Received: by 2002:a2e:8702:: with SMTP id m2mr10741512lji.278.1581959835817;
        Mon, 17 Feb 2020 09:17:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyT/XRSylcKMU5hkKtXzin0V8eVj+3tuoEYwtYxLeF2KXw8Lvo06GvSDcZZ6TCVSTq5wcEmkA==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr10741501lji.278.1581959835561;
        Mon, 17 Feb 2020 09:17:15 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k12sm703708lfc.33.2020.02.17.09.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 09:17:14 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A9C3C180365; Mon, 17 Feb 2020 18:17:13 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH bpf] libbpf: Sanitise internal map names so they are not rejected by the kernel
Date:   Mon, 17 Feb 2020 18:17:01 +0100
Message-Id: <20200217171701.215215-1-toke@redhat.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel only accepts map names with alphanumeric characters, underscores
and periods in their name. However, the auto-generated internal map names
used by libbpf takes their prefix from the user-supplied BPF object name,
which has no such restriction. This can lead to "Invalid argument" errors
when trying to load a BPF program using global variables.

Fix this by sanitising the map names, replacing any non-allowed characters
with underscores.

Fixes: d859900c4c56 ("bpf, libbpf: support global data/bss/rodata sections")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 514b1a524abb..7469c7dcc15e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -24,6 +24,7 @@
 #include <endian.h>
 #include <fcntl.h>
 #include <errno.h>
+#include <ctype.h>
 #include <asm/unistd.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -1283,7 +1284,7 @@ static size_t bpf_map_mmap_sz(const struct bpf_map *map)
 static char *internal_map_name(struct bpf_object *obj,
 			       enum libbpf_map_type type)
 {
-	char map_name[BPF_OBJ_NAME_LEN];
+	char map_name[BPF_OBJ_NAME_LEN], *p;
 	const char *sfx = libbpf_type_to_btf_name[type];
 	int sfx_len = max((size_t)7, strlen(sfx));
 	int pfx_len = min((size_t)BPF_OBJ_NAME_LEN - sfx_len - 1,
@@ -1292,6 +1293,11 @@ static char *internal_map_name(struct bpf_object *obj,
 	snprintf(map_name, sizeof(map_name), "%.*s%.*s", pfx_len, obj->name,
 		 sfx_len, libbpf_type_to_btf_name[type]);
 
+	/* sanitise map name to characters allowed by kernel */
+	for (p = map_name; *p && p < map_name + sizeof(map_name); p++)
+		if (!isalnum(*p) && *p != '_' && *p != '.')
+			*p = '_';
+
 	return strdup(map_name);
 }
 
-- 
2.25.0

