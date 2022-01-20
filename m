Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06BD495682
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 23:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378145AbiATW6Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Jan 2022 17:58:24 -0500
Received: from mx08-001d1705.pphosted.com ([185.183.30.70]:57912 "EHLO
        mx08-001d1705.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233856AbiATW6U (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 20 Jan 2022 17:58:20 -0500
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KMnF5I027507;
        Thu, 20 Jan 2022 22:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=9/raL1Vn51XfsWIPo0SK9KPI0CbYzsIuyxDK2badC8s=;
 b=Mydh/7n0GzCeW0CsLgsdJ9Ih6MnCdLbE3IAh7+02lhdvZIZJv9O1VjKogRlwMvUhgxY5
 WPoUanB6VkgPSS3FCnjuIczVZ1z4l3F63EmZ9FADokKrpATLr+6swzoZUrCEipkdcamN
 ozkJEfH2NIfO7XaODCj9ANHkhfkRefMXXt/hFoYM+zkvJV1zvHn6p9LJ/dBKyFoyVD4h
 uCDuPEtubCyzErdPiS9KFRJQzr/brleHtIV74aVPCrvo2yEI+PagvUFKPApcL6CWvWkI
 N8200ie+kun0eJbrbFIwLiJwzFncHWS3lAIZhDdbIttjcwv3ud15qFBikYzY+45E00ch Og== 
Received: from jpn01-tyc-obe.outbound.protection.outlook.com (mail-tycjpn01lp2174.outbound.protection.outlook.com [104.47.23.174])
        by mx08-001d1705.pphosted.com with ESMTP id 3dq0errvxq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 22:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMza4T7ZuCfT/kEevyGaAJaKaiMHSacCHzLfJN9S0GAJW26fzZ2QyytO93GVcNIklCAwKXH22l6bZj5kxjTXKNryfUq6Ez2GFSH9NeYZNnwFRsE04ay0xCFBp38+g6ULkkHA3zQJARSAh3Jp+yV17Dqwaz9s3cKEVe8UxXawmPQI5Ia/8I81bgBOYoaJCU/LY4UGvA0PgEXO2zU8mRvr5v6zHpv+R9O232oym6n0IrKnlfQXC0tlSU70ZnYUGXvbSfwKavpBbhAwjctDzKMGG4kmyJ6idGpqgyImvsFTx7rY84nIeVww1sqvCXZ/NoqH9+JyyhgQ7zhvpHj0UisVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/raL1Vn51XfsWIPo0SK9KPI0CbYzsIuyxDK2badC8s=;
 b=CIB6xwPIdgsY71DDbuksHstQbE51tC6h8BBuD/xK+vVgQQa1Me4vbJMaqsIy60TS22vRfJith21rna3JGwE+T/p3pPqjtZQRxBXo7aqigg44pxLAgfGCeV80zS68htmXKWU+nyF2hvWRy2VzMVii8hcmcm8+cscnyrVCGZ+TbNz18oJk4iuF4s0ldj0Fgfqws4vFkQPchipj7HZmhO4QmoF229Es9CPxjahan9ru7PFwHAmLSc4MPcrURdKNSBZfDhiBOZQKKcjK9XHxWLZVc7u6u0MMmk7aQcRPFhJY5nHXap1xtnR/r1ChxASQfhI1SzvHPa90P8fYGAfnPDqXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com (2603:1096:400:42::10)
 by OS3PR01MB6165.jpnprd01.prod.outlook.com (2603:1096:604:d1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Thu, 20 Jan
 2022 22:56:15 +0000
Received: from TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d]) by TYCPR01MB5936.jpnprd01.prod.outlook.com
 ([fe80::4d73:10a:5d6:4b8d%7]) with mapi id 15.20.4909.011; Thu, 20 Jan 2022
 22:56:15 +0000
From:   <Kenta.Tada@sony.com>
To:     <andrii.nakryiko@gmail.com>
CC:     <andrii@kernel.org>, <bpf@vger.kernel.org>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>
Subject: RE: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Topic: [PATCH v4 2/3] libbpf: Fix the incorrect register read for
 syscalls on x86_64
Thread-Index: AQHYDTZZ2C28qVTfhEWPJ0gTzKPfeqxqq8iAgAHYINA=
Date:   Thu, 20 Jan 2022 22:56:15 +0000
Message-ID: <TYCPR01MB5936508A473D90FCA8C779E9F55A9@TYCPR01MB5936.jpnprd01.prod.outlook.com>
References: <20220119131209.36092-1-Kenta.Tada@sony.com>
 <20220119131209.36092-3-Kenta.Tada@sony.com>
 <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com>
In-Reply-To: <CAEf4Bza9A+iC49bZRiSPWNuy+=qG3sc=_XvKem4Fj2zZF8merg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dd04d60-0a3a-4b4b-db5f-08d9dc68100f
x-ms-traffictypediagnostic: OS3PR01MB6165:EE_
x-microsoft-antispam-prvs: <OS3PR01MB6165738F55B5EB00DC2F8A96F55A9@OS3PR01MB6165.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCJ9pmD4UoiHlIjfTtEHdC7dG44WKmcTi5HSA9qjOx3Y+29ca2rH5bYwDojD3bNFvSZ1Wnt1zX7swyw6TzyCNNkLx9oywjhg46QOA7I18RL9WS0QOyzwCISEYVD5GyBZxZvtSgYVSjiw5HKOdlSXTpfM6TyCkYQu9MO7Skndb6SBVNJGTzZC3xN1iAoBSMxnt1dbgPGn9WrqJ5TwRF1J19iOmdUyIUeIedOaCr0juk3pArV3WrYyc6whnDN6vwfpAc4/LrXaVFgo4Qv2uIOFnDKVdFuFEXFe5oC7WiBTCNkuEp4HfkfHxDZCI0EV+vEMwT4YzURgag0j/UgbrXE2caLQ0elS/AGgRJO7jo0oLbT3GwC0duvxkVbMxABvworh1UJnyzA8c14Hq2OaR0Xy15oL/k/YpQgPR7kOIVhlHIRScnYUy6XKGD1HhO2N1jaFEWaUuX0UJDbesSoepm1a9qaXB0avQCyv4txQoE7g1JE9xeolSbSUAFKaOza7kN9D8qM1Br+PXV6BuMEIjmlPSZH06RCuE5lElc4ae1OHvygFDmmUbszChEPbnTdJMWYGrS1apwspIpZGEBB0JBZ8gCPOFKjEDN04PkGynoRUAz0o9xRTB80bnRdctjGMNLakazDVyzYKZ1KG/4BGyx9tI9ghDgtEOCtmc5FaUbywUy4FPvxjMpehrgzhizuxjx3/2ZCf/oe0ZGk2TGGPQCpFjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5936.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(66946007)(86362001)(55016003)(7696005)(508600001)(33656002)(52536014)(7416002)(54906003)(71200400001)(76116006)(66446008)(66476007)(64756008)(66556008)(316002)(38070700005)(8936002)(4326008)(82960400001)(558084003)(8676002)(6916009)(186003)(2906002)(122000001)(38100700002)(9686003)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVFwRnNZNThhZWg2Ui81Yi9vcEtlQmh5U0lDUkIreFZUUXNhUmJhbFY2N2pM?=
 =?utf-8?B?SjZYak13bmZTdVlJdjNSYWRsbStHWTBVUC83NElKYStkaTVQWGdBTXhJTFNr?=
 =?utf-8?B?U1Z4NDVMUzV4akJIcEJVR0ZUSkc2cmk5MmxmWTBuMUJzWCswbUoxbUNzbk9v?=
 =?utf-8?B?UzE0WDk3TlFVTTE3WmZpdWVtS0Nocy8xN2ttalIyN2UrVkZieHk1RVhuTzFz?=
 =?utf-8?B?QUlLQ2dBR1JuSFd4YUZVZjZkMUpXbGdQU0lWM1dnajZjWlpLamdFMVBOMEVJ?=
 =?utf-8?B?eVliTXo5MWxkUDZQTkJHZmdoSUZjejBVRXZhM3B5NGZPYzZ3Y200czMzNnJm?=
 =?utf-8?B?dFl3L3VRZmlVVWc1WkU1clJqc1N6Zy96NXpaUjhDejIxd3ZqWVF0TjFHczZL?=
 =?utf-8?B?RGNGd3Z4a25ReDQyMzZuRW50YkYzSllTM3B6SldjOGNDUGRhZE5CMGpHWk5X?=
 =?utf-8?B?QXovNzF6TUdpMTNsdWRhMWhSUHJXY3F0RHlEa2tVbWd3QXpzVFVob2FQdG9C?=
 =?utf-8?B?Y1Mxdk9rYlFVMm4yazhjcE02NzdDajNFMGRpaU1wTkIzdW1zNlhCR3JyOGZv?=
 =?utf-8?B?bEdkUTEyeUdlNkFMWHNibFV3cFkvbEVBck1Xd29pSDl1d0FHazgyZTJnSUhG?=
 =?utf-8?B?QUtobGtxdW1oWFQwQ05QRi9ZM1Z1V0pUWGc3SFV2YlhKdC91VWZtWlhLaW4x?=
 =?utf-8?B?ZW5SVERsZUNhbkZCdWFIaDFhM1B2dS9QdDVSK2tXbjdRQUNhWjRCbFA3NHk3?=
 =?utf-8?B?U3EvZ0liOTA0T29NaUFZdTFlN3B2V2o3c1Z1WGRPVXZ1S1MzelliUFZkbEpJ?=
 =?utf-8?B?TVhqSHEvYXZ1ZUt1UFZsYjBIWG8zcnFFMTZnQ09GU3RSTEFrMm5KWGk3R0px?=
 =?utf-8?B?WlJ3NDkxdmFDdEM1VWhPdlp0d1VkTURER3MrOXJtb2R3M1JqVytMVk9ITmdt?=
 =?utf-8?B?OVZMTmJFQXRHaFdGOHdJYVd4MU9jb0E3ZC8xaVlNZXV3SjRaWlNrcjFId3pR?=
 =?utf-8?B?bkVQYk5mZWhUcUY4bXpFZnd3OGUxZkJodklPT3ByUkNVN3NNUHNnbXNWRHdM?=
 =?utf-8?B?ZnBNVTFwVnZweGZncWdKZTRmRnJyUGdHSWlBdmhISTBSMnJhbitxL3dRdk1Y?=
 =?utf-8?B?WG5oN1ExcEE1dEhpQ0tNa0JINE1rS0l5MGVyUjdyK2g1bzhlMDhPMFlJdDI3?=
 =?utf-8?B?Sk5hVTJNVUJETVlDTFlHaHNiWDNpeVV2b2Vsdms3ZjVzMGpiSXlkZXY0eWV6?=
 =?utf-8?B?bkpHZE9WdU9DeTM5TW05d3E1MitPR3A2TTlaTjd6V3lGUlJJQm9sTDBGeko0?=
 =?utf-8?B?ZDJ2TFcwNVNBQ1gxOWovVXFwK25lcjRGemZ1SExqMkNyeXNtU0c0S1BDTDRo?=
 =?utf-8?B?WGF4VEI2MTNiNElVdTZqTzJRVklqeTFVVkpKLzVyalNYMVdvcVkwQXpSZjY5?=
 =?utf-8?B?Ynl2TWIrVmVkbjRCNUVUd25xb0R4bzgwbzdjdVdkL1A4WXJ4a0svYmhJeUha?=
 =?utf-8?B?VTJsSGZCK2E4SXFidjFIb1p6YmxtMXlyY29RdWEzZmR6TGZZT1RaeDVDZWJE?=
 =?utf-8?B?cGUzbEgrQUErcktnNzBSOUowd1pKNWJkT1NoekF1ZENGTTVXdXhCTXRrbFBU?=
 =?utf-8?B?RjVtcEdwNjNjd29rVEtPZzZIeHZhaFNSaHFLWVdWYzNDRUVldmFRT1ZsUUo5?=
 =?utf-8?B?N3F0VWNzWmRoMXVLaytiVjB4bG8yb0NSdVhlN0x1ZnRvOUpJMnhpQS9ZTlU1?=
 =?utf-8?B?djBJU0ZLTkw4RlEyOHFJSXNoSnhQRG9ha2F0MWQ3ZDA5WlNmeWQwVVZCUy9y?=
 =?utf-8?B?eVl4T0ZZWTZXL2VkT215TGNIb3VvSVJNbWtOb1djRERMS0F1S0k4Q3ZOT2R0?=
 =?utf-8?B?WDBwSUxaZlFpcnpFL1I3K0d2Ym9nWUUxZG50czJLOVdaNTJEdlJSUlZwRkxZ?=
 =?utf-8?B?Z3lOU2k3R1FiRnA0Q0N2eFpLM3lpMjlOeWE1V0xTbXVMT21tVTUzVnZKaEl0?=
 =?utf-8?B?djV0Y01kVmdtQ2w4QU5XaitEcGZtS3ZyV2M4Z0phZVlMZ2ZMNCthRTJtTTVm?=
 =?utf-8?B?dGxldmIrQmYxaDdub0pSL3E3Ym9VN2ZPTlBTYnJXRHpTa3hjc213TVdsaUhi?=
 =?utf-8?B?TFV6Nk9ydWRCSUkrTm1TaEVHYWVYeWNlOTBpR0MwdG82TlRqakRqOGI4aVhR?=
 =?utf-8?B?M1M5TE5lL2Z2NVNtazlVWjNQcys0aWhYVm51YStyZ1RLSFhEdVJ6SEloN2pj?=
 =?utf-8?B?eXI2Z1lYNEprbEtuSFdEL1J1TE1nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5936.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd04d60-0a3a-4b4b-db5f-08d9dc68100f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2022 22:56:15.2882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8L2JNTlRRVUHE4cnflKE9SByo93ulFHTYQTMkDH7Q+1yBd93ebb3ilPmazp6KwdWjUJZI2yI8Vp2dVtiYFXn1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6165
X-Proofpoint-ORIG-GUID: vEJoEBATQPvxzZXa8WJr30Nq66rN2sd0
X-Proofpoint-GUID: vEJoEBATQPvxzZXa8WJr30Nq66rN2sd0
X-Sony-Outbound-GUID: vEJoEBATQPvxzZXa8WJr30Nq66rN2sd0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_10,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=921 lowpriorityscore=0 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200116
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

PmRpZCB5b3UgY2hlY2sgUFRfUkVHU19QQVJNNF9DT1JFKCkgZGVmaW5pdGlvbj8gVGhpcyBzaG91
bGQgYmUNCg0KSW4gbXkgbG9jYWwgdGVzdCwgdGhpcyB3cm9uZyBjb2RlIGNhbiBwYXNzIHRoZSBj
b3JyZWN0IGFyZzQgYmVjYXVzZSB0aGUgdGVzdCBqdXN0IGNoZWNrcyB0aGUgdmFsdWUuDQpBbnl3
YXkgSSBzaG91bGQgYXR0YWNoIHRoZSB0ZXN0IGZvciBDT1JFIHZhcmlhbnRzIGF0IGZpcnN0Lg0K
U29ycnkuIEknbGwgZml4IHRoZSBpc3N1ZXMgYW5kIGFkZCB0ZXN0cyBmb3IgQ09SRSB2YXJpYW50
cyB0aGlzIHdlZWtlbmQuDQo=
