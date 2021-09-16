Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F47D40D17C
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 03:58:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbhIPCAO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Wed, 15 Sep 2021 22:00:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:63046 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233565AbhIPCAN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 22:00:13 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18FM3pjb005875
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:53 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 3b36fg01y3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 18:58:53 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 18:58:52 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id 287F3422A281; Wed, 15 Sep 2021 18:58:45 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 3/7] libbpf: deprecated bpf_object_open_opts.relaxed_core_relocs
Date:   Wed, 15 Sep 2021 18:58:32 -0700
Message-ID: <20210916015836.1248906-4-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916015836.1248906-1-andrii@kernel.org>
References: <20210916015836.1248906-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: OayOR1LjF7eFsBu_YDLqkw8IfkjiSEYJ
X-Proofpoint-GUID: OayOR1LjF7eFsBu_YDLqkw8IfkjiSEYJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=947
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109160010
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's relevant and hasn't been doing anything for a long while now.
Deprecated it.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 2f6f0e15d1e7..7111e8d651de 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -83,6 +83,7 @@ struct bpf_object_open_opts {
 	 * Non-relocatable instructions are replaced with invalid ones to
 	 * prevent accidental errors.
 	 * */
+	LIBBPF_DEPRECATED_SINCE(0, 6, "field has no effect")
 	bool relaxed_core_relocs;
 	/* maps that set the 'pinning' attribute in their definition will have
 	 * their pin_path attribute set to a file in this directory, and be
-- 
2.30.2

