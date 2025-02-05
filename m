Return-Path: <bpf+bounces-50555-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EA3A29A17
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74BB3A4EB7
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B24D201032;
	Wed,  5 Feb 2025 19:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Jdz/W6FP"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2081.outbound.protection.outlook.com [40.92.59.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081451547F2;
	Wed,  5 Feb 2025 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738783904; cv=fail; b=VkMlzRpR6090XFsF12Ih/1TUqigKsvycQXD7ZXyCaDQ2XcEKB5jzdzwhwtSOFsG5WKIL3GCiztGn++MePBKeLyEVQguQc6mECXMsMJ/YCckglXgn91SdcOzxz4umJ3qyJuPMGAC33jTgHlVhU+pr89tKxg060ow/I0vGb0BnAO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738783904; c=relaxed/simple;
	bh=xktCERVD5xDs4DnaIra1BMqHrMLfwVEyc+m63Zblc5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p8FGTY6wKDpaWtIqxd2Bj6RUek4gfA2vlUKs4O9SQLLLtv1PuAlycQ3D9ZX8eZifxb2GIP7DRLr8MmYrAesbuxeZgfiq+YehP63l4oRarGVxLqjmfIA7RC8d8lL125dBG0rZgGpJJBcoCidEkkHw0jBhdcjmZ6UbZUo93Z7DBRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Jdz/W6FP; arc=fail smtp.client-ip=40.92.59.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vYDeNkeRyQrf+I6Ct9hBEq3+wN5p9sOHwfRhvmSSBzFR8ia7lt47ZTcjLDMWKKgQtnH6f8dKOJ8D/PAhmBE5SzV5DCFfiM8ceQoMreXHvabGnoIttycH2cC4scz7V+TBrB+47J9Vc8a/K8hf1mrFYaRSHI0vEjq5iMO19O4dJ19HuNwyAC2nMbImNb6Y3eKVr5eQS5gomxZeQzO9Grhfkw24IgRbXroGRbii833YfDtwACVs91PC72c90oXeK2G21xE/U2CvbJVUsOFm3khnhdJnqWh6cEVn1EeLdb+d/NaAx4gyZxaRvXre4ojXcLHfpV/ycv2Cwj4NiLE9LLeh4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrsSAPEZMK7IeTUEHHx8wwr+wt9kOHcl7NyA1AgY888=;
 b=GzTU7hYhRg2fbUVTSmyuUnp1oJdqn1K4QvZvYQLxc+y0Whe7iZzJff6rrzVHsEkOBNWXfHms9TBREMk+6bppK5goNlvGtWsl1z6RyAy1J1hjF4vBhnERNu0ayJPsT7hVUEXSqNJdkWil/rlnYWpH7igqrSZE6v/KB98M/YS2kRduqHVyvTURx9Zj7Uog/z4tzEJ6X5E5FTbRXQH3MeAcpJEPKJMb/1UydHbIs2AawBtOiprm9vjsRFm0xj1Qc9KPmazgDINKk/vIujZiYmIVHk1iGsf9tyQkt5N4DZ9RN3E9c/UdR0kJMYwVl0LwfYUd4Rl1RCmF8s8wtZ4M9toBDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrsSAPEZMK7IeTUEHHx8wwr+wt9kOHcl7NyA1AgY888=;
 b=Jdz/W6FPWkV7w66aEM6apnI3H9AeirRBNPn6Ub5xIKNolhQ6CgcE9u1HJxTuGKUzWfkSWtQAvWZTi0UD90HOde4nBwp9d2PSaAPwdXWv16BdhIGbcePMBkVMij7zByU2WaXY4GWIAmVoOXrRvl8E9HTFGwmfrmzP58wcl6Y79RKaZhrB6LHRZkcbeNw6TdPSUOST3SfFfD6RsNhSWkeDm6JFWzSD7SnYMODCTZw5zKdvvHER2B1smV9mUI1pB/yziuunq2nMQa3DoGSNgDhIOR8hMCwEzH/8zM8S1IYYZ4GCu3QHRQBhxFIlkGpasnd6LtojW9NL41ssds2FuJhTbw==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by GV2PR03MB9619.eurprd03.prod.outlook.com (2603:10a6:150:dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Wed, 5 Feb
 2025 19:31:38 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:31:38 +0000
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
Subject: [RFC PATCH bpf-next 1/8] bpf: Add struct_ops context information to struct bpf_prog_aux
Date: Wed,  5 Feb 2025 19:30:13 +0000
Message-ID:
 <AM6PR03MB50801631CC8364ACC928E09A99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|GV2PR03MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: 356cb3bf-1879-4dfa-55b5-08dd461bb52e
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|15080799006|461199028|5072599009|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00OVFvTx2//U4040aI2WTJnceMEQgMds9RgqrDXtMGxGxOu/k7zFzTxGsl9w?=
 =?us-ascii?Q?Q4KIC61p8SvHkwH5zj9A5Oy2/17Fupa3bdBE8rYYFayX0iFtcMPphGmSuNNc?=
 =?us-ascii?Q?FPHBPezOFK66fo6M6SV32eMF1Nj/iZiIerZv425HQSAKYObkYXz35a4NOmt/?=
 =?us-ascii?Q?BO3rjHu/3Q/tLyF+l/riEaGrdLrpGgkYdXMX5LbHN9ryL1y4aWsRAJY/3RZK?=
 =?us-ascii?Q?yfqlM5TQLw5QVKtjHyz4eqHOsg6G7nlC2OYQypN8VOjpS5+1WXWGzKGwwDnS?=
 =?us-ascii?Q?D7kR24oiZ6+nJ6L4v4xjrYu5B+jJQZnQI7pBSImtorndJo/EU1dzFYIfq+d8?=
 =?us-ascii?Q?yNY7RwxO87Bgy4vj3sKEX5IWg2f7S+XxHGMspZwoWNKHs7w4w9qQPjxJ8ARB?=
 =?us-ascii?Q?8NBRnGbI2LaA3PxSLbYIoSn9xraNn3JnErgWDbk48Tyi7O68oVq+1TbBFw5a?=
 =?us-ascii?Q?nRnry/Bc8u4Q+GWEMqaMczyOxuTP2IrFXhSpyeZdmElVRBrVz0MQbudIKFng?=
 =?us-ascii?Q?g23sgslXlclIA7JNy8aLjGD0mjvk9oKki7uJmtFFrrr2HGVeJ5ENrug21bEZ?=
 =?us-ascii?Q?RbQVDFYS2NIfGyf1nWrPQM2smoELgJ8euzNkyqkPXnS2bRA3Q0xctvLzguLj?=
 =?us-ascii?Q?NvF/oYaw0I8VCluMEYAm9tlRVlk/OaV2HIjYFxeTHrj8uwyEnJ2wpOEV/MTR?=
 =?us-ascii?Q?mHXyEe7PAGHVNT0X++x3kKyw6RdeyBJrSwj20Wxe0WAYbbBQVZp1m1dzHIVv?=
 =?us-ascii?Q?sxIbXO4RMPzNzkILfoG82J2Bgf3+9plOZbvq1cDK3l1JfjK53qUsjNubRnuG?=
 =?us-ascii?Q?AUJglQbBJZoY2wXlXuVWv3DKoFWQ/0AiC4v+LOd1PRTRRFv2Ocmfii44wv5v?=
 =?us-ascii?Q?fTeAe3Sgx9m1wlRBKbEFqaw8rSfbtMwv3rXNY5aE9r38Uz+IhWaSn8dMJVDu?=
 =?us-ascii?Q?H32GBr44qwiVytCO9l+aiTn5hRDs2YZxK2YbQdkUlTAXpbXg+TGqdfWA+oOb?=
 =?us-ascii?Q?4sI1m9mh6n408GMs6TF2Z8sKCPKAA8X2cxiW+Fcl1/d5acbbAG8p8NXU6mOf?=
 =?us-ascii?Q?3QWaZ826RgR15kugTPsIF0vQTChXqQ=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YthAcm/xL+zObKI/WppHhhnA2W0gSfPP/JXqtJ7E/lJNAYkJqiJNJS4ufz/C?=
 =?us-ascii?Q?lQsFhjkAS97GVesB1f7GRWfnt2akK2lKD0dNtoWXBZ9G8aiSynyAqzaJpNK8?=
 =?us-ascii?Q?sdgcuhRKSSofVi196//3tVkPIVdN8/+zdtfLvvKOBspTmxhBofurT3ohinq2?=
 =?us-ascii?Q?cdMuEjY5d/fPRnOsie7ehZI1q1dT53A98EFUxNuXnB+CqNOg1DxUMffQVyab?=
 =?us-ascii?Q?9n4rj6yC3DMIuIOgNcXJ56WTS/mN/rH+vosRgVItjqlR6Ppm7e1JwdWpoTLx?=
 =?us-ascii?Q?i6EBsy8yCImCw3cvyKINuvRdlh9her2GR1zpSEh23E+1O2FydcuNEQQ/h+J9?=
 =?us-ascii?Q?hnwN4Kx813k7TOxmZQV27rBiVjT344dAYv6TNrAkypzEl7D8+kVa69+G3kYU?=
 =?us-ascii?Q?pdmz7e+pvqLw422YQyLCW2KmFiXTMRfOFUei8CyKCKLCl2+LLFFx1zpps81D?=
 =?us-ascii?Q?s8Y1q3OAjdQJUznyDE08sAPa+bHIN+qMiuTjTq1xlMx3jbmuqXd7GOGUeE8g?=
 =?us-ascii?Q?6bA7qwcUe9cRHA1+QkO55/c16X6uDh+e0m3hfqIb2CDOHLMn/R9+Ieoq6ZCn?=
 =?us-ascii?Q?/GdAdNnvvrxho6/DswpMnm7MRuF2dX/JrjsCU/GMV3lbXlGpFyDFMzhwY3sg?=
 =?us-ascii?Q?K6tK/Je6Q5F4Tfpwm/F79TboRWi4MaJrAilMa+91edkr5nYS24K1grHp4A00?=
 =?us-ascii?Q?qME9wCv3DlDr5uIz1qMISgQSNCkOD/UX5EZKHELdjCM+H4TpHyQOT4Rbs6Wq?=
 =?us-ascii?Q?n+tLeis+z/sca42Z79/78BLJS/YC0vzoiU2ndZnxo+Gd7EmPaoan+Tlt1C3V?=
 =?us-ascii?Q?2xveYmnoWCF47ujGLOKdHrgTkAyWMvGqH2T40auHfH0bVfPDDubgSx9v0tgm?=
 =?us-ascii?Q?g/G+hFXLnVWejkJbEGue7Q9zvEb+n/8hqk9gp10wPgJ2h7iPexxCCHsOOrHu?=
 =?us-ascii?Q?AJjttvgZHZJpmO2d+g/yc/bYt+3LjHtzMnNBLgLyeT2dKRH96JL1ahdgpL7o?=
 =?us-ascii?Q?hFizJLtipvI0FInJV6XTlWJqjapB98TwHl44nusCYUvModS+9gu12YED1f6+?=
 =?us-ascii?Q?58yDck5oxcllpGKDC4pkOy37GsWGexPbZjfwV8rR0r1nr7Lx3ys8SBvWsh0I?=
 =?us-ascii?Q?KBLGPc2xGFQue1cppBcGrSBg7f7mJSu6aA2JLZIznpMd2k0sAeDB9o8zKXK1?=
 =?us-ascii?Q?tp7MwNODEOaxtfpTkKipsYh+Z9gNbP7lQBBc24h04EMcfJfiAcbsRj48hVoy?=
 =?us-ascii?Q?NblIJN4cOI8If3SpxyOq?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356cb3bf-1879-4dfa-55b5-08dd461bb52e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:31:37.9190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB9619

This patch adds struct_ops context information to struct bpf_prog_aux.

This context information will be used in the kfunc filter.

Currently the added context information includes struct_ops member
offset and a pointer to struct bpf_struct_ops.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
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


