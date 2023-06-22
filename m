Return-Path: <bpf+bounces-3112-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE33973974C
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AF4F281663
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0C25242;
	Thu, 22 Jun 2023 06:19:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019B14436
	for <bpf@vger.kernel.org>; Thu, 22 Jun 2023 06:19:36 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3941731
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:19:33 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M4fH54031920
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:19:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=f4odL6oO6LbM9MP3W2avZLAh465pNcXYZvitAYaid+0=;
 b=PzuUF2v59qh6s4FuVBLEo3+NasBhcT6rh4nwnJJgxaEr0vauNKXEoHVey5RFyMkb7jXn
 KDFa4rwvxuU60CO1fv2mAbzs1Kh9NQ/JYV3LyJsQVXgksTV0ou//sqz8fPjjPaMVbhS/
 +mYs3KRCGQaLry4oqQJvkYLILj51ytVEAcI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rc04w80w6-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Wed, 21 Jun 2023 23:19:33 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 23:19:29 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 21 Jun 2023 23:19:29 -0700
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 58C8C21B5E9A6; Wed, 21 Jun 2023 23:19:21 -0700 (PDT)
From: Yonghong Song <yhs@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        "Martin KaFai
 Lau" <martin.lau@kernel.org>
Subject: [PATCH bpf-next] selftests/bpf: Fix compilation failure for prog vrf_socket_lookup
Date: Wed, 21 Jun 2023 23:19:21 -0700
Message-ID: <20230622061921.816772-1-yhs@fb.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: cpKuyt9RU_SROhyvIHWtqgElwrMCZ_xF
X-Proofpoint-ORIG-GUID: cpKuyt9RU_SROhyvIHWtqgElwrMCZ_xF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_03,2023-06-16_01,2023-05-22_02
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When building the latest kernel/selftest with clang17 compiler,
    make LLVM=3D1 -j                                  <=3D=3D for kernel
    make -C tools/testing/selftests/bpf LLVM=3D1 -j   <=3D=3D for selftes=
t

I hit the following compilation error:
  ...
  In file included from progs/vrf_socket_lookup.c:3:
  In file included from /usr/include/linux/ip.h:21:
  In file included from /usr/include/asm/byteorder.h:5:
  In file included from /usr/include/linux/byteorder/little_endian.h:13:
  /usr/include/linux/swab.h:136:8: error: unknown type name '__always_inl=
ine'
    136 | static __always_inline unsigned long __swab(const unsigned long=
 y)
        |        ^
  /usr/include/linux/swab.h:171:8: error: unknown type name '__always_inl=
ine'
    171 | static __always_inline __u16 __swab16p(const __u16 *p)
        |        ^
  /usr/include/linux/swab.h:171:29: error: expected ';' after top level d=
eclarator
    171 | static __always_inline __u16 __swab16p(const __u16 *p)
        |                             ^
  ...

Basically, with header files in my local host which is based on 5.12 kern=
el,
__always_inline is not defined and this caused compilation failure.

Since __always_inline is defined in bpf_helpers.h, let us move bpf_helper=
s.h
to an early position which fixed the problem.

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/testing/selftests/bpf/progs/vrf_socket_lookup.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/vrf_socket_lookup.c b/tool=
s/testing/selftests/bpf/progs/vrf_socket_lookup.c
index 26e07a252585..bcfb6feb38c0 100644
--- a/tools/testing/selftests/bpf/progs/vrf_socket_lookup.c
+++ b/tools/testing/selftests/bpf/progs/vrf_socket_lookup.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+
 #include <linux/ip.h>
 #include <linux/in.h>
 #include <linux/if_ether.h>
 #include <linux/pkt_cls.h>
-#include <bpf/bpf_helpers.h>
-#include <bpf/bpf_endian.h>
 #include <stdbool.h>
=20
 int lookup_status;
--=20
2.34.1


