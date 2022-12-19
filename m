Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141A6507DE
	for <lists+bpf@lfdr.de>; Mon, 19 Dec 2022 07:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiLSGrK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Dec 2022 01:47:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiLSGqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Dec 2022 01:46:52 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3273D627E
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 22:44:57 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so7941988pjo.3
        for <bpf@vger.kernel.org>; Sun, 18 Dec 2022 22:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=bUwub9t6zGXZ6kJNZSIiJVGcE7nyHP8sEe/61z2u3greFiiPk9OZ5pPrfxh8tZyX+A
         RacRFsPm1IMDF8hbKSV7g/wBzXKoMc6eMkNei3Ppfzxn3OzunklDZdPnGqsAYPigiSDl
         A+rCRVaaq993jBOGYF+Q1N3dd3NaJLCUiUFpmI6yxb8+7ciKKlufTN5iWTMFjDznV1sa
         53aVcU0eNZOzaKEorgtf/COa6LVpqAOQEIKjobMZKE6EDLouGCXCivcgZqEZlI9+txit
         lW+LSCHcHW+/x+LkQoYy0rRJLbYHNvIvmhbJlZHF/TKYpTpN0OpymUgO3MiQ5/1+FK6g
         HUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=PXQ7uuF2M8o9qxfm99FpV89qbH9wutxFPBe4qz1CIxGwqU+NwbgN7BUHXgP75cTyl+
         Lugz67YAHkn7Yey+jooOefwQdXgJifMGWCfvJnhIcDoPbCyYx93fTRCf3CkPikP8e4KP
         zPRhPrlyRHCZ5MdPd7vow70CWiw3DsBLwNiOIskajoHHZsEreE10DPJ/goIwsYBgsx0Q
         T6c4DVYWCZHqgvsx17d86U5dktmHZQwUVe1aP6txHHf+qDfqOhJcfLaGFLdirw8Z+ZuZ
         9bxYWhlvWaeMxQizjpN2Y2BsrNh0ScrCWE7bHMcTKTJIjiWgOp2b9TB+5m+urAbmuNeQ
         WbBA==
X-Gm-Message-State: ANoB5pkcW9f2Zec2to2UStLWDJdVzQIPaBQphV+EFL+6imJcJP+oENWL
        LEc0WapiQ4vIYJnCaitJF9Qm/Z8ahJQqF0iF
X-Google-Smtp-Source: AA0mqf4WFOf9l5IzqReUQ4EcADgL8EH8NYr20CLuM6fhUZgkoaVDyvN7XlBoVrV/9NMFrBqyZOKnBg==
X-Received: by 2002:a17:902:d58a:b0:189:a11e:9995 with SMTP id k10-20020a170902d58a00b00189a11e9995mr42714242plh.13.1671432296367;
        Sun, 18 Dec 2022 22:44:56 -0800 (PST)
Received: from localhost.localdomain ([1.202.165.115])
        by smtp.gmail.com with ESMTPSA id jf14-20020a170903268e00b00189a50d2a3esm6146641plb.241.2022.12.18.22.44.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Dec 2022 22:44:55 -0800 (PST)
From:   xiangxia.m.yue@gmail.com
To:     bpf@vger.kernel.org
Cc:     Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Hou Tao <houtao1@huawei.com>
Subject: [bpf-next v3 2/2] bpftool: add runtime stats, max cost
Date:   Mon, 19 Dec 2022 14:44:28 +0800
Message-Id: <20221219064428.71784-2-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221219064428.71784-1-xiangxia.m.yue@gmail.com>
References: <20221219064428.71784-1-xiangxia.m.yue@gmail.com>
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

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yhs@fb.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Hou Tao <houtao1@huawei.com>
---
 tools/bpf/bpftool/prog.c       | 1 +
 tools/include/uapi/linux/bpf.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cfc9fdc1e863..c7764ff4079c 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -437,6 +437,7 @@ static void print_prog_header_json(struct bpf_prog_info *info, int fd)
 	if (info->run_time_ns) {
 		jsonw_uint_field(json_wtr, "run_time_ns", info->run_time_ns);
 		jsonw_uint_field(json_wtr, "run_cnt", info->run_cnt);
+		jsonw_uint_field(json_wtr, "run_max_cost_ns", info->run_max_cost_ns);
 	}
 	if (info->recursion_misses)
 		jsonw_uint_field(json_wtr, "recursion_misses", info->recursion_misses);
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 464ca3f01fe7..da4d1f2d7bc2 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6259,6 +6259,7 @@ struct bpf_prog_info {
 	__u32 verified_insns;
 	__u32 attach_btf_obj_id;
 	__u32 attach_btf_id;
+	__u64 run_max_cost_ns;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
-- 
2.27.0

