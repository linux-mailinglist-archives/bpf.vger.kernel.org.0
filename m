Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D829DFC46
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2019 05:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730837AbfJVDtW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 23:49:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:13368 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730828AbfJVDtW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 21 Oct 2019 23:49:22 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9M3n6Di028519;
        Mon, 21 Oct 2019 20:49:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=SxndQuITCZXG1RNtz1wHwRtxOZBQrhM292WM9ZuLwfg=;
 b=qDbrNEacazzSn2mmEZWmN3/xNOFtxpoftAa/d5wpjRtGFAHeXEPk2deCeG5FwzutSyB3
 7tKAHWo70belh59DIhRGENs6H/ijNigwAUChpiej22j61J4AuJozxhHFt+5osMBKLMy7
 PbhpIuCBdl96DoIHjq15FbiwApUqcp6MoJQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vsp6brx1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 20:49:08 -0700
Received: from prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 21 Oct 2019 20:49:07 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx02.TheFacebook.com (2620:10d:c081:6::16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 21 Oct 2019 20:49:07 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Oct 2019 20:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OH0GfT+yFffCbEqAWg6vMYbhF45yd/fNqiQH4I159A2PIjbvuRLCqCwLlvgkkfkNs+I4+dQ2qQCG6rWrZbHj06pdtr3bREbX5K68kmO5dv31eEgJpFOcMTOB1PLTjMHuWWZ+pWnoEYqgAb4s7F0OxdRoW+qWblIisAzdBhnqx0JtGGE5gLyL8EVdbBLvzt8knHF9blQAhdat1eiBlEDVrTTYQ26ngm3LnvJhdZ7MdwABIgJcIVbvM05SKhJBmEh8j8Nq0M95CDkhTvbLOOULUzktfUoussVecPE9kA57U2iUQ+/+di7TgRcxiLTEQxqUHEuRQDaC3e0+Gi3820M6bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxndQuITCZXG1RNtz1wHwRtxOZBQrhM292WM9ZuLwfg=;
 b=mRfZMB4HQQ+QPsbYk/hZJnTO18KUg5pgcJyWIwjWQUzL+3e5/Qj4s7v0ODgFqLJnfn9kgliy/L4q1nCgu+ZTHMRqoToNCI1TTC4012Vtk+ZznkPdbuiI0HY4+VwkQTtMOR6ODLEugiVqJDIt33oTJwh6AYZ46dYZHgf/J7/7jQ28vo0j5S2Mq1MrS0YKhJ4NnByzBVx858YeK5CQeNE+Upoq1+GH6F4hkOU7/OoH1YDuu7U1I1N+n3jd1G/hQL9IRSerpjuUxM8n+PdMnLToRZCOzd0wGouCVqMLstyWB3Dty6jQv5BFEk7hImhyq8kM+Lrx/xkK4gcJgVtbZlYJdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxndQuITCZXG1RNtz1wHwRtxOZBQrhM292WM9ZuLwfg=;
 b=SxbzgDTyEFzX+jiugLHblk7DhF04KKlzADiarJG2C/wr9zC5C2dDDafE1BnjK4QNhyqWu0RUlbXpI4rwUIU7BtDuLek5i6ZZYCVT9cIzULSwGAn3HAGPryNaGYLCGiuAGXBMsWmT6ltHt04lFTcoEQ64eTQW2/qQardao7dw1jI=
Received: from BYAPR15MB3384.namprd15.prod.outlook.com (20.179.60.27) by
 BYAPR15MB2887.namprd15.prod.outlook.com (20.178.237.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Tue, 22 Oct 2019 03:49:05 +0000
Received: from BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d]) by BYAPR15MB3384.namprd15.prod.outlook.com
 ([fe80::b92c:ebd2:58dc:6b8d%5]) with mapi id 15.20.2347.029; Tue, 22 Oct 2019
 03:49:05 +0000
From:   Yonghong Song <yhs@fb.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@fb.com>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Jiong Wang" <jiong.wang@netronome.com>,
        Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH bpf-next] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Topic: [PATCH bpf-next] tools/bpf: turn on llvm alu32 attribute by
 default
