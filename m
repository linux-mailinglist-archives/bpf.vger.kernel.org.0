Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6968569045F
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 11:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBIKCQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 05:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBIKCP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 05:02:15 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DDE2CFF6
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 02:02:14 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3199hrKA006327;
        Thu, 9 Feb 2023 10:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=qx18tyNE6+SeEyP/SY6W3y3kk+54CKIAYrsKK/wQ1Kg=;
 b=q6itPgtrG71Ule75ODplFuZmZkbQh6zjr1Py1N8AaNNiLZfVFqhv+aWL5WpYqRba47L9
 zFq5FFmIZAQzbszA+rmTmYKME3Ro4vv3M1WAdAeO9mnwFzJAb9nbQX/q0bbCLvqS3oJb
 o6GhZ53mU2M6pZgDX0tQBcfcWPsydThPet/oGy75F/4SNjPW4Rr4hQ7Jp8mpwfBgWcKw
 nc2nauaewIDvTLD3rKeBWkSwemE4yZxcNrXT6XNA93FuBlYAwjNDtT/Prs+yqvWuo588
 Yh19jbuJbO0gxR4T8LCDLuam0zJCNRIGsYh5PDeGYM0YyOtXlL44ll47ulkmgG/iLKI3 CA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmxewrc7d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:02:00 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3199jY1L011798;
        Thu, 9 Feb 2023 10:01:59 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nmxewrc6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:01:59 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 318Dgoe8005776;
        Thu, 9 Feb 2023 10:01:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma01fra.de.ibm.com (PPS) with ESMTPS id 3nhf06m837-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Feb 2023 10:01:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 319A1sdc47448476
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 9 Feb 2023 10:01:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 477382006B;
        Thu,  9 Feb 2023 10:01:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C0CF92006F;
        Thu,  9 Feb 2023 10:01:53 +0000 (GMT)
Received: from [9.171.61.223] (unknown [9.171.61.223])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu,  9 Feb 2023 10:01:53 +0000 (GMT)
Message-ID: <f1731f2b3008964d3c7c8c25c5a4d8799ac10c57.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 8/9] libbpf: Add MSan annotations
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date:   Thu, 09 Feb 2023 11:01:53 +0100
In-Reply-To: <CAEf4BzYCNNROXcEx5w3St6TLWS3YP4C6_uCWfgfS3t_p5uaxyQ@mail.gmail.com>
References: <20230208205642.270567-1-iii@linux.ibm.com>
         <20230208205642.270567-9-iii@linux.ibm.com>
         <CAEf4BzYCNNROXcEx5w3St6TLWS3YP4C6_uCWfgfS3t_p5uaxyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lRdwP9LtDdm2DjoE_7U3P-y901gykpWO
X-Proofpoint-GUID: _XnGSHTfi-lU8dwninuzMzaNOrpKNGlD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_05,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 malwarescore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=740 clxscore=1015 adultscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302090090
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-08 at 17:29 -0800, Andrii Nakryiko wrote:
> On Wed, Feb 8, 2023 at 12:57 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > MSan runs into a few false positives in libbpf. They all come from
> > the
> > fact that MSan does not know anything about the bpf syscall,
> > particularly, what it writes to.
> >=20
> > Add libbpf_mark_defined() function to mark memory modified by the
> > bpf
> > syscall. Use the abstract name (it could be e.g.
> > libbpf_msan_unpoison()), because it can be used for valgrind in the
> > future as well.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
>=20
> This is a lot to satisfy MSan, especially mark_map_value_defined
> which
> has to do bpf_obj_get_info_by_fd()... Is there any other way? What
> happens if we don't do it?

It would generate false positives when accessing the resulting map
values, which is not nice. The main complexity in this case comes not
from mark_map_value_defined() per se, but from the fact that we don't
know the value size, especially for percpu maps.

I toyed with the idea to extend the BPF_MAP_LOOKUP_ELEM interface to
return the number of bytes written, but decided against it - the only
user of this would be MSan, and at least for the beginning it's better
to have extra complexity in userspace, rather than in kernel.

> As for libbpf_mark_defined, wouldn't it be cleaner to teach it to
> handle NULL pointer and/or zero size transparently? Also, we can have
> libbpf_mark_defined_if(void *ptr, size_t sz, bool cond), so in code
> we
> don't have to have those explicit if conditions. Instead of:
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret && prog_ids)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 libbpf_mark_defined(prog_ids,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 attr.query.pro=
g_cnt *
> > sizeof(*prog_ids));
>=20
> we can write just
>=20
> libbpf_mark_defined_if(prog_ids, attr.query.prog_cnt *
> sizeof(*prog_ids), ret =3D=3D 0);
>=20
> ?
>=20
> Should we also call a helper something like
> 'libbpf_mark_mem_written',
> because that's what we are saying here, right?

Sure, all this sounds reasonable. Will do.

>=20
> > =C2=A0tools/lib/bpf/bpf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 70
> > +++++++++++++++++++++++++++++++--
> > =C2=A0tools/lib/bpf/btf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0tools/lib/bpf/libbpf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 1 +
> > =C2=A0tools/lib/bpf/libbpf_internal.h | 14 +++++++
> > =C2=A04 files changed, 82 insertions(+), 4 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/tools/lib/bpf/libbpf_internal.h
> > b/tools/lib/bpf/libbpf_internal.h
> > index fbaf68335394..4e4622f66fdf 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -577,4 +577,18 @@ static inline bool is_pow_of_2(size_t x)
> > =C2=A0#define PROG_LOAD_ATTEMPTS 5
> > =C2=A0int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, in=
t
> > attempts);
> >=20
> > +#if defined(__has_feature)
> > +#if __has_feature(memory_sanitizer)
> > +#define LIBBPF_MSAN
> > +#endif
> > +#endif
> > +
> > +#ifdef LIBBPF_MSAN
>=20
> would below work:
>=20
> #if defined(__has_feature) && __has_feature(memory_sanitizer)
>=20
> ?
>=20
> > +#define HAVE_LIBBPF_MARK_DEFINED
> > +#include <sanitizer/msan_interface.h>
> > +#define libbpf_mark_defined __msan_unpoison
> > +#else
> > +static inline void libbpf_mark_defined(void *s, size_t n) {}
> > +#endif
> > +
> > =C2=A0#endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> > --
> > 2.39.1
> >=20

