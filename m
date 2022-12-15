Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5CF64D5E1
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 05:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbiLOEdK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 23:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOEdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 23:33:05 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA91B2A27A
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:33:04 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t2so5632431ply.2
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 20:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=j3ZT4fNXOF4w5zECeJrT5Fp/3mmJ8IN0e109VtJqygU4Yd311iVeB8l6SuLzCC+59c
         TCS4dNxqvA0Iz0J9olqn1bGKjgLf0T9MMLfdTvmrE4c1GU3WqilZ12W5mlB536wzqpvd
         SiQ0rN2PVv6fgxtp3BBfWC+ctPIrjrLmLa2Fzdc2l6Z64VNTbmIaW8gmAqRSTR8uYA08
         dQm/x6MAPHkXrQmLySsgHAYIt/MbJ9QV595pBf4OlAp2/eoiK+v7Oz2Ch//i59sxh27h
         pb3OdFC92zkgiELIF+UhRMTd+jL6zXeR7wokC6eAWyjdp8HYJs3SWpCr7042bLXA0fCg
         lGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=vOWYrdK1IpkvbvIGU1VvUWXMJbDG0FBKf0C9t5Hf64UO63DizrM0t0HR/RiJD18Wzl
         7SpyyBOd99DvnofgHqKUagD+0iGp3lfYAMgqHcgjk2fzOozU3PvLJsp/TJx19QxObr4B
         38iD7vhbCJ9UiiKH5OWxy7sqQXPWOnqXqebThLm1sC0WxTbhRHHQuUiFIEpyy1bH0Lqa
         uPoqm5WixSLn3xwf1/83QqTVIepGvbSUlqM5e0hHZSuSR6VzTBKdP1BGVpH7g+ovktTj
         +dsJzU9gMmCokNS3BFxCRqy1C263V3oR21lPzuWO0X63rMfuTO7SMa1rKtM/zHsOaqWn
         ZI/Q==
X-Gm-Message-State: ANoB5pl4AUCSaLhSf9iRmbq0r09nu2KkX2x1Wl4/BaTsOlizq3CVIkh7
        WjKXVImBGZK6LQtBkAMM/w6sD6Jry2lJeA==
X-Google-Smtp-Source: AA0mqf56feI4Yc/QB2q1izTWcZBN1+J0FzmslnHa3aumgH4WIz3GyJdGKh/EGYbiYIgFYfjSHglq4Q==
X-Received: by 2002:a17:90a:ca16:b0:219:d636:dd82 with SMTP id x22-20020a17090aca1600b00219d636dd82mr26724808pjt.4.1671078783786;
        Wed, 14 Dec 2022 20:33:03 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id mv4-20020a17090b198400b0021894e92f82sm2161298pjb.36.2022.12.14.20.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 20:33:03 -0800 (PST)
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
Subject: [bpf-next v2 2/2] bpftool: add runtime stats, max cost
Date:   Thu, 15 Dec 2022 12:32:17 +0800
Message-Id: <20221215043217.81368-2-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
References: <20221215043217.81368-1-xiangxia.m.yue@gmail.com>
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

