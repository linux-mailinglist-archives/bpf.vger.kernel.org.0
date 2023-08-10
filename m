Return-Path: <bpf+bounces-7444-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D50A777803
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8241C20D62
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4232F1FB35;
	Thu, 10 Aug 2023 12:16:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F18B1DDED;
	Thu, 10 Aug 2023 12:16:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264AA18F;
	Thu, 10 Aug 2023 05:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691669773; x=1723205773;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=xirl4AmYth+JCLjoQsegok5h9cw0Z1NzgkLbFkmc5bc=;
  b=SJNFx+sPi5mUv5ALvktOxQIfEneBaVr9p605blP3W5pDZx5Om9Bm0mLc
   jq/9o9/p67VBZLuyrv4uL7t4AxVD15H13woCja6y75qjz+lbBgzPMF/Nc
   gLG9D2j3U+XkQR2bWiUZUKVbKXESM0FsWet/CTHoWv3IOLKRuv6jCrDB6
   zezlSHHd7wNtMeyfXy5jwYUB5xc5TVEMgU0/4QClFBl9c073rR8k50UXA
   cv6a3ss+FfsaDwzIRrW44nr5fmzsKsD+xgYSON10tU1dzEoVloJc1a12V
   U6pse9PJhBUvh3bpl4vNoGtolY522zoTrm9gmTAr9qveP6oes4qaXxJA1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="350965466"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="350965466"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 05:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="725770568"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="725770568"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 05:16:03 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:16:03 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 05:16:03 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 05:16:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 05:16:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8wetEfxqJp/jRpYMSNHkfqqjV3PFkaW4GEVbSWiZ6GbwZotE9JisfH1H/F6HaOJX4CAsmdoBw8UaytqCJo0yJboyuBjjkjOxOir5/aJqBQqOJ1XpenxYbF2rQsKMBtDAp/lHA+BP+0Bsgrev7H60Rvtcfj8uEfpJhmV1sJmUbeynU1G2Cn1om9DamZSYGtMjH1vT7pT2U4l+79qcgI3d5oY3GjQLWEHhuMRsXj/cxBxmYkvvYWhr86gG81E+RHjCxxi7bzN5mH0wtWvo0hzbrBJS/jBL51sYCwl6JJU6/nqB5ZZB3/JP8vcmOUQ3lLG+hv4euXx1PXsiz3ZVUakDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=blvEoV8oQnJKdTkEGNDXE7UiM/nz/u2enaW5VtWp+cc=;
 b=FGQ1C7tNyxytMNy/qTGgEbUuP3iIO6OEP4uC80W2QwqcvNDFX4qWIN5xRhwbGEJW0fNm0Z9c6HJGdrBiNOU9UI9qZE43VQTLvUfxp88AZduQAsKq+LUSsAMoDHEiy5UUq3qTmEz/BVAGp56y/jQLLI5d8T6oCANiVLCgBM3+JiYffBfjk1YqZdZ30Hvz9GEWxpDGH0CpNw+022PkAUPg/W2iC37dW8Re3ITDJJPdI2qjqlxLkXpNhoWHN7W6KdRqvufEy7D93QqfUQ4ZN35ZazuM/Yspn9cdx1vROT5o8EiJ3iDXYq2BIFqbjKckDxHSucyWPT5aduuwqgdwEu7New==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CYXPR11MB8710.namprd11.prod.outlook.com (2603:10b6:930:da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 12:16:01 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 12:16:00 +0000
Message-ID: <59631f92-c206-0f90-3eea-58d883147784@intel.com>
Date: Thu, 10 Aug 2023 14:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH bpf-next 05/10] selftests/xsk: declare test names in
 struct
