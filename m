Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99A96623108
	for <lists+bpf@lfdr.de>; Wed,  9 Nov 2022 18:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKIRFy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Nov 2022 12:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiKIRFi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Nov 2022 12:05:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488811147
        for <bpf@vger.kernel.org>; Wed,  9 Nov 2022 09:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668013535; x=1699549535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+03nDt5FxJqnUk+6ahYZ+cDXnNZxQrPdd0b81hCok7A=;
  b=mrHSXjSRh8mVVEyA4E8Jf+3lU2c5PvgvMrIyvrW+jrs/0O9CjXrs7s3v
   SQWJJGd0E+IaYwl0n1K1c6sWdim/Cve/OHXlyx4/SYtBjFEMUSjJlrPw8
   DC64wOTQ/Xqi0piCsjMvs4zvUYJpD5g/r/4If7q6egUtNWdk29Pnebtyo
   41NCvKFn4gH4O9ldBo17lXSRBGM+35DoGh/ocCL9JmYWgh+LILqhlbU5Y
   dz4hpTBPXC+HTWkTmmfYLZL3ZcgeJRHHeS6NFR/7AEdlB/ATcLHBzj4me
   BbMjgz8SN4WUAui0kitkvhBPUaCZnqp6Y1x/3h6+2GBLOXqkdB6rAKmM6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337774138"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="337774138"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 09:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="636814385"
