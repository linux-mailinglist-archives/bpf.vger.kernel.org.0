Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D358618A6F
	for <lists+bpf@lfdr.de>; Thu,  3 Nov 2022 22:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiKCVTm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKCVTl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 17:19:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C435F2018B
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 14:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667510378; x=1699046378;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b3tw2cALM0AD+8eCl0N4Esglz8jDUsx7WjNY39hBSVU=;
  b=S9vUkaZtzlDESrtW8F4LZWba4CgK1SXi7F1zXPL5GFhCOsRuQJ3OZHB2
   tgizpb5M9Nc3fG1hlzTb63MiI5YHzl3G31UgKAK1r7OZ7yOXTDQnRQQrg
   QsVixQiHxr/p53+tlVCPOTxuQ1YkZKj85P4cXNvPEFyt793fckqNZe2O4
   dTpc1TPDG7xZq3U6DaxBSRcXuiJtpLD72DrraOuv2wjD5Z/sEGsWEgZn8
   4L+HGjilLXsAWeqOXpynsTG0ZAF3nwWd2gAnu5FLOv6AgKWXvrwu6vtE+
   yUrzVFmSITWOtmp2Do407lw6/8SY4ZUnJ34D2klFclRzQlMGg9q/rhV74
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="297270959"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="297270959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 14:19:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="698391213"
X-IronPort-AV: E=Sophos;i="5.96,135,1665471600"; 
   d="scan'208";a="698391213"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 03 Nov 2022 14:19:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 14:19:34 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 14:19:34 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 14:19:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCLJQxVY+2l7at84A5kyqAgvtlDbOksmolR/FIyEXP7kNSluEwzgwL9p/EWOcbqZWvnfWwbuLKgTS7ThuEoQ63y627TTAH4m71pNb25ceVOByH6I8PZmXe+1PZx+o5JGRTJsK66po635foEPFWEHBvwWlWTvClcbFamcHsGzlXH54HinRKNlWYsx74UKeSHtamjACOy7GvPjahqVCz6iB8wm4skDHggFJEL/eDsvXV2QBcjUt2pStOQUxO0OzlrmZVZdCKlK56k52+8jxlUGzFOCg6IlpqeRfIFY1T4xQoB6vqDpFam41q26o5ci4AZaZSUkaCbBJgneZg33wBOhlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3tw2cALM0AD+8eCl0N4Esglz8jDUsx7WjNY39hBSVU=;
 b=G7R303RWHorJ9+oY+8LlrVOe3GUBKjGkSHkS2cEEIrVRWYSnEx8/gDv6mOQt2Ljx0SayATP/NX9+sWS9i81el5ooxKh9cT0xYlUKrqbDmZ47LOpaXyS7DfTBhwExLnHFSl/GmyzUq2hJiT+e8zYLnrFNGIahwkb+oCaqz+FOMmC6cdFA+CCaCEW7J6VHNxO+xI3hACv40UD4lk1io1hG+d2zVoknyH+wXC6bp+ItVqSYtfouR+TcSxwLWgAYsNhhEmtoCzvuPzKStSm4RgM3KthkvAqKmgZas2cuApU8JVelBk8JiFAxHTlZaPkgo7WYqMAssetjpi81oS/m27D0ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Thu, 3 Nov
 2022 21:19:25 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::99f8:3b5c:33c9:359a%4]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 21:19:25 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "rppt@kernel.org" <rppt@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "willy@infradead.org" <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>, "hch@lst.de" <hch@lst.de>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "zhengjun.xing@linux.intel.com" <zhengjun.xing@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "mgorman@suse.de" <mgorman@suse.de>,
        "a.manzanares@samsung.com" <a.manzanares@samsung.com>
Subject: Re: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Thread-Topic: [PATCH bpf-next v1 RESEND 1/5] vmalloc: introduce vmalloc_exec,
 vfree_exec, and vcopy_exec
