Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED6A4C7E3C
	for <lists+bpf@lfdr.de>; Tue,  1 Mar 2022 00:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiB1XYQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 18:24:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiB1XYQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 18:24:16 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F07C330C
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 15:23:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b64-20020a256743000000b0061e169a5f19so11732132ybc.11
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 15:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Hl63cIacA+y8aLzzmyl5L8wBUuBQ1b/3yZnRLsIwylg=;
        b=jAao/jq5jMxA2ELK6SgJRtpeoq77RDQVN5qgI/4Us4sP+jmjp40jD1IcRJsmh1EHgx
         m9uinNqt+dCTNXJgv1g9mue+wlv2xsOmn2+hn/I+GKLGFjBSRF7mb4sZH3jN+qPE+Mou
         wXqXDTkNDTuDftbBr11MTViCPhi8+SojdV8qj8PgIAzn2pPH3L4Pk5H62KzxUEzHu0nz
         441hsoGUHQrt/4i3cJGuIsOFKvGXiGLq7SYLJ6H/rMgo7fj/BuUAGDZbiJkI0aceAEYT
         EnNLRB+7T0ofLtJ/9wdtnqiW7cXoeOo1vd6+i+E+E6O07NDWW3a/OOIMUIghVBhV3o4f
         uwBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Hl63cIacA+y8aLzzmyl5L8wBUuBQ1b/3yZnRLsIwylg=;
        b=dAblvzJKvSkWAzil1WN1XQaUsOPE8+roxQJr9zzGtat6RVuosApqEmk3olTRW20H1g
         LrGIuZRHUD08duXtPYGa4GJ96ZGXxJxnRlBv3DAU6gQzt2mJ4/6PE0uTcvTkkmSDpccw
         WznVlBzF6p/x4fzyAsxPToTyxgvCW9JzZNJiMDJLQqCrnSkC6MxUq+gvB/MyOSIOkBYS
         fqbq9qV5JRVxnFbxxJIyhHNdi/18F/uVuqPBVw8Tppt/iFr1v43lTnNbnDlLZ0U132vt
         a3GxUwzuq3XiaIn7yK3lt6k56/6ok3627H6SYcNmWHnGfzO8AVSPpY1b6zg6biUNDeqN
         e1Hw==
X-Gm-Message-State: AOAM532O38p98btIRL8P+9t69ZKzvipsz6519ciajSANPyKkC9RnZJ/N
        xI8tuIiQyNna4eFPg9KXkJzkFAM=
X-Google-Smtp-Source: ABdhPJxkvsVPqRd5oHsNWX9wqjTUm1s4KG2y4Uox79pr8SwtrF8i4tR0F5IMf9kU59L2I+KVXzj+lKI=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:e0d9:4eba:c433:775d])
 (user=sdf job=sendgmr) by 2002:a25:296:0:b0:623:a267:ab94 with SMTP id
 144-20020a250296000000b00623a267ab94mr21495769ybc.430.1646090615042; Mon, 28
 Feb 2022 15:23:35 -0800 (PST)
Date:   Mon, 28 Feb 2022 15:23:32 -0800
Message-Id: <20220228232332.458871-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH bpf-next] bpf: test_run: Fix overflow in xdp frags bpf_test_finish
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        Stanislav Fomichev <sdf@google.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Syzkaller reports another issue:
WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
check_copy_size include/linux/thread_info.h:230 [inline]
WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
copy_to_user include/linux/uaccess.h:199 [inline]
WARNING: CPU: 0 PID: 10775 at include/linux/thread_info.h:230
bpf_test_finish.isra.0+0x4b2/0x680 net/bpf/test_run.c:171

This can happen when the userspace buffer is smaller than head+frags.
Return ENOSPC in this case.

Fixes: 7855e0db150a ("bpf: test_run: add xdp_shared_info pointer in bpf_test_finish signature")
Cc: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/bpf/test_run.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index f08034500813..eb129e48f90b 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -150,6 +150,11 @@ static int bpf_test_finish(const union bpf_attr *kattr,
 	if (data_out) {
 		int len = sinfo ? copy_size - sinfo->xdp_frags_size : copy_size;
 
+		if (len < 0) {
+			err = -ENOSPC;
+			goto out;
+		}
+
 		if (copy_to_user(data_out, data, len))
 			goto out;
 
-- 
2.35.1.574.g5d30c73bfb-goog

