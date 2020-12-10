Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2081E2D59EF
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 13:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgLJMD1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 07:03:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32802 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgLJMD1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 07:03:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607601721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=jebjPj3Ys+A6fExm1/YZZnTC7mceK9y980vXgoarv5s=;
        b=Tci7yv1BpFFpFJAfBPdSMMzK2BVtjYHc6L6da7R2Dvn0KftOi7eU8hEsFf3Iu/b2ocqaeG
        ZhFLRCzAYhqS0Fhw9WAi7K6vCqIWmvIMRz5P6tUrkhvfUFz/RnW8XWcZcla7tIkWxTgptb
        CXavTg7kgR/HJlF6pQcUdfaKtH4p7IA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-xm_6ljd6MgiW6U5D_6jzMg-1; Thu, 10 Dec 2020 07:01:58 -0500
X-MC-Unique: xm_6ljd6MgiW6U5D_6jzMg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 066E48015CE;
        Thu, 10 Dec 2020 12:01:45 +0000 (UTC)
Received: from steamlocomotive.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 95FFF5D9DD;
        Thu, 10 Dec 2020 12:01:43 +0000 (UTC)
From:   Veronika Kabatova <vkabatov@redhat.com>
To:     bpf@vger.kernel.org
Cc:     jolsa@redhat.com, brouer@redhat.com, alexanderduyck@fb.com,
        Veronika Kabatova <vkabatov@redhat.com>
Subject: [PATCH] selftests/bpf: Drop tcp-{client,server}.py from Makefile
Date:   Thu, 10 Dec 2020 13:01:34 +0100
Message-Id: <20201210120134.2148482-1-vkabatov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The files don't exist anymore so this breaks generic kselftest builds
when using "make install" or "make gen_tar".

Fixes: 247f0ec361b7 ("selftests/bpf: Drop python client/server in favor of threads")
Signed-off-by: Veronika Kabatova <vkabatov@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 542768f5195b..bc06ea263034 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -73,8 +73,6 @@ TEST_PROGS := test_kmod.sh \
 
 TEST_PROGS_EXTENDED := with_addr.sh \
 	with_tunnels.sh \
-	tcp_client.py \
-	tcp_server.py \
 	test_xdp_vlan.sh
 
 # Compile but not part of 'make run_tests'
-- 
2.26.2

