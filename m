Return-Path: <bpf+bounces-4990-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F069D75363D
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 11:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5F4E2816AB
	for <lists+bpf@lfdr.de>; Fri, 14 Jul 2023 09:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD22DF65;
	Fri, 14 Jul 2023 09:17:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE0D51F;
	Fri, 14 Jul 2023 09:17:23 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74BA1FC9;
	Fri, 14 Jul 2023 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689326241; x=1720862241;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=e7JIrKrrWhzaIAH6jDxKzpo+sjrt3ZTBx5hPU7FQi/g=;
  b=njyt1T0oRcXvENm6G3nNqzV4u+8AuPIrJimXWCHcTFLLRLBSqUdFeQD3
   ojCWM7Ysp/Nfr1IguUkATpSipVtsSq909ZkXDp0Hjy0Ez4CJFUBWe05LD
   2wPX7rILHoMfTmoHSoqZZDAVs52ePJz466ZA8rkHF5qOWnE29GxoUxvcQ
   GPpJqE4v0HAqWcprn5Daxmv3/QVzvKKY5gA2nKCRZAhnNPDtaWGfSDnud
   RHK/3SdMFZaPwv/5/kHOKDUM4y0+L4Yztqualalp8/6Jtj9DXskePbsOt
   p31s9iLmb6seOS/t2+NHjQuq41HHPDEraPFust6nEC71a1aDPis0pbEX5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364305625"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="364305625"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 02:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="846395408"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="846395408"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 14 Jul 2023 02:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 02:17:20 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 02:17:19 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 02:17:19 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 02:17:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgaLmdf/6EBQTwLn+/9jY4wSeV1BOn6RcQ1Y3TP2vIrIoQ5xxepEZdKa/HbFp+w9ymiHT+DB9O2Ywn/39ykgOdncpGpkf9MXMRL0WD1bZPHoJDSWO0l69RG8Ac/AoMSCpHt9Quowzl+GxeKX09Wv8kWR3cF7cIPjY3ytfFPVUyZE6FVi3NzXK9jMnz8rDP8vcyzksIT9mnCOoS08vFg5PJo3PZ+ecXgo99CgsTV/QpQcoo30u2TSmWeL9AO9UdHIab+kq+p6xd/+/5A+CxnkWq3a/c+jB/Yixn3G/CLqK7tiCqqJYphd31r70NgGkxaPggUWUBWIJfA2FozJdujexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bw51/Rd4lUNXIczEUsLmLJ1g2Fmpau487FgE42ZiYrA=;
 b=Af5bpUZDwN1T2VjhXrO0v2uJ0HKLvtPSawpCt+WLf/sKh6jN37M1kWmH/nHZXoc2800BxQtZ+g2BOxAcLxTTB176Ow8UGYXVgxtE42Fv1YKd1azEK5oN/HHWmw/VGe8xcEJfX66+krN9nEamUjoxqG9H9aSOlDjRhAaOSKUGxtiv9Z4WWIWRh9FdAu3LWDII+xQOYAnlnCQrFnyo54fkqLdKZJ+aSC6qsObdS6rBhrHntVff66fokWHgAMDiTQGh4utP8uNulG52iGk4GRn+Mmoidc10iUgLI4xWo+eijDHX8k1gsJoDd5r3RKJOgy0Ck/mqtT32ymh6PtCz1SWO8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CY5PR11MB6259.namprd11.prod.outlook.com (2603:10b6:930:24::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.27; Fri, 14 Jul 2023 09:17:17 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::3c7d:fa7c:3fd7:2cbe]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::3c7d:fa7c:3fd7:2cbe%3]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 09:17:17 +0000
Date: Fri, 14 Jul 2023 11:17:10 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	Network Development <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Simon
 Horman" <simon.horman@corigine.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Subject: Re: [PATCH v5 bpf-next 10/24] xsk: add new netlink attribute
 dedicated for ZC max frags
Message-ID: <ZLESlub35LTIJgzh@boxer>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
 <20230706204650.469087-11-maciej.fijalkowski@intel.com>
 <CAADnVQLKDratBrgvwHzXZBW9chH9SBXPhnXpExYwu0BbRVFPjQ@mail.gmail.com>
 <ZLBJbWqT4Ej8bHfx@boxer>
 <CAADnVQJUvE4Go4AyqCrUnHd=vkfEYBXEn9Sji7s2TdbXKL38bQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJUvE4Go4AyqCrUnHd=vkfEYBXEn9Sji7s2TdbXKL38bQ@mail.gmail.com>
