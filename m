Return-Path: <bpf+bounces-4968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DB752AA3
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 20:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F29281EFF
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFCB1F19E;
	Thu, 13 Jul 2023 18:59:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E99D1ED53;
	Thu, 13 Jul 2023 18:59:32 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28A22710;
	Thu, 13 Jul 2023 11:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689274766; x=1720810766;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=lIe3GQZtL1/nU1Vqz3pfmAyppgaJvjy74PlSYarMEeA=;
  b=RPe0P6NnDDJGrl4d8M2bZ62BXJm68j1/1A4Un3U+GEDoIY+jzSHZxmLa
   g9Uoipf1kbKE9VDwg8nggGB1IVzMCNala7qBt+wmQYqPTCyJygD9v6h7F
   dzZy/WhvUL6rgT2Gha3te+FU214gIkE2IvD68hgmxwZijcbXAA0ylfceX
   JG03+1wZ023IvEmOcxw1CNgfIPYLIa5rB8hGJYiLJKeVf+wP6t/+A2oPb
   jnyVlI291gg7PipiC4X8N4Yc5xMRSykL1HGAbrGtY2w+uTTrVDf3xKHJ7
   vqfYiRs2fxq1tAe8aURBYhg2DknTu7N7OMtkNxSywUJGlkW8f7/q6JUjP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364160889"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="364160889"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 11:59:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896125256"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="896125256"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 11:59:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 11:59:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 11:59:13 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 11:59:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrzGYpE40gWSNhIkq21Ujxo28EacK1AFRDoK3AWhiJ64/dvDQkJHcLlVyLyNmYIEvwozxqr6NWVFe7PVst26GU92d+ur7b1L+gvKmUXpl44X+TlfN6rzBR/xOzsK6MKZii0p+0cRwjHDJDQCPWPyE6u5EsHZRMAPEC/0dAfeVqmawxpfDRmYJ7KlA7xGokh/1sFwDi1QBNG2rFKukOLmLxO3h+6QvcbDlVxwE+tm1A1FLv6U9FMkUM2jfg3d3Iih289RBGvthpVxDvoF4KUhwD8oWG8xhBNb8zEmfVAANAJ3IEhzoBGcaIXOj3eG+p1DWWMbDYArCq10tyPNBW1Viw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZq6OjerEeboL1QbjNcdR6CZGCX97rKNOT5ZryPHTas=;
 b=br96nBPOURSJjRIU+h7V6tz7dOU9MncWYLQut69rNQFzRRPUEpZT1r058c0LswIoanALev4U+OZf/ELn3EBvDdZK+6P5p9LoR82S0Dv+YjcS0G1DwYENaWYLYFpaGN7pLrX5wDn7mOVQLfMd15ftAIMN6FFPSy3WXYpHnnW/1Nzo+hN8NkhodsIoBNDAj76Q6r3TfrUCXBPcEsJFwwXw4WQGOUVjFQgwdIXKSHqbuNnJVWGNQcPHfQ7KazAQapIqZIpKGq9JmIundsFa6LvERXLl1FkxQzj83oY1TDFYE+bzXpKVsyvNrD8LXKDc3SFQicbsQK8Kr2ILRf4sTvGY0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 MN2PR11MB4742.namprd11.prod.outlook.com (2603:10b6:208:26b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Thu, 13 Jul
 2023 18:59:12 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::3c7d:fa7c:3fd7:2cbe]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::3c7d:fa7c:3fd7:2cbe%3]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 18:59:11 +0000
Date: Thu, 13 Jul 2023 20:58:53 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
	"Network Development" <netdev@vger.kernel.org>, "Karlsson, Magnus"
	<magnus.karlsson@intel.com>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?=
	<bjorn@kernel.org>, "Sarkar, Tirthendu" <tirthendu.sarkar@intel.com>, "Simon
 Horman" <simon.horman@corigine.com>, Toke
 =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@kernel.org>
Subject: Re: [PATCH v5 bpf-next 10/24] xsk: add new netlink attribute
 dedicated for ZC max frags
