Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250D0357C37
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 08:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhDHGO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 02:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhDHGOY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 02:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617862453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Scc8LTC91DxoFjvU3CeJsP6fSw3/lset5wCHL8g3eTk=;
        b=gMiTaaGaziOorhG6y3EvtBunt0KP7UkWNT2KqVCcc3+qnJDI3dRkszhvYsABGF5J/wMpX+
        Yomwtr2ubihSZgwMOMpW3jZI201GbEnyRe+GExnGuSALKlMIlZr2a8mQYiaRM39eY//YsK
        NEzUTtf05cK2aeH4fI3BllttVOzFxMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-li1AGmb7MdWvN5fUjHGkbg-1; Thu, 08 Apr 2021 02:14:12 -0400
X-MC-Unique: li1AGmb7MdWvN5fUjHGkbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB84800D53;
        Thu,  8 Apr 2021 06:14:11 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-182.ams2.redhat.com [10.36.112.182])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 809F87A398;
        Thu,  8 Apr 2021 06:13:19 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v4 3/9] selftests/bpf: pass page size from userspace in sockopt_sk
Date:   Thu,  8 Apr 2021 09:13:04 +0300
Message-Id: <20210408061310.95877-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
References: <20210408061238.95803-1-yauheni.kaliuta@redhat.com>
 <20210408061310.95877-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since there is no convenient way for bpf program to get PAGE_SIZE
from inside of the kernel, pass the value from userspace.

Zero-initialize the variable in bpf prog, otherwise it will cause
problems on some versions of Clang.

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/prog_tests/sockopt_sk.c |  2 ++
 tools/testing/selftests/bpf/progs/sockopt_sk.c      | 10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
index 7274b12abe17..4b937e5dbaca 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -200,6 +200,8 @@ static void run_test(int cgroup_fd)
 	if (!ASSERT_OK_PTR(skel, "skel_load"))
 		goto cleanup;
 
+	skel->bss->page_size = getpagesize();
+
 	skel->links._setsockopt =
 		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
 	if (!ASSERT_OK_PTR(skel->links._setsockopt, "setsockopt_link"))
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index 978a68005966..8acdb99b5959 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -7,9 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
+int page_size = 0; /* userspace should set it */
 
 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -89,7 +87,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * program can only see the first PAGE_SIZE
 		 * bytes of data.
 		 */
-		if (optval_end - optval != PAGE_SIZE)
+		if (optval_end - optval != page_size)
 			return 0; /* EPERM, unexpected data size */
 
 		return 1;
@@ -160,7 +158,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		/* Original optlen is larger than PAGE_SIZE. */
-		if (ctx->optlen != PAGE_SIZE * 2)
+		if (ctx->optlen != page_size * 2)
 			return 0; /* EPERM, unexpected data size */
 
 		if (optval + 1 > optval_end)
@@ -174,7 +172,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		 * program can only see the first PAGE_SIZE
 		 * bytes of data.
 		 */
-		if (optval_end - optval != PAGE_SIZE)
+		if (optval_end - optval != page_size)
 			return 0; /* EPERM, unexpected data size */
 
 		return 1;
-- 
2.31.1

