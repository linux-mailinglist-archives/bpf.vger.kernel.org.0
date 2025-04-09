Return-Path: <bpf+bounces-55533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28522A82A8E
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 17:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51D6E1897082
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 15:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF591267383;
	Wed,  9 Apr 2025 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7nE7oH5"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F519264A85
	for <bpf@vger.kernel.org>; Wed,  9 Apr 2025 15:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744212545; cv=fail; b=Z1keCg9V/b52thdtLlTzNNYorVPbVRp/pXuoFgNNrS2Amka/qBip8xCGmc7sP3O3WUdRr+D0y3nWyw2W3bA8tkFWtXGK7Iv6uO8KHJSnlbpMwiXy/9uPh2peBnc6oe1lFKF94DAn2ajqFNyGOVgCnNhBIA3tcjHN4o56KwY44VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744212545; c=relaxed/simple;
	bh=kFN+L/qs0t0OCAbOPSIwq6rAf7/o1IxpKzzrRLyM4/E=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=svtbUK6V4ks7pJj+Q5g/HoTTMh3f8xXciCaqoFyJWaD31JMbW/1KOXMAYhSXvBSgMnSxmMgthwuRwrsGuOaFOcFH4HIXP7bVlNX+Gvlc1OHKn6JeX65uxSOu4wtzeUJQ41dfD1nkHguVTpLx7unI/h0DRkzepyxmVcM+wk02mcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7nE7oH5; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744212543; x=1775748543;
  h=date:from:to:subject:message-id:mime-version;
  bh=kFN+L/qs0t0OCAbOPSIwq6rAf7/o1IxpKzzrRLyM4/E=;
  b=j7nE7oH5D2iOS8o7DsX8nTfDN45xRUaEzOrMqq/ZfzCwgTwMRFMitHrK
   au/QC/cvlE5goIn81UeaMCwxrqpkwvP/kZEmzA2NAgm5h7yXV9F8JEDSX
   Kh7xiHf/MrnFsF2IJAYYS5BgTDd+4cYt0Ku8aTZAn3yS3Z6SKgMEWvSnT
   l+CqBxNgsZvR4HSRlr7/N1KGdDonBxKsaABmwSb7sjq09V3YRpJtmJ27u
   +DY92+USJS3QzhNDd0qAV8RtGH0eALT1mLmRIM0HkDPwQzTW190Q5htaG
   p+corSYADpSdLpI0URjeJ0dPmgfXV3uofPk0OOQ24Y4vWOHwXdNQhpQGF
   g==;
X-CSE-ConnectionGUID: NOqkKXHoQSmEHNB4a+erHA==
X-CSE-MsgGUID: oA7U88biSrWG+8mmmzPN6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="49489186"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="49489186"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:29:02 -0700
X-CSE-ConnectionGUID: PqifVUd8R9yvOAXRfHnkBg==
X-CSE-MsgGUID: 6eTWPmpHTweO6n+QpS8ahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="133332154"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 08:29:02 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 08:29:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 08:29:01 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 08:29:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IYrJowF5blYlNNgGlZYTLcQaR9mwWrUlUyYiEKjhbfEoLxwk5Eb39gqaLqyR9AolEa/L0wWPXjw4u58Cbdv//PeU4lu+qkFZWSsKIQCk/UpacRAvXu/ZKqZtivM8X0c1XvbthVRV/Zcc58g/BpHIKk633egWLqE2x68DcTrHg7lG1Cr9WIbFW0YFgWJWsShF2whcEbppEO25WxbnxrgbN/xuxjXe7BMbEWsBkIvUY2YhklqtqVcS/7Uk4l+URAlVhadNr0qGcsdZiMhPnSd/hSrHG7OYD5X5V1CAsOlDXKcqrBGZASnbzRo7eMxYyopyH3xQ5ljsnHub/eFjiq3tjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqtuuXbpQeX6KUzcKNALKjxSlA1nPSbu9615ghFf2xs=;
 b=lw57eAo5bYzBPw5rLy81Dt7t50lc8ZffLq5b1WVTPZ3diYn6AbrffthB9LYucPNpSWsDDvfOG3IiUMvKubDbkZnClCy30EHu6r+wjVkemtJ8jRP2YPzD0aPsHfRMtlD+nIaC+6IBSdaEviTVe3MpwgJ5OeLSrI4EWK9WmZokqEXCykWSx8Gr8I9dv9P8IBN2EMCq3CawhTFe2PYC2HPHaS+XCqSVFi5/PNOkCjHyQJIYFf3z8Z0XSlnNXCwsKdhLlHXv7frImxi8W2gJtcmIFS5u5j4QdXs4Kxpa7hbA+bOJ28B8htaC7+YwMC5JkQqRWw/LDG5xj1CnLburPQ1tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15)
 by SA1PR11MB6967.namprd11.prod.outlook.com (2603:10b6:806:2bb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Wed, 9 Apr
 2025 15:28:59 +0000
Received: from PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582]) by PH7PR11MB7050.namprd11.prod.outlook.com
 ([fe80::dbd2:6eb1:7e7:1582%6]) with mapi id 15.20.8583.045; Wed, 9 Apr 2025
 15:28:59 +0000
