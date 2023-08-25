Return-Path: <bpf+bounces-8574-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2697887F5
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 14:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B98A2810DE
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C032D523;
	Fri, 25 Aug 2023 12:57:58 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7DFC2E0;
	Fri, 25 Aug 2023 12:57:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E792693;
	Fri, 25 Aug 2023 05:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692968257; x=1724504257;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WrC8S5Zvb6lCY+NLUpEDldnIkp7XtLsH5UYjSoaorBA=;
  b=LF2x3mnP0eQWD7bGVElDnAoDfVdPe//gurFH+8yWTt0Dc4dVdxwoHShK
   uQdshD4jU+8FUcFd+gvZtgFzeQkxjjxAgURvdXPwxNJ70qIvABKivQmWx
   zZZpA8Q3ZeW2w79WklPuJjLlTnA+SfVE6Y9WODwDiX/t2L5iz/G/01sOD
   Kv0Rg8errTvCvU/WSY1xFWC56YwPwmKCE0jDeID/MJAKh5vuVbW3KL/5p
   lUtQIrnrUprHDb5vh/ir8iyjSAZO07XHYWb80UhVHjqGMB1nlJEm0tzpi
   kKaedK6tuOtS4YHy01kboAzSk753d7P1UVEKkv6UTGweRPsTUQntqW4ht
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359706115"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="359706115"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 05:57:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="861080334"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="861080334"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 25 Aug 2023 05:57:36 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:57:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 05:57:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 05:57:35 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 05:57:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meEnAxYy+93p8FmjJQjiO3yN6j5QCj1KEL5zk2sotjvqa1VOfvR16w3rx21UfDB/bHizxgHH19XGsuqYgwFQ7FFuIn+IEAMZbi+79bWRnTS6nMmITxwaqghQ90b1iyByH9t1XbFJBwXBOoh5NFenCEDw6qk1wCk579I3PaXsyJdfVAisRRMJ8wXC5uXERgyOqTPI9MTTFuDykuH3jlLmqIJgMB0K9W+bHIt7LonL8dls7wIoM+VjZt6E0hureK4nsuKXMYs2aNF3BVnjX+nL10DzICYrMQBRYpJy4pbpSciFWbtp77loftZK2uv+r0dgpGOC2O4AYaasWWezLR8CtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXMMUsF/MSVmvL3srapdvRF7hiPAvzQR/YOvnCNKEFM=;
 b=WogmUk+ETBnvNwJb93Vqq3GGAvn0XaIAmjymLenIFxebMAMwFu0Fhs5vnPfCL4WAasRbrqybA4kSWmOj5eUH4BltRh/+3IaflEGW750dRd/zTWNLV56bmwqR1D+wDi2ZZTCqB9jyNqiYZUAV5TVCd2lUF6GVahfoZAOqu4jvKpj1qORyXDSwGdUhNlKcagj60yPcpoFQElRC42FXKYpapPItY83O2Ht9UeZ8pNRD7Jft2mmiSm8dbHuOLJXsHJotFRypYfM7UzH0cyr54BLOwI1OjArUy3E7IL13GkcxbcJQbkC7gW4bU4xWLWnXUOJgfyxug2Bz9TSCpICIcOSSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 12:57:33 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 12:57:33 +0000
Date: Fri, 25 Aug 2023 14:57:26 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 11/11] selftests/xsk: introduce XSKTEST_ETH
 environment variable
