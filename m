Return-Path: <bpf+bounces-71395-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822C0BF19BE
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 15:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAD9218A6C68
	for <lists+bpf@lfdr.de>; Mon, 20 Oct 2025 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC2E320A30;
	Mon, 20 Oct 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JehUM3Pr"
X-Original-To: bpf@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012003.outbound.protection.outlook.com [40.107.200.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92F73203AA;
	Mon, 20 Oct 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760967869; cv=fail; b=Ik8dcObKJ/uWBefxrIS1GEY0kuhuNiHq2EasbNPx6i6d73itnMBApW9jCzEkYtDhaEzYsV4zjl1Gvv1/kaQPWLTfVFAV4pTKgn1vveIHEHbc570d7cdjMZFiEqlgoWq/4HmJGnKJUb48I7DOkckVsZb12NDGIXLCyFxkw2QgKY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760967869; c=relaxed/simple;
	bh=nhccl63rYNlClAwu/CzH+FHSLpvOv3mpXewnFTneWzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SgMTo6IAj7AypFkvS7JESumz9CnOQ14ulgW50sUQfTiGoHFngzW5ufVa9oiPkzdGmGr97GFc8XGZcEaxU5sYPpx3rTnVc4fujK21cqtOIN6FgAbwqJKeBT3Fsds7At10I8Ri4/pYmCq9uW7L/K3K9SByCRvpWK24I5Fiof6ClLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JehUM3Pr; arc=fail smtp.client-ip=40.107.200.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtHKoS8mL8nouC5e7XmzyBn1oiXn62ciaOymaCVjPweOLv2UkBrOvvoKdjcS4BFny0cr5Xqvg/fV6Lvn7hwthUBD8op+KFHIMnbfrbmHbdpWCG5yfOWvqGJ+tbOyggcXVNdUeMWuDfS8grO2W1wd8MhbH8aUOjboOEVFE7ed38+WoGXF9+JIq5q2/gSbEe8WXpMYhF02Dt74Ve4NPJ8gQZKvmvXarh+nwVkIj7EBlS/pAWbtY88p+3btLy8TbwPcPFxt/bZXgM69Ei99k4gIX3lO/McjZQfF5krHCGCRmOwZ2TAJFy9cJqGupnsZsktzpRdin6YzAON3Ab8wgpF+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5gSsxRGuC5jQqWw+C304LQNCWMs0hF+F7s3Ytxz2gw=;
 b=F57jRWPxLJePrd0rB5gIfL6UA35SCuF+xFXYbeIuD54QMzgl0owx3lUVHkU3GuduIYmf0qM5v9UY1QYRZGwqVyiDfh6Sl3Mlntbqrqj9Khc7JEKTRPYKGuoEuIO04M7Kp2CIOWW/r6S+cu/rzhe6E0ai/XYwgI4uLmZJU5j7rLCzCWbjOKpAjqSPM8GrQsM/tFJKd0NREBr452mAxPrQOiLHE5K+mCPVKAc6chkD6O4K7CD+yWuleoDNvqi52uYHpX7sao1gF/rnVGvqYRzJjQIk6NNayyjc50y6khuWinBmbxjj5kMlH25uAlespPB/aMCa2w8I51Se4FiA9p4GoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5gSsxRGuC5jQqWw+C304LQNCWMs0hF+F7s3Ytxz2gw=;
 b=JehUM3Prvf1A0WNKh53bhYn5+qONQ0L1xqWnepHrhVi2cZ3oRDdk9Wq4oMd+wOTpfPuwjuyVrS4HP3cq+DhOgCwfBeCh09+yNxmLDODY+Wz7j+dwDXQAOf+Rkkp50qO1kiIvop6WI1W+xRoswJ5DjodoKsP87IYAy1zNlCxsdQXWyXMOpxZ9C41ygG1z5JtQvMByPf4u43gS9aaaYnsOp5gPTOhX0FqfFz3IGa6MMALopbgOOD80eaL3xmzC28xYCy1hiI+i92kwVYus/3RPlwRbWnteQmOtpv02dRydW6uhKAqGYTVRTa71lDxiK3oiMCt9hdHEy1R4KVqINwyK7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DS5PPFE52C859EE.namprd12.prod.outlook.com (2603:10b6:f:fc00::666) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:44:22 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9228.015; Mon, 20 Oct 2025
 13:44:22 +0000
Date: Mon, 20 Oct 2025 15:44:14 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Emil Tsalapatis <linux-lists@etsalapatis.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] selftests/sched_ext: Add test for sched_ext
 dl_server
