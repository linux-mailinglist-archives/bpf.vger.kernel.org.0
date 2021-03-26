Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65AAF34A694
	for <lists+bpf@lfdr.de>; Fri, 26 Mar 2021 12:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhCZLrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Mar 2021 07:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60807 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229589AbhCZLra (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 26 Mar 2021 07:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616759250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1PRjoolN/0TRpZdrtFaOMo+fWLdGM5HRHk+d2zU9yXI=;
        b=gc1W+g7+Qqj0wdFeGGKfaKUM9cWERShWx2Lfq2g33rGahpUZRH6fvxpu7OfVsqRPBaSACs
        siWxNCBNqVyAmznjxmJGZw027M5zBlYXUSo0jcHOrCvde9ILE8tL5UAiAhMzPzUwYe7ETX
        cEUHD1oCs1E6vmOn5Xht5nYYd8kGzTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-IIM9zxEKNL2edDbp7N_LSg-1; Fri, 26 Mar 2021 07:47:28 -0400
X-MC-Unique: IIM9zxEKNL2edDbp7N_LSg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BDDD51005D4F;
        Fri, 26 Mar 2021 11:47:27 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-114-130.ams2.redhat.com [10.36.114.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3DC186060F;
        Fri, 26 Mar 2021 11:47:23 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, jolsa@redhat.com,
        Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Subject: [PATCH 1/3] selftests/bpf: test_progs/sockopt_sk: pass page size from userspace
Date:   Fri, 26 Mar 2021 13:47:20 +0200
Message-Id: <20210326114722.210109-1-yauheni.kaliuta@redhat.com>
In-Reply-To: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
References: <20210326114658.210034-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 114c1a622ffa..6a7cb5f23db2 100644
--- a/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/prog_tests/sockopt_sk.c
@@ -201,6 +201,8 @@ static void run_test(int cgroup_fd)
 	if (CHECK(!skel, "skel_load", "sockopt_sk skeleton failed\n"))
 		goto cleanup;
 
+	skel->bss->page_size = getpagesize();
+
 	skel->links._setsockopt =
 		bpf_program__attach_cgroup(skel->progs._setsockopt, cgroup_fd);
 	if (CHECK(IS_ERR(skel->links._setsockopt),
diff --git a/tools/testing/selftests/bpf/progs/sockopt_sk.c b/tools/testing/selftests/bpf/progs/sockopt_sk.c
index d3597f81e6e9..55dfbe53c24e 100644
--- a/tools/testing/selftests/bpf/progs/sockopt_sk.c
+++ b/tools/testing/selftests/bpf/progs/sockopt_sk.c
@@ -8,9 +8,7 @@
 char _license[] SEC("license") = "GPL";
 __u32 _version SEC("version") = 1;
 
-#ifndef PAGE_SIZE
-#define PAGE_SIZE 4096
-#endif
+int page_size; /* userspace should set it */
 
 #ifndef SOL_TCP
 #define SOL_TCP IPPROTO_TCP
@@ -90,7 +88,7 @@ int _getsockopt(struct bpf_sockopt *ctx)
 		 * program can only see the first PAGE_SIZE
 		 * bytes of data.
 		 */
-		if (optval_end - optval != PAGE_SIZE)
+		if (optval_end - optval != page_size)
 			return 0; /* EPERM, unexpected data size */
 
 		return 1;
@@ -161,7 +159,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 
 	if (ctx->level == SOL_IP && ctx->optname == IP_FREEBIND) {
 		/* Original optlen is larger than PAGE_SIZE. */
-		if (ctx->optlen != PAGE_SIZE * 2)
+		if (ctx->optlen != page_size * 2)
 			return 0; /* EPERM, unexpected data size */
 
 		if (optval + 1 > optval_end)
@@ -175,7 +173,7 @@ int _setsockopt(struct bpf_sockopt *ctx)
 		 * program can only see the first PAGE_SIZE
 		 * bytes of data.
 		 */
-		if (optval_end - optval != PAGE_SIZE)
+		if (optval_end - optval != page_size)
 			return 0; /* EPERM, unexpected data size */
 
 		return 1;
-- 
2.29.2

