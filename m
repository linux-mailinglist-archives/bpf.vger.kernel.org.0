Return-Path: <bpf+bounces-50494-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B03BFA28574
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 09:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DC016159A
	for <lists+bpf@lfdr.de>; Wed,  5 Feb 2025 08:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9958A229B2B;
	Wed,  5 Feb 2025 08:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fsl2QqUK"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15798215077;
	Wed,  5 Feb 2025 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743592; cv=fail; b=iMe7Foa6NYmrLgZS9CnrZiOUh2yfEL5U7cSeXF4gaetx1lWsY/Y86Gmf7jlDY0s1+gcxtwbgTsOnasva8HzYcholrbYmvjfC0FmkH5X98+f9sscA328IWFW38SH9X83cW/SL7s+i12rECgfZwbn+SRy1L26tRMLi9grwQ1EROP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743592; c=relaxed/simple;
	bh=HeXfQlgKoX2I47Q7BJz/spvnAfs//MYPdkDyrcMF6rs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=giUVUMm6r7HDUtE4+yi+EloPS3WHiMmMvbe7YUPuWK+L93CdrusjyyQaRQsxg9Zb+0i8jCDTXkBn/SFe4abRsQYpGDnkwfWXJXGnO0x6pNdCwb+U6xEVa3GA7IENUnZJdar0H0CO+aiJRP3DZKkYVlptY0DQmwuP+uSXd86P2ek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fsl2QqUK; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738743587; x=1770279587;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=HeXfQlgKoX2I47Q7BJz/spvnAfs//MYPdkDyrcMF6rs=;
  b=fsl2QqUKD0Rxsc+0+zFN0ZrfJ5fE59cEgMXt3e6NfIlV2BrgO53wAxdN
   TBqs+TQ+2aGi7GzNM9lK9n+RQ0Rtj6N9J0PcKuYooqwntaEMNDn6JQgjZ
   innSvZNZikZvEFgLN9gSbn8pk/qgs1LZ1Zw3+rlNhEdTdSvw/YFueXXRW
   WJa9uqE2Y/pWsr4svZO0z3BHXpWjW+duXoWKIpchVvb7fZde6Gr+us967
   6bPd52qpyptHTQTdPQDWpiTQWmlfGoljbaTlQ+6mBUkgRLG0bmtx+8n5d
   nWXAfaugC+22GXfnKPmxDmEp0zEBSXPt4JhnzoKQ5DFynM7lyvRHYwhoh
   A==;
X-CSE-ConnectionGUID: a0x6Ktr4QNCeMybIlK0Sjg==
X-CSE-MsgGUID: jXeGeY2LTsaHNQHoTC0wrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="49948673"
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="49948673"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 00:19:44 -0800
X-CSE-ConnectionGUID: 2foi3u6pRbai4+QWANrTcw==
X-CSE-MsgGUID: hDSn3167R+uP8EF7DaK8hA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,260,1732608000"; 
   d="scan'208";a="115882363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 00:19:43 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 00:19:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 00:19:42 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 00:19:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXOEbCfs/IPtINLbFARhXv5dnLZwF/DGYpFvU9ofP9nT6HMzMZ772OYZXTRKhYhb1JSuniFlYsbBVBUDorlmwD8tFx4QA6SWisr3Ec/Gas4s42vTLy6rQL1azblKG2MpuF4YtRhhE0BKiToWvpWg1fteYTZNMUlulTvtT6iK5hoFFcRw+yGxU6wdCMMjugJL+f5IiJMhmxumXE2qG8FOg7CR/EuftpO3gQ4Get36GJnKn1xxPDI8cbiEPBNHkFoTryC0XZJ1S/LPUNVgXqUC2J+q+/83Jq6Pp3uiXsgfwZ3C6RJTvere8uusWH6m/s1sHQCMzai69G8uWEcMgRkoHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p7tfJoaXOWmBTf81di22NaoLaMuRMhwkPiVGWCl1zy8=;
 b=osEKorznd2yHgNh7qG1tzr1yP2i246Cfcmp8AfPb9jJqMAeytlk4YKvZ052rs6hYRdv3p1pfSd52irfiMvI/dEZrcm7ss0pwjN3261xYAe+ojO1+qHWcL3ia0NOKQzcDp8uBMp0oDHxJTN0QoebKAi5UOqQvn/9tHm0lMkp2wpYHB0AcszJIG9uFtXeRuP5gQQkL/SdLb/QHjWCu5qQmgSerGH1tUR/0/RNFfFK76iseLX+Vyh6/7ZINHkT4IWnZbhDDFqZQkj0fj6Fq7wodo0gZSetcvmMQhrx1ZgAkLtUsnnwXdfRhb3XHYQJR80Jl5TXd2Giv6qNoo7VEjJOEWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by BY1PR11MB8055.namprd11.prod.outlook.com (2603:10b6:a03:530::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 08:19:18 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%3]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 08:19:18 +0000
Date: Wed, 5 Feb 2025 16:18:58 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
	<alan.maguire@oracle.com>, Heiko Carstens <hca@linux.ibm.com>, Mark Rutland
	<mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
	<kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, "Naveen
 N Rao" <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, "Paul
 Walmsley" <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	<linux-trace-kernel@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linus:master] [fprobe]  4346ba1604:  netperf.Throughput_tps 11.7%
 regression
Message-ID: <202502051612.c3c3749-lkp@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KL1PR01CA0033.apcprd01.prod.exchangelabs.com
 (2603:1096:820:1::21) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|BY1PR11MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 79064fbd-bef3-46d3-dded-08dd45bdc8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?FHxVtgcuqEXDMPk/2wwKJDSYFwjEpLmOkCh/QjFjmdDRjkvsQSDtFHfC45?=
 =?iso-8859-1?Q?vfrtEZE52tEFNMlnUljXSOK7lmU7Hztot0IcgFY/cFOM7ezHe+imKvOFLS?=
 =?iso-8859-1?Q?uARSjx5fVDy2xLGOWdRRnGDTu8BVk1FVAOZaqih9fXP6rCnzeWs0N8jdCt?=
 =?iso-8859-1?Q?7AFHIPMBG0wuqsMD17UR+y2dCqMVR2efllK2yab0K3s7KGWK6HpfTCkLNz?=
 =?iso-8859-1?Q?qX/5pyiAcTZLj51k8QPV0YnFtUV+WLJOu3/Zvru8CQbQGmsaVx+DCzt2ea?=
 =?iso-8859-1?Q?+ogzbKL9wpTMJulvaAbRZbuNimXT9TfXA0eGucKjt1LTfbcKQYIux3C1/k?=
 =?iso-8859-1?Q?TkjNUQL6kQXJMLNqkseiUfktCbGrDDgz0Iyde0GgXfV2tK2jXQLycdFTbe?=
 =?iso-8859-1?Q?13GU4LpYAFYh1s3C2gkUBiCbJVbb5/0r2QAyD7zBYodvh+aWMzjZNt/z25?=
 =?iso-8859-1?Q?rRt3Zx3nkWme6n/rMiqC2wJ0loZ51eOQi918HWeS4kDGK0DjH1+WnX6u23?=
 =?iso-8859-1?Q?pb2fUnkJxPIJaPtyICURJDV20r/mDtpyigbyTvwxEIrG6U4hDKL0YD17S+?=
 =?iso-8859-1?Q?z+518JJM2a1DLl3Nr1+OAGJxlf5MZhQWfoIh1ISrVfO6KhXDeRy1dylDoa?=
 =?iso-8859-1?Q?zWJytz3rwbI7kbS3gAz1fvsEXSj6t088AHXYLGBwxtwkjCoqaz79FA52UP?=
 =?iso-8859-1?Q?+PeO7Qdymf7B0nTreYyjTAx04eHwXgCbRmOvHbj+1rzar0Xli5taPlDbvb?=
 =?iso-8859-1?Q?m/n5EoRXL27hotsHn7OiRZon/SukEm0EHolNvi/RO0nHsbuC/TpZ0b6l7/?=
 =?iso-8859-1?Q?SA191aMz5cE5RpylLCvLuMxEuceC6zGQPq7o8g/Y9fZTYo2exCm2o9wpwW?=
 =?iso-8859-1?Q?AIVqZlSQDd6t4qqBCBkaO4kmnlxFmR9DlRKyE9sa2+0FXWTnnDrp8TBBaG?=
 =?iso-8859-1?Q?HHpV1/O5ZOl4NzBLVXsWHozCpsdESMHDx40qxSeEoc3Jn637Pg9eBdj+s7?=
 =?iso-8859-1?Q?dUiov+t9IwHYfJOMhvEY2ARQ/UBOUc4xeyTaxNoNGyIedZ51z1i8DSIDBz?=
 =?iso-8859-1?Q?nLuJ6LFVX15e4oI56myOExWWjhe4AZpJrRGoOaHFte6YIu2LKinFIOdkbz?=
 =?iso-8859-1?Q?H3RwFPfaOfuH20tvE4/0avGzuur6F6kv3mU2yTpVJV+TIYzOYcuJPe5ySx?=
 =?iso-8859-1?Q?Q6h3uhVOOaqCFtzYCAaCEzZQyr/tHiOhG2MJn0iupop7kjLea8zy1clDDG?=
 =?iso-8859-1?Q?7EtvuROdmkLm4lzlv90m8Gfi9shgaAWDAHJfjgprXSqB5umoofvTwOQCxJ?=
 =?iso-8859-1?Q?Q/SOGLju/9F/ZLod5r669NoYvVhUXefVIGHSrZK7ljfWULm6bjmQHBWhGB?=
 =?iso-8859-1?Q?a6QaOKqwaRpIJEHM4v6gViJhBB1bHOqw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?I1wxJcKj6vsq6YVWYhMfFbSYTRsHdEiv1uZMeli74j/UzIBAmQcKYba5Ci?=
 =?iso-8859-1?Q?7OPNeWTGqbdfZZcxzfbooYWijtLNujA5IrNTc/MSXwiyLHvEnw+ByUuFJX?=
 =?iso-8859-1?Q?KvTvU/JONHVg/0CQLqzQdX8fhp7e4KOdp0oICXZLbLHdtrK4yT3YcA7h5D?=
 =?iso-8859-1?Q?IWQsuNz8dLR3xSpEw5ykTHQ9i1CaPvvxHGUQuTgEBBDl48uPriAr/Ep1YX?=
 =?iso-8859-1?Q?jhVPwPQMTdlmi6sIOuwOvZM0o1n+D9Xw4jYbShq5ERDARB6MD2dDyWPJtl?=
 =?iso-8859-1?Q?Y0BDiIQsYE96wYMZ8jvtSFqcsz9Wv60T92Mw/4gKaXbTs4BDiYvuS6GMwY?=
 =?iso-8859-1?Q?XLkMtijkyeSjrZ+jrvXCvkdUsIih2eKQWIRVVNim1T+pffLFLrdk9CQfzn?=
 =?iso-8859-1?Q?CZcIid1BTeD/1N1KtZnWVB4hp9Z8o3V48UuN48+Y8REDEPyb7Rryw4bZNA?=
 =?iso-8859-1?Q?e7gjDpspTad10QeYIPzOEoDzH4ZZHyPIWszTnDiKK+KyS1kkD/AA8XBT5j?=
 =?iso-8859-1?Q?vDwv4B/pCYrQrvlAHMOpl9qfSKceuifbrjOK8/Z/BbO7kc3ynhaJHtwypK?=
 =?iso-8859-1?Q?hNBWqOazADvUTORMdakGi17Fvh0gZFN5kGzXNvtJbAKwFYwJG7LhTOlkic?=
 =?iso-8859-1?Q?9EfYOYsEkj577doEw/Z8CM+wAzCQlGN5FiyIS3dpGQyi69enk19Ipw0wSV?=
 =?iso-8859-1?Q?IP32+cEp0lmHxZDcxd4pC3CJcFDg1+3zlH9X6kMmKYkVuiQH1RgQRiAdee?=
 =?iso-8859-1?Q?viT3CSkWIQ/WlbajYYPzfhIFX8qtyn27cJ1zs4Ww1FllsZ/8THLkH8oCQc?=
 =?iso-8859-1?Q?3cliNbyAW3+kw98y7D51NT9pUq27fJQ3Drquc/AkaW7pYszOFYlmimu0vJ?=
 =?iso-8859-1?Q?OEVOTRKhMMp0lzPjZRINgH1QHAngwzegRRfgv265bzJC/p3bQvhzkkVxxr?=
 =?iso-8859-1?Q?Du1v8+fepV/mE8DuGoJi/SZrPRVBx7fNArKyShiY5hRZ24Y8PL9uxqGL7F?=
 =?iso-8859-1?Q?BYTk1OEUTJvFu6qXJdDWbvAu3QEAaYNLNU+I/09BSnK2f9YGl+xPdRmxQB?=
 =?iso-8859-1?Q?wepXHv+yKFxcBHF3JGW0Wxd8K9wraB6lmoz1SM1u4TY01VDAPQxZRPXM3R?=
 =?iso-8859-1?Q?CAYa5i82V5uvZP67ryNOO3a4YX5iqlyEIU5loqZV0KcdaLFvoyaLz37TTm?=
 =?iso-8859-1?Q?h5ahPogMehpLqAe3g8g1bSJG4RTwi8cxcOuzwNkRI6c1EssilId51wVvPr?=
 =?iso-8859-1?Q?vlutZBuApjuSXlXjxRlmcTkgU4Ax5dqcibGH73w4mj4sMqEl0cEd4ytZdm?=
 =?iso-8859-1?Q?DgNEPjjK8C3dDdMEbyn3Y8Qrnwhv+f6AVPJfSzSvnqgdAO1p+PKesfg06N?=
 =?iso-8859-1?Q?8RA9dxJIMEzohhUmj6EMwGK47sZlCCSMveaA+rwn6K9jdED842/hex9JT6?=
 =?iso-8859-1?Q?IgY0X0l3wW3nY7gyLsxXZj7ObCrgp0O8iQ/pjm+mrWzWCxehOWzvoudd3M?=
 =?iso-8859-1?Q?qNIYMR6O/yZkvtxZ5GRTIxTVl2hyGr3FxCECnLneXkPAqjrxnS22si7nIN?=
 =?iso-8859-1?Q?a0LQwPKMmA1ImL33LD3khjDNA/I3qtYfg628alkRYAzE+gMd4X+QyomhaS?=
 =?iso-8859-1?Q?IXhtqnI4C9uDaIfCNFpJjGjQoRVPt3ud8kG23ywIIsq4zACy+Y2cU+5Q?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 79064fbd-bef3-46d3-dded-08dd45bdc8b5
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:19:18.0970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIE/HdAt6gh+46LWAskJe/csVo9Q0szvMZpwP/t5wSg9xxxo9MTOO6alQ2cj2R6CfzpjS5Fb2iCFWucxpEBkiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8055
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed a 11.7% regression of netperf.Throughput_tps on:


