Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052B7669299
	for <lists+bpf@lfdr.de>; Fri, 13 Jan 2023 10:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbjAMJNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 04:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240704AbjAMJMN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 04:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A5DB1DD
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 01:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673600995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vxQrOpngc5m5sJ3ndl/6WbG/qisMRAH+hUsUrxa1xvM=;
        b=VCbUlBRDqWtxasRbyrVeNs3FSa0eZk3VdNOfhIDVVwEeudTdXp6EvMN6XbLKLjIYfbWVss
        km3fXtnEVIzwmMjv/LXXg2a1RIX4LWrDckL2QCqv1XRH9NDs4UJT9PxnawqjiOUZ/QryXW
        48RgB0U5P96aF8p3kDnxFPZ9pDHMQHA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-JHAzXNGBM9es748yubQ6Qw-1; Fri, 13 Jan 2023 04:09:50 -0500
X-MC-Unique: JHAzXNGBM9es748yubQ6Qw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6BB43C16E9C;
        Fri, 13 Jan 2023 09:09:49 +0000 (UTC)
Received: from plouf.redhat.com (ovpn-193-50.brq.redhat.com [10.40.193.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 778171121314;
        Fri, 13 Jan 2023 09:09:47 +0000 (UTC)
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jiri Kosina <jikos@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Tero Kristo <tero.kristo@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH HID for-next v2 4/9] selftests: hid: ensure the program is correctly pinned
Date:   Fri, 13 Jan 2023 10:09:30 +0100
Message-Id: <20230113090935.1763477-5-benjamin.tissoires@redhat.com>
In-Reply-To: <20230113090935.1763477-1-benjamin.tissoires@redhat.com>
References: <20230113090935.1763477-1-benjamin.tissoires@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out that if bpffs was not mounted, the test was silently passing.

So ensure it passes by checking the mount command result.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

no changes in v2
---
 tools/testing/selftests/hid/hid_bpf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/hid/hid_bpf.c b/tools/testing/selftests/hid/hid_bpf.c
index d215bb492eb4..3b204a15e44b 100644
--- a/tools/testing/selftests/hid/hid_bpf.c
+++ b/tools/testing/selftests/hid/hid_bpf.c
@@ -640,7 +640,8 @@ TEST_F(hid_bpf, test_attach_detach)
 
 	/* pin the first program and immediately unpin it */
 #define PIN_PATH "/sys/fs/bpf/hid_first_event"
-	bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	err = bpf_program__pin(self->skel->progs.hid_first_event, PIN_PATH);
+	ASSERT_OK(err) TH_LOG("error while calling bpf_program__pin");
 	remove(PIN_PATH);
 #undef PIN_PATH
 	usleep(100000);
-- 
2.38.1

