Return-Path: <bpf+bounces-51485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C6A352EA
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 01:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60A0E18904F4
	for <lists+bpf@lfdr.de>; Fri, 14 Feb 2025 00:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340F5227;
	Fri, 14 Feb 2025 00:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="onHKDsjz"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2021.outbound.protection.outlook.com [40.92.58.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7317E;
	Fri, 14 Feb 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739493082; cv=fail; b=Bmsotc4P6HyS4FJBBAhP9XG3m2hkoMCUfF677nTOXWWiBlzQdlZZwMR/wmIWaambg83Hf6Q9Z/lxejhDf6p/k8SpHDyVlQ7yQMK6J/S+esiHJPbg5+llWpVI2gN6AY130NNWwfgG84T6ykxY7r/pDgbf3C6o1Rjs4e5kfb/t5hQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739493082; c=relaxed/simple;
	bh=sm4fcQXPRhn+cB/EWMv3cWGE2PaP9EnIy7SevCXFUww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QBux3WIYcanEcFCOX6tVxzrzjPVLa9bWYu2HNqTl7djdd0yHYWiTfU4m2bsfSAMv3F+6h9yAywYjiHEj6IHvnmEfMocf9HXAUjVhWrSA6zmZ42deBPJ49OUJPkRvbS324Bu+aynckv1DEGQURrBL0v40apebWiSmGuNMFN8jfzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=onHKDsjz; arc=fail smtp.client-ip=40.92.58.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hw4Cq83sY/kbXPRJ8ptDfKHogDQIeNaShGt34Uwpz8ukkHlE5kO27pSTaDN6LkliUM7ZdhdQ8tucRj9f11Lro4ZJfAfOXVzaYpDxFxRz4Q1nX1jCzTtUowbTCx0ijwcyQ9G2yNO9767sieLZg0rnZ+Cu2wr15TU0kGbNOYn2z4/JzIGn4yr0flsQmd363M6kAn8Q2wJMvaXRr9cSXJEjmbfepYopeQBECotHE9Trww/iX5mBZY3Ut/hkL+oPgp4Tjtm9Dr7G04AWG/YCDJAo3H3LaMQwXwL8uqQFISKKjmQMsi+aa1Pjca1bShs+anxFLyx1gBD6GbDEpEnvB+Tf3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nd6UG5sJ6D8bYn5ZzB1SAka3sw4Qj7oIstrGT1doitU=;
 b=QMs29jvai0GXbI/+OyBZ0QE1DTU8lU3c8SRJ4TJgWS4zUmt5v/CvTgNEOEggs9EQ+5VIPESsFRaYKREOsnOFyTllg/vfCG0pu3fufEybXXK0znhtFiR0epp12B2pUSr8axWoHKsznk4gIZHzzQ9mQ1EpgrQdSfeLGl9ki7CUmOJ8kQXr/NvXGEvwOSr/kujR2FGNIFHi58giiF6zaDd7DJ7SZqGnygBH8syT2kSdCudj4sicoddK+4/g3u9ZD2JoAs9nSxo+sYfvxmQla+eyc6EY/1RmoOlQf4vrMCAbKpgec49IuAbxns2kI1ba6XywI76Ktqk68XMzJYHeZC54xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nd6UG5sJ6D8bYn5ZzB1SAka3sw4Qj7oIstrGT1doitU=;
 b=onHKDsjzIEsjLyfJTNf/E15cCi81W/RV7iTZVwm7gth2B4EkZ/80fVcJVy4hChphmSzQsLPvZzLjWTFnbzYoCZ+eoWm3TWsvbiSW2YRwrG/IXb1eHCk9oAcgtQJe2mH0jyJPFbF2VSgjewIWzo00nOfwalzPZ1EHv6kkRGUBsB2dqEsXQrNELWTLqnVrJp5gAVOjPZE0Eqd3tO5FpQoMUTZa5TeniKY378TRzsvrFw/AMurGZ23CzZD08ArvlN6C8ej/0aKuqojWnH8Kj/T7hS7/Mx45htkPZ8Tw0hHBVLSf+vtlC7CVnqpV41FkgNy+U0dGNbI8cDaO44dGvxH/PA==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DB9PR03MB8869.eurprd03.prod.outlook.com (2603:10a6:10:3df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 00:31:16 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 00:31:16 +0000
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
Subject: [RFC PATCH bpf-next 2/6] bpf: Add max_acquired_refs to struct bpf_prog
Date: Fri, 14 Feb 2025 00:26:53 +0000
Message-ID:
 <AM6PR03MB5080C639B73200461C2087AE99FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080513BFAEB54A93CC70D4399FE2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0229.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a6::18) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250214002657.68279-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DB9PR03MB8869:EE_
X-MS-Office365-Filtering-Correlation-Id: f4a81d44-a550-419c-ed11-08dd4c8ee48b
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|8060799006|19110799003|5072599009|15080799006|461199028|41001999003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?k9ERoa50/t5F4vbDVnZcBV3F9kJiB5I1T2sdbxBA2eSJRJHwquPN3YG/m6qL?=
 =?us-ascii?Q?xssm276vfv5SkwYF9fEtPJJ2q4XUFhz10qaNBTYGnZV5Izxgg050T7P1EVc6?=
 =?us-ascii?Q?Jbch6MeqbBnF3yonhb3HxE/NqVp8oylIYzlVIt+FMi+Up7orwBA8cej0lADI?=
 =?us-ascii?Q?lz43V9u2vBg6Nq9XtDNrKSrWu4G/7o6cYxVFvUj2zY0UBqndJ74SSpxXBfpc?=
 =?us-ascii?Q?qS2/Q/dGxzEsQ3IA1yj7TI89AOq9cuuJXwsCpBwWENu7moOESN6WKpxZDFnZ?=
 =?us-ascii?Q?yDcnDgOKmCPrwLet0V2C8xkyZ4bbeHqACbi9Uuoopi77oLYiKDIAYqZo2/LZ?=
 =?us-ascii?Q?ZNuoal/NmI1vd/tST78dqxeFnqxzPZoiBybhmilGgjNpFCzE7SntsDx/7lME?=
 =?us-ascii?Q?xJ94g5VE3kxsbQnNUyvuRr4CT4uHutHyzldoNslsjW8jnZ4KXWIXhAQbklSp?=
 =?us-ascii?Q?wFwd/Jm6xZaPJoi26QgsNgLvGb/zfrY5g/k7+AkVrqMn6tK6ZjzoPEm8zdF5?=
 =?us-ascii?Q?JuIOxKMri/YOaSx1Q7FgGtAb3QFHTw4TR7pzzx6aXlNvNm9J21FhkaTot1vg?=
 =?us-ascii?Q?cDaRxeO5gE26t58ojCsIN2u1j/tJSViaTkoMIeNfqVTMk28/YHYXgRKmOovC?=
 =?us-ascii?Q?kbI239OwB9dibVXznGqZ3NO2dgNicvh86KRWy30KeSLMtYH71t3oPGv3VV9Z?=
 =?us-ascii?Q?mpv/sd7kA9W1pyo8YPWIwNc3x7okeMan902BQEMFMLSVYHDjS/EAug/1WF5s?=
 =?us-ascii?Q?k0BwT10XqguIxSf0bwZqkc69iPMIyCQJaAtXw6GvcpM2O8VvVkBCgZhLX8tT?=
 =?us-ascii?Q?Z5Zd6KBwdKf4a2/lmozvgMm6TN7YqJdb4WV7CD2Y/YuaU6dkF+cBQ8gIu3S0?=
 =?us-ascii?Q?CUGKLE4Ukec26eNjVOmq0a4y4/cpKLr+i7Z59lcUnhXaWx+7ZVN6wbbYt1ch?=
 =?us-ascii?Q?XihE9dxnmoaEd304AEvEUcJY9MyITtNTBk6Is7n6UTieLKsGneQnimEtyzt5?=
 =?us-ascii?Q?FJPZWrvfriVhAH5TEP+bbsmQ1qAKPLK+JZLkkQZ7YMOAav544teqIzoN9DyH?=
 =?us-ascii?Q?iGcYeGHAd32cWpxQvfaeSwjFxU58Lw=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hERo7CTahg/nDpSlLwoEJCNqktrnil0HLCVJ4Unk/ZJeXmZcAAhT64c++gqz?=
 =?us-ascii?Q?MiWyeUdY1bb8tezQ7VU2Q+9T5BtmDn3o8MwhbNnbelvRelhEiNoVx1hvxmoc?=
 =?us-ascii?Q?xoS2aSldDqniD9aCZCqJ0JYgFHb2Unb37MrJDfK88sjAzZhmPAJgCUq2wVqQ?=
 =?us-ascii?Q?aHZvKoADDpxdfkdEfI9l2Y5wfr7Xw4qwBHIAb9/z9AXua77gEsj5PnJCTGjw?=
 =?us-ascii?Q?QNK/OZdeyw7Prqx4GNTGtEj65ymqqmMCkHchk5IRNzX1XJq4FMOG487iGbUw?=
 =?us-ascii?Q?now56SVKSaEdLG9hpPrHZqgC5MwLoR3ocLgwjA2X5jRPBGw6E25ESgx/xDAW?=
 =?us-ascii?Q?d0P5o20rvM8DvKt73Wb++sk45bvjxSCdB/IgQYJX3zCTQOlZdmQDB9FyPufX?=
 =?us-ascii?Q?CPwL0f4C8txKvmVlxysplTv+PSX8tGWGc285ooWGap6UNGi8zo0e9NQxSEBA?=
 =?us-ascii?Q?2UqWrzj2kDdmJht1mZkXySP9BasnLAeyLLUtjpq4YpH9Dzkeg9jTt5zj2dmU?=
 =?us-ascii?Q?CaY15uAZu1hE+Hef9TzrS63sF2jQm4sFS/J1Ad8hbAc1N+bYd5FFpzfTHnpI?=
 =?us-ascii?Q?rQHhoS2iGheekwKQz/pPC8oirp94SC8ZONXMKqmZZUp03Ddj2xmWORLHlp5s?=
 =?us-ascii?Q?TNBHNp2CVxAI92kLPiQ/cajy1NvaXW9Cf6yjD2kuDSdU0QQb8ly7kTP36Tsw?=
 =?us-ascii?Q?wTt2UsQl83O5P6IY6dyynI2rUZocrnATNnXVxrdfQJom+iQ0Zfen1HA8SjLP?=
 =?us-ascii?Q?T6/E2oScormOnYMKWNbkW6LTm0y8jplQnumky2kPHfUwjYjGjY+iDdOansem?=
 =?us-ascii?Q?Myag4ezNT1pxvqlBGs8vZDBDHLUTuSc78hgaRfTJEk3MxyvQHmM+rktkZdKR?=
 =?us-ascii?Q?Wf7JgtCIJPCiVbk5y+GbqxG6E98RBq6LIVa1298d9grK6thLQ6qG97ymnGn2?=
 =?us-ascii?Q?uwpjTp8rZEWD52qNCTB3yzb0LCx8Qw14Fk05SjqKHFeJ8crcejBDFb1CMLSK?=
 =?us-ascii?Q?veoLaQ9OqW9VepbpEt3qMQiiA93XH6AdrKVDLq003sOo/0If79adYTE+WAzZ?=
 =?us-ascii?Q?XKYVmvPjg9cT+NzMtNejdsXEEPssmJXMgLHksGSyP+uHC+UcsiyWmwUyE9gI?=
 =?us-ascii?Q?TlpbXhmuZxvbC7oPA0CAfNUkzBgkNAdrlyAirp4/BNFMMC/EaZEKSzUtzIYs?=
 =?us-ascii?Q?WEqCozNREkKnNbaf6O/kkZcOMs5jnd/eElMV2w0d5XwKhu9UTU8XnG96yvhv?=
 =?us-ascii?Q?sA/5DBxAiSi9qIvjSMFZ?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4a81d44-a550-419c-ed11-08dd4c8ee48b
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 00:31:16.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR03MB8869

This patch adds max_acquired_refs to struct bpf_prog.

max_acquired_refs is used to record the maximum number of references
that a bpf program may have acquired at the same time.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/linux/bpf.h   | 1 +
 kernel/bpf/verifier.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index f3f50e29d639..3ccc20f936b2 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1618,6 +1618,7 @@ struct bpf_prog {
 	enum bpf_attach_type	expected_attach_type; /* For some prog types */
 	u32			len;		/* Number of filter blocks */
 	u32			jited_len;	/* Size of jited insns in bytes */
+	u32			max_acquired_refs;
 	u8			tag[BPF_TAG_SIZE];
 	struct bpf_prog_stats __percpu *stats;
 	int __percpu		*active;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9971c03adfd5..2d7f5aea90df 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -1479,6 +1479,9 @@ static struct bpf_reference_state *acquire_reference_state(struct bpf_verifier_e
 		return NULL;
 	state->refs[new_ofs].insn_idx = insn_idx;
 
+	if (env->prog->max_acquired_refs < state->acquired_refs)
+		env->prog->max_acquired_refs = state->acquired_refs;
+
 	return &state->refs[new_ofs];
 }
 
@@ -18927,6 +18930,8 @@ static int do_check(struct bpf_verifier_env *env)
 	bool do_print_state = false;
 	int prev_insn_idx = -1;
 
+	env->prog->max_acquired_refs = 0;
+
 	for (;;) {
 		bool exception_exit = false;
 		struct bpf_insn *insn;
-- 
2.39.5


