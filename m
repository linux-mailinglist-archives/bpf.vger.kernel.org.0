Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98EC6E5805
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 06:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjDRES5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 00:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDRES4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 00:18:56 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF97D40D1
        for <bpf@vger.kernel.org>; Mon, 17 Apr 2023 21:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681791535; x=1713327535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qe2UB2jna+790wYfXeZOvomzlvYuH9vt3KuK0f00x4I=;
  b=VRTHmEM+Bopiy3MV7J84UJn4qKKfh9HIZZUZbGWMwexPOrLn5olqF5Zq
   lXqlguNl5m14J5MlRearJUhcAZw09LGqMFdHWy/nPG+/JhUlPeMc7Lu3Q
   /72ILIK/ODDNKN7sgtUpNbQFpKvdE6iSuTJCbrLPy9ezPE/QUt1pcoUnT
   cPUJIFIbqatmYvITYla0hixs6sVnBsUq6eBD59HAFMYnrsRKLew5jvjXL
   WylSB5p6oUoJDIJhQdb6JunZCeNB8Kfk8jfDDaKtyRlfirjdsRpQyhZ8V
   fvLKVabl53sDHijcyauvJ2SWJSZ8nOyoTqGnTG+T9LbMfGkt2GdsMHs1+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="325409924"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="325409924"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 21:18:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="780363719"
