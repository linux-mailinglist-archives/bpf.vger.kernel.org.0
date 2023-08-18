Return-Path: <bpf+bounces-8085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B327780FE1
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 18:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14545282460
	for <lists+bpf@lfdr.de>; Fri, 18 Aug 2023 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A7A19BAE;
	Fri, 18 Aug 2023 16:07:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DEE8182B5;
	Fri, 18 Aug 2023 16:07:19 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2073.outbound.protection.outlook.com [40.107.241.73])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DEDBE42;
	Fri, 18 Aug 2023 09:07:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CffwCNJ3znuvXHr3PfQlyotRRG8mayUtXTwziBc+XkDlpktc4UGzcuEzcgkTB/6fHcVDBKrEyyQnxuEygM8FJc9S0vySWv5lC4W7DcboHuYC0PHzJCLPm1bIRJfqTIcCTMkpAzRIsg3AkmKQwJ/pk+gqmFPfRgAFUnE9xIwLsKiIQMNhEDN+5oaFSN3vWkrSSf8Xn9Sq2HFLOBto9w4ZK7rQnOyj1wVSR+JKWAK7SCQRZbePWGeUOKal79RkE1MO7RaTFtro1WdyE2sPg6VTEN21Zur+oK1dEo+MiFx2iXIfAZskvQ5t8inNL5YogyA0p7nlCvdTQHsbkYgQs+bH7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlF24pfX4yL8mh29eBFsXl7y+pPdI7efAy9Xjk1aOHI=;
 b=EqfWi/SA/drOmfg74fzzsdr07AobWbLEM5sVjQPaqGgC4Vsk999p3uQs2H6VuK9facNCicK7HZtMl9WlMSYibpnr5Jtpa1sWP0YNEdZY2vXivpv/uoFU9JaIyGqYH7lR3SlEc3Cse6/f1ihhEF1vqe1KPSYfmeWKOxZv+fI9w4He0KgIS38OisAZeARvInyn7Cc5Q2QUNb+NZz6vG+XSMoJGl3/MnScLFCQ7nJzBBJj+WKvqM3s0s4FfPugZ7F887VX/ieaHYpb+NN2cGBHV5a0jPSL1eaPzhimsIzv9n53A+upBOfqnjQFUSFErvYaXxIxht1LDwe5WTfoI/tHllA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlF24pfX4yL8mh29eBFsXl7y+pPdI7efAy9Xjk1aOHI=;
 b=M35HOMT9B9MGZMRIlviOPBcgsLtJXzmD+zCC84t5R790DQZt2AqaqZ71J3v5fhgs0wuvVphDFe1bPNbWIt5tDpxr+swOvfyjX3Mx9mAw3A1+AiZMLsnW457GztkxphcYylRkHDSnpjSSQ2fCFHigh5LimGPC/gfBtha8yP0qOeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS8PR04MB7895.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 16:07:15 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 16:07:15 +0000
Date: Fri, 18 Aug 2023 19:07:11 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>,
	Pedro Tammela <pctammela@mojatatu.com>,
	Victor Nogueira <victor@mojatatu.com>,
	syzbot <syzbot+a3618a167af2021433cd@syzkaller.appspotmail.com>,
	bpf@vger.kernel.org, brauner@kernel.org, davem@davemloft.net,
	edumazet@google.com, jiri@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [syzbot] [net?] INFO: rcu detected stall in unix_release
