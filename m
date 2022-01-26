Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4C649D4B1
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 22:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232744AbiAZVsX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 16:48:23 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32004 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbiAZVsX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 16:48:23 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20QL24wK005673
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vb1bqpvevvJw77qKF/pvSupfkGkXKoZ8kOt2CxtKzJY=;
 b=JpUHIGmfhngZXmnQ0jTMrK6Qo/x/IaD49W1ccypxgEiLfbK+AJdMCscAfE4/IYHQ8rZL
 o/blmzfr4KQx0ePv9trSXLMDWNfviCs2kQpE6YlsKsX1OdkLCtbo2KNpFGqV9jJhnxrM
 GqlUD9X+gKsTXB8nVdeTekmiLOl02qWYXQ4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtguhu02v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 13:48:22 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 13:48:21 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 278812C9AA2C; Wed, 26 Jan 2022 13:48:16 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH bpf-next 2/5] bpf: Detect if a program needs its program ID.
Date:   Wed, 26 Jan 2022 13:48:06 -0800
Message-ID: <20220126214809.3868787-3-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220126214809.3868787-1-kuifeng@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: AM2kU1n6Q4jmL4IwTP94go5HDeM9o3fP
X-Proofpoint-ORIG-GUID: AM2kU1n6Q4jmL4IwTP94go5HDeM9o3fP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_08,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 impostorscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260126
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Scan BPF bytecode to detect if a program calls any functions requiring
a program ID.  So far, bpf_get_attach_cookie() is the only function
that needs a program ID.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 include/linux/filter.h  | 3 ++-
 kernel/bpf/trampoline.c | 7 ++++---
 kernel/bpf/verifier.c   | 3 +++
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index d23e999dc032..4433c5d1bc19 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -572,7 +572,8 @@ struct bpf_prog {
 				has_callchain_buf:1, /* callchain buffer allocated? */
 				enforce_expected_attach_type:1, /* Enforce expected_attach_type chec=
king at attach time */
 				call_get_stack:1, /* Do we call bpf_get_stack() or bpf_get_stackid()=
 */
-				call_get_func_ip:1; /* Do we call get_func_ip() */
+				call_get_func_ip:1, /* Do we call get_func_ip() */
+				need_prog_id:1; /* Do we need program ID? */
 	enum bpf_prog_type	type;		/* Type of BPF program */
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 4b6974a195c1..c65622e4216c 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -181,7 +181,7 @@ static int register_fentry(struct bpf_trampoline *tr,=
 void *new_addr)
 }
=20
 static struct bpf_tramp_progs *
-bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bo=
ol *ip_arg)
+bpf_trampoline_get_progs(const struct bpf_trampoline *tr, int *total, bo=
ol *ip_arg, bool *prog_id)
 {
 	const struct bpf_prog_aux *aux;
 	struct bpf_tramp_progs *tprogs;
@@ -200,6 +200,7 @@ bpf_trampoline_get_progs(const struct bpf_trampoline =
*tr, int *total, bool *ip_a
=20
 		hlist_for_each_entry(aux, &tr->progs_hlist[kind], tramp_hlist) {
 			*ip_arg |=3D aux->prog->call_get_func_ip;
+			*prog_id |=3D aux->prog->need_prog_id;
 			*progs++ =3D aux->prog;
 		}
 	}
@@ -344,10 +345,10 @@ static int bpf_trampoline_update(struct bpf_trampol=
ine *tr)
 	struct bpf_tramp_image *im;
 	struct bpf_tramp_progs *tprogs;
 	u32 flags =3D BPF_TRAMP_F_RESTORE_REGS;
-	bool ip_arg =3D false;
+	bool ip_arg =3D false, prog_id =3D false;
 	int err, total;
=20
-	tprogs =3D bpf_trampoline_get_progs(tr, &total, &ip_arg);
+	tprogs =3D bpf_trampoline_get_progs(tr, &total, &ip_arg, &prog_id);
 	if (IS_ERR(tprogs))
 		return PTR_ERR(tprogs);
=20
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ff91f5038010..0359242e2a81 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6812,6 +6812,9 @@ static int check_helper_call(struct bpf_verifier_en=
v *env, struct bpf_insn *insn
 		env->prog->call_get_func_ip =3D true;
 	}
=20
+	if (func_id =3D=3D BPF_FUNC_get_attach_cookie)
+		env->prog->need_prog_id =3D true;
+
 	if (changes_data)
 		clear_all_pkt_pointers(env);
 	return 0;
--=20
2.30.2

