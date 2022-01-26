Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41FBB49D26C
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 20:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244415AbiAZTUx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 14:20:53 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52912 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231277AbiAZTUw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Jan 2022 14:20:52 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 20QDp2Cs013835
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 11:20:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=uK7RO90UiMhWRn8dT9R+mW99z5aYEUvlpNBfMLCoWXI=;
 b=jI5uyyi3X80lsII1ce26Jpt+ISQpAHcBOdVefvY7yOs9svCD2VRqDl9eDqZTPoL+BE1j
 nbSfVAODt7i6R+WjwVSgjbWEZgOWqhGtGuXoPHx0UJpPqeGgStvIaiI7YJB2SALvgIuN
 qtMEwR7j6E5tymTPmH2rEFudb7R6TWbD5bY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net (PPS) with ESMTPS id 3dtebx2s04-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 11:20:51 -0800
Received: from twshared7634.08.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 26 Jan 2022 11:20:49 -0800
Received: by devvm1744.ftw0.facebook.com (Postfix, from userid 460691)
        id 4F40B2C7F863; Wed, 26 Jan 2022 11:20:43 -0800 (PST)
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     <dwarves@vger.kernel.org>, <arnaldo.melo@gmail.com>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <bpf@vger.kernel.org>, Kui-Feng Lee <kuifeng@fb.com>
Subject: [PATCH dwarves v4 0/4] Parallelize BTF type info generating of pahole
Date:   Wed, 26 Jan 2022 11:20:35 -0800
Message-ID: <20220126192039.2840752-1-kuifeng@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: phR9HJlcEXAObB1-JZivTK6A35ury10A
X-Proofpoint-ORIG-GUID: phR9HJlcEXAObB1-JZivTK6A35ury10A
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-26_07,2022-01-26_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 malwarescore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=952 spamscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201260115
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

V4 includes following changes.

 - Fix nits and typos.

 - Rollback to calling btf__add_btf() at the main thread to simplify
   code.  The reasons for that are additional lock making it
   complicated and doing w/o reusing btf_encoder being obvious slower.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit=
/?id=3Dd81283d27266
[v1] https://lore.kernel.org/dwarves/20220120010817.2803482-1-kuifeng@fb.co=
m/
[v2] https://lore.kernel.org/dwarves/20220124191858.1601255-1-kuifeng@fb.co=
m/
[v3] https://lore.kernel.org/dwarves/20220126040509.1862767-1-kuifeng@fb.co=
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
 dwarf_loader.c |  59 ++++++++++++++++++-----
 dwarves.h      |   9 +++-
 lib/bpf        |   2 +-
 pahole.c       | 128 +++++++++++++++++++++++++++++++++++++++++++++----
 pdwtags.c      |   3 +-
 pfunct.c       |   4 +-
 10 files changed, 198 insertions(+), 40 deletions(-)

--=20
2.30.2

