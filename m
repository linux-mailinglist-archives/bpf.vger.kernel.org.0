Return-Path: <bpf+bounces-37277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7A2953808
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93E06B23A58
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 16:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CCD1B374C;
	Thu, 15 Aug 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="HEbIHsHJ"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011036.outbound.protection.outlook.com [52.103.33.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E641B29B9;
	Thu, 15 Aug 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738319; cv=fail; b=PKGdXcRTiSvikPOLOg3ZrcfRixTI5HMiI4x29dMrnjeysQxy4DodgVVsxYEPVh1dU3Nj+weCXmqLzTZI/Y+W8KPBfL5mN8lWoLEu9EXW9Mm7cAZdnS9LjdmOzPg7S67wFmAwCMeV4dJONYbBQp3swiFBN6aLSGUBrM5fj5wUEG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738319; c=relaxed/simple;
	bh=9mhAsiYcMOFRcBOFr4iWzBYYYSTAfka4LL11W16NdzM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gd7CCqOnEz62p8mzH/GhJR5LKUOwOuoKuJfseV4lw42CamBshAxXLYCUeh6JXg0/2j35QWrUfmBM7rzWx7WJ3CBy9WwezeJOR+BnNx8J0AfwTVzgLiF/26yRze3CuT4cPAkzcMGkO/eoBlgrOdg7vtBPdSYGOX4/bkLCnExldW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=HEbIHsHJ; arc=fail smtp.client-ip=52.103.33.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJE0acdLJPPYKxo4uZn4aCYqZfaa0d9rHVu7YWrhYYIN58scAk7AMdNNsi54F695DZTC/TXLJaiJXsSs9b4JOmlm516aHBQBGxqFIJSi3Fi6CFEtbRsxjTXG4ATukhrk2NC5W2nWUCwmF3Cs/XY13gWGQCQ0JBBiUkms5zsKdQWI0FxzLvBnLA1/C1NfLUeeahStnV+sSces0nO/L0q/j8knXqHaBpk86yLEOl9BZwHxctUyEhdz7iIaBxyJ5wqE4COfCsCuKAzPQLaY0MXphxjKZg/8e0NNFL0cNGZRhOaWtFzyiWv+no1lqiDmIQQ+v+Jzrfp0Nd0DEXX3Ygddyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2hQb4Nvl+0Ps9qDrk2gupeReaTQ2BjO5pqYMR3hds+E=;
 b=nMVzio+38ff6O61ontPraP8iag07yBjP6BOiFv2Cmp8Jds2CFduk0+kfWAeMWBywHM5PmYQug6K4Jt3zSPKw6wdvWD4cJk9efOXPhF16+r9rQC69Np0vL3oDT50CTVHwBCVH/tMBvOoOWkPWLot7mTcLAhwADZz6APTODZ0hVkJ5l+RzwJb81H8nw6xApbmoBDATT/jw6OsR8EzZ+oEDBoj0LrTC1xhwiPU/74KNTO3OACPZ4Ti7ZKssHCZSJlaot2wj2guZPrOYaQVAARicglJwnS816nMGMYvzJxa2ri1DjSEf5UfNrWhPaztPfBj/PhXiCp0Qog9AbGdz76nQyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2hQb4Nvl+0Ps9qDrk2gupeReaTQ2BjO5pqYMR3hds+E=;
 b=HEbIHsHJC2fseQbG4P0MTHtsLOxK/wcGsBqYo9lDdhwFmGN6metE0azrqQZcNDS0SmC6OsAAmzRvGJJxCm3DMHOhbuE//Ar+ltQgWrY97QyOv+mCsQL53tQRGm75x+pGvgmRGCnKrziJxzDW1Qbvl2hw34FJZBZz2CW7zDnPDICSNs4rYRE98XPynusvnxOaFRBRRP5qzjCHEudf0oss+2LQxwstQunm7pVfYYt+IjV01l1m7Xiz81yMYuiKKNnPs/tfkPXr/k264X1/p3hx4BS2YfE9C6MkKmuos05jdI25Om0xLTXTUqBkuz1fLRj6tdJCvxx7Dv0OPiV2bi3Tlg==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AM7PR03MB6133.eurprd03.prod.outlook.com (2603:10a6:20b:142::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 16:11:55 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 16:11:55 +0000
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
Subject: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next method valid
Date: Thu, 15 Aug 2024 17:10:10 +0100
Message-ID:
 <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [WjddbNVysARXYnm+NXADiM763c6v8Xen]
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240815161010.605444-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AM7PR03MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: f2ac063c-e757-418e-3a64-08dcbd44fadf
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|461199028|19110799003|15080799003|5072599009|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	575XHwxdqO7qtkn99AtooRxANz74RFg4inTID+srTDMdlFCIolYILIOWAdnaKrBtgS21sWwKm6ja1MWkSaoJDRqBEama05K+sqGMUJ1GQ4wcSor5eG2SY2DfCezafRmMVpXxBop6ewW/fwOYkSds8tKnw7ETU81tGO9p9ty8hdBMvKyoWGB/IEXy9tJiT7xHg9203vgQ4cAeojQlzVBeu2k2jJI8HtcaPT9U8sBsWHL5bEUPNWO02OkpQLIm4LEkhQluHhD3s/uFRK93oYkegEV925D4Xv3ttnKWqUlUQc/ieZKG+zSdoyd9innum6UHwzdXq/R2z0xzPJQNMomGQJG1b+/4JH/thQmpZtf+7kgwKq/vuhcLdgv8FoiPO7mPYvuDnU+FQJVvP38re108U56JH7YnmF5tEb5qA0GdLwfk0Kb0KpnH04kQb3c4SqIGh34TVTrK5SESSGcS+5IgymbHsstoD6xVqxwPv99DbCzD6CykckELjfB1zeTyiyllziNhCsR4MCfLT6nA8g5zYZe56oyFXZj93MEw0LsXlLMwJYeqKtn3Co5GhTIEpaIeGZk8CF8Wqe3HPuoRlVVYIUprsmCDQmnaxBzReKpKy545czYLue8leb91nn2Ad+QklTZlUNeCIT4RNdKPFjJfV5Ym6okJxdgfx50StyvmEtXYT/vj+6dF0ga7zi5U5IVovRHjaA2xHoAas7foInYnUw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OGli+X+YS0aJl+wAYaKot9Y92f9xVNhIIltxuU0i/DYsmakLv1tYa+B/EOqC?=
 =?us-ascii?Q?idXSSdb0jR8ciq1MeCbvWv0JKvszBFs1miQsZDRMIkbCkc7eLATFyP+6kY0X?=
 =?us-ascii?Q?N4YA4mlxCFi49R6YsDpIKoGdMzZGxFMCyuHo4rinVBYIPOcDYTA0LHyNbf1h?=
 =?us-ascii?Q?xURlGmQZzU3KNzBP02+3kMg1c7CbrjXzsN+SGZru6obZP951QZxpZ+i5yCJE?=
 =?us-ascii?Q?LfaAKh56dKpy4q8NNgKCcYQCVo3bS2iMaRHIKtz/WmVX5xwfEJymE8Z1CYe6?=
 =?us-ascii?Q?G7vOQuLewrC4QF7wIHKg59bsvhwblfzh6CInHb2zA4MNCdRBjxNfMlZYem+j?=
 =?us-ascii?Q?7ZrJizOGfE0WX2t2b4085MGtofN2xKP6rbBI9nARjEVIRJTjRZdRNWnjTMVP?=
 =?us-ascii?Q?xpbbEogC7/r09CJ5bG3RFjxi1Pv2K1XGjJZOdZ6ZX/+B5EME1y6tYiNluLtP?=
 =?us-ascii?Q?dIT+jPDL11tZ+jQgboAMilu1nGOKPyed3x3xaTVtmbD9N8s7+bPwHzcsjATO?=
 =?us-ascii?Q?teFCObinXclYaV/hH4eIm5l2tR8/wj0COYOfCqNuLtpEHr3aVs+f/qcFB5lf?=
 =?us-ascii?Q?qwGN0IFHorSpTb6kgRei7y/WkIDTVNPIcLwNUoOWUguKIjR8hfNMMeVvzIKE?=
 =?us-ascii?Q?wKUUR5ra3SeN0+zt6RvQ+vPjyHHBL0zbQEamaP17hY3I9JFDyYE3pNyamyng?=
 =?us-ascii?Q?hpDYx5ab+ulWAylqxWMsIeUHEIkH8pkM+IO6w1tzmgBQMZDJVr47j1pFzrmN?=
 =?us-ascii?Q?vcTB3OQmD13ZvuBTBDT+wdQrloIvhRrOc2H5JZQDjWrEYqSQYcReN7M0/pUp?=
 =?us-ascii?Q?1sIK/wA8nLDK0T2cYuLsOQyOyT1NDgLidEHdRwugg8LW5+8OT3ca/msfYads?=
 =?us-ascii?Q?LteDeSUBtukKHrEL7Kw5tFWz+1/ITI0ptwIHcKp8rm0+DexRKVPT8zHeSTkV?=
 =?us-ascii?Q?Yb4eBt0s4/+L/PMs4reXbzcG4nd5cAAZM2Caw170DiLV+msrLgB8QzMrdniR?=
 =?us-ascii?Q?5d/RUZvTwy5uU9s2oD4HzGeZP8xjXLrM8aRlZVbx5XIKfFSZUm3F1XZyqisS?=
 =?us-ascii?Q?iaHTnl0/00F7+/06tYROgsWAA3V9jIL9/90hMLJmeplok907Fh6PxG3QWMDO?=
 =?us-ascii?Q?sxVqbD7OHJxiU+RZA8NgZIS9xgGSGxbDTcVwfYvM6qLdQfygu+COYNu2J7T5?=
 =?us-ascii?Q?R5wXatic8oqx+w6SBOkB5L0Vt2qNSCNwaA4D8dLLgcCeuBI3FzKD/UzfywN/?=
 =?us-ascii?Q?L9hl/BwdJytOPQMOiOcM?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ac063c-e757-418e-3a64-08dcbd44fadf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 16:11:54.9103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR03MB6133

Currently we cannot pass the pointer returned by iter next method as
argument to KF_TRUSTED_ARGS kfuncs, because the pointer returned by
iter next method is not "valid".

This patch sets the pointer returned by iter next method to be valid.

This is based on the fact that if the iterator is implemented correctly,
then the pointer returned from the iter next method should be valid.

This does not make NULL pointer valid. If the iter next method has
KF_RET_NULL flag, then the verifier will ask the ebpf program to
check NULL pointer.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebec74c28ae3..35a7b7c6679c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12832,6 +12832,10 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 			/* For mark_ptr_or_null_reg, see 93c230e3f5bd6 */
 			regs[BPF_REG_0].id = ++env->id_gen;
 		}
+
+		if (is_iter_next_kfunc(&meta))
+			regs[BPF_REG_0].type |= PTR_TRUSTED;
+
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
 			int id = acquire_reference_state(env, insn_idx);
-- 
2.39.2


