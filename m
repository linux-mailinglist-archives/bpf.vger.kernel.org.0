Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 559C440E143
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 18:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhIPQ2z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 12:28:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55700 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242040AbhIPQ0d (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 12:26:33 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GFgs8s005005
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=jLNFft97hv/+lzB1+kKBtzjwdHEKLK12ir3d65yRKbs=;
 b=BdE8vgfuIBiqSt7JKmZakqlS4vbYR7D0qzVC1UTsbGgAFri1TttE1Zqg2mdtAaNRWuAa
 UrDz10ftOJTe2Br6skpcjBhHRf4J+6rb3H+smx7SgZzqPAXFH/+qTY75EF1sRH++iVFC
 c5RY1avm01b2awBOJUo6LA6a9DPfPwQVMDo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3dkwjsb3-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 16 Sep 2021 09:25:12 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Thu, 16 Sep 2021 09:25:04 -0700
Received: by devvm3388.prn0.facebook.com (Postfix, from userid 111017)
        id 495CFBE68AB6; Thu, 16 Sep 2021 09:25:02 -0700 (PDT)
From:   Roman Gushchin <guro@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     Mel Gorman <mgorman@techsingularity.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Roman Gushchin <guro@fb.com>
Subject: [PATCH rfc 6/6] bpftool: recognize scheduler programs
Date:   Thu, 16 Sep 2021 09:24:51 -0700
Message-ID: <20210916162451.709260-7-guro@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916162451.709260-1-guro@fb.com>
References: <20210915213550.3696532-1-guro@fb.com>
 <20210916162451.709260-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: 8HvMUC_xPgX95nOH5jqKUhGlVBP27p6z
X-Proofpoint-ORIG-GUID: 8HvMUC_xPgX95nOH5jqKUhGlVBP27p6z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_04,2021-09-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 clxscore=1015 suspectscore=0 mlxlogscore=595 impostorscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Teach bpftool to recognize scheduler bpf programs.

Signed-off-by: Roman Gushchin <guro@fb.com>
---
 tools/bpf/bpftool/common.c | 1 +
 tools/bpf/bpftool/prog.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index d42d930a3ec4..c73d634f4e82 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -73,6 +73,7 @@ const char * const attach_type_name[__MAX_BPF_ATTACH_TY=
PE] =3D {
 	[BPF_XDP]			=3D "xdp",
 	[BPF_SK_REUSEPORT_SELECT]	=3D "sk_skb_reuseport_select",
 	[BPF_SK_REUSEPORT_SELECT_OR_MIGRATE]	=3D "sk_skb_reuseport_select_or_mi=
grate",
+	[BPF_SCHED]			=3D "sched",
 };
=20
 void p_err(const char *fmt, ...)
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 9c3e343b7d87..78eb4e807a6b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -67,6 +67,7 @@ const char * const prog_type_name[] =3D {
 	[BPF_PROG_TYPE_EXT]			=3D "ext",
 	[BPF_PROG_TYPE_LSM]			=3D "lsm",
 	[BPF_PROG_TYPE_SK_LOOKUP]		=3D "sk_lookup",
+	[BPF_PROG_TYPE_SCHED]			=3D "sched",
 };
=20
 const size_t prog_type_name_size =3D ARRAY_SIZE(prog_type_name);
--=20
2.31.1

