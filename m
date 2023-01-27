Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08C367F163
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 23:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjA0WvV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 17:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjA0WvU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 17:51:20 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9292365C
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 14:51:18 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RMXTUF003322;
        Fri, 27 Jan 2023 22:51:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=vrAQp7Tsb/AANUzsOTtPZt9rSQqoRTiXPriAY3AYRjM=;
 b=S6HxeYvMVEIvNlH/vuRjuVvBF50s6hwjhwmmW33C8c35kKMHjnxw+IonLVE5Jy0+5zCt
 Z6K+irRdJRtdtvYNGuucry9BeObQ/hsMlW4qzdVV39bfpXeLhuSYQipIv28/jqSKH8ti
 3OsjP2Uy+/02CXy6JTmbzJ0ONH+LQN0G33SyiFq5P7RO9P9bA9rBqoW5IfAq2rkieFTU
 kFgV6B8sC3lBVbZMUqYSQHv5SiM4XVbvYAhMovPpyFa/1uo8nZpSgT3WyWdRGCWfdc7N
 g8YdYfro7rGaOXGYp7AKXjR2DBJO5ZTFyE/zMBy5hhf4g/Z5AnlUauAuPOoz6g3C4q+M qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncqgwran7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 22:51:02 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RMja7N012650;
        Fri, 27 Jan 2023 22:51:01 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncqgwramq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 22:51:01 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R3v7wG029886;
        Fri, 27 Jan 2023 22:50:59 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3n87p6dsc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 22:50:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RMouMf25035232
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 22:50:56 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 12A0E20043;
        Fri, 27 Jan 2023 22:50:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9156420040;
        Fri, 27 Jan 2023 22:50:55 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 22:50:55 +0000 (GMT)
Message-ID: <bed8d554582c171765083c849750af37656aa253.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 00/24] Support bpf trampoline for s390x
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 23:50:55 +0100
In-Reply-To: <CAEf4Bzb3uiSHtUbgVWmkWuJ5Sw1UZd4c_iuS4QXtUkXmTTtXuQ@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <CAEf4BzZP5771Wbv4w1gM+8vcGwvhmFi2tH-8aSGfnzvb=ZgaJg@mail.gmail.com>
         <8e9f72c6b43361a778e623085eb5b7aea7bd0fbd.camel@linux.ibm.com>
         <CAEf4Bzb3uiSHtUbgVWmkWuJ5Sw1UZd4c_iuS4QXtUkXmTTtXuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B7onH34S4W5kKyEsiCbva640HbVNqXlZ
X-Proofpoint-GUID: AU7mxH4gDNqwANmyuAq3dF3ml1lcng6n
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_14,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270207
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-27 at 09:24 -0800, Andrii Nakryiko wrote:
> On Fri, Jan 27, 2023 at 8:51 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > On Wed, 2023-01-25 at 16:45 -0800, Andrii Nakryiko wrote:
> > > On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich
> > > <iii@linux.ibm.com>
> > > wrote:
> > > >=20
> > > > Hi,
> > > >=20
> > > > This series implements poke, trampoline, kfunc, mixing subprogs
> > > > and
> > > > tailcalls, and fixes a number of tests on s390x.
> > > >=20
> > > > The following failures still remain:
> > > >=20
> > > > #52=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core_read_macros:FAIL
> > > > Uses BPF_PROBE_READ(), shouldn't there be
> > > > BPF_PROBE_READ_KERNEL()?
> > >=20
> > > BPF_PROBE_READ(), similarly to BPF_CORE_READ() both use
> > > bpf_probe_read_kernel() internally, as it's most common use case.
> > > We
> > > have separate BPF_PROBE_READ_USER() and BPF_CORE_READ_USER() for
> > > when
> > > bpf_probe_read_user() has to be used.
> >=20
> > At least purely from the code perspective, BPF_PROBE_READ() seems
> > to
> > delegate to bpf_probe_read(). The following therefore helps with
> > this
> > test:
> >=20
> > --- a/tools/lib/bpf/bpf_core_read.h
> > +++ b/tools/lib/bpf/bpf_core_read.h
> > @@ -364,7 +364,7 @@ enum bpf_enum_value_kind {
> >=20
> > =C2=A0/* Non-CO-RE variant of BPF_CORE_READ_INTO() */
> > =C2=A0#define BPF_PROBE_READ_INTO(dst, src, a, ...) ({
> > \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___core_read(bpf_probe_read, bpf_=
probe_read,
> > \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___core_read(bpf_probe_read_kerne=
l, bpf_probe_read_kernel,
> > \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst, (src), a, ##__VA_A=
RGS__)
> > \
> > =C2=A0})
> >=20
> > @@ -400,7 +400,7 @@ enum bpf_enum_value_kind {
> >=20
> > =C2=A0/* Non-CO-RE variant of BPF_CORE_READ_STR_INTO() */
> > =C2=A0#define BPF_PROBE_READ_STR_INTO(dst, src, a, ...) ({
> > \
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___core_read(bpf_probe_read_str, =
bpf_probe_read,
> > \
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ___core_read(bpf_probe_read_kerne=
l_str,
> > bpf_probe_read_kernel,
> > \
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dst, (src), a, ##__VA_A=
RGS__)
> > \
> > =C2=A0})
> >=20
> > but I'm not sure if there are backward compatibility concerns, or
> > if
> > libbpf is supposed to rewrite this when
> > !ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
>=20
> Oh, this is just a bug, it was an omission when we converted
> BPF_CORE_READ to bpf_probe_read_kernel. If you look at bpf_core_read
> definition, it is using bpf_probe_read_kernel, which is also the
> intent for BPF_PROBE_READ. Let's fix this.
>=20
> And there is no backwards compat concerns because libbpf will
> automatically convert calls to bpf_probe_read_{kernel,user}[_str] to
> bpf_probe_read[_str] if host kernel doesn't yet support kernel or
> user
> specific variants.

