Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0F65F5813
	for <lists+bpf@lfdr.de>; Wed,  5 Oct 2022 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbiJEQPC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 5 Oct 2022 12:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiJEQPA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 5 Oct 2022 12:15:00 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1232A1EECB
        for <bpf@vger.kernel.org>; Wed,  5 Oct 2022 09:14:59 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 295EPiU0007568
        for <bpf@vger.kernel.org>; Wed, 5 Oct 2022 09:14:59 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3k0sjapxen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 05 Oct 2022 09:14:59 -0700
Received: from twshared29845.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 5 Oct 2022 09:14:57 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C47D81FBED49D; Wed,  5 Oct 2022 09:14:55 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/3] selftests/bpf: add BPF object fixup step to veristat
Date:   Wed, 5 Oct 2022 09:14:50 -0700
Message-ID: <20221005161450.1064469-3-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221005161450.1064469-1-andrii@kernel.org>
References: <20221005161450.1064469-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ZauFIgPgHteo8_s9vX1wp7HGgnA81lG6
X-Proofpoint-ORIG-GUID: ZauFIgPgHteo8_s9vX1wp7HGgnA81lG6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-05_03,2022-10-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a step to attempt to "fix up" BPF object file to make it possible to
successfully load it. E.g., set non-zero size for BPF maps that expect
max_entries set, but BPF object file itself doesn't have declarative
max_entries values specified.

Another issue was with automatic map pinning. Pinning has no effect on
BPF verification process itself but can interfere when validating
multiple related programs and object files, so veristat disabled all the
pinning explicitly.

In the future more such fix up heuristics could be added to accommodate
common patterns encountered in practice.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/veristat.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 38f678122a7d..973cbf6af323 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -509,6 +509,28 @@ static int parse_verif_log(char * const buf, size_t buf_sz, struct verif_stats *
 	return 0;
 }
 
+static void fixup_obj(struct bpf_object *obj)
+{
+	struct bpf_map *map;
+
+	bpf_object__for_each_map(map, obj) {
+		/* disable pinning */
+		bpf_map__set_pin_path(map, NULL);
+
+		/* fix up map size, if necessary */
+		switch (bpf_map__type(map)) {
+		case BPF_MAP_TYPE_SK_STORAGE:
+		case BPF_MAP_TYPE_TASK_STORAGE:
+		case BPF_MAP_TYPE_INODE_STORAGE:
+		case BPF_MAP_TYPE_CGROUP_STORAGE:
+			break;
+		default:
+			if (bpf_map__max_entries(map) == 0)
+				bpf_map__set_max_entries(map, 1);
+		}
+	}
+}
+
 static int process_prog(const char *filename, struct bpf_object *obj, struct bpf_program *prog)
 {
 	const char *prog_name = bpf_program__name(prog);
@@ -543,6 +565,9 @@ static int process_prog(const char *filename, struct bpf_object *obj, struct bpf
 	}
 	verif_log_buf[0] = '\0';
 
+	/* increase chances of successful BPF object loading */
+	fixup_obj(obj);
+
 	err = bpf_object__load(obj);
 	env.progs_processed++;
 
-- 
2.30.2

