Return-Path: <bpf+bounces-4217-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E58C749932
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 12:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CCAE2810CC
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 10:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBF88824;
	Thu,  6 Jul 2023 10:17:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916E79FD;
	Thu,  6 Jul 2023 10:17:11 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FC510B;
	Thu,  6 Jul 2023 03:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688638629; x=1720174629;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gh8A1Zfcv9Irq1MKa1eGHrD2MMVUDbtOmw2sMoxvgFI=;
  b=dsgUK+BIeMoYgpSNrl8yc7d9A2uufItvk3unsEtHpVyc8StmAIOCbi0p
   dOwhC7N1C0vE6XyNk14lPh0UxRMg0Nj5XTG8SaFZNp5UjHH+zw6ax7rDk
   STQAnLOv/8yRxCAE4+75SWlFHtIMIdsJ5W5DSfuS0/mWClBC8l5xBgxir
   kpmKTcxFrCx8Jkty1hIGJXydAZvDxH+OaRMYknbnuqbq2kRAJ3Kbx8wtm
   uX2rpIHymuDqAmRvnWVwF83KABFwMsWi/ioZFLBGWz5f+hJj703zwnU+j
   Zj8a1FbyCWQ0l8t7Uz/RHH1ZK+TYN8ZMk+ZH7tNEfdleAXqd8or7gMRhh
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="449923436"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="449923436"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 03:17:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="864052354"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="864052354"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2023 03:17:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 03:17:08 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 6 Jul 2023 03:17:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 6 Jul 2023 03:17:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 6 Jul 2023 03:17:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jFFRDfaZxdvL/RHRBRvXOqr/6lpZvgaZAts2ZJGXBArAvU04XWIimsChHoNbyYL8rLSHQCVtUwjDm/JMs6GNHfI0Mg5FFKsS2Va+6onPIM9Yn3Zh3a+gMAifWvNgk844F+fVZp0fs8kUnPtkMjBm6BmFy+fiZEl0UfRsXD68aRvpyuyggj5OEDZygFTL7AFXYY70R+WDYfWadZMpb8YCTAbNrtGQW6PY/yiEQP7gkxj9PkDrXFWLT5nmbazkUdo2JbjBZmW2DdMldYtvT/1IouZQNgcdGFy1Ersf12HioRsoMDYxAbhJlYoQsczE9Q4ikkxd58uB+zkKlWXEseQrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQZrcj/bctzbdAhE38KP8MZdZ5KbsHUqMpLWFgRSvMU=;
 b=IgqUKCpz0cx/ptJ4fL0V9bAd2+OiT15VonyjD0pgFq86gXhpO8wTM04ytTTZyHcunyfawzVHP2UKzqB1RW84iMHkKu6pfaEM/qvNoOAAuxotAsUlQ5eN1V+fESrShpOf+B5/brZQBCjX73eUnhC3KBfK0Uxm6suipwxaDCytp8NYnxdwfIYGkdXLgYPUTYXoc9abbmmejE3xEG5bMDuDPgt/dOGp0arCQmkjZCFpDmZza8zYdhyIxC8XlGFSD7wj+xGC4MWNfTsXVOZn4sn2pfnuxksBNNR1J6SYQxfdT+sQNZHBDRiw8fWWDB/WoRaYzDqAk/g8MBAw4eCfe4pqLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB7541.namprd11.prod.outlook.com (2603:10b6:510:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Thu, 6 Jul
 2023 10:17:04 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6565.016; Thu, 6 Jul 2023
 10:17:04 +0000
Date: Thu, 6 Jul 2023 12:13:04 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Jesper Dangaard Brouer <jbrouer@redhat.com>
CC: <bpf@vger.kernel.org>, <brouer@redhat.com>, <ast@kernel.org>,
	<daniel@iogearbox.net>, <andrii@kernel.org>, <martin.lau@linux.dev>,
	<song@kernel.org>, <yhs@fb.com>, <john.fastabend@gmail.com>,
	<kpsingh@kernel.org>, <sdf@google.com>, <haoluo@google.com>,
	<jolsa@kernel.org>, David Ahern <dsahern@gmail.com>, Jakub Kicinski
	<kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Anatoly Burakov
	<anatoly.burakov@intel.com>, Alexander Lobakin <alexandr.lobakin@intel.com>,
	Magnus Karlsson <magnus.karlsson@gmail.com>, Maryam Tahhan
	<mtahhan@redhat.com>, <xdp-hints@xdp-project.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 19/20] selftests/bpf: Check VLAN tag and
 proto in xdp_metadata
