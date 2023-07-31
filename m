Return-Path: <bpf+bounces-6428-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DDD7693D4
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D761C208E5
	for <lists+bpf@lfdr.de>; Mon, 31 Jul 2023 10:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DA17FF2;
	Mon, 31 Jul 2023 10:57:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB008BF0;
	Mon, 31 Jul 2023 10:57:15 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA3035A9;
	Mon, 31 Jul 2023 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690801016; x=1722337016;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=00r5gllT0Cq4uVi7D4yJV4ySnRJGqb0EL2cKWSfvCac=;
  b=JdiN359aMbFKIyk2NvaXdTfUBENIaVU9kuXvHdfKEPGQuXoiyxDS2mDR
   mPbvjP5rcWncZ6UOvO50yvwFIVlUROiEcDRHrchTr6nVg5VsypocvvtKX
   R6Xdjn/jqlNmY3Q7zH6H4nX9usfe8MELmloJ2kkAi0bSKb4tVe8Ts2bcP
   OxbDP0OlUJd8rcQb30uQSqRmjSLtBDq9SFCmGksEWuoYoBB8oDY8sTUrH
   J8oT/xeru4BT310I5vZ7Uvaj5aCogJx6yRHl0pZqBO6JjYWisIquCRF1w
   NfI8UEQYVuyR9a52H8SzxEcxywECBWaCZmcFj1VCRM+pwkIDie3Cn6b5t
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="435290648"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="435290648"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 03:56:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="798212302"
X-IronPort-AV: E=Sophos;i="6.01,244,1684825200"; 
   d="scan'208";a="798212302"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 03:56:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 03:56:48 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 03:56:48 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 03:56:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 03:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VN8pzGw1SyoA9B/Fo1qSk8nAXygtU0FbO2Zvvkc8o2//YtoCGvgQIbGa4ufHYElZlIALPR3FSufkqHPeJBDw4htB+n1vmMvRWc+Cn6P3n0rdTy3au+56smMs5XPV71m/Kfj65E9TQEsMLxrPQay1sI1BKU/W5k/JUVpNLpUxLiJXtiPS46sUgn5mNYcSuEk/9CvIRReDhe1o9EL5Qk36NTAHSqb/sX8idcq+caL9uNL/dGE6AzoELvIYMe5kTGAdnInGaKYOERJnkYwrPYOsKF3Vz2vXm2m8Q1zNU7iDHOsRiPzsVKhlHfJQD5crcL68iUNyL3jnM6FBqKqF8yLBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11YOiMFAFajkTdc40rW8zM6e0HnW8WPleUP/+xTJXTc=;
 b=h0pZ6V+EJ9oYgxgd6MJyrZwLuA++BBtzAyWk46ojydB9xY8RjRzEGt7sdenYU/r1dEI1TyYhnEjq0V4ISmH3kxZaYMfHpjiHedlhazKKels8JaY94tVgM02B8liYcc6KtzK+FpS2mLJhuFAjklVZhJ64B7/OKrqJ0zZqLTOBBtcNDALfvRBd4oMunDidMLFE3jyXj2xLx+dVsvdp7GJiJEx7k3HrElwOWXYHd/Zhwc2v3OD/SP3//Dm2x3VW+FIxvyLXvlTJFzu/A08PfFqup+nFHPpMxAt/xLR16TNamSu1j3sjqFR/EPP2G+XkTTddmVRZhD5za+qrfofy1quO0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SJ2PR11MB7714.namprd11.prod.outlook.com (2603:10b6:a03:4fd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Mon, 31 Jul
 2023 10:56:46 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 10:56:45 +0000
Date: Mon, 31 Jul 2023 12:52:02 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf
	<bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
	<yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh
	<kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
	<haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, David Ahern
	<dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn
	<willemb@google.com>, Jesper Dangaard Brouer <brouer@redhat.com>, "Anatoly
 Burakov" <anatoly.burakov@intel.com>, Alexander Lobakin
	<alexandr.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@gmail.com>,
	Maryam Tahhan <mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, "Network
 Development" <netdev@vger.kernel.org>, Simon Horman
	<simon.horman@corigine.com>
