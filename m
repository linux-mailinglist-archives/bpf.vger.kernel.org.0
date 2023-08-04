Return-Path: <bpf+bounces-7014-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E88DD7702E3
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269411C209A0
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B45CA67;
	Fri,  4 Aug 2023 14:23:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F3CA49;
	Fri,  4 Aug 2023 14:23:51 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A906E171D;
	Fri,  4 Aug 2023 07:23:48 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHSXz1FZPzGpn3;
	Fri,  4 Aug 2023 22:20:19 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 22:23:45 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 0/5] team: do some cleanups in team driver
Date: Fri, 4 Aug 2023 22:28:31 +0800
Message-ID: <20230804142836.3157711-1-shaozhengchao@huawei.com>
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Do some cleanups in team driver.

---
v2: combine patch 5/6 and patch 6/6 into patch 5/5
---
Zhengchao Shao (5):
  team: add __exit modifier to team_nl_fini()
  team: remove unreferenced header in activebackup/broadcast/roundrobin
    files
  team: change the init function in the team_option structure to void
  team: change the getter function in the team_option structure to void
  team: remove unused input parameters in lb_htpm_select_tx_port and
    lb_hash_select_tx_port

 drivers/net/team/team.c                   | 62 +++++++++--------------
 drivers/net/team/team_mode_activebackup.c |  9 ++--
 drivers/net/team/team_mode_broadcast.c    |  1 -
 drivers/net/team/team_mode_loadbalance.c  | 50 +++++++-----------
 drivers/net/team/team_mode_roundrobin.c   |  1 -
 include/linux/if_team.h                   |  4 +-
 6 files changed, 48 insertions(+), 79 deletions(-)

-- 
2.34.1


