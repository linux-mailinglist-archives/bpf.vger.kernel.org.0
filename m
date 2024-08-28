Return-Path: <bpf+bounces-38312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE996313C
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 21:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BB1C233C8
	for <lists+bpf@lfdr.de>; Wed, 28 Aug 2024 19:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F161AB51B;
	Wed, 28 Aug 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="MLICXYbE"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012038.outbound.protection.outlook.com [52.103.32.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01EC1A76CE;
	Wed, 28 Aug 2024 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724874581; cv=fail; b=h+4GO3lVCWNkZMd9A0529pY5Vvfqnp3JMrD5GjUgLiYhlw2Ls159i7Wmvwk8RY0FIdxkTLpAQpZaXL5T/ZY/V5GFOfjag72ga9veK/uLinQQafspXad7Y5cWntwfrFN8WTRV27kfg2VgGT5jOTs/hiTiQM8EMoBPpN0L72odpGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724874581; c=relaxed/simple;
	bh=ZoKicK9oj7IU7ppsDSDQzxm4RrCh62YDD+8yFpPMz6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=sq7THUL8b7BRv6SfgjoxLnvJVyFN9AM9/5YUMGCjVxTR2CUNJaIi3e2KpIBZyNmpLhAJw0zIMtLwRdRg6UdRSeclD4t9GFLENYQ88bLzgO1WPNpaCzghvUvuzKF01WoOo1cYpbYlzLikudXAO7OIGPyKlYG/VpAmksmas/82YSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=MLICXYbE; arc=fail smtp.client-ip=52.103.32.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOoKTnBWMh06lqafzERZcca/GQFW1q6eX8Zes+PIcMrV6UtjnmgiRpyggF+xXQau7myYZ3xl+E6e/OGsChDbGelJIcjNCUAfBB0DVMSoUYFsogSwLkU5oLUXvlGT3EiUaA+YHKEcOodOxP/cscXMNmShU8Y8OVxqzqvRa5uKh1L/LHjEi/BrgWmGJFzzINKCCTiM0ulk+HuDu7joJ6gAzCAK2CDIJ+4sj0MAxwHPRcHjruQXZBsxdbyUHMNvZ0ZZ+8b8y64AQQO8rikt/OA1cHj5cX1ZKEiVvujQSDWoOGniKFpPWWk/tpB0Zlvb0eHBVwgYmgOvoiljKFbISkA5Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juFGlL8RNkGyKAsi+4qo6HpF4AJ7y67q2jLQ7zY7Ias=;
 b=RvSH2GHsHQUBeYiCu21m6zx311999ZoF1N7uyX3Npls+Ge2ClNWuny/W+6om7sMS2+Hcg1yi24A92fh1DCS7ho8rb6Qrps7vS9yM5XSSbEcYfkYUBsJyIRlCVJdmzBTAstIni642PS1Q8PAI4HdKeSYjveGh6iQ10QTdLATsLJUu4GkyItkowL0L58jd98W2DjtNnmSYX5sxwCY8v35UCbYgW1ZsvhZVH+mC6esQgdOD2RBv3C4Fw7/oBBLB1nlaOPG8UDDv1V84KLXg4cWOw2eXOb63Otwm0Ysdnv6SXLQU7y++9m61sCwH9i7z5rB7i8Ss0YnMpK1zdoS6Qu7UwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juFGlL8RNkGyKAsi+4qo6HpF4AJ7y67q2jLQ7zY7Ias=;
 b=MLICXYbE0TdQNn8S3lgnXDAc+34BnEYPnRAAIixtda9sHchcPF9nwGcO2F2idmaVWOGGkPHom9Uj5PYkQoneGxYjt5XL0RfD4ETszQ8Cm82J8yi11J3cgAyMO+uAapGbnlnQAaezlPAeT7HnLVfZfsrUAQr1qVpIRLOX+hWc8AbhMIRMub44LHwkEHukUAl8TMGYYko2p1RJyYBAy4f8MRbhlciTB9HTLlscJujhIVvcmQLjzOy6Az+yFuorx5JJbW7r2bZoBBp9LzAKOExe58EzQQIpb00VTZDMNjGwo5n1vuUrS2zmEMtvA1QWN0HxrZuwl/hK1/yoGv9I+/7K2g==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PAWPR03MB9785.eurprd03.prod.outlook.com (2603:10a6:102:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 28 Aug
 2024 19:49:37 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 19:49:37 +0000
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
Subject: [PATCH bpf-next v2 1/2] bpf: Relax KF_ACQUIRE kfuncs strict type matching constraint
Date: Wed, 28 Aug 2024 20:48:11 +0100
Message-ID:
 <AM6PR03MB5848FD2BD89BF0B6B5AA3B4C99952@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [CN0PWSKvxgexGrenKCsp/GgYJd0mlCFi]
X-ClientProxiedBy: LO4P123CA0085.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::18) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240828194811.49890-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PAWPR03MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a5b16ed-ea33-4ca9-48a1-08dcc79a8bbb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|8060799006|15080799006|5072599009|19110799003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	NnVR/W7PH+ax0BPz2J172+EY6M7xxP3U6qgZ89Z9R23bvl8rz8lJhjYaFricGKbf8wjS5O3GvgnS+L3rbIjSUVj1avV5GJMdcIFWCdxTP6abOOrmIwB+LciBYOBrEI0V93lgMzYqtXmXdR0y/8AFbO12aa2k/xAO9TDDyfQnt1D6/tzVNapZWgicXnWJ4w0APnKzmEOEIlSNASEeI66ob3VgPArM2tZX0+hpd/b8BgB/XJURzEi1A4mnrGN7ge7ybjFM2XEzYl471pOst7Vna+dcVFBHp4JgS8KZVfgW9nutCBcccGP0FIsmVGPfIQIlyR4gXWg3942Rf7iWsB/ivaPSI5Evc5qu96iLXVX4GL9nbdLFNS9ceXGBG+GixAAojyO/3dxso/tS4UXC7UqzSsEmwv/o0f9OqxS4hWxWcagYGwu70TTfnzlPf2uP6GHyTKw37y26rtcB9KCNyodyAT51PK+w5xk8Twxo5pUUHZBD17gK2Lcdbt5+2t8Umkmrll2tJXTeBZbGC2o6yNLPBUNhzWKJIeVodUfAFhpR4/W7RqcUlgJ0wjYzD3cZ71yTmF9jRqLFhWdATO6+QkMQkaqf+qSxK81x1R/Adhb21ITvtvIuPfrKW6xRSLa6bIwlMs6uV6z03WcNiWR+tkbUKsRpWAJpMbJGJfM/HfzvqJD7vXFv7mwlxnUvCjEQ0Teot1CF0UYotmnIXJSgumbwx/vMGlRZTavqySjh2ocpmxYpW9JWLRW5PsPUsFuCZLLv
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJH/InqoHZORQ9qRAxuv9/am57BxbnTWRYXU1OPDkTToUGxegyV9QJFwipPk?=
 =?us-ascii?Q?j1KMTV7YMuKdu0b+QUc2DwRG8WtP93xNGLJIkPlMt2AXlHa7lCA5HYzhgyyR?=
 =?us-ascii?Q?qZstVCmWPqmoYCF4J+ZzdLGbL8ABaH1PhGQ4fF7wUamk1dL4Wy+9TtoX+1WF?=
 =?us-ascii?Q?/9EJTRvpDXQiF+C6nA+/GpPFyeOaEmp9LmiFrXbhryBqHULIn1M51kLZPvJx?=
 =?us-ascii?Q?+aRVCJQyWGdOp80F4ov36C8lSEepdKBgmn5UcP3fg3XfGhNjBMbptey4BWnW?=
 =?us-ascii?Q?GltwrvC2bAiskywOYZYO4Nh/aNgL4u//I4ba/eCxaaNh+M9XPN+6cQ5SaP6Y?=
 =?us-ascii?Q?F7074w0oRKjKSOdSx659puD9Lwxe1A4TD4TsjmXIyqJW2cVazBWE31i8d2OD?=
 =?us-ascii?Q?eXEATKUe1ltiSLCbXoVpGW2Zixp4zVI5/XD6oljxEXXmxTCYbI2W+TqApA59?=
 =?us-ascii?Q?BzcpvBQjcpcB3Gn6TznJ7gxabx8ZWXqrl6KmSDU1rGObIH5pbQ9ywoQ/AODN?=
 =?us-ascii?Q?zI3JovFXU6Umv79wc13SXsZliHFY9xVwXkODGIjtAQXsmn2hzs9sXJsrHPNx?=
 =?us-ascii?Q?c7w0si9N00/WcDlIufN5SUHeii09lfBrIujfuDI4clpvD6tCjxlV5AoOWDGY?=
 =?us-ascii?Q?Vb5k8DUQIaahG4jMqiyfubjDbrmrhF5Hn1tBiIxdzWNZqyg48Nx59vsSpHk8?=
 =?us-ascii?Q?LDtE7h6Q/xUTq+4vx+cmJuZ1NPKxAlLzhEKhBfTRvCAog6lQTyLaz4cQwwXL?=
 =?us-ascii?Q?dXCx3MxHLj0T4nY6a7qHH0ObYPyOW0B6sl/JdH+Elb7/pLSUM36EgYLPFz7H?=
 =?us-ascii?Q?Dx2NaizGzZUYIbbnJJe6A+b9Kzh4KJ5rN+IB+yqeloQb6p8N0AstPNDBaEWT?=
 =?us-ascii?Q?OzXuEJpS9sv/faiVLjmKzhpDddmIPFEGS+ERU1cr1u/44h0MW4smczR1b0ct?=
 =?us-ascii?Q?BJmYi2calpEI76Y+afofNDHE+u6gILpOYxd/QYzul07ye2q2wCOyKiYjy6sw?=
 =?us-ascii?Q?TRFGw3yJQwCOozxA2xo2d6mp9Ndb37d3scQPRZ9K8/Baf4XImg3Xsy8acnI5?=
 =?us-ascii?Q?cWXb71dQFGYtNUTNVEterE79Guobk3jFmyVXngNoaSDGLQMKybnlTsZ7lO7c?=
 =?us-ascii?Q?9dJhzM2eRlOtsp0Bz7/Co39+PvrcCoN8cMRV+0m2N73IGJvSHlftryun+sur?=
 =?us-ascii?Q?Iw3eFfyw9hN+w6vx3T3Oogpraa4Ja5x6fQja9GbMNn0CuKzr1gKZLlGHqTia?=
 =?us-ascii?Q?ucvsNs9OiEpicQUlflS6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5b16ed-ea33-4ca9-48a1-08dcc79a8bbb
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 19:49:37.0942
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB9785

Currently we cannot pass zero offset (implicit cast) or non-zero offset
pointers to KF_ACQUIRE kfuncs. This is because KF_ACQUIRE kfuncs
requires strict type matching, but zero offset or non-zero offset does
not change the type of pointer, which causes the ebpf program to be
rejected by the verifier.

This can cause some problems, one example is that bpf_skb_peek_tail
kfunc [0] cannot be implemented by just passing in non-zero offset
pointers. We cannot pass pointers like &sk->sk_write_queue (non-zero
offset) or &sk->__sk_common (zero offset) to KF_ACQUIRE kfuncs.

This patch makes KF_ACQUIRE kfuncs not require strict type matching.

[0]: https://lore.kernel.org/bpf/AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v1 -> v2: Completely remove strict type matching for KF_ACQUIRE kfuncs

 kernel/bpf/verifier.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 5437dca56159..0f3b6fa3db39 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11497,8 +11497,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
 	 * resolve types.
 	 */
-	if (is_kfunc_acquire(meta) ||
-	    (is_kfunc_release(meta) && reg->ref_obj_id) ||
+	if ((is_kfunc_release(meta) && reg->ref_obj_id) ||
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
-- 
2.39.2


