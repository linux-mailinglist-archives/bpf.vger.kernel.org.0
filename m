Return-Path: <bpf+bounces-826-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B24570739F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 23:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881C62813B9
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 21:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713571078A;
	Wed, 17 May 2023 21:14:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D77AD28
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 21:14:05 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021017.outbound.protection.outlook.com [52.101.57.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C628461B9
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 14:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc5tMckmIJxNCJuM7lt5BvM6Bmc8PskT8++b/DK23ozhXggQcn8Kp3FPVeV+0BNbISS0tjRldaQe6h7OM6GXLER4LhQ0Zwmg1bSEN/JWfozLPRJMjv1nluf2OF8VaTgZ62WU6bNdoQFHlXE5a/N8iCfbGt2kAu5BujEero/IsR/oN8Bp3YxzZAX0dhoT9LK915yOO3oA4CuSXkaUTSkbJkZbFRFJe1OYMbA/A29ixKoIf9fq6xgTeWp0KC/3VcllcKHUa2gtIAZHvysxkba+FyfNaScOEHk7sjEGDV/7X2PQx6UNR8vWdUFpHeaoNQt1jCV889xsTObme7lV1asLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pp9h1tYJ/zrVS0+EE36XYI2ra51MlPxfFOguWjmcfI0=;
 b=llsQbkGBS0X0P4TUqyJ0kPA3M9MuBeGLBA7vXR/HCmQbbVU/uQCOUj6+e6v6GsoSXfIN9g74cOVztnDYMaqyw66mVRtWYLMZ5NMm27KSENpKg1VkdfxC4oGm0UvwM6aLWZATbiTrAx3PHU029yumo2MwbzLSgGRb8nAI9o6Idcp01wkkqj+g/5VbmOxIEqnltSnHRx1PUywbAaEShFJ0nxrPKzPc1YUS29HIOZyJlYIl2fqjT8JqNaAzItBWVe/SIoESJhgAXaHQ2Ri+EItePJ5aGOgMLCQfER82bZUG+XVHcJBF9+jATbFZiVhb7oJEF3gIue3KlrZrhUWL6nkVsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pp9h1tYJ/zrVS0+EE36XYI2ra51MlPxfFOguWjmcfI0=;
 b=jJwfarddjAFFcHc5N4HqQI3ZiKbdZ2wrz6BnFJUHxvdD+sS4RBLNtS6bBEXbupmpQ/AnmNX0yVNMc3Vs/6PmMGApGPY6j7T45VG6MzA3TZhb4CpY86ztYEExNWAXBwGWeLBEAGeTKq7nR9BQKNwnKZ2USQgcQBOlA1nuQVaKROU=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by DS7PR21MB3668.namprd21.prod.outlook.com (2603:10b6:8:93::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.4; Wed, 17 May
 2023 21:13:59 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::ebee:52ea:94c9:4e43%7]) with mapi id 15.20.6433.000; Wed, 17 May 2023
 21:13:59 +0000
From: Dave Thaler <dthaler@microsoft.com>
To: David Vernet <void@manifault.com>
CC: "Jose E. Marchesi" <jemarch@gnu.org>, Dave Thaler
	<dthaler=40microsoft.com@dmarc.ietf.org>, "bpf@ietf.org" <bpf@ietf.org>, bpf
	<bpf@vger.kernel.org>
Subject: RE: [Bpf] IETF BPF working group draft charter
Thread-Topic: [Bpf] IETF BPF working group draft charter
Thread-Index: AdmIWSmp8uIYgrASRIKQXfLbLZQgdgAeO2knAAYWUOAABgrygAAAOCrQ
Date: Wed, 17 May 2023 21:13:59 +0000
Message-ID:
 <PH7PR21MB3878D0643BEE59DEDAC0886FA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
References:
 <PH7PR21MB38780769D482CC5F83768D3CA37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <87v8grkn67.fsf@gnu.org>
 <PH7PR21MB3878BCFA99C1585203982670A37E9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230517210029.GB123984@maniforge>
