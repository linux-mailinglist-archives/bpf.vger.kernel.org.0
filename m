Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E067EB97
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbjA0QwP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 11:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjA0Qv6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 11:51:58 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D32A97E68C
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 08:51:48 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RFr9xh016717;
        Fri, 27 Jan 2023 16:51:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=0DRwPkATuVZk0ycNBg88E3o9kC/D5achfqcjDgh9aFU=;
 b=hFEjCNyF+fjLNHhi0YwQzRC8VgLbGZdcjyTCyEzTZMKJW2GYyjjAZDOiPmiiaJl0JYIl
 c+iZBzXpX4Vat9zEJRrP3jYAdr1bQqxkyiZIMRlHQO0SFFbSIROfCkGrfFSlkSw2tOl8
 MWM+ptWUKY/BVCJ7PM2+p8831LA2SdQRKRS0CkZTmqvThntk2HwtnA07RqPJ6bSDUgla
 WbJZejDPR3ZTvmuSDkrnehdw3YsudiEyjVpg4A2hBYo5sHOWA28xkJcukAIRP+eavGAg
 JtGBjJlBqFgRluUhMydrGEgJgFjY6wQvxx2OXu6oufpX3GNwyPSz9tQV5oxvp6zTAywK GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nchn91njd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:51:27 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RGTu9V022269;
        Fri, 27 Jan 2023 16:51:27 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nchn91nhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:51:26 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R5jm0H014941;
        Fri, 27 Jan 2023 16:51:25 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n87affuek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 16:51:25 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RGpLpb20775172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 16:51:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5827620040;
        Fri, 27 Jan 2023 16:51:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBEA72004E;
        Fri, 27 Jan 2023 16:51:20 +0000 (GMT)
Received: from [9.179.11.57] (unknown [9.179.11.57])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 16:51:20 +0000 (GMT)
Message-ID: <8e9f72c6b43361a778e623085eb5b7aea7bd0fbd.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 00/24] Support bpf trampoline for s390x
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Fri, 27 Jan 2023 17:51:20 +0100
In-Reply-To: <CAEf4BzZP5771Wbv4w1gM+8vcGwvhmFi2tH-8aSGfnzvb=ZgaJg@mail.gmail.com>
References: <20230125213817.1424447-1-iii@linux.ibm.com>
         <CAEf4BzZP5771Wbv4w1gM+8vcGwvhmFi2tH-8aSGfnzvb=ZgaJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uz8riWgIfR7qpTOAFhjz0r0L1T4-IpOP
X-Proofpoint-ORIG-GUID: ma4hGy36HBN1e6rcheaIEbzz-pj9p3sM
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_10,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270154
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-01-25 at 16:45 -0800, Andrii Nakryiko wrote:
> On Wed, Jan 25, 2023 at 1:39 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > Hi,
> >=20
> > This series implements poke, trampoline, kfunc, mixing subprogs and
> > tailcalls, and fixes a number of tests on s390x.
> >=20
> > The following failures still remain:
> >=20
> > #52=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 core_read_macros:FAIL
> > Uses BPF_PROBE_READ(), shouldn't there be BPF_PROBE_READ_KERNEL()?
>=20
> BPF_PROBE_READ(), similarly to BPF_CORE_READ() both use
> bpf_probe_read_kernel() internally, as it's most common use case. We
> have separate BPF_PROBE_READ_USER() and BPF_CORE_READ_USER() for when
> bpf_probe_read_user() has to be used.

At least purely from the code perspective, BPF_PROBE_READ() seems to
delegate to bpf_probe_read(). The following therefore helps with this
test:

