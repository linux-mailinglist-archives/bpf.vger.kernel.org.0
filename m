Return-Path: <bpf+bounces-61813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427CAEDB8B
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 13:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 405DC7A7614
	for <lists+bpf@lfdr.de>; Mon, 30 Jun 2025 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220C027F16D;
	Mon, 30 Jun 2025 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZ+egiPW"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9C27F012;
	Mon, 30 Jun 2025 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751284033; cv=fail; b=p0S6rsfe8dxUlG9A7czgiG213tbEJnkgTyVJVDGZ/T8sYrPoF7fRSICwmNAT6alch+IeZxP5aOJLkshaaiI6BtywNmtB6fs30T7hDLjf90SzvP2xqbpuDbs0ZW952jmCDXNjA60zEGJPCLiHHHK4CDfhyPv1HDUrYtxqlDWim4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751284033; c=relaxed/simple;
	bh=HR4goAxdTwL1Cndsvh7L2mVkzmu6tfhuydgMmhBxcjA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S/Qf/f2TYEq5pBhAqbK33v1eG8KuKMZSkLS2+zpqz0O+1J8VCnK/EZsuUwHaY5HvYMvjiG1jb/330lXzq6Hy0/MQgfq+NjlNUvZYATZxb6DTlAneHQPsFFX1ZMGvsoiebwn+zw/JjTmUoxgRGqThL/TmB5JStieLwK/9X8r38xI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZ+egiPW; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751284032; x=1782820032;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=HR4goAxdTwL1Cndsvh7L2mVkzmu6tfhuydgMmhBxcjA=;
  b=MZ+egiPWdLuLSVKfl+VX9DOu/2TybLmFb88VMg4vxU8NmsmZ9TkN2wRb
   A9UJOb0F8OCRcz9s5h6JjEyOVtpbs49Wd9zqg9Gpu71b8YP1UbYxNDYG5
   HZxiv95bzpQq1YsgzysKSTdHi9i4mkJUUbjXXEmQ2dkqhv6pPsPSjQKBp
   6ReNzaWxaZ+aIJqdBLyu7BwFc/uNbVEHEMqRytOgAqxdndpgyOEkGU3pR
   cItbAcUGLCcb4GYcVpIROS7C3fZ8mb5ceriElJ6Mg8uYWLMa7y2JeJMgy
   KrHfC2vbdxA/Z2i95+T2egzLN6MGTyDyKSN3vJI6Q6QsZtnQeFoy88pNW
   g==;
X-CSE-ConnectionGUID: /ZdOhQQMTcKqlG11ZsI2bQ==
X-CSE-MsgGUID: 16rHEUPWR7yrz5Afmc9mGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="64102756"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="64102756"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:47:10 -0700
X-CSE-ConnectionGUID: 4mnj/EPeSXmUeZEnjAdylA==
X-CSE-MsgGUID: N1UbMDvqSpG/7p5PTkgNEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="184460182"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 04:47:10 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:47:09 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 30 Jun 2025 04:47:09 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.80)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 30 Jun 2025 04:47:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XIaQhwHC2FdXmyQAOUg+Rv5QpjH2kKzCuW9ZrTrfs+eEzKTq1u7Ccfh+819UkNYs71gEnYi/ax9cTw+XuEOBoQAK8A1V542ThuFXnhcaNP0rntZd+o5NPDrBw44Kd5aOsphH2T8J0DGm/FoH5yQVwma1xkc8DTYdNCSv1G4ZVCJh9RJiuHXkbVE0fWCGbo0HS9QSYwB12DVUrxmxRB5WmWtsf/GRrRpsNOYuL1vdVK8Sxx17xLQeqOZSPYCbYa+eAqEz2PXMeFakcSMnl4l4FFzA9dAWaniN9A8mxKVPfDx9DAIL4iv+hLbt/QZw0BAsDEuYqpQoVBIqkKOJpEojmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hKXeNHOQBalrH7Hi/KRxi/yJbRmoMVduqHaE5Pxtqo=;
 b=KvTY+g0qoo4oZWV4Ck5iML2YTVevMgSIWzPafKt6Rkajh8UU6gsZ6qJLsWHi3wkKjcfhWhVYqbs0XMagfTfuxOpWj5bDn1XmDDLe+G1cihfUNevsuK/ASmulLqs9qj4dKP0INwvM7V09VBhrXbhV5hsyVhcoxTcjaE/i/tq1EhloxhU/EM550N/zw9LQrgMMt6nGjQocuLxL4DXi3sfvksoDTzLjKuWrU9Og4C6/139h8lbHmz9HnyxmMaIX/qRBBf+oGN8XQh4pjzQ6TBZnqMVF154PmatzDrsBwNwngIIQo8JTpMOWdaU4KCMMsjHQQ67M1GGQ2Q1CsM9dzK8Wfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4663.namprd11.prod.outlook.com (2603:10b6:208:26f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.30; Mon, 30 Jun
 2025 11:46:27 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%2]) with mapi id 15.20.8880.024; Mon, 30 Jun 2025
 11:46:27 +0000
