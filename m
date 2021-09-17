Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB08141017B
	for <lists+bpf@lfdr.de>; Sat, 18 Sep 2021 00:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhIQWts (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Sep 2021 18:49:48 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44432 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236208AbhIQWts (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Sep 2021 18:49:48 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18HJOYYi021538
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 15:48:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=+YXihBOMhiSG+piFiJGD8LrHHDzlghSOhQNudXvTfQA=;
 b=mfSp63QvOV8DHKTM43D7BuMQIswZ9lkP6SM47iOMjoQdGFNV9ZpH9mq0IMWQ7o4TGhSF
 P+RmLlxH5O+pNRe9PZPkxPXNvu/GY+pt5hzS9+POxguZZtw1nlcYYRd+GHI2NZLdd2J1
 Oqi/gXGgX7wEnzNXLUFYYi8hdLGbVhUJ1BQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3b4rrnmu1d-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 17 Sep 2021 15:48:25 -0700
Received: from intmgw001.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 17 Sep 2021 15:48:24 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id B823E75B5A17; Fri, 17 Sep 2021 15:48:18 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH dwarves] libbpf: Get latest libbpf
Date:   Fri, 17 Sep 2021 15:48:18 -0700
Message-ID: <20210917224818.733897-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: GgLQGlSP-2HEaCsooK9py8IXBbfqAf-r
X-Proofpoint-GUID: GgLQGlSP-2HEaCsooK9py8IXBbfqAf-r
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-17_09,2021-09-17_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxlogscore=905 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109170135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Latest upstream LLVM now supports to emit btf_tag to
dwarf ([1]) and the kernel support for btf_tag is also
landed ([2]). Sync with latest libbpf which has
btf_tag support. Next step will be to implement
dwarf -> btf conversion for btf_tag.

 [1] https://reviews.llvm.org/D106621
 [2] https://lore.kernel.org/bpf/20210914223015.245546-1-yhs@fb.com

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index 986962f..980777c 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
+Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
--=20
2.30.2

