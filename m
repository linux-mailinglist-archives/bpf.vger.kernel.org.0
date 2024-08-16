Return-Path: <bpf+bounces-37365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE638954894
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 14:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7291F284380
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600F1A4F04;
	Fri, 16 Aug 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D3J3LdI6"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A31B18FC83;
	Fri, 16 Aug 2024 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723810641; cv=fail; b=WZ5AB8qHKu64hAwlt5chVc8SwjZXyawSQobgdqruQH27nmGt8ywe/Fmoul2vhi6zOyL5xwnHph1j4Z4KsC2HDFL2xMAXgsXE6yb3WZsLZ29Vd5gVOo4oMrbMICP9TbAHJgI4QF/fQ53Y4F53S+HfhKvFvHHeE1iBsexxSAXR/AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723810641; c=relaxed/simple;
	bh=VKl9e9cZiPr8FHTJ8J76iOODRD7P3M84J6wN8t7efBk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NTxQbLNdJ0qWGWcHGexL59xgyTCTyFLP0RuXdYCPupA0AczKuXzCb8PCd7Y7dGwOnK648PEnVnpn8mjpXKM/Fk3r2WU/hVM+S8tiAwcE9o5ZsTsltLn9uVh5IIW+XNDUP6vPO0AHAJeOZmomHv5zNEud9kvCbe4rkHkp9GRUMHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D3J3LdI6; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723810639; x=1755346639;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=VKl9e9cZiPr8FHTJ8J76iOODRD7P3M84J6wN8t7efBk=;
  b=D3J3LdI6Y/vuCrIKhJQa7bprngo6xj5t0bV751RqkiKDnKdBrFtjvxjg
   /jI36B80jXVhOW67TdcR9g+aCRSzjpMdqrXNnIpFQz9xTD1iBCDtEcwzX
   1kbmhIg/MTFySLEOXpi+Yxyh5cCj78N9hh2kCeeieJlHq13zyFgeqVY3s
   0yNYuj3gBvyFZdA/YnJOok2Rsw8K4zuzUxKMzyLOtTFYfn5uXSyDXFs7Q
   UH9Y7nyDcCSgYHgps47q6tfv9UMcxP3KhlnpDGGTLCWOG5ZUc69V1vx9G
   8P89ttjGw42t5cymHPXzwohzx1LbiBQ21gudOP4bsCK/pMdBDh2Ikq4Dd
   w==;
X-CSE-ConnectionGUID: IS8zAltrSoy3JY6oHwRemg==
X-CSE-MsgGUID: gmHSeGWHSxKIy0JGeg/PbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="25862455"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="25862455"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 05:17:16 -0700
X-CSE-ConnectionGUID: //RlAXnXQ1KVQMBFyZ+Q4Q==
X-CSE-MsgGUID: DF8YxqagTTORAAUM35XqVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="90384522"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Aug 2024 05:17:15 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 05:17:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 16 Aug 2024 05:17:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 16 Aug 2024 05:17:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 16 Aug 2024 05:17:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8YSim9NrI0GKb08L+satYoIQmaOcMBqkGB8ubeS4J1K3XdhdCc2Htn3/z9VFtUptmFd6pBenNntNsbNFbejE5V7tnjDpoJ159aJ4yDw2RCBOYyBPOclQ+guIVCWJolPXMT5QqxtOFQmER0S525usLOzKPRTSwHYMTbOAxEdpS9414YBW+2ZCnC19IwynnPT/u5iNPQC3nzLSAqoexXJOKUCt+9x4TODmcwH0vhbErvKIMkEdiH8OocMTd0S06yrbwJTjFDzyz4nlmYzMf4nIejwVszjRp6+sX1WQLoJinDpMZqUxcjKNK/3QQUtPlwG0075Qd5J1e5/t5JvK/8Q2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Vhe54p657ZEaxOtF6J8Y9Rhuu5bvFV/kWMQr7u8p7o=;
 b=kazsWl23V8tagsYWLgk4UTkhEC8IUDwYXwup6rjhTMcb/7Kq5zcWZZXGyqCiPuefasFZbjxcwajKTQ9saFGPwTdBwJ2J2YRpDbG4c4FSUK+RIAhstAiHqc3oCL3ZF0VIgv3j440we6qTWoyJlZUzrZdgLvJADxQgkXd9sls58MR3qmSajexzl2HwNZXkNiSmUKnxSBPqKUHOBaT15MUJpkad5VGWig2aWDQj4eyFHBXfUEpjdKPrtVIRzxKnLY2/rlf2uXZCb7H+QsbqFRwQPB+B84R/3OWqZO6gNWw7vLKNz01F28o2QOg4WeSi5MEVkI9Dz80j+gsehR4KsYSOHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.33; Fri, 16 Aug 2024 12:17:11 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.7875.016; Fri, 16 Aug 2024
 12:17:11 +0000
