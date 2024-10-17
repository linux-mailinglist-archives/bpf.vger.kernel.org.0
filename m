Return-Path: <bpf+bounces-42292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92AE9A20BD
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 13:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3797B219A2
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2024 11:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC8C1DBB35;
	Thu, 17 Oct 2024 11:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KMyRvYEj"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C821D88CA;
	Thu, 17 Oct 2024 11:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163594; cv=fail; b=erTUAaXGa/SdBgJ84k+ty8u5ZXD5mgGXUp7JVm1nJdxHH+Pz3ekDLmp9CjAds3h/WzVz24buOoAlNCr0aO0Lu+k60Uu6DNVUsAYTdXQ/ZLrsTqJnLci+FrY7zgMJmVIzTHv9Am99XE1gjR+QBRkW5N8xOzbgaYMYdQaKJfLcvQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163594; c=relaxed/simple;
	bh=EXgVdjOzCp2IKOIhkCJmIt+vMf1s1RSVCXK9Lrn7ysI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=J8oxWQVNke88qWxQHdZxNEMt9EQA3C2yf44C033TMvbnoFoExwae9SUXozDv6DVQHv7NpsdU+I6IMU7BcL25i4lkl6ilZOW2FboN+WL7rSCssvJFRiIMfAzETMXfzJgd8khjb/PpR5NSY3MtLW1wLXKFuGAVTlobh6KDSuvFK9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KMyRvYEj; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729163592; x=1760699592;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EXgVdjOzCp2IKOIhkCJmIt+vMf1s1RSVCXK9Lrn7ysI=;
  b=KMyRvYEj4nB8IJM4yQVLhn+sLiKdRf/u9y2x3LfhtGe/Vv/nm945Lv+Z
   l15CHRASmc2i++XFWMuM4PfhDp2qyH/YxjNeXnGuFyriK93x7SLqr6fic
   Mn4rBDiDQOJPQBl5WoGaD+VWMmq75xMglhumaYw5FsgZUelaACWMajypj
   DsoNP4AjPRFE2RSpfWOvwfSVjF9zuVn1togo2ixYLgFh8kYRazniHIVFj
   7emp/wZccFzwkbowrYq5YJ68SETnRIGaIhqpnrFEXGdE0h5m5HJJWvr8y
   F1lnZDENifSksooo+q/Ix8MvGtyn34vSW50FmXpLWoqpwc0LteYYRyCFV
   w==;
X-CSE-ConnectionGUID: FRm1QdfCTSOjvuOX3myVBA==
X-CSE-MsgGUID: OWnXe8kNTuWB+gJ3/mvfTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="28433405"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="28433405"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 04:13:11 -0700
X-CSE-ConnectionGUID: wdaBxiTeRZq65gSKi4Jj1Q==
X-CSE-MsgGUID: DEfCO3DvSYeNu+tSTNjk5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,210,1725346800"; 
   d="scan'208";a="78122903"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Oct 2024 04:13:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:13:09 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 04:13:08 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 04:13:08 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 17 Oct 2024 04:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcs6BaYubJeypdcu2fLdwsEum06xGxiR64DuY5EV922QkE+LDPhPqrnVe5d1lJQvEaB7er8aYvk+ho3SVTbf4YTt7y2mFdSqM0E1eSBXpVs8OtlVmL/3UrEN+HSi4o6xV9Z8juuTOF7I2QGVlnWyOP5aV+C/0KO4hkfr6y7tqrsOw60tVf4g0lIK+KhE29D8IAUuG3Fn7PvCvARdXTRqE5TzYPJR8s2Tg6q6VO2TcZgmr9vtysjnhSLA2wC8UlZMLLkl3wSE5IpAk6g7/Atm4wyq+oM6XdvB9fJXmxFLQYUb0pENfmGVDbz8lvGxsVzHVv7FCFNnKutYEYy3YYTqxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+KF8HyepNi5W9XRctKNQcHzr5ATJ+9ZbAGsihTx4Z8=;
 b=KZlw3d91Y+pdhbbm+lGMv6wHwOHeYoqE7Qv+8rACPIa8qG358wGu6xF/4n68YSY5V2ElxIKZlWKxHQ+uIEuS92uSP3ZR2yWUf3TVfOI07m67F7OVi2zuRVWPU/X7075qXKAZ/5Tfhe3LiDWuyAr91sNTvjkXDSUEokLNxvCEvpX1i2FDRfKBkDOPoIIVz32blA4Zw+IsMUfBQfVJvB3mybRT957b7lm6dAOwXncSRPR0N24nUnAKIvGAfUtrKF6NT9G30v+z8pcKMEaRiRgZqE4z5MJCgd5DNPZIiZBXR2SZ4zRzYu+YClpoXlt/t6Cv0sOMH0Jq0WgdSao0KDU4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH8PR11MB6998.namprd11.prod.outlook.com (2603:10b6:510:222::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 11:13:05 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%5]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:13:05 +0000
