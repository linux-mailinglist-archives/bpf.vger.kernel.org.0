Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E51498F44
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 20:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357750AbiAXTvm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 24 Jan 2022 14:51:42 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:24616 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1350023AbiAXTnP (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jan 2022 14:43:15 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20OHVlQ5020323
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:14 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dsk2q5c4t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 24 Jan 2022 11:43:14 -0800
Received: from twshared1259.42.prn1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 11:43:13 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 468C9FF02B02; Mon, 24 Jan 2022 11:43:03 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH v2 bpf-next 4/7] bpftool: use preferred setters/getters instead of deprecated ones
Date:   Mon, 24 Jan 2022 11:42:51 -0800
Message-ID: <20220124194254.2051434-5-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220124194254.2051434-1-andrii@kernel.org>
References: <20220124194254.2051434-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: _58krIhdLf-3KUxzjSsJGCaT43yg5ET4
X-Proofpoint-ORIG-GUID: _58krIhdLf-3KUxzjSsJGCaT43yg5ET4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-24_09,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 spamscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201240129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Use bpf_program__type() instead of discouraged bpf_program__get_type().
Also switch to bpf_map__set_max_entries() instead of bpf_map__resize().

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/gen.c  | 2 +-
 tools/bpf/bpftool/prog.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 43e3f8700ecc..8f78c27d41f0 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -378,7 +378,7 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
 				int prog_fd = skel->progs.%2$s.prog_fd;		    \n\
 			", obj_name, bpf_program__name(prog));
 
-		switch (bpf_program__get_type(prog)) {
+		switch (bpf_program__type(prog)) {
 		case BPF_PROG_TYPE_RAW_TRACEPOINT:
 			tp_name = strchr(bpf_program__section_name(prog), '/') + 1;
 			printf("\tint fd = bpf_raw_tracepoint_open(\"%s\", prog_fd);\n", tp_name);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index cf935c63e6f5..87593f98d2d1 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2283,10 +2283,10 @@ static int do_profile(int argc, char **argv)
 	profile_obj->rodata->num_metric = num_metric;
 
 	/* adjust map sizes */
-	bpf_map__resize(profile_obj->maps.events, num_metric * num_cpu);
-	bpf_map__resize(profile_obj->maps.fentry_readings, num_metric);
-	bpf_map__resize(profile_obj->maps.accum_readings, num_metric);
-	bpf_map__resize(profile_obj->maps.counts, 1);
+	bpf_map__set_max_entries(profile_obj->maps.events, num_metric * num_cpu);
+	bpf_map__set_max_entries(profile_obj->maps.fentry_readings, num_metric);
+	bpf_map__set_max_entries(profile_obj->maps.accum_readings, num_metric);
+	bpf_map__set_max_entries(profile_obj->maps.counts, 1);
 
 	/* change target name */
 	profile_tgt_name = profile_target_name(profile_tgt_fd);
-- 
2.30.2

