Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C938C67DC2D
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 03:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbjA0CJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 21:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233558AbjA0CJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 21:09:33 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2104.outbound.protection.outlook.com [40.107.93.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FC61ABE7
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 18:09:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh+je7Dm7GcNvZQqzv3X0x0T7H0E/U246UEHHXeJ3BNNLNsqHL126jkYSNdOSyiHq5CgoXnFFkAiNojlKZU9f3B1LwUj5YdeJ74mhsjpAOAMncOKPBMJMhErPvbusxCDdVpB2eMNiRjP7Vx+3O8v+DH/6fHJdmNcDEGNbzTWPwyW20thpIC11VITHrzIqBP2xy/f7YQz+46KWLhqSgevCttrFQrWr0qY4TFL/PSIJwKI5HJA5IUby8j/pSAgdNoslov2USlqo01Rx4VzUMU7cPyDhLvx//piGzzX5qupDWpExhPDotAVFfIksWsvL9dw0b7hljDt18t8+82zuU8szQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udvfR4A4L1+EgEpZmku4Io9iYIjmmuqkcv8Jy9zCzS4=;
 b=elZdDkWB6tMvNSFyv3j5lGvRijKP3R5cXgiI766zRgXCtM691n6hEvdn40TWRvN+d20awdPuGY37R6s5ypeTco5KZXDIC9D/qo4rl6DCLGGBFFLqjjpxImGHE6Q+I/e7jTPOQyNfaIuROI9mF++9z+R2tj3gknyGz4W2UyK/TR6A2iK/zYe7TUTmcD/K9JX424i05UxSDOOy54hFqx8Wn9DPCevn9vyvJyq34u7ve+EQQOT2CfDZW8o0smkd4sKiEqJjkNjfcZLeI5KlcKDdGQJUkMFqvhMk4bKZe0O6t+zcm8gQJ18wNrkEh7V4gnXHHyXs8KwMCLHTYD+Bg1gvPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udvfR4A4L1+EgEpZmku4Io9iYIjmmuqkcv8Jy9zCzS4=;
 b=TSOPXwv0pBegEasfcMul9SpnATq6oZHswp/HVvjmA7mS5fE8GCtcARq9Q+TrnPzfY9bwf+G8ddH+3x9etRnH3ZilhxHi2L0zzNNmI/JAv7A9oYO+0iCzxQSpEYtWW3cVDkCDndTnp872cv1rntbkS/9M8BFAzoJnFKeJ+kvgQqQ=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by SJ0PR21MB1887.namprd21.prod.outlook.com (2603:10b6:a03:2a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.7; Fri, 27 Jan
 2023 02:09:28 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::7d5f:74de:b40e:903c]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::7d5f:74de:b40e:903c%6]) with mapi id 15.20.6064.007; Fri, 27 Jan 2023
 02:09:28 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     David Vernet <void@manifault.com>,
        "dthaler1968@googlemail.com" <dthaler1968@googlemail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>
Subject: RE: [PATCH] bpf, docs: Use consistent names for the same field
Thread-Topic: [PATCH] bpf, docs: Use consistent names for the same field
Thread-Index: AQHZMO8BkWkqOO667kmeFLdMO+BgX66vknIAgAHvpMA=
Date:   Fri, 27 Jan 2023 02:09:28 +0000
Message-ID: <PH7PR21MB38789524AE1609A864894A04A3CC9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230125185817.6408-1-dthaler1968@googlemail.com>
 <Y9GOiIbWz5mL0nSv@maniforge>
