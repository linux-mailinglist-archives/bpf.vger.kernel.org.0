Return-Path: <bpf+bounces-3965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC129746F6D
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 13:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEAF31C2084B
	for <lists+bpf@lfdr.de>; Tue,  4 Jul 2023 11:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7F5681;
	Tue,  4 Jul 2023 11:08:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27061566B;
	Tue,  4 Jul 2023 11:08:12 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11997E76;
	Tue,  4 Jul 2023 04:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688468891; x=1720004891;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ce2mAEI/e9+UqKg3uJadAovEGTYAPynqm/f3LpxateQ=;
  b=gtctl/bBISFFUVclAhqjbvi+ZpS/2DukjPfy/gGclRyc5UwdnDx6DTbP
   lq0KZzdi3dRNKIpgx6a2/TS8dUABYYhe8K8ha3NkPczGqCI6vJ9b99RNN
   PGQKdkjTM4brHnVp4kpfeJWsWYaqxEUlYhrLGs2/JfkWesOljnaS4w2Cz
   FCvz72IEWFaP/aP+y1JERxnR/bDwNIvD8i83stKaOcHblIb7yz23MDo0k
   rlKKoeOu8USdP0T8KP4v01VhM07hTvevn+bQs3dzfHvIFzvJZUZnwOQ/s
   MEXhFUFOj7nHczEhD3YhduK39Dsn2d4hl6GrZADEKYQdHXPuOJ5wD68tb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="347891143"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="347891143"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2023 04:08:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10760"; a="832141713"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="832141713"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 04 Jul 2023 04:08:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:08:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 4 Jul 2023 04:08:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 4 Jul 2023 04:08:08 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 4 Jul 2023 04:08:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNA4fX6RSyjIjRL1+BCJCuGDcNJvklhDPPWmikq5N64wjimfYQ/wzh03/XC7F72/T3KJ4PwO8N8DWww70o/di02uJNPKcpmDgzbRgRJ8rvNPonmiDzmmle9TdV4Jf/K/W4u4NmEtENUBWUEF9bbA7hrTGyw7unQqRXdxPhbGjTryonMM3oe+H1wIXt7GgEY6VIKS9e0TYEr0aE9p+WYHQOJWiKG6TwMruHozCCuCvX5pL4N7PsYSrYvYygZulfJziD9YO6YD7OzRunbXaMJhylbTOjd0EUIRbqm4+qxgbyxWJcB1h1XHRZKHJ8iG3pKg53SlQGLLi/16NYNMCzq9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ybgvj8+vypkP278uICKz1xdOar4UZG5CZd5LZhEMP4o=;
 b=hwZc5cI465xOnvCoJxIUmmZ47LTkC8mtVCSF4slcQ9unIQDtZf7HiUwx4ePJ0FxVH8xy6QTAQvUunaYqwqWuM9LEA3+sDIe5ywO3Gfmy/yYxkB6QySD3/3Ji3QGi8RzwgqnSoP2CXx3rMhtMAaYlawpedu046Nu3YPBsx98SGpQb5mCEFm8fuOE3T0I5kiwdMEtrXlGT5snCFEAZm5Jr0EEDHmPewO/gf1eI1/bIw5ZvM9BZyn0J/NyrP3gUKLX2FIbh4h2ef2zPX7MyH8qHtugxfe2DipuBVXWCHef7i0OVlLwFTrflK1vt0nhOR7yFwGXmNXnIIEfvWSUmX7EVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 11:08:01 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::9376:9c9d:424a:a0fe%6]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 11:08:01 +0000
Date: Tue, 4 Jul 2023 13:04:22 +0200
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
Subject: Re: [PATCH bpf-next v2 16/20] selftests/bpf: Add flags and new hints
 to xdp_hw_metadata
Message-ID: <ZKP8tsdN3Kzokbf1@lincoln>
References: <20230703181226.19380-1-larysa.zaremba@intel.com>
 <20230703181226.19380-17-larysa.zaremba@intel.com>
 <8c4da3c2-bc18-5fe9-2189-4b22cc910a25@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8c4da3c2-bc18-5fe9-2189-4b22cc910a25@redhat.com>