Date: Wed, 9 Apr 2025 11:28:56 -0400
From: Brandon Kammerdiener <brandon.kammerdiener@intel.com>
To: <bpf@vger.kernel.org>
Subject: [PATCH RESEND] bpf: fix possible endless loop in BPF map iteration
Message-ID: <Z_aSOFIJkhq5wcye@bkammerd-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:a03:331::31) To PH7PR11MB7050.namprd11.prod.outlook.com
 (2603:10b6:510:20d::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB7050:EE_|SA1PR11MB6967:EE_
X-MS-Office365-Filtering-Correlation-Id: a53258cd-ab79-40a8-8de1-08dd777b3fc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MOC662ujvz9TCsh3GPIgLRiU7tGcnB6Mi9vF0Xe0RiZvdm1ZwmOJO8fPVqu7?=
 =?us-ascii?Q?36VLENV1Xs0Q+2TnQcI5hMuEFkvP6w2fs3ZgXyuq8RNXGexgIBeHS6d4i+Jb?=
 =?us-ascii?Q?yTf0fHMQ6FI+oDbESxUj864gBZPRF801URtTMuj3nkH6ICyCX1IX95M0+Np2?=
 =?us-ascii?Q?GgHqCrPE3T/dwAihPW0dIxTRfve3plzhFVtUL3M4XlLAZq3GG02RdY0ournJ?=
 =?us-ascii?Q?bAc4KFUKEw74OLOfAWYuak7EmOi+AbnCRnoenUW78b0EvD2zOfp4nqjH4waO?=
 =?us-ascii?Q?uLn40mEu4sRFvcp+1VVEBCTei0eFGQaBdSW/XyU9LKafQP9utJJdC166JNm6?=
 =?us-ascii?Q?fGDtIypJ+YQ0YL7EAY1KY/wQn76gOhVokD2NHJ3SuxziVyjXaFZMAGEkZYH/?=
 =?us-ascii?Q?k6SzGUdQFwNmSiD1OyT4VyOn8IA5J5+hlY0ayn0+d+ml9OjG+GC99+z7bQkm?=
 =?us-ascii?Q?k7W5Snhzv5EOaf8BosyX8TT/dLYmCQMotY5JnFC3nNQx+CKQ67p2v7Btn7fh?=
 =?us-ascii?Q?FeOX8bFkgpdeAh3FBKCGeLJOVDZ7jHMbMvy/bm6z4lD4NG3SDvFKIBeqpFiB?=
 =?us-ascii?Q?p9Fd0yo7zKzGvGBh8jFpfC4THUEr259KvU1BxqE4EqxHU7Lu2H0bnrlDbglR?=
 =?us-ascii?Q?QEdkJg3sXyttz99hZtzjF0eK0fxZVoFAM2xZA8rpun6+Im6TjENYjZtxZot3?=
 =?us-ascii?Q?0CXv7XvMHBOPtiT0Zpx66prI/t7qdsn4p9aJTi7sxf+RRejuWEr7WyjjmgiA?=
 =?us-ascii?Q?tE94AFGs5LdHJ023X3yQcUsb9t5f0GOiMxSW9meY9NR2SqmFRZ65VoRgYWWc?=
 =?us-ascii?Q?kbuClO7gHhEmkI/vO6eH3Efe/I+puXy5He1jDhwuqoy1ncuopPNuVLbfYbKl?=
 =?us-ascii?Q?esH1tJww/5GCsn02Mt/0nLPBOY8JEhiOx1uM3lPF0PIEFDatKS6FmJFfWpyb?=
 =?us-ascii?Q?CYMcKT1fNx3VGEpnxZ6qlvMkp90ZhTguq6z9TocZJwiTtZ+8N8M/CDZDk3OF?=
 =?us-ascii?Q?Zgrkpwny3XuBFkSrXHHrambP8tAoERtT8oOqspEAuK2wWwP8w+G4akWclxYh?=
 =?us-ascii?Q?nvVZogjss3pp9eHJ2LCVpqCjlvlquecwlSxaMFRTMe5iOvN05I98TVwDQTCG?=
 =?us-ascii?Q?K/Cs0uM9hm/UrVdGlIGXuqwXVuhMHeXxrxb+3ws1K2M5UPspT27TwGQkBYmG?=
 =?us-ascii?Q?Aaw6qYj36gqkMO5oJ/tBnZ2RywVzjQBr8LJrmAryBoHOsZXDT/E1MAPd1VOn?=
 =?us-ascii?Q?N0uZauGiQ/lQoCscnKJSPQdDTcc7H6/gWGEBZMUqaqQtXE7TWCadmaj1EeA0?=
 =?us-ascii?Q?KINSJHqey3QZLHYLcE64YOmT6BNzrgbtIXPvpjHzcdBijM9+b/eiE8pQ6L+Y?=
 =?us-ascii?Q?zhrLTyhUsWiM3KhHK8NXe36hh2F3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7050.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y1ICiQNV0Rrfzm3x1Dt6k52pH639ZLeeJWO///8Z9+j0NpBYqpGrNecqQd6w?=
 =?us-ascii?Q?oqqtItHJw3mvo3Z8pZbQ/P9TXNzsz/7OYwkzFpgapivSrz443HTtAiL09lWv?=
 =?us-ascii?Q?QypMulVN1st15bW+zKrG6VrKlPVO+g4jeDq87+iIRpde8zKJQWBhC9tHWztf?=
 =?us-ascii?Q?DUDMAWbk5ipzyCCMYjoFp6IkBF8GsJGD/uLps4ZvSMQAZXqESQnauiyez1vo?=
 =?us-ascii?Q?40WdFkCObO69do7atrPcveavPPmX1oywxN6h6Yfcr7kk4vmQeJ6HyQfRJwDy?=
 =?us-ascii?Q?0knVb0Z9jbG8AbkpPn2bv9oP/z0FAXDsZxDxaWmfrLnxOdtZSlM5ysmEVWTB?=
 =?us-ascii?Q?DocRTLB1fX4sVzkFF0S5MyJUHJ2C1j1AK3lyJ9TnS8bVn5B3l0oQNnHphpzi?=
 =?us-ascii?Q?CKHXjC3nIJkflVqfThcf5Kfrw4aDB01TD8TAlcGpj1kTcZ/OAETvMo59oQSQ?=
 =?us-ascii?Q?BBcSVlb6n5RvP0uhEkgtqnZOg9m56WB6EijYH2lnKQz+73UE72kq0uzEj/ju?=
 =?us-ascii?Q?gPdmJ30eSaOA47E+o2b4E8JW3rL9IpJobzSfSYIWTjN0GrvawQQyaCug3ydd?=
 =?us-ascii?Q?OL7/REmY0UWz3FJUnoA90Wsw28VgVDCA9TBQOh8BhXT368V1j1R5iGHHw8/y?=
 =?us-ascii?Q?jwwGONyt6ZU54dP9S3IvALRgEKVuHDjCMb1vv0BPdaanf+l80NBo8rJ/p8AH?=
 =?us-ascii?Q?3Pa2SixcdbfMh1tznlXMFYHg+nMOPodc8DaaxgiY/mFaUYioqCMiCErh6Ks4?=
 =?us-ascii?Q?6H831coIes/7s58xMNZqErUZxrm8mYelvgRlmwV5fV6RFAasZR7nvI2U9VL4?=
 =?us-ascii?Q?esJcT8eeUQsO5PrnPcRQC1EzqxLxjbW1AspdslwtqugTTztGShqN/TzUYAZA?=
 =?us-ascii?Q?Cz6VrKs+pOvRQKVnUBlsTs2FhWaSIGRPTxVSTqr8pz+WdF54U0AjkO3bcnba?=
 =?us-ascii?Q?kQ3hpCJTeuCkVybgMuXW2VyAjGYO6tKHVkLMOYJWeXcctB/J4s22DXxnj9RS?=
 =?us-ascii?Q?TGjL2fXLw/ZqSnsGxkqrLAzstC0XAzvXCTnKLZ8DuG3xLb0Fl5IkoiSBr9mT?=
 =?us-ascii?Q?2W+wmiJxFBa8TJ1FOgmD2IrlmkxGHyB5IsUWLl5CAWNkNP1nFkb0Rl1okvb0?=
 =?us-ascii?Q?CPBirPDg1pL6fWS427E+y36SclM2KaHhPvIZn/XKFF4cV9A6VprA5+4F0my0?=
 =?us-ascii?Q?m5/243tzWmNsZOUSmpeEQ8gLV/u3ypho/qwx4+Os5pnd1CT0H4v1j9qROQrG?=
 =?us-ascii?Q?UNajrLx00t7nV8E0iV4IUDeLeqgZiLhbvGSfv6CCpvfevEkes9A6/oNgPSBA?=
 =?us-ascii?Q?NCovo12B7RoawOBox6jg1c/BtqJZu+/4K1eDs/GCaPpt1Nnw7L8WB9GyDJe3?=
 =?us-ascii?Q?34fqKrsc5Iu4owD4N9DhvaVC0B8Cl2EMqRhZLHfKvv0aZRolr9lsw/v26VmQ?=
 =?us-ascii?Q?xGd/BUiTCd1Yv4tG/Ba++VyXxkr/+yMDjDRhQjJT43HjdO7COoW72CUdKo8u?=
 =?us-ascii?Q?rPApc+g2AodU4ED45PncqWQtOMENABEfFOGVhQ9x+9nX38+ZuejhWCsRu7Ww?=
 =?us-ascii?Q?bjFOHsCB6A/ohhbRLRestX0UEIUg9vFWJ2LzcQcFuofNm0k7wPOgC6oslLoT?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a53258cd-ab79-40a8-8de1-08dd777b3fc4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7050.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 15:28:59.4476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61v7FEWk/X6lxOdd1jKOOCDTxtw9MQ/PYnQidzW6wqnQooZvCj6HhubE4JVwTF6/kvi9QXnuqJr3hKtRdj9BzfMCmhhUGcfi0bc5Rt31jek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6967
X-OriginatorOrg: intel.com

This patch fixes an endless loop condition that can occur in
bpf_for_each_hash_elem, causing the core to softlock. My understanding is
that a combination of RCU list deletion and insertion introduces the new
element after the iteration cursor and that there is a chance that an RCU
reader may in fact use this new element in iteration. The patch uses a
_safe variant of the macro which gets the next element to iterate before
executing the loop body for the current element. The following simple BPF
program can be used to reproduce the issue:

    #include "vmlinux.h"
    #include <bpf/bpf_helpers.h>
    #include <bpf/bpf_tracing.h>

    #define N (64)

    struct {
        __uint(type,        BPF_MAP_TYPE_HASH);
        __uint(max_entries, N);
        __type(key,         __u64);
        __type(value,       __u64);
    } map SEC(".maps");

    static int cb(struct bpf_map *map, __u64 *key, __u64 *value, void *arg) {
        bpf_map_delete_elem(map, key);
        bpf_map_update_elem(map, key, value, 0);
        return 0;
    }

    SEC("uprobe//proc/self/exe:test")
    int BPF_PROG(test) {
        __u64 i;

        bpf_for(i, 0, N) {
            bpf_map_update_elem(&map, &i, &i, 0);
        }

        bpf_for_each_map_elem(&map, cb, NULL, 0);

        return 0;
    }

    char LICENSE[] SEC("license") = "GPL";

Signed-off-by: Brandon Kammerdiener <brandon.kammerdiener@intel.com>

---
 kernel/bpf/hashtab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 5a5adc66b8e2..92b606d60020 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2189,7 +2189,7 @@ static long bpf_for_each_hash_elem(struct bpf_map *map, bpf_callback_t callback_
                b = &htab->buckets[i];
                rcu_read_lock();
                head = &b->head;
-               hlist_nulls_for_each_entry_rcu(elem, n, head, hash_node) {
+               hlist_nulls_for_each_entry_safe(elem, n, head, hash_node) {
                        key = elem->key;
                        if (is_percpu) {
                                /* current cpu value for percpu map */
--
2.49.0

