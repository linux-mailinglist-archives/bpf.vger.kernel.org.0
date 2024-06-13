Return-Path: <bpf+bounces-32047-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F39067D7
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 10:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5CBA1F24154
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 08:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC9C13D53E;
	Thu, 13 Jun 2024 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMJTS3ZL"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1510356458;
	Thu, 13 Jun 2024 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268869; cv=fail; b=G2Ng1HCC2X29Nt6KQSImRNRj9eVAVHzQwGU/llWXYaOzC6CKJWBUZaTCiVuRfdB1EGxU8Eq9mGAGaqsernwW12bQoPYYOOls45XF8Xfp3NF259DaUW75kRHGE6rYQP9W02FbR7tRsCG8SPwC34RMvUWlQStzV2nuDn+J31R8DHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268869; c=relaxed/simple;
	bh=I8968A61gDMHMmXm2Q0Osq4u89QYK50mO3hVoHXlTac=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhwDYx4Gx+f54saPKrLf4kppoYWC89rQrftWJzzUIuPWXuG8VwrNSzg8E+cdXjaF+CIjnqIT1XDCkhYViXnpgekeUGMZvmJ7N+qA//0jd0O5uFalEc7HCQdo/RkVZrMvEJlFr3dAwaFrMIpZzE85G7EIEq0cJRnhEmsX3lvNU18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMJTS3ZL; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718268867; x=1749804867;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=I8968A61gDMHMmXm2Q0Osq4u89QYK50mO3hVoHXlTac=;
  b=jMJTS3ZLArx/i5sNtkIkLrQVEgBN8SE3S9pnEDgjU3x769ejEOPQyPhQ
   wLKIYHj2nZVRZEGLnBoYouGxs7ZTKaRNvFf8/dNpvAyTk3YFTE7gP9S5/
   hoRNSq9LQ3UecouK5zsFL8qUAJqGx4T+IbD1dV7D3EVl5PSHhzpAbMnrA
   vrAYcRKojENuujvIE16si3OFEZSrEbXE5rQt/g65JoJZA7H+499R9K/sW
   uGm3leQWJzwE5bX7es13xcgfAeaMfj7jutHVqp2cQsO5BxHMH/dpsJq2W
   4U01lW7HGqLxm+CzaoXg5VU8dlYpwxupGGpg6OPGCTmullUoKBQuKEh0l
   g==;
X-CSE-ConnectionGUID: ZCTpgmL4RoC+KhSUl3Qhtg==
X-CSE-MsgGUID: M03AHQ4XRlipRtlP5Fz6ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18856133"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18856133"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 01:54:26 -0700
X-CSE-ConnectionGUID: qRhJ2h9cSRCTo6OmUJK9XQ==
X-CSE-MsgGUID: Cw/BTPaQQeuMDAD+Tw1yAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40555978"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jun 2024 01:54:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 13 Jun 2024 01:54:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 13 Jun 2024 01:54:25 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Jun 2024 01:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCnZLnrBq4l1D6hpmBu8DzScGxEusXDtbrHm7p9ydwmRTjypvXJysSDLuifi03zZYnSJuzWGqGBSe6PMwmZzhr/eQKeV5EnqYIHFIbtCyU4hk+J1y2Q3p/TLF27KgAANcEXzPvdZsmGA8kPGPnJleJjo3VpM4O5Hen6Rh+0GAq0P7WIKCHv6lBjCl9Yq2uZqns/i0egXhWBPqpUg5x4TdoASj5m/4bMjAL384Khy+/QDoS+Fedm964Jvn6UW2qquUSzWxxRZo9cRtoZRRBzIDXqhyK6ueBfMm6CvDl7fp2mW4BWjDlrO09/BlQen5veSiRtsZWiMKfKspKbWXzEiVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2R7sPhhWr9YECztVNsbADrUxyIaWngggSjs7bT9nN4=;
 b=H02sv8ietpH9ZOzxRdYhmO0oCURXobmVfq+iiGDSu+fFDJjrHiRT2xBvWM5NXzGJbpwUkzJDlT7P8K08cet3C+CdSTWh+89z427t5Ri1OReScninX7hXS9+LLDaREQELhqOzEpyxgBCx/iWoEb4K524u5JxgwuwwEJD34ebl/NSyhwPXOoE8o/vCIJB76zgiUpvdroj9xcky2z8x3xtE0d0U+XaXPtS3e0vBi1Qg6WZq16vuJUstv5F7FEVge+k28eaWVNeF0Ye3X3lbFLmhqmNHUhfnhDUnvL93ZEf9Hq3Qqak4V3JXuR6BeZnv0mT7BLu2MksPzG9YnFbpzFqHxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DM3PR11MB8713.namprd11.prod.outlook.com (2603:10b6:0:45::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 08:54:23 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7677.019; Thu, 13 Jun 2024
 08:54:23 +0000
Date: Thu, 13 Jun 2024 10:54:12 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Maciej Fijalkowski
	<maciej.fijalkowski@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<magnus.karlsson@intel.com>, Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net 0/3] ice: fix synchronization between .ndo_bpf()
 and reset