X-IronPort-AV: E=Sophos;i="5.96,151,1665471600"; 
   d="scan'208";a="636814385"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2022 09:04:35 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 09:04:34 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 9 Nov 2022 09:04:34 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 9 Nov 2022 09:04:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXJx4WMK8/2ND39uTK3baKkyAvq/zCnpgwcEDUI9RV78/roFahNhO1aB9fKarERw3bWpzOVYPTrGpHTDh2QaBMbcG99FqjcgZjQsPaI9VaEikioqob9/ArHBkLpU+DPpqYAFzvLvTcBxz+AiP4aoDuS8mf4+Xoud1Z0T2xK2Yaz8Vcxldo9Mvanm/23j56kw47KtSBxPn9GSaw8DIS1UN7WAl6qCwvHgJ5A8KDOCBr5YY9JmCM1eEUfKth5Su6/tdVrSkeZqnGSyRvxc3Cv9F98wn3nOdi9P3kVDO4snglJSo6rk9ZDpTnBNXd8n8+jntwL2U5+YOB7ChIgDV+OeGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+03nDt5FxJqnUk+6ahYZ+cDXnNZxQrPdd0b81hCok7A=;
 b=DhGkjoFLL/YGJBNftUxQ4GfiaTpJD0vIxN3akwOcejptdvPjemvnA1adb4T+Dswl0H6pAw0mwoo0rFlwBjUWN3kkKl0Q2srIFyaRUyBfPyvsjMPb3pWh5e3xfyrw8RfbqEJOdKn2tkzviWPSwJSdE9kjVE4wpSQyAcacJ6Pk6OQE2ZUta2P6D6am0GHVdl2iHlPjpTT01DwdMPtNpSfH5LurMPa8VDh3N434q+lM/epOIU0OphbUpCiNPshUZBwrs+3XDQ7ec1kYYs+zslHbQ4lJwWNIZdku1OrFvyaUt0OIvTAqV9J4is46/mc4JuF5A2ICAZzRkDH9Qen1qHIfRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5239.namprd11.prod.outlook.com (2603:10b6:208:31a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 17:04:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Wed, 9 Nov 2022
 17:04:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC6405DmAgABab4CAATUtAIAAYNkA
Date:   Wed, 9 Nov 2022 17:04:25 +0000
Message-ID: <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <Y2o9Iz30A3Nruqs4@kernel.org>
         <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
         <Y2uMWvmiPlaNXlZz@kernel.org>
In-Reply-To: <Y2uMWvmiPlaNXlZz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|BL1PR11MB5239:EE_
x-ms-office365-filtering-correlation-id: 403480c5-9290-4f83-843c-08dac27474bc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NA1ZJL5NZo9FINa7cJNeP061QLG7T0ymB3KfzJj9oDnZji0KfjvgKUr4jbBkl+oVA6G5ZV74aoJ0Mu+A855snoXssgfE4+QrkHxp7S6/V8DOeuHDL809gI/2Q/tI9TkzmUeRHmPklgOgCbokO4md4TcGuDFEuSJYNhtLIsGKhRV4KMKYFuyl0rzU6p1PU/Az8JRZIT8MzjtJo6K8XY7LnEjZ/oKczDFfu4aunxYGR7QxqQDb2pOIspLXLTFzGjucbOp5THONVrM0nZAuWwzDSvn7DTEH4j+zwD78H/AWJWngVj/P3hor5CnlBmsvIhHd3VpIKxdsWD5Wc0lKBF29D6ubdW+f7dPBwV7gjlj8I1ixxblzat2HHcuxMtEWTdNuk/g9PpxYDH9FDFf6GWo8N1usBNji4f+KSIHAn5xQ+PPaTaf9Y7Sa1KOnIKYCwY0tuz1dQzj+leqNYj2EIA7b1YfQmTUMCtDJ03DBBZcChoz8BR6jsxaYa5fPxFm4+u0mZnJxWykiH+5zK7ABrCkvvvSju0qjXNQjWDXPKELwo7qmAYFaNOrTvWQ0aLrgwE6u2EUXaHPf90PdJk9Hxl05LgmjvD3htzQDlhfj1PT/2kq1hfmBX3pITNz3xlvGfo71wQlZTAtOXJyqXVBqD73mxZQCVtGdxQ2ftXlulPKL5RcLa1ZbPJd9rhXGUIxW3kvdBlpO0kRTSLu+i08hg7jbbK0Y0JLbZPSnde8ge3tRaqHGzqf90v6lKRK6GDKuQ0nywkwvsFq4AKK9hGHBXHDNZc2xGceC86GcazMc8Sv67Io=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199015)(83380400001)(86362001)(122000001)(82960400001)(38100700002)(38070700005)(6486002)(478600001)(107886003)(5660300002)(91956017)(71200400001)(8936002)(76116006)(66946007)(66556008)(64756008)(4326008)(8676002)(66476007)(66446008)(316002)(54906003)(2616005)(6916009)(41300700001)(26005)(6512007)(186003)(6506007)(2906002)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlVrSHpMRFY5dEJQd0tIU2lwVHVXRlBabTc4T2lOV01QZjFWTUlybjhvS3Nt?=
 =?utf-8?B?NlVBUUM4ek9nWVQvd2VFSGQ3anR5cy9rUGFicFVROXFtRzdGcnZJYkwrVWdH?=
 =?utf-8?B?YnhyOXZncGU2bnQ0bzI5UTltMXFmRE5HWmNuWVNNUjlUQTlmR08zMXBEZUZW?=
 =?utf-8?B?RFg3bU0vKzBDVlFNdzQ3dGhJMnpKNzZuQTVxUG56d1JYcmp6MTdadmpIUFVM?=
 =?utf-8?B?RmJ0VDJhR3RWanllV1pIaHlJd1phQlZTS29mNy9DekpRMmVKMkxQSGNtZFpX?=
 =?utf-8?B?cGRydmJycXY0ekkxUllxaTVNUjZEYk1tOGlwaVF6N0lGdVhRU0NodmxhdHNa?=
 =?utf-8?B?ZkRFU3VMSFk1QmZwWk1PQzNLRXBuVzlUZGcwNlNYTTIySVdzTkVjZTMyT0li?=
 =?utf-8?B?d0Rxc0NMZS8rSkE1TWh5bFJJVmZKV3Z5T2t0MEJ0ZDJVNmh1UGlrUVU0YXN5?=
 =?utf-8?B?aFBtV0lIbVpSOXdaTE14SExzMUJRUFo5MlBpSlZSTXhEVDBpUFBaNnB0K1dX?=
 =?utf-8?B?WmljSVRPZG1pOW0zYm5wbCswVVZTQnNoTnI4WFFHQmV5V1ZlTklKelVjVUsr?=
 =?utf-8?B?eS8rVmh5UERCUUlFQld6UFhKRjJzQVNzYmk2L0gvaEx6OWR6YW1QaHZGTk5r?=
 =?utf-8?B?MURlTnJpMllzbVgvNGNGLzh0REdETnRHZzYzSm5EdXE2TXh0YlhUZGZNS3J6?=
 =?utf-8?B?ZE9ESG9aZ1Bod3lvYldXaVB5YUpSTzUzQXRQeklVSFEvWDI0WHdNTFB5WEhI?=
 =?utf-8?B?L0VRbzNBdXA0OENESS8xUmpaRWRIMWhETGMvSHA1cU5KMVhVZTQrczNrWE1J?=
 =?utf-8?B?Uy9OemlIN0pYT0ppK0RyQUQ2OHhIa2o1MnNPV1BzL3Y1THVhZG9jVkpITGFw?=
 =?utf-8?B?QklDOTc3cGFqV0x5SGkzZlVKb1FiOXFWWnZQSnV6YWZJZUk0NkYrNUhFdUdh?=
 =?utf-8?B?Mkdra3ltaW53aVUxcjloWGR6Y2trbXFPRjZ1VFl0bERmR3lGenpZQXRUNjUz?=
 =?utf-8?B?VDdVN0N5MjR6UlBtSDZiZU53ei91ZTNDYTdOQ3FPanYvWEFHb1hkSDZkcFpC?=
 =?utf-8?B?RmxhbnpIcThuaDJUeTFveUR0VEwxNW1IdEtrUnpJQ1Fmdytsc2ErVVdORExa?=
 =?utf-8?B?Y0o2L0V1MXdCdUoraGxGNmo2a291amg4TVNhQzQycDN1dkY4eFBKK0pZUUZK?=
 =?utf-8?B?VG9kTHl3WDlseXZ5WWtTQU1ZQllCSVBuaGpORlZ0eE81M0JlZzV3dDA0ckow?=
 =?utf-8?B?cGRlcjBBdHNMY3EvZllKOXlpb2lIMlh1T1JML2lBSnJJNk9UZS9TU0JnK0lX?=
 =?utf-8?B?L1Y4S3BiVGZoT0JENmNrZUZIZU83WEJWaTgzTC9oZzF6aU4waGJZL0JVYkxa?=
 =?utf-8?B?UWxlUloybWY0RW40a2VnSXNnckJpcGxHOTZYZHRseEI5Wi9LYU9aM1pyOS9N?=
 =?utf-8?B?QzhDR2Z6RWhOb2NvWEhSM3Vhdm9kNlR6dmU4UjNOMUplWFN3ZFp5ZkpsaWl2?=
 =?utf-8?B?Ylo2YWFPZ0NVVUZ5S3RTTGEyZHFoZy9YR0Uyc0x1bXdkVnd4R1JqNXVwSHRw?=
 =?utf-8?B?YytRVXdUR1lNejN1dml1djBUT0xVT09DamY1VUlFSS81K093bFg3d1loWlpk?=
 =?utf-8?B?ckhuaktkS3pQSzZXRFBXNnlZaytpVjdSU1NlU21mQTdwekNJNWRCeURRWEFH?=
 =?utf-8?B?SXYrcHd4Y3FSNE1JTXpEYjVlWEszQ1pJU3pCWXFXS0ZIbzhkdFZKSi9CYnAx?=
 =?utf-8?B?ejRrdG5tdUJVcEQxeVVLN2gwQTB0Y1I4ZkNINDJ0ZnNTSE5PWEF0WXpVLzI5?=
 =?utf-8?B?UUlGbHZVTFdPNDlOTktCNlJMTUN4LyswOHNwNUV1ZFhIUys5MHQ1RDlhRCtE?=
 =?utf-8?B?cVdJWXc4QjgzR25sOVpnaFVoRTJaTjIyQjRiRzZYY3QrYlNvS3RjbHhLZkJr?=
 =?utf-8?B?ckZxU3d5TXhLWnhPQkFFMklYQ1MwNjl3UzJKVEFaN2pGNTBjdHI0eEFTbHVn?=
 =?utf-8?B?anZSbzRvR0pJYjUvaVJUMlo1S1lsZjJac0Uxd2I1eGVSWktqOExLdzhsWjRS?=
 =?utf-8?B?VzZYcC9VK2NNakdDMEo0YTJnc3o3eVlKUW9mNUppV2JKRS84SFlTekY4YXQr?=
 =?utf-8?B?NC91bW1pUUd5dlZGaWRHQmVxcjJwemFha2wraWg4TWV1UTVVNzN3ZmUwcEhS?=
 =?utf-8?Q?klwVD5WaZUTDaJN09GDDltU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F541C4ABAEF8E94B8BA101780155ECFC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403480c5-9290-4f83-843c-08dac27474bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 17:04:25.6696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ud3Q5iYJbR4xtTsuRSVEOl9WuY/iGQyUMoIE5AdRcAfBsBEQfONqQEcrJWFFNQeywD/WHxbrYSW4632FLgqiR4u8SbZLzA9vdX5fkaBkj3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5239
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTExLTA5IGF0IDEzOjE3ICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0K
PiBPbiBUdWUsIE5vdiAwOCwgMjAyMiBhdCAwNDo1MToxMlBNICswMDAwLCBFZGdlY29tYmUsIFJp
Y2sgUCB3cm90ZToNCj4gPiBPbiBUdWUsIDIwMjItMTEtMDggYXQgMTM6MjcgKzAyMDAsIE1pa2Ug
UmFwb3BvcnQgd3JvdGU6DQo+ID4gPiA+IEJhc2VkIG9uIG91ciBleHBlcmltZW50cyBbNV0sIHdl
IG1lYXN1cmVkIDAuNSUgcGVyZm9ybWFuY2UNCj4gPiA+ID4gaW1wcm92ZW1lbnQNCj4gPiA+ID4g
ZnJvbSBicGZfcHJvZ19wYWNrLiBUaGlzIHBhdGNoc2V0IGZ1cnRoZXIgYm9vc3RzIHRoZQ0KPiA+
ID4gPiBpbXByb3ZlbWVudCB0bw0KPiA+ID4gPiAwLjclLg0KPiA+ID4gPiBUaGUgZGlmZmVyZW5j
ZSBpcyBiZWNhdXNlIGJwZl9wcm9nX3BhY2sgdXNlcyA1MTJ4IDRrQiBwYWdlcw0KPiA+ID4gPiBp
bnN0ZWFkDQo+ID4gPiA+IG9mDQo+ID4gPiA+IDF4IDJNQiBwYWdlLCBicGZfcHJvZ19wYWNrIGFz
LWlzIGRvZXNuJ3QgcmVzb2x2ZSAjMiBhYm92ZS4NCj4gPiA+ID4gDQo+ID4gPiA+IFRoaXMgcGF0
Y2hzZXQgcmVwbGFjZXMgYnBmX3Byb2dfcGFjayB3aXRoIGEgYmV0dGVyIEFQSSBhbmQNCj4gPiA+
ID4gbWFrZXMgaXQNCj4gPiA+ID4gYXZhaWxhYmxlIGZvciBvdGhlciBkeW5hbWljIGtlcm5lbCB0
ZXh0LCBzdWNoIGFzIG1vZHVsZXMsDQo+ID4gPiA+IGZ0cmFjZSwNCj4gPiA+ID4ga3Byb2JlLg0K
PiA+ID4gDQo+ID4gPiAgIA0KPiA+ID4gVGhlIHByb3Bvc2VkIGV4ZWNtZW1fYWxsb2MoKSBsb29r
cyB0byBtZSB2ZXJ5IG11Y2ggdGFpbG9yZWQgZm9yDQo+ID4gPiB4ODYNCj4gPiA+IHRvIGJlDQo+
ID4gPiB1c2VkIGFzIGEgcmVwbGFjZW1lbnQgZm9yIG1vZHVsZV9hbGxvYygpLiBTb21lIGFyY2hp
dGVjdHVyZXMgaGF2ZQ0KPiA+ID4gbW9kdWxlX2FsbG9jKCkgdGhhdCBpcyBxdWl0ZSBkaWZmZXJl
bnQgZnJvbSB0aGUgZGVmYXVsdCBvciB4ODYNCj4gPiA+IHZlcnNpb24sIHNvDQo+ID4gPiBJJ2Qg
ZXhwZWN0IGF0IGxlYXN0IHNvbWUgZXhwbGFuYXRpb24gaG93IG1vZHVsZXMgZXRjIGNhbiB1c2UN
Cj4gPiA+IGV4ZWNtZW1fDQo+ID4gPiBBUElzDQo+ID4gPiB3aXRob3V0IGJyZWFraW5nICF4ODYg
YXJjaGl0ZWN0dXJlcy4NCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgaXMgZmFpciwgYnV0IEkgdGhp
bmsgd2Ugc2hvdWxkIGFzayBhc2sgb3Vyc2VsdmVzIC0gaG93DQo+ID4gbXVjaCBzaG91bGQgd2Ug
ZG8gaW4gb25lIHN0ZXA/DQo+IA0KPiBJIHRoaW5rIHRoYXQgYXQgbGVhc3Qgd2UgbmVlZCBhbiBl
dmlkZW5jZSB0aGF0IGV4ZWNtZW1fYWxsb2MoKSBldGMNCj4gY2FuIGJlDQo+IGFjdHVhbGx5IHVz
ZWQgYnkgbW9kdWxlcy9mdHJhY2Uva3Byb2Jlcy4gTHVpcyBzYWlkIHRoYXQgUkZDIHYyIGRpZG4n
dA0KPiB3b3JrDQo+IGZvciBoaW0gYXQgYWxsLCBzbyBoYXZpbmcgYSBjb3JlIE1NIEFQSSBmb3Ig
Y29kZSBhbGxvY2F0aW9uIHRoYXQgb25seQ0KPiB3b3Jrcw0KPiB3aXRoIEJQRiBvbiB4ODYgc2Vl
bXMgbm90IHJpZ2h0IHRvIG1lLg0KDQpUaG9zZSBtb2R1bGVzIGNoYW5nZXMgd291bGRuJ3Qgd29y
ayBvbiBub24teDg2IGVpdGhlci4gTW9zdCBvZiBtb2R1bGVzDQppcyBjcm9zcy1hcmNoLCBzbyB0
aGlzIGtpbmQgb2YgaGFzIHRvIHdvcmsgZm9yIG5vbi10ZXh0X3Bva2UoKSBvcg0KbW9kdWxlcyBu
ZWVkcyB0byBiZSByZWZhY3RvcmVkLg0KDQo+ICANCj4gPiBGb3Igbm9uLXRleHRfcG9rZSgpIGFy
Y2hpdGVjdHVyZXMsIHRoZSB3YXkgeW91IGNhbiBtYWtlIGl0IHdvcmsgaXMNCj4gPiBoYXZlDQo+
ID4gdGhlIEFQSSBsb29rIGxpa2U6DQo+ID4gZXhlY21lbV9hbGxvYygpICA8LSBEb2VzIHRoZSBh
bGxvY2F0aW9uLCBidXQgbmVjZXNzYXJpbHkgdXNhYmxlIHlldA0KPiA+IGV4ZWNtZW1fd3JpdGUo
KSAgPC0gTG9hZHMgdGhlIG1hcHBpbmcsIGRvZXNuJ3Qgd29yayBhZnRlciBmaW5pc2goKQ0KPiA+
IGV4ZWNtZW1fZmluaXNoKCkgPC0gTWFrZXMgdGhlIG1hcHBpbmcgbGl2ZSAobG9hZGVkLCBleGVj
dXRhYmxlLA0KPiA+IHJlYWR5KQ0KPiA+IA0KPiA+IFNvIGZvciB0ZXh0X3Bva2UoKToNCj4gPiBl
eGVjbWVtX2FsbG9jKCkgIDwtIHJlc2VydmVzIHRoZSBtYXBwaW5nDQo+ID4gZXhlY21lbV93cml0
ZSgpICA8LSB0ZXh0X3Bva2VzKCkgdG8gdGhlIG1hcHBpbmcNCj4gPiBleGVjbWVtX2ZpbmlzaCgp
IDwtIGRvZXMgbm90aGluZw0KPiA+IA0KPiA+IEFuZCBub24tdGV4dF9wb2tlKCk6DQo+ID4gZXhl
Y21lbV9hbGxvYygpICA8LSBBbGxvY2F0ZXMgYSByZWd1bGFyIFJXIHZtYWxsb2MgYWxsb2NhdGlv
bg0KPiA+IGV4ZWNtZW1fd3JpdGUoKSAgPC0gV3JpdGVzIG5vcm1hbGx5IHRvIGl0DQo+ID4gZXhl
Y21lbV9maW5pc2goKSA8LSBkb2VzIHNldF9tZW1vcnlfcm8oKS9zZXRfbWVtb3J5X3goKSBvbiBp
dA0KPiA+IA0KPiA+IE5vbi10ZXh0X3Bva2UoKSBvbmx5IGdldHMgdGhlIGJlbmVmaXRzIG9mIGNl
bnRyYWxpemVkIGxvZ2ljLCBidXQNCj4gPiB0aGUNCj4gPiBpbnRlcmZhY2Ugd29ya3MgZm9yIGJv
dGguIFRoaXMgaXMgcHJldHR5IG11Y2ggd2hhdCB0aGUgcGVybV9hbGxvYygpDQo+ID4gUkZDDQo+
ID4gZGlkIHRvIG1ha2UgaXQgd29yayB3aXRoIG90aGVyIGFyY2gncyBhbmQgbW9kdWxlcy4gQnV0
IHRvIGZpdCB3aXRoDQo+ID4gdGhlDQo+ID4gZXhpc3RpbmcgbW9kdWxlcyBjb2RlICh3aGljaCBp
cyBhY3R1YWxseSBzcHJlYWQgYWxsIG92ZXIpIGFuZCBhbHNvDQo+ID4gaGFuZGxlIFJPIHNlY3Rp
b25zLCBpdCBhbHNvIG5lZWRlZCBzb21lIGFkZGl0aW9uYWwgYmVsbHMgYW5kDQo+ID4gd2hpc3Rs
ZXMuDQo+IA0KPiBJJ20gbGVzcyBjb25jZXJuZWQgYWJvdXQgbm9uLXRleHRfcG9rZSgpIHBhcnQs
IGJ1dCByYXRoZXIgYWJvdXQNCj4gcmVzdHJpY3Rpb25zIHdoZXJlIGNvZGUgYW5kIGRhdGEgY2Fu
IGxpdmUgb24gZGlmZmVyZW50IGFyY2hpdGVjdHVyZXMNCj4gYW5kDQo+IHdoZXRoZXIgdGhlc2Ug
cmVzdHJpY3Rpb25zIHdvbid0IGxlYWQgdG8gaW5hYmlsaXR5IHRvIHVzZSB0aGUNCj4gY2VudHJh
bGl6ZWQNCj4gbG9naWMgb24sIHNheSwgYXJtNjQgYW5kIHBvd2VycGMuDQo+IA0KPiBGb3IgaW5z
dGFuY2UsIGlmIHdlIHVzZSBleGVjbWVtX2FsbG9jKCkgZm9yIG1vZHVsZXMsIGl0IG1lYW5zIHRo
YXQNCj4gZGF0YQ0KPiBzZWN0aW9ucyBzaG91bGQgYmUgYWxsb2NhdGVkIHNlcGFyYXRlbHkgd2l0
aCBwbGFpbiB2bWFsbG9jKCkuIFdpbGwNCj4gdGhpcw0KPiB3b3JrIHVuaXZlcnNhbGx5PyBPciB0
aGlzIHdpbGwgcmVxdWlyZSBzcGVjaWFsIGNhcmUgd2l0aCBhZGRpdGlvbmFsDQo+IGNvbXBsZXhp
dHkgaW4gdGhlIG1vZHVsZXMgY29kZT8NCg0KR29vZCBwb2ludC4gSWYgdGhlIG1vZHVsZSBkYXRh
IHdhcyBzdGlsbCBpbiB0aGUgbW9kdWxlcyByYW5nZSwgSSB3b3VsZA0KaG9wZSBpdCB3b3VsZCBz
dGlsbCB3b3JrLCBidXQgdGhlcmUgYXJlIGEgbG90IG9mIGFyY2hpdGVjdHVyZXMgdG8NCmNoZWNr
LiBTb21lIG1pZ2h0IGNhcmUgaWYgdGhlIGRhdGEgaXMgcmVhbGx5IGNsb3NlIHRvIHRoZSB0ZXh0
LiBJJ20gbm90DQpzdXJlLg0KDQpUaGUgcGVybV9hbGxvYygpIHN0dWZmIGRpZCBzb21lIGhhY2tz
IHRvIGZvcmNlIHRoZSBhbGxvY2F0aW9ucyBjbG9zZSB0bw0KZWFjaCBvdGhlciBvdXQgb2YgcGFy
YW5vaWEgYWJvdXQgdGhpcy4gQmFzaWNhbGx5IHN0YXJ0ZWQgd2l0aCBvbmUNCmFsbG9jYXRpb24s
IGJ1dCB0aGVuIHRyYWNrZWQgdGhlIHBpZWNlcyBzZXBhcmF0ZWx5IHNvIGFyY2gncyBjb3VsZA0K
c2VwYXJhdGUgdGhlbSBpZiB0aGV5IHdhbnRlZC4gQnV0IEkgd29uZGVyZWQgaWYgaXQgd2FzIHJl
YWxseSBuZWVkZWQuDQoNCj4gIA0KPiA+IFNvIHRoZSBxdWVzdGlvbiBJJ20gdHJ5aW5nIHRvIGFz
ayBpcywgaG93IG11Y2ggc2hvdWxkIHdlIHRhcmdldCBmb3INCj4gPiB0aGUNCj4gPiBuZXh0IHN0
ZXA/IEkgZmlyc3QgdGhvdWdodCB0aGF0IHRoaXMgZnVuY3Rpb25hbGl0eSB3YXMgc28NCj4gPiBp
bnRlcnR3aW5lZCwNCj4gPiBpdCB3b3VsZCBiZSB0b28gaGFyZCB0byBkbyBpdGVyYXRpdmVseS4g
U28gaWYgd2Ugd2FudCB0byB0cnkNCj4gPiBpdGVyYXRpdmVseSwgSSdtIG9rIGlmIGl0IGRvZXNu
J3Qgc29sdmUgZXZlcnl0aGluZy4NCj4gDQo+ICANCj4gV2l0aCBleGVjbWVtX2FsbG9jKCkgYXMg
dGhlIGZpcnN0IHN0ZXAgSSdtIGZhaWxpbmcgdG8gc2VlIHRoZSBsYXJnZQ0KPiBwaWN0dXJlLiBJ
ZiB3ZSB3YW50IHRvIHVzZSBpdCBmb3IgbW9kdWxlcywgaG93IHdpbGwgd2UgYWxsb2NhdGUgUk8N
Cj4gZGF0YT8NCg0KU2ltaWxhciB0byB0aGUgcGVybV9hbGxvYygpIGhhY2tzPw0KDQo+IHdpdGgg
c2ltaWxhciByb2RhdGFfYWxsb2MoKSB0aGF0IHVzZXMgeWV0IGFub3RoZXIgdHJlZSBpbiB2bWFs
bG9jPyANCg0KSXQgd291bGQgaGF2ZSB0byBncm91cCB0aGVtIHRvZ2V0aGVyIGF0IGxlYXN0LiBO
b3Qgc3VyZSBpZiBpdCBuZWVkcyBhDQpzZXBhcmF0ZSB0cmVlIG9yIG5vdC4gSSB3b3VsZCB0aGlu
ayBwZXJtaXNzaW9uIGZsYWdzIHdvdWxkIGJlIGJldHRlcg0KdGhhbiBhIG5ldyBmdW5jdGlvbiBm
b3IgZWFjaCBtZW1vcnkgdHlwZS4NCg0KPiBIb3cgdGhlIGNhY2hpbmcgb2YgbGFyZ2UgcGFnZXMg
aW4gdm1hbGxvYyBjYW4gYmUgbWFkZSB1c2VmdWwgZm9yIHVzZQ0KPiBjYXNlcw0KPiBsaWtlIHNl
Y3JldG1lbSBhbmQgUEtTPw0KDQpUaGlzIHBhcnQgaXMgZWFzeSBJIHRoaW5rLiBJZiB3ZSBoYWQg
YW4gdW5tYXBwZWQgcGFnZSBhbGxvY2F0b3IgaXQNCmNvdWxkIGp1c3QgZmVlZCB0aGlzLiBEbyB5
b3UgaGF2ZSBhbnkgaWRlYSB3aGVuIHlvdSBtaWdodCBwaWNrIHVwIHRoYXQNCnN0dWZmIGFnYWlu
Pw0KDQpUbyBhbnN3ZXIgbXkgb3duIHF1ZXN0aW9uLCBJIHRoaW5rIGEgZ29vZCBmaXJzdCBzdGVw
IHdvdWxkIGJlIHRvIG1ha2UNCnRoZSBpbnRlcmZhY2UgYWxzbyB3b3JrIGZvciBub24tdGV4dF9w
b2tlKCkgc28gaXQgY291bGQgcmVhbGx5IGJlIGNyb3NzDQphcmNoLCB0aGVuIHVzZSBpdCBmb3Ig
ZXZlcnl0aGluZyBleGNlcHQgbW9kdWxlcy4gVGhlIGJlbmVmaXQgdG8gdGhlDQpvdGhlciBhcmNo
J3MgYXQgdGhhdCBwb2ludCBpcyBjZW50cmFsaXplZCBoYW5kbGluZyBvZiBsb2FkaW5nIHRleHQu
IA0K
