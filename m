Return-Path: <bpf+bounces-16233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F617FE8DC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6DB282364
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DB1BDFB;
	Thu, 30 Nov 2023 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="mPaaTiBS"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C08D7F
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:56:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSS/847qzboUzpQKGZoV0lcGmo0lVIV8VrxMxJQaOO2XWnxp1hXlGE+9EWJkJ0mQRtWMPBh3FOHqacViX6ArTbxxashFRC+LKa63u9LYI2wAd3Gce5jPXh21R1O65lJAkUTu7Y46rdHXrp1zcZ13jUF/7yttO5z0J0a+OlRi/oKJyci7dsYkCB7aC9TDKvOvVsPgIJQ/4kXgnGPM1Z7Ew8ZTaqT7Tipho27Y1rU/m+B9OAw5ochqH/fK/GFaTt9oOWmrAyeo4gQqSfvV1W5ygUqaHCZP4NXHfGoJ0S7/GPWG/rkfQB6c+EOJW37Xkb1lnxoh4Wgy5ZMoceZ3WdeSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fo6KKlw9v2Ka1uusOtb++q+0KzTWxBg1OqIU4LatrbQ=;
 b=HCauYsVN7ZgyPCk9Pd6YlWIaEe8ZcEYfIj/qv6+hZR0iweYGn3cetVuVZyzmSmUTaAXTB/gRQoRXMMwWf6FJrJP0jlqIqL9FJjdsPJ3QSq32bL4q6Vow9OybS5604wx7xmBmq2LJZbyxouwK8c012Hv/8dm07ipJKcWQZIFrNONIlStRVW4ob4l8XcN34LRxTgvXbk0tfKGQDFHMrOBBm2SS4bSE2imNDlTEg074e5SWrULjaf3lbbpCtw6cW+lTJanm/2VC5u5Y1kX1QRqwNLcK6aSKDzgxed0lKG8Z639jHMS1gOoR2pDGNjtmusij8u1EIjVU/glhGcCz7RXUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fo6KKlw9v2Ka1uusOtb++q+0KzTWxBg1OqIU4LatrbQ=;
 b=mPaaTiBSF1t72q/2xj56nwhVDRSIzlbuUR436p7vziqDCe4LUneA7RupeHBK3UAPIfkiE+pl+MqszjceaIE0weLrlk9g2CK+YssAfMvy/sctivKajR2Ui8zbCWz7mbJWR5ft6xAst327ub8lG7ugxULJHOuY2tIKdK1sYkNGMFvq5sJ+67Aq0GMfBAWm4K4K0SjA+h9jCoXxzqI3NwxbXEvmxc5c7/uWClsvdbNNEM7O0VXWcnz/yvnEj9uIq0ZklrCWHmyV1ww0RIZ3Dj0WaxoQoroQpG/oPay+poLiFmBkEpewrns6zKxB53YdQ/Bcy9qr2QNpbIgZuI6k+mv9GQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 05:56:44 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:56:44 +0000
Date: Thu, 30 Nov 2023 13:56:34 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 06/10] bpf: unify async callback and program
 retval checks
