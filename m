Return-Path: <bpf+bounces-34428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D7292D86E
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 20:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 995941C21237
	for <lists+bpf@lfdr.de>; Wed, 10 Jul 2024 18:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FACA197A82;
	Wed, 10 Jul 2024 18:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ebCR2ZWr"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazolkn19011079.outbound.protection.outlook.com [52.103.32.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD83619754D;
	Wed, 10 Jul 2024 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720636942; cv=fail; b=OciiEI2fHGaFveU548lq0Indys1awXnISu6v4kh0Xs31bmoRIypjtD4ooe6xXlIntXPQShtoVOZPFuOQpE9dxFD9JFe64w4+xsqRqjokxmhfi0Pg4a7JIB8M3m38pd6A3BoPT99TVDA9dB6KKuePAZ2XKqkGNMrKwMn10JIO1WY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720636942; c=relaxed/simple;
	bh=2VzsNC8RjhBFsaoETzi1HALEC+WpHCOX/RqlEcxIgQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwQGMnHMXX3Pfh+On8lTOOewza92SEjY9NTZ0+XKdDdfs7unHrfFjI8/iR93bowFtY3XNW12wNXIm7grZTVpv2RpIFQAyP/vDaXG7G6oGrbVSCKrhDfwu3Ut12+nBDnvUYcqtCvuYTgk8CgGTA+wZhwSq6VWDc27t901+lJcziM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ebCR2ZWr; arc=fail smtp.client-ip=52.103.32.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz/XN824Opt/fn2mr+NL6luxvRDrumLMP9YzyixRQr62st/OGvJlXXs5rmTCtFuOwHVppxvzkk0MA4w4Dgpryx8GAUyJS8DGDaC/KZ35DPgO1JRh5oJtbv/F2hvaQ4g269vmn4HmvvHt0SN6paeFhvPI8PqrUA2LUcHkRJao9xwBAwKVVKO9S0XLNcSpNew4yEFwbuOLAL601UeK1Uw7XhRfMgdscYRRCcpDGSRCzsBpGlr0kzmfh2xlpEzJq+eqTtsrcPZTEEs9Af3hKR89PIs6971Mh8Tyigy/D/+hcBJimOM8KFzGBa+C3f3HLU63DnDypjuTvU8pqwNuyAek1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QfFwhFFn2kM4OMK4kA50yiuRJuIhkfv0Ti3LY/dxRIk=;
 b=F7gfSzlXM5O06DDgOTThR8nMF/JdF/U89s+FVIrehBHhXorA9lkO4VG/sVekbBAaxB4bfXsFMohTYBROQBV/CajRNMQolkP62J44VvZN4WASPD2FZJ/cBtBqd3j3uMZy0/Huvz3KVSOMczX5w9TaCLq7gpLPPRAaU9OlRXWcxBCnp3G/AcIcuHZSQ8h1sGMlu1yYNqFA7P6s0h/pB3STyTciTNXqa4aig6QfoX8cWGbWP8hh/wAVdOtovPDEASDKngyP+2UtguauYVJH4uxOv/ugOmyLwxR8RNikUcxqr/UEG0gxrXsE4IbbmpxA8K1LTG6vs1+3JbtUze9wGIpiRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QfFwhFFn2kM4OMK4kA50yiuRJuIhkfv0Ti3LY/dxRIk=;
 b=ebCR2ZWrs/FI6gzOEOnkTLPBcdGRlCwcM1NFf1A5faZPYvMwBeWbP0xaviNaPdaFiOeN1qWO7IXuFwbaRs9o3eo7g9L5Vf+wgHZoXSJKcp2DnJl8lULbMe7n4AejY1qO0hN2RSQuNF558FN2/suxhmV0mM3qxTsjRlvOwFmAQ2rTiDqn3E/c1I1z6l5vqFH3oTXVjTVGi5sjWFwF6DpQNkH20bw9UCc+T2RETzleLlkw9z6trAQobUzqFJzQ1bWe9SzkAgsluOwG5/uCJOm5bxmvlAmebJItYP8hZSTQ6jO+RW/u7esIf94TZKRDZcnTzklLroHSt5zHByTuYc2CAQ==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS8PR03MB9935.eurprd03.prod.outlook.com (2603:10a6:20b:628::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 18:42:17 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 18:42:17 +0000
From: Juntong Deng <juntong.deng@outlook.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	andrii@kernel.org,
	avagin@gmail.com,
	snorcht@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 02/16] bpf: Add KF_ITER_GETTER and KF_ITER_SETTER flags
