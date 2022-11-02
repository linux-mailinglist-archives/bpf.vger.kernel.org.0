Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BC617093
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 23:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiKBWWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 18:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKBWWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 18:22:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B23CA467
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 15:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667427740; x=1698963740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rH12OjCatZg/cIflfH+PZuoNTVd7dbGHy9sZi9a+z/w=;
  b=XmYdPRyA0NNqaHcxGbqDvWClo2KWcMmSxGJAxeCzf3Oc90rGPE4ZVvmM
   2Jebvjth0ESJkXXVbI5aPZkkMTXpDFhnnp3dbTb7n3Une9CZOk7UQICQ8
   gRLHFk//g1uzAsgz+wqSY47IxJHfhSvmy8CpRKrw4rGaitxD7LiJIPUm/
   RFrW9Bkr3sipVyfIG9IBaDT6guliQv2GjP0HOECimLGpiLfbi/TrN++fr
   8lhaxDhf2uClPfN0BMbBx7vzLPd8TcsAbv9SeciPNOJAgc/EfRsefeOgF
   /FE+PbQRnxWde/7thjcd0PMLJechkbzjzqmEi7CL204iP7RBSrjnHC326
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="308250828"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="308250828"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 15:22:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="697984617"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="697984617"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 02 Nov 2022 15:21:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:21:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:21:56 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 15:21:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 15:21:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvgFK83t7IpmYEYo9MBBNMgLqf4d28ocTDohSO1Ejgj5uOvNqcA2D9lQoQnnPvf8QnOEf7rDBwptZI+xXaw2wDF0SwVcC8lhKAy9gvmG3rfAYRvQIdDgdaGumCr8m5ypLcoQKiY3c0Ao8tyZLktjgd0799lo5n3GrsWNoKcw/07o+OoMb2IKSNRWpcOTegI7obXam0xV6Q3uMeBuyYNBlZRF5tn3wHAEQffk1AvLcl3GHL4bT9iBXY280YB3Sdu+rsU+GO4BvELKuiFz74de4RIvasVbUp8bXgXGvzBLVtYQvoFLQUC+4EyibQCqJxCyz/0aCorZqE7FQEdJTcZbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rH12OjCatZg/cIflfH+PZuoNTVd7dbGHy9sZi9a+z/w=;
 b=d2AYM0aYHrqnqloLQQ06TcEkv/Wby0cfFaKa5Wi8E5IH7aUiD71NUCnU2JX4Q7KAGRhyivnc98kFnbdwrNt2fa4hUQrO5qlqV9i93O2t0Zy4V05D3W8ljtMglfKMmiFeWPzzfj478RFtUOlpoeaxX6l2tjk33LrTzy2LJsOMLZWdXo3DalnDv0odlogGNgdS+1bMX0526HYFFcHTrWJEHEQcOYReZGu9oiuh8YzAgE00bL5Pr6kMFUHhsGDu9B2+Gy4ecnFeWguD12Z9O6FFn/StbugPkMKeAEH79AqAQRNMfV7Xf5vLiafK7QN2lYLT/HgLyXoX5yo5OYNHjiIDFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 22:21:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 22:21:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH bpf-next v1 RESEND 2/5] x86/alternative: support
 vmalloc_exec() and vfree_exec()
Thread-Topic: [PATCH bpf-next v1 RESEND 2/5] x86/alternative: support
 vmalloc_exec() and vfree_exec()
Thread-Index: AQHY7XfIO6mQLHRAUkOuPYEg0W4ogq4sOBQA
Date:   Wed, 2 Nov 2022 22:21:52 +0000
Message-ID: <d298ae748f267a336f0089f6aa649e3291f1081a.camel@intel.com>
References: <20221031222541.1773452-1-song@kernel.org>
         <20221031222541.1773452-3-song@kernel.org>
