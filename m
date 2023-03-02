Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F1D6A7AC9
	for <lists+bpf@lfdr.de>; Thu,  2 Mar 2023 06:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjCBFcX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 00:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCBFcX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 00:32:23 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8584AFE4
        for <bpf@vger.kernel.org>; Wed,  1 Mar 2023 21:32:22 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id cp12so8646387pfb.5
        for <bpf@vger.kernel.org>; Wed, 01 Mar 2023 21:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677735141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BV6p+c0ND44fD4nkRCAK8d/DVpgj2+urj5MTwT+JjOM=;
        b=T+nzTVjyo09aNiyNbJctYvolBZU32eeT9grBFK6bpsCC468q0le+hrzvjpDARMJbvn
         k4Fwt0DJrB7543gE1bgOqiaGTthGi35gnr9iwscmChvYMiqx5VyC4MtC/RUIWSK/vi9H
         /AVDWGBFEhIyVtF4frFvtpKLN3CG3Sd0SZJ5s/kHUrzsdFbvMWIpGMEp/BPltLgFiES5
         +pabvWuDeJH/a2+w25Xdql57rbRQDPl81DQzl8fHdtmcecf0vAToudzMbqESnBv6tlFR
         tEpysnCGFGowC8O/yqnxHLfBsGvZFhCSqWfmANzer5CdxAWAit5hAf/z6tISU3LSsYQa
         KGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677735141;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BV6p+c0ND44fD4nkRCAK8d/DVpgj2+urj5MTwT+JjOM=;
        b=wbLQUoJjxiha0W6Rd8PZWU76pjWa4BIzgejA04hKsIP7uIi/aUQ1sdL4ngQ2VB1t2q
         dFUgXk/qnGZDdypdquyoeHOU3mBCUUdGWzi8F7j45LPpGuf362Agyz/4MTB1kb5Otk8o
         2mzI3ctC8GLGnBWuxy4Jq3W++d4RpdZpqICSIsc6D9M0lIMn3mUqL0A+D96/EA+n5fLW
         aBqNej2IJdjUV3BHsM4xmjVg5Vn87My/ijjR48RCu18E8hxJ3P7BtZkgnShHPTT80shz
         uLzLUOjvMfMYe0TLm5L2mV++5H7sgBMPO8GURQs5OvsKhhw2WEm8YTW09jNssqIszE9D
         AYYQ==
X-Gm-Message-State: AO0yUKX8LBoMCvbX8sqWWa6GSWhJztPFnR8manxqTlvvQRC1QgM0y2WL
        OU99dWXnI/cc7TGTLnWftzk2Go4tIxM=
X-Google-Smtp-Source: AK7set8pCGXQBtzkwNynvfJSkfq13SxyWPeo856tIGwafxscSpUWwOcVnj47W9WZ+asfYFg4yvyt3g==
X-Received: by 2002:aa7:96f9:0:b0:5a8:a56c:6144 with SMTP id i25-20020aa796f9000000b005a8a56c6144mr7563433pfq.19.1677735141253;
        Wed, 01 Mar 2023 21:32:21 -0800 (PST)
Received: from gatsby.corp.tfbnw.net (75-172-126-232.tukw.qwest.net. [75.172.126.232])
        by smtp.gmail.com with ESMTPSA id i20-20020aa78d94000000b0058bc60dd98dsm8792535pfr.23.2023.03.01.21.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 21:32:20 -0800 (PST)
From:   Joanne Koong <joannelkoong@gmail.com>
To:     bpf@vger.kernel.org
Cc:     martin.lau@kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, Joanne Koong <joannelkoong@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 bpf-next] bpf: Fix bpf_dynptr_slice{_rdwr} to return NULL instead of 0
Date:   Wed,  1 Mar 2023 21:30:14 -0800
Message-Id: <20230302053014.1726219-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change bpf_dynptr_slice and bpf_dynptr_slice_rdwr to return NULL instead
of 0, in accordance with the codebase guidelines.

Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 kernel/bpf/helpers.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 58431a92bb65..de9ef8476e29 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2227,11 +2227,11 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	int err;
 
 	if (!ptr->data)
-		return 0;
+		return NULL;
 
 	err = bpf_dynptr_check_off_len(ptr, offset, len);
 	if (err)
-		return 0;
+		return NULL;
 
 	type = bpf_dynptr_get_type(ptr);
 
@@ -2252,7 +2252,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	}
 	default:
 		WARN_ONCE(true, "unknown dynptr type %d\n", type);
-		return 0;
+		return NULL;
 	}
 }
 
@@ -2300,7 +2300,7 @@ __bpf_kfunc void *bpf_dynptr_slice_rdwr(const struct bpf_dynptr_kern *ptr, u32 o
 					void *buffer, u32 buffer__szk)
 {
 	if (!ptr->data || bpf_dynptr_is_rdonly(ptr))
-		return 0;
+		return NULL;
 
 	/* bpf_dynptr_slice_rdwr is the same logic as bpf_dynptr_slice.
 	 *
-- 
2.34.1

