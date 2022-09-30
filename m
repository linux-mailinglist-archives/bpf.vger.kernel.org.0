Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310F55F1646
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231963AbiI3WnU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiI3WnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:43:16 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2100.outbound.protection.outlook.com [40.107.237.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14D92CE2C
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2Vy1ehhku8LMyC+mw+/ZCt2b9e8Rc1ZGAhdm7dcZzA94RE2KKjYhpaXXxJgA5AfOpjupAzOeVaxIXWbvdoWbsF/YkvT+KVvwdEtGOfcnRSk/l5qRMwECiJSiaLMIB81z8BEuIJNZirUsjcl/S7LQVuVxEdCe4m21AD835ynw7MCrkmgSx97Z1a6rXjURhpD7G6oHWfafib57XFNbdig2USgQ4gqRiQIGOUJXnB1tiX24rq6seb9xCXyKtsUgSlfCz5vIQNRGUxP8080RuteBJJHTfBj3zBO+C/IO9N9Dcfq/lbqJ7oBEwaEoTB3Xx+6il4ZeUHfK/BH9eNIM/yhXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwe08G4aNiijkRa7Ek8pH33efZQauqWHBcpwlyOwXcE=;
 b=i/6E4/jJ5pTYvM3F2IE61cEut6vzYEvhK2Qg8LnGfiuI0pG5IxJNo8ORcWPc5zzSVR5tVcnRArk7clGHqUbpJw2Tg5ZdYI/GDO79dVZLTjHzUSYOA3jntoxDuGXQO4njTKj11GsTpxL3uI6VfNlgWPOS5qhMBmrKP5pqSYeIh7MaVKXA5QIBabLCjWD/gN9OiowhVzBglhZ4KzleVXsCW40MPSseTqCqZPfpOvWhk8VNkbTPLEB1Lo5iOplcF3Pyz2ku49ptesAgO73Aly/kLY0a/eMUVOgrB5mcmSHe3tMDr6AxDSSx7uXdcqQz0cFMZFy+02o2ds2GNqQU2lwUKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwe08G4aNiijkRa7Ek8pH33efZQauqWHBcpwlyOwXcE=;
 b=auBWnR/9wXho1xdNyObpD0ru+6iPdzKfZgKLArYyvCUjBdlke+CngNs4T6TElUQZXUnH032zULjsN0cHRl5qM20FRGpq2tswHnVCSxNYVkFA/XBemHI6xTg7NDzr5zJ03T1W4SiURof0/KR5IFm2B70ru4y0jDIlGQT5hbG6lQ8=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 SJ1PR21MB3673.namprd21.prod.outlook.com (2603:10b6:a03:453::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.0; Fri, 30 Sep
 2022 22:43:11 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5709.001; Fri, 30 Sep 2022
 22:43:10 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 10/15] ebpf-docs: Add appendix of all opcodes in order
Thread-Topic: [PATCH 10/15] ebpf-docs: Add appendix of all opcodes in order
Thread-Index: AQHY0qNpvsu9ptXWoUKj95lHu67/9K34i1yAgAALACA=
Date:   Fri, 30 Sep 2022 22:43:10 +0000
Message-ID: <DM4PR21MB3440D8A01BEF100600C18CF3A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-10-dthaler1968@googlemail.com>
 <20220930220223.avtsehbwmgsbkzcz@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930220223.avtsehbwmgsbkzcz@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4b7f9b14-3e4e-475e-a7fa-55747c65b3b7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T22:41:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|SJ1PR21MB3673:EE_
x-ms-office365-filtering-correlation-id: e6912701-7f52-4572-684c-08daa33526ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFNhczQ7NcAa2F3mwb3KieMXxHvUq1HAisBDZE6JNnzmOBul5Y6kDndIPTogd2R4FOgtTWR6Kj0+MkToFCWlYGwEq2Yl50VEd6c5ihpch1oAmLvPyiUOyCDRNdCuPIFg61dy6THN288nDXK/oOir8kvfki690NCTr9crOU8F2UpbL1qqboApYT+pmGQcBpQqy5st9G1GAz4Zjggo4xBr07LVj/6GRpsPY2qGNIUTA0UGl6TnbZXihsK86Tn8lKB/uduFqN08CkYq5LeSDaA3dyUEgj9RAw15HobzuYuFf6TVm6wK8Zf5X0eONHksUQqYXdK5SCjMV0wHbgqJRdhEoZUNCF+4PaY33RZsQQtN6dqU/znNPIUKsVXzITEjYbv+btUO0qvuaXLbQ6hLkTG4M0zVCdCO4OUjDMcTkv+CghML7UIxOTAYPH8L2goGZDoRtWNWw8KQ1Qv6Qe+KIOEvDVos4nUo8mQQirmkuTic0IGaU2r6aLDzRJ7jfSzcvOG2eNL6+FGGdWYeVnBRxyuoxH7/163L+0o7H5K3K29MYK2IPYoIONH+Hg+YvbmLN5mfyO0P/GhBLtkzq/0bVzRGuHq9P0AL5niB7Y/ygS4dsW9Jeg6C82lL3rcz1glyktGj/z744x8Os45qNc3C2ad0vS2R9poXEkDoCTbhVdmciG8arfVMzxEmcwtvpVL4L12Id0QCIJeOlDOqnYEy4x3snCAazHJEwJ0/ALf8eCalaT6reoHBaFjWUMAsDl77xyTwDk4G58yjQfM+WpnpQtVidrn+uSprscGLSdHMW6+52USBAzlHqJNA6HezEC59SMxi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(346002)(366004)(136003)(376002)(451199015)(66556008)(86362001)(10290500003)(71200400001)(6916009)(66946007)(66476007)(478600001)(55016003)(4326008)(64756008)(66446008)(316002)(8676002)(76116006)(8936002)(38070700005)(7696005)(8990500004)(52536014)(186003)(5660300002)(6506007)(41300700001)(66899015)(4744005)(2906002)(9686003)(38100700002)(82950400001)(82960400001)(26005)(33656002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6BXnKUJyhDatJZaiiSmk24yOKKwKi96uQWxciVcu1G0lH8KeK3MEhKp26FQN?=
 =?us-ascii?Q?wVaOErYNuVoyIKBxVwRX6J9PtkE3ZZv2SYGwCSP/9G7/ZCReiHtTGYxMP9dM?=
 =?us-ascii?Q?HMBHqJvGHMZ0iM5e7/iW99T6J3RDa2lX19lnS3glfL//zpa9w6qPmC9B8zX3?=
 =?us-ascii?Q?vivW9NJRqv9b3MsNUDnfoqvkTydDwAw2Q8Ykwb37IU1cagXDRXCxrUUvnX2x?=
 =?us-ascii?Q?qcyO/TGMSOo/UEcW6YzVyynK+1ClOi/zW2LDZbUoJxnZncJNPb01oSRRFmX4?=
 =?us-ascii?Q?HD7ERLNfbjIQnm7h+0p/cv8fLZ1WnUmNbETObDMQIibRpp9VSAzyuVnR4Gq4?=
 =?us-ascii?Q?JJuFoqQbtDj6vzb9xV+tQKwx9vMjLVA5hIesPj/vTAF/MvW6RNG/9dPb6WUZ?=
 =?us-ascii?Q?s4qvMMZe94PSiUAZDt2qOH8IGkt90k6XpKhIdQorhdbrYpbFH6FBm7w21CRe?=
 =?us-ascii?Q?VEHeDAeP2lUKmfgCi/gReitmJHQm023tTnd+5UHAYbjYc+KHsx5LmthMORtX?=
 =?us-ascii?Q?MXTWSE/Cz7IhDiaCOYnZnNvnpYOFGURSgCn2J9ateS0VqFQsPw9MNlOe/bdR?=
 =?us-ascii?Q?VZMhGeo+Ea1mYjR6OSH32eBPBmYvuX0ijBVpThu5iJr5K1XyKkNnu2lIw50+?=
 =?us-ascii?Q?MBduBg20DAbZXTWUjQp+iPCWyyCfgMm8zzARHKyc3WZR0NKEh3Ju6YPwn5bh?=
 =?us-ascii?Q?oMKVny5bvgOWy3MZONiePuAz2IRL9gx4nZTG0BagCRZEHZpt+/HrF4ucMdaF?=
 =?us-ascii?Q?4TV4YRJA48Mi6wBGgUhzLll6i8pwURV2bfun+nZaqYP6x19VB3lZmmULmmUv?=
 =?us-ascii?Q?wsQT+toKWL1bsV0GMUEQTy5F7NFT6qMew3EQ/rQGklfWNwPvtXzBGUGdmwTJ?=
 =?us-ascii?Q?vzdbBu6uzq8zdm97XPzYCa70RJ08pSYgQwGYTwKp4dxr/7cx9UFtGQSycSum?=
 =?us-ascii?Q?dABjIz0kby5VVB0J4V97RrfryH8U86FIGpZkngdehpuv9eayesv+KNgWEPx9?=
 =?us-ascii?Q?X4wrpubeu6HUqTGsiB6UK/ejhMvwFF658JZKaTF662h2AZpq+D9Wv0+3AVwF?=
 =?us-ascii?Q?oUArcNt03gei3lEy+IHSrC8TALukA6ibyWTc2nmR0bt+x1eg516GRswj+Vwc?=
 =?us-ascii?Q?79sHRlCXdNfmP+e9sUj+2wJa6AL8jHVgWrRxdeAyLi5Pv2HbUhNnUqdimr1z?=
 =?us-ascii?Q?KoluV3zeH9niuXfExwbtQiwgfCpwSqaRqAKRDCIE0uq/1gLyO/3l/mN9uDTK?=
 =?us-ascii?Q?cwwupX7rPdy66SzeHWG+Hu7QS1qDBeYANjc8oMlfn8CI9jXSj0gtGAhZUfYc?=
 =?us-ascii?Q?s0TAuIHry1K7Ba/Ig4iVLhyXarAiSO+37ddAjDal7bkXbmW53z3+aa+xttgN?=
 =?us-ascii?Q?zV+SPzPbdRm53GQzDLn4aL5LFckWfTdBP7LHVCzApesKgsWsNZQkPhU5XdFZ?=
 =?us-ascii?Q?IqPzAvPvuXHP1YOIBsCa+ISZDIV/0x359Z7RCxFw4GR5MBkaNPHF4W2Ci6BA?=
 =?us-ascii?Q?zDdXWGfUsC8aV8fOEJwdPvFcUagShP9VNPiK/ZlnT9VWIvPA+JOSSpVbwfrj?=
 =?us-ascii?Q?a1vVYsLClwtfP1mZTV4Ze7XTn4Ib9oF0g5niFTnKNtzZzKLRHqbfrH3jmpFD?=
 =?us-ascii?Q?Xw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6912701-7f52-4572-684c-08daa33526ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 22:43:10.7564
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTkMqdRVnFI3iHU7ZEL6kPQWR962ln78G1QbDrKAhPsMI3VKNVnixT0PkhaV/++FMv7vTd82wxIBVhbw13hY+qOfPz7auI7caUTASph1GLA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3673
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
[...]=20
> I guess it's useful, but how did you generate this table?
> Looks very error prone if all hex numbers were done by human.

Yes it was human generated and checked by other reviewers such as Quentin.
I wish there was an automated way.  If someone else can come up with
an automated process, I welcome the patch contribution :)

Dave
