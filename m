Return-Path: <bpf+bounces-76729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 310E8CC4A1C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 18:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E0A3300F70C
	for <lists+bpf@lfdr.de>; Tue, 16 Dec 2025 17:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A04328608;
	Tue, 16 Dec 2025 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cxpkqrbn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368EF30BB87
	for <bpf@vger.kernel.org>; Tue, 16 Dec 2025 17:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765905697; cv=none; b=V+LpcnF0ILmtF5sUz1d6UWIbZMw/VlYEJkQX/3e+06eCsGtqxyG0UtGb/KrWgMSWeUaAQKRSk1Aglnbw6OocV8JoGDy8t0rqyS/LHI1IelC1GMJ4AcH7vqOYfa9KDtB63qzuo1PYCe1OBUhbz1/L6dGvkGG5szEmda644D+dKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765905697; c=relaxed/simple;
	bh=LQW2IWwU8QZwLjRft/TdPr1GiTUYK68AzkuX1ekkCZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol3pTpvxIAIWft2yoVbXz6RqWLDPmOaL1Bnx6js/8OZI3rkOzvpFiIxzlKfcx/vdZGbYVnNbNTemDlFQRcVENEcMGzSJ+hKsFH5ex4TpRY4lUvMSjheDl1V2hWoyni99VzsXT60rNLqoIUwO5gVoLQkrDbtONcYWqhgaCXTsv3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cxpkqrbn; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BGDuctB504792;
	Tue, 16 Dec 2025 17:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=yjJFe
	SXAJGCd+4VmJ344YSnKcXB12rtO7GpJk77zN2Q=; b=cxpkqrbnQC+apYkkqKv8Q
	GiTDCBSRJ3aQWijTTZqrdfbo3kC1GNzA8U4TMxmYko9kLfozPCXwXCpbLtlrh9kz
	Dnr6U+qWaVM37101E3SeRV8JPgLVtT/CPBUyG2S85P1+cZ9L+X4LMQA6VH1Iz/We
	pRW2VtTLwMJjanmFJt2OTahAEQ5BuPMWmAYAPTz9GegMbV16aZ62mznj1w9OMDWn
	Tc9N7rYTOFvx/yGBXWxVkQlBeHZXByJz+Ri03D5NjKbqjlG/110qPSAMJCKAg2n/
	plFVHg5Lh76USA15PymdcUKHahN1F2zI8gqUaz5cgzgV4cc2hZ3G0bHruRYkhJXK
	w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0yrum98b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:19:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGG1xqM005945;
	Tue, 16 Dec 2025 17:19:00 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xkdgpux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Dec 2025 17:19:00 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BGHIvZR039632;
	Tue, 16 Dec 2025 17:18:59 GMT
Received: from bpf.uk.oracle.com (dhcp-10-154-50-156.vpn.oracle.com [10.154.50.156])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4b0xkdgprs-2;
	Tue, 16 Dec 2025 17:18:59 +0000
From: Alan Maguire <alan.maguire@oracle.com>
To: qmo@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
        yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested structs for BTF dump
Date: Tue, 16 Dec 2025 17:18:53 +0000
Message-ID: <20251216171854.2291424-2-alan.maguire@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251216171854.2291424-1-alan.maguire@oracle.com>
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512160149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE2MDE0OCBTYWx0ZWRfX5qDupCCSjo1H
 aS2fm7nz1IbTby8ithsnZ5c4ts7lcLDZgRNVtYlXmX5gx9xm3j+LB9oc7kXpd1OcV49bzl6TPeB
 I7F3uv1LeCqSEAcwGGhdn4qTGS1uZMo/Iq8qfyrWi3L1SYHo/vp16ZwvTG0JqGXK+AsFadrwimH
 E4md7VNil0tQjXnALiinqurZBSdzNOuj2KovfhDygXXPfI358ybeCftSZK8PJPGo07gAChvM61G
 CAq6P43fmTS5APG7VyfkHyScZuD6zccV9CVGL0FAHKiIuW9EgLt/B46rpfpbBhs1OncwKhjdZPy
 Bin018Uww1nqC5XwAikjvZ+nH7k/9E78B91zzCo66xEpHIXKun7OQF9VY19IBIf9Dj8ED5ydG/+
 v9oxjkWQwwA680J5s0rc+izML3qpmiDEsO7xOgs6e6+b3q7B9h0=
X-Authority-Analysis: v=2.4 cv=TL9Iilla c=1 sm=1 tr=0 ts=69419484 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=Nwcz4HrqxhHGP_bvhj8A:9 cc=ntf awl=host:12109
X-Proofpoint-GUID: OOuDxLzGVkxd9lGqOlSB0N-vs1NFnKCc
X-Proofpoint-ORIG-GUID: OOuDxLzGVkxd9lGqOlSB0N-vs1NFnKCc

When -fms-extension is used, it becomes possible to declare a
non-anonymous nested struct without a member name; for example

struct bar {
	int baz;
};

struct foo {
	struct bar;
};

These are used in the kernel now, and hence make it into BTF.
For example:

struct ns_tree {
        u64 ns_id;
        atomic_t __ns_ref_active;
        struct ns_tree_node ns_unified_node;
        struct ns_tree_node ns_tree_node;
        struct ns_tree_node ns_owner_node;
        struct ns_tree_root ns_owner_root;
};

struct proc_ns_operations;

