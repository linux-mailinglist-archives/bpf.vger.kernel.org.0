Return-Path: <bpf+bounces-13391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1117D8E41
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 07:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FE2822A0
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 05:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4EA6FA9;
	Fri, 27 Oct 2023 05:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LYLmih63"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3546135
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 05:44:02 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB951AC
	for <bpf@vger.kernel.org>; Thu, 26 Oct 2023 22:43:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/So9yqKJ9kr08V0kMA8djxgHXvZCQrD3WdKYwEQvxu75/6JtoeACm6CQ1F35TStVJ50fDlceemPtrNkUgpa6ROKqf6ZS+pYdfGq02fZ6tXqUv0mHatHluCeGROhIuAjCR1ng2k+SV9GYLBHUDFXHdquiMvPfA9bn1hyOd9zAhftQrzgwIWxH97OY1jsszHTUNaAPYJLO5Yd3k1XPC8/WgVr7NXWKzFYsLJhWT9zhoq1dhlmlTIf7+njH+m3IgOaF2BSXdeETmZVikiNLWe5Ig37J8CW9OAQxBj5UrXK/H2u0ODmotPydbBTgMACa2GlcJdkdxUotW/+iYEqjAQvTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tW65BKiT0cPxcroRprBm3y8TXIuJupwOIMKHIz1pzjg=;
 b=RNi7ozWCcniwGUKf7uFc0dJKlUIb6f0b8sfxWiBePYXym++kJ5Joooj82PNd+M46ema6aGPo3YT3+9PxWAqV/Bth9jvqKspQqeNgUi6IWhrUY6RERW7fY5MeND+8HnBRp2eulWFHVTofIWUBLh8ZFUUOyvRj00F/KObS4AMOxPnqqMOQl53MwQyGslyrwp5PNt58ju4mkXek+Iyw9rSfFdP/CpKeYOoXQL7jaM2hiDRS2p+EUx6TJ0B/jQUmDEvTtCU7lS8XZyzDMEeX+EPxb+lyVdIauLxUgy7E5YsmsU8okXtdAAQ1sMhEmd7KDNoL2tTkJinMA4mWI7yQXU654A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tW65BKiT0cPxcroRprBm3y8TXIuJupwOIMKHIz1pzjg=;
 b=LYLmih635CP4euzW0zR4iACazoRtA2GDZxu8QJ/cBxTUTMEZBdancgIZwwlTtGqfbsOycACAUJicn/iH/bcGcwsKRW5ZyG90sPn9vnFqUttTXXW26PRZMH5GEMAEqRPpFemgLJH0Ry7KPZPw6I4+oUsjYr9Uyd0qEZs++caDTbj63oF+bLDYfxPenYEFWVuic8XekqDOtyv+eqrkbHtB634g7V7TVodASNsD9fzPNCej6StPIcfn3X4WPqqurxT0WyfjdXvVr+UPZfR2uGepuMVc+I4X+oY0gjVCrb1zR55cKRIgbT/j3+XXvXRTriFkcia7dfrVvHjz/lYHpyYdgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.14; Fri, 27 Oct
 2023 05:43:55 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::9f3e:3b47:5ccd:c47c%6]) with mapi id 15.20.6954.008; Fri, 27 Oct 2023
 05:43:55 +0000
Date: Fri, 27 Oct 2023 13:43:44 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Dave Thaler <dthaler@microsoft.com>,
	Paul Chaignon <paul@isovalent.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: Re: Unifying signed and unsigned min/max tracking
