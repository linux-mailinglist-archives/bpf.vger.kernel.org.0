Return-Path: <bpf+bounces-2782-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A306733E61
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 07:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B7A31C21034
	for <lists+bpf@lfdr.de>; Sat, 17 Jun 2023 05:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10F623D3;
	Sat, 17 Jun 2023 05:28:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6376B1C16
	for <bpf@vger.kernel.org>; Sat, 17 Jun 2023 05:28:17 +0000 (UTC)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A6544B7
	for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 22:28:03 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-57015b368c3so16842957b3.3
        for <bpf@vger.kernel.org>; Fri, 16 Jun 2023 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686979682; x=1689571682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=EiaL4osYN2o3e4iIQmRmNutP8CMbYCpegW6HpdRnUpOvB1tKSgh4nNhsNPJHIDDC5G
         jQaLadL8cT8aHkruJda+9XClLpn4EG5wbT1Mhpujg1hRqFz5rJjfoaFqpqPJgfosHTvZ
         GCVzrIXuYymBriY7uFrISCSdTE7Gpxy8sShATojfj1N4vJOG/imyTev/FcmB8TAiLtmX
         v/5QrFfXkH1ktLP8UpRW2lJV52GaKgQ8Y1u0pgKG1r3MXdT4e8pqSScCJpV61zRStcLy
         r2hy38k7kzlFakZrSzC9SXsR5BBtN4DGF8qDiYu+HYq14ybSiSH+RSRLu1tYe/OBxB7a
         ri6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686979682; x=1689571682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydxT33j6K/rQl2yqLMUva8O7XS2nS8xNlZ0E1sIDwPQ=;
        b=cfyKKUHUZw/5rAmW+LwAytA8gjQEWLhbSL1UXqef2uIGAWelDbPu/OdmUtvaRUCUtl
         h5p1HZfdcq6947FcnffJpzVMIS9VLrJyi4PNoN4ZZy5CzORTjxa8MxiqRflwMJZRTEzY
         Ecq+XdDqH9l847A9UV16Evqz9TYvZfZC5+CkAW24z+MpSwrw9PIPClOkl2i7crGExvcS
         CS3ZpKy0nbLZl4iQ7VbLSmCWCkEsNn7ITp2GXMXoPj0Tt/ofSUfKQzDUyryk+hR1FBHq
         WpXxF6b+aoFP4KDX4hP95+vK5R1okShSj3+x7tB4czr48GxS5F1sZ9Em9Lb0IhH1Fvl8
         Fb8Q==
X-Gm-Message-State: AC+VfDy+jEjj54aaAwMVpqQRAnlccYG1/59CfEMqKiLHmuxipBbxvqIT
	DSz/Z2HWnGo49m3eQ/3n571wnVOdSF8=
X-Google-Smtp-Source: ACHHUZ4bX7F1ybeouQsZZGWK5xwUDLugzV48KmyM3U789cA3MzbtSzDGLQFCUnWLOwyxA4xL9O/Zuw==
X-Received: by 2002:a81:6e89:0:b0:568:e6d9:7c1a with SMTP id j131-20020a816e89000000b00568e6d97c1amr3906169ywc.4.1686979682193;
        Fri, 16 Jun 2023 22:28:02 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a9ca:115f:d699:728])
        by smtp.gmail.com with ESMTPSA id c123-20020a0dda81000000b0056d0709e0besm4133312ywe.129.2023.06.16.22.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 22:28:01 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
X-Google-Original-From: Kui-Feng Lee <kuifeng@meta.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	daniel@iogearbox.net
Cc: Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v2 1/2] net: bpf: Always call BPF cgroup filters for egress.
Date: Fri, 16 Jun 2023 22:27:55 -0700
Message-Id: <20230617052756.640916-2-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230617052756.640916-1-kuifeng@meta.com>
References: <20230617052756.640916-1-kuifeng@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Always call BPF filters if CGROUP BPF is enabled for EGRESS without
checking skb->sk against sk.

The filters were called only if skb is owned by the sock that the
skb is sent out through.  In another words, skb->sk should point to
the sock that it is sending through its egress.  However, the filters would
miss SYNACK skbs that they are owned by a request_sock but sent through
the listening sock, that is the socket listening incoming connections.
This is an unnecessary restrict.

Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
---
 include/linux/bpf-cgroup.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf-cgroup.h b/include/linux/bpf-cgroup.h
index 57e9e109257e..e656da531f9f 100644
--- a/include/linux/bpf-cgroup.h
+++ b/include/linux/bpf-cgroup.h
@@ -199,7 +199,7 @@ static inline bool cgroup_bpf_sock_enabled(struct sock *sk,
 #define BPF_CGROUP_RUN_PROG_INET_EGRESS(sk, skb)			       \
 ({									       \
 	int __ret = 0;							       \
-	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk && sk == skb->sk) { \
+	if (cgroup_bpf_enabled(CGROUP_INET_EGRESS) && sk) {		       \
 		typeof(sk) __sk = sk_to_full_sk(sk);			       \
 		if (sk_fullsock(__sk) &&				       \
 		    cgroup_bpf_sock_enabled(__sk, CGROUP_INET_EGRESS))	       \
-- 
2.34.1


