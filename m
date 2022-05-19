Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF4152CA04
	for <lists+bpf@lfdr.de>; Thu, 19 May 2022 05:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiESDIP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 May 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiESDIN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 18 May 2022 23:08:13 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021014.outbound.protection.outlook.com [52.101.62.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDC3D410B
        for <bpf@vger.kernel.org>; Wed, 18 May 2022 20:08:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEJx4sVfZ54Bv3BDQI/bL2crfEY2mwXS0DJ01GO/U6+rLa4Yy4HkElO9PvOK4AB73V+5SOvcxSeSnmx86abUd+jVNT4MZZJ0xUM1uDf8cnvAq2XxI2rsrg5YQCvUzth33P3tSCfoJivPXBz4It/krUndzzVOUnMyRE2a57D+rd/VlvfIs52qhPjNmE8VMvOzFFYLR7VFfaRTg50CR2bwohx0ioEkGHnrhpo+ZsH6siiewyEa3nyDSsI6hrDlvFA6e8i3Qhiwz7OGNejteLN5EqAWisTmZ8UhrhY/GgSqnmhZM4TugaEBe+wXoUiG/+iLFv0aLByRcGn94Ylt3Swdzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfb9WvaP1ZTr/wHg3JxTv/7EVYVWTo9zV0wyKh1doiY=;
 b=LwQzs98GYeNxxPEbupBCdNjH+8qegSR6Yv9Sojcgqbj7uw1BRrsjvXm53c1bGTsj+EbW3LgvZVGNhpvwz6gXPlBJ581HIsn+fDWdNVlkQr2ZRs3o9TVWdKRRuYCXH3X/Pcve0hN2pxTbnSlKkGf0rvj8FBnTzcWfVMWV6Ks3JJ607hHtLBc8Y1PWzs6EqMfishfPwKeekP0Lfl+49DpeWhfglJVPANn5TKzfNw8sX0+b8i69GZT9pM3z0Weso/GGQ96HOo/jbBPVM8SvS3Yto9T9sg8TJKMK3aR1QS4h8sv3sovSZcUosJc7XNSuL7tLEbFi7kgZ0Wh13FTcztDa+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfb9WvaP1ZTr/wHg3JxTv/7EVYVWTo9zV0wyKh1doiY=;
 b=TTRcF5L5zKQ4NWY1u4tjFI+NyjS8gqekdB+tuJ0Sbeekrzv0du0cjVRGq6x3mLZoPPVjAbA8RWNt3lh0XUgMM0pA22uOR9XmlkeyDFWcaVt93gdOQbRyo9EX0SZARf56Fs6/8kdgWrxDw28qx49wQ1JihxksPIdp4RqtHoW/YIk=
Received: from CH2PR21MB1464.namprd21.prod.outlook.com (2603:10b6:610:89::16)
 by PH7PR21MB3334.namprd21.prod.outlook.com (2603:10b6:510:1db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.4; Thu, 19 May
 2022 03:08:09 +0000
Received: from CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::4910:3316:8c4e:f4b3]) by CH2PR21MB1464.namprd21.prod.outlook.com
 ([fe80::4910:3316:8c4e:f4b3%3]) with mapi id 15.20.5293.007; Thu, 19 May 2022
 03:08:08 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        =?iso-8859-1?Q?Daniel_M=FCller?= <deso@posteo.net>
CC:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Subject: RE: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
Thread-Topic: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_str
Thread-Index: AQHYaUt9crVMsORySECr4+zVF8VJf60iKjQAgAD1OYCAAE0MgIABOCYAgADjdmA=
Date:   Thu, 19 May 2022 03:08:08 +0000
Message-ID: <CH2PR21MB146471FFF1748CE417D6B79DA3D09@CH2PR21MB1464.namprd21.prod.outlook.com>
References: <20220516173540.3520665-1-deso@posteo.net>
 <20220516173540.3520665-10-deso@posteo.net>
 <CAEf4BzYXxSerQnw3U5SKU10HAbM1KrTj9z_DvX+tQqaq7+2CUQ@mail.gmail.com>
 <a1a518b6-4006-7a65-178d-6100ada34a2d@isovalent.com>
 <20220517185427.tafxhqk7vplj6ie4@devvm5318.vll0.facebook.com>
 <1198532c-3be3-badd-cfc2-052aa435d697@isovalent.com>
