Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238485A1DB8
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 02:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbiHZAiF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 20:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHZAiE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 20:38:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1749CC7F93
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:03 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PM4LJe008184
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=L31dVQbj43xil/VYLqGUdhtNts7bYluBBMk3yvVLWBk=;
 b=l1uLfYra9AjHVsZ7/fHdtmLIQm2OjNXLyhbCfQknSQbKcsWB3KOPh89Y4lciSb5JUJmL
 cSvLPqX2reXadZ5KpfMP7+PmQMC9EgPghu9LZzHT9jZQJ8+BWcISlkVY1m8VBAiY6cj7
 PT961jQ3VPdTu1MC0sCQ3iC+m893f33Efr8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6cfwk8ec-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 17:38:02 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub102.TheFacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 17:38:02 -0700
Received: from twshared14818.18.frc3.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 25 Aug 2022 17:38:01 -0700
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id E072F71E4BA0; Thu, 25 Aug 2022 17:37:54 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kernel-team@fb.com>, <yhs@fb.com>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next v7 5/5] bpftool: Show parameters of BPF task iterators.
Date:   Thu, 25 Aug 2022 17:37:12 -0700
Message-ID: <20220826003712.2810158-6-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220826003712.2810158-1-kuifeng@fb.com>
References: <20220826003712.2810158-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: fqr3fCkKicCifKVGmETM3y9o3rwQQKpo
X-Proofpoint-ORIG-GUID: fqr3fCkKicCifKVGmETM3y9o3rwQQKpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_11,2022-08-25_01,2022-06-22_01
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

For exampole, the commaned `bpftool link list` may list following
lines.

1: iter  prog 2  target_name bpf_map
2: iter  prog 3  target_name bpf_prog
33: iter  prog 225  target_name task_file  tid 1644
        pids test_progs(1644)

Link 33 is a task_file iterator with tid 1644.  For now, only targets
of task, task_file and task_vma may be with tid or pid to filter out
tasks other than that belong to a process (pid) or a thread (tid).

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/bpf/bpftool/link.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
index 7a20931c3250..f96c18bb7a42 100644
--- a/tools/bpf/bpftool/link.c
+++ b/tools/bpf/bpftool/link.c
@@ -83,6 +83,13 @@ static bool is_iter_map_target(const char *target_name=
)
 	       strcmp(target_name, "bpf_sk_storage_map") =3D=3D 0;
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
@@ -91,6 +98,12 @@ static void show_iter_json(struct bpf_link_info *info,=
 json_writer_t *wtr)
=20
 	if (is_iter_map_target(target_name))
 		jsonw_uint_field(wtr, "map_id", info->iter.map.map_id);
+	else if (is_iter_task_target(target_name)) {
+		if (info->iter.task.tid)
+			jsonw_uint_field(wtr, "tid", info->iter.task.tid);
+		if (info->iter.task.pid)
+			jsonw_uint_field(wtr, "pid", info->iter.task.pid);
+	}
 }
=20
 static int get_prog_info(int prog_id, struct bpf_prog_info *info)
@@ -208,6 +221,12 @@ static void show_iter_plain(struct bpf_link_info *in=
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
 }
=20
 static int show_link_close_plain(int fd, struct bpf_link_info *info)
--=20
2.30.2

