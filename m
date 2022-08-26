Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 254855A2A01
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiHZOtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 10:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHZOtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 10:49:50 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1295F5A
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 07:49:47 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27Q1w594021500
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 07:49:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=lq38tyDdqnAxMqZDRki4M8CzrKwBzacfXRhAjGDw77Y=;
 b=EBpNwHzcUDJVZTEj9WZCtu2rkT1zsfC1gjjRmLHOTlRAPkUSabf4KyQdQOM0FjXCaySe
 3QQyj+wcAi81oCD7XiIPIfYrp3lD/1rUKGwDKydwSCtQu0ckO+IMgfLGX9zPwyyp2Uj7
 rw/j5BAFjhO4RLlKP8uHhULwBtA6GxxdtVc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6myh3fhu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 07:49:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDXzHJ5dcXbVSahgdsWR1RLDKsRlXIkJuokeut3xMdvhNLwUOe3g9Qr12msZ16WwAdiAUBYTPXev6E5SBUUWjVPoUABF70toUrbhl3ksM1R7vkFuR8rAO3crI3fRax9hwC9D0DxJBz8jsSHCrAYFxCdgvXaoxpljTCelI5dZaRfKcPwxVQJaYU4BYFELO6j8xXObuKMfTiBmTl9M+ggiu1V7cHJKquWBVUrmP+A8pQKvY0M7t9oA9PVIYpJ8KxfYgfch2qLGAXTty7YgFtwm90AEHQ+S7KLNw7ct2kmDbNnYJV7oMqlULnG0cec5JqhGnG3aNFT3PD9o0ocleRJ4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lq38tyDdqnAxMqZDRki4M8CzrKwBzacfXRhAjGDw77Y=;
 b=lpAw5+uZQf4N91/5axai9ikpbW+83BIVKlhxCfA0dqu82HqA6KBz2AM/r8aKa31DU8+FZqpX13wt+Pw61ex3d9Hh4xy1REEwJELdiUnsh6/hIjl8jWUeXs2cLHRkgv1GIkaeo/y2H79VDpGeJLXv8cs5ShCSG8Ln4I7dI2b7lrhce/h/0Kz18wcNkYs0WD3jqGj1DVW019ObFnQ0sSPF+mca6TOeJlCOjn3O+GVejZ7JDT+QA6z34vk/y38rPFtvV4uEQJtnTPjYuc6oLCvNDS2gBAzF53aagpo/zpuqrjUrtHGf2lbKBlgpj2/j8647xsdKF6uuFfXqZyY37JZkcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by PH0PR15MB4640.namprd15.prod.outlook.com (2603:10b6:510:8c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 14:49:44 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::14b0:8f09:488d:f55f%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:49:43 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
Thread-Topic: [PATCH bpf-next v6 1/4] bpf: Parameterize task iterators.
Thread-Index: AQHYtBhma+uwkbOpgku54fTHsnnakq2+p1GAgAAgXYCAAV9CgIABJwaA
Date:   Fri, 26 Aug 2022 14:49:43 +0000
Message-ID: <50a3d352b6098841eb691b435fde4dec05e22aaa.camel@fb.com>
References: <20220819220927.3409575-1-kuifeng@fb.com>
         <20220819220927.3409575-2-kuifeng@fb.com>
         <CAEf4Bzai7s1E6Y5=+URKXvSO7h8NJ6aNLxZCQrTq2ucTUp=S_Q@mail.gmail.com>
         <52171bf63f54b311116988cefd275c0847396d45.camel@fb.com>
         <CAEf4BzZEVzh5eTjHt_PmDKMJMgtSKkTcGpidNGamyH3__38R9g@mail.gmail.com>
In-Reply-To: <CAEf4BzZEVzh5eTjHt_PmDKMJMgtSKkTcGpidNGamyH3__38R9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e242155-8ad9-46a7-0c00-08da877236a5
x-ms-traffictypediagnostic: PH0PR15MB4640:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: suO3NLgb10eIppbQ/n96zj3YP8QdniPMTslJ2h/x3WiUMsFMZazt6mW+aSJxcLi2R/aUZO+0z214bb7bwvZeXokR4/qqbi5ohbg5+o1zok3XCEHUsl/zWCRk7hkESGwtQ4SXu1FAmU4WCI/rS0NMIIADPiwDAb4t6oK+Syb1YiNykV4b/HKxzDGpwsmmJf5sqJIcZ4GdmWpsKv1FgeauW/c2NvkUkHrN2NW2ao5iDYAiT3bOGoU5gmhxR0DrefRZLQmXc35X8JKHzIm8zASzId/tVikxvg4BzKq0c8tjt5mG1ulzgv6o/MI0H+LNjLQUlIm0rMsa5te/eOY1V/IiOLPSdV2cVEZjf3FATBXAjLHl+Bij/aLXroCQkebQvR8bC4bQpwg8H+/l/Oupc6+Ahz3Ul2vRLOY+XiMg7Cj1fSYlCdX9TBEDgMoqiSeGgKVXc6d6qnhTRmW13Kioq7IVtObfMJyd1+qr7QVYusa8oPQI4iDSbBcmUeEe6/be29BuuGD4GKHsTLvOWI1ZTfppcuPquNU1pQu9170RUo/yFGlPTyo+SC5NhfUjnIZ8V2gXJ/RMvM60AGjOZwDR4MGJ2UlVrfXoHDkgUDhTGvQNbggvCGGnKk+brDuZVn6DZNjCKQI7UaM7LWmYiT7iVZEezdnlqL2N3Ci2kA1oyGk08sGmumoy0BVfa5N04NmNADgjW+9hjxaA0Fqte2l/Yfv9N4U+SjGRYBDVLuYibdUofDgR24X7+TcL4NVt5O4qgn9EZNEI53APdQEl2ucJ0A+sgg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(136003)(366004)(396003)(316002)(54906003)(71200400001)(122000001)(66446008)(6506007)(38100700002)(64756008)(8676002)(4326008)(478600001)(6486002)(36756003)(53546011)(5660300002)(6916009)(41300700001)(6512007)(26005)(8936002)(2906002)(83380400001)(86362001)(38070700005)(76116006)(66476007)(66946007)(66556008)(2616005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkhQSEx4RWxMaFhIRnl6bFBnOThmWkdBaE5ZVGR4ZFJUcU5nYU96WTYxamE0?=
 =?utf-8?B?ZVcraUZzeU9BVlB3dUhscE9COWtKTWUrZ1loQUFDMTVZRzlXTXlRNlpIdzBr?=
 =?utf-8?B?SlVwbndSYzY2eGNYeDhxRElRSXpMV1hwSmh0amh5WVFUd2ZzSGhXMVVwd3hC?=
 =?utf-8?B?WWVSZXhjb0pFMFRFRDY1dWNxL3N6K3ppb0ZQUzZnWVlRdnRPcVdLWjB3TnRL?=
 =?utf-8?B?OFlqSExZSE11ZzFoNm9oRlYzSWxUbEs5TTNyMzZ0TUJvTWJXZXBFQ0U5MFV3?=
 =?utf-8?B?M0E2b2dYT3hWUjlZSzVBTDFucHk5R0NSbFMvaVc2SXFRd0x2d0hqVnBOV1Jo?=
 =?utf-8?B?a0Vmb2pUWC9WZ0xJbE9SQUR2OWdOempCSmpBTlVCTW9yV29obVU2NTYwS2Fy?=
 =?utf-8?B?NHk3b0dWOGo5QVBubXBvVHlKUXdGQXdtZWphalg1cm1Sdy96c1ZUOGtUVTh4?=
 =?utf-8?B?ZXFMOG5FMjhFTThGeGZwcXFnWXR1emVaOEh3RDZPUmd4dXNDeFBDWWpTQVRO?=
 =?utf-8?B?YythVXUxNHR4ZjI2WHkvdkJDQ3BwODFXWkQ2cWl5c2hjUjdQbmpFYkZKN3hH?=
 =?utf-8?B?Zm5lRWM3bU5oSzc0N3hDd1ppN1J4d2pGTWpDY3oxU2E2YUR1eVQvSnJ0cTla?=
 =?utf-8?B?d2oxazMxMnpJRm1wOXVpdHRYUStqVy9ZV3h4bXJOK09XcEYvZVg5WEY0MG41?=
 =?utf-8?B?SkNRa0xMckR1K0x1aUx6VkZCS1N6TzNMUFVyV1hWZ29XR3pTQ1VCbjJRZlA1?=
 =?utf-8?B?YkVIN0EyNkNyNEtCb1VDY2EwNG5PcXlzTGdjMGRxT2U1amNWWTZ2d1V3NXZE?=
 =?utf-8?B?TXNEZ2JINnhqVndLUmtnTVRHOEp0MXFrR1RkMkdiNnVCY2pHdVlkYk5CNW5l?=
 =?utf-8?B?eld2MVhjUEpzanhDZnFEUmtFeW54ZVVjOC9NdGRBRWRLVVlGbUkrTlBmRE53?=
 =?utf-8?B?RHo2dWhVVnZvS21jWXFsWjhKZk53d3NPT3JBY2dpZFl1T29PeXpnbWRFS3Bu?=
 =?utf-8?B?Ylh3Z3NiOFNsL3FLaUNjMkVZRmxQS1YvdjQvekh0WHVOS3FlWmc2NUlkTEpW?=
 =?utf-8?B?L0ZsdjVMQTFnaHkxTnU1R3MzbGxOT3lOendXSW9Kc2NQUU1oMGNGOW9jSmlP?=
 =?utf-8?B?RzJpU2dmTy8zVkE0OElZeE9LQy9sWUlJWEpSYzY0V0IxcWxkQXlzd3Bmdk5x?=
 =?utf-8?B?RUJOZnpZWXlndTlvSVo0cnB2YlRudDBlcWRSWmhxTFdPaU9JcDZZU0tSTjJ2?=
 =?utf-8?B?VWtBcFJHL2RJd1d6K2p0Ui80SXByTVNDMEtLZEFrMnRyT3hHZUpEOUQ2ZmVM?=
 =?utf-8?B?dUxTNWRScmVVUHBwc0VTNHptTTVlZGJGQ3F2N1BGVGlsUW8vQ1dGcEl5Mk43?=
 =?utf-8?B?N0IxQ0JFektJdUpZZlhzUERIdGdFS0ppeXJSTEZnM0NtRXB0cy8rTGdtemVv?=
 =?utf-8?B?WFFzbVJFRkt1Uyt0dmdFWW9NQUx3WUFORmNiUmJQVHlwNWdDUXBkNDQranYv?=
 =?utf-8?B?eW9RUGkvT1p3UTlvQmNqKzN2UFZ5WEo3aUVaSXVvWnZKcjAwVDVzWXdLVUVL?=
 =?utf-8?B?ZFlnZTcvc3B6MVdUenV3MmJrREEwWVl0dmV1dDEyYlhKSTRKWGloRzAvaTlt?=
 =?utf-8?B?UGE3aHBhQUpkT2FuWllQQkd5OWZpOXd5aFR6eGd0bkhJakJUcjhmckN0Q3ZB?=
 =?utf-8?B?cXJGdU92RDhlc3FkQXhCdWVFS2ZKbzB4YWo0T3hSYjdJTE5YWEkvRWZDek1T?=
 =?utf-8?B?ejg4TjNBckVSSk1SRlcrdGdqbjMwRXhubE5NRTcxam03YTgzOW04MkZjeUtB?=
 =?utf-8?B?VkJiREc5ZDVZcVZ0Q01OQmczY2NDTlVuekJCc0ZnWndOL3p1OWhzNkVFY1pj?=
 =?utf-8?B?eWNaWTRRanJaMlQ1RTFxMkEwb094S0JmL0tmMWRGdkc5ZndvV2V1OWtyUGNz?=
 =?utf-8?B?ZzYyY3g1WlpFVWpwSnFLYTZScEJhcDVzeW5qVHJhQ0pXVi9KSWpic05WeDJa?=
 =?utf-8?B?RDJYbXYweGZsL2o5cWFEQzdqOUlrZTdQY3dITkw3Zlp2cXl1MFRyWTJ1YU5l?=
 =?utf-8?B?Nm5hVGZ0TFNvbVVSdWw0Q0haWW41SHY5d3ZVNWhWMm1YWW0xeWlibjhEZUVD?=
 =?utf-8?Q?x7NafLMRwTZ7DwYuYR+YJNz9e?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BEB89F13D94E4340909FC392F2D2D3F9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e242155-8ad9-46a7-0c00-08da877236a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 14:49:43.8841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TpJCCZZ8DHMJOlgdD2KeLLLg6IRzy04A4Oh0m3hbSUggElkLqLZZoy1pak4Spc3N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4640
X-Proofpoint-GUID: Ozo8hOIP9lsRE2FFnyYA-6Orp4FHm5Nq
X-Proofpoint-ORIG-GUID: Ozo8hOIP9lsRE2FFnyYA-6Orp4FHm5Nq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVGh1LCAyMDIyLTA4LTI1IGF0IDE0OjEzIC0wNzAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
Cj4gT24gV2VkLCBBdWcgMjQsIDIwMjIgYXQgNToxNiBQTSBLdWktRmVuZyBMZWUgPGt1aWZlbmdA
ZmIuY29tPiB3cm90ZToKPiA+IAo+ID4gT24gV2VkLCAyMDIyLTA4LTI0IGF0IDE1OjIwIC0wNzAw
LCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6Cj4gPiA+IE9uIEZyaSwgQXVnIDE5LCAyMDIyIGF0IDM6
MDkgUE0gS3VpLUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4KPiA+ID4gd3JvdGU6Cj4gPiA+ID4g
Cj4gPiA+ID4gQWxsb3cgY3JlYXRpbmcgYW4gaXRlcmF0b3IgdGhhdCBsb29wcyB0aHJvdWdoIHJl
c291cmNlcyBvZiBvbmUKPiA+ID4gPiB0YXNrL3RocmVhZC4KPiA+ID4gPiAKPiA+ID4gPiBQZW9w
bGUgY291bGQgb25seSBjcmVhdGUgaXRlcmF0b3JzIHRvIGxvb3AgdGhyb3VnaCBhbGwKPiA+ID4g
PiByZXNvdXJjZXMgb2YKPiA+ID4gPiBmaWxlcywgdm1hLCBhbmQgdGFza3MgaW4gdGhlIHN5c3Rl
bSwgZXZlbiB0aG91Z2ggdGhleSB3ZXJlCj4gPiA+ID4gaW50ZXJlc3RlZAo+ID4gPiA+IGluIG9u
bHkgdGhlIHJlc291cmNlcyBvZiBhIHNwZWNpZmljIHRhc2sgb3IgcHJvY2Vzcy7CoCBQYXNzaW5n
Cj4gPiA+ID4gdGhlCj4gPiA+ID4gYWRkaXRpb25hbCBwYXJhbWV0ZXJzLCBwZW9wbGUgY2FuIG5v
dyBjcmVhdGUgYW4gaXRlcmF0b3IgdG8gZ28KPiA+ID4gPiB0aHJvdWdoIGFsbCByZXNvdXJjZXMg
b3Igb25seSB0aGUgcmVzb3VyY2VzIG9mIGEgdGFzay4KPiA+ID4gPiAKPiA+ID4gPiBTaWduZWQt
b2ZmLWJ5OiBLdWktRmVuZyBMZWUgPGt1aWZlbmdAZmIuY29tPgo+ID4gPiA+IC0tLQo+ID4gPiA+
IMKgaW5jbHVkZS9saW51eC9icGYuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDI1ICsrKysr
KysKPiA+ID4gPiDCoGluY2x1ZGUvdWFwaS9saW51eC9icGYuaMKgwqDCoMKgwqDCoCB8wqDCoCA2
ICsrCj4gPiA+ID4gwqBrZXJuZWwvYnBmL3Rhc2tfaXRlci5jwqDCoMKgwqDCoMKgwqDCoCB8IDEx
Ngo+ID4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tCj4gPiA+ID4gLS0tLQo+ID4g
PiA+IMKgdG9vbHMvaW5jbHVkZS91YXBpL2xpbnV4L2JwZi5oIHzCoMKgIDYgKysKPiA+ID4gPiDC
oDQgZmlsZXMgY2hhbmdlZCwgMTI5IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9ucygtKQo+ID4g
PiA+IAo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2JwZi5oIGIvaW5jbHVkZS9s
aW51eC9icGYuaAo+ID4gPiA+IGluZGV4IDM5YmQzNjM1OWMxZS4uNTk3MTJkZDkxN2Q4IDEwMDY0
NAo+ID4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvYnBmLmgKPiA+ID4gPiArKysgYi9pbmNsdWRl
L2xpbnV4L2JwZi5oCj4gPiA+ID4gQEAgLTE3MjksOCArMTcyOSwzMyBAQCBpbnQgYnBmX29ial9n
ZXRfdXNlcihjb25zdCBjaGFyIF9fdXNlcgo+ID4gPiA+ICpwYXRobmFtZSwgaW50IGZsYWdzKTsK
PiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBleHRlcm4gaW50IGJwZl9pdGVyXyAjIyB0YXJnZXQoYXJn
cyk7wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgCj4gPiA+ID4gXAo+ID4gPiA+
IMKgwqDCoMKgwqDCoMKgIGludCBfX2luaXQgYnBmX2l0ZXJfICMjIHRhcmdldChhcmdzKSB7IHJl
dHVybiAwOyB9Cj4gPiA+ID4gCj4gPiA+ID4gKy8qCj4gPiA+ID4gKyAqIFRoZSB0YXNrIHR5cGUg
b2YgaXRlcmF0b3JzLgo+ID4gPiA+ICsgKgo+ID4gPiA+ICsgKiBGb3IgQlBGIHRhc2sgaXRlcmF0
b3JzLCB0aGV5IGNhbiBiZSBwYXJhbWV0ZXJpemVkIHdpdGgKPiA+ID4gPiB2YXJpb3VzCj4gPiA+
ID4gKyAqIHBhcmFtZXRlcnMgdG8gdmlzaXQgb25seSBzb21lIG9mIHRhc2tzLgo+ID4gPiA+ICsg
Kgo+ID4gPiA+ICsgKiBCUEZfVEFTS19JVEVSX0FMTCAoZGVmYXVsdCkKPiA+ID4gPiArICrCoMKg
wqDCoCBJdGVyYXRlIG92ZXIgcmVzb3VyY2VzIG9mIGV2ZXJ5IHRhc2suCj4gPiA+ID4gKyAqCj4g
PiA+ID4gKyAqIEJQRl9UQVNLX0lURVJfVElECj4gPiA+ID4gKyAqwqDCoMKgwqAgSXRlcmF0ZSBv
dmVyIHJlc291cmNlcyBvZiBhIHRhc2svdGlkLgo+ID4gPiA+ICsgKgo+ID4gPiA+ICsgKiBCUEZf
VEFTS19JVEVSX1RHSUQKPiA+ID4gPiArICrCoMKgwqDCoCBJdGVyYXRlIG92ZXIgcmVvc3VyY2Vz
IG9mIGV2ZXZyeSB0YXNrIG9mIGEgcHJvY2VzcyAvCj4gPiA+ID4gdGFzawo+ID4gPiA+IGdyb3Vw
Lgo+ID4gPiAKPiA+ID4gdHlwb3M6IHJlc291cmNlcywgZXZlcnkKPiA+ID4gCj4gPiA+ID4gKyAq
Lwo+ID4gPiA+ICtlbnVtIGJwZl9pdGVyX3Rhc2tfdHlwZSB7Cj4gPiA+ID4gK8KgwqDCoMKgwqDC
oCBCUEZfVEFTS19JVEVSX0FMTCA9IDAsCj4gPiA+ID4gK8KgwqDCoMKgwqDCoCBCUEZfVEFTS19J
VEVSX1RJRCwKPiA+ID4gPiArwqDCoMKgwqDCoMKgIEJQRl9UQVNLX0lURVJfVEdJRCwKPiA+ID4g
PiArfTsKPiA+ID4gPiArCj4gPiA+IAo+ID4gPiBbLi4uXQo+ID4gPiAKPiA+ID4gPiDCoMKgwqDC
oMKgwqDCoCByY3VfcmVhZF9sb2NrKCk7Cj4gPiA+ID4gwqByZXRyeToKPiA+ID4gPiAtwqDCoMKg
wqDCoMKgIHBpZCA9IGZpbmRfZ2VfcGlkKCp0aWQsIG5zKTsKPiA+ID4gPiArwqDCoMKgwqDCoMKg
IHBpZCA9IGZpbmRfZ2VfcGlkKCp0aWQsIGNvbW1vbi0+bnMpOwo+ID4gPiA+IMKgwqDCoMKgwqDC
oMKgIGlmIChwaWQpIHsKPiA+ID4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqdGlk
ID0gcGlkX25yX25zKHBpZCwgbnMpOwo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICp0aWQgPSBwaWRfbnJfbnMocGlkLCBjb21tb24tPm5zKTsKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgdGFzayA9IGdldF9waWRfdGFzayhwaWQsIFBJRFRZUEVfUElE
KTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCF0YXNrKSB7Cj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCArKyp0
aWQ7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBnb3RvIHJldHJ5Owo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxz
ZSBpZiAoc2tpcF9pZl9kdXBfZmlsZXMgJiYKPiA+ID4gPiAhdGhyZWFkX2dyb3VwX2xlYWRlcih0
YXNrKSAmJgo+ID4gPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB0YXNrLT5maWxlcyA9PSB0YXNrLT5ncm91cF9sZWFkZXItCj4gPiA+ID4gPiBm
aWxlcykgewo+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAo
KHNraXBfaWZfZHVwX2ZpbGVzICYmCj4gPiA+ID4gIXRocmVhZF9ncm91cF9sZWFkZXIodGFzaykg
JiYKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB0YXNrLT5maWxlcyA9PSB0YXNrLT5ncm91cF9sZWFkZXItCj4gPiA+ID4gPiBmaWxl
cykgfHwKPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgKGNvbW1vbi0+dHlwZSA9PSBCUEZfVEFTS19JVEVSX1RHSUQKPiA+ID4gPiAmJgo+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIF9fdGFza19waWRfbnJfbnModGFzaywKPiA+ID4gPiBQSURUWVBFX1RHSUQsCj4gPiA+ID4g
Y29tbW9uLT5ucykgIT0gY29tbW9uLT5waWQpKSB7Cj4gPiA+IAo+ID4gPiBpdCBnZXRzIHN1cGVy
IGhhcmQgdG8gZm9sbG93IHRoaXMgbG9naWMsIHdvdWxkIGEgc2ltcGxlIGhlbHBlcgo+ID4gPiBm
dW5jdGlvbiB0byBjYWxjdWxhdGUgdGhpcyBjb25kaXRpb24gKGFuZCBtYXliZSBzb21lIGNvbW1l
bnRzIHRvCj4gPiA+IGV4cGxhaW4gdGhlIGxvZ2ljIGJlaGluZCB0aGVzZSBjaGVja3M/KSBtYWtl
IGl0IGEgYml0IG1vcmUKPiA+ID4gcmVhZGFibGU/Cj4gPiAKPiA+ICFtYXRjaGVkX3Rhc2sodGFz
aywgY29tbW9uLCBza2lwX2lmX2R1cF9maWxlKT8KPiA+IAo+ID4gYm9vbCBtYXRjaGVkX3Rhc2so
c3RydWN0IHRhc2tfc3RydWN0ICp0YXNrLAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3QgYnBmX2l0ZXJfc2VxX3Rhc2tfY29tbW9uICpjb21tb24sCj4gPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJvb2wgc2tpcF9pZl9kdXBfZmlsZSkgewo+
ID4gwqDCoMKgwqDCoMKgwqAgLyogU2hvdWxkIG5vdCBoYXZlIHRoZSBzYW1lICdmaWxlcycgaWYg
c2tpcF9pZl9kdXBfZmlsZSBpcwo+ID4gdHJ1ZQo+ID4gKi8KPiA+IMKgwqDCoMKgwqDCoMKgIGJv
b2wgZGlmZl9maWxlc19pZiA9Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIXNr
aXBfaWZfZHVwX2ZpbGUgfHwKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodGhy
ZWFkX2dyb3VwX2xlYWRlcih0YXNrKSAmJgo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHRhc2stPmZpbGUgIT0gdGFzay0+Z29ydXBfbGVhZGVyLT5maWVzKTsKPiA+IMKgwqDCoMKg
wqDCoMKgIC8qIFNob3VsZCBoYXZlIHRoZSBnaXZlbiB0Z2lkIGlmIHRoZSB0eXBlIGlzCj4gPiBC
UEZfVEFTS19JVEVSX1RHSQo+ID4gKi8KPiA+IMKgwqDCoMKgwqDCoMKgIGJvb2wgaGF2ZV90Z2lk
X2lmID0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBjb21tb24tPnR5cGUgIT0g
QlBGX1RBU0tfSVRFUl9UR0lEIHx8Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
X190YXNrX3BpZF9ucl9ucyh0YXNrLCBQSURUWVBFX1RHSUQsCj4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgY29tbW9uLT5ucykgPT0gY29tbW9uLT5waWQ7Cj4gPiDCoMKgwqDCoMKg
wqDCoCByZXR1cm4gZGlmZl9maWxlc19pZiAmJiBoYXZlX3RnaWRfaWY7Cj4gPiB9Cj4gPiAKPiA+
IEhvdyBhYm91dCB0aGlzPwo+ID4gCj4gCj4gSG0uLi4gIm1hdGNoZWRfdGFzayIgZG9lc24ndCBt
ZWFuIG11Y2gsIHRiaCwgc28gbm90IHJlYWxseS4gSSB3YW50ZWQKPiB0byBzdWdnZXN0IGhhdmlu
ZyBhIHNlcGFyYXRlIGhlbHBlciBqdXN0IGZvciB5b3VyIFRHSUQgY2hlY2sgYW5kIGNhbGwKPiBp
dCBzb21ldGhpbmcgbW9yZSBtZWFuaW5nZnVsIGxpa2UgInRhc2tfYmVsb25nc190b190Z2lkIi4g
Q2FuJ3QgY29tZQo+IHVwIHdpdGggYSBnb29kIG5hbWUgZm9yIGV4aXN0aW5nIGR1cF9maWxlIGNo
ZWNrLCBzbyBJJ2QgcHJvYmFibHkga2VlcAo+IGl0IGFzIGlzLiBCdXQgYWxzbyBzZWVtcyBsaWtl
IHRoZXJlIGlzIHNhbWVfdGhyZWFkX2dyb3VwKCkgaGVscGVyIGluCj4gaW5jbHVkZS9saW51eC9z
Y2hlZC9zaWduYWwuaCwgc28gbGV0J3MgbG9vayBpZiB3ZSBjYW4gdXNlIGl0LCBpdAo+IHNlZW1z
Cj4gbGlrZSBpdCdzIGp1c3QgY29tcGFyaW5nIHNpZ25hbCBwb2ludGVycyAocHJvYmFibHkgcXVp
dGUgZmFzdGVyIHRoYW4KPiB3aGF0IHlvdSBhcmUgZG9pbmcgcmlnaHQgbm93KS4KPiAKPiBCdXQg
bG9va2luZyBhdCB0aGlzIHNvbWUgbW9yZSBtYWRlIG1lIHJlYWxpemUgdGhhdCBldmVuIGlmIHdl
IHNwZWNpZnkKPiBwaWQgKHRnaWQgaW4ga2VybmVsIHRlcm1zKSB3ZSBhcmUgc3RpbGwgZ29pbmcg
dG8gaXRlcmF0ZSB0aHJvdWdoIGFsbAo+IHRoZSB0YXNrcywgZXNzZW50aWFsbHkuIElzIHRoYXQg
cmlnaHQ/IFNvIFRHSUQgbW9kZSBpc24ndCBncmVhdCBmb3IKPiBzcGVlZGluZyB1cCwgd2Ugc2hv
dWxkIHBvaW50IG91dCB0byB1c2VycyB0aGF0IGlmIHRoZXkgd2FudCB0bwo+IGl0ZXJhdGUKPiBm
aWxlcyBvZiB0aGUgcHJvY2VzcywgdGhleSBwcm9iYWJseSB3YW50IHRvIHVzZSBUSUQgbW9kZSBh
bmQgc2V0IHRpZAo+IHRvIHBpZCB0byB1c2UgdGhlIGVhcmx5IHRlcm1pbmF0aW9uIGNvbmRpdGlv
biBpbiBUSUQuCj4gCj4gSXQgd2Fzbid0IG9idmlvdXMgdG8gbWUgdW50aWwgSSByZS1yZWFkIHRo
aXMgcGF0Y2ggbGlrZSAzIHRpbWVzIGFuZAo+IHdyb3RlIHRocmVlIGRpZmZlcmVudCByZXBsaWVz
IGhlcmUgOikKPiAKPiBCdXQgdGhlbiBJIGFsc28gd2VudCBsb29raW5nIGF0IHdoYXQgcHJvY2Zz
IGRvaW5nIGZvcgo+IC9wcm9jLzxwaWQvdGFzay8qIGRpcnMuIEl0IGRvZXMgc2VlbSBsaWtlIHRo
ZXJlIGFyZSBmYXN0ZXIgd2F5cyB0bwo+IGl0ZXJhdGUgYWxsIHRocmVhZHMgb2YgYSBwcm9jZXNz
LiBTZWUgbmV4dF90aWQoKSB3aGljaCB1c2VzCj4gbmV4dF90aHJlYWQoKSwgZXRjLiBDYW4geW91
IHBsZWFzZSBjaGVjayB0aG9zZSBhbmQgc2VlIGlmIHdlIGNhbiBoYXZlCj4gZmFzdGVyIGluLXBy
b2Nlc3MgaXRlcmF0aW9uPwo+IAoKSSBoYXZlbid0IG5vdGljZSB0aGlzIG1lc3NhZ2UgdW50aWwg
bm93LgpJdCBsb29rcyBsaWtlIHZlcnkgcHJvbWlzZS4gIEkgd2lsbCBhZGQgaXQgdG8gbmV4dCB2
ZXJzaW9uLgoKPiAKPiA+ID4gCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBwdXRfdGFza19zdHJ1Y3QodGFzayk7Cj4gPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0YXNrID0gTlVMTDsKPiA+ID4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICsrKnRpZDsK
PiA+ID4gPiBAQCAtNTYsNyArNzMsNyBAQCBzdGF0aWMgdm9pZCAqdGFza19zZXFfc3RhcnQoc3Ry
dWN0IHNlcV9maWxlCj4gPiA+ID4gKnNlcSwKPiA+ID4gPiBsb2ZmX3QgKnBvcykKPiA+ID4gPiDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgYnBmX2l0ZXJfc2VxX3Rhc2tfaW5mbyAqaW5mbyA9IHNlcS0+
cHJpdmF0ZTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRhc2s7
Cj4gPiA+ID4gCj4gPiA+ID4gLcKgwqDCoMKgwqDCoCB0YXNrID0gdGFza19zZXFfZ2V0X25leHQo
aW5mby0+Y29tbW9uLm5zLCAmaW5mby0+dGlkLAo+ID4gPiA+IGZhbHNlKTsKPiA+ID4gPiArwqDC
oMKgwqDCoMKgIHRhc2sgPSB0YXNrX3NlcV9nZXRfbmV4dCgmaW5mby0+Y29tbW9uLCAmaW5mby0+
dGlkLAo+ID4gPiA+IGZhbHNlKTsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoCBpZiAoIXRhc2spCj4g
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBOVUxMOwo+ID4gPiA+
IAo+IAo+IFsuLi5dCgo=
