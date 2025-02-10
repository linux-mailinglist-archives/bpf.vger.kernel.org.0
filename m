Return-Path: <bpf+bounces-50964-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC839A2EC78
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 13:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80E6B3A49AC
	for <lists+bpf@lfdr.de>; Mon, 10 Feb 2025 12:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0F223323;
	Mon, 10 Feb 2025 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gh9VmOPB"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA201DFE8;
	Mon, 10 Feb 2025 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190636; cv=fail; b=Gfm6VRxDwgTMe9mligos+pVznR6nYQbNN2jwbOA1e+U8XlKjd64tc3a9kCx8qzW2GViu+s+iMfG7VVKZ0ESsPp1lVgEYrlgvwjqieLejEZkDxc8MhYfN9Cqd3GdrI2FBvKRj48VKL1JN+UQruPc1aGl17RVK01z4Rx+9h/sltBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190636; c=relaxed/simple;
	bh=vay4I4r5sBzS88A25CGpkVEPbMjW8JPsNgSR0s0Qw1A=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=n4CqWwarT2UAKMDi0X9n6SDK3inhEX1rK3upAB3n9T9w24T7poBS2ir6kgKeo+yzp8mNaPx4XvLpYXoNje9LFYA2bgg9xxEWAGnsCo4aBRVIkSAhK6fqIyU2To1CFvZf7aY/u7s1Xy3yb486unY1n32IEzweIQbv10o9by23zYA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gh9VmOPB; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739190635; x=1770726635;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=vay4I4r5sBzS88A25CGpkVEPbMjW8JPsNgSR0s0Qw1A=;
  b=gh9VmOPBnsmoUGtGDa2m+T1OIiqOf4N/5/p31X6b/MnptzHHmPPy9Ad6
   vPoYkc0x8w8EWPXyMcFHRX7mmnK1vGmjFe5cvGNoFt6+1TDDYTXqiCKl+
   oZw44Fnpx4jzpqipXwOZLQ8vrco8hEtVZ5sGGeXQ7s77nBKYKCwzEzIj6
   0mnm84oAijKFnoNtrFrf6dEJTfwY3wt23dH7lujof6dEpWqAp+u6eUpd5
   x6J8p8+VQv+CfbsRbxRROawyRAcHvQSRXobhSGwY/wB/T5G1MKw8X11wz
   V4t6GYbf4w6Cn2gcvXh/F3a7hyu2l7IGGU7fYIHoDeh2fZ3vbP9eaLL3f
   g==;
X-CSE-ConnectionGUID: h7naKOiyRIOcuIUlzV07aQ==
X-CSE-MsgGUID: MnvNDtTYRUOpguCl1U1qJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="50396345"
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="50396345"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 04:30:33 -0800
X-CSE-ConnectionGUID: /VqLSAGXTYu+MeOk8i4LQw==
X-CSE-MsgGUID: G205MvreRimfymfl2UCblQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,274,1732608000"; 
   d="scan'208";a="112704792"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Feb 2025 04:30:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Feb 2025 04:30:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Feb 2025 04:30:32 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Feb 2025 04:30:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+cAicYSy978MSnpCGKFhrG1L07xrJn8xZgSdQNZgy7bS/fYgD65s/wgNlNJIokZs7y2WXJ3EgL9n4vBgmWzai7xivNrL/idsSbCAtSvE+Ea/7soO1yMW9bEbfGGuRUTTYyjN8eF4AfSIBVI18YuY1TrH9W6fyzqOQn2x9BXYzjmR+PP8FszbVz6LY3UBlFc9cAdRFRsVDLcOqV3fegQJAdgA7NryxWurRrI7mYsYHzg5MaPN4+ND/bEOf1xR4j0HbIvNcEGFWXTC3hJgLsf274uhbNHTOHwtOeHYB/9SU96JtPq0rGTsun/J/2H15Z76W2htSz/WsYIJKGAl4uIrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCe+Ihq+g3sGiuHtRCdtCVLnpEFipWWbDguNgIwg0h8=;
 b=l7276yRlFzNfI4Yvl+j636zKJ+TZW62AL7e1WfkovleohGi36zZzEWVq99tF5ltjQdm4LZWQGsRWLVTP14AZ/Jgupx2Iug4axiFAx2A/m77qFGlh/KO7UG2AMlGExcA7JTyAlwVuzzb2yU2v0xg9jA5yxeAL7mRFH68J7IDBmauYFM2ElPt2bRtiwodpaQBlndFJ2bcYmwYYbZtxiXO08VyI2NACAikAHsVbKdPUeeIxIBK08Ah2+80lPD24eCtFwezhgd5J6/yp1jXoSvwiBuVbFVryL8ngFhhBhD1kZk71VNKzQ2Xf4ljG5t3cV4W0RpQK1luWKzf2S+83YKFuow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB6351.namprd11.prod.outlook.com (2603:10b6:8:cc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.14; Mon, 10 Feb 2025 12:30:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%3]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:30:16 +0000
