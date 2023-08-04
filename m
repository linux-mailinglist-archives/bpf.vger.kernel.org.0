Return-Path: <bpf+bounces-6985-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DB576FF6D
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 13:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A819D282563
	for <lists+bpf@lfdr.de>; Fri,  4 Aug 2023 11:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33CBA36;
	Fri,  4 Aug 2023 11:23:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1733BA2D;
	Fri,  4 Aug 2023 11:23:47 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F361B9;
	Fri,  4 Aug 2023 04:23:38 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RHNb03sZyzVjxy;
	Fri,  4 Aug 2023 19:21:48 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 19:23:35 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <jiri@resnulli.us>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>,
	<shaozhengchao@huawei.com>
Subject: [PATCH net-next 2/2] team: change return value of getter in the team_option structure to void
Date: Fri, 4 Aug 2023 19:28:25 +0800
Message-ID: <20230804112825.1697920-3-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804112825.1697920-1-shaozhengchao@huawei.com>
References: <20230804112825.1697920-1-shaozhengchao@huawei.com>
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
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Because the getter function always returns 0, so change return value of
getter in the team_option structure to void and remove redundant code.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/team/team.c                   | 52 ++++++++++-------------
 drivers/net/team/team_mode_activebackup.c |  3 +-
 drivers/net/team/team_mode_loadbalance.c  | 24 ++++-------
 include/linux/if_team.h                   |  2 +-
 4 files changed, 33 insertions(+), 48 deletions(-)

diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
index 84a57dcddb8b..8f8a3eabdbe7 100644
--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -358,7 +358,9 @@ static int team_option_get(struct team *team,
 {
 	if (!opt_inst->option->getter)
 		return -EOPNOTSUPP;
-	return opt_inst->option->getter(team, ctx);
+
+	opt_inst->option->getter(team, ctx);
+	return 0;
 }
 
 static int team_option_set(struct team *team,
@@ -1373,10 +1375,9 @@ static int team_port_del(struct team *team, struct net_device *port_dev)
  * Net device ops
  *****************/
 
-static int team_mode_option_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void team_mode_option_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	ctx->data.str_val = team->mode->kind;
-	return 0;
 }
 
 static int team_mode_option_set(struct team *team, struct team_gsetter_ctx *ctx)
@@ -1384,11 +1385,10 @@ static int team_mode_option_set(struct team *team, struct team_gsetter_ctx *ctx)
 	return team_change_mode(team, ctx->data.str_val);
 }
 
