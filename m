Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAFF55EB39
	for <lists+bpf@lfdr.de>; Tue, 28 Jun 2022 19:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiF1Rnd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jun 2022 13:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiF1Rnb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jun 2022 13:43:31 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0E6B7EC
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:28 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id q8-20020a632a08000000b00402de053ef9so6920990pgq.3
        for <bpf@vger.kernel.org>; Tue, 28 Jun 2022 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=71zBhHqOlgavpKpxzPPbRNnJB5yGAr0x9fpb6lOWlX0=;
        b=FR0OrhvN9DytA+1OJSpLZJAHTSkIOJKN1nhWqAc0a0Sff5hjRSk9anv4BUStX6JZNN
         UKCq9E4Mlu97FB7XNN8tSJ3Np6h0QcX8hM61vkN2oC8zXq1afXFLaN08FMukA44uVfJ0
         Aj5xlhnqMOo9lTJ3tHQt5holHFT3kdH6PelV8mUugWXgB9SebfxPDE6UBMbYeDAZKgo4
         udXeppVlnKnWqGg9py+051sAxPHoiP18zlcmurpbMEPX78hTONkSfn35MlrPYAKfzvQd
         x30QRsP8obFlGHZURs5tbfRpX8Uj0A2HrxNxVFUvYtdLxE41j81U65YcWYW+jg/iwrlT
         d/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=71zBhHqOlgavpKpxzPPbRNnJB5yGAr0x9fpb6lOWlX0=;
        b=XxnVNb8uBWprTDtBeTANGdCg4l3IGjrNzIoeihMnV4dryaN7W1ayntwB8N0gF5TScS
         1gYaAUUGQyPKf825js9mImFncghXkOKOrkfWTCxSesCi1MD5hPWONWROJy5BkPKgC9gx
         DP89gGTleuMIbc8CCUzcAUwhDCtR9npJJp4TJ7uzY5ebflgpFd6bFop6JXanlGcSJ9Hp
         NjtBaCMHKVvWVbMi5XN16GGXa1qXgKshrYlPHaEtlAWnV6IQ6KEvdtcB7N4v4vbyqi/k
         +YCr1OwynGozRXsR4WNfGJx0IVaYcnnVk6rbjy3lEhZ9hy0TFfCiFhH+fUaRBjj1X+oV
         60+A==
X-Gm-Message-State: AJIora9d8QoEzpnOl8WFObMssjUrDmzJZUrHEI9lTtNc+U4h0qkqi1vr
        j3d2KrREQO67f87IHoos2PaSqrSxU31MCx+D3k9HGSWJZwhcv6C6WfmDff8w69R46QryRiV7kNv
        XN+MvEQDryPWmYP7VMrVxTKmptuHCjsh47qwaANHpHvGWmdW8/A==
X-Google-Smtp-Source: AGRyM1vCIE0X8tK5lzNqWB2uOFb1DlbaIMgOj24h+A+HiSe78ccPEiYmRcScP2awNP84eMbpjY6Doa0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:90a:760e:b0:1ec:83e0:3ae1 with SMTP id
 s14-20020a17090a760e00b001ec83e03ae1mr798106pjk.25.1656438207779; Tue, 28 Jun
 2022 10:43:27 -0700 (PDT)
Date:   Tue, 28 Jun 2022 10:43:10 -0700
In-Reply-To: <20220628174314.1216643-1-sdf@google.com>
Message-Id: <20220628174314.1216643-8-sdf@google.com>
Mime-Version: 1.0
References: <20220628174314.1216643-1-sdf@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH bpf-next v11 07/11] tools/bpf: Sync btf_ids.h to tools
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Has been slowly getting out of sync, let's update it.

resolve_btfids usage has been updated to match the header changes.

Also bring new parts of tools/include/uapi/linux/bpf.h.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/linux/btf_ids.h                 | 35 +++++++++++++++----
 tools/include/uapi/linux/bpf.h                |  3 ++
 .../selftests/bpf/prog_tests/resolve_btfids.c |  2 +-
 3 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 57890b357f85..71e54b1e3796 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -73,7 +73,7 @@ asm(							\
 __BTF_ID_LIST(name, local)				\
 extern u32 name[];
 
-#define BTF_ID_LIST_GLOBAL(name)			\
+#define BTF_ID_LIST_GLOBAL(name, n)			\
 __BTF_ID_LIST(name, globl)
 
 /* The BTF_ID_LIST_SINGLE macro defines a BTF_ID_LIST with
@@ -82,6 +82,9 @@ __BTF_ID_LIST(name, globl)
 #define BTF_ID_LIST_SINGLE(name, prefix, typename)	\
 	BTF_ID_LIST(name) \
 	BTF_ID(prefix, typename)
+#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) \
+	BTF_ID_LIST_GLOBAL(name, 1)			  \
+	BTF_ID(prefix, typename)
 
 /*
  * The BTF_ID_UNUSED macro defines 4 zero bytes.
@@ -143,13 +146,14 @@ extern struct btf_id_set name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
-#define BTF_ID_LIST_GLOBAL(name) u32 name[1];
-#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
-#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
-#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
+#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 __maybe_unused name[1];
+#define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
@@ -172,7 +176,10 @@ extern struct btf_id_set name;
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_TCP_TW, tcp_timewait_sock)		\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_TCP6, tcp6_sock)			\
 	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP, udp_sock)			\
-	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP6, udp6_sock)
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UDP6, udp6_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_UNIX, unix_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_MPTCP, mptcp_sock)			\
+	BTF_SOCK_TYPE(BTF_SOCK_TYPE_SOCKET, socket)
 
 enum {
 #define BTF_SOCK_TYPE(name, str) name,
@@ -184,4 +191,18 @@ MAX_BTF_SOCK_TYPE,
 extern u32 btf_sock_ids[];
 #endif
 
+#define BTF_TRACING_TYPE_xxx	\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_TASK, task_struct)	\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_FILE, file)		\
+	BTF_TRACING_TYPE(BTF_TRACING_TYPE_VMA, vm_area_struct)
+
+enum {
+#define BTF_TRACING_TYPE(name, type) name,
+BTF_TRACING_TYPE_xxx
+#undef BTF_TRACING_TYPE
+MAX_BTF_TRACING_TYPE,
+};
+
+extern u32 btf_tracing_ids[];
+
 #endif
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b7479898c879..ad9e7311c4cf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1432,6 +1432,7 @@ union bpf_attr {
 		__u32		attach_flags;
 		__aligned_u64	prog_ids;
 		__u32		prog_cnt;
+		__aligned_u64	prog_attach_flags; /* output: per-program attach_flags */
 	} query;
 
 	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
@@ -6076,6 +6077,8 @@ struct bpf_prog_info {
 	__u64 run_cnt;
 	__u64 recursion_misses;
 	__u32 verified_insns;
+	__u32 attach_btf_obj_id;
+	__u32 attach_btf_id;
 } __attribute__((aligned(8)));
 
 struct bpf_map_info {
diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
index f4a13d9dd5c8..c197261d02e2 100644
--- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
+++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
@@ -44,7 +44,7 @@ BTF_ID(union,   U)
 BTF_ID(func,    func)
 
 extern __u32 test_list_global[];
-BTF_ID_LIST_GLOBAL(test_list_global)
+BTF_ID_LIST_GLOBAL(test_list_global, 1)
 BTF_ID_UNUSED
 BTF_ID(typedef, S)
 BTF_ID(typedef, T)
-- 
2.37.0.rc0.161.g10f37bed90-goog

