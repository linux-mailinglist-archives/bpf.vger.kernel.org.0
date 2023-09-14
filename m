Return-Path: <bpf+bounces-10041-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F277A0A98
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A9028251B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD7A21370;
	Thu, 14 Sep 2023 16:17:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1C18E28;
	Thu, 14 Sep 2023 16:17:16 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3BC10C7;
	Thu, 14 Sep 2023 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694708236; x=1726244236;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dtx6puYU5oZJh3x5EGDrDtT57YKHBMGq+tz1O+XF6yE=;
  b=SQRYRB3+k17nPSG96626g9EiMyDuQaR4ds6XPA6IBk1PyJu3BaFZgSIj
   N9CkNJ0pd5hhNG2/TvbNDM0XRZG3d8VEh9HyvUPDOaoho4fbeg2f6tY54
   8UMew+H7k6BCKxmYswMXtZrJPtMVnMorpWo5ZXAhC68HhEDkB5P+vn4+W
   ZQZEDJXuZEKdDhBbwj+q5COSTxvSRi7lIWd24xfZfc9E/bCkAL0jtSmg4
   wqp6be4yTerXnuQagBct5gln16TS6MY363J4v8+4IExx4+0BimLUoSN3q
   XWsAx9AOw0423UD9TS+M/+4+QA+DUuuMSJ1I89BU/2eHsr0IngBJBpY3f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="376340026"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="376340026"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:13:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="694361750"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="694361750"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:13:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:13:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:13:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:13:21 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:13:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT8qqq97PyEs57S6Y8vcyWvUlSck3Ioi+/kto2gl1U75Rsji5mEOFGGHM8i55cLOQNkgdeDNKtZkjCJhD4HyGXuEVpv7RFndpPvUYkhD2JVwngswBg/IsNgE03EPG+qeG4x/moDP5ahKpx55p2bXy4ms5ysS99R0ASAATlOQGLR0JSV4qoxquTJZCfxwIxZ9NVU3UcQs8WMk1Zaa3ICGWYmvVrNep2Ucy7pSCmC3QzoEBugIrp1RRQSqArRFq0BroKwGCiNvaH6Jq6HnJD9FcFJzBjcNC8GS0sqmifhx9007t4L8LdYGLoOmhR+p30QgNWiuGgsvl6dCOrG29t4pUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SkeBjq8hdb+DAPbGpUwxqsSClSylOT0jX6iAYqGO5jw=;
 b=jU2mo+0yKMHaFaQxn/raBYC+jdym9MV1WgVX0jJiCZzWz7i4NsN7e0zZxUIquKvYpQh6AzqifTD+ljtGAy+P/gc1EJmAqjZTRTGR7sTAaQFMB/Pvq/8PSCf5P0CbPlmC9minl8e+I+1OaAHDPEGcIswZxfQXOyHez9m4ioZfkXZQ1M1LLzjmGqatq0DcTCgOh5liYY0b218yDR637pB2v6GxNltUn4gwHn/OAoTQ3Q2XVX2H8zPuEQ6MXFSf8b3c6yvU0uezCay9L5jrgIYToibPb9LoEyFyC+F5SQ2+QRuN83eQ6NZjMgoWtuz6rOwFKs20xEkGv7+ynbBnRIBQbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 16:13:18 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:13:18 +0000
