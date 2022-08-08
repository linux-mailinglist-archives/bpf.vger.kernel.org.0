Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2558CA27
	for <lists+bpf@lfdr.de>; Mon,  8 Aug 2022 16:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbiHHOI0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243282AbiHHOIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 10:08:16 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB2FD1C
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 07:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id AAE7DCE1107
        for <bpf@vger.kernel.org>; Mon,  8 Aug 2022 14:08:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA17C433B5;
        Mon,  8 Aug 2022 14:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659967691;
        bh=tNzc71raX5o7gseJh9tni2LdxYhM88jj6NK+OdwaOT8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bnBH4eAnk5fMLcqilSvK9/DRJr1oW1fGp5e+EeASyUt5bi8Co107RDly3zd/8D6QV
         SGcorBQCOqNeq2R7LSEIcAaJoa3T90IjExHEg0WD8Ob4mLrgpGAKpfdcnu20ixl89A
         HV+ojE185+xg11ANlFsInAAnPiQy3/NcAs3XGC4RhLeo90EXuLSyA5wMqgEf+4mPqx
         Z7g3DhlMBMEAr870lJmeChEYCsLm+Y0DGeLQF5d45F3HdffifWz72aIdWL/QNOKb2y
         pxbd88LiZbLIYexOgMi94MhzNuulU7Gia54T6zDkIiaCFKkpHnlPxw3SQpW2EBqHBa
         AXGhtmJ5XLLPQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [RFC PATCH bpf-next 09/17] bpf: Factor bpf_trampoline_put function
Date:   Mon,  8 Aug 2022 16:06:18 +0200
Message-Id: <20220808140626.422731-10-jolsa@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808140626.422731-1-jolsa@kernel.org>
References: <20220808140626.422731-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factoring bpf_trampoline_put function and adding new
__bpf_trampoline_put function without locking trampoline_mutex.

It will be needed in following changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 15801f6c5071..b6b57aa09364 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -928,22 +928,19 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 	return tr;
 }
 
-void bpf_trampoline_put(struct bpf_trampoline *tr)
+static void __bpf_trampoline_put(struct bpf_trampoline *tr)
 {
 	int i;
 
-	if (!tr)
-		return;
-	mutex_lock(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
-		goto out;
+		return;
 	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 
 	for (i = 0; i < BPF_TRAMP_MAX; i++) {
 		if (!tr->progs_array[i])
 			continue;
 		if (WARN_ON_ONCE(!bpf_prog_array_is_empty(tr->progs_array[i])))
-			goto out;
+			return;
 	}
 
 	/* This code will be executed even when the last bpf_tramp_image
@@ -958,7 +955,14 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 		kfree(tr->fops);
 	}
 	kfree(tr);
-out:
+}
+
+void bpf_trampoline_put(struct bpf_trampoline *tr)
+{
+	if (!tr)
+		return;
+	mutex_lock(&trampoline_mutex);
+	__bpf_trampoline_put(tr);
 	mutex_unlock(&trampoline_mutex);
 }
 
-- 
2.37.1