Date: Wed, 10 Jul 2024 19:40:46 +0100
Message-ID:
 <AM6PR03MB5848986AAEEE3264C6EB6D8C99A42@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710184100.297261-1-juntong.deng@outlook.com>
References: <20240710184100.297261-1-juntong.deng@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IP88/lLZhQyzCEjrgSlvpEcLTR2RiuZU]
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240710184100.297261-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS8PR03MB9935:EE_
X-MS-Office365-Filtering-Correlation-Id: 9918cc04-1cdd-4f38-c494-08dca11005cd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|461199028|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	C0T+6Z35XRWRykX113fZtP2wqKY4DiIk/WKSvNzHFi7e2qckWGZ0oJH4poQ094SQWs4tOkrkvuTG9tleLTMBZ/g9LvBuW/2WU6xC2AA7MmQyVM6q+pXdbX+C52fzgrQsHTSC6C0EP+tDQ3o5PiXiqAWYovnKcXYC+px5O6TkJdoqNV9DZ3SrSDU1lQRdtdxJ5Ek1b+Io7usMlsbxbPE22EBYIjYqC9r2WmsWX3nk1Iu8Bi4Cnw3Pf5gSHqCSRUYY7zdv6U0/zIm4hNOXRFsvmXGz4aeEIUw+aTzUxct5Sq9IrTzswGs32s4QysITDyrBZZr4lXRLs5Nquq3jSSrtpXR94RCV/tzFZNq0wan+Kbn5zpi8v0Byg00zmAQQM2FONyS1chZIhMGBtKSFDHCD5/WZRb8iQB3ryHOeh3W+B96Obs3c0KSL5NrUYafRuBtczXORLmjerzxNj72Ewk2Hor9pOc0t/19eZ3gHwsK5vvylAYm4UgDyMD/6mL5xmCh0ZEgKrHRNl0eVvC3JgoHfeckHRMT5CVY1Ho4n8XFv3WTxbK+NK+nICpsk1c0THcDEZOJ59hEQB28jlsFZemwEQ9oRtU2UasOcBAa8tf6ehs7pGE40+/5uhdbSlwTOu3x2Drui6cQ/x17t0KvcY2Xo8g==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9kcTc7MgQCHhchPsPJEcfVhd47u+JjyNWJHiQGWIVXFjCACmudcb2toOEzC2?=
 =?us-ascii?Q?e85ENAgbUYFugFTUbxkJoSvdyAQXghkw29PwNgDzXK9YOKUBAB0jkPpcqTVs?=
 =?us-ascii?Q?CTpdimlQeD53z7adAMOZe+tPL684GIaVR4vOf2BmNvn3E5fnEpqtuRxv27yc?=
 =?us-ascii?Q?yJqxtM5XcV35IOZCOqdYNKQMnLzQOmoBxGwseAlwgYTADjMfDwLYuVMs8zgY?=
 =?us-ascii?Q?pWEMTp/wPtIY43SJSCBFKyCC4kivBFtlpOq3ayrzkpDCBQI/g6Q3vzQ/apz8?=
 =?us-ascii?Q?YdTK6uHqqrIgdGKFADnZpBGjCd2alVEI22OTd7cz/dfDtSgIFDN1Yd72kZbJ?=
 =?us-ascii?Q?eop8Sf5jxUngHGbmIEOtTucB026V5dI3xtWmnRsJS3GE6AGbsvwepqkT9yn5?=
 =?us-ascii?Q?nRXRjPsgGcz2KHc6QDQzQa99PtYCSbQdwSMm2STfSFSZKoWCzPfB/TLujIhw?=
 =?us-ascii?Q?gIZ30o2BeThPBTYCNDYIbjnqSW7VfOPZJebjhqtTCyxbwX87HvXE57Y+7JSV?=
 =?us-ascii?Q?mlHPm25eJ8HZPB+XMqNrW5+NRHeERaYuf/cYhseXwm+aWPYh3a00oemAe/UA?=
 =?us-ascii?Q?cOV5PYylcFFyHm/ynLojoBJYL9TJHwMxEi3m83mzg5HLVvbJLWqtr8FLu9Rw?=
 =?us-ascii?Q?4LNm9/HjynW6e0JSG2aS+gv8X3PfjljfOWIGmAEP9XusA7la4sSfqPdeb4uW?=
 =?us-ascii?Q?pLkLTiWK9fxo8C0/Z8P3DusI51hZuGXHui5/+Q87HEsZJTDLvZsqdo62bJsZ?=
 =?us-ascii?Q?n6cf285gK/qEsjDbR5wTALyaebUXCnEb8xUl2fnWsNpn8Kx2jKIVJtN8sBwc?=
 =?us-ascii?Q?+IBHYHpcezfDY9U+Hn8FnRy00CY/hLqTpw+Y0+Mh0smzqqy6Yfdpoig0jDeA?=
 =?us-ascii?Q?G/TUSuCuECsIak2mGAJL908OZ3onQPxovQPQOuE1wufCSYVOD76xt0ajtW5O?=
 =?us-ascii?Q?Vi51va/qWQGP5F+mjQhflIB1/3+f6Kv9O7FKuVAP/CX7fvM3XqwCqxJpSr/M?=
 =?us-ascii?Q?C+kb9cv3ZINof81SUszEl7xNpmsM4964vPNR5+wmomRT7jWkT7L7PeExDpgo?=
 =?us-ascii?Q?xh0h/Fdf46wU0eXQU64rAQgeoasbzEKwp1gGODlzjs0/00+V9aBOxOb5Qt+J?=
 =?us-ascii?Q?VXF2FlnuB4TK8CpmC+hfv3gEzailsdWu8B8flPppyrPSFY7OCh4we7u4R8/a?=
 =?us-ascii?Q?JEKBm1zJUMLmpYiKDqPAFOnw7xc/5hRBNX+M+mdYie7TfC4dyIL15w4TTOk?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9918cc04-1cdd-4f38-c494-08dca11005cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 18:42:17.1110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9935

