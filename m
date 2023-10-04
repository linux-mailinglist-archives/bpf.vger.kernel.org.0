Return-Path: <bpf+bounces-11375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A82477B80CD
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 15:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 36E501F225A2
	for <lists+bpf@lfdr.de>; Wed,  4 Oct 2023 13:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9514A86;
	Wed,  4 Oct 2023 13:27:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371A3FF1;
	Wed,  4 Oct 2023 13:27:09 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3986A9;
	Wed,  4 Oct 2023 06:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696426025; x=1727962025;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LiQXgi/aPL21RNz6hpOhfWu8bXXwUMkLtiGalAmx4Xk=;
  b=ITKy1iZG6rGHJiUuOIqh4PL6W37ttovTVqEzEqqfZN4kAi/vsNNOUZ3n
   4c0ULu3TkTTiovoJli4z+c6h1RUWVAoGDZckMA7SUyE6BdDVk86xs9LVg
   EWaLdljkE4ByyuzxR0UZZYZ8enq/2F3DyRqS8Mg4RLgRMyF+zs22KUwBf
   6Y2vuWjubq2HQlV9RwDYGBdlbBpYtseFVJQjSSfYp9sTb+Gl+QPrR753r
   dweI3WOA5E3TEsoDKS9MKT6AE4/6NLrMCVVUa0Bj13ZtHxwLC57Lo9aTj
   oUiRTYR73TbmGUhRupna8QE7pIR2cTsYr4V5wY0O9dJ3/dzNl5PTSjkcF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="385991520"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="385991520"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 06:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="1082502414"
X-IronPort-AV: E=Sophos;i="6.03,200,1694761200"; 
   d="scan'208";a="1082502414"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 06:27:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 06:27:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 06:27:03 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 06:27:03 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 06:27:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itKsJKDc+HrvacgUH1NAi9Mpm9T+7inVzWk6iSdU8RUIOgKi4K3HqblVYS794cOCtdx0AnF4Oq5hAP43fkDSCEsR4Y2lkFDbLAHCp26et18PqsMXBhHkx7o5In9uEa9l0kkiTjFtQC+aGFFDRIVM5WK4AHSw1a85LexjdgaiPgaXl8Dt8YHikW9faA/3RpblB2jsU75MStpQIIPNQM7BOYWbUyW7CZLgc0LzVboK5TzhoK3Ia/jii1qGr0Vx2DVP26jVKPauRUZdm77571Id2mx4RxaxlbfB235jl42SsBsHR4Y1yLHuc05e2jGQgJ6Gbq9rMnzC32Z5qNKOLlM3hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQOdmQ60LlxDKUixu75aULMbncaCPL4Aw/CyJ6sfsW8=;
 b=kR5TNWbQEWY0BQaCbZcKu8hYWnllEGY+Lxk9mK6SMDKvaJdTb7W8GpjPYvtz6JfC2FPHllc/MhMOa0JlHGYuJ04Wim98h44oggrVx0xM0LDA1ySTdt6jj5D2s7DyB2dR4sU5V1/3rYfYO2dX1Z4ONo5sWIRfJ+dzx7YVpy+ie9um7HJO/6eKiemZmc6uUgk5Ir0fZuWuaKWAjV0Gq5I37a6PurDEIkLI75yyjHPtjH0orAVPqskmYqxxrbn/p/t/x+jBcguH0FK7et5j4C6ziHh68M9jxVM51/x/z0ZI3F4m1dKzFDnZOSnioCppk+u6odsCtJahwnrQydwI3PFvGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB7418.namprd11.prod.outlook.com (2603:10b6:806:344::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22; Wed, 4 Oct 2023 13:27:01 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::551d:c6c9:7d7:79cc%7]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 13:27:00 +0000
Date: Wed, 4 Oct 2023 15:26:47 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>, "Kamil
 Maziarz" <kamil.maziarz@intel.com>, <magnus.karlsson@intel.com>,
	<ast@kernel.org>, <daniel@iogearbox.net>, <hawk@kernel.org>,
	<john.fastabend@gmail.com>, <bpf@vger.kernel.org>, Chandan Kumar Rout
	<chandanx.rout@intel.com>
