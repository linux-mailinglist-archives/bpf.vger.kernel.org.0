Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01916E581D
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 06:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjDREfK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 00:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjDREfH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 00:35:07 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949B49F8
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 21:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681792505; x=1713328505;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nQagnkgroKsrVUSjWcxVsPtKnG23rxRVaN+BIS2ThCI=;
  b=g7D445fyEctqaJKYCjoU8tQV0Dmavm1OYgVFKXIGaB5xWKTXzjZb9Zu+
   FHVSBzTNGxow77UV/tY7iPsK8ppQ7v8zHu1TEqcAPF11SJxvP35UtLoYC
   o4Y3ZemdqiuCjhctsM2d0aeQaPFSDZt4YWR1G/Fjc+UWnd9wsVa5JG3gk
   0VCF8Rf601+jVMXkZe3h8nVaoVppQMkgKPxiZN4VC415m/l8Yndx/osg/
   /c5pvG6VnaGYhC7OMwQCP/OINnCDYM8Rq70uj6X7QkeHZT/aYZ7dWNWD0
   RBlzboHLb5U+AuFIUGK130Tgp8oF6aTDl6fTgKCibqcqGPQIoinlZR8SP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="372951569"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="372951569"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:35:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="815057726"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="815057726"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 17 Apr 2023 21:35:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 21:35:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 21:35:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 21:35:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArfesyhMo+K/KLKd7om1taaQo/BIl5NMrG+P/XFV/NBdFmlfZ0YISawV0arOEuxkMQ/ZCM17NmKh29dGszsbJNMd+oz9FUrstJ1N1AW42sj4yEaa2uW1yq/1iFrMsirmL7o4GS4odDZ3UH9FxieX0I8uVNK7jN9vb4tBp0a6328yM++CYCa59+HvvVpahFixqNUxpEmdpXmPELvGRTo3d4gyZHu1EBlYbJcrwO6t5j1pCS/Bv/wEBjPVnlhneCIoPBr8zcvbIxqUcToiEH8+wYLoJYeRFxGWv350ZMokQDwT/HOdK4xn4LZL9qozmCx0YhHymCytj/9EcX5pajvCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQagnkgroKsrVUSjWcxVsPtKnG23rxRVaN+BIS2ThCI=;
 b=BYG0M15EVRwzTBpludDZMfAESa078vVufSVTOTpjv9aBPUOPx9hyUaiBV9Jp0ZnLh9hz+xH2XK+Nk9WQsXhaPHLDQBNYLRR38i4BcfsLZelr4p+LSat6J2v29Py+m0y+weoWaBFxixHLaxWT74KNhPYTOY5+xFlEOFwdvCfBtoB2MHzVPgruJPL0pZ2uzg3v1GGPkplfxzjzECOkMA+Voy/nrAgcPjAmcpqZETlUaIH521HQRWNgRGImhmTiQuA807DD8tfynxIACPzPFef5CQoe0JZb2ErVDyEC7VArCK3G/U+aFq86jHUETuIXsSDldYrt4INnIIKrDTVFIVm28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DM4PR11MB7183.namprd11.prod.outlook.com (2603:10b6:8:111::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:34:52 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:34:52 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH bpf-next V1 2/5] igc: add igc_xdp_buff wrapper for
 xdp_buff in driver
Thread-Topic: [PATCH bpf-next V1 2/5] igc: add igc_xdp_buff wrapper for
 xdp_buff in driver
Thread-Index: AQHZcTzsnAe6U9nIUE+jaLPBuHApcK8weMVQ
Date:   Tue, 18 Apr 2023 04:34:52 +0000
Message-ID: <PH0PR11MB5830DD3BA9F6CBDA648F5AF8D89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <168174338054.593471.8312147519616671551.stgit@firesoul>
 <168174343294.593471.10523474360770220196.stgit@firesoul>
