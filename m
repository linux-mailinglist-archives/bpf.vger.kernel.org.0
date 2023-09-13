Return-Path: <bpf+bounces-9936-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 808BE79ED97
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 631CF1C20E9D
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DF41F945;
	Wed, 13 Sep 2023 15:46:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D601F924;
	Wed, 13 Sep 2023 15:46:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886F293;
	Wed, 13 Sep 2023 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694619974; x=1726155974;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=Sl6I6wh4ny4OhNsnxmMRQ6RHZniNWpXoQRWYNJs+LrQ=;
  b=dqibRfBlI5bclPhMjV8OwbSJaj3kmU+HbmLjY51oIjaJYvJUqC0L4La/
   jCDcGQm32yJSZ2E+ryH9LuWo1qI7P0ezW5k42KdGM0iECK7WlJynhwztP
   c1KvzX/DigkTuv48ZJlkKLdJ9ME68CzCFWRVfIQpYKehvc098Q6WX6E1S
   ddQVP3ElbSpyEJEHVLep6ydSIFc2Gg3WKmQyPw5IgXHyCNvd72y+mQCRF
   2kBj7MAhYEPMdIQXxj0jynb9DhU8Tcpn+Hssu5Qfe3FHohSub4aHLXxo0
   f/ZS9ocaE6+ZMEmdFt8HpjcaMBAgaTP+yRb9cCfwlDBbV9is2hsMqKv0f
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="358131021"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358131021"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="773508195"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="773508195"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:46:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:46:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:46:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:46:01 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:46:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ojk9OT1tgfXcKuOeJHXOiEcKOEwtc02ZAv/BdqFCZVBhYqmsih3DLP13rFt4UA7M19fuxxIgct2c7YYmGut27S1RBeZCjFAd+LXxSdLGZChWaXzgdcWWU/9rqgA4z6LGSRbVIhM8qI34pwUxaZcJjq4SUTX8DGP89h5chlIWvAI3xMrTe6qd4TvMPLhGCCbZt+ejM3VDLoeYoQw2GOElMTw7dtX0oJrkp5ms+NgdBKGHh1yEwXZ7YxTNHTKdubRTYYfaJkTz4aA2QRRD/gUC9aK14eosfm7kd8TD+EiWQ18MutpT+IQxxtEtavgMhkTkhKbngjYzu16TyCOdD/TqBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1fSttFxzw4wu/Yj3msPWE+Ro6I116/Ambz/6AOcTl4=;
 b=EC1aX0xXTZFuQJ8gtNSen4rdQzFQCCF1cDmmtYeR3pnpgnwRzfcDxmLFn0xJklgK+qzWM8FNL3gJojfc3Qd/Tj0W+2pialCec53j/ZA/NWLT5nsWX/ILNmXqgtyl10cdWEMowc3ivq4th4QiXmCv7yp6lWvr/pOmr0AgfQT1MkJShtTYJSdu6PmFzLI8V6WvX2IZyjn0xcF67+dDOGcVjoMF7dCkdJLrScP78EATYtAB6v7FLX63aGXBnLE6xaDa/JrIEBWKZ6trLowteMD0Eu+kAizV+MmiDy/QXO9nwxVKOGbQoH/SD3VXJBuZz/YHZcT68c58jXGrLbogLcyS3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Wed, 13 Sep
 2023 15:45:58 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:45:58 +0000
Date: Wed, 13 Sep 2023 17:40:24 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Stanislav Fomichev <sdf@google.com>, <bpf@vger.kernel.org>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
	<martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, "Jesper Dangaard
 Brouer" <brouer@redhat.com>, Anatoly Burakov <anatoly.burakov@intel.com>,
	Alexander Lobakin <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 05/23] ice: Introduce ice_xdp_buff
