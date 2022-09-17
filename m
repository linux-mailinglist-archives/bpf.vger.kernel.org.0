Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93F55BB74F
	for <lists+bpf@lfdr.de>; Sat, 17 Sep 2022 10:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIQInb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 17 Sep 2022 04:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiIQIna (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 17 Sep 2022 04:43:30 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F5D33E01;
        Sat, 17 Sep 2022 01:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qu8I8
        YuJXw2M3hcQgEmGhnOxzHzTnOpfQLL1aurP3gI=; b=GKYo1wnVQ9W7++m/gxDhy
        h5+k3MWm4MhGqdN/BMT+hvTTZsDZmxhQJcOQ8/kBu6Gkyoqo+cJ3td6wu6Za3UCc
        ZTvCJ6ALUpgNOjaNT9grYpjZB9JlwRBF+9tQZgYHYMneTr636qO2J92LxjQfs7zw
        qLInSOkfE/Kq/Ffj3b7KQE=
Received: from DESKTOP-CE2KKHI.localdomain (unknown [124.160.210.227])
        by smtp4 (Coremail) with SMTP id HNxpCgD3TtOKiCVj9QEZdw--.2977S2;
        Sat, 17 Sep 2022 16:42:52 +0800 (CST)
From:   williamsukatube@163.com
To:     martin.lau@linux.dev, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, William Dean <williamsukatube@163.com>
Subject: [PATCH -next] bpf: simplify code in btf_parse_hdr
Date:   Sat, 17 Sep 2022 16:42:48 +0800
Message-Id: <20220917084248.3649-1-williamsukatube@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3TtOKiCVj9QEZdw--.2977S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWkur45Jw13KF4fAF4xWFg_yoWfKFXE9r
        18uanxur4DJFWFyw1UAa4IvFyjqF4vgF9rZwsFvrWkCw15Gw45Crn8WFsakFWvqws7tF9r
        GFs8Cas0yF4fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_rb13UUUUU==
X-Originating-IP: [124.160.210.227]
X-CM-SenderInfo: xzlozx5dpv3yxdwxuvi6rwjhhfrp/xtbB0Ax-g2Esr7zWwAAAso
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: William Dean <williamsukatube@163.com>

It could directly return 'btf_check_sec_info' to simplify code.

Signed-off-by: William Dean <williamsukatube@163.com>
---
 kernel/bpf/btf.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7e64447659f3..80eda86ddfce 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -4854,7 +4854,6 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 	u32 hdr_len, hdr_copy, btf_data_size;
 	const struct btf_header *hdr;
 	struct btf *btf;
-	int err;

 	btf = env->btf;
 	btf_data_size = btf->data_size;
@@ -4911,11 +4910,7 @@ static int btf_parse_hdr(struct btf_verifier_env *env)
 		return -EINVAL;
 	}

-	err = btf_check_sec_info(env, btf_data_size);
-	if (err)
-		return err;
-
-	return 0;
+	return btf_check_sec_info(env, btf_data_size);
 }

 static int btf_check_type_tags(struct btf_verifier_env *env,
--
2.25.1

