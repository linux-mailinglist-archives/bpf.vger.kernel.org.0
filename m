Return-Path: <bpf+bounces-49087-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B308A1427D
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 20:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DDAF7A2BE1
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A8233531;
	Thu, 16 Jan 2025 19:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Vh8Ada/s"
X-Original-To: bpf@vger.kernel.org
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2051.outbound.protection.outlook.com [40.92.59.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B52722E409;
	Thu, 16 Jan 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737056597; cv=fail; b=SmnIDJrm/Wu129415OhCq1YbNti9nOvhZNZFo/FFjU8CKt2F+CFywUUXjK9XUFe7LHchOh6j05dR1nAj9MfACOONTwxcPa4q/1zA1xexcFe2vGMI3dNgmwraw485sUrZzKZUny/3gqWb+/mef/aR9QIKwbsdD9P7YxQ+xI0zHVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737056597; c=relaxed/simple;
	bh=WzL0JC6Cz5/FF98R9p6CG/sIhh6XxgQPgoMzxIGocyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BObO52AwPnaypRKX8wQvk4NJBz3RxvnqxKamx6g9/220CW/DhBu0b/b/JzfniYHR/fbwahncQ4fwzcCiEAWHykq4bKcD7S0DqK/ynZrvIwu8aDJrIapT/pVXnxWjOL3wlWkiBCa2Tgr2WUC+bFZLL0LuMwRu0IFC/lWJTuOeVD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Vh8Ada/s; arc=fail smtp.client-ip=40.92.59.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHNAD1hPkJPrlCmuXQUvTf9az1TEk2hYk2kIP0DpMEDpHCZwXnI5GOZuZ6Nw3uR875k5CHQpy3x/WklD6kzybu7MapfuhYKbjEIA0DFRgggchNDtbAjyVjzEf+iRDSNTvhoLj/z4xT5qk9iqhhDXPcOAthaWGrRdxRvr6iCnYGhZOVnLAi1+X/3PtoT3A8rGa1g0Yy7XAD1ip4Q6upvUbgiyvEvXN4OGNDkJ3/1rLIc3bjA8BMihz/9NWjGblJSsxoMa+3xL7NF14/yT/aKQKSZhFAxcGaTlylqPgN/qf9ioyajeka3TY9HC9ngd0ab2PV7AXGWsuaKuk+8PEjF1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2kZyZ6v6BsmVdg6OwQQcMrbODiao6uodG37JMurUyC0=;
 b=qClWbvyu0IB6wgbAIyJTucad1wWcy40mkVL6p882+DTI1L9eC2D8D4yoH1LQKqxh30nLzTpeGHjZVp9omErah4QQb9JAFxgLF9qaSSRdZ+dx+GErAVSnhi01ELCHDgK8oy6OBqYRwKIsC1PAZ+xb3nJd1kxkLRiaDW6TMymuMvrtph/WwVH8x/NnQHEu6pMJ+Lul8TQdydoO5bvgKnL63pg79/P7YfBQuRkOLwdzFxICQ391Sn3oRsNSwC2B1skfzJQAsD42ulw4IviPxnIbCzoYhV7N1dBnh+VJnToEXeag2ePj6YM0+zEjoNVjghUf5L5FiabW/rchiYvle2ufuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2kZyZ6v6BsmVdg6OwQQcMrbODiao6uodG37JMurUyC0=;
 b=Vh8Ada/szZ5Xo+sEb+R9BO4Wcs11pzQrJP+NVm34XZSGfUiaHVVxJzE53IbbUgnFhc4KlVoosJcWxiqSgCo8dvtYaqacZAo5tzwdMBa1Ae6MNZgMf5lhUf7iK+W2hzsFwRwy5RgtC9udub/XuLN3a42dUnItm4N3BnB8spIwRiAt8nn9Z872E6s3bfLZStpIEnZ+DcFxh2ZWf7vZCyHCDShD+a+Ms+l6j0pzAbpHu4vKvjhnTFTq9hy4veAfhJZt3fWcn0ENHEjux3YMaL9Xt/NgCBA4m8LQLM/9ebxdmH2Nxe5pNJJRTKXbYixoDuRvn+5tNY8Syv4X/cGvE7fKbQ==
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com (2603:10a6:20b:90::20)
 by AS8PR03MB7970.eurprd03.prod.outlook.com (2603:10a6:20b:427::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 19:43:13 +0000
Received: from AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8]) by AM6PR03MB5080.eurprd03.prod.outlook.com
 ([fe80::a16:9eb8:6868:f6d8%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 19:43:13 +0000
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
Subject: [RFC PATCH bpf-next 2/7] bpf: Add enum bpf_capability
Date: Thu, 16 Jan 2025 19:41:07 +0000
Message-ID:
 <AM6PR03MB508044E85205F344C4DA4B5F991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
References: <AM6PR03MB5080C05323552276324C4B4C991A2@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0041.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::19) To AM6PR03MB5080.eurprd03.prod.outlook.com
 (2603:10a6:20b:90::20)
X-Microsoft-Original-Message-ID:
 <20250116194112.14824-2-juntong.deng@outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5080:EE_|AS8PR03MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: fc354ca9-6584-4aff-5329-08dd3666036e
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwU46ctkesNAQSdI89rGQphJEVobBKesdTHfPyAMsuVrUV8yCepNesYZyT+MXfGD6BOlLfAlvnbsREvwmysJBCk/tJyzSoIKXZYTWB59SHlQkRK6Czh/OFW+3+CufSuDxCFHeawShgQfom3wJPAKE3BPVzn89TBeUzCyr6i9tYDyWIw4VsQqpBdyjC2+deXuRivmTLgfh9sGYQOD/8ytv4K2VediD+yGMoZIZFYgXW/7zlRAeydxk8eMz5oCpx2Z9QPpma3Fu76z0tSOb87Bum+gCb6AiwaIxm0tHo+1mJ0gjERYat81aHt26g4XqvMRWgD4RdlIaiplQ7oKOsc3IN1VpirCqK7EKOAsWYTXIWxc2WuiZuGYbTlyLzc7YCEg3CpLkpkS1Etpr5z6bv9K5eV3OtSe4PaSJANQVKFXUcgAQxytT8LODhVFIEnoiFHCq+7P0XGGtdKcsDmtlNntsL5U8gEI52ODG5S9+YFCP5F6GFQb3mZJOoS7twgS6puL/fS5RG8fCixbd6zgiZOwGPnvnK1OLW6RWGxqU158WMWLqErzqBrpDWbhJQ3jpbXdh1kB0sQtjC3AuI4piAG5zf8iLh7KbGz3dUesKKHavSbztlRX9RMvPjmMqtpTTwI72QwuH7RZ+d0oZ3mgWSqbcQw8ziCO1Cf+xi6g6qR5K8TsBE3jAoh9+Nq0RpreMVed04FFgXhkgaktAPve+fig7tPQgoro2Zh8ProyaVWFKV9950KqCx2Wj5x7tvHn7m3+KYg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|8060799006|5072599009|461199028|19110799003|440099028|3412199025;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?am+r6Q06inOs6MQwJztvw+B0t5FJJ6fgUL0AwJy0cDlDn4TJ15IEv+LoKlew?=
 =?us-ascii?Q?sCuRCwa+YWphVfXDt0wK8Hktho8n2nCZ+MvJq7naQKYPVwDlpx76vjfduSsm?=
 =?us-ascii?Q?CkiqjBi4bqbcihLCYqkUaUHD3NkFrDx5N5ML+xdsm8YddVaPZKckfia6hurb?=
 =?us-ascii?Q?EWw1O7pHhv09MocqtPDMvTghMJoNioicDl6N2fCXkAEB81BRuuoyhprBQ79W?=
 =?us-ascii?Q?VUmTqS09ISaD9de4l+KGDIfiA9yuJQwa0c5FTpMCwR4uyM4bpm+EJTQRBN4F?=
 =?us-ascii?Q?BPkTGxrMfyCU5ECz/fpaxppD38R8xRPb02DS1EuBjXKPdzjwwGWwfsAbj+7M?=
 =?us-ascii?Q?QIDt3AXK2XZDcI3537P9U1UcFrHruZxbGMnYJOAs/eOrFA5Le+CQcLSFKF2c?=
 =?us-ascii?Q?hkqmrqf8lr8QgRPageDSp067c6lai6MvZtLBqNtJjKAVPNw9Ew/PU7tsoGGz?=
 =?us-ascii?Q?0lp8J2oa+Pcx4DzK0otgsq6AQwHNaxs3USkixGt1nhoKIlvHd8HKSyz3YkoN?=
 =?us-ascii?Q?0FbNKWBpTP5xOnxk2EDBHx/yZfhU6chVDo+43lpEzSamUUT3/2NuFp3IGCPB?=
 =?us-ascii?Q?965iy2iyV+f+DpqSLfMwXfr0NxsTjqwr5kJjt1b50FUC2GEDGdcSpirlRtGX?=
 =?us-ascii?Q?zp4CiPmAVSguXIFcLTny9j+7lsM2s0IsFJ7eVrlQ8UvT/VAqupuzfBTtlcu5?=
 =?us-ascii?Q?EGNg8ToBO4AkWNLdlG/RXuASsq2XhIce+bPkzQJZoRGjd8ss2X8Zuc6W5YES?=
 =?us-ascii?Q?ILLDPFEPH9Rnu6x7Rc9p1AJqZs5XZNy7Ai1h35vgKMdEtASm3hXArmyLtS6b?=
 =?us-ascii?Q?8LtPGUBXv1xBXULc1EbdY8t1+qoMWCnYICobV27k0mUEGjmbtxM3BmOPDy7w?=
 =?us-ascii?Q?NGs95jtUhEafj4HUWYjqklnRBB90BIvqLrLtxA8C41/nMtwy5AwtuHGaNhrT?=
 =?us-ascii?Q?nEzAuf/eUmh6zKpKesVSSgHAuarUuLmQKg3fOdXZtgmyUDnMcQAqHIWaPIPO?=
 =?us-ascii?Q?1U9hsAJNZSzbmHJoGXSua2wAG7gpfJfx38a0ViJOgZXTgAg=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?huQOxEplClX7DqQFmzWOQrrs6s0QuSGWszmfF18I9EPv8iYyWTYXKKfJIVvL?=
 =?us-ascii?Q?jsmggIBvPFfDy7yYENZk8zpn7CHQDDf+ZziqPYSLbTBUZPKmenExCdUkNwxD?=
 =?us-ascii?Q?k2iahPT1HxItWKoStqkE9MscyWcsQDce0Gj4lbT8OqI79llEiMUfXyDSqTVC?=
 =?us-ascii?Q?RDuHlRj3+b544wEFX8zS8US2WxCSu6B9/BYAtH25IsN6oqAFv/qrzGJsWEkU?=
 =?us-ascii?Q?Qza67kfUte7QczZ39HyDkggMkicj1ihn9rABj/0WYQGaOt/KmZiEuWnULZ1C?=
 =?us-ascii?Q?xTOhX6QYJEbDMZxmB2Tt7mzMv5KZB/mPsWMAMje8IPfHoMR58a/ufivyxhu2?=
 =?us-ascii?Q?JkOqfQC2M5m3Rqt7NDfSistxDWXAO/nJY7xjheNzgQC9KhT/6JikL7cQkwx3?=
 =?us-ascii?Q?byDqfUEfbaP28sve/WevlhATFjvaynZmQYvTahmtqaql5ih1b/D2TFE2d/f4?=
 =?us-ascii?Q?znrifzASlbU7DKse7XB5RSUXl8f+HgIgGfWIdwQ1yhmsLSeehkeQdJOO0HSL?=
 =?us-ascii?Q?4qFGuGIUKfe6rUcFY56QaY79qjFUzLKrsj0ejYh2mrH46RaUp0jqBZd6G3mC?=
 =?us-ascii?Q?R7cz+pfDpymT4QmkP9iyFYv5Or42EupNySHDkbop3sv+k4ldHzcGv9kGZYz5?=
 =?us-ascii?Q?L6k+aoJ/U7WoapA7jEkyCrecQc+bi/OjIIqGtjHIpkB0B5f7Qxwjj0Up/9KC?=
 =?us-ascii?Q?hB17F94QAzr8ty2M+f6FXSthCh1RuDCc2eIOkxGxBoWQI+fXvVCEvy5/nvRj?=
 =?us-ascii?Q?ilB4zb+dWs1QXfMprZP3eel+B7i4CAH4SyBMUb3Snxgej/4U9oZW0gaZ5Ek2?=
 =?us-ascii?Q?J50VF43ub5ap9aldS4EqUCygL4ZKVh4M7DS8LTptfpy3pZ4jZnc0n1hRUIKy?=
 =?us-ascii?Q?dn6XzplHe+oMIMIZynTlVrjfroE/Ui8l7tUXp2cj2oyznQAlLoFRqo+1hcca?=
 =?us-ascii?Q?Zfj14s3KRJuj129wrWJmcqaZSI3U4w70qeUIQUGZCHiDHotSmR+qvZEMB5MM?=
 =?us-ascii?Q?v1CwygKOz4dEoXGqYq6IZhW7vecCtQ5OZMb1Mr1wyYc6MzSqgvih67DHPa8Y?=
 =?us-ascii?Q?EfWoMPEle8aIyP1dOpmadyFggfKQRZUcHf2gL9cJQeYGT2afYUUeTwrzUiid?=
 =?us-ascii?Q?1te4e78iq9FaM11X/VjXxWVlFYTDYP4tScVS3pZ4YoEOoIvyZWnZ7ED1ZQxm?=
 =?us-ascii?Q?1odmYMMeECnHKzcWMAqdbFMleASz667JBRZuTLDs+aNskUwhNp1HnlHQiGrE?=
 =?us-ascii?Q?d091kaOj1oNu9KMomE9H?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc354ca9-6584-4aff-5329-08dd3666036e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5080.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 19:43:13.1296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7970

This patch adds enum bpf_capability, currently only for proof
of concept.

Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
---
 include/uapi/linux/bpf.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 2acf9b336371..94c21d4eb786 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1058,6 +1058,21 @@ enum bpf_prog_type {
 	__MAX_BPF_PROG_TYPE
 };
 
+enum bpf_capability {
+	BPF_CAP_NONE = 0,
+	BPF_CAP_TEST_1,
+	BPF_CAP_TEST_2,
+	BPF_CAP_TEST_3,
+	BPF_CAP_SCX_ANY,
+	BPF_CAP_SCX_KF_UNLOCKED,
+	BPF_CAP_SCX_KF_CPU_RELEASE,
+	BPF_CAP_SCX_KF_DISPATCH,
+	BPF_CAP_SCX_KF_ENQUEUE,
+	BPF_CAP_SCX_KF_SELECT_CPU,
+	BPF_CAP_SCX_KF_REST,
+	__MAX_BPF_CAP
+};
+
 enum bpf_attach_type {
 	BPF_CGROUP_INET_INGRESS,
 	BPF_CGROUP_INET_EGRESS,
-- 
2.39.5


