Return-Path: <bpf+bounces-1803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D77722193
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 10:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3260281202
	for <lists+bpf@lfdr.de>; Mon,  5 Jun 2023 08:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6964134C1;
	Mon,  5 Jun 2023 08:58:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF7A804
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 08:58:03 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DB7A1
	for <bpf@vger.kernel.org>; Mon,  5 Jun 2023 01:58:00 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-392116b8f31so2333167b6e.2
        for <bpf@vger.kernel.org>; Mon, 05 Jun 2023 01:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685955479; x=1688547479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWMEC/WxcteDJyXzPJyHSynAbsyVbP1PCch1BrjS4SU=;
        b=Ngx2rNfpaJ44BRUXxOdpwjPH8XOnjHlYWiKOA5HZi6Zaz+aLPY4zphVBTsxKJZ2Nsj
         Wiu2D7qD/sah1NSyalIaI3Vu9hN2GN4m3NFoxkmr4tjWd+rImJ5Kw6cvqGeHgxXiQ/1T
         kUAsGAMYb6/6znbSkw36CSUUkhqkOl3O1YAB4iLS4otQUOYfTxQs0XyF8X38i8H2jGgr
         vevu+nMcUuzqwtJERrSm5W4OkSrZ7wu/pNLnaQheHNewXketQDTXj7KI67WU/4+Z0E00
         2QY1nSy58ZY+p9ek53N6/G+rJrOWThkohXWetfcYRFE42XMk+Zt/uIOOy3FUf6RTtmRQ
         z8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685955479; x=1688547479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWMEC/WxcteDJyXzPJyHSynAbsyVbP1PCch1BrjS4SU=;
        b=YNJ/w0AtSEm3KYnIzeyLFha2RCNbabZGfE6Uo7EwnsGBSN+/lEA2KncgInSUPd3X1w
         8r3Q0dxnO1FLbCRbuUHhyNpjaPk808QBjvNWAn/shyiu1iJcmPAWJVYSOeYhvr//Aa8U
         TNbsOOTiFk50bnNFRFtRvr5xFhWx2NRVmql/YkhIHJYR/QqWRYJJj1PC1KUUV5wO8lRg
         cM0x3+Wi8JgaTgrB7zZP6v1MKvOzTMn7XXKuKI/wuNsClYxl5jnPdurpS/a4K4KS11Uq
         oMWhLHWeU6pDWkzmkB9mmDGfCD1qYS57S7o6TU8FQlDbsXK2ql6UIFaRYw1W+g/zZemO
         7NXA==
X-Gm-Message-State: AC+VfDzS8OgiCkgNMs7WOx81DdQGKKnt04y8TgTjKbuA54NtEya4lJxw
	Hc05Hq8gyXXG8e6cWmkkC0aB3acKXl0hGw==
X-Google-Smtp-Source: ACHHUZ54ucWdNqDMmSAgks5wCxYROPcA2bG2stnGv6KInmu50RrcFd1cPdBEVnKLz7eZbjQ83wOztg==
X-Received: by 2002:a54:460b:0:b0:38e:eaf:cf16 with SMTP id p11-20020a54460b000000b0038e0eafcf16mr3841773oip.54.1685955479333;
        Mon, 05 Jun 2023 01:57:59 -0700 (PDT)
Received: from localhost.localdomain ([120.26.165.80])
        by smtp.gmail.com with ESMTPSA id mv7-20020a17090b198700b0024dfb8271a4sm5503901pjb.21.2023.06.05.01.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 01:57:59 -0700 (PDT)
From: Yang Bo <yyyeer.bo@gmail.com>
X-Google-Original-From: Yang Bo <yb203166@antfin.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Yang Bo <bo@hyper.sh>
Subject: [PATCH 2/2] mini test case.
Date: Mon,  5 Jun 2023 16:57:33 +0800
Message-Id: <20230605085733.1833-3-yb203166@antfin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605085733.1833-1-yb203166@antfin.com>
References: <20230605085733.1833-1-yb203166@antfin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Yang Bo <bo@hyper.sh>

update test example

