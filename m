Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A712E62A447
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 22:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbiKOVjg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 16:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238871AbiKOVjZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 16:39:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1942ED68
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 13:39:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668548353; x=1700084353;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JvXueCPGqvcBq/CtAsSAMxGbvguR0VwvmRWw29lYP18=;
  b=afQH0TMdLiwSpQ6ja5CquLQ16MWRf6XjLEHY/sNEzZ3uJi3HqDQhGJ1V
   e+c57E06mA1DxTXce2DkTcgdTtrmx109npMYO5Zp6rFJCpaBxKqKIemLm
   8L7+9uCfBE+GnIjkltz768smxWSPJyAJBe41/gMRTKM61j8110RP7Ffwe
   PxfWyiWVk6zVx2VGZZK1/eR8BW4t2gxLnpxGZ98P/86N5wmuYAmMiI1t1
   b+hS/M7vQdaTzEDT60B3NFtSWAqhDIU/5Gc91KA5pTudKFazUfjy+V3jr
   tqm14/5TRbtEzExq5+ijbiWMTJjXiMMrK6Jy9BnkRFQBkA1Zv7FG7/1y4
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="312379874"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="312379874"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2022 13:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="672146746"
X-IronPort-AV: E=Sophos;i="5.96,167,1665471600"; 
   d="scan'208";a="672146746"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 15 Nov 2022 13:39:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:39:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 13:39:10 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 15 Nov 2022 13:39:10 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 15 Nov 2022 13:39:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeZ5yK3kK9Fv47v403RSpdpTCuT4zU8TlCyZ69J0Ku2RvF1hh9D2x3JMvr+8yGqImGPN1MYYVDNih6lcJamgCn/VjHO7WIYZ7c5rD01v4sbOZY7MVB3mNdROnLbFLm5QGZYLDiIdW3J3K9QUCrpjcoKU305H3Z5coLSnXKkGc70+IQEUhRo4DIZTfVFYt3KoUIeSC65rZ8y3ZWDDT7Ge4goSxWEY6Bz85qOKQeRCpF3q1t6Sfm15l/K0Hxhe5wOoAgEcAGbO3NtgJj7XFgmdp/ljShy64Qz21d2OPktt0bmusQ4ibImYsGExF6qUnEpZdZ4666NOeARcMDAcA2xZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvXueCPGqvcBq/CtAsSAMxGbvguR0VwvmRWw29lYP18=;
 b=NrVxUzwGFQXD3pKEtCG//804iieKIUfrC1Gw1dbX4+fJggveP0aULzNqy+5cNL8HmP9C2/VzNm9D+E1hXUX6unseP3RUYFyKiGX5/Pt9svMYS8DwBpKMn1+ut/4WZ4zgEksFFzbGL445z9P7eCAMyGhLZtTjEHrdOZVQ6RPRSBLE7O4RoSLDPg3dQv+/5goZ8fbzF/pnM8QQWMtlAfJWKwkEcYDLTzgjONTlgakIde5FjQBruFPRWtnRPU+vSkBTuklD7h9jmNxeTKBkvFO+JmtFfZ0IkTeMxy0y6/JqzC02h986MnGvvGVph97Ei++8L/uNKZ/Z0m8bvWpt590vKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DS0PR11MB7405.namprd11.prod.outlook.com (2603:10b6:8:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 21:39:08 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Tue, 15 Nov 2022
 21:39:08 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC6405DmAgABab4CAATUtAIAAYNkAgAXcgACAAjjUgIABn7gAgAAFswA=
Date:   Tue, 15 Nov 2022 21:39:08 +0000
Message-ID: <a0bea8c90acc70bc67210eb890447d51fb7315de.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <Y2o9Iz30A3Nruqs4@kernel.org>
         <9e59a4e8b6f071cf380b9843cdf1e9160f798255.camel@intel.com>
         <Y2uMWvmiPlaNXlZz@kernel.org>
         <bcdc5a31570f87267183496f06963ac58b41bfe1.camel@intel.com>
         <Y3DITs3J8koEw3Hz@kernel.org>
         <CAPhsuW4zKABHC_Stwnkac05Lvww4C_tz-T4JfALDcQusRmsCEw@mail.gmail.com>
         <Y3QCNCNW31lB37El@bombadil.infradead.org>
