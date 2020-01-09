Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE615136214
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 21:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728611AbgAIU7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 15:59:36 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:27853
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728508AbgAIU7e (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 15:59:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAUPlnz6OWBgTTwNNU6xzojnDz5MXmPLdIDFky+UttRzc+RYrIjWa/K80bFjNO/EEK4CNJnf93vZs3CqFv/fbqX4WSwAYsd/dal64nacURgk5Sf+sXK5b+LCMR9eJWuLcP7NzlT7AuPSPZ55dvgnaBapQjUNH/LbUKnYG36qgP9QeqUs3tGUYIemtrK/Ku1h1WbcMC/WrxvhCqRi9eIJhtOetUo9lSyAEnELPAeQ3KmB4CF6AH81raaDcJCC28yTUFjUWe01MBjgfrAQA3qtx37fh3VFskynWNc++1heiBPwO5QGaUU9vH8pQ/vcoIQ6s21cW9x6IrurM2MnlKZsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5FZbpLd938kmTEfhl0oqHxaovzMo8dYURXWFhR/DQ=;
 b=U7gPLeumKJVoDoMnGRL9pBte1Le6aw66ElTrqZ6Upk5CRHnU6QI6GDLafnxDxgkXZcK2TyYpkvlm8rCzO+XtLLiWAkPPo9rtALtuwcANTqEpjrKcIWWniGTov0iwSENchKaDuvlcWgeaFuz8VJjQndCwfjxzq1v1v0fkBtTJMzUhJPxmHFzw/hD6qvX/sz+8835NNV62uiKdfg0BwYJjhR4PQiLgZLh2igh3KsDIVS6KpgwOIH/1L74Y0gXvFalrQT4+BH56JQglEKSqOPVKiUGNqzTMhfT2vZxQkOWRYtyRKWwBdeR1zN5+GQ29mzsb0DnuQqBt5Rc1tU9fQPU2IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tP5FZbpLd938kmTEfhl0oqHxaovzMo8dYURXWFhR/DQ=;
 b=KeaFL4PRlXWluwgVDEkBH3bZZNmVwt2zIYr/UeXhUrcQepyIn1OpowYQQiV6vdw9yl5zEMmhEAJikvcOnWfa1GTh3/CkBKO9e2WoaH1cxjSXby2kxtH5vK85SWWjQP4YaLe4d6kzoHNoSGAB7CCzaCfzMo4T8qkLWlq+uIZqNE4=
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com (20.177.51.151) by
 VI1PR05MB5024.eurprd05.prod.outlook.com (20.177.51.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 20:59:29 +0000
Received: from VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::d830:96fc:e928:c096]) by VI1PR05MB5102.eurprd05.prod.outlook.com
 ([fe80::d830:96fc:e928:c096%6]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 20:59:29 +0000
From:   Saeed Mahameed <saeedm@mellanox.com>
To:     "bjorn.topel@gmail.com" <bjorn.topel@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "piotr.raczynski@intel.com" <piotr.raczynski@intel.com>,
        "ttoukan.linux@gmail.com" <ttoukan.linux@gmail.com>,
        "peter.waskiewicz.jr@intel.com" <peter.waskiewicz.jr@intel.com>,
        "magnus.karlsson@gmail.com" <magnus.karlsson@gmail.com>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "brouer@redhat.com" <brouer@redhat.com>,
        "toshiaki.makita1@gmail.com" <toshiaki.makita1@gmail.com>,
        "jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>,
        "toke@redhat.com" <toke@redhat.com>,
        "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
        Tariq Toukan <tariqt@mellanox.com>,
        "neerav.parikh@intel.com" <neerav.parikh@intel.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>
CC:     "jhs@mojatatu.com" <jhs@mojatatu.com>,
        "dev@zabiplane.groups.io" <dev@zabiplane.groups.io>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "tom@herbertland.com" <tom@herbertland.com>
Subject: netdev 0x14 XDP workshop, call for participation
Thread-Topic: netdev 0x14 XDP workshop, call for participation
Thread-Index: AQHVxy+vdxlw26BUCEyr2AiSM4ZQzQ==
Date:   Thu, 9 Jan 2020 20:59:29 +0000
Message-ID: <feee123711a3d79f0b9c0c26b49934e9d1b4a46a.camel@mellanox.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.2 (3.34.2-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saeedm@mellanox.com; 
x-originating-ip: [209.116.155.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f565df0-2741-4551-406c-08d79546d1c6
x-ms-traffictypediagnostic: VI1PR05MB5024:|VI1PR05MB5024:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB5024B140379BBA7740E94F55BE390@VI1PR05MB5024.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(189003)(199004)(53754006)(91956017)(2906002)(66946007)(64756008)(66446008)(66556008)(76116006)(6486002)(4744005)(7416002)(6506007)(26005)(186003)(54906003)(110136005)(316002)(36756003)(966005)(66476007)(71200400001)(2616005)(8936002)(478600001)(81166006)(5660300002)(81156014)(86362001)(8676002)(6512007)(4326008)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB5024;H:VI1PR05MB5102.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZcpRKzV0BQlr2px9M2V+pTmvQkjGYNE73+7QlFkEvxL/2+FCx6FSjkceTyXSTrV4pvkoRl2Skt+CW1F3F+94kMNqDmcV+UECBYeLFVFRXP5LSlJ2W0Og9FZDoc4rqnQwFXCGop3qv6nlnkznmnM2g8PLIxDLsAAhncRfso1De2DTFSjSYJ/12piyynhaRDPIy8MY6MNVt0H+EO3d1vtimt8pjr9+03hpqTkpd+CJx6fXq/jaFrS1smVn8CpFL8ibqa2QGWVSV/HT/kRSMRfnT4RRNLf25GA5tMsq1Py74rhl33LpquLGrZ8nsLbM6ZJPdULvmji5fCGdHxb9leRgTsrsbY7qxV+4PlSI4NMryQJ0+6bIp+QTlIdVfaKugJgq0SMSKLce87fjnOpPErNUSa//xvnftbkc/Zte8svx8f2US3EXxdqCuDUTD9GldWt74ewAN0hkkdk+Q9PIn+bDVbCKM41bEGoj4pR/VwVdYN66qQn0+t8V6y5BrcU7BoBdvpLNMYrebSMBaG3KJyxtPQyZz4dinKw3ajjdXAqP86D9/3ePPUsCjU6TgdLjpIqCXyRyHGisWyRGU/esGTfsF+T2SPPN6Q4XFhMUt6xuJjE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D92E103742327C42B16D2E051A0DB4AC@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f565df0-2741-4551-406c-08d79546d1c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 20:59:29.4295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G8O4VDk/7vlWd0kCZj34Kdioz39P/08UvnSfVWxrZMj5aTZTNCaThI3+zaadCMhk5XO5w82buQoKcWb4jKH/tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5024
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SGkgQWxsLA0KDQpJIGFtIHdvcmtpbmcgb24gcHJlcGFyaW5nIGEgWERQIHdvcmtzaG9wIHByb3Bv
c2FsIGZvciB0aGUgY29taW5nIG5ldGRldg0KMHgxNCBjb25mZXJlbmNlLg0KDQpJIHdvdWxkIGxp
a2UgdG8gY2FsbCBmb3IgcGFydGljaXBhdGlvbiBhbmQgaWYgYW55b25lIHdhbnQgdG8gam9pbiBh
bmQNCmhhcyBhIFhEUCByZWxhdGVkIHRvcGljcywgZGV2ZWxvcG1lbnQsIGV4cGVyaWVuY2VzLCBp
ZGVhcyBhbmQgaXNzdWVzIHRvDQpzaGFyZSBhbmQgZGlzY3VzcyBpbiB0aGlzIHdvcmtzaG9wLCB0
aGlzIGlzIHRoZSByaWdodCBmb3J1bSwgaSB3aWxsDQptYWtlIHN1cmUgdG8gaW5jbHVkZSB5b3Ug
aW4gdGhlIHByb3Bvc2FsLg0KDQpGb3Igbm93IHdlIGhhdmU6DQoxKSBYRFAgSFcgaGludHMsIFNh
ZWVkDQpTaW1pbGFyIHRvIHdoYXQgd2FzIHByZXNlbnRlZCBpbiBlYnBsYW5lIEhXIGFjY2VsIFdH
IGJhY2sgb24gRGVjIDE5dGgsIA0KaHR0cHM6Ly96YWJpcGxhbmUuZ3JvdXBzLmlvL2cvZGV2L21l
c3NhZ2UvNTYNCjIpIEJyaW5nIHVwIGlzc3VlcyBhbmQgaWRlYXMsIERhdmlkIEFoZXJuLg0KDQpJ
ZiB5b3UgYXJlIGludGVyZXN0ZWQgaW4gam9pbmluZyBwbGVhc2UgcmVwbHkgdG8gbWUgQVNBUCwg
d2l0aCBhIHRvcGljDQp0aXRsZS4NCg0KSWYgeW91IGhhdmUgYSB0b3BpYyB0aGF0IHlvdSB3YW50
IHRvIGRpc2N1c3MgYnV0IHlvdSB0aGluayBpdCBkb2Vzbid0DQpuZWVkIGEgZnVsbCBibG93biB0
YWxrIG9yIHNlc3Npb24sIHRoZW4gdGhpcyBpcyB0aGUgcmlnaHQgcGxhdGZvcm0gZm9yDQp5b3Uu
DQoNClRoYW5rcywNClNhZWVkLg0K