Message-ID: <eceeb36a-6621-b0c3-371d-e617023fb0e4@intel.com>
Date: Thu, 14 Sep 2023 18:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [xdp-hints] [RFC bpf-next 01/23] ice: make RX hash reading code
 more reusable
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-2-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-2-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:66::6) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CYYPR11MB8429:EE_
X-MS-Office365-Filtering-Correlation-Id: 11483fd0-8a02-46e7-9c40-08dbb53d81d5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Vyi9fA9dVqoe62C4pJNj+75H3KfEiOMQzJ0bAJypqQJVy1Oy61kxvAre5InejzbssWOaGJo0qyNqSnpZgoHBVKLZYI2wT0opv3I62Faf1Ak+HLvT0zFF66NV7vFfDIh0l3/uNMyVsWe/aKK9MsI9x3ttPvlaipz1fhJVOqlGab+MgxWsHokdlb/ySaBr3Z2MUppi7lwZ6eZzOfxXczB6MO/35/EaE7gzp3bCgQrRKFHlOjDcdmZgm3bMv6GO02bfaLKMX3OFXoxMACHHXwbgsP6J87ShQaFHuV7llb69mt+zRgkUjD4MGH0UbRh4ZoCMQZMb5mE4lyfC+K+tZolwU6Ne+GJq5peNw7ioNH+HgIZxTAzrPTStMS/ZglXQS5vRC3hSopgSuUUAUVQm7E30M0XpH4cT2ouF9LeVN71R12BHS0A2M8YqgQ9dEJFi0svYw7iStYekQ3HA8nzYpy40PU995B2Ye1190Re8Wt09XB22u+ebd7emEG78jFRTtFPqQnvH8S/6FLuJJ7NuWDGMcEbDvXvFuOfQeRlUBJlJXmti8NMMGvIqYu4yEYVHCoqz8c1QCPhFetrzv4aA0DWxIO1mfOgtS9kcA3K1jk4yc7Z+YGNAj8CRJ8ZDEGyR7IGsm0cRm4Z2wMkC/YKsd8JLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(1800799009)(186009)(451199024)(2906002)(86362001)(31696002)(6512007)(26005)(2616005)(478600001)(36756003)(6666004)(6486002)(6506007)(83380400001)(38100700002)(82960400001)(7416002)(41300700001)(31686004)(8936002)(4326008)(6862004)(8676002)(5660300002)(66476007)(66556008)(54906003)(66946007)(37006003)(316002)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnM3cHo3QnRYUWVPV0JRcXZPQ3FFa1Z2SDFwT21TS0x4NkcreFRKd0Y1LzRk?=
 =?utf-8?B?d0VGYno1ZlRMQmdsaTN0elozdGFyWGdtVWFIL2JwZGNaRW5FMHZwUFlmYWpk?=
 =?utf-8?B?UEJGdWxNZTFJTjNnNENHKzlBanA2TVc2NXVDVnFmNjFRcWZwTGhSNTV2NFBE?=
 =?utf-8?B?azd6S1BTMFZka0I3K2NFVUd4akEyU1NabGVFWjhFNUtqRG8xclQ4Z1kzYTRx?=
 =?utf-8?B?SnJGQStYRkV2ei9ranRrQ08rakFuMlI1a2VpRnFkZURXK3RjK2FqdHFjVHkz?=
 =?utf-8?B?cVo5akNDOEdYZzZvTk5weXo1UmJBSDRoUEExamd4MHQ4L205a0M0N1ViLzB5?=
 =?utf-8?B?aGVZTzdEazZ0dzI1ZHpBNk85ODFXMTVDQ0RTNG1OQWdJTGlxTER5VXNWano0?=
 =?utf-8?B?RzRsRWJ0SjJFY0FIcmNTdStDakVlcy9hTEdOYmI4dENSY1N6S0FwVzhhSy9l?=
 =?utf-8?B?dkUzQWRjdEFhSTlYY0FvZTdkQ0RHeVlsK0FvV2l5ajVFclJiditHSU8yMS9r?=
 =?utf-8?B?S1U0NnR6cEVxT244aFhmUStFTDBtWDdmRlRYaVE0QnUrL3MwbW85em42M293?=
 =?utf-8?B?VzR3M0ExTmgzVVNVMHVvaTRtZnVoNkxGdUtQVzRHMXBLdm5JTVoxOGxHNjFV?=
 =?utf-8?B?MFJNVHhvSFlkTTBBZXgrVmhmUzFsQ3JPUmZtTlZWT1dsQktNMzFaUzBCeEFu?=
 =?utf-8?B?dVVRc1pZNThtY1crV2Fxa0hlRmtleGRVSnFDRVpPMmVQUHIzTlB0UDlQbDBK?=
 =?utf-8?B?VHdqQmtDTXo1eTlWS1hjQTdqTTZRaVBzNHFZYUU3MGpzTHFHVzg2ekUwUmkz?=
 =?utf-8?B?Tk5OTFJvNE5qZEdZVjB0eEFJVE5vTjBnODBSNGtTaTVDL0hoenZCcFExblhx?=
 =?utf-8?B?QmJPNzc2b2ZGT3A2c1ZjVEpVTGNEV25LR3dhRDgxbWliOU92bGYrRy9rOFZY?=
 =?utf-8?B?VDRMYVJJVnRodlE2RFFrbCtpYlhBaVJMbVRCdnhTUGJuL3JVaG55bE1BQnEy?=
 =?utf-8?B?SnRvRWphSEtRa29nVXh3TmZObUM4ZkJDWFhnTmxKSjlKQy9LSXhCZ3ROTDBx?=
 =?utf-8?B?dUdzQ1lSSU1KTjlGZjBMT0svVzgyWUorUUZMeW8vSXQvUFdJdEVobU5zcFdV?=
 =?utf-8?B?cmk2cDNRazlqSHk3SEpCbzBad0NSZTg3Y0Fqdnp2MUxlakVlYTNOVEhVZGZS?=
 =?utf-8?B?aTBhc29Hck01U3FkM2NyS3RNMlBWa0dvWG11aUtpMHJjR2VzbkxoSzhNcU5w?=
 =?utf-8?B?V3I2Tms0eHJzYUgxUE0rbko2UUNkb3BIWjFORks5d3FwYTdMQkxPck5DNnkr?=
 =?utf-8?B?NnpyQzNWcEtPeFNmMkd5YkR4Qkdzd0JzMTdFZ1VFK25oYnlmQlVFaVBweCtl?=
 =?utf-8?B?a1RVZUdEbktNT3FLOUZvQ05RNjFhSFYyZG9SdXpKYUZFZVZVaGxRMEJka0NI?=
 =?utf-8?B?Z3d2bnVsbmFZaGNleFEwOXV3MWZWdStISVRsSzJCSTVsTnI1RFRKT2t4YjNJ?=
 =?utf-8?B?ZXJMaUdXaE9rcFVwbGJNVXJ5M2V3T0lyc0krb2tPdmdJRGdoM2F4U01HR0Za?=
 =?utf-8?B?V21NNDAyUTNUeWhJUFlJRzg5c1hJOHM1TnhJV2hxY0FKRlVPVHVKSjk4NUhZ?=
 =?utf-8?B?MGZ4Wk9hWTVLT0FqQW84ZzlTeFFUcUxqaW1MVGw4OW92UnNER1ZXVzJEbXRj?=
 =?utf-8?B?UXE1UXZwa3Azc3RGSlYyTGxDejEwNG0vTk9PZlhiL0tjaWdEb0hFZGJxTU1y?=
 =?utf-8?B?aUNWZzQ1aFhWVVY3UU1WbURZcDVvcUdpMkRZKzdBUkZIdmtZNGZVRXl4ZFZV?=
 =?utf-8?B?Y084NjJXRzdHbjZTM3Y1MXdPK1dndEZ6ZjJPVHprbEZCR0s0bmN5VWRRTWNS?=
 =?utf-8?B?MXZrbHZWb0RJbW9ydDVTV2ZNOWV1N0xEOXBVSlY2ZXQrblVlRXA3OGpKeW84?=
 =?utf-8?B?S0Y2Y2xKbmhUTW1KaG9hamNSbDJIQ1RGVDV1WktXbm9RZDUyb3Zad2haZ0lZ?=
 =?utf-8?B?SDBnNDNZYUVGV0hXZ1Ard3pZZFhza1BMallYbHYwZ1dPUTZwanVMM1UvNXNu?=
 =?utf-8?B?dDVrcHdRTVZMa1ZoaTFyMnVYTFFpeUdxSHFjNkxlK1R3ZWNFa1NOUDU0TXNN?=
 =?utf-8?B?dHhnTU5neVJ5ejE4SXFoZGFGOUFreHlpZmZ3LzZnL1Y4ajhyRm9MaUdmd0JG?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11483fd0-8a02-46e7-9c40-08dbb53d81d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:13:18.1731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dqn6H4vrSyvOWUeTDmBCgqKW4E75JyLIrFkyRHGmTP3ssctk9uk0Ozv3re8OIjozff53SntAKs2dBuIJPpsqQcDsX5+oLp5i9p2lTWnSV68=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8429
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:40 +0200

