Return-Path: <bpf+bounces-16230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544617FE8CC
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 06:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6DCCB2116D
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 05:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460FA19451;
	Thu, 30 Nov 2023 05:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="4fa18IDn"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B910E4
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 21:49:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYpKFWU+vTR0O3TX9A4cMKpoyUfss4NVHWi61iOBozvkDPwm7b9Y01PllVTw7iBibrcRy037p9niUuemcckyAPfs20WVqe0PXJDznsTuQse2B5w4h/V9iy+SNU/4sqOuI1Ke87193N3u2ZLnkthhAj8JM6BZVSMG3CRfWb/hjZVt1e+XEfj/aIQ0Fkb1JS2HR4cMOZ2uJXgG4wqrSUAsdlgDyZ87Yn3lKZOmErWkBOZunrB8n3Wdxs5in7sXOPCV6VCNRJr/s+e/t9QTdri54+htf4Qki0z3ewep/VV5FoaW6aDBq/OTNOs2ThkojvrCXY0O09Jwwhnn39XtBQytYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCN+hGE6AM5PhSU3UZeBhhZXZmzEz0rmoR4ou0k1b6w=;
 b=I4pVCiLaWXmjgAS0bSE3hfpSuKdLuNKcYsxMqjXBaPJkIraCxf13UZSa1HM1Xt3F+azt4w/VEcJHo/1CSGungly9BQzkpok+MXmqX28YACo8fD8ElNJRxaimH0lHVswNy/V2WIb5hToB/7MdfOXgrxVxMJl1srpCA1uJGYVJP42Lw2DgZ8TUSwt9RJMvMi7toV70a/gqfRRyJqpU7nqhG5i1olLUrVgTSQzCFFHQae8Fb1S6GKjT/44nKxobD8uQ5JOsfpALgcOY/P0jPP3ccXbq6xfCZvfc7G69clGoCv+zWTBAHrGaS4m0/G9ZeCumkPd3nFGfkxbNpK2oas63dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCN+hGE6AM5PhSU3UZeBhhZXZmzEz0rmoR4ou0k1b6w=;
 b=4fa18IDnhMV6HCqOgkOAHTh2L8TigJHuWTVq8jA72eJX7bPRu9f07CvGsUDYeSm1Xb8rEskn5wHVMKot0Jw7lC299BJv/aoPCGarfYWxTcwb8baiGqdSxX+hszV1WxiRYbRmW5f488Rv5XzLYMZCvBvMKnzVU7lOc3baCeut97SSsHmbrdD1xl1ChF57g0g/Ph2XovgEKLR8SeM2AtjqfTdJDXaA4t5/ibQrg9YavvVKz94WB4J9f48xnVRef7e0WJjrPgHLcjwtvlH38BZ2cwlbpiIn2tCB4Hdt11CETb6hqx08gmiG5cZySuTHIRTTPxMeilbhrECcoEou7XU8WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com (2603:10a6:20b:42b::14)
 by DB8PR04MB6985.eurprd04.prod.outlook.com (2603:10a6:10:11e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 05:49:49 +0000
Received: from AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3]) by AS8PR04MB8660.eurprd04.prod.outlook.com
 ([fe80::fda7:fd74:c07d:c8f3%7]) with mapi id 15.20.7068.012; Thu, 30 Nov 2023
 05:49:49 +0000
Date: Thu, 30 Nov 2023 13:49:40 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@kernel.org, kernel-team@meta.com, Eduard Zingerman <eddyz87@gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/10] bpf: enforce exact retval range on
 subprog/callback exit
Message-ID: <lqtcbzjufylnjretotjiultjwnsl6kstxjscnt375kt4tzm5su@kch2bhmsflk3>
References: <20231130000406.480870-1-andrii@kernel.org>
 <20231130000406.480870-4-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130000406.480870-4-andrii@kernel.org>