X-IronPort-AV: E=Sophos;i="5.99,206,1677571200"; 
   d="scan'208";a="780363719"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Apr 2023 21:18:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 21:18:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 21:18:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 21:18:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fCwVwbV94Hr/w71r7yIjD6MS1gTYKzxIP1g6ruEiMPq41+RsPLbcz77ZlYkhCyL0AewncvhdGFQ9hLKxGfQwWz+ZhcVdiEwFxHCwsPrPcP2Cn3+VvS9I2vl6cVozrxHPvV4CS2LBUJHAe2vy+mFnZ2GuiD+LC/E9SZCLzoejxVpp6Fh1hsa2I+OwvKlxVu3R9nl+ALsuQTTBTn7bSmXKo601jw+SHe/zBqndceQTTv2f41uX8zqtY/Zbcqzphij8d741nViWa52cdEGGoLcySofChzTsX06lIyP9316iG90P74KNVjweB0z2C/GjdPUGx3EiibZUu4Ya4TvJ89NynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qe2UB2jna+790wYfXeZOvomzlvYuH9vt3KuK0f00x4I=;
 b=F6J/T8vKoHY+/uv3lvSIMRdclinlDb5CKxpKZ4WnQr4Nzz4kNo7VVl4lpfoVGQLXsV5L/+1U/Srb6HbXFfRuzmTH1phMVXIQeWs+9zCwLYH1Yym/8IFth92SBzHuXdFrX2qKoTISuOa9LZrg8ty/upeK+4nu5VaWuI6M4QnYJS3OVPc6AvEbkkysjALbOm/JEq65ir1PAVR/Z55GcrkivNUjjNkNaRl0RLqRulvY9kskPCIkyJ91M/9Ca07gTDSWj6s5TDAdFpl1VsitgSWBhpud8StleEd4MxClxguM7EdpZOvGsKpLQCITgmBJ2wlDSXhBsdL4n4Nx+1bI0KhXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by SJ2PR11MB7502.namprd11.prod.outlook.com (2603:10b6:a03:4d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:18:50 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6298.045; Tue, 18 Apr 2023
 04:18:50 +0000
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
Subject: RE: [PATCH bpf-next V1 4/5] igc: add XDP hints kfuncs for RX hash
Thread-Topic: [PATCH bpf-next V1 4/5] igc: add XDP hints kfuncs for RX hash
Thread-Index: AQHZcTzyLxexDRn6WUOEsDW09NDjv68wdoRQ
Date:   Tue, 18 Apr 2023 04:18:50 +0000
Message-ID: <PH0PR11MB5830550374DCF59BAEFC5D09D89D9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <168174338054.593471.8312147519616671551.stgit@firesoul>
 <168174344307.593471.11961012266841546530.stgit@firesoul>
In-Reply-To: <168174344307.593471.11961012266841546530.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|SJ2PR11MB7502:EE_
x-ms-office365-filtering-correlation-id: 9911b0d9-befa-4ec0-e104-08db3fc4033c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UBZ2fVbLV6PFS/35UhtcKU7KV7HeEmPLtGS/QF0CxJrdH2ZBTK1CJy5UpxZH6jSQNPoDMUiJH1RJh9COK4P4oMHfryM394bySsdnEyB2dnePGle3uTMORBjIdiwOe9f0VsZE1nMNPyy/9PE1qhAnF27qY8ZUPuJBHWFIRFgZbKpZjLsD4E4AqFY+hQY6h2m1sB3gQmUbxzyRsa+9dVk/p6oO5YrS179THU6xVHzYFrtYyvG81oyy8BrE+wLxF89xHJvpm9CXKCEU8wcARnv4SRV5HILsMVlnzeVXrElJ73OcUdXIQ53YoGsPVRKfeJDTtMuzAkOlGFvw6jhECAdgY/cHHHghBXoiigsByR1ZCVd77ITsgjqDfEtzQwbzIOBZm5196O7LI+8K9g4uxALxQmNntDxLIlc6vWOx4aNp6eFlJ8pIpep+2DHguRdWFMWKdS8JXId6PdDt4FuUM2qJ13LVQs1ZU2WxLAthfwaM3NqrRpt2DprvCoauXvR5OfmbQUgYkPdSikbth+HUzaySU7JH6d3alTkeCEu3fuJyBo9ZozVqZ6VxvVIsSHYMsJca989rrE3mCsiwORr7YGJFyst9nIwQ2jVxRyOdUjJf1n8tKwh1LL7OFVdohGPGY87q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(396003)(39860400002)(366004)(451199021)(2906002)(38070700005)(8936002)(8676002)(41300700001)(82960400001)(122000001)(52536014)(7416002)(38100700002)(5660300002)(33656002)(86362001)(55016003)(478600001)(54906003)(110136005)(55236004)(9686003)(6506007)(26005)(71200400001)(186003)(7696005)(53546011)(76116006)(4326008)(316002)(66946007)(66556008)(66476007)(66446008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L085M1pjbjJ1bk5QdWhjb0NCdjZSbkh3QjB1WEFubWFQYTE2dE92c3BhSkNS?=
 =?utf-8?B?alljKzR5UFB4L0xERlNqZVdNdHFuMEpicHkrL2h4WGNzbitwSjJvKzlXRkdC?=
 =?utf-8?B?Ty9kNDk3ZW9MNzV5eWFVdDRJOGZ0TDVKd0J5VjBYM2VLMnlLdDVna1ZwV0hZ?=
 =?utf-8?B?UEQvZk9XMC90L0ZoaXA0L3NjZ3dZaTVGd0dOV29zcEdTZGhnSEVzd3M4RmUx?=
 =?utf-8?B?ektJUzZaVE9YVzhVdlh0R0FxejdCMjEwckJVVTVFWFVnZXVLM1FRbEVuWE5U?=
 =?utf-8?B?RUZPTTF6RXd2LzdrWk9XRFZCcGt3YWRZeDEvUzA0NTliajVjZzlaTUhKMnF3?=
 =?utf-8?B?S3dDbDdkTHI3Nm83ajhDeXBBdVdjZ2hFQ2UyeFVObVl2QXYxMFNHSFFQSmJT?=
 =?utf-8?B?dTJXUUI1NjA2VDBoc2RycVVDdlpNMWNuQUo2SFgya3M3QmF0MktzZmFad1F1?=
 =?utf-8?B?Tk8wUGVCeG15Sk9rOUtIN3lQVmxpQjZ6YXFkZjdzcmJZSG0wMVlESGdFNk1T?=
 =?utf-8?B?MXN6VmVMaVVGd3dzK2RJcEYyWlVvd3hoU01JT1N4cWVkYWJDMncrTkhpS0po?=
 =?utf-8?B?WFJOT2d4M2xPMHhyU0lpSFpTMDNxbGc3eFd3TVp1MDlBRExKbTJTbGlkaWpG?=
 =?utf-8?B?Sm95Mzd6V0lsWVRqUUNRM0lWUGdyQzhhbE1ibWZPTUxJTmp5WkQ0di9DYzh1?=
 =?utf-8?B?VGxxWExKZG5CRllkOHBkaDd3WEQzUnNCdFozcXZBT3hCUlNONHljNFNkdFo1?=
 =?utf-8?B?SWRLWkEwOUlqdWMwWXdDRUZOM1BvQ293azlxVDB1YTRlZmZtTldoTGV6OWpR?=
 =?utf-8?B?ZGVrUFZYQ2dXZlZwaDFNdnprbXJFcHpab2UrMEFKcXBwM25qSFlkR2kxcmtp?=
 =?utf-8?B?dFFjK0xqOVJhU3haV2ZNMHFNMzZTTG4vOGR3TGFWbVZHcG9pd3VISHJFckYw?=
 =?utf-8?B?dWlNa2R6MXZ6OTNKOGpxeDlnalhvTXZDUXJmVGJOOWJMdWxpa2h2U0dPN2h6?=
 =?utf-8?B?ckZMSzh1WTNkQStiVUVkakt4ZUVoUjlZaGtmWUFlVHgyNElZWm96RW5QcTJn?=
 =?utf-8?B?ZkN2aHRKLy9yc2FrSEJRTGVMcmpSN0tIYUVBVTZsc0R1c1JOanVwK2JrSFZ2?=
 =?utf-8?B?dVdyRmlFcjlNMjFNRmszd1dZYk1LT09IcnhMbE5RSk5KWFhaeUNGeUtyYWl6?=
 =?utf-8?B?TUtDZCtKdzA3VEMxMFNzbWhVVG11UXEvYkJoaU45dXVWbFJwS3phSEcwTDlK?=
 =?utf-8?B?aEphRnpaaERYMmpBWVRKako0ZEtJS3VNbVB1ODJ3cnZCMExZeU1hbEdITzRV?=
 =?utf-8?B?TDQ3SmI4L25sb0dRcjJGU0JiVXRBSzNCWEFaTjV3SDFzWWtURktOTVM5TFhE?=
 =?utf-8?B?K3hMNlVCYm4wWnR0YXNETEE3UC9DbDhUZ0RrTFJJaUN4b3RuY2lxOUVINmhW?=
 =?utf-8?B?R042dlF6U29ZZUl0S3F5MXBlMTBhTFREd01qNkZnMkV3c3J5VFErVis0aTZ0?=
 =?utf-8?B?Z0ZlaG5MSnJGNDFueEJKNkQvTURMWjdLbjg4THhJMWN5NURKeWk5cHZqR1k4?=
 =?utf-8?B?TGVWcEVMOWFZMFBxNU02c0IvdXBIOFhicFdKZWFKL3djVGFUVWIwOEtxR3RL?=
 =?utf-8?B?U0ZRMU5YZXo2YjEyaEw4M05sbGdPMU9pQlRhR2wyOXg1em5PTXk1eWh0OHdF?=
 =?utf-8?B?N0xGUDVCNnBsempyQklKZHB0K1o1MU9IdDlKMlVWR1ozV3p0enkwNllnSHFq?=
 =?utf-8?B?ZHlEVjhmYjZkRlRUdTd0elp5MFhCYkZqemJYbk84b2t6UTJONmYrNjV2dldQ?=
 =?utf-8?B?a0hFSUZ3U090WTM1NjZXYlRabmFGeGlKbDhSMUlVYUJCbERZUVhDYzZZQnNI?=
 =?utf-8?B?QU5tL0JzeEtudUtQK240TndYSnErM1BPOEZ0Nkh6N2lMSkl5RVdtOHo3TE04?=
 =?utf-8?B?VEQ4Rk1LYnRHSkRQa0JyOEhuTjVtN00xenFkdlBCM1AybCtSVktHekptbUxV?=
 =?utf-8?B?TysxVW84ZUQzWGYyZ29qZm1jWVFyWkUzQlA1QWY0RUZzeUJ4SUUrZllVdjFG?=
 =?utf-8?B?U0NlKy9ZMHJESkl0ZC9zQm15T0JLSXVVd0MzdW1OUk9SOE9lcUd6RVJSeERh?=
 =?utf-8?B?ZDA5VURWQ0VBYVJvNXYra3RDbGJCNm5zODRtSGZ0WExWdHAxckRrbHV4cnNv?=
 =?utf-8?B?T1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9911b0d9-befa-4ec0-e104-08db3fc4033c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 04:18:50.3437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/6ftgdQaChFKowZJLalUIizSeMqBWWaapwBPWU2KR70iwY/IRAzIqYOrsnDJgs2/JhfeujC5CRx0f9GYaIhoRSPEONMmdDGlAQFkeOjsro=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7502
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uZGF5LCBBcHJpbCAxNywgMjAyMyAxMDo1NyBQTSwgSmVzcGVyIERhbmdhYXJkIEJyb3Vl
ciA8YnJvdWVyQHJlZGhhdC5jb20+IHdyb3RlOg0KPlRoaXMgaW1wbGVtZW50cyBYRFAgaGludHMg
a2Z1bmMgZm9yIFJYLWhhc2ggKHhtb19yeF9oYXNoKS4NCj5UaGUgSFcgcnNzIGhhc2ggdHlwZSBp
cyBoYW5kbGVkIHZpYSBtYXBwaW5nIHRhYmxlLg0KPg0KPlRoaXMgaWdjIGRyaXZlciBkcml2ZXIg
KGRlZmF1bHQgY29uZmlnKSBkb2VzIEwzIGhhc2hpbmcgZm9yIFVEUCBwYWNrZXRzIChleGNsdWRl
cw0KDQpSZXBlYXRlZCB3b3JkOiBkcml2ZXINCg0KPlVEUCBzcmMvZGVzdCBwb3J0cyBpbiBoYXNo
IGNhbGMpLiAgTWVhbmluZyBSU1MgaGFzaCB0eXBlIGlzDQo+TDMgYmFzZWQuICBUZXN0ZWQgdGhh
dCB0aGUgaWdjX3Jzc190eXBlX251bSBmb3IgVURQIGlzIGVpdGhlcg0KPklHQ19SU1NfVFlQRV9I
QVNIX0lQVjQgb3IgSUdDX1JTU19UWVBFX0hBU0hfSVBWNi4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBK
ZXNwZXIgRGFuZ2FhcmQgQnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4tLS0NCj4gZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMgfCAgIDM1DQo+KysrKysrKysrKysr
KysrKysrKysrKysrKysrKysNCj4gMSBmaWxlIGNoYW5nZWQsIDM1IGluc2VydGlvbnMoKykNCj4N
Cj5kaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMN
Cj5iL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jDQo+aW5kZXggODYy
NzY4ZDVkMTM0Li4yN2Y0NDhkMGFlOTQgMTAwNjQ0DQo+LS0tIGEvZHJpdmVycy9uZXQvZXRoZXJu
ZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj4rKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRl
bC9pZ2MvaWdjX21haW4uYw0KPkBAIC02NTA3LDggKzY1MDcsNDMgQEAgc3RhdGljIGludCBpZ2Nf
eGRwX3J4X3RpbWVzdGFtcChjb25zdCBzdHJ1Y3QgeGRwX21kDQo+Kl9jdHgsIHU2NCAqdGltZXN0
YW1wKQ0KPiAJcmV0dXJuIC1FTk9EQVRBOw0KPiB9DQo+DQo+Ky8qIE1hcHBpbmcgSFcgUlNTIFR5
cGUgdG8gZW51bSB4ZHBfcnNzX2hhc2hfdHlwZSAqLyBlbnVtDQo+K3hkcF9yc3NfaGFzaF90eXBl
IGlnY194ZHBfcnNzX3R5cGVbSUdDX1JTU19UWVBFX01BWF9UQUJMRV0gPSB7DQoNClNpbmNlIGln
Y194ZHBfcnNzX3R5cGUgaXMgdXNlZCBpbiBpZ2NfbWFpbi5jIG9ubHksIHN1Z2dlc3QgdG8gbWFr
ZSBpdCBzdGF0aWMuDQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQoNCj4rCVtJR0NfUlNTX1RZ
UEVfTk9fSEFTSF0JCT0gWERQX1JTU19UWVBFX0wyLA0KPisJW0lHQ19SU1NfVFlQRV9IQVNIX1RD
UF9JUFY0XQk9IFhEUF9SU1NfVFlQRV9MNF9JUFY0X1RDUCwNCj4rCVtJR0NfUlNTX1RZUEVfSEFT
SF9JUFY0XQk9IFhEUF9SU1NfVFlQRV9MM19JUFY0LA0KPisJW0lHQ19SU1NfVFlQRV9IQVNIX1RD
UF9JUFY2XQk9IFhEUF9SU1NfVFlQRV9MNF9JUFY2X1RDUCwNCj4rCVtJR0NfUlNTX1RZUEVfSEFT
SF9JUFY2X0VYXQk9IFhEUF9SU1NfVFlQRV9MM19JUFY2X0VYLA0KPisJW0lHQ19SU1NfVFlQRV9I
QVNIX0lQVjZdCT0gWERQX1JTU19UWVBFX0wzX0lQVjYsDQo+KwlbSUdDX1JTU19UWVBFX0hBU0hf
VENQX0lQVjZfRVhdID0gWERQX1JTU19UWVBFX0w0X0lQVjZfVENQX0VYLA0KPisJW0lHQ19SU1Nf
VFlQRV9IQVNIX1VEUF9JUFY0XQk9IFhEUF9SU1NfVFlQRV9MNF9JUFY0X1VEUCwNCj4rCVtJR0Nf
UlNTX1RZUEVfSEFTSF9VRFBfSVBWNl0JPSBYRFBfUlNTX1RZUEVfTDRfSVBWNl9VRFAsDQo+Kwlb
SUdDX1JTU19UWVBFX0hBU0hfVURQX0lQVjZfRVhdID0gWERQX1JTU19UWVBFX0w0X0lQVjZfVURQ
X0VYLA0KPisJWzEwXSA9IFhEUF9SU1NfVFlQRV9OT05FLCAvKiBSU1MgVHlwZSBhYm92ZSA5ICJS
ZXNlcnZlZCIgYnkgSFcgICovDQo+KwlbMTFdID0gWERQX1JTU19UWVBFX05PTkUsIC8qIGtlZXAg
YXJyYXkgc2l6ZWQgZm9yIFNXIGJpdC1tYXNrICAgKi8NCj4rCVsxMl0gPSBYRFBfUlNTX1RZUEVf
Tk9ORSwgLyogdG8gaGFuZGxlIGZ1dHVyZSBIVyByZXZpc29ucyAgICAgICAqLw0KPisJWzEzXSA9
IFhEUF9SU1NfVFlQRV9OT05FLA0KPisJWzE0XSA9IFhEUF9SU1NfVFlQRV9OT05FLA0KPisJWzE1
XSA9IFhEUF9SU1NfVFlQRV9OT05FLA0KPit9Ow0KPisNCj4rc3RhdGljIGludCBpZ2NfeGRwX3J4
X2hhc2goY29uc3Qgc3RydWN0IHhkcF9tZCAqX2N0eCwgdTMyICpoYXNoLA0KPisJCQkgICBlbnVt
IHhkcF9yc3NfaGFzaF90eXBlICpyc3NfdHlwZSkgew0KPisJY29uc3Qgc3RydWN0IGlnY194ZHBf
YnVmZiAqY3R4ID0gKHZvaWQgKilfY3R4Ow0KPisNCj4rCWlmICghKGN0eC0+eGRwLnJ4cS0+ZGV2
LT5mZWF0dXJlcyAmIE5FVElGX0ZfUlhIQVNIKSkNCj4rCQlyZXR1cm4gLUVOT0RBVEE7DQo+Kw0K
PisJKmhhc2ggPSBsZTMyX3RvX2NwdShjdHgtPnJ4X2Rlc2MtPndiLmxvd2VyLmhpX2R3b3JkLnJz
cyk7DQo+KwkqcnNzX3R5cGUgPSBpZ2NfeGRwX3Jzc190eXBlW2lnY19yc3NfdHlwZShjdHgtPnJ4
X2Rlc2MpXTsNCj4rDQo+KwlyZXR1cm4gMDsNCj4rfQ0KPisNCj4gY29uc3Qgc3RydWN0IHhkcF9t
ZXRhZGF0YV9vcHMgaWdjX3hkcF9tZXRhZGF0YV9vcHMgPSB7DQo+IAkueG1vX3J4X3RpbWVzdGFt
cAkJPSBpZ2NfeGRwX3J4X3RpbWVzdGFtcCwNCj4rCS54bW9fcnhfaGFzaAkJCT0gaWdjX3hkcF9y
eF9oYXNoLA0KPiB9Ow0KPg0KPiAvKioNCj4NCg0K
