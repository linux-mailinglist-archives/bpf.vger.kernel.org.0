Return-Path: <bpf+bounces-51759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B48A38A8C
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 18:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738AC3A709D
	for <lists+bpf@lfdr.de>; Mon, 17 Feb 2025 17:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10339229B11;
	Mon, 17 Feb 2025 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TVJVjtrr"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4EB4EB51;
	Mon, 17 Feb 2025 17:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739813241; cv=fail; b=Xndx7UVGoy/mJ8AUesYO8LaLRnKRzCUBwaFgWapDivI7ZiIh70kEP2ofOuQi29wpR6oTGu3enmj8O5LpzU3Fyq/nEy8mizKeVtn/CEIfst0x1/WsEOcQsOxzNR0XZvX6dwBOeQ76dA8FxchhQbiZDe1n3mylr8q5X/bcqmYVrGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739813241; c=relaxed/simple;
	bh=umDUISRXG4cqZKxhfA03W+VHEM3jDXl/n1Nygv7B28U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dK8YP1iAZUEi1CKMgujuZPBD+2iJVIxhTiTHfVgr0gDtixZeQGtEb8Nr/s5sm83uoXYo4BHNzD/nu5UR5mKSRBgqwAfEdSOf4mELQlW6UTJtuCR9+E1I7Zj8sUNBO1OYnWbkfi1R8Z37bVYe5QaWYMQbRmC/yvk8WOaR9ZlbDKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TVJVjtrr; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSXzed0pXm7UZ/eoMEIOO2Ish9hw3BWKN6DIRaRqLNI0NgdInnutGUGiBL/TApxlQxqUHrKDew0fMv9aT5jRjxhgvjNq6riZe6xX+5mdW+rs3aeXrPZryAPESDBDAeHowQJVqqH+cVWhuRepQecaeR1fGd3ZKxVbluGsuxmGj19ONNWsOMAZUWkMK64o/AAEgyITUnJYj8a4ukveabKsPYhXyWdvESCK5ZTj/9zlV0QVn5Z8tXOEZvTcNx614wsp0Q5q94KsOWMsVwm7OzXffRTdbCj0h94x7SpRXBuLvYHYxTLKA1YbvsgvnxSo7KLxrpOyMZembao3FclMSMSXBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYWZkqK+tW+K+Pq7VB7QdRR6KjsqI/2LYUkN/s1Ps3w=;
 b=DWSQkq68wUuDqxfPvFdGiuP8iGsWv+4IVy9Rs2kzLv1hTYG1zsH9gDViTLQdSAeGgAPtuTPBhPT53KtxBfPixiE2as8Iggu9Wcb239hifM1hK9DYBmKPFxC/3x7ieSALNcR946CzS1I+99jiqsuPXkhgPNJUSfTUT5+ES6Qng13MXnwPC4SN1KUdyI0jWOTWTKxOFUWL4HZJo3HIenTmJm+WlrldVImmWp4b6JS0Ee8bnOQVXdd2tlwtrTfxteHTcbJA/JTV0NsmUy4RBr5h6ilz/atOEjGPLuGXaDaS5VlXo5SoMmuaP9K3TeVb3GDcQ5CPL6+bnroBVHass7tjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYWZkqK+tW+K+Pq7VB7QdRR6KjsqI/2LYUkN/s1Ps3w=;
 b=TVJVjtrrqNStSLilbWetDk/0O9wVNnMnW84IiyHf2b0LEBKd8+YeGiOIMWmNKSr1aKYcakJG5hj9iw5i1DpQFrfCUos2JE/eUQcatXizXBlvoNmxF66ajL3NUCamqDIkTDSEmXlyy+7CSEdmily2RhF8cu+5dDiQ8pTuXuPYGiXC19OBi/9nBVkUXJ2Vf88r8uEbKczt2MQkfHn8Ta83x+G2EZ+AmvlFV3wSUHxBTvDhUQmRQZXUsnnxnCgbfw8SsHcLEKnhmtk/P5Ja5SYAeFnFZe9w9cS5jsVehFutNs9MXkGolvqgCdISjURy/Y0eB5SRyw0xtGqF4vFyOfHRLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 17:27:15 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 17:27:15 +0000
