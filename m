Return-Path: <bpf+bounces-16232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969127FE8D8
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15266B2111C
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27DE1B294;
	Thu, 30 Nov 2023 05:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="h9O+P/Bp"
X-Original-To: bpf@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2052.outbound.protection.outlook.com [40.107.14.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A820D66
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:54:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ic2UVWjZgcPhTAZJU5IgJXpTIu6KS+sJ5PQOpmJ4AU4+iFnj9J43fYPbKZierNTcnD3JxSP6auZ+DXeybi5JR91ZaXfhoSL5Uc83MeRoCGmj18zLLhC8opLEiB8FdCrz2JtONnfx7pwjOM8DOXDezhrL32ALNxWfeTymhJfP9JJEPxUObhIXRAu0tqjPbkoUD7ajtbFtbC7mj6eNUG2hxK4VqntppsJGSBtf03Bqt2nvem/lfVywaeh9LZTM98X7P05CeH/eb6BJVd1oTJkuns+wxVyo0X384rf3NyZOzf2HAVrXtBFpWWUvKZ1UW4ECl80PbZcWgbTqTENf7fIBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OV5bffcx553OfOEcde/ABsHT7/WjUsRMXJla7oVyaEs=;
 b=EYgdJ+qDjIDixYaBPaZFpKhm/zE7jzuIWojKNa7aAhEGolvPoYQXYjXz3hqaX8fBIXZdkVL2WLfmHDzEtC/g1G218fGnIqRC97Fay/HSXQnI0L3ZWk7RnpazJjXL1q7iOyrtAJFxYCRl196Oz/xRThlQTwSLhjU5lEe7IR4LgJ6SDzcOuCklUbn+xZt8E2XVGAGufcA8nmN3AkneIytt05HafVMoXdauWx6+M26vXljSWBegQl6Wv1kCyL3WAHHW38IbmGNtxRkDwv9pntUKJtFuxmyc9T+SGjyd/SFhwbh+b6ciJ8hvefiOMvXK6DRcoEvN97aP5ZLuFaxn3reAJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OV5bffcx553OfOEcde/ABsHT7/WjUsRMXJla7oVyaEs=;
 b=h9O+P/BpXbuxiKbXQYL/baBIzEC+UDzcOpIpweQdzwvSxJ+DFDGlw5AgImlvjtNMlcUFblvGg7SwSjpmieegEWiuuXyJCEmx5JZnO6Y2oS4HpKa7B4UryKH5Fc6Sp7bc0rE8GnaihDtNa/eWtgkwyTbC8V6QuDrMYL5/OicRsG87VombhByG6v6PCMCQPec6PLlV6HvXvKU8+Zlya5+gmn7iBFN7R6cmmX6qxOn6MwexH2AEA1+2QKrK/8+MEOON8rxa39Fk/PpeArnP5EOazj/xmTpE0DQhm97WkxkO5DUwRUoYMOjghW2DffJCjjL5BELYuFZOHMA9xSuo6CSZzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by PAWPR04MB9912.eurprd04.prod.outlook.com (2603:10a6:102:387::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.13; Thu, 30 Nov
 2023 05:54:51 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:54:51 +0000
Date: Thu, 30 Nov 2023 13:54:42 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 05/10] bpf: enforce precise retval range on
 program exit
Message-ID: <uvfju5kluaaw7ywaj7lmqunmtrcyz3asm5wdlufwvk4f4octsd@gfhph6ninqwz>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-6-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-6-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0363.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::10) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|PAWPR04MB9912:EE_
X-MS-Office365-Filtering-Correlation-Id: b8848703-8f5c-4a68-2df8-08dbf168deac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y0ReBrmUE+H0vObYIGu4P6gQUjyfQysebyZxH358hAnps7cMpruaPg49xbh/dSHzE6ulH8XB1v7aaCiHhELssaSFOCqVPBXJfK8ZjrN3KeM+efgmkeVgbOjorXGPDkIk5k/b8nv9OtxzUNv4CIjp2bdYMQSwIAZBg9jx8o8z9INqnoKC2OmPmyfljiPmJ1EaNNW7DDgLitYJL6iY8mPcbVpVSyBrsJYknc3jWMhZA3VK/7nIYwUB271FvBKaFxExd3VFDWqZmNxmuf0Do5wW3ZKAlN6TbGbjGaYbA+EvUCQ3myCUi4yA3XHtxpuefln/yYzETBLCxSmFP7+pgm1aKPWvXK0Tams3Re4KudwvzXlGjSAK9CFZSbjwbDEqq94gg4LVNlk4eqs3I68/zPRF3cVS8bGrfBw+Y9+b3yhyR60TcGW/J5wg9Mf47Z2QLGhEZLsHhqzCDlbfu3GdciqMcjBsGwigcgDQjfNUpYUlDn6tX/2uj4TaqOpRQFmgWuCfIMmPuD/HxUgnOzZ0fTSWtobkpPkezOJnY5kpRDOho9Ub5Px22RIv41hznmzw8RQCcw+Em1QNjDBHUTxVA1nWMNovy4Ea17Bict8Po4tFvuVXkRC2A+2y7oroCjKb/QhI
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(366004)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(33716001)(38100700002)(6666004)(6506007)(66946007)(66556008)(66476007)(6916009)(86362001)(316002)(8676002)(4326008)(8936002)(41300700001)(478600001)(6486002)(9686003)(6512007)(2906002)(4744005)(83380400001)(5660300002)(202311291699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nSCYQ/0tEHvxDRg1mKWpvos/5JDASfzEC3P6gcjreRe3eAyKFGrA0rz2LGzL?=
 =?us-ascii?Q?WHG/FLyCpyi/+kL1V1hkq6ApFdoi9coHX+KNmTBQa0NGeePI7X/BMcgQCFIz?=
 =?us-ascii?Q?jxoLCwt2MyrJttbBCcZmKvFRhT+vBpyiW5zOZKpQrKGY+MbKKCaX94g72NnO?=
 =?us-ascii?Q?jwpZ7I1MhZ4LUpr8sIo6POLxxBYjlL4IGE1Bbw5JaCMDy7bOBkLyvLdeO2cP?=
 =?us-ascii?Q?z5sGDliIfZLnBJ6NQYz4ciJ+Tj8UaU+590oc7CEIoui96sGUCaFfMf2lvrsI?=
 =?us-ascii?Q?t3zazDVxrXKfpmY46YYMsPzi3RbSq7sMA0CaZxZ6mwmPbbVuetoesHfPgNZy?=
 =?us-ascii?Q?4cSvzjGVom5CbBO+yEUAQxDtVTJgukdsMzRuQwLTaSHOAV+Mvr4+resJ8Usn?=
 =?us-ascii?Q?Nqrdu7W2EgMV7gdvYLsmu+x9nEh7RwFMqpaO2uUWpRN3Krgh1N2NKnMxmURp?=
 =?us-ascii?Q?NW855PHzIy8vuQpfh5LJkm3VPacTvvH6PTvdcmrUl3ZpDWUWWrV4sOQ7L/C7?=
 =?us-ascii?Q?7/R8EL3mKHklK2RP4ilMJTw7ByDqZFovJRAGRhP3CF26I5sO3va5LG7pg703?=
 =?us-ascii?Q?eq+VKFDrMWy54+D7KocFLcCKeQkkp4jaG5R6yi80LJEjkrBsbuTxtUtOVbuq?=
 =?us-ascii?Q?E9mmDx421iHyz3hab1XaEfZ2yCqkrA4IlQZww5t2UuAkUqTqKj7D9sz1pZRS?=
 =?us-ascii?Q?HHrcqeFUcajr4SISSw/XEJpjHBQRnihuk4UfcC0LKlMSGqvGeK9sNHiGBOBR?=
 =?us-ascii?Q?KQBsv8on+sriVdiMYjHJtAKNH47llNo0xSL1JKIN7wJNUhasDEb6idvYWBWW?=
 =?us-ascii?Q?i0MJakDJDYwUDx0tTRjWIJ1B4FLB2m/V1BMSqwrHYrVzdTUN99CwALUOZP1K?=
 =?us-ascii?Q?MZDADPOuQ7k1V/35wtmx7sMQpXUCU9BcCgprbKrVumQz4FRcn5qyDVSI9IfP?=
 =?us-ascii?Q?d7s/CKNNBzrZWuqQzlzKNh9Kafge87akfTb/JcUjt69CPttkigrqhz8u1PjE?=
 =?us-ascii?Q?l+MrCn6LIVnqaKWXgQDa4GZlvWXkNJjtvlvgXIFNL7BkH+iJcgUs9g0VlmOA?=
 =?us-ascii?Q?+ogAnGBi7v8bHX/LsGrlv5x5bQjc0lODtff3c3uhZS0FKN4WdVfG3PJZw4Qf?=
 =?us-ascii?Q?0zu4sssCLgq/7P6CbzOQb5EqvDks0P36WifbDIgkdW+ExBYOX5Gc0EZQJM69?=
 =?us-ascii?Q?XOnxfnRVEAyQK9/fLIWGurJmkmxGf41LvmNYmFxKA8bfDzmwTh9Z7UAf89Zz?=
 =?us-ascii?Q?GonWmJU/kiA8Ol5sTX6Xm8RrxaFX7o+5JZEFXWCYMrIgq1pBmY18LCP/LHmb?=
 =?us-ascii?Q?TotrCN5/Qu9T/iRqm8wZxOJGlcFnGPdIrYrzLVSsl4ZCSn0zhoIRg49T42E9?=
 =?us-ascii?Q?Lyp8zNhdUZ7JCJCzfFrK8YF8ponC7jrQuhyhKR/I6ys2qDJaUnB5VX+fPODC?=
 =?us-ascii?Q?kUYVO1tijagHqsURUvWJ4/SRR3vf3yWU4gMk11IQU2eIrNe774oZ6PCe8vvQ?=
 =?us-ascii?Q?dufaXfH6Ok/7v4aQTa9ReWIolXd9doumuGg262pO3NbJk5Ygii3kM93jgi/k?=
 =?us-ascii?Q?kvkugK6eTrHmHqnQLzpAxN8brRXfka4NqaQrKq4Jwu5WwKlZELJR2ZEzpYbL?=
 =?us-ascii?Q?8F3AlT1DBq/RQKJwn6HE4B3Fay8lAT4U54DuIA2ofDDzuUIxnuJkwTlnQufU?=
 =?us-ascii?Q?Z/FRlg=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8848703-8f5c-4a68-2df8-08dbf168deac
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:54:51.8542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V1wYUrajWCa3uwKiLxe82gTwKUDxcECRIYEBxai72M/GvuyVdlv4qkfzUe1jRMLSB020n6uBL/2OiPmqUftqEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9912

On Wed, Nov 29, 2023 at 04:04:01PM -0800, Andrii Nakryiko wrote:
> Similarly to subprog/callback logic, enforce return value of BPF program
> using more precise smin/smax range.
> 
> We need to adjust a bunch of tests due to a changed format of an error
> message.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

