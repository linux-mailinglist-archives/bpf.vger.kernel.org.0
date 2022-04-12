Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65414FE660
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 18:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbiDLQ6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 12:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353145AbiDLQ6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 12:58:54 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E5C5F8D8
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:36 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23CGQCvO000850
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NHH6RviNAH6XZY+a20b/Nz6R9VCrU4Hm9x/69A7F1Zg=;
 b=AoIz9Nv7EaQUfWGkZB42UBYsgo8eidw0lcLsVM0FWUNRcUIjzY+4zwSla1odmWmjKliC
 scJTGmeW18H5e2pPBiotGF9xkBrrnfklFClHKJUGeaBgUhT4i6TfO87h6kSb9zPZvdr5
 012ik3BD+BYX1Z/qTjllE+npjUZ94/KV6+4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fcy5qvaa2-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 12 Apr 2022 09:56:36 -0700
Received: from twshared13345.18.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 12 Apr 2022 09:56:34 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 63A512309166; Tue, 12 Apr 2022 09:56:25 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v5 4/5] lib/bpf: Assign cookies to links in libbpf.
Date:   Tue, 12 Apr 2022 09:55:54 -0700
Message-ID: <20220412165555.4146407-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412165555.4146407-1-kuifeng@fb.com>
References: <20220412165555.4146407-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fAfUamtYbcy73tz_2YOeIbHYr1eiyKNt
X-Proofpoint-GUID: fAfUamtYbcy73tz_2YOeIbHYr1eiyKNt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-12_06,2022-04-12_02,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
 tools/lib/bpf/bpf.c      |  7 +++++++
 tools/lib/bpf/bpf.h      |  3 +++
 tools/lib/bpf/libbpf.c   | 33 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h   | 12 ++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 5 files changed, 56 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cf27251adb92..c2454979c3c4 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -863,6 +863,13 @@ int bpf_link_create(int prog_fd, int target_fd,
 		if (!OPTS_ZEROED(opts, kprobe_multi))
 			return libbpf_err(-EINVAL);
 		break;
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+		attr.link_create.tracing.bpf_cookie =3D OPTS_GET(opts, tracing.bpf_coo=
kie, 0);
+		if (!OPTS_ZEROED(opts, tracing))
+			return libbpf_err(-EINVAL);
+		break;
 	default:
 		if (!OPTS_ZEROED(opts, flags))
 			return libbpf_err(-EINVAL);
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index f4b4afb6d4ba..4cdbabcccefc 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -410,6 +410,9 @@ struct bpf_link_create_opts {
 	__u32 iter_info_len;
 	__u32 target_btf_id;
 	union {
+		struct {
+			__u64 bpf_cookie;
+		} tracing;
 		struct {
 			__u64 bpf_cookie;
 		} perf_event;
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index bf4f7ac54ebf..8586e1efd780 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11262,6 +11262,39 @@ struct bpf_link *bpf_program__attach_trace(const=
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
+
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
+	link_opts.tracing.bpf_cookie =3D OPTS_GET(opts, bpf_cookie, 0);
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
+	return (struct bpf_link *)link;
+}
+
 struct bpf_link *bpf_program__attach_lsm(const struct bpf_program *prog)
 {
 	return bpf_program__attach_btf_id(prog);
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 63d66f1adf1a..e0dd3f9a5aca 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -563,8 +563,20 @@ bpf_program__attach_tracepoint_opts(const struct bpf=
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
+	__u64 bpf_cookie;
+};
+#define bpf_trace_opts__last_field bpf_cookie
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
index 82f6d62176dd..9235da802e31 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -424,6 +424,7 @@ LIBBPF_0.6.0 {
 LIBBPF_0.7.0 {
 	global:
 		bpf_btf_load;
+		bpf_program__attach_trace_opts;
 		bpf_program__expected_attach_type;
 		bpf_program__log_buf;
 		bpf_program__log_level;
--=20
2.30.2

