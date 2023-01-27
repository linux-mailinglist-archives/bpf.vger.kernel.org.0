Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF55D67E2E2
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 12:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjA0LPi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 06:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjA0LPh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 06:15:37 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD07BB8E
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 03:15:36 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RBEBeu013210;
        Fri, 27 Jan 2023 11:15:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ZWcM07hHMfgDbbf+scDj067c7h6IFS4WE0OKQlvo8w8=;
 b=IFEoEGkyKbpLazFtDO0zIzgAAtsScacwa3UC5NauqbhkoDHhLO09/sVIThOBjm9Ep1fY
 fOCKaYhWR+mfOoSeqJM+0t6DUnKFBXuWhFYFZ+6sjFgG2fJOV3BF7RXFW9xer7vwbv/Q
 9j/SEFYc/gGBEYZAaT9LAXBPPLwSNt3HPqA8zms0w0Q/KC/jz44CiCNastHX50rRDqPA
 lGLBrj8Y+SYhXSbKb3F/u08ok34J+TGLUXPU89y7hPqd+UZYRIzKTrj9iamCGtQwl3Ih
 3s15vKfFPY5+dAGvEjE2bWOHQxpFb+gamvi1A4m/qGtNW2AXneMc5+ru8eDUXWbgXH40 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7g0n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:15:22 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RBFLhV016563;
        Fri, 27 Jan 2023 11:15:21 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7g0mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:15:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R9u6Au029861;
        Fri, 27 Jan 2023 11:15:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afdcsd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 11:15:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RBFGQQ51577202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 11:15:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F35332004B;
        Fri, 27 Jan 2023 11:15:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72FEA20040;
        Fri, 27 Jan 2023 11:15:15 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 11:15:15 +0000 (GMT)
Message-ID: <ad1dcd67fb0a118175fabf109d89b9df18714020.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 22/24] s390/bpf: Implement
 arch_prepare_bpf_trampoline()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 12:15:15 +0100
In-Reply-To: <CAEf4BzZO637m4vXNJ3MNb9R+diuJyx4Ck-zbYof5YHPOrApDYA@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-23-iii@linux.ibm.com>
         <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com>
         <56b6677c73903638b88f331d6e074c595bd489b9.camel@linux.ibm.com>
         <CAEf4BzZO637m4vXNJ3MNb9R+diuJyx4Ck-zbYof5YHPOrApDYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 8iEIBsF-kbFSJDFzFN70Be_62KROv26e