Signed-off-by: Yang Bo <bo@hyper.sh>
---
 tools/lib/bpf/mini/Makefile |   2 +
 tools/lib/bpf/mini/main.c   | 130 ++++++++++++++++++++++++++++++++++++
 2 files changed, 132 insertions(+)
 create mode 100644 tools/lib/bpf/mini/Makefile
 create mode 100644 tools/lib/bpf/mini/main.c

diff --git a/tools/lib/bpf/mini/Makefile b/tools/lib/bpf/mini/Makefile
new file mode 100644
index 000000000000..c4f6901aebed
--- /dev/null
+++ b/tools/lib/bpf/mini/Makefile
@@ -0,0 +1,2 @@
+default:
+	gcc -o test main.c ../libbpf.a -lelf -lz
diff --git a/tools/lib/bpf/mini/main.c b/tools/lib/bpf/mini/main.c
new file mode 100644
index 000000000000..d245be004f20
--- /dev/null
+++ b/tools/lib/bpf/mini/main.c
@@ -0,0 +1,130 @@
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include <errno.h>
+#include <asm/byteorder.h>
+
+#include "../bpf.h"
+
+int main(int argc, char *argv[]) {
+	struct member *member;
+	char *key, *value = NULL, *end;
+	bool update = false;
+	int err = 0;
+	__u64 data = 0;
+	__u32 id;
+	int size;
+	__u64 raw[2] = {};
+	bool print = true;
+	
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+	printf("big endian\n");
+
+#else
+	printf("little endian\n");
+#endif
+	if (argc != 3 && argc != 4) {
+		printf("invalid number of params: %d\n", argc);
+		return -1;
+	}
+
+	id = strtol(argv[1], &end, 10);
+	if (errno) {
+		printf("cannot convert map id: %s\n", argv[1]);
+		return -1;
+	}
+
+	key = strdup(argv[2]);
+	if (argc == 4) {
+		update = true;
+		value = strdup(argv[3]);
+	}
+
+	member = bpf_global_query_key(id, key);
+	if (!member) {
+		printf("can not query key: %s\n", strerror(errno));
+		return -1;
+	}
+
+	// display data
+	switch (member->size) {
+		case 64:
+			data = *(__u64 *)member->data;
+			break;
+
+		case 32:
+			data = *(__u32 *)member->data;
+			break;
+
+		case 16:
+			data = *(__u16 *)member->data;
+			break;
+
+		case 8:
+			data = *(__u8 *)member->data;
+			break;
+
+		default:
+			printf("unsupported size: %d\n", member->size);
+			size = (member->size + 7) / 8;
+			memcpy(raw, member->data, size);
+			printf("as u64: %lx, %lx\n", raw[0], raw[1]);
+			print = false;
+	}
+
+	if (print) {
+		printf("data: %ld, type: %d, size: %d\n", data, member->type, member->size);
+	}
+
+	free(member->data);
+	free(member);
+
+	print = true;
+	if (update) {
+		err = bpf_global_update_key(id, key, value);
+		if (err) {
+			printf("cannot update key: %s\n", strerror(errno));
+			return -1;
+		}
+
+		member = bpf_global_query_key(id, key);
+		if (!member) {
+			printf("can not query key: %s\n", strerror(errno));
+			return -1;
+		}
+	
+		// display data
+		switch (member->size) {
+			case 64:
+				data = *(__u64 *)member->data;
+				break;
+	
+			case 32:
+				data = *(__u32 *)member->data;
+				break;
+	
+			case 16:
+				data = *(__u16 *)member->data;
+				break;
+	
+			case 8:
+				data = *(__u8 *)member->data;
+				break;
+	
+			default:
+				printf("unsupported size: %d\n", member->size);
+				size = (member->size + 7) / 8;
+				memcpy(&raw, member->data, size);
+				printf("as u64: %lx, %lx\n", raw[0], raw[1]);
+				print = false;
+		}
+
+		if (print) {
+			printf("updated data: %ld, type: %d, size: %d\n", data, member->type, member->size);
+		}
+
+		free(member->data);
+		free(member);
+	}
+	return 0;
+}
-- 
2.40.0