In-Reply-To: <20221031222541.1773452-3-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB7470:EE_
x-ms-office365-filtering-correlation-id: 0aa3f626-086e-49d7-368a-08dabd20a4e2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //oOVQVEKEH2m6U4P3In46wir0xRETejItqZlmkszpGxyP8YDQiWHHwJTTC0p5ZMX3HfkEs5SP7QQ3ihjMTU55AGAaZEpo780pg4EFCKAdeyNB/NbC0MleLjCsJsshbZ7CZzw+tVChAqn+AJT/Jt27dCo5L9J2D9b2mvLyJLxiM2yWNLylNw4YGD4XT1vTH+qa9fCywxrzJQcH9f7ylpJaopHAmsu+k9bSsaFHEDEugVVOHYJKakEGNm5/agtit5dhiyTMHfPMM7DN0eH1T+vTSY7kW4sTzDc/vs2rhdUcXWbek0IKneZ6+bdsF9YgBetjeRFgHPZTI2goN3wj5167/bVUzSkQKQDozLGx0qdl4+W2hUJPVklgbh+5NZI2FOGfuPuRKnP37PjXYjfpP4hP4v6AUBeumjAKhH3QeiUUrhEngV7kqb7A9wfj9tMzNCZtAZ9v5JlFn9BSb9Hl27VeVuhiw4d5Iuzq3Jqq0ZtOOUaQ4qXzTHWRIR2U//tuyBe0TQXDcDVnpEhXoHk+/ttpUTX3vKdUyZKLGFVWsSlP67p2SVXkn4DiK06uqZSj917MKbYlkC4A/eq0zb2J2Ao2/3GZtC4NoGgQPBuWjjDh69ZvkLObacmJ5kdoivo8jWP/wdvCwoOY9dbrAV8AjEdgNOcRX6K+f0Pd54dlY9BRhVedeJulRamypOp8ueGewPt7j3LVKwvJyIRiZ6riKrb2VyS+3KadOIq7QMpRnIoGsqUgEZrqJDnd6NvPxugCbrje1tgb5mFe4uwyrhy/0dAD/i8heZbNt+0TLeuDNeouY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(4744005)(8676002)(4326008)(86362001)(91956017)(38070700005)(76116006)(66946007)(66476007)(110136005)(8936002)(64756008)(5660300002)(66446008)(66556008)(316002)(478600001)(38100700002)(36756003)(54906003)(122000001)(82960400001)(41300700001)(6486002)(6506007)(107886003)(26005)(71200400001)(2906002)(4001150100001)(2616005)(186003)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3Blc2puV0lXVlUzTFpCT3VKaDBZaWVyMGIrVlNkenhLTStNQ3Fsa1U2MFh2?=
 =?utf-8?B?aVJiOXo5NCtzQlpWSG51M2Z3amdGZktQZGpNczViU21kSjRrcm5FVG5IWUVW?=
 =?utf-8?B?Y25Dck9XRTZ5dG1LS2VDcm1JVWxGTHhROHp0Y3AyRDNqNzRBcXBpbUFmMFRX?=
 =?utf-8?B?eTdSS3hYL28xazRTdlhqTlliTDNFMXg2cm9EVTM3bDRET2NYMTZyeEV4L09H?=
 =?utf-8?B?MjFBSXBqMXptWlVqcVlxenlMVnZoMkQ5Ukd1UnNEVUFIMWxycDlFbmt6YXBP?=
 =?utf-8?B?S3ovaWIzRHZaTWRqVERQNDJtTHhqRTFxcmlYYnlJS0h3S1d3c2FMV1B5UTQ0?=
 =?utf-8?B?RWppUzRQYklCeXBhZXkrem8zVjMrdnZVVUdiZHRGOUFRLzQ2TEJVY0tJTjBh?=
 =?utf-8?B?OTJFeUF5V1JJaFdtcEVDbU9YK0djMjRFVEYrKzdza2JjVEtFMkhQM1puRkEy?=
 =?utf-8?B?bThCT1JaVVMxVTY2RkZQV1RrQURldUdYOHNNMVBsZzJ4ZlN0UFlSWDV1M3JK?=
 =?utf-8?B?OXhoQUZqYWYzbHFFNXN6UzNJQ2ZYak1naURCWFdmMFc5UjhaYzFsR01PbGM3?=
 =?utf-8?B?R0ZvUFg1S0Zsb25lMk43QnhwS2VCcHJqUWMyc0FYa0MveEc2SjFlWUFzVGJF?=
 =?utf-8?B?MzdTMmNnSkpncUU0WmRxVFBGWHRPN3NiT0wzVUs5aE5UcjE5L0JyZ2paRFgz?=
 =?utf-8?B?UzVBODBvWURrL3F6dmFYTi8vQ0ptSWkyd1dJRFJHZXZGTWdDSWZOcXhTUXB4?=
 =?utf-8?B?SXZVVXhGQnMrL2Fnakh1WllkakZNZURWKy9pU1JqOEJLR3JPL1IwM2V3Vlgw?=
 =?utf-8?B?eW1JaVhsQyt4SmhzM1RFT3UwMWtjVy9uYmtCeDNtbTVqTitQSmNHQndLSjBs?=
 =?utf-8?B?RDJOaHRXRnl4MGV6Wlg3Q1VXclVMYjlRQjkvUUYwOG95a0FQLzdzTEwvelJk?=
 =?utf-8?B?SDc4RlVKQVVUbGVuT3FIT1p2QWxwZFlqWWdNRGNycnF5U3FmcmVqN0xzZk9o?=
 =?utf-8?B?bEwwN0NxMXlESkJKZnBMUW80c25zUFNjQ3QrQzVEMkFoQmIrbkdLTkx0MnR4?=
 =?utf-8?B?Z3pIZC83YWdtMFhtMERwcDJDZFB1ZTlxbkVKaGMrdHFERzUvRTlsVHBTSGY1?=
 =?utf-8?B?QmdaMC9Ra2VyaDJnbk1BU2RyQlp3UDc3WmJ1NkxneCt2dUQ3THdOT2ozNmEz?=
 =?utf-8?B?d1FxY3N4NEpHRWdsT3N1Ujd6dWFaaVhoRG1rOXliazk1K0FFTi9xVE9ERW1h?=
 =?utf-8?B?ZFJHVzlkVjhBU2hVQm5NU0lZYmZycGNqWWc0NEFhYVpGZWthNklOU2FrM0gx?=
 =?utf-8?B?a1kvLzFwQTA5VnNGVDNMOEJEVUhPcVdsU3QvamYxM2RCRGN6WDFSYVpua2gz?=
 =?utf-8?B?V1QraUFYV09XNFNqRndxL2tlTlUxamNYZFFYSi9oMFFWcm1mQ2hRcWhTemtI?=
 =?utf-8?B?QlkzTlR6NU5Hb1lOMTN1TGRCRjVkYjF3aFJza1JLK0xHaWplcDR6S3p1aWVP?=
 =?utf-8?B?QWJEY2FxOVhIcWIrU1V0K2hXdnV5VitZRDhWUHduOEhUSVFwUGlNVkxSRE5M?=
 =?utf-8?B?WU1xaSs5TG1sa3JUTTFHSDlETmttaFdOK094dFNRaGFXNHBlT2VMajRwWllF?=
 =?utf-8?B?YWVtTy9NZlVkOU1PSkMwcE9sQW5zMHJqOU10Nm9LbDluKzJSbDlkSFpNc2xH?=
 =?utf-8?B?NldzOTB0UHFBMTVrYnVSUEcvMGN5SHpHaVNzQzhWN2MxUGltNWVUYjYzQTIv?=
 =?utf-8?B?T0Z5MzU3RjRrYy9kQlpqMDZ5ck1PNjhCUWlGcytNZlVLZWFLTmlMeXRmUkZL?=
 =?utf-8?B?QjlWQWFnZGR2dVgvYkZmK3ZwOEtnWmJZOTVMbkdpcDlMWG4rRmM0eVhBNSt2?=
 =?utf-8?B?YUdoOU8vdWJXUjZWV0o1MHlTT3lhWXFOZFNDWjd0OG8yWUo4RXFiNXA0RVZQ?=
 =?utf-8?B?N0tvU01qVUwxSFJHZFZaQjJaRXJEa3B2Y21yOFJIc2szcnlZMGtwMForN2R0?=
 =?utf-8?B?ejZEVC9NaEZxd1Z3MUJqaldJenU2U2RhaVRiYmJXUTNNcmpYT2I1VWRWTG5t?=
 =?utf-8?B?SDhKU0RpWnFQdldRRlhkVXFFQ0FmY0h6eWJOTFNLSm1aUDc5NXpMWkFudmt6?=
 =?utf-8?B?SDRIcHVZa3NVMXZNNzV3NmxGRVJybkVKaDBiZUc3dW1acUp6djJNZFk2Z1o4?=
 =?utf-8?Q?4rrJuyR/XS0ib6+a1nCJHXo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F880D285BB0F624E8163F21944921723@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa3f626-086e-49d7-368a-08dabd20a4e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 22:21:52.8613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RNLl6rd77oK1tIIxi/qGBJgr85qtTgdzJqW9xreN/F9nPt8I0Ntp/a4adE41LsOHPn8KQSEFJ232aV5lK19Xx4RUPsynaKKWAhIhltHM0z8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDE1OjI1IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IGIvYXJjaC94ODYva2Vy
