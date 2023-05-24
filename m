Return-Path: <bpf+bounces-1187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD6170FF96
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 23:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C17C51C20D8F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 21:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1822625;
	Wed, 24 May 2023 21:03:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F855182A2
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 21:03:02 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDD6BF
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:57 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OH9vP3029316
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:57 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qsde0dgnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 14:02:56 -0700
Received: from twshared18891.17.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 24 May 2023 14:02:55 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
	id 633DD31486D62; Wed, 24 May 2023 14:02:47 -0700 (PDT)
From: Andrii Nakryiko <andrii@kernel.org>
To: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <martin.lau@kernel.org>
CC: <andrii@kernel.org>, <kernel-team@meta.com>
Subject: [PATCH RFC bpf-next 1/3] bpf: revamp bpf_attr and name each command's field and substruct
Date: Wed, 24 May 2023 14:02:41 -0700
Message-ID: <20230524210243.605832-2-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230524210243.605832-1-andrii@kernel.org>
References: <20230524210243.605832-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: y34GCQLYo3you0RsC1pzlsRnhRoS11ni
X-Proofpoint-ORIG-GUID: y34GCQLYo3you0RsC1pzlsRnhRoS11ni
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_15,2023-05-24_01,2023-05-22_02
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

union bpf_attr, used to provide input argument to bpf() syscall, has
per-command (or sometimes a per-group of commands) substruct section
with relevant arguments.

Unfortunately, as it evolved, we ended up with a situation where some
commands use anonymous struct field and some other named fields. Member
of anonymous field structs are basically in a "global namespace" and
would potentially conflict with fields in other such anonymous field
substruct. This means that commands like BPF_PROG_LOAD, BPF_BTF_LOAD,
BPF_MAP_CREATE, etc have to avoid naming fields the same, even if it
makes total sense. E.g., just because of this, BPF_BTF_LOAD couldn't
have uniformly and logically named `log_level`, `log_size`, and
`log_buf` fields, and we had to "namespace" them as `btf_log_level`,
`btf_log_size`, and `btf_log_buf`. If some other command relying on
anonymous field struct would like to add logging support, we'd need to
use yet another naming prefix to avoid conflicts with BPF_PROG_LOAD.

This is quite suboptimal to say the least, espcially when needing to add
some conceptually the same field across multiple commands. One such
example might be "token_fd" that would represent a BPF token object
(patches not posted yet, just an example and motivating case for these
changes). It would be great to just add `__u32 token_fd;` across
multiple commands with uniform name, but with current state of `union
bpf_attr` this is impossible, and we'll need to do `prog_load_token_fd`
vs `map_create_token_fd` vs `btf_load_token_fd`, etc.

This patch is attempting to rectify this situation and set bpf_attr and
bpf() syscall for cleaner evolution story. To that end, each command or
group of similar commands always use named fields. E.g., BPF_PROG_CREATE
will have `prog_create` field with a struct that contains all relevant
attributes. Of course, we can't break backwards compatibility, so to
make all the old code both compile with no changes and keep working with
no changes, we keep all the currently anonymous field structs, just move
them to the end into "LEGACY" section of bpf_attr. In their stead,
though, we add named field with exactly the same memory layout and
(mostly) the same field names. This makes sure that layout is exactly
the same, but gives each command its own naming namespace that will
allow to make naming decisions independent from any other command.

Another aspect is that these per-command structs are not anonymous
anymore, and they are actually named now. This significantly minimizes
amount of user-space code changes for applications and libraries that
would like to use new named field substructs (e.g., like libbpf in the
next patch). But this is not even the main benefit. Having each
substruct named allows to reduce accidental use of wrong fields that
don't belong to a given command. Follow up kernel-side patch
demonstrates how we can modify kernel code to ensure that we only work
with per-command part of bpf_attr, instead of hoping to never mix up
field names.

Given we keep source code and ABI backwards compat, we can do gradual
migration of both kernel and user-space code to new named substructs,
where necessary and/or benefitial.

While at it, I've used an opportunity to split some commands that just
happened to be "colocated" in terms of which substruct was used, but
that are conceptually completely separate. E.g., BPF_MAP_FREEZE gets its
own tiny struct. GET_FD_BY_ID group is split from OBJ_GET_NEXT_ID
command. I've also split PROG_ATTACH from PROG_DETACH, OBJ_PIN from
OBJ_GET, etc.

Also some fields were renamed to make their use clearer (e.g., for
PROG_DETACH `attach_bpf_fd` made no sense). For GET_FD_BY_ID union of
"link_id", "prog_id", "map_id", and "btf_id" were unified into "obj_id",
which matches struct's `bpf_obj_fd_by_id_attr` name nicely.

