Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2A250C1DD
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbiDVV5q (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 17:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbiDVV50 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:26 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832EF2A7DAF;
        Fri, 22 Apr 2022 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660002; x=1682196002;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hRt183UB3iYw0I3yhw7j6Oq6pPUcFneykwhACj8STqA=;
  b=RY65R19+c/jMZNGzpe30e+rN3dAzBTBeYfZes2GsCfZS5+Vqvx6r7DjX
   gD+yO3pysFzvzOq8pJt9sYwn0IYcFMcGdtJNRieNYNh9e8h6kIrZ51+cW
   M/dIPFqft6ngKHe0XLhUzy9e4KkePabCX6Wpao926MYd+zZCycpBYTc6M
   OT3gZFH6jvZnYAxAnFkC5zsohQ5e1XybYhWSasKkTubVegFk49kDrb0FM
   5RXN+1bVTH7clnNeSUOn76XXhwsBFoJoQBmyYHx4a64v1qpD6PNc/augZ
   9qGXoKqjEcc8bSaWrkI7EobfjloYr1ibhgKTqPnHUSlb2DrXx/9CaZGxQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="325229849"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="325229849"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="648775083"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2022 13:22:37 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 13:22:36 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 22 Apr 2022 13:22:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Apr 2022 13:22:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IUGBFinUOkdQcdOCWsLBl95T7Lv03EMJbPxqpfph/fdiGeIA10R2DbBxVsmQtb+kW+wcfE7vGCIE2cE06deBYqABCYxAgGqDUNDw/Id5HVeY0v6KyNJeL63lVdPCgfrc3+i50v6Pi59Ytj+XjunewKZxCaYjmgGvgN8k7M9YOmLnUoyU6KlE/iZDjHAnRilPnuGqPY9wj8QoSGkT/oF5J5sfX4ZQqPcwXIKfmsWL5jTo2ji3x374JHMaDjxbNmU3V0GDREmFO/0pYA63i3e9TLB1nECTTJb87zJ8qf7VljIilSlpi3SaThwqxW8+BtHtLtrZgkkLKb8+AsCosKW0wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRt183UB3iYw0I3yhw7j6Oq6pPUcFneykwhACj8STqA=;
 b=LCR1n5OzJsXAzjrJJzyp3oYVrv3aCx5XFquvL72x/h3bzdmQdmb7eNCAVockTadfmNdC4undRnQ/yL8EtXLHhpDFjGLUdpensjfgEvjXGxX2ssAS6Q+hOp03v+kLPnhN/0hxLMVtJOkADOqWwOVAklan/oClp9TbbYpXeSzWyD4kd0oa5oVLkJGo8FMFjibWOrgWC8nJXuX2znVbCsbJ02aOAQCNOI6rnJR5x7nYB5jmaSJ+GQtK5s71255oy12JcPL+HHWiW3XJ9iSvDB2O4cDZiKzrF7MGiunziGTjuW1Oin81vu25g6tUPq7iyumaKHxD5i+ocWq+ABb9U6PfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3464.namprd11.prod.outlook.com (2603:10b6:a03:7d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 22 Apr
 2022 20:22:33 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5186.015; Fri, 22 Apr
 2022 20:22:32 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAD2rgIAA23qAgAAKuICAAhm2gIAAJ/4AgAA00QCAAHKLAIAAB8GAgACFUwCAACY8gIAACuGAgAAXVICAANQIAIAANawA
Date:   Fri, 22 Apr 2022 20:22:32 +0000
Message-ID: <63e73592b145e579b3eca984b5badc9300619077.camel@intel.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
         <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
         <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
         <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
         <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
         <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
         <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
         <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
         <1650511496.iys9nxdueb.astroid@bobo.none>
         <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
         <1650530694.evuxjgtju7.astroid@bobo.none>
         <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
         <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
         <1650584815.0dtcbd4qky.astroid@bobo.none>
         <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
         <1650596505.bxrmjmgjur.astroid@bobo.none>
         <1650601109.vb3owbt14k.astroid@bobo.none>
         <b88a1097c994a72e9d8abfdcc43a4a0f9003d65a.camel@intel.com>
In-Reply-To: <b88a1097c994a72e9d8abfdcc43a4a0f9003d65a.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0ed183a-0d20-4f87-26d6-08da249dd4dc
x-ms-traffictypediagnostic: BYAPR11MB3464:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB34644A8F84C7B0121C845675C9F79@BYAPR11MB3464.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/wY+/uk9iZRCb8qNQbX9WNnn8vZRhujpLwRNnbiPw5vBJwSe8jOfx0Pai65cwKZoMGAtM87PXvn1yYkMOVUgqAXiyDhSDlokKyyasls3kpCBpN0lXpRu8szDSsaIeMLXFxsBITiOYBW+PZcSCnYXdBTPsPyDoNkKTWgZsxXnaJpnewbk5QU2zSeG7rAK9hoJ+RPolbVEP4vbK92KyOVSYa+wbYT2U/Fq/ABZnNF7oIDcNaL6yvzEG4GRLMy/iG1HUrnZfJUAdadYQdPgO2BwP/wSw5kX8+/WPKlfPWbehi8Ibpt9MSI/uRGn9yZ1tX43u995A0W2VuIMndik/SE0JygR9LBkFA91tEu10ujhhH5GCCM8nXSJAVi73THw8Nt7JAgeIxoA0GFHrj2d595Lmhaade7K4aS7+ibkVnl1QH4T9FfOyZpfzJ0yiywy0PB3NuRZd4Y5ZdUjCm9blnsjZp6VwzgbS01QdLqc2EiYqX3RVKU0C4SubEyuiSTYtGSfjSs8ROp0lJHuBv+pC+yX9QHOLtZnyQQ2vtcUhUod6U2z3MaSAAQ2ee/rPdJCtbstCBDYr5pW+Z4K/wvf+jO0fix+8ty8mPw51lRoDPZele46TaL37Y7EpC+HqmBWMECp5ML4jR4cmsNdFminNOow6wDjr0HgjdUVXJ6xmGv/zhDX2RqoPGrx2D+AmE3GqVcvoldSq4+hi5ICYpr0pXRpLFJStH9FwxD1ZSYF2HB/AQznByBRm0KBJAz3mHkLJP5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(82960400001)(36756003)(6506007)(122000001)(7416002)(64756008)(86362001)(6486002)(5660300002)(71200400001)(4744005)(83380400001)(316002)(508600001)(54906003)(38070700005)(8676002)(91956017)(66946007)(110136005)(66556008)(66476007)(26005)(6512007)(76116006)(2616005)(66446008)(38100700002)(186003)(4326008)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NC9Tazg1T05qako3N3RQNHE1WUhMclRnRHdCdUo0UW9zUFBQeVlwWVI4emds?=
 =?utf-8?B?b3pKeUZQU2M2aDNyYXZrUjFuMWVsUytObXJqZUhvMUJTeitzQU5uaEI2NzhU?=
 =?utf-8?B?OVIxSXA3bE1ZaDU1K2tjK1d1ek93dzBDdm4wU2J0ODh4Qlh4QllnSzUzYXdD?=
 =?utf-8?B?b2hpWE9XK3VZQUFaTmFhZUszWVdmdGxDTFVwZTEyWVhVRXl2TjhWM2hyOERB?=
 =?utf-8?B?NzMyOFM4NkdNUDVtM1FjWG8zWjhRek8xZW5Sd21ac01pbXZ5MjF6Mi8zaTl3?=
 =?utf-8?B?d2ZSYXZiME1iVmhvRWVLc2RFNlRQWXB4bFFQdTJhUmc5SDZjeFlzZk9hbU1i?=
 =?utf-8?B?RkpOUEEvSE9RR0F4WVUzSmFwSlNIU203L1ljbXlHcEhKZWNJSHVrVXI5L2c2?=
 =?utf-8?B?R1JsSGNiK3JBOEJUR1VVR1lBeFhzdHBZT0x0UzZIUFRMdHE0QTBuMis5Zyt2?=
 =?utf-8?B?QnpRL0dseERzUmVMaGpwaGcwcE1rRXlJbXNiTVhkQXZKaGlpYVNMWlRzeGpv?=
 =?utf-8?B?TW5JZzdGYlZUSjNTQ0tEekZzazJtWU9vWFVwcGJ1c3JJanZlVzNvZ01xRUdi?=
 =?utf-8?B?Y0JrbmNLdjdwVHg0ZDhXT2FvTW4xa0J3YU5vUFNwZXBZaW1ERURQM1JYUk9I?=
 =?utf-8?B?Q0luN0g5Zmk0RzdxcTZRUllQWDFaMmJXZEU0WEpyODhQVUYrU0dQK3pVeFF6?=
 =?utf-8?B?LzRXc2lxS2Z1NDJXTDRGVXdLUVdlVDE1dWZMSjVmUzBVcys0MWcxd0YrZ1pT?=
 =?utf-8?B?STl3MCtmV1c3OTl2NEpRUC9ubDE0Q3JXVUZwVElvanhsTUJBUUFaS3VnNHZH?=
 =?utf-8?B?bnpBR1JpcXJEeFdvbFRQTFNCYW1vSHo1anZKbUxnV3IxdjFhVzlTc3RiTk5L?=
 =?utf-8?B?SGxoZXdwc2t0aHM2bjdNTXZjNEVYdy9qZ3VZWDNIZjZMd0dkeVNWRmVSMUFZ?=
 =?utf-8?B?a1FGQjl6ZmFEZWdiNzY4dTJDcW1mdTZmWjd0QzJNbkdhQ1U3Nk5xRHFJUUVF?=
 =?utf-8?B?UWdNUlVJM0xLMnVBNXB3TnBOZ2VHOC9qNndWbnprblM5bkpOYXQ2clBITXRG?=
 =?utf-8?B?QTBQUUpqcW5VODNpMi94T2ZMOWhwTTRpMDl0TDBUN2NackczR3NLU2V2b1dL?=
 =?utf-8?B?Z01ybFBhVDlnemNxVWprMUJEZVQ1TU9OOW4zNjhGdzJpTUpXU1JEWHZxWjN6?=
 =?utf-8?B?YzdFczU0NnBZdTVUNVJNbFpFZUh5Zk5WTG84cExUcmVHTWhWME9QU3FtQ28w?=
 =?utf-8?B?eUo4b2hnaXRZdzUwMUprK093aFNpQlpyVE15VmhWSXl0ZlYreGVVU09zTDlm?=
 =?utf-8?B?VUpMR3J3Vzl3VmlHNDkvcXl3dzEzQTlzaGR0SG80M0NMSE53ZXFMRWI0eG9V?=
 =?utf-8?B?c3dSRkE2TzJCTFlGWTg0UFZ4ejJQZ1ZCejFTdkxCZGpmTkpEVG1uQUpJV2Np?=
 =?utf-8?B?cEx2UzhDYVJqVEhoTlNEZm9MVUdJZHN3RlpvQ3JtVFJhZzl4YWFZRlJ1OFZy?=
 =?utf-8?B?MDd0Z0t6YWV5ajh1MVNkVytjekd4cHJTbWc1ZW1nOWJqK1pTVXZJcGVkUUZG?=
 =?utf-8?B?ZDhmZ0R2V3N2MFY0bklQaWlrSDBwRWVBNkIydXZKYjFOcXFEOEdIb1A5UGhB?=
 =?utf-8?B?YVdLZGFVZnkvdS81U2FvaU1MN2M4REd5WFdmM1FTS3RQeFNRaFZFQmdFYjNR?=
 =?utf-8?B?cmFiTkhxOGx0Q25KdTRoQ1Y5SGprWEZ2Ni9aaVFESXhJd0svc2J1R0tvd0Ux?=
 =?utf-8?B?cy9ycHVwNndRWHczRGRtYnBmeStjVkdKRUN2dGRWRWJDOE1TSXZrWVlVK1Bj?=
 =?utf-8?B?ZWZxQkpyclNCblU3RVlibVI2bW5tYTRFeHRHTXVUVkJnNGQrN3VUNjFzK2VG?=
 =?utf-8?B?WktTeEpaOGUvYkJ4TzA0Rmd1OFRvK1R1NXYrYXBqTVNkVjlKQXdxQ3draXVw?=
 =?utf-8?B?cUVWT0hwRUpPUFlqTmZ3Qk9GOFhUUElvNzJINFlNMCtRTjRFNFlnVmtnNUJn?=
 =?utf-8?B?YlQySnc4Y1psN28vTk4yVVBSQUd3blhLcXZzakdMWVZiazZPSTZCeHJBK0w2?=
 =?utf-8?B?NTFFTnpxT0MzRkozOE5TaHplM0hxR2FkOVNrdFVCYVBiM2ZNbGZMMFc4TE1v?=
 =?utf-8?B?eStFc2dBQ0RvSC9FVGRLV3VyanJQb3YvUHlDTjA0YWdVRk9WeTNBUmhKZUJh?=
 =?utf-8?B?czl4T21MNldlcERXUUQ5WHBzVnA1eHE1VnIwU2FpellVOXgzTXYwT1kvbHR3?=
 =?utf-8?B?SldvdkhLQm5tQm8vM3VpQ0JFNlVRYVdsN1dCbVYyb1haN21URG1CZlhZZDF0?=
 =?utf-8?B?aldrd0s4ckFtWndZUmI5SzQrZk1nYyt1TFRhb0N5K2ttS0p1SW5hN1hEa1Ju?=
 =?utf-8?Q?nE3PaFbouKQUI2D5RLdO2G1eanp4vcrPRS4m1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <874C1D2983D0944E9C9E0D3D9595CF0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ed183a-0d20-4f87-26d6-08da249dd4dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 20:22:32.5459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGALpqAzCOw49vsKoT+D3b9GlOQbgP7T8fVbYbsRJGsHLVPND0K0zPVfLk6BR3XcFTfH82uX2Lb/RoF0dN0ZcH79YZB/Jssx6Rxk/RNWRo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3464
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTIyIGF0IDEwOjEwIC0wNzAwLCBFZGdlY29tYmUsIFJpY2hhcmQgUCB3
cm90ZToNCj4gVGhlIHJpc2sgdGhpcyBlbnRhaWxzIGlzIHJhY2luZyBhZ2FpbnN0IGFsbCB0aGUg
c29mdHdhcmUgcGFnZSB0YWJsZQ0KPiB3YWxrcyBhbmQgd2Fsa2luZyBhIGZyZWVkIHRhYmxlLiBB
dCBsZWFzdCBvbiB4ODYgdGhlIHdhbGtzIG9mIHRoZQ0KPiBrZXJuZWwgdGFibGVzIGFyZSBkb25l
IHdpdGggbm8gbG9ja3MsIHdoaWNoIHdvcmtzIGJlY2F1c2UgdGhlIFBURQ0KPiB1cGRhdGVzIGFy
ZSBhdG9taWMgYW5kIHByZXR0eSBtdWNoIG5ldmVyIGZyZWVkLiBTb21lIG9mIHRoZSBrZXJuZWwN
Cj4gcGFnZQ0KPiB0YWJsZSB3YWxrcyBpbiB0aGUgZmF1bHQgaGFuZGxlciBhcmUgYWN0dWFsbHkg
dHJpZ2dlcmFibGUgZnJvbQ0KPiB1c2Vyc3BhY2UuDQoNCkFyZ2gsIHBsZWFzZSBpZ25vcmUgdGhp
cy4gSSBndWVzcyBpbnRlcnJ1cHRzIGdldHRpbmcgZGlzYWJsZWQgaW4gdGhlDQpmYXVsdCBoYW5k
bGVyIGZvcmNlcyB0aGUgZnJlZWluZyBvZiB0aGUgcGFnZSB0YWJsZSB0byBzeW5jaHJvbml6ZSB3
aXRoDQp0aGUgZmF1bHQgaGFuZGxlciB3YWxrcyB2aWEgdGhlIFRMQiBmbHVzaCBJUElzIHRoYXQg
cHJlY2VkZSB0aGUgZnJlZS4NClNvcnJ5IGZvciB0aGUgbm9pc2UuDQo=
