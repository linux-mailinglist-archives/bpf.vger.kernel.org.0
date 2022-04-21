Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C650D50A4A1
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 17:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390285AbiDUPuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 11:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390282AbiDUPuP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 11:50:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B38143AD4;
        Thu, 21 Apr 2022 08:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650556046; x=1682092046;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=y40IUO5X2Dnfy2febu6yEKzIcT6QZFRNeqZoGozajJ0=;
  b=hL8zIQ1CL6iyNA71KYligE+3C4sj/IqtydowBM+Mgp+sqm09jd3v97VZ
   ZDEV+Htslk9Oo0/Ci7zM4M/Sx/Z6WIWjkbTuWJGENY6hBu/Gjbh1jc1Qq
   s6nNK/5GWvfFQOIivlYHfaGF+Jjq1MhzBPynhJm/eE3R4HrUmbQ+FSOQr
   fVcwDUU8GdWtoYh+BoOp2v4mtJFRGXOi8mevOvxDtlJbQOVRoP0HMbd9z
   VIzYszTrISbT8LtowGYQsAA4umq/csM6t/lHFjTXnrN3TDUpAiHXQuirs
   jSkWJa0sBf7/VeXOt+0SwtQcy2KyDaT7O2WyxU/myxIRXPnbdlRkiqEkE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="251714951"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="251714951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 08:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="648187458"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 08:47:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 08:47:24 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 08:47:24 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 08:47:24 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 08:47:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIggzBoy3RplCXllURqdlJpfUgguv2RwdbrXQksh24cvmemHVyi1aoIOdEq/ATiEFLOxuY4Q3qNI3nXMFjhGY/3gZMzSNBfbHF+bLIqUawf6umIVw17NsTP+K7sAppkOAxwngIyMDEW2WXPK8X68WS8w04X/FIc/lCLBik+TpDgidvBYjF4FPyA3/PIZfcni6jxeKoaWKKDnvFzk1daOs2ieot2GbVen/7I52U06GJJGG9NKuI98TafZxqjZ3rKzAZQqBc4JxYUu3ZVHhyyr8305MFCvUX2Ls7MZtpHzEAcrlzJ46lJDkU7/wMqnhh1PrbkX4lupl6J/kr/Y58zMbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y40IUO5X2Dnfy2febu6yEKzIcT6QZFRNeqZoGozajJ0=;
 b=ldU6a9mcbgQvscfxBxQGElhhXTb5h9J46u8FUjBGo3PzMpKpcIwwU7C1o0ZtQe9Zk01o99Oon1hzUJmZVyOh0YvNvfFpnS6IdzS8l6PVAtS4/QKPscGWKq2vmdiWCI0oh6PfHwQeRV4eulpJmNkk433OkaINYMFpxQm182Gg13UGsdBwjcYvmgiAZn0/1KRjm/Bepq8sLom0anc9STHlMYk0/vCGYzrmmGKDE9BLoxIZaOGt4lVqmXdMZNCzLCQ0dcK7TWfWyks2y2rkw5alCFXlaK7rQg5QZ2+j9ryXrL+o9kSCrcrKzjGwo50tKKEvw6Tk8zj+BVUg23xuv4053Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN6PR11MB3488.namprd11.prod.outlook.com (2603:10b6:805:b8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 15:47:21 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5186.015; Thu, 21 Apr
 2022 15:47:21 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>
CC:     "songliubraving@fb.com" <songliubraving@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
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
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>
Subject: Re: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Topic: [PATCH v4 bpf 0/4] vmalloc: bpf: introduce VM_ALLOW_HUGE_VMAP
Thread-Index: AQHYUOjaBVzlZEmkq0yuNBGgG1oCjazxVckAgACoe4CAAPegAIAACf+AgAAgOgCAAlYLAIAA9TuAgAAUCQCAAD2rgIAA23qAgAAKuICAAhm2gIAAJ/4AgAA00QCAAHKLAA==
Date:   Thu, 21 Apr 2022 15:47:21 +0000
Message-ID: <25437eade8b2ecf52ff9666a7de9e36928b7d28f.camel@intel.com>
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
In-Reply-To: <1650530694.evuxjgtju7.astroid@bobo.none>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4451721-c13f-4e55-1b61-08da23ae393e
x-ms-traffictypediagnostic: SN6PR11MB3488:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SN6PR11MB3488B2D18941484175911C02C9F49@SN6PR11MB3488.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xOpl3Eu5fFs7ucpEJkAk0xkEWH7wimjm5UoI7UMhssmSskjUwCdoieldIZDyUvUS1t4UZhOSxgdgoe94YV1xYVWDQm5MO47feCFmfndsjAE/6Pf9ehACMle6p95UMMmlx6r94khz2MhCo9AGCzokMZHl3d4pD41Vlbsm7L4TcTS72myV7CAr8q+uSyREVlM6iCXIGB5R2rD5yFwQl9jmkKSEStI35gaB7LB2zcw8lCIzMKLVqEvjVTYtngOO8QO/eddgcta1T/TQq1XYwo2TKQLXR9sRkmTZIgqf8TUQ1Z07xsQAa+YUNaUgt+FwZNwXcDyodJMy3RAL2TcHPhrwIL2Ty2b5UPmhqM1a5DkWrrImS7TrDJ1Lgm4sUEMcZ4KRGRzuIpcXbEq8G0MjVlu7hwKp8Zra98+/lJG/3uBG18NrjMTirR8N+GCXLM+0h9OpRgg68VEV+znHSbZ+Pef6MSa7usLDngtHkUnlfkjqlWPmc2J3QfqAeK6SK59KFEX5h3lMZce9o6ODpGpQT4HuzAw5l9Xpx6NB8tisNB3GPovAIo2ayVTuKoagp+68ndCRXctFByP1bP2PAR72aiUVotimrIXdVySylxjDoYOYaExsU1f/mrcqLkzhW8kfaNJ03UV9NSrbz1kU5PGpD/zOeytSO28LLbGT3gWfBdBFi7Y13nwcMwWlJnNayqpejzLQ1LOOp9q+WAr6wvdCiBFQ5/9Lwe1T3NKou4JF7NwBesOYVZ+ACTlTFUdDNAj/R7O7PMB/Hdoc1maVX5M/mdAz4bl/cXcvwqEIx48AEH3h5wSx78KRPDm6tp2mpbdu2pKHmUqMtyovDq5uVLz0epaXPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(110136005)(54906003)(6486002)(508600001)(6512007)(8936002)(4326008)(5660300002)(6506007)(122000001)(7416002)(2616005)(36756003)(66946007)(8676002)(966005)(38100700002)(316002)(186003)(82960400001)(91956017)(66446008)(64756008)(38070700005)(71200400001)(2906002)(66556008)(76116006)(86362001)(66476007)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QlhZNEVXbFNPREJtaDRIUk5xdXJ3bEgyK2pHbmZrdzliTTFJaFEwWjQ0ZXRN?=
 =?utf-8?B?OVZNV0tBUlluZ2I4NFhXY1JaejhNbTNYSEwvS2k0bEo5aTV4azRWSmtDcE5X?=
 =?utf-8?B?QkpQc2F4eXJ5LzgvVHFFZHgyME9vYUpaMDRyMFZpV2wwWEpKSFF5cFl6N3lr?=
 =?utf-8?B?U2tLSk9BMXIyYkZqSnYrdWh2dHl3WmtUOVdWakh2SmJtcjVUdGMvc1h4djNz?=
 =?utf-8?B?T2NDUFBhYmxGWmk5eHRCajk1SGJ3L00xV09nSk9sOGRLaU1SdVpZenlUKzll?=
 =?utf-8?B?Qk9LOVpjaGI2S25qVXdibXBwTlNMKytZOHVZQyt0RDludW1PRnFNL21XVW1a?=
 =?utf-8?B?UldFSlYvL2IxTExCRXR4cEZTUm9XeTBUc3ptY1VWU0hyWjdwMnFiK2NLMG5z?=
 =?utf-8?B?TzVCY1M2VjRYTTIwUkw2REFhdkw0RXBWN3ZKWmY1UzU5OUg2bjZheVg3czRs?=
 =?utf-8?B?aWpYWVBEdDAwcWVXWHpmcG1FbXFUdFVYMXp0TUgyY1VkQU9RdVhhUzlIcEhI?=
 =?utf-8?B?WURZbHF0N3ZvdWVjOXV6a05paUZESnpzdzQrR0x5ZmlxRlFCWGFIZmhNdjVN?=
 =?utf-8?B?MUtMemNNdTZicXdtQlNoTTc1OStBbGdzQ3V5SERQWHVEMTFBcG1QbXVDSXRD?=
 =?utf-8?B?SFd0ZkpvZzdVSG54b09IdVl2cjBhcFRhUmRTN1A2RW03YU03dEllaXZHSk5D?=
 =?utf-8?B?MVRETWh0RDZlUWVGV1IwMzMwZkF0WUJoS2l3aFVVQkRZa1NzS2gvSU8xVVNt?=
 =?utf-8?B?cnZTT3Q4MDkzekg3TVYrZlU4cUs1VExTUnUwZjdOYUxiTUgzbkdKN0RZNzh0?=
 =?utf-8?B?b3IyQTg2VUdrQnZ6Tk4rNlFlVjZFRFdBWHNkMXlvcGlZZ2dyOStBNXc5N2NM?=
 =?utf-8?B?dVlkNWdkSTVxK3FUYmVOR2Vabnl3em5jb3cxWDNEY1l2QnM2OWQ0V0w1L1Q2?=
 =?utf-8?B?QVZDc2FrV3ZrZzdVWWxicUQxZUxvZkhDbG93NXMwc2ZkYXhxVU9ZOE1DMzJQ?=
 =?utf-8?B?cEo4eE9WNGN3ZDZoR2tRdmJGdnArd0pOa0ltbTRhc0VHS25tWXkwOG94aER5?=
 =?utf-8?B?U09ZOTNUYTdRelI4ZDZ4Z2hkZ2VMR0VoM3hnV1lxRFhkaEtGc3hkakt6cy9L?=
 =?utf-8?B?bWkyVGl5Rzc1WG82RXRZbFdMeTZCM1lmK1hVVzJ2dkt6NjJRUExubWV3cFBj?=
 =?utf-8?B?bWhuVVRuV3hpOE1vL1cyem1tNFBwLzZLZlB4ZUNPMXZaWVhaQzRYSTdzS0Zn?=
 =?utf-8?B?NHBOVm5paENKclNsaG1iRmcwLzk1aGlKdG1WVW5tQW1YT3BZQjJCVVNRb0Er?=
 =?utf-8?B?ek9oRmNsc0NUYWFCN1AvWE96RjJiSzFDenh0TU5GbUhRYmJ0cE96bHlQeDU5?=
 =?utf-8?B?ZU5EZTlnS1JjRmt1OWJyMjhKVC84MmNBY2lMWGFTVktEY2l0U1RVK01mb3Bq?=
 =?utf-8?B?R2RKUWdzYnhCM2ovbTFzSUNhYm9iK0UvQ3JXZmgwdENVM2haTWpKVEhpcmF4?=
 =?utf-8?B?V0ZDY2toZEJ6YnNkdmpRMW9OeVIwRWdDRElPZmVvTHd2NWEzTFhoeTU5Wmlm?=
 =?utf-8?B?Sy9GZmpwRjI0OTN4VXJSQlZsSWIxL1d2VjEza0FYYzFsd1hISDVQZWU0dVU4?=
 =?utf-8?B?WWVJY2JEd1NHQThZYWZLRDFSVVU0OGxuRDJvUVZzYVhQUmFHbHh2Q0RPREg1?=
 =?utf-8?B?eHhVZlBGWVRkUGxtMFloUDlUWDZ2c2UxV1FzYzdjcjRwV3lRMDZZZmpKYjVu?=
 =?utf-8?B?RzQ5VVo1b0s4NEpubFUwZVVHS2F1bHNCQmdWK1lFQ1JTZ0dqTS9CR2FTQTJM?=
 =?utf-8?B?dUZUVjFBNHp3L3d5cEhvWEJzZTdlVzYvQTFQWjJyM1ZBTmYwOThXdFBQeVVP?=
 =?utf-8?B?YmE2djBkcFRubk1rR0RhVVF2WXZGN01INW9YOW9GWmV6bXRQS3gwUkZ3NHNi?=
 =?utf-8?B?MDM1RkJsK0FZakZtQjIrYUthalFFRk1CT0tQemZOSlV2dUNCUHgvN1Rzcm5q?=
 =?utf-8?B?ak1rY1Y5RVUvUnBxYk01V0xNNWVoRnZqMk05Z2wrS21ZTnJ1enpvclhyUk5F?=
 =?utf-8?B?aStFNVZZR0ppdFErNG8wMHRZYVNZeUdVSysrb0JXeDFkOVhlR3lhakJiUU5j?=
 =?utf-8?B?ZHpWMEVlY3plVldralpVZlRnMXQwY3NUejRVNWZYZENIbmg5OWFkSDI0anBF?=
 =?utf-8?B?WGJaTlFyOFdHbitIMjRuQnpML3c5VHBSK3o2Q2M3c1YxVGxEekJabHQ3TVhp?=
 =?utf-8?B?WEpRRW5iL01YcW12VUZSNUZxSkpJVkQzVEtCZnUyNk5nWThoWkx4S29vdCtX?=
 =?utf-8?B?Q0ZhMnIrMm1MT0pvY2VKZGJxSGRkRVZYQjI0SW41Q1FUTk9Nd3djNDFrR29Q?=
 =?utf-8?Q?Ne0y5DzAQ4SBBr3J0V9DMiiMhPkQJgnf8Am2X?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1981016391B0B040BADBEE99FA7AE6B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4451721-c13f-4e55-1b61-08da23ae393e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 15:47:21.7724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4+LlfEUTa0SGGav+4Nx13CzfeJVwcbEQrzm6eOcy+YWccRQHxbZ5UiHm2d/ug5KjIikBwlym14kNHJ4fdkId9yE0qroqHV2J4G802Iz1Kq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA0LTIxIGF0IDE4OjU3ICsxMDAwLCBOaWNob2xhcyBQaWdnaW4gd3JvdGU6
DQo+IFRob3NlIHdlcmUgKEFGQUlLUykgYWxsIGluIGFyY2ggY29kZSB0aG91Z2guIFRoZSBwYXRj
aCB3YXMgdGhlDQo+IGZ1bmRhbWVudGFsIGlzc3VlIGZvciB4ODYgYmVjYXVzZSBpdCBoYWQgYnVn
cy4NCg0KVGhpcyB3YXNuJ3Qgcm9vdCBjYXVzZWQgdG8gYXJjaCBjb2RlOg0KIkJVRzogQmFkIHBh
Z2Ugc3RhdGUgaW4gcHJvY2VzcyBzeXN0ZW1kLXVkZXZkIg0KDQpodHRwczovL2xvcmUua2VybmVs
Lm9yZy9hbGwvMTQ0NDQxMDMtZDUxYi0wZmIzLWVlNjMtYzNmMTgyZjBiNTQ2QG1vbGdlbi5tcGcu
ZGUvDQoNCkluIGZhY3QgaXQgd2Fzbid0IHJvb3QgY2F1c2VkIGF0IGFsbC4gQnV0IG9uIHRoZSBz
dXJmYWNlIGl0IHNlZW1lZCBsaWtlDQppdCBkaWRuJ3QgaGF2ZSB0byBkbyB3aXRoIHZpcnR1YWwg
cGFnZSBzaXplIGFzc3VtcHRpb25zLiBJIHdvbmRlciBpZiBpdA0KbWlnaHQgaGF2ZSB0byBkbyB3
aXRoIHRoZSB2bWFsbG9jIGh1Z2UgcGFnZXMgdXNpbmcgY29tcG91bmQgcGFnZXMsIHRoZW4NCnNv
bWUgY2FsbGVyIGRvaW5nIHZtYWxsb2NfdG9fcGFnZSgpIGFuZCBnZXR0aW5nIHN1cnByaXNlZCB3
aXRoIHdoYXQNCnRoZXkgY291bGQgZ2V0IGF3YXkgd2l0aCBpbiB0aGUgc3RydWN0IHBhZ2UuIEJ1
dCwgcmVnYXJkbGVzcyB0aGVyZSB3YXMNCmFuIGFzc3VtcHRpb24sIG5vdCBwcm92ZW4sIHRoYXQg
dGhlcmUgd2FzIHNvbWUgbHVya2luZyBjcm9zcy1hcmNoIGlzc3VlDQp0aGF0IGNvdWxkIHNob3cg
dXAgZm9yIGFueSB2bWFsbG9jIGh1Z2UgcGFnZSB1c2VyLg0KDQpUaGVyZSBpcyBhbm90aGVyIGdv
b2QgcmVhc29uIHRvIG9wdC1pbiB0byB0aGUgY3VycmVudCB2bWFsbG9jIGh1Z2UgcGFnZQ0Kc2l6
ZSBpbXBsZW1lbnRhdGlvbiAtIHZtYWxsb2Mgd2lsbCByb3VuZCB1cCB0byBodWdlIHBhZ2Ugc2l6
ZSBvbmNlIHRoZQ0Kc2l6ZSBleGNlZWRzIHRoZSBodWdlIHBhZ2Ugc2l6ZS4gT25seSB0aGUgY2Fs
bGVycyBjYW4ga25vdyBpZiB0aGUNCmFsbG9jYXRpb24gaXMgd29ydGggdXNpbmcgZXh0cmEgbWVt
b3J5IGZvci4NCg==