Date: Mon, 30 Jun 2025 13:46:20 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jason Xing <kerneljasonxing@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <bjorn@kernel.org>, <magnus.karlsson@intel.com>,
	<jonathan.lemon@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
	<joe@dama.to>, <willemdebruijn.kernel@gmail.com>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net-next v6] net: xsk: introduce XDP_MAX_TX_BUDGET
 set/getsockopt
Message-ID: <aGJ5DDtFAZ/IsE0B@boxer>
References: <20250627110121.73228-1-kerneljasonxing@gmail.com>
 <CAL+tcoCSd_LA8w9ov7+_sOWLt3EU1rcqK8Sa6UF5S-xgfAGPnA@mail.gmail.com>
 <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCCM+m6eJ1VNoeF2UMdFOhMjJ1z2FVUoMJk=js++hk0RQ@mail.gmail.com>
X-ClientProxiedBy: WA2P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4663:EE_
X-MS-Office365-Filtering-Correlation-Id: 09f6e908-846d-40ed-a549-08ddb7cbbf32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bWVud0VFbUlWd3RsQkF6OEpoRStPSERTU2d5SEowdU82UXB2eXZiWWFrclQv?=
 =?utf-8?B?SU4xRW9IQ0hST3hVQzI4TmM1cXFZNmpkbDh3N1BUNHNYeGdjSlZDak16ZFlU?=
 =?utf-8?B?dFdvbUNqcHZnc1NMK1FiZ0VmVnF3bEExclVNQ0J1dDhrS3U0dUpERG1zU3Iy?=
 =?utf-8?B?SnRvNnB4V3lZdUhmVG5jdTJoWlB1ZExFeWxHTmNrQUtzQ0ZSWEUxdVI1Y1dl?=
 =?utf-8?B?YnZDMkdRQnZPcFJFM1V1OGlVN1lML3lqSkJqL1NJMzRXNVBuN1J4VnE3ZDA1?=
 =?utf-8?B?M1VycDByRUlKajhSOEUyR3VsY0RmdlNwamxKdHRybFF1TDdFMDBxbXBtN0JG?=
 =?utf-8?B?Y0FOTEY4djQ3VU8rMmdoRk1HYnFSeFl1bERsSmF0dmJXVnJ1YThPRVhDaFBM?=
 =?utf-8?B?UjRsWm1CU1BpOGpFTkxobjNCczM4eVg5dTJhK3QrZkFXd3VEaWhNRTBCOGFa?=
 =?utf-8?B?VUlMdlg0ZmtUNVJsVkl4OWhBUXJqZjZOUFcxSzBNYmhOaWlTM2hsNTMzOC9i?=
 =?utf-8?B?dHlkWkNWb2VUa0pGeXJKaEZneTNZczRVZndVZlk3R1A5K1lFYm1KcklOK21h?=
 =?utf-8?B?YWkwM28vdGZkMFlXbDl6V01zYjQ1N2VLNCtlZEpIWDJGREY2TlZMVGl3SmdY?=
 =?utf-8?B?Vms0YW9ka0VEZWlLQ2dyTGpiN1IzK2prNFdPR1pIR3FYZGVWUkxtMXdzOXFO?=
 =?utf-8?B?aXEvSXN1WVY0UXdTMFJETThSek5VSXpvRXNGdjE1U3FGbWRsNE9pTzJ5K2xG?=
 =?utf-8?B?TDY0cm1YcHlsSTlId25Qci9GZjJHWVJaLzgyeHVyL0crblgveWVBSThZVUoz?=
 =?utf-8?B?R00zcEVkaTJIU2Q2VzNiMVU2NFlqWXVZaUdnUWtBQTlQaE1wTjNCb3JlYStj?=
 =?utf-8?B?SjlJNk1BcUxRS3FsWmNCLzIrMExiTCtEejlYNGFucy9UY1J5a0F3aCtxU2lN?=
 =?utf-8?B?MnZxQXFLMmw5VitEWm5mc3hrREpXaUU4VFVzdGg1OWg4cDhRd1lhblZwNWMw?=
 =?utf-8?B?WjFpMldCM3JDeUxBalpOa3NXZ0dtY2lFL2lDb29zbGxHbHZsSmhCaUh5UWF1?=
 =?utf-8?B?MjFJNXp4cXA5QUNTdk1GWldwRDIvMHNZdmtocFFaOHJITlRkTUJIUzR4SitY?=
 =?utf-8?B?aTFDbW4wSzJPY0lIdTRZTUFrbnRNSE93cU02N1JuYmZ1NWhGMkdrT0RUWkdU?=
 =?utf-8?B?Uk9oZUtDdFZXOFBPTzJzU1IzUFg5eFZ5RmxSSTNsK2lJanliR01tdFFDbkVI?=
 =?utf-8?B?L3kvVlo1YWs5bDRqWFoxRHlsblZSampaUEhvSUduRW85bkV1OTZKM0M5UktY?=
 =?utf-8?B?UnZYSitIR0VUdGdXcnFQYWJobDdzOXBVZSt3S0IvUkdwZDdNcjFyVGE4eWlR?=
 =?utf-8?B?NWVxSFQzMU5SRitVVStGWGJRUWxuSGVGWVlyMlpDczNpSE9aT3drcktHdGF3?=
 =?utf-8?B?YjFOYWdoazZFMFFNVHNpMkpCSjZtdmF4amI3Z0d4NGNvTDMyZUdkM0UzNEhq?=
 =?utf-8?B?czFNTGp1UUJFM3FXZ2ZHdW9VNEtSaXgzMFB6eU82dWl2Y2g1YXkyeGRxcHZU?=
 =?utf-8?B?NTdVWXUwc3REQlRnZnhYVFZVY2JoNFl1QW1kMEZpYkR5WnFmY0VjRkJXUTlW?=
 =?utf-8?B?eW1KeWM4UzlyMkJxbGZvQVJPMTd0ZXNldnVrSHg2azhqSDJhcU02dEVOcFJn?=
 =?utf-8?B?K1pXS1FqWWYvMDFNNEJ2TW14Ulg3WGs0V3VTMlBjMkFDUzI4cld0RXNjM2Jz?=
 =?utf-8?B?WWNkMEJOMWdQNXRRN00xaEpSd3BFVHZIZkFWYlpMc2N0SHY4N01lRTNEay9i?=
 =?utf-8?B?ZnNkc1VML05pdGkwNWlYdmd0TXZ2aE5kWGR0RnZzTllBWWN3OHlrU1p6NmpD?=
 =?utf-8?B?bDA3YWdIbXBvN2hkVWg5cDdVcmN0ZEJNTE1mb3NZa1FMSEttNDl0WXVHQUpC?=
 =?utf-8?Q?LeBYo8K+C0U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEVXa01weGRNV1AvTk5lRVFOYk9sR3BkT3dSNGlGSStmUlg0OTBJSWxWbnRD?=
 =?utf-8?B?N0c1dXZVdllZNEM5Qnk0RGlwZ25Zdk9tdXFncjA0L0xNN1RkUzdsTnowVXJL?=
 =?utf-8?B?UzNtNUxIS1VqYjE2QkZqZVZmUDBqQWhiS2FPbGNFZFlzaHNPZnY0QzVUWTVQ?=
 =?utf-8?B?WnN2MG84OGIxaG9GcUpmbDd3KzhaMFRNeFN0KzNnTUxrMmNNeWkzOENRL05a?=
 =?utf-8?B?ZmNOSkRvOS8vSFdyTVBtWE5ocHZVWEFLMXFXWktxbVA1UncvdFhsTTNyRXhF?=
 =?utf-8?B?eWlkSGk3VDdGRHF0NUN2Nmwra2hoUUxIekNBczNuemxpTThDbnJsNHlMZVRz?=
 =?utf-8?B?MTVGN2NjaEd0ZGxPalVJamRPRzE2NWhzZU9EWkJueStzMFFrd1hrZ2Y4U1pN?=
 =?utf-8?B?dFp2UGVETEprajVOOTVoYXpoMUFsSThhL1UrMncvTnpMYWw0MUNTdU1tVTFO?=
 =?utf-8?B?aDRDODhvc1JqSDZvcmxVdjRPbWk4dTl3enl3bzZrWUs2dUxtSERoUk9rcEVu?=
 =?utf-8?B?ejZSZis3dlg5NmwxbTVJZ0N2OFE1bmRLalBQVjkzd3BPVE9DVVN1UDFTczB6?=
 =?utf-8?B?TEd5TkdMQjdBMld4YmhKNDd1YkQ5aXdhMW9pTnVwNE4vcks5MUxjbTdydkEy?=
 =?utf-8?B?VnRBcGJTV2djWGdlTVdRaTVaZHJIazVlVkYxZlE1b1QzeGxLdjc3TXgzTXhy?=
 =?utf-8?B?bkJ5dk42K2EwcUZTR0lKQjFLOExnclRUcnhIdjNic2NDckdqcTFYQ0hSSG9T?=
 =?utf-8?B?bnhoeDRiVXFTRnBWR0UvNHJtZkZIMmFBRWl0MEJZbjl6cmpCbWMvcGI3THli?=
 =?utf-8?B?YlVkVGNqUGpLRE9RQjdNNVNiQXhKN1ZqSmhpYmxkcHBqUlZ6YVkzUEZEN0Js?=
 =?utf-8?B?TkFmNzhiVFpxRU4ra0RkUXVwUGZ0M3JBb1lKNkNOVDVwYXAzV0xWTnAwNnI5?=
 =?utf-8?B?TG9TbHNsVk1TUVBtVXNvaCtkdTJDZmVTcEdLMVg1K3M1ZnNTc0FPSzcrM1Fp?=
 =?utf-8?B?RDdEbVhCcndxbmpZSFQwVTJldmx3eG9VaEZzS25ITWpFOUd2Vy9FNEFIaVpj?=
 =?utf-8?B?ekgxMGloNXlxNnhuSXBUNmFWQkpNd1hSclNxWVRNaE1WUkFKa2traXBFdUdC?=
 =?utf-8?B?TEtRODY4RVRtZ2dDcmVYbzNvZkE0ejlncmJibWxsV2ZpMU9ManZSL2VwNzN4?=
 =?utf-8?B?Y1poU0tKdUE1bTlWNktUM2NvbXE2dFhxTlVDWjJBb2JzZDllUUdOMkd1Ry85?=
 =?utf-8?B?UU1RTkx4VmJIQ1F0YzJCNWRLQ05waEN3Tld3d2FwcnQvbzN2WjhhVWhGdmoy?=
 =?utf-8?B?VjV5SnJFbVp4TDhQU1YrOG41YUVlcWNnN0VVcFRzTlZtSWUzZXNUZ1JxNkJQ?=
 =?utf-8?B?UDlhZVdIMU9Fd0JaZHk3Y1VJcTc0dVQ1V2E1WGI2WHdMT1hPMW5YM1pSTG5Y?=
 =?utf-8?B?WEo2QmR3MytrTlgwR2dMQ1E3SmlXUjlUanVINWxxcEpRZk5ibGdGQmhsQmIy?=
 =?utf-8?B?VmtybHMreFZaSWtPSHZiZGRrVWZwZzRlUlFQWUh2bFI1Q1Q4UFdnNU9uVXlH?=
 =?utf-8?B?bzNmYjRBRFVZc0Q4d2p6U0lzWWVlUVVRaWxpMHRTN3IyUE9PaGlhTVNzd2xy?=
 =?utf-8?B?WWo1bCtOQmV6UTNnU3JsRThJSmZyaG0xbXNwMUwvWFViUXh2VnYvVHhSb2Fm?=
 =?utf-8?B?M2IxMzA5d1p4NjBVNFBHOTVZQnBRbTNMZldHUmtJWjE3Q0lpcy94NGhEd3Vh?=
 =?utf-8?B?a2w4OVFZVU9rNE9NTFZlYWEwcWRXakp2UDZ4SnpGWGp6WXBFeG1oUFFDWDVG?=
 =?utf-8?B?b3ZGUFNzSU5iNysyN0I0cmI4bFJXNEQzTWpEK0hPY3B0SFExTW5CcW5tNVR2?=
 =?utf-8?B?YUJsdDdkaDgySmNVME5LWG5TbHVyVUJHdFJjSlVUcGtwYlRiZFRGckdNZ2d5?=
 =?utf-8?B?c3IwYWNOUndMM1V6NkFSV1V2WDBvOU8xM1ZUbFpGWTFGOTY0MWlyK1lERlRT?=
 =?utf-8?B?akRBNHQzSndoUE94eDhoeTVDL25wN05QRWdma1MzenQ5NERyVkZsZXZiK2pI?=
 =?utf-8?B?K0lIaTFGcFArak11WkcxNDZlb3NmTVRtTHFHWVQ4ODVZOXlJbVN0RzI2eC9P?=
 =?utf-8?B?NHRwZktHaUhJQ1owQ2N6WUpaZkVEcjR4bXZJZnVUOWVaTG5ib1RBNFJqZjg0?=
 =?utf-8?B?Umc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f6e908-846d-40ed-a549-08ddb7cbbf32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:46:27.1462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Abycmu8sT9bnB29AIaWFxPj/FmW5sSLhYDqC9VfBq4g/ZhMRAKCKXE+EC/Rq5wxXRSkLACXCu88jvi4WkH1Y35p05Vtr8exKOqa2SZ4Fwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4663
