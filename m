Return-Path: <bpf+bounces-12141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB617C8720
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F7C3B20AB2
	for <lists+bpf@lfdr.de>; Fri, 13 Oct 2023 13:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD0915EB5;
	Fri, 13 Oct 2023 13:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="mmlqf5aa"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EC517980
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 13:45:31 +0000 (UTC)
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5B095
	for <bpf@vger.kernel.org>; Fri, 13 Oct 2023 06:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1697204724;
	bh=9yGwfZ0bSaj3gcY+vZ+R+FcCTDnHPx5WRf8m9aJ5bfI=;
	h=From:To:Cc:Subject:Date;
	b=mmlqf5aacSNUnhyslTSexUdWpxzmWi0YyoEtOLx25QOY5FJpj/Tt6hgleC4xzGqg+
	 OWfqOUr77Ta6MsJ17VuCrsf3QAi0L6fIKwt8Sii/sgKopjyxuCK/NvFKyaxAi6lcVx
	 6Mm/C5lHGuXiMlTOeIJULes6hDNH5oytvv+xXRUM=
Received: from lb-dt.. ([117.32.216.61])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 98D3A64F; Fri, 13 Oct 2023 21:38:13 +0800
X-QQ-mid: xmsmtpt1697204293t6sdx6oqu
Message-ID: <tencent_C59755D2B2D8A78676CFECBC4DA9031C1908@qq.com>
X-QQ-XMAILINFO: NjoVKmBV+G+ji2pBCRqhNflLjeN+jgbwKx7H/BliISMpkUUtrPg/xyOxP5kwRd
	 Y+zx7lSNr9ErA697vCPImorxOPKeM5R3NjRLahV6PpJAG8ijODM3BrXVhEixWMBQoDzmmZcOURiI
	 LeQViSRu/XyES3sM89rhWv8TVg9ySwvxu0IpDxr2CrSwD2lapC5mR6yMsbFNXbM3hnJKaxpfW0T4
	 GF8Osr0Q916ZAHM6hXV1//iRzvBg0sOO8OJ/x9M07WezxekJPgoIolOmR246PgAnolhwxlycIIXj
	 wL4O52Qv/fIeTrp6KT7u6v3UGwiwlbPYwJi8yMCDJTCMpBratNOBzEFgCRk8Rdu7P5qhxwUblIXS
	 eT76BD19IPhMwgAFUWWZ/a0ysrNb7C6ONreUizOZU4ooYdBH+/Uohb7hQ3W5e2dd14tCDOu8GI3i
	 QVLt2vv+2nLN8A2vBJ/PqjPONHYfXYrQd6n76he7do3Tj/DpFuJqMZnDJaNQvlvCoTXa3n55F3CD
	 up3vO9MxMnHwCAJ0L59eJNXV1z8WC+JXOWN4RQCeKG7DnHp3+HqAfqoH66hPqv9Nr8sIZnrzJfB7
	 dWdKFq62JUYW7pkUfq4xYViMKyc6QB+JxlzYGOdMiYzl3osBOvkNVawvJOzmexZe1xeBogFNHqVy
	 XRoOsAffb/5Fg0/6FFqWdH4GFZ7KLnieTTkSEHk78MweN0Eaz41QE9eqsUOOyQeObNwDXPLv8RXW
	 nt5gFK53q4dwjV0yownPp8NNps0BvoIZp6J4n0jFsVY/dGU4MLicU9pCTzMVtduhs8EarDp7lIuf
	 3NkNRcih/z7p8BWVU+pHlUKkoqIj0zwePGVOomNUNRhGqwqAfv2akf/i+W6MaVhr/X4ij4LjUpjt
	 TIM0SZiTw7672AkJgMjg6G9TFYUBiY3lGskKKrwSrN62xrq5sYwCQzPYDnN6bKwyYrptUwIVI1Xb
	 o5Zy250enAHsDDrRwQiBMEaX+yI0gw1kOZBZSsEag=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: LiuLingze <luiyanbing@foxmail.com>
To: bpf@vger.kernel.org
Cc: LiuLingze <luiyanbing@foxmail.com>
Subject: [PATCH] Fix 'libbpf: failed to find BTF info for global/extern symbol' since uninitialized global variables
Date: Fri, 13 Oct 2023 13:38:10 +0000
X-OQ-MSGID: <20231013133810.147874-1-luiyanbing@foxmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

---
 examples/c/usdt.bpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/c/usdt.bpf.c b/examples/c/usdt.bpf.c
index 49ba506..2612ec1 100644
--- a/examples/c/usdt.bpf.c
+++ b/examples/c/usdt.bpf.c
@@ -5,7 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/usdt.bpf.h>
 
-pid_t my_pid;
+pid_t my_pid = 0;
 
 SEC("usdt/libc.so.6:libc:setjmp")
 int BPF_USDT(usdt_auto_attach, void *arg1, int arg2, void *arg3)
-- 
2.37.2