struct ns_common {
        u32 ns_type;
        struct dentry *stashed;
        const struct proc_ns_operations *ops;
        unsigned int inum;
        refcount_t __ns_ref;
        union {
>>>>            struct ns_tree; <<<<
		struct callback_head ns_rcu;
	};
};

In order to generate a vmlinux.h from such BTF that does
not force support of -fms-extension, provide an option to
btf_dump__new() to replace structs that have names but no
referring member name with an equivalent anonymous struct.
bpftool can then make use of this feature.

With this approach, the above would become:

truct ns_common {
        u32 ns_type;
        struct dentry *stashed;
        const struct proc_ns_operations *ops;
        unsigned int inum;
        refcount_t __ns_ref;
        union {
                struct  {
                        u64 ns_id;
                        atomic_t __ns_ref_active;
                        struct ns_tree_node ns_unified_node;
                        struct ns_tree_node ns_tree_node;
                        struct ns_tree_node ns_owner_node;
                        struct ns_tree_root ns_owner_root;
                };
                struct callback_head ns_rcu;
        };
};

Fields are still accessible, size is the same but we have
included an anonymous equivalent of the struct instead since
this is more compatible.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.h      | 25 ++++++++++++++++++++++++-
 tools/lib/bpf/btf_dump.c | 25 ++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index cc01494d6210..fc32e488c05c 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -285,8 +285,31 @@ struct btf_dump;
 
 struct btf_dump_opts {
 	size_t sz;
+	/* when a struct declares another struct within it without a
+	 * member name, force it to be an anonymous nested struct;
+	 * for example instead of
+	 *
+	 * struct bar {
+	 *	int baz;
+	 * };
+	 * struct foo {
+	 *	struct bar;
+	 *	...
+	 * };
+	 *
+	 * use
+	 *
+	 * struct foo {
+	 *	struct {
+	 *		int baz;
+	 *	};
+	 * };
+	 *
+	 * This is needed for compilation without -fms-extension .
+	 */
+	bool force_anon_struct_members;
 };
-#define btf_dump_opts__last_field sz
+#define btf_dump_opts__last_field force_anon_struct_members
 
 typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
 
diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 6388392f49a0..b37062247580 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -54,6 +54,8 @@ struct btf_dump_type_aux_state {
 	__u8 name_resolved: 1;
 	/* whether type is referenced from any other type */
 	__u8 referenced: 1;
+	/* whether named type should be anonymized */
+	__u8 anonymize: 1;
 };
 
 /* indent string length; one indent string is added for each indent level */
@@ -84,6 +86,7 @@ struct btf_dump {
 	int ptr_sz;
 	bool strip_mods;
 	bool skip_anon_defs;
+	bool force_anon_struct_members;
 	int last_id;
 
 	/* per-type auxiliary state */
@@ -164,6 +167,7 @@ struct btf_dump *btf_dump__new(const struct btf *btf,
 	if (!d)
 		return libbpf_err_ptr(-ENOMEM);
 
+	d->force_anon_struct_members = OPTS_GET(opts, force_anon_struct_members, false);
 	d->btf = btf;
 	d->printf_fn = printf_fn;
 	d->cb_ctx = ctx;
@@ -1417,6 +1421,8 @@ static void btf_dump_emit_name(const struct btf_dump *d,
 	btf_dump_printf(d, "%s%s", separate ? " " : "", name);
 }
 
+static void btf_dump_set_anon_type(struct btf_dump *d, __u32 id, bool anon);
+
 static void btf_dump_emit_type_chain(struct btf_dump *d,
 				     struct id_stack *decls,
 				     const char *fname, int lvl)
@@ -1460,10 +1466,16 @@ static void btf_dump_emit_type_chain(struct btf_dump *d,
 		case BTF_KIND_UNION:
 			btf_dump_emit_mods(d, decls);
 			/* inline anonymous struct/union */
-			if (t->name_off == 0 && !d->skip_anon_defs)
+			if (t->name_off == 0 && !d->skip_anon_defs) {
 				btf_dump_emit_struct_def(d, id, t, lvl);
-			else
+			} else if (decls->cnt == 0 && !fname[0] && d->force_anon_struct_members) {
+				/* anonymize nested struct and emit it */
+				btf_dump_set_anon_type(d, id, true);
+				btf_dump_emit_struct_def(d, id, t, lvl);
+				btf_dump_set_anon_type(d, id, false);
+			} else {
 				btf_dump_emit_struct_fwd(d, id, t);
+			}
 			break;
 		case BTF_KIND_ENUM:
 		case BTF_KIND_ENUM64:
@@ -1661,6 +1673,13 @@ static size_t btf_dump_name_dups(struct btf_dump *d, struct hashmap *name_map,
 	return dup_cnt;
 }
 
+static void btf_dump_set_anon_type(struct btf_dump *d, __u32 id, bool anon)
+{
+	struct btf_dump_type_aux_state *s = &d->type_states[id];
+
+	s->anonymize = anon;
+}
+
 static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
 					 struct hashmap *name_map)
 {
@@ -1670,7 +1689,7 @@ static const char *btf_dump_resolve_name(struct btf_dump *d, __u32 id,
 	const char **cached_name = &d->cached_names[id];
 	size_t dup_cnt;
 
-	if (t->name_off == 0)
+	if (t->name_off == 0 || s->anonymize)
 		return "";
 
 	if (s->name_resolved)
-- 
2.39.3


