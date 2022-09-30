Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D821E5F1540
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 23:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbiI3VyW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 17:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiI3VyV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 17:54:21 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A826B1263C
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 14:54:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFuogbvEJ03Wr0SiTQh+X7d4L1IQaTahvqTXgZagmlYfSMX5wtpeFkwkAg3lumSfaM1clmwNtYR97UjWTU9ZrbStETMsNSeKLzq6ti8Am6GqrpkeKVV3e19Q+4QhrCxOl8K5tKYL3ZXi2IOiuMdRJI4US/oG20a1FblEYEfQkjeAwyta9X2owOTkAJ0XPikeIGeK75zD/L48skuRhiT7UaoX+H7X8w2d0Tem3+sL/vCzO7v23Vfv6B/3Hoao/Sz4EqN3cJDbrf8YS6jjcmQMxTlaExSUD0pL54YrIdx6LYeY5xPoENNGYS2xu8hoF7stIBJFgRH3lTNIYzOOBwA3KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bkd+ytYpxsJdGm+PUavbPuNUyusmQIHrT9wthNHDrIQ=;
 b=mt0gO/g6ZVUW5X0l1FB/D5/hEWlTUH8ueSyQssuH3N5PHKJnij2dc1uD0sZEUxcZYQwG/oyUX3QOu8IpI6RRZwsjQv64INLV7oQhg8UFM4tKCHdjcAP65O6fhS8MY/QEZMKdlP2MxgP3Q3GjUdUImmhn4HXVRPzUuXdTvCM2I5CG0OPK9+/gt8qEHXtb7Q081HaonBhiVJHIW2avvlKwtxnYQdxyDqkTSzZhKC7Jl+/GwJNQF1z8dPj0ZE7zjFFffOR5lbSDXbkvHaLWtcs2MFnEr0vCP4r7uzqlfqrBA5KWDGgW2xCTUyd3FvOSB7P2GpkRnsmyI7aD68iLIX/Vww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bkd+ytYpxsJdGm+PUavbPuNUyusmQIHrT9wthNHDrIQ=;
 b=KObzOrLp7PIhlQd3AIO+Y40sQvKvYygsrkL30oNcwKmdttDMcP+/IPiwtNnR6mzT/vhzC/1IF6yZdDEnwNacplC/vX46gkDM9UCTcwCntjOkz4693J6lY2J8Tqqil7Hdw8gffXmY1BEE1MuR5E0V83Kc41DSdHJKW+J/XFddB9c=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 MN0PR21MB3604.namprd21.prod.outlook.com (2603:10b6:208:3d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.3; Fri, 30 Sep
 2022 21:54:17 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5709.001; Fri, 30 Sep 2022
 21:54:17 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Topic: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Index: AQHY0qNnkHKOYI8p1UG845fwAHqmHq34d7+AgAAQ4JA=
Date:   Fri, 30 Sep 2022 21:54:17 +0000
Message-ID: <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5eacc704-a8b5-4f59-8ef6-a997e9b24ea8;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T21:52:35Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|MN0PR21MB3604:EE_
x-ms-office365-filtering-correlation-id: aab12229-0bac-4f11-cdb4-08daa32e528a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xa5zoT3F60IJenkV3Pm5RA7LccIi3OMEoFj6BSIguxAM/xoO9sfTvg/IZ7C10B1rJLtDMj8SHcbrODADk3fgdivyCilMNIpnNgdVq/74BZvsELQWJw7j8qe/rAsw4MI4EfmPUmLDn6UjA5Gdmeqaep47SgORt0z/oIcyGfk5InDOqUNm4qZRulqhWzNV4RhK333YpVQDm9Lpq1TUj1SMs3EqwCRSIg2dcHMjvyHkuStcM9eMF5K42+d1rp8HkEGfwRlHNjekemib8RipEZ1QOhWjs6msHjLY9aeWTLNQh8udUsWZ2MvQBlLhpTrV0/dqNPZW3l2o9ihWX4iZPag4ajgCy+bhWztrpqosIV0Q98ZAGRRYq9cQEVmVSLd9clmU/I3Lbliz3FBHeOJg9LRwgFg509d7ojmwr6qBlzachAosHphONZIxedfmIoTK8+1o8WsUH43cyA+7imv253uqOgkAA9O2TSAmHgkVxxq+dfZ1kawJ0vWvD3jKC+pat8hL162WDvrVWNQzVeCWEAFtY3Zshw39G6ktRV+4SR07LU9a5nZ58hvELMyPzCgI8Yd6eE9+AmjN0y5kLrMrpJZoAzSzqyXffEYnHvidnVxg1UgdbY9YxigXViKN59jGVJsarQG43X6OrM5v+BbFjM9qBD0ba8jieq86lM+brZxSkn97g712YNROxSU+yL5dE9y/9sFX22r1gaXunYRdp0hUJrBvb450W9sRje26aclKv4ktdi8mqucs2/cvUqF/45q4eekOmAjgqpr6janeX+h3cpE1r4gSHZ+oQh5XLeXTEVudPJMgAe3xHqpcD1ntvChI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199015)(66446008)(186003)(82950400001)(82960400001)(38100700002)(122000001)(38070700005)(9686003)(4744005)(5660300002)(2906002)(52536014)(41300700001)(8936002)(6506007)(55016003)(8990500004)(478600001)(71200400001)(7696005)(26005)(66946007)(76116006)(4326008)(8676002)(64756008)(66476007)(10290500003)(316002)(110136005)(33656002)(66556008)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u3QmzzjW+5aJsyKM+obHrPEwgjBoYKTJ/XKdEltbfYu2CCZCbM0NVIj4M+bw?=
 =?us-ascii?Q?nWUJOOpGkMUJTRwkesgyAtjEBXTUpBTJfAYgRgWSuq3avKdjsgncAvHGVTeo?=
 =?us-ascii?Q?1NDlbcJ03DzQ9RduWBycmPxMffuXspzs+kqlIsKNNe9nB3HuGomuZf4IJ3OL?=
 =?us-ascii?Q?8hyJhlqEP57+t1ABcw6UXX/0KUPnu37JJOqCW7UIlMgkD1Hnv91gYtovUX8+?=
 =?us-ascii?Q?NRNRD2104zcPcAPYByhYpAGx9pPLAg+LI3bQ+/eXLlcGlMoKIIRiCAyXnzX0?=
 =?us-ascii?Q?jvFslbh8iz0jz2UvqZD08Prg3JvOSt1WXuLbsIagbMy694pzYpHmeVauWXf+?=
 =?us-ascii?Q?ljDrbt+s1mNS+RyJq9Qryy0mEXE7mIJw8xcTwqKhzpr0PHgRUcGEywGS+inA?=
 =?us-ascii?Q?VpraMieaWMlBDGR9avoSXoCN8tsvTj+VbwNcps0PPCHE9mu3tWvaWqtUdLrh?=
 =?us-ascii?Q?+yfu2z4tDa9zEdk5qlR2q5TUvrjUE89gQWVChU+FdqZck+9pLCVAP/Uwd1VG?=
 =?us-ascii?Q?UP5v7lGENyVQzxB7bTPg6GC4Ohu2WrLqUqq20FgyVK7djviEBKlYHeY9O+Fq?=
 =?us-ascii?Q?j1z7UqmCyYXCoVY9vwCmdliJLsz8SuSLQLFqMfpql8hBlC10YdJB8UOTHOBH?=
 =?us-ascii?Q?tI4+1RwASaUVxSz5t1qCeuzUlSYoHQfRdsZc3qd1XuY0GALD55vlbDJcvVli?=
 =?us-ascii?Q?NphZjyJMnI5gbQH8cvQuzR+b+EfXjETcHjk1mmczR4K6oZAiMHtvkQI1GkeD?=
 =?us-ascii?Q?snchEUU4nFC8WgW7KGMHZpp7eRhTZlvxYoXvSj6XPQGZXA0v3AWrRdS8PaP7?=
 =?us-ascii?Q?2gIyF/dlIDKSqxu4FhjFBW99W9ft5ZYEnAqq/niWLCh7LMveAwviNJBsS/oV?=
 =?us-ascii?Q?7X33bo0fqLg/2t9S4fpoxFyNcnC6/M6eaewZq1vPoSd/bu0R7isPQAvY6mPz?=
 =?us-ascii?Q?/XC7RLaEkJbMukGxxpvSBjmVkZv4S8Pllu7XETM3GndKiIMj4KeghTIgt9JD?=
 =?us-ascii?Q?g9u9AWyvC4RTIzte4JGVxOPvtvIClaW6OliAHtmFt83tdRC7w8XWZR8AD/fX?=
 =?us-ascii?Q?y9HwRF5nL63g8RL4+6xMf8JTfyRIZiqZ/ZVj7ovS55xP0x0Froa+dGFwJ2Fd?=
 =?us-ascii?Q?M5Xoi4jvEBxSCMjEN7ByqBeLT1O/PdM0/3KktNhHc3udMCtmGAz5Q2XET0Vb?=
 =?us-ascii?Q?2FGVjB8FPkWYoE/a9OGP5EDYMTdsukTStTYntMwXTvGj/JQJi7NIMrIlH6+r?=
 =?us-ascii?Q?HQf7i5LAh6466oGZaCLzvwK3jakZ0UwnicxWRJop2ZpKy84NY3dhVT3SnZNE?=
 =?us-ascii?Q?R0RW4/4cQ2F1M6iA/gttgzW6fazrFCy+Azur/RCNa6b58dS8q0tOkC7HvVxd?=
 =?us-ascii?Q?24uC7dBDeUgHWvG8/Ck99snPWiICA+PnBy7261lyuObe5pimoKzT3Tngu/o/?=
 =?us-ascii?Q?hbR9DqD5S+JmpaecbUea5A091Pg0NRvBFEqf3gTgLuxPzCuYyCh+opODS9Gr?=
 =?us-ascii?Q?bPRZqxeZsRvnJtBXvifvOV+VscuKKg4Hlg4DajevOMYMLexxZ/knsSNwKOt6?=
 =?us-ascii?Q?tLGg5ZVFQtuDkYS6xxLd4FTa/tM0zRtHNmK9MOn/ufOPv4xaq9e0Yt1ssc/U?=
 =?us-ascii?Q?mg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aab12229-0bac-4f11-cdb4-08daa32e528a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 21:54:17.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlzbQFvdJrsbDqRVBdkR871Ehs+D7jFIgfMZ4VmP6plgZGu3SVeD/8Iz2ONI7sQtCUWZAiQJ8j18U2e6qbRuve/Gu/kDpRWVVaOYBB+eBFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3604
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]
> > +Also note that the modulo operation often varies by language when the
> > +dividend or divisor are negative, where Python, Ruby, etc.
> > +differ from C, Go, Java, etc. This specification requires that modulo
> > +use truncated division (where -13 % 3 =3D=3D -1) as implemented in C, =
Go,
> > +etc.:
> > +
> > +   a % n =3D a - n * trunc(a / n)
> > +
>=20
> Interesting bit of info, but I'm not sure how it relates to the ISA doc.

It's because there's multiple definitions of modulo out there as the paragr=
aph notes,
which differ in what they do with negative numbers.
The ISA defines the modulo operation as being the specific version above.
If you tried to implement the ISA in say Python and didn't know that,
you'd have a non-compliant implementation.

Dave
