Return-Path: <bpf+bounces-7527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 797AF7789B1
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 11:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B85A1C21320
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 09:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB85691;
	Fri, 11 Aug 2023 09:28:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B191869;
	Fri, 11 Aug 2023 09:28:14 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E682D7B;
	Fri, 11 Aug 2023 02:28:12 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RMdfb1VqBzcdSR;
	Fri, 11 Aug 2023 17:24:39 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 17:28:09 +0800
From: Liu Jian <liujian56@huawei.com>
To: <john.fastabend@gmail.com>, <jakub@cloudflare.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
	<sdf@google.com>, <haoluo@google.com>, <jolsa@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>
CC: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <liujian56@huawei.com>
Subject: [PATCH bpf-next v2 0/7] add BPF_F_PERMANENTLY flag for sockmap skmsg redirect
Date: Fri, 11 Aug 2023 17:32:30 +0800
Message-ID: <20230811093237.3024459-1-liujian56@huawei.com>
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
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

v1->v2: fix one UAF issue, and add some tests.

patch1: Add new BPF_F_PERMANENTLY flag for bpf_msg_redirect_map/bpf_msg_redirect_hash
patch2-patch7: Added some normal and abnormal use cases.

Liu Jian (7):
  bpf, sockmap: add BPF_F_PERMANENTLY flag for skmsg redirect
  selftests/bpf: Add txmsg ingress permanently test for sockmap
  selftests/bpf: Add txmsg redir permanently test for sockmap
  selftests/bpf: add skmsg verdict tests
  selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENTLY flag
  selftests/bpf: add tests for verdict skmsg to itself
  selftests/bpf: add tests for verdict skmsg to closed socket

 include/linux/skmsg.h                         |   1 +
 include/uapi/linux/bpf.h                      |   7 +-
 net/core/skmsg.c                              |   1 +
 net/core/sock_map.c                           |   4 +-
 net/ipv4/tcp_bpf.c                            |  21 ++-
 tools/include/uapi/linux/bpf.h                |   7 +-
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_kern.h   |   4 +-
 .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
 tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
 10 files changed, 217 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c

-- 
2.34.1


