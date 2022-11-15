Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBB62A04A
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 18:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiKOR2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 12:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiKOR2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 12:28:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2161711C29
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 09:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668533315; x=1700069315;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q8bMBv+VQL4IpSrjh8Blg8RJyGJ9dF5zo4GrSauuWkk=;
  b=T/NCvt8Dbt+nRA4PtIhcleycPQAi7cQV18gz3bv9T9tpCGh8vQ1kvdQj
   0Y0BFACuaHRldi7c1FUz+6CkdOeYAhoM+g4SCjqhKcVBojqFFfhKIP7dU
   e9BeuJrUJ4me7hjVY0eSByFWRnriiackD7/UiTvvDPcQGEOHXhls3/v39
   6jfRukYyzdTjciBlbof2QqHEXChu4sAhuHEQSQiJSlFus1hL1NfZMJR49
   xBcmeiSpL8GFmmVHmbunYgqkw81Otjdo7puQlsm9jhm30+C7lBPT1t2Fg
   y3Be8pTwjKHCVQVvSOjs3ePPYz5a1cP42JdfdOsYZKxu8ezm0BukG3XCZ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312320119"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="312320119"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 09:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="616833127"
X-IronPort-AV: E=Sophos;i="5.96,166,1665471600"; 
   d="scan'208";a="616833127"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 15 Nov 2022 09:28:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:28:34 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 09:28:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 09:28:33 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 09:28:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6gROKfRQgWDltvTbDX+Y+YZuO5G0ndeXGpATcvR+udkImDVi0w1w9SeNDh/cclQybq0ZLuv5hyhAfpiKXMVR+nuvNxrVB8A84kWpHaXlgnxk6e5w1r/Go0Sx7+3/A37yNIAdjnqLoGLMRQ5yfs+x4OwTBPN7XVLfTtheh8a09Bc6MDnin3GpA8TmiYM5fOmtx+C50YqXOCf49ukF0yOhjIDkYnW+iE1nqhJ/yD1EnyA/iy2kGSwAjr5CrVsCVIxMmDUl4pHVMj+cTq9WmVU40RGfgRI6GMx/YvQcLOBYfldbGDe7zDCu/9r3/dk5BEyP9kQtLJJVA6DLNFKBGXpkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8bMBv+VQL4IpSrjh8Blg8RJyGJ9dF5zo4GrSauuWkk=;
 b=R3MDu8Ur2HgcFgCtiaPm3UIcra02QpcaKub4v5TvwypgYM3n5FXGNTpSIgRCrDOYOAoaAvPJSXbXXawMHDNYLwyv0Fm7m6xjuQaDTohAH0d3/Xc5eZAl8FxE4YpqoWoI85uWAHgtqWT3gbyrfutvsE3CO0s16jEeb/11haFXPRE0AwtMtCEzYos07GvPUpnv3RIA/fCGUv9AUPDtkjCZB4Tz1dnHSFNKdCbznSL0u7JEWAlJgG+sRW/a3UAzi+LXd3xj0t5wAKy4Zm+YjuBwCYYF2P/P1McD7paxGHbi1srtKiwYqgl2T8WqLts7vJZeNQQutnlEuFupTujqgh6lJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA1PR11MB6148.namprd11.prod.outlook.com (2603:10b6:208:3ec::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Tue, 15 Nov
 2022 17:28:31 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 17:28:31 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 5/5] x86: use register_text_tail_vm
Thread-Topic: [PATCH bpf-next v2 5/5] x86: use register_text_tail_vm
Thread-Index: AQHY8vpB5ncG2TwEA0WkYnZuK4LEMK41Y9kAgAA1awCACrAiAA==
Date:   Tue, 15 Nov 2022 17:28:31 +0000
Message-ID: <24f2a65c53fd060d02e410db61ad91fcc4ca29b6.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <20221107223921.3451913-6-song@kernel.org>
         <572a1977126b54f50eb69b7b2f826e271bfd42c7.camel@intel.com>
         <CAPhsuW6rp01kuVXq7t4ukExPJY+W+nmHcgdVON7WSH+4_W57dg@mail.gmail.com>