For a few commands we had a mix of "flags", "file_flags", and
"open_flags". What's worse, "file_flags" for OBJ_PIN/OBJ_GET is already
a misnomer as it has more than just file permissions flags. So for few
of those commands where there was single flags field, I unified the
naming to be just "flags".

For OBJ_GET command "bpf_fd" was meaningless, so I renamed it to
"__reserved" and we could reuse it later, if necessary. For
MAP_{LOOKUP,DELETE,etc}_ELEM, `next_key` field was meaningless and
dropped. It stayed in split out bpf_map_next_key_attr struct, which had
`value` dropped.

And there were a bunch of other similar changes. Please take a thorough
look and suggest more changes or which changes to drop. I'm not married
to any of them, it just felt like a good improvement.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 include/uapi/linux/bpf.h       | 235 +++++++++++++++++++++++++++------
 kernel/bpf/syscall.c           |  40 +++---
 tools/include/uapi/linux/bpf.h | 235 +++++++++++++++++++++++++++------
 3 files changed, 405 insertions(+), 105 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9273c654743c..83066cc0f24b 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1320,7 +1320,8 @@ struct bpf_stack_build_id {
 #define BPF_OBJ_NAME_LEN 16U
=20
 union bpf_attr {
-	struct { /* anonymous struct used by BPF_MAP_CREATE command */
+	/* BPF_MAP_CREATE command */
+	struct bpf_map_create_attr {
 		__u32	map_type;	/* one of enum bpf_map_type */
 		__u32	key_size;	/* size of key in bytes */
 		__u32	value_size;	/* size of value in bytes */
@@ -1348,19 +1349,30 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
-	};
+	} map_create;
=20
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	/* BPF_MAP_{LOOKUP,UPDATE,DELETE,LOOKUP_AND_DELETE}_ELEM commands */
+	struct bpf_map_elem_attr {
 		__u32		map_fd;
 		__aligned_u64	key;
-		union {
-			__aligned_u64 value;
-			__aligned_u64 next_key;
-		};
+		__aligned_u64	value;
 		__u64		flags;
-	};
+	} map_elem;
=20
-	struct { /* struct used by BPF_MAP_*_BATCH commands */
+	/* BPF_MAP_GET_NEXT_KEY command */
+	struct bpf_map_next_key_attr {
+		__u32		map_fd;
+		__aligned_u64	key;
+		__aligned_u64	next_key;
+	} map_next_key;
+
+	/* BPF_MAP_FREEZE command */
+	struct bpf_map_freeze_attr {
+		__u32		map_fd;
+	} map_freeze;
+
+	/* BPF_MAP_{LOOKUP,UPDATE,DELETE,LOOKUP_AND_DELETE}_BATCH commands */
+	struct bpf_map_batch_attr {
 		__aligned_u64	in_batch;	/* start batch,
 						 * NULL to start from beginning
 						 */
@@ -1377,7 +1389,8 @@ union bpf_attr {
 		__u64		flags;
 	} batch;
=20
-	struct { /* anonymous struct used by BPF_PROG_LOAD command */
+	/* BPF_PROG_LOAD command */
+	struct bpf_prog_load_attr {
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
 		__aligned_u64	insns;
@@ -1417,12 +1430,13 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
-	};
+	} prog_load;
=20
-	struct { /* anonymous struct used by BPF_OBJ_* commands */
+	/* BPF_OBJ_PIN command */
+	struct bpf_obj_pin_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
-		__u32		file_flags;
+		__u32		flags;
 		/* Same as dirfd in openat() syscall; see openat(2)
 		 * manpage for details of path FD and pathname semantics;
 		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
@@ -1430,9 +1444,24 @@ union bpf_attr {
 		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
 		 */
 		__s32		path_fd;
-	};
+	} obj_pin;
=20
-	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
+	/* BPF_OBJ_GET command */
+	struct bpf_obj_get_attr {
+		__aligned_u64	pathname;
+		__u32		__reserved;
+		__u32		flags;
+		/* Same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of path FD and pathname semantics;
+		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
+		 * file_flags field, otherwise it should be set to zero;
+		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
+		 */
+		__s32		path_fd;
+	} obj_get;
+
+	/* BPF_PROG_ATTACH command */
+	struct bpf_prog_attach_attr {
 		__u32		target_fd;	/* container object to attach to */
 		__u32		attach_bpf_fd;	/* eBPF program to attach */
 		__u32		attach_type;
@@ -1441,9 +1470,16 @@ union bpf_attr {
 						 * program to replace if
 						 * BPF_F_REPLACE is used
 						 */
-	};
+	} prog_attach;
=20
-	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
+	/* BPF_PROG_DETACH command */
+	struct bpf_prog_detach_attr {
+		__u32		target_fd;	/* container object to attach to */
+		__u32		prog_fd;	/* eBPF program to detach */
+		__u32		attach_type;
+	} prog_detach;
+
+	struct bpf_prog_run_attr { /* anonymous struct used by BPF_PROG_TEST_RU=
N command */
 		__u32		prog_fd;
 		__u32		retval;
 		__u32		data_size_in;	/* input: len of data_in */
@@ -1467,25 +1503,26 @@ union bpf_attr {
 		__u32		batch_size;
 	} test;
=20
-	struct { /* anonymous struct used by BPF_*_GET_*_ID */
-		union {
-			__u32		start_id;
-			__u32		prog_id;
-			__u32		map_id;
-			__u32		btf_id;
-			__u32		link_id;
-		};
+	/* BPF_{MAP,PROG,BTF,LINK}_GET_FD_BY_ID commands */
+	struct bpf_obj_fd_by_id_attr {
+		__u32		obj_id;
+		__u32		__reserved;
+		__u32		flags;
+	} obj_fd_by_id;
+
+	/* BPF_OBJ_GET_NEXT_ID command */
+	struct bpf_obj_next_id_attr {
+		__u32		start_id;
 		__u32		next_id;
-		__u32		open_flags;
-	};
+	} obj_next_id;
=20
-	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
+	struct bpf_obj_info_by_fd_attr { /* anonymous struct used by BPF_OBJ_GE=
T_INFO_BY_FD */
 		__u32		bpf_fd;
 		__u32		info_len;
 		__aligned_u64	info;
 	} info;
=20
-	struct { /* anonymous struct used by BPF_PROG_QUERY command */
+	struct bpf_prog_query_attr { /* anonymous struct used by BPF_PROG_QUERY=
 command */
 		__u32		target_fd;	/* container object to query */
 		__u32		attach_type;
 		__u32		query_flags;
@@ -1498,25 +1535,26 @@ union bpf_attr {
 		__aligned_u64	prog_attach_flags;
 	} query;
=20
-	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
+	struct bpf_raw_tp_open_attr { /* anonymous struct used by BPF_RAW_TRACE=
POINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
 	} raw_tracepoint;
=20
-	struct { /* anonymous struct for BPF_BTF_LOAD */
+	/* BPF_BTF_LOAD command */
+	struct bpf_btf_load_attr {
 		__aligned_u64	btf;
-		__aligned_u64	btf_log_buf;
+		__aligned_u64	log_buf;
 		__u32		btf_size;
-		__u32		btf_log_size;
-		__u32		btf_log_level;
+		__u32		log_size;
+		__u32		log_level;
 		/* output: actual total log contents size (including termintaing zero)=
.
 		 * It could be both larger than original log_size (if log was
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
-		__u32		btf_log_true_size;
-	};
+		__u32		log_true_size;
+	} btf_load;
=20
-	struct {
+	struct bpf_task_fd_query_attr {
 		__u32		pid;		/* input: pid */
 		__u32		fd;		/* input: fd */
 		__u32		flags;		/* input: flags */
@@ -1532,7 +1570,7 @@ union bpf_attr {
 		__u64		probe_addr;	/* output: probe_addr */
 	} task_fd_query;
=20
-	struct { /* struct used by BPF_LINK_CREATE command */
+	struct bpf_link_create_attr { /* struct used by BPF_LINK_CREATE command=
 */
 		union {
 			__u32		prog_fd;	/* eBPF program to attach */
 			__u32		map_fd;		/* struct_ops to attach */
@@ -1581,7 +1619,7 @@ union bpf_attr {
 		};
 	} link_create;
=20
-	struct { /* struct used by BPF_LINK_UPDATE command */
+	struct bpf_link_update_attr { /* struct used by BPF_LINK_UPDATE command=
 */
 		__u32		link_fd;	/* link fd */
 		union {
 			/* new program fd to update link with */
@@ -1602,25 +1640,136 @@ union bpf_attr {
 		};
 	} link_update;
=20
-	struct {
+	struct bpf_link_detach_attr {
 		__u32		link_fd;
 	} link_detach;
=20
-	struct { /* struct used by BPF_ENABLE_STATS command */
+	struct bpf_enable_stats_attr { /* struct used by BPF_ENABLE_STATS comma=
nd */
 		__u32		type;
 	} enable_stats;
=20
-	struct { /* struct used by BPF_ITER_CREATE command */
+	struct bpf_iter_create_attr { /* struct used by BPF_ITER_CREATE command=
 */
 		__u32		link_fd;
 		__u32		flags;
 	} iter_create;
=20
-	struct { /* struct used by BPF_PROG_BIND_MAP command */
+	struct bpf_prog_bind_map_attr { /* struct used by BPF_PROG_BIND_MAP com=
mand */
 		__u32		prog_fd;
 		__u32		map_fd;
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	/*
+	 * LEGACY anonymous substructs, for backwards compatibility.
+	 * Each of the below anonymous substructs are ABI compatible with one
+	 * of the above named substructs. Please use named substructs.
+	 */
+
+	struct { /* legacy BPF_MAP_CREATE attrs, use .map_create instead */
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
+		__u64	map_extra;
+	};
+	/*
+	 * legacy BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY attrs,
+	 * use .map_elem or .get_next_key, respectively, instead
+	 */
+	struct {
+		__u32		map_fd;
+		__aligned_u64	key;
+		union {
+			__aligned_u64 value;
+			__aligned_u64 next_key;
+		};
+		__u64		flags;
+	};
+	struct { /* legacy BPF_PROG_LOAD attrs, use .prog_load instead */
+		__u32		prog_type;
+		__u32		insn_cnt;
+		__aligned_u64	insns;
+		__aligned_u64	license;
+		__u32		log_level;
+		__u32		log_size;
+		__aligned_u64	log_buf;
+		__u32		kern_version;
+		__u32		prog_flags;
+		char		prog_name[BPF_OBJ_NAME_LEN];
+		__u32		prog_ifindex;
+		__u32		expected_attach_type;
+		__u32		prog_btf_fd;
+		__u32		func_info_rec_size;
+		__aligned_u64	func_info;
+		__u32		func_info_cnt;
+		__u32		line_info_rec_size;
+		__aligned_u64	line_info;
+		__u32		line_info_cnt;
+		__u32		attach_btf_id;
+		union {
+			__u32		attach_prog_fd;
+			__u32		attach_btf_obj_fd;
+		};
+		__u32		core_relo_cnt;
+		__aligned_u64	fd_array;
+		__aligned_u64	core_relos;
+		__u32		core_relo_rec_size;
+		__u32		log_true_size;
+	};
+	/* legacy BPF_OBJ_{PIN, GET} attrs, use .obj_pin or .obj_get instead */
+	struct {
+		__aligned_u64	pathname;
+		__u32		bpf_fd;
+		__u32		file_flags;
+		__s32		path_fd;
+	};
+	/*
+	 * legacy BPF_PROG_{ATTACH,DETACH} attrs,
+	 * use .prog_attach or .prog_detach instead
+	 */
+	struct {
+		__u32		target_fd;	/* container object to attach to */
+		__u32		attach_bpf_fd;	/* eBPF program to attach */
+		__u32		attach_type;
+		__u32		attach_flags;
+		__u32		replace_bpf_fd;	/* previously attached eBPF
+						 * program to replace if
+						 * BPF_F_REPLACE is used
+						 */
+	};
+	/*
+	 * legacy BPF_*_GET_FD_BY_ID and BPF_OBJ_GET_NEXT_ID attrs,
+	 * use .obj_fd_by_id or .obj_next_id, respectively, instead
+	 */
+	struct {
+		union {
+			__u32		start_id;
+			__u32		prog_id;
+			__u32		map_id;
+			__u32		btf_id;
+			__u32		link_id;
+		};
+		__u32		next_id;
+		__u32		open_flags;
+	};
+	/* legacy BPF_BTF_LOAD attrs, use .btf_load instead */
+	struct {
+		__aligned_u64	btf;
+		__aligned_u64	btf_log_buf;
+		__u32		btf_size;
+		__u32		btf_log_size;
+		__u32		btf_log_level;
+		__u32		btf_log_true_size;
+	};
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c7f6807215e6..babf1d56c2d9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1123,7 +1123,7 @@ static int map_check_btf(struct bpf_map *map, const=
 struct btf *btf,
 	return ret;
 }
=20
-#define BPF_MAP_CREATE_LAST_FIELD map_extra
+#define BPF_MAP_CREATE_LAST_FIELD map_create.map_extra
 /* called via syscall */
 static int map_create(union bpf_attr *attr)
 {
@@ -1352,7 +1352,7 @@ static void *___bpf_copy_key(bpfptr_t ukey, u64 key=
_size)
 }
=20
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_MAP_LOOKUP_ELEM_LAST_FIELD flags
+#define BPF_MAP_LOOKUP_ELEM_LAST_FIELD map_elem.flags
=20
 static int map_lookup_elem(union bpf_attr *attr)
 {
@@ -1427,7 +1427,7 @@ static int map_lookup_elem(union bpf_attr *attr)
 }
=20
=20
-#define BPF_MAP_UPDATE_ELEM_LAST_FIELD flags
+#define BPF_MAP_UPDATE_ELEM_LAST_FIELD map_elem.flags
=20
 static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -1483,7 +1483,7 @@ static int map_update_elem(union bpf_attr *attr, bp=
fptr_t uattr)
 	return err;
 }
=20
-#define BPF_MAP_DELETE_ELEM_LAST_FIELD key
+#define BPF_MAP_DELETE_ELEM_LAST_FIELD map_elem.key
=20
 static int map_delete_elem(union bpf_attr *attr, bpfptr_t uattr)
 {
@@ -1538,7 +1538,7 @@ static int map_delete_elem(union bpf_attr *attr, bp=
fptr_t uattr)
 }
=20
 /* last field in 'union bpf_attr' used by this command */
-#define BPF_MAP_GET_NEXT_KEY_LAST_FIELD next_key
+#define BPF_MAP_GET_NEXT_KEY_LAST_FIELD map_next_key.next_key
=20
 static int map_get_next_key(union bpf_attr *attr)
 {
@@ -1817,7 +1817,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
 	return err;
 }
=20
-#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
+#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD map_elem.flags
=20
 static int map_lookup_and_delete_elem(union bpf_attr *attr)
 {
@@ -1910,7 +1910,7 @@ static int map_lookup_and_delete_elem(union bpf_att=
r *attr)
 	return err;
 }
=20
-#define BPF_MAP_FREEZE_LAST_FIELD map_fd
+#define BPF_MAP_FREEZE_LAST_FIELD map_freeze.map_fd
=20
 static int map_freeze(const union bpf_attr *attr)
 {
@@ -2493,7 +2493,7 @@ static bool is_perfmon_prog_type(enum bpf_prog_type=
 prog_type)
 }
=20
 /* last field in 'union bpf_attr' used by this command */
-#define	BPF_PROG_LOAD_LAST_FIELD log_true_size
+#define BPF_PROG_LOAD_LAST_FIELD prog_load.log_true_size
=20
 static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr=
_size)
 {
@@ -2697,13 +2697,13 @@ static int bpf_prog_load(union bpf_attr *attr, bp=
fptr_t uattr, u32 uattr_size)
 	return err;
 }
=20
-#define BPF_OBJ_LAST_FIELD path_fd
+#define BPF_OBJ_PIN_LAST_FIELD obj_pin.path_fd
=20
 static int bpf_obj_pin(const union bpf_attr *attr)
 {
 	int path_fd;
=20
-	if (CHECK_ATTR(BPF_OBJ) || attr->file_flags & ~BPF_F_PATH_FD)
+	if (CHECK_ATTR(BPF_OBJ_PIN) || attr->file_flags & ~BPF_F_PATH_FD)
 		return -EINVAL;
=20
 	/* path_fd has to be accompanied by BPF_F_PATH_FD flag */
@@ -2715,11 +2715,13 @@ static int bpf_obj_pin(const union bpf_attr *attr=
)
 				u64_to_user_ptr(attr->pathname));
 }
=20
+#define BPF_OBJ_GET_LAST_FIELD obj_get.path_fd
+
 static int bpf_obj_get(const union bpf_attr *attr)
 {
 	int path_fd;
=20
-	if (CHECK_ATTR(BPF_OBJ) || attr->bpf_fd !=3D 0 ||
+	if (CHECK_ATTR(BPF_OBJ_GET) || attr->bpf_fd !=3D 0 ||
 	    attr->file_flags & ~(BPF_OBJ_FLAG_MASK | BPF_F_PATH_FD))
 		return -EINVAL;
=20
@@ -3526,7 +3528,7 @@ attach_type_to_prog_type(enum bpf_attach_type attac=
h_type)
 	}
 }
=20
-#define BPF_PROG_ATTACH_LAST_FIELD replace_bpf_fd
+#define BPF_PROG_ATTACH_LAST_FIELD prog_attach.replace_bpf_fd
=20
 #define BPF_F_ATTACH_MASK \
 	(BPF_F_ALLOW_OVERRIDE | BPF_F_ALLOW_MULTI | BPF_F_REPLACE)
@@ -3590,7 +3592,7 @@ static int bpf_prog_attach(const union bpf_attr *at=
tr)
 	return ret;
 }
=20
-#define BPF_PROG_DETACH_LAST_FIELD attach_type
+#define BPF_PROG_DETACH_LAST_FIELD prog_detach.attach_type
=20
 static int bpf_prog_detach(const union bpf_attr *attr)
 {
@@ -3706,7 +3708,7 @@ static int bpf_prog_test_run(const union bpf_attr *=
attr,
 	return ret;
 }
=20
-#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD next_id
+#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD obj_next_id.next_id
=20
 static int bpf_obj_get_next_id(const union bpf_attr *attr,
 			       union bpf_attr __user *uattr,
@@ -3772,7 +3774,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 	return prog;
 }
=20
-#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD prog_id
+#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD obj_fd_by_id.obj_id
=20
 struct bpf_prog *bpf_prog_by_id(u32 id)
 {
@@ -3814,7 +3816,7 @@ static int bpf_prog_get_fd_by_id(const union bpf_at=
tr *attr)
 	return fd;
 }
=20
-#define BPF_MAP_GET_FD_BY_ID_LAST_FIELD open_flags
+#define BPF_MAP_GET_FD_BY_ID_LAST_FIELD obj_fd_by_id.flags
=20
 static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 {
@@ -4385,7 +4387,7 @@ static int bpf_obj_get_info_by_fd(const union bpf_a=
ttr *attr,
 	return err;
 }
=20
-#define BPF_BTF_LOAD_LAST_FIELD btf_log_true_size
+#define BPF_BTF_LOAD_LAST_FIELD btf_load.log_true_size
=20
 static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr, __u3=
2 uattr_size)
 {
@@ -4398,7 +4400,7 @@ static int bpf_btf_load(const union bpf_attr *attr,=
 bpfptr_t uattr, __u32 uattr_
 	return btf_new_fd(attr, uattr, uattr_size);
 }
=20
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD obj_fd_by_id.obj_id
=20
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
@@ -4859,7 +4861,7 @@ struct bpf_link *bpf_link_get_curr_or_next(u32 *id)
 	return link;
 }
=20
-#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_id
+#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD obj_fd_by_id.obj_id
=20
 static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
index 9273c654743c..83066cc0f24b 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1320,7 +1320,8 @@ struct bpf_stack_build_id {
 #define BPF_OBJ_NAME_LEN 16U
=20
 union bpf_attr {
-	struct { /* anonymous struct used by BPF_MAP_CREATE command */
+	/* BPF_MAP_CREATE command */
+	struct bpf_map_create_attr {
 		__u32	map_type;	/* one of enum bpf_map_type */
 		__u32	key_size;	/* size of key in bytes */
 		__u32	value_size;	/* size of value in bytes */
@@ -1348,19 +1349,30 @@ union bpf_attr {
 		 * to using 5 hash functions).
 		 */
 		__u64	map_extra;
-	};
+	} map_create;
=20
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	/* BPF_MAP_{LOOKUP,UPDATE,DELETE,LOOKUP_AND_DELETE}_ELEM commands */
+	struct bpf_map_elem_attr {
 		__u32		map_fd;
 		__aligned_u64	key;
-		union {
-			__aligned_u64 value;
-			__aligned_u64 next_key;
-		};
+		__aligned_u64	value;
 		__u64		flags;
-	};
+	} map_elem;
=20
-	struct { /* struct used by BPF_MAP_*_BATCH commands */
+	/* BPF_MAP_GET_NEXT_KEY command */
+	struct bpf_map_next_key_attr {
+		__u32		map_fd;
+		__aligned_u64	key;
+		__aligned_u64	next_key;
+	} map_next_key;
+
+	/* BPF_MAP_FREEZE command */
+	struct bpf_map_freeze_attr {
+		__u32		map_fd;
+	} map_freeze;
+
+	/* BPF_MAP_{LOOKUP,UPDATE,DELETE,LOOKUP_AND_DELETE}_BATCH commands */
+	struct bpf_map_batch_attr {
 		__aligned_u64	in_batch;	/* start batch,
 						 * NULL to start from beginning
 						 */
@@ -1377,7 +1389,8 @@ union bpf_attr {
 		__u64		flags;
 	} batch;
=20
-	struct { /* anonymous struct used by BPF_PROG_LOAD command */
+	/* BPF_PROG_LOAD command */
+	struct bpf_prog_load_attr {
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
 		__aligned_u64	insns;
@@ -1417,12 +1430,13 @@ union bpf_attr {
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
 		__u32		log_true_size;
-	};
+	} prog_load;
=20
-	struct { /* anonymous struct used by BPF_OBJ_* commands */
+	/* BPF_OBJ_PIN command */
+	struct bpf_obj_pin_attr {
 		__aligned_u64	pathname;
 		__u32		bpf_fd;
-		__u32		file_flags;
+		__u32		flags;
 		/* Same as dirfd in openat() syscall; see openat(2)
 		 * manpage for details of path FD and pathname semantics;
 		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
@@ -1430,9 +1444,24 @@ union bpf_attr {
 		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
 		 */
 		__s32		path_fd;
-	};
+	} obj_pin;
=20
-	struct { /* anonymous struct used by BPF_PROG_ATTACH/DETACH commands */
+	/* BPF_OBJ_GET command */
+	struct bpf_obj_get_attr {
+		__aligned_u64	pathname;
+		__u32		__reserved;
+		__u32		flags;
+		/* Same as dirfd in openat() syscall; see openat(2)
+		 * manpage for details of path FD and pathname semantics;
+		 * path_fd should accompanied by BPF_F_PATH_FD flag set in
+		 * file_flags field, otherwise it should be set to zero;
+		 * if BPF_F_PATH_FD flag is not set, AT_FDCWD is assumed.
+		 */
+		__s32		path_fd;
+	} obj_get;
+
+	/* BPF_PROG_ATTACH command */
+	struct bpf_prog_attach_attr {
 		__u32		target_fd;	/* container object to attach to */
 		__u32		attach_bpf_fd;	/* eBPF program to attach */
 		__u32		attach_type;
@@ -1441,9 +1470,16 @@ union bpf_attr {
 						 * program to replace if
 						 * BPF_F_REPLACE is used
 						 */
-	};
+	} prog_attach;
=20
-	struct { /* anonymous struct used by BPF_PROG_TEST_RUN command */
+	/* BPF_PROG_DETACH command */
+	struct bpf_prog_detach_attr {
+		__u32		target_fd;	/* container object to attach to */
+		__u32		prog_fd;	/* eBPF program to detach */
+		__u32		attach_type;
+	} prog_detach;
+
+	struct bpf_prog_run_attr { /* anonymous struct used by BPF_PROG_TEST_RU=
N command */
 		__u32		prog_fd;
 		__u32		retval;
 		__u32		data_size_in;	/* input: len of data_in */
@@ -1467,25 +1503,26 @@ union bpf_attr {
 		__u32		batch_size;
 	} test;
=20
-	struct { /* anonymous struct used by BPF_*_GET_*_ID */
-		union {
-			__u32		start_id;
-			__u32		prog_id;
-			__u32		map_id;
-			__u32		btf_id;
-			__u32		link_id;
-		};
+	/* BPF_{MAP,PROG,BTF,LINK}_GET_FD_BY_ID commands */
+	struct bpf_obj_fd_by_id_attr {
+		__u32		obj_id;
+		__u32		__reserved;
+		__u32		flags;
+	} obj_fd_by_id;
+
+	/* BPF_OBJ_GET_NEXT_ID command */
+	struct bpf_obj_next_id_attr {
+		__u32		start_id;
 		__u32		next_id;
-		__u32		open_flags;
-	};
+	} obj_next_id;
=20
-	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
+	struct bpf_obj_info_by_fd_attr { /* anonymous struct used by BPF_OBJ_GE=
T_INFO_BY_FD */
 		__u32		bpf_fd;
 		__u32		info_len;
 		__aligned_u64	info;
 	} info;
=20
-	struct { /* anonymous struct used by BPF_PROG_QUERY command */
+	struct bpf_prog_query_attr { /* anonymous struct used by BPF_PROG_QUERY=
 command */
 		__u32		target_fd;	/* container object to query */
 		__u32		attach_type;
 		__u32		query_flags;
@@ -1498,25 +1535,26 @@ union bpf_attr {
 		__aligned_u64	prog_attach_flags;
 	} query;
=20
-	struct { /* anonymous struct used by BPF_RAW_TRACEPOINT_OPEN command */
+	struct bpf_raw_tp_open_attr { /* anonymous struct used by BPF_RAW_TRACE=
POINT_OPEN command */
 		__u64 name;
 		__u32 prog_fd;
 	} raw_tracepoint;
=20
-	struct { /* anonymous struct for BPF_BTF_LOAD */
+	/* BPF_BTF_LOAD command */
+	struct bpf_btf_load_attr {
 		__aligned_u64	btf;
-		__aligned_u64	btf_log_buf;
+		__aligned_u64	log_buf;
 		__u32		btf_size;
-		__u32		btf_log_size;
-		__u32		btf_log_level;
+		__u32		log_size;
+		__u32		log_level;
 		/* output: actual total log contents size (including termintaing zero)=
.
 		 * It could be both larger than original log_size (if log was
 		 * truncated), or smaller (if log buffer wasn't filled completely).
 		 */
-		__u32		btf_log_true_size;
-	};
+		__u32		log_true_size;
+	} btf_load;
=20
-	struct {
+	struct bpf_task_fd_query_attr {
 		__u32		pid;		/* input: pid */
 		__u32		fd;		/* input: fd */
 		__u32		flags;		/* input: flags */
@@ -1532,7 +1570,7 @@ union bpf_attr {
 		__u64		probe_addr;	/* output: probe_addr */
 	} task_fd_query;
=20
-	struct { /* struct used by BPF_LINK_CREATE command */
+	struct bpf_link_create_attr { /* struct used by BPF_LINK_CREATE command=
 */
 		union {
 			__u32		prog_fd;	/* eBPF program to attach */
 			__u32		map_fd;		/* struct_ops to attach */
@@ -1581,7 +1619,7 @@ union bpf_attr {
 		};
 	} link_create;
=20
-	struct { /* struct used by BPF_LINK_UPDATE command */
+	struct bpf_link_update_attr { /* struct used by BPF_LINK_UPDATE command=
 */
 		__u32		link_fd;	/* link fd */
 		union {
 			/* new program fd to update link with */
@@ -1602,25 +1640,136 @@ union bpf_attr {
 		};
 	} link_update;
=20
-	struct {
+	struct bpf_link_detach_attr {
 		__u32		link_fd;
 	} link_detach;
=20
-	struct { /* struct used by BPF_ENABLE_STATS command */
+	struct bpf_enable_stats_attr { /* struct used by BPF_ENABLE_STATS comma=
nd */
 		__u32		type;
 	} enable_stats;
=20
-	struct { /* struct used by BPF_ITER_CREATE command */
+	struct bpf_iter_create_attr { /* struct used by BPF_ITER_CREATE command=
 */
 		__u32		link_fd;
 		__u32		flags;
 	} iter_create;
=20
-	struct { /* struct used by BPF_PROG_BIND_MAP command */
+	struct bpf_prog_bind_map_attr { /* struct used by BPF_PROG_BIND_MAP com=
mand */
 		__u32		prog_fd;
 		__u32		map_fd;
 		__u32		flags;		/* extra flags */
 	} prog_bind_map;
=20
+	/*
+	 * LEGACY anonymous substructs, for backwards compatibility.
+	 * Each of the below anonymous substructs are ABI compatible with one
+	 * of the above named substructs. Please use named substructs.
+	 */
+
+	struct { /* legacy BPF_MAP_CREATE attrs, use .map_create instead */
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
+		__u64	map_extra;
+	};
+	/*
+	 * legacy BPF_MAP_*_ELEM and BPF_MAP_GET_NEXT_KEY attrs,
+	 * use .map_elem or .get_next_key, respectively, instead
+	 */
+	struct {
+		__u32		map_fd;
+		__aligned_u64	key;
+		union {
+			__aligned_u64 value;
+			__aligned_u64 next_key;
+		};
+		__u64		flags;
+	};
+	struct { /* legacy BPF_PROG_LOAD attrs, use .prog_load instead */
+		__u32		prog_type;
+		__u32		insn_cnt;
+		__aligned_u64	insns;
+		__aligned_u64	license;
+		__u32		log_level;
+		__u32		log_size;
+		__aligned_u64	log_buf;
+		__u32		kern_version;
+		__u32		prog_flags;
+		char		prog_name[BPF_OBJ_NAME_LEN];
+		__u32		prog_ifindex;
+		__u32		expected_attach_type;
+		__u32		prog_btf_fd;
+		__u32		func_info_rec_size;
+		__aligned_u64	func_info;
+		__u32		func_info_cnt;
+		__u32		line_info_rec_size;
+		__aligned_u64	line_info;
+		__u32		line_info_cnt;
+		__u32		attach_btf_id;
+		union {
+			__u32		attach_prog_fd;
+			__u32		attach_btf_obj_fd;
+		};
+		__u32		core_relo_cnt;
+		__aligned_u64	fd_array;
+		__aligned_u64	core_relos;
+		__u32		core_relo_rec_size;
+		__u32		log_true_size;
+	};
+	/* legacy BPF_OBJ_{PIN, GET} attrs, use .obj_pin or .obj_get instead */
+	struct {
+		__aligned_u64	pathname;
+		__u32		bpf_fd;
+		__u32		file_flags;
+		__s32		path_fd;
+	};
+	/*
+	 * legacy BPF_PROG_{ATTACH,DETACH} attrs,
+	 * use .prog_attach or .prog_detach instead
+	 */
+	struct {
+		__u32		target_fd;	/* container object to attach to */
+		__u32		attach_bpf_fd;	/* eBPF program to attach */
+		__u32		attach_type;
+		__u32		attach_flags;
+		__u32		replace_bpf_fd;	/* previously attached eBPF
+						 * program to replace if
+						 * BPF_F_REPLACE is used
+						 */
+	};
+	/*
+	 * legacy BPF_*_GET_FD_BY_ID and BPF_OBJ_GET_NEXT_ID attrs,
+	 * use .obj_fd_by_id or .obj_next_id, respectively, instead
+	 */
+	struct {
+		union {
+			__u32		start_id;
+			__u32		prog_id;
+			__u32		map_id;
+			__u32		btf_id;
+			__u32		link_id;
+		};
+		__u32		next_id;
+		__u32		open_flags;
+	};
+	/* legacy BPF_BTF_LOAD attrs, use .btf_load instead */
+	struct {
+		__aligned_u64	btf;
+		__aligned_u64	btf_log_buf;
+		__u32		btf_size;
+		__u32		btf_log_size;
+		__u32		btf_log_level;
+		__u32		btf_log_true_size;
+	};
 } __attribute__((aligned(8)));
=20
 /* The description below is an attempt at providing documentation to eBP=
F
--=20
2.34.1


