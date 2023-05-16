Return-Path: <bpf+bounces-638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5BC704DF1
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 14:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF379281332
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E40261D2;
	Tue, 16 May 2023 12:39:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFABF34CD9
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 12:39:37 +0000 (UTC)
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827FD1713
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:36 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so8185253b3a.3
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 05:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684240776; x=1686832776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7SQXujUgwPTd6zntnjgrKNTX9Z8saXSJ5Wp2x1NepU=;
        b=ehaiI+bEZkFM5fwyJPHR09yzVW02x5F74ppGVm8XFCYlJyGDQuxlbILkBblNtaPBrO
         0w1tOKhDCj2xdf2kNmVmWtIQXU4Mvvp3F2517IuLtSxIeBXLBybeyFhH241Hu/i/aR9G
         zt0wv/h9rabBGibEcwk3MqNxJG6ng/8Ai/y0vrQVZfI4DqoD4ZHWp0ibGKPdAPv2+0bs
         PAn7Mc0T0hyt2MqwVYcxP9nrIMlFyi5RBOZKuFGuHKpoAgc3Szpd+qSDDVnwwf4Uo7Wj
         YIcPGoqraE/IkPckduhwghyMHYv4GwCJ+Wtgc9jRerY2wdrBmQxCeWPYTemnBvbJdvSD
         hmmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240776; x=1686832776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7SQXujUgwPTd6zntnjgrKNTX9Z8saXSJ5Wp2x1NepU=;
        b=c5ftoc7IMtelK6mOaD2cBlK3EYhaVak0ltlm7h19iWRhNXPvoyPnp4qm+YYy69xhbb
         jDyEKVexBhGri/BEvzoJaP+FsSpJDXBAYTUuaNJ1YGyvr3aQ3BbPMhOs3Z2zHjaL0O42
         QYiAOSyGHeL/UIG89fj2gbgT+1/pFlmQnV1l1Xq3r0UvKyGglb/Ko2B3GKQkpXberAKj
         va66L86O0O8Aiwfzw004t6NfuUQZUBxcOwRytG+6Cu1bW1oaaJnw6dqASbVAMR4ijePn
         BHXy82Q39ObD3mSFs0mw4Q1WA86Z8lUZV4lpP/YMRu3hSbNwCEL7xVyV2Lbwk8GZcZ0M
         FORQ==
X-Gm-Message-State: AC+VfDzedD+VSEUtNnHNC/lzup5dxORPfytSBuuq2r106vVE7nCCJhvR
	S2OwihRswS+iysumYmwjXZ4=
X-Google-Smtp-Source: ACHHUZ5YOmk2EapTBodgBpuCtIX3s/ylGAB7hJhxmTdGKOB02j3Wa0DmkUXOdhwrbD/1wrk3GkmYYw==
X-Received: by 2002:a05:6a00:88b:b0:644:18fe:91cc with SMTP id q11-20020a056a00088b00b0064418fe91ccmr42749490pfj.12.1684240775909;
        Tue, 16 May 2023 05:39:35 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:8001:1799:5400:4ff:fe70:6970])
        by smtp.gmail.com with ESMTPSA id c20-20020a62e814000000b0063b8ddf77f7sm13156984pfi.211.2023.05.16.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 05:39:35 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: song@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Show target_{obj,btf}_id in tracing link fdinfo
Date: Tue, 16 May 2023 12:39:25 +0000
Message-Id: <20230516123926.57623-2-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230516123926.57623-1-laoar.shao@gmail.com>
References: <20230516123926.57623-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The target_btf_id can help us understand which kernel function is
linked by a tracing prog. The target_btf_id and target_obj_id have
already been exposed to userspace, so we just need to show them.

The result as follows,

$ cat /proc/10673/fdinfo/10
pos:    0
flags:  02000000
mnt_id: 15
ino:    2094
link_type:      tracing
link_id:        2
prog_tag:       a04f5eef06a7f555
prog_id:        13
attach_type:    24
target_obj_id:  1
target_btf_id:  13964

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
Acked-by: Song Liu <song@kernel.org>
---
 kernel/bpf/syscall.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 909c112..870395a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2968,10 +2968,18 @@ static void bpf_tracing_link_show_fdinfo(const struct bpf_link *link,
 {
 	struct bpf_tracing_link *tr_link =
 		container_of(link, struct bpf_tracing_link, link.link);
+	u32 target_btf_id;
+	u32 target_obj_id;
 
+	bpf_trampoline_unpack_key(tr_link->trampoline->key,
+							  &target_obj_id, &target_btf_id);
 	seq_printf(seq,
-		   "attach_type:\t%d\n",
-		   tr_link->attach_type);
+		   "attach_type:\t%d\n"
+		   "target_obj_id:\t%u\n"
+		   "target_btf_id:\t%u\n",
+		   tr_link->attach_type,
+		   target_obj_id,
+		   target_btf_id);
 }
 
 static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
-- 
1.8.3.1


