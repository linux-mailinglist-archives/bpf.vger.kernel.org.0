Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBAC470F84
	for <lists+bpf@lfdr.de>; Sat, 11 Dec 2021 01:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbhLKAkD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 19:40:03 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:61494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237517AbhLKAkC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 19:40:02 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BAMKZEH028999
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:36:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=V0l6XQFF5nZBN79EWmdFUCE8HnSXDiQKLQbTvKDazj0=;
 b=JB/Sb6hRxZ0O+2kuHX4KdmJx90icpH5vtEnFJS7itI1THM40/EjMf3c0tMhZ8ydiACIr
 A6TE7ehpZydToGOTcZKMiKm2JoQL9RixVA8seMY16TVgyiZtQYd33U+2f9T3SZ0t3D5P
 H+7tbAtVfemffuC0tldqUcQzq8vKiOqFshg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cvch2a0eu-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 16:36:26 -0800
Received: from intmgw001.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 10 Dec 2021 16:36:22 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 7FFC1F370E2; Fri, 10 Dec 2021 16:36:15 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <ast@kernel.org>
CC:     Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH v2 bpf-next 4/4] libbpf: Mark bpf_object__find_program_by_title API deprecated.
Date:   Fri, 10 Dec 2021 16:36:08 -0800
Message-ID: <20211211003608.2764928-5-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211211003608.2764928-1-kuifeng@fb.com>
References: <20211211003608.2764928-1-kuifeng@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: Y9UPRyFW9nb1X9pk3rTuTojelZfExHyt
X-Proofpoint-ORIG-GUID: Y9UPRyFW9nb1X9pk3rTuTojelZfExHyt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-10_09,2021-12-10_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=869
 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 bulkscore=0 suspectscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112110001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate this API since v0.7.  All callers should move to
bpf_object__find_program_by_name if possible, otherwise use
bpf_object__for_each_program to find a program out from a given
section.

Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
---
 tools/lib/bpf/libbpf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 4802c1e736c3..cd9dec4def41 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -187,6 +187,7 @@ struct btf;
 LIBBPF_API struct btf *bpf_object__btf(const struct bpf_object *obj);
 LIBBPF_API int bpf_object__btf_fd(const struct bpf_object *obj);
=20
+LIBBPF_DEPRECATED_SINCE(0, 7, "use bpf_object__find_program_by_name() in=
stead")
 LIBBPF_API struct bpf_program *
 bpf_object__find_program_by_title(const struct bpf_object *obj,
 				  const char *title);
--=20
2.30.2