Date: Mon, 17 Feb 2025 18:27:10 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, Ian May <ianm@nvidia.com>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] sched_ext: idle: Introduce node-aware idle cpu kfunc
 helpers
Message-ID: <Z7NxboD4_G7HVAlf@gpd3>
References: <20250214194134.658939-1-arighi@nvidia.com>
 <20250214194134.658939-9-arighi@nvidia.com>
 <Z6-1mQMBhq4OOlvB@thinkpad>
 <Z7M8h8jGEPoPmmiT@gpd3>
 <Z7Nww_e-aHXsfXcS@thinkpad>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7Nww_e-aHXsfXcS@thinkpad>
X-ClientProxiedBy: FR4P281CA0370.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::16) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a173386-eac3-4eed-fce1-08dd4f78521e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q/bIo/52BcGbBommSFCff6b2fgdgA+gzhWN66IFerPTRoiAB6GcJgq/PGnZ3?=
 =?us-ascii?Q?ikMBrDcqkQAOKbbqEFPzoyO8dB1q69or51MbIOFQDUhokurfQ0RvtkI9gllh?=
 =?us-ascii?Q?vY3MKqMf15nu62z3laTLlLyiQTT7b38RwpdyjT9iQUdAnacPPsc7oIM/fNcP?=
 =?us-ascii?Q?nw86c6ewfQFDB4LTY+CtVzi5KkkyWpbkJL9BDNoykfK8eGajODjaus6a6Bh+?=
 =?us-ascii?Q?zGpA1WStyAOOvbUFyUslytTrJug88+P4s74KBw4K2J96TwfME3KoBeVlJfv9?=
 =?us-ascii?Q?j73fAPreiQXOqt0bijqc31wYY6Z4vweT8HY2W0oqKlUZ4KC4OHmmqSOSDJJ8?=
 =?us-ascii?Q?wZOB8xrik050WXeD2vQPFp2weLjC8ljCAMWsaQW+V84Nv2axmiXojTrd4Qq3?=
 =?us-ascii?Q?jUPn7Ee7j0uPBXfTI1BC3tptyn6AXy47c1egF8jb8EN1Jiunl4ECGUihUje+?=
 =?us-ascii?Q?z6F45Ae488eJE6EXG5PBtAvbuAUaps1UZl0GbZmHj28zSjn4bPX4LIaf/mBN?=
 =?us-ascii?Q?0YxPKF419ELt8MnXcd98KeWO/Xjk38XVEi8KfFA0eXFz/y4OsphqnFrt+Q9c?=
 =?us-ascii?Q?uf62lGRlCNrm9jEuom5s4/9gsxS73/EM7n1iSjhc7fKchxySZNHkvZ7rbHf7?=
 =?us-ascii?Q?s8PQ29wVqQsOfhz0Eho7srWZBsr794ng6eO7uw9QHqqVsQqsA3SbulVSh3MG?=
 =?us-ascii?Q?t3KztZoIN5jGVzl0ttkVj7nLH5FqtrjPH4gnwlYqvBbvBvdZkM15hs3H5csM?=
 =?us-ascii?Q?owA5YWISRiNrvdcfDNtRmtmceHboR29tsHO1+QpBGZa9ozvFERf3MT5la8Ru?=
 =?us-ascii?Q?OS4DrvDgYQISGeUBlI/AjXMT/BuBVcEbhg+LkGNcluL6Kq4gj2/l01U5mpb5?=
 =?us-ascii?Q?pKb/2z++/vRUtD4fDf9FryF2E5LnYmd1eyZK6XxGr88Ec57JYL9s0EM2UNGP?=
 =?us-ascii?Q?cV8l4XA4zDxIX/sniHsygb1SKfOC+s5H5ugaisf7o5gKWeVQ+XAiVSE0tF0u?=
 =?us-ascii?Q?pK0AdSK+RGwtCoBSkz8RDqiJzwKU+ThUlihwont0rag3lxPQKGaG0bVjKUYt?=
 =?us-ascii?Q?+SXRCcePUIhQQKzsgcfNZ3Tt+M88ej8S1M17uDEMU93s31DiwrZ0LUh4PaDT?=
 =?us-ascii?Q?rjZm7su8ZJipeFQfoFPnu2N2s7FUXxcB30k0NidvtRhA4RIxvHWe1Cwl2Pxs?=
 =?us-ascii?Q?RNpxa+LvOz9W8goFfSvW7skV5tpLOPQRIb6BIMNkHphvfqaKuuMOMoCRtp9/?=
 =?us-ascii?Q?3zSkJ71ZE0R/OHasR968Hf4/KnNROEJu7EBf4aqmbgT0KPdci08vFmGmhSmA?=
 =?us-ascii?Q?5m4bnxmsaNk87RqocmTegczM4Jwtyh8vQrnx7tFuHtGaChmAsOOdz+RJATgw?=
 =?us-ascii?Q?xI5ppyMVZqg1wcNIAT+PNwNAtD04?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUfKKDpFzOQMEl9QTMd0+ADDIdzIgUIUMOWDwTPjjWWzw4ZSH1zr8tgCp9ff?=
 =?us-ascii?Q?Umsf3yM9+UGAel9bk1TJg4z/NJovHH+c7aXZXshUDP+Hq66KfYVv4ti6oL4J?=
 =?us-ascii?Q?4dZVUWp8mqooumocz73ENz8l/vNjEyVhSfSBxbywjc7I7svOGwEJxqDDO0qt?=
 =?us-ascii?Q?6LwuZkIKFDJaZRN6hePImk+kBvnOXyJ87XA9gzvEcNH0AOIbqM8J/n0WWn92?=
 =?us-ascii?Q?WuluFntLKIXE955ecRlgt/elgLFsX8Qfq0bK0CFpyasBBvYaEjxneg4ujqAA?=
 =?us-ascii?Q?9HmuIifrVmnobkcYwU1CwgFeLeTmTOdoUMoSVIdF5PbDc+G7lPdlH4PaJTFT?=
 =?us-ascii?Q?hIcd7z3wSOv4gz43+kqwwaoEEcrf1bc1JJ4nSNyyIDXSj2uBGVNUPSOFgA1a?=
 =?us-ascii?Q?YHXyJ3SGWYA9+/3yoSMvwfoh0P1tus/LSNQradtPbyysNb8B6AiSc3U4yMBs?=
 =?us-ascii?Q?/pVYce2kD/bXCUeAWnRZK55UlPIiAtIMY1AeIy7Z7m42e6xOCBodFZQTMXtb?=
 =?us-ascii?Q?Gl+p8dXUPCKL+i14PfgCHmnCpPfJ6WTJGPiFkrZZYdFKppxama9wQZDtvYfy?=
 =?us-ascii?Q?mY9UUimQf6uyOeJxFE77av1qWgdHFJQ9WxgUSdEgtPO6DUWVCjvl2ZOwBQxr?=
 =?us-ascii?Q?a27F24XJ34Ni3Yu1EZ0oAN8cQQr0NN+JS1eKO7Qim/5qzVe1A+74gU1As5aZ?=
 =?us-ascii?Q?G+mkaH5ryc+1N26EVJ9gJaCCCWFAWg69gA6hYr+eHnH0JwjxF13+V8QcmSi7?=
 =?us-ascii?Q?v4uCighPEnqMfWMrssKDcl5z4Dgvawnn/fBp+L8EA9zGvvXLd2StHlxZ5tdn?=
 =?us-ascii?Q?1GJBVMfgujpKA8cSSCHA8KQwQRg4cTefYM16LQ9TFrbG/4pd3Npt7+IVGtlv?=
 =?us-ascii?Q?VdyCbIehZcj26MWZ58atwipyd/V7M8y4cfyd6YhNzzF9AhWAFl844g72Mnod?=
 =?us-ascii?Q?3PddKTc4AbtP6n2g56uN28VckhOBCGlw7qQaHr94NI1QW/l/xhAZRLLVONS9?=
 =?us-ascii?Q?nVetrc4cCqjQAmwtng7gZ+IDyVHehWMsw6cbvpIEG0BoAkUAMAkcDog4twi4?=
 =?us-ascii?Q?SOX9u4C7C7z/KuF+zKDeNkwt67uRkgM6pOOisFe6nGAV5o3xGXvKKWqzQR41?=
 =?us-ascii?Q?FKismVEMva/Fw7SSSiP/8Ers9BsLFIce0dOjswuXTef6lLJn+gpKOFaYYRuf?=
 =?us-ascii?Q?WF2h/LbKj0Qbk6Hk8s1J32oSkhaNkRbQ22gQBLRalXJQWweWGROvC0QMpWkv?=
 =?us-ascii?Q?BxKsMv52U4fxOHZ5LFoy2Jw5vrmWgIMSLqFqDDeBh/mrbtyZS6APsZ19wu9A?=
 =?us-ascii?Q?1cbvIjPurdeC4OTb6smjSe1qXEgc9YoZSrqAxpEV4ZY1yvVBtL2JCMEry+Iq?=
 =?us-ascii?Q?DHikUiBAL0Jf7u84rED9baUyh07e5ZDghBXS8RcZHxHNDmybOf1ypWL9x3hu?=
 =?us-ascii?Q?//TJfKlTv6PbzO3t3aXM9Djd8Vgq+4mizEUTBoWtg+BxLQEFpSezavPXphQl?=
 =?us-ascii?Q?sK3LWTITSMQ/BOm2/sCGscYz8ndRkZqKuYeQ7Ogld2ySwpebfNdJqMIL+L71?=
 =?us-ascii?Q?Z5LP3cXKV/sZa6qLMHU7kjS7896mbBdGoqZyG2gR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a173386-eac3-4eed-fce1-08dd4f78521e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 17:27:15.0356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Ti8ZpogRAeEISgQ1UUgy7bNKm+6bF0xdeF0L94yQC91t5zWVaUQwdPqGphOOc+ephCPmWuJCOVCAUt0VndTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

