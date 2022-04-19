Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB285061E3
	for <lists+bpf@lfdr.de>; Tue, 19 Apr 2022 03:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbiDSB6y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 18 Apr 2022 21:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344104AbiDSB6x (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 18 Apr 2022 21:58:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D752E9C4;
        Mon, 18 Apr 2022 18:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650333372; x=1681869372;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EcDL7pJATOqYWEw9h18xK1VBCgM/6r2pv+5sc6RbhAg=;
  b=Ok1IEJYXDmzq8V1ZgncgJO5A6CFwvF7+NngJESoqN4xQuu/k5I8bbBtd
   tcFrwv/a1ZpwO5lonEtucuV6DjW5VOLfkzUn2DajPhyLvKuIQZ2zveENT
   KGq+86OyUryo1pftM+TQdiYLvLYvL2uV/lLgAhf9an63MfjNcEQUdwQnp
   VkGLCCEx2DKgQwK9Veo97usJmnLHO7wIFB/SdaJ2SIezUeX+j1ETDPcTk
   VflBAMiK8KfGtAjPAsHdaTYLJiHtM1B/hfMCSVCOCx8sDAWo0kaclp+0R
   CpEUWhCuLtiESIVftDbFWyVJpWaDNrpj+UpUL/cg1g7wdPBOm3fytdDFR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="250954927"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="250954927"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 18:56:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="509954001"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga003.jf.intel.com with ESMTP; 18 Apr 2022 18:56:11 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 18:56:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 18:56:11 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 18:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3O20QwQZAClp37j9Yo46nMw/devjT8maKKiZdk0H9+RO/9bXQL8alcB7q/vGk9SPUMU4roSXmbDTevxYLrydfZvMXD+eriVj0+uPP5AhgRL+/nK+T+vJb/z671nWJVIlHluu/N71Xk3/BK+ldsEVNSWY4Ze2J863gKRKQLKqb3V5YK5u3hYD39uM8pq9vZ/9X4qZyX5FiobaR3Kj7PtFKg9OI37gd3hVNTEDuylYU7dpSsUKd+hY4lVQKGqBWPsX4r45kfIA3NKBtvMbBjeH+q4/xYDBApsU/EWhuAg5s3AQ9C0ycWOwZ7h69T3r2Fpt7eN0cPCCofv145jiIIoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcDL7pJATOqYWEw9h18xK1VBCgM/6r2pv+5sc6RbhAg=;
 b=kL9iXzum1I4oNNGdn6X7hPsMzk3QzN7JPjQTMSxUGrxQSghQ5gP1lpbyf9AJxscYFeMvGOU1LtHw2tWlgQ2by57hn391FvEuvHxZrV7AnTjrwXd6YpRDhkU0RfuRgwfSyE1HSAoZuJmShd/sH1E7TJVmwe+61PzxQ0SeY2IOfmmZbHEc0KqBLk+cQGU9dyjL3C6OhDNCLfVTbkFkAJj9jEcyxRtSG1Msb+agza/120twAm3zBwnXN46Fh/d6uZx9Ekoc4ESPPrz4OIKFbB8/7kZ7KUoEt3rrKXZcbbopnY8fbZ7wMr7du+8z96O2Li8shgobmUCwL+prkqzdsVg7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM6PR11MB2843.namprd11.prod.outlook.com (2603:10b6:5:c7::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 01:56:03 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 01:56:03 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQA=
Date:   Tue, 19 Apr 2022 01:56:03 +0000
Message-ID: <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
         <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
         <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
         <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
         <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
In-Reply-To: <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3efb4736-e107-4a56-c181-08da21a7c2aa
x-ms-traffictypediagnostic: DM6PR11MB2843:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB28435BBD409D335251F01DCAC9F29@DM6PR11MB2843.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UTc27qPABthpY9ZJOvcPxckZHLd3J1Zo6jE6GcYLVFHcUsAJEKew+URB4z8wsdswfsnCTN5spCButUkrbURNSuvVpLNxd/WvMeso16kzJ6erOEx8a3YOBALXx/Vg7FA2OyoYKV1+wSRuqn18iXDGZ1JYWUztDNOnW+8slIPOh0ret5BVCcIUtkAkrMiUooGmRobCJ8UadCufeEXsTWF9p9tWzdSwcYHXy8c/vRncVpWXNLCEG1CE3ON5ktoQISlNYg0EdSNQ5CYpQ5D4SK5vX1wmn/R8ZonQ0jkOVO1eaxVy+PX3pPugHu6OhmJzARgADmG9R46exssiIXsgriUf+DLVAWuEBqFvvMjtPvG8U7ppaCyVLtdxGYEpJBcLUSn3ufy22xkn3EF0k+ytofsBIRZHZmOaIw7AcsMm0D4EigYMjjZf3lug4acOad+fTjrat+Ll+DFto0goQX0FpkVPHcBBrrwVnYidfcc/XprVu3nvL73njdLOGLi5zGrvv+MGl3XE/BO+dJ4DhGMcKMdOCoNr79RZgEjeUyayxQ+NE1r29t8daNZ7n2VNQqxNv9dAfJektm30obR9lwZ+thx00ejRQL5bjFAeMGsjNrbDL2ZxiN+IO7zv8NjxOVBrpttWsRT7THVLlsyXTl0QrRKDaNNQlpCoW9kKeATKFghYqqr9n3VZ3rSpGKTsyCiwwIMc3zFJeISTAcAPx+nn770tUYAF4VxKgTlLT0lYDoaz7IHKabcyob9bLgLw6ZawrGtB9i1bf/yG3Rhr6X2JN2/RvWmECBsHfQEJUKM9MYVcqRWBAilvkkexWMOm8L/aBbD11pxfynhHjXuvBr63F2PD/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(38070700005)(186003)(8936002)(66946007)(54906003)(91956017)(76116006)(110136005)(316002)(4326008)(66476007)(64756008)(66446008)(66556008)(8676002)(82960400001)(36756003)(38100700002)(122000001)(6512007)(26005)(71200400001)(7416002)(5660300002)(6486002)(2906002)(966005)(6506007)(86362001)(508600001)(83380400001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlNrTlpUV1RvVHovMFpnMFBwdUR3Ym1kcXkwU1c3ZHpzVGFpWFBkMUJEZmFs?=
 =?utf-8?B?ODVkMHlxbHRwdWVIdVRZMjBzbVJNWk1CWXhKTWl3czlkSFg2NXl4M1k4N2tm?=
 =?utf-8?B?VHNSOGM3U1F6QzEwUjNuTjE3NkZUem1zZVJiZDJJVXZXWWlFM1hrQmFXTGxi?=
 =?utf-8?B?MWFZU1o4RWRxbTg2d2E1UmI3alB5TjVjNzcwRVY0VVNBNmd6d0MvTmNqeFhM?=
 =?utf-8?B?UXFHS2ZXMUhxaFpTMlhyWWZmYnQ1YlRsa1U5NTgyVDUvT0VTOEVOT0wvL1N3?=
 =?utf-8?B?cFdFLzNYekRDYzB2YTNVZTAzZklqT1pRMUpQcTZFWUppWG04Rlk1OEdHdUo0?=
 =?utf-8?B?em5EQXU4STc5R3JhQTRQUERsQStnbkN1clZzTWRlS0Job1h1Z1FrK0x1RHRs?=
 =?utf-8?B?bVZ3YkxvdnVES042ZWlLZzhsWXBtK1UyVXQ3WDVCSXg1OVpEM0tFTFdVaDQ2?=
 =?utf-8?B?cktaWEpFeXA0bE9lUytQOXF6U3FNZlFTL01hQkp5bGthT0d4eFhIYmF4cmRB?=
 =?utf-8?B?R0lMTC9QeU15V3ZZNlcwNThITEd5MXNyYjQ0a0JrNlJZTi9IMkNSZXRraTJo?=
 =?utf-8?B?TjFXUnBYS2Zua29BbU1TVXFEeHFvQWk2RThzTndpeEFDdXlLOURPS2VQamFq?=
 =?utf-8?B?ZS9rajlmNmV4V08zT2NJWXVxdDdCUzRPMGNoem4yWHlBU1FFdjNHbkw0MXJ2?=
 =?utf-8?B?SWNOZnRSTDh1WVZ1N1h2YTV5TU1SRGIveDRVdWZvV2RGc0FCQ1JZSHlQcmRP?=
 =?utf-8?B?dnEzV0ViOXV0dWVzZ2c4TjhoUnU4RHlJc2RMQm03bnZjUzljZ1ZqRk5YU1J1?=
 =?utf-8?B?ellsWVorbzdVaTRtTFBNZWRNdDJhZmYvZ0FnQ1pOTkZIbHNuekFhbmVoZXFa?=
 =?utf-8?B?eE03Ykdlem0wTG5ualc1NEo0Nlp5cDNoYnFOaVJKdng2cUJXcnd4T2NGL0x4?=
 =?utf-8?B?U1pwMWZSN0o2SzJnLzFuTHpMakpyc0ZiVU1id2JpUHVOTlhMTzBzY0xVWnJi?=
 =?utf-8?B?eFVFd2g3ajUxNVNJT3hCSkRkQ3FmZGJKTG9xUHJ3dGZzMElHektuVTEvTE9x?=
 =?utf-8?B?TG1IL0tXNUtBdzBlS1c0KzYwajJEMWNIMVZlek9zSGJhV1ZYVjczejlrb2Zk?=
 =?utf-8?B?ZXMzRTdZNXJWbUYzS3hYMlQwaWYzRHJMTWpYSVkyaTZEbVBLRnhEOXJTOFZN?=
 =?utf-8?B?dXRTUC91SjdIMjF5cVI4TmJtUnVtZ0htNGNsWkVZWVhEN0pYbWljWjV0dVJs?=
 =?utf-8?B?ZzBrNGZnT1JlSENJSGtXZWY0c3lXZ3l6VzBoQVBvU2lPY0pScUV0eTR1Nnk5?=
 =?utf-8?B?N2swTG1CK2hTc2F2dU9TbjNCNXhpdHRDbkpEQ2lBd3V4bkY4ZUEzd3BoU3p4?=
 =?utf-8?B?bURBUDBpaDIwaFErUHFWR2tVdVFUL1d1OWNCa1RpZUU2UVVRbEpDTjRUN0RL?=
 =?utf-8?B?Y1h6NGMraHJVS3lkZXVKcGprWHB0VEx2V0hpR2QxMTNpTTBzeHV5SlZ5RWRh?=
 =?utf-8?B?MVVpdUVJaWF1RE9VcWNza1FMVktyQUQrR0piNzhvSHQ0U0RQWXVrM0ZLMWFW?=
 =?utf-8?B?ZGN6WFhxMU55by9KdXhFWCtCNThtQnFTbmh5V2JpN04zWnoxN0R2cElaZ1Iw?=
 =?utf-8?B?eEgyMXdTYTM3RGM4U05wS29HVDgvckNRTWRpKzFiQkhtVDlBVFU4TjNXMStt?=
 =?utf-8?B?eGJ2ZndiNjM2VDVtUU5jblV1VHJaalliY2lPc2k5b3M1WU5IdW8wV1hxbjV0?=
 =?utf-8?B?akhZRzhWT0NETXNJeDVQeDg1WGREQ0V2UURjQ2Q0RDBBZ1MxS2pDeGFhcjF4?=
 =?utf-8?B?a0E5V0o5T3hiS0hCYlRQZlRYTkVWdTFBeEhjWTJTc0JGUkJPQUVIcUdEWnph?=
 =?utf-8?B?VTh0M2piUXRBRkhkQmg2VmlqRkFjdnZ1NDFrdDd1WFFjMmRMNTJ6TFlmL1Zt?=
 =?utf-8?B?S2NJbXNnK2dObm9vejZFZno0elVHQ1kxSEtqbEFiY2F3a2RBbUJ6QTVaVng1?=
 =?utf-8?B?UDRvVTliZHJVeG5ncGlkK0ZEZlBQTEdSMStobENWdHR5N2VCemozbjdHcGtQ?=
 =?utf-8?B?NFRlVWM4T3NJZ25iUXVpYkNoVUEzM2IwczhYZnZzbEZIMXA3d01XY2RTbUdX?=
 =?utf-8?B?YWpSSVRhM3lTUWRKK0c5QXJmOW5LVkFtU1daK0Q2bE5qWklCNnY5djFZdVll?=
 =?utf-8?B?TmlZS0UxY1RQZ2dTMWRNN1NpR0ZzeW9TeVA0S2ZOc2g5SmwyZ1hPNHIxRnJ6?=
 =?utf-8?B?S1lzVmRqWEVWTTdlU3cxRDRZWFJuQi9JSW9lbkxxd0tEa244eWNrNlQ4YnZ1?=
 =?utf-8?B?NDlvemRIQ1RwNDBwU1g4dXUreFRWSi9XYjlYK3BER0ZHVnNLRjM2V0pTaE1w?=
 =?utf-8?Q?NYkd4lJzYo1/X77zw3s9jl6bhcWy327sbFSaH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07CE1E5788321C42AD4E889B53CCD552@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3efb4736-e107-4a56-c181-08da21a7c2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 01:56:03.3072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqS0rrYXqvM5/0wlXDmYOpT0waROP6dgylSXJ4le6K+D783+J2yPBx0TALE0GEyP2NLN4EBfD8HyTDDp5+ilBqHRPUs/BgMEotDRmHX3EvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2843
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTE4IGF0IDE3OjQ0IC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiA+IFRoZXJlIGFyZSB1c2UtY2FzZXMgdGhhdCByZXF1aXJlIDRLIHBhZ2VzIHdpdGggbm9u
LWRlZmF1bHQNCj4gPiBwZXJtaXNzaW9ucyBpbg0KPiA+IHRoZSBkaXJlY3QgbWFwIGFuZCB0aGUg
cGFnZXMgbm90IG5lY2Vzc2FyaWx5IHNob3VsZCBiZSBleGVjdXRhYmxlLg0KPiA+IFRoZXJlDQo+
ID4gd2VyZSBzZXZlcmFsIHN1Z2dlc3Rpb25zIHRvIGltcGxlbWVudCBjYWNoZXMgb2YgNEsgcGFn
ZXMgYmFja2VkIGJ5DQo+ID4gMk0NCj4gPiBwYWdlcy4NCj4gDQo+IEV2ZW4gaWYgd2UganVzdCBm
b2N1cyBvbiB0aGUgZXhlY3V0YWJsZSBzaWRlIG9mIHRoZSBzdG9yeS4uLiB0aGVyZQ0KPiBtYXkN
Cj4gYmUgdXNlcnMgd2hvIGNhbiBzaGFyZSB0aGlzIHRvby4NCj4gDQo+IEkndmUgZ29uZSBkb3du
IG1lbW9yeSBsYW5lIG5vdyBhdCBsZWFzdCBkb3duIHRvIHllYXIgMjAwNSBpbiBrcHJvYmVzDQo+
IHRvIHNlZSB3aHkgdGhlIGhlY2sgbW9kdWxlX2FsbG9jKCkgd2FzIHVzZWQuIEF0IGZpcnN0IGds
YW5jZSB0aGVyZQ0KPiBhcmUNCj4gc29tZSBvbGQgY29tbWVudHMgYWJvdXQgYmVpbmcgd2l0aGlu
IHRoZSAyIEdpQiB0ZXh0IGtlcm5lbCByYW5nZS4uLg0KPiBCdXQNCj4gc29tZSBvbGQgdHJpYmFs
IGtub3dsZWRnZSBpcyBzdGlsbCBsb3N0LiBUaGUgcmVhbCBoaW50cyBjb21lIGZyb20NCj4ga3By
b2JlIHdvcmsNCj4gc2luY2UgY29tbWl0IDllYzRiMWYzNTZiMyAoIltQQVRDSF0ga3Byb2Jlczog
Zml4IHNpbmdsZS1zdGVwIG91dCBvZg0KPiBsaW5lDQo+IC0gdGFrZTIiKSwgc28gdGhhdCB0aGUg
IkZvciB0aGUgJXJpcC1yZWxhdGl2ZSBkaXNwbGFjZW1lbnQgZml4dXBzIHRvDQo+IGJlDQo+IGRv
YWJsZSIuLi4gYnV0IHRoaXMgZ290IG1lIHdvbmRlcmluZywgd291bGQgb3RoZXIgdXNlcnMgd2hv
ICpkbyogd2FudA0KPiBzaW1pbGFyIGZ1bmNpb25hbGl0eSBiZW5lZml0IGZyb20gYSBjYWNoZS4g
SWYgdGhlIHNwYWNlIGlzIGxpbWl0ZWQNCj4gdGhlbg0KPiB1c2luZyBhIGNhY2hlIG1ha2VzIHNl
bnNlLiBTcGVjaWFsbHkgaWYgYXJjaGl0ZWN0dXJlcyB0ZW5kIHRvIHJlcXVpcmUNCj4gaGFja3Mg
Zm9yIHNvbWUgb2YgdGhpcyB0byBhbGwgd29yay4NCg0KWWVhLCB0aGF0IHdhcyBteSB1bmRlcnN0
YW5kaW5nLiBYODYgbW9kdWxlcyBoYXZlIHRvIGJlIGxpbmtlZCB3aXRoaW4NCjJHQiBvZiB0aGUg
a2VybmVsIHRleHQsIGFsc28gZUJQRiB4ODYgSklUIGdlbmVyYXRlcyBjb2RlIHRoYXQgZXhwZWN0
cw0KdG8gYmUgd2l0aGluIDJHQiBvZiB0aGUga2VybmVsIHRleHQuDQoNCg0KSSB0aGluayBvZiB0
d28gdHlwZXMgb2YgY2FjaGVzIHdlIGNvdWxkIGhhdmU6IGNhY2hlcyBvZiB1bm1hcHBlZCBwYWdl
cw0Kb24gdGhlIGRpcmVjdCBtYXAgYW5kIGNhY2hlcyBvZiB2aXJ0dWFsIG1lbW9yeSBtYXBwaW5n
cy4gQ2FjaGVzIG9mDQpwYWdlcyBvbiB0aGUgZGlyZWN0IG1hcCByZWR1Y2UgYnJlYWthZ2Ugb2Yg
dGhlIGxhcmdlIHBhZ2VzIChhbmQgaXMNCnNvbWV3aGF0IHg4NiBzcGVjaWZpYyBwcm9ibGVtKS4g
Q2FjaGVzIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmdzDQpyZWR1Y2Ugc2hvb3Rkb3ducywgYW5k
IGFyZSBhbHNvIHJlcXVpcmVkIHRvIHNoYXJlIGh1Z2UgcGFnZXMuIEknbGwgcGx1Zw0KbXkgb2xk
IFJGQywgd2hlcmUgSSB0cmllZCB0byB3b3JrIHRvd2FyZHMgZW5hYmxpbmcgYm90aDoNCg0KaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDIwMTEyMDIwMjQyNi4xODAwOS0xLXJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tLw0KDQpTaW5jZSB0aGVuIE1pa2UgaGFzIHRha2VuIGEgbG90IGZ1
cnRoZXIgdGhlIGRpcmVjdCBtYXAgY2FjaGUgcGllY2UuDQoNClllYSwgcHJvYmFibHkgYSBsb3Qg
b2YgSklUJ3MgYXJlIHdheSBzbWFsbGVyIHRoYW4gYSBwYWdlLCBidXQgdGhlcmUgaXMNCmFsc28g
aG9wZWZ1bGx5IHNvbWUgcGVyZm9ybWFuY2UgYmVuZWZpdCBvZiByZWR1Y2VkIElUTEIgcHJlc3N1
cmUgYW5kDQpUTEIgc2hvb3Rkb3ducy4gSSB0aGluayBrcHJvYmVzL2Z0cmFjZSAob3IgYXQgbGVh
c3Qgb25lIG9mIHRoZW0pIGtlZXBzDQppdHMgb3duIGNhY2hlIG9mIGEgcGFnZSBmb3IgcHV0dGlu
ZyB2ZXJ5IHNtYWxsIHRyYW1wb2xpbmVzLg0KDQo+IA0KPiBUaGVuLCBzaW5jZSBpdCBzZWVtcyBz
aW5jZSB0aGUgdm1hbGxvYyBhcmVhIHdhcyBub3QgaW5pdGlhbGl6ZWQsDQo+IHdvdWxkbid0IHRo
YXQgYnJlYWsgdGhlIG9sZCBKSVQgc3ByYXkgZml4ZXMsIHJlZmVyIHRvIGNvbW1pdA0KPiAzMTRi
ZWI5YmNhYmZkICgieDg2OiBicGZfaml0X2NvbXA6IHNlY3VyZSBicGYgaml0IGFnYWluc3Qgc3By
YXlpbmcNCj4gYXR0YWNrcyIpPw0KDQpIbW0sIHllYSBpdCBtaWdodCBiZSBhIHdheSB0byBnZXQg
YXJvdW5kIHRoZSBlYnBmIGppdCBybGltaXQuIFRoZQ0KYWxsb2NhdG9yIGNvdWxkIGp1c3QgdGV4
dF9wb2tlKCkgaW52YWxpZCBpbnN0cnVjdGlvbnMgb24gImZyZWUiIG9mIHRoZQ0Kaml0Lg0KDQo+
IA0KPiBJcyB0aGF0IHNvcnQgb2Ygd29yayBub3QgbmVlZGVkIGFueW1vcmU/IElmIGluIGRvdWJ0
IEkgYXQgbGVhc3QgbWFkZQ0KPiB0aGUNCj4gb2xkIHByb29mIG9mIGNvbmNlcHQgSklUIHNwcmF5
IHN0dWZmIGNvbXBpbGUgb24gcmVjZW50IGtlcm5lbHMgWzBdLA0KPiBidXQNCj4gSSBoYXZlbid0
IHRyaWVkIG91dCB5b3VyIHBhdGNoZXMgeWV0LiBJZiB0aGlzIGlzIG5vdCBuZWVkZWQgYW55bW9y
ZSwNCj4gd2h5IG5vdD8NCg0KSUlSQyB0aGlzIGdvdCBhZGRyZXNzZWQgaW4gdHdvIHdheXMsIHJh
bmRvbWl6aW5nIG9mIHRoZSBqaXQgb2Zmc2V0DQppbnNpZGUgdGhlIHZtYWxsb2MgYWxsb2NhdGlv
biwgYW5kICJjb25zdGFudCBibGluZGluZyIsIHN1Y2ggdGhhdCB0aGUNCnNwZWNpZmljIGF0dGFj
ayBvZiBpbnNlcnRpbmcgdW5hbGlnbmVkIGluc3RydWN0aW9ucyBhcyBpbW1lZGlhdGUNCmluc3Ry
dWN0aW9uIGRhdGEgZGlkIG5vdCB3b3JrLiBOZWl0aGVyIG9mIHRob3NlIG1pdGlnYXRpb25zIHNl
ZW0NCnVud29ya2FibGUgd2l0aCBhIGxhcmdlIHBhZ2UgY2FjaGluZyBhbGxvY2F0b3IuDQoNCj4g
DQo+IFRoZSBjb2xsZWN0aW9uIG9mIHRyaWJhbCBrbm93ZWRnZSBhcm91bmQgdGhlc2Ugc29ydHMg
b2YgdGhpbmdzIHdvdWxkDQo+IGJlDQo+IGdvb2QgdG8gbm90IGxvb3NlIGFuZCBpZiB3ZSBjYW4g
c2hhcmUsIGV2ZW4gYmV0dGVyLg0KDQpUb3RhbGx5IGFncmVlIGhlcmUuIEkgdGhpbmsgdGhlIGFi
c3RyYWN0aW9uIEkgd2FzIGV4cGxvcmluZyBpbiB0aGF0IFJGQw0KY291bGQgcmVtb3ZlIHNvbWUg
b2YgdGhlIHNwZWNpYWwgcGVybWlzc2lvbiBtZW1vcnkgdHJpYmFsIGtub3dsZWRnZQ0KdGhhdCBp
cyBsdXJraW5nIGluIGluIHRoZSBjcm9zcy1hcmNoIG1vZHVsZS5jLiBJIHdvbmRlciBpZiB5b3Ug
aGF2ZSBhbnkNCnRob3VnaHRzIG9uIHNvbWV0aGluZyBsaWtlIHRoYXQ/IFRoZSBub3JtYWwgbW9k
dWxlcyBwcm92ZWQgdGhlIGhhcmRlc3QuDQoNCg==
