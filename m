Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06FF4AF5D4
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 16:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiBIPzn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Feb 2022 10:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbiBIPzn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Feb 2022 10:55:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56F62C0613C9
        for <bpf@vger.kernel.org>; Wed,  9 Feb 2022 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644422145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4LPpUdaJ26kqsRGD9r2rux0lwgDIoM8+4SVGYnTcTCQ=;
        b=cP9cOzl4QzjvyPr0KNFRcWwnP8jGz3x2BGiVTbrIYFYWzIzzZioLCMYJnYbmR87gS7qMbo
        OPn40He61xez1ic+ZSQ5J+KJPAh3QCzuCHZeoer0prv4MQyWspJTsiKCtxtRFIMxGuSh+o
        mI7q6nfru7YtzUh6te5X+aV0lft6+2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-guvqruGQNH67d-8mqU2OLw-1; Wed, 09 Feb 2022 10:55:40 -0500
X-MC-Unique: guvqruGQNH67d-8mqU2OLw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF57A1091DAB;
        Wed,  9 Feb 2022 15:55:38 +0000 (UTC)
Received: from thinkpad.redhat.com (unknown [10.40.194.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1276134D46;
        Wed,  9 Feb 2022 15:55:35 +0000 (UTC)
From:   Felix Maurer <fmaurer@redhat.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org
Subject: [PATCH bpf-next v2] bpf: Do not try bpf_msg_push_data with len 0
Date:   Wed,  9 Feb 2022 16:55:26 +0100
Message-Id: <df69012695c7094ccb1943ca02b4920db3537466.1644421921.git.fmaurer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Calling bpf_msg_push_data with len 0 previously lead to a wrong ENOMEM
error: we later called get_order(copy + len); if len was 0, copy + len
was also often 0 and get_order returned some undefined value (at the
moment 52). alloc_pages caught that and failed, but then
bpf_msg_push_data returned ENOMEM. This was wrong because we are most
probably not out of memory and actually do not need any additional
memory.

v2: Add bug description and Fixes tag

Fixes: 6fff607e2f14b ("bpf: sk_msg program helper bpf_msg_push_data")
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