In-Reply-To: <20230517210029.GB123984@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=892be498-6033-48e2-b590-e56b06f1e31a;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-17T21:06:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|DS7PR21MB3668:EE_
x-ms-office365-filtering-correlation-id: 6cf81c75-9744-4c5a-f03d-08db571ba1a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4iYT3tbTA8ZYt+VfjLVLk4U8HrM6S8Qv5uFqEWNclq12Lqqd1PKNSxWSGPKCuKuiNKU4TNRVHCblz1MkzTlgblNMFdSLeYmP+2bn+PFLW6i8n7leqdsNmqDCqKAxGC6QkSkgznwLDGthDbs4Q5PHOaEkXTcZJVeWo7IgLY9J3BFkkz6pdUWlmJoFv9xRtEFqnglaaqx8YNMBhvxuXc7Id/YoAP2HFgoEKTea9LB3gSphkYk0PFkN1QoXaMeULon25XyW+bpmWa3l4ANMiLzwfinzZ+UeZ/+cXDR8YIGl5AEiusFZgJJA7x7OikeMPI9NfBVdZGWGynpMD3P80rgqhqBQkFxUpC4YNT6eoFoD+7W0A52QP0P7/4rB6iQQE6foVrYkjFSxk8MOCcDiUlZYz9cWrygOGpcTiuiaoJnbxXh1aNpcxILIYq6rbgmSFRFfFyM3aVvo0ejR9rILJTMXr27k39YgWGcWl2eD0E0eFkUKRm2EqYh/fqa2jLXyhU/jASTjn/vMSUy2L7OTyVt31jX9O1JYliz8R4wDF2km2TIiL6/gmK16X1n20MHS6LJk4zIYA2+V5+t1D6Ona6Ftuk/nJsDtPer8yumh15XpByH5lHg5fbmkq4yhtqr68m3MaixBMu1o92G2UepAjVsd7Y0465WiSIdJK+rPpquv7Nw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(451199021)(38100700002)(38070700005)(86362001)(122000001)(82960400001)(33656002)(82950400001)(41300700001)(83380400001)(55016003)(186003)(71200400001)(6506007)(316002)(5660300002)(786003)(8936002)(8676002)(9686003)(52536014)(6916009)(4326008)(54906003)(53546011)(8990500004)(76116006)(64756008)(66556008)(966005)(66946007)(66446008)(2906002)(10290500003)(478600001)(30864003)(66476007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uASNpYN7fF9T8zABFJh80PoV2XuF0+85J7GAcTQczR7y7A+Fr/zetQKaiPQM?=
 =?us-ascii?Q?rAa4ngIONRkEQn/yC2x1Mtv39hWKY8/VJRyesQK1jZCnISTOW9nSd09c3fxJ?=
 =?us-ascii?Q?+zxGksY6nG8/I2JTyKHKkuKxIrV1uG3wkCrp41N45wmzf5jNyJdTY/0XHpkd?=
 =?us-ascii?Q?3kqahUurc1a/mKO4FHocF2fnqfw0Lpy1U6F6+i2po3Fe2FLvn6opwkJxV4T2?=
 =?us-ascii?Q?nB49QDaxh3wBiNqqIIQuB2lPdPq4X4Jb0MJChklYuf00R5Av5CAwk7O7a6l9?=
 =?us-ascii?Q?i5bA4uMSowU8xoBxxvogI51sfryX3mdRSqLXd2H2Iy0Sf4gve6T4XdFSa04k?=
 =?us-ascii?Q?/OT8D1MYTkqZYmdwbRq+iQG+1EvFV0NaSA02wEkMMk3uBuLtgfA2Dz9mmXzS?=
 =?us-ascii?Q?bgTZ/1gHpHJuP47lBaua1z8N9q8nZTN+ZxEO1w7MwfcewyV0WYF+tASrDglA?=
 =?us-ascii?Q?1OtyVHTlMXgwTqFY7HUSc/Hh5fNY4XoVq/Pq6d6NPqv9LgYh/pmhBJOqrwS8?=
 =?us-ascii?Q?p8XFbWg+4SeZi+oMdWBeg/f96nn1OrW8TmHxrEuxTcvpJNHXruwroYli5UrY?=
 =?us-ascii?Q?1kQRi7bGBq8jhfQsBh6pR/dJ62Ou1xWANV+eNvescU1c8TumFFDLeQkiUze3?=
 =?us-ascii?Q?zl0Dj0By/XDooq24N21qvSV9aujjkQx71nNj2SnRAKL9D0ZwGk+/BlkRkCMJ?=
 =?us-ascii?Q?RkM6I0GrREmaGj7L0LswpfzldhJErIELUQz2IrPcaGl6u0H2nO3b8xB5ZG3e?=
 =?us-ascii?Q?VCi+sPNz7e/iS9vnHP2avSBGEujHGuhr0jzi/mdyyTpeCgJN7vmLXvqjvTPW?=
 =?us-ascii?Q?oyGUu2rE7psrlsVfbEbR9z+iegF6sf//C4A0T5xPjBId8FXU85M1gfOzccKM?=
 =?us-ascii?Q?H/3dH3/OFaiaY44crNHAOe53m4AkmsukB4pQeqgiH/ScyfHPvTJYUeR4smNX?=
 =?us-ascii?Q?6powwxjXnhDnrrr4k5mioH2Y5wVbd7WN8XS+eXWiMlgoJTqXx60cv8+B7JWb?=
 =?us-ascii?Q?2gQFPhc5jehGsXdxWnTvJqXZkUbVK1MaxN47Ohy8cqNgRt2q6eaJQY/LNaku?=
 =?us-ascii?Q?C8/ra8aHrftJp9NJKejNaaZaiLY+wKXh/c9mcJ/xy8eRARSClrmDgCpLtATd?=
 =?us-ascii?Q?TuUund4tAV/qymoORPlM2hzTmOQUQDk9cxS0czrm0rgbEw2wSK4KytczkzyA?=
 =?us-ascii?Q?cAyQWG3G6D8yu4BVWb2E+G4/MdMRndSnCWdcRWiWU4tjLm+tVMLBjc8ZatXW?=
 =?us-ascii?Q?H6U7tKaLgzcPBdKql8zaMoDMrt8A5ApZ6vSxgnSJ9eUw1AxxrR88kA7TqTBq?=
 =?us-ascii?Q?dhsgwf0Q3WuXnIBInm2hhSXjGNbi2DBl3MztRdDTKxafHKJ4wJPRLd/8PulP?=
 =?us-ascii?Q?UELsGtdAQGCYTA1KObrDUKS2CvooUqpcdWnb/SDhbpC/F8eozoKQscdQgeQS?=
 =?us-ascii?Q?8idK8UIHnQwiBFtIUSu+pHfXz5NWClUIAS36Kimrf8ueTmx/8n02BxZwPgBS?=
 =?us-ascii?Q?+JvcoqxjOAUO9wAP1jY5fhOFGWJel1Bq2OazghTadX/lbE1dFhNdn6jfwuMM?=
 =?us-ascii?Q?7TDAXnTnxiyM30fvGc13tTegcUkkhhLdZwT4l6aPEpOXTF4EZVKxciIPMJoF?=
 =?us-ascii?Q?+lHMT/TV1FN4EivsCo1lNKuQ0bR5Wd/kp+nxWxHGLLileh8mimGSOCUoTc9z?=
 =?us-ascii?Q?T414bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf81c75-9744-4c5a-f03d-08db571ba1a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2023 21:13:59.0455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cN3GREqLRpHA2+3sz6Sj0BQzdOBfzskUEUtMrD2bANDCbGyOPXRzhHgJRmaoOF3mRId3S0YnM98UByuh1qBSpXHPn0YkAaAb5S2tOihC2nU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3668
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> -----Original Message-----
> From: David Vernet <void@manifault.com>
> Sent: Wednesday, May 17, 2023 2:00 PM
> To: Dave Thaler <dthaler@microsoft.com>
> Cc: Jose E. Marchesi <jemarch@gnu.org>; Dave Thaler
> <dthaler=3D40microsoft.com@dmarc.ietf.org>; bpf@ietf.org; bpf
> <bpf@vger.kernel.org>
> Subject: Re: [Bpf] IETF BPF working group draft charter
>=20
> On Wed, May 17, 2023 at 06:19:42PM +0000, Dave Thaler wrote:
> > Jose E. Marchesi wrote:
> > > As I mentioned during your talk at LSF/MM/BPF, I think that two
> > > items may be a bit confusing, and worth to clarify:
> > >
> > >   * the eBPF bindings for the ELF executable file format,
> > >
> > > What does "eBPF bindings" mean in this context?  I think there are
> > > at least two possible interpretations:
> > >
> > > 1) The way BPF uses ELF, not impacting internal ELF structures.  For
> > >    example the special section names that a conformant BPF loader
> > >    expects and understands, such as ".probes", or rules on how to use
> > >    the symbols visibility, or how notes are used (if they are used)
> > > etc
> > >
> > > 2) The ELF extensions that BPF introduces (and may introduce at some
> > >    point) as an architecture, such as machine number, section types,
> > >    special section indices, segment types, relocation types, symbol
> > >    types, symbol bindings, additional section and segment flags, file
> > >    flags, and perhaps structures of the contents of some special
> > >    sections.
> >
> > See
> >
> https://nam06.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> > ietf.org%2Farchive%2Fid%2Fdraft-thaler-bpf-elf-
> 00.html&data=3D05%7C01%7C
> >
> dthaler%40microsoft.com%7Cddd426f86cb4489c17d108db5719c1cc%7C72f9
> 88bf8
> >
> 6f141af91ab2d7cd011db47%7C1%7C0%7C638199540383552382%7CUnkno
> wn%7CTWFpb
> >
> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0
> >
> %3D%7C3000%7C%7C%7C&sdata=3DhM81uNUjJP2J46eSs6tLPi7B82Z7EhlJrGUS
> 2YNo9Bk%
> > 3D&reserved=3D0 It includes the values used in the ELF header, section
> > naming, use of the "license" and "version" sections, meaning of "maps"
> > and ".maps" sections, etc.
>=20
> I have what may be a silly question: The document you linked specifies,
>=20
> "This specification is a [sic] extension to the ELF file format as specif=
ied in
> Chapter 4 of the System V Application Binary Interface [ELF]."
>=20
> What does it mean exactly for an IETF-published BPF ELF extension to be a=
n
> extension of a specification from a totally separate standards body (in t=
his case,
> the System V release 4 ABI / Tool Interface Standard (TIS))?=20

