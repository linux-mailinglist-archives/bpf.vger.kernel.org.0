Return-Path: <bpf+bounces-8242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1B678417D
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 15:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9C4C1C20A65
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE201C9E8;
	Tue, 22 Aug 2023 13:03:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED4B7F;
	Tue, 22 Aug 2023 13:03:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C5FCC6;
	Tue, 22 Aug 2023 06:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692709387; x=1724245387;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bfVisHuGty7CrsDVwRFiLIBfH1x+UYA4SHJJdhO+dqA=;
  b=fiIeLLG6bvceBjL5/SOoRa5W1iRCS8h3UEHfPAUPB3/oxd1JGucu3h7d
   5tOyYh6Hun89AZK2JEhBa4krpusxjJAP18Gv6dQ8V2auBhEZ5mgEOufvc
   dPQSUIUAS68Pt/n/TleMuFc81d352M/q2zKXmuBkJrBnRks1gmZzjpi2M
   6//uqqh9FWkkhbtXuPLlR2F9pTzk/38BhCURry0cKmx8a2xK++Von5Eyz
   z9opbXowf+KK/umisf4H1Ve8cLTtKqQy7JS9tnCnzgimApIUszvLfV7I5
   DIp6lOcQKh6kQYSfIgp/Gdk50CjlldijHDCFof1/zIx5XJxKfwQuhs0Sv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="364039429"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="364039429"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 06:02:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="982862392"
X-IronPort-AV: E=Sophos;i="6.01,193,1684825200"; 
   d="scan'208";a="982862392"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP; 22 Aug 2023 06:02:54 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 22 Aug 2023 06:02:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 22 Aug 2023 06:02:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 22 Aug 2023 06:02:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Is28yHQaV9LV/w4pod5NA4oX+JHxG/BFaj09HiRSRT8H1Y4yGAaxOdqMC1S5/63PmV7hxHXpJLNgEdD0C9ddn8om/q+MQGY8P1yjtdaST9b9WjTe0GpNk2BbQCLvtXIbncdCu3AmDF39F5P6omqrON3UHouP44vmH0GgbtYa4ZD4TA0+8b6G9n1q5BZWceyI8EqCnohOsHfLeEQ5/h+VPBMD0e622HIRz52XWyo8QhxnKJyPdRd2GTxWwKS0rDBlB2YpTkGFjHdkytlmYwVav0aS5Xk2jDH28KYUmYJfVSqoPCKgnfbr8eBpDyyA9t+jPbmIOcTJ27olilY8ocY3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXnZLvv9uS0skWk5bH7BrUjncyfD44GEZIWK8ZK3+O4=;
 b=NO53hRn8EIGgdPifsysAftfcZWWCvPf+SBTr/BBan50Yhn95Ce2AwuE2HJ6eb+lut/hLGZccrrCYBpfDtY3Z6KLevYl91qyBjbFKCcwtiXUIYiEffcPwn2NbUYN+5pLNcgrtr/6AZXox90bGUZ8xF9NixkansRkvb5mx8XjuvugbeJd18y8JPd1fp1UN5JIj1FuK0seqCc3TqedySRQkH1aSqQk6pLhi3fzmrc/60WcetF8XYV2aoXMEJF3fhXbNgyNXfi8iyQemFVUwDOw+SIQqDVbaILUUg1qGfftcZo0wsY1tP7vgJgSG15l/pZ2rWYgi47u+BVPWqqLbFQJbNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SJ1PR11MB6153.namprd11.prod.outlook.com (2603:10b6:a03:488::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 13:02:51 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 13:02:51 +0000
Date: Tue, 22 Aug 2023 15:02:38 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next 10/10] selftests/xsk: display command line
 options with -h
Message-ID: <ZOSx7rZ4NcRBX/MR@boxer>
References: <20230809124343.12957-1-magnus.karlsson@gmail.com>
 <20230809124343.12957-11-magnus.karlsson@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809124343.12957-11-magnus.karlsson@gmail.com>
