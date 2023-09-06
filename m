Return-Path: <bpf+bounces-9336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4639A793E99
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 16:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 708E51C20AEC
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB0C107AD;
	Wed,  6 Sep 2023 14:18:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A895D513;
	Wed,  6 Sep 2023 14:18:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D291710D5;
	Wed,  6 Sep 2023 07:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694009912; x=1725545912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LougLevJKfX93euw/aixI39zK/pmyR+MMsS0sddzAGU=;
  b=kGEMEhH8HCaO3TCjeRY43TuPlANS/hfjvXUW/eeoCoy6eZO/giO9fl6/
   L09XwDYAItPy335J+5ff9ZsaV/cb84CKLi4Q3FAY+qYzYTTPW4wA9gUtF
   R1gZNutneZ761CYeW42UIZat0Ywf5uWxRyXUKDrZdRuMx4Kp6UrJOPlMt
   TrBYTeDRc1H8XxDaiO1ASa7nasZNxT2F9iwzovWWURu5ZlMpuf5qNqbwZ
   V6DscWvGrkYRJxS30Kkj2FlLZU/npQ10seMeqeXNZlQrkYHfSAvpEo03Z
   P/u2Ppiv3PfXEbmWhz6OcvhB92qlqH20I9R1snQ7/YU9lzIl/uAkIN9MC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="441051927"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="441051927"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 07:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="811673312"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="811673312"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 07:18:31 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 07:18:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 07:18:30 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 07:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAJoHn1i3FZBPZ4KyE+1EfZc+o8txPBn1ihkE5qR8/tBWGyX1ckmaDorwz58mNOHCvK7SwrjF9XlfFTlAqUykZfIZzmyysXh0NoAe2Gq1QI6LaNBfx3TsN1aNQVmRn94V435n6puDtBPf85+FAQGZeONA3Cn5hxwEZYuUFstXQOG/uYBlUWdX+5/WooTWLTrSJjv9dFa0at+lsPbT48MxXKfzUMcb4P3gw9vVbXKswPrUiger+vBRlOm7jS6azfltVyo/6bUmWU1LbjGUKmHLn5bsulIdqXU+A7P7004M4NFPYxvglWOSEXqZF4kljgg2y597PMei2dy5i4uVDbNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxQrzG3qji5zZ621N/DZ0PKjYTgpkm7da0B2fY6rf9M=;
 b=Ehu2VQgc9BBBPDZ5niXvBQFhdL8FUGx0Oq9kFR5kxykQhLFw2yFQiBpPYeDO4o8TQ9CZf7lCRRmF9hPZ/HB5s/AFOzDtP8hYKplE1w74afqF/1s+4dVY15PO3ixwtupFtfCekbJzNK3IBBHPfVywU/5QUBCw5VxfsYQWAeSYZOyfDFM2O5aGYBopFfy0jEsWTyVoibsrw9bv4LLgzEUCTSErkTwSt3lHwKIt2XDFJqh+gHeWjBKklfdmyj8KjO+bEoaHbjpnDkmzmZR3Q84nlBCHlMeyZAH4s7pamLMlUJbfjum24NoAYtOif07UUD8xoZwK2mTlS8ZEqodg8B+uRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Wed, 6 Sep
 2023 14:18:25 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::10f1:d83:9ee2:bf5d%3]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 14:18:25 +0000
Date: Wed, 6 Sep 2023 16:09:52 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>,
	Jesper Dangaard Brouer <brouer@redhat.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [xdp-hints] [RFC bpf-next 00/23] XDP metadata via kfuncs for ice
 + mlx5
Message-ID: <ZPiIMPKDEadvX2oI@lincoln>
References: <20230824192703.712881-1-larysa.zaremba@intel.com>
 <ZPYAm9oq0SZ7VEvO@boxer>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZPYAm9oq0SZ7VEvO@boxer>
