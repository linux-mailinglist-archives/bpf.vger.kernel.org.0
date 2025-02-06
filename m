Return-Path: <bpf+bounces-50703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6628A2B6A4
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 00:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C385B1887CC6
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2622CBF0;
	Thu,  6 Feb 2025 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mEEDcZWA"
X-Original-To: bpf@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCE42417EF;
	Thu,  6 Feb 2025 23:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738885150; cv=fail; b=R3UFA+TNPBGIXTJJrLxXNhRC6fL9cjTTH0x+bnm+oSSRBkaTv0uXvi6KmRmKUxfaOl4/z9DXbS+/3ylWNYfTEx+1EozOyr6Zph8J7KFaBbGHjNFDpZCCW8QjlDc1o0bdz3agpWpWToQCN5lAP9HpltL6BrlM/DpOoaX+AshwHBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738885150; c=relaxed/simple;
	bh=saTlSIfJKWFP02Hc+StwNdiqWJjRohNxTIgPj/RNDeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=evxWbIFNH2x2XnD2BSjNUDGKU01c4HWeMN/iUm8ft5I9HKOpkZXPC2Yz4EdkUknDqDvcNUkYmpStEOGisWgTMnBgO1mA/V8rCd3/6I3EH/P1Esf+HG09gFlfkVk892rc6zalTy/UdB+gAQazAQLbD4Nwp0tHkyaSViwO9vaKXUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mEEDcZWA; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZdcQk8MssOmQPvS37vlkORif4XuzcdJEhZy99avvh7gjDWdYC+YXfjAdEuAe/9CEvqpp6VccCKxfiuIMYe6DACtpyPYoZv2E9KCBEsdjGfaed5Jy45nTYDjf/5g8BXDBWTUbUE8lt7fGgRAEwls3HmC0pO+FI8hsrKWcOlzxHCIjdiBR4cdd13zxel7JwHMXGiPw+a43nZsCjzfhR4pMQ3mAT5TzjDL5JSxlXW1fYhyfB9Oxq/AwlHMqeZ5q6UqTkjslIei1GtSfwhnYUlXfR6Ea8DxMGgNqZ79Q+bW379arZfyB/3uDnHpWSETfVhLMrmjVPOfo/+li/Q8zGMC5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MkL5dMQYKqc/mOG9OdWw55x5M0GSuDUpxUl+K+Clo4=;
 b=XM6l4INxWEjzSRsgDF76Z142/oiwC7Y3RhKsWz062wUAXwlWADpPIHEh8uiMnpKjG2Ka0GZjPkSE5GWpnyg8I13itpaQzs4hG1rLRTxnkTAeilOHM3/kRCel5MTStYlZ82AjO5cyugfpgSI/8dCrQ0bnGSFwSiXu19kRrKrwZtq6D/VlcaUmMvG4WcfVp/4CcoPoii2Z4QuLJa8PlOEeytGXV5QAySSI0J3CaZUb+UQjy9EyhY8BfN9czj2SX4+YEgAk9Np173ogEqAsKFW5UBjCdJrZiWV1lPrjBBjwP3A2W2bpzEJZ2ssVkaKKnP1MzmReAqHrssCfXF5/Cg+pPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MkL5dMQYKqc/mOG9OdWw55x5M0GSuDUpxUl+K+Clo4=;
 b=mEEDcZWAb2MzI5dF6eAjP27Y+w4pBvXBiwXIkyh0WPUEpwdkFDkfCPnXI5kW2UzUcDz/rHtIDTnQzJpTpexpDGZi6w/1XGP9xA2njQSEBCfze9m1UGTSyKH7B3WXxEIgWEczBzpMgJ/j2BkcrBq2AfUyi1phrs9QM54mvXMkTjsDwGbKcmPFu7EtVtS7A3Wy9JyZEEYY+syrBWTdtwAymKzMVWlXE0rKyBCvfBoJHHnCQFlo6XhzW72tL5I7uGnSJTADpTHrDktEYrNC8U3uqhtCkZhQYHJe6gy/CixvOC2NDvwekzsIsRL3B/W70VPFEjgyfOQq+aj8tKDxvGZ7EA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by MN2PR12MB4454.namprd12.prod.outlook.com (2603:10b6:208:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.10; Thu, 6 Feb
 2025 23:39:05 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8398.025; Thu, 6 Feb 2025
 23:39:04 +0000
Date: Fri, 7 Feb 2025 00:39:00 +0100
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
Message-ID: <Z6VIFPucwML5YLSJ@gpd3>
References: <AM6PR03MB5080261D024B49D26F3FFF0099F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
 <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR03MB50805D6F4B8710EDB304CF5C99F72@AM6PR03MB5080.eurprd03.prod.outlook.com>
X-ClientProxiedBy: FR0P281CA0260.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|MN2PR12MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 62947cd1-e35c-49b6-0d15-08dd47077126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YGcqsH4lkg6X6E0WndFq7WypEOfQ8SpBxtmOrcHpeFj74nXHYfEiethkXlTh?=
 =?us-ascii?Q?P5xUWFuVf/YJcHXP+4Gs0NmAU0x0P4FDWg2mJoctKvLvT1hQR0k7ERIqUVlU?=
 =?us-ascii?Q?eYOTEqnHFJl23OTyjFc9DqTsh/y5anyiB6xkJ53V/Cik6XzyWenUPt0nl6ZX?=
 =?us-ascii?Q?uiGIYonY5LfV2QLJ7hIoNzj2JpObASYthslp/If1SY6RNJGu3UtCOKOrspUJ?=
 =?us-ascii?Q?gKlgaJiZJQNk9tkhJOmvQfnxZF6pjUfMM3AzOZiffrnr9kkSLIoGQ9LBvCNS?=
 =?us-ascii?Q?ueLARt5NFUo9ebIQFAgUbDdLagIDSM0kh2lt33cgQFI5z0PqTm+4DHS6onfE?=
 =?us-ascii?Q?GiaXoYXeuMQFP6T9E6dFbZof46MrpEb4K2MTi5xNiBwy0r3jIhSX0XODstf3?=
 =?us-ascii?Q?czM+IdKTj2GZnssIX3KZfcyalPBvmOBu+4tUsQhphkHpjR5rXoZk97rg7YAT?=
 =?us-ascii?Q?afx9DjN6Ljg3rgA7yg/XTO25b27TrtiZ6jAxGDXD0dVChvPmO5VO/bDPL/l6?=
 =?us-ascii?Q?5K3crNVrSHN7MmnZl8cWwXYNn0Ga5PHx+mM8PoskVZetQ6sfQC8NrlkOR7+P?=
 =?us-ascii?Q?kLfs2F2EpwnWrk/tObZ99YwORFgmJm/ScOS/Wz8zC1khRF8d/2UdhKJbcctK?=
 =?us-ascii?Q?2c9obK+7K83YaIoPMi/xIcaiMqg4B0rZX93BHjyvJO1H6b704wi6SP/vwpNn?=
 =?us-ascii?Q?i04E9MuJF7mPk0bzDKBpHoSCv5Km0x/UA97nnLtaigQEzMJJhhz7qAUk6MbZ?=
 =?us-ascii?Q?QvgyjR13tun8gqUmSeZG4iwCa3H5EQUu+4sIlCaJ7hY5voUSAb77nQFs0Ahc?=
 =?us-ascii?Q?H8AGsUjvAJbBfTH3irWvDyLBF0qQ50t8nQgLJVr5isGRmbDLDBQe4EXiyeVI?=
 =?us-ascii?Q?j914wcRJKa3BQ0aTSNSGCFoFeBsHRRAVN/mrC5Zm7ufHzlMiUYeEur0FYxNx?=
 =?us-ascii?Q?MhwLeorP4CGZ0IQZpr22XFmcFNp1dn1ulWg9tdddzjVzC1oU8r3WviaL6afq?=
 =?us-ascii?Q?HjHM9C7IFcy4jKXpNSDf4ODlmQIwpToBNyZfTOnX4JnjMiCq4rHccAOLhWaB?=
 =?us-ascii?Q?SEWMIgBEgEPGJBFzd5IoJclmIrIAmS5RT3DyYuzKORwdWjIqX43HFHf/Z4xJ?=
 =?us-ascii?Q?RFZzs8TsxTitovtQA31PhL2inY80WUlT8fi2qfcfGnqWtff45Vm4gD+lmzN5?=
 =?us-ascii?Q?gSYfOkpgAGqhc1061mnHYr5WRDSdWfY9A23ZXeJxtkn2f4nAvaDINFnT9MoL?=
 =?us-ascii?Q?MN5EAe2F4EWiOsLGrHbLJ8WGkAtEuqEgkBmgyfscZ8CBWgJG4crKcP/DOszp?=
 =?us-ascii?Q?7/BZfFoyaUPe1h77l7sV9tZ6Pbanm2s6A7LApL+0gKu3JiX9Ca0s0dNe77jA?=
 =?us-ascii?Q?BwScNGTlspe04fOJKJC/ZtFfTqK+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YLvKZgd5GyIvESv4MmYDrQFUqZymZ6COrbirLSgVb5FQnKBwtv+Uxm7Tt1EM?=
 =?us-ascii?Q?SCkCCIiEGONVoODxbYNBsOZQnpGtXchBYXfd1+N3Cw+etLf5279rxLx8BM3k?=
 =?us-ascii?Q?gTtPUh1cKO9sieQIcXHWnqhPao4o+wCb8DWTExUUg1RzMFgzC3OxvorweoQD?=
 =?us-ascii?Q?3hI55K/4YF+Y7xx0DdyiiUFU5/uFaB86KHWX0EfjoFhAdgDQ6MOvM01MhWo5?=
 =?us-ascii?Q?da4dlUQBlgz8YFFUrK8KgbnFMScTGQbitvPQFcHq/XZeAL5V99eOtErF02Yj?=
 =?us-ascii?Q?/QKhfzQMMSHlIgPdMQdFOP83hhC2Gt3aYztlxAe/h181NNgR1YDHG+fNg+Ey?=
 =?us-ascii?Q?MsihB7yQdbIRMNYqiJwSvPQZJwMNW+k3Px7P3gzOHOaBHwLLR10B5lvstRhH?=
 =?us-ascii?Q?ia1iCE//QCgue3bvlG2WizWQJS4+lraMNOrxb24jzAGAXGPs6+Tix/s49ntv?=
 =?us-ascii?Q?tM4X6V6wa15ImMSeZOlwEQivBdqyovbfLmmePR6Uk7BiyuaK/DQE8jvqTIFf?=
 =?us-ascii?Q?OiRleadBl06iXLI7LC5bMUTOsZtQdENecZXJhuosgdCiyTxFQybWIq6hSODn?=
 =?us-ascii?Q?C2tPtENPwogPDc9RYhwXzLXx5zIijeA3YRjZObXfnHf9t0jfBY/dEoFUdz9A?=
 =?us-ascii?Q?e0GdVPlKBYfoqpJHpZZkSgb/LVrOXAQkTLl17c7lXZ3Ud2oXftxsfZS9P53f?=
 =?us-ascii?Q?zXNa1QUH9/Rglck86zVFfIqeWefPInbh25sJBhWScd4vfJf02CK7QJZMqvzS?=
 =?us-ascii?Q?JwXzEpnn+O9IB8knDtgjdPlfX0f7SfY1uC1SdFLgNqdt8IOJ0IICAovApDUi?=
 =?us-ascii?Q?6Rp/l0akHNlLB/5WhtC5iLIHQJ9lYfZkEy3KNjyvmWEE5XoidMEK+xh7HWZs?=
 =?us-ascii?Q?QjSLK7W07a8hiaemRzOYVdQXaxpsFzNbYjhFOiDE2mdp2ejH70wAZ/EHteAC?=
 =?us-ascii?Q?Z3eL3YxO/dsE4REteof1cPzHsYYKuqHczl/OOj/cANH1hz+EgzLAE5tSC/1T?=
 =?us-ascii?Q?R9J2exAiS+Afxhsp/O3yM7PPwPupVlPi2PkAjGsFUhZ5CNisEzve7OuwimGW?=
 =?us-ascii?Q?nQnc+JZQvmErtY6RKlxup7Ges7hjW0jwEnAdiPnoPZhThugys68utoBj+fIC?=
 =?us-ascii?Q?LBbgYQFaTPxs3FokWjRYF7nzVWQRJT1JhBjfucb9wKGnHbqV0GEmYN3ss9Xm?=
 =?us-ascii?Q?DPtjgJyE+l1rhYr7HJWExHsJ/or5uhhr3KNwcRXLSHqdluyJ6/OZ6TskG/zz?=
 =?us-ascii?Q?xMa2eR0t+HpzTIrB+G87NkE7iX2p2Lf+hcIoiWj+lWyXkpIYyQIblwfWL/Nz?=
 =?us-ascii?Q?y/u38rc0Qrlc0YBAsBEU+JyRnXkqJMGSxZcD/ntSNxceante3cOk2xkDLmiS?=
 =?us-ascii?Q?VA91Z1Gn2S/FaIvTblqN9OMJiL5h2dM8Mfwy4k+0i2upZWYoK5culgBAAtGL?=
 =?us-ascii?Q?oenNoNmh8JvAfXMJtvYvAyb5zs4eaXGSo08tDfMRhxPx2YXIXbU525w92kcN?=
 =?us-ascii?Q?Wkrv2pdNUKI5mr9LpWsivL9ThKGV32kC9B2C75Lt4LJxAcmFVM7Hf9CvQHNO?=
 =?us-ascii?Q?eDNQH0WzqDirU/nEFl7YF7pBj6koLyGcBfZc3/sU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62947cd1-e35c-49b6-0d15-08dd47077126
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 23:39:04.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 10EyPKL0/fHNfmoWoVVNetxyWKRycAdvBGfx+npT8Jvcwkv1RpB/HnZYob5u65nX4dQzNSgnnsYexrxEHdv+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4454

On Wed, Feb 05, 2025 at 07:30:14PM +0000, Juntong Deng wrote:
...
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

Actually, do we need this filter at all?

I think the other filters in your patch set should be sufficient to
establish the correct permissions for all kfuncs, as none of them need to
be called from any rq-locked operations. Or am I missing something?

-Andrea

