Return-Path: <bpf+bounces-51486-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA9A352F3
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 900EA1890521
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ADF469D;
	Fri, 14 Feb 2025 00:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="RWuc/OKy"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2014.outbound.protection.outlook.com [40.92.59.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853A1134D4;
	Fri, 14 Feb 2025 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493199; cv=fail; b=shexH1cmcs7a9Q/4pwQsNcIiIko+royZ08CBjjEAmTV+bJEh+b22Zcl13R01fjw87eV+3+1fFxSq4NqTQ+HNs4LzeSs1xb17nr21gGD9mLDr1DQ0sMNDKrRhJ5gWnPY2myUesE5+z6gmCJlXy8iYQn3txVbHN+MuJd6jGPjKWeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493199; c=relaxed/simple;
	bh=JWuiJasS8860QMkmztej+3oDPfd77uxfjQQ6S45LRWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O6FELRe+DPYWlG/+9Ie9/3BKvIkNLVTISJA7XUvPrP8sQaycB3L+Jy/Zwgmrb8TUejG/tioknbfydtR0NmVNV3yaa0XuP4NmH7U6o6pBj0FsMPIlH/bDey/aT4cs26Kqk2qNVh2AV863oV3n/RWR3ElDcEiAEZKVsPYeHY4JBII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=RWuc/OKy; arc=fail smtp.client-ip=40.92.59.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RRyzplAU4J79vKvDDTkkMTN4rW1UKcZow5Ux+w0f2Yh4LQwCUp/7l9UU6krv0Ci+EH3FuQQ+oT2fu69FBeZa1TsmwU6u2NllpnGf5vZij3fB6cK+aWRxxVKXetjekXKMJg5ViapsFiqkvq/2bzm5HGbyb4GZxudFDqUL8HmzoPCewFlIvoo+b42CbOAJIrz7Iw8myQJLjaQiQrF8kEQOx4nxNHPJqpSOUKVGP9E4smNPgLANVdbVEHZzLd/L+fFno6nkdbdSRQgfmbjXEZDqdyTAZx0wwZm8em8MwT2aTDnn3OAPAWvTyC25y8kvVEfaFOcRvgzMODUiAuPZ/G09Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2TZOmdi257EbXTuOknlFZlojF6sQOigQnIyaFQt0mgw=;
 b=sNtEYEglgzJGy9fbUeq3Njc/W2PLiJgGcjcJCsVZY1/g0b7QsrEnIW8QKX5Tg9P/QwDHXgIXvaw9jT/Wb84jzOjXrbp9KmnHCdkoDHZZSGgsE3M6GTvWnTylYOvZc/dGzCPzs+7OTwQKlHNw5UypxQTh3wm21945980YOJreZaNg6vV8CVuNcFVy0UmNo1RPsVCfikIWHB5RMqMotA1Dz+dUJ21mweD/ZcNhyja6edb1Eg4e+ZmpmJNAxu7ZhDhSrWjevXEweuQPJuGo1/MR/R5x/ZSrMiqgdL/QyYFWbYfie9DvK2QaMo5X3AOCrrr8xFnbmPCsZ9RC7ILRez3nmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2TZOmdi257EbXTuOknlFZlojF6sQOigQnIyaFQt0mgw=;
 b=RWuc/OKyz3PeVA41ejg9gaTgg0QZvw1Gph4+kzjn5XQJWhE7RNCczQOrTCDEoGZvdUHrqpLmwLQVIMbdo2ZBFkkFcMvDaZ0LhPZtAkifuluyTe5eJHOEB/tfaB5qjb/WrUnaY0LUBk/mLW4f63eoLDmVuNowMoIgTs1ukDC1Bj/JYoLx+tslxbXl7+WaTxe+r0Unu/Ovff8BZ7cOhQkInfZbsgJ2MFVRzigMkGUVel+neCxo+D0YmSuGjBSljfWg0pdY/c3uDaq2GM0qmszf1eXfD6TqFNhmdQ4hqK2zvOnPIQHAqv6+5tqWTUPg/QtihdZOBxhfYRc6KNEaJuA69g==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8869.eurprd03.prod.outlook.com (2603:10a6:10:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:33:13 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:33:13 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	memxor@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 3/6] bpf: Add active reference hash table and free reference list to struct bpf_run_ctx
Date: Fri, 14 Feb 2025 00:26:54 +0000
Message-ID:
 <AM6PR03MB50809C11FD48A5F1E9F8836499FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b6ac04c-519c-430c-46c8-08dd4c8f2aa7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|41001999003|12091999003|11031999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WbJg2gn0KzeGqTnTLcIGFqqNMpuVmuZm3oJF0KibBIAVuoQpuxkGRuVRd4xg?=
 =?us-ascii?Q?Lh+x27HWJNuofEidv00UhXxyZP3ED/bWcgJmW2QO3lclkQVEo5gM0kigcxju?=
 =?us-ascii?Q?LLezOp6itxKjwBx/Lgl9zh4fsVJ8fC3lxca0w1+m7yhnr3S6N5WiRKc8WcF5?=
 =?us-ascii?Q?a8gsc70XanUzF88BGgADS9ipv7+J0JcOHRLD17NHJkocc9TVo4S40/iBJf54?=
 =?us-ascii?Q?Q2T2JM8E2KVlhSMB+Q/CiqpQfBrCYBzHftyhYmGFUogdL580TkmPpja7+Eb9?=
 =?us-ascii?Q?pKtTfhfRBiaqRp4oupWRJpROdTFCNVAZWF/cHerjfdODDBS6vPBBircqDXNa?=
 =?us-ascii?Q?bqIWkBXAXPWp5GTVPsSUjwSdQQhGi7L00kkbgqh3/PrvqDbOm1O5kIQ3DAC+?=
 =?us-ascii?Q?rL28RYxQnCdGrFCQXgnwI3SjsSYHyGHo1FnghL1ZaB/sJeqpQSLBp3WCwVTu?=
 =?us-ascii?Q?vLCyb1vxackiGoMMQvXkbs1wz/GwnZrr2C2sE4x42UiyTegE9K9E9Fds4eOU?=
 =?us-ascii?Q?JgrtwbgKQm3NOuQLfiLF590rAugcVtosnGZAQfxltNKxLhX8Vy0nigU2kZbF?=
 =?us-ascii?Q?Az6wwdHXeVbsdznS9zJXkN0AsvijPNY7L1QXWroOHE6CVwTYlAslOEJISkVU?=
 =?us-ascii?Q?eRMWu3pAn909L2LWEmD8jpCcAipHx2lsY22AKr9xQDa0Y6YmcWZeCp+y3y3v?=
 =?us-ascii?Q?1lYhF8qYVl4P12naefHiUgSW8EyI4VD2UJTVOuDWoBRABm3KX/LYVXdMnxOQ?=
 =?us-ascii?Q?qX9zwRo0F6SjgdX3qCAS3HJOa95yT7jTd2twtgsbo2aKCvdnXZSsLyGJqBXZ?=
 =?us-ascii?Q?L8eb+WhQ7HOXHoZJh7wC4KQ0zlf2SYZYtqpeSgyPZ53YwbWgXC3oSxawWjjO?=
 =?us-ascii?Q?2GiOurJx5HJ9Kj7/em3wwSJydB63v3XYpbitUJVQvetQw64HMjFu/bVyk8yW?=
 =?us-ascii?Q?2kFY9XHHJYLzK5vlDZ0EBuFTNNhD8sPbfKbPL4rsnAbO/YVbta+HSsZl9aGJ?=
 =?us-ascii?Q?5USTEFWCQgbRiQHtWvHWtnrEg1U867gfhM0p9oPSH/p3G4gW5oq/m3XApkNZ?=
 =?us-ascii?Q?RHpYqhitLsdoUb2jXeshp4XLFYz8bFnPIENEOVYaaEBUWX7iKFye8wu4rDJC?=
 =?us-ascii?Q?1WSIgrIEeNGMHQRIf5ab8wEfKGoo2gg37A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5DuqEpymRFkzcVvlncDHJ8xc1P+XgUZLg3BLaXGbuV1DDzygy8QPtq3H9FgR?=
 =?us-ascii?Q?cz4c6/RyMHVM1AQq2zXSW0SAoZQGCfGyE+E860J0fcChoTRsS9Zy1l6GEGAL?=
 =?us-ascii?Q?pTaCcnw17/ssl9XtJv1MGNO6d66VUTzYLmdUEggyPuHOLtG9GU7Vn/rKuRlw?=
 =?us-ascii?Q?70nJMlP/AH90TvNR1Btl9fG/BBQur+lMCaY+xXSo6DqIxEDy3upQVSetx9uR?=
 =?us-ascii?Q?nZOsAI1CfSExcE9CUvXbDnmqgfD6GJwtPznnzXsrtygGCErHX/64fdVCcDDw?=
 =?us-ascii?Q?mRFbpkW4WrIlCiwz1J4e4bhwE1YHm4wiQCifoBDnPPCwIuwa22d0hl8kWkmf?=
 =?us-ascii?Q?4DqhTkEud7GsR5CQw0QUucLJF0bJtIJ2quU7+Ig+DaE3birk+4zjmo22jd3Y?=
 =?us-ascii?Q?Xg8bXK4wAfT5LBFymy3wWm99TgjEdzP92NeOvpAmZypuVnl1AoomykhIi8r+?=
 =?us-ascii?Q?QMtvq8QLIlcKotPKPKBD8Y3dP26NMK9ybjooF50Q2iaLGXYtauDLa5lYVMgP?=
 =?us-ascii?Q?gukRVPcxtti5UuYZog2Xc3DoRdWto7ucgT0AForRi28S+0oQJEmKT5wuh7Bf?=
 =?us-ascii?Q?5fo9lx1kKIplmasMqmi9twlYE44amx4JMckOsARj2xqg+D0i1xkO2MDs4jAK?=
 =?us-ascii?Q?ZyMXumaZUfXDctKA9lhvlbJJ5weLvmOYK1MPHVyV5nlASyWvww9n+QuAjUgU?=
 =?us-ascii?Q?t+Tv+sBG4p+15kV50X3sC5+dM+D/4i6sd5qglse07tDJ8paxeV4tZy7HLvK4?=
 =?us-ascii?Q?eNLjiGE5aeLhND5e9JLJKjpxHHE++O4ynIvWICv4ODYDixAqZuxYJ+mCHlX9?=
 =?us-ascii?Q?QEaW8Q9c/FRf7Zj/6p/sZNFWME82ZagDPskdhOCEYSPKaJqRDCWS8/VGTuSC?=
 =?us-ascii?Q?DRqfAU+sHSkTKrSXBteStap33Q7J94abl/hspmNStaZyprQUnUM3gb/I7KOV?=
 =?us-ascii?Q?X5UMrcJLFHFx3Mzxdd3r+UhGbLFhzYt9txUdMv8oX5H7LYDfS+stwG5R7edf?=
 =?us-ascii?Q?i/TrK/kUBTjk+bcUDtYULLSWZPTHzivyOgfHHDkUwTLLnDjishfoSjvKNwZN?=
 =?us-ascii?Q?ucCp5WuxRC2vzx7MYMCrkIHAybVlbI2A/IdMMK4a9MR11YBByb4pfrnjlJoP?=
 =?us-ascii?Q?0rd6fkyUF81r0T4OUe0vrt+Os7twTd/9GV96A3M2C13UYOuRozrTxfiHa0Yr?=
 =?us-ascii?Q?8iYRCwOcZ2+LSohBBkT/a6d5c0ibrAfXiZ3X6uVmv1NhZqH5Ec6T0B4ZzD4X?=
 =?us-ascii?Q?WZ2cE4wUPCBWaXZ3sPt9?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6ac04c-519c-430c-46c8-08dd4c8f2aa7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:33:13.8633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869

This patch adds active references hash table and free references list to
struct bpf_run_ctx.

The active reference hash table stores active reference nodes that
record the references currently held by the bpf program. The free
reference list stores free reference nodes. At the beginning all
reference nodes are free.

During initialization, max_acquired_refs number of reference nodes
will be created to record information about the references held by
the bpf program. A reference node records information including the
object btf id and the object memory address.

The bpf context will be initialized through init_bpf_context before
the bpf program runs, and cleared through clear_bpf_context after
the bpf program ends.

Currently only used to demonstrate the idea, so only applied to
the syscall program type (only added to bpf_prog_test_run_syscall).

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf.h |  6 +++++-
 include/linux/btf.h |  7 +++++++
 net/bpf/test_run.c  | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 3ccc20f936b2..1bc90d805872 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/percpu.h>
 #include <linux/err.h>
+#include <linux/hashtable.h>
 #include <linux/rbtree_latch.h>
 #include <linux/numa.h>
 #include <linux/mm_types.h>
@@ -2109,7 +2110,10 @@ int bpf_prog_array_copy(struct bpf_prog_array *old_array,
 			u64 bpf_cookie,
 			struct bpf_prog_array **new_array);
 
-struct bpf_run_ctx {};
+struct bpf_run_ctx {
+	DECLARE_HASHTABLE(active_ref_list, 5);
+	struct list_head free_ref_list;
+};
 
 struct bpf_cg_run_ctx {
 	struct bpf_run_ctx run_ctx;
diff --git a/include/linux/btf.h b/include/linux/btf.h
index ebc0c0c9b944..2bd7fc996756 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -139,6 +139,13 @@ struct btf_struct_metas {
 	struct btf_struct_meta types[];
 };
 
+struct bpf_ref_node {
+	struct hlist_node hnode;
+	struct list_head lnode;
+	u32 struct_btf_id;
+	unsigned long obj_addr;
+};
+
 extern const struct file_operations btf_fops;
 
 const char *btf_get_name(const struct btf *btf);
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 8f6f7db48d4e..13d0994883c0 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1530,12 +1530,43 @@ int bpf_prog_test_run_sk_lookup(struct bpf_prog *prog, const union bpf_attr *kat
 	return ret;
 }
 
+static void init_bpf_context(struct bpf_run_ctx *ctx, struct bpf_prog *prog)
+{
+	struct bpf_ref_node *node;
+	int i;
+
+	hash_init(ctx->active_ref_list);
+	INIT_LIST_HEAD(&ctx->free_ref_list);
+
+	for (i = 0; i < prog->max_acquired_refs; i++) {
+		node = kmalloc(sizeof(*node), GFP_KERNEL);
+		list_add(&node->lnode, &ctx->free_ref_list);
+	}
+}
+
+static void clear_bpf_context(struct bpf_run_ctx *ctx)
+{
+	struct bpf_ref_node *node, *tmp;
+	int bkt;
+
+	hash_for_each(ctx->active_ref_list, bkt, node, hnode) {
+		hash_del(&node->hnode);
+		kfree(node);
+	}
+
+	list_for_each_entry_safe(node, tmp, &ctx->free_ref_list, lnode) {
+		list_del(&node->lnode);
+		kfree(node);
+	}
+}
+
 int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			      const union bpf_attr *kattr,
 			      union bpf_attr __user *uattr)
 {
 	void __user *ctx_in = u64_to_user_ptr(kattr->test.ctx_in);
 	__u32 ctx_size_in = kattr->test.ctx_size_in;
+	struct bpf_run_ctx *old_ctx, run_ctx;
 	void *ctx = NULL;
 	u32 retval;
 	int err = 0;
@@ -1557,10 +1588,16 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
 			return PTR_ERR(ctx);
 	}
 
+	init_bpf_context(&run_ctx, prog);
+	old_ctx = bpf_set_run_ctx(&run_ctx);
+
 	rcu_read_lock_trace();
 	retval = bpf_prog_run_pin_on_cpu(prog, ctx);
 	rcu_read_unlock_trace();
 
+	bpf_reset_run_ctx(old_ctx);
+	clear_bpf_context(&run_ctx);
+
 	if (copy_to_user(&uattr->test.retval, &retval, sizeof(u32))) {
 		err = -EFAULT;
 		goto out;
-- 
2.39.5


