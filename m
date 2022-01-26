Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 825DE49C274
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 05:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiAZEGJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 23:06:09 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57342 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237507AbiAZEGD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jan 2022 23:06:03 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20Q16aqJ002594
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:06:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=JpffoWym74+MgQN0qpr5StbYuzgcbdK3sP2KWVIQ3ew=;
 b=bBemxczCmMMWuRKBacBxCEQZbNG19H6LIPJey9YnUZlBD9mBSl3SHslFeW0AX87izAWE
 J8tzmI3K+cBNxtiH+Qnngn56LZLucF9PwSCe9RqF6V5EMTmxiTP4R2ZT2k2izcI1rCQd
 86BSIbvlF8DIbCwD/s2feSzgHB0PFaBh/2I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dtvberk96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 20:06:01 -0800
Received: from twshared7460.02.ash7.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 25 Jan 2022 20:06:00 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id C773C2C1E059; Tue, 25 Jan 2022 20:05:51 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v3 0/4] Parallelize BTF type info generating of pahole
Date:   Tue, 25 Jan 2022 20:05:05 -0800
Message-ID: <20220126040509.1862767-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1Sqa4oMptToCkKMuSqHAA2CrSiQdZqAP
X-Proofpoint-ORIG-GUID: 1Sqa4oMptToCkKMuSqHAA2CrSiQdZqAP
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_01,2022-01-25_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=610 impostorscore=0 clxscore=1015
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2201260019
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Creating an instance of btf for each worker thread allows
steal-function provided by pahole to add type info on multiple threads
without a lock.  The main thread merges the results of worker threads
to the primary instance.

Copying data from per-thread btf instances to the primary instance is
expensive now.  However, there is a patch landed at the bpf-next
repository. [1] With the patch for bpf-next and this patch, they drop
total runtime to 5.4s from 6.0s with "-j4" on my device to generate
BTF for Linux.

V3 includes following changes.

 - Merge types collected by workers threads at thread_exit and
   simplify the code creating btf_encoder.

 - Update libbpf and fix uses of deprecated APIs.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3Dd81283d27266
[v1] https://lore.kernel.org/dwarves/20220120010817.2803482-1-kuifeng@fb.co=
m/
[v2] https://lore.kernel.org/dwarves/20220124191858.1601255-1-kuifeng@fb.co=
m/

Kui-Feng Lee (4):
  dwarf_loader: Receive per-thread data on worker threads.
  dwarf_loader: Prepare and pass per-thread data to worker threads.
  pahole: Use per-thread btf instances to avoid mutex locking.
  libbpf: Update libbpf to a new revision.

 btf_encoder.c  |  25 ++++++----
 btf_encoder.h  |   2 +
 btf_loader.c   |   4 +-
 ctf_loader.c   |   2 +-
 dwarf_loader.c |  58 +++++++++++++++++------
 dwarves.h      |   9 +++-
 lib/bpf        |   2 +-
 pahole.c       | 124 +++++++++++++++++++++++++++++++++++++++++++++----
 pdwtags.c      |   3 +-
 pfunct.c       |   4 +-
 10 files changed, 193 insertions(+), 40 deletions(-)

--=20
2.30.2

