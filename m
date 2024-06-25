Return-Path: <bpf+bounces-33025-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7401D915F1E
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 08:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E948A1F23688
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 06:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0919B146597;
	Tue, 25 Jun 2024 06:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZbYBftu"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BA614658B
	for <bpf@vger.kernel.org>; Tue, 25 Jun 2024 06:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719298528; cv=fail; b=laSXXPZUbduhcf1ZxR7bC9Qm8TPS7/z9lhfXilwfk9c3aBJvrA1NBE8IiU0YKy/x/8nUlUAkVN3LYsmvH/pWxDY927SuS1JZctFHLfaMOsG2lkL2OuIhpYopJRL1Vyvd/ztjt+mNrx6hes+saWhLIwQHfyttWAcePn60ii8mduU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719298528; c=relaxed/simple;
	bh=yCGfE3KM2gkh9gVGEuMaagT9P8W9D8rZc0wmtwIZqR0=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=MZ7UD732gZ2+wTH4/F2OAaQVaMPMlQvGBCNOlBDqbyoVf4eow5T44WSTRlm534qDjyPq7S0fzoWbpKg9UPsbXU9c3Vcu2jYFkWNb58GgFn2op5ds+hCqO5Ssqc+uhNTAfX1gTOo1MSDnq0xMpYOBfx05Q/7hn7pFTKeZYVdpdjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZbYBftu; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719298527; x=1750834527;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yCGfE3KM2gkh9gVGEuMaagT9P8W9D8rZc0wmtwIZqR0=;
  b=PZbYBftuulw1ZUnjqslgOg1xurecR6msjHXi+f2Pgjb8ge/GKA5HJCFq
   K1WqrxcvRyINmmTk6QdJL9jCMBM1aXzK8V9tAb8Fx4s8kCDCBxsdkEJwl
   EfQfOqX8JPBKZHXjOz1cf6BkJ76NhpT1IBOrqJ4+VoII7FvdODo1ObvDd
   HiwF9GbZUa6T56fMLUFj+c2iCQqsP5forp1Pp/iUrA/Vz3yiAfdJCiNed
   puowbl63SZYxWtjzwUIhmlHvmMruoalfGZVQVlq3jqb8JncrVfcIzuAAX
   vh5RrX9rXqAqs+aiseMIqwMHfe97Z7+dznSPIn/MXhPIgsAfqjMXmtZSh
   g==;
