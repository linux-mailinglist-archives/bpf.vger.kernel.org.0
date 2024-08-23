Return-Path: <bpf+bounces-37939-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7411A95CB40
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 13:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6A72854A6
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 11:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C073E187547;
	Fri, 23 Aug 2024 11:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gcvEvgQ3"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4FB4F88C;
	Fri, 23 Aug 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412093; cv=fail; b=dZvziVBeQ7Tk79nH1UN3dMZfn07tMhftj5wHcOKGHKE4z/aTvmA19FDh1geLm/fcMHud/Qs9+GpAUs6c2VSlX2Wd7y5ZdzPE3Yks9Y83tEkFbc2JyOGwspD7Vh/7kGjzgYBPhv2ZD8PiPq5J3kTUqaK8X9C8ablolYwHZbwM0DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412093; c=relaxed/simple;
	bh=Y9qVJi8Zxhozv5BUgSDvu5gJYLHngE/B+7jS5Ram6E4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rixUXfwkmGFpp9yy+KdojnABKoylzpvEonN6gtxWk7WsodKu0Kay24V7Z+odEsty7NdfQmWCN+HIkY+rpkS1w49fZnYcqE7SowUPCsTL1FLuIPp9BBvqkSUmT7K5aaxnsUZOBpLNFzWgkhIX9LtOyXarLpVWH28rKwKd0CO6ZK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gcvEvgQ3; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724412091; x=1755948091;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y9qVJi8Zxhozv5BUgSDvu5gJYLHngE/B+7jS5Ram6E4=;
  b=gcvEvgQ3CZyKmJzBGRq3cBYdTmnhnQk+E4pM+TZ8Hg1c1S1F7CZR9T1o
   8i3waCrRNfQQYakXAbOXbgfuzqLy8SiB2B2wyvFPWgBIie4z0hr5/olXc
   RNd7buSO0U65Atjgug9Zwbhm8GSH48AzEuTi76wz3zmO4fgUBkw19KxpC
   jY1ZgLf4tDAbB7t8kkCf9uuIKfjW4/TGLqHzDeNSyCAP8TMzcxm2ra3bz
   PMNYsHLHI3Q+7vYIIzIiIkiNVxZ8X8p4w+VAO2wzwhZqwfAhqxnYoaURt
   e5Zk+qA38koxKOSSOqUU7XmYxQuY5RLu6a+mbHWf/QaOlbVHlRnUVi3Rl
   w==;
