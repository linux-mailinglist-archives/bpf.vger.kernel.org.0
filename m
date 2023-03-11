Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8026B6151
	for <lists+bpf@lfdr.de>; Sat, 11 Mar 2023 23:06:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCKWGn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 11 Mar 2023 17:06:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCKWGm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 11 Mar 2023 17:06:42 -0500
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021020.outbound.protection.outlook.com [52.101.62.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE376A1EF
        for <bpf@vger.kernel.org>; Sat, 11 Mar 2023 14:06:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUYY3HDyCAp7Zb+qzwiY9eePmzsL3ezgkdB1exrhyrmCCPjpJOzD11izRwE8a505H9Ap2YZ7Vmn9ZqNQNYFpQNv4lGKH8E5xpzQlnrPPhCO+mE4mHQ6bQzZvJCD4ozWKxcX5PTNtx9yDDZ96mBSh8xQGksS1ICHylI+1932JBEd/o+rx4QmTWPpGormco3eDglgIH1phscHKs9LT5GZ+el+vqhXTRyK9aMIpsYlWWBVGpJjtnMQ9xusvwurpgE0yYrr/kkFHWx0yzMaj+/AyN2EO0OxE6YdOhzI9xlmPY3sHhPCDVDm4l1f9bs8Iqsp/zVtIlqu7692FXc66wY2uKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nCbYB9DY8zZhl62DLeVz8ShElLORbdMPbpN9xSiUjec=;
 b=OPzpr1BjMz5XQW2Sd/BnxyV0Dbr7CydqWJ5bHGvtuj8l641LK/y++dctYlG55Nnns93QZcMwCpeENltumRKF00EOLBzhsvxHWUMtVbneag0EnnV3rQnl2C6v9jE2hOvKRgR9NlnZgU3Jfd8lpEMa1AufviBojRv5h9ucnQeGAEXFyRVF/zSSSTQls7vMuku9QKiYFASmv1FYgNuNdj7AptrUOnK+hqFkHatFq47bLGuX4cwx2Uy0smUlbZ0L0dbkaku0Fz3i54HaGgBXWxD7PL//YixhKnwnWliyqyyOJ6CMylC58RQy8TNALcnNmfGtkRN7c8Dlyp58AqNNgEhLdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nCbYB9DY8zZhl62DLeVz8ShElLORbdMPbpN9xSiUjec=;
 b=NUmxv4kuxFapsQZK8AxE93Of9yIIfLGZ6jFIpEsw5vGR6zjQK+orfyzSsFya4UlaCQ+ncfCqrJyWSz8ZVWSFwsGDPf4uA/3rEdTEXLHoKspe0ttdJNoZAIc4FpAr/WN6xvX545ybWAT2y6vmEnFY8DIPJxJ7/JmCSUKCY5JqzDQ=
Received: from PH7PR21MB3878.namprd21.prod.outlook.com (2603:10b6:510:243::22)
 by MN0PR21MB3511.namprd21.prod.outlook.com (2603:10b6:208:3d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.17; Sat, 11 Mar
 2023 22:06:37 +0000
Received: from PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75]) by PH7PR21MB3878.namprd21.prod.outlook.com
 ([fe80::4538:223f:7805:9e75%2]) with mapi id 15.20.6178.020; Sat, 11 Mar 2023
 22:06:37 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     David Vernet <void@manifault.com>
CC:     Dave Thaler <dthaler1968=40googlemail.com@dmarc.ietf.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "bpf@ietf.org" <bpf@ietf.org>, "ast@kernel.org" <ast@kernel.org>
Subject: RE: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Thread-Topic: [Bpf] [PATCH bpf-next] bpf, docs: Add extended call instructions
Thread-Index: AQHZU6cgfSRLMPukSECUjWK6Qe/ohK719f2AgAAZ0UCAABDNgIAAAVrg
Date:   Sat, 11 Mar 2023 22:06:36 +0000
Message-ID: <PH7PR21MB38789351F3A3EBE47AD179B2A3BB9@PH7PR21MB3878.namprd21.prod.outlook.com>
References: <20230310232144.4077-1-dthaler1968@googlemail.com>
 <20230311192115.GA332677@maniforge>
 <PH7PR21MB3878BD98FB4A65E5DF3E0906A3BB9@PH7PR21MB3878.namprd21.prod.outlook.com>
 <20230311215347.GA436457@maniforge>