Message-ID: <20230818160711.k7irnjba3qxx3rfu@skbuf>
References: <0000000000008a1fbb0602d4088a@google.com>
 <20230814160303.41b383b0@kernel.org>
 <20230815112821.vs7nvsgmncv6zfbw@skbuf>
 <20230816225759.g25x76kmgzya2gei@skbuf>
 <CAM0EoMnux5JjmqYM_ErBZD4x3xkgYOEyn3R4oX6uBW-+OkE_sQ@mail.gmail.com>
 <CAM0EoMk5USiuZ84JeJQYCDQQ5dV-jiuGRVVocqH2izi7xcZnkg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMk5USiuZ84JeJQYCDQQ5dV-jiuGRVVocqH2izi7xcZnkg@mail.gmail.com>
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS8PR04MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: dd02f981-f88b-43d1-80ef-08dba0053030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DcEzeaGS8q2d2bmwYrZY0xEPdFrNQM/VaS+oBIfRBrt2AsWlpfGyjcBJUxcYCPklLZaBUn++rQ92uVhNsRqjXR2qMBYyDSaO0WAPD4z9lgq2OGewCPhOvYUAAoNzpPA+BeV2e053BF/yYiqIrlB/09fggZgaYnAGtq5HSiQNIBwAA7rrJgJCQI/vy2nJzj8p6HAxPmeyE9nSLjMItmD2RS/rVGbrO+K1QWwl1DONIE83JGIDVSTlKBriY1zcMxurw/fQIgNqvqwnqzmUxAw1Twp6v9+MZvFgS/L2HoNpRQb0yZgKGfrr0E+1ssxhyXz0nFXzT/YOgTrWf3kXuLDsjAFk2gB7A5a1wXnloGvVEbLElzza1lI+aoPwa0DzoedXerdjdi490BIuxHiXbJqKPwWIRgL4QGnYqdBJuEuhDJHO7gMoQKyNVlUXJcdEAxs45LlESCuscnpTE1SSxcvFwlwGz3ylxR4yL88OwuRKQK5+YXfyKDOkcEPm3NP6p5YGw1rPi83S4SDwlkj5hSS2qE0qfy3ArMqC0KrKPK7J9aY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(39860400002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(86362001)(54906003)(316002)(66476007)(6916009)(66946007)(66556008)(478600001)(41300700001)(966005)(38100700002)(6486002)(6666004)(26005)(6512007)(9686003)(6506007)(1076003)(8676002)(4326008)(8936002)(5660300002)(7416002)(2906002)(44832011)(33716001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h2hhoU8NJx/KqV+cRKxZT1sMOKNQ6S8F1lXFaprPmbCQvcizDPUWllIRHuoG?=
 =?us-ascii?Q?uaPjvQSWkCka6Gw9shsK24zLZ+EpKaOmlLjg5C/5ihlpOveccdt57XREa8+i?=
 =?us-ascii?Q?K/K6eFIwvoKSSY6+TnTTA7e0mXgulmiyR+VKw976+kGW6vGyFw4WQnHgGRRk?=
 =?us-ascii?Q?itvlqnAnfyKXDT7MczOsvLecqvHD7obUzIrNwkimnPfFPMWbXWq/YgKVu/3b?=
 =?us-ascii?Q?n6QcF6amOpyBpt/Eqpdg4tv5qN1nS6VLXlH2tWcTY+8Qls+uQJ98y0Z3ML21?=
 =?us-ascii?Q?vN3t/lbWvnYmLG0FO+H2dHoCbgeXQus1TiAE1oR6dGlClLek/l2jMCX63qbj?=
 =?us-ascii?Q?7oyk/R5QUiBsxT1orBGwixdRqgQ4ogsDyg4gWkfIVtuJIQacnrbkbHtmPRyE?=
 =?us-ascii?Q?G7PTKl1O9Sa3odleGvIoX1JIDVEKMGQKzZB7Xn955xmPsYH4qDp8GCWZac8R?=
 =?us-ascii?Q?a87AtoRPQZy5qnJMnY2vn+jSygfjU4dGkFUvZaZr4Z3qFKa+3jV2dZbVLBD9?=
 =?us-ascii?Q?WUYDlzploNytXW8uYISea/Ekl/6b68rsj8xxtgeBNSR56S7VO3jBJ1PTUxKO?=
 =?us-ascii?Q?ZtLSyMdEnKl37f241tDoAIjOZIzpo1r5KYw5xJosgKjzaUM64gSK33eJsmkt?=
 =?us-ascii?Q?jQ8PysPch7bZuQ0zii87mBsGDnFY1QE2WTImqVjL+VsRYY152nRl9ulaU6lO?=
 =?us-ascii?Q?njSf1YqnH/+Wcr4I6XoTHBxbBS9serLcnsBdGFa3j4kQTZq35uNqxncFoMpB?=
 =?us-ascii?Q?3viCrLiPCvPYht0Mad+Rb4F9AQ5BpVnh9Xwq7ipS3rErB4p2XVUYvBAbMwDl?=
 =?us-ascii?Q?Icl4D0pBjakp6ehekCEkMVTl21ImwTZNGKVZWvS9cNeW7THnt/2Z4HZVhT+b?=
 =?us-ascii?Q?f/45AoM8p+GVc5z3lLucR6WgpXjI9E7Bsamq8lJEVBHkXI1x8mm+EAvU7CYe?=
 =?us-ascii?Q?3dp4tULIaYDaiKeCTPJhJphw3AqvTjrPKDH8guNiXD1bHP+Z9PLUqPP4PCao?=
 =?us-ascii?Q?ePpNjIYFtz7zEawoKHlroT14dYzoKUduh1M/WulHpoCa7kYxsr4cxA1BlYAg?=
 =?us-ascii?Q?eOOAmY8FR69rveTpdyaXJwnYEs26BmOrwMRFRAm/HGvHgGJAwIE3yyuwcmws?=
 =?us-ascii?Q?e00v+6WC6XCDMvNW9h4hjaFeyttscRhFx5hlZMcn79uHQEnn2s8wfz7aEmhH?=
 =?us-ascii?Q?WFZ+NQldlk38VAjoXDcikv73SVWdRYYialGqEsM3coobIDm5Nu4WUqn+EdRf?=
 =?us-ascii?Q?aNYNAb5MbOCAGQavXART3KOaVivz4v7U3KyJ9/mvg4X+h6O0jIDLfjOktMpq?=
 =?us-ascii?Q?QY1+mqvyI1ZDXhzJ8HsCLdWJffwSSaz+5L2CHLFDP5PLXLgCk3W8CH5tvN0k?=
 =?us-ascii?Q?K58hhHrTe3d5vY5R5q95SWhie4uUgup2wtXhq/m54u6WdiKBVU/Of4YwSgse?=
 =?us-ascii?Q?Pn2v2dJc5ySVZwNiXqsZ/SSMh4tuk1r+UWV+SQMe+qunReqW7Rne+A8YT05c?=
 =?us-ascii?Q?eQOa8ggP0Yx6zEJT8tRN5gLuaTmUFY1dMaKhWSN4WJwOlZbcsFktpsX+brd2?=
 =?us-ascii?Q?JHGKD4XVo5UQ1o62kvgNu0c6A4szT2t3HZdVMsogbcc3euECvaaA5kUrHE4s?=
 =?us-ascii?Q?Fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd02f981-f88b-43d1-80ef-08dba0053030
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:07:14.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ixQ36EvO6mY7mmOaArrTMSRWZfAON+FJhouesRJX8HCxx/c4pj2N6/kVHp4acGYXrdeHmKgfUzRofuVQK4ECsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7895
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Jamal,

On Fri, Aug 18, 2023 at 11:27:27AM -0400, Jamal Hadi Salim wrote:
> Can you try the attached patchlet?

Thanks for the patch. I've tried it, and it eliminates the code path
(and thus the problem) exposed by the syzbot program, by responding to
RTM_NEWQDISC messages having the NLM_F_CREATE|NLM_F_REPLACE|NLM_F_EXCL
flags with "Error: Exclusivity flag on, cannot modify.".

Actually, to be precise, the first such netlink message successfully
creates the qdisc, but then the subsequent ones leave that qdisc alone
(don't change it), by failing with this extack message.

If that's the behavior that you intended, then I guess the answer is
that it works. Thanks a lot.

What would be an appropriate Fixes: tag?

Side note: I believe that we can now also revert commit be3618d96510
("net/sched: taprio: fix slab-out-of-bounds Read in taprio_dequeue_from_txq"),
which was papering over an unknown (at the time) issue - the same as
this one - without really even completely covering it, either. Hence
this other syzbot report.
https://lore.kernel.org/netdev/3b977f76-0289-270e-8310-179315ee927d@huawei.com/T/
https://lore.kernel.org/netdev/20230608062756.3626573-1-shaozhengchao@huawei.com/