X-CSE-ConnectionGUID: fBRlZ7BhSlCSsycyKxDgOw==
X-CSE-MsgGUID: qG04Ar/cSru1eI7AZO4xbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="45396191"
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="45396191"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 04:21:31 -0700
X-CSE-ConnectionGUID: 3gu0BtXDT3mQpS6F28Vyeg==
X-CSE-MsgGUID: x3g1ddJuRbWhgn1D3g7egA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,170,1719903600"; 
   d="scan'208";a="61774736"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Aug 2024 04:21:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 04:21:29 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 23 Aug 2024 04:21:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 23 Aug 2024 04:21:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 23 Aug 2024 04:21:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3vNCFxDo2Z3AxaE+EuL9iXG5Jrp3+BpYURl0hIGJU+mU/ELLB5DKY3LTkzNvj3lG4l06WlPl3FOTurpTv0MU5teQsduYRgWSFTDxnSUajnDZwEiplauW+0h4e/HrWdxJBf/ikzhZsOt8QgaCS+H4viKhRG83cxS6NRJZremRYK3PZb6tJhX4zOGkcWNJvivCgQEKU5ZmDMMfeWrGhx4mfH6fNhUCfkp7ynVu3u7RTxyd0i/0uMoQys20rrxUi7YKfM/MBBDLPEBKgLzsIDxfWpEeTHxMTmyv06TB3IKCbH/CVUG0ybgdmDaczuft0fs6hWdMTlJwx4HT7jP2ra/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DVdRwD1n/aNfz8Ma4rAOTdWw6KnQHvFcHttmO5M6VTo=;
 b=JibSIZ5nuVDjG29JBMWAdqa0ZaYVMD2e936S2Rib90fRTa98rsv9FUXVPhdNOhBBFXbwa8/RYKaLcJfEYLqg0175/g3vSVLPnTB1fHiTSCyZtuAspDuFRen7/wh6bDSz0FDbL5iEiO7KSsIk20+Lro7FutNStlE83tb4L1tLtwAx3B0s2mV8Q7iGoiF5HceOJa2hXWN/AgkP9lcZLwdmGNE085zWtnmS2K3Np4P4Nc1QrF7HGSD+1rNCEJGd1kXtqckl0m8pEErj9fiJVeBSq22kC/1tAVeb+uwZl2NaMQPAkaoHkPe30jB1yYWcUMOavPYGYUEQ9RTr3HnTqzHdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4920.namprd11.prod.outlook.com (2603:10b6:510:41::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.16; Fri, 23 Aug 2024 11:21:25 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 11:21:24 +0000
Date: Fri, 23 Aug 2024 13:21:16 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, "Jacob
 Keller" <jacob.e.keller@intel.com>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <magnus.karlsson@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Wojciech Drewek <wojciech.drewek@intel.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>, <przemyslaw.kitszel@intel.com>,
	<anirudh.venkataramanan@intel.com>, <sridhar.samudrala@intel.com>, "Chandan
 Kumar Rout" <chandanx.rout@intel.com>
Subject: Re: [PATCH iwl-net v4 2/6] ice: protect XDP configuration with a
 mutex
Message-ID: <ZshwrM9FrhbNQimz@boxer>
References: <20240823095933.17922-1-larysa.zaremba@intel.com>
 <20240823095933.17922-3-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240823095933.17922-3-larysa.zaremba@intel.com>
X-ClientProxiedBy: ZR0P278CA0002.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::12) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4920:EE_
X-MS-Office365-Filtering-Correlation-Id: c2fb9b62-a583-4e97-9bfb-08dcc365b94e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1xaiDpCW9rdJaJa32otkXaLDOkemWmee86Eg7dIiOy81xes3txXiZWtj/Y3l?=
 =?us-ascii?Q?DshG8mfBMDIodFxWI3jTt58m+nTYLlClNXZ7+V7nimHulfVzuEaJBkF0/J95?=
 =?us-ascii?Q?7HSj1DXoj3nc91w24iCx3voYpDFP0/dQO+tMk0DcFI+oxWWh8tH1Se8xq7FW?=
 =?us-ascii?Q?GQUtfhWtf7WjndBqIDy2IagYyJRz8mkGBFeJKf0sTZLUf2rSssMjTz49fohV?=
 =?us-ascii?Q?OymbZCbItfR3Bki66FmuY1Kt5kcGnKadPf9yvelDnfEVZ0ae4GM4rIhA61tQ?=
 =?us-ascii?Q?F+cAovGjbaK4BUAwSDIJ+FipJuoM7ojRn/4DJdUjBNHhpqrpk5IEogTS8MzH?=
 =?us-ascii?Q?GoCJHnAqSq8sx0h6ogg1n7lVNkzqe38Yg+PNQL0LiBsBrvhL56mTsnxZCo2X?=
 =?us-ascii?Q?HL+CoQrsh477CbCYrfoCp+O5QTGKvn+RwsoUc43HxjZIA+JoL1D3zWH0Ae7O?=
 =?us-ascii?Q?quiBTlQFiB90Sib+zaLEICE6mYVq2we++2NI2hcQ9mH02qqWdZGKSn82uh+F?=
 =?us-ascii?Q?UOvlOQksGNaG3ACWa49YZ28nD6X3vRNNFL26RnIiCYLwZlfYEUU/OHDZPyW1?=
 =?us-ascii?Q?BNk3RRGXNm6mwPCdkV5mSjbhZSZ6rtCP0XliB2Qng4w0NiyxLYEWxkHIFZ5L?=
 =?us-ascii?Q?XPko9QXnPJWzbEzwbD9uGlTBwOZbq/vPq8YkoWLAuINTSmUrvX64RhrcQS7c?=
 =?us-ascii?Q?gMwZFClVz+BTN3Xg8iNvJmbu5m+vloJYN68bpvRavUciObyw2wUKPF90b8lO?=
 =?us-ascii?Q?WbXEjiUDMMJZ+3VCEeh0zGQa3ggp51MMxAGzwzEBhnSpuxmTGh1C3G3cgmP7?=
 =?us-ascii?Q?oBAMC2PGHV3lBLJiDRzpa9BZ7QfYApGgKpE/Un32ztW6sGYXrUsvl7X6qV1T?=
 =?us-ascii?Q?5E28xSVmsg7D5drOIkIldrqJQtrd7IPW+54brxo8I09jFXKeeER4Y+aoIhAI?=
 =?us-ascii?Q?DM3Uor+9yP4XQoC9Cypu6/G410Gs9UMtEn/NxJtosYyNYUQzymzuLZa9rdEw?=
 =?us-ascii?Q?VkY0xGddmZBti2HI879oIsn83T4HLtKSXE1t5eQBu4sHxrYX2A3yKkYmmKVC?=
 =?us-ascii?Q?HO8lnLQdvZho4ZyGlLIgCf7RR/WXhx80hMohGD2S6bpZ2Ut/7gTze0AALlzm?=
 =?us-ascii?Q?k1OfO3TcZQfVh+4PPdZVgRPP1ytcg9o77yM/nZotonoSjwmKPCUVFwJb8IRc?=
 =?us-ascii?Q?VTgUtiBiJ6TSytFtDf/aiVmqO+5blM6g7/PN3m/q4q2TceuvgaG5lCL0Fa0H?=
 =?us-ascii?Q?HVq+07cep+/mqQGewjFrO5+uGGeKWhXQ6igVUVmGWRqnW0Iqsk5h6lhjkw52?=
 =?us-ascii?Q?yoGXO1oPyNIl/uW/YyYEd6sQHkEmPEBl9B4VLBLdvkQPtA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KhzyIsIqH95cyphaMLGfsicluhrr+05ys71DlPW9PjaV99H9M9ccIU3Tk4Ge?=
 =?us-ascii?Q?KANOor9csUVYprDdeFb8do2HKqJh7MJFKLivRnfASxxRGqmxOxV+a/Qg507o?=
 =?us-ascii?Q?rQN0astnzkAvcVWcPdxv/bsanK4ZO5ZBZYCPXLArtNOH8txBORZa0XnA44O2?=
 =?us-ascii?Q?IE90hjoRK+km5dLsHwhy//H+zdAk4/WmCkJmuKZFeJDJY+zsN1xgXYwiSn+v?=
 =?us-ascii?Q?yT4aJ5ThzfT4ObrkTcfawPuoPpMO4CHXXcFIZDnk+noQyBiRfC31ZdA7oj3w?=
 =?us-ascii?Q?RoK+rtaecVKA2FK9IWHNaTQKcZ8CUPezMQ3rvikV39vlP10XnQuS8OjEfXWK?=
 =?us-ascii?Q?IytoixNUBk9EeopxV95KxPOpuY2QfSJ70UeU63bUaSb/20vyy5m0+4A7j2xz?=
 =?us-ascii?Q?rqzluS4DRs/XTRKnHgK7MXWzCWNt/nwAO6axJ6yV3yc6oAG+bwBCL5kcTz1r?=
 =?us-ascii?Q?ZMZ6krRYBNL9KEtkrWJQahBM0JOpWOnoGzSAm+ROxvK3gMpaUxFtUjlbtr6J?=
 =?us-ascii?Q?dCg2RDNaSQgbbZYYai9A5B5nvbZiTgPP3L7ynAZYi3SgXrblQ9W4SuCtsmAo?=
 =?us-ascii?Q?g2t8P2PbQmhFIYtsBad2up5AfrwucIzsltiIFC7Aau4sdcZ2al9W+Hk5CL76?=
 =?us-ascii?Q?/e+bnkqiyIofeFjBhmzVz7FjWGnyxtG0Z2Lu0WGS1AWspUcegfoB/ppbozYU?=
 =?us-ascii?Q?sU0lX5URpdKHdFQq1F+hRMwlMxyBWSbKY35DJER5dmtKJ2iMVK5jQblaUK0Y?=
 =?us-ascii?Q?fJefLswP4eX+RA9KH5klb11r8WsPDbeXQ7SH0C4sFVtdsdsdAfTHl1gidjA8?=
 =?us-ascii?Q?7IBlX8NdO++zJl9sei3d556IEnHlNGQSmH2TBIDVnH4J8LybP4Gru6J9Tdln?=
 =?us-ascii?Q?NDq68NWSg063m0ENOPyKGC24By0x4i5SL6/rUURpk8ODH99ryP3F3Zt4X8dU?=
 =?us-ascii?Q?Zg6d+M/KyhaaERzCBbq4yweWzjdnck9Ms8spusyOL+u45ek6tExwLPkYfgkA?=
 =?us-ascii?Q?+i6Fj7fRwcFKmBhjQ5g6RJkqfnbGKbDhSYUnhjjX/7RK1tGflKEiDYPI5HnO?=
 =?us-ascii?Q?+PkIJHUJV87K+J/cWzc78zWMrsx3r8JNs14lryhkPf8uGVR7d/YNDbBQZ7q0?=
 =?us-ascii?Q?bh/h7qMIy8YN3qnXLQpnNYEXv+V8TRhAU+OE2Nt4Tx0xyo6nO06RfFZdzUpv?=
 =?us-ascii?Q?ohEJCPf6dT6HHTiyfSVD2mxUGvPM/HCUCeFHry0iOCWfwg+VCWgJRoj3OXAL?=
 =?us-ascii?Q?tlrGNc3VBDUY74rTLWeDPpgXROOvbDF2ycFxNlySAxq6hCLrScINweGClBvr?=
 =?us-ascii?Q?oRqqNvX6Vqs5ZdVIekca6vk57y9Q5118vU+DoFMrSez88esngaWnmy82fGOn?=
 =?us-ascii?Q?kibVZF4iTZGqvZhsnL8hGxGU2sfyrKKKJ61yQ2CFfJq6J/jzRl4Wqn8ncXlh?=
 =?us-ascii?Q?wgosP+RHM6qBvk1PNWKpGBmCssbEi8gB2JNjLqjTOyYx9cbVqupj472Hxe8K?=
 =?us-ascii?Q?mTPG8PPYyQBx1H+j9OrvbMd7E2591S3G4/dVaF7OKCAj0t+kcivH5k3RHwZJ?=
 =?us-ascii?Q?RULL5A/6Ybu2ofc0oMR9lBLhN+k/zouBHmO9ZQX2f2bpMGRCtdBDVR/vGNyy?=
 =?us-ascii?Q?Ow=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2fb9b62-a583-4e97-9bfb-08dcc365b94e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 11:21:24.9062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7gP8EowefnQzrRjvXWPtCIfew6gfShBitFApFVze5ZRBiwZqS8EBcuh9jGBAQJDt/w/EhlD5e14FBruW/9hlTDdOe5t7yTxRi49Dh6e/rLo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4920
