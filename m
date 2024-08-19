Return-Path: <bpf+bounces-37495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB0956812
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D65DC2833BB
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5727516088F;
	Mon, 19 Aug 2024 10:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mhu9opnl"
X-Original-To: bpf@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011027.outbound.protection.outlook.com [52.103.33.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38E1165F14;
	Mon, 19 Aug 2024 10:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.33.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724062591; cv=fail; b=rDxU5Phy+8DajbVRN4KbxrHJIMwqMqeY9ZsrqAYWJbf6Dv87ScWbEwyDU+xL6/IWUNtuJJj9efobHF+WE/ptbD1FED6H4hahNpe87p2JVyyyAeA8q5Z3bdCQNq4hJiXLX+gDyrd6Z/FSycjnhbLhyDhoxykASJ9r+SlAvMDwEsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724062591; c=relaxed/simple;
	bh=KsQdJsgBkgsrgplVh4rZ+1UCcpaCmhEvl8mfS6/cNMs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=INRP67TqQX+vivEK5YUOHKVJduBLIFbemo76DknmlncHvMiAO0SYNg15DA8LlQIaQUV13o51xu2fDRGYfpYLjXCcTLOrwqUe1ECWCPVOPyXSIUIWjt3HTNHdkzvEfac3BBr+6bN+xA2ZozczPHMhJ5jE/Di66wWkIiLyn7eOkI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mhu9opnl; arc=fail smtp.client-ip=52.103.33.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LWGcdwFgS692x5Klf504x0b4e9sNuyxQeTY/FspvgMfISahUS+7b9DUwP2Hi770c18ERSVWMbsYUm8K5x0sreu2N9aoUwpvnFkbs4GO83++wvKsgK5lvRHUmekJAheORhmyObXm1GGvISHz5LxEo5FwzqE/A5jW7pwS7V5V57dZPvUvvWSnqjQHQu/jdC4R54FE2xVzhOxzPVCCI3ju9qj4iJZIv9UXm6CrIsF1vGnjEDAuiS49M4eyaOSp4+bJoq7C6XQ7QpDpDx53HLdvOFalE6BWE3H3f6kHmHdpaTtDWX3QZXmwhBYHROvvb3RfAPrMtvqJFT5GLDKcXgho6MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSO1Fp/Uii6BaHYkbchzc2eyOtlTYi0WWMedNvYDons=;
 b=xwDqax3ME91WyW4a+Qe0Mfet9HEPkUxl64Rwq065jzXK3j+UFREtwYpsr+iTp84S+ISJrAvlqWRp79rKhBkUHXw0UaMg+hGlYUhe+ojgaXWad/yMJhilEvVcd2BSnFiL7F8bzfzjsggE8ShfFDFzOeguxZZsmRnbLBh0Co/XC4Q7fQRJxoDVfqt57kyd62t2i5DdWZIQUZxJpoQXYRmCelWIGJZvBtXYVaJHjVjClTdwfvZzsCZlL1rxaOh65bzXE4wS9gxxpp0P0ZWPSNtjA7xIZqctbIBeH+LiSDWr2pCZlmzueXhF6RXtk4/r1yVl7Yic0R1Kyrmszs+sXJ/cAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSO1Fp/Uii6BaHYkbchzc2eyOtlTYi0WWMedNvYDons=;
 b=mhu9opnlhDxaKaNWynsS+JGHcpKl8O3RuQYRnOF2ayXj8jBksoKLg+xrN0Bi/Lf/sRaeZGQMeZgXMuwneYnb+hCFOyzho7iZP5dMISjVhkOD9TQlFGJHYVpzZyNFXuTakNqR6vTrW/ncGqM68VFQ7hfvryS/WkDkeqobGyaysaRZ6dSXdOFe5RPdXdwW08ZjfLfTF9Qm/ePBxIztKUGUTqYIujpU82PM9zl0g4uXmKdsQFQ01kd9yMiORRXw9vIjHCGycCY80D4qrgcf+Z5rOpfenrUP0yDC6K406xLJ7aNm8Qffz9SeZwodrnYDUp8L1dz1mQPdf5s6iKL/eOJt6A==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by DB9PR03MB7291.eurprd03.prod.outlook.com (2603:10a6:10:221::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 10:16:23 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::4b97:bbdb:e0ac:6f7%6]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 10:16:23 +0000
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
	memxor@gmail.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: Make the pointer returned by iter next method valid
Date: Mon, 19 Aug 2024 11:13:52 +0100
Message-ID:
 <AM6PR03MB5848FD2C06A4AEF4D142EE91998C2@AM6PR03MB5848.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [wqRm7CFf1S7KHOwdTPMhVXW/T1gw0IwD]
X-ClientProxiedBy: TYCPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:3::35) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <20240819101352.62730-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|DB9PR03MB7291:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d3f162-3283-4c52-7141-08dcc037f9ae
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|8060799006|15080799003|461199028|5072599009|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	NtoUiFGpdX7sFCyWbRqrKBADYKhsd0/e0duRCEdsWlp8S/NdhvPAfFjCu9r2zC4tDDbaQ1skz9a2GwLl+Ioe44aAcNM9Ulgp0LoUOSEhJCKcgHxVBndxfvS1pFPIV1+qgVRFrG7RI4WW9lD9Illj8C/ZDXqQ55iHKZ88w1EbIdvOgidpT6sNkaTxYcqLgjCMCabjirmLrNIxpi11RKJGPL27VsdpucV+DeSvSFf1FUDTZOvAWi2wnjVHFoFKmIDLRYHU8JU8kO+OJ5osB5elOdolIQzIWBc2YNbWe0H/Y7d6T2WBJWMHtSWF/GjaU/4U1WOQIjditUiQJ2iYVJBYMzwi43fk+stfghOFDJagM6HkCrwUl4oHrRMrg8jlXU60xmAGRvV7FEwpK75d1KoKvt7/ObRjOLUnljDfp1E9qXthObVhsrys1fJh9faP5rHn+Uejg0+1oOPoJ4n95DMqFBHqgB6xL7DaMLvS9g7uLTR/M/twzrAi08r8ywxyMphh4RrWnHPf9UTZ7zwY/MpiPL/NU0y6rJX4yRvYSoH8rwJTsuXUsAqCgz3zYjhP3fwTNBR4ogJ+JeS+9k56TQzRQGaeKVnVlk8BWixLHkLC1KF/xULcV/OXeNECKTm8kxc5oxuGhbjgqWUQ5Q2/uU78dzuqQtZZWM0uS3iWLJR3aWnpVc6Fun1GGZj+ACWCS5rYCW9jhLt92/YwcLjUt39XDA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4qFOrlV6iVjz+re+Theb4EBTZRk4An1R7UJTddiSBfppNd+PQadIt8Hb4PXD?=
 =?us-ascii?Q?AO3Zfw4c8IJvoJw02IYNuhv3hfS0sVFoDn7Pke7uhAa6npsSgIYo5CcoP3Pg?=
 =?us-ascii?Q?7gRSQQ0lyJhSrTu4+BC/nTc9moUTofUsfvLNeA57deYO8HwRBwmhXFloTAgg?=
 =?us-ascii?Q?RLFj+/xbFlKlh0xA4BDZCw8d76Fykyjzez34nKbYx7xaFI90W9RbdXgbfzZ/?=
 =?us-ascii?Q?RXiwdmyahYzNUVFiRF0NSdmvioALsWpkUKS2Au1G4Sf/Bg0UQEEbrjubCjmd?=
 =?us-ascii?Q?cQhJodFOLnz8PzcemY6dc4x8IdyBmDtPe3rsZsqlJRBBhwlclu0irTBXEW++?=
 =?us-ascii?Q?e3MPig+6j4AxZ4LgT2763zZ5uF+7AsAnHbyNZgk1ePWscmpg1R9whL2nhlCg?=
 =?us-ascii?Q?rwRsWdbg1A8DCn/F6o6nuDKZaBi1dGpgWP323B/vV+x4BfEVBuXBThBT67Ze?=
 =?us-ascii?Q?K+1KhMaxF/wpwZ/88egkKlQFswfisN8D+fn5PITT8OamWEoUpky/bUZwHioJ?=
 =?us-ascii?Q?gF3mUjIsdOLy+9pDdB6/ZT1CSXPijEDuQhLoXnG7oOyUdOpg3aiLyDGTar7k?=
 =?us-ascii?Q?8kTS3TiWgnMqKwYa51UryAOA5Gp//vq6mQnGtP8SA2QdGBKCjf7T2YRmBoB1?=
 =?us-ascii?Q?EyycjI3G9I1BWFHH6Eur6EHtTG5V3xN2JSAOa9BGHJyYrxbbWXasrmBNID2a?=
 =?us-ascii?Q?AVEzRELy9zWQh3YQWB+IV9vyuBUgFBGeZky57NnK7VL9kaYdlGUsGfLNw/6Z?=
 =?us-ascii?Q?seXNNcFNX4UYqB/0AydDCZ6pUjSekyEIToRTdB0PaY6IncMrrqm36cLSEFE8?=
 =?us-ascii?Q?EOTNk4txpkYcBYszdWoGujebXQQBCjXWAFBzkuVTerLXa/gYflRM7nIhOANJ?=
 =?us-ascii?Q?UlH9h+WvFyID9vycCTMAzYwabryp7pwQEbl6RegJoqq5fqFtPa3ve5D6egDy?=
 =?us-ascii?Q?72BvieI4tL23jfsrFghhaT0+FYfLavZf/L7NB38amhqOqfd7bRp7iVZRJ9r1?=
 =?us-ascii?Q?KVGrNA6A2c8/7jBSiHnNVx3MDOMYvMLYU7xaRZ2dQeF/VePNELrApwCZRHIn?=
 =?us-ascii?Q?7/OnebI84haYqkODyIIthoT1IMbN7FKFuszrvbXAVOTqUUab5z7lcgvuKe/g?=
 =?us-ascii?Q?XKjDdAfsXG6yCKjUxJDlIJN2Z/+CJmgr/L2rQUTrLJx9zpzJD+bsW86Aqrec?=
 =?us-ascii?Q?ST7VQ6i13CDy+HygWw8VAWwRDCi6P5n3F1CSdL3vB5cg4YsmR/IA+s9mwu2I?=
 =?us-ascii?Q?CmL6IxNVccKAnMtVy4wB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d3f162-3283-4c52-7141-08dcc037f9ae
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 10:16:23.0717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB7291

