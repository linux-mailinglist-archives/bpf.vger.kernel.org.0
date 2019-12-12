Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EE011D64D
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 19:51:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfLLSvk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 13:51:40 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:52844 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730511AbfLLSvj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 13:51:39 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBCIirPj013374;
        Thu, 12 Dec 2019 10:51:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=JAc6M0rspyV+cTcojEK0Z2foWIRRD2+gbFTiZm+JXpg=;
 b=P4sdkC7rPjkjv61WAvUGh2gIOFiJAzHPH3II7ZiF+vLyHlU9ikSWpOZSRlXtZUcOQ6xQ
 AU9LLtit0cYsoegSgXzbfb5th39RS6D19goc+6ONMqjYNEOar3oHhOOE+3osKS0KZ/zc
 raLnNvZZ/QMa3rMIqA0FiKyEcuUFy60yBXs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wu4ehnx0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Dec 2019 10:51:22 -0800
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 12 Dec 2019 10:51:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 10:51:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn22XgE+1b0aHQxEY3xt3+yVEorpqFty94isl+pmgtOKYJBNPSTbfK/e/tjykVPNbYGydIuppYMj5nxotD2hpf2XjX/WmEWGOeiKtFz6IDQKIRdt5PrXQ9UPPHCvGTl1f/vIgxsJJQmehGTQMo5ze7eu47EWesGfbUd1Rf5SYtERdS9M7WNrTw7XUYMK894a/zt9OGggsdHP3fzSchXTBRPzLfWQT5IurIlt1ohi0yYl46UFxw9KpVa/i4GLBwAbUm8Q6UUMitGFEAKWnTQg9K0AtWI74q9MI7/NIA1o/Aa2aG473bRxYl8AnHj6fBRU59fXest7ZtPBWomKtV3+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAc6M0rspyV+cTcojEK0Z2foWIRRD2+gbFTiZm+JXpg=;
 b=WKtPs97JANVHmR4lwJ5bQpbLfB/CdVP/JtC4eIvJKHqjOfOPRLzhrR4V8TcsMGSnJmWi6xIS967S54000aJYFbKaqr8xmY6aMWqS6n3KcDkPYYiY41HHJz5gSGlQFugMXBmUaz1IeeKcm8XsICn+zWvwY4ZJtxSvKZecHrw65LRrwAIbMn6Wi97Ds6iNrQtfjYoauZMdl5QvhlS75X74ePpfpkk9RUr5OBgKtDWvmFNazp5f8wfVvkPr9CoagfHyDcZYqXpq+buUCXlju+EI9VHBzHpmlAMe3Hysr3bVaqTidV3N+TzxRr7sKfg2uAvidOf4aizRRVyVK6fxOTqJvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAc6M0rspyV+cTcojEK0Z2foWIRRD2+gbFTiZm+JXpg=;
 b=M+UJaTcWVz5qB+qfFDkRl7OIT9yTkkxITH6vtE5eQMtlqI8zBNWDSBkvLAlANBUNwHYIfiGepDrOnyR8+0UOgiXapJg8+L5yJ/xXPS/Q0CF3zKEbmDAmkK75bTiJHG8jKfQbGyLVbCiFuYV/HWOBNzlLe41Vh/zfRDXTqECkyD8=
Received: from MWHPR15MB1294.namprd15.prod.outlook.com (10.175.3.150) by
 MWHPR15MB1758.namprd15.prod.outlook.com (10.174.255.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 12 Dec 2019 18:51:20 +0000
Received: from MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c]) by MWHPR15MB1294.namprd15.prod.outlook.com
 ([fe80::5160:b3c0:bed1:e26c%10]) with mapi id 15.20.2538.017; Thu, 12 Dec
 2019 18:51:20 +0000
From:   Andrey Ignatov <rdna@fb.com>
To:     Martin Lau <kafai@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 5/5] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Topic: [PATCH bpf-next 5/5] selftests/bpf: Cover BPF_F_REPLACE in
 test_cgroup_attach
Thread-Index: AQHVsRmnjJdytZyL+UGHM6g9PcqP4ae22BMA
Date:   Thu, 12 Dec 2019 18:51:20 +0000
Message-ID: <20191212185118.GB65217@rdna-mbp>
References: <cover.1576031228.git.rdna@fb.com>
 <829ef294f0395649f459334b48d4d9a6103a4fc1.1576031228.git.rdna@fb.com>
 <20191212182616.le7deuzfis2r2sah@kafai-mbp>
