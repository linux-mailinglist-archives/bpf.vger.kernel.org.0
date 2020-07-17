Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8045F223DF8
	for <lists+bpf@lfdr.de>; Fri, 17 Jul 2020 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgGQOXk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Jul 2020 10:23:40 -0400
Received: from mail-eopbgr50133.outbound.protection.outlook.com ([40.107.5.133]:14660
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726090AbgGQOXk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 17 Jul 2020 10:23:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkpxCsQ/cGA/J9u6lgQZ9uM/9fxKI+lJMHjYdLGjrKR4aH70oErQD+5bOx2hlNfFup93JjC//L0kPFtSvzv8eTz9OVkBm7zcROx9y+NrXu4Jz/qoQFwyDfjmXX44MoHMa7W1TfhnjJkIuGAhZlFflRxB8G4pelwW//CqkVECsd3eEety1xN3vEwT+1+gLyBFNFnoWe4RFov/uYmostc+hU6dJayb1qkVz/RPFlWQZCXCI/33GB0gyuZ9mP3JHqh4mSQvlsuNI0WFgTpX2WNJx5EXYEPNbpoSd5IMcWSFfrnUFxh6XiAD/Bn6S+F+uMKmxXSqLb6+3js1liBbSywuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8oqi9LXQkaiXTLV3dPVg3+LxEurxj5pvF207urhTIE=;
 b=FVYYG24pi70+D1mEYlC8dZ+iAB3xSzf0HDjb3gmePXd98XgV4AkvXrtaqGxwWa1UnZxYsMDrcoVk17mSmD7CMG0Ooy3HMVsYJ8RWOdys0QGgbfZ+5eRwMbWBzKpZ4WGzJpp5q69pG4tS7mQtjHyQeVkmO6EdiSAduw53xLx5E45ZiaM/7VKw5H7Bp2nhj5TOXv7tQPhxNChOTtVib2qGpslU4bYILJZsotgpnC3f0WHKERIF7zI3806T944siRFE4jdlkpcQP9uwC8bx0PGGrc7kKE6ZtqwNiO9PoSuqMXTk7t+mtrLDopzZPhh+cc32Skct01y3s8oe4MVAxT0/tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8oqi9LXQkaiXTLV3dPVg3+LxEurxj5pvF207urhTIE=;
 b=FqtWIEaG6o8QVTEuCixkkGS5Blg9b6FwnJAW50y9H0BvM05X2VMJbFnVL4LEEUSst6LII0wfQsgsrryL6F0hsjxvNLe0D/o7bigVgytQaIW1E02TwV/mlZ78ehUXGnzxKliq879x1Y3hY5yJAawyqaYNkAr1XB2PSzJCbuyM5NE=
Received: from AM5PR83MB0210.EURPRD83.prod.outlook.com (2603:10a6:224:e::25)
 by AM6PR83MB0230.EURPRD83.prod.outlook.com (2603:10a6:209:69::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.14; Fri, 17 Jul
 2020 14:23:37 +0000
Received: from AM5PR83MB0210.EURPRD83.prod.outlook.com
 ([fe80::5c8:a547:c544:d19a]) by AM5PR83MB0210.EURPRD83.prod.outlook.com
 ([fe80::5c8:a547:c544:d19a%9]) with mapi id 15.20.3216.014; Fri, 17 Jul 2020
 14:23:36 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Maximum size of record over perf ring buffer?
Thread-Topic: Maximum size of record over perf ring buffer?
Thread-Index: AdZcRdT23AT0UyAxRuO+fVAupufT3w==
Date:   Fri, 17 Jul 2020 14:23:36 +0000
Message-ID: <AM5PR83MB02104FB714E7E29DD90D8E06FB7C0@AM5PR83MB0210.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=kesheldr@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-07-17T14:23:35.5047193Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f81394ad-ce5c-4d40-a3e5-d4c49ac86bdd;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [149.22.2.128]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9041496f-15f2-4b7f-aedc-08d82a5cfe87
x-ms-traffictypediagnostic: AM6PR83MB0230:
x-microsoft-antispam-prvs: <AM6PR83MB0230E9402C0FABED69491441FB7C0@AM6PR83MB0230.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnM6mS4AAEuDwf8Z+djI4uGu8OER9JmmfTUtt83xFnUi+puOPisqvyzQgP5XmW6DvQmg4HUm7cuWPTi/CzmmXm+DGvJJWpUyu6Ev9CBgLJUqXm8jAaa78ucf2+rVy6iOL5uvxVVukZ4TrkT619v3y8oq6K7anDfURVLszh6Oo0W+8AePTuHXvGw9rUTP5TKJ/Azw3Wftc/PDGoZnu2zZ4+vqqoZevtLPjyjyhIkLZQ+50uoOW+5IRfNGShpbZ8G1vVuniojPGFq9B2jc7Xy1U5hy2bfA3Vc1wpqnUesYcd5+d+tgTIOfVdR7mtB7hUjKH4sCm9Gr03nEGtYlHM4log==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR83MB0210.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(186003)(55016002)(6916009)(52536014)(26005)(83380400001)(8936002)(8990500004)(82950400001)(82960400001)(478600001)(2906002)(8676002)(66446008)(64756008)(66556008)(66476007)(316002)(66946007)(76116006)(86362001)(5660300002)(71200400001)(33656002)(10290500003)(9686003)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 1RGPOQnDl9YUiyxQfr63TXuOT8ZCAa83uFxZ/ql9Z5PMhV+0OoUKak09pm6BLLiHAB727o5Mak7VhLCUFbCCwR6tcFUrqpZZlUSIBofSS07DRnk/z+oS7HhlQ9irrRQ/p6BWd2fdsVfKTHbkqVxKbuNEeypF959xhUv9xmXj+8M4bOx0CdpzDYnMUMUQJJY8ceDIXN8Spn1Cd91O/VvMUyNCkr7pkWXfW9b43LwPu0S+NpPcR41s0S6Ypbpp7ipi7XPW524MCOiz7W1Sl7HV5MoIyii8N+EYGC3KZqlNXIxwMWC/i97vPf33Wf4K5TuY0JWHcRFPtWfLQskG9y4WZ6Fc3W6REl5n/5KaocfeLF1tiD9hw0Ep3C1W4ggYsaanGzaFUDZt3yaN1+Ysi0xEa+R2IWN8x+LduxOdskO6ZX6dEw8WmjlC24DfwO0C9jYZN7CdNoKL427J4EUw02UjtO9qkoUgY/1F6q4sQrVIWM8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR83MB0210.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9041496f-15f2-4b7f-aedc-08d82a5cfe87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 14:23:36.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DfqwInEYzKTo4twIUUKDBLrs2V0fKiHaHPqv27EqaPEaoht3EV8xmi8Gohy04+CJZ+8M88Gw9HovNweCoqkCig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR83MB0230
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

I'm building a tool using EBPF/libbpf/C and I've run into an issue that I'd=
 like to ask about.=A0 I haven't managed to find documentation for the maxi=
mum size of a record that can be sent over the perf ring buffer, but experi=
mentation (on kernel 5.3 (x64) with latest libbpf from github) suggests it =
is just short of 64KB.=A0 Please could someone confirm if that's the case o=
r not?=A0 My experiments suggest that sending a record that is greater than=
 64KB results in the size reported in the callback being correct but the re=
cords overlapping, causing corruption if they are not serviced as quickly a=
s they arrive.=A0 Setting the record to exactly 64KB results in no records =
being received at all.

For reference, I'm using perf_buffer__new() and perf_buffer__poll() on the =
userland side; and bpf_perf_event_output(ctx, &event_map, BPF_F_CURRENT_CPU=
, event, sizeof(event_s)) on the EBPF side.

Additionally, is there a better architecture for sending large volumes of d=
ata (>64KB) back from the EBPF program to userland, such as a different rin=
g buffer, a map, some kind of shared mmaped segment, etc, other than simply=
 fragmenting the data?=A0 Please excuse my naivety as I'm relatively new to=
 the world of EBPF.

Thank you in anticipation

Kevin Sheldrake