In-Reply-To: <Y9GOiIbWz5mL0nSv@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=bb0d64b7-893b-4073-b515-9b03986715b0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-27T01:52:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|SJ0PR21MB1887:EE_
x-ms-office365-filtering-correlation-id: 87a8c9cd-c508-4532-3c34-08db000b8543
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bVgOcv4JwkVR1jhIqkjD5KyAKsqPuZlYhekJVyacbKQ10R8eodUk/iw9uW35YUZs6XpJB2OgelHpu3w0b6ypEmxJysNcm2Cgs4bGbC4K8R/3JZFASago6Yefo2lNVLfr+ZF+QV6iDHaA2Ro6ZMcfZeswfruq5yjr5PxHQTHIZEfJMCN0TcfGJrJyq4ve+eOf3zMRfFlDH8Vs7qUGvgwTPEG+xO+nabQJBS/2PR2YOXfL46YxKqEEjtuwpVUF70PIXJrlRnKQr113lzmL63lYcot1aqWgwabzj/oUslSJaEMj55PGeGI0v0VnvbwiGi3r8dEgqUD3/FzhsTT6DW+B9ehQgy8kIVb1l6eVkf1T9ulkWYmOz7k4zV1oO2RnLKLlRgcQzrJu/GmOW6tIcomLuNmAIjkUbZ8RY0Aj3QbVi6b9QlgmcgXG2/mslsIXQYtdUgLKfY+yAA1zrDZksJfWF6EdRagbJPfAyxvJOTvD4wMOocIBqaZ27IA2PMRICsO1oonEK4/FDxjBoWMrAVsOYzyiEcjgf/LCbqeLETjL1w+BS0sLpn+d9WlKl9ReojyyA+4PpRAj1XvDn/RD9yENw0eV3lqEPhQMmmpaAwhSOH8Lvjz7V50m6DlMmo9ZioUqyEuMAziuvkSlBihDqW7FGcw58Q1b6gTRzC4a/gA8tnWd7CwjZKHUEN2ro9s4Cu7zovwGUgl5pKLKWQLh/WY0D9pOKPBa5BAEECQoJ7+g9x3YXnyesBnRGWAFiKdHV08oYErc3/IOp9Sikv5BCBcKIA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199018)(2906002)(8936002)(41300700001)(5660300002)(316002)(4326008)(64756008)(8676002)(66446008)(52536014)(54906003)(8990500004)(10290500003)(110136005)(71200400001)(6506007)(7696005)(478600001)(966005)(83380400001)(9686003)(186003)(66946007)(66476007)(66556008)(86362001)(76116006)(38100700002)(33656002)(122000001)(55016003)(38070700005)(82960400001)(82950400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CMZfGKoSuY7AkRtU8fUG2XPbJA+DqJzWMdEWhL07Pmsz3ZHNKymkzJE3EfbQ?=
 =?us-ascii?Q?0gkcc/+ZgvjDm2Xv1GIP1VEfYZ8shZS3VmJ8oLlrYDj1bnyMXI8nrr5Rsag7?=
 =?us-ascii?Q?kRUIGup1HKvyNO6LY3Iz53cDk73uHiMM8h4DcXYKH02wC6lYtubZMGTTSZC2?=
 =?us-ascii?Q?vwQbzkm4K7lKfg/W2gsgWG4Co9nxeHeDgUJxv9IXhzCz22Y2MsO/6YczJPe5?=
 =?us-ascii?Q?CZbW1dF3V0rQVr7XmPYXDXWGcBClUlAkdXJBRFxirx4baphTJhhOm9ND4Bkh?=
 =?us-ascii?Q?he2PsBN7LdEQbhxpauVbOFrQI/hGU3Etuc98WHDacSB8ZLRJVDYCv91cTIy4?=
 =?us-ascii?Q?CmapGZRXmqAAFxKQXt3i5Guyov5NvoUHi1GMOObjvtAnyhzfYjqU1oilWBNW?=
 =?us-ascii?Q?sLAoyVYD+whkuAemn6gJVwA9FcFMWUOT/a7CU+W/7EPFfWFCkFhK4fLJHcgX?=
 =?us-ascii?Q?8GpV/xkbHjbRezApItbQGeCcuyfqr3BBI5xt7KnDUwAxOwKonW37/VW60zIj?=
 =?us-ascii?Q?O5rNK5QZbeL0kLRG0MS2tbOe5hVLYVluqtk2pGknRy1EWLrFq7k0azmRbjlh?=
 =?us-ascii?Q?PpK1oYDntfZYThdLKzs8pnmTUWnA8fAwznzOQrKIYxr4eXcH6TwzpIqaW/mW?=
 =?us-ascii?Q?nHHhuy4IgMNdPKVO7Rh5jtdCHDPD/nz9H1OtbZu138EYSONfYvmnojzCejkI?=
 =?us-ascii?Q?Don4+z6xTCosMhbA7j/IKUDATHKif/w6lYQsfFE803lvoCS7I1Qk/dRvf9Jl?=
 =?us-ascii?Q?IhRm/59ClzMoYaRjK72OxJ/IriepbtDx76oaNd/GOJFP8uoXM2qaT9l+Uots?=
 =?us-ascii?Q?MtgikCBzpzDoLO66rDb7VsBIuP57Wuh0FjDckhqcnJVC6ebVAJiZPSs1ag20?=
 =?us-ascii?Q?DW6fVKCft7Prj4DZPteO0O9l8NHWmzh2aBGdTmzK/DsG/0hIjNWMhfcp6Y6Y?=
 =?us-ascii?Q?Sz8lTRqDf8jENOeb4T79+yzaM/fSDuhFBfwZ6IcDx/DgxVRj2Epm9yLvuuUW?=
 =?us-ascii?Q?c3ntDlyPgzhfbGwPOuSI49d8KaP8YNuNlH0d2wfPDISD5Y6e5V70xUwdB/ED?=
 =?us-ascii?Q?BsnVRD/KdiZd3UN+aXvi1BoiRvz+Pbbu4dpMhpKLmpS1hAkhujwjtS5ni54A?=
 =?us-ascii?Q?L2CfAqKV60f7fGyOrXLoQABlFQLePhxX71p1EQQYIGuoqhV8Up2N2UXb6g1E?=
 =?us-ascii?Q?/aXTIMp30EIdyHVKpKuKatLKdFr2p7cAGiYBB9lnXwIi1mvMveTyO+k9VqtG?=
 =?us-ascii?Q?HH/RhQekIUl3i8vZ8MBrOriHEQUJrs/n45s2L1s10/akkfAosvcC4HEhM2BS?=
 =?us-ascii?Q?/ayaRehzSRUnWBxLee81ON9YJw/6hmzaaS9b6Q8CB2K/+FcPjLgDls0MYLuS?=
 =?us-ascii?Q?RQkchYz42ec84mzf8e45ZfBvIYOv8qd6zhUf9apt5w2ESigP145hEdwB+coH?=
 =?us-ascii?Q?8CrNl+CSbNFYknO8YUX6Mj2Jfaof6hqR8g9dWD/wloq1LWXPaa0zlRhQ5TOn?=
 =?us-ascii?Q?SmOQFdUjbj4UuGQBUZC0Nx0BbEPmh3E9E9WEG8bGKPlouMH6z+M0ZNTHonhc?=
 =?us-ascii?Q?m8y+ury1OR793xfIsEnUe95I/gl+vtdIbeJ3+FkH+8hE/Nf679FLrUiKv6D7?=
 =?us-ascii?Q?jCScKYgikamJoEJ/k5RckxH3n0iYO+ljkS5GoLGcrRKV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a8c9cd-c508-4532-3c34-08db000b8543
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2023 02:09:28.3317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s3g9FeD3HYduHBsoUCl2PQGYDlc7CCniiIm6ZPgd4Qy/kaafoKOngW5SRPY7UN9Ll8XGJ51Qm7ge4TDuc+SNo0PrIMOoZfGVSDVwnbrjvmU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR21MB1887
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> wrote:=20
> In the future, if sending subsequent iterations of a patch, could you ple=
ase
> follow the typical versioning  and changelog convention described in [0]?

Thanks for being patient with a newcomer to this particular process :)

> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  32 bits (MSB)  16 bits  4 bits           4 bits                8 bits =
(LSB)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -immediate      offset   source register  destination register  opcode
> > +imm            offset   src              dst                   opcode
>=20
> What's the rationale for changing source register and destination registe=
r to
> src and dst respectively here? Below you clarify that they mean something
> other than register number after this section in the document, so why not
> just leave them as is here to avoid any confusion?

Fair point, will update.

> Can we make all of these bold, just to slightly improve readability.
> E.g.:
>=20
> **imm**

My view was that it was up to the RST renderer to do so. For example,
if you look at https://github.com/ebpffoundation/ebpf-docs/blob/update/rst/=
instruction-set.rst which is what I used
to validate the look of this patch plus other patches, it is already
bolded because the github RST renderer bolds definition list terms.

On the other hand, https://htmlpreview.github.io/?https://raw.githubusercon=
tent.com/ebpffoundation/ebpf-docs/pdf/draft-thaler-bpf-isa.html#section-3 i=
s the output of RST -> xml2rfcv3 -> HTML
doesn't do so.  That could be addressed either by me updating the
RST -> xml2rfcv3 converter to automatically bold (i.e., add <strong> to the=
 XML)
or by adding an explicit bolding as you suggest.

I guess the benefit of adding the bolding into the RST itself is if there
are other RST renderers that don't automatically bold definition list terms=
 but
we want them to.  I see other RST files in the Documentation/bpf directory
vary in terms of whether any explicit bolding is used, but I see maps.rst
does so, so I will go ahead and do this and make the RST -> xml2rfcv3
converter map bolding correctly to xml.

Dave
