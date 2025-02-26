Return-Path: <bpf+bounces-52689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CA9A46B13
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 941CC188771B
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 19:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BE124EF99;
	Wed, 26 Feb 2025 19:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="szxj+6MX"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011038.outbound.protection.outlook.com [52.103.33.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2424290B;
	Wed, 26 Feb 2025 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598234; cv=fail; b=V96QpxAcaJe4Y832g+FzcofhOCxVPe39z87HqFoace+XlufjSbJeq5RYFBY4MCb8A1N3lJqweFiKBbg1tdkPjgQ3Bow1IVi17qwmELg0ojMiZwYVALCdIiukE3c8U0lh8IjtpkXzADjn9E5FZZPcAaO2Xlc6KSYmaZc2tbj4KiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598234; c=relaxed/simple;
	bh=HmwH+cN60yxalTr1BHqponBP6iClfhXvpgjEJetVV3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mshw+D7T/AZRAS2Bg/gFQ4Yl+Hq57lxPF7KLh1z6O8KYzadwwS2FRG1l1Dlcvjwr6QQAuHKZQACImmVqulijtpOdouq+BqzE3jlCGQc3z4sHK3wem9eUMLIEpdR69Cdtt1i+3EqWPPkY5eT55BO2ebPwUG2qKDxeYXF1aVU1Jl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=szxj+6MX; arc=fail smtp.client-ip=52.103.33.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nzGjAAbWYiMpUoMa8MTe25EK+Ec5RG89udStaDGrBLqYXdLYxgUejIBvUtzUDYBnnte7ui/UXSmYClD0v/c8F6Stxd2k9MbO4nDp85pzpVtqAw0gyK5IHBjmGVN1jJCQpVp+zzzIRSkpzEPwh6lGDtZyRXJYGH8puRy0OFkdgPmk1wRFfuOD+ssnsn20m+wEncm8Ii8Ea8bSDSPbEmtdCdihxNfDRvEGf/vNR8XxRANO4tiOGUt53IC8mGagoF9mH3y926HJRPgMu9mc6fUFx6l0nvMITwe6FSSj/13jw9V8xWic6Y7zcIyLTScVzB8mOq1w6tLN4oBAWJrdo/q6ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm7boR8lK/4PKwHNHfZm/xsiGobHGR94qtaOr9lLJdA=;
 b=NQuN6U0Cyxlct+JxUc/+7zUg1T3Q9E/ISRcxA/qUiK7k5mgT/uP5mkChTJmm8HV3HiJpJ82GQWBJc8JsS8AY47f6/47xEV20bLQlodZpuOij/jRx2PTXJ3EIZcbJUt4nvJRtWRQmLVFtt5T47c73YQ5W1Wz5uFQAGUs6cGr/FNPsvIQemUwe+rOVqhukl1H2gyfcp+35gY2Dva6r+hTtki9vLfDKlmtCKsWJ39hh4jFRsT6Gc2xODJdvKLpceYDq7X240T393DZS8UkB78QP+d1yhlaM/3qpTuRI5Jm+DImwn8Y8r9ySHRtw6Np1KrLnIRPpOdjNauP2Mh8N3NafVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm7boR8lK/4PKwHNHfZm/xsiGobHGR94qtaOr9lLJdA=;
 b=szxj+6MXJZ5aaXT0xQgHSuA0pb0z30C011Poy/gKoNT6MNOUf0eEz2YHiWVQugM4hJzwJf0cqp0HjeZQZ7s/JAmgnXq1BVuvv4ClamzWslXbbKxMSb5YRZUl9Iw9S18zZ3b7fACcLFm7bBWIquDtu9IxUKe52sUAvgkVc5Uwa+STukRpx9Chg7wFg5BGwDDUcTrMgTWhAknS7u0r8MrwwIvLgQh0JlA/o34JQiLspnOu4Igrlfy9rTwDQ9Qx7wte8vswS22Vm0R4V967A14wcb5W2h8DszKtSpfa2+9FIhWl2oHmfNBwM3Y0C+AvTeUe1busmtWNZTOoXrEsIev/Mw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBBPR03MB7451.eurprd03.prod.outlook.com (2603:10a6:10:20e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 19:30:29 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 19:30:29 +0000
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
Subject: [PATCH sched_ext/for-6.15 v3 1/5] bpf: Add struct_ops context information to struct bpf_prog_aux
Date: Wed, 26 Feb 2025 19:28:16 +0000
Message-ID:
 <AM6PR03MB50804BE76B752350307B6B4C99C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50806070E3D56208DDB8131699C22@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250226192820.156545-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBBPR03MB7451:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f0328c8-1ef5-4599-c14f-08dd569c0715
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|19110799003|8060799006|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vf4h5OspN3Y2I73Q9XXpnPGUdRjduGfHZ4yOS73mlcnCjxrZTT7/i+YzFT38?=
 =?us-ascii?Q?4idseEWUz+iJtDiRdu40MV7c2N3qKxm+B2Mao1+bD+G5hdED7Rxzw2mkgPXq?=
 =?us-ascii?Q?G82vvDY5i8cWIuQ0p/yxpKtE6ptgolYPYmb1lXtudQXZdIp7Zdyle03H6ET+?=
 =?us-ascii?Q?KEFavtGo6ruf8wdcbj/44uCEZ8IPy2E2pLMEM1CT29Bc4/2qklYaNz7lSm48?=
 =?us-ascii?Q?ujvCaZPjxx219EJLcWbrJF7PeAA4UozA70b2sAmngtsLYRDxMRPOfT8u+L7N?=
 =?us-ascii?Q?2YktAEFFmb8QPW3CHi5/dIsgCS3/lgAznjfAM2Kq24kgtSYu3bh1HKVtGV18?=
 =?us-ascii?Q?iSZd7wu7GAB6qNKrntDxWqAL+44Y9flHsJOfEFbn+jkz1SswTcDs/gXdFmk3?=
 =?us-ascii?Q?oSF+t5QTlhUEJopqhODWWXV5y1KwoH4NvVS0lW9kT36D9OthpJrrW/j+wQwM?=
 =?us-ascii?Q?LHOIMZwY1dlPK8UZFZTfr7IJQoz/KzaXSzYF7wMbvcb3cxZmZAeN31QWAYry?=
 =?us-ascii?Q?wZaNMwNUoTt2yRB6DcrPhQWmxqG4C3YDszjS9oVK+VKomZSYfqDCuoKFnYw4?=
 =?us-ascii?Q?4tVKaBk0QbTGS4MKRJNN1UdTPZ1LjJKCiaHB4q8DCn6AlwzCL7iQSyWpoBFi?=
 =?us-ascii?Q?r76DzVhjIdG9AWHcTcBOQqQ/jlMYSIW89rZuAosvV5NO5YCpn7+ytTucihKT?=
 =?us-ascii?Q?zshkYCRrPaemd/bXWFQaVMUvMV2UhPQtxLljPBFeYSE38HaqDNYwP8Z45dLp?=
 =?us-ascii?Q?f9KQSCxYWJ0y/WBFIN9An5RohFZ8pYHhfaGmRxy3mrAbWCToAIpb11RlWf4q?=
 =?us-ascii?Q?o498cet6nBj5bX1KT7Ucb766SogAzf0vZGFAvIh7Z24JNGeTQ8YlKVdZ/Aa/?=
 =?us-ascii?Q?PDwNFeMokxRWf5NLmOQ1EWkX5S67ujeRv/8CMUqqNTryvhPUCtHEEjg0GGhG?=
 =?us-ascii?Q?Mw97xKXX6ZV6YTY2BUdHN6mdRGJj32MWf1SIXKRIexSo3CgDETkyWqPsZ8/5?=
 =?us-ascii?Q?fNnnAFgiXfNMRYlLuwaOPMUUbfTh931cB69Yrp2SzZ3BXkHn7wGt1tLjFWGa?=
 =?us-ascii?Q?Hv6JU7y/Bbj6xSEffXsWdTYCHsl0uQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wsHj9jf0F2y+EgTtuR/le/cQl/78bDxQnLUicSL89kvs55DVvzhyD9Oy38PN?=
 =?us-ascii?Q?h0n1JR3iUrYBdwwOtSkHBi9Lh+WUFnKc8P4hbmqmPOdxZqBW5Z3Os01knRWK?=
 =?us-ascii?Q?aST7j9NCv2Ryx0gYO7S/gO7G7KC97PNSvr7nsCHxEsqe010s4FGvw3fwPWeJ?=
 =?us-ascii?Q?IGgHqPhaaH/p3g+cXQZMHhd7y11OHfaVFjCmHQUqCUjqrzzu4OrL4ILASStX?=
 =?us-ascii?Q?UJk/XcGw5g+Pe5el5YQ/OQZR1bt0RzEywPm9P+nk6tqeaT/ic1PoLlQVIIXB?=
 =?us-ascii?Q?HNUx4tkctUJWUofih7LH2weCGHd5IxEcK7EQLwV9ThwoeAAiCOBRhUTXkAdf?=
 =?us-ascii?Q?BGc3JXHYcrUee1z9aRhtMuvwA1JBYPg6N+IyPtthN0f79SODEe2OXFrCxE/z?=
 =?us-ascii?Q?touuChTazZBYYvd2c2evWt+R/gY84q/PlFkQkHz02oVdjFlWeBH33TOh7qJ7?=
 =?us-ascii?Q?qzsZikMIUJJmHqp2nToa6kNRTtOVW4GubMH2FFLAJXTvhQIfNPzu7o7QQC1G?=
 =?us-ascii?Q?r1FoJ0l1m7+P4Fnfm13L2kKRd1wMlA9GhSlBPffhQQGZS2pdJoj6GQdVjhk9?=
 =?us-ascii?Q?37ZBd+v0ahM1w78pmSPmz9+h/g2rZ/S7aNRKUMAbCT4zScxxUsLOqsghK1Rs?=
 =?us-ascii?Q?Wowl17Oqr2bZyA9yjSqnO0oKSA0jHxQTuGsbZQVVG643t6G9zVgI43uCfWz2?=
 =?us-ascii?Q?RvvsGx3pps/fp8oCrRGPR6OGO+HHjQkkNc++0EiC60/g4yRpJBlChFeWedLW?=
 =?us-ascii?Q?zO074ODtya5FNfaApHel5zbsiCJFI4rewBpxO6WSMGaOFL1sr0FqjyCgDiSN?=
 =?us-ascii?Q?lt7GtbVdTar7tw/z2SZBtRKecQPRpi5LJZL+6JwUHUCeeZp6lMymjIFmJQX1?=
 =?us-ascii?Q?/MJVLQspPl4f5UMTQQjPRGfNziw/naXKFG79YNYHtiD3E+6j9TEAwreb8fNG?=
 =?us-ascii?Q?rEZK1mdN5ohnavEkGfZHnP8YNJVv6uKsZb0O+YBjFybYAA4LTuPBm4RYMHuB?=
 =?us-ascii?Q?eVaLq1UX68o3uSkqoUqMcRdpke4PPxrDGo2A/PHD6XJqCvRX7eVbBTS1eEO3?=
 =?us-ascii?Q?FMg7ZpYG7qAMDwzfhO8/ffInL8i0LGs17nzW4soFOEX5QXWJrENBtpU2fceE?=
 =?us-ascii?Q?zPIv9uXTwgVdEIxQ/7FHB435Ky5sG0KBHEvb/DMraJDGD9bqO6Z2pmaCddEe?=
 =?us-ascii?Q?gg/iP+Nl87ilPJO4cTxTIosj6bWNJquvLJhEtlg50jAQL9n8V2b+jWRm/R1E?=
 =?us-ascii?Q?rNJn0ESl/FsVRa8ISwU6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0328c8-1ef5-4599-c14f-08dd569c0715
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 19:30:29.3926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB7451

This patch adds struct_ops context information to struct bpf_prog_aux.

This context information will be used in the kfunc filter.

Currently the added context information includes struct_ops member
offset and a pointer to struct bpf_struct_ops.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
---
 include/linux/bpf.h   | 2 ++
 kernel/bpf/verifier.c | 8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..e06348a59dcf 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1503,6 +1503,7 @@ struct bpf_prog_aux {
 	u32 real_func_cnt; /* includes hidden progs, only used for JIT and freeing progs */
 	u32 func_idx; /* 0 for non-func prog, the index in func array for func prog */
 	u32 attach_btf_id; /* in-kernel BTF type id to attach to */
+	u32 attach_st_ops_member_off;
 	u32 ctx_arg_info_size;
 	u32 max_rdonly_access;
 	u32 max_rdwr_access;
@@ -1547,6 +1548,7 @@ struct bpf_prog_aux {
 #endif
 	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
+	const struct bpf_struct_ops *st_ops;
 	struct bpf_map **used_maps;
 	struct mutex used_maps_mutex; /* mutex for used_maps and used_map_cnt */
 	struct btf_mod_pair *used_btfs;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..2dee3fd190a4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22384,7 +22384,7 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	const struct bpf_struct_ops *st_ops;
 	const struct btf_member *member;
 	struct bpf_prog *prog = env->prog;
-	u32 btf_id, member_idx;
+	u32 btf_id, member_idx, member_off;
 	struct btf *btf;
 	const char *mname;
 	int err;
@@ -22435,7 +22435,8 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 		return -EINVAL;
 	}
 
-	err = bpf_struct_ops_supported(st_ops, __btf_member_bit_offset(t, member) / 8);
+	member_off = __btf_member_bit_offset(t, member) / 8;
+	err = bpf_struct_ops_supported(st_ops, member_off);
 	if (err) {
 		verbose(env, "attach to unsupported member %s of struct %s\n",
 			mname, st_ops->name);
@@ -22463,6 +22464,9 @@ static int check_struct_ops_btf_id(struct bpf_verifier_env *env)
 	prog->aux->ctx_arg_info_size =
 		st_ops_desc->arg_info[member_idx].cnt;
 
+	prog->aux->st_ops = st_ops;
+	prog->aux->attach_st_ops_member_off = member_off;
+
 	prog->aux->attach_func_proto = func_proto;
 	prog->aux->attach_func_name = mname;
 	env->ops = st_ops->verifier_ops;
-- 
2.39.5