Date: Thu, 17 Oct 2024 13:12:58 +0200
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
Subject: Re: [PATCH net-next v2 04/18] bpf, xdp: constify some bpf_prog *
 function arguments
Message-ID: <ZxDxNisU45KrF80e@boxer>
References: <20241015145350.4077765-1-aleksander.lobakin@intel.com>
 <20241015145350.4077765-5-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241015145350.4077765-5-aleksander.lobakin@intel.com>
X-ClientProxiedBy: ZR0P278CA0077.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::10) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH8PR11MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 59c850c5-7bf4-4f93-6ce8-08dcee9cac10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nfn39jteavuE1QyYCEseiYVzSc/xjgBFLviXcR2KUjihxbBZwBYFzpXvAvZE?=
 =?us-ascii?Q?IWKQpAQ4/eJE7Ei4hWwSOv1zwksr81ggJPzG0X0stgX403Z3T8imq8+xC+2p?=
 =?us-ascii?Q?ADvUdTWL+DhJ0EnxwrMMqiKaFe9f8XcD7p+nmeoSjUzo4wPxKrmSZGltWCCk?=
 =?us-ascii?Q?EwuYb8wKTXeVdlu/rbmuoZWk4VidLbOReB0hUAu/bBYKKEetVwz9+GbRgAGB?=
 =?us-ascii?Q?x3YeWSWi2pux2gy30d+dIk36zfxPqyz+tAIyD7LE5lXzGxnf42VAkKNqPZmc?=
 =?us-ascii?Q?9iLnyGfw0REAXLnu8y9AOWFE13/mZ7+Ft60iEAj7n6FoKki8oVyl1SKs3Rvs?=
 =?us-ascii?Q?NRhGMYhfJnc2h7iPpuWmN09YmSznILp6cr6+2uEYLK25GW/4VcMl8gJ6VMgF?=
 =?us-ascii?Q?7w0MCnwVPw8BPtgskhbqLY4g0hxWun+cSkhmlaUEFtoCYYuQxX6EXgCHN315?=
 =?us-ascii?Q?yM9PDEjCU/61ZgghzPNvYCvpguHDbJUTv5zACB1BMZdXKnT/RGsSeG4+aTqa?=
 =?us-ascii?Q?4Uupk8l83f9Kt3ubDzn2LoYGls/0NSuSvLcIQqdl2rqkweUHZ0UuWnG/0S9J?=
 =?us-ascii?Q?b8oIg3rDda+XOgoO6IDIK+EgTRvtm3YtLgLWGleBF+k4XdSmuD/ZUsLeMwZx?=
 =?us-ascii?Q?jok/MoU0glvwM5/ir6jbgEMWkV43oVF0xwPLORlCmUH+Pj2Bsj3zFBu/HvIK?=
 =?us-ascii?Q?/twFAt+v1FGKi+M1A/o4mAi7uEkPtYiImuxVYN1H4ggmYR0AJc1Hhj+PYs+l?=
 =?us-ascii?Q?5U8BW6ePWg9UE4C35JOyTBo6H1cB8NV0apZqbvVOS9Cs9K6Y/bCXE53LGEL1?=
 =?us-ascii?Q?GylBYwgV6c4MaWupwLqoOM/PNK8s4Yt8XmN7mVOCKWUFMIZcq8lJvwEPxZxq?=
 =?us-ascii?Q?LXGQbTarBCsV6eXxHFNDxqOgWrun4EpAw99OCnw2k6kYdooUHJTgYlXL86tf?=
 =?us-ascii?Q?lEqyuAwnKyx0z4Sj5HpEBJdrE3QBKxJ8H4CQoFmFWPzP/N1o9CT7qnccPZzt?=
 =?us-ascii?Q?aSaKNKE9uT6ONVSwAtcdrroTbMXoW0BMNfrNt88sCajLYAqVo9Y7OCiK5mLG?=
 =?us-ascii?Q?OeMaKR9tUi37nf3y6dnzRfFEUxgO9vhU2sw5sN8x6JvdVAjgSk6yIR4wSZ5V?=
 =?us-ascii?Q?3oZyTq+7m29jULN33C3k0kJeCUMAGG3FN5zpe7aOxlyXs62l0GQEltSkDMUR?=
 =?us-ascii?Q?wU3402/iIqONJvR7xWeQVLtCrMqq5cnATy9Pngdum8DbwHNVEPQd2eY1+uKm?=
 =?us-ascii?Q?bSVhkp4ojhGEcGDp0TgQhvpuHyvWEh2csqj0xH4fIEAk0VVVKIR2TaA5ccoS?=
 =?us-ascii?Q?wWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IRZB8aiGNEogIhp1L4uOxLSObbdvYr07etm9BkA2TjuSVElYOvYJgzOGiHOY?=
 =?us-ascii?Q?nyAqpkKCydKb0lPkBTwQVK3VbH6DxgYDMGKYdlTQGx8ePKQ3MYnMv3bokUtn?=
 =?us-ascii?Q?6J9Jt34iZMNAvahNlU7sJQs+dYZf9V6Xn5tB6fPk64uBA4ZvbKpkSKeHVe6r?=
 =?us-ascii?Q?/axcMIC1tG6JVfyl1g+pZa5KY80De9/9TtdGlE9agYJMKl6+jUAuCPHqfYSl?=
 =?us-ascii?Q?hX5dwi2BKR9i/WsYpOONsruXZ0j6Lr7ul3f28MzjzIGwltMq8OAFnxCn7u6P?=
 =?us-ascii?Q?CR68somDveFFvD+7pWNGIHgwVvqm2GbgXLopk6hLGpg1X+BUEDoanAMOzYtQ?=
 =?us-ascii?Q?/mc0hiIGUlFCevrjfsHJEbi/xBxauP5Hj06r/GZXyQSHNCVGTkDpiH2XK9fm?=
 =?us-ascii?Q?Eu867o4mz+7ROU91iHfmosoqi/UNxHbhAMvX84G5e86/rCmhMJzUmV2NJuaG?=
 =?us-ascii?Q?Ja0a4doxHmqjuZ1YKWXZM2Pv6MP4qlsWsmENg4dlOrNxl6fdB5UQl0vxu8UK?=
 =?us-ascii?Q?Zu6726wuaqYD7lFJ1rK6WpnHmNhX981p0poRzZUz4yxPnAWD/vS1Mj2cl3wm?=
 =?us-ascii?Q?fT7O8B27dkcc70bMLY/rACNUGXH02ukqs3MorlMnbEIZm4LVsvIj2IjKO5K6?=
 =?us-ascii?Q?TeE3I8T6IvANrwEwDKZ17rwxGT7RWRkRa+L1qvMM/lgLSlDmZwA7qzarJNAN?=
 =?us-ascii?Q?bUchGC23vqSrJyfCH75RdqvtXmU/gAXrEJ4fypSZK0CdZv6RFaavF65CkloC?=
 =?us-ascii?Q?XE493FPLcyFfyvou8QEvVnl7fpHutG0Crug5zqikH7dwDGiP2v9Q0ZnkZbGK?=
 =?us-ascii?Q?MEd/MQxNWCG+guII1zvO918zrg4K3DpmpaD1IAUkke/2i2qZUEAaaHmRRW7f?=
 =?us-ascii?Q?rsplPZcLC4jkR+PGBRbvkxlIa9mbY1ycpm5Jy9+iowP9a6Nd8KoEgZH2VWI5?=
 =?us-ascii?Q?dy5PwOkL3K551JbdI7arFmTX+WY2N00ehDp1uppzMNRrUANtNM0hwGUAr7vw?=
 =?us-ascii?Q?DmzOcLI0WoqUCrLr/tfAEdIHCd1j123p7FwW+bQHJm+ywDxiD+PmuBMhtbJY?=
 =?us-ascii?Q?PKmEWK8/Jl1r1dG8hWFe2hi8V1NgYbjctrWTCWLHwdLrkqT+zKV5A8AJAef7?=
 =?us-ascii?Q?Qs4i9OkilrOVoUb1FpheUHwnJqxliJq6Rdq4ZWQeQnH7vHQmrtqgYU+mAyQ2?=
 =?us-ascii?Q?OTWmgvChvrmqXRTdK+d9SjMjIHpYque0aHf6HeBusyh2NWR/V2B8BJXYxuTe?=
 =?us-ascii?Q?+vmlUMRAdE0nRKBov+X8nt/cNLRAqKiysIoIR5ZHIzl9OSAbh0mD1/QA0f4f?=
 =?us-ascii?Q?ijWryPOLFGu6SVhv372z/7+aTYK1gp+tNEBi16icdlmocdBP3qR7IxR99VcI?=
 =?us-ascii?Q?zyJs4UWdws25qwtur0KU47CjsfaPNiPZNPIYvw1Cgm6x6WVJlLJXI3e4FezD?=
 =?us-ascii?Q?a3Ogcm8NlUtnHI1fKCPzUTGNEfWAWB/+v36AF3hivazZBeimhC82yUWjq0yJ?=
 =?us-ascii?Q?4vn5nU1/fV+UK6AAWpw2zdLUF1926SlOuc37dMWQcfF/RF2gFAchmxU1Y/5Q?=
 =?us-ascii?Q?Y+GuSTRa7y9lXeMrWvWHadRK3kF6f6eJkVX2mlgdOkx4gl92L77xpo8EVM28?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c850c5-7bf4-4f93-6ce8-08dcee9cac10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:13:05.1417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdjVfh7Yy0v7tlMtuLA2NAljqEdz3hGxofZ1jVkqWf+AsrpEtfOCqrhWWBxMapMKy3aRcY/xe7Hgfwh89sEcYN6CzQwtsagtSafCaHV9pk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6998
