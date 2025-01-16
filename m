Return-Path: <bpf+bounces-49088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5901A14280
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E017A243D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A757E233532;
	Thu, 16 Jan 2025 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="BYhATwA8"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03olkn2040.outbound.protection.outlook.com [40.92.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43214AD2B;
	Thu, 16 Jan 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056672; cv=fail; b=fSXPyFnASs1iq5h7pvINlNFaury33g04yPZF6Sdi2Ql5twqgitQGhezlfQ5rQoOO7dZpefzpZvqTkxz3K+suqmZ6qtacK6N4MbCfwylBHnsUBcpwwyxcMl1J0XeXt2amFkd3GlqUs3FOQD2IqVAzFWmSYV+rorYnSjNE9Rjylto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056672; c=relaxed/simple;
	bh=TdnqlHyEHw6/HWMktIaFaVMal6vOshEfTy4z9mEud24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cWdoXJwrr9di0jCyxge82iG8VMsh3J/2EJyvUfCZRI+ebeYVsZZZirbj0MJMSWIpM4qEBJomxS8n8iEwnGK/EW45hQRvFVUmN78cwN6Pd9pEKpVlFNEyGpI3SQZBchgLWVbJJFSt18p83hcDASaY6E9jHQc20w6564YMpM/Obwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=BYhATwA8; arc=fail smtp.client-ip=40.92.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKIxRcfy/Y4cFwoHS3nqVpHb5DEMwK/l5+nySpzzeI9Rs1s9eM/KGDNlBn6QksJ6+72umFzE9HV7JHmHLkC0Hbp5Gvg8uTP4hW6OnWAlefTB3kRHggFO4SBO6G/RIs2bArp10ksf8OTnow5ySrEWCuj/aK08mphFpsnH3okgzdfndyHy3zpNVL/2kxgyLu4IjyGAMUQx7dv1EvkCuphtCPmhYrWGtmtbhyDtmOUixLkEgZNn8YSQBYjYo2/nQgT8sC2VCl1mlyLpX85QNN8jNt5bdSjidEdgdCqFNVrYck45ctOFc5tRc+OccK9JfybvwpiGtfhsdHcmNrpuxNSuBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvIeYHB/ZIAD8T2ESpfoSLTIGJUkVMWdBsKU9gs7Dro=;
 b=JkcrysWU8ZL5Xdv0MteKZl2kWHyRboK+xbCwWHf4qOCf0dIurI4cVplCQzXNSNEERJiRd0lXX7HnlhwDgiUMWM5UqanJsoUCnGaka54SC5cBOloukjGwPdOvEguTeGJ/Uh6dV91oEVb+JoEJMaUUj0A3Wc5+Rz099DF5D5p1NIGGwcgTeCXq10YzeB97edu2FOJIPV2+fGGkRfqrrUkI8faEwgPWcNUEaFlaiY63PSELQ4JBgXJRy9LHwClRirPl07fBTYhi3noQlrNtJney4gpSdBzezGqmT6vA1nzOsjY/tBJUAyWePBYkRoLqtSisTikG3HjTJUwGzkz41FRT6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dvIeYHB/ZIAD8T2ESpfoSLTIGJUkVMWdBsKU9gs7Dro=;
 b=BYhATwA87JMIaOrqhf3jhNaLRBevDzTaoHuowee7oUphTuh2KM6j43K9sk2rs/it+t5V3/ztQB6f1UhLmJZ5KHUYgyFSw0NmX0wZDHdedFgFtt0SOJd3cZeuywhQPINHIa+ftyTiBx9DNp5Uk8mMCZIwW5U1OtJNMHmFdoqkY+JGNKa16VQ42dugyLOuYgXI53+YVSqPKa72zd0t+dan4QPWct6nTvylWDcDRdMtjK2R+fc0Bf6kKYuV5OogN5EUpe4RBfy6X6GD2DzeQMHcsPM9d9XIZtdGcTWtV3Z3vNKWJmsiFj8ffU4tXDeWSGCIfD9Md9UMYAB0BYr+kAbKAQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:44:27 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:44:27 +0000
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
	void@manifault.com
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next 3/7] bpf: Add capabilities version of kfuncs registration
Date: Thu, 16 Jan 2025 19:41:08 +0000
Message-ID:
 <AM6PR03MB508089CDC0B4E73ADD67BEEE991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d13a809-f710-4a98-d674-08dd36662f40
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwU46ctkesNAQSdI89rGQphJlfXOd4NGK4dtPeZj1fNJdZ6TCQh/SLkHkYr81oaksgrv+flMfLvYR4XUqmRHYHmB6rojPv6DN+8QIXhFI6M1fpRfPv7NPlIbR6jak0okOndjIkOGRYLMhbUGLBlmfcNERIm6cUJrcZBLAYqxXks8S1BwHao9aBD6x6Rp0Rj2BBZV9gU370RQp1ag9vSVSY567cdJsWcaUgx0EEqysZXu+S9xivRZxMFIRQ14f/Ez4bPpnWEt2oXb+dsxJ8GCVLI3HVPRGFn2yO00XgFTMEygZZA4ZzsgoplAX6STtBkLG6Y2AncGSRbRGz5XAZ5uzPftN0Ax15o5xE0hfHrsg/OZnM1HUb1X4iBF5sWg9JXKjuTYOZrydEzFi6HbjZU+YuA7GrPTDf1/KB5KrI/wQOxO55s8Wr4e8M1nHqJScJpIA5UFfwFvXmjw9C0OjseFSCdXspmjMD+fC0ATwslJGmZ/dtjSuqe6Llr3zf3Nidqeidr3ZWf4mWB7TCKmmYb8O5ogNuogUbb57QYP/+E0YRJP80t6Emh6d7T4GLZOoaMSef5nzVFy5qdlP0oVcplkFMtAck+kc6zOlKbyHrz25tP9Hv/EqV5Rv/z3GpGYn8j445iN2KfgGZ4+B12mOsWLJSN7h8RjPpWHFaTzND7aJIMI7Hc1KBIGEFjzngZTV8o8GSnuGQVbKLOenIaLR5qEAqo+XG5DTEFQaPaS0/ZnkSdZOgeSAmBhz3q1a6ax1qefi/c=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025|41001999003|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9rrhcaDe3b2qH4IUJQyljH4Yro9eWxZjEUF56vqVv5uqjyMuF00QHxURlcdl?=
 =?us-ascii?Q?mOTxweKrH09ZdxUUib5bSz2qTUpJj5KyXqwHr+ZiLSAnJ5tI64TAwycYwCiC?=
 =?us-ascii?Q?c6iRPuBNpY/CNjz0sStjRTGwAz91lP1lpNNgEZmBSa9NBzZo4EZ759qeEoj4?=
 =?us-ascii?Q?DLfqifiVjXEcEKRm/60XP6Q/T6It1Dxbk3siZUeXvwkVC1trh7s/DgSGhW9v?=
 =?us-ascii?Q?b9SPHOs4T6u7QBa0GgzNaT5do7QvBiAV21a37W29vg7Sx1NCC1FXPE4cJh9s?=
 =?us-ascii?Q?+AuLS9qi6qaosEXr3e/PzGVgoLMV7HCFhXwmrAgAQ4D25Ew4v8BQciqrRe0d?=
 =?us-ascii?Q?iv80qpBdrFmgnCJrhFMOitHKYl6op/KtcJRTC7w5KbrirAM1LWL3hr9DawdD?=
 =?us-ascii?Q?JnzS4GEC45X08Us+fVKevcpKSLh9qW5H8qPDe4jC5jtwqOTfzLxpk44Fso0M?=
 =?us-ascii?Q?QuA1FyKvZ8S5N7qCfvQtBDKSA9TPGMEnHcZ3xdsl23VYsKoHQRdZ8hjjODIM?=
 =?us-ascii?Q?/kM516fU4neX5g3SceeOQ+nxtVX1++oz1TrfWf1FLM/sbK3gHXtuEZF1NZBy?=
 =?us-ascii?Q?Li491xwiowTW2GeppELM1DVRY6oE/WdZyc0S++BfNRwjqKKu7XlKpaWXxpOt?=
 =?us-ascii?Q?6CujPtsHwL3gy93ICLjFTpwPCQTKstydWgMhKnLNRFmi6uu75ZuxYl72tZ0c?=
 =?us-ascii?Q?7okFiLSPw5T/poryL6wZMWgNtZuILFm2h8n5v50GtXA1WbEMD009Ge2oiii6?=
 =?us-ascii?Q?2QvMDjM+qz7z4MjROVqTkkONoE7YEhdWzWg7Z5Y5Ri84SbNNi6NpJ7jGqQi1?=
 =?us-ascii?Q?fyxaPnOy+P8dCH7JbeH17dj/lEqOMjgim2Nykp3ieO3jMPke/mWlJi21pREN?=
 =?us-ascii?Q?rY1StdRKO6fq3WTRC1aCIks+lWf6Q4FDZPMrSx8/aNdlhhbSYNMDvR9x9nwo?=
 =?us-ascii?Q?OVeFqHWMR3DjWdLEigyBbgoqdLkY5k0+pPbam0rgfyY1S+xlHmGwRz91zm1M?=
 =?us-ascii?Q?2/FYZHRm9TwSbAy2fgS3Gm7igftvz0syVZH6yUG419uViGV00FxXxI/JMe11?=
 =?us-ascii?Q?GEb1vZajURBrEZ70Ie6fAseXOS7hPUuFupndcGAFf8dqscwfmQM=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tLeEGLbD6tOSmpGXxK8kEDsiCSzx5jEklF6t8IQBKOf2Difpt5exDIx8kW8K?=
 =?us-ascii?Q?OjhM4vgLWyB899wQolNnQzuMtGMvs+rhPNH1uzkxOCyKE7G/bOFvUOMPP0N3?=
 =?us-ascii?Q?jgPZtSwNZw171kXefDAyX39/zLfu48y6n3oYCxeHdtb41PM6B9ESPrXsc7S0?=
 =?us-ascii?Q?bERhmHn8kknuMEtUlxI3E4/JD3EHa3Sew7sjzxWyQQODy7By1HK9aSyPl0H/?=
 =?us-ascii?Q?UqaFtdyBzd961x4ufKRb9GpCDtdGZ+5yg9rGWmYNq3N1Srd6AiU9oZOFKiMX?=
 =?us-ascii?Q?b0heKxLIDlZ0fep3Od8uUGPpwJzpAaRT29TxZa2hTJosVnPV7NBwO8+AX0gI?=
 =?us-ascii?Q?b+82y1pX+0LEnYwFh49ToyPmoR6SF5BSdmjGHeFEtBlKOd5dJSwByWuy66QE?=
 =?us-ascii?Q?z3Qqm+wd44/giaVIbg4y7Y5IQ3rb5xqJMjRdET3mxPGhKxjucv5FN3Cxmwlw?=
 =?us-ascii?Q?+8QNGrzzc58GuXZLEunH/XMlsQu94/f1jUSzZmO9Mh3kOSDlcIvwIizbuhnx?=
 =?us-ascii?Q?THuKe08jCvgjZQRNkjy1Qxm9VU/94CmAfid7TnOiGZ140G7NesKgnDVmj3Yx?=
 =?us-ascii?Q?B9HG0S0yZWRO9mZGMN5VXoGxShClm/5SCk0ZE/e9qM0piKUN3k1pEuwuCNDJ?=
 =?us-ascii?Q?3SwnYA2d/jnyeaFROBQL1NvULMX75NRBdzHTxgTsROXjgOXvoTnVm7x4mMWy?=
 =?us-ascii?Q?K7Ou4t842SS1wI2RwIv7mMMCXFkOgg5gL/nwmGpHeSdRIwkpd/atOSVEI+uo?=
 =?us-ascii?Q?MCu6Q8qvAY8Idftkx+NaEQTvb4J5W0MWQgal6Ula6h+vtNn9BdQORdzhumgl?=
 =?us-ascii?Q?g1t77ivOIZgtArLQ1tBaWCQi2FnWbOHggfbAGvcHA6bc7tD85hA9NNQjI7EN?=
 =?us-ascii?Q?L7IikRhL0ATA4sPLojRta/4IJj+6WnpJbDOPI03T43SqV1RX/RsaPChoAbw5?=
 =?us-ascii?Q?rjd8xYZcQ+R3++rRk7rgBSVT+DTwGPdFADEeSRh7Llf21VSTE8i4JILhBQvC?=
 =?us-ascii?Q?9mTLRODirR23hLenbLhJc+eNa99RoeEkDnYMyg4WrPfOMAAAUFtuGuBUnX3j?=
 =?us-ascii?Q?Xv/Tuyxc84dcofIlK27x/oKkaLDfIG0yEjHFehet3kF9r31YZe8HFQRds6na?=
 =?us-ascii?Q?uWdxKXy/WbxlME9+l1/dvvV6YUcA2O8sEmiLNny8ne7jQMp4CQfdHSE3o7p9?=
 =?us-ascii?Q?uF/haN5vXvE+UrRStDAt3t2xM3pFl0z9+kYzkfqi9+6oovC2SXAnRlM9ez5q?=
 =?us-ascii?Q?g4bu5EQgG6FutA5BAExr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d13a809-f710-4a98-d674-08dd36662f40
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:44:26.9145
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch adds capabilities versions of kfuncs registration related
functions and data structures.

