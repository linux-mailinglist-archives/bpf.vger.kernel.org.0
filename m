Return-Path: <bpf+bounces-5669-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A7C75DA84
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 08:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04684281F55
	for <lists+bpf@lfdr.de>; Sat, 22 Jul 2023 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F99F125C0;
	Sat, 22 Jul 2023 06:52:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8C11C84
	for <bpf@vger.kernel.org>; Sat, 22 Jul 2023 06:52:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020773A90;
	Fri, 21 Jul 2023 23:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=6e6Gsmt5fuWDEDUMlV5yIHXbLkqJTWyuTSXMAY5Ttmc=; b=CTvfmxTTyitXCXYOiU35nUEh7j
	ZAiznwnqEDF5+eGbY5nbS8U2zsC7MlEySEW+M4QqH/62uRz8yqN76cLtGtYhtYOCelbTWg/2IZe4n
	uyL4KkPVU+Z+aDNVP/gFKDLj2Ybngd9Q0vMWm3632smFnftEesASrZBrqWqHIlSZwNEI16BNCkf4O
	8T9jKed7BybKh/lh1Ie/Bm0f5u8IL67MxTjtMXHIjrHp669kx+rxujKx9tuVJn9QcYWgAxIxYou89
	M6sk4TIF3NA67UYpfQrX921Kq2s0MzDUcO0d94lArN2AngvjcLKmKLky+NXCdfVGtxxCzoquIv0SY
	kHh3OJcQ==;
Received: from [2601:1c2:980:9ec0::2764] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qN6Tl-00FzCi-12;
	Sat, 22 Jul 2023 06:52:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	Xin Liu <liuxin350@huawei.com>
Subject: [PATCH bpf] libbpf: fix typos in Makefile
Date: Fri, 21 Jul 2023 23:52:36 -0700
Message-ID: <20230722065236.17010-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Capitalize ABI (acronym) and fix spelling of "destination".

Fixes: 706819495921 ("libbpf: Improve usability of libbpf Makefile")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Xin Liu <liuxin350@huawei.com>
---
 tools/lib/bpf/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -293,11 +293,11 @@ help:
 	@echo '  HINT: use "V=1" to enable verbose build'
 	@echo '  all     - build libraries and pkgconfig'
 	@echo '  clean   - remove all generated files'
-	@echo '  check   - check abi and version info'
+	@echo '  check   - check ABI and version info'
 	@echo ''
 	@echo 'libbpf install targets:'
 	@echo '  HINT: use "prefix"(defaults to "/usr/local") or "DESTDIR" (defaults to "/")'
-	@echo '        to adjust target desitantion, e.g. "make prefix=/usr/local install"'
+	@echo '        to adjust target destination, e.g. "make prefix=/usr/local install"'
 	@echo '  install          - build and install all headers, libraries and pkgconfig'
 	@echo '  install_headers  - install only headers to include/bpf'
 	@echo ''

