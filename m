Return-Path: <bpf+bounces-8577-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80CA0788813
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3D381C20FB0
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037FD532;
	Fri, 25 Aug 2023 13:07:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD5AD5C;
	Fri, 25 Aug 2023 13:07:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205F1BF0;
	Fri, 25 Aug 2023 06:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692968836; x=1724504836;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kl5Z3p9u0TfurUNMXDDE4ORgnIuotm0NPI3HB2rvc/g=;
  b=OtsvNlN3ICJB6vYIjvnZ8XaKAtTxxssZmL9cVHnv9+h28udetqm6QO1m
   H5ZRAkFX6O2XXscTFcCIVqfTgWVjlub23/g3pejzull/7BWFiq1daB+ot
   33UXdLixQxmXV7RZQo6tUBnWzb0MUva+5wDrZv9K+F2hz2pqxZGJPmrKl
   ZQQIZTRpDMCUl6DHA7naZtP/1qHMuTf5RoPwdefrRimgohcKBPkjAd9zs
   wGLCg/X3bGs9cyclQ34sa+i6sjVMKzoK3YuI4mNEEy+tDeDzGH66QHgjT
   YxrZCgdxU8MNTm9UcbWFpsKLaQHlzysnpgobHvRALVhLSXrYkkDzxJ4WC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="461070486"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="461070486"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:06:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="827593918"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="827593918"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 25 Aug 2023 06:06:46 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 06:06:46 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 06:06:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 06:06:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/KIcJjff1A2QzN3v0EqovTBL4rMsLkUAW40+Iw9+5f79HZLrSTbHegOQjGx8fqYsbqVOenIGUEMr9f5fnNU/swn+xlBdvKHixUg35KYIvGgzfD/M0Uxm1IICs6M6+u8yA/JhBUa2PbLLHs4zlWXfP6u18AyxoVjEeNELb59vq04XE4HLpDTn8dZb9JUtvMWyfVMmBh46uuM2mj4yo6KInuJU9EFrtLD7J5dT/9+fYF8wSBSfvCz18+lN/aqVKyYDW+0Ken3c35+1TUJi+yRR81gcTE40oJBcsNFKhBZRMFiwaDtMb8LErVo5DNX0sOgM/wm2t24PdC3d/U0xXKT3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVP12XTwemqPCbFgLnrKFfe/ch7tptt1QD6mAPzp/vc=;
 b=EQ/9PahU58DIMYEq9JsrRuc25TACUBBWaVd6juCooGRxLKOjbDgmWPDaj4bdyNjV3ZHF1OqQm7RF/IS3eFpbyQvbWagdHxHZaf/xH9OG9n1mzRLqgMXqMaonYxto966/dvP2mUFEHaMmseBnP9wvQZ6Jtt1+j5zar7ea+7W5sPPux4iJIwJ4iTZlWzImVea6mTELOfMlU40nM8dYxFKMyW0LFM5uRn+EEB/0b6Tabwr3xwnXSPYk6mz7Egh8TNFpNe6o0ppcHrR1apqzmkGrntKn4LFL3EAPKWsi28zoBBiw6a3HaRbdtNcdM1ahhzrDXTGIT8nQSrCgrBxsY8+z6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 BN9PR11MB5419.namprd11.prod.outlook.com (2603:10b6:408:100::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.29; Fri, 25 Aug 2023 13:06:43 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 13:06:42 +0000
Date: Fri, 25 Aug 2023 15:06:35 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Magnus Karlsson <magnus.karlsson@gmail.com>
CC: <magnus.karlsson@intel.com>, <bjorn@kernel.org>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
	<yhs@fb.com>, <andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH bpf-next v2 10/11] selftests/xsk: display command line
 options with -h
