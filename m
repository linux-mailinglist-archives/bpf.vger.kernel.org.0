Return-Path: <bpf+bounces-49090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD37A14291
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4FE188C886
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877CF234CEB;
	Thu, 16 Jan 2025 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="PBBNb1JN"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2079.outbound.protection.outlook.com [40.92.58.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE4322DC2B;
	Thu, 16 Jan 2025 19:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.58.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056783; cv=fail; b=TCF0swhf25w3DiEu93NiRi+JU8Qa9ia4M1BXIGCrfCdHMCimrEfGTuuNrli+u0Qx+D8vWCWyNWFpn5McvHULQf7aystTKsjv4+uVgNQUVEHbSz20ZtX8tb9RsYz2ASIUJ8C9IMTLnAIL2qpY7wF39ZARzkRdgD6o9SadXf0YmzU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056783; c=relaxed/simple;
	bh=OxXjD/dGBq/vZAn2GQDS0goOix0417cy8O8ZQKseT7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+0nNJdUhcNjtzks6z9A0Ev3fMbEY7QiMw09+z59coz5/PYNgwpEsykSm8j+vcC6c8NdSqXScLyk+wYhM9Fb2NYZc1wBPHI+dfom6MrjhNF8dJGPdEDhDJ7GWKMgWH37UwWznJG51+9aF6tekxF6nG3qZ6drlYXvGoRWMXzSZsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=PBBNb1JN; arc=fail smtp.client-ip=40.92.58.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k6sUmg0E42rJTCXENJxcRU+WhDWSPvzbpM+uMhUHpu/4DwhZlX3C3tfHt4ScA4CzfMedc1w06f2oPY+biz31Mp3LvO6GIm64ymG5ZJPzpPgflGsQoFdKTWMvU4HV/8ZgURL9or95709hVi4zy0agE1sivF9pjijHWmpNv/R2qrcamo1EOMdQ933zTVh7a+dJtqGM1oTQe38u6IapeQ6eVJrQCoqSdXbILe04C7+6oDIlEHKQ0/h9/yBdbSnr2Y1Co/3ww9ZeZ9Hacc7eJAOiFN3zt7HfbNmALLdu7BJlAkjaHj1Jc3E2UxzpjQjdUXwNQbHQyBtotyzupbBeSVoFUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZ6A4w4OHkXdtMbn1yg1U3YXnst3cLDL8hDYwE5DRCM=;
 b=wzLE1gy8FNYX3RMQqXjtIVyCIpZGkdpyJIoj/4rvVdQF5sRQaAHP/iAeMf1O3gsOO+vslTm1gyJ0WyeDGFZeH0Vapu/2KKDCPJWq6ZWwYLFKHExzQ2K0aMRkqqci/Pb4YAUgA0vuxfuZr5VKsafQXrVEycwz8LZBc9Z1rh0lnCxJ5CLLavZRyQt2+UF/AKvlGDR//PLnW1h9gQhTm5czc60XZ3mWTsfcTmJBX8OIAIi4iHI9JGPf6KBW45dnfyXJFmjr/87RrKm6pQfM7DbTYE/69sRW+gzKlzJ+Qu40InTTFnGfREVJEHZu/gA+2E0KgGbZAejraODdMx0h21YcmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZ6A4w4OHkXdtMbn1yg1U3YXnst3cLDL8hDYwE5DRCM=;
 b=PBBNb1JNcNMMW4r5iNzGA1KumXFeIHbkyy780r2f+XR0CQxciRm7AiYZdsKhTinPKVMVLe/wfgcxm1qNkYwnJ9dNZQmEJAe/goE9QITeGtoWiwihR4RKi6ERIMtebhLmSQVZz4hTrJWyrjoMDFx48a6d26KzL0HBmVy3Fn1oLEHGWEBrNj0z+LKrz3fuRZZmwG/USmhaUx9nVTMBm26oU6UZ87kIr6CxJqDWcdM4xtgOPthKSe7A8jmmL9DqDmVRyAZRNkNmnFXR/LPIN+6MVlIRwZ4yID0H0Feto8Q/kKzjxd2Gdsf4KtyTxMHuJfeDz9JpbQakkoaldmfLsDNDkg==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:46:18 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:46:18 +0000
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
Subject: [RFC PATCH bpf-next 5/7] bpf: Add default BPF capabilities initialization for program types
Date: Thu, 16 Jan 2025 19:41:10 +0000
Message-ID:
 <AM6PR03MB5080AD77B5A231ED617A5D2E991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-5-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a5e83f-cdf3-4749-efa0-08dd36667215
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwU46ctkesNAQSdI89rGQphJWvyCmanD08b/nTnXOhcKMdvQzGpECoPIv4qmjXoe6E2p5tYkxI56t7Nerty9iwVCTmhex/4j1aRPnaicq8LIeJYJgNVvVdpyPOH55ZXYz3T5BJREEcMBd5srOKp/I57c98P9QRNvM0gcOghnlPlh64xEVozLpshLRDKM6q2UloQVz+PKgy/bpuLjcepZtOFozbsKXzNy5wInDNKX7yFDHcENFaw0gL+AG4HwVirTn024ft3GAQYlZyrn/suEUR5WkUyWOy68FTWOTXP4+7Qp8EZz6TzIashXPIeu1wFyvDJ0G1C2Ta7hqz0o14ztFYPCkW58H4nE3v92RDrj0OB0bESs4rqR9zA/sZU9F6MrGSF8NCzASuoGPATnF5aWvUgpMAnKPN+e+GzBGpy2n8oAumkUSNsGcwgizjycy1ym4fbepuDQC0SI3Wvc1/x2Q/H0VhaUyR07TcXIQbAqHgJH9AyQLa362rHUobA3vJ0ttnu9BTsguQzKz01nF2o2HedRH/4sUNzfnL9rHo9cG53EnlZTkeM+eTUNxuTIgvkjH+E8KvU4Aagzpd+Lc7coUzFFoM02DTb0XGcm+56r8CorwyPLmneAm0gcLuz+u3o1wO+0VfqaNlVUTeRkGPOmLWJzfWlarUpz5GbGXt7KGiLgs5UYLUrH16DcSk/fhdRMD4V5d7UNPnFOSko2qkYyjEGZhwbiVVYqSljaF/2x6wNnyqbtmRZJfgk//NjTb+ZbRxE=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025|18061999003|19111999003|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6S+5rMPWLrCM9df4YY5gdU2sIUA9hmT4NlJcdTzRKLuW4n60FKabVOmt0Qh7?=
 =?us-ascii?Q?ICB9H1VCUVD3bWj8x+DTpm06TfFX1yV2pw0rO9iD8iNAnLdQkGXqk8N/L9IL?=
 =?us-ascii?Q?2qGiW7RKfJqWorn4+gilE7BlWC9EL8qdI7W455Shte+yz+tmUYeS/axJBJhW?=
 =?us-ascii?Q?PyYV8edBKXaSg76UJYMn9TTghEoVRCmT4193rJ4cQ5QATDXgzcrBDUMZe1Ym?=
 =?us-ascii?Q?BOs7ZWjwKaYtLQg3LrrJDlxfgY/lQmubbfkg4AgTbtw0f1C17u2Tf0AhSN2+?=
 =?us-ascii?Q?NVX6Yiqep9TLWJqfkiW1x17xAPAKKzupCxQPA82Hu/Eln1lG0Wk1WBxjw2SC?=
 =?us-ascii?Q?Ic1TQhIzVvWy42y5xMjN9AkBPGUQsO3JCEheyKCGUv/wDq2hH82wp0EZyjBN?=
 =?us-ascii?Q?JIeBGAEYDV03yIkFPZyDf5OxaT/o63GF0LsGawz8EQNYlFUCPInz/3tbhwlM?=
 =?us-ascii?Q?VU8JKcRrLyKQDfQLNpws/TtGt2FwQGV9wDkhxyb8PlXNCtWCn/FAXo1muWiA?=
 =?us-ascii?Q?YsdA99/noQQAWFN7uQCANTgGunNVbBPj+nY/rEZTIqtAscYxqkrEiAcZBLk1?=
 =?us-ascii?Q?VsqerznkHs/n+fHFvL860JZLUiYkeI7mj/UBlQwW0mrUj0tRi2oGFjuA1Agn?=
 =?us-ascii?Q?WRjZfc/cvnROik3FKX5WYi6hbyEQJlafdsrVJXqRa2nXrs7H2ZwIuzELQnft?=
 =?us-ascii?Q?cm4rhMs0b73ns4KL7UVPfV5PUrl8a7avb42YJLn6DpwJmn5SN/PC3dSKSvTu?=
 =?us-ascii?Q?unr0E7ujwCQOQpozIGV7qtL0vCRyp+y93h7A0B9P87cykvVb3269I0PMUp+y?=
 =?us-ascii?Q?RNtyfSv7/F2bYYp1aHI22IZgBO1N2owQONGTLlQBQIO/2OkGqK1P6QeXq34P?=
 =?us-ascii?Q?FK96PUnyfeGDMypcRa4rbXy26Q2+QFbfpH9J2oUbpQpdWUQJ69wtMhFIxJlq?=
 =?us-ascii?Q?nqmJtJ5IVeelXwWZAGrhdJMk3KjIzzE5riw2/Dt9KqFEmElxeizS3UMy20Sp?=
 =?us-ascii?Q?RITLbNzopiA3zrlOTbOfrwQvUTfZ2p8THZXEvhENM+T95SbCimmbwbQbD6rK?=
 =?us-ascii?Q?x+YQo/DM1O8AQFiNU4iGj0tHkBRo8Bz9oaGW3nWup0MkmoMi5cBEZ0mVu8KZ?=
 =?us-ascii?Q?Ted5JcgstaTO0MNloPg0hJb3niBcdb4LBA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lw2T3OXQgAd8ieO+33x2KT6eb2jmWSoHg4XU+mR5N2nU10XvUSv93F1qOI7a?=
 =?us-ascii?Q?BKt3oR4E/sEI2i9y0q32waSNJjqASw7vMfJDuAX9L5cU6bDoj30VvAEHsvmY?=
 =?us-ascii?Q?swjoXOsxmyQN/pkQdnaJMvV6CLrdzQi30PwSbsts/V4OWZ7noKDAb/Ej6yHO?=
 =?us-ascii?Q?a0aWc+t8xwx//pNGw6/rO6ZQDnlg/Qkqcus5EcMRtttPUO+rwyM7y3mRZFfs?=
 =?us-ascii?Q?Sxzy0GIza0tXyma/euvKPFeupdSkBkQjAAfpWeHZ/Iq/MW6ItAu5NWg7lg9Y?=
 =?us-ascii?Q?1oQyWNEevCXOIGa/Qtbi8eoOa/kTTpIcfDJ7Ivbua+5nUUmh++aa2WBXuPtY?=
 =?us-ascii?Q?ZtUSAlGXpVl0vAngbpdg5LZpmQLMWlG/6E/PMRRKAsKMeU4jwUxPrcsgRx+z?=
 =?us-ascii?Q?JXBYa9GwRf0oZM5Un5VJZ+b/4OggSJfAvTN/QXjmtASGeJ3WNvKFShQsjyKW?=
 =?us-ascii?Q?om0Lpe+B+G3bhYrP5SJwKmB6vz4wrI5fuMOguAtCHH8gNznBadkUeGMcVqIq?=
 =?us-ascii?Q?rOvZxPu9dDMIEBCZdInJTq3F8Epds0l72RDYE/0RWFiAdJmhD9EaBY8YJQxQ?=
 =?us-ascii?Q?GfD+ik6mPngpwB8Kj2GKT8eIH7aKiXIZHrUrWcNFQWJyiFOWW9EOLeDxJ9vR?=
 =?us-ascii?Q?wiNKFJcnBcDuPQrAvlttl7IEUI2C41MvfvDmxU4MgFWBNwe7k1zqwdcLnQLX?=
 =?us-ascii?Q?uwGFZKO9WuyP0qY9kRlyh8Wgnuni6VFnxFPfXg7C+iDkAVYfdTOjbe721E4I?=
 =?us-ascii?Q?aWenj3/RHzp4L0aXZZsbhve1YeAfEsg41vh7mHo3rXdT4mdmvOosDtZ9hjOS?=
 =?us-ascii?Q?uufgjfJj7+nhgJkAhE7pRx1HgndWoxVuMCnxyEM/mrM0OYwRba9Ry91tbeQR?=
 =?us-ascii?Q?/6hFpprF+sJZ04ISeEuQU5cOfMHvqOzIlOKq6r6tjHEke0geERfAqoPg0NAP?=
 =?us-ascii?Q?7ldiBxQY+JtDwPHMq3LqYYfjqhKn7ulOq0RF8GJM/QNtCSRboqWs9+jyLxaf?=
 =?us-ascii?Q?W73DKEW9HzwJ3tJFyJvqfM/qblWY2/G1YeLgrvRZQnhzEQjJv0DbRl+X+8R5?=
 =?us-ascii?Q?Wnq/BPNVYM1iC6ojM/kD9RqGtkQhYXdvSeoqHrsDTohjxBPrzK7EX3Roy0Jn?=
 =?us-ascii?Q?+tVhYllf3Z0Ea8lkHJedEzJR5EfKlqCyVUWXlOWQRjttYJj7gvZmHJhITHdD?=
 =?us-ascii?Q?voWjxoMj8Xl8WzZd3p0iEALfU912Acj+QAjntl3QBxaiER+7+Jql+iSZJWms?=
 =?us-ascii?Q?UMBncx0TZ7ugFmScNLm4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a5e83f-cdf3-4749-efa0-08dd36667215
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:46:18.8976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch adds default BPF capabilities initialization for
program types.

Since this is a proof of concept, only BPF capabilities initialization
for BPF_PROG_TYPE_STRUCT_OPS is added.

BPF_PROG_TYPE_STRUCT_OPS enables only STRUCT_OPS_BASE_CAPS and
BPF_CAP_SCX_ANY by default.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/bpf/verifier.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2a321a641b4a..7a69a581861f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -22959,6 +22959,40 @@ static int process_fd_array(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
+#define STRUCT_OPS_BASE_CAPS \
+	BPF_CAP_TEST_1, \
+	BPF_CAP_TEST_2, \
+	BPF_CAP_TEST_3
+
+static const enum bpf_capability struct_ops_caps[] = {
+	STRUCT_OPS_BASE_CAPS,
+	BPF_CAP_SCX_ANY
+};
+
+struct bpf_program_type_caps {
+	enum bpf_prog_type type;
+	u32 size;
+	const enum bpf_capability *capabilities;
+};
+
+static const struct bpf_program_type_caps bpf_default_capabilities[] = {
+	{
+		.type = BPF_PROG_TYPE_STRUCT_OPS,
+		.size = ARRAY_SIZE(struct_ops_caps),
+		.capabilities = struct_ops_caps
+	},
+};
+
+static void setup_bpf_capabilities(unsigned long *bpf_capabilities,
+				   const struct bpf_program_type_caps *caps)
+{
+	int i;
+
+	bitmap_zero(bpf_capabilities, __MAX_BPF_CAP);
+	for (i = 0; i < caps->size; i++)
+		ENABLE_BPF_CAPABILITY(bpf_capabilities, caps->capabilities[i]);
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -22997,6 +23031,9 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	env->bypass_spec_v4 = bpf_bypass_spec_v4(env->prog->aux->token);
 	env->bpf_capable = is_priv = bpf_token_capable(env->prog->aux->token, CAP_BPF);
 
+	if (env->prog->type == BPF_PROG_TYPE_STRUCT_OPS)
+		setup_bpf_capabilities(env->bpf_capabilities, &bpf_default_capabilities[0]);
+
 	bpf_get_btf_vmlinux();
 
 	/* grab the mutex to protect few globals used by verifier */
-- 
2.39.5


