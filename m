Return-Path: <bpf+bounces-42778-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 831CD9AA282
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 065DE1F236F6
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 12:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01619DF47;
	Tue, 22 Oct 2024 12:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gihKr9YE"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6036D19D89B;
	Tue, 22 Oct 2024 12:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729601571; cv=fail; b=VxbZ7ho6UmO48FzoThX6l3LsEHoDM+tap/mpisVjxmOaC2OPPXopBwoOsIoNKgzh5l10hEIqdQD0xuo4E5AIftWaKI1GVXNsPF0A99jjNfZko62W+jMv+mJedsaWs8dxKxBnprn6ynDrHoQIiAmzv0EOKvN32hL6rbH55+u4a/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729601571; c=relaxed/simple;
	bh=NXsPrB7g/VDW0flJh1eVz2UDiuPLzpBy3d9e9qA0Drw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jvZmGzewhJTArx8BOe0YuOVHwWiyk7eojRhou/x7q3nETb1fk8XXuAHtBy/yvGoi6RGruj8+nMgeYPoR6ICxtiaeRctgo3w2K0JYoDDX2UpFZE3Un96aq8zdFhLgi24tCchyJBAPLX9mVUJ2FPKDftrnkkFcCPMeF0NaqjVP9d8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gihKr9YE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729601569; x=1761137569;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NXsPrB7g/VDW0flJh1eVz2UDiuPLzpBy3d9e9qA0Drw=;
  b=gihKr9YEp+xA5iPOSpd+28aOjYIW6X935h2cEKX/gX+OKciNwYMC9wjm
   WOz07GJN346Skd1HBOCMOebpG1RL8cFCtPkLkRhqkp6ek7jQJtfKHAA4j
   R/ySW7X0GB505gr6ow6251jNGr/0VlI5s6aFT+LHlmnpDq+kvwTu06f9y
   IaJFiJ2Zd5bmaHMWFIeFy/DvG5OBilLWHE5dZ91rKGStNmMYe/CE0v9aX
   2l7/HKhq4SBREEW1NvBYsRwPiB5NLKWlsSEC30B+1OdO6liLluIxefDHe
   fui9r7qauaoB3HMQdWnUD5YzIO500GiF2Xg60vM2QkLiemJ4cMkClq1K3
   A==;
X-CSE-ConnectionGUID: CCOAeSArT7WzobgKfri8NQ==
X-CSE-MsgGUID: U0G3RQtGShquB6zrphK84Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51675687"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51675687"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 05:52:49 -0700
X-CSE-ConnectionGUID: leapbMMyTiCB5HbhRMOj6w==
X-CSE-MsgGUID: SyDNfOcSQf6Bs/wCIk1rFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="79771041"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 05:52:48 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 05:52:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 05:52:47 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 05:52:47 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 05:52:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEj3DoSDScLFvh+aKc2Lk6GEiddVPXrpqgB/PB4wZuUGV+Yy9scEQ0AsUoFZpJb1WaaFMpoOq0hJkW2qN4ZD6Q9uf37fCbT49iXcj3iwyWrZaoZqwfaC/kYxPc5u3ukv0ibRLaw5a2p6PMAxisx8lw0Ht+TWzzru/3sJf79XVSGFjh8dR8Cs51WPu5RGzNk2qrkh3raJuB/11uj/2AysluCpOOV0i33PtDr4mc+T4/Xs/FdiVeitLPhWrDoFuypJSYr+6sylW2FCntwHdwYNZ4zujfvgFRvELgxC95vClLXwyfhs871PP/lp7ZsUhRITYsGk6La54xTlnGtLIDtdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+1hS4YCBUTnwlVhysBlZvI0MxlHsRiAMjIVDIVNTxo=;
 b=F1l3XEkJnWu0ZxGtSw0siZVgbUAh/HHh3tGno8+zmtFbhTPjJj7utcBtVdaNTl3Z+wMQjZw3tRTIIDbZOX+4WiBYTyUV1plAF0GBOqMxdjcqyE0eOSw6N5i/YAf/8wS/Vv/UFL4uvhGjOrWJQJn5ZA1cstIs9M/jSCkuxwwsSFhW4EV/DmUgmpYkQmTU/F9T73XJUI0rNH0xcbdBAy+MiZ22MB7F1QRt8AkNCYzyKRKzpQi8tXzEoikGUghWQJVEuxxc8zCT/MTijq07d0Z9QlCQb6k5ccXiJcPHuEpDoNtN3rkiypTBhpY9V0kGvhjfapbZFx1f05S62gO8rlSJVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Tue, 22 Oct
 2024 12:52:45 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8093.014; Tue, 22 Oct 2024
 12:52:44 +0000
