Return-Path: <bpf+bounces-4215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6C347498F1
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C4628119D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702928474;
	Thu,  6 Jul 2023 10:03:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373727483;
	Thu,  6 Jul 2023 10:03:35 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69C0E3;
	Thu,  6 Jul 2023 03:03:33 -0700 (PDT)
Received: from dggpeml500010.china.huawei.com (unknown [172.30.72.54])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4QxX9V0bgpzPjtb;
	Thu,  6 Jul 2023 18:01:18 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500010.china.huawei.com
 (7.185.36.155) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 18:03:30 +0800
From: Xin Liu <liuxin350@huawei.com>
To: <daniel@iogearbox.net>
CC: <andrii@kernel.org>, <ast@kernel.org>, <bpf@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <hsinweih@uci.edu>,
	<jakub@cloudflare.com>, <john.fastabend@gmail.com>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <liuxin350@huawei.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzbot+49f6cef45247ff249498@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <yanan@huawei.com>,
	<wuchangye@huawei.com>, <xiesongyang@huawei.com>, <kongweibin2@huawei.com>,
	<zhangmingyi5@huawei.com>
Subject: [PATCH bpf-next] bpf, sockops: Enhance the return capability of sockops
Date: Thu, 6 Jul 2023 18:02:43 +0800
Message-ID: <20230706100243.318109-1-liuxin350@huawei.com>
X-Mailer: git-send-email 2.33.0
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
 dggpeml500010.china.huawei.com (7.185.36.155)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since commit 2585cd62f098 ("bpf: Only reply field should be writeable"),
sockops is not allowd to modify the replylong field except replylong[0].
The reason is that the replylong[1] to replylong[3] field is not used
at that time.

But in actual use, we can call `BPF_CGROUP_RUN_PROG_SOCK_OPS` in the
kernel modules and expect sockops to return some useful data.

The design comment about bpf_sock_ops::replylong in 
include/uapi/linux/bpf.h is described as follows:

```
  struct bpf_sock_ops {
	__u32 op;
	union {
		__u32 args[4];		/* Optionally passed to bpf program */
		__u32 reply;		/* Returned by bpf program	    */
		__u32 replylong[4];	/* Optioznally returned by bpf prog  */
	};
  ...
```

It seems to contradict the purpose for which the field was originally
designed. Let's remove this restriction.

Fixes: 2585cd62f098 ("bpf: Only reply field should be writeable")

Signed-off-by: Xin Liu <liuxin350@huawei.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 06ba0e56e369..4662d2d3a0af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9063,7 +9063,7 @@ static bool sock_ops_is_valid_access(int off, int size,
 
 	if (type == BPF_WRITE) {
 		switch (off) {
-		case offsetof(struct bpf_sock_ops, reply):
+		case bpf_ctx_range_till(struct bpf_sock_ops, reply, replylong[3]):
 		case offsetof(struct bpf_sock_ops, sk_txhash):
 			if (size != size_default)
 				return false;
-- 
2.33.0


