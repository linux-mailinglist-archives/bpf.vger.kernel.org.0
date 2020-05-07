Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0D1C92BC
	for <lists+bpf@lfdr.de>; Thu,  7 May 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEGO5J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 May 2020 10:57:09 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726445AbgEGO5J (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 7 May 2020 10:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588863427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TA2yiUCwSNNWkYk0v7NlGANpA5rE9ycMJRkmA+UfkI=;
        b=BUYdpJg4inN6NXBvesmvoxlMTrGfYKuA3CKBcxn5JtLpeglFYBDIFtXfhm01Uv/uKvBf1x
        KVzwFptEfB/b6OE/ASbego01BBh4mMgquBEpGZuKrrI0yuTUXH7b+1v+EktVP2jhrxxgCH
        Alp2LIwmEO3cPVGfu6WNrAEHfV22uP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-c3VQ9wbEPZehl--iMhk7Nw-1; Thu, 07 May 2020 10:56:59 -0400
X-MC-Unique: c3VQ9wbEPZehl--iMhk7Nw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FF1280058A;
        Thu,  7 May 2020 14:56:58 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-223.ams2.redhat.com [10.36.112.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6178B62A98;
        Thu,  7 May 2020 14:56:57 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 1/2] Revert "libbpf: Fix readelf output parsing on powerpc with recent binutils"
Date:   Thu,  7 May 2020 17:56:51 +0300
Message-Id: <20200507145652.190823-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
References: <20200507145652.190823-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The patch makes it fail on the output when the comment is printed
after the symbol name (RHEL8 powerpc):

400: 000000000000c714   144 FUNC    GLOBAL DEFAULT    1 bpf_object__open_file@LIBBPF_0.0.4         [<localentry>: 8]

But after commit aa915931ac3e ("libbpf: Fix readelf output parsing
for Fedora") it is not needed anymore, the parsing should work in
both cases.

This reverts commit 3464afdf11f9a1e031e7858a05351ceca1792fea.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index aee7f1a83c77..908dac9eb562 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -149,7 +149,7 @@ TAGS_PROG := $(if $(shell which etags 2>/dev/null),etags,ctags)
 GLOBAL_SYM_COUNT = $(shell readelf -s --wide $(BPF_IN_SHARED) | \
 			   cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' | \
 			   sed 's/\[.*\]//' | \
-			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
+			   awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}' | \
 			   sort -u | wc -l)
 VERSIONED_SYM_COUNT = $(shell readelf -s --wide $(OUTPUT)libbpf.so | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
@@ -216,7 +216,7 @@ check_abi: $(OUTPUT)libbpf.so
 		readelf -s --wide $(BPF_IN_SHARED) |			 \
 		    cut -d "@" -f1 | sed 's/_v[0-9]_[0-9]_[0-9].*//' |	 \
 		    sed 's/\[.*\]//' |					 \
-		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
+		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$8}'|   \
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
 		readelf -s --wide $(OUTPUT)libbpf.so |			 \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
-- 
2.26.2

