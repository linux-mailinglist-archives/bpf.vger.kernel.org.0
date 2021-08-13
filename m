Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7F63EB3BB
	for <lists+bpf@lfdr.de>; Fri, 13 Aug 2021 11:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbhHMJ6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Aug 2021 05:58:09 -0400
Received: from mail-eopbgr60127.outbound.protection.outlook.com ([40.107.6.127]:12005
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239016AbhHMJ6I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Aug 2021 05:58:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ7ZZ0BwqdftZZEari5b02AWYcz+ks7uaBP0BPf+Qgj5l+eAjvnpsX81180z8Pudlxv3fS0XUwaZ1TUKNA+6sBqdVCJ1LDDuF2xuh4EepQvH2XXR0C2Os/8KMyKliCO7U9sKd2S+NTmdxmu4yMXSDNaNH96RqmB2+ikQdm5x6Yp0FnxfcQNonzgd9YSKGnpiHinvyLvmxibryBtGYf1hxwCyalBa7IXKhrv9QLfMOpJU5l778oSWNsbXzfjHbEuU3yhe/KkWR/l6sX6b00VkhkzjRVNGyEs6ihSm0GMhmT3E3FKfY9cEiJ1c1FAJcuXcDTw2EVS2J3iYsRT7/uBHvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8WURZ6ajDeKfr1SioMJxfwuO3mW6++K2CD/r+0QV48=;
 b=fsOilbzEtn/1dVpUblL8QQB7H5MACd/kCLlHvDc9rKUZmL69S6VB80ltQS5jqxMCYxRMPt+o/h9CZ7CU3zAaSat3HyAcMsw/d1RSm+Gt/BmcoNDkWr7gmi+V+BO5HXI4iuP2Is6e8x3REWjMf+JbDPz8qs7U8sJZl3ZuwBcVZ1IVUXNaKkgzQWyThLt9uPQ5lSHaTVhkk8sMjEfC3l/+qnNryYkgRjPHJfuIcLjRCVmDRPJKjmEIC88i9aBpE6C/9MZlMUEpzA2rc7x/r2oNzQWr3jx619kqcCyD1o9774eTGhkXo0FofLP9hX5SB9xFIGrlyTPRH1jhN751sTMPTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8WURZ6ajDeKfr1SioMJxfwuO3mW6++K2CD/r+0QV48=;
 b=Fsjew8wc++2pucWmHC3egsOvehAE0JkoqTtmk1Wo69M8y7V5QllOxrzQM2GxZUAVrhsGLqvve/k+/oKfUilhdX0AjQ+MQfDiRT/ejPwRrOz3or/RQfCYEqiiHUg0FQgxKVkjw4BR8Qw+dhqU02mDRk+AhP7r7E2rhGOJ5ljErcw=
Received: from HE1PR83MB0380.EURPRD83.prod.outlook.com (2603:10a6:7:63::13) by
 HE1PR8303MB0092.EURPRD83.prod.outlook.com (2603:10a6:23:17::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.4; Fri, 13 Aug
 2021 09:57:39 +0000
Received: from HE1PR83MB0380.EURPRD83.prod.outlook.com
 ([fe80::18cb:6fc1:371d:751a]) by HE1PR83MB0380.EURPRD83.prod.outlook.com
 ([fe80::18cb:6fc1:371d:751a%7]) with mapi id 15.20.4436.011; Fri, 13 Aug 2021
 09:57:39 +0000
From:   Kevin Sheldrake <Kevin.Sheldrake@microsoft.com>
To:     bpf <bpf@vger.kernel.org>
Subject: signal/signal_deliver and bpf_send_signal()
Thread-Topic: signal/signal_deliver and bpf_send_signal()
Thread-Index: AdeQKDHCoRVxaytpS+OXCpLUfp+NfA==
Date:   Fri, 13 Aug 2021 09:57:39 +0000
Message-ID: <HE1PR83MB038015B1D19B02219FB1315BFBFA9@HE1PR83MB0380.EURPRD83.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-13T09:46:54Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=20f74fce-fd23-44a6-bd07-c9b854d76d1e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 415c00b9-d137-4256-b5b8-08d95e40c94d
x-ms-traffictypediagnostic: HE1PR8303MB0092:
x-microsoft-antispam-prvs: <HE1PR8303MB0092B5DC17D0A300D750503AFBFA9@HE1PR8303MB0092.EURPRD83.prod.outlook.com>
x-o365-sonar-daas-pilot: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8GsMiAdc/nmKNsv9BO718H8S3Mu+BIYZtkY1qQWXADSOnSYohNhYcbrBGbvTrWkYb5JBjO7nWfRYKyChw9GDOLWnL3dkcSDyiMaYfxTWCL7aA66onuns6zCll+GlraR9LAODGKNXwWTFsxVLNfBfdEio3rSgzOrF2uj94ECTKQFHlso5OhOMZho8r4PsQtloN8kR6B7YVj6NwOk8xZr/B24ngMuz6HZB77axI8DrgtWzUJdscBQtdc/RZZWHzkAEYLPl1M9Fxj042vcXUHxM9UKjB1OUOYBFpC6WiMAcs59gBp5URaFKnP6Ict00FwvGAiSvuIj9aPUcF3PmQCKF502MaMn/rKwEzCbwwBp6MPxyBZyExF6Or/B+048cAaZxAGQHEosrmviBlcvPugzJNc0j+Tpeq26L0OuisRClgRNK/o3fg9Y/yVIZk+CR0Sk6dAaKRa/8Xysg7GHZMQhzMY3PKmKb58/tkt7MKG1KtU5xIFIcSeWPL+ZJ3pS/XeHV+Paxb9EdNgXf/43ZBg//1AxE8d8A69ADqnrEQUu/boUerDgaNdiar695bQcXgQnLVTN1OWrt/izpl4iZghG2ui++lFJkztkVprC36NEifnvfGaDBeE0PBbt97s1654lVzVoqaD1YH15Kb4wJTBEMBdCpn16FCEpM8xBVJf2Ci/TD8Lxu8fqdeguwQ9e3IXvT0rc2BdArWqCoysmfivVzbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR83MB0380.EURPRD83.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(8676002)(82950400001)(82960400001)(2906002)(10290500003)(5660300002)(52536014)(8936002)(86362001)(7696005)(38070700005)(33656002)(26005)(186003)(38100700002)(76116006)(122000001)(66446008)(83380400001)(64756008)(66556008)(71200400001)(316002)(66476007)(66946007)(8990500004)(9686003)(55016002)(508600001)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vB8oXSFGvc1RyQrRzj83XitypgEgT8XG4lth7CsjwTXJpeiNnsEJGG47Luxr?=
 =?us-ascii?Q?YGcPkza6ojZBM/kMRtSmaqJDFbPs8A2qkXDA2LNQNi9GO5P+v8AkgxThNfP0?=
 =?us-ascii?Q?safRIxOljgJS+jHzA6NT2dC1afKmW8WnfJac84572onrqO6vRT/VCekGoiog?=
 =?us-ascii?Q?PSpf+u5bCgRKIR00INDp/WAkSukl191tpii+WUgBUaqrU1//9r1CRDR3niHI?=
 =?us-ascii?Q?FPKpwbjtfytmZkpUNVLIu/MHUO0V3+dtOFGetjtaJ4ynnQAaOG9vzq9bEFks?=
 =?us-ascii?Q?/7TBCf+2aN50js5cla8OWLiYd9zCxvDxnblTcMLtWXPW0NteVuCGXI6tDgJY?=
 =?us-ascii?Q?ZgkMjSyHw9tpYtCJ/DZXbGjbDOOMI+hA/+tDazI43vOXA6Ib6oyejrxteOO5?=
 =?us-ascii?Q?j9BlAqcV1EKmBVl5iek+wLHgB3NJx4VtcEjEdlCwkpMpaAz3PPtEcYAG9MSf?=
 =?us-ascii?Q?PReXae4wGRhYWV4609gqbYblq5YXEbvnVlB2Jzqt1UGKeflPESm8aIzgj5Gk?=
 =?us-ascii?Q?OYASAOtfo3Oy3Xalvk5vU16Qoq69aSko3kTqpn61dN1SfNLavVnGtCAEpiu+?=
 =?us-ascii?Q?GKsMTPzVstxIVRDYBylxyvZ0pdrq7Ju+gE0HllxulbaSQUSun3VtJLEFNrb4?=
 =?us-ascii?Q?8vbEfi839fDFshJlabHqaYUUFLpRfeNlByh5nfaGqxI+4BXlZd/D1a8gdAA5?=
 =?us-ascii?Q?iwCUAXtrQmXR01y2yZX2jlMHYPllSR3/Guc1Ck2dxlpUUsYr8aWjudytk9N5?=
 =?us-ascii?Q?ANUkcJtTPfzv3+OdViO9qIFHve1uHChY8CNureywjRM9q4aFpOVcfF7ssu/0?=
 =?us-ascii?Q?I/CmEHp17kT4iKDHxZPJSb5xNb/Pp1/mJ+bjKLeG1Coj8fnQPOVNXZlnawWx?=
 =?us-ascii?Q?GECC7+tHG7BccQJre2CGGr0NwPQNFrG8m6optBZWgbAZ8cgMbN0V7OHwTgKM?=
 =?us-ascii?Q?1hhY3ZvaR2oQ3Fuwnx4NSs5PxuHAqc2jDhy7XIKuoSPe1J9a47flvgkI9x9x?=
 =?us-ascii?Q?EgKChr5ucVl6s71+n9Z/NvEAunXRHxqjgYo2w7ktGNo+dtpsjj9ygvyzqAyK?=
 =?us-ascii?Q?JUeP/9hoNb9ObU4MQilLSA8nnlzx2INJE9XOn6FfvSFTOTVCm7WxvMgXHVwV?=
 =?us-ascii?Q?CS4UuPmggwijVstUrodggpwDhEKyTaWG0Xkzbm7kbY0K/IhsY3Y+USbwk5So?=
 =?us-ascii?Q?R7T5A8N3Y/STLjigcbty8vPrG8YCbfx0eaoloouvLatgVj8Fh5D4C0XP6GdT?=
 =?us-ascii?Q?NZcVp7FGdpc7NAK30bCmH0/VZIojK10XXsj4ZR/D6bm/juxo4s2kMlx4A4QJ?=
 =?us-ascii?Q?zexpfhttWCr3p2Z/PpxS13Lp?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR83MB0380.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 415c00b9-d137-4256-b5b8-08d95e40c94d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2021 09:57:39.6037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMrdQtbIxyNx1+QP5vIXVEat6eL6qZIMCMcn/MqmfrjOwV0URB0fpjEfJeavwOAJv/ZlFE8rWMj7/Rav1wllWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR8303MB0092
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello

I have a requirement to catch a specific signal hitting a specific process =
and to send it a SIGSTOP before that signal arrives.  This is so that the p=
rocess can then be attached with ptrace(), but without the necessity of ptr=
ace()ing the process continuously beforehand (due to performance and stabil=
ity reasons).  I thought this might be possible with an eBPF program attach=
ed to a tracepoint.

I attached a program to the signal/signal_deliver tracepoint and used bpf_s=
end_signal() to send the SIGSTOP but it didn't stop the process.  If I sent=
 SIGTERM or SIGHUP instead it worked as expected, just not SIGSTOP or SIGTS=
TP.

Sending a SIGSTOP prior to another signal (eg SIGSEGV) works from userland =
- the process stops and the other signal is queued.

I'm guessing that the reason is that bpf_send_signal() adds the (non-state =
transitioning) signal to the process signal queue, ignoring SIGSTOP, SIGTST=
P, SIGKILL, SIGCONT, but doesn't change the state of processes.  Can anyone=
 confirm if that is correct or if there's another possible reason that bpf_=
send_signal seems to fail to send a SIGSTOP?  If so, is this documented any=
where?  Is there another way to do this with eBPF?

Many thanks

Kev

--
Kevin Sheldrake
Microsoft Threat Intelligence Centre