X-ClientProxiedBy: DB8PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:10:a0::36) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB5984:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d9834a-33aa-4012-e368-08dbaee420e7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j95s0fdno32wEKwN+uBzAYBiOntN4CIR166TdCOCN9sv8koKk7/rLtAymZz14/VDvjZ6Fj3vcJQcEznjFOIa9dSO9PjcXP4TAdNm7RMo94mZFan4wHh0wm0Xj+okk/iVFGl8aHKCQ5rhzYFJWNSbIQRIisEO7fjrc+VfqSDjPDm18QCHi52cJD25Nn8jElcUs/SptcDBwdM+hSe5EyAUtuy2HNJnIaQMJ4w+Y8Syev7VvuSLTpZWsNKx9MD7rzVkgF4nc196EomW4lEDdTY3jripICEZbFLTSf9Klxxr4roz5tPn7lCH6BZmtwQ6gu4rw5lWRmNFSVIsTpmvoLPvkErJgAzSwP6/oWEncWj0w5Np2HTh2hYVXAqecNqGvZYFGocYvRolstReebBQ0s3wiV2QNUTKVp4L45COPiPqx711VhbbcAY+Aj3lgPfH/l599cuH0wikBeJlO/5NeyOlAFhrLmiidZmckH6E/6ZQbLjO2gGUyoBBoFczh71zZRkPc8VZdYQzf4LbPWK+4sILV8aL76ZBkilBK8JFVq5WAR1h2CImedHv6TftSl6z26tx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199024)(1800799009)(186009)(8676002)(5660300002)(6862004)(316002)(66556008)(2906002)(54906003)(66946007)(66476007)(6636002)(8936002)(4326008)(44832011)(7416002)(41300700001)(6486002)(6506007)(9686003)(6512007)(26005)(33716001)(6666004)(82960400001)(86362001)(478600001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQTz4ZHQe6nNu0Md+o+1IDvWN1iqJZfYanDVkjnVPaibhqVVrMwAp/d6VcJh?=
 =?us-ascii?Q?m63FyjPm4V8nIJIyEJSvqlViWQ+kuMfk4Qz3c3+4wdtIzIE8syVnp7NygI52?=
 =?us-ascii?Q?BWynwS6oexjI++kQ6PRi34R+5dvJjx1hvM0ulmxCSjC1jwrSoSLodBi18cSN?=
 =?us-ascii?Q?R4/17ysastJRgHj6Z+q+xh+DRZG1FzXDMsHId97NJ4AWnVeef+LfffJGSSNU?=
 =?us-ascii?Q?eXHg/N/uizdtXcinxSuarsQXFdGU63pP8HIDAdQzNLlpTzzgLaK9g5iKE5c7?=
 =?us-ascii?Q?1ddv0ADOamqgznSLYhqaY4m/CyNKa1vtWb6rueY34nreKQWx/uM/u3cA1PrG?=
 =?us-ascii?Q?KA8k2wkjlEqdAoQsnQwYy6SaHtsJFjBOloh/VqlNBPt3dtTMd0KzbHgNtekr?=
 =?us-ascii?Q?71mlTplOOfc0r1GZM5b2kFa3p42SAZ1RD8kQE+nP2Z6h+ttRs0qWBehzEn99?=
 =?us-ascii?Q?X3Sz/ZmKlp8Z+IxliogSJM3Yg/v64jEsj1nk8IZHNY0N8AF6s5NXe1uJMda1?=
 =?us-ascii?Q?SXbVyUh5PAPHFpmGaXlFlwgOleLqHigNk/P0wmXzTL5iqHfl0gUIEywb+Yny?=
 =?us-ascii?Q?CQ3ZOdOWwMNHVQQ2Ky1XH8ajpmkK/+VDxZnZSAwVsIs4ojxgKJ15/CYgEtBO?=
 =?us-ascii?Q?rjQxnMzXjHkvI8K81Bzw/yqtaI8/3LbkAM1ds2fNpIdxy9YorGWYzIJt/QOK?=
 =?us-ascii?Q?6nNSVLdQls+HNp3fYHUbham+hAQIWiMeEcizG7sDpClxgd1BVvbxilcqc7jC?=
 =?us-ascii?Q?gsXsFLcm44cYrNXgVJt2vAtWUvbqWpz0oDFtSJzzOol6l/GsfNo5q2Yu6GnI?=
 =?us-ascii?Q?A/Fc3QqWOht3pet++olA0SFdlEk5OPxaNmrkALLcKZ+WBCcR9Is3O/o6UYY7?=
 =?us-ascii?Q?uwT/bRrEbgyrNOqJ+g+85+kGuM4H1QkZ1SDn6EmK7tkS0G5gwh8ppaEvRTFF?=
 =?us-ascii?Q?T+31ZhnW97Fd3RHCuFTg3NxHXEVcHcjWT4ubdnkH3GHD09AJh3MFOBZXqk1J?=
 =?us-ascii?Q?inn41Uqo7rDaFLEN4D8eG7OeDq2n8Llr4odgbqnqaDTKtp9p05m1qIdmASUh?=
 =?us-ascii?Q?4F6JqbFQ1vRtVtEemhUgaK5FKHWVLNzXDvAXnHX7RygkDxUzIYFMxG8R5juU?=
 =?us-ascii?Q?yqd6Omz7bHO1Y4Uw+EZwkoGbxMYHT3y4B1ZTyO19XnI1NZW1su/1et/gYPgd?=
 =?us-ascii?Q?t07NhmWgb+zjl+ASW8QbvenQ5HixvV9RuuRi16GUZiT5g2N2+tnVD4h+o06S?=
 =?us-ascii?Q?4dt14vpG+kj2By+j7CvSmtGK0iycTbn1qVHip2+hwYVyr+eL1EHAHevAbtq2?=
 =?us-ascii?Q?XXWww19aw6FM1ASoT5rG1voPz1dPgpzGdYIsdz/wftVgFxnrsUbBkmdRwEka?=
 =?us-ascii?Q?7ixfY0EqKt40qu6pSgyzAV0kAWlyAoVbzcnHTYO9K1CeDKKR8bsCLNZb28np?=
 =?us-ascii?Q?hT3+dNUyWGz21Jxjqb6iQjzHr2rSP0upPiaOqaq1iezhRTn9BNzfz4cS3nnA?=
 =?us-ascii?Q?0IxrXR4uqiglb2Kt7sGuUpU1TavP9Xa4DzBjlZ50F8K7155B4xoW9w+cFnkJ?=
 =?us-ascii?Q?658/Yo6nO8ITZnMdlhbu/syd0NaABo6y3RvVkDF7IWbm3Uz+Z5gFi7yrCG5F?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d9834a-33aa-4012-e368-08dbaee420e7
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 14:18:25.3515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwqDn14cklYj3PaMKHrB2o8bzNWDtwJ+/Go5MtkuPq++0MjhfSHtk5V6MbEkdJYcO2faPR3j1VC2lcocnQC2ou/otagKS4y9lo0guc/xrV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5984
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 06:06:51PM +0200, Maciej Fijalkowski wrote:
> On Thu, Aug 24, 2023 at 09:26:39PM +0200, Larysa Zaremba wrote:
> > Alexei has requested an implementation of VLAN and checksum XDP hints
> > for one more driver [0].
> > 
> > This series is exactly the v5 of "XDP metadata via kfuncs for ice" [1]
> > with 2 additional patches for mlx5.
> > 
> > Firstly, there is a VLAN hint implementation. I am pretty sure this
> > one works and would not object adding it to the main series, if someone
> > from nvidia ACKs it.
> > 
> > The second patch is a checksum hint implementation and it is very rough.
> > There is logic duplication and some missing features, but I am sure it
> > captures the main points of the potential end implementation.
> > 
> > I think it is unrealistic for me to provide a fully working mlx5 checksum
> > hint implementation (complex logic, no HW), so would much rather prefer
> > not having it in my main series. My main intension with this RFC is
> > to prove proposed hints functions are suitable for non-intel HW.
> 
> I went through ice patches mostly, can you provide performance numbers for
> XDP workloads without metadata in picture? I'd like to see whether
> standard 64b traffic gets affected or not since you're modifying
> ice_rx_ring layout.

Thank you for the review, I will send the next version with performance numbers.

