Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5ED94D359D
	for <lists+bpf@lfdr.de>; Wed,  9 Mar 2022 18:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbiCIQn5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Mar 2022 11:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236627AbiCIQgQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Mar 2022 11:36:16 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C09C26AF1
        for <bpf@vger.kernel.org>; Wed,  9 Mar 2022 08:31:49 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id b24so3560290edu.10
        for <bpf@vger.kernel.org>; Wed, 09 Mar 2022 08:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=844SbVhNSCdnApdt2qVYxeOoNErw3+B8CirEt3M2ZA4=;
        b=SDP3F7fNgJJI+Quh9xU3mGy/yTwISaWQuZ3v6SsCwUeGKh+OKUEniUPPR+hNbQTpTk
         mJYGLlfj42GsyHX/l5HC1cc9tZAjAyKBZfiak531G0fJ4/NF+k+8yUhJt1eCtsS2NrIC
         9YNeJeWIN5zsazpUaKjnum7E9AJVykjd48jcWUaorSt+xHR/uLKI5l4se30ruHp7R6dw
         60V4BxocYVlaeR2B+NcX7qu8u25ZKgFXZvgQ0duW5Ss9Vj9iltWarpUMWvf7L2M3v7Hi
         VdAUHaTUtGPLtVZjQ7PMcJUtZSEL6IpwNI4Rm8I5xr+ruRAelqWqpcDWm92tGmpOdpZx
         lkQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=844SbVhNSCdnApdt2qVYxeOoNErw3+B8CirEt3M2ZA4=;
        b=iaNvM2wp0g9upvJosYs+nLxN+r+Npx07sGqTrqopzLca8UqaExvF7HyIvF6qSlfxCE
         6beKwbJ7AMZnCd+s2+gjpL22GoA2K0kJX9nmbxpp/O6U/PWVhYTaHi5LsMsj7I8K1oOL
         OHom1JCaqcle6cv1kqPjcX5lxkvwIfKhVOpBsr+T9WcCIeQKO7cDbCLiDRYjlDF1kT4r
         teXoDtl+GsEMX1phO51GWaqYSTQ0cvuCQdVOIkzOC7JmEXUm0y51Irt1n3GNXrddnL1j
         DlC8NPKuwPbF4LWFWtYwXgB6o+PY3RqCxJo7TF68o8PcT3kR6dioU8KMn6qn0JOhZWfq
         Zo6A==
X-Gm-Message-State: AOAM530AWpHJdpbjlPfLqgY1LmyLaTIo68XQQmNyNyvPUoqLOnQV7Tvj
        AVigKz2ol+3R3Y9fmNbAwgp40bWrycwgkA==
X-Google-Smtp-Source: ABdhPJwoETpqIlUAI0rXdXeev7puxy1F03rCvWRXqiup2/FI1GLvp40ODN3BdOWf8Ra3zdImZwz2aw==
X-Received: by 2002:a05:6402:1941:b0:413:2b7e:676e with SMTP id f1-20020a056402194100b004132b7e676emr292073edz.114.1646843507534;
        Wed, 09 Mar 2022 08:31:47 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id h21-20020a170906829500b006cef3dcd067sm928161ejx.174.2022.03.09.08.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 08:31:46 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v6] bpftool: Add bpf_cookie to link output
Date:   Wed,  9 Mar 2022 17:31:12 +0100
Message-Id: <20220309163112.24141-1-9erthalion6@gmail.com>
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
Acked-by: Yonghong Song <yhs@fb.com>
---
Changes in v6:
    - Remove unnecessary initialization of fields in pid_iter_entry
    - Changing bpf_cookie_set to has_bpf_cookie
    - Small code cleanup (casting bpf_cookie when needed, removing
      __always_inline, etc.)

Changes in v5:
    - Remove unneeded cookie assigns

Changes in v4:
    - Fetch cookies only for bpf_perf_link
    - Signal about bpf_cookie via the flag, instead of deducing it from
      the object and link type
    - Reset pid_iter_entry to avoid invalid indirect read from stack

Changes in v3:
    - Use pid iterator to fetch bpf_cookie

Changes in v2:
    - Display bpf_cookie in bpftool link command instead perf

Previous discussion: https://lore.kernel.org/bpf/20220225152802.20957-1-9erthalion6@gmail.com/

 tools/bpf/bpftool/main.h                  |  2 ++
 tools/bpf/bpftool/pids.c                  |  8 ++++++++
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 22 ++++++++++++++++++++++
 tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
 4 files changed, 34 insertions(+)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0c3840596b5a..3574bef7d4ce 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -114,6 +114,8 @@ struct obj_ref {
 struct obj_refs {
 	int ref_cnt;
 	struct obj_ref *refs;
+	bool has_bpf_cookie;
+	__u64 bpf_cookie;
 };
 
 struct btf;
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 7c384d10e95f..bb6c969a114a 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	refs->ref_cnt = 1;
+	refs->has_bpf_cookie = e->has_bpf_cookie;
+	refs->bpf_cookie = e->bpf_cookie;
 
 	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
 	if (err)
@@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->has_bpf_cookie)
+			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
+
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
@@ -234,6 +239,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->has_bpf_cookie)
+			printf("\n\tbpf_cookie %llu", (unsigned long long) refs->bpf_cookie);
+
 		printf("%s", prefix);
 		for (i = 0; i < refs->ref_cnt; i++) {
 			struct obj_ref *ref = &refs->refs[i];
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index f70702fcb224..eb05ea53afb1 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -38,6 +38,17 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	}
 }
 
+/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
+static __u64 get_bpf_cookie(struct bpf_link *link)
+{
+	struct bpf_perf_link *perf_link;
+	struct perf_event *event;
+
+	perf_link = container_of(link, struct bpf_perf_link, link);
+	event = BPF_CORE_READ(perf_link, perf_file, private_data);
+	return BPF_CORE_READ(event, bpf_cookie);
+}
+
 SEC("iter/task_file")
 int iter(struct bpf_iter__task_file *ctx)
 {
@@ -69,8 +80,19 @@ int iter(struct bpf_iter__task_file *ctx)
 	if (file->f_op != fops)
 		return 0;
 
+	__builtin_memset(&e, 0, sizeof(e));
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
+
+	if (obj_type == BPF_OBJ_LINK) {
+		struct bpf_link *link = (struct bpf_link *) file->private_data;
+
+		if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
+			e.has_bpf_cookie = true;
+			e.bpf_cookie = get_bpf_cookie(link);
+		}
+	}
+
 	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
 				  task->group_leader->comm);
 	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
index 5692cf257adb..bbb570d4cca6 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.h
+++ b/tools/bpf/bpftool/skeleton/pid_iter.h
@@ -6,6 +6,8 @@
 struct pid_iter_entry {
 	__u32 id;
 	int pid;
+	__u64 bpf_cookie;
+	bool has_bpf_cookie;
 	char comm[16];
 };
 
-- 
2.32.0