On Mon, Feb 17, 2025 at 12:24:19PM -0500, Yury Norov wrote:
> On Mon, Feb 17, 2025 at 02:41:27PM +0100, Andrea Righi wrote:
> > On Fri, Feb 14, 2025 at 04:28:57PM -0500, Yury Norov wrote:
> > > On Fri, Feb 14, 2025 at 08:40:07PM +0100, Andrea Righi wrote:
> > ...
> > > > +/**
> > > > + * scx_bpf_get_idle_cpumask_node - Get a referenced kptr to the
> > > > + * idle-tracking per-CPU cpumask of a target NUMA node.
> > > > + *
> > > > + * Returns an empty cpumask if idle tracking is not enabled, if @node is
> > > > + * not valid, or running on a UP kernel. In this case the actual error will
> > > > + * be reported to the BPF scheduler via scx_ops_error().
> > > > + */
> > > > +__bpf_kfunc const struct cpumask *scx_bpf_get_idle_cpumask_node(int node)
> > > > +{
> > > > +	node = validate_node(node);
> > > > +	if (node < 0)
> > > > +		return cpu_none_mask;
> > > > +
> > > > +#ifdef CONFIG_SMP
> > > > +	return idle_cpumask(node)->cpu;
> > > > +#else
> > > > +	return cpu_none_mask;
> > > > +#endif
> > > 
> > > Here you need to check for SMP at the beginning. That way you can
> > > avoid calling validate_node() if SMP is disabled.
> > 
> > As mentioned in the other email, I'm not sure if we want to skip
> > validate_node() in the UP case.
> > 
> > I guess the question is: should we completely ignore the node argument,
> > since it doesn't make sense in the UP case, or should we still validate it,
> > given that node == 0 is still valid in this scenario?
> 
> Ok, I see. You don't promote the error from validate_node(), but you
> print something inside.

Right, it calls scx_ops_error() inside, that prints the error and also
forces the active BPF scheduler to exit (it's like an exception for the BPF
scheduler basically).

-Andrea

