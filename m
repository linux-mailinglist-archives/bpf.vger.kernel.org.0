Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0072939C477
	for <lists+bpf@lfdr.de>; Sat,  5 Jun 2021 02:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbhFEAeg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Jun 2021 20:34:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:58102 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229847AbhFEAeg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Jun 2021 20:34:36 -0400
IronPort-SDR: pUr2xSEeAlcmNpJwttKiT/dydBGRBVZTy+7gPxmTMsiSZkztTgN5XH8f5TDxTLgOKAkOkNY9+t
 ozlubkA3W/Rw==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="204422991"
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="204422991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 17:32:48 -0700
IronPort-SDR: xdBXLpLQ4dXRe/8HIMXNv2l0rKRpwfT3aGYTk313T/sMVPmOOufhSrRYrDkLs+0fVudMxN+to1
 7cSbNfOWw+/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,249,1616482800"; 
   d="scan'208";a="480829381"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga001.jf.intel.com with ESMTP; 04 Jun 2021 17:32:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 17:32:48 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 4 Jun 2021 17:32:47 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Fri, 4 Jun 2021 17:32:47 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Fri, 4 Jun 2021 17:32:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TjTZcyOD1F9m1ZPfVWC2+dz0oW6v7wyunguFqcQzE2x/nVK/QvZyDyojHN3QIg7LuQzwYrDOVX9mfJhDxtvdrFjHCyzf83tQZ2luJVMYgHDLtBMG1MMHTT5+pFbqRYoF58VmQ0XEzziSnMEf7O0klHOKqjEClMJl4hS+SPzs4eh/ElZcTQ4NrXjX/US2hAzWZov6wTQg6xy2uOW6+xFR8Ndp3pYppOe/fCKtM0SsfWys935KipeMmAyn09Kcy5B9ayN8g+ginbfZg0iUqpeHoWp5W9f/qLUBPabNAy86jxzvhvUlr1/4oCtU5cKQ1AuBQfAjheL1eJ+b8spzMQz7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgxA8d61GksfjRYuaOTI4R9FVSovBUlBN+xCUWEnnVE=;
 b=eL6NpWnMFiBP63iipJSZ3jj2eB1/1f9cJRI8nqzY45jhSJ+EGblWwCsBusAd2IPv3jp0LPRzcEboYBySG1xiifRIrdLqYOOv6YodZm8dm/6V3fZBnBUl0qTzw9OHPdXAUFOz865IzgI5tKAD+daX7TdlYfAx4U2CZ3XI+O19WBk/8/102ON63UIPDGGPMG4mvfWhR6fSsF9BUpDIFES+RKijB84Ru588XWCzXjT3ldVcCWd03b1ZcbknQaA895C7ImXP6EZjLBb/5/VEZ7tAVqYVALC1ETyQyDxJ90okvUzfTINwBEGa3Lc8y3nPTfoeP+CsA99G+LUhjq4uvN22fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgxA8d61GksfjRYuaOTI4R9FVSovBUlBN+xCUWEnnVE=;
 b=L3xW7/ZCA6C7Qpv8BiXfMrmKlPsv7FQxdsduL7ErcAoA2wgQS0mNFNtU9LIllHj3v20Jh0VY+ireWXNpdSK0J1NDnxuvRLSNVQ2vNgI3ZI35BNB7AFw2ooRI7muOCIVYm2UKSBk2EFqeHttRspPegTSONpGQlfgdbpTk3h3eQhw=
Received: from CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12)
 by CY4PR11MB1318.namprd11.prod.outlook.com (2603:10b6:903:27::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Sat, 5 Jun
 2021 00:32:45 +0000
Received: from CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::ec26:a3f8:92a8:bc8]) by CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::ec26:a3f8:92a8:bc8%8]) with mapi id 15.20.4195.023; Sat, 5 Jun 2021
 00:32:45 +0000
From:   "Desouza, Ederson" <ederson.desouza@intel.com>
To:     "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "brouer@redhat.com" <brouer@redhat.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Raczynski, Piotr" <piotr.raczynski@intel.com>,
        "Zhang, Jessica" <jessica.zhang@intel.com>,
        "Kubiak, Marcin" <marcin.kubiak@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Maloor, Kishen" <kishen.maloor@intel.com>,
        "Gomes, Vinicius" <vinicius.gomes@intel.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "Plantykow, Marta A" <marta.a.plantykow@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "Czapnik, Lukasz" <lukasz.czapnik@intel.com>,
        "Song, Yoong Siang" <yoong.siang.song@intel.com>
Subject: Re: AF_XDP metadata/hints
Thread-Topic: AF_XDP metadata/hints
Thread-Index: AQHXPjEbH46iigLME0O53NTVwSEbLKrXLbaAgAAEt/CAAAaWAIAAcYLAgAAn8KCAABRbAIAFBGqwgCfct4A=
Date:   Sat, 5 Jun 2021 00:32:45 +0000
Message-ID: <7ca8de6cd52b2aa5f76c447024e1a4906e61d2cd.camel@intel.com>
References: <dc2c38cdccfa5eca925cfc9d59b0674e208c9c9d.camel@intel.com>
         <2226aeaab7a4ca8e4f26413514bf54ab2c81ea36.camel@intel.com>
         <5c9fd8fbc29d4b21a3279f1122960413@intel.com>
         <DM6PR11MB2780A8C5410ECB3C9700EAB5CA579@DM6PR11MB2780.namprd11.prod.outlook.com>
         <PH0PR11MB487034313697F395BB5BA3C5E4579@PH0PR11MB4870.namprd11.prod.outlook.com>
         <DM4PR11MB5422733A87913EFF8904C17184579@DM4PR11MB5422.namprd11.prod.outlook.com>
         <20210507131034.5a62ce56@carbon>
         <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
