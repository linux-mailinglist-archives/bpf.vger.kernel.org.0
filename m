Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294E7249A48
	for <lists+bpf@lfdr.de>; Wed, 19 Aug 2020 12:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgHSKYX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Aug 2020 06:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727966AbgHSKYU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 19 Aug 2020 06:24:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597832657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IG3Te5ktUQG4u9T0CO/w0qH3TqN2jWIS4OrkM2E6mQg=;
        b=Iu1tXnpTOoCsyP12qL+SL55D8rH/Rg465HxW4RHep8vZgVgFxl6HWKqwK9wABrSilnBesy
        Eclei7EOPxHgH2n5SpS+uheLQuEUhON3Y60vM6Wx0K8P1u97/uP5VEVHzF6tFZkoonCWtv
        oz16snijI97jurhjj8xBziE5CrsoQ5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-je9PjB7ZPvG0igbs61fyCw-1; Wed, 19 Aug 2020 06:24:15 -0400
X-MC-Unique: je9PjB7ZPvG0igbs61fyCw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C43501008550;
        Wed, 19 Aug 2020 10:24:14 +0000 (UTC)
Received: from steamlocomotive.redhat.com (unknown [10.40.194.249])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F3E350AC5;
        Wed, 19 Aug 2020 10:24:09 +0000 (UTC)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf@vger.kernel.org
Cc:     sdf@google.com, andriin@fb.com, skozina@redhat.com,
        brouer@redhat.com, Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH] selftests/bpf: Remove test_align from TEST_GEN_PROGS
Date:   Wed, 19 Aug 2020 12:23:54 +0200
Message-Id: <20200819102354.1297830-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Calling generic selftests "make install" fails as rsync expects all
files from TEST_GEN_PROGS to be present. The binary is not generated
anymore (commit 3b09d27cc93d) so we can safely remove it from there.

Fixes: 3b09d27cc93d ("selftests/bpf: Move test_align under test_progs")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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