Message-ID: <ZKaTsKijOsIa1I3L@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-20-larysa.zaremba@intel.com>
 <80792adb-ca6c-3870-8fdd-a7e814830d1f@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80792adb-ca6c-3870-8fdd-a7e814830d1f@redhat.com>
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e771128-1030-47cf-945a-08db7e0a241f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ctyp5EwcdkJFQuyqoqemhTQcx77hMIgmYeG2ZCOHtWEUChEmutENuL3W2aTRDzYQMI7P06ofv15PoWjaUqKKVpGVe4nQZvvb2zkqnL+5wLDr28TIcyMXxX9plvlhMeP7ikz3/BW1JthB+aYicrd1YQyRUizFehFGe069usuVJ1BeanFF3PBcP4586hPjMHF/v/E6h6OQjdavooVpyYyezvkn82nhTqEs7isGKdZA35cUkn0j31MtrPSG2uti5CqvnVfAdpGqMOFmLAV8ES/m+3CzatRovfKQgvnYa3ccbyG+ghdUGOLXdIyTRG909NXgHKJZFGJbdUzbqwthbTxPGLFDbzcIsObRH/dLvbTENU76BmjJwF/R6ilbvn/txFSCvDEsefWKsUpjzAERgAKz+LP8cR7wz3j1ojrITfV0RvrFoeXNglhseN+O4xF9iQse+qzZNBY5E/Ox6COLsZpcj/XhhMV0MA3CPRHXxNqg9MnFLOxdHZy1upYVzFWcDMNv8GjjEAVp2Epiuq8P3+3jA42017tWWUUSGG2igQNqcpNIvBO9NnLchlU85kUHISA6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199021)(2906002)(33716001)(44832011)(7416002)(5660300002)(86362001)(8676002)(8936002)(6506007)(478600001)(6486002)(26005)(186003)(6512007)(9686003)(38100700002)(82960400001)(54906003)(83380400001)(4326008)(66556008)(66476007)(6916009)(316002)(66946007)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ya4Ue6vqSw0ttyAOjoAJqiHcMs1wuxfMudVOPN/Ci8J3/0BidSpW4P86iaMu?=
 =?us-ascii?Q?JeqKsKmepDwe4R+oL5+CkdDEGmcIdxQYlW5mRScD6E8TZKWxw+bL0y/9lv8x?=
 =?us-ascii?Q?rwXr4bPxvqZX+1c4hhiQwnxrWSA7sXG15ZVliJtY0Kw4VbrHs71K9Unw/Ret?=
 =?us-ascii?Q?eJnubVRtVK8buDZ72TbfdpRloIg6oB3UQi7gIoMX/OqHUkedHiayupY+/04q?=
 =?us-ascii?Q?Q8kI0K7irRPtrZjdgel7tZfvwy43danQwEUCWF6ymqGo67YH5R18CUZlCAPY?=
 =?us-ascii?Q?/d2cLMdi/WUKae98VhqJwjhnBIeE51BABmO/ZdeOW+gEw/+Bs+wQkb+9ztcC?=
 =?us-ascii?Q?8L0PzqDVyjhBuM7i3egVhHWn3yFwH+GkkQUP4hkOadr5taJP156LqRhqlh4N?=
 =?us-ascii?Q?UUaMsJCLYhuYKUXTBSji+JtzSVwvqZVLNKFRPrUnTf/cZd3ZqXNVt9W4VwpE?=
 =?us-ascii?Q?7QvS9hwTL/x2Y3Jgsm/tHgDpB6B7hqCriaOzPgXF/dlYW2/hysw0jI92wINC?=
 =?us-ascii?Q?iXW7W4++/j8l/HkHNZjIaiJyy9bTehaFhjO0NmcPbZ06pmt/zh7RxUC/zdoH?=
 =?us-ascii?Q?fRSYPazrmws5ZBStECF4xHD30eIuyMct/brAqY5+soG7u3vzGa8Ah7dMjksf?=
 =?us-ascii?Q?4oXUZv0EoxRz4Z4ShoDfMWUxvnyG4OfUhiKw9F4/Mm7KhAt+hBGaZ1YuoDsB?=
 =?us-ascii?Q?yXvWU6DhnPqO76wDQ55nZiPGN78duQiCX51r8rtf7z4101JMqmKS+JVM6QqV?=
 =?us-ascii?Q?mCJ5s1lnG2XrgLP1pEfSFi7/d1p7Euynu1NgYHUOVwJdeyf4v2OMF7KZt27Y?=
 =?us-ascii?Q?xjixES8X8rQGkziMTC8eiUjV8k2RPRq0b7L2MMqF8xoWbsZh4Mr+E9Log7U9?=
 =?us-ascii?Q?g+MSQrq9BjsEKAHppk9pN2TjprhFFN8yUGDoN5W198KShyQ4SGyVkWxeYZ7V?=
 =?us-ascii?Q?2+Vr8HolcVLDVoTBtE0q+m/hBdFjlbdvsLsSJBED8gdXvnx4bbqUC13MDU0q?=
 =?us-ascii?Q?M1v2CI27KMGp5iCpKllnQsbh2pjevGS1skSBRba8XE8JD50n3eYUWERt3uWD?=
 =?us-ascii?Q?+WZeJOuNyjc50T8WhaHrkmZ0n/Hj95CaLxLYEwqEQIT3TEnqRBemCpw/NjqX?=
 =?us-ascii?Q?eT03dONCKwscGxOnossEE9fiRK8wfnxMqQ+HmCSU5H23APplirSboFHNH33V?=
 =?us-ascii?Q?/h3qFLATIzSUu114dvQLd9+bbE0YmyRTs6w5uGYJ/94nv/j6L7fLk4wkxkAT?=
 =?us-ascii?Q?37h0SyaGOXDY22nzP0NKrvvFv6uFTPUTM/+y23/A67WVJP+Q2G2sGaWkQSck?=
 =?us-ascii?Q?WRH46yP9j5IL2IGMMSi/eKiKsqt1s2Rw8RdiEAEeYU3mq9EeqYYRH+ly4X2Q?=
 =?us-ascii?Q?rZhzRUa8gfzJqj4HQ6cWIGnbk4YIQXQBTW99RLpCfU48s8TAchwV1y/uQk8O?=
 =?us-ascii?Q?emL00QllmPWdQVGKC7lDcQZS/6+fOHeRwIX/AR9OoIkhU5otJVAzeqT5IDDb?=
 =?us-ascii?Q?lINSW2hcTyYReB/Qw5n42mhPIskj59HscFOiHlYqKeUWDEWRTbjqEobiBpQH?=
 =?us-ascii?Q?DAzYVxoxQPZLWAnJ0x4GmiNr3uiCzsLblFc69eNEzjr24GJSTtmx6aTynmLE?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e771128-1030-47cf-945a-08db7e0a241f
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 10:17:04.1865
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q9Z4Wt/isKcKDvdqVFJhTcYcy/STjn3x3UYEX3TRXufjhQjBbJ9XIzNmF9RosMj4KLRnFgGy2DTxss7yePSP3AKXhuitFeu7hVvwWMZlHD4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7541
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 06, 2023 at 12:10:01PM +0200, Jesper Dangaard Brouer wrote:
> 
> On 03/07/2023 20.12, Larysa Zaremba wrote:
> > Verify, whether VLAN tag and proto are set correctly.
> > 
> > To simulate "stripped" VLAN tag on veth, send test packet from VLAN
> > interface.
> > 
> > Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > ---
> >   .../selftests/bpf/prog_tests/xdp_metadata.c   | 21 +++++++++++++++++--
> >   .../selftests/bpf/progs/xdp_metadata.c        |  4 ++++
> >   2 files changed, 23 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > index 53b32a641e8e..50ac9f570bc5 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> > @@ -38,6 +38,13 @@
> >   #define TX_MAC "00:00:00:00:00:01"
> >   #define RX_MAC "00:00:00:00:00:02"
> > +#define VLAN_ID 59
> > +#define VLAN_ID_STR "59"
> > +#define VLAN_PROTO "802.1Q"
> > +#define VLAN_PID htons(ETH_P_8021Q)
> > +#define TX_NAME_VLAN TX_NAME "." VLAN_ID_STR
> > +#define RX_NAME_VLAN RX_NAME "." VLAN_ID_STR
> > +
> >   #define XDP_RSS_TYPE_L4 BIT(3)
> >   struct xsk {
> > @@ -215,6 +222,12 @@ static int verify_xsk_metadata(struct xsk *xsk)
> >   	if (!ASSERT_NEQ(meta->rx_hash_type & XDP_RSS_TYPE_L4, 0, "rx_hash_type"))
> >   		return -1;
> > +	if (!ASSERT_EQ(meta->rx_vlan_tag, VLAN_ID, "rx_vlan_tag"))
> > +		return -1;
> 
> In other examples you are masking meta->rx_vlan_tag with VLAN_VID_MASK
> (12 lower bits 0x0fff) to extract the VLAN_ID.  It would make the
> selftest more correct, robust and pedagogical to also mask out the ID here.
>

True, will do.
 
> 
> > +
> > +	if (!ASSERT_EQ(meta->rx_vlan_proto, VLAN_PID, "rx_vlan_proto"))
> > +		return -1;
> > +
> >   	xsk_ring_cons__release(&xsk->rx, 1);
> >   	refill_rx(xsk, comp_addr);
> > @@ -253,10 +266,14 @@ void test_xdp_metadata(void)
> >   	SYS(out, "ip link set dev " TX_NAME " address " TX_MAC);
> >   	SYS(out, "ip link set dev " TX_NAME " up");
> > -	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME);
> > +
> > +	SYS(out, "ip link add link " TX_NAME " " TX_NAME_VLAN
> > +		 " type vlan proto " VLAN_PROTO " id " VLAN_ID_STR);
> > +	SYS(out, "ip link set dev " TX_NAME_VLAN " up");
> > +	SYS(out, "ip addr add " TX_ADDR "/" PREFIX_LEN " dev " TX_NAME_VLAN);
> >   	/* Avoid ARP calls */
> > -	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME);
> > +	SYS(out, "ip -4 neigh add " RX_ADDR " lladdr " RX_MAC " dev " TX_NAME_VLAN);
> >   	set_netns(rx_netns);
> >   	SYS(out, "ip link set dev " RX_NAME " address " RX_MAC);
> > diff --git a/tools/testing/selftests/bpf/progs/xdp_metadata.c b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > index d151d406a123..382984a5d1c9 100644
> > --- a/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > +++ b/tools/testing/selftests/bpf/progs/xdp_metadata.c
> > @@ -23,6 +23,9 @@ extern int bpf_xdp_metadata_rx_timestamp(const struct xdp_md *ctx,
> >   					 __u64 *timestamp) __ksym;
> >   extern int bpf_xdp_metadata_rx_hash(const struct xdp_md *ctx, __u32 *hash,
> >   				    enum xdp_rss_hash_type *rss_type) __ksym;
> > +extern int bpf_xdp_metadata_rx_vlan_tag(const struct xdp_md *ctx,
> > +					__u16 *vlan_tag,
> > +					__be16 *vlan_proto) __ksym;
> >   SEC("xdp")
> >   int rx(struct xdp_md *ctx)
> > @@ -57,6 +60,7 @@ int rx(struct xdp_md *ctx)
> >   		meta->rx_timestamp = 1;
> >   	bpf_xdp_metadata_rx_hash(ctx, &meta->rx_hash, &meta->rx_hash_type);
> > +	bpf_xdp_metadata_rx_vlan_tag(ctx, &meta->rx_vlan_tag, &meta->rx_vlan_proto);
> >   	return bpf_redirect_map(&xsk, ctx->rx_queue_index, XDP_PASS);
> >   }
> 

