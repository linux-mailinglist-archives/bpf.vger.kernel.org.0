Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1C25E1002
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2019 04:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733196AbfJWC1t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Oct 2019 22:27:49 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45494 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729994AbfJWC1s (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 22 Oct 2019 22:27:48 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9N2N0Qk018940;
        Tue, 22 Oct 2019 19:27:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mkWwJBF1OTvqn6Dc+3rPF0N5fXYiVr2zp7Wbo+pS3aU=;
 b=opw26nlaxxnPVHk7V0QyoWmDtM8t4rutdQqn9NZOrin9l5cyMFGTIfrrI0a34XN4n2bP
 67SOalKMoZvmqFoFSrztbF/yicnMd49DezZw1r6AkwP4HSSof4zLAQiRswrOja7ljymT
 MF5lIvIVnUwP+E3+p2sOVSZ9qQqaYTacr08= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2vt9t9gy77-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 22 Oct 2019 19:27:34 -0700
Received: from ash-exhub203.TheFacebook.com (2620:10d:c0a8:83::5) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Oct 2019 19:27:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Oct 2019 19:27:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e0a9MehOkUELSC2CDlxEmhL9FRWShBJe6k+RrowkV3vZX6EvZHty1Uv8UDMDmo2KK6X+iRLK/STBiOXtabOtVHV8y8VHMZv0DwJFJe5HPkPkXnQ8BjtvsJW6saak6VBITYZR+z1DdcpaJXJvubaV8DII0lrAjhrUk7/Qup5EcsAo62B39HHpaWt1ZcdlRGsb02V2/JLDdz55PUTyIEPHmFFzULDo4CMNf6zJLy/6IkmV6IRQhy28iKbI8myJ77bQeAw034qUNvSJZEExH+9vEGmMehGyvaQdq/flKiDNccwjwno37+8GI+HlXQOGdLsgaoC+dQcLNSdv1WjTTMqzsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkWwJBF1OTvqn6Dc+3rPF0N5fXYiVr2zp7Wbo+pS3aU=;
 b=KdGHP5iJPlM7zH1qY4SzYXSXXk/slHB3ddMNax/1vHS4+p7RbsYQR/WF7VR4dGKuwqlYokagLkI024vs0BY8+boYjU6VXNkZNNOChPCDRNDDkML4jq6gpgHcIi3HP3+JsczvhkhcfNWXN5frCmu9bvftLNBreb699UbQJGBLDFAPr9aVdmia3HeJa7eLwAwWBEbUDiBwc6bn+PHiHcopdvtgXnS+Pb+5znWGC4ChM65NVgW+MESPZfLzYJ97YgreO+VY5APjXX4Kgzhz4VRwd6x2Q1opc+/XERjcPpDhsHZCk1nkTJo8p3yhgoyBq0jl6WNW9ueysubCE3fR7a1wdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkWwJBF1OTvqn6Dc+3rPF0N5fXYiVr2zp7Wbo+pS3aU=;
 b=FT63pESICd9lt92Aky65C/wxhswG+LC44l6OduVn9CU3QsiTEWfqbDSx1+IrMDCU4cweUVXj0NgzBc4YNXIslRC7SYZiueRG+HQMa6yLtc8IAYmniperAXZhgaoyo5gykW4LeA0/Q5vhx8391HSFtLd0VeZ3GggImx9dEgdjrHc=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2456.namprd15.prod.outlook.com (52.135.193.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Wed, 23 Oct 2019 02:27:31 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 02:27:31 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Kernel Team <Kernel-team@fb.com>,
        Jiong Wang <jiong.wang@netronome.com>
Subject: Re: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Topic: [PATCH bpf-next v2] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Index: AQHViQ8bekJNizadfUWedWpSMU1ckadngLSA
Date:   Wed, 23 Oct 2019 02:27:31 +0000
Message-ID: <f666fdcd-9b02-ca47-509b-aaffb3cf7c09@fb.com>
References: <20191022043119.2625263-1-yhs@fb.com>
 <20191022192953.GB31343@pc-66.home>
In-Reply-To: <20191022192953.GB31343@pc-66.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::b6b9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5d59235-3746-427b-c920-08d757608e5e
x-ms-traffictypediagnostic: BYAPR15MB2456:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB24560E8EA42E6B6887B34D66D36B0@BYAPR15MB2456.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 019919A9E4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(366004)(396003)(136003)(346002)(376002)(39860400002)(199004)(189003)(478600001)(966005)(14454004)(5660300002)(54906003)(31686004)(6246003)(316002)(6436002)(66946007)(6486002)(229853002)(31696002)(25786009)(64756008)(66556008)(4326008)(66476007)(6306002)(6512007)(76176011)(36756003)(99286004)(476003)(2906002)(8936002)(52116002)(6916009)(486006)(6506007)(186003)(7736002)(305945005)(2616005)(6116002)(386003)(71200400001)(46003)(86362001)(256004)(102836004)(66446008)(8676002)(11346002)(81166006)(81156014)(71190400001)(53546011)(446003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2456;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /yOjGdgaL5/TskU9VVOeQglxath8yoZViIEEcR84jMDXaNLln5VA3oQLA29WOSJJ7n31SWWPWJpmqlqqCbxCLSoyEcgrdJvg82O7CZpXmm26HOO1T51SW4qMP/JYbyIDzEyJaceYDqDBB17d0QmBHYi5UyfbMRSJsmNJ1g0gZaYR4bYgkQP5psbBCFPkaQ3wLA/Pe/qwD4wqo9uQAdzL4aNAczZcrQ1+SuEHWmJ8+fqcLgvrxGb62xtQKraJA+Oz7ZvoxnX0m84EEAUhNQDT/V0xw4Up4rlHzl5yYtMXPXxQP/Z03XtBh0xl1NRPh5rmgB8UT+1B0W771qvmj+1ZD/cu1obb2IsJe8uvLF1ay3ljYyEY7QZ+G61aFrvSJH7aqXDvUBGbTkwDE3XOhJjkGotExEXhrAhrmKintNsjkCEAAAO0H3rZJx9/vNciiOyPIOu3v4X94wYc4i9FsciBU8QWRYexRPzVSrAjI8iTVX4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EA3C51906CC6479E4E03486A9AE2AD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d59235-3746-427b-c920-08d757608e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 02:27:31.5796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3le1Y8rJWsT6GCNQ8+hfpkQ2yT9YEKIwmcaScy/V39d+qPSP4u4gZpidVKMK1yGs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2456
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-23_01:2019-10-22,2019-10-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 phishscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxlogscore=959
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910230022
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEwLzIyLzE5IDEyOjI5IFBNLCBEYW5pZWwgQm9ya21hbm4gd3JvdGU6DQo+IE9uIE1v
biwgT2N0IDIxLCAyMDE5IGF0IDA5OjMxOjE5UE0gLTA3MDAsIFlvbmdob25nIFNvbmcgd3JvdGU6
DQo+PiBsbHZtIGFsdTMyIHdhcyBpbnRyb2R1Y2VkIGluIGxsdm03Og0KPj4gICAgaHR0cHM6Ly91
cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19yZXZpZXdzLmxsdm0u
b3JnX3JMMzI1OTg3JmQ9RHdJQkFnJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZyPURBOGUxQjVy
MDczdklxUnJGejdNUkEmbT0wVkNWcy1hSXRrYVZMUko5SnA3WWVYMFdlMkpQS3pjWTdwXzgzSGxr
c280JnM9TTBBTnZoODB0RE5aYjVKekU1dmo5SUVUa0tEODdMMWpGa2NSSFNoQzZSayZlPQ0KPj4g
ICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19y
ZXZpZXdzLmxsdm0ub3JnX3JMMzI1OTg5JmQ9RHdJQkFnJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01V
dyZyPURBOGUxQjVyMDczdklxUnJGejdNUkEmbT0wVkNWcy1hSXRrYVZMUko5SnA3WWVYMFdlMkpQ
S3pjWTdwXzgzSGxrc280JnM9TEFCbHJxOUU2dG1Dd3JiVTJiQ1FhX0x3Y2hDYUw4VGs1R2N6TUNP
NUN2cyZlPQ0KPj4gRXhwZXJpbWVudHMgc2hvd2VkIHRoYXQgaW4gZ2VuZXJhbCBwZXJmb3JtYW5j
ZQ0KPj4gaXMgYmV0dGVyIHdpdGggYWx1MzIgZW5hYmxlZDoNCj4+ICAgIGh0dHBzOi8vdXJsZGVm
ZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbHduLm5ldF9BcnRpY2xlc183
NzUzMTZfJmQ9RHdJQkFnJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZyPURBOGUxQjVyMDczdklx
UnJGejdNUkEmbT0wVkNWcy1hSXRrYVZMUko5SnA3WWVYMFdlMkpQS3pjWTdwXzgzSGxrc280JnM9
cVNESUlrYXV4dzlZXzhyWUgwQWx2QjRudnUwNnJlRHVoc2IwR3hTcG9CbyZlPQ0KPj4NCj4+IFRo
aXMgcGF0Y2ggdHVybmVkIG9uIGFsdTMyIHdpdGggbm8tZmxhdm9yIHRlc3RfcHJvZ3MNCj4+IHdo
aWNoIGlzIHRlc3RlZCBtb3N0IG9mdGVuLiBUaGUgZmxhdm9yIHRlc3QgYXQNCj4+IG5vX2FsdTMy
L3Rlc3RfcHJvZ3MgY2FuIGJlIHVzZWQgdG8gdGVzdCB3aXRob3V0DQo+PiBhbHUzMiBlbmFibGVk
LiBUaGUgTWFrZWZpbGUgY2hlY2sgZm9yIHdoZXRoZXINCj4+IGxsdm0gc3VwcG9ydHMgJy1tYXR0
cj0rYWx1MzIgLW1jcHU9djMnIGlzDQo+PiByZW1vdmVkIGFzIGxsdm03IHNob3VsZCBiZSBhdmFp
bGFibGUgZm9yIHJlY2VudA0KPj4gZGlzdHJpYnV0aW9ucyBhbmQgYWxzbyBsYXRlc3QgbGx2bSBp
cyBwcmVmZXJyZWQNCj4+IHRvIHJ1biBicGYgc2VsZnRlc3RzLg0KPj4NCj4+IE5vdGUgdGhhdCBq
bXAzMiBpcyBjaGVja2VkIGJ5IC1tY3B1PXByb2JlIGFuZA0KPj4gd2lsbCBiZSBlbmFibGVkIGlm
IHRoZSBob3N0IGtlcm5lbCBzdXBwb3J0cyBpdC4NCj4+DQo+PiBDYzogSmlvbmcgV2FuZyA8amlv
bmcud2FuZ0BuZXRyb25vbWUuY29tPg0KPj4gQWNrZWQtYnk6IEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpbkBmYi5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29t
Pg0KPiANCj4gQXBwbGllZCwgdGhhbmtzIQ0KPiANCj4gV291bGQgaXQgbWFrZSBzZW5zZSB0byBp
bmNsdWRlIC1tYXR0cj0rYWx1MzIgYWxzbyBpbnRvIC1tY3B1PXByb2JlDQo+IG9uIExMVk0gc2lk
ZSBvciBpcyB0aGUgcmF0aW9uYWxlIHRvIG5vdCBkbyBpdCB0aGF0IHRoaXMgY2F1c2VzIGENCj4g
cGVuYWx0eSBmb3IgdmFyaW91cyBvdGhlciwgbm9uLXg4NiBhcmNocyB3aGVuIGRvbmUgYnkgZGVm
YXVsdA0KPiAoYWx0aG91Z2ggdGhleSBjb3VsZCBvcHQtb3V0IGF0IHRoZSBzYW1lIHRpbWUgdmlh
IC1tYXR0cj0tYWx1MzIpPw0KDQpUaGUgY3VycmVudCAtbWNwdT1wcm9iZSBpcyBtb3N0bHkgdG8g
cHJvdmlkZSB3aGV0aGVyIHBhcnRpY3VsYXINCmluc3RydWN0aW9uKHMpIGFyZSBzdXBwb3J0ZWQg
YnkgdGhlIGtlcm5lbCBvciBub3QuIFRoaXMgZm9sbG93cw0KdHJhZGl0aW9uYWwgY3B1IGNvbmNl
cHQuIEZvciAtbWF0dHI9K2FsdTMyIGNhc2UsIGluc3RydWN0aW9uIHNldA0KcmVtYWlucyB0aGUg
c2FtZSwgYnV0IHdlIG5lZWQgdG8gcHJvYmUgdmVyaWZpZXIgY2FwYWJpbGl0eS4NCg0KQnV0IEkg
YWdyZWUgdGhhdCBmb3IgYnBmIHByb2JpbmcgdmVyaWZpZXIgZm9yIGFsdTMyIHN1cHBvcnQNCmlz
IHRvdGFsbHkgcmVhc29uYWJsZS4NCg0KSmlvbmcsIGNvdWxkIHlvdSBoZWxwIGRvIGFuIGltcGxl
bWVudGF0aW9uIGluIGxsdm0gc2lkZSBzaW5jZQ0KeW91IGFyZSBtb3JlIGZhbWlsaWFyIHdpdGgg
d2hhdCBhbHUzMiBjYXBhYmlsaXR5IG5lZWRzIHRvIGJlDQpjaGVja2VkIGZvciB2ZXJpZmllcj8g
VGhhbmtzIQ0KDQoNCg==