Date: Mon, 10 Feb 2025 13:30:08 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov
	<ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
	<john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, "Jose E.
 Marchesi" <jose.marchesi@oracle.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>, Magnus Karlsson
	<magnus.karlsson@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jason Baron <jbaron@akamai.com>, Casey Schaufler <casey@schaufler-ca.com>,
	Nathan Chancellor <nathan@kernel.org>, <bpf@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 2/4] i40e: use generic unrolled_count() macro
Message-ID: <Z6nxUIK/xApn8B8N@boxer>
References: <20250206182630.3914318-1-aleksander.lobakin@intel.com>
 <20250206182630.3914318-3-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206182630.3914318-3-aleksander.lobakin@intel.com>
X-ClientProxiedBy: MI1P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 5068d2dc-9235-459d-b3d2-08dd49ceac65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/TPs/8Uv1PGR9NnV5lWiY3WiqCg1yGjXlBt6TmYV9Y3ZyXNEUMOnCjOGkhPA?=
 =?us-ascii?Q?tdBMLDsKZoXIv7PiSYuLyT7w2+MpTGx/5LemRWYB4PT/KYiNg4xLBvWblpYe?=
 =?us-ascii?Q?7oKAnkJ1zShGM0rViP6TnvvnsBgwhY0Rlk/FUXFE+xWxc6CSihFP9/Sg2TbB?=
 =?us-ascii?Q?euFulAl30yzUw+uVTCTHl2W5ihdftTXcPZOAN+3VAZuUrpvjc90IWKefhz9H?=
 =?us-ascii?Q?49lTt3VyoAfnKaAjF5zzvxcYWrHEioPsGu2vp0AC96AbnW4jbPQVSdcskTLg?=
 =?us-ascii?Q?glzs/waBiwrfw2PjlzA3j6e9wBI7GthGMcgVgdOAVj++5xqaabtd5Pr+zglA?=
 =?us-ascii?Q?oXw+AM8y7YgvmVbgSgQJ4dzNk3JHpsCntjwdKHst1K8GF4+v00dtgZadeHOK?=
 =?us-ascii?Q?hafqrFw36ru+nkSa2XXUY+RHrJd2dmcoW2U4woBkExd43Dwem7EhlWfY+bDA?=
 =?us-ascii?Q?jT9iW6JdcU2A+qKFxKkN/rKaYx6LvvAZDWiPRuwwdCPrDy/vRSzIFoudUgfh?=
 =?us-ascii?Q?xTNWtRXI41FEMdoaZXMBUAb4dt889gNiTHNp/HPS1MMJC7UlY5ltMxkeVREI?=
 =?us-ascii?Q?wSKcjggpiFpCFPWILx+xcjyqvOAi6sLEQaoIKaHAEGuCaV6NdbcVEWjBPZcc?=
 =?us-ascii?Q?MMS0spTlLlKW6Pbr6/KG6b4orc8HQAHtsMcpzJ9RXDy0ljVuMhyvrluFAlVz?=
 =?us-ascii?Q?uRM0XSlrcRiXPMYn8CrQJjzb3TAT5SYRFizt68QxoiVGB4SN1npU8PqzALle?=
 =?us-ascii?Q?BIw/YlJ3gTiVSNlEXAYID9WJQsepe+EIYEe8SNjp7nSZ9vCbUqG8ZPUOZz3H?=
 =?us-ascii?Q?VtK681yg4Nb6HdMYZRFE6hlz275RIBKZWWbasXqaaBWBucLHG8N7ZodZ2o/I?=
 =?us-ascii?Q?E559qDlgofeCddfFkino5ichAlaylW3LpqjmFCU7r9lcDlqpSDlDzoTmsorp?=
 =?us-ascii?Q?8/GFX45FRdYlSyk0mXHjFlpKYGjCTO+zcqLOeTzjCKv5B7yoh8pZkMOWDu2a?=
 =?us-ascii?Q?N4/A2t8YmIYV6fMYaUCU2vo93xOi73cOPUAGVDfbFuC1dKqy9T5Jd3y/sHJJ?=
 =?us-ascii?Q?YBT4JJA2UazrPQp9Ar5MoSxxA+MDOLDGivEJn3MpTMNkyMsyTQb+nvc7ewcA?=
 =?us-ascii?Q?3OSa9SBg6sACEHo+A05ZjHzz0jSaPtnLdOMyK/CQNvryRwGE4aWcgyOw396V?=
 =?us-ascii?Q?C9tGSVCefL5EKGWNyRd7Fb9ivtXUvcjVNHLuBKR0vO2HgXIs4LuEzx/zHufe?=
 =?us-ascii?Q?xr6DvYfWuMQAnbZpqHVPWcLsm6kpf0OiezXm1O9iwRuBnmyiq3QAzlhoJMtq?=
 =?us-ascii?Q?z9WVYjlr2zx9ZdUasmcC5GFzHObTbi7me9kAXPLLqX8D1jZd/NEEfJOh0HOi?=
 =?us-ascii?Q?3D//Ik95ELByFripK0KBgTD+5Mi7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zrhcxR1Ow2I15XxT57e9VttnrD5EOzrVlOJicWrZjV0lcZn2nYCDytKmI62t?=
 =?us-ascii?Q?S62A2JyU8Q5RXctovZeaCYg5CkvrRoB0cHVMdUf9P6lXg2aZBemJJoJgiNmt?=
 =?us-ascii?Q?U88OgUvwBCOEqTZrwqn0thJNn1JTs3cyFXzLgUeuJMp5ugAWi0BtWUkn87F/?=
 =?us-ascii?Q?3SHzTTRQMUocQL/vEAwX01lJ4FIogt5hv33Q/jdpR6mttWF9gmIG/RtbppXD?=
 =?us-ascii?Q?Wuhuwk4Cv6sK/qG6EIdIAnWGowOXqqTERxKeLBbdVU7NNSIi1Q+CmLxdm1T5?=
 =?us-ascii?Q?ix9PdrxhGpI6+UXfPmAWEHejqD3T48hCTQO1HOM3NESn1KtiBxL9IlzDeP29?=
 =?us-ascii?Q?5P/fXZMrTsbNox67arsIfenOLrPRFI+3Vw14MInNRPCcMlE8L4GhW4/Qk7iC?=
 =?us-ascii?Q?eXUTmd6YvnCK2rkjhyXcQwtJSYj23REsk17x7cWCSPRIsOuL4cyqZQfpiive?=
 =?us-ascii?Q?bcnwRkdihE93DeCRk1jSMc3rZXLJIC76OO4ng20LYcwdS5mjEEuGebuCld1X?=
 =?us-ascii?Q?+apkEEDKwQQOZk1C8IqGjUJLdKNsQkOp9ppTyvaYVYk6okFiyQ8JdqTMm3cS?=
 =?us-ascii?Q?246nbuvnu2o/e83zrKWtzKEj8m6HZ+bpba9QBkB9ZCc8mZ3nHFAYmY1GWGaQ?=
 =?us-ascii?Q?2pI6gM8yMpWfuyjzODJfESJQybomY7SU790OqKCqlSZroobPx0ESu+jTH+bT?=
 =?us-ascii?Q?8He0cnx3ARL6ePIzf50iPMNgITX88I8GOZM9gosKysRQ/kgE7GDf566pRVbe?=
 =?us-ascii?Q?E3zcX9PszFQ3PykqpkkhgcQXFTN2NHmltLuc5qGZcngLQ/MUrw2KMEQci+t0?=
 =?us-ascii?Q?/fq2Vc2RYC200lDprlplI2wT5T4D+BJEOBGmXAJQal6/UBgSIK8Ywnkp4W1i?=
 =?us-ascii?Q?poqYBkNlNG+VVYgLQ06RJr8qddsgKVfluNT6BnhGg0tTyJoEa0G5+q/0SWkL?=
 =?us-ascii?Q?SSzA9oxOmT4wgZvYpen/v+VORH2NuSbR2XSMRM3ZKuKmmF0Q+FSYr5/6MAqJ?=
 =?us-ascii?Q?JAB9S19v3vnclpk7hID07M2got98tLSDd/pwAgQJ9jV2UqbatsEDwPep+vs7?=
 =?us-ascii?Q?B7V56X+f0h5CUh+FWJpqW8hWGit0UbYMiRJ9JiN13zTwKvwedfKyQUO7LazJ?=
 =?us-ascii?Q?pvJhtECVBAvACzZsEx7Mn2z6aML5d89ism2+1GM2A4dr1tMIQcNKe0xzk88P?=
 =?us-ascii?Q?ijmUalUl4H+8+ZAdCbtwDknKqS5QSlIZvry+2QQeRH6B2L84ocOE9W7CwOSI?=
 =?us-ascii?Q?JrELfGDnG03j93K5qHY4FnWQXgz7/HfXF1xrC4at9oggZFgRTGUBx9LxwPe8?=
 =?us-ascii?Q?tiFu1bJ11FkgoYFLKuKXc4nUssct2utUflB6LNaYjA/Ca3nhd8iYcrwYi/qj?=
 =?us-ascii?Q?MHJt1O49kpDUedENZEpsuI9xIke1JchazJ3Zh/OnoevWRhpXHrrFhMeX9BIC?=
 =?us-ascii?Q?UKhmO5YLPTJCXCcRbctDV4wGuNT/GVBLy1q61JCcc/tzy4+5F2b0vpS2RIsk?=
 =?us-ascii?Q?JRwlG/TSkkpiTfxLdCUXIzYdRcWnezAtKyc+BCP7WJt4MH7C0StxV/KnRLKz?=
 =?us-ascii?Q?L+M0pKSK9Rkm2jPmJWqABYm69A6wjpoVY1Jre+Ru1vwMj0eIyVU7p0d5o3Bl?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5068d2dc-9235-459d-b3d2-08dd49ceac65
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:30:16.1932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vyafkLDPayLdgFr4+Fntekc8xMc2sOUX8RRhi4n8dSY11V2RbN3/zVPZHf9YlEP62Tug6IPqKCmED+8m4wFTSrhE9x0C3CnwKS9OCLSRCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6351
X-OriginatorOrg: intel.com

