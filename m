Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3556DF3E5
	for <lists+bpf@lfdr.de>; Wed, 12 Apr 2023 13:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDLLjj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Apr 2023 07:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjDLLjP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Apr 2023 07:39:15 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B897122
        for <bpf@vger.kernel.org>; Wed, 12 Apr 2023 04:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681299535; x=1712835535;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/hfvsYVSexZl4RoDjWHGHVyOXpHkiX7YSYgShp+G7tU=;
  b=HKf1Qh+H4duyMSoSMrivIyeqrdEHxmeF/sB6/SYBZhaV7Wz0N1fVyMFe
   LEklNvD8kPojewzs7xSuNBWSnCY8kRnNooID7iUC00LBkHj+rb0GpP7MS
   RzCMJXHy5TTcs5o8wkeD0TFIPbh9Lktxt93WLgn9Rl0Cg+Ab7JdVMwYgW
   JKT2LPm8NGer18xJ89ZAd50XGJhMpX77+gslAOLWy851p+zX7wDtijakX
   bQ3sMnnZ6YKvIArdyqmTQEK770u97we5Jcb1Mkhh39zTQjpmau/T2fU7t
   ZMFFUwIpzCA62pZI3DvktDoce0Xhvu4aC5zWDqSBkeGgpA7DGJi99MT+3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="345660650"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345660650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 04:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="721536829"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="721536829"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 12 Apr 2023 04:38:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:38:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 04:38:40 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 04:38:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 04:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QoqtuZfTc4nJMy5MWhrC7yAkhCjQPn7HDuaF/FFnt/F9HmXPnxmo24yBgs/bpLal5ceK4Qs0E1WUjrw1znFok+JyQ3J2gnvZLAUUOKvDVZu1XDr80si+GLlSnVqtSPEBfTqIvy8nsx+8SHvvfSjXZowbe/oSZp39hnxihzzXa73v9gw7IlmWhxdRhjiDbs3exEL8IWzG/+JdZgEXfCbYA7s0wYlowUdGGOrRrY7xG7EUdpjLwPZMOC7D49tBV8lu75hPBG/DjrxdiuCdpxPAKSAkLh35acSirav9RIroGA6E9y+8CNkNfk9KP+PgWJNqSF1AXhhEh2N06JU9VExXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hfvsYVSexZl4RoDjWHGHVyOXpHkiX7YSYgShp+G7tU=;
 b=gs6cTXonSv7NnKZGnaJlTFQ1fvssanauZ1iGEXgrYm+jPWbMPfbNaO4+eJnmxu43LnbB8tzzvp4mLKgBYCWnsysZ5N8iURwPuNSaSRdTrTsWfyvtLmYFwpiBIoqF10suI5BEayZjKll//bMLVjPm9rBpAaO28Lk2bkabtrPuJySoQCSxhPp80GYTXIL0IsCZhuzWnLgPlysRbqbtu0Jfn6A4td6hZ98H/ClOXsbs0HmbwdMXG5OBVlQgRRaylSbqKJe1UteauGLdf55eKRvxgMNlH7vn2RfUayviEAxgO+21JyUJZjPHgW8dEWAdzflFSI2d5RrUHJNY6ju9ELgaHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5830.namprd11.prod.outlook.com (2603:10b6:510:129::20)
 by DM4PR11MB6504.namprd11.prod.outlook.com (2603:10b6:8:8d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Wed, 12 Apr 2023 11:38:36 +0000
Received: from PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee]) by PH0PR11MB5830.namprd11.prod.outlook.com
 ([fe80::1c4e:86ae:810d:1fee%2]) with mapi id 15.20.6277.036; Wed, 12 Apr 2023
 11:38:36 +0000
From:   "Song, Yoong Siang" <yoong.siang.song@intel.com>
To:     "Brouer, Jesper" <brouer@redhat.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "Brouer, Jesper" <brouer@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        "martin.lau@kernel.org" <martin.lau@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Lobakin, Aleksander" <aleksander.lobakin@intel.com>,
        "Zaremba, Larysa" <larysa.zaremba@intel.com>,
        "xdp-hints@xdp-project.net" <xdp-hints@xdp-project.net>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Ong, Boon Leong" <boon.leong.ong@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "Brandeburg, Jesse" <jesse.brandeburg@intel.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "hawk@kernel.org" <hawk@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: RE: [PATCH bpf-next V3 1/6] igc: enable and fix RX hash usage by
 netstack
