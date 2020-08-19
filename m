Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B283F24A3C5
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 18:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgHSQHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 12:07:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42301 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725275AbgHSQHW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 12:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597853241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qBHxHMLNJZNm9IHhHzJpYWQ+1g9g8xWfIEFbiVdGNJI=;
        b=VK0PsN4PI1ltmKP9RtsaQxmmRU7ip3ckBE9oBXBt5vwgNCUk/7cRcdaRRgpZuNX5t3PYpl
        7fQKI6CiVLA5+TD/jgJxcSr5CcOyhbwJzLsv1jzLBi98EliIQCOyRoVeAhevG3T7+Jvpqo
        SoGs5Cyr1yBaiJDxsRIMrLQQzWqaycs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-vCNbpd0LPd-oSMLQLTZdtQ-1; Wed, 19 Aug 2020 12:07:19 -0400
X-MC-Unique: vCNbpd0LPd-oSMLQLTZdtQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52D2BF6A62;
        Wed, 19 Aug 2020 16:07:18 +0000 (UTC)
Received: from steamlocomotive.redhat.com (unknown [10.40.194.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABC31101E1DE;
        Wed, 19 Aug 2020 16:07:13 +0000 (UTC)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf@vger.kernel.org
Cc:     sdf@google.com, andriin@fb.com, skozina@redhat.com,
        brouer@redhat.com, yhs@fb.com,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH v2] selftests/bpf: Remove test_align leftovers
Date:   Wed, 19 Aug 2020 18:07:10 +0200
Message-Id: <20200819160710.1345956-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling generic selftests "make install" fails as rsync expects all
files from TEST_GEN_PROGS to be present. The binary is not generated
anymore (commit 3b09d27cc93d) so we can safely remove it from there
and also from gitignore.

Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 tools/testing/selftests/bpf/.gitignore | 1 -
 tools/testing/selftests/bpf/Makefile   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftests/bpf/.gitignore
index 1bb204cee853..9a0946ddb705 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -6,7 +6,6 @@ test_lpm_map
 test_tag
 FEATURE-DUMP.libbpf
 fixdep
-test_align
 test_dev_cgroup
 /test_progs*
 test_tcpbpf_user
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index a83b5827532f..fc946b7ac288 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -32,7 +32,7 @@ LDLIBS += -lcap -lelf -lz -lrt -lpthread
 
 # Order correspond to 'make run_tests' order
 TEST_GEN_PROGS = test_verifier test_tag test_maps test_lru_map test_lpm_map test_progs \
-	test_align test_verifier_log test_dev_cgroup test_tcpbpf_user \
+	test_verifier_log test_dev_cgroup test_tcpbpf_user \
 	test_sock test_btf test_sockmap get_cgroup_id_user test_socket_cookie \
 	test_cgroup_storage \
 	test_netcnt test_tcpnotify_user test_sock_fields test_sysctl \
-- 
2.26.2