Thread-Index: AQHViID08VKNu2OXoUuUYy2Z59vEuKdl+OAAgAANYYA=
Date:   Tue, 22 Oct 2019 03:49:04 +0000
Message-ID: <dbf529f1-3ded-1a8c-9282-97f52d2309f4@fb.com>
References: <20191022023226.2255076-1-yhs@fb.com>
 <CAEf4BzaugaCBgUFnavTtAzezY-Tz55bbfPcQFHOv9Z5VbMh-TQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaugaCBgUFnavTtAzezY-Tz55bbfPcQFHOv9Z5VbMh-TQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR0201CA0005.namprd02.prod.outlook.com
 (2603:10b6:301:74::18) To BYAPR15MB3384.namprd15.prod.outlook.com
 (2603:10b6:a03:112::27)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::6f0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2eb2fbe-f8bb-46ff-eb1f-08d756a2c890
x-ms-traffictypediagnostic: BYAPR15MB2887:
x-ms-exchange-purlcount: 3
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2887D26ADE168BC44740C18AD3680@BYAPR15MB2887.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:849;
x-forefront-prvs: 01986AE76B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(376002)(346002)(396003)(189003)(199004)(46003)(6512007)(476003)(66476007)(52116002)(66446008)(2616005)(6306002)(7736002)(5660300002)(64756008)(11346002)(66946007)(446003)(86362001)(6246003)(2906002)(4326008)(99286004)(31686004)(478600001)(31696002)(66556008)(76176011)(486006)(186003)(6116002)(102836004)(6916009)(8676002)(316002)(25786009)(36756003)(71190400001)(305945005)(6506007)(386003)(6486002)(256004)(14454004)(53546011)(5024004)(6436002)(229853002)(8936002)(81156014)(54906003)(81166006)(71200400001)(966005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2887;H:BYAPR15MB3384.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /1lsoLeGZFxyPLk6l7pePYiFPrzVZzXXrxM6hwSBYyIMlCoSBa6hyofGT/pHyXtCdhruOSBBnNXfXL83gi5BfByOaze+2ukHP4+10zZhkQbdVhSrnevEGvwpG0SObTJU1DMKowx6bsYHBp1jtDpIAoMeA0K+2oDN3UIAdaCtCuqssYqNZRIU8oO4pOEVjqW75AFbyKuJ1T9/Yx+yIwejhEcFJGZ/4GHzY9qWZIGXwATumLo6D9NfYk7zQaqCZTdoTb7X7IJtayscd2QBw1ImNmCn/onH23B7vdBjhYHvj15A0lbl56YJYrc+loeBQGq7JOwQN/W6vsdzqJmIjf0IqDa/d+j5U1nYssETOLtrnxGBdka9blNE2iCqEF1s8X+UZquKwDJemO3cQ6ngux4cw7f+G11JzAET5Kr40usUwTho4HgAOJj87jaWiXTuoOJrT9t4DtxEAd5UA8vdcbf646U4OzvW8fbylKj0kvAQjFw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A0BB5C860A509E44B072FD8D9BE77B3F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2eb2fbe-f8bb-46ff-eb1f-08d756a2c890
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2019 03:49:04.8534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O1CVYonw2NcbruoWkQUVO6EvIwGXcL0GKy9rl9+gvQZULwQX2hEvkkF++OEA27h2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2887
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-22_01:2019-10-21,2019-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910220038
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

DQoNCk9uIDEwLzIxLzE5IDg6MDEgUE0sIEFuZHJpaSBOYWtyeWlrbyB3cm90ZToNCj4gT24gTW9u
LCBPY3QgMjEsIDIwMTkgYXQgNzozMiBQTSBZb25naG9uZyBTb25nIDx5aHNAZmIuY29tPiB3cm90
ZToNCj4+DQo+PiBsbHZtIGFsdTMyIHdhcyBpbnRyb2R1Y2VkIGluIGxsdm03Og0KPj4gICAgaHR0
cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBzLTNBX19yZXZpZXdz
Lmxsdm0ub3JnX3JMMzI1OTg3JmQ9RHdJQmFRJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZyPURB
OGUxQjVyMDczdklxUnJGejdNUkEmbT1OSEFuMkRYNE03NXVwSm5vOEVfVmhnNVd4MGNqX0N0S0xE
ZE1ZSkpIZ1ZBJnM9emxYS2dPZE5EZDdWNmNRazNsWUVDenJwOE1Zc3dyT25jLUFwVFBKNlE1byZl
PQ0KPj4gICAgaHR0cHM6Ly91cmxkZWZlbnNlLnByb29mcG9pbnQuY29tL3YyL3VybD91PWh0dHBz
LTNBX19yZXZpZXdzLmxsdm0ub3JnX3JMMzI1OTg5JmQ9RHdJQmFRJmM9NVZEMFJUdE5sVGgzeWNk
NDFiM01VdyZyPURBOGUxQjVyMDczdklxUnJGejdNUkEmbT1OSEFuMkRYNE03NXVwSm5vOEVfVmhn
NVd4MGNqX0N0S0xEZE1ZSkpIZ1ZBJnM9TlNIaXJ5NWdzRWVMNVRoUldqLWtjMHlmRDBZcFpDdC1P
aEFzQkl2d05aUSZlPQ0KPj4gRXhwZXJpbWVudHMgc2hvd2VkIHRoYXQgaW4gZ2VuZXJhbCBwZXJm
b3JtYW5jZQ0KPj4gaXMgYmV0dGVyIHdpdGggYWx1MzIgZW5hYmxlZDoNCj4+ICAgIGh0dHBzOi8v
dXJsZGVmZW5zZS5wcm9vZnBvaW50LmNvbS92Mi91cmw/dT1odHRwcy0zQV9fbHduLm5ldF9BcnRp
Y2xlc183NzUzMTZfJmQ9RHdJQmFRJmM9NVZEMFJUdE5sVGgzeWNkNDFiM01VdyZyPURBOGUxQjVy
MDczdklxUnJGejdNUkEmbT1OSEFuMkRYNE03NXVwSm5vOEVfVmhnNVd4MGNqX0N0S0xEZE1ZSkpI
Z1ZBJnM9RmFPT1cwUkpORjdCMlU0SlVLRzJkUGxLazBjMW9RdG5xMDYtZUZ4OG1CZyZlPQ0KPj4N
Cj4+IFRoaXMgcGF0Y2ggdHVybmVkIG9uIGFsdTMyIHdpdGggbm8tZmxhdm9yIHRlc3RfcHJvZ3MN
Cj4+IHdoaWNoIGlzIHRlc3RlZCBtb3N0IG9mdGVuLiBUaGUgZmxhdm9yIHRlc3QgYXQNCj4+IG5v
X2FsdTMyL3Rlc3RfcHJvZ3MgY2FuIGJlIHVzZWQgdG8gdGVzdCB3aXRob3V0DQo+PiBhbHUzMiBl
bmFibGVkLiBUaGUgTWFrZWZpbGUgY2hlY2sgZm9yIHdoZXRoZXINCj4+IGxsdm0gc3VwcG9ydHMg
Jy1tYXR0cj0rYWx1MzIgLW1jcHU9djMnIGlzDQo+PiByZW1vdmVkIGFzIGxsdm03IHNob3VsZCBi
ZSBhdmFpbGFibGUgZm9yIHJlY2VudA0KPj4gZGlzdHJpYnV0aW9ucyBhbmQgYWxzbyBsYXRlc3Qg
bGx2bSBpcyBwcmVmZXJyZWQNCj4+IHRvIHJ1biBicGYgc2VsZnRlc3RzLg0KPj4NCj4+IE5vdGUg
dGhhdCBqbXAzMiBpcyBjaGVja2VkIGJ5IC1tY3B1PXByb2JlIGFuZA0KPj4gd2lsbCBiZSBlbmFi
bGVkIGlmIHRoZSBob3N0IGtlcm5lbCBzdXBwb3J0cyBpdC4NCj4+DQo+PiBDYzogSmlvbmcgV2Fu
ZyA8amlvbmcud2FuZ0BuZXRyb25vbWUuY29tPg0KPj4gQ2M6IEFuZHJpaSBOYWtyeWlrbyA8YW5k
cmlpbkBmYi5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZb25naG9uZyBTb25nIDx5aHNAZmIuY29t
Pg0KPj4gLS0tDQo+IA0KPiBTb3VuZHMgZ29vZCB0byBtZSwgc2VlIG1pbm9yIG5pdCBiZWxvdy4N
Cj4gDQo+IEFja2VkLWJ5OiBBbmRyaWkgTmFrcnlpa28gPGFuZHJpaW5AZmIuY29tPg0KPiANCj4+
ICAgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvYnBmL01ha2VmaWxlIHwgMjYgKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLS0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTgg
ZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3Rz
L2JwZi9NYWtlZmlsZSBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9NYWtlZmlsZQ0KPj4g
aW5kZXggNGZmNWY0YWFkYTA4Li41YTBiY2EyODAyZmUgMTAwNjQ0DQo+PiAtLS0gYS90b29scy90
ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvTWFrZWZpbGUNCj4+ICsrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL2JwZi9NYWtlZmlsZQ0KPj4gQEAgLTMyLDE1ICszMiw3IEBAIFRFU1RfR0VOX1BST0dT
ID0gdGVzdF92ZXJpZmllciB0ZXN0X3RhZyB0ZXN0X21hcHMgdGVzdF9scnVfbWFwIHRlc3RfbHBt
X21hcCB0ZXN0DQo+PiAgICAgICAgICB0ZXN0X25ldGNudCB0ZXN0X3RjcG5vdGlmeV91c2VyIHRl
c3Rfc29ja19maWVsZHMgdGVzdF9zeXNjdGwgdGVzdF9oYXNobWFwIFwNCj4+ICAgICAgICAgIHRl
c3RfY2dyb3VwX2F0dGFjaCB4ZHBpbmcNCj4+DQo+PiAtIyBBbHNvIHRlc3Qgc3ViLXJlZ2lzdGVy
IGNvZGUtZ2VuIGlmIExMVk0gaGFzIGVCUEYgdjMgcHJvY2Vzc29yIHN1cHBvcnQgd2hpY2gNCj4+
IC0jIGNvbnRhaW5zIGJvdGggQUxVMzIgYW5kIEpNUDMyIGluc3RydWN0aW9ucy4NCj4+IC1TVUJS
RUdfQ09ERUdFTiA6PSAkKHNoZWxsIGVjaG8gImludCBjYWwoaW50IGEpIHsgcmV0dXJuIGEgPiAw
OyB9IiB8IFwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICQoQ0xBTkcpIC10YXJnZXQgYnBm
IC1PMiAtZW1pdC1sbHZtIC1TIC14IGMgLSAtbyAtIHwgXA0KPj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgJChMTEMpIC1tYXR0cj0rYWx1MzIgLW1jcHU9djMgMj4mMSB8IFwNCj4+IC0gICAgICAg
ICAgICAgICAgICAgICAgIGdyZXAgJ2lmIHcnKQ0KPj4gLWlmbmVxICgkKFNVQlJFR19DT0RFR0VO
KSwpDQo+PiAtVEVTVF9HRU5fUFJPR1MgKz0gdGVzdF9wcm9ncy1hbHUzMg0KPj4gLWVuZGlmDQo+
PiArVEVTVF9HRU5fUFJPR1MgKz0gdGVzdF9wcm9ncy1ub19hbHUzMg0KPiANCj4gY29tYmluZSB0
aGlzIHdpdGggVEVTVF9HRU5fUFJPR1MgbGlzdCBhYm92ZSwgaXQncyBub3QgY29uZGl0aW9uYWwg
YW55bW9yZT8NCg0KWWEsIG1ha2Ugc2Vuc2UuIFdpbGwgcmVzcGluLg0KDQo+IA0KPj4NCj4+ICAg
IyBBbHNvIHRlc3QgYnBmLWdjYywgaWYgcHJlc2VudA0KPj4gICBpZm5lcSAoJChCUEZfR0NDKSwp
DQo+PiBAQCAtMTc5LDcgKzE3MSw3IEBAIGVuZGVmDQo+PiAgICMgJGV2YWwoKSkgYW5kIHBhc3Mg
Y29udHJvbCB0byBERUZJTkVfVEVTVF9SVU5ORVJfUlVMRVMuDQo+PiAgICMgUGFyYW1ldGVyczoN
Cj4gDQo+IFsuLi5dDQo+IA0K
