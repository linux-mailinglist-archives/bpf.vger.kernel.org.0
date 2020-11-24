Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA172C3186
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 21:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729777AbgKXT7u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 14:59:50 -0500
Received: from mga14.intel.com ([192.55.52.115]:2071 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbgKXT7s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 Nov 2020 14:59:48 -0500
IronPort-SDR: PA5BRUx/eE+hSGTXyoHko1YU0qIp035VaAUYw8WAPOcRip0wL1umoPHZ0HICK2Ck//0wcAI39O
 JntEhn11GWmQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="171228492"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="171228492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 11:59:48 -0800
IronPort-SDR: +ax1h8vFq9gbnC2OKPq0W7q7KhylF4OEMd9u7iwyo8rVxtHWmEiT/iuVquVcoFwZLNzaRBRA9l
 ldz8+7/xCyeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="403023749"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 24 Nov 2020 11:59:47 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 11:59:47 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 24 Nov 2020 11:59:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 24 Nov 2020 11:59:46 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 24 Nov 2020 11:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YuASUyu5N9ovRepn0+RrMv6ajx/7u3Nb3wpP4YMzAoE0jnf4PZB0FkfmCXshWfHAVAT0HHIsrXPcG8HVz0pFpqy/q8p5qq2oMZqMZrL2k7MimNHuH9xLUSuDucOLV6UYQwAJMP0jjnWNgVW+6skTdID9NO2NdDZd3sDaL2/KVIfe5D9axmuxst7CU/LA66nrAESNOH9VrjxMISWTY4NeFx9xNJzamFGgazeF7NUvPeS8ZT9u+gQeyZsT9eunuY7s7QFGXcwVWtneqQvNL/jzN0fYYWdgAOITClAoTsr37exgMKC4jMLfLtpTJN3MKC0leIYUxnINwmTKmZHdtnHGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbaOc9dGIMbBvsUxiaReTf7Nregbi2ZsXC5E6bUMggE=;
 b=PS7Q5EeOmbvhksj7KmD9/afW9tjxtlZvKtfVhsFyl4suJe1wKIjgi5co0dcKG3WUwDqE7xtUTvG7/jv8l2YpJMUWBQwSfQSMSGiCJMwBeBKAPB/Z9iuelXKD68uPNxOmXP763sFYN2PJ4mmlR5wF3TrOHaPtbUpoTHI+EKFAyfLjn44OV4bjKaPP9WuBfcuXC/qkoYFibI70Q1GQa59RpvbowWKm4mpM6kVGlyY8g1CMWRJaNzUYHAHMOwvt1qk8aDwjq+T9Ld4jc78ZvllKjbl7M9xXVghaS2h/IjHnlRSKQjov5/7B5GzEEt/cN4IJFnXfLkSYf0+9hBH0iOYWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbaOc9dGIMbBvsUxiaReTf7Nregbi2ZsXC5E6bUMggE=;
 b=jEZwGKbHAqW1BYTVaDFTc/5XiXQZoqK1DhKRQ6F3qVlxq9HCaAUm3DFEZgamvkmo3lhRx/652bav+55BYWVNRyUl7zetwk+pJIObC8/1W4l4fka7CPnig/iQGrvp8MihsE5Bf7UeZxAw9rZeNqi/CsSnr837u7S1yFYvVRHanxo=
Received: from SN6PR11MB3184.namprd11.prod.outlook.com (2603:10b6:805:bd::17)
 by SA2PR11MB5035.namprd11.prod.outlook.com (2603:10b6:806:116::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Tue, 24 Nov
 2020 19:59:44 +0000
Received: from SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412]) by SN6PR11MB3184.namprd11.prod.outlook.com
 ([fe80::bcad:a1da:3b9b:1412%6]) with mapi id 15.20.3589.025; Tue, 24 Nov 2020
 19:59:44 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "luto@kernel.org" <luto@kernel.org>
Subject: Re: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Topic: [PATCH RFC 01/10] vmalloc: Add basic perm alloc implementation
Thread-Index: AQHWv3v0VGlTYBJQUE2XnxoQHVHqeqnVb0MAgADEkICAAOOpgIAAoj4A
Date:   Tue, 24 Nov 2020 19:59:44 +0000
Message-ID: <4be82a3571fb25bb096f2c98dc32d07da51af3d4.camel@intel.com>
References: <20201120202426.18009-1-rick.p.edgecombe@intel.com>
         <20201120202426.18009-2-rick.p.edgecombe@intel.com>
         <20201123090040.GA6334@infradead.org>
         <eccaa448f82e90c924d51d52525f766340026dfe.camel@intel.com>
         <20201124101901.GB9682@infradead.org>
