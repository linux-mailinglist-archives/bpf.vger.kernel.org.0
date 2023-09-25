Return-Path: <bpf+bounces-10807-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3726F7AE1FC
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 00:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 99ACD281591
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 22:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C650D250FC;
	Mon, 25 Sep 2023 22:58:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC281224E9;
	Mon, 25 Sep 2023 22:58:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1967F10C;
	Mon, 25 Sep 2023 15:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695682719; x=1727218719;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MDVV3njIIlHGhSVRPPCc1tLs0fEK7iuz3R5jh1grrU=;
  b=h6B6+FCoYPDRzcJV0X42Y1XcvhrEhssdGaxqkAZgWm9oKiwsD6oYA0LT
   0Ishf4Pl9/siwBzXRj0rqEu9up3tUT00QRZX9sg9Binsf7YvaYGg2pOPy
   0EDtXy/2GXMYEtJ3qupU9KYbrCIxqw/hPaFywha0hnGwqsLeXl101BAEM
   QrJ+qyLmInM1zRfX0XaK0AbW2cZ1j8v0eU5Jnk2iIxQnKcsVe59tCZQXt
   WKvsgimzQ4+sXdCuUyVIlUQ+1ysrhioAuxsFJ1SMsTlGIcAvjgCiULThC
   BHDIVcMrAiMclpO8zbRVRlZ6aFowdGAG5vkKWHd5XNKSKwC6VfJSTddLn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384209411"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="384209411"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 15:58:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995581646"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="995581646"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 15:58:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:58:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 15:58:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 15:58:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 15:58:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMy0lTTFrQo1BTaJW/qRFBG0ddDI4yKyq/Eucq7LZCVRWqvjKf8DBGxEmDI1KKz0ClwZjqk38NSxgeSg35l4MWvf/9FDrT1tTCTkFHgk5UXcrA5zZxpweJ8hRRqZ0iF1D2VxYVzu4yByAwmOY1R49ldTG3DWPRHIWefu89kv60ZJXYPej8WiGN8F6NvA+1vhoqMpBV5GgkPsGube4pLlzfOXs21KfAznlrH2Y09dGqEKepUqxYkz/lrh8wweqTy+C9oswoRe/HbZRgN/VPcr8N0yRfz/k1G45qRG6aeQ3GjbyZ+P0EmLyoiCIKXw3p+QzAnVwEybrhP9qPslbCNVwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lfxkO3a/FtfP0/xqgCzfDON7ETw9Uitw5iJFjmVbv+U=;
 b=c9MgBFShxU4pVbXEnW16LP2+ITV07LP1rZMU5mtXW1FhlyNTKSo0hnjMKusXiwL191f88620gFT+HcOVDMmIiM3JYVxFTL4qJqI2d6MBXObad3kQKCi3Dh87D0j5SJ6xXI9K/0H1Aos7vftQowKlMXQAgKTlzarRjDJZB3AHDZn3SMVnItB3VA97b+Q/RE7tlC7HPBUcSB7cKfN9fl5Pbxv4URvq4t7n9WVQr2c37JHipjclEi1dr6zt2e2Cu0z5ROsnD/Cnh4ZH/3GAOy0akyV0H2hqvuvnTAb3hPELkVLa9yD0covbNnjG3FdbNOWaCxKD7G9veArdcGOQvaP4DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB6501.namprd11.prod.outlook.com (2603:10b6:8:88::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6813.28; Mon, 25 Sep 2023 22:58:29 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Mon, 25 Sep 2023
 22:58:29 +0000
Message-ID: <0fcdb8b4-5a3b-ce11-fead-504b6c3f8cd1@intel.com>
Date: Mon, 25 Sep 2023 15:58:26 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] ice: don't stop netdev tx queues when setting up XSK
 socket
Content-Language: en-US
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
CC: Kamil Maziarz <kamil.maziarz@intel.com>, <maciej.fijalkowski@intel.com>,
	<magnus.karlsson@intel.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<hawk@kernel.org>, <john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Chandan
 Kumar Rout <chandanx.rout@intel.com>
