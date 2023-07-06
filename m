Return-Path: <bpf+bounces-4228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0C749B2A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 13:53:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C14A28124B
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 11:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE468C1E;
	Thu,  6 Jul 2023 11:52:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56398C12;
	Thu,  6 Jul 2023 11:52:58 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634C1726;
	Thu,  6 Jul 2023 04:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688644377; x=1720180377;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4gh2jg5vDEliKdm/44I8uvzf5ZwuloQnAgS2pPC5/7w=;
  b=cVIBuVjHKIwALnPaP+CgRGwB1bkQHMQ6Cj76EJHxvLY66MK3r8QAm22x
   kAZVGx0M4Ir6cH+1/kDHGKce4fZzWUr34+Np4SRDxTOj/TSWrAU55R1LF
   Dh4h0lHN9umqgQXavGwNKN8D9gsHDrGGQQms2F0728tz0qtaIZqqmWHn0
   /CB4C3RgWSXk9CgHRlTHE1rpi2+YuuMSQ9sJ5QDVzFMR9a3cCT1PmayHL
   yVeMXSaX3KRr128pdb2oVcK1wbOB6gps0ozYwa1aXoGNmiawG36hk93V5
   BLPITJU1GFslyVe38TbjMMZ/TsaFDdyZ67bTgaRFalWkRbZc82fGSTdRr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343913646"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="343913646"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:52:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="864077103"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="864077103"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2023 04:52:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 04:52:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 04:52:56 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 04:52:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gE09Icl7ZxTY3h6UnNCeqLJZ9cvCI798TQ4qS8RgvJ5T2fjX8pEBnfbU1WMArZR/14mhUlZgxAJMyyMBzv2jmNApQdw2xkcc5oRn8kla9sJTb4ubqOZKXHsuByyRc1hKIQdfb8ztzXj6ZbxvA4z10iScBUyynbdFyIUd3AY8Onwhrqz3jWlYuLPiLXyMnlAMh56JyG8AwnI76aMePUXUlx4zv5kmtF+ODwiiLHJ8KlcFcN5U2soMu4jOGllfYVAxyfdgk8ncRjsM74yZ4lkbjf4J/wUVVZDMV4lbfS5TSHlyPaiwLSLgSyEdvlyFL5mWM5Dp4fylgZkj87klZVIQtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+8CM9IlKA0iiB4osw0uODDSbrOlhMu8ZmqZr38aBdKk=;
 b=m/uhje+/kHLZQ2ZI5S/+DNSfV3oqvoSfa5DSL2uaZX5AxRGtwxmMERvt90DSHSA+tf8VWdsi/HpiUgFuZiUECZ0B/UdoAQw1gpAIjdsqJUVjl6901dVD2e6VjLh3QqljI0cxymm7NWVW3onxMVTi+746dnvI669Ug/QKtuFmu+4ABzSlCblCjzNnGIn4ndeV3B7EFdbHHp5soJLqZSEAD9EXzhoOINNcnAgregw9MfnPz45u+g5YJWhXHGmtM1B0ABW2nxNX811x5SAxXFzfpVIev8thNOZOjcwfdsf7Dku/ti8EOztnFy84GzyAJd3AWQU409XTXKm4ZtX7hOp5DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MN6PR11MB8101.namprd11.prod.outlook.com (2603:10b6:208:46e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 11:52:51 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::1ecd:561c:902a:7130%4]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 11:52:51 +0000
Message-ID: <cc4224aa-1304-dd16-7036-4f069958d371@intel.com>
Date: Thu, 6 Jul 2023 13:51:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH V2 net 0/4] net: fec: fix some issues of ndo_xdp_xmit()
Content-Language: en-US
To: <wei.fang@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <shenwei.wang@nxp.com>,
	<xiaoning.wang@nxp.com>, <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
