Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7718C69878A
	for <lists+bpf@lfdr.de>; Wed, 15 Feb 2023 22:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjBOVza (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Feb 2023 16:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbjBOVz3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Feb 2023 16:55:29 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8858427D57
        for <bpf@vger.kernel.org>; Wed, 15 Feb 2023 13:55:27 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FLTCw4005020;
        Wed, 15 Feb 2023 21:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=DH+ubWCNE3kchrTkJFBmnY8KTrsyqMjlW4JEDLxJEj8=;
 b=mrCPRxVLdfuoeG5owpdXqGiko/Yu8lsEBxMoyds6Q31oKhdbWNrAVIzRsAE751T6/SIv
 T6uHiRaqjcdkQU0K9XodySsmhVuAGXO173tjG1Du/61f+KUIJEEPDt2bBoRupUiZBgQi
 6PQ3ZQzGDHfeU4+OklVLOeWM27j4GjHKLggrIMJOegdJpiyiClb/NsXaJ8eAaA9jvr1I
 dLooDWpgWS67uCgevErrfenDILJGOtcSs0Z0crpIE05nVBuwsGu1fJuE8InloTsHhmQB
 g/ZPKAPSNngQOtA2PehJYrK5asfvfwS3VJq8oUxmGexN7gpiYacQ8JJIM82drWXniPOT 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7bs0p3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 21:55:07 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31FLjCpf031312;
        Wed, 15 Feb 2023 21:55:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ns7bs0p2m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 21:55:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31FBpltZ017758;
        Wed, 15 Feb 2023 21:55:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3np2n6nv65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 21:55:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31FLt1Pd47972790
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 21:55:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE45220043;
        Wed, 15 Feb 2023 21:55:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4690820040;
        Wed, 15 Feb 2023 21:55:00 +0000 (GMT)
Received: from [9.179.4.133] (unknown [9.179.4.133])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 21:55:00 +0000 (GMT)
Message-ID: <824f9b8fc6cc88ca5d5b1b10ebeaf0cb3c4052d4.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 1/1] bpf: Support 64-bit pointers to kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Date:   Wed, 15 Feb 2023 22:54:59 +0100
In-Reply-To: <Y+0lhD1Um5K9Z1CG@google.com>
References: <20230214212809.242632-1-iii@linux.ibm.com>
         <20230214212809.242632-2-iii@linux.ibm.com> <Y+wgDzf9zjfwgFwA@google.com>
         <7a2d61865e0fb1ef8db5bee8f7b95b3e983e59d4.camel@linux.ibm.com>
         <Y+0Zve9/LTWaZ96a@google.com>
         <33d548b6b265af07b7578c529e09751b58fe92ed.camel@linux.ibm.com>
         <Y+0lhD1Um5K9Z1CG@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LdARn9P8pDNSAYm0RJPBjCIK-wbwXn-X