-static int team_notify_peers_count_get(struct team *team,
-				       struct team_gsetter_ctx *ctx)
+static void team_notify_peers_count_get(struct team *team,
+					struct team_gsetter_ctx *ctx)
 {
 	ctx->data.u32_val = team->notify_peers.count;
-	return 0;
 }
 
 static int team_notify_peers_count_set(struct team *team,
@@ -1398,11 +1398,10 @@ static int team_notify_peers_count_set(struct team *team,
 	return 0;
 }
 
-static int team_notify_peers_interval_get(struct team *team,
-					  struct team_gsetter_ctx *ctx)
+static void team_notify_peers_interval_get(struct team *team,
+					   struct team_gsetter_ctx *ctx)
 {
 	ctx->data.u32_val = team->notify_peers.interval;
-	return 0;
 }
 
 static int team_notify_peers_interval_set(struct team *team,
@@ -1412,11 +1411,10 @@ static int team_notify_peers_interval_set(struct team *team,
 	return 0;
 }
 
-static int team_mcast_rejoin_count_get(struct team *team,
-				       struct team_gsetter_ctx *ctx)
+static void team_mcast_rejoin_count_get(struct team *team,
+					struct team_gsetter_ctx *ctx)
 {
 	ctx->data.u32_val = team->mcast_rejoin.count;
-	return 0;
 }
 
 static int team_mcast_rejoin_count_set(struct team *team,
@@ -1426,11 +1424,10 @@ static int team_mcast_rejoin_count_set(struct team *team,
 	return 0;
 }
 
-static int team_mcast_rejoin_interval_get(struct team *team,
-					  struct team_gsetter_ctx *ctx)
+static void team_mcast_rejoin_interval_get(struct team *team,
+					   struct team_gsetter_ctx *ctx)
 {
 	ctx->data.u32_val = team->mcast_rejoin.interval;
-	return 0;
 }
 
 static int team_mcast_rejoin_interval_set(struct team *team,
@@ -1440,13 +1437,12 @@ static int team_mcast_rejoin_interval_set(struct team *team,
 	return 0;
 }
 
-static int team_port_en_option_get(struct team *team,
-				   struct team_gsetter_ctx *ctx)
+static void team_port_en_option_get(struct team *team,
+				    struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 
 	ctx->data.bool_val = team_port_enabled(port);
-	return 0;
 }
 
 static int team_port_en_option_set(struct team *team,
@@ -1461,13 +1457,12 @@ static int team_port_en_option_set(struct team *team,
 	return 0;
 }
 
-static int team_user_linkup_option_get(struct team *team,
-				       struct team_gsetter_ctx *ctx)
+static void team_user_linkup_option_get(struct team *team,
+					struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 
 	ctx->data.bool_val = port->user.linkup;
-	return 0;
 }
 
 static void __team_carrier_check(struct team *team);
@@ -1483,13 +1478,12 @@ static int team_user_linkup_option_set(struct team *team,
 	return 0;
 }
 
-static int team_user_linkup_en_option_get(struct team *team,
-					  struct team_gsetter_ctx *ctx)
+static void team_user_linkup_en_option_get(struct team *team,
+					   struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 
 	ctx->data.bool_val = port->user.linkup_enabled;
-	return 0;
 }
 
 static int team_user_linkup_en_option_set(struct team *team,
@@ -1503,13 +1497,12 @@ static int team_user_linkup_en_option_set(struct team *team,
 	return 0;
 }
 
-static int team_priority_option_get(struct team *team,
-				    struct team_gsetter_ctx *ctx)
+static void team_priority_option_get(struct team *team,
+				     struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 
 	ctx->data.s32_val = port->priority;
-	return 0;
 }
 
 static int team_priority_option_set(struct team *team,
@@ -1525,13 +1518,12 @@ static int team_priority_option_set(struct team *team,
 	return 0;
 }
 
-static int team_queue_id_option_get(struct team *team,
-				    struct team_gsetter_ctx *ctx)
+static void team_queue_id_option_get(struct team *team,
+				     struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 
 	ctx->data.u32_val = port->queue_id;
-	return 0;
 }
 
 static int team_queue_id_option_set(struct team *team,
diff --git a/drivers/net/team/team_mode_activebackup.c b/drivers/net/team/team_mode_activebackup.c
index 44d604f1c512..e0f599e2a51d 100644
--- a/drivers/net/team/team_mode_activebackup.c
+++ b/drivers/net/team/team_mode_activebackup.c
@@ -63,7 +63,7 @@ static void ab_active_port_init(struct team *team,
 	ab_priv(team)->ap_opt_inst_info = info;
 }
 
-static int ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct team_port *active_port;
 
@@ -73,7 +73,6 @@ static int ab_active_port_get(struct team *team, struct team_gsetter_ctx *ctx)
 		ctx->data.u32_val = active_port->dev->ifindex;
 	else
 		ctx->data.u32_val = 0;
-	return 0;
 }
 
 static int ab_active_port_set(struct team *team, struct team_gsetter_ctx *ctx)
diff --git a/drivers/net/team/team_mode_loadbalance.c b/drivers/net/team/team_mode_loadbalance.c
index 50c015cd0682..2f1573f253ec 100644
--- a/drivers/net/team/team_mode_loadbalance.c
+++ b/drivers/net/team/team_mode_loadbalance.c
@@ -242,19 +242,18 @@ static bool lb_transmit(struct team *team, struct sk_buff *skb)
 	return false;
 }
 
-static int lb_bpf_func_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void lb_bpf_func_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 
 	if (!lb_priv->ex->orig_fprog) {
 		ctx->data.bin_val.len = 0;
 		ctx->data.bin_val.ptr = NULL;
-		return 0;
+		return;
 	}
 	ctx->data.bin_val.len = lb_priv->ex->orig_fprog->len *
 				sizeof(struct sock_filter);
 	ctx->data.bin_val.ptr = lb_priv->ex->orig_fprog->filter;
-	return 0;
 }
 
 static int __fprog_create(struct sock_fprog_kern **pfprog, u32 data_len,
@@ -335,7 +334,7 @@ static void lb_bpf_func_free(struct team *team)
 	bpf_prog_destroy(fp);
 }
 
-static int lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 	lb_select_tx_port_func_t *func;
@@ -346,7 +345,6 @@ static int lb_tx_method_get(struct team *team, struct team_gsetter_ctx *ctx)
 	name = lb_select_tx_port_get_name(func);
 	BUG_ON(!name);
 	ctx->data.str_val = name;
-	return 0;
 }
 
 static int lb_tx_method_set(struct team *team, struct team_gsetter_ctx *ctx)
@@ -370,8 +368,8 @@ static void lb_tx_hash_to_port_mapping_init(struct team *team,
 	LB_HTPM_OPT_INST_INFO_BY_HASH(lb_priv, hash) = info;
 }
 
-static int lb_tx_hash_to_port_mapping_get(struct team *team,
-					  struct team_gsetter_ctx *ctx)
+static void lb_tx_hash_to_port_mapping_get(struct team *team,
+					   struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 	struct team_port *port;
@@ -379,7 +377,6 @@ static int lb_tx_hash_to_port_mapping_get(struct team *team,
 
 	port = LB_HTPM_PORT_BY_HASH(lb_priv, hash);
 	ctx->data.u32_val = port ? port->dev->ifindex : 0;
-	return 0;
 }
 
 static int lb_tx_hash_to_port_mapping_set(struct team *team,
@@ -409,14 +406,13 @@ static void lb_hash_stats_init(struct team *team,
 	lb_priv->ex->stats.info[hash].opt_inst_info = info;
 }
 
-static int lb_hash_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void lb_hash_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 	unsigned char hash = ctx->info->array_index;
 
 	ctx->data.bin_val.ptr = &lb_priv->ex->stats.info[hash].stats;
 	ctx->data.bin_val.len = sizeof(struct lb_stats);
-	return 0;
 }
 
 static void lb_port_stats_init(struct team *team,
@@ -428,14 +424,13 @@ static void lb_port_stats_init(struct team *team,
 	lb_port_priv->stats_info.opt_inst_info = info;
 }
 
-static int lb_port_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
+static void lb_port_stats_get(struct team *team, struct team_gsetter_ctx *ctx)
 {
 	struct team_port *port = ctx->info->port;
 	struct lb_port_priv *lb_port_priv = get_lb_port_priv(port);
 
 	ctx->data.bin_val.ptr = &lb_port_priv->stats_info.stats;
 	ctx->data.bin_val.len = sizeof(struct lb_stats);
-	return 0;
 }
 
 static void __lb_stats_info_refresh_prepare(struct lb_stats_info *s_info)
@@ -528,13 +523,12 @@ static void lb_stats_refresh(struct work_struct *work)
 	mutex_unlock(&team->lock);
 }
 
-static int lb_stats_refresh_interval_get(struct team *team,
-					 struct team_gsetter_ctx *ctx)
+static void lb_stats_refresh_interval_get(struct team *team,
+					  struct team_gsetter_ctx *ctx)
 {
 	struct lb_priv *lb_priv = get_lb_priv(team);
 
 	ctx->data.u32_val = lb_priv->ex->stats.refresh_interval;
-	return 0;
 }
 
 static int lb_stats_refresh_interval_set(struct team *team,
diff --git a/include/linux/if_team.h b/include/linux/if_team.h
index fc01c3cfe86d..1b9b15a492fa 100644
--- a/include/linux/if_team.h
+++ b/include/linux/if_team.h
@@ -163,7 +163,7 @@ struct team_option {
 	unsigned int array_size; /* != 0 means the option is array */
 	enum team_option_type type;
 	void (*init)(struct team *team, struct team_option_inst_info *info);
-	int (*getter)(struct team *team, struct team_gsetter_ctx *ctx);
+	void (*getter)(struct team *team, struct team_gsetter_ctx *ctx);
 	int (*setter)(struct team *team, struct team_gsetter_ctx *ctx);
 };
 
-- 
2.34.1


