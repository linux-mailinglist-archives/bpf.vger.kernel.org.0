Return-Path: <bpf+bounces-4202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1560274975D
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0C6F28127F
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 08:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA464C61;
	Thu,  6 Jul 2023 08:20:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBED20F3
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 08:20:10 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2080.outbound.protection.outlook.com [40.107.14.80])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D481A1BC2
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 01:20:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0UcrgCf5TbrIhqNZJ+560nO6eX2wruh6EYkfSX+dULmDE3QntPc2T5RbXQvWxDf/BcubInw3MAmVUzoXCcQueYtnpwmJ34ZKsI1lN+gE32tArVQvRlcmecXpPjE4YZV6h9c5X8oL12Su6nXkzcBmphSaX4BXUXMBjYp0J5Znu7o45mWXkcmc25QoYypO7m2Akv9QB382ZNdVtHomhgZU28mpJKp1WV8WWbLf6N+L3Jpbv/y8QF1XZfv6+QSoBBCeIzF2FbD6bGlm8Jmnz5tZCR06jKstJ3fgmxgE3KSj1TlI3Q3YXdfMgwsOMWPsh04WiEUY31eezf4DnCVsyCsHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=I9RwIJHUaA4EuLiaqadVCUHl0z4RqOJJxaMoVIzhNpQ9x5Xdg8KY34W1UFx9GvmDqRYtvth5Dpzc4GjSYEFQikq8NsZ5Hl32eeykbTbU/GMs3KKNxC+96qKrFw8r7WfvkdHfjo0u1yc0ff3P/ll5NVKTNHd+J2OswiscY0KAXlVhUTmdsWnBeG8iXMoP3b7Hji+6TG9Ddompby1kiLk5bRyuM5L8uAgeRiMtBGs/HgwDNyJP5DqmdocM5U6hfBjM++9PjWvVOXaSHUVoJsCVd5x6HIrmCW1QfS/h6kbjXXTIF/zxUAa5HjmdH1/egga32yX0S7aO32gNIXVZtAgwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=KTPSN7sc/GzPMq/nSwjn7pSePSrwtBZlWC17Rr02bRwiW+sJzWbvCBxz0YIvA8IeKCQRuxIlV5Jb/x00mZBJpszDUq1bMwBW+FLY935gOtJwqgSm65Kvu/tItmzJSwlkcrjxfzOPDlgjVeZkPEcutsDxLcv8hIfoCd0f/E+dIoYfRpHw8uVDyNP0Y645F/5TykP0r6EISc2PR7a3x79zs/u3GVHISayyz44GOogfB+raq9FsnKT7i5tCr6qcy2nX9rYJ6DkRf4vcHuxcFoppmgVPx5Vg79gfHrZAYwJ2Y4CTBhXFVL+Lw8ZYc8jSgUO0XQeCIusNUwS7HxKG0l+3eQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by DB9PR04MB10066.eurprd04.prod.outlook.com (2603:10a6:10:4c1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 08:20:06 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 08:20:05 +0000
From: Geliang Tang <geliang.tang@suse.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Geliang Tang <geliang.tang@suse.com>,
	bpf@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [RFC bpf-next v3 3/8] net: socket: run sockinit hooks
Date: Thu,  6 Jul 2023 16:19:42 +0800
Message-Id: <5f76da0bea3453db04bb07399b4b1c9ce4859e31.1688631200.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688631200.git.geliang.tang@suse.com>
References: <cover.1688631200.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|DB9PR04MB10066:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f32d51c-8195-40f5-1f07-08db7df9cd94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oj0WtYV/ZXW0s9xWrj8vI1S/eEEHOIEeGmRMGCeVPtBsqrdCVI62h1FUaAs7ZddR5R194xOXLCb2Vde+olY4nlSFpx+YBnwjvdpIf3e2ywR8566lA+pTQODD7kjsf/CQMXUbZpj6ELIBuk1anwvQbsWnbuTAHFrJ6wDasLK0V6tA5foIqHSL0NWeqNPjehb6tHxRzpos3iqMOAoCRMVRSztISS+Adw6Eoc5pZIOiASz8qb1iRjaZWyBTI081ZBn9RxPji9aQmTaLeCk0ChtwkxQJSxQSI6VnINS6nJpzCYG2UDPpmWITXpHYR0hnwp0g/jzHP08EtS75yzTmKav6y/fDIyZzNaxvNMi9y65TonCxEXtQBek/YZIEt/7D8mYeN9YzRXlw+ru/r7Fn46pk71ulyn5GpRWQw8HcpOLoPuN0Zx3dbgQrzT/+4n6ofz9rUPKo4K2mliU6OFOMctG+aLs/bYeYZfQZoA2bdPGQ1VeyTURwPpw5Jr7gqm4lxgGYknnO5Q5Vo3DnUb/b3hDQ+AQMEEuHw26QkZ6ds3i1ej7p9qBE/CGT0G3eyBmJjhJL78N/Dx8Litq9NCbqOovjdalKRYmbZ6HuUzsDeWfi558ZbWVZHjp/inGAw5stLgTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(4744005)(2906002)(41300700001)(7416002)(44832011)(8936002)(36756003)(8676002)(2616005)(186003)(6506007)(478600001)(5660300002)(26005)(6512007)(6666004)(86362001)(6486002)(316002)(4326008)(66946007)(66556008)(38100700002)(66476007)(921005)(110136005)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B1qGycjNVUZ8CnTTLmVoj8F2qV3k2kI/L2LvgxjD2etLMQW1PUj5hSDA0Uc8?=
 =?us-ascii?Q?Oe+5Vyo2EgNo9X5uhTIzXVH9w1pE6xE6Bwipru2Uta/4euifJtxvT4eT1cwa?=
 =?us-ascii?Q?j/jvoYzBv88Rbse/bA/7XKeAW64Qr/Q+Z+rCIgJ/MgusRdRNGK8PxADZNk8I?=
 =?us-ascii?Q?AJ4TufNZKeRWxEZe2i8yUYDcjZsUtnsmEvFRU3NqkqAv02skyg4ZpdZqRUB4?=
 =?us-ascii?Q?/z2xmYZNfBsx9yr11OWydizBgAESy96DxxRjrygSvhxEXZUA8G59V39qrH4M?=
 =?us-ascii?Q?m99MxCoRm+iCthahzbod8aWhHMF90AXMSiDtLJzF7ZUz9hiw/GZeqYdSW0xp?=
 =?us-ascii?Q?U3JtZOfCJQA0O+RX/Ov6wX09r88GCzq93XNQUf8NP8ZKYoCJVNlaz2bsDQdj?=
 =?us-ascii?Q?jmrkQf3xpV3jB1jTCD4mCDiGP02F9ZqXlLpFGCrGeTF1LXjaIvGu+hNSmxa2?=
 =?us-ascii?Q?4IE+FPjgfyhWycJutQZxgrgYzNzO6Ao8V2JaYF6QPt2Q7YCRr53t/UUP3jS6?=
 =?us-ascii?Q?1ZlQuB3BxT3k6ACcuxOkybHBP6OFcMzeIxL6kgwnywLo7Oj/TJYlWNQ7xc2b?=
 =?us-ascii?Q?7ZgbPvuQTBbMiKTpSqLhUOKxkSysev6DoyQpDHjld4ZKJIGWa6bKE9kyuc/r?=
 =?us-ascii?Q?QDspK/DlUC6hz8mpIJla0CkHdOyyjv3ttGALelmoF4Wak8cp/kK+pZXj2uJP?=
 =?us-ascii?Q?X5J7ACI+ubHu1tyfeHEZAlqIVmv3a+Jje+19BTR4ZSBa+daiGPr6/Xrgp2cp?=
 =?us-ascii?Q?vK6GLrA1BurWVsW3UdmaH0zOctAo0upqyfAVFsLyMW/k8I/csqp227B6A+ik?=
 =?us-ascii?Q?mzPtOQ4M5PNEKbWjb6Q28KID8WG32hlmSNH0STJdoVD0+dD7JMTUYdufGz9K?=
 =?us-ascii?Q?gleOXOaALdN181HZcoZeVKsCk9/J5u3L0RwBwyNplev4PdL/wv/MqfvXGGcd?=
 =?us-ascii?Q?LWadZX7/Keo7MJ1FhenZ7QqHoNrWfXBYGhrSurv0UNVdJZvtk0AVAM3BzsM5?=
 =?us-ascii?Q?E4VPY3YPznSLMDTLu3Ij9WxPlAZaqie9LsDqHgc45cWM/BBSd6cTQ/Baaz6h?=
 =?us-ascii?Q?9YcdsknK1xENdQ6ax71+HtGgqhQfQEggzOy9Iey5zc2RcLud6THhZhX8U0me?=
 =?us-ascii?Q?NgVNevVe26UFPkot6GpKfAhRIhRI74txWqtwgPIH4op1w9mCFeZikWLnNyd/?=
 =?us-ascii?Q?TKczhry/HI9S/DuNPK+qwAuY3wu2hS+KaM7yR4boXTIMRoqXu6PxE8x8s/fK?=
 =?us-ascii?Q?ukveHiJasT8fDymj99m+1knk322VOyr+KIb0Mua5pV5STWYktsiCzJg2mMOK?=
 =?us-ascii?Q?Uumrb9Z25T1fU5+V9raKEjp2wPVJ4h8Lswhpelrxqj7UQ4BqDOeZiuvTBCEc?=
 =?us-ascii?Q?RUg/XbHSF/dVWhQ85T+ztMrf+QCXoc+VkT71ZZRSiOCDe8cjiUVrjFXi6fpJ?=
 =?us-ascii?Q?hWsrYIp6Tk3qXWmHZYyqabP+GtN+spHEBwFpmM7MfrrxW6ZFMgpZABU/4WJB?=
 =?us-ascii?Q?2MtqzbX5+9HKtEaGPITQo3LyHrPBZp44Pvw54PZaLBbWkvpb9PEueEJ8m6CC?=
 =?us-ascii?Q?bDB7s/BovlGVRQiCKThWapCNye7PGC1uuCT8QTCn?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f32d51c-8195-40f5-1f07-08db7df9cd94
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 08:20:05.3623
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl4kq0Po7J5WVH4wHHZHWZ0r+cTvEItrNKokS5hsum7TRdV5C3WYliXIzUtPs9QLNmyp/qIXk2TKhScMLJS/ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10066
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The arguments of socket() need to be changed sometimes like the MPTCP
case in the next commits.

It's too late to add the BPF hooks in BPF_CGROUP_RUN_PROG_INET_SOCK()
in inet_create(). So this patch invokes BPF_CGROUP_RUN_PROG_SOCKINIT()
in __socket_create() to change the arguments.

Signed-off-by: Geliang Tang <geliang.tang@suse.com>
---
 net/socket.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/socket.c b/net/socket.c
index 2b0e54b2405c..27b423e1800f 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -1469,6 +1469,12 @@ int __sock_create(struct net *net, int family, int type, int protocol,
 	struct socket *sock;
 	const struct net_proto_family *pf;
 
+	if (!kern) {
+		err = BPF_CGROUP_RUN_PROG_SOCKINIT(&family, &type, &protocol);
+		if (err)
+			return err;
+	}
+
 	/*
 	 *      Check protocol is in range
 	 */
-- 
2.35.3