Subject: Re: [PATCH net] ice: don't stop netdev tx queues when setting up XSK
 socket
Message-ID: <ZR1oF7he5WaToeR1@boxer>
References: <20230925171957.3448944-1-anthony.l.nguyen@intel.com>
 <20231003154920.6ae3801f@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231003154920.6ae3801f@kernel.org>
X-ClientProxiedBy: DUZP191CA0040.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a627552-20cf-4945-5a41-08dbc4dd973d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71KXbIqmDq2VMdUQ22nhooxtdjwAdsCTe8wmDwwDHk03Rh9Oh61iWxz2hMNsCBz66e8g0hcQIGemJOafQU4CU6lWwUixfqZekPFt9wHq/Jhkux1eLbEGODbZHt4zcZI2HSnWQJ+rQxkfMJJDeD36/kTUutMFk4G6AOAhubGBzXFg8R/AxOeA6IpDyrN5tBd3zHqoMwvP+MqWhpfCgfzP6pldWZR1OehxqdasG5wJN5U5LiPeDP5DdGGr5Gd1CcJsmct9iTCh/R3Uzb8WpcECqANYV4esKYRc1T1pzDFc4IjZKmaN0fiQasajY61TeRSd/BnXdEnHd5AL9APdT2uiVaReHD7HvNqN8ytqZEwqKT65Xngfk60W6lFVjEvZWkp1d3MvBd/2WTx4v12CENXRnq184bqZFGz8i+xOjJj0XsAZ9Se4BCcUigAGOMMzDpqHvhlfZ/+mRxYSzag56lWFDM4f4g4x7dqQy/911VQGnG5Jx6zUC0uS0ndObi6HjZ1Ax4OoAav65d24XbWmiUSwsWdz1bpKpt7wX2xJ4IS7/Dc1aBaU7LVZgh78luVYM57l
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(39860400002)(366004)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(33716001)(2906002)(4744005)(107886003)(26005)(38100700002)(6666004)(478600001)(86362001)(6512007)(9686003)(6506007)(6486002)(44832011)(7416002)(41300700001)(316002)(4326008)(8676002)(66556008)(6916009)(66946007)(8936002)(5660300002)(66476007)(82960400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m2Z5ff/CsVgDC2HSBnZ/7nbBAcgdohbjYLY/lLHGDAoXYq3dhEZ+Qtz7pUp5?=
 =?us-ascii?Q?6ZBuJAMIlhE54p1AKK1wf3UMIv7d/MEFxrYHCqRAWYMQ2d9DLd/mUAWDjrcK?=
 =?us-ascii?Q?sIcWGHmwpTYNFL02k1MRg4hrQyzcmnDGEL4s2Ps+l17aWD+2USbwig1O1Ala?=
 =?us-ascii?Q?hpSEGLS8ycK1cgc4A++WODM8W/exc3uS2uZVYrGl1VdGYOloYak1+cKdszY9?=
 =?us-ascii?Q?tv7uLHBMjYHN35iXy8+9GWkHde6PjJLI1aOfwV3lZs61zXPWU7kGpBl7CpiY?=
 =?us-ascii?Q?52Ep9t0uO+QU+jMb/GD1McaH0Uzzlbu8RPde6Fjo5+H9J2mI6eD06sVJF+rA?=
 =?us-ascii?Q?Q341GbWNO6jJtJEBjL+XxE3rAdVIwsgoS3RYlswCv3Inh4R4q+wSumQNNgUW?=
 =?us-ascii?Q?E3kO9gZwXsXeNiJJi0p+umBf3YnQZVBRxQCrJuWu9XfCx3xwELGGGFsGgpev?=
 =?us-ascii?Q?hN9GWUqi1qtqXO2PF+K9M5xM6Ui6cUJ5Fc423iJoQ+JqWDbn5tZRKV/x233H?=
 =?us-ascii?Q?DLW8sMulLFxz83gKn7CrO1QMXKHPbf+XNoq4BxHuHozk8kfwzKhbFeeB110d?=
 =?us-ascii?Q?fk88AUzzuP080N+0zMC/pR5tCzaLSyDRtYA/ZuV2edvNTxvpDEOAWTqqQAej?=
 =?us-ascii?Q?PCPobKNh8yZpNax6XI26CfLstxBqjY+EBXPUxg1rVtNf+58ieqKnk02lWzhW?=
 =?us-ascii?Q?kkUyyjkOuEzz5LDtO/7t6NGyj9HtdDCfLTI2tdA+nxi47wgjjzW/YSJvFjYY?=
 =?us-ascii?Q?XeLVhq0iVnLLtOHeTNNu9ZN2ViUF0jUURIroi0+XVMlopM9lASSGHjIHlX/P?=
 =?us-ascii?Q?WihJSI92JYAibqTkkiOPAsMFU1nBf2mbruSQILwH3gNrFxP1lB/RkyfT7A9A?=
 =?us-ascii?Q?0/leFh3AOOhxj0aGEgXXMJdMbX/UTxd+HoIkhBv5f8dQTifFkmIKVUzmO9M2?=
 =?us-ascii?Q?vQ8cg/uXSJdFPYdc7Z8G/Hsck+8Md1S7oEBVXaMgXc02oTlzQajc3jtkytky?=
 =?us-ascii?Q?9rnBrsm7ZMHzYikM2PGDDBUOo7M3EFnA6eomf4GbyfM6nC/fE4KAxeFjrGgK?=
 =?us-ascii?Q?WW6sZAiaexOicauZnAzRvfVuiZrqrwt7ylwmCF14Esvvrrq4oavfVw4ZLD8R?=
 =?us-ascii?Q?Kr9GXSe7UfcMRj5vrMTWOMAEhrn6KsxEFus24PmYJlU4CP1bqedTwj6THwiq?=
 =?us-ascii?Q?2rclXl/F1N2U84YqKrj8tSHvIZT7VikG/67QfNYZErtVoIVtXXJ8Fou/xWoR?=
 =?us-ascii?Q?SjgrosbkaxR1ZFwNMjick4HNrt9y4EG8L98mZ/Rb4d2mwM81gStVpwwei8w2?=
 =?us-ascii?Q?SCLQz5AsCuOXFnODZD7N9Uc35u8iBYuGZAOtjRCC+IU/2i70hYQRBq+8ISrn?=
 =?us-ascii?Q?5t3wvwIS+I1CE6/i7lqo09im8mTbIrE7fJx50+pIsYs6Yf69h/EjZAnqmHeq?=
 =?us-ascii?Q?ihpMz1QLYpORFhUNRSjSXi0JrtY98dJWZjtko0/bsSkXwxHQXd7nsXWa57FK?=
 =?us-ascii?Q?GhRCYOSbiGKoLkb6qH0vSf+kx4A6ujbmtDSEwyZ1tJMwigvch6rM84ijAV1O?=
 =?us-ascii?Q?ORzTxZYs9/3uAPEnQcsG3nOUqo4bpcI0BziflGO9rFMF7Xk8tSpgSt1WbOGt?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a627552-20cf-4945-5a41-08dbc4dd973d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 13:27:00.8936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzRmuVTvTemz7+NHLnvRRxgS6cO8KmyI/xN84VQbcisFHgSJF6882IyzWn7gx9up7vyowCWIl9Fw8y9pmqS+EpG73LPD4LhV1gcNeBDR+tU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7418
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 03:49:20PM -0700, Jakub Kicinski wrote:
> On Mon, 25 Sep 2023 10:19:57 -0700 Tony Nguyen wrote:
> > Avoid stopping netdev tx queues during XSK setup by removing
> > netif_tx_stop_queue() and netif_tx_start_queue().
> > These changes prevent unnecessary stopping and starting of netdev
> > transmit queues during the setup of XDP socket. Without this change,
> > after stopping the XDP traffic flow tracker and then stopping
> > the XDP prog - NETDEV WATCHDOG transmit queue timed out appears.

what is xdp traffic flow tracker? what do you mean by stopping xdp prog -
or you removing it while keeping xsk pool present on interface? or are you
just downing interface?

can you provide steps to reproduce it?

> 
> I think we need more info about what happens here.
> 
> Maybe ice_qp_ena() fails before it gets to the start?
> If we don't understand what happens, exactly, we may be papering
> over other bugs.

+1

> -- 
> pw-bot: cr
> 

