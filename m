Return-Path: <bpf+bounces-10049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2226F7A0AD4
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A4DB20C1B
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9012AB42;
	Thu, 14 Sep 2023 16:31:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AF3DD99;
	Thu, 14 Sep 2023 16:31:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52EE1FDC;
	Thu, 14 Sep 2023 09:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709110; x=1726245110;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jzenu2jYGbPBWtnlA1h++PnDfhV2KbUJl9bSa0TuY14=;
  b=G94BxM00PKRMc63v2HCFvAzkFDsEE8U282qzvQDPn65RNW1ZaVuhayLg
   cLb7vrYxr64MYnLyGZxcfRhTSSEbzI0pMW+61A2GVxtdy5Z/pNoKbqdWJ
   79B16X0Z7rhM8JUbDpi8VNeOxeJU3TrXihgAf09HGAxx6Mh+PiKlJpE+3
   9yAinG3CR7TKBYJijlWsGjLcxDW4TVZEiFUbqNj5RfUUUPAQEruYvuC/D
   vhdVn/c6EwoTsALvAyhmUMSWjuwH3n+wD/jd3FVix7rHjgqZuGbfYbED7
   nJArQw1Av5/WI4WIArZHJE6N6t8bAJm2lxklUY3/yFgZzrWH8VfxvGN1j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="377913525"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="377913525"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:31:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="814765202"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="814765202"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:31:38 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:31:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:31:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:31:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiZsihE7cs9SHWOzDuBTr5er8uEg4Q5Yo1c9Jjb8+wadoGraF599+i8LYoNpJj2wyyMpLoHBj4e9pyOEx0mtq1O7/Ov5WV4DBE5Mh8CAbbR2uMjxMSeSC3ZC5jH7ZIGd+dY3X7iZHTR+D1WJhdw19IK92hEIypB3NUwxrQ6jhMQcDwNYdhoqmS2+lk1VGUDDXS1NmVODsG38g2wR2SW/48j4sGzpnW+YJ9spSI3R1RcruLHwKOz+FmWuqnFhcL0R/Pr8aIx5zh/uY+F2FcfvOjB33AqkPgUdkTRtSdzk0mwlW6a9pLTuUKg+E+IEMPMyfDaxTqVV/BALW9/B+Gr7yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ibrxsXSKJSOzsyQQwK6THsSVMQ1l32bv8gLvJOapKA=;
 b=HPSIes5Lil41kTxhh5fCtjamO7qRMGBZXE3HUCh83O5JExfWcfrxNJXLwUu+4RiRJ6b7kEWVpQ25TpnK6WOMmNXdfWsxVNdyZuEl27BPV2agc+HVkIzyWJr2Soaxsmjfz/u1uix6K1A5nBBOVNFgL67w1l9y/BCZF1hN7gbZHiudFsl6lHzlW0btNcfjnpGEyypFLT+M69+OijmErJUFUtmQGrPNG1V5OTy/FwDR11Be+MDjRxe1mixQsQsYf+XimAV3sAyQU1cY5c2Fxh0FhUzfRej/YhpJwLaQlA0trmIsAhI5xTsffHlA81WGzAYdtb5gLo4FWVJOGOYHltljEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 14 Sep
 2023 16:31:27 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:31:27 +0000