In-Reply-To: <168174343294.593471.10523474360770220196.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DM4PR11MB7183:EE_
x-ms-office365-filtering-correlation-id: 71c554fa-c605-4a40-1dc4-08db3fc640be
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nj1+6KTnJKkWkq35emk2V/lwNhkaWFQmkVMILsE0m53+l7Xf8yJeTO3JnfX2OYEookufTzf/YjGhqLspRsJlAIHNxwb1zha8dv6eu524Xh95YNvmZGdDhnYu4HPFyauTp5sFKw3cLj07tcGo1ZOZSe4HLvJsTbC7pTiayMlcBZG30Smw6K3foAhynLKXVmO52YEo2FCrBm2DsJFlqHtR186BQEnldaIPMOa+xgV0XAeGwfxkXye2mQoi1F9Ah8UQGlu2uCMhjyrIIDAwvQn0OrMTRqojaZoN5+b1UYPJc1eow7Uk1MJBUBalgVAXaY+cQ+CNtgpwpR0eB7LXQM7KW7Yt8n94ARyxrA+UNFyBQxr/u+DPM8k5A8Ca/qc+LcGRU+ry/qXVcXzQDbPb3m376fKcMIQNs+ZTa8Sqn/awJXxtZqBEZOS2RnW0r4zMM5VeELuitONycVFAWaP3qJ58fb6TAfYOAGLt6Qg9c3e/rDaLVEzj5LUw34Z78NCflfeyn6PRr/zgoYY+e/mop6Cog9uNoE9g3TGI9UKqXRmOaL/7y3ggU1D17sBH4wcLlA+7HtHLVLxSzPQk1SK4yUKUeM2akmPyzQxcMdxq837tgBJ79TtGRgeBj+HodGWEXSFw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(39860400002)(376002)(136003)(451199021)(53546011)(26005)(9686003)(55236004)(6506007)(122000001)(316002)(41300700001)(186003)(82960400001)(110136005)(7696005)(33656002)(478600001)(71200400001)(54906003)(66946007)(66446008)(86362001)(64756008)(66476007)(76116006)(66556008)(55016003)(4326008)(7416002)(5660300002)(52536014)(38100700002)(8936002)(8676002)(38070700005)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTVTdk9GOU5vWkE0R0dNNTZQWUVsb3RXS1lNb3ljR21tZElpN3NuWXl5bXlr?=
 =?utf-8?B?WFArcEdXSFFpbWhKMktqdURHaGRYc215bEN0ZEgwSlRKQXRYTHlCZGlyT3pn?=
 =?utf-8?B?dzJNNlY3YmF1Q3c3QlZ0K1NGOVFWUnB5S3BRVnF1bVkvSHRQSGkzN2krSlNk?=
 =?utf-8?B?S0JvYkg2RUNWWHpncVhQaW1KUTBjTGZETkhsRk9VeVE3U2FQWUQxRW5rK0Ey?=
 =?utf-8?B?ZG1RWjFHbVJNMHNrVWkraXczcCsxSGlDRVRPdXFjSjExT3hWTFBqQmEzVHRs?=
 =?utf-8?B?a0Q1TWVDSjhZRFg1eTNJcENnMitJSmtoUUtJSncyWmxIN0hOU1VmTmNiRjdD?=
 =?utf-8?B?Z2pwamxwQm5ibjNLeHJGMmhxWUZnbHZPSzdYS25pTDRKaWIyM2V5SFArRzhw?=
 =?utf-8?B?azFUWG52OXVDa2w1c2NFa2ZseWtROXlYejlxTHZ3aHFqazhLQnlQUjR3a3lQ?=
 =?utf-8?B?U2dmR2cxQ09kNEZRazB2cS8ydDVnOVYrL3V4QmxITEp1RWdmR0hjc2ptU0pN?=
 =?utf-8?B?UHMwOGhwdG1EKzJMdVh4ZDJqT3RNSDB0NnI1SHA1Y0pyRXVnMmhTTGhLWE1P?=
 =?utf-8?B?RUQwWkNva2drOUNXUW9VUWVTSUJLeXN4dTVLbVV4ZzZFQXNtYWk0OVdlT2d6?=
 =?utf-8?B?dTJzMUVkdU13SmF4VHVYRU1meGV5QnpibDljSUJnUjJBTlhzeWNxc3RUTnNY?=
 =?utf-8?B?V3F3UGRtSGYrUWNGM0piWUtZMklhbHQrbjZ1K1Bqeksrb1JrRFBvdWVkeEhW?=
 =?utf-8?B?WHVkMVI0c1BpdFFzdG9ERVUxUDN0dDZIRWEwWWs1aCtHWStra2RTWXBKdzBk?=
 =?utf-8?B?aVY2MFNaaitqYU9hS0ZCVDdqWXQ5cDZ4K0RTT1lmek1GZGEvYkIzVDZoVnNk?=
 =?utf-8?B?ZGJDUVM4SFEzZUw5a1A4c2UvZUhpUmU3V0ppODc3akZiRXRTazhtaGVvQ3Jk?=
 =?utf-8?B?cmJ2c05RVUNCZmZGR1o2N2IxY0NXSmNvcnpVTno1c296NldpMmQ0NUZjOEdh?=
 =?utf-8?B?dU9rR1dXRWk0QmpkRjd2Q2h0VmdaeklwNGlBcjVyZFlySEZhZUxrTDFpSk5l?=
 =?utf-8?B?aGZ3aXBlL1lHZ3cxbmt0UkQ1RmpXemZZTit6dzdlcnNoVG5jL0tDcXpValN5?=
 =?utf-8?B?QU44RFNYbko3MUEzdjhxeGc3bmNJMWdsMWVCMW9PaEIyS0FlVG81RS9pb1BP?=
 =?utf-8?B?aFY2SEkyc2pxZnFSY2pkOGNkeW9yUEM2dVFnbjQySVVldmtuajZXVWM0TEJo?=
 =?utf-8?B?bGFzTnpJakRoZDAwU3c2S2d5clRwSkszSUNFdHVWVktySnZxcDM4Uk83MUtw?=
 =?utf-8?B?YUFHTkJtYUhaNzZUZ1dBYWdBOCsvVm9HRlVqK21xYmdSSm1STXh4dll1ZFRi?=
 =?utf-8?B?VW1IRjkxWkxMM25vUGlNMm1kV003Sk5LMGVWak9ySnUrcjNTZHY0V08xeGhz?=
 =?utf-8?B?QVdVU3hkdGFScXcrNSsyUDF0VDNxNVMyUmpGTDNWRm9XWWRsMXJMWldFWU9K?=
 =?utf-8?B?eitYN1hvS3NQa0NlUE9iRFh3V0NVdmRyVllmdXJTNVhpamY4Wm9jTmdnNkpG?=
 =?utf-8?B?ZEt6QU4vYWYxNDI0MnZEd1hDOUxVNmdYOGxaZDg1L0U1Z2lYdzdIb0FlaFlK?=
 =?utf-8?B?V21NNEl2Ym1NY1dYNzVsUmQ0K09BOC9neDJZaG56NVVVU3RBL01ISVZYZkpT?=
 =?utf-8?B?TytIeThENWIzaEV3YXJJMzdXdkhiNzQza0NXOXJvdE1PbmRGc08vdDY5QUdM?=
 =?utf-8?B?OHJqdHlXSTkvbm11WGIzOUFOWEwrb0YyV1RBUGRqWk53cmhqSnJnNGQ2ZW1s?=
 =?utf-8?B?SHhIOXcrVkM1dzFXNkVMMjFRakRRdzZKR0hBbmRsajJ2SzBVY3F0b1kya3lq?=
 =?utf-8?B?WlV3eUwrY015bjlpcCtRVHU2aEVHdHhPSzROWmp6NVIzRm1sRTBaZmlwMG1P?=
 =?utf-8?B?NW1jckFzWjhWTldmYllrc3NoZWtXS3RlQ3hRenJmMkExY2NnT24vLytwYmg0?=
 =?utf-8?B?NXUya2ZZTmcyYWpudFFqK3VwT2Q4R3I2RzhDSXhyOTRvTFYwbFlQS2Y5ckVU?=
 =?utf-8?B?NzZZY0ZNM1VvZzJ3OWozMlRBckNZOHhtaXY3cjdPSDRsZ3VuUDNmNXVEZEpX?=
 =?utf-8?B?RU5LVEphWWZCTU5peElaSHMzbmNURmk4RklSQVl1TUlGU2FUWkpQVEx6MDU5?=
 =?utf-8?B?RGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c554fa-c605-4a40-1dc4-08db3fc640be
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 04:34:52.4989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AfU1xHFRhwVgKKs4daZpN6pVP7Yo1wG7WzUbpQm3AEFcm/Jqt4eDxqLIB2cX6xBGuT54KznaMzs7dFpZ1spIS4DOPWNu5Z81U+jB8RiVObQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7183
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uZGF5LCBBcHJpbCAxNywgMjAyMyAxMDo1NyBQTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPkRyaXZlciBzcGVjaWZpYyBtZXRhZGF0YSBk
YXRhIGZvciBYRFAtaGludHMga2Z1bmNzIGFyZSBwcm9wYWdhdGVkIHZpYSB0YWlsDQo+ZXh0ZW5k
aW5nIHRoZSBzdHJ1Y3QgeGRwX2J1ZmYgd2l0aCBhIGxvY2FsbHkgc2NvcGVkIGRyaXZlciBzdHJ1
Y3QuDQo+DQo+WmVyby1Db3B5IEFGX1hEUC9YU0sgZG9lcyBzaW1pbGFyIHRyaWNrcyB2aWEgc3Ry
dWN0IHhkcF9idWZmX3hzay4gVGhpcw0KPnhkcF9idWZmX3hzayBzdHJ1Y3QgY29udGFpbnMgYSBD
QiBhcmVhICgyNCBieXRlcykgdGhhdCBjYW4gYmUgdXNlZCBmb3IgZXh0ZW5kaW5nDQo+dGhlIGxv
Y2FsbHkgc2NvcGVkIGRyaXZlciBpbnRvLiBUaGUgWFNLX0NIRUNLX1BSSVZfVFlQRSBkZWZpbmUg
Y2F0Y2ggc2l6ZQ0KPnZpb2xhdGlvbnMgYnVpbGQgdGltZS4NCj4NCg0KU2luY2UgdGhlIG1haW4g
cHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzIHRvIGludHJvZHVjZSBpZ2NfeGRwX2J1ZmYsIGFuZA0K
eW91IGhhdmUgYW5vdGhlciB0d28gcGF0Y2hlcyBmb3IgdGltZXN0YW1wIGFuZCBoYXNoLA0KdGh1
cywgc3VnZ2VzdCB0byBtb3ZlIHRpbWVzdGFtcCBhbmQgaGFzaCByZWxhdGVkIGNvZGUgaW50byBy
ZXNwZWN0aXZlIHBhdGNoZXMuIA0KDQo+U2lnbmVkLW9mZi1ieTogSmVzcGVyIERhbmdhYXJkIEJy
b3VlciA8YnJvdWVyQHJlZGhhdC5jb20+DQo+LS0tDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2lu
dGVsL2lnYy9pZ2MuaCAgICAgIHwgICAgNiArKysrKysNCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWdjL2lnY19tYWluLmMgfCAgIDMwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0t
DQo+IDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4N
Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+Yi9k
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjLmgNCj5pbmRleCBmN2Y5ZTIxN2U3YjQu
LmM2MDlhMmU2NDhmOCAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2MvaWdjLmgNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjLmgNCj5A
QCAtNDk5LDYgKzQ5OSwxMiBAQCBzdHJ1Y3QgaWdjX3J4X2J1ZmZlciB7DQo+IAl9Ow0KPiB9Ow0K
Pg0KPisvKiBjb250ZXh0IHdyYXBwZXIgYXJvdW5kIHhkcF9idWZmIHRvIHByb3ZpZGUgYWNjZXNz
IHRvIGRlc2NyaXB0b3INCj4rbWV0YWRhdGEgKi8gc3RydWN0IGlnY194ZHBfYnVmZiB7DQo+Kwlz
dHJ1Y3QgeGRwX2J1ZmYgeGRwOw0KPisJdW5pb24gaWdjX2Fkdl9yeF9kZXNjICpyeF9kZXNjOw0K
DQpNb3ZlIHJ4X2Rlc2MgdG8gNHRoIHBhdGNoIChSeCBoYXNoIHBhdGNoKQ0KDQo+K307DQo+Kw0K
PiBzdHJ1Y3QgaWdjX3FfdmVjdG9yIHsNCj4gCXN0cnVjdCBpZ2NfYWRhcHRlciAqYWRhcHRlcjsg
ICAgLyogYmFja2xpbmsgKi8NCj4gCXZvaWQgX19pb21lbSAqaXRyX3JlZ2lzdGVyOw0KPmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPmIvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj5pbmRleCBiZmE5NzY4ZDQ0
N2YuLjNhODQ0Y2Y1YmUzZiAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZ2MvaWdjX21haW4uYw0KPisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9p
Z2NfbWFpbi5jDQo+QEAgLTIyMzYsNiArMjIzNiw4IEBAIHN0YXRpYyBib29sIGlnY19hbGxvY19y
eF9idWZmZXJzX3pjKHN0cnVjdCBpZ2NfcmluZw0KPipyaW5nLCB1MTYgY291bnQpDQo+IAlpZiAo
IWNvdW50KQ0KPiAJCXJldHVybiBvazsNCj4NCj4rCVhTS19DSEVDS19QUklWX1RZUEUoc3RydWN0
IGlnY194ZHBfYnVmZik7DQo+Kw0KPiAJZGVzYyA9IElHQ19SWF9ERVNDKHJpbmcsIGkpOw0KPiAJ
YmkgPSAmcmluZy0+cnhfYnVmZmVyX2luZm9baV07DQo+IAlpIC09IHJpbmctPmNvdW50Ow0KPkBA
IC0yNTIwLDggKzI1MjIsOCBAQCBzdGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnEoc3RydWN0IGln
Y19xX3ZlY3Rvcg0KPipxX3ZlY3RvciwgY29uc3QgaW50IGJ1ZGdldCkNCj4gCQl1bmlvbiBpZ2Nf
YWR2X3J4X2Rlc2MgKnJ4X2Rlc2M7DQo+IAkJc3RydWN0IGlnY19yeF9idWZmZXIgKnJ4X2J1ZmZl
cjsNCj4gCQl1bnNpZ25lZCBpbnQgc2l6ZSwgdHJ1ZXNpemU7DQo+KwkJc3RydWN0IGlnY194ZHBf
YnVmZiBjdHg7DQo+IAkJa3RpbWVfdCB0aW1lc3RhbXAgPSAwOw0KPi0JCXN0cnVjdCB4ZHBfYnVm
ZiB4ZHA7DQo+IAkJaW50IHBrdF9vZmZzZXQgPSAwOw0KPiAJCXZvaWQgKnBrdGJ1ZjsNCj4NCj5A
QCAtMjU1NSwxMyArMjU1NywxNCBAQCBzdGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnEoc3RydWN0
IGlnY19xX3ZlY3Rvcg0KPipxX3ZlY3RvciwgY29uc3QgaW50IGJ1ZGdldCkNCj4gCQl9DQo+DQo+
IAkJaWYgKCFza2IpIHsNCj4tCQkJeGRwX2luaXRfYnVmZigmeGRwLCB0cnVlc2l6ZSwgJnJ4X3Jp
bmctPnhkcF9yeHEpOw0KPi0JCQl4ZHBfcHJlcGFyZV9idWZmKCZ4ZHAsIHBrdGJ1ZiAtIGlnY19y
eF9vZmZzZXQocnhfcmluZyksDQo+KwkJCXhkcF9pbml0X2J1ZmYoJmN0eC54ZHAsIHRydWVzaXpl
LCAmcnhfcmluZy0+eGRwX3J4cSk7DQo+KwkJCXhkcF9wcmVwYXJlX2J1ZmYoJmN0eC54ZHAsIHBr
dGJ1ZiAtIGlnY19yeF9vZmZzZXQocnhfcmluZyksDQo+IAkJCQkJIGlnY19yeF9vZmZzZXQocnhf
cmluZykgKyBwa3Rfb2Zmc2V0LA0KPiAJCQkJCSBzaXplLCB0cnVlKTsNCj4tCQkJeGRwX2J1ZmZf
Y2xlYXJfZnJhZ3NfZmxhZygmeGRwKTsNCj4rCQkJeGRwX2J1ZmZfY2xlYXJfZnJhZ3NfZmxhZygm
Y3R4LnhkcCk7DQo+KwkJCWN0eC5yeF9kZXNjID0gcnhfZGVzYzsNCg0KTW92ZSByeF9kZXNjIHRv
IDR0aCBwYXRjaCAoUnggaGFzaCBwYXRjaCkNCg0KPg0KPi0JCQlza2IgPSBpZ2NfeGRwX3J1bl9w
cm9nKGFkYXB0ZXIsICZ4ZHApOw0KPisJCQlza2IgPSBpZ2NfeGRwX3J1bl9wcm9nKGFkYXB0ZXIs
ICZjdHgueGRwKTsNCj4gCQl9DQo+DQo+IAkJaWYgKElTX0VSUihza2IpKSB7DQo+QEAgLTI1ODMs
OSArMjU4Niw5IEBAIHN0YXRpYyBpbnQgaWdjX2NsZWFuX3J4X2lycShzdHJ1Y3QgaWdjX3FfdmVj
dG9yDQo+KnFfdmVjdG9yLCBjb25zdCBpbnQgYnVkZ2V0KQ0KPiAJCX0gZWxzZSBpZiAoc2tiKQ0K
PiAJCQlpZ2NfYWRkX3J4X2ZyYWcocnhfcmluZywgcnhfYnVmZmVyLCBza2IsIHNpemUpOw0KPiAJ
CWVsc2UgaWYgKHJpbmdfdXNlc19idWlsZF9za2IocnhfcmluZykpDQo+LQkJCXNrYiA9IGlnY19i
dWlsZF9za2IocnhfcmluZywgcnhfYnVmZmVyLCAmeGRwKTsNCj4rCQkJc2tiID0gaWdjX2J1aWxk
X3NrYihyeF9yaW5nLCByeF9idWZmZXIsICZjdHgueGRwKTsNCj4gCQllbHNlDQo+LQkJCXNrYiA9
IGlnY19jb25zdHJ1Y3Rfc2tiKHJ4X3JpbmcsIHJ4X2J1ZmZlciwgJnhkcCwNCj4rCQkJc2tiID0g
aWdjX2NvbnN0cnVjdF9za2IocnhfcmluZywgcnhfYnVmZmVyLCAmY3R4LnhkcCwNCj4gCQkJCQkJ
dGltZXN0YW1wKTsNCj4NCj4gCQkvKiBleGl0IGlmIHdlIGZhaWxlZCB0byByZXRyaWV2ZSBhIGJ1
ZmZlciAqLyBAQCAtMjY4Niw2ICsyNjg5LDE1DQo+QEAgc3RhdGljIHZvaWQgaWdjX2Rpc3BhdGNo
X3NrYl96YyhzdHJ1Y3QgaWdjX3FfdmVjdG9yICpxX3ZlY3RvciwNCj4gCW5hcGlfZ3JvX3JlY2Vp
dmUoJnFfdmVjdG9yLT5uYXBpLCBza2IpOyAgfQ0KPg0KPitzdGF0aWMgc3RydWN0IGlnY194ZHBf
YnVmZiAqeHNrX2J1ZmZfdG9faWdjX2N0eChzdHJ1Y3QgeGRwX2J1ZmYgKnhkcCkgew0KPisJLyog
eGRwX2J1ZmYgcG9pbnRlciB1c2VkIGJ5IFpDIGNvZGUgcGF0aCBpcyBhbGxvYyBhcyB4ZHBfYnVm
Zl94c2suIFRoZQ0KPisJICogaWdjX3hkcF9idWZmIHNoYXJlcyBpdHMgbGF5b3V0IHdpdGggeGRw
X2J1ZmZfeHNrIGFuZCBwcml2YXRlDQo+KwkgKiBpZ2NfeGRwX2J1ZmYgZmllbGRzIGZhbGwgaW50
byB4ZHBfYnVmZl94c2stPmNiDQo+KwkgKi8NCj4rICAgICAgIHJldHVybiAoc3RydWN0IGlnY194
ZHBfYnVmZiAqKXhkcDsgfQ0KPisNCg0KTW92ZSB4c2tfYnVmZl90b19pZ2NfY3R4IHRvIDN0aCBw
YXRjaCAodGltZXN0YW1wIHBhdGNoKSwgd2hpY2ggaXMgZmlyc3QgcGF0Y2gNCmFkZGluZyB4ZHBf
bWV0YWRhdGFfb3BzIHN1cHBvcnQgdG8gaWdjLg0KDQo+IHN0YXRpYyBpbnQgaWdjX2NsZWFuX3J4
X2lycV96YyhzdHJ1Y3QgaWdjX3FfdmVjdG9yICpxX3ZlY3RvciwgY29uc3QgaW50IGJ1ZGdldCkg
IHsNCj4gCXN0cnVjdCBpZ2NfYWRhcHRlciAqYWRhcHRlciA9IHFfdmVjdG9yLT5hZGFwdGVyOyBA
QCAtMjcwNCw2ICsyNzE2LDcNCj5AQCBzdGF0aWMgaW50IGlnY19jbGVhbl9yeF9pcnFfemMoc3Ry
dWN0IGlnY19xX3ZlY3RvciAqcV92ZWN0b3IsIGNvbnN0IGludA0KPmJ1ZGdldCkNCj4gCXdoaWxl
IChsaWtlbHkodG90YWxfcGFja2V0cyA8IGJ1ZGdldCkpIHsNCj4gCQl1bmlvbiBpZ2NfYWR2X3J4
X2Rlc2MgKmRlc2M7DQo+IAkJc3RydWN0IGlnY19yeF9idWZmZXIgKmJpOw0KPisJCXN0cnVjdCBp
Z2NfeGRwX2J1ZmYgKmN0eDsNCj4gCQlrdGltZV90IHRpbWVzdGFtcCA9IDA7DQo+IAkJdW5zaWdu
ZWQgaW50IHNpemU7DQo+IAkJaW50IHJlczsNCj5AQCAtMjcyMSw2ICsyNzM0LDkgQEAgc3RhdGlj
IGludCBpZ2NfY2xlYW5fcnhfaXJxX3pjKHN0cnVjdCBpZ2NfcV92ZWN0b3INCj4qcV92ZWN0b3Is
IGNvbnN0IGludCBidWRnZXQpDQo+DQo+IAkJYmkgPSAmcmluZy0+cnhfYnVmZmVyX2luZm9bbnRj
XTsNCj4NCj4rCQljdHggPSB4c2tfYnVmZl90b19pZ2NfY3R4KGJpLT54ZHApOw0KDQpNb3ZlIHhz
a19idWZmX3RvX2lnY19jdHggdG8gM3RoIHBhdGNoICh0aW1lc3RhbXAgcGF0Y2gpLCB3aGljaCBp
cyBmaXJzdCBwYXRjaA0KYWRkaW5nIHhkcF9tZXRhZGF0YV9vcHMgc3VwcG9ydCB0byBpZ2MuDQoN
Cj4rCQljdHgtPnJ4X2Rlc2MgPSBkZXNjOw0KDQpNb3ZlIHJ4X2Rlc2MgdG8gNHRoIHBhdGNoIChS
eCBoYXNoIHBhdGNoKQ0KDQpUaGFua3MgJiBSZWdhcmRzDQpTaWFuZw0KDQo+Kw0KPiAJCWlmIChp
Z2NfdGVzdF9zdGF0ZXJyKGRlc2MsIElHQ19SWERBRFZfU1RBVF9UU0lQKSkgew0KPiAJCQl0aW1l
c3RhbXAgPSBpZ2NfcHRwX3J4X3BrdHN0YW1wKHFfdmVjdG9yLT5hZGFwdGVyLA0KPiAJCQkJCQkJ
YmktPnhkcC0+ZGF0YSk7DQo+DQoNCg==