btf_populate_kfunc_set_cap, __btf_kfunc_id_set_contains_cap,
__register_btf_kfunc_id_set_cap, and register_btf_kfunc_id_set_cap,
corresponding to btf_populate_kfunc_set, __btf_kfunc_id_set_contains,
__register_btf_kfunc_id_set, and register_btf_kfunc_id_set respectively.

Note that these are proof-of-concept versions of the functions. In real
implementation, the original functions should be modified directly.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/btf.h |   8 ++-
 kernel/bpf/btf.c    | 165 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 170 insertions(+), 3 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 2a08a2b55592..71d9658ee328 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -569,11 +569,14 @@ const char *btf_str_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
 u32 *btf_kfunc_id_set_contains(const struct btf *btf, u32 kfunc_btf_id,
-			       const struct bpf_prog *prog);
+			       const struct bpf_prog *prog,
+			       u32 *capability);
 u32 *btf_kfunc_is_modify_return(const struct btf *btf, u32 kfunc_btf_id,
 				const struct bpf_prog *prog);
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *s);
+int register_btf_kfunc_id_set_cap(enum bpf_capability capability,
+				  const struct btf_kfunc_id_set *s);
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset);
 s32 btf_find_dtor_kfunc(struct btf *btf, u32 btf_id);
 int register_btf_id_dtor_kfuncs(const struct btf_id_dtor_kfunc *dtors, u32 add_cnt,
@@ -632,7 +635,8 @@ static inline const char *btf_name_by_offset(const struct btf *btf,
 }
 static inline u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 					     u32 kfunc_btf_id,
-					     struct bpf_prog *prog)
+					     struct bpf_prog *prog,
+					     u32 *capability)
 
 {
 	return NULL;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8396ce1d0fba..535074527e80 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -236,6 +236,7 @@ struct btf_kfunc_hook_filter {
 struct btf_kfunc_set_tab {
 	struct btf_id_set8 *sets[BTF_KFUNC_HOOK_MAX];
 	struct btf_kfunc_hook_filter hook_filters[BTF_KFUNC_HOOK_MAX];
+	struct btf_id_set8 *cap_poc_set;
 };
 
 struct btf_id_dtor_kfunc_tab {
@@ -8483,6 +8484,96 @@ static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
 	return ret;
 }
 
+static int btf_populate_kfunc_set_cap(struct btf *btf, enum bpf_capability capability,
+				  const struct btf_kfunc_id_set *kset)
+{
+	struct btf_id_set8 *add_set = kset->set;
+	bool vmlinux_set = !btf_is_module(btf);
+	struct btf_kfunc_set_tab *tab;
+	struct btf_id_set8 *set;
+	u32 set_cnt, i;
+	int ret;
+
+	if (capability >= __MAX_BPF_CAP) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (!add_set->cnt)
+		return 0;
+
+	tab = btf->kfunc_set_tab;
+
+	if (!tab) {
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
+		if (!tab)
+			return -ENOMEM;
+		btf->kfunc_set_tab = tab;
+	}
+
+	set = tab->cap_poc_set;
+	/* Warn when register_btf_kfunc_id_set is called twice for the same hook
+	 * for module sets.
+	 */
+	if (WARN_ON_ONCE(set && !vmlinux_set)) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	/* In case of vmlinux sets, there may be more than one set being
+	 * registered per hook. To create a unified set, we allocate a new set
+	 * and concatenate all individual sets being registered. While each set
+	 * is individually sorted, they may become unsorted when concatenated,
+	 * hence re-sorting the final set again is required to make binary
+	 * searching the set using btf_id_set8_contains function work.
+	 *
+	 * For module sets, we need to allocate as we may need to relocate
+	 * BTF ids.
+	 */
+	set_cnt = set ? set->cnt : 0;
+
+	if (set_cnt > U32_MAX - add_set->cnt) {
+		ret = -EOVERFLOW;
+		goto end;
+	}
+
+	if (set_cnt + add_set->cnt > BTF_KFUNC_SET_MAX_CNT) {
+		ret = -E2BIG;
+		goto end;
+	}
+
+	/* Grow set */
+	set = krealloc(tab->cap_poc_set,
+		       offsetof(struct btf_id_set8, pairs[set_cnt + add_set->cnt]),
+		       GFP_KERNEL | __GFP_NOWARN);
+	if (!set) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	/* For newly allocated set, initialize set->cnt to 0 */
+	if (!tab->cap_poc_set)
+		set->cnt = 0;
+	tab->cap_poc_set = set;
+
+	/* Concatenate the two sets */
+	memcpy(set->pairs + set->cnt, add_set->pairs, add_set->cnt * sizeof(set->pairs[0]));
+	/* Now that the set is copied, update with relocated BTF ids */
+	for (i = set->cnt; i < set->cnt + add_set->cnt; i++) {
+		set->pairs[i].id = btf_relocate_id(btf, set->pairs[i].id);
+		set->pairs[i].capability = capability;
+	}
+
+	set->cnt += add_set->cnt;
+
+	sort(set->pairs, set->cnt, sizeof(set->pairs[0]), btf_id_cmp_func, NULL);
+
+	return 0;
+end:
+	btf_free_kfunc_set_tab(btf);
+	return ret;
+}
+
 static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 					enum btf_kfunc_hook hook,
 					u32 kfunc_btf_id,
@@ -8511,6 +8602,30 @@ static u32 *__btf_kfunc_id_set_contains(const struct btf *btf,
 	return id + 1;
 }
 
+static u32 *__btf_kfunc_id_set_contains_cap(const struct btf *btf,
+					u32 kfunc_btf_id,
+					const struct bpf_prog *prog,
+					u32 *capability)
+{
+	struct btf_id_set8 *set;
+	u32 *id;
+
+	if (!btf->kfunc_set_tab)
+		return NULL;
+
+	set = btf->kfunc_set_tab->cap_poc_set;
+	if (!set)
+		return NULL;
+	id = btf_id_set8_contains(set, kfunc_btf_id);
+	if (!id)
+		return NULL;
+	/* The capability is next to flags */
+	if (capability)
+		*capability = *(id + 2);
+	/* The flags for BTF ID are located next to it */
+	return id + 1;
+}
+
 static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
 {
 	switch (prog_type) {
@@ -8565,12 +8680,20 @@ static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
  */
 u32 *btf_kfunc_id_set_contains(const struct btf *btf,
 			       u32 kfunc_btf_id,
-			       const struct bpf_prog *prog)
+			       const struct bpf_prog *prog,
+			       u32 *capability)
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
 	enum btf_kfunc_hook hook;
 	u32 *kfunc_flags;
 
+	kfunc_flags = __btf_kfunc_id_set_contains_cap(btf, kfunc_btf_id, prog, capability);
+	if (kfunc_flags)
+		return kfunc_flags;
+
+	if (capability)
+		*capability = BPF_CAP_NONE;
+
 	kfunc_flags = __btf_kfunc_id_set_contains(btf, BTF_KFUNC_HOOK_COMMON, kfunc_btf_id, prog);
 	if (kfunc_flags)
 		return kfunc_flags;
@@ -8611,6 +8734,31 @@ static int __register_btf_kfunc_id_set(enum btf_kfunc_hook hook,
 	return ret;
 }
 
+static int __register_btf_kfunc_id_set_cap(enum bpf_capability capability,
+					   const struct btf_kfunc_id_set *kset)
+{
+	struct btf *btf;
+	int ret, i;
+
+	btf = btf_get_module_btf(kset->owner);
+	if (!btf)
+		return check_btf_kconfigs(kset->owner, "kfunc");
+	if (IS_ERR(btf))
+		return PTR_ERR(btf);
+
+	for (i = 0; i < kset->set->cnt; i++) {
+		ret = btf_check_kfunc_protos(btf, btf_relocate_id(btf, kset->set->pairs[i].id),
+					     kset->set->pairs[i].flags);
+		if (ret)
+			goto err_out;
+	}
+
+	ret = btf_populate_kfunc_set_cap(btf, capability, kset);
+err_out:
+	btf_put(btf);
+	return ret;
+}
+
 /* This function must be invoked only from initcalls/module init functions */
 int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			      const struct btf_kfunc_id_set *kset)
@@ -8630,6 +8778,21 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 }
 EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
+int register_btf_kfunc_id_set_cap(enum bpf_capability capability,
+				  const struct btf_kfunc_id_set *kset)
+{
+	/* All kfuncs need to be tagged as such in BTF.
+	 * WARN() for initcall registrations that do not check errors.
+	 */
+	if (!(kset->set->flags & BTF_SET8_KFUNCS)) {
+		WARN_ON(!kset->owner);
+		return -EINVAL;
+	}
+
+	return __register_btf_kfunc_id_set_cap(capability, kset);
+}
+EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set_cap);
+
 /* This function must be invoked only from initcalls/module init functions */
 int register_btf_fmodret_id_set(const struct btf_kfunc_id_set *kset)
 {
-- 
2.39.5


