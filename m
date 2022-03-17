Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A914DC4EC
	for <lists+bpf@lfdr.de>; Thu, 17 Mar 2022 12:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232975AbiCQLkk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Mar 2022 07:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233011AbiCQLkk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Mar 2022 07:40:40 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEB21E3E37
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:24 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so8599937lfb.0
        for <bpf@vger.kernel.org>; Thu, 17 Mar 2022 04:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQgZAkq+ORk9ENUakuwLhhkNNQ+vKaeY9GX3+UUqx8k=;
        b=lgYhAxitjoyP+MJwFELpUSNbr8ad29xlnUpzRY8b2rQo6nwLeV3DG6J2YYEscVC+0O
         3bQzAZ6ea8OK8y3HsC4fhd/uaX28aQmYPHLiHh9TLcl1utGyj9rW1c5+KuWZfegXkzGg
         HN0JDauYgZDF2uT8ijyHIgCGNxEjyQF6KbNrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MQgZAkq+ORk9ENUakuwLhhkNNQ+vKaeY9GX3+UUqx8k=;
        b=oSETJHHjUgJ56a8gLwCJ8ni7n6yrbMr3zzk5+UGtBf6ApgMfLpjOPb4ZqqGpWbus3h
         u4Be4ZFhpSAUessjEIw3GPF7WlEEq8kJIYSLpbBegx5RrziBmTwg8kMnWRCdVIcS2e4I
         qdY2dR1Euju2Epr1olYNwca8jvlmkN/wHu1FiBq8PWLv6Q9c9f8nl5Hio20LpYlPOSMi
         Ir6J0BmbMnuJUUR184WYDEzIEvjdw9MScNgZWr0ujpgflZndhGSZHFJwTqD+A8FzPm56
         3uXTe3zZLTdJ64u0IIzAUiqnwon28vjffbSeeJntKKo3pVmQlqRaIv6Q2iZb6Bd6HH8K
         aE7g==
X-Gm-Message-State: AOAM5333EJ+t/zAEZNC7I9Nd7riduhNMTbBNQJ0ZaxTUIExNe+nZFphV
        P/K+7xxew0wI5swa62roxvnZ4xAIeR+TIQ==
X-Google-Smtp-Source: ABdhPJwfy++rrH/kaz3cZwg2wuOC4ouKNCNoiW9xSTCYcKcSHsSmiXt5+r4wDAgNoKotDCAuf1HfTQ==
X-Received: by 2002:a05:6512:2027:b0:448:bdb3:a238 with SMTP id s7-20020a056512202700b00448bdb3a238mr2654501lfs.266.1647517162095;
        Thu, 17 Mar 2022 04:39:22 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id 206-20020a2e09d7000000b00247eb27d491sm395404ljj.103.2022.03.17.04.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:39:21 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Ilya Leoshkevich <iii@linux.ibm.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 1/4] selftests/bpf: Fix error reporting from sock_fields programs
Date:   Thu, 17 Mar 2022 12:39:17 +0100
Message-Id: <20220317113920.1068535-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317113920.1068535-1-jakub@cloudflare.com>
References: <20220317113920.1068535-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The helper macro that records an error in BPF programs that exercise sock
fields access has been inadvertently broken by adaptation work that
happened in commit b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to
use skel and global variables").

BPF_NOEXIST flag cannot be used to update BPF_MAP_TYPE_ARRAY. The operation
always fails with -EEXIST, which in turn means the error never gets
recorded, and the checks for errors always pass.

Revert the change in update flags.

Fixes: b18c1f0aa477 ("bpf: selftest: Adapt sock_fields test to use skel and global variables")
Acked-by: Martin KaFai Lau <kafai@fb.com>
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