Message-ID: <ZmqztPo6UDIC6gKx@lzaremba-mobl.ger.corp.intel.com>
References: <20240610153716.31493-1-larysa.zaremba@intel.com>
 <20240611193837.4ffb2401@kernel.org>
 <ZmlGppe04yuGHvPx@lzaremba-mobl.ger.corp.intel.com>
 <20240612140935.54981c49@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240612140935.54981c49@kernel.org>
X-ClientProxiedBy: VI1PR09CA0174.eurprd09.prod.outlook.com
 (2603:10a6:800:120::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DM3PR11MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ed419b-3f71-45b5-caee-08dc8b866bcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230034|376008|1800799018|366010|7416008;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V0CKHSr3lHeoYehjYWV8/YG8QiIeKKQ0qNKx1WUKYbbLURhOgM6oZ2Pm3HIu?=
 =?us-ascii?Q?2hO/ZCaciyNrxkhWjgAbgmJI6zQf6fQo5bK0BR5BGQujpv/OjIAYotY+FJMj?=
 =?us-ascii?Q?KUYtOJIkZwP/Lvwa0QrnF5i6XYb9qMzCQoNLwcHEJTs75/yN9kXZhoHdoXiT?=
 =?us-ascii?Q?sflAapBD5YN330Te/jB9fcSVppuOirMYwvnxriNUOUrDuiz1kE6k/11vtJzG?=
 =?us-ascii?Q?hfxNvpoKSOyybQzfzdJW9zaL0Yj4f1jz8pImA6U3JWvE+RR+6UOGS3Zrh9H2?=
 =?us-ascii?Q?vLybuycNzJQIf4MQrqpPH+70kh5cqVAF95N6VVdhi4GwmOrMOHOheRb33Ri+?=
 =?us-ascii?Q?UYrXWX9GNMoeQ+NkwZzsF0qQibq+rCbuyLiU+DiZ9+uTihghvzwmy7vOFrbj?=
 =?us-ascii?Q?fwfUWEq8U9hJnom/XCSRXtdfebFrtd9gYy94mT3/x2V5nMchZXmdm7fXx8YH?=
 =?us-ascii?Q?e/lzkBWqCZFj+4FYUHF0b0lFdvncuRXXN05aRB80HNZWGMfq/HkyTY6dh70g?=
 =?us-ascii?Q?L55QEhO0yMVpgqKzm0nadgzZBpRCFdQSDpwrODGkC9cRuNj5JyftqodM8Ovo?=
 =?us-ascii?Q?UFTN4wjmOKuC4amdSP67d4hdgCMREDHF0XVPdIbvAp62fOh8S1tPoMBXN1cU?=
 =?us-ascii?Q?f5Ot0YCCmaglxTXsGuwpAKcgdwFv3xSgTEUo/4bCEMglLs2oqPEiZ8bJY1VH?=
 =?us-ascii?Q?tix1WYXyDB3hwcAr7UqeVG+ZYXuexY5FND63xEySCWZisIKKykSdJRBSgK36?=
 =?us-ascii?Q?Dh2gSq8JKSO1UbDZ7QkWa+enaAjwPf+sBJXSme5LahBlx+Za7OTNKuZ/3OQ3?=
 =?us-ascii?Q?/Quc6csPw3twb0YfjitY985CiCxbmukf9pGJJBocgdOkxX1Mn3yzJTXcrpqk?=
 =?us-ascii?Q?Ozg8+qtLjl0YF9wkBr5gI+RY1x3EcuJfpVC/gsYxxZj9BoFwc27S6Y14TzFp?=
 =?us-ascii?Q?QWwp9JWSonGURMafWSkg3E4qO65z2HDSqHeQhYD4/69ZQgaKLObyGpDThW0y?=
 =?us-ascii?Q?JXlW46EIWQ4NcIS4vL8XqSzPVXu/l2VoIQRN2gTNqYUrYSq7Rdpz8JRa1/1y?=
 =?us-ascii?Q?enS89m7NEphHKH7JvdzFVK+9BiJCi+FiPQJ+xIISF+ZudFqBmfYKsG4HfsNa?=
 =?us-ascii?Q?tde1r109CIA3+LBTeTPWWN8W8ocFsO7mC8Uja/tmEXdBYhj1dvaK+GDXZUEa?=
 =?us-ascii?Q?k+RRHyOSJxtHaxt09GrOghn3h+/THQ4LV871i8VM9TlGavtOX20OXIeMCTdo?=
 =?us-ascii?Q?eWuRdg2NNNOFZOID3xpX80k/9hBfx+QZrwTT+qDhIUCAN14LnbbQh2F9jH3v?=
 =?us-ascii?Q?hdMBSGRKOHOWFJpJFW88zfns?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Isx9mLC6rLOF28uj7YN25DI1Oty1tVKWEPCh2wLMspfNMdZmeSA78ezM+UqN?=
 =?us-ascii?Q?9b3/2Gzo9xsWAINza4UIl2iSL4QKXgfezmNHns9+cMmDVIbsk3EYuBG7f4QQ?=
 =?us-ascii?Q?VjiOF8K6zZjVN6sTmo8ndIMpvn1rjCnV9gETDEyOCe8BR4WAp00Dg8j4lZ0a?=
 =?us-ascii?Q?GmMlYH1sMfRv1Mq77y8xt3lzQUs6QDgrJIdBF7l27vfpF3Rh7wrUS9Hz3u9M?=
 =?us-ascii?Q?rdqiLEOperTgm4s1Gfle589polXxlczAqQFEuEAE5PG5OLkU+zN7aZZG1Nf9?=
 =?us-ascii?Q?ezSGBSh6/RaeEIUg46zqQNsFPqOX7HwY7zll4DzuRYw3nzQG6q4/fMi0XeIZ?=
 =?us-ascii?Q?3F+ASwT4WNpPdUTBW+c25Kk4z3pWH1PdLmZUynBJE8p5Ng7DyoBH6AeYsK8y?=
 =?us-ascii?Q?WxTHGQuBZouYmFSlPUpzoRjth81q/0EIE4li6az90Siws8OGQGUXzaDATFce?=
 =?us-ascii?Q?Wk9axk4wLPAW9yRALQCAGVvSzh6mdD0Y+HDjdLeZFVeXNNCrscC7vafeb9/7?=
 =?us-ascii?Q?nPr0Rwg2N64CMOLuViPQgO/mpycsXkvAqn/XmwQKSNhp7NNRKupv2poWybIe?=
 =?us-ascii?Q?8QYiSTMvQUo2L/xRTZVuOcPAUQLv7TJVzVCIaE8eYocmZQa5WeywHR30vgrK?=
 =?us-ascii?Q?erSzELOinULXJetmPwYQHadC+MBSsk+zIIW1JzVOj/6RPSkhH1lnXMhLJeRk?=
 =?us-ascii?Q?0OHph5JNcO0mOtDOmOHWw8sGOaJdVovWTv8DDMicfjDbSjXEM7Nwk7TEx5EJ?=
 =?us-ascii?Q?1rloq5gOGV9wQ28+Rys7Mttgn70FlBEImmHM9T35AkDdJ4KlRabML4lbqSTh?=
 =?us-ascii?Q?Qm1Vsgt5C2rcHTcBQFx5t9691nWeIIMUfUh2+tewk5+y/Txg8GPR4/2W0SCS?=
 =?us-ascii?Q?d8vBjPVTUOm/xSCEtLSm/U+H1xE3t97ba1QTWDqDPvkyQRV/GT3oOJpx2P0p?=
 =?us-ascii?Q?jsWx2x/fvMlnF39VxHwValy61/mAqfDMSm5fPnp9pM9cn/2ibuIBzWlUbYOz?=
 =?us-ascii?Q?7h+3VhUvGNQiCgJwl+uITQgGVh9Xj200KNS45VTQi8BiSLj1MB2q28+lPJ7L?=
 =?us-ascii?Q?TgZxnm1m50s22hqT6J7tG8DgRFehOvDwuR9rb5EVTNM8c/fVdqH2CPyRR18w?=
 =?us-ascii?Q?OOHZ8vGj+3Y0gedRBm+jYQ6FMgJAowCPCb6pIzKy16qo6nQLBSyZBgJIz24T?=
 =?us-ascii?Q?SRrWZSa9djzyoIhe3knR9ePqNOSrJoMDqFiRJhyKrhfyZVxLyYCUkrS1oW2D?=
 =?us-ascii?Q?okgMzm86OKszr2tlmKLWcZ20Xm+t3RnQcwTuiZv0ECbcgfi0+kbGHaBYSBMo?=
 =?us-ascii?Q?/ajcSZUfoZGoaYe5U+4zt20agWwh2aQBikTX0hZszRhoSfqzk45Uqr8j0EQl?=
 =?us-ascii?Q?KY4UekWUtC284vOTf/AEQljnyf0QJDzVzr88iWMrym2ZphobsJjiMzRtbloH?=
 =?us-ascii?Q?M+43mtDol5OVZFmOXtHEEGe/sUTkUc45DCkIC1ludqHC/g4sr2aqwNClyGWR?=
 =?us-ascii?Q?vrf8vrURGMu6+h7xyEWS4kRbiRh00KLfVvJNxyW+PODa4ikhkBptyA+uGZV2?=
 =?us-ascii?Q?sPxztskhs5sKZA3yVJi2cuVvc1rRkLlXJ0p05v6sAiU0aSdfBUCLzMzaqBMm?=
 =?us-ascii?Q?0A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ed419b-3f71-45b5-caee-08dc8b866bcb
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 08:54:23.1322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sB3HYzWK70UI1UD0A70HhsAE8vgFreUozjzn/e0/aa4lIgMCsLFhrA+QvX5NwBt6U3Dmdyw0JJI1y/E5UoLhImBqLS44LArmmSJoLD12nWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8713
X-OriginatorOrg: intel.com

On Wed, Jun 12, 2024 at 02:09:35PM -0700, Jakub Kicinski wrote:
> On Wed, 12 Jun 2024 08:56:38 +0200 Larysa Zaremba wrote:
> > On Tue, Jun 11, 2024 at 07:38:37PM -0700, Jakub Kicinski wrote:
> > > On Mon, 10 Jun 2024 17:37:12 +0200 Larysa Zaremba wrote:  
> > > > Fix the problems that are triggered by tx_timeout and ice_xdp() calls,
> > > > including both pool and program operations.  
> > > 
> > > Is there really no way for ice to fix the locking? :(
> > > The busy loops and trylocks() are not great, and seem like duct tape.
> > 
> > The locking mechanisms I use here do not look pretty, but if I am not missing 
> > anything, the synchronization they provide must be robust.
> 
> Robust as in they may be correct here, but you lose lockdep and all
> other infra normal mutex would give you.
> 

I know, but __netif_queue_set_napi() requires rtnl_lock() inside the potential 
critical section and creates a deadlock this way. However, after reading 
patches that introduce this function, I think it is called too early in the
configuration. Seems like it should be called somewhere right after 
netif_set_real_num_rx/_tx_queues(), much later in the configuration where we 
already hold the rtnl_lock(). In such way, ice_vsi_rebuild() could be protected 
with an internal mutex. WDYT?

> > A prettier way of protecting the same critical sections would be replacing 
> > ICE_CFG_BUSY around ice_vsi_rebuild() with rtnl_lock(), this would eliminate 
> > locking code from .ndo_bpf() altogether, ice_rebuild_pending() logic will have 
> > to stay.
> > 
> > At some point I have decided to avoid using rtnl_lock(), if I do not have to. I 
> > think this is a goal worth pursuing?
> 
> Is the reset for failure recovery, rather than reconfiguration? 
> If so netif_device_detach() is generally the best way of avoiding
> getting called (I think I mentioned it to someone @intal recently).

AFAIK, netif_device_detach() does not affect .ndo_bpf() calls. We were trying 
such approach with idpf and it does work for ethtool, but not for XDP.

