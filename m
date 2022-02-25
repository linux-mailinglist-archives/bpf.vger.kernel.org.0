Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785034C4DF7
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbiBYSmG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 13:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiBYSmG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 13:42:06 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CAF25F8DD
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:41:33 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id e2so8553466ljq.12
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djk2iSPkU6bce+rQdTLcInAqOwqRlRJpCDbVsqFpZFI=;
        b=OzYxTD4CmL0ePnPhaXDmhUlRKz/q3hczlwtWXey3Ywb/lJZoVE5GfzM4uSCCbDmMWA
         NwxFqCPoqipQvBPpd2OPlElu5j3iFmfjrO6ZHjqlpDTZUklMBYpjGvyGPnI1NNlzH7Yn
         4zBOSKYtHBP5fZZT6LwMVKPOUSPNKH5lIhD/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=djk2iSPkU6bce+rQdTLcInAqOwqRlRJpCDbVsqFpZFI=;
        b=shNixjxc5IxZRhSNwgMQcqza/Pth88DoGuIeGt4qRfX7I71Ld2nE3maD96YFI3xUep
         bNPQBsgNHZNWktE1hy6gB6/Inn6z3QHYSPS0dtUdHf9C7muCESztxLkgY6BzhIUMfyat
         vVCfAU/GS+OrAvZkIIh74OMGEF/1Pv6DN1HXBadna5UlVcQyNNAurnfSptKAQ1E9WXTX
         pGjsSiJ+yhjmYmi+ZM9+UktROhwTnWWjhkjvwv1s0xtbUTufKULJi3DYBNDR9W+Y26fZ
         IhJ1tHMrPqsJN5RPRupzZgSnhbPxbSsABb6keQ4+R7igbg+5Li0ApzzRnBPow4hwdA4d
         bj1w==
X-Gm-Message-State: AOAM531q9hF3unQLc8bZl8LGoYqNsR5tMkLe6AiRCpOor0BBmP2LyW38
        haIxuKrfLjL/MFCxa/L+9QD6NS8k/b2YuA==
X-Google-Smtp-Source: ABdhPJwDhbrlUo20U7aTV9+LwebiAho+uzwmqOxcAv5U2zPC/Cy+UJxk39eaUameA/Oev6yrbo5jyQ==
X-Received: by 2002:a2e:9b4d:0:b0:244:da30:84c2 with SMTP id o13-20020a2e9b4d000000b00244da3084c2mr6110335ljj.359.1645814491478;
        Fri, 25 Feb 2022 10:41:31 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id w8-20020a2e9588000000b002461a53f351sm335351ljh.25.2022.02.25.10.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:41:31 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        kernel-team@cloudflare.com
Subject: [PATCH bpf-next] selftests/bpf: Fix error reporting from sock_fields programs
Date:   Fri, 25 Feb 2022 19:41:30 +0100
Message-Id: <20220225184130.483208-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper macro that records an error in BPF programs that exercise sock
fields access has been indavertedly broken by adaptation work that happened
in commit b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel
and global variables").

BPF_NOEXIST flag cannot be used to update BPF_MAP_TYPE_ARRAY. The operation
always fails with -EEXIST, which in turn means the error never gets
recorded, and the checks for errors always pass.

Revert the change in update flags.

Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sock_fields.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sock_fields.c b/tools/testing/selftests/bpf/progs/test_sock_fields.c
index 246f1f001813..3e2e3ee51cc9 100644
--- a/tools/testing/selftests/bpf/progs/test_sock_fields.c
+++ b/tools/testing/selftests/bpf/progs/test_sock_fields.c
@@ -114,7 +114,7 @@ static void tpcpy(struct bpf_tcp_sock *dst,
 
 #define RET_LOG() ({						\
 	linum = __LINE__;					\
-	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_NOEXIST);	\
+	bpf_map_update_elem(&linum_map, &linum_idx, &linum, BPF_ANY);	\
 	return CG_OK;						\
 })
 
-- 
2.35.1

