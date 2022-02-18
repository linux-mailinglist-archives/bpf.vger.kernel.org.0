Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C414BB38C
	for <lists+bpf@lfdr.de>; Fri, 18 Feb 2022 08:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiBRHvz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Feb 2022 02:51:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiBRHvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Feb 2022 02:51:54 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0399541AC
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 23:51:34 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s24so7582641edr.5
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 23:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/vDRWmOBWs4cdlPBKUYdr6LmKhYbTMV3l6cGiqCxbc=;
        b=Kmmnu1gDMLfDWW/uZXj1xCaOxWiVET/xZvguooMp8N9Io25dEn26YShOyr76nnl1QO
         AtTyek418CvwJheBQHoJBt2Pl/VWVPFb4sodE0gT/TGAqI56ocJL2s2neWLqnoyj3fHL
         vvl6vLxOiNtXJONlj8NtWYSBmf0S8As4q/A4Ku9j4EZ+rcD6HTuvY0Botyvn0vwMtdiQ
         zF4KqieROvF4yVtv0HVJX7TOQQLzR7E4/GAQAgoOfQ3XKPp93BrmqY6zxSQwgSrMVDbJ
         qqRz3iNlMvEv4tFtv1mNR12BHYczVSPYYxJR0Yve9a1JKN/KzV3FkNdmGoGJaeKjSSTX
         YraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u/vDRWmOBWs4cdlPBKUYdr6LmKhYbTMV3l6cGiqCxbc=;
        b=Zs1cozl4ZDBa+57H3oDzoS/1tKTsCye5S3aTdopg7Ip1XeGd3MkApt1Mod4zTTIosB
         LxJN6zQZdU1le/dSHDgSzrL5PKGNW/Icu43h255ET7GaDGAhF6lJ82HEggzZgDd9f4k7
         eychf18h0c8xo4lqyPd7PGaB5wJQoeFrMnMMKIyZMPC2/qTSE+zIdAeXs85YfqScVieY
         BJwMJEPMrrTApAMS79wNaypEslYzZepK/cw59pa49gJLQht0bIpTFyPvOQY26PxGLiSt
         1idRetTaPfvEfr5v0tlEnZiE17gelNRf7ZNjN7stoVOjyNdE9zvlj/ZzsoRtjXoU18JI
         ZCng==
X-Gm-Message-State: AOAM530LKffr1pMdKKcH9xIVC906J9+1Cpt7sFMMkqpaAUaIHpKWcaJn
        ytvUszK7RvA5v9qJbTqicUYleF/Bwc7LkQ==
X-Google-Smtp-Source: ABdhPJwt1ZOfoq7IWTIeREF0QeglKeV7kUad/f75IpOEszyckUPykPtmAp/6jSrivIPN/qoq33BZlw==
X-Received: by 2002:a05:6402:4311:b0:408:71a7:13aa with SMTP id m17-20020a056402431100b0040871a713aamr6652905edc.54.1645170693366;
        Thu, 17 Feb 2022 23:51:33 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id 5sm4441367edx.32.2022.02.17.23.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 23:51:32 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v3] bpftool: Add bpf_cookie to link output
Date:   Fri, 18 Feb 2022 08:51:03 +0100
Message-Id: <20220218075103.10002-1-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
BPF perf links") introduced the concept of user specified bpf_cookie,
which could be accessed by BPF programs using bpf_get_attach_cookie().
For troubleshooting purposes it is convenient to expose bpf_cookie via
bpftool as well, so there is no need to meddle with the target BPF
program itself.

Implemented using the pid iterator BPF program to actually fetch
bpf_cookies, which allows constraining code changes only to bpftool.

$ bpftool link
1: type 7  prog 5
        bpf_cookie 123
        pids bootstrap(81)

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Changes in v3:
    - Use pid iterator to fetch bpf_cookie

Changes in v2:
    - Display bpf_cookie in bpftool link command instead perf

Previous discussion: https://lore.kernel.org/bpf/20220204181146.8429-1-9erthalion6@gmail.com/

 tools/bpf/bpftool/main.h                  |  2 ++
 tools/bpf/bpftool/pids.c                  | 15 +++++++++++++--
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 16 ++++++++++++++++
 tools/bpf/bpftool/skeleton/pid_iter.h     |  1 +
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0c3840596b5a..c0042bd56139 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -114,6 +114,8 @@ struct obj_ref {
 struct obj_refs {
 	int ref_cnt;
 	struct obj_ref *refs;
+	enum bpf_obj_type type;
+	__u64 bpf_cookie;
 };
 
 struct btf;
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 7c384d10e95f..d4db4049d94b 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -28,7 +28,8 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id, json_writer_t *json_write
 
 #include "pid_iter.skel.h"
 
-static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
+static void add_ref(struct hashmap *map, struct pid_iter_entry *e,
+				enum bpf_obj_type type)
 {
 	struct hashmap_entry *entry;
 	struct obj_refs *refs;
@@ -55,6 +56,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
 		refs->ref_cnt++;
+		refs->type = type;
+		refs->bpf_cookie = e->bpf_cookie;
 
 		return;
 	}
@@ -78,6 +81,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	refs->ref_cnt = 1;
+	refs->type = type;
+	refs->bpf_cookie = e->bpf_cookie;
 
 	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
 	if (err)
@@ -161,7 +166,7 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
 
 		e = (void *)buf;
 		for (i = 0; i < ret; i++, e++) {
-			add_ref(*map, e);
+			add_ref(*map, e, type);
 		}
 	}
 	err = 0;
@@ -205,6 +210,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->type == BPF_OBJ_LINK)
+			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
+
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
@@ -234,6 +242,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->type == BPF_OBJ_LINK)
+			printf("\n\tbpf_cookie %llu", refs->bpf_cookie);
+
 		printf("%s", prefix);
 		for (i = 0; i < refs->ref_cnt; i++) {
 			struct obj_ref *ref = &refs->refs[i];
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index f70702fcb224..afdfdfbf305d 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -38,6 +38,17 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	}
 }
 
+static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
+{
+	struct bpf_perf_link *perf_link;
+	struct perf_event *event;
+
+	perf_link = container_of(link, struct bpf_perf_link, link);
+	event = BPF_CORE_READ(perf_link, perf_file, private_data);
+	return BPF_CORE_READ(event, bpf_cookie);
+}
+
+
 SEC("iter/task_file")
 int iter(struct bpf_iter__task_file *ctx)
 {
@@ -71,6 +82,11 @@ int iter(struct bpf_iter__task_file *ctx)
 
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
+	e.bpf_cookie = 0;
+
+	if (obj_type == BPF_OBJ_LINK)
+		e.bpf_cookie = get_bpf_cookie((struct bpf_link *) file->private_data);
+
 	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
 				  task->group_leader->comm);
 	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
index 5692cf257adb..a631640f6fe4 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.h
+++ b/tools/bpf/bpftool/skeleton/pid_iter.h
@@ -7,6 +7,7 @@ struct pid_iter_entry {
 	__u32 id;
 	int pid;
 	char comm[16];
+	__u64 bpf_cookie;
 };
 
 #endif
-- 
2.32.0

