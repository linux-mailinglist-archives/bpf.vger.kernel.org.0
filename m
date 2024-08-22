Return-Path: <bpf+bounces-37854-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE0F95B3FE
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 13:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32AFA2858EC
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 11:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388FC1C93D2;
	Thu, 22 Aug 2024 11:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NixgX6Wk"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB5423774;
	Thu, 22 Aug 2024 11:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326622; cv=fail; b=udnrOTxZo0X/EMfIKB/hmLGhDocLub0EqBZmghCnXu1lq/vt/+2uYd390fNekFA0WJ69WT0/vkxvrb4ZOkLIRSxUHzkwfaTz9TaoQ2BKHw/RPSjnvQ1MKc1dLanbHNIz4L5fYe9JjqfUHOPmUUbbRhPnCQ7ukY0MiojJah7YaAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326622; c=relaxed/simple;
	bh=Jgur2W3DUf/gZB6ei4K/2oeqadYSxryQks6SqIMTTy8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=usKQapPK1qCxGmJFJvXDBigellnjp5PotCnhi/P3JNO4oIRWrveNyulEj72KLxd0+86I6CIMTvsTNGBHVIFuv5XGnfeEftzMKV7qbyO43MMAhBtSC6Niw0e21kkAtb5PlyvkhSt0kI4LUc3bo685Hq5gU3tKic36amsEedBZBUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NixgX6Wk; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724326621; x=1755862621;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jgur2W3DUf/gZB6ei4K/2oeqadYSxryQks6SqIMTTy8=;
  b=NixgX6WkRVV1IGlnuK41rqxsJe9uEncV9XQeorHO9uMq8MQ54jpj/72r
   M9Cct82DLfSf347bJvgsrPIYjakhp7gCYtZInH6C/yxF1ipmSu/1cn0f4
   zEG0BLwwofD8M8Ca79iZ9ZPemiO/tMwua70uCYDSlU6WfmwCNRXsnotxd
   ZMnzOemRxtOGmMDZJXcpWCYaUkwZ307YQMgCYBjFWcCYPp7hxtq4GVVLu
   OZMsvyWVw5VDuKnYY84oyS5zIz3weFdBtlrXAHuW5PzXBPxPa3fX4Q/YZ
   Xl5T28+SCv6WeQVvvRrgdceYOy8NlTr0pVrpSAE+2xvN5rDbjBv51JunH
   Q==;
X-CSE-ConnectionGUID: gdT4Tli7SbCR+/Oufn+euA==
X-CSE-MsgGUID: R/p83jefRHWrBguw4TUlUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="48127174"
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="48127174"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 04:37:00 -0700
X-CSE-ConnectionGUID: QckvzRtoQBWI06Ih2BSK8A==
X-CSE-MsgGUID: Lgpz2kCYSTm/tp9Y69TXag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,166,1719903600"; 
   d="scan'208";a="66303453"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 04:37:00 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 04:36:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 04:36:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 04:36:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7E4skXGLk/9YtbzH2f/oeMuqX5qM95eqmZfTY0OB7RF7Ibw9VmUqQE9jZTozFR+LBkitzVZqJ6dg8kpMdql9Yq4nzG5PNeaSurLn1QqruyhJWDZBnfKRtrcQq1puVcSKAROGnBxfYWrr3Ny0Zjj1tDcF8DN4nGIIYiYmdiT4mYcLzN+updYDbHyXsR/Lea/+flmrQdfW/FItpFsZwjTzBx0BtLoPjKbyKnHgXVG8MKhJafIi6F0ppUBwAqqhUr3n0O0xjEEZ25QtLC+e7gFSdYEuHd/tvw9zplde8CwdpPWJYRlJocdoMzm8OFVEUSnZ69ycPJS25qPnolQVTm3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxJTy3OtsivPCQcvJXUAXF66qJAqbfircJtnyHeKn+U=;
 b=nFlZir8cJXLmbE9d+taCQh39qT+xX31NNe27pCumfTyHWeAwtBunQr9JklFt0E1OjSpRy0kIEeVMkwFlQG73zqXuPBCv6pBqHMEEO6OrvV3eiOX29UoRgKUIAonQlPOUBxsEW9b0Wi14MsJFa/U9wXB39RhZlaL5PimuW+08NVArk4SH4BI/Z+NZ3YRyFvKvpuZqmLa4pvnAfZ0yq9t5I7/kZx2590PwRHrc+C8E4apXX7rewlpDA0SLOwcJOsehWU/WvgqV695/osUnqdaMKP6UKKMjUNw3CRemncBXiMH7hkjqEboDYGkOopkeaRzLSKYOdRqqkZNen7slW5pXVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8583.namprd11.prod.outlook.com (2603:10b6:408:1ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 11:36:57 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 11:36:56 +0000
Date: Thu, 22 Aug 2024 13:36:48 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>,
	"Jakub Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>, Amritha Nambiar
	<amritha.nambiar@intel.com>, Chandan Kumar Rout <chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v3 3/6] ice: check for XDP rings instead of bpf
 program when unconfiguring
