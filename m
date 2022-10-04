Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F115F45D9
	for <lists+bpf@lfdr.de>; Tue,  4 Oct 2022 16:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiJDOoc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Oct 2022 10:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiJDOoa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Oct 2022 10:44:30 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11023024.outbound.protection.outlook.com [52.101.64.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C30763F09
        for <bpf@vger.kernel.org>; Tue,  4 Oct 2022 07:44:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQBGCKiMahJTIEW645S7UDbd4vvTFWzmqGWDrMQAYv5MSocRa25DmgZNTNgFHf4vRyOX0q7gRPm/+8Aq3po7YmuOYBoLSMJ7byjgcG3+VEfjqaF423wXzHgGa0Q/ZHRr5Ga4J1UrGkbj1cMu4Gnc64fhBk46S1+UK8AksOf42vHzDs3vQMZd3GGRa+UTemTdBKobKVLchDmobuvc8qVGY44LRopoSWQ0TuVElG1RK4YvWXjGDtpE0kwnS0X8UxtTX3RcxBip1kpqnD0uph11mgojzr0Ruc2CpHpBobJs48pOgMWiwgAdzibF06V7l5qa2QQaMXETYhAZyBl01gKknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zmf7APKenwTNCMAK4xVPCEKkKUFhqALO0xaZYzcFvvk=;
 b=Cnj8kwxoZn3+HeS56WSBsjDbKafLTelV/zTnZjTyjOhKwWxAMWE3LKRvvYyJHGk2pJicCogILzDkSQ/+ee2C9B2DG/jMfkYyPtT0jZ38g1Md2Bw9E17Vb/pZdCHMYF0L6VmE30BxDM/4pxhX+VyVz6A/a0V5v4D8ITjz14VgPKh6Z14rjx57kMBQ6ah/D6ubUErwylidmzqzDi7eYJ0e2TqWRFbBPAjgaOsZ2jXdDkX7efLwxuQAw9qZeSa/gV4yX7zDqW1z7c5JyZ6vIK+0I8B7m89x9JbrmFRScf08xv7hy2UEU3JnRyH1e//9Mk1LX2F2PTjCZ0ruyQEb4ggcpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zmf7APKenwTNCMAK4xVPCEKkKUFhqALO0xaZYzcFvvk=;
 b=HveQs42pKdRaDYmaCzwAwYqOKfTP1nmguigflxJuf1exjD/XCqhxz/bISLB+nCeuk1318bI9xZhFktM/NdoDd4rNoQcjoTh/NgGatAUFVWX3dVI5ZokDMvpC838qYeu6DQZ6kDSU7VCw0Et4DOpNJMPUstSoG3l5U+PIDWhyNpY=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 DM6PR21MB1467.namprd21.prod.outlook.com (2603:10b6:5:22f::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.9; Tue, 4 Oct 2022 14:44:23 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::c76c:9386:3651:999d%3]) with mapi id 15.20.5723.008; Tue, 4 Oct 2022
 14:44:23 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [PATCH 08/15] ebpf-docs: Use consistent names for the same field
Thread-Topic: [PATCH 08/15] ebpf-docs: Use consistent names for the same field
Thread-Index: AQHY0qNnuaY+9KzIPkmQVz/ucE4k0a34eUQAgAXeSaA=
Date:   Tue, 4 Oct 2022 14:44:23 +0000
Message-ID: <DM4PR21MB3440239B9ED4EEE652DB183EA35A9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <20220927185958.14995-1-dthaler1968@googlemail.com>
 <20220927185958.14995-8-dthaler1968@googlemail.com>
 <20220930205738.jpg3g5qvjfrisqfg@macbook-pro-4.dhcp.thefacebook.com>