Message-ID: <ZOilNr8AgqZKCUeF@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-12-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230824122853.3494-12-magnus.karlsson@gmail.com>
X-ClientProxiedBy: DB9PR06CA0021.eurprd06.prod.outlook.com
 (2603:10a6:10:1db::26) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY8PR11MB7846:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3099c8-340e-4067-0291-08dba56ad940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2+lZ77LzD1t+4+UYjWfMYYEzEPM9LAYlGcjBQHN76Vk6LXGCinHEgJfFDQK3CKXClCcrhppjBKORs7c1wFPHxTjDczalYivxIBfP35edhv+6Cczas4Rp8yhA//jbwvG6C7pbQsXAmvTlnsdC6Jp8ijTl7EeruKR1iUBfhKTj6yHHWIO1nTD25z7S+LQKQ61q6XKS0V+XV5bIMvy478wdQ0TUf0vQlZvlCX87PK0luP7B+FbN394+p5PDYx4RMSKvQvY5KWeEHFZHkIQQ7/plvwi1Zr1BR1Ddi977pjf6EIKbuHfKgid5I1Y77zcKwlh/Rk8WSRFHp5gjym+Y1m7yvxPa6kD/2nyKApLa58XmliSHPMGg7l24KzXLgWM3/AkiX0OIddVH4Odw2CLUNpQZ97WID36LyKkXtXXSIfLIaxdTA0wPmj4BDqZxZvxn6pk7Md7/lUkk/00M2sb+J22EYXJydwb+e9Xe0C1AeL8mdQznBfI7+5Kba8ZeULZt7kElT6FZFxETxC6KeudwH5jneQ7m4NwBbX8i2Hhje2ox97xl8XCQob6mz0adYjbES2pJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(8676002)(4326008)(8936002)(33716001)(41300700001)(6506007)(6486002)(316002)(6666004)(66946007)(6916009)(66476007)(66556008)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(7416002)(2906002)(107886003)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HGFA2Nz1aqzfRUp1qJH6FfbtCasajnVLHYcnKdUVRwNXdEr5SwVEZJWf6QLF?=
 =?us-ascii?Q?YtgOopK2Y/6oLl4GQU0MDNKBFmHtfH3JIjbu4V4xJEFL5hHoILXlrDaxsfqX?=
 =?us-ascii?Q?pcr/v0JWN2l1E5sAuwF5IYOtT9HPubkpFVBklFd3C8YYRaOPZUuZR5dho9EY?=
 =?us-ascii?Q?DSGO7Y8yagSAQHC7N7LAUESCQvObvINBEsmPfQsba+7GZUd1tlNuZzi9ZSM6?=
 =?us-ascii?Q?Q4g2ToGqcmGkPo0xlS6egFr7bC6Nk0RKHhkE8nnAJ6DXRxbCz820E1pDS0J5?=
 =?us-ascii?Q?FVRWg6H9J5SxWxgnqk8Yvob3FasSsbO55rk59bzOk5vp0ROGpD5FgdFkTS6g?=
 =?us-ascii?Q?V1k65l6F2bEK7IU01d8ibj9YXjhss3XCwloFPQac1Pokt34AJor6cE0q4ce0?=
 =?us-ascii?Q?2fI+anJLXMNxISJro5C9H6i7vAOsTdy486T3SfXK1a2W7p8EKCXTQejz6q0C?=
 =?us-ascii?Q?h+yswW4gkzYzJnZm/uW10J8aCJQuPn/hiF96MVtRiQAhsrXtLqKX2ugrnAiK?=
 =?us-ascii?Q?2hdIbw+fxYOQXQ44iVLcykWs33DbEzbKGO9s712xCox2NYZ+soi5YQYUJZgo?=
 =?us-ascii?Q?wvLIpNv+O0yK/xG8lp0it+Z+tbufpIZlsE5IdcJwCyxP5RM35zipPODhdc6X?=
 =?us-ascii?Q?Yx3lDvpr2UFuRsZTWW5Vuw51ZXaW2naOzQj7ioSgIkAIpkKKnv+a/ai+tyD8?=
 =?us-ascii?Q?22pM6DJYkHwwL/hMI88PDuMhE+Zi8Rr4MwN4tZImehYU4Qn/nI5c2ajkdIgH?=
 =?us-ascii?Q?qQahVx2FBvAQkA3A9mwTtGp+xqPapuWZz09WUH9R5oSgqNhdydcTvTdF33CE?=
 =?us-ascii?Q?IofLz4uHDXszPL/3F2SNUwqqGE6ynx55C3YINoZq2lFj0iNRnoFDALq8ZAx/?=
 =?us-ascii?Q?sQNtXROWTm5N/SoQv+bdaQpup0FXT28kSJLK6PzGEvmMvGAQpwmRg2f3cSkY?=
 =?us-ascii?Q?+1pcqeScL8FgEwCaa8fKpmH/lB43IayUhlOrKDAML3Tzxm6aJICEki+TS0Av?=
 =?us-ascii?Q?6ypx+x1RzcEHM65eqYYfI4A2Iie4JhH5KUXoCfHCVFmOxD6OfI7ogOEWHP6K?=
 =?us-ascii?Q?3RKKEo7SGYn7Fl4OgpuqSFLsL1upFkoa0uB0kgoTJB4pf6y2zmfI42crxtQK?=
 =?us-ascii?Q?96R/o/gMilYps4b9pWDnm1jkTedbXgTcpAqzC+RbfOdGG8PV6ZFnAzfkqwJI?=
 =?us-ascii?Q?CRMNPFnStRcaYqVyxMJ2gBx1AW2wAz994D/o3UeT2vLOqPwNnB1KxsOdMz2q?=
 =?us-ascii?Q?bLI10bdOmGp+gCXhoQFP7zoLPTGo2nP4bKs3C+GnymN24dJ19ohX6mPqRAF3?=
 =?us-ascii?Q?Y4HcNtGAiQxbPPBueA2YkrzWWNGD1B9lfETfG11lEDaMUhsAjV7XPnPE3hjc?=
 =?us-ascii?Q?zCnop15piwDJEWXvUZbzGoAaWgpeIH0wGTozB1uhvtSfgrwoCH4eiogQeMAy?=
 =?us-ascii?Q?NSHq4IdM+0Ehv7RRrylOSFU+kHeWGm7gRxl4YzWkVeVp3MTqLbTXeFfOiy7N?=
 =?us-ascii?Q?+0RjY2lCaJ7PK563zog1ZGcum4+T0Jwlh3CVb0NVvKtowiTCIVU8TPkg5Q1s?=
 =?us-ascii?Q?Gy9diMkFpXhiDivAZcP55u8tpY3txvAtkmFRIxdYtvKYI3OKDZVJ9QElbHI4?=
 =?us-ascii?Q?gA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3099c8-340e-4067-0291-08dba56ad940
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 12:57:33.4190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Xhd6hmXCiNvDTrtqUI48FobjMwBUQVx8yLNLO79cRj3DfgQhJuJqGF8rxJTy3yO+KcSq/im3sBjKLxOj9eC0iTtFAM00Wfi6J/4mXnVR8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 02:28:53PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Introduce the XSKTEST_ETH environment variable to be able to set the
> network interface that should be used for testing.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 9ec718043c1a..3e0a2302a185 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -88,14 +88,12 @@
>  
>  . xsk_prereqs.sh
>  
> -ETH=""
> -
>  while getopts "vi:dm:lt:h" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
>  		d) debug=1;;
> -		i) ETH=${OPTARG};;
> +		i) XSKTEST_ETH=${OPTARG};;
>  		m) XSKTEST_MODE=${OPTARG};;
>  		l) list=1;;
>  		t) XSKTEST_TEST=${OPTARG};;
> @@ -157,9 +155,9 @@ if [[ $help -eq 1 ]]; then
>          exit
>  fi
>  
> -if [ ! -z $ETH ]; then
> -	VETH0=${ETH}
> -	VETH1=${ETH}
> +if [ -n "$XSKTEST_ETH" ]; then

