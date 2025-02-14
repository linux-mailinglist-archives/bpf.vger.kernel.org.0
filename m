Return-Path: <bpf+bounces-51484-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405D0A352E6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCA9816DAA6
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D2469D;
	Fri, 14 Feb 2025 00:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ryAijmhd"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2089.outbound.protection.outlook.com [40.92.59.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872CE17E;
	Fri, 14 Feb 2025 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493031; cv=fail; b=JBxxtHvX9Iz7yCZL0I8qNiXCxh4AIVNCCgHwEJ0UA2Rt7vP06b46w6NLHbFNRhihDTyxqWt7O0UJlOuuQGiqQge3cgMLrVyITBYi3v2tB1WW9fW1jEHRloaBPkeu/eatNamAOkVCQJQf2XKPLlU53JsfoO1kteZBK3W/HOIDiik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493031; c=relaxed/simple;
	bh=4V5fRtJCFPW+Z88o3Ix9DGOKqPb5kh0vZyKNVcPpQTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pyv7Ub2X8RQVMvkOey6NQmMRbjENvdcN8j6fEAbfULBU1Try4ODbfxMekX8/A5pMwI+w1rmrT/O+NfP8Qnfft+c9FFeUP+4o+LCRuOgGIgHUsH52pxkMW8wwt/3jVPcqKtgsucM5d92KD1AIlmmAqitjCoi5eBDKKjjDp+vIEvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ryAijmhd; arc=fail smtp.client-ip=40.92.59.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WZFjDzDBHYvwpsszz8+yX8ENCiZkphRKjgo70L77Hv9NPz+5vymd18uVKf/TdsFAoObjwjry/PLK0+IX4LsNUGm41NTg9YNMKbsFn+Qvy8JhEg/QNLuDfHVQneQYFi+MBPHgH3IV61qOwjKK3qvuH9UwamFC2YHakGlyrfqxGyWaCfABQE14j6n7KpYRzV6aqsFC4/INCuHrIpk3xdQHNd5ypmIf1F9M0FgZ90CWnZ8eyldXxjlziAJDNpp3m5oYn8R7yLvwt7ZimKV4KLLrI/tyIwMCy6LWiV3iTTGT7WbkiuTPAamSOM4//IYpJDGUWjVjuTocVLy70MV3/jA15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c8h9eAWOlNwSuFY9+CZjcjE2yBlZrLhmvuFY03rs+Jo=;
 b=O2PY9nyQBrXCtazm1h9KkeIGiMwGYzNJeKgB8l2igum5naI8xyH5jiO4wifxOUQrq797J1XEHx7DP2RxFvjfKkdl2dBH/tcubnO98Od8ezSKoY9I6Ma3j5mZxzpx7QL89itgjILsdh7jDsqC+U+XTluLDW2nH9fpa3WX74TnggZNKpuw4SMnkFOlBKYHJh4nd1n7gLomLAHtnflUuV1YFhH+HZbS8gb2cfhfSktUumkwl/9AOSVqbWMXwTlhNklR8LSGBvKHwxy7ixDVt9P/vloAk1tvgCsAUAPhDXFmnrivNEQ516loOdKT2NCU7AYRvRPO73gNkMHZmodIzEPcJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c8h9eAWOlNwSuFY9+CZjcjE2yBlZrLhmvuFY03rs+Jo=;
 b=ryAijmhd2D2KgpwpnMACLfpGCaAk8bNuG9Hx11cjYSYto/PKQc7FakbnHd5huoZN22ONDvId48BG7lhSLqiebHp8JV8FIf9JyTz7v5UnGbFkr7DIxEe/PTeJP5jb0ZwcnmtWf86ob+FTioucvf/1R2K7NuzQRZQ2uiP0gtUSs1Pv5yqDnXhk8nzFTd1YF8hLsGD6TDxppTNhS78w1iqZr7dwyyOEpuAm9XCK6Q0gYYmrGPSL8KGCt6emlTvCED85BtIUMJ/jiyLDa8lNlu8y1ttQ8jRD0CSFN+U2Q2EHPyYzRhQwADpbVI1YT0S/yG78Rj/lixCm5t1DDnkLtbV1vg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8869.eurprd03.prod.outlook.com (2603:10a6:10:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:30:26 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:30:26 +0000
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
Subject: [RFC PATCH bpf-next 1/6] bpf: Pairing data structure types with acquire/release kfuncs
Date: Fri, 14 Feb 2025 00:26:52 +0000
Message-ID:
 <AM6PR03MB5080B94AC203180F9148E36599FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cdda27-aa3c-4e35-4e5c-08dd4c8ec68e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|41001999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odpQfxX5P/SIMT2tzPWYdlwIwYv2KXGKtAV/+syYvCAkZNzLKAFWsJ2nIF64?=
 =?us-ascii?Q?MgRofUPZrvhDPuZB2+raOtFgzNveiPHPyf+k6/z78x5tETiNsGNwrMzy8pMu?=
 =?us-ascii?Q?y2P/teo+anWue7bS9MdTZWk8Un3dF07X+DJ6/7scnu0x4Tcl2S9OQKNvo2ZY?=
 =?us-ascii?Q?rP2iEIQD4z6zZCWmXD/+uQXqXpDoAYmOL/kr6NGySQCUOSihd22DO4vfdaZ8?=
 =?us-ascii?Q?UK9fShkmWhO8qZYJlTsepefeXHggfEpkt5sX4wjuZwyhqBCs+0A9Cx1uomjM?=
 =?us-ascii?Q?F8Bvh3AZagciDM1Swq8p59GFdlm7YzCf7npl/J3xuLMJl6u/uVCBFx/1mJZN?=
 =?us-ascii?Q?VbBIRiX+a2KCqlJcKUXNfDUzTXL8w27dD7VIfk9PAEIOq4aGLfvydeZZarlR?=
 =?us-ascii?Q?TqqmoBaBu1lhYLut4AnWbabS+g0n/nsDEhhesagwbAyz7MFCNUFB7owM1m0r?=
 =?us-ascii?Q?3uiOfH31uswdLoXHoGWU6KtSPwL0luaau4ga8r7qgVh3VyLEoecdTJOAw0VR?=
 =?us-ascii?Q?kyyWXbteZVKg4Z2tMsMLQLwwKDkrrdcDkrFoJ9CYRFPfx/xwln4CuJkmEc1H?=
 =?us-ascii?Q?wZ0QAyBqfJAQxXPw7aAwq63rr/PVK7KrJKlrMEb7aUXJE9TqrXX1Dia5auOw?=
 =?us-ascii?Q?/QD4xhemYy3l7Qob1qPXzFm6x7oECpzbUAdY9yUWtW2rj2PLkwiz0qXLmtX5?=
 =?us-ascii?Q?aUAaPjhIUebhGHUN0HmcLzGpZCfH60McjgfTQrKGTpj0nYPUo+WDJb7KCZK+?=
 =?us-ascii?Q?Oc5qYHpkzoRPerOBEs7qeBdlcUUUF7VpJep5Tlde/9FOmsWus566i3r8NHHw?=
 =?us-ascii?Q?OTFEr8Ma5U1+n7AP/4r1uou8B4JwqcWTVXLqVjnPfoIOju7KG9vmID+su6bA?=
 =?us-ascii?Q?uuAzmjTDQPD43CGqzTQrO99+Vuaf8n29Vaw+RCI/nRQ3fPbcwt95zBI/N36K?=
 =?us-ascii?Q?+PoBoiAUypiyDNbIpBMPXBXizwEkYI/tqXZ0tssGiMgFYkCHKbV3qMwRGtp9?=
 =?us-ascii?Q?DQTXzSVieOXm7/Ni/6hhxJ+gFs8FMY9TQcgsI5RZYYrn25K+rkTr+HTSMxh3?=
 =?us-ascii?Q?tp8TWKAY9TnMBGyYal3GHnEBzZ8M9g=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fo6Y2+pXKaHVjoHXf7/pzpgTp72o4+79AN3fw9i/xi+p03G2VWgxvd72Wdnn?=
 =?us-ascii?Q?p/n0cy19C+5pcYXXj4Mr+fIDujwAxxiuS18ciSuT+HFoJP4xoarQdJ7Wfu2q?=
 =?us-ascii?Q?UhxQMvs7fe+Cem0tJ74GM5CjJ5uDQeOIehVwtb5OzonK6QK+nK6NemeE1LMe?=
 =?us-ascii?Q?7URdXWKKkNcLbdBu5SW/CVXsr2tz2NCJpscXeeD9v+tS+Aw/f3ewZoMdE5Ie?=
 =?us-ascii?Q?f1n5frBtoIk+izuGHqEZhKsudWhIuOL6S8hJsqdspUAsPqqD+MXNgZ0oGBuV?=
 =?us-ascii?Q?QeqVaiIkq9h35oye88fxT9eV6q5dDe5G5wWUOF0d1SVKhy2BceZPaHhHH3Vm?=
 =?us-ascii?Q?1lDO6deO6MzUeahquVUtIeYqSJiP0PiQDJpOok8nbL9EMNiW7twjwHOhBRNA?=
 =?us-ascii?Q?NO+iyZo6nAU/KL/0QgcpKdK56BHE4H+G/Lo3yc2NGoJ2FVLMVg3OeYN4D9SW?=
 =?us-ascii?Q?OGzdfna3zZG+O2QBDW6BI/lqj9xL+NmfKh6+sdmf6A9+HdEvS8IwWL0ApHG8?=
 =?us-ascii?Q?CzcSHwYmRfCPKZdSr/L6thFPGfrjxluEWMcK9LGiA84q0CVsrCE4gRcQDhOJ?=
 =?us-ascii?Q?Qkhh/SkCeAP1VuXKdfm2B5hN+JVRXtok2PZqRBN3D9D1t24d8mbB7kUOYqaQ?=
 =?us-ascii?Q?2ddUKCHx67ro/9b4n3BfryOK7+oy0RnQwXpJoP6e3CUnVGgBkA6/uh3KWwyc?=
 =?us-ascii?Q?JvOLjIh3PiS8HHMozm0GfZNCHfYGQWCNCyP1DwkHTSeNkMCgswfiEucWfk0x?=
 =?us-ascii?Q?judeLeSKVTrIGPXKX2vcyTud76yF4lt1dvQeswxgNoBnxf9i3H3Iuyw0m5ax?=
 =?us-ascii?Q?4hWOJc2bgpaLsPLEe5LTBiWxIw6AGEkXWjvqkU+71gX8kgz+5BdzfrBs4uS2?=
 =?us-ascii?Q?UhXhUbOQeMaEBEZ18Yq9gTARvtJFXeQ8+AxZKGo1vgCW2pV6a976wsQBY1VL?=
 =?us-ascii?Q?QHAC9er5QUTvGYhCN8rF+aLCtHORjz/TOe0XTUdqecT8PasYaYyhPylrnpIW?=
 =?us-ascii?Q?pyGUgU5j9TwfzOmlcv6ABgaqZApLoMds31sUmZabUXCcmCQBrKriGVX+2b68?=
 =?us-ascii?Q?HT26rfWUqPdpWDR1LyfKOPNOclDD6g4hD1yeG77MMUCGsHPGTKsepyCX78T7?=
 =?us-ascii?Q?GuzZerqVIrjNlowk0yALuDWI5AM/xmiN021ZQoMfV4BKYs0XDmhgYRC3s5Wb?=
 =?us-ascii?Q?/bZiDhLNvt5cIi73dBNhonmBYF9dz6jk5/AS0rUjAxe28RARbjJE+h4dgd6R?=
 =?us-ascii?Q?KFLuNBI+LffQBQAqRaa3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cdda27-aa3c-4e35-4e5c-08dd4c8ec68e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:30:25.9387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869

This patch pairs data structure types with corresponding
acquire/release kfuncs.

Currently all kfuncs with KF_ACQUIRE have only one return value, and all
kfuncs with KF_RELEASE have only one argument, so we can pair kfuncs
with the btf id of the data structure type that can be acquired/released
to construct tables.

btf_struct_kfunc_set_add is used to add kfunc to acquire_kfunc_tab or
release_kfunc_tab/release_kfunc_btf_tab depending on whether kfuncs is
acquired or released, where the data structure type is converted to btf
id and the kfunc name is converted to the memory address of kfunc.

For acquiring kfuncs, we only need a table acquire_kfunc_tab, the kfuncs
memory address is used as a key to find the type of the acquired object
based on kfuncs when acquiring a reference.

For releasing kfuncs, we need two tables release_kfunc_tab/
release_kfunc_btf_tab. In release_kfunc_btf_tab, the btf id is used as
the key to find the kfunc that can be used to release the object
according to the type of the object when the object needs to be
released. In release_kfunc_tab, the kfuncs memory address is used as the
key. Currently, release_kfunc_tab is only used to determine whether a
kfunc is a releasing kfunc.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/btf.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 125 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 9433b6467bbe..3548b52ca9c2 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -249,6 +249,17 @@ struct btf_struct_ops_tab {
 	struct bpf_struct_ops_desc ops[];
 };
 
+struct btf_struct_kfunc {
+	u32 struct_btf_id;
+	unsigned long kfunc_addr;
+};
+
+struct btf_struct_kfunc_tab {
+	u32 cnt;
+	u32 capacity;
+	struct btf_struct_kfunc *set;
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -267,6 +278,9 @@ struct btf {
 	struct btf_id_dtor_kfunc_tab *dtor_kfunc_tab;
 	struct btf_struct_metas *struct_meta_tab;
 	struct btf_struct_ops_tab *struct_ops_tab;
+	struct btf_struct_kfunc_tab *acquire_kfunc_tab;
+	struct btf_struct_kfunc_tab *release_kfunc_tab;
+	struct btf_struct_kfunc_tab *release_kfunc_btf_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -8357,6 +8371,112 @@ static int btf_check_kfunc_protos(struct btf *btf, u32 func_id, u32 func_flags)
 	return 0;
 }
 
+static inline int btf_kfunc_addr_cmp_func(const void *a, const void *b)
+{
+	const struct btf_struct_kfunc *pa = a, *pb = b;
+
+	return pa->kfunc_addr - pb->kfunc_addr;
+}
+
+static int __btf_struct_kfunc_set_add(struct btf_struct_kfunc_tab **kfunc_tab, u32 struct_btf_id,
+				      unsigned long kfunc_addr, void *key, cmp_func_t cmp_func)
+{
+	struct btf_struct_kfunc_tab *tab;
+	struct btf_struct_kfunc *set;
+	int ret;
+
+	tab = *kfunc_tab;
+	if (!tab) {
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
+		if (!tab)
+			return -ENOMEM;
+
+		tab->cnt = 0;
+		tab->capacity = 0;
+
+		*kfunc_tab = tab;
+	}
+
+	set = tab->set;
+	if (set && bsearch(key, set, tab->cnt, sizeof(struct btf_struct_kfunc), cmp_func))
+		return 0;
+
+	if (tab->cnt + 1 > tab->capacity) {
+		set = krealloc(tab->set, sizeof(struct btf_struct_kfunc) * (tab->capacity + 16),
+			       GFP_KERNEL | __GFP_NOWARN);
+		if (!set) {
+			ret = -ENOMEM;
+			goto end;
+		}
+		tab->capacity += 16;
+	}
+
+	set[tab->cnt].struct_btf_id = struct_btf_id;
+	set[tab->cnt].kfunc_addr = kfunc_addr;
+
+	tab->set = set;
+	tab->cnt += 1;
+
+	sort(tab->set, tab->cnt, sizeof(struct btf_struct_kfunc), cmp_func, NULL);
+
+	return 0;
+end:
+	kfree(tab->set);
+	kfree(tab);
+	return ret;
+}
+
+static int btf_struct_kfunc_set_add(struct btf *btf, u32 kfunc_id, u32 kfunc_flags)
+{
+	const struct btf_type *kfunc, *kfunc_proto, *sturct_type;
+	struct btf_struct_kfunc dummy_key;
+	unsigned long kfunc_addr;
+	const char *kfunc_name;
+	u32 struct_btf_id;
+	int ret;
+
+	kfunc = btf_type_by_id(btf, kfunc_id);
+	kfunc_name = btf_name_by_offset(btf, kfunc->name_off);
+	if (!kfunc_name)
+		return -EINVAL;
+
+	kfunc_proto = btf_type_by_id(btf, kfunc->type);
+	if (!kfunc_proto || !btf_type_is_func_proto(kfunc_proto))
+		return -EINVAL;
+
+	if (kfunc_flags & KF_ACQUIRE) {
+		sturct_type = btf_type_skip_modifiers(btf, kfunc_proto->type, NULL);
+	} else { /* kfunc_flags & KF_RELEASE */
+		if (btf_type_vlen(kfunc_proto) < 1)
+			return -EINVAL;
+
+		sturct_type = btf_type_skip_modifiers(btf, btf_params(kfunc_proto)[0].type, NULL);
+	}
+
+	if (!sturct_type || !btf_type_is_ptr(sturct_type))
+		return -EINVAL;
+	sturct_type = btf_type_skip_modifiers(btf, sturct_type->type, &struct_btf_id);
+	if (!sturct_type || !__btf_type_is_struct(sturct_type))
+		return -EINVAL;
+
+	kfunc_addr = kallsyms_lookup_name(kfunc_name);
+	dummy_key.kfunc_addr = kfunc_addr;
+
+	if (kfunc_flags & KF_ACQUIRE) {
+		ret = __btf_struct_kfunc_set_add(&btf->acquire_kfunc_tab, struct_btf_id,
+						 kfunc_addr, &dummy_key, btf_kfunc_addr_cmp_func);
+	} else { /* kfunc_flags & KF_RELEASE */
+		ret = __btf_struct_kfunc_set_add(&btf->release_kfunc_tab, struct_btf_id,
+						 kfunc_addr, &dummy_key, btf_kfunc_addr_cmp_func);
+		if (ret)
+			return ret;
+		ret = __btf_struct_kfunc_set_add(&btf->release_kfunc_btf_tab, struct_btf_id,
+						 kfunc_addr, &struct_btf_id, btf_id_cmp_func);
+	}
+
+	return ret;
+}
+
 /* Kernel Function (kfunc) BTF ID set registration API */
 
 static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
@@ -8453,9 +8573,13 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	/* Concatenate the two sets */
 	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
 	/* Now that the set is copied, update with relocated BTF ids */
-	for (i = set->cnt; i < set->cnt + add_set->cnt; i++)
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++) {
 		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
 
+		if (set->pairs[i].flags & (KF_ACQUIRE | KF_RELEASE))
+			btf_struct_kfunc_set_add(btf, set->pairs[i].id, set->pairs[i].flags);
+	}
+
 	set->cnt += add_set->cnt;
 
 	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
-- 
2.39.5


