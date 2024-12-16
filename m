Return-Path: <bpf+bounces-47049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042C9F377A
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4901C7A308C
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF95205E25;
	Mon, 16 Dec 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hphviTLS"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0224EB38;
	Mon, 16 Dec 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369890; cv=fail; b=Ooxt68wj3siopxhvYIC6Y/2w8mhK8Tj2/m8nUp+TTQz3zYA8VZVp6DluT/VbfIK0ui3jzf85Cg8ZBGSw/mK2l376HUKKDPvHGWskCjpCEAe3zzCtrriP2U3DH2EPrBXN6Mx3LUkvsqqet+i6X57DMKp+gkZ7HOHcRxAUdr5J0JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369890; c=relaxed/simple;
	bh=9H4QqlttsQXeqmKWK3VbPPvn4dybJIOoPvItBwIJoKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TMNv4xfVOw2+WkR+un9z1Jo/+8DGGdFMyQVTubXJfHF38QMLWKiMUmGZSvo168xe5KgPHnSsEbTCVoNNZx5cJ85c5vezVK02o8JXdr88UhSV9AGzg/9Qkqk2EWeRPtO+fHB9n1wITr7JNSNWwiZCCJbVa5ZkCjTqVLHBI7s/F3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hphviTLS; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TtXqinB8eGW58pVBJU24C1LMeAC9XPZvvMJhBSQbLM9UCoOL8ePlnfR2hinlX7II/MbgruHXFr55Vqsu72mskdkn0H7g98oRHGzi1yNJ3gOvESssqlnEtzqmWmcAMPghpsJcIdhVoSXv0KMVq7xrWG/DA9oduBlc+Lc+tp71eFOvTlQcNFd0ZMNKR1YS3UrD8qpEwL1DLlfxpvdCP8JTh9h02bnjcAtNYEkEQN7Dxw/aM6pV3FJQuIRiaQgNjdpj9aZ3zUWqNbDgFYH7ZSMl28CnmjuD1UOpeyFgvINeeS9gdkYKBIBfRoPd/y/M7Ngq4tST7aURmalvrN5yhS0s9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAr6v7PcAHUA+TXBa+T80fh0vuppi/n/QNVAn6o+eo4=;
 b=a66Y2HtsBql8Y5Iyq78Mr9rlcS6tw1f6bMDL69d87h68xqqa47TBYsn1boaQTTQ9troPqEP/X9s1GVvzIquhodks2/b14wjJzE4buNGDu8bjzJA7cf378ckri4B191RVYIJe4+Ct9bAQpY9cUMDghCIoVAqJRdn3ETO+QwnQnXUkLGD/vhyxMdFQEvluInc/PeLTX1nlG79yErZVUG0BVH29HS5mPf6wOSlkk2Qthb1rl/Xg0dw6mt3LuUgu2wAhnOpF0QSDbtH9qPrxAqwwi4PwT/opeSnkMyag+EgmrkHzPiERlILu5UKegSKvaH8VUCZIiw/ThmmJ+kXn7cGoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAr6v7PcAHUA+TXBa+T80fh0vuppi/n/QNVAn6o+eo4=;
 b=hphviTLS9OsLXH1MoXM3YYTE33b63SWsmUEdNcS487cMjudyDpqMTNo3BurPbfivw35cOPHwjDvos2Hm9ZOn/n7kr5C9udmGY5X0CPr6QI7BAyng3/jGopwQiF9mZCPhd4psDKd8IKPW+aw64dOAGYTuJnc1lEWIBjmWykf/RN801i7uBvaQ0+nY1TeKWFp1qozrGHWSJ9f0Y0o+OhYk0MrXeVFo4y4xvQjReuco6tw5ez7FkC3PkDO3NHPWk24CnJndcpJhg+RDyX09qi014kAZK7V/dVJIu6juDRRL2jOaMAQ6P5FviPnkJMCxHIKFvHlEux275F1trHwnhWvC/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 17:24:46 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 17:24:45 +0000