References: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:303:8f::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB6501:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa3d07f-1096-4b2a-fe27-08dbbe1aef04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pQrl4gojjQp2xB75tnPX+TIWzNSG54I+/U94ZuC8kRegAJoJ0LKDXRwyRKO8QXXf5rjQs22hZCt9b6k77B4MI84hucR7IfjZmKKdGrerA6aEDfVjC2TVz7WDLB44c3bKXzpDmdsTRMrvnNlftSuYrPbOajUAAF7smJ2Z8/eOkll7ld2X+Y4t+vKS7G6XzoP5Qyv5JrPD+Df1mjgQYxCfUVkMFlYMpOx5kiO7Eea9aEfY79W/VU0niYXrbTQPQtYKvRzLUkn/EDjFYnnPqAS7SxmYoFsOR1QNMa6GBS5G3s+KaSAlNxWuEQIeTCJpbkhrm/g9aMhgQ429pHJDqqWgZLfJNmKtUoz7ixp5SdcfTJ9oPENcIGqJU7J6jVlKT7WMmHNMQ2jEoLzwRjHKmGrwAfgdpzMbXsIDuq+DWxERtClzWg4BLGugt/cEjyvb+HJZr6rIpTfS1ZrXl/yGZHVx8g4qFtS73NIX0uEw0g/3hDHnb+2d0YaSdaA6RtH7ESRawrVrTLs7FEgkkSZrb6Z+3P073FmJDNeSneRJUOEuKXTRJPewNcs2bh4NCKAdhGJ+rwWMrQHyFzJHQkB0oZM+46sWnK0TOMNVImZydp39swkovKhj5MxlNJO43Nf9ndGH3oJcs8s/CKrCFqQLaN3jyQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(376002)(366004)(346002)(230922051799003)(1800799009)(186009)(451199024)(7416002)(2906002)(66946007)(66476007)(66556008)(54906003)(316002)(8936002)(4326008)(8676002)(5660300002)(41300700001)(83380400001)(107886003)(2616005)(26005)(31696002)(36756003)(31686004)(86362001)(82960400001)(38100700002)(478600001)(6506007)(6486002)(6512007)(53546011)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlFDazIzNTJ4TlIxUlVteXZhOEZUc1hhcWNXdWUwVGxKYS9kSVJvZEtxYzFL?=
 =?utf-8?B?eHlpRys3T1ZkWXFueWlyQ0lmWW5kM2tGNUNiRGhFWXRnOU5OWU5uajNzVG9U?=
 =?utf-8?B?cXN2ZmFCaTlTc3dxNEtTWVVHRXRmU2l0VmtDdWRXUFFyUWxSR1FoNDd1NGlU?=
 =?utf-8?B?elBjZm5QR016Q2VaalgxKzdhMytCOGFLWklkSWJXN1k4V0tUQVFURXFKbW45?=
 =?utf-8?B?UTRPODVCTnU0K3N3Mk1XR3VyYXVySmdjS3lXd3JIVlpyNmdIYy9MYTIva1JB?=
 =?utf-8?B?c1V0TlJPcENsOU9oS1BFRnl0eG41Zm9DWW9FYjNsV1FabzUva2lTNmhNZDBI?=
 =?utf-8?B?dGJnRHRjSEFkVUErQWZ5aElaNlZ3cVVOZTVEZmY3VFN4cVJUb25XM2V0a2dj?=
 =?utf-8?B?ZmErU21lbzJoaERseUtiWDB6OXEyOWkzZ0xRWFgzWXZxb1BhYWpXeW1VYits?=
 =?utf-8?B?ZFM3RDNOZHR2c0d6b29Jbm1mZGtGQkpqbVNQU1RXQnBST0ExcjRhaUFnTnZM?=
 =?utf-8?B?M2NDemVDajZ3bzJReUpVZU5GRGhMeWw0ekZ4cS9UNjBrMnpkeGJxRUJBUW9j?=
 =?utf-8?B?ajdZcnovS1F0amNDSlNrTmxXWWs0dHNyb3RWVmhlSVp3Q1Axbno1V0FaU21z?=
 =?utf-8?B?NzNKYXVQK0IzTkZ6MWhONUIyTXJwa3VtaXZiYVBCSkJIVUkveS9ubUZ3WXBW?=
 =?utf-8?B?UkNsTHlIV0pmRGdNWXQ5UXdTTHR4cjBsNXRmZVJCNVlYRFRHWGpMQTMxS0xT?=
 =?utf-8?B?N3daTEVxYUYyaUNlcC82Qy9SVS9ET1BTZ1VhbTlVK3lwaytkY2pFQnhKODMw?=
 =?utf-8?B?U3NVQ0VZMDhsc2RpMHBVZjhyd1c4SUZCbzZqODJBSU0yZkx6K2lSSURoQmtX?=
 =?utf-8?B?Mkw5SW1WdFhOUlYxdHozdFNRd0QreHo0NGwzMDNlVUZ3TlJ1MS84MFdWdjcz?=
 =?utf-8?B?dGhwamNHSGN3VDB0TlBtYmUybTA5S3oyWXMrY3RMMVdLRzRHbFZWVlZIZDhn?=
 =?utf-8?B?MDlDOFUxNEpJYldWWjFlMmwvWldMNkVtK1hNMXhmVm9Jc21tZDUwaDE1OTli?=
 =?utf-8?B?S3NweE1sNG80QmpqaFQyTC9kcTRxM3pjeUw1VWQyTVlqY01MMDVyZWJORUJ5?=
 =?utf-8?B?MzRtYzlsdGcwRUwvQlp0bFRia0hiK0x2NStuaVpPbkNFb1lTSXJtQ2JPYnhy?=
 =?utf-8?B?amFwOFVrZURMdzFDS3hoVHVoYjB0dnVTTU9QM2h2R3d2dkcvbTdyOHozVnZt?=
 =?utf-8?B?ZnJ3U043dEdzek1zRFpEK0xsVWlTdjdNQW9LN0NKaUlyeUU5MWt3cjZwNFhN?=
 =?utf-8?B?cFhnd2FyVDJtTW5lVysxUHpZa056b2ZVK0FzanVKdkZuMi94V0loZGdidjl3?=
 =?utf-8?B?dld2YUMvK011bFFuV3NYY29UOXB2LzNSMnlIdkF6MTBwc0h1SFVTSFE5VDNX?=
 =?utf-8?B?UzZIWjVsN1U4eDZyN0tFL0tYV3hnMzErVkRoQmxUUEI4K05JQS81b1N0b0dn?=
 =?utf-8?B?K3hYK1hpL2p1cFlIbXgzTkwzbFdWZmcrNWx0bFpaWU0wUDdlbjZmakQyNERW?=
 =?utf-8?B?R0xqQk50LzNHdGMyQ05UdTdXV0ZXdWx5QUpSaVc4Znlaei9lWVh5eFJlajlN?=
 =?utf-8?B?bTBnam4xRThaRFRiOGYrUkhkQXdCQUhOUGhMS0pSUUJ3OVgreVowNFJlQkdT?=
 =?utf-8?B?NnNzV3Vha1VFMFhXSGpBelhUOVA4Z1NSQk4zbEhkVkRjZW5pOTIxKzFuYWhs?=
 =?utf-8?B?S3F2bDNXUFRydG1xLy9WcW5nRzczcTJKZVJaL0w0RWlFUWpHQnV1WUhPSVZl?=
 =?utf-8?B?QnkyaWx1K3Zpb21NQTg5bE12YlRCYTJBZTYwQjBVdEtNcmpjZmtYWjBmN1Er?=
 =?utf-8?B?NStPdzJOMzk3YjJYaU4rOHB0cmdydjVuSFdiejh3RWNrVlNZOHJiNGx0ODhj?=
 =?utf-8?B?TTlLQWtScWpLaUUrSVZkL3QyeE96eTNHLzdvQkd3N3A5VzNSK09NUXdEZzVE?=
 =?utf-8?B?RjVSNlJHZDBTWWFyRTcyZWZWbGw4eWhBYzMwS2RRNHhjbmFKa25mTmpKQ21l?=
 =?utf-8?B?ZUJhWWxEejVYeEk2WU5wazZMZDVpSHowK1d3WGZTUDNxSTNnQjFsYVU2cDRn?=
 =?utf-8?B?VmNnTTFSbFNjL0E5YTUxM1lCTUFUZDZ0ZTJJdjArVFFQZGJzMWtubFBKbXA1?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa3d07f-1096-4b2a-fe27-08dbbe1aef04
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 22:58:29.2530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+VVJp2mrI4o9p9pASRUu0bA+PblQyWAH1ILpEbNpHtDKl8Zt/CiEroTnfEbtuzEvA2QgU3GdlbfgoGKEkqd/W1hftIpsZTd8+lcmqHsc1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6501
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/25/2023 10:19 AM, Tony Nguyen wrote:
> From: Kamil Maziarz <kamil.maziarz@intel.com>
> 
> Avoid stopping netdev tx queues during XSK setup by removing
> netif_tx_stop_queue() and netif_tx_start_queue().
> These changes prevent unnecessary stopping and starting of netdev
> transmit queues during the setup of XDP socket. Without this change,
> after stopping the XDP traffic flow tracker and then stopping
> the XDP prog - NETDEV WATCHDOG transmit queue timed out appears.
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Kamil Maziarz <kamil.maziarz@intel.com>
> Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  drivers/net/ethernet/intel/ice/ice_xsk.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
> index 2a3f0834e139..cec492b827d4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_xsk.c
> +++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
> @@ -179,7 +179,6 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
>  			return -EBUSY;
>  		usleep_range(1000, 2000);
>  	}
> -	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
>  

These were introduced by the original implementation in commit
2d4238f55697 ("ice: Add support for AF_XDP"), without explanation.

Looking at some of the other implementations I don't see calls to
netif_tx_stop_queue or netif_tx_start_queue, so at least its not common.
In fact the only caller in an _xsk.c file appears to be ice.

Thanks,
Jake

>  	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
>  	err = ice_vsi_stop_tx_ring(vsi, ICE_NO_RESET, 0, tx_ring, &txq_meta);
> @@ -268,7 +267,6 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
>  	ice_qvec_toggle_napi(vsi, q_vector, true);
>  	ice_qvec_ena_irq(vsi, q_vector);
>  
> -	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
>  free_buf:
>  	kfree(qg_buf);
>  	return err;