X-Proofpoint-ORIG-GUID: 8gCgXvrjH7NljGHyP7mISoIep0gkzcVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270104
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2023-01-26 at 11:06 -0800, Andrii Nakryiko wrote:
> On Thu, Jan 26, 2023 at 6:30 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > On Wed, 2023-01-25 at 17:15 -0800, Andrii Nakryiko wrote:
> > > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > arch_prepare_bpf_trampoline() is used for direct attachment of
> > > > eBPF
> > > > programs to various places, bypassing kprobes. It's responsible
> > > > for
> > > > calling a number of eBPF programs before, instead and/or after
> > > > whatever they are attached to.
> > > >=20
> > > > Add a s390x implementation, paying attention to the following:
> > > >=20
> > > > - Reuse the existing JIT infrastructure, where possible.
> > > > - Like the existing JIT, prefer making multiple passes instead
> > > > of
> > > > =C2=A0 backpatching. Currently 2 passes is enough. If literal pool
> > > > is
> > > > =C2=A0 introduced, this needs to be raised to 3. However, at the
> > > > moment
> > > > =C2=A0 adding literal pool only makes the code larger. If branch
> > > > =C2=A0 shortening is introduced, the number of passes needs to be
> > > > =C2=A0 increased even further.
> > > > - Support both regular and ftrace calling conventions,
> > > > depending on
> > > > =C2=A0 the trampoline flags.
> > > > - Use expolines for indirect calls.
> > > > - Handle the mismatch between the eBPF and the s390x ABIs.
> > > > - Sign-extend fmod_ret return values.
> > > >=20
> > > > invoke_bpf_prog() produces about 120 bytes; it might be
> > > > possible to
> > > > slightly optimize this, but reaching 50 bytes, like on x86_64,
> > > > looks
> > > > unrealistic: just loading cookie, __bpf_prog_enter, bpf_func,
> > > > insnsi
> > > > and __bpf_prog_exit as literals already takes at least 5 * 12 =3D
> > > > 60
> > > > bytes, and we can't use relative addressing for most of them.
> > > > Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.
> > > >=20
> > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > ---
> > > > =C2=A0arch/s390/net/bpf_jit_comp.c | 535
> > > > +++++++++++++++++++++++++++++++++--
> > > > =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > > > =C2=A02 files changed, 517 insertions(+), 22 deletions(-)
> > > >=20
> > >=20
> > > [...]
> > >=20
> > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > index cf89504c8dda..52ff43bbf996 100644
> > > > --- a/include/linux/bpf.h
> > > > +++ b/include/linux/bpf.h
> > > > @@ -943,7 +943,11 @@ struct btf_func_model {
> > > > =C2=A0/* Each call __bpf_prog_enter + call bpf_func + call
> > > > __bpf_prog_exit is ~50
> > > > =C2=A0 * bytes on x86.
> > > > =C2=A0 */
> > > > +#if defined(__s390x__)
> > > > +#define BPF_MAX_TRAMP_LINKS 27
> > > > +#else
> > > > =C2=A0#define BPF_MAX_TRAMP_LINKS 38
> > > > +#endif
> > >=20
> > > if we turn this into enum definition, then on selftests side we
> > > can
> > > just discover this from vmlinux BTF, instead of hard-coding
> > > arch-specific constants. Thoughts?
> >=20
> > This seems to work. I can replace 3/24 and 4/24 with that in v2.
> > Some random notes:
> >=20
> > - It doesn't seem to be possible to #include "vlinux.h" into tests,
> > =C2=A0 so one has to go through the btf__load_vmlinux_btf() dance and
> > =C2=A0 allocate the fd arrays dynamically.
>=20
> yes, you can't include vmlinux.h into user-space code, of course. And
> yes it's true about needing to use btf__load_vmlinux_btf().
>=20
> But I didn't get what you are saying about fd arrays, tbh. Can you
> please elaborate?

That's a really minor thing; fexit_fd and and link_fd in fexit_stress
now need to be allocated dynamically.

> > - One has to give this enum an otherwise unnecessary name, so that
> > =C2=A0 it's easy to find. This doesn't seem like a big deal though:
> >=20
> > enum bpf_max_tramp_links {
>=20
> not really, you can keep it anonymous enum. We do that in
> include/uapi/linux/bpf.h for a lot of constants

How would you find it then? My current code is:

int get_bpf_max_tramp_links_from(struct btf *btf)
{
        const struct btf_enum *e;
        const struct btf_type *t;
        const char *name;
        int id;

        id =3D btf__find_by_name_kind(btf, "bpf_max_tramp_links",
BTF_KIND_ENUM);
        if (!ASSERT_GT(id, 0, "bpf_max_tramp_links id"))
                return -1;
        t =3D btf__type_by_id(btf, id);
        if (!ASSERT_OK_PTR(t, "bpf_max_tramp_links type"))
                return -1;
        if (!ASSERT_EQ(btf_vlen(t), 1, "bpf_max_tramp_links vlen"))
                return -1;
        e =3D btf_enum(t);
        if (!ASSERT_OK_PTR(e, "bpf_max_tramp_links[0]"))
                return -1;
        name =3D btf__name_by_offset(btf, e->name_off);
        if (!ASSERT_OK_PTR(name, "bpf_max_tramp_links[0].name_off") &&
            !ASSERT_STREQ(name, "BPF_MAX_TRAMP_LINKS",
"BPF_MAX_TRAMP_LINKS"))
                return -1;

        return e->val;
}

Is there a way to bypass looking up the enum, and go straight for the
named member?

> > #if defined(__s390x__)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_MAX_TRAMP_LINKS =3D 27,
> > #else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF_MAX_TRAMP_LINKS =3D 38,
> > #endif
> > };
> >=20
> > - An alternative might be to expose this via /proc, since the users
> > =C2=A0 might be interested in it too.
>=20
> I'd say let's not, there is no need, having it in BTF is more than
> enough for testing purposes

Fair enough.
>=20