X-ClientProxiedBy: BE0P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::23) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: 709f1b50-c200-4dbf-c006-08db7c7eee4d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JtC7WN7D/9x3Tzvhzd/58EViSnLlwfFOBy/DAAP/pL0sz5Y9R6bHLO5txHT7tsKZJMGlpoJqNW9+nNSQQSOwRduWBzBt/y8N/1I+r0HV3jvIZq66WsX6xVUpEvBvPHZpnmiDdsEMmdZbFrsZivYxAYI5Y3Ise+9gvdjk75uXqoBRNJ5zr72ZGy2h9awxOW3FdMJDcCA2oXpNaZ+dp5IY0FPr1nK0QIU8EnIOSYHc+4Yr/1pmxB7Qb2Naj4/+n6eD3WZfhFfzsTnGcBvyVqYlsF0TagRYgjZpw1uvvJDRdcocEvCLVHtRqBYO3fyJ4ZLJiOUOD3DIahZvlnPMKb571JdhvGI1vf0LXsw3PCaiM00zOjoAe0KTD4sC6SKKXSr72/7N8MmmEGDRiFqMtHxgaveejfKyHsYS3zszWwaHgB3m/cf/jwCW1CFwg8edjusmZTDprel3BNf2KdmnXewAWhGSW7onou9nw3TtODPWAECwlGfzEwQ+V0LZhVfqqtl+0MsLLnNjR/HnuOnKRxqIR7lMMGMZ+nYpHQfeqzXcrLiq3hcFg58uU5GI3SWI6ciY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(346002)(136003)(39860400002)(396003)(366004)(451199021)(26005)(478600001)(9686003)(82960400001)(6666004)(6512007)(6506007)(86362001)(186003)(38100700002)(54906003)(66476007)(6916009)(66556008)(4326008)(66946007)(83380400001)(6486002)(316002)(8676002)(8936002)(44832011)(7416002)(41300700001)(2906002)(5660300002)(33716001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cGr7mrKGCCjQHZEprjNEDG1dAlB6/wGpz6jNsnQ04HVhO25TYW2tUSu+VgLF?=
 =?us-ascii?Q?1GzAouBiReclNKQ/XQcrFx+UJnayN7Vojav8Oai7b9aP4ioRMG0vjvgeCzr1?=
 =?us-ascii?Q?cFCjGwV9n2o6XlpSZE5dk5bOCtD5uq/itN8uzesMcoKO1OrrJ5bR8zu0HLC8?=
 =?us-ascii?Q?Do8QpW+Kx3CrB0rOYGlgRsvjA4YhQfQ45gpGUq9M9u5h/E0bP5bWjrRKEQ+c?=
 =?us-ascii?Q?FVurNvapRNo6AzV8h/LD7IT7VhTq2jZSolN3Y4ODwCJ/3pUgnSx+irMTIu9T?=
 =?us-ascii?Q?ttaEL6N/k7Vm6nsSXX3j3lVg/MHdDXyBBZTeYtK597yi53uKvIui2ccgbt86?=
 =?us-ascii?Q?26fPpNSVT55Wi6WW3dvPwdDAgGL6MXiwDT1OznjOUjt2BNesf7FMmHenE3bN?=
 =?us-ascii?Q?0sJ03ear+CYcIEhmbp6v5nwpV91Tp5hiQMkzkv8h5riT1ym/gQQXW1yj7JBe?=
 =?us-ascii?Q?dtrwbtOsY5QxsItpy9GXa91t8sp0P1a+tV9DDlPbk/NzDgQ9NLLNbYNEJFGe?=
 =?us-ascii?Q?7w4JXI+LmiwMmlCbAf6mVuxfDdjO3MzCcd9ZtRZu9VJJSqextuYBkxvYfArT?=
 =?us-ascii?Q?SEyJj+jCQw3bMBJ+PaEt0QG/BxhtPuLOMCsFfHBHLf1hbtN8D+2mXLA1oMLW?=
 =?us-ascii?Q?pAZZhFbnCIeq94qCJv8qSIjuvmoZJR+C9R9Ke8CwykLBSiAXVh5skoNq4X46?=
 =?us-ascii?Q?oE1P1ZJ5J2Xg4VVspBJvqWesXDehC2UstIQqsYOHTuptL8A4ETbI+ktUsAan?=
 =?us-ascii?Q?TxMaeZJGZhpO6VuAjxjsRC7hB5QhNNvBmQGH/TqjryAqI6K4IlEqrPjhf0qt?=
 =?us-ascii?Q?XVsFw7QMk2Rtk0UcW8CyK+SUPZMBL0cQ2mxFaVyFjc/7FyGZ6b4bkbdudp+c?=
 =?us-ascii?Q?f+Koy0R1CpiZ9czTgheK+vpqRVqxaM/6evomawGqW/Wen44bpBrBlL/EYnv9?=
 =?us-ascii?Q?SnO9RIYjKfbImcjRWpkCWLOoBsk6G4XqTtIHtHdHTRPeLwwFoXOHLYMaT7vM?=
 =?us-ascii?Q?ohZ/W1FeFpP0WqSgLLVjoUzmCALP1RCTIjTqDuein9aYzqLP+yZY7bbAl/Od?=
 =?us-ascii?Q?e0cCWTX497sq1reH3PhSSGuE2f8EYsQy87JvyaaUM7yopSmddUHPzA6KuXxe?=
 =?us-ascii?Q?CPgSe/BbBe1Gs5YE2042bV7auliWX4k9DgPrZ8fWpBbqW4+8FMO91n++QINJ?=
 =?us-ascii?Q?Y2UUjYSt/d7vqxRiPcDKDReD27Tzk16zpXXfUp/g5jIopBDkrBD//zgMkzID?=
 =?us-ascii?Q?vOYA8O87vBOqbCoD9y3PyNFHH8GVgNKkalvKbZFBHmE/4u9bePF93CA/NqNt?=
 =?us-ascii?Q?4ZVVoCr74EBjbdeQIEUE0lF6ChSG7vGlYVC5J2Eoz1tytDZENowWUO6eNG45?=
 =?us-ascii?Q?r8c7jHFlbSSGnhXl5AA4566hXYAluEQWUUW7wjuQeK/ZQZPKPxnLai98ZbMx?=
 =?us-ascii?Q?d9Rrz0Wa51S1k0RhsneK6hkxzvtYVnVyrDSbo7j++CJ2E8c0L8aw3LOeHi/p?=
 =?us-ascii?Q?8Uu1D69pMw28n7wlH3TEEBdLkByBUT1a1YAHezblFsUE1h+3dctLzL2vgZEG?=
 =?us-ascii?Q?3CKyfHWOpBjAiS0D5WgJ2yU5CAgO98NCJ7iFONBUo9yNGc2AHmSB1ApjVfsS?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 709f1b50-c200-4dbf-c006-08db7c7eee4d
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 11:08:01.0960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ie12qevwSeQ6aVdVvVopxyZ3bGZ4ymvTBewhYxhdViuDcbTx1mieyg7r51n4zZ5c+6jSxCujeRY4Mf34KwORZoY2O6jdm6H33aN+/XlTNPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 04, 2023 at 01:03:37PM +0200, Jesper Dangaard Brouer wrote:
> 
> On 03/07/2023 20.12, Larysa Zaremba wrote:
> > diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > index 613321eb84c1..d234cbcc9103 100644
> > --- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > +++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
> > @@ -19,6 +19,9 @@
> >   #include "xsk.h"
> >   #include <error.h>
> > +#include <linux/kernel.h>
> > +#include <linux/bits.h>
> > +#include <linux/bitfield.h>
> >   #include <linux/errqueue.h>
> >   #include <linux/if_link.h>
> >   #include <linux/net_tstamp.h>
> > @@ -150,21 +153,34 @@ static __u64 gettime(clockid_t clock_id)
> >   	return (__u64) t.tv_sec * NANOSEC_PER_SEC + t.tv_nsec;
> >   }
> > +#define VLAN_PRIO_MASK		GENMASK(15, 13) /* Priority Code Point */
> > +#define VLAN_CFI_MASK		GENMASK(12, 12) /* Canonical Format / Drop Eligible Indicator */
> > +#define VLAN_VID_MASK		GENMASK(11, 0)	/* VLAN Identifier */
> > +static void print_vlan_tag(__u16 tag)
> > +{
> > +	__u16 vlan_id = FIELD_GET(VLAN_VID_MASK, tag);
> > +	__u8 pcp = FIELD_GET(VLAN_PRIO_MASK, tag);
> > +	bool cfi = FIELD_GET(VLAN_CFI_MASK, tag);
> > +
> > +	printf("PCP=%u, CFI=%d, VID=0x%X\n", pcp, cfi, vlan_id);
> > +}
> > +
> 
> Shouldn't we use DEI instead of CFI ?
> 
> This is new code, and CFI have been deprecated (it was only relevant for
> IEEE 802.5 Token Ring LAN).

You are right, should be DEI.

> 
> --Jesper
> 
> 