Currently the only iterator flags are KF_ITER_NEW, KF_ITER_NEXT,
KF_ITER_DESTROY, but we cannot get the iterator status information or
change the iterator status through constructor, next method, destructor.

For example, when iterating over process files, in addition to getting
a pointer to struct file, we may also want to get the file descriptor
corresponding to struct file.

Another example is when iterating over packet data, in addition to
getting the data, we may want to change the buffer we set.

In this patch, add KF_ITER_GETTER for getting iterator status
information and KF_ITER_SETTER for changing iterator status.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h   |  4 +++-
 kernel/bpf/btf.c      | 30 +++++++++++++++++++++---------
 kernel/bpf/verifier.c |  3 ++-
 3 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index cffb43133c68..323a74489562 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -70,11 +70,13 @@
 #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
 #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
 #define KF_RCU          (1 << 7) /* kfunc takes either rcu or trusted pointer arguments */
-/* only one of KF_ITER_{NEW,NEXT,DESTROY} could be specified per kfunc */
+/* only one of KF_ITER_{NEW,NEXT,DESTROY,GETTER,SETTER} could be specified per kfunc */
 #define KF_ITER_NEW     (1 << 8) /* kfunc implements BPF iter constructor */
 #define KF_ITER_NEXT    (1 << 9) /* kfunc implements BPF iter next method */
 #define KF_ITER_DESTROY (1 << 10) /* kfunc implements BPF iter destructor */
 #define KF_RCU_PROTECTED (1 << 11) /* kfunc should be protected by rcu cs when they are invoked */
