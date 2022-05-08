Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4702A51EB47
	for <lists+bpf@lfdr.de>; Sun,  8 May 2022 05:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiEHDZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 7 May 2022 23:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240258AbiEHDZm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 7 May 2022 23:25:42 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D2E0F9
        for <bpf@vger.kernel.org>; Sat,  7 May 2022 20:21:53 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24829jTP014094
        for <bpf@vger.kernel.org>; Sat, 7 May 2022 20:21:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=cPDPcsdLROsfhX3QM2Vxtc3mAmuOMpLT99T8MiE7Qqs=;
 b=gD8LQvfrHxKKLmriYqqG/FPlyKhcYTqOWIt0FVaUZsMTF22Z0BmylhDazt9iux2vDHZ1
 dw1cfIRJdGQ6N3eGRtIfhOygXCqiLZ+gd01k+wgGTSgWEL4TaZ+L8sBOlGlc4xCZDJEg
 xVwqBA0qovRdKCb+okU0HFZyhX9hmJkNCw8= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net (PPS) with ESMTPS id 3fx4u0g4d0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 07 May 2022 20:21:52 -0700
Received: from twshared11660.23.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 7 May 2022 20:21:51 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 586C8317038A; Sat,  7 May 2022 20:21:35 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 4/5] libbpf: Assign cookies to links in libbpf.
Date:   Sat, 7 May 2022 20:21:16 -0700
Message-ID: <20220508032117.2783209-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220508032117.2783209-1-kuifeng@fb.com>
References: <20220508032117.2783209-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3zlOy-UCkZkjQge0_DdhxQMgSQVwmYc8
X-Proofpoint-GUID: 3zlOy-UCkZkjQge0_DdhxQMgSQVwmYc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-08_01,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a cookie field to the attributes of bpf_link_create().
Add bpf_program__attach_trace_opts() to attach a cookie to a link.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/lib/bpf/bpf.c      |  8 ++++++++
 tools/lib/bpf/bpf.h      |  3 +++
 tools/lib/bpf/libbpf.c   | 32 ++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 56 insertions(+)

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
index 73a5192defb3..df9be47d67bc 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11440,6 +11440,38 @@ struct bpf_link *bpf_program__attach_trace(const=
 struct bpf_program *prog)
 	return bpf_program__attach_btf_id(prog);
 }
=20
+struct bpf_link *bpf_program__attach_trace_opts(const struct bpf_program=
 *prog,
+						const struct bpf_trace_opts *opts)
+{
+	char errmsg[STRERR_BUFSIZE];
+	struct bpf_link *link;
+	int prog_fd, pfd;
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	prog_fd =3D bpf_program__fd(prog);
+	if (prog_fd < 0) {
+		pr_warn("prog '%s': can't attach before loaded\n", prog->name);
+		return libbpf_err_ptr(-EINVAL);
+	}
+
+	link =3D calloc(1, sizeof(*link));
+	if (!link)
+		return libbpf_err_ptr(-ENOMEM);
+	link->detach =3D &bpf_link__detach_fd;
+
+	link_opts.tracing.cookie =3D OPTS_GET(opts, cookie, 0);
+	pfd =3D bpf_link_create(prog_fd, 0, prog->expected_attach_type, &link_o=
pts);
+	if (pfd < 0) {
+		pfd =3D -errno;
+		free(link);
+		pr_warn("prog '%s': failed to attach: %s\n",
+			prog->name, libbpf_strerror_r(pfd, errmsg, sizeof(errmsg)));
+		return libbpf_err_ptr(pfd);
+	}
+	link->fd =3D pfd;
+	return link;
+}
+
 struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 {
 	return bpf_program__attach_btf_id(prog);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index cdbfee60ea3e..62af394247eb 100644
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
index 82f6d62176dd..245a0e8677c9 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -444,6 +444,7 @@ LIBBPF_0.8.0 {
 	global:
 		bpf_object__destroy_subskeleton;
 		bpf_object__open_subskeleton;
+		bpf_program__attach_trace_opts;
 		bpf_program__attach_usdt;
 		libbpf_register_prog_handler;
 		libbpf_unregister_prog_handler;
--=20
2.30.2