References: <20230706081012.2278063-1-wei.fang@nxp.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230706081012.2278063-1-wei.fang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0163.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::18) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MN6PR11MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbad4dd-e215-4435-d427-08db7e1786b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UOHMS7epYrBborneGfg87Eo3Lznxl0O3tH0KxR71lBDFjhJi9cso/IrVbaP6g+VtKiZ3d9xO7QcphQ+1l8SiDZgv5Oe/X4q0bSDGf1/j6Nljj99JVGoQprgnqIXrDgQeeU6I3gfPJtyuM6ys+DhO3BbLoP6oNqvcJxC2KcnheN+31r5mPvuFhIBWhiZ3wumhFH5kI1+nLA4FrD+4z2sOQ7/Yh6QSa2PPAUnixxeYIVxhS8++sAPYQBPjOUI/tDokydbv6eYIbpXcASMZuHtFzwwhZ5f7oxhRIysPkdC3teHjrmOqcTClETEALRcom8r1+DrAhsxLs4Rz15GH5XzZkHHQdzS9LnjBy6Zyw6c51psxGGO/vQnWjrFMK6gbQa0z0ost6+f3JPtVb1kwxKuUjEhr4P3KA2StseBtQECxg1KUNyNoe4jb7PKUZ8n0QtZC9P3ys8yIdar383QB+mn9/cOrCKGvoygjRXT8zph6Yy97wm/kER2v0E9F2UayjCROabBhFUTzr8yPvQ87e9VCo5vKZ+M/VqXpdygNXwKQx92CDzArS2zC2oZEnzGcxH7XsD/FV3zxZ5/idd39jH0YsTvc8sp2aMsNoh5MRvsNLswKuzVeKpc7pHSZmraTkq5JPbYQSmlvNV0GyHHcXokkTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199021)(6486002)(6666004)(478600001)(83380400001)(2616005)(36756003)(86362001)(31696002)(31686004)(2906002)(66946007)(6506007)(186003)(26005)(6512007)(82960400001)(38100700002)(316002)(66476007)(6916009)(4326008)(41300700001)(66556008)(8936002)(8676002)(5660300002)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0l3SHVEc0VQZjFFYWxwV2lmL2FyY1VPZmdVRXlodVhNMFQ3SzhvZDhzbFV5?=
 =?utf-8?B?TTJjSERIdlpEaDBrNTJuK2ZBWkNqTklha3NBUlFoV1h1ZURRT3BiSVpxeEts?=
 =?utf-8?B?TEg5WVhUNzlXRldVcUdFYTZFQ2VYSUtRWnRYK0lET0l2WTNEa3lvdU9wMFVh?=
 =?utf-8?B?bXRuc0l0TmNMakcwaWljV29vblNCdmhkWG9CTFlwS3FOUnNreXFIOUpzN2tW?=
 =?utf-8?B?QTA1bE9BQmtHOW9EREVka0gwaERraDBmbW9CcUhtN1UvTWJzemJPckFnV1Na?=
 =?utf-8?B?c2xRUFMxQ3pJdWZWOUxVcWk5Y1J4djNjNFZoOG5wcXptVGxXSmFwVE9iNXJO?=
 =?utf-8?B?T1ZHS0dDeVg5QTczd3FJcllXY2VVQS9IVE5ZVUVtNmluSllaNXZHQmpFYWE1?=
 =?utf-8?B?bXd0Z0Z5QVV2RlJOYlNuaE1RU0ZCaEdrUDRxKzZFWTMvY1lBVEpXc3R3M3Vs?=
 =?utf-8?B?OExRdkQycUt5bURZRjRMN0ZxN2lFanVKN3FhU1FOWVp1OXRwelpEeEhLVEd2?=
 =?utf-8?B?MVptRWNyN0dhajJ2SzFCRnczbFVuaEV4cTFiZDZtVTFnbU5WakYvSjNlbnRW?=
 =?utf-8?B?REM5RTdFUGd6dTZVczhGSjJ0c3RWTmhLNmtOVy9ESWl3aU1OVjZoY3Y2S2gx?=
 =?utf-8?B?cmpHaXIzdkFDVXZpL3hSd0dLZDAwaitKZXk4SFM0US9JRzlIeEpwVGpiUUJV?=
 =?utf-8?B?WVBJZkhoNzI0Sm9qbjkvZTY1V0J3OW1oMkpycjY0ajBpVCtEQzdkeHA0ZHQv?=
 =?utf-8?B?V0Zzb1BqTFp2UndaeWw3bXV5QU9scE54WXIxMWFYOHRpT1dlbFBNQ0x4M2U3?=
 =?utf-8?B?MXpSTmFIVzVGbTRFVzFxWW9sTlhvRjd3ai9PVzlRT053ZE9sbGR3UGRxWjBy?=
 =?utf-8?B?UjgxLytpcGNyVmZNN0ZBVk8yclhqLzI3eXNvRWVnN0hTVGFCV2QzcnhtU3Iz?=
 =?utf-8?B?K2RhZHFGNjNUNFdLaTc0K0V0ZzVBeXBITTB3dlRtdmczRjlSV1FlTUZ4bWtt?=
 =?utf-8?B?K09PamJjRkc3cGRkUmFWL2NUQUN5RlF0UERzakhhTFAyY0VlcWREVzNiVlEx?=
 =?utf-8?B?V0dFcVVYOXBaTFJVdWZGU0tXdTNrWjVMc0syQUY2UUpLVUpDQnY5WE1RNUhz?=
 =?utf-8?B?L3dxNVVHbllWNTBiZ2tpMytXTU9PWnBwODFadE1lK1hZYlQ5SXFyeHBwRTF0?=
 =?utf-8?B?d1FsREcrQ1U5VVpDMXYrOXlneDByMVNuWDhNRm03R2d3V2hCNVRuclk3MWZQ?=
 =?utf-8?B?WXMxN2gvZm1Bdmx0WHZpcXFCN1NZMXNRUUZxekpEUHNubVdIWEtJdmFDMTJQ?=
 =?utf-8?B?MWlVbWtOcUFIanhmb3pPYkQxeEJDaC9NT1lsUlZRazAvL1dLOE43SDNGeGVW?=
 =?utf-8?B?b25MNzlrZHFhU2kzL2tnTzVzQTVFRlFTdmM3Qkh0TFAxVk5JaEtCZjVCNXNz?=
 =?utf-8?B?RlppMmxIOVl3UGVyVDVPV1Z0dnNTaHhhKzJSSlRJNFpMNk5OemN2RjgvOEdG?=
 =?utf-8?B?NU9iNU1iWmdmQXJreFFkbzBXZ0NENFVUS1Z1UmI1c1dxakJTcjBhSlJMYm5z?=
 =?utf-8?B?ODN5RlNucGlmR3FudWlEd1FRWmhBZ1FjSjM0RTlJOFhxem1ZSGNyOXFNNWxp?=
 =?utf-8?B?QS9TOFVlVzFiZ3ByZm8rTU4rT3I3K0VKMEZRSVQrbEdVN0pVMUlpM0ZnSGVH?=
 =?utf-8?B?bDhCVklmdUVoQWE4OGZDOTNNMTRxaW4zMTVJaWRCanRYd3ZYamRZaTd3TG4v?=
 =?utf-8?B?ejNvS1p6ODFVQVc0ZzgzUXBJNG9Ucmo3S3A0bHEzRCt3em5BNGlzVDhVY2V0?=
 =?utf-8?B?R3VDanp4Um1OTFdYbWxFWWF3WDBZanh4alFocTZGTzhndjFJT3ZVTit5Zkwv?=
 =?utf-8?B?UjZCenlubnlZczVEMUpWWkRkR0hXQWNkYW95VWlUWjRrc256ajI4MFFFaXVY?=
 =?utf-8?B?MGhFOTVOUkZYU2dSUnMvSkdhVTVGTks4VS9hNUViQUs5SU41TFp3ZHZQMzdv?=
 =?utf-8?B?NkJ4YUx3M1VHbjFWcnRxbU5pSW1Bc3ZnQ1FYUXhFWGNwN2xMQ2ZWa0VtRDc5?=
 =?utf-8?B?cGYvKzlKdVdKbWlIZWJkenBBelRKNGJhOVYvTkFMM0dvT01ZVmlnYlVKbVl0?=
 =?utf-8?B?ZjBraG9saUJ1cGkwUHIwUXEvdUFGczI2ZjBLbFNuLzAwTnN5SVViWGxUWHU2?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbad4dd-e215-4435-d427-08db7e1786b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 11:52:51.4381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyqlip2BCR3kA7LRMWLoaHvh40Ae0oR0B3fhpSxuBBTSvMLGdvtcOyITMDlGTkdds0s3iWYywznD92wufKnxSpzC1UM5uM65uSxakMyDiQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8101
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Wei Fang <wei.fang@nxp.com>
Date: Thu,  6 Jul 2023 16:10:08 +0800

