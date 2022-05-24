Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4C532FDA
	for <lists+bpf@lfdr.de>; Tue, 24 May 2022 19:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240059AbiEXRt0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 May 2022 13:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiEXRtZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 24 May 2022 13:49:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 558EC5D5E8;
        Tue, 24 May 2022 10:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653414564; x=1684950564;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q674w6JxtemiQ8S58ovlDtp9GWkS91tPrlVog4eh4Tg=;
  b=TNiOax2dApJNc3aBUPYuCSV1nJfPd7oG5gq3uHN9fcUMViaR1CW3HlMq
   WoeXgdPtWHwzh6JN5wGvPIJ8D4ns5gVFB7QJ0/DEA0HUlr4elOi7JN0W3
   dxtdJbsuc2+1QJLMLkJWTJxB1C25KVlJLOaOtyAGj+7eTMXLzOMfFjZak
   hy233+IQGOFmz9EOVeT7A8ChvMk+SNyBf//tbd44Z5nDDaDMoSz5KCKkp
   /bftAt43+RmFfgg54/GoOb4DUo9iOr13Vv/zt59DNYffCJS+x2GCuew1S
   fXDmNfZtIc+4WHHas7siAQJu3KG4ktonk0bqAIOyfKtAUDPeIYjZSVXo1
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336663733"
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="336663733"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 10:40:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,248,1647327600"; 
   d="scan'208";a="577994024"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2022 10:40:57 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 24 May 2022 10:40:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 24 May 2022 10:40:56 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 24 May 2022 10:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K4ij0ZbYqoU4l59ZcbslCoNfctjd3Lyo7pUuzFujshYBW+W+UktcDb3FZdouIZrm6PAIK9SYzND6p7wEU3i7s5FmRjn46WR6WlApBdjC0z1FEbkTweXZ3Th/QrnkzatuS1VeRoNcR8k5D+ltFsY7e0q18BG7RHgUt1iCbRsnDUmQFWVCmlxsOmDehhnZE468uF0ZAXKeNzgCEezORu0TtuUxkF33q2URVmHfdjxEx/l+PUmtKCbOTCO2TyedhnvXc6UFzcyv0pXLp3g/QPnevU3zlAii2HfjcR+Prduj0KlduQGHKy4EBTyJWbwSCAYf4KFpRjuZcaSToOWH80Seqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q674w6JxtemiQ8S58ovlDtp9GWkS91tPrlVog4eh4Tg=;
 b=TGsC/MeuLRtKaLOPPYRLSIigi5ENToJX+mYeWdVbfuMfaZfsqHyQ03ZryqnHb5G63TTXCEV12aSS98b6wMaDgJl7s9HZJxIEo5aHIczlOksnUM1IRg12mjmrCZ78KCnJ9wjdtaVPmlX6bCGqGDfgG9m1zu6raE72wJIHOD2HOVp3z+Z/RSiny95cJLLjBAXZgeSd6A9nNOAbNf++J+EKxDrmj3Cj6DTIuALvONncbyCVb3vDXRSXqZ6Z8rcaN9wsH1EQbGHIaxLV8gDdmJSifVsfeDytYi9mbwqATVh7XKKnKOguSSzeFz3PR4fXbMa9JWhizVHU9MDJP/cCNusugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by BY5PR11MB4053.namprd11.prod.outlook.com (2603:10b6:a03:183::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.16; Tue, 24 May
 2022 17:40:53 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::34f6:8e1d:ac6b:6e03%12]) with mapi id 15.20.5273.023; Tue, 24 May
 2022 17:40:53 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hch@lst.de" <hch@lst.de>, "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "arnd@arndb.de" <arnd@arndb.de>
Subject: Re: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Topic: [PATCH v3 bpf-next 5/8] bpf: use module_alloc_huge for
 bpf_prog_pack
Thread-Index: AQHYa/hbBI/pmQED80+tJ33DuaIVna0ohISAgAAm+wCAARklgIAEjj4A
Date:   Tue, 24 May 2022 17:40:53 +0000
Message-ID: <a634037bb023973b8263a65b93fa73a7a5c0dc52.camel@intel.com>
References: <20220520031548.338934-1-song@kernel.org>
         <20220520031548.338934-6-song@kernel.org>
         <Yog5yXqAQZAmpgCD@bombadil.infradead.org>
         <17c6110273d59e3fdeea3338abefac03951ff404.camel@intel.com>
         <YolGU5JGE9NVrrrc@bombadil.infradead.org>
