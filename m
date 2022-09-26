Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721E75EB082
	for <lists+bpf@lfdr.de>; Mon, 26 Sep 2022 20:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbiIZSuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Sep 2022 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiIZSuT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 26 Sep 2022 14:50:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A2C37182
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:15 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28QIBQXD008148
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nX0hkaXwbGcj6iPUlMAG3o/aYy1QJ3VMvYwK3ghX1eI=;
 b=PCzD69daS2OJTV/NAg5gabYTgZIgMheLHcxpQT4K3/KXkiI1GccNa/0fPtOIVBf0Aopv
 EJoiXJJEwBXPva1wXmGwZCknBVAdtk/fqd9ErizGbzLy9BNcqFoyeRTAbCd624GGxUOF
 OPnka+7N5R7Nc8LUhu0zj6M3Vk4oBSwerlk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3jswjunhqv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 26 Sep 2022 11:50:14 -0700
Received: from twshared25017.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 11:50:14 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 20EE7895101F; Mon, 26 Sep 2022 11:50:00 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v11 5/5] bpftool: Show parameters of BPF task iterators.
Date:   Mon, 26 Sep 2022 11:49:57 -0700
Message-ID: <20220926184957.208194-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220926184957.208194-1-kuifeng@fb.com>
References: <20220926184957.208194-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: X65FyXEo4vCo-7UIeTzP_5ku2NlI3ADZ
X-Proofpoint-ORIG-GUID: X65FyXEo4vCo-7UIeTzP_5ku2NlI3ADZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Show tid or pid of iterators if giving an argument of tid or pid

For example, the command `bpftool link list` may list following
lines.

1: iter  prog 2  target_name bpf_map
2: iter  prog 3  target_name bpf_prog
33: iter  prog 225  target_name task_file  tid 1644
        pids test_progs(1644)

Link 33 is a task_file iterator with tid 1644.  For now, only targets
of task, task_file and task_vma may be with tid or pid to filter out
tasks other than those belonging to a process (pid) or a thread (tid).

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
Acked-by: Quentin Monnet <quentin@isovalent.com>
Acked-by: Yonghong Song <yhs@fb.com>
---
 tools/bpf/bpftool/link.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index ef0dc2f8d5a2..2863639706dd 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -106,6 +106,13 @@ static const char *cgroup_order_string(__u32 order)
 	}
 }
=20
+static bool is_iter_task_target(const char *target_name)
+{
+	return strcmp(target_name, "task") =3D=3D 0 ||
+		strcmp(target_name, "task_file") =3D=3D 0 ||
+		strcmp(target_name, "task_vma") =3D=3D 0;
+}
+
 static void show_iter_json(struct bpf_link_info *info, json_writer_t *wt=
r)
 {
 	const char *target_name =3D u64_to_ptr(info->iter.target_name);
@@ -114,6 +121,12 @@ static void show_iter_json(struct bpf_link_info *inf=
o, json_writer_t *wtr)
=20
 	if (is_iter_map_target(target_name))
 		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
+	else if (is_iter_task_target(target_name)) {
+		if (info->iter.task.tid)
+			jsonw_uint_field(wtr, "tid", info->iter.task.tid);
+		else if (info->iter.task.pid)
+			jsonw_uint_field(wtr, "pid", info->iter.task.pid);
+	}
=20
 	if (is_iter_cgroup_target(target_name)) {
 		jsonw_lluint_field(wtr, "cgroup_id", info->iter.cgroup.cgroup_id);
@@ -237,6 +250,12 @@ static void show_iter_plain(struct bpf_link_info *in=
fo)
=20
 	if (is_iter_map_target(target_name))
 		printf("map_id %u  ", info->iter.map.map_id);
+	else if (is_iter_task_target(target_name)) {
+		if (info->iter.task.tid)
+			printf("tid %u ", info->iter.task.tid);
+		else if (info->iter.task.pid)
+			printf("pid %u ", info->iter.task.pid);
+	}
=20
 	if (is_iter_cgroup_target(target_name)) {
 		printf("cgroup_id %llu  ", info->iter.cgroup.cgroup_id);
--=20
2.30.2

