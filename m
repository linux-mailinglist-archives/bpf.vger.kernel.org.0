Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BA364CC1F
	for <lists+bpf@lfdr.de>; Wed, 14 Dec 2022 15:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238269AbiLNO0S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Dec 2022 09:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238316AbiLNO0M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Dec 2022 09:26:12 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAC1275DE
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 06:26:10 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id s7so3491113plk.5
        for <bpf@vger.kernel.org>; Wed, 14 Dec 2022 06:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=jCFbjQgKtfcgCHc2e84cyzJSja23Rhz1Pu6DW53VjJ/hM5ZUXvH9DyKrkTg5FaUBXq
         WjyDaa/oGN5WB/qrNJel3S5WHo3Nslm2E8YAzYRNgtAYKEuDI0BVQt9ctI5LCb3AQ779
         N9qomZc7y1M91JV4IqNMN/VCDwI1hiS23dhNZMpeuKSPvB/VQox8BZPT40t3EMyGBov7
         bM6DPN4ivoBEshb5Qo65SlvwHvY1fCNFEVRgsHkpdoPy7VjS/tIcMuBsYje+L9QlA616
         SFaMmd8fv3sDUwyZ+jB0woUzxuqfmhNYYhFz+20T+5CT+LQx/KHKZozrkbptdlo+3SUx
         o3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LZlR6Bad0hmj0yfP1fW6/YZEKORyAPx8ltFpb+vzAg=;
        b=eG53U1Ga/yMfmYwicWJVwcb5saARzsBTrpm9FM2oCZLWs6Crh6DL2e4NdpOmiBHxiO
         C/JA33KCekLQCOmJCnhHf2UpidZr7Vi/F3Zbb7bt4+XYBS1n6xK+EW/R1QGw+a4Ksisy
         UBlT9j5y1REH4YPgLphdStT+bPDZbb/axTZOPi1FpEpTndwuG56AF3N4UNdOg7lOsTdq
         ZASjErawZUf9Tw+yi2FvXVPoHfNDlWkKW042OefmNPKzK6QzNeoMUEsI/uFcUKPBIBYf
         45VzaS/7ndCuVJgKfen8VNFua1RhTCZm73+lVmRX0HvjIY9C7eYZ0oWCComF3Nlf0qMF
         FzCg==
X-Gm-Message-State: ANoB5pnW9t7s5GJe+JeiicCrt8vsa/1iiWfjKtmbhZqYpg1CJWwh/3NU
        KSoArCsbQmuvPMuTDXbPEqORt/AqJOECMg==
X-Google-Smtp-Source: AA0mqf6mfAoL+O9CVLmj9ta1KHQJQUAAWv9dT0mBzBKvWKAvOfs96jn20ncMYwbeEnPSFm5AUr7OnA==
X-Received: by 2002:a05:6a20:c887:b0:a7:9c6a:4a64 with SMTP id hb7-20020a056a20c88700b000a79c6a4a64mr27646809pzb.8.1671027969148;
        Wed, 14 Dec 2022 06:26:09 -0800 (PST)
Received: from localhost.localdomain ([111.201.145.40])
        by smtp.gmail.com with ESMTPSA id u4-20020a17090341c400b00187033cac81sm1942915ple.145.2022.12.14.06.26.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Dec 2022 06:26:08 -0800 (PST)
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
Subject: [bpf-next 2/2] bpftool: add runtime stats, max cost
Date:   Wed, 14 Dec 2022 22:25:39 +0800
Message-Id: <20221214142539.73650-2-xiangxia.m.yue@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221214142539.73650-1-xiangxia.m.yue@gmail.com>
References: <20221214142539.73650-1-xiangxia.m.yue@gmail.com>
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

