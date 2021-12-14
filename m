Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA67D473BA7
	for <lists+bpf@lfdr.de>; Tue, 14 Dec 2021 04:43:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhLNDnA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Dec 2021 22:43:00 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2256 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230072AbhLNDm7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Dec 2021 22:42:59 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BDMcxBH008544
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:42:59 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nDnseGQQZAXRcPYJURETqGAZciJp5N121Z2dvHl4zKQ=;
 b=UI/24LDLIo356UT+uL3hwa+9zk9KKysknG2p3dFbrOm13+cJD1G09DX6v4lhwf9jFy4k
 YUlLK2osQ8QYnvpBtPRfRs4B+7btP6jyimW5hM8ET6poG5rLc9wgJlEUgjloA/wpqGnq
 HBN2WI/I8yZK7d/Mn/brcuCwpoE/F3r2YVQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3cx9rqvb6m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 13 Dec 2021 19:42:59 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 13 Dec 2021 19:42:58 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 2C8D3112FDEA; Mon, 13 Dec 2021 19:42:53 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v3 bpf-next 3/4] tools/perf: Stop using bpf_object__find_program_by_title API.
Date:   Mon, 13 Dec 2021 19:41:46 -0800
Message-ID: <20211214034147.1071682-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211214034147.1071682-1-kuifeng@fb.com>
References: <20211214034147.1071682-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: O_gdcxBVrkdhccBrwEjez_mYYKNKyZI0
X-Proofpoint-ORIG-GUID: O_gdcxBVrkdhccBrwEjez_mYYKNKyZI0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-14_01,2021-12-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=967
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112140018
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

bpf_obj__find_program_by_title() in libbpf is going to be deprecated.
Call bpf_object_for_each_program to find a program in the section with
a given name instead.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/perf/builtin-trace.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 624ea12ce5ca..7c7278e434a0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3253,10 +3253,21 @@ static void trace__set_bpf_map_syscalls(struct tr=
ace *trace)
=20
 static struct bpf_program *trace__find_bpf_program_by_title(struct trace=
 *trace, const char *name)
 {
+	struct bpf_program *pos, *prog =3D NULL;
+	const char *sec_name;
+
 	if (trace->bpf_obj =3D=3D NULL)
 		return NULL;
=20
-	return bpf_object__find_program_by_title(trace->bpf_obj, name);
+	bpf_object__for_each_program(pos, trace->bpf_obj) {
+		sec_name =3D bpf_program__section_name(pos);
+		if (sec_name && !strcmp(sec_name, name)) {
+			prog =3D pos;
+			break;
+		}
+	}
+
+	return prog;
 }
=20
 static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *tr=
ace, struct syscall *sc,
--=20
2.30.2

