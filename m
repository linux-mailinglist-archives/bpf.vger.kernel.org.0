Return-Path: <bpf+bounces-53842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD822A5CA5D
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 17:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FDB3B097A
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C2725B68E;
	Tue, 11 Mar 2025 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nDQ2wD6E"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3ACF260391;
	Tue, 11 Mar 2025 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741709322; cv=fail; b=gD0LZdqvTMUxKe/j827CNEqm9gjC2KIgyj0nRXqVlIn8pbRzyBcoBk7XyUF0sRL5UV/JPEkfPlyXmkg3NGGtP7LqKtC4iawnPi8ndBqV3OqDidApOhbZRaPhG2HJqeNsEREcietsgLCWsWfyMilfpqY9dxDTu94wRN38VgdxYaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741709322; c=relaxed/simple;
	bh=OkjkUrUMX8B7t/III66trsykyVO1HM1PRyjHKvuzWqw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MjDJCU1qPxCbniI8tWJLiTUS6fVE7lobpszunenpJrsBcAYcS1p4QGvTwlWKC/k/roh3mJP2bdnhlSe9ciTHtn9ouWv6dhkdJtkYvdbUWEsAsIjhqEzvR73iOsHdSATPddRtYcMCaOQKJDa/ZBJAJklojJtgJP3w9uA9gfm1iVU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nDQ2wD6E; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741709320; x=1773245320;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OkjkUrUMX8B7t/III66trsykyVO1HM1PRyjHKvuzWqw=;
  b=nDQ2wD6EGmkykwJxZRqgCMjIn2hYiT/NC3+b8Ohz3V3wLbtGe173Y1Dq
   0G+Ol8XdTYhGzSwLLUsx5v8pyYTLMdthGxvWvPPJx8q989+lccxIFiagU
   whXcwGRtAF/2gGi7CZ5aaRnNnGpUWbn9gWbrxWKDDmbK7Igfq7J99Nlti
   7beGHD4hsFWlXLAw4Hux9wPYIIIroFXg/IXINDP0vs7ekA+0K7A62sYXW
   q8FIQvmwswYKpB1W6didFujJ+t+gGfulvbxMp4WVwpTxI93uYem0fx/Lz
   gcvZMRvR4+82yvwEvnihexK9HeYm64MA+hwjUtUikN+q2mdsj3+4A/caj
   A==;
X-CSE-ConnectionGUID: ddYrUMEsSK2MyrObcmVEVg==
X-CSE-MsgGUID: XhiRWuuEQm2S3G7/9l09/A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="52963320"
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="52963320"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 09:08:39 -0700
X-CSE-ConnectionGUID: bmNMZZUtQ8iy58mVrLcD/A==
X-CSE-MsgGUID: aOMMzt+2Romo2gM17OR/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,239,1736841600"; 
   d="scan'208";a="157566035"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 09:08:39 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 11 Mar 2025 09:08:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 11 Mar 2025 09:08:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 11 Mar 2025 09:08:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4y2C7NTsdl1FMSI7xhMWk8rP3bgZs7f/e0vkNl1Sx+UKtzmpMkZdZYNfTlGJVZ6gpLm6ogDFTHpWy9sOrTJpAmCOVChQvXHJ5nEBktodmwJrtroglNF0Nti2SoO8Z5culnZH1WN0TI2wLLU3Rsa8gAnbznjCM0T+pgdaLQ+p+bQz001uMMdORI/wTAgIV2D8pUltIViDER7b5WNhTDR4Dj0+U4D+iBj8ruVhOy/LrLU3D1ZYR8VFadFCSA0nwxyrZvMCjtEw527RAxwAdxlfVh5e3ZdjWgVITJBvXde5gKgtkvOZgpZuLp/ssbqodLrObqisNXvPI0+3++2kKzt8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c59R477ddlaZFA5mwSJIlPuFpySYZH/70GAtW8M5ClA=;
 b=Ci9LwzMAn7++PzPXe+B/iHZUW68+l/HkJU73EInnJr9oKyY5kN8JA4y0j2shEkOrvHGYLpK8xcXG7t43Qh9XadOkG62EJlormUSomWiPcMSC55+i4ll0jlhu+i3RYcXjR/6c/ofhzP1VS+E6pEMD9FT3C35Vihic1PRp9CgLLh5zouVWw16tZFtuBBAZVv/6w/qfmngbYMLoog1Olzlsbv0UKrkhabFRORX39nAXEKBY2VYw9oSU5mE3e7VGhAhJj3dZg8gPATgYZoBudZsVzXANuvpH8OMW8eMDV2E+Mmy3kv9rJxb+98kluYdaXG6rSSzh7ojZsOImDTGb37WORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7135.namprd11.prod.outlook.com (2603:10b6:930:61::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 16:08:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 16:08:35 +0000
Date: Tue, 11 Mar 2025 17:08:22 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Michal Kubiak
	<michal.kubiak@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Simon Horman <horms@kernel.org>,
	<bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 15/16] idpf: add support for .ndo_xdp_xmit()