Thread-Topic: [PATCH bpf-next V3 1/6] igc: enable and fix RX hash usage by
 netstack
Thread-Index: AQHZXNeYSjXaM/mM1kuNy5qWdOfXCq8nqwNw
Date:   Wed, 12 Apr 2023 11:38:36 +0000
Message-ID: <PH0PR11MB58307262FA2F2D68CBDFE7F8D89B9@PH0PR11MB5830.namprd11.prod.outlook.com>
References: <167950085059.2796265.16405349421776056766.stgit@firesoul>
 <167950087738.2796265.17812597177704199765.stgit@firesoul>
In-Reply-To: <167950087738.2796265.17812597177704199765.stgit@firesoul>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5830:EE_|DM4PR11MB6504:EE_
x-ms-office365-filtering-correlation-id: e23cf477-409d-47bb-96fc-08db3b4a743a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 87A8oX4i8UO8pADpC7xyyJ6fac21vwVcdYdrIN2qGDTqzmJU/bYK6TS6beyViWlz28fscVsgUAPE2FjlSg98/wZ+YP+09+sXD26cb937NmTCA7D9do/cksjSyzEKKOw9PdYH0GTK7cIviKTs4e2tFhZVzbsHO/ADQJgKyhA+DTl4M8mN0NwDG+SoT4l+fnYx3RKwVmncpjFYq1gJwcIMxF2JaV1iXpzisiuPJJ3e7+Y1rZB9fMbiQwmv4Pcbq4h1KdpjYxFAexuvHXiP/efDn9pVF+3WI4lckN/C/qC7E/fai0F3f5FTH9XfhV+2a5vr43dFpeXt+qrrS6JTrUR+IMiUlfYNtWU0mpWHOz9XPUKHW4GsBcE8QgXW5/q9Xh3BT1olOZPdIXknY0FIyLdpIXTwI25BrnRYWk8go0JEfkEn/5KfV2p4YX2eigCzPdGZKCr6OA5NyCWHrc6ffkcMCLRiB4zuxeQCUigP76wn2yGsNLw8Cw+WHDcQ3ICJ85dAdatRv+mDqxfB3VDEo1zP8nvvuc64rcYtNnIAxEiJtvHgA2d4NclQNj2ZUVyjAhfKnF2NQu89ToHoo8WR8xD2Beq4UGsse8lPo27zQgDe1zm8bvw51kQaCA4vCVTNEdkz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5830.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(366004)(376002)(346002)(396003)(451199021)(7696005)(71200400001)(54906003)(76116006)(66946007)(66556008)(66476007)(41300700001)(64756008)(8936002)(66446008)(8676002)(5660300002)(7416002)(52536014)(83380400001)(2906002)(26005)(9686003)(186003)(55236004)(6506007)(53546011)(478600001)(110136005)(82960400001)(122000001)(4326008)(38100700002)(38070700005)(86362001)(33656002)(316002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aStFMEp6ZWN5TW9nc1ZsaGE3TXhnbFlGbkpsREZaL1NzbEp0N3A5UWlrMzNG?=
 =?utf-8?B?eHp4VmIyaXBJNzZjR3BqTXRNWE40S2xKWGYyWkp5U1hIZWVtKzg3UjdOdWRi?=
 =?utf-8?B?TFJLd3R4TUw2OThSSTlYaDdpcXhCZkhGd2dOZHYzQTUycnZoeG9ycUl3MzZJ?=
 =?utf-8?B?R2NVb1B3eDlhTkRpTXRzczIzSXZscE9mdC9zS3N4dzlyczQrQnhTKzlFb3ZP?=
 =?utf-8?B?UUl0MDVnaDBVOVFLV3lpT0NjT1ozVjAyRVdLQWg5cUd2NWhlQWhmVWlVMGhY?=
 =?utf-8?B?WkRzdS9HZDZQL2xoVUhrelFwb0lISTRFejZBVHJSM1V3TEpWRDVFTFV1R04w?=
 =?utf-8?B?d0cvdmd2b2dRNUo5eEc2d25LVHFsdkpvaW5JZnR0T2lHQmYraFFuNWdhb2hX?=
 =?utf-8?B?KzRrZjRTRUp0Ym04TFhDWnFDU0dXQ0YySnJVc0MvS0g2eHJZeU1rWG9iOUJt?=
 =?utf-8?B?eUFvQlNTTm9sWndoeFN1QWlCTkcxUmVFQS9HYjZMWXBCRGZYZ0xsaGlGL1lI?=
 =?utf-8?B?eFZDUlpSaHo1WXlPbzVHcE1YMGt5aGR1bmk3MC9qSzRYY05UR1lHZFp3SEVh?=
 =?utf-8?B?VUU0NmpCSmtIMWl6aUhvZXpuQ3ZMSkp5WDJuVDhJbmhTaGJSVXZIZWh1VGFC?=
 =?utf-8?B?RndVUnBneWZMbWJMdFRiR3VKV2JVYXZUNTUvYjFXNlFpSnB6d1QwaFFLMkVY?=
 =?utf-8?B?Z0pDVzJLQmorY3RTTm12cVhpTDlTRFZjK2tqdDJ4VTQxb2orVXgzZlRQNi9l?=
 =?utf-8?B?TUt1K2lmRDRTSjV3K0doNElnUi9xWUNvb1MzaWF4bTJaREpWbmtvZ2Y3cFVW?=
 =?utf-8?B?ZEVESGtZWFJEdmtLQm9rYTRKSG1XVmVVOXBnSDRPUHRrZGJsRjE0L25xWXN6?=
 =?utf-8?B?TDgrVlpUeXRlTzR2LzN4OWR0L2ZzOGZNekwwNG8xaHg4bENRWFpxYjBMMFJy?=
 =?utf-8?B?NVcxVVlaYXEvdUViQzRBS28zd0hjTFhDZldhQ2daZm1EVGNyU3J5N3lMNTJU?=
 =?utf-8?B?OEhOM2V0bWNYczVVTUFpTi9LUUZlV0tTbTRFbDRWZGRjSVBKdWlmYXI3L3RK?=
 =?utf-8?B?dlZkaXpic0FxYTZMQ3BEVXNyYTlvTkxTNE9OS08wWVM3WTcxZm1abktrcmhK?=
 =?utf-8?B?TXUyaXJLYWNON2FiQUJYYytlTWFHbFowb2EraFRMM05IWFVLclVXTVB5cCtx?=
 =?utf-8?B?bVZyU25XZHo1STcwbmNOVG1yOFlLaGhUL1hTWjI3UkxEY25uQXNrZHQvS0x5?=
 =?utf-8?B?VTRDSy9ET2Q0WGtocUZ2dENpaU1saEdhTmtBZnRBS0hhWWVBdjBaQk1wbkgy?=
 =?utf-8?B?cXVVcng3SVhoa2JYZXp3ZU9aTDlHWUFpN0NneEhRZGhwVXlUWHVSbjZyaVRz?=
 =?utf-8?B?Qms4ZUZWNHgzaWJPMWp1ak02ek1MVkRSYWRoT01SdkEyejMxcjJNRjFJL2px?=
 =?utf-8?B?dFVyWVNOY215OUtjbVEzNm1XMUc2R0QzcitFeU51SkRjbXFCNi9EMVZpU1NX?=
 =?utf-8?B?NExXZnlERVJGVitRSWlEVkt3a1kzMUpIZXpDYno0MHNsemVYWGVOZFJNcGt6?=
 =?utf-8?B?MHV5Y3lLOE9qMTVoRitaL2JCTEhVcW9tUTRLV1h1bmlGRWlad1FzV2Z6L1Q5?=
 =?utf-8?B?elZxSVpLZXhSWjFWSG1KeHlhVVBXMUI5Nys3MG9reFl2bWg0QWk1RGpHOUdR?=
 =?utf-8?B?dDVQVWU0YlNTeHpoajJ2bnlqMmNPOWxJTnNXNzhmZVhaYnZGQmJwVkFDUGF3?=
 =?utf-8?B?UHA2RFc0MVUwSXYwNVBqLzRLSko0OHRWUlhQTFdkQUVmZ0pMZUpDeHZVV1Fw?=
 =?utf-8?B?aC85SnlYWXhhVGZmZFZVSHEzT21USkpka21tRDFZWmFRZGxaS2dBcGZnd3ZR?=
 =?utf-8?B?ME45a0t1NzFuQ08zK0NEd241WiszVjF6T1ppN0NjRDA3SUd5Ymp3d3B4cFMv?=
 =?utf-8?B?WXZrajJMWVBTT0tUcmJNUXRwUURTTjFQN1VEZVlyTklZSHVqdnNQcVNOcFhF?=
 =?utf-8?B?SVJBM1JaeHFUWTNzTnNIdzVhS0JDUE5UbG1TbjFUNkhUN2VBUjRqWmZBK3Yz?=
 =?utf-8?B?aEdwR0JscUtCN1JiQnF6dHhCNkl3UFdYZFFoeUN3eFRMYWk0c3VwTkRXMGx1?=
 =?utf-8?Q?mFSdV9feX36S3dSteHBnjrYsP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5830.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23cf477-409d-47bb-96fc-08db3b4a743a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 11:38:36.6555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qb7EWQkQpSQCjNTnyeE9MqPedmFyAnAEbCMB5/PRSEXfCDYFk4HuSOFxHPUT6ViOjsX7ljHsP2S12c9zcsSSR2crR5DI3oeSgj4v7XI+/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6504
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1cnNkYXksIE1hcmNoIDIzLCAyMDIzIDEyOjAxIEFNLCBKZXNwZXIgRGFuZ2FhcmQgQnJv
dWVyIDxicm91ZXJAcmVkaGF0LmNvbT4gd3JvdGU6DQo+V2hlbiBmdW5jdGlvbiBpZ2NfcnhfaGFz
aCgpIHdhcyBpbnRyb2R1Y2VkIGluIHY0LjIwIHZpYSBjb21taXQgMDUwN2VmOGEwMzcyDQo+KCJp
Z2M6IEFkZCB0cmFuc21pdCBhbmQgcmVjZWl2ZSBmYXN0cGF0aCBhbmQgaW50ZXJydXB0IGhhbmRs
ZXJzIiksIHRoZSBoYXJkd2FyZQ0KPndhc24ndCBjb25maWd1cmVkIHRvIHByb3ZpZGUgUlNTIGhh
c2gsIHRodXMgaXQgbWFkZSBzZW5zZSB0byBub3QgZW5hYmxlDQo+bmV0X2RldmljZSBORVRJRl9G
X1JYSEFTSCBmZWF0dXJlIGJpdC4NCj4NCj5UaGUgTklDIGhhcmR3YXJlIHdhcyBjb25maWd1cmVk
IHRvIGVuYWJsZSBSU1MgaGFzaCBpbmZvIGluIHY1LjIgdmlhIGNvbW1pdA0KPjIxMjFjMjcxMmY4
MiAoImlnYzogQWRkIG11bHRpcGxlIHJlY2VpdmUgcXVldWVzIGNvbnRyb2wgc3VwcG9ydGluZyIp
LCBidXQgZm9yZ290DQo+dG8gc2V0IHRoZSBORVRJRl9GX1JYSEFTSCBmZWF0dXJlIGJpdC4NCj4N
Cj5UaGUgb3JpZ2luYWwgaW1wbGVtZW50YXRpb24gb2YgaWdjX3J4X2hhc2goKSBkaWRuJ3QgZXh0
cmFjdCB0aGUgYXNzb2NpYXRlZA0KPnBrdF9oYXNoX3R5cGUsIGJ1dCBzdGF0aWNhbGx5IHNldCBQ
S1RfSEFTSF9UWVBFX0wzLiBUaGUgbGFyZ2VzdCBwb3J0aW9ucyBvZiB0aGlzDQo+cGF0Y2ggYXJl
IGFib3V0IGV4dHJhY3RpbmcgdGhlIFJTUyBUeXBlIGZyb20gdGhlIGhhcmR3YXJlIGFuZCBtYXBw
aW5nIHRoaXMgdG8NCj5lbnVtIHBrdF9oYXNoX3R5cGVzLiBUaGlzIHdhcyBiYXNlZCBvbiBGb3h2
aWxsZSBpMjI1IHNvZnR3YXJlIHVzZXIgbWFudWFsIHJldi0NCj4xLjMuMSBhbmQgdGVzdGVkIG9u
IEludGVsIEV0aGVybmV0IENvbnRyb2xsZXIgSTIyNS1MTSAocmV2IDAzKS4NCj4NCj5Gb3IgVURQ
IGl0J3Mgd29ydGggbm90aW5nIHRoYXQgUlNTICh0eXBlKSBoYXNoaW5nIGhhdmUgYmVlbiBkaXNh
YmxlZCBib3RoIGZvcg0KPklQdjQgYW5kIElQdjYgKHNlZSBJR0NfTVJRQ19SU1NfRklFTERfSVBW
NF9VRFAgKw0KPklHQ19NUlFDX1JTU19GSUVMRF9JUFY2X1VEUCkgYmVjYXVzZSBoYXJkd2FyZSBS
U1MgZG9lc24ndCBoYW5kbGUNCj5mcmFnbWVudGVkIHBrdHMgd2VsbCB3aGVuIGVuYWJsZWQgKGNh
biBjYXVzZSBvdXQtb2Ytb3JkZXIpLiBUaGlzIHJlc3VsdHMgaW4NCj5QS1RfSEFTSF9UWVBFX0wz
IGZvciBVRFAgcGFja2V0cywgYW5kIGhhc2ggdmFsdWUgZG9lc24ndCBpbmNsdWRlIFVEUCBwb3J0
DQo+bnVtYmVycy4gTm90IGJlaW5nIFBLVF9IQVNIX1RZUEVfTDQsIGhhdmUgdGhlIGVmZmVjdCB0
aGF0IG5ldHN0YWNrIHdpbGwgZG8gYQ0KPnNvZnR3YXJlIGJhc2VkIGhhc2ggY2FsYyBjYWxsaW5n
IGludG8gZmxvd19kaXNzZWN0LCBidXQgb25seSB3aGVuIGNvZGUgY2FsbHMNCj5za2JfZ2V0X2hh
c2goKSwgd2hpY2ggZG9lc24ndCBuZWNlc3NhcnkgaGFwcGVuIGZvciBsb2NhbCBkZWxpdmVyeS4N
Cj4NCj5GaXhlczogMjEyMWMyNzEyZjgyICgiaWdjOiBBZGQgbXVsdGlwbGUgcmVjZWl2ZSBxdWV1
ZXMgY29udHJvbCBzdXBwb3J0aW5nIikNCj5TaWduZWQtb2ZmLWJ5OiBKZXNwZXIgRGFuZ2FhcmQg
QnJvdWVyIDxicm91ZXJAcmVkaGF0LmNvbT4NCj4tLS0NCj4gZHJpdmVycy9uZXQvZXRoZXJuZXQv
aW50ZWwvaWdjL2lnYy5oICAgICAgfCAgIDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2NfbWFpbi5jIHwgICAzMSArKysrKysr
KysrKysrKysrKysrKysrKysrLS0tDQo+LQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDU1IGluc2VydGlv
bnMoKyksIDQgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2V0aGVy
bmV0L2ludGVsL2lnYy9pZ2MuaA0KPmIvZHJpdmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2ln
Yy5oDQo+aW5kZXggZGYzZTI2YzBjZjAxLi5mODNjYmM0YTFhZmEgMTAwNjQ0DQo+LS0tIGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+KysrIGIvZHJpdmVycy9uZXQvZXRo
ZXJuZXQvaW50ZWwvaWdjL2lnYy5oDQo+QEAgLTEzLDYgKzEzLDcgQEANCj4gI2luY2x1ZGUgPGxp
bnV4L3B0cF9jbG9ja19rZXJuZWwuaD4NCj4gI2luY2x1ZGUgPGxpbnV4L3RpbWVjb3VudGVyLmg+
DQo+ICNpbmNsdWRlIDxsaW51eC9uZXRfdHN0YW1wLmg+DQo+KyNpbmNsdWRlIDxsaW51eC9iaXRm
aWVsZC5oPg0KPg0KPiAjaW5jbHVkZSAiaWdjX2h3LmgiDQo+DQo+QEAgLTMxMSw2ICszMTIsMzMg
QEAgZXh0ZXJuIGNoYXIgaWdjX2RyaXZlcl9uYW1lW107DQo+ICNkZWZpbmUgSUdDX01SUUNfUlNT
X0ZJRUxEX0lQVjRfVURQCTB4MDA0MDAwMDANCj4gI2RlZmluZSBJR0NfTVJRQ19SU1NfRklFTERf
SVBWNl9VRFAJMHgwMDgwMDAwMA0KPg0KPisvKiBSWC1kZXNjIFdyaXRlLUJhY2sgZm9ybWF0IFJT
UyBUeXBlJ3MgKi8gZW51bSBpZ2NfcnNzX3R5cGVfbnVtIHsNCj4rCUlHQ19SU1NfVFlQRV9OT19I
QVNICQk9IDAsDQo+KwlJR0NfUlNTX1RZUEVfSEFTSF9UQ1BfSVBWNAk9IDEsDQo+KwlJR0NfUlNT
X1RZUEVfSEFTSF9JUFY0CQk9IDIsDQo+KwlJR0NfUlNTX1RZUEVfSEFTSF9UQ1BfSVBWNgk9IDMs
DQo+KwlJR0NfUlNTX1RZUEVfSEFTSF9JUFY2X0VYCT0gNCwNCj4rCUlHQ19SU1NfVFlQRV9IQVNI
X0lQVjYJCT0gNSwNCj4rCUlHQ19SU1NfVFlQRV9IQVNIX1RDUF9JUFY2X0VYCT0gNiwNCj4rCUlH
Q19SU1NfVFlQRV9IQVNIX1VEUF9JUFY0CT0gNywNCj4rCUlHQ19SU1NfVFlQRV9IQVNIX1VEUF9J
UFY2CT0gOCwNCj4rCUlHQ19SU1NfVFlQRV9IQVNIX1VEUF9JUFY2X0VYCT0gOSwNCj4rCUlHQ19S
U1NfVFlQRV9NQVgJCT0gMTAsDQo+K307DQo+KyNkZWZpbmUgSUdDX1JTU19UWVBFX01BWF9UQUJM
RQkJMTYNCj4rI2RlZmluZSBJR0NfUlNTX1RZUEVfTUFTSwkJR0VOTUFTSygzLDApIC8qIDQtYml0
cyAoMzowKSA9IG1hc2sNCj4weDBGICovDQo+Kw0KPisvKiBpZ2NfcnNzX3R5cGUgLSBSeCBkZXNj
cmlwdG9yIFJTUyB0eXBlIGZpZWxkICovIHN0YXRpYyBpbmxpbmUgdTMyDQo+K2lnY19yc3NfdHlw
ZShjb25zdCB1bmlvbiBpZ2NfYWR2X3J4X2Rlc2MgKnJ4X2Rlc2MpIHsNCj4rCS8qIFJTUyBUeXBl
IDQtYml0cyAoMzowKSBudW1iZXI6IDAtOSAoYWJvdmUgOSBpcyByZXNlcnZlZCkNCj4rCSAqIEFj
Y2Vzc2luZyB0aGUgc2FtZSBiaXRzIHZpYSB1MTYgKHdiLmxvd2VyLmxvX2R3b3JkLmhzX3Jzcy5w
a3RfaW5mbykNCj4rCSAqIGlzIHNsaWdodGx5IHNsb3dlciB0aGFuIHZpYSB1MzIgKHdiLmxvd2Vy
LmxvX2R3b3JkLmRhdGEpDQo+KwkgKi8NCj4rCXJldHVybiBsZTMyX2dldF9iaXRzKHJ4X2Rlc2Mt
PndiLmxvd2VyLmxvX2R3b3JkLmRhdGEsDQo+K0lHQ19SU1NfVFlQRV9NQVNLKTsgfQ0KPisNCj4g
LyogSW50ZXJydXB0IGRlZmluZXMgKi8NCj4gI2RlZmluZSBJR0NfU1RBUlRfSVRSCQkJNjQ4IC8q
IH42MDAwIGludHMvc2VjICovDQo+ICNkZWZpbmUgSUdDXzRLX0lUUgkJCTk4MA0KPmRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYw0KPmIvZHJpdmVy
cy9uZXQvZXRoZXJuZXQvaW50ZWwvaWdjL2lnY19tYWluLmMNCj5pbmRleCAyOTI4YTZjNzM2OTIu
LmY2YTU0ZmVlYzAxMSAxMDA2NDQNCj4tLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9p
Z2MvaWdjX21haW4uYw0KPisrKyBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2lnYy9pZ2Nf
bWFpbi5jDQo+QEAgLTE2NzcsMTQgKzE2NzcsMzYgQEAgc3RhdGljIHZvaWQgaWdjX3J4X2NoZWNr
c3VtKHN0cnVjdCBpZ2NfcmluZyAqcmluZywNCj4gCQkgICBsZTMyX3RvX2NwdShyeF9kZXNjLT53
Yi51cHBlci5zdGF0dXNfZXJyb3IpKTsNCj4gfQ0KPg0KPisvKiBNYXBwaW5nIEhXIFJTUyBUeXBl
IHRvIGVudW0gcGt0X2hhc2hfdHlwZXMgKi8NCj4rZW51bSBwa3RfaGFzaF90eXBlcyBpZ2NfcnNz
X3R5cGVfdGFibGVbSUdDX1JTU19UWVBFX01BWF9UQUJMRV0gPSB7DQoNCkhpIEplc3BlciwNCg0K
U2luY2UgaWdjX3Jzc190eXBlX3RhYmxlIGlzIHVzZWQgb24gaWdjX21haW4uYyBvbmx5LCB3ZSBj
YW4gbWFrZSBpdCBzdGF0aWMgdG8NCmF2b2lkIGZvbGxvd2luZyBidWlsZCB3YXJuaW5nOg0KDQpk
cml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2MvaWdjX21haW4uYzoxNjgxOjIxOiB3YXJuaW5n
OiBzeW1ib2wNCidpZ2NfcnNzX3R5cGVfdGFibGUnIHdhcyBub3QgZGVjbGFyZWQuIFNob3VsZCBp
dCBiZSBzdGF0aWM/DQoNClRoYW5rcyAmIFJlZ2FyZHMNClNpYW5nDQoNCj4rCVtJR0NfUlNTX1RZ
UEVfTk9fSEFTSF0JCT0gUEtUX0hBU0hfVFlQRV9MMiwNCj4rCVtJR0NfUlNTX1RZUEVfSEFTSF9U
Q1BfSVBWNF0JPSBQS1RfSEFTSF9UWVBFX0w0LA0KPisJW0lHQ19SU1NfVFlQRV9IQVNIX0lQVjRd
CT0gUEtUX0hBU0hfVFlQRV9MMywNCj4rCVtJR0NfUlNTX1RZUEVfSEFTSF9UQ1BfSVBWNl0JPSBQ
S1RfSEFTSF9UWVBFX0w0LA0KPisJW0lHQ19SU1NfVFlQRV9IQVNIX0lQVjZfRVhdCT0gUEtUX0hB
U0hfVFlQRV9MMywNCj4rCVtJR0NfUlNTX1RZUEVfSEFTSF9JUFY2XQk9IFBLVF9IQVNIX1RZUEVf
TDMsDQo+KwlbSUdDX1JTU19UWVBFX0hBU0hfVENQX0lQVjZfRVhdID0gUEtUX0hBU0hfVFlQRV9M
NCwNCj4rCVtJR0NfUlNTX1RZUEVfSEFTSF9VRFBfSVBWNF0JPSBQS1RfSEFTSF9UWVBFX0w0LA0K
PisJW0lHQ19SU1NfVFlQRV9IQVNIX1VEUF9JUFY2XQk9IFBLVF9IQVNIX1RZUEVfTDQsDQo+Kwlb
SUdDX1JTU19UWVBFX0hBU0hfVURQX0lQVjZfRVhdID0gUEtUX0hBU0hfVFlQRV9MNCwNCj4rCVsx
MF0gPSBQS1RfSEFTSF9UWVBFX05PTkUsIC8qIFJTUyBUeXBlIGFib3ZlIDkgIlJlc2VydmVkIiBi
eSBIVw0KPiovDQo+KwlbMTFdID0gUEtUX0hBU0hfVFlQRV9OT05FLCAvKiBrZWVwIGFycmF5IHNp
emVkIGZvciBTVyBiaXQtbWFzayAgICovDQo+KwlbMTJdID0gUEtUX0hBU0hfVFlQRV9OT05FLCAv
KiB0byBoYW5kbGUgZnV0dXJlIEhXIHJldmlzb25zICAgICAgICovDQo+KwlbMTNdID0gUEtUX0hB
U0hfVFlQRV9OT05FLA0KPisJWzE0XSA9IFBLVF9IQVNIX1RZUEVfTk9ORSwNCj4rCVsxNV0gPSBQ
S1RfSEFTSF9UWVBFX05PTkUsDQo+K307DQo+Kw0KPiBzdGF0aWMgaW5saW5lIHZvaWQgaWdjX3J4
X2hhc2goc3RydWN0IGlnY19yaW5nICpyaW5nLA0KPiAJCQkgICAgICAgdW5pb24gaWdjX2Fkdl9y
eF9kZXNjICpyeF9kZXNjLA0KPiAJCQkgICAgICAgc3RydWN0IHNrX2J1ZmYgKnNrYikNCj4gew0K
Pi0JaWYgKHJpbmctPm5ldGRldi0+ZmVhdHVyZXMgJiBORVRJRl9GX1JYSEFTSCkNCj4tCQlza2Jf
c2V0X2hhc2goc2tiLA0KPi0JCQkgICAgIGxlMzJfdG9fY3B1KHJ4X2Rlc2MtPndiLmxvd2VyLmhp
X2R3b3JkLnJzcyksDQo+LQkJCSAgICAgUEtUX0hBU0hfVFlQRV9MMyk7DQo+KwlpZiAocmluZy0+
bmV0ZGV2LT5mZWF0dXJlcyAmIE5FVElGX0ZfUlhIQVNIKSB7DQo+KwkJdTMyIHJzc19oYXNoID0g
bGUzMl90b19jcHUocnhfZGVzYy0+d2IubG93ZXIuaGlfZHdvcmQucnNzKTsNCj4rCQl1MzIgcnNz
X3R5cGUgPSBpZ2NfcnNzX3R5cGUocnhfZGVzYyk7DQo+Kw0KPisJCXNrYl9zZXRfaGFzaChza2Is
IHJzc19oYXNoLCBpZ2NfcnNzX3R5cGVfdGFibGVbcnNzX3R5cGVdKTsNCj4rCX0NCj4gfQ0KPg0K
PiBzdGF0aWMgdm9pZCBpZ2NfcnhfdmxhbihzdHJ1Y3QgaWdjX3JpbmcgKnJ4X3JpbmcsIEBAIC02
NTQzLDYgKzY1NjUsNyBAQCBzdGF0aWMNCj5pbnQgaWdjX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpw
ZGV2LA0KPiAJbmV0ZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1RTTzsNCj4gCW5ldGRldi0+ZmVh
dHVyZXMgfD0gTkVUSUZfRl9UU082Ow0KPiAJbmV0ZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1RT
T19FQ047DQo+KwluZXRkZXYtPmZlYXR1cmVzIHw9IE5FVElGX0ZfUlhIQVNIOw0KPiAJbmV0ZGV2
LT5mZWF0dXJlcyB8PSBORVRJRl9GX1JYQ1NVTTsNCj4gCW5ldGRldi0+ZmVhdHVyZXMgfD0gTkVU
SUZfRl9IV19DU1VNOw0KPiAJbmV0ZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1NDVFBfQ1JDOw0K
Pg0KDQo=
