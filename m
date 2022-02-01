Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 677294A6299
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 18:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbiBARhg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 12:37:36 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234997AbiBARhf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 1 Feb 2022 12:37:35 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 211HDn01009651
        for <bpf@vger.kernel.org>; Tue, 1 Feb 2022 09:37:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=t4NuetAYswQ+lUddUIrlJvQ2uPnk+3JZMzLR+vtzotk=;
 b=gjhdhvVKcoXQGCYp+whWmou5yQN7wkFwMJrHKMq5X/xoVdjzdi9Mqi9GpC4jGwoKr4BE
 nzyQXzuEiluKTCST8k1a0rwr9zdLRueyBKPfHasWOYJs2GhELHLKKsGKgL31IQUg73S1
 DekdM/JJE5FhQC6BPCsJJNrckt4Qikps44M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3dxvmpc6c7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 09:37:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 09:37:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRmVmqojfUc/2fF/5ToihSvVbHVFCOGHTpashM8vHtkpt+HD/FKJBuUWsbtY9IY+lWJSA0021KddGfRnfBFzmcQnBJgAPGsFfa1iG9sNj0e/TWXKxvqnxsqp/KUaM06miLcVgH2CHbaPBaF8OULbhmj9CxZ2480kexGyeJQ9UvGvfdfKpCwh6Ue+anscV8F5IzJSborQnH8a8wT8mkTG9bLL0fftRfJCdhfm/SOStaoHblY9E/Q3nobdd1Kcwc9kD/mvn1zM9mOSmeZMPvV9hUOFSv1iQZpUttbZiFBFnKXvYrL8Ib3bPxERQH4mv8jud2XGJ+t6X4h1FPWg9sPp7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4NuetAYswQ+lUddUIrlJvQ2uPnk+3JZMzLR+vtzotk=;
 b=bH9ppaBN6u/HO42YZWm0ciJHx2VEwDZQNbPlOKa8US83dJfTOSlQc0+LeWCgQrdHKgVhQHOnZrl9TfhQE1PC8IG9Md5QZybRrm966DC+6OwHlfqKKmvU0bn2WWSlqdwOBZrzEdqB5fkvINYwLPFR1dMQR14MZz1bT3G5QL4ZSo6h5T4mya9YPNAUw6DtfZK4GNmRYy5yCKtnr8jO1W6nphGoJMJUx9OdTWpTCmaE0GDqv0WkCpTX/rs7yFaSOOcwdWUfJ75jf9JxwFre8ZlNnB4ESft5/UzXeIUP4BfXEqP8AkiIcNDtLK+0Rt1GO2jdFopMlGfQl31B2XvmUU3G2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BY5PR15MB3651.namprd15.prod.outlook.com (2603:10b6:a03:1f7::15)
 by BYAPR15MB3029.namprd15.prod.outlook.com (2603:10b6:a03:fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.22; Tue, 1 Feb
 2022 17:37:32 +0000
Received: from BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24]) by BY5PR15MB3651.namprd15.prod.outlook.com
 ([fe80::74e2:d175:a6f7:cf24%6]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 17:37:32 +0000
From:   Kui-Feng Lee <kuifeng@fb.com>
To:     "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>
CC:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
Thread-Topic: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
Thread-Index: AQHYEv59zmTihbq3R0eshpelP+wgtqx2VESAgAf0dYCAALYRgA==
Date:   Tue, 1 Feb 2022 17:37:31 +0000
Message-ID: <8f1d25d8c01d7397192e3c034330c5f757eabea0.camel@fb.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
         <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
         <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com>
In-Reply-To: <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a60001ba-198c-46ec-e16c-08d9e5a986a0
x-ms-traffictypediagnostic: BYAPR15MB3029:EE_
x-microsoft-antispam-prvs: <BYAPR15MB3029E2DD4C486D75D57BBAF3CC269@BYAPR15MB3029.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c+Q6muSl0FLxt3+sY3h29MtlZOQAkimQ3NedeRj30YeHautu6tlAatH8RUdjksWNtGGjv2epHRSojfB3fRe/hwMyERXNQ9EPh+sMuEk4I4Q4VmAfv5HBsEOBVlK20iYo43Z/RFbIM/WUQNteO/39qm5mA9VA63ozQUguh+67/BgOleMq51Ycr5O5rK93Iq2LyDp5y3pkIKnZFKE/nC4SrYsJfrQdridCliJa+1QsHY52BLoT8KAcoafFIsAdfnRzZ/aQsEUsORHarFfHOYWmQ81PbWzqzfyuNl/JXc2Qjze5L76y2R9DTX38FxZaSSQLKseNxPWO3qnkfhwd0hu3Zt0YSlZum8i/iJQVEtazCZZhHXwOckNXqz+MCAOz6NKrTHHCvqQzhs4APvZLjGhBggB0tN/1janBJ7thITJEpDD/qnxYquaRt9RKR2cAVjpeOI+zkyO+PCR5R0Z6exp65Jv3CBOy3kxWF71FLt8dqHa8Y1O9kFuFQUNhGcUiAm7uAJgNzCWDojU/scifyoT7wPkfihVjshOS3GxZ/4LJLf9oPdufhJ1ZR9kheh/xvf16BF4M49MgH39abN7rRBcfL7QBTZSR7atdoabZ8d6DkZryvzLLHP0bSiHzc/QLXpRcYE/ySzCfDPHVkArf5Swfq9kcmyh4q1a6NJgTZ9LCz/JH7BzGaBFJHrdDsvkM/r5gHJBwuz4mtTJBjf1JjSx3kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3651.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(5660300002)(6512007)(186003)(4744005)(2906002)(2616005)(122000001)(86362001)(316002)(38070700005)(38100700002)(8936002)(91956017)(6486002)(110136005)(54906003)(71200400001)(508600001)(8676002)(4326008)(66556008)(36756003)(66446008)(66946007)(76116006)(64756008)(66476007)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b21XL0MrSEhTdjk1ZGVzY044SEUweE9LU2VsdkJyTkg2Z0paMWR5a0VURUMw?=
 =?utf-8?B?V2FqSmkxT0dqTUorWlY3dnNIcWdtZE1acC9qSjd3VUw1WlhIbWhXU3cycGYw?=
 =?utf-8?B?VlZWMFF2U1N2MzJrRU9oZEU2aEpVTVMzRUg4RTNtTXlYb2NkYmZlb0xFdnM3?=
 =?utf-8?B?NDY4NUdscDlHblpRUWJhejdqcDFhQW5pcW5nd3RGcURFb2phTkF0QXhNMjBL?=
 =?utf-8?B?YzQ4c3BtdGNvSTU4UmRnMk1DdDlBUis3MHJNR0cweFRHTEJzQlhSeFRKWXBO?=
 =?utf-8?B?bjFxZ3NPMlhuTFVwMUQzLzI3eXAxWjlTTEZjUVJkcStyZ1phdXQ4STdrUjNM?=
 =?utf-8?B?ejNVTWQ1TDdPNEM3Rk5GRVE1b1hIMCtqS1VMbUpjeStzcTNiakwxY2lXeEZk?=
 =?utf-8?B?bHpzeWUxQXRRVjVvZmQ3d204Yk14K0YwbGVFb0NXWW5Cc0ozVVVCYVgwSDc0?=
 =?utf-8?B?RDk0TnR3TnFkbVZyYm1Dd3Rqb2hoN2t4czk1THJVYS9ZR2JGb2ZOblpSdUd5?=
 =?utf-8?B?aTZsaEJzUjl1bFBmc0drSDZ4OGxna2VBSE41VEh6NHN6NldEd21QblorOXBC?=
 =?utf-8?B?UTlYNkZ0dWgyL3hxa044YjB5VStOOWJoV3dKOHlzbElzMlJIMHgrUEg1NTBD?=
 =?utf-8?B?MmJsakM1MzczejVZQjBnVktJNE9aRVM4Um5tVmFBd0RhZTVJN0pRSHRrL3lH?=
 =?utf-8?B?UmpEKzhvT2Jydk0weXVZazRCMkFLVFk0S3NncFJPVkNyQjhtL2g5ZEx5MUpN?=
 =?utf-8?B?d1ZoN2F5czlVM2dLSmdNRE5rVFJ6YWFpRy9VR0hJUTFocU8xZGo5d3E3MFVw?=
 =?utf-8?B?c3hIbmlTZXRPUmtuZXBVSUNyOGJWKzFiczNSeEdLMXZldCtZN093Y3FlWnM5?=
 =?utf-8?B?SXc2dXFtREpDQzIxcWxLVjk4WGtrZnNFclJ5NEhCSTFkNjNRdVdURlFKSHJH?=
 =?utf-8?B?cEEzWFFNS2Zmd1EvaHUwMVduelFVbElMamZNN2R1WlVPNXh2RCtTbEhNVzI1?=
 =?utf-8?B?NGVVMkhRc0g1QWZLeG1MMWpOSDZFSDdzMGl3UVg5QUowbVBkQkxzYUY2MkdL?=
 =?utf-8?B?UUJ3NFROZFp1Rm5NcFZ5L3ZDSXlQSE1mTWcwRHhoZ0dOdXNqZEtuMHhNMW1D?=
 =?utf-8?B?WG9qZjNoR3lQazN5SVM3OVJrMVNhNEMyeGgyTmFDYnZKUXNlT3VsN05ZdUZD?=
 =?utf-8?B?YmpEYmlHR3l4b2d5cUJPN0loV1ppM1FwVlA2aWpjQlpmM3Q5YWtxOTZMRGRX?=
 =?utf-8?B?bGx6N0FLc2tpSkwrbVJLTy82U0Qzdmc5M24wVE5VWTl4YUNCcGs5ZTJ5Y3pp?=
 =?utf-8?B?OVJLa05lbHNRNWpzSlVuSnBzczc2WFpUdXZBcTI2MFZzcGozdHRBNXFZclRz?=
 =?utf-8?B?aGZwZmV1Sm0weUliMXVmS1piMjJuVGZFZ040YTRCWDZrcksrc1JTQnVPV0RU?=
 =?utf-8?B?TTFsZ080S21iTEloemRHM3U4MnFHRXNEdXR1R1kva2FQcXVLL25nVDNRQjQy?=
 =?utf-8?B?QldzMWF1UlV6YUpCaUFQdTlPUXVTOXI3MGJGNWJySmxpeCs5dVFYNFlXczhW?=
 =?utf-8?B?d1pXcms5UUk0WXZOU2psaHlDQU44Zk9VU3RDQ1lIK25FSHE2bzVJMDdyVVp1?=
 =?utf-8?B?dDVxSlo2aGMvVHNjOWo1N0VuSnpPcytaM09UYzBjMExDRHhCRUNVeEphOTJq?=
 =?utf-8?B?Z2tQZVFIVVUwbUc5VEJzZ0JLejVHY2ZRR2VhYlJhOXA2MHlvQVRrbWFZSlh2?=
 =?utf-8?B?TjR2T2MvL3dtU2k4VEtNOWsyUmJMNWtnT3RWMlJGMzJmSHRabnR5cllmYTls?=
 =?utf-8?B?SWZxb3Q5SGYzZDV1WXVrM2QxTUtYTkpPSTR2T2hNREJibFRqdm1qdFA2alIz?=
 =?utf-8?B?cmFLbFo0NEZpdW4rMHNHZSsyb29SVk9ySjRwN0NHUmxZRTVXWWJmL3k1T0pj?=
 =?utf-8?B?Ti9LU3FOTTZIemZibGt6TG5tOTNZNmU3V1dzMkUzZUhYbTZsYTJkeGZWcTc5?=
 =?utf-8?B?UmdseVppSjFXeFFHQXRmaXJCakJKZU43eWJGVWVsa2FyeFgzUVQreVVTQkdF?=
 =?utf-8?B?UDArblhQQnJUakVhWlFCcFBtT3orMnlpWitMalRjY28yZk10TUJKampwZXkx?=
 =?utf-8?B?dDZQVFhDUnhzRGduQjVLTjJhNUVNanZ1Z2ZkMllRYWFwSXczWTlHVlovZk9q?=
 =?utf-8?B?eXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BC365DC1065BE40B0E64E63E36E6164@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3651.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60001ba-198c-46ec-e16c-08d9e5a986a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 17:37:31.9466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QqCTMadt2Z7nMPF/KYC4mpDq4ourTVgIH6nQwfqbCyHsnvd4uVZti+0h4lAJGX2e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3029
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: AiXPZ6WJzM4JChlJqBYqB3tH1WdSh1pj
X-Proofpoint-GUID: AiXPZ6WJzM4JChlJqBYqB3tH1WdSh1pj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-01_09,2022-02-01_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 suspectscore=0 mlxlogscore=794 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202010098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

T24gTW9uLCAyMDIyLTAxLTMxIGF0IDIyOjQ1IC0wODAwLCBBbmRyaWkgTmFrcnlpa28gd3JvdGU6
DQouLi4uLi4gY3V0IC4uLi4uLg0KPiBGb3IgbXVsdGktYXR0YWNoIGZlbnRyeSwgd2UgY291bGQg
dXNlIHRoZSBzYW1lIGFwcHJvYWNoIGlmIHdlIGxldA0KPiBlaXRoZXIgYnBmX2xpbmsgb3IgYnBm
X3Byb2cgYXZhaWxhYmxlIHRvIGZlbnRyeS9mZXhpdCBwcm9ncmFtIGF0DQo+IHJ1bnRpbWUuIEt1
aS1GZW5nIHNlZW1zIHRvIGJlIHN0b3JpbmcgcHJvZ19pZCBpbiBCUEYgdHJhbXBvbGluZQ0KPiBn
ZW5lcmF0ZWQgY29kZSwgSSBkb24ndCB0aGluayB0aGF0J3MgdGhlIGJlc3QgYXBwcm9hY2gsIGl0
IHdvdWxkIGJlDQo+IHByb2JhYmx5IGJldHRlciB0byBzdG9yZSBicGZfbGluayBvciBicGZfcHJv
ZyBwb2ludGVyLCB3aGljaGV2ZXIgaXMNCj4gbW9yZSBjb252ZW5pZW50LiBJIHRoaW5rIHdlIGNh
bid0IGF0dGFjaCB0aGUgc2FtZSBCUEYgcHJvZ3JhbSB0d2ljZQ0KPiB0bw0KDQpGWUksIHRoZSBw
cm9nX2lkIHVzZWQgaXMgY2FzdGluZyBmcm9tIGEgYnBmX3Byb2cgcG9pbnRlci4gIEl0IGdldHMg
YQ0KYnBmX3Byb2cgYnkgY2FzdGluZyBhIHByb2dfaWQgYmFjay4NCg0K