In-Reply-To: <20201124101901.GB9682@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.30.1 (3.30.1-1.fc29) 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42e8382c-ea5f-4089-fcd5-08d890b37d10
x-ms-traffictypediagnostic: SA2PR11MB5035:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5035E91AC57639C956B908E3C9FB0@SA2PR11MB5035.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fw4daa2UbjRIYu14CSRnlfDRs2/KO/p2TsSm+0HQQuaRbsq/4azWBf6hqEKtGG6UcJMnjHZhOZ/qRuFdzFNPtSXKNp/TBhCIFGAgc79Ig4BwCPf6LHvRBLn0MkGRPPGMtbmK5/kXyRKfjx5C+YSvrUr5MsFr+wXrmFFfp02amm7BE2/DF3kGSVcEnbAxfAi59cL3da6GF3sZZGhvtS9YL/8VHafU3pujrz6+Magn0a+bQJrfLo8jaOZIbcPFRk+A0+QA17UzjS4HIuJ4lOW5OF5NjCdxUAJOInyqJMJZ6gvprjFIIGDaWswtCXJCink1ID2+lDYm84yZNqXmPqJhGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3184.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(346002)(376002)(316002)(54906003)(6506007)(2906002)(2616005)(26005)(83380400001)(186003)(5660300002)(36756003)(66946007)(66556008)(7416002)(71200400001)(64756008)(76116006)(478600001)(8936002)(91956017)(86362001)(8676002)(6486002)(66476007)(4326008)(6916009)(66446008)(6512007)(4001150100001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?RFRVZDBGNFBXSE9BT0dsekRiUHRKTDdUcjNCcUFWWGFhNC9GVWIvUXFYZmtS?=
 =?utf-8?B?anBCL0U2U3ZlR3p5MDZPM1NETWhTNzlkUTVaVVA4c1o1OHNyT1R0Sm1HNDVJ?=
 =?utf-8?B?UU9hK1VMRFJYaEYrNjlYTWRLK1o5MnlZVjFERE1GSE9TeDNTQldXS0ZTTjlm?=
 =?utf-8?B?b0Z0UG1pY0dqcGdOM1pFU3FiVUZyOHlEdkxpTEtMUHdETXI5T1lrVTNYMlpO?=
 =?utf-8?B?UDNaNm5ZY3RsOHdjRWNrNUpXd1gxeUlsMkNoZmZQTkdENWliVVYweGdQdW1v?=
 =?utf-8?B?WStZeURWZzdoWkhDdkR3TmR3SVZMOEl2RW02L3VrNU1RQms3OHgvMmdHYzNO?=
 =?utf-8?B?TVREb21XYTdETUlkTENlcnFvc21sbkorUTdWTGsxNzVSQWRkWitTK2w3R1Rr?=
 =?utf-8?B?b2Urc3RURVlHcHY4ODlpam41ZTdBQ04yOGdRZ25EVEVuWXo3RndGdDZvcU9C?=
 =?utf-8?B?cjJRZmFjZFdRK1dBVTEwbHJESzBNRWY1alBxaEswQXR4S1A1Rk96QmxicE50?=
 =?utf-8?B?N0tvTDZ2S0xSQzUvdCtQdnAwUzJsekxyQ29oQTF3dWs3eTlqZ2h5QVpmZUVm?=
 =?utf-8?B?OVcxU054ZDhZNTNsSEEyTjZXNTBuSjFFS25NTWFoNkhGRVRvMC96K1k1aTNE?=
 =?utf-8?B?YzVWdFpWVnNVT3MzZXJkc1VMRDBEVndyNWNqVlgvZ2JWMGhIaGJ5RTJQM2ZM?=
 =?utf-8?B?RC91SHkvYzdpOUw1ODhrbnlBUlFtblFsM1c2T1doczRza3ZHdzBoei9Nendt?=
 =?utf-8?B?VUkyWHNRUGtJY3FIQWlKeitYR1dsYk5BWUs4WmpMV0lOZUV6N0VXMldGM3U2?=
 =?utf-8?B?c202RjdLRTlScEZicmc5T0QxUC9RU1psbFdTbE1uUnBhTGp0d0VmVWhzYXBj?=
 =?utf-8?B?RDZGeDBDNWtlaG9CTG8zWHV5VFVJT3IvWWxkR1poL3Q5b0NOTWpqNXRqNDVB?=
 =?utf-8?B?WGdRd2o2NjRIanh3RGhNODBjUW5yMEZmRmFxNk5xR1EwenZ4a3lEN2cweUJS?=
 =?utf-8?B?WjlETjNHOGxEREcyQll3eE1pd3NWMFpxNkd4aVdPRmJzdDduYWJTSlhOZllw?=
 =?utf-8?B?TkF5ak84dFB5WlhyRGt5Z0VlSEZVS1krcWorVEp2ekxKUlNuUTJJL3hGR2FT?=
 =?utf-8?B?NGJ5OHdFeWkvbC9McTZhS1NVb0NhZnh1NHprQnNocEhEVEZpUjArUU93QjlS?=
 =?utf-8?B?SDJya1ZqMkRYUnBPVlpScDBwSitIZWlxVnkxTXlqbk9hRUErRkhlZTQ5Yld4?=
 =?utf-8?B?RzB0d2F4amZwWHFyVnNmczlwbldJZEFvNTVSQUJKUlRveVRiNU81Rm9ZWDVD?=
 =?utf-8?Q?GXYzlR+MKjFgqu36Eb5s/tv5Oox6mt2nRT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E955E7D407404A479F3EA44983CCE8C4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3184.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42e8382c-ea5f-4089-fcd5-08d890b37d10
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2020 19:59:44.3207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c1fWfaHWlNjMrYF9yRro/HqQXV7wEeTt5ybE1+mer2j+PB9P825uoNUXPcaxHWwdPhhzhyazwi/naFb36mk5D8nj19o9M6DWKJNzBRhTXUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5035
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIwLTExLTI0IGF0IDEwOjE5ICswMDAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gQnV0IEkgdGhvdWdodCB0aGF0IHVzaW5nIHRob3NlIHBncHJvdCBmbGFncyB3YXMgc3Rp
bGwgc29ydA0KPiBvdmVybG9hZGluZw0KPiA+IHRoZSBtZWFuaW5nIG9mIHBncHJvdC4gTXkgdW5k
ZXJzdGFuZGluZyB3YXMgdGhhdCBpdCBpcyBzdXBwb3NlZCB0bw0KPiA+IGhvbGQNCj4gPiB0aGUg
YWN0dWFsIGJpdHMgc2V0IGluIHRoZSBQVEUuIEZvciBleGFtcGxlIGxhcmdlIHBhZ2VzIG9yIFRM
Qg0KPiA+IGhpbnRzDQo+ID4gKGxpa2UgUEFHRV9LRVJORUxfRVhFQ19DT05UKSBjb3VsZCBzZXQg
b3IgdW5zZXQgZXh0cmEgYml0cywgc28NCj4gPiBhc2tpbmcNCj4gPiBmb3IgUEFHRV9LRVJORUxf
RVhFQyB3b3VsZG4ndCBuZWNlc3NhcmlseSBtZWFuICJzZXQgdGhlc2UgYml0cyBpbg0KPiA+IGFs
bA0KPiA+IG9mIHRoZSBQVEVzIiwgaXQgY291bGQgbWVhbiBzb21ldGhpbmcgbW9yZSBsaWtlICJp
bmZlciB3aGF0IEkgd2FudA0KPiA+IGZyb20NCj4gPiB0aGVzZSBiaXRzIGFuZCBkbyB0aGF0Ii4N
Cj4gPiANCj4gPiB4ODYncyBjcGEgd2lsbCBhbHNvIGF2b2lkIGNoYW5naW5nIE5YIGlmIGl0IGlz
IG5vdCBzdXBwb3J0ZWQsIHNvIGlmDQo+ID4gdGhlDQo+ID4gY2FsbGVyIGFza2VkIGZvciBQQUdF
X0tFUk5FTC0+UEFHRV9LRVJORUxfRVhFQyBpbiBwZXJtX2NoYW5nZSgpIGl0DQo+ID4gc2hvdWxk
IG5vdCBuZWNlc3NhcmlseSBib3RoZXIgc2V0dGluZyBhbGwgb2YgdGhlIFBBR0VfS0VSTkVMX0VY
RUMNCj4gPiBiaXRzDQo+ID4gaW4gdGhlIGFjdHVhbCBQVEVzLiBBc2tpbmcgZm9yIFBFUk1fUlct
PlBFUk1fUldYIG9uIHRoZSBvdGhlciBoYW5kLA0KPiA+IHdvdWxkIGxldCB0aGUgaW1wbGVtZW50
YXRpb24gZG8gd2hhdGV2ZXIgaXQgbmVlZHMgdG8gc2V0IHRoZSBtZW1vcnkNCj4gPiBleGVjdXRh
YmxlLCBsaWtlIHNldF9tZW1vcnlfeCgpIGRvZXMuIEl0IHNob3VsZCB3b3JrIGVpdGhlciB3YXkg
YnV0DQo+ID4gc2VlbXMgbGlrZSB0aGUgZXhwZWN0YXRpb25zIHdvdWxkIGJlIGEgbGl0dGxlIGNs
ZWFyZXIgd2l0aCB0aGUNCj4gPiBQRVJNXw0KPiA+IGZsYWdzLg0KPiANCj4gT2ssIG1heWJlIHRo
YXQgaXMgYW4gYXJndW1lbnQsIGFuZCB3ZSBzaG91bGQgdXNlIHRoZSBuZXcgZmxhZ3MgbW9yZQ0K
PiBicm9hZGx5Lg0KDQpUaGV5IG1pZ2h0IG1ha2Ugc2Vuc2UgdG8gbGl2ZSBpbiBzZXRfbWVtb3J5
LmggdGhlbi4gU2VwYXJhdGUgZnJvbSB0aGlzDQpwYXRjaHNldCwgYSBjYWxsIGxpa2Ugc2V0X21l
bW9yeShhZGRyLCBudW1wYWdlcywgUEVSTV9SKSBjb3VsZCBiZSBtb3JlDQplZmZpY2llbnQgdGhh
biB0d28gY2FsbHMgdG8gc2V0X21lbW9yeV9ybygpIGFuZCBzZXRfbWVtb3J5X254KCkuIE5vdA0K
dGhhdCBpdCBoYXBwZW5zIHZlcnkgbXVjaCBvdXRzaWRlIG9mIHZtYWxsb2MgdXNhZ2VzLiBCdXQg
anVzdCB0byB0cnkgdG8NCnRoaW5rIHdoZXJlIGVsc2UgaXQgY291bGQgYmUgdXNlZC4NCg0KPiA+
IENvdWxkIGVhc2lseSB3cmFwIHRoaXMgb25lLCBidXQganVzdCB0byBjbGFyaWZ5LCBkbyB5b3Ug
bWVhbiBsaW5lcw0KPiA+IG92ZXINCj4gPiA4MCBjaGFycz8gVGhlcmUgd2VyZSBhbHJlYWR5IHNv
bWUgb3ZlciA4MCBpbiB2bWFsbG9jIGJlZm9yZSB0aGUNCj4gPiBtb3ZlIHRvDQo+ID4gMTAwIGNo
YXJzLCBzbyBmaWd1cmVkIGl0IHdhcyBvayB0byBzdHJldGNoIG91dCBub3cuDQo+IA0KPiBDb2Rp
bmdTdHlsZSBzdGlsbCBzYXlzIDgwIGNoYXJhY3RlcnMgdW5sZXNzIHlvdSBoYXZlIGFuIGV4Y2Vw
dGlvbg0KPiB3aGVyZQ0KPiBhIGxvbmdlciBsaW5lIGltcHJvdmVzIHRoZSByZWFkYWJpbGl0eS4g
IFRoZSBxdW90ZWQgY29kZSBhYnNvbHV0ZWx5DQo+IGRvZXMgbm90IGZpdCB0aGUgZGVmaW5pdGlv
biBvZiBhbiBleGNlcHRpb24gb3IgaW1wcm92ZXMgcmVhZGFiaWxpdHkuDQoNCkZhaXIgZW5vdWdo
Lg0KDQpBbmQgdG8gdGhlIG90aGVyIGNvbW1lbnQgaW4geW91ciBmaXJzdCBtYWlsLCBnbGFkIHRv
IGRvIHRoaXMgYW5kDQpmaW5hbGx5IHNlbmQgaXQgb3V0LiBUaGlzIHNlcmllcyBoYXMgYmVlbiBz
aXR0aW5nIGluIGEgbG9jYWwgYnJhbmNoIGZvcg0KbW9zdCBvZiB0aGUgeWVhciB3aGlsZSBzdHVm
ZiBrZXB0IGludGVycnVwdGluZyBpdC4NCg==