X-OriginatorOrg: intel.com

On Tue, Oct 15, 2024 at 04:53:36PM +0200, Alexander Lobakin wrote:
> In lots of places, bpf_prog pointer is used only for tracing or other
> stuff that doesn't modify the structure itself. Same for net_device.
> Address at least some of them and add `const` attributes there. The
> object code didn't change, but that may prevent unwanted data
> modifications and also allow more helpers to have const arguments.

I believe that this patch is not related to idpf XDP support at all. This
could be pulled out and send separately and reduce the amount of code
jungle that one has to go through in this set ;)

> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>  include/linux/bpf.h       | 12 ++++++------
>  include/linux/filter.h    |  9 +++++----
>  include/linux/netdevice.h |  6 +++---
>  include/linux/skbuff.h    |  2 +-
>  kernel/bpf/devmap.c       |  8 ++++----
>  net/core/dev.c            | 10 +++++-----
>  net/core/filter.c         | 29 ++++++++++++++++-------------
>  net/core/skbuff.c         |  2 +-
>  8 files changed, 41 insertions(+), 37 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 19d8ca8ac960..263515478984 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -2534,10 +2534,10 @@ int dev_map_enqueue(struct bpf_dtab_netdev *dst, struct xdp_frame *xdpf,
>  int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
>  			  struct bpf_map *map, bool exclude_ingress);
>  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
> -			     struct bpf_prog *xdp_prog);
> +			     const struct bpf_prog *xdp_prog);
>  int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
> -			   struct bpf_prog *xdp_prog, struct bpf_map *map,
> -			   bool exclude_ingress);
> +			   const struct bpf_prog *xdp_prog,
> +			   struct bpf_map *map, bool exclude_ingress);
>  
>  void __cpu_map_flush(struct list_head *flush_list);
>  int cpu_map_enqueue(struct bpf_cpu_map_entry *rcpu, struct xdp_frame *xdpf,
> @@ -2801,15 +2801,15 @@ struct sk_buff;
>  
>  static inline int dev_map_generic_redirect(struct bpf_dtab_netdev *dst,
>  					   struct sk_buff *skb,
> -					   struct bpf_prog *xdp_prog)
> +					   const struct bpf_prog *xdp_prog)
>  {
>  	return 0;
>  }
>  
>  static inline
>  int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
> -			   struct bpf_prog *xdp_prog, struct bpf_map *map,
> -			   bool exclude_ingress)
> +			   const struct bpf_prog *xdp_prog,
> +			   struct bpf_map *map, bool exclude_ingress)
>  {
>  	return 0;
>  }
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 7d7578a8eac1..ee067ab13272 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1178,17 +1178,18 @@ static inline int xdp_ok_fwd_dev(const struct net_device *fwd,
>   * This does not appear to be a real limitation for existing software.
>   */
>  int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
> -			    struct xdp_buff *xdp, struct bpf_prog *prog);
> +			    struct xdp_buff *xdp, const struct bpf_prog *prog);
>  int xdp_do_redirect(struct net_device *dev,
>  		    struct xdp_buff *xdp,
> -		    struct bpf_prog *prog);
> +		    const struct bpf_prog *prog);
>  int xdp_do_redirect_frame(struct net_device *dev,
>  			  struct xdp_buff *xdp,
>  			  struct xdp_frame *xdpf,
> -			  struct bpf_prog *prog);
> +			  const struct bpf_prog *prog);
>  void xdp_do_flush(void);
>  
> -void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act);
> +void bpf_warn_invalid_xdp_action(const struct net_device *dev,
> +				 const struct bpf_prog *prog, u32 act);
>  
>  #ifdef CONFIG_INET
>  struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 8feaca12655e..72f53e7610ec 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3932,9 +3932,9 @@ static inline void dev_consume_skb_any(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     struct bpf_prog *xdp_prog);
> -void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog);
> -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb);
> +			     const struct bpf_prog *xdp_prog);
> +void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog);
> +int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb);
>  int netif_rx(struct sk_buff *skb);
>  int __netif_rx(struct sk_buff *skb);
>  
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index f187a2415fb8..c867df5b1051 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3595,7 +3595,7 @@ static inline netmem_ref skb_frag_netmem(const skb_frag_t *frag)
>  int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  		    unsigned int headroom);
>  int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
> -			 struct bpf_prog *prog);
> +			 const struct bpf_prog *prog);
>  
>  /**
>   * skb_frag_address - gets the address of the data contained in a paged fragment
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 9e0e3b0a18e4..f634b87aa0fa 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -675,7 +675,7 @@ int dev_map_enqueue_multi(struct xdp_frame *xdpf, struct net_device *dev_rx,
>  }
>  
>  int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
> -			     struct bpf_prog *xdp_prog)
> +			     const struct bpf_prog *xdp_prog)
>  {
>  	int err;
>  
> @@ -698,7 +698,7 @@ int dev_map_generic_redirect(struct bpf_dtab_netdev *dst, struct sk_buff *skb,
>  
>  static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
>  				  struct sk_buff *skb,
> -				  struct bpf_prog *xdp_prog)
> +				  const struct bpf_prog *xdp_prog)
>  {
>  	struct sk_buff *nskb;
>  	int err;
> @@ -717,8 +717,8 @@ static int dev_map_redirect_clone(struct bpf_dtab_netdev *dst,
>  }
>  
>  int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
> -			   struct bpf_prog *xdp_prog, struct bpf_map *map,
> -			   bool exclude_ingress)
> +			   const struct bpf_prog *xdp_prog,
> +			   struct bpf_map *map, bool exclude_ingress)
>  {
>  	struct bpf_dtab *dtab = container_of(map, struct bpf_dtab, map);
>  	struct bpf_dtab_netdev *dst, *last_dst = NULL;
> diff --git a/net/core/dev.c b/net/core/dev.c
> index c682173a7642..b857abb5c0e9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4927,7 +4927,7 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
>  }
>  
>  u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
> -			     struct bpf_prog *xdp_prog)
> +			     const struct bpf_prog *xdp_prog)
>  {
>  	void *orig_data, *orig_data_end, *hard_start;
>  	struct netdev_rx_queue *rxqueue;
> @@ -5029,7 +5029,7 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  }
>  
>  static int
> -netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
> +netif_skb_check_for_xdp(struct sk_buff **pskb, const struct bpf_prog *prog)
>  {
>  	struct sk_buff *skb = *pskb;
>  	int err, hroom, troom;
> @@ -5053,7 +5053,7 @@ netif_skb_check_for_xdp(struct sk_buff **pskb, struct bpf_prog *prog)
>  
>  static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>  				     struct xdp_buff *xdp,
> -				     struct bpf_prog *xdp_prog)
> +				     const struct bpf_prog *xdp_prog)
>  {
>  	struct sk_buff *skb = *pskb;
>  	u32 mac_len, act = XDP_DROP;
> @@ -5106,7 +5106,7 @@ static u32 netif_receive_generic_xdp(struct sk_buff **pskb,
>   * and DDOS attacks will be more effective. In-driver-XDP use dedicated TX
>   * queues, so they do not have this starvation issue.
>   */
> -void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
> +void generic_xdp_tx(struct sk_buff *skb, const struct bpf_prog *xdp_prog)
>  {
>  	struct net_device *dev = skb->dev;
>  	struct netdev_queue *txq;
> @@ -5131,7 +5131,7 @@ void generic_xdp_tx(struct sk_buff *skb, struct bpf_prog *xdp_prog)
>  
>  static DEFINE_STATIC_KEY_FALSE(generic_xdp_needed_key);
>  
> -int do_xdp_generic(struct bpf_prog *xdp_prog, struct sk_buff **pskb)
> +int do_xdp_generic(const struct bpf_prog *xdp_prog, struct sk_buff **pskb)
>  {
>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  
> diff --git a/net/core/filter.c b/net/core/filter.c
> index a88e6924c4c0..8dfa9493d2f3 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4349,9 +4349,9 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
>  EXPORT_SYMBOL_GPL(xdp_master_redirect);
>  
>  static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
> -					struct net_device *dev,
> +					const struct net_device *dev,
>  					struct xdp_buff *xdp,
> -					struct bpf_prog *xdp_prog)
> +					const struct bpf_prog *xdp_prog)
>  {
>  	enum bpf_map_type map_type = ri->map_type;
>  	void *fwd = ri->tgt_value;
> @@ -4372,10 +4372,10 @@ static inline int __xdp_do_redirect_xsk(struct bpf_redirect_info *ri,
>  	return err;
>  }
>  
> -static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
> -						   struct net_device *dev,
> -						   struct xdp_frame *xdpf,
> -						   struct bpf_prog *xdp_prog)
> +static __always_inline int
> +__xdp_do_redirect_frame(struct bpf_redirect_info *ri, struct net_device *dev,
> +			struct xdp_frame *xdpf,
> +			const struct bpf_prog *xdp_prog)
>  {
>  	enum bpf_map_type map_type = ri->map_type;
>  	void *fwd = ri->tgt_value;
> @@ -4444,7 +4444,7 @@ static __always_inline int __xdp_do_redirect_frame(struct bpf_redirect_info *ri,
>  }
>  
>  int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
> -		    struct bpf_prog *xdp_prog)
> +		    const struct bpf_prog *xdp_prog)
>  {
>  	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>  	enum bpf_map_type map_type = ri->map_type;
> @@ -4458,7 +4458,8 @@ int xdp_do_redirect(struct net_device *dev, struct xdp_buff *xdp,
>  EXPORT_SYMBOL_GPL(xdp_do_redirect);
>  
>  int xdp_do_redirect_frame(struct net_device *dev, struct xdp_buff *xdp,
> -			  struct xdp_frame *xdpf, struct bpf_prog *xdp_prog)
> +			  struct xdp_frame *xdpf,
> +			  const struct bpf_prog *xdp_prog)
>  {
>  	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>  	enum bpf_map_type map_type = ri->map_type;
> @@ -4473,9 +4474,9 @@ EXPORT_SYMBOL_GPL(xdp_do_redirect_frame);
>  static int xdp_do_generic_redirect_map(struct net_device *dev,
>  				       struct sk_buff *skb,
>  				       struct xdp_buff *xdp,
> -				       struct bpf_prog *xdp_prog, void *fwd,
> -				       enum bpf_map_type map_type, u32 map_id,
> -				       u32 flags)
> +				       const struct bpf_prog *xdp_prog,
> +				       void *fwd, enum bpf_map_type map_type,
> +				       u32 map_id, u32 flags)
>  {
>  	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>  	struct bpf_map *map;
> @@ -4529,7 +4530,8 @@ static int xdp_do_generic_redirect_map(struct net_device *dev,
>  }
>  
>  int xdp_do_generic_redirect(struct net_device *dev, struct sk_buff *skb,
> -			    struct xdp_buff *xdp, struct bpf_prog *xdp_prog)
> +			    struct xdp_buff *xdp,
> +			    const struct bpf_prog *xdp_prog)
>  {
>  	struct bpf_redirect_info *ri = bpf_net_ctx_get_ri();
>  	enum bpf_map_type map_type = ri->map_type;
> @@ -9088,7 +9090,8 @@ static bool xdp_is_valid_access(int off, int size,
>  	return __is_valid_xdp_access(off, size);
>  }
>  
> -void bpf_warn_invalid_xdp_action(struct net_device *dev, struct bpf_prog *prog, u32 act)
> +void bpf_warn_invalid_xdp_action(const struct net_device *dev,
> +				 const struct bpf_prog *prog, u32 act)
>  {
>  	const u32 act_max = XDP_REDIRECT;
>  
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 00afeb90c23a..224cfe8b4368 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -1009,7 +1009,7 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
>  EXPORT_SYMBOL(skb_pp_cow_data);
>  
>  int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
> -			 struct bpf_prog *prog)
> +			 const struct bpf_prog *prog)
>  {
>  	if (!prog->aux->xdp_has_frags)
>  		return -EINVAL;
> -- 
> 2.46.2
> 

