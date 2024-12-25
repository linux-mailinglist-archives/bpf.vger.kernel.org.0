Return-Path: <bpf+bounces-47609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82E669FC5D0
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 15:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8BE17A11BD
	for <lists+bpf@lfdr.de>; Wed, 25 Dec 2024 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAEE1BD517;
	Wed, 25 Dec 2024 14:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CcFeyioe"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A541BBBDC;
	Wed, 25 Dec 2024 14:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735136634; cv=fail; b=kapoxqi3vggeMiHCS7fNApSLO6yCQDP9yHkzmC5nwEr3ED55T+EwjfLzqPpT1Qt0Ys/gYMJn3pZ0ppe/YcbwmfhyZCFcNPgIQNpHLyqJDpGYrkEgKxH4FkcB1Oz27aL7nwJ/LYc94xCmDc1V7+Ehjoi6bOhN+1y5BEuA9q130uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735136634; c=relaxed/simple;
	bh=+jGXb8wzbnGvNVM37THvZ0bogt1JWkDXE/WCdKEmsg0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=D3Sv7ZcX8xGOpvVhu460Fy5Vi/v02ri7ZxI8V6CQKIRh+NDXE+mcbHR48wLQjgD4u/QDu3a3g3kVLoTDYDv2qu1r0CRN7X5T24yw0dZn9a235ngBCjiPyPJBqztji91k2ct/DHoQA+8ScDRUvlCio7qogkKoxUUBLqsEu2sIGYE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CcFeyioe; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735136632; x=1766672632;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=+jGXb8wzbnGvNVM37THvZ0bogt1JWkDXE/WCdKEmsg0=;
  b=CcFeyioe8fv5YmIjaN4IpIMJ1At9QCkWCYX6K6pJz3UfJTtFJMxoOocY
   30Cbwpctt1ZjEq0aN2JLJYqdSfjjaspPuTR1oHZF1ksvLeNOJEwwH2h3s
   5uNnieEVdwaPARWkfbJDWl/llEM9w/tdxrahQ34TQYFVR1/5eZq5FgFMv
   2IoqtgOl7dhKPhB9koTli7ajz26oM1WSLDtQuMffkpLiCGGjFC39VuDyl
   8DZgzdReogYULr1KUQQGTcJulUUBZsuNBrAVSV6yRD4HtlXMD2Z0XhPPg
   50BwuNCwy1VauQucBl5w61ddrHPYp8grTHRP8MVedfxxbt/01b85GgEu+
   Q==;
X-CSE-ConnectionGUID: 1Ogd8NHtSXapm/zBhSMkbQ==
X-CSE-MsgGUID: lu//rrSURT63vR0fakzbGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="39362188"
X-IronPort-AV: E=Sophos;i="6.12,263,1728975600"; 
   d="scan'208";a="39362188"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Dec 2024 06:23:51 -0800
X-CSE-ConnectionGUID: arHJ36pGRPCX0LWmA5iMlQ==
X-CSE-MsgGUID: XSDyUs8iSpmkqYEv4Py1lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="130708378"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Dec 2024 06:23:50 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 25 Dec 2024 06:23:50 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 25 Dec 2024 06:23:50 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 25 Dec 2024 06:23:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fXW+audc2K3Z1n63345lELKdO/sNyyJF7q2vzBF5NuWBdKWannjuyqsJoo6IhQ5u9HxRW3ygSlrjTR32XLPzJIQvD2FU819Eztdoz0K01k/l0GjN1FaTiKR+gaRLCq5zbrEqi+usSTkMd2+vdEwdKJTXLr3SGsDHyOgERIEhXlRWf1+us+cjfu2lGPh3y8IH6ifmrSSETr7bFh0hugczAwxBVGHv37z9/qqKN/UHoDpyOWKfFA65d+ECl8YCjYPShcPg31+ukzXZ4XiL8ZVIH1nRrET8FwNbVDh09aBq/wqZtU2ssSR9yQbtqN3fLjkhdM9h3Hzw7mIrU4izV3ymGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGwDFGMSfpDMigRXsjIIFgk37CpUnmwlYdSI1hIr2zY=;
 b=lrDcMrcRanvsvUVc+KUmhGo83oPd8GvKO2an2NqCWvPNdx1y427oqYfSNubT4a5h2xnlzt9jYBeiW0LmS54W5dOxsp7a0We8R7VGds63V9U60JCuDyOcCgCfERUQ7ho2t1HQe18JGVj1YYG3oEXfdNLgeulBje1DyZ94Mj42sIxqDOvo7mxpdmswVWwiDdWsiTgdU6YlRuoAfq7OXf4Cc6YinYHZI4R0qMLU5OjS6P2XLNk5cFgJ50PgFil4h3UK0w87oMZSczBdGX1doEPtXQDal9a9nARWyx/MOsVjCft14ebsq52xG0LPSU91VS0RVVK9fAYe7fpWKmaG2dWSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DS0PR11MB7384.namprd11.prod.outlook.com (2603:10b6:8:134::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Wed, 25 Dec
 2024 14:23:44 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%6]) with mapi id 15.20.8293.000; Wed, 25 Dec 2024
 14:23:43 +0000
