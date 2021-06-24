Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE4533B2432
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 02:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFXAMd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 20:12:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:53498 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229726AbhFXAMd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Jun 2021 20:12:33 -0400
IronPort-SDR: k88EgTIr7uN7Y5Enf1oTgxVbLgSRsnLAmr8OPC9xp4GPZil0uONmEHLRfbpuEqWdw0vM5v/Ux3
 aBkztr4IaAmQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10024"; a="204359519"
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="204359519"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2021 17:10:14 -0700
IronPort-SDR: xgpsNJKKweNd9tOBPcrXc2A/EfECZMTdetlqIrywJ2o9aSIgTEMKwr0vMUeHYYHFKTe584okdw
 Efg4A046eMEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,295,1616482800"; 
   d="scan'208";a="557140428"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga001.fm.intel.com with ESMTP; 23 Jun 2021 17:10:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 17:10:14 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 23 Jun 2021 17:10:13 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4
 via Frontend Transport; Wed, 23 Jun 2021 17:10:13 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.4; Wed, 23 Jun 2021 17:10:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MdWXkgKSwkpXZy6S+ioIxI18JA/XWoqVm77WkI+7kHHAmfWGyO9lmta8DxFHel5FMZO09DNzOF8iRY+hdTW0vG0Q9f3iDWXfo6LO9gbby1SbhmTYJF5I7GWjKCLa+dFsfGAvIlREouSuJvsFCxDepiJ/ZuQzybkLwmR0jO6c7chQbBbSFBC2bd7xcRZVDamdy+kKejZIDUQjNtCQzA2aYT3vmVoXdfMb/yxBFQJs2vTJfyVQH1dUeY4sPypUJk8meusm4YF5i92UCMAbIxH7UfGr+YIqjKIfmxa5CR0NebHGUvhnbkeqpUn1nGJshbHjYy9k4IaCwKI/X2aWoKughA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbpcHIm7nt8ssd663Zj5e/pkfNtvCNKGW+esHcbcVoA=;
 b=H4E8HKhrw/cxKjC6W6YIp50hJDGvh9Yh2RWLlC8yq07kmZH3SV6qpZG0qC3N4RoGaGjJxbMoJWF9D+PFN+YbMMjNk7+9FQuaPoZYKEcLv2UMwG1TKh7K7jDg7WRnr070/YBPRivCpBln7Hw0ocs4bRUWSKYxjl3KTZY2ZfpKXzLVLN2Njhn4mfzHDUNx05NTXOhXy782hDSrvEA7jTTG5wTf+HlLcFUl4KRxNGXHcxmwhBE3UVuJJsCh3w1UPUY/4Gzn60SNnEJai98c8j5Uxuzh88VdAERxIZOL24LQ3t/MIIfkpAIMiNfa+MoVgqCOHCqsV3eLA3V1HPB+I5HyYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nbpcHIm7nt8ssd663Zj5e/pkfNtvCNKGW+esHcbcVoA=;
 b=xUirwq/tQAtyqz971BYYGBHkix8XX9HQGJwYJQHJzcw58q99aqTCAt/htL7VRmboAeEhRJ1uS705rpaEQzLxJyRP947YuC6KR4MQiins7R1RqGfJvDqEdNgQO/olhc1uqgDSa8Z32YyJUOXM7Ap+6bigFbeiZvDk5oCJ5xNCqZY=
Received: from CY4PR11MB1624.namprd11.prod.outlook.com (2603:10b6:910:8::12)
 by CY4PR1101MB2359.namprd11.prod.outlook.com (2603:10b6:903:bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24; Thu, 24 Jun
 2021 00:10:12 +0000
Received: from CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467]) by CY4PR11MB1624.namprd11.prod.outlook.com
 ([fe80::d9f8:2dbd:528:b467%4]) with mapi id 15.20.4242.023; Thu, 24 Jun 2021
 00:10:12 +0000
From:   "Desouza, Ederson" <ederson.desouza@intel.com>
To:     "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "saeed@kernel.org" <saeed@kernel.org>,
        "Lobakin, Alexandr" <alexandr.lobakin@intel.com>,
        "Swiatkowski, Michal" <michal.swiatkowski@intel.com>,
        "brouer@redhat.com" <brouer@redhat.com>
Subject: A look into XDP hints for AF_XDP
Thread-Topic: A look into XDP hints for AF_XDP
Thread-Index: AQHXaI1NCoqWOcnh50mPov3W8E+84w==
Date:   Thu, 24 Jun 2021 00:10:12 +0000
Message-ID: <be4583429b45d618e592585c35eed5f1c113ed68.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.2 
authentication-results: xdp-project.net; dkim=none (message not signed)
 header.d=none;xdp-project.net; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2601:1c0:6902:8a70:9eb6:d0ff:fed2:f387]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d272d44-4bd6-4777-34ce-08d936a46faf