Message-ID: <aPY8rjLoNfCDr9zp@gpd4>
References: <20251017093214.70029-1-arighi@nvidia.com>
 <20251017093214.70029-14-arighi@nvidia.com>
 <CABFh=a578RNXxjtze1TxAcPBkx9_M58qBc=6E4o-uFJx0DB4Jg@mail.gmail.com>
 <aPY3n5vIlzfTZMru@gpd4>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPY3n5vIlzfTZMru@gpd4>
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DS5PPFE52C859EE:EE_
X-MS-Office365-Filtering-Correlation-Id: e9e43463-30b4-4d25-bc6b-08de0fdec69c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?imKGoo1zijO0sPm1juSu0VAMrdforah174tFLiM2SvBsWIYAB8oR7MDGV3Hc?=
 =?us-ascii?Q?RjBi94o3GLTduebpIxHxbhW9s5NJNIPyWcVzFeRLj9RxvfqlB6HUNu2bqVfN?=
 =?us-ascii?Q?UcW/HjKEpgx9mZ5Bp/nA1BVvvq2vqLh69zFbGhPg/lnxBlqjwJZRLy9g56Hc?=
 =?us-ascii?Q?fH6bvKc64A4aGdSijk9lKpZ7GDTmRVm/6dNwv2lMNl4WCOaazaBhosc1wcbr?=
 =?us-ascii?Q?FMEyiqZIKzAAfq/q865BtdCrr06xclHmuJB2VYcqZJu1zDpfTIfxvGccSHZM?=
 =?us-ascii?Q?8O949Y4H6nwv/LnS1Jg3QrZlP2e6xoNYORUz3v/QVa9hWhgLE50tZtDVyJbH?=
 =?us-ascii?Q?0m75oxJpvCjDCfHsbUPJa8/DjHRqTKzzh08+rUIRzhjRamPnQBSffH72uRaO?=
 =?us-ascii?Q?332WyzjLJ91dHZ7RhPPHcoyO2Bj9LE5rFlgTMVn5MiZUN1AMLESxrCwT/XBS?=
 =?us-ascii?Q?75dJuWBc1oyPj6JUw4pO4njNF6VBCz7S2vwAxl+baYoWQ6/cB5qeJvnZHBlA?=
 =?us-ascii?Q?ur+iZuy7C4zu6wZ2Z9+CVu+AGRMR+U9TviZDQ1DfvMw7vuVUf7H06IygxpTE?=
 =?us-ascii?Q?KKgknxmxKvjemyVsrI2QIzqbnMfOSIODdhD+NG12/zfaTcLIzu2WMEV9CO6z?=
 =?us-ascii?Q?Mmqhojr25P3aJL/kRd9c2ro3DJ/sOdckcMl77dzWeVZwYJJWDUPRpuGqsuR1?=
 =?us-ascii?Q?zbyyCzTykgW/e3yJX4ncO0dinnxlqUVfkBRpLEHVK+STU+s+/nR10D9WmPeG?=
 =?us-ascii?Q?6wb89j7FLdOLuqOqYaInDI52Eki+uYzKClKDHNC6FgmzCwj2Q8q9qyi1IQMn?=
 =?us-ascii?Q?TQYymY8Gy6EXzP5UrJgODqUny71Fd+5alP6joSpRCjrIkmL4N/wTys/p8UJV?=
 =?us-ascii?Q?I+0QBIetLQTFKKEP09Hb5rv/Y1uG1MuyvdxBuPylImmQvkUwvIEZs4T2UtSF?=
 =?us-ascii?Q?YE/fOZO85WCqbySxKmrzjas+rwnOGjBz98GxFKJemJkiI/fMriuqQJH/IoYQ?=
 =?us-ascii?Q?RA1uZk7pczIzZjzN0wUuGjlVcDw5niYXWNj5T4azVaBMrBxB2L+EyFHZuT8D?=
 =?us-ascii?Q?KWh6uvviJsB6CbV6UQ+H8GfufyOGl1XqhmKSpETDA9gUyTqwHWf2VMtEDDcn?=
 =?us-ascii?Q?jWH/hxqMpybSzBF65bPwc0clXEpJZWRKhVfzdsX1Rr/5+zmqoykvcY/lZZxp?=
 =?us-ascii?Q?45Hmb0JvEWAqC3kgViyCrlWUfQpslE0RSXf1P43VcjUiJNPfo/uNlZe0zaQm?=
 =?us-ascii?Q?Gi6y9FHLSygOUy+rqNnVx7xfOvSN3zO34o3uLfNhjecxR88JJEMFOkNsVOgy?=
 =?us-ascii?Q?N7RJ3CxKR30ZuuKriOp6e0WPb6A9I1C6ENYr5lXOsH+joN/BWpaS67vnaSD7?=
 =?us-ascii?Q?jDvhML+R/H4Xqifpxw7006rogDMgq7q2+n39YrFHhZqYUWBVv7RTR/cA9xgA?=
 =?us-ascii?Q?XPVyR0yzaJItU9rNQ0NsuoQ9iV2qLvKZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0p3qLN4bccouIWCL9gAYCh5FHGAWw+f1r6AI/4u23jkyX+j7/vMMcXna8mSQ?=
 =?us-ascii?Q?rkFPby0e7KDOFBSwQJd6ih32VH0tkxrdxh5afZSuhN2lrAP24vJikfWNiMcY?=
 =?us-ascii?Q?qiw5C8uXZCTFS3UUnH7xOIE+iC2SvDwJ8Ba///NwO8LI+LsijydNNB0K+uFQ?=
 =?us-ascii?Q?Co6tTsQ985iEvqXz7lX3+/rVFi+evZKdeaJ5/yHkMdXUf73r4XO4Dho4ZwOv?=
 =?us-ascii?Q?bgEfM5kxf1Ah9RQFE03JGPAcMzmjWraENHYxCf3vpShOPBmuKLt2Nt0xhiJA?=
 =?us-ascii?Q?8fw1rUIMA3szVVH7SI6u5RnF/9wsSCC+cIEg13kKODiJe9vZeDnZscvvFUVt?=
 =?us-ascii?Q?zsQFTyRqr1ooSNdd5gt5l+9JJTmvpbEzGoY4ZEzFacy4Ht2QCa/Z0BKPXl4m?=
 =?us-ascii?Q?44dnfryVsxIYPdBRTurD1fRoDsSKL/Laub7TgzdJ45O+tc8mOU83WfUCgUUF?=
 =?us-ascii?Q?/L02KPw6KKY9P5nlm6U1vNzfhvIRMiqNv3SazYtVdCG2hXztnH5QTmyU3cw5?=
 =?us-ascii?Q?KiRdiHc9IE7kvX3X8V1zkSDR4/aGPgOXN44nZt2CySB9yiBSdwJWc1PTIwfi?=
 =?us-ascii?Q?6WryQgo86WfwDu9mhtitg3LmuGvYBAs7OkCOjisim7TpAbOeKCDsCcxlke0U?=
 =?us-ascii?Q?FVfPETCqJXFc24sauU+f/H98GgfXxw9XGGs1bPj7JnpzBufmgNR2iT8/JPMQ?=
 =?us-ascii?Q?BQPpPluMalafZlkT7lhFLODiVs7w5f+Lo4rPVZKSgc7EajooFyyv3tXKVGmW?=
 =?us-ascii?Q?CMOkKPA2QSC3d+2DodPcEd0Vje+vhd4/VXaS19jxcJ8u2QWB1x1rpWb1bWva?=
 =?us-ascii?Q?eGwyBrt2W04os6sz6zTyGrdYBc+TJ5zq+f3F8dtKUFooJnaYiZZlst0s/uvl?=
 =?us-ascii?Q?YDRTKw5tekT613m7oC05Qt1FLlLjlIdpw3wK9bE4C6TXMdM8AKvlUPOJ11Lh?=
 =?us-ascii?Q?vjnhA9gcYpeTtFVID3KMud9mGDoVkiLrK163z29gKYUo/hdFnXll8Lox3Kwc?=
 =?us-ascii?Q?L9g4NUHEB7zoE5hDzW+kmrUupc50avlHIgKNEOhcpE4Hmg/n0y2yNDx2dS92?=
 =?us-ascii?Q?0ZjMzf22r4y7JYLRs9bB/iqpSiRMkwNGUAi+QiHjXyMjpo3pgU/Hhljfwqqx?=
 =?us-ascii?Q?C+bpML0nagji03CAyMm/85gVTj3TCTCdyWX/4Eh2aeaSV3VNgQKEf5Pby4+h?=
 =?us-ascii?Q?l8ytR28coU7bTBnRVVBLZxbCxh38VT2swHsyNLfuvICf5Cws+txCtE0KzFg9?=
 =?us-ascii?Q?eY0wtTD1JQFHYbiCx4H7ED0JdYAiAGTu7yZD4E+BU8mEbCY5g80w6WF4HDl4?=
 =?us-ascii?Q?0ldRbNyR9iVOIpDcCNI3fGep4I6N3YQ1vh6+x5zJNtkJGIxfbQJMaRqv1ozX?=
 =?us-ascii?Q?GO0MHyRBz1yGBHSvDrKT/Oi7WL3MZSH9sc4ZuVTgXivp+l6R9p0Bta0lMrSf?=
 =?us-ascii?Q?bSBCkL6LD9HS00T22/DPEYLGjT9+NeHnUQWMc2EPFXqGp6wDD+vgfYvXqrCO?=
 =?us-ascii?Q?gf/FSgaf46lL0EL3ypPM+fuc7oNSDuLx7F9vl52JRUdysz3A+w7MX/cz4Uzl?=
 =?us-ascii?Q?/3d8D23gK4PhJPL/aw0TavSXfVe6YIMUWAM4TWuO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9e43463-30b4-4d25-bc6b-08de0fdec69c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:44:22.4382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +XDs+HpFYr7UoGNd4QsAw4X8aPiMzt+hs16D3Y4dyIsR41I6y8p7m68dtYiQF+aF6RYhlPSJTXSjuxyiBP8JNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFE52C859EE

On Mon, Oct 20, 2025 at 03:22:53PM +0200, Andrea Righi wrote:
> Hi Emil,
...
> > > +static bool sched_stress_test(void)
> > > +{
> > > +       float cfs_runtime, rt_runtime, actual_ratio;
> > > +       int cfs_pid, rt_pid;
> > 
> > I think it should be cfs_pid -> ext_pid, cfs_runtime -> ext_runtime

Oh and ack to this as well, using CFS in general is a bit confusing at this
point.

-Andrea

