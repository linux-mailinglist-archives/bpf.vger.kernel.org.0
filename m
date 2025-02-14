Return-Path: <bpf+bounces-51487-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5070A35301
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29864189054D
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D64523A;
	Fri, 14 Feb 2025 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BuLkp5tp"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2107.outbound.protection.outlook.com [40.92.58.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C21A17E;
	Fri, 14 Feb 2025 00:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493369; cv=fail; b=Nko12Q5HbR16VwcYidXOYOtXolF5ZAeLu4flNMfg79rAS/KYI3PNUhKvg2fM37ZTh443TuX39PO6KFyyBTCWg2ax2UbgmoBlvHNcs25eo+zEpgK4Vg8Max4up9dk5b7HtV3zVBdULX2tpkGIOEkB4xArA5MjZRnpiFjifd8W9po=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493369; c=relaxed/simple;
	bh=e4p3PeZyB8cvPxX32hj0dA28u4inhIt7RFLAvYB4J+k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WAkzvvY1pJagly9C5cPruHOco15531wBbF0Cwj3nlW/b7yi6osF2qHuJ6xHzDggekAcBtO54J7d3DXuyOOOr6hfAkmPBNznQeMgir8SmdUCwdvxPIvtJiMp8bDt5t/27nO46TeL5v/gH84al5ygK29EriOtUujR1mXjEwQ112jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BuLkp5tp; arc=fail smtp.client-ip=40.92.58.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0hXTYpWzP52BhVwfuor87nG5rCqwvDM32tRBSa5uz/dxzcBU2F4BU0EbAvr+Qkra4RJHvjL8rIfnDhQXXCcnS2AcoKS1BU0yi63Eev9j66At2tm8LTuoHlhC07xVhVPU8f/1aEBKreVzsT3FmiThfXbVY5tV3VW2HSpbcFxsf+pT0MPOuQ3MDXTtGT85lkqg0RrzCQol84G2D0ZlWMp41idEu1XosrvdyLw8+iEbdeiv29RaP/VM52dpIn40OIrHwetBJyXZHJPcvIsah7fd5ZCf2MDrKgarGaMZEe907Yj0IbsoDIkwnU9fr5A6N6h93fiU+LK2tNE8vzmiX3EBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfwD4HQD4UcnWnBQz/K1V8zcIvmPD7KuyxTcWwPf9V8=;
 b=GYSTp30HrG/wZE1kOK7S2rAVIgirUDp5wAcx/Ou3veXGH/tIQG7f2lRf65ROZGfaUKhrEkpHmvvGBP5fsoT1sUMtSLDPaRuu2IDaczpf2B/BQGl1hlri99aw7lYaQo7o6u6vB5ir8izrmD2Ro74Evxt814U867pGbzAnwDvvn3R9WZtb9GVVziFhg7+PVM0YMEceTr7AlJtECw5uuZnyIdiTRu5UzkOioeSktQR6/0U7bs5/gnpkVkD54rhXYoKu6KoiDaPwlnx2X2aF9c3JLpnrDj+NzoYDZHsyp147hxkemPOLwkyP6t+hEIinNsxbrjuNjLGb28q4MK5g4bjPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfwD4HQD4UcnWnBQz/K1V8zcIvmPD7KuyxTcWwPf9V8=;
 b=BuLkp5tpnghgVhhfZjO4lkoKpLoJXO2MdcowpPNPQdtyDaIDQl7gV6sToP3SPCt5gsHk7khQ+3QOZn84UxQs1rFCp3aY0dWIMPHTdX/106h1i2A6TtaU7MUDX4lpnXti4lbnuu9dY1Xn+R2t6zsY59cfZpzpJa29voxq+A+EfWvI/uEWqbJ8psPD+HcBQvvENT6/PYtUTb0lKunCIDtnkG08KhTbClpD/LxrTrSNrP2Uo9nv8F1DFhrr4na/MOiHpKLnjz33ZygzceAZjT3KXs95URN3lDRcE+2vImSxZ2/ELYnob5JVO5xNbayon9pr4zCRBf/NTe0VdOXIXqMQ9Q==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8869.eurprd03.prod.outlook.com (2603:10a6:10:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:35:59 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:35:58 +0000
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
Subject: [RFC PATCH bpf-next 4/6] bpf: Add bpf runtime hooks for tracking runtime acquire/release
Date: Fri, 14 Feb 2025 00:26:55 +0000
Message-ID:
 <AM6PR03MB5080FFF4113C70F7862AAA5D99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-4-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: bdc060f8-06c9-42a1-ca76-08dd4c8f8cf6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|41001999003|12091999003|13041999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bwjhygHa4Y5HrPnk1l72SBstz9eHIEnaNxHcfbBFzNIVNjo3K8SNFaVL+zeu?=
 =?us-ascii?Q?g7mf4E5j12ouOM8iurbBedefTZC1cK7rplB9hhT4xxMzTXM8YiQ9xUQVJpqc?=
 =?us-ascii?Q?ad/ZaoPSNkcGejQEn6Egy7gVzbp/TMg7YYnHesJSLlg1HeNZqI9voW9XMXrQ?=
 =?us-ascii?Q?64kYgChGy60bIXb4gFNhJlMGxkqtv5iuc1vPHoOfI4/l+MXaBNc6fryzkqS8?=
 =?us-ascii?Q?pJVCme0c3MDPQVfrAnSxdNKryPd2XHPLcTcNGZYn9vqIaRUWyd77dw3p1dRF?=
 =?us-ascii?Q?Rrotx4qriM2KM6FUmc7nil5UkwT7JgYnqhzGqhe+5ETM+pvTslwO9//bQZx8?=
 =?us-ascii?Q?5PwdmeifTWoJgYPlp56H7hqF4y2iS/OFPgSeG1wRR8smoKuWDNZ1TKhuQNOY?=
 =?us-ascii?Q?lMegS1LKleitNS6QMFJLT8tLBACCfxc1h/yDtt5A185yjlMound9TtB9s8yq?=
 =?us-ascii?Q?sHVSJHIPTQhsLDCv0lFQw5OzTPDnm8wJmaLRVQNTIOXoLxO9COqg8ouRtM5j?=
 =?us-ascii?Q?TiEfp2IGLiaowrjT6GXMQAvF7eiNo8mJ8ZgFQm9U0UMW9oXmETy5HCgeAI0a?=
 =?us-ascii?Q?c4EkHTkO0YhR1XaSAOhy5WM2aVketgsy2+qQN7VwSsvl6N2Vng9ibN5zaZi6?=
 =?us-ascii?Q?HpfWJvpsdjrQD+8J70ZjU3cX4pHVB6SV2DpnSP0lE9XBMA8ZkLI/NRCUk2+Q?=
 =?us-ascii?Q?flydSmu9HoDOhqAsOs+Mq9PZDPb0neUwyOS5WgxuQVB2wV0Eu8aSUk/JnWIK?=
 =?us-ascii?Q?EOhcEYFh8iB/I/zWkkqEFR1er4tDhhB5jbg6z1IlzdhpTJpiAlNjmCGlxC/P?=
 =?us-ascii?Q?rLzgXddiI9Bf8XDQTb54CbTr3C0lPC2QmDXA0xI086J30zJckrgJ/Nk45Ufs?=
 =?us-ascii?Q?bZpBlZINn1Zan3Y2xvgTTILXiofhJu6hqgdfqiwyA3QqR3kH0luNLDjWORsz?=
 =?us-ascii?Q?zqvxZG6hMhmOfXXOSnvM7cHTXA+R7P3LaWosHnTPXYGIv2znlqeQIzjNuqaK?=
 =?us-ascii?Q?gwx+L4THZrWVLUkQC4R3KXgrjhX71uI+D4cNrzyPsv0cOFze7GiqbStAeD+4?=
 =?us-ascii?Q?Y4TbNIsqwjHiH+wgUiS4zd9LWfA5qKv8O9dTVZlZAkYsGNLp8qDNuJWh8IBw?=
 =?us-ascii?Q?z7PtH32ncJ7M57Cml9uBLCvFOzDDPAuiSA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F+fXGpJzYjEb9Ddlp4tOQ1YvapvgSZqXhUAQIJllz9iuNs+kpdIcfVryGwel?=
 =?us-ascii?Q?MtrFYcSdG71BQZg9PEDtpU9AVoSCJb+bnBdUPH6fMtXew3/cPvtB++KygkuW?=
 =?us-ascii?Q?hQh3XN0vNBgfbKni7lw2dFAsX/IeRiC11Z803058lRh6Xb2Jqe1DQqxL4oOi?=
 =?us-ascii?Q?oqRzfwfP43Yy7rAj0NJHHkFNWguzbkIGNz8ALih4CfJcog8yGJTKgTb92S2U?=
 =?us-ascii?Q?tIMw9UX6L11kvF71i7ZeJZ+FZ14SHOEi8SPw24UKRkvHLu/2wSAcuQentWYR?=
 =?us-ascii?Q?eDFMLKkdh7Crg4f+LE8JKEA9jRhJbz2QoRoQmJaboMEksvmQ2vfwl4Ege0JA?=
 =?us-ascii?Q?ug7uVLyPtZRc1ck2N/fXnQ+Q3KCZVHmMIXtGzndoJ/R297wBR0NlXtyeYTVJ?=
 =?us-ascii?Q?6KUZNLDUbWNKhuEVw0FTSnFHSeF1kkAR3kvd1A29vbVsy7DUKQiorfo51gHb?=
 =?us-ascii?Q?tbYHqohZp+QhSGFZOzmLR+HMpzvp8ilPjqc0ONQJsueSgDDknr3j0zmL9JIa?=
 =?us-ascii?Q?yFmKCc5LByxmW3XIqHkDzfNSWdHItir2zoiRZkxrWwtHMsievH0ceLRDmzOz?=
 =?us-ascii?Q?z8O2Vi2kQxW/6qD2aIPeSM7tAfuI55gdRsf8YexuHCN/HeL4uwwulCM3Crco?=
 =?us-ascii?Q?8vGKqd54WiNVpQEEmGU+Vf5sC6j5T+7jXE037rXZMgpPbuV7trqFHgXrrVts?=
 =?us-ascii?Q?krsIk214ELM6y0F4jqIqVOzhYkgBoBi0NFukS38aLiJFPxK8K10KbHsSvHda?=
 =?us-ascii?Q?p05YsXrC/NcJ5g5zown5Tb3W8e70qny1CnDoCskRKYKhy90ccykk2xLEzIE6?=
 =?us-ascii?Q?VEhw6dN3BgTiyejhs5iTbqmET5f8aDSmOdcPSwwkVIxP9MgQf6ytVqZJeKbS?=
 =?us-ascii?Q?Jeo1nZIEwfZQOoN/gGiHQEgG1wSATwuJdh9Tj5xTPy3/pVZZqvJnI0pvnH6Q?=
 =?us-ascii?Q?hhr2VrabqS1HcB/VIHWDfF/8ycoprFQUcJLTS3LGLk84Z2HKd2XjiG+Cs320?=
 =?us-ascii?Q?LlFK3PreSsCoom+xr2xtNOJviRZ/0+ITeBUUTE0akbx5Ol/apCDBj3Yxu4Qv?=
 =?us-ascii?Q?1VnP7s5ypK9k85q4EM/uKNov5RWl6HbcSWgPEWfuG1t2SqtQYBe01Yl4geyd?=
 =?us-ascii?Q?sMGQuC8U4F5+F+3R3HAO22aoL0bVEIhRF6VbT1oQGYGrNkK0+0sycRxvpBaS?=
 =?us-ascii?Q?xFTCmv54q//VIzbCTNIR6AYZ0t7a6G1X0MeQdKv4TXkwo5W5E3CuckOpCVAf?=
 =?us-ascii?Q?sxcBYAY2COSjE4JzfUMT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc060f8-06c9-42a1-ca76-08dd4c8f8cf6
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:35:58.8324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869

This patch adds runtime hooks for tracking runtime acquire/release.

According to the bpf instruction set, all functions can have a maximum
of 5 arguments. The first 5 arguments of the BPF runtime hook function
are used to pass the original arguments of the kfunc, and the 6th
argument is used to pass the memory address of the kfunc. All bpf
runtime hook functions must follow this calling convention.

bpf_runtime_acquire is used to record the information of the referenced
object to the reference node, including the memory address of the object
and the btf id of the data structure. First, call the original kfunc.
If it returns NULL, it means that the reference acquisition failed and
no record is needed. The btf id is obtained from acquire_kfunc_tab
according to the memory address of kfunc. The reference node is taken
from the free reference list and put into the active reference hash
table after recording the information.

bpf_runtime_release is used to take out the reference node from the
active reference hash table according to the memory address of object
and put it into the free reference list. Since currently releasing
kfunc has no return value, bpf_runtime_release does not need a return
value either.

print_bpf_active_ref is used only for demonstration purposes to print
all entries in the active reference hash table.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h |   4 ++
 kernel/bpf/btf.c    | 108 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 112 insertions(+)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2bd7fc996756..39f12d101809 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -567,6 +567,10 @@ struct btf_field_iter {
 };
 
 #ifdef CONFIG_BPF_SYSCALL
+void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
+			       void *arg4, void *arg5, void *arg6);
+void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
+			      void *arg4, void *arg5, void *arg6);
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 3548b52ca9c2..93ca804d52e3 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9532,3 +9532,111 @@ bool btf_param_match_suffix(const struct btf *btf,
 	param_name += len - suffix_len;
 	return !strncmp(param_name, suffix, suffix_len);
 }
