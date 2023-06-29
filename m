Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24151742798
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjF2Nmj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jun 2023 09:42:39 -0400
Received: from mail-dm6nam11on2132.outbound.protection.outlook.com ([40.107.223.132]:52384
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232037AbjF2Nmh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jun 2023 09:42:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPJ1USPT+fIZJb4/kumkTM5WjsKNd8BbsC47xPNBVQmoM1irc+Aln9lqN2F5A4cKv5+FJfkfcKGMnt3LBR3SEmhpxFfZmKeUD4H1xzOQtIU6FaDIz+CpmBdj5uQ+kRRHL/awRz/9yxhXZiPdH9b//QkI65JJjvcZDsBOJMtgWFsTllqle+WSieS6DVCeF4Zxv2K0wX7rhxf9ySZ1d8RzhYXJj0EkqgTiO/DB5bEGi7z7HcJxjotxFqWI9ZLGcP6wnHlNlsL2F3rCXg4E67lEyiOi3ziez/4m0HacUDvTEIV86Xi9CrKK9u7klJnEVpuai/csgmLgIbJpo5yVU47igw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKIbcx37EKx98KkbYLFyHIWfgCl8E4XG71yxBwrPzJs=;
 b=mM7BWG57VJTI5mV1vHoErCPUtmUkz+D2vrXiSTL8PIZCPG2nZ3VvmjtlVpQ2vGY3j49HfStIwurTCh8CIkaKnDzT7MRK+Efh2Cp7FSJBqez1va81hgV+pSjmfpSE9k+afrhWgb27wFo7ef7Egsy9JwUmoU3/wP9/QQ4AGSgRV2q+vz3QQvwGEt1beXvmzPvGNeL3vI6SoCqkWFDDhwq1vIi2rY6/unsSn0cZ7BLc3pIaF7VF6N2lsDTgYiTWLKcP4pd4GThALBleUS9kw8t/vMeVNdtjzmg4PmLZb9JOMQpqtZij3tk9KiUfjcQF5MZEJKEKkJVODFE8v4ac2wAKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKIbcx37EKx98KkbYLFyHIWfgCl8E4XG71yxBwrPzJs=;
 b=Ex3owltmoYHJeSebVRO+6nPwTSPd0JMWsB9JYuPU3n0o8Xcxx5wc8RbWbLQocBjxQrIA2WiGWxqGLUDRmK/Km8Ibjo23OUErVp7BTesKvWtnlEOMQOYFImkNyamG5JNUtIJL8EToCw33d8YF9fpG3CY38pgdk0ff2VQKr/WHRqo=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by BY5PR21MB1473.namprd21.prod.outlook.com (2603:10b6:a03:239::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.8; Thu, 29 Jun
 2023 13:42:35 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::8708:6828:fb9f:7bd5%4]) with mapi id 15.20.6544.010; Thu, 29 Jun 2023
 13:42:35 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Yonghong Song <yhs@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