Perhaps "extension" is not the correct word.   At least that word is not in=
 the
draft charter.  If the document is changed to say "bindings" then it would =
be
consistent with the draft charter, but there may be a better term.

As Alexei explained at LSF/MM/BPF last week, this isn't a change to the ELF
spec, and my understanding is that it needn't be done by the ELF standards =
body,
but I am not the expert there.

> In other words, is it
> normal for extensions to be specified in external / separate standards bo=
dies
> from where the original specification is defined? It seems like that coul=
d
> potentially result in a confusing outcome if the original standards body =
could
> itself eventually choose to publish its own extension which conflicts wit=
h the
> IETF. That won't happen for Sys V of course, but in general it seems odd =
for us
> to publish an extension for a specification that was defined in the Syste=
m V ABI
> instead of the IETF, and it seems like a situation for which following th=
e existing
> contours for x86_64, ARM, etc might make sense.
>=20
> > > If the intended meaning of that point in the draft is 1), then I
> > > would suggest to change the wording to something like:
> > >
> > > * the requirements and expectations that ELF files shall fulfill so t=
hey
> > >   can be handled by conformant eBPF implementations.
> >
> > My own opinion is to leave the more detailed definition of what
> > belongs in the ELF spec vs another document up to the WG to define
> > rather than baking it into the charter.
>=20
> I tend to agree, but that seems to suggest that we should remove this lin=
e from
> the charter, and instead leave it up to the WG to determine if it should =
be
> included:
>=20
> * the eBPF bindings for the ELF executable file format,

