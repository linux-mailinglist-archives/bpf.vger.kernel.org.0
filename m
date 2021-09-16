Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E239240D17A
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233564AbhIPCAL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19688 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229816AbhIPCAL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:11 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18FM3qGp012307
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:51 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b3jkac8vr-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:51 -0700
Received: from intmgw001.05.prn6.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:49 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 36DA0422A286; Wed, 15 Sep 2021 18:58:47 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 4/7] libbpf: allow skipping attach_func_name in bpf_program__set_attach_target()
Date:   Wed, 15 Sep 2021 18:58:33 -0700
Message-ID: <20210916015836.1248906-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: iRCF89ct4h89Sf-5E9lMnZC0g12QRdFa
X-Proofpoint-ORIG-GUID: iRCF89ct4h89Sf-5E9lMnZC0g12QRdFa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=737 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160011
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow to use bpf_program__set_attach_target to only set target attach
program FD, while letting libbpf to use target attach function name from
SEC() definition. This might be useful for some scenarios where
bpf_object contains multiple related freplace BPF programs intended to
replace different sub-programs in target BPF program. In such case all
programs will have the same attach_prog_fd, but different
attach_func_name. It's conveninent to specify such target function names
declaratively in SEC() definitions, but attach_prog_fd is a dynamic
runtime setting.

To simplify such scenario, allow bpf_program__set_attach_target() to
delay BTF ID resolution till the BPF program load time by providing NULL
attach_func_name. In that case the behavior will be similar to using
bpf_object_open_opts.attach_prog_fd (which is marked deprecated since
v0.7), but has the benefit of allowing more control by user in what is
attached to what. Such setup allows having BPF programs attached to
different target attach_prog_fd with target funtions still declaratively
recorded in BPF source code in SEC() definitions.

Selftests changes in the next patch should make this more obvious.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5ba11b249e9b..552d05a85cbb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -10643,18 +10643,29 @@ int bpf_program__set_attach_target(struct bpf_program *prog,
 {
 	int btf_obj_fd = 0, btf_id = 0, err;
 
-	if (!prog || attach_prog_fd < 0 || !attach_func_name)
+	if (!prog || attach_prog_fd < 0)
 		return libbpf_err(-EINVAL);
 
 	if (prog->obj->loaded)
 		return libbpf_err(-EINVAL);
 
+	if (attach_prog_fd && !attach_func_name) {
+		/* remember attach_prog_fd and let bpf_program__load() find
+		 * BTF ID during the program load
+		 */
+		prog->attach_prog_fd = attach_prog_fd;
+		return 0;
+	}
+
 	if (attach_prog_fd) {
 		btf_id = libbpf_find_prog_btf_id(attach_func_name,
 						 attach_prog_fd);
 		if (btf_id < 0)
 			return libbpf_err(btf_id);
 	} else {
+		if (!attach_func_name)
+			return libbpf_err(-EINVAL);
+
 		/* load btf_vmlinux, if not yet */
 		err = bpf_object__load_vmlinux_btf(prog->obj, true);
 		if (err)
-- 
2.30.2

