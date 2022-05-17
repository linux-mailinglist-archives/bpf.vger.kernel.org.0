Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C278852AEE2
	for <lists+bpf@lfdr.de>; Wed, 18 May 2022 01:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiEQX6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 19:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiEQX6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 19:58:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FE63CFFE;
        Tue, 17 May 2022 16:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652831930; x=1684367930;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o4T7SgKPbCVADfWqcMWudzlgX1r/cju8q/bYni9TqQY=;
  b=CmOtD4NNwN8ltTRjboQ+AfW82Ez6SpbccXr0TZLxfS3q/mA9mLrRyNo9
   kN7AZ3wfzSnshO9Y0dtSm7UI+to8zUFYYUICE4soHibgFqHaYAkyat8rT
   Cw15Z4lz9Vc2l7naKb68ZD59HO18yYJdc0h+42G/aZ9HujTXm/8YVwQXi
   OeD5RhwATs+MSlqVY8ujsAzaVbaj6TZziMJ6zUMF6QAPHQQasMycrYW4X
   S0MVJDXaJNgufg56eOMPjK3oipQU9uSAOrCJm/bCkGiJKd9/dMkJ1Xr2m
   y/qXWJfbXoGI+vUhgxeENedc/4yqfzizK3nEJExxxL4H1auKRav5MK8At
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268973040"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268973040"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 16:58:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="545143785"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga006.jf.intel.com with ESMTP; 17 May 2022 16:58:47 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 16:58:46 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 16:58:46 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 16:58:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 16:58:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUdTDpZbltZ74yNUEpa7BpmHao/pmfbqx3ceA2L3zoyTOskPh7UtR9PogZlhXpbfCTV9HUwssyuI0FKhvZrXgkfThXpi5dZLfD1I9k9FbpENlRSv/r3MEBu10LVuF39CWIkGG2vd1fvPe+4O3b9UIwbjY0Q2aQZAViI8ZsCMXm7B28T6p0vByIgtQF5vYhUWQ3s3uOa7YuDqscUzf/kdMk2aLwj+nki+wv0SuEQHu2py+droVNFLerxaECYBj+q3PQpSq53EramoDLJHR2o2nJ3D+MWtYGWwTx+0KUwE2m9o/OBCyRXuHC/Tan970EMU3wysu++N9odM8AfGC1HxHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o4T7SgKPbCVADfWqcMWudzlgX1r/cju8q/bYni9TqQY=;
 b=GpFraayvornAamL4FhRbOqUhyHV4szu8gFUZ2Sm3sDYv2WarlfBKOycZKEe5cI819Ocymatowt9BygiFGUlTWT2Aci5DBFdUAn40WvE4tnN3uwsRJHd6IWQzibY4YhVsDrxXabXU7jW5HAM7/l3iSG5AmEtOPCYYmsppGzoVI4/cg9Jy58SoYSRph75m4PAIKcQ9KzGdH0SLp4Ny+sc4Vaas3HbYQhC8hetWY/K5DCfboTaoC72af7Y4bBPZfATLWaOgDSWz/MTgoi/46W9iofVRAdagrswxVPBUxEd5WWzz8gkN5rS5+wq3Fc6hzulym57QxXCz660ZRmdaPCSVoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM5PR11MB1660.namprd11.prod.outlook.com (2603:10b6:4:4::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Tue, 17 May 2022 23:58:43 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Tue, 17 May
 2022 23:58:43 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "songliubraving@fb.com" <songliubraving@fb.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOe12KXACXSTpU+YN3bK6iMF8a0jcwCAgAAfpACAAC+eAA==
Date:   Tue, 17 May 2022 23:58:43 +0000
Message-ID: <dc23afb892846ef41d73a41d58c07f6620cb6312.camel@intel.com>
References: <20220516054051.114490-1-song@kernel.org>
         <20220516054051.114490-6-song@kernel.org>
         <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
         <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
In-Reply-To: <68615225-D09D-465A-8EEC-6F81EF074854@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dddeb33-48ec-4140-0858-08da38612c40
x-ms-traffictypediagnostic: DM5PR11MB1660:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB1660FDB1ABF15CF606A6552AC9CE9@DM5PR11MB1660.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lsV6aFpbE0E0p9oTdOXtqLn/K8XYrDxlCnzee/8mViXbahJsUnT7AV0SLKAQRW3PijkG08+bNuqKGvtUpDgQ1N1xfNAvFEAxunW3fPFiW7qRCvopuZOu3DN99/bNzPDpWBipaHtRqzr0FQJYUc0q1VF0SAeGDD3zeVGNwZbtyFXXbbBNZWxFLsk/B78RgrobhRQ6I6DBq23fEWZNQz3tCq04c3hIFZmtsDBpZ7JZpd0HGTrgrHqQxXGtrxuUo5jnJ2AyOgVYKgu/7jOjPwdGiWk9Hbu8KtdsNFh0ob3lyKm83hbKgsqmNrCvBRMYw3WceYk/WNRP2mO1GQAKRoWrujvq2UqgEjr8EFKzsd0nYy+gf0+fQyAzydbEN+1h3J8uL4Van+FkMfWoMLu0u62YLbjZ2tYP4SPtCQF3T6toJrm26OhvKKRupDdCgzd2i45/e910dYB+N12KX5zKU/Ge7YwgF4o42iuViUhb6dJ6v53J4je5R1+KtansII5cMnQGd/bCqsZ8LADewl/HOmN98y7+GCZsroiJ1Vjr+0GupZ++4TntN6jKhQOO5HNJJqTk/OGzbMww/ZzOQhpPup4RTVWVlfpCmUqwgyu/971z3M17F5aP/pXo+P2c8AoVAgEinUnevSsyAPzG+l5JOd6IjH1bJEdtVDoODX8gKMOY8rcPcb8QaB0n9bREcWoD4kiud+QAripK8rBdWyIf4oVprX0vaLjD5c39Rsd27OgnpTqjw++1AJr9M9LOcwzTR2FQImaV3tYRuwuVD7F06Nq7pLuZd4O0nQjEAYmqbIwwmymf5inKr5K9UHFH66aVwKeV1QHFYS4WpQwmCMTJwZRvjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(6486002)(66446008)(966005)(66556008)(66476007)(316002)(508600001)(64756008)(54906003)(6916009)(38100700002)(38070700005)(122000001)(8676002)(82960400001)(86362001)(4326008)(76116006)(26005)(186003)(71200400001)(6512007)(53546011)(8936002)(7416002)(2616005)(83380400001)(5660300002)(36756003)(6506007)(66946007)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHhnTEQyL2lndzA4U0VtWUx4dmhydkZSUHY1em8vMy9zNWhnVjZKdlRhSEVu?=
 =?utf-8?B?YUlpT2RmR2QzRmdLZytpU2xMdmJNL20yNkUvd0plSE1ZQWNabm1rK0p3cGZY?=
 =?utf-8?B?aTNHN1lrc3V3bUIvcWh0Z3d4NTJwckR3dVdOeVZERDVlMEEwRFZqSnk1MDlu?=
 =?utf-8?B?K1Y3cTM5VFF5UGdUQnlpa2ZIbzFEeEV1ck51bWNkUVFjMjMyUGh3dlEwU05n?=
 =?utf-8?B?QWQwTzJQUitCU0RiSlhhOHdwZ0ZCOHBGVlBBckRJcm1LK0RiLzErYjJZY3dV?=
 =?utf-8?B?Rk54RHJoalJJdVExNUdUUFc3VEc4eCtYV1ZCWjN5c2loU2NkeXJwMFB0Z3Vy?=
 =?utf-8?B?bE82WllxSHdJOFJTalQzajVIUSsxZmE3b2JOYlV0dVRybm5sRXUxV0hZVHVS?=
 =?utf-8?B?OFhZa0k1dHdUaHN1VGd3ZXZhTkpGZjlRZlpqTGNoSjR1eGwvRUJyVUU0RFd6?=
 =?utf-8?B?ZHlUNURFN3F5RUx2Z3paZnZFOW9BQktDbEQxeWxnTDMwNEFocHI2VGpIa1NZ?=
 =?utf-8?B?TEF5SUUyOENtSDRrbURuM1hDUyt0bkI3ZGRLbEY0QXBzUnBBTE0wTnRQN0Mz?=
 =?utf-8?B?Z3J3OVl5YWo3SnFqdWNHZ0pLNVdka2hpSHB6em9tNHdVaHJoNUVwYkNTUkgw?=
 =?utf-8?B?VlgzY3lOdnlXM0RaNHgzR3lvQkZYZWFjeGFxV2g4NlNZTUJNMnpaOEFwMGxv?=
 =?utf-8?B?ZjdkbG5PUWl1MTJsS2I3NThQV3F3Mk93SFB2OVhvYXF2RmdoVXIvSGhtZCtu?=
 =?utf-8?B?OFczN1dnYTQ0dzJxRmV3WnEyN29GS1c2YVRIM214VnVwaHdGUGU2T0pMdjFE?=
 =?utf-8?B?dGpZQWdKcGtrM0NvOURWSFkyY1k1bzkvUzNBeTU5RllWOHRzT2tBSDIvcFJT?=
 =?utf-8?B?Vll1djFIMXo3MzVMbEI4dWhsSk4weDZkcktWNGptRnZRQVhNN3N0UmZSaFNp?=
 =?utf-8?B?dUR3d0dwektIQ1A1Y0g4TVZMWC9ScVduYWkvdGsrMU1IQWRVaWk1T3BBaEpr?=
 =?utf-8?B?VFFTZHVKc1NHZjZhUTFETHNwNGpIUk9KaTdzdHdFUzhXck9jSXB1N0I0STJG?=
 =?utf-8?B?NVlZOGMvak5TNTYydG51NWJFeitiRVdDNXZUaHJwUGpuU216R3pONUs5cFBZ?=
 =?utf-8?B?UWIyUFRiVnU3cDNEbnNFWHpwUzh6Q29vbmtaMm1sdThDL0JYdlpIeURlS3FS?=
 =?utf-8?B?VTJzQWJDQ3M4eUVVVjFQV1pLVlNtUDgyK3BNcW51VmVYUnVUWG1QeFltVFlX?=
 =?utf-8?B?bWFUWk9jUTVjYlJyL2VQUTE4Zys1aVdUMlEyY1lsTlUrV3RHMlJqYXA0QmRP?=
 =?utf-8?B?emtrSGg3MGpSNk1lT2FVeE94NUVkbWpiWmZzamVMRDQ1aFhmSEVqcGZ1dnpK?=
 =?utf-8?B?TTlBQWkzakxhRkxiOStid2x5TGpxY2R0TnUzUlNlMHdnbUVwNHZoc0Y0MlpV?=
 =?utf-8?B?OEJ5V3VlNDI4YVdvZGdDVDBlT1BEMngzREtURHVOK1Q4UlU1NjhhNFNPM0pk?=
 =?utf-8?B?VnczY240SkdCdEpsNUU0NTVjMnFZRHJEMDEzZVRtUlNpUDE0eHBMbDlxelpK?=
 =?utf-8?B?YlRzeWlnYWJ3M1lRMVZxU1hqQzJWMFBSd3d5VnIvZkdyRjNoRHBmM2pseElF?=
 =?utf-8?B?ejB4c1BITHZkU08yTXRTWm5NSEpqR0p6Z1BWRkpSQ3ZkR1hCOVZ2MnVocHJo?=
 =?utf-8?B?VGR5cnBFb3pJOVc3eVJtQ2lIeWJ4L2tjbWsyWElIQkg0NGdiS011d1dpMXpz?=
 =?utf-8?B?SkhwWklKWkQ5YkhvUzhFRmE5Y055OENGYUlnZmZuMUNKYzV5czdmMHNzbGNJ?=
 =?utf-8?B?dXMyWmEvU0pOSktNWkc2SnhGUUYvditOZ0o1eWtsbTU4M3pYWkQ1Ky9hNFVQ?=
 =?utf-8?B?dGw0TDA0ekl1L2lCWVJwODF5Z0w3VDNFc3hBVzh4UEtHejVXMmxKNHQwUDhm?=
 =?utf-8?B?VGpQcENyUm5ROWgvMTIwTlNDVEF4cXJpNE9vZDZpc1plZE1OVk05amlCcEU4?=
 =?utf-8?B?VmYzcHZndHRhckI0MjZHWEltd0Q1eGRQNGRoaU5QS3dsVUVtMG1WempVaFBo?=
 =?utf-8?B?emhWSmhGYjgrNjd0R1UxQnora3NnOXpEaUpMTVYyb3dyM0doNUtBeVpiSW94?=
 =?utf-8?B?aW1iT1hEdXNNd1owcHhMTlFhWmlma3p1UGJpSG96bU93RklwRUVTKzY4Zzdz?=
 =?utf-8?B?OHB0bGxjVEs0SnpvMEJMYzloRkZDSk9qU0tUcEFYaFdCb09uaHFaOGNmTjdS?=
 =?utf-8?B?Vzh5VHJpK04rc0QxVXJML0dpQmZvL1JsVFJtTUFtekJpa05IMUIzeEl3bFZk?=
 =?utf-8?B?enNLUkVuOFZxVjNMa2xBK1huSll2cWRuV1R4UXFncFlvWW1kZktYU1F2M3Fu?=
 =?utf-8?Q?uXsRBOfKsEIpIvTxhKDAy7yvyY1RHmc2V4Lem?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A9D0F2F98CB1C4280C643178B6537B7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dddeb33-48ec-4140-0858-08da38612c40
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 23:58:43.1411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jWtRk4Mtod0nDFaYuhXDjtevjSZxvYvZwG9vAGOyutE1y7dijNhDGFh3QrA+mO/BlJDGZE5KOEF+I/TEq8YUexktDTPeKuBaV9PRxOJMxdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1660
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTE3IGF0IDIxOjA4ICswMDAwLCBTb25nIExpdSB3cm90ZToNCj4gPiBP
biBNYXkgMTcsIDIwMjIsIGF0IDEyOjE1IFBNLCBFZGdlY29tYmUsIFJpY2sgUCA8DQo+ID4gcmlj
ay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIFN1biwgMjAyMi0w
NS0xNSBhdCAyMjo0MCAtMDcwMCwgU29uZyBMaXUgd3JvdGU6DQo+ID4gPiBVc2UgbW9kdWxlX2Fs
bG9jX2h1Z2UgZm9yIGJwZl9wcm9nX3BhY2sgc28gdGhhdCBCUEYgcHJvZ3JhbXMgc2l0DQo+ID4g
PiBvbg0KPiA+ID4gUE1EX1NJWkUgcGFnZXMuIFRoaXMgYmVuZWZpdHMgc3lzdGVtIHBlcmZvcm1h
bmNlIGJ5IHJlZHVjaW5nIGlUTEINCj4gPiA+IG1pc3MNCj4gPiA+IHJhdGUuIEJlbmNobWFyayBv
ZiBhIHJlYWwgd2ViIHNlcnZpY2Ugd29ya2xvYWQgc2hvd3MgdGhpcyBjaGFuZ2UNCj4gPiA+IGdp
dmVzDQo+ID4gPiBhbm90aGVyIH4wLjIlIHBlcmZvcm1hbmNlIGJvb3N0IG9uIHRvcCBvZiBQQUdF
X1NJWkUgYnBmX3Byb2dfcGFjaw0KPiA+ID4gKHdoaWNoIGltcHJvdmUgc3lzdGVtIHRocm91Z2hw
dXQgYnkgfjAuNSUpLg0KPiA+IA0KPiA+IDAuNyUgc291bmRzIGdvb2QgYXMgYSB3aG9sZS4gSG93
IHN1cmUgYXJlIHlvdSBvZiB0aGF0ICswLjIlPyBXYXMNCj4gPiB0aGlzIGENCj4gPiBiaWcgYXZl
cmFnZWQgdGVzdD8NCj4gDQo+IFllcywgdGhpcyB3YXMgYSB0ZXN0IGJldHdlZW4gdHdvIHRpZXJz
IHdpdGggMTArIHNlcnZlcnMgb24gZWFjaA0KPiB0aWVyLiAgDQo+IFdlIHRvb2sgdGhlIGF2ZXJh
Z2UgcGVyZm9ybWFuY2Ugb3ZlciBhIGZldyBob3VycyBvZiBzaGFkb3cgd29ya2xvYWQuIA0KDQpB
d2Vzb21lLiBTb3VuZHMgZ3JlYXQuDQoNCj4gDQo+ID4gDQo+ID4gPiANCj4gPiA+IEFsc28sIHJl
bW92ZSBzZXRfdm1fZmx1c2hfcmVzZXRfcGVybXMoKSBmcm9tIGFsbG9jX25ld19wYWNrKCkgYW5k
DQo+ID4gPiB1c2UNCj4gPiA+IHNldF9tZW1vcnlfW254fHJ3XSBpbiBicGZfcHJvZ19wYWNrX2Zy
ZWUoKS4gVGhpcyBpcyBiZWNhdXNlDQo+ID4gPiBWTV9GTFVTSF9SRVNFVF9QRVJNUyBkb2VzIG5v
dCB3b3JrIHdpdGggaHVnZSBwYWdlcyB5ZXQuIFsxXQ0KPiA+ID4gDQo+ID4gPiBbMV0gDQo+ID4g
PiANCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2JwZi9hZWVlYWYwYjdlYzYzZmRiYTU1ZDQ4MzRk
MmY1MjRkOGJmMDViNzFiLmNhbWVsQGludGVsLmNvbS8NCj4gPiA+IFN1Z2dlc3RlZC1ieTogUmlj
ayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiA+IA0KPiA+IEFzIEkg
c2FpZCBiZWZvcmUsIEkgdGhpbmsgdGhpcyB3aWxsIHdvcmsgZnVuY3Rpb25hbGx5LiBCdXQgSSBt
ZWFudA0KPiA+IGl0DQo+ID4gYXMgYSBxdWljayBmaXggd2hlbiB3ZSB3ZXJlIHRhbGtpbmcgYWJv
dXQgcGF0Y2hpbmcgdGhpcyB1cCB0byBrZWVwDQo+ID4gaXQNCj4gPiBlbmFibGVkIHVwc3RyZWFt
Lg0KPiA+IA0KPiA+IFNvIG5vdywgc2hvdWxkIHdlIG1ha2UgVk1fRkxVU0hfUkVTRVRfUEVSTVMg
d29yayBwcm9wZXJseSB3aXRoIGh1Z2UNCj4gPiBwYWdlcz8gVGhlIG1haW4gYmVuZWZpdCB3b3Vs
ZCBiZSB0byBrZWVwIHRoZSB0ZWFyIGRvd24gb2YgdGhlc2UNCj4gPiB0eXBlcw0KPiA+IG9mIGFs
bG9jYXRpb25zIGNvbnNpc3RlbnQgZm9yIGNvcnJlY3RuZXNzIHJlYXNvbnMuIFRoZSBUTEIgZmx1
c2gNCj4gPiBtaW5pbWl6aW5nIGRpZmZlcmVuY2VzIGFyZSBwcm9iYWJseSBsZXNzIGltcGFjdGZ1
bCBnaXZlbiB0aGUNCj4gPiBjYWNoaW5nDQo+ID4gaW50cm9kdWNlZCBoZXJlLiBBdCB0aGUgdmVy
eSBsZWFzdCB0aG91Z2gsIHdlIHNob3VsZCBoYXZlIChvciBoYXZlDQo+ID4gYWxyZWFkeSBoYWQp
IHNvbWUgV0FSTiBpZiBwZW9wbGUgdHJ5IHRvIHVzZSBpdCB3aXRoIGh1Z2UgcGFnZXMuDQo+IA0K
PiBJIGFtIG5vdCBxdWl0ZSBzdXJlIHRoZSBleGFjdCB3b3JrIG5lZWRlZCBoZXJlLiBSaWNrLCB3
b3VsZCB5b3UgaGF2ZQ0KPiB0aW1lIHRvIGVuYWJsZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyBmb3Ig
aHVnZSBwYWdlcz8gR2l2ZW4gdGhlIG1lcmdlIA0KPiB3aW5kb3cgaXMgY29taW5nIHNvb24sIEkg
Z3Vlc3Mgd2UgbmVlZCBjdXJyZW50IHdvcmsgYXJvdW5kIGluIDUuMTkuIA0KDQpJIHdvdWxkIGhh
dmUgaGFyZCB0aW1lIHNxdWVlemluZyB0aGF0IGluIG5vdy4gVGhlIHZtYWxsb2MgcGFydCBpcyBl
YXN5LA0KSSB0aGluayBJIGFscmVhZHkgcG9zdGVkIGEgZGlmZi4gQnV0IGZpcnN0IGhpYmVybmF0
ZSBuZWVkcyB0byBiZQ0KY2hhbmdlZCB0byBub3QgY2FyZSBhYm91dCBkaXJlY3QgbWFwIHBhZ2Ug
c2l6ZXMuDQoNCj4gDQo+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0Br
ZXJuZWwub3JnPg0KPiA+ID4gLS0tDQo+ID4gPiBrZXJuZWwvYnBmL2NvcmUuYyB8IDEyICsrKysr
KystLS0tLQ0KPiA+ID4gMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlv
bnMoLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2tlcm5lbC9icGYvY29yZS5jIGIva2Vy
bmVsL2JwZi9jb3JlLmMNCj4gPiA+IGluZGV4IGNhY2Q4Njg0YzNjNC4uYjY0ZDkxZmNiMGJhIDEw
MDY0NA0KPiA+ID4gLS0tIGEva2VybmVsL2JwZi9jb3JlLmMNCj4gPiA+ICsrKyBiL2tlcm5lbC9i
cGYvY29yZS5jDQo+ID4gPiBAQCAtODU3LDcgKzg1Nyw3IEBAIHN0YXRpYyBzaXplX3Qgc2VsZWN0
X2JwZl9wcm9nX3BhY2tfc2l6ZSh2b2lkKQ0KPiA+ID4gICAgICAgdm9pZCAqcHRyOw0KPiA+ID4g
DQo+ID4gPiAgICAgICBzaXplID0gQlBGX0hQQUdFX1NJWkUgKiBudW1fb25saW5lX25vZGVzKCk7
DQo+ID4gPiAtICAgIHB0ciA9IG1vZHVsZV9hbGxvYyhzaXplKTsNCj4gPiA+ICsgICAgcHRyID0g
bW9kdWxlX2FsbG9jX2h1Z2Uoc2l6ZSk7DQo+ID4gDQo+ID4gVGhpcyBzZWxlY3RfYnBmX3Byb2df
cGFja19zaXplKCkgZnVuY3Rpb24gYWx3YXlzIHNlZW1lZCB3ZWlyZCAtDQo+ID4gZG9pbmcgYQ0K
PiA+IGJpZyBhbGxvY2F0aW9uIGFuZCB0aGVuIGltbWVkaWF0ZWx5IGZyZWVpbmcuIENhbid0IGl0
IGNoZWNrIGENCj4gPiBjb25maWcNCj4gPiBmb3Igdm1hbGxvYyBodWdlIHBhZ2Ugc3VwcG9ydD8N
Cj4gDQo+IFllcywgaXQgaXMgd2VpcmQuIENoZWNraW5nIGEgY29uZmlnIGlzIG5vdCBlbm91Z2gg
aGVyZS4gV2UgYWxzbyBuZWVkDQo+IHRvIA0KPiBjaGVjayB2bWFwX2FsbG93X2h1Z2UsIHdoaWNo
IGlzIGNvbnRyb2xsZWQgYnkgYm9vdCBwYXJhbWV0ZXINCj4gbm9odWdlaW9tYXAuIA0KPiBJIGhh
dmVu4oCZdCBnb3QgYSBiZXR0ZXIgc29sdXRpb24gZm9yIHRoaXMuIA0KDQpJdCdzIHRvbyB3ZWly
ZC4gV2Ugc2hvdWxkIGV4cG9zZSB3aGF0cyBuZWVkZWQgaW4gdm1hbGxvYy4NCmh1Z2Vfdm1hbGxv
Y19zdXBwb3J0ZWQoKSBvciBzb21ldGhpbmcuDQoNCkknbSBhbHNvIG5vdCBjbGVhciB3aHkgd2Ug
d291bGRuJ3Qgd2FudCB0byB1c2UgdGhlIHByb2cgcGFjayBhbGxvY2F0b3INCmV2ZW4gaWYgdm1h
bGxvYyBodWdlIHBhZ2VzIHdhcyBkaXNhYmxlZC4gRG9lc24ndCBpdCBpbXByb3ZlIHBlcmZvcm1h
bmNlDQpldmVuIHdpdGggc21hbGwgcGFnZSBzaXplcywgcGVyIHlvdXIgYmVuY2htYXJrcz8gV2hh
dCBpcyB0aGUgZG93bnNpZGUNCnRvIGp1c3QgYWx3YXlzIHVzaW5nIGl0Pw0K
