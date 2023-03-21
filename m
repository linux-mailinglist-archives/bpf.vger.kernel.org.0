Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247DB6C3974
	for <lists+bpf@lfdr.de>; Tue, 21 Mar 2023 19:46:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCUSqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Mar 2023 14:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCUSq3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Mar 2023 14:46:29 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9599656506
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:52 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so16441034pjh.0
        for <bpf@vger.kernel.org>; Tue, 21 Mar 2023 11:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679424351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySR/7H/KndjNOioe8wi69UHVxagx7ZilKLOoZyQ/76g=;
        b=jXJGqU5NOSY3X78jYA4klyuheJGhc1gv2EBl7cKlJciO88FzAtSbGkAxxAerIzuPQR
         H7OnofPlNauub7kVmKCgqLVORgOkLFJ10T0K4lboU/t2/uDuIUXeA7UsHPVHweUXASoX
         TOvdKqlpXBXPMWMg1OU9YJui3cSBzIbH3tQUv0CnvI7Zfy666I+WW6DLJHUgeVMHk+06
         tc8pFZtYoEDaevUkfalJS//QolWIxlk4OPsLqdq2VSL+6oq9O7yZfzWuKq8Y7S00pvoq
         hTbhSIzXaWh43acIooqzlsqOJki6O7SKLZ+Cs0HR0PgzLtr8Lt7O4AwE9J8F2USPN3KP
         ootQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679424351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySR/7H/KndjNOioe8wi69UHVxagx7ZilKLOoZyQ/76g=;
        b=uEiEH7KE1ABAYgXwzs5jxhQf7bLi+CG28uruqBU/ULHSzExguva8u8mY254RgeKADU
         4F6TXMYMXkTAfRufQnZObycQHeBGAttl8+S9mKBz4T0gowAi510TNeWpI5gcZk3iqPEf
         eJYrYbxNMFeGQeWqlhgsquPmYnuHX5N4ZgBoT7/yB2kK4xS6I2ZGy+gy1sJxIlslN/Ty
         +mAMu0I9cC0KldlJJxWaIl6xSXX2F6mRUaN+HPOeKoiLqnyvi2HKnn5Dw9c+Z9SCuzA6
         63y8yzK5APH0Jvr5ZBzMu45ql/7B3WBFDAlULnbxtFE/RaeW5s/huDPqIr7HmgAEtK42
         jVeQ==
X-Gm-Message-State: AO0yUKUR54gUR6U0oVj8uwMkpflEm6rvx+z69lhLYosVdtuQxpP+4yRN
        RFVtOxTA/gmwAGQvv51N7HgQv1Tztk21iA/MXZw=
X-Google-Smtp-Source: AK7set/LKH37N81+ekuT2OO4haAShAmThuI34pBiosUg7tDCw95FaNMGpoK4vmw+oFgOie3UOmRgfw==
X-Received: by 2002:a17:902:fa0f:b0:1a1:a8eb:d33e with SMTP id la15-20020a170902fa0f00b001a1a8ebd33emr110985plb.8.1679424350837;
        Tue, 21 Mar 2023 11:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4611:8100::1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c15500b0019cf747253csm9095878plj.87.2023.03.21.11.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 11:45:50 -0700 (PDT)
From:   Aditi Ghag <aditi.ghag@isovalent.com>
To:     bpf@vger.kernel.org
Cc:     kafai@fb.com, sdf@google.com, edumazet@google.com,
        aditi.ghag@isovalent.com
Subject: [PATCH v3 bpf-next 3/5] [RFC] net: Skip taking lock in BPF context
Date:   Tue, 21 Mar 2023 18:45:39 +0000
Message-Id: <20230321184541.1857363-4-aditi.ghag@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
References: <20230321184541.1857363-1-aditi.ghag@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When sockets are destroyed in the BPF iterator context, sock
lock is already acquired, so skip taking the lock. This allows
TCP listening sockets to be destroyed from BPF programs.

Signed-off-by: Aditi Ghag <aditi.ghag@isovalent.com>
---
 net/ipv4/inet_hashtables.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index e41fdc38ce19..5543a3e0d1b4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -777,9 +777,11 @@ void inet_unhash(struct sock *sk)
 		/* Don't disable bottom halves while acquiring the lock to
 		 * avoid circular locking dependency on PREEMPT_RT.
 		 */
-		spin_lock(&ilb2->lock);
+		if (!has_current_bpf_ctx())
+			spin_lock(&ilb2->lock);
 		if (sk_unhashed(sk)) {
-			spin_unlock(&ilb2->lock);
+			if (!has_current_bpf_ctx())
+				spin_unlock(&ilb2->lock);
 			return;
 		}
 
@@ -788,7 +790,8 @@ void inet_unhash(struct sock *sk)
 
 		__sk_nulls_del_node_init_rcu(sk);
 		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
-		spin_unlock(&ilb2->lock);
+		if (!has_current_bpf_ctx())
+			spin_unlock(&ilb2->lock);
 	} else {
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, sk->sk_hash);
 
-- 
2.34.1

