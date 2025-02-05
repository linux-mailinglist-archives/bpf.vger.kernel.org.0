Return-Path: <bpf+bounces-50559-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83193A29A2E
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0986C163BBD
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30CA204589;
	Wed,  5 Feb 2025 19:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ArXau5H7"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2040.outbound.protection.outlook.com [40.92.49.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715811547F2;
	Wed,  5 Feb 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784101; cv=fail; b=o3R4lPRRvVoTx9ilHTqSZQCZpaIMEJC3/rIyq2qtN7N+H8APhAcig1TFnxFL30Jdo2tmpHkt7h4YedeY/TuCyPVGKcUbOaAyt6qbZXvpMwn3uQ/af4eX+kKpIlZ0u+fdpLz1UaWtSZlPUtxmwL7vxvnz8Ivuo80u/3tSwEYZvOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784101; c=relaxed/simple;
	bh=MDeRd+98KN+G5GVPHW+R+9odPAvjEiRvkK+NERuReGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mDPFG6zgJZ8KgU2uZ+u9NLd/NdOYYzAL3z3S4RQNbRIBB0ZLjW0CsuvlhVwFPGnNb9ZWGaEhebED5aExwu8NLQBs69vZVyL9O/z/vJrRje79bxcl2SzzhR3V6Dy0urPBlvQj68Z8cHczNP5Z8V4MF8rSMHk57sv+wi9Zsh79LuI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ArXau5H7; arc=fail smtp.client-ip=40.92.49.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=we6he5CJs1ivigEfo3unrw3MV4X2Eqe/8iuBDF3DQvURxXRAGHKfvsUmhU4PUZgyDTfLSMv2TnZMwP4eV05bewL7rkcWb+sr5SDsvShzYy0axANaaIZr3Lj6J7AVmdUJp3Wx6pSY/FfIiTH2cd/1s1970y1TQKMiB82XXs/MwWjI8An/ZUJ9fwizecfXPtsi1YQh1I1JAlE9W0+G0iBcHRRsgORGHPX8FWHb5KiXe1Ygoxbw8pMmdk5qqWHp5VpDv9rF9TdsHALfq59Gvw58/Z4/HfZB2NKjTsGRu1V+mZsSAv9wGBaZB5jImwIGAF1gqzLQGpD4kEIRV0bvwOPJjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wr0P8GKWNGhL9I3nk339jus5q847ivE5hjA+9RK9uAY=;
 b=ZnAyVs01SnFvlCvXHSwvDPpr2NJytTpvJU30ucYB2wAgNH03d8yjtwgg+e90OvsfZiFFUpGZRE37mVGwSlpdL0SzEJqFZhIwHOlwpAU03rXepUnDWkh0UdVQ2kbMoVHZDJA/PFpm/TafLRFq2jxslbPfXCes1hIrYF7aGcNUJirCzvymVeZQjo9ZYvs/xp0egrszmZUEiFhq+LqJ2oaZOQrne6yX9tr10soRxPaISXSUCIHYeZMVNOpj0Vbc+RKqtx9e8kLqITUL24UL6Xzq/HLbAVNEZVQ5MxJ5LSbXHybqeGKEcoVnBx32iD5/McJuuM4oB2jzyPXNJhNBEVENJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wr0P8GKWNGhL9I3nk339jus5q847ivE5hjA+9RK9uAY=;
 b=ArXau5H7WHUglyRYm42aR05enqIjGTQlSLNP+qj58ncsZQgO534M9ejnE1VY0nnUSkM50DxyqruU6jc4CiDbJB3Y0yvMJY85b/31RM7Gw6Muabl2q3UpmPe49Kjb/gl6AW5hFlRxddBO63vWz712wn1B/pHTN3vB9QHkaKsdwGxjmqjB/XAKD6pBtCdCu1iHdyBd2wkEL100Av1htMZ+JqPKhGqeiwqN++3Y/GZjnhv6ghc8z379wdyu5Xw3REj/ejs8lGGeLvs78Yb6Ip2mY0qTF/uIgJAqbGZ2ipcBHZL0TgK/4j4Lj1WLBGTRL2Madr8mutG2otvOKUM2IRBgiA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:34:56 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:34:55 +0000
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
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 5/8] sched_ext: Add filter for scx_kfunc_ids_cpu_release
Date: Wed,  5 Feb 2025 19:30:17 +0000
Message-ID:
 <AM6PR03MB508024584949BB503B9BC44399F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: db30c9a3-8980-4cb9-0421-08dd461c2b07
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gFw0hZLOxe/dR9jTqVajtXIs7+jGDgBcsTr69S7u3qxz0bC2KbujmCNbZjd2?=
 =?us-ascii?Q?WzeXbcDtouuTmD70Z5ORO/HZzie/Z1rqcNwb+ySZ6jGCq8Kv/wKibSORoBjG?=
 =?us-ascii?Q?LILEjt788Gzz9ocflNLPpASfheXT0VJrmthp8rFtfEChsVEDcD00yA4UTWZs?=
 =?us-ascii?Q?suIZyydN51uKauHbAGAMAUPczHBbjfgMbCr87f8a4AEyQikcUhoHeTAuXDG8?=
 =?us-ascii?Q?/5gotmgFysLJrVIOGlTVg3dDcTNVlaC2VETn8mL0s8xRrfg1brxaAP78A24h?=
 =?us-ascii?Q?6fCVkYFD7SS1Q9pAvtas5EA2Tv6J1R9EyQrhtOtPB1tTMj9+/rZIIAWqv7dK?=
 =?us-ascii?Q?6KywfsiJhpDCywvSrJHFdIyd4AabbCwO8N2oxe8qAwD08v8xMG113gj04k6G?=
 =?us-ascii?Q?U9Kq3tfcXKqBthDcwLifgDyc9jHHkAMwxlUquF2bO4v1m9Y3vftYuGNRG2tI?=
 =?us-ascii?Q?KaTf9ULQzQHeYWYooP1Gty+be4d6PMZZuTlu+bbgHoydMyzMxsJEmjRIfqmq?=
 =?us-ascii?Q?yVxHGJcUDD8hA1ON8c9f3n93T+aSpmnPqbbadPP0yZF8idRuo9nW2ugCQSwg?=
 =?us-ascii?Q?jGtUCTqu/9aTWC20o1LdtW/sbs6KVozJ12JzyvmV6a7kSR0trIGnIoe6YLqX?=
 =?us-ascii?Q?PUBYLbLzeIOa+ZBap9wbzDB3D2WRjg24dAscKrMD/Un7T62zHCaShVPURDeU?=
 =?us-ascii?Q?32aFwZUb8ci2uNbK8s8/WOt+ht+IRsUxaqOwN+NBJrQ9iYsCr4CJVQdYUxtJ?=
 =?us-ascii?Q?5Zu/hh1CPH2IE5kh52ipKGsAWXSHiBy3q7UFjbhYbvgTpIpsRZrUSUC01jUW?=
 =?us-ascii?Q?iuFnGLaC3FwMjToxUeedybQNPcMeTItjmRct+wW9vSqpPDwhBoPNLNSza4g2?=
 =?us-ascii?Q?p+fUBPGhbJgQNMTXqrfdNCFxKoQ1iDsRjgV3J4e4uhTMgZLtLybYQT9YIgD7?=
 =?us-ascii?Q?woGRHejsm4nTmeH8kbbyW2pgZifn9khZ94/9/CgmSVBigQBUuEyWZQmTDkMs?=
 =?us-ascii?Q?HQZ5v4p0LacNpIcPVGDghM6hJy7VIfWxcQbfXzaavsq26Z1is+X6JAtbQ02e?=
 =?us-ascii?Q?CI8YnDUyqkXki2px0PxxprqNtZA0VQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?08Hcw/awxWpnOshZGVjbGck5JwJYET9aPJBAR+g4MwQkzHB49qjmW3RLm5bI?=
 =?us-ascii?Q?uNW9wTgNauLOYKgZDBydBd9fVCX5nkJo13glUfIif+xYXOtkgKHmq0soNVxY?=
 =?us-ascii?Q?EraTdUviZUehHWJAtiWczLlwed3Dd2SSQIa0sYbwtSw41MxRjdQuiDdbaKLW?=
 =?us-ascii?Q?/JKrmEnhhQ1mF87utUKFZ8S65RL3JymDU7IFu8obEh6uH4+OyeM0+O9gmC6K?=
 =?us-ascii?Q?2LhkKi4vtwPz+TLH6X3t27/tOefIuGzkLRrXAnANpKsPMC24JZxEsxmx+eQv?=
 =?us-ascii?Q?ZX6KTIcCl6rDE9TKBYzBVHW8TIppkhoguNklGA/7RILDdzk3GwQMyCDX0Zx1?=
 =?us-ascii?Q?uShisReAJOCaSb5WoaJv/B++c9h+1F2+8S1b0v2vnS7XzPsZv5MhxZDPiK6P?=
 =?us-ascii?Q?k0WnJZFk57S9rj8FpzxmDNkyrtCMzXLEB4oN5cfv2ayv6I4MIuHcHmej6xln?=
 =?us-ascii?Q?xuRvb/2vb+5AHDHIXCXDLLGerVeT3MWF2LaHCSwKJcNrvjxcEvoehPFHkE7f?=
 =?us-ascii?Q?kXSUKI7hSVa1pufjvLbpECl+5lLBJC2jB1MhYo/8hCX0SxSNrOZmBGZpLMDe?=
 =?us-ascii?Q?iJIE7wQzFm+JUsEdYuB2V5Gc2Xw0LNK2lvuPnJxMjCHbad9nhyLkiPOfC73p?=
 =?us-ascii?Q?5xXD4yGzop3JHXJAMBJ3IzOtkLHHEcG7F65E3fqVACK31fiZm0Jdz2vt0dqV?=
 =?us-ascii?Q?BpNgbw+8bo2JWLsfAqynUmhto5Nk0oCMFtzuuhU+77exVlE4w/9PlLFh6F27?=
 =?us-ascii?Q?SDpxO4RovVVcnQ2Xs65ng1yizkGScc07yG0WNxDSgtj28taKlkynNXniqR5Y?=
 =?us-ascii?Q?8UjpPoVaeJZWfBHDIdxuqbsQH7m+8XBqE3SdmxYlhKVy9kfH2SgjD+evSBRr?=
 =?us-ascii?Q?kRUnjPgj0TNzZLaDKFR55W4T7EyKXdxZi3jsP9g740qNANFreEOHAaJtACv/?=
 =?us-ascii?Q?Qi6lUXfoYu7wzusNzvTBT07TheJE1CQOiaj7bfCbGdmvkcPyecXkVCuztT4a?=
 =?us-ascii?Q?Z/rPD9XGqUjcKB+/c/dnMlQc+SFMw0lOXbj6130tNzYGbjm0m9ccQgQYtW6Y?=
 =?us-ascii?Q?JTzvQWLF2txKzJlwyKz76gy4mFEgbYVZ5KmrSwUkbLSi8TXb2g/AW6oSUL7g?=
 =?us-ascii?Q?kBICQ9JWf/lssr2lHSwfXeyXZMSMrZjRLAX499AJI1g3kU+LXdEcMH3ncVZE?=
 =?us-ascii?Q?2ii0hPhgTiXvX9oEU7xzlLU4ZKygOT7tY+8cs31CTzA+q5H6e5iA+YOmsvD+?=
 =?us-ascii?Q?iOzTi2549l7K2K9x1rwS?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db30c9a3-8980-4cb9-0421-08dd461c2b07
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:34:55.3420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

This patch adds filter for scx_kfunc_ids_cpu_release.

The kfuncs in the scx_kfunc_ids_cpu_release set can be used in
cpu_release and other rq-locked operations.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index caddcf41e5f1..7f039a32f137 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7026,9 +7026,25 @@ BTF_KFUNCS_START(scx_kfunc_ids_cpu_release)
 BTF_ID_FLAGS(func, scx_bpf_reenqueue_local)
 BTF_KFUNCS_END(scx_kfunc_ids_cpu_release)
 
+static int scx_kfunc_ids_cpu_release_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_cpu_release, kfunc_id) ||
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff == offsetof(struct sched_ext_ops, cpu_release))
+		return 0;
+
+	return scx_kfunc_ids_other_rqlocked_filter(prog, kfunc_id);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_cpu_release = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_cpu_release,
+	.filter			= scx_kfunc_ids_cpu_release_filter,
 };
 
 __bpf_kfunc_start_defs();
-- 
2.39.5


