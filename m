Return-Path: <bpf+bounces-41120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065F6992CA8
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 623311F23DB5
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2024 13:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CF51D359A;
	Mon,  7 Oct 2024 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ke/mXRsq"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223BA18C015;
	Mon,  7 Oct 2024 13:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728306514; cv=fail; b=qxyqKSb7VZ1WTk6tgdOyw245LknlXM6GqSnoHTFaQaMlRCk7Wu3XSrZ4X6XKItVjtqGwTWt49eciFMWgRbjuVgYm9kjol7OfsS+aVKm1Ahj2Wntk3aXcnPWwG2EyEAceQ8eHtqD1IzzV9v8mc4+pptZYvdeD/JTfKSEIW4KnQ8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728306514; c=relaxed/simple;
	bh=am+Mtwb9xww2rdLuSuzkP4dQW8lD1T9CXmdMOh7gB6I=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LVFl3phduvbU48mg74TrOUBuAy/RdUkAY4GrLWt1DlZgTIMUV06BVNBZDvYnhsPRZ4P1rZSY0BSfFwuvGiXS4AcP+uHCOSbXzawM16ac6Y4zxBNXxglI4szpeCWy5TSjt/xYgeAxw4kalzSUxgNFgbdzAVili48EeZFECnSv43o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ke/mXRsq; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728306513; x=1759842513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=am+Mtwb9xww2rdLuSuzkP4dQW8lD1T9CXmdMOh7gB6I=;
  b=ke/mXRsqQw0XII7Ia174j+D+ZyuqmH5FqdbZWLPUsrMcnY1wghsXsM0/
   k+QGLRktQBYlUgf42wUuOEaif1zUpmp81xn/edUzZn6NZFhqrXH500I83
   VSuXab+xsuZL5h0USyD7MPmbQHTrYZR2DONgjU/Uyyb34m/AkiQnNRK9k
   A5POte7dwQYJyxV3rVFRASVn5KYptP0U9nOeHxCtxAF3HiWXSCiEzrn+H
   G3ZmIg7L+k22CSyWvjcqcQP/HVA0k6ysCOcUrczDnTQPHySAYqvD69qV4
   S9GsJKcpmx3MFx+MLHxpo7WKf68W7gXAacjAIAYQuACq8lsaXaqBSI88c
   Q==;
