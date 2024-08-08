Return-Path: <bpf+bounces-36659-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1336794B4EC
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 04:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E491C219F5
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 02:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A204C2C8;
	Thu,  8 Aug 2024 02:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4Hcp031"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15784A21;
	Thu,  8 Aug 2024 02:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723083326; cv=fail; b=dumu0FMpJUBvB5PvRJKIejSlyuZ5bju1Kwf4pBRfvC0kPce24ccfqZz83ujWAB0MOwI5CrFx2HhuMkEGD3GInXasJSnKwYlYFidDgNHQmqe6jroIuyfX2mUU/kYX2kvj6lTbKI2m+ZCSLHPVV6z27an5IpIhuclvqP8r2WVdIe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723083326; c=relaxed/simple;
	bh=4+d7+nvvwqzNKApPDl0LdlK0FyJL/KJ2ahZ/t4TejrI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ReJYU54d7JOQW0oFnac45O8kzZwlP6PA0bXvanXYPvVwbItJgyCj70Rk28cPkxM25nM48F2V1BN6qjH17tNQeA3/uZL1ionuqfTUSGzxB6KiAGZIBW5RI1Y3xZoGspGs86Gzu7uTQZIWxQBwQxxjo8IKZd4rZ/uCwx09Jj5WeEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4Hcp031; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723083325; x=1754619325;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4+d7+nvvwqzNKApPDl0LdlK0FyJL/KJ2ahZ/t4TejrI=;
  b=V4Hcp031S4IHmX+MWHrSBpF1qfp4XRmMtnugcoQd5qzb+61VOcH16a3j
   cedkDlPzSZtkNPu5I+wXSKNdxdc/MNF+quIfVVWecQGVos/YSpJmLL+iE
   VTMWr6EKAQbVEJcLO4Pi89dawA4BHwW2XROubIa58S+j4aSw0FesNav27
   352LZ2YpweD/0ve6c6Kj1oZJdVy3aeYZWf8nxTmBZ/osrG+L9ea0uIpLW
   htjWhhb54D7ygMScrFkN6SP0YWbrj92YDMPkruVZkC23XLNb3G7UHasej
   C6i3SA+dA5600AHRCGCrUXJnnAE/sw75qi+ZKCQ+WoKGqDJtouYpBtSLO
   w==;
X-CSE-ConnectionGUID: WyViFiq/QpyVtk1/Vbe11A==
X-CSE-MsgGUID: CdpWturPQ9Kgf83HKQuEiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="20852023"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="20852023"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 19:15:24 -0700
X-CSE-ConnectionGUID: 5/o+70TnR7q3n59db+y/HA==
X-CSE-MsgGUID: lbkwDlCNQgeq/kjW0s4c9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="57136519"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Aug 2024 19:15:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 7 Aug 2024 19:15:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 7 Aug 2024 19:15:23 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 19:15:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GUOaTRcwf9L7rDK/7/IxkzYu9sM+GIRY0gnh0e9tYCnwcOzXn/P9kDbmEEyMNjzwZ+T/di/YYguiufxavmFXT92/FkXZ1q2lxHBbYPN6IbofNl8iwnhQGCVvoOaCESJMZ/kEzWsskB+wRlqgtXNS+/Ryy56shKSEEB3A0Yj9kGZ0EmiJ/qLfyIW+xt8iwVsRVlSnB5qRizNoZ0w8OkxR7rNPdY3OFyNeJhGv5lasDgTdTJvhPAXKy/AAu4im7b/S2MikV2ZGmD4y3VE+K3s4zpEbfWQmc+bMeaLG/CCAGmYYWVH9vKGrTPcvMQquv6VeK293/QXITzmS5vAqJb5A+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rLOU8K92pjbyFeO4At3fFGF1Nn3MuS2QXr632mhm5J0=;
 b=vM8Nl+6yMDMVvGvRO8eP0+ZM6++qX+UjKcVVUSMXvP1Vp4XIZ1GKhWZYmOp9NNH8Dc9chhnxdTM9z56RJWvJczcfMbKVIK5TXVledVNCUeAbYR9zqTTM6xlroWzFxcMJGCJXTlYyQA+dagjrND8ylxDqZyBMidqSzjJqXX9LjLxhwTnSwM6ZLbWWiwmm+rPz/T0MxeauouQg2N9xjowF+2ed8ImAlGOniX5FeKOEO6ZecqflOEkMYUqXLmwVVzOZuJDSxl2jeXj0BP2T1z2sLXKJyroyJbv7eOGaI/czIbObHN9CBDbqBhXh9JSiAvo33Sz7Y5QdWHmX4uzg6XbP7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB8313.namprd11.prod.outlook.com (2603:10b6:610:17c::15)
 by SA1PR11MB8253.namprd11.prod.outlook.com (2603:10b6:806:250::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Thu, 8 Aug
 2024 02:15:17 +0000
Received: from CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3]) by CH3PR11MB8313.namprd11.prod.outlook.com
 ([fe80::3251:fc84:d223:79a3%5]) with mapi id 15.20.7828.024; Thu, 8 Aug 2024
 02:15:17 +0000
