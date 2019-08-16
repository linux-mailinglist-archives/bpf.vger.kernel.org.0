Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B502904E1
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2019 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfHPPoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Aug 2019 11:44:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10834 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbfHPPoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Aug 2019 11:44:12 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7GFeaKR000905;
        Fri, 16 Aug 2019 08:43:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=21D7G6Ke6G6M2hj2FV6sqAHfMqazQkrXL0AmMN30+Kw=;
 b=Q405bchW6C/aLxoqXTSUk+b2zBLk563f4GpQqwIzFDsFoDV8ON18gJ8+S8buOg36jESE
 E9jTP1Dx71+lg5d8IJYcV3DCm5SmPA80QzVJn8ocRMEmfQ9ySP57VhJnJkK0VFeqOQDb
 fivqIrxBKUDvte0Hv5vzUPGgDTuSRXKTumU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2udsxesaqr-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Aug 2019 08:43:48 -0700
Received: from ash-exhub102.TheFacebook.com (2620:10d:c0a8:82::f) by
 ash-exhub104.TheFacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Aug 2019 08:43:25 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 16 Aug 2019 08:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPSYB0FruXuZJOAv2ZCyGjvdRFBza8FF8BDRrvzohx3xhJylz8BuBJMUB6u1ZiR9MY6YWNZ9Q3KG49VXsYeExlsJyAQgXtU9toKsIiLTh3QoUc/X/IKfRVo64HmQiCBQHwq2WQKSe6I4yx0BBeUcwrWyEnH8BYAKvmz97yR7Z099MG5NEqRSlWYqa7ubboapq2r0fDtL1XzOuqMyPe1LWI0ZnnBNfqZZz2R2WE80siU6JIfv70w8wxdpjHgi5EDKtIp2K8LYkwnRoDLlp9Gf8aSvM4zRDb92sFmx/k347DS5vuQJ6n3K4FBdwBu3e5bAMPe5sc3y4rUk6KdJJuzghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21D7G6Ke6G6M2hj2FV6sqAHfMqazQkrXL0AmMN30+Kw=;
 b=UaH/LiecIG2CIRsRAOoLxblebf5e0LyJDPztVFy65x2v6jHfUbcNSR+UTY/dv7B5Mld7Qx0NUcThpX7GG15oFWQ2o6P9Zjwgnj7lXxK/Vtk3FBuHlv53mREOzR7o8wu0132G3FAnja9Gf1la/FEwO8/X2ERvSrUkHi1/UYlirelZmTYotMsPX53fpuXf48xvZoagzGH6p0BmuYGZWTaIYgaxR0uwl8Pv2yPil71NCStivFRea/IHBzDDSo+V3J/rBWT5be21ZE3qMpE9DDkZU+kPJcfGGyFlUq+2KOruUNvdx1VQEao1f/792EaNQc8CZvmmG43JG75sdLyW/h6aXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=21D7G6Ke6G6M2hj2FV6sqAHfMqazQkrXL0AmMN30+Kw=;
 b=JNoIagRBb6+yXcLXqbsB5zmIV2iNM6oEjZGzYljwUjF8rMeuXkOCEFA0SoTG889zgd+57BNUaSjXG9wNJoi/f4fstVkG4qnSDEzDZwvwnjAQwWBXOdKKCBcnSfaQH1zHLGn+8u2D053DCVKUwpO3uoOdyMKzx4B8Ie5tWhJ/n9Y=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.59.17) by
 BYAPR15MB2248.namprd15.prod.outlook.com (52.135.197.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Fri, 16 Aug 2019 15:43:24 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::d95b:271:fa7e:e978%5]) with mapi id 15.20.2157.022; Fri, 16 Aug 2019
 15:43:24 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrey Ignatov <rdna@fb.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Topic: [PATCH bpf v2] bpf: fix accessing bpf_sysctl.file_pos on s390
Thread-Index: AQHVVCESLNEA0xJ8rUq0Dn4tWx4R7Kb96mYA
Date:   Fri, 16 Aug 2019 15:43:24 +0000
Message-ID: <ff6b8a11-ffdb-4500-7b09-9e255d8e9bfe@fb.com>
References: <20190816105300.49035-1-iii@linux.ibm.com>
In-Reply-To: <20190816105300.49035-1-iii@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0003.namprd22.prod.outlook.com
 (2603:10b6:300:ef::13) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:10e::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:9590]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b46c47f4-f14e-4c62-7aff-08d72260792c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2248;
