Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF8721C192
	for <lists+bpf@lfdr.de>; Sat, 11 Jul 2020 03:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgGKB3V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 21:29:21 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:46376 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727028AbgGKB3R (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Jul 2020 21:29:17 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06B1SpSp018705
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RUib/HXP+VBprzF23xQbf2Dp0Yp03NX2lImz1c9fDJE=;
 b=iWQDjuYIdV7RPt0IGz7XVSPSDg0dibn2GeinZf7LAQ4ZURFFLOF6C7GjjPW2qI0CFGx1
 yyySJfYlwTCSPuOQVdEUELZB2DRRvlG7qEOVIKo33Le89ZkueTr3gfhYLwyf4I6455m7
 ionkgMMg+Qe6vyJmTwyeVsmOBI25iRwQ9FA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 325k2cn9td-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 18:29:15 -0700
Received: from intmgw005.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 10 Jul 2020 18:29:12 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 338A662E51D5; Fri, 10 Jul 2020 18:26:54 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/5] bpf: add callchain to bpf_perf_event_data
Date:   Fri, 10 Jul 2020 18:26:36 -0700
Message-ID: <20200711012639.3429622-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200711012639.3429622-1-songliubraving@fb.com>
References: <20200711012639.3429622-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_14:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007110007
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

If the callchain is available, BPF program can use bpf_probe_read_kernel(=
)
to fetch the callchain, or use it in a BPF helper.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 include/linux/perf_event.h                |  5 -----
 include/linux/trace_events.h              |  5 +++++
 include/uapi/linux/bpf_perf_event.h       |  7 ++++++
 kernel/bpf/btf.c                          |  5 +++++
 kernel/trace/bpf_trace.c                  | 27 +++++++++++++++++++++++
 tools/include/uapi/linux/bpf_perf_event.h |  8 +++++++
 6 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 00ab5efa38334..3a68c999f50d1 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -59,11 +59,6 @@ struct perf_guest_info_callbacks {
 #include <linux/security.h>
 #include <asm/local.h>
=20
-struct perf_callchain_entry {
-	__u64				nr;
-	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
-};
-
 struct perf_callchain_entry_ctx {
 	struct perf_callchain_entry *entry;
 	u32			    max_stack;
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5c69433540494..8e1e88f40eef9 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -631,6 +631,7 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map =
*btp);
 int bpf_get_perf_event_info(const struct perf_event *event, u32 *prog_id=
,
 			    u32 *fd_type, const char **buf,
 			    u64 *probe_offset, u64 *probe_addr);
+int bpf_trace_init_btf_ids(struct btf *btf);
 #else
 static inline unsigned int trace_call_bpf(struct trace_event_call *call,=
 void *ctx)
 {
@@ -672,6 +673,10 @@ static inline int bpf_get_perf_event_info(const stru=
ct perf_event *event,
 {
 	return -EOPNOTSUPP;
 }
+int bpf_trace_init_btf_ids(struct btf *btf)
+{
+	return -EOPNOTSUPP;
+}
 #endif
=20
 enum {
diff --git a/include/uapi/linux/bpf_perf_event.h b/include/uapi/linux/bpf=
_perf_event.h
index eb1b9d21250c6..40f4df80ab4fa 100644
--- a/include/uapi/linux/bpf_perf_event.h
+++ b/include/uapi/linux/bpf_perf_event.h
@@ -9,11 +9,18 @@
 #define _UAPI__LINUX_BPF_PERF_EVENT_H__
=20
 #include <asm/bpf_perf_event.h>
+#include <linux/bpf.h>
+
+struct perf_callchain_entry {
+	__u64				nr;
+	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
+};
=20
 struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
 	__u64 addr;
+	__bpf_md_ptr(struct perf_callchain_entry *, callchain);
 };
=20
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4c3007f428b16..cb122e14dba38 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -20,6 +20,7 @@
 #include <linux/btf.h>
 #include <linux/skmsg.h>
 #include <linux/perf_event.h>
+#include <linux/trace_events.h>
 #include <net/sock.h>
=20
 /* BTF (BPF Type Format) is the meta data format which describes
@@ -3673,6 +3674,10 @@ struct btf *btf_parse_vmlinux(void)
 	if (err < 0)
 		goto errout;
=20
+	err =3D bpf_trace_init_btf_ids(btf);
+	if (err < 0)
+		goto errout;
+
 	bpf_struct_ops_init(btf, log);
 	init_btf_sock_ids(btf);
=20
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e0b7775039ab9..c014846c2723c 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/bpf.h>
+#include <linux/btf.h>
 #include <linux/bpf_perf_event.h>
 #include <linux/filter.h>
 #include <linux/uaccess.h>
@@ -31,6 +32,20 @@ struct bpf_trace_module {
 static LIST_HEAD(bpf_trace_modules);
 static DEFINE_MUTEX(bpf_module_mutex);
=20
+static u32 perf_callchain_entry_btf_id;
+
+int bpf_trace_init_btf_ids(struct btf *btf)
+{
+	s32 type_id;
+
+	type_id =3D btf_find_by_name_kind(btf, "perf_callchain_entry",
+					BTF_KIND_STRUCT);
+	if (type_id < 0)
+		return -EINVAL;
+	perf_callchain_entry_btf_id =3D type_id;
+	return 0;
+}
+
 static struct bpf_raw_event_map *bpf_get_raw_tracepoint_module(const cha=
r *name)
 {
 	struct bpf_raw_event_map *btp, *ret =3D NULL;
@@ -1650,6 +1665,10 @@ static bool pe_prog_is_valid_access(int off, int s=
ize, enum bpf_access_type type
 		if (!bpf_ctx_narrow_access_ok(off, size, size_u64))
 			return false;
 		break;
+	case bpf_ctx_range(struct bpf_perf_event_data, callchain):
+		info->reg_type =3D PTR_TO_BTF_ID;
+		info->btf_id =3D perf_callchain_entry_btf_id;
+		break;
 	default:
 		if (size !=3D sizeof(long))
 			return false;
@@ -1682,6 +1701,14 @@ static u32 pe_prog_convert_ctx_access(enum bpf_acc=
ess_type type,
 				      bpf_target_off(struct perf_sample_data, addr, 8,
 						     target_size));
 		break;
+	case offsetof(struct bpf_perf_event_data, callchain):
+		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_ke=
rn,
+						       data), si->dst_reg, si->src_reg,
+				      offsetof(struct bpf_perf_event_data_kern, data));
+		*insn++ =3D BPF_LDX_MEM(BPF_DW, si->dst_reg, si->dst_reg,
+				      bpf_target_off(struct perf_sample_data, callchain,
+						     8, target_size));
+		break;
 	default:
 		*insn++ =3D BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_perf_event_data_ke=
rn,
 						       regs), si->dst_reg, si->src_reg,
diff --git a/tools/include/uapi/linux/bpf_perf_event.h b/tools/include/ua=
pi/linux/bpf_perf_event.h
index 8f95303f9d807..40f4df80ab4fa 100644
--- a/tools/include/uapi/linux/bpf_perf_event.h
+++ b/tools/include/uapi/linux/bpf_perf_event.h
@@ -9,10 +9,18 @@
 #define _UAPI__LINUX_BPF_PERF_EVENT_H__
=20
 #include <asm/bpf_perf_event.h>
+#include <linux/bpf.h>
+
+struct perf_callchain_entry {
+	__u64				nr;
+	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
+};
=20
 struct bpf_perf_event_data {
 	bpf_user_pt_regs_t regs;
 	__u64 sample_period;
+	__u64 addr;
+	__bpf_md_ptr(struct perf_callchain_entry *, callchain);
 };
=20
 #endif /* _UAPI__LINUX_BPF_PERF_EVENT_H__ */
--=20
2.24.1

