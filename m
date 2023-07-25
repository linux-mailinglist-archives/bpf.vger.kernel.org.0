Return-Path: <bpf+bounces-5803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 666DA760B48
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 09:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D959281A3C
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 07:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3428F77;
	Tue, 25 Jul 2023 07:16:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7A38F5E;
	Tue, 25 Jul 2023 07:16:14 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF63CBD;
	Tue, 25 Jul 2023 00:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690269372; x=1721805372;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=nfnVQ3D3weN3m9exjCF6K404CsGMS1Ev/neIh1rBBKY=;
  b=OiMzxgWtdYViXSRT+NWMGguN3++LP51B3cgJxRfZYB3zRDb4p4SLu1sA
   bPTlWuz7LHsQXKeVLOAGAvRmUuXn4h0QFScu6Rx3aUxS1YHe1cKyceOzB
   ZejtCmFoCKTNt5aJjvyjUZSjcMl58lMrsujab2ZV8zmrDny5ISqCOpxsp
   Z4cMYWJqL1N/k9SMPSGc0gY//BwCVr2QKMLjDEaA+eCaXHForS1ExOmSq
   NCCM5BKAuW5p1z1f9QrLd30hLEC5T7hR9mHoWBUWu4PXuLzoTuO7e43eL
   yf8Ci9ta+C3tlQZR8fwVH+x6iqeOjPBm+66AWLaRpj7ThXA6qnYpg5qwV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="365099987"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="365099987"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 00:16:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="796046788"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="796046788"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 25 Jul 2023 00:16:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 00:16:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 25 Jul 2023 00:16:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 25 Jul 2023 00:16:11 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 25 Jul 2023 00:16:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEmtl+pmcM225H7FVu+7llxCWiOc9EKiHzczagNye+aKCk4RnS0wNwpq2cAxsXBxOGr91iYG2q+qsJ2ByBQmt29TKm19VSt7q/BPue1IDG5gSTw4GUUl/V5X6b0FHts/LfdTZj2Ll5nBXCMGlXWStZFryE3sDWX6wByn3W1yruk2RZxI5vz3BMbmtrvvAyWV17KsXYmrYae6kOW8HmANfGizkaH3h0dogMZCT8yrbxU3SuAD+5JFkrQ8A5zy3TfldlzZPpdBDOC+01PzZP6eXJGQm9Vn2N2dHkP2McSQOOnrVtGhrkngRfxXpPXDGYIpTRjsZ8+E+rkWUKSpMfezFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SuVLW+jyS34359DD6TL1IJOnu2CPnfLzZKJuzuZ6aq4=;
 b=ZQuF631/45Q0rcoUI/cf9WETPGjvGp5vghI4rqi2QwGgxeH9hYZc0V6IZFXYbGX/r6rIdBJEWdcw0sj5bcOeHlAZFXL4Vb/s3V+ecvTGGXhL/EmgcLQKhovlBtE+cYi98muuqE5M2Ouo6vbTMKasGS0UXTiAPaHqdk2ZymjYWh9vkXqqudRqulOAxK4q3D5Cr4OFUvfyiEUuMIXbd18NcodJoUPvrtN3b8JRpHiF0AfDZOMGCFki17mwGEqSv6NBr91Ytz/pTDu+FvB0s3eYal4wNK/fE5Ek0iDRDBndBvE1935XvdLKbu6WQE10BJJi2zBgQZ6VbeHxrhA36Xlkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7050.namprd11.prod.outlook.com (2603:10b6:510:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 07:16:09 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6609.030; Tue, 25 Jul 2023
 07:16:09 +0000
Date: Tue, 25 Jul 2023 09:11:34 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "ast@kernel.org"
	<ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev"
	<martin.lau@linux.dev>, "song@kernel.org" <song@kernel.org>, "yhs@fb.com"
	<yhs@fb.com>, "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "haoluo@google.com"
	<haoluo@google.com>, "jolsa@kernel.org" <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, "Brouer, Jesper" <brouer@redhat.com>, "Burakov,
 Anatoly" <anatoly.burakov@intel.com>, "Lobakin, Aleksander"
	<aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	"Tahhan, Maryam" <mtahhan@redhat.com>, "xdp-hints@xdp-project.net"
	<xdp-hints@xdp-project.net>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 20/21] selftests/bpf: Check VLAN tag and
 proto in xdp_metadata