bmVsL2FsdGVybmF0aXZlLmMNCj4gaW5kZXggNWNhZGNlYTAzNWUwLi43M2Q4OTc3NGFjZTMgMTAw
NjQ0DQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+ICsrKyBiL2FyY2gv
eDg2L2tlcm5lbC9hbHRlcm5hdGl2ZS5jDQo+IEBAIC0xMjcwLDYgKzEyNzAsMTggQEAgdm9pZCAq
dGV4dF9wb2tlX2NvcHkodm9pZCAqYWRkciwgY29uc3Qgdm9pZA0KPiAqb3Bjb2RlLCBzaXplX3Qg
bGVuKQ0KPiAgICAgICAgIHJldHVybiBhZGRyOw0KPiAgfQ0KPiAgDQo+ICt2b2lkICphcmNoX3Zj
b3B5X2V4ZWModm9pZCAqZHN0LCB2b2lkICpzcmMsIHNpemVfdCBsZW4pDQo+ICt7DQo+ICsgICAg
ICAgaWYgKHRleHRfcG9rZV9jb3B5KGRzdCwgc3JjLCBsZW4pID09IE5VTEwpDQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsNCj4gKyAgICAgICByZXR1cm4gZHN0Ow0K
PiArfQ0KDQpFeGNlcHQgZm9yIHRoaXMsIHRoZXJlIGFyZSBubyBtb3JlIHVzZXJzIG9mIHRleHRf
cG9rZV9jb3B5KCkgcmlnaHQ/DQpTaG91bGQgaXQganVzdCBiZSByZXBsYWNlZCB3aXRoIGFyY2hf
dmNvcHlfZXhlYygpPw0K