Message-ID: <Z9Bf9o+t4BmFsMQG@boxer>
References: <20250305162132.1106080-1-aleksander.lobakin@intel.com>
 <20250305162132.1106080-16-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305162132.1106080-16-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR0P278CA0131.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b58fc10-dfd0-4095-b71c-08dd60b6f9f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Sv4LRoF2QikQXpD+kVNXrRiIbrk00er7s3ndp6ecgEXIYUhlW80vTpYgD+AV?=
 =?us-ascii?Q?PC28XkijZT5ymhqHLqhalsmexilCAH5rTpcsqPtNbEuy1pK63WWiPVq1y/WA?=
 =?us-ascii?Q?UV9N0gEIEDzTrPGTzkUYmM5GfpoVAg9ZTsbQmtQerkH2NZwqBRuNPf32zhRf?=
 =?us-ascii?Q?VAllc5GwaSVquuorrmY23YR+VZNi7/EOSBTkcmUuz2WKJaVmaahVJWWjelEZ?=
 =?us-ascii?Q?U7CfSIYNvIxW8H2mlJFSyceQTsTUU2q4fcMljoS05yoaH9gsB17qUrxZGHMb?=
 =?us-ascii?Q?6Yf1tJmpVvl+hfeM72VMVUzzuT23yg+KJttqSLgDWubaidRF10t9ae/EpA+1?=
 =?us-ascii?Q?lVE46OAv1g4dCImHV40GJMDTHQVg4q7N+6zWEQnlVqKxl7oism6XTf/artXt?=
 =?us-ascii?Q?nMaCqjfJlYiQBjsb6Rfa8Q1496gNhuwIrA2ZFmzYz3nJ8ZUA69yN1GZsc2y4?=
 =?us-ascii?Q?L68IGVAX95Tyg33oqmWV76F02Akq+UQGxmgmRgodKfNDHBGwgR/mSU29I6Cp?=
 =?us-ascii?Q?6EaAjKi5YjB9Uqd0YDr6g9rTYNq1F/YMl8iGU19lFCNqN9+M0Q+2V+g59JXQ?=
 =?us-ascii?Q?Aw/gHvshWRrGk1qb027AvLwbuC+bSta1KfVbPurURclgy0oCuVbGffBd9g88?=
 =?us-ascii?Q?gortUxp3qmPDpAdrLzIuNPpATaCAMxrO3WpRJ6IHDCXSDPTgK0mUhqsaU39j?=
 =?us-ascii?Q?eq+J2Lf/J+/T+ZgVr5Gk3BTmysV7Pwr4avXfJ9ejGAS9+vyT8jI9IqUsI+hi?=
 =?us-ascii?Q?NqYDrJcWoRwNhCWhxG4akf6IEwcZ4vDvDiJ+bsXSIXdvXpsMiQon7c90lIO3?=
 =?us-ascii?Q?kzAGa15PCqANcdVoKOBzdCS16fWNpLTpEtiPeGIiyt8nYuIC1qa72S2Ib2+T?=
 =?us-ascii?Q?4L7FZnckVLFbxBmZq/OdUQgmV6wWx6XRN3+pt6e+TzxM6CUdW9oCI/Hgw5bF?=
 =?us-ascii?Q?/1AbKV89FzJzAOD4l93onl23aeO+vF7qP+8jc9g4hEfwdcbdn7CUhdHrP/iY?=
 =?us-ascii?Q?if2mxC21zTyO2vP9iFNKTRCLmBYTx+Xy7rglj9nRolqyYGYjZWmBMaiXA85+?=
 =?us-ascii?Q?0SIx9BF8rJ3TsSB5w0EI+2JGviuK8+b6zUAiqD0D+ZHGVRFwroFt1YFP00kj?=
 =?us-ascii?Q?nLOa9YMUJlO1NDV8Ae2APwXeNX8/M0Oi6Qo6h3KvfqXVeZZewLH1ktDydyPC?=
 =?us-ascii?Q?XPdgX0Qt+c3vo+HzXC/l+zN4NRepHviAYooTeAYMxfvDsGLxi2YkAOhkOLS1?=
 =?us-ascii?Q?Am+o7t2p5cF+3yENb9m+MJWj5L5E++/d72Am66Xet66pGllIWzjeiZCNltq/?=
 =?us-ascii?Q?ndaBk1oC/bogs+81FDEWr/CQ657XIQLrNXidLVrBdt8e8oMaDAGRZ/LMI8hG?=
 =?us-ascii?Q?1gtvbgjwUlTE1GwuspH6DB+DNlEa?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FExpF9A9FAVM9/CzA+8uN1A5bdDv+qB/dEnBI7dK0REv4M4/ejDBoRHh9WoY?=
 =?us-ascii?Q?neBo0x+jsOImArMIQzHvHEQS3E6ijnTPgbV/EaVVbri7r01M+gyjmlbF2lQc?=
 =?us-ascii?Q?WnlIwfzDcUahsRDZw3NBG51agWcDtUZ8b4xmYVCiNqufRqcMuW6xodc3g/P8?=
 =?us-ascii?Q?xzSVHf8G2zFvQUAHjCwYUDWyUeBl7FCnjlhN65sfxWb45zxtddA+kNH22mxS?=
 =?us-ascii?Q?OTeokunSda359Grayp38Gdl+vgzw7G8I7U8K/riOnlh/jpJW/GYR3xcjVA8u?=
 =?us-ascii?Q?dZomRj/bqc63HjMLIjHcDlf1rMU/4EhVgb3oRglKHcUnTOXaViQIk0V7w1ic?=
 =?us-ascii?Q?4fWW7oWSjQvqU24Ctxk9Ipzd/5QyaRfJpjwz84Uvtpv3Ww+vNhUWx0UaIAiE?=
 =?us-ascii?Q?XaBNmDZe5vL0lEjjvaQKmzUeC2ZXzjiUZevHygjF2vb7e5UjJveqLHF5rqLT?=
 =?us-ascii?Q?XxME4cIutU1r/amzpXGHJ9dvzFRI/MXTQfDDK7J4u7nvR8mpB17Uwq41x56p?=
 =?us-ascii?Q?2S62tJAo0ZGuP+XRYo9YI7AjhPOeCjdH1J+l2aQx41D4/Un+o+eRqhiaFPxk?=
 =?us-ascii?Q?1C6QnyGZ+40eR7Mjhx0TmYICAY/kZCS08oRy6QwODCePhDow3lj6v/zdioCF?=
 =?us-ascii?Q?2j5mSrK0dOugA7jP9lYwv/8ZqriHbpDlINu6wpPkPAYKcG5dmksBsXWrUrrM?=
 =?us-ascii?Q?jmNQTV7rigMPxrPlmGBixRjwu4FaZMZLssmHIQktMehfci/piWr2FUEULkvl?=
 =?us-ascii?Q?ffVlVoees/+P45wBn9JEAX3Jj1AYIctx4JkeAhWZTm35cHSQOwDa8QeQDZfD?=
 =?us-ascii?Q?u8sjvAwIB+aoRIXTk2T+IBCd7Sdk9cOMxKmQ+vTFEEUpqDaHkiKz+o9INGl7?=
 =?us-ascii?Q?2/xuONoE2gsKtiXYX8yShuxTsVJw0jo+gZ8BTIIaDwrkDoaOvfBIA71wYcJh?=
 =?us-ascii?Q?0pDK7FsysDijvkEmmHVqQRsodO/dsCMiZAA83NJjOOwmw2NRM9b9aw9ibueb?=
 =?us-ascii?Q?SxYwF6iZV7Q6WZ22y94Qy5lmqxGY3Av6TPZyeNiqNc0V94qKMdPB9R77GWo3?=
 =?us-ascii?Q?MRyfEQans6u7oGfQZmTDNYWC8l81qUhCqwIGS3gw2b2/McdTsqwK36kO5XNZ?=
 =?us-ascii?Q?ct+l1zKTrRjHCLSHz9uxLCP9iiWC6b5P1ne7i4DF7gXNhi75otv+JIhbRDJM?=
 =?us-ascii?Q?rdErt4cy/qGmxLDc5XDrt/QjR37tdlmGmwcj4LNLQYSdsGacHfwaqAQOU/t5?=
 =?us-ascii?Q?XOz6thasGE+KxUI9UzGPEFkk5Jg+6TV8mYdiSNMAYE0W0+nTLUJ9h8XJYDKk?=
 =?us-ascii?Q?ZhXVFes1MHkpQfGWNapUW75Mr/FLy+YHGsKTMKiVB+stVWLuS7gne2KFPT1e?=
 =?us-ascii?Q?GtVZrbmd02zxtkjWVQ5GdFKMtKnjs/9FyRUmMKTZJkQyaEgu8nVDAz+ZmW1V?=
 =?us-ascii?Q?tQ6Q8xuID8LDvYS8WSn+wtTWIhiZ9FyOIQir4/XcOi+eGIh5Ybcji2jGepkq?=
 =?us-ascii?Q?IVwbJQEcKkW6Y0eombhyAITPwRzT3eoah4qurtVH1M7MGMoM4tP3agUBVQou?=
 =?us-ascii?Q?mV+8GzqK4QSy7qzVryUU76qftZvw7pOwRAafs7OEXZX6NQh3hb9j7FO+aqBB?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b58fc10-dfd0-4095-b71c-08dd60b6f9f9
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 16:08:35.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qGwxNqoFy48mabBZl+Lbj2ikgW/oSkz2ktEemGGTgsqnXyg7e3zmxMr/aKlxDxiXtbkdcbF0Y/3HnRX0dTJAfUR+IlBeZiE1BJyLOLFR4sM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7135
X-OriginatorOrg: intel.com

