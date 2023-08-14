Return-Path: <bpf+bounces-7704-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A8277B75A
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 13:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1814D28112D
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 11:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D377BA43;
	Mon, 14 Aug 2023 11:16:04 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C53523D0;
	Mon, 14 Aug 2023 11:16:03 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37504FA;
	Mon, 14 Aug 2023 04:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692011761; x=1723547761;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l5KAfZ0d/qeuZ8h/lX2FTOGYE7SltKPUcOg6dXbu/FM=;
  b=WRMtVhMZVMPQCLFchvQmFLNgl5JFyiIAw8ILIHyJJrQVd5jCIt5sTrTb
   qxhHCOKQ0mlCYWzG2va2Q3Z/OV9zwcOEUkSsgNQfs+mIMLQyeLUef2HLY
   tOdUIvSzogiloiBDzjNzVPcQCKQvw9oCSfOAj5eT84hnPf2ndgdmGNZZy
   G3xTsEv6F8Xot04zbtzhQOixrOd31IydNJLM6iC8IiDumHSAiitVFQ6pC
   v5Ma3E/YCaRICZiZfHnrpqU3PMB4eMP9oIi02xAuavBrC0HsMWCCJ37re
   GxiIwxV4tpgDL41cKkTdwq1+91fak6vhtTscUv3ZqVP+t28OcuKTKp2aK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="356978237"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="356978237"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 04:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10801"; a="762904437"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="762904437"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2023 04:13:37 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 04:13:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 04:13:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 04:13:36 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 04:13:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OCI3X+0zQIzM7Xgw8JU+tBcVhukZT1Zt3UmcdLlws47Upj9wXlGl1eLaJLhhF+mEpaaKVH58i3nup3nPNLyKrw1yMRzdaYFrgHimih+YAkY9UAgQb1maTru3Pr209F75bDHAVQvesnxDV6e8FR8UK7aHg4ABRs3kdZ3UwFmWEma33uYPyE+NbjRmvCR8ZXO04knRSCSocSEJ5dqPAQP+EJUJyz04gpegL5ewuhG0YUf/us3vm0BBhiyaZPGvuiHvtJLYtxU486rnOdPflbxOmeFNvkGOrfkzuQ06DJR4y7rJI7S8DWbWLps5L+o81qzGNdUbkuhK4Fg9XnhGSNUA5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fnH6Y1mlSoBQxaLEjsvmTSpoNeebzdPsvSWj60T+Szo=;
 b=apf+VNKe3XWYzZ1jJdmr1xEVQkjupWTOuhHqVt4YASdyibyuoLlNO7L8T0CeX5KlAf+8z7sa05vUuoEF4avmHYPnKzZ/+mem7AEEELfcNBE9oyE3DZy3CMhQE5J1HzyoSg+fETRvYMYgV2lIgN1aH1RpaLy7YJuG2m/lv79Vlz5XoJOEwI5PKkUU0JJCBmPwK6h84cH2mro3Gt68aja2sZJL7Y8drMH/zcpLDgElIoBpZ2SnLYlV6yy4UIgMzRibFfZLRQ1xmx8wGF+BzTmI05b1kP0o0mMn3egWc/drRioQTgK82QHvN2sChVWk7EO5iSqnGY06I4RgN6TtSsJrNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB8052.namprd11.prod.outlook.com (2603:10b6:8:122::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6678.26; Mon, 14 Aug 2023 11:13:34 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::c1f9:b4eb:f57e:5c3d%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:13:33 +0000
Date: Mon, 14 Aug 2023 13:13:17 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <sdf@google.com>
CC: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <martin.lau@linux.dev>, <song@kernel.org>, <yhs@fb.com>,
	<john.fastabend@gmail.com>, <kpsingh@kernel.org>, <haoluo@google.com>,
	<jolsa@kernel.org>, <kuba@kernel.org>, <toke@kernel.org>,
	<willemb@google.com>, <dsahern@kernel.org>, <magnus.karlsson@intel.com>,
	<bjorn@kernel.org>, <hawk@kernel.org>, <netdev@vger.kernel.org>,
	<xdp-hints@xdp-project.net>, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH bpf-next 0/9] xsk: TX metadata