Date: Wed, 25 Dec 2024 22:23:34 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Zijian Zhang <zijianzhang@bytedance.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<oliver.sang@intel.com>
Subject: [linus:master] [bpf, sockmap]  5d609ba262:
 BUG:KASAN:null-ptr-deref_in_splice_to_socket
Message-ID: <202412252136.8e8395f3-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DS0PR11MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: ee356889-1b7e-41b5-5ac7-08dd24efbcb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?tuleeEbYEjsiDN9cB9SpTiTlDf3e5+1TJlXCpfQtE6qXJDpO7PxLJ/r88sAn?=
 =?us-ascii?Q?OH3wtJz1ubny/grrX94zEwm/Cz+N+LIu+wrSgtj5FcU8mZteV5rD3gzcdzah?=
 =?us-ascii?Q?IY93AKpj9ltVlMNwJst7lzJCWmuoV+KAKmtfTs7DmF3B6+owPgQ/wShm1R5V?=
 =?us-ascii?Q?yF7rjC04g+u+LlG+w4060kxpfjqv+Z9k+rbBdkhebsQHshI44OVUaa4yLTri?=
 =?us-ascii?Q?O94D0kh2fhDCr89bc6ulfdMMP1Fl84QZdKI6txA2ue3MkWFzwsqwBqtve8UW?=
 =?us-ascii?Q?1bzSWN8ZqfQC8r/cKzSuOSUrVUx5lZJdUcvGlYcLpmnHQh//vv1/mLK5jDOw?=
 =?us-ascii?Q?7H4tCGhFh19FZPU2eBgPgjPhjIPo7beRnjK6zuk39UBLOJBf36eakAeFDqHT?=
 =?us-ascii?Q?J3yvxUJ8xF7TGYOgyrI2BWyYzewf0jvGbkU7Qf2xS6PhDl0V/Gy5b0jBr8e5?=
 =?us-ascii?Q?4X44c8n81GzEy2AHHS+TY4hJVEL7/iKVsum/6q822DKe4/YUbORSdX6qteuU?=
 =?us-ascii?Q?pSdn/VftATcOle47ADgJ5xQ/xeIAE87+hsIAM+9K2E8w/DEf5j1SweGbkymo?=
 =?us-ascii?Q?8AfljoCdytgIHkfIyWPte6DchiMU2r8L6AT2ZIY/X3uPmVZ+jFb3y6y7HUNZ?=
 =?us-ascii?Q?MNBf6dmFlG0PYl1WXyZDRXIgIpO0VI1MVhPYT4b2KSDaijFyH2zXQt1Kp/op?=
 =?us-ascii?Q?avuu4RWV4/VPnwMUYhRjS4MShKdhpce+UqFf+cqlrNNQndAA6seEQ3SOA05t?=
 =?us-ascii?Q?emyFucFytcjG+LzJ7xyO4w8e2o3KC8EEjXwzUoI1KNxvVaQc8uuLJ2HjIafN?=
 =?us-ascii?Q?Juj/LDTW0xCsTI31iM6XWhH5tFYCwcX6mOZxIJGmgaOUEZ02KX9hulXf/MHo?=
 =?us-ascii?Q?s9g+8EP2suLQEVNmC8n6zSRzWYXemiCGckBds4getijnpBcG5iUz4O5It6j8?=
 =?us-ascii?Q?IC/rTS5gZqLMXfpCWNzZsw2XA5wq6cSzrCUWkc0swvjonYZ7i34+BrxbB6mT?=
 =?us-ascii?Q?iaCfsQgirWlaTGjCbvbCh++F28c5nAoZeewMBoQbQdc6zFLT7cI6NbYYkewQ?=
 =?us-ascii?Q?R1IxBrQssoparEfhi2XVwK09IA0I/cpNY75Fk5wbqVk76rJZtMH+8OuStcaI?=
 =?us-ascii?Q?bJAlzV8qDFDygsNrSNxFBDEIudLZVn+mKkeqJ66wcW+v+OfQKeLQNPEZs0lc?=
 =?us-ascii?Q?QCwQJKTs2BgAa+3HZWj2sJZZl0TY43hATqlzQaxSWMC/b3o7YqJU9RC8ffRs?=
 =?us-ascii?Q?6Fo0XI8cdtr3pmFrcCgiObRz8IWJgDJzgd2J+NVAx1QykowKBNXEROz7NZbF?=
 =?us-ascii?Q?bW8ZhvbQ6K2gHsGBj5TNMa5TfvBkl/5osKT4GgvRD9tW1g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0nUibGAbkRiawdju2gE1iI/sC4dD2/KWGrE13XctgTIj7ntOaQWl6IsKO4g0?=
 =?us-ascii?Q?BNJ9x6U01f5VbrAh4BUEIUNpfBnAesblfI79I3tLuoo6dFOaw9JUDrc8LA3L?=
 =?us-ascii?Q?BdDTPKnm9CzgGEfzrIXZXsVLYakucvYbONjW8GzTQj+jGIgKyJxHSFrksWJj?=
 =?us-ascii?Q?WYrWlpT4uH7FzdF11Qm5JF/CVfVeRLi+aCvwlhH8ByGbMzfOM8TDsmBUvVtp?=
 =?us-ascii?Q?Pwt5ccVSQ9YC0fAD3Vj2fEK/cErkFWwlYX72raVzvbENdEk7Z2cJU/hz/URy?=
 =?us-ascii?Q?q+LSkrgW8lNlFDAnk1xi6ekzzniPHQvtZiaS08tzl9TktIzc/l0ImL3oheAQ?=
 =?us-ascii?Q?7vXysSwYCjAZUfxlJnxCsIn/xAaBJwPONRcIM+M6OtNiisTotHE1MhEjGRrH?=
 =?us-ascii?Q?X1K5pvpxzrwn0sA2TbW3nyITotf8uLQ4YeBdWfHchs4oPd8zoEhWm7uNVOL/?=
 =?us-ascii?Q?PDyeLvFVtHCEhS1GTcudB0TdCgA4yK0IQbWBIxsdd4V66niLVaP0IlxWOoA1?=
 =?us-ascii?Q?wunYaVjObI6cHzI6ePQ4ajv9uHyfVNPXcu6BAequoacdmrnwfQ4paJrbUElV?=
 =?us-ascii?Q?/qIJH94BO7+RO992ixeiR8eqnPrSd7bTi/6r/pzegzUgW5OIISbUupZ5Sndt?=
 =?us-ascii?Q?bUWQpHmeHb9qXL9JZaBfdfuCceCvKkCzCEW49aBXNiFVL9dzrQd3gnppCZYM?=
 =?us-ascii?Q?/GW9dgONZfpc+L/TZAz15k6kDNwVIHz7h9iUcuqC5PAVhi38bI6stBNuNTgx?=
 =?us-ascii?Q?IlEnFWnqERdLrtWvy9ThOWXopHlvA/btIUU0nlHWHPbgkbrNbQk6E4bOuJO1?=
 =?us-ascii?Q?n1zMsilAFin2rDOrf++hhOsr78zd9geTzmgl3s5kTw4QVrNt19ltwLhurFzL?=
 =?us-ascii?Q?zlQiuqBfeiZbjKcDk2X9TyFFyrQGH7wCX0KGiGh1iXu3hi2rOKSstxKfGoV1?=
 =?us-ascii?Q?UmrOjapoOrGnCacEseD6zyR3Vnngn5hvWCVaGG72P5Cr/+WYG9PVNaCS2y3p?=
 =?us-ascii?Q?f/4mmUAakOQ3Mej+g11l2Qu0Oe4qicPw85dE1EpP+E7U0Crn9VGMwzC3cjvv?=
 =?us-ascii?Q?P/3jby3RduVGNVK3X/0Evt2FCtWfBFvbUt+RpavVjIe+WQCRBShcrlUNqVZa?=
 =?us-ascii?Q?7FD1ZFBnW3GNc+vnZRRf6MU1k4tTizNXutSC99aNE48KDALJoK14JCJljTy7?=
 =?us-ascii?Q?muqOiBeRa2+IrHCFtM2irAY+9UME3HQmdciZvneMxwx4YicQYsHnn9PEZeyG?=
 =?us-ascii?Q?jaA3znIBgeIeoM/BQfW8WARxQGFo2II4F+V6TL4zaM9AhXTpQmiMTcW1xr82?=
 =?us-ascii?Q?OBWcwCKqoEFKU67jb1V8GasvslTm2VYbTr9qXPoJVrUvo9cCjXcC1sbdGN+R?=
 =?us-ascii?Q?Cyg5MvgNU069PNW9naYUoRYA2jn0J0K+hA4ggAz34tMsfVAvf0aaXFENwvBe?=
 =?us-ascii?Q?02CA4k55tCgVbHcgQo0f4wDDDbzkfSmcgFk5rwDYS1nFQPp5vyAzfuBv/um5?=
 =?us-ascii?Q?FEwsOVN5Eyi/LNN6Uxwt9JJ//18Y+TsvKG2lZC6QWCH6fgv0nyRg19TNj46s?=
 =?us-ascii?Q?4y4i4mtQs6y8cPjqExOmQTQfKyQtbfbHyfO0fUNzvUhI7JFDvzJpVjj+wkxv?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee356889-1b7e-41b5-5ac7-08dd24efbcb6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 14:23:43.9063
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPz3mPjRm6Y5CxPfL8nUTUYi/L5FwUB/goVfPN4Ojx3EtSuQczI83+o5qt403k5tFGvXT0aDG1D1aQZGYbxVHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7384
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:null-ptr-deref_in_splice_to_socket" on=
:

