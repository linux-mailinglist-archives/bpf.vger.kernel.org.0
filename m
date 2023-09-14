Return-Path: <bpf+bounces-10051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E07D7A0AEC
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 18:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF46E281A00
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 16:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CA328DC9;
	Thu, 14 Sep 2023 16:35:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066873CC44;
	Thu, 14 Sep 2023 16:35:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 654A01FE8;
	Thu, 14 Sep 2023 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694709338; x=1726245338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lJPo84E1WW+SYt0NlVVk4y94Vm3D33w5hmMKH5sjhKI=;
  b=OChAZjtlMM2kRfmtFVyGClTMLIfJPiThGr++AOhBXuINKVTlBqEGPaty
   4TD6lN+XcFIHDTDcvyM/bg+9rnwoGZMh12kmvGDpOnRrPQ34p5ACgZUR1
   CbuJykPvKt6W2EDgkL7Wuh+YsoquUUW9OUd7FSCaotIqzTPgtrfsRYV09
   9/tJwCW74V+X+W/5M89SkjptQJjoaI4x4lPnHem9nQ0pgEisMgl/XBmBP
   Zi8xuPPvJHfYEW19lUU7m3wDkOnZRHHyZDoCYC6RwrzyPdmsBWhmXkHHB
   p3VER1oRd65M1/7f8C4l/x8kDMvXk9NUGNA4sr+6eD88rG/1tWtib9lf6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="364053976"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="364053976"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2023 09:35:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10833"; a="747816419"
X-IronPort-AV: E=Sophos;i="6.02,146,1688454000"; 
   d="scan'208";a="747816419"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Sep 2023 09:35:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 09:35:37 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 14 Sep 2023 09:35:37 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 14 Sep 2023 09:35:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EATznK2plfhl6iRcJQzIEMa13HlHXHktR7KRa9OThgfaOc/ZKc8YFoSLSjEvFpS4WJX0bU+Y0B/x6mitM/RQuskbGEZDUUldvKSHmkWnByVCDr7hPbfwbIOpJYxGYX2rc4DnNTRpwWdqaBozKUEd9Zcbm5fMYUemx9sMIrmJCAUMId5UHkS5iwPSWzgB9NJzSePahCPA9zS351vOZFKhYhn0WcUsdSFr6zbN3wNHUqFSaAT0Awzj3DphiM+UAswPvyDQVSn+BmT3vJJCXxIVObuAxXXYaRRJ6EurfTeZw/OupGDQw/aBBsh9wGheN/DxEJ1SeR1I2JUHAFcUTowyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=drZunxVgKDQ2G0X4I3S94m2qXbvxmkYqY/ZjPh2NJEk=;
 b=aYeJ+XWdmVpALfEBHfkOaKmE4KUYTbbGXs+OH1v1q2uTCQ42BWVAIwgxs2gFQi8qx/eqI5sGxQGtX1OAXLItUogvDuuqpASeMc49qeiTSmxwXDn1BY9KQTTIvSGD2Fg1yRn5oBh4S/RRQyfK9er0nzrrXaO5vuhEDZhkQkvxvP7dFkIAH5yjMuw4pgxXzk+3ffm4kuwAnxZHG/5jysBRMD3G53ZIKm74FEktCMDInQNz9eow85D9NduyVAYVPrpxQyx8s7WNHXBuZ4hwxZFtyRpLHj+EhV64HJT9Uv9zBHhlyuJLzHswL3HV+1rL9xJ4FUYfaUw7EXGGNcqDj/v7mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA0PR11MB4669.namprd11.prod.outlook.com (2603:10b6:806:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 16:35:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Thu, 14 Sep 2023
 16:35:34 +0000
Message-ID: <280ca32f-4c69-dd5b-fd9b-e69a7685a60a@intel.com>
Date: Thu, 14 Sep 2023 18:34:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC bpf-next 12/23] xdp: Add checksum hint
Content-Language: en-US
To: Larysa Zaremba <larysa.zaremba@intel.com>, <bpf@vger.kernel.org>
CC: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
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
 <20230824192703.712881-13-larysa.zaremba@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230824192703.712881-13-larysa.zaremba@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::19) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA0PR11MB4669:EE_