In-Reply-To: <20220930205738.jpg3g5qvjfrisqfg@macbook-pro-4.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=6be04e6d-e4d5-4be2-b536-8605e6fc9d22;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-10-04T14:34:30Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|DM6PR21MB1467:EE_
x-ms-office365-filtering-correlation-id: 7b911d37-eb3b-401b-009e-08daa616edb7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jc94PKSHGoS7aFvQhPAQy92zmkIJF4/mvefscx5ndYX/5Oa59nZFEydN2lvARgQq61xwotW3h75m1mn6w0cQ2YiuzzC4kH4tV7f+osnxFeXQ7EjjUjGELmPFc+7khdcIZpvch3Zi7hvYDpKknPp9BrJb1XTtGFE90QElYhZt1LltFvSXo0jm4PMP094kB3Mp2EwfQ+qPRo2wFhBT30UPh5U7/67jzMAjjouwXIKLSiI3i/zvceAH0jnyyG1vDZbamr13tyruBgTSUyeKNRBFIDlxaSPSpPQK1n8RHlS5Ye8kEsMFfHvpWScqvuXKUG6id3Ss3s2tcd2CEYY9qlWsZUYFEp2jJLFwp9IN0CmZEUS2c8nHXFtNpIOhZHcyRyFBiry1O8l1gZ5sgJs9FhDIyhQTM+onI+rFqoxIbA2+f/R/1fG24XPBmQNIAdalY+yl/PkmtA/+p1L13KhwTRHxXi9yF+ggpAgtd43vqoF//8HeyANhVY1Esj07bm4tb6GaN6ZoWmjlsasy6d2oZnD9JwfXG2tMv+vjp4mbu/y7YHdgu/loUAhkNQEYJDeG/C0d3U7jTL8qk2tbzJbbXOJKMT5Qno9Dldck96J3fJCjy2ZSDTpF195FNrg8ICHw3o3/JPz5c6PbRq/wUCx888gkWaYFyrlRLWuuDZukSwbpzktu+zr3pkarvxpYmMdjmR2R7dBNxxAdVvwbciTxDuElwYLM8GvOuArXo40Vpww8Bi9nFsPnwMkujYqDrhot0TeI8EOQF5dw0PubC5lPcrc+yfkSDMJ8XwVhVwQoBSxi6Le4MGDSv3qdwsvqtwcbct4Y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(39860400002)(136003)(396003)(451199015)(66446008)(66476007)(66556008)(4326008)(64756008)(8676002)(8990500004)(26005)(316002)(9686003)(6916009)(7696005)(33656002)(186003)(76116006)(66946007)(6506007)(122000001)(38070700005)(5660300002)(2906002)(8936002)(82960400001)(82950400001)(38100700002)(41300700001)(86362001)(52536014)(55016003)(71200400001)(478600001)(10290500003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uaMN5ChThtkQpdP/lhJg+5sdNYsNo/hKECofhFkYfc4OecqOyXKrK/ZXwrSc?=
 =?us-ascii?Q?4++Ii9ukX4U585j7mprCxQJiKtxQb9+XQbTzkJI/NI0wZnBZWdtsJqBkn2mQ?=
 =?us-ascii?Q?2zZMyPMWWOxthvfGSGMtv/vxJ2KxGzBiosmmnIJ2umJ1Ol9S8NALoK1uBDdK?=
 =?us-ascii?Q?xyHqVR5XmtTQU0Z5R4tFm5wdoO9TdFg0rtyalm4DAKXf2POk4ffrHtDXGL8P?=
 =?us-ascii?Q?n9PIOHzX+gbTs1nM6HCvglxhKzS1ERKzzacHATrxABItktG0cg1Q1JUVPhPs?=
 =?us-ascii?Q?9NSd5RLOs9KhpvXudxpijtv1B9ZAGlbVL6NK+gXTBdUbAwwd+9nLb8QCE5fS?=
 =?us-ascii?Q?l29yVSESIrcgqkXpPZWYrfWIs4bedufK/qIRcZZ5XRZXV4bpOC7dny9Bhd23?=
 =?us-ascii?Q?qBWUxc4TeF5NHG7Ha1QvXVHGgULm3o53EGuqWI3w2eV/AlKjSu/kjmF2gWfX?=
 =?us-ascii?Q?HsFYM2KhpTZHce9ncYaCtyazCeL4JQ5ZFUp0yEA8widbICPWj67T/QVMKcn9?=
 =?us-ascii?Q?FWA05SBjroBQlUJV7tRMjj97wBM5hoUhntF2NKW8AcNxYq/TdmORahwMjK9N?=
 =?us-ascii?Q?NlGmunqQCMtHasHc201tt3W8SuUP+4aVAABWBZXwU70A4xbvaFlZVJOJX0HG?=
 =?us-ascii?Q?S0wOAyFIm9JCr+pGGhz7IoxkcRFtBU/U9Gasn9/0ghGqYoblDwAd2yG2Pgr2?=
 =?us-ascii?Q?d5OTIFq/T28HlGmZkkLNiNfUbbMF04s3o6NhhJpq0TsCRSN0qybCj1HStzKh?=
 =?us-ascii?Q?wiNRsA69+AbL/Acg61YhbnBZAR+jRLDDyrsj38ppJCqUeLcK8VViNdDySGn4?=
 =?us-ascii?Q?sL8hvIoDGtUggowYcWSel/QNWWHvtbeMjEaRAcgKionG9lyNSzMsSbkiz3xW?=
 =?us-ascii?Q?Xnc0ZK3pKu+AHO7gnba6rgNPL7XQgd4XhAVbyPnhRsLcxxgxVAZlegKjIVaM?=
 =?us-ascii?Q?V5B9KNbcCzLyUjWSxZGaNTzYRU/ry5nu1MRg2tbA2pAerLUzLtdoLKR9pZmD?=
 =?us-ascii?Q?5S34MvGd5Lxp8EdW6rCh9fINWrgrWZeklZpqvG+WmbVo0z066dPHmQiCu0gq?=
 =?us-ascii?Q?D3ZGqyJoLy2nfcMjWZ/Fm9paoaE+IlVY6sn4AnCNYAFWhG1OC/+P0VbKjJvT?=
 =?us-ascii?Q?BpGmNVt1SWbvLh1M8l4MrV0tZceaT4BFlsxPyIjvelAFCNLquKNyAajogW+a?=
 =?us-ascii?Q?vNvc/xtfUAMfOGTmzVKQ7a7CVDdr2XGN0KxhgiMEdlVYztlSvkpTGP7Ywwbu?=
 =?us-ascii?Q?O1KoMgE1cju+DfCrIMHK3rkMZTHMs6/p9uJIv3pFsgd4LDzlCbMigre33JUM?=
 =?us-ascii?Q?2b6KztmihK7+0nMLeUz58BFmAtkKZbBXV8Ct3lsNBvOBpe3XwCQQE4Ld9QB0?=
 =?us-ascii?Q?1WTVr5+oSwrkGUP0DhblRDrRTleHJl6y+6ktDU2z94vYDWYWtcmiezEa1htY?=
 =?us-ascii?Q?UM4ZqqmYLcFJzCvbHFja677DYSLqP9ZBGpOTSJf7NDWLBheOXc7kh8TJtCWy?=
 =?us-ascii?Q?z+GBVlGvps4pcwxpa2El0bFkhoyKQPz7quoxNpgBbzyXTsJlioIIMClsbTzp?=
 =?us-ascii?Q?+4ilvgKlCp/zz/AKUg2dZXJSiR32lpGzKL+f/2qxkI7K++FLyVrhgqeHx2LN?=
 =?us-ascii?Q?kQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b911d37-eb3b-401b-009e-08daa616edb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2022 14:44:23.3718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DhxWc4+BfSVQRGn4c+llWn225E2TEunZFqAWco6+5AiaxeHK7+UtHgtSBsF4TkrWpKgKowBDEM5FJORyITW5rRbwNmrNLXc9Dz0bmfGLrY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR21MB1467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
