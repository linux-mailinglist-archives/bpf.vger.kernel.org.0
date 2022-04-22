Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260A450ADC1
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 04:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiDVCcL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 22:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbiDVCcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 22:32:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B291D0CC;
        Thu, 21 Apr 2022 19:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650594556; x=1682130556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aGQUDQU9yr88jLK/qWgCiV6w/0/992ZsuCsdDAeaHtI=;
  b=QRkUDupXTBFvgWmwa1A7FJuRs/mMJuZu2TvhyUqmVJD7rrThikP1Rtz0
   Y+uz3ZcFfOT7CeJrNZSmfG0TLwFXOVEvAMaUwOPjYJPsifEdCJehBFmpT
   X41E7sMHUgCQLU5fZr6PvFXb4xb8U9RqD82tIKqz8c87N4R0KZsKV8ZwV
   ORKQ49/mFnv/9xG9HsniXOefLtNbpdpaVD5CBMR/vRNccrpVOEHBrEB2i
   vlxINy/koMdHgeNWlk9ifLKC6iQZpBeBnFhXuoXoEtQd6uL6mEdiq3YGA
   ah60Slg6z7w1ux3gnlbLqHK6xG0FeVXglUsTG5gXGBI1fGOkdWFytzHCb
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264321584"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264321584"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 19:29:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="648404102"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 19:29:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 19:29:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 19:29:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 19:29:15 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 19:29:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lASi7X1LiG1S8yYRNAqVVNdmgbTb0lxVcUqkZ6oM6TuDIgIzu0UJXEICNEDFwLFVeggNiMNgDe9JI95j7k1RHLYWhFQomw7kebzz5Nnn1JIPWNpbFYovc5iis5EZlHNpG5dSWU7UNPR6Sk5bXdLLtDIFgtJE/OYTY8Vl7mdsWRd7dwN2xVBmQIUQOvMF4GrAHksfeNGkfA5R8ouQKEZ+qhOleMFTn06mR3mEupHFtOFk70qVltonQ26NV0WX0j4lDksUjbALRwxAjxJs2AuMTQKfEy8PoWgsqL01En543zCpjHA9QZQTQ0QWy9231zQvsIlEeYN80OlwEN7J0j6NZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aGQUDQU9yr88jLK/qWgCiV6w/0/992ZsuCsdDAeaHtI=;
 b=ZZ6jibSB09MK0PrbsQVypSDgNVKjrox3Z+ElV5WHJbgM83kIjFXE1aks6FalsfE//YExXQx+/ggUPfwss68cmOvdMxIE3TC4X6fuUFdSutX+bLte564/Utw5boCrTcJWbYDnSzPNGMsgfPZuitSzscTabEtqyu7921/yDe/0P+2K/7X/+rW81rD306/lFtDS78pV0gXmzdk4QesRFn022lOGNh4BYkrl/AUzzdFzB8gBad3sXpaC1SGDPQIu7DN9NGrAEGctO/yUIx1n4ecWjUS966qislzS7j5Ukygo0REEhxc+eiWPzyJfB3Tw5OXOh0cUci8Uy+PM0u3UDzmXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CH2PR11MB4456.namprd11.prod.outlook.com (2603:10b6:610:48::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 02:29:08 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5186.015; Fri, 22 Apr
 2022 02:29:07 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAD2rgIAA23qAgAAKuICAAhm2gIAAJ/4AgAA00QCAAHKLAIAAB8GAgACFUwCAACY8gA==
