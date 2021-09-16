Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C253F40D207
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 05:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbhIPD2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 23:28:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:12686 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbhIPD2O (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 23:28:14 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM43m9000649
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=Di7zKwhVfDDdb5rs8d2Yby0rh32ReJX8CbgLXeN0CCI=;
 b=MIuarcXroKNU748GvJdzPaI8TnVzgMqWBUadrzwbr5QAIWlaqxqjhaNMCsCVDOk/mex5
 saKweIDpSgITZmB3X24US29sUA38yXKzke9o14Hlw988/o4mk+lH3Zj2e0usqtgGYhie
 DH0RSks+09XCG5JEPUIwxs0GITezpSCizGg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3kv0ky1e-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 20:26:53 -0700
Received: from intmgw003.48.prn1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 20:26:51 -0700
Received: by devvm2661.vll0.facebook.com (Postfix, from userid 200310)
        id C54043A34AFE; Wed, 15 Sep 2021 20:26:42 -0700 (PDT)
From:   Yucong Sun <fallentree@fb.com>
To:     <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <fallentree@fb.com>
Subject: [PATCH v5 bpf-next 0/3] selftests/bpf: Add parallelism to test_progs
Date:   Wed, 15 Sep 2021 20:26:38 -0700
Message-ID: <20210916032641.1413293-1-fallentree@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: giZuOtMcZcR0yVgNVblTVJ_wayeqUuKk
X-Proofpoint-GUID: giZuOtMcZcR0yVgNVblTVJ_wayeqUuKk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=735
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series adds "-j" parelell execution to test_progs, with
"--debug" to display server/worker communications.

V5 -> V4:=20
  * change to SOCK_SEQPACKET for close notification.=20
  * move all debug output to "--debug" mode
  * output log as test finish, and all error logs again after summary lin=
e.
  * variable naming / style changes
  * adds serial_test_name() to replace serial test lists.

Yucong Sun (3):
  selftests/bpf: Add parallelism to test_progs
  selftests/bpf: add per worker cgroup suffix
  selftests/bpf: pin some tests to worker 0

 tools/testing/selftests/bpf/cgroup_helpers.c  |   5 +-
 tools/testing/selftests/bpf/cgroup_helpers.h  |   1 +
 .../selftests/bpf/prog_tests/bpf_obj_id.c     |   2 +-
 .../bpf/prog_tests/select_reuseport.c         |   2 +-
 .../testing/selftests/bpf/prog_tests/timer.c  |   2 +-
 .../selftests/bpf/prog_tests/xdp_bonding.c    |   2 +-
 .../selftests/bpf/prog_tests/xdp_link.c       |   2 +-
 tools/testing/selftests/bpf/test_progs.c      | 658 +++++++++++++++++-
 tools/testing/selftests/bpf/test_progs.h      |  36 +-
 9 files changed, 667 insertions(+), 43 deletions(-)

--=20
2.30.2

