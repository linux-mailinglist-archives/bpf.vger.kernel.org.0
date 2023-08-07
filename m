Return-Path: <bpf+bounces-7104-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7CE7717B8
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 03:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D111C2074C
	for <lists+bpf@lfdr.de>; Mon,  7 Aug 2023 01:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBB365C;
	Mon,  7 Aug 2023 01:21:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81042392;
	Mon,  7 Aug 2023 01:21:16 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C661712;
	Sun,  6 Aug 2023 18:21:14 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RJz3P1Lnmz1Z1XF;
	Mon,  7 Aug 2023 09:18:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 09:21:12 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 0/5] team: do some cleanups in team driver
Date: Mon, 7 Aug 2023 09:25:51 +0800
Message-ID: <20230807012556.3146071-1-shaozhengchao@huawei.com>
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
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Do some cleanups in team driver.

---
v3: add header file back to team_mode_activebackup.c
v2: combine patch 5/6 and patch 6/6 into patch 5/5
---
Zhengchao Shao (5):
  team: add __exit modifier to team_nl_fini()
  team: remove unreferenced header in broadcast and roundrobin files
  team: change the init function in the team_option structure to void
  team: change the getter function in the team_option structure to void
  team: remove unused input parameters in lb_htpm_select_tx_port and
    lb_hash_select_tx_port

 drivers/net/team/team.c                   | 62 +++++++++--------------
 drivers/net/team/team_mode_activebackup.c |  8 ++-
 drivers/net/team/team_mode_broadcast.c    |  1 -
 drivers/net/team/team_mode_loadbalance.c  | 50 +++++++-----------
 drivers/net/team/team_mode_roundrobin.c   |  1 -
 include/linux/if_team.h                   |  4 +-
 6 files changed, 48 insertions(+), 78 deletions(-)

-- 
2.34.1


