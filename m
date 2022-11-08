Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A107621CA7
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 20:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKHTEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 14:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKHTEW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 14:04:22 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDF5E9DD
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667934261; x=1699470261;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oP0ETXmUHIikCsQ7GnlpGUJyDKg/oi6skvt3oSeuQFA=;
  b=VSTiiXqF8qx9QrR6qFBsZmzy9JrIWKid8iu4eb8OnIkQdwvuJhDeukUL
   JgyAJ0Dei7SC0IMEES5SBN808HjLV7RfML0iG4Q+BRdskMb4LoPacrKKK
   PvCEJFJnJHhBLauIQLwgg7jiriXIQYIYBKp+Xuwzc+bWbwAixVEszSCZb
   xTy3wrqKW6gDnUZQAr8kX4Yi/MIjwVnzgQ4tDk6lDE1jniRnKEzI65COe
   zPCY6IFBFhjKdLLqxNkFEYTTS9GVkESNNvf0BZlsuqsiynBrTWjQ2sIKl
   4o2w0RzU4zeOoZ5aLNRL5MF9CRTopiw4IpgiaNVx46yc854TOU0UvjvX2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309488694"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="309488694"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 11:04:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705410743"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705410743"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 08 Nov 2022 11:04:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:04:21 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 11:04:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 11:04:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 11:04:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zme3IUbnMMlPtLmIfmp5DmXh3rJumI8NZaVLEQG4Wo2YmGFVXXXw3V+Ra6bVx+b8phyAD4YrbyZdS/OL7x83H5Zl/GilIyVTxEG0a1PTiIMtQQQ9IAfCB7PgW3LN0Z8VTtS+3mo6MkHxvEGffG+56maIqE3ZOHaBmBFHO7o25oDWqpw3pcbE1F7juvP8yWV886dQ3hObE5RrDia2JjBS9hl65BLzT8MAKFHgQaWSNsxNNPSJ6i29ZquP984IPBV0fpPwpJ2SO8g7t1ZcOodHxU0cIZ7ip97bGkZ/Ng8Yixav9n/zs2/zuWoKmmq/t1xqZgWKmLEnW2RErudxsE2i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oP0ETXmUHIikCsQ7GnlpGUJyDKg/oi6skvt3oSeuQFA=;
 b=nsE7iONnMpNydSEvB9SlfxUDIdioCkK4G0WwFdm19CMWfFhU1xYure9/IyJymCCOxDDuq9jnOaTtW6zWNKFF93Trnrk0cw08Ke5OUd4mb5z2BqBXNFFq1dl5zqT08+s2ZcqHW0eUzrUv/mMKdVX7zhW5MrYs+/Ln9tthVMMwTJY6chhE3GmaPx2QThSM5FcJPuwKW+U5hitRWtBJixSDw3hzQSWH+z9QKm+u6fPp3SlRL8A2+edmuHoH7mcn2HbzCGJbs5vW/QVUBls+r755ih6Xk9q5VAGKOeFzVw50VslfkNOW0WzzHpce+NB0na7Zv01brSWKa6jXpeGvcZ0zBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by CO6PR11MB5571.namprd11.prod.outlook.com (2603:10b6:5:35f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Tue, 8 Nov
 2022 19:04:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:04:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Lu, Aaron" <aaron.lu@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
Subject: Re: [PATCH bpf-next v2 5/5] x86: use register_text_tail_vm
Thread-Topic: [PATCH bpf-next v2 5/5] x86: use register_text_tail_vm
Thread-Index: AQHY8vpB5ncG2TwEA0WkYnZuK4LEMK41Y9kA
Date:   Tue, 8 Nov 2022 19:04:18 +0000
Message-ID: <572a1977126b54f50eb69b7b2f826e271bfd42c7.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <20221107223921.3451913-6-song@kernel.org>
In-Reply-To: <20221107223921.3451913-6-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|CO6PR11MB5571:EE_
x-ms-office365-filtering-correlation-id: daa43af4-a656-4ace-735f-08dac1bc09c8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHRT1tp7Wuy2RdCzwsUg4XPl4VKgB3NswirE7+fNyHNEnPs4jdytxVncL96fI1+DC7PR8pYjyW2c20FRUGa9uyNFRXu763liQK0KJmpSnj2pS2J7XIkdj794OVbl870lr2+bkK3G87nnRzbemwjCd5DeOUnuJma2/1YT/qQNgC1RX3EffYT6dTAElPDvWXTmeIZusdB9m+nSI2sr8mv+U+0DflNVE6tt3Sh43vmXa/Vp5mKe5zXNRQ6EHwltI92/4xbTqs+gFCgPY/UExBqFVPWpYf4XvWfeEku67u2NfwZoX40uQAfato7j5QAF2glFFXEo+BAdccS1x9U0CF66BdjHo1Y7Zdy2b+z73EqIYgBbFj95x8LVdA6R+xe6d3uBGPjz1jvmk9gTmxowDuiMv+ASrnlgMnJD0jy33EXATX1PNmW4Q8F4puk7RBZFIGKgUB+TVXVxCVFGf/RtzJx7juovoolZPSiHfj6lv7s6H3AlRHNvTVyHvnhTf6PpV9tgpDxf07609xVu/B7ZSOMPUIyHLEEeTZiGmE+FTjMWZ7RQalnQLGMcly0diJzyJB3AKfCeLN4xuVpUi5qSq5oJJsSvqfqU646f8c54N7qwtu3vF/eYu/nTUbbTm3NPnfJBVZwN6lmncj08aj6btENi27rb1uQyR/3R+DRGw5hi5OghMil8cBD/Rr0VfMLEEqEqbUtzji4g5o+pO6zxLX0AH2o7I8eu84vEBO45Ms+w0UlYi9IDeKtqpNZ/Cw1Pubg2Tk9h7J71Q9f8yKxIkggsV+KS4yNbbcDMwsb9wV4aY04=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(396003)(366004)(39860400002)(346002)(451199015)(5660300002)(83380400001)(8936002)(186003)(2616005)(41300700001)(38100700002)(122000001)(82960400001)(6506007)(76116006)(2906002)(86362001)(110136005)(54906003)(26005)(6512007)(71200400001)(66556008)(38070700005)(66946007)(66476007)(8676002)(4326008)(64756008)(66446008)(316002)(36756003)(6486002)(478600001)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZHemtKUnZRdnE2UUo1cmVpSE8zRWZ6bnRvUngwUUxvTXhLQlA3TEZpSWFT?=
 =?utf-8?B?azBQc2VRT3FIT0RwaGZ2STZHWjFNSGhpbTAwMG9rUWwwRWZFVnpZWHJQMk0x?=
 =?utf-8?B?UllQU0RXaW9SVFZoSnVtL0JrUFNGbGExQ3FXMUUveHhMY1JxOTRSa3YxUmNG?=
 =?utf-8?B?YURTWmM0dzd2eXJORTJzWWVmNVg1M1NxVUJBdDhyNjM1a1drdDhvOWF5K1lF?=
 =?utf-8?B?ZklLckQyTjJrWExFc0hrSzZaV2pibFozamNqT2c4cmkremE0R0U5ZzhhL2hC?=
 =?utf-8?B?eFQ4T1BYbkgzdlRpT2o2cXFpWWQ4WHFvKy84NDhPSUJtSHFSM0VxdFRQSzFY?=
 =?utf-8?B?czdyYnBWTjZzdi81NUxNT0MrcVVTMW93R01DZFlSb2twVks4R0xhdTRJd1Q2?=
 =?utf-8?B?N2g3cG9FaisvU0ZNbWhVUWhaM0E0MFA5RGJjYTM0Z2tReUJNV1MrSy9QS29n?=
 =?utf-8?B?bTIvZGNaUXZDcjNWdm95RTJ3dm5EdU43OVRjYUdMREVzbkptaFVrdzhQd1RL?=
 =?utf-8?B?RlAyeUhIQmxsT1UvbUVJMmhVSGpQOGxtS3dncDRLRVRRYktHTjBpVjVGWm45?=
 =?utf-8?B?d2J4ZVRLM1l1TzdjQW5vYmJpdDhuZnF2RW1LbzNxbFhOMWNSNU9aNm1pQXZR?=
 =?utf-8?B?eGpqUXljSnFMOGNVN1JudHB1WG81dnlZb0JLM1pmZTQ1MStNSDZESVVGMGM2?=
 =?utf-8?B?OW5zc1dGZGNmTzhjMlRzcy9MNFR1YkJSWCswbG9waHRzUVJhQVlZK2g3Nm1k?=
 =?utf-8?B?RFY2UlVPS3h4Z0lhZlFUOTJrU0ppREUvUFFtelNjcFN4OStDaWY2K00vRThG?=
 =?utf-8?B?dWVCR21mcDJ3aWp5T1REQ3B0dHlGTktSY3ZBR3MxamMwdXdkcjFsNkpjUko2?=
 =?utf-8?B?ZnZjbGxSOVEvaHRQeWlOUk55bmxwS2IyWGlSK3R0R2ZkQU1iYkV1cFNsVndP?=
 =?utf-8?B?a3VRYXE3RkxnMkZYdUNoYXZEOTdOUUtNclppSWZOM0hPbkhpVkx2N1RQbmc4?=
 =?utf-8?B?Nm9XUFpZUWxoZmVZUkh2cjRtRmFNdTUvdmdlTWlnc1dCVVZ6VUFpSEpUNEdL?=
 =?utf-8?B?Zk1jN2k1enRRdmF4dyttRWpBZ1ZXWERpSGxLa01ydzdheUhFOFQrSWsvZzdG?=
 =?utf-8?B?Y1hEaVN1NW9zUjdENE5SWk9OQ1VHa3Z4enRWNnZXdEwzU2VVNHVIN2c3bk9w?=
 =?utf-8?B?VnI0bTNscXNhTUE4MnZ6YlZCVzNjSFlnZWdrdWtEZGZNamhhN0RSOUoza1Zy?=
 =?utf-8?B?NmtxV25BTUtRNGExQXlWQThVT2lvWjFkSHdVZmgvLzkwVngvUXhLNlJlWlBW?=
 =?utf-8?B?cm1IR0drems0V002cUtKeUJJQklIVFdwbkp0R1JDWFUweWNGZ2c0bGk2NHds?=
 =?utf-8?B?U1Z6dmFJNnIyYzhlSGRSWjNsSDVCVjRtRU1EblllZmRqZmhkTWJyQXV1K2Za?=
 =?utf-8?B?bld4S3NEYlBsanlyU01PRXNnK3hrb2FFbCtUcUNkZDFtY25hM05PSUQ5ckJa?=
 =?utf-8?B?UXRRYXB0VDFJcktxQWRZMmIwRDRreUxEeVBYMHVFazQ4dnFNeGV0NWo3dDlm?=
 =?utf-8?B?TzZDS1pSNnpoM0s2QmZQZGp4dlVGVmpXVlBGbkg0eW1NQWJ0K29iUy8vVjBp?=
 =?utf-8?B?WjlWVnN1UmJ1MWZtZi9PUHA2enVWbWhaWlVTWGNiNFcxUzFxMHVobmo3Uzh0?=
 =?utf-8?B?WFB6djRhMURPaUdQN0lKbWxNNkU4WDhyZjV1YjN4eEJMWXRGNzU0OHJ2UklG?=
 =?utf-8?B?b0ovK09JdWVBQ0ZjTUw4cU5JWHpLM1hYNVpsM2d1Q0VQVGF2cFFFdmg0QjU4?=
 =?utf-8?B?blJyTW5aNDQzWndIbHVRV2xrMENTM21SeHUrRWNKd3dXVmttb0tzMjZuc0NZ?=
 =?utf-8?B?Zm1SRGhIWXZtOWorYmg0OE1tTmdBSDhZSi9la09yZVBxQnRDSlRDdWpWbzFJ?=
 =?utf-8?B?VXlRZkw4Wll3OWc0R2gyK2l4SW5vNkZtTlB5Rk45aTRCZndmRUhhdEJYbDRa?=
 =?utf-8?B?VTdNdmZXSTRyU0FHMDZsSVdyY00ra3FTZW5tbXp1OGxtUlNmbFMyS3pVK1dR?=
 =?utf-8?B?bG0vbHA0Q296QW5sZ2k1dFZ3SlZHakJUTldTbWhMZkJGdWNiVVZQdFQ3YUI4?=
 =?utf-8?B?ZEE0OXFLaFF4d25nQUZnOFZVdzVYWUxTT1NhKytHcWI0MjdqNFBkLzkzWGRv?=
 =?utf-8?Q?axBgrA4kzTERSMhlTz0QKLg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB5D528008F5C14FB5B79D69036283F4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa43af4-a656-4ace-735f-08dac1bc09c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 19:04:18.8021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rxSTa+Pp1rg3FWkUNpj2uighIjc4bVqcChlMw/hDb7SqGtzf7U04p607irQE/YG2qAlbl96pbdLyMoRT8OC8mypXnr0coARBVvf2D46tb0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5571
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE0OjM5IC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4gQWxs
b2NhdGUgMk1CIHBhZ2VzIHVwIHRvIHJvdW5kX3VwKF9ldGV4dCwgMk1CKSwgYW5kIHJlZ2lzdGVy
IG1lbW9yeQ0KPiBbcm91bmRfdXAoX2V0ZXh0LCA0a2IpLCByb3VuZF91cChfZXRleHQsIDJNQild
IHdpdGgNCj4gcmVnaXN0ZXJfdGV4dF90YWlsX3ZtDQo+IHNvIHRoYXQgd2UgY2FuIHVzZSB0aGlz
IHBhcnQgb2YgbWVtb3J5IGZvciBkeW5hbWljIGtlcm5lbCB0ZXh0IChCUEYNCj4gcHJvZ3JhbXMs
IGV0Yy4pLg0KPiANCj4gSGVyZSBpcyBhbiBleGFtcGxlOg0KPiANCj4gW3Jvb3RAZXRoNTAtMSB+
XSMgZ3JlcCBfZXRleHQgL3Byb2Mva2FsbHN5bXMNCj4gZmZmZmZmZmY4MjIwMmEwOCBUIF9ldGV4
dA0KPiANCj4gW3Jvb3RAZXRoNTAtMSB+XSMgZ3JlcCBicGZfcHJvZ18gL3Byb2Mva2FsbHN5bXMg
IHwgdGFpbCAtbiAzDQo+IGZmZmZmZmZmODIyMGY5MjAgdA0KPiBicGZfcHJvZ19jYzYxYTUzNjRh
YzExZDkzX2hhbmRsZV9fc2NoZWRfd2FrZXVwICAgICAgIFticGZdDQo+IGZmZmZmZmZmODIyMGZh
MjggdA0KPiBicGZfcHJvZ19jYzYxYTUzNjRhYzExZDkzX2hhbmRsZV9fc2NoZWRfd2FrZXVwX25l
dyAgIFticGZdDQo+IGZmZmZmZmZmODIyMGZhZDQgdA0KPiBicGZfcHJvZ18zYmY3M2ZhMTZmNWUz
ZDkyX2hhbmRsZV9fc2NoZWRfc3dpdGNoICAgICAgIFticGZdDQo+IA0KPiBbcm9vdEBldGg1MC0x
IH5dIyAgZ3JlcCAweGZmZmZmZmZmODIyMDAwMDANCj4gL3N5cy9rZXJuZWwvZGVidWcvcGFnZV90
YWJsZXMva2VybmVsDQo+IDB4ZmZmZmZmZmY4MjIwMDAwMC0weGZmZmZmZmZmODI0MDAwMDAgICAg
IDJNICAgICBybyAgIFBTRSAgICAgICAgIHggDQo+IHBtZA0KPiANCj4gZmZmZmZmZmY4MjIwMDAw
MC1mZmZmZmZmZjgyNDAwMDAwIGlzIGEgMk1CIHBhZ2UsIHNlcnZpbmcga2VybmVsIHRleHQsDQo+
IGFuZA0KPiBicGYgcHJvZ3JhbXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29u
Z0BrZXJuZWwub3JnPg0KDQpQbGVhc2UgdXBkYXRlIERvY3VtZW50YXRpb24veDg2L3g4Nl82NC9t
bS50eHQgYW5kIHRlYWNoIHBsYWNlcyB0aGF0DQpjaGVjayBpZiBhbiBhZGRyZXNzIGlzIHRleHQg
YWJvdXQgaXQuDQo=
