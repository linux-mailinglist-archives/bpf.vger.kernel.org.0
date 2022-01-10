Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA9448A30A
	for <lists+bpf@lfdr.de>; Mon, 10 Jan 2022 23:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242590AbiAJWgN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 10 Jan 2022 17:36:13 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:23970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S242548AbiAJWgN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 10 Jan 2022 17:36:13 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20AJZ9vb014982
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:36:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=nDnseGQQZAXRcPYJURETqGAZciJp5N121Z2dvHl4zKQ=;
 b=V8dQ9nfwilTRLUaMuXDDwFZjwTjlyE5aEDXZC9z/CvpXbyk7MMgo8Ag76aDKFJV1v4Ic
 o8Q9Wgy7rNrrc+B2JzcIex7Z3NiRkJgsJbz/c4rCkoaQxmn76o5C3tVnPAK8QSMu6eJp
 HFLN8eK2WY7vCLcweBRJQJ79N/Jk3MOC6ys= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dgtkbhdxq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 10 Jan 2022 14:36:12 -0800
Received: from twshared12416.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 10 Jan 2022 14:36:11 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 9AEB02124792; Mon, 10 Jan 2022 14:36:06 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v4 bpf-next 3/4] tools/perf: Stop using bpf_object__find_program_by_title API.
Date:   Mon, 10 Jan 2022 14:34:45 -0800
Message-ID: <20220110223446.345531-4-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220110223446.345531-1-kuifeng@fb.com>
References: <20220110223446.345531-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: h7d1BDnrALRFDW4MrKrdG99LIV0BUS3k
X-Proofpoint-ORIG-GUID: h7d1BDnrALRFDW4MrKrdG99LIV0BUS3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_10,2022-01-10_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100146
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

