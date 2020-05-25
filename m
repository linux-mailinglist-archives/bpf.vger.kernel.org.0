Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A33A1E06D2
	for <lists+bpf@lfdr.de>; Mon, 25 May 2020 08:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729690AbgEYGS6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 May 2020 02:18:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48051 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729653AbgEYGS5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 25 May 2020 02:18:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590387536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HP26hv9iAyi1MUU5g6+eJngX9ihCxZ4VLxR9IAwqTd0=;
        b=RBfYVFefvZAAqwSRliVoppRs5EESavOtyih+Tm3LhVIA/b2fZOzdO8bl05ZBbcnsUVVfzV
        hoyQMmwjx3ltCpLlUnHmJqfdj7I1ortmstM0ePtTMpOfs2dO7/aSBY/yD6lMVW8w5y+WFI
        7cG7+kRss7BENM0IUBBj54ZiPtPkGXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-l8eW_VfBNUitsQRbOkaP7A-1; Mon, 25 May 2020 02:18:51 -0400
X-MC-Unique: l8eW_VfBNUitsQRbOkaP7A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DEF68014D7;
        Mon, 25 May 2020 06:18:50 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-111.ams2.redhat.com [10.36.112.111])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A019510013D5;
        Mon, 25 May 2020 06:18:48 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH RESEND] libbpf: use .so dynamic symbols for abi check
Date:   Mon, 25 May 2020 09:18:46 +0300
Message-Id: <20200525061846.16524-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since dynamic symbols are used for dynamic linking it makes sense to
use them (readelf --dyn-syms) for abi check.

Found with some configuration on powerpc where linker puts
local *.plt_call.* symbols into .so.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index aee7f1a83c77..aea585cbe2f4 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -151,7 +151,7 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
 CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
@@ -218,7 +218,7 @@ check_abi: $(OUTPUT)libbpf.so
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf -s --wide $(OUTPUT)libbpf.so |			 \
+		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
 		    sort -u > $(OUTPUT)libbpf_versioned_syms.tmp; 	 \
 		diff -u $(OUTPUT)libbpf_global_syms.tmp			 \
-- 
2.26.2

