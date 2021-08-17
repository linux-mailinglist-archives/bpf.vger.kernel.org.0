Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF1073EF279
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 21:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhHQTJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 15:09:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229821AbhHQTJt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 15:09:49 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HJ6aGT018474
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=ll4RYkcA+SmlPqcQZ+mjN2VP7bo2zPZlOQmZow19BZo=;
 b=HITVKDjB0ZNC30A+mrp4+OCltdp1uhL/y5gjLhyL/9kzEJVZW259/aSLrmVe/v2a9WH4
 8Sy2Ruk81eLUbI+XDohkcO24SeT2Gqq59LDjs9/cQpfFChLF2LzgDYpOnx1u+Uxfecjt
 BtNX5GzdWsMXVt/BK6+fmO5bQ9DWdHRLOlo= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3afqeya057-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 17 Aug 2021 12:09:15 -0700
Received: from intmgw002.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 17 Aug 2021 12:09:14 -0700
Received: by devbig003.ftw2.facebook.com (Postfix, from userid 128203)
        id CAFB1606B17C; Tue, 17 Aug 2021 12:09:12 -0700 (PDT)
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: fix flaky send_signal test
Date:   Tue, 17 Aug 2021 12:09:12 -0700
Message-ID: <20210817190912.3185813-1-yhs@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 2AkYMbijAWdT-DLWat4qp3w2-Zco7fXy
X-Proofpoint-GUID: 2AkYMbijAWdT-DLWat4qp3w2-Zco7fXy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_06:2021-08-17,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=600 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The bpf selftest send_signal() is flaky for its subtests trying to
send signals in softirq/nmi context. To reduce flakiness, the
signal-targetted process priority is boosted, which should minimize
preemption of that process and improve the possibility that
the underlying task in softirq/nmi context is the bpf_send_signal()
wanted task.

Patch #1 did a refactoring to use ASSERT_* instead of old CHECK macros.
Patch #2 did actual change of boosting priority.

Changelog:
  v1 -> v2:
    remove skip logic where the underlying task in interrupt context
    is not the intended one.

Yonghong Song (2):
  selftests/bpf: replace CHECK with ASSERT_* macros in send_signal.c
  selftests/bpf: fix flaky send_signal test

 .../selftests/bpf/prog_tests/send_signal.c    | 61 +++++++++++--------
 1 file changed, 36 insertions(+), 25 deletions(-)

--=20
2.30.2