X-CSE-ConnectionGUID: ffL9yKY1TUit3KFH6i/oUw==
X-CSE-MsgGUID: 3a9fGry9TT+9A4vcJJuj0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="27263637"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="27263637"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 06:08:32 -0700
X-CSE-ConnectionGUID: C/GaGrVgTFSHJcFLYeJtBw==
X-CSE-MsgGUID: u3HGGzDeRkeSmREwFQpzXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75143409"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 06:08:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:08:30 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 06:08:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 06:08:30 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 06:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wjvFhoFNLLE1K19K/fN9/sfYlIWwCEfHjjWBDr3Gyx2VjOuiwCQ4rEtJwGY8abAfN8Y548Yz3Bg4AGtxh2Xy7HGuuBH1k/KW/3wO3fbELgO94BN1VfcWp+PTVycVI9lbr14Dj65tfh/PwgLvhbhIra3jzxf/4Ppgv9PCVw3WLtV+ku66fb9SIaAld7u6JQaDAj8w31sK4vHIhmHNvqPip67SpLQ1zAOlGVj/SQLnCtyKB6Ty69jsIt1II//urLbQfHw8A44ZxfvCydJY0FfB2Qthg5oYcMMWc79zDWhSgI1tVzm0irlr5Q8kG4DXxXButjKB1nd87NgsVDzbtzgf2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7crTi6/FJGG2njPcIQ1A6xRa2ACFkH2nYf92crrOG7g=;
 b=iBBjAs5i77viRi7wgzKGRQJJOtHmFzIUxBwqh9sCG/mxndIMNnl6sOEUgMWEy9/HGT1Lgmc86HRFON5SRyEzplqn53ZfiyNNmy+FQa6g61yTqVn0WKt0djbxyyRyiiswuh70ClYdSSwxCmZH8ABWDZfOhlGevmIrE7+4BwTtjpP549Ngp0u3/EKrYo6RY2ptZBa5FEqdD/27gAvwyUGdkX6y9jvqcUiCRJnYQ22BoC3U8bUzq2ZEtsLsQ3dhJqmjj7k8eDhDLWqMR1SKnupq7/Gx4+rZ6Nxi/l90cT4IErCLphnXNM3r5Wsaw64pdVKyyfaKoyGm5jYqhh9rvc2Ncw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB6987.namprd11.prod.outlook.com (2603:10b6:930:55::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.23; Mon, 7 Oct 2024 13:08:26 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 13:08:26 +0000
Date: Mon, 7 Oct 2024 15:08:11 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Kurt Kanzenbach <kurt@linutronix.de>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>, Richard Cochran
	<richardcochran@gmail.com>, Sriram Yagnaraman
	<sriram.yagnaraman@ericsson.com>, Benjamin Steinke
	<benjamin.steinke@woks-audio.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, <intel-wired-lan@lists.osuosl.org>,
	<netdev@vger.kernel.org>, <bpf@vger.kernel.org>, Sriram Yagnaraman
	<sriram.yagnaraman@est.tech>
Subject: Re: [PATCH iwl-next v7 4/5] igb: Add AF_XDP zero-copy Rx support
Message-ID: <ZwPdOxJrk04D9FKn@boxer>
References: <20241007-b4-igb_zero_copy-v7-0-23556668adc6@linutronix.de>
 <20241007-b4-igb_zero_copy-v7-4-23556668adc6@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007-b4-igb_zero_copy-v7-4-23556668adc6@linutronix.de>
X-ClientProxiedBy: ZR2P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:50::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB6987:EE_
X-MS-Office365-Filtering-Correlation-Id: ed15ac14-49f7-4e54-842a-08dce6d1211d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O4NdccBn4s7xew7KPeL5Ik/0jYdOW5qmGHIrdoTAnPk6v7ivsw89GCT3Fl/W?=
 =?us-ascii?Q?QWj4zLRir5Akt/E7eCo4BH3qhSG3pfac1fTtJp6BvdH45vGOfCKV1F4M+OCH?=
 =?us-ascii?Q?T5KRlWMTujYwocgyt29LQ6+QG9Ebrnz9a1vkTL1Pp4PPIpwg/ayNkuB8nn0K?=
 =?us-ascii?Q?ykcQ2GJOcRkxiFErRHprcdXu/XrPP5rpmND9sUFU/SHjSD1roo7D7FwwsolF?=
 =?us-ascii?Q?fqbZWonwLjWiPhC8/neAw+T1FdASH7lq7IZ7tBuwEnloVsAC34yk5v1lFFjD?=
 =?us-ascii?Q?0Et6v5jAozGLO/qGlGq7w6hfSt6HxfK6rYeKc7J0ozBaBMfAMVsV1LWE3Ysf?=
 =?us-ascii?Q?Pv8WE0XFt9sqeyNQn74g23fu3JR3MQjUpIuQWgGVqYLtYdu/1dFlDj2JkTpO?=
 =?us-ascii?Q?qwEojWPLxnttS2yJ9jf1HeA3XhJ+6U8z7A281AL5cTtlNk49GspYoaNeu5tM?=
 =?us-ascii?Q?qjNxPihwgwbgl04Hgt5uE4/Kap86HqsPYkmkslQXsiaRDZ2NXn67rvL3MLhQ?=
 =?us-ascii?Q?sdyhVzHknsDZ7/8zLQhg/ruLthElloRIA8RwzC1xzzkkQxLSY/0KrXA8SsKp?=
 =?us-ascii?Q?ykkC35i6MAmYXpka4HHAvZ1w4MrT3mAwzwgPVPGG1yDa31F3Eiqtnvmnsy27?=
 =?us-ascii?Q?73D3IcDTNXkakprPHz+b/CYNcD4fGMaHePENiSt+G7cNCZg/eiVKNaEH2tHc?=
 =?us-ascii?Q?JIXlFJFOhRH5xFJ84T9Lt6B9MamX43vrNWQZJDZy2HA+ns8jSMd+UXzfQ2UY?=
 =?us-ascii?Q?E1S9TleLqwPSHOatIqsMDQQ80Im6iJNpZDllAr0wCA7TNQxVtK+HTIjKpvHU?=
 =?us-ascii?Q?CTXTgS+2yNVDSKtzS7u/zxf7Pi2Ng1anm4RK9rv8BPrD90mQw42XOgy0JnIZ?=
 =?us-ascii?Q?pfLyzEibR6KCsjFZZS4WCXryxHJ6t4L5f9V/2MGiwdTbDtEbUe7F19P6CMvC?=
 =?us-ascii?Q?s1eiIxxULXWL6Wnjfcg/Vuu5rVuccdGkZcTueIyK531if3ITKOshwZMX6CAG?=
 =?us-ascii?Q?67tjefWd51iIsy6ZjqIZVOdYtjONDARelYGig0K6h1p1NCI8EJkBdKKMd0DY?=
 =?us-ascii?Q?Jt/IKU4PevoZTeokq4DOqHWD4u89EFZV3kWaG46Q4HEDkC6BCbEhUcJ1186O?=
 =?us-ascii?Q?KpJPCNZby32J/48QyRNdWKmquu0k7Oh031d9KhLJNG8/P2ioYR1LlPt+w5aH?=
 =?us-ascii?Q?qy2vqKB5vSijgDcL6zGuUOGnUkti7aJcs/H6fXigL/qCqUu6oEcHf0IbJYkY?=
 =?us-ascii?Q?OAW1hqLMBY6+f2Ldl/atEItzupccSZW8E12+naTaPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D1JHKBbL08FkUc9USCnWhgGoqHTXJ3WYiHQilF0ywlR+h3LqjgDDgN6Lme3+?=
 =?us-ascii?Q?/ln7RnpkLihc697bSng/FLBjugKin+08s28puLohf7GZrHYRCYnTy3q+bhr0?=
 =?us-ascii?Q?CD697kBCgSNpi3/qwNZg4OWB+o5Eowjz2x46nIju91K/T3h8mDS27gA5wdMC?=
 =?us-ascii?Q?W+/dUkACwxfEgWdj66iKcRTsJ5NJ/Wfjtimj/uHKQBhl3oaq+5tgYUD2Zw0y?=
 =?us-ascii?Q?Ux+w9P+pkj3wsUR/M6nWNqkAchD7QsZar2NpGhFndlss+aVoFX3uDnmpEgLn?=
 =?us-ascii?Q?YSIcYLzV+9R9mqfWmGn3L6naMyUxzfeJBR3bmDhuaTIf1ms9LAAgpiD8Nqug?=
 =?us-ascii?Q?L0TI3uXirIdXmmMllnI3/Yy/WAPtTz7rkCzWKJh72tCApWeKe8KEEyhDXn7w?=
 =?us-ascii?Q?+gLmUy2+aC/Eb2boNS44qO6KCBOTccXQqeAC9RJg/VzZwUggD8E+0S2GllpV?=
 =?us-ascii?Q?1OCIMco9hobec37IhXBaXdgb+Mr2ZSfTAyBAoXlvWMrOiNDtc70XKT4cFuPo?=
 =?us-ascii?Q?7p1LnH5+eN0K+IW+/k1hg8e1sWmZuqXUUI7SuyyrmHLkeAbKls9gvgrwhoXz?=
 =?us-ascii?Q?GKJk7ypV/grEDKOeDbrKV0S5s0DnN23geos5zRmUzlHUADuNqIuYGb9Rm0WY?=
 =?us-ascii?Q?uK/Dy538voCsvI9EaZV3i3q1iKTyHzf7R4xacRlqZp3WskXKAeciLFJIIyTS?=
 =?us-ascii?Q?2cZc+23ChiBSqsANq3b7N5/0aiXLLuHcAPWrfyt9gvntcKiDwPQ2DzYYgrqN?=
 =?us-ascii?Q?I4jS2TEpQTQinF4LVgfvKuqpl7kgBN9cdCiMI1LL1/ZltBtIQ/XKOfNy4mrc?=
 =?us-ascii?Q?AWZEViU6N3FFbYz/T/jwItupw2gkujksXm6vv62/vIVjlaInZLcL7kMw5PXd?=
 =?us-ascii?Q?7tYsjqPyhgUbMUQlGNOJknH8VDIHNt8E50PUWX5yEnUCUN28O1BXoSVB+ofM?=
 =?us-ascii?Q?hyPnrdzlVK4lJaVSc2Kg9HJ99hOMz9OIPZZfkA4R/8uQ8uX+cVMEHjUYu8nL?=
 =?us-ascii?Q?4jr43azD4CP4aTGXQvPPLXfsXt6q4l/ag6Iw4gu4tiuE5fgeywghZX2ioiYU?=
 =?us-ascii?Q?KLvT3V2GMjg2yC99nrZU0oN0NWmSlEieUFOjzEJ5Y80Z2Dw86h01FRZkbmHx?=
 =?us-ascii?Q?dQifIIcmna0o9eyvv6JXRVxVMIH2lagzgYCXXixiMt0OuIESXxnDh+CKAxzj?=
 =?us-ascii?Q?vXf7nifv5TRMP10wZuMAIE1C8KSUIaYS5haAfDeDzoynPT889d8/MdKIdRHd?=
 =?us-ascii?Q?N++YXmAJ1FmS1nyVDXibRC2t0SwBF9BSTm8DNT1PKHIX8LmpCLq0X1/9ijDE?=
 =?us-ascii?Q?E3JOslR/UFzM2PvtfiqNSvfcg85IrVMxzQP+xYWMSXTo7dIP5naPT6kv0H0r?=
 =?us-ascii?Q?IRzqIc/Drw1BEGyjqJB2MIPfC3qWHiezoxWTAPrrGAhqzAJcC7YGRVi9eDHD?=
 =?us-ascii?Q?umhAEO6p2ZodIyKDvc/VkxqRkxNkhNctIci8DyGhbdTUSM5sRKhTAAKZu9dF?=
 =?us-ascii?Q?IpmRE1caCnHaCO5QlDOpIPhYaahfi8UDnxGMNDp2Ij1hc3KK4Ynl3Mo4cTvR?=
 =?us-ascii?Q?FzzNdR7QRH67nBq4+NU2D8K3aDCUJvwRlxsbjIaMESDB8wO9s5HjJdAczEt/?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed15ac14-49f7-4e54-842a-08dce6d1211d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 13:08:26.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6neU301VaH0HhIrZTRkCg1FY16ZdMlSKnJWSph9n7sj3GitNrLii0ZOIRABTIpxDw10Br4rsYH4vORszDgzcDH1kl26EmfPKSxj6HKQado=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6987
X-OriginatorOrg: intel.com

On Mon, Oct 07, 2024 at 02:31:26PM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy receive path.
> 
> When AF_XDP zero-copy is enabled, the rx buffers are allocated from the
> xsk buff pool using igb_alloc_rx_buffers_zc().
> 
> Use xsk_pool_get_rx_frame_size() to set SRRCTL rx buf size when zero-copy
> is enabled.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Port to v6.10 and provide napi_id for xdp_rxq_info_reg(),
>        RCT, remove NETDEV_XDP_ACT_XSK_ZEROCOPY, update NTC handling,
>        move stats update and xdp finalize to common functions,
>        READ_ONCE() xsk_pool, likelyfy for XDP_REDIRECT case]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

