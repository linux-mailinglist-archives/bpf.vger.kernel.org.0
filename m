Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74A52ABC5
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 21:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235409AbiEQTQr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 15:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiEQTQq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 15:16:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4582B1AA;
        Tue, 17 May 2022 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652815005; x=1684351005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=h79zf+e+LMNmFPPdaNKfGUAZ8dyXH17xeHE52aT59x8=;
  b=XqJ5DbXflpmbkT7F3dIPjFAdME12oYF9UfkDw17Qjbph7EP/GYseq2rZ
   0VjqcOvGi1Llb1ZoK/+D+7jEYMbl4D7Vk5y6Rdm6cR4ACdNYzXuHkb5fX
   S3m7VpAynydiAfdA06Sq0qZ01r4K7w0NlsbeaeU4DF41PqPuBm2J3IpOT
   BoncL8f3lhuxNUHl+FOpv7m8dlPgieGpQ31xlEXeP6p80JMxKo/LsAV4y
   X7dMPw0JvEC5NLjMZhholmkPi7jEavXxOVc0umpJMi8iJNMhjMUCh2STU
   P0hfSQMGBUtiGgth6xlvHp5SAzHgD2RK08Ui+bvAOkuvrBi+izfb64vWq
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271421240"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="271421240"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 12:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="597304568"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2022 12:16:44 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 12:16:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 12:16:43 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 12:16:43 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 12:16:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYmfdffVTK9NjhFYLsdgjANtzrSoS61rZHGT//gh6nucmdecJwxYuZRaaRKrMqRXGi4bMhC8S5+usBaQsp+flDkG/xmDtTVwwxoAQJtC2IbURu8/PRI4Ls2M33ume+maWs93Yyl2ElruhdUb5I1szOpXtjV85hMAlUPXqRM+H9gdLVlWDnYSppw7GVA2yh/atxy/7ATaF048bDlf9sBFDUY5PVHvZsSoMQ/9OSCoZP9OKy+na9rPjs6xYR67LsczYMEjQs/4eGbnnqQXup6tciBbDN5APXgwtr6e+QlawGCmLWkk4h+kMQLdjWXSu0R/XDyD0hD7Bc47gKFOnhaghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h79zf+e+LMNmFPPdaNKfGUAZ8dyXH17xeHE52aT59x8=;
 b=aJQoc6gFBeQCyBucb/A9ELas5iCh6vyOHOeY1mKrxdBd/V1fkEs4iwTEGixsQZzfZlisQzfMUV+s551leWeVzmLFyWbHU2zzQYtw1d8fC6sFtL1y7B1pKVKXn3kzXrrJ2JdGEjOBSi+5M8z6J47ZR3flgXGjDDwjJPEFB5csAkei7HIRRE9ZfPXNIZvuP8JPESw+vKLdw0kCDNj2NvORJmBVIiyCmwpmt/PNDI3Jm1CB+TlQxXVsAuAlE6inbvXSPc/TENu7btv0ErKgT+X06r1m2EQZMBhPTv9s0FptVrEWHiM13Cx004LlwNfz2PfW/jJQlW8OPDhSvJPtu8tvYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (10.169.234.14) by
 MN2PR11MB4550.namprd11.prod.outlook.com (20.180.245.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13; Tue, 17 May 2022 19:16:41 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5250.018; Tue, 17 May
 2022 19:16:41 +0000
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
Subject: Re: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Topic: [PATCH bpf-next 2/5] x86/alternative: introduce text_poke_set
Thread-Index: AQHYaOeec1hA593+wEu9fkGa5lEroa0jc3YA
Date:   Tue, 17 May 2022 19:16:41 +0000
Message-ID: <e681c4083fc53cedded845301e8df7a4910d1075.camel@intel.com>
References: <20220516054051.114490-1-song@kernel.org>
         <20220516054051.114490-3-song@kernel.org>
In-Reply-To: <20220516054051.114490-3-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a40bfe61-c39a-41b8-e889-08da3839c62d
x-ms-traffictypediagnostic: MN2PR11MB4550:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB4550829EF6000382ED156AACC9CE9@MN2PR11MB4550.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YqqBBu2IgF6bCEbojNr7PoniWasb+7iCdW5t1FLofl6GvE4mFAFMN8tnXf4KUXrc+yNKIfpLK+6dgDYWRVNOsezRgUiaSi5skEPRPwjTlILQMLYW4m6h5af3BpMvexeIEmHwx3cHsZUJ+d8UZq9E9bIwmhEZwsfLWS5yOa4d8vZJ1znofnPGXb4Hz2gcjgxS1ipNJwfmq8pLxuGpDERft/+iI9+PDsX8i0sorLdPlZkCOqJj0OeIuKhPOTEWDaEUPg6PeKCth4D8eBqz6DFK5zCWMdNKhhXQpMjjmiIDfl1qCHPkPRwr9Ug368jrkJJuNkFQGjcryePzrMPPazaF394IKV2WTYi3JoopxNzTmjO/0q7wLEZLcKfR4nbrUHF6xOVPJdr9cafuA29JRf4UcSCStJi7r4uGCDI7Mp6IrtKmtdZe4OjTe2vjs+JnyM7YxfIOE0V3NF0slkzUR6qnoA23p6Zxziy3f6OfeNJxiunS5mt0UlMxoZSCTvGDKu5mqPu4di7nrANdtAwG62jsSMwPSPqvFwVNVFVT6iYQQBnLD89FqXAjlNI0Pvkd9ftt/AvKBMQRJARR2h/Xzk3qvflgWNYtvwQgkSR9JI3/qnIxRV3/TT2QALG361ZrJiaLulFwbDPMYXuZ0931odtE/VSrE6zkegHJh43mTEJd6rA4FWsoV88iytpt1Q3HDOID/a7P/mIlLlC1DO9AN2H5cR19ts5hNG1UpaERzfhou0A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(36756003)(6486002)(558084003)(316002)(6512007)(2616005)(6506007)(2906002)(66446008)(8676002)(71200400001)(508600001)(8936002)(91956017)(26005)(66946007)(64756008)(66476007)(76116006)(86362001)(4326008)(66556008)(82960400001)(186003)(54906003)(110136005)(5660300002)(38100700002)(38070700005)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WnNld285c3IxWjB2YndlRlBBRExSNngrcWtCL2ZxMzV0NXd2VXVqZkg3Y1Ix?=
 =?utf-8?B?N3ovTWxNNVJ5WW90VDF2NklXcEg3NDFaVEhVTVY5YnVYc1lLd2Z5TXR4V3RL?=
 =?utf-8?B?bHNPY0hMZ0Y5Ry9Gb1h0eUxuS1VJd0ZrcWJiWHUzRFI0cFNMaXU0bFEyN3Vo?=
 =?utf-8?B?ZFc3ODJmVHJEYzhKa1p6UHNQTWk1TElUQTdUV013K3FhSGhpWiswaWJjNWJl?=
 =?utf-8?B?bDdueXg4M1drVVBwdytpd21iSmt6V2laQUJVcDZHS2lsbk43VktJUFRXdkxY?=
 =?utf-8?B?OXd1djkxL3ZSWGhycEFTVTR4azFacVI0RmtPL1J6Qkg0TnNPa005TmNWN1dk?=
 =?utf-8?B?QmNVbVQ3ZWlyOGo4K2c3aXBYRHc5TGlpVFVSbG8wZzA2Y3EyZTNycWp6ZkxV?=
 =?utf-8?B?azJudEdtdlVtcWJRSmVSMEdLeHJVUHBLWUNlTU01RzRFK2lSOTdtSlBWeXpu?=
 =?utf-8?B?cmxXOTNTYUdpY1FMbStvUlNFalIvUDJxUlVCMDZFNHM5b2VrM2R6d3hSV2pK?=
 =?utf-8?B?M3c3L0ZLUmcxY1hiS0V5QWxmc3k1TFc2T1JLSUM3MWc5QjMzVTF4Qis0SkNO?=
 =?utf-8?B?cmljWVdOUDdOOHQrWHU3V1NXOSsvR2dSSE9Sb3FqbGVhQ2ZYYkNkVDNxN1F0?=
 =?utf-8?B?M0Z5Rm4yaXltWUJyek1ONGpsWEkzZ3JpNXdoc1FNdXhmdVFOcmR4b0xpcU9V?=
 =?utf-8?B?eGRCRXl0bXRXQzFpM00vTkpsOXJwUC9TRkpLZXkyL24zOWREcjJxNUdzR2tr?=
 =?utf-8?B?Rm9QN3piMkZCU1FFQ1g1cS9udEZreVMxcFhvd2FUNlFVRHZPQzBHRDRtcFB6?=
 =?utf-8?B?bGhxMHBsTXlFS1BnaHZaL2UyTldNQ3RvL1dnNmRsOGpnOXE4eElvVEtMaFph?=
 =?utf-8?B?RExCS3RiaEpDUUpUNTYrd1BYS1ZnUDhCR3owcFZ1clBoUHRLcEVjTDBMcVJG?=
 =?utf-8?B?VVJkZGdnR3Q4V1FQdnZqR3NEZ0t6bEdzWDFTY1pDaDZhaVNEWGd2RzdHUHJK?=
 =?utf-8?B?TGlMY2sweW81TUE1QjdHbkZHRGRjejFGbVV3VSt5M3doS0JabS92aUxQMnNP?=
 =?utf-8?B?REhWbVhpVHhlbStmUm4xR0lOSDgxNE5XdEJTTkVaTFhsQU5xK2pxcHoxQ0da?=
 =?utf-8?B?TndoNjQ1Q20ydUNRMFhYWnJIVk41Z1EvR3FEL2hCVGh0VStHbU5NRHgwcFI0?=
 =?utf-8?B?RnRDVkFkNXZOTVVDZms4QzU4QW9hUEpQL25acnBEVnlsaHhBQ1h1R0dGVHFV?=
 =?utf-8?B?RUp1STN5aHlNZGM4aTVlaVgyeEJKaTZic1FzSU1KR09UTzBRNkdBcG5VN09L?=
 =?utf-8?B?NWRoNnZSVnZoVFJrRmdUM2NqK1JZM2ZjWlByZERiWkVxSHg4aDk0VEwxd0ND?=
 =?utf-8?B?SjlaRXJhYkQyUzR1M2NnaDYrYlNySFpFWko3VXhudW5vZjlHT05VZWFPR1pY?=
 =?utf-8?B?ZFZERGl2cXQwYThyb001eWZYaUxONFEzL1lXTGJ1ZFA2SU1vTmhQdSs0K1li?=
 =?utf-8?B?TkwwNCtxa0NDd2Rwc3ljVFBMV1JZS1h6bE5MMWxWbWRDVEZXNHpJd3lMOHVa?=
 =?utf-8?B?ZUI0NXdRZXZHSXY1WDlLdElsMGt2aEQxcTV0M2t6SVV4UTI0ZUtmOVRJcFFH?=
 =?utf-8?B?U0c4MzN5ZlhMcFJzOVhMdk1BWHovUm5WR0pwbUNvV2psK0NMUmxDRHFtdzZw?=
 =?utf-8?B?YTJoRTAwY0ZpMDV0LzM2QnkxTjhFeno1V2V3Vlp2VVB4SmtZakZqdi84RXhh?=
 =?utf-8?B?WUhmU3lBTWdJZ0twVWRrMzUvaEFLRi9saEZ1TWZxUmtrcEZMMEJlNkk3OXRm?=
 =?utf-8?B?bDVFUW54L1lSTjgreGJyeHVIUHdEWS9oVkE3UFIrRHdiZ21vTUVPeTdndHBX?=
 =?utf-8?B?ZUt1SGZTR1hzbS9WN080Y1dST3VNM3dQU1RiREZwU2U5NlNVL3djbFArU0FH?=
 =?utf-8?B?MzVNSG10SVh2S1NhNC96Z3EvZWN6VVpMOHhZenZOZEQ2MzlwQ1YvNlp1UDFz?=
 =?utf-8?B?UStwZ2lLdVNqWmJZaXVsWXhPd29VbE8vR213MmMxdzNURVluUnE1T1FxZTMw?=
 =?utf-8?B?akw2M3o1NEhaTlFOOXpvejVBeXhld2d1SXFxaTBKT29GUEp5cHhvaEk5VERQ?=
 =?utf-8?B?NmpWWWE1dWREMnpGd3FxK1hVSENNOFFiNnBmcStGT0RBQ2Z1Q1dsRy85RVd5?=
 =?utf-8?B?SGE1ZjNPeXZoc0dOZS9iUXIyQi9WUXNtZnBZaVpBTlNOMlMxNlZGRFJnYUJ0?=
 =?utf-8?B?L3NicGJkVVExLy9JWjk2WnNWV1VJVlJWMmRIdXMzQ2Q1QXlVK0h2WDJZT3cv?=
 =?utf-8?B?VWpqeWgyMk1xOGFCNGJRcUV3aHFRR1ZIbm1FL3l2dk9CbW5YbzdDVkJKZTlO?=
 =?utf-8?Q?ip2y6XlFSX3NmQDUAdokv240BM/Fnn4ats0ba?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <209B976F45992143A2D782C496879479@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a40bfe61-c39a-41b8-e889-08da3839c62d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 19:16:41.5066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GMMPOfEagA4wkBK1cJv12tv0Sk+Sx+QAA390dovK150mM9SDB9tF6rzeHEhRe2CgSZFAT0z0hLfvwzTJL5X5+GQE6+y9k/oIzPDUbj5oh/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4550
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU3VuLCAyMDIyLTA1LTE1IGF0IDIyOjQwIC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gK3N0
YXRpYyB2b2lkIHRleHRfcG9rZV9tZW1zZXQodm9pZCAqZHN0LCBjb25zdCB2b2lkICpzcmMsIHNp
emVfdCBsZW4pDQo+ICt7DQo+ICsgICAgICAgaW50IGMgPSAqKGludCAqKXNyYzsNCg0KSXQgY2Fz
dHMgYXdheSB0aGUgY29uc3QgdW5uZWNlc3NhcmlseS4gSXQgY291bGQgYmUgKihjb25zdCBpbnQg
KilzcmMuDQoNCj4gKw0KPiArICAgICAgIG1lbXNldChkc3QsIGMsIGxlbik7DQo+ICt9DQo+ICsN
Cg==