In-Reply-To: <20191212182616.le7deuzfis2r2sah@kafai-mbp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0066.namprd14.prod.outlook.com
 (2603:10b6:300:81::28) To MWHPR15MB1294.namprd15.prod.outlook.com
 (2603:10b6:320:25::22)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:f3cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 647b302c-258f-4599-69e6-08d77f3446f3
x-ms-traffictypediagnostic: MWHPR15MB1758:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR15MB175805D3BDC8AD7ABBDF4629A8550@MWHPR15MB1758.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(39860400002)(366004)(376002)(396003)(346002)(189003)(199004)(6862004)(6512007)(81166006)(478600001)(6486002)(4326008)(33656002)(66946007)(6636002)(66446008)(81156014)(8936002)(8676002)(9686003)(66476007)(64756008)(66556008)(1076003)(86362001)(33716001)(186003)(2906002)(54906003)(4744005)(4001150100001)(52116002)(5660300002)(71200400001)(6506007)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1758;H:MWHPR15MB1294.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y2CcayjUizWr3pp7wTrIQHG/lRtYiC4GaeV7EVe0bQj/Wm1l9hgNTsU1hBOTFhdwHwxmQ+qUJZRN+ClBaJIMdol05RRkfB+Dsvf7VINy0Im3hTfZwcLhxsUyLcKvuwdt6gAZdOHkUnsbVow9dsM2awEAurfLcZOkV1tvBaSxnJydH2kRz+YXf1zgxsCdhPUMCs7NPH63kEsdEY3cxnlINB6mGagRd84WzbkHzOsgu8r0FYnqiJ2il+pvWb5d8WmgXpreZN1+2cae7/VHk55nRRg6PgilLdZ0qck9tl73Y1Zt73X8QcD+F9Qp1zXApdGwGVpFX1axOH5IJsEamUY5kc85wTpzfYAcTpF978/vBd8BBxewiRbQty4rezMQsNL1vm8AGlF/sseyMwGBoVVu04gzPWFAuG+Cj/b857VL5QyQWM7540CVb2ZE1uACmyRO
Content-Type: text/plain; charset="utf-8"
Content-ID: <63A4DD4E06450B4EB61DBCB24787C7D0@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 647b302c-258f-4599-69e6-08d77f3446f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 18:51:20.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AzlLwOPHnR6h1GRYBVN+oPngNEl1fIqiFVMs+8Al9JOsz/pfOI/oGaYY0fs7hOoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1758
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_06:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 mlxlogscore=729 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120143
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

TWFydGluIExhdSA8a2FmYWlAZmIuY29tPiBbVGh1LCAyMDE5LTEyLTEyIDEwOjI2IC0wODAwXToN
Cj4gT24gVHVlLCBEZWMgMTAsIDIwMTkgYXQgMDY6MzM6MzFQTSAtMDgwMCwgQW5kcmV5IElnbmF0
b3Ygd3JvdGU6DQouLi4NCj4gPiArCWF0dGFjaF9hdHRyLnJlcGxhY2VfcHJvZ19mZCA9IC0xOw0K
PiA+ICsJaWYgKCFicGZfcHJvZ19hdHRhY2hfeGF0dHIoJmF0dGFjaF9hdHRyKSkgew0KPiBUaGUg
d2hvbGUgc2V0IExHVE0uICBJIGV4cGVjdCB0aGlzIGF0dGFjaCBiaXQgd2lsbCBjaGFuZ2UgYmFz
ZWQgb24NCj4gdGhlIGRpc2N1c3Npb24gaW4gcGF0Y2ggNC4NCg0KUmlnaHQsIEknbGwgY2hhbmdl
IGxpYmJwZiBwYXJ0IGFuZCB0aGlzIHRlc3QgYWNjb3JkaW5nIHRvIHRoZSBmZWVkYmFjaw0KZnJv
bSBBbmRyaWkgYW5kIHNlbmQgdjIuDQoNClRoYW5rIHlvdSEgDQoNCi0tIA0KQW5kcmV5IElnbmF0
b3YNCg==