In-Reply-To: <YolGU5JGE9NVrrrc@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18409028-23b1-4037-515f-08da3dac8cc3
x-ms-traffictypediagnostic: BY5PR11MB4053:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BY5PR11MB4053BD5BA3E6D6FB4957324CC9D79@BY5PR11MB4053.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2aEMoBAG0K6nY2tfQMFmJp+uhrCS0MDqc8mjZX17/aZ5VP3R7fvp1cZ5JRzYhYjv8veyhiikSTaSq1SW2W9uat3D1BCGOUnTytcfH4vha3qD9cPu2DwgtHF4cW3W+wXyc0O1Kaj+skq8FAK73FH9LiNvPWHufslS/uKHWt5hbvSMQL1N7PHGQDPY4jyEIWlfR8ixbipF9SJvoRIyeaGyjtD3eXAV7udyuBUXA6nRARfIURxIlG0+GaYSVxG1fQJokGvaXQUO70sqNxHd25Y/WtITq2XKLv1HS3SdFVWWKV8ZmU5lh/215nrWqsfhn/4AC8h6qlszpg0SqS/vgdED+ppZebUd09rtTAfQIRS/svUsRJtAQy8kAqXG1ffP9XJQoAAZsD6lgbr6pRyDH0fnH93mq1wMi8mWp3zaC1LPvyeFxDQQs4aVbRN9XwX+PXnoXc2VfE1tmUbU/3W2I6vf31I29tr00/HW4ishis0QyNFU7S9RXW9W2rdjG2WbtLIshwcCRhn3Y72PkgfYU0gEfXxgDSYV3LIpS9LFHifdLJpm3zOWrmcG9WBezyzQXcGJD2lChnNKDhV8l4Q5HuFVORiygcQWlDYs5eCDwO8WMk2DtRk5U8rUkmRHJY+fIpiBtXQJwgzaxUoFVRhcrv9Njrskoy/B0OE9ksj/Oi2FLLAAN7/SN2gvW32ObI8APtVNy2XUK4PQEMfQvlLJR9GZfC8kCvR0lCCW6frlCRJhqeLktcx+Tqdfhrl4m045wNl9X7xfxIlc8z+XP5mPX/nzI4T6lpQbqG1MBMrKHrlA+Yc3acY5I7VL+UkHxzkgEjmE0gexV58GCZSVyqrAjHDmpd4NyY2E/CdBWv6zl9QAsF+9m0XszqbbkGZncgyeen1H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2616005)(316002)(508600001)(4326008)(54906003)(83380400001)(6512007)(86362001)(66476007)(26005)(186003)(110136005)(38070700005)(6506007)(64756008)(66556008)(6486002)(38100700002)(8936002)(966005)(8676002)(66446008)(76116006)(66946007)(2906002)(71200400001)(82960400001)(7416002)(5660300002)(122000001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ekdpZ2FyUWo1M3FPRmtDZ2UydWNQR3NhcUFrZ2JCZ3hMeUNicThaQlVFOHpN?=
 =?utf-8?B?cTVzWGRiQ1BpVWlPdVhRWEIrcERyWStJQjdISWxIMFo2RkEwNUloQzRWdlJG?=
 =?utf-8?B?dXp2RUFTVm1pVWlYenR2bmVYT2p4MkdKVTJUSDlpVmRZeXpHYXRqRkNMN1Vq?=
 =?utf-8?B?VWlpMjlQY3gvWUE0d0xIQUJRRWxwQmd0a3hRRUlvZEE4L0o3NXA2THlGKzdv?=
 =?utf-8?B?SjNDVXFzNnZJazlYeldIcFd0RmFCRmpZeFV5ZHJTTE9MWjRoQjg2b0p1bFpr?=
 =?utf-8?B?NDgyU3gvYWZLZDMvS0pvUlE5OS9TNG16ZXIxaTRxNHNYczE2QnR2cndoLzRC?=
 =?utf-8?B?UDlCaUVwZ0ZvL3RhNGRYY1lILzNuUGJJaGZqd21rakxzVUQ2UHBDRExnbTlR?=
 =?utf-8?B?bkNnL1JHUDkydFh0L2htdGZudU9yRU10YnJnSGcrT2NiWE5IazlsMjdRTFhX?=
 =?utf-8?B?dGM0MzNJZFZLb3RnMVBoQTBrSlJTQTVWMlY3d1RTcHJ1SjV0MTg4SWg0cW1P?=
 =?utf-8?B?L1V1RDFnTHVldWRqMENMS21pSXFGanMrcE5MdGlOZlQxT0VoQjRTc2hnWGE4?=
 =?utf-8?B?UjRRZitTU1pRTnBiSzB0Qk51OEZrRS9rcjZiMDdWNnRJZ3J1WlJEY2xPUG9w?=
 =?utf-8?B?L29LSG0wdlg0MDQybks1aWJnYm1HZ25tc1FvUkdtaUJxWFBzRHI2MXRvL2p4?=
 =?utf-8?B?TmlWWWpyc0Y1Z3JjOVMrSlZGeElyTU5FNDc1b0M4TytuYVdlWDJQbEtOdW82?=
 =?utf-8?B?MU1hZGM4V29aRk5Eb0svcUhqcHZBNWh6cUxvSHg1STVxTDc1THNxTUlRN1pa?=
 =?utf-8?B?T0JpOVpsQUI2eWNwTThOSFQweEl3aFRJc3c5d2dDV3ZDd2ZSWnZaK1gwbWov?=
 =?utf-8?B?em5ZNFVGK2lrOURHNVZKN2FaaU03VTRTWnRETWtKUzJXV2Rac1JiQVZCaVFx?=
 =?utf-8?B?VTBVY2FhdGZBMEgyblgxRDcrT21Ed3lhTWkvZ1p0L1F6VUw4NWtsaTZXYzRm?=
 =?utf-8?B?Z0hnekx1OTJjR2RKVFoyZVRxZDE2U1ZXalBxbXl1OC9pNENrT0wrS3Q4bERk?=
 =?utf-8?B?Z1JFcnVVc2hOV2htYlc5cjMxdGRldVNOejZoOUlxSk02eEhjdVJNWTlRMUcr?=
 =?utf-8?B?clREL3d2bDYxa05JcGV1MEJyaHIwOVJJQ2g3REFlVEJZQi9iMS9KVXhQcUwx?=
 =?utf-8?B?dXhVblFRak1nWFRMQkR3bFZva1ZpdkJ1MXp1NlM5QlU3ai9mRGpsQVpXSnBj?=
 =?utf-8?B?RG9nODk1RGpCTks3cmpySlRWbC9XVldUbnRmNnBTVVpKalkzTnlvZDNMQ1kx?=
 =?utf-8?B?bEwrQ0tLSXBqNnZCVlROOCs1b1g2VWJWb1dEcWRMTGlKRCtHRmtVNzlHaWdz?=
 =?utf-8?B?MGROWG9uMnA2Y2drMUlUUnRlUjFsNHBiS3ZUcUpPdjlkNzduSjIwRHdmRlVC?=
 =?utf-8?B?MGZGLzl1dTdxVGd3a1RldU91UDZwdzUzY1VRYm05WDRkRktYV2JxV0pnSkY0?=
 =?utf-8?B?TlB3OXliSXZDejFodkI0TGpSME9JU3RQc3ZwSDFvc2pZOWNNVkZscG9uT1Ev?=
 =?utf-8?B?SXBoNDBNejdjR3NjTmIzMkpGRWRlcEdlbHEzWlZiaWNLbDJrR2JSd1MrVUR0?=
 =?utf-8?B?RmFJcmFyRUZuWEowOU41dXNwdG1uZHdLenNmVVZPTW0rQVVBbVk2cmtMT2RD?=
 =?utf-8?B?eVFIMDE1T3BZTFg3OElHc0RwbUhLcDFHT1VoRnpOMldCcHF0OHhGV3lyc0ox?=
 =?utf-8?B?TzVPemZ2TXZvMCtvZVdCb1FZWVJ4QUx6cEFvSmNqMDE0ellJMCtHWHVGZlBq?=
 =?utf-8?B?WW5wcXVMSnM3OHZ0M2R0ZlNGbGZjc0VDTFBMRzFrL3dERHNYS0g2M1loMitP?=
 =?utf-8?B?czkxMWYyQzlvNjQ2QWVUTnU5SnFHUjZmbG9rSzYra1FDV044NjJ5ZXduNlBm?=
 =?utf-8?B?ZUZuMDNITTdkaGZtTVB6d3lRU29ERWlBSEtwUVB3WEZSRkNlOS8wNlYrQ3ds?=
 =?utf-8?B?WW9qQk51cXQ1b3dpb1EySXkvSW1INXZFUFo5ZzM0QVJKYUtrcmxOcHNsd0lZ?=
 =?utf-8?B?SlNhQXFwcC9vZzcyMFFCenV1cUtEK3dxc2xhTGIyT2dQOXpZdzBabFVXdFJ3?=
 =?utf-8?B?a1lnNE91QkFacFZKU1pxSVRnT2FLUjlSQTA5UW1oSGloZjU3blQvcjlKZjhs?=
 =?utf-8?B?TW0vRTBERVFyTHBHVGxVcTNnQnhyejh2RFVqSXI4WXZ3alZKTUFoT253NlZX?=
 =?utf-8?B?R1dlM3V4V2JHQy9NYmZPamkxaXZXdzJrR3NiK2hEQXVBbEpVZFQ0dHBXR3BD?=
 =?utf-8?B?NEF5azVtSXlmS21mZjZDQU1oSnlELzQrdjZyem5sQk1EVGhJWXgzYng1ZU4v?=
 =?utf-8?Q?CpF7pEIyF0l5qtkbX35JWccO1pH4QPutAmiPs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <52406F5B2FBC0B40AD71000AE9C30134@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18409028-23b1-4037-515f-08da3dac8cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2022 17:40:53.1313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbTjPpHif4dfS5whgwI2e8EYBIiVFhloC4Rvi0gipKbvcDp31AGJCJumRFdc8Uk+FZHfmJTwJteC9WgAow2SG1F3azcHUsOnR66ostyFK9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4053
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gU2F0LCAyMDIyLTA1LTIxIGF0IDEzOjA2IC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiBPbiBTYXQsIE1heSAyMSwgMjAyMiBhdCAwMzoyMDoyOEFNICswMDAwLCBFZGdlY29tYmUs
IFJpY2sgUCB3cm90ZToNCj4gPiBPbiBGcmksIDIwMjItMDUtMjAgYXQgMTg6MDAgLTA3MDAsIEx1
aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+ID4gPiBhbHRob3VnaCBWTV9GTFVTSF9SRVNFVF9QRVJN
UyBpcyByYXRoZXIgbmV3IG15IGNvbmNlcm4gaGVyZSBpcw0KPiA+ID4gd2UncmUNCj4gPiA+IGVz
c2VudGlhbGx5IGVuYWJsaW5nIHNsb3BweSB1c2VycyB0byBncm93IHdpdGhvdXQgYWxzbyBhZGRy
ZXNzaW5nDQo+ID4gPiB3aGF0IGlmIHdlIGhhdmUgdG8gdGFrZSB0aGUgbGVhc2ggYmFjayB0byBz
dXBwb3J0DQo+ID4gPiBWTV9GTFVTSF9SRVNFVF9QRVJNUw0KPiA+ID4gcHJvcGVybHk/IElmIHRo
ZSBoYWNrIHRvIHN1cHBvcnQgdGhpcyBvbiBvdGhlciBhcmNoaXRlY3R1cmVzDQo+ID4gPiBvdGhl
cg0KPiA+ID4gdGhhbg0KPiA+ID4geDg2IGlzIGFzIHNpbXBsZSBhcyB0aGUgb25lIHlvdSBpbiB2
bV9yZW1vdmVfbWFwcGluZ3MoKSB0b2RheToNCj4gPiA+IA0KPiA+ID4gICAgICAgICBpZiAoZmx1
c2hfcmVzZXQgJiYNCj4gPiA+ICFJU19FTkFCTEVEKENPTkZJR19BUkNIX0hBU19TRVRfRElSRUNU
X01BUCkpIHsNCj4gPiA+ICAgICAgICAgICAgICAgICBzZXRfbWVtb3J5X254KGFkZHIsIGFyZWEt
Pm5yX3BhZ2VzKTsNCj4gPiA+ICAgICAgICAgICAgICAgICBzZXRfbWVtb3J5X3J3KGFkZHIsIGFy
ZWEtPm5yX3BhZ2VzKTsNCj4gPiA+ICAgICAgICAgfQ0KPiA+ID4gDQo+ID4gPiB0aGVuIEkgc3Vw
cG9zZSB0aGlzIGlzbid0IGEgYmlnIGRlYWwuIEknbSBqdXN0IGNvbmNlcm5lZCBoZXJlDQo+ID4g
PiB0aGlzDQo+ID4gPiBiZWluZw0KPiA+ID4gYSBzbGlwcGVyeSBzbG9wZSBvZiBzbG9wcGluZXNz
IGxlYWRpbmcgdG8gc29tZXRoaW5nIHdoaWNoIHdlIHdpbGwNCj4gPiA+IHJlZ3JldCBsYXRlci4N
Cj4gPiA+IA0KPiA+ID4gTXkgaW50dXRpb24gdGVsbHMgbWUgdGhpcyBzaG91bGRuJ3QgYmUgYSBi
aWcgaXNzdWUsIGJ1dCBJIGp1c3QNCj4gPiA+IHdhbnQNCj4gPiA+IHRvDQo+ID4gPiBjb25maXJt
Lg0KPiA+IA0KPiA+IFllYSwgSSBjb21tZW50ZWQgdGhlIHNhbWUgY29uY2VybiBvbiB0aGUgbGFz
dCB0aHJlYWQ6DQo+ID4gDQo+ID4gDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzgzYTY5
OTc2Y2I5M2U2OWM1YWQ3YTk1MTFiNWU1N2M0MDJlZWUxOWQuY2FtZWxAaW50ZWwuY29tLw0KPiA+
IA0KPiA+IFNvbmcgc2FpZCBoZSBwbGFucyB0byBtYWtlIGtwcm9iZXMgYW5kIGZ0cmFjZSB3b3Jr
IHdpdGggdGhpcyBuZXcNCj4gPiBhbGxvY2F0b3IuIElmIHRoYXQgaGFwcGVucyBWTV9GTFVTSF9S
RVNFVF9QRVJNUyB3b3VsZCBvbmx5IGhhdmUgb25lDQo+ID4gdXNlciAtIG1vZHVsZXMuIENhcmUg
dG8gY2hpbWUgaW4gd2l0aCB5b3VyIHBsYW5zIGZvciBtb2R1bGVzPw0KPiANCj4gTXkgcGxhbnMg
YXJlIHRvIG5vdCBicmVhayB0aGluZ3MgYW5kIHRvIHNsb3dseSB0aWR5IHRoaW5ncyB1cC4gSWYN
Cj4geW91IHNlZSBsaW51eC1uZXh0LCB0aGluZ3MgYXJlIGF0IGxlYXN0IHN0YXJ0aW5nIHRvIGJl
IHNwbGl0IGluDQo+IG5pY2UgcGllY2VzLiBXaXRoIHRpbWUsIGNsZWFuIHRoYXQgZnVydGhlciBz
byB0byBub3QgYnJlYWsgdGhpbmdzLg0KPiBZb3Ugd2VyZSB0aGUgb25lIHdobyBhZGRlZCBWTV9G
TFVTSF9SRVNFVF9QRVJNUywgd2Fzbid0IHRoYXQgdG8gZGVhbA0KPiB3aXRoIHNlY21lbSBzdHVm
Zj8gU28gd291bGRuJ3QgeW91IGtub3cgYmV0dGVyIHdoYXQgeW91IHJlY29tbWVuZCBmb3INCj4g
aXQ/DQoNCkl0IHdhcyBvcmlnaW5hbGx5IHRvIGNvcnJlY3Qgc29tZSBXXlggaXNzdWVzLiBJZiBh
IHZtYWxsb2Mgd2FzIGZyZWVkDQp3aXRoIFggcGVybWlzc2lvbiBpdCBjYXVzZWQgc29tZSBleHBv
c3VyZS4gVGhlIHNlY3VyaXR5IHNpZGUgY291bGQgYmUNCmZpeGVkIHdpdGggY29waW91cyBzZXRf
bWVtb3J5KCkgY2FsbHMgaW4ganVzdCB0aGUgcmlnaHQgb3JkZXIsIGJ1dA0KdGhlcmUgd2FzIGEg
c3VnZ2VzdGlvbiB0byBtYWtlIHZtYWxsb2MgaGFuZGxlIGl0IHNvIGl0IGNvdWxkIGJlIGRvbmUN
Cm1vcmUgZWZmaWNpZW50bHkgYW5kIGNhbGxlcnMgd291bGQgbm90IGhhdmUgdG8ga25vdyB0aGUg
ZGV0YWlscyBmb3IgYXQNCmxlYXN0IHRoYXQgcGFydCBvZiB0aGUgb3BlcmF0aW9uLiBUaGlzIHBy
b2cgcGFjayBzdHVmZiBpcyBhbHJlYWR5IG1vcmUNCmVmZmljaWVudCB3aXRoIHJlc3BlY3QgdG8g
VExCIGZsdXNoZXMuIFNvIHdoaWxlIFZNX0ZMVVNIX1JFU0VUX1BFUk1TDQpjb3VsZCBzdGlsbCBp
bXByb3ZlIGl0IHNsaWdodGx5LCB0aGUgc2l0dWF0aW9uIGlzIG5vdyBwcm9iYWJseSBiZXR0ZXIN
CnRoYW4gaXQgd2FzIHByZS1WTV9GTFVTSF9SRVNFVF9QRVJNUyBhbnl3YXkuIFNvIHRoYXQgbW9z
dGx5IGxlYXZlcyB0aGUNCnByb2JsZW0gb2Ygc29tZSBzcGVjaWFsIGtub3dsZWRnZSBsZWFraW5n
IGJhY2sgaW50byB0aGUgY2FsbGVycy4NCg0KV2l0aCBhIG5leHQgc29sdXRpb24gaXQgd291bGQg
aG9wZWZ1bGx5IGJlIGhhbmRsZWQgZGlmZmVyZW50bHkgc3RpbGwsDQp1c2luZyB0aGUgdGhlIHVu
bWFwcGVkIHBhZ2Ugc3R1ZmYgTWlrZSBSYXBvcG9ydCB3YXMgd29ya2luZyBvbi4NCg0KPiANCj4g
U2VlaW5nIGFsbCB0aGlzLCBnaXZlbiBtb2R1bGVfYWxsb2MoKSB1c2VycyBhcmUgZ3Jvd2luZyBh
bmQgc2VlaW5nDQo+IHRoZSB0aW55IGJpdCBvZiBncm93dGggb2YgdXNlIGluIHRoaXMgc3BhY2Us
IEknZCB0aGluayB3ZSBzaG91bGQNCj4gcmVuYW1lIG1vZHVsZV9hbGxvYygpIHRvIHZtYWxsb2Nf
ZXhlYygpLCBhbmQgbGlrZXdpc2UgdGhlIHNhbWUgZm9yDQo+IG1vZHVsZV9tZW1mcmVlKCkgdG8g
dm1hbGxvY19leGVjX2ZyZWUoKS4gQnV0IGl0IHdvdWxkIGJlIG91ciBmaXJzdA0KPiBfX3dlYWsg
dm1hbGxvYywgYW5kIG5vdCBzdXJlIGlmIHRoYXQncyBsb29rZWQgZG93biB1cG9uLg0KDQpBIHJl
bmFtZSBzZWVtcyBnb29kIHRvIG1lLiBNb2R1bGUgc3BhY2UgaXMgcmVhbGx5IGp1c3QgZHluYW1p
Y2FsbHkNCmFsbG9jYXRlZCB0ZXh0IHNwYWNlIG5vdy4gVGhlcmUgdXNlZCB0byBiZSBhIHZtYWxs
b2NfZXhlYygpIHRoYXQNCmFsbG9jYXRlZCB0ZXh0IGluIHZtYWxsb2Mgc3BhY2UsIHNvIG1heWJl
IHRoZSBuYW1lIHNob3VsZCBoYXZlDQpzb21ldGhpbmcgdG8gZGVub3RlIHRoYXQgaXQgZ29lcyBp
bnRvIHRoZSBzcGVjaWFsIGFyY2ggc3BlY2lmaWMgdGV4dA0Kc3BhY2UuDQoNCj4gDQo+ID4gSWYg
dGhlcmUNCj4gPiBhcmUgYWN0dWFsIG5lYXIgdGVybSBwbGFucyB0byBrZWVwIHdvcmtpbmcgb24g
dGhpcywNCj4gPiBWTV9GTFVTSF9SRVNFVF9QRVJNUyBtaWdodCBiZSBjaGFuZ2VkIGFnYWluIG9y
IHR1cm4gaW50byBzb21ldGhpbmcNCj4gPiBlbHNlLiBMaWtlIGlmIHdlIGFyZSBhYm91dCB0byBy
ZS10aGluayBldmVyeXRoaW5nLCB0aGVuIGl0IGRvZXNuJ3QNCj4gPiBtYXR0ZXIgYXMgbXVjaCB0
byBmaXggd2hhdCB3b3VsZCB0aGVuIGJlIG9sZC4NCj4gDQo+IEkgdGhpbmsgaXQncyB1cCB0byB5
b3UgYXMgeW91IGFkZGVkIGl0IGFuZCBJJ20gbm90IGxvb2tpbmcgdG8gYWRkDQo+IGFueSBiZWxs
cyBvciB3aXN0bGVzLCBqdXN0IHRpZHkgdGhpbmdzIHVwICpzbG93bHkqLg0KPiANCj4gPiBCZXNp
ZGVzIG5vdCBmaXhpbmcgVk1fRkxVU0hfUkVTRVRfUEVSTVMvaGliZXJuYXRlIHRob3VnaCwgSSB0
aGluaw0KPiA+IHRoaXMNCj4gPiBhbGxvY2F0b3Igc3RpbGwgZmVlbHMgYSBsaXR0bGUgcm91Z2gu
IEZvciBleGFtcGxlIEkgZG9uJ3QgdGhpbmsgd2UNCj4gPiBhY3R1YWxseSBrbm93IGhvdyBtdWNo
IHRoZSBodWdlIG1hcHBpbmdzIGFyZSBoZWxwaW5nLg0KPiANCj4gUmlnaHQsIDEwMCUgYWdyZWVk
LiBUaGUgcGVyZm9ybWFuY2UgbnVtYmVycyBwcm92aWRlZCBhcmUgbmljZSBidXQNCj4gdGhleSBh
cmUgbm90IGFueXRoaW5nIGZvbGtzIGNhbiByZXByb2R1Y2UgYXQgYWxsLiBJIGhpbnRlZCB0b3dh
cmRzDQo+IHBlcmYgc3R1ZmYgd2hpY2ggY291bGQgYmUgdXNlZCBhbmQgZW5hYmxlIG90aGVyIHVz
ZXJzIGxhdGVyIHRvIGFsc28NCj4gdXNlIHNpbWlsYXIgc3RhdHMgdG8gc2hvd2Nhc2UgaXRzIHZh
bHVlIGlmIHRoZXkgd2FudCB0byBtb3ZlIHRvDQo+IGh1Z2UgcGFnZXMuDQo+IA0KPiBJdCBpcyBh
IHNpZGUgbm90ZSwgYW5kIHBlcmhhcHMgYSBzdHVwaWQgcXVlc3Rpb24sIGFzIEkgZG9uJ3QgZ3Jv
ayBtbSwNCj4gYnV0IEknbSBwZXJwbGV4ZWQgYWJvdXQgdGhlIGZhY3QgdGhhdCBpZiB0aGUgdmFs
dWUgaXMgc2VlbiBzbyBoaWdoDQo+IHRvd2FyZHMNCj4gaHVnZSBwYWdlcyBmb3IgZXhlYyBzdHVm
ZiBpbiBrZXJuZWwsIHdvdWxkbid0IHRoZXJlIGJlIGEgZmV3IGZvbGtzDQo+IHdobw0KPiBtaWdo
dCB3YW50IHRvIHRyeSB0aGlzIGZvciByZWd1bGFyIGV4ZWMgc3R1ZmY/IFdvdWxkbid0IHRoZXJl
IGJlIG11Y2gNCj4gbW9yZSBnYWlucyB0aGVyZT8NCg0KQ29yZSBrZXJuZWwgdGV4dCBpcyBhbHJl
YWR5IDJNQiBtYXBwZWQsIG9uIHg4NiBhdCBsZWFzdC4gSXQgaW5kZWVkDQpoZWxwcyBwZXJmb3Jt
YW5jZS4gSSdkIGxpa2UgdG8gc2VlIGFib3V0IDJNQiBtb2R1bGUgdGV4dC4gSSBjYW4gb25seQ0K
YXNzdW1lIHRoYXQgaXQgd291bGQgaGVscCBwZXJmb3JtYW5jZSB0aG91Z2guIFNvbWUgcGVvcGxl
IHdpc2VyIHRoYW4gbWUNCmluIHBlcmZvcm1hbmNlIHN0dWZmIHN1Z2dlc3RlZCBpdCBzaG91bGQg
YmUgdGVzdGVkIHRvIGFjdHVhbGx5IGtub3cuDQoNCj4gDQo+ID4gSXQgaXMgYWxzbw0KPiA+IGFs
bG9jYXRpbmcgbWVtb3J5IGluIGEgYmlnIGNodW5rIGZyb20gYSBzaW5nbGUgbm9kZSBhbmQgcmV1
c2luZyBpdCwNCj4gPiB3aGVyZSBiZWZvcmUgd2Ugd2VyZSBhbGxvY2F0aW5nIGJhc2VkIG9uIG51
bWEgbm9kZSBmb3IgZWFjaCBqaXQuDQo+ID4gV291bGQNCj4gPiBzb21lIHVzZXIncyBzdWZmZXIg
ZnJvbSB0aGF0PyBNYXliZSBpdCdzIG9idmlvdXMgdG8gb3RoZXJzLCBidXQgSQ0KPiA+IHdvdWxk
DQo+ID4gaGF2ZSBleHBlY3RlZCB0byBzZWUgbW9yZSBkaXNjdXNzaW9uIG9mIE1NIHRoaW5ncyBs
aWtlIHRoYXQuDQo+IA0KPiBDdXJpb3VzLCB3aHkgd2FzIGl0IG1vdmVkIHRvIHVzZSBhIHNpbmds
ZSBub2RlPw0KDQpUbyBhbGxvY2F0ZSBmcm9tIHRoZSBjbG9zZXN0IG5vZGUgeW91IG5lZWQgdG8g
aGF2ZSBwZXItbm9kZSBjYWNoZXMuDQpXaGVuIEkgdHJpZWQgdG8gZG8gc29tZXRoaW5nIHNpbWls
YXIgdG8gdGhpcyB3aXRoIHRoZSBncm91cGVkIHBhZ2UNCmNhY2hlLCBoYXZpbmcgcGVyLW5vZGUg
Y2FjaGVzIHdhcyBzdWdnZXN0ZWQgc2hvdWxkIGJlIHJlcXVpcmVkLiBJIG5ldmVyDQpiZW5jaG1h
cmtlZCB0aGUgZGlmZmVyZW5jZSB0aG91Z2guDQoNCj4gDQo+ID4gQnV0IEkgbGlrZSBnZW5lcmFs
IGRpcmVjdGlvbiBvZiBjYWNoaW5nIGFuZCB1c2luZyB0ZXh0X3Bva2UoKSB0bw0KPiA+IHdyaXRl
DQo+ID4gdGhlIGppdHMgYSBsb3QuIEhvd2V2ZXIgaXQgd29ya3MsIGl0IHNlZW1zIHRvIG1ha2Ug
YSBiaWcgaW1wYWN0IGluDQo+ID4gYXQNCj4gPiBsZWFzdCBzb21lIHdvcmtsb2Fkcy4NCj4gPiAN
Cj4gPiBTbyB5ZWEsIHNlZW1zIHNsb3BweSwgYnV0IHByb2JhYmx5ICguLi5JIGd1ZXNzPykgbW9y
ZSBnb29kIGZvcg0KPiA+IHVzZXJzDQo+ID4gdGhlbiBzbG9wcHkgZm9yIHVzLg0KPiANCj4gVGhl
IGltcGFjdCBvZiBzbG9wcGluZXNzIGxpZXMgaW4gcG9zc2libGUgb2RkIGJ1Z3MgbGF0ZXIgYW5k
IHRyeWluZw0KPiB0bw0KPiBkZWNpcGhlciB3aGF0IHdhcyBiZWluZyBkb25lLiBTbyBJIGRvIGhh
dmUgY29uY2VybnMgd2l0aCB0aGUNCj4gaW1tZWRpYXRlDQo+IHRyaWJhbCBrbm93bGVnZSBpbmN1
cnJlZCBieSB0aGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbi4NCg0KSSBhbSBhbHNvIGJvdGhlcmVk
IGJ5IGl0LiBJJ20gZ2xhZCB0byBoZWFyIHNvbWVvbmUgZWxzZSBjYXJlcy4gSSBjYW4NCnRoaW5r
IGFib3V0IGRvaW5nIGl0IG1vcmUgaW5jcmVtZW50YWxseS4gVGhlIHByb2JsZW0gaXMgeW91IGtp
bmQgb2YNCm5lZWQgdG8ga25vdyBpZiB5b3UgY2FuIGludGVncmF0ZSB3aXRoIGFsbCB0aGUgbW9k
dWxlX2FsbG9jKCkgdXNlcnMgYW5kDQpnZXQgc2FuZSBiZWhhdmlvciBvbiB0aGUgYmFja2VuZCwg
dG8gdGVsbCBpZiB5b3VyIG5ldyBpbnRlcmZhY2UgaXMNCmFjdHVhbGx5IGFueSBnb29kLg0KDQpU
aGlzIGlzIHByZXR0eSBtdWNoIGhvdyBJIHRoaW5rIHdlIGNhbjoNCiAtIHJlbW92ZSBhbGwgc3Bl
Y2lhbCBrbm93bGVkZ2UgZnJvbSBjYWxsZXJzDQogLSBzdXBwb3J0IGFsbCBtb2R1bGVfYWxsb2Mo
KSBjYWxsZXJzDQogLSBkbyB0aGluZ3MgbW9yZSBlZmZpY2llbnRseSBvbiB4ODYNCiAtIHN1cHBv
cnQgYWxsIHRoZSBhcmNoIHNwZWNpZmljIGV4dHJhIGNhcGFiaWxpdGllcyB0aGF0IEkga25vdyBh
Ym91dA0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAxMTIwMjAyNDI2LjE4MDA5
LTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vI3INCg0KSXQncyB3aHkgSSBzaHJ1ZyBhIGxp
dHRsZSBhYm91dCB3cml0aW5nIGNhbGxlciBjb2RlIHdpdGggc3BlY2lhbA0Ka25vd2xlZGdlIGlu
IGl0LiBJdCdzIG5vdCByZWFsbHkgcG9zc2libGUgdG8gYXZvaWQgaXQgY29tcGxldGVseSB3aXRo
DQp0aGUgY3VycmVudCBpbnRlcmZhY2VzIElNTy4NCg0KPiBXaGF0IGlzIHlvdXINCj4gb3duIHJv
YWRtYXAgZm9yIFZNX0ZMVVNIX1JFU0VUX1BFUk1TPyBTb3VuZHMgbGlrZSBhIGZ1dHVyZSBwb3Nz
aWJseQ0KPiBtYXliZSByZS1kbz8NCg0KSWYgaXQgd2VyZSBtZSwgSSB3b3VsZCBzdGFydCBiYWNr
IHdpdGggdGhhdCBSRkMgYW5kIHRyeSB0byBtb3ZlIHRoZQ0KYWxsb2NhdGlvbiBzaWRlIGZvcndh
cmQgdG9vLiBJIGhhdmVuJ3Qgc2VlbiBhbnl0aGluZyBzaW5jZSwgdGhhdCBtYWtlcw0KbWUgdGhp
bmsgaXQgd2FzIHRoZSB3cm9uZyBkaXJlY3Rpb24uIEJ1dCBJIGhhdmUgZW1wbG95ZXIgdGFza3Mg
dGhhdA0KdGFrZSBwcmlvcml0eSB1bmZvcnR1bmF0ZWx5LiBJZiBhbnlvbmUgZWxzZSB3YW50cyB0
byB0YWtlIGEgc2hvdCBhdCBpdCwNCkkgY2FuIGhlbHAgcmV2aWV3LiBPdGhlcndpc2UsIGhvcGVm
dWxseSBJIGNhbiBnZXQgYmFjayB0byBpdCBzb21lZGF5Lg0KDQo=
