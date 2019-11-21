Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFB105727
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2019 17:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfKUQgb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Nov 2019 11:36:31 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:8974 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726279AbfKUQgb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 21 Nov 2019 11:36:31 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xALGXLdk009333;
        Thu, 21 Nov 2019 08:36:15 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=E3+u92y64i3slh3/MjMfZTgabXtItYElhBCvVGAife8=;
 b=jUkzFZL1p2EzlVRhuTsyneZP9zL5CKEJV6wCFGwDek84NvJPvDK/M8Kuv8jo527VYgwh
 j5RKZUA6ObN4A8IKictATOBtHLTw2Rmo6lqBtpwj2siO9AgYaPjBDwd+dZQ51Sik3m9V
 eC41eJeBlz9UUt7mFXQ2tw8x85c7HRu4cI0= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2wd80pj37j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 21 Nov 2019 08:36:15 -0800
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 21 Nov 2019 08:36:14 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 21 Nov 2019 08:36:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrRkKtjbUNkyRTIN3qMRtdNjeEuO8izJTyg66fbFPkU30bkYyXdOy2IZgujFOjSiUlV+n99K3iHKRqamNMaukJMpDop/pOWF0D9rbzp4uAdfkBlmfXLCF9mbA8IXgwqZBHJLJHp9waJp7chE0teq4Km4ORMtsfU0EwUCf+ZWnxpnLNqeFXv25CJMYntA9UbtQcN8lHF5Todu8D8vBWpEejuSRMIMCS6KHN89Oxqpj+7RPge6V9Q4P7cNs1/PNQe0IzDps6DT+bsBnURC0jXMjKSADbdLOpRjLe35/d71MF6xV1vHXnzgxbVs/1lhMLG6d2zyr0pAlPKJSVNW4qM3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3+u92y64i3slh3/MjMfZTgabXtItYElhBCvVGAife8=;
 b=NI5yoQ9cK+yzDoGJKLj30lUGjws5LxZKtqE+4+sm7kqFvd9wpdC1SoXWru5cfWNnBCBHo8b+2jBNBloIqNG2oiGc2HE/zBCfwn7eiu/aAVkw0QN9fP4oUzatKMq6diXXCTb9plG+BVkR6NPrxzhSzTNEpMIopJsm3gZjtTHU58jVHw6xQoAfd3OH2sW0d8ielRETcXnj/G150+H/3fQailRYwk36cVlRDTLoh3h49PShgDy3YEkeKWHNGf5UScmTdvhGxmnJgNnU/4D8v5XEz1Inwwnd39cZCGETksLs6WB8h0VD+ehjVVg/7AqdW0dWWAWz9fI9I5DL1Sv4HnL4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3+u92y64i3slh3/MjMfZTgabXtItYElhBCvVGAife8=;
 b=UAbnl1nZtKHFR6FhKv5etb6cO9c1tP/KFScMb+YNeN2PmyUYR4ZXeTgXsV2ZgaIwSf3M0tJwZlQghRL0HoQnOOM6RzkKwGNQJ18u5oongxaFYS63+nKA5Ltn9zREV83+gPCVIO3ANZYZn5riGd8mY0uRGxZuxm4Nsb3LIAlETdo=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2471.namprd15.prod.outlook.com (52.135.200.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Thu, 21 Nov 2019 16:36:11 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::a9f8:a9c0:854c:d680%4]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 16:36:11 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ecree@solarflare.com" <ecree@solarflare.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: provide better register bounds after
 jmp32 instructions
Thread-Topic: [PATCH bpf-next 1/2] bpf: provide better register bounds after
 jmp32 instructions