Thread-Topic: [RFC PATCH bpf-next 00/13] bpf: Support new insns from cpu v4
Thread-Index: AQHZqlQzqBvLT71SNkSEKbXTQ3XlmK+hyjqA
Date:   Thu, 29 Jun 2023 13:42:34 +0000
Message-ID: <PH7PR21MB38786422B9929D253E279810A325A@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230629063715.1646832-1-yhs@fb.com>
In-Reply-To: <20230629063715.1646832-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=98e71f03-60fc-489d-9cdf-1590a7418074;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-29T13:41:44Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|BY5PR21MB1473:EE_
x-ms-office365-filtering-correlation-id: 40c6248e-f42a-4fc8-730b-08db78a6b1f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DbD5I4lsFS2Q9nMmox6VTzw4Fa2QnePPYhu7BfI5LIsqvq3Sgfp+uC6CXPG9fFOaUu3uAVWPHzJHScO21OJCuGD7NtWjq33xlX+9FEakB9fAdTXBtB68otQDbfcIcJd8+VNUiUrvllo2jOcONsLq+4zWuoIRGgd1CTLyEvxbGqUOnnoA4J2j2+dowtygQJsheLdVvoRQG+FoeJPlvmDQkaGU+JARQvPtljb04qoRdYS99HezJ16QUdNxeoSA+KPm+PFFh56SFvvVX+/otrmpAL+zxfQPaQSL6W6Efjcp20KtyFTnwDFc2PWPO2Ox6XkfpWSDsWB6BZ9H03FDqlKIJLoXWl3ybxFGjMKTWjUgzs9BwpF9o7WQOs8e6s+IqZc+bUnBNJQAszhwDYvw7jQAsNN2ySg01bbmFqwhBlzWoGSSQDSAKGkJhcFm4hi9UIPm/MSz9aY9Y8hBPMVs95PCcUsuwj324UDOW1j68FxzoEAVU4s9NCJ6J2+GyVehbSLZnqQB94lAazRT+eHHGi0X6hXs9h7xnekxuPl7OjhMn+ioHw71I0c/Si5GwHE8mdh3hMT9kzclbnV+hd+BvLxqGad/wTBAdNTOEPy9d8HWkDHVrT3ce8Bo81vPNhLcmVeCZLNR6jkw7pIMRQ7NuMoDCcr6v3GjsCGNFPmP21zj8S4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199021)(7696005)(71200400001)(10290500003)(478600001)(110136005)(76116006)(54906003)(86362001)(38070700005)(33656002)(55016003)(4744005)(2906002)(66946007)(186003)(9686003)(6506007)(26005)(8990500004)(82950400001)(38100700002)(122000001)(82960400001)(66476007)(64756008)(41300700001)(316002)(66556008)(4326008)(8936002)(8676002)(66446008)(5660300002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TNxtmOXlqizaaBARqF1ssIDeWyHKhiYt52WRasz1Vim+YxDDkwktY3vgt9CM?=
 =?us-ascii?Q?SB3Ox1aZsaZYXSV6gncqcn6p04uON3dvgDDHx0URp4EYCrgjUOaQmTMH+1z3?=
 =?us-ascii?Q?jofpt+ivezCHsc6Mrtd1K5TL3VsylEEf74EX0yjX2q1x5sFzgMx0s+jdx2nb?=
 =?us-ascii?Q?DVBT+FiibTPUVR6QF2iSrtlMRzKZo5RApQmV2UNVQLnRqTaOZzdkM32H7phM?=
 =?us-ascii?Q?l+ZBd+BKLQvHUiUQK0GhvSQQjyJ0ezm8+UiW6m1FH407USzxdiF6Vl0UerCQ?=
 =?us-ascii?Q?hgegCrJkJWQ5ixM/IqFegk+GaDfdsxU/5MCGP5N88ysHPRln2Br+actHxvQL?=
 =?us-ascii?Q?+VZ06DMyPN8Np6tIuN7gapkZiS3bFmKn8M34evVreNsQBVzgSdR/PTY9jXLM?=
 =?us-ascii?Q?C1Ayt9RXcX2sTYPQJFpOIth/ltDQmnDlafXvcLJ07p9+FYUWlfYlAqjkvnl1?=
 =?us-ascii?Q?WO+fYnCDj9Z4n3Lh2HUTfqahsE0YKnjlQCrGcz2CFh/siBMX2m6r56VIL47r?=
 =?us-ascii?Q?oXkMNHtDsgJgKmV6pIfIT8vYdhekFFx6bDTqosih8cLYmDDdrPBHQaraibBR?=
 =?us-ascii?Q?wWL9KmydfMHtRJAtU6o/cF6IDjQy2WdwVXnwo4fFtUPfpc2+gp3ZW4BBUUMB?=
 =?us-ascii?Q?KqFAyKUhyJn7aSt2nRCorFridcKHtR9yUxotIYU0s7kX2q4lW7RBG6KTJw8n?=
 =?us-ascii?Q?s96Dd088QdmzkPv5OBDlUiwiGEUzGdGA0ffA9vLOxD1kGDlIzsPDzOPS6jrV?=
 =?us-ascii?Q?unTwPzSppeO3aG497teYb93ey//h3xTXoluTsKMKI1i7/27hZv/GMqKGR8Iq?=
 =?us-ascii?Q?7oQj+wWH/uaIAVWAii0rszA5RXNL7Cjvm03SeLreLVCaXBjLTKQbiG7tosnp?=
 =?us-ascii?Q?4hu9IWOIYJxM5TYGYwJAtaVlK/ov63gfusdwmTyCd4CBeQTRpUeGnlgAsq8l?=
 =?us-ascii?Q?V2MAC2LZwD5r4H7z70BQS5bF/3hN92GxBO4IAKporWXoGkMQEgycnL4jCTSW?=
 =?us-ascii?Q?qw4QN1ZXT1Luk2wHhSrpFuj2qw0AyTUURa5RZbQLracJxD1mk0SyxmvMWubI?=
 =?us-ascii?Q?z99YjKJjnzQExW7+Dzos7PjcpHHBX1Fz6E+0L7QT/k4AJ560Ufv/cbfNeej+?=
 =?us-ascii?Q?ePheMH9uhKnrYmakZ0Vx7WkbAup5QYhPfhtEf5FLkCAtXLpzP2EuoT1noMum?=
 =?us-ascii?Q?3cO8n+vNVLgqAfK24iU1CuYCPZqeaKmWsSQ/deQOjovTkMN+NJMo8AkRzVTL?=
 =?us-ascii?Q?X8Zaqdi0Jy9YwX4Kv46vztDd/3hN6lMq4KRlHjwi8moWn1S5Mfs49F250YWz?=
 =?us-ascii?Q?n35+27bu3Ln+RcgzZqBJnB2zANU01zl3G8xhfN0Yv4ay/HtzJ9WTNWWDZXB1?=
 =?us-ascii?Q?tkp4gBsBQ6e1zUM7QPXj6YhEd/5UIrw6ivBa/QkfXkDiN2WSYRp//qQAEdAJ?=
 =?us-ascii?Q?Un9lQhDzuKam/LVADpqcqCbWG6TfDFG5bHInHen+4u4CQ16R1JYe4EsrzrVW?=
 =?us-ascii?Q?wMxB3a0RCRXh0IZd/dqRIN6GIbCf/uTZEkip0iJXLmzAWuUpusUz1ZRalAKj?=
 =?us-ascii?Q?kqx11v8BK3K4YWHJEnPfvT3RDjvf4t9ED0JFOqWNJgL2F0PNruh7KxaqgbTT?=
 =?us-ascii?Q?Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40c6248e-f42a-4fc8-730b-08db78a6b1f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 13:42:34.8394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rs55zf7i7Z23DcIyUfW2AnzUJE4PMLfjjT5uHJE8MIUtQVqAgwi6XU/mls9L4ExbNU5puKuv1DhSICvuB13GZkwPhh4QZrphtTve76xVk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR21MB1473
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yonghong Song <yhs@fb.com> wrote:=20
> In previous discussion ([1]), it is agreed that we should introduce cpu v=
ersion
> 4 (llvm flag -mcpu=3Dv4) which contains some instructions which can simpl=
ify
> code, make code easier to understand, fix the existing problem, or simply=
 for
> feature completeness. More specifically, the following new insns are
> proposed:
[...]

What about also updating instruction-set.rst?

Dave
=20

