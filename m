Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 924EB22F7FE
	for <lists+bpf@lfdr.de>; Mon, 27 Jul 2020 20:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgG0SpP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jul 2020 14:45:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8158 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728581AbgG0SpO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 27 Jul 2020 14:45:14 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06RIf4tE020156
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=zGK16O/SqBwirKsEmrbqGLXTndq4UsGeeEkKv4p9xoo=;
 b=db/Yhk8JoqJBvo0PmK42y9itrvAJTHNGRByTF2VbH8XVbZ/EAuE4EFr3+98XWwuJpqEf
 dzX2fo72aviCQWDra4zrpknSxRe9JDCMjqprBJagX9wC3J1qk64hRhFgRRTazyD+hvY+
 nB7n8a/b8cRdKoWTaZjz9/6HqlQTTjdL3pM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 32h4k25ux6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2020 11:45:14 -0700
Received: from intmgw002.06.prn3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 27 Jul 2020 11:45:13 -0700
Received: by devvm1096.prn0.facebook.com (Postfix, from userid 111017)
        id 8E0761DAFE73; Mon, 27 Jul 2020 11:45:10 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm1096.prn0.facebook.com
To:     <bpf@vger.kernel.org>
CC:     <netdev@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn0c01
Subject: [PATCH bpf-next v2 01/35] bpf: memcg-based memory accounting for bpf progs
Date:   Mon, 27 Jul 2020 11:44:32 -0700
Message-ID: <20200727184506.2279656-2-guro@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200727184506.2279656-1-guro@fb.com>
References: <20200727184506.2279656-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-27_13:2020-07-27,2020-07-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=542 mlxscore=0 spamscore=0 suspectscore=38
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007270126
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include memory used by bpf programs into the memcg-based accounting.
This includes the memory used by programs itself, auxiliary data
and statistics.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 kernel/bpf/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index bde93344164d..daab8dcafbd4 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -77,7 +77,7 @@ void *bpf_internal_load_pointer_neg_helper(const struct=
 sk_buff *skb, int k, uns
=20
 struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int size, gfp_t gfp_ex=
tra_flags)
 {
-	gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog_aux *aux;
 	struct bpf_prog *fp;
=20
@@ -86,7 +86,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int s=
ize, gfp_t gfp_extra_flag
 	if (fp =3D=3D NULL)
 		return NULL;
=20
-	aux =3D kzalloc(sizeof(*aux), GFP_KERNEL | gfp_extra_flags);
+	aux =3D kzalloc(sizeof(*aux), GFP_KERNEL_ACCOUNT | gfp_extra_flags);
 	if (aux =3D=3D NULL) {
 		vfree(fp);
 		return NULL;
@@ -104,7 +104,7 @@ struct bpf_prog *bpf_prog_alloc_no_stats(unsigned int=
 size, gfp_t gfp_extra_flag
=20
 struct bpf_prog *bpf_prog_alloc(unsigned int size, gfp_t gfp_extra_flags=
)
 {
-	gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog *prog;
 	int cpu;
=20
@@ -217,7 +217,7 @@ void bpf_prog_free_linfo(struct bpf_prog *prog)
 struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int =
size,
 				  gfp_t gfp_extra_flags)
 {
-	gfp_t gfp_flags =3D GFP_KERNEL | __GFP_ZERO | gfp_extra_flags;
+	gfp_t gfp_flags =3D GFP_KERNEL_ACCOUNT | __GFP_ZERO | gfp_extra_flags;
 	struct bpf_prog *fp;
 	u32 pages, delta;
 	int ret;
--=20
2.26.2

