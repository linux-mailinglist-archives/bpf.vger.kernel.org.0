Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7811B50BDAA
	for <lists+bpf@lfdr.de>; Fri, 22 Apr 2022 18:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349143AbiDVQ6R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449949AbiDVQ6F (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 12:58:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B519311A06;
        Fri, 22 Apr 2022 09:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650646510; x=1682182510;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JRR4XV1G2YgFXCQmMSJI7lfT8um9u+r6a/lnPOBSEUg=;
  b=fVkSExsMK1Kysbdj27+njqtbm45+ffKLW+qMs++ukLGu2zmWPZjxWQ5q
   qhnmxKm2bJhGcGsAUQbRcgbbQuU3uOSniwKKQyBpMV5SPO5VH65Ox+0pf
   9UofLlFEo7iuelO/iO4YT28mdFX4zzrCua+b2lA73Fpqi4tU8O94DyAcy
   Ex31xXdbLJPPtcBlieAyjcAiln80u68K6tnkebZn1YIGXzpW1Bh+I/EN0
   vkgRWU8yCFp0826f5eKBZd0N20KZE9N+Xbofh6zMm9w+GT3/vLHiUEbz1
   9zB0dvv17ctETsocpaPVGAifnasdnXNNl4F0aIfIgHJReRLPYXWu5NUGG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="245299722"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="245299722"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:55:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="659105604"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga002.fm.intel.com with ESMTP; 22 Apr 2022 09:54:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 09:54:57 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 22 Apr 2022 09:54:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 22 Apr 2022 09:54:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 22 Apr 2022 09:54:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nh0nMXaCMA7vTXTRR3nBVxznZwegzDAvfUNJ9Vh3VvkrFy5Dx6K7c3qpbpTjBeLH7lrbl2TagQoxMmYopLThHBRmaAwifXInU+r8szbD4uFyyGp19rVOdGUvTplUxD3lXP5KqURsYi3OAqMVNZm1fvO3aeAHbnzXY8zFVMqmR22n0HmAtMPVU62qQMlH7JWWLA63RZ3OsJAoI7aJyGTiDWWbGTOpm10fXV3mIEENuFpAE/PcKYGgRI+wJQj25zXi5oOZ5Pgr7atzOwPceI8x9DzSX+TbiqtLOxtW4E0+nBt7IRz0xy5J4USeojhP9/53xVw/e9orw0FAobGKwI3AdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRR4XV1G2YgFXCQmMSJI7lfT8um9u+r6a/lnPOBSEUg=;
 b=BT2wEAbqD9Y4dAcnu0TXBxY9DldKu3NXHHVOpMSNAqEZsSxZcc3c2Nh/7vD6AihoZaMi4RMraE+3qVfREnAOnyg6vEUChfDoixmjmk5SN+fsRedvwtLL94F177qwF+9xjuxjVz4cveNuB1MPzISiHtLvObBwuWNp/df8mrebcysRD1YmR6Od6xb2d81F/GDdCbd4cU8MMnAqeJhst/mrPQuVAh7n/RPE4hrVWhyWZ9FExbhkJd2m0qGRQTciXRAtbnYPT9dTI7Tubg3IoFIfLeWA2ylDKEDxD6jE/sQKrrThvVHKeZOUhirV3Ar9ss6p/oTkJ3+GDzrrhT6S5ndVXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BYAPR11MB3782.namprd11.prod.outlook.com (2603:10b6:a03:fd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 22 Apr
 2022 16:54:52 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5186.015; Fri, 22 Apr
 2022 16:54:52 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "Kernel-team@fb.com" <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "song@kernel.org" <song@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dborkman@redhat.com" <dborkman@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAD2rgIAA23qAgAAKuICAAhm2gIAAJ/4AgAA00QCAAHKLAIAAB8GAgACFUwCAACY8gIAABT0AgADspYA=
Date:   Fri, 22 Apr 2022 16:54:52 +0000
Message-ID: <e00b452952e7aaef0d94bc25a32261aafeeff7ea.camel@intel.com>
References: <20220415164413.2727220-1-song@kernel.org>
         <YlnCBqNWxSm3M3xB@bombadil.infradead.org> <YlpPW9SdCbZnLVog@infradead.org>
         <4AD023F9-FBCE-4C7C-A049-9292491408AA@fb.com>
         <CAHk-=wiMCndbBvGSmRVvsuHFWC6BArv-OEG2Lcasih=B=7bFNQ@mail.gmail.com>
         <B995F7EB-2019-4290-9C09-AE19C5BA3A70@fb.com> <Yl04LO/PfB3GocvU@kernel.org>
         <Yl4F4w5NY3v0icfx@bombadil.infradead.org>
         <88eafc9220d134d72db9eb381114432e71903022.camel@intel.com>
         <B20F8051-301C-4DE4-A646-8A714AF8450C@fb.com> <Yl8CicJGHpTrOK8m@kernel.org>
         <CAHk-=wh6um5AFR6TObsYY0v+jUSZxReiZM_5Kh4gAMU8Z8-jVw@mail.gmail.com>
         <1650511496.iys9nxdueb.astroid@bobo.none>
         <CAHk-=wiQ5=S3m2+xRbm-1H8fuQwWfQxnO7tHhKg8FjegxzdVaQ@mail.gmail.com>
         <1650530694.evuxjgtju7.astroid@bobo.none>
         <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
         <CAHk-=wiQcg=7++Odg08=eZZgdX4NKcPqiqGKXHNXqesTtfkmmA@mail.gmail.com>
         <1650584815.0dtcbd4qky.astroid@bobo.none>
         <310d562b80ad328e19a4959356600e4efe49cf4c.camel@intel.com>
         <CAHk-=wg+xn7WbSEb1boSCj+AEUwwAGmXf5Hvb0822BHyBwRoDw@mail.gmail.com>
In-Reply-To: <CAHk-=wg+xn7WbSEb1boSCj+AEUwwAGmXf5Hvb0822BHyBwRoDw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc12fba9-566a-4296-8447-08da2480d200
x-ms-traffictypediagnostic: BYAPR11MB3782:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3782FDCB1A861E26AB7A8BB9C9F79@BYAPR11MB3782.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tK0JcB7RbCRTtA9AX15PIjXbkgNZSlcrauwW4Cs8UK/u10aNBGTP8lpbs9DaunDu/NkPoP4v0zw5jBL3VVb3Xao6Ba9w4ZS7+ESPdJp3jCzK/SfMfbWysA0Sa/cNOE6I/F/nwzuIIAmRgf9y7DJGqEvRtpGrkfd9KpKPqadwTO1bdoHgloJFNelFPnkQz0Cqt5VU3lAnclQUJVjGYh9Axd8O373Z4rsd82xXP0COBtAjSbgfPlpyLHTl68wHLkJTW49K055bio61nK5ipwQ+qcmCv9bawvk+//5N8C4WmAS5ZLAKkw6F+6ZXH9b/an4XVdPkTFtQSn7dKvnFLkOpu7ZnB8U7/R68x9JBop9Vk4NOtfo3/Gds3zLDktsNyVPxyShtM8FRtXShNsSC0lQTGEiqao3syjlNbDYcU8qGkt5fz+MyGrmQ4tgAO20079tJhxBJ1bkGlIfPrkbPRqQVYu2u2r6FfO8bp2ksHQqNNIYh52LzP0GMJSFF3dCMNepVkPi9RabmmmzmWfwM72uF+PmyklGXaya1vHC1HkoxnXCiDx7dXa0KDZ3+FyOxHTEubdyk8cXDvv+uPqn3cE2GfQYX4kRz+PKxMoBwGXis4f5acbLy9iaIUJZkfh0oT8IXDvg3PKrvo08wehkz951RBJAFbtu+Ecc77ctlgEFB2WPV/INEc4siPqNlo5Bv5A39rvbTtEf5JO18SI/sITt/OR6SfNFRH9AohmEb3OugVhmbR8ZGNlkqK6fnXa2jICJ7VyKsam4bn+ag+HpCoNsnQ36z8gVNuE2PNP8XyodV2y/SsH9pqjy3UzOULn9sMJluWjn/krUUubmT34q3AF5rkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(38070700005)(66946007)(966005)(86362001)(66556008)(38100700002)(6486002)(36756003)(5660300002)(7416002)(186003)(2906002)(508600001)(91956017)(316002)(76116006)(66476007)(4326008)(64756008)(6916009)(66446008)(54906003)(8676002)(26005)(6506007)(6512007)(71200400001)(8936002)(122000001)(2616005)(82960400001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVpIZ29XQkJmNmk3em5RaVp3eXNld3Vidkl1bTY2Y3NpOWMvb1ltcnUrTnhV?=
 =?utf-8?B?SkJ2aUcraHVISldQUkxNNmRXSzZzb1kxSmZFd0lJa01BZmsyWVpVTlQ0bUg1?=
 =?utf-8?B?My9La2thd3ZXZkhvR29VL1doMnZCaWQzanNMTTlsUVoxdjdDdlFkSUhKTTd3?=
 =?utf-8?B?NDg3Rjc4cGE4SkdPVFg1WithZEM5eUpZZEhGVG5QMlo0V0dDcE1GTGFyNUtI?=
 =?utf-8?B?aGFRSXFiUGd6RkZHc2RiVXhrcEFmVkJpSmI2SmFhUkVnVlYxSVZGTXZvSjZz?=
 =?utf-8?B?T2VReHAvbUZtNU90MzVvb05JMFF3UEVadjR5alVxd2w0RS85Ri9GWTJtZWl4?=
 =?utf-8?B?V3pseXNYRHVGYUp2TVRJeHZ3ZU0vejJwMklaSFdmYi9CRnlVeC93MjZnWEVQ?=
 =?utf-8?B?c0w3ZlRuK1E3RmNrd2FWUXkvNW5lZUlkSTFrd1hUYUFJOWE3QTM5OVBZMTAr?=
 =?utf-8?B?K1VrZlpvL1VPeTloeUZyNW93MmNPUk5HUS9SK3RYZU0xY1ZlK3RialVnOGVm?=
 =?utf-8?B?bE5JRWZTak94VVF0QUhkMXlpNURkZ3Q3LzRmRjBRYThNZjcvNXBCcjB1U3Rm?=
 =?utf-8?B?dis5ekhvQlR1OTNVZ3lvMzl4eDM2YlNReTN0bkV6ZjluWHdFcEpLSkJvY09D?=
 =?utf-8?B?dG0rOW12WXJpVUpZUHVhR0dvckVGQ0k0Z3E1ZktDUmdXR0NUTU9MN3k2OEM3?=
 =?utf-8?B?WUR0eHRUYTdrZ1Y1QXZ5ZkJTbFdHVm5oUmJWbVA1R290SW1TczMyNDNZL2FF?=
 =?utf-8?B?b2N6R3FRVmthdVU2NmpnMG90ZkRtTXp3d2kxNDFBZTJHSWRsVW8rRFhLNXEx?=
 =?utf-8?B?NjVPdnZ1U01MNzRwYW5QcktmVFNmUFZGYi9DTWc4UUxPVDJtSGtKV0JpS3JP?=
 =?utf-8?B?UU9HOU9ZSTBvOFdJU2RZU1Fob2h4eUFtblhDdHBac3c5ZkY2NlllUHFqVUFS?=
 =?utf-8?B?TW9kbis0ajYzOC9lMXRHd1pSeFFRMHBtNkpleWlSRWZGMHE0U3MraTNRYTFF?=
 =?utf-8?B?NnlTSlM3TjhjeWNadll5UXpTeEttSHFEckduOWhKVUtNRnUxUEtJYzJoQkpa?=
 =?utf-8?B?QmVQcVBPa2xTa0RGdmV6cjBodm9vWC9PNDVGUDVodjJIc0tqNVBucXkzc1c2?=
 =?utf-8?B?a0wra29lYUQ5TmNPczA4RHY2REl0VDRuVGp1cFZmSGwrbUJwVHJWbGxGKy96?=
 =?utf-8?B?ZXAyUlkrRVZNRDh0VFZGM0d1VEl2bTNEdVI1aGwvOWN0MHVGdzFsVFN2Q2FM?=
 =?utf-8?B?dUYwTytQNERrazljdkRzWG85N0RpTldhU3dKbTJOMTdzZi9RYzlERVpvbkd5?=
 =?utf-8?B?M1NhYU9xSnlxaUI4c3Q5UFFSZjUya2VkVnJDVUlxRFNYeDVlNEZwUFhyN1BO?=
 =?utf-8?B?cytjL25vYm9hWjBFQXVyZlRFZnNDNjdSQlhiZ2xwSUFEUjJYZ3NPNUhOVjRV?=
 =?utf-8?B?NGZiMkEvWTFHZGFMUzcwcEZLZTV5TGpXUHR5WVNYeXA1aTMzM1FXa2E4Rm0y?=
 =?utf-8?B?MTRNZ3lXQjJ2VEJ6MXhCTnhrdTVubjBjM01ZSUdXNlpyaGNTVlVrdnpsNUpS?=
 =?utf-8?B?VmxMSDhaLzVrWk4ydXhlS2s1TmdSMTFLSlltRzdqL1d1QkU4Z1hTZnYyR09K?=
 =?utf-8?B?TmVZV0l3cFZ2MzcwaFBpWmwxME5ack9wS3JnUEl2TTJJYjVYQldOOEdSNHI2?=
 =?utf-8?B?Z2NOYWJ3OUVydzJYNnV4dSttR05HMmpKVC9melg3a3NheFo1OXJzZUVXUHFT?=
 =?utf-8?B?eiswc3FTa1owOVhGNmFFb0Y2VzVtSnZKRCtNSWNXZlRoczRycUhYdGF5ZWFj?=
 =?utf-8?B?UmtibHFyc1dXRWd5OGtmRCs4VkdVVVlwMFNkUUUrUkwyVU1aNUtsd0Y2SDUv?=
 =?utf-8?B?WjVwUVVJc01KSS9kZzJGY3NFczBBSUFZK2g3ZHhhUWlLb21KeVdsVGVwYnFV?=
 =?utf-8?B?blNDdUJyRXZvdmV1QW91R1ZuRnQ0SUs3K0FTUmJPZy81d28vd25wM0M3ZHA1?=
 =?utf-8?B?QjcvcXVBUzBIeUFDSTFxYmFZdE5nWGY2dE1QRTRWNk9vM2NqS1FrREgyUisv?=
 =?utf-8?B?NEdmcnZHbFk1YjB1bWNwUDdOWm9QUmhhdXNGWWUrYkpFSExWMC9oOW1XeCsy?=
 =?utf-8?B?YVhEYTJsNEJXVmh6WTRTdWh3cDFlRFY3RUtRZlpENjg5Tm1sQ1FJckFKNkxz?=
 =?utf-8?B?eE5mTmFIS2Q3bzMzK3lLOVhPNXVCdjFVS29SYW9ka3Z3dUI4R3pWM3FDV3ZB?=
 =?utf-8?B?T2g1TjJ0SzB6YzVrS3UrUVR5OTh3N3luWEhiQlRXZkNWQlpMUkxsMnkxWHor?=
 =?utf-8?B?bkV2TVAvWW94cU5zQVc1U0YrMHpiNDF0S0VjcGlzVE1aN0NEZXpwY2NzaDFs?=
 =?utf-8?Q?22sL67L4/0IJEItt0yDZlizQmGQXbDLg6dpKQ?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E59FEC4797C4CE499C175F4B3A381474@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc12fba9-566a-4296-8447-08da2480d200
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 16:54:52.3389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeRqBtLWXV1ExHPPBrB23y3Wak65dJyVB81UlpWRq5O9RlmFbLl4yN9T/20ewlgwjX2C+U4fHRKe5Uwd1GM+ezn1UDKM2BW97+0j5Yb+xuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3782
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTIxIGF0IDE5OjQ3IC0wNzAwLCBMaW51cyBUb3J2YWxkcyB3cm90ZToN
Cj4gSSBkb24ndCBkaXNhZ3JlZSwgYnV0IEkgdGhpbmsgdGhlIHJlYWwgcHJvYmxlbSBpcyB0aGF0
IHRoZSB3aG9sZSAib2VuDQo+IHBhZ2Vfb3JkZXIgcGVyIHZtYWxsb2MoKSBhcmVhIiBpdHNlbGYg
aXMgYSBiaXQgYnJva2VuLg0KDQpZZWEuIEl0IGlzIHRoZSBtYWluIHJlYXNvbiBpdCBoYXMgdG8g
cm91bmQgdXAgdG8gaHVnZSBwYWdlIHNpemVzDQpBRkFJQ1QuIEknZCByZWFsbHkgbGlrZSB0byBz
ZWUgaXQgdXNlIG1lbW9yeSBhIGxpdHRsZSBtb3JlIGVmZmljaWVudGx5DQppZiBpdCBpcyBnb2lu
ZyB0byBiZSBhbiBvcHQtb3V0IHRoaW5nIGFnYWluLg0KDQo+IA0KPiBGb3IgZXhhbXBsZSwgQU1E
IGFscmVhZHkgZG9lcyB0aGlzICJhdXRvbWF0aWMgVExCIHNpemUiIHRoaW5nIGZvcg0KPiB3aGVu
DQo+IHlvdSBoYXZlIG11bHRpcGxlIGNvbnRpZ3VvdXMgUFRFIGVudHJpZXMgKHNoYWRlcyBvZiB0
aGUgb2xkIGFscGhhDQo+ICJwYWdlIHNpemUgaGludCIgdGhpbmcsIGV4Y2VwdCBpdCdzIGF1dG9t
YXRpYyBhbmQgZG9lc24ndCBoYXZlDQo+IGV4cGxpY2l0IGhpbnRzKS4NCj4gDQo+IEFuZCBJJ20g
aG9waW5nIEludGVsIHdpbGwgZG8gc29tZXRoaW5nIHNpbWlsYXIgaW4gdGhlIGZ1dHVyZS4NCj4g
DQo+IEVuZCByZXN1bHQ/IEl0IHdvdWxkIGFjdHVhbGx5IGJlIHJlYWxseSBnb29kIHRvIGp1c3Qg
bWFwIGNvbnRpZ3VvdXMNCj4gcGFnZXMsIGJ1dCBpdCBkb2Vzbid0IGhhdmUgYW55dGhpbmcgdG8g
ZG8gd2l0aCB0aGUgMk1CIFBNRCBzaXplLg0KPiANCj4gQW5kIHRoZXJlJ3Mgbm8gImZpeGVkIG9y
ZGVyIiBuZWVkZWQgZWl0aGVyLiBJZiB5b3UgaGF2ZSBtYXBwaW5nIHRoYXQNCj4gaXMgMTcgcGFn
ZXMgaW4gc2l6ZSwgaXQgd291bGQgc3RpbGwgYmUgZ29vZCB0byBhbGxvY2F0ZSB0aGVtIGFzIGEN
Cj4gYmxvY2sgb2YgMTYgcGFnZXMgKCJwYWdlX29yZGVyID0gNCIpIGFuZCBhcyBhIHNpbmdsZSBw
YWdlLCBiZWNhdXNlDQo+IGp1c3QgbGF5aW5nIHRoZW0gb3V0IGluIHRoZSBwYWdlIHRhYmxlcyB0
aGF0IHdheSB3aWxsIGFscmVhZHkgYWxsb3cNCj4gQU1EIHRvIHVzZSBhIDY0a0IgVExCIGVudHJ5
IGZvciB0aGF0IDE2LXBhZ2UgYmxvY2suDQo+IA0KPiBCdXQgaXQgd291bGQgYWxzbyB3b3JrIHRv
IGp1c3QgZG8gdGhlIGFsbG9jYXRpb25zIGFzIGEgc2V0IG9mIDgsIDQsIDQNCj4gYW5kIDEuDQoN
CkhtbSwgdGhhdCdzIG5lYXQuDQoNCj4gDQo+IEJ1dCB0aGUgd2hvbGUgIm9uZSBwYWdlIG9yZGVy
IGZvciBvbmUgdm1hbGxvYyIgbWVhbnMgdGhhdCBkb2Vzbid0DQo+IHdvcmsNCj4gdmVyeSB3ZWxs
Lg0KPiANCj4gV2hlcmUgSSBkaXNhZ3JlZSAodmlvbGVudGx5KSB3aXRoIE5pY2sgaXMgaGlzIGNv
bnRlbnRpb24gdGhhdCAoYSkNCj4gdGhpcw0KPiBpcyB4ODYtc3BlY2lmaWMgYW5kIChiKSB0aGlz
IGlzIHNvbWVob3cgdHJpdmlhbCB0byBmaXguDQo+IA0KPiBMZXQncyBmYWNlIGl0IC0gdGhlIGN1
cnJlbnQgY29kZSBpcyBicm9rZW4uIEkgdGhpbmsgdGhlIHN1Yi1wYWdlDQo+IGlzc3VlDQo+IGlz
IG5vdCBlbnRpcmVseSB0cml2aWFsLCBhbmQgdGhlIGN1cnJlbnQgZGVzaWduIGlzbid0IGV2ZW4g
dmVyeSBnb29kDQo+IGZvciBpdC4NCj4gDQo+IEJ1dCB0aGUgKmVhc3kqIGNhc2VzIGFyZSB0aGUg
b25lcyB0aGF0IHNpbXBseSBkb24ndCBjYXJlIC0gdGhlIG9uZXMNCj4gdGhhdCBwb3dlcnBjIGhh
cyBhY3R1YWxseSBiZWVuIHRlc3RpbmcuDQo+IA0KPiBTbyBmb3IgNS4xOCwgSSB0aGluayBpdCdz
IHF1aXRlIGxpa2VseSByZWFzb25hYmxlIHRvIHJlLWVuYWJsZQ0KPiBsYXJnZS1wYWdlIHZtYWxs
b2MgZm9yIHRoZSBlYXN5IGNhc2UgKGllIHRob3NlIGJpZyBoYXNoIHRhYmxlcykuDQo+IA0KPiBS
ZS1lbmFibGluZyBpdCAqYWxsKiwgY29uc2lkZXJpbmcgaG93IGJyb2tlbiBpdCBoYXMgYmVlbiwg
YW5kIGhvdw0KPiBsaXR0bGUgdGVzdGluZyBpdCBoYXMgY2xlYXJseSBnb3R0ZW4/IEFuZCBwb3Rl
bnRpYWxseSBub3QgZW5hYmxpbmcgaXQNCj4gb24geDg2IGJlY2F1c2UgeDg2IGlzIHNvIG11Y2gg
YmV0dGVyIGF0IHNob3dpbmcgaXNzdWVzPyBUaGF0J3Mgbm90DQo+IHdoYXQgSSB3YW50IHRvIGRv
Lg0KPiANCj4gSWYgdGhlIGNvZGUgaXMgc28gYnJva2VuIHRoYXQgaXQgY2FuJ3QgYmUgdXNlZCBv
biB4ODYsIHRoZW4gaXQncyB0b28NCj4gYnJva2VuIHRvIGJlIGVuYWJsZWQgb24gcG93ZXJwYyBh
bmQgczM5MCB0b28uIE5ldmVyIG1pbmQgdGhhdCB0aG9zZQ0KPiBhcmNoaXRlY3R1cmVzIG1pZ2h0
IGhhdmUgc28gbGltaXRlZCB1c2UgdGhhdCB0aGV5IG5ldmVyIHJlYWxpemVkIGhvdw0KPiBicm9r
ZW4gdGhleSB3ZXJlLi4NCg0KSSB0aGluayB0aGVyZSBpcyBhbm90aGVyIGNyb3NzLWFyY2ggaXNz
dWUgaGVyZSB0aGF0IHdlIHNob3VsZG4ndCBsb3NlDQpzaWdodCBvZi4gVGhlcmUgYXJlIG5vdCBl
bm91Z2ggd2FybmluZ3MgaW4gdGhlIGNvZGUgYWJvdXQgdGhlDQphc3N1bXB0aW9ucyBtYWRlIG9u
IHRoZSBhcmNoJ3MuIFRoZSBvdGhlciBpc3N1ZXMgYXJlIHg4NiBzcGVjaWZpYyBpbg0KdGVybXMg
b2Ygd2hvIGdldHMgYWZmZWN0ZWQgaW4gcmMxLCBidXQgSSBkdWcgdXAgdGhpcyBwcm9waGV0aWMN
CmFzc2Vzc21lbnQ6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvNDQ4OGQzOWYtMDY5
OC03YmZkLWI4MWMtMWU2MDk4MjE4MThmQGludGVsLmNvbS8NCg0KVGhhdCBpcyBwcmV0dHkgbXVj
aCB3aGF0IGhhcHBlbmVkLiBTb25nIGNhbWUgYWxvbmcgYW5kLCBpbiBpdHMgY3VycmVudA0Kc3Rh
dGUsIHRvb2sgaXQgYXMgYSBrbm9iIHRoYXQgY291bGQganVzdCBiZSBmbGlwcGVkLiBTZWVtcyBw
cmV0dHkNCnJlYXNvbmFibGUgdGhhdCBpdCBjb3VsZCBoYXBwZW4gYWdhaW4uDQoNClNvIElNSE8s
IHRoZSBvdGhlciBnZW5lcmFsIGlzc3VlIGlzIHRoZSBsYWNrIG9mIGd1YXJkIHJhaWxzIG9yIHdh
cm5pbmdzDQpmb3IgdGhlIG5leHQgYXJjaCB0aGF0IGNvbWVzIGFsb25nLiBQcm9iYWJseSBWTV9G
TFVTSF9SRVNFVF9QRVJNUw0Kc2hvdWxkIGdldCBzb21lIHdhcm5pbmdzIGFzIHdlbGwuDQoNCkkg
a2luZCBvZiBsaWtlIHRoZSBpZGVhIGluIHRoYXQgdGhyZWFkIG9mIG1ha2luZyBmdW5jdGlvbnMg
b3IgY29uZmlncw0KZm9yIGFyY2gncyB0byBiZSBmb3JjZWQgdG8gZGVjbGFyZSB0aGV5IGhhdmUg
c3BlY2lmaWMgcHJvcGVydGllcy4gRG9lcw0KaXQgc2VlbSByZWFzb25hYmxlIGF0IHRoaXMgcG9p
bnQ/IFByb2JhYmx5IG5vdCBuZWNlc3NhcnkgYXMgYSA1LjE4IGZpeC4NCg0K
