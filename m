Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5055F163D
	for <lists+bpf@lfdr.de>; Sat,  1 Oct 2022 00:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbiI3Wlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 18:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbiI3Wlk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 18:41:40 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2121.outbound.protection.outlook.com [40.107.96.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C3C1A0D25
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 15:41:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYfMcbmLN1ByFYU280/OMEei0V0Q4q6MGVLW4EDmlQxYxhxhLiUI8Q01dbZ+AXgmyVorB976DrguLdtNA8FuED8b3IKNHNnic8zd6upgd/9MyF7Np9ePut5xAJN+M1MZ6DeD9/lwvutQsjnL19CL3diUBqSd8ObL4WZOWAbiLtlWFKmgGx0IVqZ56xvX5H1yqEf4agCJnY6fu1l1nygtQLzvVtfNwaRlcDqaAmns7mMyJOupxS1/g+7+s07vYT0GRunQR7ujB1EWvbTNvP2EDd1jui70Vzp51IT/w1HOhOL6Pd1OsJHhk06xM4gtc371eaeNdmxvvYaf31hptpsnJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruzknCE6020CCDgRiFc9hbo1ynNXvEGBRNi8bWftfiY=;
 b=gaN2L6CgijOBSA3Pmx7fh6dTh1IktKYMQnieJpr2mqaQ05VzxOLmiXXu3bKWk/SYcbnXSTse5mOV3ONxKT+ORmb005nGVnr7iy/MFdEAUmoKmjqqLVucCzxPyz8Abo4KG1tz62VA/PaLwmxFhbrdAlZt1ooxVzML6qv0HdXuv78fi61ZXXYEoM0PIyNj/iaOs0y5SJoEuLdes33DEdAoPVz0+TJAkyIzD+dE0uDvi+SJIezSJ8CzAHGBL7h0CVad89fuH9QFhpa4FzUQys8yJApVKVZq+VaXmVT3Uhw6cqdufrvrLF9rtXGufZlHNbQj2H0/AWyhRGCOvp8CN488DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ruzknCE6020CCDgRiFc9hbo1ynNXvEGBRNi8bWftfiY=;
 b=J6Uf00y9QIHa4fS9EYpgQr4CKEnRWwy8Q2XhrD05HXNjsya+cnfPQfV1FQ50QNLO3VC3pm8eKXu+AA80xyi7CRr/eKcJWiRc0LzkZX8NTmBfMe02dZ010r3pbJ6ojDS9bMFTgPL7OgkBqpRGaEoTIOCZE9NCV9xZvkm80LBFEx0=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.1; Fri, 30 Sep 2022 22:41:36 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5709.001; Fri, 30 Sep 2022
 22:41:36 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Topic: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
 overflow, and underflow
Thread-Index: AQHY0qNnkHKOYI8p1UG845fwAHqmHq34d7+AgAAQ4JCAAAHbAIAACxbA
Date:   Fri, 30 Sep 2022 22:41:36 +0000
Message-ID: <DM4PR21MB34402522B614257706D2F785A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-7-dthaler1968@googlemail.com>
 <20220930205211.tb26v4rzhqrgog2h@macbook-pro-4.dhcp.thefacebook.com>
 <DM4PR21MB3440CDB9D8E325CBEA20FFA7A3569@DM4PR21MB3440.namprd21.prod.outlook.com>
 <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930215914.rzedllnce7klucey@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=17d2a68b-d1b9-4c64-b84a-8c7414aa9153;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-30T22:38:54Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DM4PR21MB3441:EE_
x-ms-office365-filtering-correlation-id: 81d488a8-279a-42e6-1aa6-08daa334eeaa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MkDj9B+aMk3cc9Sf1EoecX6LOWcGiXOr5WsBhmYqO+zG6af6GXbQexXx6aniljsY75+GzoIny2wbu78NXYCI+yQj5c0qYr9O+5WRN4o8BdXYkUdAg11PQgSt9oV205bGHX4213+/Hj3DuO8p9GrvI4TgIjfO1B350psIe/hrEBFbVzrVMvODM9bqkmyoEWmYVd1p2NnjpKOCTO7zIBzkNZjPoVPWI2iW25r+whVDx8a0PhfHmOuhxFxqQ8DsqVnvT1GOV4OIyqYUyFUWu/a6AxbJizUkcQ54OfOowFoxBFJPWh4q8jt805OPOC4St0/SCbWg9H3GE+9SQz0O77t+ER7+csNH0nbQDnKHkd0WnLafXcqZcqKNSFP82wgDmIYF2Kq37Ob8JZew+24GLzDSvruT8HnuNv+8Ema6wIZWI5UhYsE1nWQ4Z6aPBRXunHxtpeTWYm90ziZSuUvXUOdmnxXP65EfZlnsUNFTbWnb66Mu4q8jDs7GTWXIa65c/Qel8ZmVCaZgqOc+u2459EpGwEu7qkqwaavtfhlOS344RxzQ1rsG0j0VvBRXltMV+BvVmW6ShBvuP4JP67PpVsaPlKm8jAJUQmGjapB2v8IvBfNmtM/DvdvvwqJy7f/474Tys97lXnFqunuc5NSbrhaduiM+Xl1fUWbZIYqOyoo70wGu8eDzKpNQxghNtMpezLRwNUY/Pn5cSrxOCe771I5iBbKBi9QtteKaO4IjHoYV9ietwW5Nr6tCobvxtZpaiOJw7ELYUScAYTJnUUeYSFDrpq6KLMZwT9s3MyAL8C5DUzmBETmV9CnVfwGXlBS7ioUyr9fv8o8TRMM+bhXflQIQvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(86362001)(66556008)(64756008)(66946007)(8936002)(2906002)(52536014)(33656002)(41300700001)(76116006)(8990500004)(66476007)(66446008)(5660300002)(8676002)(4326008)(316002)(6916009)(54906003)(82960400001)(82950400001)(55016003)(10290500003)(38070700005)(122000001)(966005)(38100700002)(53546011)(9686003)(7696005)(26005)(71200400001)(478600001)(83380400001)(6506007)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kYbiqOsuI/HEmXhZsoYunkCySOyBY4MJzxSyYmlwLA8MdydYRXk1Bnf825tw?=
 =?us-ascii?Q?WxK8W+7WrZQsjN2fH4YmEJS7D/dfgEi0mn5w1Fg0n5RIBoGcQf17B08WYeay?=
 =?us-ascii?Q?rhMMyId7X1CeDvlxbGSJH46ZBOCi/l9ZNPYS+5QUnUtK0mlox/onWS8ABqai?=
 =?us-ascii?Q?5DeO7to50ua9cwNGcvbBbRtu3cXYM/rJgXYxsPfx5ALx5Becc9H6426i4j1M?=
 =?us-ascii?Q?SFFF7gDG1cdRS0UmlJT/ObGwYOgk+ZwVbBI7X5g8/0+toWuXkvEv7gyUYriL?=
 =?us-ascii?Q?h3n1UosvqAyyqHw7kBT3mMvU23WREeIebEIYTadqz8bSRI6PdMdK5ZVXo2C9?=
 =?us-ascii?Q?6XUFj2qZoUvXt2hR+v5hhQZNQpB04xESupDQvTpIXDl3jCeCyW5a1sDJecmV?=
 =?us-ascii?Q?oeFkzeaQT0RlYcmrR97KN4arCOBOy02s2JoooD/rQNUDapiykMzUgC6RZrMa?=
 =?us-ascii?Q?atLwsliXTPw69slstvq/7ag7lmp3xpq8LFBO/RoM2sVJB6xOY5vaSil1aTf1?=
 =?us-ascii?Q?5CJDAWXyJitiF97BgU5s1aEI24pOKh9dr07UOyyxu/ZvVp6BdOe+9n1FDE++?=
 =?us-ascii?Q?8s2sdp3NSl1VoQBZa/tYUGp99+CDnWmBSGKawquAsM3lWFbZ/dgln3NBSNZ2?=
 =?us-ascii?Q?7A79euJaH4ad/hxTSnTQaAHSOayXKT+2BoNqEpNQ3/6MqL6DBqpPlW4eAUhk?=
 =?us-ascii?Q?vaFdpixl1Et4h178Q//VCOKS396SWzFnXEEpRIGnVKuKE/K1ukaY0fDr+B3j?=
 =?us-ascii?Q?9zHgFC3iOw02lLbtsOSCr5AL7AH5twYDlwyVNiUfhRLpbwz+as+gDZ2YyiUW?=
 =?us-ascii?Q?QmgOlcKPCYU2ygkF62c72Gv7TeZOlrD4c2zzTRLMag1IB/3p9rFXjsZ4XNBO?=
 =?us-ascii?Q?ca7s8dbSPYki3Vw6zVZ5RSYuowNAhtfAgijuNhhFGOSFFQmyANT99+q/SVT4?=
 =?us-ascii?Q?uE3Eg6tTyZJpuXgDmj91PRlomcaWrN1M/aVwKN0XTlDgBA9WqwtgcHFKCuFY?=
 =?us-ascii?Q?jXQlb6vtfkzQax0/MOxiVVrYd9AApjdM17s/lmpZjO2xl8VL70f9Lh1FhRgF?=
 =?us-ascii?Q?R4qzUVtXkigK8cSeKqK1d61mFpiwCl7PeQ8mPSDz/uHmp8xyA8nzpvZ4M7p9?=
 =?us-ascii?Q?A/MbkOc4g0W1/OkqhYC56Y2cYUZrgSDvGX+wE3tLuqY0rsRpjzEQWVHuGEnU?=
 =?us-ascii?Q?cSBsAnTB4VIq9WSqLDVexDZ3Cq5P6s5dmfKIqUoB+qMzFFJuVloVnsrABQSK?=
 =?us-ascii?Q?/wirtkSgAxVJIxmVGXGkXAhljNDbRKnH2jRLxcN/ONk6OIF99DzFP4rQwWfU?=
 =?us-ascii?Q?E44Ywg42amOyqDD8jezymnCZjwOS5iOU3WBVYU8JxqK6TQiwOqqz+DVO1Eho?=
 =?us-ascii?Q?834YqVclNNgxe8mtPeWT2iVGbyHZXUTJqq1mrM/aeOx8VPV3eYA6KqundIqi?=
 =?us-ascii?Q?LI5IbkDZfhB2nzAzMciqUmxE+ktAhPnixH4WnwAw8yz2q24vzETzSb9CYFvi?=
 =?us-ascii?Q?WDkIBLaPFDcR/uR/hKeqnQU/hwlnO4AciQM/n2Cr9uzPnBQSJ1WbGdF0exzZ?=
 =?us-ascii?Q?j59+reU/jBY0ezr4UmUPqLa4tH05k8d5l1uQH4GHnbLkJ6suf83NXecuTuZN?=
 =?us-ascii?Q?BQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81d488a8-279a-42e6-1aa6-08daa334eeaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2022 22:41:36.3474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeyjI6jPQjUANd8M9K+to/x1W8hknrCgHS3R1H0mayoBnRWr5dXMB8VN1PZIHmfMl63iweafC/HyuSE++HX+fBrZOI3dJC7lxMeOefIts/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3441
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> -----Original Message-----
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Sent: Friday, September 30, 2022 2:59 PM
> To: Dave Thaler <dthaler@microsoft.com>
> Cc: dthaler1968@googlemail.com; bpf@vger.kernel.org
> Subject: Re: [PATCH 07/15] ebpf-docs: Fix modulo zero, division by zero,
> overflow, and underflow
>=20
> On Fri, Sep 30, 2022 at 09:54:17PM +0000, Dave Thaler wrote:
> > [...]
> > > > +Also note that the modulo operation often varies by language when
> > > > +the dividend or divisor are negative, where Python, Ruby, etc.
> > > > +differ from C, Go, Java, etc. This specification requires that
> > > > +modulo use truncated division (where -13 % 3 =3D=3D -1) as
> > > > +implemented in C, Go,
> > > > +etc.:
> > > > +
> > > > +   a % n =3D a - n * trunc(a / n)
> > > > +
> > >
> > > Interesting bit of info, but I'm not sure how it relates to the ISA d=
oc.
> >
> > It's because there's multiple definitions of modulo out there as the
> > paragraph notes, which differ in what they do with negative numbers.
> > The ISA defines the modulo operation as being the specific version abov=
e.
> > If you tried to implement the ISA in say Python and didn't know that,
> > you'd have a non-compliant implementation.
>=20
> Is it because the languages have weird rules to pick between signed vs
> unsigned mod?
> At least from llvm pov the smod and umod have fixed behavior.

It's because there's different mathematical definitions and different langu=
ages have chosen different definitions.  E.g., languages/libraries that fol=
low Knuth use a
different mathematical definition than C uses.  For details see:

https://en.wikipedia.org/wiki/Modulo_operation#Variants_of_the_definition

https://torstencurdt.com/tech/posts/modulo-of-negative-numbers/

Dave

