Return-Path: <bpf+bounces-34980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F622934609
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 04:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D96E2820D2
	for <lists+bpf@lfdr.de>; Thu, 18 Jul 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D401E1DFFB;
	Thu, 18 Jul 2024 02:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hse/J6iO"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDE15C9;
	Thu, 18 Jul 2024 02:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268620; cv=fail; b=h/r+4YC9qplRQEVjU4HoNpHae14zmzhOTgUPfCJ90aIalkkorb3owNdY+09PJu5nfCu7olR4BDU5/U8IZPtX1H45KugAKMpkp68coxYPxzFiDHxXWaxeF+pg1DrIiJpPuZhahs0/GwAdnuh9245S4AlOC38Gy5dwU1Q+yE83qg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268620; c=relaxed/simple;
	bh=n7dlxxDMW82eGc+y4LjgfDIdOwyAZNyd6lJ9Sr8csww=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=eHp+jaPXyrgdfq3qtspT9SoF9XIY0g3Slcw8UiFOoLIOqeAA3Epc28fobsTy7aO2wo0xzTlCLXlxQatXxicxIOzETW8mA4KGza3sJvVn0kIULUnVYX93UHgnNAoS30XrtviNfR9SMxbVEPXKK0p1WO9MF0swpDf56LM7aj+s5MI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hse/J6iO; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721268618; x=1752804618;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n7dlxxDMW82eGc+y4LjgfDIdOwyAZNyd6lJ9Sr8csww=;
  b=hse/J6iOKVrYv+H4u9eIsk8Lh0pWHjUmO7UQHnqXKS61xV0TiXWO2xBd
   fAAjGnvK8QsNU3qvf2ezuRrD7V0pQzIrb6YICOTQdJsR6VUWar4hQysEP
   GGWzC1ZWEmgvVd4ttDxGuu+/ymKJeIbZo82PGx4YQzr7SEG2MTja+FxpG
   LfKgElJsYDGed0h/HIARSExA35ffphL4dwsp+SgYs/evXHikmhtWhDevz
   Bb0s/x/iZEIsIejWcFLbFzl7kiXVhOLdxYdrXX50V/fIllyvC4JyDTCov
   lQSdSfvBcPtOGoKdB55JLHnVT3c0iCxtWTHQ/147A8ays23KaikPl6X9T
   Q==;
X-CSE-ConnectionGUID: 0p7Oy+jVS5uyKUXp1NWSOQ==
X-CSE-MsgGUID: Xay84WkyQl6MA3E3Ad/I3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11136"; a="22669884"
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="22669884"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2024 19:10:17 -0700
X-CSE-ConnectionGUID: UZcwVyOZRvu1Oaxr7BgPew==
X-CSE-MsgGUID: StqD33umRsuwuhGUhdps9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,216,1716274800"; 
   d="scan'208";a="81242812"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jul 2024 19:10:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 19:10:16 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 17 Jul 2024 19:10:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 17 Jul 2024 19:10:16 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 17 Jul 2024 19:10:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STPVM7lzeNsVA+6djMzd3izCJH35qJvGvc2hcOdcxzJWDYtzzmo1C9ZP8oo4cnzSGO5Ft9Wfbn4AaGDdO3MK/vjuF+aIT72UPxhtDdegbTFw0qCR6xPDLaoV0bLDjmzklB+66zjkATYq/u1bD9yNlmYv+rpMLxTk28r46T6LKVu0/AgI8wi0XJy99tmJ3ksLIE5IOaCP5mtdcJ43J+aeAkGnJGjlCVLSNu2QFI5HRiDOfaN2EqBHy3weOZYbiID2rEFob+BzJiTRfAmqyX88Q7DkotqHlU7yvclL6QCYSlgAiDCbggNHF4xab45nZE4KZuf2dT0Lu+o88tq7VyAy8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxYrvie4mTB5lSx5adAPFXQcSDuEsGXXSqff2d8iw20=;
 b=Kzch8KqKmCBrOHbFO8uX4GEGKHKQ7Tb4MNtwD++P0pePGOdEe0BkfzgzUriSwfXSp+PFFTBsvqebwj8D8q1E96HGSpu5QJJv59Cfddnw17nCLRDXwSRAPTS5l4YQTFkvxNkbu1OkIZQ++VCg1HNJOr6uM4Txf8tZ/x+HLkl1RgiyStIEicIpDP7fGbAjdflyqhRCZs6GpCarp+Rk3BwifuVMYpTkuAmkWEiTO3+7c0WFJ9V3EoDvui8gd8+ht/TdCit4rmeyGRcp0t8gnRqE7N3VnzP+NFuOPIDWY5IgSGPFxyuzoRvsDksa8jqEvZ4i5og2Ihc8PfaQwSK4InT1mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 02:10:08 +0000
