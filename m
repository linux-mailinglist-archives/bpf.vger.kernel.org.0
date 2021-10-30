Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3862044078B
	for <lists+bpf@lfdr.de>; Sat, 30 Oct 2021 07:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbhJ3FCh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sat, 30 Oct 2021 01:02:37 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36594 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231497AbhJ3FCg (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 30 Oct 2021 01:02:36 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19TMhdkI014137
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:07 -0700
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c0pyjk0vr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 29 Oct 2021 22:00:07 -0700
Received: from intmgw001.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 29 Oct 2021 22:00:07 -0700
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id C33917830579; Fri, 29 Oct 2021 21:59:59 -0700 (PDT)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Subject: [PATCH bpf-next 08/14] bpftool: stop using deprecated bpf_load_program()
Date:   Fri, 29 Oct 2021 21:59:35 -0700
Message-ID: <20211030045941.3514948-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211030045941.3514948-1-andrii@kernel.org>
References: <20211030045941.3514948-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 93iQyNRCDTZfkfQ8DOy_U8p0_CD_6rP5
X-Proofpoint-GUID: 93iQyNRCDTZfkfQ8DOy_U8p0_CD_6rP5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-30_01,2021-10-29_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=957
 priorityscore=1501 phishscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110300025
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Switch to bpf_prog_load() instead.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/bpf/bpftool/feature.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index ade44577688e..5397077d0d9e 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -467,7 +467,7 @@ static bool probe_bpf_syscall(const char *define_prefix)
 {
 	bool res;
 
-	bpf_load_program(BPF_PROG_TYPE_UNSPEC, NULL, 0, NULL, 0, NULL, 0);
+	bpf_prog_load(BPF_PROG_TYPE_UNSPEC, NULL, NULL, NULL, 0, NULL);
 	res = (errno != ENOSYS);
 
 	print_bool_feature("have_bpf_syscall",
-- 
2.30.2

