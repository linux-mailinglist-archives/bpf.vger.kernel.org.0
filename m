Return-Path: <bpf+bounces-50560-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2DFA29A3B
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2933A608C
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A7D208989;
	Wed,  5 Feb 2025 19:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mhLfbE06"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2071.outbound.protection.outlook.com [40.92.48.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1D92046AA;
	Wed,  5 Feb 2025 19:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784158; cv=fail; b=YCL6CCUcXx6ob9MxIIV4k5r8O30XUve0tky2teJGwB/7uf1Gq7SW4Ho4cmZ7mQ/lKe+0ZTdke5AdJSiSAFLH5g5lA5OJa9E0LxBgiq7QtCsjc1z/AD2MZ58CoQNaTZPOBKxsntOyCA6WgwKrbmyYD+pJ6teu1VRapTY5B2WmE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784158; c=relaxed/simple;
	bh=vLH7ltSfTPVTQtRqwyt7nyi4crnKTUzYgzbiyyy+C7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N8MoUlvF4bAixW0vA7Zw5y2KM3WNsfsIpUKM4u7HPP2cekP58r4F5tyOCfX5eMZrjDngDtvrTp4Sh5HryqFw80D8/ESjmUhKrpkrKZT8GfQzWqGzcyRUzhTmvY1cZpfXXtZFiZfF/dvUNNell0OZ+TiaWwVsPdtE+gWmbDwmpzQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mhLfbE06; arc=fail smtp.client-ip=40.92.48.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnHEemVoDnFaJLQE04IDsctzwoGrZmHZplcOMiztvTmWqtbtDC09XUOjuCE5SjjTyNmO5Qt2LeJ9X0kLU1WlM712hPIx0cLGYiOoX5Ra1UR4hhYkmggTiWi0NmDo8bZTM5ekIkaG2mLDmBhzu+313goe/tkXfM+nmdRv+F031HEc9kFIVHL26B3gFqJ3U0ETwdubqxgYju26EcUJavFT/akBa5Jq6+kbHNrIFAcxFpCwd4VHqtiLTEbVk92AENh2qHPdtT6jRgvyj9rgifV9jtYVo4ZTwKW2CdkTuy5nwxxf8oJFKv0xVh+hqGaYgmKJojSIVPpxy07dJ2EFq/sIYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3LBxm2Iw60ClGg/YKTfRKv6VK6Umf7tABvBvVW+4t08=;
 b=rdlv/gX3llpQ0s64dO3cnKvaqynOBjLATtRESuMC27tobVcS/ziK672qDHhyatc7RFbEjHFXB5VcwLMft8qhkYDkH7ibGLU7ouV6y10/TgXxV1C/NqZXTNjjcuX1+fj0vrVjII7a08UmuOmNJmO1H3zwhwqWCLgoPn1FAY20ypUZ+faN4w59rJlZ/BjqtLPPd6c3DzCefBrv6H28tQZ6VTX4lvuvPs0llacqIGKy+0Q4on1KIHCjlvz4FjAeH5ksn4GSi2F3ozCMv7uYpjx1Ow0D2NCJQejO9EbWg8HTJx0KEp1gJV8vLXE860RYHDo3wN0r/axgHd+VjOxvXGCzmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LBxm2Iw60ClGg/YKTfRKv6VK6Umf7tABvBvVW+4t08=;
 b=mhLfbE06Lo9A1XadaECJdTdfcCi6JNQSAWMyZQWpVXGMZZoMLPZBjW2t62jF8kJIZDgwQIIMYayUX8/lVWH1UEapov3AJx0Vm0CsGifzlJZgWLt1AlfZoXzY8H0LPVh/psCSBpeaEC2fGrLKwKbYqzBg4D1zOM2wJd0n1gQSSn/U/ErGSbrg2BLRWsBJGnNhD23zh3nsgsQ3Ol7ymrpl/ZB3aBxmglnDNkdjJbo4PlLUJXtg/JDMF+u4QgjP2kX2VGuBpFBkE2745Zq+CYU9dKe2NXS20I5uRO8TiSDhJQechw1xhzRIUivfguJi+CKqLO1Tz3Ch11s+SENjW8qLFQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:35:53 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:35:53 +0000
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
Subject: [RFC PATCH bpf-next 6/8] sched_ext: Add filter for scx_kfunc_ids_unlocked
Date: Wed,  5 Feb 2025 19:30:18 +0000
Message-ID:
 <AM6PR03MB5080EDA5E2E2FDB96C98F72F99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-6-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 6052b05a-1796-44e0-944b-08dd461c4d96
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oML6kpOlITBXzhYTKPKxt+3sjEbJr2e9LTRW7UXxv36PA2Vz39lpDRlbJRZq?=
 =?us-ascii?Q?pj5bd8TNW6TdmRM1u3BUW8E51f5I942RfgfW+Zn1aX+X66JzZN3jn0RRUzKh?=
 =?us-ascii?Q?EENbyM36Q+8JR8oArspwpmkWDboTU1OAOLHRsyX/XCrZQukfFGTTxS3gmU5X?=
 =?us-ascii?Q?AHFm7MDQmRNml+nOnbIpzSAdXUduj5QINln9FvZfcXtjMaK0rYuhYje/kSdR?=
 =?us-ascii?Q?dlAfuXNDyC+KU1N6EEM07S1LEMwBPEB2T2hkGwFfCuqbptetQVxpaGk+4OIG?=
 =?us-ascii?Q?B4KxCQ1hejLc6QW/zpUAPWkjrNzlOXf1QtBAM2w2o5d/Mh+zEMc0GbHbXUmP?=
 =?us-ascii?Q?iXCUxoTGe7EGZ2rXNBkXrhBJskaT8KBkrkm4SF4C9Y16RAKoDaQt6nBM5S9T?=
 =?us-ascii?Q?Jw+TBj2aG8RhsR3wF8EoXho4FJmA/dYsHsZdT3OWGgYS4dXGY3oYIomKbuNX?=
 =?us-ascii?Q?5vMvrkNEk2wodCkptjis3Blzxjj4wwZc5wRVdie5ErP9RzZyWi40IzZ9EnSm?=
 =?us-ascii?Q?zjSxfb5oCmQLXMl6lKVvdFDOaYT7yoQuXL05nVr0gPxLbU/JH3nQh3OL4yli?=
 =?us-ascii?Q?uTuVnXaXR7uw5WlKqD0BoyP13WVUvjR7bhYpOUFfDFSyRsLvJihj3KaVctjr?=
 =?us-ascii?Q?6EuI4Uom6mvs6jANAPdoMxgb7bLml037p00fffIQ92DzkXbVuv8OZntWD7Cg?=
 =?us-ascii?Q?zg7kUIcu+Q81wPp8yDkDovhc3bhiQKskb7kYY6/fjpbRiCxFbXf3AnAP9Jp+?=
 =?us-ascii?Q?19mveNG8fn/V9qOeFBC4pgDVReqxFDAgiI6pOhQWfyYjdVLPoIRArV5QsEAo?=
 =?us-ascii?Q?ECLTORaGm0bqCB04kyRiZMyO9V1Ue7j2tVDGtga4OnDjldZ5zDID+zJFYaT0?=
 =?us-ascii?Q?jx+q/+RW9ZyzWynqzWRGCdy757M+H6D7whK5wZK0P7U4Bisg8qd7JohrBZD1?=
 =?us-ascii?Q?ym5kM/SaUwpan40hwn8RX8iFFMbFKJlMVO8tXE1or5/etcA8CtpLCIkZ5BJP?=
 =?us-ascii?Q?kpdbuRRClBFYpbkFGhdIG84Ms8Sff1KhmhPIAfbwJxFZ6xJaue1h6flfdPhU?=
 =?us-ascii?Q?h5OnCnSjKje52GjvktXLPcFay/twaw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KIl2GcoCyJImgqrlbyjhGHGa7Dr3CosHJ/8WX3seLaYABp3BWRh5Z/eauY5D?=
 =?us-ascii?Q?zsd3dQzSG4zPMfPsGrwomOX33aazU6HTFQy+avOkuKbe/7XkV2bWM33N56b3?=
 =?us-ascii?Q?8s0vtW2o2Dzo9ifbj4ZBC9wQpQ7SuAsyojQNwzH/EAjU4mMgncc0ywXKFAy8?=
 =?us-ascii?Q?fzs2a0bX4/ZJd2VqBsu88qZje/E+PEVeA4C84UTzgApUapVolmaxEkySYPo5?=
 =?us-ascii?Q?nKKTy1RT+hpHnwGwBE2GaznEGvJHSFoupgw9JM9PJrtpzXb2KsBo1S9sATmW?=
 =?us-ascii?Q?3qDnnsNdP3qDMb97ANtjDj98zVPwILX6FDXM/d8jIKHqc17DrqZfy3hIth2z?=
 =?us-ascii?Q?VxhDKrBSow9c9u8+HtQbR2HVUZRYLwGxepnUNp1l0UWun43/OqNZpC9k742P?=
 =?us-ascii?Q?zB8spg11Gp/Zo5GBG+cpQlwC4Xl51X4KVrYXboEkSALmhMlXzkwlP9B+WNtu?=
 =?us-ascii?Q?+uGiYO/kosufWpVI3Swjt0OJrSHASGdWFbHCobolVOAnnM4pSQt65/X8urel?=
 =?us-ascii?Q?u22ZivBmEu9Hh/g2QR2HR2AaNYgUVigKR9hq3tGm2dfd+U0pwKt0RJv93d1J?=
 =?us-ascii?Q?JdzEMpUioNcOo/AOkptR8mUtk0tt/hvI+P5LxpcprOyRCLe1X5G4YXOy6U+w?=
 =?us-ascii?Q?2HSlcB4AimFwHpMX2ZCA8nIlq9U3YG+Ag8YsFsMf1viCLH3pImA/pvGlyiiR?=
 =?us-ascii?Q?AHZRvnEhnF1dSWt3IgFB+vDUu+0B9rbAmXuZ374N74V3OySgwzW4dq/I2fKS?=
 =?us-ascii?Q?DFVqcjWhSkMtgzQBdL7GGzpj4tARyO+jbE/O8dJ5Gly094vwRHrfWP+tY6CX?=
 =?us-ascii?Q?puFdzyHP1T0JVUoFfvr7yt+yeAsc/LhgSTkOqfnrJna2e39no6q/j+0xkCg+?=
 =?us-ascii?Q?oGFiOKqm93ltDMcbXOyGl2OGb3BqLEjwegh8MPJNge+sRiP2GOqI9BmIfPq4?=
 =?us-ascii?Q?4uq5HRprfN04hBufxPp1xK/3Gi14UgwEroIZaPOFEo3ez+LeZ3oKuH5We3IS?=
 =?us-ascii?Q?k/j361ldQCPdqusK91C6O6nEWdZPaOji6QPM+Bv+lcQTrPwF662mQZYTfpLn?=
 =?us-ascii?Q?967JEr9cpe6vkcZcBD/sQJ74ay9MM9P3hIKotpuOBylrd3iUpu/WqBiJtvK+?=
 =?us-ascii?Q?289NyW2vK0+m7p/SJIPQYyGLNeZHEIOqmljed6VgUaZW3A79d2r0NvuxgzkC?=
 =?us-ascii?Q?1ReKoSDtD6yPzisL7s9p5dd5FMuYmQmsWbuLWP3pXbbs2ZxjbdeJ73x2jL9i?=
 =?us-ascii?Q?I4FaPjTPppgK7VFyp23k?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6052b05a-1796-44e0-944b-08dd461c4d96
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:35:53.3408
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

