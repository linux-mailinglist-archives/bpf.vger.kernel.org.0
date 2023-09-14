Return-Path: <bpf+bounces-10042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C64B7A0AA1
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9418281B4E
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39D219E3;
	Thu, 14 Sep 2023 16:19:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64793210FE;
	Thu, 14 Sep 2023 16:19:42 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D61FC4;
	Thu, 14 Sep 2023 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694708381; x=1726244381;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FLzoe7Abpt3b6cn6wwfKeEHi+nZmwvp4FPPUN2C0feM=;
  b=Lvqv2NWWpTBdAwdvmt5vbczHdJqZtpQxM9nKm1xttgWw17ZToR1LwBvf
   YG23Rp2MtgDT4tCe4mfE2l9mZuBR7uSeNeqc/HqLdoLkZsS85CQxySVXi
   iLvOg6h25eMfKwfPpQbFO6PQYVD5SOEfLUWFDd159wV7lgFOCr+kRrXyf
   M706lzyLWuU0cikUWL9R2u096dNeQAv0vhoGZ9A12+pJHtn3mk+QkPRo3
   Ptn4vt/v55pSM+19+dYroEBbq8Ksrzl8uxDhqUHZDlziu+SAOTa8djM+p
   cMpB9MRscu6Fs4pvw43isMFAdZWjB+hITyy21mTHgYzLm3HHL6OlOp6G/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="409944865"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="409944865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:19:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="779711278"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="779711278"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:19:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:19:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:19:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:19:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZVohcFk9JDCQnaXLQs4Y0k5qVUKj7C9UbOBC0NqZDl6bM+i342mdXeKrNvNL+oHMsfiKWNyTqa5kabwSvJuDO6j96DtWNdYq5oP2vJYrBFbgHjPB8egaEgUDMmjL8vSqruC8YY41DbDDqqRdVQJeF6B6KDWl3t2X+6g6p//KYFwHmswCBO3BEp4wxm6Z4RhIfWtYQaQLTmbpb3f7T52YLbTpZy/PnLhpqv4TP5Hzo8SaMkrBaqsbQ0bzndjNektgV5XIc9N6e7TB9fbRgsWN3lwTtXIpjav0Dz0/NJ86eSgnDbduj90pZEhB+ji2EqHacinNyVoIzwmev302IUmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fzLzknMIdcot2Meo3y9DwQM+y+W5376EjS+YpAOTbDs=;
 b=mIcS1AAtEGxvYHNcYR4GN+XawEiPbTw+lJgQ2pe4VH8GQMJjr+336zZWZDDop69Kif5trH4f8aypxh+KuoicC3elw4J4cauIRf01nvuWYbe0nyyWYQdWteYyHFfYAHHl9wWcgRiKzs/F3sqtgviUv6lS7npTfZrO/PKLAL7aIjrpIeerRO+yfXkuo+xgF5TXSKOK4WrTlr4OFl8Y5jjphJ0EGH3bvxibdMmWbmbkXQsDscpn2b1sbi5ZUl59L04it3tGNRiCkeMQYhk+deCbQ2LF/JtZE1/36K3/IWjuhpE2NDTvXMJPgyY216Vvqi0pjl8AUraWmH95YHpUwFf0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by BN9PR11MB5356.namprd11.prod.outlook.com (2603:10b6:408:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Thu, 14 Sep
 2023 16:19:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:19:34 +0000
Message-ID: <2c1f16fe-df92-08bc-e24f-a95edb2eadd0@intel.com>
Date: Thu, 14 Sep 2023 18:18:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 09/23] xdp: Add VLAN tag hint
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
 <20230824192703.712881-10-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-10-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::9) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|BN9PR11MB5356:EE_
