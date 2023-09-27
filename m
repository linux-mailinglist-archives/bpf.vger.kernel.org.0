Return-Path: <bpf+bounces-10950-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A777B0006
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id ABE14281CCE
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC28023740;
	Wed, 27 Sep 2023 09:27:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47821356;
	Wed, 27 Sep 2023 09:27:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7971212A;
	Wed, 27 Sep 2023 02:27:50 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RwWPV5H60ztT71;
	Wed, 27 Sep 2023 17:23:26 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 27 Sep
 2023 17:27:47 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v5 0/7] add BPF_F_PERMANENT flag for sockmap skmsg redirect
Date: Wed, 27 Sep 2023 17:30:06 +0800
Message-ID: <20230927093013.1951659-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v4->v5: Fix one refcount bug caused by patch1.
v3->v4: Change the two helpers's description.
	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.

Liu Jian (7):
  bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
  selftests/bpf: Add txmsg permanently test for sockmap
  selftests/bpf: Add txmsg redir permanently test for sockmap
  selftests/bpf: add skmsg verdict tests
  selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
  selftests/bpf: add tests for verdict skmsg to itself
  selftests/bpf: add tests for verdict skmsg to closed socket

 include/linux/skmsg.h                         |   1 +
 include/uapi/linux/bpf.h                      |  45 +++++--
 net/core/skmsg.c                              |   6 +-
 net/core/sock_map.c                           |   4 +-
 net/ipv4/tcp_bpf.c                            |  12 +-
 tools/include/uapi/linux/bpf.h                |  45 +++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
 .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
 tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
 10 files changed, 272 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c

-- 
2.34.1


