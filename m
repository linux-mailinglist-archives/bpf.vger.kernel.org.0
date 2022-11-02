Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2B6170A2
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 23:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKBWYh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 18:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbiKBWYg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 18:24:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD9510C2
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 15:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667427875; x=1698963875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4Qn3SGtIh/VlYTildDnlYPa4B3qNu+nr58hdO0yUyEU=;
  b=jNIjJZzf65ov6VPwvViQl5goilFHdxAjJBddPOgo1BnJT5a6dOFzCNle
   87WBcz4DqQoGj1vCldEtAYohcLXz5B9u/ImmiMuOIUbFpV60cIL+/9FPa
   r8+L8jjFIPF4Jp3Hk6cNfVruVz+wai56eRapBUb6/TI+498e5rgbyUr3T
   nGa1exvYfhNTHlbUxMCpJYziz8bRTTVZmmu2g6Ub74ydE5xu8u2eyNN49
   dX/naDxKWZXLZyku/X+sYaI/WLceKMpwDOuM3plc2buWejUl+TFslHINK
   ttvZDsg1/MIgYG5xmnPT+8C1BmQW6Cx7K728MaWr4SKMQo+htAQ2Gx6tC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307148604"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307148604"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 15:24:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="723722793"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="723722793"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Nov 2022 15:24:31 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:24:25 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 15:24:25 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 15:24:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H3RxbjxLhXLFI3lAFHJoIzuaMD5k1G9KtvfvQ66VAenDllyHymlzCQW84MgsrGGOvhgWNFe5Y0mvO+yJNX8/S9BIz7KQ6PMcpAah3J6XDYYnBN/XB244F70g3LPObf63exP5bc5fDyui9KnHYP9zQBp3e3ZFp5Wk0ZDuqHIMAURsOKcvFiRk4xJLOxPFlIAAdRgHu6pJEIRLDldcUURHiX/Pb1D1a1bbk7nfFSbWYJCTDO9o3HcVoIi7Fo/f/vpt906hudHTttqRvjSiTbQFvC/8PS3S6lgmTteosxxkYuWKBctUaPVNNQWiv9bXIpQFvh0UGkcHu39X4C39TmRqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Qn3SGtIh/VlYTildDnlYPa4B3qNu+nr58hdO0yUyEU=;
 b=lk00Nv/m2ekarsWvnsEzAWM4sO53t9LADGof+8xkksPck1gvNMqMMtkn7XsI/Iknjdm7Ewfe9h5eGpa61ta87ZQGmrvEpLf+tojItiDBP7UaOH60BDacznAxkBIR1LHy2FVuHFXm2Z21M7K0OtRcTLs/s2P5XigxtOjYUUaJ7x0q3RDrucsx5CPL7gEabIPsPzZlo7CtRloIepFF8URigXCi9ZgYKr8voptf4A/dAUfNJJRvaLGTItXZCHoTRApfCmRirJf+OnzDgt6NAPkvU0uZNDcIR1VjQHA5huaxT44bYgdjCcB7gQQ/JPBRVxqtTE8O4bdsQm3rylRtVs82Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB7470.namprd11.prod.outlook.com (2603:10b6:510:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Wed, 2 Nov
 2022 22:24:22 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 22:24:22 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH bpf-next v1 RESEND 5/5] x86: use register_text_tail_vm
Thread-Topic: [PATCH bpf-next v1 RESEND 5/5] x86: use register_text_tail_vm
Thread-Index: AQHY7XfLfV3ntfkyQEeKgLbE11xpNq4sOMWA
Date:   Wed, 2 Nov 2022 22:24:22 +0000
Message-ID: <cc240325744f6b9237c433fb74aac28f34a3a8cf.camel@intel.com>
References: <20221031222541.1773452-1-song@kernel.org>
         <20221031222541.1773452-6-song@kernel.org>