Content-Language: en-US
To: Magnus Karlsson <magnus.karlsson@gmail.com>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, "yhs@fb.com" <yhs@fb.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>, "haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-6-magnus.karlsson@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230809124343.12957-6-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::18) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CYXPR11MB8710:EE_
X-MS-Office365-Filtering-Correlation-Id: e4283d84-1c3f-4eb7-1d44-08db999b8f59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E8LtRzFGlBmW+7nX/KmPalEH0wzFn9X7T0gyqEi295s1dXaEfk3GNg24HJ6Xhjfkljl96yLeg9cMMyKRJWa/SwS3uz9karRjnsJKGbpYEn/mPuVd7gKMtrEuhDTDi02nRkGwZ5Z9UfNW9EtCyUSWZb3OJ4zq5zah3YPEcYTF73+IS8s9hdwvEba0v+ue6toukq77b20EwtwuAoAyklHZh7mZBUB3EruYfhsjDgzW2TBqcZE36jikxU3UVArsWTSH7BCgHdNvIFaShl9DxxpM3on1ISKzkw5gQZat2oC/8XS6BfM1QKCuU6hIS0jHDSH08XbS6c9kb/CYk7rVV7u1fsnarnNazIYtpEhMbHRJoFek3PFTcAH+7A/mItuDHjTeQoIbBa7I1UO3TTL9oJsU0cMx3DgIgU7tot4qqq8Q0zpK44N31fiPla/BrDjdT6udZkU3bk6HiePHKm8nalMRBYNg5fvb4R2j5te/WdNLRwZDX5oAugGxROQgSIBzwAWKOYfo6G6vxEZDhihLP2F5SsWfLpFBVJv3D1gxVZx18/bmLE18BFGuIdcaEe0+V+R9hyqs+S84uQGYFC7ScMgPHiHPDy2/z0rYaDwILrKQT6eUT5R1wqPW3TP1tUK+kzVdSxqAcXajr8mZeVSVMPhGc4R9xVolv67LNOenkjQYu1Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(376002)(346002)(366004)(39860400002)(186006)(1800799006)(451199021)(7416002)(66476007)(66946007)(41300700001)(6512007)(6486002)(6666004)(36756003)(66556008)(5660300002)(8676002)(8936002)(316002)(31686004)(110136005)(4744005)(478600001)(2906002)(921005)(82960400001)(38100700002)(83380400001)(6506007)(26005)(2616005)(86362001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MURyc2pWYU1pS0V6OVpOUmpRMUdzTkJKTzkzVXVIbXU0ZVZTWXR5L1RxM0Qv?=
 =?utf-8?B?TWZDS2xMdWpjdjBOSVhZY29kNWtHU2hDN0tnS1dOY0lZc1ppZ3d0cjlPeEh0?=
 =?utf-8?B?U2s5TGpMbzZOK1o2V093NGlhV0pSVEJaZmF4ampVTlNsdUtzcjJka2V2NHNm?=
 =?utf-8?B?amsyK3dROENmOFhQYlU3bk1QUkQ5SEwveW1IZFF4L2ljcEhybEhrVWVFZTdr?=
 =?utf-8?B?TDFaaGZ3OEd0NnhLbGNPd0YrTS9MbXVZRGRNcnhWdHpHbzUyVFJYdGgrU2tE?=
 =?utf-8?B?dzNBbEE5eUNZMXFxanIwOU14YnRGcmlSVG5sUXhpR2dQb0Mwak1LUVJUUEdj?=
 =?utf-8?B?UFhHaHBJZkY4WG82Yjh3bTRTT0NDdHJvSGhnMkZ0ZFllZ1l2TEFsRmtVSXV6?=
 =?utf-8?B?RzZCTkZXTW5JMmVsQXlydVlKekZqYmVWbGhia0g5eEU2YkNyUlpjMHNmQ2pZ?=
 =?utf-8?B?TVU0QkFzSDJNbThjd3RLVUI4WmtvSVdjbG13WGpmc05uVFlhMnVzNEhhcUd0?=
 =?utf-8?B?ZENidVBVTnlLNnNER0dxQ2kwazEyQitQaGVzdFJRNHlRYkljOW9KbTNHdUg1?=
 =?utf-8?B?c0JYbXFuNjFYNHIrWUMrREwwa1dpTzVZRS9ZVjhUVlNLeCtEa3J4SWtmMjFa?=
 =?utf-8?B?QUVuaWRMdy82QmljRGozSzVpNVRRZUlFZjZ6RkdRRjZPMGlzU1JzdnFlNWpG?=
 =?utf-8?B?RE9RaE9jRWtoVFZmU1BOL0ZFR29zYWNBMWVvTGJzbnoxS2d6M1R3anRwcW5a?=
 =?utf-8?B?SkNWTldESjRSN1dpN001ZnZPbTBrSGpPbk9COVZRTXpJYS91aGVQZFc1azJT?=
 =?utf-8?B?YmhZVlY3QUFpSWphYVpxWWRHdDRvTFpLby94bldROTMrUGlJeGxSenRCZ1pu?=
 =?utf-8?B?cHhJWUtmaVRCWTROZXphbVlkY0ZubG82bmdrTkxXT0FyRE1IOThsWi9yandC?=
 =?utf-8?B?aTk5MXhYYmZhOEZCY2tqWHkzNkFUaUxWRTJoTTV2dGJjSUduTnNCVDk0S3pC?=
 =?utf-8?B?M09FaTBXM05xbDUvTEdURVVnSjA4S3FyL0h2MXBuREdMckhJWUQ0dXNjeEh3?=
 =?utf-8?B?elNJcnl6YXRCVmdqVnhKTkozbVQ2RXlzZ1I5VXBhdGw5SXB4Zzg0R3RXTjlI?=
 =?utf-8?B?aXV3dS9QNFpNVmN1N0pJbk1KQUhaNGltVjJKdU0ySmwvSldaM2NsUWd6QVND?=
 =?utf-8?B?WmxNb3Rjbk1MeFRNb3lLdjY3cGNOK1E0YXlpSlovNzhSbnlnaG9XLytjYjBO?=
 =?utf-8?B?MEZxUnd2MGhTQVZQa0NndWFmZ1pKYkxvZHdWZFpVZnlxYXdqUjNjb0hxdzRW?=
 =?utf-8?B?c2hQNTQvdFJMRWZnNlFQdjVwbVNJYTBqTHEvS3VCL1JIN0t5Qm13Q3VtNVlv?=
 =?utf-8?B?aWIwOEh1NERFMWZ4R0NDRUhmSC9LYWtyL2JnRUlxdmo0d0J3Q2I3QnRpLzhL?=
 =?utf-8?B?eStpNU9WMVdTUUlmRDZ1c2pBa3doNDB3SUJJWGN1V3BkelFMWTMzeDBJOFhx?=
 =?utf-8?B?VnB5YlNTaFlnZEpxejlpYXN6RUxMbTROcTdFdGE4TnJwcHE0M0VzSkViRUZn?=
 =?utf-8?B?bWU3ZVhwQjdSK2J0M044QkhnVTI5alg3UVpMR1ZFVVQrQzcybDIzS1ZjYTZs?=
 =?utf-8?B?eU80bHpNdmF1MmlkNFEvUlIvdDBIaVVhS3hHaEdVdExSV1NRblJqVkNNRVdj?=
 =?utf-8?B?dnFWVlp5ZVJnRU1xdXhDUWRZUmJ4QmgramJkc2FRMDlBOGZnNGV6S3lkeVgy?=
 =?utf-8?B?eGZ0QmJlTTV3cEk1akhCT2ozNDJWL1A0N1JFMkFRcENKMHdQOStCSGlMTGcr?=
 =?utf-8?B?QXlTVnF5NmNkQUx1bkRGVUtHZ1BnQjhRUlZsRlNKWnZVd1RPeXU3NjROektD?=
 =?utf-8?B?ZVpnaWlyN1h4UWlwN1lYL09OdHA1aXIrVkJ5SG1Xb0ljQlFMZVdVRWI3LzlS?=
 =?utf-8?B?TitEenhKMGVWaldEYVY1Q3pTQXpMKzNWckR1aWxLNHY4aXMyKzlxQTJuWU5D?=
 =?utf-8?B?SDFUMlQ4WStydWhscEpwTHBuRmhMaE9meHFHWStOWHh5VVhTUVRMaFJQMnc1?=
 =?utf-8?B?V21DRldTTytjOFMydllPNlFYTDZ5S0FFR1E3cTM2M2VmcGc2ZHJRQ0tqWmd6?=
 =?utf-8?B?NHFPaHkzV2NnZTdsZW04SGorTjNtVDVBSzBMeWUwNTNnZHdKdjJIMVk3RlQ0?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e4283d84-1c3f-4eb7-1d44-08db999b8f59
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 12:16:00.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: si6R+CgG7NCq0JS29QeAYPwFWaCynFoMScdlyl6hhLIOLc0IymvTlLgOLUKD1D3cLf2FNu6aISyD4+pGkFnq7Ta8VhC7nMKYL01ltzaQfio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8710
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/9/23 14:43, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Declare the test names statically in a struct so that we can refer to
> them when adding the support to execute a single test in the next
> commit. Before this pathc, the names of them was not declared in a

patch

> single place which made it not possible to refer to them.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>   tools/testing/selftests/bpf/xskxceiver.c | 191 +++++++----------------
>   tools/testing/selftests/bpf/xskxceiver.h |  37 +----
>   2 files changed, 57 insertions(+), 171 deletions(-)

[...]

