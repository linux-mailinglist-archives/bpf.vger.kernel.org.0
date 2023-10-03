Return-Path: <bpf+bounces-11246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6636E7B6106
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 08:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5CD931C20506
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 06:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0B5CA7B;
	Tue,  3 Oct 2023 06:51:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ACBCA65;
	Tue,  3 Oct 2023 06:51:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF11CE;
	Mon,  2 Oct 2023 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696315885; x=1727851885;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=xV8/ZXAWnLwRUjGrga8K1IffqO6Ap9IatCXxjEf7Ac4=;
  b=R57OTvghc+9sx22UOVK4boI+bd8C2+nU2iCs12V7dZHAUxhUi82cpCpC
   BWqLQS4/TLRFRf612figlmGhcd3/nSbsuO4TvcClqT6CzpL61h/SffvfV
   ULay1qRnKki0H9hQUVqq1MSXHsiD8K0Zg10q73146iz0oiM7iuaYVFp4W
   WeUR2vhU7kl5lvYu6RMaIADwNbVa6iz9AdlhmysY4CKw1kBp8uDbV6MmE
   uId3ZZIUYKrZSVa223A1YP1iz7bpLo2b2M3cLicEd2MzkCDFwWo6zFYcU
   t3czz3xLcgAUjCLcslIROvsIaV5UOAtxKsp50jpCfstQKH/Me2uWlwsGq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381688491"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="381688491"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:51:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="874616977"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="874616977"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2023 23:51:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 23:50:19 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 2 Oct 2023 23:50:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 2 Oct 2023 23:50:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 2 Oct 2023 23:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjVEGLaNu/of4zsx7YTvCmEpxlQDFbN1z12sx0Eq803e7QwrxHkGvSxx7w3Q2wWDKYBbmh8h1qhtH8ZaVfqBconXzIFcKKW27Alg4Bc80yUk7p5Epe0XjsLPUBZODSXt8yPI2NuYLiXvTEJp4cSmHCFW+mffFA42aWQ7vf/low9uxbu3hj3llk9ByXRX/uP3ZDjwIF25L7PpVzddnpSS4K4Oye+kfl/q4T+H9mR4Aj+HJZ7/ZIe0K13U9l/QT0ZErLn+f5fM3pM0w/NBNtYA5mSXjNUbv5lCguSQWL/nD1Q+B7G4BhhQnQ2VAMC7yW8ugfhClY6Ji1Ot+Fdy2qlF3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFU2PT14japsP4ryY570EP7nWnXh0ZHMu/TyWLTzJzY=;
 b=MGldof/GUoWs9diSXs/bPvZDCrlk/UezyOaxdyhXDSFJeduWDAmqGLQ/WtL3TuOZflcFz8ddVixgEOhec/juzdyGcHfGnR0r7+4KScwOLCkegb6tv4iTTFzlifHMD1Nue4b/FbZ365eF12q3bFriX83PS6AIMUHs47Gl7DdPHqclpMaMGByLfE4pBAwY0SUierblnmSPnTfD+CFZKRgFJz+lmV+c0/rwpeUDRO9DYcJ/ygqZphA1W3VkHMcGrinWUVdm8qi6NxptibQCy2kOX62T81UXMEMM2ULu+P2ergAJW4mexuAWmUZ/p3f61dCLed83t7HL0x6cvtf0dtLqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH7PR11MB7073.namprd11.prod.outlook.com (2603:10b6:510:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Tue, 3 Oct
 2023 06:50:16 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::f8f4:bed2:b2f8:cb6b%3]) with mapi id 15.20.6813.027; Tue, 3 Oct 2023
 06:50:16 +0000
Date: Tue, 3 Oct 2023 08:44:08 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: add options and ZC mode to
 xdp_hw_metadata
Message-ID: <ZRu4OJMAOApPsoVx@lincoln>
References: <20231002162653.297318-1-larysa.zaremba@intel.com>
 <CAKH8qBtGBOw7j01s-ZO4tZmU9kQf-jQi1xUP9UmZ0ebN+W0whw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBtGBOw7j01s-ZO4tZmU9kQf-jQi1xUP9UmZ0ebN+W0whw@mail.gmail.com>
