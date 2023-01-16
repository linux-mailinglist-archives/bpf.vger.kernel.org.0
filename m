Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561F466D1D9
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjAPWiJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232913AbjAPWiG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:38:06 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865B022DD3
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:38:05 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GJKrHS019473;
        Mon, 16 Jan 2023 22:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=wZZ5SC9QdYwaHWT1F398stNa4XmL+L+iGbgbq9lwdjM=;
 b=MDq6YE5jBi2f0WTsiAGkspf4tMyLx012Fmubf5Wirwi9WM7l4aEgm9+Uh/RIibdPMHvZ
 LhhNJg6xjwYVKWf2UtxfwK1u22q2N7bzLzrDcv9SE0P0lvsQB0z64ZTWENLGygtgt5oh
 ljlfWun399ebYVleFePKTC/Kf1iAzviPbmoFnuasJ6qxRlI+LxzQv8Ke1lrpQ3rziLOY
 dhC9ookI0ms7T05RSmLiNmhqw3nfgdUUjRvMGaLTRHatGD1QZfQ0VX9G7DB13TWcmqag
 YlwX70PXHYx0u3uYOLwNyAMz6FtTnD6A3+gRpzW/2uCwXMN70VjfcLKqY6+ZtKumVFul /w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5chfkgwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:37:37 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30GMba8r032054;
        Mon, 16 Jan 2023 22:37:36 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5chfkgwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:37:36 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GCrsvD006884;
        Mon, 16 Jan 2023 22:37:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3n3m16j5p5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:37:34 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30GMbVwf40239448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 22:37:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B34002004B;
        Mon, 16 Jan 2023 22:37:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDC4420043;
        Mon, 16 Jan 2023 22:37:30 +0000 (GMT)
Received: from [9.171.3.141] (unknown [9.171.3.141])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 22:37:30 +0000 (GMT)
Message-ID: <ed8ce036cd61741170dffe3fa733cd98d1970302.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 00/25] libbpf: extend [ku]probe and syscall
 argument tracing support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Pu Lehui <pulehui@huawei.com>,
        Hengqi Chen <hengqi.chen@gmail.com>,
        Vladimir Isaev <isaev@synopsys.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Kenta Tada <Kenta.Tada@sony.com>,
        Florent Revest <revest@chromium.org>
Date:   Mon, 16 Jan 2023 23:37:30 +0100
In-Reply-To: <f810f5c6a43af954464cedbe25d523896a59d500.camel@linux.ibm.com>
References: <20230113083404.4015489-1-andrii@kernel.org>
         <f810f5c6a43af954464cedbe25d523896a59d500.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mp3g8GAXGQo4mPA62_hwFzdq94nLibB2