X-CSE-ConnectionGUID: u9GoIFKATs6zSLmWw25xaw==
X-CSE-MsgGUID: wSssiD1wQJ6SS9lhImoRvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="20070251"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="20070251"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 23:55:26 -0700
X-CSE-ConnectionGUID: VxF/amnxS9OpeNSzedFxzA==
X-CSE-MsgGUID: zlccMD6dRW+MR7yzmBIKaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="44195358"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 23:55:25 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 23:55:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 23:55:24 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 23:55:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VYJo61cfXQfzdzJ2hy7lbXE6JaPsPgPptzbV7djyTZCH5W8163etq3WhBT7DdzF/Waur2NdvPnwW6REd86LpSsKllWzAK+LIQEAPcpy9dYiqaMXJafZdZuHNc7hNgETuA33U/MDysc5xlP5FOKO+OwVQhl2TyhfsTweSQ9IJN0RwD8L1Oc7A9ZR+bFdTMlruxcviZpzdQRvJM6NOUtkN0moYu9XLIry891XNkhNBg0B/1GOhX3qSg717PsK2vTP3EYvpK96N011TKSp5CuVQiOyw228SM6cFhOTYnYIEYIinNP5SClK6ibRl29dL2hgpnAPEmYsuv0omysUmOS6uhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VxIRFGZFPmVyeUimZbz80HepbiDNjyUSzVznK8rGRno=;
 b=iTrivMDooljCpQkoJl76Jq4oxjtWHKObDZY3e899ZPNVhCL8FRErWzjVhfW2mxxdpit/gzyeLnpTvnx4kBNleUx9C8F8lEUFglPnd6JyB/yHMkV0UGqeFNTufHmG5lRN1NgBvvulupW6ouuhuIdmawE/Oag5DrCdiShz7gf1LiHiNcAVwLrNbOhAEE7T34V3Mp6o5wsT9fulciqpISYP2I+N19FtB0tkI6rnc9j8Eso6i39ZhHR0xvrRdGfeydqwuNW6v9kG/EkjNwuC+KfuYjqaqXgeJk4QT4Q3IR1jAoBJVzrwU0jXW3qvOyyrJ06ZzH7wFD4XTo9WoBe0oBtjFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW3PR11MB4652.namprd11.prod.outlook.com (2603:10b6:303:5a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 06:55:21 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 06:55:21 +0000
Date: Tue, 25 Jun 2024 14:55:12 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Leon Hwang <hffilwlqm@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, Alexei Starovoitov <ast@kernel.org>,
	<bpf@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [bpf, x64]  f663a03c8e:
 test-bpf.Tail_call_count_preserved_across_function_calls.fail
Message-ID: <202406251415.c51865bc-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW3PR11MB4652:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c1493dd-fd87-4b8f-a162-08dc94e3c833
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?vlA2kVT1cgyajBOqXT+q7e0c3C7/F9SA51zho6u0OvdFzQ0wNuMuIyguwCs7?=
 =?us-ascii?Q?/ddj9xACBT6DGDB0Ue3MvoXRXd1KdjdRbnPZKtyHOHefRdXUZRwAaZ2P+vRK?=
 =?us-ascii?Q?mq10TkqO7vp1RsFyWbFbaJmsy37CBxhaMjjJzdqugrRv2ctVXhrrKU5Mah55?=
 =?us-ascii?Q?4I6yiGRsPl8TMXLr3URMsCQQFSTiT7m+nTQCV8pvn0AFW/T/vRILvOR4u1Fs?=
 =?us-ascii?Q?lq2HZmS55aQKFL7UqlHbDCrQX2vs+EQifki1DsxVUpGnofbtvoU92AcHkFf0?=
 =?us-ascii?Q?pWhYuFnBebjjzeZrDQCjZEc37YBMUhLv+H1wXZRKidOVsA7mvew08UgQ+4sP?=
 =?us-ascii?Q?rBzHZuLGMedqd23mBvxunR7eIJqxxOiuMobaLZfFF3vKLplLS38Knpa/9ZpQ?=
 =?us-ascii?Q?dfhL46pLrmHtHD5KD8xnj14vT0HssMBH2u8NmkpZ9vBaUmSL2VppOEcPvCKl?=
 =?us-ascii?Q?dxREuPbQyHERHdxZQA3Hd1JZE8Dtae3mgpgEW/DziOOycU4JaZn6bz+sP/Mn?=
 =?us-ascii?Q?GNVO3qRfQsZTCaVMUjdWl1Gk3HQxBJDI1kT2HeoQCdaPk/Jrikqj+ZE6alde?=
 =?us-ascii?Q?mZdLAoj+35Rgkpt8y1JRIOBAVpDaV5yaqfn2+rTm4OdKxueR5JAbYQLQ1XQt?=
 =?us-ascii?Q?DTQkXwObrHBqsPGAH+YAvXidDmLgUNQWNUGlIjIko24THHfaDoWKcA6bTC4a?=
 =?us-ascii?Q?y9W6NgbnhJLqOPAvxBbBPReusLHG7O8cQyN0feCwCSO8rpcTbkfuxbwri/Vn?=
 =?us-ascii?Q?lLUSTgGL87r8u2lxMMBSOnNn7BNlSZmseHCPa3tu2MaZPm1I8bbaoceUpgNr?=
 =?us-ascii?Q?WKFWu0ulZpUK/y9UBf3MgVbbFcHACYsuD9Jk5hvFwn9WEERGE6CfnwfMszsP?=
 =?us-ascii?Q?lSWjzNywAMsEBeLU3q5sqv/I5Ul5MoI+r0a5onQ3zVmWel5cKpN18YDBwMHQ?=
 =?us-ascii?Q?im5CoQzYdKU6AC6qJAxcX4A+2xA5J+L1fewy9avr/tOBoLHYroeUy2DpRgyv?=
 =?us-ascii?Q?Gjhx3aGy29sx/VSkvcwm+NDw3Mk4rUATttwwWUyBXc39ZIPsQB34lIJvcYGd?=
 =?us-ascii?Q?VvMU1wa4pNYmQhUhrcKQ8RKPtJcZ3x7IIfF7Pw9ytOu0NXooxduTaSziOh9c?=
 =?us-ascii?Q?Wj3E2ioCQnKtBr32g5EMdvSpJzgZUndgZN6AQx5bHj1YpeCS7/zOlT7q+64Z?=
 =?us-ascii?Q?+Ye0R0VR0qvpzUY6C53A24Lb7sC364IgkiZPC89zBNzFmCEoQHAIqNu/XYE4?=
 =?us-ascii?Q?K3SuaD1omubeaS5uEVjUhJe4/SktZhhgKEmj0/D37g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bBDdJvK6BH2QLOQmmXvuGuVGLe7iAap+0Rm+phepIqcvFuBD+QSRFSZ97M2u?=
 =?us-ascii?Q?6su5s4wvBTvKzpnUJOZYlu9z0679D/BGAT1b+0yMhBLu2HEYg6f8TE+1aFjb?=
 =?us-ascii?Q?BiHzSjtIX4Q6cwXoPeJTSCb0iK4c69ZDpnzPpamTxxpI15MzRsiJ176IDEhe?=
 =?us-ascii?Q?O+rohNgq0dRoOG2JSq/E5sNRo3XSzJ7KtBiD7RLcM4Bnkbcxf6W+uoAWdGMV?=
 =?us-ascii?Q?ysSo4nHNX5DYF03hGcUJ3hZ0JyYHf/LgmnXYssrOR0tMEmtkOWbwsVz43gB3?=
 =?us-ascii?Q?sdwS/jpdWpPiS4tRwOGgQkne+Cq5+FooezfqD/Wiwrgdp1fprxuwTCsWgBVU?=
 =?us-ascii?Q?Uye0jhQdzJvdEiBMSkN5jmUqL7Tt3HSGEr5lj/cH1ul3S6q1LL2BkgxStzVl?=
 =?us-ascii?Q?j3a1yWlGZzJSsUF5KDxrLBpbIoC5kLUpHH424rDhmxhgjEKCe1FjxdsIRHUg?=
 =?us-ascii?Q?0KDriY94pGrDBE2qy0LqHwZ9quw1LuXXYT1/apifaKc4vXX1MOtRZ9GR9NIV?=
 =?us-ascii?Q?soGHcZkOl4QXpSiM+wRzxppXAYM1NdzIY0R/HWgjWbVQiAd31eDB2AQSfChp?=
 =?us-ascii?Q?Zwesho1EQbyCQBKys570OSIqJvR6M89Xg3Gc9PdEoMb6x1o6U0FJDZmtlPQS?=
 =?us-ascii?Q?b2r3vZVPEDFLkokJOpnWAWatQ3QTNWo9TPMDp4jLuKf2mM+G6IoT5vTcfFhv?=
 =?us-ascii?Q?NWJ7IffdYQZgw2QY5hgRGndp1b88OIfDHaX6olKUzK+h87Cq8hHgWIO2hl0u?=
 =?us-ascii?Q?NiP8YPHCnX1rBMpStgLKSvDr5sV8XZXEYQv6FDclLSpOWAgY0tzpU4mvqTip?=
 =?us-ascii?Q?lEROsSXNEiGZ3WHe0Zkxvr+poOXdcd9k91NQbsfUfurx5e/hYMLvIhJz1Deo?=
 =?us-ascii?Q?Vs1xvskUEQ/UVakwMrqU27BPJyoOdy6N7l6knjaAsx+PBcv85i/edmmnpBbx?=
 =?us-ascii?Q?FcfAN7KsQOaPMIB5qkFoOcB87OsdZ4XnKVefb8DUikHHzM4qcatNf3F/BGVM?=
 =?us-ascii?Q?OkJc/uRca/IuAEvEbEQaWfRRiXbcOuLbVIHEcJLhO4rhh1TlWenAC3wdw/qf?=
 =?us-ascii?Q?A/eJDLLm7q0sIyBrhc6yru8ZzpJy3g9kt/FY/WIKr/dZhVVhR0bnCvE/qJ47?=
 =?us-ascii?Q?CJlS+z2/oEj3DqHIuBi3Q/3Sj6t9BsyOXqhofg4mZeiBqiTI8MnGwImFxI9t?=
 =?us-ascii?Q?eXXPga738LJAF5C2QMyJgibzBixlDnJ8W+Ekur2gXODmB1ixeqBnq4OA04Fi?=
 =?us-ascii?Q?mk0zeahxo5/rPezYOK+LGe0+/NQ8ETw6hDWMKMImDBB1aPVMxRv5pkz7SgPn?=
 =?us-ascii?Q?nud3xyYU9JwKpMh/K4VhGXPeOgvZO0k2giXc/v4oXI3Fi5DkuxXWwL1WdfX1?=
 =?us-ascii?Q?229rYxZMIK3fsfPsQAgI4gyA66T1el1wvLB7fKTFa0TxKKv7XwhwjWNxTGZL?=
 =?us-ascii?Q?wRe4AEcj53Ihi61hDWwylepnT7C87IlVzDr74Sr8dyjZchbXWmp4+17jO4rc?=
 =?us-ascii?Q?mBkovRqEPSxxwv2GL5rcZCGQWK7rDsIPswzYJNQ7vze77qrLMffXuqGboiw4?=
 =?us-ascii?Q?lyWVbz0gKUtIq1a/yr7MEkbIqf6f1DJemNJksq7nRLDhintC5+MXUEaHFtia?=
 =?us-ascii?Q?QA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1493dd-fd87-4b8f-a162-08dc94e3c833
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 06:55:21.7762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: srMPBBweey9KMzzr7m258olQpRIUrgWd/l7pQ52/AhNVJVdtsQ5rKVNT+SrvJgt3rrDXRBUakP6biGw4BTsvig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4652
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "test-bpf.Tail_call_count_preserved_across_function_calls.fail" on:

commit: f663a03c8e35c5156bad073a4a8f5e673d656e3f ("bpf, x64: Remove tail call detection")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master 62c97045b8f720c2eac807a5f38e26c9ed512371]