Message-ID: <ZL91pnrvlwdxP7M6@lincoln>
References: <20230719183734.21681-1-larysa.zaremba@intel.com>
 <20230719183734.21681-21-larysa.zaremba@intel.com>
 <ZLmxt3744Q1e42pT@google.com>
 <ZLo29C1kpx99+u6G@lincoln>
 <CAKH8qBtqCnewzcn_rfgNYPYD3oWSaDbf0ws6bDKL3H6gK7x6cg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKH8qBtqCnewzcn_rfgNYPYD3oWSaDbf0ws6bDKL3H6gK7x6cg@mail.gmail.com>
X-ClientProxiedBy: FR0P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::6) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6354f5d9-b2b4-43ae-43d5-08db8cdf04aa
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zcdKvBDJiHsgJy94DTY8k+C+qhtRnxciL4QJ4GJazu/fs7aiN7wz0p+DgKNYAAQJmQOQfHrRYK4JKpS93ZgxgGYAlPCfL9OoXQU2agMNB3tDnd0HgqI5dYP2l4r+SG/yXVSmRPMPoevVcitYleOC8Nlo8yvHcuQKfJ+8ajP3eLXXo1TqgyFoanTrpPMgFbVMwWPsPuFD+kgiYud3Q1sW44Ul9PC1CGA3Ce0eXTAZ5bHjMKT/TkIv707TPe+jOzgBOCu8ATHe4MYNhZAxa1saU18iUanURNOZFVg0+/3sXAMY9FAnfz8OcwukxX0bjTZABa8KhNWz/hii/32zX+fVCJ815rHJHa6IDZpJ1n+PnTtN5A3+1xw55njEwEjZc2gBeed2sNku0PGhgLhCj3UjWYhjf4qGP92x6wogDsKbynqsz4CitZTJE2DFVccRIgy+8TPjudNNlSOo709bB/RLG8fOVQd7VMYI7Os0629w41RMgIuErWgHwLiYuSXPdwPKH9oEv/pKSVtFyEqroTDKClqmKC+4a0YY9GnX0LTKHiVH7ATx/RaKhlPHuv2gkTc3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199021)(86362001)(33716001)(44832011)(2906002)(7416002)(83380400001)(186003)(53546011)(6506007)(26005)(6666004)(9686003)(6512007)(6486002)(54906003)(38100700002)(478600001)(4326008)(66946007)(8936002)(8676002)(316002)(66476007)(66556008)(6916009)(41300700001)(82960400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T3VmV0RFR1U5ZUswSEQrbHkrRkVuYVVLRktCWnp5MmtaYnpUZXRqYWo2eHNP?=
 =?utf-8?B?eTJ3UmR6KzRoSVliRUZlYzRyUWg0bFQwTXMyK0dkcVNPWkV1Ry9FSDk0V2lM?=
 =?utf-8?B?SGdtdHpid3lhY202U1FGS2lJcTZtMTU5SXoycHpqTlFOZkJ6SDB5NDdmUW8z?=
 =?utf-8?B?ZUF3aEs4YVY4V3dGaktudVFDRFdZNGd2Smw4Ulp5ZUEvZy9xMGFmRnBxellq?=
 =?utf-8?B?eTc1dGswNmdvT2UxK2FDb29RaHR1ZCt2aytXNHpyMGowdm5hMVJnbU1ZbGxZ?=
 =?utf-8?B?eThPRmtwRXRISWMrSDdaVnJuWXNiazFPWks5ajRVRjBpUGdQa1JWWmdaZDZl?=
 =?utf-8?B?cFlzamVZRjBZb0QxN1JYUWNqcUdnYTRBV2ViUzNpU3UwVFVoUVRibGxkaHB4?=
 =?utf-8?B?NzczNkNlbVdZYzFXZzMrMDkzUlFsdkdub1NCVjBPU09ON1hGUU5Vc0lDRDVU?=
 =?utf-8?B?YnZCbVpodzV2K3BTcWJlczlzVzgxVnd5d0dWRDhYbVpERjZiUlJ2d2xZZ2Ry?=
 =?utf-8?B?L3lYQTJoSzFzaklxcm4vcjE1cXBHemR5TUNwbnpSWlBNb0p4bkUwcEdkR2Zy?=
 =?utf-8?B?UUgrWjRIajRkeGNnZjNQUW5jejdWMnliVjlzenpnS09pQUNoNlo0S0lOVjRD?=
 =?utf-8?B?VHk4bGx5NCtUOHdQVVpycUsvRnpLOFl1L3JVeHA1c2NyWGJSdlF6T2ROWFFF?=
 =?utf-8?B?MnlpM1h0V1BKSVBBMFJOcUozbWtXRm9qNEVtRzd6QWFzem5OTll2TWhYVWpS?=
 =?utf-8?B?R0hrNTJyc3dFak1TZEtxZ2dMQ3FGRlJaWFhQUVRqcFRxaEluN0Q4cVhTbU14?=
 =?utf-8?B?NXZYVjBPWkVUZjdVUTZ4dmdsbGhyUFd6SkhINFBzTm5WdDJUQ2NYMHRqbHpq?=
 =?utf-8?B?ZTRvUC85eHVuaHRSenIrSldOcUdqOVJnOWw2ZWlpRS9Fc1ZONXE2cDJIOXds?=
 =?utf-8?B?N0hWTjZDRkRjUUFRaVNGRGR2WlpjVmk4SDBBc2dROXdxLzFOOXU2K3E2RVlq?=
 =?utf-8?B?M0svTnZxV3FnU05GK0xVRlY2WXFDSTBiclRtQndwMnVhZkZpa2tlSFFKL0lx?=
 =?utf-8?B?VDNSc3k3cEdBUlEvVTlaTVRKNWlpMFJndFcwMVVrcFAzc3YyaFM5VVhIYlY1?=
 =?utf-8?B?eU9VeG1LYjNPdDhDb3hNdnRGRWdYZzdGK29CcEM5a3pGY0FSVjhxMHRnSnVR?=
 =?utf-8?B?d0t4ZTlrSi9nQmFhZTBha0FGdWV4c2hra2hUM2dBS3R6TStpTy9LYlM3ZzNF?=
 =?utf-8?B?ek1aeEQ2U1VncGlodjJPejJEWFVPNVlkMVQ2Rlc2Z1JWaDFIVE9xYXF0N2Vq?=
 =?utf-8?B?QUpCb1psR1Y2cmJwUHhQVngwbmFKQUZBZER5NzdOR096cTNHVlBTYUx2L0gw?=
 =?utf-8?B?U1E5b2FjUU9LejRReUNValVUY1luUytqdnNpNlB0YURyNENvZk5aY1lFU292?=
 =?utf-8?B?elJaZWdDTU1OQ0EzdTRCajVOemFhS1Rjck9UT2FoSVNGUjZ4R3owMHoxei81?=
 =?utf-8?B?V1ZObFpYWDROZHdlU29ndk5RTXJxdmw5WnFHYi9VK2dyUU9PYnZlOGJhRU9G?=
 =?utf-8?B?cHJYRHd4NHZjUHNEVHduK05CVFRrVDR6blpCUFFuZnJ3RlIrbE5XbC9LaUJj?=
 =?utf-8?B?MmM5U1AyZUlKNDBOTHJuT1k2WHgzOFV2UStYcEhvOFR0MnI2VGxpbWZ0K3Iz?=
 =?utf-8?B?dWs3cExSREYrTG9mTEQ2Q0hkSTVPcEVlelV1RFZGcE5HVUk3aU8rM0Z0TE1Q?=
 =?utf-8?B?SDZHSElpVlMwS2NiQTNCR1BKb0wwV05ycTIybWFLNWsxZncrWUo3VnFQYzZ1?=
 =?utf-8?B?TUlJT0V6Z25xR0RNaXBpN2FpOGtHVGF4YTlPZitLaXFxaUxoV3JFcThVaVFY?=
 =?utf-8?B?cklMeVo4L0RjTXRMSFYxY2t3QUdOTytRVHFyOThrQWlrTkxrZ0pxb0pmL0lu?=
 =?utf-8?B?Y0FNWGF1dktTTE1zMERtSHdiM2JuRktsVGp1UDdFV3liQXh1bWFOZkZwRXI1?=
 =?utf-8?B?eHFuQkVjMVkyTENNZVRrNjBwQUsrWkJQTjdZL0xMYlBLS3ZUS0hIK01zZnBr?=
 =?utf-8?B?SFl6NTl4SUM5cGo4b0JSdngxSTg0Y2lIZ2dkd05BOEVxNGkwS0xZeWxOanIv?=
 =?utf-8?B?am80bzJiWGxzSWxjZ0dHOUVRcHJhdGJjc2J4VFJENkpXNUMyM2hNNDBKbmdu?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6354f5d9-b2b4-43ae-43d5-08db8cdf04aa
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 07:16:09.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jqSKFLG42SHJr2Y7o08hBXm0ftP+sPgvQuz04QhEtGtAw1RNOQxV6xL+HwFmaqSXJjRIhtATudFbIAp2sUTHRxInM34PvIFsiRIGdEemvLM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7050
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 21, 2023 at 09:44:17AM -0700, Stanislav Fomichev wrote:
> On Fri, Jul 21, 2023 at 12:47 AM Zaremba, Larysa
> <larysa.zaremba@intel.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 03:14:15PM -0700, Stanislav Fomichev wrote:
> > > On 07/19, Larysa Zaremba wrote:
> > > > Verify, whether VLAN tag and proto are set correctly.
> > > >
> > > > To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> > > > interface.
> > > >
> > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > >
> > > Acked-by: Stanislav Fomichev <sdf@google.com>
> > >
> > > > ---
> > > >  .../selftests/bpf/prog_tests/xdp_metadata.c   | 22 +++++++++++++++++--
> > > >  .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
> > > >  2 files changed, 24 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > > index 1877e5c6d6c7..6665cf0c59cc 100644
> > > > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > > > @@ -38,7 +38,15 @@
> > > >  #define TX_MAC "00:00:00:00:00:01"
> > > >  #define RX_MAC "00:00:00:00:00:02"
> > > >
> > > > +#define VLAN_ID 59
> > > > +#define VLAN_ID_STR "59"
> > >
> > > I was looking whether we have some str(x) macro in the selftests,
> > > but doesn't look like we have any...
> > >
> >
> > I could add one, if you could hint me at the file, where it would need to go.
> > Or just add it locally for now?
> 
> Up to you. I feel like it's fine as is.
>

I need to send v4 with some minor changes anyway, so will add in v4.

> I was expecting to find something like the following in
> tools/testing/selftests/bpf/testing_helpers.h:
> 
> #define __TO_STR(x) #x
> #define TO_STR(x) __TO_STR(x)
> 
> We have similar patterns in:
> tools/testing/selftests/bpf/sdt.h (_SDT_ARG_CONSTRAINT_STRING)
> tools/testing/selftests/kvm/x86_64/smm_test.c (XSTR)
> tools/tracing/rtla/src/utils.c (STR)
> 
> But nothing "generic" it seems...
> 
> > > > +#define VLAN_PROTO "802.1Q"
> > > > +#define VLAN_PID htons(ETH_P_8021Q)
> > > > +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> > > > +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> > > > +
> > > >  #define XDP_RSS_TYPE_L4 BIT(3)
> > > > +#define VLAN_VID_MASK 0xfff
> > > >
> > > >  struct xsk {
> > > >     void *umem_area;
> > > > @@ -215,6 +223,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
> > > >     if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
> > > >             return -1;
> > > >
> > > > +   if (!ASSERT_EQ(meta->rx_vlan_tci & VLAN_VID_MASK, VLAN_ID, "rx_vlan_tci"))
> > > > +           return -1;
> > > > +
> > > > +   if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> > > > +           return -1;
> > > > +
> > > >     xsk_ring_cons__release(&xsk->rx, 1);
> > > >     refill_rx(xsk, comp_addr);
> > > >
> > > > @@ -248,10 +262,14 @@ void test_xdp_metadata(void)
> > > >
> > > >     SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> > > >     SYS(out, "ip link set dev " TX_NAME " up");
> > > > -   SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > > > +
> > > > +   SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> > > > +            " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> > > > +   SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> > > > +   SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
> > > >
> > > >     /* Avoid ARP calls */
> > > > -   SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> > > > +   SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
> > > >     close_netns(tok);
> > > >
> > > >     tok = open_netns(RX_NETNS_NAME);
> > > > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > > > index d151d406a123..d3111649170e 100644
> > > > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > > > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > > > @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> > > >                                      __u64 *timestamp) __ksym;
> > > >  extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> > > >                                 enum xdp_rss_hash_type *rss_type) __ksym;
> > > > +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> > > > +                                   __u16 *vlan_tci,
> > > > +                                   __be16 *vlan_proto) __ksym;
> > > >
> > > >  SEC("xdp")
> > > >  int rx(struct xdp_md *ctx)
> > > > @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
> > > >             meta->rx_timestamp = 1;
> > > >
> > > >     bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> > > > +   bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tci, &meta->rx_vlan_proto);
> > > >
> > > >     return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> > > >  }
> > > > --
> > > > 2.41.0
> > > >
> > >

