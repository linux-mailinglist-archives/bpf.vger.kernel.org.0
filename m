Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59301A4AD8
	for <lists+bpf@lfdr.de>; Fri, 10 Apr 2020 21:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJTyX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Apr 2020 15:54:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21934 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726263AbgDJTyX (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Apr 2020 15:54:23 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AJkPa8017037
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=uwp71Ob9R0r0n9NMW7YFhybfU3k19sFM++vLav3a/Ag=;
 b=ggP8rJ25U8vmUQmL8sSalkO8BL2CvX2MagBiVyf5bN1D+/QWc6ipMGQd0klvXFpSpGhT
 ddZnj532bFeh0G+Yu79oAVfgMvMNTfLMcUhCrtCowR7Ine4dwLTAzs83PPjsuTEkkRr7
 NzrQSYM76Dk/RU7SPVzgvEBBpAtizfik7Fs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3091n49egt-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Apr 2020 12:54:22 -0700
Received: from intmgw001.41.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 10 Apr 2020 12:54:21 -0700
Received: by dev082.prn2.facebook.com (Postfix, from userid 572249)
        id D568E37007ED; Fri, 10 Apr 2020 12:54:20 -0700 (PDT)
Smtp-Origin-Hostprefix: dev
From:   Andrey Ignatov <rdna@fb.com>
Smtp-Origin-Hostname: dev082.prn2.facebook.com
To:     <bpf@vger.kernel.org>
CC:     Andrey Ignatov <rdna@fb.com>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kernel-team@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf 1/2] libbpf: Fix loading cgroup_skb/egress with ret in [2, 3]
Date:   Fri, 10 Apr 2020 12:54:00 -0700
Message-ID: <daa546903aa74cf844452b7f80788d67c15b42ea.1586547735.git.rdna@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1586547735.git.rdna@fb.com>
References: <cover.1586547735.git.rdna@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_08:2020-04-09,2020-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0 mlxscore=0
 priorityscore=1501 malwarescore=0 suspectscore=13 adultscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004100146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Initially BPF_CGROUP_INET_EGRESS hook didn't require specifying
expected_attach_type at loading time, but commit

  5cf1e9145630 ("bpf: cgroup inet skb programs can return 0 to 3")

changed it so that expected_attach_type must be specified if program can
return either 2 or 3 (before it was either 0 or 1) to communicate
congestion notification to caller.

At the same time loading w/o expected_attach_type is still supported for
backward compatibility if program retval is in tnum_range(0, 1).

Though libbpf currently supports guessing prog/attach/expected_attach
types only for "old" mode (retval in [0; 1]). And if cgroup_skb egress
program stars returning e.g. 2 (corresponds to NET_XMIT_CN), then
guessing breaks and, e.g. bpftool can't load an object with such a
program anymore:

  # bpftool prog loadall tools/testing/selftests/bpf/test_skb.o /sys/fs/b=
pf/test_skb
  libbpf: load bpf program failed: Invalid argument
  libbpf: -- BEGIN DUMP LOG ---
  libbpf:
  ; return tc_prog(skb) =3D=3D TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
  0: (85) call pc+5

   ... skip ...

  from 87 to 1: R0_w=3DinvP2 R10=3Dfp0
  ; return tc_prog(skb) =3D=3D TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
  1: (bc) w1 =3D w0
  2: (b4) w0 =3D 1
  3: (16) if w1 =3D=3D 0x0 goto pc+1
  4: (b4) w0 =3D 2
  ; return tc_prog(skb) =3D=3D TC_ACT_OK ? 1 : 2 /* NET_XMIT_CN */;
  5: (95) exit
  At program exit the register R0 has value (0x2; 0x0) should have been i=
n (0x0; 0x1)
  processed 96 insns (limit 1000000) max_states_per_insn 1 total_states 1=
0 peak_states 10 mark_read 2

  libbpf: -- END LOG --
  libbpf: failed to load program 'cgroup_skb/egress'
  libbpf: failed to load object 'tools/testing/selftests/bpf/test_skb.o'
  Error: failed to load object file

Fix it by introducing another entry in libbpf section_defs that makes the=
 load
happens with expected_attach_type: cgroup_skb/egress/expected

That name may not be ideal, but I don't have a better option.

Strictly speaking this is not a fix but rather a missing feature, that's
why there is no Fixes tag. But it still seems to be a good idea to merge
it to stable tree to fix loading programs that use a feature available
for almost a year.

Signed-off-by: Andrey Ignatov <rdna@fb.com>
---
 tools/lib/bpf/libbpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ff9174282a8c..c909352f894d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6330,6 +6330,8 @@ static const struct bpf_sec_def section_defs[] =3D =
{
 	BPF_PROG_SEC("lwt_seg6local",		BPF_PROG_TYPE_LWT_SEG6LOCAL),
 	BPF_APROG_SEC("cgroup_skb/ingress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_INGRESS),
+	BPF_EAPROG_SEC("cgroup_skb/egress/expected", BPF_PROG_TYPE_CGROUP_SKB,
+						BPF_CGROUP_INET_EGRESS),
 	BPF_APROG_SEC("cgroup_skb/egress",	BPF_PROG_TYPE_CGROUP_SKB,
 						BPF_CGROUP_INET_EGRESS),
 	BPF_APROG_COMPAT("cgroup/skb",		BPF_PROG_TYPE_CGROUP_SKB),
--=20
2.24.1

