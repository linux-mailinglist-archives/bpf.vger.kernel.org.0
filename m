Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16A62AE01
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 23:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiKOWOa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 17:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbiKOWO1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 17:14:27 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F9F29811
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 14:14:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668550463; x=1700086463;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1UOrLJ63WOfOOsgM1snX0sRcQKVNS5wrlloxebnaSYk=;
  b=T1ppEbYr488F67mZXWr/yorURCR8di0+ul9JMNKhbp99/HOzMeR8+Hvu
   bq9P4z4MoS5+/6iHCrWIEMptxVAcQ8uhU64FcElUhWakEcp2EbE9pmIM9
   NlYCs+Y/RHDyEP7zpddN4zMV2ZZP6lwxHRPjnSb7dYHxqUHcvMF6E7gSW
   SOkIpzDZ8nWwkuRYD9ClqUykLL0FJhp/MzV022gfZrWFk8aa4ya74q3Hi
   5YBEtv5uJLrHqUHY2+CUmJAaK/6WVNLw6gfv5lVMc4MyIcMqFb1xLAMI+
   3YyMi6z9QpnJpCSxIS0aVCDBDqgNCc7x8p7hMG4A5JilvUvQqnF7KELmu
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="374515432"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="374515432"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 14:14:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="589952052"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="589952052"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP; 15 Nov 2022 14:14:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 14:14:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 14:14:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 14:14:22 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 14:14:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsinvh8qWIMXYJjm53J227uHNk0sqJeKElyJhvII+xx+mI0ezSdX4vAafQTwxphuKtPIxnUxq5lNwgFQf9DT3VbFlAltoyM+02A+2ZtDm5IQKS0YZBSWPiV48ZgmmYKBB9BJxSfVpV3f6fAaAFf8jOmR6In3xBR1nw/w/ggFrACH/DFF9IrH2qSSKO89nDCVFHOQVNP5CEyNj9IOK4BZjZWeCsTsRv++fCIRrHbghARHJbyeMZOjCC8SETeDfnI6B536Cwd2eRvjqBZkMBjktPAM+JeeyjR0sJ8Cpapgt08CQApmSbEnyu2xLKDBRe5AvFbYXzJUaxqHTx5EqMCYQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UOrLJ63WOfOOsgM1snX0sRcQKVNS5wrlloxebnaSYk=;
 b=KRbzq1v7jkQQMaeVh8UXi/RGAXxMP/JVuE/uAwi6tKt2Jl9s35hnaN22YMER6FoAPTRglJb3LxFhXlkmB11IHQrnyV//bkFk+GR8Fvzm7KwDhZsEasorRRnaDtEd7FNCxEuaAoQg3dGhSFsVQ0ARdZpsAc4xeLx5qn3Vjmz8XvKuPoZH1g/u09QrKyy0fLUjLmPnZg9ew2gcdIrvL6E1ZM2yQhNWY0oVr/B28TjtVCtt/Oz1AfV58jO16/KGz5dvxhKcIi/OkadgDDZCB1Bs4ZcZIru9WmDkrBwwWLhQViYlHaleieHvvWMVt5caR0ZeYq+pnCNq3ZWDQvHuvAabBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO1PR11MB4947.namprd11.prod.outlook.com (2603:10b6:303:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 22:14:20 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 22:14:20 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC64/PciAgAENRoCAAEi7AIAABXmA
Date:   Tue, 15 Nov 2022 22:14:20 +0000
Message-ID: <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
         <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
         <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