In-Reply-To: <CAPhsuW6rp01kuVXq7t4ukExPJY+W+nmHcgdVON7WSH+4_W57dg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA1PR11MB6148:EE_
x-ms-office365-filtering-correlation-id: 77e81570-0821-4370-1e33-08dac72ed117
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IAv0zBPoshQUKWrp+aXlBkQ9tqiKQ3ZH/PppLksMSx6sDaBVfywynccHvQIbevt/zNh71asSr1jR46+mqsylRe5C8XGeCopztwvfiOpun8FnVp83e8PWtmmVnDjQkTYKWbwdiUSOvcD+LiVM5ECA3A1if57tx91FmBaDLk1/mSJIK40PoytA6sz1rht15qGPzxYEQhTd4XTSmkbLs6JoMbLkdjFJErjuoqg56jVocrEBJTZDisnCNaZ3KoqwWMltfBV3J4fditHqXqFMCdjijxfOJuknSbXbFUkWZZ28oVF3HTOmlBCBrsB4iVDm57kiLYg1TNfUVYh0eOSq2UYYuZJzQJz1dA5IyT+uOibjHIGzyJfuSOZmyj2O1CYc1kn40M9bK4duE7vRFukdQrAqDkzRCfiXv+ShIAaCGjcoll+yzOmaObjGTKPhl4xwO+HSa63SjgHdG1BAvIwkxjUDPqJYL5z8Qo8hH2TguZ281Y83vAF5Vh8KMtWYo9ZyTm4zqHPxIpRuhkUufHAIOaNUogM+Obw2zA4Bo1SFuV9GWX13DYGc7D4ExsX79nmaPOUs77+LaWQAqTUMxBV5O02yPtwCrvoRV1H7Noj5x1IZtGid7YM4QmrKckYwSqWoWITgIn6STKNOH4LxCgF5Mruexf63u/0yM99+dySlh2GlKVavcS4zQ7lStr/Ai5NwkpK7pnwHb9mYcsfM66U7iv+zSDKlgTC+NTh2jU+DhFB2NfS7Go81v8SzyKeaehIm5MZmQA7DbmI9qVxnC7Ei/u/isoUjVLseJ7HMBghJCniJRos=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199015)(26005)(6512007)(2616005)(186003)(122000001)(38100700002)(82960400001)(6506007)(5660300002)(2906002)(6916009)(66476007)(107886003)(6486002)(66446008)(71200400001)(478600001)(64756008)(41300700001)(8936002)(4326008)(8676002)(316002)(76116006)(66946007)(91956017)(66556008)(54906003)(38070700005)(86362001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eXFDTy9vV2ZvcUFpbjg1MU1aY2NpTVNubnhwMlk5NytZR3ppVGtST0VhWTNh?=
 =?utf-8?B?K2ZENHlpdkVTZzZUUHpWcW9samVuS2UwZU9RV20vUVRHeDdIeHVHN2RXQkVa?=
 =?utf-8?B?ejRjSnVkTzlKN3N3aEQ2T3VLR2c1ZjZQeFBrR2hhQ2pRSkN3bUt1cURVK2li?=
 =?utf-8?B?R3BvMGtURGs2TFhUeGZ6Tk1YL1RQWnNlc2czN1dENzJ5bFZUeXdwZDFVeHdX?=
 =?utf-8?B?Q2xrSytZcFlzWEoxeGY4aVJ6WjAvWEZiUkxCYVJiZmpMT1lPMlZUY0lKQzlH?=
 =?utf-8?B?Qnl3QWlNamdBNzFCY0d5a2Y1YnhTY3k1WDE2TGJNK3RoRTFOTzc2azRzNUVs?=
 =?utf-8?B?MktwdnFqQjRva1Z1RVlOZnAxVTRCVVBnZnZ0QVNmWjV3ZURBNXN2ZlM2aWQ4?=
 =?utf-8?B?UWdOa3ZaM3E4VEltUjBmdVphYUhTS0gzSGZ4UnV4Tnd2cmMzR1RSKzRkYTNU?=
 =?utf-8?B?RFBGdDIrR1NpcDFrejFteFQ0eFpNUjFuK01tOVJaNVQxWlJpQVRYS01KcVho?=
 =?utf-8?B?dlhTT3l3ejlzR0JCNS95YW9WZnNHc1BnbzdBWDdnWFE1eDNMWnpOV3BZSk9D?=
 =?utf-8?B?TDNhMW0ySDVBVnl4QldVeG1uaDhhcGt6WXJUdDV4NDBFNFhoWEtOUTV5ODIv?=
 =?utf-8?B?MFJwWHZNczd3T3RzTU1SaWk3cVJrek54UUd5N084WGhKbjk0WXQrK01FQk1D?=
 =?utf-8?B?RDZldUlVSFhaNnEzaGIva2dmeWprbmlMRHVkTjRZdXhLY25JbHREYzd1VUla?=
 =?utf-8?B?VzRCd0gyakZJR3NRWTgyL3cveGw0V0ZmdlpHWkVVTlplSUJ4ODY3eDhNdkg2?=
 =?utf-8?B?cGJTYzg3Wi8rd0NOUnZXY2FsRTBzbkRYOUprd29UVEZBeXFBWW9VN0hZaWI1?=
 =?utf-8?B?aWFybGxlQnM0WmNFOHBwZXcrMVFzdGthR0NtTjNPdE5qbVZwaWw3bldCRFNY?=
 =?utf-8?B?S05vT3doNTZrTW1QaEdOZWZNcnBMQ2JyamtBTWdrcE5MWlFwUUF1UmJ4cnNL?=
 =?utf-8?B?SXRmY0JVaVdxaWFGSFV5N3RtVFBSTjdhTzdiTm9saWlxM0hQYmplc0FESTFX?=
 =?utf-8?B?eTc5UGQ4ZU9aSXlpcWVWSHlhZnV6TnNSYTQ1ZXRnaGczT2pKUzVtNURPTzZy?=
 =?utf-8?B?blJ6M3gzQnVNUmpLdjdJR3FwS0Q4c2JSZ0JvVjFlcWp2MTBQMDMzUzlKVnpi?=
 =?utf-8?B?Y2EvYzdxalROMGxoTlBWbGN4UW9JUjR6L1MvR05nRVZod1NQWWRsZXRlN1Zr?=
 =?utf-8?B?QjI2dVFadThOaVNoYkFuamdMWkNvSzl3b1g5NVZzalQ2UE5yVjBGSWRpd2pt?=
 =?utf-8?B?TmVDSmU1RUhjK202aEx4TldJNFZTWjQ2L1dESG9YcG04MDNNVjVSZXYyVkw1?=
 =?utf-8?B?alVJS3ZBdWpkWXhKc1NvRkNJWjJmRGJOSjRic2hOYzlkUWswL3B4YW05OTc4?=
 =?utf-8?B?RHo5REM4RnpVTFJCZmNzTzg3c2RkKy9HMXUwSUZCWlV4bmFFWGpweWNBRVo0?=
 =?utf-8?B?eXR5K3VXSURvMDl2S3JHSlozaGxobWtrM1lvZTJGUDFaTDhWTGNyWlRNL0Nq?=
 =?utf-8?B?dXVENTZDOVhKSUxQYzlLQWx6cDRpTXJwQkhybFBTL2wza200dGNya2RYOGpp?=
 =?utf-8?B?cklZbjRHemxDL2cyZzRVeWNlL1VheGREam9CQjRXRU8vdWErNks2MjZoQW9E?=
 =?utf-8?B?MmhlSy94SHBnRmppUlJMTHlFUzNFUXpnMmdMYUdXTXRtREg4Smc5dlNNRzJ4?=
 =?utf-8?B?S0gvTXJNVTl1LzkrN1NORkFydEN4RnZmd25HdkYxNEl5QkdqM1NGVXRpRnpz?=
 =?utf-8?B?cGwxMStpdzJkZlU1aWxsWXJTRSszYWsrTDEyTDVxK0JEMERuVmN6MGJZemZ2?=
 =?utf-8?B?SkF0amcwSUs2MXBOeDRtbDFtM2NUWnZYZDhHWkw1OVUwVkxWSFlpemRlODhZ?=
 =?utf-8?B?T3VZYjJEWkZLODFZclN0OTQrRkdQMk1pUFp1d3VEKzZxSkxPY2dwckdmRFNj?=
 =?utf-8?B?Qld5ZHlkMDFSaVJjc0daT1RralFnaDVUZU1WS0Q0dHJsR2pnblhJd1FyT2Za?=
 =?utf-8?B?MzNRTm4yNUNtYTVCNFhlbWc2cmx1SkhDem45QmljZS95dnBSUHFIWUFJbFpV?=
 =?utf-8?B?MTdZUnI0ck51VG1Mem82Z1FmcWxZTC9YeDE5TjA3ZE5GS0ZNVUdXam56M0dO?=
 =?utf-8?Q?JudHF4jLjjyF+D83M95+xxI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66CED2C53737F84E937EECEEDC6E360A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77e81570-0821-4370-1e33-08dac72ed117
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 17:28:31.6254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kB6rPLK5jXGhO9dy8jsfb6PhmP+TvxeqCy7zqzOPlJ0lK8jbUv9+leanW856Lk3gh9ST/qhVaIrg0MLzLWAdqGKSEFy/aviVSEo7q3gqmMM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6148
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDE0OjE1IC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4gZGlm
ZiAtLWdpdCBpL0RvY3VtZW50YXRpb24veDg2L3g4Nl82NC9tbS5yc3QNCj4gdy9Eb2N1bWVudGF0
aW9uL3g4Ni94ODZfNjQvbW0ucnN0DQo+IGluZGV4IDk3OTg2NzZiYjBiZi4uYWMwNDFiN2QzOTY1
IDEwMDY0NA0KPiAtLS0gaS9Eb2N1bWVudGF0aW9uL3g4Ni94ODZfNjQvbW0ucnN0DQo+ICsrKyB3
L0RvY3VtZW50YXRpb24veDg2L3g4Nl82NC9tbS5yc3QNCj4gQEAgLTYyLDcgKzYyLDcgQEAgQ29t
cGxldGUgdmlydHVhbCBtZW1vcnkgbWFwIHdpdGggNC1sZXZlbCBwYWdlDQo+IHRhYmxlcw0KPiAg
ICAgZmZmZmZmODAwMDAwMDAwMCB8IC01MTIgICAgR0IgfCBmZmZmZmZlZWZmZmZmZmZmIHwgIDQ0
NCBHQiB8IC4uLg0KPiB1bnVzZWQgaG9sZQ0KPiAgICAgZmZmZmZmZWYwMDAwMDAwMCB8ICAtNjgg
ICAgR0IgfCBmZmZmZmZmZWZmZmZmZmZmIHwgICA2NCBHQiB8IEVGSQ0KPiByZWdpb24gbWFwcGlu
ZyBzcGFjZQ0KPiAgICAgZmZmZmZmZmYwMDAwMDAwMCB8ICAgLTQgICAgR0IgfCBmZmZmZmZmZjdm
ZmZmZmZmIHwgICAgMiBHQiB8IC4uLg0KPiB1bnVzZWQgaG9sZQ0KPiAtICAgZmZmZmZmZmY4MDAw
MDAwMCB8ICAgLTIgICAgR0IgfCBmZmZmZmZmZjlmZmZmZmZmIHwgIDUxMiBNQiB8DQo+IGtlcm5l
bCB0ZXh0IG1hcHBpbmcsIG1hcHBlZCB0byBwaHlzaWNhbCBhZGRyZXNzIDANCj4gKyAgIGZmZmZm
ZmZmODAwMDAwMDAgfCAgIC0yICAgIEdCIHwgZmZmZmZmZmY5ZmZmZmZmZiB8ICA1MTIgTUIgfA0K
PiBrZXJuZWwgYW5kIG1vZHVsZSB0ZXh0IG1hcHBpbmcsIG1hcHBlZCB0byBwaHlzaWNhbCBhZGRy
ZXNzIDANCg0KSXQncyBub3QgcmVhbGx5ICJtb2R1bGUgdGV4dCBtYXBwaW5nIiB5ZXQgcmlnaHQ/
IEJlY2F1c2UgaXQgZG9lc24ndCBnZXQNCnVzZWQgYnkgbW9kdWxlcy4gSSBtaWdodCBqdXN0IGNh
bGwgaXQgZXhlY21lbSBvciB3aGF0ZXZlciB5b3UgY2FsbCB0aGUNCmNvbXBvbmVudC4gT3RoZXJ3
aXNlIGl0IGlzIG91dGRhdGVkIHdoZW4gdGhlIG5leHQgdXNlcnMgc3RhcnRzIHVzaW5nDQp0aGUg
QVBJLiBPdGhlcndpc2UgbG9va3Mgb2ssIHRoYW5rcy4NCg==
