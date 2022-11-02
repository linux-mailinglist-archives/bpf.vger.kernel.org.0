Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0626170AD
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 23:30:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbiKBWaF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiKBWaE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 18:30:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4A959B
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 15:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667428203; x=1698964203;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JGGB4qoITLNQE0N9Y6euwsy8ZMPAxMRfCToSilPUJDg=;
  b=Lb5lwljn0dnbXnmUyUa54GyB6pWucQoz8LK7u4zbTAAoafqvsabD7Lpy
   DnzcFF8bWHbh+TaRnOtd3cM7ycLESZjXCLTAiqtZs1HYFBOV5zylLdv3r
   n9FfQbO3I3u2s11jyNM63sClw8DhyxcDzzV6spFTyPweItq4N+hAi3RAL
   o+62Ml7hndk+u8LyNQpTohjk3vEUyVLzrPShlcgQZ5d7oXNF0VYmxz+uU
   1/Ll9VTbLkCI6RRn+78as7q+bxWNO6HRlfTdk9oYKooHn6Dsv8xK5jjQP
   STsB1MiRvN9r8/ZPsFqxaeCmxpQKXRgxnqwPgAeU5c6VftjW20nqYYFD0
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307149709"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307149709"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 15:30:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="809440965"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="809440965"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 02 Nov 2022 15:30:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:30:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 15:29:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 2 Nov 2022 15:29:59 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 2 Nov 2022 15:29:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRhnwqzKyh/FNaumPqldBw4DXPH8ukdfRGsU1gyS2CPe5D45/0Qe1ZpWWVWFQtZLB2qZ/8WCltTNooCVnWwl9IJ2ORtDOFAer6BmITDQGURmRRZTMvI5fJP8U6SPdQka+jsRyCUD0R7JTbN8x46DRigEF2MWenHgprIrkXYrRVmejgEe3SxB64alfr+iID1TV+F9oljDwM2282BeZ0Z/Z0nmXecr92V2Jq79/XquJ2C2n1dT3Bs1o8EBAyEZkgkgRWUfvvjkeZTWWrs7iLNj9nYkwJEF3+WgHmUvc6jDm6ROGCN9vf+gFTdUx9qG40K4DgCVVi0BPPgIZser4bJjrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGGB4qoITLNQE0N9Y6euwsy8ZMPAxMRfCToSilPUJDg=;
 b=JC6zy3OK0TE43O6u9bMaSZlVJ+ROXOovV1HK34fTpJTTfF7Djo0z1PSRVIRACGsFrJExMGqf3zKFsGXhCmeA1JfvirqoT2WNJgPXf69NdDGyXpy0QAomkx0iou73bNBYq2Hgv5umo57TgxINjPE9OiUKQM73KK1bnNdLCHECBZQl8+Q72pmVN938aJnxAKayq4Hwy0eN1sFb3u2NpTcVj9Pnj4exEh+DO1KMIsq66X0R7vnzR+HmbmfBv7D2nU8k/ZuDzwHuWdOPnrVFvmECKylJ+Zl4ZcuJX8EJvjb/70j+ZrNPndzNGX1FSaa7JfcL3r3KLjLa1gU0jDFPHAWfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SA0PR11MB4607.namprd11.prod.outlook.com (2603:10b6:806:9b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 2 Nov
 2022 22:29:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5769.019; Wed, 2 Nov 2022
 22:29:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
Subject: Re: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF
 programs
Thread-Topic: [PATCH bpf-next v1 RESEND 0/5] vmalloc_exec for modules and BPF
 programs
Thread-Index: AQHY7XfCX9HTqPYJAEOMf9j6GwTq5a4sOk+A
Date:   Wed, 2 Nov 2022 22:29:51 +0000
Message-ID: <14dfef4f077b3c9ebce2526ba2cfebd2c151a036.camel@intel.com>
References: <20221031222541.1773452-1-song@kernel.org>
In-Reply-To: <20221031222541.1773452-1-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SA0PR11MB4607:EE_
x-ms-office365-filtering-correlation-id: 1827e66d-b73c-468d-ed8a-08dabd21c260
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hbuypg0rftyd6Hng9NSMjEaiDuL38cOA8Fs8vnwdnOdHOrJrjKvc+pWL9JxW1IPE8KKnbPIKUJkxA9BjRcF3WxyLta2qKXtu9GXq85EtLlt1a2jcLFIsJ9MSs8sVuJLYnH2oEGeXX/4RzaHUo+MMP5baUPTKCXkgCuukY4QKy3IaAse+/Rmwlj4UjdywRtwaUupmGDCCVWGivF8S7kE7OFs+fnRqqXUMlZANhZGAcg8racLg3244izVBXNuaD0mLK4huWztnelgIn/mqnOFLh3PLZ4i8eGN3/u6mq1FxEuzh+O+ISis+wRF2ZycH3wDR1DrvufoO5Jztkc/qyzjUMuLRiMLNAtMobKNXe+vqTh09NnOE21DXKwdjPrumdlyu+4BpZIEx9wkbpIyTC8gnm4odyAjZiQa0RFzOlwU4U7ayYXfxqXljQXrTlFiaGUWo0MyPld2KBYze0DtSJQASAj/rxFlDRHVYODcgVT1K/te/yAImU24PfNIwuZmtHUFzGEYfU61fJb2DFaR7tlninTX5SKmXFIVZG6qk1W2UqB4Sxtb1/tSJX2b4/0yxihpMiO1V/bc6TD1zfPCx6qN5GRqTYkoN1fbbupBcxHs06jln2iRXVxjoMGL6ONvOsLFKkxtUBBJaxDYan3faQPt3WwstNXZdiXdtUjdBvmGNQJZMJtuUFiU9mCwiUQtAOtPUcCYBzX+UDFoFcocnl4jm8qcHGMtM3ICc3x9svrTTplN4mwxZv2N57zVqP6D0VeTZRS4qZijYDoeTx9jW3SrF2H5G3ql7n9cPivdBvmseG8k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(376002)(396003)(366004)(136003)(451199015)(83380400001)(38070700005)(86362001)(5660300002)(82960400001)(122000001)(38100700002)(2906002)(4001150100001)(4326008)(66946007)(8676002)(66476007)(66556008)(64756008)(8936002)(41300700001)(66446008)(76116006)(6506007)(26005)(6512007)(186003)(107886003)(2616005)(316002)(54906003)(110136005)(91956017)(478600001)(6486002)(71200400001)(36756003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjB6UmpHMmdnNEg4RFh2WUZuY08yaUYwNVZIMkVaRlJla2ZzaDhlSmpYbTJX?=
 =?utf-8?B?dGtJamNPWEpVQVlnV1I4Wm9WL3poUnFIc1EvUlo2THVidzBDUXp4MkdEcUZi?=
 =?utf-8?B?UFB1WDB0MzhaMnkycXJQSVFkYTlKOW0ycEZlb2tIRTgya0t0Y0xGYmNoNm1Y?=
 =?utf-8?B?V0xGRlp3ZTJLK3ExVk5ZbHhWYTVXeVRWU1NyT1IxVXVtd2lCVGFaVld3R2VH?=
 =?utf-8?B?Q1VjYnBLcVhLWVNzSWZHNk1yeldpbFYvajlyQWdHMHJIbkJIZ0tSaS8vVXBW?=
 =?utf-8?B?UFhIVWZUKzJnR2ZDaEU0dldmR21JU1hkT01pWDFVMFdkL2JPWFExSVh3SGVO?=
 =?utf-8?B?RndydEhKcTZvbGgxWjZKNUhPS2c0bDRhSmZCbVhNaTV4RTNYdDg1ZGh1Unlv?=
 =?utf-8?B?YnVtTlcvMTRTUzNPbCs0NUZMaUZvVzBBRVdabEkvU0QycWpjOHYzaExvZTF0?=
 =?utf-8?B?SFh4ako2TTA4VzNkTzQ3eG5JaUVXdFNKVCt6S2lhWTdVUWkxcGhaWXp4Z0Jp?=
 =?utf-8?B?RlVxNzNyamt6cE9KZlpJbTU0MnM1MFZwcWJmOXEvWGVPSUFrREJYbnlRVDBy?=
 =?utf-8?B?cE5KczJWS0ZNMHRPK3Rla0twZEpzRjR2c2ZUZkJlTUV2UlBTMklkdDZlZkdR?=
 =?utf-8?B?OU9uOW1jazlHWVE5YWE3ZTNOQnhLZEZRK1MrQVVjcVJyWE0yUE0wckZJUVBt?=
 =?utf-8?B?QzJZTVQwNEgyWThwY3ZWQmNreWRoZ2R1Q1RtLzBtT1FCbzlPeEsrdy9FUkhY?=
 =?utf-8?B?LytHV2pCdm15ZEh4M2Z1cHBQVHkzQ3lHYXpZZUJSOHZnUktMQXpTVWhaa1RO?=
 =?utf-8?B?S2xUckpIWnlKU05nU2hFaEJjdU9nV2NMeHl5UHlqd0xxRWs4eDdqdWNxRGhv?=
 =?utf-8?B?akpHaVFBQXRQU0NkZE5qS0VsQmR6a2dNSkFWTG9iTk1aOFN1eGR1WGQySHZw?=
 =?utf-8?B?YW1RTVR3cG9FSkJPdE95dDNVVlc1ZDV1Nm1qcitWWjFEd3RCclFTYUJvb056?=
 =?utf-8?B?cEV1Y2ZQNkd2SjN2YW1MTW9zWEd0blpuY3B1QUIzcE1YSGtMUDdsblp0RzNx?=
 =?utf-8?B?aXJ3ajRtb1grUDdHWkU3ZDVGcDF5TWNZTVNnWXNOSko3aVVUKzJabmU5M3dz?=
 =?utf-8?B?bDlGeWsxZ2dsZmZFQjQ4SDcrRDY1ek9PcFZkNHFQTTQzS2VjSkg3eTFLb3I3?=
 =?utf-8?B?ckhOVkVzWW02dng2VU0wd3JzSDJUcU5Na2RqQmVZVGFWR05yWWdxb3pENWhD?=
 =?utf-8?B?dlF1bmJVNE5XTGg0b0QvMlAxZkJPVHdSM29QdDdHZmNadlUyTTlVZzhBQnhm?=
 =?utf-8?B?azRsVnpQa3FGRk85ekl3V2pyaGgyUXozNkVWU3BGQnBoK21hUmpSNHBiaDJL?=
 =?utf-8?B?Q1RkRUdoQ3p0SVJFbUZsWElrUjBrcUtrU0M0QkJicEJxeThrWUdpeFUwNzU2?=
 =?utf-8?B?c2N5di9DRDJUNjdJY0tnQmVOT1FrL3BTMmIzNDlhTTJVUnhUQ3NiVUxUT3Mx?=
 =?utf-8?B?TmtQaWROVVB3NUpOSmsrVzB2Y0pjdzh3YThlWWgyRVZGNTZnLytBczlXcFQr?=
 =?utf-8?B?R3F6bEZzQ0h4RmU5TGt5c2phLzBkdkdEQ2UvcU8wNkxHQmlFazBNSm56d2VS?=
 =?utf-8?B?aGxCMFJDN29CNmpYV1gwSGg3eW42UHJiWXBoNUV0RGJHVlRhWHB6dk1qUXlu?=
 =?utf-8?B?OFVZeGhKVnUvSGhmY0V0T3ZCWVBoaGZpRnNaa1Bvakw0dWpVb2NWZDl0RXpT?=
 =?utf-8?B?azg1Y3RCZ0JHQ1h0enV0K2p3MmRSdnBocTQyVDhXQUp4Qk5IYVptWHo2ZTdQ?=
 =?utf-8?B?UzNBR1NhckJaMlZrc2MzZEwwdFFpNDVvMzFUY1NPK0lleDZwaS8yVEVXUjY3?=
 =?utf-8?B?VnJFYmoyek5JTnNvTEF6SWswN1NDallRNy9tcFJsaFRGZXY2SnNhSDRHOE9o?=
 =?utf-8?B?NUJwMHRZbmg1QnNkUGJlN2VTMm9xVzgwNVE2SnFPeC90eVkzeFZXcEllNElR?=
 =?utf-8?B?ME9hTk15MWVBVWdYWmFJL1VaZHcwaDVJbVIyT3UrSHdzK3NjcFQzY0loUFNX?=
 =?utf-8?B?UVZ2amR0RzRjSjhYT3A3TGF2ajdRWTZBZktlRVdSQTE4YkQ1bjBwTjU2SXFL?=
 =?utf-8?B?Z3E0NytmTFVCYVZQMUN6TXpTa0dCaGJxK0x6WE9wdWVaOGVnU2QrZEhSN0Uy?=
 =?utf-8?Q?5P+Z/XrMKeqrYYPZdP18ie4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25DA653E9F6D614882951E5F749EF1C2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1827e66d-b73c-468d-ed8a-08dabd21c260
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 22:29:51.8892
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0NaZcjgM2vOCmBu9OswxsH3xDAfX22nIkUOrdSkNbuh+ICv43IP/VHhjgiM4yL46gCmsV0LoX7w4wCycgL0kNKZeNfnn7Bk1cP6fUAIceHg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4607
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTEwLTMxIGF0IDE1OjI1IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gVGhp
cyBzZXQgZW5hYmxlcyBicGYgcHJvZ3JhbXMgYW5kIGJwZiBkaXNwYXRjaGVycyB0byBzaGFyZSBo
dWdlIHBhZ2VzDQo+IHdpdGgNCj4gbmV3IEFQSToNCj4gICB2bWFsbG9jX2V4ZWMoKQ0KPiAgIHZm
cmVlX2V4ZWMoKQ0KPiAgIHZjb3B5X2V4ZWMoKQ0KPiANCj4gVGhlIGlkZWEgaXMgc2ltaWxhciB0
byBQZXRlcidzIHN1Z2dlc3Rpb24gaW4gWzFdLg0KPiANCj4gdm1hbGxvY19leGVjKCkgbWFuYWdl
cyBhIHNldCBvZiBQTURfU0laRSBSTytYIG1lbW9yeSwgYW5kIGFsbG9jYXRlcw0KPiB0aGVzZQ0K
PiBtZW1vcnkgdG8gaXRzIHVzZXJzLiB2ZnJlZV9leGVjKCkgaXMgdXNlZCB0byBmcmVlIG1lbW9y
eSBhbGxvY2F0ZWQgYnkNCj4gdm1hbGxvY19leGVjKCkuIHZjb3B5X2V4ZWMoKSBpcyB1c2VkIHRv
IHVwZGF0ZSBtZW1vcnkgYWxsb2NhdGVkIGJ5DQo+IHZtYWxsb2NfZXhlYygpLg0KPiANCj4gTWVt
b3J5IGFsbG9jYXRlZCBieSB2bWFsbG9jX2V4ZWMoKSBpcyBSTytYLCBzbyB0aGlzIGRvZXNub3Qg
dmlvbGF0ZQ0KPiBXXlguDQo+IFRoZSBjYWxsZXIgaGFzIHRvIHVwZGF0ZSB0aGUgY29udGVudCB3
aXRoIHRleHRfcG9rZSBsaWtlIG1lY2hhbmlzbS4NCj4gU3BlY2lmaWNhbGx5LCB2Y29weV9leGVj
KCkgaXMgcHJvdmlkZWQgdG8gdXBkYXRlIG1lbW9yeSBhbGxvY2F0ZWQgYnkNCj4gdm1hbGxvY19l
eGVjKCkuIHZjb3B5X2V4ZWMoKSBhbHNvIG1ha2VzIHN1cmUgdGhlIHVwZGF0ZSBzdGF5cyBpbiB0
aGUNCj4gYm91bmRhcnkgb2Ygb25lIGNodW5rIGFsbG9jYXRlZCBieSB2bWFsbG9jX2V4ZWMoKS4g
UGxlYXNlIHJlZmVyIHRvDQo+IHBhdGNoDQo+IDEvNSBmb3IgbW9yZSBkZXRhaWxzIG9mDQo+IA0K
PiBQYXRjaCAzLzUgdXNlcyB0aGVzZSBuZXcgQVBJcyBpbiBicGYgcHJvZ3JhbSBhbmQgYnBmIGRp
c3BhdGNoZXIuDQo+IA0KPiBQYXRjaCA0LzUgYW5kIDUvNSBhbGxvd3Mgc3RhdGljIGtlcm5lbCB0
ZXh0IChfc3RleHQgdG8gX2V0ZXh0KSB0bw0KPiBzaGFyZQ0KPiBQTURfU0laRSBwYWdlcyB3aXRo
IGR5bmFtaWMga2VybmVsIHRleHQgb24geDg2XzY0LiBUaGlzIGlzIGFjaGlldmVkDQo+IGJ5DQo+
IGFsbG9jYXRpbmcgUE1EX1NJWkUgcGFnZXMgdG8gcm91bmR1cChfZXRleHQsIFBNRF9TSVpFKSwg
YW5kIHRoZW4gdXNlDQo+IF9ldGV4dCB0byByb3VuZHVwKF9ldGV4dCwgUE1EX1NJWkUpIGZvciBk
eW5hbWljIGtlcm5lbCB0ZXh0Lg0KDQpJdCBtaWdodCBoZWxwIHRvIHNwZWxsIG91dCB3aGF0IHRo
ZSBiZW5lZml0cyBvZiB0aGlzIGFyZS4gTXkNCnVuZGVyc3RhbmRpbmcgaXMgdGhhdCAodG8gbXkg
c3VycHJpc2UpIHdlIGFjdHVhbGx5IGhhdmVuJ3Qgc2VlbiBhDQpwZXJmb3JtYW5jZSBpbXByb3Zl
bWVudCB3aXRoIHVzaW5nIDJNQiBwYWdlcyBmb3IgSklUcy4gVGhlIG1haW4NCnBlcmZvcm1hbmNl
IGJlbmVmaXQgeW91IHNhdyBvbiB5b3VyIHByZXZpb3VzIHZlcnNpb24gd2FzIGZyb20gcmVkdWNl
ZA0KZnJhZ21lbnRhdGlvbiBvZiB0aGUgZGlyZWN0IG1hcCBJSVVDLiBUaGlzIHdhcyBmcm9tIHRo
ZSBlZmZlY3Qgb2YNCnJldXNpbmcgdGhlIHNhbWUgcGFnZXMgZm9yIEpJVHMgc28gdGhhdCBuZXcg
b25lcyBkb24ndCBuZWVkIHRvIGJlDQpicm9rZW4uDQoNClRoZSBvdGhlciBiZW5lZml0IG9mIHRo
aXMgdGhpbmcgaXMgcmVkdWNlZCBzaG9vdGRvd25zLiBJdCBjYW4gbG9hZCBhDQpKSVQgd2l0aCBh
Ym91dCBvbmx5IGEgbG9jYWwgVExCIGZsdXNoIG9uIGF2ZXJhZ2UsIHdoaWNoIHNob3VsZCBoZWxw
DQpyZWFsbHkgaGlnaCBjcHUgc3lzdGVtcyBzb21lIHVua25vd24gYW1vdW50Lg0KDQo=
