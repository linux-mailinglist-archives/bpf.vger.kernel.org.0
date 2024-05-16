Return-Path: <bpf+bounces-29848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E118C7566
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 13:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF828360B
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80021145A0F;
	Thu, 16 May 2024 11:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJKxqoQU"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BF226AD0;
	Thu, 16 May 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715859816; cv=fail; b=o/7ohhPrvglSouKPnCGslz3l0my15zYlGad06xJlgwoZ9tpRe+NtQr/IlQWBA684MuB8+rLdzHOhamXStA4FMgv+KubZfNvt3nA57bS5mJkVDnWacBDdgtvvREA1JeAet3wcnGh8Fwb81mBPy0ZmcE4cpzq6xGGF+LgRxfhajIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715859816; c=relaxed/simple;
	bh=w1SSU2Vax9hXSiU4TcgdjNOK/76tcqEvQCyfy5o6Jl8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uOerdEnje1V+cCDzLyBU2YbR33vmsglzznm9gWE72HMnFxPsLQ7tG3XzH8cF/iwhksJXX30Af5+jdOy1R7YhE9A2LmG+YLYV8qDy2uLJ9pHSZ3XOaFXMU15jXaMVM4lrplVtaFOcoEx5BcykrI6Gg+rpBYsgRtSMzvk14mo3bq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJKxqoQU; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715859814; x=1747395814;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w1SSU2Vax9hXSiU4TcgdjNOK/76tcqEvQCyfy5o6Jl8=;
  b=nJKxqoQUl1nz7VhV4UsYyDhPVzK+IxqKZ+MiH7eckNDNMeUdXhBlSzTm
   XXuSu8nkRCNKfU9b8I57LOQMCIhMiHUCH0FQngACoRNyfivaIw/1fAaEC
   KtCOP4AMiUGH4PpcA6WbyLiTbSKhEpCKZV0NXURZFL5Xfx4Ll+g9kEv4A
   dU+ah3OwZHQicJG4wGvLHx4Up/RLl1sxeOUQAOPHvMxxulswXfoKjPgAg
   xCKCN+eSiwseAVY5f7avwo0R3eHW+tgWogddPLKCJ+Kv8KTV84O2gwwCU
   KXKh1+P8wdRBPFXcIzEHRctYg38+BxgyIstuoEzWbcUHdtv0H4wFVXRW6
   g==;
X-CSE-ConnectionGUID: ucf5HbwiRr6J+GWYjBHX4w==
X-CSE-MsgGUID: TnjYhplLTsq8Wp+2UhR38Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="23365507"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="23365507"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 04:43:33 -0700
X-CSE-ConnectionGUID: VMaGvw9OQQWhiqczKpEP1Q==
X-CSE-MsgGUID: VJ7R9CbYR0evdXqZy4hGYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="62612169"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 May 2024 04:43:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 04:43:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 16 May 2024 04:43:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 16 May 2024 04:43:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 16 May 2024 04:43:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcsj08NKAvFkTAmFn+lGvvGNMPy1BRSgs8ZewxUKYjEtQ3aXCzjxsi56PxQe3jhmPlNIAsXpYEuDz1aQQgcuyfk8Qrelust4ytklODcaNb7aNm16yPClpi2u+VcgZ+wouKiE1b813REcFEF8X5mCDc0/MaHmiLgUWoe0GPUBrGAhFIuKliFEUh5QNG1qLI1hBqchyXJgupeZi+Ts20ZVaplSr5iu7CLBg7EFjumfWGH9RUpUzROTEkDVPTZSxRDDCiLG/FIIjGcHngI/l3qkKmqY3airejsvExZA9GLENBlsqEKPwQ4a7Be6C0HfO47/9KIA4dT8F1FAvMsjierlkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eLsakhp78TSTDBdyBflgWaKIOtfPHtGxfy0j7ktp50=;
 b=JTmAKjlChpVdb1lrMautOa3BidoF7/23z8qkDyEyxa/nIXIFkDJ3kLfbAni1hMXK12CUe+1JPdXmKduR+s/ZTZN5ABWxe8gDYOy9vSIMfZrOdWlAVpVVDAa21JEe181D+mQi0cdrB3hVrFtgZHtYYn4WaQeqyi8rs9XVycVhg/b7aiRnZ6B4TXYoaZ5mTP9KqHnJAumHKpjBfR81q2ckdt+WqgP99yRmSbfX8pYbDwyy/GcTAV3fETgW//eO6/4RRAqy225y2Tb05Qb+3+pJwonUijMyvWLDdz7J2Oa30ueLJ/WVVBPEWFkGEZ8A45lesREZnGCEPkMXET0i5cRvYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by MW6PR11MB8412.namprd11.prod.outlook.com (2603:10b6:303:23a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 11:43:28 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%3]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 11:43:28 +0000