[...]
> > +src
> > +  the source register number (0-10), except where otherwise specified
> > +  (`64-bit immediate instructions`_ reuse this field for other
> > +purposes)
>=20
> There are more than one?
> I guess we have such section now,
> but in ISA it really is only one insn. LD_IMM64.
> It's one insn for the interpreter and one insn for JITs.

Here the plural is really referring to occurrences in programs,
rather than implying multiple opcodes, so I don't think the grammar
is incorrect.

[...]
> > +As discussed below in `64-bit immediate instructions`_, some
> > +instructions use a 64-bit immediate value that is constructed as follo=
ws.
> > +The 64 bits following the basic instruction contain a pseudo
> > +instruction using the same format but with opcode, dst, src, and
> > +offset all set to zero, and imm containing the high 32 bits of the imm=
ediate
> value.
>=20
> 'instructions' here and further reads a bit odd.
> May be calling it one instruction where imm_lo/hi have different semantic=
s
> depending on src would be better?

I will reword the first sentence above to:

As discussed below in `64-bit immediate instructions`_, a 64-bit immediate
instruction uses a 64-bit immediate value that is constructed as follows.

[...]
>=20
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +64 bits (MSB)      64 bits (LSB)
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D basic instruction  pseudo
> > +instruction =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Thus the 64-bit immediate value is constructed as follows:
> > +
> > +  imm64 =3D imm + (next_imm << 32)
> > +
> > +where 'next_imm' refers to the imm value of the pseudo instruction
> > +following the basic instruction.
> > +
> > +In the remainder of this document 'src' and 'dst' refer to the values
> > +of the source and destination registers, respectively, rather than the
> register number.
> > +
> >  Instruction classes
> >  -------------------
> >
> > @@ -75,20 +114,24 @@ For arithmetic and jump instructions
> > (``BPF_ALU``, ``BPF_ALU64``, ``BPF_JMP`` an  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  4 bits (MSB)    1 bit   3 bits (LSB)
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D -operation code  source
> > instruction class
> > +code            source  instruction class
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >
> > -The 4th bit encodes the source operand:
>=20
> feels wrong to lose this part.

The concept is still in the document, just in the "Arithmetic and jump inst=
ructions"
section since it seems specific to those (i.e., not the "Load and store ins=
tructions").

> > +code
> > +  the operation code, whose meaning varies by instruction class
> >
> > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > -  source  value  description
> > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > -  BPF_K   0x00   use 32-bit immediate as source operand
> > -  BPF_X   0x08   use 'src_reg' register as source operand
> > -  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > +source
> > +  the source operand location, which unless otherwise specified is one=
 of:
> >
> > -The four MSB bits store the operation code.
>=20
> same here.

Still there in the supersection.

These are easier to see in the rendered document.

Dave
