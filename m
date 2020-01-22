Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB15144BF8
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 07:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgAVGvI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 01:51:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:8136 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgAVGvI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Jan 2020 01:51:08 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 00M6oPjx014640;
        Tue, 21 Jan 2020 22:51:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=facebook;
 bh=cMB8vq5P45QnHPSWxhnPZ8p6q7RmWMyLW4Qf25VL1Qs=;
 b=F6/ruQ6eoUS6/WwBTqHJz4wpun4rXmpR2YmIrSMzNbuSU2wjrxfsOr+mooMvl6y1ucJq
 cabjcDhpzW712wRfJZOAhWf+SG2sp8qH/6OtqfSXb+GwJYAVIHcoke1Yf6ijohRn9KYd
 mtz1k6+7SrfUV+zejtzUetSNccvasXCpVKs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2xp8jc1ytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Jan 2020 22:51:05 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 21 Jan 2020 22:51:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUf2SX6CJXfRjg7tk10vq7FXNpxqbEyB9Ag96pwHUU9rQNL/DTYBWc58ZiDxqWLnkQmCWUpQTV2vHozl8vscszOgAgMdANWE4GasxkgOLmsQelIY/L+dVYi8gcq8JSB1O4g9cp7Su8B4uLbzcHQdHyX3A4qWBRyG/aYuuS4b2Jm2O06LnwPWcQNnIv/kgQ3/Z0EooYlTotZdUPY4A55k8YVtANErQy05d6FxVqLBHszadsNllIPoWya+oJKDDDqnxPCAMKJUIIW7EtspoMEsxG7wtIqRWjrizo1NniRR/lj8DzdgCbfVk4SaBHBiNtgglTmxIbTlna3daU+8JPRaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMB8vq5P45QnHPSWxhnPZ8p6q7RmWMyLW4Qf25VL1Qs=;
 b=UV9i51Bi8t7cG3hRzwupFZ0WosY51ZbCj9sHYaJV1ay2uepy9X5XubSNHg5cw9OWmssV32xy0f1ZMl1ywKtznTTUnXhyti9I68kDyOXaaDsMNHgu+EQ8UswBx4HrgMW/nzIrCqfMRf/QU6fDY1Rc36SfQHyAkUzzW+GeBjqePetpTv/uVZHrLluUkG7snMWWR7feMFD0x7N66q/QUbqUNw2Gl40G8MFqLelF7+PLNWb1noSN0caxlNtnlgBagTdqOnDci2Y6DvOedNKa9wVbDWxSmorDgh6ALyddQL41I4RN2FAJGwF2xG4Nm3hDcNh2cTo8k33o0KvIJ3qeQA85YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cMB8vq5P45QnHPSWxhnPZ8p6q7RmWMyLW4Qf25VL1Qs=;
 b=Ubv3SP8h0NYhoA82Iyy1cmT3Qv92tZSFd8SJ8hLAbqoIy4UG5u5wN0FdFsxrcFJAkXW6+F60sX/nxiYszFxLK/62wLJi7U5K8n9ifFGuSZsYwxYjndM4wS9Wuet6xjkAeFKD99UqgcnpjF2+hoEs1K6RGSQkFy0eMfY1b4nvKcw=
Received: from DM6PR15MB3001.namprd15.prod.outlook.com (20.178.231.16) by
 DM6PR15MB2298.namprd15.prod.outlook.com (20.176.68.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Wed, 22 Jan 2020 06:51:03 +0000
Received: from DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2]) by DM6PR15MB3001.namprd15.prod.outlook.com
 ([fe80::1d74:b392:183e:c8c2%6]) with mapi id 15.20.2644.027; Wed, 22 Jan 2020
 06:51:03 +0000