Hi Kurt,

Sorry but still have comments :< see below.

> ---
>  drivers/net/ethernet/intel/igb/igb.h      |   8 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 132 +++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 296 +++++++++++++++++++++++++++++-
>  3 files changed, 398 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index c30d6f9708f8..ea3977b313fc 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -88,6 +88,7 @@ struct igb_adapter;
>  #define IGB_XDP_CONSUMED	BIT(0)
>  #define IGB_XDP_TX		BIT(1)
>  #define IGB_XDP_REDIR		BIT(2)
> +#define IGB_XDP_EXIT		BIT(3)
>  
>  struct vf_data_storage {
>  	unsigned char vf_mac_addresses[ETH_ALEN];
> @@ -740,6 +741,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring);
>  void igb_clean_rx_ring(struct igb_ring *rx_ring);
>  void igb_configure_tx_ring(struct igb_adapter *, struct igb_ring *);
>  void igb_configure_rx_ring(struct igb_adapter *, struct igb_ring *);
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status);
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes);
>  void igb_setup_tctl(struct igb_adapter *);
>  void igb_setup_rctl(struct igb_adapter *);
>  void igb_setup_srrctl(struct igb_adapter *, struct igb_ring *);
> @@ -850,6 +854,10 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		       struct xsk_buff_pool *pool,
>  		       u16 qid);
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count);
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index bdba5c5861be..449ee794b3c9 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -472,12 +472,17 @@ static void igb_dump(struct igb_adapter *adapter)
>  
>  		for (i = 0; i < rx_ring->count; i++) {
>  			const char *next_desc;
> -			struct igb_rx_buffer *buffer_info;
> -			buffer_info = &rx_ring->rx_buffer_info[i];
> +			dma_addr_t dma = (dma_addr_t)0;
> +			struct igb_rx_buffer *buffer_info = NULL;
>  			rx_desc = IGB_RX_DESC(rx_ring, i);
>  			u0 = (struct my_u0 *)rx_desc;
>  			staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
>  
> +			if (!rx_ring->xsk_pool) {
> +				buffer_info = &rx_ring->rx_buffer_info[i];
> +				dma = buffer_info->dma;
> +			}
> +
>  			if (i == rx_ring->next_to_use)
>  				next_desc = " NTU";
>  			else if (i == rx_ring->next_to_clean)
> @@ -497,11 +502,11 @@ static void igb_dump(struct igb_adapter *adapter)
>  					"R  ", i,
>  					le64_to_cpu(u0->a),
>  					le64_to_cpu(u0->b),
> -					(u64)buffer_info->dma,
> +					(u64)dma,
>  					next_desc);
>  
>  				if (netif_msg_pktdata(adapter) &&
> -				    buffer_info->dma && buffer_info->page) {
> +				    buffer_info && dma && buffer_info->page) {
>  					print_hex_dump(KERN_INFO, "",
>  					  DUMP_PREFIX_ADDRESS,
>  					  16, 1,
> @@ -1983,7 +1988,10 @@ static void igb_configure(struct igb_adapter *adapter)
>  	 */
>  	for (i = 0; i < adapter->num_rx_queues; i++) {
>  		struct igb_ring *ring = adapter->rx_ring[i];
> -		igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
> +		if (ring->xsk_pool)
> +			igb_alloc_rx_buffers_zc(ring, igb_desc_unused(ring));
> +		else
> +			igb_alloc_rx_buffers(ring, igb_desc_unused(ring));
>  	}
>  }
>  
> @@ -4405,7 +4413,8 @@ int igb_setup_rx_resources(struct igb_ring *rx_ring)
>  	if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
>  		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
>  	res = xdp_rxq_info_reg(&rx_ring->xdp_rxq, rx_ring->netdev,
> -			       rx_ring->queue_index, 0);
> +			       rx_ring->queue_index,
> +			       rx_ring->q_vector->napi.napi_id);
>  	if (res < 0) {
>  		dev_err(dev, "Failed to register xdp_rxq index %u\n",
>  			rx_ring->queue_index);
> @@ -4701,12 +4710,17 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	struct e1000_hw *hw = &adapter->hw;
>  	int reg_idx = ring->reg_idx;
>  	u32 srrctl = 0;
> +	u32 buf_size;
>  
> -	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> -	if (ring_uses_large_buffer(ring))
> -		srrctl |= IGB_RXBUFFER_3072 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +	if (ring->xsk_pool)
> +		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> +	else if (ring_uses_large_buffer(ring))
> +		buf_size = IGB_RXBUFFER_3072;
>  	else
> -		srrctl |= IGB_RXBUFFER_2048 >> E1000_SRRCTL_BSIZEPKT_SHIFT;
> +		buf_size = IGB_RXBUFFER_2048;
> +
> +	srrctl = IGB_RX_HDR_LEN << E1000_SRRCTL_BSIZEHDRSIZE_SHIFT;
> +	srrctl |= buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT;
>  	srrctl |= E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
>  	if (hw->mac.type >= e1000_82580)
>  		srrctl |= E1000_SRRCTL_TIMESTAMP;
> @@ -4738,9 +4752,17 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	u32 rxdctl = 0;
>  
>  	xdp_rxq_info_unreg_mem_model(&ring->xdp_rxq);
> -	WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> -					   MEM_TYPE_PAGE_SHARED, NULL));
>  	WRITE_ONCE(ring->xsk_pool, igb_xsk_pool(adapter, ring));
> +	if (ring->xsk_pool) {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_XSK_BUFF_POOL,
> +						   NULL));
> +		xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
> +	} else {
> +		WARN_ON(xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
> +						   MEM_TYPE_PAGE_SHARED,
> +						   NULL));
> +	}
>  
>  	/* disable the queue */
>  	wr32(E1000_RXDCTL(reg_idx), 0);
> @@ -4767,9 +4789,12 @@ void igb_configure_rx_ring(struct igb_adapter *adapter,
>  	rxdctl |= IGB_RX_HTHRESH << 8;
>  	rxdctl |= IGB_RX_WTHRESH << 16;
>  
> -	/* initialize rx_buffer_info */
> -	memset(ring->rx_buffer_info, 0,
> -	       sizeof(struct igb_rx_buffer) * ring->count);
> +	if (ring->xsk_pool)
> +		memset(ring->rx_buffer_info_zc, 0,
> +		       sizeof(*ring->rx_buffer_info_zc) * ring->count);
> +	else
> +		memset(ring->rx_buffer_info, 0,
> +		       sizeof(*ring->rx_buffer_info) * ring->count);
>  
>  	/* initialize Rx descriptor 0 */
>  	rx_desc = IGB_RX_DESC(ring, 0);
> @@ -4957,8 +4982,13 @@ void igb_free_rx_resources(struct igb_ring *rx_ring)
>  
>  	rx_ring->xdp_prog = NULL;
>  	xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
> -	vfree(rx_ring->rx_buffer_info);
> -	rx_ring->rx_buffer_info = NULL;
> +	if (rx_ring->xsk_pool) {
> +		vfree(rx_ring->rx_buffer_info_zc);
> +		rx_ring->rx_buffer_info_zc = NULL;
> +	} else {
> +		vfree(rx_ring->rx_buffer_info);
> +		rx_ring->rx_buffer_info = NULL;
> +	}
>  
>  	/* if not set, then don't free */
>  	if (!rx_ring->desc)
> @@ -4996,6 +5026,11 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  	dev_kfree_skb(rx_ring->skb);
>  	rx_ring->skb = NULL;
>  
> +	if (rx_ring->xsk_pool) {
> +		igb_clean_rx_ring_zc(rx_ring);
> +		goto skip_for_xsk;
> +	}
> +
>  	/* Free all the Rx ring sk_buffs */
>  	while (i != rx_ring->next_to_alloc) {
>  		struct igb_rx_buffer *buffer_info = &rx_ring->rx_buffer_info[i];
> @@ -5023,6 +5058,7 @@ void igb_clean_rx_ring(struct igb_ring *rx_ring)
>  			i = 0;
>  	}
>  
> +skip_for_xsk:
>  	rx_ring->next_to_alloc = 0;
>  	rx_ring->next_to_clean = 0;
>  	rx_ring->next_to_use = 0;
> @@ -8177,6 +8213,7 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  	struct igb_q_vector *q_vector = container_of(napi,
>  						     struct igb_q_vector,
>  						     napi);
> +	struct xsk_buff_pool *xsk_pool;
>  	bool clean_complete = true;
>  	int work_done = 0;
>  
> @@ -8188,7 +8225,12 @@ static int igb_poll(struct napi_struct *napi, int budget)
>  		clean_complete = igb_clean_tx_irq(q_vector, budget);
>  
>  	if (q_vector->rx.ring) {
> -		int cleaned = igb_clean_rx_irq(q_vector, budget);
> +		int cleaned;
> +
> +		xsk_pool = READ_ONCE(q_vector->rx.ring->xsk_pool);
> +		cleaned = xsk_pool ?
> +			igb_clean_rx_irq_zc(q_vector, xsk_pool, budget) :
> +			igb_clean_rx_irq(q_vector, budget);
>  
>  		work_done += cleaned;
>  		if (cleaned >= budget)
> @@ -8852,6 +8894,38 @@ static void igb_put_rx_buffer(struct igb_ring *rx_ring,
>  	rx_buffer->page = NULL;
>  }
>  
> +void igb_finalize_xdp(struct igb_adapter *adapter, unsigned int status)
> +{
> +	int cpu = smp_processor_id();
> +	struct netdev_queue *nq;
> +
> +	if (status & IGB_XDP_REDIR)
> +		xdp_do_flush();
> +
> +	if (status & IGB_XDP_TX) {
> +		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		igb_xdp_ring_update_tail(tx_ring);
> +		__netif_tx_unlock(nq);
> +	}
> +}
> +
> +void igb_update_rx_stats(struct igb_q_vector *q_vector, unsigned int packets,
> +			 unsigned int bytes)
> +{
> +	struct igb_ring *ring = q_vector->rx.ring;
> +
> +	u64_stats_update_begin(&ring->rx_syncp);
> +	ring->rx_stats.packets += packets;
> +	ring->rx_stats.bytes += bytes;
> +	u64_stats_update_end(&ring->rx_syncp);
> +
> +	q_vector->rx.total_packets += packets;
> +	q_vector->rx.total_bytes += bytes;
> +}
> +
>  static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  {
>  	unsigned int total_bytes = 0, total_packets = 0;
> @@ -8859,9 +8933,7 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	struct igb_ring *rx_ring = q_vector->rx.ring;
>  	u16 cleaned_count = igb_desc_unused(rx_ring);
>  	struct sk_buff *skb = rx_ring->skb;
> -	int cpu = smp_processor_id();
>  	unsigned int xdp_xmit = 0;
> -	struct netdev_queue *nq;
>  	struct xdp_buff xdp;
>  	u32 frame_sz = 0;
>  	int rx_buf_pgcnt;
> @@ -8983,24 +9055,10 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
>  	/* place incomplete frames back on ring for completion */
>  	rx_ring->skb = skb;
>  
> -	if (xdp_xmit & IGB_XDP_REDIR)
> -		xdp_do_flush();
> -
> -	if (xdp_xmit & IGB_XDP_TX) {
> -		struct igb_ring *tx_ring = igb_xdp_tx_queue_mapping(adapter);
> -
> -		nq = txring_txq(tx_ring);
> -		__netif_tx_lock(nq, cpu);
> -		igb_xdp_ring_update_tail(tx_ring);
> -		__netif_tx_unlock(nq);
> -	}
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);

Nit: given you would be sending next revision, IMHO this is a candidate
for a separate patch. Not a big deal but would reduce the noise in this
one.

>  
> -	u64_stats_update_begin(&rx_ring->rx_syncp);
> -	rx_ring->rx_stats.packets += total_packets;
> -	rx_ring->rx_stats.bytes += total_bytes;
> -	u64_stats_update_end(&rx_ring->rx_syncp);
> -	q_vector->rx.total_packets += total_packets;
> -	q_vector->rx.total_bytes += total_bytes;
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);

This also.

>  
>  	if (cleaned_count)
>  		igb_alloc_rx_buffers(rx_ring, cleaned_count);
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 7b632be3e7e3..9fd094a799fa 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -70,7 +70,10 @@ static void igb_txrx_ring_enable(struct igb_adapter *adapter, u16 qid)
>  	 * at least 1 descriptor unused to make sure
>  	 * next_to_use != next_to_clean
>  	 */
> -	igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
> +	if (rx_ring->xsk_pool)
> +		igb_alloc_rx_buffers_zc(rx_ring, igb_desc_unused(rx_ring));
> +	else
> +		igb_alloc_rx_buffers(rx_ring, igb_desc_unused(rx_ring));
>  
>  	/* Rx/Tx share the same napi context. */
>  	napi_enable(&rx_ring->q_vector->napi);
> @@ -169,6 +172,297 @@ int igb_xsk_pool_setup(struct igb_adapter *adapter,
>  		igb_xsk_pool_disable(adapter, qid);
>  }
>  
> +static u16 igb_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
> +			     union e1000_adv_rx_desc *rx_desc, u16 count)
> +{
> +	dma_addr_t dma;
> +	u16 buffs;
> +	int i;
> +
> +	/* nothing to do */
> +	if (!count)
> +		return 0;
> +
> +	buffs = xsk_buff_alloc_batch(pool, xdp, count);
> +	for (i = 0; i < buffs; i++) {
> +		dma = xsk_buff_xdp_get_dma(*xdp);
> +		rx_desc->read.pkt_addr = cpu_to_le64(dma);
> +		rx_desc->wb.upper.length = 0;
> +
> +		rx_desc++;
> +		xdp++;
> +	}
> +
> +	return buffs;
> +}
> +
> +bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring, u16 count)
> +{
> +	u32 nb_buffs_extra = 0, nb_buffs = 0;
> +	union e1000_adv_rx_desc *rx_desc;
> +	u16 ntu = rx_ring->next_to_use;
> +	u16 total_count = count;
> +	struct xdp_buff **xdp;
> +
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	xdp = &rx_ring->rx_buffer_info_zc[ntu];
> +
> +	if (ntu + count >= rx_ring->count) {
> +		nb_buffs_extra = igb_fill_rx_descs(rx_ring->xsk_pool, xdp,
> +						   rx_desc,
> +						   rx_ring->count - ntu);

Ehh wanted to ack this finally, but I believe that here you need to work
on the pool pointer that was READ_ONCE() in igb_poll() in hot path and
in igb_configure() pass rx_ring->xsk_pool as an argument.

I did the same scheme for ice FWIW.

> +		if (nb_buffs_extra != rx_ring->count - ntu) {
> +			ntu += nb_buffs_extra;
> +			goto exit;
> +		}
> +		rx_desc = IGB_RX_DESC(rx_ring, 0);
> +		xdp = rx_ring->rx_buffer_info_zc;
> +		ntu = 0;
> +		count -= nb_buffs_extra;
> +	}
> +
> +	nb_buffs = igb_fill_rx_descs(rx_ring->xsk_pool, xdp, rx_desc, count);
> +	ntu += nb_buffs;
> +	if (ntu == rx_ring->count)
> +		ntu = 0;
> +
> +	/* clear the length for the next_to_use descriptor */
> +	rx_desc = IGB_RX_DESC(rx_ring, ntu);
> +	rx_desc->wb.upper.length = 0;
> +
> +exit:
> +	if (rx_ring->next_to_use != ntu) {
> +		rx_ring->next_to_use = ntu;
> +
> +		/* Force memory writes to complete before letting h/w
> +		 * know there are new descriptors to fetch.  (Only
> +		 * applicable for weak-ordered memory model archs,
> +		 * such as IA-64).
> +		 */
> +		wmb();
> +		writel(ntu, rx_ring->tail);
> +	}
> +
> +	return total_count == (nb_buffs + nb_buffs_extra);
> +}
> +
> +void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
> +{
> +	u16 ntc = rx_ring->next_to_clean;
> +	u16 ntu = rx_ring->next_to_use;
> +
> +	while (ntc != ntu) {
> +		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc >= rx_ring->count)
> +			ntc = 0;
> +	}
> +}
> +
> +static struct sk_buff *igb_construct_skb_zc(struct igb_ring *rx_ring,
> +					    struct xdp_buff *xdp,
> +					    ktime_t timestamp)
> +{
> +	unsigned int totalsize = xdp->data_end - xdp->data_meta;
> +	unsigned int metasize = xdp->data - xdp->data_meta;
> +	struct sk_buff *skb;
> +
> +	net_prefetch(xdp->data_meta);
> +
> +	/* allocate a skb to store the frags */
> +	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	if (timestamp)
> +		skb_hwtstamps(skb)->hwtstamp = timestamp;
> +
> +	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
> +	       ALIGN(totalsize, sizeof(long)));
> +
> +	if (metasize) {
> +		skb_metadata_set(skb, metasize);
> +		__skb_pull(skb, metasize);
> +	}
> +
> +	return skb;
> +}
> +
> +static struct sk_buff *igb_run_xdp_zc(struct igb_adapter *adapter,
> +				      struct igb_ring *rx_ring,
> +				      struct xdp_buff *xdp,
> +				      struct xsk_buff_pool *xsk_pool,
> +				      struct bpf_prog *xdp_prog)
> +{
> +	int err, result = IGB_XDP_PASS;
> +	u32 act;
> +
> +	prefetchw(xdp->data_hard_start); /* xdp_frame write */
> +
> +	act = bpf_prog_run_xdp(xdp_prog, xdp);
> +
> +	if (likely(act == XDP_REDIRECT)) {
> +		err = xdp_do_redirect(adapter->netdev, xdp, xdp_prog);
> +		if (!err) {
> +			result = IGB_XDP_REDIR;
> +			goto xdp_out;
> +		}
> +
> +		if (xsk_uses_need_wakeup(xsk_pool) &&
> +		    err == -ENOBUFS)
> +			result = IGB_XDP_EXIT;
> +		else
> +			result = IGB_XDP_CONSUMED;
> +		goto out_failure;
> +	}
> +
> +	switch (act) {
> +	case XDP_PASS:
> +		break;
> +	case XDP_TX:
> +		result = igb_xdp_xmit_back(adapter, xdp);
> +		if (result == IGB_XDP_CONSUMED)
> +			goto out_failure;
> +		break;
> +	default:
> +		bpf_warn_invalid_xdp_action(adapter->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_ABORTED:
> +out_failure:
> +		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
> +		fallthrough;
> +	case XDP_DROP:
> +		result = IGB_XDP_CONSUMED;
> +		break;
> +	}
> +xdp_out:
> +	return ERR_PTR(-result);
> +}
> +
> +int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
> +			struct xsk_buff_pool *xsk_pool, const int budget)
> +{
> +	struct igb_adapter *adapter = q_vector->adapter;
> +	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_ring *rx_ring = q_vector->rx.ring;
> +	u32 ntc = rx_ring->next_to_clean;
> +	struct bpf_prog *xdp_prog;
> +	unsigned int xdp_xmit = 0;
> +	bool failure = false;
> +	u16 entries_to_alloc;
> +	struct sk_buff *skb;
> +
> +	/* xdp_prog cannot be NULL in the ZC path */
> +	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
> +
> +	while (likely(total_packets < budget)) {
> +		union e1000_adv_rx_desc *rx_desc;
> +		ktime_t timestamp = 0;
> +		struct xdp_buff *xdp;
> +		unsigned int size;
> +
> +		rx_desc = IGB_RX_DESC(rx_ring, ntc);
> +		size = le16_to_cpu(rx_desc->wb.upper.length);
> +		if (!size)
> +			break;
> +
> +		/* This memory barrier is needed to keep us from reading
> +		 * any other fields out of the rx_desc until we know the
> +		 * descriptor has been written back
> +		 */
> +		dma_rmb();
> +
> +		xdp = rx_ring->rx_buffer_info_zc[ntc];
> +		xsk_buff_set_size(xdp, size);
> +		xsk_buff_dma_sync_for_cpu(xdp);
> +
> +		/* pull rx packet timestamp if available and valid */
> +		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
> +			int ts_hdr_len;
> +
> +			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
> +							 xdp->data,
> +							 &timestamp);
> +
> +			xdp->data += ts_hdr_len;
> +			xdp->data_meta += ts_hdr_len;
> +			size -= ts_hdr_len;
> +		}
> +
> +		skb = igb_run_xdp_zc(adapter, rx_ring, xdp, xsk_pool, xdp_prog);
> +
> +		if (IS_ERR(skb)) {
> +			unsigned int xdp_res = -PTR_ERR(skb);
> +
> +			if (likely(xdp_res & (IGB_XDP_TX | IGB_XDP_REDIR))) {
> +				xdp_xmit |= xdp_res;
> +			} else if (xdp_res == IGB_XDP_EXIT) {
> +				failure = true;
> +				break;
> +			} else if (xdp_res == IGB_XDP_CONSUMED) {
> +				xsk_buff_free(xdp);
> +			}
> +
> +			total_packets++;
> +			total_bytes += size;
> +			ntc++;
> +			if (ntc == rx_ring->count)
> +				ntc = 0;
> +			continue;
> +		}
> +
> +		skb = igb_construct_skb_zc(rx_ring, xdp, timestamp);
> +
> +		/* exit if we failed to retrieve a buffer */
> +		if (!skb) {
> +			rx_ring->rx_stats.alloc_failed++;
> +			break;
> +		}
> +
> +		xsk_buff_free(xdp);
> +		ntc++;
> +		if (ntc == rx_ring->count)
> +			ntc = 0;
> +
> +		if (eth_skb_pad(skb))
> +			continue;
> +
> +		/* probably a little skewed due to removing CRC */
> +		total_bytes += skb->len;
> +
> +		/* populate checksum, timestamp, VLAN, and protocol */
> +		igb_process_skb_fields(rx_ring, rx_desc, skb);
> +
> +		napi_gro_receive(&q_vector->napi, skb);
> +
> +		/* update budget accounting */
> +		total_packets++;
> +	}
> +
> +	rx_ring->next_to_clean = ntc;
> +
> +	if (xdp_xmit)
> +		igb_finalize_xdp(adapter, xdp_xmit);
> +
> +	igb_update_rx_stats(q_vector, total_packets, total_bytes);
> +
> +	entries_to_alloc = igb_desc_unused(rx_ring);
> +	if (entries_to_alloc >= IGB_RX_BUFFER_WRITE)
> +		failure |= !igb_alloc_rx_buffers_zc(rx_ring, entries_to_alloc);
> +
> +	if (xsk_uses_need_wakeup(xsk_pool)) {
> +		if (failure || rx_ring->next_to_clean == rx_ring->next_to_use)
> +			xsk_set_rx_need_wakeup(xsk_pool);
> +		else
> +			xsk_clear_rx_need_wakeup(xsk_pool);
> +
> +		return (int)total_packets;
> +	}
> +	return failure ? budget : (int)total_packets;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> 
> -- 
> 2.39.5
> 
> 

