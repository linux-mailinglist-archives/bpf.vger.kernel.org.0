Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F19F52ABBF
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346100AbiEQTPI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbiEQTPH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 15:15:07 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D9435275;
        Tue, 17 May 2022 12:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652814906; x=1684350906;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EhlMMtnV9z11ON7cFT2LuVOyrcZN8UV9uJbb8KeCbIk=;
  b=Tmpc6gjdWo+BS9Jm6C7t+l8EETBz38koXaNpcPH6YEu4p+jqn9z8NMEB
   Lps+6b5e//T4Y2CEmGd2om/Pkk5mSk/6cRhu4I7u5X+KmGZTm5C+9isnS
   dzfDq19RFoHGxeEUzT+S7LZQjrbGy2R3GU5rEwdKz1qYNSCUsJj24OwKi
   V3ovik1VQ/wg632SdhsB9Rj10MmUiEnePLcmL37wTKRJqWSBdPgFfjFaN
   4BSHQnbrigwDAGafe0PMoSiHc+Mhh3DrHG+1m3f84NVZKm60GDigKmV+D
   8EwzjzmxoQ1cE1iCmfSsLt0JuOFv/bkx1o7aNqeu93HMldMeyA3GNT6TD
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="331911854"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="331911854"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 12:15:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="605499353"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 17 May 2022 12:15:05 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 12:15:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 12:15:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 12:15:04 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 12:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixKpmFiddPCaZMGYuUmy+qnFZiuOx8xzSaq0hXNXjTvon6rj1JDQiiwnNZrdklAjjgkBVypJi7pRnZksbqBuE44JsvQ9NmMrHDU/Q7IxQrZZ04Oph5y2JBwX1i4U/5tx3B415yeAvIXBj6wSVkFXVYYmIXrMwAixdXagSXjzVBOOzu/6yoxK1GR0SVKK7Bj//bKLsc3A3GCS8JRkuIB7xrdnVEv7SeHrmDrq42oW1gafZ6tlkNY3cg5fuqGWodxuPJSIfMpVWnz/uqddnzALMilBGu67XVE7udoXCwQx9myA1EX/dFGmq+Ym5OT/ZnVeRg0tcMGKgoe7Z1xCSTzCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhlMMtnV9z11ON7cFT2LuVOyrcZN8UV9uJbb8KeCbIk=;
 b=lcbaHfWT8FakQrs/yUNjNvGF1WTv7FfaFPQJN4H8UsIXd83Z0SCYDuA4aKk7k5sHBqQXhfSe68ZMXb9Q7+kwEHrMs6xrZDd3Q8nNE8ymgWcXK/oaYd2Hrwue0AXUA3z2quCaYRoVTYu0yzzaR7ccG9g3HVHR2UrqJ9eQycVy8BocD23oq8ad9CEBlwYRHP7isdmN1YvM/pU1iJimPPPD8uiHygp3MI+lMd1qehzgNa60w0Xz648d6bqAUhPwXSS8o+XfWc/oq7KR/VX1N4T2lI1MzHQu8YKUQmDqveSKw9OP/F/NRfnIfGAobv3SeP5R9N0fEVtJVGfC+iLGP8Dwow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN6PR11MB3392.namprd11.prod.outlook.com (2603:10b6:805:c5::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Tue, 17 May
 2022 19:15:02 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Tue, 17 May
 2022 19:15:02 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for bpf_prog_pack
Thread-Topic: [PATCH bpf-next 5/5] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYaOe12KXACXSTpU+YN3bK6iMF8a0jcwCA
Date:   Tue, 17 May 2022 19:15:01 +0000
Message-ID: <83a69976cb93e69c5ad7a9511b5e57c402eee19d.camel@intel.com>
References: <20220516054051.114490-1-song@kernel.org>
         <20220516054051.114490-6-song@kernel.org>
In-Reply-To: <20220516054051.114490-6-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7b76ac0-4cc4-498b-2922-08da38398ade
x-ms-traffictypediagnostic: SN6PR11MB3392:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB339244AC07F787E59A22B81BC9CE9@SN6PR11MB3392.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1KgcerHuU1YQSmkZCusEbc4mcyRqckNSbfSQQwNr2oKgdZYh6zjGVNb5R75I+5Ng01jPS31B4oN65qZzd0f+Ao9i4oMOnVhb9ZVmig1QL+4etw/7eMYgeofSBkmR4LV3g2KWsHdcAj1911ouiHwDkXpFaxIWyeqeIftSDYhhPI1zoIXFdWao/L2600en8wPVCGW4n1XaV1XKlsXv8YwaIRU+vCUJYmlWs3u2pJxAxbc89o2y05SeKiCyxyiaCByKyuAJEfCU27kZU3wFNatYBkwEhYub/0Cl6jQMJWQbstG0rMmj0j7gS4B8C3wLzwmQ10a34j0AYXXM214xCtuSvzjtnzm+LsF6aDXpHB1u8ErvCrWVwcbok/dFkB+nNTVKKfzIy4lNWYc49wQJJH/51cV10kwzIMvJdU+lfnQHyX1Ca+zJnQr/Cqpnb2sOJR4l6f0EzggTHk0gIdllhzFZSyP961E+8gRfJVS5UkSsYTAGn1ZQvkVJao3xsgsu4NIa0rdto7i9r6XyW4q7KxWuuLkrFWdwMnzeCCktIKvy6wfF4McLZzKcZjmxtpRONyuQKWVFfu5k4qJPr2tYCKhliHX6k5RjAOS0qPuKmFTKn4Cj07Ll4WeXzLL9zCNsmQw0n9zQEzwQ/gUSC89nqUsNlQ3HQDeP099EtDVIRfdSn1316os82f8qZOMJbOti5KXulHk2jlrF58uQpkV+JiemDIrSMfO88dWINvBopCltMlqe00L4Y+wHnMb3C4KcSim0TNr+KZLx0B55zH5Lc0HasIdrkCzBtLpqPoQCXCSPOKXaZ51B29CMcwXa0Zv8J+kwQOADlgz+9fumtRiNwXFeaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(4326008)(36756003)(83380400001)(64756008)(91956017)(8936002)(122000001)(2906002)(66556008)(76116006)(66476007)(66446008)(66946007)(6506007)(6486002)(8676002)(110136005)(86362001)(508600001)(2616005)(316002)(82960400001)(26005)(54906003)(6512007)(71200400001)(38070700005)(38100700002)(186003)(5660300002)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEIxZHBRZ3gyeVJueklXWTRTRnJsUXFBTEw3ZXZ0RmRvTWFqQm1idXN4clgr?=
 =?utf-8?B?eE1iY1BGa1hSMWZrM0RUeWpiVmorK0kwLzNvd1ZBUlRzR1MvTGVmdzBaUXB4?=
 =?utf-8?B?eTNVR0IrS3ZadmFYTHBvYWh4eXI4dkVUM1V2TmZVd0V3WG4xZVhFSTE0T0hw?=
 =?utf-8?B?WEJQREhza3hrUmNxc2FjUWpmaVp2WjlPY3lsaDYyVzBCQWxVWnVJYVNFTlhs?=
 =?utf-8?B?RThoSWl0LytSWndRSXhZM2RTQVNDVCtKWk9PMXN4Zi9EZ2pnR3cvVi9WTGxr?=
 =?utf-8?B?UDVGamRWUElxZEMvQmRkaTdZakN4N3hiOXVSTkNtOG9sSWVUMVFSckN3aEpU?=
 =?utf-8?B?ZDlnejFsUm1uTkdBZkkvM0FQQlFzMlNhdFQ2YkN4aDJZek1Oc1phTENzTlNO?=
 =?utf-8?B?VXdUNjcvdGlsUUVmcHlReEdaRUdNSUR1WUZwNlRvbUVZbUR4dEZBVkExUSt3?=
 =?utf-8?B?UHhpNzhyZmFTeDZBN2tOV0lsK0M2UDZQNUlUT3E5S0thRVNxeVQxZ0V6Q3pD?=
 =?utf-8?B?eFFOTzVkYkdFbWRSWmVHSWFXU3VrSXhjczQvYXU1b2QwMjRQZ0FBSkpGUGtt?=
 =?utf-8?B?WlArN3Z4Qndvem9BQWt1am5xM3F6M09nblRWZFFGYWQ4QXZIbVFBeVMxSXBV?=
 =?utf-8?B?T1hTTnQ2MHYzSW5KSVFHSFArRnFXbmNQWFJxWVM4SzZ4L3UxY3B6TnkrVU9L?=
 =?utf-8?B?bnFHaEFocDlBbXl2dTVZVEF2NWZ0b2dpUUJDc0NZdXJtcUJyRGNVMGtzb1Rs?=
 =?utf-8?B?VXVMbXdqdXBRWkhpMWVoYmRtei9wZUgwQ2MwdkVsbTB6UTBJd0c1WTBJQmlJ?=
 =?utf-8?B?Q0NJb0c3L1F5WU5pUkhSeTFBb3BnVnMrdTltZys1MklCbDdwbHNWSmpoY2tr?=
 =?utf-8?B?ZVVIYlNaQisrWU84YVpDRnRJTXAvaHVqbGhxbVJjdlZpR0RvQnJHdzEvR0xt?=
 =?utf-8?B?TWtpOVpzLy91OWlzSzZXRkFzV3Urc1RSVVp4S1VDNEptYlpKd3RmT2xOZFRU?=
 =?utf-8?B?NE9VcGZLd2pjeUhtOHlEZFQvcjQrMmNRS280eTR0cHN5SzRXMW51VmxacVRN?=
 =?utf-8?B?ZFd6NXZXMEZlWlpPd1E3dmFub1NaYzQ1Zm5WWFJYbzR1MVJ5c2lPM0Q2bm9H?=
 =?utf-8?B?WVBCRmZKWE11cDIyZWpEakdxY3BXQlQ4NXF5N0pMWjk1dEo4SlVCSnZqNlB0?=
 =?utf-8?B?bGZLUkJpQ0JCUlo4VndBWVJLVjh0MjlYaUxtMFQweGRwZFdnbTRYMGxtR2RO?=
 =?utf-8?B?OEYzTVpidm9tN2pwSVJyc201YUxROWpIMGIvaGs5Q0IyWDJOZzBleDZzcUdp?=
 =?utf-8?B?eUhUcXRKN3VNSFBUMWwvMm5adU5ETnM5d0RTSlhUTFJ1TTFiSHhJakZvQVZO?=
 =?utf-8?B?Z201ZllmMnhEam8yWlVRSHFwMkNhZWtLMWtnaW1JTjdGZkx0aER5cldxM2w4?=
 =?utf-8?B?NnNsUW9RZTlzam5VTWlMRUo1VGtFbGJ3MjNQSERRdnI1MHRhSXZCMUxHN0Fy?=
 =?utf-8?B?L3dKc2h4cDhSOWhLOXN3aEgyVTBHTFpjd1EweWZDRlJnSVlqTVQ5U2R4WWdT?=
 =?utf-8?B?V3dKbXBvYllhSDdrVStnSk5XUU9BSCtiUVBoYXlTeVdMbDVwVi9GZHB5QTlj?=
 =?utf-8?B?MmNVUXNHaVZzNFkvUytoenY5c0J0bW9BUHAzU2FBNFNWWnd5dGdWa2orUEZW?=
 =?utf-8?B?dFBSbUpMTjI3SHZobDc2VEJsSmFwdEYzbS8rL0Zkc2xiRTFwYXltNk1QU0Rs?=
 =?utf-8?B?QVZPZDZMemh3ekd1b0VWUUZJYnlmZXhxVGNiZnA5SEVsallvTmlXZDlxNCtJ?=
 =?utf-8?B?Rkt6VlpTeUlrSWh2YS9mT1hNOVNLL3M2S1VFV0IrRWt5b3Z6b1VjcnZoN2l3?=
 =?utf-8?B?ZzIwak13OGNuRDh0UUE1OW44ZnFMM3hsbGkyTk5OenpnUjhmSGkreWpmTk01?=
 =?utf-8?B?WFZ2WHcrTFN2NkZieWR0cHFudnJLeU10eUh6ejFaNGNmYVlNZzExWiszR1E2?=
 =?utf-8?B?RUhlKzJmQVRieTJWU3kzOEI4WFZJRjZybk9BaGJEeTQwbS9jZ2c5U05pd3d1?=
 =?utf-8?B?ZmMwTEV5MzQzV0RYYVIwWmVuTnhhbGNVOXEya1Z6ZGhJb2cvQlBYMDdpU0tY?=
 =?utf-8?B?NEYrTFZiYUcvNW0vaTkxRHB1RFlNYnpYcnFUZ3RESWs4a0RJd3RIQ01ubkV3?=
 =?utf-8?B?d256U3VQUnVNTmViMjZ2dEkvWDRrMnllQy8yRVd5Q2xlNTZISDdSQzBKOG83?=
 =?utf-8?B?L3RPM2d5S1hEa01yOWUzb1BPdFV5d1JjZFo2NnhCeVd3YlZUMUl0aXVXczFm?=
 =?utf-8?B?dDFzZ1IxYXhEUXFVQWp3ektOK20rZkg0ejQ0SmkwSVhpazVYMFF1ZGJPWjgr?=
 =?utf-8?Q?6jTm19827zJ8+LPAlcyrWVKROqu2sB5RONAJI?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EE4B98D15FDC448BC66383578C1FE2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7b76ac0-4cc4-498b-2922-08da38398ade
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 19:15:01.9984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P5LQabm8klngepo0JXWPTw9Z7ZwEVOsFzWq+TBmb8K1kzH/RyTM3h6fronzlQyavuvRpEsTZXHcuCTrey31eGUYQTleyQ0AcGOba5DPkOPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3392
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU3VuLCAyMDIyLTA1LTE1IGF0IDIyOjQwIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gVXNl
IG1vZHVsZV9hbGxvY19odWdlIGZvciBicGZfcHJvZ19wYWNrIHNvIHRoYXQgQlBGIHByb2dyYW1z
IHNpdCBvbg0KPiBQTURfU0laRSBwYWdlcy4gVGhpcyBiZW5lZml0cyBzeXN0ZW0gcGVyZm9ybWFu
Y2UgYnkgcmVkdWNpbmcgaVRMQg0KPiBtaXNzDQo+IHJhdGUuIEJlbmNobWFyayBvZiBhIHJlYWwg
d2ViIHNlcnZpY2Ugd29ya2xvYWQgc2hvd3MgdGhpcyBjaGFuZ2UNCj4gZ2l2ZXMNCj4gYW5vdGhl
ciB+MC4yJSBwZXJmb3JtYW5jZSBib29zdCBvbiB0b3Agb2YgUEFHRV9TSVpFIGJwZl9wcm9nX3Bh
Y2sNCj4gKHdoaWNoIGltcHJvdmUgc3lzdGVtIHRocm91Z2hwdXQgYnkgfjAuNSUpLg0KDQowLjcl
IHNvdW5kcyBnb29kIGFzIGEgd2hvbGUuIEhvdyBzdXJlIGFyZSB5b3Ugb2YgdGhhdCArMC4yJT8g
V2FzIHRoaXMgYQ0KYmlnIGF2ZXJhZ2VkIHRlc3Q/DQoNCj4gDQo+IEFsc28sIHJlbW92ZSBzZXRf
dm1fZmx1c2hfcmVzZXRfcGVybXMoKSBmcm9tIGFsbG9jX25ld19wYWNrKCkgYW5kIHVzZQ0KPiBz
ZXRfbWVtb3J5X1tueHxyd10gaW4gYnBmX3Byb2dfcGFja19mcmVlKCkuIFRoaXMgaXMgYmVjYXVz
ZQ0KPiBWTV9GTFVTSF9SRVNFVF9QRVJNUyBkb2VzIG5vdCB3b3JrIHdpdGggaHVnZSBwYWdlcyB5
ZXQuIFsxXQ0KPiANCj4gWzFdIA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9icGYvYWVlZWFm
MGI3ZWM2M2ZkYmE1NWQ0ODM0ZDJmNTI0ZDhiZjA1YjcxYi5jYW1lbEBpbnRlbC5jb20vDQo+IFN1
Z2dlc3RlZC1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0K
DQpBcyBJIHNhaWQgYmVmb3JlLCBJIHRoaW5rIHRoaXMgd2lsbCB3b3JrIGZ1bmN0aW9uYWxseS4g
QnV0IEkgbWVhbnQgaXQNCmFzIGEgcXVpY2sgZml4IHdoZW4gd2Ugd2VyZSB0YWxraW5nIGFib3V0
IHBhdGNoaW5nIHRoaXMgdXAgdG8ga2VlcCBpdA0KZW5hYmxlZCB1cHN0cmVhbS4NCg0KU28gbm93
LCBzaG91bGQgd2UgbWFrZSBWTV9GTFVTSF9SRVNFVF9QRVJNUyB3b3JrIHByb3Blcmx5IHdpdGgg
aHVnZQ0KcGFnZXM/IFRoZSBtYWluIGJlbmVmaXQgd291bGQgYmUgdG8ga2VlcCB0aGUgdGVhciBk
b3duIG9mIHRoZXNlIHR5cGVzDQpvZiBhbGxvY2F0aW9ucyBjb25zaXN0ZW50IGZvciBjb3JyZWN0
bmVzcyByZWFzb25zLiBUaGUgVExCIGZsdXNoDQptaW5pbWl6aW5nIGRpZmZlcmVuY2VzIGFyZSBw
cm9iYWJseSBsZXNzIGltcGFjdGZ1bCBnaXZlbiB0aGUgY2FjaGluZw0KaW50cm9kdWNlZCBoZXJl
LiBBdCB0aGUgdmVyeSBsZWFzdCB0aG91Z2gsIHdlIHNob3VsZCBoYXZlIChvciBoYXZlDQphbHJl
YWR5IGhhZCkgc29tZSBXQVJOIGlmIHBlb3BsZSB0cnkgdG8gdXNlIGl0IHdpdGggaHVnZSBwYWdl
cy4NCg0KPiBTaWduZWQtb2ZmLWJ5OiBTb25nIExpdSA8c29uZ0BrZXJuZWwub3JnPg0KPiAtLS0N
Cj4gIGtlcm5lbC9icGYvY29yZS5jIHwgMTIgKysrKysrKy0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgNyBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9icGYvY29yZS5jIGIva2VybmVsL2JwZi9jb3JlLmMNCj4gaW5kZXggY2FjZDg2ODRjM2M0
Li5iNjRkOTFmY2IwYmEgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9icGYvY29yZS5jDQo+ICsrKyBi
L2tlcm5lbC9icGYvY29yZS5jDQo+IEBAIC04NTcsNyArODU3LDcgQEAgc3RhdGljIHNpemVfdCBz
ZWxlY3RfYnBmX3Byb2dfcGFja19zaXplKHZvaWQpDQo+ICAJdm9pZCAqcHRyOw0KPiAgDQo+ICAJ
c2l6ZSA9IEJQRl9IUEFHRV9TSVpFICogbnVtX29ubGluZV9ub2RlcygpOw0KPiAtCXB0ciA9IG1v
ZHVsZV9hbGxvYyhzaXplKTsNCj4gKwlwdHIgPSBtb2R1bGVfYWxsb2NfaHVnZShzaXplKTsNCg0K
VGhpcyBzZWxlY3RfYnBmX3Byb2dfcGFja19zaXplKCkgZnVuY3Rpb24gYWx3YXlzIHNlZW1lZCB3
ZWlyZCAtIGRvaW5nIGENCmJpZyBhbGxvY2F0aW9uIGFuZCB0aGVuIGltbWVkaWF0ZWx5IGZyZWVp
bmcuIENhbid0IGl0IGNoZWNrIGEgY29uZmlnDQpmb3Igdm1hbGxvYyBodWdlIHBhZ2Ugc3VwcG9y
dD8NCg0KPiAgDQo+ICAJLyogVGVzdCB3aGV0aGVyIHdlIGNhbiBnZXQgaHVnZSBwYWdlcy4gSWYg
bm90IGp1c3QgdXNlDQo+IFBBR0VfU0laRQ0KPiAgCSAqIHBhY2tzLg0KPiBAQCAtODgxLDcgKzg4
MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgYnBmX3Byb2dfcGFjaw0KPiAqYWxsb2NfbmV3X3BhY2soYnBm
X2ppdF9maWxsX2hvbGVfdCBicGZfZmlsbF9pbGxfaW5zDQo+ICAJCSAgICAgICBHRlBfS0VSTkVM
KTsNCj4gIAlpZiAoIXBhY2spDQo+ICAJCXJldHVybiBOVUxMOw0KPiAtCXBhY2stPnB0ciA9IG1v
ZHVsZV9hbGxvYyhicGZfcHJvZ19wYWNrX3NpemUpOw0KPiArCXBhY2stPnB0ciA9IG1vZHVsZV9h
bGxvY19odWdlKGJwZl9wcm9nX3BhY2tfc2l6ZSk7DQo+ICAJaWYgKCFwYWNrLT5wdHIpIHsNCj4g
IAkJa2ZyZWUocGFjayk7DQo+ICAJCXJldHVybiBOVUxMOw0KPiBAQCAtODkwLDcgKzg5MCw2IEBA
IHN0YXRpYyBzdHJ1Y3QgYnBmX3Byb2dfcGFjaw0KPiAqYWxsb2NfbmV3X3BhY2soYnBmX2ppdF9m
aWxsX2hvbGVfdCBicGZfZmlsbF9pbGxfaW5zDQo+ICAJYml0bWFwX3plcm8ocGFjay0+Yml0bWFw
LCBicGZfcHJvZ19wYWNrX3NpemUgLw0KPiBCUEZfUFJPR19DSFVOS19TSVpFKTsNCj4gIAlsaXN0
X2FkZF90YWlsKCZwYWNrLT5saXN0LCAmcGFja19saXN0KTsNCj4gIA0KPiAtCXNldF92bV9mbHVz
aF9yZXNldF9wZXJtcyhwYWNrLT5wdHIpOw0KPiAgCXNldF9tZW1vcnlfcm8oKHVuc2lnbmVkIGxv
bmcpcGFjay0+cHRyLCBicGZfcHJvZ19wYWNrX3NpemUgLw0KPiBQQUdFX1NJWkUpOw0KPiAgCXNl
dF9tZW1vcnlfeCgodW5zaWduZWQgbG9uZylwYWNrLT5wdHIsIGJwZl9wcm9nX3BhY2tfc2l6ZSAv
DQo+IFBBR0VfU0laRSk7DQo+ICAJcmV0dXJuIHBhY2s7DQo+IEBAIC05MDksMTAgKzkwOCw5IEBA
IHN0YXRpYyB2b2lkICpicGZfcHJvZ19wYWNrX2FsbG9jKHUzMiBzaXplLA0KPiBicGZfaml0X2Zp
bGxfaG9sZV90IGJwZl9maWxsX2lsbF9pbnNuDQo+ICANCj4gIAlpZiAoc2l6ZSA+IGJwZl9wcm9n
X3BhY2tfc2l6ZSkgew0KPiAgCQlzaXplID0gcm91bmRfdXAoc2l6ZSwgUEFHRV9TSVpFKTsNCj4g
LQkJcHRyID0gbW9kdWxlX2FsbG9jKHNpemUpOw0KPiArCQlwdHIgPSBtb2R1bGVfYWxsb2NfaHVn
ZShzaXplKTsNCj4gIAkJaWYgKHB0cikgew0KPiAgCQkJYnBmX2ZpbGxfaWxsX2luc25zKHB0ciwg
c2l6ZSk7DQo+IC0JCQlzZXRfdm1fZmx1c2hfcmVzZXRfcGVybXMocHRyKTsNCj4gIAkJCXNldF9t
ZW1vcnlfcm8oKHVuc2lnbmVkIGxvbmcpcHRyLCBzaXplIC8NCj4gUEFHRV9TSVpFKTsNCj4gIAkJ
CXNldF9tZW1vcnlfeCgodW5zaWduZWQgbG9uZylwdHIsIHNpemUgLw0KPiBQQUdFX1NJWkUpOw0K
PiAgCQl9DQo+IEBAIC05NDksNiArOTQ3LDggQEAgc3RhdGljIHZvaWQgYnBmX3Byb2dfcGFja19m
cmVlKHN0cnVjdA0KPiBicGZfYmluYXJ5X2hlYWRlciAqaGRyKQ0KPiAgDQo+ICAJbXV0ZXhfbG9j
aygmcGFja19tdXRleCk7DQo+ICAJaWYgKGhkci0+c2l6ZSA+IGJwZl9wcm9nX3BhY2tfc2l6ZSkg
ew0KPiArCQlzZXRfbWVtb3J5X254KCh1bnNpZ25lZCBsb25nKWhkciwgaGRyLT5zaXplIC8NCj4g
UEFHRV9TSVpFKTsNCj4gKwkJc2V0X21lbW9yeV9ydygodW5zaWduZWQgbG9uZyloZHIsIGhkci0+
c2l6ZSAvDQo+IFBBR0VfU0laRSk7DQo+ICAJCW1vZHVsZV9tZW1mcmVlKGhkcik7DQo+ICAJCWdv
dG8gb3V0Ow0KPiAgCX0NCj4gQEAgLTk3NSw2ICs5NzUsOCBAQCBzdGF0aWMgdm9pZCBicGZfcHJv
Z19wYWNrX2ZyZWUoc3RydWN0DQo+IGJwZl9iaW5hcnlfaGVhZGVyICpoZHIpDQo+ICAJaWYgKGJp
dG1hcF9maW5kX25leHRfemVyb19hcmVhKHBhY2stPmJpdG1hcCwNCj4gYnBmX3Byb2dfY2h1bmtf
Y291bnQoKSwgMCwNCj4gIAkJCQkgICAgICAgYnBmX3Byb2dfY2h1bmtfY291bnQoKSwgMCkgPT0g
MCkNCj4gew0KPiAgCQlsaXN0X2RlbCgmcGFjay0+bGlzdCk7DQo+ICsJCXNldF9tZW1vcnlfbngo
KHVuc2lnbmVkIGxvbmcpcGFjay0+cHRyLA0KPiBicGZfcHJvZ19wYWNrX3NpemUgLyBQQUdFX1NJ
WkUpOw0KPiArCQlzZXRfbWVtb3J5X3J3KCh1bnNpZ25lZCBsb25nKXBhY2stPnB0ciwNCj4gYnBm
X3Byb2dfcGFja19zaXplIC8gUEFHRV9TSVpFKTsNCj4gIAkJbW9kdWxlX21lbWZyZWUocGFjay0+
cHRyKTsNCj4gIAkJa2ZyZWUocGFjayk7DQo+ICAJfQ0K
