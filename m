Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D127F5766B8
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 20:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiGOS20 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Jul 2022 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiGOS2Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Jul 2022 14:28:25 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5E56BC03
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:28:24 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FGHJk8023142
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:28:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Aga6+uM35dCMw02gbI/tDfyADWG5G9PZJobds9hIrYE=;
 b=ZDHwlxkwc7W5j6lPdR+I916+ZWEYc6ZceAtvxbem72Jej8u1t/BV2rurC8kj1ZoeY51Q
 g88oRC3hljRTExt6WOi/0gMMyDL7OwkljAtheOPO/Dzu8awjMTa8zeHgC8vr7xKj9TLH
 ZSbaBLgncHg9TX+LqbTOSG0fLzPGJkSTWfg= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3haktc94hv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 15 Jul 2022 11:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUWhdMwNJAq6MwTgt3MP0fVEY+hQ3+gJeWcYeY4tcSYKhPw9dkHMsQyThGIfNjIZSgE6jPBen+LwW/x4zbU8r2XPj4JxJJ1o1qR4dFc3mJbha0HaiBvKchPOJnGeLZOecLCjpiJkQxl+eaahRSo3bnMkIfYOlTzTTRyro/OZZw4Rnp/50lTKk4GdRWjmlruoWXGqnaXEnmPnn/vWuBIImiZ6j2Ot8dVIYCsQ7bC42FKGYg7Ng9Ti9oCK5kUcsWkojPZRJq+0ij+tkr/9mxBYUKtZDu7GNvcgoyN74IhrNpyxGGB7XIbWbefBP9XE0RnW/sEesXGtIp/TrMGyVMWkdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aga6+uM35dCMw02gbI/tDfyADWG5G9PZJobds9hIrYE=;
 b=AASXQ6oHYH8jVUuWsRa9JQWjqpM+DoxTE/NOvHFR4wgPV7vD5X+bPGzoxxJphyNTQhzT6Zqdh3Duh79qjqay9KNZCsN1jld9u7EDVAhSwwjvCZ+ZQvIKCGCdLUc1wALNWjU1luwhdaQ5S/T/8i18k20Snxq7bs+YWNsBID3ZxJItAYDCdGPW0IEm40sJ/0HTYHGPELan/XwtrEmrsVfE1UqFcNO0TM0dJN4qbunMoUWJecNItxTcLGQpVjfs7X+vpCcu2ZKtFDE+vK72Ip5xqzc8HN3IBpvVk0+5Mz8gZRcCtqNJlmCiI+oV2AWttAjS5L58iVeLXh8K1W6A3pNjsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BYAPR15MB3063.namprd15.prod.outlook.com (2603:10b6:a03:f6::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:28:21 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::ac52:e8fa:831f:237e%9]) with mapi id 15.20.5438.014; Fri, 15 Jul 2022
 18:28:21 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "sdf@google.com" <sdf@google.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Topic: [PATCH RFC bpf-next 0/3] Execution context callbacks
Thread-Index: AQHYlW/snznW93TcsEKe6oR5OxPAGK17CZiAgAAIg4CAA52vAIABFUCA
Date:   Fri, 15 Jul 2022 18:28:20 +0000
Message-ID: <8ee9f9d1a5218ab23655d3f0d754aa5634a71d89.camel@fb.com>
References: <cover.1657576063.git.delyank@fb.com>
         <Ys24W4RJS0BAfKzP@google.com>
         <3a6294a44dfec84b3efbdebed6a0d8d9c5874815.camel@fb.com>
         <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
