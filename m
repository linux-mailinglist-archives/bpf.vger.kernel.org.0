Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50FB4B8FEE
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 19:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiBPSMc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Feb 2022 13:12:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbiBPSMb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Feb 2022 13:12:31 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4ACB0E91
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:12:18 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21GFV3dF019200
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:12:18 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=vnScfvRIq75E6vrkFOjNHl91brWa12CqvtnPLfYv6+M=;
 b=hZ6bcuRJjCDFcK5vTz2c6EW0f17dN+uJYpVCUN4RBPhCXN3IloJSfkrPTQVFKeg3bZRu
 6QprnPkCQC7i9RFNr+4fO87ppkNAXxbFwT6KBLmv6T2XArznI3Tx9ExtxnxM4OvpgVxz
 517eAjLroI4mY+jCu3FlSfRW4YWkvIBqVDc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n4bebsq-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 16 Feb 2022 10:12:17 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 16 Feb 2022 10:12:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV7g1rIt//MEHhYYkt2PdTLgmJGdmZvj7A9+QOCdkUv4ur2b3eAdKkX91jXXv+A2rZYo4GYSfctf8BonafQNoXVH+ZwAahrxKl+GsvP22oWJ3HLw4NJMkULYVe3EOJQget9bdLN9pGdZWZQGpxe0z+stP+jmWHF3Vil9C5oIGqG3biA2mo9IQAlbqeeC7q6RKZsa7l2rbw4Rfp7th7fLKFvh+EDaYangR0SGBh2gMxw26u7nyiMgUCXNZ4iV0ElwvKEn9hu6j7wYO34d21fujS5Z39e0lSlfYkDi189t19wr93Jd6/FJANhsIQd+qYUz6yfdTGbM6rn6IbbxLXfgNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vnScfvRIq75E6vrkFOjNHl91brWa12CqvtnPLfYv6+M=;
 b=Hn1MkWGMVZSDzlQQZ+G0aQNB9dliGUntnHN2DcaaZYQ8iug5AqFxj4ZENYOlw7lqObfsnQ+Tsw8gWu8yscoFBVlT5Cd4QID4qwnQZTS0vslYXVkGSoRHWdq5AIHhoVvJdaxadhU2wFdlhUP6fTb73OLa3Dbfj7SxDo9bOrG46F2eMO3SN0rmzP8La3IgOJzmc/5FPR9WteqcazzzA3K+UjxNutrGwprKBAUvvIpDqf7hind3zKCFjz2tRCPNEMLxmxFz9GF/o6AwTFc0CNz8DMjbsoWgBn87HUi3Z3VCeu2Px/4CiggAE+0BO7ygb1kUmJlLe0oSzfLF0vnK1BvfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by MWHPR15MB1280.namprd15.prod.outlook.com (2603:10b6:320:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 16 Feb
 2022 18:12:10 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::c13e:f7b6:fa3f:687a]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::c13e:f7b6:fa3f:687a%5]) with mapi id 15.20.4995.015; Wed, 16 Feb 2022
 18:12:10 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>, "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] scripts/pahole-flags.sh: Enable parallelization
 of pahole.
Thread-Topic: [PATCH bpf-next] scripts/pahole-flags.sh: Enable parallelization
 of pahole.
Thread-Index: AQHYIs7aIdBuaPWH3keCEpOs+TzD7qyVlqkAgADlJwA=
Date:   Wed, 16 Feb 2022 18:12:10 +0000
Message-ID: <056a349d0f8a16664212aeee2396db511ef14a8b.camel@fb.com>
References: <20220216004616.2079689-1-kuifeng@fb.com>
         <c861356d-5187-4995-4049-10ac1ee0babb@fb.com>
