Return-Path: <bpf+bounces-12680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E667CF1FA
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 10:06:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A73FB212BC
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 08:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8BA14F75;
	Thu, 19 Oct 2023 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CM9D17wj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAD646678;
	Thu, 19 Oct 2023 08:06:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B920E11F;
	Thu, 19 Oct 2023 01:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697702766; x=1729238766;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=oA7t3nyrzq2OUKSIAjOjyMJg/zxdF91EnUsleqTdItc=;
  b=CM9D17wjoz8dBboX6ufR7hBy6i1JeQGACecOLEcdVM3nSQv6a0E2oQTS
   E9eRdRJmfuYxp64ZpA1R4zo5wCECwtZzJ3qOwI9lGJD+sKxhvLzFKTLjh
   8mpJiHyAThVPKfBhDyEe1RLkM1sk7wnXRfNGx+ftDRsxlZQjFs9PAsvG1
   lDx0lHpW4jO7RbWsNA6jMR1uu7ozBi6QVbY3zxthNC7lZwtJ/P5zDkvC/
   tT922snnCDYs7HjYUR46ZtQkigzaolTxl6X8BrrojyjR0XI6YNN2eTAce
   fm/0aVfh1t9hRQTbyJ0JCraTaBjZ3tcJV7FAweL8U1jV3s/ArWH6KG/dK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="417311517"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="417311517"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 01:05:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10867"; a="756923321"
X-IronPort-AV: E=Sophos;i="6.03,236,1694761200"; 
   d="scan'208";a="756923321"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 01:05:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 01:05:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 01:05:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 01:05:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 01:05:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEI9U6xXi1JKz+lhWYHtECK/6nqvtWF6c1WWLEPWpKvlUoZdUW+WVHXBr/jqZ/GglsXFr3moO2cQbHGA0h5JlRqzh7xaEKdrDoFPxIYgbXeazgd6rLjCy3HE2hCevdyK6OGFBV6kFLzxPCo8c255RmzcN2giV/sXeIGPDcffSCMTkg0K7UiJQiCmR87Ph1hC3VYoFkrZqLJYkJ1mXDE3Vbk56+GvhJL+SGYd2hu6nr6NhwM2UIRABuI3VtTq2rYC8iNP4v7LvlDxY54AHronfXA82uqZzPWMje+cFC6ypYKQNIT3Esd8qdJVhmUKsl8Leyfu/USI58DQGN6F+YhEFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LXEObFb69ROw7YbOpWbJK5yzcpsYhCILuywFUa2F6Y=;
 b=ZYJNbxQQF+N3YoV8CfE5OxkeP6Jmpl7r3ufVR25K31QKMVHKgTTWd6sn9SjlDfAzjqVwbcsFohjAR//MJSSWmebJHsZINEy7S6AbQ4OVsolzObt0AOU1z0VI7lxKcNzeGrhfImouDgRr46GKdUM5hJhtIasJ66k2s2kuI72Ftg/jNMgqxqwXUYAOh1CIo9A/hjWtJWdfoEAqkpibYqnGhRXUud+GcZ4ase+MnsfUD6gtwJf+aoWg/4AAy4su/auX4k26yFwIkZwvMe7cSuI/utmtUyv/LRLgVqylE8cy/IGQgve7jEFF4Ft0KZBbxRAsJa5qE+iF92mLaqk1zIcS9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by SA1PR11MB5923.namprd11.prod.outlook.com (2603:10b6:806:23a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Thu, 19 Oct
 2023 08:05:53 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8947:cca7:ef62:7936]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::8947:cca7:ef62:7936%5]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 08:05:53 +0000
Date: Thu, 19 Oct 2023 10:05:24 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <sdf@google.com>,
	<haoluo@google.com>, <jolsa@kernel.org>, David Ahern <dsahern@gmail.com>,
	Willem de Bruijn <willemb@google.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>, Anatoly Burakov <anatoly.burakov@intel.com>, "Alexander
 Lobakin" <alexandr.lobakin@intel.com>, Magnus Karlsson
	<magnus.karlsson@gmail.com>, Maryam Tahhan <mtahhan@redhat.com>,
	<xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>, Willem de Bruijn
	<willemdebruijn.kernel@gmail.com>, Alexei Starovoitov
	<alexei.starovoitov@gmail.com>, Simon Horman <simon.horman@corigine.com>,
	Tariq Toukan <tariqt@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH bpf-next v6 08/18] xdp: Add VLAN tag hint
