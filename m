Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7C8135D00
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2020 16:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgAIPnB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jan 2020 10:43:01 -0500
Received: from mail-eopbgr1310075.outbound.protection.outlook.com ([40.107.131.75]:64736
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728098AbgAIPnB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jan 2020 10:43:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZqQQDuBZZNtcI3Lj6rbIvnlX2dDyg2yiniv3/AwHfM7H51J09tUGlnNbcsiy5YHU3o/pqzna7kIRVyV74IGyJtHsmrV+omJL5/vixqNGaNzhcOiXGeBhZ2CTwVYMjgCAWbwVDyvXykKIWXKhFbttQobFjNqfujyQgZhcYnNpmXR029h1PzyaKFRq1aQtZoVEAIbdDL0R2aS6hkJcuXQvVOghtj46etW/YeU3mHyD94Um4QlIqH+yXZDHQtvcADoB5gkrxrscUhr33EwRp+BWOQ/mHYnB2wEjCdc9Okzs/tftvFI0i04VFPDtczBBr/+Fw6/A7v8NV6ae9J7ckONTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzyTqtbOfq3Ig0yXTX1EWjydOU+uAenurCB81rAkFjg=;
 b=YOVdNthcBLkMAN7XTCEijShhFVg+PRi7Q3bnUq6mt32w49a5qUbViQ90gMoGWa8CUdLF+XC+HCZAkp3mvO+H7ijpVwTfBIWVBVDe43V9hZ+44Gesk9b73GhA516P0/5O8w8EENGslq0Ppzufw/j3nmalDTFTKht5yV4KIPb6pi30E9asB6u5/VYhjoaIOAVhvQaFKSVisQPlugzLTzJdtTSJcrUeEu7HBfe+ttEA5JYqTYN4q70MamvS6p+7nPuGJZ6baXN0v9H84pVDH8Sh67s+DGoL3zoNDWOXuDKQ6czCxE5aPleSAf8Flpl6Q5R73g0xeWvJdS52e13dRg4VaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=teo-en-ming-corp.com; dmarc=pass action=none
 header.from=teo-en-ming-corp.com; dkim=pass header.d=teo-en-ming-corp.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=teoenmingcorp.onmicrosoft.com; s=selector2-teoenmingcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzyTqtbOfq3Ig0yXTX1EWjydOU+uAenurCB81rAkFjg=;
 b=GUXhJEzIfb+veQcY1cPFjEIK7SLh+7E8a8wFHc1A0Ot0u87rWfLbXH/EGIBPUzPMz+McNkBX0i3c+ZFzlmohwU7rOFrlu5w/U9gRpna5genQtDEFKEpxxrudLzMn3+KbgBA8Z1OSnhck8zJZVY3FoCO+2rdUQ+35sukmYl+J9Gs=
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com (10.170.174.138)
 by KU1PR01MB2005.apcprd01.prod.exchangelabs.com (52.133.203.15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.15; Thu, 9 Jan
 2020 15:42:56 +0000
Received: from KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::8122:ca17:cba6:19aa]) by KU1PR01MB2134.apcprd01.prod.exchangelabs.com
 ([fe80::8122:ca17:cba6:19aa%5]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 15:42:56 +0000
From:   Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Turritopsis Dohrnii Teo En Ming <ceo@teo-en-ming-corp.com>
Subject: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at 9
 Jan 2020 Thursday
Thread-Topic: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as
 at 9 Jan 2020 Thursday
Thread-Index: AdXHA2tFPmIUAZNGTAWnJSF576GrxA==
Date:   Thu, 9 Jan 2020 15:42:56 +0000
Message-ID: <KU1PR01MB2134DC143E5182FDCB19FC3087390@KU1PR01MB2134.apcprd01.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ceo@teo-en-ming-corp.com; 
x-originating-ip: [2401:7400:c802:de67:f1ab:6fde:d925:5c0c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc73331a-362e-4de1-abc2-08d7951a98ed
x-ms-traffictypediagnostic: KU1PR01MB2005:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1PR01MB2005D95097E2893FB25DC5C187390@KU1PR01MB2005.apcprd01.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(396003)(39830400003)(346002)(366004)(376002)(199004)(189003)(107886003)(6916009)(66556008)(4000180100002)(8936002)(52536014)(66446008)(66946007)(71200400001)(66476007)(64756008)(966005)(76116006)(186003)(2906002)(508600001)(4326008)(5660300002)(7696005)(316002)(6506007)(81156014)(8676002)(81166006)(9686003)(86362001)(33656002)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:KU1PR01MB2005;H:KU1PR01MB2134.apcprd01.prod.exchangelabs.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: teo-en-ming-corp.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HwjdgBCXdFWJQRZfr7a4b3Lq0VKU27zhfc4hT1uqCu/b2HoY+DyBk/ryKIMv0O2Ffvy7q6U9/NNRfuMnLQLaHe++rKvwRayT/GQF3+TzyVktz45cI8QPwKn0vfELptmYc77VHQKFOBhE27LZWDXgY/xH2KzYwj/fdIL3nRLxCv39Z+jjZvShPW+A8FsJ8H38xnSwTFiwBXeBGkDByI469XJuO3BlbEYMqu8DIPKQpeQYfsnRATKZdErQ7Y9pdG8aO2LLl3I2K0rR7YsLPKOGYBtpNQGg3qDRaYN6DBH9gxS8bTsYthNYcLvSof5/WCgSUR6estzqhLb/nH0U/+FANza9m09dli3t8+FsKTVwppQR2rLG7z4rJJ726aYJAJHySQeX2x8FpbNzWgYljN4Oxna+EzBADKlznCGb0jPs2Ih5ioMfm573hKXP7CQ4oKn9NSaPGVw46VBh/W8X0Be1F+uYMY1QZ4hrPfHr1drAVGuK4CDqOYW0KbRK4fcaeaidDM9o4gFx6UteP4lJld2G1A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: teo-en-ming-corp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc73331a-362e-4de1-abc2-08d7951a98ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 15:42:56.1656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 23b3f6ae-c453-4b93-aec9-f17508e5885c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmdik+oW3f/UKkVI7VzcLZTukvTzMaj4UPC4V77gbZUxbsKP9Xf7y5cSsqtkQi3iA34ME23pI5rd+4j7nPxwcWvAYrTWvVAZ+eoTz9MTOlc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1PR01MB2005
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SUBJECT: Singapore Citizen Mr. Teo En Ming's Refugee Seeking Attempts as at=
 9 Jan 2020 Thursday

In reverse chronological order:

[1] Application for Offshore Refugee/Humanitarian Visa to Australia, 25 Dec=
 2019 (Christmas) to 9 Jan 2020

Photo #1: Page 1 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa

Photo #2: Front of DHL Express plastic envelope (yellow)

Photo #3: Back of DHL Express plastic envelope (white)

Photo #4: DHL Express Shipment Waybill

Photo #5: DHL Express Shipment Tracking Online Page, showing that my applic=
ation for offshore refugee visa to Australia=20
was picked up at 1619 hours on 25 Dec 2019 in Singapore and delivered to Ca=
nberra - Braddon - Australia
on 30 Dec 2019 at 11:10 AM Braddon, Australian Capital Territory (ACT) Time

Photo #6: DHL Express Electronic Proof of Delivery, showing that my applica=
tion for offshore refugee visa to Australia=20
was received and signed by staff Mohsin Mahmood at the Special Humanitarian=
 Processing Center,=20
3 Lonsdale Street, Braddon, Australian Capital Territory (ACT) 2612, Canber=
ra, Australia.

Photo #7: Page 5 of Form 842 Application for an Offshore Humanitarian visa,=
 Refugee and Humanitarian (Class XB) visa, bearing the=20
official stamp of the Australian Government Department of Home Affairs at N=
ew South Wales (NSW):=20
"COURIER RECEIVED; HOME AFFAIRS; NSW; 27 DEC 2019" and=20
"HOME AFFAIRS; NSW; 27 DEC 2019" at the bottom.

References:

For the above-mentioned seven photos, please refer to my RAID 1 mirroring r=
edundant Blogger and Wordpress blogs at

https://tdtemcerts.blogspot.sg/

https://tdtemcerts.wordpress.com/



[2] Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday

Photo #1: At the building of the National Immigration Agency, Ministry
of the Interior, Taipei, Taiwan, 5th August 2019

Photo #2: Queue ticket no. 515 at the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photo #3: Submission of documents/petition to the National Immigration
Agency, Ministry of the Interior, Taipei, Taiwan, 5th August 2019

Photos #4 and #5: Acknowledgement of Receipt (no. 03142) for the
submission of documents/petition from the National Immigration Agency,
Ministry of the Interior, Taipei, Taiwan, 5th August 2019, 10:00 AM

References:

(a) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Blogger blog)

Link: https://tdtemcerts.blogspot.sg/2019/08/petition-to-government-of-taiw=
an-for.html

(b) Petition to the Government of Taiwan for Refugee Status, 5th
August 2019 Monday (Wordpress blog)

Link: https://tdtemcerts.wordpress.com/2019/08/23/petition-to-the-governmen=
t-of-taiwan-for-refugee-status/



[3] Application for Refugee Status at the United Nations High Commissioner =
for Refugees (UNHCR),=20
Bangkok, Thailand, 21st March 2017 Tuesday

References:

(a) [YOUTUBE] Vlog: The Road to Application for Refugee Status at the
United Nations High Commissioner for Refugees (UNHCR), Bangkok

Link: https://www.youtube.com/watch?v=3DutpuAa1eUNI

YouTube video Published on March 22nd, 2017

Views as at 9 Jan 2020: 659

YouTube Channel: Turritopsis Dohrnii Teo En Ming
Subscribers as at 9 Jan 2020: 3.14K
Link: https://www.youtube.com/channel/UC__F2hzlqNEEGx-IXxQi3hA






-----BEGIN EMAIL SIGNATURE-----

The Gospel for all Targeted Individuals (TIs):

[The New York Times] Microwave Weapons Are Prime Suspect in Ills of
U.S. Embassy Workers

Link:=A0https://www.nytimes.com/2018/09/01/science/sonic-attack-cuba-microw=
ave.html

***************************************************************************=
*****************

Singaporean Mr. Turritopsis Dohrnii Teo En Ming's Academic
Qualifications as at 14 Feb 2019 and refugee seeking attempts at the
United Nations Refugee Agency Bangkok (21 Mar 2017) and in Taiwan (5
Aug 2019):

[1]=A0https://tdtemcerts.wordpress.com/

[2]=A0https://tdtemcerts.blogspot.sg/

[3]=A0https://www.scribd.com/user/270125049/Teo-En-Ming

-----END EMAIL SIGNATURE-----