Date: Thu, 16 May 2024 13:43:18 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <maciej.fijalkowski@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<igor.bagnucki@intel.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH iwl-net 3/3] ice: map XDP queues to vectors in
 ice_vsi_map_rings_to_vectors()
Message-ID: <ZkXxVp3hFvczWr8r@lzaremba-mobl.ger.corp.intel.com>
References: <20240515160246.5181-1-larysa.zaremba@intel.com>
 <20240515160246.5181-4-larysa.zaremba@intel.com>
 <20240516082713.GC179178@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240516082713.GC179178@kernel.org>
X-ClientProxiedBy: VI1PR08CA0251.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::24) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|MW6PR11MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 10349e5d-13b8-4778-0b28-08dc759d677e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JR9r8lDnnoA6S4/7Kz/bFFtEmfnxwKX221quEf75wj6cO4x/ntKovCzzt7GB?=
 =?us-ascii?Q?ugs+o+K8VcKYQtOmu/RK1/RpLB3Zv+wEMKD49ndE5j71CBMR4keGquPz39qi?=
 =?us-ascii?Q?S/uPQBuKUEnkoKSd1cDKM42PKR2QuLsKNQWmpYuUl6qlC125NG9Zq/Sz/pDr?=
 =?us-ascii?Q?KawXxCMIkVnxmKyxdGBoN0IkeFISbFPgWXv2tFm7zT2D2sEbb24XS9hhosy/?=
 =?us-ascii?Q?wbbbftCXfJBMA83KdNhvorrcwifB4aVpiRlvZjJHy1r0+/pPQRKgFQ+8QRpz?=
 =?us-ascii?Q?8+nWVckJ8hl5oW/vJiDAGRSVOXHPbGYeNgZPBr3xWVFGj3s52Iwz/QwqNDDQ?=
 =?us-ascii?Q?k3LUIs5GVYI4aWWh9fTp0nzSXa2G3siOWlbOCcWLcYPNiu4zu8K+I98gE234?=
 =?us-ascii?Q?lkfgzNUXS0SoCH4rbts2RDaOyDhIpR5yh6n07sF7i05giNG8mSVYYCR9E1oO?=
 =?us-ascii?Q?o0cEj+bNvP6DHyjfKDcmu35BgguYCmVo0+nJNVE5ovDXdaObsfyE1dg38fET?=
 =?us-ascii?Q?xGw91+No584fNscMTVzZvBUmksPwK8fJhll/nPnqf2/NlzjIRdiX7kghjefz?=
 =?us-ascii?Q?3u8sJ6aDZ09LcHldU/nZzyWCEIJX7oY1UyjVZ0DPh5+AQGL2v/NSoSvViLDC?=
 =?us-ascii?Q?EFiYwMYHIcXuk7F7lELT9VOAYbv8zX9mq2Ly0jz64ZHI8k+6SEOHCTkK/g4o?=
 =?us-ascii?Q?fvbgeY/PiucOnAw2uf27P3a161OBn9b7nwsvEhnYNA5pPERnLF42eYR2stZ5?=
 =?us-ascii?Q?m/pxhmm89babF36s7X/UgF8bK1ABKvYK7ucMX+IqL2mqp3s3pKZ53G44+m8N?=
 =?us-ascii?Q?kUY8FBfUbf4cbPosAAAnB9HEX9fDzgjywdIAxdtXQAifarcw+BsMz8fyGq/Q?=
 =?us-ascii?Q?pp8BpN23xi0aEeuhLHf/6iSLNb8tSpk+cSORhMKZThqV/v7d+lz1ZqGd4SM9?=
 =?us-ascii?Q?MFjIqlZwjwQ9q/6/wmQEunQVkKytCYeZKck0C8hWEtQND/2wnHSvI1FivFx1?=
 =?us-ascii?Q?7K4hfoVyuiPyJf9hHOvd5JfPpzjG+9BLadyqWYGbVTapS4LqykC/kX7nM/8s?=
 =?us-ascii?Q?PJ7iX0tUXm1yfHAFMtYFWsHNXDibmmQf+bdeoFLtX2ZfcFEFYPNkYhHE6Yxq?=
 =?us-ascii?Q?NqoP8y16bNgpGQdqwq9LGqAMhEwfoprPm+usXStz4LBU12ggWLmcp5uh/sAd?=
 =?us-ascii?Q?+IjDAOnT7uBJPj+9qWGVXbXaQnrXXENrD6mgWC9MsqEGfHe7Rv+Bxnt9Iy6H?=
 =?us-ascii?Q?UA/DNr3MklCdCe7GeR3BhQ7I5twLQvOFHi3BVSejow=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HLJErOfeYxo7BGc6fvvh1R1EGo4m/Om97RVHuxrPL6O3ECffo8Tv2kW2QBZf?=
 =?us-ascii?Q?pWrTStizbsPODPCy0PgoSdDI7aaxSJQszYionTO0lsC/d1zQprvzBosCSNQx?=
 =?us-ascii?Q?MS8iqkHPdKv7yW/LzDWOrOcEpLZcp7MOcWKbfYKx+06/Az/2bl5PqWvTkjIo?=
 =?us-ascii?Q?G/aYBqjFDZZSkhWH5rxijuBLn8tZl7bA4KGr3f5HWD/kGtxgyV1YtvYCnQvK?=
 =?us-ascii?Q?QYfAn1wGaqFfO77Cx8j/4F+7iDfoHeN6Fhq+kRjLb5m3CarEaq1IKi18VN8W?=
 =?us-ascii?Q?XbG6V0F0PH7xSRWD687t+twp5b9mVd/mr38WGboVSXyabo7475JGgaFALl5Q?=
 =?us-ascii?Q?g8q+0tsvMWnV3jVFY+hQFsY0Z9TN8oVRgwEobHCUUJqA45fsfMsOnJSfF6y1?=
 =?us-ascii?Q?hEZK8XrZvsZnv7w+ab1wnMhpIom2dr4ILVGa0r71tGI2sKUZ1gVnOhIKtgkN?=
 =?us-ascii?Q?9S2kNdbWoODD0yL36pVWfYrjSywOmCI7t/0aAZTn10WxKeBVwHMYiwi/Aadd?=
 =?us-ascii?Q?onp3z29MOZSqbYl+Yky0cgjUT1jBHKqTo8N7POLNWLMNtmZ0XpVUS98b2rlc?=
 =?us-ascii?Q?pgRPC5qYg7XT0jjjvIYjxPEAcbMALTBd8kNGUpKzdHrqTOkMkUbsKUb6mxCF?=
 =?us-ascii?Q?voW9mPpVVgk1Dd6/7eK8aAOIcVagm1qHfBQMRmNi+9Cd2zBbeM2mQ66RQ4WZ?=
 =?us-ascii?Q?2PloVpgqaJ4unWuvR4lsC6n3zGIH0iPc8zGksaP3imb8y8ghx0HbLYF986/y?=
 =?us-ascii?Q?7oBd4nA3+Edsu0vNHJ6PN7tmql7/OnymcH8VsgQDzah+yemLuNN/XUbIvm92?=
 =?us-ascii?Q?OMeoELW6ZYGF3q5cS1uymSi7YYohPsg15ZGbakshY+kU1/Bot3cniYhxcYfz?=
 =?us-ascii?Q?hM1TxOid/mvOAly+6arHJSBdgVwCuqDSO2iVcgApdo6Qe5AmOfkCjzryRVyL?=
 =?us-ascii?Q?0cB6iCU/6sRJk7kCuLhbIIV9UuYOSWg1/gh5MBP6zNL9hEBbwA3s6tjIK/kM?=
 =?us-ascii?Q?bRGLerbCiCg3hHjR8Uaw5ocLoTsz+VrdCNcKzSP4KaWQ6KmlEZS2En74kPwy?=
 =?us-ascii?Q?J+VFL76a3ng+ZAWs1ruVSANAUrVbG+Lc8VSB3DtQwPA7nsQAyn3C7T3bnViS?=
 =?us-ascii?Q?8KBf2gSyGulKt3By91tWi2yO118lkaC99nyAGYUnNsswE/SoMzz84jnTxHr9?=
 =?us-ascii?Q?pz5qhDKkTGdyQcHL/FuDRiAZtlED6iwUFhayxuzSZvLDfjXKQz63xjpulHIX?=
 =?us-ascii?Q?0fQXIosHZBVdjcGYUCZCfhm9WWs/7pY8P4d3Kgk+R3OuWJR0iOwWv0WsLH8Q?=
 =?us-ascii?Q?zPkMmJ5QfmAGTwifgVS6XpZ3RZH7BCzTCke6mLmEQ1iLnqG2gsUkwgqNgEmi?=
 =?us-ascii?Q?mY1dpTWrFuZv2OFC7JORJgpL7tkyXoQ0+1KIKkTPKv+lIbyENBDNuqmGeW8u?=
 =?us-ascii?Q?YKrKd8bTzmCpMpTTiP74zYSO7i6UoTQi5cN7YuZKxFwLxTySmX0VYxsGNYFr?=
 =?us-ascii?Q?ncnt9v0XpfMmc6FyZ4iwCXu1Sg6WggpPlx29AEwiDaHVRoLHkxVoNxOP54wM?=
 =?us-ascii?Q?hKOaH6Lo2seh1xRxfuIBnXqqTh8fFayHloZta9E2sqd8Fn2Tqdstwmym9Aor?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 10349e5d-13b8-4778-0b28-08dc759d677e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 11:43:28.7699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sjipUoARqmSWT7a1p0X2oQDWF7i8nRM2tjxzNbHjW2lkPqVfsMUoZsjJtGQYERYu0KwrqLQoorVY+5ns2ISjFXSKK6VxrLAPXEJSk5K611Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8412
