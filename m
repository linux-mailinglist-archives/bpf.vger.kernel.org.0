Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC950957F
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 05:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiDUDmv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 20 Apr 2022 23:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384015AbiDUDms (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 23:42:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC59163C0
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:40:00 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KL3ZvN007577
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fjsrjsy1v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 20:39:59 -0700
Received: from twshared13315.14.prn3.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 20:39:56 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id DD484186F53D6; Wed, 20 Apr 2022 20:39:50 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 2/3] libbpf: teach bpf_link_create() to fallback to bpf_raw_tracepoint_open()
Date:   Wed, 20 Apr 2022 20:39:44 -0700
Message-ID: <20220421033945.3602803-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421033945.3602803-1-andrii@kernel.org>
References: <20220421033945.3602803-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: l_LD7uXBWHRDnjOi2q8tfn8yHIZ4yXyD
X-Proofpoint-GUID: l_LD7uXBWHRDnjOi2q8tfn8yHIZ4yXyD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_06,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach bpf_link_create() to fallback to bpf_raw_tracepoint_open() on
older kernels for programs that are attachable through
BPF_RAW_TRACEPOINT_OPEN. This makes bpf_link_create() more unified and
convenient interface for creating bpf_link-based attachments.

With this approach end users can just use bpf_link_create() for
tp_btf/fentry/fexit/fmod_ret/lsm program attachments without needing to
care about kernel support, as libbpf will handle this transparently. On
the other hand, as newer features (like BPF cookie) are added to
LINK_CREATE interface, they will be readily usable though the same
bpf_link_create() API without any major refactoring from user's
standpoint.

bpf_program__attach_btf_id() is now using bpf_link_create() internally
as well and will take advantaged of this unified interface when BPF
cookie is added for fentry/fexit.

Doing proactive feature detection of LINK_CREATE support for
fentry/tp_btf/etc is quite involved. It requires parsing vmlinux BTF,
determining some stable and guaranteed to be in all kernels versions
target BTF type (either raw tracepoint or fentry target function),
actually attaching this program and thus potentially affecting the
performance of the host kernel briefly, etc. So instead we are taking
much simpler "lazy" approach of falling back to
bpf_raw_tracepoint_open() call only if initial LINK_CREATE command
fails. For modern kernels this will mean zero added overhead, while
older kernels will incur minimal overhead with a single fast-failing
LINK_CREATE call.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/bpf.c    | 34 ++++++++++++++++++++++++++++++++--
 tools/lib/bpf/libbpf.c |  3 ++-
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index cf27251adb92..a9d292c106c2 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -817,7 +817,7 @@ int bpf_link_create(int prog_fd, int target_fd,
 {
 	__u32 target_btf_id, iter_info_len;
 	union bpf_attr attr;
-	int fd;
+	int fd, err;
 
 	if (!OPTS_VALID(opts, bpf_link_create_opts))
 		return libbpf_err(-EINVAL);
@@ -870,7 +870,37 @@ int bpf_link_create(int prog_fd, int target_fd,
 	}
 proceed:
 	fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, sizeof(attr));
-	return libbpf_err_errno(fd);
+	if (fd >= 0)
+		return fd;
+	/* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
+	 * and other similar programs
+	 */
+	err = -errno;
+	if (err != -EINVAL)
+		return libbpf_err(err);
+
+	/* if user used features not supported by
+	 * BPF_RAW_TRACEPOINT_OPEN command, then just give up immediately
+	 */
+	if (attr.link_create.target_fd || attr.link_create.target_btf_id)
+		return libbpf_err(err);
+	if (!OPTS_ZEROED(opts, sz))
+		return libbpf_err(err);
+
+	/* otherwise, for few select kinds of programs that can be
+	 * attached using BPF_RAW_TRACEPOINT_OPEN command, try that as
+	 * a fallback for older kernels
+	 */
+	switch (attach_type) {
+	case BPF_TRACE_RAW_TP:
+	case BPF_LSM_MAC:
+	case BPF_TRACE_FENTRY:
+	case BPF_TRACE_FEXIT:
+	case BPF_MODIFY_RETURN:
+		return bpf_raw_tracepoint_open(NULL, prog_fd);
+	default:
+		return libbpf_err(err);
+	}
 }
 
 int bpf_link_detach(int link_fd)
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 94940497354b..ae317df1fc57 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11262,7 +11262,8 @@ static struct bpf_link *bpf_program__attach_btf_id(const struct bpf_program *pro
 		return libbpf_err_ptr(-ENOMEM);
 	link->detach = &bpf_link__detach_fd;
 
-	pfd = bpf_raw_tracepoint_open(NULL, prog_fd);
+	/* libbpf is smart enough to redirect to BPF_RAW_TRACEPOINT_OPEN on old kernels */
+	pfd = bpf_link_create(prog_fd, 0, bpf_program__expected_attach_type(prog), NULL);
 	if (pfd < 0) {
 		pfd = -errno;
 		free(link);
-- 
2.30.2