Date: Fri, 16 Aug 2024 14:17:03 +0200
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
Subject: Re: [PATCH iwl-next v6 0/6] igb: Add support for AF_XDP zero-copy
Message-ID: <Zr9DP5Dr+IRYESD+@boxer>
References: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240711-b4-igb_zero_copy-v6-0-4bfb68773b18@linutronix.de>
X-ClientProxiedBy: MI1P293CA0007.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SA1PR11MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 1618aab7-a72b-477f-f725-08dcbded5b13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s2+zGwX1GdncUiAPJvZ5LgSSz/GiGpEgXcEoGr/iplJueLskqBPOQc+x/ZZ+?=
 =?us-ascii?Q?M+Lpx9y6fhnUFw9yGWnpEDT1lsGXSoTTczR/27e+/hMA8gP70L5FT2+KPmSk?=
 =?us-ascii?Q?SI77iPfCgVs/KQn8ftHnxmdTJf9N6zCMyib4iC+j0W+9kgIb7Zx/WPdVvlyg?=
 =?us-ascii?Q?nwMfydxNporNSWK5LxAzw1RFy5L/jGppcNRKcaD4Wf4xnu2V6CMLQ/jQGhCn?=
 =?us-ascii?Q?kPp42oqhcHR9E21tCnXDO7pTXay/S/g0WHHFWKP+NSQC1qDBFRUCu3o62T5l?=
 =?us-ascii?Q?3z4vlIRNKbMeTkANBZAT3pM5k+OPEXkwg21EUf8qUkRJJFdNemVhrygFbAHk?=
 =?us-ascii?Q?bOBi6fc7fBLO88PjXpeDdkq+GjoS2qS3u8s3EbF4aR7gzc+ZPpXVuu90/jPs?=
 =?us-ascii?Q?VEesDrwSBWnjCYxi18I+eBIyyUHOeFvDk08Mjo6jfd44ZYCHUtD5njJoSJsO?=
 =?us-ascii?Q?ekGdbP2f1t5IxCIBvkZQ9/jrUcsXhTws9kkXEdAMMWA57mYMhJglPew2FArg?=
 =?us-ascii?Q?bzkrqGy1o4yCidSMUS0NWNz6ygRsZYVCTZcaY8L3UR90uq/DksFnDEvGHmL1?=
 =?us-ascii?Q?Ppjz8H8cLA3p2FtSBeUtaUvPYitMlKYcKaceQH197QxRsDm+Mue1aEr5OOr+?=
 =?us-ascii?Q?bfkQhX6VbANzek15W1lzqeN28kDIdGFtHPWzfWi+Ikbt7TX8uC+2NsQOrJdH?=
 =?us-ascii?Q?jJSjJJUcEVyPw76ib76ELvmX7ZStfw+sxX1d5nyUwfv20nLIml+f4d6Mxjcu?=
 =?us-ascii?Q?2H7hXskKt0Su/GMaiCnr4CDaXVS0r5UmNc+bXw7d332Gq9Ucy0+pW8V2P0pB?=
 =?us-ascii?Q?YwpnrMLXCXtHT1Hu5TFZ6wzq06wegNhI+YhpYMIINuA1wDNYXhbaXC/8LTkx?=
 =?us-ascii?Q?x1yt3S3coJKiIlUmADbZ7BZymaKRGb+6tuHqw3DGFMYgbWYF5yZQeIf5nHIu?=
 =?us-ascii?Q?1ckMTiQiV3/mqiBml6vveQrz4x3/pSdNseC1h7IVnudlNcsABIq1GxOUz8LO?=
 =?us-ascii?Q?eV63HefM1yFQnNMG3SIHGPEL5G0txgONz9RB6VSYVUsWz8stJJSwV8A/BT83?=
 =?us-ascii?Q?bWT1KdEXoApvjCUm/AZsY9WwgVYwP2ruBrivubY2yd/K+rpf/rh49ZAdNPhb?=
 =?us-ascii?Q?vPh6A0B5yfcOJZ+6PKoFEh5ImIVB5P+jJi4CKXDwpPomKMUxQ3aX1zHE5ULT?=
 =?us-ascii?Q?W8mgaKjAw0Y4zFln4OVPgJtAFzCVbV5b76KQIks1I5eNKB/j1Rhkqnk4bdJs?=
 =?us-ascii?Q?GqW3Qpk/V6g8ZWRdf76vbT9TqHVC7g2VdMc6roHl7kxX0bscE9kXhV8UV/Fy?=
 =?us-ascii?Q?yWg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IKxXRJC7i3K4oilIcv7uJ5K9/SULdk+hblUbufI0IE9/YluGdJDt49RLf8YL?=
 =?us-ascii?Q?c6atgQIxl4VfkpVnG2Er8ZKOQ6S3cMH1oSrNAFbMpHP1LL/8v/rvz6mF0MFu?=
 =?us-ascii?Q?smvmZkgq/VqTF908ieWU7O0wc/lqoprHxe99oJ66dmh3aeRWAwW9Txjxt+a7?=
 =?us-ascii?Q?8yrIgo2XuHDQV6H4AsBfS9FsI1OKjXNMugv66gI3A3Iz3D1QAi6sogQ9Kk8z?=
 =?us-ascii?Q?Vc1Vq5Q9m7Jd7JJ1mesC8bUnBpqzR4dCBLh+zUZcoE3pUYxNzmXtnQ31L0tz?=
 =?us-ascii?Q?rW5Vc518zn0jVMQruBijUPDi4NqangnrROISAIBr8yj/o2bUKDYdzLHFtJWq?=
 =?us-ascii?Q?1aPYSrHermXZ99sGK+NT4nH5vessWnee0QHWVfSUukqLqWGXd22xjeEGTJBc?=
 =?us-ascii?Q?9c3fdjRbMLVK+jhrbILM32M93Or2R39cafMfV+3y+jFUpWg3sO2HVsWxYrJd?=
 =?us-ascii?Q?HbusN9WS24ThU8uRZKB32ZPWae9UYgj06CSPn4D+GDJSZcSgiyH+HjNHp3eo?=
 =?us-ascii?Q?qNgcwTscuiIlwkiuBvm55EGTSDUfAEkLjWWeV5uGXUK9r0nFNf39PirX2b+b?=
 =?us-ascii?Q?6G37LZccVOaxuX/GIxCSB/+XnZWaADQBv01CrBZUjp4jus5st1j4KBaweoDH?=
 =?us-ascii?Q?XIZxiICsVxFu4Atd+R3Sao+FW3EkU4Pq9klH+ngCPH2DtRoxMXjnITHyBH/m?=
 =?us-ascii?Q?/HCaz18rIrLrktgjk9RYZCBaKXcdVzpeuuPiTuCnk+5OKXex8SJ/34veyriR?=
 =?us-ascii?Q?5FfL0KQDmpLvjbSVuThzNrgEECzgf/3i79enSoJDXQo+SUqJFuag0fTl1V11?=
 =?us-ascii?Q?Iqjw9DMlXRIs5NwF6yvMWLtNfZHctlru4z5RZ1jZ0ECDwec8SiJayOPieOZz?=
 =?us-ascii?Q?KaZTn2eNasSrjSewbCp2bpGsDbXX/b7cBBDArnDWtdaTJLwPELIza7+u87WY?=
 =?us-ascii?Q?uIfxX8u2EiRUA88q/AgrS8LAg72/PoA/7xohg4No2M7FrLQAuO0JzsUdGWwL?=
 =?us-ascii?Q?nsqRjiWe8ztkdWpoHpVX8wXtq33lToYXE90wCe+e5Yfg5INafX4lS0C4Dwk6?=
 =?us-ascii?Q?HaWoqk1NnQCzqvm5/OTAqpu7CtrfhhMMvFq8WjWsYH5xCTxFe7vI9vm8gRug?=
 =?us-ascii?Q?8fR5UKyQ6p0NeUQl18YGPAi2PyB3pyERATDuLbUpmROy3Lr1Z29HGuetyjAO?=
 =?us-ascii?Q?oUKFMj/5bWDXQ/jDbql/x/ZF74tZnpxYd/harVW0OmxX6EGxjuRFc2pSHjou?=
 =?us-ascii?Q?NbAzUsigbyqKvEi55b+zBMcXKAuyRVrKreEVk8Fi9zRTKUY1ilU3ySv4H003?=
 =?us-ascii?Q?6S4KjoWcKDIr8x95K/chUGZPcP2x7HqG7i4QgoPjewpchCLchONOYNNmwBPZ?=
 =?us-ascii?Q?IuGXfpYqn2OQgHIiyn+PBydkrav1VBLj1OI1Kuut1i/qvAWR5ZhubNO8izel?=
 =?us-ascii?Q?GWAvzPgvjHPf8JLJwtDDnsjaYXQz0a4Iz7myq2vHm7WELjlsLk8HfY8gW1iv?=
 =?us-ascii?Q?NJz0NKuwGz7dpN0RcRD34R/Weo7EEHw21IQRViJW9wJN3QHy3r7W9WvHhSbx?=
 =?us-ascii?Q?hsgbeqi64kLNaJFJ4dySD/Ngd9t+zJkNC3lKf0KeCYAENZkyUt0bnvgNFg5H?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1618aab7-a72b-477f-f725-08dcbded5b13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 12:17:11.3631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xV4cmYkInJUW3k1AA1sGi5BDkOndv3FAjqZDNmjvQZ9Qi0wwdKorXAJemAN4CO6TyL+2FGFq8m9guHA2+2ntt3vkXpcKEo8BBQ3R4nUKTXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