In-Reply-To: <20220715015100.p7fwr7dbjyfbjjad@MacBook-Pro-3.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1dab6bb-f6d0-4a66-60e7-08da668fcbb3
x-ms-traffictypediagnostic: BYAPR15MB3063:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Pfwh/dsbw7yzlspOk6UpbT9Dq9a0kjORyO18FgB+bQNXjARJu182mB2IIMNA9IGqvR9TncdbEotvtrGAaQOIvj/XR0ggIdWTgsTbnDOV4amv7d5Hv2f/jOWk05duflSfuWwwArNarH6o2GoWwnnfgaiP0DFO2AhtTWC6pRFi9OpcHofUG5HDee4JdjFfhfxhwimvPMABEPtC1RaPbkrJuvRtK4hmp/AI0Vr/K2ska/hi6G2fTOapWJLcAm0vSczU5Of9Eyq1n0N6u1Haw1W+xK3I0MbH2cMABedHtFXha8O5HmTkOD9X4CYbU31WC07vCnKcvx6PDhpYJiS+HsmZIfWNl25bd1KQx/OwrQof2kmMoH24+bRHWDy8jOEnof8YDYlhLAwG+iqhagivPDyH1pSWtZJ8zJFXOFnHhrpTXHDALolyJFN+OWQgDf2Wjqvtr3M06n3dNKMcnq5PN8ETcTYZrygJg3CIQbhQNEb2nHwEuRSNfhYV126et7OiqXPrXXGzFS2prT/5M4uVaa2Iu4z3sWYnZ0i16LZ0wGRLIa4H/jPeDbmf2xViuOIwBU5R84VzX2tON5+uyJZZjkBw1w/w43vITs0MLgq/u+8jt3zHkHDQ8cxRvohqSmyPMTOYKkb1mnS1sQApzAQlyaBUd3N53kKCXkUPYMF9WwltgqsZ7jHmLkbeMYac4B37F+US7M+ZwvL4+w/X/sEe2Vr3FAYe416fPa3lwFLv5hJmm1eXjnnMPTmQ9fX9AC/wiQeB6XFyfAbjOYyW0Vtoc9uslt3XeIShX4TJl8Hn9LvOyg03itMhglaG+llw2Dc2k1t9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(2906002)(8936002)(316002)(66476007)(66446008)(83380400001)(76116006)(122000001)(54906003)(6916009)(36756003)(41300700001)(6506007)(8676002)(5660300002)(38100700002)(66556008)(38070700005)(4326008)(186003)(66946007)(71200400001)(478600001)(64756008)(2616005)(86362001)(6512007)(26005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ak1ocDNabEJMYTdlM3J1dzhVUzV5aGx2TUpYbnlEVTNSUVlvS3E4c2lRYm1U?=
 =?utf-8?B?SXNwb1NaSGJnY2gyckZaU2FFdzJ5S1ljT3VENWVrK1l4OTl0UXIxSCs3VmIx?=
 =?utf-8?B?Q1VKTVRSNkhhZ21hSzkxcG9teTlJeUpNYkNzRS8vNlBJcnlpd3MvMmw4dDM0?=
 =?utf-8?B?VmppRWRVTUlUb2tCM0tFRHoxKzhkenYzYUMrTHp4MEJ4eFRKZVFzeFg2aW9T?=
 =?utf-8?B?M0xqUkN0YWh5c2lNSmQ0U3BYMFRHZytzKzZkaGNxRzVxYkRuWVZ2NU9YalFh?=
 =?utf-8?B?QjVPejhNczdXUkxjOFIrK2dxU3E4UFZDVG54N2U4UGtBcklLOGZhRGxYV3h3?=
 =?utf-8?B?NTkvalFrN3BPaWt5QWoxdGM3V0RCZ2srMDRBZHM5d0E1aVg0VlRtdm9FUlBW?=
 =?utf-8?B?Vy9FcHFqV2ZlSTdJWU55MHU2aWczVkRSc1ZLVWdWenNxNiszUmlHdnRJQzl5?=
 =?utf-8?B?WGlISU1TUzBWUTZOQ3kzOFpDV1phcGcyZ2ZwVjB2UGlDeEh6Z1N1RUlWRGVR?=
 =?utf-8?B?MnQrd0gxa3lrMDRTSlhZVlA0Y3IweEtCRXF6VWxSYWNpRWVBeFM3RFZJUkpY?=
 =?utf-8?B?bzAvRXJ6enJ6OTRIZWRDVFlSNURnVzZsdndUUitUTFFHcVBXbFBDVSsydGV1?=
 =?utf-8?B?RTY0RkhZNWxXWEwvbFNyS3N4RVNIQ2RyV2pTNWYwTWFlY0tXc0czNEVyZXNB?=
 =?utf-8?B?U2VLWnhEWHVJUmlLMy8rb0lNSUd1VDZ0T3AyZnRHMC9XZ3BVTjFZbEcyNmto?=
 =?utf-8?B?NkxkMzRPMUVEZnovSUJWTTdET01ETC9yV3ZpSVNXWmpIM1FWNE5nT0haSEwx?=
 =?utf-8?B?L1V4Q05FQVdvK2NkeXV5VkpTOG1rQU5td1hFWEFzZ0lzNW1UUzhlWGZxNS8z?=
 =?utf-8?B?ZzEzZTZOM2pWeVpnUHRXMFJ2ZzFxRjBnRUQyT0VNNWd0V25FSzlZeFNaayt4?=
 =?utf-8?B?amlUMDFUMmo5MDJsNC83eS9pMGwrYktWSUdmKzVyY2ZJVmFqYVRKMUNrM21X?=
 =?utf-8?B?VDl4d0tqV2taR1NvUXhaR3E0ZVJHWW1UbkMrblRnTzR1M0hlUjlxR1hzZVZO?=
 =?utf-8?B?MlE5akJzcUhzSm1zc2NHTmthUmJLSWkwTnVSN3F3QVF5dTlsSWYzZXEwbm1l?=
 =?utf-8?B?NHdxQUZ2aFZEbkdmZXNEcXU0clVpOFdpeVpaT1ZoRHNkc0FVYTIwWFZxR09K?=
 =?utf-8?B?RGs5V1Znd0V1cGZRM3M5N1FWbGlUc1hpS2lvc2h3K0VUZ09STWVsTkRxV2Za?=
 =?utf-8?B?d0hLcjVpRysxdENZNCthMk9MRlJUdUIwTkUyOVRkbjZWaUNEV1dmd3dsOHVN?=
 =?utf-8?B?cExBcTJyV3I1cG1yUHVRSWIyNFBPekdTU0RCV3RkQUhkM2phUDQvNzRzb2J5?=
 =?utf-8?B?MlM1VTZ4MkVGUlI1ZGplay8zMmdwbURyOW1yTDRZakxkMzc3TC9uakRUTUxa?=
 =?utf-8?B?SWtNcWVrNGJha2hubXZRTVIzTXlISys4RkNxQ05kUkdGMFAwbEZDRDBjMzJ2?=
 =?utf-8?B?bnBycDBRY3lXWFZuMXd4bUR2QldrNFBrdTNsR2l0TEVPVWpLWWhrNmZCSnIv?=
 =?utf-8?B?TDU3eTdPTHZ4NTl1aGxyanNrc1Fpa3VxeDNFb1RUaUtMYzNPQ3B5VGgrNFFk?=
 =?utf-8?B?dGJWK1llLzdINWk5bk42L1RBc1BKeVJSaHRTWjRKb1dhWnFmaWo5U0NxU2pZ?=
 =?utf-8?B?aEpXcU14d1FmNGpLTnp0N05lRmdwNndSczJuM21tdHdiQnpQOS83dm0vMEps?=
 =?utf-8?B?d1UxUGYxeUpRbHQwc1pNOVlwQXhEdjBKNGdZTG5rUkVOdVMwQmpxbHhBSkF3?=
 =?utf-8?B?ZUNGZ3V4eUxvTHc3cmpEeUNYMmladTVmSWlhV3Fza3ErcGhyZlJIL2ZaMkpL?=
 =?utf-8?B?blF6ZVBBR25BZG5kd0xKc1FNYWtza0xrZUdsSDNKYWN2NDNzUW1DUG95bTVF?=
 =?utf-8?B?YmgzaUppUSs0eVF1YXZaY1ZDQTlBYnpRMWZ5N3Yvc3IzREZPcUR3dkVHU0VU?=
 =?utf-8?B?cDNJWkJJT0NRWGNkTk96RHc5NlM1YUM1ODQray9CM3Y4Q1FGcldlekpSWHh6?=
 =?utf-8?B?c1FtMWk5UEVmZHl5TUMxeGsvZmNEWnpKMXEwNUtHRXBUS3IxazFiR2tzVGdm?=
 =?utf-8?Q?S0BQGUVjQm5hQPbROjkp2E/vg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3676C2079EFFFA4F800100443FB21A21@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dab6bb-f6d0-4a66-60e7-08da668fcbb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 18:28:20.9764
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lJB/GPMVWqgFo3rcrI4rqYXPy+HDanCZ3nRYyRLBBGysY9b5QK17Wcir13vNo3T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3063
X-Proofpoint-GUID: NCFaEvNpjXNZwvM7n7OysQJAhJ8EViEz
X-Proofpoint-ORIG-GUID: NCFaEvNpjXNZwvM7n7OysQJAhJ8EViEz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_10,2022-07-15_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA3LTE0IGF0IDE4OjUxIC0wNzAwLCBBbGV4ZWkgU3Rhcm92b2l0b3Ygd3Jv
dGU6DQo+IE9uIFR1ZSwgSnVsIDEyLCAyMDIyIGF0IDA2OjQyOjUyUE0gKzAwMDAsIERlbHlhbiBL
cmF0dW5vdiB3cm90ZToNCj4gPiANCj4gPiA+IGJ1dCBoYXZlIHlvdSB0aG91Z2ggb2YgbWF5YmUg
aW5pdGlhbGx5IHN1cHBvcnRpbmcgc29tZXRoaW5nIGxpa2U6DQo+ID4gPiANCj4gPiA+IGJwZl90
aW1lcl9pbml0KCZ0aW1lciwgbWFwLCBTT01FX05FV19ERUZFUlJFRF9OTUlfT05MWV9GTEFHKTsN
Cj4gPiA+IGJwZl90aW1lcl9zZXRfY2FsbGJhY2soJnRpbWVyLCBjZyk7DQo+ID4gPiBicGZfdGlt
ZXJfc3RhcnQoJnRpbWVyLCAwLCAwKTsNCj4gPiA+IA0KPiA+ID4gSWYgeW91IGluaXQgYSB0aW1l
ciB3aXRoIHRoYXQgc3BlY2lhbCBmbGFnLCBJJ20gYXNzdW1pbmcgeW91IGNhbiBoYXZlDQo+ID4g
PiBzcGVjaWFsIGNhc2VzIGluIHRoZSBleGlzdGluZyBoZWxwZXJzIHRvIHNpbXVsYXRlIHRoZSBk
ZWxheWVkIHdvcms/DQo+ID4gDQo+ID4gUG90ZW50aWFsbHkgYnV0IEkgaGF2ZSBzb21lIHJlc2Vy
dmF0aW9ucyBhYm91dCBkcmF3aW5nIHRoaXMgZXF1aXZhbGVuY2UuDQo+IA0KPiBocnRpbWVyIGFw
aSBoYXMgdmFyaW91czogZmxhZ3MuIHNvZnQgdnMgaGFyZCBpcnEsIHBpbm5lZCBhbmQgbm90Lg0K
PiBTbyB0aGUgc3VnZ2VzdGlvbiB0byB0cmVhdCBpcnFfd29yayBjYWxsYmFjayBhcyBzcGVjaWFs
IHRpbWVyIGZsYWcNCj4gYWN0dWFsbHkgZml0cyB3ZWxsLg0KPiANCj4gYnBmX3RpbWVyX2luaXQg
KyBzZXRfY2FsbGJhY2sgKyBzdGFydCBjYW4gYmUgYSBzdGF0aWMgaW5saW5lIGZ1bmN0aW9uDQo+
IG5hbWVkIGJwZl93b3JrX3N1Ym1pdCgpIGluIGJwZl9oZWxwZXJzLmgNCj4gKG9yIHNvbWUgbmV3
IGZpbGUgdGhhdCB3aWxsIG1hcmsgdGhlIGJlZ2lubmluZyBsaWJjLWJwZiBsaWJyYXJ5KS4NCj4g
UmV1c2luZyBzdHJ1Y3QgYnBmX3RpbWVyIGFuZCBhZGRpbmcgemVyby1kZWxheSBjYWxsYmFjayBj
b3VsZCBwcm9iYWJseSBiZQ0KPiBlYXNpZXIgZm9yIHVzZXJzIHRvIGxlYXJuIGFuZCBjb25zdW1l
Lg0KDQpUbyBjbGFyaWZ5LCB3ZSdyZSB0YWxraW5nIGFib3V0IDEpIG1ha2luZyBicGZfdGltZXIg
bm1pLXNhZmUgZm9yIF9zb21lXyBidXQgbm90IGFsbA0KY29tYmluYXRpb25zIG9mIHBhcmFtZXRl
cnMgYW5kIDIpIGFkZGluZyBuZXcgZmxhZ3MgdG8gc3BlY2lmeSBhbiBleGVjdXRpb24gY29udGV4
dD8NCkl0J3MgYWNoaWV2YWJsZSBidXQgaXQncyBoYXJkIHRvIHNlZSBob3cgaXQncyB0aGUgc3Vw
ZXJpb3Igc29sdXRpb24gaGVyZS4NCg0KPiANCj4gU2VwYXJhdGVseToNCj4gK3N0cnVjdCBicGZf
ZGVsYXllZF93b3JrIHsNCj4gKyAgICAgICBfX3U2NCA6NjQ7DQo+ICsgICAgICAgX191NjQgOjY0
Ow0KPiArICAgICAgIF9fdTY0IDo2NDsNCj4gKyAgICAgICBfX3U2NCA6NjQ7DQo+ICsgICAgICAg
X191NjQgOjY0Ow0KPiArfSBfX2F0dHJpYnV0ZV9fKChhbGlnbmVkKDgpKSk7DQo+IGlzIG5vdCBl
eHRlbnNpYmxlLg0KPiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gYWRkIGluZGlyZWN0aW9uIHRvIGFs
bG93IGtlcm5lbCBzaWRlIHRvIGdyb3cNCj4gaW5kZXBlbmRlbnRseSBmcm9tIGFtb3VudCBvZiBz
cGFjZSBjb25zdW1lZCBpbiBhIG1hcCB2YWx1ZS4NCg0KRmFpciBwb2ludCwgSSB3YXMgd29uZGVy
aW5nIHdoYXQgdG8gZG8gd2l0aCBpdCAtIHN0b3JpbmcganVzdCBhIHBvaW50ZXIgc291bmRzDQpy
ZWFzb25hYmxlLg0KDQo+IENhbiB5b3UgdGhpbmsgb2YgYSB3YXkgdG8gbWFrZSBpcnFfd29yay9z
bGVlcGFibGUgY2FsbGJhY2sgaW5kZXBlbmRlbnQgb2YgbWFwcz8NCj4gQXNzdW1lIGJwZl9tZW1f
YWxsb2MgaXMgYWxyZWFkeSBhdmFpbGFibGUgYW5kIE5NSSBwcm9nIGNhbiBhbGxvY2F0ZSBhIHR5
cGVkIG9iamVjdC4NCj4gVGhlIHVzYWdlIGNvdWxkIGJlOg0KPiBzdHJ1Y3QgbXlfd29yayB7DQo+
ICAgaW50IGE7DQo+ICAgc3RydWN0IHRhc2tfc3RydWN0IF9fa3B0cl9yZWYgKnQ7DQo+IH07DQo+
IHZvaWQgbXlfY2Ioc3RydWN0IG15X3dvcmsgKncpOw0KPiANCj4gc3RydWN0IG15X3dvcmsgKncg
PSBicGZfbWVtX2FsbG9jKGFsbG9jYXRvciwgYnBmX2NvcmVfdHlwZV9pZF9sb2NhbCgqdykpOw0K
PiB3LT50ID0gLi47DQo+IGJwZl9zdWJtaXRfd29yayh3LCBteV9jYiwgU0xFRVBBQkxFIHwgSVJR
X1dPUkspOw0KPiANCj4gQW0gSSBkYXkgZHJlYW1pbmc/IDopDQoNCk5vdGhpbmcgd3Jvbmcgd2l0
aCBkcmVhbWluZyBvZiBhIGJldHRlciBmdXR1cmUgOikgDQoNCihJJ20gYXNzdW1pbmcgeW91J3Jl
IHRoaW5raW5nIG9mIGJwZl9tZW1fYWxsb2MgYmVpbmcgZnJvbnRlZCBieSB0aGUgYWxsb2NhdG9y
IHlvdQ0KcmVjZW50bHkgc2VudCB0byB0aGUgbGlzdC4pDQoNCk9uIGEgZmlyc3QgcGFzcywgaGVy
ZSBhcmUgbXkgY29uY2VybnM6DQoNCkEgcHJvZ3JhbSBhbmQgaXRzIG1hcHMgY2FuIGd1YXJhbnRl
ZSBhIGNlcnRhaW4gYW1vdW50IG9mIHN0b3JhZ2UgZm9yIHdvcmsgaXRlbXMuDQpTaXppbmcgdGhh
dCBzdG9yYWdlIGlzIGRpZmZpY3VsdCBidXQgaXQgaXMgeW91cnMgYWxvbmUgdG8gdXNlLiBUaGUg
ZnJlZWxpc3QgYWxsb2NhdG9yDQpjYW4gYmUgdHJhbnNpZW50bHkgZHJhaW5lZCBieSBvdGhlciBw
cm9ncmFtcyBhbmQgc3RhcnZlIHlvdSBvZiB0aGlzIHV0aWxpdHkuIFRoaXMgaXMNCmEgbmV3IGZh
aWx1cmUgbW9kZSwgc28gaXQncyB3b3J0aCB0YWxraW5nIGFib3V0Lg0KDQpXaXRoIGEgZ2VuZXJp
YyBhbGxvY2F0b3IgbWVjaGFuaXNtLCB3ZSdsbCBoYXZlIGEgaGFyZCB0aW1lIGVuZm9yY2luZyB0
aGUgY2FuJ3QtbG9hZC0NCm9yLXN0b3JlLWludG8tc3BlY2lhbC1maWVsZHMgbG9naWMuIEkgbGlr
ZSB0aGF0IGd1YXJkcmFpbCBhbmQgSSdtIG5vdCBzdXJlIGhvdyB3ZSdkDQphY2hpZXZlIHRoZSBz
YW1lIGd1YXJhbnRlZXMuIChJbiB5b3VyIHNuaXBwZXQsIHdlIGRvbid0IGhhdmUgdGhlIGxsaXN0
X25vZGUgb24gdGhlDQp3b3JrIGl0ZW0gLSBkbyB3ZSB3cmFwIG15X3dvcmsgaW50byBzb21ldGhp
bmcgZWxzZSBpbnRlcm5hbGx5PyBUaGF0IHdvdWxkIGhpZGUgdGhlDQpmaWVsZHMgdGhhdCBuZWVk
IHByb3RlY3RpbmcgYXQgdGhlIGV4cGVuc2Ugb2YgYW4gZXh0cmEgYnBmX21lbV9hbGxvYyBhbGxv
Y2F0aW9uLikNCg0KTWFuYWdpbmcgdGhlIHN0b3JhZ2UgcmV0dXJuZWQgZnJvbSBicGZfbWVtX2Fs
bG9jIGlzIG9mIGNvdXJzZSBhbHNvIGEgY29uY2Vybi4gV2UnZA0KbmVlZCB0byB0cmVhdCBicGZf
c3VibWl0X3dvcmsgYXMgInJlbGVhc2luZyIgaXQgKHJlYWxseSwgdGFraW5nIG93bmVyc2hpcCku
IFRoaXMgcGF0aA0KbWVhbnMgbW9yZSBsaWZlY3ljbGUgYW5hbHlzaXMgaW4gdGhlIHZlcmlmaWVy
IGFuZCBleHBsaWNpdCBhbmQgaW1wbGljaXQgZnJlZSgpcy4NCg0KSSdtIG5vdCBvcHBvc2VkIHRv
IGl0IG92ZXJhbGwgLSB0aGUgZGV2ZWxvcGVyIGV4cGVyaWVuY2UgaXMgdmVyeSBmYW1pbGlhciAt
IGJ1dCBJIGFtDQpwcmltYXJpbHkgd29ycmllZCB0aGF0IGFsbG9jYXRvciBmYWlsdXJlcyB3aWxs
IGJlIGluIHRoZSBzYW1lIGNhdGVnb3J5IG9mIGlzc3VlcyBhcw0KdGhlIGhhc2ggbWFwIGNvbGxp
c2lvbnMgZm9yIHN0YWNrcy4gSWYgeW91IHdhbnQgcmVsaWFiaWxpdHksIHlvdSBqdXN0IGRvbid0
IHVzZSB0aGF0DQp0eXBlIG9mIG1hcCAtIHdoYXQncyB0aGUgYWx0ZXJuYXRpdmUgaW4gdGhpcyBo
eXBvdGhldGljYWwgYnBmX21lbV9hbGxvYyBmdXR1cmU/DQoNCi0tIERlbHlhbg0K
