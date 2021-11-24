Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA26945B0AC
	for <lists+bpf@lfdr.de>; Wed, 24 Nov 2021 01:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbhKXA06 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 23 Nov 2021 19:26:58 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S233523AbhKXA06 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Nov 2021 19:26:58 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 1ANMf7Pk020569
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:49 -0800
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ch3v52y4u-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 23 Nov 2021 16:23:49 -0800
Received: from intmgw001.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 16:23:45 -0800
Received: by devbig019.vll3.facebook.com (Postfix, from userid 137359)
        id D81A5A666AC8; Tue, 23 Nov 2021 16:23:43 -0800 (PST)
From:   Andrii Nakryiko <andrii@kernel.org>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <andrii@kernel.org>, <kernel-team@fb.com>
Subject: [PATCH bpf-next 08/13] selftests/bpf: fix possible NULL passed to memcpy() with zero size
Date:   Tue, 23 Nov 2021 16:23:20 -0800
Message-ID: <20211124002325.1737739-9-andrii@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211124002325.1737739-1-andrii@kernel.org>
References: <20211124002325.1737739-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: JfF4apstAJMKlB1lJgCg6rkqMN_f5Ex5
X-Proofpoint-GUID: JfF4apstAJMKlB1lJgCg6rkqMN_f5Ex5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-23_08,2021-11-23_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=679 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111240000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Prevent sanitizer from complaining about passing NULL into memcpy(),
even if it happens with zero size.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 1041d0c593f6..44a9868c70ea 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -881,7 +881,8 @@ void test_core_reloc(void)
 		data = mmap_data;
 
 		memset(mmap_data, 0, sizeof(*data));
-		memcpy(data->in, test_case->input, test_case->input_len);
+		if (test_case->input_len)
+			memcpy(data->in, test_case->input, test_case->input_len);
 		data->my_pid_tgid = my_pid_tgid;
 
 		link = bpf_program__attach_raw_tracepoint(prog, tp_name);
-- 
2.30.2

