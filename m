Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D552A8EE0
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 06:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgKFF0I convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Fri, 6 Nov 2020 00:26:08 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58640 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726125AbgKFF0I (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 6 Nov 2020 00:26:08 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A65Q6LW008311
        for <bpf@vger.kernel.org>; Thu, 5 Nov 2020 21:26:07 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34m81m75au-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2020 21:26:07 -0800
Received: from intmgw001.03.ash8.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 21:26:05 -0800
Received: by devbig012.ftw2.facebook.com (Postfix, from userid 137359)
        id D3EEE2EC8EF6; Thu,  5 Nov 2020 21:25:57 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <dwarves@vger.kernel.org>, <acme@kernel.org>, <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH dwarves 3/4] libbpf: update libbpf submodlue reference to latest master
Date:   Thu, 5 Nov 2020 21:25:48 -0800
Message-ID: <20201106052549.3782099-4-andrii@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201106052549.3782099-1-andrii@kernel.org>
References: <20201106052549.3782099-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_01:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 adultscore=0 mlxlogscore=778 lowpriorityscore=0 clxscore=1034 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 suspectscore=8
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Pull in latest libbpf changes, containing split BTF APIs.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 lib/bpf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bpf b/lib/bpf
index ff797cc905d9..5af3d86b5a2c 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit ff797cc905d9c5fe9acab92d2da127342b20f80f
+Subproject commit 5af3d86b5a2c5fecdc3ab83822d083edd32b4396
-- 
2.24.1