x-ms-traffictypediagnostic: BYAPR15MB2248:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB22484309E6F49A3CDE2489B0D3AF0@BYAPR15MB2248.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0131D22242
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(189003)(199004)(86362001)(6246003)(31686004)(31696002)(186003)(66946007)(53546011)(386003)(6506007)(102836004)(36756003)(4326008)(6512007)(71190400001)(71200400001)(53936002)(5660300002)(25786009)(486006)(6436002)(256004)(46003)(66556008)(4744005)(64756008)(229853002)(66446008)(66476007)(14444005)(2906002)(476003)(6486002)(446003)(2616005)(11346002)(52116002)(14454004)(76176011)(316002)(54906003)(110136005)(478600001)(8676002)(6116002)(305945005)(81156014)(7736002)(81166006)(8936002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2248;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bMPNBYDwgwtHNtF28MJsYvqbvX3tQAcM3b/I4AmgQO5JF3sXnBhsQ+LVzcs8gEhXZrlA6/4Xkyqqkwv8S28ULYzMEo731DojIZxR9cDRuDBZtpVs+qFtX4iLcq6oh2GwFnxssj3fyIXfPsbKXjz0dqoBki91oh3BelI2HmG/GRVD1fLbfLdqyg0YRAPh2orXx3zj4fAKLw+JUgh6KBOYV3gqt2sr6CurpKtLF/lJGb+TJHIVO9AmuUJrMTkbPgFw5A2QbW22Ha4QM8z7B5B6D6uewHHPLBG7k+Qzxxu3pyQ8Pnd4xX5KhHYAob535s1p32nMVU5CWHYm1mDrA6aDCTZEd8hM2L4cdm3JxgLXFnYEOv/yA9gbuqmVI56p6L2GheKb227jhPUOZyGzjZv1slpL+0nP8HzHdAPbuPr1+BY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8493DD4648F7D4388FD303253716EDB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b46c47f4-f14e-4c62-7aff-08d72260792c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2019 15:43:24.3436
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qS96fQGoqz1XWEqtPLCC0ETZEfWFdINOrbvo2/uwfxn5tfh9U3hYRlZ3bkM2VEz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2248
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-16_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=911 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908160166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDgvMTYvMTkgMzo1MyBBTSwgSWx5YSBMZW9zaGtldmljaCB3cm90ZToNCj4gImN0eDpm
aWxlX3BvcyBzeXNjdGw6cmVhZCB3cml0ZSBvayIgZmFpbHMgb24gczM5MCB3aXRoICJSZWFkIHZh
bHVlICAhPQ0KPiBudXgiLiBUaGlzIGlzIGJlY2F1c2UgdmVyaWZpZXIgcmV3cml0ZXMgYSBjb21w
bGV0ZSAzMi1iaXQNCj4gYnBmX3N5c2N0bC5maWxlX3BvcyB1cGRhdGUgdG8gYSBwYXJ0aWFsIHVw
ZGF0ZSBvZiB0aGUgZmlyc3QgMzIgYml0cyBvZg0KPiA2NC1iaXQgKmJwZl9zeXNjdGxfa2Vybi5w
cG9zLCB3aGljaCBpcyBub3QgY29ycmVjdCBvbiBiaWctZW5kaWFuDQo+IHN5c3RlbXMuDQo+IA0K
PiBGaXggYnkgdXNpbmcgYW4gb2Zmc2V0IG9uIGJpZy1lbmRpYW4gc3lzdGVtcy4NCj4gDQo+IERp
dHRvIGZvciBicGZfc3lzY3RsLmZpbGVfcG9zIHJlYWRzLiBDdXJyZW50bHkgdGhlIHRlc3QgZG9l
cyBub3QgZGV0ZWN0DQo+IGEgcHJvYmxlbSB0aGVyZSwgc2luY2UgaXQgZXhwZWN0cyB0byBzZWUg
MCwgd2hpY2ggaXQgZ2V0cyB3aXRoIGhpZ2gNCj4gcHJvYmFiaWxpdHkgaW4gZXJyb3IgY2FzZXMs
IHNvIGNoYW5nZSBpdCB0byBzZWVrIHRvIG9mZnNldCAzIGFuZCBleHBlY3QNCj4gMyBpbiBicGZf
c3lzY3RsLmZpbGVfcG9zLg0KPiANCj4gRml4ZXM6IGUxNTUwYmZlMGRlNCAoImJwZjogQWRkIGZp
bGVfcG9zIGZpZWxkIHRvIGJwZl9zeXNjdGwgY3R4IikNCj4gU2lnbmVkLW9mZi1ieTogSWx5YSBM
ZW9zaGtldmljaCA8aWlpQGxpbnV4LmlibS5jb20+DQoNCkFja2VkLWJ5OiBZb25naG9uZyBTb25n
IDx5aHNAZmIuY29tPg0K
