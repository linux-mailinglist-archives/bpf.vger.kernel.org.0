Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11A532F24
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 18:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbiEXQnM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 12:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbiEXQnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 12:43:11 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F883DA7C;
        Tue, 24 May 2022 09:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653410590; x=1684946590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MPogCQE8C3Il7RsCO1j43fxrKvak9eATmxi5ceE0feE=;
  b=NTcF9X8aYLaGZ/sEqygqTF7KQbekea8qoyhbIpgHYzkSIMm2d76Q5msP
   ZIYRjJc+BAvFQDdPu/5W5G18tF+dgm8tpzxLu+zIU3zyeAf2tdw/wr40v
   matA2kF/30GoM/3HOFS0ftgnGXEFCdgzxUfS8wZDgqJcNqh8hC7qsjmG7
   uP/0o/hJK4wJRPMxGnSecQYCBjgrf49x5sygcQQ8h/V5305jZeF8BszpY
   upOijjQRg/gARM6N4Ezs1FtroqpLsGwYuhvvM9nNPkEuKAnFSOlp6jmIe
   Rtt5r5ileKj9gaujIj+4eFUvghqChhqCbR3ULX69fyenSLISFfkxHqtYS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="272400496"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="272400496"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 09:43:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="642006413"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga004.fm.intel.com with ESMTP; 24 May 2022 09:43:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 09:43:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 09:43:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 09:43:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtL6UQcFrheHI8zzU6iLo5upkz/j0eoXS/jtLEDjVkEHPIO7UuSJjWAcqRmzXs9BD0g6WEfKjyrwQalZ4q5lR39kjSkxenV3XS9FRhDTJUxIyKpZo+xNEZ0miKw6SA5kz7pDbx1VmYbmavKJHcQ5qijOdJrJZFSgX2DCqhMCeMyPn+a8c5oYf24z27sL9qL9eeUzOOZOKVqC6dTn+9USXatsnFweU4jxzW6bwWmGsLFgR/METh3K5fdZW5rhCo3MLfc0Hm+geoZ/6ez7itCAK1sa6VOvuR0kD5/Djwx1mEs8nv67ZTQ6T6qxm/uYl/ZHQlavkmq9Iyv+dEYV2ICx0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MPogCQE8C3Il7RsCO1j43fxrKvak9eATmxi5ceE0feE=;
 b=Z4xdVYAv6rhitnHnRPgEsoDTiCq1E/R0Fi4OtYHsvF0dlF9fIuq+4/v0Aj386scsQTgcTwbG9cgQuo6H9c8z5reVyk4/C+L+LKsiEXVhGQFGtkiKokkAkgsxOSlqPiKiz5zauE5MVS0DMJ4FzpGudS1jKdnapqy/BdWk/v5N4UYB1OpgIAJZ0EOGHmhtxgP/ye0QrNaB4itedZ7Fce+TOk5pd98+aJrz5+4kyVdzx4KW6W+DFCNXHyJL7N5nDi0t5CqDF7SOfqVL8zXaE+ZZrN7e/ymRnrinHchgGY3pfXXLX6EVHKt/tPPgmV7r1idkURo+fgCijpUUYODXj9fhuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CY4PR11MB1815.namprd11.prod.outlook.com (2603:10b6:903:125::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 24 May
 2022 16:42:35 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5273.023; Tue, 24 May
 2022 16:42:35 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v4 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Topic: [PATCH v4 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYbKXnj3o6xLcz+0eRQs/hI9nkpK0tpJ4AgACcnwA=
Date:   Tue, 24 May 2022 16:42:34 +0000
Message-ID: <4fb734063815d34ef0180927f61702394783199b.camel@intel.com>
References: <20220520235758.1858153-1-song@kernel.org>
         <20220520235758.1858153-6-song@kernel.org> <YoyHmGoEN7kQSw3N@kernel.org>
In-Reply-To: <YoyHmGoEN7kQSw3N@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11a81fb8-3a0c-4159-2da9-08da3da4679a
x-ms-traffictypediagnostic: CY4PR11MB1815:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB18153572390E1AF6C2DF9517C9D79@CY4PR11MB1815.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vgBslL0bWkZImFkfcRPb5NNjLz6J9rtKv2qxmbc9Iin8AKxWeE9pW9tXusl2NWu3EHq2M2quVpIrhS1GFXDXVb++4eDwi4yj0pNC0tUiJuxrE53OyUAoWoqtExzHhRNB1Y27iKMJ1hcXt6yJG78uDd9tfWLeTDmg6gd2H7DJAX2OyfYR+sP1z435LVAHmKEfOMQtbZ1z9q1HQwwkvQP5idNxSorZel1qeZvsUnU6OBidLIuFLhgVXjSPEmTxf4YuLq/yHZmwbEUeR8DCCJQDBxMIDxNihK0a9xGsgr4sTtJak3KF3J3Y5hJi1hXHdn4s0oD4q+vBuJziNfhUk7gQhRVr2rq2yTccCuuzQA4gCkWeWyGR9h3I2IAMYroWWvNu6nBeNEzLRSCPRPMhVqfehiRM+s506oJ4MjOts/bvck5lhhyEHPEHNcvDCZZ4wbmIVRuploubPpKnTtSm0hHrkA1VbHHCG4JIcRvt4nw9CV6OfFEF/X6wFgJCb1g023rdR1A6m+VpO3IND9oqMkKBxT/k7jVPONacrE3qyQb754nOY1oeRHOxRJCoP9U9eWlqoxJInJ9AVmu68STkT9+rBcSJN/SUPVNDYTi4TidZD1HJZVZvhlQGoIrLCbNBJfnbWn8VLv1T84utJTmcUYQz0hNEQJDEA48qDnrkmVIL0SkpdqN2Xip7aT4Si2MxmzpFTZ1y/zFfGMybMYw2KPF4Le8SrHG3Dh7BYjyepcVMX6r5eHJb3z7qo4r+zM3cUcAt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(66556008)(66946007)(66476007)(6512007)(26005)(64756008)(66446008)(4326008)(8676002)(76116006)(82960400001)(508600001)(86362001)(5660300002)(71200400001)(6486002)(83380400001)(122000001)(2906002)(8936002)(316002)(38100700002)(2616005)(38070700005)(36756003)(110136005)(54906003)(186003)(7416002)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?emZQeW5LQ000NmRsMkc4UU5Vdkk1S29MM3RCcHNWN3hVaDVMSUxGNzVkQjg5?=
 =?utf-8?B?Q1BFSjZwbzNudGZPeiszUDVFU2FnRk9zL2k4TFhTM3lCWURZN1BpOWJaTldl?=
 =?utf-8?B?ZFpJRHQzSWZER0RHaHc0UEdXc1Q0TzdpNzI4Si94aUNTenk3cXpmb21PaUdY?=
 =?utf-8?B?V2R4cHN2UTNnTDQ5UytLRUUvTmJUMnJpS1haK2FPWDhZVmtjd3RvOWp2aWM1?=
 =?utf-8?B?SE9Cbm5Lb0VyVTRuRGNiaDFlOGU2OGxvem1NMHh3Zyt0T0k3UElrNFh0eVh5?=
 =?utf-8?B?R3Q2QUFZaDk0N2QwbUJIWnN4VUJpV2ErYThuSFhvUWQ1QlUyengxMHU1eHVl?=
 =?utf-8?B?d0F1Q3B3NWFyaEo3dzVBajZYZlRBTmlad05rTnQ4allsWTcxb1c4TWVoWXBY?=
 =?utf-8?B?KzlPWXlEUVpZdk8waTBoN01zQXJHbTlHRWcxaXFBcFpDUEpvSWpDS0JjYVFy?=
 =?utf-8?B?TUppSmtsUVFtbmJnTGtkMFM4ZUR6N0tBMkNiM0l0czh2cXM3UkJrM1FRck1p?=
 =?utf-8?B?VnlRSmxPVURqM0pjSy9yTUc5VXZvMC9odHJJWk9LcWNyQ3YzcXZoWWFuNHhD?=
 =?utf-8?B?MVFvZXpwTUxwMHgyeE9uWlJGVEM2UHRsNCtIbDZvSjNxY0Y3UmdhYTdQMG1v?=
 =?utf-8?B?U05pQTdPVjNFWk5PczZLTTlpbFdTdWVDb1Mra2NQVXp2d3VTZlFzK2NlRG1T?=
 =?utf-8?B?ZmV6WHJSTXR1dUExNHFJRzd4aFFDUEwvWlROWmFXYXhYUEE2MUlvdnVybVhq?=
 =?utf-8?B?Z2hIS1FJaDM2WDVQLzlrNExJWldUYWtIczVsRWplb1FseDQ5aCthS2doMEpY?=
 =?utf-8?B?ZlQ1ZGlmTzdZS1VkS1EyRjE4aUVmVkFnNkhmNWFIR00va2puSldxK3c1cTJJ?=
 =?utf-8?B?Qmp4TXFveFA3NXdsa2k5OG1qa2RYTk4yUTFvbTUxYUNRbHZJTFlHUzFUUUxw?=
 =?utf-8?B?cERpR0hxUXhkU0JzT2VtcGdlQlA1SENuKzY2amVvUDloaTNlKzUzOUh0eGxQ?=
 =?utf-8?B?NzVQdVZIS1N5U3pQbkhlL1RqZDR4RkdTbmNNb2FDRzM3T2hNbit6cXU5amw0?=
 =?utf-8?B?dDFPSlVOUVdObEZGSmlRRnlHQmJBS09RQjF3Mk9XNGlPcGdKVGdGZWs3V3g0?=
 =?utf-8?B?MHFEbzBlclN4NXpwRkg2VWRUK1dSSkxlQklWVDdUSTRGbmNqN0dvL243Ritv?=
 =?utf-8?B?TTJ1NHZBQVdySkpXL1ZjYm1WMHI5aTQ0bDM1bTJEcUtnaDQwVlF1MmFKaDRR?=
 =?utf-8?B?ejdDVm5WaWgxQmhNUVBNdnlXeHpoSUVLNXc5YTFBK21jQk1lSVB3SEI2RER1?=
 =?utf-8?B?NG5zZHMwV0FVL1psYWdUSnNodHhESW1TMVhPaUFKc3JQNWttbTBFZXlLdXJ4?=
 =?utf-8?B?d1NtMFowbm1Ua1czVzMwY3d4anlSMEVIVWozVmdvbXcvMkhOdUJ4eUtnTUYr?=
 =?utf-8?B?M3hPMHRtajdiTTNiaS9VeUlwN0JaQ3NTRE04VVhyVy9ETW1XcmR3YXRzMU54?=
 =?utf-8?B?b1htYUYwV3FpbUJrY1pRQ2J0Qk5DZEt4STdHemVFL2x5Z3NZZUZSbEd2N2c3?=
 =?utf-8?B?SE9rSUFsODFpaVZYZzNOYkVSTi9lMWttT0RXTVhCZHJKMGxNMEVNZGhHbWwx?=
 =?utf-8?B?V3BaTHk1dm1rbUZsLzVvVFllU29PK09wR2pmS09DVXVtV2JiaWN4RGdITzZ4?=
 =?utf-8?B?WW53a0E3aDBPVlZGR3NGZUt1bUtUemR1L1hXTmxwc1VkWkNZYUhIYUd6UHcw?=
 =?utf-8?B?aDh5dlRDdm43WU5DSW4xZmVUTlgwTlRPaC8rK0x4cnNBWDl3MHhyd1ZPVjN3?=
 =?utf-8?B?L0xyRHNCZEpMaHFJb2pjVFQvOVpIbzFuVHg0U3ZmbFlnK2hVOXBwa3EyeGwx?=
 =?utf-8?B?MkVVcXYrV3B6RzlLZVdnbGtNNENtLzdCRjErbmxZOUQ1S2FOcTBHVUpBNkRz?=
 =?utf-8?B?RzlqVHJ0MVlVcjdaRDJRYWdNMHV0NFFNZ2FWLzMrMFR5VU8vOXpWOXlmaS9t?=
 =?utf-8?B?UjNCdHVIVFpIRUY2ci82VFBFZE95eTQ2TkRSM0FjZWxHUEFObytHaE43M29J?=
 =?utf-8?B?MWtKUnRyUy9xWlgzVjE2c3FoQnVFTVhHTFpZaDdOOFBGdGFnYjM3TlNycEZz?=
 =?utf-8?B?eW5WVWpJMElGSW1kTC9ielY4aDRTdEJxVHNPdUtmbmxDbU9nb3JyTVpxdmxW?=
 =?utf-8?B?Q0xWQWJqeVcwdUtXSWNVWHlUQWhJblM0Y0t2YXdFMWFDUk5OOE5ZNmZZakVr?=
 =?utf-8?B?dVVyVnVwQUJBUUpMcWkvWGFqUFpSQ1NYQnJ0L29Va0FUYWdrdlhKUndENEU5?=
 =?utf-8?B?M2Ywa1RQRVdJUmxLY3BWTmhHa0d1ZzVHMFpmUER2ZngzaGx2Vk1iQ1o1bUZp?=
 =?utf-8?Q?55iTcgh9wYTeB8yCvo+23+3xaKliAmXpoisUR?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB23BAF03B76B6489F4B4B7F6241506B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a81fb8-3a0c-4159-2da9-08da3da4679a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 16:42:34.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Gg1sEhrGR6yh6MAAX/qQsEJh64m6ExAf7tsR7sLZqpXeNcznmY10JnnzN5rV5UwAlhsh5fW6bagDWV44kX/WHVp5+Unvk4IVDW0BN2xm1s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA1LTI0IGF0IDEwOjIyICswMzAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IEBAIC05NDksNiArOTQ3LDggQEAgc3RhdGljIHZvaWQgYnBmX3Byb2dfcGFja19mcmVlKHN0
cnVjdA0KPiA+IGJwZl9iaW5hcnlfaGVhZGVyICpoZHIpDQo+ID4gICANCj4gPiAgICAgICAgbXV0
ZXhfbG9jaygmcGFja19tdXRleCk7DQo+ID4gICAgICAgIGlmIChoZHItPnNpemUgPiBicGZfcHJv
Z19wYWNrX3NpemUpIHsNCj4gPiArICAgICAgICAgICAgIHNldF9tZW1vcnlfbngoKHVuc2lnbmVk
IGxvbmcpaGRyLCBoZHItPnNpemUgLw0KPiA+IFBBR0VfU0laRSk7DQo+ID4gKyAgICAgICAgICAg
ICBzZXRfbWVtb3J5X3J3KCh1bnNpZ25lZCBsb25nKWhkciwgaGRyLT5zaXplIC8NCj4gPiBQQUdF
X1NJWkUpOw0KPiANCj4gc2V0X21lbW9yeV97bngscnd9IGNhbiBmYWlsLiBQbGVhc2UgdGFrZSBj
YXJlIG9mIGVycm9yIGhhbmRsaW5nLg0KDQpJIHRoaW5rIHRoZXJlIGlzIG5vdGhpbmcgdG8gZG8g
aGVyZSwgYWN0dWFsbHkuIEF0IGxlYXN0IG9uIHRoZSBmcmVlaW5nDQpwYXJ0Lg0KDQpXaGVuIGNh
bGxlZCBvbiBhIHZtYWxsb2MgcHJpbWFyeSBhZGRyZXNzLCB0aGUgc2V0X21lbW9yeSgpIGNhbGxz
IHdpbGwNCnRyeSB0byBmaXJzdCBjaGFuZ2UgdGhlIHBlcm1pc3Npb25zIG9uIHRoZSB2bWFsbG9j
IGFsaWFzLCB0aGVuIHRyeSB0bw0KY2hhbmdlIGl0IG9uIHRoZSBkaXJlY3QgbWFwLiBZZWEsIGl0
IGNhbiBmYWlsIGZyb20gZmFpbGluZyB0byBhbGxvY2F0ZQ0KYSBwYWdlIGZyb20gYSBzcGxpdCwg
YnV0IHdoYXRldmVyIG1lbW9yeSBtYW5hZ2VkIHRvIGNoYW5nZSBlYXJsaWVyIHdpbGwNCmFsc28g
c3VjY2VlZCB0byBjaGFuZ2UgYmFjayBvbiByZXNldC4gVGhlIHNldF9tZW1vcnkoKSBmdW5jdGlv
bnMgZG9uJ3QNCnJvbGxiYWNrIG9uIGZhaWx1cmUuIFNvIGFsbCB0aGUgbW9kdWxlcyBjYWxsZXJz
IGRlcGVuZCBvbiB0aGlzIGxvZ2ljIG9mDQphIHNlY29uZCByZXNldHRpbmcgY2FsbCB0byByZXNl
dCBhbnl0aGluZyB0aGF0IHN1Y2NlZWRlZCB0byBjaGFuZ2Ugb24NCnRoZSBmaXJzdCBjYWxsLiBU
aGUgc3BsaXQgd2lsbCBoYXZlIGFscmVhZHkgaGFwcGVuZWQgZm9yIGFueSBtZW1vcnkNCnRoYXQg
c3VjY2VlZGVkIHRvIGNoYW5nZSwgYW5kIHRoZSBvcmRlciBvZiB0aGUgY2hhbmdlcyBpcyB0aGUg
c2FtZS4NCg0KQXMgZm9yIHRoZSBwcmltYXJ5IGFsaWFzLCBmb3IgNGsgdm1hbGxvY3MsIGl0IHdp
bGwgYWx3YXlzIHN1Y2NlZWQsIGFuZA0Kc2V0X21lbW9yeSgpIGRvZXMgdGhpcyBwYXJ0IGZpcnN0
LCBzbyBzZXRfbWVtb3J5X3goKSB3aWxsDQooY3J1Y2lhbGx5KSBhbHdheXMgc3VjY2VlZCBmb3Ig
a2VybmVsIHRleHQgbWFwcGluZ3MuIEZvciAyTUIgdm1hbGxvYw0KcGFnZXMsIHRoZSBwcmltYXJ5
IGFsaWFzIHNob3VsZCBzdWNjZWVkIGlmIHRoZSBzZXRfbWVtb3J5KCkgY2FsbCBpcyAyTUINCmFs
aWduZWQuDQoNClNvIHByZS1WTV9GTFVTSF9SRVNFVF9QRVJNUyAoYW5kIGl0IGFsc28gaGFzIHBy
ZXR0eSBzaW1pbGFyIGxvZ2ljKSwNCnRoZXkgYWxsIHdlbnQgc29tZXRoaW5nIGxpa2UgdGhpczoN
CkFsbG9jYXRlOg0KMS4gcHRyID0gdm1hbGxvYygpOw0KMi4gc2V0X21lbW9yeV9ybyhwdHIpOyA8
LUNvdWxkIGZhaWwgaGFsZndheSB0aG91Z2gNCg0KRnJlZToNCjMuIHNldF9tZW1vcnlfcncocHRy
KTsgPC1Db3VsZCBhbHNvIGZhaWwgaGFsZndheSB0aG91Z2ggYW5kIHJldHVybiBhbiANCiAgICAg
ICAgICAgICAgICAgICAgICAgICBlcnJvciwgYnV0IG9ubHkgYWZ0ZXIgdGhlIHNwbGl0IHdvcmsg
ZG9uZSBpbiANCiAgICAgICAgICAgICAgICAgICAgICAgICBzdGVwIDIuDQo0LiB2ZnJlZShwdHIp
Ow0KDQpJdCdzIHByZXR0eSBob3JyaWJsZS4gQlBGIHBlb3BsZSBvbmNlIHRyaWVkIHRvIGJlIG1v
cmUgcHJvcGVyIGFuZA0KY2hhbmdlIGl0IHRvOg0KcHRyID0gdm1hbGxvYygpDQppZiAoc2V0X21l
bW9yeV9ybygpKQ0Kew0KICAgICB2ZnJlZShwdHIpOw0KfQ0KDQpJdCBsb29rcyBjb3JyZWN0LCBi
dXQgdGhpcyBjYXVzZWQgUk8gcGFnZXMgdG8gYmUgZnJlZWQgaWYNCnNldF9tZW1vcnlfcm8oKSBo
YWxmIHN1Y2NlZWRlZCBpbiBjaGFuZ2luZyBwZXJtaXNzaW9ucy4gSWYgdGhlcmUgaXMgYW4NCmVy
cm9yIG9uIHJlc2V0LCBpdCBtZWFucyB0aGUgZmlyc3Qgc2V0X21lbW9yeSgpIGNhbGwgZmFpbGVk
IHRvIGNoYW5nZQ0KZXZlcnl0aGluZywgYnV0IGFueXRoaW5nIHRoYXQgc3VjY2VlZGVkIGlzIHJl
c2V0LiBTbyB0aGUgcmlnaHQgdGhpbmcgdG8NCmRvIGlzIHRvIGZyZWUgdGhlIHBhZ2VzIGluIGVp
dGhlciBjYXNlLg0KDQpXZSBjb3VsZCBmYWlsIHRvIGFsbG9jYXRlIGEgcGFjayBpZiB0aGUgaW5p
dGlhbCBzZXRfbWVtb3J5KCkgY2FsbHMNCmZhaWxlZCwgYnV0IHdlIHN0aWxsIGhhdmUgdG8gY2Fs
bCBzZXRfbWVtb3J5X3J3KCksIGV0YyBvbiBmcmVlIGFuZA0KaWdub3JlIGFueSBlcnJvcnMuDQoN
CkFzIGFuIGFzaWRlLCB0aGlzIGlzIG9uZSBvZiB0aGUgcmVhc29ucyBpdCdzIGhhcmQgdG8gaW1w
cm92ZSB0aGluZ3MNCmluY3JlbWVudGFsbHkgaGVyZS4gRXZlcnl0aGluZyBpcyBjYXJlZnVsbHkg
YmFsYW5jZWQgbGlrZSBhIGhvdXNlIG9mDQpjYXJkcy4gVGhlIHNvbHV0aW9uIElNTywgaXMgdG8g
Y2hhbmdlIHRoZSBpbnRlcmZhY2Ugc28gdGhpcyB0eXBlIG9mDQpsb2dpYyBpcyBpbiBvbmUgcGxh
Y2UgaW5zdGVhZCBvZiBzY2F0dGVyZWQgaW4gdGhlIGNhbGxlcnMuDQo=