x-ms-traffictypediagnostic: CY4PR1101MB2359:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB23595CFC794877F6A9B6BB0DF6079@CY4PR1101MB2359.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FErdm3Gf4SbRHex7x0Hmabln95MKmwRF9/kxacsrqkdSHV6sA9tOzxbA151VetejTluNtxlBh15vFnY32cTr29hPbjDH1jO1rgsziwql3nAoGpxRmDe3yJAAk9AQPLwsIFNnZ99JxRBIM4by6e9t2VbhICbnvuyZyDxHhO9DSN6iEzqJjXTGtA/C1muN+ouahLWXUaq76Zy+0ovwI4MbU/tfj1Y0XyJDL3L7zoc2d7a/0PTNdTfWkdkiRLe+nMpigbAs/C70pBq+UuTq3RP2RBSVmt/fcwycyGDWC2QFkKBWqHjJVqKNwc9mIEjXsX85j2vz5xyyRia/IcFE5XcW8gYzPfUiRBORP6w2Yuciajp8Fl/b3pY6YhqRyikmj+d89lo/ZsmwJmO8K4LUVuO6/9QYnvMhamsYIlBHMGVQQpZt1X1ceq9OizTcJjZbJl/UwIgVrW6EQHpbahwtx/2bekA3JqzBIX6AmvtYFQlvWSFI/XOeMB+hL4XclbtaNxFxhwy9WOOwYPTzrUh8PtEUwjui4MhqdImZ0nFTKe/d/ZgfnnIoKFi/ijFL+AV6ZJholdyU8UhXqEY2MxMlRIyOMIF2eGfGZ4wR8s4GsD2iLEB2dPiS6vLZb2encuLbXHThcYYms921CQgVYCGhc1ysPqcSqkdbGYE+ziyvYXwf9wF/N5Vsu4MTzmU2FaHI/9bpr9137ECNUTCx+dTso3Se46rN0TR0B8HMwI22Xi00aN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(86362001)(110136005)(316002)(6506007)(38100700002)(122000001)(6512007)(83380400001)(186003)(2616005)(5660300002)(8936002)(76116006)(36756003)(66946007)(478600001)(66446008)(64756008)(66556008)(8676002)(4326008)(91956017)(966005)(66476007)(6486002)(54906003)(71200400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUM1Z21JbXJ4ejE5SGFxMUNBTzJ4c2w5Wkd4RXFSTnpGWWFYTS9mSXRmWnIw?=
 =?utf-8?B?ek04alN2cVdqcnNEalhMellidTVMUEFCMHd0dzk5NkVnOVVJcDVpamYvWDRy?=
 =?utf-8?B?NVpzSmdTNnUwVHZpQk5XQlk5SGs4YTN5aXhtRWg5cGUxcWhMRDNiQTJiN1dS?=
 =?utf-8?B?a1YrTFMzQ2g2TEo3eGhvSGE0TjJWaE9WS1BGazIrdkRsL1VzZkhueVMydG95?=
 =?utf-8?B?NEF3TTltWVE5TFBhUG1Oa3lENm1UQ0lPby9YSFMzdFF2RStJSGU1VXpRQXp0?=
 =?utf-8?B?MUxqTll4aDlmN21YUU5VZ0VpbkU4c2k1L3BMcVVmbys2d0F4NUZKRHcxcmty?=
 =?utf-8?B?amt4SWxJUHVxbnlucFJCdTNUQUEzWFEyZUxlNVh6RmM4blVqNms1V0JlWEhI?=
 =?utf-8?B?SUJ6a25Vb01LSmVCRE5SeUlYUWt2Sk1kaUZHMVE3RG54M3M0YVpPS2FQVVpU?=
 =?utf-8?B?c1lJMzZDTUlBTkdLS3d2dWpLd2J1M1BYQW54NkRJdDltb3B0NnJZOUlHNnly?=
 =?utf-8?B?K2hDTHFVbzJxVE45aHg1amtaTHkra3pBaEg2cVBWOEU5eVo5TVlWazlFK1V1?=
 =?utf-8?B?Mjlxdy8xSGE2LzlBalFSYVBEQ0QwakN3V0tuZThSS2dhd0IvU05NRjMrVkJK?=
 =?utf-8?B?VHU1MlNHV3QvQnBJREl0Z0JkanZ6NVdheXFqUW1yemtUSEZIcUkvTHVJVDBp?=
 =?utf-8?B?UlZkY0FaY3hGSXduUTI2TUtaeFRFakFsN1laSkZNR0xrVkZZKzFNOFNVeU91?=
 =?utf-8?B?dnlmUkZGTUplM2VHUEdEUTcrc3hJaWhkZ1BGdUo5VGxSM0FseVl3REhaUGI0?=
 =?utf-8?B?V0krUFlHNE9jd2NsckpUTkgzZDRVVERUUWxxcHArT3J2QTZNNmtOY1k0OXpm?=
 =?utf-8?B?WGdnWW42YzNFRlFwaHZ3VkUraldrcGE5ck53NFh0NFd0R2IwWmxZbDB3UXFw?=
 =?utf-8?B?Z0dNb1puL3dpTnd3OFpjSjd5NG02a2VSd2NBYmZUUW5jdk9Kb2dOZ1JqUlRI?=
 =?utf-8?B?N1d0OG40THYwMUQyNGhYRGxHMm5tKzZjMnk3dFI2TnNJZjQrNWlWcC81R0xB?=
 =?utf-8?B?QlhxMHFVdkI1ZVNpMm96U2p3T2ZWM0szcXNmL2hzNjJuVDd3U25VbFlOMWZ0?=
 =?utf-8?B?V2VrR1pleitQRWgvcHg4NEJPcDJBZklPcGdxSTEwOXpNa1lvUDZvQ2hZeGJU?=
 =?utf-8?B?WFFPWEYyUUlsczh4SitYNGtUTUJNU0pJVDBGUmNaYmp5VFNlMThXWnYzS2Fi?=
 =?utf-8?B?Ujc5MndEQ214WnN6MDIrQnE1RFJhUVZ3eHQwRW4xc0VCQ2RMYXJPcWtlRUFp?=
 =?utf-8?B?KzFlUldOMEtJNldFeHJia1JlYkNxSkxMQm1LYXc0aG12NTFyNm00WEQzRnhl?=
 =?utf-8?B?WmF1R3c2WEk4WTJGOTZEZU83ak9jUlBRWnRvalNGdW5XMTJISW9vZnNGRzhz?=
 =?utf-8?B?emprbyt2Qy9kSVdONms3WkdRdmcxWmpLeHdGekJSOGxVUWR5SGlNVkxCdWVI?=
 =?utf-8?B?Zkg1b1ArRnhFYk5aU1YzSEh3KzlXODVCZHZlREJEQTYwMnBtUnFIL2R6N0FH?=
 =?utf-8?B?dUYzLzFzb09ZK0JRNnQ0ZHd4SzZ0aUl5WnhsTkFKcWIvZWJpcGpCR0pHVGJr?=
 =?utf-8?B?Yk9UN01BRWJrc2JhMjlQeFhKUUlpeXdRZWRodDBZbDJ5WFRGOFBxaFl0M1Zy?=
 =?utf-8?B?c0VVdDBDaFlCOVorMm9OY3NZS2s3bjJ2aERUcExFUkpiTmZ1ZDd2NXRhdUlu?=
 =?utf-8?B?NThDT3JvSk4xTTZBaml0RXBtYUI3M2ptTFJDbWI0dStYRGZ4RXgwRExUMjcz?=
 =?utf-8?B?Y2owdGdxVGJiS3N5a1l2VEVUblRKRHJOOHRSd1RUejFIdzFWZUxYS3RZWm1q?=
 =?utf-8?Q?lBCIx3UzBRP8c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <41EBB532C5991A4E8ABBB68C084D1C86@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d272d44-4bd6-4777-34ce-08d936a46faf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2021 00:10:12.5045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aERa/zAnrSB8KdXfcnHovUgzmAHdzmNMEfRxjXFb3s/QT43xEoA+VaHPGqAqZdmZB98kNYVAfJAfi//VPKXk0Wtajw3IUmCF3gMye9dXaNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2359
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGksDQoNCkZvbGxvd2luZyBjdXJyZW50IGRpc2N1c3Npb25zIGFyb3VuZCBYRFAgaGludHMsIGl0
J3MgY2xlYXIgdGhhdA0KY3VycmVudGx5IHRoZSBmb2N1cyBpcyBvbiBCUEYgYXBwbGljYXRpb25z
LiBCdXQgbXkgaW50ZXJlc3QgaXMgaW4gdGhlDQpBRl9YRFAgc2lkZSBvZiB0aGluZ3MgLSB1c2Vy
IHNwYWNlIGFwcGxpY2F0aW9ucy4NCg0KSW4gdGhlcmUsIHRoZXJlJ3Mgbm90IG11Y2ggaGVscCBm
cm9tIEJQRiBDTy1SRSAtIHdobydzIGdvaW5nIHRvIHJld3JpdGUNCnVzZXIgc3BhY2Ugc3RydWN0
cywgYWZ0ZXIgYWxsPyBTbywgSSBkZWNpZGVkIHRvIGdpdmUgYSB0cnkgYXQgYQ0KcG9zc2libGUg
aW1wbGVtZW50YXRpb24sIHVzaW5nIGlnYyBkcml2ZXIgYXMgSSdtIG1vcmUgdXNlZCB0byBpdCwg
YW5kDQpjb21lIGhlcmUgYXNrIHNvbWUgcXVlc3Rpb25zIGFib3V0IGl0Lg0KDQpGb3IgdGhlIGN1
cmlvdXMsIGhlcmUncyBteSBicmFuY2ggd2l0aCBjdXJyZW50IHdvcms6DQoNCmh0dHBzOi8vZ2l0
aHViLmNvbS9lZGVyc29uZGlzb3V6YS9saW51eC90cmVlL3hkcC1oaW50cw0KDQpJdCdzIG9uIHRv
cCBvZiBBbGV4YW5kciBMb2Jha2luIGFuZCBNaWNoYWwgU3dpYXRrb3dza2kgd29yayAtIGJ1dCBJ
DQpkZWNpZGVkIHRvIGluY29ycG9yYXRlIHNvbWUgb2YgdGhlIENPLVJFIHJlbGF0ZWQgZmVlZGJh
Y2ssIHNvIEkgY291bGQNCmhhdmUgc29tZXRoaW5nIHRoYXQgYWxzbyB3b3JrcyB3aXRoIEJQRiBh
cHBsaWNhdGlvbnMuIFBsZWFzZSBub3QgdGhhdA0KSSdtIG5vdCB0cnlpbmcgdG8ganVtcCBhaGVh
ZCBvZiB0aGVtIGluIGluY29ycG9yYXRpbmcgdGhlIGZlZWRiYWNrIC0NCnByb2JhYmx5IHRoZXkg
aGF2ZSBzb21ldGhpbmcgbW9yZSByb2J1c3QgaGVyZSAtIGJ1dCBpZiB5b3Ugc2VlIHNvbWUNCnZh
bHVlIGluIG15IHBhdGNoZXMsIGZlZWwgZnJlZSB0byByZXVzZS9pbmNvcnBvcmF0ZSB0aGVtIChp
ZiB0aGV5IGFyZQ0KanVzdCBhbiBleGFtcGxlIG9mIHdoYXQgbm90IHRvIGRvLCBpdCdzIHN0aWxs
IGFuIGV4YW1wbGUgPUQgKS4NCkkgYWxzbyBhZGRlZCBzb21lIFhEUCBaQyBwYXRjaGVzIGZvciBp
Z2MgdGhhdCBhcmUgc3RpbGwgbW92aW5nIHRvDQptYWlubGluZS4NCg0KSW4gdGhlcmUsIEkgYmFz
aWNhbGx5IGRlZmluZWQgYSBzYW1wbGUgb2YgImdlbmVyaWMgaGludHMiLCB0aGF0IGlzDQpiYXNp
Y2FsbHkgYW4gc3RydWN0IHdpdGggY29tbW9uIGhpbnRzLCBzdWNoIGFzIFJYIGFuZCBUWCB0aW1l
c3RhbXAsDQpoYXNoLCBldGMuIEkgYWxzbyBpbmNsdWRlZCB0d28gbW9yZSBtZW1iZXJzIHRvIHRo
YXQgc3RydWN0OiBmaWVsZF9tYXANCmFuZCBleHRlbnNpb25faWQuIFRoZSBmaXJzdCwgc2hvd3Mg
d2hpY2ggbWVtYmVycyBhcmUgYWN0dWFsbHkgdmFsaWQgaW4NCnRoZSBkYXRhLCB0aGUgc2Vjb25k
IGlzIGFuIGFyYml0cmFyeSBpZCB0aGF0IGRyaXZlcnMgY2FuIHVzZSB0byBzYXkNCiJ0aGVyZSdz
IGV4dHJhIGRhdGEiIGJleW9uZCB0aGUgZ2VuZXJpYyBtZW1iZXJzLCBhbmQgaG93IHRvIGludGVy
cHJldA0Kd2hhdCdzIHRoZXJlIGlzIGRyaXZlciBzcGVjaWZpYy4gQSBCVEYgaXMgYWxzbyBjcmVh
dGVkIHRvIHJlcHJlc2VudA0KdGhpcyBzdHJ1Y3QsIGFuZCByZWdpc3RlcmluZyBpcyBkb25lIHRo
ZSBzYW1lIHdheSBTYWVlZCdzIHBhdGNoIGRpZC4NCg0KVXNlciBzcGFjZSBkZXZlbG9wZXJzIHRo
YXQgbmVlZCB0byBnZXQgdGhlIHN0cnVjdCBjYW4gdXNlIHNvbWV0aGluZw0KbGlrZSB0byBnZXQg
aXQgZnJvbSB0aGUgZHJpdmVyOg0KDQogICMgdG9vbHMvYnBmL2JwZnRvb2wvYnBmdG9vbCBuZXQg
eGRwIHNob3cNCiAgeGRwOg0KICBlbnA2czAoNSkgbWRfYnRmX2lkKDYwKSBtZF9idGZfZW5hYmxl
ZCgxKQ0KDQpBbmQgdXNlIHRoZSBidGZfaWQgdG8gZ2V0IHRoZSBzdHJ1Y3Q6DQoNCiAgIyBicGZ0
b29sIGJ0ZiBkdW1wIGZpbGUgL3N5cy9rZXJuZWwvYnRmL2lnYyBmb3JtYXQgYw0KDQpDdXJyZW50
bHkgdGhvdWdoLCB0aGF0J3MgYmFkIC0gYXMgaW4gdGhpcyBjYXNlIHRoZSBzdHJ1Y3QgaGFzIG5v
IHR5cGVzLA0Kb25seSB0aGUgZmllbGQgbmFtZXMuIFdoeT8NCg0KV2l0aCB0aGUgZHJpdmVyIHNw
ZWNpZmljIHN0cnVjdCAob3IgYnkgdXNpbmcgdGhlIGdlbmVyaWMgb25lLCBpZiBubw0Kc3BlY2lm
aWMgZmllbGRzIGFyZSBuZWVkZWQpLCB0aGUgYXBwbGljYXRpb24gY2FuIHRoZW4gYWNjZXNzIHRo
ZSBYRFANCmZyYW1lIG1ldGFkYXRhLiBJJ3ZlIGFsc28gYWRkZWQgc29tZSBoZWxwZXJzIHRvIGFp
ZCBnZXR0aW5nIHRoZQ0KbWV0YWRhdGEuDQoNCkkgYWRkZWQgc29tZSBleGFtcGxlcyBvbiBob3cg
dG8gdXNlIHRob3NlICh0aGV5IG1heSBiZSB0b28gc2ltcGxpc3RpYyksDQpzbyBpdCdzIHBvc3Np
YmxlIHRvIGdldCBhIGZlZWwgb24gaG93IHRoaXMgQVBJIG1pZ2h0IHdvcmsuDQoNCk15IGdvYWxz
IGZvciB0aGlzIGVtYWlsIGFyZSB0byBjaGVjayBpZiB0aGlzIGFwcHJvYWNoIGlzIHZhbGlkIGFu
ZCB3aGF0DQpwaXRmYWxscyBjYW4geW91IHNlZS4gSSBkaWRuJ3Qgc2VuZCBhIHBhdGNoIHNlcmll
cyB5ZXQgdG8gbm90IGp1bXANCmFoZWFkIEFsZXhhbmRyIGFuZCBNaWNoYWwgd29yayAoSSBjYW4g
cmViYXNlIG9uIHRvcCBvZiB0aGVpciB3b3JrDQpsYXRlcikgYW5kIGJlY2F1c2UgdGhlIGlnYyBS
WCBhbmQgVFggdGltZXN0YW1wIGltcGxlbWVudGF0aW9uIEknbSB1c2luZw0KdG8gcHJvdmlkZSBt
b3JlIHJlYWwgbG9va2luZyBkYXRhIGlzIG5vdCB5ZXQgY29tcGxldGUuDQoNCkFub3RoZXIgZ29h
bCBpcyB0byBlbnN1cmUgdGhhdCBBRl9YRFAgc2lkZSBpcyBub3QgZm9yZ290dGVuIGluIHRoZSBY
RFANCmhpbnRzIGRpc2N1c3Npb24gPUQNCg0KTmF0dXJhbGx5LCBpZiBzb21lb25lIGZpbmRzIGFu
eSBpc3N1ZSB0cnlpbmcgdGhvc2UgcGF0Y2hlcywgcGxlYXNlIGxldA0KbWUga25vdyENCg0KVGhh
bmtzIQ0KLS0gDQpFZGVyc29uIGRlIFNvdXphDQo=