In-Reply-To: <20221031222541.1773452-6-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH0PR11MB7470:EE_
x-ms-office365-filtering-correlation-id: 249787d4-1208-44e5-e737-08dabd20fdf2
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 049H42Nis7Vsa8aKdSL4dGrwW+ri8jLXirF1tkKRvwguK4E80PKXEAVlvUoE/z6t45okI2PT/18wVbYtHP3ZnjIJo9CoESRyfeLz0wDZ4LdrhTxNyeOBnFjiJDJNYRo4eFxa8zRRSuc7DlTc/4VdS4HP37RfPKI2A3d1a69rmyCxC1iEmqkvpeb8bXaKibEx+//UCJCVmZUNB/dbU48+UfIRr90DUMNcd7y9ITdmfTQ8CLpbktT6SfnxTPPiRzqJbWhKZXc3YrJGUfKeqjkkREBwxF6qcd827O2aEjjr11hXvNM+iRMcGrkSXv3OxnuG7/IbC8tvIdLkxvIyOlIQyvMY0z/f6s718VQvXOozlnyWdGSklcpoHZ9ooT0ep/qVBCko4rdfT3k4LAsOVQOU/gf3xc28hDmBb4+j5P54YzPFLjgD/t8OC+8kt7V6/eVUbpH+X5iTB2ugJLXT3mXTVZtRCvc7UBjDCwgW5Ii/o32QUV4MzB+UARGQygmxfSjSFsXzlmP+T10vui4Px80wR62NQ7OUF0KZ54L40rP/6ulIOp/fqeVXMEU0BXCUmAc9ksVOAMh/PL7i+FdxtKhWrFDi9uv5OSyHKpdZtTtL7qfJogB4rCpqY8+fkRRIlQ31Yrtd5u6yhxnchktLcTwNVHFWuGX1Fvb9I/rhCyzJLIc3spbC0SVi6P7hTOtj7haYDWFcD6tXCC0zgGKF7Z0c//XkVpEp+3TQh5cTRe3QoWUNEGHjjegVjx4tkN0cvRfQ1gkO+25wOmYqD45TvQ7LpmK+hQoHr0e51SXWTDrjfhU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(136003)(346002)(396003)(39860400002)(451199015)(8676002)(4326008)(86362001)(91956017)(38070700005)(76116006)(66946007)(66476007)(110136005)(8936002)(64756008)(5660300002)(66446008)(66556008)(316002)(478600001)(38100700002)(36756003)(54906003)(122000001)(82960400001)(41300700001)(6486002)(83380400001)(6506007)(107886003)(26005)(71200400001)(2906002)(4001150100001)(2616005)(186003)(6512007)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWw1aTViWFluSUVmcldXd2Y5K1gyL3pVU3g4TCtLQU1wY1BEQmx4KytRZHlo?=
 =?utf-8?B?dW43R1lhcHMvOVpuVGlLYjVoU2ZNaGdvN2dZb1dkWTNFYWR2ZjI5Q3J1YzVD?=
 =?utf-8?B?R2lvRTFTQTdXRFROeUdFdnM5MmVHOWJlN3BMNkRqTHh6MTVsMzJQam4wMXJV?=
 =?utf-8?B?QzUzUHhUblozRFk1Lzd5SEtnOFhiSUxBdlpCckRUZXN1eGF5K2g4ZEZLL0xi?=
 =?utf-8?B?enlJazhUOTMvdzhQZFpqUWhSN016KzBWc0RhV2NyT2hWL01xa29YQzZRTHpI?=
 =?utf-8?B?L0F2cHpwb2pGc2lGY01FREh2VnpqNlJPNFVhcGphYStVYmN6a0QxTHBmZSs2?=
 =?utf-8?B?d1NtSnBVQ1RGdkVmQko4TW52SEF4QlI0TndsZHFML1Z6VXFXa0lZV1FCMjFn?=
 =?utf-8?B?a01peitTeVZRTkRiMU4zRGJKcXV0MUFYTkRlUjRLbS8vUTI3NTBZMzc3M3Zh?=
 =?utf-8?B?VHRKL2hsTzQxWjd2YVQ2Y2htdHZTRXFlWWZ3ZkZHRlAwWnZwViszeXMyQkJG?=
 =?utf-8?B?dk5KdG55ZHRiV2dJNWxqbXB0Ym05NjZlZFNoVURYNU0xWmdvb2NSWGg1NHoz?=
 =?utf-8?B?cFpWaWF1eEpSOE0ySnFOcms3Q1dYdENSZUh5aTNxVmptcWI3Q3FFUVQ5VVNN?=
 =?utf-8?B?L1RINHJrL0lxY1Rka2ZBcTQ3UDNRbSt3Y3hxbHpndmFleTYrTGlRUjBqNFlB?=
 =?utf-8?B?ckZWeUhZL203Yk9YSkJXRm5BK0RRVDZhZHFuN2JLdXR3NDUwU1l3cXBLWER5?=
 =?utf-8?B?ODhmUnIzNUNVcCtReUpZcVdKOEtRZk5oVnM0Y1hRelZXTjJ4RElEbS8zVDlJ?=
 =?utf-8?B?MkpKYmZsaDNQcDFZQkNPRFFmRElJOFZvSnp0ZUowUXRzZy90eFg2cUUrYlp5?=
 =?utf-8?B?VmFnalFyRnZyUnk3VFB3bzlwM1pRMXZ4bTdEZFB5SCtPMEtPLzVyMHVya0Jl?=
 =?utf-8?B?Yi9IVkpmWXVuN0lFRVVSNHVXT2NPYndMOFloSUJIeWY4T2xWWVJVVFhCNTRN?=
 =?utf-8?B?bGdJZVd1OXdlVjJFcUhQdzhldkdCQUdBeGsvQlE0VTFWL3RWZlVyLzJ4Uy82?=
 =?utf-8?B?Qm9rVm1KYVZxY09ONDhYaGdHK01SQ3VUQTZZMkNmSmVIUkl6WTFVdlFNU1ZC?=
 =?utf-8?B?UVVyZ2lUK24rZjBvQTBES3F4RzdzMDY5azduWExvRnE3MllGOVAwajZTVVM2?=
 =?utf-8?B?c1lJb1lOUkNEWjR0MjVxck1sdFZ4dnlVcXZrQUJ0bjVkTUJreGdtVWNKeVoz?=
 =?utf-8?B?ajgreVRmS2hNREYzMWJoVHVSb1A3cmpnOTJsR1FsbkFBekhHNTRMYXVhaTUx?=
 =?utf-8?B?aFBtVTR1ZkMwT053akMwVjdUdi9SMzhBS3R3U1hPSXlnZ2svc2pKREhnazQz?=
 =?utf-8?B?THpDTUt1VzlnUk91QVVGQWU2ZzhnSTRuQk5CSm45VlNZcTA1NUYybExzMWRC?=
 =?utf-8?B?MGYvSkxzTFZsWDRmZmQ1d2FuVGpmWUtLNXlHUUt0bXY5YW85UW5ick9XR1hu?=
 =?utf-8?B?S3dueGwvb29rU1JJSjV2S1NCVUZJRDFIenNoWGZFdmdyNDlpVHJpTUY1NEhV?=
 =?utf-8?B?R3BZS1hhRE1tKzVNcHV4RXRwT21tbnBuS1FjVXN1M0craXQyN0NwSzNpR0Nw?=
 =?utf-8?B?TExoakgyYVlYaUFuc1dkSUl5VVhvUUQrU21Wb2lWOVFacXhGc2NkYkVlSVVy?=
 =?utf-8?B?MExiSExZYmdKNGNDWi9VY2tXdjdzUzU1TFM4cEU1dW9LUnZqRTdjbFJhSmpM?=
 =?utf-8?B?NnVYb0hrbWJWdGo1RHkrK1hkMi9EbVZRR1NzdGsvVURJbldaakdDdmx4RlFH?=
 =?utf-8?B?a1VDYWZVY3NISGtBZjM5ajU5TTF6L2Z0VnpSOVkrZncvMEZtNFpwU1VsbENt?=
 =?utf-8?B?Sm5Ma2dlQkFRSUVFZnV1cGYrVDVrcDIxM0JXNXVpK3ZTWkp1REUyTVpQV1NP?=
 =?utf-8?B?bDl2ZVE4TlFUSk5kb3ZnT3hTNTZMeXg2YmVYelVVN3I4UFRoVkUzaUxIMkRy?=
 =?utf-8?B?bEoyQkl1S2tFY0VCd250dlQ3VmFBVkhTRnN2ZFNsVWNkM2JkYjA2eE8vQW1X?=
 =?utf-8?B?eWFJVzZmbjdycnJWeUZ0aEdxcktYNVB2RExHYnYvWmF4NEVqQ2ZMRjczTHBa?=
 =?utf-8?B?UGExS3BMOWlzQXh3dlNpQVBMclNXOW9jNjljVlJka1VVckVVcG11enRueFZG?=
 =?utf-8?Q?20qVPZei7r3jx08rk+CA75Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <301BCCC614905B46BE875BC9438FE757@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249787d4-1208-44e5-e737-08dabd20fdf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 22:24:22.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZdvDeWmTxqWJGHuuWUz4HKOHGvsmxaFVBqX+JrdJLUS8SzPVevgh3JnXv/SLUU6Rk287nnSOJDrBjPOmAwEjCZn9fDyCXC09eEs/H1RCORk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7470
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDE1OjI1IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gQWxs
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
YWJsZXMva2VybmVsDQo+IDB4ZmZmZmZmZmY4MjIwMDAwMC0NCj4gMHhmZmZmZmZmZjgyNDAwMDAw
ICAgICAyTSAgICAgcm8gICBQU0UgICAgICAgICB4ICBwbWQNCj4gDQo+IGZmZmZmZmZmODIyMDAw
MDAtZmZmZmZmZmY4MjQwMDAwMCBpcyBhIDJNQiBwYWdlLCBzZXJ2aW5nIGtlcm5lbCB0ZXh0LA0K
PiBhbmQNCj4gYnBmIHByb2dyYW1zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU29uZyBMaXUgPHNv
bmdAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0
X3R5cGVzLmggfCAxICsNCj4gIGFyY2gveDg2L21tL2luaXRfNjQuYyAgICAgICAgICAgICAgICAg
ICB8IDQgKysrLQ0KPiAgaW5jbHVkZS9saW51eC92bWFsbG9jLmggICAgICAgICAgICAgICAgIHwg
NCArKysrDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjRfdHlw
ZXMuaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfNjRfdHlwZXMuaA0KPiBpbmRl
eCAwNGYzNjA2M2FkNTQuLmMwZjljY2ViMTA5YSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vcGd0YWJsZV82NF90eXBlcy5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNt
L3BndGFibGVfNjRfdHlwZXMuaA0KPiBAQCAtMTAxLDYgKzEwMSw3IEBAIGV4dGVybiB1bnNpZ25l
ZCBpbnQgcHRyc19wZXJfcDRkOw0KPiAgI2RlZmluZSBQVURfTUFTSwkofihQVURfU0laRSAtIDEp
KQ0KPiAgI2RlZmluZSBQR0RJUl9TSVpFCShfQUMoMSwgVUwpIDw8IFBHRElSX1NISUZUKQ0KPiAg
I2RlZmluZSBQR0RJUl9NQVNLCSh+KFBHRElSX1NJWkUgLSAxKSkNCj4gKyNkZWZpbmUgUE1EX0FM
SUdOKHgpCSgoKHVuc2lnbmVkIGxvbmcpKHgpICsgKFBNRF9TSVpFIC0gMSkpICYNCj4gUE1EX01B
U0spDQo+ICANCj4gIC8qDQo+ICAgKiBTZWUgRG9jdW1lbnRhdGlvbi94ODYveDg2XzY0L21tLnJz
dCBmb3IgYSBkZXNjcmlwdGlvbiBvZiB0aGUNCj4gbWVtb3J5IG1hcC4NCj4gZGlmZiAtLWdpdCBh
L2FyY2gveDg2L21tL2luaXRfNjQuYyBiL2FyY2gveDg2L21tL2luaXRfNjQuYw0KPiBpbmRleCAz
ZjA0MGM2ZTVkMTMuLjViNDJmYzBjNjA5OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvbW0vaW5p
dF82NC5jDQo+ICsrKyBiL2FyY2gveDg2L21tL2luaXRfNjQuYw0KPiBAQCAtMTM3Myw3ICsxMzcz
LDcgQEAgdm9pZCBtYXJrX3JvZGF0YV9ybyh2b2lkKQ0KPiAgCXVuc2lnbmVkIGxvbmcgc3RhcnQg
PSBQRk5fQUxJR04oX3RleHQpOw0KPiAgCXVuc2lnbmVkIGxvbmcgcm9kYXRhX3N0YXJ0ID0gUEZO
X0FMSUdOKF9fc3RhcnRfcm9kYXRhKTsNCj4gIAl1bnNpZ25lZCBsb25nIGVuZCA9ICh1bnNpZ25l
ZCBsb25nKV9fZW5kX3JvZGF0YV9ocGFnZV9hbGlnbjsNCj4gLQl1bnNpZ25lZCBsb25nIHRleHRf
ZW5kID0gUEZOX0FMSUdOKF9ldGV4dCk7DQo+ICsJdW5zaWduZWQgbG9uZyB0ZXh0X2VuZCA9IFBN
RF9BTElHTihfZXRleHQpOw0KPiAgCXVuc2lnbmVkIGxvbmcgcm9kYXRhX2VuZCA9IFBGTl9BTElH
TihfX2VuZF9yb2RhdGEpOw0KPiAgCXVuc2lnbmVkIGxvbmcgYWxsX2VuZDsNCg0KQ2hlY2sgb3V0
IGlzX2VycmF0YTkzKCkuIFJpZ2h0IG5vdyBpdCBhc3N1bWVzIGFsbCB0ZXh0IGlzIGJldHdlZW4g
dGV4dC0NCmV0ZXh0IGFuZCBNT0RVTEVTX1ZBRERSLU1PRFVMRVNfRU5ELiBJdCdzIGEgcXVpdGUg
b2xkIGVycmF0YSwgYnV0IGl0DQp3b3VsZCBiZSBuaWNlIGlmIHdlIGhhZCBhIGlzX3RleHRfYWRk
cigpIGhlbHBlciBvciBzb21ldGhpbmcuIFRvIGhlbHANCmtlZXAgdHJhY2sgb2YgdGhlIHBsYWNl
cyB3aGVyZSB0ZXh0IG1pZ2h0IHBvcCB1cC4NCg0KU3BlYWtpbmcgb2Ygd2hpY2gsIGl0IG1pZ2h0
IGJlIG5pY2UgdG8gdXBkYXRlDQpEb2N1bWVudGF0aW9uL3g4Ni94ODZfNjQvbW0ucnN0IHdpdGgg
c29tZSBoaW50cyB0aGF0IHRoaXMgYXJlYSBleGlzdHMuDQoNCj4gIA0KPiBAQCAtMTQxNCw2ICsx
NDE0LDggQEAgdm9pZCBtYXJrX3JvZGF0YV9ybyh2b2lkKQ0KPiAgCQkJCSh2b2lkICopcm9kYXRh
X2VuZCwgKHZvaWQgKilfc2RhdGEpOw0KPiAgDQo+ICAJZGVidWdfY2hlY2t3eCgpOw0KPiArCXJl
Z2lzdGVyX3RleHRfdGFpbF92bShQRk5fQUxJR04oKHVuc2lnbmVkIGxvbmcpX2V0ZXh0KSwNCj4g
KwkJCSAgICAgIFBNRF9BTElHTigodW5zaWduZWQgbG9uZylfZXRleHQpKTsNCj4gIH0NCj4gIA0K
PiAgaW50IGtlcm5fYWRkcl92YWxpZCh1bnNpZ25lZCBsb25nIGFkZHIpDQo+IGRpZmYgLS1naXQg
YS9pbmNsdWRlL2xpbnV4L3ZtYWxsb2MuaCBiL2luY2x1ZGUvbGludXgvdm1hbGxvYy5oDQo+IGlu
ZGV4IDliMjA0MjMxM2MxMi4uNzM2NWNmOWM0ZTdmIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3ZtYWxsb2MuaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZtYWxsb2MuaA0KPiBAQCAtMTMy
LDExICsxMzIsMTUgQEAgZXh0ZXJuIHZvaWQgdm1fdW5tYXBfYWxpYXNlcyh2b2lkKTsNCj4gICNp
ZmRlZiBDT05GSUdfTU1VDQo+ICBleHRlcm4gdm9pZCBfX2luaXQgdm1hbGxvY19pbml0KHZvaWQp
Ow0KPiAgZXh0ZXJuIHVuc2lnbmVkIGxvbmcgdm1hbGxvY19ucl9wYWdlcyh2b2lkKTsNCj4gK3Zv
aWQgcmVnaXN0ZXJfdGV4dF90YWlsX3ZtKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVkIGxv
bmcgZW5kKTsNCj4gICNlbHNlDQo+ICBzdGF0aWMgaW5saW5lIHZvaWQgdm1hbGxvY19pbml0KHZv
aWQpDQo+ICB7DQo+ICB9DQo+ICBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgdm1hbGxvY19u
cl9wYWdlcyh2b2lkKSB7IHJldHVybiAwOyB9DQo+ICt2b2lkIHJlZ2lzdGVyX3RleHRfdGFpbF92
bSh1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBsb25nIGVuZCkNCj4gK3sNCj4gK30NCj4g
ICNlbmRpZg0KDQpUaGlzIGxvb2tzIGxpa2UgaXQgc2hvdWxkIGJlIGluIHRoZSBwcmV2aW91cyBw
YXRjaC4NCg0KPiAgDQo+ICBleHRlcm4gdm9pZCAqdm1hbGxvYyh1bnNpZ25lZCBsb25nIHNpemUp
IF9fYWxsb2Nfc2l6ZSgxKTsNCg==
