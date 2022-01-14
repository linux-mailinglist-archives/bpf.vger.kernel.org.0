Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6C048E1BC
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 01:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiANAtT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 19:49:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:22938 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238527AbiANAtT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 19:49:19 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DN7C5f026185
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=AE5AYS7TYVWXWUx2j1JgjBiqe6Rfoqcg8Dq9/iFbchg=;
 b=n3pTAHh48K3B6HV96g5C0xBwAdM50Ooz/sjr4JgZMwBS/tA15IJ3bZ7kjNGSAjnanYH+
 sh1KoU2tIj7X49JND0qxA41umLSYiDUTDOOK1pxxY4zTNvDSA0qjyFoKh0Do/am56gFs
 KK9BinrBssaT6+vza7mqIdYMoeIccVArbk8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djh92w0q2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 16:49:19 -0800
Received: from twshared13833.42.prn1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 16:49:18 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id 3C3CD8FA31C4; Thu, 13 Jan 2022 16:49:11 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <bpf@vger.kernel.org>, <ast@kernel.org>, <andrii@kernel.org>,
        <daniel@iogearbox.net>, <yhs@fb.com>
CC:     Kenny Yu <kennyyu@fb.com>
Subject: [PATCH v2 bpf-next 0/4] Add bpf_access_process_vm helper and sleepable bpf iterator programs
Date:   Thu, 13 Jan 2022 16:48:56 -0800
Message-ID: <20220114004900.3756025-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220113233158.1582743-1-kennyyu@fb.com>
References: <20220113233158.1582743-1-kennyyu@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UxegXj4G7O6hjHN7WjT5LLKYcAPsx4Kh
X-Proofpoint-GUID: UxegXj4G7O6hjHN7WjT5LLKYcAPsx4Kh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=721 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201140002
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch series makes the following changes:
* Adds a new bpf helper `bpf_access_process_vm` to read user space
  memory from a different task.
* Adds the ability to create sleepable bpf iterator programs.

As an example of how this will be used, at Meta we are using bpf task ite=
rator
programs and this new bpf helper to read C++ async stack traces of a runn=
ing
process for debugging C++ binaries in production.

Changes since v1:
* Fixed "Invalid wait context" issue in `bpf_iter_run_prog` by using
  `rcu_read_lock_trace()` for sleepable bpf iterator programs.

Kenny Yu (4):
  bpf: Add bpf_access_process_vm() helper
  bpf: Add support for sleepable programs in bpf_iter_run_prog
  libbpf: Add "iter.s" section for sleepable bpf iterator programs
  selftests/bpf: Add test for sleepable bpf iterator programs

 include/linux/bpf.h                           |  1 +
 include/uapi/linux/bpf.h                      | 10 ++++
 kernel/bpf/bpf_iter.c                         | 16 ++++--
 kernel/bpf/helpers.c                          | 19 +++++++
 kernel/trace/bpf_trace.c                      |  2 +
 tools/include/uapi/linux/bpf.h                | 10 ++++
 tools/lib/bpf/libbpf.c                        |  1 +
 .../selftests/bpf/prog_tests/bpf_iter.c       | 16 ++++++
 .../selftests/bpf/progs/bpf_iter_task.c       | 54 +++++++++++++++++++
 9 files changed, 126 insertions(+), 3 deletions(-)

--=20
2.30.2

