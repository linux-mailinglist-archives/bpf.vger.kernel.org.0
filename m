Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0937423513D
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 10:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgHAItz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 1 Aug 2020 04:49:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27950 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728585AbgHAIty (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 1 Aug 2020 04:49:54 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0718fnn2023960
        for <bpf@vger.kernel.org>; Sat, 1 Aug 2020 01:49:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=NKQqwLFy8/q+xi0MOf7ccTYyH52VimvbRfy6sPrQxH0=;
 b=miRPqVAtOfsMZ4nFysxkGPoxisbN8mrDb4YFYJJ0/5IeMPPUhymb72Myis3STPwEwyjd
 Qd14JngWOW/TqnSV4TdssAP1OgMqpKSp+YIwfuQNTMWNraVog/1vPQEilv+nUb0vUrcy
 VvjfeaPQcMpp0sf2k7eWmNLuwrX9DZkMtvI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 32n3qd07sv-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Sat, 01 Aug 2020 01:49:54 -0700
Received: from intmgw004.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sat, 1 Aug 2020 01:49:49 -0700
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 7AAC362E53C9; Sat,  1 Aug 2020 01:47:27 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig006.ftw2.facebook.com
To:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@chromium.org>,
        <brouer@redhat.com>, <dlxu@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH bpf-next 2/5] libbpf: support BPF_PROG_TYPE_USER programs
Date:   Sat, 1 Aug 2020 01:47:18 -0700
Message-ID: <20200801084721.1812607-3-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200801084721.1812607-1-songliubraving@fb.com>
References: <20200801084721.1812607-1-songliubraving@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-01_07:2020-07-31,2020-08-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008010067
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add cpu_plus to bpf_prog_test_run_attr. Add BPF_PROG_SEC "user" for
BPF_PROG_TYPE_USER programs.

Signed-off-by: Song Liu <songliubraving@fb.com>
---
 tools/lib/bpf/bpf.c           | 1 +
 tools/lib/bpf/bpf.h           | 3 +++
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 1 +
 4 files changed, 6 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index e1bdf214f75fe..b28c3daa9c270 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -693,6 +693,7 @@ int bpf_prog_test_run_xattr(struct bpf_prog_test_run_=
attr *test_attr)
 	attr.test.ctx_size_in =3D test_attr->ctx_size_in;
 	attr.test.ctx_size_out =3D test_attr->ctx_size_out;
 	attr.test.repeat =3D test_attr->repeat;
+	attr.test.cpu_plus =3D test_attr->cpu_plus;
=20
 	ret =3D sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
 	test_attr->data_size_out =3D attr.test.data_size_out;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 6d367e01d05e9..0c799740df566 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -205,6 +205,9 @@ struct bpf_prog_test_run_attr {
 	void *ctx_out;      /* optional */
 	__u32 ctx_size_out; /* in: max length of ctx_out
 			     * out: length of cxt_out */
+	__u32 cpu_plus;	    /* specify which cpu to run the test with
+			     * cpu_plus =3D cpu_id + 1.
+			     * If cpu_plus =3D 0, run on current cpu */
 };
=20
 LIBBPF_API int bpf_prog_test_run_xattr(struct bpf_prog_test_run_attr *te=
st_attr);
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b9f11f854985b..9ce175a486214 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6922,6 +6922,7 @@ static const struct bpf_sec_def section_defs[] =3D =
{
 	BPF_PROG_SEC("lwt_out",			BPF_PROG_TYPE_LWT_OUT),
 	BPF_PROG_SEC("lwt_xmit",		BPF_PROG_TYPE_LWT_XMIT),
 	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
+	BPF_PROG_SEC("user",			BPF_PROG_TYPE_USER),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.=
c
index 5a3d3f0784081..163013084000e 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -112,6 +112,7 @@ probe_load(enum bpf_prog_type prog_type, const struct=
 bpf_insn *insns,
 	case BPF_PROG_TYPE_STRUCT_OPS:
 	case BPF_PROG_TYPE_EXT:
 	case BPF_PROG_TYPE_LSM:
+	case BPF_PROG_TYPE_USER:
 	default:
 		break;
 	}
--=20
2.24.1

