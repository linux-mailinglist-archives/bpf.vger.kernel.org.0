Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C073A6E6120
	for <lists+bpf@lfdr.de>; Tue, 18 Apr 2023 14:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDRMW0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Apr 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjDRMWZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Apr 2023 08:22:25 -0400
Received: from DM5PR00CU002.outbound.protection.outlook.com (mail-centralusazon11021015.outbound.protection.outlook.com [52.101.62.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84C2D46;
        Tue, 18 Apr 2023 05:22:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lF1H1GIn9O0lr6DIkmyBvUfVu7Ydy7JgRTHVyTiKMRTa/4qj43jAUL31doPEdT3tTznKvBQewsCRohwC2YsET+R89+kKx6w0EGxU8qIfE17e+qrOCJ52DcGQnURR7eXKDdjQx/DCEPh/O59KSe3VAXe5W53Wi99aIGckQ9Nojkw+pds5D8U8e72tR4Rs+Zh6tZKj46NM+g8GaebWl/w6RGr0xYCLR0h5gH5WThyZWE5us7SU+PfE3vfdH3s8Nnzn1AsF3WxMUx8uTili/sQE/PX/XT4mhIG1/4irI0Dhrdgb4VZcqK8RmiAeTLHBZZz2gIh8P/sryLEjV9zLfsnuxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORsXe0KrxzFurR5wApMaYmhUcgQtqjyVWNG0VofWa8E=;
 b=cA+pc/s1wZSufSMTxVO+2gEHkLxWAv1UjA7u8EyrwrEvyCRas25Bx0837nJ+r6JNYr45TN40AvB3puaZmh6A8IxatIE4AHZBlxrCB10K3O/EFA2Ns8W/zbwIYfjqCBmNI2ww9JzIwWe7jLi2hwaoGZWJ52/FOFQDLo7iwzQYJQsOrU0f6ThXYJjxnabJ0v8wOVp+wuvWas0ict4WZhbvZn1Hb9M/VUDw3dBObqMZ5Rifem0XJs+0gEHtzvoURk61s4uNnKCGTbVDwNu6YWbsYHT/uPZq0i6qN4ST34G9k6fOmDPQPptAwLnm4+6vl31CSNEEQwgnv196e2lecA2rLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORsXe0KrxzFurR5wApMaYmhUcgQtqjyVWNG0VofWa8E=;
 b=ckvbzKzf0fW8+rM78iFQelpLpiwnknB0OgENPHnmN+jEZ2GUi3dkHQo2HbM51pC0cjL7o8kKQPjpyWnuT7g+peqcdbIYZ9w+pjNvWKAWd2cVxTIy6/eR4us4gOoK5+6Be5OwT17DfPhjy+20HY67vtAk2kyWw8B1cBYfpo9h7lc=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by CY8PR21MB3840.namprd21.prod.outlook.com (2603:10b6:930:51::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.7; Tue, 18 Apr
 2023 12:22:21 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%3]) with mapi id 15.20.6319.004; Tue, 18 Apr 2023
 12:22:21 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     quentin <quentin@isovalent.com>
CC:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        =?iso-8859-1?Q?Michal_Such=E1nek?= <msuchanek@suse.de>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        =?iso-8859-1?Q?Toke_H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>
Subject: RE: Packaging bpftool and libbpf: GitHub or kernel?
Thread-Topic: Packaging bpftool and libbpf: GitHub or kernel?
Thread-Index: AQHZbemvzLfoFraNtUiZwvvjHtWrnK8p9igAgACbAYCAACyuAIAGRDMQ
Date:   Tue, 18 Apr 2023 12:22:21 +0000
Message-ID: <PH7PR21MB38786076F31A3B19AF5592DAA39D9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
In-Reply-To: <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=93025451-cb57-4a1d-a190-d89726a41e87;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-04-18T12:11:40Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|CY8PR21MB3840:EE_
x-ms-office365-filtering-correlation-id: 4fd822a8-7035-40e6-3d42-08db40078f09
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nJxkj3czSbkpXa0zkmqF/fcOlhx0X9utRr638geo5GeRPqX2DnRJEMGrTn5BR3qMJsSD5N2VwNfTHPb4yR5yFCpD7QUmGQcdymNaHUNtlWdoXnf4qDrfHqKQHfmG47mysI1lgj2/0b+o+YECU5xCCCIniInAeCSlA5V0w+aDiziVl+krIxcpamAuxyy9Q8qc4CdszuNYpiTTO+Ea84nBenXY1mBHYKeBxX2P7kRD80gYHS13LfdtiyGK8fYH5Y6QiczluO6W9+a66B1S8pdmHo6u+jZxZIjE1I872rhXs4wXbrkceckBXJ6XGr+ffTjte40PwgHbW1XbWv5Ups4maldZP+V/220PhGABop11f8IUp2nb5I3R3RhvttXNNZcdAuCpfRbiS1RUPv/K4B9qyBfFpDtztN6odlpb+1f+2gE93BGzG6w4MwP33R0Px/3sdwyZ0zZfDjBZB1k5G0apRoxktdqdzNaT4+DJVciFpAc/XJ06NLlEnzXqkXcKfZJSp4+guRZKr1F2uIQ6URY+o0tW+7A5vSpa2+RZ4+4rlbYiYDFOSfHyUebV7qFpSEpsJO0g1B45+bUwnYOBQn+/gTI6NzpgFExSaeXAmZ7uFZ86ZjXdegAs7Syjrr/EPfIccO2ucyEYtRCmCmut/6mHSSEdImLRH8Pk4YgBWTtEZ4A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(451199021)(55016003)(4326008)(6916009)(786003)(66476007)(66556008)(9686003)(6506007)(66446008)(186003)(64756008)(41300700001)(83380400001)(66946007)(7696005)(71200400001)(10290500003)(316002)(54906003)(478600001)(76116006)(26005)(38070700005)(122000001)(82960400001)(82950400001)(38100700002)(8990500004)(86362001)(33656002)(8676002)(8936002)(2906002)(7416002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Zp0IZogqj/Om4ETKwolBhZv+hqkA1ycOzxuuxv3xLOu+SG2H7Zh2EKIkz4?=
 =?iso-8859-1?Q?lFocf75BboGr4oAmmp5aNzLRKRG4iu2UmEPEDDWgHUUlFEjQUMfetPpjGm?=
 =?iso-8859-1?Q?RlSC0xFE3r6bOF8NLLRQ3biVJNCWT50/XeefvB1Zrf58Aft4DA33jXCJ6i?=
 =?iso-8859-1?Q?VU6/PLlKni0SCnewi5tELzlQu8VzvzVREq/Cr0TA0ONA4Pg8Z5ofwkD3iF?=
 =?iso-8859-1?Q?mLWAFXC0MpuKlhOYoCgI0VZcEWjplhoMBFrZBM4zgEigtR6B01h7ySZGwX?=
 =?iso-8859-1?Q?uSOF0Oy3x5l+rChmvtef8w9ard7MgTxGxtw6yV2AWH/dhLTtP+z4BcmNZi?=
 =?iso-8859-1?Q?gJFdK12YJllTDkATcW6aYtVBiSpjxLu23bOcqzYODb0df6u7yrpFTvis2s?=
 =?iso-8859-1?Q?Hs2TsAWeem2Dq9Pmh6zjnrnFYzCd8k0xXGiLISQvtrXVDLDWNS18GW1Wqo?=
 =?iso-8859-1?Q?8RqaTMyAbVliCMnlMiLeKNyh5AX4MYf9Yib5MEUO0lyWBk3UPa98vxHCzu?=
 =?iso-8859-1?Q?o7KpqWS/2pxLikIAh5LfjlgSjkaKlAYTNMRZTLJPiH1fDH22YOABdap4kn?=
 =?iso-8859-1?Q?dECHi1YcpNHiAy00bNdcYl4J43SezGalR/Py3MCNX7TfUcGKywpoQ68G/H?=
 =?iso-8859-1?Q?1IeovXvUBRiJi0thRTCi8WEEe9ZTaL0ahqtwWa35PrlhAI6f7qrXbuc203?=
 =?iso-8859-1?Q?3w5TrMDRF2FPY/lpKydQsmaf9VU7BTmzuZ1UBoHSEc8rnLIGbNC8gxf/wR?=
 =?iso-8859-1?Q?/d7FPXU/B/egid05joUJRrNLZIBQPcSSezKFPZ7rsS07shr+XZatsNTZiu?=
 =?iso-8859-1?Q?yL8h0c2lQtuNyHEU/wtp8I65v4nlu0bPKDSv9LI4/7XHoJUoPxfzkUQvfD?=
 =?iso-8859-1?Q?iS3oEDVw0cjC2CkYah//dJhj/aJlF15hBkl8tku1LKY4Znme8JD8pE1lAi?=
 =?iso-8859-1?Q?g7yAV5FzeHtk0T7/mikVE1vruB1V2/IaHDxMqVPbKb16MtqOa7MhM/KnqS?=
 =?iso-8859-1?Q?uCjr52sKekf3ERA1N0x6sareH3rfUo9Z4EWDmI8CoXRvINQWtZq149P5HC?=
 =?iso-8859-1?Q?H3RmCD6MV7nn/Utl8aL2QgQ9xHP5pPB6TYKoUF9N4Nt3QYls4BoTIUl8JL?=
 =?iso-8859-1?Q?mHSNy+W3SYnJPKCQqDrt0tJZsZ2icJhvT8dbX2s4MJ11XRyBU3YsvyU01q?=
 =?iso-8859-1?Q?Lz3gu3td+FrqvwjAZgTy6d/R0BMZ+CpoK7PT9yRKEpf+GswkEjDH1Rc2u5?=
 =?iso-8859-1?Q?VHrPljj+Pk0BMt2yudpIJAa1HkuTNoMZD40b4IJOUffhwCB2s2TFosjsQV?=
 =?iso-8859-1?Q?NgaPpFfuLAXv1h1eS+UtKfrPSUrYZDf7aot14C6FvracgXKD0WDaCjJz1l?=
 =?iso-8859-1?Q?38Qy9X29mgY1a72UEqe/YzKyhoxu770x4L4JNHGqFj0VdsyHN7lptAUvZo?=
 =?iso-8859-1?Q?1S3L7Ck6rv96/E+XYLvOFJD37NV+eqxipVDcE4PF/SvpO5rRpJaUY4xgxG?=
 =?iso-8859-1?Q?BwMTseoYhW7sOMGr9LkdU/CtVZ0D4EqNEF6JfsHe5J1xYD0vDpKTPUpyEF?=
 =?iso-8859-1?Q?k6ERV11NDQgGF/pm46MO2Eg0oTt1LFws9ZKxi/zvVCKEGYugI1Wcy5SsHq?=
 =?iso-8859-1?Q?aI06yJDcIZ+UYldMcI1IwXhVCp6Um43T+Wyr/KiryjyeBtvVM2ri0vRQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd822a8-7035-40e6-3d42-08db40078f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2023 12:22:21.1713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sb1R1pDPYgjlrWH/xvCTmalq8gYZUMCRunvn8KkwB0rrqGsMa+dWy0O7y9+/yr2A40qqGztFwq0Za8cneCR1G/RSAfpWubrRo0G2NuZgMDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR21MB3840
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quentin Monnet <quentin@isovalent.com> wrote:
> My point is that I've received little feedback on the mirror
> so far, so it's hard for me to figure out who's using it or whether anyon=
e has
> been reading the changelogs.

FWIW, the ebpf-for-windows project uses both bpftool and libbpf as git subm=
odules.
Both of them are, today, very Linux-centric and not usable directly cross-p=
latform (something I'd like to see change in the future as I've previously =
discussed but not
had enough cycles to drive much).

So today the libbpf mirror is used as a submodule just to get the header fi=
les,
where ebpf-for-windows currently uses its own C implementation of the same
prototypes, to map to Windows ioctls instead of Linux syscalls.

And today bpftool is used via a github fork of the mirror, where various if=
defs
and Windows-specific alternatives are in the fork.  The intent is to clean =
it up
and upstream it, but I just haven't gotten to that yet.  But ebpf-for-windo=
ws
does not currently support BTF so it is like an older Linux kernel in that =
sense.

So we haven't updated either to commits that rely on libbpf >=3D 1.0 since
the APIs we support were removed.

> >>>   Does bpftool work on older kernel?
> >>
> >> It should, although it's not perfect. Most features from current
> >> bpftool should work as expected on older kernels. However, if I
> >> remember correctly you would have trouble loading programs on pre-BTF
> >> kernels, because bpftool relies on libbpf >=3D 1.0 and only accepts ma=
p
> >> definitions with BTF info, and attempts to create these maps with
> >> BTF, which fails and blocks the load process.
> >>
> >> But we're trying to keep backward-compatibility, so if we're only
> >> talking of kernels recent enough to support BTF, then I'd expect
> >> bpftool to work. If this is not the case, please report on this list.

Yeah, unless/until we support BTF in the future, we cannot use the current
HEAD of the libbpf or bpftool mirrors, only older commits we sync to.

In that sense, the removal of pre-1.0 APIs made the mirrors more
Linux-only and less cross-platform.

Dave