Message-ID: <ZNoMTVS0I9A1hyTQ@boxer>
References: <20230809165418.2831456-1-sdf@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230809165418.2831456-1-sdf@google.com>
X-ClientProxiedBy: FR0P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB8052:EE_
X-MS-Office365-Filtering-Correlation-Id: edfe1839-8431-41b3-e1a7-08db9cb77fa5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u6XxCgIJY5PhUlYcOy9RW86TPmrmfouYaf5AhHd5FzMyxwLn84JS+IQb/PM/2SlGc42ALeGkOVVC2LdZjO2t+jk25xt7N+AOi3zpLYrazi1QpWALInwO6LVlxst0VbLEYvU3p8m9A+yUqmY/+i+ZB5lgZ03B1FLnQKZCxjC96coINYwsoX0tbgbNPf3iD1MtX0pg4s9pazb7F+PHbmMtK/e0rM1sQ2KiXD8q/mFIH1VZaMw6I1IwbHJJV9kO8cKsMGngNwk4orRUOveZ1CwWI1J5Mo94LJ1YDd3ygVhtYJyEX5RDZt2zYotL6JvvKX6ih+r9+zYGfx93bdPzfPLnfI1VRrbEiuG5KgFcBuaAsEjv4J835icPZ+cLdx5ANnJtZZ+5YV/w56YNg3+Rx6oPjRwhBYeOnmfLNRthhxIB/rf8Fa3WrfRaZutrAPICQ9LKBLnJrWYPOCjf3yMtVdv/oR9JTF7LHVg1v5yHL0NqsR/i3nwEORuErn9xeIiHzKHEIocnD8gUtAqfGLUHhdkz/Zr8uKpBffjzksFcIcl4IVdKkq2iODK7ze/OD3LvWgH3cKHzSBbZ2WG4aX1d9dCwxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(346002)(366004)(136003)(376002)(39860400002)(186006)(1800799006)(451199021)(478600001)(966005)(82960400001)(6666004)(8936002)(8676002)(4326008)(66556008)(66476007)(6916009)(316002)(41300700001)(38100700002)(66946007)(83380400001)(9686003)(6512007)(6486002)(6506007)(26005)(86362001)(2906002)(44832011)(5660300002)(7416002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UzclTfQOzkXkzL5q+byud4N+wfO+6TecrYn3IjDXJ2rf2sYeu7V4tYrdmh/7?=
 =?us-ascii?Q?IojDDduV9H5mv81zVV6pC7paptnDxOlA4bHEhZ4TKn3kN7Zgxa2pbGlp7seH?=
 =?us-ascii?Q?+c7VhKIqO2j6euB6GXBf6ogMlHSw1ZtBJ5DDuRXAb8A6JWbeROcCuQELmzvq?=
 =?us-ascii?Q?NYjbiwdKRj24rAexURg+CAS9OVboboXT7oMnuT65YkBDz4m2iHZA6mFS3Z4Q?=
 =?us-ascii?Q?jgHAJBz0oYcr3X5lhuUuFww7R7vfyn8KHBT+eQdhxJXzPeA2DBhZE48T5yBw?=
 =?us-ascii?Q?q5txAKysdo+ZpIkRA4IK0BZHimHkPZJM6JYc47JaBq3lAbqn3E5h5WHnYfDJ?=
 =?us-ascii?Q?umaFYNG+ZxwUAxguyGbX7hcDQxg1NDDGqvaOSuW78ZNruhno8OladkvgDEHS?=
 =?us-ascii?Q?lB7u+jIEgP7dRkNow3bDFHI9QOSGjrlgPwn9phc2XaQXFnCYBbQurMGaK/vn?=
 =?us-ascii?Q?rdimR9XQztC8pKiocSYU4xxAwYdsjfsDgUQdI18akcsfxXv9tcKGKohlA+1e?=
 =?us-ascii?Q?3rsevWl1ulqNqo3VRVrKl/+Nwu4+OTWFYw6l9APWEiGelRl6zYlG9fafl7Ni?=
 =?us-ascii?Q?S546XC6SLJw5u+X+ZWe4o/41hiOuo4SCAo6xL/20GY38YQGz/rjucEeQUpVw?=
 =?us-ascii?Q?MMsJFUx99IcKFkYNQSzwxtNilhhlhorLKkvGzn795oAgXj6NlcZprswHZzTB?=
 =?us-ascii?Q?Vnvt1ofnr8UmBkzey0TrVtdJlnLXTMtGfXV+wobBjmVC4A7wXdL3rsYIWfX8?=
 =?us-ascii?Q?9ylEuVj9rzq665GFtzJ5rhuCmjKF9shjjf/zxzcPJd+Qb6zsaaZkWcbAHpv7?=
 =?us-ascii?Q?4JZV5PFu1Uxcg6mcGzOxlluxAu4B9ptgHH/gyChVaJRJtTkyx+5fmw8SS4RL?=
 =?us-ascii?Q?6dsxweUJb0P4430OYK11VnBCWbc6F3XWadzMevoDgE7pOtrQWhYWFF54QxYP?=
 =?us-ascii?Q?eYKSWX5uLGwjx9Se7Gs8fEnzZByvDDsfz5Z+sukGUCFgWsMvujACJayDepDh?=
 =?us-ascii?Q?IMVNzhoxq67NY/gfAIhKkJta0qwInh4mm8xt0nhCoyw2hP97lzXCWb98wi3x?=
 =?us-ascii?Q?xGTldFKTh4/YvZhJnYGKHw8e07EQwS27IenxIhWVGYmPDKF+EchWeRkLWgwR?=
 =?us-ascii?Q?xWqgHrnMutZjOY28ABz/ahUkjC+FWYMCkczODqk8Z4XqYrYFH+oh5qQYUJdi?=
 =?us-ascii?Q?XJQVUDv4XpJgfBNsrSNtqeD8W5UVEwxc1erYPYHBvAnOWSg4YaePTAn973wr?=
 =?us-ascii?Q?sWslr09+nd4KUpalrqBo1iMJOQ65GLF3Sv9OSy9Qz1SW2jgUt0BckU1zYMuE?=
 =?us-ascii?Q?jntmv9SRQm3eY3q6sX7f195m1JAjytLrQLV7ajlPZ/W8sGYPAoyHN9vjG0Tf?=
 =?us-ascii?Q?ue5+ow2fihIBDoi6Y0hpEp3j1wsLTrf0vxq8QVPtQCA0yTx5N95RV/gaZS/O?=
 =?us-ascii?Q?KE07smKZoESN4hH6/yT9Y9oDj0A/873NS4VgnspfkahPTug6GBE8GbOU+liZ?=
 =?us-ascii?Q?mU8obvDEW+9ZK08OJMIi0E1YYnk2h7NZI16ky9kRMYEAaEtEc9I4/s144WmA?=
 =?us-ascii?Q?ErteTlJNcD0zNTDTcFdkodjciioOaUdUWReeMsuS+gynaD0/zNohLzoLHqAN?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: edfe1839-8431-41b3-e1a7-08db9cb77fa5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:13:33.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKy5JhCK8udLEh++i6+tYyQ0C5atEzueG4mQ73vSN1tQu5opj7WRq/F8LR+ocVA7ekyUrxVu4e50b2oXqscYT9jfxMVrVy+ib2/upfDVaks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8052
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 09:54:09AM -0700, Stanislav Fomichev wrote:
> This series implements initial TX metadata (offloads) for AF_XDP.
> See patch #2 for the main implementation and mlx5-one for the
> example on how to consume the metadata on the device side.
> 
> Starting with two types of offloads:
> - request TX timestamp (and write it back into the metadata area)
> - request TX checksum offload
> 
> Changes since last RFC:
> - add /* private: */ comments to headers (Simon)
> - handle metadata only in the first frag (Simon)
> - rename xdp_hw_metadata flags (Willem)
> - s/tmo_request_checksum/tmo_request_timestamp/ in xdp_metadata_ops
>   comment (Willem)
> - Documentation/networking/xsk-tx-metadata.rst

Stan,

thanks for working on it - we reviewed the patchset with Magnus and we
have some questions (responded inline to patches). Overall we think it
would be worth implementing this work against another ZC driver
(preferably ice :P) to check that proposed API is generic enough.
> 
> RFC v4: https://lore.kernel.org/bpf/20230724235957.1953861-1-sdf@google.com/
> 
> Performance:
> 
> I've implemented a small xskgen tool to try to saturate single tx queue:
> https://github.com/fomichev/xskgen/tree/master
> 
> Here are the performance numbers with some analysis.
> 
> 1. Baseline. Running with commit eb62e6aef940 ("Merge branch 'bpf:
> Support bpf_get_func_ip helper in uprobes'"), nothing from this series:
> 
> - with 1400 bytes of payload: 98 gbps, 8 mpps
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189130 sec, 98.357623 gbps 8.409509 mpps
> 
> - with 200 bytes of payload: 49 gbps, 23 mpps
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.422235 sec, 49.640921 gbps 23.683645 mpps
> 
> 2. Adding single commit that supports reserving XDP_TX_METADATA_LEN
>    changes nothing numbers-wise.
> 
> - baseline for 1400
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189247 sec, 98.347946 gbps 8.408682 mpps
> 
> - baseline for 200
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.421248 sec, 49.756913 gbps 23.738985 mpps
> 
> 3. Adding -M flag causes xskgen to reserve the metadata and fill it, but
>    doesn't set XDP_TX_METADATA descriptor option.
> 
> - new baseline for 1400 (with only filling the metadata)
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188767 sec, 98.387657 gbps 8.412077 mpps
> 
> - new baseline for 200 (with only filling the metadata)
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.410213 sec, 51.095407 gbps 24.377579 mpps
> (the numbers go sligtly up here, not really sure why, maybe some cache-related
> side-effects?
> 
> 4. Next, I'm running the same test but with the commit that adds actual
>    general infra to parse XDP_TX_METADATA (but no driver support).
>    Essentially applying "xsk: add TX timestamp and TX checksum offload support"
>    from this series. Numbers are the same.
> 
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188430 sec, 98.415557 gbps 8.414463 mpps
> 
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 20960000000 bits, took 0.411559 sec, 50.928299 gbps 24.297853 mpps
> 
> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.188723 sec, 98.391299 gbps 8.412389 mpps
> 
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000064 packets 20960134144 bits, took 0.411240 sec, 50.968131 gbps 24.316856 mpps
> 
> 5. Now, for the most interesting part, I'm adding mlx5 driver support.
>    The mpps for 200 bytes case goes down from 23 mpps to 19 mpps, but
>    _only_ when I enable the metadata. This looks like a side effect
>    of me pushing extra metadata pointer via mlx5e_xdpi_fifo_push.
>    Hence, this part is wrapped into 'if (xp_tx_metadata_enabled)'
>    to not affect the existing non-metadata use-cases. Since this is not
>    regressing existing workloads, I'm not spending any time trying to
>    optimize it more (and leaving it up to mlx owners to purse if
>    they see any good way to do it).
> 
> - same baseline
> ./xskgen -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189434 sec, 98.332484 gbps 8.407360 mpps
> 
> ./xskgen -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.425254 sec, 49.288821 gbps 23.515659 mpps
> 
> - fill metadata for 1400
> ./xskgen -M -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189528 sec, 98.324714 gbps 8.406696 mpps
> 
> - fill metadata for 200
> ./xskgen -M -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519085 sec, 40.379260 gbps 19.264914 mpps
> 
> - request metadata for 1400
> ./xskgen -m -s 1400 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000000 packets 116960000000 bits, took 1.189329 sec, 98.341165 gbps 8.408102 mpps
> 
> - request metadata for 200
> ./xskgen -m -s 200 -b eth3 10:70:fd:48:10:77 10:70:fd:48:10:87 fe80::1270:fdff:fe48:1077 fe80::1270:fdff:fe48:1087 1 1
> sent 10000128 packets 20960268288 bits, took 0.519929 sec, 40.313713 gbps 19.233642 mpps
> 
> Cc: Saeed Mahameed <saeedm@nvidia.com>
> 
> Stanislav Fomichev (9):
>   xsk: Support XDP_TX_METADATA_LEN
>   xsk: add TX timestamp and TX checksum offload support
>   tools: ynl: print xsk-features from the sample
>   net/mlx5e: Implement AF_XDP TX timestamp and checksum offload
>   selftests/xsk: Support XDP_TX_METADATA_LEN
>   selftests/bpf: Add csum helpers
>   selftests/bpf: Add TX side to xdp_metadata
>   selftests/bpf: Add TX side to xdp_hw_metadata
>   xsk: document XDP_TX_METADATA_LEN layout
> 
>  Documentation/netlink/specs/netdev.yaml       |  20 ++
>  Documentation/networking/index.rst            |   1 +
>  Documentation/networking/xsk-tx-metadata.rst  |  75 +++++++
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |   4 +-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  72 ++++++-
>  .../net/ethernet/mellanox/mlx5/core/en/xdp.h  |  10 +-
>  .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  11 +-
>  .../net/ethernet/mellanox/mlx5/core/en_main.c |   1 +
>  include/linux/netdevice.h                     |  27 +++
>  include/linux/skbuff.h                        |   5 +-
>  include/net/xdp_sock.h                        |  61 ++++++
>  include/net/xdp_sock_drv.h                    |  13 ++
>  include/net/xsk_buff_pool.h                   |   6 +
>  include/uapi/linux/if_xdp.h                   |  36 ++++
>  include/uapi/linux/netdev.h                   |  16 ++
>  net/core/netdev-genl.c                        |  12 +-
>  net/xdp/xsk.c                                 |  61 ++++++
>  net/xdp/xsk_buff_pool.c                       |   1 +
>  net/xdp/xsk_queue.h                           |  19 +-
>  tools/include/uapi/linux/if_xdp.h             |  50 ++++-
>  tools/include/uapi/linux/netdev.h             |  15 ++
>  tools/net/ynl/generated/netdev-user.c         |  19 ++
>  tools/net/ynl/generated/netdev-user.h         |   3 +
>  tools/net/ynl/samples/netdev.c                |   6 +
>  tools/testing/selftests/bpf/network_helpers.h |  43 ++++
>  .../selftests/bpf/prog_tests/xdp_metadata.c   |  31 ++-
>  tools/testing/selftests/bpf/xdp_hw_metadata.c | 201 +++++++++++++++++-
>  tools/testing/selftests/bpf/xsk.c             |  17 ++
>  tools/testing/selftests/bpf/xsk.h             |   1 +
>  29 files changed, 793 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/networking/xsk-tx-metadata.rst
> 
> -- 
> 2.41.0.640.ga95def55d0-goog
> 
> 

