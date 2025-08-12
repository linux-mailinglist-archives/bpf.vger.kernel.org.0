Return-Path: <bpf+bounces-65409-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB15B21AF8
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72737427C5C
	for <lists+bpf@lfdr.de>; Tue, 12 Aug 2025 02:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05162D780D;
	Tue, 12 Aug 2025 02:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuxdwvXT"
X-Original-To: bpf@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC5820F07C;
	Tue, 12 Aug 2025 02:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754967081; cv=fail; b=Q14OHbEFpSlM9ifyxyFuRjVd4mO92CFu7XY17irewrfK7FUJm1qnsF7YcyX1j+77sovqB5olV/pK6T1+g4rrvgzr939mA8xhFa7BtWwuIz+tgQ+Ex1SCqNdlaWLCRR+hyZpxWQIAvgpPtgZ0nWmozNUL9sC6crFUnP0TAt9rBgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754967081; c=relaxed/simple;
	bh=pwXxpTbqCJ3mVoE/NAezn7dmNizN6jOoB6j6GTflruo=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yo7kGr5G93iKEc5Hf9a0n4ILdR+P6n3WFAOiIo9XiJA8wCqbCgtnbKg8xgsnNwEnCjL5kFDUxLjfAJF3UfVBnP5DCd6HL/14/IbAemwsLeqIjRm93MkXjTh6yXyOqEDsI+h/6uG8c8hQowRjpdNfE3V1z+Y8yw8lG7trYqUqTUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuxdwvXT; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754967079; x=1786503079;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=pwXxpTbqCJ3mVoE/NAezn7dmNizN6jOoB6j6GTflruo=;
  b=KuxdwvXTJ92pO2KCsI88Qc6Qingg6IkKaXDsTQKtv3LRzxGjUfZHyUnv
   jtS9gSdFwJGh9DNfi37/LdYEkUFvX9xAXVQZQWLDjKDKrjIyjuPEBBqX+
   PzBZieSkpSSDak2/cr1JHvp1w4RO7tMT/OuYyhvcoie0QUA1jue3BQdvB
   Q/H3OTG5KjUkNgQoEHBwMaPaansmVSjSxO1Ahrr/9NpxK4+K7GBoZVBLd
   EQSk4fB/yaXB6zqDhjsF9JZr/iNIkMxXW/7SaX/rCbOl0Ke/ljvdXPpZ3
   ttZT0WZ58NRe270mkexnylzMj4SmpGCoxpnDGk4bEvG/Yw5zjTnfFnx2/
   Q==;
