Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1658C67CE20
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 15:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbjAZOah (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 09:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjAZOag (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 09:30:36 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B05998
        for <bpf@vger.kernel.org>; Thu, 26 Jan 2023 06:30:34 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30QDewGU023399;
        Thu, 26 Jan 2023 14:30:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wYTM8D9rO9dxP/6eEQvQXZuqT8EbRXjpxDXJF89ePFI=;
 b=HH+IlBwfDDs42q3JiTuC3R74SBR0zK90gD9n7J26WGW2LZWaQL5WRS4tgPSkzujDQ/Gc
 y1w2eNFSh6Dd5o0bkUGM4xESF2VoB1GIDPVDllwjUJYaUtUb3DexdV7JH37zkHJA1Xzq
 6Mh9LYiahbixWtrE8bRejTxSzcYDmOitAXwcfnht+yWHhN/mtyM3m+yzVDhocLAfOUY8
 fmx5eMg7UcC1wdQdypFRFfJTSR+Bwd4781tPWzhKHK2yTt6Qe6yb/+SPGT4f4VaXS4vk
 2KAU9LOwirlllHR7Lb7/84b8rABryAwN8u49YJz2rgudty6tIF1Gjr6FeeUjHL25GFT2 qw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbt6rhx12-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:30:19 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30QDfr5U029696;
        Thu, 26 Jan 2023 14:30:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nbt6rhwyn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:30:19 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QAj8Re026731;
        Thu, 26 Jan 2023 14:30:16 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6eghk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Jan 2023 14:30:16 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30QEU7sH38600966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Jan 2023 14:30:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 306132005A;
        Thu, 26 Jan 2023 14:30:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFE082004E;
        Thu, 26 Jan 2023 14:30:06 +0000 (GMT)
Received: from [9.155.209.149] (unknown [9.155.209.149])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 26 Jan 2023 14:30:06 +0000 (GMT)
Message-ID: <56b6677c73903638b88f331d6e074c595bd489b9.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 22/24] s390/bpf: Implement
 arch_prepare_bpf_trampoline()
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 26 Jan 2023 15:30:05 +0100
In-Reply-To: <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <20230125213817.1424447-23-iii@linux.ibm.com>
         <CAEf4BzbaNhFw77bECCxf7cKenBTTe6YvMHbm+XiMQbqgukyW8Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XIj42k5yRuEqnCWRAOeG7dtw4DaLZzo6
X-Proofpoint-GUID: Cd0Nb0SnYkYpwFo2nvfTQynh_a-3V4Ej
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_06,2023-01-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 spamscore=0 clxscore=1015 mlxscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301260136
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 17:15 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > arch_prepare_bpf_trampoline() is used for direct attachment of eBPF
> > programs to various places, bypassing kprobes. It's responsible for
> > calling a number of eBPF programs before, instead and/or after
> > whatever they are attached to.
> >=20
> > Add a s390x implementation, paying attention to the following:
> >=20
> > - Reuse the existing JIT infrastructure, where possible.
> > - Like the existing JIT, prefer making multiple passes instead of
> > =C2=A0 backpatching. Currently 2 passes is enough. If literal pool is
> > =C2=A0 introduced, this needs to be raised to 3. However, at the moment
> > =C2=A0 adding literal pool only makes the code larger. If branch
> > =C2=A0 shortening is introduced, the number of passes needs to be
> > =C2=A0 increased even further.
> > - Support both regular and ftrace calling conventions, depending on
> > =C2=A0 the trampoline flags.
> > - Use expolines for indirect calls.
> > - Handle the mismatch between the eBPF and the s390x ABIs.
> > - Sign-extend fmod_ret return values.
> >=20
> > invoke_bpf_prog() produces about 120 bytes; it might be possible to
> > slightly optimize this, but reaching 50 bytes, like on x86_64,
> > looks
> > unrealistic: just loading cookie, __bpf_prog_enter, bpf_func,
> > insnsi
> > and __bpf_prog_exit as literals already takes at least 5 * 12 =3D 60
> > bytes, and we can't use relative addressing for most of them.
> > Therefore, lower BPF_MAX_TRAMP_LINKS on s390x.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0arch/s390/net/bpf_jit_comp.c | 535
> > +++++++++++++++++++++++++++++++++--
> > =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A02 files changed, 517 insertions(+), 22 deletions(-)
> >=20
>=20
> [...]
>=20
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cf89504c8dda..52ff43bbf996 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -943,7 +943,11 @@ struct btf_func_model {
> > =C2=A0/* Each call __bpf_prog_enter + call bpf_func + call
> > __bpf_prog_exit is ~50
> > =C2=A0 * bytes on x86.
> > =C2=A0 */
> > +#if defined(__s390x__)
> > +#define BPF_MAX_TRAMP_LINKS 27
> > +#else
> > =C2=A0#define BPF_MAX_TRAMP_LINKS 38
> > +#endif
>=20
> if we turn this into enum definition, then on selftests side we can
> just discover this from vmlinux BTF, instead of hard-coding
> arch-specific constants. Thoughts?

This seems to work. I can replace 3/24 and 4/24 with that in v2.
Some random notes:

- It doesn't seem to be possible to #include "vlinux.h" into tests,
  so one has to go through the btf__load_vmlinux_btf() dance and
  allocate the fd arrays dynamically.

- One has to give this enum an otherwise unnecessary name, so that
  it's easy to find. This doesn't seem like a big deal though:

enum bpf_max_tramp_links {
#if defined(__s390x__)
	BPF_MAX_TRAMP_LINKS =3D 27,
#else
	BPF_MAX_TRAMP_LINKS =3D 38,
#endif
};

- An alternative might be to expose this via /proc, since the users
  might be interested in it too.

> >=20
> > =C2=A0struct bpf_tramp_links {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_tramp_link *links=
[BPF_MAX_TRAMP_LINKS];
> > --
> > 2.39.1
> >=20