Date: Tue, 22 Oct 2024 14:52:30 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?=
	<toke@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, "Magnus
 Karlsson" <magnus.karlsson@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 01/18] jump_label: export
 static_key_slow_{inc,dec}_cpuslocked()
Message-ID: <ZxegDpofPnIKK/1L@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-2-aleksander.lobakin@intel.com>
 <ZxDvsSPbnY5iCsAY@boxer>
 <1fdc9726-e21d-43f4-aee9-59276ddff37f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1fdc9726-e21d-43f4-aee9-59276ddff37f@intel.com>
X-ClientProxiedBy: WA2P291CA0042.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::14) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: f1aba579-12b6-47a9-f056-08dcf2986c4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UB+hfYQc7iKr8Fmmzsc8e1Sw0H1PZifKToJx6YqUVb0Yy6gNbUBhYHtpJQH8?=
 =?us-ascii?Q?v5V1vtnLDlkTaC54QXGdkRLUMxeG57jskmnUEsrYX/UU7twFGO2iMwZNRFtp?=
 =?us-ascii?Q?tHoHnoQUuVn6J7ungFEDcwnOy4IsghYrJYwK63CXZO9RtWQGGtmWWIU8MoCY?=
 =?us-ascii?Q?Rjgg2EBrBytjjjcuzJlmaG5DQQI0h0UoZ+MuTZXZKRqPCwNsCJJs6FeFPbSY?=
 =?us-ascii?Q?CKXKqgcxE7ZY37qmuxiuOAYJh9oEHXKqmUnyR6qLgGLQwFkEHq63wAhuOvno?=
 =?us-ascii?Q?xsAt+Gb1hkBKbI5+vrX2sFETg81WxMFDTBt4FEQId57IpQnS15N8KaPK1O7U?=
 =?us-ascii?Q?gPeWT6lezf+MnogmCmQfeNpXMwA+8xLeTJF8BFWJDwFSp1hyQjDyFz7cqF/B?=
 =?us-ascii?Q?q9/oKtsOI39a7dYA//wWjj0RmodC1SSWzo9OhCbvoZ+gVEm3DmlHxtfNw7m2?=
 =?us-ascii?Q?1gOgkgd5IbVaH2KaZ37u2KaXYRu5c7HnxfG+s7uHO9ft73MDvZWcYD4/m1PP?=
 =?us-ascii?Q?FyeAk5D191CETcfwahcOEDbW9u5DtPseElo74k2066bVvYxuci4/u4h0QIZP?=
 =?us-ascii?Q?GgB2DHS5Yi+W/GHAzK1INU2sfdWlmm18VYlCcD2Bw68KLriZAwwMYTYG0Ni7?=
 =?us-ascii?Q?rMXN01ZIVj9VY4PjWmzb+yu7MCAfH01lGgk+tcr+T0eEpBwUI1G8qFYjF+cM?=
 =?us-ascii?Q?21j8mZQFKPgJI1ykpE6jpg2DDU+xexsp6++CeAapaWvVDCEw9jYaDWHjd4vy?=
 =?us-ascii?Q?zN4d7beNoPTRF+hnLDFs8ndRneuXDWsHiZh8bc2RLStdJ+eus9SVugXat39j?=
 =?us-ascii?Q?uQt8uwswbwZTkV07+xxIbhfPj2LSalyIsyE3WNz9B8LGn6XnYnNhZWm0xChK?=
 =?us-ascii?Q?HU/tw7w38soeefScCuGg3xTZAMFHSJoVlk9ZAY3MaKi79GeBiZT1EQ7qXE2z?=
 =?us-ascii?Q?9LtCYJPlbpmZqoFEjL+t5SaesmnSnVpwUxKx+IxUCbvxuehrbt4AVNvfUgS0?=
 =?us-ascii?Q?bJhWNVV7E+BCXv8qQpC41hGl+YIQ56oyY0ItfSkIOESrWdLPG56nIHaWnkkz?=
 =?us-ascii?Q?C5DM4ZLly4qRxCuzmUYBvZvx7KS8QJIs02gPeioiBVudRQe+vGKSzfRFRGVN?=
 =?us-ascii?Q?n5rKzqDiwCNud/kg5MpjLCmB0L7nwbrzf6c/chspJapRGfkZyvMFVskbEZMH?=
 =?us-ascii?Q?C8DxxheYCjVDANSwLBM8Vf9iD9l4UzNfTFkPtWvcq3BFnRBt/kFSgke4F8XX?=
 =?us-ascii?Q?oCYupDvJSG5jyiAYAPOSdOQZmHNwWLGWEzQV6lYLnbFzHmGaS6PkHPk5Se2G?=
 =?us-ascii?Q?XHYVCSM15pUcOrcxm/PnpiDg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+vAVvlecVdOJWoanKRyvkka0kLtQNEbvgw6AIuy4PhvnSmAfo8vvhHPichel?=
 =?us-ascii?Q?tAww1roD0n2dNdhcm2ASV1QTwjJE0XMyjZ5gEMSRXj0sVQW6fltWrR9vQ+If?=
 =?us-ascii?Q?3ZfoTN8gLfsNy+0caQTV2KsRctLKUQ3qvM8zlwZKaJbN9eoJeswoehJyZg83?=
 =?us-ascii?Q?BmUBnKsPYJ0p/4ADHwWgVsyn0qVnH+QHpkkDsNQ3fp3VKNxXmW5quP4NACST?=
 =?us-ascii?Q?JhyaNeRhT0Io07qdmpy2JQIOQgtlLETL+uPQgIprArbwhQ8+cwQxFji9XF1W?=
 =?us-ascii?Q?ap5a5m5DlRO6cV7yTHAEztFmYWu3RN2jJFPlN/fIfPAsrBU03Ca/gFEDDeuj?=
 =?us-ascii?Q?RnXVIcMySezKnIsY11XWbw5hDc6Hw68lr8OD3wEjJuTygEfyXVD0zNihPha6?=
 =?us-ascii?Q?G+dTNnKLGnhKQ1FEVjSc/OPRetnTAgk2MJFJWR6vPOMsRYRoqPCVbaGnjzZ7?=
 =?us-ascii?Q?YbLYaeG+q9jk3h3/veeJxxpmcI9eAhxC+pt0hjQwCla/ZX3nFAAEerROwQca?=
 =?us-ascii?Q?oPWMeSPRy8PUDn8ykSbDqeVi7gckH6VTYeaNmMR+PBdMs079aOSvAwqrPdNy?=
 =?us-ascii?Q?sAxkiKbOy1RMnicqDKAIdCT8L1LE6a7JBcbhdwKf3OLfuu08ZOMTbX8iw2GL?=
 =?us-ascii?Q?/TWoekrG/zkXVhSWDqB2p566r+TxwstgXKHKl6R85guQpvC9ekpGfSZQq/r/?=
 =?us-ascii?Q?gzxp5158h27P/0DoL1qcpSLnDqG2+p5AraMslFQ+UE3E3UizyeezXiOVACJr?=
 =?us-ascii?Q?mk+Fujk5qx7xH+3mnsAFLLKrwvuIESj/dM3AIru/6yyhz1nDKGd5kjyprSMI?=
 =?us-ascii?Q?ZEdijLu2jEaxvHHhocpvFgnZ/eScmQcj35UUlli0faKXBqOIBpXToATPaGqb?=
 =?us-ascii?Q?IsUlb8PORgarIk1vkSFanZBvwmWwBN5r38tQj78d+F6fb4VOPsKC9ERL6C4x?=
 =?us-ascii?Q?8yyOoGSCQXkVRbhqzynOl6Nggowh33cTLM3+LNllDhj568PoUoXNJcuT4L0z?=
 =?us-ascii?Q?WWxDKWZNtRje9dOm/OH872gBxGKZVpSznK5m9JQMybABvlJFam/f8b2fuF7r?=
 =?us-ascii?Q?wYDfZXywdgIFikx8bzZ2RTu3VGt7UddQy4ADTskrQeWealJBOVO2um3byAwx?=
 =?us-ascii?Q?SpX2SSEpiXy12kCFkroxRX5UeaP3RDzw3GU4tyerVB9JNFfGM6e9OZ7pjvt+?=
 =?us-ascii?Q?so8lwu5TnnX/iTmLCKX4+2WUU/lyMvBhh41p7YvhDA5hMInYvTUsd0diqiJr?=
 =?us-ascii?Q?e4ZRPvDjvomJ0QsAsRPz/Mp/Ri43DrIX8fidDUW51rEXCwyjnnZH9dkX5gey?=
 =?us-ascii?Q?xqNN8gd88Wv5HRVnMO6D1gJVdDwCghdaVQZ4z0/zU4aEOgAbaabv4MyuIq6M?=
 =?us-ascii?Q?CP2WUhSm6deV30OJOMCy+qjPeCSrkH9eVou8fDxILBxwwfj03TEc7Jo5hQdD?=
 =?us-ascii?Q?B2SDVtAcDlBGSjvBqS/35h+V0MOGqEUBxKLyz0iJ7fZmuQwGND994Uu0PH0Q?=
 =?us-ascii?Q?CLbTGiLE/Yopmr32kRWbQ76KEgTnb0lU+37GJUQBmKqBplPDvjaF8kJZHyfk?=
 =?us-ascii?Q?R3XLWOsGrpVE9NB4no3tTR8f6iEy/btm+TRfVRCOOaWjq67lfR8GlZGr29wA?=
 =?us-ascii?Q?MA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1aba579-12b6-47a9-f056-08dcf2986c4b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 12:52:44.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4eAQyHkBATR6zg8q8V/vLCyr/YsdEhHAGAeE6esidnZet2uCmJ14hAF0MELtfk/zbSmuBg0ZDy20u7s8B1RvV+7cOBX8RbFyJBZtF1xnxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805
