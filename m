Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C59252F7F4
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 05:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbiEUDUf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 23:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiEUDUe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 23:20:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B7B18542C;
        Fri, 20 May 2022 20:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653103233; x=1684639233;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ch8zVXikFub7njjaKtbHqypqpgQ3PIzWw0BSWKO/mKk=;
  b=eRyK/Z8jq6d+X1DZazda5UYmp83wAFoL/1vp96MLuRUpiSW49MFZcTK+
   8ZSI6FxIEFrnftJGkKftW7WjMGdVq3A1f+otaZWKbZ31Mz2PleZIv6OZf
   UQNPZrD24rGp80zDjHjeIi6KEqUUHo5Rt0Nohq6dgX5RfwFJ/37tEwywM
   GTjF7yMUcRp57ay/IhRtC2B4SpWMB5/X3k+8f7hUx0PIqtGvqALCl15bK
   Nb4xCMokTsi1xV+SWvC2SdsOv0uDcQkis+xjrvQWXCpQj1dl5WFT78l8Q
   0Ipd/abZOUlxmS0hyZUYQ/Pdi1OZ5mHIQcBVL635TFEdusEXgRyjlY6QJ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298111670"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="298111670"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 20:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="674908085"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2022 20:20:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 20:20:32 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 20 May 2022 20:20:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 20 May 2022 20:20:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 20 May 2022 20:20:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8pY5hFAq3IBNYE03M3FidBqq6mP0RNApf81+sdoM9vUrWbbx2CrdeZF38bqdFrN/AliFAOGjgx++OyoXjEznSjCHdzzTZJAQnUQssV9SOF3E0CAiCboFb5GbtHOmUKJ+ma9kUYTcKpSf5Bra2ACNo5cIefKCeqrWApznotKjnFchhGd+LWQTloyorItcw0kAHgNRVBPgG0Vo3LzmeuIOkIi3786hcJZyz2bZlKsCim3nhTxTeM6P09BovFRisZoU9G/1s9mcvXtD6JhNsr8up534A4B2uaY/04PXbGaSUNTUbTa/Y/PVoZ8miy8ZabZyQoGbAPujBSZzGNqe+Acrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ch8zVXikFub7njjaKtbHqypqpgQ3PIzWw0BSWKO/mKk=;
 b=PU+/LdVunLEAF0/xiw0eoePqhKrpcORjiFBMKJa69hXRavPALqKT/wFz0RFB49ZCEdZTakfCVd44OxcwNTK2yeLcacFtCX+AXGjS7c096tEbbWXlikEAyvS5nraaf66odAfHW5/S0ZZpB28iTNKhRvqGt1y/+b+DSuXWznKC07Beh7vSDQlR8lYvYpkXM/qUMdYkqcwq3CpVgrdLZRT65CFUiQeCq1cdYqlsEL1OIjbZkzCJ0H8YRV0fmNOnAOBED3KGhNa4idWu3Lffi76DVJHW6HRfo5m2W0daW5AoJrRRcG1cghsKaqIToFm9zbJ5mW3Vq7Wncq6ijo/pEghkbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3270.namprd11.prod.outlook.com (2603:10b6:a03:7e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Sat, 21 May
 2022 03:20:29 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5273.018; Sat, 21 May
 2022 03:20:29 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Topic: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYa/hbBI/pmQED80+tJ33DuaIVna0ohISAgAAm+wA=
Date:   Sat, 21 May 2022 03:20:28 +0000
Message-ID: <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com>
References: <20220520031548.338934-1-song@kernel.org>
         <20220520031548.338934-6-song@kernel.org>
         <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
In-Reply-To: <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc149590-2559-4739-98db-08da3ad8db26
x-ms-traffictypediagnostic: BYAPR11MB3270:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB32700469DB651E1CFB01EF53C9D29@BYAPR11MB3270.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: N2Rc7e3VU1p/Hokp8ui7urZaBkY3QfFHQJz7GTJOPUsJrg64zDk4k6l2zZDLmP5eQksc40SiOTD3WlfRTT6OrqinYHknD1uF12kV5kadllGygChiK1K0hj1m4IqGcoiHmdjvxRRbArfI1HUXald169FWDZBrLGUovksvtKGPPKSlMft8UyXNdqT3k1ay3EcZczg0E3V1N8wCDQLgoYbiTnKCKEb3aMwGuhyzin3RWsz4QETh7r4d1teR3m3gIb45ogoCs/VCMIWC9NFYRJtoNhpR9ILJiMZksMLF09ht5LKSWHV5tl+aF7tnQlcRAv7ds5a71/r6Z1NVYfgTSJ05tfGHFquMb3M0SngZeQUUsY9/+XFDM4Sz6Zse245aTQ/1sILJZTdk5xghQ+k1cJ3TiPkqHTSl8n5HJ0bCH9Pa8gvQ4KKHk18xKdOJuVdx2QZKjGMdOoOhQoA9AsFVOIeUffNKDYYVYJyCk1CHoZMx5IKtTBZG+jdLVoSQOyRNL31K8QbW5kXgRe1B18ZFIj9RfPEt2BF1k0N3nrL5W4uAWMYcHk2K/R/kIQ6ev1UpQ+kF9qzCQ+t+JXXZMGVARIKB9BKuYtIe8R8W3GAf4G2bwzvjbaoDTBSkGCBGoAK6XLC3iXPkr2JAGkZdEvw5qbAIAXeQpdZ363Py4jq+Jj8qWx0/wTBjmFllfrvSg2PERoQ+a2ZdKsOrozZ39tHXjYtZa1a3xY/Z5GPgy0c3nNW+Bh8YY+QJoYGKTAtFX8Mtdf57qXB0fhwYoxrkRhjKuhjBTn7XPxtQ6mCwiVxymQjXFxNmyWQfM1FtllGv3etlJnYcJJjSW6gJDJ86qovFGa5Ohw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(508600001)(54906003)(6506007)(38100700002)(110136005)(66946007)(26005)(7416002)(5660300002)(2616005)(2906002)(122000001)(64756008)(8676002)(4326008)(66446008)(66556008)(66476007)(966005)(6486002)(186003)(76116006)(86362001)(6512007)(82960400001)(38070700005)(316002)(8936002)(71200400001)(83380400001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aHNMdWxvTlNQSWp0dGlkeU5MU0JrLzA0dVR5TmZid1lQNTYvMjdHYWgzckxW?=
 =?utf-8?B?QVdGNndHL1Q4bUdjOWdhT2hpVDk1RVJtczhsUFlDMTNTUTByYjhVOUtvcmEv?=
 =?utf-8?B?elZ6L1NHb2luUG5qVVl2S1BmaVprTHFxb1BnZWpTbFpKUFB2YUdpSk91YzBp?=
 =?utf-8?B?MlcwY3BOdzdqeERkb0JndWNaWDRnMHo3M2ZRYVVsQTBpK01LR1BhM0lwTzlF?=
 =?utf-8?B?bWVpZ1h4T2QwSU9yTzFXQ2hMMFhNYjhjMU42OGZiOVJ2S3VaR0RZU2doN1V3?=
 =?utf-8?B?REkyT1NzSmhYdjRNam1WSnhDYnplQXhtUHFuVDhRWUxJYXpHaVRBVkt6ZnNv?=
 =?utf-8?B?SnNBNDBCUWJsSlVSM0ZzU21qV1BEbldoVXBpUnNnTTZYZmJSNGpOZ0NETzJp?=
 =?utf-8?B?aVNBNWd5UzV6YW1uRVJsRTRpMWdrcWRpUnR1akNjSktza2p1OTlsdlgvTUNh?=
 =?utf-8?B?UnlvSSt1RmxyZHY2NTVXVXEzaVp5MUJKWHpXL3hGM25IcEtvbGRpMHQ4UDlZ?=
 =?utf-8?B?UkVXU2xmWUNKbWZ5bkM5L0FTbFdMWHVidW5vZTlkN1B0NGcrWVlibVc1ekp5?=
 =?utf-8?B?Mm5KaXkvNVFKYTU0Z1dKSy92c2s4VFN3YWhtVW01OVF5MHNyelAwaFRHU0VP?=
 =?utf-8?B?aEVQR3JmK2lHK2dGR1JQSU9VOU1wTkhLaGx2VVJIMk9ueUhUWGFJUWx5V0Nt?=
 =?utf-8?B?WnptUEpTZ2lSbm0zeHZiSzVzN0d6eWw3T2NEMGRDbW4rOFJ5aGJlOXhXQ1B6?=
 =?utf-8?B?enYwcnExSThPZDB5c2FLQ2E2dFJJOTcxYVl0K3k3Z2NVT21PQjIrblV0VmtK?=
 =?utf-8?B?VXVzcTM2QnB6YmZGbFZHSmFCWldCQnVzU1QxUlFHWXREYU4zWU9lVlp2Qitt?=
 =?utf-8?B?eUtaZEgrQlRUS2d2R1M4L1A0VXlWd1RTZWJwMUg2cWpTamVScmtvVU16YjFJ?=
 =?utf-8?B?Mkl5OGYxV3ZPZGhiZHNwbEtIbnA2Q2RZenhSUVg0K2FCVzJkUlNzVERxamp4?=
 =?utf-8?B?ZHA0MXN2MkRrZ2FqTzkwR1NkZHlOWHE1Mi8xSXd2NisxNW1Rb0VQb09XazAw?=
 =?utf-8?B?WnNCMmNiUkc1c0RkbzdZV0VLK3JPQjBLU3BtNmFTU2pFNmE2UFlObUlhVFJU?=
 =?utf-8?B?TGJjNk5pSVpIRU13djl0T0VVYTlxTFVyclZCYXFsY2k3UnhwdUV6aUwrZ1VI?=
 =?utf-8?B?ZUNOVFdTTHJjUjBDN01wNU5sRzJIU0hGdVdJZ0RCY1lOQjZNcUM4TUNFQUhS?=
 =?utf-8?B?ejJ0MEx4NGlSYlNyWVNHTDlwdnBzZWs1ejZ2blNqRjN5YnhWYm9qVm5uUGJT?=
 =?utf-8?B?T1NnNEx6eWVuUmw1OWwxbUhDM1ovOHk4c01JUVVmUzFrYlhHWE9nUVV4VkI4?=
 =?utf-8?B?K08rVC9ubGpGM0lZRHdpR1dIM0dtMExDOVNnRkQvbW5nUFdNSGlBMWVJUDYw?=
 =?utf-8?B?R0xHRkk1d0lFdVM2WG56SlFZUDdvWkc2UHRobW5zMGYxd0lTd2xEZ1c2Z1Ax?=
 =?utf-8?B?MHVKS1hwUFlYRlJGTjVqOURSRG9IOTBoUlJUVnVaYlVUWExpdnNyYTIrZGs2?=
 =?utf-8?B?SmZYalY1VWNLREN1VHVNYjY3REl4ZGtqOEpGUUg4R3pvaDV3QlAycDR0TEJK?=
 =?utf-8?B?MEJRZndTNm8vRFFJak4xdDdWc01EVW5BTG5rbCsxUkFHMXZ4T3IvMTVVeklY?=
 =?utf-8?B?d05wQS81U0djQVVsc0lJSnV6bUNiU3NyTDAvQUc5RWxCL3FLSlJEalFMUHBy?=
 =?utf-8?B?T095eWplTWVxN1BnSGR1d3IvalQyYVd5ak5BQWhsTVgvRjlGRXg3S2N5dWVa?=
 =?utf-8?B?cTRDRFZxQjBtYkRUNEkzdnJKd2FGY2pLNTVjTHA0V1ZscFlCblJIRDAxbmZI?=
 =?utf-8?B?TUtrekhaaFRBaHF5NEtkWUU1V01oTUoreEJjcmJ3eGVjVHQrN1ZjVTh1WE80?=
 =?utf-8?B?NENEOG90alFjTFMwUGhYOFFJY1I0YkdlTjZXRUJ2UllpSUVXcmU4dDFybVEr?=
 =?utf-8?B?RlNWUDhqNkExK3VUSDNkbUN4SUlhOXJvL1dRRGZxcjgyQkhmSGErUTBtRlNW?=
 =?utf-8?B?LzJubjlZQTNUSlc0aDZETDIzeXB3OE1SR2hYbGV3Z1ZFaHdJS1FzTW9nVEhk?=
 =?utf-8?B?VFJQTFFhTW9ESjUzbWVENy9yUzBnZWg2SEZodFk4aDZHTmZmWStobzZYdmdR?=
 =?utf-8?B?dVhBcGpwa0tDMW13YzVkNHNickVaNUtwTHREUFoyWHZwTDV2OXRSdEh6aFVz?=
 =?utf-8?B?aHRneHdaR0RZVFV5U2pUSVlhTFp0RVZlK29Xa0dIL3M2YXg2SFFZZlpDRXgz?=
 =?utf-8?B?cXFXVXpHVVpaL3RkV3NmVWNaRm8yUUZGa1ZzMTJySVM0S0ZhYWhTdGFBUjNT?=
 =?utf-8?Q?Zr1NBON/AEBco1ygxJ0bLFIq4WPxegbM4MShv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBA695F7BE0C864BA8C3958D5963E1EA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc149590-2559-4739-98db-08da3ad8db26
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2022 03:20:28.9808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H8ou8Vk6osVOTSkWF+fxjjLEKOHQ7bOjJpofU/iF1FNPteV9osBLzoSkfnjI1y5w0IDg0nTfmHNcp8eEcfUneg3RVxxuUPfljL04KcLD898=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3270
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gRnJpLCAyMDIyLTA1LTIwIGF0IDE4OjAwIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBhbHRob3VnaCBWTV9GTFVTSF9SRVNFVF9QRVJNUyBpcyByYXRoZXIgbmV3IG15IGNvbmNl
cm4gaGVyZSBpcyB3ZSdyZQ0KPiBlc3NlbnRpYWxseSBlbmFibGluZyBzbG9wcHkgdXNlcnMgdG8g
Z3JvdyB3aXRob3V0IGFsc28gYWRkcmVzc2luZw0KPiB3aGF0IGlmIHdlIGhhdmUgdG8gdGFrZSB0
aGUgbGVhc2ggYmFjayB0byBzdXBwb3J0DQo+IFZNX0ZMVVNIX1JFU0VUX1BFUk1TDQo+IHByb3Bl
cmx5PyBJZiB0aGUgaGFjayB0byBzdXBwb3J0IHRoaXMgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBv
dGhlcg0KPiB0aGFuDQo+IHg4NiBpcyBhcyBzaW1wbGUgYXMgdGhlIG9uZSB5b3UgaW4gdm1fcmVt
b3ZlX21hcHBpbmdzKCkgdG9kYXk6DQo+IA0KPiAgICAgICAgIGlmIChmbHVzaF9yZXNldCAmJg0K
PiAhSVNfRU5BQkxFRChDT05GSUdfQVJDSF9IQVNfU0VUX0RJUkVDVF9NQVApKSB7DQo+ICAgICAg
ICAgICAgICAgICBzZXRfbWVtb3J5X254KGFkZHIsIGFyZWEtPm5yX3BhZ2VzKTsNCj4gICAgICAg
ICAgICAgICAgIHNldF9tZW1vcnlfcncoYWRkciwgYXJlYS0+bnJfcGFnZXMpOw0KPiAgICAgICAg
IH0NCj4gDQo+IHRoZW4gSSBzdXBwb3NlIHRoaXMgaXNuJ3QgYSBiaWcgZGVhbC4gSSdtIGp1c3Qg
Y29uY2VybmVkIGhlcmUgdGhpcw0KPiBiZWluZw0KPiBhIHNsaXBwZXJ5IHNsb3BlIG9mIHNsb3Bw
aW5lc3MgbGVhZGluZyB0byBzb21ldGhpbmcgd2hpY2ggd2Ugd2lsbA0KPiByZWdyZXQgbGF0ZXIu
DQo+IA0KPiBNeSBpbnR1dGlvbiB0ZWxscyBtZSB0aGlzIHNob3VsZG4ndCBiZSBhIGJpZyBpc3N1
ZSwgYnV0IEkganVzdCB3YW50DQo+IHRvDQo+IGNvbmZpcm0uDQoNClllYSwgSSBjb21tZW50ZWQg
dGhlIHNhbWUgY29uY2VybiBvbiB0aGUgbGFzdCB0aHJlYWQ6DQoNCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvODNhNjk5NzZjYjkzZTY5YzVhZDdhOTUxMWI1ZTU3YzQwMmVlZTE5ZC5jYW1l
bEBpbnRlbC5jb20vDQoNClNvbmcgc2FpZCBoZSBwbGFucyB0byBtYWtlIGtwcm9iZXMgYW5kIGZ0
cmFjZSB3b3JrIHdpdGggdGhpcyBuZXcNCmFsbG9jYXRvci4gSWYgdGhhdCBoYXBwZW5zIFZNX0ZM
VVNIX1JFU0VUX1BFUk1TIHdvdWxkIG9ubHkgaGF2ZSBvbmUNCnVzZXIgLSBtb2R1bGVzLiBDYXJl
IHRvIGNoaW1lIGluIHdpdGggeW91ciBwbGFucyBmb3IgbW9kdWxlcz8gSWYgdGhlcmUNCmFyZSBh
Y3R1YWwgbmVhciB0ZXJtIHBsYW5zIHRvIGtlZXAgd29ya2luZyBvbiB0aGlzLA0KVk1fRkxVU0hf
UkVTRVRfUEVSTVMgbWlnaHQgYmUgY2hhbmdlZCBhZ2FpbiBvciB0dXJuIGludG8gc29tZXRoaW5n
DQplbHNlLiBMaWtlIGlmIHdlIGFyZSBhYm91dCB0byByZS10aGluayBldmVyeXRoaW5nLCB0aGVu
IGl0IGRvZXNuJ3QNCm1hdHRlciBhcyBtdWNoIHRvIGZpeCB3aGF0IHdvdWxkIHRoZW4gYmUgb2xk
Lg0KDQpCZXNpZGVzIG5vdCBmaXhpbmcgVk1fRkxVU0hfUkVTRVRfUEVSTVMvaGliZXJuYXRlIHRo
b3VnaCwgSSB0aGluayB0aGlzDQphbGxvY2F0b3Igc3RpbGwgZmVlbHMgYSBsaXR0bGUgcm91Z2gu
IEZvciBleGFtcGxlIEkgZG9uJ3QgdGhpbmsgd2UNCmFjdHVhbGx5IGtub3cgaG93IG11Y2ggdGhl
IGh1Z2UgbWFwcGluZ3MgYXJlIGhlbHBpbmcuIEl0IGlzIGFsc28NCmFsbG9jYXRpbmcgbWVtb3J5
IGluIGEgYmlnIGNodW5rIGZyb20gYSBzaW5nbGUgbm9kZSBhbmQgcmV1c2luZyBpdCwNCndoZXJl
IGJlZm9yZSB3ZSB3ZXJlIGFsbG9jYXRpbmcgYmFzZWQgb24gbnVtYSBub2RlIGZvciBlYWNoIGpp
dC4gV291bGQNCnNvbWUgdXNlcidzIHN1ZmZlciBmcm9tIHRoYXQ/IE1heWJlIGl0J3Mgb2J2aW91
cyB0byBvdGhlcnMsIGJ1dCBJIHdvdWxkDQpoYXZlIGV4cGVjdGVkIHRvIHNlZSBtb3JlIGRpc2N1
c3Npb24gb2YgTU0gdGhpbmdzIGxpa2UgdGhhdC4NCg0KQnV0IEkgbGlrZSBnZW5lcmFsIGRpcmVj
dGlvbiBvZiBjYWNoaW5nIGFuZCB1c2luZyB0ZXh0X3Bva2UoKSB0byB3cml0ZQ0KdGhlIGppdHMg
YSBsb3QuIEhvd2V2ZXIgaXQgd29ya3MsIGl0IHNlZW1zIHRvIG1ha2UgYSBiaWcgaW1wYWN0IGlu
IGF0DQpsZWFzdCBzb21lIHdvcmtsb2Fkcy4NCg0KU28geWVhLCBzZWVtcyBzbG9wcHksIGJ1dCBw
cm9iYWJseSAoLi4uSSBndWVzcz8pIG1vcmUgZ29vZCBmb3IgdXNlcnMNCnRoZW4gc2xvcHB5IGZv
ciB1cy4NCg==
