Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFD26A45EB
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjB0PVP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjB0PVN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:13 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABD22A2D
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:09 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 130so3767285pgg.3
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEfQ8gbb6YM9AUGhgYD61SWx4aCRStdaB4FDTThUGWI=;
        b=GmOHWNfUOrQ2t1qOEgUxHOS/Y+sD2zO9zkiEtOKPLlXUd4t/fUfkQgCc7JLziQs6/U
         knmK7ZJXZZBSY0JG7v9ZmP/uJX/ZqRHMOc3dwaXO+n1FwTE00ND7fUayERYiADKCHOiQ
         JmtMK932vw2fr5uJvd0qKyvzdSyBSYV39JDabnJ1f5NuZPPOFsphjXkiqRJZ+KcXoWH0
         9QXcsfZicgPLeg0ScVdvLTImGIxtvgJ//+D9awCOrvf4S2Q/WjXm06rayLYOsqYkOicC
         Ospl0wvV21MLRU0giz0oF4Tk5jvGpa7+MeKZ/OP58pn/SIXU+AvOnT73w84Ga5eAHg6m
         iVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pEfQ8gbb6YM9AUGhgYD61SWx4aCRStdaB4FDTThUGWI=;
        b=eRx5sm0Eg5/gfRiyJLiowD4pHpX7a4fsH8f5QFJVtiStiZNm6dSMkRoqXecVt/RKyF
         fCyerMC7CXYGkUKBOsE65cogZUu5qJqlJs3R5GuzYrsLrBVwoqhgb7NEp/EPwGsBRMnZ
         nBmXDO6MbFWlZQExosIxuCgzd36CLkrnJMT/Fs0O17fWc7u9cYnI7yd0oEtWb3uTryWM
         EcksU8Adqbsb5TL126qcjDGTi2m5xJysl5VaGCYch3O+ZUdTQ+CemMvLd/j6017hD9Fa
         4DqpmHCxMAdXTpg8lagao7v8qWVae3+8UIc9mwF7iUog6UnRj14lLzduidzBc9Mbw4gD
         xk/w==
X-Gm-Message-State: AO0yUKXU8FRb4TFmSR2Vq6VvX7bBho3Nby2lKKzjDxE3qkY0fdC2n5ei
        dlo9jrkcwyvpsxALeuXeo8WO2jvuwjcUBOKCvIA=
X-Google-Smtp-Source: AK7set+cd8HA7AkH+09OCnifAFyYuuoM9iTcyNGmr3u/JXN2szP6b11Op6IJWrufhMAYiuv1Bf4Hpw==
X-Received: by 2002:a05:6a00:17a3:b0:5a8:4ae7:25d5 with SMTP id s35-20020a056a0017a300b005a84ae725d5mr11239192pfg.8.1677511268822;
        Mon, 27 Feb 2023 07:21:08 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:08 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 07/18] bpf: ringbuf memory usage
Date:   Mon, 27 Feb 2023 15:20:21 +0000
Message-Id: <20230227152032.12359-8-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230227152032.12359-1-laoar.shao@gmail.com>
References: <20230227152032.12359-1-laoar.shao@gmail.com>
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

A new helper ringbuf_map_mem_usage() is introduced to calculate ringbuf
memory usage.

The result as follows,
- before
15: ringbuf  name count_map  flags 0x0
        key 0B  value 0B  max_entries 65536  memlock 0B

- after
15: ringbuf  name count_map  flags 0x0
        key 0B  value 0B  max_entries 65536  memlock 78424B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/ringbuf.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
index 80f4b4d..2bbf6e2 100644
--- a/kernel/bpf/ringbuf.c
+++ b/kernel/bpf/ringbuf.c
@@ -336,6 +336,23 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	return 0;
 }
 
+static u64 ringbuf_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_ringbuf_map *rb_map;
+	struct bpf_ringbuf *rb;
+	int nr_data_pages;
+	int nr_meta_pages;
+	u64 usage = sizeof(struct bpf_ringbuf_map);
+
+	rb_map = container_of(map, struct bpf_ringbuf_map, map);
+	rb = rb_map->rb;
+	usage += (u64)rb->nr_pages << PAGE_SHIFT;
+	nr_meta_pages = RINGBUF_PGOFF + RINGBUF_POS_PAGES;
+	nr_data_pages = map->max_entries >> PAGE_SHIFT;
+	usage += (nr_meta_pages + 2 * nr_data_pages) * sizeof(struct page *);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(ringbuf_map_btf_ids, struct, bpf_ringbuf_map)
 const struct bpf_map_ops ringbuf_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -347,6 +364,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &ringbuf_map_btf_ids[0],
 };
 
@@ -361,6 +379,7 @@ static __poll_t ringbuf_map_poll_user(struct bpf_map *map, struct file *filp,
 	.map_update_elem = ringbuf_map_update_elem,
 	.map_delete_elem = ringbuf_map_delete_elem,
 	.map_get_next_key = ringbuf_map_get_next_key,
+	.map_mem_usage = ringbuf_map_mem_usage,
 	.map_btf_id = &user_ringbuf_map_btf_ids[0],
 };
 
-- 
1.8.3.1