X-OriginatorOrg: intel.com

On Fri, Aug 23, 2024 at 11:59:27AM +0200, Larysa Zaremba wrote:
> The main threat to data consistency in ice_xdp() is a possible asynchronous
> PF reset. It can be triggered by a user or by TX timeout handler.
> 
> XDP setup and PF reset code access the same resources in the following
> sections:
> * ice_vsi_close() in ice_prepare_for_reset() - already rtnl-locked
> * ice_vsi_rebuild() for the PF VSI - not protected
> * ice_vsi_open() - already rtnl-locked
> 
> With an unfortunate timing, such accesses can result in a crash such as the
> one below:
> 
> [ +1.999878] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 14
> [ +2.002992] ice 0000:b1:00.0: Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring 18
> [Mar15 18:17] ice 0000:b1:00.0 ens801f0np0: NETDEV WATCHDOG: CPU: 38: transmit queue 14 timed out 80692736 ms
> [ +0.000093] ice 0000:b1:00.0 ens801f0np0: tx_timeout: VSI_num: 6, Q 14, NTC: 0x0, HW_HEAD: 0x0, NTU: 0x0, INT: 0x4000001
> [ +0.000012] ice 0000:b1:00.0 ens801f0np0: tx_timeout recovery level 1, txqueue 14
> [ +0.394718] ice 0000:b1:00.0: PTP reset successful
> [ +0.006184] BUG: kernel NULL pointer dereference, address: 0000000000000098
> [ +0.000045] #PF: supervisor read access in kernel mode
> [ +0.000023] #PF: error_code(0x0000) - not-present page
> [ +0.000023] PGD 0 P4D 0
> [ +0.000018] Oops: 0000 [#1] PREEMPT SMP NOPTI
> [ +0.000023] CPU: 38 PID: 7540 Comm: kworker/38:1 Not tainted 6.8.0-rc7 #1
> [ +0.000031] Hardware name: Intel Corporation S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0014.082620210524 08/26/2021
> [ +0.000036] Workqueue: ice ice_service_task [ice]
> [ +0.000183] RIP: 0010:ice_clean_tx_ring+0xa/0xd0 [ice]
> [...]
> [ +0.000013] Call Trace:
> [ +0.000016] <TASK>
> [ +0.000014] ? __die+0x1f/0x70
> [ +0.000029] ? page_fault_oops+0x171/0x4f0
> [ +0.000029] ? schedule+0x3b/0xd0
> [ +0.000027] ? exc_page_fault+0x7b/0x180
> [ +0.000022] ? asm_exc_page_fault+0x22/0x30
> [ +0.000031] ? ice_clean_tx_ring+0xa/0xd0 [ice]
> [ +0.000194] ice_free_tx_ring+0xe/0x60 [ice]
> [ +0.000186] ice_destroy_xdp_rings+0x157/0x310 [ice]
> [ +0.000151] ice_vsi_decfg+0x53/0xe0 [ice]
> [ +0.000180] ice_vsi_rebuild+0x239/0x540 [ice]
> [ +0.000186] ice_vsi_rebuild_by_type+0x76/0x180 [ice]
> [ +0.000145] ice_rebuild+0x18c/0x840 [ice]
> [ +0.000145] ? delay_tsc+0x4a/0xc0
> [ +0.000022] ? delay_tsc+0x92/0xc0
> [ +0.000020] ice_do_reset+0x140/0x180 [ice]
> [ +0.000886] ice_service_task+0x404/0x1030 [ice]
> [ +0.000824] process_one_work+0x171/0x340
> [ +0.000685] worker_thread+0x277/0x3a0
> [ +0.000675] ? preempt_count_add+0x6a/0xa0
> [ +0.000677] ? _raw_spin_lock_irqsave+0x23/0x50
> [ +0.000679] ? __pfx_worker_thread+0x10/0x10
> [ +0.000653] kthread+0xf0/0x120
> [ +0.000635] ? __pfx_kthread+0x10/0x10
> [ +0.000616] ret_from_fork+0x2d/0x50
> [ +0.000612] ? __pfx_kthread+0x10/0x10
> [ +0.000604] ret_from_fork_asm+0x1b/0x30
> [ +0.000604] </TASK>
> 
> The previous way of handling this through returning -EBUSY is not viable,
> particularly when destroying AF_XDP socket, because the kernel proceeds
> with removal anyway.
> 
> There is plenty of code between those calls and there is no need to create
> a large critical section that covers all of them, same as there is no need
> to protect ice_vsi_rebuild() with rtnl_lock().
> 
> Add xdp_state_lock mutex to protect ice_vsi_rebuild() and ice_xdp().
> 
> Leaving unprotected sections in between would result in two states that
> have to be considered:
> 1. when the VSI is closed, but not yet rebuild
> 2. when VSI is already rebuild, but not yet open
> 
> The latter case is actually already handled through !netif_running() case,
> we just need to adjust flag checking a little. The former one is not as
> trivial, because between ice_vsi_close() and ice_vsi_rebuild(), a lot of
> hardware interaction happens, this can make adding/deleting rings exit
> with an error. Luckily, VSI rebuild is pending and can apply new
> configuration for us in a managed fashion.
> 
> Therefore, add an additional VSI state flag ICE_VSI_REBUILD_PENDING to
> indicate that ice_xdp() can just hot-swap the program.
> 
> Also, as ice_vsi_rebuild() flow is touched in this patch, make it more
> consistent by deconfiguring VSI when coalesce allocation fails.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---

