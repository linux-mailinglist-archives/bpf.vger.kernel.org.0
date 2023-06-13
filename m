Return-Path: <bpf+bounces-2490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E11672DC68
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 10:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BCA41C20B79
	for <lists+bpf@lfdr.de>; Tue, 13 Jun 2023 08:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6328BE0;
	Tue, 13 Jun 2023 08:26:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AB567E
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 08:26:52 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E710E6
	for <bpf@vger.kernel.org>; Tue, 13 Jun 2023 01:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686644807; x=1718180807;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u8Wpwvm9qGIaZS9KjEKJVs0xuuvnK/AIczXf8Xzy3Hs=;
  b=Psqw8LSvQm+TTu14Ci6o/Svyl0P3d7yK1Zgdb8IW0ud2QSu4PQV0vAr/
   ygwh8gsUDu7c8p7ZX/qkY7uw7VClsSJtEp41KSm+fUhjpJfu30/OMuHuf
   1tjUeT1tjS6jrrKWPvK3TYBTIgGazadx2u9uLwADNLmz+bRxTfy0zvFES
   GCtP+/JSvsprVYajqrUTe1pricAm+F7eQh1M1d6cMWOC5DaY81yB7jx27
   o3HlBWtzLLdXuVjLx27gY/bduuGtNWUbB83oi1h8UkuRclhvnhSZd85uR
   N3OgKY3ciXyaN2fxGim51V73ZWIS/Q39a06Pz0/kdpYCSYvf31v6ObgaV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="444641876"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="444641876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 01:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="741340186"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="741340186"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 13 Jun 2023 01:26:46 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 01:26:46 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 01:26:45 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 01:26:45 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 01:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jw1yyn/fOAqM7UsrH83YmUG/8e3ADzhCv34GyE9pEebExwR14ovts8KLQ/TGCkY0CGvaHyisaUIPW5tIbCnq362ZYhnpWIvbLUcs9zshHfw6NZ8RXgMHERXQEsjGY0g7L8E6yT9zqd2fZiyyYef5wu9yydOwWPzxyf4lJZ+enRH7Gz1dGm/9FMui0fNLx8+6RmvDxAEScgZEUCKIGMYSLjSA+eyK94zA5OfcV4yuOoVDImBW/C5+a1qYDWbf4EJ2wPL7VW8WeNWWIslqMu5K9oHbR25f8ds00+y5mD0UyqJliATNhXrbD0iKzbvP3KRs7tgE04Ua2hcL50L9U44mKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oCalRXzgDW1pJUDWZ29n4J1n1RdUMSNIBRbZcy5ILwA=;
 b=SJMtNNWxIfzMgS0jaNxNAWaM4CNDAMk9qCyTi4fAxjjn1vBXC2wMLcZnSAdapIDndbJIz8STt+Aul8Jyl3YvfcLryh8l32/EqUqNxjESgC5FLB1vSLPmfVpdXKbRvHyoXvfZnvlN24otsPFUlJYbGGCVYuUHYOUvzxckhZgay0IpodQ245o9x0gFhauK773HvrB6FOjOnQ54543+PoTj9KdnS/5G64zeDfgyaswpIn4PWbO1x9Nw5Dmxr5eZIcNMRZBTMN0EXxUbAKYkJTJWQ4j4VlDA4nFYHROwy9zoGseAFlXqHWXRMb7DTTqmIleDp4DUEJB7ROuxX+/lXsEX6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CH3PR11MB7896.namprd11.prod.outlook.com (2603:10b6:610:131::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 08:26:37 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::5486:41e6:7c9e:740e%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 08:26:37 +0000
Date: Tue, 13 Jun 2023 16:23:29 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Anton Protopopov <aspsk@isovalent.com>
CC: kernel test robot <lkp@intel.com>, <bpf@vger.kernel.org>,
	<oe-kbuild-all@lists.linux.dev>, Joe Stringer <joe@isovalent.com>, "John
 Fastabend" <john.fastabend@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new map ops ->map_pressure
Message-ID: <ZIgngQXrlaCtAYgl@yujie-X299>
References: <20230531110511.64612-2-aspsk@isovalent.com>
 <202306010837.mGhA199K-lkp@intel.com>
 <ZHhNqDi7+k5VzofY@zh-lab-node-5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZHhNqDi7+k5VzofY@zh-lab-node-5>
X-ClientProxiedBy: SI2PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::22) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CH3PR11MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c074fb9-ec74-4427-ebdd-08db6be7e7c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jsgDneOK3vpd8VJVPHxQnT7xvZDcr+FvERj2JvcFMDvZlJxxpWjj8qamRw7D7zIuxOj+FEagfWZfkn70rOv8pptA/UQcuVahc0p9CE3Qj6ZfOgTqXeOwTu7El8mURdIiC6nb/xZTj5zh2+w/MPL76pxkxDKFj8owU5cq39FCa0oNtzQ+W75dLX/IgjKRhhoBjD2YES15PY7oOsQeOIMAPbl+h83foVtxmlOSH6y4tmiq/CfZHJgDo9xaQqCP4gzIzq7m4I6sYami1KxoFlVouFxrvhuCHuwKrFVXXAcGoBaVGGLW4gVWXc/bmuK/1o1FoT4uSzgeicossUKfyuO3jqe9uC5sjaBGEBG7RmR4qHMfPf/CvVGAaHa1rTY7lihdQEJ06//QnJjMYizKmuridVRI4vbRkhY2BXaUOsLEVkWkuTCcvG6MQnuzD/krN01BeAECDeM1bTyX02uHCPx6vCg+YIIsEmajbJWZGBFlzGZxGTTR7wZEg22wVi3o/8EOYqRUH6qjiNbOWfOTi/K8fOq6iKv9KZfM1zZpaAaoD6/YZfJ+t+ONAOy1W78JgaZmHHP7MCSxTYSybnXSRDd6HQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(5660300002)(54906003)(4326008)(66946007)(66556008)(8936002)(316002)(44832011)(8676002)(41300700001)(2906002)(6916009)(186003)(66476007)(478600001)(6666004)(966005)(6486002)(9686003)(26005)(33716001)(6506007)(6512007)(82960400001)(83380400001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NttFAzvxivsuwBrqIGz0CEH5vQURgvbkrS421128ZjaeTI47bxd4648rZxqP?=
 =?us-ascii?Q?V48SuZimjJXVx2Ws/v2ukC6aE/QYfSXv2pA1pcD8xrIjvR7A2pf1pmigOUUi?=
 =?us-ascii?Q?x2+gEaNb+LpHytC+XX0nEl2yJKZOnmjQP39dBz6ALsbiTjsuoBmO94GX33gL?=
 =?us-ascii?Q?L8pgl3znS12NDiq5HTqGo2r3cGqVyS1sJ6Fau7PF4T3bAJNiAHiMw9WBbWyH?=
 =?us-ascii?Q?oHN9rYmSBFTvH4pLNguB8VAPH9ovZhJ4n1tHDKg6y3FW6JM17ds2i8Tkttn0?=
 =?us-ascii?Q?cZddo7Hhpu9+p50Z/esC/zXrTI1iUt5wpKAgMsbKQORNHCDvuAmYV9nbzSdU?=
 =?us-ascii?Q?VXhztgwT/lycVaJM+METuvfN3XB39j5P5cTZfvdaS6p0Ww/CZ+5nQHWvcSaP?=
 =?us-ascii?Q?nApXH+lXPL9wXBqRgs8RAbKAbzVnsibySyjUsqiPEhrRXOYwbxMyFpIg0l68?=
 =?us-ascii?Q?vuuzJSjCCCvcwWmD1ZiSFuS4SM/gwXfkTgxTb2ReafYq/BuAc5LignRqvTLx?=
 =?us-ascii?Q?0umdwLjSZzsLcQOaCk67w4TASCQF2vqIityelX8UUMQv8JHPU4hV9jmC2fGZ?=
 =?us-ascii?Q?wbTlvCKGRji3SkdDXZV+XNSYvj0m99RGmH6qvQHSckdHxMnhWzTz5y2o9mgD?=
 =?us-ascii?Q?m6hz8GSiKJ53JP9KlvwLILAPUaEyigTgjiRoWXEalltejkqTKy+zbwV4mi9x?=
 =?us-ascii?Q?sS/zfJflNY4kS2Uk1fmA4qWozepMGPHk0vgZbrJMPE39ME4HDzt7RlIZcnFa?=
 =?us-ascii?Q?mlsjxZc0JaMnOEWnPXPxd1Q2+749at8bfcOI57rIwa2tfDazBIHQOR0WbnIE?=
 =?us-ascii?Q?aZVXlByMfsPP/dZdj2mVSHPfmR3xaGrBlIIT93w+qKHOGzuR+d/WwoZbz3nr?=
 =?us-ascii?Q?NL2kA9yKdW0ylkN63pom2CGLFTbls8xUkOVFprJGcPZsfihJiu6uR+pkufyn?=
 =?us-ascii?Q?KKo1lWvciSsEzhkd/BbKwLaAfaE+8pmnHFQ4m8GlX/zaG/X56djtjSQrW6VT?=
 =?us-ascii?Q?VInsAXzECOsZ6p2e2ZPKJFrtREc2oIVG2E0jvVIBRDhlJwS3qd485rsJccdc?=
 =?us-ascii?Q?xq8UOg8cIbDsuMF2Axd/4dbwjwbuwyd5cUTS0pePcJjzvTNTaBQUNLX2Ie62?=
 =?us-ascii?Q?LA6E8SyxUomWoJkjWsq7aRLHzmL7q5H6waURfTF/4BtKUER7ZKWqfS8+yJRX?=
 =?us-ascii?Q?uLxnln+ytkyTq4JQKGIB3c/jVHIQO7zBEUQVicC4kgIJxv5FNxAkVqf3ztsk?=
 =?us-ascii?Q?n3C0zzZeZrp97mASHdnmgR/CoqPzKevEdHt3lJty86LyYEfDVoLy7iIEgfLa?=
 =?us-ascii?Q?MYO9XjgyvW1KBn8M5eeqD+jKLYbn0reFo+G8uwqzxRtZUcYZObNjv2+WYoFS?=
 =?us-ascii?Q?lt8d88F9cCtBd2eS8+DeF836zX8A4fArDADqDx3av+3pERGbSJj1NnC8Pu0l?=
 =?us-ascii?Q?8Sr6xoGhboQo63iuCtlnhKUw4sNREuBEl4SbND4/F7iFeyygeJWnVYUWMgAh?=
 =?us-ascii?Q?9CwLA7uAfuigpXYmVVT76A53yDgBo+uu2LOoMsE1b3t3czlbSik1AFQWv6rY?=
 =?us-ascii?Q?AlUkVFCSbyOj8B5MC/iZHH0E6Xyg4wEg2fwNV0j2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c074fb9-ec74-4427-ebdd-08db6be7e7c7
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 08:26:37.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xjW/IDQ9F57e9v/rN9L7D46opZk2YrUuw13BKI8DY+FcNQQo+j87jJyRC3gGZhzohuQTsNGazP57yZha0KtHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7896
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Anton,

