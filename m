Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304365091D7
	for <lists+bpf@lfdr.de>; Wed, 20 Apr 2022 23:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382407AbiDTVP2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Apr 2022 17:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382485AbiDTVPT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 Apr 2022 17:15:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289744927C
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:12:31 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KILSoA022585
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:12:30 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=8OSf1aRO1lUiQ53rX3clwMCwdudOfr8ZpFaMLADBI2U=;
 b=bi1jshZHI19XE9jOJOSrltbTXWo49CMGwk9dToHlxgKFWr2LhwVTH1EcduzijYrgCSF7
 8vLLA6Yd64vKMvHJeXDGx3JoImaf7xnEQjeljrb4Gt6oSh7OwFJ1rawHyDIOLLenuW6D
 2iofSviGuAo9inB5MK6O2FHxEerrzHGK2+0= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fjhgxv3g3-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 20 Apr 2022 14:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPfFPFM5RxLeDdAUXRU7Wnh5x7AOiW3Mp0z4ZVaVF8zawXitk5PVGPN1WYgqJc0yvM/gHp+fLaMZO8w7R+5jTSvPFyI/lzAhK5T/Rpap8m4LbDeE7nb2QCGJw7zsrM9NDh/GjDVvf6dMzZrgJLXmUY6EKdppMcN5bboRFosUA7gNAKQ9UQMQYhrDK1OJf/pSlK45eV6cWsSbqUBddcKgwdTs6gBQvTnzJDyDFHxQjOIURGBklnK04ormLiEE/gR8HqcAvIZMX+3AIElXEqKj57r97dM/ralHp3/oSxYnP08UqCUMEo+fdVsWgN3t7TJWsf7pG69t8Sd5H7fby1rNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OSf1aRO1lUiQ53rX3clwMCwdudOfr8ZpFaMLADBI2U=;
 b=Wr15/yOn5EH5uCb94uaeMg2seEFjUfkP5V45vco3ENv9mvX6/m+DNJVoapjnE02gNC6RJvGHdSiPFCbJzmVrCRjBbGkIFIeWDC6r61bOujpXjzU/6su7lzzheN9p6xdT8l7HqC4dzq3ytB6Yn55HWPbd/TW7wS7nhv6S6FIAz19bzf5hjjM4jZb6nTZ6m7QSU+6VvFeluMJXOFTE0NyvCoeCa8c98KnFLYZevAU/y0zg3KR48sx/r0ChztxnztQFuovoHbzCFbjE+NLtk9lMxAaNEGMCV48pPUvIKtMfOJGoSzi7L9s834Itgw8C4O+Rc0vD20ijp/lV2cXx8B6YNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by SA1PR15MB4659.namprd15.prod.outlook.com (2603:10b6:806:19e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 20 Apr
 2022 21:12:28 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::2174:fa72:f7fe:fe5c%5]) with mapi id 15.20.5164.026; Wed, 20 Apr 2022
 21:12:28 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH dwarves v6 4/6] bpf: Create fentry/fexit/fmod_ret links
 through BPF_LINK_CREATE
Thread-Topic: [PATCH dwarves v6 4/6] bpf: Create fentry/fexit/fmod_ret links
 through BPF_LINK_CREATE
Thread-Index: AQHYUUq57kaW8e7NC06je3fui9igA6z5G2GAgAA4toA=
Date:   Wed, 20 Apr 2022 21:12:28 +0000
Message-ID: <8c6f11c42743f916e344285db467ace85db60a64.camel@fb.com>
References: <20220416042940.656344-1-kuifeng@fb.com>
         <20220416042940.656344-5-kuifeng@fb.com>
         <CAEf4Bzbi-k54JFfYA2-GA6-YcpquFegPms5r+iMH-03C4EauuQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzbi-k54JFfYA2-GA6-YcpquFegPms5r+iMH-03C4EauuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d4237f17-c086-4dcf-d457-08da231279ad
