Return-Path: <bpf+bounces-51760-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A3A38A8B
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9CC3166053
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A985C229B13;
	Mon, 17 Feb 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="iNG6cM3d"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2081.outbound.protection.outlook.com [40.92.91.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191ED229B05;
	Mon, 17 Feb 2025 17:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813272; cv=fail; b=d+rOqzufUEg9hYy4G76zNybMkAAy4f2CgjenusEjDDeDMqB+8dB0DqPW0BilprfDmc04aFJ5EAqOUQw8MyEbsbmEKl1oH/XRqz43lNyAyL7XkNoZASV8y5p96wguBpo5v673C9TnLatXOeuLSnLn+ZRIzQJih0jR0vUbLtd2xf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813272; c=relaxed/simple;
	bh=Y/g6qXI2dFspDb7A2+0na/3GmlOt7ZpwEfzakNGPoqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T+deys6EzszLEXLwEFWJPLBMSiiOJ4CSkU9ISD9Kdo3ws/H8NI4fGyyPGlo6m0y9tCfq4wkLS85Gh0YIZOonbiQj+hX7yHeDjEflTCm+Bcryw6GJteswnef94ks7PL79LmIKmBVx+1yqraIg7tJeLfiO33Mxq6k3ZpdZZA3PdNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=iNG6cM3d; arc=fail smtp.client-ip=40.92.91.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H9VF8BEBnyFB+LHZrNo3yxWuT9By4dqARSu20XH7TjY2X5pxO0Q67DoxlDycIGbanghqLLtURl+RXokHV/IT1sdUxThCn1xl+AJGQ1HXCqGUmCBsF0eyY4Ax8UAHqFUpdqNDv9iTqciAPaRnbQ9SPSh08TJikb+1lkSCXP6bCAl2pK1tPPAmEcLyfZjolPpnCKADfpGUwK91sT/96ldYO7v3hIIQ+ES54LqIKnSp/A5qy05gOkTqHKtQ7FW0ZZUUWgF5+wy7+hv+mHphN0ULQ04PpV5sQB+QD1Lxir8pgGQtXmdWAnCSZbKn3cquK00bKoytEUkEwZGagaG9f6yoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Kc6JLowibTlb9Z3Kq57oZKxBJCZwTi9sKmJoBW8kx4=;
 b=CsvHuhuLSNd6WpUFwCdRXPSOBnKhxFWTj+G80E/9tN1pALj+R5ie7qJQErIiI0YPdV9mogvlvEajb4vRzcykZw301M9nhwHG+lVYBbinhb83qCoxdx40StTHjrfsU1fF9r/mnAEMsZeIT8XOi0Z9TOy0AvhpoePSxq+ecaVBvBd/sqkBM1aNWOXhv/UBLh/b/eyTMfcMtvRrVwXwfIPr1/ltxuiFw6oCB2i9TxlquiTUDVKyc+tCIhnorNtPa2A6HF09YDirFsx6grTduv6YNfL7iZARw32UXjPMYtHaepzrSKa2cb/kKOb4UFTzcLFxJ0zGZqNrYtUjbIxLkxybCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Kc6JLowibTlb9Z3Kq57oZKxBJCZwTi9sKmJoBW8kx4=;
 b=iNG6cM3dHJ2uRup6ZoMYxaTprOOMvt6VzTiRCFuDZYlwCIZ8OMPP5plKqFNPlx+H46R4GFYORBRVIQofj/7nEcZ3y3TWxqQEedVSq+NzWZyMljCLM0AyJur/fI3KV3YD8D0/QGavKSKzi4FjKcg92PrU3ObGnmI0vg7bW/VRSWEPPY4dzCBNcgzPySL91uVn3GWCGkEC1kaRqQ4BnkidAq+A3LmmWU9Aqf/cbHiQokaMfGwNLeWDmrZ+x5kkynh8l7AcSj6fHe4+JMIPHYtunSgmv3mfFwyEl5mqEtkotzqZatm5qgc+iekgu9E8CLXotQpePV62K74tsiBjRqICkg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DBAPR03MB6613.eurprd03.prod.outlook.com (2603:10a6:10:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:27:46 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%5]) with mapi id 15.20.8445.016; Mon, 17 Feb 2025
 17:27:46 +0000
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
Subject: [RFC PATCH bpf-next 2/3] bpf: Add bpf_runtime_kfunc_tracing_hook
Date: Mon, 17 Feb 2025 17:23:49 +0000
Message-ID:
 <AM6PR03MB5080A03B62901EA2AF9C78AC99FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB50804A5BF211E94A5DF8F66699FB2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0024.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250217172350.56184-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DBAPR03MB6613:EE_
