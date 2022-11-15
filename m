Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1294F62A070
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKORer (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbiKORep (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:34:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3B29342
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668533685; x=1700069685;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mGD/Bw2qrYKDUTcEqTu5cwlKV4aBao/rA8v7j3BY0r4=;
  b=V7s45cQFLhqEPhJwdBTeuFtFvyl6pA+B+nwGQGfXpaJwlGaBLayeDzHT
   +P0F1bLFcIEvh8rnU8dxcHif59M95+NyAckfx6Eqg9rTlGaOz2dKR6dBg
   oUubW1u2v7TsnT3F0Lfzn8z5OKiin//cDhfk7xewo74jbbb/kwqdToGtb
   rImOepwjrTScmnh9Q9+k/1vOiUNKvw1+biVQ+2wHbTNsQfBaouR5HkQBh
   dSGOKVVlivKzS3RJOigTfeRtpolB37lV53K+i1QhTW9/XTLEyVRJNbEwh
   5I7KrNpThrKpn+1ijUvy2DrzjFl2pj1kFVoEYnvZBukoJkquCdNVRhJv3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="292027403"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="292027403"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:34:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672072863"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="672072863"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2022 09:34:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:34:29 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 09:34:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 09:34:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CAxrsanCgnByzXym1Y5E0gMdFejEzxPXhpZF9pZk30WgE+Z57h4ij+NFttgx1sGnwLMJN4ng6ltpHZlwYQFyu6Z506ElxRDChpS0f9HJI8mg4SOCbwmlvfCbye0Wj5cSKvzhVGizmHWSBqTudkMXLZxobTMXxDy5tek2whnw6G0X9Mo0v7YaS80NHKl65XbbY5JeLtArEwmYm6lH431o0vdswYWLrvB7Z8Rywti4lMtADyvrgMDhw11+V47N0U7EAjV9Th6X2u7obtHH9uzJXiu1pGoAHLIjYsOGARGxrVo8LVNawZKEMIf94X11OTOd65Z+gIyI4PaogUaji3RZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGD/Bw2qrYKDUTcEqTu5cwlKV4aBao/rA8v7j3BY0r4=;
 b=YbsjUjt9NAG6mlQCky0azG/c6i61In1H96cse+xa2vSnlNawcEhqMORw/4EBm6fpHrpSr2BM0/2sBFNx9k5FwXcyMH4b5fR9v6dmHg0kCnbGZ7PzUva5fzQOvVOiefjFuZ7JbNjFUgD8xZ5VcqRIPf1z7/C19/b+DF8jbKuZlP+IYyOELo0ndg8j7cbS1LlqpEfB4HLz0+KRYDYoiUXWepJfB8tVSP67SrFotlyoIGBznUNmFPcqjto1SCsSBVJoawYXpoWBZ8zZphDyFivzSRZvhl0/Ccp+q+8mmSD7PE2NQSu0YTpU5Ssb61L2/RyuUK4g9z5RlrfHrMguGJD9bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SJ0PR11MB4831.namprd11.prod.outlook.com (2603:10b6:a03:2d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 17:34:26 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:34:26 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "peterz@infradead.org" <peterz@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "hch@lst.de" <hch@lst.de>, "Lu, Aaron" <aaron.lu@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC64/PciAgAENRoA=
Date:   Tue, 15 Nov 2022 17:34:26 +0000
Message-ID: <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
In-Reply-To: <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SJ0PR11MB4831:EE_
x-ms-office365-filtering-correlation-id: 1c762b62-1796-4dd3-fbef-08dac72fa46d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l1fYXokqI463JrGajDsc6NPuiiQARpl6bNdUzEH/pOj9MHPs+XOBKChnvsu5qgHgZxbg00ThbccFghgRuWbkvZnGIf7Lg2AQwTfiFvJvZ+y8YOObVss/nwg8ic8Bz2Bc8T/4aOP55jsC/A9K3V2+ayQhtEd3dy8mzV3ggUUNVLyspUz8JkKtgUseCgwAHkqh3sz4rX38YGirnNrN6yr/zT/jruJ7b7NZIZZ+Pw5Cho9PJQGwY+vo2uKh3vFYpGOmd5XnS7zLnvjTAI2xWqaJttawxQohivwbcx3lJpgAw8BrwHJrquK0I92xEQYElpKXz9erwsB5Kt7sxeODu7cwwG+H5BoMdSZbmQ5mhACfm3yqD//Xk04ZyFKLcvozVHHGij5yF4zWZqWnG76vSGziThxWJyzOh9wmr2kzCOff12T/MJovOlc0gDZIrHAaeH8sTSqxvDo88DCj6MYnjHAAjabi+a3V97fdsl7gYWRVKvRE+vat44Z1KYELLwTuJaEfOnlUB5ykRFNfVk1rALg2dg8ly3fUTqsncOJSaqQqxtIs/prPCsKkj8OsCDU2PCpdIpmBLrjuyXBIr/FDnZcX3o5lbfZhZ4Ps51i+OVJdk3VAfltzjL/jEnO96GptyFenlC+/2YaIwCQ/EXiURunjF4yiIuy3IUqxA61qPMegoyqzv7YUPme2b7fkcoClUBlmuj1IwNqz4ZPFnErrP0nxP1iSsxQlAQcvB92UbHNMyc90co+miZlwbkJVYffKAAsHeB5E/lqvvxTwKjaryiB4FUtwzDWidySZq0hxOyRht1AK5uiaDqbzziKZb5yB4luGNeRnHbsu6lk2rb+5UoaEJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199015)(6486002)(966005)(316002)(71200400001)(76116006)(66556008)(66476007)(66446008)(64756008)(66946007)(122000001)(91956017)(36756003)(86362001)(38070700005)(82960400001)(38100700002)(8676002)(186003)(6512007)(478600001)(2616005)(6506007)(26005)(4001150100001)(2906002)(41300700001)(4744005)(54906003)(83380400001)(4326008)(5660300002)(110136005)(8936002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TTByV3pCRjhxclByaTNKcE5wNEY1WDlGTFAwOUREWFI0SjVBQmh5K3hhWXlt?=
 =?utf-8?B?cjNVL1BvN21Xa3lNeTgxSWVGYnprWEJwVTM2VWc3N085cngrVzNLWHJNaEls?=
 =?utf-8?B?VExITzFFSll4THpFQVVCUDQ0YUNDL2NVeFd2eW5WRTFJdlVpUlJHNWJoN1ZQ?=
 =?utf-8?B?c1VOVTF4SEEvKzRCcVd1cGpLZkN3VjE2SEVaVmlGcDRXMmdUaEc2L3pUbE44?=
 =?utf-8?B?eFZ3OFcxYndQMjZyUkRiVjRCdEM4emlxeVlJZEVocm1FRnZ6Vy9Cd0lDVStW?=
 =?utf-8?B?SDRya0lQdExoT3FEN3JDdVNDWGxyV012ZFZqdXhndWVTd2VvMy92ZGIzVlYz?=
 =?utf-8?B?UVZVL3Z3OVd3VjMvMGp4Ykd4OXc2U3BzQWlITnF6c0laeFc1TUpoRjRaNEFO?=
 =?utf-8?B?TlNaenZxZkFvSGxzVWxiRVVMU0FSRmpQWmFWR2w2REsxblEvYWY4bXRwT0Rq?=
 =?utf-8?B?Y3MzSkJ2M0lkdk1EZlZBOE1rakw3VStSMjN4a3RMSVdFYUVWZit6M291VXo0?=
 =?utf-8?B?TExpZzdiMGNXQWNXejNjV2ZlL3ErZW0vZlIvcTRJcFlsUXdVdExPcFBMNFhL?=
 =?utf-8?B?bldoK2srMjFIT2FNaGcrdEt0WFhqajVndXFtcnpjUlRreVl3dzBNT0pOdC9m?=
 =?utf-8?B?eGJiL0NONUw3TVFCa0dPaExwKzcyR01qVXFhcFZFTGVNT3Y0MzJLMExENEhy?=
 =?utf-8?B?QlpmM2swSTRsVzB2dVF6SzZxcjh3bVVzaHE5QVg4Sm85bVJCSVIwMXNYM1l6?=
 =?utf-8?B?Yyt4MUliaG11THA0SFJsMEx3WE1IRXBlQU0xdzJ4Q0lkM2hTQXczdlIreGpm?=
 =?utf-8?B?clYvUllzbzJiM1pjbFdQN095SzhFUTJQOVhqbVczVXYwdzdqc29rbHQ3Zngv?=
 =?utf-8?B?aENYU01xVFRETXUwK01XUklsTW9nR2FSS0UxUUUzOEpJODJrcTcrZkxrbE5D?=
 =?utf-8?B?UURuVm8vdVVHSUxqd1UzSU5pN1ZlWGp5OUFkaWZyTmd1YlVmc284d1R5K2Ev?=
 =?utf-8?B?M2JPZisrVVZORmpobzR5WTNXTDRFQ1FDNlJ4UUhDOUQ3Wi8yT1hQa3B3NkxS?=
 =?utf-8?B?ZHdjZTIxSktMZkFCR3FVdTBqelVhTkFqZmlUNzZkdG9pN0JSbGNINjlBYnVr?=
 =?utf-8?B?ZWZtNGNHNjVhdU55MFFVNy9UOWFvTmhncFMrZndiVWVQMEVNTlVlN3psTUow?=
 =?utf-8?B?cHFYSk5TWnhsczBxUHBzV05EenhYMWYwU0FvMDRxY2lwc3haNVJ1clFLLzQ2?=
 =?utf-8?B?QVk2blpFcWdnOGlrL3E2dkRLc0xTYmJXVkV4MFNWZFdNcnFiV2xIQm44b3Qr?=
 =?utf-8?B?YTQ0d2V1SjFoWXNDN09RUTZTRWZHajNaRVVOTHd1cmh3MTkzd0R3RHdIMTlO?=
 =?utf-8?B?alFqZjFGeEpBRWFTYlkxNGdJVEtWZ2NKc3BDNlUyZTFxN0VxNFNzYldMNnMz?=
 =?utf-8?B?SFozNkxPT2RKcEsvMUZXNkRYK0l0Z2ZVU1g1QUNSYURTTE91QmFEcFk4NVgw?=
 =?utf-8?B?NDdDZXVhNHBXcG5KMTdHc0NwOEMwZy82V040b3NET2dpdVdUK3pFV3ZzQ1pM?=
 =?utf-8?B?SmZIM1QyVkdJM2o2anZtenJGQVpBRFVGVUxzYTgyQ1VGaHZPZG9TSU5yNjNo?=
 =?utf-8?B?VEpCVVFqbjlySWhZUXZQeGxIeUt5L2hyRTVRU0dFTkQ2TEluZ0YzbGFCYk1Z?=
 =?utf-8?B?NnUvUDMrT1dMbjRYcHFjMWczYlNFNnRLWVRqVDdxSGxZYWEvL0VERzFaQ25y?=
 =?utf-8?B?aFFHbmhpK216RUhCak5SaVN0ZkpHNm1ybUQwckZ5b2dKTnRuMDV5UHpjNjZW?=
 =?utf-8?B?NlhiOCt6bU1QSmc3V0ZGb01EZVlDY2ZQMXVtR3BqM2pzZFVnVnQxUzdwR3dN?=
 =?utf-8?B?ZDhUR3dSTU5BNVFDazJyVFdlT1p3ODg2NndlQldYclp5MXJHNTRQdUxpUVB3?=
 =?utf-8?B?RmYwMzBzaW9WWHdIT1Zxc2F0TzBaWk9lSmt6NlNrdFVtQ24zaHRLOVJydVlt?=
 =?utf-8?B?VTVLUDJ2NFBhUVVYeVRRWURrcnhyRyt3N3N3cnRGVjdJSFFsN2U0cmVDWS96?=
 =?utf-8?B?ZTNDUExEc084NkVNOTFjZHZ2OWlFTFc2bzRGYUlmckJxeERPV0I0SGsycG1h?=
 =?utf-8?B?VFUvMXVnQ2dHVjNkenI0UEZQbk13TmVrRUxuM1R1WVErUk1uNUt3RWRjVkhD?=
 =?utf-8?Q?nO2QmFOPACLsbXG4xRf/p2g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F54EE778AD4FF418C0C86C7C4D35070@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c762b62-1796-4dd3-fbef-08dac72fa46d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:34:26.1783
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3nosEBWnc/0+FYbHGrYkrIiGdcLs7CUGI66+xzMpgNzB9ja0w6yL77d9xxmKAbevwTlxbZkL71DPLaDM+yLKukwdS2uYiHjR74NFG2cJ1VE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4831
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTE0IGF0IDE3OjMwIC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4gQ3Vy
cmVudGx5LCBJIGhhdmUgZ290IHRoZSBmb2xsb3dpbmcgYWN0aW9uIGl0ZW1zIGZvciB2MzoNCj4g
MS4gQWRkIHVuaWZ5IEFQSSB0byBhbGxvY2F0ZSB0ZXh0IG1lbW9yeSB0byBtb3RpdmF0aW9uOw0K
PiAyLiBVcGRhdGUgRG9jdW1lbnRhdGlvbi94ODYveDg2XzY0L21tLnJzdDsNCj4gMy4gQWxsb3cg
bm9uZSBQTURfU0laRSBhbGxvY2F0aW9uIGZvciBwb3dlcnBjLg0KDQpTbyB3aGF0IGRvIHdlIHRo
aW5rIGFib3V0IHN1cHBvcnRpbmcgdGhlIGZhbGxiYWNrIG1lY2hhbmlzbSBmb3IgdGhlDQpmaXJz
dCB2ZXJzaW9uLCBsaWtlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvOWU1OWE0ZThi
NmYwNzFjZjM4MGI5ODQzY2RmMWU5MTYwZjc5ODI1NS5jYW1lbEBpbnRlbC5jb20vDQoNCkl0IGhl
bHBzIHRoZSAoMSkgc3RvcnkgYnkgYWN0dWFsbHkgYmVpbmcgdXNhYmxlIGJ5IG5vbi10ZXh0X3Bv
a2UoKQ0KYXJjaGl0ZWN0dXJlcy4NCg==
