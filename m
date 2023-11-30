Return-Path: <bpf+bounces-16229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF187FE8C8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF8FB210C3
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9847C179BC;
	Thu, 30 Nov 2023 05:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AzHosLul"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2089.outbound.protection.outlook.com [40.107.20.89])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1AABD
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:43:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeUGRewfI4+vpY8XzCaPioQ4LaAx4FaYq5yF85BMjFppS2aY/7ZnHFCgAzVYj+pU2b3b+yvvg9F3JWETe5c7sVqLtfvJGYCxZRgcmcOl6cyNmzuheHLlo817wNTxPC9iULiQCUQ9/5ALMP9t6T/V3w8Pdjcxl4EenXjj1AiJ5rJFWG90sMvTquILXA5FnXDoPzeUEWpqzf5wxpMfoqq5j4eBoctx06fl0Lo1HCE1NsfSvVlpu5SmwbfRxW4AKVG6pxgdvGXuT9Laga1RAcPhxIk3Gkoli9bVKrdnGbsQFzgUayGTFOxXTZmCQk707ONAFG1DjJGNjZDRhyC25oMDgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZCx7qJqYErvvqRAa+GhAUMJ9k92JxfDmOKpz0epKiU=;
 b=L+0LAajdkKWMFyNkFs5gswbf7aR1j1av5Y1Rxjy3ljKh2xtPjf5eUPtLpVw0sigBEfP/DXdt06/4UPwEZt/HOQZtyI0e+NILUfk0CtG9YWRBiiypmwB3XpLEnICQ9cQ1RXx2cGOqQH5sszNK4j0QcShu/1UWUFq1aNaxAOp1cmgTWIAVtfqoprMt2SU9kdW405LTQR3SSwOnjKp8Vl3CfqknG83uQyOVx3wT/lowYwU0JZkbIY2ITSMBfwjPy+swKGOXJZ93NRJYoorQhAbBnpRFJfNTCMRFfqUZKUoz8zDVC5isj4aTrBCWhw6hsu4uf32Mfz2pnDNmT9G16lqIag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZCx7qJqYErvvqRAa+GhAUMJ9k92JxfDmOKpz0epKiU=;
 b=AzHosLulA/PoYrBeV85DsW7zkvIvjt8K9lC/+mRwPvE32QjSIWXAOxWgsSApV14yqStLfjU/PqpHWkHHi1fzH+AqJfctgpWo2kXerSFcX2GpjgWBtga8YWMPedDWF1Am7j9qw4H3wAWTMv14846xVDflCLb5Eo4nB+v5CLlVBfPaH8S6RR7qR6+QEhY74NMXAR1dayLNsn8uBmiE1rb4ThXd7/aYftFDuy8m7O343794nAmN8+OB6NTsSRO7WmlVhqX+6c9Rciudya5GI18gPnVvDnOSOC7MypwQxCyZaYdnpTwkWfE0AWik1LSpFK8thYGMXnTI8dOoh5bXSYlt+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:43:27 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:43:27 +0000
Date: Thu, 30 Nov 2023 13:43:17 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 02/10] bpf: enforce precision of R0 on
 callback return
