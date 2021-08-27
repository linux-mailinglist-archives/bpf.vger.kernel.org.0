Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6A43FA1BD
	for <lists+bpf@lfdr.de>; Sat, 28 Aug 2021 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbhH0XOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Aug 2021 19:14:05 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:18672 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232392AbhH0XOF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Aug 2021 19:14:05 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17RN8sKA013985
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 16:13:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=8aj5pTvvkTqBwH+sZwrilAXQT4LsEGNEwGm6/PhWkuk=;
 b=Ch38oO6sNduqb1rMio2iet+9/HBH0e/10jQL8hSC/+wGBBOYI7b5VLFPWGcCNK9wb59T
 EOJk/7yoLcwHycU3amyyBnVqyLXf8XHNxClGrj7B2/MMo4SL+TnMF+Mjx9xkUpGbzOSh
 NIuR6rMpIp03jlAEprCvJQx06/6FM0ajcLc= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3apmvtq4vc-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 27 Aug 2021 16:13:15 -0700
Received: from intmgw002.48.prn1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 27 Aug 2021 16:13:14 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id 271752B99AFB; Fri, 27 Aug 2021 16:13:08 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <sunyucong@gmail.com>, <bpf@vger.kernel.org>,
        Yucong Sun <fallentree@fb.com>
Subject: [RFC 0/1] add parallelism to test_progs
Date:   Fri, 27 Aug 2021 16:13:06 -0700
Message-ID: <20210827231307.3787723-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: vT5sXKLGn2FWDKJdKDR4AEj37liYarw1
X-Proofpoint-GUID: vT5sXKLGn2FWDKJdKDR4AEj37liYarw1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-27_07:2021-08-27,2021-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 clxscore=1015 mlxlogscore=482 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108270138
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch added a optional "-p" to test_progs to run tests in multiple
process, speeding up the tests.

Example:

time ./test_progs
real    5m51.393s
user    0m4.695s
sys    5m48.055s

time ./test_progs -p 16 (on a 8 core vm)
real    3m45.673s
user    0m4.434s
sys    5m47.465s

The feedback area I'm looking for :

  1.Some tests are taking too long to run (for example:
  bpf_verif_scale/pyperf* takes almost 80% of the total runtime). If we
  need a work-stealing pool mechanism it would be a bigger change.

  2. The tests output from workers are currently interleaved from all
  workers, making it harder to read, one option would be redirect all
  outputs onto pipes and have main process collect and print in sequence
  for each worker finish, but that will make seeing real time progress
  harder.

  3. If main process want to collect tests results from worker, I plan
  to have each worker writes a stats file to /tmp, or I can use IPC, any
  preference?

  4. Some tests would fail if run in parallel, I think we would need to
  pin some tasks onto worker 0.

Yucong Sun (1):
  selftests/bpf: Add parallelism to test_progs

 tools/testing/selftests/bpf/test_progs.c | 94 ++++++++++++++++++++++--
 tools/testing/selftests/bpf/test_progs.h |  3 +
 2 files changed, 91 insertions(+), 6 deletions(-)

--=20
2.30.2

