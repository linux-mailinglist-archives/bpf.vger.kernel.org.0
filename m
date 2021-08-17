Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295123EE1EE
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 03:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhHQBDx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 21:03:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34330 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232974AbhHQBDw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Aug 2021 21:03:52 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H13KKl032531
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 18:03:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=+Udh3zFIRRPbJ55f7QBvetrSxxtKstFIyfhFPYdJ8wc=;
 b=j0c4UX+MNi0TqOzb8yEutyDqKxVG3Tp02215zmFORTj7owgcjqsx3/kGYRg9O/6hHuBf
 RS8liq4oRuIDuU2rcdkiXcsYyJ/g0C1STpqD+Rc35jwYCrq1U5tzp/U5fE3skLRdxcld
 X0xnESbBxqv1l7vTLtwxeoxcbS3rziOA04o= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3afrcbmcd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 18:03:20 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 18:03:18 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 5156322890B9; Mon, 16 Aug 2021 18:03:12 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v4 bpf-next 0/4] selftests/bpf: Improve the usability of
Date:   Mon, 16 Aug 2021 18:03:06 -0700
Message-ID: <20210817010310.2300741-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: QtVdUE-kYoY9fSzwWDNZ7h3_kVp-OzOy
X-Proofpoint-ORIG-GUID: QtVdUE-kYoY9fSzwWDNZ7h3_kVp-OzOy
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-16_09:2021-08-16,2021-08-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=771
 suspectscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170005
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This short series adds two new "-a", "-d" switch to test_progs,
supporting exact string match, as well as '*' wildchar. It also cleans
up the output to make it possible to generate allowlist/denylist using
grep.

Yucong Sun (4):
  selftests/bpf: skip loading bpf_testmod when using -l to list tests.
  selftests/bpf: correctly display subtest skip status
  selftests/bpf: also print test name in subtest status message
  selftests/bpf: Support glob matching for test selector.

 tools/testing/selftests/bpf/test_progs.c | 93 ++++++++++++++++++------
 tools/testing/selftests/bpf/test_progs.h |  1 +
 2 files changed, 72 insertions(+), 22 deletions(-)

--=20
2.30.2

