Return-Path: <bpf+bounces-42396-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A074E9A3AE0
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 12:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A2C1C21788
	for <lists+bpf@lfdr.de>; Fri, 18 Oct 2024 10:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D622010FE;
	Fri, 18 Oct 2024 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DxzkkRug"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375F201030;
	Fri, 18 Oct 2024 10:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729246035; cv=fail; b=gakgg7KFZc6IqF4922GG3geETd6Oz7XmI7GUu4nWK2Oq4CsSYiB8XAtufczhDmO/8Ajs88luSh4Xc+SX5hQMJTHGd9yMY72QaOUT4docAkNMOBUL5r1p/j9G3j8xBCiPWnptLZfdgWS/DAF02h95gr1BH8U6mO+YJJWSxc3DTpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729246035; c=relaxed/simple;
	bh=336I10POpUa2MbOH5Y+64j1EHfWaAqpaH8gd0xqjv7U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AG+khRRdiZw7irpJbLI/87AYL7XJTK03dQIA0+VubyQYNJJdZO7zXlX2EpWwWnuv+MC5Uga9LZ4eciGRR9x8SKHiaSHJKEJ34xQhd77jcOL7kR+njFPyGNvf3ge3aYAWorw+ssByF3rAwWjIdJl5PPt8Didtd9vaI6NsUiz+Oig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DxzkkRug; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729246034; x=1760782034;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=336I10POpUa2MbOH5Y+64j1EHfWaAqpaH8gd0xqjv7U=;
  b=DxzkkRugba+Q6BCKQem6RP+/4W+Z5HN0zENTgddwTCNN6ryPwbYcVR6x
   ZrXirr0Ee4LN4xQRp3/d2az55nqs0yAhbYL/AhID/vvgIworpUzXni8jV
   LTrRVDTDJ3XITQywLGKap98uzxvD1JFMtrhGgnBSPSLpJLNv/TOICBk7P
   QMMeG9WUSzfuDGSPYRN0wcyoyJedTNqLlQ54EJxuAq1yxw9ccFPrK8mWu
   2zEqW6VZFuH4zP/EM/pPX9tue4+nU5fGQax87pKtcz4RsQzB3ehJigLBy
   O+Pm/sBE/6mriDH+G4ks4WI7e3fDpugIi6SyU03ptq6p2eYPUR94gF+6K
   Q==;