Received: from PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215]) by PH0PR11MB4839.namprd11.prod.outlook.com
 ([fe80::2c61:4a05:2346:b215%3]) with mapi id 15.20.7762.027; Thu, 18 Jul 2024
 02:10:08 +0000
Date: Thu, 18 Jul 2024 10:10:51 +0800
From: Pengfei Xu <pengfei.xu@intel.com>
To: <namhyung@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<peterz@infradead.org>
Subject: [Syzkaller & bisect] There is deadlock in __bpf_ringbuf_reserve in
 v6.10
Message-ID: <Zph5q+XdNN1bn0Ot@xpf.sh.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To PH0PR11MB4839.namprd11.prod.outlook.com
 (2603:10b6:510:42::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4839:EE_|LV3PR11MB8768:EE_
X-MS-Office365-Filtering-Correlation-Id: df29c5f7-1ca0-4148-a9e0-08dca6cebf78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r3cx5z34k5hSMKTev2cYnezFVvhOA3qCzMMBd3ryexu4saDbxK4/9l0KVlYM?=
 =?us-ascii?Q?1kFjX0svFThuZNRxEspi68t+Zy2yHoSCod44IFeN/HgynU0o9aQO5daslv0k?=
 =?us-ascii?Q?ri9er9wcXLahOqichN5igyNQ7I86+ni3jSEyBz3pEuHA4gbpDXiOltTxn0Zv?=
 =?us-ascii?Q?TDJKL0v/ymavjfdw2vNv+deolziyUH3IQRFUP/678MQACCqQ9uuqyIl+rAro?=
 =?us-ascii?Q?M8lEZKRdyWGWrHjAz+nuAqaI0jww+evsTYMGNLtg3RffogbnCMYP+jq1kyP1?=
 =?us-ascii?Q?8NUxhAo4zgGnaLOS2Y2JPOXgGlyEOPgQpifErdFJ3Nd/GWybi3/FXPD8TYcQ?=
 =?us-ascii?Q?E3hrb4KT4Z2OCot8TIxcP+xGlwftYt3oIp6p2fHHPXL5JLdWa/lCOJOwec/i?=
 =?us-ascii?Q?Ooy902t69Fkqn8x7zdfXzfYtN3MCQ+EaNMysCX+3FfxFtc4Bz166LhA0LPtE?=
 =?us-ascii?Q?R8fBkcTkBFZx3EylQJL9tTDfUHLy9+pVl0HPbUjna0XjXyTGLGj8tYOO+e1r?=
 =?us-ascii?Q?1ZLOvYmAGYusDEx0YtQOwSlrCBjV2prp/NKxV9F4v1GmJmrkG54iyp6jXry+?=
 =?us-ascii?Q?gUnmVgJSTcIQ1krAVh/G1VcKrcTpU2rB0SKITZSN6PfhKva4ferR7DZYV04v?=
 =?us-ascii?Q?wY6hq/XyDt0/Gs6Bp/++6UQ1swai0xdPUoMVUhHczdYHKdFCOuLoyWyFxYiH?=
 =?us-ascii?Q?d1xZp0TiSXbii0MuxQpDW5S3c/HIvnM1zo7pPpS5zzAfyLSA1H+J+p0VePY7?=
 =?us-ascii?Q?BHle+BG4a7e8B7/AXAsq4YhF/gvSSwU+MAF030TvoZUvJCmDukeFwnFOh6nw?=
 =?us-ascii?Q?TEe1qJrVPVxbWMie0eK5WRtEDqcqsaCCE5/ApRsmD6DpDKISFZvjXo9Rn9rO?=
 =?us-ascii?Q?FdNWLhb9U7c8ZLtLkFgOyos3fc+GZwiIu9TMAU6vRNc78zcvioKXH0YYI45f?=
 =?us-ascii?Q?ZfjvrAkdnSgTz95rY1AFDbAIe7NmfAY3F52PfI/9Hzl8aempZySb++DqJLRx?=
 =?us-ascii?Q?kwKT4YnpjtHqD9mMhyN0qxWoyh7FxOqqoyziXpGEkG68+sTRVa6Iyw7NQ5c1?=
 =?us-ascii?Q?830TZMiEsTjvgvqBW/ZCy+pYgs9HBE0deqsy6RsxKpsftC4SkLS/+Sgjsjwe?=
 =?us-ascii?Q?xFbOAhBRsUYeHeszIaFdm/dqzbhFpqJOESiB9d2dR9s3PNVoqf3MS75aEVxB?=
 =?us-ascii?Q?wp3W4NdahHYln8LQezlpKjNeRm1wcB1yh799Nmc9nzimDfS0O2nCteTJa9w/?=
 =?us-ascii?Q?K1vWos/gE5D18XXi8TUOM/VqfTYRoLNt9aJkyg/+xUQmmMdWK0SZf9BrpcfA?=
 =?us-ascii?Q?ggI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4839.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+ehmUCDPCZRzh9d4bI7xmUwHORu3HPjmF2WmCKqjTR4EM3zHZjMGBJs6XBnk?=
 =?us-ascii?Q?7yjBs3ikxXWA2J54dAc0KQGWF2uExKzIgG+0RY3kEWPx5m0nvVUSZlqVjDnN?=
 =?us-ascii?Q?Vpm6AKndaxaiSH7Kwu+zr49ZO0PZiATyjb5jHd8n4J6pJ2/YZIjVom8kJtFB?=
 =?us-ascii?Q?gWxHQiZX97W6dRp8Y3lHJiplS3XQnEvIy/qy+WOWo6l1LqzxDu0RF0JQ0Dkt?=
 =?us-ascii?Q?dhr5iBLLg4SE/iq+tV79krZ/WJ881pP2RStKBYhklSQOHsG2MOpLY1CD9Sdd?=
 =?us-ascii?Q?RxtSYZ0vJFxYnM026lfNjdiuIMUbYjr0Bv6fxns7xoawRBnHl1S9Y1KTaX02?=
 =?us-ascii?Q?exVvqIvBFTLzwpG0zpUbXDw7bQ62Qqqc/uvQjnYpO3aGp8+4zIF4/mZd9pID?=
 =?us-ascii?Q?crgrxzmwBmhaKlj5PcRylo+ZFvg4rTwhd0NzrigWrAEYZstsje4cWrxXnrjQ?=
 =?us-ascii?Q?jbvOxfXtA+VzDAq3TmY8cghjuy9a/KsxMtZrLjXGXSHfsbkBro8MP/Ac/5Zg?=
 =?us-ascii?Q?4mwht0JUg6pJfXe4wCbPJeyzF0dURybCHWQc2De++VnflSGaGMSpYtsOrr9j?=
 =?us-ascii?Q?ZF4ZhtTjyMYk+GgWkQ8A1Da3MFt2V/RiX2R4+X1A5zJE6ghBqvhV3kN99pTm?=
 =?us-ascii?Q?8WDhgvGaC7nz7zWPW20NpmEU8Gx8LDP3XIy0dQxqnI76/70rq9xFAARDIoG9?=
 =?us-ascii?Q?inhLt/9LA7adsV6WPWTQixgLdzW7EyNs/HuWPnuI7+3qb7vXcrgG7r41A0On?=
 =?us-ascii?Q?MUMEcPnAzw6avxBjzJ5yGvyz7BIbNNyD8B+qO2L9vclRt0gtTLsaKuxObVmN?=
 =?us-ascii?Q?d43ADVJ8qcifDIZ9lJzu0I02yuaH0ZRtlhsH3fFx0TN8d1W5wU2oSbAYqQA5?=
 =?us-ascii?Q?Klj9kImLPIBpRAW5u+hK1gq6RHWxn3L3KtwMAMYUBwNUCBeajG/XsIE0MnMM?=
 =?us-ascii?Q?X+XQeqrumMt/CmJ3IR0baFaJ/O7PAx1YH3WMyEzIhC7aL2Fj27GZ6ysB8o/j?=
 =?us-ascii?Q?+iIDE7pjzpdkazR+9oIfiYl58+6Hio68ShwxOtRQdCceqJq0h5DXj/hn8icj?=
 =?us-ascii?Q?qY3iBLLCDEcPjQzpEnt84t090hDbkpq9IQn5JNWfdlZgwVoVmO9qbTgDJZa3?=
 =?us-ascii?Q?EwZOJGUDneTwBRHKzOGmBbVSggyLyCnLngTRvRJkx0T2avL00sCwUQy7CCv2?=
 =?us-ascii?Q?dMEZArSi7Wmkb3+fsMk1oDNLLTMb9jOnRDETzpCD6dXiupFBFVhMYD0CjU8s?=
 =?us-ascii?Q?GjI3ytZi1AkNP+W5ledoxZT1JmMiVrrBCjtDK6wIi0iaUFsxRmfXvSmb4sDA?=
 =?us-ascii?Q?O1PnXd97BtpJXTaFPz/aaV5/zyEDyUHbc8hPGfxaw5Gce5Js27D4KdLtPEOt?=
 =?us-ascii?Q?lr1PI60IXZW7yavhaBckJSOjgb/v/nmtPbphysuMWWTGpDdeq8h734jF2Jpm?=
 =?us-ascii?Q?zWJnUEXu3ucn8Xj/Zdhb5ZTpfgFXT72IlvoTi9pXSqXmrRxK0NkRVV3LtE7D?=
 =?us-ascii?Q?WZjPfjPgmqaKLInDfrMq5gZHRs8JJcKl7Jrk4aorwLR8nA7GhHk/RbTmTflW?=
 =?us-ascii?Q?uEZ2N0MsNU8OYRIFjLxKoZgU7a6UITvAeg4JX+nz?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df29c5f7-1ca0-4148-a9e0-08dca6cebf78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4839.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 02:10:08.6368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzDsQsZrGapiba7vivfdIaWND6XaxzsQW96eExLyNOxDW9vtPv5GKbjyzE0ZRBpgfGKC1Nzwp2Zm0G7hca6mNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com

Hi Namhyung Kim and bpf expert,

Greetings!

There is deadlock in __bpf_ringbuf_reserve in v6.10

Found the first bad commit:
ee042be16cb4 locking: Apply contention tracepoints in the slow path

All detailed info: https://github.com/xupengfe/syzkaller_logs/tree/main/240717_170536___bpf_ringbuf_reserve
Syzkaller repro code: https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/repro.c
Syzkaller repro syscall: https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/repro.prog
Syzkaller report: https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/repro.report
Kconfig(make olddefconfig): https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/kconfig_origin
Bisect info: https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/bisect_info.log
v6.10 bzImage: https://github.com/xupengfe/syzkaller_logs/raw/main/240717_170536___bpf_ringbuf_reserve/bzImage_0c3836482481200ead7b416ca80c68a29cfdaabd.tar.gz
Issue dmesg: https://github.com/xupengfe/syzkaller_logs/blob/main/240717_170536___bpf_ringbuf_reserve/0c3836482481200ead7b416ca80c68a29cfdaabd_dmesg.log

"
[   25.063013] 
[   25.063211] ============================================
[   25.063694] WARNING: possible recursive locking detected
[   25.064165] 6.10.0-0c3836482481 #1 Tainted: G        W         
[   25.064787] --------------------------------------------
[   25.065264] repro/745 is trying to acquire lock:
[   25.065693] ffffc90004f1a0d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   25.066517] 
[   25.066517] but task is already holding lock:
[   25.067054] ffffc900018360d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   25.067878] 
[   25.067878] other info that might help us debug this:
[   25.068504]  Possible unsafe locking scenario:
[   25.068504] 
[   25.069061]        CPU0
[   25.069301]        ----
[   25.069540]   lock(&rb->spinlock);
[   25.069879]   lock(&rb->spinlock);
[   25.070208] 
[   25.070208]  *** DEADLOCK ***
[   25.070208] 
[   25.070741]  May be due to missing lock nesting notation
[   25.070741] 
[   25.071362] 4 locks held by repro/745:
[   25.071731]  #0: ffffffff86fff388 (pcpu_alloc_mutex){+.+.}-{3:3}, at: pcpu_alloc_noprof+0xa07/0x1120
[   25.072674]  #1: ffffffff86e58de0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1b7/0x5a0
[   25.073493]  #2: ffffc900018360d8 (&rb->spinlock){-.-.}-{2:2}, at: __bpf_ringbuf_reserve+0x386/0x460
[   25.074359]  #3: ffffffff86e58de0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1b7/0x5a0
[   25.075180] 
[   25.075180] stack backtrace:
[   25.075587] CPU: 0 PID: 745 Comm: repro Tainted: G        W          6.10.0-0c3836482481 #1
[   25.076373] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[   25.077661] Call Trace:
[   25.078033]  <TASK>
[   25.078253]  dump_stack_lvl+0xea/0x150
[   25.078650]  dump_stack+0x19/0x20
[   25.079003]  print_deadlock_bug+0x3c0/0x680
[   25.079417]  __lock_acquire+0x2b2a/0x5ca0
[   25.079829]  ? __pfx___lock_acquire+0x10/0x10
[   25.080270]  ? __kasan_check_read+0x15/0x20
[   25.080693]  ? __lock_acquire+0xccf/0x5ca0
[   25.081101]  lock_acquire+0x1ce/0x580
[   25.081472]  ? __bpf_ringbuf_reserve+0x386/0x460
[   25.081926]  ? __pfx_lock_acquire+0x10/0x10
[   25.082343]  ? __kasan_check_read+0x15/0x20
[   25.082770]  _raw_spin_lock_irqsave+0x52/0x80
[   25.083202]  ? __bpf_ringbuf_reserve+0x386/0x460
[   25.083920]  __bpf_ringbuf_reserve+0x386/0x460
[   25.084487]  bpf_ringbuf_reserve+0x63/0xa0
[   25.084904]  bpf_prog_9efe54833449f08e+0x2d/0x47
[   25.085383]  bpf_trace_run2+0x238/0x5a0
[   25.085784]  ? __pfx_bpf_trace_run2+0x10/0x10
[   25.086237]  ? __pfx___bpf_trace_contention_end+0x10/0x10
[   25.086779]  __bpf_trace_contention_end+0xf/0x20
[   25.087230]  __traceiter_contention_end+0x66/0xb0
[   25.087697]  trace_contention_end.constprop.0+0xdc/0x140
[   25.088207]  __pv_queued_spin_lock_slowpath+0x2a1/0xc80
[   25.088751]  ? __pfx___pv_queued_spin_lock_slowpath+0x10/0x10
[   25.089369]  ? __this_cpu_preempt_check+0x21/0x30
[   25.089833]  ? lock_acquire+0x1de/0x580
[   25.090222]  do_raw_spin_lock+0x1fb/0x280
[   25.090622]  ? __pfx_do_raw_spin_lock+0x10/0x10
[   25.091056]  ? debug_smp_processor_id+0x20/0x30
[   25.091506]  ? rcu_is_watching+0x19/0xc0
[   25.091900]  _raw_spin_lock_irqsave+0x5a/0x80
[   25.092337]  ? __bpf_ringbuf_reserve+0x386/0x460
[   25.092791]  __bpf_ringbuf_reserve+0x386/0x460
[   25.093269]  bpf_ringbuf_reserve+0x63/0xa0
[   25.093694]  bpf_prog_9efe54833449f08e+0x2d/0x47
[   25.094138]  bpf_trace_run2+0x238/0x5a0
[   25.094525]  ? __pfx_bpf_trace_run2+0x10/0x10
[   25.094963]  ? lock_acquire+0x1de/0x580
[   25.095344]  ? __pfx_lock_acquire+0x10/0x10
[   25.095766]  ? __pfx___bpf_trace_contention_end+0x10/0x10
[   25.096296]  __bpf_trace_contention_end+0xf/0x20
[   25.096755]  __traceiter_contention_end+0x66/0xb0
[   25.097245]  trace_contention_end+0xc5/0x120
[   25.097699]  __mutex_lock+0x257/0x1660
[   25.098077]  ? pcpu_alloc_noprof+0xa07/0x1120
[   25.098518]  ? __pfx___lock_acquire+0x10/0x10
[   25.098951]  ? _find_first_bit+0x95/0xc0
[   25.099340]  ? __pfx___mutex_lock+0x10/0x10
[   25.099760]  ? __this_cpu_preempt_check+0x21/0x30
[   25.100223]  ? lock_release+0x418/0x840
[   25.100638]  mutex_lock_killable_nested+0x1f/0x30
[   25.101109]  ? mutex_lock_killable_nested+0x1f/0x30
[   25.101611]  pcpu_alloc_noprof+0xa07/0x1120
[   25.102034]  ? lockdep_init_map_type+0x2df/0x810
[   25.102488]  ? __raw_spin_lock_init+0x44/0x120
[   25.102931]  ? __kasan_check_write+0x18/0x20
[   25.103352]  mm_init+0x8da/0xec0
[   25.103692]  copy_mm+0x3cf/0x2550
[   25.104040]  ? __pfx_copy_mm+0x10/0x10
[   25.104431]  ? lockdep_init_map_type+0x2df/0x810
[   25.104901]  ? __raw_spin_lock_init+0x44/0x120
[   25.105371]  copy_process+0x361c/0x6a60
[   25.105776]  ? __pfx_copy_process+0x10/0x10
[   25.106194]  ? __kasan_check_read+0x15/0x20
[   25.106607]  ? __lock_acquire+0x1a02/0x5ca0
[   25.107033]  kernel_clone+0xfd/0x8d0
[   25.107396]  ? __pfx_kernel_wait4+0x10/0x10
[   25.107811]  ? __pfx_kernel_clone+0x10/0x10
[   25.108214]  ? __this_cpu_preempt_check+0x21/0x30
[   25.108736]  ? lock_release+0x418/0x840
[   25.109144]  __do_sys_clone+0xe1/0x120
[   25.109529]  ? __pfx___do_sys_clone+0x10/0x10
[   25.109999]  __x64_sys_clone+0xc7/0x150
[   25.110375]  ? syscall_trace_enter+0x14a/0x230
[   25.110815]  x64_sys_call+0x1e76/0x20d0
[   25.111188]  do_syscall_64+0x6d/0x140
[   25.111559]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   25.112045] RIP: 0033:0x7f6219f189d7
[   25.112415] Code: 00 00 00 f3 0f 1e fa 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 39 41 89 c0 85 c0 75 2a 64 48 8b 04 25 10 00
[   25.114082] RSP: 002b:00007fff149665d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
[   25.115078] RAX: ffffffffffffffda RBX: 0000000000000001 RCX: 00007f6219f189d7
[   25.115792] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
[   25.116487] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000007194fa985
[   25.117136] R10: 00007f621a028a10 R11: 0000000000000246 R12: 0000000000000000
[   25.117793] R13: 0000000000401e31 R14: 0000000000403e08 R15: 00007f621a073000
[   25.118449]  </TASK>
"