commit: 4346ba1604093305a287e08eb465a9c15ba05b80 ("fprobe: Rewrite fprobe on function-graph tracer")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      0de63bb7d91975e73338300a57c54b93d3cc151c]
[test failed on linux-next/master 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e]

testcase: netperf
config: x86_64-rhel-9.4
compiler: gcc-12
test machine: 128 threads 2 sockets Intel(R) Xeon(R) Gold 6338 CPU @ 2.00GHz (Ice Lake) with 256G memory
parameters:

	ip: ipv4
	runtime: 300s
	nr_threads: 200%
	cluster: cs-localhost
	test: TCP_CRR
	cpufreq_governor: performance




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202502051612.c3c3749-lkp@intel.com


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250205/202502051612.c3c3749-lkp@intel.com

=========================================================================================
cluster/compiler/cpufreq_governor/ip/kconfig/nr_threads/rootfs/runtime/tbox_group/test/testcase:
  cs-localhost/gcc-12/performance/ipv4/x86_64-rhel-9.4/200%/debian-12-x86_64-20240206.cgz/300s/lkp-icl-2sp2/TCP_CRR/netperf

commit: 
  7495e179b4 ("s390/tracing: Enable HAVE_FTRACE_GRAPH_FUNC")
  4346ba1604 ("fprobe: Rewrite fprobe on function-graph tracer")

