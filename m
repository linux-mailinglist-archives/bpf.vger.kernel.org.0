Return-Path: <bpf+bounces-72117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE54C06E66
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD3A41C075EF
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 15:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB0331352C;
	Fri, 24 Oct 2025 15:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b="mHZ1ho0y"
X-Original-To: bpf@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010066.outbound.protection.outlook.com [52.101.84.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303E3322C60
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 15:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318899; cv=fail; b=HFEuyBEVvJ4mq8A4TR0+rhxnzgjnqCMFtN+kd1kpUOeeBVXzaNS5DGyLroqO8M1eAbDtYKeI9FDaZys0+leu3IXMSSu/X+chU6P7ElZyFwd7JL7VPxtkz4OjXbmxoKbTP4GA2Ig8PX4Kxi3o5+dWSH9djgTITh6TRK2qj/9HQ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318899; c=relaxed/simple;
	bh=TU1nuGkaKigeojVz/SVnWNxbQIW1F+u7Hn2IVoB6Vq0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dDBzI4edLpxRudRcVNLqZN/904LTYJ53dmdb93Zoag7wlCXce7FXli7JqUODENu+2/+wRT+mFt7htSVX2U8j8eU+K+KYcHpo7JFPE4eKIi3NMAEntnetPG16yI9x2KToUIyQInQ+8Z7/Ams4ZJQUX6osyTGVyoSqs7YiLnZo86Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (2048-bit key) header.d=est.tech header.i=@est.tech header.b=mHZ1ho0y; arc=fail smtp.client-ip=52.101.84.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aBTtz6svgA5coKw6cZA4EM0jTUUuZL4YHxtnBaxzH/6VynEMdoqkVj/PHwhG2NTvxg3w6mEjXw8PqKVKMUzUABYNJNUvkarcGEYGRYMqlZ6Kj0JQCNj4rza3qtVJAxeS7daYi8k9D6wxdsXE+I8g8pcdhtOOQU0mHOWC2sQN3mQCtCd4lsgGUV5qu3COWXl7oySBlR/Y/7jihELw/2GjVPiJQ+lFEHg+Jn8UXvWr4I9Eeb49Fp9OxzXovQyMkUL/2+aiktvoitqAsMfNB/CRulRmEhZ/JFxCCIPPsEJBPDxw90hiO6/rDofsZrohJ2nJT58q5KmC55MguhYMB8aR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jz7hqrXag4ty8Rm7FXkno5RbjIbkWPduCXwpOBTaLqA=;
 b=d6PZs0f51bs/0OPD3WXzR02/cHqVmKNzZX6J8ZrLBMS0bSU9/2a/ZmqukGzVUT5VljFIAW5m9zLOCyxP3WErG2VAL/IS/ZabRwqxbUm0DT+l1ccbEtF+ZO7cH+JvkSqs0zznVAIjOHykn2HqJALm2R/6N8tBprmJZGdceo0j4XS6j0UEuCyUd4Yvxvo006rGWDYHBZEQZI/jNnNkXSX8nuVJRgDn45zN5WKzRlGxr+x7/COmhotMyLhoYnbJ4xOKt4+LOVkQ7gvLIQcxoodaO1xvA7w+xKY97JHtnIp30GehEHqjAANx7SIvktsX6qZSgMzcJgskIFTvJX41CnD2aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jz7hqrXag4ty8Rm7FXkno5RbjIbkWPduCXwpOBTaLqA=;
 b=mHZ1ho0yKsXuizvH3QdYXzgBOIgww0zlQAuDesXwW8zLG6XzlCitqSyTj/kzHvRTrp6XGglkAY5Ny43j4G8PVLz04fOQQOeOiJVMrqY1V3yG6iUsD4JNWyfoFrNMceW2vvzViktSryIeNlLDyelztxd7iNMY5NzepdDfHWLZjYQ9VTcjKK+ogwgrbUG4DpSTIlHkIxNbNyrx+xLlyMD80RK48FoqzdrEIfDmcQYLt/UzLQUgmE8GVEF9YyNGUigBDulLdlyRVwIz0eR4xDm7BCkXe5UgW+kE3a7dfAHQ79xF5AgF48U0ey3Gdg2hzaC3NUmxEzGVBShkj/R/los3zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU2P189MB2588.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:49f::19)
 by AMBP189MB3269.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:6b0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 15:14:54 +0000
