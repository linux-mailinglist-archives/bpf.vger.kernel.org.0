Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706096A45E9
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjB0PVM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjB0PVK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:10 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DC121A11
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:02 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id s17so3767093pgv.4
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=EGHxG5AQPREWj5Ue4Hll9H2ysnzprW5t5FeOti8EnP/qRJDRYCuda2SL4ifL1BLGkJ
         nHnTtwPTqDu7rKZZpb169rmeMM5z7NeI2ZQ1rjOznzKxAoLIXoAiPBc6p18iFhz/lZ9q
         JbqYPWkvYiViKgza4/qvriMppj5fJsFz0eoskgo1BziXBhPiHVjAthV4aep06exiLh7o
         H5L7f8UXUpo/tmVETDt1OSNbk7ucO2Wk6gAhnGLb47GeRjMozFZViMePJ2nvE4P+O27i
         2jn+ks37q2xi/5elXMkbfa+AGRXE3xZZJQ6C46ZRUaH6RHni/BIROhff/vU9ww/hiGdi
         1ZIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQHwjTJNmWcaYoQZxEEd3KAAGtFjO42sdOiYOa2Xw5Y=;
        b=uL0ZbaiPIbT0IlXoCjreMc5FNaR1EiT6pVzZhN+lBU74FP2wlsn1Kc2WUCmXQcVvFz
         R/BSR2lSEHlinAvzKdiWtjDnAYp2NNJODJ5pNI+IPopSQT+Pg/88iE/G32BXeFVLWcn/
         vCMgUYUYtk5uoAy6W7Xn81RGqFL+vR38fU0nw+R3nw9Muczssa0PWs5+W9x6CqOLCUWi
         STfPs9gNduGTy++Befc4g7SbrfySjIIof5JCoqEGezRMrM5A5q0sIo8viQgF3eHa+XtK
         SmcLXFj1xbAxIK+whbtcYdKdHCsq5tZyOxgvMQn0ezKc+/yce2D6LMqD6Lo1fxEvtNCP
         153w==
X-Gm-Message-State: AO0yUKXmVEj/4RlKfYhcIMT4yoOSRLePVtOm4S3dnPcsvJeuU4VXMmSm
        JJjthqtVeDQ45Wi/bYyexuo=
X-Google-Smtp-Source: AK7set/nl3Fv4n8yu5m269/5IWtamEOWuEx4H8Dn9A+iULNnFUwxFUMUL/oMJHhnB7HPcmtAcp0xKA==
X-Received: by 2002:aa7:9466:0:b0:5aa:4df7:7ef6 with SMTP id t6-20020aa79466000000b005aa4df77ef6mr22781213pfq.7.1677511261916;
        Mon, 27 Feb 2023 07:21:01 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:01 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 05/18] bpf: stackmap memory usage
Date:   Mon, 27 Feb 2023 15:20:19 +0000
Message-Id: <20230227152032.12359-6-laoar.shao@gmail.com>
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

A new helper is introduced to get stackmap memory usage. Some small
memory allocations are ignored as their memory size is quite small
compared to the totol usage.

The result as follows,
- before
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 1048576B

- after
16: stack_trace  name count_map  flags 0x0
        key 4B  value 8B  max_entries 65536  memlock 2097472B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/stackmap.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index aecea74..0f1d8dc 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -654,6 +654,19 @@ static void stack_map_free(struct bpf_map *map)
 	put_callchain_buffers();
 }
 
+static u64 stack_map_mem_usage(const struct bpf_map *map)
+{
+	struct bpf_stack_map *smap = container_of(map, struct bpf_stack_map, map);
+	u64 value_size = map->value_size;
+	u64 n_buckets = smap->n_buckets;
+	u64 enties = map->max_entries;
+	u64 usage = sizeof(*smap);
+
+	usage += n_buckets * sizeof(struct stack_map_bucket *);
+	usage += enties * (sizeof(struct stack_map_bucket) + value_size);
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(stack_trace_map_btf_ids, struct, bpf_stack_map)
 const struct bpf_map_ops stack_trace_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -664,5 +677,6 @@ static void stack_map_free(struct bpf_map *map)
 	.map_update_elem = stack_map_update_elem,
 	.map_delete_elem = stack_map_delete_elem,
 	.map_check_btf = map_check_no_btf,
+	.map_mem_usage = stack_map_mem_usage,
 	.map_btf_id = &stack_trace_map_btf_ids[0],
 };
-- 
1.8.3.1