Message-ID: <ZTtOEFqpFIiYoqht@u94a>
References: <ZTZxoDJJbX9mrQ9w@u94a>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZTZxoDJJbX9mrQ9w@u94a>
X-ClientProxiedBy: TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::19) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: c389dd8d-a327-477f-4c17-08dbd6afb51a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IioQU7roK9rkMwyiLQlRmxCQtySZ3RFAzT8B4NZxFI6o5KyNXHPjz0wVFbt8zS8bEEs4UVRDTlKVxMaxMNH2VPaCe6CQWblkgWhTmLrCN9VS/AT8SYW77s36KohakRiFMTrqORG8xGRxO4ktQvONM0uHDaFwcb41FigJCmRifLSXe43emCp8HjD4VP5gMIH+BP3dtUedjsWM8YNwHYOiROrpt7J0xF7cIU+J1m2NEUyuZciOuLBfQdEMLzAjJVu80OencYtHWVYhLiT0kqpohLN2s4pPnexKJLnH0VMzwjyc/sycYscoWSxqhtMw2hocK6lfAASykclpCOP831lk02OBhjX0XqyfRvATeGFh7D2R3kjzZicFSCIUNHxftsY4P0y4O8J7tVhLPBQeAxfLC09WUdpfogzRN7+Lu/gLpKSEjHQvy0OEy+NGLFYPo5NJjaRAiLIWetdSAl13elH3P+zsXAjCU7IQoyohsWFfd2tw+qQ9xEShASCwZomTLWE3iF3zbhlgvbFLZZGmWgnbCUvRv/HCezU9rtNBuKdJZVkI1BPT7+EbfIg1YUNxytZmPfgwXzgwH4iPA/5ibEEsAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(6666004)(6512007)(6506007)(9686003)(316002)(26005)(66556008)(54906003)(66476007)(478600001)(6486002)(966005)(6916009)(38100700002)(66946007)(107886003)(83380400001)(86362001)(41300700001)(4326008)(8676002)(8936002)(30864003)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzdVTGRwaUp1bEc4NTRXTmJtMzd6YU0vY1J3aE1IR3I0TDFydnM5S1M3LzBt?=
 =?utf-8?B?MEQ4YmFwNFhBbklWWUgyTnp1UjZVMU5TUHFKUlFuRHozOUhwOGtQak1rdm5i?=
 =?utf-8?B?TXlnZ3BVYVN0QkpWWjRMZkhrZS8rTFYvSHBVQWs0cW1ZOCsxNG9Hc0hxYTNH?=
 =?utf-8?B?clRWcHVUNlJUMGZma0RnMTNMazg3NzFYMFNSZTI3Sk1LVXdqR3VsSUxuUURn?=
 =?utf-8?B?eEU5dy9Dak5wTzdvdkprL096amhaUTN4YVVCQkkyWlFmdUxSYUw0dFZPVlMw?=
 =?utf-8?B?WTR6TWJoODRlRjNpMnZGdkJaMTlwUks1VytZMWUrRHNyWjVpckZQVUIwbk9j?=
 =?utf-8?B?NDVCeG1ldU1mYkxzaSszRjhUOFk0ZW9GanltcnJmQ3puVVZhVHd3VTlCTVoy?=
 =?utf-8?B?MktvZVNhZm1PdE9oLzhDLzJhT2p6K1FLWkRHaFN1M2hWUUo4cU5rdHNpRU92?=
 =?utf-8?B?MDdaRW1TTCtyc05JTzVOcDFlN0NSaWc3emNrQ01nY0tuaG53YWtWaStMQmNL?=
 =?utf-8?B?SkZXVEJmL0l0ei84UGd4cE92TnZjNGl4RGVmMkpZb1BrSzllVVJ1b0F1TVlT?=
 =?utf-8?B?L1dhOWlMT3RCWkNST3RIRXo3SVcvS3pBTHl0aUJxM2VjYzNwSXRiZ0VHTlRT?=
 =?utf-8?B?dzAzc050cGFUdVJ4TnFPRTNRazdpRU5KVUlnbE1OL3kyYUw0eXp6d2JmdWRK?=
 =?utf-8?B?WW42RmFLOFkweHphdlRXTmhzYXdzdU9TZEhNNEVOaGsvZnNUbjBPMjdzY2FR?=
 =?utf-8?B?clZ6Uk4xcUZCZmhueHc3OCthZ2lEN3VtajNVMVVBMHovY3FlS2ZQYVM1ckJV?=
 =?utf-8?B?Mk1Hc1EzelJKd0NacWRESUZtRHBlNGZtWWtxVVhtYlFKTk0rMFpIb3VEVDkr?=
 =?utf-8?B?L2x4QWE3K2pJZFZhcUxzQktSZTYvdWhMM3lSdlBjSHRRWk5mL1R3RmMwb1NZ?=
 =?utf-8?B?VnhRQms4Ylc3QzFDemFpRnk1dUNqOUNHSzhMbUVXSDBTV2hYZGprakY1S29M?=
 =?utf-8?B?WFdSTXZwVnhTSWR3akhncmJhSUNoV0dUbzk2bC9RRmlYZEtrS2FzdDEzZmZv?=
 =?utf-8?B?eG1xMmc1K3MyN0Z3dDhJdEhlRWw4SXhwZnVlU3JUaGZyNkovUDR0RkhBV2xw?=
 =?utf-8?B?MG9Zc2dCVkR5bWZkNXVrZ3NBa002WnBwKzh0UUhBc2NpN3M4SlhScGpuZ2lB?=
 =?utf-8?B?SVJZN05PTmNVUDB4R2tSZjlWb0RhNXRpdldpNkNzTnpQbHJOeFdVVXhSNEd5?=
 =?utf-8?B?RWlWaGRmeWJ5cjZyN1JUcmtrZ0NQZUZMbUFMY0hTWDk1OEtaakJZUHVseHpH?=
 =?utf-8?B?VmVvb08zUWtZNER3Q0Zsdm9ZdmJkWm53OTExN09qeThiMGQwQ0xNYTdoR2NL?=
 =?utf-8?B?OU1TN3VKMkRRaVhaeXJINy9vajBvbFFRMkpQTjZ0ZjhGSVU4S0YzR1BrQkdO?=
 =?utf-8?B?Mjlya2tqU21JOUE3L3luK1VOczA1TENpNENXVGUyTFFndlAvWWpQbktyNmJr?=
 =?utf-8?B?Z2VwSU1oMHdzbmc5Y2lDYkcrQ0NmRlNHRmNvMVVEU1pNaVcvaWNsL0c0QndB?=
 =?utf-8?B?OVpENGRwV2pJZFFQK0t2ZjdnblpiWm05NDh0a1o2ajYvN3FTRGwxRGd6K1lY?=
 =?utf-8?B?RkNFRmthMVU3em93NUhtM0RUYWZ5M3JjTStBcERSR3UzZDZQdC82ZWxIUko0?=
 =?utf-8?B?SmJEMi9KSjhhd3JpUG8xNW8rV201eXRwSmdJR3plREE2SDFNbkJuemh0REZt?=
 =?utf-8?B?ajFNZmVHUWR2eHJ3QTFkazBSZFBRdWR0MXdVaGJ6VzlSTXFqM1RNaUQ1aU9L?=
 =?utf-8?B?dW1GSXhkMTB2b20yS01TMkM1T0JWSURBbzM4bFIvMHZVa0NVVnZScHg4ckQ1?=
 =?utf-8?B?cGdyM3AvdFVhN1VTSzhvZWxRenl2ZFdWWUMwUlpQVWFmM21qNkh1QXh6S2FV?=
 =?utf-8?B?ck9kTEpBcklmbWdHNWgxQjJVVFNlTnJ4VnZrcmErRHhaYzEvbEw2aE96c3JY?=
 =?utf-8?B?USsvdURIcE1DWlE1NlV0SW16NEhLcGRrN1dOMnJGMjFid3lmclMxazRHZlBn?=
 =?utf-8?B?VlFlbDZzKzd2L2MvaXA3bXpQcXE0Z0s0VHNhYjJnaDRFdEc0eVFURGpQZGlO?=
 =?utf-8?Q?HZ3p8wqqqtsYmjM+v9crnz/VN?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c389dd8d-a327-477f-4c17-08dbd6afb51a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 05:43:55.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gem/pHowQUv+m+Wa4scnNAd3H8BHlPPTfap7bZ3+Q8ihxLrYnYGBBNamjPxZRN8OII//s6IOwYew+uTlqGwhMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254

