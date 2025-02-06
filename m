Return-Path: <bpf+bounces-50700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D17A2B565
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 23:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E43B18866AF
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 22:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E9822654C;
	Thu,  6 Feb 2025 22:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a0IwSjBm"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED1522FF38;
	Thu,  6 Feb 2025 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738881833; cv=fail; b=UCeUTWsadKw+31NqZzfKf9Gv/hUMRDQ6EYttWfN4ve9yJaWEsUusr1MNPVnYakPZtABq/b45IXdOXyw8XOzvizKclKBuNaLX2zLtMSBb/BHZ7g+Q0SflQ5fWrdqP0BoTClx9k+55Wwn3kYvDGdtDQ+hvggz7YnZF1pUIIyIw1iU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738881833; c=relaxed/simple;
	bh=WLPjaF4EjGcYzAjTFGrcalr7NxFzibudM9HpaNAeV/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PXSXX4GVJMRrohS2V7TkpYcFM57Jml3i5H9OS3zBr33Apogzux0o3Nb172GqY3seqMy/cii9SlSyCyUJB9vYIY0Txq20d5bVfSvmJrE4/IcDoRKxjcxxyJxQ9o6DTemAWuETi7vYs8bjoxvGDPEMo55jc7Xw/yuCVGzXBew0n5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a0IwSjBm; arc=fail smtp.client-ip=40.107.237.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou0TvXWAhb0vJaxfWRoElGKg3T9qhCPdN0tc/IhCytcSZQaTXm8QZMXy41I29uwgeWhh8ZIxO3Ax53u8P3mcOIzuFdqgmCst42JQ025Sv5Dri9iZN/qUypfzyPTw7qRqKjNn9M6et/00RH7d7QR/PD14taWnGQC5xZ8OqkUTRlLdHnPQlj4tWvh7iGPMwdRjDv50vIqdD1EbDBG9L8+UW0bRtJQF90e0xypdkfNQKw8pk+fqYsex3UyQXNHaM4q8wH/R2D0P8zsbub2vVlxv1jjf01oYGKKOvcjETgEhIGnIR5Ad6EuM5kL09FRwaq2zRkyUst1IF8OkmXM37Tbnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uy2dvmPlJf6wwLASdLcTUdGJEyjDglVrQxNrcGgFmmg=;
 b=VHF/fT7esxkH5AUf5kLabU6cU9vPj12579rdQmpz3USGanhYQ5IHcsA2maZbzWglRHfLyb1UmEO+V4/ofiPlGvqI9elbU2PokUcLke6n56LaqKnGUwyaj5NBeeoJaxV2i1JZYfSiLOp6kqQnX9u8Xf7BwBChYbp3nXwDsrd7ghQL32dg1Xek1C0dDJZDk9dOVYbG7A0hWvgx9/My5bWkucLWURxmNyR5vlmQV7GRZVykOzJUZV2ClsG43xhW/AmC/60UIXqRV2rKIQPUts33x1KfqcG6RfNkh5MG4huxwBEwmtBih+Rs8M9aXAaA9ntkru3VMnez+6oKxnD92wDbTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uy2dvmPlJf6wwLASdLcTUdGJEyjDglVrQxNrcGgFmmg=;
 b=a0IwSjBmPhQj7VZVdEY4wHWsf+bYQEH/wjlJlW/pvzraFEPOODOcLo6ccwIPYi4fyAqT7PnxtEOG3PQK4xnI8mArBKfoDST8aWeiYkH2fLRcu9K7vK/1uu/L2OzA1F6DoIjZQn68EBXZ0iRRBOtCeyPj1BkkkZOUSMCRKhTGxci4eyTDnJ632UFi05kdoqFjalUmNLkulgbF2u/mpQ5FX7LJotuFZVcBUdokspliHnv9D95UQ34bryHDXulrRgu+uZkCmzzFnZQD9hldHcq6BhMvAK8Y+wr3MzfFbpVDcNF68SEJ1I5hWRME0d0bLhBwz0xsAC6WeSBLj9vv7r68+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by SN7PR12MB7953.namprd12.prod.outlook.com (2603:10b6:806:345::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 22:43:48 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 22:43:48 +0000
Date: Thu, 6 Feb 2025 23:43:43 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Juntong Deng <juntong.deng@outlook.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	memxor@gmail.com, tj@kernel.org, void@manifault.com,
	changwoo@igalia.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next 2/8] sched_ext: Add filter for
 scx_kfunc_ids_select_cpu
