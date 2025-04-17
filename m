Return-Path: <bpf+bounces-56100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83357A912AD
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 07:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67D0C19067B0
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 05:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3751C84C1;
	Thu, 17 Apr 2025 05:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SvVN+C46"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EB23AD;
	Thu, 17 Apr 2025 05:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744867862; cv=fail; b=dyAggMHUmGD9ss62fvea45zONTTsJRdI/oQJqA+slVnsj7mIPU3MMg6gyCgqch1UPB1t6Y/5TnaIDKs25cdCY1+ghtu8KkNNg3EmogGZpaHl4DoSNc6v6mFX+ngDFM5w8UScJGb2s/KuZvdZp+jlB+flofEmiEHjcAeQkKjlkC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744867862; c=relaxed/simple;
	bh=/1aYKDK8pLQLvWVQiaBaMXfXXhMqg+pLABYHEKgVRSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YL5ScQ40Y4F/UIdFHfeRFA41p8hdojgX2WyUG3iJ3pVRD1xUr0ybaA9WlhQnspQRKBAMfiHvgiPKWksOFcAJQZKnetN3Fi8NlMMeaeCSczCVX2l6l/0H5+eqZByam174OmjBUwbxH4smDd/0i7D3OqhWzT0N677dgr9boUAc/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SvVN+C46; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCCuHiwgxOV2iJoWbTYxFZkt77MVZVoaeokWuQ6QnyRNuiJutTJ8etseGu9yck6vryqc5z+OqR6VXGad0FHRKpJ3fADJOMbpV42Ty25LMiT2V9dF7P7TUqXVnwDbbtJzatFuXaxIfF+QJhGJ2xgckVmL+NnM5MrKKF7giRfFU3HNHe6D9RSz5DtDENOMXoMfRWhmnjEVAEf3QDeL+jeS6+A3LQ9Vp9t3lkYQ2HVLwdvQa9JHYVyhSqOX/dZ5TRlHsrVteICSlG947bV9W7XdckJhX+I9Q2fdBl6HSTsLbta0X50xsxP/TZyghzN61duqQ8GlDc9Z8wGRnDx8EfGdcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ww1iZgW6WUoFSMrG/uk3H1DtXk6oOSc3CbqT/G4V7fc=;
 b=su30e549xCHv/8kzouydSD7f8+dKt39h5og2C9Z1OiRkOlR8TaH+cqxktORR/nnms3/dCLIpacBhaVm8jCPmEubM7ifPBuPOqkpvWcfM2g7hUAjnAF+pRyQaH5LcyHafljVN8l3LGBg3YSFCRPhgw/IVGMYDyqBeW3kymQZpNIs6iyLsfpogShp9LClT8/OmvJQMjm66f8XrBVba87Ao10qWr0WYhh9mH5WIiIKK+JAkuvE3D8owqQDrc7zkpwCFhHmeZslJxWjvLDIiw69g7tJDHK1c//6KcCS5fJmB6PiuTXWo3jtEhXOC7fOJ0hqcQbfNcPXeYsA6MV+epwQq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ww1iZgW6WUoFSMrG/uk3H1DtXk6oOSc3CbqT/G4V7fc=;
 b=SvVN+C46uPZ6Mrtk35QQLOsz+cK3fNRmnqs0HYTn9O+ZmKxpm7R94ulXIxkGi5kKCz+Q1RgBjMXTQ6IM/LY2+sO8AdRcu2WYLldGLh7hlnNMqWpuz84CuhXfhQ53job4rY4F2rKgcVGlcOjDh4c1M/Qky8JNJNy70ScjDS5OitgxQsLtKoj+P8OqzRTU6owRdIsA8/+7DGWnEmd8gPOwHoS1kXvPap/Cdn3VUmUjcvyCZGoJ0Awi1ksLlFqEoBVpD4ox9VpP3F3vQFXswo/1k4POES9RNsvqYow7UY192YjcUWmU+ej0ul/OR48/XbTdmKSdElyGoH0KxD87JE6ASQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DM4PR12MB6375.namprd12.prod.outlook.com (2603:10b6:8:a2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 05:30:57 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::66fc:f8a2:1bfb:6de8%4]) with mapi id 15.20.8632.030; Thu, 17 Apr 2025
 05:30:57 +0000
Date: Thu, 17 Apr 2025 08:30:47 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	m.grzeschik@pengutronix.de, jv@jvosburgh.net,
	willemdebruijn.kernel@gmail.com, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, nhorman@tuxdriver.com,
	kernelxing@tencent.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, gnault@redhat.com, petrm@nvidia.com,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: add UAPI to the header guard in various
 network headers
