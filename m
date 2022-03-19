Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2494DEA24
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 19:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243926AbiCSSfa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 14:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiCSSfW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 14:35:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB702986E2
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:34:01 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id p15so8079342lfk.8
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 11:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qPPQj9ItVfe1R+y/cRdtBrWh+vYyFPZ0Vdz4dbbnHxA=;
        b=GgSox0CBISUzBNHpwQRpVYkZodqL1GmusqJl3ZG7YpnJL0cAUSA8bHZDUgqZLOH4CA
         pkBo9UVAmWb9s6SjJUmmW2nsWsxPDwYwukl50uH8s2npKUSCAp07Hpg08jsAH47IAECd
         ISsMr+5HWlT5iSjI9c1mjtMVraKZUGnFEfjiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qPPQj9ItVfe1R+y/cRdtBrWh+vYyFPZ0Vdz4dbbnHxA=;
        b=7tPuUF/jgd8ZhjJHFa+MdZSwqLW7it+mcFvavrg6gfAAxP70yOSkorc9ZmX/dh8TmD
         KPaYmGl5jcv8Bk3Ouqif+B6Yht/842UiGKR97NrWWSqi21+2UB1MTgr5uemkkB4iu6YK
         TTqwt4NWgzOUCkXVfgNYLU732i0LvJJ4U4b9Cuo/WXnolApNMl+3iBKtT7+Pa3bJrt/+
         4wNjdJ+9GqlLmGQlXpBDM4IwPL8TDwtT5JY7RnyINuUgdL7Ahmejgz+mmm2scWPW8QCu
         wDxavn++pHC3X4CnoSB1R7l1i5eP0S9NWabUX/Xq3IE8yWB+/o6FC4OYiYT92QyXIiSP
         FCGw==
X-Gm-Message-State: AOAM531/80rqSzgHX+QAyiA6D5SjGTLW+Z9S7CEx+KdeDZWphKWFn9rW
        W3n3wDpzfAJRVs9XdGStdPqLLsKmGnWsbQ==
X-Google-Smtp-Source: ABdhPJxRvEPyfXs52HdvEeThnMOdcgxoyS2uOkJtk0UaiCitq7i+/2T8/ud8rxkMWY+W2mgdDmIt1g==
X-Received: by 2002:a05:6512:3a90:b0:448:a18f:4b82 with SMTP id q16-20020a0565123a9000b00448a18f4b82mr9325673lfu.307.1647714839284;
        Sat, 19 Mar 2022 11:33:59 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:4809:d800::f9c])
        by smtp.gmail.com with ESMTPSA id l4-20020a2e9084000000b00244cb29e3e4sm1613912ljg.133.2022.03.19.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 11:33:58 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH bpf-next v2 2/3] selftests/bpf: Fix u8 narrow load checks for bpf_sk_lookup remote_port
Date:   Sat, 19 Mar 2022 19:33:55 +0100
Message-Id: <20220319183356.233666-3-jakub@cloudflare.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220319183356.233666-1-jakub@cloudflare.com>
References: <20220319183356.233666-1-jakub@cloudflare.com>
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

In commit 9a69e2b385f4 ("bpf: Make remote_port field in struct
bpf_sk_lookup 16-bit wide") ->remote_port field changed from __u32 to
__be16.

However, narrow load tests which exercise 1-byte sized loads from
offsetof(struct bpf_sk_lookup, remote_port) were not adopted to reflect the
change.

As a result, on little-endian we continue testing loads from addresses:

 - (__u8 *)&ctx->remote_port + 3
 - (__u8 *)&ctx->remote_port + 4

which map to the zero padding following the remote_port field, and don't
break the tests because there is no observable change.

While on big-endian, we observe breakage because tests expect to see zeros
for values loaded from:

 - (__u8 *)&ctx->remote_port - 1
 - (__u8 *)&ctx->remote_port - 2

Above addresses map to ->remote_ip6 field, which precedes ->remote_port,
and are populated during the bpf_sk_lookup IPv6 tests.

Unsurprisingly, on s390x we observe:

  #136/38 sk_lookup/narrow access to ctx v4:OK
  #136/39 sk_lookup/narrow access to ctx v6:FAIL

Fix it by removing the checks for 1-byte loads from offsets outside of the
->remote_port field.

Fixes: 9a69e2b385f4 ("bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide")
Suggested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/progs/test_sk_lookup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup.c b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
index bf5b7caefdd0..38b7a1fe67b6 100644
--- a/tools/testing/selftests/bpf/progs/test_sk_lookup.c
+++ b/tools/testing/selftests/bpf/progs/test_sk_lookup.c
@@ -413,8 +413,7 @@ int ctx_narrow_access(struct bpf_sk_lookup *ctx)
 
 	/* Narrow loads from remote_port field. Expect SRC_PORT. */
 	if (LSB(ctx->remote_port, 0) != ((SRC_PORT >> 0) & 0xff) ||
-	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff) ||
-	    LSB(ctx->remote_port, 2) != 0 || LSB(ctx->remote_port, 3) != 0)
+	    LSB(ctx->remote_port, 1) != ((SRC_PORT >> 8) & 0xff))
 		return SK_DROP;
 	if (LSW(ctx->remote_port, 0) != SRC_PORT)
 		return SK_DROP;
-- 
2.35.1

