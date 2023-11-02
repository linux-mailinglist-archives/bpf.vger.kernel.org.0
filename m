Return-Path: <bpf+bounces-13958-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E1E7DF618
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 16:14:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAEF71C20F4A
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 15:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728E21C297;
	Thu,  2 Nov 2023 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="skH5lB1F"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DA1C280
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:14:38 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2074.outbound.protection.outlook.com [40.107.13.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13772193
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 08:14:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpvSPjqgPdNroDn2ln3numjsOQyKCG+FPzmLHHI88xFVOyKLGKfepRsJe5VJsGwLTl8AjcIFipG4ruwu54myKt+TrET1BM7CtDweSTopkYIJiwlJeljKNYwrp6EE3wnaRZMJM3D68grcEn9Oq3jzTqvQuhia/iWg+qg5nC3kv92BmKI37z/MJGlAYaV/nZ0nT8/sDpCKE8ORoxtuEu6zH1ce3aKalU+Eks4m8MbG9ciNgfrv8qR6KzW6MvNeIlipzA5Jjcks3lVP2jIC8cLSM+RGGmJbjXG1sDRJ4KPp8eq2MC/TQZVwdcWV23PbHG7Pd6EyhFYsKpAwW8zU1hLpnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5OJb7q4/nldeftd4oT0u+xA9+lzoTgUMyBlZQbS7t4Q=;
 b=L4xy7cTpQ/U+1300tnt6Xr7ad8RXE73bDPw6BGku1YHURoveL9abBPRcIETtrEs6qUruJynEHhHZ8pySN/W4zKZ6PcXwABD1uZrDCIciVFUhPdDvUcRTYATAMSkRYhpzM8Y8Br+bqB4Mtj2fw+jl2MANDiciaMlxGy4PqK0qZmmnQ6XyJE+PYiXc+2caQ254rhysp265GP7Z1VkgsQYV9rvAmrDnoazliBM49xU94x9/yBna6opeRSzYWvpbeHbzq5DTDslvvCr7Gpkgzfe53kRq0dLi+40jjXM25khdqR3pDinmSNZmivu9E0keIRrw2tTMTTKzFJCs2i4HKVD32g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5OJb7q4/nldeftd4oT0u+xA9+lzoTgUMyBlZQbS7t4Q=;
 b=skH5lB1FhvkU9hldoKCwyRGKs8sD56Ann/J8ESf7kIaDmMrOxfnc2TE9fa+wrkH2JKaf2z788gKevEAU5XBO5q+2hXZAwIYMufrhB41k+JuaYj4/WpBj5jpMDDVgC8JJMY5gFl0xpVCZqKMyrNNFWlHje3/yF7zdYD2OfA5g6O3cQstMYhTTxswpHl96H4Gu4TUw3burv0hBHBfkY150wPKqQmw9NUf8D+grKv7/wGKRd2KeyKwevb/r7MadvNYxQJJtyIoudWhHMvRrzh5ow6eRbTz9Fzk1Xuzux3C5XW2nwvPoYC9x4tTmyQ1RmDdsOLFM094b0iXgr6/7PBTM5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.17; Thu, 2 Nov
 2023 15:14:28 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.019; Thu, 2 Nov 2023
 15:14:28 +0000
Date: Thu, 2 Nov 2023 23:14:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v6 bpf-next 09/17] bpf: drop knowledge-losing
 __reg_combine_{32,64}_into_{64,32} logic
Message-ID: <ZUO8xwx8o_PO8pkD@u94a>
References: <20231102033759.2541186-1-andrii@kernel.org>
 <20231102033759.2541186-10-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231102033759.2541186-10-andrii@kernel.org>
