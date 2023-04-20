Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775F06E88A8
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 05:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDTD16 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Apr 2023 23:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjDTD16 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Apr 2023 23:27:58 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B4E40D4
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-63b620188aeso726468b3a.0
        for <bpf@vger.kernel.org>; Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681961276; x=1684553276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=EbJ7DiX0KNLClu6JNpZIDUdsu5ZAfzUcUtofGd3c7gYYeF16zc/59GXJ+AutZPz5w3
         1ifFTsK5hJK7jS8Yuwo7Jpyx5xPPQBukFkmUdFtOl7Q+AjoYuvx5dbhYnTTITWFdLbT0
         0yQKRpLKV/NLt/a9TXPz/ywKmiu4fth5/3NewCfewonuQbTDHwV12xSpaKQu3zXBdLTK
         Wkanbypedh5FCjD5x9rM26Np8iyWJ5A6WTwsT0eUl7SY1+Mb/AXTqtug1T3xcMgQl0nK
         yW1wBdq39B32F1H77/uS5PhpH+H1TGtEQ217Ncm+uuavogm6WqfJlu1T+jxqmG4+Bqhw
         b38A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681961276; x=1684553276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr7bhkX+Epn2YWYx/+oT337obKjgENzwcgRHzhBp9VI=;
        b=fDvXQPyVyBCN5uZY2ZK36bEL8VKtIFK8eW7e9A+ACCldtwr7X2M9mvadCjdDiZvaMS
         15FnAWk1sqVO3UaUBn/FNXviSAYAwi2RZkYAVjYMqa7ywEFJWMuCpdGMqFaR2eEw/tMq
         Ussomi+RYE/OkQoxLgDdR6RRjX3qN9V5JgmVWLPhb3asxBVWYydkn1F9AMSCMymgl354
         4zqeiTb4fmYVQlihluJRjOGp2nUPY56EaL25M0ir7BWQJSfp17J5u/OnAd3iLS1aJ72t
         DOJP2tAJ8RNh0LIH5wuzpdzt1cTYEYd1ARCk9rZLds8pHL2SOqR2Ng4W4vMnAkEVXUv2
         XPuA==
X-Gm-Message-State: AAQBX9d6WJwgQFFA0N7oEEdVynymrjsZQKzdXuNzziKsxQpJZygmOFbf
        eg6cIryic79BuTnn1L3ihoMKQw==
X-Google-Smtp-Source: AKy350Zzlox3kqFQwaEZJ1yWV/Qr9yqOXqttJ3x49/9gX0Cj/UedEau5H5gSR+U9pHNT8o+cBv2Pjw==
X-Received: by 2002:a05:6a00:189c:b0:626:2984:8a76 with SMTP id x28-20020a056a00189c00b0062629848a76mr7091693pfh.34.1681961276413;
        Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id z15-20020a655a4f000000b00517abaac366sm115231pgs.74.2023.04.19.20.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 20:27:56 -0700 (PDT)
From:   Feng zhou <zhoufeng.zf@bytedance.com>
To:     martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mykolal@fb.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
        zhouchengming@bytedance.com, zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2 1/2] bpf: support access variable length array of integer type
Date:   Thu, 20 Apr 2023 11:27:34 +0800
Message-Id: <20230420032735.27760-2-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230420032735.27760-1-zhoufeng.zf@bytedance.com>
References: <20230420032735.27760-1-zhoufeng.zf@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Feng Zhou <zhoufeng.zf@bytedance.com>

After this commit:
bpf: Support variable length array in tracing programs (9c5f8a1008a1)
Trace programs can access variable length array, but for structure
type. This patch adds support for integer type.

Example:
Hook load_balance
struct sched_domain {
	...
	unsigned long span[];
}

The access: sd->span[0].

Co-developed-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 027f9f8a3551..a0887ee44e89 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6157,11 +6157,13 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		if (off < moff)
 			goto error;
 
-		/* Only allow structure for now, can be relaxed for
-		 * other types later.
-		 */
+		/* allow structure and integer */
 		t = btf_type_skip_modifiers(btf, array_elem->type,
 					    NULL);
+
+		if (btf_type_is_int(t))
+			return WALK_SCALAR;
+
 		if (!btf_type_is_struct(t))
 			goto error;
 
-- 
2.20.1