From: "Rout, ChandanX" <chandanx.rout@intel.com>
To: "Zaremba, Larysa" <larysa.zaremba@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "Drewek, Wojciech" <wojciech.drewek@intel.com>, "Fijalkowski, Maciej"
	<maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, "Kubiak,
 Michal" <michal.kubiak@intel.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Nambiar, Amritha" <amritha.nambiar@intel.com>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>, Jakub Kicinski
	<kuba@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, "Karlsson,
 Magnus" <magnus.karlsson@intel.com>, "Pandey, Atul" <atul.pandey@intel.com>,
	"Kuruvinakunnel, George" <george.kuruvinakunnel@intel.com>, "Nagraj, Shravan"
	<shravan.nagraj@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 4/6] ice: check ICE_VSI_DOWN
 under rtnl_lock when preparing for reset
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 4/6] ice: check ICE_VSI_DOWN
 under rtnl_lock when preparing for reset
Thread-Index: AQHa3erV5Xvyg0HmDUOm17nyG/GVRbIctYkw
Date: Thu, 8 Aug 2024 02:15:17 +0000
Message-ID: <CH3PR11MB83136F88E713DCBB72F1F483EAB92@CH3PR11MB8313.namprd11.prod.outlook.com>
References: <20240724164840.2536605-1-larysa.zaremba@intel.com>
 <20240724164840.2536605-5-larysa.zaremba@intel.com>
