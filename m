Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88316A45E5
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 16:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjB0PUy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 10:20:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjB0PUx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 10:20:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AA622A20
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:48 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id bn17so3741421pgb.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 07:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJddoMByRjHQiNUI72hW0/VP9TMtY4CHZ+jz5kdN4Dk=;
        b=ML0n077AfddxJBCHhaNpn/6+Y1LdZ/ciH4DnF+yE0e/G7AfHanvJRZrxsgdaFs5cms
         F1jf18DL+jQYCUaruCv+sMLNb68vRHK4bliwI2sTE1LxhpfqVfI5hPYBZN5s/yqxvSVq
         T7N78whzgPpSAs4LfnuDR4At95hpw/PLV9R8rhUV9PM9U5aezTcOn5i4SSWhYSXL5OCW
         BIh5K1PZm+7bCKnh5vvvIlvZT/Fek73X+BabasTTJ6RO/MYE0+uwoXrCUKFk8UpILU8k
         s0jPeSeBvPQgNMRtp/oLa5gKZPykdDJunydAGjBg+hEp00Kir19OKTj67h7ppyPEQ9tL
         ypIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJddoMByRjHQiNUI72hW0/VP9TMtY4CHZ+jz5kdN4Dk=;
        b=o5XuaLaVWXwq90xAu5OqO2JIT/3a3dTLXGCTsQQOognHKLutN+MnBv7VMHvnGdwhEw
         +laDYo386yGTINJVMakn/4hPk1Ck4uGBsLIQDDd4QTjpXuCatt2upKyugjdRcu0Tc+QV
         c7WFXqPCJ0W2SYxlaCTRyMTNEC3+Aqe3qIy5PEs1Yk84N+l6pWeCQQK44WHHowRnCYej
         LJGn6YjLLHeevdd0YE6w3jViD1g2kID8cFvGSojzYD/Z4qxBtqZMJ6aL98ONv+1kgliX
         VByXJ0+sCWD2k7nyZcGO3tkdivw/U0Xudz1Nx9hOwZCDIMGwkDlhgvIlrXDGMGNZbHT0
         iS8Q==
X-Gm-Message-State: AO0yUKWEbFECKrydIOr5q50u0OBzyy0A+JvhX3uARr2YvEDZ4C/TGjsW
        WT4mIkAoZ01B5I4d6tbmhak=
X-Google-Smtp-Source: AK7set+l9FNmyImZupwLcpZal1e/zt1ODkBNMqz0bY8tGVWURAUwvDxVH+XtDuwQ6zxppUEGKWcwug==
X-Received: by 2002:aa7:95a4:0:b0:5a8:c6c1:c9ae with SMTP id a4-20020aa795a4000000b005a8c6c1c9aemr22056386pfk.30.1677511248302;
        Mon, 27 Feb 2023 07:20:48 -0800 (PST)
Received: from vultr.guest ([2401:c080:1000:4a6a:5400:4ff:fe53:1982])
        by smtp.gmail.com with ESMTPSA id n2-20020a62e502000000b00589a7824703sm4326825pff.194.2023.02.27.07.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:20:47 -0800 (PST)
From:   Yafang Shao <laoar.shao@gmail.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, horenc@vt.edu,
        xiyou.wangcong@gmail.com
Cc:     bpf@vger.kernel.org, Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v3 01/18] bpf: add new map ops ->map_mem_usage
Date:   Mon, 27 Feb 2023 15:20:15 +0000
Message-Id: <20230227152032.12359-2-laoar.shao@gmail.com>
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