In-Reply-To: <DM4PR11MB5422FE9618B3692D48FCE4EA84549@DM4PR11MB5422.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.1 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:6902:8a70:9eb6:d0ff:fed2:f387]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a537c4cf-8b48-4b01-272a-08d927b97036
x-ms-traffictypediagnostic: CY4PR11MB1318:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB131851CEB1E10E050988B0F9F63A9@CY4PR11MB1318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Orm+NB/+FzwX2oYQo9u8eXGGv8IIYPIlEz3eGIYSrR8oB048RIjfYdwrf9alQbzj+DJ0QS8VjMeczSJ98GrS7BxgqNLts6v5/nnapURvuItdXKrSlmGDv4N11+lRUFwoqC1CFzIjiX+l56eyYCW/WRxYZ2Rz8WZRRPsE45fYURyXUswl8Atq9R7Z9fOy2YFWCejsrVaZRjDLNjB4NMMKsEeKDXnGjdRtjDhbq6bgj28y6gO7aQezwOnJWkgzKMUzu++X4NznIiOb2D862e4nMBc8k9yJV4TvjnH7xfsfZ8Xoh7nmAQWqBUdmDV2+LnMFU2seGM5GgBR8s/5yx4o4tXfU8kI30D8yXxg4sTUQ/o+REWU+kjNFQ+KvC1m8bCjgMcfGRSjIosgaBGJPtzEN9c8805MedX5q49+rSrViM0MGG/w2F/fLsM75YVNfcftpbIcOMarw3XV/hKfR3ABuoZ7kdp3FJO0jPq8liIn0zvaX2uEz1P7/aUkYkzHVwAVQLQwdmUrL49L1BOiwE6qJew+O9jLvS4rUJr4XfEpD7SYuHy7VbWabyl1Yt7CNzs1oiPweXLah0NvHafh6wOJIYKfTVp52ceuv3Mop6PYojTRj35oHPaead2NAhk7UVtrjLcm8HLQALPx1GfYyA77HksxScQAURPNAEhukmKHm0OzF4xdvuXANfZSs+avSsjBe/SG7eu889drpNHEIdNAAKRfn6tPVxTmIaPWQ2ab1nOObEuc1dhTvrssHqrXgLGbs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(346002)(366004)(136003)(396003)(316002)(122000001)(38100700002)(8676002)(6512007)(186003)(53546011)(6506007)(5660300002)(2616005)(76116006)(91956017)(107886003)(66946007)(66476007)(66556008)(64756008)(66446008)(2906002)(71200400001)(45080400002)(478600001)(110136005)(54906003)(8936002)(6486002)(966005)(83380400001)(86362001)(36756003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Nm1tQ1NtMlhhVjQ4TVJPVml6Qm40ZXpraG5WbmFBTGpITmZYS3RNWnRqb1Vw?=
 =?utf-8?B?cFY3Mkw3NG5vNEFnUDdoZGNoekRFK1VlRkVjTGtGOWlXdFlLRDA0Yy8weUNy?=
 =?utf-8?B?QzYzN2F3dDM3RXg1T0hPNTZLRlo4a0RTczNVS3laVVJEcFhMTjNDSVVET1Z5?=
 =?utf-8?B?OW1pd3ZNUy8zYTFvOGE0REJtVDVrd2Y1MXZiU3FiNnlNN0ZWZHZnMy9iYkdD?=
 =?utf-8?B?MHMzTEtDVWNIWkRVdVZPMERHRGVhN3BGMEdvUnJoNFNIMFM2MGtGeGxwTXVh?=
 =?utf-8?B?b29WQ3VTaG1vakNxZ3BXY3d6WVZ3TXJYRXBIWVJpcXFyRm5nTDRrLzRzRWdt?=
 =?utf-8?B?aS9vOEZWZ1d6eFliYTlMSWROUnFxem02eHk5ZUNkMDZjaFJWZTVtL2VZNGx5?=
 =?utf-8?B?a1o5ZlhicUZ0QmxYbTlFMTN5dGkrVTBEVHlMa0VleXA3YUwzVEpPdjViQU9k?=
 =?utf-8?B?bWZ6bXBWMzdsZlp2a2hzVUZZa2pyWWswWXlnMVVDOTRFQXl4MytIb0c4YTdi?=
 =?utf-8?B?SytKeldNR3JDVURmR0h5bTJSd21RWjRFaFR2My9lSnJhMEhLakd4b0w2TVVt?=
 =?utf-8?B?ajdDU2ZHZWdRUDRMR0pOTlpCbGFuRjJwc0FBZktDaWx6UDNtZDZXYUdHaFdZ?=
 =?utf-8?B?c3ZVTUk3YVk2VEVJOUNiQ1Q4N0lubEs2dWFwYkhJNmJKc0hXa2ZhMFYrWDFN?=
 =?utf-8?B?ZXRFRFBENUh1enNzZGFvSlIzWk1qdWRCbG5nR01aWkxpYWNMTWk1Ty9UeFFa?=
 =?utf-8?B?aVNtWEVSbEUzK0IrUHRFOGZPM0xuUlFxY2NNdkVWNE03NDhaZ05GeUNUU1hS?=
 =?utf-8?B?MUoxVnlaUzJQTGw3VDRGcC8zS1dWSmlIdEpYTzYwSHNsNlJleUVJWWNCZ1Mv?=
 =?utf-8?B?eE9DTTZTYWQvR1M2aFdVMVplenNOT0dQdUpSMU14ZEgwM2pzRlJWVEpod1pw?=
 =?utf-8?B?WWZlZGVNN3lnSGdoWWV2ZXVoK1NWME5KUXJkeVZ0Q3pvMFBkMS9yTVA0MGs0?=
 =?utf-8?B?eCtDSDNDUE1KZWtoRC9FR2tYa2p6c294MjhzcFhKZ2lvTi81dnJ5VTdaZkpq?=
 =?utf-8?B?V2tRSmpCYzZMTjNpYnF1WVg5NlBNZ1g1VHV2V2xzY3lweHRNR2dsZ3JuNzhj?=
 =?utf-8?B?RFM2NHpxWEsxeTVJUEpFNDJnYXZVcE5hN1NhUWpmeCtNbE1sT25VaGhuN3NW?=
 =?utf-8?B?WWFjaENDaXhMY2VuYmhEei9jam1vNzZzZk1mNFdDQ0ErNzV2VlQ1Ui9wc1Q4?=
 =?utf-8?B?Qzhmd0ducTFLenl3aEREZThQb1cxU0IzUjN3a0k3MHpyN0lyZWkrVDN3SGxI?=
 =?utf-8?B?YTRXdGJSaG9tbGxoTndYNjVubjVvUzdOTzd1TDNhdlRUK2NYcUJoSjAzRDdn?=
 =?utf-8?B?ZnozcCtZVU5nTEV1NkRLY0U0Zmdxd3A5cS9CeWp3Q3BCTitjR0k4Z1pQdG5k?=
 =?utf-8?B?L1JxVHpNZDVjL2dYbHloWVpHTnVkK2pDN21HQjgzcE1wSE9iaWlCcTQ4cXc2?=
 =?utf-8?B?VVFMUW81S0VWL055TmVWdlF1V3JFS1h1MUdLUVRLNmxwckRwYlF3ZUlHYTdz?=
 =?utf-8?B?dUd4RnNlUHY4djRTMlNsazkyUkdBTUVDTmh0WUJHM1EvNU14ZWZzUFZLMFU0?=
 =?utf-8?B?Ykd6SmhWd2hvcjZaM3NnaHBMeEtKV3dFOVlpdUV6b3g4V0ZPVUl4RkovNjAw?=
 =?utf-8?B?Q01FbmRIejJ2UlFyUUNDdmgrMCtwaEhkc0dWcjZYR3BxNXVKcGFnYkpqM1M0?=
 =?utf-8?B?dkNlbDFNamRZUVU2cjlGeStrSVd4VDFhNW1CWDNaYUJndU5kbGtWYVduQkRF?=
 =?utf-8?B?ZlViUXJ1d0t5K2pVaHUrcU50cldBVUxJbVAxdHp5TC90WWF4aWtjTHp6YXVi?=
 =?utf-8?Q?REtcr6S/1/Sz1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6698EFE2AF701C4F91A26C2D53BC2230@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a537c4cf-8b48-4b01-272a-08d927b97036
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2021 00:32:45.3346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VY3jgNc3EesGK9CkPFIrF9qLk3xKLGtzdLtPhALBoE6j/2gqqDm18+K2eDfxTGPuD0S5NjhupzVT0nR8HZsu21eei27sGnC7p0X8B1uTsoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1318
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIxLTA1LTEwIGF0IDE1OjQ5ICswMDAwLCBMb2Jha2luLCBBbGV4YW5kciB3cm90
ZToNCj4gSGksDQo+IA0KPiBTbyBoZXJlIGl0IGlzOiBodHRwczovL2dpdGh1Yi5jb20vYWxvYmFr
aW4vbGludXgvYnJhbmNoZXMNCg0KUXVpY2sgcXVlc3Rpb246IGFyZSB5b3UgcGxhbm5pbmcgYW55
IHVwZGF0ZSBoZXJlIChsaWtlIGluY29ycG9yYXRpbmcNCnRoZSBDTy1SRSBmZWVkYmFjayk/IA0K
DQpJJ20gdGhpbmtpbmcgb2YgaWdjLCBhbmQgd29uZGVyaW5nIGlmIHlvdSBoYXZlIHNvbWV0aGlu
ZyBpbiB5b3VyDQpwaXBlbGluZSBhbHJlYWR5IHRoYXQgSSBjb3VsZCByZXVzZSBmb3Igc29tZSB0
ZXN0cyA9RA0KDQo+IA0KPiBEZWZhdWx0IGJyYW5jaCBpcyBqdXN0IG1lcmdlZCB3aXRoIHY1LjEz
LXJjMSB3aXRob3V0IGFueSB0ZXN0aW5nLCBkb24ndCBleHBlY3QgbXVjaCBmcm9tIGl0LiBJJ2xs
IGZpeCBpdCBhIGJpdCBsYXRlci4NCj4gDQo+IEFsDQo+IA0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBKZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNv
bT4gDQo+IFNlbnQ6IEZyaWRheSwgTWF5IDcsIDIwMjEgMToxMSBQTQ0KPiBUbzogTG9iYWtpbiwg
QWxleGFuZHIgPGFsZXhhbmRyLmxvYmFraW5AaW50ZWwuY29tPg0KPiBDYzogS3ViaWFrLCBNYXJj
aW4gPG1hcmNpbi5rdWJpYWtAaW50ZWwuY29tPjsgT25nLCBCb29uIExlb25nIDxib29uLmxlb25n
Lm9uZ0BpbnRlbC5jb20+OyBCcmFuZGVidXJnLCBKZXNzZSA8amVzc2UuYnJhbmRlYnVyZ0BpbnRl
bC5jb20+OyBEZXNvdXphLCBFZGVyc29uIDxlZGVyc29uLmRlc291emFAaW50ZWwuY29tPjsgU3dp
YXRrb3dza2ksIE1pY2hhbCA8bWljaGFsLnN3aWF0a293c2tpQGludGVsLmNvbT47IEdvbWVzLCBW
aW5pY2l1cyA8dmluaWNpdXMuZ29tZXNAaW50ZWwuY29tPjsgTWFsb29yLCBLaXNoZW4gPGtpc2hl
bi5tYWxvb3JAaW50ZWwuY29tPjsgWmhhbmcsIEplc3NpY2EgPGplc3NpY2EuemhhbmdAaW50ZWwu
Y29tPjsgSm9zZXBoLCBKaXRodSA8aml0aHUuam9zZXBoQGludGVsLmNvbT47IFBsYW50eWtvdywg
TWFydGEgQSA8bWFydGEuYS5wbGFudHlrb3dAaW50ZWwuY29tPjsgQ3phcG5paywgTHVrYXN6IDxs
dWthc3ouY3phcG5pa0BpbnRlbC5jb20+OyBSYWN6eW5za2ksIFBpb3RyIDxwaW90ci5yYWN6eW5z
a2lAaW50ZWwuY29tPjsgU29uZywgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwu
Y29tPjsgYnJvdWVyQHJlZGhhdC5jb20NCj4gU3ViamVjdDogUmU6IEFGX1hEUCBtZXRhZGF0YS9o
aW50cw0KPiANCj4gKEFuc3dlciBpbmxpbmVkIGJlbG93KQ0KPiANCj4gT24gRnJpLCA3IE1heSAy
MDIxIDEwOjA4OjUxICswMDAwDQo+ICJMb2Jha2luLCBBbGV4YW5kciIgPGFsZXhhbmRyLmxvYmFr
aW5AaW50ZWwuY29tPiB3cm90ZToNCj4gDQo+ID4gKyBKZXNwZXIuDQo+IA0KPiBUaGFua3MgZm9y
IGluY2x1ZGluZyBtZSEgIEp1c3Qgc2VlIG1lIGFzIGEgcmVzb3VyY2UgdGhhdCBjYW4gaGVscCBv
dXQgb24gdGhpcyBwcm9qZWN0LCBib3RoIGNvZGluZyBhbmQgKHBlcmZvcm1hbmNlKSB0ZXN0aW5n
LiAgSSBoYXZlIGEgY3VzdG9tZXIgdXNlLWNhc2UgcmVsYXRlZCB0byBMYXVuY2hUaW1lIG1vZGUg
dXNpbmcgQUZfWERQLCB3aGljaCBpcyBvbmUgb2YgdGhlIG1vcmUgdHJpY2t5IGNhc2VzIChkdWUg
dG8gWERQIGxhY2tpbmcgYSBwcm9wZXIgVFggbGF5ZXIsIHRoYXQgY2FuIHB1c2hiYWNrIGlmIFRY
LXF1ZXVlIGlzIGZ1bGwvcGF1c2VkKS4NCj4gDQo+IA0KPiA+IFNvIGxvbmcgc3Rvcnkgc2hvcnQ6
IGRyaXZlciBhZHZlcnRpc2VzIHRoZSBYRFAgaGludHMgaXQgc3VwcG9ydHMgKFJ4Og0KPiA+IFJT
UyBoYXNoLCBjc3VtIHN0YXR1cyBvciBjb21wbGV0ZSBjc3VtLCBDL1MtVkxBTiB0YWcgaWYgc3Ry
aXBwZWQgZXRjLiwgDQo+ID4gVHg6IGNzdW0gb2ZmbG9hZCBldGMuKSBvbiBuZXRkZXYgcHJvYmlu
ZyBzbyBCUEYgcHJvZyBjb3VsZCByZXF1ZXN0IGZvciANCj4gPiB0aGVtLg0KPiANCj4gWWVzIGV4
YWN0bHkgYW5kIHZldGggYW5kIGRldm1hcCBhbHNvIHdhbnQgdG8gY29uc3VtZSB0aGVzZSBlLmcu
IFJTUyBoYXNoICsgY3N1bSBzdGF0dXMgd2hlbiB0aGV5IGNyZWF0ZSBhbiBTS0IgYmFzZWQgb24g
YW4geGRwX2ZyYW1lLg0KPiANCj4gKE5vdGUgRGF2aWQgQWhlcm4gYW5kIEkgaGF2ZSBwYXRjaGVz
IHBsYWNpbmcgdGhlIGNzdW0gc3RhdHVzIGJpdHMgaW4geGRwX2ZyYW1lIHRvIHRyYW5zZmVyIHRo
YXQgaW5mbyAoeGRwX2ZyYW1lIGlzIGxvY2F0ZWQgaW4gbWVtb3J5IHRvcCkuDQo+IG5vdGUgcGVy
Zm9ybWFuY2UgYW5hbHlzaXMgaGVyZVsxXSkNCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS94ZHAt
cHJvamVjdC94ZHAtcHJvamVjdC9ibG9iL21hc3Rlci9hcmVhcy9jb3JlL3hkcF9mcmFtZTAxX2No
ZWNrc3VtLm9yZw0KPiANCj4gDQo+ID4gVGhlcmUncyBhIHBsYW4gdG8gcHJvdmlkZSAyIHR5cGVz
IG9mIGhpbnRzOiBnZW5lcmljIG9uZXMgKHRoYXQgYWxtb3N0IA0KPiA+IGV2ZXJ5IE5JQyBpcyBj
YXBhYmxlIHRvIHByb3ZpZGUpIGFuZCBjdXN0b20gb25lcyAodXAgdG8gDQo+ID4gdmVuZG9yL2Rl
dmVsb3BlcnMpLiBEcml2ZXJzIHRoYXQgZG9uJ3Qgd2FudCB0byBzdXBwb3J0IGhpbnRzIGF0IGFs
bCANCj4gPiBjb3VsZCBvcHQgb3V0IGZyb20gdGhlIGdlbmVyaWMgb25lcyBqdXN0IGJ5IHNldHRp
bmcgdGhlaXIgDQo+ID4geGRwLmRhdGFfbWV0YSB0byB4ZHAuZGF0YSArIDEsIGp1c3QgaG93IGl0
J3Mgbm93IGRvbmUgaW4gdGhlIG1haW5saW5lLg0KPiANCj4gSSBhZ3JlZSB0aGUgTklDIG5lZWQg
dG8gc3VwcG9ydCBkaWZmZXJlbnQgdHlwZXMuICBBbmQgZGlmZmVyZW50IHR5cGVzIHBlciBwYWNr
ZXQgYXMgZS5nLiBQVFAgdGltZXN0YW1wcyBtaWdodCBub3QgYmUgaW4gZXZlcnkgcGFja2V0Lg0K
PiANCj4gPiBYRFAgSGludHMgd2lsbCBiZSBvYnZpb3VzbHkgc3RvcmVkIGluIG1ldGFkYXRhLA0K
PiANCj4gSSBoYXZlIGNvbnNpZGVyZWRbMl0gc3RvcmluZyBYRFAgaGludHMgaW4geGRwX2ZyYW1l
IGFyZWEgKHRvcCBvZiBtZW1vcnkpLCBidXQgSSdtIG1vcmUgYW5kIG1vcmUgY29udmluY2VkIGlz
IHNob3VsZCBiZSBzdG9yZWQgaW4gbWV0YWRhdGEgYXJlYS4uLiBtb3N0bHkgYmVjYXVzZSB0aGlz
IHdpbGwgYWxsb3cgZnV0dXJlIGhhcmR3YXJlIHRvIHdyaXRlIHRoaXMgZGF0YSBmb3IgdXMuDQo+
IA0KPiBbMl0gaHR0cHM6Ly9wZW9wbGUubmV0ZmlsdGVyLm9yZy9oYXdrL3ByZXNlbnRhdGlvbnMv
S2VybmVsUmVjaXBlczIwMTkveGRwLW5ldHN0YWNrLWNvbmNlcnQucGRmDQo+IA0KPiBJIHRoaW5r
IHRoZXJlIGlzIGEgc21hbGwgcGVyZm9ybWFuY2UgcHJvYmxlbSB3aGVuIHdyaXRpbmcgaW50byBt
ZXRhZGF0YSBhcmVhLiAgQmVjYXVzZSB0aGlzIGlzIGEgY2FjaGVsaW5lIHRoYXQgbWlnaHQgYmUg
KHNlbWkpY29sZC4gIEhpbnQgd2UgcHJlZmV0Y2ggeGRwX2ZyYW1lIGFyZWEgYW5kIHdlIGNvdWxk
IGRvIHRoZSBzYW1lIGZvciBtZXRhZGF0YSwgYnV0IEkgc3RpbGwgc2VlIGEgc2xvd2Rvd24gd2hl
biBjb252ZXJ0aW5nIHhkcF9idWZmIHRvIHhkcF9mcmFtZS4NCj4gDQo+IFhEUCBpcyBleHRyZW1l
bHkgcGVyZm9ybWFuY2Ugc2Vuc2l0aXZlLiAgRXZlbiBpZiBtZXRhZGF0YSBhcmVhIGlzIGluIEwx
IGNhY2hlIGl0IHdpbGwgc3RpbGwgY29zdCBhIGNvdXBsZSBvZiBuYW5vc2VjIHRvIHVwZGF0ZSB0
aGUgZmllbGRzLg0KPiBUaGlzIHdpbGwgYmUgbWVhc3VyZWFibGUgaW4gYW4gWERQX0RST1AgdGVz
dC4gIFRoZSBlYXNpZXN0IHdvcmthcm91bmQgSSBzZWUgaXM6IHRoYXQgd2UgYWxsb3cgdGhlIGNv
bmZpZyBpbnRlcmZhY2UgZm9yIFhEUC1oaW50cyB0byBhbGxvdyBkaXNhYmxpbmcgdGhpcyBmZWF0
dXJlLg0KPiANCj4gDQo+ID4gdGhlIGxheW91dCBpcyBub3Qgd3JpdHRlbiBpbiBzdG9uZSB5ZXQu
DQo+IA0KPiBFeGFjdGx5LCB0aGUgbWFpbiByZWFzb24vbW90aXZhdGlvbiBmb3IgdGhpcyB3b3Jr
IGlzIHRvIGFsbG93IE5JQyB2ZW5kb3JzIHRvIGludmVudCBuZXcgaGFyZHdhcmUgaGludHMgd2l0
aG91dCBoYXZpbmcgdG8gd2FpdCBmb3IgdGhlIExpbnV4IGtlcm5lbCB0byBhZG9wdCB0aGVzZS4g
IEluc3RlYWQgdGhleSBhcmUgaW5zdGFudCBhdmFpbGFibGUgdmlhIEJQRiBhbmQgQlRGLWluZm8g
dGhhdCBkZXNjcmliZSB0aGlzIGxheW91dC4NCj4gDQo+ICANCj4gPiBJJ2xsIGJlIHByZXBhcmlu
ZyBhbiBvcGVuIHJlcG8gd2l0aCBvdXIgZHJhZnRzIHRvZGF5LCBsZXQgeW91IGtub3cgDQo+ID4g
b25jZSBpdCB3aWxsIGJlIHJlYWR5IGFuZCBhdmFpbGFibGUgc28geW91IGNvdWxkIHRha2UgYSBs
b29rLCByZXZpZXcsIA0KPiA+IGZvcmsgYW5kIGdvIGZvcnRoIHdpdGggcGxheWluZyB3aXRoIGl0
Lg0KPiANCj4gR3JlYXQhISEgOi0pKSkNCj4gDQo+ID4gQW55IG9mIHlvdSBjYW4gYWxzbyBzaGFy
ZSBhbnkgYml0cyBvZiBjb2RlIG9yIHRob3VnaHRzIHRoYXQgeW91IGhhdmUgDQo+ID4gYW5kIG1h
eSB3YW50IHRvIHNoYXJlLg0KPiA+IA0KPiA+IFRoYW5rcywNCj4gPiBBbA0KPiA+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogS3ViaWFrLCBNYXJjaW4gPG1hcmNp
bi5rdWJpYWtAaW50ZWwuY29tPg0KPiA+IFNlbnQ6IEZyaWRheSwgTWF5IDcsIDIwMjEgOTozNSBB
TQ0KPiA+IFRvOiBPbmcsIEJvb24gTGVvbmcgPGJvb24ubGVvbmcub25nQGludGVsLmNvbT47IEJy
YW5kZWJ1cmcsIEplc3NlIA0KPiA+IDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT47IERlc291
emEsIEVkZXJzb24gDQo+ID4gPGVkZXJzb24uZGVzb3V6YUBpbnRlbC5jb20+OyBMb2Jha2luLCBB
bGV4YW5kciANCj4gPiA8YWxleGFuZHIubG9iYWtpbkBpbnRlbC5jb20+OyBTd2lhdGtvd3NraSwg
TWljaGFsIA0KPiA+IDxtaWNoYWwuc3dpYXRrb3dza2lAaW50ZWwuY29tPg0KPiA+IENjOiBHb21l
cywgVmluaWNpdXMgPHZpbmljaXVzLmdvbWVzQGludGVsLmNvbT47IE1hbG9vciwgS2lzaGVuIA0K
PiA+IDxraXNoZW4ubWFsb29yQGludGVsLmNvbT47IFpoYW5nLCBKZXNzaWNhIDxqZXNzaWNhLnpo
YW5nQGludGVsLmNvbT47IA0KPiA+IEpvc2VwaCwgSml0aHUgPGppdGh1Lmpvc2VwaEBpbnRlbC5j
b20+OyBQbGFudHlrb3csIE1hcnRhIEEgDQo+ID4gPG1hcnRhLmEucGxhbnR5a293QGludGVsLmNv
bT47IExvYmFraW4sIEFsZXhhbmRyIA0KPiA+IDxhbGV4YW5kci5sb2Jha2luQGludGVsLmNvbT47
IEN6YXBuaWssIEx1a2FzeiANCj4gPiA8bHVrYXN6LmN6YXBuaWtAaW50ZWwuY29tPjsgUmFjenlu
c2tpLCBQaW90ciANCj4gPiA8cGlvdHIucmFjenluc2tpQGludGVsLmNvbT47IFNvbmcsIFlvb25n
IFNpYW5nIA0KPiA+IDx5b29uZy5zaWFuZy5zb25nQGludGVsLmNvbT4NCj4gPiBTdWJqZWN0OiBS
RTogQUZfWERQIG1ldGFkYXRhL2hpbnRzDQo+ID4gDQo+ID4gKyBAU3dpYXRrb3dza2ksIE1pY2hh
bA0KPiA+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogT25nLCBC
b29uIExlb25nIDxib29uLmxlb25nLm9uZ0BpbnRlbC5jb20+DQo+ID4gU2VudDogRnJpZGF5LCBN
YXkgNywgMjAyMSAzOjEzIEFNDQo+ID4gVG86IEJyYW5kZWJ1cmcsIEplc3NlIDxqZXNzZS5icmFu
ZGVidXJnQGludGVsLmNvbT47IERlc291emEsIEVkZXJzb24gDQo+ID4gPGVkZXJzb24uZGVzb3V6
YUBpbnRlbC5jb20+OyBMb2Jha2luLCBBbGV4YW5kciANCj4gPiA8YWxleGFuZHIubG9iYWtpbkBp
bnRlbC5jb20+DQo+ID4gQ2M6IEdvbWVzLCBWaW5pY2l1cyA8dmluaWNpdXMuZ29tZXNAaW50ZWwu
Y29tPjsgTWFsb29yLCBLaXNoZW4gDQo+ID4gPGtpc2hlbi5tYWxvb3JAaW50ZWwuY29tPjsgWmhh
bmcsIEplc3NpY2EgPGplc3NpY2EuemhhbmdAaW50ZWwuY29tPjsgDQo+ID4gSm9zZXBoLCBKaXRo
dSA8aml0aHUuam9zZXBoQGludGVsLmNvbT47IFBsYW50eWtvdywgTWFydGEgQSANCj4gPiA8bWFy
dGEuYS5wbGFudHlrb3dAaW50ZWwuY29tPjsgTG9iYWtpbiwgQWxleGFuZHIgDQo+ID4gPGFsZXhh
bmRyLmxvYmFraW5AaW50ZWwuY29tPjsgQ3phcG5paywgTHVrYXN6IA0KPiA+IDxsdWthc3ouY3ph
cG5pa0BpbnRlbC5jb20+OyBSYWN6eW5za2ksIFBpb3RyIA0KPiA+IDxwaW90ci5yYWN6eW5za2lA
aW50ZWwuY29tPjsgS3ViaWFrLCBNYXJjaW4gPG1hcmNpbi5rdWJpYWtAaW50ZWwuY29tPjsgDQo+
ID4gU29uZywgWW9vbmcgU2lhbmcgPHlvb25nLnNpYW5nLnNvbmdAaW50ZWwuY29tPg0KPiA+IFN1
YmplY3Q6IFJFOiBBRl9YRFAgbWV0YWRhdGEvaGludHMNCj4gPiANCj4gPiArIFlvb25nIFNpYW5n
DQo+ID4gDQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogQnJh
bmRlYnVyZywgSmVzc2UgPGplc3NlLmJyYW5kZWJ1cmdAaW50ZWwuY29tPg0KPiA+ID4gU2VudDog
RnJpZGF5LCBNYXkgNywgMjAyMSA4OjMyIEFNDQo+ID4gPiBUbzogRGVzb3V6YSwgRWRlcnNvbiA8
ZWRlcnNvbi5kZXNvdXphQGludGVsLmNvbT47IExvYmFraW4sIEFsZXhhbmRyIA0KPiA+ID4gPGFs
ZXhhbmRyLmxvYmFraW5AaW50ZWwuY29tPjsgT25nLCBCb29uIExlb25nIA0KPiA+ID4gPGJvb24u
bGVvbmcub25nQGludGVsLmNvbT4NCj4gPiA+IENjOiBHb21lcywgVmluaWNpdXMgPHZpbmljaXVz
LmdvbWVzQGludGVsLmNvbT47IE1hbG9vciwgS2lzaGVuIA0KPiA+ID4gPGtpc2hlbi5tYWxvb3JA
aW50ZWwuY29tPjsgWmhhbmcsIEplc3NpY2EgPGplc3NpY2EuemhhbmdAaW50ZWwuY29tPjsgDQo+
ID4gPiBKb3NlcGgsIEppdGh1IDxqaXRodS5qb3NlcGhAaW50ZWwuY29tPjsgUGxhbnR5a293LCBN
YXJ0YSBBIA0KPiA+ID4gPG1hcnRhLmEucGxhbnR5a293QGludGVsLmNvbT47IExvYmFraW4sIEFs
ZXhhbmRyIA0KPiA+ID4gPGFsZXhhbmRyLmxvYmFraW5AaW50ZWwuY29tPjsgQ3phcG5paywgTHVr
YXN6IA0KPiA+ID4gPGx1a2Fzei5jemFwbmlrQGludGVsLmNvbT47IFJhY3p5bnNraSwgUGlvdHIg
DQo+ID4gPiA8cGlvdHIucmFjenluc2tpQGludGVsLmNvbT47IEt1YmlhaywgTWFyY2luIDxtYXJj
aW4ua3ViaWFrQGludGVsLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJFOiBBRl9YRFAgbWV0YWRhdGEv
aGludHMNCj4gPiA+IA0KPiA+ID4gSSB0aGluayBvdXIgWERQIHRlYW0gaXMgb24gdGhpcywgYW5k
IEknbGwgbGV0IHRoZW0gYW5zd2VyIGluIGRldGFpbC4gDQo+ID4gPiBZZXMsIEknbSBhIGdvb2Yg
Zm9yIHRvcCBwb3N0aW5nIHVzaW5nIG91dGxvb2suLi4uDQo+ID4gPiAgDQo+ID4gPiA+IFNvLCBJ
J2QgbGlrZSB0byBhc2sgc29tZSBxdWVzdGlvbnM6DQo+ID4gPiA+ICAtIEFyZSB5b3UgZ3V5cyBh
bHNvIGludGVyZXN0ZWQgaW4gQUZfWERQIHN1cHBvcnQsIG9yIGRvIHlvdSBjYXJlIA0KPiA+ID4g
PiBhYm91dCBYRFAgb25seT8NCj4gPiA+IA0KPiA+ID4gWWVzISBCb3RoLiAgDQo+ID4gDQo+ID4g
Rm9yIHVzIChCTCBhbmQgU2lhbmcpIGluIFBlbmFuZywgU2luY2UsIHdlIGhhdmUgMyB0aW1lLXpv
bmVzIGFuZCBJIGRvbid0IHRoaW5rIGl0IGlzIGVmZmVjdGl2ZSBmb3IgdXMgdG8gcnVuIDMgdGlt
ZSB6b25lIGRpc2N1c3Npb24uIFNvLCBwbGVhc2UgY2Fycnkgb24gd2l0aG91dCB1cy4gDQo+ID4g
DQo+ID4gSG93ZXZlciwgd2Ugd291bGQgbGlrZSB0byBmb2xsb3cgdGhlIFJGQyBhbmQgUE9DIHNv
IHRoYXQgd2UgY2FuIGhlbHAgdG8gaW1wbGVtZW50IHRoZSBzdG1tYWMgZHJpdmVyIHBhcnQgYW5k
IGhlbHAgdGVzdC4NCj4gPiANCj4gPiBCTA0KPiA+ID4gIA0KPiA+ID4gPiAgLSBEaWQgeW91IGFs
cmVhZHkgc3RhcnQgdGhlIHdvcms/IENvdWxkIHlvdSBkZXNjcmliZSBob3cgeW91IA0KPiA+ID4g
PiBoYW5kbGUgdGhlIG1ldGFkYXRhPyBDYW4gd2Ugc2VlIHNvbWUgcHJldmlldz8gV2UncmUgcGxh
bm5pbmcgdG8gDQo+ID4gPiA+IHN0YXJ0IG5leHQgd2Vlaywgc28gbm90IG11Y2ggdG8gc2hvd1sq
XS4NCj4gPiA+ID4gIC0gSSBiZWxpZXZlIHRoZXJlIG1heSBiZSBvcHBvcnR1bml0aWVzIHRvIGNv
bGxhYm9yYXRlIGhlcmUgLSBob3cgDQo+ID4gPiA+IGNhbiB3ZSBoZWxwPw0KPiA+ID4gDQo+ID4g
PiBQbGVhc2UgZm9sa3MsIGdldCB0b2dldGhlciBhbmQgdGFsay4gRWRlcnNvbiwgdGhpcyB0ZWFt
IGlzIGluIFBvbGFuZCANCj4gPiA+IHNvIGlzICs5IGhvdXJzIGZyb20gUFNULiBLZWVwIG1lIGlu
Zm9ybWVkIG9uIHdoYXQncyB1cCwgYnV0IEkgZG9uJ3QgDQo+ID4gPiBuZWVkIHRvIGJlIGluIHRo
ZSBkYXkgdG8gZGF5LCBidXQgeW91J3JlIHdlbGNvbWUgdG8gY29uc3VsdCBtZSBhbnl0aW1lLg0K
PiA+ID4gDQo+ID4gPiAtSmVzc2UNCj4gPiA+IA0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPiA+IEZyb206IERlc291emEsIEVkZXJzb24gPGVkZXJzb24uZGVzb3V6YUBpbnRl
bC5jb20+DQo+ID4gPiBTZW50OiBUaHVyc2RheSwgTWF5IDYsIDIwMjEgNTowOCBQTQ0KPiA+ID4g
VG86IExvYmFraW4sIEFsZXhhbmRyIDxhbGV4YW5kci5sb2Jha2luQGludGVsLmNvbT47IE9uZywg
Qm9vbiBMZW9uZyANCj4gPiA+IDxib29uLmxlb25nLm9uZ0BpbnRlbC5jb20+OyBCcmFuZGVidXJn
LCBKZXNzZSANCj4gPiA+IDxqZXNzZS5icmFuZGVidXJnQGludGVsLmNvbT4NCj4gPiA+IENjOiBH
b21lcywgVmluaWNpdXMgPHZpbmljaXVzLmdvbWVzQGludGVsLmNvbT47IE1hbG9vciwgS2lzaGVu
IA0KPiA+ID4gPGtpc2hlbi5tYWxvb3JAaW50ZWwuY29tPjsgWmhhbmcsIEplc3NpY2EgPGplc3Np
Y2EuemhhbmdAaW50ZWwuY29tPjsgDQo+ID4gPiBKb3NlcGgsIEppdGh1IDxqaXRodS5qb3NlcGhA
aW50ZWwuY29tPg0KPiA+ID4gU3ViamVjdDogUmU6IEFGX1hEUCBtZXRhZGF0YS9oaW50cw0KPiA+
ID4gDQo+ID4gPiArSmVzc2ljYQ0KPiA+ID4gDQo+ID4gPiBHZW50bGUgcGluZyB0byBjaGVjayBp
ZiBhbnlvbmUncyBpbnRlcmVzdGVkID1EDQo+ID4gPiANCj4gPiA+IE9uIEZyaSwgMjAyMS0wNC0z
MCBhdCAxOToyNCAtMDcwMCwgRWRlcnNvbiBkZSBTb3V6YSB3cm90ZTogIA0KPiA+ID4gPiBIaSBm
b2xrcywNCj4gPiA+ID4gDQo+ID4gPiA+IEkndmUgbm90aWNlZCB0aGF0IHlvdSBhcmUgc29tZSBJ
bnRlbCBwZW9wbGUgdGhhdCBtZW50aW9uZWQgKG9uIGEgDQo+ID4gPiA+IHRocmVhZCB3aXRoIHRo
ZSBjb21tdW5pdHkpIGludGVyZXN0IGFuZCBzb21lIGRldmVsb3BtZW50IHJlZ2FyZGluZyANCj4g
PiA+ID4gWERQIG1ldGFkYXRhIChmb3IgUlgvVFggdGltZXN0YW1wIGFuZCBTT19UWFRJTUUgc3Vw
cG9ydCkuIEFuZCBteSANCj4gPiA+ID4gdGVhbSwgb24gSUFHUy9TU0UsIGlzIGFsc28gd29ya2lu
ZyBvbiB0aGF0IGZvciB0aGUgaTIyNSBpZ2MgZHJpdmVyLg0KPiA+ID4gPiANCj4gPiA+ID4gQXMg
dGhlcmUncyBzb21lIG92ZXJsYXAgaW4gdGhpcyB3b3JrLCBJJ2QgbGlrZSB0byBmaWd1cmUgaXQg
b3V0IA0KPiA+ID4gPiB3aGF0IGlzIHRoZSBzdGF0ZSBvZiB0aGVzZSBkZXZlbG9wbWVudHMgYW5k
IGFsaWduIHdoYXQgd2UncmUgZG9pbmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBJJ2xsIHRhbGsgYWJv
dXQgb3VyIGlkZWFzIGFuZCBhc2sgc29tZSBxdWVzdGlvbnMgdG8gaGVscCBpbiB0aGlzIA0KPiA+
ID4gPiBhbGlnbm1lbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBXZSB3YW50IHRoZSAiU09fVFhUSU1F
IiBzdXBwb3J0IGZvciBBRl9YRFAgWkMuIFJpZ2h0IG5vdywgd2UncmUgDQo+ID4gPiA+IHRoaW5r
aW5nIGFib3V0IHdvcmtpbmcgb24gdG9wIG9mIFNhZWVkJ3Mgd29yayB0aGF0IGVuYWJsZXMgQlRG
IGZvciBYRFAuDQo+ID4gPiA+IE91ciBpZGVhIGlzIHRvIHVzZSBCVEYgYW5kIHRoZSBYRFAgbWV0
YWRhdGEgYXJlYSAodGhhdCBoZWFkcm9vbSANCj4gPiA+ID4gYXJlYSBqdXN0IGJlZm9yZSB0aGUg
ZnJhbWUgZGF0YSBzdGFydHMpIHRvIHN0b3JlIHRoZSB0aW1lc3RhbXAuDQo+ID4gPiA+IA0KPiA+
ID4gPiBGb3IgdGhpcyB0byB3b3JrLCB3ZSdyZSB0aGlua2luZyBvZiBhZGRpbmcgc29tZSBuZXcg
QVBJIHRvIA0KPiA+ID4gPiBgdG9vbHMvbGliL2JwZi94c2suaGAgdG8gYWxsb3cgdXNlcnNwYWNl
IGFwcGxpY2F0aW9uIHRvIG1hbmlwdWxhdGUgDQo+ID4gPiA+IHRoYXQgYXJlYSBhbmQgYWRkIHRo
ZSBtZXRhZGF0YSAod2l0aG91dCBleHBsaWNpdGx5IHN1YnRyYWN0aW5nIA0KPiA+ID4gPiBwb2lu
dGVycyBhbmQgc3VjaCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGVuLCBhZGQgc3VwcG9ydCBvbiBi
b3RoIGlnYyBkcml2ZXIgdG8gZXh0cmFjdCB0aGlzIG1ldGFkYXRhIGFuZCANCj4gPiA+ID4gc2V0
IHRoZSBsYXVuY2ggdGltZSBhbmQgdGhlIGdlbmVyaWMgQUZfWERQIHNvY2tldCAoZm9yIGNvcHkg
bW9kZQ0KPiA+ID4gPiBjb21wYXRpYmlsaXR5KSB0byBleHRyYWN0IGFuZCBhZGQgaXQgdG8gdGhl
IHNrYiBzZW50IGRvd24gdGhlIHN0YWNrLg0KPiA+ID4gPiANCj4gPiA+ID4gT2YgY291cnNlLCB0
aGUgaXNzdWUgaGVyZSBpcyBob3cgdG8gbWFrZSB0aGlzIGdlbmVyaWMgZW5vdWdoLiANCj4gPiA+
ID4gU2FlZWQncyB3b3JrIGtpbmRhIGV4cGVjdHMgYSBtZXRhZGF0YSBzdHJ1Y3QgcGVyIGRyaXZl
ciwgSUlVQy4NCj4gPiA+ID4gDQo+ID4gPiA+IFNvLCBJJ2QgbGlrZSB0byBhc2sgc29tZSBxdWVz
dGlvbnM6DQo+ID4gPiA+ICAtIEFyZSB5b3UgZ3V5cyBhbHNvIGludGVyZXN0ZWQgaW4gQUZfWERQ
IHN1cHBvcnQsIG9yIGRvIHlvdSBjYXJlIA0KPiA+ID4gPiBhYm91dCBYRFAgb25seT8NCj4gPiA+
ID4gIC0gRGlkIHlvdSBhbHJlYWR5IHN0YXJ0IHRoZSB3b3JrPyBDb3VsZCB5b3UgZGVzY3JpYmUg
aG93IHlvdSANCj4gPiA+ID4gaGFuZGxlIHRoZSBtZXRhZGF0YT8gQ2FuIHdlIHNlZSBzb21lIHBy
ZXZpZXc/IFdlJ3JlIHBsYW5uaW5nIHRvIA0KPiA+ID4gPiBzdGFydCBuZXh0IHdlZWssIHNvIG5v
dCBtdWNoIHRvIHNob3dbKl0uDQo+ID4gPiA+ICAtIEkgYmVsaWV2ZSB0aGVyZSBtYXkgYmUgb3Bw
b3J0dW5pdGllcyB0byBjb2xsYWJvcmF0ZSBoZXJlIC0gaG93IA0KPiA+ID4gPiBjYW4gd2UgaGVs
cD8NCj4gPiA+ID4gDQo+ID4gPiA+IENoZWVycyENCj4gPiA+ID4gDQo+ID4gPiA+IFsqXSBJbiBm
YWN0LCB3ZSdyZSB1c2luZyBCVEYgbWV0YWRhdGEgdG8gZ2V0IEhXIFJYL1RYIHRpbWVzdGFtcHMg
DQo+ID4gPiA+IGZvciBzb21lIGludGVybmFsIGxhdGVuY3kgbWVhc3VyZW1lbnRzIHdlJ3JlIGRv
aW5nLiBJdCdzIGZhaXJseSANCj4gPiA+ID4gaGFja2lzaCAoYW5kIHVnbHkpIGF0IHRoaXMgcG9p
bnQsIGJ1dCBpZiB5b3UgYXJlIGludGVyZXN0ZWQsIHdlIA0KPiA+ID4gPiBjb3VsZCBzaGFyZSB3
aGF0IHdlJ3ZlIGRvbmUuDQo+ID4gDQo+ID4gDQo+ID4gPiA+ICANCj4gPiA+IA0KPiA+ID4gIA0K
PiA+IA0KPiANCj4gDQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+ICAgSmVzcGVyIERhbmdh
YXJkIEJyb3Vlcg0KPiAgIE1TYy5DUywgUHJpbmNpcGFsIEtlcm5lbCBFbmdpbmVlciBhdCBSZWQg
SGF0DQo+ICAgTGlua2VkSW46IGh0dHA6Ly93d3cubGlua2VkaW4uY29tL2luL2Jyb3Vlcg0KPiAN
Cg0K
