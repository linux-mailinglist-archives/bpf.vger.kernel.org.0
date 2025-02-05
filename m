Return-Path: <bpf+bounces-50557-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C62A29A28
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 20:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5839A164395
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80426207E0E;
	Wed,  5 Feb 2025 19:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="rRzxVRcE"
X-Original-To: bpf@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02olkn2011.outbound.protection.outlook.com [40.92.49.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB4204589;
	Wed,  5 Feb 2025 19:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.49.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738784006; cv=fail; b=G9o/VdM5wVbKVcVLbsgObRvxmimQ7DJLnyMJrBfRebS9+WjhzvpfjqiH018IFVK1VCRFQLe8Y4rxbyF3ACcwU4EaNHS+7A3UIfetxzpf8KC1t2ZsDl6oUDPHx6PJ0RtETymuCQCI86AMiXiE+NscZKvO5ay4nSrAtGAieip7BhM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738784006; c=relaxed/simple;
	bh=pV0bF+7v/QJHS+cQm1OZ9ubCa8eMx3av85ih8woHmbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HIjIOzrQqnCesfa9bJNCBOXbb6rx9+U++NqnRHufHMx66H8G9CEI4E9GlmZZIb/z8jLtFgTcrqqOKcPvLyWHJ6d/p+XCM35fAEA0cnBY/p3qn1L/d1yNr7I2w1BEo21pzWE6YivUtjIsL/3KbYGtkaHEdRubmz6h2mE2BaHo0p8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=rRzxVRcE; arc=fail smtp.client-ip=40.92.49.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jetf9suCXy3fTYoGi4etYRSAUK8te2s2LcOQu1SnndOrtK+vZG8CJVHodPGeJs6setTMF1eqfFlpGCrrCtKwuOc8VncIYXyzRY+kmZ6/yxQ2A++7BlnxtcM7XKfipXFgKM8drFNxKVLC437FfPVByy6hzqQtcfqvzVmAGPEicEZAJBzBPtq5fxY75BaS5cKP0/T/5kDPrYhoJj/nA8K7xplm13lNsM52EGnUtXnelI/QrJN6zFRZsmOEO8l4jpCPeTOSrurGM9iDFtq6lss2uDD6NgLhB09bAp8D10e5BidvU90Fhv4dYRyM7AOTHVWrN2Bir8l7QtFhpumRoMamUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqsG3ZdvKcatTTaWkqsiLB//W06/kprRGfcdGIv6J4U=;
 b=xhSSWdiyFlmR4fGXDWGLN7bjdCjtq7LJCRWCMG9rwrbmUrTGVTgHyfTWL6pfWh/VcAveY30CNEV30cCNJYFnsNU2uReX9fJejrvVX8kTbTrnmlxOuwUk5zGYkuo+rHTX1D/+DRUREYaP1iYgPp/hwdsDZtxpBOYI+U0KFKr+MTnnpauIoJc0lz7RQixunkrHcYxsvEnVCuKJN2EiwDcoeuCP3irLXGxHl+lw3FRwrDtMonim7BG1advOghStBgtKge2uYHKwZI+QZWk4Gs5gsX8qGiiAVT06r5OzEOcIU2kq6dA1tePum0qMULG4NcwZf3VtnTBj+3kZLXIfunb3Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqsG3ZdvKcatTTaWkqsiLB//W06/kprRGfcdGIv6J4U=;
 b=rRzxVRcEymRy0fE/jg4VGy+XDm4kz6/PansbhBYDJHeWDq34kC63klU06Qyxt0jJSbIxBpMexehriJgPidxzLid5kfcIYUepUzvPkoa8ZpPazyCxM2ZwIYwBHWOme9F0o0IYZgopZjbB8nYxB19xhf/fLXv+SaTGO63H5GB47vBMX5uBDNGIJigAa1ldsU+Y2n+Rp2puLyn0UXwyfWvRMWHkYB3mY6oN4bGhaJsSkpzfRWTba43D3XC6mxgFpnLaQ5AaVlfHjP/eCcx+u7UNlKY7Y2hnE/NXMprgtyjqVjVK/1nCbbEd2b/wBamtE7qRXO1ghEU22WbC9Bnmft6Z/Q==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by DU0PR03MB9077.eurprd03.prod.outlook.com (2603:10a6:10:464::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 19:33:21 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%4]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 19:33:21 +0000
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
Subject: [RFC PATCH bpf-next 3/8] sched_ext: Add filter for scx_kfunc_ids_enqueue_dispatch
Date: Wed,  5 Feb 2025 19:30:15 +0000
Message-ID:
 <AM6PR03MB50807BA3D5FF24BDA684974799F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0570.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::14) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250205193020.184792-3-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|DU0PR03MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: a479b2b9-07c5-4ee6-a102-08dd461bf334
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|15080799006|8060799006|19110799003|5072599009|440099028|3412199025|41001999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U+Gjssou25Uj2iQ4wnNB5pEYxfeS+pxJA3McXAB/XPrK/LiPAfbqrMmre0c4?=
 =?us-ascii?Q?Fv6Dl7l2o5yDS49vjM8OTkbQdEwd3gmCF/0jVYLFS4sHAbFYrcM8AP8eIcWi?=
 =?us-ascii?Q?Gj2hmwmhtSTfIHsXK6If9GiPj5qGb8EKMzN+rXvFWpX24tVUa5zSIHTa0peq?=
 =?us-ascii?Q?A28iLuh2VlhvVphdN2ig8+KLQR3eGbIN5CFuP5zBEiRaUxJ8y59drjqdrOd8?=
 =?us-ascii?Q?I/ec7KItpJn5GACjp7ojba4dOcvpaVUzlh7SDm8Zz8+6CtkHieEFtdvUngsX?=
 =?us-ascii?Q?z3kFGqXy3hhSFzGK7Iyhd7GLUTUHFl6fiebdunE4LuH61140uRjirD/Ulguk?=
 =?us-ascii?Q?DjtrIyiFgN8Kj5Vtlw13cNSYLoO3QcblTicfkM38okLHwAEM15yUY5EiVXRg?=
 =?us-ascii?Q?Wky9fJLhjfTpxXwNAWQ5Lrgg3y09Y7Ac9nUZMtI9N/qrBczJNShU/9D+gNYI?=
 =?us-ascii?Q?OwkfFZYGxhi+J3iYu8pV3nQBViPp2YeE9IQ0WZUrgRA++ihu/swec73yQ9Dg?=
 =?us-ascii?Q?xWMM/6Jm3ImlI99ijuZS71kZZxBRSO4lLDZqxWmIPj3vM6BafqCgRp44471V?=
 =?us-ascii?Q?/wZRdqhwvjsrXgr0fJzPpjrULZdqbamvba/vQy1kHVmcZuMVjEjDD7UgzS+V?=
 =?us-ascii?Q?JwLYmPuKq2lY08wKu+fxh55p07k0hvS7V5GuPTS1ZYEt9vydlf0KnOeLbBeG?=
 =?us-ascii?Q?zs4vx8NTQbonfdzYIzSs8TYVVYPUjj94NFIjwekdi46qCwP4/L+0gD+um13B?=
 =?us-ascii?Q?ru5cpJX0ji0sq+OJaIDPwyu3dsTLS8QymRQQwNiJCDr6DF1u3L5+GwxGaywH?=
 =?us-ascii?Q?K3Cw+ltsMI8Oe6aI2ZDhe5Ur2mRw3KAUMumYctnfV4FeCMfc+MDGxnFLURZM?=
 =?us-ascii?Q?uEaYs2rtHIkUcUWQkNN/ydhVgBltNnR/QWrJz1oiU5wraIywh7lvP+QxPl+D?=
 =?us-ascii?Q?dRA3aIpLMxS4NYfLk/tv3cXqJwwA674Mx5XaIJD9T/83q7Dz1OW0xeHsc+tV?=
 =?us-ascii?Q?BTx1LcjhyTNLI5hnlL8F/5RG55sbg0NaLsMNgl0z47uFDA1el2BWa7NyXQUv?=
 =?us-ascii?Q?pV5zdACeU3M9tpixpcvukJyBFJhN9A=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SEIVkl8UKwwx4ji0z+5Fwk1tn9T9NbGMJioZBbdBm8o2SelYksEaj7Bt/dT+?=
 =?us-ascii?Q?v7dlzzl0G5mNU0OF2pbLS/zHeNaMob48327QqMUDFx1YOMNIvRw/3G2X0Kfw?=
 =?us-ascii?Q?W2JEyQjNF45r6XdUydKm6MUngdkJ9e+vL1Mn/CFLO/3IG08mffmJbc1v+ENo?=
 =?us-ascii?Q?ajiSemItTANlznPR6PS9OEP43Qo/P115helwBtwMyglbfgtFKZKvBx/XID2+?=
 =?us-ascii?Q?9z4AmCwzOx1OVPj4WFPeKOLXwUnguTg6CaO8wC5K1MU5uAMWmYDFStjY3Lpo?=
 =?us-ascii?Q?RNnkrpA41ksHoFJW0XJSAMZU+x697aBzmPF4v7yFfE/4atfto/QDKmqJGqz3?=
 =?us-ascii?Q?xtB+uYpoEW1GOpyNJuYuOD7a5ORs87vs2ZtDxUQc93A2pOArRRe+IUM39LKY?=
 =?us-ascii?Q?SwsYoybxHzX+TeZ5YS0bTRNplKxJLK/LceODN4nXsD576Z9C0ix0OB0dWybl?=
 =?us-ascii?Q?X3ElLyG7wm3PN+TtJ5nya77aSpbqr2z1ZjD3hdKsbuUZzpVVudYG7eG2ensE?=
 =?us-ascii?Q?5KO+cQDpmIrz8vfIP3x3OpknW+NXjKSwHwLdsy2ivv8JGDsC32e1dvtdtib2?=
 =?us-ascii?Q?ddT4/HwCzm0OWMFpEhm6xDFdRBUO/iiyLb5AvIwprxqFzJWbt/XBKQHBlGJ1?=
 =?us-ascii?Q?uUrsNpv0BLhV/yae9a0FKM7RiuZFrf6IKg/fJlz682zMzArBP+QbFTlagXDU?=
 =?us-ascii?Q?geMZymwaUexKUQ9obK0onoaiqahUnueoJo5OEfG45IzXh8bxz/SymrNO8E3p?=
 =?us-ascii?Q?/PH665ZdX3VQQEedNux0xbFPWsoi9w1dP+EeJKZ3ZMCaw++ORvRTxWzoPJuU?=
 =?us-ascii?Q?p9Mlo3XPicLbCfW2nNXM+5ZkvznhV5aRKfomIx3u14WvLcsIxI6MxVzwkk0g?=
 =?us-ascii?Q?MT5YhWXBfBBC3HXvA83JXRwWFgiOeOA8964dp6FZmEx16vUvZF0kOwb93mjE?=
 =?us-ascii?Q?LTeSd6dKliHJafBQ53E06k7ILoYd/XSZARSdMzNhJKSKEJekUFtcDXolCy/j?=
 =?us-ascii?Q?jrcnJbT8DK39sz9mBLgDxOSpeosYtgBOdRCNIPVDJfDQxUzHL3wIvTntWQYg?=
 =?us-ascii?Q?+VxISC1MgcCN1hTAwsFiF8WxXNrkH2FKT3x0JkboIoJLfmzVFok3H25U2Seb?=
 =?us-ascii?Q?xSV07LusKQ6puj8n3r7ANgc7luA7JIhetGb58LZL9EpViGZD5tD6/U1iMyp4?=
 =?us-ascii?Q?lYP/dVdiAfOGSZmf/RV+8AcApKBYzcmxdYpOBSZV08n2voDioUw5u4sODHzr?=
 =?us-ascii?Q?jbIWAul/TZBkwmPzxf80?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a479b2b9-07c5-4ee6-a102-08dd461bf334
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 19:33:21.7486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9077

