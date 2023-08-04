Return-Path: <bpf+bounces-7017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9147F7702EC
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C258C1C21859
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 14:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF38418033;
	Fri,  4 Aug 2023 14:23:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B776513ADF;
	Fri,  4 Aug 2023 14:23:52 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735B419A4;
	Fri,  4 Aug 2023 07:23:49 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHSY05F3vzGpnH;
	Fri,  4 Aug 2023 22:20:20 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 22:23:46 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next,v2 3/5] team: change the init function in the team_option structure to void
Date: Fri, 4 Aug 2023 22:28:34 +0800
Message-ID: <20230804142836.3157711-4-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804142836.3157711-1-shaozhengchao@huawei.com>
References: <20230804142836.3157711-1-shaozhengchao@huawei.com>
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
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because the init function in the team_option structure always returns 0,
so change the init function to void and remove redundant code.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/team/team.c                   |  8 ++------
 drivers/net/team/team_mode_activebackup.c |  5 ++---
 drivers/net/team/team_mode_loadbalance.c  | 15 ++++++---------
 include/linux/if_team.h                   |  2 +-
 4 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index e4fe70a71b40..b88e1c451e07 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -149,7 +149,6 @@ static int __team_option_inst_add(struct team *team, struct team_option *option,
 	struct team_option_inst *opt_inst;
 	unsigned int array_size;
 	unsigned int i;
-	int err;
 
 	array_size = option->array_size;
 	if (!array_size)
@@ -165,11 +164,8 @@ static int __team_option_inst_add(struct team *team, struct team_option *option,
 		opt_inst->changed = true;
 		opt_inst->removed = false;
 		list_add_tail(&opt_inst->list, &team->option_inst_list);
-		if (option->init) {
-			err = option->init(team, &opt_inst->info);
-			if (err)
-				return err;
-		}
+		if (option->init)
+			option->init(team, &opt_inst->info);
 
 	}
 	return 0;
diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index 49d1c08d040e..4fd5966c9876 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -56,11 +56,10 @@ static void ab_port_leave(struct team *team, struct team_port *port)
 	}
 }
 
-static int ab_active_port_init(struct team *team,
-			       struct team_option_inst_info *info)
+static void ab_active_port_init(struct team *team,
+				struct team_option_inst_info *info)
 {
 	ab_priv(team)->ap_opt_inst_info = info;
-	return 0;
 }
 
 static int ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 18d99fda997c..50c015cd0682 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -361,14 +361,13 @@ static int lb_tx_method_set(struct team *team, struct team_gsetter_ctx *ctx)
 	return 0;
 }
 
-static int lb_tx_hash_to_port_mapping_init(struct team *team,
-					   struct team_option_inst_info *info)
+static void lb_tx_hash_to_port_mapping_init(struct team *team,
+					    struct team_option_inst_info *info)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 	unsigned char hash = info->array_index;
 
 	LB_HTPM_OPT_INST_INFO_BY_HASH(lb_priv, hash) = info;
-	return 0;
 }
 
 static int lb_tx_hash_to_port_mapping_get(struct team *team,
@@ -401,14 +400,13 @@ static int lb_tx_hash_to_port_mapping_set(struct team *team,
 	return -ENODEV;
 }
 
-static int lb_hash_stats_init(struct team *team,
-			      struct team_option_inst_info *info)
+static void lb_hash_stats_init(struct team *team,
+			       struct team_option_inst_info *info)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 	unsigned char hash = info->array_index;
 
 	lb_priv->ex->stats.info[hash].opt_inst_info = info;
-	return 0;
 }
 
 static int lb_hash_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
@@ -421,14 +419,13 @@ static int lb_hash_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
 	return 0;
 }
 
-static int lb_port_stats_init(struct team *team,
-			      struct team_option_inst_info *info)
+static void lb_port_stats_init(struct team *team,
+			       struct team_option_inst_info *info)
 {
 	struct team_port *port = info->port;
 	struct lb_port_priv *lb_port_priv = get_lb_port_priv(port);
 
 	lb_port_priv->stats_info.opt_inst_info = info;
-	return 0;
 }
 
 static int lb_port_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index 8de6b6e67829..fc01c3cfe86d 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -162,7 +162,7 @@ struct team_option {
 	bool per_port;
 	unsigned int array_size; /* != 0 means the option is array */
 	enum team_option_type type;
-	int (*init)(struct team *team, struct team_option_inst_info *info);
+	void (*init)(struct team *team, struct team_option_inst_info *info);
 	int (*getter)(struct team *team, struct team_gsetter_ctx *ctx);
 	int (*setter)(struct team *team, struct team_gsetter_ctx *ctx);
 };
-- 
2.34.1