in testcase: test-bpf
version: 
with following parameters:

	test: non-jit



compiler: gcc-13
test machine: 36 threads 1 sockets Intel(R) Core(TM) i9-10980XE CPU @ 3.00GHz (Cascade Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406251415.c51865bc-oliver.sang@intel.com



[   43.913560] test_bpf: #0 Tail call leaf jited:1 5 PASS
[   43.913572] test_bpf: #1 Tail call 2 jited:1 ret -1 != 3 FAIL
[   43.914138] test_bpf: #2 Tail call 3 jited:1 ret -1 != 6 FAIL
[   43.914756] test_bpf: #3 Tail call 4 jited:1 ret -1 != 10 FAIL
[   43.915374] test_bpf: #4 Tail call load/store leaf jited:1 5 PASS
[   43.915993] test_bpf: #5 Tail call load/store jited:1 ret -1 != 0 FAIL
[   43.916636] test_bpf: #6 Tail call error path, max count reached jited:1 ret 1000 != 34000 FAIL
[   43.917319] test_bpf: #7 Tail call count preserved across function calls jited:1 ret 1000 != 34000 FAIL
[   43.918799] test_bpf: #8 Tail call error path, NULL target jited:1 5 PASS
[   43.919720] test_bpf: #9 Tail call error path, index out of range jited:1 5 PASS
[   43.920474] test_bpf: test_tail_calls: Summary: 4 PASSED, 6 FAILED, [10/10 JIT'ed]



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240625/202406251415.c51865bc-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


