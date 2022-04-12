Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76EB4FE6C7
	for <lists+bpf@lfdr.de>; Tue, 12 Apr 2022 19:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358102AbiDLR0a (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Apr 2022 13:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350483AbiDLR01 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Apr 2022 13:26:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B59EBF50;
        Tue, 12 Apr 2022 10:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649784248; x=1681320248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rPAAScnpuTCPsXkew+slRL3DHN03HE4jRHtE9XwvwiI=;
  b=a2SY3iRPPYyjNWhfikfN+rLDIETKHf89iTBDwBglcae2QT0QSKtbhTOl
   loWCmHK8kUv+rWsS/IjYGt1GCA/JAxMx7KYJKK4wDArpg6hbx2S/WB19X
   WSkQ4HJwnVRUfrPCU/ZNuirVWwBNyIZuxqcJaWP4eNA3ymRKArLfC3l0K
   2Tc1p23CpWpOrpFyZacXU3K99mOckA7S4Dv0RtYuCwx8C2tMvzr5RRLwM
   DJ2m6noCQgG0n9UhcR6Uj/eSOuu+hk+ea0zdxYH10v8vq/p99SGncho8L
   38kLRhanNJwwcbhV/IllCuycgqyX0dddsTDRj6WxEIF3IKlFFZOh7XrvM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="287468253"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="287468253"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 10:21:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="644831695"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2022 10:21:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 12 Apr 2022 10:20:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 12 Apr 2022 10:20:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 12 Apr 2022 10:20:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T46Pv4+DiPPQUGHtLRc7IIajuz84zFbdQdk5ER06o4BZO67rmYEsBZ/3e3A9uLywRmJ61Ol7DdPmmzpzebHvsEbUUH4JrViXrFsUU8i+CFBuhbQbu3LTKX7o1jgTTs9HT33ioHPCk8jIRC5Csq43Ib+w3KBlmaDQoROsrXY5evRzuK969mVclzyhP4mKj230M/WV0x2cMlJPQQhml4VLgqiuwdv9wivWjPmOPJX7nxJy3cUDX+30c/EFzz1A1Z82ewsB54vZTcTX7/stjhP79MYyrib4ZLlpjWm0pm0Bt+pht1Dpd6nw79tjrGSaGLmcVyv6EVn03SCVyzi0ft+U4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rPAAScnpuTCPsXkew+slRL3DHN03HE4jRHtE9XwvwiI=;
 b=E65yAy8BZNesqTiiEhE5IeNN9fn1u5eVFTVMREqsNNSEbTsR9BLWxrlfsqWrVBB6ObYOeHz464P3pagZ8+3Mu0WBXKOmZ3K4V6eFysORvStSOOowrPaeZKK8EVwnxvkICMuUDU5J/Dvr+MGwTqOjccl4fMkeBPSIiXYfZYm9PANKUB9zeVfb9lMmfiiJUp+oumklJOga/jcswf5ufLCImHVO6YFP10mDmOplUjlhvKZkZHP197MZnUlIdzw3yM7IjGeUcKpDAb1+YfVXGRhh8R8S3mcwAqIwSdg0NrtIkJkVRYvIjkrB3ScVBJjY60py/ZHYD2yMBHrxtWxTO9AbEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by SN6PR11MB2686.namprd11.prod.outlook.com (2603:10b6:805:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 17:20:56 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::69:f7e:5f37:240b%3]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 17:20:56 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "song@kernel.org" <song@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
Subject: Re: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for
 bpf_prog_pack
Thread-Topic: [PATCH v2 bpf 3/3] bpf: use vmalloc with VM_ALLOW_HUGE_VMAP for
 bpf_prog_pack
Thread-Index: AQHYTf2qaLgPk3a2NEqtdWyicAiNHqzsh1qA
Date:   Tue, 12 Apr 2022 17:20:56 +0000
Message-ID: <0e8047d07def02db8ef33836ee37de616660045c.camel@intel.com>
References: <20220411233549.740157-1-song@kernel.org>
         <20220411233549.740157-5-song@kernel.org>
In-Reply-To: <20220411233549.740157-5-song@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecd6ea66-fb44-48ad-f66c-08da1ca8cdfe
x-ms-traffictypediagnostic: SN6PR11MB2686:EE_
x-microsoft-antispam-prvs: <SN6PR11MB2686553F456263104282DC1EC9ED9@SN6PR11MB2686.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlVbUmXr+SmWAAG/juL0Bwu9YhG7+5hSub3i/qCp4GMDYKtrYqVgXIYoL3FUU6i2govDYCJdcya6WXj74omEYcsJU8Q1ujNEPrTk83Jn9m6hKvdslok5IK4AKWSp2tcaQB06Cp6Jdmh3MvcHCAJRIwa2oov6IylEsGt9MeN5Od5dzbOOyDGr3pmkhQQGN1y3FSBOsHYKAhp7xTS33+ivI3uTRJ/T4zbYA8P4d0r0WwiV2jX5AQmjS3KnZf4GnH6Bdyla+WD9T1/4KdJeczb8xaUsv79Wf0dNhSN7ajqJJ/K+YHtLtv5ymOri0rhgZewBcGcQFN9O6zJg1/ieaZqJtJDPfYesXtxYELJZSDHmK/X0lcs8QJJJ24uiatBex/aQs5CgvKacTPkQsbCXP9enbj1CK0/y1vjn+zYuJ4s/xryMgFe7MTwVksZgFuZxKRZWgvAR5NlkQm6qIcTJ015zYLPvk7Vjw2eNAqlQGJk4F84fudWQjrBprCpG0Oej8P8D6J7vfcG18Dkjl8i4RPY90xdEdOcn73Hb+FeZlrSnxSrtcNyG2HEeSKeZidK04p7zL5SoFM2Fmd0nBKTikC7gu6znQBcZR0ksdRozElHfui1e/Tkf7+T3sV9VWXjwTERb2gmpUK/FNAGjFIMDmhasdubbqObU1vMMDNTR3wrZqfzvql8APiDZJ90jhbBkQvv/H4879L4pNGBakEFMs1XChz56gdBYR2JDmIl7Z7cCBehU2sr5/MJ0qtrNSLnAyfstkKgHdPPMW9mF/P7J7w8pSv4NB8ujML5cB7eTng/jX9bADk1IRPfBHOXvsxYZC9q6hS4DMOcI/8ZNB0kN2G3OYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(66476007)(8936002)(7416002)(71200400001)(5660300002)(91956017)(83380400001)(508600001)(122000001)(38070700005)(2616005)(6512007)(186003)(6506007)(26005)(66556008)(38100700002)(966005)(36756003)(66946007)(76116006)(54906003)(110136005)(2906002)(64756008)(66446008)(4326008)(8676002)(82960400001)(316002)(86362001)(99106002)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bm5udFFiaWVGS0cvbXlnUmpXTlkvTGxaQVoxeUZwTFdUeWJXYU5qTTZSMytv?=
 =?utf-8?B?NEZHS3JrRHY3NFZleHdOUUZEdHpFSFVnTUVVa2dXQzB4VkhYRlJVTUNYNHVp?=
 =?utf-8?B?UXpXL01rdVUzZnViR1cvV21ud3owbDJlQVFNcTNVK29MalkvQkJsZk54Z1pG?=
 =?utf-8?B?cWFjZ2lzYjJiOEs4M0Nuanp6b0dXbzVoMFAyekhKZ3R2R3ZqQklpUndDMlpW?=
 =?utf-8?B?ODFPUHB1c0c3cTduclI3VG1icGs3S2Z5QTJjRWpSYld6NTYyNVlIYXZtM2dD?=
 =?utf-8?B?d1BScWk5cmwwS1hnbHVyUC9oUlZFRjZOSitHTHFFZXk1Mm4yTi9FL1Zxbk9E?=
 =?utf-8?B?UFBtQjN5SFpNeTZiMEhBYlhzcGgvSmQ5YUZTcVlzSkIrSFZucFRxZnFGQTEy?=
 =?utf-8?B?OFlkR1JHcEZhWkUyek8ycnk4ZjJXcGZidVViSW5RTGlIQkxFMzRpVll6WmxU?=
 =?utf-8?B?LzJNMmM4T2pnKzM4MzlFQU4xdkxVV1NPMnByR1NhMUd5UGJHbTNITkJ3eHd0?=
 =?utf-8?B?WTYxWEZGKzVkYkUxYTIxV0pSbmhWZ1J6eUVBNTMwZ0w3QjY0Wi94OEtEUnpN?=
 =?utf-8?B?MzlIMWExVXZDTEx0WWVUQ0NiOUROVVVDblNKMldVVUlPNkpYMDZhbStmU3dQ?=
 =?utf-8?B?bTVvNUE0dDVHUFZ2VVdQS2F1RmFLVlFxQS9uZmNzVHlQT2ZEaGtmU0xsR1Q2?=
 =?utf-8?B?Z2dWdWV2NjJYM1laZHQyVzBJSW5LdzUyZ3JEaithb2VpUjRJcVh3d3o5MEZj?=
 =?utf-8?B?WTJDM3IvSGpUVnBzZ0tuWTRZNXFBV2xhbWJFcW5MT2ZOZ1dhOWhhQ2ZCUFJF?=
 =?utf-8?B?YkhxaUJENTdSTEZhTjdvWTl5Y28vUDRieHNOQ3FYOFJmeHpEZUVzdVdyZ05w?=
 =?utf-8?B?V3BsSzlocS8xVk5GY3hLZWpGd3VWcjlFR2JBOUQ4YlBBMVFROXArUHExTUh5?=
 =?utf-8?B?cCtwNUtzeHFhM3VqSmlUTG0rWk12YlJ3L2hIbGc2ODJxaHl6ekgrbEx4RXhx?=
 =?utf-8?B?UUtpZ3JMYXRBaS8xL2pGRUxOTlU3QnEvV1JjK3VRKzhHL1FuRmJKTXB4WXNR?=
 =?utf-8?B?QUJ1dEtKMGZjclNjWFEyS0JoaE0zWUozWnhPK1N0Q3lKZmtacXdNdW1Mb091?=
 =?utf-8?B?akVoQzd4S2NpYkU2bEFIQWFhR1RzZXFIM0tPTGdMMmZ5cWM1NjUzZHlxTTk2?=
 =?utf-8?B?ZldNc1Iwb2RIMkNWV0tqY2xZUVprbzVLelRreW8vOG1vTzg1dUp3T1lWUkdY?=
 =?utf-8?B?RnBRcHEzY0IvM3FIUm1nSFU2TXhPVTF4Zk5oYkNaVWx0QzhPL2tXK00xVWVJ?=
 =?utf-8?B?NXNqd2owZWFsSTdxNG1TaG1SZU9sdk1kZVdwNlJyWmZoanRYTWZPcGJjV215?=
 =?utf-8?B?dlM3RmVpU3krSVVSTmxUejdTbHhQYW8vYk11d2pKcHBDQ0xjZ1VvcVFaS1V1?=
 =?utf-8?B?UmxZRGRhTzFCSkdqZ0YzcGw0RWkyWEVvNW02RnFwRytxK2Rod2M3L3lTMXh0?=
 =?utf-8?B?dW9EUzVNeVVHaHZySmpLcUgwTEY5dk1TbjhRVkE0N1IvQVFnaUVJWkNsRXRr?=
 =?utf-8?B?Z0crR0cxOCtFRDgrVU9BdDR1b1lxY29BZDVNWHhPZG5KMm1LZ0lUVEx4TlI0?=
 =?utf-8?B?enBSTWpJK0ZwTGVpcWwyRllWNGFlaHQ4M0VEcFhzdDA3Q0twSng2R2RvaytL?=
 =?utf-8?B?ZmkvWG5iQlQ5eEc0ajZLbzFpRmJUZmVTZG5EQTVqN1hpdTNpZGpMblNIM3ZZ?=
 =?utf-8?B?aUg5SStGUlplY1g5bHdOSDJYekdGY0tkT1RQNVhSaS9tUS96TGpvVUg2aUpJ?=
 =?utf-8?B?TXEvTHJjelNqZ25KQkNZZFk4dHU4SGhSK05TZkswaHIxbFRxNURhdE9HbFdY?=
 =?utf-8?B?UzdyU2lLUTQzYzBadzJpWlI3NzBxNzZZTjU5SEJYTDRDT3B2Nm11NnEwUkFz?=
 =?utf-8?B?K1BvcTY1ZE85c0FCUDV2LzRmSFZyNU5GVXJtM0lkaSsydVozQlkzbGx5aGVo?=
 =?utf-8?B?b2ZFeUFEWEd3QTJKQVZZM2RUZHZiSHlQT3NIUC9jMkFzSkEzaTVLaEhSSVJk?=
 =?utf-8?B?QlpidzVhWGVyRGJXZWY2Tzg2TnVETEdySUh6R0J1ckhNSmZ2TmR3anBlT3pq?=
 =?utf-8?B?UHpLaWhnZ21EejR2bVYrWnFQbFNiRlE5NUt5L01NcVkwZFBaUk5JOE11bVY2?=
 =?utf-8?B?RHZvU0dDQmpRRUUzRVorRXVnMVh1aU1EK1U4UWJnZGJuQU1VVTJzZHVQeGp6?=
 =?utf-8?B?Rm9YL0tScTgrQXdnZWdLc002K2ZWT09oM25lUzBvSXQxWUJsTFlhWHpjdlRY?=
 =?utf-8?B?ME9CZzB2SkllTGduRXNJZFJhV2ZHMDllOUk2SVZCTlUyN1N5M1V6VjYxZlJi?=
 =?utf-8?Q?Nca5cRhJrD+A5Nv3UIXhMSVF9gYR/H7gZZf4w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E1D73EE0A1595499F1CE197069B3A50@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd6ea66-fb44-48ad-f66c-08da1ca8cdfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2022 17:20:56.1999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XX7g4OAiB44fSn9WtwkmdUm+MT+SFIod+c1AX04OHRtKt3Mcdv8EZ35KyQWjlFNIvCbXb4+AVa4Fbz3F/m9m+xNMMo4oWDDmlJeUkR4vTkw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2686
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTA0LTExIGF0IDE2OjM1IC0wNzAwLCBTb25nIExpdSB3cm90ZToNCj4gQEAg
LTg4OSw3ICs4ODksNiBAQCBzdGF0aWMgc3RydWN0IGJwZl9wcm9nX3BhY2sgKmFsbG9jX25ld19w
YWNrKHZvaWQpDQo+ICAgICAgICAgYml0bWFwX3plcm8ocGFjay0+Yml0bWFwLCBicGZfcHJvZ19w
YWNrX3NpemUgLw0KPiBCUEZfUFJPR19DSFVOS19TSVpFKTsNCj4gICAgICAgICBsaXN0X2FkZF90
YWlsKCZwYWNrLT5saXN0LCAmcGFja19saXN0KTsNCj4gIA0KPiAtICAgICAgIHNldF92bV9mbHVz
aF9yZXNldF9wZXJtcyhwYWNrLT5wdHIpOw0KPiAgICAgICAgIHNldF9tZW1vcnlfcm8oKHVuc2ln
bmVkIGxvbmcpcGFjay0+cHRyLCBicGZfcHJvZ19wYWNrX3NpemUgLw0KPiBQQUdFX1NJWkUpOw0K
PiAgICAgICAgIHNldF9tZW1vcnlfeCgodW5zaWduZWQgbG9uZylwYWNrLT5wdHIsIGJwZl9wcm9n
X3BhY2tfc2l6ZSAvDQo+IFBBR0VfU0laRSk7DQo+ICAgICAgICAgcmV0dXJuIHBhY2s7DQoNCkRy
b3BwaW5nIHNldF92bV9mbHVzaF9yZXNldF9wZXJtcygpIGlzIG5vdCBtZW50aW9uZWQgaW4gdGhl
IGNvbW1pdCBsb2cuDQpJdCBpcyBraW5kIG9mIGEgZml4IGZvciBhIGRpZmZlcmVudCBpc3N1ZS4N
Cg0KTm93IHRoYXQgeDg2IHN1cHBvcnRzIHZtYWxsb2MgaHVnZSBwYWdlcywgYnV0IFZNX0ZMVVNI
X1JFU0VUX1BFUk1TIGRvZXMNCm5vdCB3b3JrIHdpdGggdGhlbSwgd2Ugc2hvdWxkIGhhdmUgc29t
ZSBjb21tZW50cyBvciB3YXJuaW5ncyB0byB0aGF0DQplZmZlY3Qgc29tZXdoZXJlLiBTb21lb25l
IG1heSB0cnkgdG8gcGFzcyB0aGUgZmxhZ3MgaW4gdG9nZXRoZXIuDQoNCj4gQEAgLTk3MCw3ICs5
NjksOSBAQCBzdGF0aWMgdm9pZCBicGZfcHJvZ19wYWNrX2ZyZWUoc3RydWN0DQo+IGJwZl9iaW5h
cnlfaGVhZGVyICpoZHIpDQo+ICAgICAgICAgaWYgKGJpdG1hcF9maW5kX25leHRfemVyb19hcmVh
KHBhY2stPmJpdG1hcCwNCj4gYnBmX3Byb2dfY2h1bmtfY291bnQoKSwgMCwNCj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnBmX3Byb2dfY2h1bmtfY291bnQoKSwgMCkg
PT0NCj4gMCkgew0KPiAgICAgICAgICAgICAgICAgbGlzdF9kZWwoJnBhY2stPmxpc3QpOw0KPiAt
ICAgICAgICAgICAgICAgbW9kdWxlX21lbWZyZWUocGFjay0+cHRyKTsNCg0KDQo+ICsgICAgICAg
ICAgICAgICBzZXRfbWVtb3J5X254KCh1bnNpZ25lZCBsb25nKXBhY2stPnB0ciwNCj4gYnBmX3By
b2dfcGFja19zaXplIC8gUEFHRV9TSVpFKTsNCj4gKyAgICAgICAgICAgICAgIHNldF9tZW1vcnlf
cncoKHVuc2lnbmVkIGxvbmcpcGFjay0+cHRyLA0KPiBicGZfcHJvZ19wYWNrX3NpemUgLyBQQUdF
X1NJWkUpOw0KPiArICAgICAgICAgICAgICAgdmZyZWUocGFjay0+cHRyKTsNCj4gICAgICAgICAg
ICAgICAgIGtmcmVlKHBhY2spOw0KDQpOb3cgdGhhdCBpdCBjYWxscyBtb2R1bGVfYWxsb2NfaHVn
ZSgpIGluc3RlYWQgb2Ygdm1hbGxvY19ub2RlX3JhbmdlKCksDQpzaG91bGQgaXQgY2FsbCBtb2R1
bGVfbWVtZnJlZSgpIGluc3RlYWQgb2YgdmZyZWUoKT8NCg0KDQoNClNpbmNlIHRoZXJlIGFyZSBi
dWdzLCBzaW1wbGUsIGltbWVkaWF0ZSBmaXhlcyBzZWVtIGxpa2UgdGhlIHJpZ2h0IHRoaW5nDQp0
byBkbywgYnV0IEkgaGFkIGEgY291cGxlIGxvbmcgdGVybSBmb2N1c2VkIGNvbW1lbnRzIG9uIHRo
aXMgbmV3DQpmZWF0dXJlOg0KDQpJdCB3b3VsZCBiZSBuaWNlIGlmIGJwZiBhbmQgdGhlIG90aGVy
IG1vZHVsZV9hbGxvYygpIGNhbGxlcnMgY291bGQNCnNoYXJlIHRoZSBzYW1lIGxhcmdlIHBhZ2Vz
LiBNZWFuaW5nLCB1bHRpbWF0ZWx5IHRoYXQgdGhpcyB3aG9sZSB0aGluZw0Kc2hvdWxkIHByb2Jh
Ymx5IGxpdmUgb3V0c2lkZSBvZiBicGYuIEJQRiB0cmFjaW5nIHVzYWdlcyBtaWdodCBiZW5lZml0
DQpmb3IgZXhhbXBsZSwgYW5kIGtwcm9iZXMgYW5kIGZ0cmFjZSBhcmUgbm90IHRvbyBkaWZmZXJl
bnQgdGhhbiBicGYNCnByb2dzIGZyb20gYSB0ZXh0IGFsbG9jYXRpb24gcGVyc3BlY3RpdmUuDQoN
CkkgYWdyZWUgdGhhdCB0aGUgbW9kdWxlJ3MgcGFydCBpcyBub24tdHJpdmlhbC4gQSB3aGlsZSBi
YWNrIEkgaGFkIHRyaWVkDQp0byBkbyBzb21ldGhpbmcgbGlrZSBicGZfcHJvZ19wYWNrKCkgdGhh
dCB3b3JrZWQgZm9yIGFsbCB0aGUNCm1vZHVsZV9hbGxvYygpIGNhbGxlcnMuIEl0IGhhZCBzb21l
IG1vZHVsZXMgY2hhbmdlcyB0byBhbGxvdyBkaWZmZXJlbnQNCnBlcm1pc3Npb25zIHRvIGdvIHRv
IGRpZmZlcmVudCBhbGxvY2F0aW9ucyBzbyB0aGV5IGNvdWxkIGJlIG1hZGUgdG8NCnNoYXJlIGxh
cmdlIHBhZ2VzOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAxMTIwMjAyNDI2
LjE4MDA5LTEtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQoNCkkgdGhvdWdodCB0aGUgZXhp
c3Rpbmcga2VybmVsIHNwZWNpYWwgcGVybWlzc2lvbiBhbGxvY2F0aW9uIG1ldGhvZHMNCndlcmUg
anVzdCB0b28gYnJpdHRsZSBhbmQgaW50ZXJ0d2luZWQgdG8gaW1wcm92ZSB3aXRob3V0IGEgbmV3
DQppbnRlcmZhY2UuIFRoZSBob3BlIHdhcyB0aGUgbmV3IGludGVyZmFjZSBjb3VsZCB3cmFwIGFs
bCB0aGUgYXJjaA0KaW50cmljYWNpZXMgaW5zdGVhZCBvZiBsZWF2aW5nIHRoZW0gZXhwb3NlZCBp
biB0aGUgY3Jvc3MtYXJjaCBjYWxsZXJzLg0KDQpJIHdvbmRlciB3aGF0IHlvdSB0aGluayBvZiB0
aGF0IGdlbmVyYWwgZGlyZWN0aW9uIG9yIGlmIHlvdSBoYXZlIGFueQ0KZm9sbG93IHVwIHBsYW5z
IGZvciB0aGlzPw0KDQo=
