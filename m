Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158656CD366
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 09:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjC2Hhq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 03:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjC2HhZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 03:37:25 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C168F1734
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:09 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eh3so59472861edb.11
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 00:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680075368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZN6ES45HsbP7J6z7pQ6tOacKZ75tcnoy08VBp4h/to=;
        b=NGyxcIDiY1PmJcwgfgo94nKcjacR8wNjHqFy8Hq7iht+ppH2KISX+KDrIf6yCZloM6
         033V3o9NPrIIAAJiQGiYA8jfh24/ndwgdb8XoiA/HFr/xgXE6OrqhFqCWJoiWkSwPEcr
         sYFVu1hFJR4FNQU/K3QxPn+mELykpOMl8WGG/POY/M0CC07kE7j/ClDXK3G8dMlIhWV+
         Zj5iB63pkP9MdMHiyXuVWiLp69mY6gQ9rcjNJi6iXRvSJIYumQ643UVyr7W01RNdt+Zi
         +k1Rbp1+y1BGql708E1OPnzlyxFMzgL4EpmZnV+JxepK8tll94xDw3xgPrzb4T4fMJVF
         vHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680075368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZN6ES45HsbP7J6z7pQ6tOacKZ75tcnoy08VBp4h/to=;
        b=ceJx7AG0cc4dmpnZRZ+/VNe/nDSdcfQa4Hg7R6tOUSJvjxoCBj4rPIH6DEfr2qW3zj
         EjON47Fa+Yh82/Op2vPCIUiws89CoKHcBRBbeceLnywNTeed0nhf4qjV7kIQmTILAayz
         hVJnVujiethyPJv/LHi3hdfKSnHhEBFf9oE4AUtaWznmUarj6NhI93TIZFE+znliA+Ur
         xFpum+QCyg/lbmTBvak48kLsSQ2R9KIMNrqqPRakBXp9TSfciQeyXTG7NCgZk43e+9CQ
         fCjS3nmFyEo234nN+NxflawM8MMybXPGOVUsRvjSg8SX4zuCdg5YuPEO5aSJN8fMkxTB
         q2dA==
X-Gm-Message-State: AAQBX9estw+iWtNxO6LiAweWBAKBHEbP2FcpCn5a5De204+SGjYfx5wc
        MaT0dtrxyxj+feBJAwN1kMwIHg/NAjqo04PkQ0k=
X-Google-Smtp-Source: AKy350ZLXFT9SwqB+wuOYtshVaPkEpE+DGG3emGaSHadmsCHnT7cS6bCwOIrtMKP3vILQRRG/qgwDA==
X-Received: by 2002:a17:906:32d5:b0:926:c9e4:f843 with SMTP id k21-20020a17090632d500b00926c9e4f843mr19058317ejk.59.1680075367775;
        Wed, 29 Mar 2023 00:36:07 -0700 (PDT)
Received: from localhost.localdomain ([45.35.56.2])
        by smtp.gmail.com with ESMTPSA id g10-20020a17090670ca00b0093b8c0952e4sm9719041ejk.219.2023.03.29.00.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 00:36:07 -0700 (PDT)
From:   Yixin Shen <bobankhshen@gmail.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, song@kernel.org, yhs@fb.com,
        bobankhshen@gmail.com
Subject: [PATCH bpf-next v2 1/2] bpf: allow a TCP CC to write app_limited
Date:   Wed, 29 Mar 2023 07:35:57 +0000
Message-Id: <20230329073558.8136-2-bobankhshen@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230329073558.8136-1-bobankhshen@gmail.com>
References: <20230329073558.8136-1-bobankhshen@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

A CC that implements tcp_congestion_ops.cong_control() should be able to
write app_limited. A built-in CC or one from a kernel module is already
able to write to this member of struct tcp_sock.
For a BPF program, write access has not been allowed, yet.

Signed-off-by: Yixin Shen <bobankhshen@gmail.com>
---
 net/ipv4/bpf_tcp_ca.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
index e8b27826283e..ea21c96c03aa 100644
--- a/net/ipv4/bpf_tcp_ca.c
+++ b/net/ipv4/bpf_tcp_ca.c
@@ -113,6 +113,9 @@ static int bpf_tcp_ca_btf_struct_access(struct bpf_verifier_log *log,
 	case offsetof(struct tcp_sock, ecn_flags):
 		end = offsetofend(struct tcp_sock, ecn_flags);
 		break;
+	case offsetof(struct tcp_sock, app_limited):
+		end = offsetofend(struct tcp_sock, app_limited);
+		break;
 	default:
 		bpf_log(log, "no write support to tcp_sock at off %d\n", off);
 		return -EACCES;
-- 
2.25.1

