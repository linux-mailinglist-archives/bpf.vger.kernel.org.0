Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8D6F6B60C9
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 22:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCKVAa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 16:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKVA3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 16:00:29 -0500
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020022.outbound.protection.outlook.com [52.101.56.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37446C1A2
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 13:00:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKsXAR81vdIJmdCvHC8tfxSRnXckr32zPwtly07IEv5FPiXwrHlaasooBhrFgFm01Fq4al6Z0HP+2tfenCqV/agDjEvdImnw6rahVG3N+w/hWyDxwpzX7WL7v+6erBYLHc4AnZUk6pbndUTPlki//TmUAv+Y7m6Jx7vUD19Vwc2HMVMB3fvEpCQ2NC58wvzXJiFzEd+6zuXcmsPJdjdH7hcqMsrhBiayC7ODyaIMwaE6C7YAcqDA/kgQVw7ckDV5fPCGIdCgVZO8Chq76oQYqZwWex1huV/SA4yA4k1ztZjjWkWmtJB/ZIbLZsUBP1aKs2WlxFu5cuVcCuvgmeCZ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wY0kMrUrA23CnO44CN1hw1E4ZS9k+qeYSMvpbeVbtbc=;
 b=S4xKxmA16Ob2on5XLRFp+lW3cvpNCMlrv+WkACuao6vHXHHcRL9WjZ7AFuirVh+atsJcuE/Q4JfWYUn4qEMW2MNnUDkT+7ZfYRrNiaFRbgcngQPQPm83SpNn3+kRAnouT/e5oEbEn7QRhtgPujCn57s5IFsbfUkXzmW2BOLkaBVhdcK0KD3yvzL9cBljkv39Adahhpq6WL9vVqRU6/MFT0obf7WQS5fUn5fbLLjaiUqqK9G15hXeXb0O77w7hUXEOfa0pQpt4LL5OIvRYHc/Oldgi5TMcIMC96WPOaaWqJlEt0ZqeSt/+bLTe3oWRg0Hm7c+xe2N5VI7fnpM7En/EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wY0kMrUrA23CnO44CN1hw1E4ZS9k+qeYSMvpbeVbtbc=;
 b=dOrfe4PbbwpbrzG7ziyndIPHDOcTqfcbGOgeirwBInDuDoc+BzwsjIxnN7Gct6OJb5BwBwQMFNmYUUXWQLfWMLg3ZqXUmOHji32LSQW+0zMreJJlyIP1wYYbOyHzE0dgsmApUgfvIOjl/YZFVqd7NJ3AljACPpooUnaS1FzyKWk=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DM6PR21MB1355.namprd21.prod.outlook.com (2603:10b6:5:175::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20; Sat, 11 Mar
 2023 21:00:20 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75%2]) with mapi id 15.20.6178.020; Sat, 11 Mar 2023
 21:00:19 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     David Vernet <void@manifault.com>,
        Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Thread-Topic: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Thread-Index: AQHZU6cgfSRLMPukSECUjWK6Qe/ohK719f2AgAAZ0UA=
Date:   Sat, 11 Mar 2023 21:00:19 +0000
Message-ID: <PH7PR21MB3878BD98FB4A65E5DF3E0906A3BB9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230310232144.4077-1-dthaler1968@googlemail.com>
 <20230311192115.GA332677@maniforge>
