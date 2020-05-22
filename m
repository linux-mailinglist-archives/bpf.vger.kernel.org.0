Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DD1DDE98
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727924AbgEVENb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37493 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgEVENb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u49He7mJeWJjiEdyUax5g8nLZYWZmudbu/H3Tbw4Blk=;
        b=c6DUVT6khTtiNVjklgwSTDJhM8WuUqU5xClUyH8ab/PpcQpOedp/N07vubGrJdBWkXStel
        cFYtCC1IxZdPpfM6j2hEbh/B34eZNI5dStegdY7+dlC2mdi3hel9X4T1olZtDqT9xbGQaW
        L7JL4VaSX+P5x2rmlGGHDzUhPCgTX9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-7_16xKkwPem1yCkA9UW5lw-1; Fri, 22 May 2020 00:13:28 -0400
X-MC-Unique: 7_16xKkwPem1yCkA9UW5lw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0417107ACCD;
        Fri, 22 May 2020 04:13:27 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 308CC5D9C9;
        Fri, 22 May 2020 04:13:25 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 5/8] selftests/bpf: add output dir to include list
Date:   Fri, 22 May 2020 07:13:07 +0300
Message-Id: <20200522041310.233185-6-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some headers (skel) are generated in the output directory and used
for build (test_cpp.cpp), so add it to the list (as well as
CURDIR) otherwise out of tree build is broken.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 1ba3d72c3261..efab82151ce2 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -22,7 +22,8 @@ LLVM_OBJCOPY	?= llvm-objcopy
 BPF_GCC		?= $(shell command -v bpf-gcc;)
 SAN_CFLAGS	?=
 CFLAGS += -g -rdynamic -Wall -O2 $(GENFLAGS) $(SAN_CFLAGS)		\
-	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
+	  -I$(CURDIR) -I$(abspath $(OUTPUT)) 				\
+	  -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)			\
 	  -I$(TOOLSINCDIR) -I$(APIDIR)					\
 	  -Dbpf_prog_load=bpf_prog_test_load				\
 	  -Dbpf_load_program=bpf_test_load_program
-- 
2.26.2