X-MS-Office365-Filtering-Correlation-Id: b635bd9b-b606-4ecb-fd66-08dbb53e6222
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tKA7hDa8LQsgZBpqRWTnWwiVVER30NMQBk/pqCy9PEtZpcjadNQ9wxqCFbEN5cMO7nNN/A0C/esky24eSqOtLeS5MKj8ZW24OqSwfkPMW99KfjYs3g6G4IhotQSNo6aTiz6ojqDaPzbdB01xFWQ2HSuycBxdCCkS9jEXvuv+IdtECECUu2Q6N7Bo1+GWkKhwKqzNr8e1NpI4FVa1/4iG+hAFUe72uJJwEDHPxCHDF9fw2kinfXE2zVs5KZ8x/PaPfAn9dmoo5JMEWngzfDKzZiAPHwGTtYxU5hOcvnW8rlN/gZvBmTr2iLOVrbceOAPehXoMBgeNAuBg4O8v8Bu617dL5wMncvKGlTZPD1E3vScsFXBDQNz6Cpyi3OXurtGKE8SNNMPYi68Gh7sSudTlppnAL+3hfVunjONRs8oa0+aQ0C488TDmpNWJp1SBtErgooRMT9sKtuSH18Iwmm0FdYdZXjspo1RkNN7RLrigZimnOSPynWtLrAfP0ce5GieY+RuMS79/bF/i9CrZjZEbT4MpeMgIvjGcDxZnIPlhIBHotX8ob8TYLSRaISJ3qP/XCGxGj2+a7zkBUnYoTzIOL99d7DojkWEsfpDAlsMMHBFB11a9vChOm+WGlYEoyu+FdRgHxhWUKt8IprcFcUSQuw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(451199024)(186009)(1800799009)(2906002)(31696002)(86362001)(6512007)(26005)(2616005)(478600001)(36756003)(6666004)(6486002)(6506007)(82960400001)(83380400001)(38100700002)(41300700001)(7416002)(5660300002)(31686004)(4326008)(8676002)(6862004)(8936002)(37006003)(66556008)(66476007)(66946007)(316002)(6636002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NTh0bVR1dFFWbGp6ZEFNUlNNUUNRcGlBcVVJL3kvY3NOdjZxenhwaDRFZzU5?=
 =?utf-8?B?Wjl5MFFXcHErSGViaXZqQ0poTW9vOEw1U2VyYW5pYlp3Wmh2MHV6d0VSTGt5?=
 =?utf-8?B?c291dERVZTRhVGUvTHV0cVBYRjd3bjJzdnhCWnRXVEtWMFd2d1JIQ0c5dTlh?=
 =?utf-8?B?NkFNY2h3aVhSMWxxOU13U1lCS1lCakpoUXh4NEpaczBrODlnd0RHOXZnNC80?=
 =?utf-8?B?cVpmS0J0S2Qxb1MzNHoxcFR0cS9vNHBnQnZrOERnR25FOENBN2FGS2p6d3lE?=
 =?utf-8?B?U2JhSzZDS1p1anloeE1MZFgwTHVOaDhXVVhpSE5yK2J4RG5wOXNGSXg1enBp?=
 =?utf-8?B?TzZLLzY3V3d2ejkwUSs2TmRudVd3NEwwMjgzRzhrREgxd3o2UEVvTitTd0o1?=
 =?utf-8?B?N1BWZUMybHpQKzRGSk5NdHp4aktKbys3aTlJaDVZeUc3djB2S3dFTEgxam9q?=
 =?utf-8?B?T0VZUFUxaG9GTGdCQzhJWjdYLzF2MGZEbjRHU2tYZDNBZm1ncmovd3g1aEVH?=
 =?utf-8?B?Tm1nUkw4Q2FGLzA4ZlhxbFNkTnF3VXFtSGc0YzFKRGtQWHNmK3V2b1F1b093?=
 =?utf-8?B?NzFHS3ZjSkI1Q1YzSmZlcHUvV1VJcFl6UlUyOG9lekxWcmtINWl0alVRNkE1?=
 =?utf-8?B?WHphLzlNMHhPZktrMWZiL0oxcnorT2dTN0FDSUFnMjdJbHBLWEorUDBlMlBE?=
 =?utf-8?B?amtTWjBnc2FRYXIrRm1LUFRLVDZVVTFWSjdldzlDNTRDdGhoUVRGK09FRk0r?=
 =?utf-8?B?NTFncVhaRDlJWHNWYjJJYzVLZXcyWkFhMWgweEw1R2s1YnBZR2Y5elBqa1lX?=
 =?utf-8?B?R0hOWDdJaHAwbDdzWXk2ZVp6dExidlVFbEdJWk5iaG1aTlVLTkRoZTB0Rm1K?=
 =?utf-8?B?aXBMa1AxMmpEK01CbFV3VytwTGh0Tzg2cWptOHFWWlFTZjhaanl6RHhRZjRS?=
 =?utf-8?B?Y3ZJVmdHWlZNbkpFa0JqNm94bXl0dDJhZDFDUGVVTXZMc2hnZWkwQ0J6S2FB?=
 =?utf-8?B?YzA5RjE0SkE2ZW5rQUtNZGg4cFc5azdud24vVzZ1WEpuR3llQTBKbkxCR2tL?=
 =?utf-8?B?eTFDbUUxVjJZWFBiV1BxODlWOEplY0pRRklhRDFYMFRhZ2N1TExBdnJoWWhF?=
 =?utf-8?B?eUsrS2VzSGkvUEQ5WVJpNWdENUYzWVN4dTFSQVpTMGxBQ0ljRHUwV3NyQ3Bw?=
 =?utf-8?B?YitRdFRYb1ljRGo2VG1wZS9TZDRGSmhmam1xNU5TSlo4ZTQvSHF5UlBJUXJx?=
 =?utf-8?B?UXN6UGtBOEVLM29hZGxTV3psTDlpOFMxZE94MFk2OEJNY2FHRjM4UXlUQ2gx?=
 =?utf-8?B?VUE2ZWwxVFoxMFRFcElWa01oL0VDcWkxaDYwdzltbFp5bXZtQ3krYmQyR213?=
 =?utf-8?B?eUgybHBuUFNTTmZpSG1xbWNQc3I4WWE1eXZleUc0TDNGZmFUM0J4WllYOEhR?=
 =?utf-8?B?TFpsdjZSR3dSVm1XWVZEWnpYL3dNT2NwOEU0MzFDUlhMUmdWWHBIRTllV1Q4?=
 =?utf-8?B?M1B4WmQrWFl5ejN3SkhhVXE2NGFYNmFlRkxKY01IOWwrbmIwTkVpSThsakEr?=
 =?utf-8?B?cHNxd0hEWi9lVjlXVU9OV0ozZmcrR1EwQktEa1VhdzJOcGEwbnAzbnNobnBz?=
 =?utf-8?B?eTdNcU5BRHk5L2Y5blZOeWdVTnVpRCtObDF3NElYMXQ3T1Vvb2h4Tk1GRFRD?=
 =?utf-8?B?ckI3d2FiUnpNOVRPWGMvY2pUWmVRcWhTRUJ2MjNGdVpvZ2pBUkE0TW9jWUQ5?=
 =?utf-8?B?TjdPbWNETys2bkplRlhSZExEc0NzeFZuMHFWcmNjaTFKWEtyTVorOGw0WmJw?=
 =?utf-8?B?clFlYm11UHR2LzZteGpmZG1qRnFlTGVKY1RwQzgrTnNvaEJKTmFWTWpTaFo3?=
 =?utf-8?B?aDFuUndWOWx5OGpja3B6THg5ZkgyR2VYWXBQU1NxSnM3aUU1eGlpSFAvTXA1?=
 =?utf-8?B?OEJqZ2cxa3VOcThyeVpya1NsZFdtTis5NDlFTVJjSWZ4TzJZZDdTT1VVMm5G?=
 =?utf-8?B?YmJ3cTZnRzNDZjE2R2FTMTBwa3pDQWdHOStxTXZTc3lUN1Y5clRIQWpNcWtL?=
 =?utf-8?B?THVlTGIzbU04a3VJRnU1Q2Yvb2pQQWNQeWJ6R0tSelMyYkxnQ3FyOVpmN1d2?=
 =?utf-8?B?M0s3YUtsUFdDZllMclJxbXVTdjFobkZIZXBOU3lGMWZVVDNWNUdJOGFvM1dz?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b635bd9b-b606-4ecb-fd66-08dbb53e6222
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:19:34.6222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fb2gTSItJ0i/GlYcldSy0otDcJfZeHzQIb8H2R2miOmPQQESoh2Qo9GVrBahyLVJ5eSEvFTYOcbnp1fVoZzZMW4SRvn2Z9UcsnJwAwUerUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5356
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:48 +0200

> Implement functionality that enables drivers to expose VLAN tag
> to XDP code.

I'd leave a couple more words here. Mention that it exports both tag and
protocol, for example. That TCI is host-Endian and proto is BE (just
like how skb stores them and it's fine).

> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> ---
>  Documentation/networking/xdp-rx-metadata.rst |  8 ++++-
>  include/net/xdp.h                            |  4 +++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 34 ++++++++++++++++++++
>  4 files changed, 47 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/networking/xdp-rx-metadata.rst b/Documentation/networking/xdp-rx-metadata.rst
> index 25ce72af81c2..ea6dd79a21d3 100644
> --- a/Documentation/networking/xdp-rx-metadata.rst
> +++ b/Documentation/networking/xdp-rx-metadata.rst
> @@ -18,7 +18,13 @@ Currently, the following kfuncs are supported. In the future, as more
>  metadata is supported, this set will grow:
>  
>  .. kernel-doc:: net/core/xdp.c
> -   :identifiers: bpf_xdp_metadata_rx_timestamp bpf_xdp_metadata_rx_hash
> +   :identifiers: bpf_xdp_metadata_rx_timestamp
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_hash
> +
> +.. kernel-doc:: net/core/xdp.c
> +   :identifiers: bpf_xdp_metadata_rx_vlan_tag
>  
>  An XDP program can use these kfuncs to read the metadata into stack
>  variables for its own consumption. Or, to pass the metadata on to other
> diff --git a/include/net/xdp.h b/include/net/xdp.h
> index 1e9870d5f025..8bb64fc76498 100644
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h
> @@ -388,6 +388,8 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
>  			   bpf_xdp_metadata_rx_timestamp) \
>  	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_HASH, \
>  			   bpf_xdp_metadata_rx_hash) \
> +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_VLAN_TAG, \
> +			   bpf_xdp_metadata_rx_vlan_tag) \
>  
>  enum {
>  #define XDP_METADATA_KFUNC(name, _) name,
> @@ -449,6 +451,8 @@ struct xdp_metadata_ops {
>  	int	(*xmo_rx_timestamp)(const struct xdp_md *ctx, u64 *timestamp);
>  	int	(*xmo_rx_hash)(const struct xdp_md *ctx, u32 *hash,
>  			       enum xdp_rss_hash_type *rss_type);
> +	int	(*xmo_rx_vlan_tag)(const struct xdp_md *ctx, u16 *vlan_tci,
> +				   __be16 *vlan_proto);

Was "TCI first, proto second" aligned with something or I can ask "why
not proto first, TCI second"?

>  };
>  
>  #ifdef CONFIG_NET

[...]

Thanks,
Olek

