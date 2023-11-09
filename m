Return-Path: <bpf+bounces-14564-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D273E7E6580
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 09:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89BD0281250
	for <lists+bpf@lfdr.de>; Thu,  9 Nov 2023 08:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819BFD307;
	Thu,  9 Nov 2023 08:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="F6zkrqJx"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D51D2E5
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 08:43:28 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2075.outbound.protection.outlook.com [40.107.6.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE041D4F
	for <bpf@vger.kernel.org>; Thu,  9 Nov 2023 00:43:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BNUp6KG/5H7lgILRFTJDLD3LGPUCfmkg5BxIvom+6icZAY1BggI+Z45disqSVQePORg5Q1+moA/S2C43s6AM267+KFDQYiaZ1hFWeYQBQBAirkR5ItFeBkSt4zGkOT74Ju0jlV9P9a09TupUlvD5GF+FRltlgXJwyjABuN11R2rbyU5Qsr3/R9ZXkKgEeE8RTnv5F252mJCHjnE1tVxwGtQ6T2lObih9/lwSfEdfIuw14JKcvLIf++dgFWKQXL+Acjzd2voPTNhVLy/bsq5+vjOaan2cGCrN0451rIdxCU7eNRECfsMt54e4yrp8+6IKw7jN6ouVkyUwEh19etPioA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5t5eOCnUaaVFW8+Fti7tUp6STLby9NIIalPJQX++XUc=;
 b=ahR5RxRg+ZPAXe5H+nODlrKwhjJ6s1adLaadP5Bak/KRRdDZCBBxdWh/BHdXBfxd66xAZCI3JOH5gsnH0n8YzUKjWMAoFFZ7UVszHF/a2bxir7QLAvRY6+A/kwvMMgOgCQU8W4T8utc/Pd8qSGOdbNLAmLZILu/EchQKWVXC8FOp1Y9ObzGlfaWNO6ZmMiG4nSUhTuttsEQr6WjYAm15APbPbXGD2qH65weZbkIwFIWQxGf/FDohngrmW7v+RZIfDC13Sk+zI4laK86oB7KlsI8XhMssqWs8Hs/Z+3FAOXR9DHys4UUhDDu/mb25EaPNK57PF1IP0Dw/X8BBBQOqjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5t5eOCnUaaVFW8+Fti7tUp6STLby9NIIalPJQX++XUc=;
 b=F6zkrqJx5iNGMUH+6O7/MAWTSbtSCQe7iyQaPM4X0HJ2+QjcB9qJJGX+/F3P6ryQpy06JZTBYB79+JmPkGqySBEZWul8gYV1wYP1ADFQJdt8jigoY5ncDeaf+ks4jJnzIocepAWjhWLa8tECVGuo8nnTaMVzIt9d38CsulHK24t61YpJAcbwOpoxlEF9/0unw8uGK65A5Zh5K0BnZ6ztXkwlDE576AZtDPRujeQZMo4xjRrSi0vGpZB8gvzbdc9Nme+UwqWarzgeiupKHXIu33gRr7VeMP/ymOS7CIFwnCyWt9R/1eCqkkfYffWRglZO5jfb0l6dTgf0b+SrZWspqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by AS1PR04MB9381.eurprd04.prod.outlook.com (2603:10a6:20b:4db::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Thu, 9 Nov
 2023 08:43:25 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::24f2:1041:ddd8:39f1%6]) with mapi id 15.20.6977.018; Thu, 9 Nov 2023
 08:43:25 +0000
Date: Thu, 9 Nov 2023 16:43:14 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 05/13] bpf: remove redundant s{32,64} ->
 u{32,64} deduction logic
Message-ID: <eqnlqlpqr4flzfnz5azqqpyy63imahn4z5gr3phx4k5huq4ndy@7kmfhlndgvh5>
References: <20231103000822.2509815-1-andrii@kernel.org>
 <20231103000822.2509815-6-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103000822.2509815-6-andrii@kernel.org>