Message-ID: <Zsci0BshPQSXm8kl@boxer>
References: <20240819100606.15383-1-larysa.zaremba@intel.com>
 <20240819100606.15383-4-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240819100606.15383-4-larysa.zaremba@intel.com>
X-ClientProxiedBy: ZR0P278CA0032.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8583:EE_
X-MS-Office365-Filtering-Correlation-Id: 191b58c0-5d9c-4183-a65e-08dcc29eba6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AZS2pLATiq4XmlD9oCptvekrYaZO4wpD4o1AirWvEuFMEKtsl3PAxk4Vjmoi?=
 =?us-ascii?Q?NW3DQW+9QaW9kof+PRHpAj+F86WZxDtQ5nuGVwkm/fmjcE6eHVaF0np1ICod?=
 =?us-ascii?Q?VLectySoQDmkJBqa0eHqPsECk2B8gygncWBJPfg+HbAjc1tpOUFW01ZWHEw0?=
 =?us-ascii?Q?RVclWG/roHhZeLMDFjQEeYPECNg9mGIFum1RfyXoPxbscZtGF9oC/4EhwWYz?=
 =?us-ascii?Q?19VD5KR8BhWeYbNo79MoSSWU4WxRDu50S1Z3f9BIUc8XjFNJT3unLDpmr35n?=
 =?us-ascii?Q?ZzOGoT1u1Ar80QYv+xlxYBk52qoBR4B8KxgaTu54wANjsRFoFXrorsNysG+m?=
 =?us-ascii?Q?/F4jPJr7j/1eNUDHOVPmTKP05LsOfJysrzLC6Qly8+Oa7XvcTTV1uOjiiidD?=
 =?us-ascii?Q?3vVJHTMCTCYePd2ED14RQ/8spfHCwXXcp+TvVedGzS2zqEqfD8AXjgRYShaj?=
 =?us-ascii?Q?T2t0PL5glMYXlfn502QHzaN+16rrpJkgpftNcOtDsiSTov83KH108mWdDDZ9?=
 =?us-ascii?Q?xEaHDKORW/VTKOBFkj3WyRtxpI5Ie4lF3ly31BrsJn9J7HRM9KqTJTGK7zhr?=
 =?us-ascii?Q?YHPMHHAT6p4luLGRBnMI+Gw+5Ez71frLcwshCYMRxtrgC3Cm5Tw8M92ZE+wg?=
 =?us-ascii?Q?u0ExwQX5eolTFf88hgaMEBGcx5UmHOqH8z0iEf+1QOjFDgyvMF2SikSqtZ21?=
 =?us-ascii?Q?N2uAAAMe55iDpPMXllWIQ79dP90lj3a4MRxUPAu32/rdRexdxQxivm2t6FRb?=
 =?us-ascii?Q?p5R+UBm6ondfyXeSsDnH+baMHK9HnGVehbHKwmUb0x3d//c1plPMhMPYGyPc?=
 =?us-ascii?Q?2q6l/96ykImyAAAGa6IPkygceyHAhfl3PrrPSdHZ48ccVI+sdl/ariN/7rKg?=
 =?us-ascii?Q?Dgis2sMPGxdkpKIKgqG2PwRvyGVWXQzdyFB5J/AqfHtFaIoHDm5pfRmiP/Om?=
 =?us-ascii?Q?vzX9AjH5qWg8XF3cy/aqt/Cn4B0HisGyn/vbzTnp+WoOLuf7kGnXPSiLTYut?=
 =?us-ascii?Q?Kzj0fniU7Y9emGOEujIj/AS+HzFwxpI8xOvoqTyOVnbDNRIofjX8jsr0Zlla?=
 =?us-ascii?Q?uEXMHZq+tn58hjVnThmxQ2iMED/k8dBn4joPBKmpnqYlzDgeOIx4iOEI/Im2?=
 =?us-ascii?Q?FsbtN1lpdavtblpI7tTc30II/20/umaACf7Ahr0tBrtsChFmHqnrXcv32Tuu?=
 =?us-ascii?Q?jEwQ678SLUEuuAlfy1TiYZ0jZJ/N5bem/nqGwve227JBqY1lcwRz5tloKYoC?=
 =?us-ascii?Q?mhmBrv+OL0NpBtKCBT6BbYjdVt2CB1njnnJAXuzDZV8RHDJVQCuQa+HI74uc?=
 =?us-ascii?Q?pjT4MI9c0i6SbG5zQSACjuJmx1WObECSeX4FDq/bz4fiAg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ns0JZMECMSeV2E0sWnWUMKLhXBujigKwbU+cabVCKjhtfBA1scMpp2gLfFM4?=
 =?us-ascii?Q?WUN7csJ904ZnpZFKSrY5If/YbPm5bBYf2cM6huHqVcJYtiu/jzAUGZ6DxErH?=
 =?us-ascii?Q?EDEXnMsDsBpjvun7buupI4mq6Ofv7nc1GRMcSyR9JGYthl/6lmVIm4aW6IYY?=
 =?us-ascii?Q?Oog24APiho8z9XEBGRwD31Y0owxzHg+t47hsW5YD8erNL2aoNeXtXvF1miCr?=
 =?us-ascii?Q?FUX53oTALUU0RUmn5Ns1fS9NLtrQcfpTo9EJuaYqY1GBGa3Ez5JbrWZmkyXT?=
 =?us-ascii?Q?0ug131viNJh66a0hvFCVHid7CNzk5b3CK7iScIoIkckpBuy5anf4cNiAWPyO?=
 =?us-ascii?Q?75EL3/A3own57vtnvQPlM/wdUaMk8nXqzT7HsxsiGbpmvq0L97RjBQLqbLcL?=
 =?us-ascii?Q?U4fZ+1UM6oKIdiXybobHG9gHy7LLe7Sc5+37ETUNi1/dYxKH+3c2ilnbJRmV?=
 =?us-ascii?Q?D3zzFPya+WHag5hIA87V+8/s/jTWX6saJrJNs3A5gMxSQivowbx0hUDGKkGU?=
 =?us-ascii?Q?es1d6c6nSORqM1h+CAKRCyC/0pDUJCE1GwqnJSTQi4ZpjYUTktpeKRm5oJ8C?=
 =?us-ascii?Q?hWJD2BjM96+1kn96JJHQj5euMtEeqO9T2MEt2EcjSZthlWzHWppizay+9wOP?=
 =?us-ascii?Q?e37ajApfqc0ijIN9DW3jzszQE+NCjoonSR/fbZGsmZh1Z/eKNfoq32t61KER?=
 =?us-ascii?Q?GHifSdXw1Gtjy0g/Ag1ClejghICDrhOBAgnsbK/wncXjG4QHOvDpEUvrJcCb?=
 =?us-ascii?Q?Q0XKVqw8K511NzRBe2d3M9IEwHR6FLByyixQlScO1AaQBu8DshMlJLtTb6Ba?=
 =?us-ascii?Q?ke6OkO0ksvpO0sdRenBSEsLmpVaN9YvVDRMTdJffaqILgh5+L5W7kiPMQ9Ol?=
 =?us-ascii?Q?fidk3STsZCduWs9pSCy8DfDqtWknD8lPx/Yv7Zj4eR9U379wtxPJoQZxJvX6?=
 =?us-ascii?Q?Uw2V2Xz7k7afNr7rZ6RpEEAl8u3vMwxv7a/Bpihdu4B+YjX0kSMlljvTdYZi?=
 =?us-ascii?Q?gSPCQA1j6e08L0s3vRZv8AR3zhkglsq7sZ0LALkeNrjsVZzxj5zbt/L5ReOf?=
 =?us-ascii?Q?D91Uez9K4RvZ8eY6zk/VN2BlrihQdg7G/tHilS2wkO9mS9+tNqE0a8DOF1Kc?=
 =?us-ascii?Q?4ZKqVLRvyfKCNwuSwHkKH0b1t4XmqIVlwXWDYije9PFbudFzOFJ7/r9tEtii?=
 =?us-ascii?Q?VkdQn1dHCulW8tope1MuynQBn1uIrsCZSZWqAyw1BmNG1goA/pipK2T5kd7i?=
 =?us-ascii?Q?/GW9xUeVG7Ruu7e3lPXaTd7MUGtTdxzc0+TaE08oK5KkrWBxOD1f/T4J9c3H?=
 =?us-ascii?Q?KZ0tSm8Szs+HU8ezr0dSsaObUEzP3V2XTiAeswS5BmaKCOJ+NkgbPM0tv9uv?=
 =?us-ascii?Q?IGVEAxgDYRCkfO+6pA6xc5pABH/5OeXCObLksTTLa9gzFV3tK9eNz1pfUYIA?=
 =?us-ascii?Q?1eKrxillc2LY4ZC0hTE6gNeUHX+4fO0G2mtajAsqmmq6eVQ5Ro7Wker/yesQ?=
 =?us-ascii?Q?OADzFpAQmMuRLumeO61XlUYeIegmFSAiOVosT3bo+VzQJ+S3uv7f+n1uhmlg?=
 =?us-ascii?Q?awCg4gnx9Li1Qj7AKuMDGp/GaW1hbPv/tXeBu3xCT8OuvBcgCTgv/jeOedwA?=
 =?us-ascii?Q?qw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 191b58c0-5d9c-4183-a65e-08dcc29eba6b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 11:36:56.8959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49G3YgAV59EVZoQkaZS/Uv8rCsiGwjWr57of57YKZlUGbYYcvDCXV3+oPMM3PommPaLDzeigi/K6wyRZZxoAqeydUiDwlyPWXKEYFn7+GW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8583