commit: 5d609ba262475db450ba69b8e8a557bd768ac07a ("bpf, sockmap: Several fi=
xes to bpf_msg_pop_data")
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

[test failed on linus/master      8faabc041a001140564f718dabe37753e88b37fa]
[test failed on linux-next/master 8155b4ef3466f0e289e8fcc9e6e62f3f4dceeac2]

in testcase: kernel-selftests-bpf
version:=20
with following parameters:

	group: bpf



config: x86_64-rhel-9.4-bpf
compiler: gcc-12
test machine: 8 threads 1 sockets Intel(R) Core(TM) i7-7700 CPU @ 3.60GHz (=
Kaby Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)


If you fix the issue in a separate patch/commit (i.e. not just a new versio=
n of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202412252136.8e8395f3-lkp@intel.co=
m


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20241225/202412252136.8e8395f3-lkp@=
intel.com


[ 1571.082367][T49469] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1571.092110][T49469] BUG: KASAN: null-ptr-deref in splice_to_socket+0x6d3=
/0x7d0
[ 1571.099401][T49469] Read of size 8 at addr 0000000000000008 by task test=
_sockmap/49469
[ 1571.107402][T49469]=20
[ 1571.109626][T49469] CPU: 4 UID: 0 PID: 49469 Comm: test_sockmap Tainted:=
 G           OE      6.12.0-rc5-01137-g5d609ba26247 #1
[ 1571.121113][T49469] Tainted: [O]=3DOOT_MODULE, [E]=3DUNSIGNED_MODULE
[ 1571.127170][T49469] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS =
1.2.0 12/22/2016
[ 1571.135326][T49469] Call Trace:
[ 1571.138498][T49469]  <TASK>
[ 1571.141320][T49469]  dump_stack_lvl+0x62/0x90
[ 1571.145719][T49469]  kasan_report+0xb9/0xf0
[ 1571.149950][T49469]  ? splice_to_socket+0x6d3/0x7d0
[ 1571.154888][T49469]  splice_to_socket+0x6d3/0x7d0
[ 1571.159641][T49469]  ? current_time+0x71/0x170
[ 1571.164145][T49469]  ? __pfx_splice_to_socket+0x10/0x10
[ 1571.169443][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.175344][T49469]  ? __pfx_current_time+0x10/0x10
[ 1571.180277][T49469]  ? atime_needs_update+0x18e/0x240
[ 1571.185380][T49469]  ? touch_atime+0x3d/0x2a0
[ 1571.189781][T49469]  ? shmem_file_splice_read+0x5c6/0x630
[ 1571.195236][T49469]  ? __pfx_direct_splice_actor+0x10/0x10
[ 1571.200778][T49469]  direct_splice_actor+0xb1/0x2f0
[ 1571.205706][T49469]  splice_direct_to_actor+0x1c5/0x450
[ 1571.210982][T49469]  ? __pfx_direct_splice_actor+0x10/0x10
[ 1571.216532][T49469]  ? __pfx_splice_direct_to_actor+0x10/0x10
[ 1571.222338][T49469]  do_splice_direct+0xee/0x170
[ 1571.227000][T49469]  ? __pfx_do_splice_direct+0x10/0x10
[ 1571.232275][T49469]  ? __pfx_direct_file_splice_eof+0x10/0x10
[ 1571.238077][T49469]  ? security_file_permission+0x84/0x90
[ 1571.243528][T49469]  ? rw_verify_area+0x1e5/0x2e0
[ 1571.248278][T49469]  do_sendfile+0x601/0x6e0
[ 1571.252593][T49469]  ? __pfx_do_sendfile+0x10/0x10
[ 1571.257443][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.262105][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.267991][T49469]  ? syscall_exit_to_user_mode+0xa2/0x2a0
[ 1571.273619][T49469]  __x64_sys_sendfile64+0x138/0x150
[ 1571.278720][T49469]  ? __pfx___x64_sys_sendfile64+0x10/0x10
[ 1571.284347][T49469]  ? mark_lock+0x8f/0x530
[ 1571.288569][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.293233][T49469]  do_syscall_64+0x8c/0x170
[ 1571.297638][T49469]  ? do_user_addr_fault+0x39d/0x790
[ 1571.302738][T49469]  ? reacquire_held_locks+0x16b/0x270
[ 1571.308012][T49469]  ? do_user_addr_fault+0x39d/0x790
[ 1571.313118][T49469]  ? find_held_lock+0x83/0xa0
[ 1571.317694][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.322793][T49469]  ? __lock_release+0x130/0x260
[ 1571.328154][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.333255][T49469]  ? __pfx___lock_release+0x10/0x10
[ 1571.338967][T49469]  ? __up_read+0x161/0x470
[ 1571.343281][T49469]  ? __pfx___up_read+0x10/0x10
[ 1571.347945][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.353049][T49469]  ? __rcu_read_unlock+0x65/0x90
[ 1571.357888][T49469]  ? do_user_addr_fault+0x400/0x790
[ 1571.362990][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.367656][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.373548][T49469]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1571.379352][T49469] RIP: 0033:0x7fb9e873c77a
[ 1571.383665][T49469] Code: c3 0f 1f 80 00 00 00 00 4c 89 d2 4c 89 c6 e9 f=
d fd ff ff 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00 49 89 ca b8 28 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 56 56 0d 00 f7 d8 64 89 01 48
[ 1571.403312][T49469] RSP: 002b:00007fff4192bac8 EFLAGS: 00000203 ORIG_RAX=
: 0000000000000028
[ 1571.411663][T49469] RAX: ffffffffffffffda RBX: 00007fff4192bf28 RCX: 000=
07fb9e873c77a
[ 1571.419574][T49469] RDX: 0000000000000000 RSI: 0000000000000218 RDI: 000=
0000000000212
[ 1571.427497][T49469] RBP: 00007fff4192bb20 R08: 000da7112e464d67 R09: 000=
07fb9e8812cd0
[ 1571.435397][T49469] R10: 0000000000002000 R11: 0000000000000203 R12: 000=
0000000000000
[ 1571.443318][T49469] R13: 00007fff4192bf38 R14: 000055f5228dbf18 R15: 000=
07fb9e88a3020
[ 1571.451226][T49469]  </TASK>
[ 1571.454133][T49469] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ 1571.462327][T49469] Disabling lock debugging due to kernel taint
[ 1571.468595][T49469] BUG: kernel NULL pointer dereference, address: 00000=
00000000008
[ 1571.476319][T49469] #PF: supervisor read access in kernel mode
[ 1571.482203][T49469] #PF: error_code(0x0000) - not-present page
[ 1571.488085][T49469] PGD 0 P4D 0=20
[ 1571.491350][T49469] Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
[ 1571.497321][T49469] CPU: 4 UID: 0 PID: 49469 Comm: test_sockmap Tainted:=
 G    B      OE      6.12.0-rc5-01137-g5d609ba26247 #1
