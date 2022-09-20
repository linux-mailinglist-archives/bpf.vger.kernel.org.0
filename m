Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E2B5BEDEA
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 21:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiITThp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiITThi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 15:37:38 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-cusazon11020026.outbound.protection.outlook.com [52.101.61.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EDA76758
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 12:37:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kID8vt/8zIQgEWZSqZxtlu1AOc9rCxVAiWw0+UIhlIjC9QVOPeMMC+2VG2O6LGX04Mb3pP4pN2x/HvgjJqJ8UVCXiSq4/7H3wFgCuXLTKdRSes3iIi/AtnRdtGMENYb54oHkUxWwsbf2rM1b3RnisuNinSIgswTc6fGW+ErA9BNYZ2CkotUf4vXNdux8yYedrJrbW2U7q3Y4WPU2WI9+zxHmjmkK2Tmw4lz7EfglDcum0tQb5YrVBTvYhPbhgviSIcliGzeBB1rD1+QFoWxDBa/Ij0P3uxdyI+lQqG0LV1AqS2px0hxvx1GwGuzU/Fwu+ZBV0yUxqk3OeSLL7x/rgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmZ0G47+lR725ujoqFimczuB56TAXoaXP+DkxSj9GWg=;
 b=ihoguOky2hVAZR+8Su9YamXOXCp60zwxaKw0sBaa2lFwUFR0VZonE0AoMNsH8QeV6n7MlGpmI5LGIVFLB2fczy/toKxIPYjEActTyZ7DeaeVY2NtNQ52W6CcYwo2C0oNOtkfaHiJUNJmR5szE3EnV+YVwRNUZYkzGZNqtlHts9oQ7hpKXlCTnCByk6XOo9MCMEfSAyh81amB17eyfGWcmGtxVX5Ggkj0p2LnWpknV83KWGjQyiy88wzpIhvUjKKHEb/t01Slz5S3OGPnmVkh+i5VWNmx9+Q8qVGGYThrHq/sKgvI9MYHTg/AIK1Ux98QgHxn5r5cV+a9+DhkzfLvZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmZ0G47+lR725ujoqFimczuB56TAXoaXP+DkxSj9GWg=;
 b=A3o8EqWmKSWbFynrTf8tDXZvh2Myq+cijh85sFAFfhZrhdlAJwTOxeTedYDHvg0mrjNP9U98J0d0frUJ7KJykVnvIjcVNDAaJZyJHKeIhDPZwX9PcJ+4rbm4NfhS7fB0qD2Vgh3mYH84Gge9qTaSnx2Q4XLR48Vz9cz7OsiIjYI=
Received: from DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) by
 PH7PR21MB3143.namprd21.prod.outlook.com (2603:10b6:510:1d7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.4; Tue, 20 Sep
 2022 19:37:33 +0000
Received: from DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111]) by DM4PR21MB3440.namprd21.prod.outlook.com
 ([fe80::5872:7dd2:2a86:c111%9]) with mapi id 15.20.5676.004; Tue, 20 Sep 2022
 19:37:33 +0000
From:   Dave Thaler <dthaler@microsoft.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     bpf <bpf@vger.kernel.org>
Subject: RE: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Topic: FW: ebpf-docs: draft of ISA doc updates in progress
Thread-Index: AdjEi0anVH25Go4YTCyzpO9wKsLa4gCvUITgAUAd8AAANwVhsA==
Date:   Tue, 20 Sep 2022 19:37:33 +0000
Message-ID: <DM4PR21MB3440671C5D0E203B95EAF6B4A34C9@DM4PR21MB3440.namprd21.prod.outlook.com>
References: <CY5PR21MB377000AC95B475C47B702293A3439@CY5PR21MB3770.namprd21.prod.outlook.com>
 <DM4PR21MB34401314FC9285A9F5A338E0A3479@DM4PR21MB3440.namprd21.prod.outlook.com>
 <YyifpJR4uwZwvpkc@infradead.org>