On Thu, Feb 06, 2025 at 07:26:27PM +0100, Alexander Lobakin wrote:
> i40e, as well as ice, has a custom loop unrolling macro for unrolling
> Tx descriptors filling on XSk xmit.
> Replace i40e defs with generic unrolled_count(), which is also more
> convenient as it allows passing defines as its argument, not hardcoded
> values, while the loop declaration will still be a usual for-loop.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> ---
>  drivers/net/ethernet/intel/i40e/i40e_xsk.h | 10 +---------
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c |  4 +++-
>  2 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.h b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> index ef156fad52f2..dd16351a7af8 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.h
> @@ -6,7 +6,7 @@
>  
>  #include <linux/types.h>
>  
> -/* This value should match the pragma in the loop_unrolled_for
> +/* This value should match the pragma in the unrolled_count()
>   * macro. Why 4? It is strictly empirical. It seems to be a good
>   * compromise between the advantage of having simultaneous outstanding
>   * reads to the DMA array that can hide each others latency and the
> @@ -14,14 +14,6 @@
>   */
>  #define PKTS_PER_BATCH 4
>  
> -#ifdef __clang__
> -#define loop_unrolled_for _Pragma("clang loop unroll_count(4)") for
> -#elif __GNUC__ >= 8
> -#define loop_unrolled_for _Pragma("GCC unroll 4") for
> -#else
> -#define loop_unrolled_for for
> -#endif
> -
>  struct i40e_ring;
>  struct i40e_vsi;
>  struct net_device;
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> index e28f1905a4a0..9f47388eaba5 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2018 Intel Corporation. */
>  
>  #include <linux/bpf_trace.h>
> +#include <linux/unroll.h>
>  #include <net/xdp_sock_drv.h>
>  #include "i40e_txrx_common.h"
>  #include "i40e_xsk.h"
> @@ -529,7 +530,8 @@ static void i40e_xmit_pkt_batch(struct i40e_ring *xdp_ring, struct xdp_desc *des
>  	dma_addr_t dma;
>  	u32 i;
>  
> -	loop_unrolled_for(i = 0; i < PKTS_PER_BATCH; i++) {
> +	unrolled_count(PKTS_PER_BATCH)
> +	for (i = 0; i < PKTS_PER_BATCH; i++) {
>  		u32 cmd = I40E_TX_DESC_CMD_ICRC | xsk_is_eop_desc(&desc[i]);
>  
>  		dma = xsk_buff_raw_get_dma(xdp_ring->xsk_pool, desc[i].addr);
> -- 
> 2.48.1
> 

