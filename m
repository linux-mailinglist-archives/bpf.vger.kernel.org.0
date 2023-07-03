Return-Path: <bpf+bounces-3881-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53D745F24
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 16:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4403A280DB0
	for <lists+bpf@lfdr.de>; Mon,  3 Jul 2023 14:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFA3100AC;
	Mon,  3 Jul 2023 14:52:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1B100A3
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 14:52:24 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDE1BE5C
	for <bpf@vger.kernel.org>; Mon,  3 Jul 2023 07:52:22 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso43658875e9.3
        for <bpf@vger.kernel.org>; Mon, 03 Jul 2023 07:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688395941; x=1690987941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+3KjuLBngLO3rai8mrqNkWZ2OBnCS0ojb/WfZfP0ytU=;
        b=KFYcQJIC/LHmqIQeVankvlb89fFhXYJ2u4CRhT6/pS3M2Mop+/IKcNS6tZ4P3Wel4B
         4812aItVGnJv3Opnl116QiQO7pXEjK6Fe0MXtMVzVAx03vxCOot9tHZcEF778K3ijkGZ
         8ehBVmANtCmTN66OCjq2uFuheE7ql4BEsAXiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688395941; x=1690987941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+3KjuLBngLO3rai8mrqNkWZ2OBnCS0ojb/WfZfP0ytU=;
        b=MS927zfTpT3cdOYoUGL48mjWVI0X1t49ataxMWAV7K4pE0WEPtreMt6GjviN4XFvxu
         IbyjAOzUwecHsrlnvcMdUOMXdQGRbB6ADfQEkGncZhaFVR9treaUVbwhXy5z5a9WBPRp
         divesQl0rOX/Q3/pE8UZ0snXmx+ODcCRulZPu8bMGmisAECG/zl/pr5fjKqCrP1f5RDC
         AjraUe9DMCD1P8svB+5VDrbwOybQOM1s6X2swS7iF4JpylXJruVgSZnuACapdMb9XNdC
         YcFaPajDygCU3scoQVOzAQsm/n6BUMiddtvzIlsk7SoJCQKrkr068elNDZ1YcAsyS8Ur
         CaKg==
X-Gm-Message-State: AC+VfDy8py6RtIgw3pgxoQv28sIvXQYR0wFMR0Rjo/LYSwsqWICOdJx3
	TSAsJ0jJHO9sKnMr+t1qoLG91Q==
X-Google-Smtp-Source: ACHHUZ7JLYiih/sZAgY31lyo8PL1r1xW+5cJuN3mzYzCpWVCujuece0APXkMinyxrAGdwGlWBqHPNw==
X-Received: by 2002:a7b:c38f:0:b0:3fb:a46c:7eac with SMTP id s15-20020a7bc38f000000b003fba46c7eacmr9214337wmj.7.1688395940886;
        Mon, 03 Jul 2023 07:52:20 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:34e3:ca8b:5d5c:2c66])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c028c00b003fbaade072dsm16878177wmk.23.2023.07.03.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 07:52:20 -0700 (PDT)
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
	kpsingh@kernel.org,
	stable@vger.kernel.org,
	Florent Revest <revest@chromium.org>
Subject: [PATCH nf v2] netfilter: conntrack: Avoid nf_ct_helper_hash uses after free
Date: Mon,  3 Jul 2023 16:52:16 +0200
Message-ID: <20230703145216.1096265-1-revest@chromium.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If nf_conntrack_init_start() fails (for example due to a
register_nf_conntrack_bpf() failure), the nf_conntrack_helper_fini()
clean-up path frees the nf_ct_helper_hash map.

When built with NF_CONNTRACK=y, further netfilter modules (e.g:
netfilter_conntrack_ftp) can still be loaded and call
nf_conntrack_helpers_register(), independently of whether nf_conntrack
initialized correctly. This accesses the nf_ct_helper_hash dangling
pointer and causes a uaf, possibly leading to random memory corruption.

This patch guards nf_conntrack_helper_register() from accessing a freed
or uninitialized nf_ct_helper_hash pointer and fixes possible
uses-after-free when loading a conntrack module.

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
2.41.0.255.g8b1d071c50-goog