In-Reply-To: <1198532c-3be3-badd-cfc2-052aa435d697@isovalent.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=f0c6c587-81c9-496e-8900-a00461941706;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-05-19T03:05:47Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9af375c-692f-4677-01bc-08da3944cce8
x-ms-traffictypediagnostic: PH7PR21MB3334:EE_
x-microsoft-antispam-prvs: <PH7PR21MB3334CD356D589E8CDE0A3FE5A3D09@PH7PR21MB3334.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ppSqsnAf53YuVc3lZmm8Sl4u4OAc0ZASKzKGtBnfqYsCGJ6G34SxxQwe9dD5o3VLqUzROjVERQFVwBGYSRSxr6Nghb/yPuxhf+VFsuHK2vx9ZBHqADlRAlePD/4ClNtLhd7Xnd+0kHsfZ4wXwYJ1f9xDTcz05fenMhJh+MWuDoAN4ki+xU6vqy3zsnEKlW8viJVPTPL3lWNrMXt5YMBodGaAjQ9JVhkdTq36cLexjaoNX5H39XXsKBkn4z1sro+8ZNE86jBm/jfkFD5EtPdz2PBBXII9b7ebgxU5DqIt/VzUsOwKF35Nv/A9dgsFNY/pO7045i+lNHZdH4EOCKehiOS8pWUKkzrfio4Oy2M2l8e14KTTw4w3cUQLr/twOt6/A2NbIUoqgqVREczaBuIibCRldHbBv9lcHjkb4/RwsHd0C0RIGaVv6P1ZHB9qdEgUm7FwxlGMShdZIH0Ao+a79bNMIa/EEBroAW6/kJGw5dZm7g5LqHFYWEzvUCklOPl/JyQWwT0JGp7tnYn7gnJDmJspBeYQUvZhX+OGYwiO5H+D4VbD7V1dqXHKyHxKOD/6TCeFhTByh755m0jBKizI013F4B6NKKn9SF5WTE6Lsf6AVKSBB/gX1tDScB5L0cbF4VGyhNcnowS66xMXbaL8rGRQeE4Jgp0bbMEb3TfmhZVhYGfBWsa/h8RTXqu3GIOMTGbO+r7YPsuhnNlDuxbA1KebfzjXTBNamVWXt99rWxw8GXCNko34nFMX3b0N5u08
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR21MB1464.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(451199009)(2906002)(33656002)(186003)(7696005)(6506007)(82950400001)(8990500004)(53546011)(86362001)(26005)(9686003)(38100700002)(82960400001)(122000001)(38070700005)(66574015)(52536014)(5660300002)(4326008)(8676002)(83380400001)(55016003)(10290500003)(316002)(66556008)(66476007)(66946007)(64756008)(66446008)(76116006)(71200400001)(508600001)(8936002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?44YRL/DWfem2b8TKbifN7O4QXsxVJYB3Cg/mDY9c7aR0W24z9r+qATPGSD?=
 =?iso-8859-1?Q?UvnfS91zzxlgRhJ9r7JDYJgix9vdtH+2I2iONWwiZSUcQC5tKFTx6Xjmbd?=
 =?iso-8859-1?Q?8aiQ0yz8rSGRE9LJUV6mAzHku8e9HpnimI1pxmovypRQr0IG77swArP/WS?=
 =?iso-8859-1?Q?ayoaT6WOviiwI6269Okm+LE/nTWlessgi41IKF629SYmBppO39ot/cCNRB?=
 =?iso-8859-1?Q?9eSJEYt0qRCTQaUGzm3l++65sIDB3hi1H7b4iZga1FFteqZRLxafOkFpwP?=
 =?iso-8859-1?Q?0I+fLgqm7IBmjIzf9KaAWsVhdXRmEyhIX2uHViUJu993xq8k3aHx4j6HB1?=
 =?iso-8859-1?Q?077vuAr3BaZIDF6Z7CV25479tHvOpmnBoCp1gnsfFtxhYKcWAfi1TyBSX2?=
 =?iso-8859-1?Q?skY04QdilBWUSTxSNr1O2IF/+PLF9ETRpaex94DEnUKTRqysgE+NlypFJq?=
 =?iso-8859-1?Q?2Ts+c/B035uENI3ZXeCj72cKZlNd6fqbm3QSdwwz0S+rdX3BUGMP3c37BX?=
 =?iso-8859-1?Q?NbIF4CXqua8DdnpY1vLdrpF4pGDttz59kxmtMD6Tw2GXlhpAeVcPqJxmJp?=
 =?iso-8859-1?Q?ryyzjlEYl4lObRs6l2CwjIlwAgqQ3lX4riIEEBErH/xrS9+8WW0mhDi1vg?=
 =?iso-8859-1?Q?2SpxLYyJc+ErQ8JmvV54aBCULZI4FNkuDI6H3dV3OuWBp4SZi2eM+D62oA?=
 =?iso-8859-1?Q?JUwXGpgZ49+7lI5tOpkfU7nPDoPPAzwWNG8sFfj8MAy+oUkM1m64k/ubKX?=
 =?iso-8859-1?Q?QTPwxJBwcIiPo5I9A0pWPZVFYC8sBRoAPhvdc3RKXOCcYFs52yS2P3bfmy?=
 =?iso-8859-1?Q?G12bjGohH1JL01vzYX/pzHPD371CotARl/n6nLGlMaDjZD6u5yA4JtZCT5?=
 =?iso-8859-1?Q?nEnE2fTB90PmWw8VN3PSmX8+dNCLFBVd8GX1MoFkWYbsJMBqDBlvd/8KzJ?=
 =?iso-8859-1?Q?gGXk+K83ECgKTcetm5XzZ3gLWr9xzltpinzUsz6PT+K3W35C8mL80K4KPG?=
 =?iso-8859-1?Q?lauhI8HXgiNC6tUr6vBDaLwMaf7yurrPuiAZpMjZFzOZduJ2Gf4OUmyxGZ?=
 =?iso-8859-1?Q?OJa4C2kBK9vO4ZPu7c8SVJD7IhG9otkD2uW2LQCukGr77GpgCc9aZhyA7W?=
 =?iso-8859-1?Q?UUL8dnmQ9RbaIBZk1jnRPzV5gy2VQDtrahy3PTohWUAR3yVAvnjntuMDa6?=
 =?iso-8859-1?Q?a/ixpqGyQmHl6gke5A1+nrK8gkcLUWEvKKJQmViJBzpt0s9x3GETSESkYa?=
 =?iso-8859-1?Q?9LGYleQRnz1kpDW8fDAYCg//5BStnZHev1KQhZO3FQOUNh0VAfx8Xg8h0o?=
 =?iso-8859-1?Q?Cv9UO11RjjcVRkxQBjDfgeOccddq94E27Am3DT4QoQPVh3xxfntJT0mjTk?=
 =?iso-8859-1?Q?oQpCd2v3gFXVQcCsPX3o5YscCVZuYV3Jg5MqwdxXaF1OsznwCxjguqgxp2?=
 =?iso-8859-1?Q?AJFLXbHDYS+GD5sU4ve65ZqEwe1dkQ0L9n+bCeHE79CaiVvt798rVtuGP+?=
 =?iso-8859-1?Q?hAa5zjQgSnkN1SoxyzV4jZZV22E5cfvDf2YWtYvL1dMVjkSD8hFJKcJXRD?=
 =?iso-8859-1?Q?C0aY8GKSkR4l+Avt7hqoNsztTBHtjLxXtZkmxCNWWAAM6zicqNPw6lkVga?=
 =?iso-8859-1?Q?0FduMdEYbpahHhfJmEIiBnY1+4CLE50CgVSdOHfHpIoJtlvm+N1VHASdY/?=
 =?iso-8859-1?Q?ZkpHnQcBDZqkvjMhyODLgfWpFh6LvrEfNaLmnEdXgjvVgl8VUJLKlqD56t?=
 =?iso-8859-1?Q?qgfa54i8vvU/UIbfGamf3Cfm5FHwuj0HKGjwDB9ny5rM+TkIMIrak5JIuc?=
 =?iso-8859-1?Q?ta18E++zHUNe8RKJ23vaQtBvGjFmMHI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR21MB1464.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9af375c-692f-4677-01bc-08da3944cce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2022 03:08:08.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqPZH0AT5CH3JvD/9tQG7iIjQjTZxo4pIYtzY1NZhkjJTiQgiW5O7cXvzPcVapj3xdPDprNjgsblAgdiPzubNidTi/bZlQhfmjnQ1/lTMvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3334
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Quentin Monnet <quentin@isovalent.com>
> Sent: Wednesday, May 18, 2022 6:32 AM
> To: Daniel M=FCller <deso@posteo.net>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>; bpf <bpf@vger.kernel.org=
>;
> Alexei Starovoitov <ast@kernel.org>; Andrii Nakryiko <andrii@kernel.org>;
> Daniel Borkmann <daniel@iogearbox.net>; Kernel Team <kernel-
> team@fb.com>
> Subject: Re: [PATCH bpf-next 09/12] bpftool: Use libbpf_bpf_attach_type_s=
tr
>=20
> 2022-05-17 18:54 UTC+0000 ~ Daniel M=FCller <deso@posteo.net>
> > On Tue, May 17, 2022 at 03:18:41PM +0100, Quentin Monnet wrote:
> >> 2022-05-16 16:41 UTC-0700 ~ Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com>
> >>> On Mon, May 16, 2022 at 10:36 AM Daniel M=FCller <deso@posteo.net>
> wrote:
> >>>>
> >>>> This change switches bpftool over to using the recently introduced
> >>>> libbpf_bpf_attach_type_str function instead of maintaining its own
> >>>> string representation for the bpf_attach_type enum.
> >>>>
> >>>> Note that contrary to other enum types, the variant names that
> >>>> bpftool maps bpf_attach_type to do not follow a simple to follow
> >>>> rule. With bpf_prog_type, for example, the textual representation
> >>>> can easily be inferred by stripping the BPF_PROG_TYPE_ prefix and
> >>>> lowercasing the remaining string. bpf_attach_type violates this
> >>>> rule for various variants. In order to not brake compatibility
> >>>> (these textual representations appear in JSON and are used to parse
> >>>> user input), we introduce a program local bpf_attach_type_str that
> >>>> overrides the variants in question.
> >>>> We should consider removing this function and expect the libbpf
> >>>> string representation with the next backwards compatibility
> >>>> breaking release, if possible.
> >>>>
> >>>> Signed-off-by: Daniel M=FCller <deso@posteo.net>
> >>>> ---
> >>>
> >>> Quentin, any opinion on this approach? Should we fallback to
> >>> libbpf's API for all the future cases or it's better to keep
> >>> bpftool's own attach_type mapping?
> >> Hi Andrii, Daniel,
> >
> > Hi Quentin,
> >
> >> Thanks for the ping! I'm unsure what's best, to be honest. Maybe we
> >> should look at bpftool's inputs and outputs separately.
> >>
> >> For attach types printed as part of the output:
> >>
> >> Thinking about it, I'd say go for the libbpf API, and make the change
> >> now.=20
[...]

I mentioned this at LSF/MM/BPF in the discussion of making bpftool & libbpf=
 cross-platform, but yes it is a good direction (in terms of supporting mor=
e runtimes) to avoid as much as possible having per-prog/attach type info i=
n bpftool itself.   So yes depending on libbpf apis instead of hard coding =
in bpftool is good.

Dave
