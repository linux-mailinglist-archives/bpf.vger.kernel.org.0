Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5A981DDE95
	for <lists+bpf@lfdr.de>; Fri, 22 May 2020 06:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgEVENX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 May 2020 00:13:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59537 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727809AbgEVENX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 May 2020 00:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590120802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQATS343UrFgDgS2zqiZoNp9hEOUjo/m3Yr8XAj0GQE=;
        b=VfLhr86jjU8N0FI6+TV70NF9USvvlKtwhCmg5OtvimMJuxGFZtkZZMEr37t0H2t0o4+E7R
        +a+PzWRK7r0pGa/I1MtGUSqvMLoSzb7z+qr4qUOTLlJFFEN/NjOJPcIGZistnHS4TI4l+D
        j+H8E34I9POM/NfjBYf/FfogUs5kgBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-F1Fudic5Mm2EVvzd2s_U6w-1; Fri, 22 May 2020 00:13:17 -0400
X-MC-Unique: F1Fudic5Mm2EVvzd2s_U6w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 15CE1107ACCD;
        Fri, 22 May 2020 04:13:16 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-74.ams2.redhat.com [10.36.112.74])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79C565D9C9;
        Fri, 22 May 2020 04:13:14 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     Jiri Benc <jbenc@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH 1/8] selftests/bpf: remove test_align from Makefile
Date:   Fri, 22 May 2020 07:13:03 +0300
Message-Id: <20200522041310.233185-2-yauheni.kaliuta@redhat.com>
In-Reply-To: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
References: <20200522041310.233185-1-yauheni.kaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

test_align has been moved under test_progs.

Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under
test_progs")

Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index e716e931d0c9..09700db35c2d 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -30,7 +30,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
+	test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
-- 
2.26.2

