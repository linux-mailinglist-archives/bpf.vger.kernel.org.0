Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4177C4CD680
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 15:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiCDOhi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 09:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiCDOhi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 09:37:38 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141AC1BAF21
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 06:36:48 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id qt6so17870463ejb.11
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 06:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPWGKV7Be8rhAq6oameOx214jwmWcM7f+lzAa8k0/1g=;
        b=Bh6MMyiemv1/otcEIrdq9g1erz7n06Nu58+PRW7QXHV/QPQbWu9h+B8H8avJDfSem+
         4IiBvQ+NfFu3HySa0ekEWxliUKqriALB4qGv2XKxSjfhxwJ61e1otmAS7czYiiPdQGe5
         IUcYb5ZUSNNqu0U+BhEZKrey3P2c3QXhcrGVd33uXDjve9HMHC6NOJh04vzl693gtFB8
         xOgSqZsytKHLQxDlHPJ1XTam/eMHCtm6wjuJTuy7KLh3tAaMbvAFlirqD2b3kJLkG7n0
         FL02OlpHeEtQgfw92XtPSitAmmR09TwtXSBmub3+O/Xd3/Vm8/l+eV/nb1YqVEysQG/P
         pnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPWGKV7Be8rhAq6oameOx214jwmWcM7f+lzAa8k0/1g=;
        b=YAUP1EJl++yYglDhtq5/D5iy8iaDjiYN7g1odXViU7Y6NCFmvNhGy7wBT2KLoJKhyA
         1obS77rUO1ouSmlz+kGq1p4TOhZcUFmpuSdzAysad0blXSA9DsIqaEujgJN2Gf+TVYR3
         77BkLFhdPXiwJ+VHVDyXAKbhP48EG7zZYc84cSqLVypRaHccgxA2WYjPlzK4sNDgK2va
         ClmGQhRjhtRxVZ4md9+i52zlZ7nQBs6X4Ee0aTOO2kEUZAKs6Es1snrqRpRIytbBPU4r
         HjIl0k4oX39XB47G2tfR/cHqYLRfs+iX+MZuaGiRxBynsA7O3+PsCSXKjON0X/SsHg0R
         osNQ==
X-Gm-Message-State: AOAM5319t/F7E080xVn/KKf7p5NiKSSAH0DiU6U69nqrNJd36XMu1aBF
        bCZ3NKuiV3LYnf52aIBbT+MrWQa4Mox3Zw==
X-Google-Smtp-Source: ABdhPJyyjVKx4kXuFddh4pEJfVX+aeV/w+gz2eCtf8vVuceWWQExptstr5VzVHDYbe40slrso1/rHg==
X-Received: by 2002:a17:907:94ca:b0:6da:b785:f067 with SMTP id dn10-20020a17090794ca00b006dab785f067mr2639929ejc.654.1646404606603;
        Fri, 04 Mar 2022 06:36:46 -0800 (PST)
Received: from erthalion.local (dslb-178-005-230-047.178.005.pools.vodafone-ip.de. [178.5.230.47])
        by smtp.gmail.com with ESMTPSA id n19-20020a170906165300b006a625c583b9sm1854751ejd.155.2022.03.04.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:36:46 -0800 (PST)
From:   Dmitrii Dolgov <9erthalion6@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, quentin@isovalent.com, yhs@fb.com
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
Date:   Fri,  4 Mar 2022 15:36:10 +0100
Message-Id: <20220304143610.10796-1-9erthalion6@gmail.com>
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
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 25 +++++++++++++++++++++++
 tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
 4 files changed, 37 insertions(+)

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
index 7c384d10e95f..6c6e7c90cc3d 100644
--- a/tools/bpf/bpftool/pids.c
+++ b/tools/bpf/bpftool/pids.c
@@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
 	ref->pid = e->pid;
 	memcpy(ref->comm, e->comm, sizeof(ref->comm));
 	refs->ref_cnt = 1;
+	refs->bpf_cookie_set = e->bpf_cookie_set;
+	refs->bpf_cookie = e->bpf_cookie;
 
 	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
 	if (err)
@@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
 		if (refs->ref_cnt == 0)
 			break;
 
+		if (refs->bpf_cookie_set)
+			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
+
 		jsonw_name(json_writer, "pids");
 		jsonw_start_array(json_writer);
 		for (i = 0; i < refs->ref_cnt; i++) {
@@ -234,6 +239,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
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