X-OriginatorOrg: intel.com

On Mon, Aug 19, 2024 at 12:05:40PM +0200, Larysa Zaremba wrote:
> If VSI rebuild is pending, .ndo_bpf() can attach/detach the XDP program on
> VSI without applying new ring configuration. When unconfiguring the VSI, we
> can encounter the state in which there is an XDP program but no XDP rings
> to destroy or there will be XDP rings that need to be destroyed, but no XDP
> program to indicate their presence.
> 
> When unconfiguring, rely on the presence of XDP rings rather then XDP
> program, as they better represent the current state that has to be
> destroyed.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_main.c | 4 ++--
>  drivers/net/ethernet/intel/ice/ice_xsk.c  | 6 +++---
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index a8721ecdf2cd..b72338974a60 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2419,7 +2419,7 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
>  		dev_err(ice_pf_to_dev(pf), "Failed to remove RDMA scheduler config for VSI %u, err %d\n",
>  			vsi->vsi_num, err);
>  
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	if (vsi->xdp_rings)
>  		/* return value check can be skipped here, it always returns
>  		 * 0 if reset is in progress
>  		 */
> @@ -2521,7 +2521,7 @@ static void ice_vsi_release_msix(struct ice_vsi *vsi)
>  		for (q = 0; q < q_vector->num_ring_tx; q++) {
>  			ice_write_itr(&q_vector->tx, 0);
>  			wr32(hw, QINT_TQCTL(vsi->txq_map[txq]), 0);
> -			if (ice_is_xdp_ena_vsi(vsi)) {
> +			if (vsi->xdp_rings) {
>  				u32 xdp_txq = txq + vsi->num_xdp_txq;
>  
>  				wr32(hw, QINT_TQCTL(vsi->txq_map[xdp_txq]), 0);
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index e92f43850671..a718763d2370 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -7228,7 +7228,7 @@ int ice_down(struct ice_vsi *vsi)
>  	if (tx_err)
>  		netdev_err(vsi->netdev, "Failed stop Tx rings, VSI %d error %d\n",
>  			   vsi->vsi_num, tx_err);
> -	if (!tx_err && ice_is_xdp_ena_vsi(vsi)) {
> +	if (!tx_err && vsi->xdp_rings) {
>  		tx_err = ice_vsi_stop_xdp_tx_rings(vsi);
>  		if (tx_err)
>  			netdev_err(vsi->netdev, "Failed stop XDP rings, VSI %d error %d\n",
> @@ -7245,7 +7245,7 @@ int ice_down(struct ice_vsi *vsi)
>  	ice_for_each_txq(vsi, i)
>  		ice_clean_tx_ring(vsi->tx_rings[i]);
>  
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	if (vsi->xdp_rings)
>  		ice_for_each_xdp_txq(vsi, i)
>  			ice_clean_tx_ring(vsi->xdp_rings[i]);
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index a659951fa987..8693509efbe7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -39,7 +39,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  	       sizeof(vsi_stat->rx_ring_stats[q_idx]->rx_stats));
>  	memset(&vsi_stat->tx_ring_stats[q_idx]->stats, 0,
>  	       sizeof(vsi_stat->tx_ring_stats[q_idx]->stats));
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	if (vsi->xdp_rings)
>  		memset(&vsi->xdp_rings[q_idx]->ring_stats->stats, 0,
>  		       sizeof(vsi->xdp_rings[q_idx]->ring_stats->stats));
>  }
> @@ -52,7 +52,7 @@ static void ice_qp_reset_stats(struct ice_vsi *vsi, u16 q_idx)
>  static void ice_qp_clean_rings(struct ice_vsi *vsi, u16 q_idx)
>  {
>  	ice_clean_tx_ring(vsi->tx_rings[q_idx]);
> -	if (ice_is_xdp_ena_vsi(vsi))
> +	if (vsi->xdp_rings)
>  		ice_clean_tx_ring(vsi->xdp_rings[q_idx]);
>  	ice_clean_rx_ring(vsi->rx_rings[q_idx]);
>  }
> @@ -194,7 +194,7 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
>  	if (!fail)
>  		fail = err;
> -	if (ice_is_xdp_ena_vsi(vsi)) {
> +	if (vsi->xdp_rings) {
>  		struct ice_tx_ring *xdp_ring = vsi->xdp_rings[q_idx];
>  
>  		memset(&txq_meta, 0, sizeof(txq_meta));
> -- 
> 2.43.0
> 