X-MS-Office365-Filtering-Correlation-Id: af192bcd-3b9d-4441-58fd-08dd4f7864c7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|19110799003|15080799006|8060799006|461199028|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X9IvEg28ukM7lLkThR5RwZH7iHOhlOjR0f4ZO9gVWoseSs1Dq0g2+PVzD8Kk?=
 =?us-ascii?Q?vD7rATCIwXscO0SZ4R+1n+W1+OgplGsOPGk7G9wqV9h7rxxKRXPq4J1Qjy8W?=
 =?us-ascii?Q?D/1R+EACc5meRt7eBhw4gKdXJuiG0FZrBttL/qkItenvghsb6HkXNr0sD/+C?=
 =?us-ascii?Q?VUhYH59WawxPNyJCYW2Vb3lMBVitUh3La5oRln24wZZUP84EOUdKBDPXNn7+?=
 =?us-ascii?Q?UbisbzI1T8c7lmitK8MQbw266OkMfHaZNrO2CjhcB522uV6LqIU1tSdxpF3+?=
 =?us-ascii?Q?Heo3jMrgsWm4DnWP3vsNc/Na519bhRAQthJkP1mSu+j0yV2My97bvLBKl0w2?=
 =?us-ascii?Q?n0dT6N39OIcz0DoqM6xU51OtikHtw2uD92+CiaNru7ufLwJ2Vwa5eK0wBvnR?=
 =?us-ascii?Q?lq53mH2d+ZsJWiOl4kjxRgE8tbSZoBziSf9xvLrOfR6owO1hFmgCOlPNctAW?=
 =?us-ascii?Q?k2avP2kkMWg3N8dsNOlQM4M6btheHmemRahgQ2SNc0w4h/3TReNt85ILzrZW?=
 =?us-ascii?Q?JrQgj/EZ6yOAR2qrwjSeFlB8VVmugbzFjN+CyXwoMdyt8QGIkTJE/qZZHhXw?=
 =?us-ascii?Q?lnZ/1mIAPDXXt70EwWHImw0ZtQaeUa1HzlmGEfvPvp7OcK4Me5Gq4670PQSc?=
 =?us-ascii?Q?/64Ugzlv1NjRJMe608iOu4PjxKR66ryqKbyq/o7RlHKW2syHpFtbngJrn9ny?=
 =?us-ascii?Q?CfDJZNsnCz2kiCjq4D2ipmNM/zkkHMA26xyoGkaLU2hQgssYOfJYQ1glvwIz?=
 =?us-ascii?Q?3fbrFXoMBCumSUQV50johjXXeLOGG0va6ZGqBxxosDL4BIBPF4wmqK/tkz3C?=
 =?us-ascii?Q?rWlaQGj0EI/oyFwrmNJfOZOsMxpX6jG2Em9GD8zYEZtXaQph/X3chbWNnnUy?=
 =?us-ascii?Q?VE7RtlAyG2/3xpHNfqxcAoZEIhMG9mGFVI26Jx8aGsfHii675wgrWiKAOqYs?=
 =?us-ascii?Q?PRXXeOOcYKlMUY7zH54QieK8B/4T3mfVR/b/O8+8Fcu+P2m8I+X6ajBd7cJ+?=
 =?us-ascii?Q?Xk3ZhVgk0fVWMmzo3iGmj1r24Cfakys0IEAsMw6qMD/Wy9xawvfAqw3H1nnd?=
 =?us-ascii?Q?xxi4gwTievknYQmet/lo4sfQlCaByA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ve4eTiIgLzT0HuEQVrcFTduu7PQjFk0LlZcjC1NXhCNBmGKXhMwU3qK0a+Yc?=
 =?us-ascii?Q?pSQoRXPEouJW1IEDHQYAlynW021ZqDZh+cmOTHLjpCWf9bLTi4rpNTB08z3A?=
 =?us-ascii?Q?2PG4D2bykamHDbXOLFh664Nyp4zKp4i4cRSX17lRl9D1gyElJiA7iFDmxhXM?=
 =?us-ascii?Q?UDhXDfx2KsLBy2WbrCTiBTGONSOz0D5OiS2wzHE6BNIXvZ+UgQGYttLdLuE1?=
 =?us-ascii?Q?mdcToJKpyfpErUaSaNBveWIzOB0F2moGw7+b0x5FOnXRe2xoWvNx4KLPBev2?=
 =?us-ascii?Q?wIUHFl01sJ/xl76a73uJeqVxNP+hXd0awUh0nUyUNdhLqiPPiiD25tCmYRIl?=
 =?us-ascii?Q?BAwmo5kwOPkUE5M52xkv7dPqs7VWXn6tS3ZlUPyBK6uMseztYDFy8clYf5Bb?=
 =?us-ascii?Q?FB/0Nen7i0aJXPSQItUqCG9Ks3x10tRcVFTKByzGK13PfWorU+aPp6ZllZ2K?=
 =?us-ascii?Q?0Prbo6BOK8gzZ/C2TXV3r/bmEw+bMr3sQN87tm+sQtzdJ4v3t11Cun0VH1Mm?=
 =?us-ascii?Q?DxTYBeEqfhz0RvL7l5wxxum0uupkbMDZq8mfvKQ+ki1NotYDtvgPBu3UPhPh?=
 =?us-ascii?Q?v5QJhLPi2+us3pceTQMY7Puv3Bli+pxGLnsjRHoJjq5C1zNMhwUdxLOAxFD8?=
 =?us-ascii?Q?jMxQpwCeya27V2wDrqrq80s7hV+RUT+Bu7LbeL6FkQZH0TEPNgBSv9RKvAxs?=
 =?us-ascii?Q?Rw34DmcJofE10B0A6yZaLOt1VjetAIDXyaBsUJuNp7P4v5+0VXy+/XPxhj89?=
 =?us-ascii?Q?hpp/RFSNYfvRD15It3oqvZgq1OLNEDH9t4FmryeuELGZDDKxXlZENKl8S2uZ?=
 =?us-ascii?Q?GNHLH0vF2stcsnkUfNXuZt6opfgaD6xwFNuYvDnXcuXm5pHsfQxsxQhd985U?=
 =?us-ascii?Q?7Y2lX4x4ihQMTKPHZLV99D5sKEZRwr9bgigEXXkk95X2d09pOk2cJcRn3EF2?=
 =?us-ascii?Q?LTP7Oc9xwEqyn2LlCUUE4TLAG2sB28olJh8a9bod55JZ9Apx5BnOh50Ih1vX?=
 =?us-ascii?Q?bST0Kz1wrIYPfOA/2WmA45mDK/9JnHcY+NKtB2679nRnsbflDRApYl70Z1Ua?=
 =?us-ascii?Q?5ljwR/bq5jqhTVWCwJl7fO45zC6mnh8e1nS8a41cM9ScOMguzjjdcpYj9t7f?=
 =?us-ascii?Q?uLbWg50TTGGD452zrxa7YqeXWcKHRmJzfZ7ld7eR6JDFSbBjQaqyhhLT9Yxf?=
 =?us-ascii?Q?x0E2nRkCp9Udi1uDmhAC49PqkZiKvjUGVMunFnBIbKZWSIIrWjRnEbSEPL7O?=
 =?us-ascii?Q?Gr0XlDoSeQd5quwDWRrV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af192bcd-3b9d-4441-58fd-08dd4f7864c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:27:46.7779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6613

