Return-Path: <bpf+bounces-56615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0EFA9B277
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 17:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88DE41B873E9
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 15:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60927BF79;
	Thu, 24 Apr 2025 15:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i64o6/Se"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF491A5B94;
	Thu, 24 Apr 2025 15:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508853; cv=fail; b=Eh8rFSfVd1dnU/esj09r/B12RTBbTI7WevlA1zR+/2Fz3K10m9rPNm1Tz8qOVFtYEwVPzxzhJj7sIQEWwrohd7QBk2ibIPWqigu7H245eT744pGx7aahW4oYE6kXy+FIMrYuLZhUBoxwwL+KBCvv672w1XIkkQL6FpAJsMBsS2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508853; c=relaxed/simple;
	bh=9YSd8j/+pq54i55IwunFmzvHN/1FdebSKC0L/gTkgTE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EeouepqtUSLGjwWHvO3YP4oszG6ruoWE3zLl6C6s9Rk4mR6MRiext4NWmYf7zLKuZck5Xeop/K5Hfktk5avXtqsJei1p4uxG05FVlhBIsDWYBjaDjYp4tUDrG0URwxSqOVus3yKAtC6za+Yx5NM8b3qbSVpwKrpQggxV4BNpP6U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i64o6/Se; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745508852; x=1777044852;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9YSd8j/+pq54i55IwunFmzvHN/1FdebSKC0L/gTkgTE=;
  b=i64o6/SeXPAPdnZRIMjhnc2nMIMZ62UWq87hMVkTRSBgZzQiS50cXD5k
   9TeSx1JwKdnE6Ob2kmQx87r44nbMLcQAetvqbJckOvI8gcg0PX31Yw7tf
   qKf1+2nM/zVjRAr4uGDPhgDSBs/DYYZqBp/SGeLsE9p3Turq+S1mDThv0
   28WcR5zjBGEJZFGxq5GFZzlKrt53+H/1koF84DuHxaTN4Pz8aqO8gyrnZ
   /SiE7G9MoIrg71MW1eTbktsXgVhxpUM6Yl+Xz7HVVtAnhw2eQOo0Gzt15
   jkAq8yPkLWKtLUUvcqZujySmwFQc2WCA4V9qudgZTcCznzRkf60OKlB/0
   Q==;