X-ClientProxiedBy: BE1P281CA0316.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::19) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH7PR11MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f76b1c2-819c-4f7f-bb55-08dbc3dcffca
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQtOTlgOuTFb72MkMPZdO4DV+Unw6xu+Y61+dwKaAcp72cmzrt+orAmNRQC7/KgOtBVUnBxhfkC+9DtRJ9KgNblD7aEEkr7re4HyyN9oSgVk7NfzK2KluOcL5ephvFn9MS5ABB1jZVfqc2URD/LD62JWERLkYpU2VpEtiGxqlCgJIC67zF7F7UpyqHxJZtEOS487Dq5rQk8ZINmwv+Q+HMHuSGsoLfvIvd2qo07oMTAIPAXu/DlrjV4TKJ4jjEDJp4VINRdWUs1iIX/fZFJZUdE7SkFr20XIo5aXnYi5n2J59+0RGhyb8JgHanr82UskUTDmIAei3lQ8aqeE82M35sKGj/cWdIwSgBjhLSRnM0mRnWwizVRetjb8d341mJm9ohflDcyihJ70QUPg3TmBNmtmiH0niRKh3IEt6hfzYirb+TriJaiapf+JuIblDzTQHEBcptuN5i7P85VmLlhS+/Mv28xt1c5NH/Y+qjOSxGaV9mPHLgPPnen7qC6lir+C4bn6w8XLSb8ndWQJO8u/+xlN1p6Sv7FBvX9+5d5Rz/aTFy9Q7xrqjrM65fB3tM3DeBgHF3D6T1/aAYFEi4x0Ww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(6666004)(53546011)(6486002)(6506007)(478600001)(966005)(83380400001)(6512007)(9686003)(26005)(7416002)(2906002)(33716001)(316002)(41300700001)(6916009)(54906003)(66476007)(66556008)(66946007)(44832011)(5660300002)(8676002)(8936002)(4326008)(38100700002)(86362001)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJCYmszQVRPUG9BS0lkajR2d1FFWE1ZaDRUdnVlVTZMdmtCQ2VmN2dIbG9y?=
 =?utf-8?B?UkU5QmhNSTZGU2d0MEFMUnBJNytRM21CTGVyZVVMc1kxWGdIaHlmeVFEeEEx?=
 =?utf-8?B?TDJXT2FGZWF3em5vK09MaDEyTDJleTdaQ3dOWDhzT2ljckhPT0lBY09sZVpM?=
 =?utf-8?B?dHQxaWdDVXFNK0haNU0wUjh4aFdUMGxNNkVXOE8reTRRczVFck9hNXBKSHJ3?=
 =?utf-8?B?R1lBT3NreElLNVZCLy9mR3FtTkVyUVJLQUJoVk1ydEpHMzJrUmdIYUhvSWhj?=
 =?utf-8?B?RDg4TCtYK3U5Ym1wbHlxNEFHVEpNMk1aKzNRdWpGMjRwTFp3L0JmaXpWU1Jw?=
 =?utf-8?B?d3lXQWpDVjl4eCtERk5qNStTZVlQL3hmd0lMck5IcmNSSkxMbm9IQXEvRUFw?=
 =?utf-8?B?NDE2eEdQcHZuVnhuK0xPTWw3eEJzUUVzTStySzV2dE0zT05DK3VvclVnMzFj?=
 =?utf-8?B?YWo3cTk5d2pHWFlRQlg1SjBzYWR6UUJZMm1OdHRUSkM0VWllVjFCNUU5aVE0?=
 =?utf-8?B?ZUlsLzhlTWFONFZ1NXVxMzRqc2huQ3BVSzZpL2ZzY2l6dnh3UjJuMEJaWjZO?=
 =?utf-8?B?cmFBQW9ISTJMQVJxa0hhZW5NQm83d0lEVDR1bFRVN0E3RDdOSkRMR0U5K1pI?=
 =?utf-8?B?Znltd0laRlV3MXd1U1ZqN1Y3L01vb2N4VE5jR3AyVHJFN2JGcWJ6T1FreGd5?=
 =?utf-8?B?RlBmdXR6LzlVVERVdmVUZlI4L1RZNUVWMVRUNU5hemIwd2V6MXVqMUZWQlFV?=
 =?utf-8?B?T0dKcWlwQU4wTE1QT3BFTndTQUVpK1pITWFRK1ZEcmRoL21vRkpBMnhxSXR3?=
 =?utf-8?B?VWs3d3hOUk1PRi91VmQ3ZVU1RVFNaS8vZGMvbXJnMDNtS0grWFhodXlFb3dP?=
 =?utf-8?B?K01pVGhjZm12UWN6WGdjS0Zha240ZVFRUmlDQmJDMEJKdWxYTUVQYUN5dkp1?=
 =?utf-8?B?UStTdFh1Rmt0dWtncjFwaVNnc0JtSHVaaHNxcWx6eVV4R2pKOHdvV1VWRDFa?=
 =?utf-8?B?Q0RpOTZrSEJSODhHa2tKKzhhYUYvcCt6cTViNjFLcW5DdWlYSGk0T2djTzgy?=
 =?utf-8?B?bno1eDRIS1ZQeWdLQll4c1o4N3FuNElNRFlXVEVEQUhpY2llWkNHV2NxaDdG?=
 =?utf-8?B?ZnpLRENPaGRTR1BWcnM5VUJVRGRaWHZIS3hreE9QNzIzaFFoWmE0ZEZlRHhl?=
 =?utf-8?B?Mlp2NU1KWG9CMmZ3VEJnUTAxcEdIZU1sZEFTQUpqRmZiRWc5WENaVjJtUTBk?=
 =?utf-8?B?UEFYUU94eG9pcWFibWo0RXVyRmtOdkNSNU1sd3FNV29zamNKZk45aVdKV0dv?=
 =?utf-8?B?QVRsY0FjeDh2akRoKzlGcUpXemM1VGtJQzVQcEY0c2pzN0w1b2o5NVg1a1Ar?=
 =?utf-8?B?dlQ0QWhSVWFNaWNQQTFRR2tHRFlrYlZBeStadDZLL2cyaHdJVHNFb09JMGJh?=
 =?utf-8?B?YUp2U3drWmR0UzNkeUNuS3RoY3JVWFgxU1pzYnd2VlZGbWpHbXpLN3R6QTM2?=
 =?utf-8?B?SC95R1VWMGV1bGo1eko0TnY5Z0ZSVGRlNWNpS25MUXRyaEZOcEw3UEdVMFZP?=
 =?utf-8?B?YUhUOFVTR01vajFLMHI2MEJZUy9uajR6T291NGpwKzlYalZUeU5Oc2xYdjg1?=
 =?utf-8?B?OENiYTUxS0dHZWplNW5FQkY0WGxXU0RXNlBWclBuRnh3WlI3VFJoRWEySnpL?=
 =?utf-8?B?eFJuZHZrZmI2QnkzeUpkSVM3Z1NGekRSZXZFMDZnaktOSkJGbElZeFozOHJx?=
 =?utf-8?B?YWFXcDBZWW4wdTdCekI4bHRzQjNYUkFBMEM5VUlyMHpsbkpNSXpiem4zM1BG?=
 =?utf-8?B?RFNxbXFpbnkwV0lxL3Q0UEFVYU8rM0FLK3lrMHMxNi9CY1V0bXVDWTNDUlB4?=
 =?utf-8?B?WVc0YmpwdFdaQTVlNVV4Qm8zWm1SbjlsRFpIcEwwbWJ3OFM0SnhPUC95NVRa?=
 =?utf-8?B?T1RPdnRnLzlzQmoxalNscWZPcXliRTNCa05IM1JYY1FYdGQxb3RjakdJTU5v?=
 =?utf-8?B?S3lBUnN6ZGVGd0RqNkIrZDZTbXV2TWNuQmZIUmZnVk5jdmJ2VjF2V3R5cDlU?=
 =?utf-8?B?OHYyYU1CREM4bFl6TWwyZEpwNyt0Y1pMTXNXeVBIc1Z5KzF5NytiSGZmZFc4?=
 =?utf-8?B?Kzl5Y2QxUldoNkZlTUZOKzVyMzFDekFKdXBobEZmUEpqQjhzb1l0ZXhJclNt?=
 =?utf-8?B?QVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f76b1c2-819c-4f7f-bb55-08dbc3dcffca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 06:50:15.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8levCavxmSD7lYfdEyd8Wch4+Pcknw4mb9jbm0uXUqOP1baa//px/fhy6TfOyhElqKJ5ISKs1M7fzpTZa30PScW9EzEM6kiIaHNOtpXHgNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7073
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 02, 2023 at 09:46:08AM -0700, Stanislav Fomichev wrote:
> On Mon, Oct 2, 2023 at 9:35 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> >
> > By default, xdp_hw_metadata runs in AF_XDP copy mode. However, hints are
> > also supposed to be supported in ZC mode, which is usually implemented
> > separately in driver, and so needs to be tested too.
> >
> > Add an option to run xdp_hw_metadata in ZC mode.
> >
> > As for now, xdp_hw_metadata accepts no options, so add simple option
> > parsing logic and a help message.
> >
> > For quick reference, also add an ingress packet generation command to the
> > help message. The command comes from [0].
> >
> > [0] https://lore.kernel.org/all/20230119221536.3349901-18-sdf@google.com/
> 
> I did similar changes in my pending [0], but I made the zerocopy, not
> the copy mode, the default.
> If you want to get this in faster (my series will probably need
> another iteration), let's maybe do the same here?
> ZC as a default feels better.
> 
> 0: https://lore.kernel.org/bpf/20230914210452.2588884-9-sdf@google.com/

