Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF86507D75
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 01:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244362AbiDTABo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Apr 2022 20:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiDTABn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Apr 2022 20:01:43 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E409E1D338;
        Tue, 19 Apr 2022 16:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650412738; x=1681948738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e3zjpM+qkqVFnReq2gf/R1xJwMXdWlPzQfJcriWoMPw=;
  b=YRwKooFt1gsrWJWmPSlCjq8Lq7LmdZ52YXUzExZerYskRm6H+qv4Z+5E
   UbWprFZPAway9qUgyXXbJN4jhmc4hiiqrBowBsV40vJEgYpbU1rY5jWnk
   pNctzAN1svPUMAfCkodYN9Cp1LqBUdeLZ0+auj2Vy4o6Emu3dhK5pTulq
   cU8TW9gNhnui8nSqn5V3tmrytqMdNcxSwa/boThrtUHA4VwBiDe07TN2p
   WLQ/cxcA8eDL/omXC+w5S9LN1Shc+5RVPhubKBlN+kwltxbyaKAt2OCpv
   eDgGQ+avDN48abwC8AwLhraUl6OZ6F98XCKGlaT/Kjg+zHZTeKEveV5rz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324342436"
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="324342436"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 16:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,274,1643702400"; 
   d="scan'208";a="727265903"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 19 Apr 2022 16:58:56 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 16:58:56 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 16:58:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 16:58:56 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 16:58:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQFaz8gvIBvY23B7bbPHyMYPFDl/qs9KMEQYxWdGVXiZXDcgcd9ALr99xPa4MyglgcHIx65j6lZgzvQvRQrx7YXhzluu2lwRBaN7TNtDAvJ8yEne4iC14nJPhR9T3KnZGxNCPEGSDaBfmadyskU2ZNDJq/K5HoJu+gPmgIMc98o2njGFBpV1NBsXp1DYu3EOcLJnbaeqd1kUuCOxW4yWoNKBkei13gn2Qkj6HvBSDZX8zxz93Wdvm1hwkIAeCoV+WhQiqDW+HOhkjC+l7xwD0g2E/DvBBTcZrwfsLXoZ5fXDsydxxcthKar5SJ0Ps26JQjoGxa5J5za4N0k+L9UpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3zjpM+qkqVFnReq2gf/R1xJwMXdWlPzQfJcriWoMPw=;
 b=gSeNvb7cQTSvPn1ZH/2+kGzEYgQH1HysjbktxPFLxcGz6gB4jOrYquG+X/kCI+E6ksUgGZP0op6htn242mg1MWGxyywISpGc4Y4aqGy8dt6vbfFRuwznA4WqKSxV0NIgMc2gGXJYGo00QWtyBduGFHpjpKgie7I3zZWinK5kUvWo3az+SuNmATzF0jW8sF/czbx9C6D0ezL/6vhVTO62SVE5XPlHWoG3QKWO3cQCrWD7OJOeyqUrbrKLg5/cEm6OdGDZqlj/z+L/uMQ/iFdvxouXkllk5ymV0VBIu1J5vpEyXbz4eMXhORToU/KB01gquH4L32QiaSZLeTYfqxrlzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BL1PR11MB5448.namprd11.prod.outlook.com (2603:10b6:208:319::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 23:58:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 23:58:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAUaBAIAAKxUA
Date:   Tue, 19 Apr 2022 23:58:51 +0000
Message-ID: <fc9a006f8f7ae548cbc5881038428ee5bcc3ae16.camel@intel.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
         <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
         <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
         <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
         <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
         <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
         <Yl8olpqvZxY8KoNf@bombadil.infradead.org>
In-Reply-To: <Yl8olpqvZxY8KoNf@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d216cb7d-8b5c-4e7c-7a62-08da22608df4
x-ms-traffictypediagnostic: BL1PR11MB5448:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BL1PR11MB544824AFFFC4D7A382182EB7C9F29@BL1PR11MB5448.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9awqkxZAorbRBZ9gles4EOIDL1Tf9UZMo2JFAyzVlL0bXk3sqqljUIwKoWarmxf9sU5+Mi7NAoLwxdTqCFrnULdisMBxXlP6ss/JgwZ0qNo8U336ZVg0FP545UV+uXj4zpks8rI/5R6HF6yAbgzEj3wUMt5Ee0cf1so3CZVD7gBxCg3Ifg0gD4s4NZtoglCNvDCDeW4lhsluBRauv78PGty1ioFomY06yQcKMddSDIqp5EqU5WpX45VLQQQ/gu9B+nsuj6eO5sJVIiYUXUJVSElJfh6wfVgiMsLNb8hvmsZ7ItRsVxvlO+FE+PemFRQfYqdyJf6ZtY7wTxK4SLkyRLacVNZbprMLQDgnZ6jy1cLv4s/o/8Z5Q9Um5yg+3sOtspcytYqD4np1MB/Zxo/Dw3WFbrndfs4h1mfODEXx583hrjKSsZanL/hmzZWlPMbMV+6Ul3mD7lwWDXR/++KVMwqulFHml3poB163ktOhQ0V1NJh1ee0Cgx2pqsFwi/xdZZPQyrwpur/1cJQtz+AeLArebfmjDRc2I26HXGrgno3d/awZ2bHxf35rl+Kp2z1JyafmVAVOZuRQxm0anDltPTAdIefjUVgxOBuyTPKVuoKSZCljGjE2LmXHN0HTpU3cjB5+RdjkBeG5TkOiXfs7jPIZV8jWcYWS3McGn1hdGdKUWxbnz0XSHIvQS0iOnXRxIFJOKP9OLrN6RQB01P9fg2vWT5XWP8J9VBG4mhqdypx+d9U9N4hctgnP0FiLnjOiXKhxUVRPI2lc56O8v4UgQsBrooJzqf3p0mTJjxnMwVCRxOokTfaYsbLjHPNvTizjjNjoUUh0BJjC0I0dacL4K45oKEzI13fTDFFDNMZcPSyJlGh+zk+lmAA6iW2h50hP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(4326008)(76116006)(66556008)(38070700005)(8676002)(2906002)(71200400001)(508600001)(83380400001)(122000001)(26005)(86362001)(6506007)(6486002)(966005)(54906003)(316002)(6916009)(6512007)(186003)(2616005)(66446008)(64756008)(82960400001)(66476007)(36756003)(7416002)(5660300002)(66946007)(8936002)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzNuM0NJMEFvVWs0VkdFR1crbGdqUVJRZlNoenkrbnM3MjBuOGZCNVI5bjZC?=
 =?utf-8?B?S0YzU3hUQVRMbXYwbi9oN0p0bTdPWEFXZ3dXdkJSdXJHeDVlZ1lpbllERTdZ?=
 =?utf-8?B?NXNybEI0S1pUaE96RlFKcDhmSWJSSUlhQ1gzanh4eTAyTGY2akNqTWF1VVQ5?=
 =?utf-8?B?dFUrTnRDTDJmc0g5ckhudmUxeGFTdklZQktaWmtaZk1HbUdjQXMzWUpmRm5G?=
 =?utf-8?B?OTFOTitycGZiQXRDYjFnUkdlU3VvTmg1R095RVFaQTI1UDVvOFBWMjFvSmMr?=
 =?utf-8?B?S0VnaldGNTFWY0RmQWo4QlNqR3lBckloMTBhSmZKNnFncjBHNDBCcmhwSU0z?=
 =?utf-8?B?SXVhdHN6WmFaOWI0aVluZVNIRlNQbjlxMnoyUHVMUFZKNmFmZUJBaC9UdHRi?=
 =?utf-8?B?eStPMlE2U3JRVGFCd1lhMHpvZnhmMmJldDRmaENTbDJZRUZObWdzUnZablRL?=
 =?utf-8?B?YU5xUnlxZzU5VXBvZ3BUSXRENXFxMzJFekI4Smhua3RYT0xwZzRWUDA1Uk1C?=
 =?utf-8?B?NFVZaWgyVHZZOHRPMk9yRDZGREdxVHlVM1VueE1DaEJyMjI0VG1uVmtja25Y?=
 =?utf-8?B?Vm1UTU1lcGk0ZWsxbnlzK2lGNlZjVHBLaklHMmV4NkN6U05aak5iNnZBMFBZ?=
 =?utf-8?B?KzZmNXUwQlVZaVVOTzBTUldQUmo4TnJ3UTRzMHFjRUhMZFJhSk53SHZHclZX?=
 =?utf-8?B?aE00NHF2djlSVEFIM081VjFnZlY4YldHRVFnNzJDZWFlQkxNMkR6b3Z4UDNt?=
 =?utf-8?B?QjhKL0hLdWpTV3JoQ3JNcDhEdmZkM01vOUdaRm1QYUlLdEpjdHVBTkhHWVNv?=
 =?utf-8?B?dVF1bmZWaXAzcTYxdnRLdmJlTlYycnZuTElKVHZET1hqVkRPdnlZOVZCem00?=
 =?utf-8?B?MllQL1dXUGhNemN1Nk1YeXF6cWF6MXR0NmQ4VXRucnlDVmZndEZwQ3NwSXdG?=
 =?utf-8?B?MUxJWTE0bU5aUWNLWFRpdm9JSXNaWWtFeWxXS2xFVGNxS2JFektrb244MVNv?=
 =?utf-8?B?QzJBZHlucDVrVG80Rk55RnppMit4WC9YVUhObjg4QWZYbndmeGpnbUZ4cDFU?=
 =?utf-8?B?eVlVNXlTbkJHQUZPK0ZzbG5jTUdKODBlQVhYSVYvZ2NMSVV4dGpsbjBmUk5R?=
 =?utf-8?B?RkdUUjJtVVM0bU0yUnRoNUlEeFcxYjIvZFJwYkFxOU90YVNMNExGdHV3MVFT?=
 =?utf-8?B?eCtnNHVqK3ZVM0N2cFRFNUdzT3lNZEtzOGRYMENsdGtta1ZtZVJBLzBCa3Zm?=
 =?utf-8?B?OTR4U0dqRFNhaEJaSkUyckFFM0c2YWVDdUNYc3drRVZrbVhPOGlvcVB2N1Ji?=
 =?utf-8?B?bzdhb29wK3pDQVVkV3VmTVJsS1NKaDE0SWxMVlRkaEFRM0pXazFzUFNKamo5?=
 =?utf-8?B?dzQ0c3RMeG5FU1FLUUZCMHkycC8yVi9TS1ZoamZRem4wT2U3Vlp1d05nb1Y3?=
 =?utf-8?B?c2dJdXVDTVpHT1NVRmdyYUpwNjAzUHIrWjREdUc3aHQvKzQwNnZid1RLV1Zo?=
 =?utf-8?B?Ukt1WERlSzliUDFsNW5STy9DSjI1akg4M1FRS2swVjNpSVJxTE5qM3pXTUVL?=
 =?utf-8?B?Und0M1dHSnMzNTd5S1RHS1Q2ZE9lbUpQc05tUG5aSmxWcnROdWU1NzNKaDF0?=
 =?utf-8?B?ZjdObGpxMHI4cFN4TS9wd2t2UUwwK1kra1ZXYzNHS3l3cGtWOTE5VUxTcm5J?=
 =?utf-8?B?Z2xYc2ltZjg4c0tERHVtL01aKzlZT29LTWQ0dmRnbUlES0M0RDdFVUgwRFRv?=
 =?utf-8?B?Nm9JWEhjM3M5YjhHazZoMnA2UkNxdWlpWC81cjNGbGhyTHdVUDlMVUJkN3cx?=
 =?utf-8?B?cVp0blJFUjNKbENDTi9Za3FiYXBZR2tqRnhRNTdIVVZheDlrTVNuRWtJcGs0?=
 =?utf-8?B?R0YyUlJZRzM0Q0IyUktqMzlMS3o2VkxwTWlIUjVZZDNWaklzRGtIU0hmSXF0?=
 =?utf-8?B?dkFHbUMvbk5WNDIwc3JhdFdDUVlyOW9kaklCWHdtUTFaTXEvSDVMdkR6SE1x?=
 =?utf-8?B?Tkd0WFFldXU3Qk5BTDBmQkZDWjBJT0ttSVhyN2QwWk56MmtERkpUZzlxS2Jj?=
 =?utf-8?B?MW1OSGZuV2JOQmRwSUx4MXRFdDNmOGp1N1VPTitnWWpWL2Z5azVPMzBZK1Fu?=
 =?utf-8?B?SkFsbzBodjBuUEtGTTE4cW42cVNWV3RhVWxlbFpraWtoZjhNa1FFQ29ueGFM?=
 =?utf-8?B?RDV2YWlkUDV6RmVDSTNvZkdqWG1GUXVuNjd1TWRhbk9OYXpMMGVKS1FXR1di?=
 =?utf-8?B?OWtyQWRsaXpoajRsRWVXQys5ZWQwSXU4ajRhNkhPb1phZjdVZnBucHFSQXdz?=
 =?utf-8?B?YXU2MVBHT2tDOXpxZmtzQVBHVkhneG9jREU0d2k0S1NrQXk1SEdWaEZTU1hq?=
 =?utf-8?Q?mz/AfOjickqtmRuVGRDFNGWR3J0xu4tXdL8AT?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0120A8680B58F6469FAD9335C210D327@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d216cb7d-8b5c-4e7c-7a62-08da22608df4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 23:58:51.8286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2JiNEKVvecHx9fTx2zvqKAu14a7MYMSQBwUlChmqEdxC6vUN/P74/qVwZhiGcuEC39zTGtmAMDrozTapFZH8+oRqZ24elBzQwGauH5CFiao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5448
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTA0LTE5IGF0IDE0OjI0IC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBPbiBUdWUsIEFwciAxOSwgMjAyMiBhdCAwMTo1NjowM0FNICswMDAwLCBFZGdlY29tYmUs
IFJpY2sgUCB3cm90ZToNCj4gPiBZZWEsIHRoYXQgd2FzIG15IHVuZGVyc3RhbmRpbmcuIFg4NiBt
b2R1bGVzIGhhdmUgdG8gYmUgbGlua2VkDQo+ID4gd2l0aGluDQo+ID4gMkdCIG9mIHRoZSBrZXJu
ZWwgdGV4dCwgYWxzbyBlQlBGIHg4NiBKSVQgZ2VuZXJhdGVzIGNvZGUgdGhhdA0KPiA+IGV4cGVj
dHMNCj4gPiB0byBiZSB3aXRoaW4gMkdCIG9mIHRoZSBrZXJuZWwgdGV4dC4NCj4gDQo+IEFuZCBr
cHJvYmVzIC8gbGl2ZSBwYXRjaGluZyAvIGZ0cmFjZS4NCj4gDQo+IEFub3RoZXIgYXJjaGl0ZWN0
dXJhbCBmdW4gZmFjdCwgcG93ZXJwYyBib29rM3MvMzIgcmVxdWlyZXMNCj4gZXhlY3V0YWJpbGl0
eQ0KPiB0byBiZSBzZXQgcGVyIDI1NiBNYnl0ZXMgc2VnbWVudHMuIFNvbWUgYXJjaGl0ZWN0dXJl
cyBsaWtlIHRoaXMgb25lDQo+IHdpbGwgd2FudCB0byBhbHNvIG9wdGltaXplIGhvdyB0aGV5IHVz
ZSB0aGUgbW9kdWxlIGFsbG9jIGFyZWEuDQo+IA0KPiBFdmVuIHRob3VnaCB0b2RheSB0aGUgdXNl
IGNhc2VzIG1pZ2h0IGJlIGxpbWl0ZWQsIHdlIGRvbid0IGV4YWN0bHkNCj4ga25vdw0KPiBob3cg
bXVjaCBtZW1vcnkgYSB0YXJnZXQgZGV2aWNlIGhhcyBhIHdlbGwsIGFuZCBzbyB0cmVhdGluZyBt
ZW1vcnkNCj4gZmFpbHVyZXMgZm9yICJzcGVjaWFsIG1lbW9yeSIgcmVxdWVzdCBhcyByZWd1bGFy
IG1lbW9yeSBmYWlsdXJlcw0KPiBzZWVtcw0KPiBhIGJpdCBvZGQsIGFuZCB1c2VycyBjb3VsZCBn
ZXQgY29uZnVzZWQuIEZvciBpbnN0YW5jZSBzbGFwcGluZyBvbg0KPiBleHRyYSBtZW1vcnkgb24g
YSBzeXN0ZW0gd29uJ3QgcmVzb2x2ZSBhbnkgaXNzdWVzIGlmIHRoZSBsaW1pdCBmb3IgYQ0KPiBz
cGVjaWFsIHR5cGUgb2YgbWVtb3J5IGlzIGFscmVhZHkgaGl0LiBWZXJ5IGxpa2VseSBub3QgYSBw
cm9ibGVtIGF0DQo+IGFsbCB0b2RheSwNCj4gZ2l2ZW4gaG93IHNtYWxsIG1vZHVsZXMgLyBlQlBG
IGppdCBwcm9ncmFtcyBhcmUgLyBldGMsIGJ1dA0KPiBjb25jZXB0dWFsbHkgaXQNCj4gd291bGQg
c2VlbSB3cm9uZyB0byBqdXN0IHNheSAtRU5PTUVNIHdoZW4gaW4gZmFjdCBpdCdzIGEgc3BlY2lh
bCB0eXBlDQo+IG9mDQo+IHJlcXVpcmVkIG1lbW9yeSB3aGljaCBjYW5ub3QgYmUgYWxsb2NhdGVk
IGFuZCB0aGUgaXNzdWUgY2Fubm90DQo+IHBvc3NpYmx5IGJlDQo+IGZpeGVkLiBJIGRvbid0IHRo
aW5rIHdlIGhhdmUgYW4gb3B0aW9uIGJ1dCB0byB1c2UgLUVOT01FTSBidXQgYXQNCj4gbGVhc3QN
Cj4gaGludGluZyBvZiB0aGUgc3BlY2lhbCBmYWlsdXJlIHdvdWxkIGhhdmUgc2VlbSBkZXNpcmFi
bGUuDQoNCkVOT01FTSBkb2Vzbid0IGFsd2F5cyBtZWFuIG91dCBvZiBwaHlzaWNhbCBtZW1vcnkg
dGhvdWdoIHJpZ2h0PyBDb3VsZA0KYmUgaGl0dGluZyBzb21lIG90aGVyIG1lbW9yeSBsaW1pdC4g
Tm90IHN1cmUgd2hlcmUgdGhpcyBkaXNjdXNzaW9uIG9mDQp0aGUgZXJyb3IgY29kZSBpcyBjb21p
bmcgZnJvbSB0aG91Z2guDQoNCkFzIGZhciBhcyB0aGUgcHJvYmxlbSBvZiBlYXRpbmcgYSB3aG9s
ZSAyTUIgb24gc21hbGwgc3lzdGVtcywgdGhpcw0KbWFrZXMgc2Vuc2UgdG8gbWUgdG8gd29ycnkg
YWJvdXQuIEVycmF0YXMgbGltaXQgd2hhdCB3ZSBjYW4gZG8gaGVyZQ0Kd2l0aCBzd2FwcGluZyBw
YWdlIHNpemVzIG9uIHRoZSBmbHkuIFByb2JhYmx5IGEgc2Vuc2libGUgc29sdXRpb24gd291bGQN
CmJlIHRvIGRlY2lkZSB3aGV0aGVyIHRvIHRyeSBiYXNlZCBvbiBzeXN0ZW0gcHJvcGVydGllcyBs
aWtlIGJvb3QgbWVtb3J5DQpzaXplLg0KDQpFdmVuIHdpdGhvdXQgMk1CIHBhZ2VzIHRob3VnaCwg
dGhlcmUgYXJlIHN0aWxsIGltcHJvdmVtZW50cyBmcm9tIHRoZXNlDQp0eXBlcyBvZiBjaGFuZ2Vz
Lg0KDQo+IA0KPiBEbyB3ZSBoYXZlIG90aGVyIHR5cGUgb2YgYXJjaGl0ZWN0dXJhbCBsaW1pdGF0
aW9ucyBmb3IgInNwZWNpYWwNCj4gbWVtb3J5Ig0KPiBvdGhlciB0aGFuIGV4ZWN1dGFibGU/IERv
IHdlIGhhdmUgKm5ldyogdHlwZXMgb2Ygc3BlY2lhbCBtZW1vcnkgd2UNCj4gc2hvdWxkIGNvbnNp
ZGVyIHdoaWNoIG1pZ2h0IGJlIHNpbWlsYXIgLyBsaW1pdGVkIGluIG5hdHVyZT8gQW5kIGNhbiAv
DQo+IGNvdWxkIC8NCj4gc2hvdWxkIHRoZXNlIGFyY2hpdGVjdHVyYWwgbGltaXRhdGlvbnMgaG9w
ZWZ1bGx5IGJlIGRpc2FwcGVhciBpbg0KPiBuZXdlciBDUFVzPw0KPiBJIHNlZSB2bWFsbG9jX3Br
cygpIGFzIHlvdSBwb2ludGVkIG91dCBbMF0gLiBBbnl0aGluZyBlbHNlPw0KDQpIbW0sIHNoYWRv
dyBzdGFjayBwZXJtaXNzaW9uIG1lbW9yeSBjb3VsZCBwb3AgdXAgaW4gdm1hbGxvYyBzb21lZGF5
Lg0KDQpOb3Qgc3VyZSB3aGF0IHlvdSBtZWFuIGJ5IGFyY2hpdGVjdHVyYWwgbGltaXRhdGlvbnMu
IFRoZSByZWxhdGl2ZQ0KYWRkcmVzc2luZz8gSWYgc28sIHRob3NlIG90aGVyIHVzYWdlcyBzaG91
bGRuJ3QgYmUgcmVzdHJpY3RlZCBieSB0aGF0Lg0KDQo+IA0KPiA+IEkgdGhpbmsgb2YgdHdvIHR5
cGVzIG9mIGNhY2hlcyB3ZSBjb3VsZCBoYXZlOiBjYWNoZXMgb2YgdW5tYXBwZWQNCj4gPiBwYWdl
cw0KPiA+IG9uIHRoZSBkaXJlY3QgbWFwIGFuZCBjYWNoZXMgb2YgdmlydHVhbCBtZW1vcnkgbWFw
cGluZ3MuIENhY2hlcyBvZg0KPiA+IHBhZ2VzIG9uIHRoZSBkaXJlY3QgbWFwIHJlZHVjZSBicmVh
a2FnZSBvZiB0aGUgbGFyZ2UgcGFnZXMgKGFuZCBpcw0KPiA+IHNvbWV3aGF0IHg4NiBzcGVjaWZp
YyBwcm9ibGVtKS4gQ2FjaGVzIG9mIHZpcnR1YWwgbWVtb3J5IG1hcHBpbmdzDQo+ID4gcmVkdWNl
IHNob290ZG93bnMsIGFuZCBhcmUgYWxzbyByZXF1aXJlZCB0byBzaGFyZSBodWdlIHBhZ2VzLiBJ
J2xsDQo+ID4gcGx1Zw0KPiA+IG15IG9sZCBSRkMsIHdoZXJlIEkgdHJpZWQgdG8gd29yayB0b3dh
cmRzIGVuYWJsaW5nIGJvdGg6DQo+ID4gDQo+ID4gDQo+ID4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5v
cmcvbGttbC8yMDIwMTEyMDIwMjQyNi4xODAwOS0xLXJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29t
Lw0KPiA+IA0KPiA+IFNpbmNlIHRoZW4gTWlrZSBoYXMgdGFrZW4gYSBsb3QgZnVydGhlciB0aGUg
ZGlyZWN0IG1hcCBjYWNoZSBwaWVjZS4NCj4gPiANCj4gPiBZZWEsIHByb2JhYmx5IGEgbG90IG9m
IEpJVCdzIGFyZSB3YXkgc21hbGxlciB0aGFuIGEgcGFnZSwgYnV0IHRoZXJlDQo+ID4gaXMNCj4g
PiBhbHNvIGhvcGVmdWxseSBzb21lIHBlcmZvcm1hbmNlIGJlbmVmaXQgb2YgcmVkdWNlZCBJVExC
IHByZXNzdXJlDQo+ID4gYW5kDQo+ID4gVExCIHNob290ZG93bnMuIEkgdGhpbmsga3Byb2Jlcy9m
dHJhY2UgKG9yIGF0IGxlYXN0IG9uZSBvZiB0aGVtKQ0KPiA+IGtlZXBzDQo+ID4gaXRzIG93biBj
YWNoZSBvZiBhIHBhZ2UgZm9yIHB1dHRpbmcgdmVyeSBzbWFsbCB0cmFtcG9saW5lcy4NCj4gDQo+
IFRoZSByZWFzb24gSSBsb29rZWQgaW50byAqd2h5KiBtb2R1bGVfYWxsb2MoKSB3YXMgdXNlZCB3
YXMNCj4gcGFydGljdWxhcmx5DQo+IGJlY2F1c2UgaXQgc2VlbWVkIGEgYml0IG9kZCB0byBoYXZl
IHN1Y2ggSVRMQiBlbmhhbmNlbWVudHMgZm9yIHN1Y2gNCj4gYSBuaWNoZSB1c2UgY2FzZSBhbmQg
d2UgY291bGRuJ3QgaGF2ZSBkZXNpcmVkIHRoaXMgZWxzZXdoZXJlIGJlZm9yZS4NCg0KSSB0aGlu
ayBpbiBnZW5lcmFsIGl0IGlzIHRoZSBvbmx5IGNyb3NzLWFyY2ggd2F5IHRvIGdldCBhbiBhbGxv
Y2F0aW9uDQppbiB0aGUgYXJjaCdzIGV4ZWN1dGFibGUgY29tcGF0aWJsZSBhcmVhICh3aGljaCBz
b21lIG5lZWQgYXMgeW91IHNheSkuDQptb2R1bGVfYWxsb2MoKSBpcyBwcm9iYWJseSBtaXNuYW1l
ZCBhdCB0aGlzIHBvaW50IHdpdGggc28gbWFueSB1c2Vycw0KdGhhdCBhcmUgbm90IG1vZHVsZXMu
DQoNCj4gDQo+ID4gPiBUaGVuLCBzaW5jZSBpdCBzZWVtcyBzaW5jZSB0aGUgdm1hbGxvYyBhcmVh
IHdhcyBub3QgaW5pdGlhbGl6ZWQsDQo+ID4gPiB3b3VsZG4ndCB0aGF0IGJyZWFrIHRoZSBvbGQg
SklUIHNwcmF5IGZpeGVzLCByZWZlciB0byBjb21taXQNCj4gPiA+IDMxNGJlYjliY2FiZmQgKCJ4
ODY6IGJwZl9qaXRfY29tcDogc2VjdXJlIGJwZiBqaXQgYWdhaW5zdA0KPiA+ID4gc3ByYXlpbmcN
Cj4gPiA+IGF0dGFja3MiKT8NCj4gPiANCj4gPiBIbW0sIHllYSBpdCBtaWdodCBiZSBhIHdheSB0
byBnZXQgYXJvdW5kIHRoZSBlYnBmIGppdCBybGltaXQuIFRoZQ0KPiA+IGFsbG9jYXRvciBjb3Vs
ZCBqdXN0IHRleHRfcG9rZSgpIGludmFsaWQgaW5zdHJ1Y3Rpb25zIG9uICJmcmVlIiBvZg0KPiA+
IHRoZQ0KPiA+IGppdC4NCj4gPiANCj4gPiA+IA0KPiA+ID4gSXMgdGhhdCBzb3J0IG9mIHdvcmsg
bm90IG5lZWRlZCBhbnltb3JlPyBJZiBpbiBkb3VidCBJIGF0IGxlYXN0DQo+ID4gPiBtYWRlDQo+
ID4gPiB0aGUNCj4gPiA+IG9sZCBwcm9vZiBvZiBjb25jZXB0IEpJVCBzcHJheSBzdHVmZiBjb21w
aWxlIG9uIHJlY2VudCBrZXJuZWxzDQo+ID4gPiBbMF0sDQo+ID4gPiBidXQNCj4gPiA+IEkgaGF2
ZW4ndCB0cmllZCBvdXQgeW91ciBwYXRjaGVzIHlldC4gSWYgdGhpcyBpcyBub3QgbmVlZGVkDQo+
ID4gPiBhbnltb3JlLA0KPiA+ID4gd2h5IG5vdD8NCj4gPiANCj4gPiBJSVJDIHRoaXMgZ290IGFk
ZHJlc3NlZCBpbiB0d28gd2F5cywgcmFuZG9taXppbmcgb2YgdGhlIGppdCBvZmZzZXQNCj4gPiBp
bnNpZGUgdGhlIHZtYWxsb2MgYWxsb2NhdGlvbiwgYW5kICJjb25zdGFudCBibGluZGluZyIsIHN1
Y2ggdGhhdA0KPiA+IHRoZQ0KPiA+IHNwZWNpZmljIGF0dGFjayBvZiBpbnNlcnRpbmcgdW5hbGln
bmVkIGluc3RydWN0aW9ucyBhcyBpbW1lZGlhdGUNCj4gPiBpbnN0cnVjdGlvbiBkYXRhIGRpZCBu
b3Qgd29yay4gTmVpdGhlciBvZiB0aG9zZSBtaXRpZ2F0aW9ucyBzZWVtDQo+ID4gdW53b3JrYWJs
ZSB3aXRoIGEgbGFyZ2UgcGFnZSBjYWNoaW5nIGFsbG9jYXRvci4NCj4gDQo+IEdvdCBpdCwgYnV0
IHdhcyBpdCAqYWxzbyogY29uc2lkZXJkIGluIHRoZSBmaXhlcyBwb3N0ZWQgcmVjZW50bHk/DQoN
CkkgZGlkbid0IHJlYWQgYW55IGRpc2N1c3Npb24gYWJvdXQgaXQuIEJ1dCBpZiBpdCB3YXNuJ3Qg
Y2xlYXIsIEknbSBqdXN0DQphbiBvbmxvb2tlciBvbiBicGZfcHJvZ19wYWNrLiBJIGRpZG4ndCBz
ZWUgaXQgdW50aWwgaXQgd2FzIGFscmVhZHkNCnVwc3RyZWFtLiBNYXliZSBTb25nIGNhbiBzYXku
DQoNCj4gDQo+ID4gPiBUaGUgY29sbGVjdGlvbiBvZiB0cmliYWwga25vd2VkZ2UgYXJvdW5kIHRo
ZXNlIHNvcnRzIG9mIHRoaW5ncw0KPiA+ID4gd291bGQNCj4gPiA+IGJlDQo+ID4gPiBnb29kIHRv
IG5vdCBsb29zZSBhbmQgaWYgd2UgY2FuIHNoYXJlLCBldmVuIGJldHRlci4NCj4gPiANCj4gPiBU
b3RhbGx5IGFncmVlIGhlcmUuIEkgdGhpbmsgdGhlIGFic3RyYWN0aW9uIEkgd2FzIGV4cGxvcmlu
ZyBpbiB0aGF0DQo+ID4gUkZDDQo+ID4gY291bGQgcmVtb3ZlIHNvbWUgb2YgdGhlIHNwZWNpYWwg
cGVybWlzc2lvbiBtZW1vcnkgdHJpYmFsIGtub3dsZWRnZQ0KPiA+IHRoYXQgaXMgbHVya2luZyBp
biBpbiB0aGUgY3Jvc3MtYXJjaCBtb2R1bGUuYy4gSSB3b25kZXIgaWYgeW91IGhhdmUNCj4gPiBh
bnkNCj4gPiB0aG91Z2h0cyBvbiBzb21ldGhpbmcgbGlrZSB0aGF0PyBUaGUgbm9ybWFsIG1vZHVs
ZXMgcHJvdmVkIHRoZQ0KPiA+IGhhcmRlc3QuDQo+IA0KPiBZZWFoIG1vZHVsZXMgd2lsbCBiZSBo
YXJkZXIgbm93IHdpdGggdGhlIG5ldw0KPiBBUkNIX1dBTlRTX01PRFVMRVNfREFUQV9JTl9WTUFM
TE9DDQo+IHdoaWNoIENocmlzdG9waGUgTGVyb3kgYWRkZWQgKHF1ZXVlZCBpbiBteSBtb2R1bGVz
LW5leHQpLg0KDQpQYXJ0IG9mIHRoYXQgd29yayB3YXMgc2VwYXJhdGluZyBvdXQgZWFjaCBtb2R1
bGUgaW50byA0IGFsbG9jYXRpb25zLCBzbw0KaXQgbWlnaHQgbWFrZSBpdCBlYXNpZXIuDQoNCj4g
IEF0IGEgcXVpY2sNCj4gZ2xhbmNlIGl0IHNlZW1zIGxpa2UgYW4gQVBJIGluIHRoZSByaWdodCBk
aXJlY3Rpb24sIGJ1dCB5b3UganVzdCBuZWVkDQo+IG1vcmUgYXJjaGl0ZWN0dXJlIGZvbGtzIG90
aGVyIHRoYW4gdGhlIHVzdWFsIHg4NiBzdXNwZWN0cyB0byByZXZpZXcuDQo+IA0KPiBQZXJoYXBz
IHRpbWUgZm9yIGEgbmV3IHNwaW4/DQoNCkkgd291bGQgdmVyeSBtdWNoIGxpa2UgdG8sIGJ1dCBJ
IGFtIGN1cnJlbnRseSB0b28gYnVzeSB3aXRoIGFub3RoZXINCnByb2plY3QuIEFzIHN1Y2gsIEkg
YW0gbW9zdGx5IGp1c3QgdHJ5aW5nIHRvIGNvbnRyaWJ1dGUgaWRlYXMgYW5kIG15DQpwZXJzb25h
bCBjb2xsZWN0aW9uIG9mIHRoZSBoaWRkZW4ga25vd2xlZGdlLiBJdCBzb3VuZGVkIGxpa2UgZnJv
bSBTb25nLA0Kc29tZW9uZSBtaWdodCB3YW50IHRvIHRhY2tsZSBpdCBiZWZvcmUgSSBjYW4gZ2V0
IGJhY2sgdG8gaXQuDQoNCkFuZCwgeWVzIG90aGVyIGFyY2gncyByZXZpZXcgd291bGQgYmUgY3Jp
dGljYWwgdG8gbWFraW5nIHN1cmUgaXQNCmFjdHVhbGx5IGlzIGEgYmV0dGVyIGludGVyZmFjZSBh
bmQgbm90IGp1c3QgYW5vdGhlciBvbmUuDQoNCj4gDQo+IFswXSANCj4gDQpodHRwczovL2xvcmUu
a2VybmVsLm9yZy9sa21sLzIwMjAxMDA5MjAxNDEwLjMyMDkxODAtMi1pcmEud2VpbnlAaW50ZWwu
Y29tLw0KPiANCj4gICBMdWlzDQo=
