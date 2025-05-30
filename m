Return-Path: <bpf+bounces-59346-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BD2AC8D18
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 13:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0467E7AE192
	for <lists+bpf@lfdr.de>; Fri, 30 May 2025 11:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D6522A7E6;
	Fri, 30 May 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WaTPlf9H"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DDF224AFE;
	Fri, 30 May 2025 11:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748605583; cv=fail; b=QVmz+axRL7bL8B3DohgmjREY0kh/bzz5o/YmRRiX/kiizFBcLpzaFEMggmpYZKYRQJC3FPQewjUho2NwQCaVgM9LFiILwVsQ1QBPqNmVl4BWVLDjpHGrvEJEP2aARk/I/bGfnHi4qPYl1TRIU2c/NIjilyFg5yljobjtqEXxLrM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748605583; c=relaxed/simple;
	bh=cRNEWTthpcWdfkRQgCdXXoyGMV4R7PfOLXSjjdDRGoM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fow/4TaV5gjAR/GWPvq1JKbzEhgHClnS7+9wYkMqt6TZcszCrgWMiIbP888kr+uRIfyHh74O2Pa87GMfsfU9dvupShkTmfLVcDaa+38INr7Aj99/SNd1JZbT6EDPqNkx84xsiTB3vcJcVBl6o0V3P/YwlAl8nSkJcYMC4/Y6i5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WaTPlf9H; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748605581; x=1780141581;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cRNEWTthpcWdfkRQgCdXXoyGMV4R7PfOLXSjjdDRGoM=;
  b=WaTPlf9HVsavrcitUZzEgDkrmyUa2M0hus9FYJTW/NE+w4yAfdKUrtA+
   VzWBNHvn8UHDbGZkSKmqCAxbntNVVC60mi05CIZiH4t1v8Hc2Ag+/3J17
   ryQmI0Hmb4GzP0X/KTurN5dzwNLpXMp8/N1B7IYk3FmMxQJfF4Hh9ELlM
   468sDrcjOqGuI1x+4kZ+rFumPehnPJD+Jq8OtrSAWXGaqq+dT0tbsYju4
   OW9XYORWtTQWIKTv0D8KFdB+QqakBkQlUGIjIOLysUs2hCVk6/NVOR0Td
   xsLwt9O5PZVSWROAztgYHnzIOOo2MFTQYsRUhltDuRwVXYcHjq3LQZrxD
   Q==;
