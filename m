Return-Path: <bpf+bounces-8578-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0E788851
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB034281855
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D945DDA0;
	Fri, 25 Aug 2023 13:20:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7276CA79;
	Fri, 25 Aug 2023 13:20:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE41FFA;
	Fri, 25 Aug 2023 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692969603; x=1724505603;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5zZvYKLoEWkQ+u3VVCzWavEaSCkHq7eMCIUKyFoN2aw=;
  b=kP8oKZfS4ud2Wx2jTkbPzNMN6DZZ1nnJDlVaUQTSni4bTJus5juY3cxu
   MxZB26PQgLEELl4PhjyKs2N4ebyNbZN6uqYmghitILibOk0jGMfpDedBG
   1mTW9oWx5aIlB0IFeRE1Tv3MZvYgaY/g8N0O2g+qvEqvUDvXYWd+ImjcW
   j3X9KxQUYO32nsMfcVUmQvUDKV+97OCb1Jg7OQqbOO8cJ5HU9Fj0yDmmm
   rFFhOWKP4a77z6B+MHyTMQlgnqszWV17b86vE5Z+9UdjGwmkRU4oHjzTS
   wlWKwfbJC5evR7ZeN075j0sNULotb5KabIWJ/fw5+ZQh4lRxqQj/QX8Xv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="378495601"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378495601"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:20:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="731065471"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="731065471"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 25 Aug 2023 06:20:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 06:19:59 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 06:19:59 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 06:19:59 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 06:19:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZWRVre6THeRlp0MYpgy5sqGyBgNmcuzMmQFPMWRN7Z8SHcCNYuAMUlH4IJo2HNumAbHmgmpredB79qAGRWBSTJ37PMrNMvLeE4Y9Ncb0PwFbHKxrcB9yKm/WmzwPzfJPA+490fkpTxNvwduLIcTNEqkmYLLmPmV0mKsyWp+d03Q5Euo0xVFdZQ6k1sJbSmk+IkR9g0CG+JpXljCmF8A497JB0QzD/XncWql612QQNbSBv/zrDB+8S9+tO+mlNpshhCd6LbCF0X84ihIaKPldmRkHGIJZJ1IZ+JpJ43MX45rZUQ7TQy+AyYNEkyblfaqolmcuYlJQOOOWJucVVIGkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0brkMm4dlxqEIYazKyV1dslPASLomXKa4fe1nJzVp4=;
 b=XopkV4S+p6vga6qWdBz5Q0Wt4cI2xe1d9lmJx/9OmVcmyBotdlSLf7q1B2WC6TNrbZfbZRPP0yCHPjuOgnp3UMzRIfW37gsqOPoMlBXLa2CgOSKt8sASt0m+ZcdeM1LH4VZz7J5gR1Acz2zJNudVpI84bOpqCQyAYTfZV4g3Yl7ODg2YyEiQRzsMzz/u2/pSnPAeUAUznEK6zU2R/lL9CVJli3FKQYO9iQrvtZOKWQ8AQ9sTFp0voVPx3dzY+LkhLcZQrAYGBFbM6cZmXT1EXX5QFk6teWmUxi7oySTEYgBS+0z5S5hOrkeik4lbMgaW+gAcVqZk6F5lfBKyWUOoag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH7PR11MB7986.namprd11.prod.outlook.com (2603:10b6:510:241::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 13:19:56 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 13:19:56 +0000
Date: Fri, 25 Aug 2023 15:19:27 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 11/11] selftests/xsk: introduce XSKTEST_ETH
 environment variable
Message-ID: <ZOiqX6jMIcHwAwgR@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-12-magnus.karlsson@gmail.com>
 <ZOilNr8AgqZKCUeF@boxer>
 <CAJ8uoz2pdVG0K62pQXnm6hgJxnp64eaQmQwNUEzSXX8DpPbSJQ@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz2pdVG0K62pQXnm6hgJxnp64eaQmQwNUEzSXX8DpPbSJQ@mail.gmail.com>
