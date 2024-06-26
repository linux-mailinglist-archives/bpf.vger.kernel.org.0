Return-Path: <bpf+bounces-33141-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD33917B15
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 10:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 820B8287E2E
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 08:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4C16848F;
	Wed, 26 Jun 2024 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJusXzxw"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6274166302;
	Wed, 26 Jun 2024 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391001; cv=fail; b=V24ijpePFph77EmZqXxnpjQRDfH3jIEu/6wegUpreiyyuJofSQaB39L51VhYhgO6Uoa+t09+Zm8oPo7AaJgrSPmEbiCX/L5y8JBT/KhcrHAkLovhVHoSFO2cpVYV1i0uKVutbYdHwxGuENvz48V6jfoPqeK22j65aJw8Wxrw1TI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391001; c=relaxed/simple;
	bh=uMWfte1HNEihYk6Fl81tEhGpPdkT/8x0/B+vF1JyYso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rLCWjrqqcyqhKxsB7/KyXMg9tuZzj3GD2V+mYgnz1CSoDxSF3LZ5ocBmg9U6VNXYpnU7SkLG7s+iEceiGOmLyYBlWLTmk3kzFkHdVZkLomTstfPnL5yRdZ1JOJKnJg5F9S1t+VZIJp6r9GCz5gC8JQOVa7XPMHlaSCoFw3ssrf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJusXzxw; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719390999; x=1750926999;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uMWfte1HNEihYk6Fl81tEhGpPdkT/8x0/B+vF1JyYso=;
  b=jJusXzxwaSpD3YZHHToAPJtyRy4W2NtrEWumXz2JWffWVNcQ4GOuW18K
   DPYDZtSOuUNOoaZIsWfRimUeQSfIDwcj35DLQ8hVeeZdgWCoTsSErM7bh
   YqcXvUvWd3cOLMXuw60dn/O6CMBl+g4Z5Leu5JWcCHGwNNFIA//3U5cIv
   DnDlhJpSetTRCHsH9DjSXRH5u5DMtKx2qHmUdRJb0kJWRbjiooDsEkWX6
   oOwYloy80ptQScYyYi4UXlznyEcLlgu7OGJ3DXlm8CyxWjtTtX9ZhY95p
   2d7FRha+8EmkBmQcxxQwwTCI/b+d4+/tLYA8JBeHKo/Edfzhr8Y4B1Q5C
   w==;
