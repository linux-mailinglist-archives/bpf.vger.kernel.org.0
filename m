Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D47D6A45EA
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjB0PVN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230132AbjB0PVL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:11 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DA22A1F
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:05 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id p6so3790829pga.0
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=kPV1P61Kd0VE4A/sLs+rCgugutJbre1p41Jp9AewL8nwfkSQmj85/GyTCWADug9ewR
         p/5HqctY4ymjNfXE05aBzhq1gjUD+CE08kHyUXNas9jYtVnM1KnjuG6Apdf1HAqu0YK9
         0vO95QdYSksS+4Icu5HEmCeXql2TQ8rMrv+xN0BC9mg3ktlTMEcdkyUUa5UBBQNCdGev
         0pspuVc5MaXtjryhse+sRWUGv1ehoEJqp5M406FF7OIRNLSEvzEPuekwG49o1WTpXucE
         YOPpivQFUItrDGyudyfXL2BzRTGqqu5HyEzH2r00J00vMy8ozVlM78QvDoegnV22U/CN
         ettA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQuLzFY+KbTi70OVyTdLGmPLsVqTEok0qqP2ZiCsjVY=;
        b=lew/JPukHKYSGyBjz6g1W/aWjfO0komwzXxBpqhg72FqWp3uR75lbuJu19wzkvu+g0
         nWWbJ/gpy6juRic1e2Pg7c+2jrSBjujWX9s3EZy6lavrG73ZCBHw36U5lY1ynmAIPgfS
         t7mI04K8Hhfvk8kG07/itVaiMddkPLM+s87yha+OCPcuR6F/w5Q1cgEADyEJLkbu5aBz
         Ac0y/95kmYOQS6DM7cfkn6Y5zgLlrtbvKIA1ravNNXUjQh/Q+cioFmzhyA7D0lgMRG01
         tfeFebhaNzm1jLvJIO601OytD0fwUjE6JphdoCRyhufk0VUZ5DMimSvoqCJW7ATsfFew
         gyYQ==
X-Gm-Message-State: AO0yUKWyHYpgSFAG+JireHCtNv2CuGD4huJ9+1pHgsa5SZd2tBXVhbt2
        9wDHrL7wmUlLcf4MV2mo0xE=
X-Google-Smtp-Source: AK7set90cqPKHF+c9azvhxFYskYHfqBJBWIgjcvjhGerZlvJH5CMd+VY9e8lDOaCIXonspx1OL1oRQ==
X-Received: by 2002:aa7:9798:0:b0:593:da8:6f34 with SMTP id o24-20020aa79798000000b005930da86f34mr22639253pfp.5.1677511265390;
        Mon, 27 Feb 2023 07:21:05 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:04 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 06/18] bpf: reuseport_array memory usage
Date:   Mon, 27 Feb 2023 15:20:20 +0000
Message-Id: <20230227152032.12359-7-laoar.shao@gmail.com>
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

A new helper is introduced to calculate reuseport_array memory usage.

The result as follows,
- before
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
14: reuseport_sockarray  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 524544B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/reuseport_array.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 82c6161..71cb72f 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -335,6 +335,13 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	return 0;
 }
 
+static u64 reuseport_array_mem_usage(const struct bpf_map *map)
+{
+	struct reuseport_array *array;
+
+	return struct_size(array, ptrs, map->max_entries);
+}
+
 BTF_ID_LIST_SINGLE(reuseport_array_map_btf_ids, struct, reuseport_array)
 const struct bpf_map_ops reuseport_array_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -344,5 +351,6 @@ static int reuseport_array_get_next_key(struct bpf_map *map, void *key,
 	.map_lookup_elem = reuseport_array_lookup_elem,
 	.map_get_next_key = reuseport_array_get_next_key,
 	.map_delete_elem = reuseport_array_delete_elem,
+	.map_mem_usage = reuseport_array_mem_usage,
 	.map_btf_id = &reuseport_array_map_btf_ids[0],
 };
-- 
1.8.3.1