X-OriginatorOrg: intel.com

On Fri, Aug 16, 2024 at 11:23:59AM +0200, Kurt Kanzenbach wrote:
> This is version 6 of the AF_XDP zero-copy support for igb. Since Sriram's
> duties changed I am sending this instead. Additionally, I've tested this on
> real hardware, Intel i210 [1].
> 
> Changes since v5:
> 
>  - Rebase to 6.11
>  - Fix set-but-unused variable warnings
>  - Split first patches (Maciej)
>  - Add READ/WRITE_ONCE() for xsk_pool and xdp_prog (Maciej)
>  - Add synchronize_net() (Maciej)
>  - Remove IGB_RING_FLAG_AF_XDP_ZC (Maciej)
>  - Add NETDEV_XDP_ACT_XSK_ZEROCOPY to last patch (Maciej)
>  - Update Rx ntc handling (Maciej)
>  - Move stats update and xdp finalize to common functions (Maciej)
>  - "Likelyfy" XDP_REDIRECT case (Maciej)
>  - Check Tx disabled and carrier in igb_xmit_zc() (Maciej)
>  - RCT (Maciej)
>  - Link to v5: https://lore.kernel.org/r/20240711-b4-igb_zero_copy-v5-0-f3f455113b11@linutronix.de

I'll go through the set on monday.
Thanks!