Received: from DU2P189MB2588.EURP189.PROD.OUTLOOK.COM
 ([fe80::8636:4f22:3af7:9aa1]) by DU2P189MB2588.EURP189.PROD.OUTLOOK.COM
 ([fe80::8636:4f22:3af7:9aa1%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 15:14:53 +0000
From: Malin Jonsson <malin.jonsson@est.tech>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: bpf@vger.kernel.org,
	Malin Jonsson <malin.jonsson@est.tech>,
	Yong Gu <yong.g.gu@ericsson.com>,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH] bpf: Conditionally include dynptr copy kfuncs
Date: Fri, 24 Oct 2025 17:14:36 +0200
Message-ID: <20251024151436.139131-1-malin.jonsson@est.tech>
X-Mailer: git-send-email 2.51.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0224.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::19) To DU2P189MB2588.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:10:49f::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2P189MB2588:EE_|AMBP189MB3269:EE_
X-MS-Office365-Filtering-Correlation-Id: cbbc4e00-0e47-4d81-735c-08de131015a8
X-LD-Processed: d2585e63-66b9-44b6-a76e-4f4b217d97fd,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?zSmo+f7JzKdZ2F95sR2LR8k1n5Lzs0euVNfyzazuTwsvzQUqFoJEm9pkymYF?=
 =?us-ascii?Q?mmY+Nhl/7ZgRLfiFrUnf0aVw5t/rUIwcopwHWgKR0wrbTfkEDUiYoUX16ZR5?=
 =?us-ascii?Q?wxEvf5eXb4m3op4NDlv4e3HIX5I7+fMaiQZwQj/drxgg1iU6ALlPrA8OG0wS?=
 =?us-ascii?Q?zyxr0JB19UKZKHL/aajRYniFlxiqfTcJVLXFKQNSGxbuOXIZVsg4YaSsFVJ4?=
 =?us-ascii?Q?M0ZK1rdvnZZXcgCxeSyuOPaH2NJaBldpWD8cPbxD37dQSMHuASW6h03koAmf?=
 =?us-ascii?Q?ms8xZsZ3zSGuJn7m6S1jzQvmOf1mCo8KrzaEjbePzvOmSj2rEqllOLnCoLyJ?=
 =?us-ascii?Q?vzxVGpMhlHZOrzzfWUyGayVZCix/52PyyqzeSzbByPl/QLpsZ8e6iUdwDk7e?=
 =?us-ascii?Q?grKd1yrDq55qLGsk/UOaXcgDb2Ndpqr+f+NeHsETWoRHfY+aR4xRL5vrm7zL?=
 =?us-ascii?Q?8C+B8QtU4DEFvZ+3gIb4JsGr/lkGSIuLBUCzorS+7kbYHhjJFhsWUMmBTfQY?=
 =?us-ascii?Q?kByC8jPapyPvpRtc4Dwb9B13fU1OXudALqEUymqVv7jI/USR/aC7EX3xZ4Lk?=
 =?us-ascii?Q?nlcTNxV3fhCK88Nazpszhm5ipPCfzzc+LvEKFzBkBSy9DxG8sCCL3Exp/y62?=
 =?us-ascii?Q?m8yVbOVg9qECQivMDfTzcpJkIt90lQJvuRyQUSAJ6m/l8iSGm+N83h+cBcbR?=
 =?us-ascii?Q?gRJxswzrbr7EQhg3U7wch6uoZO9Y8wByIVrIzFK9f+AZwKxqZ9o3NQgx4qT7?=
 =?us-ascii?Q?BKx/U4oywGrjDt32BqA6D892lsXAmlY7y1IvaeaKjk+peJ/EOE447H0710Pb?=
 =?us-ascii?Q?CzkNCsRpJ6Fo3srvOGEwgvMHRlHU6qMqRkKwV8TakoZq+VM4z/6TUDbhI86c?=
 =?us-ascii?Q?BExcg9YvDVhxGej0sUTtBNETQvRjEAF0qtRq5vYrjt2PLcYcY+HQtPM85c4/?=
 =?us-ascii?Q?zl3XaiQ6RuBxIbTSny311vfXZvk16nBe2lwfr5lCC53DJ/pYGm0fF0jCKlIt?=
 =?us-ascii?Q?Fiw6WQlfBWvacRvAuu3T3+Krw/0DDz1AeimdHJc9cwKo3znfp8mqYUypW0+U?=
 =?us-ascii?Q?ZKz/k6kbniLCYJLSAKi7BbNDq54So0ryWuZ5J5TWR1M1pNAt5Fkx13EQ1YCa?=
 =?us-ascii?Q?w2+y/LeGcOZPa/kvAFsyVQ9hF9i5GC63LEjFyKtxyD2nQoZN0hs1c+u7zcM8?=
 =?us-ascii?Q?CARd988nXLzNoqk7l6qmnCRDHKNSgkGaJhmRlJX5UXA2y9OmnCU0KU8w7RAr?=
 =?us-ascii?Q?Opw7zx3GRpHsWUgu4N9ojbaMO/zZYT1nnzx2AjFeJ5makdFnm3+DAHhsRNZ/?=
 =?us-ascii?Q?rOSRvLziCrepQrbUcrBvagapTKrouKuCgtEoMpF+vrU7t6pP7UXy8WUD4B62?=
 =?us-ascii?Q?kzBLfj90dL9VH1YaC6YZyekC12dDXrY38DS3lNzsu0ctwO67kXYI9zFROy0y?=
 =?us-ascii?Q?NJKD5e4DgBgZ3LmI3mApjGaCAuta302U?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2P189MB2588.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?5TY7uiVEa7dPTJi3xG0jp9O8/h5l6FDdx8aqcTd1nX29vtAjrh0RZN6q5QHU?=
 =?us-ascii?Q?NLpySeqSjMRk9SLFrAKT2MGrIATAceXReuea4uFS6mCgjwEwg4NpKOrXCupf?=
 =?us-ascii?Q?BwSvgnCsxUWbycltrHAsVlJFD+balazctxFwG2x43be8NI/VLCxwX+tjm+U/?=
 =?us-ascii?Q?hwoOxeg44YK8LDGGICo8TzuBp5jtm3bWkJkQy29meNRgErQG/V4R8JQqShjp?=
 =?us-ascii?Q?QwR7rbC7V65Lm6XyIIG1u2Qalp1v88pZiHmeZ9bKfHobXQ1AF5NwP2+Qz402?=
 =?us-ascii?Q?FUOU9D4vckNB6UT8HlIATEnODC5SP52kslGcIa3zObpebP5cqoKJq/C8DrI0?=
 =?us-ascii?Q?rFWmDIME30/uI9MF72oRyA+EVNFuMNsKo9tHYT805WsK7KdsafWp3f11rUEJ?=
 =?us-ascii?Q?qfmtf9L7AIU7DtHS6A0o3XPuooWaJ2r0SCPdNjaFL4tdahOLv0UQBxlvd81l?=
 =?us-ascii?Q?32Uu1tCIGbMfGjMuM4AFT1e1BEowvgs6AtqT8r+3z5iUpruiVY+wuSXccNsR?=
 =?us-ascii?Q?O8XZQB5s7N/dGLr7o8gUplmkrDWzXQQe4G/YLxL0kteVWezGH+WU2HYGsPnJ?=
 =?us-ascii?Q?PYbW0OD99+uA7PxbqrfmIMXCOYUtShQwaCk8NeJWKK4LIdQ5jDV4t1GUvFLI?=
 =?us-ascii?Q?gJeRp3k8h+5vx9449gadeKuNfqITz2+Qc7EF9oGc60zdO7Z6MPMEC/SGH5Br?=
 =?us-ascii?Q?bLOpdJJ/8CybI1ZCcHvqDRmQGmy67F31WTHAq314nv1IczagbuE2PnGpBgLK?=
 =?us-ascii?Q?WU5ECBUuUKkL1X1bqWSZIp1g3nk586gnMq4MieWuoAlRdrbd0MvTgW+gr+im?=
 =?us-ascii?Q?V1COeYPWQGoy2Yx6LKW+kGnhxvoVeye6FaV3KjzyHFbV4fLazzQEd7vHfVzJ?=
 =?us-ascii?Q?92zIUqpjzRGyuMkEB8IZFxiiRrUM9RsteQxQMuqWKv05Dt9kBtMeZt8jVGwF?=
 =?us-ascii?Q?FonV69foKddEhzPJwoR/Z+9iKflJkHzZB9QPtMEIvNYXcGNkkCgxYGgkbODi?=
 =?us-ascii?Q?0STlDAOU8ujTPKiT2Ss8/uM7YC8i6kheH3huZ9ClBZZuynxFqWh5QJlWuEvZ?=
 =?us-ascii?Q?ObxoVVP9XDrWhC+v5FVFJ3w03aIDKe9bnVoYwhvvlphenx+h3gZUBD2w8sue?=
 =?us-ascii?Q?qrtwx//Am4HhzktEo2QqQ+5HgTz1t1MJNZXkZFy1E3sYGGY0XmNl8jfC7Oke?=
 =?us-ascii?Q?SU4dvPfDRK9xiHqItEDyHaFmK4W6Yu1B+JyD9cLeBqrylHKN4kyVxJCgGKnX?=
 =?us-ascii?Q?+rXfxfrfsfG8rOM0a+W1x1k3pQkmt7cA/mcBq2HN1CtrrOhHXPcDX1Zaut6B?=
 =?us-ascii?Q?fSvgu0tRlA9cjiOCJzv0OjjZzjymOJSZcwtH3nD0pWzVue+3g4xvJJ26iPh1?=
 =?us-ascii?Q?7FDyW8cFE7XwAPi1xjUpBFQgfBbjy0iWf6BHOK7pQzAw0QSlIf4hqeIFCaeV?=
 =?us-ascii?Q?NJU6JfuY6409I4q40XNl21m2HxhOvBznddD1MsYuYX4X39/hOPx0joGcjZGO?=
 =?us-ascii?Q?OJgPSGB8FJ5eAUrLxVr50RGTXalmbMtdcoksp4MmihN6qj6/h7HPfKvhm3oG?=
 =?us-ascii?Q?Mw2KM59zC5ksLc6LJrgq9iajDGwJV5NvZUabPcgR4Isce04FtLPN5OYIzD15?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: cbbc4e00-0e47-4d81-735c-08de131015a8
