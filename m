Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CC769EC7C
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbjBVBqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBVBqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:52 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629B232E71
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:51 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id n5so3801765pfv.11
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=cT6ZpeMZlvActEHylhnHJxns8fGIttIwua0XGUXlW41oRKQWzLDAI98YA6QuBDxZs5
         lwS3VNS3Rgxor8rll71gygjd6Z+m9m1lSrFlV9+5MvPk0JQzaCD1pmxCoXfYyPKTIi1Z
         36ehNIQ7nmKjGleGJTz13NvreYuOd0wfsg/G7zOm5XJz+81PJUYz+Ig2JDwaPzKrwd7Z
         H/3z6AnZjoqAXKfjjJZkmFPLgi6q7Vg+7hj0vbfM/tvH3fbRJFHnoyEBTGmhF4mPkMpX
         8sMQsaoY0PjP/HXbuDkuOnd2vA0eW1WDixhIQ8UPJUYZomHUAj+qNbELhj5B/TMAFpmG
         rRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BoFsRKqLdKP02I7g694Qbh39KZF7kQZ2F0Pz2UqBWn0=;
        b=k5HD8sYEoXOJFcbef9GqN3vfzmLFG1L7mqxA7R5mah6SxwnQugToi5J3B//kYvEVZ8
         wq/RAi9CxPeX+d3YjlipTg5OP6RNFZ8dgKk/pQyyaJaZXIPvNtX8VfVrYoO40GvCC3sY
         hms9DW4K31fDrrvZQw76BmxQlzGxjdWypfhW/JhZydpJ3ey/8zG/d3Zlp4ib4S3gsW0C
         EbTj/2ZWrF7H/Q6nhaeypzquoa2FYMqK8jnU3BvYhN1/8EFXFBzTzzKRvgj6sver70Rb
         hj5ZWFM7ejJDzJ8Ub5uCM5VxmQLIgdbhsnhHtzEcb9etuV/TWxEusJrocZ3D7XikW6bh
         buMg==
X-Gm-Message-State: AO0yUKWLM1X97/J2PHMmQi8jq+vOI3vExOUpBhv9cQEbWG+zkxQMxoNk
        1EPUYr9pckmKncA33Jd2j4k=
X-Google-Smtp-Source: AK7set9ItwQSAjFPJqKB5Ylen7PsNSkh9to8/6u12kw5KI/hdBAoIUYeN5OC/zcZ8bgV0PAvPVtcMQ==
X-Received: by 2002:a05:6a00:18a9:b0:594:1f1c:3d3b with SMTP id x41-20020a056a0018a900b005941f1c3d3bmr9159787pfh.16.1677030410790;
        Tue, 21 Feb 2023 17:46:50 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:50 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 08/18] bpf: bloom_filter memory usage
Date:   Wed, 22 Feb 2023 01:45:43 +0000
Message-Id: <20230222014553.47744-9-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230222014553.47744-1-laoar.shao@gmail.com>
References: <20230222014553.47744-1-laoar.shao@gmail.com>
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

Introduce a new helper to calculate the bloom_filter memory usage.

The result as follows,
- before
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 524288B

- after
16: bloom_filter  flags 0x0
        key 0B  value 8B  max_entries 65536  memlock 65856B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/bloom_filter.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
index 48ee750..6350c5d 100644
--- a/kernel/bpf/bloom_filter.c
+++ b/kernel/bpf/bloom_filter.c
@@ -193,6 +193,17 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	return btf_type_is_void(key_type) ? 0 : -EINVAL;
 }
 
+static u64 bloom_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_bloom_filter *bloom;
+	u64 bitset_bytes;
+
+	bloom = container_of(map, struct bpf_bloom_filter, map);
+	bitset_bytes = BITS_TO_BYTES((u64)bloom->bitset_mask + 1);
+	bitset_bytes = roundup(bitset_bytes, sizeof(unsigned long));
+	return sizeof(*bloom) + bitset_bytes;
+}
+
 BTF_ID_LIST_SINGLE(bpf_bloom_map_btf_ids, struct, bpf_bloom_filter)
 const struct bpf_map_ops bloom_filter_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -206,5 +217,6 @@ static int bloom_map_check_btf(const struct bpf_map *map,
 	.map_update_elem = bloom_map_update_elem,
 	.map_delete_elem = bloom_map_delete_elem,
 	.map_check_btf = bloom_map_check_btf,
+	.map_mem_usage = bloom_map_mem_usage,
 	.map_btf_id = &bpf_bloom_map_btf_ids[0],
 };
-- 
1.8.3.1