This patch adds filter for scx_kfunc_ids_unlocked.

The kfuncs in the scx_kfunc_ids_unlocked set can be used in init, exit,
cpu_online, cpu_offline, init_task, dump, cgroup_init, cgroup_exit,
cgroup_prep_move, cgroup_cancel_move, cgroup_move, cgroup_set_weight
operations.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7f039a32f137..955fb0f5fc5e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7079,9 +7079,39 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch_from_dsq, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime_from_dsq, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_unlocked)
 
+static int scx_kfunc_ids_unlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_unlocked, kfunc_id) ||
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff == offsetof(struct sched_ext_ops, init) ||
+	    moff == offsetof(struct sched_ext_ops, exit) ||
+	    moff == offsetof(struct sched_ext_ops, cpu_online) ||
+	    moff == offsetof(struct sched_ext_ops, cpu_offline) ||
+	    moff == offsetof(struct sched_ext_ops, init_task) ||
+	    moff == offsetof(struct sched_ext_ops, dump))
+		return 0;
+
+#ifdef CONFIG_EXT_GROUP_SCHED
+	if (moff == offsetof(struct sched_ext_ops, cgroup_init) ||
+	    moff == offsetof(struct sched_ext_ops, cgroup_exit) ||
+	    moff == offsetof(struct sched_ext_ops, cgroup_prep_move) ||
+	    moff == offsetof(struct sched_ext_ops, cgroup_cancel_move) ||
+	    moff == offsetof(struct sched_ext_ops, cgroup_move) ||
+	    moff == offsetof(struct sched_ext_ops, cgroup_set_weight))
+		return 0;
+#endif
+	return -EACCES;
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_unlocked = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_unlocked,
+	.filter			= scx_kfunc_ids_unlocked_filter,
 };
 
 __bpf_kfunc_start_defs();
-- 
2.39.5


