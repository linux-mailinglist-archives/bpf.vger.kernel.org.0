Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8663521B0
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 23:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhDAVg1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 17:36:27 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35574 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234200AbhDAVg1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 17:36:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131LUWuq010968
        for <bpf@vger.kernel.org>; Thu, 1 Apr 2021 14:36:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=V+5T3XIzC5HniNwTeNsseSUcAexHr6G7KRoxq51KMuQ=;
 b=Vrq9YzUSdM+PMCv7LJBqYFE3HE9VVl2Cy/CaLXByLwiCkkiq5d0J/Au3gPBHlhas3WsF
 BZXxv/JyYc/8RW847euvuId5mqs7hh1BgVzpg5egrxucIG7f1VypY7RUJ9Ed0C4H95m1
 8zKIOu6+KcCXHXkzLlyrtqsFOAfeYvFLUoE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n2yue5jp-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 01 Apr 2021 14:36:27 -0700
Received: from intmgw001.38.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 14:36:26 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id DBA55F2A0F8; Thu,  1 Apr 2021 14:36:20 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH dwarves] dwarf_loader: handle subprogram ret type with abstract_origin properly
Date:   Thu, 1 Apr 2021 14:36:20 -0700
Message-ID: <20210401213620.3056084-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 78Dgp8M6jmHFlKO6ykJY7xHRnHswF8gF
X-Proofpoint-ORIG-GUID: 78Dgp8M6jmHFlKO6ykJY7xHRnHswF8gF
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

With latest bpf-next built with clang lto (thin or full), I hit one test
failures:
  $ ./test_progs -t tcp
  ...
  libbpf: extern (func ksym) 'tcp_slow_start': func_proto [23] incompatib=
le with kernel [115303]
  libbpf: failed to load object 'bpf_cubic'
  libbpf: failed to load BPF skeleton 'bpf_cubic': -22
  test_cubic:FAIL:bpf_cubic__open_and_load failed
  #9/2 cubic:FAIL
  ...

The reason of the failure is due to bpf program 'tcp_slow_start'
func signature is different from vmlinux BTF. bpf program uses
the following signature:
  extern __u32 tcp_slow_start(struct tcp_sock *tp, __u32 acked);
which is identical to the kernel definition in linux:include/net/tcp.h:
  u32 tcp_slow_start(struct tcp_sock *tp, u32 acked);
While vmlinux BTF definition like:
  [115303] FUNC_PROTO '(anon)' ret_type_id=3D0 vlen=3D2
          'tp' type_id=3D39373
          'acked' type_id=3D18
  [115304] FUNC 'tcp_slow_start' type_id=3D115303 linkage=3Dstatic
The above is dumped with `bpftool btf dump file vmlinux`.
You can see the ret_type_id is 0 and this caused the problem.

Looking at dwarf, we have:

0x11f2ec67:   DW_TAG_subprogram
                DW_AT_low_pc    (0xffffffff81ed2330)
                DW_AT_high_pc   (0xffffffff81ed235c)
                DW_AT_frame_base        ()
                DW_AT_GNU_all_call_sites        (true)
                DW_AT_abstract_origin   (0x11f2ed66 "tcp_slow_start")
...
0x11f2ed66:   DW_TAG_subprogram
                DW_AT_name      ("tcp_slow_start")
                DW_AT_decl_file ("/home/yhs/work/bpf-next/net/ipv4/tcp_co=
ng.c")
                DW_AT_decl_line (392)
                DW_AT_prototyped        (true)
                DW_AT_type      (0x11f130c2 "u32")
                DW_AT_external  (true)
                DW_AT_inline    (DW_INL_inlined)

We have a subprogram which has an abstract_origin pointing to
the subprogram prototype with return type. Current one pass
recoding cannot easily resolve this easily since
at the time recoding for 0x11f2ec67, the return type in
0x11f2ed66 has not been resolved.

To simplify implementation, I just added another pass to
go through all functions after recoding pass. This should
resolve the above issue.

With this patch, among total 250999 functions in vmlinux,
4821 functions needs return type adjustment from type id 0
to correct values. The above failed bpf selftest passed too.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 dwarf_loader.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

Arnaldo, this is the last known pahole bug in my hand w.r.t. clang
LTO. With this, all self tests are passed except ones due
to global function inlining, static variable promotion etc, which
are not related to pahole.

diff --git a/dwarf_loader.c b/dwarf_loader.c
index 026d137..367ac06 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2198,6 +2198,42 @@ out:
 	return 0;
 }
=20
+static int cu__resolve_func_ret_types(struct cu *cu)
+{
+	struct ptr_table *pt =3D &cu->functions_table;
+	uint32_t i;
+
+	for (i =3D 0; i < pt->nr_entries; ++i) {
+		struct tag *tag =3D pt->entries[i];
+
+		if (tag =3D=3D NULL || tag->type !=3D 0)
+			continue;
+
+		struct function *fn =3D tag__function(tag);
+		if (!fn->abstract_origin)
+			continue;
+
+		struct dwarf_tag *dtag =3D tag->priv;
+		struct dwarf_tag *dfunc;
+		dfunc =3D dwarf_cu__find_tag_by_ref(cu->priv, &dtag->abstract_origin);
+		if (dfunc =3D=3D NULL) {
+			tag__print_abstract_origin_not_found(tag);
+			return -1;
+		}
+
+		/*
+		 * Based on what I see it should be a subprogram,
+		 * but double check anyway to ensure I won't mess up
+		 * now and in the future.
+		 */
+		if (dfunc->tag->tag !=3D DW_TAG_subprogram)
+			continue;
+
+		tag->type =3D dfunc->tag->type;
+	}
+	return 0;
+}
+
 static int cu__recode_dwarf_types_table(struct cu *cu,
 					struct ptr_table *pt,
 					uint32_t i)
@@ -2637,6 +2673,16 @@ static int cus__merge_and_process_cu(struct cus *c=
us, struct conf_load *conf,
 	/* process merged cu */
 	if (cu__recode_dwarf_types(cu) !=3D LSK__KEEPIT)
 		return DWARF_CB_ABORT;
+
+	/*
+	 * for lto build, the function return type may not be
+	 * resolved due to the return type of a subprogram is
+	 * encoded in another subprogram through abstract_origin
+	 * tag. Let us visit all subprograms again to resolve this.
+	 */
+	if (cu__resolve_func_ret_types(cu) !=3D LSK__KEEPIT)
+		return DWARF_CB_ABORT;
+
 	if (finalize_cu_immediately(cus, cu, dcu, conf)
 	    =3D=3D LSK__STOP_LOADING)
 		return DWARF_CB_ABORT;
--=20
2.30.2

