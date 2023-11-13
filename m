Return-Path: <bpf+bounces-14971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0F7E9659
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 05:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC9421F21137
	for <lists+bpf@lfdr.de>; Mon, 13 Nov 2023 04:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908C96AA2;
	Mon, 13 Nov 2023 04:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Jb5udZbi"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EB78BE6
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 04:53:29 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2057.outbound.protection.outlook.com [40.107.6.57])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9E01719
	for <bpf@vger.kernel.org>; Sun, 12 Nov 2023 20:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U913KL32LrvwuY9ScXShGb7OJqEMreaZ4f60q5fUkWNo9/dfCOz69PD0J2FbS3/LlKZhnEwyuGUnGCBlv+AZxFcU4Gxs5qhKnCV5Aan8uq2XqdNmLkZIh0pDw7YS6dEP3tn6+xkR+23MmLGtb3t/oKy03m/lOlziNSpHjac1/dNAudUO8sexUn1n6+Ckpth/QDKCi8Zddahc6m2Rr32yG+6Yzt2miw0t7EpwYylxE9g1yGQBu9U514ITFRREG5GDABwBMh11J1Ue2rI2mICfXarN6/GQ8B0Gr3XVkR2jiBZs+8Wp1R+mqZ69DuicvB0+cmzoTj52MqWTQsuvIK6+gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IK7vhQg1MvOSx1Js9K2bV3F+hC73iild0NgPV6UFbpQ=;
 b=cb4DACSt8+Ve/ZF6bfr1V5q9nGrf+KSGWjoooYH2nKdAYCYKzXFYerM5e+PpiTsvgx2k5QCbztZ2vv+wF+5oHYWoZirAVuVHXSKKsDln8wRMbYSqnDE0vkKTr1bIx4Cj8ohVSO0SB0sAYndp+DvT3HaVXp2fLNqjIZdOdirsIeO6gdcz+v6lUmRIsFDGw7dLV7jFBCkqQVy0MvkqCtlvapMbu3UG35i5TjNW/XlMEKw4r7lDLgihwF+34LjkKXYxrykTk6RqhxkQiTML8b+Xl9yBN0AGSKWSVau2VbtlwtAekylf1U4JaHGipgIKdjz96NQd368cl8Vs5d7eqnqNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IK7vhQg1MvOSx1Js9K2bV3F+hC73iild0NgPV6UFbpQ=;
 b=Jb5udZbiHhkFXGtX2ssI9MfsylgyaLpPYDaekDiJoGmj3CHp/7V1GW+tXO3m6oLEmvc7vdePvgJ/RVq2DCPTDbStEaxguDX62namXrCGuUVcGJQCjrrPg7KegaDWWze6DO+5lc9Yy6+oiidvOj2oTdBPPc5TaUkAmfYRK+K3oPmXjpeDaKFC4T/XMrNlguo5H+qanhHfoa0tfZRulME8Ofzvdl16cpdNBqLb+YRAZOtaOu1W3L9L/qaaDMsjrKTZYxzbrnsVGVaNH8UeTy7k9CpbTvbYGEZN1cy45kjSAwGG3K/gLsNDY7zsmqbANcPf6aMh15nVFcrXJuhAdB0/bw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by VI1PR04MB9737.eurprd04.prod.outlook.com (2603:10a6:800:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.15; Mon, 13 Nov
 2023 04:53:25 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%6]) with mapi id 15.20.7002.015; Mon, 13 Nov 2023
 04:53:25 +0000
Date: Mon, 13 Nov 2023 12:53:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] bpf: add register bounds sanity checks
 and sanitization
Message-ID: <jocxeodjb3njeqr2vaeih675qcosgwuobpll5gyr5yruf2tarq@nho3y6texrid>
References: <20231112010609.848406-1-andrii@kernel.org>
 <20231112010609.848406-5-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112010609.848406-5-andrii@kernel.org>