7495e179b4788014 4346ba1604093305a287e08eb46 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      2.83            -0.4        2.46        mpstat.cpu.all.usr%
   5211816            -9.4%    4720624        vmstat.system.cs
     18400 ±  5%     -14.5%      15738 ±  9%  numa-meminfo.node0.KernelStack
     13137 ±  7%     +20.1%      15781 ±  8%  numa-meminfo.node1.KernelStack
   3058216 ±  4%     -10.0%    2752039 ±  4%  numa-numastat.node0.local_node
   3106482 ±  4%     -10.1%    2792138 ±  4%  numa-numastat.node0.numa_hit
  36192546 ±  2%     -22.1%   28205925 ±  2%  proc-vmstat.pgalloc_normal
  34772551 ±  2%     -23.1%   26734920        proc-vmstat.pgfree
   6252258            -9.4%    5665821        sched_debug.cpu.nr_switches.avg
   5112604           -15.6%    4313474        sched_debug.cpu.nr_switches.min
     19576           +13.3%      22175 ±  2%  perf-c2c.DRAM.remote
     23248 ±  2%     +26.8%      29473 ±  3%  perf-c2c.HITM.local
     29717 ±  2%     +18.9%      35320 ±  3%  perf-c2c.HITM.total
     18395 ±  5%     -14.4%      15737 ±  9%  numa-vmstat.node0.nr_kernel_stack
   3106133 ±  4%     -10.1%    2792518 ±  4%  numa-vmstat.node0.numa_hit
   3057867 ±  4%     -10.0%    2752419 ±  4%  numa-vmstat.node0.numa_local
     13135 ±  7%     +20.1%      15777 ±  8%  numa-vmstat.node1.nr_kernel_stack
      0.06 ±  4%      +9.7%       0.06 ±  7%  perf-sched.sch_delay.avg.ms.__cond_resched.lock_sock_nested.inet_accept.do_accept.__sys_accept4
      0.15 ± 28%     +82.7%       0.28 ± 23%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.__inet_stream_connect.inet_stream_connect.__sys_connect
    118.89 ±149%     -99.8%       0.30 ± 30%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.inet_csk_accept.inet_accept.do_accept
      0.24 ± 10%    +1e+05%     244.10 ±100%  perf-sched.sch_delay.max.ms.__cond_resched.lock_sock_nested.tcp_recvmsg.inet_recvmsg.sock_recvmsg
   1962590           -11.7%    1732368        netperf.ThroughputBoth_total_tps
      7666           -11.7%       6767        netperf.ThroughputBoth_tps
   1962590           -11.7%    1732368        netperf.Throughput_total_tps
      7666           -11.7%       6767        netperf.Throughput_tps
    630.24           -13.5%     544.97        netperf.time.user_time
 3.933e+08           -16.1%  3.298e+08 ±  2%  netperf.time.voluntary_context_switches
 5.888e+08           -11.7%  5.197e+08        netperf.workload
      0.49 ±  2%     +60.4%       0.79 ±  2%  perf-stat.i.MPKI
 4.498e+10           -11.5%  3.979e+10        perf-stat.i.branch-instructions
 4.059e+08           -11.9%  3.577e+08        perf-stat.i.branch-misses
     23.41            -0.9       22.47        perf-stat.i.cache-miss-rate%
 1.108e+08           +44.2%  1.598e+08        perf-stat.i.cache-misses
  4.72e+08           +50.0%  7.079e+08        perf-stat.i.cache-references
   5253361            -9.4%    4760608        perf-stat.i.context-switches
      1.35           +13.8%       1.53        perf-stat.i.cpi
      2862           -30.4%       1991        perf-stat.i.cycles-between-cache-misses
 2.368e+11           -11.5%  2.095e+11        perf-stat.i.instructions
      0.75           -11.7%       0.66        perf-stat.i.ipc
     41.07            -9.3%      37.24        perf-stat.i.metric.K/sec
      0.47           +63.0%       0.76        perf-stat.overall.MPKI
     23.49            -0.9       22.57        perf-stat.overall.cache-miss-rate%
      1.35           +13.5%       1.53        perf-stat.overall.cpi
      2881           -30.4%       2006        perf-stat.overall.cycles-between-cache-misses
      0.74           -11.9%       0.65        perf-stat.overall.ipc
 4.485e+10           -11.6%  3.967e+10        perf-stat.ps.branch-instructions
 4.047e+08           -11.9%  3.566e+08        perf-stat.ps.branch-misses
 1.105e+08           +44.2%  1.593e+08        perf-stat.ps.cache-misses
 4.705e+08           +50.0%  7.057e+08        perf-stat.ps.cache-references
   5237358            -9.4%    4746137        perf-stat.ps.context-switches
 2.361e+11           -11.5%  2.088e+11        perf-stat.ps.instructions
 7.236e+13           -11.4%  6.408e+13        perf-stat.total.instructions
     19.16            -2.7       16.49        perf-profile.calltrace.cycles-pp.__close.send_omni_inner.send_tcp_conn_rr.main
     18.85            -2.6       16.24        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr.main
     18.84            -2.6       16.23        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner.send_tcp_conn_rr
     18.71            -2.6       16.12        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.send_omni_inner
     24.19            -2.0       22.24        perf-profile.calltrace.cycles-pp.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close
     21.99            -1.7       20.27        perf-profile.calltrace.cycles-pp.sock_close.__fput.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe
     21.95            -1.7       20.24        perf-profile.calltrace.cycles-pp.__sock_release.sock_close.__fput.__x64_sys_close.do_syscall_64
     21.76            -1.7       20.07        perf-profile.calltrace.cycles-pp.inet_release.__sock_release.sock_close.__fput.__x64_sys_close
      8.84            -1.2        7.63        perf-profile.calltrace.cycles-pp.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
     20.53            -1.2       19.33        perf-profile.calltrace.cycles-pp.tcp_close.inet_release.__sock_release.sock_close.__fput
     20.25            -1.2       19.08        perf-profile.calltrace.cycles-pp.__tcp_close.tcp_close.inet_release.__sock_release.sock_close
      4.25 ±  3%      -0.8        3.45 ±  2%  perf-profile.calltrace.cycles-pp.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      4.36            -0.8        3.58        perf-profile.calltrace.cycles-pp.recv.send_omni_inner.send_tcp_conn_rr.main
      4.02 ±  3%      -0.7        3.29 ±  2%  perf-profile.calltrace.cycles-pp.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      3.87            -0.7        3.16 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr.main
      3.84            -0.7        3.14 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner.send_tcp_conn_rr
     12.27            -0.7       11.59        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close.tcp_close
     11.63            -0.6       11.02        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.__tcp_close
      3.37            -0.6        2.78 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv.send_omni_inner
      4.26            -0.6        3.68        perf-profile.calltrace.cycles-pp.__socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      4.23 ±  2%      -0.6        3.66        perf-profile.calltrace.cycles-pp.__release_sock.__tcp_close.tcp_close.inet_release.__sock_release
      4.15 ±  2%      -0.6        3.59        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.__tcp_close.tcp_close.inet_release
      4.12 ±  2%      -0.6        3.57        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close.tcp_close
      5.05            -0.5        4.50        perf-profile.calltrace.cycles-pp.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe.recv
      3.99            -0.5        3.46        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      3.98            -0.5        3.45        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket.send_omni_inner
      3.90            -0.5        3.38        perf-profile.calltrace.cycles-pp.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket.omni_create_data_socket
      3.87            -0.5        3.35        perf-profile.calltrace.cycles-pp.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe.__socket
      4.68            -0.5        4.16        perf-profile.calltrace.cycles-pp.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64.entry_SYSCALL_64_after_hwframe
      4.47            -0.5        3.95        perf-profile.calltrace.cycles-pp.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom
      4.58            -0.5        4.07        perf-profile.calltrace.cycles-pp.inet_recvmsg.sock_recvmsg.__sys_recvfrom.__x64_sys_recvfrom.do_syscall_64
      1.30            -0.5        0.80        perf-profile.calltrace.cycles-pp.sk_alloc.inet_create.__sock_create.__sys_socket.__x64_sys_socket
      0.83 ±  6%      -0.5        0.34 ± 70%  perf-profile.calltrace.cycles-pp._raw_spin_lock_bh.inet_unhash.tcp_set_state.tcp_done.tcp_rcv_state_process
      4.13            -0.5        3.66        perf-profile.calltrace.cycles-pp.tcp_recvmsg_locked.tcp_recvmsg.inet_recvmsg.sock_recvmsg.__sys_recvfrom
      1.51            -0.5        1.05        perf-profile.calltrace.cycles-pp.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.03 ±  2%      -0.4        0.60        perf-profile.calltrace.cycles-pp.__sk_destruct.inet_release.__sock_release.sock_close.__fput
      0.88 ±  6%      -0.4        0.45 ± 44%  perf-profile.calltrace.cycles-pp.inet_unhash.tcp_set_state.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv
      1.20            -0.4        0.78        perf-profile.calltrace.cycles-pp.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv
     18.94            -0.4       18.52        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames
      1.12            -0.4        0.71        perf-profile.calltrace.cycles-pp.sk_clone_lock.inet_csk_clone_lock.tcp_create_openreq_child.tcp_v4_syn_recv_sock.tcp_check_req
      1.24 ±  4%      -0.4        0.83 ±  3%  perf-profile.calltrace.cycles-pp.tcp_done.tcp_fin.tcp_data_queue.tcp_rcv_state_process.tcp_v4_do_rcv
      1.05 ±  5%      -0.4        0.65 ±  4%  perf-profile.calltrace.cycles-pp.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close
      2.87            -0.4        2.47        perf-profile.calltrace.cycles-pp.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
     18.72            -0.4       18.33        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit
      1.10 ±  4%      -0.4        0.72 ±  3%  perf-profile.calltrace.cycles-pp.tcp_set_state.tcp_done.tcp_fin.tcp_data_queue.tcp_rcv_state_process
      0.91 ±  6%      -0.4        0.55 ±  5%  perf-profile.calltrace.cycles-pp.tcp_set_state.tcp_done.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      0.70 ±  6%      -0.3        0.36 ± 70%  perf-profile.calltrace.cycles-pp.__tcp_get_metrics.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_rcv_state_process
      1.56            -0.3        1.25        perf-profile.calltrace.cycles-pp.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind
      0.74 ±  7%      -0.3        0.46 ± 45%  perf-profile.calltrace.cycles-pp.__tcp_get_metrics.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_finish_connect
      0.74 ±  6%      -0.3        0.46 ± 45%  perf-profile.calltrace.cycles-pp.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_rcv_state_process.tcp_child_process
      2.37            -0.3        2.11        perf-profile.calltrace.cycles-pp.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      1.46            -0.3        1.21        perf-profile.calltrace.cycles-pp.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      1.31            -0.2        1.08        perf-profile.calltrace.cycles-pp.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      1.89            -0.2        1.67        perf-profile.calltrace.cycles-pp.inet_create.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      2.20            -0.2        1.97        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr
      0.79 ±  6%      -0.2        0.57 ±  6%  perf-profile.calltrace.cycles-pp.tcp_get_metrics.tcp_init_metrics.tcp_init_transfer.tcp_finish_connect.tcp_rcv_synsent_state_process
      2.18            -0.2        1.96        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket.send_omni_inner
      1.19            -0.2        0.99        perf-profile.calltrace.cycles-pp.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket.send_omni_inner
      2.10            -0.2        1.90        perf-profile.calltrace.cycles-pp.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind.omni_create_data_socket
      2.08            -0.2        1.89        perf-profile.calltrace.cycles-pp.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe.bind
      0.85 ±  4%      -0.2        0.69 ±  4%  perf-profile.calltrace.cycles-pp.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket.do_syscall_64
      1.88            -0.2        1.73        perf-profile.calltrace.cycles-pp.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64.entry_SYSCALL_64_after_hwframe
      1.86            -0.1        1.71        perf-profile.calltrace.cycles-pp.__inet_bind.inet_bind_sk.__sys_bind.__x64_sys_bind.do_syscall_64
      0.80 ±  4%      -0.1        0.65 ±  5%  perf-profile.calltrace.cycles-pp.alloc_inode.sock_alloc.__sock_create.__sys_socket.__x64_sys_socket
      0.83            -0.1        0.69        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket.omni_create_data_socket
      0.80            -0.1        0.67        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer.create_data_socket
      0.71            -0.1        0.59        perf-profile.calltrace.cycles-pp.setsockopt.omni_create_data_socket.send_omni_inner.send_tcp_conn_rr.main
      0.68            -0.1        0.57        perf-profile.calltrace.cycles-pp.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt.set_sock_buffer
      0.66            -0.1        0.55        perf-profile.calltrace.cycles-pp.__sys_getsockopt.__x64_sys_getsockopt.do_syscall_64.entry_SYSCALL_64_after_hwframe.getsockopt
      0.79            -0.1        0.68        perf-profile.calltrace.cycles-pp.alloc_file_pseudo.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64
      0.83            -0.1        0.72        perf-profile.calltrace.cycles-pp.sock_alloc_file.__sys_socket.__x64_sys_socket.do_syscall_64.entry_SYSCALL_64_after_hwframe
      0.80 ±  2%      -0.1        0.71 ±  2%  perf-profile.calltrace.cycles-pp.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk.__sys_bind
      0.68 ±  2%      -0.1        0.62 ±  3%  perf-profile.calltrace.cycles-pp.inet_bind_conflict.inet_csk_bind_conflict.inet_csk_get_port.__inet_bind.inet_bind_sk
      0.61            -0.1        0.55        perf-profile.calltrace.cycles-pp.tcp_clean_rtx_queue.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      0.87 ±  2%      -0.1        0.80        perf-profile.calltrace.cycles-pp.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function.__wake_up_common
      0.81            -0.0        0.76        perf-profile.calltrace.cycles-pp.enqueue_task_fair.enqueue_task.ttwu_do_activate.try_to_wake_up.autoremove_wake_function
      0.62 ±  2%      +0.0        0.66 ±  3%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.57 ±  2%      +0.1        0.64 ±  3%  perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.__tcp_close
      0.99            +0.2        1.15        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      0.69 ±  6%      +0.2        0.88 ±  6%  perf-profile.calltrace.cycles-pp.tcp_v4_send_reset.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.63 ±  6%      +0.2        0.83 ±  6%  perf-profile.calltrace.cycles-pp.ip_send_unicast_reply.tcp_v4_send_reset.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
     10.36            +0.2       10.59        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      4.30            +0.3        4.65        perf-profile.calltrace.cycles-pp.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      0.27 ±100%      +0.4        0.65 ±  8%  perf-profile.calltrace.cycles-pp.tcp_time_wait.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      1.72 ±  2%      +0.4        2.17 ±  3%  perf-profile.calltrace.cycles-pp.tcp_finish_connect.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      0.17 ±141%      +0.4        0.61 ±  9%  perf-profile.calltrace.cycles-pp.tcp_update_metrics.tcp_time_wait.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      2.92            +0.4        3.36        perf-profile.calltrace.cycles-pp.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      3.44            +0.4        3.89        perf-profile.calltrace.cycles-pp.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      2.19 ± 12%      +0.4        2.64        perf-profile.calltrace.cycles-pp.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg
      1.34 ± 15%      +0.5        1.79        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      1.63 ±  2%      +0.5        2.10 ±  3%  perf-profile.calltrace.cycles-pp.tcp_init_transfer.tcp_finish_connect.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
      1.54 ±  2%      +0.5        2.04 ±  4%  perf-profile.calltrace.cycles-pp.tcp_init_transfer.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.5        0.54        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      6.28            +0.5        6.82        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests
      6.30            +0.5        6.84        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__close.recv_omni.process_requests.spawn_child
      6.57            +0.5        7.12        perf-profile.calltrace.cycles-pp.__close.recv_omni.process_requests.spawn_child.accept_connection
      6.16            +0.6        6.71        perf-profile.calltrace.cycles-pp.__x64_sys_close.do_syscall_64.entry_SYSCALL_64_after_hwframe.__close.recv_omni
      9.42            +0.6        9.98        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process
      2.22            +0.6        2.78 ±  3%  perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_child_process.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish
      0.00            +0.6        0.57        perf-profile.calltrace.cycles-pp.tcp_connect_init.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      9.32            +0.6        9.91        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process
      6.07            +0.6        6.66        perf-profile.calltrace.cycles-pp.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect
      0.00            +0.6        0.59        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process
      6.03            +0.6        6.64        perf-profile.calltrace.cycles-pp.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect
      8.35            +0.6        8.98        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg
      0.00            +0.6        0.64        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash_rcu.ip_route_output_flow.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req
      0.00            +0.7        0.65        perf-profile.calltrace.cycles-pp.ip_route_output_key_hash.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.tcp_init_sock.tcp_v4_init_sock.inet_create.__sock_create.__sys_socket
      0.00            +0.7        0.67        perf-profile.calltrace.cycles-pp.tcp_v4_init_sock.inet_create.__sock_create.__sys_socket.__x64_sys_socket
      7.87            +0.7        8.57        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked
      2.34 ± 12%      +0.7        3.04        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.tcp_sendmsg.__sys_sendto
      7.34            +0.7        8.05        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect
      2.75 ± 11%      +0.7        3.47        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
      3.32 ±  5%      +0.7        4.05        perf-profile.calltrace.cycles-pp.release_sock.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     10.02            +0.7       10.76        perf-profile.calltrace.cycles-pp.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock
      6.75            +0.7        7.50        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_connect.tcp_v4_connect.__inet_stream_connect
      0.58            +0.8        1.35        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      9.66            +0.8       10.46        perf-profile.calltrace.cycles-pp.__ip_queue_xmit.__tcp_transmit_skb.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv
     11.47            +0.8       12.30        perf-profile.calltrace.cycles-pp.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect
      0.00            +0.9        0.86        perf-profile.calltrace.cycles-pp.ip_route_output_flow.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
     32.81            +0.9       33.68        perf-profile.calltrace.cycles-pp.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit.__tcp_transmit_skb
      0.94 ±  2%      +0.9        1.82        perf-profile.calltrace.cycles-pp.tcp_ack.tcp_rcv_established.tcp_v4_do_rcv.__release_sock.release_sock
     32.68            +0.9       33.56        perf-profile.calltrace.cycles-pp.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2.__ip_queue_xmit
     32.42            +0.9       33.32        perf-profile.calltrace.cycles-pp.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit.ip_finish_output2
      3.32            +0.9        4.24        perf-profile.calltrace.cycles-pp.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu
      0.00            +0.9        0.94        perf-profile.calltrace.cycles-pp.ip_route_output_flow.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv
     31.26            +0.9       32.20        perf-profile.calltrace.cycles-pp.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip.__dev_queue_xmit
      0.00            +1.0        1.00        perf-profile.calltrace.cycles-pp.ip_route_output_flow.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv
      0.00            +1.0        1.00        perf-profile.calltrace.cycles-pp.inet_csk_route_req.tcp_conn_request.tcp_rcv_state_process.tcp_v4_do_rcv.tcp_v4_rcv
      8.58            +1.0        9.62        perf-profile.calltrace.cycles-pp.tcp_connect.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect
      0.00            +1.0        1.04        perf-profile.calltrace.cycles-pp.inet_csk_route_child_sock.tcp_v4_syn_recv_sock.tcp_check_req.tcp_v4_rcv.ip_protocol_deliver_rcu
     33.14            +1.0       34.18        perf-profile.calltrace.cycles-pp.__napi_poll.net_rx_action.handle_softirqs.do_softirq.__local_bh_enable_ip
     33.00            +1.1       34.06        perf-profile.calltrace.cycles-pp.process_backlog.__napi_poll.net_rx_action.handle_softirqs.do_softirq
     32.23            +1.2       33.46        perf-profile.calltrace.cycles-pp.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action.handle_softirqs
     14.34            +1.4       15.70        perf-profile.calltrace.cycles-pp.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     14.26            +1.4       15.62        perf-profile.calltrace.cycles-pp.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect.__sys_connect
     13.76            +1.4       15.14        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.__release_sock.release_sock.__inet_stream_connect.inet_stream_connect
     29.64            +1.4       31.05        perf-profile.calltrace.cycles-pp.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll.net_rx_action
     13.40            +1.4       14.81        perf-profile.calltrace.cycles-pp.tcp_rcv_synsent_state_process.tcp_rcv_state_process.tcp_v4_do_rcv.__release_sock.release_sock
     29.52            +1.4       30.94        perf-profile.calltrace.cycles-pp.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog.__napi_poll
     11.30            +1.5       12.78        perf-profile.calltrace.cycles-pp.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto
     13.28            +1.5       14.78        perf-profile.calltrace.cycles-pp.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64
     11.22            +1.5       12.71        perf-profile.calltrace.cycles-pp.tcp_write_xmit.__tcp_push_pending_frames.tcp_sendmsg_locked.tcp_sendmsg.__sys_sendto
     28.79            +1.5       30.34        perf-profile.calltrace.cycles-pp.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core.process_backlog
     15.86 ±  2%      +1.5       17.40        perf-profile.calltrace.cycles-pp.tcp_v4_do_rcv.tcp_v4_rcv.ip_protocol_deliver_rcu.ip_local_deliver_finish.__netif_receive_skb_one_core
      6.76            +1.6        8.34 ±  2%  perf-profile.calltrace.cycles-pp.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni
      6.86            +1.6        8.44 ±  2%  perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send.recv_omni.process_requests
      6.87            +1.6        8.45 ±  2%  perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.__send.recv_omni.process_requests.spawn_child
      7.12            +1.6        8.70 ±  2%  perf-profile.calltrace.cycles-pp.__send.recv_omni.process_requests.spawn_child.accept_connection
     11.01            +1.7       12.68        perf-profile.calltrace.cycles-pp.tcp_v4_connect.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect
     19.64            +2.2       21.80        perf-profile.calltrace.cycles-pp.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe.__send
     16.27            +2.2       18.46        perf-profile.calltrace.cycles-pp.recv_omni.process_requests.spawn_child.accept_connection.accept_connections
     19.26            +2.2       21.46        perf-profile.calltrace.cycles-pp.tcp_sendmsg.__sys_sendto.__x64_sys_sendto.do_syscall_64.entry_SYSCALL_64_after_hwframe
     26.56            +2.7       29.25        perf-profile.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner.send_tcp_conn_rr
     26.29            +2.7       29.00        perf-profile.calltrace.cycles-pp.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner
     26.25            +2.7       28.98        perf-profile.calltrace.cycles-pp.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe.connect
     26.05            +2.7       28.79        perf-profile.calltrace.cycles-pp.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64.entry_SYSCALL_64_after_hwframe
     25.88            +2.8       28.66        perf-profile.calltrace.cycles-pp.__inet_stream_connect.inet_stream_connect.__sys_connect.__x64_sys_connect.do_syscall_64
     26.65            +2.9       29.50        perf-profile.calltrace.cycles-pp.connect.send_omni_inner.send_tcp_conn_rr.main
     26.37            +2.9       29.26        perf-profile.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.connect.send_omni_inner.send_tcp_conn_rr.main
     21.16 ± 14%      +3.5       24.68        perf-profile.calltrace.cycles-pp.accept_connection.accept_connections.main
     21.16 ± 14%      +3.5       24.68        perf-profile.calltrace.cycles-pp.accept_connections.main
     21.16 ± 14%      +3.5       24.68        perf-profile.calltrace.cycles-pp.process_requests.spawn_child.accept_connection.accept_connections.main
     21.16 ± 14%      +3.5       24.68        perf-profile.calltrace.cycles-pp.spawn_child.accept_connection.accept_connections.main
     26.13            -2.2       23.91        perf-profile.children.cycles-pp.__close
     25.21            -2.1       23.08        perf-profile.children.cycles-pp.__x64_sys_close
     24.53            -2.0       22.48        perf-profile.children.cycles-pp.__fput
     22.30            -1.8       20.49        perf-profile.children.cycles-pp.sock_close
     22.26            -1.8       20.46        perf-profile.children.cycles-pp.__sock_release
     22.06            -1.8       20.29        perf-profile.children.cycles-pp.inet_release
     74.74            -1.7       73.04        perf-profile.children.cycles-pp.send_omni_inner
     74.35            -1.5       72.83        perf-profile.children.cycles-pp.send_tcp_conn_rr
     20.82            -1.3       19.54        perf-profile.children.cycles-pp.tcp_close
      9.02            -1.3        7.76        perf-profile.children.cycles-pp.omni_create_data_socket
     20.54            -1.2       19.31        perf-profile.children.cycles-pp.__tcp_close
      3.03 ±  4%      -0.9        2.10 ±  3%  perf-profile.children.cycles-pp.tcp_done
      2.18            -0.9        1.28        perf-profile.children.cycles-pp.__sk_destruct
      3.00 ±  3%      -0.9        2.12 ±  3%  perf-profile.children.cycles-pp._raw_spin_lock_bh
      2.84 ±  4%      -0.9        1.96 ±  3%  perf-profile.children.cycles-pp.tcp_set_state
      7.31            -0.8        6.47        perf-profile.children.cycles-pp.recv
      2.94 ±  6%      -0.8        2.11 ±  6%  perf-profile.children.cycles-pp.tcp_get_metrics
      6.86 ±  2%      -0.8        6.04        perf-profile.children.cycles-pp.tcp_data_queue
      2.76 ±  7%      -0.8        1.99 ±  6%  perf-profile.children.cycles-pp.__tcp_get_metrics
      2.16 ±  5%      -0.7        1.42 ±  4%  perf-profile.children.cycles-pp.inet_unhash
      4.30 ±  4%      -0.7        3.64 ±  2%  perf-profile.children.cycles-pp.tcp_fin
      4.38            -0.6        3.77        perf-profile.children.cycles-pp.__socket
      5.47            -0.6        4.87        perf-profile.children.cycles-pp.__x64_sys_recvfrom
      5.40            -0.6        4.82        perf-profile.children.cycles-pp.__sys_recvfrom
      4.83            -0.6        4.27        perf-profile.children.cycles-pp.tcp_recvmsg
      4.92            -0.6        4.37        perf-profile.children.cycles-pp.inet_recvmsg
      5.02            -0.6        4.47        perf-profile.children.cycles-pp.sock_recvmsg
      3.98            -0.5        3.43        perf-profile.children.cycles-pp.__x64_sys_socket
      3.94            -0.5        3.41        perf-profile.children.cycles-pp.__sys_socket
      4.48            -0.5        3.97        perf-profile.children.cycles-pp.tcp_recvmsg_locked
      1.33            -0.5        0.82        perf-profile.children.cycles-pp.sk_alloc
      3.44            -0.5        2.95        perf-profile.children.cycles-pp.kmem_cache_free
      1.55            -0.5        1.06        perf-profile.children.cycles-pp.tcp_create_openreq_child
      1.22            -0.4        0.79        perf-profile.children.cycles-pp.inet_csk_clone_lock
      1.80            -0.4        1.38        perf-profile.children.cycles-pp.inet_csk_destroy_sock
      1.15            -0.4        0.73        perf-profile.children.cycles-pp.sk_clone_lock
      2.94            -0.4        2.52        perf-profile.children.cycles-pp.__sock_create
      5.06            -0.4        4.70        perf-profile.children.cycles-pp.__schedule
      2.64            -0.4        2.28        perf-profile.children.cycles-pp.sk_wait_data
      2.00            -0.4        1.65        perf-profile.children.cycles-pp._raw_spin_lock
      4.36            -0.3        4.01        perf-profile.children.cycles-pp.schedule_timeout
      4.29            -0.3        3.96        perf-profile.children.cycles-pp.schedule
      1.61            -0.3        1.28        perf-profile.children.cycles-pp.inet_csk_get_port
      1.39            -0.3        1.07        perf-profile.children.cycles-pp.tcp_v4_destroy_sock
      2.37            -0.3        2.05        perf-profile.children.cycles-pp.wait_woken
      2.42            -0.3        2.12        perf-profile.children.cycles-pp.tcp_clean_rtx_queue
      2.50            -0.3        2.21        perf-profile.children.cycles-pp.bind
      1.48            -0.3        1.20        perf-profile.children.cycles-pp.kmem_cache_alloc_noprof
      2.03            -0.3        1.77        perf-profile.children.cycles-pp.dev_hard_start_xmit
      1.51            -0.3        1.25        perf-profile.children.cycles-pp.create_data_socket
      1.36            -0.2        1.12        perf-profile.children.cycles-pp.set_sock_buffer
      1.82            -0.2        1.59        perf-profile.children.cycles-pp.loopback_xmit
      1.97            -0.2        1.74        perf-profile.children.cycles-pp.inet_create
      1.29            -0.2        1.06        perf-profile.children.cycles-pp.getsockopt
      1.79            -0.2        1.57        perf-profile.children.cycles-pp.__memcg_slab_post_alloc_hook
      2.14            -0.2        1.93        perf-profile.children.cycles-pp.__x64_sys_bind
      1.71 ±  3%      -0.2        1.50 ±  3%  perf-profile.children.cycles-pp.sock_alloc
      1.29            -0.2        1.08        perf-profile.children.cycles-pp.__memcg_slab_free_hook
      2.13            -0.2        1.92        perf-profile.children.cycles-pp.__sys_bind
      1.77            -0.2        1.56        perf-profile.children.cycles-pp.__alloc_skb
      1.61 ±  3%      -0.2        1.41 ±  4%  perf-profile.children.cycles-pp.alloc_inode
      1.69            -0.2        1.52        perf-profile.children.cycles-pp.dput
      1.92            -0.2        1.75        perf-profile.children.cycles-pp.inet_bind_sk
      1.34 ±  2%      -0.2        1.17 ±  2%  perf-profile.children.cycles-pp.kmem_cache_alloc_lru_noprof
      1.18            -0.2        1.02        perf-profile.children.cycles-pp._raw_spin_lock_irqsave
      0.85            -0.2        0.69        perf-profile.children.cycles-pp.inet_put_port
      1.11 ±  2%      -0.2        0.95 ±  3%  perf-profile.children.cycles-pp.__mod_memcg_state
      1.90            -0.2        1.74        perf-profile.children.cycles-pp.__inet_bind
      1.45            -0.2        1.30        perf-profile.children.cycles-pp.__pick_next_task
      1.42            -0.2        1.27        perf-profile.children.cycles-pp.pick_next_task_fair
      0.72 ± 11%      -0.2        0.57 ±  9%  perf-profile.children.cycles-pp.smpboot_thread_fn
      0.98 ±  6%      -0.1        0.83 ±  4%  perf-profile.children.cycles-pp.rcu_core
      0.60            -0.1        0.46        perf-profile.children.cycles-pp.tcp_schedule_loss_probe
      0.96            -0.1        0.82        perf-profile.children.cycles-pp.__sk_mem_reduce_allocated
      0.93 ±  6%      -0.1        0.79 ±  5%  perf-profile.children.cycles-pp.rcu_do_batch
      1.74            -0.1        1.60        perf-profile.children.cycles-pp.syscall_exit_to_user_mode
      0.84            -0.1        0.70 ±  2%  perf-profile.children.cycles-pp.mem_cgroup_uncharge_skmem
      1.52            -0.1        1.38        perf-profile.children.cycles-pp.__inet_lookup_skb
      0.76            -0.1        0.63        perf-profile.children.cycles-pp.setsockopt
      1.53 ±  2%      -0.1        1.40 ±  2%  perf-profile.children.cycles-pp.__cond_resched
      1.35            -0.1        1.22        perf-profile.children.cycles-pp.clear_bhb_loop
      0.54 ±  6%      -0.1        0.41 ±  2%  perf-profile.children.cycles-pp.fib_table_lookup
      1.46            -0.1        1.33        perf-profile.children.cycles-pp.__dentry_kill
      0.66            -0.1        0.54        perf-profile.children.cycles-pp.sk_prot_alloc
      0.58            -0.1        0.45        perf-profile.children.cycles-pp.__inet_bhash2_update_saddr
      0.68            -0.1        0.56        perf-profile.children.cycles-pp.__sys_getsockopt
      0.85            -0.1        0.73        perf-profile.children.cycles-pp.__kfree_skb
      0.70            -0.1        0.58        perf-profile.children.cycles-pp.__x64_sys_getsockopt
      1.00            -0.1        0.89        perf-profile.children.cycles-pp.kmem_cache_alloc_node_noprof
      1.01            -0.1        0.90        perf-profile.children.cycles-pp.skb_release_data
      0.51            -0.1        0.40        perf-profile.children.cycles-pp.__ip_finish_output
      1.59 ±  2%      -0.1        1.48        perf-profile.children.cycles-pp.ip_rcv
      0.89 ±  3%      -0.1        0.78 ±  4%  perf-profile.children.cycles-pp.sock_alloc_inode
      1.61            -0.1        1.50        perf-profile.children.cycles-pp.alloc_file_pseudo
      1.36            -0.1        1.25        perf-profile.children.cycles-pp.enqueue_task
      1.66            -0.1        1.56        perf-profile.children.cycles-pp.sock_alloc_file
      1.09            -0.1        0.99        perf-profile.children.cycles-pp.tcp_stream_alloc_skb
      1.28            -0.1        1.18        perf-profile.children.cycles-pp.dequeue_entities
      0.76            -0.1        0.66        perf-profile.children.cycles-pp.mod_objcg_state
      0.67            -0.1        0.57        perf-profile.children.cycles-pp.__tcp_send_ack
      0.43            -0.1        0.33        perf-profile.children.cycles-pp.sk_stop_timer
      0.82            -0.1        0.73 ±  2%  perf-profile.children.cycles-pp.inet_csk_bind_conflict
      0.59            -0.1        0.49        perf-profile.children.cycles-pp.do_sock_getsockopt
      0.63            -0.1        0.53        perf-profile.children.cycles-pp.ip_rcv_core
      1.10            -0.1        1.00        perf-profile.children.cycles-pp.__inet_lookup_established
      0.78            -0.1        0.68        perf-profile.children.cycles-pp.validate_xmit_skb
      0.63            -0.1        0.53        perf-profile.children.cycles-pp.lock_timer_base
      0.88            -0.1        0.79        perf-profile.children.cycles-pp.tcp_send_fin
      0.34 ±  2%      -0.1        0.25        perf-profile.children.cycles-pp.skb_release_head_state
      0.81 ±  2%      -0.1        0.72        perf-profile.children.cycles-pp.dequeue_entity
      0.68            -0.1        0.59        perf-profile.children.cycles-pp.lock_sock_nested
      0.55            -0.1        0.46        perf-profile.children.cycles-pp.tcp_make_synack
      0.36            -0.1        0.27        perf-profile.children.cycles-pp.dst_release
      0.56            -0.1        0.47        perf-profile.children.cycles-pp.inet_csk_reqsk_queue_hash_add
      0.65            -0.1        0.56        perf-profile.children.cycles-pp.entry_SYSCALL_64
      0.97 ±  3%      -0.1        0.88        perf-profile.children.cycles-pp.ktime_get
      0.70            -0.1        0.61        perf-profile.children.cycles-pp.syscall_return_via_sysret
      0.66            -0.1        0.57        perf-profile.children.cycles-pp.sched_clock_cpu
      0.69 ±  3%      -0.1        0.61 ±  4%  perf-profile.children.cycles-pp.inode_init_always_gfp
      0.81            -0.1        0.73        perf-profile.children.cycles-pp.update_load_avg
      0.85 ±  2%      -0.1        0.77        perf-profile.children.cycles-pp.mem_cgroup_charge_skmem
      1.15            -0.1        1.07        perf-profile.children.cycles-pp.enqueue_task_fair
      0.36            -0.1        0.28        perf-profile.children.cycles-pp.inet_csk_clear_xmit_timers
      0.38            -0.1        0.30        perf-profile.children.cycles-pp.ip_skb_dst_mtu
      0.49            -0.1        0.41        perf-profile.children.cycles-pp.__ip_local_out
      0.38            -0.1        0.31        perf-profile.children.cycles-pp._copy_from_user
      0.74            -0.1        0.66        perf-profile.children.cycles-pp.__netif_rx
      0.68            -0.1        0.61        perf-profile.children.cycles-pp.d_alloc_pseudo
      0.66            -0.1        0.59        perf-profile.children.cycles-pp.__d_alloc
      0.56            -0.1        0.48        perf-profile.children.cycles-pp.__check_object_size
      0.42            -0.1        0.34        perf-profile.children.cycles-pp.__inet_check_established
      0.46 ±  4%      -0.1        0.39 ±  4%  perf-profile.children.cycles-pp.cgroup_rstat_updated
      0.70            -0.1        0.63 ±  2%  perf-profile.children.cycles-pp.inet_bind_conflict
      0.48            -0.1        0.40        perf-profile.children.cycles-pp.inet_ehash_insert
      0.58            -0.1        0.51 ±  2%  perf-profile.children.cycles-pp.sched_clock
      0.71            -0.1        0.64        perf-profile.children.cycles-pp.irqtime_account_irq
      0.23 ±  2%      -0.1        0.16 ±  2%  perf-profile.children.cycles-pp.sk_stream_kill_queues
      0.29 ± 10%      -0.1        0.22 ±  9%  perf-profile.children.cycles-pp.select_task_rq_fair
      0.17 ±  2%      -0.1        0.10 ±  3%  perf-profile.children.cycles-pp.tcp_newly_delivered
      0.69            -0.1        0.62        perf-profile.children.cycles-pp.netif_rx_internal
      0.35 ± 10%      -0.1        0.28 ±  7%  perf-profile.children.cycles-pp.select_task_rq
      0.99            -0.1        0.92        perf-profile.children.cycles-pp.sk_reset_timer
      0.45            -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.native_queued_spin_lock_slowpath
      0.32            -0.1        0.25        perf-profile.children.cycles-pp.timer_delete
      0.27            -0.1        0.20 ±  2%  perf-profile.children.cycles-pp.tcp_options_write
      0.63            -0.1        0.56        perf-profile.children.cycles-pp.enqueue_to_backlog
      0.56            -0.1        0.49        perf-profile.children.cycles-pp.kmalloc_reserve
      0.64            -0.1        0.57        perf-profile.children.cycles-pp.read_tsc
      0.42            -0.1        0.35        perf-profile.children.cycles-pp.__x64_sys_setsockopt
      1.30            -0.1        1.24        perf-profile.children.cycles-pp.dequeue_task_fair
      0.83            -0.1        0.76        perf-profile.children.cycles-pp.__netif_receive_skb_core
      0.96            -0.1        0.89        perf-profile.children.cycles-pp.tcp_event_new_data_sent
      0.42            -0.1        0.35        perf-profile.children.cycles-pp.sk_getsockopt
      0.40            -0.1        0.34        perf-profile.children.cycles-pp.__sys_setsockopt
      0.46            -0.1        0.39        perf-profile.children.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.63            -0.1        0.56        perf-profile.children.cycles-pp.tcp_mstamp_refresh
      0.38            -0.1        0.32        perf-profile.children.cycles-pp._raw_spin_lock_irq
      1.03            -0.1        0.97        perf-profile.children.cycles-pp.__mod_timer
      0.47            -0.1        0.41        perf-profile.children.cycles-pp.__inet_hash_connect
      0.15 ±  2%      -0.1        0.09        perf-profile.children.cycles-pp.tcp_v4_send_check
      1.42            -0.1        1.36        perf-profile.children.cycles-pp.try_to_block_task
      1.45            -0.1        1.39        perf-profile.children.cycles-pp.ttwu_do_activate
      0.47            -0.1        0.41        perf-profile.children.cycles-pp.ip_local_out
      0.44 ±  2%      -0.1        0.38 ±  3%  perf-profile.children.cycles-pp.netif_skb_features
      0.46            -0.1        0.41        perf-profile.children.cycles-pp.pick_task_fair
      0.55            -0.1        0.49        perf-profile.children.cycles-pp.tcp_try_rmem_schedule
      0.70            -0.1        0.64        perf-profile.children.cycles-pp.switch_mm_irqs_off
      0.19 ±  2%      -0.1        0.13 ±  2%  perf-profile.children.cycles-pp.sk_skb_reason_drop
      0.20            -0.1        0.14 ±  3%  perf-profile.children.cycles-pp.xa_destroy
      0.36            -0.1        0.30        perf-profile.children.cycles-pp.do_sock_setsockopt
      0.28            -0.1        0.22 ±  2%  perf-profile.children.cycles-pp.ipv4_mtu
      0.48            -0.1        0.43 ±  2%  perf-profile.children.cycles-pp.alloc_empty_file
      0.46            -0.1        0.40        perf-profile.children.cycles-pp.fdget
      0.38            -0.1        0.33        perf-profile.children.cycles-pp.skb_do_copy_data_nocache
      0.14            -0.1        0.09        perf-profile.children.cycles-pp.tcp_event_data_recv
      0.23 ±  2%      -0.0        0.18        perf-profile.children.cycles-pp.secure_tcp_seq
      0.29            -0.0        0.24        perf-profile.children.cycles-pp.tcp_add_backlog
      0.33            -0.0        0.28        perf-profile.children.cycles-pp.tcp_init_xmit_timers
      0.35            -0.0        0.30        perf-profile.children.cycles-pp.evict
      0.28 ±  2%      -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.check_heap_object
      0.52            -0.0        0.48 ±  2%  perf-profile.children.cycles-pp.__skb_datagram_iter
      0.47            -0.0        0.42        perf-profile.children.cycles-pp.obj_cgroup_charge
      0.31 ±  2%      -0.0        0.27        perf-profile.children.cycles-pp.percpu_counter_add_batch
      0.19            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.obj_cgroup_uncharge_pages
      0.31            -0.0        0.26        perf-profile.children.cycles-pp.__skb_clone
      0.30 ±  2%      -0.0        0.25        perf-profile.children.cycles-pp.try_charge_memcg
      0.27 ±  2%      -0.0        0.23 ±  4%  perf-profile.children.cycles-pp.tcp_write_queue_purge
      0.25 ±  6%      -0.0        0.21        perf-profile.children.cycles-pp._copy_to_user
      0.40 ±  2%      -0.0        0.35 ±  2%  perf-profile.children.cycles-pp.destroy_inode
      0.16            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.inet_reqsk_alloc
      0.17 ±  2%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.inet_bind2_bucket_create
      0.22            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.refill_obj_stock
      0.22            -0.0        0.18        perf-profile.children.cycles-pp.tcp_wfree
      0.20            -0.0        0.16        perf-profile.children.cycles-pp.move_addr_to_kernel
      0.56            -0.0        0.52 ±  2%  perf-profile.children.cycles-pp.skb_copy_datagram_iter
      0.18            -0.0        0.14        perf-profile.children.cycles-pp.get_random_u32
      0.16            -0.0        0.12        perf-profile.children.cycles-pp.tcp_sync_mss
      0.11 ±  3%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.__sock_wfree
      0.13            -0.0        0.09        perf-profile.children.cycles-pp.tcp_rate_skb_sent
      0.23            -0.0        0.19        perf-profile.children.cycles-pp.ip_send_check
      0.37            -0.0        0.33 ±  2%  perf-profile.children.cycles-pp.__destroy_inode
      0.16 ±  2%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.__sk_free
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.bpf_skops_write_hdr_opt
      0.12            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.get_random_u16
      0.24 ±  2%      -0.0        0.21 ±  2%  perf-profile.children.cycles-pp.rcu_all_qs
      0.20 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.tcp_check_space
      0.38            -0.0        0.34 ±  2%  perf-profile.children.cycles-pp.tcp_current_mss
      0.26            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.update_rq_clock_task
      0.15            -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.__memcpy
      0.16            -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.inet_bind_bucket_create
      0.42 ±  2%      -0.0        0.38        perf-profile.children.cycles-pp.switch_fpu_return
      0.14            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.tcp_update_skb_after_send
      0.26            -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__call_rcu_common
      0.25 ±  2%      -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.memset_orig
      0.48            -0.0        0.44        perf-profile.children.cycles-pp.native_sched_clock
      0.33            -0.0        0.29 ±  2%  perf-profile.children.cycles-pp.put_prev_entity
      0.36            -0.0        0.32        perf-profile.children.cycles-pp.inet_ehashfn
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.__hrtimer_init
      0.18            -0.0        0.15 ±  3%  perf-profile.children.cycles-pp.rseq_get_rseq_cs
      0.27            -0.0        0.24        perf-profile.children.cycles-pp.sk_setsockopt
      0.26            -0.0        0.22 ±  4%  perf-profile.children.cycles-pp.raw_local_deliver
      0.19            -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.update_min_vruntime
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.sk_free
      0.46            -0.0        0.43        perf-profile.children.cycles-pp.__sk_mem_schedule
      0.14 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.rb_first
      0.15 ±  2%      -0.0        0.12        perf-profile.children.cycles-pp.pick_next_port_number
      0.28            -0.0        0.25        perf-profile.children.cycles-pp._raw_spin_unlock_irqrestore
      0.37            -0.0        0.34        perf-profile.children.cycles-pp.prepare_task_switch
      0.18 ±  3%      -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.sk_setup_caps
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.__virt_addr_valid
      0.13 ±  3%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.inet_sock_destruct
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.kfree_skbmem
      0.13 ±  5%      -0.0        0.10 ±  3%  perf-profile.children.cycles-pp.security_file_release
      0.13            -0.0        0.10        perf-profile.children.cycles-pp.sock_i_uid
      0.31            -0.0        0.28        perf-profile.children.cycles-pp.rseq_ip_fixup
      0.16 ±  2%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp.tcp_urg
      0.18            -0.0        0.15 ±  2%  perf-profile.children.cycles-pp.kfree
      0.27            -0.0        0.24 ±  2%  perf-profile.children.cycles-pp.sock_def_wakeup
      0.23 ±  2%      -0.0        0.20        perf-profile.children.cycles-pp.__update_load_avg_cfs_rq
      0.10            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.consume_skb
      0.14 ±  2%      -0.0        0.11        perf-profile.children.cycles-pp._get_random_bytes
      0.14 ±  2%      -0.0        0.11        perf-profile.children.cycles-pp.xa_find
      0.24 ±  2%      -0.0        0.22 ±  3%  perf-profile.children.cycles-pp.__switch_to_asm
      0.20 ±  2%      -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.inet_ehash_nolisten
      0.28            -0.0        0.25        perf-profile.children.cycles-pp.__update_load_avg_se
      0.11 ±  3%      -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.skb_push
      0.21 ±  2%      -0.0        0.19 ±  3%  perf-profile.children.cycles-pp.inet_csk_complete_hashdance
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.tcp_synack_rtt_meas
      0.11            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.tcp_chrono_stop
      0.49            -0.0        0.46        perf-profile.children.cycles-pp.__rseq_handle_notify_resume
      0.34 ±  2%      -0.0        0.32        perf-profile.children.cycles-pp.restore_fpregs_from_fpstate
      0.47            -0.0        0.44        perf-profile.children.cycles-pp.set_next_entity
      0.20            -0.0        0.18 ±  4%  perf-profile.children.cycles-pp._copy_to_iter
      0.20            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_established_options
      0.14 ±  3%      -0.0        0.12        perf-profile.children.cycles-pp.__build_skb_around
      0.19 ±  2%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.skb_network_protocol
      0.23            -0.0        0.21 ±  3%  perf-profile.children.cycles-pp.tcp_queue_rcv
      0.19 ±  2%      -0.0        0.17 ±  3%  perf-profile.children.cycles-pp.x64_sys_call
      0.07 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.tcp_small_queue_check
      0.13 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.connect_data_socket
      0.15 ±  3%      -0.0        0.12 ±  3%  perf-profile.children.cycles-pp.ip_finish_output
      0.08 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.ktime_get_seconds
      0.43            -0.0        0.41        perf-profile.children.cycles-pp.__sk_mem_raise_allocated
      0.25            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.__switch_to
      0.25 ±  3%      -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.d_instantiate
      0.12            -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.sock_copy
      0.22            -0.0        0.20 ±  2%  perf-profile.children.cycles-pp.__wake_up
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.chacha_block_generic
      0.10 ±  3%      -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.init_timer_key
      0.17 ±  2%      -0.0        0.14 ±  3%  perf-profile.children.cycles-pp.sock_put
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp.tcp_rate_gen
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.__fput_sync
      0.32            -0.0        0.30 ±  3%  perf-profile.children.cycles-pp.__inet_inherit_port
      0.10            -0.0        0.08        perf-profile.children.cycles-pp.__refill_stock
      0.18 ±  3%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.recv_data
      0.22            -0.0        0.20        perf-profile.children.cycles-pp.tcp_ack_update_window
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.__try_to_del_timer_sync
      0.10 ±  3%      -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.hrtimer_try_to_cancel
      0.13 ±  4%      -0.0        0.11        perf-profile.children.cycles-pp.raw_v4_input
      0.09            -0.0        0.07        perf-profile.children.cycles-pp.rb_next
      0.07            -0.0        0.05        perf-profile.children.cycles-pp.tcp_sndbuf_expand
      0.15 ±  3%      -0.0        0.13 ±  3%  perf-profile.children.cycles-pp.__get_user_8
      0.11            -0.0        0.09        perf-profile.children.cycles-pp.ktime_get_with_offset
      0.20            -0.0        0.18 ±  2%  perf-profile.children.cycles-pp.tcp_v4_fill_cb
      0.12            -0.0        0.10        perf-profile.children.cycles-pp.__copy_skb_header
      0.18 ±  2%      -0.0        0.16 ±  3%  perf-profile.children.cycles-pp.___perf_sw_event
      0.10            -0.0        0.08 ±  4%  perf-profile.children.cycles-pp.chacha_permute
      0.18 ±  3%      -0.0        0.16 ±  2%  perf-profile.children.cycles-pp.__inet_lookup_listener
      0.08 ±  4%      -0.0        0.06        perf-profile.children.cycles-pp._raw_write_lock_bh
      0.10 ±  3%      -0.0        0.08        perf-profile.children.cycles-pp.remove_wait_queue
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp._raw_read_lock_bh
      0.08            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.siphash_1u64
      0.06            -0.0        0.04 ± 44%  perf-profile.children.cycles-pp.tcp_ack_tstamp
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.siphash_3u32
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.skb_rbtree_purge
      0.11 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.tcp_release_cb
      0.24            -0.0        0.22 ±  2%  perf-profile.children.cycles-pp.simple_copy_to_iter
      0.29            -0.0        0.28        perf-profile.children.cycles-pp.sk_filter_trim_cap
      0.10            -0.0        0.08 ±  5%  perf-profile.children.cycles-pp.__timer_delete_sync
      0.23            -0.0        0.21        perf-profile.children.cycles-pp.tcp_inbound_hash
      0.08 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.crng_make_state
      0.08            -0.0        0.06 ±  7%  perf-profile.children.cycles-pp.__calc_delta
      0.11            -0.0        0.09 ±  5%  perf-profile.children.cycles-pp._atomic_dec_and_lock
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.netdev_core_pick_tx
      0.09            -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.sock_rfree
      0.24 ±  2%      -0.0        0.23        perf-profile.children.cycles-pp.tcp_send_mss
      0.10 ±  5%      -0.0        0.08        perf-profile.children.cycles-pp.security_sk_free
      0.14            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.syscall_exit_to_user_mode_prepare
      0.09            -0.0        0.08 ±  6%  perf-profile.children.cycles-pp.xfrm_lookup_route
      0.07 ±  5%      -0.0        0.06 ±  8%  perf-profile.children.cycles-pp.netlink_has_listeners
      0.15 ±  3%      -0.0        0.13 ±  2%  perf-profile.children.cycles-pp._copy_from_iter
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.detach_if_pending
      0.12 ±  3%      -0.0        0.11 ±  4%  perf-profile.children.cycles-pp.neigh_hh_output
      0.09 ±  4%      -0.0        0.07 ±  6%  perf-profile.children.cycles-pp.xas_find
      0.25            -0.0        0.23 ±  2%  perf-profile.children.cycles-pp.__dequeue_entity
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.__xfrm_policy_check2
      0.07 ±  6%      -0.0        0.06        perf-profile.children.cycles-pp.map_id_range_down
      0.13            -0.0        0.12 ±  4%  perf-profile.children.cycles-pp.rseq_update_cpu_node_id
      0.13 ±  3%      -0.0        0.12        perf-profile.children.cycles-pp.__usecs_to_jiffies
      0.10 ±  4%      -0.0        0.09        perf-profile.children.cycles-pp.add_wait_queue
      0.08 ±  4%      -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.down_write
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.children.cycles-pp.finish_task_switch
      0.08 ±  5%      -0.0        0.07        perf-profile.children.cycles-pp.rb_insert_color
      0.30            -0.0        0.28        perf-profile.children.cycles-pp.skb_attempt_defer_free
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.children.cycles-pp.update_rq_clock
      0.10            -0.0        0.09 ±  4%  perf-profile.children.cycles-pp.filp_flush
      0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.get_sock_buffer
      0.07            -0.0        0.06 ±  6%  perf-profile.children.cycles-pp.inet_csk_update_fastreuse
      0.09 ±  4%      -0.0        0.08        perf-profile.children.cycles-pp.qdisc_pkt_len_init
      0.07 ±  5%      -0.0        0.06        perf-profile.children.cycles-pp.select_idle_cpu
      0.17 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.__enqueue_entity
      0.08            -0.0        0.07 ±  5%  perf-profile.children.cycles-pp.disconnect_data_socket
      0.12 ±  3%      -0.0        0.11        perf-profile.children.cycles-pp.file_close_fd
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.inet_csk_init_xmit_timers
      0.10 ±  3%      -0.0        0.09        perf-profile.children.cycles-pp.inet_sk_rx_dst_set
      0.11 ±  3%      -0.0        0.10        perf-profile.children.cycles-pp.ip_build_and_send_pkt
      0.12            -0.0        0.11 ±  3%  perf-profile.children.cycles-pp.ip_output
      0.17 ±  2%      -0.0        0.16        perf-profile.children.cycles-pp.os_xsave
      0.15            -0.0        0.14 ±  2%  perf-profile.children.cycles-pp.security_sock_rcv_skb
      0.06 ±  6%      -0.0        0.05        perf-profile.children.cycles-pp.tcp_rate_skb_delivered
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.clear_inode
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.crng_fast_key_erasure
      0.09            -0.0        0.08        perf-profile.children.cycles-pp.init_file
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.lockref_put_return
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.rcu_segcblist_enqueue
      0.13            -0.0        0.12        perf-profile.children.cycles-pp.update_irq_load_avg
      0.07            -0.0        0.06        perf-profile.children.cycles-pp.xfrm_lookup_with_ifid
      0.08            -0.0        0.07        perf-profile.children.cycles-pp.truncate_inode_pages_final
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.cubictcp_acked
      0.06            -0.0        0.05        perf-profile.children.cycles-pp.hrtimer_active
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.__get_user_4
      0.05            +0.0        0.06        perf-profile.children.cycles-pp.d_set_d_op
      0.10 ±  4%      +0.0        0.11        perf-profile.children.cycles-pp.file_init_path
      0.32            +0.0        0.34        perf-profile.children.cycles-pp.pick_eevdf
      0.06 ±  9%      +0.0        0.07 ±  5%  perf-profile.children.cycles-pp.dentry_unlink_inode
      0.25            +0.0        0.26        perf-profile.children.cycles-pp.kmem_cache_charge
      0.10            +0.0        0.12        perf-profile.children.cycles-pp.validate_xmit_xfrm
      0.17 ±  2%      +0.0        0.20 ±  3%  perf-profile.children.cycles-pp.tcp_rtt_estimator
      0.34 ±  3%      +0.0        0.37 ±  2%  perf-profile.children.cycles-pp.check_preempt_wakeup_fair
      0.23 ±  2%      +0.0        0.28        perf-profile.children.cycles-pp.ipv4_default_advmss
      0.42 ±  2%      +0.0        0.47        perf-profile.children.cycles-pp.wakeup_preempt
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.dequeue_task
      0.00            +0.1        0.05        perf-profile.children.cycles-pp.tcp_try_fastopen
      0.00            +0.1        0.06 ±  7%  perf-profile.children.cycles-pp.cookie_v4_check
      0.12 ±  3%      +0.1        0.19        perf-profile.children.cycles-pp.tcp_syn_options
      0.16 ±  2%      +0.2        0.32        perf-profile.children.cycles-pp.secure_tcp_ts_off
      0.19            +0.2        0.35        perf-profile.children.cycles-pp.tcp_openreq_init_rwin
      0.42            +0.2        0.59        perf-profile.children.cycles-pp.tcp_connect_init
      0.31            +0.2        0.49 ±  2%  perf-profile.children.cycles-pp.__tcp_select_window
      0.08 ±  4%      +0.2        0.26        perf-profile.children.cycles-pp.tcp_ca_openreq_child
      0.15            +0.2        0.34 ±  2%  perf-profile.children.cycles-pp.tcp_mtup_init
      0.71 ±  4%      +0.2        0.90 ±  6%  perf-profile.children.cycles-pp.tcp_v4_send_reset
      0.67 ±  4%      +0.2        0.86 ±  5%  perf-profile.children.cycles-pp.ip_send_unicast_reply
      0.13 ±  2%      +0.2        0.34        perf-profile.children.cycles-pp.tcp_skb_entail
      0.34            +0.2        0.56        perf-profile.children.cycles-pp.tcp_parse_options
      0.13 ±  3%      +0.3        0.40        perf-profile.children.cycles-pp.__tcp_ack_snd_check
      5.21            +0.3        5.48        perf-profile.children.cycles-pp.tcp_rcv_established
      0.40            +0.3        0.66        perf-profile.children.cycles-pp.ip_route_output_key_hash
      0.39            +0.3        0.68        perf-profile.children.cycles-pp.tcp_init_sock
      0.39            +0.3        0.69        perf-profile.children.cycles-pp.tcp_v4_init_sock
      4.38            +0.3        4.72        perf-profile.children.cycles-pp.tcp_child_process
      0.11            +0.3        0.45 ±  2%  perf-profile.children.cycles-pp.tcp_select_initial_window
     36.57            +0.4       36.96        perf-profile.children.cycles-pp.ip_finish_output2
      0.14 ±  2%      +0.4        0.55        perf-profile.children.cycles-pp.tcp_rack_update_reo_wnd
      0.13 ±  2%      +0.4        0.55        perf-profile.children.cycles-pp.tcp_assign_congestion_control
      2.99            +0.4        3.43        perf-profile.children.cycles-pp.tcp_v4_syn_recv_sock
      1.76 ±  3%      +0.4        2.21 ±  3%  perf-profile.children.cycles-pp.tcp_finish_connect
      3.51            +0.4        3.96        perf-profile.children.cycles-pp.tcp_check_req
     35.98            +0.5       36.49        perf-profile.children.cycles-pp.__dev_queue_xmit
      0.41            +0.6        1.02        perf-profile.children.cycles-pp.inet_csk_route_req
      0.41 ±  2%      +0.6        1.06        perf-profile.children.cycles-pp.inet_csk_route_child_sock
     36.30            +0.7       37.00        perf-profile.children.cycles-pp.handle_softirqs
      4.43            +0.7        5.14        perf-profile.children.cycles-pp.tcp_ack
     36.31            +0.8       37.08        perf-profile.children.cycles-pp.__local_bh_enable_ip
      0.10 ±  3%      +0.8        0.91        perf-profile.children.cycles-pp.inet_sk_rebuild_header
     35.75            +0.8       36.56        perf-profile.children.cycles-pp.do_softirq
     93.47            +0.9       94.33        perf-profile.children.cycles-pp.entry_SYSCALL_64_after_hwframe
     34.17            +0.9       35.06        perf-profile.children.cycles-pp.net_rx_action
      0.22 ±  2%      +0.9        1.15 ±  2%  perf-profile.children.cycles-pp.tcp_tso_segs
      3.39            +0.9        4.32        perf-profile.children.cycles-pp.tcp_conn_request
     92.92            +0.9       93.85        perf-profile.children.cycles-pp.do_syscall_64
     33.69            +0.9       34.63        perf-profile.children.cycles-pp.__napi_poll
     33.57            +1.0       34.52        perf-profile.children.cycles-pp.process_backlog
      3.25 ±  3%      +1.0        4.22 ±  3%  perf-profile.children.cycles-pp.tcp_init_transfer
     28.72            +1.0       29.72        perf-profile.children.cycles-pp.tcp_rcv_state_process
      8.75            +1.0        9.76        perf-profile.children.cycles-pp.tcp_connect
     32.87            +1.0       33.92        perf-profile.children.cycles-pp.__netif_receive_skb_one_core
      0.21            +1.1        1.29        perf-profile.children.cycles-pp.tcp_update_pacing_rate
      0.26 ±  6%      +1.1        1.41        perf-profile.children.cycles-pp.__mkroute_output
     25.78            +1.2       27.00        perf-profile.children.cycles-pp.__tcp_push_pending_frames
     25.65            +1.2       26.89        perf-profile.children.cycles-pp.tcp_write_xmit
     30.22            +1.3       31.47        perf-profile.children.cycles-pp.ip_local_deliver_finish
      1.05 ±  3%      +1.3        2.31        perf-profile.children.cycles-pp.ip_route_output_key_hash_rcu
     30.12            +1.3       31.38        perf-profile.children.cycles-pp.ip_protocol_deliver_rcu
      0.22 ±  5%      +1.3        1.50        perf-profile.children.cycles-pp.__ip_dev_find
     21.97            +1.3       23.29        perf-profile.children.cycles-pp.__release_sock
     13.66            +1.4       15.04        perf-profile.children.cycles-pp.tcp_rcv_synsent_state_process
     29.42            +1.4       30.81        perf-profile.children.cycles-pp.tcp_v4_rcv
     13.45            +1.5       14.92        perf-profile.children.cycles-pp.tcp_sendmsg_locked
     11.23            +1.7       12.88        perf-profile.children.cycles-pp.tcp_v4_connect
     41.12            +1.7       42.83        perf-profile.children.cycles-pp.__tcp_transmit_skb
     18.79            +1.9       20.72        perf-profile.children.cycles-pp.release_sock
     21.13            +2.1       23.18        perf-profile.children.cycles-pp.__send
     20.10            +2.1       22.19        perf-profile.children.cycles-pp.__x64_sys_sendto
     20.01            +2.1       22.11        perf-profile.children.cycles-pp.__sys_sendto
      1.11            +2.1        3.21        perf-profile.children.cycles-pp.ip_route_output_flow
     38.13            +2.1       40.24        perf-profile.children.cycles-pp.__ip_queue_xmit
     22.57            +2.1       24.68        perf-profile.children.cycles-pp.accept_connection
     22.57            +2.1       24.68        perf-profile.children.cycles-pp.accept_connections
     22.57            +2.1       24.68        perf-profile.children.cycles-pp.process_requests
     22.57            +2.1       24.68        perf-profile.children.cycles-pp.spawn_child
     19.64            +2.1       21.79        perf-profile.children.cycles-pp.tcp_sendmsg
     16.27            +2.2       18.46        perf-profile.children.cycles-pp.recv_omni
     36.99            +2.8       39.74        perf-profile.children.cycles-pp.tcp_v4_do_rcv
     27.38            +2.8       30.16        perf-profile.children.cycles-pp.connect
     26.68            +2.9       29.54        perf-profile.children.cycles-pp.__x64_sys_connect
     26.64            +2.9       29.51        perf-profile.children.cycles-pp.__sys_connect
     26.43            +2.9       29.33        perf-profile.children.cycles-pp.inet_stream_connect
     26.27            +2.9       29.20        perf-profile.children.cycles-pp.__inet_stream_connect
      0.24 ±  2%      +3.3        3.54        perf-profile.children.cycles-pp.__sk_dst_check
      0.12 ±  5%      +4.0        4.08        perf-profile.children.cycles-pp.ipv4_dst_check
      2.93 ±  4%      -0.9        2.06 ±  3%  perf-profile.self.cycles-pp._raw_spin_lock_bh
      2.74 ±  7%      -0.8        1.98 ±  6%  perf-profile.self.cycles-pp.__tcp_get_metrics
      1.41            -0.7        0.69        perf-profile.self.cycles-pp.__sk_destruct
      1.94            -0.4        1.49        perf-profile.self.cycles-pp.__tcp_transmit_skb
      0.76            -0.4        0.37        perf-profile.self.cycles-pp.sk_alloc
      0.76            -0.4        0.41        perf-profile.self.cycles-pp.sk_clone_lock
      1.52            -0.3        1.26        perf-profile.self.cycles-pp._raw_spin_lock
      0.73            -0.3        0.47        perf-profile.self.cycles-pp.__tcp_close
      1.73            -0.2        1.52        perf-profile.self.cycles-pp.kmem_cache_free
      0.73 ±  3%      -0.2        0.56 ±  3%  perf-profile.self.cycles-pp.ip_finish_output2
      1.10            -0.2        0.94        perf-profile.self.cycles-pp._raw_spin_lock_irqsave
      1.02            -0.2        0.86        perf-profile.self.cycles-pp.tcp_ack
      1.33            -0.1        1.21        perf-profile.self.cycles-pp.clear_bhb_loop
      0.59            -0.1        0.47        perf-profile.self.cycles-pp.kmem_cache_alloc_noprof
      0.39 ±  7%      -0.1        0.27 ±  3%  perf-profile.self.cycles-pp.fib_table_lookup
      0.75            -0.1        0.63        perf-profile.self.cycles-pp.__memcg_slab_post_alloc_hook
      0.25            -0.1        0.14 ±  2%  perf-profile.self.cycles-pp.inet_csk_get_port
      0.38            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.tcp_schedule_loss_probe
      0.90            -0.1        0.80        perf-profile.self.cycles-pp.kmem_cache_alloc_node_noprof
      0.61            -0.1        0.52        perf-profile.self.cycles-pp.ip_rcv_core
      0.62            -0.1        0.52        perf-profile.self.cycles-pp.mod_objcg_state
      0.68 ±  4%      -0.1        0.59 ±  5%  perf-profile.self.cycles-pp.__mod_memcg_state
      0.73            -0.1        0.64        perf-profile.self.cycles-pp.__dev_queue_xmit
      0.33            -0.1        0.24        perf-profile.self.cycles-pp.dst_release
      0.56            -0.1        0.48        perf-profile.self.cycles-pp.tcp_clean_rtx_queue
      0.55            -0.1        0.48        perf-profile.self.cycles-pp.entry_SYSCALL_64_after_hwframe
      0.37            -0.1        0.29        perf-profile.self.cycles-pp.ip_skb_dst_mtu
      0.85            -0.1        0.77        perf-profile.self.cycles-pp.__inet_lookup_established
      0.34            -0.1        0.27 ±  2%  perf-profile.self.cycles-pp.ip_protocol_deliver_rcu
      0.45            -0.1        0.38 ±  4%  perf-profile.self.cycles-pp.native_queued_spin_lock_slowpath
      0.37            -0.1        0.30        perf-profile.self.cycles-pp._copy_from_user
      0.69            -0.1        0.62 ±  3%  perf-profile.self.cycles-pp.inet_bind_conflict
      0.49            -0.1        0.42        perf-profile.self.cycles-pp.__memcg_slab_free_hook
      0.26            -0.1        0.19        perf-profile.self.cycles-pp.tcp_options_write
      0.44 ±  4%      -0.1        0.37 ±  4%  perf-profile.self.cycles-pp.cgroup_rstat_updated
      0.61            -0.1        0.54        perf-profile.self.cycles-pp.read_tsc
      0.16 ±  2%      -0.1        0.10 ±  3%  perf-profile.self.cycles-pp.tcp_newly_delivered
      0.30            -0.1        0.23 ±  2%  perf-profile.self.cycles-pp.tcp_data_queue
      0.33 ± 10%      -0.1        0.26 ±  7%  perf-profile.self.cycles-pp.__slab_free
      0.36            -0.1        0.30        perf-profile.self.cycles-pp._raw_spin_lock_irq
      0.53            -0.1        0.47        perf-profile.self.cycles-pp.__alloc_skb
      0.44            -0.1        0.38        perf-profile.self.cycles-pp.entry_SYSRETQ_unsafe_stack
      0.81            -0.1        0.75        perf-profile.self.cycles-pp.__netif_receive_skb_core
      0.46            -0.1        0.40        perf-profile.self.cycles-pp.loopback_xmit
      0.17 ±  2%      -0.1        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_get_metrics
      0.46            -0.1        0.40        perf-profile.self.cycles-pp.do_syscall_64
      0.39            -0.1        0.34        perf-profile.self.cycles-pp.__cond_resched
      0.56            -0.1        0.51        perf-profile.self.cycles-pp.syscall_exit_to_user_mode
      0.24            -0.1        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_set_state
      0.69            -0.1        0.63        perf-profile.self.cycles-pp.switch_mm_irqs_off
      0.27            -0.1        0.22 ±  2%  perf-profile.self.cycles-pp.ipv4_mtu
      0.44            -0.1        0.38        perf-profile.self.cycles-pp.fdget
      0.20 ±  2%      -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.enqueue_task_fair
      0.22 ±  2%      -0.1        0.17 ±  2%  perf-profile.self.cycles-pp.ip_rcv
      0.20            -0.1        0.15 ±  2%  perf-profile.self.cycles-pp.tcp_ack_update_rtt
      0.18            -0.1        0.13        perf-profile.self.cycles-pp.tcp_make_synack
      0.46            -0.0        0.41        perf-profile.self.cycles-pp.net_rx_action
      0.13            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_v4_send_check
      0.13            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.tcp_event_data_recv
      0.32            -0.0        0.27        perf-profile.self.cycles-pp.send_omni_inner
      0.35 ±  2%      -0.0        0.30        perf-profile.self.cycles-pp.skb_release_data
      0.26            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__ip_local_out
      0.21            -0.0        0.17        perf-profile.self.cycles-pp.tcp_wfree
      0.56            -0.0        0.52        perf-profile.self.cycles-pp.__local_bh_enable_ip
      0.30 ±  2%      -0.0        0.26 ±  2%  perf-profile.self.cycles-pp.percpu_counter_add_batch
      0.10            -0.0        0.06        perf-profile.self.cycles-pp.__sock_wfree
      0.16 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__sys_sendto
      0.25 ±  3%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.memset_orig
      0.28 ±  2%      -0.0        0.24        perf-profile.self.cycles-pp.try_charge_memcg
      0.25 ±  3%      -0.0        0.21 ±  4%  perf-profile.self.cycles-pp.netif_skb_features
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.refill_obj_stock
      0.12            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.tcp_rate_skb_sent
      0.46            -0.0        0.43 ±  2%  perf-profile.self.cycles-pp.native_sched_clock
      0.32            -0.0        0.28        perf-profile.self.cycles-pp.syscall_return_via_sysret
      0.10            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.tcp_check_req
      0.07            -0.0        0.03 ± 70%  perf-profile.self.cycles-pp.get_random_u16
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.sk_reset_timer
      0.25            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.tcp_event_new_data_sent
      0.22            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_rcv_established
      0.19            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.tcp_check_space
      0.24 ±  5%      -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._copy_to_user
      0.11 ±  3%      -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.select_task_rq_fair
      0.34            -0.0        0.30        perf-profile.self.cycles-pp.inet_ehashfn
      0.35            -0.0        0.31        perf-profile.self.cycles-pp.tcp_sendmsg_locked
      0.26            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.mem_cgroup_uncharge_skmem
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.__inet_bhash2_update_saddr
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.__inet_check_established
      0.24 ±  2%      -0.0        0.20 ±  5%  perf-profile.self.cycles-pp.raw_local_deliver
      0.17 ±  2%      -0.0        0.14        perf-profile.self.cycles-pp.update_min_vruntime
      0.13 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.bpf_skops_write_hdr_opt
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.ip_route_output_flow
      0.14 ±  3%      -0.0        0.11 ±  3%  perf-profile.self.cycles-pp.tcp_sync_mss
      0.14 ±  2%      -0.0        0.11        perf-profile.self.cycles-pp.__memcpy
      0.18 ±  2%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.__hrtimer_init
      0.37            -0.0        0.34        perf-profile.self.cycles-pp.process_backlog
      0.20 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.rcu_all_qs
      0.15            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_v4_connect
      0.20 ±  3%      -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.lock_timer_base
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.ip_send_check
      0.19            -0.0        0.16        perf-profile.self.cycles-pp.tcp_validate_incoming
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.sk_free
      0.15 ±  3%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.skb_release_head_state
      0.21 ±  2%      -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__update_load_avg_cfs_rq
      0.16 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.__virt_addr_valid
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.tcp_update_skb_after_send
      0.13 ±  4%      -0.0        0.10        perf-profile.self.cycles-pp.__ip_finish_output
      0.21            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.dev_hard_start_xmit
      0.23 ±  2%      -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.kmem_cache_alloc_lru_noprof
      0.18 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.sk_setup_caps
      0.11            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.rb_first
      0.11 ±  3%      -0.0        0.08        perf-profile.self.cycles-pp.sk_stop_timer
      0.19            -0.0        0.16 ±  3%  perf-profile.self.cycles-pp.__call_rcu_common
      0.24            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__switch_to_asm
      0.19            -0.0        0.16        perf-profile.self.cycles-pp.kfree_skbmem
      0.32            -0.0        0.29        perf-profile.self.cycles-pp.update_load_avg
      0.18 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.__netif_receive_skb_one_core
      0.09            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__sk_free
      0.08            -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.tcp_try_rmem_schedule
      0.12 ±  3%      -0.0        0.09 ±  4%  perf-profile.self.cycles-pp.__copy_skb_header
      0.24            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp._raw_spin_unlock_irqrestore
      0.24 ±  2%      -0.0        0.22        perf-profile.self.cycles-pp.validate_xmit_skb
      0.34 ±  2%      -0.0        0.32 ±  2%  perf-profile.self.cycles-pp.restore_fpregs_from_fpstate
      0.18 ±  3%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.tcp_send_fin
      0.18 ±  2%      -0.0        0.15        perf-profile.self.cycles-pp.x64_sys_call
      0.10 ±  5%      -0.0        0.07        perf-profile.self.cycles-pp.tcp_chrono_stop
      0.08            -0.0        0.06 ±  9%  perf-profile.self.cycles-pp.xa_destroy
      0.14 ±  3%      -0.0        0.12        perf-profile.self.cycles-pp.pick_next_task_fair
      0.09 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.skb_push
      0.15            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.tcp_create_openreq_child
      0.23            -0.0        0.20 ±  2%  perf-profile.self.cycles-pp.__fput
      0.33            -0.0        0.30        perf-profile.self.cycles-pp.tcp_recvmsg_locked
      0.14 ±  3%      -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.ip_finish_output
      0.26            -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.do_softirq
      0.14 ±  2%      -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.inet_unhash
      0.27            -0.0        0.25        perf-profile.self.cycles-pp.obj_cgroup_charge
      0.18 ±  2%      -0.0        0.15 ±  3%  perf-profile.self.cycles-pp.skb_network_protocol
      0.13 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.tcp_urg
      0.12 ±  4%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.update_rq_clock_task
      0.13 ±  3%      -0.0        0.11        perf-profile.self.cycles-pp.wait_woken
      0.12 ±  3%      -0.0        0.10        perf-profile.self.cycles-pp.__build_skb_around
      0.24            -0.0        0.21 ±  2%  perf-profile.self.cycles-pp.__switch_to
      0.20            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp._copy_to_iter
      0.11 ±  4%      -0.0        0.09        perf-profile.self.cycles-pp.timer_delete
      0.24            -0.0        0.22 ±  2%  perf-profile.self.cycles-pp.__inet_lookup_skb
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.get_random_u32
      0.08 ±  4%      -0.0        0.06        perf-profile.self.cycles-pp.siphash_3u32
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.tcp_add_backlog
      0.11 ±  4%      -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.tcp_v4_destroy_sock
      0.25            -0.0        0.23        perf-profile.self.cycles-pp.__update_load_avg_se
      0.19            -0.0        0.17        perf-profile.self.cycles-pp.dequeue_entity
      0.20            -0.0        0.18        perf-profile.self.cycles-pp.entry_SYSCALL_64
      0.18 ±  2%      -0.0        0.16        perf-profile.self.cycles-pp.tcp_established_options
      0.14            -0.0        0.12        perf-profile.self.cycles-pp.create_data_socket
      0.14            -0.0        0.12        perf-profile.self.cycles-pp.tcp_rearm_rto
      0.13            -0.0        0.11        perf-profile.self.cycles-pp.__tcp_push_pending_frames
      0.11 ±  4%      -0.0        0.09 ±  5%  perf-profile.self.cycles-pp.enqueue_entity
      0.10 ±  4%      -0.0        0.08 ±  6%  perf-profile.self.cycles-pp.obj_cgroup_uncharge_pages
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.rb_insert_color
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.siphash_1u64
      0.08            -0.0        0.06        perf-profile.self.cycles-pp.tcp_openreq_init_rwin
      0.07 ±  5%      -0.0        0.05 ±  7%  perf-profile.self.cycles-pp.tcp_rate_gen
      0.07            -0.0        0.05        perf-profile.self.cycles-pp.ktime_get_seconds
      0.09 ±  4%      -0.0        0.07 ±  5%  perf-profile.self.cycles-pp.init_timer_key
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.kfree
      0.18            -0.0        0.16 ±  2%  perf-profile.self.cycles-pp.__skb_clone
      0.19 ±  3%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.tcp_connect
      0.10            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.chacha_permute
      0.26 ±  2%      -0.0        0.24 ±  2%  perf-profile.self.cycles-pp.enqueue_to_backlog
      0.06            -0.0        0.04 ± 44%  perf-profile.self.cycles-pp.inet_csk_clone_lock
      0.09 ±  4%      -0.0        0.07        perf-profile.self.cycles-pp.sock_rfree
      0.16 ±  3%      -0.0        0.14 ±  3%  perf-profile.self.cycles-pp.sock_put
      0.07 ±  6%      -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.rb_next
      0.14            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_queue_rcv
      0.12 ±  3%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.__inet_stream_connect
      0.09            -0.0        0.07 ±  6%  perf-profile.self.cycles-pp.__refill_stock
      0.08            -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.getsockopt
      0.12 ±  4%      -0.0        0.10 ±  4%  perf-profile.self.cycles-pp.raw_v4_input
      0.16 ±  2%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.tcp_inbound_hash
      0.18 ±  2%      -0.0        0.17 ±  2%  perf-profile.self.cycles-pp.tcp_v4_fill_cb
      0.19            -0.0        0.18 ±  2%  perf-profile.self.cycles-pp.__check_object_size
      0.14            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.__get_user_8
      0.10            -0.0        0.08 ±  5%  perf-profile.self.cycles-pp.__x64_sys_close
      0.15 ±  2%      -0.0        0.13 ±  3%  perf-profile.self.cycles-pp.recv_data
      0.14            -0.0        0.12 ±  4%  perf-profile.self.cycles-pp.security_sock_rcv_skb
      0.07 ±  5%      -0.0        0.05 ±  8%  perf-profile.self.cycles-pp.connect_data_socket
      0.08 ±  4%      -0.0        0.06 ±  7%  perf-profile.self.cycles-pp.__ip_append_data
      0.08 ±  6%      -0.0        0.06        perf-profile.self.cycles-pp.inet_csk_destroy_sock
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.__xfrm_policy_check2
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.map_id_range_down
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.tcp_sndbuf_expand
      0.15 ±  3%      -0.0        0.14 ±  2%  perf-profile.self.cycles-pp.___perf_sw_event
      0.21            -0.0        0.19 ±  2%  perf-profile.self.cycles-pp.__sys_recvfrom
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.disconnect_data_socket
      0.07            -0.0        0.06 ±  8%  perf-profile.self.cycles-pp.netlink_has_listeners
      0.11 ±  3%      -0.0        0.10 ±  3%  perf-profile.self.cycles-pp.neigh_hh_output
      0.08            -0.0        0.07 ±  7%  perf-profile.self.cycles-pp.tcp_recvmsg
      0.06 ±  7%      -0.0        0.05        perf-profile.self.cycles-pp.get_sock_buffer
      0.12            -0.0        0.11 ±  4%  perf-profile.self.cycles-pp.syscall_exit_to_user_mode_prepare
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp._raw_write_lock_bh
      0.09            -0.0        0.08 ±  4%  perf-profile.self.cycles-pp.inet_twsk_alloc
      0.07 ±  5%      -0.0        0.06        perf-profile.self.cycles-pp.sk_prot_alloc
      0.13            -0.0        0.12 ±  3%  perf-profile.self.cycles-pp.tcp_current_mss
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.inet_release
      0.06 ±  6%      -0.0        0.05        perf-profile.self.cycles-pp.security_sk_free
      0.10 ±  3%      -0.0        0.09        perf-profile.self.cycles-pp.sk_wait_data
      0.16            -0.0        0.15        perf-profile.self.cycles-pp.__enqueue_entity
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.__tcp_send_ack
      0.07            -0.0        0.06        perf-profile.self.cycles-pp._atomic_dec_and_lock
      0.14            -0.0        0.13        perf-profile.self.cycles-pp._copy_from_iter
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.detach_if_pending
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.entry_SYSCALL_64_safe_stack
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.finish_task_switch
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.init_file
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.lockref_put_return
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.netdev_core_pick_tx
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.schedule
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.sk_getsockopt
      0.07            -0.0        0.06        perf-profile.self.cycles-pp.switch_fpu_return
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.tcp_release_cb
      0.09            -0.0        0.08        perf-profile.self.cycles-pp.tcp_write_queue_purge
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.__sk_mem_reduce_allocated
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.do_accept
      0.08            -0.0        0.07        perf-profile.self.cycles-pp.sched_clock_cpu
      0.12            -0.0        0.11        perf-profile.self.cycles-pp.update_irq_load_avg
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.ip_local_out
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.pick_next_port_number
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.tcp_child_process
      0.06            -0.0        0.05        perf-profile.self.cycles-pp.tcp_rate_skb_delivered
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.__usecs_to_jiffies
      0.11            -0.0        0.10        perf-profile.self.cycles-pp.ip_output
      0.05            +0.0        0.06        perf-profile.self.cycles-pp.__get_user_4
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.__sys_connect
      0.06            +0.0        0.07        perf-profile.self.cycles-pp.dequeue_task_fair
      0.05            +0.0        0.06 ±  6%  perf-profile.self.cycles-pp.alloc_file_pseudo
      0.09            +0.0        0.10 ±  4%  perf-profile.self.cycles-pp.sk_forced_mem_schedule
      0.10 ±  4%      +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.reweight_entity
      0.05 ±  7%      +0.0        0.07 ±  5%  perf-profile.self.cycles-pp.__rseq_handle_notify_resume
      0.42            +0.0        0.44        perf-profile.self.cycles-pp.handle_softirqs
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.dentry_unlink_inode
      0.05            +0.0        0.07        perf-profile.self.cycles-pp.wakeup_preempt
      0.09            +0.0        0.11 ±  3%  perf-profile.self.cycles-pp.validate_xmit_xfrm
      1.05            +0.0        1.08        perf-profile.self.cycles-pp.tcp_v4_rcv
      0.15            +0.0        0.18 ±  2%  perf-profile.self.cycles-pp.tcp_rtt_estimator
      0.02 ± 99%      +0.0        0.06        perf-profile.self.cycles-pp.d_set_d_op
      0.23            +0.0        0.27        perf-profile.self.cycles-pp.ipv4_default_advmss
      0.16            +0.0        0.21        perf-profile.self.cycles-pp.tcp_connect_init
      0.15 ±  2%      +0.0        0.20 ±  3%  perf-profile.self.cycles-pp.tcp_rcv_synsent_state_process
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__inet_hash_connect
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.__rb_insert_augmented
      0.00            +0.1        0.05        perf-profile.self.cycles-pp.tcp_try_fastopen
      0.00            +0.1        0.05 ±  8%  perf-profile.self.cycles-pp.rseq_ip_fixup
      0.00            +0.1        0.06 ±  7%  perf-profile.self.cycles-pp.cookie_v4_check
      0.76            +0.1        0.83        perf-profile.self.cycles-pp.__ip_queue_xmit
      0.06 ±  6%      +0.1        0.14 ±  3%  perf-profile.self.cycles-pp.tcp_syn_options
      0.11            +0.1        0.20        perf-profile.self.cycles-pp.tcp_init_sock
      0.30            +0.1        0.39        perf-profile.self.cycles-pp.ip_route_output_key_hash_rcu
      0.07 ±  5%      +0.1        0.17 ±  2%  perf-profile.self.cycles-pp.tcp_fin
      0.17 ±  2%      +0.1        0.30        perf-profile.self.cycles-pp.tcp_init_transfer
      0.08 ±  4%      +0.2        0.25        perf-profile.self.cycles-pp.secure_tcp_ts_off
      0.30            +0.2        0.48 ±  2%  perf-profile.self.cycles-pp.__tcp_select_window
      0.08 ±  4%      +0.2        0.27 ±  2%  perf-profile.self.cycles-pp.tcp_v4_send_synack
      0.15 ±  2%      +0.2        0.34 ±  2%  perf-profile.self.cycles-pp.tcp_mtup_init
      0.12 ±  3%      +0.2        0.32        perf-profile.self.cycles-pp.__inet_bind
      0.11 ±  4%      +0.2        0.32        perf-profile.self.cycles-pp.tcp_skb_entail
      0.34            +0.2        0.55        perf-profile.self.cycles-pp.tcp_parse_options
      0.11 ±  4%      +0.2        0.32 ±  2%  perf-profile.self.cycles-pp.tcp_v4_syn_recv_sock
      0.28            +0.2        0.53        perf-profile.self.cycles-pp.tcp_conn_request
      0.13            +0.3        0.39        perf-profile.self.cycles-pp.__tcp_ack_snd_check
      0.11 ±  3%      +0.3        0.44 ±  2%  perf-profile.self.cycles-pp.tcp_select_initial_window
      0.55            +0.4        0.90        perf-profile.self.cycles-pp.tcp_write_xmit
      0.13            +0.4        0.54        perf-profile.self.cycles-pp.tcp_rack_update_reo_wnd
      0.12 ±  4%      +0.4        0.54        perf-profile.self.cycles-pp.tcp_assign_congestion_control
      1.36 ±  7%      +0.5        1.89 ±  5%  perf-profile.self.cycles-pp.tcp_update_metrics
      1.16 ±  5%      +0.6        1.74 ±  6%  perf-profile.self.cycles-pp.tcp_init_metrics
      0.22 ±  2%      +0.9        1.14 ±  2%  perf-profile.self.cycles-pp.tcp_tso_segs
      0.20 ±  2%      +1.1        1.28        perf-profile.self.cycles-pp.tcp_update_pacing_rate
      0.24 ±  7%      +1.1        1.38        perf-profile.self.cycles-pp.__mkroute_output
      0.16 ±  6%      +1.3        1.46        perf-profile.self.cycles-pp.__ip_dev_find
      0.11 ±  4%      +3.9        4.05        perf-profile.self.cycles-pp.ipv4_dst_check




Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


