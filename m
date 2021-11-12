Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F6944ED46
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 20:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhKLTcG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Nov 2021 14:32:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:64290 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhKLTcG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Nov 2021 14:32:06 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ACJSmqG016367
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:29:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=jNf1dNKFhLMvuyBHeXb1PdRLKoOl78cCq3lFBrUpdk0=;
 b=KImUxQMP0kqZdOpYrWe/IrXmGtDxDw/303bk7y74k3rzyOL0g4+xdhvNQNnDNNcjbqlN
 M0ZCIbiaRv5Ba6+aedOfOz5wuJEkUe9QOJgwwgL7lKKNTB4ohm+DQNGywZqrTOU91gH1
 r8M6TuZci6uFDjov0Xq+KSyrwyeWjfYuhGg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3c9x54r3vf-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 12 Nov 2021 11:29:14 -0800
Received: from intmgw001.37.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 12 Nov 2021 11:25:46 -0800
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id B83C16C83833; Fri, 12 Nov 2021 11:25:39 -0800 (PST)
From:   Yucong Sun <fallentree@fb.com>
To:     <bpf@vger.kernel.org>
CC:     <andrii@kernel.org>, <fallentree@fb.com>
Subject: [PATCH bpf-next 0/4] selftests/bpf: improve test_progs
Date:   Fri, 12 Nov 2021 11:25:31 -0800
Message-ID: <20211112192535.898352-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: jXI3cUsmvZXUSP-vn0jX1e7sQE1u2I7o
X-Proofpoint-GUID: jXI3cUsmvZXUSP-vn0jX1e7sQE1u2I7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-12_05,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 spamscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0 adultscore=0
 mlxlogscore=388 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111120103
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

various improvement to test_progs, including new '--timing' feature.

Yucong Sun (4):
  selftests/bpf: Move summary line after the error logs
  selftests/bpf: variable naming fix
  selftests/bpf: mark variable as static
  selftests/bpf: Add timing to tests_progs

 tools/testing/selftests/bpf/test_progs.c | 153 +++++++++++++++++++----
 tools/testing/selftests/bpf/test_progs.h |   2 +
 2 files changed, 134 insertions(+), 21 deletions(-)

--=20
2.30.2