This patch adds the bpf_runtime_kfunc_tracing_hook.

When a bpf program is in BPF debug mode, all calls to kfuncs and helpers
will be installed with bpf_runtime_kfunc_tracing_hook.

The arguments, return value, and timestamp of this call are recorded in
bpf_runtime_kfunc_tracing_hook.

Since this is a proof of concept, I output the information to the
tracing ring buffer directly in bpf_runtime_kfunc_tracing_hook.

In actual implementation, bpf_runtime_kfunc_tracing_hook should only be
responsible for recording information. Parsing and outputting
information should be done in another thread to avoid affecting the
performance of the bpf program.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 arch/x86/net/bpf_jit_comp.c |  2 +-
 include/linux/btf.h         |  4 ++-
 kernel/bpf/btf.c            | 72 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index da579e835731..93714ec975e2 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2198,7 +2198,7 @@ st:			if (is_imm8(insn->off))
 				ip += 2;
 			}
 			ip += x86_call_depth_emit_accounting(&prog, func, ip);
-			runtime_hook = select_bpf_runtime_hook(func);
+			runtime_hook = select_bpf_runtime_hook(func, bpf_prog);
 			if (runtime_hook) {
 				emit_mov_imm64(&prog, X86_REG_R9, (long)func >> 32,
 					       (u32) (long)func);
diff --git a/include/linux/btf.h b/include/linux/btf.h
index 46681181e2bc..c4195479d0c1 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -571,7 +571,9 @@ void *bpf_runtime_acquire_hook(void *arg1, void *arg2, void *arg3,
 			       void *arg4, void *arg5, void *arg6);
 void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
 			      void *arg4, void *arg5, void *arg6);
