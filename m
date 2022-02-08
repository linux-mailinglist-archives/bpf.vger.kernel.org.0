Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AC44AD744
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 12:32:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356143AbiBHLcT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 06:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiBHKq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 05:46:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B332C03FEC0
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 02:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644317185;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dsj7EDldFhvvU63eZge2erJsS2a998I6mphPpp9LcYI=;
        b=XEBj6CzVRdsCfCwfgPubsKb5vumKxZoLB8uILrs1QbTEcJS+es6+Ws4yP8bx2j8JF7V62C
        A87PW/9uYq3aBUSmurSo+kLOmM25iLcKyRSAGM+cOggXtqY61j0fhJLkEUprb8FjE40RKt
        Mj5e8g9VKkIWZqWYAJm0TJ6LypeQFrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-167-hmWdigUQOxeOSaJhAM3rIw-1; Tue, 08 Feb 2022 05:46:21 -0500
X-MC-Unique: hmWdigUQOxeOSaJhAM3rIw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAED91091DB3;
        Tue,  8 Feb 2022 10:46:19 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.194.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 458457A8D7;
        Tue,  8 Feb 2022 10:46:17 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH bpf-next] bpf: Do not try bpf_msg_push_data with len 0
Date:   Tue,  8 Feb 2022 11:45:56 +0100
Message-Id: <05989b20a8793d1ee1fa70a8a7a4328a768263d0.1644314545.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If bpf_msg_push_data is called with len 0 (as it happens during
selftests/bpf/test_sockmap), we do not need to do anything and can
return early.

Signed-off-by: Felix Maurer <fmaurer@redhat.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 4603b7cd3cd1..9eb785842258 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2710,6 +2710,9 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	if (unlikely(flags))
 		return -EINVAL;
 
+	if (unlikely(len == 0))
+		return 0;
+
 	/* First find the starting scatterlist element */
 	i = msg->sg.start;
 	do {
-- 
2.34.1