Message-ID: <ZTDjRLj8zFsNIwUP@lzaremba-mobl.ger.corp.intel.com>
References: <20231012170524.21085-1-larysa.zaremba@intel.com>
 <20231012170524.21085-9-larysa.zaremba@intel.com>
 <20231018165931.1016e6c5@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231018165931.1016e6c5@kernel.org>
X-ClientProxiedBy: WA1P291CA0016.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::27) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|SA1PR11MB5923:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7612cf-c2eb-4f85-8353-08dbd07a2b7f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K2XHdCJ0UfXOjPT8JaxHF5L+F6BmLTYZyFMEJHL0aJLiPsDN125LEicIsBlRmMIFxdlvwkehXDt+hfSWNXgyuhmI8Iu9RaZLEwmUyS102OyY84YTL9TIn7sGxm0kxU7asV21561JPG70moc+/lsmuar3n0KRy21OAEM8Oj9OWRs16wUzE4VmHe902uAmiw5q4vyczs0YZ5raOdBULjIWlgOI04FA8mIX1kPsSvFTQd1m+tfxRzzuXgm4/btF09iTnz+ev2lkZOcVgBO+4e2zqbgscMU+zEgpmJTulQtMgJt/Or1WBlIJ3G2UnEc8dcf8LJj2/AZvgiWqBHCzRA8+Cy92tlkWvQ4WSDJNfGB3Cdk6Ha1aU/IuCZYFeVWdjM2X802/twnkS2e1uM3WCGvNrclXDqmbOB/KFPoo8+vRuU6K7W5yB//gKqkVy4l/Rzj+l+whdyQWWW/CaGjMc1Qmmoqwidn7YP+ikagCiV6fCUydCZYtlL5n+y6eLICBD9msKrSFakl8m4yMmGwNQt3FbisRrakMRer1ay5jbkaHErvVm9xpTz0Tk33xD7oW6fK8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(478600001)(66476007)(66946007)(54906003)(6916009)(6666004)(6486002)(66556008)(5660300002)(26005)(86362001)(38100700002)(6512007)(82960400001)(316002)(6506007)(107886003)(41300700001)(7416002)(2906002)(44832011)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y7v3yiQMnl2IpbuX5GaZa4U0jya97iusioM3U++Wx14OvtRRaqyWKVCkZbgu?=
 =?us-ascii?Q?QYhGDt4CtW4Vzpusp6tjCK7sIM2YIaGw5xj8YEBWaiCAOF9myq7Bj4gJBig/?=
 =?us-ascii?Q?HDLo+UhIAZz0WEYRQugaRy+5pfw/F15/znjfQnr5PY2BBWvg8GMqLzBcISXE?=
 =?us-ascii?Q?iaG5rConkwvXQLVx9X1Jw4vvdjSrbZPfjCnVlif1KyL58Zw9+AU7VPCpiqs0?=
 =?us-ascii?Q?SHP/sTrOQmTJc35u9fztgAPMwiLrKAlstzteVxBBWWuoqQzl8/ItnPD4HYd7?=
 =?us-ascii?Q?IlZRcZvLLiOc3Uizp8sPjW2qdBAoIMgfVSmxxi+JTZvd8ZclGJ028LmmDEDI?=
 =?us-ascii?Q?R1PrdkJW3Gzxn0rT76ZwIC6h1yfSoOkmBtoCRl7aBI6emA3NZzvneBKKkDt7?=
 =?us-ascii?Q?arfHvaPUELW8i9qCabw5rd6UFpQ8gB62QCcgVZBsX2/n6/JiEv+f/k5KhfVM?=
 =?us-ascii?Q?VzycG/HWvnxquyZITIOkPN1DpQKDZO8l2O+tb+jQwQ/cOYvLE5Zgm+Xb+7pL?=
 =?us-ascii?Q?YKnNnyFeasb12HNJkvIvtqZHc/VqLUzOiUsFvRVc9eBCqrIjZS2izQP3fvRi?=
 =?us-ascii?Q?BCBj8mTDawBEMtVc4KW6twTB7T91sjjqKR3siZAuKQS/QokY50pdyM8d24Tq?=
 =?us-ascii?Q?e8vG+xrpi3TxXiLtsFJMVJMTyVOgRG4mhNljqBSrRLikwKKQ+RL9BW32Doau?=
 =?us-ascii?Q?ZoaQWZwzbWjZtPS38NOiMzKDhG1S5FOf3O5JXP5On0dkBOGpmABGJ8TVYQEg?=
 =?us-ascii?Q?ugK/rysdiF6nBvgryp3E81vzXzyW3S9eEYcti4dhZDgde+DOPcQXs4zq+/jj?=
 =?us-ascii?Q?lFKNspudSKTg+5O5UNQajFIu1Il1R6eSPC+YWGh7dQz8L/EvIOMWBcTNrQdc?=
 =?us-ascii?Q?m6Lcw1vv48xbwNRdurJmKaoCPqgdBkZXDlT5zzywEf76G6Rxz/Se6V9g0BTY?=
 =?us-ascii?Q?PzizSgnCGmLN6AN+nT6obfh8zQXE7th50XCSFLmXylZRrWjuR1J794maamUx?=
 =?us-ascii?Q?Tg6DcWiJSZ1xFttp7zNbNvl/Z2h1CvhIgdZxI8faZnyetyIqNqfdZlhdFTdE?=
 =?us-ascii?Q?ebkCihmLygcF67oEupGdddxXIjNiPnjvLTmlAz4GpnaHrVeZ+45JtinNjNf/?=
 =?us-ascii?Q?eJigFPvQCEySoDhwb43BlqLwbHZoJj6gGGLvKBiXLHJWKlUenIH4jhJM06zl?=
 =?us-ascii?Q?h1wMf7tejW1hGVJMFThHahFptdeLy7/djVceO9DtePZWR94fLUxCNK9X6e2w?=
 =?us-ascii?Q?aei/cqQ59avtdCWLJCHGCScdbgWFJHRwwXmXMe+134vJ7RDGSKTB6jfm97l8?=
 =?us-ascii?Q?0KfFUXP2E5GeGecNNuV2J61HZcdWi9QbGQXRL6Zbibs/Szlb00KCmOwu/G0i?=
 =?us-ascii?Q?ImQXIQJkWJFI+biRxW6TF7rmbUdgNM/iw6gyrcQ73sXKsJHawTLz0oz9ghPO?=
 =?us-ascii?Q?c7y5cVIwh+sms7FoaxPsVn7uhw+0rJsoEmX8sZTxmeeHHZbc6dLjIdhW0VSk?=
 =?us-ascii?Q?y2FxWQ+lLQ9EFUTEBA8zsbqdRcrxUda3NCpGsd2oGijJ1CEe5XibE9kFJ8wz?=
 =?us-ascii?Q?yzbBc9jd9VmR+BtOHnqtfrTEIT4M11+f4FXLlIsJZ6wsAQ0Q/HA6WkY6NmnW?=
 =?us-ascii?Q?Iw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7612cf-c2eb-4f85-8353-08dbd07a2b7f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 08:05:52.8451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Gr7wKzygnn8G2VOzGyYbuw7kB5VxiwAvaoe6+dbo5O7aam8k/tXFaeGJxtSgv/zX6ZXuqz7kjlR4pKSy8AWWAKF9CD90ic75a00i08lQUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5923
