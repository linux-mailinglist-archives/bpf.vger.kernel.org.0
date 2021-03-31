Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28A6B3504F3
	for <lists+bpf@lfdr.de>; Wed, 31 Mar 2021 18:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhCaQps (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Mar 2021 12:45:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36846 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234206AbhCaQpa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 31 Mar 2021 12:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617209129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFwiGJ1dIAkQaLWEx4XeDhCLf4sdj3iC0TsPGK9TRT4=;
        b=Yi6yT63purwpZpl5fyzXDsUpQ3nB1W3CXlTwH7P1sIPnRswSkqmslzqp/fz52SLmCelNOX
        93q1cYa3ljxel+/0hHlOppsDjBe9/8s5Sg7gZ5w+araLutVUgfM8w5NcGVDqvon8OPcyQo
        tpA3frvCBAKXmSQ+K4XtI8ar2AhqXa8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-3SV314FsMAeAGbtwKyCT5g-1; Wed, 31 Mar 2021 12:45:21 -0400
X-MC-Unique: 3SV314FsMAeAGbtwKyCT5g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 726098189C8;
        Wed, 31 Mar 2021 16:45:20 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A49D51C40;
        Wed, 31 Mar 2021 16:45:19 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH bpf-next v3 3/8] selftests/bpf: pass page size from userspace in sockopt_sk
Date:   Wed, 31 Mar 2021 19:44:59 +0300
Message-Id: <20210331164504.320614-3-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
References: <20210331164433.320534-1-yauheni.kaliuta@redhat.com>
 <20210331164504.320614-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since there is no convenient way for bpf program to get PAGE_SIZE
from inside of the kernel, pass the value from userspace.

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
index 978a68005966..d6d03f64e2e4 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -7,9 +7,7 @@
 
 char _license[] SEC("license") = "GPL";
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
+int page_size; /* userspace should set it */
 
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