In-Reply-To: <20230311215347.GA436457@maniforge>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=71f4c599-41a7-40dc-a37b-20d68bfac624;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-11T21:58:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3878:EE_|MN0PR21MB3511:EE_
x-ms-office365-filtering-correlation-id: b7f9494c-beac-460d-704c-08db227ce232
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z5lCe670Y8TeFvGJdkZn9wf1MlaDszW1W9eVn70nFLFj0yyVIBu0o78O9pCCz8AWmPqjpqzl4gk0sSVuR7Dn10OgdmF7Qo+vMrpWNFhC06G2jccIHvBhZRrdXkxOlkI+mYV8BG3c9ZIaYH7GB/Xpq3G+S0aKdHC/XK07pFCWMnWpatcgESGP/T+Czi+iXb+6A/GqGoaCYWhXLdpj7J6O6g7fsztmyBl7vhaj3P7XLvhwsd/hF8GNxU6Ou0vhpI5/mHjjvRDfA9OdhFEDxxSq5HMrnVnEst0Scq0iE0IdoLZ7BGmB6EisnGcySSSISdtZvdYHvjtDTTiIp8WKpS+J5NP++/QZedgat3/m80OUdzRRJRcIikRxaHMqgpZYNLBhWir1CQNeDfomKBHDuu8Qf9VyESBkfcO3YVlI3umedWcFVLWqA4OHU8p+5GcFCnslYAh4rvRcWVmfdPheUUFQNbz5mHUK1kyvn0mRf7T+eHChRvDxmoMuMB0Jr54wDpY8LLk6CLqPAPf61htTvFxqDsvMngZ7Erc707ypFwdj7XUrcq5QhJ2H31sXPFdLT8ZiMvkVzr07IPu6bshrNjJqf+Qc+z5QhZhc8NJvPBN/AYp3zYWGGVqA2ToFKCQa9rcE5cjx3AUct5ZvsKnSEkGk7HY9VE9YY80krkKe1JEQRLth9oaEZj2li1t119lN9qqHI6RCvKStFATAMlnpbjSBRdPKcJ4gu4FBUScCPiCzrNVp72aun4TPdaX4KIOzpnxI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3878.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199018)(33656002)(82950400001)(82960400001)(71200400001)(478600001)(186003)(26005)(8936002)(7696005)(76116006)(66446008)(66946007)(8990500004)(8676002)(41300700001)(4326008)(64756008)(66556008)(86362001)(52536014)(5660300002)(6916009)(66476007)(2906002)(38100700002)(10290500003)(316002)(122000001)(9686003)(38070700005)(54906003)(55016003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z3T2Q6EnwF9VZBCqwe/xAob8FJwVEex7Jb6eolc7P7olDpzmFNIFlFw3nDgu?=
 =?us-ascii?Q?oSkaexE6B2tbKR7c3EU4i0Z2Ko/KUI+kgePGIwxuubHHKKhuQRZBfLEKNC0P?=
 =?us-ascii?Q?u2bvrZA+PAzmXrd0kiyW2utywHn28DQp+K/D7Re/2/NlsLDAJJmSHEbD0Y+1?=
 =?us-ascii?Q?r7iIrKSftayzBz54Iq/DdKajOuSiDqVw+JQRoKA05uoNW+hcbcyGX4na+8MC?=
 =?us-ascii?Q?nuxI+LhbTH1jKMrD9qQLG0AwZD0KSdLgbi1oACD4C9AkfF2aGBoQ33eYDzMf?=
 =?us-ascii?Q?DcNbaS84VpphBOysgRONGPt/cAlmPcXEs/QQrzFiNZdunvQiMPcWfwVINvKj?=
 =?us-ascii?Q?eeuybnt+q02NJq7KA8THXPK2qo/Ehgs/S2jnWywcXMFm19QDxFtbqko8Xq2z?=
 =?us-ascii?Q?cM5w3y2gEBGfy5JWiW0KQBSUewR4UIGJisBBKeTIFG3wtebPkfsMi4YXVjQm?=
 =?us-ascii?Q?r6I3UsywgIwOUwsmNHAHHlPLv7d+r9DeRu0RDr/sy6/A/kAd/kyaC1LK4Yr+?=
 =?us-ascii?Q?2KFfXe+krlT1r3E1HOVI3VFI6aqN4wILwSoTsc3EQbp+pWaegq/LT7Von0jd?=
 =?us-ascii?Q?ZGm6j5V+mhscbyTQqTTprR/qqV3P1aL14/6/zw5kbEXRQyOYq+E4aFR6agcf?=
 =?us-ascii?Q?POAGvY/ihUBDjKClyLgKEPPaAQxSfHmERT9naJiXHPBQd23/zkrTsJwkEic7?=
 =?us-ascii?Q?akGma4bAJgiv463Pwmul6bQ3bWYIcYavKJZpLEtGCUnJQ7IslPszeIPTIfHm?=
 =?us-ascii?Q?9zArR3CbAJLf2B3NFZhV8PKksT+wp15WRdQ///u174WxGQFK9wp/yK4rMWN3?=
 =?us-ascii?Q?yt3xny9q4/bjUJBiPMNpir7LMrmA6Ay4di5Gx8rw2+1HCYRhyxtgBwfPmK6d?=
 =?us-ascii?Q?eZw23bcEl+eAQelol72xMv0L/SLhOP3t6SoMiCy0KskDY76RNSkI1FazfvTU?=
 =?us-ascii?Q?92LxL2yGJB5qds+AjGu26NE1OlJvOplcNarex5L7kUOTW9ur2PrMCcweZTqB?=
 =?us-ascii?Q?+xakyObIjLS+Jwx6c3ua3kCBzf8gZeasgLJDeCwqd78WVt+I9Eh2pwLph2HN?=
 =?us-ascii?Q?NqudSMR2amiQ3bNJJbgvqi+KuwJTqNpd577TrDnrHk7bOu7PJ0c5MJGKvY+p?=
 =?us-ascii?Q?n6krCn5m9pRdFb0tPPjxNf5gSxm4wRYRXo2POBlfbvWNHyD1Jabm/47SBBl2?=
 =?us-ascii?Q?e6S8HIETJg2ljoUi2DmHvN4DA/pdIutxyHF5/mlruJzkTUKu4f3144wsu9EO?=
 =?us-ascii?Q?bnW6IUAXaRUeeVTpQBEKiDtHqmmASz39cuueX4VFSzsRE10N0EZ9XfYW6lnl?=
 =?us-ascii?Q?fDMfqI+IbD1HBlhvCaOeqrDMAkC7PANr5zemX+FUwBiy6qx7EyNEAs6elzmK?=
 =?us-ascii?Q?pP01jv5nqOe3MfbK87yYQ4M9Xe8AWfiwC8LCTv1GjkGwnzDwp66Sc7Qpraf4?=
 =?us-ascii?Q?s68C9Y1/7awaUj7F7rG7bEi0oXxVTel5iquejUrJGkEniwZEfev08/tHXveW?=
 =?us-ascii?Q?sQYemOToXH1yM8EZINnKCoYGqL/O6zXKmpvHkiAMmTdtNGA7tL9JAh5wRzzu?=
 =?us-ascii?Q?KnCT+XRM/v0rgTWunxpuMg2ekXjLhFfVRlYmU7IIcRI5wZrvNz42BW/oZetR?=
 =?us-ascii?Q?rA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3878.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f9494c-beac-460d-704c-08db227ce232
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2023 22:06:36.8677
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ackS/FO65FIK1Jz9dAmFm+S962uy+NddTlaTCRh3/p8CStjZMki4xZ2xV7qvFQviOjle5K2kABwM6PbePBbnf/e4IUPTakJJOZUQQp35TJc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3511
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

David Vernet <void@manifault.com> wrote:=20
> On Sat, Mar 11, 2023 at 09:00:19PM +0000, Dave Thaler wrote:
> > David Vernet <void@manifault.com> wrote:
> > [...]
> > > > +BPF_CALL  0x8    0x0  call helper function imm    see `Helper func=
tions`_
> > > > +BPF_CALL  0x8    0x1  call PC +=3D offset           see `eBPF func=
tions`_
> > > > +BPF_CALL  0x8    0x2  call runtime function imm   see `Runtime
> functions`_
> > >
> > > The names "Helper functions", "eBPF functions", and "Runtime function=
s"
> > > feel, for lack of a better term, insufficiently distinct. I realize
> > > that it's very tricky to get the naming right here given that some
> > > of these terms (helpers + runtime functions) are conceptually the
> > > same thing, but as a reader with no background I expect I'd be
> > > confused by what the distinctions are as they all kind of sound like =
the
> same thing. What do you think of this as an alternative:
> > >
> > > 1. Standard helper functions
> > > 2. BPF-local functions
> > > 3. Platform-specific helper functions
> >
> > I like where you're going with this.  However, the fact is that some
> > of the existing Helper functions are actually very platform-specific
> > and won't apply to other platforms. So retroactively labeling all of
> > them "standard" is somewhat problematic in my view.
>=20
> That makes sense. For what it's worth, I was envisioning us specifying bo=
th
> the helper number (and likely the semantics of those helpers) in the stan=
dard,
> and just skipping over any which are Linux-specific.

Outside the scope of this patch per set, but...
FYI, in ebpf-for-windows, we do not currently have a goal to use the same i=
nteger
numbers as Linux has, only the same prototypes.  If there is a strong techn=
ical
reason to do so, it can be considered, but right now I don't see any need
to standardize the actual integer values.   We claim BPF program source cod=
e
compatibility, not byte code compatibility at present.  But if the standard=
ization
effort does see a need to standardize integer values, we will accommodate.

> That's of course assuming we do decide to include functions in the standa=
rd,
> which to my understanding is not yet finalized.

Platform-agnostic helper functions are on the proposed list of things to
standardize and for ebpf-for-windows, we do want to standardize a bunch
of them that are now common between Linux and Windows and in my view
make sense for other platforms too.

> Regardless, I'll certainly defer to your expertise on when it's appropria=
te to
> use the word "standard", and I could see why it would be problematic to d=
o
> so here.
>=20
> > I do like the idea of using "<some adjective> helper functions" for
> > both 1 and 3 though.  Since we might not choose to standardize all the
> > existing type 1 functions, maybe "Platform-agnostic helper functions"
> > is synonymous and pairs nicely With "Platform-specific helper
> > functions" as a term.  And then we could just have a note in the
> > linux-notes.rst saying Linux has some platform-specific helper function=
s that
> for historical reasons are used with the platform-agnostic helper functio=
n
> Instruction.
>=20
> That's a reasonable option as well. The only thing that gives me pause is=
 that,
> as you know, the plan of record for now in Linux is to have all new BPF -=
>
> main kernel functions added as kfuncs. That includes features which are
> "platform agnostic", such as BPF iterators. I know you've previously rais=
ed the
> idea of having the traditional helpers be used as standard / platform-agn=
ostic
> helpers in BPF office hours, so this isn't out of the blue. It seems that=
 the time
> has come to discuss it more concretely.
[...]

Yes, my view which I have expressed in the office hours meetings, is that L=
inux
can do so.   But when the time comes to standardize something cross-platfor=
m
(platform-agnostic), then it gets an integer out of the platform-agnostic s=
pace.
That means at that point it's not a kfunc, but a classic helper function.  =
But
they can start as kfuncs in Linux and do that once standardization is done,
potentially having an integer in both numbering spaces if a breaking change
is undesired.  Other platforms, like Windows, can do the same thing with th=
eir
platform-specific helper function if one later becomes a platform-agnostic
standard.   I don't think this affects this patchset right now though, but
may affect future ones.

-Dave