X-MS-Office365-Filtering-Correlation-Id: cc99989d-a72c-452d-cbf9-08dbb5409e4c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4en7oIe7dfdx4RIqhilVu/CrP2E9HGz5PvOrDSKzISymiwRH8gqOT8NGwxL2Uk3MImp3Jo1KBx0jz2pjL2UmlJOcqC5FAZNj55yWa9MOn/WA4crdk8lBo8pxRQ3NyQZKTzQEyGBicGxJ2cRYRq9Gm/ho+x8LM61HOZCXkgB5UwI+zdKtUvqsRGLz6WJmbA/N6aUpLm9JuBx+oN8uWdQrGzm0zBUXjqVm0s7r62nV0m8E1w7EYUKVbnXZe4DiYlpXtsQ0IjBYnNL5BzPav943KkAYf+uK6/ff2KNMCQTiWaSaZ2/geBSZo3oLA6v04XtX1Jx+QpPNn6viqAlyq10UPJbnXE3rkhXRPxQe2i1zyy7DIWYAgAbVLM2PYsYWkg1NaNz+BUm6QYsxGZpmh3Y5AV2qGV5SemE5oJRiCxC5+qMtuq7GYxxkxRXZ3gtsDxJFP3bidm4qg2aNu6a4kXCFlMRUscK/xE0Oph40j12MnoMifhnsz3VwPv9/opdzvYn8ST/oKMQz7jBXNAXTsPgMWwTJtkPYvVDxiSU1hJT88uy+3UZsC1T+0sg5pl3do+PRHqcqyXerxsLVmsuBMAYjGO0phws73801m+L32HA7ooWIgSRzzi3+1Poaxi9QnlkogjOl9WwgyJWf/0ThLd19w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(136003)(366004)(39860400002)(346002)(186009)(1800799009)(451199024)(6512007)(82960400001)(2616005)(38100700002)(86362001)(6486002)(6506007)(31696002)(478600001)(6666004)(26005)(66946007)(8936002)(8676002)(4326008)(5660300002)(316002)(66476007)(54906003)(41300700001)(66556008)(2906002)(7416002)(36756003)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2d4T21rdEI5a2VzUTRPTEJZdTdvUVBVcmZiOTMrSGl0UUQ1SlZhb1QzS3Bo?=
 =?utf-8?B?QkFQZWV0ZlVubVhmSkUwNFJWZjUwTjRuQmhMbElxdVp1cm5LSlVCUXNiNTRL?=
 =?utf-8?B?SGtldy9iZnlzRG50T2hwc0prbjRDMzA5SGxvdWE1c2VWZUI1dGt4aHdXcnNv?=
 =?utf-8?B?NWdMZVBDN0YzNG5ERjdoWkRsekFMOFlUWHNVQXF0VHhpYTh3ZnBlZ0k5VlVN?=
 =?utf-8?B?Z0tJbkdHNWZjTlorY3BudFU3c0dxamJMRFJtV3hubDhlVlJxbUZMak5NUEE5?=
 =?utf-8?B?bHhCR3VmRDBWN2lPQUxUTGRleStoZ01hQWh3TkJ0YUZBcFNlWDJEaXFLWDRB?=
 =?utf-8?B?NE9BZW5RRFBEelNMUmtEekJXNU1UZjRmdE5sSFFkWjkvbDljcEZCckFqVkpV?=
 =?utf-8?B?Zlh2M205N3UzaEp2Z05ncjdGMENrNENKeEx2Yk1iRzY4VllvQ3NCYnM3dVdS?=
 =?utf-8?B?cytDQmZGM2g0ZTJPRWVmL3VkVXg1RGpjL2FqRDhuZXVGTDJwOUI3RmE5SzFx?=
 =?utf-8?B?THRtOTJMV3pWV3JCRFRuRkNFUm5UUmFPQ3crNGVHdnZKWWx6NDJ4aWNJb1Ay?=
 =?utf-8?B?bEZ6dmZtMEtXWnJLUnQxdWQwQUVUdnM4bTg0YWwwUmVDRU1MRlByMkVhQ2VR?=
 =?utf-8?B?NDNiYWxVQXYvaWdKeFFiNjd0S2d0aDlCL0tBR0R0VEplQ3pueHNGRmpQUGFo?=
 =?utf-8?B?SXorTVVtanZBdEMrYS9XZlMvbDNKZkoxTE9SMGlOenVmeXFzd1BIWFd4WCtB?=
 =?utf-8?B?bjV0MDcxQzd0d3I1OVVobEVDOGEyQ2JENGRUNnNwbkljT0dnaVhheFRvdVJZ?=
 =?utf-8?B?NnVnd3R1N29uM3F2Y1llVlBRYm4velEzcjBQTi84eGhNbDN6a1N1ekpadzl3?=
 =?utf-8?B?cXY0OHFLcURJYW4rcmpacjFMczIwZlMrZ1h1WlhsdDJpMGVhMk1EVmd2cmwy?=
 =?utf-8?B?OEhweWpWWTNPVmxqK2Q1c2VzV3JOTWF0Ryt3RTdRaCtnVTVCc20ramtCWHJi?=
 =?utf-8?B?UDkwQ25Oc0MxdkFCNVc5MWlKbHgrSHh4bHgwN3VkanBiaFJHWDJibVBKNEpM?=
 =?utf-8?B?TitJTVVRSU4zZjRJQVB6WHFON09rWEtCaDVEamtJa2xYMEJaYmU5NnFHRE10?=
 =?utf-8?B?NjI2VmIxUCsxbFpkZ0FHNlAyM3lvdlR5K3c4WTR3K0xocEJ6RG93a3NaL0RB?=
 =?utf-8?B?MzlZSGhPV3l6ZkxXNWlCblhuOGRkL2xLNFZUZkYzT1hXdE81R3A3Y2MxSE9h?=
 =?utf-8?B?UFFCQTQ1SDdkOHdyTDJFeUJYNE05cGRaenZhZitpODFBbGFsaUN0c0dGNWhZ?=
 =?utf-8?B?V3FQai9GaUc0N25DR3JaYXIxdFNja3FzOHFjOTUrU1lHTEhyOXNXRHNDK2ZX?=
 =?utf-8?B?K05idW53RnpBY2xGK0pOOUVGRkRkM0NVd1UxRldBend2RVFaZGh2SG1NS0Fq?=
 =?utf-8?B?RkR2YlZkeWlJT2YrMUFCeTlkcmNlMEpybzRTNHJ2YzJNc0hhODZsQ2xtV283?=
 =?utf-8?B?WTQ3OVpPT1hDOXlPTVRxbVB5Q0YyY1ZCZkRSZkhuQStYLzZUTmg3SUszQkhZ?=
 =?utf-8?B?WlQxdDY1dDVlRUVmSGVjY1ROVDdXSFh2OER3Unp6Q1hKTXRxZHMwSUtLY2xU?=
 =?utf-8?B?WFJ5ZG9KWGphMkdLSVcweFB5UVJFUDVNVHBoZDdJWFNEbnd3bWtlQkpKTGQy?=
 =?utf-8?B?YktXdmh0bEtNWFB1S3BEQndsSlRlZDNOQmVtWjhld2tJaitqS3RMNFZ0akVT?=
 =?utf-8?B?SWVYbDJ2VktvenNKQm1neXdsbFcvS1dwaDFHV3N1c1l3ZGVxeXdBaDhwZnJE?=
 =?utf-8?B?TjEvOUZwVFQ2ellxOVpaOHMrUGt0NHpmVHhxTzhSSjlQZjcxT1BIaVVkVXNy?=
 =?utf-8?B?Vi9lMTJsQzlneUpuNjJDdGhtTFNpYWRVRXQ2OFUyblVmV3U0T0RrNEQ1SVFP?=
 =?utf-8?B?QU10bUswQ1dwVld3Q0pXMC85K0tsdkdGa2JzY0NnczU4VVlWTFdQRnJsMHdl?=
 =?utf-8?B?RzlubFZKaDQ0M0xody9hNnRvb2FIM3JVdlZkbVNpeFlsVW1RWkdpTDRjdENm?=
 =?utf-8?B?cXNvYUpIZ0NRMmVzeGRodjM2WjBvaVdEY2xPOE9tSWVXYlRFZjlkYlNtVUhs?=
 =?utf-8?B?Y28rT0RSWEpxMkR4UlprSWxkTEcwOCtFcjJQSjV5MklaWVBnU0VJQ1F2ckNX?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cc99989d-a72c-452d-cbf9-08dbb5409e4c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 16:35:34.3983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IX2X6El4B3VuDb+nK57VC7wsTm1sfeB219LWZ4cF60YUdjpumHRll+6C9sMOepeOld/7qqSR3+tUOSvEl8rGt7my6wWaEiPPDVkzkXFW/Lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4669
