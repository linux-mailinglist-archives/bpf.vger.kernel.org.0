Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718958A76C
	for <lists+bpf@lfdr.de>; Fri,  5 Aug 2022 09:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240283AbiHEHt1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 03:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240355AbiHEHtT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 03:49:19 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757966D9C5;
        Fri,  5 Aug 2022 00:49:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id e8-20020a17090a280800b001f2fef7886eso2058627pjd.3;
        Fri, 05 Aug 2022 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=E/vJaeCBGviaQ0hvzD8949Y30FhDcD4GWRiGcNZUjZ4=;
        b=Ab4hS9bBEcHP2rHNZUseHVF0Kw0e80Tj0eXSPOSDMaSQ3heN0Lqrkw4M52EpZyd3sz
         H9AEvm+73fn4pFMKyNCe0D7m7XhYsjeLiVYlvI+r0WhTQ/DUsXNg61ByHct2DBLbc9oc
         ewCUbcq9frRNV20oyoqTu8u41JDh+umV94wF+N9+9UEkxR/nGoJPM4G1EGXLoFWR860r
         fIPFpLycsY8kqzkAHDiyitnIQI/hitho4s7dx4+1EH+2TNpZUjB/R83HhmaLT+MgLuI6
         KHiq3EkjwE6QWABljF2bgdlGIj2IKOOOQcyAcsuQjR5rgW3YcnHOymJLiCN94q/lqtx4
         +CBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=E/vJaeCBGviaQ0hvzD8949Y30FhDcD4GWRiGcNZUjZ4=;
        b=ORwKRgeJQQ68wpbs5E9ppXAvctFH6Yg9sfb1kGCPkksuAioUSBunZlqutTXffPs4XH
         hlsE+kEH0JDasvlpwIkDK4uximcbLclupouKm/PtfbtdzmpZS/3z1EGSIqaOzii/UtUO
         4VgGyIZgbBUevyQcIU69i0eUNU5ddI8gvkS3R/Y3LH053PPqedBuWm2OV+iQBLOGH5Kn
         stXdHrgFta+vNQb36Tqm8Y0rNUVKfI5x0ZI2zkuTCUJCCDUQBhPIM9e7JiNTzpJMSq+P
         BKoTDnvfs83mlG1YU40rflyEo72TjlRUJOUruFJMmR6TwvpbORFWrtjsQgMdVYOiRCmE
         aX/w==
X-Gm-Message-State: ACgBeo38jzcCJPajm+e9EPj+2lrOnKGIHVRxxjsSUSjGrFMII6VPDpvI
        SKcoJqTkktMr2aWqMWvghhA=
X-Google-Smtp-Source: AA6agR4RWYHTlCj4Uz5Gvo8snJllIK29/g1mtcBOELrWgSN3MOHqMmX6fls8W5al8Nbc/MsRyKi2yA==
X-Received: by 2002:a17:90a:e2cc:b0:1f3:1151:e0ff with SMTP id fr12-20020a17090ae2cc00b001f31151e0ffmr6512965pjb.50.1659685753937;
        Fri, 05 Aug 2022 00:49:13 -0700 (PDT)
Received: from localhost ([117.136.0.155])
        by smtp.gmail.com with ESMTPSA id z66-20020a626545000000b0052d3a442760sm2218418pfb.161.2022.08.05.00.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 00:49:13 -0700 (PDT)
From:   Hawkins Jiawei <yin31149@gmail.com>
To:     syzbot+5f26f85569bd179c18ce@syzkaller.appspotmail.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc:     paskripkin@gmail.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        18801353760@163.com, Hawkins Jiawei <yin31149@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v5 2/2] net: refactor bpf_sk_reuseport_detach()
Date:   Fri,  5 Aug 2022 15:48:36 +0800
Message-Id: <68ea55d47f10ac8faa0d44e184a5ec00a9dd0409.1659676823.git.yin31149@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1659676823.git.yin31149@gmail.com>
References: <cover.1659676823.git.yin31149@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Refactor sk_user_data dereference using more generic function
__rcu_dereference_sk_user_data_with_flags(), which improve its
maintainability

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
---
 kernel/bpf/reuseport_array.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index e2618fb5870e..85fa9dbfa8bf 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -21,14 +21,11 @@ static struct reuseport_array *reuseport_array(struct bpf_map *map)
 /* The caller must hold the reuseport_lock */
 void bpf_sk_reuseport_detach(struct sock *sk)
 {
-	uintptr_t sk_user_data;
+	struct sock __rcu **socks;
 
 	write_lock_bh(&sk->sk_callback_lock);
-	sk_user_data = (uintptr_t)sk->sk_user_data;
-	if (sk_user_data & SK_USER_DATA_BPF) {
-		struct sock __rcu **socks;
-
-		socks = (void *)(sk_user_data & SK_USER_DATA_PTRMASK);
+	socks = __rcu_dereference_sk_user_data_with_flags(sk, SK_USER_DATA_BPF);
+	if (socks) {
 		WRITE_ONCE(sk->sk_user_data, NULL);
 		/*
 		 * Do not move this NULL assignment outside of
-- 
2.25.1

