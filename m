Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CC862047F
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 01:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiKHANQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 19:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHANP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 19:13:15 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C466A1F9E9
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 16:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667866393; x=1699402393;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Kdb3HT0U4trynvRhnjjvBYCnpEucqEYytiR5L1yS7PM=;
  b=gbV+T7jfVXSs83fwnb8EMo/WGDr6U3Rfi2k/NZwXynolBzJiVmHnAXfF
   3MAIR0SiRyyeLGc9i/yD7mcEGmhQSQZGYwg3YHhH4YWT3YAi+HFimFwWO
   ORguLyb3c6+RUC1S+p1ZIABUys3e4qBg17kmpCFKAz0vreHYihgSllm+4
   zniKR/apPBAK8aZK4lRoBVPwgdK70oDv4kWb5ag4O4mU6QCYJYAZ6Olrz
   qtBbI72Yx4iGu66xJDyBg6PY5t7YXZHM/C+eW1vAcZNoELiA2TSyuhMVi
   2Y8iNl1X9OjwSfIZKgCdk/8OpJW1W1Su26i03Kd7O/qmj+gD4XjuLyIk/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290278980"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290278980"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:13:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="636118725"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="636118725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 07 Nov 2022 16:13:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:13:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 7 Nov 2022 16:13:12 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 7 Nov 2022 16:13:12 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 7 Nov 2022 16:13:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPPiDdtC3ySOyEpW2egkBh5AuzL75WgTh86pxdcgxv4XTiXnC7oo6dyWI10mmVibMA6v+64E/Oyp3MDDyjdJj/ksC918YuDEct5KIzW3PFOGzqcYFCx6ffew0OZDstefogjvoFkS4JsZnm/pmFJ3q74s3ZinFiscAgSlqXc0Z2Ii//jxRj37m8UljJbwznVuyEKdQtKFIN248uWLz1E9vrewvfZYmB9ZOxgRaubEx1I37Uond7kwX5dKlJBjRxmeH6EjDcfagq3xbg9tUY/lt3g5MVAy6aVYs2G3QoS7tRae5I42CNpltP0k4nvQbE3U+PeFwBM64nb1bvcayy80zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kdb3HT0U4trynvRhnjjvBYCnpEucqEYytiR5L1yS7PM=;
 b=c4wBDJactjBRP7jhjNVAcj8azHWtKRn8BOfhYkJC73Se6E/JoG9HH0L0/r197c5kZQSyPLyR5wmj1ivLHpCYln5MxnVtUQrdONQLUYeS7G+uR3UjbREVb3BszRdJDtzoV3XgzzhlCs6N2STAJZWeQw1gNwaB4Seh/wF4q5CetvBgwSruDPwh5jKc7p3McANkNIPAdzrDkPFkpbyQar20D8FI6AdXEsLPHhkKcHZ0crEix4baw6quHVZjYhMedlH8+V0mc6zi+XN111BlEhyMG+N+YyF/782YcyCY1D1Y1or3vQyKPIDvvQ2EI6ouCnnsNa8/X7ZihWlnculBsQ7NkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH7PR11MB7146.namprd11.prod.outlook.com (2603:10b6:510:1ed::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Tue, 8 Nov
 2022 00:13:09 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 00:13:09 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC640EheAgAAFMICAAAcPgIAACXaA
Date:   Tue, 8 Nov 2022 00:13:09 +0000
Message-ID: <dc47953aa9296d1955e41f02d4ddef06036d855c.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <Y2mM3eElIBmAyLko@bombadil.infradead.org>
         <CAPhsuW4fyx+Doy8gWG1x20v7FHtQ0OeMT_XOHrneAS8aXdrjuw@mail.gmail.com>
         <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
In-Reply-To: <Y2mXI1WHuhRW7Jt+@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|PH7PR11MB7146:EE_
x-ms-office365-filtering-correlation-id: 700ae28e-886f-48e1-6921-08dac11e047c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fj6pZA4jgVXa98A/kdHsZLoww1ygtBGTazSJiDavnm0sN0Wt/rshDhVkhSg2WjUHj+UElFKy5X13drH+riacefl3PG9UjI6nNb3TnvTvVjIWvkC9aq6W2IfhhG8/mD/M5OrmYZztFJ8PlSwrTgX/uHIoOePiokUtkp0N89x3yeezZpcOfMkPfJ3NaRO/AIxgzk4YklMUGpoQqsNr4Eb/mNy9fkPs9J8YZjARCavQqBP/CwBD9aqzqpsctVYiAr9oPf+I338wLSr2k1yeAUQiv/K4svPQO1Vf4y5+MW3MSJi9Dc/hdPpL5+gS+h+RhYlDfDrtLb4RIakk1k4Mb03GVQqXw0oN1dEKKdXwvab/VdV7n/8IRinFRsAlz8aNcP6/XhHYNzFHKJfH3Qh93GXoLsyLIhymiXNvrsR5N+38UuO/xGlnx6ovobmcmLcUlX/QeJMppQVA5bkNDXuass5LGBJlOuXZmsK1B26Nqkh8KY7FvCtMU2m3zaese6PmlOn5UKfAUUoA/OyeeyUtZSszLrzGELHgcRCGjvMMbm/SGOO1qwkHWhLupKjum5/ua2F3wduccD4ZRLoIqZE3s/yi9oPpkUCHgV9qEhfA9N8sr0Ku07MkRigTTgtSH33noAS2o7sdCMAd0S8qaNqmdgBpChT3RSeqqTF/VvQmUk2JkzpB1sPOqQ0S26lBBmckOQQtiI7OJRIxo3nd6NdVZv1SE82ZLx7GTAJrWXHk2GO4fBS87PVlIwzDg7oq4PPrApJA16+jythevncCr3+KW25dScgw0bwC+C6fHTAUo19jbFE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199015)(71200400001)(38070700005)(66476007)(6486002)(122000001)(478600001)(82960400001)(110136005)(107886003)(2906002)(5660300002)(2616005)(7416002)(54906003)(316002)(91956017)(6506007)(36756003)(64756008)(8676002)(66556008)(66446008)(66946007)(76116006)(38100700002)(41300700001)(4326008)(8936002)(26005)(6512007)(86362001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aE1HeHNtVUxqU1F0OUUycWwyV2sxTnFUY0VQeVUvdTBJeFA3SmdsR3FJREwr?=
 =?utf-8?B?U1JJTHlUK0tUKzlqcHlVWC9FRFNkbkdGVXpJMm5YY1ZLMFlJa1FaUjJIMkJh?=
 =?utf-8?B?MzEzczVxQytPb0pUeDRNenlnVkZ4MnViOE9ObWlKeUlacGhqTng4RHdOeUpK?=
 =?utf-8?B?cElIOHozZ0pkL1V2OTVjM2VUN1lsdE41NXU3aE45eklLcUNYanhNN0ZZbnpV?=
 =?utf-8?B?YU9CaGVxWU1hbG1CT2hmd09FSHVTWDR0N2F6TUFXT2o4am9UNmtTWTJKQW1C?=
 =?utf-8?B?by9Nc0ZnTVBneHBtQlVoUm5rL2V0YnJBT3FmRll2eWNaMlZydzdpTzcrM2xW?=
 =?utf-8?B?NVlueUJOWFRiSmpDNGpOd3EzSUlFYTJOa05DK0pKeG1SU3Q2TGZJdTdUTm1J?=
 =?utf-8?B?ZXlqYkJ2R1pOeC9SaWw2Qnp0VGdhdkNVN043Vnk2TDFNK2VMZjhZcnlUbGpm?=
 =?utf-8?B?SE1Ib1FJcW40a2RVd0c4K0JncDV1Q1c2cDRxM1c0NXpSV01qUjc4bFFleERq?=
 =?utf-8?B?M0ZzWlQyK3pSMitBK1A0L3prdzRTOWF5anlhZythWGNwYzU0bTNEUTNxTDRY?=
 =?utf-8?B?cm9wWThPQWpWL280RWNleUlQZ3VGUkdST2lvNUN6WEg5SDRMK3ZMOFFmaWdC?=
 =?utf-8?B?dWJpdUNMM3VrWVhTR2lmSkl6ajV2bHlDclByRThPZGExWlM4STZkUjFpRUZw?=
 =?utf-8?B?aURoYm1ZbGptUktaa0k3c1p6a3g5Ync0cGdGSnJWbWpwOFg3cjhCL0JYTTRq?=
 =?utf-8?B?dXRwUzE1amlncGZOMFcvNnlva2xKSlUrVGg4dGg2SjZ4NVlpdnY5TUpRenhQ?=
 =?utf-8?B?VUo4SnR4YzJiNkM5Q1V2K0dHSUt5b0ViS1NhQUg5eWs2QXltTWZsbzQ1Sm8v?=
 =?utf-8?B?ZytWNDBLSFdLM0UvY0p6bjFlQXAreWMvQWJoR3I0bXgvLzFsZDdWTlgzcmhy?=
 =?utf-8?B?ZEZpbitOTnI4MDBCVkg5V3kxZDFrTENhWmt5Qjh3dFFrais0cjlaL1NTSXNT?=
 =?utf-8?B?YWJKT2FTOHlWYVNqMTVSNXgySWRZajBBS1JxbVU0OVNBNzRmeVVMck1kZ25U?=
 =?utf-8?B?NENOTUJUNjlpWTVFUHBmeFhVUmo4ZDc5M1B4Y2xxTjFrbkUyQ1M5dWwxTHU4?=
 =?utf-8?B?ODRodHVCMWpQM1EvQ1RFNU1tZmd6ZWpSZytmV2IrekkvcUs3L3U0R1dNVkJJ?=
 =?utf-8?B?QmpPdUJrMnVDT1h5YkNqVXYwVFlxUXc4U3l1Zk41UlRMMHhPTDg5Q1JOQVJN?=
 =?utf-8?B?MkxENUNBdzE4K2MrWUE2V0J4a3FheTRZTmVmUDQrNEs5RWdrVDBmZXh1UG1L?=
 =?utf-8?B?OW5CWGlRMGNRb0FpdzJvVVEzSFphUUY1T05KTUJyOFIreTBLd0ZuQmVHSWxN?=
 =?utf-8?B?VTR4UElXSGxXdnpVejRyVC9ER3dlNytpS0p5Zzcza0dCckFrZnlrMHZlR3BW?=
 =?utf-8?B?WExOSE92c2lrZ296MVNLQ0l2SDVvWmlQWjRMdGc0M0QzdGVUUkVFa0kvOXpO?=
 =?utf-8?B?NWVTd1JIRjZzZ0c4Y3NCVHREK1BmZk5pTXV1eXZ4Q2pkOWo4UnRIZkZkZzRu?=
 =?utf-8?B?cU4xMzN2aXFGVjhxNklMTmpqbS9NREJSMjB5NTZsbjhleTlvRjE1Ny9YYVVp?=
 =?utf-8?B?eVdENnhVT0o3aW84RkswOEo3MWtweVA0UWc0eis4eU9iQ0tyM2NTdXhRK2RT?=
 =?utf-8?B?N2tmUEwvUkROVXg3aVVFeVJ2cFFwbCs1d3JZN0hONHJMaklpL1RDbVpNYnNB?=
 =?utf-8?B?RHFDUXVGb2lsRnMwZExtazJLdmVpTmxPbkUwWjJId01YTExIYW8xQ3NRK25D?=
 =?utf-8?B?dE9TamNOdGxaelNnTjIxMEgyTFE3S3lIaWY4WUlxY0dwSW9ONmFRai9XazM1?=
 =?utf-8?B?L1BPZ1V5aGMzVWx1d25NVEZzNlU2V0RXZTFSRHp3U08vd0M2TEUxRTkzY1lk?=
 =?utf-8?B?TlBNRHFrcUhXVFZEM1NSckdnV2hLMnpEaWFHNnZTTVZCM1AySDB2WUhNdkFn?=
 =?utf-8?B?SWNZQUN6M2diajNCR2ZTNmZRdUR2MUxpcy80bUZFOTB0T2dneHNER0QwWXBu?=
 =?utf-8?B?UkhwUnk0bTZqeURhMVhVM20vbkhLcVFUTFR1TjJUQ0VOUkFRTjhFeEN5WVVi?=
 =?utf-8?B?dFo2Nm9VaWovSGp0dTlkcTU4d1U3cDZxRDFOZWgzeXFSY3h5M0pIKzNjQSs5?=
 =?utf-8?Q?x/FkHBdVoH13B2AnhgFloFQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DB519236E121840A337FEE030717D47@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ae28e-886f-48e1-6921-08dac11e047c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2022 00:13:09.4163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IneeVb0ugyb/oeztG+c0OY+TrK2+dq4EMxlglYGB7LRQND9NSEjqsIs9m9PGQMD68nKvJ3SmQtSp8tJ6Xex1ghfnygJGetYJpBLYe5L/8Fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7146
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTExLTA3IGF0IDE1OjM5IC0wODAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBPbiBNb24sIE5vdiAwNywgMjAyMiBhdCAwMzoxMzo1OVBNIC0wODAwLCBTb25nIExpdSB3
cm90ZToNCj4gPiBUaGUgYmVuY2htYXJrIHVzZWQgaGVyZSBpcyBpZGVudGljYWwgb24gb3VyIHdl
YiBzZXJ2aWNlLCB3aGljaCBydW5zDQo+ID4gb24NCj4gPiBtYW55IG1hbnkgc2VydmVycywgc28g
aXQgcmVwcmVzZW50cyB0aGUgd29ya2xvYWQgdGhhdCB3ZSBjYXJlIGENCj4gPiBsb3QuDQo+ID4g
VW5mb3J0dW5hdGVseSwgaXQgaXMgbm90IHBvc3NpYmxlIHRvIHJ1biBpdCBvdXQgb2Ygb3VyIGRh
dGENCj4gPiBjZW50ZXJzLg0KPiANCj4gSSBhbSBub3QgYXNraW5nIGZvciB0aGF0LCBJIGFtIGFz
a2luZyBmb3IgeW91IHRvIHBpY2sgYW55IHNpbWlsYXINCj4gYmVuY2hhcmsgd2hpY2ggY2FuIHJ1
biBpbiBwYXJhbGVsbGVsIHdoaWNoIG1heSB5aWVsZCBzaW1pbGFyIHJlc3VsdHMuDQo+IA0KPiA+
IFdlIGNhbiBidWlsZCBzb21lIGFydGlmaWNpYWwgd29ya2xvYWRzIGFuZCBwcm9iYWJseSBnZXQg
bXVjaCBoaWdoZXINCj4gPiBwZXJmb3JtYW5jZSBpbXByb3ZlbWVudHMuIEJ1dCB0aGVzZSB3b3Jr
bG9hZCBtYXkgbm90IHJlcHJlc2VudCByZWFsDQo+ID4gd29ybGQgdXNlIGNhc2VzLg0KPiANCj4g
WW91IGNhbiB2ZXJ5IGxpa2VseSB1c2Ugc29tZSBleGlzdGluZyBiZW5jaG1hcmsuDQo+IA0KPiBU
aGUgZGlyZWN0IG1hcCBmcmFnbWVudGF0aW9uIHN0dWZmIGRvZXNuJ3QgcmVxdWlyZSBtdWNoIGVm
Zm9ydCwgYXMNCj4gd2FzIGRlbW9uc3RyYXRlZCBieSBBYXJvbiwgeW91IGNhbiBlYXNpbHkgZG8g
dGhhdCBvciBtb3JlIGJ5DQo+IHJ1bm5pbmcgYWxsIHNlbGZ0ZXN0cyBvciBqdXN0IHRoZSB0ZXN0
X2JwZi4gVGhpcyBJIGJ1eS4NCj4gDQo+IEknbSBub3QgYnV5aW5nIHRoZSBpVExCIGdhaW5zIGFz
IEkgY2FuJ3QgZXZlbiByZXByb2R1Y2UgdGhlbSBteXNlbGYNCj4gZm9yDQo+IGVCUEYgSklULCBi
dXQgSSB0ZXN0ZWQgYWdhaW5zdCBpVExCIHdoZW4gdXNpbmcgZUJQRiBKSVQsIHBlcmhhcHMgeW91
DQo+IG1lYW4gaVRMQiBnYWlucyBmb3Igb3RoZXIgbWVtb3J5IGludGVuc2l2ZSBhcHBsaWNhdGlv
bnMgcnVubmluZyBpbg0KPiB0YW5kZW0/DQoNClNvbmcsIGRpZG4ndCB5b3UgZmluZCB0aGF0IHRo
ZXJlIHdhc24ndCAob3IgaW4gdGhlIG5vaXNlKSBpVExCIGdhaW5zPw0KV2hhdCBpcyB0aGlzIGFi
b3V0IHZpc2libGUgcGVyZm9ybWFuY2UgZHJvcCBmcm9tIGlUTEIgbWlzc2VzPw0KDQpJSVJDIHRo
ZXJlIHdhcyBhIHRlc3QgZG9uZSB3aGVyZSBwcm9ncGFjayBtYXBwZWQgdGhpbmdzIGF0IDRrLCBi
dXQgaW4NCjJNQiBjaHVua3MsIHNvIGl0IHdvdWxkIHJlLXVzZSBwYWdlcyBsaWtlIHRoZSAyTUIg
bWFwcGVkIHZlcnNpb24uIEFuZA0KaXQgZGlkbid0IHNlZSBtdWNoIGltcHJvdmVtZW50IG92ZXIg
dGhlIDJNQiBtYXBwZWQgdmVyc2lvbi4gRGlkIEkNCnJlbWVtYmVyIHRoYXQgd3Jvbmc/DQoNCj4g
DQo+IEFuZCBub25lIG9mIHlvdXIgcGF0Y2hlcyBtZW50aW9ucyB0aGUgZ2FpbnMgb2YgdGhpcyBl
ZmZvcnQgaGVscGluZw0KPiB3aXRoIHRoZSBsb25nIHRlcm0gYWR2YW50YWdlIG9mIGNlbnRyYWxp
emluZyB0aGUgc2VtYW50aWNzIGZvcg0KPiBwZXJtaXNzaW9ucyBvbiBtZW1vcnkuDQoNCkFub3Ro
ZXIgZ29vZCBwb2ludC4gQWx0aG91Z2ggdGhpcyBicmluZ3MgdXAgdGhhdCB0aGlzIGludGVyZmFj
ZQ0KImV4ZWNtZW0iIGRvZXMganVzdCBoYW5kbGUgb25lIHR5cGUgb2YgcGVybWlzc2lvbi4NCg==
