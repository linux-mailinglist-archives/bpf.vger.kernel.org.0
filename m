Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E03B4C48DC
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 16:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbiBYP3H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 10:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240592AbiBYP3G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 10:29:06 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7807820D816
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 07:28:32 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h15so7909992edv.7
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 07:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLxf1fZDTiZpCuq+mHl7usWCDrS+N/OQtnmPAGuje4E=;
        b=VPVZ7WODFfi9ePuEabGauSKvoyQ70/GvjsF6SMmur1zT+uh0Pop24HxZvVxLFzn0qq
         XLt81b7s6VaKL4lkJMTSqDYbQq5MsepGoQWChFRwdZOrIo9Cr+rBRSi6Zh0kFV8fefUx
         JTE0pqxsr1dhlwnqlr+n12YyWdLzIvzAK0lmL8/bgNdESU0U6iyidnGk6L2kuSuJwBrF
         Zyuc9xBBe1T7YnVoyRVHCx9hMezkZHztKiCesrDlhiPvbzwCEiR3WlwOuIMI93EUie8Y
         rUlUkYJrgc0KULUL5cbOioIvLdTmN40rWkkvyQVTmwASI1lr7ra3u1ewGilSBKO21qY0
         Wq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iLxf1fZDTiZpCuq+mHl7usWCDrS+N/OQtnmPAGuje4E=;
        b=kUIGSObhAs8/3KZMhuiBMAm71xHH5coCTIyK8HUQqjBPDviR+HPuPXlHGsbFjMSKCK
         fztzFJxpQmLRRaXYEMwxEYh8BHxFYxC/HRsZjYT2bJBYH81iGYSO1e42Hm+2DNKo8rWL
         vEV9n2HZd6QAfy8UVF2justxdqrphix1iDUMXj0UO/4+Y+QaPCauojJStXJArb4Kpfzn
         vT5c5nuwykCOJxG0OGy9SliGaDoMX+CDtoUpreM43le8P69n2fnmYuCFsOuuGr6c03YL
         zpZoa1i/n5aFyxB8JvUJ3Zjm/LpIFNA5gpgDsvnw4O6SQRRRUORWM+ctM/DpNqO3AOCH
         DbhQ==
X-Gm-Message-State: AOAM533rJfvRPHUNqxkoUmXs0rvVyAx+UPlgprBbrSfTTyIbsPldZwIE
        vUrqiM2BJ/fkLKB9LpBRg6VykURG3vTMnA==
X-Google-Smtp-Source: ABdhPJxSSqYcsmGfqRV/sCuHa6BaxMzznWyO/UWRh0EwZe64tTn17iQ5/b/u4eLg255iEpb41Hk7GQ==
X-Received: by 2002:a05:6402:b9c:b0:410:d469:d73d with SMTP id cf28-20020a0564020b9c00b00410d469d73dmr7629837edb.78.1645802910941;
        Fri, 25 Feb 2022 07:28:30 -0800 (PST)
Received: from erthalion.local (dslb-178-012-046-224.178.012.pools.vodafone-ip.de. [178.12.46.224])
        by smtp.gmail.com with ESMTPSA id o8-20020a17090637c800b006cee4c6c9acsm1147938ejc.11.2022.02.25.07.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 07:28:30 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [RFC PATCH v4] bpftool: Add bpf_cookie to link output
Date:   Fri, 25 Feb 2022 16:28:02 +0100
Message-Id: <20220225152802.20957-1-9erthalion6@gmail.com>
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
Changes in v4:
    - Fetch cookies only for bpf_perf_link
    - Signal about bpf_cookie via the flag, instead of deducing it from
      the object and link type
    - Reset pid_iter_entry to avoid invalid indirect read from stack

Changes in v3:
    - Use pid iterator to fetch bpf_cookie

Changes in v2:
    - Display bpf_cookie in bpftool link command instead perf

Previous discussion: https://lore.kernel.org/bpf/20220218075103.10002-1-9erthalion6@gmail.com/

 tools/bpf/bpftool/main.h                  |  2 ++
 tools/bpf/bpftool/pids.c                  | 10 +++++++++
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 25 +++++++++++++++++++++++
 tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
 4 files changed, 39 insertions(+)

diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
index 0c3840596b5a..1bb76aa1f3b2 100644
--- a/tools/bpf/bpftool/main.h
+++ b/tools/bpf/bpftool/main.h
@@ -114,6 +114,8 @@ struct obj_ref {
 struct obj_refs {
 	int ref_cnt;
 	struct obj_ref *refs;
+	bool bpf_cookie_set;
+	__u64 bpf_cookie;
 };
 
 struct btf;
diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
index 7c384d10e95f..152502c2d6f9 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -55,6 +55,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 		ref->pid = e->pid;
 		memcpy(ref->comm, e->comm, sizeof(ref->comm));
 		refs->ref_cnt++;
+		refs->bpf_cookie_set = e->bpf_cookie_set;
+		refs->bpf_cookie = e->bpf_cookie;
 
 		return;
 	}
@@ -78,6 +80,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	refs->ref_cnt = 1;
+	refs->bpf_cookie_set = e->bpf_cookie_set;
+	refs->bpf_cookie = e->bpf_cookie;
 
 	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
 	if (err)
@@ -205,6 +209,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->bpf_cookie_set)
+			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
+
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
@@ -234,6 +241,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->bpf_cookie_set)
+			printf("\n\tbpf_cookie %llu", refs->bpf_cookie);
+
 		printf("%s", prefix);
 		for (i = 0; i < refs->ref_cnt; i++) {
 			struct obj_ref *ref = &refs->refs[i];
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
index f70702fcb224..91366ce33717 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
+++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
@@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
 	}
 }
 
+/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
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
@@ -69,8 +81,21 @@ int iter(struct bpf_iter__task_file *ctx)
 	if (file->f_op != fops)
 		return 0;
 
+	__builtin_memset(&e, 0, sizeof(e));
 	e.pid = task->tgid;
 	e.id = get_obj_id(file->private_data, obj_type);
+	e.bpf_cookie = 0;
+	e.bpf_cookie_set = false;
+
+	if (obj_type == BPF_OBJ_LINK) {
+		struct bpf_link *link = (struct bpf_link *) file->private_data;
+
+		if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
+			e.bpf_cookie_set = true;
+			e.bpf_cookie = get_bpf_cookie(link);
+		}
+	}
+
 	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
 				  task->group_leader->comm);
 	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
index 5692cf257adb..2676cece58d7 100644
--- a/tools/bpf/bpftool/skeleton/pid_iter.h
+++ b/tools/bpf/bpftool/skeleton/pid_iter.h
@@ -6,6 +6,8 @@
 struct pid_iter_entry {
 	__u32 id;
 	int pid;
+	__u64 bpf_cookie;
+	bool bpf_cookie_set;
 	char comm[16];
 };
 
-- 
2.32.0