Message-ID: <ZLBJbWqT4Ej8bHfx@boxer>
References: <20230706204650.469087-1-maciej.fijalkowski@intel.com>
 <20230706204650.469087-11-maciej.fijalkowski@intel.com>
 <CAADnVQLKDratBrgvwHzXZBW9chH9SBXPhnXpExYwu0BbRVFPjQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLKDratBrgvwHzXZBW9chH9SBXPhnXpExYwu0BbRVFPjQ@mail.gmail.com>
X-ClientProxiedBy: FR2P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::6) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|MN2PR11MB4742:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa9b9dd-bac6-4eee-3704-08db83d33eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZTr33PgbsdvinN8WSztFy8goLV1NqrczFnMLeS98rHyt3L+WtcN3s89Om7cUIjdbCQh5R1mrNrco0c7+upzguKYbF2wae44F3+9LfcJNBq0uqhWodouc3X+wH4QNpXeXWDTT6B7h4Q/q0OouO4Zc70B4gDoNUgVsIWBLSxGAyuVzSIBExOXrlZIiJ9reIctdZzbVVeVXssqy05ASz/aq0Zbvq29CFrugf7YhO8UiLcOG3RLKfqruLZlxCIdV+slY4Mo+8qK4obXfxO72WSlaWcRQTyLVOeoyMF5EHMtVFFHcttRolbXQYhh1qEGmWk9DyxrChahyZd6Y9fBuq4kVwNHoA8bLOPkiAp0pBvCk8OKSHysPCcJYWEzkQCOv8dhemhS5jNSs/+OC7Rndx4iyP4Dh8hlVI1umStBUKvDZ82kFg3g7g8aEzTaa5qIa/imgvbV1P4fPx+XE0Tonzi1Ydd/JTlshRHXrAuxx+W6g+8S6QSuGTnSqfalSIOC31cJuQHtTcFXMGi8MyzW+sSTuihEoiRuVT5VtNy8KTTzz3e+Nb31b0eyaGs++eckIB4B4laPX8t5aU+Ys8ZjZYl0TgdprtklSy/sKN09MQgQFdQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(136003)(396003)(39860400002)(346002)(366004)(451199021)(38100700002)(478600001)(82960400001)(6916009)(4326008)(86362001)(6666004)(6486002)(54906003)(66556008)(66946007)(33716001)(66476007)(6512007)(316002)(83380400001)(41300700001)(53546011)(2906002)(8676002)(8936002)(6506007)(26005)(9686003)(5660300002)(44832011)(186003)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlVjSFNLc3BmMnIrK0hVYlJQTFlEeTMxVkYyUXJPVW11Q3FNZGtOV0FIaWN3?=
 =?utf-8?B?ZnRSR1VQaTB3eTlmVDZoSmZoQlVYMFJZaFc1T0hZYVNQUUttTzdYVkVXcjAx?=
 =?utf-8?B?MUU3UnYxQTFHVE5zTHY3bXljNkpHbEFKTnNXaW90R1ZmeHJsalJXbEtiN0xp?=
 =?utf-8?B?VGpjeFJ6WkNsTTJkY3NBcVMzNGprc1FYSVpEKzRyemdPa05HUk9hL05DcjF3?=
 =?utf-8?B?OWZ5S0pIV1ZERjRNV1o5aGhTaFB6eHRiQ0RkUU1uNS9TalU4bjRCWVlOZzFS?=
 =?utf-8?B?VlhFVDZ5b3pueEtTME5MZGVBY2o1dE1uL1JUczl0Q1NseGFYQlhuaHoxSEd6?=
 =?utf-8?B?cDB4bTQ5Y0NuOHJHRnNYK2ExRk5FQys3RVBJNzMrdzJtUHUyYjVMSXVSOWdq?=
 =?utf-8?B?c2RZUWY4RkQ5cUkxQ1JjUG45cFFZYitKT3Rnb0dFTXd5aTRJTHcrOStpZU5D?=
 =?utf-8?B?YTZXTHR2bEZKUHl5UGhucWRET3lKT2c4cVZuTEFrTUZrUXdFcldES2JKT05H?=
 =?utf-8?B?WmFOK3NVRVF4M1RuTFVGVG0zQ0lUVWRCaDJkWDJKZ2M0M0JzYXBIWDJPOUwr?=
 =?utf-8?B?ZW9BMEVXUVlyUWFobzExVE90N0hIVG0xUTJ0SlorR2JUM3RKKzQ5LzFMbHU5?=
 =?utf-8?B?OGV5OXUxSEhNZVlQSnRwZkV3d0V5aGhVSDhMZXNDMjExOGZvOExKRlcrejRv?=
 =?utf-8?B?ZXVIaGZ6KzVVNDlVRW9WcEdKMVNtOFFRK3oyN1pXUmplVzR2ci8vbE5ET3Vj?=
 =?utf-8?B?dGpKaDdTWHROUm1JVmlwemluL0NSUFBZQlBPU3RTUHdMZjhocHZUYktRemJy?=
 =?utf-8?B?R2c0VVBFdkNUTlhYR091L2RVdCtGUWZ1RU9yclpaWmVHK1FNQUhWS3MrRzBJ?=
 =?utf-8?B?d3BQN2x0UFdOZTBwZVZscDdXSHFOREJtMWJxamxkOUx4bDNCOXNmVkp1OUZC?=
 =?utf-8?B?YysydDhYeitmUE00ang3MTVFWWtCb1dHUFhwdTVVOHAzOC9NN0JheHFsMVhp?=
 =?utf-8?B?d21JeUp3N0FMWVdNMlFPTzhOSFZWS0tqNkQ5MUxEbmhVVVZGYWc0MHZ5ZFRI?=
 =?utf-8?B?R3ZzTjV1ajdjMkEwalhCbFpPajFnRUt3ZEMwVlBSSnkzZjA2RGhCZ0dia1FL?=
 =?utf-8?B?bVpjVENjNVJmTkNGVDQ3MGRNU1k5T21sbmVXY1c5WHhEeFZPbk1RVG1WeWJZ?=
 =?utf-8?B?blBNcVVzM2lWMHp1RkNCaUFkT0Qydmc3V01TQVVQdWRPNlJZQU5BcFBTcnhC?=
 =?utf-8?B?ZDBJT2JCMHRGdU1VakphOGh0Q3pNN0psSWRvU3l3QlBwVENDRTRoS0VydTBD?=
 =?utf-8?B?a0RBUGUvMGNWdktTbE9YeFQ4K2VzTDQzaGEvbkMyV0dmdVNTdG1vTzFtSUpn?=
 =?utf-8?B?Qkx5NHgxZVN5QzlwQ0xoWUovdHRCd3NlOC9ObWcxT054ckdCcGlTeThxdkJS?=
 =?utf-8?B?ZkZ5dXovS0VTWjU2UEtlNzIzUytOWHk0OTdJNVFYN0t3TURFVG9vakJhdjIr?=
 =?utf-8?B?QXR4UitZSi83a0RESVYvckM3MGRFUUxJYVlKbVVrSWZJMHI2SFBGSEx5dnFv?=
 =?utf-8?B?UmptSUJJNDY4bEpFTi90UkhlOHNFSmREeFExbXFGbUNjSjNOSGF6UGtrRXBG?=
 =?utf-8?B?QXA1R1NLSldiQWo3ZUIvUm9ta09JTkwrR3BJVUk1ZGhEcWxmT2s5SmlidUMw?=
 =?utf-8?B?WFJueGgxbE9YMUJOd2hvM0ZHemFJa21iZU8rbUhsOUF1Q1VIYkRDbE5KVWNk?=
 =?utf-8?B?ckk3MjlyTTB4WmRWUjI3OTN0UlJWWFowKzkzWUtyQkpIbjNoSWo0endCRyts?=
 =?utf-8?B?TzlwWkZUSUtreWNpS0JWTGZiNmJZS0RaeiszZm1xQXFSQVArb2I4M01XZWNk?=
 =?utf-8?B?OHYwc0FwRkFhbmxnRCsxOVpnNjYwTjNFelJyTXRheWMrbzZJM2x5TjFlbnlT?=
 =?utf-8?B?SVowYmZIVnYwNHJSL3cwL29OSFRFUGV4V2J3N3RGcUJ6WW83azF3MVkySzRJ?=
 =?utf-8?B?U1RrY0V3UXZDM2t5TXlLb05aSjRVTENEYlJ1TkRnN2d6bXVCYUVFeE00RVJ3?=
 =?utf-8?B?aTVlZlNzczkxTHBFeTdSc2ZMOEtnNG12bEhUcVVzaHdXT2hQbUMxcG4zZUYv?=
 =?utf-8?B?amMwRjhVSGk3ZVlyY3lYdVRjeHNJaXlXVFdpRTdXM1FYMm5EM2FOUnRBUG53?=
 =?utf-8?B?cVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa9b9dd-bac6-4eee-3704-08db83d33eb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 18:59:11.7791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NhmFUDafY3V77vCK55OBy+NeTRuGGyE3vZQ2ED92eyAvw+iJ4rx/2UQ+PQXU5edg3evZWKPR0ydzfVWiCtG5GdV8BNdU6Ew+kbb3BmIciYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4742
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 06:09:28PM -0700, Alexei Starovoitov wrote:
> On Thu, Jul 6, 2023 at 1:47 PM Maciej Fijalkowski
> <maciej.fijalkowski@intel.com> wrote:
> >
> > Introduce new netlink attribute NETDEV_A_DEV_XDP_ZC_MAX_SEGS that will
> > carry maximum fragments that underlying ZC driver is able to handle on
> > TX side. It is going to be included in netlink response only when driver
> > supports ZC. Any value higher than 1 implies multi-buffer ZC support on
> > underlying device.
> >
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> I suspect something in this patch makes XDP bonding test fail.
> See BPF CI.
> 
> I can reproduce the failure locally as well.
> test_progs -t bond
> works without the series and fails with them.