X-ClientProxiedBy: DB7PR03CA0091.eurprd03.prod.outlook.com
 (2603:10a6:10:72::32) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH7PR11MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 20c0ad60-c566-4371-793e-08dba56df9df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oeyVrgLLQktM5lN09fPFvnidZBGJFyD7ySXTzSo4wTuGtIR0Km11+Q11VY5t8aWHkctEwFO8WK/Wp0Goo4h+gVPHjNx5PKcyrj0IwiK4rAIztBvl9yXnhOMP4VPvSTX/RY2scSXDgnuzVlivG1t+cgjQ6ukcGHwi0DzcTX6uagDoggFmbhnwmbp4gP5Nt9owEt7oAA0+CiZdpoGcuAHqAOzrceGXKH+W4HVrrMdI7bsaPN13kt69NbKsv53ufWp9hJ5HyykH4ywVrmI3sSBiNyrnmILYDPWif7PVHNwKrGmuSFJIaD/ZpZugeBCQ1hdtBN1JeZP1dZLkzFfLgUJUdHKGCEjP9dAmouxfOaR9lqPA+QqI9J/OtmeAcd5eCerM82OM5z4GZa3PN7JPJQIIa85Iu3abFaNEEWGgy5wFiU+zVwPsP9SLRjGbDgKHCakse+JWZXmyD8/KJH515BKwQfCRh4yEGlurCyERl3BHf7EHAyQ9Pfeh6AeCvCYKCbDa/bRTMMXrGTzClj5PrTxw4kpHwOdLhvnWSFNw4z5BfDrVCAsap95haiXmkW3ID2St
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199024)(1800799009)(186009)(86362001)(33716001)(38100700002)(82960400001)(478600001)(6666004)(6486002)(5660300002)(2906002)(4326008)(316002)(6916009)(8676002)(44832011)(8936002)(6512007)(9686003)(83380400001)(26005)(7416002)(66946007)(66476007)(66556008)(41300700001)(6506007)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wz3lNS6q3a3kyVS13IMxOaulzjf4NFe9mgYW8veSbVyhOo60RlDr6tfHmPKi?=
 =?us-ascii?Q?RjbCWlysmCSLjtzXwqp//4dmgMhsu1Lepi9cNo9kT4FA7wKMkF2sTdNSCKOf?=
 =?us-ascii?Q?NlXSI64yBxySkiwMjZYlIy3qUjWlsbqlPEoyCoypNXltIzEST/aE7Qp7vpjL?=
 =?us-ascii?Q?DkLElA6Wf398xDUCFP7umoMpPWiK3i9jVYVDAq0Ipy9aL1nwqX9fUfAspmJp?=
 =?us-ascii?Q?q5OtKyXJokcIbYdcmFRs2U6d3S3QGgHBOBpEIHbSA6qc3quTueOupbD83wZu?=
 =?us-ascii?Q?WyENIwLOg11l5XYZ4aPLYmHcbTfDm9V4vhWrWQGS/yQ8fG9KR272gkL+0oHK?=
 =?us-ascii?Q?OYLJo0Foaj4kPisSVmREkaVPCYuKzucRjY+MA+gDJPck2/5PcgGF0xF/X/k9?=
 =?us-ascii?Q?LO2TtiD6jrru6p/LTiGat+U8pzT56+5uapVOJAGHn69IxSZOlFAqMz8ZjFgx?=
 =?us-ascii?Q?9jKtPnYBQ1vZwqpEdi1Q2d+OwhzOFojCgDE7T14JPHyVO5jLQMUeaSxXBsma?=
 =?us-ascii?Q?+3nLl6vcszhSPJh8tWdc5Q+ZVthoBl0X1V3o63sY16Wkefe4mMIX1WhegPRu?=
 =?us-ascii?Q?ZNzKFzBBU5666OhDcUVHFLB8yhn6yFyj3uO74viIVMX2CADl/t4ku8o1bzsG?=
 =?us-ascii?Q?U5/xtpwU3ZS4+xmolyLQzXPN0U8/DyPyYNsHNQgNfNebofT+q6zpi7i0umR+?=
 =?us-ascii?Q?HD+HKZUeRN86feHjWjiJ+vlyT+fCCMke4fI4gHgH6lDGTXg0jiMSFeiKLgU2?=
 =?us-ascii?Q?fTLon2MD8P0no7eH8sYiEI+GjluvfN54XUXUFvDRwSbe6BcWjhQc7arcesV/?=
 =?us-ascii?Q?+hEQmT/AQ2npLSRO4h/h3R48RWgZk7L5RgaEbzxObPmWbxe0k+5gr6j/Tmjy?=
 =?us-ascii?Q?VykDT0of9WSBwg91QJ8zJBgjjPS8Il0q/tHbA8odJOvPwLCIiKuZAfTd0tMR?=
 =?us-ascii?Q?FrPV/wTcnS7DpYVvNh/8xk/DuyBh+k1BBfE3A4wLKXaW6eQmlb7gMellyIvE?=
 =?us-ascii?Q?1jFuaoQpySpgShgfgTPIGPFmYEJHOVFkNwSMPx2sRUH6BNV2TsNQsouiUTWL?=
 =?us-ascii?Q?+0KRP13oKTTEFnqc6P1gdrgq5n+NQSwfbuEL0SycHLgv5HsHdIzb5dFoYNkP?=
 =?us-ascii?Q?x+heplRVnfuypAq7bfRpzxhw3V8S5YGeB1UETZr5lgEcvjk4T0sBwfgQBjRS?=
 =?us-ascii?Q?VPaNHsVUdntJv1lx+95EIpuCEPLXHWA4MubFZ0d45Hgo4eZkqCkJL6Hp8peo?=
 =?us-ascii?Q?z1rufPHLsuGh2QNOTtmmgcteQqGoe/BF/siKa9mD7x84IVdU6Sm4bN4m/PrC?=
 =?us-ascii?Q?WfEjjaD8UDn0haeQsxD/cYGZdkNlq9VSu0xxR8z/imm5+F32FdGicN3OmT0C?=
 =?us-ascii?Q?y8Zg1UybF4tYHWg8td1WH0M1sA07dGu/SobIlqyaZ3ivq+w5Oxstw5MVXTcb?=
 =?us-ascii?Q?X/IrTb0ZeBwkdVR2B7olHVMdUOXHcOJ6Q4pOTOMZqPJN68dcplNQsLpdhKP7?=
 =?us-ascii?Q?QVAfaWJkBCbs74Mh/apansslX61vjT3th2/9zlfQMG85m2CzGVSAnTq55COd?=
 =?us-ascii?Q?oKf6sExvL8WVXX3RlheqehMd9lHNpnwf0JDAFp2Z6PzXu/GvcfviCOxyssHf?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c0ad60-c566-4371-793e-08dba56df9df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:19:56.7137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wi4NcD68glZ2yNAuWNkieY4qYDYb7qk9lLi2B7fTbnh5Xp2Bz9mrQAvnuSKnEtdgsZ0lBu2e9B7rTuI0Os+1fVraB6xntc0sSsQ/7EMAVDc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7986
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 03:03:58PM +0200, Magnus Karlsson wrote:
> On Fri, 25 Aug 2023 at 14:57, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 02:28:53PM +0200, Magnus Karlsson wrote:
> > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > >
> > > Introduce the XSKTEST_ETH environment variable to be able to set the
> > > network interface that should be used for testing.
> > >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_xsk.sh | 20 +++++++++-----------
> > >  1 file changed, 9 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > > index 9ec718043c1a..3e0a2302a185 100755
> > > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > > @@ -88,14 +88,12 @@
> > >
> > >  . xsk_prereqs.sh
> > >
> > > -ETH=""
> > > -
> > >  while getopts "vi:dm:lt:h" flag
> > >  do
> > >       case "${flag}" in
> > >               v) verbose=1;;
> > >               d) debug=1;;
> > > -             i) ETH=${OPTARG};;
> > > +             i) XSKTEST_ETH=${OPTARG};;
> > >               m) XSKTEST_MODE=${OPTARG};;
> > >               l) list=1;;
> > >               t) XSKTEST_TEST=${OPTARG};;
> > > @@ -157,9 +155,9 @@ if [[ $help -eq 1 ]]; then
> > >          exit
> > >  fi
> > >
> > > -if [ ! -z $ETH ]; then
> > > -     VETH0=${ETH}
> > > -     VETH1=${ETH}
> > > +if [ -n "$XSKTEST_ETH" ]; then
> >
> > Sorry - is point of this patch is just to invert the logic and rename the
> > env var?
> 
> The purpose was to make it setable from the outside and give it a name
> that is more descriptive and targeted only to xskxceiver.