X-ClientProxiedBy: TY2PR02CA0061.apcprd02.prod.outlook.com
 (2603:1096:404:e2::25) To AS8PR04MB8660.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8660:EE_|DB8PR04MB6985:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acc1214-7ded-44a0-0eaa-08dbf1682a8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8m9s9hDr0Nq5zXA01r/3Tb1SS+Lip8Wojj/N7u4p3lLIoUQAMuREtyPpV3y8xClDA24v76vLclYHnE3vWNYk2GR4SY6LPLpS3tK9f6NRUEWLZ9DE1koOzhev97MMnySO4ICJOpNjHNYUjPK0X8w4G+HYUyxOQOJvFm6QeTaVBszeEcnK8QAxTJp3mclZjK61xB6ODcKYnfwCDLOSh5t3zfxbvZIA+bzns1N1X8laZpeg4b0kSH9rEk46InU0KIkoPJpJEMq4/W6hSBfw+SXZgF44PETuyajjdpcx9UJcat1cOpllvTMnqZt1YYlhIQjr/vcu+cTO39d5cXuOoaNd5/JbPyir+ubttS/SN1yctzYLNYA0VrjydRBrgypuJelg1pl7lR6LzGycY97hoiwZ07+LiZX2i4AQh35UMC2G13kircRRyCGsAddiX0zBs9v0UULdB1HtPZyn/vJ/J43vQiNj80S+j98rNG+yzagu7W8Gao4NBIygbpx2rZ62WDP6cgg2wayK/i+ZEEPKQNj6Wp9zsCnDh8mV9qQ2nTMOe232D5TgPxzx17qGJh3BbCaqtvRBsv3GXRNpWiP/Mdy+TBgj/IJsPhOERZNpQLYDZSbImP9OLFig+Va6oABW32kc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8660.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(202311291699003)(33716001)(41300700001)(2906002)(5660300002)(316002)(8936002)(8676002)(66946007)(6916009)(66476007)(4326008)(66556008)(86362001)(9686003)(6486002)(83380400001)(6512007)(966005)(38100700002)(6666004)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VrDDsZpJSx8aX3KtnTmMDPzzFV3z9WqcQ11IuRydSeiJPkaobrO0Lcw/ja1O?=
 =?us-ascii?Q?Z+xAtXmwpClooBlQCxQBVi7ICW/FK9pALM6ZOs+SzJLq78PcrL5kEjGeS570?=
 =?us-ascii?Q?W1HJ5/NWUFYYNbchP9pTJfbd7SC1efeADAePFjmXb+pO+10Eytcvlz6ON4wn?=
 =?us-ascii?Q?veU48QnBZW3Ty9JR/Pw/bG2htI0Gwuu9SHf4cDEjNqQd0g395e5mxA7qdA6/?=
 =?us-ascii?Q?tTiEtAcbztebV8uzCU0YYTGZq+lvRLIWqdPweXR5OWpAiuwK0HhiO9nb5t22?=
 =?us-ascii?Q?DDO2l7EVAuM85xwL5dH4vu4ATQ3okGHse7YsNM2wt0oCfCKpoGSkpjO62jor?=
 =?us-ascii?Q?XdbsBGXLfswh3mdv2aHfQhmFVe2YsAoKmfKyHPPLwrig2WRCxa2EFDxgDDWq?=
 =?us-ascii?Q?p1rJIJQRkuvPN7JgvAVEj9XnciyfswDUoEniWsCNEFqSIrtBsv93f72kHozq?=
 =?us-ascii?Q?uOPDjhjyl4055ClowFdLt3x18HPi8+BsbOg6BwvC8xZf7Uoxi+Y0npjTcVFI?=
 =?us-ascii?Q?uFKED9DwBCuRbGR7Sg4X3WbiCp1xKja2gaLFwIjmMji1307ge6DrJp5Fneh9?=
 =?us-ascii?Q?xAtUOAmdrL05sY1yn5BUFFjK16nixEw2Fcis9qiuk3DFp5kWucg/XvELTtYB?=
 =?us-ascii?Q?e5TqolOzivSKuSyebCCb7ydd2yInudOniU+ulT2t6+HiOl2GJ/tbtvVfHJg0?=
 =?us-ascii?Q?zNBCG4dXvDpaj3Isbm/XvwU1oL5dVlTRjylLwTmYwOXQJgnciTZ9bU2srWI0?=
 =?us-ascii?Q?D5KbK+bh/bnLmm55dTHp+ZFT6vdnOJf6SPwe/TqcncEo3yv7lUhDdWF5XUMA?=
 =?us-ascii?Q?RzPRg35WTg7veP53dG5FBQ6bIWcRHkKYDs4cMx09B7tRGflqjRSgbITISIU2?=
 =?us-ascii?Q?FTcis+91XCe2y5efRjfOrcnJEb7qaWG2eimKyvyLPK4tWV6AozDkD0YGf9wV?=
 =?us-ascii?Q?tlF03MBwHTC6AN8B7fp2G6Kncsimtnn6nYDt4kQU0gMZTOC1kDLDqYT1bj9+?=
 =?us-ascii?Q?+PDrdazhHepcp9wpPa3Ay8Ut9oHxJDI7iIdIG8akIXWzmBiwsgkxY3jVmzTh?=
 =?us-ascii?Q?C+gHhibPe5gOkkWeUt9wMTsjX4YayXKQJrshxo9lSipRNX7xFy9Z3fQjxEig?=
 =?us-ascii?Q?PAL7gsafdhCA/9ns7dwHhwfWLMLd4qGjcKIDdmwiLiamLrtX4tdsgPatuLFY?=
 =?us-ascii?Q?lcK1SZBP5pv/0jjotn+pamKfuG5YkHtmX1WfN8P44bAtNBSLXyUV1lASQj6v?=
 =?us-ascii?Q?sGI625CqQZuoM9UosFUQzf8bkKqSg2I/6Kdmc8hP/nXMR/Y6dy9/97Uht8Pu?=
 =?us-ascii?Q?F0Nx3h0qJV8MPnToBoqIIYA/1msknj2hAeUeU+m76sG//wJktCX8e3ggOhKw?=
 =?us-ascii?Q?AazOgtbxpZuVTVa6DZYYVrwGLRppQtQw7raJIvyNSTnOjcmKMz/KPB/omOLC?=
 =?us-ascii?Q?75O7abfSOypJKzHkckGUxNMZVuptwvR3dgSVOENYxXgNp+i36NF2oqMxM3g9?=
 =?us-ascii?Q?by4XAVkPc7NkpGJtKLHR2I0GsX5e1GyjkMaXnJ4c3k63a2RrdhzXrP8Z+0uG?=
 =?us-ascii?Q?q48wXrySFdrDpL7Y5Ep+zQr7m8AMckqf2Hq2VFqrzdgi16l3P3wJduHpBhCr?=
 =?us-ascii?Q?8e7FfUL94SYm6H6tAOutAl/ecmVTGCTe+Zosk0+taVuqt7E3SyZjn0yua0yL?=
 =?us-ascii?Q?RCkg4Q=3D=3D?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acc1214-7ded-44a0-0eaa-08dbf1682a8d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8660.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 05:49:49.6872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GthLFQD+yCeiUkHkJCtYfhKN6T5+rxxlLTyL5rlt9duijFxoQ1RPnC/aZdmdNabd/PVQZPSXc5SFT+0zMlS6kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6985