X-ClientProxiedBy: TYCP286CA0041.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::16) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU0PR04MB9496:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a29ad36-747a-4462-cedc-08dbdbb66820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1sjy2Tt6UXYcPLiyY4mii/okjTQvAxWKcfJZlNXo0jh/t1T+v3N8OPvk6Q7rmJCBiDhPd/Mxm0NlCU+opjEfxRwKG+7eODC/xjR64e8DN2RY0D5v9tOmFd/NpLjBRRrPxlogKr066Zj7ABRjRoQ3KqwRrmQBk5XH3O+a8ENbW7cNV1y//YsCVoTFhojz4frx7RNtuKStwq0igboGUCUjsj786tq/8mqAsclPm2vp7crI1txmQrOq3xXRNs3/CyZV2CcaW7DT1yAu6W6SFHXOYuKTYPKcVzMAZdkuTdVVYkqe86rnaEl2NNA8IuMDM1KrXedF9A9R9h7rE533ynvAXojsHycPJ++XEdYmkn2TAbxixxzUObEas8mGMkjSz51smp9U1WNxKbsKtlROBC+6hW36Gs4ibxakzp+GitPhJCtxOCazmMKZgqWP6NMCK2C8+cGxEpRbG+BhNMIRR71VEMY0TV6t+cInbw8yImid8ljnCXxH05Ut3yJ65lzexK9rPMqEfvjjMv5p2QdBDb2e5xF9R0bpj71tP6XUel3/TPMFg0Gb9San8bxRvayY+OwD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(39860400002)(346002)(366004)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38100700002)(5660300002)(316002)(66946007)(66556008)(6916009)(6512007)(9686003)(33716001)(66476007)(8936002)(8676002)(41300700001)(4326008)(6486002)(2906002)(478600001)(86362001)(6506007)(6666004)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVlUZDJHL3VqdWp6RndSYUNzZXIvN1VvTXhDRnZVaWtjOUZDbXd2cWg2K3BG?=
 =?utf-8?B?NE04NjlLVTZiNHV1NGRFbzRIRWZpdG1HUXZkMnBISFZnWXFmdlBQMnk3UDRP?=
 =?utf-8?B?WEg1Q1UwM3QwRS84TWpIeHRuUjErQ3ZsUXkxdTdoZ1hlNk5nakEwbHQ2SFNk?=
 =?utf-8?B?M2hKMWtmZ3VqQlNnY2VVOHBnRVpaZ21NVjliNkpGQkE2L0VCdk90YkVOMU9V?=
 =?utf-8?B?ZFk4YkJKT09qMHJXbVNxNGQ4UmlHeFBRWE1pL3JhK2ZxUTIvdnpEZE1VM2o4?=
 =?utf-8?B?d2NKdXhiL3RDdGR5RWdjd0tuV2pwQmxkL1RZcUVaNk0yWURhV3JMdmZnNUh0?=
 =?utf-8?B?cStjYWRvSVFybjVKem02cStBQ0Rza3FBMkZjdW9QMWs3dzd6V05VOEJRcDJz?=
 =?utf-8?B?KzlramJQdjlDS05IVDVqMG9KaFhlMEZaOGFBSFliS2c1Rzk2ZWtBWkk5bExI?=
 =?utf-8?B?WjdzTVV6TzROZmlJQW1wMnRuaWgwYTVoNHJEZGNzeGpKRGNaTmZFQm9nQmpS?=
 =?utf-8?B?NEdDcHo2WERJWG1TSFlJazRKLzNGNWxhUnVTVGpwSkhUYWovZkxEa3VhUlVP?=
 =?utf-8?B?RC9NT1RHSnoxZFMvaDVYUGpvN3BhRStjK1BTbGxHU1piSkJTdGRFa1pyY3lI?=
 =?utf-8?B?RWp1ZXBKVXZoNHBhZFhwaVdMZGZ2T2NUck9mMkJkckk4Um5FUG1QUW41OUZ5?=
 =?utf-8?B?ZXJmNzRFeEs0NmdZUVFHcUcrKzBxTXpJdEpITHBwUG1uc1VjUUl1TEZBUTA1?=
 =?utf-8?B?U01DWm1YSEJWaXd1Y1plVlA4V25wbStGM3djT1Ywd251YWVnbThCRVZpNThQ?=
 =?utf-8?B?SVA5dVg5aCtuTFlJcHk3WHkzL25adXVEbGRpMlVWcC9hQjFweGJ6cVF5V2w1?=
 =?utf-8?B?Z2FmN1ZBdkFXbG1tWWNtQis5RHdjU0F0SWtjNXM1VXd1UnBwbHYveFd1c294?=
 =?utf-8?B?dUZjK0c1YmNwUVhVbVBFNURkVzNQSHZzdVRvalBYOE9xemxMNFVhcEw2cElT?=
 =?utf-8?B?cWVYZFJxcWRTcFBGWXNocEhjem5SVmY4OHhONzlOOHdNbWNJeUJtSVFBbTJ3?=
 =?utf-8?B?Y3Vadk5BZ3hRR2x0NStseXhRNmZkaE56NDd1M0twMk5LZW9nNVZZQXRZcXdI?=
 =?utf-8?B?cE9GZENDcFU0WEJLbkMzQUZsMllqWU96TjEwc0c1UDAyNlUyZGgvSkhmQy9M?=
 =?utf-8?B?VEQrRk9DdW1Rbk9RMDJZU3JvRVcyVDlRQzcreUw5Z1hGb25XWkY1bVZXTTZ5?=
 =?utf-8?B?VGN2cDNrd3lhQlBaTmtEZ2loNGlPdDJNZkk0NzJYREdRK3llWWNPRmhmNTdm?=
 =?utf-8?B?YklZSFVHb3lyR1FxMjgxK2FwZzBoRlNHZmtZMVprNjB0V1BxSm5DWGpKKzhC?=
 =?utf-8?B?NlA1aXFEcGNQR1BQb3hIR2E3SDdVa29ZN2ZXQWxEZ3AyQW5rT0tBTUJxdFdS?=
 =?utf-8?B?WUlPb2c3eXNWKzlpNzdscWwyWldNSmZSSTQ4T1B6dUVRL3hIK3FsY3BMOWNs?=
 =?utf-8?B?bTRLWFNYcEllcG1iLzRyY0FjeHd1MHltWmp2Q2tubFBWa0oxNHpteEV4cVRl?=
 =?utf-8?B?NnEyRjIzSng0NUdBWFRiZkovK0tyZkVqdEJ6ZlRFTi9ja0pIdlphWXovd1Ez?=
 =?utf-8?B?MnhUZXVSaklpK04vK2VSNmx0aFJwemFBUVdJM2ZLNjVhd0hZVlVDeGd2ZnZM?=
 =?utf-8?B?enRzdnMzTi9zY0Vtclo4VlZBd0FZaXoxZTZUcDFDQ2FmNVZzVkVDTGVSOVFB?=
 =?utf-8?B?STFnT1VQNnFxeFUza1lEdnZZQjFzd09sSTAyaXlIbEZiazhHb1hPNmxySTlp?=
 =?utf-8?B?MUQvM3ZwbE4vayt5dm4xQWJyNkxBMkVQOVZScVNoYVF2SkdCRVczVjdqWWcr?=
 =?utf-8?B?MXZpQ1hMOXhhZnJjOVhpdDB6TTZuRDI1QWt0Yll4ejFVbmE0bjBTaXNlaDdZ?=
 =?utf-8?B?ckxGUHREdEZLTTJyS0dKa1ZVVG1vdjJQNk5qdzZWWTU3SWl5TTBYV3MwSHdP?=
 =?utf-8?B?aVVDWUJEMXlOVzhTdDJ4NUJKVlVsSVViRStuSGxRbVlNZzIvNEtJbThockVm?=
 =?utf-8?B?SGFoRkF6SHd2ZVpwRjVyNTZwaFFZTW5hNXlkTTJVMzFNRFc2Sjh4bXlFcDV4?=
 =?utf-8?Q?7rq4KkZeynH3BddPYIfMeIXoo?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a29ad36-747a-4462-cedc-08dbdbb66820
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2023 15:14:28.1573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zOun99JzqNXKJGv5gMU3FPVjSc2l53NcOUFMicM5jA5sKHYLlpxv7qZJqmHzJcuA+xOiUh1J9Zw4+9pyklTXTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9496