X-MS-Exchange-CrossTenant-AuthSource: DU2P189MB2588.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 15:14:53.7846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t9mn4jKs4VJ1Cth4Zf86taYO9v6ZFbvvDhrgwOmBTeFMgVVosmYOlkkGAD6gYTw2+lvqfr+hrb0d36lNTwgT6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBP189MB3269

Since commit a498ee7576de ("bpf: Implement dynptr copy kfuncs"), if
CONFIG_BPF_EVENTS is not enabled, but BPF_SYSCALL and DEBUG_INFO_BTF are,
the build will break like so:

  BTFIDS  vmlinux.unstripped
WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_str_dynptr
WARN: resolve_btfids: unresolved symbol bpf_probe_read_user_dynptr
WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_str_dynptr
WARN: resolve_btfids: unresolved symbol bpf_probe_read_kernel_dynptr
WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_str_dynptr
WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_task_dynptr
WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_str_dynptr
WARN: resolve_btfids: unresolved symbol bpf_copy_from_user_dynptr
make[2]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 255
make[2]: *** Deleting file 'vmlinux.unstripped'
make[1]: *** [/repo/malin/upstream/linux/Makefile:1242: vmlinux] Error 2
make: *** [Makefile:248: __sub-make] Error 2

Guard these symbols with #ifdef CONFIG_BPF_EVENTS to resolve the problem.

Reported-by: Yong Gu <yong.g.gu@ericsson.com>
Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
Signed-off-by: Malin Jonsson <malin.jonsson@est.tech>
---
 kernel/bpf/helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 8eb117c52817..eb25e70e0bdc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4345,6 +4345,7 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_local_irq_save)
 BTF_ID_FLAGS(func, bpf_local_irq_restore)
+#ifdef CONFIG_BPF_EVENTS
 BTF_ID_FLAGS(func, bpf_probe_read_user_dynptr)
 BTF_ID_FLAGS(func, bpf_probe_read_kernel_dynptr)
 BTF_ID_FLAGS(func, bpf_probe_read_user_str_dynptr)
@@ -4353,6 +4354,7 @@ BTF_ID_FLAGS(func, bpf_copy_from_user_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str_dynptr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str_dynptr, KF_SLEEPABLE | KF_TRUSTED_ARGS)
+#endif
 #ifdef CONFIG_DMA_SHARED_BUFFER
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_dmabuf_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
-- 
2.51.1