-void *select_bpf_runtime_hook(void *kfunc);
+void *bpf_runtime_kfunc_tracing_hook(void *arg1, void *arg2, void *arg3,
+				     void *arg4, void *arg5, void *arg6);
+void *select_bpf_runtime_hook(void *kfunc, struct bpf_prog *bpf_prog);
 const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 void btf_set_base_btf(struct btf *btf, const struct btf *base_btf);
 int btf_relocate(struct btf *btf, const struct btf *base_btf, __u32 **map_ids);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 917d91494d00..4d114d2739ac 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -9740,12 +9740,82 @@ void bpf_runtime_release_hook(void *arg1, void *arg2, void *arg3,
 	print_bpf_active_refs();
 }
 
-void *select_bpf_runtime_hook(void *kfunc)
+void *bpf_runtime_kfunc_tracing_hook(void *arg1, void *arg2, void *arg3,
+				    void *arg4, void *arg5, void *arg6 /* kfunc addr */)
+{
+	char kfunc_name[KSYM_SYMBOL_LEN], helper_proto_name[KSYM_SYMBOL_LEN];
+	const void *args[5] = {arg1, arg2, arg3, arg4, arg5};
+	const struct btf_type *kfunc_type, *kfunc_proto;
+	struct bpf_func_proto *helper_proto;
+	int i, vlen = 0, index = 0;
+	unsigned long rem_usec;
+	bpf_kfunc_t kfunc;
+	bool return_void;
+	void *kfunc_ret;
+	struct btf *btf;
+	char str[300];
+	u32 kfunc_id;
+	u64 ts_nsec;
+
+	kfunc = (bpf_kfunc_t)arg6;
+	kfunc_ret = kfunc(arg1, arg2, arg3, arg4, arg5);
+	ts_nsec = ktime_get_ns();
+
+	/* In actual implementation, the following part should be executed in
+	 * another thread to avoid affecting the performance of the bpf program.
+	 */
+	rem_usec = do_div(ts_nsec, NSEC_PER_SEC) / 1000;
+	sprint_symbol_no_offset(kfunc_name, (unsigned long)kfunc);
+	sprintf(helper_proto_name, "%s_proto", kfunc_name);
+	helper_proto = (struct bpf_func_proto *)kallsyms_lookup_name(helper_proto_name);
+	if (helper_proto) {
+		for (i = 0; i < 5; i++) {
+			if (helper_proto->arg_type[i] == ARG_DONTCARE)
+				break;
+			vlen = i + 1;
+		}
+		return_void = helper_proto->ret_type == RET_VOID ? true : false;
+	} else {
+		btf = bpf_get_btf_vmlinux();
+		kfunc_id = btf_find_by_name_kind(btf, kfunc_name, BTF_KIND_FUNC);
+		if (kfunc_id < 0)
+			return kfunc_ret;
+
+		kfunc_type = btf_type_by_id(btf, kfunc_id);
+		kfunc_proto = btf_type_by_id(btf, kfunc_type->type);
+		vlen = btf_type_vlen(kfunc_proto);
+		return_void = kfunc_proto->type == 0 ? true : false;
+	}
+
+	memset(str, 0, sizeof(str));
+	index += sprintf(str + index, "%s", "(");
+	for (i = 0; i < vlen; i++) {
+		if (i == vlen - 1)
+			index += sprintf(str + index, "%lx", (unsigned long)args[i]);
+		else
+			index += sprintf(str + index, "%lx,", (unsigned long)args[i]);
+	}
+
+	if (return_void)
+		sprintf(str + index, "%s", ")");
+	else
+		sprintf(str + index, ") = %lx", (unsigned long)kfunc_ret);
+
+	trace_printk("[%lu.%06lu] %s%s\n",
+		     (unsigned long)ts_nsec, rem_usec, kfunc_name, str);
+
+	return kfunc_ret;
+}
+
+void *select_bpf_runtime_hook(void *kfunc, struct bpf_prog *bpf_prog)
 {
 	struct btf_struct_kfunc *struct_kfunc, dummy_key;
 	struct btf_struct_kfunc_tab *tab;
 	struct btf *btf;
 
+	if (bpf_prog->debug_mode)
+		return bpf_runtime_kfunc_tracing_hook;
+
 	btf = bpf_get_btf_vmlinux();
 	dummy_key.kfunc_addr = (unsigned long)kfunc;
 
-- 
2.39.5


