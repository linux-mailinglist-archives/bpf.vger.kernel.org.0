Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D86642DBCF
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhJNOhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbhJNOhN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:13 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE0EC061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:07 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g25so20116422wrb.2
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d0wyYzOBBIHyIQJznHdQNtkusLkJdooDK5maQza3Pxk=;
        b=fQ11nw6iE2HDuUqDiMFemjRxd3XpG+3M5mbJ/ILwutyxVBWBMUc/pd6PvI3HSpg5L6
         MmJcm0nhlxmU5yczt/C+eId3AaBGeUEKlBOmJJ40gR2W8laQmS/Y/kBdXeRuyoWOD6J5
         F8LV/V0NEx+6UEt/A8RXd0AJy1ifKFkUloQAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d0wyYzOBBIHyIQJznHdQNtkusLkJdooDK5maQza3Pxk=;
        b=6L5zxqnd0b2BAqJStu/gm23gij361psoCsRqAXbmjdyfdsJ4CtwbXkarrPKZjtre2s
         PA8SHIfmljQ9yNnGn841kqFwz4vW9kRds48QmMpjCOsEOO1RvYcogGtyKgS1fo9ynh3T
         9lnBLCnZxl0pByya5SzRi+plaDQsKs2mTbrV9btxFCPfR1iLR6KcPSUQNq2N3j8InTak
         O0sbnqaUf8O/BL/2sZYg3LqGyiz1je6b4o5LKSez3UBMjcOu0TYaPMXPV/DF058PbCVu
         Ipc6ulDbbcDhIeCqcY2hGEP8fXZmjMWmqGmVuj6HWbXKCUPjqvDU9n+IfzAA50Gq4XI1
         19qQ==
X-Gm-Message-State: AOAM532UI85aXjo/Ul2SDaMLQ3JqaQcA8LNDsX2D8Ycu7xf8l/MlFR5b
        urQaUbTlB0chiGWEOVxho/8JOTTZ7HTxoQ==
X-Google-Smtp-Source: ABdhPJwzZJQdE6d6eyaCQSRubL//NxIabDqUHbBvcoMACEo/yfIoK2TZVAqXvxfHtOgb/n9G8h3smQ==
X-Received: by 2002:a7b:c742:: with SMTP id w2mr6227404wmk.61.1634222103092;
        Thu, 14 Oct 2021 07:35:03 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 8/9] selftests: sync bpf.h
Date:   Thu, 14 Oct 2021 15:34:35 +0100
Message-Id: <20211014143436.54470-12-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 tools/include/uapi/linux/bpf.h | 200 ++++++++++++++++++++++-----------
 1 file changed, 134 insertions(+), 66 deletions(-)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6fc59d61937a..d3acd12d98c1 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -49,8 +49,14 @@
 #define BPF_XCHG	(0xe0 | BPF_FETCH)	/* atomic exchange */
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
+#define __bpf_md_ptr(type, name)	\
+union {					\
+	type name;			\
+	__u64 name##_u64;		\
+} __attribute__((aligned(8)))
+
 /* Register numbers */
