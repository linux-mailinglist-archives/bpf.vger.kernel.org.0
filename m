Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999405BEAF2
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 18:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiITQPs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 12:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiITQPr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 12:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974CB5A835
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663690543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KimPl/K7tlGl3uFA9Ox53J/w+LgXS6pJY0U2Ot5GrNY=;
        b=Hy/2dRwDujeIM8rGU+8gVYiLvwti9venQAnVOPSNljs8gke2+ZOhFVWLe0cOGz0ws4nDya
        IrQ1tyu8+6JQWvlIlq528Malf7nTFbtDw2a2Dpu5AdDtyH7RkuNjOE1Bw1eUuIQ0qFXz+e
        cKI3qA7zzpJtXiOttDFfngku6ZUl4zU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-664-nH50DJRMPlGgSV2maPf_YA-1; Tue, 20 Sep 2022 12:14:51 -0400
X-MC-Unique: nH50DJRMPlGgSV2maPf_YA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 536CD858F13;
        Tue, 20 Sep 2022 16:14:13 +0000 (UTC)
Received: from astarta.redhat.com (unknown [10.39.195.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B7AF492B04;
        Tue, 20 Sep 2022 16:14:11 +0000 (UTC)
From:   Yauheni Kaliuta <ykaliuta@redhat.com>
To:     bpf@vger.kernel.org
Cc:     andrii@kernel.org, alexei.starovoitov@gmail.com,
        daniel@iogearbox.net, vkabatov@redhat.com,
        Yauheni Kaliuta <ykaliuta@redhat.com>
Subject: [PATCH bpf-next] selftests/bpf: Add liburandom_read.so to TEST_GEN_FILES
Date:   Tue, 20 Sep 2022 19:14:09 +0300
Message-Id: <20220920161409.129953-1-ykaliuta@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Added urandom_read shared lib is missing from the list of installed
files what makes urandom_read test after `make install` or `make
gen_tar` broken.

Add the library to TEST_GEN_FILES. The names in the list do not
contain $(OUTPUT) since it's added by lib.mk code.

Fixes: 00a0fa2d7d49 ("selftests/bpf: Add urandom_read shared lib and USDTs")
Signed-off-by: Yauheni Kaliuta <ykaliuta@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d59ec7f4c2d..8b7b72f14665 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -85,6 +85,7 @@ TEST_GEN_PROGS_EXTENDED = test_sock_addr test_skb_cgroup_id_user \
 	xskxceiver xdp_redirect_multi xdp_synproxy
 
 TEST_CUSTOM_PROGS = $(OUTPUT)/urandom_read
+TEST_GEN_FILES += liburandom_read.so
 
 # Emit succinct information message describing current building step
 # $1 - generic step name (e.g., CC, LINK, etc);
-- 
2.37.3