On Mon, Oct 23, 2023 at 09:14:08PM +0800, Shung-Hsi Yu wrote:
> Hi,
> 
> CC those who had worked on bound tracking before for feedbacks, as well as
> Dave who works on PREVAIL (verifier used on Windows) and Paul who've written
> about PREVAIL[1], for whether there's existing knowledge on this topic.
> 
> Here goes a long one...
> 
> ---
> 
> While looking at Andrii's patches that improves bounds logic (specifically
> patches [2][3]). I realize we may be able to unify umin/umax/smin/smax into
> just two u64. Not sure if this has already been discussed off-list or is
> being worked upon, but I can't find anything regarding this by searching
> within the BPF mailing list.
> 
> For simplicity sake I'll focus on unsigned bounds for now. What we have
> right in the Linux Kernel now is essentially
> 
>     struct bounds {
>     	u64 umin;
>     	u64 umax;
>     }
> 
> We can visualize the above as a number line, using asterisk to denote the
> values between umin and umax.
> 
>                  u64
>     |----------********************--|
> 
> Say if we have umin = A, and umax = B (where B > 2^63). Representing the
> magnitude of umin and umax visually would look like this
> 
>     <----------> A
>     |----------********************--|
>     <-----------------------------> B (larger than 2^63)
> 
> Now if we go through a BPF_ADD operation and adds 2^(64 - 1) = 2^63,
> currently the verifier will detect that this addition overflows, and thus
> reset umin and umax to 0 and U64_MAX, respectively; blowing away existing
> knowledge.
>  
>     |********************************|
> 
> Had we used u65 (1-bit more than u64) and tracks the bound with u65_min and
> u65_max, the verifier would have captured the bound just fine. (This idea
> comes from the special case mentioned in Andrii's patch[3])
> 
>                                     u65
>     <---------------> 2^63
>                     <----------> A
>     <--------------------------> u65_min = A + 2^63
>     |--------------------------********************------------------|
>     <---------------------------------------------> u65_max = B + 2^63
> 
> Continue on this thought further, let's attempting to map this back to u64
> number lines (using two of them to fit everything in u65 range), it would
> look like
> 
>                                     u65
>     |--------------------------********************------------------|
>                                vvvvvvvvvvvvvvvvvvvv
>     |--------------------------******|*************------------------|
>                    u64                              u64
> 
> And would seems that we'd need two sets of u64 bounds to preserve our
> knowledge.
> 
>     |--------------------------******| u64 bound #1
>     |**************------------------| u64 bound #2
> 
> Or just _one_ set of u64 bound if we somehow are able to track the union of
> bound #1 and bound #2 at the same time
> 
>     |--------------------------******| u64 bound #1
>   U |**************------------------| u64 bound #2
>      vvvvvvvvvvvvvv            vvvvvv  union on the above bounds
>     |**************------------******|
> 
> However, this bound crosses the point between U64_MAX and 0, which is not
> semantically possible to represent with the umin/umax approach. It just
> makes no sense.
> 
>     |**************------------******| union of bound #1 and bound #2
> 
> The way around this is that we can slightly change how we track the bounds,
> and instead use
> 
>     struct bounds {
>     	u64 base; /* base = umin */
>         /* Maybe there's a better name other than "size" */
>     	u64 size; /* size = umax - umin */
>     }
> 
> Using this base + size approach, previous old bound would have looked like
> 
>     <----------> base = A
>     |----------********************--|
>                <------------------> size = B - A
> 
> Looking at the bounds this way means we can now capture the union of bound
> #1 and bound #2 above. Here it is again for reference
> 
>     |**************------------******| union of bound #1 and bound #2
> 
> Because registers are u64-sized, they wraps, and if we extend the u64 number
> line, it would look like this due to wrapping
> 
>                    u64                         same u64 wrapped
>     |**************------------******|*************------------******|
> 
> Which can be capture with the base + size semantic
> 
>     <--------------------------> base = (u64) A + 2^63
>     |**************------------******|*************------------******|
>                                <------------------> size = B - A,
>                                                     doesn't change after add
> 
> Or looking it with just a single u64 number line again
> 
>     <--------------------------> base = (u64) A + 2^63
>     |**************------------******|
>     <-------------> base + size = (u64) (B + 2^32)
> 
> This would mean that umin and umax is no longer readily available, we now
> have to detect whether base + size wraps to determin whether umin = 0 or
> base (and similar for umax). But the verifier already have the code to do
> that in the existing scalar_min_max_add(), so it can be done by reusing
> existing code.
> 
> ---
> 
> Side tracking slightly, a benefit of this base + size approach is that
> scalar_min_max_add() can be made even simpler:
> 
>     scalar_min_max_add(struct bpf_reg_state *dst_reg,
> 			       struct bpf_reg_state *src_reg)
>     {
>     	/* This looks too simplistic to have worked */
>     	dst_reg.base = dst_reg.base + src_reg.base;
>     	dst_reg.size = dst_reg.size + src_reg.size;
>     }
>     
> Say we now have another unsigned bound where umin = C and umax = D
> 
>     <--------------------> C
>     |--------------------*********---|
>     <----------------------------> D
> 
> If we want to track the bounds after adding two registers on with umin = A &
> umax = B, the other with umin = C and umin = D
> 
>     <----------> A
>     |----------********************--|
>     <-----------------------------> B
>                      +
>     <--------------------> C
>     |--------------------*********---|
>     <----------------------------> D
> 
> The results falls into the following u65 range
> 
>     |--------------------*********---|-------------------------------|
>   + |----------********************--|-------------------------------|
> 
>     |------------------------------**|**************************-----|
> 
> This result can be tracked with base + size approach just fine. Where the
> base and size are as follow
> 
>     <------------------------------> base = A + C
>     |------------------------------**|**************************-----|
>                                    <--------------------------->
>                                       size = (B - A) + (D - C)
> 
> ---
> 
> Now back to the topic of unification of signed and unsigned range. Using the
> union of bound #1 and bound #2 again as an example (size = B - A, and
> base = (u64) A + 2^63)
> 
>     |**************------------******| union of bound #1 and bound #2
> 
> And look at it's wrapped number line form again
> 
>                    u64                         same u64 wrapped
>     <--------------------------> base
>     |**************------------******|*************------------******|
>                                <------------------> size
> 
> Now add in the s64 range and align both u64 range and s64 at 0, we can see
> what previously was a bound that umin/umax cannot track is simply a valid
> smin/smax bound (idea drawn from patch [2]).
> 
>                                      0
>     |**************------------******|*************------------******|
>                     |----------********************--|
>                                     s64
> 
> The question now is be what is the "signed" base so we proceed to calculate
> the smin/smax. Note that base starts at 0, so for s64 the line that
> represents base doesn't start from the left-most location.
> (OTOH size stays the same, so we know it already)
> 
>                                     s64
>                                      0
>                                <-----> signed base = ?
>                     |----------********************--|
>                                <------------------> size is the same 
> 
> If we put u64 range back into the picture again, we can see that the "signed
> base" was, in fact, just base casted into s64, so there's really no need for
> a "signed" base at all
> 
>     <--------------------------> base
>     |**************------------******|
>                                      0
>                                <-----> signed base = (s64) base
>                     |----------********************--|
> 
> Which shows base + size approach capture signed and unsigned bounds at the
> same time. Or at least its the best attempt I can make to show it.
> 
> One way to look at this is that base + size is just a generalization of
> umin/umax, taking advantage of the fact that the similar underlying hardware
> is used both for the execution of BPF program and bound tracking.
> 
> I wonder whether this is already being done elsewhere, e.g. by PREVAIL or
> some of static code analyzer, and I can just borrow the code from there
> (where license permits).

