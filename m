Return-Path: <bpf+bounces-6697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26E76CC11
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 13:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38A4D1C211C4
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8FA6FD8;
	Wed,  2 Aug 2023 11:51:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6F46FC2;
	Wed,  2 Aug 2023 11:51:34 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E89A6271B;
	Wed,  2 Aug 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690977093; x=1722513093;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=andfEbBY9dYRDlppJ3oSW/i+KmOU+VBS5KW7TfXjxmU=;
  b=fZrRQNtdojJtPzliHNSvUz1PFG8RLb+DegYOP/blyxD1rViogMbCfMvE
   1zvhMCqgKrPr8Thpis25rynf3I3r8M1S8kgIiwDBE/00WtAAMZsavkoDF
   DJlYR8h1LvV/tHzU3QvwJtkZmUwJR4Bz5SK1jyo05thRfcZNfJNI6glk9
   vnjk71Whz4nWm9FHATgTQLRrfQmDJs1uHj4+tAMZJ8+2wLHW+Roax8Gjw
   MmXKM+2WIO7noY2oHvPCHz8JwluPBVocJ4g2admBe+kWm/SfZUsoBnRl6
   MvKEBYsXq2s4NXGr/hbxTW56+hMXZCHIcSagbAgE0aw7/Y2lLfts9pm5k
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="433396650"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="433396650"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 04:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="758725305"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="758725305"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2023 04:51:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 04:51:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 04:51:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 04:51:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 04:51:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFJbxusyWn3+HhLm/DwEweppLGnjtld7mPQEuuHGH7mqSBanP7iIFHPFQuT9mh0I8tCZ+ytdpl+GmwN8Ia95QiM3E7Iow85xhZvDb6i82n6sYBCypkl9A4vOkw7JtQ3yX9pb+DIGveX3H0uwPQrkdTL8XOUm7p78Wak2zBcjB+UOAXWw7ywmiONgXkCidFIwysv7qL8UuasMmBIsLTwNbTXYJ3VI03OdAjoELGC79Ds9LuqQB08z6NL92L6sPSKobzvUPYh0wRotS/d7+A0H+9A31RAH4Tz6IEHlkJfMrGieA6DBXwmnS+Y+whGx/ohdsugiqThkchStu/3vyKiApw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RKhp4r98ni1/RVQ9RFyqHDhTb8I1SlvT9skHiJii1fE=;
 b=jSOu2JgSwGd0sAs/WaXVFGUwWTkaB8J87hL8ce7mord40ijCktKNMTL+exD68J7SLwHgWc7+sHGKV3n+eUpLT/+LI33RT0cXu0V17PlQmUgyg4Bs7MbSbsWZtlXSqAAjcfOfCwACV5FGi44939LlLPYgYLtfGCv81J9mVr0JgXudznlPG5kbxsXuTdERD5D8QdU4zoqk8xRcjRmQZJpfH5ZyhbL8UbPYu40ZR928JqynkrZ9QbnrzNaLczTv/jsJmXJihb3YcdkLWIgP+7x1zfmCyH0Xk3mRRMptv+s4a7CbF6h2/ylGqbGb3+X3/UonVgkQQfoE24JyY3Hs92l/lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6468.namprd11.prod.outlook.com (2603:10b6:208:3a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 11:51:27 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2e3b:2384:e6ce:698a%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 11:51:27 +0000
Date: Wed, 2 Aug 2023 13:46:31 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <shenwei.wang@nxp.com>, <xiaoning.wang@nxp.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>, <linux-imx@nxp.com>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH V3 net-next] net: fec: add XDP_TX feature support
Message-ID: <ZMpCFzuuN3dEljKE@lincoln>
References: <20230731060025.3117343-1-wei.fang@nxp.com>
 <ZMkl6HUYMGWXj87P@lincoln>
 <20230801125136.5d57e3ad@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230801125136.5d57e3ad@kernel.org>