Message-ID: <3uuzcip5fjsqnqkzgliquammwljbi65bxic57cyvjdinmqjlvn@xachbab663yr>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-3-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-3-andrii@kernel.org>
X-ClientProxiedBy: TY2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:404:56::26) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: a8eeee5b-d0f3-4c0d-715e-08dbf16746a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GuqwGmLShdMwSmcuQk9RFfXSuKSGM9VLNDtyGyt+yDMgVuIwCJxeRBpZ47UV0/C5Pr0clt9yW6E5v1Y9CZ+aB/MPq0LzCETZZadlP9a+2D1FtsAAhDPa3+nH5yRXhsbOcSekp/Yu4JuKYnXtY+K6dE+Ht3W3HWAPga7XC0Na2v9kDLXA/qdY70SAErLeXr8Lj/G9JJpJ5BfPmDVWOKCOEPwHYwqMMS9kcEwF9fy74enqyLfoL9Pbp9KDHeemWmPt/y+h17mE3jD6k9O8pl+QrCymI4KZ5ULWj8Kc2MGGjWZ/HfG4a/PuN57IyFJzyy7stOTAwpO0pt2OP3qbrUavzHdlhAXG33bdJwt1Uv/riJF9dXj41Xc9WoR2FiijrG9VkZ0XFFCPNV+qe4BaUy82HgsdlOr8lA+4DDyv4v2CquT909q/OotJJ/jGFgWVybv5oX44nOZTEuSJn05Yh7VPo2CNBC1b7RIjHgr37g5fy42OuS56rx+eUrGSjdz6HZnA8uZRxWE2UnCw0ZrldW8Aw3+S0u314pG77lZ1R0DwjBzGx01aze2ST10DJBbmjrLoIGCDedtPz9X0U9erfHS3CpM6ZZr+IB+14ZQomUYB4uNR2ZDtK++2EvI7ildVA40J
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(202311291699003)(33716001)(41300700001)(2906002)(4744005)(5660300002)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(9686003)(6486002)(6512007)(38100700002)(6666004)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7C5rOLHqdnbhj03mYRtXlDwHk/OWdxLRpsGnSkLGLVe39ECAvVzDJ7B67S0t?=
 =?us-ascii?Q?BexmaAoUEuUAQ6MeiMuTcsmKCNpwAAuPuTnd6Rjrbs2UPqJdymVcxiwF3StT?=
 =?us-ascii?Q?P8iXtvztn+Uqa01iQ03aMAI+jJzgU6oI5NNgGa6Z5ui5R7QlfQ2faEk3117E?=
 =?us-ascii?Q?HcnOEmb/OmQ9xGAcdPe5kSopFS9csUseQOU/SbaGVZOZpCNxEqy/yVSqKJA5?=
 =?us-ascii?Q?8AXilE59GFuaEPjOpp3bcxHnXM5tz8S+hpmRBtAzIo/bgtn7J8b3KkOjbBSO?=
 =?us-ascii?Q?QP+EBCMi8UOwj3pdZoVcaYDNm27wpn2JHH9lyNA+HeGe6S8SYfBPV9mxACtx?=
 =?us-ascii?Q?vYZ7GCXqhv4UMSWiBKKU1Oo2wm+CQW6fSCIzwromJjEqsHw78dUMSuLJF3Kl?=
 =?us-ascii?Q?E3hX2ATzg9vuODALNtKJFmwMsrrBPcQ58yCXxfueyCc2BdWk1iPToHulIQyX?=
 =?us-ascii?Q?fmsH1o76gsM1MEEg6WDJrGZpwRCX4q6Ih3wFzNj0PNCN2FmVwdLOhgI2Mfgr?=
 =?us-ascii?Q?SXN2qtA1qyD6ExZqeEx3TJGlLu53Im4C3/zwq3w6NinOFBalerMtQFMCiisb?=
 =?us-ascii?Q?jAnkoUshukXf0KDrfm9ctyY1bjbj95ev204tvkLIelx/FjWV69GQXt/bcNTk?=
 =?us-ascii?Q?scM4Vt79cpteFhIWwmvp+cNZf7IY74EWgRfRgHpccffxfU/wyEA5wmKKC0Lh?=
 =?us-ascii?Q?9665HDJmzOmBAF0vxNVnb6pMmjExo0bcOQZTfDWiEx3uuzAulxQMJGyj6DZG?=
 =?us-ascii?Q?X6lyNlA+lwZRcx1kkW/QyF+PdkwWg3Ixhu83LL8zobxnAB73L9xktgXPJXzb?=
 =?us-ascii?Q?xbOHHOSP6dDXlE6ypHXv/o7GDA2154vuMfRtrtds4D8o+CuZNdEh9o3y72ab?=
 =?us-ascii?Q?9bWHvs/Cvt6yLUN5rEzqzooRa5oiyHeQKfAOcB7yJdRNSI7iGWjF/pvYlYNI?=
 =?us-ascii?Q?rY81tunmgVYTcj2B6PvnJNfOhpBZG5YJFtask+yH5A95SNBGNpcQyH/RWhQ/?=
 =?us-ascii?Q?BAKLNqiWrfLwZ6afJTnNCz61VFZHuJsjQxKcTm70TQfvXHZat6BcmkSiLRee?=
 =?us-ascii?Q?45FggsVwebk++NLnzO0Iw45rOK2nj5W4ELYsOR6XjrJvewdm2ahARP7UyL+W?=
 =?us-ascii?Q?0JocmtsgLsYL82b4jZwavW0T+DoJS33PmfWqVek8GTKeIycCyVD/+B/rCXnL?=
 =?us-ascii?Q?3qKigOkJ2BBKlIi2xF4CXOf3GIcGsLxLkGf3s/UQDzJDnu0NkOu+PEH0ZobO?=
 =?us-ascii?Q?/n5Ejq82QjSx52JLrp6XFtRnYhL3ESLfgVNH8/x5cdrb6WqDcxdk03SZFG6k?=
 =?us-ascii?Q?JsFjeim94iPWwitaCjocb9myS1N69VtGj02e3byWktM02Zk1oJHNT36q2idC?=
 =?us-ascii?Q?oWq3qkJjrl0z1V9KVCwcQnsvy53m+8wmTJWF5wUUPLUpa9tNjy84e0W1iBUW?=
 =?us-ascii?Q?Ufb5frq0fifAewixefWF7lwrpi881xmtoICoDgFEpRuKRRG8emnKKT28xZAo?=
 =?us-ascii?Q?DjknB0HDp1C2/Z9ouMG5Gvk5PI9XceSper++/xc29Z5ySO3wgEtFjYsfPXNz?=
 =?us-ascii?Q?hx2qvUFeUem48Bd5ZRTR8KWQa1GDURIAeslOGgeaBCoZ/lvuaScus3uZ05TR?=
 =?us-ascii?Q?mHi/8GZ04F1QXRlp5bi4oQaN4ITzRnvkiBSRs3LUmw4RmEpQEZjZnDZ5SkEV?=
 =?us-ascii?Q?hpuOuQ=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8eeee5b-d0f3-4c0d-715e-08dbf16746a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:43:27.4102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JDtS4zLsNm0TLvzOYcP44XYpK/9CZhkcm5fAfbnGN1pY/ZRg0sbMzlMiRVS/J1NQd2jkt6IfS8K2EwcmzNjcsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

On Wed, Nov 29, 2023 at 04:03:58PM -0800, Andrii Nakryiko wrote:
> Given verifier checks actual value, r0 has to be precise, so we need to
> propagate precision properly. r0 also has to be marked as read,
> otherwise subsequent state comparisons will ignore such register as
> unimportant and precision won't really help here.
> 
> Fixes: 69c087ba6225 ("bpf: Add bpf_for_each_map_elem() helper")
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