I do not need those changes in tree ASAP, that is just something I had locally 
for some time and decided to send. So I think I can wait for your series. This 
way it is less work for both of us.

> 
> 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >  tools/testing/selftests/bpf/xdp_hw_metadata.c | 59 ++++++++++++++++---
> >  1 file changed, 52 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 613321eb84c1..c1d1b161a964 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/sockios.h>
> >  #include <sys/mman.h>
> >  #include <net/if.h>
> > +#include <ctype.h>
> >  #include <poll.h>
> >  #include <time.h>
> >
> > @@ -49,6 +50,7 @@ struct xsk {
> >  struct xdp_hw_metadata *bpf_obj;
> >  struct xsk *rx_xsk;
> >  const char *ifname;
> > +bool zero_copy;
> >  int ifindex;
> >  int rxq;
> >
> > @@ -60,7 +62,7 @@ static int open_xsk(int ifindex, struct xsk *xsk, __u32 queue_id)
> >         const struct xsk_socket_config socket_config = {
> >                 .rx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> >                 .tx_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > -               .bind_flags = XDP_COPY,
> > +               .bind_flags = zero_copy ? XDP_ZEROCOPY : XDP_COPY,
> >         };
> >         const struct xsk_umem_config umem_config = {
> >                 .fill_size = XSK_RING_PROD__DEFAULT_NUM_DESCS,
> > @@ -404,6 +406,54 @@ static void timestamping_enable(int fd, int val)
> >                 error(1, errno, "setsockopt(SO_TIMESTAMPING)");
> >  }
> >
> > +static void print_usage(void)
> > +{
> > +       const char *usage =
> > +               "  Usage: xdp_hw_metadata [OPTIONS] [IFNAME]\n"
> 
> Maybe [OPTIONS] <IFNAME> to mark ifname as required?
> 
> > +               "  Options:\n"
> > +               "  -z            Run AF_XDP in ZC mode (copy mode is used by default)\n"
> > +               "  -h            Display this help and exit\n\n"
> > +               "  Generate test packets on other machine with:\n"
> > +               "    echo -n xdp | nc -u -q1 <dst_ip> 9091\n";
> > +
> > +       printf("%s", usage);
> > +}
> > +
> > +static void read_args(int argc, char *argv[])
> > +{
> > +       char opt;
> > +
> > +       while ((opt = getopt(argc, argv, "zh")) != -1) {
> > +               switch (opt) {
> > +               case 'z':
> > +                       zero_copy = true;
> > +                       break;
> > +               case 'h':
> > +                       print_usage();
> > +                       exit(0);
> > +               case '?':
> > +                       if (isprint(optopt))
> > +                               fprintf(stderr, "Unknown option: -%c\n", optopt);
> > +                       fallthrough;
> > +               default:
> > +                       print_usage();
> > +                       error(-1, opterr, "Command line options error");
> > +               }
> > +       }
> > +
> > +       if (optind >= argc) {
> > +               fprintf(stderr, "No device name provided\n");
> > +               print_usage();
> > +               exit(-1);
> > +       }
> > +
> > +       ifname = argv[optind];
> > +       ifindex = if_nametoindex(ifname);
> > +
> > +       if (!ifname)
> > +               error(-1, errno, "Invalid interface name");
> > +}
> > +
> >  int main(int argc, char *argv[])
> >  {
> >         clockid_t clock_id = CLOCK_TAI;
> > @@ -413,13 +463,8 @@ int main(int argc, char *argv[])
> >
> >         struct bpf_program *prog;
> >
> > -       if (argc != 2) {
> > -               fprintf(stderr, "pass device name\n");
> > -               return -1;
> > -       }
> > +       read_args(argc, argv);
> >
> > -       ifname = argv[1];
> > -       ifindex = if_nametoindex(ifname);
> >         rxq = rxq_num(ifname);
> >
> >         printf("rxq: %d\n", rxq);
> > --
> > 2.41.0
> >