In-Reply-To: <20240724164840.2536605-5-larysa.zaremba@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8313:EE_|SA1PR11MB8253:EE_
x-ms-office365-filtering-correlation-id: d46276e2-63cc-4753-9aaf-08dcb74ff23a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ALsnKCCvBQ34OM/vx3U3zTYN4qTDcAJ6Trd4FwZv0jTk1rSIvqKAHVJOw+vd?=
 =?us-ascii?Q?aeqYrrEg4qbwAbte4lMm4WVTrzh84G/QU/yIZZaHWV0/0svwJXEeLF4wNV8D?=
 =?us-ascii?Q?r3djl+/pzFW6j2lh/vALwzsYYa56FgycO+tkBX+mXXKCU9/rFL8JFnd6Os/G?=
 =?us-ascii?Q?bJhM2I1C/mEk6uHl5PubFA1J4X+jvkRolC+re4kSg2X9nsdEABtNgJ0/uyXI?=
 =?us-ascii?Q?zt40m1Mx0RcExlkD7LrIwc0niCh44wCYR3f2ssPITHccgZU5EdUKDLLQN/Sc?=
 =?us-ascii?Q?IRh1JE41cvnVdfhODAIAIj+0EGpElI4Nz7Tuwn7LRuO4h+NjzJowKD+iO3a7?=
 =?us-ascii?Q?CWn7JfajfLOWBYMuJpP6amrXcVKmXnaJla7+DVaFrY1nM3a+Ib0JpF/M1XOK?=
 =?us-ascii?Q?TT7iuK5YkiNAiizateV2dAu5ihcNWC4Uv/UdagCjzhF5S5Y/0gMF0946u+T5?=
 =?us-ascii?Q?5j1edxJh0fNgCo5SxTrCV7QXwhoOFMOczJaWSdgfYA/aLdVZPAJs4z4LLsKz?=
 =?us-ascii?Q?69lUNHnXVgsw4C9AjpbckDYtMTLSYnN3YjDgm0yQLPX0ZnhszNU71Mw/LiWn?=
 =?us-ascii?Q?Bfl7sppaOkDnDvFskOT3vLs9nHU7MNLi4sEU6hiVEV2RMImqj9m5+KDns4sT?=
 =?us-ascii?Q?JpYDjLie3tCZTZXZP/ZrnKuJmyuphs0W2+spW/2UMhQBgCZdWwg8v0CNZpYd?=
 =?us-ascii?Q?POUHZmH+n9Vn9ov07qraeRLzNME+Wjy6Z8IPpRpo5AU8TynCjUqUXENUv2Vh?=
 =?us-ascii?Q?+QVxzPJ4SX72EWJXp6ztUnCBgAGxIuES/0E4cNpmhwcfOoXWa7YHtUJi30La?=
 =?us-ascii?Q?UAxXVLjYD2QIXt6JIwhSsJtEJ2dibGjxFX1XA+2zThdwZM019GwJgMOtG9If?=
 =?us-ascii?Q?liEcHcuiJ6CtLAZJtHjdne61R2CwISxFZZccRTJ2VGRF0BOwnHGzSjQH7FEq?=
 =?us-ascii?Q?aQK0/qWNjfV0LxN6m8wOb/+MlFJbcHZv2NHKclGPTPg0qsI8XDEWVGILWsZs?=
 =?us-ascii?Q?BqvGAcGCJz04tf9srT1GMmz1ELBTnFPMhhXzti6lKZH2UXsRLIfQ04l0ST/e?=
 =?us-ascii?Q?zRycHVNi4jNd9KxK+YuL9yJSY+GMw/v9BdiUWHuMWpsYva57gqf2SrkB4uNg?=
 =?us-ascii?Q?uS2dUS3a1wV7KTZB9LVcG1197KgGe0eGDQgQWSLI/FRACejiuVkxS5d3TPbA?=
 =?us-ascii?Q?LKErAgXGj6NSUvBXcf3KhxIgvpoNhaazdzoKRQw11xh2Cx4rzvlVW4Ci754V?=
 =?us-ascii?Q?HNtUXpjLSTgGQ1AWRnTERakKVsJmlazkLc3rIYTPZVtWS2ZkiF37laFZTfi0?=
 =?us-ascii?Q?7rJ0SGQSe4dVLbg/LKXYe3RX9Iv/nXrv36hITDhOKPdW/aeQg5yZ9ZjBHt+d?=
 =?us-ascii?Q?bKoQeCInDYt/Y99gxabavFK7D6ZOV1kKGGv74Yq65kf7j1NQZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8313.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4uv7FLAGce4z6rFsiy8lvAvXzZ1mKV9ZZWMuljj+NXUdOfxEfBPXoh4dF1l8?=
 =?us-ascii?Q?duRaoBBCbDfbBpy74x/DBE32nOHX3DjsvcftLG3T+RX1s3/6V+VhRBQqDyga?=
 =?us-ascii?Q?TcEFgpQY/pTqfw7M6Z5LECjF8SebYfvfZhEEX8vnxO6y99RIzFHvA/mwujjM?=
 =?us-ascii?Q?4Y3TW3bUeUm6mPgvm+rlFmIo92utT4Beaz+CAA4snVRFLJ60satYZCvSZYsR?=
 =?us-ascii?Q?LIMPCTCScb/Fih7pw5jxbxkixsI1s2sU59OxPL88PGGXjuLaQtdHCthlcIbD?=
 =?us-ascii?Q?qcrnzv7ajJ4rx8kPe1MPP0cDFbH6JujIRwA48N3BSCexJIt65OykdQOJfI4f?=
 =?us-ascii?Q?3Ji8PoBRq7Qe81mqNfDf/v2d1L4P+I7072EM30cLbcTrXg6QV/3q1BNEeInN?=
 =?us-ascii?Q?fzab3VLJUIWUAG6KKjhqzf0vSNvQr2mLGZ5uI3AISOkjqAVyXHrXFOclWU9f?=
 =?us-ascii?Q?9XaI7uqv3HYy+JkOfnZOQfIC4D0ewduLAX5sLKpQP8IO4nRS4ULamzMuzuH1?=
 =?us-ascii?Q?6FOLVynco2W4FUT5SHlk3reJno7YnsqXCnhGs+1pjOpeduKP+ydmv6pk5omZ?=
 =?us-ascii?Q?rqLFhowXj6q1qExynIiAGnwjyZfdxtAZr19b+z7XPUO4IQnJz/KSgjETl9v9?=
 =?us-ascii?Q?JY40kNX49VtjUVkhBO4ILb/IoqE1cB9mGfQfXcv75qfCjGulxE4pdf3nfkyZ?=
 =?us-ascii?Q?O/YRFbdly15b4+eiVj7j/YCe7tp42tEvwja2Ha570kP42C4oGL3jgZla2Dtc?=
 =?us-ascii?Q?8dwFhsQ0HLVYSfaMvj+6naFKdz1DJMQ83yW4SsPdvAUQtTZo+eP1joiaI1U6?=
 =?us-ascii?Q?7OdX7gzlvhOC2jD48gbkTO8Wot78SmoNyKyXBi1rqYmYud4AlSfFSXCbvYNG?=
 =?us-ascii?Q?35UKG1BUrQgfPX3fzW8BLf8mppbhxIGXvmFFUduwp7CkjB9OabrjQCHxZTr+?=
 =?us-ascii?Q?1yROV3vinIKJcks/fJN1Ctqz4f5WlpgsZY9U1rN3ScwzlPWT7jpUQU0Giy6L?=
 =?us-ascii?Q?qrOFsoPTaj3IjxHWMEwtQKSrbGA6NHV02uuBSZObN/fj0OUfeN6q+sA1oVZq?=
 =?us-ascii?Q?VgQdJu1mylvrJ9i77EBnNb5nwPpIx+obVNivlz3OcC8cFvfaReptDlNnKRTE?=
 =?us-ascii?Q?0MdVMCdpc/dBb5z9HXq1Hzm+Qp7dtNlh93EjuePL3GAg8FbZYHrS3X8ju5z7?=
 =?us-ascii?Q?GLirogr/ZR3GGBH8Dss759rnwU187K0o3m5XKaXw0cq13GwrKwEhUCbfaLHT?=
 =?us-ascii?Q?b92NugTxe7wMm73KSoea7APvOlBqpaDvYYcSJB2BS5ZYfo0wfo9qd+CSmYCG?=
 =?us-ascii?Q?7vkvwJudIS7DPcAsbTYvbGMb8Uh+H7gOIsuP5z492M8x0DhdXB1ERE+wlwqO?=
 =?us-ascii?Q?lEuCXm2OxvdYP1GP2fedQBikZ8UGW4oFXGJ8OPxFchjAIS8aOwje15YQMZwD?=
 =?us-ascii?Q?Z+NPPBGgkHe43VDHGPRH7KCXZsBgehxu7jK9znN0EZC6yBGJSCnulfecTSyL?=
 =?us-ascii?Q?PtsHKpe7buzFw0SsbWa0kpixpFdb8DoiYmoTl0dzvDOOZHHvGxDYQeD8vcq8?=
 =?us-ascii?Q?g/WXYHoBdys78hFQVMIGyp09ABNFUc53KBn7ceql?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8313.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46276e2-63cc-4753-9aaf-08dcb74ff23a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 02:15:17.3442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TC1qfvCgJpe7FbPQdkifrJroxUWVlJ1bcvBl7oqkfE2YG9l+37a+UZ8e/xskuqSLh+wB0HxE4kYruWNhxetTZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8253