X-CSE-ConnectionGUID: voaeYD1ZQEO0I0RlDmbZ4g==
X-CSE-MsgGUID: /2SdJLLAQS+gZyXBcboteQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16277699"
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="16277699"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 01:36:39 -0700
X-CSE-ConnectionGUID: cE4bgsBVToG5jNAYvfPKAA==
X-CSE-MsgGUID: 6Jygj6pdTCqZ0bY/oXxBHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,266,1712646000"; 
   d="scan'208";a="75140778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jun 2024 01:36:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 01:36:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 01:36:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 01:36:38 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 01:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dyCK6HVBC+q8muvrcv80jnkx2qXBwxj36a4n9cm4/5IaZZeebqzpWGS7TMnuQ4elcIY7qg6nGusf1SiJQp9gyAeWL2gyKOd1QXjbfEqDPrDkPP0hX++NGF2b61RUSNF1+wtXO5k/L6fS3fg2zeznR1EBLZT9+HTGg+CCfldnN8rx+Dpta9xEVkkgGp+eg4XB2GYw+cOST1Y3Ke2bTYn4SBnHntzX6LxhmhPr9qbBR9XeouxwxT71g2+iaOedl2Cmf1cvFFKysomguQG7AydiURhCH8pk28xvJhLWm6nFujTZ8LYPZ5iomYhO1CGtQNBkN5xBJdTUraw1wxHmCWyktQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UgMHpNrNpGP91j5z4USpDYerXWUv6BNRAm0Lvzjl96I=;
 b=eUoXL+EwW52EKPGQvv+qHFkUpAh4W5iuJMpgs07P/OKsEoPCszzJ0Dw0di72LO60lsavghK8vE26f6B/TqCHhEuM3eDB9B80SKKzi2d9OFwSp4+AE5sjFKuJTR908RR35LjK69PIL9/00h0gfyrcCsll8w20kuwyefbd7I4SQ9taUchhQyx8w9G/b1MRwi1ru9GmXmEgbSH0fnq/hwWR6qwhq1PcMoqeTXvUjMVkccCv/W1HrIHeewD0pSSXgDr5NBxdcdms6RrrLx0F1BOcFVUROXqJmJVy2VlXw1V/dciI9n2Wc51uqOs555zId/6Ac6LDbSo2HIO9JLHXpn2sSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6514.namprd11.prod.outlook.com (2603:10b6:208:3a2::16)
 by BN9PR11MB5274.namprd11.prod.outlook.com (2603:10b6:408:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 08:36:36 +0000
Received: from IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef]) by IA1PR11MB6514.namprd11.prod.outlook.com
 ([fe80::c633:7053:e247:2bef%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 08:36:36 +0000
From: "Vyavahare, Tushar" <tushar.vyavahare@intel.com>
To: "Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "jonathan.lemon@gmail.com"
	<jonathan.lemon@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>
Subject: RE: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size support
 with dynamic configurations
Thread-Topic: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size support
 with dynamic configurations
Thread-Index: AQHawk46+lWNr8k3vku2lFqbrLR50LHYyPmAgAD56BA=
Date: Wed, 26 Jun 2024 08:36:36 +0000
Message-ID: <IA1PR11MB6514E556BFDD10C0846D407A8FD62@IA1PR11MB6514.namprd11.prod.outlook.com>
References: <20240619132048.152830-1-tushar.vyavahare@intel.com>
 <20240619132048.152830-3-tushar.vyavahare@intel.com> <ZnsBF//QuXQ9Nyix@boxer>
In-Reply-To: <ZnsBF//QuXQ9Nyix@boxer>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6514:EE_|BN9PR11MB5274:EE_
x-ms-office365-filtering-correlation-id: d982ac8b-4f39-460a-8845-08dc95bb1742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|376012|1800799022|366014|38070700016;
x-microsoft-antispam-message-info: =?us-ascii?Q?kwIFHO6J6b0OKkqa5lPHDccRzESkSP6ddeM3vy8iPORT7riwSFpzbY2syEIw?=
 =?us-ascii?Q?tb6r5onEWL7O8FHS3rDy8KZoJNA1SoV1dqswDtNwlwDWTj9NiICsfvBhfTor?=
 =?us-ascii?Q?xiiJKwHvKeg+9kwbwb6/LuOCImEWcytd20B/gxoInn0As49DFco8hIDeux7Z?=
 =?us-ascii?Q?/MW1e3/0H58AmRzgD/Git/CjgbOhUzqigfYwzXZOEXXbVke931Q68twIHyhn?=
 =?us-ascii?Q?BDkAAkU8Kf9I7go6nhrjnLitzIVnGACqDONKOuSM27XuRVuIC8+jwiVav36w?=
 =?us-ascii?Q?WJkIZolzQhvswDGvqFp2A+8YmwtKPo6XWi0AihDKIFfapAytw3fZRf3+V8Rb?=
 =?us-ascii?Q?cCWE/VispJ1qaeK5UJAR+hMgw/LNLJAxAGB/lq5Q9lWPNGzpG22y0HE+ybEs?=
 =?us-ascii?Q?sCOzMLl7rGxjRoaGx7hFD9Iw8yuyJbrfN7szhcqCph5vBjKXh7qN/OYz2wdd?=
 =?us-ascii?Q?IQ9ZGmXuTMSUhx9MTIiBGOElkzX1OkPa38ijf8mJikrXivp0gcGCEziRYN8b?=
 =?us-ascii?Q?NVN2T534sYLT+aQ4E/lxdHE5sbysKMC0TWQLK8YELtsixULEmboXnT1iHwYZ?=
 =?us-ascii?Q?5nY/Nbs+Drxgt+zXl78sC3Jg20Jq1a5Shho6sQ81adaRasQUMZpWfuKygR2b?=
 =?us-ascii?Q?JRyIHFql+n/+kz0rYi0qEqB4G6D2Vh68T8xw0yESnMHbxFMZXQFV5NRwOSML?=
 =?us-ascii?Q?S40MXPL/bHJXJiAivpyReot6PgtmPv5wbe4lqbeRwVNxD2UBsGAfmc4QvT2L?=
 =?us-ascii?Q?c9NXzPIE+y6qHbzBXk/qVuyBKuo186BaWvwNpDyRwexmIyInvnsrpgTMYsiE?=
 =?us-ascii?Q?cja2rAlt0q+9kO+uLHsTnmKcAuahYGmClq3tLiXZ/1bYF7wbargVVvt0xAiV?=
 =?us-ascii?Q?laj0iAbohQsxnw6udingXGQBbGdbJCuSGM9yqCNC2oY2k55OJDL/psWeCV4e?=
 =?us-ascii?Q?vWa1S+tw8uIlYtjej9pv7ZRfd/q4z6AKZB/pT9ViqC0oszyxJdimTJjcO3PC?=
 =?us-ascii?Q?EQLQJrWjl0IoP7Iq7rvH+5ftwS2asSCfXbZj3Js1hKFOwAdVMf0dP1sd/y/k?=
 =?us-ascii?Q?NNfPPgIDYQ5It+HlTtPxM2SAnhRQbDWe2RKKaeJsuNjxCtQaaADL2n7R83lH?=
 =?us-ascii?Q?mjT/2UKZFAmiog61nxspQVmPgtNzEzAHsgU04upJAtF0oQwHfVPSUtbRWZM3?=
 =?us-ascii?Q?WW5P8RY5d/BUIAc23U8BpOyQrbkG8MVUu9LRFj5lKW1PRrOOMjT1wh0MJCJv?=
 =?us-ascii?Q?8mc82ss4hRtijm8pvFzJAMldzsU7nL1+pCh+5Z+MPjS2d0P2VZrGj/tefEBw?=
 =?us-ascii?Q?G/yVbnO/1B0mDeYqPu7kd3qfMVdihW/3hN55rUGmtZFN2w+JZZOB1mK1G4gZ?=
 =?us-ascii?Q?sURBAuw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6514.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(376012)(1800799022)(366014)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZPUdwjIQJDtWioPHxaxrcfX0WOVIRzwuIQv+IpEwr+nD3q5GQsXv/ise7Ns6?=
 =?us-ascii?Q?oE+qywzJBSwar3u57X4glrdJAE9MuXgiusUyBGTUYXjnQwjArHMhd9l7BZrJ?=
 =?us-ascii?Q?S4sJVf1dIuR0xbq747o8V3l1XKrOwcVzKrUVzOSm1oOBJ5MdkfzD6UdfVzNq?=
 =?us-ascii?Q?Oc5L0RFoyqxvLVxovbkvVgsnDw79eAx36YvVksDRfZYl3SG9AKgfeCKFfW33?=
 =?us-ascii?Q?lqVFsSFPYD2ptvSgDxJlSGUAFBPWJy4YDOSruv5lZbI4xCKelJu0MM9+cKM1?=
 =?us-ascii?Q?De/nabSWeV+DqJu5L3z/Hbwkx3AyiaiY/qYniBWr8fr+0frsAqRsXvbGBRnA?=
 =?us-ascii?Q?tIR0y8VXJD8JB6cUB9Q+QxiLHt1EKtpDfoeA4xWi36GoEHKLXsSqJBUzhetk?=
 =?us-ascii?Q?DpBOkCWvw/RbDd1f30iXy5Z86Yp94SjnKA8vLPuitLsI9hUnD3McLnyljAQk?=
 =?us-ascii?Q?Uf7t4DeMnMQMHtqiRXG1DLqF0ZecgmsinNYQxt9QMPSvgKiJKqNbs77tzXzC?=
 =?us-ascii?Q?ikuzA2ReF5EBvN75upLqfsMNT8ZpRR6Qw9VbM5G0rwOVGr0l59DTvFtlHv+M?=
 =?us-ascii?Q?RzcELDWX4mI3lSWW95hThTI5Hp3tGaEGFNN9kpw1cun+JWfHLH0hcPprzkyo?=
 =?us-ascii?Q?1V9UKCAqdtgkDvQOdvpbDHsOYDqb291fQEeCgxveBSg1s5Bzzz63uZ4Sk6Ly?=
 =?us-ascii?Q?JL80SHd/B5LS7FhUSts8QPWjU9K+deOjBcMj4dGKjsrxHbPMiOhD2gQSl8M+?=
 =?us-ascii?Q?m1BUmyXsLqi58DRkuviWxnfDXIbeyj9SPw4UKbn1fXORYqu4vZ6FySF60ERE?=
 =?us-ascii?Q?4twNCAoxDRFSFQVXTxXz5AnAu39cHWCCAMEvQaVVN6DAit9yCbYXr7j53Vhw?=
 =?us-ascii?Q?bcCVY6mUx3M4OfaQpmdmHo6FiASfjRUxHI3RKPa+yAd7LBE4lSF6epxcrChN?=
 =?us-ascii?Q?jCVe+llnrazxwTAuTZvdGRB4hEW1x9hn0Jrs6XNBxbPj7XnCo/TC5xagOn9U?=
 =?us-ascii?Q?yO1vOIkFpGr/HfRZG5IJBw/+LEjPNQNeFP+qnUr7AHzNdXj3qzviUKP86YRj?=
 =?us-ascii?Q?SrgyX0ExPkAMWPbEHycg++pdzw6eHYVzd3dR8te6tPSk9GtOoldU2Ybm5O+c?=
 =?us-ascii?Q?jc4mf6Jh2yyvf0Ci+cp5bTQLn/glT9Bkx8keyaTJ4sx5IOohcrog8uMZ8OlS?=
 =?us-ascii?Q?iSg0FHEpFYxPuUPVIqTxLrmrMZOFBAcr/bu8pHa46mwZtqZiH07yt4rtvWTG?=
 =?us-ascii?Q?y3yP+630TRC3TzSH3/dzEbCHEtd68d8qwnIWEBuwmS/1vWoJpQxhf8Rfx0G/?=
 =?us-ascii?Q?KqbCzjBTcF60AUv2dSYqI7rROChXimOKhfmyF0NzXHjFBalmHBbfNDed9ft7?=
 =?us-ascii?Q?I2SuFAvZsOIUKBh3b4ta9aGuTlPGD7hDeMfxGWK4Qeskh4gvWVMcnHogR2ZU?=
 =?us-ascii?Q?XNt5RFpqZnO7G+4UEU8sBJKrFhykXLYzFP/TGZzTt/MmwTxQCdr9NfoWZ25U?=
 =?us-ascii?Q?I+lIhzyThB4kwOH8lA7tm34nXg0JPej/73CuLbGUnRFIrAIRu8/9lfig2mT7?=
 =?us-ascii?Q?8gR3L+i4nzMe4x8ao3nlIC/m+aFDWm1FSsrStgKp?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6514.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d982ac8b-4f39-460a-8845-08dc95bb1742
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 08:36:36.0864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: blN1QOqLWlrUiryiDfPnoTVpjEPTvtUOmABII7LF2y5hW9MGTjoZaIaw4B0ukOoofljPTuCCxnRS1zzvcyz1QWB+l2BAPPWyPqcKP2AXpq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5274
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Sent: Tuesday, June 25, 2024 11:11 PM
> To: Vyavahare, Tushar <tushar.vyavahare@intel.com>
> Cc: bpf@vger.kernel.org; netdev@vger.kernel.org; bjorn@kernel.org;
> Karlsson, Magnus <magnus.karlsson@intel.com>;
> jonathan.lemon@gmail.com; davem@davemloft.net; kuba@kernel.org;
> pabeni@redhat.com; ast@kernel.org; daniel@iogearbox.net; Sarkar,
> Tirthendu <tirthendu.sarkar@intel.com>
> Subject: Re: [PATCH bpf-next 2/2] selftests/xsk: Enhance batch size suppo=
rt
> with dynamic configurations
>=20
> On Wed, Jun 19, 2024 at 01:20:48PM +0000, Tushar Vyavahare wrote:
> > Introduce dynamic adjustment capabilities for fill_size, comp_size,
> > tx_size, and rx_size parameters to support larger batch sizes beyond
> > the
>=20
> you are only introducing fill_size and comp_size to xsk_umem_info. The la=
tter
> two seem to be in place.
>=20

I will do it.

> > previous 2K limit.
> >
> > Update HW_SW_MAX_RING_SIZE test cases to evaluate AF_XDP's
> robustness
> > by pushing hardware and software ring sizes to their limits. This test
> > ensures AF_XDP's reliability amidst potential producer/consumer
> > throttling due to maximum ring utilization.
> >
> > Signed-off-by: Tushar Vyavahare <tushar.vyavahare@intel.com>
> > ---
> >  tools/testing/selftests/bpf/xskxceiver.c | 26
> > ++++++++++++++++++------  tools/testing/selftests/bpf/xskxceiver.h |
> > 2 ++
> >  2 files changed, 22 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.c
> > b/tools/testing/selftests/bpf/xskxceiver.c
> > index 088df53869e8..5b049f0296e6 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > @@ -196,6 +196,12 @@ static int xsk_configure_umem(struct ifobject
> *ifobj, struct xsk_umem_info *umem
> >  	};
> >  	int ret;
> >
> > +	if (umem->fill_size)
> > +		cfg.fill_size =3D umem->fill_size;
> > +
> > +	if (umem->comp_size)
> > +		cfg.comp_size =3D umem->comp_size;
> > +
> >  	if (umem->unaligned_mode)
> >  		cfg.flags |=3D XDP_UMEM_UNALIGNED_CHUNK_FLAG;
> >
> > @@ -265,6 +271,10 @@ static int __xsk_configure_socket(struct
> xsk_socket_info *xsk, struct xsk_umem_i
> >  		cfg.bind_flags |=3D XDP_SHARED_UMEM;
> >  	if (ifobject->mtu > MAX_ETH_PKT_SIZE)
> >  		cfg.bind_flags |=3D XDP_USE_SG;
> > +	if (umem->fill_size)
> > +		cfg.tx_size =3D umem->fill_size;
> > +	if (umem->comp_size)
> > +		cfg.rx_size =3D umem->comp_size;
>=20
> how is the fq related to txq ? and cq to rxq? shouldn't this be fq-rxq an=
d cq-
> txq. What is the intent here? In the end they are the same in your test.
>=20

Yes, you are correct, updating code accordingly.

> >
> >  	txr =3D ifobject->tx_on ? &xsk->tx : NULL;
> >  	rxr =3D ifobject->rx_on ? &xsk->rx : NULL; @@ -1616,7 +1626,7 @@
> > static void xsk_populate_fill_ring(struct xsk_umem_info *umem, struct
> pkt_stream
> >  	if (umem->num_frames < XSK_RING_PROD__DEFAULT_NUM_DESCS)
> >  		buffers_to_fill =3D umem->num_frames;
> >  	else
> > -		buffers_to_fill =3D XSK_RING_PROD__DEFAULT_NUM_DESCS;
> > +		buffers_to_fill =3D umem->fill_size;
> >
> >  	ret =3D xsk_ring_prod__reserve(&umem->fq, buffers_to_fill, &idx);
> >  	if (ret !=3D buffers_to_fill)
> > @@ -2445,7 +2455,7 @@ static int testapp_hw_sw_min_ring_size(struct
> > test_spec *test)
> >
> >  static int testapp_hw_sw_max_ring_size(struct test_spec *test)  {
> > -	u32 max_descs =3D XSK_RING_PROD__DEFAULT_NUM_DESCS * 2;
> > +	u32 max_descs =3D XSK_RING_PROD__DEFAULT_NUM_DESCS * 4;
> >  	int ret;
> >
> >  	test->set_ring =3D true;
> > @@ -2453,7 +2463,8 @@ static int testapp_hw_sw_max_ring_size(struct
> test_spec *test)
> >  	test->ifobj_tx->ring.tx_pending =3D test->ifobj_tx-
> >ring.tx_max_pending;
> >  	test->ifobj_tx->ring.rx_pending  =3D test->ifobj_tx-
> >ring.rx_max_pending;
> >  	test->ifobj_rx->umem->num_frames =3D max_descs;
> > -	test->ifobj_rx->xsk->rxqsize =3D max_descs;
>=20
> rxqsize is only used for setting xsk_socket_config::rx_size ?
>=20

Initially, we used the rxqsize field from the xsk_socket object, directly
assigning max_descs to it and then using this value to set cfg.rx_size.
However, we are now shifted to a different approach for test,  where we are
setting cfg.rx_size based on the comp_size from the umem object, provided
that umem->fill_size is true.

> > +	test->ifobj_rx->umem->fill_size =3D max_descs;
> > +	test->ifobj_rx->umem->comp_size =3D max_descs;
> >  	test->ifobj_tx->xsk->batch_size =3D
> XSK_RING_PROD__DEFAULT_NUM_DESCS;
> >  	test->ifobj_rx->xsk->batch_size =3D
> XSK_RING_PROD__DEFAULT_NUM_DESCS;
> >
> > @@ -2461,9 +2472,12 @@ static int testapp_hw_sw_max_ring_size(struct
> test_spec *test)
> >  	if (ret)
> >  		return ret;
> >
> > -	/* Set batch_size to 4095 */
> > -	test->ifobj_tx->xsk->batch_size =3D max_descs - 1;
> > -	test->ifobj_rx->xsk->batch_size =3D max_descs - 1;
> > +	/* Set batch_size to 8152 for testing, as the ice HW ignores the 3
> lowest bits when updating
> > +	 * the Rx HW tail register.
>=20
> i would wrap the comment to 80 chars but that's personal taste.
>=20

I will do it.

> > +	 */
> > +	test->ifobj_tx->xsk->batch_size =3D test->ifobj_tx->ring.tx_max_pendi=
ng
> - 8;
> > +	test->ifobj_rx->xsk->batch_size =3D test->ifobj_tx->ring.tx_max_pendi=
ng
> - 8;
> > +	pkt_stream_replace(test, max_descs, MIN_PKT_SIZE);
> >  	return testapp_validate_traffic(test);  }
> >
> > diff --git a/tools/testing/selftests/bpf/xskxceiver.h
> > b/tools/testing/selftests/bpf/xskxceiver.h
> > index 906de5fab7a3..885c948c5d83 100644
> > --- a/tools/testing/selftests/bpf/xskxceiver.h
> > +++ b/tools/testing/selftests/bpf/xskxceiver.h
> > @@ -80,6 +80,8 @@ struct xsk_umem_info {
> >  	void *buffer;
> >  	u32 frame_size;
> >  	u32 base_addr;
> > +	u32 fill_size;
> > +	u32 comp_size;
> >  	bool unaligned_mode;
> >  };
> >
> > --
> > 2.34.1
> >