Message-ID: <Z6U7H2nzJzmMixdZ@gpd3>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-ClientProxiedBy: FR2P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|SN7PR12MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: 892c0384-2b2d-480b-59ca-08dd46ffb842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aV5ZDZWumod/9hbId/4GQs9u2b14D4xVSEMsE6NcWmKSoWTbuFMA0Ht0ccnF?=
 =?us-ascii?Q?yCutjsdc4O6q95BkQAMauhVJs+P8SE+3QF+Ohtv4bLzOFmizYcbcs7Rqa2fA?=
 =?us-ascii?Q?W+lwMD3jbbv0iRL7OO4YDAvgwDRVpJpUXG+mubdIYTtJFNmV0JD4f18cXQMx?=
 =?us-ascii?Q?ni/4dyqh7PEEcg6imiEl2gp5MrUAIw2+jrth0eRB0YDIH3FqFT4JjL8FVRxV?=
 =?us-ascii?Q?spCdqZUTYtXxQ60IjfvYGleZQa+MvoRh8CXUMgpJDLpfj2tLMFDmqLDo89tK?=
 =?us-ascii?Q?Rx212JDXU+jEtpN4YNdQelMFQ7Ic+ygyiSWgtPi3OUeBh6RNAAGLzXVSHF+P?=
 =?us-ascii?Q?MSFO8AHOJQub8DMFKgGwO1K5FlKMmi7q0NLfYUP7iUfSJjkKS1cLFOKgDfIc?=
 =?us-ascii?Q?Xbhgp+8ycxFZ3v8MMe/mTYnY5JUIYmJy3dEr1/IdbxDZdu+7+RUgMgob3/kN?=
 =?us-ascii?Q?gKhiOKvNhrKiVhmSj+QWrYlWNYY2/bPHcuJDG2RNzW2EcNy5e3ELDowg2PDU?=
 =?us-ascii?Q?279cX60oDZ31Ly/4AyOKTacyDOvMVlu8RUr/LSptYnn/nKVS4+LYTnBn7ldZ?=
 =?us-ascii?Q?ElwErtkbpwnCx+defaEbpyKEX27AQgNxJz5Sz1jfkBKGXJkCFCyDdzlQdEtJ?=
 =?us-ascii?Q?PbeaujlsdyKev910yDi9Gobnm6k5K5dPPe6+20ROsHQebj6FbvxsAQy0lY8E?=
 =?us-ascii?Q?KpyvDkOW6iJNTAjkj5EQ6Hn3FrkkFqG0XdD3rcNkjvNnsjIirosHufjYw5X+?=
 =?us-ascii?Q?6dAFtwbHnOUIvlQuMK0B1smQ7eU/LVVYXWuWEVNtXwDFVtutNA7u9dYV/bt9?=
 =?us-ascii?Q?FNyzOeeopAzoy3H5HfntkUB0WznKtcVDenyb/zoWqeIg58Q5qm26VYpg/u+/?=
 =?us-ascii?Q?z41LKcYrs/S5hGCcf0YbZSh6cuBZMaH6/tjJ5quh0DPyReu/POCfb8RGgKVc?=
 =?us-ascii?Q?J8xkM9noFbRnj/3HxVLSP/CzAtd37hmSy0gl+GVYq+7EkDOkgJZDXwEMT56p?=
 =?us-ascii?Q?fmRpzLwPq41xe4M/1/8fFlBPVdcb6QRKMdz97ZAxnfB0esgGvuQXHFn0VpgI?=
 =?us-ascii?Q?Lk3tDz7BCf/1LcNEtdfUJ4ej0aAZ2i6fklGomHlzzVM7jzTLofJgyp8UfImM?=
 =?us-ascii?Q?qdw44ZT/ZHslbfu5TYhuDbyF6vKzSivGILJJVggjvexqhHutzE5lBCetK5bd?=
 =?us-ascii?Q?1tPCk1HYdi6kHtt+6hYDJGc6Gi8gPmsRGs2ss0vrUfYdhvB2xo6w9eGoeQA0?=
 =?us-ascii?Q?nFAv3+7Y8fiprkD3KutNposELnxarR9vAdLqTE1sNjldnjY9u8KBWnq67t3u?=
 =?us-ascii?Q?12PR41WEX6VC585XfEDTxGlZUBtSSAoo0MTzu6pzEgtKnB5jEpJIo54HHuRD?=
 =?us-ascii?Q?j4CpPnud5oD8rzUF4twcGsiAWBB4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4IXzH/0Em0HEaeCMngmADuOt/OOjDrsfrbbkKqvyO8lDtWm45QxAh//TttTY?=
 =?us-ascii?Q?PgjHfl4o+Zi+EcZy9bp9c1OIeAjzFkGhKYOqmcGjnOVl+jDI6RdvecXKCAEJ?=
 =?us-ascii?Q?u3MnHfEi8NL0j0f9+IJq8w2FlghcWGn7iUdAMdutk5UA8Z8m3Q67LEhdAneQ?=
 =?us-ascii?Q?LoU9ypw5XCW/f0vqObXvC0/yAPMLXwZ6KXBmaJhUtp3A1uIBXKLOnauiaec9?=
 =?us-ascii?Q?p7n/Wm9fvkPgFoDLT8PYiHXSniWlzmef9Rl1v2IMvOVpZ33FpU3zUIDCrXQ7?=
 =?us-ascii?Q?bLbUA/6Wildl9YFWEQkcmH1BfH2U+4d5PrUJ+XZUogvTcRylW2gZmThikbeU?=
 =?us-ascii?Q?cf9k6hzyBCU6UoX0lGh48mS9Mu489yjsBFHVFd4Xn8Mlj9SiSAKT486j1kTd?=
 =?us-ascii?Q?ZptHa1y7q/zrK5tRylKEbd8YimbWKojKm0HRcYuWlFNgBIKqEZ6XF0VPLOpn?=
 =?us-ascii?Q?kX10HTtg21r5XGI0F8r/XyumEuBcZRP5I3bv8O0lXna6YapHEXeWV34ImhXq?=
 =?us-ascii?Q?SvBLzqW0CXEAyNrUE7bdiOiJvUGiuflB9vVI/ghrx0ehhxPjFZHFJ+M2p3kz?=
 =?us-ascii?Q?rRgzASUwUGM2XmA68JLYpQzkRcYMXBmEPZYiljz6CKcpZIFWgj551VO22sda?=
 =?us-ascii?Q?3HPDXevcXL9BVRs0WvPsuxBjM3t3yNaJL2d8Vr+gVU5QLhsvPXzHHLvG68Sd?=
 =?us-ascii?Q?TbXTTeye1dIwi95Op+mCru8K8ISBa2rdlehjyGp/96uQHLu/13st5h8T+ByS?=
 =?us-ascii?Q?PC6PiwpHHsTwt6j0M36q6890LJl+H6c7rDF/umjdabvqoGDFchpwD+/wOCCJ?=
 =?us-ascii?Q?vQhnALbAwyocNvMh3/XkmlQzk8FU0LN7eiT0IhZXnkAKnRaqy5cZ1MGyQf3k?=
 =?us-ascii?Q?RwvFrsICUYf/kfxFSLqDVdMjCBD2xcPnx+NQVArPAL5+PApTJM6E4Kq352EG?=
 =?us-ascii?Q?kOEVJ3do8Z3KYbSsn+DXJLSaXgvvcYRTtqkV07DAp/Q2xyRdo216LNYGJCua?=
 =?us-ascii?Q?/Am6Uij5OYO4KzCfaPvD0ktXjDLmVkaMfp9nsS3jrrgpBR5KFeMxO52bgJve?=
 =?us-ascii?Q?Z8IpgMAiVm6GzDcTZ1Zgk3F/UVgKhUfqrBQJAbRoR2K8MTXVfy14cKSu+NGV?=
 =?us-ascii?Q?P31BlOVSM4gSIaQqyehgQIljOhv/OFn8xLdgf/XBM8yx//qL2tbhVs2jeM6F?=
 =?us-ascii?Q?h87undj0Bvn0W9oUp6t3hWdN9OoUmIs09ROYLZAdzpzDdmHT+LQIbHx2CFPe?=
 =?us-ascii?Q?QgKLIdttfUVjHRzNOOT5u9ehEkP7fPz9oHcC8GBGCQnqDXquwW8cFj1uJNMM?=
 =?us-ascii?Q?hpCquE4V+RVmDjqaJm45fTmA+NcEv6xFBWF2J9hSsI0Va2sA2nYPlGQb8jtz?=
 =?us-ascii?Q?AGRn2JvSePen2fZSdgCQSGHFOUEWl2TxxoQy6nAon5Iqi4BvLTdjW9FLd4qZ?=
 =?us-ascii?Q?YofMgXvyz7HvM2gJEc3DlEX0lyrda24+Lt0e/DZB/IhvTk59R3S/+fxSKTt7?=
 =?us-ascii?Q?qBjzDOTk3jl3dkEN0tzBpdiUeEtIcKb2pljQsRm0OH+bJFAz4Wkbwf4pHKBo?=
 =?us-ascii?Q?09dCwo/1nFXGPqk/M3HrXzQMFJNAwO3zJhHkgNoQ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 892c0384-2b2d-480b-59ca-08dd46ffb842
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 22:43:47.9412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lCecAWZdKUvFSmb8M0DB22KzPMtNkRUFvfIa898IyXfz6fYHPXntL7KVUBP41Sqro3bMa0i0Y4P0rRXIiQ7Dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7953