X-OriginatorOrg: intel.com



>-----Original Message-----
>From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
>Zaremba, Larysa
>Sent: Wednesday, July 24, 2024 10:19 PM
>To: intel-wired-lan@lists.osuosl.org
>Cc: Drewek, Wojciech <wojciech.drewek@intel.com>; Fijalkowski, Maciej
><maciej.fijalkowski@intel.com>; Jesper Dangaard Brouer <hawk@kernel.org>;
>Daniel Borkmann <daniel@iogearbox.net>; Zaremba, Larysa
><larysa.zaremba@intel.com>; netdev@vger.kernel.org; John Fastabend
><john.fastabend@gmail.com>; Alexei Starovoitov <ast@kernel.org>; linux-
>kernel@vger.kernel.org; Eric Dumazet <edumazet@google.com>; Kubiak,
>Michal <michal.kubiak@intel.com>; Nguyen, Anthony L
><anthony.l.nguyen@intel.com>; Nambiar, Amritha
><amritha.nambiar@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
>Jakub Kicinski <kuba@kernel.org>; bpf@vger.kernel.org; Paolo Abeni
><pabeni@redhat.com>; David S. Miller <davem@davemloft.net>; Karlsson,
>Magnus <magnus.karlsson@intel.com>
>Subject: [Intel-wired-lan] [PATCH iwl-net v2 4/6] ice: check ICE_VSI_DOWN
>under rtnl_lock when preparing for reset
>
>Consider the following scenario:
>
>.ndo_bpf()		| ice_prepare_for_reset()		|
>________________________|_______________________________________|
>rtnl_lock()		|					|
>ice_down()		|					|
>			| test_bit(ICE_VSI_DOWN) - true		|
>			| ice_dis_vsi() returns			|
>ice_up()		|					|
>			| proceeds to rebuild a running VSI	|
>
>.ndo_bpf() is not the only rtnl-locked callback that toggles the interface=
 to apply
>new configuration. Another example is .set_channels().
>
>To avoid the race condition above, act only after reading ICE_VSI_DOWN und=
er
>rtnl_lock.
>
>Fixes: 0f9d5027a749 ("ice: Refactor VSI allocation, deletion and rebuild f=
low")
>Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
>Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
>---
> drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++------
> 1 file changed, 6 insertions(+), 6 deletions(-)
>

Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worke=
r at Intel)