and this is accomplished by not having ETH initialized here? What will be
'the outside' ?

Currently I don't see much value within this patch, unless you explain the
need for setting this from outside of this script. Maybe I missed some
discussion from v1. I can live with this variable being ETH, what's more
concerning/confusing to me is that for ZC we have to set VETH0 and VETH1
to ETH and then use that later on.


> 
> > > +     VETH0=${XSKTEST_ETH}
> > > +     VETH1=${XSKTEST_ETH}
> > >  else
> > >       validate_root_exec
> > >       validate_veth_support ${VETH0}
> > > @@ -203,10 +201,10 @@ fi
> > >
> > >  exec_xskxceiver
> > >
> > > -if [ -z $ETH ]; then
> > > +if [ -z $XSKTEST_ETH ]; then
> > >       cleanup_exit ${VETH0} ${VETH1}
> > >  else
> > > -     cleanup_iface ${ETH} ${MTU}
> > > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> > >  fi
> > >
> > >  if [[ $list -eq 1 ]]; then
> > > @@ -216,17 +214,17 @@ fi
> > >  TEST_NAME="XSK_SELFTESTS_${VETH0}_BUSY_POLL"
> > >  busy_poll=1
> > >
> > > -if [ -z $ETH ]; then
> > > +if [ -z $XSKTEST_ETH ]; then
> > >       setup_vethPairs
> > >  fi
> > >  exec_xskxceiver
> > >
> > >  ## END TESTS
> > >
> > > -if [ -z $ETH ]; then
> > > +if [ -z $XSKTEST_ETH ]; then
> > >       cleanup_exit ${VETH0} ${VETH1}
> > >  else
> > > -     cleanup_iface ${ETH} ${MTU}
> > > +     cleanup_iface ${XSKTEST_ETH} ${MTU}
> > >  fi
> > >
> > >  failures=0
> > > --
> > > 2.34.1
> > >