X-CSE-ConnectionGUID: XtghM+GVRW6tTHtMLz+0DQ==
X-CSE-MsgGUID: oVGYUBOqTEiIHQQVyw/Qqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="50700234"
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="50700234"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:46:20 -0700
X-CSE-ConnectionGUID: IMOa0zW2Tn6+GHxekeR3Dg==
X-CSE-MsgGUID: HjC1S5p0QhSIII72O4rCjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,195,1744095600"; 
   d="scan'208";a="143773923"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 04:46:21 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 30 May 2025 04:46:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 30 May 2025 04:46:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.44)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 30 May 2025 04:46:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LnqjaUzWqx+U03OcSqnBBfsd+0cuWsrmGthP9NAfppESyWfOHYNIhU6hBB0ll+Bqr48VehAWjuyV97n9b1ltcEnhMYiafbRxplgnAG5Ya8TPtH0nIOIIj03/KMgrBNJuyi2qFXBSq9aFFLUMUWhFGTLhkrv+v7SyQTArZtzkPv6uFQ02eFSEyDtEypMqVPCKEVHmc8GSWa18i2H+3FrDhRefgAWjJWfr2pZOkm3TLWBZytTDUoftR0v9jrAmgD+h9lPCKy6gWaOWHhMeb8dRE7AZJt+6ULEi+JtBQWuVGG7zBV9Y8b3ic21MSM4tMFRwkQaFIQtawlB5T/zuawJeVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYzdxTuwznrcXGqiaLXGomc0CDgKCHduDANXb/o6VrQ=;
 b=BYlLCPVYjFWuOCfjbsUsc7aYYcs0/0Nm/DDwZrcAaC6VY2s0cSyOcgYypsLlLLcyT7+Q4Iki9wMLWATDMjKbudheqjuq1fkN4zbhbAZaGMfHevSbZvnNo3pWcfr3S4GksiWkEmU2O4P7dRH0b9Axgjn5m+casyuF5BBPukNgfWTVMwdIogp4VFl7HjWyzSpRPPM8NNctiI835rccGKso3eNCaB12sZHeNrJzMD1wbCeeE2EdjLvv9l+9MIq1rVzKeJJaqoBQ+a3dR8zgvnTYTb8993s9XGvlZhj4lL36qtc6QP604yEsWE2qlsFtwOGFHKHo4TOHrxz6dlMHTg1G8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DM6PR11MB4513.namprd11.prod.outlook.com (2603:10b6:5:2a2::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.29; Fri, 30 May 2025 11:45:35 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8769.022; Fri, 30 May 2025
 11:45:35 +0000
Date: Fri, 30 May 2025 13:45:19 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
CC: <netdev@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, "Jason
 Wang" <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio
 =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, <virtualization@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [RFC PATCH net-next v2 2/2] selftests: net: add XDP socket tests
 for virtio-net
Message-ID: <aDmaT1cmoRa6PaqK@boxer>
References: <20250527161904.75259-1-minhquangbui99@gmail.com>
 <20250527161904.75259-3-minhquangbui99@gmail.com>
 <aDhCfxHo3M5dxlpH@boxer>
 <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fe162eed-fd44-4c18-a541-8243ccfc4252@gmail.com>
X-ClientProxiedBy: DB3PR06CA0024.eurprd06.prod.outlook.com (2603:10a6:8:1::37)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DM6PR11MB4513:EE_
X-MS-Office365-Filtering-Correlation-Id: 527914e8-c488-45c0-9869-08dd9f6f7d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?G2EqLXb2c3yq4+d2P0f2pI9nOhe6xUWr9NsWuGBdu/XpCAdilI/KBIT6IMLd?=
 =?us-ascii?Q?MsL0EoTHSwGm4y2juJFdYRdnCsb9YZg/OoLmZVdNg+S9B3Ur7f/VzO52IV5P?=
 =?us-ascii?Q?QG2YYlM5aNkbLKoc7hmV3D3Dceq2Run1ly8qVG4EYqUjZELXibUBFxEJE9kE?=
 =?us-ascii?Q?2AJN0XzqJZL0xT5UDRQQw6odkBBA0jrUg8epHrwlqxfUm8Yaxxy83AZYG/iv?=
 =?us-ascii?Q?LYTy5UQKfZ4s+dnvWgNvP17BQVyMt3a4ZdLbEs4yXU556TKbQkI9kQQatuF+?=
 =?us-ascii?Q?TEG0hcuiBXoBrF70p1Wf6q3lfKObIt2GVFe0S01Wp/qibHkzZZX+vGyAlXvb?=
 =?us-ascii?Q?vqWETlfVmBLuqV2hZZRO+cBV3+2cXM4BTEMElqAgGKxDGmXwLJiVgWF70k42?=
 =?us-ascii?Q?TjVNqLp+e0ZcY6NvZ3nrS6rkTRyeRjeL178+kRe/IB15TTmaloBycLVV+YRn?=
 =?us-ascii?Q?ENgJC+zz6GvVtfIEvjZYu7mtb3MsLxSbXdFNVgcb6jMSZ/zaYjfIy30W5ECc?=
 =?us-ascii?Q?S5Z2vn2o5KnZ5fKblTjq3OTNmTw4nV5CGWXYiD1bZuZGpByq3kXh92ST0hDZ?=
 =?us-ascii?Q?lzmgO+zy8NMI/v84+qHQunTtMir1GDHE1bxMLzFXXFxkG+7atFLQDjE4nwcX?=
 =?us-ascii?Q?wWdT02Kqt6K34Er41lbEB3Ub73woICNUDXsGIED17C9IutiIue3Jcylrmknm?=
 =?us-ascii?Q?DTHKIHhWaXjlP3tBMG9oxge8a3YOWek9RgzYj2/v/BvWWIikL7fBifjdjTUz?=
 =?us-ascii?Q?vbuWaYQexkdDgyesuSsrkUPMWVtYxUKWT9pam/U8QSlRM0278VSAysvIAKWL?=
 =?us-ascii?Q?srsunRDhpMwZpyO8bDUMKecdQQAGn37/nIILhl5FRvmTG97aYKhxOQvyBE0e?=
 =?us-ascii?Q?UFAO8KOhCZknU6FXDNKoNjVPQtJTP72jegp+tWLyNOvfQOdDX0jINfmlvRkJ?=
 =?us-ascii?Q?eKaj/gvjAg58hr9mTFKIJ5NF3dMfHz/FnSapL/Rpjt8+IE4zalQeh7cOsZ/Y?=
 =?us-ascii?Q?IDyOabNXFbGn618zoQ2lKPVGP/FjAEy5LjRjtgMctpz2UMYgAZrLQpS9nEAa?=
 =?us-ascii?Q?njT+wLB7m/qMGLdUTAOdtZvm1Mle5HT6GAp+5+zgZEvpzuuyqnpew4lSMUwg?=
 =?us-ascii?Q?mQUW1EVK7kILp/zkdze0Im9//g9PJ6iLeSMscYjHEF8O5f5JZ1AjxcYY1zbi?=
 =?us-ascii?Q?0B74zrmQQyj5PNnELGOAz+e68CFzgVqsj3lJBrAhy4fRzQXcxyTGAFlmTD0G?=
 =?us-ascii?Q?CAG1gHSaGKFnBJJA5bYy0ng5RZTXveHLPhTx04bzw9cHDj8LCvZko6VzgnqP?=
 =?us-ascii?Q?mYDP+fHqJYZKOSSlUs7+H7MnuTkp2rPZM4YANW0GKmP4BwlIqD6I3irfDI3f?=
 =?us-ascii?Q?DMVfIK+PFiK18wL1hHLj2l6qYgGjPj/qZA9nG6Jk0pmGfl5ipRbekVVtgwrq?=
 =?us-ascii?Q?71AG+GYrBqw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3kaoLdSV9W5XupdQvl3fDPvj0UadbbBvMWeUj2cA2nzBJAq7TfmyAtJQcp5Q?=
 =?us-ascii?Q?uAlPyu+i8x67ArVP7baaOS2DwvrhOEnrUxQdHq5bPsFECHQo4z81H3SvWGsL?=
 =?us-ascii?Q?/ilcZtPmlcv5O79bJ4XF1DrbJ+61BIt2vfRzohh8wPW3+HLTuy21scUyPo0K?=
 =?us-ascii?Q?cMshibXo5VCI9TDG1Dj8f/Ihq8FsFuj3GYXTBh+6VgFe0l8VPFhbP4hgouYX?=
 =?us-ascii?Q?g/NXfW0Mw48pUzzmShsVk0gHldbk4iCs1PoelWCgsWrozA5aq5w+AE3ss9JM?=
 =?us-ascii?Q?69X1OHcWjtewmKuOOu6iIVLRYz9e3ZHENHFe7VJFnnvWsXspWH+Bl2gQFvIE?=
 =?us-ascii?Q?2BZ7ZFPC/ddJ6X4Qk/taoMBkwclYZGZ760cIkEKUn07pzthwipgxU9NAvekX?=
 =?us-ascii?Q?Vh8bO15S60gFvSP+sNug+SKGjf+N6/4C4rycUTk5IfTX6UJGz1ZZMGA62khd?=
 =?us-ascii?Q?7CP26tM6ttS0FJIqUd79TwU2dItLTXHVPg8cp6rqn9xMJSVIaBdGCfXwtLUF?=
 =?us-ascii?Q?9Wntx3p6ewC/BVSxe8S2VajU7b1CQOHLcRWkAZxUfI3NVAEWvFCX/tzCgL+0?=
 =?us-ascii?Q?+BF9nzzSq6SJ2d4NKDERLDXTy1acWocYEk49IFkH3BtTekzhH8q3AFnUfx2S?=
 =?us-ascii?Q?osssVP8V+gnIkjaGtjmGWgFe7t+Bqori3lIz99GQiA78Rsg8OajICG4ldUXA?=
 =?us-ascii?Q?rhsqPVIBIvsjJL7ASK8YcHTh8GsYrig2wOFhe36YB8CkeI8/unRzEQnA/7fA?=
 =?us-ascii?Q?Bt5yjx55cSvUM/Dn3DgX/RZPRvT7S6E2VM2ZHRx19qtFqLSbyP7urv13WF3p?=
 =?us-ascii?Q?JtqocDF8zpBJ4wNPrGbh93uTXS4o9Xiayvrb8ci64gQVidUkzlBuFay+iRF1?=
 =?us-ascii?Q?sP4qEIyzb1e7V3Ql8nbTPu7SvYwJNQJDS8R7957Z4F8IdiSF69mXMLj9FsAK?=
 =?us-ascii?Q?v5wE1grFB4/OMdpWwxUO8dqsTRHFD9IhmaDZbHzzApFDlGsxPHfs6r6SAips?=
 =?us-ascii?Q?gCix19ffs+L0VkdV8lreuJXVZsX7/czOywTciaWgXY2+Awv47IEMQnr2Yohp?=
 =?us-ascii?Q?NU/5xB8PoZ/6yUhMdRcloYD20dySbaeNtc5vW7kSKfg5Gr0lOmYkX4Y2YTj4?=
 =?us-ascii?Q?XRQnul6o1NWV/HuSy/9H3yYKSXTqSvGqhpeIAo7FyThXTU3dFLReKUOWQDoX?=
 =?us-ascii?Q?sCS3xYjkj+m9Swq+Vb26QRmAV3dYeSfprD+lC/g5VrzpU4IhvU38h06J6xkP?=
 =?us-ascii?Q?tnVyKc4e8cjscOcgMDJWnnyUjzLmvVzYhOH/OsBMuzRDiz0UGmNOCB9iFbFr?=
 =?us-ascii?Q?NzPo28VwewYsO9AMS5PBtHVoYk439lemtaaqYWbcWSzmcLyoWy7AM2dZ/Xks?=
 =?us-ascii?Q?v236ntKNxPaRRvL0gWP0D/k+s93qVC1KGw43pRK618NwQkG81oHW5wnFCWqR?=
 =?us-ascii?Q?mK00gASpQmTr5YyjvUGxmyynWie9eB+VRVxBZqNDbekz8a5H0MzR8hpTKHW8?=
 =?us-ascii?Q?mPPQ70gkkBXSb5fbLqA3YgjclFSg37Fxg2sqb7ahFvgD6SMCF9NFG5xG/CiS?=
 =?us-ascii?Q?Qqb675nXDdXbjKaSSf6SN6ARlp5oh7rL7Z1p201BjCTP4+khZO1TfojX3S9D?=
 =?us-ascii?Q?5w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 527914e8-c488-45c0-9869-08dd9f6f7d63
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 11:45:35.1448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57MOgBRMOR0xQfB5naJTiOiaRm4yU84HviG3FCMJ3oKePwSTz9ki/l1EyOdt9m7p9vBGtpL/ZVwirSYshFAvb5hBVhwgeAjy505aXce+N0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4513
X-OriginatorOrg: intel.com

On Thu, May 29, 2025 at 09:29:14PM +0700, Bui Quang Minh wrote:
> On 5/29/25 18:18, Maciej Fijalkowski wrote:
> > On Tue, May 27, 2025 at 11:19:04PM +0700, Bui Quang Minh wrote:
> > > This adds a test to test the virtio-net rx when there is a XDP socket
> > > bound to it. There are tests for both copy mode and zerocopy mode, both
> > > cases when XDP program returns XDP_PASS and XDP_REDIRECT to a XDP socket.
> > > 
> > > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > Hi Bui,
> > 
> > have you considered adjusting xskxceiver for your needs? If yes and you
> > decided to go with another test app then what were the issues around it?
> > 
> > This is yet another approach for xsk testing where we already have a
> > test framework.
> 
> Hi,
> 
> I haven't tried much hard to adapt xskxceiver. I did have a look at
> xskxceiver but I felt the supported topology is not suitable for my need. To
> test the receiving side in virtio-net, I use Qemu to set up virtio-net in
> the guest and vhost-net in the host side. The sending side is in the host
> and the receiving is in the guest so I can't figure out how to do that with
> xskxceiver.

I see - couldn't the python side be executing xdpsock then instead of your
own app?

I wouldn't like to end up with several xsk tools for testing data path on
different environments.

> 
> Thanks,
> Quang Minh.
> 
> > 

