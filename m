Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA63617DF
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 04:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234764AbhDPC43 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 22:56:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234751AbhDPC42 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 22:56:28 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13G2u3k9022581
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=/HQDKDIA6UrFnwz9f+xViGI8k+8rQoct3P/53SF74GQ=;
 b=WMHrqUwPQwV1XT/OgeBAFX2SNGSt/UJjCF38S1GBH7BhzLNMTapmvH4OqPJlvasiJgFm
 +YD8yBcNovmYgXGWT6pxbeME+9bMoKlbAbJBQY78nVNWeyTQcOHX7gZfPY5WhdRvulAw
 S9vcjzFMsUtpiHH7hCskqqlWRhHOk+P4frY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37xr303g0c-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 15 Apr 2021 19:56:04 -0700
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 19:55:59 -0700
Received: by devbig030.frc3.facebook.com (Postfix, from userid 158236)
        id 8F5B4A2A600; Thu, 15 Apr 2021 19:55:58 -0700 (PDT)
From:   Dave Marchevsky <davemarchevsky@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: [PATCH bpf-next 0/3] bpf: refine retval for bpf_get_task_stack helper
Date:   Thu, 15 Apr 2021 19:55:34 -0700
Message-ID: <20210416025537.2352753-1-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mL9bdAuXskaEMgUogQodkWEza3RLKUis
X-Proofpoint-GUID: mL9bdAuXskaEMgUogQodkWEza3RLKUis
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 mlxlogscore=821 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160023
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similarly to the bpf_get_stack helper, bpf_get_task_stack's return value
can be more tightly bound by the verifier - it's the number of bytes
written to a user-supplied buffer, or a negative error value. Currently
the verifier believes bpf_task_get_stack's retval bounds to be unknown,
requiring extraneous bounds checking to remedy.

Adding it to do_refine_retval_range fixes the issue, as evidenced by
new selftests which fail to load if retval bounds are not refined.

Dave Marchevsky (3):
  bpf: refine retval for bpf_get_task_stack helper
  bpf/selftests: add bpf_get_task_stack retval bounds verifier test
  bpf/selftests: add bpf_get_task_stack retval bounds test_prog

 kernel/bpf/verifier.c                         |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       |  1 +
 .../selftests/bpf/progs/bpf_iter_task_stack.c | 22 ++++++++++
 .../selftests/bpf/verifier/bpf_get_stack.c    | 43 +++++++++++++++++++
 4 files changed, 67 insertions(+)

--=20
2.30.2

