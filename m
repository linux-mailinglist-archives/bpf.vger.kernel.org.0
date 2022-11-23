Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820996360C2
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 14:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbiKWN7E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 08:59:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbiKWN6o (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 08:58:44 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855943AEB;
        Wed, 23 Nov 2022 05:52:54 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id i9so2889252qkl.5;
        Wed, 23 Nov 2022 05:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ru2/Qo/Fi2mBuBD/tnfTwcQucjWsxv7vBNnif4KKxRg=;
        b=Irq8G/TbUp1OPHCe0S0cViZvzY0QkvV12l6XN9jOCRUDRKIcpR+VzomCErm49MN08v
         h5gRzTg1qp9GJrvlWBggvMxQ9uUozo+ER9Ef7HQqYZYCBbaABj4xBYCQ1OTIB3Vmj350
         11bVR24Mza84+vJfSS6TmpVUgCmUwPTCnxJfB+aSC0xGQ5WUq+cZfZr/fTxnvYkH+5YH
         sW0wkHK1XxnLrL34CNkEwlgiqrot3A4Ri5ZLAfYlg9GRrqSCNJoX2MHpFkcLbkNAB6Az
         itu9j/m0S4r99E0nY4d9qsRYSXfKsuD66h2X6WHNaZ1xN6W92KMu7Fdr742elPFC3IIa
         rFjg==
X-Gm-Message-State: ANoB5pmoLjq4/E8ByoNxc+PWTPZgBOyIumdZD1w32D6lxANnqMH8KrKH
        m0QHplv7ThAdaVlCTLZANYgi7Vhzn4j0MXl4
X-Google-Smtp-Source: AA0mqf7tsx4XkmtL07zI1j84rNZsR2zRGWZdsl/oWLCKxBnJz55LkZQWsszpShzauicMzCQJmZ1yDQ==
X-Received: by 2002:a05:620a:561:b0:6fa:4b0b:d08f with SMTP id p1-20020a05620a056100b006fa4b0bd08fmr25515242qkp.488.1669211573582;
        Wed, 23 Nov 2022 05:52:53 -0800 (PST)
Received: from localhost (c-24-15-214-156.hsd1.il.comcast.net. [24.15.214.156])
        by smtp.gmail.com with ESMTPSA id d7-20020a05620a240700b006e702033b15sm12525280qkn.66.2022.11.23.05.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:52:53 -0800 (PST)
From:   David Vernet <void@manifault.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, jolsa@kernel.org,
        haoluo@google.com, tj@kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH bpf-next] bpf: Don't use idx variable when registering kfunc dtors
Date:   Wed, 23 Nov 2022 07:52:53 -0600
Message-Id: <20221123135253.637525-1-void@manifault.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In commit fda01efc6160 ("bpf: Enable cgroups to be used as kptrs"), I
added an 'int idx' variable to kfunc_init() which was meant to
dynamically set the index of the btf id entries of the
'generic_dtor_ids' array. This was done to make the code slightly less
brittle as the struct cgroup * kptr kfuncs such as bpf_cgroup_aquire()
are compiled out if CONFIG_CGROUPS is not defined. This, however, causes
an lkp build warning:

>> kernel/bpf/helpers.c:2005:40: warning: multiple unsequenced
   modifications to 'idx' [-Wunsequenced]
	.btf_id       = generic_dtor_ids[idx++],

Fix the warning by just hard-coding the indices.

Fixes: fda01efc6160 ("bpf: Enable cgroups to be used as kptrs")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/bpf/helpers.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e4e9db301db5..da2681ebb7c3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2019,16 +2019,16 @@ static const struct btf_kfunc_id_set common_kfunc_set = {
 
 static int __init kfunc_init(void)
 {
-	int ret, idx = 0;
+	int ret;
 	const struct btf_id_dtor_kfunc generic_dtors[] = {
 		{
-			.btf_id       = generic_dtor_ids[idx++],
-			.kfunc_btf_id = generic_dtor_ids[idx++]
+			.btf_id       = generic_dtor_ids[0],
+			.kfunc_btf_id = generic_dtor_ids[1]
 		},
 #ifdef CONFIG_CGROUPS
 		{
-			.btf_id       = generic_dtor_ids[idx++],
-			.kfunc_btf_id = generic_dtor_ids[idx++]
+			.btf_id       = generic_dtor_ids[2],
+			.kfunc_btf_id = generic_dtor_ids[3]
 		},
 #endif
 	};
-- 
2.38.1