X-ClientProxiedBy: FR3P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::17) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SJ1PR11MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 7126fea0-babf-487e-2894-08dba310175d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPTmfviT+LiQsoQSySdPa9b4OP/gt9yKgyVlOw3M5FdvmNst0iJjGMWgIA5HY4ghS5ityuJ8zEb1l1WNmqO2so8+b/QPxk3wW+XpXCYMMhwIps7NYD2ysvcXL16X1BtM1DV+drNgQ3HXdT8j7pjl8+1WyQ+GqnyJ9eZ1rHS0u15XWjPZkwosLzK6jUzS3uwWnPDvXpaIxzk52icKEAfRw+PLkzzE0KHezIR54+YJtBbNzuxxj1sdIvjBcV/His2WJwAd8rp7eJOdejPFwg1g5JK6P+6YAPC6nYgaBHDk9dHSEpop8jWRdjYOnXRAQSN4F8KqMa3JIWdfM+LrUnpEqES+eAVb/KYU0J8BLCifLrZwvLS5MQOUtdNqtFhAZ++yl1j47UwiOEnwNdTBWzyzJCMi5FR/F8ETbrNIjcZYFAuZTTWbI+Uy5+lsK/YwpljLaDDTVbn+kTAuU70LAyBdVckpzr6Wy+P+/sOWrgiajiFyeULolhSGZedN8Z0w5zT18vZz3eg02aC22aWIH6c0Bz2CxDJ3ipGXGqWElIIykhYKqIDIo6Mo5T61SrttJCtv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(6916009)(66476007)(66556008)(316002)(9686003)(66946007)(6512007)(82960400001)(8676002)(8936002)(4326008)(33716001)(41300700001)(478600001)(6666004)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(44832011)(5660300002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZMQRdmra4V8o4/4hTlbjCBVd5oICgHHDoeoNg51OxCvHYEtn8bhVdDFY+8uD?=
 =?us-ascii?Q?861f0Dga9hoCJs1yS6cbo+F3kLhuS2HHICRxVRNA/1Xc+stw9mnSAIFyBiGN?=
 =?us-ascii?Q?wTav8EbO0o9bVJAdqyZyxPzIDx/oWulkPM0k0lJSW/DFWEproo3v56/sOA90?=
 =?us-ascii?Q?kJjS0H4HouHSW25j7XH1MVKlnlJ+d1IqUU3DivWaVBFq5qgxphFK12yOhvgi?=
 =?us-ascii?Q?MegE8BRJOdcI5/st2VW7ml5AQaObkieC/M4idDHznk5P5MxKhtLLTPH3XoVc?=
 =?us-ascii?Q?ZzLt0kBZn7T44ahNwb5WdfbG/QIrs1YtiB7YMvvxKezmIzQh2uBduxy+HC78?=
 =?us-ascii?Q?QYRrGRfSHOs+r5us4jatONxQ2BjLkUi0FAoB/Rs2I0XhcFdvE2i6+IWGvz8+?=
 =?us-ascii?Q?aenAV9Z8UJ/Rceq1jyBkgz1kGtbiB1JzkwDjK9xteZ/+vV8MsuNk1rvC5HV3?=
 =?us-ascii?Q?SBPb2OiagpWe+3Q5DC6MdfUiPCs/ub9T3yxFX82SexMSuaYtWTXLbr7LzSaR?=
 =?us-ascii?Q?U+4iiSu4je0VJuRcP2/QaSoHLSh455gWH0IzVDCqiTmVH5/Ox8Zo6KPXEoL/?=
 =?us-ascii?Q?Frf3RgLAeJ1DwS4hEMuZ5KB6VHmUiWiuSIuB1Eo/feb0TyNbfE/MAzXwOAvW?=
 =?us-ascii?Q?jHB7cHo7XHnJ8TK++2SmggUZNzTrhqQmtaGqvErL5uaxGNswWm0aSx74eiB2?=
 =?us-ascii?Q?Xw7ZOkmyfwDliCF8xTsbYIWvHuLhWGo+NAh85ExtVstBHPTjddt5sAM02Rf5?=
 =?us-ascii?Q?MFJG6Hi+LEyrnWSyp3npwQ23IDcKoEV8qAufR5EZ0UsmebZ/3m7OZAXJQieK?=
 =?us-ascii?Q?EVVn/xfkNzPKpaX97fbkyTxxfMstrOOnzK/lANhM8jYQwuuB1lI8cDfUuiIq?=
 =?us-ascii?Q?mbjsJFmpIcKjWMrsvKu5jAosm/sDjrs6Ihoeh/RVC0QYT0Fqe7RLQk5InJSc?=
 =?us-ascii?Q?rFo/DPxO32NZMtOqJrhZK+R7dI8kgmZJqG5tQseXg4TwUG8BOv95vJMOf14t?=
 =?us-ascii?Q?PRaE0zNqAVie8RvPnZTWJ0ZE2WKetJXlzqbkba4pXnjcdBhDo+ty/Ukfgb+W?=
 =?us-ascii?Q?FEL1RcvZ0jEm4WlI6PUAMRz9T9cmeDIH1MlPQZK1Y3xU3mehMGt0W2QKfNXu?=
 =?us-ascii?Q?cPJR59OIqi5JJNGECSPqrZNvjmKcNKIb2AaeTlyxjiNeEUVTDQAaQQjjwinQ?=
 =?us-ascii?Q?RdMSwL/8UFwQHiX+DX7zsUlW+anuO9hlmtVoUD4caLSyMCAClhjwZs906ww3?=
 =?us-ascii?Q?K3BIQHqt/qM1dH9EQ8IPb51poUabzoOrJiYPIcmC+DWcuyKWnF9OdCMnKtJ4?=
 =?us-ascii?Q?y2qhgA5r5EcozOkWx2yfD1D7I0AyPrTqVMj9vwBjmOxRaL/Hp+EhKVm7pK38?=
 =?us-ascii?Q?EAIDtWp2AOkSU5lOepHusFv2pIwQSV6pQwdQ2WhsASys5+iZZrCrf223lxvp?=
 =?us-ascii?Q?Ps38cb6M+/Z6PsZ6yGDhd+0VFfloSSmIKNlMaOOTmyTCSe+uhGpbwJKN/Uql?=
 =?us-ascii?Q?vKISaqNKwAF7belCSHOjQP6lLRC2kcFcwm672BLEiNro3Y6iuytvClanUYck?=
 =?us-ascii?Q?8As/Yk4r+IhObNAnJojpCNysV0FXYG1kM9mVoPMbmU4QBRk5Z347dqHRj2CI?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7126fea0-babf-487e-2894-08dba310175d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:02:51.1923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J6M1z5Q38KBs0ZiUEkErVHvdP656Lq/JdmX4gcxCxHp1QnoPq8AEgVj2GBgbI/7EQjVTHoFZ9sNpGF/M4OpCZkaMoVpGca3Ss/yR2rKj4U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6153
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 02:43:43PM +0200, Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Add the -h option to display all available command line options
> available for test_xsk.sh and xskxceiver.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  tools/testing/selftests/bpf/test_xsk.sh | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> index 94b4b86d5239..baaeb016d699 100755
> --- a/tools/testing/selftests/bpf/test_xsk.sh
> +++ b/tools/testing/selftests/bpf/test_xsk.sh
> @@ -79,12 +79,15 @@
>  #
>  # Run a specific test from the test suite
>  #   sudo ./test_xsk.sh -t TEST_NAME
> +#
> +# Display the available command line options
> +#   sudo ./test_xsk.sh -h
>  
>  . xsk_prereqs.sh
>  
>  ETH=""
>  
> -while getopts "vi:dm:lt:" flag
> +while getopts "vi:dm:lt:h" flag
>  do
>  	case "${flag}" in
>  		v) verbose=1;;
> @@ -93,6 +96,7 @@ do
>  		m) MODE=${OPTARG};;
>  		l) list=1;;
>  		t) TEST=${OPTARG};;
> +		h) help=1;;
>  	esac
>  done
>  
> @@ -140,6 +144,11 @@ setup_vethPairs() {
>  	ip link set ${VETH0} up
>  }
>  
> +if [[ $help -eq 1 ]]; then
> +	./${XSKOBJ}
> +        exit
> +fi

is there anything that stops from having the list of test output before
all of the validation below (check that we are root, veth support etc) ?

I would like us to have a case 'h' within parse_command_line() though.

> +
>  if [ ! -z $ETH ]; then
>  	VETH0=${ETH}
>  	VETH1=${ETH}
> -- 
> 2.34.1
> 