Removing it would be problematic in my view (unless we remove a phrase
Warren commented on) since the draft charter says:
> The working group shall not adopt new work until these
> documents have progressed to working group last call.

So if the WG does need to do it, it couldn't adopt it without keeping this =
bullet.

> Or is your point rather that the line in the charter as it exists now is =
really
> saying that discussing ELF *in general* is in scope for the working group=
, but
> that we may or may not end up actually producing a document for it depend=
ing
> on how discussions go in the WG, and that if we did produce a document, t=
he
> scope would be decided by the WG?

Yes, that would be another valid interpretation.  My opinion is that the IE=
TF
should produce a document.

> More broadly, would you mind please clarifying exactly what this section =
will
> imply for the WG (see below for more details on my question):
>=20
> > The working group will produce one or more documents on the following
> > work item topics:
> >
> > * The eBPF instruction set architecture (ISA) that defines the
> >   instructions and low-level virtual machine for eBPF programs,
> >
> > * Verifier expectations and building blocks for allowing safe execution
> >   of untrusted eBPF programs,
> >
> > * the BPF Type Format (BTF) that defines debug information and
> >   introspection capabilities for eBPF programs,
> >
> > * the eBPF bindings for the ELF executable file format,
> >
> > * the platform support ABI, including calling convention, linker
> >   requirements, and relocations,
> >
> > * Cross-platform map types allowing native data structure access from
> >   eBPF programs,
> >
> > * Cross-platform helper functions, such as for manipulation of maps,
> >
> > * Cross-platform eBPF program types that define the higher level
> >   execution environment for eBPF programs,
> >
> > * and an architecture and framework informational document.
>=20
> As far as I understand, if a topic is missing from this section, it doesn=
't
> automatically mean that it's out of scope for the WG to produce a documen=
t
> for it. If that's the case, and part of the job of the WG will be to spec=
ify what is
> actually in scope regardless of what's enumerated here, I'm not quite fol=
lowing
> why this section is necessary beyond providing the reader with some infor=
mal
> context on what BPF is in general.