X-ClientProxiedBy: PS1PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:300:75::16) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|AS1PR04MB9381:EE_
X-MS-Office365-Filtering-Correlation-Id: e39df9bd-9e2f-4e09-45c7-08dbe0fff034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	toGCi6P8VHZE08lLgxcQkvNaQ+8cai+yV6l1TZ6GJGuiDZYbw+trTe4hgbwF8qzybrhwo4/NhdJC+kjif9KhlR/GwbvAePKbJi4po/caPm4jzR9Pdo5vK6y/na3R4UcMuDYLNrk+stJkeh/OrBsUdRkOPJ9K2YloP8gxhY+QnX2c37s7vZ7dXHi1frxRLWk27aJ46/HiIlBunqdDlYkOoNxFSsH9P/5Bx5qfbAkoDkW6FfxsnIr3TR9hsKayvjzVjt5wdusNsW96oCQlyIcmMLSZ/VRqn7Gw7GK61RE4jJXA5g2G9z6ClZXR152Cm557uH5QTFptdO+JaSD3NWCcI6Het+RSuq7v3So6/iaeySVVIX+SMU3drP/RvN6BkMKt8dhirdW58rGF/Aj1vyxMSF27XyyUbDFu2noDvtLtw0f8seR01gjcK5qyV8Q5vZHEqcQsTZXyPZftiC6/CSZNko4QJJeQhVk1PsucWP1PrASulyVCTiLQ8/JzapNhh1SaiN/bLZB1vhOXwqCBtZJfvPi1w1ZaL9cuQ8wXTLFkK4hQBBkC/x9zruDZYOx2JPvB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(346002)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(86362001)(33716001)(6512007)(6486002)(6506007)(9686003)(5660300002)(6666004)(66946007)(66476007)(6916009)(2906002)(66556008)(478600001)(316002)(41300700001)(38100700002)(8676002)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zxoHAwHJt/a8MxFniY51xb29LCVUHkYhXFAWKR4WKZJEM0T7dbw1eSO9ux2I?=
 =?us-ascii?Q?LDwrQdOhuMfPtZ4QN5gg2jTR4V3AzzHwXvNjl6wbnPRBWJD/yUqzBt5Wsbzb?=
 =?us-ascii?Q?0Bt6lMKggZINTreP5vBEBgrg93ZYSwxsQK/MeXjKKrmKOKFXC6MB7sIKSx0x?=
 =?us-ascii?Q?IsCPAuuZYYdG5JX3jqrJQ6J8LCheXj1fND461Bh6AK4hkXWGr9Q0k2ZC1uR5?=
 =?us-ascii?Q?VTTO1TNYVeLu87/tQ26fVQmkdXW0gxZh68wmlqYuoOIG5SjW2UMut369gzPj?=
 =?us-ascii?Q?DMrL92gSh0LzXYzS1uCt/OVeIzbS0qV52qfqu9GWb4m2cMRZgGZpU8tiwDJz?=
 =?us-ascii?Q?r9K9oVNC2XoSKIPuNlH6BU1eZ4RUdup2bxv5Xfx23deJlJWhf7yHyr2FYWo4?=
 =?us-ascii?Q?PHJduCy3NRZ+HfBCkbJgh4Hbuzn3LuV5pT6MUkt3RaprtV9ZRV1hZrLGlouy?=
 =?us-ascii?Q?iCjU5WAO4nbuB+2T1si/yNcRjs/rprOh2v6BLh41yCbPqRxK5WtqhyzYLxs/?=
 =?us-ascii?Q?oi3uYg69dYTZTB1qp6/aVY8BEeNoi2VRgWrpjdeXCrFNokzUExU9OJBd6Dff?=
 =?us-ascii?Q?Oc6JpRvqYKyTPzlIyBMwAXV0g6GL36DVl5H+1dFkzpwZfHLU4e1JsqIJZwMV?=
 =?us-ascii?Q?ki40nJoCbQgPtuKfa+rfztbPjmGe1FVMopAsSIMZ+u8xSVaayMW6KsS/BSXq?=
 =?us-ascii?Q?F2Y55OAMJakIoZKorxClwU03DG0BcNvJs8jXVdqcKyHqNfgtNZNXiuR8bLXw?=
 =?us-ascii?Q?3p65HtPKy6pwTIyW0SCDaaOaOPoGx3e4UT1xwlIxqpvNuY9mbVbqMjxSiAxT?=
 =?us-ascii?Q?2T2aCSHUIrm2tbB+k9zWr7GRbRn/XhQtGhSequEXoZwO5pdheyJpIKbS0U69?=
 =?us-ascii?Q?cPXdQpFVn7ul9sb4lznkiYoolIxBOIs+Vd0Do2kDnQHFWhhnVatchfmSCWYs?=
 =?us-ascii?Q?WEJ8AqfjzYfuY6O03sWeAigXu1zlwTl+fxG2jHGuLpZFPueMBEfySdNCbP3D?=
 =?us-ascii?Q?EseBJucQj3BPcH8svgxoC2jI6dPmGzDRbP1HjEWLdER3Y05IbcMwFOUEIw27?=
 =?us-ascii?Q?piXDNfM6yXKFpWs7pQpedwTyfZCywaFhpz7CXVvqf+HGAP4Af7/wbpYM3bMG?=
 =?us-ascii?Q?jeMI8W+6sxizeyATURGC+4ake26pqx3wMktJFFhGr7CoomJ4PKsX1Y+n1deP?=
 =?us-ascii?Q?ey8jrMHm1r/uZlJ8GxGJAQD+I94wDQcdzCcthAmCG7JQf50su/TSN8xqNefT?=
 =?us-ascii?Q?uNJpWZ6YKuuFfWbIgyI1smUJcOTkgCZ2S0HtoeBt6w/hhxUr83o7rUysT8sy?=
 =?us-ascii?Q?oB4dzGnUkINuCdT1ikGzN9CT4B8ZL4/OrCfrS7/pFvNR9n4WQ84HiQpQhn+C?=
 =?us-ascii?Q?BoufokaST6eXCXBk7/xRhUdiTZ8S31tVSg/P1ErNXQmjeYDdW9jcnJaQhiHN?=
 =?us-ascii?Q?vAjVLu8YmEbQZuh4lqD2AsuSXmOutEbDdJ4UrCUDC0xlW5IZBVUYJ0NJ6sVk?=
 =?us-ascii?Q?pwx8CNG3TRPdNw79jh4eSns2bjBgbVyQjUq2coYm1pxsIyIiVBWJkCWK6dBA?=
 =?us-ascii?Q?3DbqYyrLhCJjtdr0+74Vbk++kvErjYvbWC9v4rRBwerOd3ueAIl+GnxBQboJ?=
 =?us-ascii?Q?HF3Z5tByw1MhwVHdaMrL6+/+WY6Loph+u8wwN8T1xYo5?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39df9bd-9e2f-4e09-45c7-08dbe0fff034
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 08:43:25.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ei0Ozxonp2R5FK2LYNYdohNv3jfC5VM4JF0mfh4fRYPrV8SQywzS2/pqluy3oGJ/IZQ9rgHORA+PneqsYMiXhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9381

On Thu, Nov 02, 2023 at 05:08:14PM -0700, Andrii Nakryiko wrote:
> Equivalent checks were recently added in more succinct and, arguably,
> safer form in:
>   - f188765f23a5 ("bpf: derive smin32/smax32 from umin32/umax32 bounds");
>   - 2e74aef782d3 ("bpf: derive smin/smax from umin/max bounds").
> 
> The checks we are removing in this patch set do similar checks to detect
> if entire u32/u64 range has signed bit set or not set, but does it with
> two separate checks.
> 
> Further, we forcefully overwrite either smin or smax (and 32-bit equvalents)
> without applying normal min/max intersection logic. It's not clear why
> that would be correct in all cases and seems to work by accident. This
> logic is also "gated" by previous signed -> unsigned derivation, which
> returns early.
> 
> All this is quite confusing and seems error-prone, while we already have
> at least equivalent checks happening earlier. So remove this duplicate
> and error-prone logic to simplify things a bit.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