X-OriginatorOrg: intel.com

On Thu, May 16, 2024 at 09:27:13AM +0100, Simon Horman wrote:
> On Wed, May 15, 2024 at 06:02:16PM +0200, Larysa Zaremba wrote:
> > ice_pf_dcb_recfg() re-maps queues to vectors with
> > ice_vsi_map_rings_to_vectors(), which does not restore the previous
> > state for XDP queues. This leads to no AF_XDP traffic after rebuild.
> > 
> > Map XDP queues to vectors in ice_vsi_map_rings_to_vectors().
> > Also, move the code around, so XDP queues are mapped independently only
> > through .ndo_bpf().
> 
> Hi Larysa,
> 
> I take it the last sentence refers to the placement of ice_map_xdp_rings()
> in ice_prepare_xdp_rings() after rather than before the
> (cfg_type == ICE_XDP_CFG_PART) condition.
> 
> If so, I see that it is a small change. But I do wonder if it is separate
> from fixing the issue described in the first paragraph. And thus would
> be better as a separate patch.

This is not neccessary for the fix to work, but I think this is intergral to
making the change properly. I mean, before the change in the rebuild path we map
XDP rings to vectors only once and after the change we do this only once, just
previously it was in ice_prepare_xdp_rings() and now it is in
ice_vsi_map_rings_to_vectors().

> 
> Also, (I'm raising a separate issue :) breaking out logic into
> ice_xdp_ring_from_qid() seems very nice.  But I wonder if this ought to be
> part of a cleanup-patch for 'iwl' rather than a fixes patch for 'iwl-next'.
>

I have separated this into a separate function, because 2 lines exceeded 80 
characters, which is not in line with our current style for drivers.
And I do not think that this small function creates any more additional 
potentian applying problems for this patch. And the change is small enough to 
see that the logic stays the same.

> OTOH, I do see that breaking out ice_map_xdp_rings() makes sense in the
> context of this fix as the same logic is to be called in two places.
> 
> Splitting patches aside, the resulting code looks good to me.
> 
> ...
> 


