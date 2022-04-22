Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0648250BE51
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiDVROH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 13:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354116AbiDVROF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 13:14:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613FC97284;
        Fri, 22 Apr 2022 10:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650647440; x=1682183440;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6H07zzq3V6Q/VQ+zNdCUfAQpxUxup5lZvmlW0gvtA7k=;
  b=NQ5ZbB2frhEIhPXMZ6mm+p2GgTY1uLuf/G/8OeysXmt4PNBdtrP3M2oW
   Wql+dRWj/M81Mcfw5iI3g+y3n1UuQSJfFXeYnqKWS6B8LZdVMpk4IuACN
   T4dUkDklamjnaLfOe3eORtEKMDaiamKbVAHXs8jnpmEqn2g/wnpZ39j09
   qUHZNpMj1Avk9C2roEd7/lyUA6so8wWXIV2uUciUvyHEIyEJqcX9beav7
   fKGM4E8fsNyxEFkBGUtTcIvstg17BUQBN8Dp3kFTXVLRwtDQlxT6sgWEB
   t88SL/i6bbsZ05xtDOJ9pqyKBFEa4V3H/W2ftXE+uOmWwLPp3kYoZ40By
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289853115"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289853115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 10:10:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="659113092"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2022 10:10:32 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 10:10:32 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 10:10:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 22 Apr 2022 10:10:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Apr 2022 10:10:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+nDecI86heb08CKUaohv9Rn9R0Sn177XpyjhhTrd/X78IR33i/g4pBMjh8RLgv/vIAMTS86REiSrXjD+Vv4S0174n7RzKxh+PuyndmJvNhTLLRqYyfkNPj+qeRg8Ne7hi5DM1oQMItIUvah0R03kRC3BfpQAoMlU0rRAuntnH8mhmrOzzyOyoypnJXpERL8RfTe4fi191udNx5uyFnHjlQe7SqUMHE0UMuZd1kZjyvmRmxUE+1X3CXDo5W3Z1t4241tSPJ1jsQOYSmOAksthGnZeF1NFr3lr6bi2E9uEF7Lr0gOafsNhN4kx0yDRE7Yd98twKbul6SLSwaS7vclzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6H07zzq3V6Q/VQ+zNdCUfAQpxUxup5lZvmlW0gvtA7k=;
 b=Uw54FMEqvisay4e6vdGhLbPvkYKhfsyeeo4yhQiIhn6c8E6zLtWoqEqyJKjgDD4dcEVrH4SP+UvRYCOczO2QH+3gj8e2gmi7PVvW+okIaa7F3jrpO5fv9/OlaUTzTP2GkD9t7oYwnsKZGyQfQRsgEax1/+R4PVW95r+peX5Hp0V3nZzpvA3+9tISBj1kYvlmbMKzpNdQc6tSBTQ3jkeAnmi2UgmSVStxiwxuELwP90MQ/00My9E7Akx8vAMNjbIdRKt+GHTzRGuB80qtPVbgvjyZH3maTYXho+j3cJBBTm+Bp1/7SsTqXGziivrkkbeXNqN3K67/3QgK3N2JSwS8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by MN2PR11MB4711.namprd11.prod.outlook.com (2603:10b6:208:24e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 17:10:27 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5186.015; Fri, 22 Apr
 2022 17:10:27 +0000
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
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAD2rgIAA23qAgAAKuICAAhm2gIAAJ/4AgAA00QCAAHKLAIAAB8GAgACFUwCAACY8gIAACuGAgAAXVICAANQIAA==
Date:   Fri, 22 Apr 2022 17:10:27 +0000
Message-ID: <b88a1097c994a72e9d8abfdcc43a4a0f9003d65a.camel@intel.com>
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
In-Reply-To: <1650601109.vb3owbt14k.astroid@bobo.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05e9d711-ff8c-45f3-77f4-08da2482ff5d
x-ms-traffictypediagnostic: MN2PR11MB4711:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB47110173470DFB46292DB280C9F79@MN2PR11MB4711.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dPA7H0jWRnX0AA8+c51lNS7dBurUm/B6v/ps69kjZloJdvJYmMshl/12lnwUleOTrcq5unkjHJDIoRMzTjE/597muth7DMckKyfr3L/6E1JCgO/wAEMqnW6oVQSdRTQsODlCGqaOjjHI0M5H6Pz+ygS+SBymu/KyHUvBlKd350mLJ4GO0QANrX5aGx+Q4XGgIGou5lNgXoJGrj7MI5u/SbP89WSB9tmpXVNaQzP47w7EtpIhaKg38mPx951FTxOSpvJ6aK/hDLVK3LLjn6/JrWpJIkkc4uoE1MO5dp8XyRk7mjFp1J5XqzZZua1vAb6fb2stLrg+vkGR/sUVTcwhWTyQDu9+44dI+e//kSh8ejH4Fm0D3qc2ZuNjAVhiUUztRCrjq6qAIfJFsrTcdYrzxqrZMp+Ozz1OKdus6UQ/KeQPBG9HCP9JzHuFuHYxSAOEVhE8X0vfxIdJT6sL06o82nWnkP3CaX80YzdSMS39XAkwPIHvBp7bkvPIEZ3YF6PL0cCgUgm+kQmStVpujBn+k5YhQo4PkG3MRiLyMKhmP0a+STk3nBkdUMnpIlm8ldLY/jy0eEG6rA0gpnHQ09jPakp2LnDQMIwxYSK+hnU7waVofdcxg46GAIgF30gTbKjlMpWMx6ghJ9tBTkbxh9qrmuck8WzcBRMzQ/NQIKE0Nsl9kXLZGElthJOMJVW2OsHoHynEg8XCJhKk9Ghi/RJ920kcByvZ2g+hj1mB03vr4nUOt0Nv9JTiJcKtfJb4u5Jm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(8936002)(6506007)(36756003)(66476007)(66556008)(26005)(508600001)(316002)(7416002)(64756008)(66446008)(54906003)(83380400001)(2616005)(186003)(8676002)(82960400001)(122000001)(2906002)(5660300002)(6512007)(4326008)(6486002)(110136005)(86362001)(38100700002)(38070700005)(66946007)(91956017)(76116006)(71200400001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXVPaWo3Q1pxOHZxT1BPTVZBL3JvSVdQalpBeVdhUEplSHZJbjRMSlZKdmsw?=
 =?utf-8?B?QkJQellNM2hzWUVIbncvazcrTmVSZ1R1ckRJUkNVdmNZUkNrTkRyZCs2Uldw?=
 =?utf-8?B?TGdHSUtZaGxVVnp3UVNPYkpydXdSdXc2YVBnTFR1R1NScG90c2VRS0QvWGxZ?=
 =?utf-8?B?NEoxaldHM0FCVThFSmd6N0xDd2V5dnNDT1IySk50VW0vTWtMaERiVzBic096?=
 =?utf-8?B?bGQvelZpZmRzRWJ0c1pRTUN2MFF3R0RUVXd6d3hwZ3VJazRhU3dabjVnMlpU?=
 =?utf-8?B?MzUyNys4cklBTGltcXpNNEFsZFR3eWpkTDV5VTNpSTNEZC9tQmR3K3N6c0Qy?=
 =?utf-8?B?b0QzVTVWVXY5M1ZmZmpoYlU5NThPQ0ZKMCtJbUJBSkJFbStpRk5oYnJ5SVJs?=
 =?utf-8?B?eXhaSUwybmh3R3pYcDVWY0NkdmlxQkMyMlpYUkwxL0p4WktmN2hEUFJPRjZJ?=
 =?utf-8?B?d0p2VmFxaytYZzVmd3MxVXg2d2tUODVPNG5kaDh4SVhQVEZhb0RhL21SY3g2?=
 =?utf-8?B?M2drT09nNEZ5bHYrM0QrTTZES3YwWnJQSm4rRlJmTG5HQWJMVEgzcFE4UFJR?=
 =?utf-8?B?dUJFcEpOOHd5dFJiZS9QamhROUxyTkFHZTY0VnRPV05pWVlwRFpJZ3FndWlp?=
 =?utf-8?B?V2s2WXgrY01XaDIzQkQ3cnA1cjJlVFAzTEhQaDhOaHcyWjUwK3E1RFR4REJt?=
 =?utf-8?B?eGEzNWRhcFhaRXBTaWJFWXJxMHptclBaUXFySmxNZTFsSkM5NlFxOWVaNWNs?=
 =?utf-8?B?ajl6R09hMFl6VVlCTjh1dGdxRUovYyt2aS9VY1RkejVqVW5kaDA5dHJiZVQ2?=
 =?utf-8?B?WDZwT1ZFNU5nYXlnRll2VHlaZkdZODFUK0J3UXZ5S0VGYmhvaWI1ckpLZWJK?=
 =?utf-8?B?Z1ordlJ4WnRJUis2aHppeWoyOXVRV0czRXlGYlVoSW51M0Z5Y0RNVWVQdW5E?=
 =?utf-8?B?ZjBjT2N4TXVaM1dTMjRQc1U2bmNJUWY1a0ovVWdSdjhqalRmU2xPUndSa0FD?=
 =?utf-8?B?NFNGSGNxZEVYdmcwMW50eHhhZG9wR1J2SndkVi8wMngyQUo2OG5vcW9JQ0ZK?=
 =?utf-8?B?UVluZ1BrYzF0c3JOalFqTmNCNTgxbW1rWFRMa0VweWRrWm9KQmtKK1FYeWVu?=
 =?utf-8?B?bnEvaVo2ZUZRZlBWRDg4ZzJqZWxRZUlCckhUMy9mYXJLbk5ESit4WGxDQWtQ?=
 =?utf-8?B?ZU5aVXJ5NmtoU2I0eXdlZDJkazY0aW1SdTRvblNwb2RYR2F0eGJKUlN5eUhY?=
 =?utf-8?B?S3FLVFZaMjdzekhpdGVUU0tTcmhLSUN6ellsQWxCMWtqRE5RTVp4bHlEekxh?=
 =?utf-8?B?VTB4ZDltemlOUjM2TExRVFk3YUE2VC9LMjM0UUcxd2NLRDVkckd3N1FnWUdJ?=
 =?utf-8?B?c3NWbmRCR2hoTXdESGJVd1pUTDE4aXIvcWZXbVZtMmVXTjYxc0xvekZ0WEp3?=
 =?utf-8?B?anB1aC9xM2dRNCtyZGxETlUyY0JJZkkxM2NWWTJveWY4UmZsVitsYnFITG0w?=
 =?utf-8?B?WTRrMTFyOEQwZkNsSE82eFkyZ3JJdWw5SnRPSEw5b0tTL1FpR042aXpDQWtw?=
 =?utf-8?B?QjZPKzBDME9xWnJjQ1FpektRWCtZMm1Pcys4N09NYVh4K1NPTkE2WGIzUGhw?=
 =?utf-8?B?REtEWkExY2tvQ0hJNmZyNEJxNXhVMGc5ZkliaEhyRzlPWk52SFZKOHA0Qjha?=
 =?utf-8?B?UFNteGtKZ3NzL3pMZXVhUWozYncrS0ZoREpZV214dm0yMFJVMXV5Wkp6U2Fl?=
 =?utf-8?B?U0pwWUl5ZGg2YTVxdDdvYmtMY05CcEhha3FSSGFDKzB0K01la0pWUVdrT0to?=
 =?utf-8?B?bDFMSUxkY0dGTngyVHhqSEE2aVVMQlZSS1FmV2hkTEI0OGNxL1NHcDViVTlE?=
 =?utf-8?B?cHZ3Y3hQeUNUOXo1TnJNQ1QxOXNLeUlkTTZWTktDdllnVkN6NVVQSXBxeWFw?=
 =?utf-8?B?QUIva255UWprVkw2aVRsd0ZvL1IrU0R1TWZoWU42T3grWHNESkY4T0drRG1l?=
 =?utf-8?B?anY1UXI4TDFtOW9iTHVGMm9rWG9JTG8rU2lZS240TFozQXYrQ3EyWXdsMEpF?=
 =?utf-8?B?RW9yd3hwVHp5L1JXVHl0clpLQXh4UVFzVmVwaU4zZTdWUjZsVFRsYWJkc0tS?=
 =?utf-8?B?OWtTeGR2dER5K1dEK3Bkd2JPZWZ3VHE2SktkREhFV2ZDNnpZY09sSFh3Uk5M?=
 =?utf-8?B?K095N3MwWngzdUU4Tnh6N2dqaGk4TStWdW1RMmtIK3ZPNElFRktHZ3dwSXE2?=
 =?utf-8?B?dlVUbk1qZS9PbXpLVFBObmVPdU9TWDUrNkRnME9Cd2tjMzhEbTJTT1VrZ0pz?=
 =?utf-8?B?ZHBKZGlUZ2NiV2t2YlZiRlJZai9HYVZKM095N0k5bkdEcHp2VFdlZElmUmRH?=
 =?utf-8?Q?TJe3Ou5Al5wrgTmd5SiM+MdN/Jk2LYUYyEFyl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52CCABBBA7C787489285F645B0B94BCB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e9d711-ff8c-45f3-77f4-08da2482ff5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 17:10:27.4865
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /175H0jlRRdMk/Hitj041X0fyhAfwlYfuMNr+cUTQhnbbPldVBqyxoGMI3K0wLS7rPU8FaKM/FthzHOTlWndZY0kQgZd3nhlVGTy2SmGJvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4711
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTIyIGF0IDE0OjMxICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
DQo+IEFueSBvdGhlciBjb25jZXJucyB3aXRoIHRoZSBmaXg/DQoNCkkgaGFkIGFub3RoZXIgY29u
Y2VybiB3aXRoIHRoZSB2bWFsbG9jIGh1Z2UgcGFnZXMuIFBvc3NpYmx5IGdldHRpbmcNCmludG8g
cGFyYW5vaWQgdGVycml0b3J5IGhlcmUsIGJ1dCBpdCdzIGFyb3VuZCB0aGUgbmV3IGJlaGF2aW9y
IG9mDQpmcmVlaW5nIHZtYWxsb2MgcGFnZSB0YWJsZXMuIEF0IGxlYXN0IG9uIHg4NiB0aGlzIGRv
ZXNuJ3QgaGFwcGVuIHZlcnkNCm9mdGVuLiBBRkFJQ1QgaXQgYWxsIGhhcHBlbnMgZHVyaW5nIGJv
b3Qgb3IgZHVyaW5nIG1lbW9yeSBob3QgdW5wbHVnLg0KDQpUaGUgcmlzayB0aGlzIGVudGFpbHMg
aXMgcmFjaW5nIGFnYWluc3QgYWxsIHRoZSBzb2Z0d2FyZSBwYWdlIHRhYmxlDQp3YWxrcyBhbmQg
d2Fsa2luZyBhIGZyZWVkIHRhYmxlLiBBdCBsZWFzdCBvbiB4ODYgdGhlIHdhbGtzIG9mIHRoZQ0K
a2VybmVsIHRhYmxlcyBhcmUgZG9uZSB3aXRoIG5vIGxvY2tzLCB3aGljaCB3b3JrcyBiZWNhdXNl
IHRoZSBQVEUNCnVwZGF0ZXMgYXJlIGF0b21pYyBhbmQgcHJldHR5IG11Y2ggbmV2ZXIgZnJlZWQu
IFNvbWUgb2YgdGhlIGtlcm5lbCBwYWdlDQp0YWJsZSB3YWxrcyBpbiB0aGUgZmF1bHQgaGFuZGxl
ciBhcmUgYWN0dWFsbHkgdHJpZ2dlcmFibGUgZnJvbQ0KdXNlcnNwYWNlLg0KDQpTbyBpdCdzIGlu
IHRoZSBjYXRlZ29yeSBvZiAiYWxyZWFkeSB0aGVyZSBpcyBhIGJ1ZyIgb3IgYSBsaXR0bGUgdHJv
dWJsZQ0Kc29tZW9uZSBjb3VsZCBjYXVzZSB3aXRoIGEgbG90IG9mIGVmZm9ydC4gQXQgbGVhc3Qg
dW50aWwgUEtTIHZtYWxsb2MNCm1lbW9yeSBzaG93cyB1cC4gQW55d2F5LCBhcyBsb25nIGFzIHdl
IGFyZSBnb2luZyBvdmVyIHRoaXMgYWxsIGFnYWluIEkNCnRob3VnaHQgaXQgd2FzIHdvcnRoIGJy
aW5naW5nIHVwLg0K
