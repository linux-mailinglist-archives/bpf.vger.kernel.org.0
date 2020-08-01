Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE7CC2353A8
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHAREI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 1 Aug 2020 13:04:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58567 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727992AbgHAREI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 1 Aug 2020 13:04:08 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-xNNdwivjPuS_GiahcBGRgg-1; Sat, 01 Aug 2020 13:04:04 -0400
X-MC-Unique: xNNdwivjPuS_GiahcBGRgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 243B48015F3;
        Sat,  1 Aug 2020 17:04:02 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F04D85F7D8;
        Sat,  1 Aug 2020 17:03:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        David Miller <davem@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Wenbo Zhang <ethercflow@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Florent Revest <revest@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v9 bpf-next 10/14] bpf: Add d_path helper
Date:   Sat,  1 Aug 2020 19:03:18 +0200
Message-Id: <20200801170322.75218-11-jolsa@kernel.org>
In-Reply-To: <20200801170322.75218-1-jolsa@kernel.org>
References: <20200801170322.75218-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding d_path helper function that returns full path for
given 'struct path' object, which needs to be the kernel
BTF 'path' object. The path is returned in buffer provided
'buf' of size 'sz' and is zero terminated.

  bpf_d_path(&file->f_path, buf, size);

The helper calls directly d_path function, so there's only
limited set of function it can be called from. Adding just
very modest set for the start.

Updating also bpf.h tools uapi header and adding 'path' to
bpf_helpers_doc.py script.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/uapi/linux/bpf.h       | 13 +++++++++
 kernel/trace/bpf_trace.c       | 48 ++++++++++++++++++++++++++++++++++
 scripts/bpf_helpers_doc.py     |  2 ++
 tools/include/uapi/linux/bpf.h | 13 +++++++++
 4 files changed, 76 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index eb5e0c38eb2c..a356ea1357bf 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3389,6 +3389,18 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * int bpf_d_path(struct path *path, char *buf, u32 sz)
+ *	Description
+ *		Return full path for given 'struct path' object, which
+ *		needs to be the kernel BTF 'path' object. The path is
+ *		returned in buffer provided 'buf' of size 'sz' and
+ *		is zero terminated.
+ *
+ *	Return
+ *		On success, the strictly positive length of the string,
+ *		including the trailing NUL character. On error, a negative
+ *		value.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3533,6 +3545,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(d_path),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index cb91ef902cc4..02a76e246545 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -1098,6 +1098,52 @@ static const struct bpf_func_proto bpf_send_signal_thread_proto = {
 	.arg1_type	= ARG_ANYTHING,
 };
 
+BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
+{
+	int len;
+	char *p;
+
+	if (!sz)
+		return -ENAMETOOLONG;
+
+	p = d_path(path, buf, sz);
+	if (IS_ERR(p)) {
+		len = PTR_ERR(p);
+	} else {
+		len = buf + sz - p;
+		memmove(buf, p, len);
+	}
+
+	return len;
+}
+
+BTF_SET_START(btf_allowlist_d_path)
+BTF_ID(func, vfs_truncate)
+BTF_ID(func, vfs_fallocate)
+BTF_ID(func, dentry_open)
+BTF_ID(func, vfs_getattr)
+BTF_ID(func, filp_close)
+BTF_SET_END(btf_allowlist_d_path)
+
+static bool bpf_d_path_allowed(const struct bpf_prog *prog)
+{
+	return btf_id_set_contains(&btf_allowlist_d_path, prog->aux->attach_btf_id);
+}
+
+BTF_ID_LIST(bpf_d_path_btf_ids)
+BTF_ID(struct, path)
+
+static const struct bpf_func_proto bpf_d_path_proto = {
+	.func		= bpf_d_path,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
+	.btf_id		= bpf_d_path_btf_ids,
+	.allowed	= bpf_d_path_allowed,
+};
+
 const struct bpf_func_proto *
 bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
@@ -1579,6 +1625,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		return prog->expected_attach_type == BPF_TRACE_ITER ?
 		       &bpf_seq_write_proto :
 		       NULL;
+	case BPF_FUNC_d_path:
+		return &bpf_d_path_proto;
 	default:
 		return raw_tp_prog_func_proto(func_id, prog);
 	}
diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
index 5bfa448b4704..08388173973f 100755
--- a/scripts/bpf_helpers_doc.py
+++ b/scripts/bpf_helpers_doc.py
@@ -432,6 +432,7 @@ class PrinterHelpers(Printer):
             'struct __sk_buff',
             'struct sk_msg_md',
             'struct xdp_md',
+            'struct path',
     ]
     known_types = {
             '...',
@@ -472,6 +473,7 @@ class PrinterHelpers(Printer):
             'struct tcp_request_sock',
             'struct udp6_sock',
             'struct task_struct',
+            'struct path',
     }
     mapped_types = {
             'u8': '__u8',
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index eb5e0c38eb2c..a356ea1357bf 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3389,6 +3389,18 @@ union bpf_attr {
  *		A non-negative value equal to or less than *size* on success,
  *		or a negative error in case of failure.
  *
+ * int bpf_d_path(struct path *path, char *buf, u32 sz)
+ *	Description
+ *		Return full path for given 'struct path' object, which
+ *		needs to be the kernel BTF 'path' object. The path is
+ *		returned in buffer provided 'buf' of size 'sz' and
+ *		is zero terminated.
+ *
+ *	Return
+ *		On success, the strictly positive length of the string,
+ *		including the trailing NUL character. On error, a negative
+ *		value.
+ *
  */
 #define __BPF_FUNC_MAPPER(FN)		\
 	FN(unspec),			\
@@ -3533,6 +3545,7 @@ union bpf_attr {
 	FN(skc_to_tcp_request_sock),	\
 	FN(skc_to_udp6_sock),		\
 	FN(get_task_stack),		\
+	FN(d_path),			\
 	/* */
 
 /* integer value in 'imm' field of BPF_CALL instruction selects which helper
-- 
2.25.4

