Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1333A22F83C
	for <lists+bpf@lfdr.de>; Mon, 27 Jul 2020 20:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732164AbgG0SrO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 14:47:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:63328 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731999AbgG0Sps (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 14:45:48 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIjhJK027318
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=1iftgx7N4hovl25oCFGN0SNpDQe3eCttfNkL/T08aeE=;
 b=hqwio7CDsr7sysjmzlwRDJw1TdUz4YDDMQlRAWFZU+GyFYNTvLacYLe8Q9KLItsVaPzh
 yVep+Usz4IWsa3G6nZdu6OSf2S+o/wiSu7HYOYJ+D2YehVgewWDoI+lYBSgp4P38jXhb
 PODwj6k+HjH81tus/jJ1FMLFVA20sSV3PxM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32h50vnt0k-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:47 -0700
Received: from intmgw003.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 11:45:21 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 2F2091DAFEAF; Mon, 27 Jul 2020 11:45:11 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v2 31/35] bpf: runqslower: don't touch RLIMIT_MEMLOCK
Date:   Mon, 27 Jul 2020 11:45:02 -0700
Message-ID: <20200727184506.2279656-32-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200727184506.2279656-1-guro@fb.com>
References: <20200727184506.2279656-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=13
 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=916 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since bpf is not using memlock rlimit for memory accounting,
there are no more reasons to bump the limit.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/bpf/runqslower/runqslower.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/tools/bpf/runqslower/runqslower.c b/tools/bpf/runqslower/run=
qslower.c
index d89715844952..a3380b53ce0c 100644
--- a/tools/bpf/runqslower/runqslower.c
+++ b/tools/bpf/runqslower/runqslower.c
@@ -88,16 +88,6 @@ int libbpf_print_fn(enum libbpf_print_level level,
 	return vfprintf(stderr, format, args);
 }
=20
-static int bump_memlock_rlimit(void)
-{
-	struct rlimit rlim_new =3D {
-		.rlim_cur	=3D RLIM_INFINITY,
-		.rlim_max	=3D RLIM_INFINITY,
-	};
-
-	return setrlimit(RLIMIT_MEMLOCK, &rlim_new);
-}
-
 void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
 {
 	const struct event *e =3D data;
@@ -134,12 +124,6 @@ int main(int argc, char **argv)
=20
 	libbpf_set_print(libbpf_print_fn);
=20
-	err =3D bump_memlock_rlimit();
-	if (err) {
-		fprintf(stderr, "failed to increase rlimit: %d", err);
-		return 1;
-	}
-
 	obj =3D runqslower_bpf__open();
 	if (!obj) {
 		fprintf(stderr, "failed to open and/or load BPF object\n");
--=20
2.26.2