On Wed, Nov 29, 2023 at 04:03:59PM -0800, Andrii Nakryiko wrote:
> Instead of relying on potentially imprecise tnum representation of
> expected return value range for callbacks and subprogs, validate that
> smin/smax range satisfy exact expected range of return values.
> 
> E.g., if callback would need to return [0, 2] range, tnum can't
> represent this precisely and instead will allow [0, 3] range. By
> checking smin/smax range, we can make sure that subprog/callback indeed
> returns only valid [0, 2] range.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Still recommend to inline retval_range_within(), using just tnum_range()
, as per https://lore.kernel.org/bpf/ZWgcW2RCDW9hoOVI@u94a/

Otherwise LGTM

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

...

> +static struct tnum retval_range_as_tnum(struct bpf_retval_range range)
> +{
> +	if (range.minval == range.maxval)
> +		return tnum_const(range.minval);
> +	else
> +		return tnum_range(range.minval, range.maxval);
> +}
> +
>  static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  {
>  	struct bpf_verifier_state *state = env->cur_state, *prev_st;
> @@ -9583,9 +9601,6 @@ static int prepare_func_exit(struct bpf_verifier_env *env, int *insn_idx)
>  
>  	caller = state->frame[state->curframe - 1];
>  	if (callee->in_callback_fn) {
> -		/* enforce R0 return value range [0, 1]. */
> -		struct tnum range = callee->callback_ret_range;
> -
>  		if (r0->type != SCALAR_VALUE) {
>  			verbose(env, "R0 not a scalar value\n");
>  			return -EACCES;

...