Received: from macbook-pro-52.local.dhcp.thefacebook.com (2620:10d:c090:180::abe3) by CO1PR15CA0080.namprd15.prod.outlook.com (2603:10b6:101:20::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Wed, 22 Jan 2020 06:51:02 +0000
From:   Yonghong Song <yhs@fb.com>
To:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>
Subject: [LSF/MM/BPF TOPIC] BPF single step debugging
Thread-Topic: [LSF/MM/BPF TOPIC] BPF single step debugging
Thread-Index: AQHV0PBP0NXnPPcYdECsnNLCnYspaw==
Date:   Wed, 22 Jan 2020 06:51:02 +0000
Message-ID: <0004eb35-e7d4-9d18-26fc-4a9965d49195@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0080.namprd15.prod.outlook.com
 (2603:10b6:101:20::24) To DM6PR15MB3001.namprd15.prod.outlook.com
 (2603:10b6:5:13c::16)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::abe3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0d29d340-255d-42db-3b45-08d79f077259
x-ms-traffictypediagnostic: DM6PR15MB2298:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR15MB2298E089CF99EF81EE27DC45D30C0@DM6PR15MB2298.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029097202E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(66946007)(8676002)(71200400001)(81156014)(81166006)(8936002)(36756003)(16526019)(2906002)(31696002)(5660300002)(186003)(6506007)(66446008)(66476007)(2616005)(498600001)(6512007)(6636002)(31686004)(66556008)(64756008)(52116002)(86362001)(6486002)(110136005);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2298;H:DM6PR15MB3001.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrBahpVS00Fjnt5UQI9cp/6+9+nG2L4zUclkyLa6ZOy/oZNFkxajutCbF0j1Yp6bhXuH83iUqQWLGKc7QtAuV7MxXjJm3ALenUNgZLnMu2XQyCRz1UYTSlT9T5zqIom79B3BlT2J7dYNDVwOO7GdVoBgrOW9oDobRaoo66AskAFMuoCdRMTp/RFeaAZfiQD176TrOcl0ivcmpjpI3VpbJ+pUj/PceZuwMQVs5/QwIvlKOmNgXM0fY4kMx20nTLQWgYBeyZtOaDm+ATLxbYiL9qExu6Eku/39ZznXcxoMiCclErp42OSHgp9VKIT4gQKwz0CX9e/HVadG1SW2ObsYRSOrnDssTJznMn20OHH6mMY3LhlMNkihFO3Wy+m0yk7OWz/5bZ2vgitLdgbEaM26OAlCPd6EBLU8TiZmxu8Rp1XFEQQtkc1/dWkYJbr0kIWy
Content-Type: text/plain; charset="utf-8"
Content-ID: <E2997D8D0E85814890BF7799BADCA563@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d29d340-255d-42db-3b45-08d79f077259
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2020 06:51:02.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6AzELPsJIrgQ6VUu2JQXsqKjp9UAUZW3gp7ktGzaHAbU/Y151GFpoFY2S40hzu9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2298
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-17_05:2020-01-16,2020-01-17 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=634 suspectscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001220061
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

QlBGIFNpbmdsZSBTdGVwIERlYnVnZ2luZw0KPT09PT09PT09PT09PT09PT09PT09PT09PQ0KDQpE
ZXZlbG9wZXJzIGhhdmUgbG9uZyB1c2VkIHNpbmdsZS1zdGVwIGRlYnVnZ2luZw0KZm9yIHNvbWUg
dXNlci1zcGFjZSB0cmlja3kgYnVncy4gQnV0IGZvciBicGYgcHJvZ3JhbXMNCnJ1bm5pbmcgaW5z
aWRlIHRoZSBrZXJuZWwsIHRydWUgc2luZ2xlLXN0ZXAgaXMgbm90DQpyZWFsbHkgYW4gb3B0aW9u
LiBQb3NzaWJsZSBzb2x1dGlvbnMgd291bGQgYmU6DQogICAoMSkuIG1heWJlIHdlIGNhbiBydW4g
dGhlIGJwZiBwcm9ncmFtcyBvbiBhIFZNLA0KICAgICAgICBhbmQgd2UgY2FuIHNpbmdsZS1zdGVw
IGJwZiBwcm9ncmFtIGJ5IHJlcGVhdGVkbHkNCiAgICAgICAgZnJlZXppbmcgYW5kIHdha2luZyB1
cCBWTXMuDQogICAoMikuIG1heWJlIHdlIGNhbiByZXNpZ24gYnBmX3Byb2dfdGVzdF9ydW4oKQ0K
ICAgICAgICBpbnRlcmZhY2UgdG8gYXQgbGVhc3QgYWxsb3cgc2luZ2xlIHN0ZXBzDQogICAgICAg
IGZvciBwcm9ncmFtcyBpbiBicGZfcHJvZ190ZXN0X3J1bigpIGVudmlyb25tZW50Lg0KICAgKDMp
LiBtYXliZSB3ZSBjYW4gc2ltdWxhdGUgc2luZ2xlIHN0ZXBzIGluIHByb2R1Y3Rpb24NCiAgICAg
ICAgZW52aXJvbm1lbnQgYnkgYXR0YWNoaW5nIGtwcm9iZXMgYWxsIGluc3RydWN0aW9ucw0KICAg
ICAgICBpbiBhIHByb2dyYW0uDQpFYWNoIG9mIHRoZSBhYm92ZSBhcHByb2FjaGVzIGhhcyBzb21l
IGxpbWl0YXRpb25zLg0KRnVydGhlcm1vcmUsIHNvdXJjZSBsZXZlbCBzaW5nbGUgc3RlcHBpbmcg
aXMgbXVjaCBtb3JlDQpwcmVmZXJyZWQgdGhhbiBvcHRpbWl6ZWQgY29kZSAoLU8yKSBzaW5nbGUg
c3RlcHBpbmcgYXMgdGhlDQpmb3JtZXIgcHJpbnRzIG91dCBpbiBtdWNoIHVzZXIgZnJpZW5kbHkg
Zm9ybWF0cy4NCldlIHdvdWxkIGxpa2UgdG8gZXhhbWluZSB0aGUgYWJvdmUgdGhyZWUgZGlmZmVy
ZW50IG9wdGlvbnMNCmFzIHdlbGwgYXMgaG93IGZhciB3ZSBhcmUgYXdheSBmcm9tIHNvdXJjZSBs
ZXZlbCBkZWJ1Z2dpbmcNCmFuZCB3aGF0IHdlIGNvdWxkIGRvIGFib3V0IGl0Lg0KDQotLSBZb25n
aG9uZw0K