Currently we cannot pass the pointer returned by iter next method as
argument to KF_TRUSTED_ARGS or KF_RCU kfuncs, because the pointer
returned by iter next method is not "valid".

This patch sets the pointer returned by iter next method to be valid.

This is based on the fact that if the iterator is implemented correctly,
then the pointer returned from the iter next method should be valid.

This does not make NULL pointer valid. If the iter next method has
KF_RET_NULL flag, then the verifier will ask the ebpf program to
check NULL pointer.

KF_RCU_PROTECTED iterator is a special case, the pointer returned by
iter next method should only be valid within RCU critical section,
so it should be with MEM_RCU, not PTR_TRUSTED.

The pointer returned by iter next method of other types of iterators
is with PTR_TRUSTED.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
v1 -> v2: Handle KF_RCU_PROTECTED case and add corresponding test cases

 kernel/bpf/verifier.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ebec74c28ae3..d083925c2ba8 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -8233,6 +8233,12 @@ static int process_iter_next_call(struct bpf_verifier_env *env, int insn_idx,
 			verbose(env, "bug: bad parent state for iter next call");
 			return -EFAULT;
 		}
+
+		if (cur_iter->type & MEM_RCU) /* KF_RCU_PROTECTED */
+			cur_fr->regs[BPF_REG_0].type |= MEM_RCU;
+		else
+			cur_fr->regs[BPF_REG_0].type |= PTR_TRUSTED;
+
 		/* Note cur_st->parent in the call below, it is necessary to skip
 		 * checkpoint created for cur_st by is_state_visited()
 		 * right at this instruction.
-- 
2.39.2