x-ms-traffictypediagnostic: SA1PR15MB4659:EE_
x-microsoft-antispam-prvs: <SA1PR15MB46598645A7378B3A47C7AA33CCF59@SA1PR15MB4659.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SR1VvpDHfY6oWoRVEwSE9VPN4T6OLaMXiqlbvhm1etZdBJ+KVP/5xyHBib7R+hhn7yWcRm/R9URioxmjvgsLbKV/0nBza2BkCHO+51gkplmuJDJdzl6HTlVWNuMwKf06fbwcaPd6DHhSClFUh0WkA1+T+M53GHidjWZlHdi902p4NDPZh3MDL8mMHdvHoz1TbdKSoxYJccZcFUBBnQ4LIrofnJI9Q9cMSpqO/+BDEARiAoLLsVz9M/yxhT8fgZ5iLwzY3M6OxRi2V58OS8K0Zk7Oq6vHQN2g+jWCGUWOJoinmsMc3oiXksgU/0YfYPFgE+SVrQNA5Esa9c66xzX4KrxTK+FjnRKIL66O20lsBwQ4ao7HI0U5E6j3zOgLG5rOcs/xBNWgO9rBv3Hjp+wzuB33r31uHNYiRHURp433tOGVn0LwONHBwg27/TQ0uZMBGpDe/qDmLBT5iobzFc4LbLzcc+EXjz+tU7TU0MI7inRCNT5Z2UFMfOZERfmKk9jgZlPtGIoFSFVCTdyxDeu2bYJftqfB2Gpe44xvSgiNXVTpJNGLEtrOeLOa6Nm+ZsVX3pNPtZUxWvQm3FaE6BgyOc5exBrCcagTFs+no4gdKw3De4c7Dkx/KUOlXD4aHcS4tFU9Kyjn/XSYQkyorG/dvnqAYKuzGBsygz/mc02GgF4ybbQki3A8CyPvqbPRtcpqSndQrErZqQHfN1spkbfqMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(53546011)(76116006)(64756008)(71200400001)(66556008)(36756003)(2616005)(66476007)(66446008)(8676002)(6512007)(66946007)(2906002)(6506007)(5660300002)(186003)(4326008)(8936002)(38070700005)(6486002)(38100700002)(508600001)(316002)(86362001)(6916009)(122000001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MkFMbHo4c1NFU0xmc0FrNkdmaFVMM0svVTJnVWo4cmM4M2FsdlNlNFFuTWV6?=
 =?utf-8?B?Q2RDemFPbzhHVVBZdEpkTDFvY1dZMUJ4L3FhN1hlU0ExMzBGRENNRFhHOFZI?=
 =?utf-8?B?NFZlb1hSbER2eklablR1RkJ5RjNQdGY0NUhHSUt3SWFVcWJXK1ZvSXpyM3dS?=
 =?utf-8?B?K1UyU2xPK2tFMjBWdXRKQTNUYVI4OS9WWThPbVdkQ251anZldGx4UVFUNU9U?=
 =?utf-8?B?WmtRWEdQamV6Z3N5cVByL2NUN0daUGhPblZlUkM5QTBaQXFGRnF3SnY0dXZx?=
 =?utf-8?B?UlUxb1pFNnVUUTlRN2J4YXJabmxkb0VNUmhLcU5xbFdtLzRJelVPTHpvblM5?=
 =?utf-8?B?L0N6TldSalNOQ1QwRU44anFLRGdaMWZ1Vjh4MU1YWDdDZWcwYmI1cEFCaWZM?=
 =?utf-8?B?TXRSUWw3ODA4UStzSEpYTDRNT3pGYy82V09tWFgrZTFvODJDU245WVpvaWcr?=
 =?utf-8?B?VG9Za3BEK1VERXNmVjJrVTB3bFBFa3VoY1hqV2Nob1dxTFJLMkRLV0R2RnY3?=
 =?utf-8?B?YXdLWHZTOXMzcVp0RE4rMFJGMzNaQkVmbVlPek1JUVpnMlorR1VlVEU0RmJ6?=
 =?utf-8?B?QXRPRDBuaHY3YndWZTlIQ2R5dzdUa0cyS2lyZDRQLzNvdnVUZC8xV3hCUENN?=
 =?utf-8?B?aVYvRE9xNUFDTFBQVzZUN2JBV3JMZVZUVEhYbWwxSTlIVW5zQ3ZoZjUwZlZG?=
 =?utf-8?B?ZStMWUlCOGx4YnJvQzVnRU41R2VHVjlRUnpCTTVPRkp5VVNISjY5OGJUTWVW?=
 =?utf-8?B?VlhSK1U1WUxUV1dQMDdWb1lVSjlMSms0c0xIOVZsY0F3YktmeEN4R3NlZzEw?=
 =?utf-8?B?b1ozTFFkeVJFSzNqTkR2NVFCVE1vYjJLaHhjZElEVkVLWnkweDgzRGFPUWtI?=
 =?utf-8?B?QkVlMk5pNDE3b2RCdGZ1TDhIK3hVcVU5V29UaHNlbEV5VCtUU0tYVXUrME1m?=
 =?utf-8?B?VkhjZzk4MmlsZTMxN2JNR01yaEVndlZVWGo3K3ZSdUtaUWtwUzdLdVBOMlh0?=
 =?utf-8?B?cXpuUTdYRXZBZ2hhSWU5VnNVbFgzKzdXNlh6U3YxOE5rYm5WYXRoRC95c054?=
 =?utf-8?B?Z3hRYWxWSE1URlYzeWMwNzlYajByNkpnWS9lRzlGbVIwS202Y2pDZkFQOGFD?=
 =?utf-8?B?T2d0WS9JQ0x4WTNBQUpYN0Q0eGZScWtxRW85ditJMmdvNHQ5Ujdlb3lRb01a?=
 =?utf-8?B?c1NSSzJCYnpHQXJ0dWtnTndWWm16NUZOTC9ZUmNyMU9nS2ZoK3dsQXhORU0v?=
 =?utf-8?B?Z2JFL3BPbmFnc1YzYjdXSk83NFF4Y3ZaTEk3dW95WDhNY1hZeXM0RUgrQ0lH?=
 =?utf-8?B?R0RQMXl5Z1BTUGZ1RGVhRjlNdi9GeFNVMU1WSDRrUDgvOW9YeE96T1pJUmJK?=
 =?utf-8?B?bm5yd2YrN2hSTkFwS2pNc0dOYmhOTzZZc1F6T25CcytIN3ZmR1pHaUpkZzdN?=
 =?utf-8?B?eW9SSVJmRXIzSEVXTmlFbk9JcGVQQS9PYjVNNjh1SGphYnh2TWtXcElRcXZE?=
 =?utf-8?B?TktCQ0lCOXI2QThIRkJqdmZkZnhYZDFpRzN6M2dsUkt4QSswNUFIRWowdkVD?=
 =?utf-8?B?TlJjL1EzR3JEbnFubUF6dHVtQkpVUU9UZVNGellJd3VlaWNPcTVwQjl1STBt?=
 =?utf-8?B?YjlOVHZxYzJvdjhxYm5NUDlZS1lwTklDRExKWkpBL0hra0k0RDNxZkh1emVj?=
 =?utf-8?B?SkljSXRsNkhCMThxUVRCckFyWis1VmdZZE9xcUVmdkU3QlVVcklvbVZETzVJ?=
 =?utf-8?B?UU5zR2k5M1Awb0cwTVRENDNhWjF1TXA1djZrQWNHaFVaTTFxeEhEdllUczVE?=
 =?utf-8?B?dWM3M1Q1L2cwdXJIOTU1ZjUzZ3JiMVcwK0xLRDRsMWk2eHdzRGdjc25uVU5M?=
 =?utf-8?B?elVVVlhXTkRSSDhDRHRqQUkxc2JPbFlmOXdNcVVnQXNUR3V2VGFUdFZZM0Rl?=
 =?utf-8?B?Wk5rZC9IVk1yam9IRERoOTJyeHFiWVFYRmF4RkhCTi9aWDk0U05LbU9hUnRU?=
 =?utf-8?B?T1gxcHk0Y1BEUjhKK2NWamtody9OOUNnZkMrY0dUMk44V3k3TDNqR05sRmJn?=
 =?utf-8?B?c0taNE0zazVDMzY5SXJJcUxyZ3ZXemdwMEF0TzRpcG9CYXJtaEh1aGRPQmZo?=
 =?utf-8?B?dUhGVHNxZ3VPaWhvNndIdEs3VEJIeW44YlhaMTRSbGhWOXdhekJMSElUUkd1?=
 =?utf-8?B?UjZyb3RaNHJqcit5RzZwckFBV3FxNC9sczB4ZkM4WlhXbFBvSndQS2NwN0Ji?=
 =?utf-8?B?NUhnQml1S2lzL2JZUGZMSTFPdVBvWk5hYnZiK0EzZWxPOGxrc1BGWUF2Q0Qz?=
 =?utf-8?B?cE9Pbzd3cUM2NWZWVXhjdTJySnZMUWNubU0wczZMS1FMbnIrTHhGYnQvU0ln?=
 =?utf-8?Q?B+6XViWJoCyCBmvLRitJbwphkyr4Hx2qpsO6/?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A509607AE4E52D4CAB5B8D53E1CB0915@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4237f17-c086-4dcf-d457-08da231279ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 21:12:28.3384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3yiqJWJCG2OEQFx6Q+jFfRbQyNI4QimaqLgekhYmjlWWV3P1NlfM0koE9w8+1ZR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4659
X-Proofpoint-ORIG-GUID: 1DpK6U0UImJLVsK1JvoMqwkaYTZkIWjf
X-Proofpoint-GUID: 1DpK6U0UImJLVsK1JvoMqwkaYTZkIWjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gV2VkLCAyMDIyLTA0LTIwIGF0IDEwOjQ5IC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gRnJpLCBBcHIgMTUsIDIwMjIgYXQgOTozMCBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gTWFrZSBmZW50cnkvZmV4aXQvZm1vZF9yZXQgYXMgdmFs
aWQgYXR0YWNoLXR5cGVzIGZvcgo+ID4gQlBGX0xJTktfQ1JFQVRFLgo+ID4gUGFzcyBhIGNvb2tp
ZSBhbG9uZyB3aXRoIEJQRl9MSU5LX0NSRUFURSByZXF1ZXN0cy4KPiA+IAo+ID4gU2lnbmVkLW9m
Zi1ieTogS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+IC0tLQo+IAo+IEkgdGhpbmsg
bG9naWNhbGx5IHRoaXMgcGF0Y2ggc2hvdWxkIGJlICMzIGFuZCBjdXJyZW50IHBhdGNoICMzIGFk
ZGluZwo+IGNvb2tpZSB0byBVQVBJIHNob3VsZCBnbyBhZnRlciB0aGlzLiBTbyBpdCB3b3VsZCBt
YWtlIHNlbnNlIHRvIHN3YXAKPiB0aGVtLgoKVGhpcyBwYXRjaCBtb2RpZmllcyBVQVBJLiAgVGhl
IGN1cnJlbnQgcGF0Y2ggIzMgc2V0IGEgY29va2llIGZvcgpmZW50cnkvZmV4aXQvZm1vZF9yZXQs
IGJ1dCB0aGUgdmFsdWUgaXMgYWx3YXlzIDAgKGVtcHR5KS4KClRoaXMgcGF0Y2ggcHJvdmlkZXMg
YSB3YXkgdG8gc2V0IGNvb2tpZXMgZnJvbSB0aGUgdXNlcmxhbmQuCgo+IAo+ID4gwqBpbmNsdWRl
L3VhcGkvbGludXgvYnBmLmjCoMKgwqDCoMKgwqAgfCA3ICsrKysrKysKPiA+IMKga2VybmVsL2Jw
Zi9zeXNjYWxsLmPCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDkgKysrKysrKysrCj4gPiDCoHRvb2xz
L2luY2x1ZGUvdWFwaS9saW51eC9icGYuaCB8IDcgKysrKysrKwo+ID4gwqAzIGZpbGVzIGNoYW5n
ZWQsIDIzIGluc2VydGlvbnMoKykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC9icGYuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaAo+ID4gaW5kZXggYTRmNTU3MzM4
YWY3Li43ODBiZTVhOGFlMzkgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvYnBm
LmgKPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51eC9icGYuaAo+ID4gQEAgLTE0OTAsNiArMTQ5
MCwxMyBAQCB1bmlvbiBicGZfYXR0ciB7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2FsaWduZWRfdTY0wqDCoCBhZGRy
czsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIF9fYWxpZ25lZF91NjTCoMKgIGNvb2tpZXM7Cj4gPiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0ga3Byb2JlX211bHRpOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB7Cj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIC8qIGJsYWNrIGJveCB1c2VyLXByb3ZpZGVkIHZhbHVlCj4gPiBwYXNzZWQgdGhyb3VnaAo+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICogdG8gQlBGIHByb2dyYW0gYXQgdGhlIGV4ZWN1dGlvbgo+ID4gdGltZSBhbmQK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAqIGFjY2Vzc2libGUgdGhyb3VnaAo+ID4gYnBmX2dldF9hdHRhY2hfY29va2ll
KCkgQlBGIGhlbHBlcgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICovCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fdTY0wqDCoMKgwqDCoMKgwqDC
oMKgwqAgY29va2llOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0gdHJhY2luZzsKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Owo+
ID4gwqDCoMKgwqDCoMKgwqAgfSBsaW5rX2NyZWF0ZTsKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9icGYvc3lzY2FsbC5jIGIva2VybmVsL2JwZi9zeXNjYWxsLmMKPiA+IGluZGV4IDk2NmYy
ZDQwYWU1NS4uY2ExNGIwYTJlMjIyIDEwMDY0NAo+ID4gLS0tIGEva2VybmVsL2JwZi9zeXNjYWxs
LmMKPiA+ICsrKyBiL2tlcm5lbC9icGYvc3lzY2FsbC5jCj4gPiBAQCAtMzE4OSw2ICszMTg5LDEw
IEBAIGF0dGFjaF90eXBlX3RvX3Byb2dfdHlwZShlbnVtCj4gPiBicGZfYXR0YWNoX3R5cGUgYXR0
YWNoX3R5cGUpCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEJQRl9Q
Uk9HX1RZUEVfU0tfTE9PS1VQOwo+ID4gwqDCoMKgwqDCoMKgwqAgY2FzZSBCUEZfWERQOgo+ID4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBCUEZfUFJPR19UWVBFX1hEUDsK
PiA+ICvCoMKgwqDCoMKgwqAgY2FzZSBCUEZfVFJBQ0VfRkVOVFJZOgo+ID4gK8KgwqDCoMKgwqDC
oCBjYXNlIEJQRl9UUkFDRV9GRVhJVDoKPiA+ICvCoMKgwqDCoMKgwqAgY2FzZSBCUEZfTU9ESUZZ
X1JFVFVSTjoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBCUEZfUFJP
R19UWVBFX1RSQUNJTkc7Cj4gCj4gc2VlbXMgbGlrZQo+IAo+IMKgwqDCoMKgwqDCoCBjYXNlIEJQ
Rl9MU01fTUFDOgo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIEJQRl9QUk9H
X1RZUEVfTFNNOwo+IAo+IGlzIG1pc3Npbmc/CgpTaG91bGQgSSBhZGQgY2FzZXMgZm9yIGFsbCBh
dHRhY2ggdHlwZXM/CkkgdGhvdWdodCBpdCBpcyBpbnRlbnRpb25hbGx5IHRvIGhhdmUgY2FzZXMg
b25seSBmb3Igc3VwcG9ydGVkIGF0dGFjaAp0eXBlcy4gIEZvciBleGFtcGxlLCBsaW5rX2NyZWF0
ZSgpICYgYnBmX3Byb2dfYXR0YWNoKCkgcmV0dXJucyBlYXJsaWVyCmlmIHRoZSByZXR1cm5lZCB0
eXBlIG9mIHRoaXMgZnVuY3Rpb24gaXMgQlBGX1BST0dfVFlQRV9VTlNQRUMuIAoKPiAKPiAKPiBM
b29raW5nIGF0IG15IGV4cGVyaW1lbnQgZm9yIGNsZWFuaW5nIHVwIFJBV19UUkFDRVBPSU5UX09Q
RU4gYW5kCj4gTElOS19DUkVBVEUsIEkgdGhpbmsgSSBhbHNvIGdvdCByaWQgb2YgdHJhY2luZ19i
cGZfbGlua19hdHRhY2goKQo+IGFsdG9nZXRoZXIgYW5kIHRoZXJlIHdhcyBleHRyYSBjYXNlIGZv
ciBCUEZfUFJPR19UWVBFX0VYVC4KPiAKPiBIb3cgYWJvdXQgdGhpcy4gR2l2ZW4gSSBoYXZlIGFu
IGFsbW9zdCByZWFkeSBrZXJuZWwgY29kZSBhbmQgSSdkIGxpa2UKPiBsaWJicGYgdG8gdXNlIExJ
TktfQ1JFQVRFIGlmIHBvc3NpYmxlIGluIGFsbCBjYXNlcywgbGV0IG1lIGFkZCB0aGUKPiBmZWF0
dXJlLXByb2Jpbmcgb24gbGliYnBmIHNpZGUgYW5kIHBvc3QgaXQgYXMgYSBzZXBhcmF0ZSBzbWFs
bCBwYXRjaAo+IHNldCB0aGF0IHlvdSBjYW4gYmFzZSB5b3VyIGNvb2tpZS1zcGVjaWZpYyBjaGFu
Z2VzIG9uIHRvcC4gVGhhdCB3aWxsCj4gbGV0IHlvdSBjb25jZW50cmF0ZSBvbiBCUEYgY29va2ll
IHNpZGUgYW5kIEknbGwgaGFuZGxlIHRoZSBsaWJicGYKPiBpbnRyaWNhY2llcyB0aGF0IGFyZSBu
b3QgZGlyZWN0bHkgcmVsYXRlZCB0byB5b3VyIGNoYW5nZXM/Cj4gCj4gSSdsbCB0cnkgdG8gcG9z
dCBwYXRjaGVzIHRvZGF5IG9yIHRvbW9ycm93LCBzbyBpdCBzaG91bGQgbm90IGRlbGF5Cj4geW91
IG11Y2guCgpTdXJlISBJIHdpbGwgc2VuZCB5b3UgbXkgYnJhbmNoLgoKPiAKPiAKPiA+IMKgwqDC
oMKgwqDCoMKgIGRlZmF1bHQ6Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIEJQRl9QUk9HX1RZUEVfVU5TUEVDOwo+ID4gwqDCoMKgwqDCoMKgwqAgfQo+ID4gQEAgLTQy
NTQsNiArNDI1OCwxMSBAQCBzdGF0aWMgaW50IHRyYWNpbmdfYnBmX2xpbmtfYXR0YWNoKGNvbnN0
Cj4gPiB1bmlvbiBicGZfYXR0ciAqYXR0ciwgYnBmcHRyX3QgdWF0dHIsCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRyLQo+ID4gPmxpbmtfY3JlYXRlLnRhcmdldF9m
ZCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGF0dHItCj4gPiA+bGlu
a19jcmVhdGUudGFyZ2V0X2J0Zl9pZCwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDApOwo+ID4gK8KgwqDCoMKgwqDCoCBlbHNlIGlmIChwcm9nLT50eXBlID09IEJQRl9Q
Uk9HX1RZUEVfVFJBQ0lORykKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVy
biBicGZfdHJhY2luZ19wcm9nX2F0dGFjaChwcm9nLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCAwLAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAw
LAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBhdHRyLQo+ID4gPmxpbmtf
Y3JlYXRlLnRyYWNpbmcuY29va2llKTsKPiA+IAo+ID4gwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
SU5WQUw7Cj4gPiDCoH0KPiA+IGRpZmYgLS1naXQgYS90b29scy9pbmNsdWRlL3VhcGkvbGludXgv
YnBmLmgKPiA+IGIvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4gPiBpbmRleCBhNGY1
NTczMzhhZjcuLjc4MGJlNWE4YWUzOSAxMDA2NDQKPiA+IC0tLSBhL3Rvb2xzL2luY2x1ZGUvdWFw
aS9saW51eC9icGYuaAo+ID4gKysrIGIvdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oCj4g
PiBAQCAtMTQ5MCw2ICsxNDkwLDEzIEBAIHVuaW9uIGJwZl9hdHRyIHsKPiA+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIF9fYWxp
Z25lZF91NjTCoMKgIGFkZHJzOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19hbGlnbmVkX3U2NMKgwqAgY29va2llczsK
PiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSBrcHJv
YmVfbXVsdGk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3RydWN0IHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogYmxhY2sgYm94IHVzZXItcHJvdmlkZWQgdmFsdWUKPiA+
IHBhc3NlZCB0aHJvdWdoCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKiB0byBCUEYgcHJvZ3JhbSBhdCB0aGUgZXhlY3V0
aW9uCj4gPiB0aW1lIGFuZAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogYWNjZXNzaWJsZSB0aHJvdWdoCj4gPiBicGZf
Z2V0X2F0dGFjaF9jb29raWUoKSBCUEYgaGVscGVyCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX191
NjTCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb29raWU7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfSB0cmFjaW5nOwo+ID4gwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIH07Cj4gPiDCoMKgwqDCoMKgwqDCoCB9IGxpbmtfY3JlYXRlOwo+ID4gCj4g
PiAtLQo+ID4gMi4zMC4yCj4gPiAKCg==