As per [1], PREVAIL uses the zone domain[2][3] to track values along with
relationships between values, where as the Linux Kernel tracks values with
min/max (i.e. interval domain) and tnum. In short, PREVAIL does not use this
trick, but I guess it probably don't need to since it's already using
something that considered to be more advanced.

Also, found some research papers on this topic referring to it as Wrapped
Intervals[4] or Modular Interval Domain[5]. The former has an MIT-licensed
C++ implementation[6] available as reference.

1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-windows-ebpf-verifier.html
2: https://en.wikipedia.org/wiki/Difference_bound_matrix#Zone
3: https://github.com/vbpf/ebpf-verifier/blob/6d5ad53/src/crab/split_dbm.hpp
4: https://dl.acm.org/doi/abs/10.1145/2651360
5: https://hal.science/hal-00748094/document
6: https://github.com/caballa/wrapped-intervals/blob/master/lib/RangeAnalysis/WrappedRange.cpp

> The glaring questions left to address are:
> 1. Lots of talk with no code at all:
>      Will try to work on this early November and send some result as RFC. In
>      the meantime if someone is willing to give it a try I'll do my best to
>      help.
> 
> 2. Whether the same trick applied to scalar_min_max_add() can be applied to
>    other arithmetic operations such as BPF_MUL or BPF_DIV:
>      Maybe not, but we should be able to keep on using most of the existing
>      bound inferring logic we have scalar_min_max_{mul,div}() since base +
>      size can be viewed as a generalization of umin/umax/smin/smax.
> 
> 3. (Assuming this base + size approach works) how to integrate it into our
>    existing codebase:
>      I think we may need to refactor out code that touches
>      umin/umax/smin/smax and provide set-operation API where possible. (i.e.
>      like tnum's APIs)
> 
> 4. Whether the verifier loss to ability to track certain range that comes
>    out of mixed u64 and s64 BPF operations, and this loss cause some BPF
>    program that passes the verfier to now be rejected.
> 
> 5. Probably more that I haven't think of, feel free to add or comments :)
> 
> 
> Shung-Hsi
> 
> 1: https://pchaigno.github.io/ebpf/2023/09/06/prevail-understanding-the-windows-ebpf-verifier.html
> 2: https://lore.kernel.org/bpf/20231022205743.72352-2-andrii@kernel.org/
> 3: https://lore.kernel.org/bpf/20231022205743.72352-4-andrii@kernel.org/