X-OriginatorOrg: intel.com

On Wed, Oct 18, 2023 at 04:59:31PM -0700, Jakub Kicinski wrote:
> On Thu, 12 Oct 2023 19:05:14 +0200 Larysa Zaremba wrote:
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index 2943a151d4f1..661f603e3e43 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -44,13 +44,16 @@ enum netdev_xdp_act {
> >   *   timestamp via bpf_xdp_metadata_rx_timestamp().
> >   * @NETDEV_XDP_RX_METADATA_HASH: Device is capable of exposing receive packet
> >   *   hash via bpf_xdp_metadata_rx_hash().
> > + * @NETDEV_XDP_RX_METADATA_VLAN_TAG: Device is capable of exposing stripped
> > + *   receive VLAN tag (proto and TCI) via bpf_xdp_metadata_rx_vlan_tag().
> >   */
> >  enum netdev_xdp_rx_metadata {
> >  	NETDEV_XDP_RX_METADATA_TIMESTAMP = 1,
> >  	NETDEV_XDP_RX_METADATA_HASH = 2,
> > +	NETDEV_XDP_RX_METADATA_VLAN_TAG = 4,
> >  
> >  	/* private: */
> > -	NETDEV_XDP_RX_METADATA_MASK = 3,
> > +	NETDEV_XDP_RX_METADATA_MASK = 7,
> >  };
> >  
> >  enum {
> 
> Top of this file says:
> 
> /* Do not edit directly, auto-generated from: */
> /*	Documentation/netlink/specs/netdev.yaml */
> /* YNL-GEN uapi header */
> 
> Please add your new value in Documentation/netlink/specs/netdev.yaml
> and then run ./tools/net/ynl/ynl-regen.sh

Thanks! Will do this.

