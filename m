Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36CEF6A45F0
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjB0PVg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbjB0PVb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:31 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E5422A17
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id p6so6220261plf.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=dr/V9d8Xp6J4y4aT6dXDbtYUZw60I5ggq3da0gVZG+vYcilYZBGI7/GNpwkhmQ0Y0C
         hh6Pc+AdZYva4FCoeV9xhsRAiOlh8+Bl7XDp93hnAGKTgHWR57oCXHKWqeadrZ3B2LXV
         htkSH5SzHvYY9eCQZR4HXuyaO9+qNTEUWU7oY0MtFbVVVRmzhSZC4d/bN5up4BYXf6FF
         SzELOoibBmXFZINNHjdAyxOlFEB2ocX0Y0QTtO+dWs8gIUlJQN1jOVCjQzGjYW1SKX0a
         wfi2X5sngNWnzjDKmsmswroHDnu2o/q2/eeQozHtjiy/zI3Q1qb94SWyHvMnaCkE2jyU
         fq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8bqcj+fQi+LPKTwP58l/gYDYaKLYdssShQrHrw6wI4=;
        b=qOrHswWKXYHeVHMnhysHoakGVt1QTbF3f8vBd8UwMkMbab8VsKu6IJvl5w13E25oQx
         r6hzRsZQXDXuaUXSVIVDcYP3F869pQtir/n8uv7pWvEsvqT90agOMOA/2YwdHlyyYRz7
         cFBJz4eaZ9H4M7+UuPaDJnyYDtCaylyL7lf6uca82MHpGaTyy0FB/G7sNa1srvXUpxth
         4eCUw4OlUGksQD10I3EM/OJWkGyCtnh0AIw40WVq40gVIMGe+bZ/rwzu5PsD1v/ksPmY
         fxw5y4/6xdUnz9OM4A5Rr9eUVZ3H05x3mX3v8IbABxI8NgZA3AoYelkDPiXky3I2dxRv
         z6gA==
X-Gm-Message-State: AO0yUKXE0zpDHPudljkSqzxdsN6xyKmUDVbQm1Dos66EGE0EYTonfzMm
        QRXBxnyWTOpaa/hNShkxTV4=
X-Google-Smtp-Source: AK7set8thacgtVIpgYitQNwESehPrSgzEk0W9nkBld/GehwQsuzvIF8fXvAVRFU/vd5AxCVG1IO+hw==
X-Received: by 2002:a05:6a20:7da2:b0:cc:8266:9951 with SMTP id v34-20020a056a207da200b000cc82669951mr12549815pzj.56.1677511286985;
        Mon, 27 Feb 2023 07:21:26 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 12/18] bpf: bpf_struct_ops memory usage
Date:   Mon, 27 Feb 2023 15:20:26 +0000
Message-Id: <20230227152032.12359-13-laoar.shao@gmail.com>
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

A new helper is introduced to calculate bpf_struct_ops memory usage.

The result as follows,

- before
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 4096B
        btf_id 73

- after
1: struct_ops  name count_map  flags 0x0
        key 4B  value 256B  max_entries 1  memlock 5016B
        btf_id 73

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index ece9870..38903fb 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -641,6 +641,21 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	return map;
 }
 
+static u64 bpf_struct_ops_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_struct_ops_map *st_map = (struct bpf_struct_ops_map *)map;
+	const struct bpf_struct_ops *st_ops = st_map->st_ops;
+	const struct btf_type *vt = st_ops->value_type;
+	u64 usage;
+
+	usage = sizeof(*st_map) +
+			vt->size - sizeof(struct bpf_struct_ops_value);
+	usage += vt->size;
+	usage += btf_type_vlen(vt) * sizeof(struct bpf_links *);
+	usage += PAGE_SIZE;
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(bpf_struct_ops_map_btf_ids, struct, bpf_struct_ops_map)
 const struct bpf_map_ops bpf_struct_ops_map_ops = {
 	.map_alloc_check = bpf_struct_ops_map_alloc_check,
@@ -651,6 +666,7 @@ static struct bpf_map *bpf_struct_ops_map_alloc(union bpf_attr *attr)
 	.map_delete_elem = bpf_struct_ops_map_delete_elem,
 	.map_update_elem = bpf_struct_ops_map_update_elem,
 	.map_seq_show_elem = bpf_struct_ops_map_seq_show_elem,
+	.map_mem_usage = bpf_struct_ops_map_mem_usage,
 	.map_btf_id = &bpf_struct_ops_map_btf_ids[0],
 };
 
-- 
1.8.3.1