-enum {
+enum bpf_reg {
 	BPF_REG_0 = 0,
 	BPF_REG_1,
 	BPF_REG_2,
@@ -1056,16 +1062,19 @@ enum bpf_link_type {
  * All eligible programs are executed regardless of return code from
  * earlier programs.
  */
-#define BPF_F_ALLOW_OVERRIDE	(1U << 0)
-#define BPF_F_ALLOW_MULTI	(1U << 1)
-#define BPF_F_REPLACE		(1U << 2)
+enum bpf_prog_attach_flag {
+	BPF_F_ALLOW_OVERRIDE	= (1U << 0),
+	BPF_F_ALLOW_MULTI	= (1U << 1),
+	BPF_F_REPLACE		= (1U << 2),
+};
 
+enum bpf_prog_load_flag {
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
  * has been built with CONFIG_EFFICIENT_UNALIGNED_ACCESS not set,
  * and NET_IP_ALIGN defined to 2.
  */
-#define BPF_F_STRICT_ALIGNMENT	(1U << 0)
+	BPF_F_STRICT_ALIGNMENT = (1U << 0),
 
 /* If BPF_F_ANY_ALIGNMENT is used in BPF_PROF_LOAD command, the
  * verifier will allow any alignment whatsoever.  On platforms
@@ -1079,7 +1088,7 @@ enum bpf_link_type {
  * of an unaligned access the alignment check would trigger before
  * the one we are interested in.
  */
-#define BPF_F_ANY_ALIGNMENT	(1U << 1)
+	BPF_F_ANY_ALIGNMENT = (1U << 1),
 
 /* BPF_F_TEST_RND_HI32 is used in BPF_PROG_LOAD command for testing purpose.
  * Verifier does sub-register def/use analysis and identifies instructions whose
@@ -1097,10 +1106,10 @@ enum bpf_link_type {
  * Then, if verifier is not doing correct analysis, such randomization will
  * regress tests to expose bugs.
  */
-#define BPF_F_TEST_RND_HI32	(1U << 2)
+	BPF_F_TEST_RND_HI32 = (1U << 2),
 
 /* The verifier internal test flag. Behavior is undefined */
-#define BPF_F_TEST_STATE_FREQ	(1U << 3)
+	BPF_F_TEST_STATE_FREQ = (1U << 3),
 
 /* If BPF_F_SLEEPABLE is used in BPF_PROG_LOAD command, the verifier will
  * restrict map and helper usage for such programs. Sleepable BPF programs can
@@ -1108,8 +1117,10 @@ enum bpf_link_type {
  * Such programs are allowed to use helpers that may sleep like
  * bpf_copy_from_user().
  */
-#define BPF_F_SLEEPABLE		(1U << 4)
+	BPF_F_SLEEPABLE = (1U << 4),
+};
 
+enum bpf_pseudo_src_reg {
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1121,8 +1132,8 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of map
  * verifier type:    CONST_PTR_TO_MAP
  */
-#define BPF_PSEUDO_MAP_FD	1
-#define BPF_PSEUDO_MAP_IDX	5
+	BPF_PSEUDO_MAP_FD  = 1,
+	BPF_PSEUDO_MAP_IDX = 5,
 
 /* insn[0].src_reg:  BPF_PSEUDO_MAP_[IDX_]VALUE
  * insn[0].imm:      map fd or fd_idx
@@ -1132,8 +1143,8 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of map[0]+offset
  * verifier type:    PTR_TO_MAP_VALUE
  */
-#define BPF_PSEUDO_MAP_VALUE		2
-#define BPF_PSEUDO_MAP_IDX_VALUE	6
+	BPF_PSEUDO_MAP_VALUE     = 2,
+	BPF_PSEUDO_MAP_IDX_VALUE = 6,
 
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
@@ -1144,7 +1155,7 @@ enum bpf_link_type {
  * verifier type:    PTR_TO_BTF_ID or PTR_TO_MEM, depending on whether the var
  *                   is struct/union.
  */
-#define BPF_PSEUDO_BTF_ID	3
+	BPF_PSEUDO_BTF_ID = 3,
 /* insn[0].src_reg:  BPF_PSEUDO_FUNC
  * insn[0].imm:      insn offset to the func
  * insn[1].imm:      0
@@ -1153,19 +1164,20 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of the function
  * verifier type:    PTR_TO_FUNC.
  */
-#define BPF_PSEUDO_FUNC		4
+	BPF_PSEUDO_FUNC = 4,
 
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
-#define BPF_PSEUDO_CALL		1
+	BPF_PSEUDO_CALL = 1,
 /* when bpf_call->src_reg == BPF_PSEUDO_KFUNC_CALL,
  * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the running kernel
  */
-#define BPF_PSEUDO_KFUNC_CALL	2
+	BPF_PSEUDO_KFUNC_CALL = 2,
+};
 
 /* flags for BPF_MAP_UPDATE_ELEM command */
-enum {
+enum bpf_map_update_elem_flag {
 	BPF_ANY		= 0, /* create new element or update existing */
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
@@ -1173,7 +1185,7 @@ enum {
 };
 
 /* flags for BPF_MAP_CREATE command */
-enum {
+enum bpf_map_create_flag {
 	BPF_F_NO_PREALLOC	= (1U << 0),
 /* Instead of having one common LRU list in the
  * BPF_MAP_TYPE_LRU_[PERCPU_]HASH map, use a percpu LRU list
@@ -1213,17 +1225,19 @@ enum {
 };
 
 /* Flags for BPF_PROG_QUERY. */
-
+enum bpf_prog_query_flag {
 /* Query effective (directly attached + inherited from ancestor cgroups)
  * programs that will be executed for events within a cgroup.
  * attach_flags with this flag are returned only for directly attached programs.
  */
-#define BPF_F_QUERY_EFFECTIVE	(1U << 0)
-
-/* Flags for BPF_PROG_TEST_RUN */
+	BPF_F_QUERY_EFFECTIVE = (1U << 0),
+};
 
+/* Flags for BPF_PROG_RUN */
+enum bpf_prog_run_flag {
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
-#define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
+	BPF_F_TEST_RUN_ON_CPU = (1U << 0),
+};
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
@@ -1240,7 +1254,10 @@ enum bpf_stack_build_id_status {
 	BPF_STACK_BUILD_ID_IP = 2,
 };
 
-#define BPF_BUILD_ID_SIZE 20
+enum {
+	BPF_BUILD_ID_SIZE = 20,
+};
+
 struct bpf_stack_build_id {
 	__s32		status;
 	unsigned char	build_id[BPF_BUILD_ID_SIZE];
@@ -1250,41 +1267,68 @@ struct bpf_stack_build_id {
 	};
 };
 
-#define BPF_OBJ_NAME_LEN 16U
+enum {
+	BPF_OBJ_NAME_LEN = 16U,
+};
+
+struct bpf_map_create_attr {
+	__u32	map_type;	/* one of enum bpf_map_type */
+	__u32	key_size;	/* size of key in bytes */
+	__u32	value_size;	/* size of value in bytes */
+	__u32	max_entries;	/* max number of entries in a map */
+	__u32	map_flags;	/* BPF_MAP_CREATE related
+				 * flags defined above.
+				 */
+	__u32	inner_map_fd;	/* fd pointing to the inner map */
+	__u32	numa_node;	/* numa node (effective only if
+				 * BPF_F_NUMA_NODE is set).
+				 */
+	char	map_name[BPF_OBJ_NAME_LEN];
+	__u32	map_ifindex;	/* ifindex of netdev to create on */
+	__u32	btf_fd;		/* fd pointing to a BTF type data */
+	__u32	btf_key_type_id;	/* BTF type_id of the key */
+	__u32	btf_value_type_id;	/* BTF type_id of the value */
+	__u32	btf_vmlinux_value_type_id;	/* BTF type_id of a kernel-
+						 * struct stored as the
+						 * map value
+						 */
+};
+
+struct bpf_map_lookup_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, value);
+	__u64 flags;
+};
+
+struct bpf_map_update_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, value);
+	__u64 flags;
+};
+
+struct bpf_map_delete_elem_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+};
+
+struct bpf_map_get_next_key_attr {
+	__u32 map_fd;
+	__bpf_md_ptr(const void *, key);
+	__bpf_md_ptr(void *, next_key);
+};
 
 union bpf_attr {
-	struct { /* anonymous struct used by BPF_MAP_CREATE command */
-		__u32	map_type;	/* one of enum bpf_map_type */
-		__u32	key_size;	/* size of key in bytes */
-		__u32	value_size;	/* size of value in bytes */
-		__u32	max_entries;	/* max number of entries in a map */
-		__u32	map_flags;	/* BPF_MAP_CREATE related
-					 * flags defined above.
-					 */
-		__u32	inner_map_fd;	/* fd pointing to the inner map */
-		__u32	numa_node;	/* numa node (effective only if
-					 * BPF_F_NUMA_NODE is set).
-					 */
-		char	map_name[BPF_OBJ_NAME_LEN];
-		__u32	map_ifindex;	/* ifindex of netdev to create on */
-		__u32	btf_fd;		/* fd pointing to a BTF type data */
-		__u32	btf_key_type_id;	/* BTF type_id of the key */
-		__u32	btf_value_type_id;	/* BTF type_id of the value */
-		__u32	btf_vmlinux_value_type_id;/* BTF type_id of a kernel-
-						   * struct stored as the
-						   * map value
-						   */
-	};
+	struct bpf_map_create_attr map_create;
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
-		__u32		map_fd;
-		__aligned_u64	key;
-		union {
-			__aligned_u64 value;
-			__aligned_u64 next_key;
-		};
-		__u64		flags;
-	};
+	struct bpf_map_lookup_elem_attr map_lookup_elem;
+
+	struct bpf_map_update_elem_attr map_update_elem;
+
+	struct bpf_map_delete_elem_attr map_delete_elem;
+
+	struct bpf_map_get_next_key_attr map_get_next_key;
 
 	struct { /* struct used by BPF_MAP_*_BATCH commands */
 		__aligned_u64	in_batch;	/* start batch,
@@ -1487,6 +1531,32 @@ union bpf_attr {
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
 
+	/* DEPRECATED: these are kept for compatibility purposes. */
+	struct { /* anonymous struct used by BPF_MAP_CREATE command */
+		__u32	map_type;
+		__u32	key_size;
+		__u32	value_size;
+		__u32	max_entries;
+		__u32	map_flags;
+		__u32	inner_map_fd;
+		__u32	numa_node;
+		char	map_name[BPF_OBJ_NAME_LEN];
+		__u32	map_ifindex;
+		__u32	btf_fd;
+		__u32	btf_key_type_id;
+		__u32	btf_value_type_id;
+		__u32	btf_vmlinux_value_type_id;
+	};
+
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+		__u32		map_fd;
+		__aligned_u64	key;
+		union {
+			__aligned_u64 value;
+			__aligned_u64 next_key;
+		};
+		__u64		flags;
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
@@ -5230,7 +5300,7 @@ enum {
 };
 
 /* BPF ring buffer constants */
-enum {
+enum bpf_ringbuf_const {
 	BPF_RINGBUF_BUSY_BIT		= (1U << 31),
 	BPF_RINGBUF_DISCARD_BIT		= (1U << 30),
 	BPF_RINGBUF_HDR_SZ		= 8,
@@ -5272,12 +5342,6 @@ enum {
 	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4),
 };
 
-#define __bpf_md_ptr(type, name)	\
-union {					\
-	type name;			\
-	__u64 :64;			\
-} __attribute__((aligned(8)))
-
 /* user accessible mirror of in-kernel sk_buff.
  * new fields can only be added to the end of this structure
  */
@@ -5456,7 +5520,9 @@ struct bpf_xdp_sock {
 	__u32 queue_id;
 };
 
-#define XDP_PACKET_HEADROOM 256
+enum {
+	XDP_PACKET_HEADROOM = 256,
+};
 
 /* User return codes for XDP prog type.
  * A valid XDP program must return one of these defined values. All other
@@ -5574,7 +5640,9 @@ struct sk_reuseport_md {
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
 };
 
-#define BPF_TAG_SIZE	8
+enum {
+	BPF_TAG_SIZE = 8,
+};
 
 struct bpf_prog_info {
 	__u32 type;
-- 
2.30.2