X-Proofpoint-GUID: q9w3Qxvd5eScgc6MVNelwU0sF-8Ovbz3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_16,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301160165
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 23:09 +0100, Ilya Leoshkevich wrote:
> On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> > This patch set fixes and extends libbpf's bpf_tracing.h support for
> > tracing
> > arguments of kprobes/uprobes, and syscall as a special case.
> >=20
> > Depending on the architecture, anywhere between 3 and 8 arguments
> > can
> > be
> > passed to a function in registers (so relevant to kprobes and
> > uprobes), but
> > before this patch set libbpf's macros in bpf_tracing.h only
> > supported
> > up to
> > 5 arguments, which is limiting in practice. This patch set extends
> > bpf_tracing.h to support up to 8 arguments, if architecture allows.
> > This
> > includes explicit PT_REGS_PARMx() macro family, as well as
> > BPF_KPROBE() macro.
> >=20
> > Now, with tracing syscall arguments situation is sometimes quite
> > different.
> > For a lot of architectures syscall argument passing through
> > registers
> > differs
> > from function call sequence at least a little. For i386 it differs
> > *a
> > lot*.
> > This patch set addresses this issue across all currently supported
> > architectures and hopefully fixes existing issues. syscall(2)
> > manpage
> > defines
> > that either 6 or 7 arguments can be supported, depending on
> > architecture, so
> > libbpf defines 6 or 7 registers per architecture to be used to
> > fetch
> > syscall
> > arguments.
> >=20
> > Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this
> > patch set.
> > They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics of
> > argument
> > fetching of kernel functions and user-space functions are
> > identical),
> > but it
> > allows BPF users to have less confusing BPF-side code when working
> > with
> > uprobes.
> >=20
> > For both sets of changes selftests are extended to test these new
> > register
> > definitions to architecture-defined limits. Unfortunately I don't
> > have ability
> > to test it on all architectures, and BPF CI only tests 3
> > architecture
> > (x86-64,
> > arm64, and s390x), so it would be greatly appreciated if CC'ed
> > people
> > can help
> > review and test changes on architectures they are familiar with
> > (and
> > maybe
> > have direct access to for testing). Thank you.
> >=20
> > Cc: Alan Maguire <alan.maguire@oracle.com>
> > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > Cc: Pu Lehui <pulehui@huawei.com>
> > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > Cc: Vladimir Isaev <isaev@synopsys.com>
> > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > Cc: Florent Revest <revest@chromium.org>
> >=20
> > Andrii Nakryiko (25):
> > =C2=A0 libbpf: add support for fetching up to 8 arguments in kprobes
> > =C2=A0 libbpf: add 6th argument support for x86-64 in bpf_tracing.h
> > =C2=A0 libbpf: fix arm and arm64 specs in bpf_tracing.h
> > =C2=A0 libbpf: complete mips spec in bpf_tracing.h
> > =C2=A0 libbpf: complete powerpc spec in bpf_tracing.h
> > =C2=A0 libbpf: complete sparc spec in bpf_tracing.h
> > =C2=A0 libbpf: complete riscv arch spec in bpf_tracing.h
> > =C2=A0 libbpf: fix and complete ARC spec in bpf_tracing.h
> > =C2=A0 libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
> > =C2=A0 libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
> > =C2=A0 selftests/bpf: validate arch-specific argument registers limits
> > =C2=A0 libbpf: improve syscall tracing support in bpf_tracing.h
> > =C2=A0 libbpf: define x86-64 syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define i386 syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define s390x syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define arm syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define arm64 syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define mips syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define powerpc syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define sparc syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define riscv syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define arc syscall regs spec in bpf_tracing.h
> > =C2=A0 libbpf: define loongarch syscall regs spec in bpf_tracing.h
> > =C2=A0 selftests/bpf: add 6-argument syscall tracing test
> > =C2=A0 libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG
> > defaults
> >=20
> > =C2=A0tools/lib/bpf/bpf_tracing.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
301
> > +++++++++++++++-
> > --
> > =C2=A0.../bpf/prog_tests/test_bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0 1=
8 +-
> > =C2=A0.../bpf/prog_tests/uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 33 +-
> > =C2=A0tools/testing/selftests/bpf/progs/bpf_misc.h=C2=A0 |=C2=A0 25 ++
> > =C2=A0.../selftests/bpf/progs/bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0 2=
6 ++
> > =C2=A0.../bpf/progs/test_uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 48 ++-
> > =C2=A06 files changed, 405 insertions(+), 46 deletions(-)
> >=20
>=20
> With the following fixup for 24/25:
>=20
> diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> index c07c5c52d5fc..75ccdef9bc78 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
> @@ -88,15 +88,33 @@ __u64 mmap_flags;
> =C2=A0__u64 mmap_fd;
> =C2=A0__u64 mmap_offset;
> =C2=A0
> +#if defined(bpf_target_s390)
> +SEC("ksyscall/old_mmap")
> +#else
> =C2=A0SEC("ksyscall/mmap")
> +#endif
> =C2=A0int BPF_KSYSCALL(mmap_enter, void *addr, size_t length, int prot,
> int
> flags,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 int fd, off_t offset)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pid_t pid =3D bpf_get_current_=
pid_tgid() >> 32;
> +#if defined(bpf_target_s390)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long args[6] =3D {0};
> +#endif
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (pid !=3D filter_pid)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0
> +#if defined(bpf_target_s390)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* For __ARCH_WANT_SYS_OLD_MMAP, pa=
rse mmap_arg_struct. */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_probe_read_user(args, sizeof(ar=
gs), addr);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =3D (void *)args[0];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 length =3D (size_t)args[1];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prot =3D (int)args[2];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 flags =3D (int)args[3];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fd =3D (int)args[4];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 offset =3D (off_t)args[5];
> +#endif
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmap_addr =3D (__u64)addr;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmap_length =3D length;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mmap_prot =3D prot;
>=20
> # ./test_progs -t syscall_macro
> #19=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf_syscall_macro:OK
>=20
> Tested-by:=C2=A0Ilya Leoshkevich <iii@linux.ibm.com>=C2=A0 # s390x

While the above fixup works, I realized that it's ugly. It's better to
admit that mmap and old_mmap are different syscalls and create a
different probe, even if it means duplicating pid filtering code:

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index c07c5c52d5fc..2420cad54d36 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -88,6 +88,29 @@ __u64 mmap_flags;
 __u64 mmap_fd;
 __u64 mmap_offset;
=20
+#if defined(bpf_target_s390)
+/* Attach to old_mmap on architectures with __ARCH_WANT_SYS_OLD_MMAP.
*/
+SEC("ksyscall/old_mmap")
+int BPF_KSYSCALL(old_mmap_enter, void *arg)
+{
+       pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
+       unsigned long a[6] =3D {0};
+
+       if (pid !=3D filter_pid)
+               return 0;
+
+       /* Parse mmap_arg_struct. */
+       bpf_probe_read_user(a, sizeof(a), arg);
+       mmap_addr =3D (__u64)(void *)a[0];
+       mmap_length =3D (size_t)a[1];
+       mmap_prot =3D (int)a[2];
+       mmap_flags =3D (int)a[3];
+       mmap_fd =3D (int)a[4];
+       mmap_offset =3D (off_t)a[5];
+
+       return 0;
+}
+#else
 SEC("ksyscall/mmap")
 int BPF_KSYSCALL(mmap_enter, void *addr, size_t length, int prot, int
flags,
                 int fd, off_t offset)
@@ -106,5 +129,6 @@ int BPF_KSYSCALL(mmap_enter, void *addr, size_t
length, int prot, int flags,
=20
        return 0;
 }
+#endif
=20
 char _license[] SEC("license") =3D "GPL";

