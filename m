Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6053EE5DD
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 06:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233902AbhHQEsU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Aug 2021 00:48:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29392 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234050AbhHQEsU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 17 Aug 2021 00:48:20 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17H4juik009404
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=v82S7iRsJlQ2EvLnBr+YzQVwux5gJp06g56oHxTCxVI=;
 b=MhDnAsv9Wl3ovP9l0cZPc4u3z1bbLVWdnHfdqSLRXwc6QSmY4iCfd6ML8xStwnfq3Ziy
 YpXnWkBamONJLKgwoNVX7MOKtk7jy9GkmxnqvO2oBw/q+Y/dSTQtFPtrawDXZ9/2BN6t
 +HqoT0jofE6clXSCQg7k1bC3lU0k6Rt9pV8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3afuh53ke5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 21:47:46 -0700
Received: from intmgw002.46.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 16 Aug 2021 21:47:45 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id E624C22A2416; Mon, 16 Aug 2021 21:47:36 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [PATCH v5 bpf-next 0/4] selftests/bpf: Improve the usability of test_progs
Date:   Mon, 16 Aug 2021 21:47:28 -0700
Message-ID: <20210817044732.3263066-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: 0Ies71u3BqPVXXYB35yl86VwVe_9ODG0
X-Proofpoint-GUID: 0Ies71u3BqPVXXYB35yl86VwVe_9ODG0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-17_01:2021-08-16,2021-08-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 mlxlogscore=755 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108170029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This short series adds two new "-a", "-d" switch to test_progs,
supporting exact string match, as well as '*' wildcard. It also cleans
up the output to make it possible to generate allowlist/denylist using
common cli tools.

Yucong Sun (4):
  selftests/bpf: skip loading bpf_testmod when using -l to list tests.
  selftests/bpf: correctly display subtest skip status
  selftests/bpf: also print test name in subtest status message
  selftests/bpf: Support glob matching for test selector.

 tools/testing/selftests/bpf/test_progs.c | 101 ++++++++++++++++-------
 1 file changed, 73 insertions(+), 28 deletions(-)

--=20
2.30.2

