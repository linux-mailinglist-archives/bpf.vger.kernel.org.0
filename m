Return-Path: <bpf+bounces-4187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F146A7496BD
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 09:48:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C63F81C20D02
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 07:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6300915BB;
	Thu,  6 Jul 2023 07:48:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E4715AA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 07:48:12 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2043.outbound.protection.outlook.com [40.107.105.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD3410B
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 00:48:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Edm40UAL0U9BcFCACF0CAyFMC1jBevk53H42ohEUICQ6YUMiZsH54W4KvK4hGpFZTb5Tyd3FZNLIL5730EWyAfMhKRSaGJfHmS+N6HAFzQQtmdkCZGCm1IG6BeO22mkXJKyjFE0ArBdWol8kpvt3iZtoQ83AVcf6nDnjliW2wjlzymKdoFtYpjO3Uiz9soQmvJm9UzQGgOBrWa+tE+bJYj6qeoh/EWd5Z3SCpNki1M0DB9L9gJhCjcfHTrjaiOK1GYIdvjZkB6Nhn5etzVDsywcE0kCmlB3qUCYfUT2ulVd10D4v+hEDGtN76JCckQiN2MzLnmWOZYOcP3ZlLbeB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=iWguMhKIUxkIdXbyZc251EeuK5/eycH7cRHF93njur3Q7WXwrwAboO9U+Fk2Phi/sojOr3I7yfX4Px3gYWo1DBWx0D8FmjYaXbFVNyHX5iYFOoxCaG76bxrCcopZN/Gb3Jwge0Ige8PxnBEpcGR/0Q4NP30yLrTcXUKtfIqqPh40f3/PP0YY76rDgvNfCn7DRnT5KjMIVgRO33JHmqqNdbn6q7ecFDhSkjLqqLKFuU9IUTeDEPfvBpszz7644j2joVyZ3EoP42ipXsYbsfscgtn9SoDZBqvKLDbk8hxMrkYye5WC1GYpF2UnEMCK5qBL61fAkblXqOHc7dfVFABtKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lY3Pgk1uh4FXkQ6a+2ml9sNjR4idpzfAMSUu5Wzp0tY=;
 b=GFiD+UCNF/p6J7jNV0X3ul+YbeMUBLhaOSEBDJ8NI3nx7/FrvZ4ygeYai0eL0Vau66bNRVqKkZwftPuwxP1Sj376kfG2FXk1nagm7MPgt5rCEjAKgkKdnbGJdO1HEGL3j6pFL16m0J/P8IhpciYi4SnCgRhPin2v9eP7ah2ZKME8en0iCsK/bDJMn1DOQe+L4JDO3nCbRcuZaDej45YWV7sZktd1Jt5kEMM8cVuCSq0C55DYaOo1iLbQ746sSoOjSVyiDDs1RlxSTLHWEMt2btiC154FjYcUXyCvD8TH96lCN7PTAoQ/wNohKOyNop3Vdcypk8L68He40Gr9vVM0EQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com (2603:10a6:7:83::14)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 07:48:08 +0000
Received: from HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35]) by HE1PR0402MB3497.eurprd04.prod.outlook.com
 ([fe80::423a:a30f:5342:9d35%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 07:48:08 +0000
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
Subject: [RFC bpf-next v2 3/8] net: socket: run sockinit hooks
Date: Thu,  6 Jul 2023 15:47:27 +0800
Message-Id: <5f76da0bea3453db04bb07399b4b1c9ce4859e31.1688629124.git.geliang.tang@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1688629124.git.geliang.tang@suse.com>
References: <cover.1688629124.git.geliang.tang@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:404:7e::31) To HE1PR0402MB3497.eurprd04.prod.outlook.com
 (2603:10a6:7:83::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1PR0402MB3497:EE_|AM9PR04MB8437:EE_
X-MS-Office365-Filtering-Correlation-Id: 08acf7c3-d227-4430-1b77-08db7df5571d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9qzI/BVWYR10dX3h7y1I5eSHsscUASv92DSZPzKc2tFdu3M0Zz6rHmfFTua8wItuOmQgv1+puDU4rRHACp5F4/eKDVCR+XcHDzFpAPmyxqqRq5i3MQj9kzpONBXB7R0AhQqwgmrF4LSMPxA6YE877wdEqrcovLKs0M1G+Xxf2sH6fup8ixE+aqW+mFnmB2yzB4gCFpAlVisCDp15Teh3kNIRYBePXfvq8sd2pI1iCRxyhwn5ZnEeWAwJfjyuf8ypC9OOjajat8vHl9Y7uxJec4Pt8KDwRHY/zjP4d8P73BOtFN+dAr1FIQax5hhNYFAjBrWdVp/7De6L9eE1QcbSx1VbyWnCMvDzkAi7U4OuJTQ6BTeFUlQqsxC0yH3LqY2Our52TqKx1UschfXCtGwvBaQL3MDlvcDJ+GRrhvrtiAfS9OVWLVRkwKKwCy3MEJtnzOkvPx1JRTn+beBlLsY+/uf9dKJojrtNb6JrH81/YfRy5Y/MoeR47zSzWEGHzxriiVv4zlm0PJ9nQP66vQ0CAwPaMCr/wGf8YdESUJaF8utRtq4y51yJYyoug6cMkuD0u+SGKKt33naHu3EWr8DQ3LCXYEKa5/iyylC+EGVX6YXOk91oPr+eyLX+UiAa7QgY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(6666004)(41300700001)(7416002)(5660300002)(110136005)(36756003)(4744005)(2906002)(44832011)(8936002)(316002)(8676002)(6486002)(66476007)(66946007)(4326008)(66556008)(6512007)(478600001)(86362001)(38100700002)(186003)(2616005)(921005)(26005)(6506007)(13296009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSb1Ja9ErQtVzwdwbwWXqMIXV18qhANxEleRUBJvGvOXLcPAQMnNrNuTnN9q?=
 =?us-ascii?Q?2JzCSewGZPdep/atGHQmD0yTdnHRxRK4tYBvhpNE8fQN3Krk5XfE8yE//kxG?=
 =?us-ascii?Q?gJ9CqPel0ZYe7VaO8V7Jcpzoclk6AlWzxGQLdHJ7WGuOKxBQEmxQH5mCLs3Q?=
 =?us-ascii?Q?XgIsCi6EjBVcLytaBxfx5Ft0NioKdXK9MBdzZET5xDHl5c9OVI8gJ9i0Kro+?=
 =?us-ascii?Q?v6vxPsBQn2X4gEBrOedLy7aiFKLDYqkEcNPCmMD4B/+naiXLF/+TqtPfuAiL?=
 =?us-ascii?Q?gprn6Qo36cAIGgqs/rmEN2di3Rv4resbhMl/zaxbGIZVgs/hBdsFITPexBcY?=
 =?us-ascii?Q?z0B5CAu9u6D2rHRN3ACkPQ/B7lpcKjEHqjnR7LX7TOVtOKWbT6samPTAgR2J?=
 =?us-ascii?Q?mt/aKvm6GrZwluZHqXk2PO8IfwGZtT1ar9Qrpsa41SpFA11ET2rNrm7/ec1f?=
 =?us-ascii?Q?zwLkVGo2dE1y9SYIKbCRUtqk6hUysOyxEybB8tkK6BYm7g9kSVs8RxNOlU/x?=
 =?us-ascii?Q?kouOVtw+V2qcPeUUcxnqvPvIIDkpx8yzbw+K+8Qp5nlm4Sdv4AaM0+nIU/nw?=
 =?us-ascii?Q?rPJ0ZTLW857KEuRlKDU3yCzhMtCJLasIPRUTF85COjYHHEX9wBM9c/LqHHEq?=
 =?us-ascii?Q?zzihS9kfPiEvpjhsGw8Rm2yUtC6XmyvI8xVXx1eumUIzJ11D2c2ueG5vOvkY?=
 =?us-ascii?Q?G2PbwpXh3JRyoemL0IUDLkpOkiYUP+A4JTbnTZRHhG7CD3UfP1cmpCyjXfLB?=
 =?us-ascii?Q?jmq569NrAyP5Lq1oUPg4Mfqr4MXXhXiRfykWJG1RfD4cMOZWXQ5WnA1h7AqH?=
 =?us-ascii?Q?3kuswH4Ge32E62EMYLvqbTDzZlec6n/P8PwBwSfdFm1crfY2UnJuCkDn4MvU?=
 =?us-ascii?Q?JhDjMCzjnv1FzX11PupabBj+s+3Vht9/lhXg855hJPbPniKv1qVWD1nsnep6?=
 =?us-ascii?Q?0tXu176mRTIYVpvm9bnettZq/FeNtRpmhxZJUCzx21YPuXyx2ec0iZlEpSRB?=
 =?us-ascii?Q?5P4KelFQqTTHv0EiLZWOMn8NzeWAOMOcC29ZO6Y+yfShmVboedkc3Vv7MBPo?=
 =?us-ascii?Q?LpUL9fuNBomLNQf7K2mlrFcoNFjswYVcwZ72Gc+mIicpFDUtwVlr/NDsMr8o?=
 =?us-ascii?Q?AcQSgMRiIRwsPCWXb+kVrsOMGJ6sEeqkaIT4odXIbDFflLeWDR2ioleq+ToW?=
 =?us-ascii?Q?n1GZ3PUBFjF+7+UQz3RABoC82ZX1WJPStFpU0fXF+Da9c3dTtsP0NLrnuN1U?=
 =?us-ascii?Q?Lc7fezyXx+OWCKJFf5B2d8/ccYzPtKo28M3cWiYDRzBTYyi2e9RCtuEE/M3i?=
 =?us-ascii?Q?hQojWEghrBtTU8vM8MNupyxI6WM1ppUUMppM7cFr1aaB4VcSsmlyixb2t2JG?=
 =?us-ascii?Q?TFTflfRk35jhdzfqaKRNKffsLk4+KgbttJmejkUgHRqx7AY3mKUgatTzzmYe?=
 =?us-ascii?Q?75IlD0eAW3PhRwLhQbD8owVYxAnFXJR31EcsxuN5sXJMabwrBDMV35nxiePH?=
 =?us-ascii?Q?RbdSsTeDF922uZs36L38lKuO5SyXxuyaVMQ0W1w0+oXeGYFuvAtKiA1qz3lA?=
 =?us-ascii?Q?HoI5dcJuqCQyW8sXvbUStaSuWJmwx4Wtx1MU/Bdu?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08acf7c3-d227-4430-1b77-08db7df5571d
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 07:48:08.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxjYrJ79kWDYvR6fHg0oUR7krpfp1l3Cg1aBKysiLEgn7KSmlorKMM+x4Xqj3+Y7UC6ipT3z++4KVQg/1vE7Wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437
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