Message-ID: <ZQHX6DN0jjBGC6dG@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <20230824192703.712881-6-larysa.zaremba@intel.com>
 <ZPX4ftTJiJ+Ibbdd@boxer>
 <ZPYdve6E467wewgP@lincoln>
 <ZPdq/7oDhwKu8KFF@boxer>
 <ZPncfkACKhPFU0PU@lincoln>
 <CAKH8qBuzgtJj=OKMdsxEkyML36VsAuZpcrsXcyqjdKXSJCBq=Q@mail.gmail.com>
 <ZPn9eRofEv3guPLj@boxer>
 <ZPn9zgnItkkVfpu/@boxer>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZPn9zgnItkkVfpu/@boxer>
X-ClientProxiedBy: BE1P281CA0249.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8b::11) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS0PR11MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a7cd38e-e9a7-4de5-03eb-08dbb470860b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ogxkz1OFuQtOnVn2hxBgM+Jikf+qaX/h71JdVs0U8qu+T0VdwvLyEDKFAHA79oyLkoz1gy8b71r0VaFehj6DH54U44FzrlNUtVAPA5yimXxp/CuUjep4F5FyxzrWjH0oI7Pz0JqiawhD7Y2Ju9CXJBVMUC/PpPyWjquuPw3m+5JCVUyp3lOX5BSBa+Lrxrd57TaCDu4SSr8kSoh86+8i/tjPh5ZXAFV2YQRVdjgGUfVmcgdjnNAMg8Uvqem5vFl0RTZdZOs5g+wh+x91PyaV/hdiD59qVqfWHpgvbsEUOMkhc2YZZxy1haB2M5Y8Tv0Avd8GCzcDvsfUO59yExjSQ9PYtEHXWBwh16ye3yQXvtnnyFy+JeZGkGhtmtunnvQ4nPuDQNwBHDfLYpLGYl2Fnglt+ZlFXIK81+IO1AXqeXyxNTApsSVHf9JdE1xw9w8wnGSKEZOVNIPJEOdv/X+eli15aGLON7zAavn2AzdoCKhBxT6ZOtNC1YY6mjVLClA8Iy9y21n0M0wsuafVV3WYPKZWV9AeWoqUpH2/WK+PuTM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(41300700001)(66946007)(54906003)(66476007)(66556008)(6636002)(316002)(82960400001)(478600001)(966005)(38100700002)(7416002)(33716001)(86362001)(2906002)(5660300002)(44832011)(4326008)(6862004)(26005)(8676002)(8936002)(6506007)(83380400001)(53546011)(6512007)(6486002)(9686003)(6666004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NktMTlNIa2lKRDF0Rm4yMXBHY0U4YnQ1SzlFZVVZN2NacUFBQ1lXVWZDT0xE?=
 =?utf-8?B?bk9PYS9QUHgxR1ZjREY0R1R1WmlnTUlhN2Z1RGdLS2tqTDhFRElNS05lNHJw?=
 =?utf-8?B?VW5BK2JCenJ3cE9PTC9jc0R3bUpwbmtudG9UZVVMd0luTDVJSVpNL0hBMmxm?=
 =?utf-8?B?UGdSNG1wY0RwUkQzR1Nsa1RRYUVNZTNjWW5rK3U3Y3gxQ3M3ZXUzTEFOQzVk?=
 =?utf-8?B?N0UrRnVGZ0llYnI1NG5USDBIbFllWjh0anFydjVFMSt0ZS9zM1ZOcWgxemFk?=
 =?utf-8?B?UHhMT05xV1FRZkovZ3luOTAvcUVpVnVzc0psSWt2RUp3bVhJZXRCaHpValQ4?=
 =?utf-8?B?SXdHSHJ1RktmczdWcUVHeEpFQVIyWW1CQXdiR2tnUUcxblZIb0ZzclJFdG1l?=
 =?utf-8?B?OTlaeEgxaWJQbmhnY3RXVzl1YXVtUWhoM2FWOU5IRjg0OTQ2ZWdCRlR6OVp1?=
 =?utf-8?B?Y3gwTUJMc1ZkYVlhclE0d2phQ1JjTFFEdU1jcnpwWHRIQUZ6M1o5cEh3RmlS?=
 =?utf-8?B?U3Zab2ZzbjRpMzhvUHdXUEV1RUpFYmRWN0FBQjZPWnJocU5OOE9zd3RKU3k4?=
 =?utf-8?B?MDF0NHJORzBJQld3a01uZFBDd1hOaFhOaUxaQzQrdWtlemFqeXhjbHFrdW5l?=
 =?utf-8?B?b21Da0tHRWttblpVMmV4Y2hkTWtBY3ZIUE1kTUNwOU9SQ1NwSHM0OFhUS0Vo?=
 =?utf-8?B?R3pqVW8wSDZvNlRERElKbHVFM3p4MFJ0YnVhSTJKTHp2SndKbkhjTUYvOSsz?=
 =?utf-8?B?RWdMRHRJT0pEM2pEbHNhczFhVkNack0vMlAzSTN1MGFvbFF6UkJJSVR0bnRW?=
 =?utf-8?B?QnlRVk5MY3NFZzBkS2dINkU3MDNBS1NrLy9BU29KYitMU0dnM0RwcVNwejgw?=
 =?utf-8?B?VS80TjlqQVZkVTFyaUZybW90L0plOFVQRVRWOFRVL3ZKMytiRlNtbmVvQnVp?=
 =?utf-8?B?SzFGQUhRS0xlbVladGV2SE4yRUJFTXNmVGxFcm5vVGF0a3BTalJuRGNOVXlu?=
 =?utf-8?B?ZFRZVzlmTjBPRStJanQzYlV1L3hEd0lRbExicVUwcWliTTEybzJmbnl1eG15?=
 =?utf-8?B?VVlPTXdpS1pFRmIwZHdobVAwRm9yLzd0T0w4dXRBemh3RFU2NWtQSEsrcVlD?=
 =?utf-8?B?QVdkSFFqTVlONkx0ckl2VkZNRVhxVW5QQXhLM3VaUG5VbDdKTnF4dEVEczg4?=
 =?utf-8?B?UEtERFFXRGpia1FpK3Bjb0pEdGUzOFluRjhXWXVvUWpoL1Z6RTJtaVNDekZI?=
 =?utf-8?B?TlhqZm9WZnFvWEhLazEzSzFYbStNUS84RUFaNVNnTFpuNUVNOXJDa1JIVjBJ?=
 =?utf-8?B?cFMwRlVNQXFPS2ZBdnRSYUR4dXkvbHlEbDY2TStYRm1YR09Ua3AwenRkcXZj?=
 =?utf-8?B?WDNhUXhkNFlKL0Nza3hkME1VdWRIS2QzN2hReTJmR3ZwbG9Sa082eTBXclp0?=
 =?utf-8?B?ZmhVNnBZdzBwc0JVMk9vRlB4ZUdUeXdOeXZTVDgzUHBXTEVubHpTTHd2V0No?=
 =?utf-8?B?VnZKOFUrcDBwejUvWXYzR2FLWmpEamV6MVJ3V3ZZNlgyellCRXdBOEhMSzI3?=
 =?utf-8?B?M0VUYmF3NUROOXJicWdmWWlaQS85dXE4QjY3OUN6NTV5OWNBTzdGRFRmZ0Q5?=
 =?utf-8?B?c0RNRXJQb0xFM0k5U0prbkhCVjBzOUZHQUVXVW9LbEZ2SW1UdVRoNDY2TnBo?=
 =?utf-8?B?UzlvSnVHNU9QKzZzNnJJaUlIczRXUWJ4Q2xRYkxGTGVlRVpWUEFGbFVBdWNZ?=
 =?utf-8?B?aW8zZnBxQkV1akRNM1ZYRFZZcXFvTjBZMi9vY1EwQzJGL3VTZnVoY2NLLzky?=
 =?utf-8?B?emxBZTBRUWx2RDVhRXNOcXlEVlRWTWhBMHhJZW11bU5qR0x6L2E1RVBUUEtE?=
 =?utf-8?B?SEx5RTdrOGRRVTY0Vm9haXZnTmlnL2F5REh5M2dEY1BvUzNxWHJHci9yNnJl?=
 =?utf-8?B?ekxxVjBhUmV5aEgxYTBST2h0bWhzaGZURUlNWlZxcDFKTi9WME1Pb3Ryc2pv?=
 =?utf-8?B?UTlVWTdFSGU3bXlyYUFWSElBMkFxVjNIdHpjaVRlQXJzcFF5YUE3ejdnREQ4?=
 =?utf-8?B?d3AzTFdFem8vVENsb1ZiN2xETXRUM3JDTllIdFFRRk1qeUVYR2haaHlHUDN2?=
 =?utf-8?B?TytPLzZzTkpjOE0waW5HV2ozdnphME9QR2tGVXFxbm45QU14TUFBNGlKYy9F?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7cd38e-e9a7-4de5-03eb-08dbb470860b
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 15:45:58.3212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HkPlqVq6oQ6MqI+5bFaoY/94b0DykgYRXGGXdaWJSUtqOxgLo5iN5SpNljSrCB5vy5GeRwhDHdB6Y0bMAE+TERalZGxp/Zae7CfkR0AKhSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7971
X-OriginatorOrg: intel.com

On Thu, Sep 07, 2023 at 06:43:58PM +0200, Maciej Fijalkowski wrote:
> On Thu, Sep 07, 2023 at 06:42:33PM +0200, Maciej Fijalkowski wrote:
> > On Thu, Sep 07, 2023 at 09:33:14AM -0700, Stanislav Fomichev wrote:
> > > On Thu, Sep 7, 2023 at 7:27 AM Larysa Zaremba <larysa.zaremba@intel.com> wrote:
> > > >
> > > > On Tue, Sep 05, 2023 at 07:53:03PM +0200, Maciej Fijalkowski wrote:
> > > > > On Mon, Sep 04, 2023 at 08:11:09PM +0200, Larysa Zaremba wrote:
> > > > > > On Mon, Sep 04, 2023 at 05:32:14PM +0200, Maciej Fijalkowski wrote:
> > > > > > > On Thu, Aug 24, 2023 at 09:26:44PM +0200, Larysa Zaremba wrote:
> > > > > > > > In order to use XDP hints via kfuncs we need to put
> > > > > > > > RX descriptor and ring pointers just next to xdp_buff.
> > > > > > > > Same as in hints implementations in other drivers, we achieve
> > > > > > > > this through putting xdp_buff into a child structure.
> > > > > > >
> > > > > > > Don't you mean a parent struct? xdp_buff will be 'child' of ice_xdp_buff
> > > > > > > if i'm reading this right.
> > > > > > >
> > > > > >
> > > > > > ice_xdp_buff is a child in terms of inheritance (pointer to ice_xdp_buff could
> > > > > > replace pointer to xdp_buff, but not in reverse).
> > > > > >
> > > > > > > >
> > > > > > > > Currently, xdp_buff is stored in the ring structure,
> > > > > > > > so replace it with union that includes child structure.
> > > > > > > > This way enough memory is available while existing XDP code
> > > > > > > > remains isolated from hints.
> > > > > > > >
> > > > > > > > Minimum size of the new child structure (ice_xdp_buff) is exactly
> > > > > > > > 64 bytes (single cache line). To place it at the start of a cache line,
> > > > > > > > move 'next' field from CL1 to CL3, as it isn't used often. This still
> > > > > > > > leaves 128 bits available in CL3 for packet context extensions.
> > > > > > >
> > > > > > > I believe ice_xdp_buff will be beefed up in later patches, so what is the
> > > > > > > point of moving 'next' ? We won't be able to keep ice_xdp_buff in a single
> > > > > > > CL anyway.
> > > > > > >
> > > > > >
> > > > > > It is to at least keep xdp_buff and descriptor pointer (used for every hint) in
> > > > > > a single CL, other fields are situational.
> > > > >
> > > > > Right, something must be moved...still, would be good to see perf
> > > > > before/after :)
> > > > >
> > > > > >
> > > > > > > >
> > > > > > > > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.c     |  7 +++--
> > > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx.h     | 26 ++++++++++++++++---
> > > > > > > >  drivers/net/ethernet/intel/ice/ice_txrx_lib.h | 10 +++++++
> > > > > > > >  3 files changed, 38 insertions(+), 5 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > > index 40f2f6dabb81..4e6546d9cf85 100644
> > > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > > > > > > > @@ -557,13 +557,14 @@ ice_rx_frame_truesize(struct ice_rx_ring *rx_ring, const unsigned int size)
> > > > > > > >   * @xdp_prog: XDP program to run
> > > > > > > >   * @xdp_ring: ring to be used for XDP_TX action
> > > > > > > >   * @rx_buf: Rx buffer to store the XDP action
> > > > > > > > + * @eop_desc: Last descriptor in packet to read metadata from
> > > > > > > >   *
> > > > > > > >   * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
> > > > > > > >   */
> > > > > > > >  static void
> > > > > > > >  ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > > > >             struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
> > > > > > > > -           struct ice_rx_buf *rx_buf)
> > > > > > > > +           struct ice_rx_buf *rx_buf, union ice_32b_rx_flex_desc *eop_desc)
> > > > > > > >  {
> > > > > > > >         unsigned int ret = ICE_XDP_PASS;
> > > > > > > >         u32 act;
> > > > > > > > @@ -571,6 +572,8 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
> > > > > > > >         if (!xdp_prog)
> > > > > > > >                 goto exit;
> > > > > > > >
> > > > > > > > +       ice_xdp_meta_set_desc(xdp, eop_desc);
> > > > > > >
> > > > > > > I am currently not sure if for multi-buffer case HW repeats all the
> > > > > > > necessary info within each descriptor for every frag? IOW shouldn't you be
> > > > > > > using the ice_rx_ring::first_desc?
> > > > > > >
> > > > > > > Would be good to test hints for mbuf case for sure.
> > > > > > >
> > > > > >
> > > > > > In the skb path, we take metadata from the last descriptor only, so this should
> > > > > > be fine. Really worth testing with mbuf though.
> > > >
> > > > I retract my promise to test this with mbuf, as for now hints and mbuf are not
> > > > supposed to go together [0].
> > > 
> > > Hm, I don't think it's intentional. I don't see why mbuf and hints
> > > can't coexist.
> > 
> > They should coexist, xdp mbuf support is an integral part of driver as we
> > know:)
> > 
> > > Anything pops into your mind? Otherwise, can change that mask to be
> > > ~(BPF_F_XDP_DEV_BOUND_ONLY|BPF_F_XDP_HAS_FRAGS) as part of the series
> > > (or separately, up to you).
> > 
> > +1
> 
> IMHO that should be a standalone patch.
>

Sorry for not answering, I was stuck in testing and debugging, wanted to come 
back with a definitive answer. Fortunately, the problems were not caused by
hints and mbuf clashing on some fundamental level, everything works now, so I 
will send the patch that allows to combine them tomorrow.

> > 
> > > 
> > > > Making sure they can co-exist peacefully can be a topic for another series.
> > > > For now I just can just say with high confidence that in case of multi-buffer
> > > > frames, we do have all the supported metadata in the EoP descriptor.
> > > >
> > > > [0] https://elixir.bootlin.com/linux/v6.5.2/source/kernel/bpf/offload.c#L234
> > > >
> > > > >
> > > > > Ok, thanks!
> > > > >
> > > 