X-OriginatorOrg: intel.com

From: Larysa Zaremba <larysa.zaremba@intel.com>
Date: Thu, 24 Aug 2023 21:26:51 +0200

> Implement functionality that enables drivers to expose to XDP code checksum
> information that consists of:
> 
> - Checksum status - 2 non-exlusive flags:
>   - XDP_CHECKSUM_VERIFIED indicating HW has validated the checksum
>     (corresponding to CHECKSUM_UNNECESSARY in sk_buff)
>   - XDP_CHECKSUM_COMPLETE signifies the validity of the second argument
>     (corresponding to CHECKSUM_COMPLETE in sk_buff)
> - Checksum, calculated over the entire packet, valid if the second flag is
>   set
> 
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Only one stupid thing from me: when a line starts from '-' in the commit
message, some editors/viewers paint it red thinking it's a diff already
:z (same for '+')
Not something important, you just may want to prefer "neutral" '*', up
to you :D

> ---
>  Documentation/networking/xdp-rx-metadata.rst |  3 +++
>  include/net/xdp.h                            | 15 +++++++++++++
>  kernel/bpf/offload.c                         |  2 ++
>  net/core/xdp.c                               | 23 ++++++++++++++++++++
>  4 files changed, 43 insertions(+)

[...]

Thanks,
Olek