In-Reply-To: <Y3QCNCNW31lB37El@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DS0PR11MB7405:EE_
x-ms-office365-filtering-correlation-id: b2bb60d6-72df-4bbf-835c-08dac751d3e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePYO28g7W+0otERE7wC8/jsvX5grFON/teKZXALNbTfJ/IYUfoOICy+fjxIMxMgo2+lEcOrhYdQ6hmLoOc1FGKO9vfaHoccSqiqcmZj1uHAd1tqw4ElU+ePhoLyfJrUJLqt3Ixa9SfgA/6wctCGvCP3kOjfbPciQRmzSP4vjEyfYGbmSR8MuIb17ml8ATA0Oifux4AFi2GxFqSPb9sPE4bCmybXYy+u6EAm6iHRSs0fW6/PXuzkBperKrefQnQZ2BGHNk18mj1yv2OTBxE/4dhue4lt6bo4wzoZXR37seFtwxT+bt/kwpW7oMIluv+PsKSrnhchMndCwpaEND6LemVe18vhCL3SRUUgbPHUkMN3TfXYWGOxZhHnLzxltIwxc0b8eyDooi+aH6TFeKfFzPQYxgg0HrJYI/0Jw41tW+7d+BLjfHh9yFiLT/pe84upwGUh0M1puLY3O8hlcn1Z20vJY/KTNZVk5goeRo5ZW5GzZGTHv38xHzTj0TKRbN+afBI11zA0pYWpOV/xPQYvUOpFrJ2aqazdxEII6+T1dqojHGqdXKeWPYp/zS2CLl32aSgIoaCnB1BI2/LmtwR9LQ8H2GQ6mc3YLfqrIsLBQxma+l2k5ceX+1XQ0dKSMzAwcjW22g1zp1JNyNlRokXRWV1Zsy4rQ7jr2pZRo/2BfAhs6L5IychI6g0mP2+aT2A3MgbXIZvm+2UiRh+VyOf0ovBLZdaelaEzzmFuqIZwxc8TCjjIADxobyESopNSWdQo5bwZAHhl0qeieEB62JeoMBjGYOG+g8xhERaQJsfp/Uwo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(76116006)(4001150100001)(2906002)(64756008)(66446008)(91956017)(122000001)(66556008)(66946007)(66476007)(41300700001)(4326008)(8936002)(4744005)(8676002)(86362001)(5660300002)(82960400001)(36756003)(38100700002)(54906003)(478600001)(38070700005)(110136005)(71200400001)(6486002)(6512007)(26005)(107886003)(6506007)(66899015)(186003)(2616005)(316002)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1hWSERFN0Z1OVRMelpVbG9rTzFucCtnYkUyUGJXRGZlcDNLNmJUb1BRc28r?=
 =?utf-8?B?U2VKRHVzYm1aSU5yTm10b1U2NkloMHRDV3hlSTB3L0FPQlUvZ0VGZFhQaWFu?=
 =?utf-8?B?WTBDWlk3T0hSb1NHZ01iRWJRZmpCc0h4Y3NYYUJPY2IveldkZ2hRTTRHeExy?=
 =?utf-8?B?SytVYU9pSkRPbGhCdFN3ZGp0ODJxZWtVUGEwMVc5VEVsN0t1OTRsd0ZhWWV5?=
 =?utf-8?B?QjgyK1J6Rjk2UEpJZ1Y5bWhGUnZUemsyNWxITzdqZlpac3dYUEh6OGo1aXIx?=
 =?utf-8?B?NTJDQkpDVlpITW8rYkNZellpNVErYmlvczh6MXl5MHB0Z0FrdVBpendWWlJN?=
 =?utf-8?B?bkRMQy9jM0RyQWVmRk9GRk1uMi8yeUlNeUQzSE4zN3YyTVhtemd0V2YvVThC?=
 =?utf-8?B?NDRhMEpnaTlnd2xrYU1keDE3VDJIQU9HbVZibVUxS0NOcy9vcE1icVFHRUtm?=
 =?utf-8?B?Zm9VZHRTaEN0S25LUEdpQjRqZXVlTHllRjdEREZnRkVqN01KcFNiZFh4K1VP?=
 =?utf-8?B?alNaWUtmbU9qSXIxMEYyYjlNN2lmS091WnVqcFVEbk1QaXJkUVRoVzJCUGhX?=
 =?utf-8?B?L0FVT1YyTi9JZVZUdmFkYVJ4SllnUklNaCttcGpLd0Mwd1JBbUFnaFVJaEl5?=
 =?utf-8?B?VkhGK2lKYTU3dFhNR0tQS0VZTk9LbmhhZ0d2SGR5djY0OUpnQmFYRUN6VEFN?=
 =?utf-8?B?R3paNWVxQ3dDM3dJTDlXOHZQSTNTNVNoNnFabU5FMEVKdlJBUGVGUlhkdHFI?=
 =?utf-8?B?NXh5YVc1UEM0ZUI3RjdSU1VaTWRZWm1KaTl4WDJMYnhNcDZmekNEdG92TlU0?=
 =?utf-8?B?VG9PRVFwelRZWkhpa1RZMWlBaWpDVDBsZEhwWnRnYSt5Z0R2eVRUMzlLZS9D?=
 =?utf-8?B?SW1kMGR2OEhlUkVZdW5MeEVMbHR0ZkNReDdSWlhodCsrTUhOOWQzMlY4S212?=
 =?utf-8?B?QjZ6YW5EQ3V4K1E1U0U2WldQRkpjT1F6dytPcFlrT2Z6Vis3M0x0ZUNDQ3h0?=
 =?utf-8?B?ZW5Cc1k0QVJMRlppSy9ndGFTczZTeHhDbDMrbVBxTTFmSXdpMEFDZEtsOFpY?=
 =?utf-8?B?NVN3WVY4RExVaDhVaEt4TmY3Z0ZiMDJqZnFTOWF5L1EyTjhyeEV2Rk1qMDl1?=
 =?utf-8?B?UkE2T0V4SHNKTUlRN1NwK2phSy9iSFlXZWlTRU5uTGxTcDk4cmVhM0dJNEFx?=
 =?utf-8?B?N2xuOUsyTjNqekt2aldGTGVmVUp5RnM3TnZseG56OERyR1BaMDdlVnZvZzZH?=
 =?utf-8?B?bE5WWXQ1dG8rNnI4d0tCZjY3bU8yNWJaSkRVekhBVUthWmQ2dkdZYXBVSFpI?=
 =?utf-8?B?LzdIamNqb1RmQUJ1SlhIcHduZTFFaFVmUGY4QlRCK2gvT045K256VHpMdFZ5?=
 =?utf-8?B?MklKeGpwRlBQdjliZ0wvdXBwVHgveXVFcHQ4YWRPZFhzSWkwTmVod1NuQ3I0?=
 =?utf-8?B?d1VicWZ6SjhwbXBTODQwVkxPRk9tbzA1Y3AzSHc3L3gvS2F2ZE1EYmxtb1hy?=
 =?utf-8?B?ZVpmd2Qrc003dWRTQXJ0NXhSWmZzdUMvaUxQUkttdzg2QnJLeTlGV0RPd3Mx?=
 =?utf-8?B?cEIxb2lnVDVxWUdNQ2ZvUnhnZVZsRXFxZ0FXUXpORkxxMi8rZ09hLzAvdFhK?=
 =?utf-8?B?aW9IdE5aZlhjMUN2V2ZrY2pHTUt3YWdKTGkvUlIrbnZqZ2dLQ1FwOVlZRm8z?=
 =?utf-8?B?ZmZSVVRzZmdqcU8zeVBQK0NOSjVoNVRhTU41bjRrRWduaHFmdFpyVVplMzB1?=
 =?utf-8?B?MlNpRVd5Y1N5eVlTNHNrNDhRYXFIRTZCNWpvc2EveUcvT09taWNJU0FYc0Vt?=
 =?utf-8?B?VzJZVFpxQi9WVmx3dVhNd0dybDZwU1hTWlhZYTVnbmsrcmY5ZENOT3pjVDM5?=
 =?utf-8?B?QzFWNXlyLzJCOUxNd3Q4ZjNaS09CWGlBMXN4amNxOEJLZytZTWNpWFRUbk5B?=
 =?utf-8?B?YVBoNnBXejFRWHhoMjVNSHoxbXdSMlMyaElrcWd5a3YyQWRhZ2VnL3VRaUpE?=
 =?utf-8?B?azNteTJvUUtSa3ZIVldLb0lMRmxZWktIYTBIQnErTGZrWXlIVDM2OXQzNlNN?=
 =?utf-8?B?TUxSOXJ5ZXhJVGNCYkZpNlFEY3gyUEVjMUN1eDNhbE5RS3puWkdSUTFNQ3d0?=
 =?utf-8?B?Z1FHaGFtOWVLZXlpTXVkOGx2UjFFMnFyYUMwVnVpZm1CNWltajlLOGVBNmZY?=
 =?utf-8?Q?JMpnE66N5BH95c19TctN5ig=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <408673FCCA14A64995BFB4049343DA12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bb60d6-72df-4bbf-835c-08dac751d3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2022 21:39:08.7124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kEexz01pooFus7a1FVnM8GfR2nLsVs9vvZZDrO6q5JIu2Uv4R6CGxObgNRy8zIvUquQBEFCFybQb1oL3ht1lpFYEYlZ2T7N2dzOgNpGyHxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7405
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDEzOjE4IC0wODAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBUaGUgbWFpbiBodXJkbGVzIGZvciBtb2R1bGVzIGFyZToNCj4gDQo+ICAgKiB4ODYgbmVl
ZHMgc3VwcG9ydCBmb3IgQ09ORklHX0FSQ0hfV0FOVFNfTU9EVUxFU19EQVRBX0lOX1ZNQUxMT0MN
Cj4gICAgIHRvIHVzZSB0aGlzIHByb3Blcmx5DQo+ICAgKiBpbiBsaWdodCBvZiBsYWNrIG9mIHN1
cHBvcnQgZm9yDQo+IENPTkZJR19BUkNIX1dBTlRTX01PRFVMRVNfREFUQV9JTl9WTUFMTE9DDQo+
ICAgICB3ZSBuZWVkIGEgZmFsbGJhY2sNCj4gICAqIHRvZGF5IG1vZHVsZV9hbGxvYygpIGZvbGxv
d3Mgc3BlY2lhbCBoYW5reSBwYW5reSBvcGVuIGNvZGVkDQo+IHNlbWFudGljcyBmb3INCj4gICAg
IHNwZWNpYWwgcGFnZSBwZXJtaXNzaW9ucywgYSB1bmlmaWVkIHdheSB0byBoYW5kbGUgdGhpcyB3
b3VsZCBiZQ0KPiAgICAgaWRlYWwgaW5zdGVhZCBvZiBleHBlY3RpbmcgZXZlcnlvbmUgdG8gZ2V0
IGl0IHJpZ2h0Lg0KDQpIb3cgd2VyZSB5b3UgdGhpbmtpbmcgbm9uLXRleHRfcG9rZSgpIGFyY2hp
dGVjdHVyZXMgbG9hZCB0aGVpciB0ZXh0DQppbnRvIHRoZSB0ZXh0IHJlZ2lvbiB3aXRob3V0IHRo
ZSBmYWxsYmFjayBtZXRob2Q/IFNwbGl0IGxvZ2ljIGluIGNyb3NzDQphcmNoIG1vZHVsZXMuYz8g
U29ycnkgaWYgdGhpcyBpcyBjaGFuZ2VkLCBidXQgbGFzdCB0aW1lIEkgd2FzIGluIHRoZXJlDQpJ
IHJlbWVtYmVyIHRoZXJlIHdhcyBxdWl0ZSBhIGJpdCBvZiBjcm9zcy1hcmNoIGNvZGUgbG9hZGlu
ZyB0ZXh0Lg0K