Hi Juntong,

On Wed, Feb 05, 2025 at 07:30:14PM +0000, Juntong Deng wrote:
> This patch adds filter for scx_kfunc_ids_select_cpu.
> 
> The kfuncs in the scx_kfunc_ids_select_cpu set can be used in select_cpu
> and other rq-locked operations.

The only function in scx_kfunc_ids_select_cpu is scx_bpf_select_cpu_dfl(),
which should be called exclusively from ops.select_cpu() and not from any
rq-locked ops.

> 
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> ---
>  kernel/sched/ext.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index 8857c0709bdd..c92949aa23f6 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -6401,9 +6401,51 @@ BTF_KFUNCS_START(scx_kfunc_ids_select_cpu)
>  BTF_ID_FLAGS(func, scx_bpf_select_cpu_dfl, KF_RCU)
>  BTF_KFUNCS_END(scx_kfunc_ids_select_cpu)
>  
> +static int scx_kfunc_ids_other_rqlocked_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	u32 moff = prog->aux->attach_st_ops_member_off;
> +
> +	if (moff == offsetof(struct sched_ext_ops, runnable) ||
> +	    moff == offsetof(struct sched_ext_ops, dequeue) ||
> +	    moff == offsetof(struct sched_ext_ops, stopping) ||
> +	    moff == offsetof(struct sched_ext_ops, quiescent) ||
> +	    moff == offsetof(struct sched_ext_ops, yield) ||
> +	    moff == offsetof(struct sched_ext_ops, cpu_acquire) ||
> +	    moff == offsetof(struct sched_ext_ops, running) ||
> +	    moff == offsetof(struct sched_ext_ops, core_sched_before) ||
> +	    moff == offsetof(struct sched_ext_ops, set_cpumask) ||
> +	    moff == offsetof(struct sched_ext_ops, update_idle) ||
> +	    moff == offsetof(struct sched_ext_ops, tick) ||
> +	    moff == offsetof(struct sched_ext_ops, enable) ||
> +	    moff == offsetof(struct sched_ext_ops, set_weight) ||
> +	    moff == offsetof(struct sched_ext_ops, disable) ||
> +	    moff == offsetof(struct sched_ext_ops, exit_task) ||
> +	    moff == offsetof(struct sched_ext_ops, dump_task) ||
> +	    moff == offsetof(struct sched_ext_ops, dump_cpu))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
> +static int scx_kfunc_ids_select_cpu_filter(const struct bpf_prog *prog, u32 kfunc_id)
> +{
> +	u32 moff;
> +
> +	if (!btf_id_set8_contains(&scx_kfunc_ids_select_cpu, kfunc_id) ||
> +	    prog->aux->st_ops != &bpf_sched_ext_ops)
> +		return 0;
> +
> +	moff = prog->aux->attach_st_ops_member_off;
> +	if (moff == offsetof(struct sched_ext_ops, select_cpu))
> +		return 0;
> +
> +	return scx_kfunc_ids_other_rqlocked_filter(prog, kfunc_id);

So, I think we just need to return -EACCES here.

> +}
> +
>  static const struct btf_kfunc_id_set scx_kfunc_set_select_cpu = {
>  	.owner			= THIS_MODULE,
>  	.set			= &scx_kfunc_ids_select_cpu,
> +	.filter			= scx_kfunc_ids_select_cpu_filter,
>  };
>  
>  static bool scx_dsq_insert_preamble(struct task_struct *p, u64 enq_flags)
> -- 
> 2.39.5
> 

Thanks,
-Andrea

