Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DCA9417BDA
	for <lists+bpf@lfdr.de>; Fri, 24 Sep 2021 21:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346903AbhIXTht (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Sep 2021 15:37:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54874 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345195AbhIXThs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 24 Sep 2021 15:37:48 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18OIs6aH013495
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 12:36:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=i4aGsyR/qauPLRgls/XDPtZKfLA7JQ8ifAJDJzaQf2U=;
 b=NvHB5gH4HHyAARewXOx9of/KTEjmpJ2D4/8bPz7mEA3wtPbmkswV7UtVMxLfUroXy9+/
 qIko4tKwjWTkY/tetN3v3PTcY46RxGx392jkqXDOh+NLd5iSeMfqRadEU8qAbZhPV4yi
 N6em/nHLyphT3G4PPEd/Jxz2ZnRdYK6/uuA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b9j72s6ux-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 24 Sep 2021 12:36:14 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 24 Sep 2021 12:36:11 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id C649971595BE; Fri, 24 Sep 2021 12:36:04 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, <kernel-team@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next] MAINTAINERS: add btf headers to BPF
Date:   Fri, 24 Sep 2021 12:35:57 -0700
Message-ID: <20210924193557.3081469-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: n0dDPIzyDsMSLtJp2j36R9uu74Z-DETu
X-Proofpoint-ORIG-GUID: n0dDPIzyDsMSLtJp2j36R9uu74Z-DETu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-24_05,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 mlxlogscore=784 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2109240121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF folks maintain these and they're not picked up by the current
MAINTAINERS entries.

Files caught by the added globs:
  include/linux/btf.h
  include/linux/btf_ids.h
  include/uapi/linux/btf.h

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..93396e93033e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3385,9 +3385,11 @@ F:	Documentation/networking/filter.rst
 F:	Documentation/userspace-api/ebpf/
 F:	arch/*/net/*
 F:	include/linux/bpf*
+F:	include/linux/btf*
 F:	include/linux/filter.h
 F:	include/trace/events/xdp.h
 F:	include/uapi/linux/bpf*
+F:	include/uapi/linux/btf*
 F:	include/uapi/linux/filter.h
 F:	kernel/bpf/
 F:	kernel/trace/bpf_trace.c
--=20
2.30.2

