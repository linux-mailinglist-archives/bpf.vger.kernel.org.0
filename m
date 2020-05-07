Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067DA1C92BB
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgEGO5F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:57:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56431 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726445AbgEGO5F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 May 2020 10:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588863424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rUH5aeb489Gm6b5nkGw17EeZl9qUx/s3MDaOOYrNNLQ=;
        b=OrLTCt/FadMmAnRF9S9wV/v38wp/X3xpmdo6j5P9zCSimUd7wFTC+2z/0Fyj2U43tzfo8t
        Y/LxIEAcVAnrBKu8S/eydAgq5AqcipqzHlHkkPcnpc79VL1a/U6Hi6Zl+4PKXSjk7xYwMU
        atyjFOxgYyLEl0cY9Nww7YmrRt8n/yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-g2cQqNYHPg-yUOekbLI2NA-1; Thu, 07 May 2020 10:57:01 -0400
X-MC-Unique: g2cQqNYHPg-yUOekbLI2NA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4430B801504;
        Thu,  7 May 2020 14:57:00 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-223.ams2.redhat.com [10.36.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0995A62952;
        Thu,  7 May 2020 14:56:58 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 2/2] libbpf: use .so dynamic symbols for abi check
Date:   Thu,  7 May 2020 17:56:52 +0300
Message-Id: <20200507145652.190823-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since dynamic symbols are used for dynamic linking it makes sense to
use them (readelf --dyn-syms) for abi check.

Found with some configuration on powerpc where linker puts
local *.plt_call.* symbols into .so.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index 908dac9eb562..0c7b06de5633 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -151,7 +151,7 @@ GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 			   sed 's/\[.*\]//' | \
 			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
 			   sort -u | wc -l)
-VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
+VERSIONED_SYM_COUNT = $(shell readelf --dyn-syms --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
 
 CMD_TARGETS = $(LIB_TARGET) $(PC_FILE)
@@ -218,7 +218,7 @@ check_abi: $(OUTPUT)libbpf.so
 		    sed 's/\[.*\]//' |					 \
 		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
-		readelf -s --wide $(OUTPUT)libbpf.so |			 \
+		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
 		    sort -u > $(OUTPUT)libbpf_versioned_syms.tmp; 	 \
 		diff -u $(OUTPUT)libbpf_global_syms.tmp			 \
-- 
2.26.2

