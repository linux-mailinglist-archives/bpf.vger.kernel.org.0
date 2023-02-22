Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05069EC75
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 02:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjBVBq3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 20:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBVBq2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 20:46:28 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2A932E65
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:27 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id a7so3798426pfx.10
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 17:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJddoMByRjHQiNUI72hW0/VP9TMtY4CHZ+jz5kdN4Dk=;
        b=S67RSMT+i70sqtYTUdfcim6BdyITLBJCg5h9SzwksU7LjQPcWMRiDmd6wtTaGz2y1r
         7GHSUVAwTlYfF3CoJ8AcFEq9HROsbsPvkO6F09G7rNam1edzvzmPVgB39kB1eXOo3lJj
         VT5qT/nRzkwvU3lSlNaBfsZtEphQ1yXyGAjlgmmMOUeWmmMzgvFI617m7YCSJzASQPfD
         scXbJFMcHZQrYxu2q2PrmXyZDosd0aD5wbDiLH8WGCbFSa+6rz47BG44vptOXRwyna2O
         GipN/I5cddQbzrZmUZ/Cbg0rvFk55/EBCdSP20qEOO6uosuCoa5WCM+1HIWQX2Xy6EJN
         ZG5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJddoMByRjHQiNUI72hW0/VP9TMtY4CHZ+jz5kdN4Dk=;
        b=TLAiuiEWOJYouoUWgoRSz3fvUJ1Dlju+MRRHcnZBIFt14Lx4vx6xLe+RXtzHZF0qij
         R2oAbNhMd1JA+fB53Egx+h5Sf2cEV27xtMRja82faZYDs7Begz5Q5lCbcZ0XDSAt+Hi9
         fvbonVLVomscizY863yPZ1+cCviSOz31Yyv5g5TZ4t2eAr/Kdd9lo1Q2K0zyDI7nU3zV
         C4I/LdCilpPD06f6bPJjpt9aymm6EDTxD/rE30i+fnaPhgpqrn3wrZnMyurKtDbhjlG/
         nxFa0wmsIpjiOhXori+GR+mL9bav9MV6X11Og5+7AZBAx9ND7nBUMFPuaVBAyjEmoxYX
         f49A==
X-Gm-Message-State: AO0yUKWOnpcYRmqr8ICxUWVi9PBfWQaUP4iIvfoBTfLtbfb0RwesSlY1
        QENishYTClKvVG/ZOtRpRoU=
X-Google-Smtp-Source: AK7set8oQvBKkzlNe7PnZ4BGwcobiyHVbjlv5I5sL/NK9DVgscykp/DiL6EOjSowtkw8WFJnk+C8uQ==
X-Received: by 2002:a62:62c5:0:b0:5a8:65e4:aba9 with SMTP id w188-20020a6262c5000000b005a865e4aba9mr6865930pfb.18.1677030386674;
        Tue, 21 Feb 2023 17:46:26 -0800 (PST)
Received: from vultr.guest ([2001:19f0:7001:5cd8:5400:4ff:fe4e:5fe5])
        by smtp.gmail.com with ESMTPSA id f15-20020aa78b0f000000b005ac419804d3sm3811509pfd.186.2023.02.21.17.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 17:46:26 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v2 01/18] bpf: add new map ops ->map_mem_usage
Date:   Wed, 22 Feb 2023 01:45:36 +0000
Message-Id: <20230222014553.47744-2-laoar.shao@gmail.com>
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

Add a new map ops ->map_mem_usage to print the memory usage of a
bpf map.

This is a preparation for the followup change.

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 include/linux/bpf.h  |  2 ++
 kernel/bpf/syscall.c | 15 +++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 520b238..bca0963 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -161,6 +161,8 @@ struct bpf_map_ops {
 				     bpf_callback_t callback_fn,
 				     void *callback_ctx, u64 flags);
 
+	u64 (*map_mem_usage)(const struct bpf_map *map);
+
 	/* BTF id of struct allocated by map_alloc */
 	int *map_btf_id;
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e3fcdc9..8333aa0 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -771,16 +771,15 @@ static fmode_t map_get_sys_perms(struct bpf_map *map, struct fd f)
 }
 
 #ifdef CONFIG_PROC_FS
-/* Provides an approximation of the map's memory footprint.
- * Used only to provide a backward compatibility and display
- * a reasonable "memlock" info.
- */
-static unsigned long bpf_map_memory_footprint(const struct bpf_map *map)
+/* Show the memory usage of a bpf map */
+static u64 bpf_map_memory_usage(const struct bpf_map *map)
 {
 	unsigned long size;
 
-	size = round_up(map->key_size + bpf_map_value_size(map), 8);
+	if (map->ops->map_mem_usage)
+		return map->ops->map_mem_usage(map);
 
+	size = round_up(map->key_size + bpf_map_value_size(map), 8);
 	return round_up(map->max_entries * size, PAGE_SIZE);
 }
 
@@ -803,7 +802,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   "max_entries:\t%u\n"
 		   "map_flags:\t%#x\n"
 		   "map_extra:\t%#llx\n"
-		   "memlock:\t%lu\n"
+		   "memlock:\t%llu\n"
 		   "map_id:\t%u\n"
 		   "frozen:\t%u\n",
 		   map->map_type,
@@ -812,7 +811,7 @@ static void bpf_map_show_fdinfo(struct seq_file *m, struct file *filp)
 		   map->max_entries,
 		   map->map_flags,
 		   (unsigned long long)map->map_extra,
-		   bpf_map_memory_footprint(map),
+		   bpf_map_memory_usage(map),
 		   map->id,
 		   READ_ONCE(map->frozen));
 	if (type) {
-- 
1.8.3.1