Thread-Index: AQHVoCh8HVz+szR93UibF25TDTTd1qeV0zOA
Date:   Thu, 21 Nov 2019 16:36:11 +0000
Message-ID: <46d885d9-9267-5767-d8cd-d2bd7ef18b2c@fb.com>
References: <20191121014024.1700638-1-yhs@fb.com>
 <20191121014024.1700703-1-yhs@fb.com>
 <20191121045924.v77wb5zzfliln7ql@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20191121045924.v77wb5zzfliln7ql@ast-mbp.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:300:13d::11) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b385]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 199121d7-da48-4da7-dcfb-08d76ea0eafb
x-ms-traffictypediagnostic: BYAPR15MB2471:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2471DC5CDEF8BE0E9BD597ABD34E0@BYAPR15MB2471.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(396003)(366004)(39860400002)(199004)(189003)(31686004)(6306002)(66476007)(36756003)(66556008)(386003)(14444005)(6506007)(6512007)(478600001)(53546011)(64756008)(256004)(71190400001)(2616005)(102836004)(71200400001)(305945005)(7736002)(6436002)(8936002)(52116002)(186003)(11346002)(6116002)(446003)(966005)(46003)(2906002)(6246003)(4326008)(5660300002)(6916009)(66446008)(76176011)(66946007)(25786009)(6486002)(14454004)(99286004)(54906003)(229853002)(8676002)(81156014)(31696002)(86362001)(316002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2471;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZsaetWNvlVdPYlRB7YHkMfj73nSyK6OkXDWyv1sO20NYrEUvDJtIViU5xdJJbenQyE7M3LVe4DsDiF4Hxqcm7Oq9n0ebR2WodykLb30AOJP/sDQVmClcaldwZWAyPJpl4rqeBn/TbOhhgt/A6RU8NYWjmsOr3qDY/CvW2n68/jzQCR3aOK6AopAZGYTV6+cZeajBZGI4JBZKf42vX1nO9OO5mRnuQzq+VIL5vvkkpjxZkbsibQH5KH3u5ifObw/7RhMx5oXW1/VurwRFvlpAgHM5rRbVmTS7xOKGjuBjXnrjrRGBYCK3i+sakxJ9+w+4pA1gG63CnzY12DDM/qK2G1cKDG/0jBGApxu0jBfP7QsfHBoGRegBei9etZKPMAc/I4euIJ8k6c+VXFvIAMifWgUztddeaC/BSgH9RPNlr2AaCzR2nr+dg3hUTVTxF3/x
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F34F895EDF484B8409C7BE0D1F0245@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 199121d7-da48-4da7-dcfb-08d76ea0eafb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 16:36:11.4510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1XnlQ9KcJx+YKRWUH09qqSLJKeyMhaeLv/jDp6Om1WvnFDDPJ0nASoju3Fc/vkpO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2471
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-21_04:2019-11-21,2019-11-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1011 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911210146
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDExLzIwLzE5IDg6NTkgUE0sIEFsZXhlaSBTdGFyb3ZvaXRvdiB3cm90ZToNCj4gT24g
V2VkLCBOb3YgMjAsIDIwMTkgYXQgMDU6NDA6MjRQTSAtMDgwMCwgWW9uZ2hvbmcgU29uZyB3cm90
ZToNCj4+IFdpdGggbGF0ZXN0IGxsdm0gKHRydW5rIGh0dHBzOi8vZ2l0aHViLmNvbS9sbHZtL2xs
dm0tcHJvamVjdCksDQo+PiB0ZXN0X3Byb2dzLCB3aGljaCBoYXMgK2FsdTMyIGVuYWJsZWQsIGZh
aWxlZCBmb3Igc3Ryb2JlbWV0YS5vLg0KPj4gVGhlIHZlcmlmaWVyIG91dHB1dCBsb29rcyBsaWtl
IGJlbG93IHdpdGggZWRpdCB0byByZXBsYWNlIGxhcmdlDQo+PiBkZWNpbWFsIG51bWJlcnMgd2l0
aCBoZXggb25lcy4NCj4+ICAgMTkzOiAoODUpIGNhbGwgYnBmX3Byb2JlX3JlYWRfdXNlcl9zdHIj
MTE0DQo+PiAgICAgUjA9aW52KGlkPTApDQo+PiAgIDE5NDogKDI2KSBpZiB3MCA+IDB4MSBnb3Rv
IHBjKzQNCj4+ICAgICBSMF93PWludihpZD0wLHVtYXhfdmFsdWU9MHhmZmZmZmZmZjAwMDAwMDAx
KQ0KPj4gICAxOTU6ICg2YikgKih1MTYgKikocjcgKzgwKSA9IHIwDQo+PiAgIDE5NjogKGJjKSB3
NiA9IHcwDQo+PiAgICAgUjZfdz1pbnYoaWQ9MCx1bWF4X3ZhbHVlPTB4ZmZmZmZmZmYsdmFyX29m
Zj0oMHgwOyAweGZmZmZmZmZmKSkNCj4+ICAgMTk3OiAoNjcpIHI2IDw8PSAzMg0KPj4gICAgIFI2
X3c9aW52KGlkPTAsc21heF92YWx1ZT0weDdmZmZmZmZmMDAwMDAwMDAsdW1heF92YWx1ZT0weGZm
ZmZmZmZmMDAwMDAwMDAsDQo+PiAgICAgICAgICAgICAgdmFyX29mZj0oMHgwOyAweGZmZmZmZmZm
MDAwMDAwMDApKQ0KPj4gICAxOTg6ICg3NykgcjYgPj49IDMyDQo+PiAgICAgUjY9aW52KGlkPTAs
dW1heF92YWx1ZT0weGZmZmZmZmZmLHZhcl9vZmY9KDB4MDsgMHhmZmZmZmZmZikpDQo+PiAgIC4u
Lg0KPj4gICAyMDE6ICg3OSkgcjggPSAqKHU2NCAqKShyMTAgLTQxNikNCj4+ICAgICBSOF93PW1h
cF92YWx1ZShpZD0wLG9mZj00MCxrcz00LHZzPTEzODcyLGltbT0wKQ0KPj4gICAyMDI6ICgwZikg
cjggKz0gcjYNCj4+ICAgICBSOF93PW1hcF92YWx1ZShpZD0wLG9mZj00MCxrcz00LHZzPTEzODcy
LHVtYXhfdmFsdWU9MHhmZmZmZmZmZix2YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKQ0KPj4gICAy
MDM6ICgwNykgcjggKz0gOTY5Ng0KPj4gICAgIFI4X3c9bWFwX3ZhbHVlKGlkPTAsb2ZmPTk3MzYs
a3M9NCx2cz0xMzg3Mix1bWF4X3ZhbHVlPTB4ZmZmZmZmZmYsdmFyX29mZj0oMHgwOyAweGZmZmZm
ZmZmKSkNCj4+ICAgLi4uDQo+PiAgIDI1NTogKGJmKSByMSA9IHI4DQo+PiAgICAgUjFfdz1tYXBf
dmFsdWUoaWQ9MCxvZmY9OTczNixrcz00LHZzPTEzODcyLHVtYXhfdmFsdWU9MHhmZmZmZmZmZix2
YXJfb2ZmPSgweDA7IDB4ZmZmZmZmZmYpKQ0KPj4gICAuLi4NCj4+ICAgMjU3OiAoODUpIGNhbGwg
YnBmX3Byb2JlX3JlYWRfdXNlcl9zdHIjMTE0DQo+PiAgIFIxIHVuYm91bmRlZCBtZW1vcnkgYWNj
ZXNzLCBtYWtlIHN1cmUgdG8gYm91bmRzIGNoZWNrIGFueSBhcnJheSBhY2Nlc3MgaW50byBhIG1h
cA0KPj4NCj4+IFRoZSB2YWx1ZSByYW5nZSBmb3IgcmVnaXN0ZXIgcjYgYXQgaW5zbiAxOTggc2hv
dWxkIGJlIHJlYWxseSBqdXN0IDAvMS4NCj4+IFRoZSB1bWF4X3ZhbHVlPTB4ZmZmZmZmZmYgY2F1
c2VkIGxhdGVyIHZlcmlmaWNhdGlvbiBmYWlsdXJlLg0KPj4NCj4+IEFmdGVyIGptcCBpbnN0cnVj
dGlvbnMsIHRoZSBjdXJyZW50IHZlcmlmaWVyIGFscmVhZHkgdHJpZWQgdG8gdXNlIGp1c3QNCj4+
IG9idGFpbmVkIGluZm9ybWF0aW9uIHRvIGdldCBiZXR0ZXIgcmVnaXN0ZXIgcmFuZ2UuIFRoZSBj
dXJyZW50IG1lY2hhbmlzbSBpcw0KPj4gZm9yIDY0Yml0IHJlZ2lzdGVyIG9ubHkuIFRoaXMgcGF0
Y2ggaW1wbGVtZW50ZWQgdG8gdGlnaHRlbiB0aGUgcmFuZ2UNCj4+IGZvciAzMmJpdCBzdWItcmVn
aXN0ZXJzIGFmdGVyIGptcDMyIGluc3RydWN0aW9ucy4NCj4+IFdpdGggdGhlIHBhdGNoLCB3ZSBo
YXZlIHRoZSBiZWxvdyByYW5nZSByYW5nZXMgZm9yIHRoZQ0KPj4gYWJvdmUgY29kZSBzZXF1ZW5j
ZToNCj4+ICAgMTkzOiAoODUpIGNhbGwgYnBmX3Byb2JlX3JlYWRfdXNlcl9zdHIjMTE0DQo+PiAg
ICAgUjA9aW52KGlkPTApDQo+PiAgIDE5NDogKDI2KSBpZiB3MCA+IDB4MSBnb3RvIHBjKzQNCj4+
ICAgICBSMF93PWludihpZD0wLHNtYXhfdmFsdWU9MHg3ZmZmZmZmZjAwMDAwMDAxLHVtYXhfdmFs
dWU9MHhmZmZmZmZmZjAwMDAwMDAxLA0KPj4gICAgICAgICAgICAgIHZhcl9vZmY9KDB4MDsgMHhm
ZmZmZmZmZjAwMDAwMDAxKSkNCj4+ICAgMTk1OiAoNmIpICoodTE2ICopKHI3ICs4MCkgPSByMA0K
Pj4gICAxOTY6IChiYykgdzYgPSB3MA0KPj4gICAgIFI2X3c9aW52KGlkPTAsdW1heF92YWx1ZT0w
eGZmZmZmZmZmLHZhcl9vZmY9KDB4MDsgMHgxKSkNCj4+ICAgMTk3OiAoNjcpIHI2IDw8PSAzMg0K
Pj4gICAgIFI2X3c9aW52KGlkPTAsdW1heF92YWx1ZT0weDEwMDAwMDAwMCx2YXJfb2ZmPSgweDA7
IDB4MTAwMDAwMDAwKSkNCj4+ICAgMTk4OiAoNzcpIHI2ID4+PSAzMg0KPj4gICAgIFI2PWludihp
ZD0wLHVtYXhfdmFsdWU9MSx2YXJfb2ZmPSgweDA7IDB4MSkpDQo+PiAgIC4uLg0KPj4gICAyMDE6
ICg3OSkgcjggPSAqKHU2NCAqKShyMTAgLTQxNikNCj4+ICAgICBSOF93PW1hcF92YWx1ZShpZD0w
LG9mZj00MCxrcz00LHZzPTEzODcyLGltbT0wKQ0KPj4gICAyMDI6ICgwZikgcjggKz0gcjYNCj4+
ICAgICBSOF93PW1hcF92YWx1ZShpZD0wLG9mZj00MCxrcz00LHZzPTEzODcyLHVtYXhfdmFsdWU9
MSx2YXJfb2ZmPSgweDA7IDB4MSkpDQo+PiAgIDIwMzogKDA3KSByOCArPSA5Njk2DQo+PiAgICAg
Ujhfdz1tYXBfdmFsdWUoaWQ9MCxvZmY9OTczNixrcz00LHZzPTEzODcyLHVtYXhfdmFsdWU9MSx2
YXJfb2ZmPSgweDA7IDB4MSkpDQo+PiAgIC4uLg0KPj4gICAyNTU6IChiZikgcjEgPSByOA0KPj4g
ICAgIFIxX3c9bWFwX3ZhbHVlKGlkPTAsb2ZmPTk3MzYsa3M9NCx2cz0xMzg3Mix1bWF4X3ZhbHVl
PTEsdmFyX29mZj0oMHgwOyAweDEpKQ0KPj4gICAuLi4NCj4+ICAgMjU3OiAoODUpIGNhbGwgYnBm
X3Byb2JlX3JlYWRfdXNlcl9zdHIjMTE0DQo+PiAgIC4uLg0KPj4NCj4+IEF0IGluc24gMTk0LCB0
aGUgcmVnaXN0ZXIgUjAgaGFzIGJldHRlciB2YXJfb2ZmLm1hc2sgYW5kIHNtYXhfdmFsdWUuDQo+
PiBFc3BlY2lhbGx5LCB0aGUgdmFyX29mZi5tYXNrIGVuc3VyZXMgbGF0ZXIgbHNoaWZ0IGFuZCBy
c2hpZnQNCj4+IG1haW50YWlucyBwcm9wZXIgdmFsdWUgcmFuZ2UuDQo+Pg0KPj4gU3VnZ2VzdGVk
LWJ5OiBBbGV4ZWkgU3Rhcm92b2l0b3YgPGFzdEBrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1i
eTogWW9uZ2hvbmcgU29uZyA8eWhzQGZiLmNvbT4NCj4+IC0tLQ0KPj4gICBrZXJuZWwvYnBmL3Zl
cmlmaWVyLmMgfCAzMiArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQ0KPj4gICAxIGZp
bGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEva2VybmVsL2JwZi92ZXJpZmllci5jIGIva2VybmVsL2JwZi92ZXJpZmllci5jDQo+
PiBpbmRleCA5ZjU5ZjdhMTlkZDAuLjAwOTA2NTRjOTAxMCAxMDA2NDQNCj4+IC0tLSBhL2tlcm5l
bC9icGYvdmVyaWZpZXIuYw0KPj4gKysrIGIva2VybmVsL2JwZi92ZXJpZmllci5jDQo+PiBAQCAt
MTAwNyw2ICsxMDA3LDIwIEBAIHN0YXRpYyB2b2lkIF9fcmVnX2JvdW5kX29mZnNldChzdHJ1Y3Qg
YnBmX3JlZ19zdGF0ZSAqcmVnKQ0KPj4gICAJCQkJCQkgcmVnLT51bWF4X3ZhbHVlKSk7DQo+PiAg
IH0NCj4+ICAgDQo+PiArc3RhdGljIHZvaWQgX19yZWdfYm91bmRfb2Zmc2V0MzIoc3RydWN0IGJw
Zl9yZWdfc3RhdGUgKnJlZykNCj4+ICt7DQo+PiArCXU2NCBtYXNrID0gMHhmZmZmRkZGRjsNCj4+
ICsJc3RydWN0IHRudW0gcmFuZ2UgPSB0bnVtX3JhbmdlKHJlZy0+dW1pbl92YWx1ZSAmIG1hc2ss
DQo+PiArCQkJCSAgICAgICByZWctPnVtYXhfdmFsdWUgJiBtYXNrKTsNCj4+ICsJc3RydWN0IHRu
dW0gbG8zMiA9IHRudW1fY2FzdChyZWctPnZhcl9vZmYsIDQpOw0KPj4gKwlzdHJ1Y3QgdG51bSBo
aTMyID0gcmVnLT52YXJfb2ZmOw0KPj4gKw0KPj4gKwloaTMyLnZhbHVlICY9IH5tYXNrOw0KPj4g
KwloaTMyLm1hc2sgJj0gfm1hc2s7DQo+IA0KPiBzb3JyeSB0aGF0IHdhcyBhIHF1aWNrIGhhY2sg
OikNCj4gTWF5IGJlIG1ha2Ugc2Vuc2UgdG8gZG8gaXQgYXMgYSBoZWxwZXI/IHNpbWlsYXIgdG8g
dG51bV9jYXN0ID8NCj4gVGhlIGlkZWEgd2FzIHRvIGFwcGx5IHRudW1fcmFuZ2UgdG8gbG93ZXIg
MzItYml0cy4NCj4gTWF5IGJlIHRudW1faW50ZXJzZWN0X3dpdGhfbWFzayhhLCBiLCA0KSA/DQo+
IE9yIGFib3ZlIHR3byBsaW5lcyBjb3VsZCBiZQ0KPiBoaTMyID0gdG51bV9hbmQocmVnLT52YXJf
b2ZmLCB0bnVtX2JpdHdpc2Vfbm90KHRudW1fdTMyX21heCkpOw0KPiBUaGVyZSBpcyB0bnVtX2xz
aGlmdC90bnVtX3JzaGlmdC4gVGhleSBjb3VsZCBiZSB1c2VkIGFzIHdlbGwuDQoNCkkgd2lsbCB1
c2UgdG51bV9sc2hpZnQvdG51bV9yc2hpZnQgd2hpY2ggc2VlbXMgZWFzeSB0byB1bmRlcnN0YW5k
Lg0KV2lsbCBzZW5kIHYyIHNvb24uDQoNCj4gDQo+IEVkLA0KPiBob3cgd291bGQgeW91IHNpbXBs
aWZ5IF9fcmVnX2JvdW5kX29mZnNldDMyIGxvZ2ljID8NCj4gDQo+PiArDQo+PiArCXJlZy0+dmFy
X29mZiA9IHRudW1fb3IoaGkzMiwgdG51bV9pbnRlcnNlY3QobG8zMiwgcmFuZ2UpKTsNCj4+ICt9
DQo+PiArDQo+PiAgIC8qIFJlc2V0IHRoZSBtaW4vbWF4IGJvdW5kcyBvZiBhIHJlZ2lzdGVyICov
DQo+PiAgIHN0YXRpYyB2b2lkIF9fbWFya19yZWdfdW5ib3VuZGVkKHN0cnVjdCBicGZfcmVnX3N0
YXRlICpyZWcpDQo+PiAgIHsNCj4+IEBAIC01NTg3LDggKzU2MDEsMTMgQEAgc3RhdGljIHZvaWQg
cmVnX3NldF9taW5fbWF4KHN0cnVjdCBicGZfcmVnX3N0YXRlICp0cnVlX3JlZywNCj4+ICAgCV9f
cmVnX2RlZHVjZV9ib3VuZHMoZmFsc2VfcmVnKTsNCj4+ICAgCV9fcmVnX2RlZHVjZV9ib3VuZHMo
dHJ1ZV9yZWcpOw0KPj4gICAJLyogV2UgbWlnaHQgaGF2ZSBsZWFybmVkIHNvbWUgYml0cyBmcm9t
IHRoZSBib3VuZHMuICovDQo+PiAtCV9fcmVnX2JvdW5kX29mZnNldChmYWxzZV9yZWcpOw0KPj4g
LQlfX3JlZ19ib3VuZF9vZmZzZXQodHJ1ZV9yZWcpOw0KPj4gKwlpZiAoaXNfam1wMzIpIHsNCj4+
ICsJCV9fcmVnX2JvdW5kX29mZnNldDMyKGZhbHNlX3JlZyk7DQo+PiArCQlfX3JlZ19ib3VuZF9v
ZmZzZXQzMih0cnVlX3JlZyk7DQo+PiArCX0gZWxzZSB7DQo+PiArCQlfX3JlZ19ib3VuZF9vZmZz
ZXQoZmFsc2VfcmVnKTsNCj4+ICsJCV9fcmVnX2JvdW5kX29mZnNldCh0cnVlX3JlZyk7DQo+PiAr
CX0NCj4+ICAgCS8qIEludGVyc2VjdGluZyB3aXRoIHRoZSBvbGQgdmFyX29mZiBtaWdodCBoYXZl
IGltcHJvdmVkIG91ciBib3VuZHMNCj4+ICAgCSAqIHNsaWdodGx5LiAgZS5nLiBpZiB1bWF4IHdh
cyAweDdmLi4uZiBhbmQgdmFyX29mZiB3YXMgKDA7IDB4Zi4uLmZjKSwNCj4+ICAgCSAqIHRoZW4g
bmV3IHZhcl9vZmYgaXMgKDA7IDB4N2YuLi5mYykgd2hpY2ggaW1wcm92ZXMgb3VyIHVtYXguDQo+
PiBAQCAtNTY5Niw4ICs1NzE1LDEzIEBAIHN0YXRpYyB2b2lkIHJlZ19zZXRfbWluX21heF9pbnYo
c3RydWN0IGJwZl9yZWdfc3RhdGUgKnRydWVfcmVnLA0KPj4gICAJX19yZWdfZGVkdWNlX2JvdW5k
cyhmYWxzZV9yZWcpOw0KPj4gICAJX19yZWdfZGVkdWNlX2JvdW5kcyh0cnVlX3JlZyk7DQo+PiAg
IAkvKiBXZSBtaWdodCBoYXZlIGxlYXJuZWQgc29tZSBiaXRzIGZyb20gdGhlIGJvdW5kcy4gKi8N
Cj4+IC0JX19yZWdfYm91bmRfb2Zmc2V0KGZhbHNlX3JlZyk7DQo+PiAtCV9fcmVnX2JvdW5kX29m
ZnNldCh0cnVlX3JlZyk7DQo+PiArCWlmIChpc19qbXAzMikgew0KPj4gKwkJX19yZWdfYm91bmRf
b2Zmc2V0MzIoZmFsc2VfcmVnKTsNCj4+ICsJCV9fcmVnX2JvdW5kX29mZnNldDMyKHRydWVfcmVn
KTsNCj4+ICsJfSBlbHNlIHsNCj4+ICsJCV9fcmVnX2JvdW5kX29mZnNldChmYWxzZV9yZWcpOw0K
Pj4gKwkJX19yZWdfYm91bmRfb2Zmc2V0KHRydWVfcmVnKTsNCj4+ICsJfQ0KPj4gICAJLyogSW50
ZXJzZWN0aW5nIHdpdGggdGhlIG9sZCB2YXJfb2ZmIG1pZ2h0IGhhdmUgaW1wcm92ZWQgb3VyIGJv
dW5kcw0KPj4gICAJICogc2xpZ2h0bHkuICBlLmcuIGlmIHVtYXggd2FzIDB4N2YuLi5mIGFuZCB2
YXJfb2ZmIHdhcyAoMDsgMHhmLi4uZmMpLA0KPj4gICAJICogdGhlbiBuZXcgdmFyX29mZiBpcyAo
MDsgMHg3Zi4uLmZjKSB3aGljaCBpbXByb3ZlcyBvdXIgdW1heC4NCj4+IC0tIA0KPj4gMi4xNy4x
DQo+Pg0K