Date:   Fri, 22 Apr 2022 02:29:07 +0000
Message-ID: <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
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
In-Reply-To: <1650584815.0dtcbd4qky.astroid@bobo.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40071bac-a6e7-4377-cd29-08da2407e0ab
x-ms-traffictypediagnostic: CH2PR11MB4456:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CH2PR11MB44567BE491F38AFF6914F293C9F79@CH2PR11MB4456.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5l1j211ic6N0rx9SCUSyuEH9xYwN99/EwBnDExYFH1No72kHrKyKyRvCy7FZzynpkw5vic3UjPI1Zs+vuueLhB4TdPkrBMDATREEv/c/RcqpTeW8bNI4epYZ3+th4E8W5BsN4SnOojHK/TSbzk1szhGIAPiOfuaC8I2NtxG57sZXrZS6yM/L36ivBKVyp3y3AJVw3MNvgEMAZimOkzvm4EqfKyyCCEqOXFz+/FWFj0749PU5VTE8tGGCCUh7Rer8vPMukmeJODoyqI/X39Vnonv/0DLwYFzurFMR7mrxWKUEzI/GYgN8/raRG8xdqBMLkF7R2TW4sz/1mxl5UltQDTpJPNA/4JT3t6Ywwf9emEflPGJVB+AYOsfkdauYKDcVZqo2TOIkEve6PWYtV9es+BAUP/dBF8UUA7qHI+/q8nipN3SjjWrTeBWSIaUxojLNB1mwlp9dawkTh7+eiAUGQQRv2dd0JfWl+wsEm8Bz+0NoAE9eo3gMiNPNvnze1o9svLGDyQ9tAOm/Zld3lYO97i6i+mPVMTPCvmSUDQzLkTAYszR/CVHSsofOGnT6XpDAaG+ItyPS5swG3desVvnGLG4LN1UOu8I4bU5GGeAc5FSyOpL+6+dn/Xh/GskX/pJB3oYzH7MEErObWg9ntJYfUm2RbfAPQpgC2pwXCtmdmD7ZncoW/Nv2y7sjG1wKxUNhSz/cqohgMVALTOHAGAxX6Irz6FxAGqYBR6Sf+1JJltTZ5XCkH4Zgu/nnpFQHxzQ8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(186003)(64756008)(66476007)(8676002)(66446008)(66556008)(7416002)(91956017)(66946007)(2616005)(6512007)(36756003)(26005)(4326008)(83380400001)(6506007)(122000001)(110136005)(82960400001)(54906003)(38070700005)(38100700002)(86362001)(2906002)(8936002)(316002)(71200400001)(508600001)(5660300002)(6486002)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bitvTWpRQzBsNHYzSzZybjhIbzY4ZWE5WUM0OE55WE5mMXdjMjBLWFM3eHdm?=
 =?utf-8?B?TXpWQmI0eFcyaHJ0TFh6OWduWGNRaUlXTk00MTI1a0xTZUE5SDlLR2Jya2lq?=
 =?utf-8?B?Q1JOQ3NCakwzMC9TWFMxS0E4dUF3UnRrQlpaa2VIQk5NRXhSQ3dabEtCWWRw?=
 =?utf-8?B?cDBwb3ZYU1VVM1ZXaUp2Q0YreUJWamJvMEJ6eHlRWFp2MXVZTWRXTmk2NXFT?=
 =?utf-8?B?VnUzV0JlbkdpREdPSkE5SmhHaEhOaWlYbm94a1orbktTek94MkVWOHR0ZUQ2?=
 =?utf-8?B?WS9ka0RpU1JaQUZKRzNlNHhoZTd4QWlaUDI2bkNlUzJMcW50VFEzdWtkRDhm?=
 =?utf-8?B?cUxWZTZ6NmFFVHI3WVdQRFoxbTFPeEVYckV0dkJnZFJlMHl4SDRkUnptdHhK?=
 =?utf-8?B?KytsRkg5MVRpRVc0b3ZCYnRTSjQxSjZhckt6c1Z1SGlTT1B0NzlTQThxaXlP?=
 =?utf-8?B?YVQvRnFzbElaZWszYWMydEovSERkTUh5ZVhFWENpYnNaM1NRWFpuN1AzR3Yr?=
 =?utf-8?B?SDlrY0VqWjZPWlRyRlp5eTRHRGRadTNwRTFRcDg3NWVNbnFma2gwbnJIMmZr?=
 =?utf-8?B?ZkVFdnJhcjJTTk5USys4R2d4L0RnZ1pmZ05wQ2xOWVhBMzE4MVBIc2RWWnBn?=
 =?utf-8?B?M0tZTWkvWFg4eVhFZ3dOZDdXV0duT1pVTXZhRTZYY1lVaXlSc0ZxVUFOdXY3?=
 =?utf-8?B?SllzckY1Sm9BZDJuV2pjK0FsL0lmWFFhdERsWEF1SjY2eGJUaXFLUUtqT0hB?=
 =?utf-8?B?dm5naXJOZEFmZkxUcUhZSWNXSmcvKzV2OFZ5RHBNYTVvZGRPRUtwdzZmNjlI?=
 =?utf-8?B?QzZkZVZiQ3J5QWhUUWc0R3FKNWVibnZ1UUhOU2VmOVpDWUtvY0dHdVI2NXpZ?=
 =?utf-8?B?LzV2YjZvQnBsOG9HM3h6WXZTZDlkcmJSQVRsQjc1eWRUVzh0WFdsclBuUzNo?=
 =?utf-8?B?OHZIcWZyNlZ1RTJsWUJNTnQwK1U2aUFmOTVxOVVDMEJNbDQrWk5xUHJiS05i?=
 =?utf-8?B?OWdqVUhuZWt3Q2RSTW5QRHFMZDZnQXZCdlk3bGw2aTN5aEhpeERGTWdGZ1c1?=
 =?utf-8?B?NU5BRm1sZmJienhXMjNYMUhFUFFWTHN2Q0g1dy93RER6SEtzR3o5VEtkbE1Y?=
 =?utf-8?B?REl1TGNsR254T01oUEJUZm5Qelc1NUdtamRvcW40c1dqOU9VQlVnYi9rN3pl?=
 =?utf-8?B?STJpWTBXUDdxWGNLajhCSWxHTE5zZmxVb1dTNzViNWh1bGNQZSt5ejJ4Ynpq?=
 =?utf-8?B?clpPZlBiTlcxcFl2RCtzQm1MMUwxTEJMTys2WnhNODhKa2xOYitWbG1BS2gr?=
 =?utf-8?B?LzVXd2s0QU4rWEE2WkRsSzFyN25EMngwR1FXYk03b2hPVWcyL2YvNjJMVGtZ?=
 =?utf-8?B?THZWOGFXckwzY204aFR3QnJ1N1RZQmo5UlZHODFLQjhzTXh2WWFWakJCV2RN?=
 =?utf-8?B?VzJwN3RCVE9lNDB5dW90WWxtbFEvZmJvL0xpMGR1c01iZHFPeENWaHE3S2E5?=
 =?utf-8?B?anVKdjd3d1FMWU4vQW9ocmlvZlYyaDQvWk9NZncwam1BNDRhTjRuQis4ZnBG?=
 =?utf-8?B?TXhTeVEzbFc0YkdKNmV4MFJ6OUlIRElBZWpHQkdxZkxxNmdFb1dxRTgzQ2ND?=
 =?utf-8?B?b1NTK2tKQnZrdUIzUDFNSzcvOWhndk5PZkZJN09ETDN2ZEVrb2lKM09OTmxX?=
 =?utf-8?B?dDB6R2p1R25lUzUwNERsdVpHRUcrRVI0MllBZWdxQUpRMExBTGkrbFhpS2Iz?=
 =?utf-8?B?MVBMQUlkSWtrdDJ1L25aQ0EvQVR2aTRhWnpJWktIbzZYYnV6ejdaUkxENkNX?=
 =?utf-8?B?emlYdDNSUlpoREhDSGtIZmlKOGxMUC82RFRhM2QwMThvVkg5RzVRZS93anQv?=
 =?utf-8?B?NHRkdk5qVitBaU9GWEgxWklNcU1QOTV5VlZTOGhzUnNueC9xQzVDZ2hoWGNo?=
 =?utf-8?B?czB2Vk53dEZqTUI0Nm0xZGZHbGlVVlBWa2JIcDNYS0ZjSmVqUklZelQ1bi94?=
 =?utf-8?B?L2ZUTnB2Y3Q5WDVEL1FWL1VwdktLUFlNYkIrVEFzRjY4NmcxSllsc1g2SHJ5?=
 =?utf-8?B?blVYZ1BEdnBseGJGNmpkRkVYQUxHL09Xb2VWb1RZTzd4T0htdWlLTlRETCt0?=
 =?utf-8?B?SFhtSWdEb0swRmR1bDArT2Roc3l6M2JWSUtQc2YrbkI2cnVBc0g4eTlweDR2?=
 =?utf-8?B?d0RJb0F1WlIzNkt1OFVwUG51MU9lWU94Mm1yQWRlVExiRllUYjJzR3p2VVh4?=
 =?utf-8?B?RDJsL3R0RDFYa2ZVdDRHUXNlZ0hYVDJJaStWaWdjemxraTV4NVIwSGc4cTJr?=
 =?utf-8?B?V3Fyc2FKcmlvSkJvVUZSQzZOWFQ5S29qME8yTllQbGdZN1B1MFVhYjV5Ny9U?=
 =?utf-8?Q?ktUJSL0WxuJptgo1aWcttSmbHbIzvJFUL6P08?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24C3714794384145BBA3A7DB58A8CCB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40071bac-a6e7-4377-cd29-08da2407e0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 02:29:07.8803
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wc15OrDXHnSvGnCtNYlpU1M6cpXwxn+VAVHynkVcZDMZiQHnHCYMgF7gL9JPmq0NREPPc1NrKYF0nYAJZg2/tTvBM4mV5Fo8N3CKdgxrsuQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4456
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTIyIGF0IDEwOjEyICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
DQo+IGRpZmYgLS1naXQgYS9tbS92bWFsbG9jLmMgYi9tbS92bWFsbG9jLmMNCj4gaW5kZXggZTE2
MzM3MmQzOTY3Li43MDkzM2Y0ZWQwNjkgMTAwNjQ0DQo+IC0tLSBhL21tL3ZtYWxsb2MuYw0KPiAr
KysgYi9tbS92bWFsbG9jLmMNCj4gQEAgLTI5MjUsMTIgKzI5MjUsNyBAQCB2bV9hcmVhX2FsbG9j
X3BhZ2VzKGdmcF90IGdmcCwgaW50IG5pZCwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KG5yICE9IG5yX3BhZ2VzX3JlcXVlc3QpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYnJlYWs7DQo+ICAgICAgICAgICAgICAgICB9DQo+IC0gICAgICAgfSBlbHNlDQo+IC0gICAg
ICAgICAgICAgICAvKg0KPiAtICAgICAgICAgICAgICAgICogQ29tcG91bmQgcGFnZXMgcmVxdWly
ZWQgZm9yIHJlbWFwX3ZtYWxsb2NfcGFnZSBpZg0KPiAtICAgICAgICAgICAgICAgICogaGlnaC1v
cmRlciBwYWdlcy4NCj4gLSAgICAgICAgICAgICAgICAqLw0KPiAtICAgICAgICAgICAgICAgZ2Zw
IHw9IF9fR0ZQX0NPTVA7DQo+ICsgICAgICAgfQ0KPiAgDQo+ICAgICAgICAgLyogSGlnaC1vcmRl
ciBwYWdlcyBvciBmYWxsYmFjayBwYXRoIGlmICJidWxrIiBmYWlscy4gKi8NCj4gIA0KPiBAQCAt
Mjk0NCw2ICsyOTM5LDEzIEBAIHZtX2FyZWFfYWxsb2NfcGFnZXMoZ2ZwX3QgZ2ZwLCBpbnQgbmlk
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICBwYWdlID0gYWxsb2NfcGFnZXNfbm9kZShuaWQs
IGdmcCwgb3JkZXIpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHVubGlrZWx5KCFwYWdlKSkNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgICAgICAgICAvKg0KPiAr
ICAgICAgICAgICAgICAgICogSGlnaGVyIG9yZGVyIGFsbG9jYXRpb25zIG11c3QgYmUgYWJsZSB0
byBiZQ0KPiB0cmVhdGVkIGFzDQo+ICsgICAgICAgICAgICAgICAgKiBpbmRlcGRlbmVudCBzbWFs
bCBwYWdlcyBieSBjYWxsZXJzIChhcyB0aGV5IGNhbg0KPiB3aXRoDQo+ICsgICAgICAgICAgICAg
ICAgKiBzbWFsbCBwYWdlIGFsbG9jcykuDQo+ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAg
ICAgICAgICAgIGlmIChvcmRlcikNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgc3BsaXRfcGFn
ZShwYWdlLCBvcmRlcik7DQo+ICANCj4gICAgICAgICAgICAgICAgIC8qDQo+ICAgICAgICAgICAg
ICAgICAgKiBDYXJlZnVsLCB3ZSBhbGxvY2F0ZSBhbmQgbWFwIHBhZ2Utb3JkZXIgcGFnZXMsIGJ1
dA0KDQpGV0lXLCBJIGxpa2UgdGhpcyBkaXJlY3Rpb24uIEkgdGhpbmsgaXQgbmVlZHMgdG8gZnJl
ZSB0aGVtIGRpZmZlcmVudGx5DQp0aG91Z2g/IFNpbmNlIGN1cnJlbnRseSBhc3N1bWVzIHRoZXkg
YXJlIGhpZ2ggb3JkZXIgcGFnZXMgaW4gdGhhdCBwYXRoLg0KSSBhbHNvIHdvbmRlciBpZiB3ZSB3
b3VsZG4ndCBuZWVkIHZtX3N0cnVjdC0+cGFnZV9vcmRlciBhbnltb3JlLCBhbmQNCmFsbCB0aGUg
cGxhY2VzIHRoYXQgd291bGQgcGVyY29sYXRlcyBvdXQgdG8uIEJhc2ljYWxseSBhbGwgdGhlIHBs
YWNlcw0Kd2hlcmUgaXQgaXRlcmF0ZXMgdGhyb3VnaCB2bV9zdHJ1Y3QtPnBhZ2VzIHdpdGggcGFn
ZV9vcmRlciBzdGVwcGluZy4NCg0KQmVzaWRlcyBmaXhpbmcgdGhlIGJpc2VjdGVkIGlzc3VlICho
b3BlZnVsbHkpLCBpdCBhbHNvIG1vcmUgY2xlYW5seQ0Kc2VwYXJhdGVzIHRoZSBtYXBwaW5nIGZy
b20gdGhlIGJhY2tpbmcgYWxsb2NhdGlvbiBsb2dpYy4gQW5kIHRoZW4gc2luY2UNCmFsbCB0aGUg
cGFnZXMgYXJlIDRrIChmcm9tIHRoZSBwYWdlIGFsbG9jYXRvciBwZXJzcGVjdGl2ZSksIGl0IHdv
dWxkIGJlDQplYXNpZXIgdG8gc3VwcG9ydCBub24taHVnZSBwYWdlIGFsaWduZWQgc2l6ZXMuIGku
ZS4gbm90IHVzZSB1cCBhIHdob2xlDQphZGRpdGlvbmFsIDJNQiBwYWdlIGlmIHlvdSBvbmx5IG5l
ZWQgNGsgbW9yZSBvZiBhbGxvY2F0aW9uIHNpemUuDQoNCg==
