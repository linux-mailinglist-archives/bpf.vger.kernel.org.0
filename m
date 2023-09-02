Return-Path: <bpf+bounces-9138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47504790738
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 12:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1538D1C20927
	for <lists+bpf@lfdr.de>; Sat,  2 Sep 2023 10:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE743D8B;
	Sat,  2 Sep 2023 10:04:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4DE2F46;
	Sat,  2 Sep 2023 10:04:16 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 892DB10EB;
	Sat,  2 Sep 2023 03:04:14 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Rd9Ps2tkTzNn4n;
	Sat,  2 Sep 2023 18:00:33 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Sat, 2 Sep
 2023 18:04:11 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v4 0/7] add BPF_F_PERMANENT flag for sockmap skmsg redirect
Date: Sat, 2 Sep 2023 18:07:37 +0800
Message-ID: <20230902100744.2687785-1-liujian56@huawei.com>
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
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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
 net/ipv4/tcp_bpf.c                            |  15 ++-
 tools/include/uapi/linux/bpf.h                |  45 +++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
 .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
 tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
 10 files changed, 275 insertions(+), 32 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c

-- 
2.34.1


