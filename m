Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611C62CC9D
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 22:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbiKPVWN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 16:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiKPVWL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 16:22:11 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A361B9D
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 13:22:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668633730; x=1700169730;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CkfGoZNaPbQSOyROveRqpAK2nnzDjyWFpZzB9321Ywc=;
  b=VgWk8iSBPu+2H5AI5R24yY98uLuCFQddER2ZT4TsoBuGa6KZmY+ynHU/
   PZ7WamAT4fkCw7aZIXoRxt6TuFQbFFMAmxsgDQ7qFD3x8BUyfFj795hXm
   Aek490tLIXRecLZjQqozbN8r3BfJzc8Lj8bicWw2bJmNd1i2Ic485acIs
   +OHFtLKWLIObJ6ildHo7bZb+jkcumgh/oSKdbVUH/pmyPY0Pi/aS09IXt
   BTivYPYD60zJbr+HHMkJpeVrHryXcbWUk99fW9xfmWqbUV5j6RnvY5WGD
   uptgmO7c+eMH0WWHMUUvnRNzllNg8nUAuIc5Of+M9RhCLVFafPlcpaLYo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="313822424"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="313822424"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2022 13:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10533"; a="884571200"
X-IronPort-AV: E=Sophos;i="5.96,169,1665471600"; 
   d="scan'208";a="884571200"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2022 13:22:09 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:22:09 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 13:22:09 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 16 Nov 2022 13:22:09 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 16 Nov 2022 13:22:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NhS3s15CfB/jo7O4tD5lAZ2VSUqV4o2sLf4aSVvtr7gX84AGnOsZTXn4mat8lxQsmyDm5l2DUhhfzPTFBB+fmPjXPzWo3nR0YUfLBGozV+BM1EEhajD3YAgbaz7Fq26LVBGSxlwsPs3AVh5ff5bOBRggwxfK11sFTGy0+wvkLGAG9oitoYkeZlhs2rH9AXQocI3Ai/2RPjLrH+PCW2hEBOvQa5tXwjFBatD5bocl2m2yiXdpItBVHz9zofeHUrhvo9CcPWsUD/UMKC/4kqclC0DLxsoLGVpLM/u0JAbRVsnAV2fwTaFGa3O4vIL8n/AqBhSQPLsslSUKxNA0tiJ4zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkfGoZNaPbQSOyROveRqpAK2nnzDjyWFpZzB9321Ywc=;
 b=EhLRprpc9ocoZNq/1Nn5C13gAl44ZAu4GmbhHF7CpgR3rJUjQM2MzoQJX9yozaQRXz+ZuC04mDj86EfZXKcbI/L66vKAYwOxboAZdmIBrvK7P4RjUd1O1NIGpnvg3yMPh0rX0wTCbNz6CK0OkBnyoDPgcnZ4vVkeZJ/mNCCWq9HNmexXL5sFdIdnCmzvvBYLJ9JhEhN2t5uLQK6IoN9IYNhEql7o6BxQGEqxlMaGULmbJYrvAC3way5a1GRtHLwz8er40lzM2l2QpQ4o4qBavPP3sSFEGu1M8g58Ih76j3pp+kImRYalqpKHS96G5IRh/vjGJe+8y0KuT6v0XoisRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN7PR11MB6945.namprd11.prod.outlook.com (2603:10b6:806:2a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.18; Wed, 16 Nov
 2022 21:22:06 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::add7:df23:7f86:ecf3%5]) with mapi id 15.20.5813.018; Wed, 16 Nov 2022
 21:22:06 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "song@kernel.org" <song@kernel.org>
