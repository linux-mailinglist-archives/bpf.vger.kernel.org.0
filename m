Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846FF3E504D
	for <lists+bpf@lfdr.de>; Tue, 10 Aug 2021 02:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236100AbhHJARz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 9 Aug 2021 20:17:55 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236088AbhHJARz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 9 Aug 2021 20:17:55 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A0Efum027829
        for <bpf@vger.kernel.org>; Mon, 9 Aug 2021 17:17:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=0WwT5WUhlPtXq+PFY9nKiBnRu9Z1rXWjZVF8skg7KE4=;
 b=TrxdFKYHamngwtfTzyLE0ZrmsVL9pLG5tvtwwEuCfyuRxuxysWguPD4s7y1WJkfnKQEU
 x3OtRatMpsKcFP4Eac3IyP3vPYrVPo+CGzrh5lb5VuEbcxoHJV0Wr/1/Q42Cl+3W21Jn
 s9U4fYqmaSP7ivv7wZyVzVGBw6XMe4NA+KE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3abdp30awa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 09 Aug 2021 17:17:34 -0700
Received: from intmgw001.27.prn2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 9 Aug 2021 17:17:32 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 2CD9A1E2CB66; Mon,  9 Aug 2021 17:17:25 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <sunyucong@gmail.com>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v2 bpf-next 0/5] Improve the usability of test_progs
Date:   Mon, 9 Aug 2021 17:16:20 -0700
Message-ID: <20210810001625.1140255-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-GUID: SX4TwG92K6eJ7b-RFTFaSqqv0RFkIntL
X-Proofpoint-ORIG-GUID: SX4TwG92K6eJ7b-RFTFaSqqv0RFkIntL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-09_09:2021-08-06,2021-08-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 bulkscore=0
 mlxlogscore=700 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108100000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This short series focus on improving the usability of test_progs, making
the output cleaner, easier to select test to run, and adding a summary of
all failed the tests at the end of the output.

Yucong Sun (5):
  Skip loading bpf_testmod when using -l to list tests.
  Add glob matching for test selector in test_progs.
  Correctly display subtest skip status
  Display test number when listing test names
  Record all failed tests and output after the summary line.

 tools/testing/selftests/bpf/test_progs.c | 144 ++++++++++++++++++++---
 tools/testing/selftests/bpf/test_progs.h |   2 +
 2 files changed, 132 insertions(+), 14 deletions(-)

--=20
2.30.2

