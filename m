Return-Path: <bpf+bounces-2642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C82731CAD
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 17:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0939281394
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8617FE7;
	Thu, 15 Jun 2023 15:30:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7350C17AC7
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 15:30:00 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CD2D59
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:29:34 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so17802795e9.1
        for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686842964; x=1689434964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DmTVCcDzgdb0rJxfE0Wgi1MTtd65tPNrOoDRMDRx3gQ=;
        b=ZWKJCPeyY3OAvLfQ/Akuz48aKCvTBQTX/njIi7+Ped9HxmetqggAQuX8AfhzbOMrMB
         0SjxhsxeYOEEX9VqUD5ASxl4hgU9Nz2oqcj/uFxTGO7cYvDZyEyoyjgYsc9H67ECc5K4
         h6ydnE3ghYlThrijidU2Apjum47pypqMDNRd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686842964; x=1689434964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmTVCcDzgdb0rJxfE0Wgi1MTtd65tPNrOoDRMDRx3gQ=;
        b=E2GxDmy366xX7iQ+UIGRNaDuINB/XIGLtpWOu2ZKcJOC9Q5yJswc6n085UFM5Z6gPD
         wfGl6BM7+uSaUCyePX8bkNPdTeNY1I+W7XiAhs2WpVlXhTK+NsQyPqi1OQVyH2UKA/Oj
         8UyDeYYhe9buOFk7xRDLcZOQiqIjrjbBT6IQNUYGqKlCT6+Dy+fLvy9RgUqORX7n1EcV
         T4CfENvHNpGHXPKSu+my/fRX6gCdebRXS3EqCF1nSTiYVF8bUFeMFX9Lw/8v6QsKM9/1
         Ai9O17vG7NU/cJUi9kDi95hjbS0rFLilcWE2UvjAqBhPy3H6+WgMyLnGE4Ne1rfptJe3
         MhAA==
X-Gm-Message-State: AC+VfDzCGJ15n8JuD4wmYsD0UQF1GNpGQtHnGYdOr+0DEAoadocnLAo6
	/sTlbK75L+AGQOCUQbIqxdEW4g==
X-Google-Smtp-Source: ACHHUZ7if8/QjJGrlFQPl6PUziSmXH/MThCln20vJrrNGAbg26qZf+cyoV/v/dt8J17ZWjgWvauPdA==
X-Received: by 2002:a05:600c:2212:b0:3f6:cfc7:8bc7 with SMTP id z18-20020a05600c221200b003f6cfc78bc7mr12113985wml.17.1686842963710;
        Thu, 15 Jun 2023 08:29:23 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:7ec7:7f97:45af:3056])
        by smtp.gmail.com with ESMTPSA id k1-20020a5d6e81000000b0030e5ccaec84sm21510469wrz.32.2023.06.15.08.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 08:29:23 -0700 (PDT)
From: Florent Revest <revest@chromium.org>
To: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lirongqing@baidu.com,
	wangli39@baidu.com,
	zhangyu31@baidu.com,
	daniel@iogearbox.net,
	ast@kernel.org,
	kpsingh@kernel.org,
	Florent Revest <revest@chromium.org>,
	stable@vger.kernel.org
Subject: [PATCH nf] netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
Date: Thu, 15 Jun 2023 17:29:18 +0200
Message-ID: <20230615152918.3484699-1-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If register_nf_conntrack_bpf() fails (for example, if the .BTF section
contains an invalid entry), nf_conntrack_init_start() calls
nf_conntrack_helper_fini() as part of its cleanup path and
nf_ct_helper_hash gets freed.

Further netfilter modules like netfilter_conntrack_ftp don't check
whether nf_conntrack initialized correctly and call
nf_conntrack_helpers_register() which accesses the freed
nf_ct_helper_hash and causes a uaf.

This patch guards nf_conntrack_helper_register() from accessing
freed/uninitialized nf_ct_helper_hash maps and fixes a boot-time
use-after-free.

Cc: stable@vger.kernel.org
Fixes: 12f7a505331e ("netfilter: add user-space connection tracking helper infrastructure")
Signed-off-by: Florent Revest <revest@chromium.org>
---
 net/netfilter/nf_conntrack_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index 0c4db2f2ac43..f22691f83853 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -360,6 +360,9 @@ int nf_conntrack_helper_register(struct nf_conntrack_helper *me)
 	BUG_ON(me->expect_class_max >= NF_CT_MAX_EXPECT_CLASSES);
 	BUG_ON(strlen(me->name) > NF_CT_HELPER_NAME_LEN - 1);
 
+	if (!nf_ct_helper_hash)
+		return -ENOENT;
+
 	if (me->expect_policy->max_expected > NF_CT_EXPECT_MAX_CNT)
 		return -EINVAL;
 
@@ -515,4 +518,5 @@ int nf_conntrack_helper_init(void)
 void nf_conntrack_helper_fini(void)
 {
 	kvfree(nf_ct_helper_hash);
+	nf_ct_helper_hash = NULL;
 }
-- 
2.41.0.162.gfafddb0af9-goog


