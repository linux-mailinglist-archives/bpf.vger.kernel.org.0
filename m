Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B20F25C15
	for <lists+bpf@lfdr.de>; Wed, 22 May 2019 05:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfEVDRK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 21 May 2019 23:17:10 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59818 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728031AbfEVDRJ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 May 2019 23:17:09 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4M3H2EJ026981
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 20:17:09 -0700
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 2smcnpuj8f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 21 May 2019 20:17:09 -0700
Received: from mx-out.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 21 May 2019 20:17:08 -0700
Received: by devbig007.ftw2.facebook.com (Postfix, from userid 572438)
        id 820B4760CB3; Tue, 21 May 2019 20:17:07 -0700 (PDT)
Smtp-Origin-Hostprefix: devbig
From:   Alexei Starovoitov <ast@kernel.org>
Smtp-Origin-Hostname: devbig007.ftw2.facebook.com
To:     <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <netdev@vger.kernel.org>,
        <bpf@vger.kernel.org>, <kernel-team@fb.com>
Smtp-Origin-Cluster: ftw2c04
Subject: [PATCH v2 bpf-next 0/3] bpf: optimize explored_states
Date:   Tue, 21 May 2019 20:17:04 -0700
Message-ID: <20190522031707.2834254-1-ast@kernel.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-22_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=26 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=26
 clxscore=1015 lowpriorityscore=0 mlxscore=26 impostorscore=0
 mlxlogscore=45 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905220021
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Convert explored_states array into hash table and use simple hash to
reduce verifier peak memory consumption for programs with bpf2bpf calls.
More details in patch 3.

v1->v2: fixed Jakub's small nit in patch 1

Alexei Starovoitov (3):
  bpf: cleanup explored_states
  bpf: split explored_states
  bpf: convert explored_states to hash table

 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/verifier.c        | 77 ++++++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 29 deletions(-)

-- 
2.20.0