> Previously, we only needed RX hash in skb path,
> hence all related code was written with skb in mind.
> But with the addition of XDP hints via kfuncs to the ice driver,
> the same logic will be needed in .xmo_() callbacks.
> 
> Separate generic process of reading RX hash from a descriptor
> into a separate function.
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

I like the patch, except three minors above,

> ---
>  drivers/net/ethernet/intel/ice/ice_txrx_lib.c | 37 +++++++++++++------
>  1 file changed, 26 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> index c8322fb6f2b3..8f7f6d78f7bf 100644
> --- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
> @@ -63,28 +63,43 @@ static enum pkt_hash_types ice_ptype_to_htype(u16 ptype)
>  }
>  
>  /**
> - * ice_rx_hash - set the hash value in the skb
> + * ice_get_rx_hash - get RX hash value from descriptor
> + * @rx_desc: specific descriptor
> + *
> + * Returns hash, if present, 0 otherwise.
> + */
> +static u32
> +ice_get_rx_hash(const union ice_32b_rx_flex_desc *rx_desc)

The whole declaration could easily fit into one line :>

> +{
> +	const struct ice_32b_rx_flex_desc_nic *nic_mdid;
> +
> +	if (rx_desc->wb.rxdid != ICE_RXDID_FLEX_NIC)

Not really related: have you tried to measure branch hit/miss here?
Can't it be a candidate for unlikely()?

> +		return 0;
> +
> +	nic_mdid = (struct ice_32b_rx_flex_desc_nic *)rx_desc;
> +	return le32_to_cpu(nic_mdid->rss_hash);

I think the common convention in the kernel is to separate the last
return from the main body with a newline.
To not leave the cast above alone, you can embed it into the declaration.

	const struct ice_32b_rx_flex_desc_nic *mdid = (typeof(mdid))rx_desc;

This is a compile-time cast w/o any maths anyway, so doing it before
checking for the descriptor type doesn't hurt in any way.

	if (!= FLEX)
		return 0;

	return le32_ ...

(or via a ternary)

> +}

[...]

Thanks,
Olek