X-CSE-ConnectionGUID: Mh9VN2gTSLKqszoA91KVUA==
X-CSE-MsgGUID: KEdnJYimQdik5uI7iGtgGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="34773236"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="34773236"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:34:11 -0700
X-CSE-ConnectionGUID: oI885D1cQ6yqWX1aCGkQtQ==
X-CSE-MsgGUID: ccXbu+fmTZ6WaBhyfWiXkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="133611885"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:34:10 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:34:10 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:34:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:34:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oAdxX9yBlLAkIh/pHpTCYuRKC5sRGfLh8A/4ubTvSvk9EYmDNhi5RtpcI1Sy6R5Q1dmP9cyF8wq6jzhawKHDXspJHyCsLI+AMUulPrG/1EKeDHuOznCea72/0rCjM0WmKn8/M5fBdgAdz/tynu01CFqsGd/ceEF8+U55ssqEPLFUHzSK29Rrlvzy2fp7+ETrOpea7NUEy0uBmPyNuqtNjfiYpxOBK57skQ/8GeF0AqwR9iqTsp0ydLkAd4vO6qOM6GLjvr41WozA2H51/xpjfiqw3HvvgYDbalShp9LNmMb9xr3CzpENe/8+Qf2BCqs2xyXD0OqHgNuGoMQa3coILw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKeAMhgQWPG9K/LK8qHzfeyXpMPH6LP+Qrt5U8XJBpk=;
 b=wNXxdC1dmCytLGD+HOmzaOr1HBtA71E1xG2O7gmgBRliphpvqtbNE6p7LAX0NgNy7UhAMEZIKat59Ar0SMC1s0qd/NlzmJiPiqZUhkSjBURA6OnOvQxklpqdIErW8dnQKPWuR1HPXuEWrjFVW+5ceXlngXJweub+rSWkImfO5wy3OAEuZUpi6+oVxyLQoifgUadoyBHvVCdt99AIaFf2v4VMDR2OvejuHMPQK+u6OUcZrTigRzIUDuQLRE+W3c6kFe+wPEbb9AUnvIg06r0vET2+uA8KqEA+MJJgjt/kHJqOr0K2CUz0dmPbb4ngK1qHWYJXYrpTYJO/NpoG5y+XGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ2PR11MB8537.namprd11.prod.outlook.com (2603:10b6:a03:56f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.24; Thu, 24 Apr 2025 15:34:06 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 15:34:06 +0000
Date: Thu, 24 Apr 2025 17:33:59 +0200
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
Subject: Re: [PATCH iwl-next 07/16] libeth: xdp: add XDPSQ cleanup timers
Message-ID: <aApZ55JEtybm32eZ@boxer>
References: <20250415172825.3731091-1-aleksander.lobakin@intel.com>
 <20250415172825.3731091-8-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250415172825.3731091-8-aleksander.lobakin@intel.com>
X-ClientProxiedBy: DU2P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ2PR11MB8537:EE_
X-MS-Office365-Filtering-Correlation-Id: 08e1754c-b13f-43ab-6d34-08dd834572c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6sv99BjTBMKiuLYrry/jFgaApPM4TavddrhmaCUO9IU1BB8RXU8PNM7LAv5Y?=
 =?us-ascii?Q?eiUzotXC2Tjn8qLz2p1Bipvds8JSK+v5UzCiR0BHdjZNOD6QJ2KaB+Cs0nb5?=
 =?us-ascii?Q?4X6wbRBGW98wfvcOQtUiywO7D7lRcIAZtgmTKMSGgPQwaLYdRwrBjvW8EmKw?=
 =?us-ascii?Q?gsUkH4sfAwBYL6/hy0Q1wrdN9Q2er+vcWbTzYqBZlnf2Wn8a47YXGSBD1I0T?=
 =?us-ascii?Q?WH+ngGI1IlgKCyq/aa5cIbqB11CdYtco5k3ttmS4JAqBmQvVVX6bb9d42HmN?=
 =?us-ascii?Q?mMmbORmTf9+2929lmv9gi3pR7yyGK2cnUC4HuE9i5sIYJl6X9A6l8RXxkF/2?=
 =?us-ascii?Q?+hKsOHzlkjZqoWOQvmIzVBsPEPYes2yR7TjPB2c6qY1GKbFyaw1UydyzFCpW?=
 =?us-ascii?Q?hxV3Egt+Pr1y3nBJrwYQ/9UrigdhazXfo0YGf3v6r3yFPAoIBwm9vgnbkT6I?=
 =?us-ascii?Q?43OTPNYN2EEo9tqs/rKlCfojTKyfKwqWVQ0aB+8IaL25fHIjwhBAdEYCAZMN?=
 =?us-ascii?Q?1kBo76zWlGuDLe3CS2tV7XcqYZPp2QcDSb67gJAhibldbHmUEKPk9NreDDoU?=
 =?us-ascii?Q?rwwKOF5xHzaBMPRGVQmY+z+SxKMNh6pFzl9UReRyF0ZGgcmpSu6nqE22r+Kx?=
 =?us-ascii?Q?oqnk45yipuxFzPHHurKcXruhpO+tNynxS2aczkEzRZvYIyE7eilYsHagCvfz?=
 =?us-ascii?Q?4zxuQTBQGc/QuJP4FBsnXthOW5UFo6TRxnK0ECcKoAaxi0+p7z7LTU0rMb+C?=
 =?us-ascii?Q?fMMvX/e3AUdS4HJpep7R72cV9wvrFpd4bKvexJc16wKEy9aB58vEbvcSw6Ku?=
 =?us-ascii?Q?uUBKo4Q8rFeesjOrMdcWosebH/GjJ3YZNgSPHa/ZVgOAsTUl0R4ueRP0zJxM?=
 =?us-ascii?Q?FgX34obhWM3NT9OXgowB0AsDQT21cShCzjsf6jFgVTLVG3XXOuP8GSUmduSg?=
 =?us-ascii?Q?bBObsEQrLoVatgNfToxokpysMH7TkloGR+g9qL63RwlD5cLu36CbAZLCXVUO?=
 =?us-ascii?Q?ELvtvpQqYsf6EpsfsKk47KQiXcAGZiVD9hG/+b9nI+uMcC4ISvkRkmUGleCZ?=
 =?us-ascii?Q?1xUEqakcPZ56xQRJ6ICS3tMPOjtdQ3HHWLqbaAGyP/OVyCLlD1+CMDdbGi7r?=
 =?us-ascii?Q?RtwR02UqjQ60zGHL0B8LQumpZXyV/DU+X11KTOnWnC0QUmzfFCTBQwDQMX9H?=
 =?us-ascii?Q?sAwQs2yy9pG9XVqkRkIRzol0sT/X801oB/P2jzWz+8sxhkowUzq+l7VGQp92?=
 =?us-ascii?Q?tUlNi5QGY5XuNl2GcpXRge4QiTxV26BwNJW/LI1t3LkL93Y8y8MXnFeWvbLp?=
 =?us-ascii?Q?VX9+5aBXoQYPz92CINl8iqtcU3eV1ApRff7fDnAX0QsYoiqvKRgFfwi8MQQ7?=
 =?us-ascii?Q?3/J7cCivtP0qxen8DVg5tuk9sUXGeNyBgI1o4p/x+XcndCHPyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ixBNcUKwDEdtsMz2Q1FdaIwdQUFMqi+0QJtsz3WmcETRUOatez3KeNKXF1RI?=
 =?us-ascii?Q?mmpmnlQg/r681XQgzXBUGSHm8VcSEczcwJtzl5xj265LFNLv1KMsdlJHM9+F?=
 =?us-ascii?Q?HqKqD8ADcqVtL80E2Qg4jbJ2a3S8B/XLKe4MSyZdVacu6gdaFEacHiJjdoxr?=
 =?us-ascii?Q?AJhXcZEGMa7+SBRJ8cfdTaADJbwl9Pz2jdAynCuOkp/5oBvY/y3+hzqAsm6/?=
 =?us-ascii?Q?JQhFlefRrgr84XVvVnN/JojF4bQxnJUch7gQdaWrTlaMaNtWYCZ/MXiya3f/?=
 =?us-ascii?Q?yHURHMr88lSLBH+UfykOFrg3VnBIk+v2HLWCOtrBPp/FW1dUqF+ZPaZb+sjD?=
 =?us-ascii?Q?d0mqMsrsZjRELmO5KiOmBDGIrW3OKH60DF6k20TTT8cr7UirO5dAYixF4YbN?=
 =?us-ascii?Q?2cfs+pt+swengBRW+WT0TN3VEUpNelc927m8xhWhZzwuWu3TAVQy3KoqOTOz?=
 =?us-ascii?Q?ozhv46qjJWdFN2S1lj75Sla5rE9VdTbv6Z6bcQosG5ppie9+NtarRq5Ne+tP?=
 =?us-ascii?Q?DaHk0zZIiNY+E8DvRTic7lbk9djpo3RJwrX7xSbIyjMTqtPbavYV4jBddngC?=
 =?us-ascii?Q?9WwRaF4kpCTx+CJalbETQbBXDrjIyVlbcDnpClTvzHaaAO9I1KJtO58QSfsc?=
 =?us-ascii?Q?2UAvw1chP7BT9tS7eYeUy6mtqUhntP8U1guCbK+U3DkreIk9A9OLN+55M1wh?=
 =?us-ascii?Q?tej2i9cVMdcMsqRqP9cDVVcYv0aOvTHLuoKDl9CxZCEs3cG+M6KtbMpvAvbQ?=
 =?us-ascii?Q?vIlKDtenIuPkB5iU//KOJcU3UJ6oUQ8Oa/P5eOWi3NkivseJmIKxW5FMZi75?=
 =?us-ascii?Q?BbsG8zkt4vUERMhJ3tnM1ZTRC1SA+e4wayrwCXBvjCN3K9/rTHh+nPRxfCmZ?=
 =?us-ascii?Q?KLGkyQa2pzv5MxLmb1Ur/ULEnDtL4CT5BslADdvScZBPpJ8zl7KfjaIo+99u?=
 =?us-ascii?Q?7G4+4YtjiU56rPQVm1uwmKF8mMp6sdPqD/5KsZFPlhg3I4HZ3MThLCEcMlSH?=
 =?us-ascii?Q?DM0X7y1UPNOcJKtaUhB5DGnZI3jlSVymNl9b5QRPZIVk4wcwp03FZ0Qlcjqd?=
 =?us-ascii?Q?XkY3tie5zL78dDMUpex6tjIGumqw2FElcLOOKxUqoeJWWKoVAcqTZoCZRfx3?=
 =?us-ascii?Q?LTC4vwECCpBx0BVr4FVp17DzP/htG7QzCAIsEKTVGywnbxpxeziVhfOWIqKX?=
 =?us-ascii?Q?qw4kzrKAJJwVPHLMARTCPAsEmCswnMmDl8LNFUOHjI+zY2Qkt31/d6WxeiDO?=
 =?us-ascii?Q?TFpO+22X+0wFn8eFm0MOrMhl/tVP/sSS2sIoyu5qskJCJxidjtYg8hHnowcf?=
 =?us-ascii?Q?QGlBJoj7R/QWLl2FVVcZS6D7xRWI9ekWW3giyISd/qDDMpPgwwB3JtlWeHTE?=
 =?us-ascii?Q?zWDBIA/wSwSylBhRpLBYMymnTXXWkrHaFil6zBoRY+PDNSr5/nuH4gL0a1Lk?=
 =?us-ascii?Q?ar7ySQ0PDTqsYj+rTnVQZcMepvT5gsS30bUdyRDK+/Sz5NQQPw7YQyRd/3y2?=
 =?us-ascii?Q?zK1d1S8xw3+lCyItq/6BiWegMDq6hoeTlS0MpoVnzIpyvxgVDbRpWSqbW0hQ?=
 =?us-ascii?Q?1rEktVC0du0E+uT4bDJjfXc2f1g8jUGEYlZJXRVykSAuquSbBKJqcj6SwDS9?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e1754c-b13f-43ab-6d34-08dd834572c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:34:05.9428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv10d46DYxXC7eCG7i0TUZQZfOKHt7fHfHEVXMg68teM2iTS7526y3/KVUlbiehxEBDYE+I2qKowXviqzlK9QZoibhgKXMQGqCYR5y2l+bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8537
X-OriginatorOrg: intel.com

On Tue, Apr 15, 2025 at 07:28:16PM +0200, Alexander Lobakin wrote:
> When XDP Tx queues are not interrupt-driven but use lazy cleaning,
> i.e. only when there are less than `threshold` free descriptors left,
> we also need cleanup timers to avoid &xdp_buff and &xdp_frame stall
> for too long, especially with Page Pool (it warns every about inflight
> pages every 60 second).
> Let's say we sent 256 frames and don't need to send more, but we clean
> only when the number of pending items >= 384. In that case, those 256
> will stall until 128 more are sent. For this, add simple helpers to
> run a timer which will clean the queue regardless, after 1 second of
> the last send.
> The timer is triggered when finalizing the queue. As long as there is
> regular active traffic, the timer doesn't fire.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