Sorry - is point of this patch is just to invert the logic and rename the
env var?

> +	VETH0=${XSKTEST_ETH}
> +	VETH1=${XSKTEST_ETH}
>  else
>  	validate_root_exec
>  	validate_veth_support ${VETH0}
> @@ -203,10 +201,10 @@ fi
>  
>  exec_xskxceiver
>  
> -if [ -z $ETH ]; then
> +if [ -z $XSKTEST_ETH ]; then
>  	cleanup_exit ${VETH0} ${VETH1}
>  else
> -	cleanup_iface ${ETH} ${MTU}
> +	cleanup_iface ${XSKTEST_ETH} ${MTU}
>  fi
>  
>  if [[ $list -eq 1 ]]; then
> @@ -216,17 +214,17 @@ fi
>  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
>  busy_poll=1
>  
> -if [ -z $ETH ]; then
> +if [ -z $XSKTEST_ETH ]; then
>  	setup_vethPairs
>  fi
>  exec_xskxceiver
>  
>  ## END TESTS
>  
> -if [ -z $ETH ]; then
> +if [ -z $XSKTEST_ETH ]; then
>  	cleanup_exit ${VETH0} ${VETH1}
>  else
> -	cleanup_iface ${ETH} ${MTU}
> +	cleanup_iface ${XSKTEST_ETH} ${MTU}
>  fi
>  
>  failures=0
> -- 
> 2.34.1
> 