In-Reply-To: <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO1PR11MB4947:EE_
x-ms-office365-filtering-correlation-id: 5f0e21b6-785b-4c3e-c75f-08dac756be7d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnTLEzo8WJ7X+kGEI4Y/Io5hsaUz0V/LebL8RZKIAwmgRZjoc8PIpH2mU3OjBtYgw0M8ljrcn5pal/jDaovMgGKJ1S/iCUpl8ZIPItf6o7tiCRRIT9TblTYQeb4XavKVT2VymnJY9oNEC0zLAKwTMQ+RVXU5mxEhqJU6pEfixtR7nh080zmMnMMnYF756+l81sbvjLO0rDgymTVxbDz5yY2FvEFJw+Jr89fZUayo5Kb3NloXkwJ8JJxyRmBOr6a+CrxP/sBS52dBmNxRwfTVjmSZnf2hlvr/5aF2GIwQDrlA4S3jEirPW3IVrBvtOzYnNTqDL9yoTv9wXRPfl55Hj6uQn3RbiQqtRLwpl8nY4wNItb+deyIEBYTj7tSS/KGBRbs2OdnE2jsfnvrQNDENTS58tY182jX7z+5eGG+rdTIGMBP/70SKW7G/PKoSP51/CNdd5ULBBBkKsaHATUN1uFacCkWCI/JO39wOtWaSiaMkOSUYcT7Fzq6U4eb/8YJi7k7F/4/K5NURc60QjTKsV79t6Y3f46bJXifZyriy4zGyaRLgQHYFiE4iqqHDA2yPUippwvwpnrPkuvVQaxmv7qI8F4wZox1R4v2gAQboZvdigwDwAmkel20Ufk2ZvmfE/PexW4QZZ4EGxDRiykE+xz2t+dVaF1EwaCxcfZT04cJ0IBDM7kDLpT8M1x4EWIpJPjxPDcY3d7hHw0pCk0FlIFisn/zhYujmMKiuBmMq/Hz6eeuhWKQFF8WOLTF5FIYwJxIijj6+kOQ96c60w8CbwyTH1E3bKDzVLHheM10JlaKGPVd2DDHRnQrPvT9RyRDZ5GSh3F6Za9yuAT3nTW+QYQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(39860400002)(396003)(136003)(346002)(451199015)(36756003)(38070700005)(86362001)(83380400001)(5660300002)(2906002)(4001150100001)(26005)(2616005)(53546011)(6512007)(6506007)(186003)(82960400001)(38100700002)(122000001)(76116006)(91956017)(66946007)(4326008)(71200400001)(6916009)(966005)(54906003)(64756008)(66476007)(107886003)(8676002)(66446008)(66556008)(316002)(8936002)(41300700001)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEYrRXlrTXFwc2VYRkgzMy9FSVBUMzRPN3EySlhheXFySFVnSEJ4K0g0NytO?=
 =?utf-8?B?M3NMcWg3TzhCMVlETXFMREx2YjgzTjhiZHhsb0d5cmVFZUMraEJJWlluYzVM?=
 =?utf-8?B?RVoxajFtOVY2L0pyWXB1SzJraHB4T0x0UlFZUlliNWU2VklKTVh2NGpDL1Bs?=
 =?utf-8?B?UXFoL3VhQ0VQeVVBMVEwUmJxNmJpdkYyWjBXOGZtMXhZTzRQUWVrcXpjQ0hl?=
 =?utf-8?B?T1lUUHFIZUNtb1Zqb0phQWtvRTFyT0FJMzBuQXh4ZTZDVXVOenJNSDJiWEFH?=
 =?utf-8?B?cnRHRnUvc0Z5d1IrdFBpd0dCK2tmMWFiWlFYNzZjY0pseHkxVGlQQis0V0k2?=
 =?utf-8?B?TkNmaEN5WGZrWkdpbzllWHVmYTBTNTRIR0lDM0RNSk1KYkMwSms1YlZlVVBT?=
 =?utf-8?B?ZEF1S1RoVEVWb1hPOXp5UXNVYmVLaU1wRnYwVW9NSnNJMTZ4OHY1VFlkb0o1?=
 =?utf-8?B?dGgrUnUvRlNzay9vamYyQWNkNWpyZnlkVTQ5a0o0OWlIeVlKbVJLL2liT1pM?=
 =?utf-8?B?VXVoQ1VvTmZIRlNSNlVrNzhHTERFb0ZEYktwWFVVY2NzN0tBdFNZd2FFbnFx?=
 =?utf-8?B?SWxoQXdhRnNmTm5NSEN6dlRYUVpHdk9sRnJ6MW8xdy93VEp3c1hoWXJnU01m?=
 =?utf-8?B?aStpSytoeTJXU3pBVllEUjlWMGVsUUhZZGpFUHp4eXhrbEozbnM5WUZTL2dV?=
 =?utf-8?B?Rm9ycTNyUkJVRVNUeHBNYmR0M0ZaS3ozVHQyS212SXVIeTdlQ3l5eFU1S05v?=
 =?utf-8?B?bExSUDJWT2srVlQ5ZnA5TUJaYm1YUE44bjFRREN3SG1yS2xrakxSdWR4dlRj?=
 =?utf-8?B?M2VsTW04RmVUbGpMSnVZTUVubVdUU3Z3NnZ4cFdFc3ZSTlpIWFRpVVpmMWhZ?=
 =?utf-8?B?S3lyNUlSWFdjaThneXNyMHVBY2QyZHFoZU9ZdVZhWVpzM240Ky9Ha3hkUHZL?=
 =?utf-8?B?SlcydnRRQzgzU0JnWmZqS1EycWltK1FZOEZmaVFVSEduRzBCNjlDUTMwcU8v?=
 =?utf-8?B?NWNqZFdwMk1QODI1K3g5WWZIdkRFa3g1M2dId1B0Y3RBRDdlZ2JEcW84UTlH?=
 =?utf-8?B?THJVdER0dTlxbEFpamhZaytvRXY4K1Q0a25ib21iSkRVVDhUVitUVkF0bEkw?=
 =?utf-8?B?MFJRdmVVN0djbk56N1k5YTJHMmpnSWVyeVNmYnhZZzJsYkY0UmlacnJWZ0hi?=
 =?utf-8?B?WHpCRStGWTd5aVZzLzBZWlFWam9KSUgzUUFrUHdMTlNBd2pkTzdwaVRQZkdO?=
 =?utf-8?B?UU5wZ3ZxTVMyd1M5dlVTaUtnZjIrWThGVjhDRm5xMU9wS1NWZ015NFhYLzQv?=
 =?utf-8?B?T1lqTjBNUTFaUjZCZGltcnh4a2haSkhKR2I3WndkdWRCZkFJZk8zcnBlTDUx?=
 =?utf-8?B?U3ZtVElmeTdHKzE4ZVEyOWxacDRZYVJrTXhxSUc5NkNSTVpQeGtab2Jqai9u?=
 =?utf-8?B?VlNvY2RHTll6aDhwVWRmbE1ncEVRVVIvRkpnb3gwVytHbkxrajg4eHVYRkYw?=
 =?utf-8?B?NEgyTjE5RU54b2V6aVJtSmNQcjE1R2dUdk9xNXJNb0NJcFAxclBHYUtSTzc5?=
 =?utf-8?B?K3RBRmtOUnNqSjg1RWorekhXY0F6WmpzcGszZEVDWXdCUzJPblRqNG1YRWlQ?=
 =?utf-8?B?MWE0bUxQMXh6RDhRd3FsemNNV2xoeFVCUVArOVJiWlNYdXh4TWhPVStGTS9u?=
 =?utf-8?B?d0R0Ym9HYmhWOTNZT3dLdkhLSjB2TkZFVjJLN2NvU1MrOHEwL0U2VG8rTXY1?=
 =?utf-8?B?aWZJTC9qUkJmQ1lxaHdvRU5SUWdnQnY4VGtzZnhVZnIzaTQ0SnlmSHI1Y1pM?=
 =?utf-8?B?eG1aaUM1Tml4c1ZCcW9uWDJOaVlGQkNYMkp4ejBKdU93eGUxbkVRMnZHODh2?=
 =?utf-8?B?d3VydDQwREpJaUxDNS96R3VKM0lCditEbkxjQ2E0UnVERGVma2xBbVdXWG9T?=
 =?utf-8?B?M0x4RlU0QUxqWGNDRXZJR2xBS3lzcW1neXorc0t4KzVKRUdaMFg4Um1td2w0?=
 =?utf-8?B?THdGZW9nYjdGdjlRc2pmQWdPZTUvZmZvT2tzZW1aSUc3NVFNOHI0MkR4eThN?=
 =?utf-8?B?a1AvelV0d09pR0xKT0hLYWNTQ1laVW9vcHRSSEJCVmNGWU9hcGl5N3I5a1JB?=
 =?utf-8?B?NXVpSS9lSTVpS3k3cDd0cUd6UDh2VzFDZnRVaEQ4Y25aZ0F4TUQ0dDVhcFJs?=
 =?utf-8?Q?8+He/r471QeMrqrd8744Ews=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB634915CD62AE4B82BC43A8C9F02311@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0e21b6-785b-4c3e-c75f-08dac756be7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 22:14:20.2750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uCKHRy/Q1BrDrKshUb3+3GLoGh4+UNWqUmJH96W65YCEBL5q1Cy+acI4Q43cwMxtDJG/0vzUb7ry+Z48iFbPXt/kQfRL6XVXO/wzBtcQF28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4947
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEzOjU0IC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4gT24g
VHVlLCBOb3YgMTUsIDIwMjIgYXQgOTozNCBBTSBFZGdlY29tYmUsIFJpY2sgUA0KPiA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyMi0xMS0x
NCBhdCAxNzozMCAtMDgwMCwgU29uZyBMaXUgd3JvdGU6DQo+ID4gPiBDdXJyZW50bHksIEkgaGF2
ZSBnb3QgdGhlIGZvbGxvd2luZyBhY3Rpb24gaXRlbXMgZm9yIHYzOg0KPiA+ID4gMS4gQWRkIHVu
aWZ5IEFQSSB0byBhbGxvY2F0ZSB0ZXh0IG1lbW9yeSB0byBtb3RpdmF0aW9uOw0KPiA+ID4gMi4g
VXBkYXRlIERvY3VtZW50YXRpb24veDg2L3g4Nl82NC9tbS5yc3Q7DQo+ID4gPiAzLiBBbGxvdyBu
b25lIFBNRF9TSVpFIGFsbG9jYXRpb24gZm9yIHBvd2VycGMuDQo+ID4gDQo+ID4gU28gd2hhdCBk
byB3ZSB0aGluayBhYm91dCBzdXBwb3J0aW5nIHRoZSBmYWxsYmFjayBtZWNoYW5pc20gZm9yIHRo
ZQ0KPiA+IGZpcnN0IHZlcnNpb24sIGxpa2U6DQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9hbGwvOWU1OWE0ZThiNmYwNzFjZjM4MGI5ODQzY2RmMWU5MTYwZjc5ODI1NS5jYW1l
bEBpbnRlbC5jb20vDQo+ID4gDQo+ID4gSXQgaGVscHMgdGhlICgxKSBzdG9yeSBieSBhY3R1YWxs
eSBiZWluZyB1c2FibGUgYnkgbm9uLXRleHRfcG9rZSgpDQo+ID4gYXJjaGl0ZWN0dXJlcy4NCj4g
DQo+IEkgcGVyc29uYWxseSB0aGluayB0aGlzIG1pZ2h0IGJlIGEgZ29vZCBpZGVhLiBXZSB3aWxs
IG5lZWQgdGhpcyB3aGVuDQo+IHdlIHVzZQ0KPiBleGVjbWVtX2FsbG9jIGZvciBtb2R1bGVzLiBC
dXQgSSBoYXZlbid0IGdvdCBhIGNoYW5jZSB0byBsb29rIGF0DQo+IG1vZHVsZSBjb2RlIGluDQo+
IGdyZWF0IGRldGFpbC4gSSB3YXMgdGhpbmtpbmcgb2YgYWRkaW5nIHRoaXMgbG9naWMgd2l0aCBj
aGFuZ2VzIGluDQo+IG1vZHVsZSBjb2RlLg0KDQpCUEYgdXNlZCB0byBoYXZlIGEgZ2VuZXJpYyBh
bGxvY2F0b3IgdGhhdCBqdXN0IGNhbGxlZCBtb2R1bGVfYWxsb2MoKS4NCklmIHlvdSBoYWQgYSBm
YWxsYmFjayBtZXRob2QgY291bGQgeW91IHVuaWZ5IGFsbCBvZiBCUEYgdG8gdXNlDQpleGVjbWVt
KCk/DQo=