On Wed, Nov 01, 2023 at 08:37:51PM -0700, Andrii Nakryiko wrote:
> When performing 32-bit conditional operation operating on lower 32 bits
> of a full 64-bit register, register full value isn't changed. We just
> potentially gain new knowledge about that register's lower 32 bits.
> 
> Unfortunately, __reg_combine_{32,64}_into_{64,32} logic that
> reg_set_min_max() performs as a last step, can lose information in some
> cases due to __mark_reg64_unbounded() and __reg_assign_32_into_64().
> That's bad and completely unnecessary. Especially __reg_assign_32_into_64()
> looks completely out of place here, because we are not performing
> zero-extending subregister assignment during conditional jump.
> 
> So this patch replaced __reg_combine_* with just a normal
> reg_bounds_sync() which will do a proper job of deriving u64/s64 bounds
> from u32/s32, and vice versa (among all other combinations).
> 
> __reg_combine_64_into_32() is also used in one more place,
> coerce_reg_to_size(), while handling 1- and 2-byte register loads.
> Looking into this, it seems like besides marking subregister as
> unbounded before performing reg_bounds_sync(), we were also performing
> deduction of smin32/smax32 and umin32/umax32 bounds from respective
> smin/smax and umin/umax bounds. It's now redundant as reg_bounds_sync()
> performs all the same logic more generically (e.g., without unnecessary
> assumption that upper 32 bits of full register should be zero).
> 
> Long story short, we remove __reg_combine_64_into_32() completely, and
> coerce_reg_to_size() now only does resetting subreg to unbounded and then
> performing reg_bounds_sync() to recover as much information as possible
> from 64-bit umin/umax and smin/smax bounds, set explicitly in
> coerce_reg_to_size() earlier.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

LGTM. Seeing __mark_reg{64,32}_unbounded() removed had me spooked
quite a bit though :)

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