X-Proofpoint-ORIG-GUID: ObcB8UoGJ2DENs04bqjcLcRhcY2qELxq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_13,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150186
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-15 at 10:33 -0800, Stanislav Fomichev wrote:
> On 02/15, Ilya Leoshkevich wrote:
> > On Wed, 2023-02-15 at 09:43 -0800, Stanislav Fomichev wrote:
> > > On 02/15, Ilya Leoshkevich wrote:
> > > > On Tue, 2023-02-14 at 15:58 -0800, Stanislav Fomichev wrote:
> > > > > On 02/14, Ilya Leoshkevich wrote:
> > > > > > test_ksyms_module fails to emit a kfunc call targeting a
> > > > > > module
> > > > > > on
> > > > > > s390x, because the verifier stores the difference between
> > > > > > kfunc
> > > > > > address and __bpf_call_base in bpf_insn.imm, which is s32,
> > > > > > and
> > > > > > modules
> > > > > > are roughly (1 << 42) bytes away from the kernel on s390x.
> > > > >=20
> > > > > > Fix by keeping BTF id in bpf_insn.imm for
> > > > > > BPF_PSEUDO_KFUNC_CALLs,
> > > > > > and storing the absolute address in bpf_kfunc_desc, which
> > > > > > JITs
> > > > > > retrieve
> > > > > > as usual by calling bpf_jit_get_func_addr().
> > > > >=20
> > > > > > This also fixes the problem with XDP metadata functions
> > > > > > outlined in
> > > > > > the description of commit 63d7b53ab59f ("s390/bpf:
> > > > > > Implement
> > > > > > bpf_jit_supports_kfunc_call()") by replacing address
> > > > > > lookups
> > > > > > with
> > > > > > BTF
> > > > > > id lookups. This eliminates the inconsistency between
> > > > > > "abstract"
> > > > > > XDP
> > > > > > metadata functions' BTF ids and their concrete addresses.
> > > > >=20
> > > > > > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > > > > > ---
> > > > > > =EF=BF=BD include/linux/bpf.h=EF=BF=BD=EF=BF=BD |=EF=BF=BD 2 ++
> > > > > > =EF=BF=BD kernel/bpf/core.c=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
 | 23 ++++++++++---
> > > > > > =EF=BF=BD kernel/bpf/verifier.c | 79 +++++++++++++-------------=
----
> > > > > > ----
> > > > > > ----
> > > > > > -----
> > > > > > =EF=BF=BD 3 files changed, 45 insertions(+), 59 deletions(-)
> > > >=20
>=20
> > [...]
>=20
> > > > > > +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32
> > > > > > func_id,
> > > > > > u16=EF=BF=BD
> > > > > > offset,
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD u8 **func_addr)
> > > > > > +{
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDconst struct bpf_kfunc_desc *desc;
> > > > > > +
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDdesc =3D find_kfunc_desc(prog, func_id, offset);
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDif (WARN_ON_ONCE(!desc))
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
return -EINVAL;
> > > > > > +
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BD*func_addr =3D (u8 *)desc->addr;
> > > > > > +=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=
=BDreturn 0;
> > > > > > +}
> > > > >=20
> > > > > This function isn't doing much and has a single caller.
> > > > > Should we
> > > > > just
> > > > > export find_kfunc_desc?
> > >=20
> > > > We would have to export struct bpf_kfunc_desc as well; I
> > > > thought
> > > > it's
> > > > better to add an extra function so that we could keep hiding
> > > > the
> > > > struct.
> > >=20
> > > Ah, good point. In this case seems ok to have this extra wrapper.
> > > On that note: what's the purpose of WARN_ON_ONCE here?
>=20
> > We can hit this only due to an internal verifier/JIT error, so it
> > would
> > be good to get some indication of this happening. In verifier.c we
> > have
> > verbose() function for that, but this function is called during
> > JITing.
>=20
> > [...]
>=20
> =C2=A0From my point of view, reading the code, it makes it a bit
> confusing. If=C2=A0=20
> there
> is a WARN_ON_ONCE, I'm assuming it's guarding against some kind of
> internal
> inconsistency that can happen.
>=20
> What kind of inconsistency is it guarding against here? We seem to
> have
> find_kfunc_desc in fixup_kfunc_call that checks the same insn->imm
> and returns early.

The potential inconsistency is the situation when the check in
fixup_kfunc_call() passes, and the very same check here fails.

We could say it's impossible and directly dereference desc. But if
there is a bug and it still happens, the result is a panic or an oops.

Or we could still check whether it's NULL. And if we add such a check,
adding a WARN_ON_ONCE() on top is a cheap way to quickly pinpoint the
potential user-observable issues.

Of course, it's a defensive programming / gut feeling thing. I don't
think comparing all pointers to NULL before derefencing them is a good
idea. It's just that here the first NULL comparison is quite far away,
and with time code that modifies kfunc_tab may be added in between, in
which case this might come in handy.

In any case, I don't have a really strong opinion here, just explaining
my thought process. If the consensus is to drop it, I would not mind
dropping it at all.