> From: Wei Fang <wei.fang@nxp.com>

Please sync your Git commit author settings wrt Git email settings, so
that there wouldn't be "From:" for your own commits.

> 
> We encountered some issues when testing the ndo_xdp_xmit() interface
> of the fec driver on i.MX8MP and i.MX93 platforms. These issues are
> easy to reproduce, and the specific reproduction steps are as follows.
> 
> step1: The ethernet port of a board (board A) is connected to the EQOS
> port of i.MX8MP/i.MX93, and the FEC port of i.MX8MP/i.MX93 is connected
> to another ethernet port, such as a switch port.
> 
> step2: Board A uses the pktgen_sample03_burst_single_flow.sh to generate
> and send packets to i.MX8MP/i.MX93. The command is shown below.
> ./pktgen_sample03_burst_single_flow.sh -i eth0 -d 192.168.6.8 -m \
> 56:bf:0d:68:b0:9e -s 1500
> 
> step3: i.MX8MP/i.MX93 use the xdp_redirect bfp program to redirect the
> XDP frames from EQOS port to FEC port. The command is shown below.
> ./xdp_redirect eth1 eth0
> 
> After a few moments, the warning or error logs will be printed in the
> console, for more details, please refer to the commit message of each
> patch.
> 
> Wei Fang (4):
>   net: fec: dynamically set the NETDEV_XDP_ACT_NDO_XMIT feature of XDP
>   net: fec: recycle pages for transmitted XDP frames
>   net: fec: increase the size of tx ring and update tx_wake_threshold
>   net: fec: use netdev_err_once() instead of netdev_err()
> 
>  drivers/net/ethernet/freescale/fec.h      |  17 ++-
>  drivers/net/ethernet/freescale/fec_main.c | 166 +++++++++++++++-------
>  2 files changed, 127 insertions(+), 56 deletions(-)
Thanks,
Olek