In-Reply-To: <c861356d-5187-4995-4049-10ac1ee0babb@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db215ff4-5f8e-4b02-6ff6-08d9f177d9cc
x-ms-traffictypediagnostic: MWHPR15MB1280:EE_
x-microsoft-antispam-prvs: <MWHPR15MB1280A0D84B523746EBEB85E1CC359@MWHPR15MB1280.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R1ajaSM2BrOXL10OlhsNX/K0ojxXtBA32xvH+eftest0ULE5c9jRpjvkofRYQJO1F6BEAStrWlqxJ0n3ctPxzG39cf1NlBMnNMwyvyZAhXzpc5agAQDQTGZ4A+G5P+VkbsrEHSEWSQnNN8WyrgttGjbTQ0EHIzu8jc1+CfKiFSVrIci+2vxBpdpvFi8DMQihLqxLAT9QylnOiOYFAF3ecgvKvZblJt8fO9zX7wlGtZ2IDv83vzfVBp79piZrMPHuclZC6UVRVIZPkmbqzd9y9PYj4qr1pmkEmvaAhZgOzF8wSj+UBMgv3UZffGq1Xp7aoORsdb/EOoSLnff/r6f2PLGA0QlYbC/vOrS0Vr2l9ALxCsg8Ry0iRW1RLNxb88Nl6VMNRpDWIxKDAVp2jGVUS4Ws76WSfEK05XR8xfFoVWj7Rt7yyo9kZAGOV6usQLJx15U4LJ3ELpIs9oYo3y7wh4ow71KFb0Yn5uf5FHUbgJXDFXneGBHkAn3yEauH6pFgefxat0huuNBkA3Dis7yaGkemlOWkHiZunPUKaXDNPsyUuKn5v6VuwuMgZ5IR/lR/uG5CkddmGBbBziiwHWea2YRyZLXvdEBYVjhhFjFzKaLU51gyi1RvHr25E0RaQAocV6uyq44WCffGV+wIqjQzlhBb0Xk0vBbgJSZmtE29mcYdXwQugQ9lQQsEqHpu0jwBuEI6YxpM1ZQm6K8t3swFtA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(4744005)(6486002)(38100700002)(508600001)(6506007)(53546011)(38070700005)(71200400001)(86362001)(6512007)(2906002)(110136005)(316002)(186003)(8676002)(66446008)(64756008)(36756003)(66946007)(66556008)(66476007)(4326008)(91956017)(76116006)(83380400001)(5660300002)(2616005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnE3d0JoYWQydzV0NWhQUzhWc3NDVjZud0syckhncVFSTkxMNzF3KzRXK2dw?=
 =?utf-8?B?UUdHa01OeDlPZ0kvR0RzUG9Pc2ZmUzRLMGVQa0JpRFYwdDVPd05kSlJPOEg5?=
 =?utf-8?B?OFZBWWtPNUFBQmZRNlc4T0tRNFk4Y29pck9xTzJ5VXBvTENBSnpLQitwVm5i?=
 =?utf-8?B?d2xUeVMrZWhvMHBLS2Z5QzhYVitnRVVCUjVWSG11NTRQc2F3T21ZaWRxb2xK?=
 =?utf-8?B?dE1RSTNHaFJTeVliK24zMFJjbysxTFI0NGk2STJydlZINGpmaEVVV0Q2cG1w?=
 =?utf-8?B?b2VlM3JBV01QTGNPMDRBaWNYWHArNTg3aVJCK25zS1hqM0hnWHZXanh0MzZI?=
 =?utf-8?B?V1VyNmc1MHNFNWJBdzAvVnhHeTI3OFdjaStDWHpwcmVteVFXaVVtbUdmeVhn?=
 =?utf-8?B?MVJkcXNrNXZPeWx2cEVvK1BmeTJ2dDY5dzB1bnowdmlHUXVESTZYQi9JUDVQ?=
 =?utf-8?B?WEdrSUNXWVRDTDFpR0VUajhqWG04dkM5SlBFNEhkR3FHZnpyaGhvSEF0V1FE?=
 =?utf-8?B?ZXNMZ3l3cXVublQ2UitOeXR2QXBuMFlJeDBGRVpGanB4UHBNL0szQUUrY1Zo?=
 =?utf-8?B?dU9SZjQ4WmpkRXFxWkkxUnFwRDE2M2VuUDJUa3hralAydVZaM1NWZDZYUTV6?=
 =?utf-8?B?QXhMUk41SW5VU000RVdjeS9DZ3JmTjRxZG05cHRhZmN4cGRyRTZUeitsZ1o4?=
 =?utf-8?B?Mk9Wa3FBSDhPZ1dsWGdHbmVGMnlESW9QWGw3K3BTRjNKdzIwRklUUysxbTV4?=
 =?utf-8?B?anRZdTRBSVl3b3A2Q0xZOGttM05wNWd6UnpvVFhmTnV1WVBXUUxYZ3dTTklo?=
 =?utf-8?B?dXQ0VHk3blFzcVdDcGU4NGpJcnpnanBHSHdwZVQ4am16R1VDcmd6Z2pHL29J?=
 =?utf-8?B?bC9vb2xodDVIZVFsTXVIbUJQUGlZVXVldWNaa2FvR3Y5NUxvVjJtMTVMRjRp?=
 =?utf-8?B?eWg0QkpNd1VSMFZLdm9IUnRtb05mNGtFQjlnNkhYT1MrVWdCS1pILzlrSmdO?=
 =?utf-8?B?Q1MyeStFT0dmcDgwMDNtVWdVcnBzWGszVmdHMUJLTmt1c0lJNDlISTQ1cm1a?=
 =?utf-8?B?dUJVRlhER2RTOEZRdUpCZ1RSK1JRaWFuMzd4akxLbTdvWGlCWlh0WkZIeG5S?=
 =?utf-8?B?QndoTVVTNTd1SjlvSjd1bmRBL2VjZUNYVnUxaXR2VVFZZGFyNHVsQXdHQ1Ay?=
 =?utf-8?B?eE9qOWZmbXhCWFpMcUdxR0xPWHZZSVF2UUVBU1ZFYkVka1ZZVWgvWXhUdWVF?=
 =?utf-8?B?WFR3a1pxM05mbHVaeUlnT2Z0WHRWVUpNdDRwNXcya2RJT29uMDZ0aytlSUdK?=
 =?utf-8?B?a0NnR0ZabHFQV1gyL0UzQzZCS2lOakVhekM4b0lrRTdRbDZULzd2SnJpRHBm?=
 =?utf-8?B?eXZhVTlHSUtpRy8xMUljQ292NkdIdXZVRlE5S0VWUE1BZWM3UStkQjUxNVFs?=
 =?utf-8?B?T1o0dnkwMzdSUjhVTVVPVUFLTVdjNW1MdDRDNXFXeVJSclZQYVMyc1hEVlF4?=
 =?utf-8?B?M3pUY1hCVnY2YnJMbmxiSkZZcFF0RDJVUFBZcjZaVnZJNkl2aCtGUmhHV0Zn?=
 =?utf-8?B?MGVhaS84a3BOQ1V5ckRSNDRGT2pQald6bjRObHplenZaTlJERkZGS0JWZlds?=
 =?utf-8?B?L1VKeE9WOVlWc2UwcGdoaThoNnNPT1Nmd0UvTjUrU0hjREQzZzZRSFMwUGMv?=
 =?utf-8?B?ZWpIRE1pQkRiVEFrSlJtY3R6RVA2YTdrdFp5YjcySlRaYkVWZ2dSM1BvN3Br?=
 =?utf-8?B?bS93RXZ4clN4T3FXZko4UVlHbnRubExOSmN2c2ltSDc0dXRRcFNzREVPdEVI?=
 =?utf-8?B?N1lCVWlyMjBwV203OEUxUElUcURwY2IrbHVjOXROSytHbkFTSVo5cTc2eEhT?=
 =?utf-8?B?L0ZIclovUHY2S3MyQ3pqbkdvNVNCbTBkL3I4K3E2NzVUclllcGR0ckVjZGRB?=
 =?utf-8?B?YzhhYXluZGF4dnpkd1NEVVo0M2t2bllvOVR6WEhmZm9IaFYremV2VU9pOUdO?=
 =?utf-8?B?VTk1Vjc4MHpsd2ltUW1QWE5ielh3NFE0RGpOZkZ4SVllYXZnSjFIZnQxd3p1?=
 =?utf-8?B?RVJhbTJULzFuUzVZSUI0Wmtvb1U5ZDFGRXQvWlRja2V1RTFhd0orQ0cvdnZi?=
 =?utf-8?B?WmFZUHhjUE44Ukc1c0IxSHprMno1L0Q2U0NKTGN5STFZRGVXZjJ4RTYyeVVw?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8802F7143278E3479D5334698E7D8834@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db215ff4-5f8e-4b02-6ff6-08d9f177d9cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 18:12:10.6467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0vKKWIOlXaVHo9j0Pyc9A8AIP+PzvQ5SNNLseIciZufuiyoH8M/AMrugTAKQdRF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1280
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: F2H_NT02-YEiwE3i4jUQtGjlyGiu0tQV
X-Proofpoint-ORIG-GUID: F2H_NT02-YEiwE3i4jUQtGjlyGiu0tQV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_08,2022-02-16_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160102
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gVHVlLCAyMDIyLTAyLTE1IGF0IDIwOjMyIC0wODAwLCBZb25naG9uZyBTb25nIHdyb3RlOg0K
PiANCj4gDQo+IE9uIDIvMTUvMjIgNDo0NiBQTSwgS3VpLUZlbmcgTGVlIHdyb3RlOg0KPiA+IFBh
c3MgYSAtaiBhcmd1bWVudCB0byBwYWhvbGUgdG8gcGFyc2UgRFdBUkYgYW5kIGdlbmVyYXRlIEJU
RiB3aXRoDQo+ID4gbXVsdGl0aHJlYWRpbmcuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogS3Vp
LUZlbmcgTGVlIDxrdWlmZW5nQGZiLmNvbT4NCj4gPiAtLS0NCj4gPiDCoCBzY3JpcHRzL3BhaG9s
ZS1mbGFncy5zaCB8IDIgKy0NCj4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyks
IDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvc2NyaXB0cy9wYWhvbGUtZmxh
Z3Muc2ggYi9zY3JpcHRzL3BhaG9sZS1mbGFncy5zaA0KPiA+IGluZGV4IGMyOTM5NDE2MTJlNy4u
NzNmMjM3Y2U0NGU4IDEwMDc1NQ0KPiA+IC0tLSBhL3NjcmlwdHMvcGFob2xlLWZsYWdzLnNoDQo+
ID4gKysrIGIvc2NyaXB0cy9wYWhvbGUtZmxhZ3Muc2gNCj4gPiBAQCAtMSw3ICsxLDcgQEANCj4g
PiDCoCAjIS9iaW4vc2gNCj4gPiDCoCAjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ID4gwqAgDQo+ID4gLWV4dHJhX3BhaG9sZW9wdD0NCj4gPiArZXh0cmFfcGFob2xlb3B0PS1q
DQo+IA0KPiAtaiBvcHRpb24gc2VlbXMgb25seSBhdmFpbGFibGUgZm9yIHZlcnNpb24gPj0gMS4y
Mg0KPiAocGxlYXNlIGRvdWJsZSBjaGVjaykuDQo+IFRoZSBzY3JpcHQgc2NyaXB0cy9wYWhvbGUt
dmVyc2lvbi5zaCBjYW4gYmUgdXNlZCB0bw0KPiBkZXRlcm1pbmUgdGhlIHBhaG9sZSB2ZXJzaW9u
Lg0KPiANCg0KWW91IGFyZSByaWdodC4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQoNCg==