On Wed, Mar 05, 2025 at 05:21:31PM +0100, Alexander Lobakin wrote:
> Use libeth XDP infra to implement .ndo_xdp_xmit() in idpf.
> The Tx callbacks are reused from XDP_TX code. XDP redirect target
> feature is set/cleared depending on the XDP prog presence, as for now
> we still don't allocate XDP Tx queues when there's no program.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/xdp.h      |  2 ++
>  drivers/net/ethernet/intel/idpf/idpf_lib.c |  1 +
>  drivers/net/ethernet/intel/idpf/xdp.c      | 29 ++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.h b/drivers/net/ethernet/intel/idpf/xdp.h
> index fde85528a315..a2ac1b2f334f 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.h
> +++ b/drivers/net/ethernet/intel/idpf/xdp.h
> @@ -110,5 +110,7 @@ static inline void idpf_xdp_tx_finalize(void *_xdpq, bool sent, bool flush)
>  void idpf_xdp_set_features(const struct idpf_vport *vport);
>  
>  int idpf_xdp(struct net_device *dev, struct netdev_bpf *xdp);
> +int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
> +		  u32 flags);
>  
>  #endif /* _IDPF_XDP_H_ */
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> index 2d1efcb854be..39b9885293a9 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> @@ -2371,4 +2371,5 @@ static const struct net_device_ops idpf_netdev_ops = {
>  	.ndo_set_features = idpf_set_features,
>  	.ndo_tx_timeout = idpf_tx_timeout,
>  	.ndo_bpf = idpf_xdp,
> +	.ndo_xdp_xmit = idpf_xdp_xmit,
>  };
> diff --git a/drivers/net/ethernet/intel/idpf/xdp.c b/drivers/net/ethernet/intel/idpf/xdp.c
> index abf75e840c0a..1834f217a07f 100644
> --- a/drivers/net/ethernet/intel/idpf/xdp.c
> +++ b/drivers/net/ethernet/intel/idpf/xdp.c
> @@ -357,8 +357,35 @@ LIBETH_XDP_DEFINE_START();
>  LIBETH_XDP_DEFINE_TIMER(static idpf_xdp_tx_timer, idpf_clean_xdp_irq);
>  LIBETH_XDP_DEFINE_FLUSH_TX(idpf_xdp_tx_flush_bulk, idpf_xdp_tx_prep,
>  			   idpf_xdp_tx_xmit);
> +LIBETH_XDP_DEFINE_FLUSH_XMIT(static idpf_xdp_xmit_flush_bulk, idpf_xdp_tx_prep,
> +			     idpf_xdp_tx_xmit);
>  LIBETH_XDP_DEFINE_END();
>  
> +/**
> + * idpf_xdp_xmit - send frames queued by ``XDP_REDIRECT`` to this interface
> + * @dev: network device
> + * @n: number of frames to transmit
> + * @frames: frames to transmit
> + * @flags: transmit flags (``XDP_XMIT_FLUSH`` or zero)
> + *
> + * Return: number of frames successfully sent or -errno on error.
> + */
> +int idpf_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
> +		  u32 flags)
> +{
> +	const struct idpf_netdev_priv *np = netdev_priv(dev);
> +	const struct idpf_vport *vport = np->vport;
> +
> +	if (unlikely(!netif_carrier_ok(dev) || !vport->link_up))
> +		return -ENETDOWN;
> +
> +	return libeth_xdp_xmit_do_bulk(dev, n, frames, flags,
> +				       &vport->txqs[vport->xdp_txq_offset],
> +				       vport->num_xdp_txq,

Have you considered in some future libeth being stateful where you could
provide some initialization data such as vport->num_xdp_txq which is
rather constant so that we wouldn't have to pass this all the time?

I got a bit puzzled here as it took me some digging that it is only used a
bound check and libeth_xdpsq_id() uses cpu id as an index.

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> +				       idpf_xdp_xmit_flush_bulk,
> +				       idpf_xdp_tx_finalize);
> +}
> +
>  void idpf_xdp_set_features(const struct idpf_vport *vport)
>  {
>  	if (!idpf_is_queue_model_split(vport->rxq_model))
> @@ -417,6 +444,8 @@ idpf_xdp_setup_prog(struct idpf_vport *vport, const struct netdev_bpf *xdp)
>  		cfg->user_config.xdp_prog = old;
>  	}
>  
> +	libeth_xdp_set_redirect(vport->netdev, vport->xdp_prog);
> +
>  	return ret;
>  }
>  
> -- 
> 2.48.1
> 

