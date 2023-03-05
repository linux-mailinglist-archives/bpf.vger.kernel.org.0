Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C98246AAF9D
	for <lists+bpf@lfdr.de>; Sun,  5 Mar 2023 13:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjCEMqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 5 Mar 2023 07:46:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCEMqi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 5 Mar 2023 07:46:38 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CC4F76F
        for <bpf@vger.kernel.org>; Sun,  5 Mar 2023 04:46:37 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id b12so1203014ilf.9
        for <bpf@vger.kernel.org>; Sun, 05 Mar 2023 04:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678020397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=SpgrIyZOj4mo5eTEmeGr8zWeeteATtN+L6UP9OW3VaBEaC8K7fh0htxidOGPXikbmW
         ZJUWFItHN8RQ55mKJIvxjouHdF/DxqNm/aBiyWqTL5myC9fWwfI3J0oDEV9tOSrHVtzl
         /0+2Z+toYPR1iHVcAoF00iGG9SD8AOhKdr6U/U4dAZT4rj3+0T918o7G2MOS06DGr7Kf
         bVbK7g8I9nkE43s2afwtgRAYmsErv2CvH6W0p2DxLMFc4lZUwMwWHJU3kx0+Q82uayAA
         QrXlag+MYfsrVfi+AdBsGJcMm0f/nMsaEDP4+Us32argvX6PXAiVp7w6PVt5t+kum9Sb
         YLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678020397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrmMexioGuwPjZT+tUM26QmTb0IQCm4pElgfaJMzHrk=;
        b=ZHuwYmBVEHeNo/1ij3/iTA4EyvS2FErzVV57t9P6T+5FSoD8IbtEOSHmUiDMz2JZv+
         80FbcZpvYQuxOvCcPYIYYl9tX4/0MP1FArqc2CM4Fg5IBg+lmci6JVLFUNriQRoNhdkh
         dFgKwwhtC8PW9t7J3dWTVyMPlSWsIUQ/9R0Tk7GJdQefbdpjj7RirMKCaKQ116ho0lm+
         zhNEKU7a8F6u/BIcNArB0VCFf9LCT72RgzmDKE3H88WKEYQd7LLy4u5w+IrTgz6lAAGV
         1utozM01fHJc5Y5OM7t0FWdw6qR2HX1k2x/TaT5NS6pZiuyI9HyHQdzWPp+2G5julEuP
         J3wg==
X-Gm-Message-State: AO0yUKXe1s8MxfcFXI0kuNvnpZRZl5RqElDf/SweNv6gCc+3BjvG5z15
        o544Rx0XQa4jcBwx3VMs+Y6eq6it+e2OJxDtkYk=
X-Google-Smtp-Source: AK7set9E+epzKirGcZEhK/9LXGqftD6EfDp2HvnR5Pfx+biu2Yn+WGTJOpbKSlVsttm5NhxaMqfK+w==
X-Received: by 2002:a05:6e02:20e6:b0:316:e39f:13f2 with SMTP id q6-20020a056e0220e600b00316e39f13f2mr6843502ilv.12.1678020397219;
        Sun, 05 Mar 2023 04:46:37 -0800 (PST)
Received: from vultr.guest ([107.191.51.243])
        by smtp.gmail.com with ESMTPSA id v6-20020a02b906000000b003c4f6400c78sm2269629jan.33.2023.03.05.04.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 04:46:36 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com, houtao1@huawei.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4 13/18] bpf: local_storage memory usage
Date:   Sun,  5 Mar 2023 12:46:10 +0000
Message-Id: <20230305124615.12358-14-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230305124615.12358-1-laoar.shao@gmail.com>
References: <20230305124615.12358-1-laoar.shao@gmail.com>
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

A new helper is introduced to calculate local_storage map memory usage.
Currently the dynamically allocated elements are not counted, since it
will take runtime overhead in the element update or delete path. So
let's put it aside currently, and implement it in the future if the user
really needs it.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/local_storage.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index e90d9f6..a993560 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -446,6 +446,12 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 	rcu_read_unlock();
 }
 
+static u64 cgroup_storage_map_usage(const struct bpf_map *map)
+{
+	/* Currently the dynamically allocated elements are not counted. */
+	return sizeof(struct bpf_cgroup_storage_map);
+}
+
 BTF_ID_LIST_SINGLE(cgroup_storage_map_btf_ids, struct,
 		   bpf_cgroup_storage_map)
 const struct bpf_map_ops cgroup_storage_map_ops = {
@@ -457,6 +463,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 	.map_delete_elem = cgroup_storage_delete_elem,
 	.map_check_btf = cgroup_storage_check_btf,
 	.map_seq_show_elem = cgroup_storage_seq_show_elem,
+	.map_mem_usage = cgroup_storage_map_usage,
 	.map_btf_id = &cgroup_storage_map_btf_ids[0],
 };
 
-- 
1.8.3.1

