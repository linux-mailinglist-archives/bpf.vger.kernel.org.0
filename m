Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 473AD13B94B
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2020 06:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgAOF6c (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Jan 2020 00:58:32 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46564 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgAOF6c (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Jan 2020 00:58:32 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00F5vLaW027605;
        Tue, 14 Jan 2020 21:58:20 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LNXyxDsdHPhwU2oqLzjVcx5HU6SlJT1N/Any2QyCfXA=;
 b=ZVWWbxdo/6LeLSecSyQr6Pln1S1Yqe2KWz49Dp3pUDG8+JBlZ4sdwze0LZng71td5kQS
 S3+62lrGuUlp4qAEh6KGSYuweNdY2eOJVJKIa3vw+tJoeX5wGZzE1i6CpQX5XJzAXicO
 VCoroLMP+33E6ShQDDt9B5rqE+IOjUjLIH8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 2xhahpn898-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Jan 2020 21:58:20 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 14 Jan 2020 21:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meQm1jsTTJcfWBmyUBywHCdPfY46cij250SSEaKY3Udnhg8s2kKuV6gBUEvFeC5qytl6f61A5d1ArNdr+2nCPKdpsfNxpThVJ7r60Qbwua2t71ZRW8HF1MrOwHLcucFyX9Y3whE4Vtq0cefdnGXx2FHjXiL+RwxxU0MUhkGDYP260csQZiAUHMoJ6Fyhu6LW9RccIrB1WBi1FsEljsMq5Wf4Ve8YMqX5IkGWwyC0fA/8/YpZaZobf1o2Z8/XUMrgF0uSODAWu+iQ3UMDJFsw02zPI3MpH8NxHoKn74CPJj9qriTWcVYBDlRvy1Pb+JhB9k0gqOLR4hE0eH1vCueHDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNXyxDsdHPhwU2oqLzjVcx5HU6SlJT1N/Any2QyCfXA=;
 b=mwMjmfJe0mJNExMP6rB3pA6Zzch7xPZk7Km7S0NvBuyBHE3dcyYhPFr85cju1pY2Dt0EoCvJzWCK3tBYvZViIQH+WITRBCj8AegeB1Eg+Ipwjk4myd47ZQXTIjYaHdZJiAWkkn6UdqiWRkinsAIUEb6jiMs+ojaN68UkbK2jstxH6xS9ykuIQHMWRrCRWXUFMkDQMkPVOkNeCjbMgWuOaO6hyOYsaQSQ2LwS9lM8qN5qsDybPvcljOA8lTZq2+EYJTi78Gg9Rkt/SDOHRvUN/hMpHz27wTDGse/6l9UKasRB5gx+3TfTSrV9PC0aDearLTemVdMU/SqW7KbM66FyxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LNXyxDsdHPhwU2oqLzjVcx5HU6SlJT1N/Any2QyCfXA=;
 b=GbDjeoDc8pvQgjgfvR4A0GdPedC/2l7BGd7tZwzoO1MYPSD8grV7k0bF4kLvAqAD4cgbpHFkhQq4PphCt9JgfvtwSQDO7S7dTihPXuAV+KbJRoitXW2Ro+Q0yMId/S1lNAvWP+j/T5nEsXCE71TGRsKiHYUB8CmbsAffgG2SgsI=
Received: from DM5PR15MB1675.namprd15.prod.outlook.com (10.175.107.145) by
 DM5PR15MB1371.namprd15.prod.outlook.com (10.173.224.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8; Wed, 15 Jan 2020 05:58:04 +0000
Received: from DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b]) by DM5PR15MB1675.namprd15.prod.outlook.com
 ([fe80::1cbf:c518:3a4d:291b%11]) with mapi id 15.20.2623.017; Wed, 15 Jan
 2020 05:58:04 +0000
Received: from MacBook-Pro-52.local (2620:10d:c090:180::6ad1) by MWHPR08CA0051.namprd08.prod.outlook.com (2603:10b6:300:c0::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend Transport; Wed, 15 Jan 2020 05:58:03 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>
Subject: headsup: latest llvm breaks libbpf/selftests
Thread-Topic: headsup: latest llvm breaks libbpf/selftests
Thread-Index: AQHVy2jA4EATUeuWXkqmraiIeyhMzw==
Date:   Wed, 15 Jan 2020 05:58:04 +0000
Message-ID: <18b7e7a4-dd3c-6e1b-c410-3b876320da97@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR08CA0051.namprd08.prod.outlook.com
 (2603:10b6:300:c0::25) To DM5PR15MB1675.namprd15.prod.outlook.com
 (2603:10b6:3:11f::17)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::6ad1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 566dce95-62dc-4947-5a84-08d7997fe2c3
x-ms-traffictypediagnostic: DM5PR15MB1371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR15MB13713CEE5920D134E3806FB8D3370@DM5PR15MB1371.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1265;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(39860400002)(346002)(396003)(366004)(189003)(199004)(36756003)(54906003)(4326008)(6916009)(316002)(31696002)(8936002)(8676002)(71200400001)(966005)(5660300002)(81166006)(86362001)(2616005)(2906002)(6486002)(186003)(6512007)(81156014)(6506007)(52116002)(66556008)(478600001)(64756008)(66446008)(66946007)(66476007)(16526019)(31686004);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR15MB1371;H:DM5PR15MB1675.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X0oBON6lZ8N+d6Q8NGLzNimSVdrFDobHvcqV0FHqHPaWZvKa/7hFzNNClb+HiSTVL+ILRin1BAJuVb+h3d+znBFkrtNZb6HLrDneatoGukYI9uTNC8rTbjt+by6BrvyuMVNW6e3rKTqDP6ksWML5uspBgl6J/QrPwvTGkcBDWQacVPUc/0FjVh/cUQSN5DAy918Spd0AUm7MF3V7tFLGVatrBk2QONxx4Xt37U7VBWZcvfbyLZkPZTe1hhr8wruI1gc2DjGY1PKMHs15Ntv/+zLB9eKjUNg6Na8YPo+ifUWIDh3pMMJ0FuQHeW1BH0SdGip+/x+LZo3J2PFh8zzGf4+1J/Zkq/5/ZTx5xsgXY7mQcTfCvI0/+AAMCayvFnJ1MILQaWjryQeRYv0aFy2Rhl+yhNK8rRKwoC94Gc9pGa4QBdXNVM2dZ9Jt1kvR+FTJy1LIlH8y5h8isHAtWY6AIUFUpciY15YM703H4yqzpqo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5B6FF05BE6F4C842BFFDE02366AFD676@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 566dce95-62dc-4947-5a84-08d7997fe2c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 05:58:04.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRg7IqAjlc0QcwQfkSNBfUvSdDGLgH413Qgd4i3gXgY1Ok6a8QU3eeGove3g/O2l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1371
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-14_06:2020-01-14,2020-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=921 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001150047
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGksDQoNClRoZSBMTFZNIHBhdGNoIGh0dHBzOi8vcmV2aWV3cy5sbHZtLm9yZy9ENzIxOTcsIHdo
aWNoIGlzIG1lcmdlZCB0byBsbHZtIA0KdHJ1bmsgb24gU3VuZGF5ICgwMS8xMiksIGVtaXR0ZWQg
ZnVuY3Rpb24gY2FsbCByZWxvY2F0aW9ucyB3aXRoaW4gdGhlDQpzYW1lIHNlY3Rpb24uIFRoaXMg
YnJlYWtzIGxpYmJwZiBhbmQgc2VsZnRlc3RzIGFzIGxpYmJwZiBhc3N1bWVzIG5vIHNhbWUNCnNl
Y3Rpb24gcmVsb2NhdGlvbnMuDQoNClRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1ZSwgYWZ0ZXIgeW91
IHB1bGwgaW4gbGF0ZXN0IGxsdm0sIGp1c3QgY2hlY2tvdXQNCnRoZSBjb21taXQgYmVmb3JlIHRo
ZSBmb2xsb3dpbmcgb25lOg0KICAgIGNvbW1pdCAyYmZlZTM1Y2I4NjA4NTliNDM2ZGUwYjc4MGZi
ZDAwZDY4ZTE5OGE0DQogICAgQXV0aG9yOiBGYW5ncnVpIFNvbmcgPG1hc2tyYXlAZ29vZ2xlLmNv
bT4NCiAgICBEYXRlOiAgIEZyaSBKYW4gMyAyMTo0NDo1NyAyMDIwIC0wODAwDQoNCiAgICBbTUNd
W0VMRl0gRW1pdCBhIHJlbG9jYXRpb24gaWYgdGFyZ2V0IGlzIGRlZmluZWQgaW4gdGhlIHNhbWUg
c2VjdGlvbg0KICAgIGFuZCBpcyBub24tbG9jYWwNCg0KLi4uDQphZGEyMmM4MDRjZDk1NmYzZWU3
Y2M5ZGM4MmU2ZDU0ZWFkOGE0ZmZlIEZpeCAicG9pbnRlciBpcyBudWxsIiBzdGF0aWMgDQphbmFs
eXplciB3YXJuaW5nLiBORkNJLg0KMmJmZWUzNWNiODYwODU5YjQzNmRlMGI3ODBmYmQwMGQ2OGUx
OThhNCBbTUNdW0VMRl0gRW1pdCBhIHJlbG9jYXRpb24gaWYgDQp0YXJnZXQgaXMgZGVmaW5lZCBp
biB0aGUgc2FtZSBzZWN0aW9uIGFuZCBpcyBub24tbG9jYWwNCjI0MWYzMzBkNmJhYjUyYWI0ZTNh
MDFjYmI5YTNlZGQ0MTdkMDdjNTkgW0FNREdQVV0gQWRkIGdmeDggYXNzZW1ibGVyIGFuZCANCmRp
c2Fzc2VtYmxlciB0ZXN0IGNhc2VzDQogICAgXl5eXl5eDQogICAgY2hlY2tvdXQgdGhpcyBjb21t
aXQNCjdmYTUyOTBkNWJkNTYzMmQ3YTM2YTRlYTlmNDZlODFlMDRmYjgxOWUgX19wYXRjaGFibGVf
ZnVuY3Rpb25fZW50cmllczogDQpkb24ndCB1c2UgbGlua2FnZSBmaWVsZCAndW5pcXVlJyB3aXRo
IC1uby1pbnRlZ3JhdGVkLWFzDQouLi4NCg0KbGliYnBmIGFuZCBzZWxmdGVzdHMgc2hvdWxkIHdv
cmsgYWdhaW4uDQoNClRoZSBpc3N1ZSB3aWxsIGJlIGFkZHJlc3NlZCBzb29uLg0KDQpUaGFua3Ms
DQoNCllvbmdob25nDQo=