Hi Alexei,

this fails on second bpf_xdp_query() call due to non-zero (?) contents at the
end of bpf_xdp_query_opts struct - currently it looks as following:

$ pahole -C bpf_xdp_query_opts libbpf.so
struct bpf_xdp_query_opts {
	size_t                     sz;                   /*     0     8 */
	__u32                      prog_id;              /*     8     4 */
	__u32                      drv_prog_id;          /*    12     4 */
	__u32                      hw_prog_id;           /*    16     4 */
	__u32                      skb_prog_id;          /*    20     4 */
	__u8                       attach_mode;          /*    24     1 */

	/* XXX 7 bytes hole, try to pack */

	__u64                      feature_flags;        /*    32     8 */
	__u32                      xdp_zc_max_segs;      /*    40     4 */

	/* size: 48, cachelines: 1, members: 8 */
	/* sum members: 37, holes: 1, sum holes: 7 */
	/* padding: 4 */
	/* last cacheline: 48 bytes */
};

Fix is either to move xdp_zc_max_segs up to existing hole or to zero out
struct before bpf_xdp_query() calls, like:

	memset(&query_opts, 0, sizeof(struct bpf_xdp_query_opts));
	query_opts.sz = sizeof(struct bpf_xdp_query_opts);

I am kinda confused as this is happening due to two things. First off
bonding driver sets its xdp_features to NETDEV_XDP_ACT_MASK and in turn
this implies ZC feature enabled which makes xdp_zc_max_segs being included
in the response (it's value is 1 as it's the default).

Then, offsetofend(struct type, type##__last_field) that is used as one of
libbpf_validate_opts() args gives me 40 but bpf_xdp_query_opts::sz has
stored 48, so in the end we go through the last 8 bytes in
libbpf_is_mem_zeroed() and we hit the '1' from xdp_zc_max_segs.

So, (silly) questions:
- why bonding driver defaults to all features enabled?
- why __last_field does not recognize xdp_zc_max_segs at the end?

Besides, I think i'll move xdp_zc_max_segs above to the hole. This fixes
the bonding test for me.

