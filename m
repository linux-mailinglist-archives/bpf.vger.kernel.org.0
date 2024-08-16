Return-Path: <bpf+bounces-37368-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE8C954B0D
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59122845C1
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133091BA868;
	Fri, 16 Aug 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="foCai1ZX"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazolkn19012037.outbound.protection.outlook.com [52.103.32.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9D41991AA;
	Fri, 16 Aug 2024 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.32.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723814695; cv=fail; b=FC0KkvkcnkoTwUZEKzg0ZoTw3nVBnB2gpT329LsUftm/DxfNtOokZuhz84ONvdNLNTYSstLBN/XhzJwQ0gc+JXw24gJq/i2pi2iMnIJruk1qcPiMKgffRXcZ7oVVeonQCQSEodEIDzR8Z+HOrnZMEg1RFejipokzio+wNa/YIHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723814695; c=relaxed/simple;
	bh=DIPaif9KOnQCMu4st9jInd6mAz04X2wRYi3ybIXxK8s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MkSFU/rZDI7qNkxmt1Vg6UvggcwQKwwKKHDufosp2Ug2OjYHZ8Rd/6erZW6V7gcXoGzGG3P2fUWJnrdzqfTRtbPM3oMDsKFv6TkGEKuCyWjHZ/5ZcnceXQFoj3H5fw5fLVz9rXnfZPvDUtIDMiBalE5QHvtLd7sKGoXZL0cfQFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=foCai1ZX; arc=fail smtp.client-ip=52.103.32.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dCcD+7rSSWKeHjypyw+JLYcqTa5DKpSpggDu/6ZAmwEChGgb1/M4z2uk0wkn5PrWZhiOINSZqjxipQcYtUKDmhGaUC6yxDOdxG/ckptfhyECYivh121T8sgYLNjdiHjixalBIRooCOI8iRHtcuXPTWqpWmNtqKHUuPpnXGTTQvFcexhbqvcFvS0e9Gv5UcCfZ3DVICPiDOyA4yrxPSQSbZJpSw5sExs7/kWiHb/ZEIeIdRJIb3G/DQ/tQYI3Qv+P414b9XXzEy/MFKJujqxBLeleOUtktTc1sqP9y8ethOCxfQ1R9tL9pdrARUkonkHlxxqHrdMftdwLRzvu3bvEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/XQ47pUxDZdsoP4M7Icy3OjxlBgUE7ZciSA7rr6XPQ=;
 b=Kru/YLk8mZPmlXYBxz94KdarraMv0D1fr9quYZr+e5MsL/2gT8YkP7rbOYliRXqAiM4bX2Rk1/kCWAr7MLmilv4DkNEIbHU7HyP8QIo+6/zQaFb5WFIwabLhbVQ4mdKlj/WdgYRwVcYRlfZ9LXYDPVlOorMAkxciig1eO2JghQm9WNVNDPR/Cs9eD+DVfUKqTtsXLwY8bEWzgRtjyMbL7hfKqwuU5UW8T5WF99FFz+Ebf2bDNpsERCEztOHpne3PqlGmSVov/VZl2A4pmbIvhzhObsd0JzezTWSutPT8MQCiGcM/kZ9v2LOgXtI9zf7lAD15lqwfpudDG8TRn+737w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/XQ47pUxDZdsoP4M7Icy3OjxlBgUE7ZciSA7rr6XPQ=;
 b=foCai1ZXvnWv/LZX3NVSIj0CGt7THC9xrZ6pcgf9jP4IeFMorVlkJ08TPxnZZ3/+Ti7iwNX4d/bEAjy8cWaEZvKXbRG6hCemB3I4bHYESWlOPsum36enIOleBkJSDZkyPDQuasYfY7TiZyUU8p8IbSyf006OCELPS0YXT98Ql99sgBnm7rcOI3kKQ4NllcYjH81G3aXwaq8YGGhQ6B6Jw6IoTMDWbM0+dTOA9af3h9P5XxeGDz+TUqQcKV+FN3Ynta19GgkORdNYaMsOURH9wBIkOzyKkWWKInm01rsteu1T0lXsa9QvgExSpafpmVVWWR4w6FV2pCw4Wnn6UxOixg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by PA6PR03MB10532.eurprd03.prod.outlook.com (2603:10a6:102:3d9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.19; Fri, 16 Aug
 2024 13:24:51 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 13:24:50 +0000
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
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Relax KF_ACQUIRE kfuncs strict type matching constraint on non-zero offset pointers
Date: Fri, 16 Aug 2024 14:23:17 +0100
Message-ID:
 <AM6PR03MB584837A72DB98E45AE595A9799812@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wyO3448nLk3qM8VrpKpIF1KMGgHcIb9n]
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240816132317.87475-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|PA6PR03MB10532:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a5b9045-dbb0-49a8-67b6-08dcbdf6cd96
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|15080799003|19110799003|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	f9ehTovk8rXCQOg89CjJ7NcO9iiW6fLRwOqA03ajZq10XQy0p6fk8aqy6lVrnvteajhqb41z2vQKM33fymDxfJfJ4cT+o9//3qiXfv96givuIeY1u6/Js979Vn8PWmAK7DrtWGj0wLso9Gwo30TPpAtCSRPbF6oMJ9LbKxezPDkkJexcaRAh75LYppAFTXWiY5ytBkIS+6wIPrqtVaGrCLMOE6Ys6ujCql/rLYQ45+mqav9hNgc6SyUC/IXFj3HKVfdHwhrfuR9X7dP5v+OMhSzbzLyhVT7rOImvgKSFgQjl5B9+vj/29AStMNuSsKkl6NnRw+pkMc7JGIXef/bMZPObgxh1ks1M64jBLnaJfV6NQ3/3Uwq6+KClvouYVl2EDFGmJURgNkabVp8m/YpjOvsRaZbfwsBiwKR2OVcFJO4z/XroHs7KsUrQsiDi28ErEbZoyj2VOyO7g+LTIyt7ZQH8Kzhzig+MLSrQJD1LoafZQAOrZ0rPqGL579/uIRVkrDEdH1FXGJmDYxPgzU1oL3UKdgqMgBUrYdl6pCpfnC6LxPF0aOpoSTihIrFLAIS68Brbs2cGFDxN7d2F1UTShWLLwmvmQ0ohWdAu4b64KcL3dPiehkPx9vH6ph9Q4WPqNxLH6Zjgv0OHyvTtl1UQW5CDjyJL80bgsRvStcJcmh2jqXVbh6Qi7zYMj4BsAZrTO+D3qaiuMU+RalxMIhrFeMpOOadgJFGCh1KavHHeiVHooyIihC+BoswcfFcYJvmE
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8KeGSgEGp8ZQaZsSThId6HNqhMza6cco1+ap7bK3JDxoZi3XWazVfSjCkNmz?=
 =?us-ascii?Q?mcnYsNa+p0QocZS2NzTiSz2XKi/rHU3J+chME0doYc8CwSmokrE90X66BAXr?=
 =?us-ascii?Q?qVdnkU9I6WJtwrMu06L1ktLdXv4Y/trkS4XapSL4uvExUTuIif+fnAxQ5Xnt?=
 =?us-ascii?Q?rt5Jip01qwtc7E3C0j1CRVClfRT2Y13TU8juGUplNrFMO6dTRXo4vuJm6HVe?=
 =?us-ascii?Q?Nz0/oPXtZsmbES6JizlV6nRajlx+Bme+ybqc3sHRFTFrPAbuJqpJuprpXs9H?=
 =?us-ascii?Q?NK+CxTLGYETjhmhS54dGcFl6stp0n/2WW3wQw2dkoJ18i2h8hi3ikpEZyq+a?=
 =?us-ascii?Q?WIgO9RjUK4kO9WEsxo5iFmcDKiliViO2ywFgraBs+osAEmtI9QK8IbXZl0rQ?=
 =?us-ascii?Q?EF5c0GeVGAwihGJWXXvtAl07cFyW3ckH47rLU38ar/EL4LrttZT9IsBk6OLo?=
 =?us-ascii?Q?yawgmn1v9gFZayMfjtGk5WYiHP8bdf3+2+cseiw8AuS7ZhWND3MLE/hUrhJF?=
 =?us-ascii?Q?Ioh/PGTEqmjrhUu1L5nESCoETezB46CPY0odphmg9uoTdL+i645209srFlOl?=
 =?us-ascii?Q?DAROcmA2TpxOeM6C8Z5PuiAGg4ZkiJTUUJbC8Na/IbzttZQ5/vrQtkGD2m70?=
 =?us-ascii?Q?CdoILKpa6U0/rX3FYD7z+Nvb0LW61Y1z8TX9aDIJp4pJH3Shc2nw9KTjgKKe?=
 =?us-ascii?Q?bYKkSkhULd1xSTson/HAvoTio1yh74e6QCIvD1Q+1ixj3y5BrSH3rYdAY9ys?=
 =?us-ascii?Q?aCBvtEUsc9CWuyRfbXvcO0DEgRv2KmnI5r8BfaBKuxxFeeK+QEQp+8XOZHxZ?=
 =?us-ascii?Q?7p8LmazBZ5fcF3088EZErwlc5UHqXCD6vZ0Y+bfYY6IHvUPnHDbC+Hk3Cv8I?=
 =?us-ascii?Q?5cWqzwkSw8miNWN43PoSPrqcSDkymM5c1I91Py1h+M5cRPPIP1jaBYdrqTuD?=
 =?us-ascii?Q?nfupcD2gpLYtIhP9Xhu4WODhmRyiR0aXBHdCxegB+X0Lh0NxUx/eG4+TVJvu?=
 =?us-ascii?Q?5dBL6GgKLp48H46ONb9MmNXPK7K8zMJ6ru08QtGXn7FRyDqCFI+Dfr5i2syw?=
 =?us-ascii?Q?EetvunsexT41WUaWDgb1jtV9sxBiKadnXUWw5BG/WrWWwuxlEm7TcGLqr4YN?=
 =?us-ascii?Q?ThG0q5TKSMEwTWps4U2lON1m+W6OQClYPqApW0/+6HRFmL/yIaL30p1agfBZ?=
 =?us-ascii?Q?7cl8z0ryy8o1nMu2Hlqjvd4f39Fjt29BLyjOSTHytbbppspjfmpdES1UDaQ8?=
 =?us-ascii?Q?oVl2Ys3XaVgk/+c2g6ak?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5b9045-dbb0-49a8-67b6-08dcbdf6cd96
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 13:24:50.6718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR03MB10532

Currently the non-zero offset pointer constraint for KF_TRUSTED_ARGS
kfuncs has been relaxed in commit 605c96997d89 ("bpf: relax zero fixed
offset constraint on KF_TRUSTED_ARGS/KF_RCU"), which means that non-zero
offset does not affect whether a pointer is valid.

But currently we still cannot pass non-zero offset pointers to
KF_ACQUIRE kfuncs. This is because KF_ACQUIRE kfuncs requires strict
type matching, but non-zero offset does not change the type of pointer,
which causes the ebpf program to be rejected by the verifier.

This can cause some problems, one example is that bpf_skb_peek_tail
kfunc [0] cannot be implemented by just passing in non-zero offset
pointers.

This patch makes KF_ACQUIRE kfuncs not require strict type matching
on non-zero offset pointers.

[0]: https://lore.kernel.org/bpf/AM6PR03MB5848CA39CB4B7A4397D380B099B12@AM6PR03MB5848.eurprd03.prod.outlook.com/

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebec74c28ae3..3a14002d24a0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11484,7 +11484,7 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	 * btf_struct_ids_match() to walk the struct at the 0th offset, and
 	 * resolve types.
 	 */
-	if (is_kfunc_acquire(meta) ||
+	if ((is_kfunc_acquire(meta) && !reg->off) ||
 	    (is_kfunc_release(meta) && reg->ref_obj_id) ||
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
-- 
2.39.2


