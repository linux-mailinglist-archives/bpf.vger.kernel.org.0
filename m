Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39DDD5225FB
	for <lists+bpf@lfdr.de>; Tue, 10 May 2022 23:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbiEJVA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 May 2022 17:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiEJVAZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 May 2022 17:00:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB9266F3F
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:00:24 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24AJEHdP007878
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:00:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=RwtK9l/hHnHpTXq+8f+Tbf8Qg5TB8468NX4V6O7a/zw=;
 b=dQhuOKA30uHfHYqFuovvmlmuyFQGeGqfztHh16kg/WGNnFQuBjgkxIa2UfguclS3Ifg7
 uLbQG7zwn92baxvuHZOQg20/bURiZ/rP/BWc4x/D77FYknSuwX+pFjNLCQY74lkc0NXi
 p8ngqGDEz0hQXqhhJ73o68/HZL6RxlLV06M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fyx1h0sqq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 10 May 2022 14:00:23 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 10 May 2022 13:59:54 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 4797C32F2035; Tue, 10 May 2022 13:59:44 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v8 4/5] libbpf: Assign cookies to links in libbpf.
Date:   Tue, 10 May 2022 13:59:22 -0700
Message-ID: <20220510205923.3206889-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220510205923.3206889-1-kuifeng@fb.com>
References: <20220510205923.3206889-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: iqWgF9u7gppBVgW28-WQqcrBdCSXiUPu
X-Proofpoint-ORIG-GUID: iqWgF9u7gppBVgW28-WQqcrBdCSXiUPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-10_07,2022-05-10_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a cookie field to the attributes of bpf_link_create().
Add bpf_program__attach_trace_opts() to attach a cookie to a link.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c      |  8 ++++++++
 tools/lib/bpf/bpf.h      |  3 +++
 tools/lib/bpf/libbpf.c   | 19 +++++++++++++++----
 tools/lib/bpf/libbpf.h   | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9d292c106c2..5660268e103f 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -863,6 +863,14 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+	case BPF_LSM_MAC:
+		attr.link_create.tracing.cookie =3D OPTS_GET(opts, tracing.cookie, 0);
+		if (!OPTS_ZEROED(opts, tracing))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f4b4afb6d4ba..34af2232928c 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -420,6 +420,9 @@ struct bpf_link_create_opts {
 			const unsigned long *addrs;
 			const __u64 *cookies;
 		} kprobe_multi;
+		struct {
+			__u64 cookie;
+		} tracing;
 	};
 	size_t :0;
 };
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 15117b9a4d1e..208bea907063 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11568,11 +11568,13 @@ static int attach_raw_tp(const struct bpf_progr=
am *prog, long cookie, struct bpf
 }
=20
 /* Common logic for all BPF program types that attach to a btf_id */
-static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_prog=
ram *prog)
+static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_prog=
ram *prog,
+						   const struct bpf_trace_opts *opts)
 {
 	char errmsg[STRERR_BUFSIZE];
 	struct bpf_link *link;
 	int prog_fd, pfd;
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
=20
 	prog_fd =3D bpf_program__fd(prog);
 	if (prog_fd < 0) {
@@ -11585,8 +11587,11 @@ static struct bpf_link *bpf_program__attach_btf_=
id(const struct bpf_program *pro
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach =3D &bpf_link__detach_fd;
=20
+	if (opts)
+		link_opts.tracing.cookie =3D OPTS_GET(opts, cookie, 0);
+
 	/* libbpf is smart enough to redirect to BPF_RAW_TRACEPOINT_OPEN on old=
 kernels */
-	pfd =3D bpf_link_create(prog_fd, 0, bpf_program__expected_attach_type(p=
rog), NULL);
+	pfd =3D bpf_link_create(prog_fd, 0, bpf_program__expected_attach_type(p=
rog), &link_opts);
 	if (pfd < 0) {
 		pfd =3D -errno;
 		free(link);
@@ -11600,12 +11605,18 @@ static struct bpf_link *bpf_program__attach_btf=
_id(const struct bpf_program *pro
=20
 struct bpf_link *bpf_program__attach_trace(const struct bpf_program *pro=
g)
 {
-	return bpf_program__attach_btf_id(prog);
+	return bpf_program__attach_btf_id(prog, NULL);
+}
+
+struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program=
 *prog,
+						const struct bpf_trace_opts *opts)
+{
+	return bpf_program__attach_btf_id(prog, opts);
 }
=20
 struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 {
-	return bpf_program__attach_btf_id(prog);
+	return bpf_program__attach_btf_id(prog, NULL);
 }
=20
 static int attach_trace(const struct bpf_program *prog, long cookie, str=
uct bpf_link **link)
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 114b1f6f73a5..a1fb91810378 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -603,8 +603,20 @@ bpf_program__attach_tracepoint_opts(const struct bpf=
_program *prog,
 LIBBPF_API struct bpf_link *
 bpf_program__attach_raw_tracepoint(const struct bpf_program *prog,
 				   const char *tp_name);
+
+struct bpf_trace_opts {
+	/* size of this struct, for forward/backward compatibility */
+	size_t sz;
+	/* custom user-provided value fetchable through bpf_get_attach_cookie()=
 */
+	__u64 cookie;
+};
+#define bpf_trace_opts__last_field cookie
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_trace(const struct bpf_program *prog);
+LIBBPF_API struct bpf_link *
+bpf_program__attach_trace_opts(const struct bpf_program *prog, const str=
uct bpf_trace_opts *opts);
+
 LIBBPF_API struct bpf_link *
 bpf_program__attach_lsm(const struct bpf_program *prog);
 LIBBPF_API struct bpf_link *
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index b5bc84039407..80819e26a976 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -447,6 +447,7 @@ LIBBPF_0.8.0 {
 		bpf_object__destroy_subskeleton;
 		bpf_object__open_subskeleton;
 		bpf_program__attach_kprobe_multi_opts;
+		bpf_program__attach_trace_opts;
 		bpf_program__attach_usdt;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
--=20
2.30.2