Date: Mon, 16 Dec 2024 18:24:41 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: do not inline bpf_get_smp_processor_id() with
 CONFIG_SMP disabled
Message-ID: <Z2BiWTcp-CnC5cCz@gpd3>
References: <20241216104615.503706-1-arighi@nvidia.com>
 <5e7c4b07-f5f0-400f-a84f-36699f867a4a@iogearbox.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7c4b07-f5f0-400f-a84f-36699f867a4a@iogearbox.net>
X-ClientProxiedBy: FR4P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::19) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba4e9ed-08aa-4569-bb18-08dd1df68922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+jTcKFfZBOeXl4eJ+vH74qylpX4vB4h+1CV4EIC3PzJ0WCo5jQp622iVhvat?=
 =?us-ascii?Q?OAWGG23cnEG2JehHh+02zTBIf9/bA++N/l+tNB8iF3KwdapYddSeqW4tlTZh?=
 =?us-ascii?Q?MAKbftbo73rzJDwzHF5t8nGmW/i0UoXJgfM138gc+Ih96efhTX0nva0sebyP?=
 =?us-ascii?Q?D9z6roFGYGJXwJB8VI2Zy4JutuR9WZ7mOd4kYGHDcjBAMYFZKPleLnnyajUC?=
 =?us-ascii?Q?LdVUmmqpd5SB8XXYZqP7PQFigQ4b7C22LEpFCBKAIgs/VJ80h8drvNqFRzye?=
 =?us-ascii?Q?oJcs9yv2CYDjSrHtO1yHT4KKWivrydue/+qVp4m94PjW0BttupXvBjRiEloT?=
 =?us-ascii?Q?Jkl8iO5XlgLuiTzWrIxo0GbQJXoTSqkaq9XWzCAUUmt09sVBLCZdyNKaaMat?=
 =?us-ascii?Q?bdxw1y4j0hemDT/W5B3NQePxBRWlbe8eA19y+prM2LwBhTM8fl+HDlD2MVEQ?=
 =?us-ascii?Q?2mbhGw5VVZZyFLGz6ZrEmseVDXhKLyCFWZnMR6qrFpQVLEvidGKqW+edjW3d?=
 =?us-ascii?Q?4UmPb35VebwYm4KMj/RUSouFpgouZ6VXKg4L0tZ94cF7WvPWDJ69pLRcNA9M?=
 =?us-ascii?Q?VfZttGCx+ogsWs+GzkGaAQiGPCB5f/b5TYM8YDpVE8PzAdf+5pd7EY3fdYHU?=
 =?us-ascii?Q?eYyoU0q4NIvaz0P1QX0Hx+dBaMZb1uGKI82qBajQNMvap3FZbIeTYku0U2mB?=
 =?us-ascii?Q?suwgpRYY17qtdNdBqxDoElZVZqUTK12GXn4tVdp4lvXhHq99yGJO54cFOjJV?=
 =?us-ascii?Q?/uk4hyyE0RqxDgD27dwwr6VhhaDj5rbp9DXPrvie9E0LDrHShX3gFBruUIO4?=
 =?us-ascii?Q?k7xC6djnWTYuI2ioZr5bBHJ5gr3ps9rWJZbSHe/3qoPjaEc2oSYcX5asDOvQ?=
 =?us-ascii?Q?sAcRl3sTXHeLoR7xyte6npTwYjVIQ26c4+UCzp6NKZtt1/XGHl/qy4JZl/dd?=
 =?us-ascii?Q?aCA62ZDbC7ul0NTERiaSsJl76EmJNuMHgdb/VbxnmcuNChsEKOWNUJ3ZKFps?=
 =?us-ascii?Q?tnOFneQbxYchwqmpapprecM81ss4R1ZQW4MTm2x23r2P5PXtN94PUZhGaEZ3?=
 =?us-ascii?Q?HGDxjqHF6ywEiOvUgvgjGvJFWDPQI9GoWlj6UhwO9vfICnNF/gvFmB/ytE0Y?=
 =?us-ascii?Q?kZ8Fvi1ITP3e9Oz7b0e68sRRnVUGILjq56PkCYc3+y1bOc1cX+2B95ptDy/X?=
 =?us-ascii?Q?oTsrpzqowgGSShlF/8qJiBUbgBwGrnO4C8Etq5ackN+qNiwYZzdhsHwWIvlg?=
 =?us-ascii?Q?zKmJ1MJy3q5KmbdhWUkllKzqIgmcY5Q+5pVT9lZuVpjf7f8SU13y1WH4P3/i?=
 =?us-ascii?Q?jtQomgHkENCWIi9nAcvEnXBBw/FpS5Hoec1ORGGTycvFDT9i1zs/BXcjhZZ3?=
 =?us-ascii?Q?QKnJUA7QOU863yPYZvDqD5ppMK3l?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1U5fZSarO2PiqqWuNR8aqcyiZQfmJQTRv579xnIaTj4EpDO/ze9mVgW2Ev35?=
 =?us-ascii?Q?sL0gpIGQp+ZFhP82W7/t5x8MNgU2x0/YFXtPZLCAqJ1CGyqR5FMbAyetopM5?=
 =?us-ascii?Q?IlqMAby/89hm0Q7uCl9gGo1fdn3RwNKKPNWwgXvDBaUHPZTvBJaRYZ/Lc7A+?=
 =?us-ascii?Q?Q0yJIeLQMLrNG5e30gMyc8XeLNBPhwe1NhuG8gHt/WNVXu6XO258foF36hU5?=
 =?us-ascii?Q?EQa6RikQJ8LtOZHh8q8xdQRRdxPjsqsjSRdMkxYMsYP6ynMntj5OForHDVlh?=
 =?us-ascii?Q?0XxnLmqGJFvIAYb776Y6JHaBEeeIn2DDzxQHpZyPHAxRK+SRogzBhlkGTpTw?=
 =?us-ascii?Q?De22N3jWM02fiTimQOpzWlWb/KWrZPSyEscY/oSJ2Sh5/3iJRZAunSLsEQOW?=
 =?us-ascii?Q?svKpTRhEGLzuocyfPGYHrOLLqsBosAFFmlAYIexGE4zJh+vJbyONwpqHReFL?=
 =?us-ascii?Q?tus43lFP+qmZFic1Dg6jgze/IpLpXk2gy/1toW0LFNpBug0Cvd0sXuhWSrZM?=
 =?us-ascii?Q?ixzM6AExKJas0M/LSU5y2opV/XCul2wrViJ+XlT4hiFZLNeDaA1x3oLPZ1aY?=
 =?us-ascii?Q?1/PmEkIk8DsT8k+j2qXM+RgU19NFIT/dA0soWfzdfI9HmgThYwYQSOquss9w?=
 =?us-ascii?Q?IKNeLs2t/p120pyjuOY0wVDM3GPW3ESJ/dIRcRO0ZE3JR/iu6gVWrprZZx9I?=
 =?us-ascii?Q?wPiyd1qnNPOKZwC244Zykx6GuXAjdCPF7ZYA1Jvy21310273bPkZpcjZ/O1x?=
 =?us-ascii?Q?Vrbd6XybBJCO2vlSmfsckrpQtYLlAjxolyT/gfZMqX4aBX+d4aMSwYrXXft9?=
 =?us-ascii?Q?EBhc8YB7C7gmT9FPqGjGashD18eSopP10VG0Gx5gvSllNUhobOZ13/1dHa4F?=
 =?us-ascii?Q?q20D3iz1RHCkLTI5so+efW6BBE7BX7UTVMewdCeNyZ+f4aKiEvQkhVsdSrSC?=
 =?us-ascii?Q?1MEzRUexD0jWP95dzxEVWoNNITcrqH2dfV+8sRd54nRRTKzn3vJyRh81SJkf?=
 =?us-ascii?Q?glrSBh53sR2tFLvT+qIFbdfMLkYX7rYzHeMW0qNnD4PCga8cRbvJVrAp62rS?=
 =?us-ascii?Q?wY0eYAP4nf+yuDJmbqZhhzn9zxuOTnf2SNuijrrdI8m2wNoI237/e43cVquH?=
 =?us-ascii?Q?5RvBu/K5S2gAMR1W7QYL/1ghep7xFn20PcqYPApMSrecLAYrMVoxcCJW9wT6?=
 =?us-ascii?Q?Jz9s8ZRAsBvblkGh4L4i6224L5BOEZfNprRs6XPCZHoo+yJLkjxOznGaDg7T?=
 =?us-ascii?Q?tPSezsBcXniuJ2768GoiVOQp59ul60LufaqpCnaX5Ds+/gtFdQhwbbm4fzie?=
 =?us-ascii?Q?Q1BZJrY+mOQnAYxD5hOsbkQ9I1YQ6RiDMSofmKTKDhLvs26UrFm8F/+30Czt?=
 =?us-ascii?Q?KJc6wVSvx7y3cgCcYBRWDeDFc+G7F/syRTbid3y9dUDeM32PCQdgYR6T1Wo9?=
 =?us-ascii?Q?eVrM//WHBXmOsd8DxHJiBpooXJhBLtUYIAux1Pbd7AFZ0o7Sm4bYYLvOPmXF?=
 =?us-ascii?Q?Iipmsbqioz5OIGLJu/JDgUGTvT6xJztcdumRvRts/oI0GaYLegx+xmqyA8AE?=
 =?us-ascii?Q?8qi+r14UCL9TEgTmVL+/edBQ3dIX+IWHqtoQyyD3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba4e9ed-08aa-4569-bb18-08dd1df68922
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:24:45.7792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qq2YJ6lJ3mELzP5RXqH0FhHlL+G7r2hOcLoWKTWVLmmqOADJ74HpBaVMuLZDTD4umKgSMIEEgc5m9pLX3HiG0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

