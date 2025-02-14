Return-Path: <bpf+bounces-51597-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6FF6A366B0
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 21:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67273170755
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 20:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37161A2385;
	Fri, 14 Feb 2025 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gRUERPLA"
X-Original-To: bpf@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazolkn19013077.outbound.protection.outlook.com [52.103.46.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07B1519AB;
	Fri, 14 Feb 2025 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.46.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739563865; cv=fail; b=nKG+i0Dv1rj0miB/j5lYPWqr3Od7GZbqTsu3+vgR4x7cbu/o1sG+L8Kx6faXHj8bn8pagsa3L9kQlZ9dsAnV2U5rnaUfcFMhKip+EqFdT8hmFwevCy5k7ryg5ORhGzq5d3s6F/a0ilV8CPjDxefRi1bcuG/J8bAfJFGeIbOr690=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739563865; c=relaxed/simple;
	bh=xktCERVD5xDs4DnaIra1BMqHrMLfwVEyc+m63Zblc5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHjKSLkBX6BX8a0519ga2ssJFvdzH7nnUm+WDQYs43i39uXeEbTP2kC2RfRqhB/BQ+4YmEIGqRvmLpI3kiZO9JaREHpxHVsUiAa1giNkHZLMV6KOl+NPf28kDnGPb193055hbkAMOaDJCfGAUfSySQ5rOJyWayr0UeYLCShmmsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gRUERPLA; arc=fail smtp.client-ip=52.103.46.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWSFjkpBhxKw0lckH8Ljwr6WJGYPe45tlgeHOCLa9IImrYCg6MupWFvDNuyDOE1WX2hOhDDKWzuVGvTB1tfWQNs/vwC0/99yUYOHkWh4ZiW44f89Ld01i1npRVbCr6ij+K+w6c6rw9lkNJBp7fqfiOZRRWT+SfBFLipbdSuWcLLrh9LbylmNcIjp+ZXaFxjNmGCWUwCs0oQFrGOZX0B8wEU6MbBp7Kg1owZliRGyDvrrTipkAjo4Jdp8SjrSYH5RGeXn9Tx/87JSRjKN/OBjglbWiyg1OYIIuSx/oYCNEmzbH7lYDkAmBMkJRYbxg0Uku7XFTn1PrJk98WF/dPzmsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrsSAPEZMK7IeTUEHHx8wwr+wt9kOHcl7NyA1AgY888=;
 b=jeEhl1XEBKCWfCfupGVpRKVw2Ig1coUeji0iNAWbjv/NdC6fTBH/zdzyrWwnYOjdbvAWu8OeY3uh0RUZuCMfmb6SmrT4a3LcxkcRocFhci3eQPCTRxueRhV5aEvqSlszpLfkpglbJeu+dXm8nK5/N3wnVTWkfCdmonl8Uh18k+K1pcOomY7VP7jr26VXHbknyR3zHkerTJw957D9aSceMjBs1PlxaGZIMpXJrK0FnQhADv8dYcxBVWw5UElFomYcqZ206rPaNMXrkBinzH8IdRfSgSRDeDGPEM6v7DQJORc0cNqjDZQKG3jenyjq1dtB/15FCq8PLE3JzLf5oI3FjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrsSAPEZMK7IeTUEHHx8wwr+wt9kOHcl7NyA1AgY888=;
 b=gRUERPLAZSGvNKR+43yfHgo+nuj6xi4+yklmKwn2keMy4EVY/yOdy5xStjC3FvaG4+BumEYL6eKiySbQPu1hmvHtWbM9WZoJfobgwfjwJ8CIZecQZvCHf5IUZOA5boiX212I87GhsH351dnY+E2bi60utBS7dgSDvYdp0Aa9s8tW4juFqqyX08eu2fL8mknsMgBzlZU+MhPKOFGuD3avebdBXnJ4QRzXBRVv1qxh0I3pxgZvVdmpp3zFQhJtRKaTXtplRTI4Aa/v0jxRbB7wu/TaTQwA1W5Gv4nzfPwZOEYP/ZeVtmf5E90gfoPSMNxlGsp1AxRqSpMl5iYR92YyiQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS2PR03MB9931.eurprd03.prod.outlook.com (2603:10a6:20b:643::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Fri, 14 Feb
 2025 20:11:00 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8445.016; Fri, 14 Feb 2025
 20:10:55 +0000
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
Subject: [RFC PATCH bpf-next v2 1/5] bpf: Add struct_ops context information to struct bpf_prog_aux
Date: Fri, 14 Feb 2025 20:09:25 +0000
Message-ID:
 <AM6PR03MB5080B609975B60688DC13FED99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080855B90C3FE9B6C4243B099FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0277.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::12) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214200929.190827-1-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS2PR03MB9931:EE_
X-MS-Office365-Filtering-Correlation-Id: 6904d567-fe07-404a-1ff6-08dd4d33afe3
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|461199028|15080799006|8060799006|3412199025|440099028|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NusUOBO7/JaUWe9EV9QeE7OiYogRKW/312vQv9XkIeGDxFxq+y6WikvD0FSv?=
 =?us-ascii?Q?e6RmoeTbnHyybt9sWZEsPCEO2dh8fR6wjwqmu05EV8ooEwiy2YjXtpBcdGuO?=
 =?us-ascii?Q?YE3xTDB6Tu2hC4+coAiQhAeshm7HWm4L0y3wft4ZH4lr2vEtXwr6DqMNdQWm?=
 =?us-ascii?Q?pMNVpBt364U/b0YqPUOn7BnyLsr0Vzrkuoc7MHSorGzsmMlCMFHAg+YcnR1x?=
 =?us-ascii?Q?4oimcOzMLGNRyxqRvpLVU3SYLtT+K/Qxf0HWPMhrao/M1bNOzv84UUqf6vRg?=
 =?us-ascii?Q?ZX96lmNm7chmBaiMWU7VFG5v2uRIrgIAmbUcYqrkOjivo2MZOFBT3U/GhEQg?=
 =?us-ascii?Q?IPFLcl/kKtuWDeJcsU42lf/yfonVbR4YJVwRZdw/ENZP7qWCOxfbJI2fSeSq?=
 =?us-ascii?Q?Om8o0Erv6TGVFIZt7hcQu3PzZIlsdg1NCOHX4TNBj5fMsSdHGJ7g/j3VVE19?=
 =?us-ascii?Q?UX/hxGxRIyDTA91FPivXTyGOwWyHAVMhZ7UDqTT3xeAjDtfQjCQJ86x5jiun?=
 =?us-ascii?Q?joAUcTJciNMPSk9OvTALlzPhAq9mwI109OyDSAepObRsoqZLoCzTD2qhQSnz?=
 =?us-ascii?Q?TQ9YqfCupNXPxSJAx/SdzXKwX8h3ph/4zFjp6z2zhspkUCuddyWM034zo8AL?=
 =?us-ascii?Q?72KO5f2hH2UMgFFNAWU6rnfhmRld42hnirClgs10hBkkZxIO/RWNVuIwnmlx?=
 =?us-ascii?Q?vXyrFHloK/pFzVs+tCxEKSewtfr4adrIH7Ap6PoOLm76qQAnaIKjotB/a9Qo?=
 =?us-ascii?Q?osy2kreqshoJSL6IfhX47ATnVwLBNVZIjCG71N62Y627K67sbvgF5donugzQ?=
 =?us-ascii?Q?TdA262s3FKhSslunydF3zHWUSOU5PA0h2PZXSiopGUKp7Tpn3zb8XJ7tDsk9?=
 =?us-ascii?Q?tNoA4y7EeA1IMAYPO9x/0zGzYbTGIUR/l4ezxdeY38Rz74jQFI6br7cnuq/I?=
 =?us-ascii?Q?xRkJ7zu/7jAqBiamFrQvI+TqYwB0c9TY72eTZZpIUmN+aGmT6tTRk9k8WuOW?=
 =?us-ascii?Q?S66Cl8esL7Zzpl6GNo4WAdN5V17dia1ZFlN5RdEzSnT2fcq9NdpGt+CFavbw?=
 =?us-ascii?Q?FZm7dKs9oZfpgqNAtZ2aPB9Dx/qHqg=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8N/3LrHURzc6I7YJs3LRn/MQ2fiVf8f3MIjgDBX4Do9nopoPYqdH/0fVu5Fd?=
 =?us-ascii?Q?CnzN98kqwODtKaKcJLA6cRUOTZAylxi4nmWWIfPdwBzWVtJNnbRGnKqncBXq?=
 =?us-ascii?Q?49U5LmnVdqZ2S0vpGIdyDU1HJ69ZMUiOPKifCalzeAJk9n9Z7HFK5t4TUlv2?=
 =?us-ascii?Q?zM8K35JLZkB0Q3V/ILo6deQfHgeuuZUAOQIPQqWkqTQu75uIjvgWeFGjpOlV?=
 =?us-ascii?Q?uKl24g8SB+wJZii046LrRFgFIiEo53kh5WPqFBJJ+miujd/6YszHZ1PESF1q?=
 =?us-ascii?Q?U2NVCaFW3o2hWp6eoUixIBwmlvMNuy09h4kNEX2DjsY9CEaafTxO1INSZ5Nf?=
 =?us-ascii?Q?Qnp7IHyc4oJbmjYxTGGIRaqYMI9GPFuDgpDbxbfcv2ANAmybc1IfB81f/GCo?=
 =?us-ascii?Q?XTo7V28CP78jE9+VW/XaTfO8vblRygHzi3jz5dcW+wW98Tp8kieRp9XJx7gS?=
 =?us-ascii?Q?KyIbB2QNQF3IRvNlCtm5xz9iv3SHbvtc/+arG2rPRAhWGhDpjdYK3ChejSUc?=
 =?us-ascii?Q?Ml1mtpnnukVTqzW26HfTCVxPdDJAk2q4Lp+Ahq8hHG4ROTlj95tlgL9di8k9?=
 =?us-ascii?Q?VtRicZqLEUJqTy5gslV/T1KyhouS++HhqJMRUUg9oTPz8urN77yo0s5NIFzA?=
 =?us-ascii?Q?4qd0h5cDS+Zg21PI9nKxOIT92lt6dObf7R+VuaAzMe0swHDMhWgez/VeluhK?=
 =?us-ascii?Q?6j7xNVLf1DcPWg0D8KJHoKEJagl1Zb+jKYKBtuu559DHxJq6kajMeTraVUrC?=
 =?us-ascii?Q?M1sJWDaZWLuNDjAb6BQvozxVPuoT/3Yr3Q8OtEmkIhatUYkV/kJ8atm1OPIV?=
 =?us-ascii?Q?AhfBZeQko0toUTYEh1efQM2WwbmnO0pjBjremHl2PFYSBA5cwaP/p4VmYQ9Z?=
 =?us-ascii?Q?h3zej02A3B/YmoV7Eat1KMcUmUE2K9AKiVdlAw/CosvHGM7RK24h9fT+ulVW?=
 =?us-ascii?Q?W2985beDALRFhxxQafQqTYNmPcQv3xn2Vze89ksrBhrxZuluU73TbyzaKPKD?=
 =?us-ascii?Q?qTeSbrfhngNHpoTKU8ttsaLawrim52Zd6Znnad8Bdr9XiMknXhi7cEv4o0T9?=
 =?us-ascii?Q?UMNqMJGsQ5BfBn5lGbOINd0CInREgqRdrMvoDLF+WlKdjeJ1LmoIdOvnwBrO?=
 =?us-ascii?Q?GFPjIlEkLzP+LHCLyXOOI/aZOUkNcdJsfFfOtZjz0Jru2WepKUZ6L4o2bHWp?=
 =?us-ascii?Q?w9CZ+EVOoEbmngcoKkBr85kEZudfO70zphJ4U5toj8chiklSozTv4BNSMAVi?=
 =?us-ascii?Q?7xbutN9HIhtaB578aERZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6904d567-fe07-404a-1ff6-08dd4d33afe3
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 20:10:54.9999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9931

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