Thank you!

---

If you don't need the following environment to reproduce the problem or if you
already have one reproduced environment, please ignore the following information.

How to reproduce:
git clone https://gitlab.com/xupengfe/repro_vm_env.git
cd repro_vm_env
tar -xvf repro_vm_env.tar.gz
cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v7.1.0
  // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65 v6.2-rc5 kernel
  // You could change the bzImage_xxx as you want
  // Maybe you need to remove line "-drive if=pflash,format=raw,readonly=on,file=./OVMF_CODE.fd \" for different qemu version
You could use below command to log in, there is no password for root.
ssh -p 10023 root@localhost

After login vm(virtual machine) successfully, you could transfer reproduced
binary to the vm by below way, and reproduce the problem in vm:
gcc -pthread -o repro repro.c
scp -P 10023 repro root@localhost:/root/

Get the bzImage for target kernel:
Please use target kconfig and copy it to kernel_src/.config
make olddefconfig
make -jx bzImage           //x should equal or less than cpu num your pc has

Fill the bzImage file into above start3.sh to load the target kernel in vm.


Tips:
If you already have qemu-system-x86_64, please ignore below info.
If you want to install qemu v7.1.0 version:
git clone https://github.com/qemu/qemu.git
cd qemu
git checkout -f v7.1.0
mkdir build
cd build
yum install -y ninja-build.x86_64
yum -y install libslirp-devel.x86_64
../configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
make
make install

Best Regards,
Thanks!