In-Reply-To: <YyifpJR4uwZwvpkc@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=4ae40aed-343d-4943-812a-6243449015df;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-09-20T19:13:37Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR21MB3440:EE_|PH7PR21MB3143:EE_
x-ms-office365-filtering-correlation-id: 8346106f-0697-4a11-8c20-08da9b3f9059
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VEwY+N9bfxafe2XcV13iyUyqBqH457yg8Sk0JAIVjiwiyRWbkHEDkh3jelQ0L2bVQ4uCh2BYCAcVq/eUJ2e8yNiZK3apKBVbc1HbQwr1F8uksf8nN60R3SQ140uHlVNjR49l9ykumnPqgCrHi8g3SwETinBWMIs3NWN+hurIabmR3zaCnX3CbLhWmrahVKmxGnqqIDm1wJfCQ3b/q38MPlZMJiFHSCSnY0psP+TzHY4ERYSbo4YLCdzB4GA65lfffH/5mGFa8gkwFCR/GtQyo3huZIPHE9HKd7v1Z+2yLqYTN2ElLvfau981UG1RWBejRuGQoLEVJrAY1JlZlIifsFin3s4bPTAwwb+WfllE3lbOcUdzNL6Dt5lMxrcEt9wFeK0vJF9F+xBEc0XCilV6FJY/XBcd1pgNwhMZjzzv+++IY0EF/C7TjW5G9Omt0T2Dn7Aakk25okKSPVmkq2JOPBYgMUL5VASxYBAVM4MC1HCMjzkEQgzGeC6Eho/R0L0dpHZCtpnarKyK/Rhtb0lmesomQ2pnbHC6r0WDgjc0BGrj4OqAfB5NakQDtmP4v1qVqXp7sKT1RvEkTdKxceTDAClXDaQgp2NjIrxRvnrEgZqbD90fcMp+gem1S8qBPBPTt4ubmbIJW/JUkFlQKNbmBElNvbxkBvhOKD8vSwd2xPBSj41MqPfK8GDsgjy5VTf4o0Z9xms/mxrrM+TbDx/kUnGbD8K2Bb/gb/L46ohF43aM1V3+zsbTsnwPlxb6rnOz04FBAvYXEjetYICxe0quNiMyUDJ4SAPNcv02YmrRJTPXalbXdQoM5F3fkdDUtpy4owpxZrpjrf+NFxMuenwHZ5OXrs+bKMjVN8aDARmb2eCdYVGES7uAM3viF3dWE8L8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR21MB3440.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(451199015)(55016003)(26005)(76116006)(66946007)(8990500004)(9686003)(4326008)(8676002)(66446008)(66476007)(66556008)(64756008)(71200400001)(82950400001)(82960400001)(8936002)(38070700005)(41300700001)(83380400001)(52536014)(5660300002)(7696005)(6506007)(38100700002)(966005)(478600001)(86362001)(122000001)(186003)(33656002)(316002)(10290500003)(2906002)(6916009)(15650500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Tsgx/nE+jy/UnH7ugrJe8JoTNJkQLSNC2B7QepXNqwtTCyuBbEei2PTgV0?=
 =?iso-8859-1?Q?HVqkHmMX47xAvPjT5BicscecCUxVhFIPsBGcgHjPfn+oh3mx2A7hL7rC8j?=
 =?iso-8859-1?Q?IWtUVWoFyDjzUNRle7tmJdvy6OM+oK4ldDLHoZ/6oMcSFLmwolDT4Fmfzj?=
 =?iso-8859-1?Q?w/OJCwf2SwWHV1nkLBpbIYzrZjdaprrFrMU6fgWwfr0jQZvYKqtbjkaJVL?=
 =?iso-8859-1?Q?5zvTAg+iwQu+2gG6uS4al3g/0LSEk9RGB/v84vA8pCjVincGXSxW7fq/0l?=
 =?iso-8859-1?Q?iExFfhv8ZKcq/AMwzIYpJzE1wHjWZBKPqcL/8N/PMfb02nSrApKTbhaDnM?=
 =?iso-8859-1?Q?ApxUMY8dvyO7fTXcve5ecczZKKqPPaPlfOpurUfT+mwvi99hgrexFKcg5/?=
 =?iso-8859-1?Q?UEF8+0kp08kYA5grpedlzYJKdPDQ0MKz+PW+KcScwfNWhIj7Hqbrykg0Vb?=
 =?iso-8859-1?Q?eix5OJt8YhS1XwJ9NThRv/TMds1c/bUZne0tD0sIVeCS69cF5gzbLeR2Ry?=
 =?iso-8859-1?Q?+eGTFJKjgpdxdFOkm+j6CGm46swpGyiB837XjlEyhtMznyY0NV3e3hXPY9?=
 =?iso-8859-1?Q?DzOzViK7Vh8arNz1JUbxPTbFqD4nVRwdJrgw01SIOQmViM9jA4k0LwJvKZ?=
 =?iso-8859-1?Q?gO022w5OQMLnJYeyzDMLNG/DilNxySAgUFcoqvK4Ab70nMtahUHhtdPZV9?=
 =?iso-8859-1?Q?VKc3y8lmA4i5DnDu/Am0wacyBe8FcK22Mg4aWgAOS7abDhtyQfuQMlGZbW?=
 =?iso-8859-1?Q?WwAza3pcL+XiXrnL3MMw3m0QDpqmck3a1GhVGvQ2UnGurPmUbk0Pu2Esm/?=
 =?iso-8859-1?Q?+nVZhqdvOOqJ9qsgQ3mR6LyJNfj2n49VmlLD7ndvaIwamOJb7EHSZ6GwiH?=
 =?iso-8859-1?Q?N0F4nOiNbsZbN6lbNkl7mVOkFqmCPiNr1dBeIO5s4/Jfre2uv1DlUk//xR?=
 =?iso-8859-1?Q?wtDRc5oA6YQRjuXpic1TXPVJ4dk5psaORw7lXDtyTIOjKdDdxYqyxIUsxl?=
 =?iso-8859-1?Q?5VTaTUvK+2FzC3TzV4pEOnicS8792qQjL/zy5mCgF4X+VaXFaaxAV2b+hM?=
 =?iso-8859-1?Q?BW8kUaP8mnRMAbn6POQyB2fmVAHlbb2/slX/u06CK35vQ1kVjMQEYeOQAZ?=
 =?iso-8859-1?Q?e8WXDVSavNE+Bo5SYfemFDK7WTpKfLhQxJbh+QXF/oShaFBUEKs/Vl6CmQ?=
 =?iso-8859-1?Q?c+qsLsfthyzdZD0gecQOIOepxe/6j+sa3yFRooPA+GJceZhskEWNl9o8kZ?=
 =?iso-8859-1?Q?DvAddmHJAQ0uGff1Y9yWXIiZLqNu4zeM/UMrd2Im8tfyY6iVpg2UDNv6DK?=
 =?iso-8859-1?Q?KHSYeIX92uWSBfUd4w1/i3pjxqUGeuuHXFJZG5rL8r7E0XymDf9rOYWCV2?=
 =?iso-8859-1?Q?20N5UV8ckclwZ0DlKaxqCEIKmYZe41C9m1g7c1hFhBKRg2r0t8X4U0PSJe?=
 =?iso-8859-1?Q?6cx6TlLhucTrc4BOlftCUrdmhz9CdUJ8ByyLH9RRI9XBFgSF1Cd47yLiIC?=
 =?iso-8859-1?Q?fuhsc2pfCr3rc4CIVLbFhFR/93dxQtfLlIExe9WF6QvCa8GTeOwp0QLdiv?=
 =?iso-8859-1?Q?dmACsejkyUgJHpB8/2b9RBNlPuILdutfz0ZqVRQncaw7tXYEmmgoUB+KEW?=
 =?iso-8859-1?Q?eLYP6ZexQ6iJO7Ys/8Yf0E10WRDid615KCidUzhVQ6bH5UmKF3VKOyow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR21MB3440.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8346106f-0697-4a11-8c20-08da9b3f9059
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2022 19:37:33.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3XhpBaKdRcEaeZeKVTR8j166nCMFYmESzIF0YklC5SdohHHYk22bs6laSrZBDmEZV7YkQUbE84Pisv3+iHGHwhf85bnNoGiYvLLwbLvqxNI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
[...]
> > +The current Instruction Set Architecture (ISA) version, sometimes
> > +referred to in other documents as a "CPU" version, is 3.=A0 This docum=
ent
> also covers older versions of the ISA.
>=20
> Hmm, I thought the versioning was a bit more complicated based on the
> mailing list interactions and the call.  Especially with things like the =
full
> atomics not even supported by all gits.

Yeah some features, like BPF_ALU, are optional in some versions so yes it's
more complicated so some things have to be described at the granularity
of a feature.

> > +=A0=A0 **Note**
> > +
> > +=A0=A0 *Linux implementation*: In the Linux kernel, the exit value for
> > +eBPF
> > +=A0=A0 programs is passed as a 32 bit value.
>=20
> Is this Linux, a specific program type, or the ISA?

https://docs.cilium.io/en/stable/bpf/ just said
> Register r0 is also the register containing the exit value for the BPF pr=
ogram. The
> semantics of the exit value are defined by the type of program. Furthermo=
re, when
> handing execution back to the kernel, the exit value is passed as a 32 bi=
t value.

But other runtimes like ubpf have no such restriction and it is not mention=
ed
in the original instruction-set.rst, so I assumed from the above that it is=
 a Linux
implementation specific convention, not part of the ISA.

If you have evidence otherwise, let me know.

> > +=A0=A0 *Linux implementation*: In the Linux kernel, all program types
> > +only use
> > +=A0=A0 R1 which contains the "context", which is typically a structure
> > +containing all
> > +=A0=A0 the inputs needed.
>=20
> I also think these Linux notes do not belong into the main instruction se=
t
> document, which tries to really just describe the ISA.

I asked this question at LPC and no one had any comments about the
current approach so assumed the default consensus was to leave them
in.  The original instruction-set.rst (prior to my proposed updates)
combined both Linux specific info and general ISA info but during the LPC
discussion we said we'd move the legacy packet instructions to a separate d=
oc
on "Linux historical notes", which I have a draft of at
https://github.com/dthaler/ebpf-docs/blob/update/isa/kernel.org/linux-histo=
rical-notes.rst

If we do move Linux notes out of the ISA spec, then we could rename the
other doc to just be "Linux implementation notes", and contain all the Linu=
x
specific notes.   It will be slightly more complicated though to explain wh=
at the notes
refer to in the main spec if they're not inline line at present.

Any other opinions?  I don't feel strongly either way.
=20
> > - * the basic instruction encoding, which uses 64 bits to encode an
> > instruction
> > - * the wide instruction encoding, which appends a second 64-bit
> > immediate value
> > -=A0=A0 (imm64) after the basic instruction for a total of 128 bits.
> > +* the basic instruction encoding, which uses 64 bits to encode an
> > +instruction
> > +* the wide instruction encoding, which appends a second 64-bit
> > +immediate (i.e.,
>=20
> Btw, can you explain why you de-indent these?  I picked the space before =
the
> * because that seems to be what most Linux RST documents do.

Quentin had pointed out to me some rendering problems with the space.
You can see the difference in GitHub's renderer in a test file at
https://github.com/dthaler/ebpf-docs/blob/test-formatting/test/test-formatt=
ing.rst#lists

> > +=A0=A0 For ISA versions prior to 3, Clang v7.0 and later can enable
> > +``BPF_ALU`` support with
> > +=A0=A0 ``-Xclang -target-feature -Xclang +alu32``.
>=20
> I also suspect the clang notes would be better off in a separate document
> from the main ISA.

No one else raised concerns at LPC when I explicitly asked this, but I
have no strong opinion either way other than whatever we do for Linux
notes and for Clang notes, the answer should be the same.

> > -BPF_XOR | BPF_K | BPF_ALU means::
> > +=A0=A0 *Linux implementation*: In the Linux kernel, uint32_t is expres=
sed
> > +as u32,
> > +=A0=A0 uint64_t is expressed as u64, etc.=A0 This document uses the
> > +standard C terminology
> > +=A0=A0 as the cross-platform specification.
>=20
> I don't think this makes sense in the document.  Instead we probably need=
 a
> "Conventions" section that defines the type and syntax we use.

I'm interpreting this comment as part of the overall Linux note feedback.
Would love to hear if anyone else has opinion on the matter of Linux
implementation notes.

Thanks for the feedback!

Dave