--- a/tools/lib/bpf/bpf_core_read.h
+++ b/tools/lib/bpf/bpf_core_read.h
@@ -364,7 +364,7 @@ enum bpf_enum_value_kind {
=20
 /* Non-CO-RE variant of BPF_CORE_READ_INTO() */
 #define BPF_PROBE_READ_INTO(dst, src, a, ...) ({=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20
\
-       ___core_read(bpf_probe_read, bpf_probe_read,=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20
\
+       ___core_read(bpf_probe_read_kernel, bpf_probe_read_kernel,=20=20=20=
=20
\
                     dst, (src), a, ##__VA_ARGS__)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
\
 })
=20
@@ -400,7 +400,7 @@ enum bpf_enum_value_kind {
=20
 /* Non-CO-RE variant of BPF_CORE_READ_STR_INTO() */
 #define BPF_PROBE_READ_STR_INTO(dst, src, a, ...) ({=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20
\
-       ___core_read(bpf_probe_read_str, bpf_probe_read,=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20
\
+       ___core_read(bpf_probe_read_kernel_str, bpf_probe_read_kernel,
\
                     dst, (src), a, ##__VA_ARGS__)=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20
\
 })

but I'm not sure if there are backward compatibility concerns, or if
libbpf is supposed to rewrite this when
!ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.

> >=20
> > #82=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_stack_raw_tp:FAIL
> > get_stack_print_output:FAIL:user_stack corrupted user stack
> > Known issue:
> > We cannot reliably unwind userspace on s390x without DWARF.
>=20
> like in principle, or frame pointers (or some equivalent) needs to be
> configured for this to work?
>=20
> Asking also in the context of [0], where s390x was excluded. If there
> is actually a way to enable frame pointer-based stack unwinding on
> s390x, would be nice to hear from an expert.
>=20
> =C2=A0 [0] https://pagure.io/fesco/issue/2923

For DWARFless unwinding we have -mbackchain (not to be confused with
-fno-omit-frame-pointer, which we also have, but which just hurts
performance without providing tangible benefits).
-mbackchain has a few problems though:

- It's not atomic. Here is a typical prologue with -mbackchain:

        1: stmg    %r11,%r15,88(%r15)  # save non-volatile registers
        2: lgr     %r14,%r15           # %r14 =3D sp
        3: lay     %r15,-160(%r15)     # sp -=3D 160
        4: stg     %r14,0(%r15)        # *(void **)sp =3D %r14

  The invariant here is that *(void **)%r15 is always a pointer to the
  next frame. This means that if we unwind from (4), we are totally
  broken. This does not happen if we unwind from any other instruction,
  but still.

- Unwinding from (1)-(3) is not particularly good either. PSW points to
  the callee, but R15 points to the caller's frame.

- Unwinding leaf functions is like the previous problem, but worse:
  they often do not establish a stack frame at all, so PSW and R15 are
  out of sync for the entire duration of the call.

Therefore .eh_frame-based unwinding is preferred, since it covers all
these corner cases and is therefore reliable. From what I understand,
adding .eh_frame unwinding to the kernel is not desirable. In an
internal discussion we had another idea though: would it be possible to
have an eBPF program that does .eh_frame parsing and unwinding? I
understand that it can be technically challenging at the moment, but
the end result would not be exploitable by crafting malicious
.eh_frame=C2=A0sections, won't loop endlessly, will have good performance,
etc.

> > #101=C2=A0=C2=A0=C2=A0=C2=A0 ksyms_module:FAIL
> > address of kernel function bpf_testmod_test_mod_kfunc is out of
> > range
> > Known issue:
> > Kernel and modules are too far away from each other on s390x.
> >=20
> > #167=C2=A0=C2=A0=C2=A0=C2=A0 sk_assign:FAIL
> > Uses legacy map definitions in 'maps' section.
>=20
> Hm.. assuming new enough iproute2, new-style .maps definition should
> be supported, right? Let's convert map definition?

Yep, that worked. Will include in v2.

> > #190=C2=A0=C2=A0=C2=A0=C2=A0 stacktrace_build_id:FAIL
> > Known issue:
> > We cannot reliably unwind userspace on s390x without DWARF.
> >=20
> > #211=C2=A0=C2=A0=C2=A0=C2=A0 test_bpffs:FAIL
> > iterators.bpf.c is broken on s390x, it uses BPF_CORE_READ(),
> > shouldn't
> > there be BPF_CORE_READ_KERNEL()?
>=20
> BPF_CORE_READ() is that, so must be something else
>=20
> >=20
> > #218=C2=A0=C2=A0=C2=A0=C2=A0 test_profiler:FAIL
> > A lot of BPF_PROBE_READ() usages.
>=20
> ditto, something else
>=20
> >=20
> > #281=C2=A0=C2=A0=C2=A0=C2=A0 xdp_metadata:FAIL
> > See patch 24.
> >=20
> > #284=C2=A0=C2=A0=C2=A0=C2=A0 xdp_synproxy:FAIL
> > Verifier error:
> > ; value =3D bpf_tcp_raw_gen_syncookie_ipv4(hdr->ipv4, hdr->tcp,
> > 281: (79) r1 =3D *(u64 *)(r10 -80)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ; R1_w=
=3Dpkt(off=3D14,r=3D74,imm=3D0)
> > R10=3Dfp0
> > 282: (bf) r2 =3D r8=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R2_w=3Dpkt(id=3D5,off=3D14,r=3D74,umax=3D60,var_off=3D(0x0; 0x3c))
> > R8=3Dpkt(id=3D5,off=3D14,r=3D74,umax=3D60,var_off=3D(0x0; 0x3c))
> > 283: (79) r3 =3D *(u64 *)(r10 -104)=C2=A0=C2=A0=C2=A0=C2=A0 ;
> > R3_w=3Dscalar(umax=3D60,var_off=3D(0x0; 0x3c)) R10=3Dfp0
> > 284: (85) call bpf_tcp_raw_gen_syncookie_ipv4#204
> > invalid access to packet, off=3D14 size=3D0, R2(id=3D5,off=3D14,r=3D74)
> > R2 offset is outside of the packet
>=20
> third arg to bpf_tcp_raw_gen_syncookie_ipv4() is defined as
> ARG_CONST_SIZE, so is required to be strictly positive, which doesn't
> seem to be "proven" to verifier. Please provided bigger log, it might
> another instance of needing to sprinkle barrier_var() around.
>=20
> And maybe thinking about using ARG_CONST_SIZE_OR_ZERO instead of
> ARG_CONST_SIZE.

Here is the full log:

https://gist.github.com/iii-i/8e20100c33ab6f0dffb5e6e51d1330e8

Apparently we do indeed lose a constraint established by
if (hdr->tcp_len < sizeof(*hdr->tcp)). But the naive

--- a/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
+++ b/tools/testing/selftests/bpf/progs/xdp_synproxy_kern.c
@@ -401,6 +401,7 @@ static __always_inline int tcp_dissect(void *data,
void *data_end,
        hdr->tcp_len =3D hdr->tcp->doff * 4;
        if (hdr->tcp_len < sizeof(*hdr->tcp))
                return XDP_DROP;
+       barrier_var(hdr->tcp_len);
=20
        return XDP_TX;
 }
@@ -791,6 +792,7 @@ static __always_inline int syncookie_part2(void
*ctx, void *data, void *data_end
        hdr->tcp_len =3D hdr->tcp->doff * 4;
        if (hdr->tcp_len < sizeof(*hdr->tcp))
                return XDP_ABORTED;
+       barrier_var(hdr->tcp_len);
=20
        return hdr->tcp->syn ? syncookie_handle_syn(hdr, ctx, data,
data_end, xdp) :
                               syncookie_handle_ack(hdr);

does not help.

>=20
> >=20
> > None of these seem to be due to the new changes.
> >=20
> > Best regards,
> > Ilya
> >=20
> > Ilya Leoshkevich (24):
> > =C2=A0 selftests/bpf: Fix liburandom_read.so linker error
> > =C2=A0 selftests/bpf: Fix symlink creation error
> > =C2=A0 selftests/bpf: Fix fexit_stress on s390x
> > =C2=A0 selftests/bpf: Fix trampoline_count on s390x
> > =C2=A0 selftests/bpf: Fix kfree_skb on s390x
> > =C2=A0 selftests/bpf: Set errno when urand_spawn() fails
> > =C2=A0 selftests/bpf: Fix decap_sanity_ns cleanup
> > =C2=A0 selftests/bpf: Fix verify_pkcs7_sig on s390x
> > =C2=A0 selftests/bpf: Fix xdp_do_redirect on s390x
> > =C2=A0 selftests/bpf: Fix cgrp_local_storage on s390x
> > =C2=A0 selftests/bpf: Check stack_mprotect() return value
> > =C2=A0 selftests/bpf: Increase SIZEOF_BPF_LOCAL_STORAGE_ELEM on s390x
> > =C2=A0 selftests/bpf: Add a sign-extension test for kfuncs
> > =C2=A0 selftests/bpf: Fix test_lsm on s390x
> > =C2=A0 selftests/bpf: Fix test_xdp_adjust_tail_grow2 on s390x
> > =C2=A0 selftests/bpf: Fix vmlinux test on s390x
> > =C2=A0 libbpf: Read usdt arg spec with bpf_probe_read_kernel()
> > =C2=A0 s390/bpf: Fix a typo in a comment
> > =C2=A0 s390/bpf: Add expoline to tail calls
> > =C2=A0 s390/bpf: Implement bpf_arch_text_poke()
> > =C2=A0 bpf: btf: Add BTF_FMODEL_SIGNED_ARG flag
> > =C2=A0 s390/bpf: Implement arch_prepare_bpf_trampoline()
> > =C2=A0 s390/bpf: Implement bpf_jit_supports_subprog_tailcalls()
> > =C2=A0 s390/bpf: Implement bpf_jit_supports_kfunc_call()
> >=20
> > =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 708
> > +++++++++++++++++-
> > =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 +
> > =C2=A0include/linux/btf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
> > =C2=A0kernel/bpf/btf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 16 +-
> > =C2=A0net/bpf/test_run.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0tools/lib/bpf/usdt.bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 33 +-
> > =C2=A0tools/testing/selftests/bpf/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> > =C2=A0tools/testing/selftests/bpf/netcnt_common.h=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +-
> > =C2=A0.../selftests/bpf/prog_tests/bpf_cookie.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 6 +-
> > =C2=A0.../bpf/prog_tests/cgrp_local_storage.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A0.../selftests/bpf/prog_tests/decap_sanity.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 2 +-
> > =C2=A0.../selftests/bpf/prog_tests/fexit_stress.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 +-
> > =C2=A0.../selftests/bpf/prog_tests/kfree_skb.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 2 +-
> > =C2=A0.../selftests/bpf/prog_tests/kfunc_call.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 1 +
> > =C2=A0.../selftests/bpf/prog_tests/test_lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +-
> > =C2=A0.../bpf/prog_tests/trampoline_count.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0tools/testing/selftests/bpf/prog_tests/usdt.c |=C2=A0=C2=A0 1 +
> > =C2=A0.../bpf/prog_tests/verify_pkcs7_sig.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 9 +
> > =C2=A0.../bpf/prog_tests/xdp_adjust_tail.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> > =C2=A0.../bpf/prog_tests/xdp_do_redirect.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> > =C2=A0.../selftests/bpf/progs/kfunc_call_test.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 18 +
> > =C2=A0tools/testing/selftests/bpf/progs/lsm.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 7 +-
> > =C2=A0.../bpf/progs/test_verify_pkcs7_sig.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 12 +-
> > =C2=A0.../selftests/bpf/progs/test_vmlinux.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> > =C2=A0.../bpf/progs/test_xdp_adjust_tail_grow.c=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 8 +-
> > =C2=A025 files changed, 816 insertions(+), 82 deletions(-)
> >=20
> > --
> > 2.39.1
> >=20