X-ClientProxiedBy: DB3PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:8::40)
 To DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CY5PR11MB6259:EE_
X-MS-Office365-Filtering-Correlation-Id: 28d27755-96a9-411b-b8c7-08db844b1e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Oibtx4a4bAddc4UfIY1gsJyJkubOwik1Ak2TVqQUC40N1X1fBKj3jSbC9qkRjogtEPOwSNmNWgTC29l+QE+cRqOM57PMi7El/J/GrRCB995g1C02dP//4j3Tmn3hxV52LWQf9oZt41cPXks+fU5IRd7bNeVIuixBBigj2BxXxqJFld0ofg1OHIMr6TvtzsmebPKsJg3UBjWPMVAGch0WQW7afBNQqPoTf42Vvrt+4PC+9C4ZVZ7NEJiHgS0qhFyslsQ9t2ngjL8krx2FG6FePOv7WQfBvV/13h6lR9vvDrXPhdEB7Gh3aHUv7vGM0XE5FMyav78ylpO+P9XEvw6UVo+byFddAeoTdQ1VhRp5/9d2EWVwzYBqv8CfY17LXFyCuxOiZaXbkZCiVuve6EBFwjrSbBiSiqEi7t2cTvn7N37dEOdahtxefIdwcIUVlo5EDymSXeDkCKP7tWYtr8HuGsZ5Zx0aW2lEnF3y5N84S9toVvXxqXAGS7Nu1L3NHcA+nYWsAX3+oOPo8DslQa3dIts932wtrpBGR7o70iIEcQkQYMx2YPXPDTFVRHgcxpBbCOfTV63jdNy8v0aVLZ86ZsPBFLG35A7Kxd3m3jchWs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199021)(478600001)(6486002)(6666004)(54906003)(186003)(53546011)(6506007)(9686003)(6512007)(26005)(2906002)(33716001)(316002)(41300700001)(66946007)(66556008)(66476007)(6916009)(4326008)(5660300002)(44832011)(8936002)(8676002)(38100700002)(82960400001)(86362001)(83380400001)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTdzb0wzelhFb2k4Sm9kN1h3ZWdCTGRnb2k4NHpFaG5XUWZScDRYdnFlb2ZY?=
 =?utf-8?B?aUc0OWgvS282dElXeTVHM1ViN0o0ZWJsUDd1eXVvMmswOWNRWWpHT1lKZUlu?=
 =?utf-8?B?anRYUk0zTml2dkJIdVExVGFCRU5Pek1CbEdPODdUWkEvMDVPRzB2N2NxQmxu?=
 =?utf-8?B?c05yRFJKTnRNQmU3YTNCbkRDSUNhU3QrV3NuS0Exc0h6WWN2amZrSjVFRWRj?=
 =?utf-8?B?NCt3UEw2YTQ2VnlmNlhxMGpmNk5welJNVEt5WW5OWTY0RC9EMFpwck9ab2dP?=
 =?utf-8?B?SWdodW45aFVHUkhwOFMrTTlFZVlvdUNiOEdjcituWHlsNWhzZU9iaVJFMUNJ?=
 =?utf-8?B?SDhsb296Rldmd0xGazM4bEFET2QwVFFuT0ljWE1mNlVBOUJvYkwwM0luNno0?=
 =?utf-8?B?MWEzN0ppMFNXdzlmR0t3aXgydnRiUGhaSDhYaFU3OEQ5UklXcnROTWMzUDZ5?=
 =?utf-8?B?RmtYNC9yQ29xaUZTWE52YmpOU0RJZXRjWmJtUHdGT1N5T0JwejdJci9aK1NW?=
 =?utf-8?B?ejZWaFZpMXFpOEpLeWppZW9EYmJLS0owRHlCSHpIbXY5aE1hSGhmZldsNHJK?=
 =?utf-8?B?cjdPcnBxS2JXQjgxUTFmN24wTWNIRmtqczlVNDFrUzhLMDRXanBiek9lNktr?=
 =?utf-8?B?azQ4bUdPVTZSNHJuZHc5OUx4N0NIMGw5WEE2aXpUdmNSTk5BcEpOdFhhRlhu?=
 =?utf-8?B?emo3MmZPNFZBcFJRTFdzUTdvUEpTQThKWVJFVHR4bWVscWtuaUtzMkpScG5s?=
 =?utf-8?B?UUE4SjVudkhpczFsM2RQbFNEeE0wU2F2ZXBlaTB5WnN6b0NSaG93NzRPRlEr?=
 =?utf-8?B?YjEwOU9Wb0F2dzR2a3RrR2FFNWVoa1BwaG1CQ2g0SVFYV0xlTVF4c2VoWFlH?=
 =?utf-8?B?U1VxckNXaUJnV0JURVFDaThGNG9EdkJiSWhva0poU2Z4RlRlYlRjcWk0TVFQ?=
 =?utf-8?B?MW9weUc2ZTdoZnJhS0xRMU9yWTZhVHl1NUQ3QlFjOVNOYzQveTdMSmNjOTNF?=
 =?utf-8?B?ZVZHZUZrU3oxa21BVWpFdy9OOWc0VU5Ic3A5ZytuU09LbFBzYWlCa1pxVnZ3?=
 =?utf-8?B?Y00zZzdxbVlPalRETXQ0MTRJU3lXSkV4UzYrZ21oU1MyUjFHNnVmTGV2Mi9n?=
 =?utf-8?B?OTkwZStJT2hkMVhMU3lJZFl0dGRkakkxT1FCTVJQVVRFLzA1a25sVS8xTTYz?=
 =?utf-8?B?UEtDV0lPZXZWcThZVUk4OE9hTFl1czdjMHB3ZEtsNnp3TTB5WFM5UWV0YzF0?=
 =?utf-8?B?NldTcE9aYzRIcEU0QndZRFNweWlrM1Z5bEdNd2JnaWIrRTNQUktkS0lkT21y?=
 =?utf-8?B?TlVneE5oZkR4RjdzR254YmF4NElLemZmRExkWlFvUnBPL1UrbVhERDRyWVcy?=
 =?utf-8?B?S2RHVDVDWW04c1FuUDdVbzJaU25JT1VoUmhkUHgyUFcrUU5HS1pKbWh5U3dM?=
 =?utf-8?B?THVaVmtWVSsrUFZHek1zYjBLMC8rSUU4eDVRajUzVmlwQjJSVytCM3dVZ3hQ?=
 =?utf-8?B?OEdmZEhiM3ZBbFdSUzJFYkx1MDUyaTdMb2hsVlZYYXYwVFZGQnJQTkpjdzJw?=
 =?utf-8?B?MTZkRmtsaFlpeGhuV2NLVWhRUzA2NnpWRE1pNnNiWVE3VE5YcHg5bmZnbFZq?=
 =?utf-8?B?OWJEMGJMK3l5V2NUSGR4MndzTHpNMHE1UWlqb3YvS2V0c0JwY1VYR2g5dkEv?=
 =?utf-8?B?UXp4Qzg5UlBBdzQwL2NFR2dyT2ZkNWM2SmdJdTAvUEcvd3pJT3E1eThISmV5?=
 =?utf-8?B?ZTR2KzB2WVlTRG9kS3M3MlByNnRRTXZxUmJiRTdMaHR5ZWd4KzZ5aFhSa2lu?=
 =?utf-8?B?OHdkSDI4QVI2Vnh5NmFlU0VUYWNYbzF0Q2RHaG9NeXVZZFRCbDZybVlpQjNr?=
 =?utf-8?B?cnRHbkVqdzBTYysrV055WEpMb21pbTFoQkVJWEdVRFF6KzBpT2c1TUQvZUd2?=
 =?utf-8?B?WlhuazcwdnhvSVE5WU9NeldXR2lPRDdldzhObGRQeFJscytQKzgvK24xSHgz?=
 =?utf-8?B?TEtidUJSK2t2Ti9SbjA2TUh3N1lMbjlMdEhoN1dHQUtrWVljeitEZUlOVkhJ?=
 =?utf-8?B?cG94c0U3WHI1SUV2USsrM2pQMERYMWIycnNiSEtnL29Yd21Dc2ZnL2V3dkR4?=
 =?utf-8?B?RFNDc3RLdHdPQ0NLSDhBUGxXN1lBeEtRTCt6WkZEcW9tZzF1SFQ4NkY1MDZV?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28d27755-96a9-411b-b8c7-08db844b1e69
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 09:17:17.2435
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxFMH6p0um0qGgrHRHRvjKsLBtE+TQsfFwbkGM3FT/PuIkwYe8J9t1jS6HKHPsOeCoUUaXX8rIxx/Jmw71+Bsr10d2JxgZTQKxWkgByRGPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6259
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 04:02:42PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 13, 2023 at 11:59 AM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > On Mon, Jul 10, 2023 at 06:09:28PM -0700, Alexei Starovoitov wrote:
> > > On Thu, Jul 6, 2023 at 1:47 PM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > Introduce new netlink attribute NETDEV_A_DEV_XDP_ZC_MAX_SEGS that will
> > > > carry maximum fragments that underlying ZC driver is able to handle on
> > > > TX side. It is going to be included in netlink response only when driver
> > > > supports ZC. Any value higher than 1 implies multi-buffer ZC support on
> > > > underlying device.
> > > >
> > > > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > >
> > > I suspect something in this patch makes XDP bonding test fail.
> > > See BPF CI.
> > >
> > > I can reproduce the failure locally as well.
> > > test_progs -t bond
> > > works without the series and fails with them.
> >
> > Hi Alexei,
> >
> > this fails on second bpf_xdp_query() call due to non-zero (?) contents at the
> > end of bpf_xdp_query_opts struct - currently it looks as following:
> >
> > $ pahole -C bpf_xdp_query_opts libbpf.so
> > struct bpf_xdp_query_opts {
> >         size_t                     sz;                   /*     0     8 */
> >         __u32                      prog_id;              /*     8     4 */
> >         __u32                      drv_prog_id;          /*    12     4 */
> >         __u32                      hw_prog_id;           /*    16     4 */
> >         __u32                      skb_prog_id;          /*    20     4 */
> >         __u8                       attach_mode;          /*    24     1 */
> >
> >         /* XXX 7 bytes hole, try to pack */
> >
> >         __u64                      feature_flags;        /*    32     8 */
> >         __u32                      xdp_zc_max_segs;      /*    40     4 */
> >
> >         /* size: 48, cachelines: 1, members: 8 */
> >         /* sum members: 37, holes: 1, sum holes: 7 */
> >         /* padding: 4 */
> >         /* last cacheline: 48 bytes */
> > };
> >
> > Fix is either to move xdp_zc_max_segs up to existing hole or to zero out
> > struct before bpf_xdp_query() calls, like:
> >
> >         memset(&query_opts, 0, sizeof(struct bpf_xdp_query_opts));
> >         query_opts.sz = sizeof(struct bpf_xdp_query_opts);
> 
> Right. That would be good to have to clear the hole,
> but probably unrelated.
> 
> > I am kinda confused as this is happening due to two things. First off
> > bonding driver sets its xdp_features to NETDEV_XDP_ACT_MASK and in turn
> > this implies ZC feature enabled which makes xdp_zc_max_segs being included
> > in the response (it's value is 1 as it's the default).
> >
> > Then, offsetofend(struct type, type##__last_field) that is used as one of
> > libbpf_validate_opts() args gives me 40 but bpf_xdp_query_opts::sz has
> > stored 48, so in the end we go through the last 8 bytes in
> > libbpf_is_mem_zeroed() and we hit the '1' from xdp_zc_max_segs.
> 
> Because this patch didn't update
> bpf_xdp_query_opts__last_field

Heh, bummer, this was right in front of me whole time. I think I need a
break:) but before that let me send v6. Thanks Alexei.

> 
> It added a new field, but didn't update the macro.
> 
> > So, (silly) questions:
> > - why bonding driver defaults to all features enabled?
> 
> doesn't really matter in this context.
> 
> > - why __last_field does not recognize xdp_zc_max_segs at the end?
> 
> because the patch didn't update it :)
> 
> > Besides, I think i'll move xdp_zc_max_segs above to the hole. This fixes
> > the bonding test for me.
> 
> No. Keep it at the end.