X-ClientProxiedBy: FR2P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::19) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e70e97f-6e78-48da-5278-08db934ecd6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FPvu0iaXSBFrFOb37Xi9tB5+RXagG7/7C7rCGosH+LwDvPT+b0oda0+6ASSVzzqiQ8jBlNMviehwDkyATndi+080ZWrgBrWRTv49VvneN5vtqfRKO0ytY+Vr7cHHB7cpEacxKgXBKjDT69Y1jmWhnIbz2p6Y5HFq6hSZk7f1cKPc75gfTF6A0SahUw6LzaDyQBeIfRJuUiLKijDDW+pWgCZLtCVm2MEm7Im9H6bSFaN3LrHH5sm1AlFAdAfZ0gYdf7lBNov24W7CF66z1mbt7LVdecq/bMGWJP0PNHz/GoK9nxq/BLqJ/f8MsYEQn7bZVMpPZxy4oy5Uq2P1FFdYxcyUX3ttixgFoeQ6qhU5Ls6dT/lgMAXBtou2dRp23LMRDl5IxzFbDbfhiuB8OW+RxnK/Kbkn3ctuJhKXuNFGaaDbt0bhs3INTrb7GIfEkv8Jdhfw2ErWB84W0ehbTmBxii7ji7CescA4iieEItbonEkgdsCa2cAREEZ6Ajd050DGZFQ2N5et0NB/uUS+yv4bhHASce6HqodrLba5Ka1St7sWmJEFZwcCss9ejCuBYimu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(366004)(136003)(346002)(396003)(451199021)(5660300002)(82960400001)(4744005)(38100700002)(2906002)(7416002)(478600001)(44832011)(26005)(186003)(6506007)(8936002)(8676002)(6512007)(9686003)(6666004)(41300700001)(6486002)(86362001)(6916009)(66946007)(66556008)(66476007)(4326008)(316002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x6Hwvel2lR7+LMqEPqcziWV9uhi2knlMsIWatvszT8p2L7402iFilHbJxkCm?=
 =?us-ascii?Q?6pbOQ+y3aZqAkYUM4Uxfo9UQ5RdZkmn4eH69eJq+H6d7wl9P5iUYl3t9P8OP?=
 =?us-ascii?Q?phf+cLupjjB7OQxFvaGTUTfA64zV/XBM0e/oA7F5cXTp1WXE44QKzGvCfXE8?=
 =?us-ascii?Q?VgbX5dibT8yVmmXAFRcjTGzCGXDREtnfqyIF1/qSsfZZc/fhRok4hHzo++gT?=
 =?us-ascii?Q?necc5SHpR2pY8B82yqorHWPOgW+PFBLnjb8NyGjcoIdW33WDa21DSGlN8j2x?=
 =?us-ascii?Q?GsEsYldfJy1zX5L52JCW1GJWnKB/GjsO9I02tOGRy5X5B11QNDy4OzGVk3QN?=
 =?us-ascii?Q?zhSqTZmzETS2/R6Z6HwbI0XSSxD6xnfItrkHKSeTuaIHY0NXrkiSJGzqeDHi?=
 =?us-ascii?Q?BN/MbcMkd2HCP62cz9ywhwLlPBMqVGaOhj87ezD22gKsR3pEEHjhLnNS62Du?=
 =?us-ascii?Q?e8VNhaNNKiEq+52AYECq8PM550+qjI7p7drWi8jBq48MU0YKskMtGQF1f4Lz?=
 =?us-ascii?Q?8oEIgRAyfcffORzk36k0ns1RNVymvX2m+nY9XM0t09oUztrk8K9rcI1+NgWO?=
 =?us-ascii?Q?j3DiPdIMQeSLsEET+oDDUw9pYd7D/WY/HGo+kPZIRa8mUap4xEnlIdMhBNO6?=
 =?us-ascii?Q?aQHruN6MyAXdXXL3dsxM/ARwbyq2q+nagfGU1OgmTTQl+a3bRBh2+I8ilB31?=
 =?us-ascii?Q?FRLA6+h5342a5saJvIHlUr/FESeMN9dXgrQdIhubszN3QeeFAY6cPtvZ9U37?=
 =?us-ascii?Q?ZQeDYZz/E7/LAiV6g/qUnWlsnedOQhrc7MV6LWmn6MJrcZYJpsoDmyMlfvjO?=
 =?us-ascii?Q?DNVX7R7nIyw9hAlwCLP7ZnEdR3FfOsDUmLfH371FGKrx/8Lj8o3sfGQT1bv9?=
 =?us-ascii?Q?G2i0uV+6bMPCRi1p98SM3MTjadOrWa+PQXsZfW/IEhAevGvXiS+qlzOpjJo2?=
 =?us-ascii?Q?TuDRdhw4bRiHKPBiCPnrB5e47ghVTs+tLG/KUKpgymrU/GBLP6Am3ntystQS?=
 =?us-ascii?Q?NR+b6kKKVG4FDj148LEvueDjmfssI6ob4oXrp5uUOI1Kv2qPR9fbZlQSgiVn?=
 =?us-ascii?Q?IzdScueimDEZeoaV/eJtLE1vBbX5jPjLGGSad31aXDCuxYm3cD/UaOSiRW1b?=
 =?us-ascii?Q?0rdkI/I0cNUO3tKOhOwKbXYqILCDHKH4DqrWXNqkI6epAYi2JgTjS/6vqJ5E?=
 =?us-ascii?Q?jQfB60uC0C/TF/Fbx9TfrVJSn41HnWBnJw2wMh/pBhAdwEcD8PiGJZDZx4dV?=
 =?us-ascii?Q?JlO2p7/4GyxdsyOf0yVbsu3nicRXBdCH7Qcoq1kJ4ZSaCSOIJ7yPFO5EYoS8?=
 =?us-ascii?Q?0vVDAS/k2OhbcTcyAXMrqfnbMvlIhb6CiBewEqW2HGtRQXnLNDGfJ9mdnKis?=
 =?us-ascii?Q?7xM9c4PoS+R6j/Dq9nnyPgSmGQff98AnzAFX7AFRgh37uM95/ErWYLgesKct?=
 =?us-ascii?Q?qIQUnriXYWG6U8GmB1L2hvy4UvysSr1wJlQ3+4L9BuS5CaE7nbU1nElzBpga?=
 =?us-ascii?Q?IdleDdsOZ5MvubDE06TniomyWKrMl5NtJKBGNlhgPT+9rn8u+rDfssmqYsKZ?=
 =?us-ascii?Q?wR02xkLIKL773NWZ4IxId/S+RJ+cH0HrQx7jqKFrPW70PmTgAMEXH6dE7sRg?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e70e97f-6e78-48da-5278-08db934ecd6e
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 11:51:27.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7vOulDju4CAez10mkvt8xH7aTI7mgRWZzi99f/KNc82oxSMt90HpDOcRLRvJvl82QAZsV0gQ950s9TEs3Tlyg7qUE6eZrsGCa2GJRY762Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6468
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 01, 2023 at 12:51:36PM -0700, Jakub Kicinski wrote:
> On Tue, 1 Aug 2023 17:34:00 +0200 Larysa Zaremba wrote:
> > But I thought XDP-related code should go to bpf-next :/
> > Could somebody clarify this?
> 
> AFAIU pure driver XDP implementations end up flowing directly into
> net-next most of the time. If there are core changes or new API
> additions in the series - that's when bpf-next becomes important.
> 
Thanks for the explanation!