The above section is typical in IETF WG charters.  And the bit I quoted ear=
lier
about not doing additional things as work items until this list is done, is=
 also
somewhat typical.
=20
> Thanks in advance for explaining these concepts to an IETF noobie.
>=20
> > > Otherwise, if the intended meaning in the draft charter is to cover
> > > 2), I would like to note that, usually and conventionally ELF
> > > extensions introduced by architectures (and operating systems in the
> > > ELF sense)
> > > are:
> > >
> > > - Part of the psABI (chapter Object Files).
> > >
> > > - Not standards, in the sense that these are not handled by
> > >   standardization bodies.
> > >
> > > - Maintained by corporations, associations, and/or community groups, =
and
> > >   published in one form or another.  A few examples of both arch and =
os
> > >   extensions:
> > >
> > >   + The x86_64 psABI, including the ELF bits, is maintained by Intel
> > >     (mainly by HJ Lu, a toolchain hacker) and available in a git repo=
 in
> > >     gitlab [1].
> > >
> > >   + The risc-v psABI, including the ELF bits, is maintained by I beli=
eve
> > >     RISC-V International and the community, and is available in a git
> > >     repo in github [2].
> > >
> > >   + The GNU extensions to the gABI, including the ELF bits, is
> > >     maintained by GNU hackers and available in a git repo in sourcewa=
re
> > >     [3].
> > >
> > >   + The llvm extensions to ELF, which in this case take the form of a=
n
> > >     "os" in the ELF sense even if it is not an operating system, are
> > >     maintained by the LLVM project and available in the
> > >     docs/Extensions.rst file in the llvm source distribution.
> > >
> > >   Note that more often than not this is kept quite informally, withou=
t
> > >   the need of much bureocratic overhead.  A git repo in github or the
> > >   like, maintained by the eBPF foundation or similar, would be more t=
han
> > >   enough IMO.
> >
> > To ensure interoperability, I'd want a slightly more formal specificati=
on.
>=20
> I understand the desire and need for ensuring interoperability, but if sp=
ecifying
> a BPF ELF extension would be the exception to the rule for the entirety o=
f the
> rest of the industry when it comes to ELF, I think we should consider als=
o being
> explicit about what's different for BPF.

Others probably understand ELF processes better than I do.  But I think
the belief is that it's not an extension.  If there is, and there's another=
 place
it needs to be done, then acknowledging that in terms of who the WG will
interact with might be helpful.

> > > - Open to suggestions and contributions from the community, vendors,
> > >   implementors, etc.  This usually involves having a mailing list whe=
re
> > >   such suggestions can be sent an discussed.  Almost always very litt=
le
> > >   discussion is required, if any, because the proposed extension has
> > >   already been agreed and worked on by the involved parties: toolchai=
ns,
> > >   consumers, etc.
> > >
> > > - Continuously evolving.
> > >
> > > So, would the IETF working group be able to accomodate something
> > > like the above?  For example, once a document is officially
> > > published by the working group, how easy is it to modify it and make
> > > a new version to incorporate something new, like a new relocation typ=
e for
> example?
> > > (Apologies for my total ignorance of IETF business :/)
> >
> > There's 3 ways:
> > 1) The IETF can publish an extension spec with additional optional feat=
ures.
> > 2) The IETF can publish a replacement to the original (not usually
> > desirable)
> > 3) The IETF can define a process for other organizations or vendors to
> > create their own extensions, and some mechanism for ensuring that two
> > such extensions don't collide using the same codepoint.  This is what
> > the charter implies the WG should do.
>=20
> This certainly seems useful, but it also feels like ELF is kind of a spec=
ial case
> here given that it was originally published as part of Sys V, and there a=
re no
> formally specified extensions for other much larger architectures. I may =
be
> missing a lot of context here, so thanks in advance again for filling in =
any gaps.
>=20
> - David

Dave

