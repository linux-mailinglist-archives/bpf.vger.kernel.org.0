Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AD6E5617
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2019 23:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbfJYVmv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Oct 2019 17:42:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37178 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725811AbfJYVmu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 25 Oct 2019 17:42:50 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9PLdAKx001191;
        Fri, 25 Oct 2019 14:42:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=ZXZpI75wkvUYk5rOoc+ft3t68xzXRgY/H7G+C1bh3wU=;
 b=A0XMXPJc+rI/0e5dIIuvd/r9sTnmvZkOgJY3fYPFCl5Dst9tk5me8oS2AlgM0E6zn761
 HAJj5VjZVqiWRMTCk8TzMdS5eS4K4RfM6B29biSyNtRdcW8E2RSvmi7eZwXCHCqNkZo/
 J13kQB+v9T4TKB/v/U8sdtafWCU/8OP4ZSs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vv2k3j3r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 25 Oct 2019 14:42:34 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 25 Oct 2019 14:42:34 -0700
Received: from NAM01-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 25 Oct 2019 14:42:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XCoV4XI+koyytwGwgszT3NcmsCaEwlWiJKVXhbMACRSdDClTA7XUELuGicyQYDaBoV2cRks3rrHysu4KMzV/45UkGDyTf3g2X//QHsbH3vgTr8Ogsbxo22r5at2s3pMqffJi/wZpbblZwtHOY8Xeb6/AytO4zG4RILqEPOq5g9z/CafvCZgYxzAqGrCg1AVWpONpZPBz6Qt073WsAHQsly8ho5pg2QAoFXuvsc+cHiSbSsS1iqvBqrFnIn1OemzIbcmCUO7ccR6m2GU0qgwI54idaimG0sV393N+qFoSFfrBrS0199j8Q4WesBw5TUFvSZLEZKy+fqLUX39Wruc3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZpI75wkvUYk5rOoc+ft3t68xzXRgY/H7G+C1bh3wU=;
 b=fGDSNySYFiBaZReGImRJDpOZ7blUt4+4XmjSXxbcG6M9Nlg2xP3wYC+9z6XvqUOqzaTEVTpaFzF/web0aXi5cKSjUwNx4bysZwviAyk5xDelMiGGAlY5txW6rYORNtbhqohrxMK2T28rahDRBWyOJTGbTdqpyvGRamG4bjhlkp5d4UGneMNIF2KGvpMihjzFsc4GIDzs6YzfsJ24MAyctGexICYh0MYP14kb9KJ4KbRUUQTNcUonffoI3vMH5SIqkL+TUOyAeai1J5BEW2mVOAACBz/7bXNVQVjW4jzScxxWIQvj1x/6FqDkpEGz+xCbjtYIw8UG3WBAPnB+75I2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXZpI75wkvUYk5rOoc+ft3t68xzXRgY/H7G+C1bh3wU=;
 b=Q+cP6kJypJFKyfYCMkEHxXfcJp9qGImf59opSxUU6/jod6WWaBqYtbQz+lzHnhY9WZtURwCxldzzVWLmGFAK6So5QOZY7OUHKZlQaCJUPbXoF6ugbHpYa8C0SwFZXithbxlHy71Led4RdnseQv3qCDREz8a38QZzYZMIbB2NwSk=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB3367.namprd15.prod.outlook.com (20.179.56.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.24; Fri, 25 Oct 2019 21:42:32 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2387.021; Fri, 25 Oct 2019
 21:42:32 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Jiong Wang <jiong.wang@netronome.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Topic: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Index: AQHViQ8bekJNizadfUWedWpSMU1ckadngLSAgALgjwCAAYbRgA==
Date:   Fri, 25 Oct 2019 21:42:32 +0000
Message-ID: <1ec37838-966f-ec0b-5223-ca9b6eb0860d@fb.com>
References: <20191022043119.2625263-1-yhs@fb.com>
 <20191022192953.GB31343@pc-66.home>
 <f666fdcd-9b02-ca47-509b-aaffb3cf7c09@fb.com>
 <CAMsOgNDHEF5qYNFLvXfbXr9CBeYD_2W3465=t7mbmQnPbSv88A@mail.gmail.com>
In-Reply-To: <CAMsOgNDHEF5qYNFLvXfbXr9CBeYD_2W3465=t7mbmQnPbSv88A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR01CA0027.prod.exchangelabs.com (2603:10b6:300:101::13)
 To BYAPR15MB3384.namprd15.prod.outlook.com (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:3057]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3174d4ad-8ef2-491a-f161-08d759943dde
x-ms-traffictypediagnostic: BYAPR15MB3367:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB3367675F55D63696242F1982D3650@BYAPR15MB3367.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 02015246A9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(346002)(396003)(366004)(136003)(189003)(199004)(99286004)(316002)(478600001)(6306002)(966005)(14454004)(256004)(229853002)(14444005)(6246003)(86362001)(2906002)(66476007)(6116002)(76176011)(31686004)(6512007)(52116002)(66446008)(66556008)(64756008)(71200400001)(66946007)(71190400001)(31696002)(305945005)(7736002)(46003)(446003)(25786009)(476003)(6916009)(11346002)(2616005)(6506007)(53546011)(386003)(186003)(486006)(36756003)(81156014)(54906003)(6436002)(6486002)(4326008)(8676002)(5660300002)(81166006)(8936002)(102836004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3367;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irNu7kT/bt7Qx725t7vK4jdM2uh6OzB2eU33O33/pq2l4bLRH1OcuQes4s4IDT8h5SNWecHmonsB17AoC70A/bAXH6zarrAd/sovFod4DwGaNoMS24tYberi/FDQZXGJ73kyhXu55EUwBd6UfSn7NrF4RhsJYum3fQTmCTf7iyCk9gSO5BmsrIyQeghaQMaq+C/7RQXkPwrqgLUY38aP95RbAg1jQgWaDlhd7yYjybRYJcgYEnIJ3gU5l36KxIIIbF+s0ZnNG/QWMZ2biIVDDuP3WnY1bIfkhsKbCx8ybEqVplbsqu1K3Sf4nS51OmcMx1w632w0WyvIQsOeuKHvmyXcL9myNAPz5nOuUIIgPI7VW3R3pwhOO5/ohAJEFsXwTfLbiqalh0zIDnvkUd9bHrDpcCJz7WQVN7342yPvh11/0GCZ0aWGxdDyxMQTZdxpTPL9Mjs1/Oft7+piwT6yNX4QU/ZI9ZxtDvBF8ah7JZY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1E0BDF7CE02CFF4BACDA45AFEFD1167F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3174d4ad-8ef2-491a-f161-08d759943dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2019 21:42:32.6126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cpvAcmb0omw1hwj//sXqd2fUA6lMHfxVVh4YhxgV1kgw5VPkPOc9r+XnMSUTxCrC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3367
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-25_10:2019-10-25,2019-10-25 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 mlxlogscore=999 impostorscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910250195
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEwLzI0LzE5IDM6MjMgUE0sIEppb25nIFdhbmcgd3JvdGU6DQo+IE9uIFdlZCwgT2N0
IDIzLCAyMDE5IGF0IDM6MjcgQU0gWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4gd3JvdGU6DQo+
Pg0KPj4NCj4+DQo+PiBPbiAxMC8yMi8xOSAxMjoyOSBQTSwgRGFuaWVsIEJvcmttYW5uIHdyb3Rl
Og0KPj4+IE9uIE1vbiwgT2N0IDIxLCAyMDE5IGF0IDA5OjMxOjE5UE0gLTA3MDAsIFlvbmdob25n
IFNvbmcgd3JvdGU6DQo+Pj4+IGxsdm0gYWx1MzIgd2FzIGludHJvZHVjZWQgaW4gbGx2bTc6DQo+
Pj4+ICAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMt
M0FfX3Jldmlld3MubGx2bS5vcmdfckwzMjU5ODcmZD1Ed0lCQWcmYz01VkQwUlR0TmxUaDN5Y2Q0
MWIzTVV3JnI9REE4ZTFCNXIwNzN2SXFSckZ6N01SQSZtPTBWQ1ZzLWFJdGthVkxSSjlKcDdZZVgw
V2UySlBLemNZN3BfODNIbGtzbzQmcz1NMEFOdmg4MHRETlpiNUp6RTV2ajlJRVRrS0Q4N0wxakZr
Y1JIU2hDNlJrJmU9DQo+Pj4+ICAgICBodHRwczovL3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20v
djIvdXJsP3U9aHR0cHMtM0FfX3Jldmlld3MubGx2bS5vcmdfckwzMjU5ODkmZD1Ed0lCQWcmYz01
VkQwUlR0TmxUaDN5Y2Q0MWIzTVV3JnI9REE4ZTFCNXIwNzN2SXFSckZ6N01SQSZtPTBWQ1ZzLWFJ
dGthVkxSSjlKcDdZZVgwV2UySlBLemNZN3BfODNIbGtzbzQmcz1MQUJscnE5RTZ0bUN3cmJVMmJD
UWFfTHdjaENhTDhUazVHY3pNQ081Q3ZzJmU9DQo+Pj4+IEV4cGVyaW1lbnRzIHNob3dlZCB0aGF0
IGluIGdlbmVyYWwgcGVyZm9ybWFuY2UNCj4+Pj4gaXMgYmV0dGVyIHdpdGggYWx1MzIgZW5hYmxl
ZDoNCj4+Pj4gICAgIGh0dHBzOi8vdXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1o
dHRwcy0zQV9fbHduLm5ldF9BcnRpY2xlc183NzUzMTZfJmQ9RHdJQkFnJmM9NVZEMFJUdE5sVGgz
eWNkNDFiM01VdyZyPURBOGUxQjVyMDczdklxUnJGejdNUkEmbT0wVkNWcy1hSXRrYVZMUko5SnA3
WWVYMFdlMkpQS3pjWTdwXzgzSGxrc280JnM9cVNESUlrYXV4dzlZXzhyWUgwQWx2QjRudnUwNnJl
RHVoc2IwR3hTcG9CbyZlPQ0KPj4+Pg0KPj4+PiBUaGlzIHBhdGNoIHR1cm5lZCBvbiBhbHUzMiB3
aXRoIG5vLWZsYXZvciB0ZXN0X3Byb2dzDQo+Pj4+IHdoaWNoIGlzIHRlc3RlZCBtb3N0IG9mdGVu
LiBUaGUgZmxhdm9yIHRlc3QgYXQNCj4+Pj4gbm9fYWx1MzIvdGVzdF9wcm9ncyBjYW4gYmUgdXNl
ZCB0byB0ZXN0IHdpdGhvdXQNCj4+Pj4gYWx1MzIgZW5hYmxlZC4gVGhlIE1ha2VmaWxlIGNoZWNr
IGZvciB3aGV0aGVyDQo+Pj4+IGxsdm0gc3VwcG9ydHMgJy1tYXR0cj0rYWx1MzIgLW1jcHU9djMn
IGlzDQo+Pj4+IHJlbW92ZWQgYXMgbGx2bTcgc2hvdWxkIGJlIGF2YWlsYWJsZSBmb3IgcmVjZW50
DQo+Pj4+IGRpc3RyaWJ1dGlvbnMgYW5kIGFsc28gbGF0ZXN0IGxsdm0gaXMgcHJlZmVycmVkDQo+
Pj4+IHRvIHJ1biBicGYgc2VsZnRlc3RzLg0KPj4+Pg0KPj4+PiBOb3RlIHRoYXQgam1wMzIgaXMg
Y2hlY2tlZCBieSAtbWNwdT1wcm9iZSBhbmQNCj4+Pj4gd2lsbCBiZSBlbmFibGVkIGlmIHRoZSBo
b3N0IGtlcm5lbCBzdXBwb3J0cyBpdC4NCj4+Pj4NCj4+Pj4gQ2M6IEppb25nIFdhbmcgPGppb25n
LndhbmdAbmV0cm9ub21lLmNvbT4NCj4+Pj4gQWNrZWQtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpbkBmYi5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFlvbmdob25nIFNvbmcgPHloc0BmYi5j
b20+DQo+Pj4NCj4+PiBBcHBsaWVkLCB0aGFua3MhDQo+Pj4NCj4+PiBXb3VsZCBpdCBtYWtlIHNl
bnNlIHRvIGluY2x1ZGUgLW1hdHRyPSthbHUzMiBhbHNvIGludG8gLW1jcHU9cHJvYmUNCj4+PiBv
biBMTFZNIHNpZGUgb3IgaXMgdGhlIHJhdGlvbmFsZSB0byBub3QgZG8gaXQgdGhhdCB0aGlzIGNh
dXNlcyBhDQo+Pj4gcGVuYWx0eSBmb3IgdmFyaW91cyBvdGhlciwgbm9uLXg4NiBhcmNocyB3aGVu
IGRvbmUgYnkgZGVmYXVsdA0KPj4+IChhbHRob3VnaCB0aGV5IGNvdWxkIG9wdC1vdXQgYXQgdGhl
IHNhbWUgdGltZSB2aWEgLW1hdHRyPS1hbHUzMik/DQo+Pg0KPj4gVGhlIGN1cnJlbnQgLW1jcHU9
cHJvYmUgaXMgbW9zdGx5IHRvIHByb3ZpZGUgd2hldGhlciBwYXJ0aWN1bGFyDQo+PiBpbnN0cnVj
dGlvbihzKSBhcmUgc3VwcG9ydGVkIGJ5IHRoZSBrZXJuZWwgb3Igbm90LiBUaGlzIGZvbGxvd3MN
Cj4+IHRyYWRpdGlvbmFsIGNwdSBjb25jZXB0LiBGb3IgLW1hdHRyPSthbHUzMiBjYXNlLCBpbnN0
cnVjdGlvbiBzZXQNCj4+IHJlbWFpbnMgdGhlIHNhbWUsIGJ1dCB3ZSBuZWVkIHRvIHByb2JlIHZl
cmlmaWVyIGNhcGFiaWxpdHkuDQo+Pg0KPj4gQnV0IEkgYWdyZWUgdGhhdCBmb3IgYnBmIHByb2Jp
bmcgdmVyaWZpZXIgZm9yIGFsdTMyIHN1cHBvcnQNCj4+IGlzIHRvdGFsbHkgcmVhc29uYWJsZS4N
Cj4+DQo+PiBKaW9uZywgY291bGQgeW91IGhlbHAgZG8gYW4gaW1wbGVtZW50YXRpb24gaW4gbGx2
bSBzaWRlIHNpbmNlDQo+PiB5b3UgYXJlIG1vcmUgZmFtaWxpYXIgd2l0aCB3aGF0IGFsdTMyIGNh
cGFiaWxpdHkgbmVlZHMgdG8gYmUNCj4+IGNoZWNrZWQgZm9yIHZlcmlmaWVyPyBUaGFua3MhDQo+
IA0KPiBJIHRoaW5rIGFsdTMyIGNvZGUtZ2VuIGJlY29tZXMgZ29vZCBhbmQgc3RhYmxlIGFmdGVy
IGptcDMyDQo+IGluc3RydWN0aW9ucyAoY3B1PXYzKSBzdXBwb3J0ZWQsICBzbyBpZiB3ZSB3YW50
IHRvIGVuYWJsZSBhbHUzMiBhdA0KPiBkZWZhdWx0LCBwZXJoYXBzIGNvdWxkIGp1c3QgbGluayBp
dCB3aXRoIHYzIHByb2JlLCBhbmQgYWxzbyBEYW5pZWwncw0KPiBvcHQtb3V0IHN1Z2dlc3Rpb24g
bWFrZXMgc2Vuc2UuDQo+IA0KPiBXaWxsIHRyeSB0byBkbyBvbmUgaW1wbCBidXQgbm90IHN1cmUg
Y291bGQgY2F0Y2ggdGhlIHRpbWVsaW5lDQo+IHRvbW9ycm93LiBGb3Igd2hhdCBpdCdzIHdvcnRo
LCB0b21vcnJvdyB3aWxsIGJlIG15IGxhc3QgZGF5IHVzaW5nDQo+IE5ldHJvbm9tZSBlbWFpbCwg
SSB3aWxsIHVzZSB3b25nLmt3b25neXVhbi50b29sc0BnbWFpbC5jb20gZm9yDQo+IGJwZi9rZXJu
ZWwgY29udHJpYnV0aW5nIHRlbXBvcmFyaWx5Lg0KDQpKaW9uZywgdGhhbmtzIGZvciBsZXR0aW5n
IHVzIGtub3cuDQpNYXliZSB0aGUgZm9sbG93aW5nIGRpZmYgd2lsbCBiZSBva2F5Pw0KDQpkaWZm
IC0tZ2l0IGEvbGx2bS9saWIvVGFyZ2V0L0JQRi9CUEZTdWJ0YXJnZXQuY3BwIA0KYi9sbHZtL2xp
Yi9UYXJnZXQvQlBGL0JQRlN1YnRhcmdldC5jcHANCmluZGV4IGFiMzQ1MjUwMWI5Li5mM2NiMDNi
MWYxZiAxMDA2NDQNCi0tLSBhL2xsdm0vbGliL1RhcmdldC9CUEYvQlBGU3VidGFyZ2V0LmNwcA0K
KysrIGIvbGx2bS9saWIvVGFyZ2V0L0JQRi9CUEZTdWJ0YXJnZXQuY3BwDQpAQCAtNTIsNiArNTIs
NyBAQCB2b2lkIEJQRlN1YnRhcmdldDo6aW5pdFN1YnRhcmdldEZlYXR1cmVzKFN0cmluZ1JlZiAN
CkNQVSwgU3RyaW5nUmVmIEZTKSB7DQogICAgaWYgKENQVSA9PSAidjMiKSB7DQogICAgICBIYXNK
bXBFeHQgPSB0cnVlOw0KICAgICAgSGFzSm1wMzIgPSB0cnVlOw0KKyAgICBIYXNBbHUzMiA9IHRy
dWU7DQogICAgICByZXR1cm47DQogICAgfQ0KICB9DQoNCkNvbnNpZGVyaW5nIGluIGdlbmVyYWwg
LW1hdHRyPSthbHUzMiBpbXByb3ZlcyBjb2RlIHNpemUgYW5kDQpwZXJmb3JtYW5jZS4gSSBkb24n
dCB0aGluayB0aGVyZSBpcyBuZWVkIHRvIGRpc2FibGUgSGFzQWx1MzIuDQpBbnkgcmVncmVzc2lv
biB3ZSBzaG91bGQganVzdCBkZWJ1ZyBhbmQgZml4Lg0KV2hhdCBkbyB5b3UgdGhpbms/DQoNCllv
bmdob25nDQo=