CC:     "peterz@infradead.org" <peterz@infradead.org>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "Lu, Aaron" <aaron.lu@intel.com>
Subject: Re: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Topic: [PATCH bpf-next v2 0/5] execmem_alloc for BPF programs
Thread-Index: AQHY8vohJKeDurB03UipOT/gu9SMC64/PciAgAENRoCAAEi7AIAABXmAgAA0IICAAU+eAA==
Date:   Wed, 16 Nov 2022 21:22:06 +0000
Message-ID: <a69ceba66135b0713c29a49fe84751274fefd722.camel@intel.com>
References: <20221107223921.3451913-1-song@kernel.org>
         <CAPhsuW5pq+hzS87Rb3pyoD3z8WH+R7EOAGkTkh-KwEKt9HV_mA@mail.gmail.com>
         <c7e9bbf45b2d52253fec16525645bda0887a9cf9.camel@intel.com>
         <CAPhsuW7H95hUUCGEk9etwTT8kYRCKCtD6Lo+8WxHUyGTKSyEFA@mail.gmail.com>
         <4bf1a1377ea39f287a4fd438d81f314d261f7d7f.camel@intel.com>
         <CAPhsuW60U0n-szdD9AO214zk5GHscZ6jnxBoh7_HBcfYw6fdSQ@mail.gmail.com>