X-CSE-ConnectionGUID: QJgggOfqTomomwWncKRw1w==
X-CSE-MsgGUID: 9gccEAHcS6ukR4WokHQqdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28561127"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28561127"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 03:07:13 -0700
X-CSE-ConnectionGUID: DQFfupEpTnK2+t7JKtxJTQ==
X-CSE-MsgGUID: cjDKmu4bQMmycDyPx5eSXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,213,1725346800"; 
   d="scan'208";a="79247676"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Oct 2024 03:07:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 03:07:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 18 Oct 2024 03:07:11 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 18 Oct 2024 03:07:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 03:07:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyRZggjXZpONlV85xLgf54E5JC6DknEFXAu4j4M8B0wpydjk+WUh+YNOS1NYM/mOc2n+pPbBNMs6im05LzvYP7q0Sa6AFa71SNYAsOgxbYQdlh3wVt7doxaeiAoEGtYEnMsS+cXQxKo76KI5Nh8POIC1bjBM0J7HmcJ1tV0F0zE5a0BafBrog5jlkWnu1BaxwpC13TPSehpyoZmtZCAfIaFGBFMCBkSj0mywtW0NmDpvcpt5YYUpr6nx1dP6RKa1yyqEksnPFP7kKb5ggIztyhhAIc9YLjBL+tKEYKks5ll7eDmdrBNZBCThQlCHBEwtjQvCzJ5prGnNPd07quegXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uZV4N5Tnpg2A4BAd4LvERSapn+GsYloqBqz2d06iH00=;
 b=CGREd7xxnEtB/44b4URDb2lmuQ4tznHtBC69R2aEvR+7igVzyYnLux/ke0YxHz8kZKMiYj6T0WFpNTkJCoQBGpeKuaRefZLrIEAtkcVhIoUwpyQd1gF3x4MqRET/nB7Q9qo7cslbMhX88OtawJSfymBXmrKw1EkIEMlfmU2LHLDvMGRw80jhvnaxKzz5ww7miyf2GzJEj7svtXgu5gb6YUdJYFW0njqqvVW6t/KDqF/EoDjQ4KZLkLaIRf0ZqApfPhKfw32DtsJidurgTO64EPMrDi5gpLLjY/nIdWgMGuzjcTHfqTl212Fn26RnkUjpK3jhWr5kbpfN1tjHGkutPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB7682.namprd11.prod.outlook.com (2603:10b6:8:dc::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.18; Fri, 18 Oct 2024 10:07:09 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Fri, 18 Oct 2024
 10:07:08 +0000
Date: Fri, 18 Oct 2024 12:07:00 +0200
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
Subject: Re: [PATCH iwl-next v9 6/6] igb: Add AF_XDP zero-copy Tx support
Message-ID: <ZxIzRJlXA91Bapwt@boxer>
References: <20241018-b4-igb_zero_copy-v9-0-da139d78d796@linutronix.de>
 <20241018-b4-igb_zero_copy-v9-6-da139d78d796@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241018-b4-igb_zero_copy-v9-6-da139d78d796@linutronix.de>
X-ClientProxiedBy: ZR0P278CA0217.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::15) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB7682:EE_
X-MS-Office365-Filtering-Correlation-Id: d6e274b7-7e5c-470a-2ca2-08dcef5ca06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hFXuPWxj4CzC1A5YdnFYz+ROXOQ8s/+RAaZEAbrCumNuEni3GGuCiuw50x3y?=
 =?us-ascii?Q?KGVAhMgeVf22w2yYhN2bxaixINzpdgbBHE5SVuRgQNtRVnQx1D60Ja5SNt9y?=
 =?us-ascii?Q?PjdXsUTv1Le8vaj5O8U40JVbhImOVHYeVNiPruDcge4Gxj4jJlQ/XDm3rJd3?=
 =?us-ascii?Q?IETfRDobLuvJtwdDw0gmQttBttkkGZlOrX7ZgmuTDyoqTWbYmFRdf5NataPB?=
 =?us-ascii?Q?Bjf2OeRhbB6hQDRiX+kN3/fH6eBwJXClkeR5ziYFHI1M2mhm6TLEKlBOJkED?=
 =?us-ascii?Q?5ESRIHW79QxOegGWXE1L0dJWoYDA3yhUfw7aagYB62v7/nz236aShsYjXmwx?=
 =?us-ascii?Q?jiVao1RHMga9VK9lBSoO99K2p7n5iDh7cYMlyxR2zGuZ6XQRYr/oKE0TDUWa?=
 =?us-ascii?Q?l8Qah3fm6DIGkUE92Fz/1J9LJpIRcbEZ0Eb2L6UHFDD2C2gZpubdgtWzp8g5?=
 =?us-ascii?Q?tx34Sq1ir8GXvBlkA7ljJdtGnm9lPYs7GK6wAR6gfh7Yavn9su6mS3ts71gA?=
 =?us-ascii?Q?sQeFFTEB64BCmaicj/TuZIOUN3XuelrJfFZtiRjk20dpIq+Ph+9Ne3EshK8g?=
 =?us-ascii?Q?3XtfqXBwc9HrVnM0600kUNdeGsXRr0jN6ugHUH5LxAxL0BxxpT8PL5/PECrU?=
 =?us-ascii?Q?fSwr/aI7gOqe91DSKM9oM5fmX6MMR0Z/IlONr3Q/8mEqX/GAyGkZ2Q3wVafm?=
 =?us-ascii?Q?6fdSeU784YjqmGGizK4qshFA7TDSrSClM9QKfqaVfmEXqDguexWPtkvxDNXE?=
 =?us-ascii?Q?gAPFSY3FzxGzlXWOJYWUIyU3qsylI1wH9ipF4x1G2OMn9T72qab6N0wR7xJ0?=
 =?us-ascii?Q?JNCrtXXD/lLhkMrGUyQrAOKl7LZnllGYsO50Hrgco+Aa+bEHhbXfDUyNIuKA?=
 =?us-ascii?Q?PEqll0Sv39PHqhV5SYOf436xbXTmgxjacg1GjlIFosn8O0S8cIoGbiFewyyN?=
 =?us-ascii?Q?TX8KAr0sXGqxRmDiAyyCXoB+cct+Ew0TkT7cLTxG12Zm/tjAQyMmW8ncu3jy?=
 =?us-ascii?Q?d6KzcdsuhCmcqY4nOk4Fl7tIh62K/2rS8TK3bKJd2W9FRgWjGllaRPn+9hAK?=
 =?us-ascii?Q?ZmrIsviQ8BQFNsluIcw5OH6CcYl+SesEQPvLLqVWUu3dP+FmF64r+FnPrO1v?=
 =?us-ascii?Q?KQVa68oAbEGKMBEuYEX5/SiLOGreTP+ceb8sTmmEArJSEmaGC/z9tQXxHRHu?=
 =?us-ascii?Q?yIt8CYNbknkasez539vAt2ADZFmMHZWrgdoM7WkX7fKJp5kreOU6Gq1ac1lj?=
 =?us-ascii?Q?GuOY8dCQgU2ibq164j8aBTQvfhrxKp5jaicuaWv0t/JmsCZf9lqi9bW91JCF?=
 =?us-ascii?Q?aenDcngqpIT/t0vW4x78w+qd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MhZONvtYIXXpHogYpILtevb3uJJKOJ7dx4m4ULiu9D99+jRAjdNLHsRwf6qz?=
 =?us-ascii?Q?SmUJMWOHhJBKEwLjz1w9Bl6fbb+yaos/TvnrHqh8BsXiG0PtyTuHcibyhXaJ?=
 =?us-ascii?Q?y3u6WqfX/wPhT77eFwKeyOYs2ehz+bpl4ft6TvFssoLp4NUHTMSxOU0/sB79?=
 =?us-ascii?Q?WtHlkR0eQITGO7nUKRB8qCxpS+nCXZ3xDyLALvY3WnrQDJtKJze0EUwMur7N?=
 =?us-ascii?Q?r3jupdyYW6s0/Qw05DVfupdAfRFCbMJlTu1RJlpYtGbyNsM2qOHMsjzMgadz?=
 =?us-ascii?Q?XLYQxsy3Iv5QkhqeCKzsZCHq9/yZDFKCzogoe1S3hw7UHyIPxVVZ34cOqcmE?=
 =?us-ascii?Q?IZQWen0t/vKoMEaH9niyrkGvz4qXeVIyt+ch1ZIjiUxLrMYWkGCVfgESoSZN?=
 =?us-ascii?Q?2HPk0UVDtW5InMzsZQlbHMMBQKQm9s9hMIIJPcVMhPKjQJu41Oa7snn8rTmD?=
 =?us-ascii?Q?/p5W2FLJjd+9M9Ie4hOaOsTO+tRczTW0yZnWQ7fEfJ9zyPE1SYKkzjnw/zYq?=
 =?us-ascii?Q?z+QVsZr0tQa0NQ18hseLyVB9ONOAYJO9OchMmGadYFS1v0RE1ILEO5XmmpNj?=
 =?us-ascii?Q?wL+Z9O1p/pshhmEcKZaCkeVrdmGxINuJ1KcvPawNb+5XqVbU45YoQjN0lx1K?=
 =?us-ascii?Q?gMp+bue8v9tlJDSFGYUDE+U4PWTYhdo/DNF+HKYm294/dn/h33nE3so5zrHA?=
 =?us-ascii?Q?Kwb70cu3Od2nL6SZiqlSZ7YE88a8mh+QljMU/FQbYt7y2bGvVtphukqwxK2k?=
 =?us-ascii?Q?YmpoaYzunEO4guUOk3+eOTJgXRoRvx0U+WJbi92KTZhNtpQ2TcCv2Bi3ci+l?=
 =?us-ascii?Q?AKJSV/6IQkr7shGMoF+Scvbaq720PKYvgZD9CtA43LuyGDCUXGJSUSiaGcOY?=
 =?us-ascii?Q?RkXR2ch8u3WFO9TbcLewxGF2kMcCbQd8L4wep2ZtxqfZtp3yeUP5QAW3U5EI?=
 =?us-ascii?Q?fPgYYKTKxYLAwwR84a3j1RLMgIv8mMsvau2EmTK2lIdSfzOpVWxh0BBhm019?=
 =?us-ascii?Q?olwcdHCGKnwvSdmB1bia+CxaovKeCVlfQG/MOF4I90tCek/l6TZEYOVHYWUw?=
 =?us-ascii?Q?T+FmNzkY2jr2M2WsNwi+3hpYJ3y868TmuuEdkZJfsT7/Ey7yXBT/ORX7Y2m/?=
 =?us-ascii?Q?DMgNhtiXbS/N8lTi3mU/LshUq8FrsT0Ir7M7sQGsxmhf076z3eYJsV+5l8pt?=
 =?us-ascii?Q?c2BKmLI1Amdeswox6w+n5KAmndEUIl+kuaDjaKa6lXcUexgSWgrtkStPAsd0?=
 =?us-ascii?Q?Zry8OUm7rTMPiJxtAkEq9DoWiOxSQfOLozCWOmfjwAqok3KMev78FNgUyT+k?=
 =?us-ascii?Q?qctge6RAOxEx60tncEVkwsxGxsbcILVsvs/Ouw6r8sWLltpljKNVg845q/LF?=
 =?us-ascii?Q?4IfYbQOr8TUzV+sjz7jArCvKjFM3YJngjxhN0qh4nomRzal6AKyFrz/gK7q0?=
 =?us-ascii?Q?UCKhu2iuFx5lROqmJGczqqXLUpO28kfKgBm7yJlvY8qHAdYRyrW/oE8HCqkw?=
 =?us-ascii?Q?dtESJd0zGSwpnOg+4leBqahXLpqwcSLW3G7i7mrGV1Went6NMAOGL94eNiws?=
 =?us-ascii?Q?CLQPiBH0/isoAG8eXHq+WMU+94M/t0YmzW5zxy7jQNlBaPo2RiOaPxcDVP49?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e274b7-7e5c-470a-2ca2-08dcef5ca06e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 10:07:08.8543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5DrMrUj0aWU8Md+aBOgtuVpk4c6odQJ94Tk4Ln1aUGrNWiGOdpFw/Yp03ZnfYk6lEhieJx6cJU9E4m47W8n97JLVbgtGCVVm0DNUBypRmK8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7682