X-OriginatorOrg: intel.com

On Sun, Jun 29, 2025 at 06:43:05PM +0800, Jason Xing wrote:
> On Sun, Jun 29, 2025 at 10:51 AM Jason Xing <kerneljasonxing@gmail.com> wrote:
> >
> > On Fri, Jun 27, 2025 at 7:01 PM Jason Xing <kerneljasonxing@gmail.com> wrote:
> > >
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > This patch provides a setsockopt method to let applications leverage to
> > > adjust how many descs to be handled at most in one send syscall. It
> > > mitigates the situation where the default value (32) that is too small
> > > leads to higher frequency of triggering send syscall.
> > >
> > > Considering the prosperity/complexity the applications have, there is no
> > > absolutely ideal suggestion fitting all cases. So keep 32 as its default
> > > value like before.
> > >
> > > The patch does the following things:
> > > - Add XDP_MAX_TX_BUDGET socket option.
> > > - Convert TX_BATCH_SIZE to tx_budget_spent.
> > > - Set tx_budget_spent to 32 by default in the initialization phase as a
> > >   per-socket granular control. 32 is also the min value for
> > >   tx_budget_spent.
> > > - Set the range of tx_budget_spent as [32, xs->tx->nentries].
> > >
> > > The idea behind this comes out of real workloads in production. We use a
> > > user-level stack with xsk support to accelerate sending packets and
> > > minimize triggering syscalls. When the packets are aggregated, it's not
> > > hard to hit the upper bound (namely, 32). The moment user-space stack
> > > fetches the -EAGAIN error number passed from sendto(), it will loop to try
> > > again until all the expected descs from tx ring are sent out to the driver.
> > > Enlarging the XDP_MAX_TX_BUDGET value contributes to less frequency of
> > > sendto() and higher throughput/PPS.
> > >
> > > Here is what I did in production, along with some numbers as follows:
> > > For one application I saw lately, I suggested using 128 as max_tx_budget
> > > because I saw two limitations without changing any default configuration:
> > > 1) XDP_MAX_TX_BUDGET, 2) socket sndbuf which is 212992 decided by
> > > net.core.wmem_default. As to XDP_MAX_TX_BUDGET, the scenario behind
> > > this was I counted how many descs are transmitted to the driver at one
> > > time of sendto() based on [1] patch and then I calculated the
> > > possibility of hitting the upper bound. Finally I chose 128 as a
> > > suitable value because 1) it covers most of the cases, 2) a higher
> > > number would not bring evident results. After twisting the parameters,
> > > a stable improvement of around 4% for both PPS and throughput and less
> > > resources consumption were found to be observed by strace -c -p xxx:
> > > 1) %time was decreased by 7.8%
> > > 2) error counter was decreased from 18367 to 572
> >
> > More interesting numbers are arriving here as I run some benchmarks
> > from xdp-project/bpf-examples/AF_XDP-example/ in my VM.
> >
> > Running "sudo taskset -c 2 ./xdpsock -i eth0 -q 1 -l -N -t -b 256"

do you have a patch against xdpsock that does setsockopt you're
introducing here?

-B -b 256 was for enabling busy polling and giving it 256 budget, which is
not what you wanted to achieve.

> >
> > Using the default configure 32 as the max budget iteration:
> >  sock0@eth0:1 txonly xdp-drv
> >                    pps            pkts           1.01
> > rx                 0              0
> > tx                 48,574         49,152
> >
> > Enlarging the value to 256:
> >  sock0@eth0:1 txonly xdp-drv
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 148,277        148,736
> >
> > Enlarging the value to 512:
> >  sock0@eth0:1 txonly xdp-drv
> >                    pps            pkts           1.00
> > rx                 0              0
> > tx                 226,306        227,072
> >
> > The performance of pps goes up by 365% (with max budget set as 512)
> > which is an incredible number :)
> 
> Weird thing. I purchased another VM and didn't manage to see such a
> huge improvement.... Good luck is that I own that good machine which
> is still reproducible and I'm still digging in it. So please ignore
> this noise for now :|
> 
> Thanks,
> Jason