Message-ID: <ZOinW9sc0QpO+1I3@boxer>
References: <20230824122853.3494-1-magnus.karlsson@gmail.com>
 <20230824122853.3494-11-magnus.karlsson@gmail.com>
 <ZOijXlBwnLxxyfFt@boxer>
 <CAJ8uoz1tukkS6MACytUyZtNo9WOzbUR_EBXiZBcc7zhXWefccg@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJ8uoz1tukkS6MACytUyZtNo9WOzbUR_EBXiZBcc7zhXWefccg@mail.gmail.com>
X-ClientProxiedBy: DU6P191CA0067.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:53e::9) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|BN9PR11MB5419:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ea2e04-9c9a-4ee9-6cba-08dba56c206b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: znAyMRcIUn4L3YLFOblE8prG/JrxFG2OCjhqzy/CTxzSLeu/hi2Q4lRTGUxMsubl1xoKftOAT8ErDch83Ifpdl6eac/fhKkYjdUhARPmoU11paGP7vDX968rXh9fVZ9cAm5z08myH94cpmGm5FkHfvBmtmI05WVAncchehVHbSNx7dbUglOz1XgF5shk078QH6IzagfxTM+T+p48zTqAIj00EAkGqud6ECLvooUGiZWg4C/np8MVswFr/lpmgoUdWImc99Vp0i0wVGGOnnsLKyUjcRLuva/XgwZLSz4+YrU64LfzcjKWuH96pQan1XBEFcIZ+k/2h9kXPFFXH2UOWdmvy2HX93q1KimIYffNKPCHjlZGGmNNt8ciru9/rWL90bJ8hqpzjE5azIruyynCizrcXQbo8HS4tmxcnm02xdd3EUUr6gh09LkRQ3hw6XpwxQrzDqG7jDK6ZahPKuNfw2TlX8Ze2ww21IaxMIIF4RaVB9tCRKtUViG27CQ1SEtQUPaNeQah5MKz32UPNENsUdfemmX3SBp1uYsECcXAhnnTyNRiGCw3YkNOCv1jVZWLA6w887391GPSJdqZGehZ6AcJrwPB7XAlSYWoSghpLFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199024)(1800799009)(186009)(82960400001)(38100700002)(8676002)(4326008)(8936002)(33716001)(41300700001)(6506007)(6486002)(316002)(6666004)(66946007)(6916009)(66476007)(66556008)(86362001)(6512007)(9686003)(26005)(478600001)(44832011)(83380400001)(7416002)(2906002)(107886003)(5660300002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xqUM1ylvT7xniuTDiBDXf4F+2oXiW+7zqE91R3cG3K2NT5PLVC3TvgHCja44?=
 =?us-ascii?Q?HqUoQVa6Zllyqj3k+FR2kjX1ZkwFnfq3FSr56YCCrHeO6SRVqqwyDWRgPCdg?=
 =?us-ascii?Q?w7j9G5A6luoxOUax8ZiYrrEZ3YM74IveshCI1gJ4WSstdNfqB9u2ctUC6WmS?=
 =?us-ascii?Q?0Y6kN9sp3Y1h/ceo+GwXfIqmtzIn0yE/Pr6QVpdYsytf+azu+0ymW+KoCMVJ?=
 =?us-ascii?Q?pdMvejetqVWRZ0+SyxVOKkLHG88r2fZa4IDTjRqkWLOpUHHfWp+dNRTko/Ae?=
 =?us-ascii?Q?dbZYTVEbEuEjEX17CsloePX9SH4AwQGzD4+lHo9vhVWitysk4XvTmBUFk7WZ?=
 =?us-ascii?Q?ahDIyWq4uWQZUzeowSJJi8gx7T3z/XYdYssY7PlUMurViTOG+YS+8aT4eiNJ?=
 =?us-ascii?Q?FcbDuDcVF5otSjlws0SUsIZA+twaKSNs78uhnrhoe8cI8jy4C9Gq+fgvLOP9?=
 =?us-ascii?Q?er5YummLMjUw3H41lllUTZtKswq2muNoF8DlYIC3Y1qRdhMwDPRgufmZq4J6?=
 =?us-ascii?Q?02LGEoCjh6TAZeJNsCt2jXCyGRyMbAfAoLJz7XvKvTd2UovxadhIOkrtQplp?=
 =?us-ascii?Q?rWFQzSxhLyhkSRjnlKvqy98O1CYVlgk+6TsRT5SO1GQoKC8+oOQz6/D+gK9C?=
 =?us-ascii?Q?WgYUmwX6ONnhQwKCPSSbsw8hJCh/J33m3xTe2QUWXgkV5biZK9zWLiWT0xQP?=
 =?us-ascii?Q?uTK6z9WeVAcr1qwsUcthPbU2BzsaHiorxllHU38WNjB1a7EDUHKL79mAIG17?=
 =?us-ascii?Q?N4hwi0u6f3IPqiL5fZH5bE8k7qMrwoqqh1WbzjGmfpcLNk9kwn2HFhlrUkVl?=
 =?us-ascii?Q?FjX2n3SePEpSd76/yVX9NQeMsRDeDARSwe26FUdbhykS3zz2HEVRlitKUsoE?=
 =?us-ascii?Q?X7Y0ikEFM8r11sGOpvVeHvXwn4ddOKKdA3IsyKNJJDz+8/8r8UJXBQBD8frd?=
 =?us-ascii?Q?ze9a3wnigfCRqQDx4n0yaAsOLhAc5gJQB+KHU8RpzZS4MWh+i/Us6gIb5QPl?=
 =?us-ascii?Q?l13OlGYADxh4BO6+glHsc6OF5Tbm3PlkZJr5MlZYtpK6Qw1RgmmXBZUScB7V?=
 =?us-ascii?Q?vR5KobPVwi133SlAD6aw82Xe/ei3TX/XWV5eGDejepYlqt4inILoCXijkqxI?=
 =?us-ascii?Q?g9at03Sc8tscw3pcrjsyCJTaoXUwzX2vyi6hesXj78JFKA5tLd2VSai6H9yT?=
 =?us-ascii?Q?pMxZP4VwYoZUyspXvnU5Ob7rE+4hs2F+4V5V5UTYQJc3k74HBKUT4atODMOw?=
 =?us-ascii?Q?gTtoDyGGcPHEaHXyDq5NQHzSwah7MvHQyMqU8aNWP4G6zFlU4Yrc2el2OoF+?=
 =?us-ascii?Q?RVtFMwp0yiEUu/XQlw73D40lt0/tDvXuKpBCqxuMChP3iowUqr98PesdXFGy?=
 =?us-ascii?Q?SAQqbIfbhkJ04PVtweXBNsL/S+EWGk9C9BbLZqzMo79JqXuBANazlh8xYZFq?=
 =?us-ascii?Q?vQYonmzws2NszklFrUjDZ+HsXvD+YziiglGKfObIjdev59NHDJV0psExML5F?=
 =?us-ascii?Q?iayRSqFtzHTAZr9Spd7PbAlFWUGnfgm/ngMIoi16tBZWq+EfFgy6qbznz3wS?=
 =?us-ascii?Q?zllekUlryaDTfpJ9nwpwlNx4fao7gOujUMkSA/0/tEDrIfo2WaUFXIKe5wU8?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ea2e04-9c9a-4ee9-6cba-08dba56c206b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:06:42.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzHbgiXBIKcmPHshtzFl/ioIoQa3BFdVWgkGWvSVg7cQiKI6s4pQ/yiLSvRK7hjDB/yvU2wjIOZP2r21HX7QNV6XmBbT8AetCWBmuQGbxW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5419
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 25, 2023 at 02:54:01PM +0200, Magnus Karlsson wrote:
> On Fri, 25 Aug 2023 at 14:50, Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Thu, Aug 24, 2023 at 02:28:52PM +0200, Magnus Karlsson wrote:
> > > From: Magnus Karlsson <magnus.karlsson@intel.com>
> > >
> > > Add the -h option to display all available command line options
> > > available for test_xsk.sh and xskxceiver.
> > >
> > > Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> > > ---
> > >  tools/testing/selftests/bpf/test_xsk.sh  | 11 ++++++++++-
> > >  tools/testing/selftests/bpf/xskxceiver.c |  5 ++++-
> > >  2 files changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/bpf/test_xsk.sh b/tools/testing/selftests/bpf/test_xsk.sh
> > > index b7186ae48497..9ec718043c1a 100755
> > > --- a/tools/testing/selftests/bpf/test_xsk.sh
> > > +++ b/tools/testing/selftests/bpf/test_xsk.sh
> > > @@ -82,12 +82,15 @@
> > >  #
> > >  # Run a specific test from the test suite
> > >  #   sudo ./test_xsk.sh -t TEST_NAME
> > > +#
> > > +# Display the available command line options
> > > +#   ./test_xsk.sh -h
> > >
> > >  . xsk_prereqs.sh
> > >
> > >  ETH=""
> > >
> > > -while getopts "vi:dm:lt:" flag
> > > +while getopts "vi:dm:lt:h" flag
> > >  do
> > >       case "${flag}" in
> > >               v) verbose=1;;
> > > @@ -96,6 +99,7 @@ do
> > >               m) XSKTEST_MODE=${OPTARG};;
> > >               l) list=1;;
> > >               t) XSKTEST_TEST=${OPTARG};;
> > > +             h) help=1;;
> > >       esac
> > >  done
> > >
> > > @@ -148,6 +152,11 @@ if [[ $list -eq 1 ]]; then
> > >          exit
> > >  fi
> > >
> > > +if [[ $help -eq 1 ]]; then
> > > +     ./${XSKOBJ}
> > > +        exit
> > > +fi
> > > +
> > >  if [ ! -z $ETH ]; then
> > >       VETH0=${ETH}
> > >       VETH1=${ETH}
> > > diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
> > > index 19db9a827c30..9feb476d647f 100644
> > > --- a/tools/testing/selftests/bpf/xskxceiver.c
> > > +++ b/tools/testing/selftests/bpf/xskxceiver.c
> > > @@ -318,6 +318,7 @@ static struct option long_options[] = {
> > >       {"mode", required_argument, 0, 'm'},
> > >       {"list", no_argument, 0, 'l'},
> > >       {"test", required_argument, 0, 't'},
> > > +     {"help", no_argument, 0, 'h'},
> > >       {0, 0, 0, 0}
> > >  };
> > >
> > > @@ -331,7 +332,8 @@ static void print_usage(char **argv)
> > >               "  -b, --busy-poll      Enable busy poll\n"
> > >               "  -m, --mode           Run only mode skb, drv, or zc\n"
> > >               "  -l, --list           List all available tests\n"
> > > -             "  -t, --test           Run a specific test. Enter number from -l option.\n";
> > > +             "  -t, --test           Run a specific test. Enter number from -l option.\n"
> > > +             "  -h, --help           Display this help and exit\n";
> > >
> > >       ksft_print_msg(str, basename(argv[0]));
> > >       ksft_exit_xfail();
> > > @@ -406,6 +408,7 @@ static void parse_command_line(struct ifobject *ifobj_tx, struct ifobject *ifobj
> > >                       if (errno)
> > >                               print_usage(argv);
> > >                       break;
> > > +             case 'h':
> >
> > do you need 'fallthrough' here?
> 
> Did not get any complaints from checkpatch, so do not know since it is
> a case without any content on its own. I would say it is obvious that
> it is "falling through" in this case :-). But I do not know what the
> rule is.

Sorry for the noise it's fine i quickly tested that with
-Wimplicit-fallthrough.

> 
> > >               default:
> > >                       print_usage(argv);
> > >               }
> > > --
> > > 2.34.1
> > >