Thread-Index: AQHY7XfLSe6tnIH3b0uqCCTfNnf6Vq4sTnaAgAEPAYCAADR9AIAAJwEA
Date:   Thu, 3 Nov 2022 21:19:25 +0000
Message-ID: <eac58f163bd8b6829dff176e67b44c79570025f5.camel@intel.com>
References: <20221031222541.1773452-1-song@kernel.org>
         <20221031222541.1773452-2-song@kernel.org>
         <Y2MAR0aj+jcq+15H@bombadil.infradead.org> <Y2Pjnd3mxA9fTlox@kernel.org>
         <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
In-Reply-To: <Y2QPpODzdP+2YSMN@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1392:EE_|DM8PR11MB5606:EE_
x-ms-office365-filtering-correlation-id: 6ad35fda-44b7-4dff-b2b2-08dabde1159e
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jtT3N6bBJTHpeG7gDthYNgifPHDP7n23FRNAaR+5+bsLbNMLj2it5v+Tm0MBdAWvs19iXqLvgtbYGCPEUMC13CXhJ60mvxyRwSJrSSaYSik7C/0eR+CTjtePbwYHBYTVP3cF1700uMw9ZujF05ygwrYmDRoYUnjxxCZNc/tftBA0/tpckpnaBjHgsY/Ubc/7JyLboo1hCHfg/Z7Una6yvrDUGlDtZZgKNxJHzRbBuzLE1dOr/N+sl12avhHxR6mYUDdbcz5E14pJREH6WiBP6mpKioWsVXdXuMRGim9D8wWZz7yYRd161FtF5mS4r4/bpzK1j/0y451nCZHjXrKeafv9KqYJvFJuGo6y1b3xrrmnjalo2MrOtHI5FAqevWiBUItcp5MYnDfMtlIRY8K3eVszjgJd+R6BwQRqHKOc1A4ZSiYzdJD7wyBaQm4QRAbMGS11Dt/XZF4BSXmpRn6CEf75wmAvzZp2UEH/oOskQ0wKiC/GF1PMuEBUR/6RAIreG+eYaXQ4BHOqVXvVseXDtJDa8JLteNFW1NTJFJAHMTWJmQDS1c9jEUi7nCVP7BfQkn9BGdvb4k8+lp2oumsugFE2Foos/5i7Bs2UWGGuEvoZZXaIRLACcK/9VJcofz1cD2ifr7A594jFzh7WE2KhvqDaU6jplxPzGSOQTfqRwiQxZmHRYkXWj23IU3k5gtMvu3rSzY2Gw9g1e6AGzHmlsu8HFlREh1wo9P/SmMLHEFTMiWKlQRdDfv7ryNTU2H0oTSvnEjPw/15rdjR343cKSOZE5Hn2yckLzriKYR9LllY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(376002)(396003)(366004)(136003)(346002)(451199015)(2906002)(66946007)(76116006)(91956017)(6506007)(6512007)(66556008)(26005)(41300700001)(110136005)(8936002)(4326008)(316002)(38070700005)(66446008)(8676002)(5660300002)(7416002)(54906003)(64756008)(66476007)(36756003)(82960400001)(38100700002)(122000001)(478600001)(6486002)(86362001)(2616005)(71200400001)(186003)(99106002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFRYVFV2R2djOTI1V3VjclcrRWxyL2Vwc1JPZWc0RkFNOHExa2tPWDdpTHFS?=
 =?utf-8?B?L25HT3p4N2Zhb3g5L1pRZmpYdkFnZDhkRHVsc2l0bzVESGo5SjRqcStMdjJE?=
 =?utf-8?B?eWV4cjZKbTFSTElzcTZpVmd5eENFWnNTNllGYUJzWUI5WFNOZmJBZEJpcXJZ?=
 =?utf-8?B?TVVsWnRYbzdDRzhRaTRxSlBaazRjS2N5UUZVTUVsdllCQ29hOWNjaThyUzZu?=
 =?utf-8?B?QnViWnA3S0NOZ1ZLTUczb010M0RhQmJ0Z3hNTnJUY0Q3dnJaYUNBbWxoT0c0?=
 =?utf-8?B?Vk5Ld0JseEhXbXhWa0lJcnhBaWtkWklqaUNKemJHVzc2Y2M0WlNaZzhCRkZJ?=
 =?utf-8?B?bjBtWDRlZkoyQVN3YWZjQTZKWitLOTJTUTJzUHEzZ25FdXpEZVlHaUZYVG9t?=
 =?utf-8?B?akpablRQRXkzL0F4Q3lORGtlcy8yTTBtcFRZU3hnTTBzenhxZ3FOQ3dSQjBl?=
 =?utf-8?B?OS9obHJGYW1rVENuSXF0QURRN2ZYWTE3Wk5pRDMxTFZZeVZlOHo3YXY5M1BE?=
 =?utf-8?B?U3Qza3NIYnREaTZHblVpeXc4RjVBemdVR1lVUkNId0gxMC9KME01blhadllu?=
 =?utf-8?B?UDlrMEtidXgyR2I3TTlQU09Jb3RwMWVrMUZLaUJ6VXpaR0JiVnRjU0hwS0kv?=
 =?utf-8?B?dVNsWVk2cCsxVGdkU2g2bHVPSW9YS2VnWllVMVc4WDFWNkh0Y2NWTTFFUDB1?=
 =?utf-8?B?UUloSmhYSld2VFlucDB2Nkh6MEdkMXBhVWUvc1NpUVBmWGY5UjhzZ0xNc1FE?=
 =?utf-8?B?bzJ2Yy92TjdkblFxc3AxSWtRZ0I0bnhLeDVnY3RnT0xCQzJpbnNwTkt2T1FT?=
 =?utf-8?B?ZmpNRTROM085Wjl5WE0vZkhaZnpMWlArWHQrN3RkNXJlNE5PYUdHK0Nrb29X?=
 =?utf-8?B?bDZDdW5BM2hkaUIxTlR6TzhkcDJTamkyTzREUk5pTWtQdmV4cFpSbUR1bkF4?=
 =?utf-8?B?YzNLVW9aSmMvYnY3MkpGU0tnaFhlT0plVms1Nk1TTndiMm1Kbm9xN092dDIr?=
 =?utf-8?B?WlU1MjBrb1pTZjZoUUZWL0hRRjNldUdrOHdCZGR1Y3hPTFB4QTNQZi82TlJC?=
 =?utf-8?B?b1lFQjdaOHEzaXdmNlQzRFNrY3k5SDBWb0xLajlScHU2MDc4dmhBeGZVR0Yx?=
 =?utf-8?B?ZTFGdXQ1V3NXMC8wTlJFQmZ6ZCtJMTRIcllqcFJQNEJSb1gvZm0vekJLN0FD?=
 =?utf-8?B?MG1aeCtYZXgvNWVoa2hhRURQVjUyYkowRUh2aEtwVXJMTTQyQTVDcUtaSUhu?=
 =?utf-8?B?NXhyWm1xMVh3MU4xYW0rRFVOOXhSdnRDTEgrZWFlMllsRHpUSlVOZHJKVGFW?=
 =?utf-8?B?U3pzUmRPcDlsQXhZOEwwOWo5SmJMVGxXWC9lNmFRYVVXRHhRaXVORVhtU3hO?=
 =?utf-8?B?dUJpbjZScmxsZHg0MGRpVnVGalpEc1c2Y2VOcTdjQ0JtWldjUVRwU1BkOVN0?=
 =?utf-8?B?MWZ2aFM2SC9jcFZMcDh4REtVWUVESXZ4VFFUOCtjN0cxU2UvaWNGTnNLSERk?=
 =?utf-8?B?OFVYWENoMFRkTWg5Z0puWkpoR0drbjRpSjNJTXBUK0J2OU1iNnFLMHBvNTJV?=
 =?utf-8?B?R0dRMURGRnlGcG00eU02VHNHcmRmcWdqb25EZGFaYlY1cjZZM1hqYkMzeTVi?=
 =?utf-8?B?cFBjNDhaVzFFUmpvbGlDUXVlUjRSdGswWGlmdThxTEE3dHVGbkVuSnJEc1hy?=
 =?utf-8?B?S0djRUF5T1FDVUlqSUgyWlc5UVgyaDA2RlhUanFiQ2RZcFBrUlZvcVVYT2o4?=
 =?utf-8?B?eTdqZ0EyN2ZLNnZjMkhFTnVReXNQNlM0bFJxWjIrSVl0Nzcxc3JhWXhaU21r?=
 =?utf-8?B?QWtadWduVXFlOEhXdWFJd0pXYkFUT1N0Tm9Yd3ZiY3BCYjVKN1YyYjZWbFZj?=
 =?utf-8?B?eG4wdHRGZit4S29EZjhueGg4ZWtqeXZCT1JFRGJpZk54WE85VDVRREhkR3NQ?=
 =?utf-8?B?RWpLcUlqSlJDOTBZYXJxQlJsQjUrcytzblMxS1hMK3NJcXVwT2NjcnNOaHAy?=
 =?utf-8?B?dTZyQkdzWkRSOUZWaTRpRWJwVlR1SzA5UXZJNnUzOTQ0RWxCZWNodWFrRDlR?=
 =?utf-8?B?WjJ1dHpib3hDaWR2MEdsYWd2T2hBNGd5dzlXV1ZBTlFkUEVOT05PbmR4aDJF?=
 =?utf-8?B?YlkvZkNvemt0dG52RVNYNm5mQTQ0Y0FZdHdzQmFkdFhKTWV2NmlaWjlncHhj?=
 =?utf-8?Q?AljfoY11A74rH1O0aVY9cK0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <113DF365A0040049B7E52F8A54E9844D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad35fda-44b7-4dff-b2b2-08dabde1159e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2022 21:19:25.3891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YmNPwWrRu9Qux5VoRdEJwa+4jcK3tAlNUyzyDWYw6tMs3/IBldFgiJQ7wQAcZ7yLbjmypCkVzIdOtXhDwJ/p6JujNk24P76DT5GQnpqZJf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTAzIGF0IDExOjU5IC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3Rl
Og0KPiA+ID4gTWlrZSBSYXBvcG9ydCBoYWQgcHJlc2VudGVkIGFib3V0IHRoZSBEaXJlY3QgbWFw
IGZyYWdtZW50YXRpb24NCj4gPiA+IHByb2JsZW0NCj4gPiA+IGF0IFBsdW1iZXJzIDIwMjEgWzBd
LCBhbmQgY2xlYXJseSBtZW50aW9uZWQgbW9kdWxlcyAvIEJQRiAvDQo+ID4gPiBmdHJhY2UgLw0K
PiA+ID4ga3Byb2JlcyBhcyBwb3NzaWJsZSBzb3VyY2VzIGZvciB0aGlzLiBUaGVuIFhpbmcgWmhl
bmdqdW4ncyAyMDIxDQo+ID4gPiBwZXJmb3JtYW5jZQ0KPiA+ID4gZXZhbHVhdGlvbiBvbiB3aGV0
aGVyIHVzaW5nIDJNLzFHIHBhZ2VzIGFnZ3Jlc3NpdmVseSBmb3IgdGhlDQo+ID4gPiBrZXJuZWwg
ZGlyZWN0IG1hcA0KPiA+ID4gaGVscCBwZXJmb3JtYW5jZSBbMV0gZW5kcyB1cCBnZW5lcmFsbHkg
cmVjb21tZW5kaW5nIGh1Z2UgcGFnZXMuDQo+ID4gPiBUaGUgd29yayBieSBYaW5nDQo+ID4gPiB0
aG91Z2ggd2FzIGFib3V0IHVzaW5nIGh1Z2UgcGFnZXMgKmFsb25lKiwgbm90IHVzaW5nIGEgc3Ry
YXRlZ3kNCj4gPiA+IHN1Y2ggYXMgaW4gdGhlDQo+ID4gPiAiYnBmIHByb2cgcGFjayIgdG8gc2hh
cmUgb25lIDIgTWlCIGh1Z2UgcGFnZSBmb3IgKmFsbCogc21hbGwgZUJQRg0KPiA+ID4gcHJvZ3Jh
bXMsDQo+ID4gPiBhbmQgdGhhdCBJIHRoaW5rIGlzIHRoZSByZWFsIGdvbGRlbiBudWdnZXQgaGVy
ZS4NCj4gPiA+IA0KPiA+ID4gSSBjb250ZW5kIHRoZXJlZm9yZSB0aGF0IHRoZSB0aGVvcmV0aWNh
bCByZWR1Y3Rpb24gb2YgaVRMQiBtaXNzZXMNCj4gPiA+IGJ5IHVzaW5nDQo+ID4gPiBodWdlIHBh
Z2VzIGZvciAiYnBmIHByb2cgcGFjayIgaXMgbm90IHdoYXQgZ2V0cyB5b3VyIHN5c3RlbXMgdG8N
Cj4gPiA+IHBlcmZvcm0NCj4gPiA+IHNvbWVob3cgYmV0dGVyLiBJdCBzaG91bGQgYmUgc2ltcGx5
IHRoYXQgaXQgcmVkdWNlcyBmcmFnbWVudGF0aW9uDQo+ID4gPiBhbmQNCj4gPiA+ICp0aGlzKiBn
ZW5lcmFsbHkgY2FuIGhlbHAgd2l0aCBwZXJmb3JtYW5jZSBsb25nIHRlcm0uIElmIHRoaXMgaXMN
Cj4gPiA+IGFjY3VyYXRlDQo+ID4gPiB0aGVuIGxldCdzIHBsZWFzZSBzZXBhcmF0ZSB0aGUgdHdv
IGFzcGVjdHMgdG8gdGhpcy4NCj4gPiANCj4gPiBUaGUgZGlyZWN0IG1hcCBmcmFnbWVudGF0aW9u
IGlzIHRoZSByZWFzb24gZm9yIGhpZ2hlciBUTEIgbWlzcw0KPiA+IHJhdGUsIGJvdGgNCj4gPiBm
b3IgaVRMQiBhbmQgZFRMQi4NCj4gDQo+IE9LIHNvIHRoZW4gd2hhdGV2ZXIgYmVuY2htYXJrIGlz
IHJ1bm5pbmcgaW4gdGFuZGVtIGFzIGVCUEYgSklUIGlzDQo+IGhhbW1lcmVkDQo+IHNob3VsZCAq
YWxzbyogYmUgbWVhc3VyZWQgd2l0aCBwZXJmIGZvciBpVExCIGFuZCBkVExCLiBpZSwgdGhlIHBh
dGNoDQo+IGNhbg0KPiBwcm92aWRlIHN1Y2ggcmVzdWx0cyBhcyBhIGp1c3RpZmljYXRpb25zLg0K
DQpTb25nIGhhZCBkb25lIHNvbWUgdGVzdHMgb24gdGhlIG9sZCBwcm9nIHBhY2sgdmVyc2lvbiB0
aGF0IHRvIG1lIHNlZW1lZA0KdG8gaW5kaWNhdGUgbW9zdCAob3IgcG9zc2libHkgYWxsKSBvZiB0
aGUgYmVuZWZpdCB3YXMgZGlyZWN0IG1hcA0KZnJhZ21lbnRhdGlvbiByZWR1Y3Rpb24uIFRoaXMg
d2FzIHN1cnByaXNlZCBtZSwgc2luY2UgMk1CIGtlcm5lbCB0ZXh0DQpoYXMgc2hvd24gdG8gYmUg
YmVuZWZpY2lhbC4NCg0KT3RoZXJ3aXNlICsxIHRvIGFsbCB0aGVzZSBjb21tZW50cy4gVGhpcyBz
aG91bGQgYmUgY2xlYXIgYWJvdXQgd2hhdCB0aGUNCmJlbmVmaXRzIGFyZS4gSSB3b3VsZCBhZGQs
IHRoYXQgdGhpcyBpcyBhbHNvIG11Y2ggbmljZXIgYWJvdXQgVExCDQpzaG9vdGRvd25zIHRoYW4g
dGhlIGV4aXN0aW5nIHdheSBvZiBsb2FkaW5nIHRleHQgYW5kIHNhdmVzIHNvbWUgbWVtb3J5Lg0K
DQpTbyBJIHRoaW5rIHRoZXJlIGFyZSBzb3J0IG9mIGZvdXIgYXJlYXMgb2YgaW1wcm92ZW1lbnRz
Og0KMS4gRGlyZWN0IG1hcCBmcmFnbWVudGF0aW9uIHJlZHVjdGlvbiAoZFRMQiBtaXNzIGltcHJv
dmVtZW50cykuIFRoaXMNCnNvcnQgb2YgZG9lcyBpdCBhcyBhIHNpZGUgZWZmZWN0IGluIHRoaXMg
c2VyaWVzLCBhbmQgdGhlIHNvbHV0aW9uIE1pa2UNCmlzIHRhbGtpbmcgYWJvdXQgaXMgYSBtb3Jl
IGdlbmVyYWwsIHByb2JhYmx5IGJldHRlciBvbmUuDQoyLiAyTUIgbWFwcGVkIEpJVHMuIFRoaXMg
aXMgdGhlIGlUTEIgc2lkZS4gSSB0aGluayB0aGlzIGlzIGEgZGVjZW50DQpzb2x1dGlvbiBmb3Ig
dGhpcywgYnV0IHN1cnByaXNpbmdseSBpdCBkb2Vzbid0IHNlZW0gdG8gYmUgdXNlZnVsIGZvcg0K
SklUcy4gKG1vZHVsZXMgdGVzdGluZyBUQkQpDQozLiBMb2FkaW5nIHRleHQgdG8gcmV1c2VkIGFs
bG9jYXRpb24gd2l0aCBwZXItY3B1IG1hcHBpbmdzLiBUaGlzDQpyZWR1Y2VzIFRMQiBzaG9vdGRv
d25zLCB3aGljaCBhcmUgYSBzaG9ydCB0ZXJtIGxvYWQgYW5kIHRlYXJkb3duIHRpbWUNCnBlcmZv
cm1hbmNlIGRyYWcuIE15IHVuZGVyc3RhbmRpbmcgaXMgdGhpcyBpcyBtb3JlIG9mIGEgcHJvYmxl
bSBvbg0KYmlnZ2VyIHN5c3RlbXMgd2l0aCBtYW55IENQVXMuIFRoaXMgc2VyaWVzIGRvZXMgYSBk
ZWNlbnQgam9iIGF0IHRoaXMsDQpidXQgdGhlIHNvbHV0aW9uIGlzIG5vdCBjb21wYXRpYmxlIHdp
dGggbW9kdWxlcy4gTWF5YmUgb2sgc2luY2UgbW9kdWxlcw0KZG9uJ3QgbG9hZCBhcyBvZnRlbiBh
cyBKSVRzLg0KNC4gSGF2aW5nIEJQRiBwcm9ncyBzaGFyZSBwYWdlcy4gVGhpcyBzYXZlcyBtZW1v
cnkuIFRoaXMgc2VyaWVzIGNvdWxkDQpwcm9iYWJseSBlYXNpbHkgZ2V0IGEgbnVtYmVyIGZvciBo
b3cgbXVjaC4NCg0K