X-OriginatorOrg: intel.com

On Mon, Oct 21, 2024 at 03:53:40PM +0200, Alexander Lobakin wrote:
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Date: Thu, 17 Oct 2024 13:06:25 +0200
> 
> > On Tue, Oct 15, 2024 at 04:53:33PM +0200, Alexander Lobakin wrote:
> >> Sometimes, there's a need to modify a lot of static keys or modify the
> >> same key multiple times in a loop. In that case, it seems more optimal
> >> to lock cpu_read_lock once and then call _cpuslocked() variants.
> >> The enable/disable functions are already exported, the refcounted
> >> counterparts however are not. Fix that to allow modules to save some
> >> cycles.
> > 
> > Hi Olek,
> > 
> > can you explain how is this at all related to the patchset that it
> > contains? AFAIK I don't see it being used in later changes?
> 
> See libeth/xdp.c in patch #18, it's used to enable XDPSQ sharing static key.

I got tricked by define in include/linux/jump_label.h  and I was directly
grepping for funcs being exported:)

Not sure who should ack it though.

> 
> > 
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >>  kernel/jump_label.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> >> index 93a822d3c468..1034c0348995 100644
> >> --- a/kernel/jump_label.c
> >> +++ b/kernel/jump_label.c
> >> @@ -182,6 +182,7 @@ bool static_key_slow_inc_cpuslocked(struct static_key *key)
> >>  	}
> >>  	return true;
> >>  }
> >> +EXPORT_SYMBOL_GPL(static_key_slow_inc_cpuslocked);
> >>  
> >>  bool static_key_slow_inc(struct static_key *key)
> >>  {
> >> @@ -342,6 +343,7 @@ void static_key_slow_dec_cpuslocked(struct static_key *key)
> >>  	STATIC_KEY_CHECK_USE(key);
> >>  	__static_key_slow_dec_cpuslocked(key);
> >>  }
> >> +EXPORT_SYMBOL_GPL(static_key_slow_dec_cpuslocked);
> >>  
> >>  void __static_key_slow_dec_deferred(struct static_key *key,
> >>  				    struct delayed_work *work,
> >> -- 
> >> 2.46.2
> >>
> 
> Thanks,
> Olek

