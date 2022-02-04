Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EBE4AA27E
	for <lists+bpf@lfdr.de>; Fri,  4 Feb 2022 22:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiBDVoI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Feb 2022 16:44:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43568 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236194AbiBDVoH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Feb 2022 16:44:07 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 214JliCu026316
        for <bpf@vger.kernel.org>; Fri, 4 Feb 2022 13:44:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=mIZyl4F0hjIrFz9KJ2kE3xhOpLeDt+Twz17ojYoeNMg=;
 b=Wg6GVqqb++hCqNECMCbD+D58MywW+wpSdTFG0Btk9Ygij5FvY5jV0BSTaiof8aGOpCM3
 erc3EDbvxFjzoW1SW2sXqEXdrtTeiWZJD/nLOBu87j8vpV1M2JlAe+jEf2RTRon4CCcS
 L+m26+HJsqIPSramcctw6ViHo+b9a6JLkm4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e0puaf6jg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 04 Feb 2022 13:44:07 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 13:44:06 -0800
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
        id 1BAEC5FA84E4; Fri,  4 Feb 2022 13:43:55 -0800 (PST)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Delyan Kratunov <delyank@fb.com>
Subject: [PATCH bpf-next v2] libbpf: fix build issue with llvm-readelf
Date:   Fri, 4 Feb 2022 13:43:55 -0800
Message-ID: <20220204214355.502108-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ceZrmSzrDoEyVOms4i7ZVsydwOlC6ReL
X-Proofpoint-GUID: ceZrmSzrDoEyVOms4i7ZVsydwOlC6ReL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-04_07,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0 mlxlogscore=952
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202040120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There are cases where clang compiler is packaged in a way
readelf is a symbolic link to llvm-readelf. In such cases,
llvm-readelf will be used instead of default binutils readelf,
and the following error will appear during libbpf build:

  Warning: Num of global symbols in
   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf=
/sharedobjs/libbpf-in.o (367)
   does NOT match with num of versioned symbols in
   /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/libbpf=
/libbpf.so libbpf.map (383).
   Please make sure all LIBBPF_API symbols are versioned in libbpf.map.
  --- /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/lib=
bpf/libbpf_global_syms.tmp ...
  +++ /home/yhs/work/bpf-next/tools/testing/selftests/bpf/tools/build/lib=
bpf/libbpf_versioned_syms.tmp ...
  @@ -324,6 +324,22 @@
   btf__str_by_offset
   btf__type_by_id
   btf__type_cnt
  +LIBBPF_0.0.1
  +LIBBPF_0.0.2
  +LIBBPF_0.0.3
  +LIBBPF_0.0.4
  +LIBBPF_0.0.5
  +LIBBPF_0.0.6
  +LIBBPF_0.0.7
  +LIBBPF_0.0.8
  +LIBBPF_0.0.9
  +LIBBPF_0.1.0
  +LIBBPF_0.2.0
  +LIBBPF_0.3.0
  +LIBBPF_0.4.0
  +LIBBPF_0.5.0
  +LIBBPF_0.6.0
  +LIBBPF_0.7.0
   libbpf_attach_type_by_name
   libbpf_find_kernel_btf
   libbpf_find_vmlinux_btf_id
  make[2]: *** [Makefile:184: check_abi] Error 1
  make[1]: *** [Makefile:140: all] Error 2

The above failure is due to different printouts for some ABS
versioned symbols. For example, with the same libbpf.so,
  $ /bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | grep "LIBBPF=
" | grep ABS
     134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.5.0
     202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LIBBPF_0.6.0
     ...
  $ /opt/llvm/bin/readelf --dyn-syms --wide tools/lib/bpf/libbpf.so | gre=
p "LIBBPF" | grep ABS
     134: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.5.=
0@@LIBBPF_0.5.0
     202: 0000000000000000     0 OBJECT  GLOBAL DEFAULT   ABS LIBBPF_0.6.=
0@@LIBBPF_0.6.0
     ...
The binutils readelf doesn't print out the symbol LIBBPF_* version and ll=
vm-readelf does.
Such a difference caused libbpf build failure with llvm-readelf.

The proposed fix filters out all ABS symbols as they are not part of the =
comparison.
This works for both binutils readelf and llvm-readelf.

Reported-by: Delyan Kratunov <delyank@fb.com>
Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index f947b61b2107..b8b37fe76006 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -131,7 +131,7 @@ GLOBAL_SYM_COUNT =3D $(shell readelf -s --wide $(BPF_=
IN_SHARED) | \
 			   sort -u | wc -l)
 VERSIONED_SYM_COUNT =3D $(shell readelf --dyn-syms --wide $(OUTPUT)libbp=
f.so | \
 			      sed 's/\[.*\]//' | \
-			      awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}' | \
+			      awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}' | \
 			      grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 | sort -u | wc -l)
=20
 CMD_TARGETS =3D $(LIB_TARGET) $(PC_FILE)
@@ -194,7 +194,7 @@ check_abi: $(OUTPUT)libbpf.so $(VERSION_SCRIPT)
 		    sort -u > $(OUTPUT)libbpf_global_syms.tmp;		 \
 		readelf --dyn-syms --wide $(OUTPUT)libbpf.so |		 \
 		    sed 's/\[.*\]//' |					 \
-		    awk '/GLOBAL/ && /DEFAULT/ && !/UND/ {print $$NF}'|  \
+		    awk '/GLOBAL/ && /DEFAULT/ && !/UND|ABS/ {print $$NF}'|  \
 		    grep -Eo '[^ ]+@LIBBPF_' | cut -d@ -f1 |		 \
 		    sort -u > $(OUTPUT)libbpf_versioned_syms.tmp; 	 \
 		diff -u $(OUTPUT)libbpf_global_syms.tmp			 \
--=20
2.30.2