Sorry for the late reply.

On Thu, Jun 01, 2023 at 07:50:00AM +0000, Anton Protopopov wrote:
> On Thu, Jun 01, 2023 at 08:44:24AM +0800, kernel test robot wrote:
> > Hi Anton,
> > 
> > kernel test robot noticed the following build errors:
> > 
> > [...]
> > 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202306010837.mGhA199K-lkp@intel.com/
> 
> How does this apply to patches? If I send a v2, should I include these tags
> there?

If a v2 is sent, these tags should not be included.

> If this patch gets rejected, is there need to do anything to close the
> robot's ticket?

No need to close this ticket.

Thanks for raising above concerns. We have updated the wording in our
reports as below to avoid misinterpretation:

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: ...
| Closes: ...

--
Best Regards,
Yujie

> > All errors (new ones prefixed by >>):
> > 
> >    kernel/bpf/hashtab.c: In function 'htab_map_pressure':
> > >> kernel/bpf/hashtab.c:189:24: error: implicit declaration of function '__percpu_counter_sum'; did you mean 'percpu_counter_sum'? [-Werror=implicit-function-declaration]
> >      189 |                 return __percpu_counter_sum(&htab->pcount);
> >          |                        ^~~~~~~~~~~~~~~~~~~~
> >          |                        percpu_counter_sum
> >    cc1: some warnings being treated as errors
> > 
> > 
> > vim +189 kernel/bpf/hashtab.c
> > 
> >    183	
> >    184	static u32 htab_map_pressure(const struct bpf_map *map)
> >    185	{
> >    186		struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> >    187	
> >    188		if (htab->use_percpu_counter)
> >  > 189			return __percpu_counter_sum(&htab->pcount);
> >    190		return atomic_read(&htab->count);
> >    191	}
> >    192	
> 
> (This bug happens for !SMP case.)
> 
> > -- 
> > 0-DAY CI Kernel Test Service
> > https://github.com/intel/lkp-tests/wiki
> 

