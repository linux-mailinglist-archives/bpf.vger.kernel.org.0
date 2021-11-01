Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3304F44238F
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 23:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbhKAWtH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 18:49:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:14142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229848AbhKAWtG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 18:49:06 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A1GobZi005512
        for <bpf@vger.kernel.org>; Mon, 1 Nov 2021 15:46:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wtDfupDnUeK2GmXhiYUJq/iMmB9T61YCROCImzi4NYo=;
 b=bioNMm0P4b/5KBXvPcqXGfRWYw4pUedHQE436jQn3YEfYZexGCAVoijt/RYsFTnHnohX
 HVR+41Ik8QiRAKlw/GjwaqHWv5qISsE/+hMjwV0OuoiqXj/JvQQCsWS9H0MCNN/qY1Sm
 lHZhZHXYMZC3RM6xdCb6WJywq8hhNoktwXg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3c2dp1n3xa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 15:46:32 -0700
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 1 Nov 2021 15:46:23 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 499C68EEEAF5; Mon,  1 Nov 2021 15:44:00 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH v3 bpf-next 1/4] bpftool: Migrate -1 err checks of libbpf fn calls
Date:   Mon, 1 Nov 2021 15:43:54 -0700
Message-ID: <20211101224357.2651181-2-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211101224357.2651181-1-davemarchevsky@fb.com>
References: <20211101224357.2651181-1-davemarchevsky@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: ofIm3dX44SISRqZ91u2tsoJ8Cj40r48i
X-Proofpoint-GUID: ofIm3dX44SISRqZ91u2tsoJ8Cj40r48i
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-01_07,2021-11-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=896 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111010119
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Per [0], callers of libbpf functions with LIBBPF_STRICT_DIRECT_ERRS set
should handle negative error codes of various values (e.g. -EINVAL).
Migrate two callsites which were explicitly checking for -1 only to
handle the new scheme.

  [0]: https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#dir=
ect-error-code-returning-libbpf_strict_direct_errs

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 +-
 tools/bpf/bpftool/struct_ops.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 9c25286a5c73..6934e8634b94 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -52,7 +52,7 @@ static int dump_prog_id_as_func_ptr(const struct btf_dump=
er *d,
=20
 	/* Get the bpf_prog's name.  Obtain from func_info. */
 	prog_fd =3D bpf_prog_get_fd_by_id(prog_id);
-	if (prog_fd =3D=3D -1)
+	if (prog_fd < 0)
 		goto print;
=20
 	prog_info =3D bpf_program__get_prog_info_linear(prog_fd,
diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
index ab2d2290569a..20f803dce2e4 100644
--- a/tools/bpf/bpftool/struct_ops.c
+++ b/tools/bpf/bpftool/struct_ops.c
@@ -252,7 +252,7 @@ static struct res do_one_id(const char *id_str, work_fu=
nc func, void *data,
 	}
=20
 	fd =3D bpf_map_get_fd_by_id(id);
-	if (fd =3D=3D -1) {
+	if (fd < 0) {
 		p_err("can't get map by id (%lu): %s", id, strerror(errno));
 		res.nr_errs++;
 		return res;
--=20
2.30.2