Message-ID: <7bd185f5-13fb-692d-a0d0-95d77685e9f4@intel.com>
Date: Thu, 14 Sep 2023 18:30:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 11/23] ice: use VLAN proto from ring packet context
 in skb path
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
 <20230824192703.712881-12-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-12-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SN7PR11MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 252ff9aa-3ec7-4379-b50a-08dbb5400b2b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mRe4V0A5PMgsvF6KcYaKbinbazJJsXyPcYX9YWHub5BVxqJOTpAmrtgsjUNeGU3byQfA/Ksw275+jwYcMcOriayzn743JyppxGIVQnWQIN75S/aAj/5eGhysI+A/38b18ScBE5Na9ZEM8j+Zh1leo/YTTBr3CoGjvq81it16PBydr5/C8hLDFyQlXukKgDbHF3MT3fzRWXsCw4sQtXL4ejghfsEIrvtdpcPL3bxs0qr5nuYnPoPcP3D8ckt0aAZi+MkfJz/YUTZquiMIVlxdqF1KAnoUDSPk4qhEhYvvnRIZA7zS2AcXIfjop2oDNns1MFmmeRLbZydIhBl9PYyp76OmwUPcXL4yGAYKiBDSeMRzZuEP/CE0DqnsuN1gpwCH8uOAx5yzF3T6zy7z32uk7EGZdPKp3aMZyvFCgGJVdIfRwpE0i+7lkXfHwGxUgnvv7dHOckrRcE8c6HlfFX8MioZUvvonDG4q+hrIcXXbhTlvm2Kbyisl30Z55mFp16gsC2jfLTXrfJ18a8aXqyBmnlxJ4Weu1nvsoJ8Htbev1nzn9i/wMx1OOojAjw4jzlwzj6cOcuRp0w3dBHTvi8rctfkh2/+dEosqOJ5AmnHju2WXYK9PxRyAYlymAxmru8Gu6SENgvWZolXXVIO4viNW+w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(366004)(396003)(1800799009)(451199024)(186009)(2906002)(6862004)(6486002)(26005)(6512007)(66476007)(6666004)(37006003)(54906003)(8936002)(6636002)(66946007)(316002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(66556008)(7416002)(478600001)(38100700002)(82960400001)(2616005)(31696002)(36756003)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmwvakl3bjNSa3FPYmJUVXVlcjJjMmNQM0NYYUkvaU1xUHYxNFlSMUZnZ3Rn?=
 =?utf-8?B?dnhDaVFiZnBkTEQvZldRQ1YzVU5YeDBIaEhpaEk5VUJqT0c2Y09HUi9ZcnBu?=
 =?utf-8?B?R2Y4ZHkvSFZKVmZGMWFGaERGZTlGb2V6SzNPOUNGZzhPZk1zNkd6clo3b2l1?=
 =?utf-8?B?MXF5OFd4ZWw4Sm5aNFBtdlo1UEZmLzVhMGdjV2hRMzhoSVdRdVhJTjJybnY1?=
 =?utf-8?B?cWJTa2l1bWpacFczbGt5VkxSdTRpeVd0ZFlzeDB2TUNoTjdTRlJySWp5U2Zz?=
 =?utf-8?B?QTZmZXFuZ0YxY1YvdHo3OWhmRi9yd1F1TFZkZ2NnRmJvbDZFb1FtZ1hkeXY2?=
 =?utf-8?B?Z0JVOTg1OEwwMW95Yis4enJrakE1RmZXM2hRLzdiekplSkNHMGo3akNJaW8w?=
 =?utf-8?B?RTAwRVNIZmo0emZOMkRjU3JjZkMwRGNodGFQTG9McG1mY3V6RHR1REswZmNx?=
 =?utf-8?B?aStrUDdhQ1QwV2JLWDQvTkhMM0t1c2t1Ni9lb21SOWFWbFJCUmdHK09KL0ZN?=
 =?utf-8?B?NHNSdFVaL29lS0N3alNBRi9FR2FDUVgvRkx6blBoZ3dxalZqbDBZZnVzVFJ2?=
 =?utf-8?B?Nk92RjJiYkpKRlM3RldjTks4SDRITkpNNE1xc2ZEWEUzRWdOMGFHQURSMGRU?=
 =?utf-8?B?cDVHS2RycnNady82U2hZMElQVk5jTERkcFVnb2xiZmlJUUMxOHRKT05qTmJ5?=
 =?utf-8?B?VmVna0VMU2VqY3Y1dFBpMHg2TlBJWHRmM1NlbFU0bHV1b0lUN1ZKWFZ1RUx2?=
 =?utf-8?B?K2J2ZDlkRGw3L2VrR2RDL2Q3bWNlMWgvUHQyTWcwQVp6eVRKOERVbmM3NFdj?=
 =?utf-8?B?QzlZWE1xZ2EvcWhOMHRVZXNQblByVVA0eFlrYXR3OU9Lanl5bmFOS2N6eVox?=
 =?utf-8?B?Qm00Rk1WVTZBYUxRVS9rYWJhSWNwWXFWSVhwdE9mOFk2U1J5dDNDMkJ6bGkv?=
 =?utf-8?B?RXNGdW9oc0lnY1A4MEZJd1AzcXJKM3pFVnZSTGhEYmprUXA3bHZzdExrNUZl?=
 =?utf-8?B?UmFqQkRrVXViVVB1bTRGS01oR1A5U1gzTXpNQm4vY1plUGhVZGFRTWw4em53?=
 =?utf-8?B?TG9XK2toRWQ1NlZMK3p4blgyMjRiSXNrL1BiNDNaMG8rZzVjUlZGU3hRRGFE?=
 =?utf-8?B?bGEvVlQ4Q3lNUnkwTGpQSmtsRDNYRXNrbThrUjZXbkd1SllSb0NXbVI5TlNE?=
 =?utf-8?B?S0F2SW00N1ZDVDhLcDd5c1MzOFpkeTE1a01RT0dCL1NUbXdjMkUzMWF3ZDNv?=
 =?utf-8?B?OTFTc3NkTmE0MFJ6NTYyNlJjUjVRa3MxUlpRanRkUCtvUEt6bjRHeC9rQ25n?=
 =?utf-8?B?djNJY3NJYTl1S2ZJb2srdlhNL0lKMm9ncHRub0N0azNTb3VvQjBPR0NxYVVQ?=
 =?utf-8?B?TUk5Y2dERUxBNThxbjlESVRpaDJJSTg1R0dka2h3RjlTZ1BXR3E2Z2ZlZFor?=
 =?utf-8?B?MTRQTm9YeSsycGRaVFpVNHBibEhvZnJzd29PTTlJcXJGbzViUElNc3h0WXN3?=
 =?utf-8?B?bjNUaHdEeFQ0eVkyQzFsYmxzNzI5MXFqbWduK3N4M3Fjd0RjejhpZEo2WXpV?=
 =?utf-8?B?enoyNlUwNTQxK0FkM2tmQlJuNndVR2poLzlZWHJUczlwWWs1a2plUUVPVndE?=
 =?utf-8?B?TDJPU0FWZTVUUHhjdDRIaWJsK0tocytrcVNpYkVDQUc0cWRNdkwvNnZHSSti?=
 =?utf-8?B?TFlQV1ZvckJnZHhYWVFFVzJyc1cwd0hpR09ZdEJ5dExkUlduRGk2M2dqUnRW?=
 =?utf-8?B?M1dlcjNibW9hS01CT1VaaTdUUE5kODljNTBYYk1GbUlCY05EV2F6YTUzOTJx?=
 =?utf-8?B?WVhmYUE0ZjIxVnFxRENVc0twU2hadCtKclhZeXl5QnpkV25PQTlrMnA2Y285?=
 =?utf-8?B?eHlHcVZEd2M4UUdRUG8zT1l6R0N4c1dvMmYrVzI0ZnQxcTNRMEt6SmhrU0tk?=
 =?utf-8?B?SS96dXVEMXIvSmVrWm1SNytsS1N3T1VscFdCRU1PNWxzYWYwWUlwOVRrR01Q?=
 =?utf-8?B?bElHNGl5WU9YNSt2WVdKbkxnOWpoMk1IN2NST0lIY1pmVEJsU2J6a0k0ek9C?=
 =?utf-8?B?K1VaZGszbWpxM1RTYml0YlM4UXVnMmdVM0FHSVdhYmEzNEtVT1BQa3BzcDV5?=
 =?utf-8?B?THQ5Y3lZZVoyd2dHajJxZmhBckFCajgvNnNBLzhhU1BObnNsT3psSFlUelBv?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 252ff9aa-3ec7-4379-b50a-08dbb5400b2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:31:27.5775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y51fpJcQoqIaoGb0x5v7ADxQcEwOAi4CcQJHZlheocmiKVRdL82lG3eS6pAXRVbOTuYWLE6k9L1DGt/fmOh/zyR4cHzUZqsCA1xjvbuLF9I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:50 +0200

> VLAN proto, used in ice XDP hints implementation is stored in ring packet
> context. Utilize this value in skb VLAN processing too instead of checking
> netdev features.
> 
> At the same time, use vlan_tci instead of vlan_tag in touched code,
> because vlan_tag is misleading.

[...]

>  void
> -ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tag)
> +ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci)
>  {
> -	netdev_features_t features = rx_ring->netdev->features;
> -	bool non_zero_vlan = !!(vlan_tag & VLAN_VID_MASK);
> -
> -	if ((features & NETIF_F_HW_VLAN_CTAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vlan_tag);
> -	else if ((features & NETIF_F_HW_VLAN_STAG_RX) && non_zero_vlan)
> -		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021AD), vlan_tag);
> +	if (vlan_tci & VLAN_VID_MASK && rx_ring->pkt_ctx.vlan_proto)

I'd wrap the first expression into ()s to make it more readable (and no
questions like "shouldn't these be three &&?").

> +		__vlan_hwaccel_put_tag(skb, rx_ring->pkt_ctx.vlan_proto,
> +				       vlan_tci);
>  
>  	napi_gro_receive(&rx_ring->q_vector->napi, skb);
>  }

[...]

Thanks,
Olek