> 
> Changes since v4:
> 
>  - Rebase to v6.10
>  - Fix issue reported by kernel test robot
>  - Provide napi_id for xdp_rxq_info_reg() so that busy polling works
>  - Set olinfo_status in igb_xmit_zc() so that frames are transmitted
> 
> Link to v4: https://lore.kernel.org/intel-wired-lan/20230804084051.14194-1-sriram.yagnaraman@est.tech/
> 
> [1] - https://github.com/Linutronix/TSN-Testbench/tree/main/tests/busypolling_i210
> 
> Original cover letter:
> 
> The first couple of patches adds helper funcctions to prepare for AF_XDP
> zero-copy support which comes in the last couple of patches, one each
> for Rx and TX paths.
> 
> As mentioned in v1 patchset [0], I don't have access to an actual IGB
> device to provide correct performance numbers. I have used Intel 82576EB
> emulator in QEMU [1] to test the changes to IGB driver.
> 
> The tests use one isolated vCPU for RX/TX and one isolated vCPU for the
> xdp-sock application [2]. Hope these measurements provide at the least
> some indication on the increase in performance when using ZC, especially
> in the TX path. It would be awesome if someone with a real IGB NIC can
> test the patch.
> 
> AF_XDP performance using 64 byte packets in Kpps.
> Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
> rxdrop		220		235		350
> txpush		1.000		1.000		410
> l2fwd 		1.000		1.000		200
> 
> AF_XDP performance using 1500 byte packets in Kpps.
> Benchmark:	XDP-SKB		XDP-DRV		XDP-DRV(ZC)
> rxdrop		200		210		310
> txpush		1.000		1.000		410
> l2fwd 		0.900		1.000		160
> 
> [0]: https://lore.kernel.org/intel-wired-lan/20230704095915.9750-1-sriram.yagnaraman@est.tech/
> [1]: https://www.qemu.org/docs/master/system/devices/igb.html
> [2]: https://github.com/xdp-project/bpf-examples/tree/master/AF_XDP-example
> 
> v3->v4:
> - NULL check buffer_info in igb_dump before dereferencing (Simon Horman)
> 
> v2->v3:
> - Avoid TX unit hang when using AF_XDP zero-copy by setting time_stamp
>   on the tx_buffer_info
> - Fix uninitialized nb_buffs (Simon Horman)
> 
> v1->v2:
> - Use batch XSK APIs (Maciej Fijalkowski)
> - Follow reverse xmas tree convention and remove the ternary operator
>   use (Simon Horman)
> 
> ---
> Sriram Yagnaraman (6):
>       igb: Always call igb_xdp_ring_update_tail() under Tx lock
>       igb: Remove static qualifiers
>       igb: Introduce igb_xdp_is_enabled()
>       igb: Introduce XSK data structures and helpers
>       igb: Add AF_XDP zero-copy Rx support
>       igb: Add AF_XDP zero-copy Tx support
> 
>  drivers/net/ethernet/intel/igb/Makefile   |   2 +-
>  drivers/net/ethernet/intel/igb/igb.h      |  36 +-
>  drivers/net/ethernet/intel/igb/igb_main.c | 232 ++++++++----
>  drivers/net/ethernet/intel/igb/igb_xsk.c  | 561 ++++++++++++++++++++++++++++++
>  4 files changed, 770 insertions(+), 61 deletions(-)
> ---
> base-commit: e7d731326ef0622f103e5ed47d3405f71cdcd7f6
> change-id: 20240711-b4-igb_zero_copy-bb70a31ecb0f
> 
> Best regards,
> -- 
> Kurt Kanzenbach <kurt@linutronix.de>
> 
> 

