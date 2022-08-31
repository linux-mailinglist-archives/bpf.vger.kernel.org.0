Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4FF5A73FA
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 04:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbiHaCik (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 22:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiHaCii (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 22:38:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92399C530
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:38:37 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27V0pn54030222
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:38:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nX0hkaXwbGcj6iPUlMAG3o/aYy1QJ3VMvYwK3ghX1eI=;
 b=Z4WRLUumL4jonR5GraUirwxyLtubPp8BrSZRCm8FDIdtYd4eg4kSlcKcSxM909dv52Xq
 LxyzbobiPV9b+oN1hJo7dUSyUtd24RY5/xvuvTIgslXeVC2Yh4ZoAE8vSNLEzplg4D0a
 IUhy1mg+uqLiKMZyl0LRzkF9achVcvmtnyo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9yxbqm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 19:38:37 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 19:38:34 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 0D0BD75A7408; Tue, 30 Aug 2022 19:38:32 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v9 5/5] bpftool: Show parameters of BPF task iterators.
Date:   Tue, 30 Aug 2022 19:37:44 -0700
Message-ID: <20220831023744.1790468-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220831023744.1790468-1-kuifeng@fb.com>
References: <20220831023744.1790468-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 3l1rEzphvPNEPBkx08bOPXzlVZqDXxC9
X-Proofpoint-GUID: 3l1rEzphvPNEPBkx08bOPXzlVZqDXxC9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