+
+static void print_bpf_active_refs(void)
+{
+	/* This function is only used to demonstrate the idea */
+	struct btf_struct_kfunc_tab *tab;
+	struct btf_struct_kfunc *kfunc;
+	struct bpf_run_ctx *bpf_ctx;
+	struct bpf_ref_node *node;
+	char sym[KSYM_SYMBOL_LEN];
+	int bkt, num = 0;
+	struct btf *btf;
+
+	btf = bpf_get_btf_vmlinux();
+	bpf_ctx = current->bpf_ctx;
+	tab = btf->release_kfunc_btf_tab;
+
+	pr_info("bpf prog current release table:\n");
+
+	if (hash_empty(bpf_ctx->active_ref_list)) {
+		pr_info("table empty\n");
+		return;
+	}
+
+	hash_for_each(bpf_ctx->active_ref_list, bkt, node, hnode) {
+		kfunc = bsearch(&node->struct_btf_id, tab->set, tab->cnt,
+				sizeof(struct btf_struct_kfunc), btf_id_cmp_func);
+		sprint_symbol(sym, kfunc->kfunc_addr);
+		pr_info("obj %d, obj addr = %lx, btf id = %d, can be released by %s\n",
+			num, node->obj_addr, node->struct_btf_id, sym);
+		num++;
+		/*
+		 * If we want to release this object, we can use
+		 * void (*release_kfunc)(void *) = (void (*)(void *))kfunc->kfunc_addr;
+		 * release_kfunc((void *)node->obj_addr);
+		 */
+	}
+}
+
+typedef void *(*bpf_kfunc_t)(void *arg1, void *arg2, void *arg3,
+			     void *arg4, void *arg5);
+
+void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
+			       void *arg4, void *arg5, void *arg6 /* kfunc addr */)
+{
+	struct btf_struct_kfunc *struct_kfunc, dummy_key;
+	struct btf_struct_kfunc_tab *tab;
+	struct bpf_run_ctx *bpf_ctx;
+	struct bpf_ref_node *node;
+	bpf_kfunc_t kfunc;
+	struct btf *btf;
+	void *kfunc_ret;
+
+	kfunc = (bpf_kfunc_t)arg6;
+	kfunc_ret = kfunc(arg1, arg2, arg3, arg4, arg5);
+
+	if (!kfunc_ret)
+		return kfunc_ret;
+
+	bpf_ctx = current->bpf_ctx;
+	btf = bpf_get_btf_vmlinux();
+
+	tab = btf->acquire_kfunc_tab;
+	if (!tab)
+		return kfunc_ret;
+
+	dummy_key.kfunc_addr = (unsigned long)arg6;
+	struct_kfunc = bsearch(&dummy_key, tab->set, tab->cnt,
+			       sizeof(struct btf_struct_kfunc),
+			       btf_kfunc_addr_cmp_func);
+
+	node = list_first_entry(&bpf_ctx->free_ref_list, struct bpf_ref_node, lnode);
+	node->obj_addr = (unsigned long)kfunc_ret;
+	node->struct_btf_id = struct_kfunc->struct_btf_id;
+
+	list_del(&node->lnode);
+	hash_add(bpf_ctx->active_ref_list, &node->hnode, node->obj_addr);
+
+	pr_info("bpf prog acquire obj addr = %lx, btf id = %d\n",
+		node->obj_addr, node->struct_btf_id);
+	print_bpf_active_refs();
+
+	return kfunc_ret;
+}
+
+void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
+			      void *arg4, void *arg5, void *arg6 /* kfunc addr */)
+{
+	struct bpf_run_ctx *bpf_ctx;
+	struct bpf_ref_node *node;
+	bpf_kfunc_t kfunc;
+
+	kfunc = (bpf_kfunc_t)arg6;
+	kfunc(arg1, arg2, arg3, arg4, arg5);
+
+	bpf_ctx = current->bpf_ctx;
+
+	hash_for_each_possible(bpf_ctx->active_ref_list, node, hnode, (unsigned long)arg1) {
+		if (node->obj_addr == (unsigned long)arg1) {
+			hash_del(&node->hnode);
+			list_add(&node->lnode, &bpf_ctx->free_ref_list);
+
+			pr_info("bpf prog release obj addr = %lx, btf id = %d\n",
+				node->obj_addr, node->struct_btf_id);
+		}
+	}
+
+	print_bpf_active_refs();
+}
-- 
2.39.5