Message-ID: <aACSBy5o8yCuujTz@shredder>
References: <20250416200840.1338195-1-kuba@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416200840.1338195-1-kuba@kernel.org>
X-ClientProxiedBy: TL0P290CA0002.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:5::10) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DM4PR12MB6375:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b7f7e49-90dc-459f-1d05-08dd7d71079e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PYRIaEiENiABa1MH/1DeUGHkcntt7OivgKLDqKHCvQm2z2aICBOVTlIUAZ9O?=
 =?us-ascii?Q?9oYq8eDKlfLajkI94k+H80efeuZJUORK8S1M2FCHR0m/QOZQkNKUTuO/LhgO?=
 =?us-ascii?Q?QQqvf2XtAgeTtiofhigOX0D6GaWqKai+Ee1aaNZ6s61l0TdoPf5gQsjWniXc?=
 =?us-ascii?Q?6BBb1pt7x51D8dlvCqFGbv/SYORlVa7r0OZRY62MR/wEmY/4rU+CZCnjA+Os?=
 =?us-ascii?Q?RVlL0Wr+8jBBe5Lp90mX7ww0XRC2RXgRvRs51PQlE2VI8NAdfXXlM/ms6rEp?=
 =?us-ascii?Q?+AvtMrmM9GZ95Yvfp/NWW7CuXAh9cXbopPelJyF13nDOwDnXiLbt+ukENgQU?=
 =?us-ascii?Q?UJ8RVCd7ahinHFrKFEfazj5gF06KNt0fJF+JrztOYzgi6CORnN0Fj5TsLb2e?=
 =?us-ascii?Q?N1TxvA9smzexPcSPnO9wTjM0STvGLvLuZjvLxnq+yVsrrLI8hta7IrB5i9C7?=
 =?us-ascii?Q?tY2c7ne75OUKTEe20QBNSu9W3/LID3+wPDgCz5IuhIzbASS2OWZj3ICsTGGi?=
 =?us-ascii?Q?q4qnAAAjjsjGacYDbFEYGQ50EzVgpq0pgeQebuHi3Zp1Rxxnitwya+iccTcb?=
 =?us-ascii?Q?krIDNX/9ny/S8qiOTqcAmSDSVh5BTzuQuXZOSc20AF1PnxKLTLmrRajb9mKc?=
 =?us-ascii?Q?tCxQBb97rEFiIYtG4UPcVYmDQIW06KKUJfzQly/x1rhNfCVIQeAYz7U7mcuu?=
 =?us-ascii?Q?SVhVhOqaLH6BIV+jNAcgbXGWLxwRk+c/f08DLtw0q4VC02JD8JaTfjKutayU?=
 =?us-ascii?Q?zjmFIeltCT/eXe7gmBpKPpiuywyKNn9eQt1DTRnhtVLZkgDqpYo2nZdPjtC/?=
 =?us-ascii?Q?xeC7Wh7Peo5L57f6vvdLOXzpxlVLbtGF6PSwxRkq8/wMDSteJY348LuZVdNo?=
 =?us-ascii?Q?sm6+BkewxpLgoJfsTCBcr7yI2iJcEg4BvaDGxcnsQSXag5iSLh/4XMJvVXHV?=
 =?us-ascii?Q?1I85wstIoMEENOeLyjqNz6n7iVXA7W71+QW6WrIId6nah3yINOGHgx/W/5vO?=
 =?us-ascii?Q?/tnx53UT95e4PFZ+zmBLCqPzJwLQwE4vpon4qFPyX3/jp/O3FZkhp7mflnoR?=
 =?us-ascii?Q?c1aj7BKz4b1HXoaNmNAnSHLbI3aH2djxcXm27HB3ksTu2iZqYuDDfXYk4wH4?=
 =?us-ascii?Q?ytgxiXWGWpdRc8d/dG8B2rx22NuivQwr5V/pVxbvsIBRpMtym/p2yfz8hFUV?=
 =?us-ascii?Q?CndCBxU4m7bTsrNR+hZouXHlOdy37dtGbRXHiP9Pr54Jqm3ROYBLLr3jr6bd?=
 =?us-ascii?Q?Q+x3YzQGR2Hlj6TnFgKwe9pAYviVWEL3D8l1zDDg87H3A0AsR1JtWjkPeEqi?=
 =?us-ascii?Q?pWF9mh0ZqvQby9GsK9bz1kkwOhCFMuZtjlsa8kkleWp980qmmU9nKEn/0jpp?=
 =?us-ascii?Q?cvagqhlvkwNmRxAjoyq9Xfviknbg4JblU0oXkqDVm+Tc7KQuCbEtAo9zK8wU?=
 =?us-ascii?Q?MwPZjs3TnqY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7g65LumqNFDkbFHGAUycWEfepqp/Ba/erlgRbJrsez2q8RvWnFPw82V2lpwe?=
 =?us-ascii?Q?qhrEEJoDE4orPSUsKk+almLiWgyB1fDP4HOCJ47YAkZLwbHwgKZvjl1PbLuC?=
 =?us-ascii?Q?4jCM5Ip0bfAOX4tFszrGHIsPSOYz4Tcbx051fptae74xYlv1hLIuwiolk8cy?=
 =?us-ascii?Q?ZSGT60jTP9Ssb3PW5EAXUxhrfP+b/ylUmhMb+gqN/P6b9wsw7iORDVQJNwRR?=
 =?us-ascii?Q?P4ytz7PcuF692GFTIekV89bwiW+01WhJlR8/B72NXUVOSHFPSZpy8ecIEYWe?=
 =?us-ascii?Q?dKpz2UTVOjxsYKFEhNK8ULH8M2UULa0gkFWfnlFKo35oPj+oWbUO+kXUif7p?=
 =?us-ascii?Q?wW/TdI2NwcDO6Dm+a6fUn07Pszy6iLwTFbPvuPSSMK4vlBx6J95HKBIb9pPd?=
 =?us-ascii?Q?0YGBDBMW4xKMyi8IJdMZncX8TILj4riyAwsKe18cs4LLseNBqNHTq15idVLy?=
 =?us-ascii?Q?mp+7KztEGz8r4wrV8LXnF3FRMJHZm3Cg/9eAxjW6XdKAku9zrBrkdk1DuFXU?=
 =?us-ascii?Q?W+Gfmx0ibPog3fN+FHcC2MNbLwghLQmvUI9qzyjwkIuULNvi2jb0ApUenMrZ?=
 =?us-ascii?Q?vV2QClhjpTEa/+8Sao8JzTy26pTFCxmxQ2QojDl1NW8ecg1z38IG3M0lwARr?=
 =?us-ascii?Q?TF2d53ycAX3HcOdwRZTkxvVlRfTCp8ngbpWXrnm/qtJUYaMlnvA4VbMBgkiw?=
 =?us-ascii?Q?42UQrbWdeOT6a+8pPIeXCHNNeWVljp/clR0Zc8RBoCZbhwrfnd/fzlNS5vbh?=
 =?us-ascii?Q?oe2Voy9tCGYN5YqB5AoI028SP++wYo62XOSmP/8jX3sLlN7slbmeiYOsXZ9F?=
 =?us-ascii?Q?23nEDbNQS/g+8VKigVUxmJOCMsTP1QEK1ApflvmxZslFo0cAUQE+UJ3mkPPo?=
 =?us-ascii?Q?XF6i7mOu1vNniZG1khoKFt0nyFCosqn8bDHjf//aT2lfFMwreulIfcKTbdcW?=
 =?us-ascii?Q?HTUY0aLgLct7qLbDRy3gt1DJ+eG8tc8rwGWXS+9pI7MY/oX+ubaGhufJ2i84?=
 =?us-ascii?Q?PTWYi7M6/p6ngbwWF0VKzZYE2psqP1JAwUL4t4kFazSYL7z3lkuN1XBE7Klp?=
 =?us-ascii?Q?es3VQQMv4zdl4JcG8BfywyLwH2M2YpvKuFHUUV806ncGyEjEzjQRLabflJ7Z?=
 =?us-ascii?Q?Xc4VMBaWjHjR1zfFndHFN5HwpNNWeGcBDTF22igz8CkfreVDxEOU7uRX/ehy?=
 =?us-ascii?Q?BTsjOwyu0YdRtGJxvqTMsNbK5bSgMzLKXuA5/SmW05s6vbfFMA5iFVVd2C4f?=
 =?us-ascii?Q?mQQ4fYoc/DoDVR/smVQ7hePW5QwgY1PGx9DD3xcq7CIYejZHaEH+A/3CCfi1?=
 =?us-ascii?Q?fkgianu6OHvOxWDTN763q6i+OrsuWvuX4nDQ0MDPC0c0rtQEg0SYFBxLIvd3?=
 =?us-ascii?Q?B4pY41sxmo/pYwIVUh99bcUOiaNQammv6PkHQhG1LBJhYbHfuSI52Wxw22pQ?=
 =?us-ascii?Q?9+kiVswMbwbFsyF7StSLstjAgemb4vPGLzRHlrtzvsIZJ5jS3xx8DzMuq6Yz?=
 =?us-ascii?Q?GcO991Zs1Khq5Md4vxzL/EHod4eC7M6fDE5T8SbARQ4z9oyIJWeDoTrPv/JJ?=
 =?us-ascii?Q?IXomb1E0tsVcljk+NXec65Y3yo8xqD/RufHjirNN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7f7e49-90dc-459f-1d05-08dd7d71079e
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 05:30:57.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4cyJokrZqFBwgA5IfWEwHqaTsyHF3XvmNZ+CCYdmXHiUQxb+dJMzeR1ciUBr9w10frcOP0fzeUSD8pP5CPSXDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6375

On Wed, Apr 16, 2025 at 01:08:40PM -0700, Jakub Kicinski wrote:
> fib_rule, ip6_tunnel, and a whole lot of if_* headers lack the customary
> _UAPI in the header guard. Without it YNL build can't protect from in tree
> and system headers both getting included. YNL doesn't need most of these
> but it's annoying to have to fix them one by one.
> 
> Note that header installation strips this _UAPI prefix so this should
> result in no change to the end user.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