On Mon, Dec 16, 2024 at 05:16:33PM +0100, Daniel Borkmann wrote:
> On 12/16/24 11:46 AM, Andrea Righi wrote:
> > Calling bpf_get_smp_processor_id() in a kernel with CONFIG_SMP disabled
> > can trigger the following bug, as pcpu_hot is unavailable:
> > 
> > [    8.471774] BUG: unable to handle page fault for address: 00000000936a290c
> > [    8.471849] #PF: supervisor read access in kernel mode
> > [    8.471881] #PF: error_code(0x0000) - not-present page
> > 
> > Fix by preventing the inlining of bpf_get_smp_processor_id() when
> > CONFIG_SMP disabled.
> > 
> > Fixes: 1ae6921009e5 ("bpf: inline bpf_get_smp_processor_id() helper")
> > Signed-off-by: Andrea Righi <arighi@nvidia.com>
> 
> lgtm, but can't we instead do sth like this :
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f7f892a52a37..761c70899754 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -21281,11 +21281,15 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
>  			 * changed in some incompatible and hard to support
>  			 * way, it's fine to back out this inlining logic
>  			 */
> +#ifdef CONFIG_SMP
>  			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
>  			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
>  			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
>  			cnt = 3;
> -
> +#else
> +			BPF_ALU32_REG(BPF_XOR, BPF_REG_0, BPF_REG_0),
> +			cnt = 1;
> +#endif
>  			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
>  			if (!new_prog)
>  				return -ENOMEM;

That works as well (just tested) and it's probably better since we're
basically inlining the return 0. Do you want me to send a v2 with this?

Thanks,
-Andrea

