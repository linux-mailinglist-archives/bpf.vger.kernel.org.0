Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8E6A45EF
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjB0PVd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjB0PVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:21:30 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3486C22A30
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:23 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id h17-20020a17090aea9100b0023739b10792so6506269pjz.1
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:21:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=Yr4SFFtPkZvwVK75AV3zwTrAqWt5rE0nlqVxsyYcahWuZX7ri2/Ayv26fnF4X1EWfn
         nNe6tSr83LYOpEpxi3jtsjOebAkbek4aVJwv0mluWzOc9IC4Hw8nwr7SL2x2LmKZB9Gz
         YXHIhVHgqu9timdfGivNg6X4TtzTGB5ju6r0dmJqBVOGVgs2XxCxXjiijshdm22JD3Gy
         MT1o1jR7fFYURo0cADrHRN4d4a62s0PVU9av361oEvAVEobHhfyOCGC1WI6mZXN6sfP3
         fMwRipMtF7RjiBGU9YUnh9zR7oix9KGrGfy9wCllssrxzrkEF2Rx4iDrZYb6pGLANLp8
         2HEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eSsP2cTbcAO8kYH41y4wWbsUNHvs4mxp7DEwTns4GbQ=;
        b=Js1ZN7+0lyRXuRBb+99oXKks1GAO1g2Cx6NbSZ7LTPhMnAIoBlsfTYH0EoF+rrRvz0
         yRXiaJ5KHKiLx2Y5M0KW9QW/HKxQCNsrUcpKCH8dNRyKcOp8OMfo10KOdPmPgBY29/v/
         g/hCqGi8HVooBaTCtUvo7ubaXYCcrW24Rw3WQJ9IAZd6TAAt4AwC/dWcV62Np4U0DCI6
         3N8/eIGgKV31iOcz2VRt9z2QYAQX4I9wskMyw1CLTYHYRCZtBwWZYw61/P480u/omRBn
         moLLRKLm+lMWB4q+noHjiWWZnpDBa+DOmqSTFxL/sOqg7QHF+CQQwSDaL0u78Rra32tg
         E7fg==
X-Gm-Message-State: AO0yUKWgwXF47FThmVOYCthAhFiDF60BPKDU4/kMyGvjzUrccKWDlRZH
        v1EJ0DvVa7Sm9qvnF51vNi0=
X-Google-Smtp-Source: AK7set8fB5grJBEEjo7ePIzmqAWZXISL/o6cbC87msv0hK56/BPFBPvMwH8PBobSNXxdCghNQpe5Xg==
X-Received: by 2002:a05:6a21:9999:b0:cc:1184:6d0 with SMTP id ve25-20020a056a21999900b000cc118406d0mr18397390pzb.23.1677511282774;
        Mon, 27 Feb 2023 07:21:22 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:21:22 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 11/18] bpf: queue_stack_maps memory usage
Date:   Mon, 27 Feb 2023 15:20:25 +0000
Message-Id: <20230227152032.12359-12-laoar.shao@gmail.com>
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

A new helper is introduced to calculate queue_stack_maps memory usage.

The result as follows,

- before
20: queue  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 266240B
21: stack  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 266240B

- after
20: queue  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 524288B
21: stack  name count_map  flags 0x0
        key 0B  value 4B  max_entries 65536  memlock 524288B

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/queue_stack_maps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/bpf/queue_stack_maps.c b/kernel/bpf/queue_stack_maps.c
index 8a5e060..63ecbbc 100644
--- a/kernel/bpf/queue_stack_maps.c
+++ b/kernel/bpf/queue_stack_maps.c
@@ -246,6 +246,14 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	return -EINVAL;
 }
 
+static u64 queue_stack_map_mem_usage(const struct bpf_map *map)
+{
+	u64 usage = sizeof(struct bpf_queue_stack);
+
+	usage += ((u64)map->max_entries + 1) * map->value_size;
+	return usage;
+}
+
 BTF_ID_LIST_SINGLE(queue_map_btf_ids, struct, bpf_queue_stack)
 const struct bpf_map_ops queue_map_ops = {
 	.map_meta_equal = bpf_map_meta_equal,
@@ -259,6 +267,7 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	.map_pop_elem = queue_map_pop_elem,
 	.map_peek_elem = queue_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
+	.map_mem_usage = queue_stack_map_mem_usage,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
 
@@ -274,5 +283,6 @@ static int queue_stack_map_get_next_key(struct bpf_map *map, void *key,
 	.map_pop_elem = stack_map_pop_elem,
 	.map_peek_elem = stack_map_peek_elem,
 	.map_get_next_key = queue_stack_map_get_next_key,
+	.map_mem_usage = queue_stack_map_mem_usage,
 	.map_btf_id = &queue_map_btf_ids[0],
 };
-- 
1.8.3.1