Subject: Re: [PATCH bpf-next v4 12/21] xdp: Add checksum hint
Message-ID: <ZMeSUrOfhq9dWz6f@lincoln>
References: <20230728173923.1318596-1-larysa.zaremba@intel.com>
 <20230728173923.1318596-13-larysa.zaremba@intel.com>
 <20230728215340.pf3qcfxh7g4x7s6a@MacBook-Pro-8.local>
 <64c53b1b29a66_e235c2942d@willemb.c.googlers.com.notmuch>
 <CAADnVQ+vn0=1UT5_c628ovq+LzfrNFf0MxmZn++NqeUFJ-ykQw@mail.gmail.com>
 <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64c661de227c2_11bfb629493@willemb.c.googlers.com.notmuch>
X-ClientProxiedBy: FR0P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::17) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SJ2PR11MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: f1286639-b109-4655-032e-08db91b4d460
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zBloti3jujkgaVcZnZVK7O9nykt+5/ez7BZKOk8+/ZVJ/9XeM4cuNjljHxwDDqPB9flsiaIGoJmnfa08V8ybiELnTmkzpsYzYoQydsAabpj/4Kus+fHKkWHcV6N1GIQnPk/oCxjq4T2kDRNBrnM1BpOX35ofsA9MxApe9kEkRbzRnWNgWory3vJaSv94wpyAhMV7Q8+37ibahz3qASOJC0FOp3iF7PvfoUkSCegq5quIHOAIjsyTOx1nTYFDM7eI/WYNMlWWN4Wm/mDKUEYcQD4h+BEkkBy5rZvMRuhe8OlZfyEhn/oSeCpG7Ws3iOB0HEcMcQ/iC/K2nkNT7FbMxajsSORMkDPYN/Txyj+SwGzXS6895ULpI/v/+9379roT5vUWj//aRV5w9+5Oq04WGKw+diD0BUjQ1sTzq0uVNSW1WnAP2mjY881jVpUb+Sc0WeJydCP+pqlfS3ZkGA96g31Iq+ppY4CkjqjsWVlYH3kcl2eC7o386X5B1o4yJuEfzg180rJzIJJZevsQ0ZvoY+rUzHYkVNwzjJp6HfRIoeWXLRvmXbcG9gaWJhdq3OBH8syvvYzoFpkDdilmYzko/09+RHP/mi+TXTXAqdV8FTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(2906002)(316002)(8676002)(8936002)(7416002)(5660300002)(44832011)(41300700001)(33716001)(86362001)(6512007)(6486002)(6666004)(54906003)(478600001)(82960400001)(53546011)(966005)(26005)(6506007)(186003)(110136005)(9686003)(83380400001)(66946007)(38100700002)(66556008)(4326008)(66476007)(134885004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmVic2pkVlFoZmRhQ2w3Q2xDUTR5bFVoUHFFZDc1S29oT1BhQjVvSHpPU0c5?=
 =?utf-8?B?enF2eGVaMXVVeXVld3ZrWVRrRWZ0Q3dpeE1SQWtFd1UvOUdtaXFLcGl4L2Ro?=
 =?utf-8?B?VE5DLzk5Sm1IbUhUaG9mRW1sckptcVp6Z3hxSW9aRVdUK0tMSUZRYmJwZEpN?=
 =?utf-8?B?SVZXWlZ4anROc2txTldqaVo3aEs5dHNlRFZ1aTZ6bE9TWVdNZW1POXQyQm1S?=
 =?utf-8?B?T3UwRkxJc3owdGpOZElNRjUwajlyV0lWOFczV1Y3eGR0NTZyVTQwdHM1OE5H?=
 =?utf-8?B?WkVKQmlsUlhhRDNYVFpyQlhLaHBYNStycG5saVQ3aGJzRWRkZnVVYXhFSU9O?=
 =?utf-8?B?RGk0dG5zbExWSE9GTDlObXR1WHVENFZXMms0a082L3c4Z0hMdGNaMjlzaXF2?=
 =?utf-8?B?NXY4VGhFYXAyZllWcEtDSVFZOFZlb1FqemM1RFlzQWpKWmtRUXVzcjUyUG55?=
 =?utf-8?B?RHpLbXBDQ29adnJyTzQ0d0xwY2E4RVUxYWRPMnNZb3JXaFp3SHNpWDJ6T3cw?=
 =?utf-8?B?UnFwSlJPVTdSSXR0dUw5c242MUU0L2hmbUZCelhsMldTMUlUWTU1YnQzTlpx?=
 =?utf-8?B?d3lreDNMNmRmNDA4VHJSSmhqMDNqelFWazhhaFFEZ0FWNVBWZ2IvOGZtOEZ2?=
 =?utf-8?B?ZzRZbnpWRHE5WnNBODNwT2locE02M01ucTBWaXBmc2dxSkNDbmh5L29RTTZk?=
 =?utf-8?B?ellReGhFNkxzbzh6VlMzWnZIbExNT3Vua2VYYXZvZUpONlVQN1JNNHd2Q24z?=
 =?utf-8?B?dDdkVDYrTGQvNnI5ZDE4OUgySVFPYkxQMU9Fa0dWZHROaW04KzJHZlBSL1Nw?=
 =?utf-8?B?bFh2QmFzNko3UndkcDl2c21xU3lJamxLSG5YZ3VpNG1aRC9HSVdsMXBqZGc0?=
 =?utf-8?B?YTJaY053Mis1SjBaUm16WjFuOHV2UmtDaHdrZndScXI3NUlwOHZ2UitmdUdo?=
 =?utf-8?B?NUhPc05kcC82ODJlOFNIUXd1eGFESXZURXEveEcraFVIYmtYZHQrYU1KOFpK?=
 =?utf-8?B?MmtUS2c5RGNJOTVFK1cweC9GNnoweEpqM1lqZXlUUkZpRzk5WEZhK0Q5ZUFH?=
 =?utf-8?B?R0lmUDI3YjFwa0RoMnpBN0JGU1FnNThZd0dSSmQzQTBvRVpueHZNUW5tN09y?=
 =?utf-8?B?YnZtaG5ZVHF2bGF5MEVZL21GM0hhUDlrcjNhOHF0YmFQbEtSbGVZZlVIblRk?=
 =?utf-8?B?aGNFSitXVFBHbTVGVjNFeG5SS1c2SFVrQmJ5anZORHIwbGYwdEFDTkMrR2Zr?=
 =?utf-8?B?ZndYNzE4WnBiTXVmSmVZQjY4UWtldGwzWW52K0RFRTY3YmgyVVI5VGJSano0?=
 =?utf-8?B?M2RCNkNBS0JSY1V6YWJRcWQ0UUNLdGFiNkMxMmpCOUIxMStZaTU3SitUbmp5?=
 =?utf-8?B?SEFOTlQ3cEErTW05T2dqY1dOQkZjYndZaDVLcDJoYVNuc3U0d2lLV3JocThp?=
 =?utf-8?B?WUN6NUk4U2hIeUMrTUxqWHVTU05RNU50dXF3RlRpNERGaGxFcjd5TUJUdlhw?=
 =?utf-8?B?S1kyYUg4Yi84Y3ZHR1NtVzk5eXkrazh2dVdJbkgya2xQL3BlanhPTU4rVDhR?=
 =?utf-8?B?K2hEeUcwWkZDakh2V3B6NVBmQkJMcm84Unh3Y2JqdjhWbjJTZThOcEFUY2pM?=
 =?utf-8?B?YndDZlZqLzN1SXF6S0ZReTZTRS95WlAwUzJyT1ZjRU1yQ2hMVXFPSmg4Tno0?=
 =?utf-8?B?WWJSR1o4dUtFbElaZFBBenRlMXNIL0RQaC95YkhudTdlakFNQnJ4M21wR2k4?=
 =?utf-8?B?ZnV6WWtHVDJzcE4xM2xPd1BLam5xRTdiMTdETFNkRnNmSElIR2syZXplbUhn?=
 =?utf-8?B?WitVVXdLM1ZTMXQ3enNxblNvWnVBa2pHNmx0VkpjVHhnN2tRam9Pd256QnMv?=
 =?utf-8?B?UlFVOXhRd0VSb1RUcmIra1BDNDRFVFp0R1lkUlViVElRYnk5NWl3SmRjSWxY?=
 =?utf-8?B?SDl4NFQ5VVU5eGREY3FmM3pxSHh0VlN5L29kdC84MHo1Nm4zN0JRV0l3dWwy?=
 =?utf-8?B?Ni8wSjJUMDB0VTJYb2cwd1BMTldNaEJHcmxVdnRMK2QyTmF2ZlJuQ3I1ckdW?=
 =?utf-8?B?Vy8rYm5kVU9mRmZydEZtcWpsRFhzYVRCQnZ5c2tDNXpPbWRoSUo2NU9iNC9C?=
 =?utf-8?B?K0V2TFdOMnBBMENzNXhSNFVldWl4MS9OYzl1YXpSZ1h0dDRNcDFEZTJoMjVY?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f1286639-b109-4655-032e-08db91b4d460
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 10:56:44.9891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mufUyDBusNec49vLg7zOtZ4VL12znujNJs5ysh87aspGTjyUR6JyYhOZqncycctRkA7S+y9kUbnayzpXv4L7OUBHpD73/2wjYlzPn0ZII5E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7714
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 09:13:02AM -0400, Willem de Bruijn wrote:
> Alexei Starovoitov wrote:
> > On Sat, Jul 29, 2023 at 9:15 AM Willem de Bruijn
> > <willemdebruijn.kernel@gmail.com> wrote:
> > >
> > > Alexei Starovoitov wrote:
> > > > On Fri, Jul 28, 2023 at 07:39:14PM +0200, Larysa Zaremba wrote:
> > > > >
> > > > > +union xdp_csum_info {
> > > > > +   /* Checksum referred to by ``csum_start + csum_offset`` is considered
> > > > > +    * valid, but was never calculated, TX device has to do this,
> > > > > +    * starting from csum_start packet byte.
> > > > > +    * Any preceding checksums are also considered valid.
> > > > > +    * Available, if ``status == XDP_CHECKSUM_PARTIAL``.
> > > > > +    */
> > > > > +   struct {
> > > > > +           u16 csum_start;
> > > > > +           u16 csum_offset;
> > > > > +   };
> > > > > +
> > > >
> > > > CHECKSUM_PARTIAL makes sense on TX, but this RX. I don't see in the above.
> > >
> > > It can be observed on RX when packets are looped.
> > >
> > > This may be observed even in XDP on veth.
> > 
> > veth and XDP is a broken combination. GSO packets coming out of containers
> > cannot be parsed properly by XDP.
> > It was added mainly for testing. Just like "generic XDP".
> > bpf progs at skb layer is much better fit for veth.
> 
> Ok. Still, seems forward looking and little cost to define the
> constant?
>

+1
CHECKSUM_PARTIAL is mostly for testing and removing/adding it doesn't change 
anything from the perspective of the user that does not use it, so I think it is 
worth having.

> > > > > +   /* Checksum, calculated over the whole packet.
> > > > > +    * Available, if ``status & XDP_CHECKSUM_COMPLETE``.
> > > > > +    */
> > > > > +   u32 checksum;
> > > >
> > > > imo XDP RX should only support XDP_CHECKSUM_COMPLETE with u32 checksum
> > > > or XDP_CHECKSUM_UNNECESSARY.
> > > >
> > > > > +};
> > > > > +
> > > > > +enum xdp_csum_status {
> > > > > +   /* HW had parsed several transport headers and validated their
> > > > > +    * checksums, same as ``CHECKSUM_UNNECESSARY`` in ``sk_buff``.
> > > > > +    * 3 least significant bytes contain number of consecutive checksums,
> > > > > +    * starting with the outermost, reported by hardware as valid.
> > > > > +    * ``sk_buff`` checksum level (``csum_level``) notation is provided
> > > > > +    * for driver developers.
> > > > > +    */
> > > > > +   XDP_CHECKSUM_VALID_LVL0         = 1,    /* 1 outermost checksum */
> > > > > +   XDP_CHECKSUM_VALID_LVL1         = 2,    /* 2 outermost checksums */
> > > > > +   XDP_CHECKSUM_VALID_LVL2         = 3,    /* 3 outermost checksums */
> > > > > +   XDP_CHECKSUM_VALID_LVL3         = 4,    /* 4 outermost checksums */
> > > > > +   XDP_CHECKSUM_VALID_NUM_MASK     = GENMASK(2, 0),
> > > > > +   XDP_CHECKSUM_VALID              = XDP_CHECKSUM_VALID_NUM_MASK,
> > > >
> > > > I don't see what bpf prog suppose to do with these levels.
> > > > The driver should pick between 3:
> > > > XDP_CHECKSUM_UNNECESSARY, XDP_CHECKSUM_COMPLETE, XDP_CHECKSUM_NONE.
> > > >
> > > > No levels and no anything partial. please.
> > >
> > > This levels business is an unfortunate side effect of
> > > CHECKSUM_UNNECESSARY. For a packet with multiple checksum fields, what
> > > does the boolean actually mean? With these levels, at least that is
> > > well defined: the first N checksum fields.
> > 
> > If I understand this correctly this is intel specific feature that
> > other NICs don't have. skb layer also doesn't have such concept.

Please look into csum_level field in sk_buff. It is not the most used property 
in the kernel networking code, but it is certainly 1. used by networking stack 
2. set to non-zero value by many vendors.

So you do not need to search yourself, I'll copy-paste the docs for 
CHECKSUM_UNNECESSARY here:

 *   %CHECKSUM_UNNECESSARY is applicable to following protocols:
 *
 *     - TCP: IPv6 and IPv4.
 *     - UDP: IPv4 and IPv6. A device may apply CHECKSUM_UNNECESSARY to a
 *       zero UDP checksum for either IPv4 or IPv6, the networking stack
 *       may perform further validation in this case.
 *     - GRE: only if the checksum is present in the header.
 *     - SCTP: indicates the CRC in SCTP header has been validated.
 *     - FCOE: indicates the CRC in FC frame has been validated.
 *

Please, look at this:

 *   &sk_buff.csum_level indicates the number of consecutive checksums found in
 *   the packet minus one that have been verified as %CHECKSUM_UNNECESSARY.
 *   For instance if a device receives an IPv6->UDP->GRE->IPv4->TCP packet
 *   and a device is able to verify the checksums for UDP (possibly zero),
 *   GRE (checksum flag is set) and TCP, &sk_buff.csum_level would be set to
 *   two. If the device were only able to verify the UDP checksum and not
 *   GRE, either because it doesn't support GRE checksum or because GRE
 *   checksum is bad, skb->csum_level would be set to zero (TCP checksum is
 *   not considered in this case).

From: 
https://elixir.bootlin.com/linux/v6.5-rc4/source/include/linux/skbuff.h#L115

> > The driver should say CHECKSUM_UNNECESSARY when it's sure
> > or don't pretend that it checks the checksum and just say NONE.
> 

Well, in such case, most of the NICs that use CHECKSUM_UNNECESSARY would have to 
return CHECKSUM_NONE instead, because based on my quick search, they mostly 
return checksum level of 0 (no tunneling detected) or 1 (tunneling detected),
so they only parse headers up to a certain depth, meaning it's not possible
to tell whether there isn't another CHECKSUM_UNNECESSARY-eligible header hiding
in the payload, so those NIC cannot guarantee ALL the checksums present in the 
packet are correct. So, by your logic, we should make e.g. AF_XDP user re-check 
already verified checksums themselves, because HW "doesn't pretend that it 
checks the checksum and just says NONE".

> I did not know how much this was used, but quick grep for non constant
> csum_level shows devices from at least six vendors.

Yes, there are several vendors that set the csum_level, including broadcom 
(bnxt) and mellanox (mlx4 and mlx5).

Also, CHECKSUM_UNNECESSARY is found in 100+ drivers/net/ethernet files,
while csum_level is in like 20, which means overwhelming majority of 
CHECKSUM_UNNECESSARY NICs actually stay with the default checksum level of '0'
(they check only the outermost checksum - anything else needs to be verified by 
the networking stack).