In-Reply-To: <20230311192115.GA332677@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3d661c3c-031c-466f-9eaa-776059510793;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-11T20:53:38Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DM6PR21MB1355:EE_
x-ms-office365-filtering-correlation-id: 6a4c9775-29c7-4943-9bb0-08db22739f69
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9NkS+X0HeAVWLUa0MyfaA4bGwtck7XMjN1J0axYr67Ae9y4UN03lDZYEs5CIF+yHIq0QVMP2rikqEqbr+QDGmfqWNWqHlH5lECRjPRmT6nt938a3380cSf3maFFYpeCPmBWLRyvFdGE4E0S8DlXbI9QPU0l+33t8oseih1QJfyc93K7DYji2MmPJWWYjMXmVkXLBc1khK+2pAJClW4TeCKr25UVNtBH/CB7pq5iSeC0+J4YXJBCyCw3Lllv0GkIQMba5JjUGZMde/pGP9cIvjNwedqM/DP3a6kU4qV4LZXqxOeyUr4XWckHKzkS4mpneL6ZqGtzkOYbndDQDrDz9sjQNnmsNEykzoc/2RkBcmKc5KNanuZUKk+XwpjdKQjHFas7qWIw++OAJx8dtlYqmNEJMlxIc6IVYKOdGBP+ZZpsxkHn7C04Gfc1ypA6ndZ5IZ6tvGPwiuFDHctTC/aQGoTAl2EOOJ7gG9HniXBtUmP+okIMaOuUQdLNd1Z7Ud1l8T60b7Qs9k6L06pF7FoJoYCrOURPGaokWsGXkfdsUVmVlkqg2xRSguE8PAPAlw/CeUp9HRCD4xMSJZv45AUam8Ps8fFK7RbsLDs568MEtUGB+jPUCQH6w2Gt/GgjWmA6vrLJnmknUuFyXWaCtqGqYi96Hf7GEyqs2rSNC/tkfUZjddOdvKhKJeuyjnoMCjfxP293RhFBJH+YVD+U4R2PqKFo41Xk3+VvL7FxZAsfCvpYRy46hR/nm36XFNsVa4Se3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(33656002)(8990500004)(10290500003)(82950400001)(110136005)(71200400001)(478600001)(7696005)(6506007)(186003)(9686003)(26005)(54906003)(82960400001)(122000001)(55016003)(38070700005)(86362001)(38100700002)(8936002)(5660300002)(52536014)(2906002)(41300700001)(64756008)(8676002)(66476007)(66556008)(76116006)(66446008)(66946007)(316002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bgjJ5hV/iwZsJXs5CebZMSVLGhcWpS+Bhm2oQvlum1DsGybpsPkoI/4DXYxd?=
 =?us-ascii?Q?MQL49e1AKt1Wmz1UIXhDO3NhuEzQcUaBIfVy8iTqCQjRoJaP64iujd560A3s?=
 =?us-ascii?Q?4zd/SyJ0UstfmLNYZjl83ez8Ip5rQM8vyFKCo46YXJFw3mF4rFCimFGYeCkh?=
 =?us-ascii?Q?VvN5Cs9gzUtbDLcPmMrubyC7xKwMWmPWhPW0/jele3Zs4zek2y7HctRrqG/n?=
 =?us-ascii?Q?Wj1kh6CEZftFJ+hDIKFN/ihRnfj6X0gU24LT1A331jsZq13hL84qXreOm08r?=
 =?us-ascii?Q?Sa1WRxrhucozIXSQnm/xfAZN8zpH75UcInDGME6oe+0KVkvjqoR47LqenEQ4?=
 =?us-ascii?Q?D/kDp8+UjwgbSANXAe9ZVwEp1ayXFGtXHWFBjxCSKbrSG0MxgnTuMDjHf7S3?=
 =?us-ascii?Q?V4qHNIcidk7PoHcYPKmFaiv9TmAEh44+lAxTwqGukzrU8CvSfB2Ow9NvEgoW?=
 =?us-ascii?Q?kS6UYbMJH1XOngLhDRQg76xpGprQM+1506RfLXOYstCZS0m/ZWYJpjCMEJlw?=
 =?us-ascii?Q?ToTjJO28tyCSs/S3ufbrjEFXlq9cyvZdt0zgGXYHmSLxuOHcXq7O8q2hr+Ht?=
 =?us-ascii?Q?nO3g6DmgK86kmxT0YnOmFg0px70LTZl2YZZ+SNfq1DGCgap+/SsYAkeH3pGj?=
 =?us-ascii?Q?mBswwy5mRolw4Y4l18pLdTyEWwjRLVz1xFU754ob3x4IdWsvwfUjDuuRkDYx?=
 =?us-ascii?Q?avIMldqOsdkvFwZ2BjqyzZZAZxk5pRnSo6ixPi7+egTT7g4K+ES9KDnxtg7h?=
 =?us-ascii?Q?nj/VWFev1eAapSD6+JbE/3MWUmuJXtXDt6KuqIpgD4haZwk6gTJATlTVeu79?=
 =?us-ascii?Q?Chb4ENotuAz8D07ojo2qd7PFVUJKPZb7pv2qyD4UUIzFUarWRWfLQh64rmmn?=
 =?us-ascii?Q?imXbOw0DYHsY1lsJug5bI0jmip/JMH/1PE8aemnML8dFEYi9XBfv2uaRWro6?=
 =?us-ascii?Q?hN3cnWu3wCBUQagaE+irfH4p6A8XYpWiIwA90AMheRyICT2vG8PQqfrY3zql?=
 =?us-ascii?Q?p1zuyO4th43F4+d6qUpOa1IKtJK5TqoyDGcFxKhAjqO76iKPZfWOusiGcB3g?=
 =?us-ascii?Q?8++Euf+GQcpj/sHo1Qw4q4jVnTE9dkU3LMefUbzA/p8/g9Hd4CTbywcxjtzi?=
 =?us-ascii?Q?u0I+B1G7htgjEU9H5xvs60hcoW2Y48lh7xiZMHH8l83hHe028+w7P/t0wHt7?=
 =?us-ascii?Q?XEqLsAnpnaVxt+7YYciD8FVd/ELUWNZTBv3jRogOp8iirZ5I+aWruIw/zHrF?=
 =?us-ascii?Q?D1ivFvGvVfc8DnwXcMdBSaOMQMgDlzZBtX7dOj3fMtomPoAMzytr7nDcr7Sp?=
 =?us-ascii?Q?RnJrHdaSYd40+EaAYtzgVD2+VXHc31ZhNRULzVzWeNFOsvkYxuEhhnPtBZ1D?=
 =?us-ascii?Q?JuJHmRWNIy47BPSef6+luAkuLe9of9VIxfqvKt1kJ8JUh7QaNhqy0Xaqyjju?=
 =?us-ascii?Q?bhIwByFpDbEHQ55MQg8yxPYX7+3aio9jMDJTPjptK3jLTO9hCofb8oP4ojvh?=
 =?us-ascii?Q?DF4d/vZvFYIXoqgn7GYIB8pzMtn3yfhuAshPabvh1uj8VG84UBBMRe6M6MdS?=
 =?us-ascii?Q?IIaI19X+qZV/TCfr3/ZFtiRA78q+rvZdpYFzsyen4RZ6TRuCv3+ZV8whTiOD?=
 =?us-ascii?Q?sg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4c9775-29c7-4943-9bb0-08db22739f69
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 21:00:19.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7KxMOTCt2fOs5CAv/GjdD1LshGI4aJXSPedmzTabvHZNjHVvWuXha62/lZdGgEkbl2xzXjtPY+KBPLaKndgo+YDafjtrQWgEm5X+A5Rpg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1355
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> wrote:
[...]
> > +BPF_CALL  0x8    0x0  call helper function imm    see `Helper function=
s`_
> > +BPF_CALL  0x8    0x1  call PC +=3D offset           see `eBPF function=
s`_
> > +BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime functio=
ns`_
>=20
> The names "Helper functions", "eBPF functions", and "Runtime functions"
> feel, for lack of a better term, insufficiently distinct. I realize that =
it's very tricky
> to get the naming right here given that some of these terms (helpers +
> runtime functions) are conceptually the same thing, but as a reader with =
no
> background I expect I'd be confused by what the distinctions are as they =
all
> kind of sound like the same thing. What do you think of this as an altern=
ative:
>=20
> 1. Standard helper functions
> 2. BPF-local functions
> 3. Platform-specific helper functions

I like where you're going with this.  However, the fact is that some of the=
 existing
Helper functions are actually very platform-specific and won't apply to oth=
er
platforms. So retroactively labeling all of them "standard" is somewhat pro=
blematic
in my view.

I do like the idea of using "<some adjective> helper functions" for both 1 =
and 3
though.  Since we might not choose to standardize all the existing type 1 f=
unctions,
maybe "Platform-agnostic helper functions" is synonymous and pairs nicely
With "Platform-specific helper functions" as a term.  And then we could jus=
t have
a note in the linux-notes.rst saying Linux has some platform-specific helpe=
r functions that for historical reasons are used with the platform-agnostic=
 helper function
Instruction.

> The idea with the latter is of course that the platform can choose to
> implement whatever helper functions (kfuncs for Linux) apply exclusively =
to
> that platform. I think we'd need some formal encoding for this in the
> standard, so it seems appropriate to apply it here. What do you think?

Agree with that.

> > +BPF_EXIT  0x9    0x0  return                      BPF_JMP only
> > +BPF_JLT   0xa    any  PC +=3D offset if dst < src   unsigned
> > +BPF_JLE   0xb    any  PC +=3D offset if dst <=3D src  unsigned
> > +BPF_JSLT  0xc    any  PC +=3D offset if dst < src   signed
> > +BPF_JSLE  0xd    any  PC +=3D offset if dst <=3D src  signed
> > +=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> >
> >  The eBPF program needs to store the return value into register R0
> > before doing a  BPF_EXIT.
> > @@ -272,6 +274,18 @@ set of function calls exposed by the runtime.
> > Each helper  function is identified by an integer used in a ``BPF_CALL`=
`
> instruction.
> >  The available helper functions may differ for each program type.
> >
> > +Runtime functions
> > +~~~~~~~~~~~~~~~~~
> > +Runtime functions are like helper functions except that they are not
> > +specific to eBPF programs.  They use a different numbering space from
> > +helper functions,
>=20
> Per my suggestion above, should we rephrase this as "platform-specific"
> helper functions? E.g. something like:
>=20
> Platform-specific helper functions are helper functions that may be uniqu=
e to
> a particular platform. An encoding for a platform-specific function on on=
e
> platform may or may not correspond to the same function on another
> platform. Platforms are not required to implement any platform-specific
> function.

That looks good to me, will incorporate.

>=20
> As alluded to above, the fact that they're not specific to BPF seems like=
 an
> implementation detail from the perspective of the encoding / standard.
> Thoughts?
>=20
> > +but otherwise the same considerations apply.
> > +
> > +eBPF functions
> > +~~~~~~~~~~~~~~
> > +eBPF functions are functions exposed by the same eBPF program as the
> > +caller, and are referenced by offset from the call instruction, simila=
r to
> ``BPF_JA``.
> > +A ``BPF_EXIT`` within the eBPF function will return to the caller.
>=20
> Suggestion: Can we simply say BPF instead of eBPF? At this point I'm not =
sure
> what the 'e' distinction really buys us, though I'm sure I'm missing cont=
ext
> from (many) prior discussions. I also don't want to bikeshed too much on =
this
> point for your patch, so if it becomes a "thing" then feel free to ignore=
.

Will remove for consistency with the other patches I submitted that already
omitted the "e".   I think Alexei had the same comment a while back and
I missed updating this proposed section at the time.  Thanks.

Dave

>=20
> Thanks,
> David
