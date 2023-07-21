Return-Path: <bpf+bounces-5577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772375BCD6
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 05:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A6C282130
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 03:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F07F9;
	Fri, 21 Jul 2023 03:32:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5807F
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 03:32:51 +0000 (UTC)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE7D1BF7;
	Thu, 20 Jul 2023 20:32:49 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VnsoRWg_1689910358;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0VnsoRWg_1689910358)
          by smtp.aliyun-inc.com;
          Fri, 21 Jul 2023 11:32:45 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: paul@paul-moore.com
Cc: stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	keescook@chromium.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	selinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	bpf@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] selinux: Use NULL for pointers
Date: Fri, 21 Jul 2023 11:32:36 +0800
Message-Id: <20230721033236.42689-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Replace integer constants with NULL.

security/selinux/hooks.c:251:41: warning: Using plain integer as NULL pointer.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5958
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/selinux/hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 62072b63b19b..d0818a338fa8 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -248,7 +248,7 @@ static void ad_net_init_from_iif(struct common_audit_data *ad,
 				 struct lsm_network_audit *net,
 				 int ifindex, u16 family)
 {
-	__ad_net_init(ad, net, ifindex, 0, family);
+	__ad_net_init(ad, net, ifindex, NULL, family);
 }
 
 /*
-- 
2.20.1.7.g153144c