+#define KF_ITER_GETTER   (1 << 12) /* kfunc implements BPF iter getter */
+#define KF_ITER_SETTER   (1 << 13) /* kfunc implements BPF iter setter */
 
 /*
  * Tag marking a kernel function as a kfunc. This is meant to minimize the
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 306349ee3d6a..d053f058bd91 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -8054,14 +8054,15 @@ BTF_TRACING_TYPE_xxx
 static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 				 const struct btf_type *func, u32 func_flags)
 {
-	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+	u32 flags = func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+				  KF_ITER_GETTER | KF_ITER_SETTER);
 	const char *name, *sfx, *iter_name;
 	const struct btf_param *arg;
 	const struct btf_type *t;
 	char exp_name[128];
 	u32 nr_args;
 
-	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY} can be set */
+	/* exactly one of KF_ITER_{NEW,NEXT,DESTROY,GETTER,SETTER} can be set */
 	if (!flags || (flags & (flags - 1)))
 		return -EINVAL;
 
@@ -8088,7 +8089,7 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 	if (t->size == 0 || (t->size % 8))
 		return -EINVAL;
 
-	/* validate bpf_iter_<type>_{new,next,destroy}(struct bpf_iter_<type> *)
+	/* validate bpf_iter_<type>_{new,next,destroy,get,set}(struct bpf_iter_<type> *)
 	 * naming pattern
 	 */
 	iter_name = name + sizeof(ITER_PREFIX) - 1;
@@ -8096,15 +8097,25 @@ static int btf_check_iter_kfuncs(struct btf *btf, const char *func_name,
 		sfx = "new";
 	else if (flags & KF_ITER_NEXT)
 		sfx = "next";
-	else /* (flags & KF_ITER_DESTROY) */
+	else if (flags & KF_ITER_DESTROY)
 		sfx = "destroy";
+	else if (flags & KF_ITER_GETTER)
+		sfx = "get";
+	else /* (flags & KF_ITER_SETTER) */
+		sfx = "set";
 
 	snprintf(exp_name, sizeof(exp_name), "bpf_iter_%s_%s", iter_name, sfx);
-	if (strcmp(func_name, exp_name))
-		return -EINVAL;
+	if (flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+		if (strcmp(func_name, exp_name))
+			return -EINVAL;
+	} else { /* (flags & (KF_ITER_GETTER | KF_ITER_SETTER)) */
+		/* only check prefix */
+		if (strncmp(func_name, exp_name, strlen(exp_name)))
+			return -EINVAL;
+	}
 
-	/* only iter constructor should have extra arguments */
-	if (!(flags & KF_ITER_NEW) && nr_args != 1)
+	/* only iter constructor and setter should have extra arguments */
+	if (!(flags & (KF_ITER_NEW | KF_ITER_SETTER)) && nr_args != 1)
 		return -EINVAL;
 
 	if (flags & KF_ITER_NEXT) {
@@ -8144,7 +8155,8 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	if (!func || !btf_type_is_func_proto(func))
 		return -EINVAL;
 
-	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY)) {
+	if (func_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+			  KF_ITER_GETTER | KF_ITER_SETTER)) {
 		err = btf_check_iter_kfuncs(btf, func_name, func, func_flags);
 		if (err)
 			return err;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d6306c363b7..51302a256c30 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -7813,7 +7813,8 @@ static u32 iter_ref_obj_id(struct bpf_verifier_env *env, struct bpf_reg_state *r
 
 static bool is_iter_kfunc(struct bpf_kfunc_call_arg_meta *meta)
 {
-	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY);
+	return meta->kfunc_flags & (KF_ITER_NEW | KF_ITER_NEXT | KF_ITER_DESTROY |
+				    KF_ITER_GETTER | KF_ITER_SETTER);
 }
 
 static bool is_iter_new_kfunc(struct bpf_kfunc_call_arg_meta *meta)
-- 
2.39.2


