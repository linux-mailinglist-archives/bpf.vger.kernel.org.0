Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B6B3EC7D1
	for <lists+bpf@lfdr.de>; Sun, 15 Aug 2021 09:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbhHOHHH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 15 Aug 2021 03:07:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:20082 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234351AbhHOHHG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 15 Aug 2021 03:07:06 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17F75eVs028079
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:37 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aebhnkp5y-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sun, 15 Aug 2021 00:06:36 -0700
Received: from intmgw006.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 15 Aug 2021 00:06:34 -0700
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id F2D523D405A0; Sun, 15 Aug 2021 00:06:28 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rafael David Tinoco <rafaeldtinoco@gmail.com>
Subject: [PATCH v5 bpf-next 09/16] libbpf: use BPF perf link when supported by kernel
Date:   Sun, 15 Aug 2021 00:06:02 -0700
Message-ID: <20210815070609.987780-10-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210815070609.987780-1-andrii@kernel.org>
References: <20210815070609.987780-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GOA28Tmzy7QJ1Jq43TSXRwVPeqTqWJv1
X-Proofpoint-GUID: GOA28Tmzy7QJ1Jq43TSXRwVPeqTqWJv1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-15_02:2021-08-13,2021-08-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 impostorscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108150049
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Detect kernel support for BPF perf link and prefer it when attaching to
perf_event, tracepoint, kprobe/uprobe. Underlying perf_event FD will be kept
open until BPF link is destroyed, at which point both perf_event FD and BPF
link FD will be closed.

This preserves current behavior in which perf_event FD is open for the
duration of bpf_link's lifetime and user is able to "disconnect" bpf_link from
underlying FD (with bpf_link__disconnect()), so that bpf_link__destroy()
doesn't close underlying perf_event FD.When BPF perf link is used, disconnect
will keep both perf_event and bpf_link FDs open, so it will be up to
(advanced) user to close them. This approach is demonstrated in bpf_cookie.c
selftests, added in this patch set.

Cc: Rafael David Tinoco <rafaeldtinoco@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 111 +++++++++++++++++++++++++++++++++--------
 1 file changed, 90 insertions(+), 21 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index d30e3282bfc7..5dc15f5b4b78 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -193,6 +193,8 @@ enum kern_feature_id {
 	FEAT_MODULE_BTF,
 	/* BTF_KIND_FLOAT support */
 	FEAT_BTF_FLOAT,
+	/* BPF perf link support */
+	FEAT_PERF_LINK,
 	__FEAT_CNT,
 };
 
@@ -4337,6 +4339,37 @@ static int probe_module_btf(void)
 	return !err;
 }
 
+static int probe_perf_link(void)
+{
+	struct bpf_load_program_attr attr;
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_TRACEPOINT;
+	attr.insns = insns;
+	attr.insns_cnt = ARRAY_SIZE(insns);
+	attr.license = "GPL";
+	prog_fd = bpf_load_program_xattr(&attr, NULL, 0);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* use invalid perf_event FD to get EBADF, if link is supported;
+	 * otherwise EINVAL should be returned
+	 */
+	link_fd = bpf_link_create(prog_fd, -1, BPF_PERF_EVENT, NULL);
+	err = -errno; /* close() can clobber errno */
+
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+
+	return link_fd < 0 && err == -EBADF;
+}
+
 enum kern_feature_result {
 	FEAT_UNKNOWN = 0,
 	FEAT_SUPPORTED = 1,
@@ -4387,6 +4420,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_FLOAT] = {
 		"BTF_KIND_FLOAT support", probe_kern_btf_float,
 	},
+	[FEAT_PERF_LINK] = {
+		"BPF perf link support", probe_perf_link,
+	},
 };
 
 static bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
@@ -8951,23 +8987,38 @@ int bpf_link__unpin(struct bpf_link *link)
 	return 0;
 }
 
-static int bpf_link__detach_perf_event(struct bpf_link *link)
+struct bpf_link_perf {
+	struct bpf_link link;
+	int perf_event_fd;
+};
+
+static int bpf_link_perf_detach(struct bpf_link *link)
 {
-	int err;
+	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
+	int err = 0;
 
-	err = ioctl(link->fd, PERF_EVENT_IOC_DISABLE, 0);
-	if (err)
+	if (ioctl(perf_link->perf_event_fd, PERF_EVENT_IOC_DISABLE, 0) < 0)
 		err = -errno;
 
+	if (perf_link->perf_event_fd != link->fd)
+		close(perf_link->perf_event_fd);
 	close(link->fd);
+
 	return libbpf_err(err);
 }
 
+static void bpf_link_perf_dealloc(struct bpf_link *link)
+{
+	struct bpf_link_perf *perf_link = container_of(link, struct bpf_link_perf, link);
+
+	free(perf_link);
+}
+
 struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pfd)
 {
 	char errmsg[STRERR_BUFSIZE];
-	struct bpf_link *link;
-	int prog_fd, err;
+	struct bpf_link_perf *link;
+	int prog_fd, link_fd = -1, err;
 
 	if (pfd < 0) {
 		pr_warn("prog '%s': invalid perf event FD %d\n",
@@ -8984,27 +9035,45 @@ struct bpf_link *bpf_program__attach_perf_event(struct bpf_program *prog, int pf
 	link = calloc(1, sizeof(*link));
 	if (!link)
 		return libbpf_err_ptr(-ENOMEM);
-	link->detach = &bpf_link__detach_perf_event;
-	link->fd = pfd;
+	link->link.detach = &bpf_link_perf_detach;
+	link->link.dealloc = &bpf_link_perf_dealloc;
+	link->perf_event_fd = pfd;
 
-	if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
-		err = -errno;
-		free(link);
-		pr_warn("prog '%s': failed to attach to pfd %d: %s\n",
-			prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
-		if (err == -EPROTO)
-			pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n",
-				prog->name, pfd);
-		return libbpf_err_ptr(err);
+	if (kernel_supports(prog->obj, FEAT_PERF_LINK)) {
+		link_fd = bpf_link_create(prog_fd, pfd, BPF_PERF_EVENT, NULL);
+		if (link_fd < 0) {
+			err = -errno;
+			pr_warn("prog '%s': failed to create BPF link for perf_event FD %d: %d (%s)\n",
+				prog->name, pfd,
+				err, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			goto err_out;
+		}
+		link->link.fd = link_fd;
+	} else {
+		if (ioctl(pfd, PERF_EVENT_IOC_SET_BPF, prog_fd) < 0) {
+			err = -errno;
+			pr_warn("prog '%s': failed to attach to perf_event FD %d: %s\n",
+				prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
+			if (err == -EPROTO)
+				pr_warn("prog '%s': try add PERF_SAMPLE_CALLCHAIN to or remove exclude_callchain_[kernel|user] from pfd %d\n",
+					prog->name, pfd);
+			goto err_out;
+		}
+		link->link.fd = pfd;
 	}
 	if (ioctl(pfd, PERF_EVENT_IOC_ENABLE, 0) < 0) {
 		err = -errno;
-		free(link);
-		pr_warn("prog '%s': failed to enable pfd %d: %s\n",
+		pr_warn("prog '%s': failed to enable perf_event FD %d: %s\n",
 			prog->name, pfd, libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
-		return libbpf_err_ptr(err);
+		goto err_out;
 	}
-	return link;
+
+	return &link->link;
+err_out:
+	if (link_fd >= 0)
+		close(link_fd);
+	free(link);
+	return libbpf_err_ptr(err);
 }
 
 /*
-- 
2.30.2