[ 1571.508811][T49469] Tainted: [B]=3DBAD_PAGE, [O]=3DOOT_MODULE, [E]=3DUNS=
IGNED_MODULE
[ 1571.516096][T49469] Hardware name: Dell Inc. OptiPlex 7050/062KRH, BIOS =
1.2.0 12/22/2016
[ 1571.524256][T49469] RIP: 0010:splice_to_socket+0x6d3/0x7d0
[ 1571.529795][T49469] Code: 85 d2 49 89 4f 08 75 32 49 8d 7f 10 83 c3 01 e=
8 63 88 ef ff 4d 8b 67 10 49 c7 47 10 00 00 00 00 49 8d 7c 24 08 e8 4d 88 e=
f ff <49> 8b 44 24 08 4c 89 fe 4c 89 ef ff d0 0f 1f 00 4d 85 f6 0f 8f 5c
[ 1571.549440][T49469] RSP: 0018:ffff888350677650 EFLAGS: 00010286
[ 1571.555434][T49469] RAX: 0000000000000001 RBX: 0000000000000003 RCX: fff=
fffff81143986
[ 1571.563333][T49469] RDX: fffffbfff0cf2b19 RSI: 0000000000000008 RDI: fff=
fffff867958c0
[ 1571.571229][T49469] RBP: ffff888350677930 R08: 0000000000000001 R09: fff=
ffbfff0cf2b18
[ 1571.579126][T49469] R10: ffffffff867958c7 R11: 0000000000000001 R12: 000=
0000000000000
[ 1571.587024][T49469] R13: ffff8883aee95400 R14: 0000000000001001 R15: fff=
f8887ca88e050
[ 1571.594920][T49469] FS:  00007fb9e863f080(0000) GS:ffff888733200000(0000=
) knlGS:0000000000000000
[ 1571.603779][T49469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1571.610275][T49469] CR2: 0000000000000008 CR3: 00000003b05b0003 CR4: 000=
00000003726f0
[ 1571.618172][T49469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[ 1571.626068][T49469] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[ 1571.633968][T49469] Call Trace:
[ 1571.637143][T49469]  <TASK>
[ 1571.639967][T49469]  ? __die+0x1f/0x60
[ 1571.643761][T49469]  ? page_fault_oops+0x8d/0xc0
[ 1571.648451][T49469]  ? exc_page_fault+0x57/0xe0
[ 1571.653043][T49469]  ? asm_exc_page_fault+0x22/0x30
[ 1571.657979][T49469]  ? add_taint+0x26/0x90
[ 1571.662118][T49469]  ? splice_to_socket+0x6d3/0x7d0
[ 1571.667043][T49469]  ? current_time+0x71/0x170
[ 1571.671537][T49469]  ? __pfx_splice_to_socket+0x10/0x10
[ 1571.676811][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.682702][T49469]  ? __pfx_current_time+0x10/0x10
[ 1571.687632][T49469]  ? atime_needs_update+0x18e/0x240
[ 1571.692735][T49469]  ? touch_atime+0x3d/0x2a0
[ 1571.697136][T49469]  ? shmem_file_splice_read+0x5c6/0x630
[ 1571.702592][T49469]  ? __pfx_direct_splice_actor+0x10/0x10
[ 1571.708132][T49469]  direct_splice_actor+0xb1/0x2f0
[ 1571.713058][T49469]  splice_direct_to_actor+0x1c5/0x450
[ 1571.718332][T49469]  ? __pfx_direct_splice_actor+0x10/0x10
[ 1571.723873][T49469]  ? __pfx_splice_direct_to_actor+0x10/0x10
[ 1571.729676][T49469]  do_splice_direct+0xee/0x170
[ 1571.734337][T49469]  ? __pfx_do_splice_direct+0x10/0x10
[ 1571.739612][T49469]  ? __pfx_direct_file_splice_eof+0x10/0x10
[ 1571.745435][T49469]  ? security_file_permission+0x84/0x90
[ 1571.750884][T49469]  ? rw_verify_area+0x1e5/0x2e0
[ 1571.755634][T49469]  do_sendfile+0x601/0x6e0
[ 1571.759950][T49469]  ? __pfx_do_sendfile+0x10/0x10
[ 1571.764786][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.769452][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.775351][T49469]  ? syscall_exit_to_user_mode+0xa2/0x2a0
[ 1571.780978][T49469]  __x64_sys_sendfile64+0x138/0x150
[ 1571.786078][T49469]  ? __pfx___x64_sys_sendfile64+0x10/0x10
[ 1571.791702][T49469]  ? mark_lock+0x8f/0x530
[ 1571.795924][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.800587][T49469]  do_syscall_64+0x8c/0x170
[ 1571.804991][T49469]  ? do_user_addr_fault+0x39d/0x790
[ 1571.810089][T49469]  ? reacquire_held_locks+0x16b/0x270
[ 1571.815364][T49469]  ? do_user_addr_fault+0x39d/0x790
[ 1571.820466][T49469]  ? find_held_lock+0x83/0xa0
[ 1571.825053][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.830154][T49469]  ? __lock_release+0x130/0x260
[ 1571.835513][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.840613][T49469]  ? __pfx___lock_release+0x10/0x10
[ 1571.846327][T49469]  ? __up_read+0x161/0x470
[ 1571.850637][T49469]  ? __pfx___up_read+0x10/0x10
[ 1571.855299][T49469]  ? do_user_addr_fault+0x3f6/0x790
[ 1571.860398][T49469]  ? __rcu_read_unlock+0x65/0x90
[ 1571.865237][T49469]  ? do_user_addr_fault+0x400/0x790
[ 1571.870337][T49469]  ? mark_held_locks+0x24/0x90
[ 1571.875001][T49469]  ? lockdep_hardirqs_on_prepare+0x131/0x200
[ 1571.880897][T49469]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[ 1571.886704][T49469] RIP: 0033:0x7fb9e873c77a
[ 1571.891022][T49469] Code: c3 0f 1f 80 00 00 00 00 4c 89 d2 4c 89 c6 e9 f=
d fd ff ff 0f 1f 44 00 00 31 c0 c3 0f 1f 44 00 00 49 89 ca b8 28 00 00 00 0=
f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 56 56 0d 00 f7 d8 64 89 01 48
[ 1571.910665][T49469] RSP: 002b:00007fff4192bac8 EFLAGS: 00000203 ORIG_RAX=
: 0000000000000028
[ 1571.919004][T49469] RAX: ffffffffffffffda RBX: 00007fff4192bf28 RCX: 000=
07fb9e873c77a
[ 1571.926901][T49469] RDX: 0000000000000000 RSI: 0000000000000218 RDI: 000=
0000000000212
[ 1571.934798][T49469] RBP: 00007fff4192bb20 R08: 000da7112e464d67 R09: 000=
07fb9e8812cd0
[ 1571.942694][T49469] R10: 0000000000002000 R11: 0000000000000203 R12: 000=
0000000000000
[ 1571.950591][T49469] R13: 00007fff4192bf38 R14: 000055f5228dbf18 R15: 000=
07fb9e88a3020
[ 1571.958508][T49469]  </TASK>
[ 1571.961435][T49469] Modules linked in: tls rpcsec_gss_krb5 auth_rpcgss n=
fsv4 dns_resolver openvswitch nf_conncount nf_nat nf_conntrack nf_defrag_ip=
v6 nf_defrag_ipv4 psample snd_hda_codec_hdmi snd_ctl_led intel_rapl_msr snd=
_hda_codec_realtek intel_rapl_common snd_hda_codec_generic snd_hda_scodec_c=
omponent intel_uncore_frequency intel_uncore_frequency_common btrfs blake2b=
_generic xor zstd_compress snd_soc_avs raid6_pq libcrc32c snd_soc_hda_codec=
 x86_pkg_temp_thermal snd_hda_ext_core intel_powerclamp i915 coretemp sd_mo=
d snd_soc_core sg kvm_intel cec snd_compress drm_buddy kvm snd_hda_intel dr=
m_display_helper snd_intel_dspcfg snd_intel_sdw_acpi crct10dif_pclmul ttm d=
ell_pc snd_hda_codec crc32_pclmul dell_wmi crc32c_intel snd_hda_core drm_km=
s_helper mei_wdt ghash_clmulni_intel i2c_designware_platform snd_hwdep ahci=
 intel_gtt i2c_designware_core rapl snd_pcm agpgart libahci dell_smbios pla=
tform_profile ipmi_devintf dell_wmi_aio intel_cstate ipmi_msghandler dcdbas=
 dell_wmi_descriptor wmi_bmof sparse_keymap snd_timer video mei_me
[ 1571.961682][T49469]  intel_lpss_pci intel_uncore snd i2c_i801 pcspkr int=
el_pmc_core libata intel_lpss mei soundcore i2c_smbus idma64 intel_vsec pmt=
_telemetry wmi pinctrl_sunrisepoint pmt_class acpi_pad binfmt_misc drm dm_m=
od ip_tables x_tables sch_fq_codel [last unloaded: bpf_testmod(OE)]
[ 1572.078794][T49469] CR2: 0000000000000008
[ 1572.082843][T49469] ---[ end trace 0000000000000000 ]---
[ 1572.088202][T49469] RIP: 0010:splice_to_socket+0x6d3/0x7d0
[ 1572.093740][T49469] Code: 85 d2 49 89 4f 08 75 32 49 8d 7f 10 83 c3 01 e=
8 63 88 ef ff 4d 8b 67 10 49 c7 47 10 00 00 00 00 49 8d 7c 24 08 e8 4d 88 e=
f ff <49> 8b 44 24 08 4c 89 fe 4c 89 ef ff d0 0f 1f 00 4d 85 f6 0f 8f 5c
[ 1572.113363][T49469] RSP: 0018:ffff888350677650 EFLAGS: 00010286
[ 1572.119346][T49469] RAX: 0000000000000001 RBX: 0000000000000003 RCX: fff=
fffff81143986
[ 1572.127253][T49469] RDX: fffffbfff0cf2b19 RSI: 0000000000000008 RDI: fff=
fffff867958c0
[ 1572.135161][T49469] RBP: ffff888350677930 R08: 0000000000000001 R09: fff=
ffbfff0cf2b18
[ 1572.143071][T49469] R10: ffffffff867958c7 R11: 0000000000000001 R12: 000=
0000000000000
[ 1572.150969][T49469] R13: ffff8883aee95400 R14: 0000000000001001 R15: fff=
f8887ca88e050
[ 1572.158867][T49469] FS:  00007fb9e863f080(0000) GS:ffff888733200000(0000=
) knlGS:0000000000000000
[ 1572.167730][T49469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1572.174226][T49469] CR2: 0000000000000008 CR3: 00000003b05b0003 CR4: 000=
00000003726f0
[ 1572.182125][T49469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000=
0000000000000
[ 1572.190023][T49469] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000=
0000000000400
[ 1572.197918][T49469] Kernel panic - not syncing: Fatal exception
[ 1572.203935][T49469] Kernel Offset: disabled



--=20
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