This patch adds filter for scx_kfunc_ids_enqueue_dispatch.

The kfuncs in the scx_kfunc_ids_enqueue_dispatch set can be used in
enqueue, select_cpu, dispatch and other rq-locked operations.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 kernel/sched/ext.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index c92949aa23f6..d782ee618d54 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -6605,9 +6605,27 @@ BTF_ID_FLAGS(func, scx_bpf_dispatch, KF_RCU)
 BTF_ID_FLAGS(func, scx_bpf_dispatch_vtime, KF_RCU)
 BTF_KFUNCS_END(scx_kfunc_ids_enqueue_dispatch)
 
+static int scx_kfunc_ids_enqueue_dispatch_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	u32 moff;
+
+	if (!btf_id_set8_contains(&scx_kfunc_ids_enqueue_dispatch, kfunc_id) ||
+	    prog->aux->st_ops != &bpf_sched_ext_ops)
+		return 0;
+
+	moff = prog->aux->attach_st_ops_member_off;
+	if (moff == offsetof(struct sched_ext_ops, enqueue) ||
+	    moff == offsetof(struct sched_ext_ops, select_cpu) ||
+	    moff == offsetof(struct sched_ext_ops, dispatch))
+		return 0;
+
+	return scx_kfunc_ids_other_rqlocked_filter(prog, kfunc_id);
+}
+
 static const struct btf_kfunc_id_set scx_kfunc_set_enqueue_dispatch = {
 	.owner			= THIS_MODULE,
 	.set			= &scx_kfunc_ids_enqueue_dispatch,
+	.filter			= scx_kfunc_ids_enqueue_dispatch_filter,
 };
 
 static bool scx_dsq_move(struct bpf_iter_scx_dsq_kern *kit,
-- 
2.39.5


