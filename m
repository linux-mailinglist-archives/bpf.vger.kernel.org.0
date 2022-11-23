Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45F636A87
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 21:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237495AbiKWUIg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 15:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbiKWUId (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 15:08:33 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187D985160
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:08:32 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id o15-20020a17090aac0f00b00212e93524c0so1845322pjq.2
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 12:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7gqkUCEDqCnwHfQcl6hPRPU1Fjayp2mbyWY/eUfc5LM=;
        b=seFQzkgG1GhvrRpskERv8Q/C5wZVgD2X37ubq108DdvbUgB9wk13RH6ypY14LgJxX9
         dPWnuw6dxP7HNWecl/FgnZoNSvGMV1svvoZ1RvxKiwUCbj7kx0pMwbqb/f2CzhJUux1M
         Rr7hTOvfv0T/VThmv7/ch8dcqDZZInx03uQrx5/OKABRlYmRjvEdG/cFgtJt1JAnuDSx
         GKxg5LZyxJRdPw4cbRQm4vIcmXpOp7GQwwdMY3+MI8u354hNUFQxbJ+yVgtMlToxVgNg
         KlWc+ULLJ8Uw9W0SgFmy6k5VzD/K8G0526n3jNwiG6bWJxzGuiGEhdLpF/LxG8+xJaqC
         +D0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7gqkUCEDqCnwHfQcl6hPRPU1Fjayp2mbyWY/eUfc5LM=;
        b=vlJ/F7ucfUjfKxpkn94j6s6koxA66Q0AGKOq2AJp9h3dBx8KOtw3op2WJQpKWRMLp6
         GmkvpxuTF1Em+NnLplg8HPaF3ZtpRRjnHJPElJnHg/bT9GGPUH1y9PLc7HJbSEUzFeWv
         NwYf6Cpal0S1Ku6QlPXKsLSmwzmSuGDOLHh8t2oBuRm71ZeVNLsdTBvs8jlu7X409UfU
         2T3UyW9OJ6ZF8txSUKEEkaFAEm/C1xSJPkFa59Sf+x1uzyHA6Klgeutlr1i3h+clByf2
         +K1MqTj/hzBuA4bVWyLTTF6shzrQ9uHnmI+pia0oRuhjE6TBnCIwf6ML6jcdvJRcICd7
         rrzQ==
X-Gm-Message-State: ANoB5pk/7m7jcGCTqIvW4tSiy9w41Lq1yUT503BiXM+4pH8TFT//9OC8
        xlWTOXbAiy8YOhy7xHUHPAqe/37unm8D/Isb5YRmdRXh647KoFljH9dNSM85H6Tpyv8z+gvP/hG
        U3zSDEJQVn4nIm4FMQSzR9fE/cGjSJzwxp/CjZ3dMrrDuaQqE+g==
X-Google-Smtp-Source: AA0mqf5En6r58XNQn3dWBKaYhIqvhvlVF2xVBV+goZ4Bd52Bg+ynMwlsCHsHjVtQHmXFlSkQDgIC4XU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2798:b0:174:a0e6:428 with SMTP id
 jw24-20020a170903279800b00174a0e60428mr11261982plb.124.1669234111546; Wed, 23
 Nov 2022 12:08:31 -0800 (PST)
Date:   Wed, 23 Nov 2022 12:08:29 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221123200829.2226254-1-sdf@google.com>
Subject: [PATCH bpf-next] selftests/bpf: Mount debugfs in setns_by_fd
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, Jiri Olsa <olsajiri@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jiri reports broken test_progs after recent commit 68f8e3d4b916
("selftests/bpf: Make sure zero-len skbs aren't redirectable").
Apparently we don't remount debugfs when we switch back networking namespace.
Let's explicitly mount /sys/kernel/debug.

0: https://lore.kernel.org/bpf/63b85917-a2ea-8e35-620c-808560910819@meta.com/T/#ma66ca9c92e99eee0a25e40f422489b26ee0171c1

Fixes: a30338840fa5 ("selftests/bpf: Move open_netns() and close_netns() into network_helpers.c")
Reported-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/network_helpers.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index bec15558fd93..1f37adff7632 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -426,6 +426,10 @@ static int setns_by_fd(int nsfd)
 	if (!ASSERT_OK(err, "mount /sys/fs/bpf"))
 		return err;
 
+	err = mount("debugfs", "/sys/kernel/debug", "debugfs", 0, NULL);
+	if (!ASSERT_OK(err, "mount /sys/kernel/debug"))
+		return err;
+
 	return 0;
 }
 
-- 
2.38.1.584.g0f3c55d4c2-goog