X-ClientProxiedBy: TYCP301CA0027.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:381::9) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|VI1PR04MB9737:EE_
X-MS-Office365-Filtering-Correlation-Id: f70c213d-95e2-4d21-97ff-08dbe404785a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JALwIVyIldjWaOo5T//Q6cXd+IWHQR7D3s24ARDwErgigoIrn0KPzFnjCuHcZH0hW2NYs4xjzeOU++buCLWSV3TMCLJCX26q013v9+ZDfj5APdOFuqvix+NiY1vYvSSYNuLvbkwWi/zRCYOa+063R9nWQObyDBueb2FfPAL70gUk8h5dkeyZ+oE3swcQdY0t9Awh9D2OAHhuYsoonmTEu/dSBte3lRI7Bk8TFgkHFT/YrXi/CgYb8m1M8QszkuBTOqC+QrnY4eGoYjcq4ftJhJP1XxX9lrENLrfX5f7gthFoYkmlOq8VZ9xrrOmdZi17dXCmT+1Z/3WGqCBCzTawsgaz5xtPN+Uh3Vfwj9oesYFyrHmMJBpXYhC9wNi8cvB29PiqnmzvY7M9jv+eHEjInAoBh5esYelBI5lKi815FHllxllibnar8uOAPo8zO7OvFPwO9kWAvWN6j9jD+wzl4QfBGZDQYlYLOns0LuSg2uMVJCOcv/UyGGZr0l0uL0MW4THFzldRHMhEP0hTwO7HSmSKscdHQlzYc5LXH9CnrazgCDUb8WJGK+Zl4Jv+cEgpYbStnjlVY7UAqSidyzw+/J1l9h2i0oCRC5NKO8X1Pc2fUD8DyloMBJ6+IYjyNRvA
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(376002)(39850400004)(396003)(366004)(230173577357003)(230273577357003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(5660300002)(86362001)(6486002)(478600001)(33716001)(2906002)(6666004)(8676002)(8936002)(4326008)(316002)(66476007)(66556008)(66946007)(6916009)(83380400001)(41300700001)(9686003)(6512007)(6506007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nf6xNsfZZAU7WVSEXUiUrPh0h39F2QHnHNqPiVCDQbalG/2PET1XTOKY2OeT?=
 =?us-ascii?Q?H/xkeP+snpEBWf9gXc0usareqO01OqlHtBIGed1/CHKo4pV4uam8GdXk1dGj?=
 =?us-ascii?Q?GQ2Dv/IH4+0hubbgxWsjZiknQq8vL0btq8Cn/yjTHqA5bNrKFHVFMSzqeALG?=
 =?us-ascii?Q?zJeK+z+OCUtRPGVTO4iX9QkW2hnXT21ILLOR85rjwxT63I0OOPsLXW2ErgjT?=
 =?us-ascii?Q?+1gpIAMrjMsX4y/1Zf0QQVAbQpaOjEHpay/RVYinPRUqVt2PZ9eLzg9ACfWF?=
 =?us-ascii?Q?D3OdANk3VCD0oPdL8vo0dI15I1ZXUNfRSliGeYxjW4TXqbwjxcnYZmiKisPg?=
 =?us-ascii?Q?Bw4oQ8rWnyfnQVgL4po1+riXuLjBzjd9JRLHPA5xyaw+xM1j0UniRozrgrTN?=
 =?us-ascii?Q?s9/WhubwRYD8lwT8O8ob0Khp/Pn6i+Nf3FMtRNUB8ppasEvIuQpnMjV7v6NM?=
 =?us-ascii?Q?EYSH0FWlm0Idzdv/IZFpmUPmhLsgscVyVzmGliXzqcjRpp8fr0QkbIV630Hq?=
 =?us-ascii?Q?zRxDSbq1vbA63EP+lpjj701RAqat2ydY/NECsAJs0X9jRzm9zVsi7v4vfama?=
 =?us-ascii?Q?tvhZmKGlaIiupW/BwSdaDMf5Me2Ws8Mm/uEXjQtuDGZn4yloTFSzr42chqj3?=
 =?us-ascii?Q?gPSP7RBtvRsQm9JY6OHXuw7hxpl8wu31Xna5oWUZZfAFpWPO7Hu41Q+h1IS1?=
 =?us-ascii?Q?gPA3qlK3daOPGdTJ7BeCxVNd3zC0ylC4+tnxUDxPAMEeiRy7GljHRMt0vzMV?=
 =?us-ascii?Q?Ht2s2CRQp5y+zpLCD5tJNQXtry9gmlXxNSEbbcerigXG3PE1OTam1YXHCxB4?=
 =?us-ascii?Q?wHdEiMKxg0xnrB/cnDjDp/hD0l3weQHZ9Ma11wOzk/WdMmJGCiXaYNKACdWY?=
 =?us-ascii?Q?MFbB3E6yvGiPDySkg0BJJTbM0bdPQjfRQKd0zrxhOlZgyN5eRyXOQ6CP1GgE?=
 =?us-ascii?Q?a0ZhMX13fcNjDusXG0J86Yq0JBZ7CDa6id8soTxpI6Yx9t6UfqxOEIhuwXbL?=
 =?us-ascii?Q?Lqn1F1h+5cAJbmURj2h5oWsSwWfvZD+0yer7Y/G1W6ulobSKXPOJKFGT3dJ7?=
 =?us-ascii?Q?TK+sKHNvE9zBSbxUqQcknDAmITn2loB5IuGXIikA8ybUu3EfDy+sflDYD8jH?=
 =?us-ascii?Q?7kXQiYJ1BRTMcNGFmBEGFf8OzSDKnWzdvW4cbwFFvb6kDUdPbj239hna5huO?=
 =?us-ascii?Q?d3RNbktO+plJqHgIhdv2fQJnKRZ8FNGCS6oqqOnhxtGD6e9fEp3B82kTZX7C?=
 =?us-ascii?Q?qvVNgdwt4ebYY02cLdffZFKsfHFdPupvcCLKRp9pLmK+FF7AUwTwbz3L/4QS?=
 =?us-ascii?Q?XMsW0alSfJrdxKdx7HzoJxdFSWoHgKD0YvPm9Dbqk7wPus5GwuEU3KAtR/Zd?=
 =?us-ascii?Q?4+bTxUHZ54ho7fP+DkqbSIFczkwOsBGmdlMR924sRijwePoY6KD/bzE7Rmkq?=
 =?us-ascii?Q?JluusSwXtk8GBc4x3Q2QnQUBaH8ISWuybBHhXre9RFdS7rothxVQLgi3O5i0?=
 =?us-ascii?Q?8w6rRbB1x4RLcX1Slr2N19PWshmj/a/TDNgNJ/x62DatPuaePHrA0JuGgMhy?=
 =?us-ascii?Q?Vof8Er6yCsFF98/6XbgcaOol8TZsQJMoeT3gsj8RXVGosvtkY2Yw6Vk6d1f7?=
 =?us-ascii?Q?eusSh0NjgpfXsB6r0/f5WI2sCbZcruMKLj70Yn598hwH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f70c213d-95e2-4d21-97ff-08dbe404785a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 04:53:25.4611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tG01c/TeGWHJrapZXraxp0R+Gpdk9XaKHSp66tw+pMX0gvYLcwo+IFUM0XZIl2E8RUqb5/F52izXz+747gdBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9737

On Sat, Nov 11, 2023 at 05:06:00PM -0800, Andrii Nakryiko wrote:
> Add simple sanity checks that validate well-formed ranges (min <= max)
> across u64, s64, u32, and s32 ranges. Also for cases when the value is
> constant (either 64-bit or 32-bit), we validate that ranges and tnums
> are in agreement.
> 
> These bounds checks are performed at the end of BPF_ALU/BPF_ALU64
> operations, on conditional jumps, and for LDX instructions (where subreg
> zero/sign extension is probably the most important to check). This
> covers most of the interesting cases.
> 
> Also, we validate the sanity of the return register when manually
> adjusting it for some special helpers.
> 
> By default, sanity violation will trigger a warning in verifier log and
> resetting register bounds to "unbounded" ones. But to aid development
> and debugging, BPF_F_TEST_SANITY_STRICT flag is added, which will
> trigger hard failure of verification with -EFAULT on register bounds
> violations. This allows selftests to catch such issues. veristat will
> also gain a CLI option to enable this behavior.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