X-CSE-ConnectionGUID: F/vbRD6qQGGzziifhpyyww==
X-CSE-MsgGUID: AhQUVU4JSxi+zneIPUkOMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="60859178"
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="60859178"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:51:17 -0700
X-CSE-ConnectionGUID: rtTxiyu2SzqfmgfC1ZtmoQ==
X-CSE-MsgGUID: fXOnAShUQEKnpPtxgkfCdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,284,1747724400"; 
   d="scan'208";a="166369353"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 19:51:16 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:51:16 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 11 Aug 2025 19:51:16 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.47)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 11 Aug 2025 19:51:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcMsggxi6MaMVzwrc7OkMlt6IqxSYIhYpVBTBRHbc6/3clCvXDtVpVblSK9kHbVj4YTCcbpTxunWJH9NQXXY2bD7p4qWugnQzE+vtzHvkssUYeidk9GQyayrx4TqN7OsBHs10m3vZ2ckguI0n4AO4H9v+cuYuDeqfFkpgxDG50B2BClJZpCq23/3zhHZAgOGqeBVsixobluWWG/7VJRaN6LIOrp3c31dJbLI2VPk5VWPBSe48Ut/xqIfr/y2OUh4M3Vob7vlJ/0Xov78sidR/3Bnwtvh9N8Fwiq6W5SpahHG6zyicRanog8Hz0De/eex/FnODO5VFMMKCPqYmiqFPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiiJUHXa6KuhjxCPrgNB+oskxHPqqNp9a8lMiITbE9k=;
 b=dC6+a7ELSHTsJ8SmQZvqxHiypXfMUqw4w0U/yfpe6TUkG2P7IymI+3wpxKLuQ4JwML6vuHJloRSvuGS/ZMFKD6JgypK/QpswZ04gbw+Bk2/WuArqM3opiBedLdsBDkBH9CZsbnEUOVnOzsnEmTgv5Fars8537CsQiriFR1JAeYIuMtaDt4mJivtTxu5/ZmTYXQcoecLPON34hwQtrovRX7vQwV65Xcq/6SyVLRshN46st9h4tqlyVLHUgr20GleelV57oLIAPu25mwCb9aFFBoDarITt8vHCO9GKipb4XdTXcs0P5Y6aBnZsNacDZKKDHwwzK7RdTsDszR3czgmzKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by PH0PR11MB4885.namprd11.prod.outlook.com (2603:10b6:510:35::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 02:51:13 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9009.018; Tue, 12 Aug 2025
 02:51:13 +0000
Date: Tue, 12 Aug 2025 10:50:57 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Menglong Dong <menglong8.dong@gmail.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Menglong Dong
	<dongml2@chinatelecom.cn>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, <aubrey.li@linux.intel.com>, <yu.c.chen@intel.com>,
	<peterz@infradead.org>, <alexei.starovoitov@gmail.com>, <mingo@redhat.com>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <eddyz87@gmail.com>, <song@kernel.org>,
	<yonghong.song@linux.dev>, <kpsingh@kernel.org>, <sdf@fomichev.me>,
	<haoluo@google.com>, <jolsa@kernel.org>, <jani.nikula@intel.com>,
	<simona.vetter@ffwll.ch>, <tzimmermann@suse.de>, <oliver.sang@intel.com>
Subject: Re: [PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline
Message-ID: <202508120411.6173c4f-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250810030442.246974-3-dongml2@chinatelecom.cn>
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|PH0PR11MB4885:EE_
X-MS-Office365-Filtering-Correlation-Id: e95a382b-d65c-4c2a-aa59-08ddd94b19c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EKj+QDcBr+ldiJv0q3Os3Z1HmytjPa43ySpeESe4TBvoX/Wg2PUINw/ACVYV?=
 =?us-ascii?Q?GAnBJItdp0Bh0G0i4w2rjnnp96+9kEazK8DL+FKIcLiYbWAP8UZxfLrnQ7zT?=
 =?us-ascii?Q?sqSIl0opQr8ekz7+ODrL7o6WgncicEajr9PNFE7t5Bky6x/fRiOeiG0FsaUP?=
 =?us-ascii?Q?sA9z+iXeiA1cE8pivjx1EAbrYMUL9OSRp+fqLXvEkYCjIn0yBArcB/U4wwxY?=
 =?us-ascii?Q?FhjjyNUA83rzU7XxnCo71y5rk6x3SfEDh00s7Y8JKJBXhzlC3KLX1MQu0ZL2?=
 =?us-ascii?Q?FtCnjSI+CQxgA+mQKTMXod1lr412WnKN3+d3YVleQuCsdHHCe8KDzfQ0C98I?=
 =?us-ascii?Q?i+8Pd8QdCuzcE0KHTV12YnHuezHZT1tpY50w/880VywOe9eRQJtElnX43WGa?=
 =?us-ascii?Q?0/STGgKSe2o1qSmEWza2XJOxA5W8DFmRiWbgOBmXL1eVxwqhYnFPzvPVAkhL?=
 =?us-ascii?Q?+hm2UF4nuTQqhgdI0eYDMxsV48Uf5MOv0eB/AIPnezRRJZNHLoBw/XY0v/EZ?=
 =?us-ascii?Q?lWpf6iMZCtnD6bZsWxOdGnn9TcXlCqMArL0WhmOaRs1A8exClOsJEedcF+BW?=
 =?us-ascii?Q?8lFJ2eyV9rSh9p6gvDgIAQWBcirCGpOUYCmVZ60MfbiSUurbXjnP20wewmcY?=
 =?us-ascii?Q?P1em2uNxb6WcuN5goRCnPkPTokqDSfkzVgP/D/HJSonX6JfBTbmoWzdW11gK?=
 =?us-ascii?Q?sXtsh+k/tC3Yp14yrio28omuz+IyR6LuHvSPfuKkHH09evbBg2sZ2ZTZjipo?=
 =?us-ascii?Q?UyMLskjSO5CAnZC3WzhxNzmONM07NvqNruzOirwjgo/RgMd4IMgI4lY2ovLZ?=
 =?us-ascii?Q?nbwZXGgTPFwhjBOef7cLKc31fQUXaRTchAfsDYziPlqovMdMT7tsmB4fboEA?=
 =?us-ascii?Q?d2tUdOhGP4FXFcE/2QqnjN4HPlwA5A8+CZvsyaR6xr6g6t2DA2WuKEQ1dle7?=
 =?us-ascii?Q?kRP+lNgbwkUaBX/bQIvUlqLzgVoKhyo6Ww326YRgPbBVQaKIfZKHtfVHRRVT?=
 =?us-ascii?Q?1Ka4a9DcjST6+YQDVQ2T8C44Bc+bkK6tDYFoxW4ESngnLZS5qXJd6qftSOl8?=
 =?us-ascii?Q?hmMsUhilz6KQZa7nOk+Gw/slUanmzkQu2K56F71Ov0/9tYcPBfX19Sv2o/OA?=
 =?us-ascii?Q?hf/C6ApmFkYOS3RiEO0quuIU1GqDH52YBKrCJwavt/7Da4wNc2gmhNTRqOJA?=
 =?us-ascii?Q?Da5G+BT/3Sj1s4aqY5njWvnj+qEyfDfVT/9HDZh7UfP0/tkhNJssuGh1zqbw?=
 =?us-ascii?Q?AXuzeVACplmu7JUcYv19lV3XHKNkaeyfb188DT8FUndXtii4aFUls4aVrjYk?=
 =?us-ascii?Q?5QI0MzKcBI7oYFeqfMB+2pX3V4lKXF7iPFAF9PG+/dhTAX13nYiNvDB4R2Hw?=
 =?us-ascii?Q?GVpfqp0SNGWsODUQZh6liaE+tEhk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9dHmz8oleJl3a+95ZcRwmX8cfV/ic93OL98U/4XK/JVofozcZeEi8rQAyJif?=
 =?us-ascii?Q?UuaMstI44uN5HI0j5U/Ho3jBwt3Ggyfg0dck9TKeJryQP5ilMYMD8moRW7hA?=
 =?us-ascii?Q?std283dT9RrwrDeSWG+h688q4XNiG1heU4YpE33yNVuallSTU97gBySeeZ9V?=
 =?us-ascii?Q?3wEUDSDJa03jynyq9DHcLFKKT7tUBOrd7UEIDh+luSoeKH16kGCMdtw70NDw?=
 =?us-ascii?Q?/yjlFPyoVty1dSe+akHrhGrNOvIwREYvOkJQizDXvsF/yeKlqkzC/JXu6gSq?=
 =?us-ascii?Q?D/XdB//VVU8bLv/J0CclqrC6jmHvH8/zHdaXHlYT/7/0JRrjeAqDQO6NEtvk?=
 =?us-ascii?Q?n/o37rjxUTn8R1X6ylgKiYTRXBiP/VeUL/hmZoMjVLJyjd6+/LGoXEQl9a9L?=
 =?us-ascii?Q?QGICTMiJL9EGOlQtOhCLQxE2tGLtgrOea036ZLHCOcl8f49t424A1XBdF0t2?=
 =?us-ascii?Q?ElmzhB0PYeiNLnK2VBXpoZ8MyDi/uxyk5hfFeG3djjIzeE1PRKya67qLd44R?=
 =?us-ascii?Q?G6dwTsM5LyBTOcfGz33CVslEkIcKV67M0YdCHmocc+jGOgqv0jH25gLiqWit?=
 =?us-ascii?Q?n9M0MN9RrXYpYGJk3f+uElANh+x6VjD9ACDNY6NW1mYPB6ol+nIT9DnMh1iX?=
 =?us-ascii?Q?JeLa96/ru0z7fZdc/9vMc71M65y7vYfo/YCZsWW+5geKP0Ww5hNP5Z4TQHUa?=
 =?us-ascii?Q?fpj6O6jLJrXx9e6W6pUeMdvW4s1TGGqbYF3OrZsoAWcq3DLSArByhlBxecJ5?=
 =?us-ascii?Q?OVPaduxHKFTDDuHEkCGURGoqzUFAcfeKxzJbZ2XntIpjHvmVfJ32haI2UvOd?=
 =?us-ascii?Q?Lvfr+LqTT6FicxCflRiDENLKr0RFg5yjcFnsgJ3gaNsL9kxt8o+QDArjuAPq?=
 =?us-ascii?Q?nfLf6GlBibG8umMIsJofhJH/8gcckqUHM7vLWd7n0+NJkrQM/2jZsMalY+rM?=
 =?us-ascii?Q?jXQvp+1OgtcVmMWR7/VbAvJ3aeuoJmKEaCYRfBlpslkjr0E8HILVCYND5W3i?=
 =?us-ascii?Q?gaEPwVX46FcHRbqPSIpvAGZZlXcdtOoxrmYgI/qGVcpLV2nqChmjU25uAG/N?=
 =?us-ascii?Q?LV1LltC8F5dT4Nj7tfATZMtI/XZtSMAxkbT+UyAzMYZ+CHEkP7+5ZHg+TJIZ?=
 =?us-ascii?Q?3tmSj1RTJ+hvG5LgpLi4CGvE3NrPTAWRkou3VACBCAheKwurSMteQlqaHwLz?=
 =?us-ascii?Q?r5QhrNAqptz2No8WfyJ95/qKvAGlXhjVnOHBIztGKtoAMFbq6zxHamcVQ8kE?=
 =?us-ascii?Q?Pvls1x6avC2ViThB6Wb7jz5hmbo4jSKQojuoa7KW530k21KbVvZw7DHdXNsr?=
 =?us-ascii?Q?PfTvgpiyxxJkub1w3MeX3/z/GGVgFnSuQnsX16g9CtMjm5jGgARxTp9P1YQs?=
 =?us-ascii?Q?FRWOy5HUeufKEZphMZabQntcL5kHVaf6OgFz+/doyH+E4Kb41NqeIqAhpWPH?=
 =?us-ascii?Q?VCpC3Ff4dw7FmDzWg2SZAOOUN6LNWtNCgoUXW2dg7Ir3zW92TSMkYqG+omDY?=
 =?us-ascii?Q?8JJYFXwcqWmkFjjzA/uMiKmnXvYbLpoCf7Il8uHbOZkPiuvq6tzPTmfsrfvB?=
 =?us-ascii?Q?Jh25+TxTOw9ehWjGs+bfxy0wDPHJIWoU6JCnb4IY2Tc6icb8uq957wTXocYx?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e95a382b-d65c-4c2a-aa59-08ddd94b19c6
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 02:51:13.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhiklGyOy19XO2XWaYe5loqtXwB5WpKHI/apxTB7/sHg07cybUVY/vTZVp6aZ++JzN1pkJIGvXU2jaZ+D1CReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4885
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:using_smp_processor_id()in_preemptible" on:

commit: 10f0da02e16093e603e5f82fe735f836a3791ca0 ("[PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline")
url: https://github.com/intel-lab-lkp/linux/commits/Menglong-Dong/arch-add-the-macro-COMPILE_OFFSETS-to-all-the-asm-offsets-c/20250810-110846
base: https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git b2fc521b40b9e94f6fe2cc9820b14ae67d8fe891
patch link: https://lore.kernel.org/all/20250810030442.246974-3-dongml2@chinatelecom.cn/
patch subject: [PATCH tip 2/3] sched: make migrate_enable/migrate_disable inline

in testcase: boot

config: i386-randconfig-007-20250811
compiler: gcc-12
test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+--------------------------------------------+------------+------------+
|                                            | 51b2cbc934 | 10f0da02e1 |
+--------------------------------------------+------------+------------+
| BUG:using_smp_processor_id()in_preemptible | 0          | 6          |
+--------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202508120411.6173c4f-lkp@intel.com


[   25.544225][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[ 25.643781][ T1] caller is debug_smp_processor_id (lib/smp_processor_id.c:59) 
[   25.657229][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-12127-g10f0da02e160 #1 PREEMPTLAZY
[   25.658066][    T1] Call Trace:
[ 25.658066][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
[ 25.658066][ T1] dump_stack (lib/dump_stack.c:130) 
[ 25.658066][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:51) 
[ 25.658066][ T1] debug_smp_processor_id (lib/smp_processor_id.c:59) 
[ 25.658066][ T1] __kvm_is_vmx_supported (arch/x86/include/asm/cpuid/api.h:29 arch/x86/include/asm/cpuid/api.h:74 arch/x86/include/asm/cpuid/api.h:113 arch/x86/kvm/vmx/vmx.c:2743) 
[ 25.658066][ T1] vmx_init (arch/x86/kvm/vmx/vmx.c:8557) 
[ 25.658066][ T1] ? pi_init_cpu (arch/x86/kvm/vmx/main.c:1028) 
[ 25.658066][ T1] vt_init (arch/x86/kvm/vmx/main.c:1033) 
[ 25.658066][ T1] do_one_initcall (init/main.c:1269) 
[ 25.658066][ T1] do_initcalls (init/main.c:1330 init/main.c:1347) 
[ 25.658066][ T1] kernel_init_freeable (init/main.c:1583) 
[ 25.658066][ T1] ? rest_init (init/main.c:1461) 
[ 25.658066][ T1] kernel_init (init/main.c:1471) 
[ 25.658066][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 25.658066][ T1] ? rest_init (init/main.c:1461) 
[ 25.658066][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 25.658066][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 
[   25.815107][    T1] kvm_intel: VMX not supported by CPU 0
[   25.822075][    T1] BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
[ 25.833038][ T1] caller is debug_smp_processor_id (lib/smp_processor_id.c:59) 
[   25.842786][    T1] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0-12127-g10f0da02e160 #1 PREEMPTLAZY
[   25.843623][    T1] Call Trace:
[ 25.843623][ T1] dump_stack_lvl (lib/dump_stack.c:123) 
[ 25.843623][ T1] dump_stack (lib/dump_stack.c:130) 
[ 25.843623][ T1] check_preemption_disabled (arch/x86/include/asm/preempt.h:85 lib/smp_processor_id.c:51) 
[ 25.843623][ T1] ? vt_init (arch/x86/kvm/svm/svm.c:5494) 
[ 25.843623][ T1] debug_smp_processor_id (lib/smp_processor_id.c:59) 
[ 25.843623][ T1] __kvm_is_svm_supported (arch/x86/kvm/svm/svm.c:429) 
[ 25.843623][ T1] svm_init (arch/x86/kvm/svm/svm.c:456 arch/x86/kvm/svm/svm.c:5501) 
[ 25.843623][ T1] do_one_initcall (init/main.c:1269) 
[ 25.843623][ T1] do_initcalls (init/main.c:1330 init/main.c:1347) 
[ 25.843623][ T1] kernel_init_freeable (init/main.c:1583) 
[ 25.843623][ T1] ? rest_init (init/main.c:1461) 
[ 25.843623][ T1] kernel_init (init/main.c:1471) 
[ 25.843623][ T1] ret_from_fork (arch/x86/kernel/process.c:154) 
[ 25.843623][ T1] ? rest_init (init/main.c:1461) 
[ 25.843623][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
[ 25.843623][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:945) 


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250812/202508120411.6173c4f-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