X-OriginatorOrg: intel.com

On Fri, Oct 18, 2024 at 10:40:02AM +0200, Kurt Kanzenbach wrote:
> From: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> 
> Add support for AF_XDP zero-copy transmit path.
> 
> A new TX buffer type IGB_TYPE_XSK is introduced to indicate that the Tx
> frame was allocated from the xsk buff pool, so igb_clean_tx_ring() and
> igb_clean_tx_irq() can clean the buffers correctly based on type.
> 
> igb_xmit_zc() performs the actual packet transmit when AF_XDP zero-copy is
> enabled. We share the TX ring between slow path, XDP and AF_XDP
> zero-copy, so we use the netdev queue lock to ensure mutual exclusion.
> 
> Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@est.tech>
> [Kurt: Set olinfo_status in igb_xmit_zc() so that frames are transmitted,
>        Use READ_ONCE() for xsk_pool and check Tx disabled and carrier in
>        igb_xmit_zc(), Add FIXME for RS bit]
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

I didn't give you my tag on this patch in previous revision, but from what
I can see now it can stay here:)

Finally, thanks!

> ---
>  drivers/net/ethernet/intel/igb/igb.h      |  2 +
>  drivers/net/ethernet/intel/igb/igb_main.c | 61 +++++++++++++++++++++++++-----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 63 +++++++++++++++++++++++++++++++
>  3 files changed, 116 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
> index e4a85867aa18..02f340280d20 100644
> --- a/drivers/net/ethernet/intel/igb/igb.h
> +++ b/drivers/net/ethernet/intel/igb/igb.h
> @@ -258,6 +258,7 @@ enum igb_tx_flags {
>  enum igb_tx_buf_type {
>  	IGB_TYPE_SKB = 0,
>  	IGB_TYPE_XDP,
> +	IGB_TYPE_XSK
>  };
>  
>  /* wrapper around a pointer to a socket buffer,
> @@ -859,6 +860,7 @@ bool igb_alloc_rx_buffers_zc(struct igb_ring *rx_ring,
>  void igb_clean_rx_ring_zc(struct igb_ring *rx_ring);
>  int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  			struct xsk_buff_pool *xsk_pool, const int budget);
> +bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool);
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags);
>  
>  #endif /* _IGB_H_ */
> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 711b60cab594..4587877d1761 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -2979,6 +2979,9 @@ static int igb_xdp_xmit(struct net_device *dev, int n,
>  	if (unlikely(!tx_ring))
>  		return -ENXIO;
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return -ENXIO;
> +
>  	nq = txring_txq(tx_ring);
>  	__netif_tx_lock(nq, cpu);
>  
> @@ -3326,7 +3329,8 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	netdev->priv_flags |= IFF_SUPP_NOFCS;
>  
>  	netdev->priv_flags |= IFF_UNICAST_FLT;
> -	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT;
> +	netdev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
> +			       NETDEV_XDP_ACT_XSK_ZEROCOPY;
>  
>  	/* MTU range: 68 - 9216 */
>  	netdev->min_mtu = ETH_MIN_MTU;
> @@ -4900,15 +4904,20 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  {
>  	u16 i = tx_ring->next_to_clean;
>  	struct igb_tx_buffer *tx_buffer = &tx_ring->tx_buffer_info[i];
> +	u32 xsk_frames = 0;
>  
>  	while (i != tx_ring->next_to_use) {
>  		union e1000_adv_tx_desc *eop_desc, *tx_desc;
>  
>  		/* Free all the Tx ring sk_buffs or xdp frames */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			dev_kfree_skb_any(tx_buffer->skb);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -4939,6 +4948,7 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  					       DMA_TO_DEVICE);
>  		}
>  
> +skip_for_xsk:
>  		tx_buffer->next_to_watch = NULL;
>  
>  		/* move us one more past the eop_desc for start of next pkt */
> @@ -4953,6 +4963,9 @@ void igb_clean_tx_ring(struct igb_ring *tx_ring)
>  	/* reset BQL for queue */
>  	netdev_tx_reset_queue(txring_txq(tx_ring));
>  
> +	if (tx_ring->xsk_pool && xsk_frames)
> +		xsk_tx_completed(tx_ring->xsk_pool, xsk_frames);
> +
>  	/* reset next_to_use and next_to_clean */
>  	tx_ring->next_to_use = 0;
>  	tx_ring->next_to_clean = 0;
> @@ -6486,6 +6499,9 @@ netdev_tx_t igb_xmit_frame_ring(struct sk_buff *skb,
>  		return NETDEV_TX_BUSY;
>  	}
>  
> +	if (unlikely(test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags)))
> +		return NETDEV_TX_BUSY;
> +
>  	/* record the location of the first descriptor for this packet */
>  	first = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
>  	first->type = IGB_TYPE_SKB;
> @@ -8260,13 +8276,18 @@ static int igb_poll(struct napi_struct *napi, int budget)
>   **/
>  static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  {
> -	struct igb_adapter *adapter = q_vector->adapter;
> -	struct igb_ring *tx_ring = q_vector->tx.ring;
> -	struct igb_tx_buffer *tx_buffer;
> -	union e1000_adv_tx_desc *tx_desc;
>  	unsigned int total_bytes = 0, total_packets = 0;
> +	struct igb_adapter *adapter = q_vector->adapter;
>  	unsigned int budget = q_vector->tx.work_limit;
> +	struct igb_ring *tx_ring = q_vector->tx.ring;
>  	unsigned int i = tx_ring->next_to_clean;
> +	union e1000_adv_tx_desc *tx_desc;
> +	struct igb_tx_buffer *tx_buffer;
> +	struct xsk_buff_pool *xsk_pool;
> +	int cpu = smp_processor_id();
> +	bool xsk_xmit_done = true;
> +	struct netdev_queue *nq;
> +	u32 xsk_frames = 0;
>  
>  	if (test_bit(__IGB_DOWN, &adapter->state))
>  		return true;
> @@ -8297,10 +8318,14 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		total_packets += tx_buffer->gso_segs;
>  
>  		/* free the skb */
> -		if (tx_buffer->type == IGB_TYPE_SKB)
> +		if (tx_buffer->type == IGB_TYPE_SKB) {
>  			napi_consume_skb(tx_buffer->skb, napi_budget);
> -		else
> +		} else if (tx_buffer->type == IGB_TYPE_XDP) {
>  			xdp_return_frame(tx_buffer->xdpf);
> +		} else if (tx_buffer->type == IGB_TYPE_XSK) {
> +			xsk_frames++;
> +			goto skip_for_xsk;
> +		}
>  
>  		/* unmap skb header data */
>  		dma_unmap_single(tx_ring->dev,
> @@ -8332,6 +8357,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  			}
>  		}
>  
> +skip_for_xsk:
>  		/* move us one more past the eop_desc for start of next pkt */
>  		tx_buffer++;
>  		tx_desc++;
> @@ -8360,6 +8386,21 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  	q_vector->tx.total_bytes += total_bytes;
>  	q_vector->tx.total_packets += total_packets;
>  
> +	xsk_pool = READ_ONCE(tx_ring->xsk_pool);
> +	if (xsk_pool) {
> +		if (xsk_frames)
> +			xsk_tx_completed(xsk_pool, xsk_frames);
> +		if (xsk_uses_need_wakeup(xsk_pool))
> +			xsk_set_tx_need_wakeup(xsk_pool);
> +
> +		nq = txring_txq(tx_ring);
> +		__netif_tx_lock(nq, cpu);
> +		/* Avoid transmit queue timeout since we share it with the slow path */
> +		txq_trans_cond_update(nq);
> +		xsk_xmit_done = igb_xmit_zc(tx_ring, xsk_pool);
> +		__netif_tx_unlock(nq);
> +	}
> +
>  	if (test_bit(IGB_RING_FLAG_TX_DETECT_HANG, &tx_ring->flags)) {
>  		struct e1000_hw *hw = &adapter->hw;
>  
> @@ -8422,7 +8463,7 @@ static bool igb_clean_tx_irq(struct igb_q_vector *q_vector, int napi_budget)
>  		}
>  	}
>  
> -	return !!budget;
> +	return !!budget && xsk_xmit_done;
>  }
>  
>  /**
> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index 3d64a9f6360c..157d43787fa0 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -461,6 +461,69 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
>  	return failure ? budget : (int)total_packets;
>  }
>  
> +bool igb_xmit_zc(struct igb_ring *tx_ring, struct xsk_buff_pool *xsk_pool)
> +{
> +	unsigned int budget = igb_desc_unused(tx_ring);
> +	u32 cmd_type, olinfo_status, nb_pkts, i = 0;
> +	struct xdp_desc *descs = xsk_pool->tx_descs;
> +	union e1000_adv_tx_desc *tx_desc = NULL;
> +	struct igb_tx_buffer *tx_buffer_info;
> +	unsigned int total_bytes = 0;
> +	dma_addr_t dma;
> +
> +	if (!netif_carrier_ok(tx_ring->netdev))
> +		return true;
> +
> +	if (test_bit(IGB_RING_FLAG_TX_DISABLED, &tx_ring->flags))
> +		return true;
> +
> +	nb_pkts = xsk_tx_peek_release_desc_batch(xsk_pool, budget);
> +	if (!nb_pkts)
> +		return true;
> +
> +	while (nb_pkts-- > 0) {
> +		dma = xsk_buff_raw_get_dma(xsk_pool, descs[i].addr);
> +		xsk_buff_raw_dma_sync_for_device(xsk_pool, dma, descs[i].len);
> +
> +		tx_buffer_info = &tx_ring->tx_buffer_info[tx_ring->next_to_use];
> +		tx_buffer_info->bytecount = descs[i].len;
> +		tx_buffer_info->type = IGB_TYPE_XSK;
> +		tx_buffer_info->xdpf = NULL;
> +		tx_buffer_info->gso_segs = 1;
> +		tx_buffer_info->time_stamp = jiffies;
> +
> +		tx_desc = IGB_TX_DESC(tx_ring, tx_ring->next_to_use);
> +		tx_desc->read.buffer_addr = cpu_to_le64(dma);
> +
> +		/* put descriptor type bits */
> +		cmd_type = E1000_ADVTXD_DTYP_DATA | E1000_ADVTXD_DCMD_DEXT |
> +			   E1000_ADVTXD_DCMD_IFCS;
> +		olinfo_status = descs[i].len << E1000_ADVTXD_PAYLEN_SHIFT;
> +
> +		/* FIXME: This sets the Report Status (RS) bit for every
> +		 * descriptor. One nice to have optimization would be to set it
> +		 * only for the last descriptor in the whole batch. See Intel
> +		 * ice driver for an example on how to do it.
> +		 */
> +		cmd_type |= descs[i].len | IGB_TXD_DCMD;
> +		tx_desc->read.cmd_type_len = cpu_to_le32(cmd_type);
> +		tx_desc->read.olinfo_status = cpu_to_le32(olinfo_status);
> +
> +		total_bytes += descs[i].len;
> +
> +		i++;
> +		tx_ring->next_to_use++;
> +		tx_buffer_info->next_to_watch = tx_desc;
> +		if (tx_ring->next_to_use == tx_ring->count)
> +			tx_ring->next_to_use = 0;
> +	}
> +
> +	netdev_tx_sent_queue(txring_txq(tx_ring), total_bytes);
> +	igb_xdp_ring_update_tail(tx_ring);
> +
> +	return nb_pkts < budget;
> +}
> +
>  int igb_xsk_wakeup(struct net_device *dev, u32 qid, u32 flags)
>  {
>  	struct igb_adapter *adapter = netdev_priv(dev);
> 
> -- 
> 2.39.5
> 