In-Reply-To: <CAPhsuW60U0n-szdD9AO214zk5GHscZ6jnxBoh7_HBcfYw6fdSQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|SN7PR11MB6945:EE_
x-ms-office365-filtering-correlation-id: 123835ed-f382-4a50-3dc7-08dac8189d33
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mZxUB5LGE1hi8ORmTqoVcEu04XS6oL9UTNribXSEdox28BY71SsT3c9XHg0X/76hC6282TcmBAW0sEum6yvFKW8q7L4TFfdfI3J3toN+SjjFEMLqmNA7rctwPZryiWJQBPVjebmX7kREagl/olNtMUyapSQAKo0vhjA6z3g9p1u+cGiXn3rbYFaDYlrZJiUTi/JQvhhqoliWEIZztV7O9brd8RtRW3QpVJ/aslHos1qW39WHTIaHiOqFUtvhT8PX9dxyh0SAygGAfgS9EsLsBaCqy0Rhcd0Urcoj/mi2abFRfhml0vGVyPdfmwuRaAzT7GXhA5zXzLRCMEFyUyhj/gz6gysQh/1dEMspoDQXBEIzRGq8OCClkf/HWr6II0LV9OeriWoJVt90dbwEITGbmiWwFfrz69i7YINdmJRXKyepJtV+VdOGK8WFsQW4kLwS0N0LarlHsiQpDiD4eLFXqCjuk2Uq0jetbcH2gKMQ7AvkJxU5dKFx5Ynly5cydkHVEDgi3VPx1SttbWsvB0Ee3LzT1cL0FyA2DHl7VLawfZpI81iiY7FC5tzI658QCCLvqIr2ANmgtxgKI0zdWJZ6i6m3gKhFEZ1g8Tzz1WWyToM2n48JmkgbNp775U34CvupmlKprm4filGLGA5G9v90KmSGf2VfENc3edUohy0cgkBBftc4lMHjr7lBsLOpmTCB6bMTvVAN6p9gkYmzJyTHcGuVxlN4Rs+OsmD55dpM5ylmsqwlmR93RIQwLcdTqUVc5EUapHzTOb65IyWcroCW12qJ+buM0Dh6UrrdDVXECM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(8676002)(4326008)(76116006)(91956017)(66476007)(64756008)(66946007)(66556008)(66446008)(5660300002)(8936002)(6512007)(26005)(122000001)(41300700001)(6506007)(71200400001)(36756003)(6486002)(478600001)(54906003)(4001150100001)(2906002)(38070700005)(86362001)(38100700002)(316002)(6916009)(186003)(82960400001)(107886003)(2616005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2JrdStIQjkvcHZab1M4RTNvZGNKRlg2WHlPZXczblI4a3ppaldXKzhGYmQv?=
 =?utf-8?B?eERiQ1prSlNmLzNRcTJVc0tGaEg0bjdsT25sL3FXeGZKamxGTWUwaXdhMUc5?=
 =?utf-8?B?QXd4SkhkWTZxZ0kvcHVqZ1dIU0Mrck1wRGlmZVNOeDI3V1R2eUJlaTNid3NU?=
 =?utf-8?B?Nzd6VVY3MStzQWg0YXNzZW8vakdhV3hYQXFxOUlKcm1jWnZ5K0QvUm9DOEV6?=
 =?utf-8?B?NUppN1lRWGRzaFRjVzdzR2h3S0lhV2o4K0xaZjdWNXl6aFlTbnkyYlRKckxk?=
 =?utf-8?B?YTc4YytRUVRYZzVWVXdtZlM4eVZuWFRURkgxT0EyZjJFaGFJNEpYMThtc2pr?=
 =?utf-8?B?T2JHMXU3TC82M1NML25TLzBtUEpsVC9COVBUeEwyM1p0Zmd3SEZLZmJVVEJE?=
 =?utf-8?B?QVdlaUxscFJqT2c0aUZtMjFNYm1CUzhvMDJsaXJPenRhK0dRTzZ5QjZxVXB1?=
 =?utf-8?B?aGJta01MTzRjT1l1eUhvRE56SlAzaFBhQUVZTUhhWUQxYWY0ZEdLNEVPUHNs?=
 =?utf-8?B?MmlrU0VZL1BQSlNmc2xWOGNjVDQ4MHdEL0ZEcHdpM3FMRFVyU01RVEpwNThj?=
 =?utf-8?B?VzJrR0JRTU1yRFpTN1FPZkQ3aHB3dGEzdzZLZkpySGM5NWdNMnFkRVgwYU56?=
 =?utf-8?B?TW13MTY5ZTlEN01kNFN5aTQ3Q2dqdGJ2YloreXJBR3IwS3paandzemFsYU5Z?=
 =?utf-8?B?NERSM04xUVJxb3A0dGdUNEZva2ZuZ3d6V0Zuc1R5eFF3MkV3MDVyc0pnUTYw?=
 =?utf-8?B?V251dEtZMEdoQytwT0NnRlJsSG4rTGZzL3ZnaXFHT2NrYnFTdmg0djE3YUxF?=
 =?utf-8?B?cnc1T2dHc2tBbkF0OTZyMm02V3MvUWdWZW84SE55VHg2Z09rQktiT3RPQ2ZI?=
 =?utf-8?B?TlBESGdGOVJSMStJc0I2dXZHV0daYzJjSzd4Z21BT2xVWU5rNWQyTlpjYUFO?=
 =?utf-8?B?c3dCT2p0RXFsTllxbXd3VDlGV0JWMzVXdEZ0Qm8wVmlOTjdlUHdxeUJtb3dJ?=
 =?utf-8?B?dCtOM1RzeXNzeEU4cGI2OGM4RG5pdlE2WUlZQUNwNmNSNDNUbDBNcXcvVDFH?=
 =?utf-8?B?QVdMaW1ialQvZU4wdTdGMVIyQ0UyNHVjR2dYOEpDY2pRQWloL1dGVDVVY0sr?=
 =?utf-8?B?dU1wY1lGc0pyT2JCeGV2WGxwRTVEditmU1k4NXc0cCtBdmpIclNVbEx4d0Fs?=
 =?utf-8?B?WXhHRnRFNkxsaUh6Y0dyZ0FQYWlqdy8yNHF4QXA1dkx6MElTTVB1dTJ4b2FF?=
 =?utf-8?B?TzFseng1bGowWTJhVk4yNXNybTdhUk1aUVppckxxVnhvL0hOWEl4a3VnQjg5?=
 =?utf-8?B?bnhOcmk4TDQ1UmJPalRHZy9rdzVyeTZjUklsc0loSlRycVcrMWtDWVpEMkgx?=
 =?utf-8?B?SlBPOGpSRktlNThSQjN2dkU2OTVkSHBmeXk2eFV0S0ZJMXJNbENaWXNiWC9y?=
 =?utf-8?B?RXNqY3pmd3BySmE3TXQvVTJPYm9FRVdQY2wzWU1EWWdFeTFRVVhjUW4zNHF3?=
 =?utf-8?B?Y3FqaGlyczJlRFpIUklnL1B1L1RvV0VmTG0rK2VuQ0FqaklneWt6WmRNQ0ha?=
 =?utf-8?B?dk1Tb1d0dFkxLzFOMzk5ajY0aUx6ckZZZDNZdTJaZ0N5NlhlZ3J5S0hUTzhu?=
 =?utf-8?B?QWlURUZ0U1FkdGJjdnhsR1JxU3RKd2srZTNaUTB1RXpuRTAvTkl1UEZaMHR4?=
 =?utf-8?B?NmhpbmFaYzBtMlZwSkZhZ3Y0ejJYSWlRc1p6ZW0rSFFhd1dOejZZSlZwTWlF?=
 =?utf-8?B?cStqdTMybkZ6WkRTRmxjM0gxYk80QmhOY2lvRERlSGp4dGtrYU1FaHhHUmpR?=
 =?utf-8?B?VGlERk80aFR4SHZjZDBIMnczVzNoYWU3ZnJtVDRodkZ1MExoRlVGOFBYN2hw?=
 =?utf-8?B?ZlJVS1piZlo3TG14LzJhZFV3ZFdDbVlkZ1ljbTN4UExmQ1Y1UHpJdDlMTVcz?=
 =?utf-8?B?N20vLzlLRlJYQU52TGZKNEp1ZVlTZVFNQW11TFd6QjFsb2xBMjlDaUtCb1Ro?=
 =?utf-8?B?WU5VSGczd0pZeFBNOHE4QXZtL25BblZlR2VTd0ZxVVdlQXBlc0ExNHdTN01F?=
 =?utf-8?B?WWs2dGZxYnFWc3pUb21jb0ZSejl0TGQ0Um50TTNZcWlrbGwyWjdlRDV2eGJJ?=
 =?utf-8?B?WHJKNDhTRStZYWR3S1NIM2g2bFlKUlBaOGhHS0d1QWlLaGRKZm1aenlqUHpm?=
 =?utf-8?Q?V8aqgjUrFjqBa0xqqm7WZQs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <344B10BA02425D4D8D455F27238A9AF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 123835ed-f382-4a50-3dc7-08dac8189d33
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2022 21:22:06.8029
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZLNZ0ApIoZ8HpKMNA5PgZZ4uGkmeITJUkhiVN/jfDBg27MKexiXI0u95a7lky2Hcyt7E1t98x9OOLsi9OCgZCEuyxJCAHd0qQSejC14k8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6945
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTE1IGF0IDE3OjIwIC0wODAwLCBTb25nIExpdSB3cm90ZToNCj4gVG8g
Y2xhcmlmeSwgYXJlIHlvdSBzdWdnZXN0aW5nIHdlIG5lZWQgdGhpcyBsb2dpYyBpbiB0aGlzIHNl
dD8gSQ0KPiB3b3VsZA0KPiByYXRoZXIgd2FpdCB1bnRpbCB3ZSBoYW5kbGUgbW9kdWxlIGNvZGUu
IFRoaXMgaXMgYmVjYXVzZSBCUEYgSklUIHVzZXMNCj4gbW9kdWxlX2FsbG9jKCkgZm9yIGFyY2hz
IG90aGVyIHRoYW4geDg2XzY0LiBTbyB0aGUgZmFsbCBiYWNrIG9mDQo+IGV4ZWNtZW1fYWxsb2Mo
KSBmb3IgdGhlc2UgYXJjaHMgd291bGQgYmUgbW9kdWxlX2FsbG9jKCkgb3INCj4gc29tZXRoaW5n
IHNpbWlsYXIuIEkgdGhpbmsgaXQgaXMgcmVhbGx5IHdlaXJkIHRvIGRvIHNvbWV0aGluZyBsaWtl
DQo+IA0KPiB2b2lkICpleGVjbWVtX2FsbG9jKHNpemVfdCBzaXplKQ0KPiB7DQo+ICNpZmRlZiBD
T05GSUdfU1VQUE9SVF9FWEVDTUVNX0FMTE9DDQo+ICAgICAuLi4NCj4gI2Vsc2UNCj4gICAgIHJl
dHVybiBtb2R1bGVfYWxsb2Moc2l6ZSk7DQo+ICNlbmRpZg0KPiB9DQo+IA0KPiBXRFlUPw0KDQpI
bW0sIHRoYXQgaXMgYSBnb29kIHBvaW50LiBJdCBsb29rcyBsaWtlIGl0J3MgcGx1Z2dlZCBpbiBi
YWNrd2FyZHMuDQoNClNldmVyYWwgcGVvcGxlIGluIHRoZSBwYXN0IGhhdmUgZXhwcmVzc2VkIHRo
YXQgYWxsIHRoZSB0ZXh0IHVzZXJzDQpjYWxsaW5nIGludG8gKm1vZHVsZSpfYWxsb2MoKSBhbHNv
IGlzIGEgbGl0dGxlIHdyb25nLiBTbyBJIHRoaW5rIGluDQpzb21lIGZpbmlzaGVkIGZ1dHVyZSwg
ZWFjaCBhcmNoaXRlY3R1cmUgd291bGQgaGF2ZSBhbiBleGVjbWVtX2FsbG9jKCkNCmFyY2ggYnJl
YWtvdXQgb2Ygc29tZSBzb3J0IHRoYXQgbW9kdWxlcyBjb3VsZCB1c2UgaW5zdGVhZCBvZiBpdCdz
DQptb2R1bGVfYWxsb2MoKSBsb2dpYy4gU28gYmFzaWNhbGx5IGFsbCB0aGUgbW9kdWxlX2FsbG9j
KCkgYXJjaA0Kc3BlY2lmaWNzIGRldGFpbHMgb2YgbG9jYXRpb24gYW5kIFBBR0VfRk9PIHdvdWxk
IG1vdmUgdG8gZXhlY21lbS4NCg0KSSBndWVzcyB0aGUgcXVlc3Rpb24gaXMgaG93IHRvIGdldCB0
aGVyZS4gQ2FsbGluZyBpbnRvIG1vZHVsZV9hbGxvYygpDQpkb2VzIHRoZSBqb2IgYnV0IGxvb2tz
IHdyb25nLiBUaGVyZSBhcmUgYSBsb3Qgb2YgbW9kdWxlX2FsbG9jKClzLCBidXQNCndoYXQgYWJv
dXQgaW1wbGVtZW50aW5nIGFuIGV4ZWNtZW1fYWxsb2MoKSBmb3IgZWFjaCBicGYgaml0DQphcmNo
aXRlY3R1cmUgdGhhdCBkb2Vzbid0IG1hdGNoIHRoZSBleGlzdGluZyBkZWZhdWx0IHZlcnNpb24u
IEl0DQpzaG91bGRuJ3QgYmUgdG9vIG11Y2ggY29kZS4gSSB0aGluayBzb21lIG9mIHRoZW0gd2ls
bCB3b3JrIHdpdGgganVzdA0KdGhlICBFWEVDX01FTV9TVEFSVC9FTkQgaGV1cmlzdGljIGFuZCB3
b250IG5lZWQgYSBicmVha291dC4NCg0KQnV0IGlmIHRoaXMgdGhpbmcganVzdCB3b3JrcyBmb3Ig
eDg2IEJQRiBKSVRzLCBJJ20gbm90IHN1cmUgd2UgY2FuIHNheQ0Kd2UgaGF2ZSB1bmlmaWVkIGFu
eXRoaW5nLi4uDQoNCg==