Thanks for confirming! I will include the fix in v2.

> > > > #82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_stack_raw_tp:FAIL
> > > > get_stack_print_output:FAIL:user_stack corrupted user stack
> > > > Known issue:
> > > > We cannot reliably unwind userspace on s390x without DWARF.
> > >=20
> > > like in principle, or frame pointers (or some equivalent) needs
> > > to be
> > > configured for this to work?
> > >=20
> > > Asking also in the context of [0], where s390x was excluded. If
> > > there
> > > is actually a way to enable frame pointer-based stack unwinding
> > > on
> > > s390x, would be nice to hear from an expert.
> > >=20
> > > =C2=A0 [0] https://pagure.io/fesco/issue/2923
> >=20
> > For DWARFless unwinding we have -mbackchain (not to be confused
> > with
> > -fno-omit-frame-pointer, which we also have, but which just hurts
> > performance without providing tangible benefits).
> > -mbackchain has a few problems though:
> >=20
> > - It's not atomic. Here is a typical prologue with -mbackchain:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1: stmg=C2=A0=C2=A0=C2=A0 %r=
11,%r15,88(%r15)=C2=A0 # save non-volatile
> > registers
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2: lgr=C2=A0=C2=A0=C2=A0=C2=
=A0 %r14,%r15=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #=
 %r14 =3D sp
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 3: lay=C2=A0=C2=A0=C2=A0=C2=
=A0 %r15,-160(%r15)=C2=A0=C2=A0=C2=A0=C2=A0 # sp -=3D 160
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4: stg=C2=A0=C2=A0=C2=A0=C2=
=A0 %r14,0(%r15)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # *(void **)sp =
=3D %r14
> >=20
> > =C2=A0 The invariant here is that *(void **)%r15 is always a pointer to
> > the
> > =C2=A0 next frame. This means that if we unwind from (4), we are totally
> > =C2=A0 broken. This does not happen if we unwind from any other
> > instruction,
> > =C2=A0 but still.
> >=20
> > - Unwinding from (1)-(3) is not particularly good either. PSW
> > points to
> > =C2=A0 the callee, but R15 points to the caller's frame.
> >=20
> > - Unwinding leaf functions is like the previous problem, but worse:
> > =C2=A0 they often do not establish a stack frame at all, so PSW and R15
> > are
> > =C2=A0 out of sync for the entire duration of the call.
> >=20
> > Therefore .eh_frame-based unwinding is preferred, since it covers
> > all
> > these corner cases and is therefore reliable. From what I
> > understand,
> > adding .eh_frame unwinding to the kernel is not desirable. In an
> > internal discussion we had another idea though: would it be
> > possible to
> > have an eBPF program that does .eh_frame parsing and unwinding? I
> > understand that it can be technically challenging at the moment,
> > but
> > the end result would not be exploitable by crafting malicious
> > .eh_frame sections, won't loop endlessly, will have good
> > performance,
> > etc.
>=20
> Thanks for details. This was all discussed at length in Fedora
> -fno-omit-frame-pointer discussion I linked above, so no real need to
> go over this again. .eh_frame-based unwinding on BPF side is
> possible,
> but only for processes that you knew about (and preprocessed) before
> you started profiling session. Pre-processing is memory and
> cpu-intensive operation on busy systems, and they will miss any
> processes started during profiling. So as a general approach for
> system-wide profiling it leaves a lot to be desired.

Thanks for the explanation, I'll read the thread and come back if I
get=C2=A0some new ideas not listed here.

> Should we enable -mbackchain in our CI for s390x to be able to
> capture
> stack traces (even if on some instructions they might be incomplete
> or
> outright broken)?

Let's do it, I don't have anything against this.

[...]
> > >=20
>=20

> > Here is the full log:
> >=20
> > https://gist.github.com/iii-i/8e20100c33ab6f0dffb5e6e51d1330e8
> >=20
> > Apparently we do indeed lose a constraint established by
> > if (hdr->tcp_len < sizeof(*hdr->tcp)). But the naive
>=20
> The test is too big and unfamiliar for me to figure this out. And the
> problem is not upper bound, but lower bound. hdr->tcp_len is not
> proven to be strictly greater than zero, which is what verifier
> complains about. Not sure how it works on other arches right now.
>=20
>=20
> But I see that bpf_csum_diff defines size arguments as
> ARG_CONST_SIZE_OR_ZERO while bpf_tcp_raw_gen_syncookie_ipv4 has
> ARG_CONST_SIZE. I generally found ARG_CONST_SIZE way too problematic
> in practice, I'd say we should change it to ARG_CONST_SIZE_OR_ZERO.

Yes, this helps, and doesn't seem to introduce issues, since the=C2=A0
minimum length is enforced inside this function anyway. I will include
the change for bpf_tcp_raw_gen_syncookie_ipv{4,6} in v2; I guess some
other functions may benefit from this as well, but this is outside the
scope of this series.

[...]
