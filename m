Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 157322EA00
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 03:04:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfE3BEU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 May 2019 21:04:20 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47796 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727327AbfE3BER (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 29 May 2019 21:04:17 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x4U11Y50015925
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-type; s=facebook;
 bh=Qc6r5qqbK205kAfRZhMWQlZzT641nDXavxSalgdphwI=;
 b=rlgperCZtY7GFJPWxF5MI4rH0GUB+8xMIPBrWyla8HyWn2aPyl99Lwm5p/qa8dqKUsN5
 13EBr7F3o7i2yEJ9hocG8n9F39uk72JFjAJYv47df5CSvLP2dMqYe3GRLyqf+ysnn3cM
 YZR4SfQ3nRhyuWltG/pxvFFqQtHCDHc35FY= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2st2yjre5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 29 May 2019 18:04:16 -0700
Received: from mx-out.facebook.com (2620:10d:c081:10::13) by
 mail.thefacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.1.1713.5;
 Wed, 29 May 2019 18:04:07 -0700
Received: by devvm2643.prn2.facebook.com (Postfix, from userid 111017)
        id A2B61129321DD; Wed, 29 May 2019 18:04:03 -0700 (PDT)
Smtp-Origin-Hostprefix: devvm
From:   Roman Gushchin <guro@fb.com>
Smtp-Origin-Hostname: devvm2643.prn2.facebook.com
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>
CC:     <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>,
        Roman Gushchin <guro@fb.com>
Smtp-Origin-Cluster: prn2c23
Subject: [PATCH bpf-next 0/5] bpf: bpf maps memory accounting cleanup
Date:   Wed, 29 May 2019 18:03:54 -0700
Message-ID: <20190530010359.2499670-1-guro@fb.com>
X-Mailer: git-send-email 2.17.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=885 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300006
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

During my work on memcg-based memory accounting for bpf maps
I've done some cleanups and refactorings of the existing
memlock rlimit-based code. It makes it more robust, unifies
size to pages conversion, size checks and corresponding error
codes. Also it adds coverage for cgroup local storage and
socket local storage maps.

It looks like some preliminary work on the mm side might be
required to start working on the memcg-based accounting,
so I'm sending these patches as a separate patchset.


Roman Gushchin (5):
  bpf: add memlock precharge check for cgroup_local_storage
  bpf: add memlock precharge for socket local storage
  bpf: group memory related fields in struct bpf_map_memory
  bpf: rework memlock-based memory accounting for maps
  bpf: move memory size checks to bpf_map_charge_init()

 include/linux/bpf.h           | 15 ++++--
 kernel/bpf/arraymap.c         | 18 ++++----
 kernel/bpf/cpumap.c           |  9 ++--
 kernel/bpf/devmap.c           | 14 +++---
 kernel/bpf/hashtab.c          | 14 ++----
 kernel/bpf/local_storage.c    | 13 ++++--
 kernel/bpf/lpm_trie.c         |  8 +---
 kernel/bpf/queue_stack_maps.c | 13 +++---
 kernel/bpf/reuseport_array.c  | 17 +++----
 kernel/bpf/stackmap.c         | 28 ++++++-----
 kernel/bpf/syscall.c          | 87 ++++++++++++++++++-----------------
 kernel/bpf/xskmap.c           | 10 ++--
 net/core/bpf_sk_storage.c     | 12 ++++-
 net/core/sock_map.c           |  9 +---
 14 files changed, 132 insertions(+), 135 deletions(-)

-- 
2.20.1