Message-ID: <vmt5lotyd464n2hlim4cbp4gqmgacobiwq4zon5we2bfbxiclp@3wiajnvr7ryd>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-7-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-7-andrii@kernel.org>
X-ClientProxiedBy: TYAPR01CA0023.jpnprd01.prod.outlook.com (2603:1096:404::35)
 To AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|PAWPR04MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: b3175cf9-60f4-4763-f7d4-08dbf1692192
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VI5DSt6Xhwh4g4v84jmketrAV38+dIaw8bfrHT7jTsM225FaqnqNSU8lFkmuqfNIgjkgXWa4KDL1wS2zh+lDRtWYkZdUwvm/ZDIfiAsSMs+n0KbiFkdyY2bWisbnXaQUBP40Rg6KX+E+Rpmrn/vl3IaXSeJiuhofONWEdxcG+37EF8rOjVnVeS51807GW+29MHqFd5vaACvBnE0qVcDMP+yRLYB8KCfhYkCUuGO3NbQwD/cLifeyV2iE+l5N8tMhJrKjX52hN4uT1bnp3NwYr6rgUmgbWmVtUabn2yYtdS8pe8KoIEzdXp0pOCfYRVRvJlptfbZYO0+s/7GAbVqa6PVZGiz9KdLE/BPo4nOjazyZQn00unqcj4tO5ycOONgsGvN1WwjeaQMPqB7urBdzXS+Yw9n62sEikp8PRrEqAkU9MOc418ZjYu1GjR9ihs84oRCt2PmmpmLwb5jJANuPrBTrVneoRYeuF732IZuU25ypHPX/KTJ7TfdqSEzA3RuQPPIDDca6nYb9U+IPuY0dAUIesSsV20p7zsqhkWNjWrpxstpZbPrbS/0pnXTOs9VrbcighxSy+0rUMpBmODFAMY0jHCXhNlxegN+c4zSmJMoubPCJamFff7U8BUkEC60Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33716001)(38100700002)(6666004)(6506007)(66946007)(66556008)(66476007)(6916009)(86362001)(316002)(8676002)(4326008)(8936002)(41300700001)(478600001)(6486002)(9686003)(6512007)(2906002)(4744005)(83380400001)(5660300002)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sv+YkF010L8hEmD4ts/Y/OUbR82U7MPp0BO5tcajj/PdY7yrtFTjE8tYIWAV?=
 =?us-ascii?Q?eBgfOdAVLKqdOHkXQR/Xa/uGkWwP8ZiFDvqlr/Ey5lbFaGA4BYHCrr64KpGj?=
 =?us-ascii?Q?8FnsB+Qq0kMjP1cOhbAoL97NCojlpppmX5brxOK51jrkqi+nRPdrASH2Wqxr?=
 =?us-ascii?Q?5bD0vyAk8anQJWDef/CFKPK8kJBrK0kMt2+CMygpeWAEkPhh0pjwAGjg0JMS?=
 =?us-ascii?Q?/n2/2ZoV/v7BGu1w2RLS34ZiymUzyHc7QNzXezav9zYM4IMITbT/TG0N2lD3?=
 =?us-ascii?Q?n/xt+680EDW9CRsUXgy19fk9VK7zMvJiM0XklB08TovnGoXZsVjg/t+pk8yg?=
 =?us-ascii?Q?gqLPm2ICMtx6pTrdEB5CMVkScHTLqHPSJAhl8fL9iCFADYtKlBwl9zne3ZDG?=
 =?us-ascii?Q?X5jpWvwnEpQgrf7ROtCd7IxlMoEdOOcgepfJQVQmUwUlhjweK3DjKaB0LHU5?=
 =?us-ascii?Q?byMnPsyeYprUet+pnQ9eo6JRtK/yxm0kVBrsYesj0Z+n9rTe3QzxCTGA9EVc?=
 =?us-ascii?Q?9aH0PWHxk59OXZG46nyzgFldQohd/FscuYAJeLIX2HUwi07U0FTEYyqWuZ2o?=
 =?us-ascii?Q?xIcj8FJ7+bnQEufFueItAZLFYNl2fc3lPq/1nxzB75618onc+nOth9VMSO3U?=
 =?us-ascii?Q?R4Ix0OfdOaGMlGpMobDFcL160KKBb6li2X7lLTPvPxd3SiuvG2GqMe98ONDH?=
 =?us-ascii?Q?+QtLYsrsyZLrALflK0dZSjoCWbQhLbJVJb+bXWqAfV4Irenev1//ZkVx4kf0?=
 =?us-ascii?Q?0VBWUiPwmAnZWWmK8r/Cs47TZCLO999/1CErjX1MjJT8ADAFiusqt6pxuxrB?=
 =?us-ascii?Q?GLgqfM65vQOWeQCyRfXbydGKxlesXMpKh6f2KBtGDMIEIdpoipxoQBqb4IAS?=
 =?us-ascii?Q?mB/Vabf8fJQ46eSPU71sStFB20RbLh5++iuRcepvcBziShwR+nCzqKRilSSh?=
 =?us-ascii?Q?Gty4ORszOuV6dGy+AlBr5+WQkdcbvMi8mjGbn42ceAdFCrxDZrduMIghJhdv?=
 =?us-ascii?Q?Sr9XJpghpjSlJiPgJxWj8b1mRaJ7GK/oeOHG5Lungjc51lAg5zB7fWHKkdpa?=
 =?us-ascii?Q?yqJsfrfnaUQvATvDey37VNsSGDmrxWpa4L4lbCc8AtWp+hxqgC5LjBUxIOxF?=
 =?us-ascii?Q?8VB+KJ0WWA+ak8PjWoeOo+5Psa4yl+atZr1/uZzVD/j7qxlqi/o4IlGXWIHq?=
 =?us-ascii?Q?LAA/9boa6No43XVAXW6k8YIIBR0yBOd2NE49wh6AE4mKcLi2IGJir6QaFcSP?=
 =?us-ascii?Q?RqsihL+GqhqiFGTJO3Mp+qJAtr1Q0uVnWwEINb9qBUxPyjnywQyQ6WyoOo5I?=
 =?us-ascii?Q?GIvtSR+iOb2Rk5GOaTdTH9NTTzme8jZxCTZfhcfCawX+5NGMDvZhRveK0KRt?=
 =?us-ascii?Q?bupquQkCC1VtresBRzeRS+zCvQpns9CJCWfg01DcZf79RlOuw+3t0v9ijaSS?=
 =?us-ascii?Q?EHY2cy2gSrS7LmxhIEPkS9EdAoGo0xPu9+sXLzUaDWKybtBfYzVr3JRCrXNP?=
 =?us-ascii?Q?og56Hhkn9uazbv+x0goj4d8/NKW0GITTj+1BOM9VJTMzMpzO2kEkoO4jn2Dt?=
 =?us-ascii?Q?w7jlDopOqQE8jVrDj5cHahDZBCJBwr96rMI6ONg/B2kfy4hLkeaIIs7Hegkd?=
 =?us-ascii?Q?StG8NRhyvgiCpfiN21374OUtYX680P8u1wLRQI05IpyqCEom59YYh6x6UXbD?=
 =?us-ascii?Q?lQXu8w=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3175cf9-60f4-4763-f7d4-08dbf1692192
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:56:44.1047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxmWjwwJB8Bs5S0RMXFJyf5mYmiObevwhBpkZpiJj1WhHup+UC9pOxSTXNdmcJClVJowTCQBkYuWAlAQ4s4kuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912

On Wed, Nov 29, 2023 at 04:04:02PM -0800, Andrii Nakryiko wrote:
> Use common logic to verify program return values and async callback
> return values. This allows to avoid duplication of any extra steps
> necessary, like precision marking, which will be added in the next
> patch.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

