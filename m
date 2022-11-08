Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9AD6219CC
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 17:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbiKHQvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 11:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbiKHQvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 11:51:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221CF58BE0
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 08:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667926279; x=1699462279;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LKNI3KQ7o8dRGtP5mg3C30709hcqI27piggqvq+ZVDQ=;
  b=fc5mhNXcH6n5DFZmGkiNiu/0WDk/t/fZ+UKpLQHn0qGs1lFljawFlYp2
   9NKWzL4GEs/PIUJ55yrQtKDPIPvS/F3ory+PeJKl5umV5x+CabBxuajt0
   LqhTaKQjTbz+MEZtb3QAhnhMNNWSiw+U+fEVWayyPkYQpqml64EGrHjmS
   TwGkfgWgE7AiIN6pFl9W5kw/KLMvcm8msIEBR3jzEIvUxiRAhA7yOj+x5
   Hsg6vvwQifyAOJLoF7Dyo4R9YuIDLYghwG41splnLsJk5zlg0AWd1yXNK
   fW49x1QH9xIhhVbQUOVIky655pmDjpx95enaA5FgxLXXL/itSfgdPsHuV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="298264336"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="298264336"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 08:51:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="725623406"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="725623406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Nov 2022 08:51:17 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 08:51:16 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 08:51:16 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 08:51:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvjfmNZMk7c+h4tIxmEHWUNH6TLghjx9cnmkuaQbZvJP5PuhWqJa18zf0x+uuiPEZMkpvbgbduf9pRoNh9+xfJl00RsGj2N5Q1lDHuA6va2Aou7s9pnWaEseioFlY/EANd/c4lNrZTiGgoqRrLAGxVIT2d5jUblE87anOfhomBnhd/kDETRIUNGzf/eDn6FvCTdDfyrYNt/ikUNIDFXcFo/PtLq1ndztV2DayZfOHNZbr6OjWy/ezUR7g887qxRRwewQ6UkvP2kZq+rt1jkY2jb8HzoICi9TkTvjzo2AVi300gpQoPTm0N0yBz1ndfip6pG5ustx00X8n5Oriy6jcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKNI3KQ7o8dRGtP5mg3C30709hcqI27piggqvq+ZVDQ=;
 b=i5jCqe4aw3Q+/tzneskgRDc+SUZpkLaARQJa2ub+vDfd9z4RHBs6RqaJ1UD382NtetkLLgdlDcrkZvUv2oyz3CWBFI01NjrVJkYa5uKZEXLM2rtxdwXUZlCOqf5GbgTvH/ZsyXrKDGNoZ2BhN3nbP1FuWWhMXa8CW9LPW5E814wHaYVXvdJD33M56HhBwHCM21SQF8e8W5iuMTdPTcNNgal8DuqO8X8YirOGpvOKX/06Z4T7brdgWgPKluaiWUSOm4oegcezUjGwHZt0CEetFjqLnlvQGZcqh+5/vRRTZxaAlBXCjJESnTWdwgPUQukANVT0QJ7PykRICnwJTi6PLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by IA0PR11MB7356.namprd11.prod.outlook.com (2603:10b6:208:432::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.24; Tue, 8 Nov
 2022 16:51:13 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 16:51:12 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC6405DmAgABab4A=
Date:   Tue, 8 Nov 2022 16:51:12 +0000
Message-ID: <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <Y2o9Iz30A3Nruqs4@kernel.org>
In-Reply-To: <Y2o9Iz30A3Nruqs4@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|IA0PR11MB7356:EE_
x-ms-office365-filtering-correlation-id: 2f02b670-42e8-4afc-ab68-08dac1a9717e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uRGnoT6No1yZU720YrN5penwdpQsBrMfkz1T3YPXEntXGmEGcq3SIml/xw8ywT7rzugAVtCo2UdtentbNRmUHtafYgQJIcGliAXbozAM2hrHMkAN7vVHKNjVKG2psrIxDVtTd4BsKzIX3FMgl7ChXHDiOWbNuFGmzQlftR6NY0265ZpkJrZfyB7yct9+mCCM5RRlQYTyp4DAEQOijW8qTmDFIbNie8qA8Dcw/gM1ToZMrJdywKaZlWtDVonwocy8Qx2NCCToi7lgHfRQRqNpzFpFTr4FBdB1uap8dfD5mbcr+bOfrB1UKqbaRG02APL7RenbSWYnz9lEZ9HHbHB3llBv7DijWfcVTLSkIq2HnR4rf3n8NYLkmkInVnXMaLlGgNcaJw6Ij9E0Qc5g4iTn21Z+nWUik+CPggm19rpNqSDz7kmQ/XX9rORnLPWJHomY2R/W2raeWXwRGQ9k8XxgUtwZpnbxTPTZSG3xMnxGPCzWP6cAoMMjVMJ1q5qprdIZ0hZ2eMvYPOpCR9+p4YFzUw1g88HKLNl1DL6Lfrkzs5zeMEOT3p0sBJBb7tD5l7hRV67AX6wIJ4j5YWNKVUoGIzUqU87YoL5X5fvNeD9Z0HDILiS+hkB/Vodw1HoUY0nUk22swaVMUmmg0+iDKfEp41tfJzdtCNSHQqggZckkopdG2FXjs3bh6vsNdLYqCakbZmFZYOV/JECBhiScm31/FtCqGICnlQtAKrMWp10VTI94FEkSYDf9+IIbt/QrAkWQcHF22/D7jB38914aGnGSdF0xwz0eI64tlFdZ1B9XH2o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199015)(26005)(107886003)(86362001)(36756003)(6512007)(186003)(110136005)(76116006)(82960400001)(2906002)(5660300002)(316002)(2616005)(122000001)(38100700002)(66946007)(8936002)(66556008)(54906003)(66476007)(38070700005)(41300700001)(8676002)(4326008)(64756008)(6506007)(478600001)(6486002)(71200400001)(66446008)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjRXN1hvRjlVM0V1WGxnV1Z5ZVhqTFF6SXBmNk5IT2RyaTVuOU10MVRiY0dN?=
 =?utf-8?B?aExFRWI5K0ZSTGd4TlF6MzNhNGcrOFRlZzBPWm9JTFFvVTlhL3dMcUVIQjV0?=
 =?utf-8?B?S21LK3VqL0NhdXFybk0wWTFmNkZnbjFtbzVVbk5rMXpTUUlqN0pxVnFROEcw?=
 =?utf-8?B?NlMvdmpYcHp6bVNRblYrM0QrWkNkNEJlRUhUQnVtREV6UFIxSGVsRGNRRnRM?=
 =?utf-8?B?eHlnTjY3WEtkUlhOL1U0djRjckdkYU5EZHhWR0NtdjlQRE9YSGJjVS9ObGF4?=
 =?utf-8?B?czFjV3FZZ29tUlR2cWFBdjBIUnhFenhCZ29nRDJFZFhQNUNCaUg5aXM3RU1P?=
 =?utf-8?B?WTNtaTFJS0hmMk5pbk4wcE9vakJQWmE1anUrazV4K2Z3Q0tsaHZiR3U4enk4?=
 =?utf-8?B?RnROcUhHVzE0Z1VHL3VlQkZUUExKSnZuM2dZczZKVVBvUjBrWnJKWFh3QkVF?=
 =?utf-8?B?bmxBMytCVENFUEtjSEZUbEJPSWxKYlB3WWlUdytVeE11Zk84UFpXM1MxSmo3?=
 =?utf-8?B?NEVUanBwRnhJVkFJSzVvcWUxQ0dVckpOQUprWXNvWnlxS2tSeFBzb2dZK2dv?=
 =?utf-8?B?bWxKUHdNeHJiU1AyazBORFdWdVgweUQ3OE5BcTRxTmVnUXBpWXhyWU1nTXFn?=
 =?utf-8?B?WGdRdVBDckVqZzhic25PRFVOZmtHWnJ1bVNxZlJCajNscURwZHRJYWtDcWhz?=
 =?utf-8?B?L3p3ZVRTcFBURXhsRXZ3NGNTVEdIVjVkRHhsaTJPbmltUHh0N2JmMnllUFM5?=
 =?utf-8?B?dVVtOEhINmJ1TG9vdWFaRDJ1WlZXVzlHS0RWNUtxOHp3QVpXUkZUQzJRUGd6?=
 =?utf-8?B?ZzU4SXJzNzJuL0w4RmZXOTFuMEE0QTJsandmU01OaGdQT2k4YTk4QURhV0R4?=
 =?utf-8?B?bXZUNVg4VTZYc05MK1Y1ekRCYmJtYXJLeTRqL0FZVlFiNGlXTTlFRHFVV2FB?=
 =?utf-8?B?Y1FPbWdSZWNMaDIwdDk0clJQc3Q2cE53Y2R4NWt0L2NpWGFVRG1uVk1wN1dM?=
 =?utf-8?B?U1oxN083WWNQNERBZ2I0M0ZpSWp6aWtxZGduZmQxS1VqTUJtTWJyWkVPVk8z?=
 =?utf-8?B?d2pGUDZQSEZ5MEZvclFubWw4SlFnZkYrMHVkMVdOSEc3L1g0NXFteE9oTmF1?=
 =?utf-8?B?UExkaHk5OHlnWGR2Q2Jla0d3M29FeEQrcDJFKzVKTTBnYk1FeDJyVzlGRVFa?=
 =?utf-8?B?K2FIcGdxMjhnSElFdVZlSDRqZUJ2T1kreHpSd1p4MnJBYTRFaTlNN0EzUjVt?=
 =?utf-8?B?M3BPNDdVdElpV3RFVVJhMEk0amcraEZ2VS95ZFB0Tm5kS3hyZ0haWW9reGlS?=
 =?utf-8?B?RENFMzhIWnVSdXM0ZkUvMGlUSkVveEtpOW55bXRpRDYwdFpOVVNSNXFpU3Vw?=
 =?utf-8?B?aFU5Qy9KMVBmM2hyWVJLczZTUkwyTE1mUmFhK0dSc1hMZUtWSXZNTlJOZHpo?=
 =?utf-8?B?VVBqbkJzd2tNYWgwbi91QXllUXEvczU0ODdySUVrTSs3Y3R0VExZUWRVL1V2?=
 =?utf-8?B?L1g3Q3RBcHpjalI2MXh5Z3RYSC9DdWNEbE9NYU92OFdDem8yU2RTbXlYZysy?=
 =?utf-8?B?bVZmRlVSK2NlYVBxMSs0QzRkRitXOGpMc1Z1YzYxOGNZdlJSTG43R1M4Vmhq?=
 =?utf-8?B?eVZvNERNUGI1OG85a2NBT0FZeTJHVzcva2YzaXNHY2Fndy9PcTNTZ0lycklP?=
 =?utf-8?B?Y2VtVXV6aExQdkFGc1l1YmJQbEhIbkx1NjlWSGpjRU1BK09BSnFGWDMzYkdL?=
 =?utf-8?B?RjIwVS81Z3lYVUdzR0pQV1NaUEwwZlZGZDFzL2xUZnVHRlJUSUxKTm9NWFYx?=
 =?utf-8?B?U1NGVHR6SnIydFRWSUZocmlTUm5WTXo2M1ZrZWx5TlJYc2N3OTQ0UUgrd0dq?=
 =?utf-8?B?V3pyTHpMSFUyVkF0MzRPMzVaTDArODBmZzB4MldqWGV4YUQ2eStUUGRZMDJ2?=
 =?utf-8?B?Y0hnZWMvdlJwS0hyMkY1b00vRlFvckYxcTgrK29Uemp6QjVHaG50QmNNK2ZG?=
 =?utf-8?B?Q2ZlUzNjOHQzWE9PeHlMVDNTdDIyVzBDc3I3bjYydEF5RU1MOU5QRjRRSDNo?=
 =?utf-8?B?WFhPTjJlMlU5eFgrc2RVSmFBVDJKSCtwL1Rtc1E2bXc4dElZams5WjNkQWZ3?=
 =?utf-8?B?ZWpEVjQ5WE0yTlVjOHZScGpNb2Q1ODhCT2E0NlpWOFA2WXBvSFpIWEJ6eU9O?=
 =?utf-8?Q?0HCp0UmBgSnDI1Cmw0FkRmQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DF9F4EDC36FB624585AA151AB6D450FF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f02b670-42e8-4afc-ab68-08dac1a9717e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 16:51:12.3794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ez9jfqJq9HPnM1peim6SGR2KRWhh1Jco4BHGFm6uLzhYgHvkMZIIwBYVFcpkPPJXRTADkcqm4S+hJRuDuUcqMN6OnTR142ESJEBFqrYfI8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7356
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDEzOjI3ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiA+IEJhc2VkIG9uIG91ciBleHBlcmltZW50cyBbNV0sIHdlIG1lYXN1cmVkIDAuNSUgcGVyZm9y
bWFuY2UNCj4gPiBpbXByb3ZlbWVudA0KPiA+IGZyb20gYnBmX3Byb2dfcGFjay4gVGhpcyBwYXRj
aHNldCBmdXJ0aGVyIGJvb3N0cyB0aGUgaW1wcm92ZW1lbnQgdG8NCj4gPiAwLjclLg0KPiA+IFRo
ZSBkaWZmZXJlbmNlIGlzIGJlY2F1c2UgYnBmX3Byb2dfcGFjayB1c2VzIDUxMnggNGtCIHBhZ2Vz
IGluc3RlYWQNCj4gPiBvZg0KPiA+IDF4IDJNQiBwYWdlLCBicGZfcHJvZ19wYWNrIGFzLWlzIGRv
ZXNuJ3QgcmVzb2x2ZSAjMiBhYm92ZS4NCj4gPiANCj4gPiBUaGlzIHBhdGNoc2V0IHJlcGxhY2Vz
IGJwZl9wcm9nX3BhY2sgd2l0aCBhIGJldHRlciBBUEkgYW5kIG1ha2VzIGl0DQo+ID4gYXZhaWxh
YmxlIGZvciBvdGhlciBkeW5hbWljIGtlcm5lbCB0ZXh0LCBzdWNoIGFzIG1vZHVsZXMsIGZ0cmFj
ZSwNCj4gPiBrcHJvYmUuDQo+IA0KPiAgDQo+IFRoZSBwcm9wb3NlZCBleGVjbWVtX2FsbG9jKCkg
bG9va3MgdG8gbWUgdmVyeSBtdWNoIHRhaWxvcmVkIGZvciB4ODYNCj4gdG8gYmUNCj4gdXNlZCBh
cyBhIHJlcGxhY2VtZW50IGZvciBtb2R1bGVfYWxsb2MoKS4gU29tZSBhcmNoaXRlY3R1cmVzIGhh
dmUNCj4gbW9kdWxlX2FsbG9jKCkgdGhhdCBpcyBxdWl0ZSBkaWZmZXJlbnQgZnJvbSB0aGUgZGVm
YXVsdCBvciB4ODYNCj4gdmVyc2lvbiwgc28NCj4gSSdkIGV4cGVjdCBhdCBsZWFzdCBzb21lIGV4
cGxhbmF0aW9uIGhvdyBtb2R1bGVzIGV0YyBjYW4gdXNlIGV4ZWNtZW1fDQo+IEFQSXMNCj4gd2l0
aG91dCBicmVha2luZyAheDg2IGFyY2hpdGVjdHVyZXMuDQoNCkkgdGhpbmsgdGhpcyBpcyBmYWly
LCBidXQgSSB0aGluayB3ZSBzaG91bGQgYXNrIGFzayBvdXJzZWx2ZXMgLSBob3cNCm11Y2ggc2hv
dWxkIHdlIGRvIGluIG9uZSBzdGVwPw0KDQpGb3Igbm9uLXRleHRfcG9rZSgpIGFyY2hpdGVjdHVy
ZXMsIHRoZSB3YXkgeW91IGNhbiBtYWtlIGl0IHdvcmsgaXMgaGF2ZQ0KdGhlIEFQSSBsb29rIGxp
a2U6DQpleGVjbWVtX2FsbG9jKCkgIDwtIERvZXMgdGhlIGFsbG9jYXRpb24sIGJ1dCBuZWNlc3Nh
cmlseSB1c2FibGUgeWV0DQpleGVjbWVtX3dyaXRlKCkgIDwtIExvYWRzIHRoZSBtYXBwaW5nLCBk
b2Vzbid0IHdvcmsgYWZ0ZXIgZmluaXNoKCkNCmV4ZWNtZW1fZmluaXNoKCkgPC0gTWFrZXMgdGhl
IG1hcHBpbmcgbGl2ZSAobG9hZGVkLCBleGVjdXRhYmxlLCByZWFkeSkNCg0KU28gZm9yIHRleHRf
cG9rZSgpOg0KZXhlY21lbV9hbGxvYygpICA8LSByZXNlcnZlcyB0aGUgbWFwcGluZw0KZXhlY21l
bV93cml0ZSgpICA8LSB0ZXh0X3Bva2VzKCkgdG8gdGhlIG1hcHBpbmcNCmV4ZWNtZW1fZmluaXNo
KCkgPC0gZG9lcyBub3RoaW5nDQoNCkFuZCBub24tdGV4dF9wb2tlKCk6DQpleGVjbWVtX2FsbG9j
KCkgIDwtIEFsbG9jYXRlcyBhIHJlZ3VsYXIgUlcgdm1hbGxvYyBhbGxvY2F0aW9uDQpleGVjbWVt
X3dyaXRlKCkgIDwtIFdyaXRlcyBub3JtYWxseSB0byBpdA0KZXhlY21lbV9maW5pc2goKSA8LSBk
b2VzIHNldF9tZW1vcnlfcm8oKS9zZXRfbWVtb3J5X3goKSBvbiBpdA0KDQpOb24tdGV4dF9wb2tl
KCkgb25seSBnZXRzIHRoZSBiZW5lZml0cyBvZiBjZW50cmFsaXplZCBsb2dpYywgYnV0IHRoZQ0K
aW50ZXJmYWNlIHdvcmtzIGZvciBib3RoLiBUaGlzIGlzIHByZXR0eSBtdWNoIHdoYXQgdGhlIHBl
cm1fYWxsb2MoKSBSRkMNCmRpZCB0byBtYWtlIGl0IHdvcmsgd2l0aCBvdGhlciBhcmNoJ3MgYW5k
IG1vZHVsZXMuIEJ1dCB0byBmaXQgd2l0aCB0aGUNCmV4aXN0aW5nIG1vZHVsZXMgY29kZSAod2hp
Y2ggaXMgYWN0dWFsbHkgc3ByZWFkIGFsbCBvdmVyKSBhbmQgYWxzbw0KaGFuZGxlIFJPIHNlY3Rp
b25zLCBpdCBhbHNvIG5lZWRlZCBzb21lIGFkZGl0aW9uYWwgYmVsbHMgYW5kIHdoaXN0bGVzLg0K
DQpTbyB0aGUgcXVlc3Rpb24gSSdtIHRyeWluZyB0byBhc2sgaXMsIGhvdyBtdWNoIHNob3VsZCB3
ZSB0YXJnZXQgZm9yIHRoZQ0KbmV4dCBzdGVwPyBJIGZpcnN0IHRob3VnaHQgdGhhdCB0aGlzIGZ1
bmN0aW9uYWxpdHkgd2FzIHNvIGludGVydHdpbmVkLA0KaXQgd291bGQgYmUgdG9vIGhhcmQgdG8g
ZG8gaXRlcmF0aXZlbHkuIFNvIGlmIHdlIHdhbnQgdG8gdHJ5DQppdGVyYXRpdmVseSwgSSdtIG9r
IGlmIGl0IGRvZXNuJ3Qgc29sdmUgZXZlcnl0aGluZy4NCg0KDQo=
