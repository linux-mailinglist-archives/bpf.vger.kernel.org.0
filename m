Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D236666D189
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 23:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjAPWLC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 17:11:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjAPWKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 17:10:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405052B0A1
        for <bpf@vger.kernel.org>; Mon, 16 Jan 2023 14:10:19 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30GLQn8H032014;
        Mon, 16 Jan 2023 22:09:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=J3uZzybB1XovKSLMOQwSWPPTffyEgQVbtwtYrl816tQ=;
 b=plBsheMZ1uCUmyvV95cru1i6XHm9tevMJM4rda7EnFqnnQ+hTFVfX6wGU1NA6xu1phlA
 M7GhVRDUsRadjoMGr+exHGzlXl19t4+19YP/HfcaWUQ3wqw5wGdls6+bYYK4LC6938ng
 PYeCKmWBPrRFAO5WzbI4QmU78JRWH+edw4EzxyfpTLrG2r20gKdWnqt95A8rW2z7DctX
 oZMLsvolBubZ3Eq4zmEvfjnx046DdZ9zrRsukjtjLtcPIjQ7FuhpcKyAigRE1tFuuZFc
 Uu5z9nU04740581Yl7Ueal7nt+ETKNc7YSPaw6YGdkydSScC0rtIKBasPchTSxOx3Yyr 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5egn8r5f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:09:52 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30GM8Q5l004463;
        Mon, 16 Jan 2023 22:09:52 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5egn8r4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:09:51 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GFFssF006282;
        Mon, 16 Jan 2023 22:09:49 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3n3knfjycn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:09:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30GM9lOh44695830
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Jan 2023 22:09:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EC582007C;
        Mon, 16 Jan 2023 22:09:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B5442007A;
        Mon, 16 Jan 2023 22:09:46 +0000 (GMT)
Received: from [9.171.3.141] (unknown [9.171.3.141])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 16 Jan 2023 22:09:46 +0000 (GMT)
Message-ID: <f810f5c6a43af954464cedbe25d523896a59d500.camel@linux.ibm.com>
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
Date:   Mon, 16 Jan 2023 23:09:45 +0100
In-Reply-To: <20230113083404.4015489-1-andrii@kernel.org>
References: <20230113083404.4015489-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G_ne0uem6lLvEBQl-0eprViSuXUatgy8
X-Proofpoint-ORIG-GUID: Nx1JdWy0ZTxXtbZPpWgnEMDWvx5neR_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_16,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301160161
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> This patch set fixes and extends libbpf's bpf_tracing.h support for
> tracing
> arguments of kprobes/uprobes, and syscall as a special case.
>=20
> Depending on the architecture, anywhere between 3 and 8 arguments can
> be
> passed to a function in registers (so relevant to kprobes and
> uprobes), but
> before this patch set libbpf's macros in bpf_tracing.h only supported
> up to
> 5 arguments, which is limiting in practice. This patch set extends
> bpf_tracing.h to support up to 8 arguments, if architecture allows.
> This
> includes explicit PT_REGS_PARMx() macro family, as well as
> BPF_KPROBE() macro.
>=20
> Now, with tracing syscall arguments situation is sometimes quite
> different.
> For a lot of architectures syscall argument passing through registers
> differs
> from function call sequence at least a little. For i386 it differs *a
> lot*.
> This patch set addresses this issue across all currently supported
> architectures and hopefully fixes existing issues. syscall(2) manpage
> defines
> that either 6 or 7 arguments can be supported, depending on
> architecture, so
> libbpf defines 6 or 7 registers per architecture to be used to fetch
> syscall
> arguments.
>=20
> Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this
> patch set.
> They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics of
> argument
> fetching of kernel functions and user-space functions are identical),
> but it
> allows BPF users to have less confusing BPF-side code when working
> with
> uprobes.
>=20
> For both sets of changes selftests are extended to test these new
> register
> definitions to architecture-defined limits. Unfortunately I don't
> have ability
> to test it on all architectures, and BPF CI only tests 3 architecture
> (x86-64,
> arm64, and s390x), so it would be greatly appreciated if CC'ed people
> can help
> review and test changes on architectures they are familiar with (and
> maybe
> have direct access to for testing). Thank you.
>=20
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> Cc: Pu Lehui <pulehui@huawei.com>
> Cc: Hengqi Chen <hengqi.chen@gmail.com>
> Cc: Vladimir Isaev <isaev@synopsys.com>
> Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Cc: Kenta Tada <Kenta.Tada@sony.com>
> Cc: Florent Revest <revest@chromium.org>
>=20
> Andrii Nakryiko (25):
> =C2=A0 libbpf: add support for fetching up to 8 arguments in kprobes
> =C2=A0 libbpf: add 6th argument support for x86-64 in bpf_tracing.h
> =C2=A0 libbpf: fix arm and arm64 specs in bpf_tracing.h
> =C2=A0 libbpf: complete mips spec in bpf_tracing.h
> =C2=A0 libbpf: complete powerpc spec in bpf_tracing.h
> =C2=A0 libbpf: complete sparc spec in bpf_tracing.h
> =C2=A0 libbpf: complete riscv arch spec in bpf_tracing.h
> =C2=A0 libbpf: fix and complete ARC spec in bpf_tracing.h
> =C2=A0 libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
> =C2=A0 libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
> =C2=A0 selftests/bpf: validate arch-specific argument registers limits
> =C2=A0 libbpf: improve syscall tracing support in bpf_tracing.h
> =C2=A0 libbpf: define x86-64 syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define i386 syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define s390x syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define arm syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define arm64 syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define mips syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define powerpc syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define sparc syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define riscv syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define arc syscall regs spec in bpf_tracing.h
> =C2=A0 libbpf: define loongarch syscall regs spec in bpf_tracing.h
> =C2=A0 selftests/bpf: add 6-argument syscall tracing test
> =C2=A0 libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG default=
s
>=20
> =C2=A0tools/lib/bpf/bpf_tracing.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 301=
 +++++++++++++++-
> --
> =C2=A0.../bpf/prog_tests/test_bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0 18 =
+-
> =C2=A0.../bpf/prog_tests/uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 33 +-
> =C2=A0tools/testing/selftests/bpf/progs/bpf_misc.h=C2=A0 |=C2=A0 25 ++
> =C2=A0.../selftests/bpf/progs/bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0 26 =
++
> =C2=A0.../bpf/progs/test_uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 48 ++-
> =C2=A06 files changed, 405 insertions(+), 46 deletions(-)
>=20

With the following fixup for 24/25:

diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index c07c5c52d5fc..75ccdef9bc78 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -88,15 +88,33 @@ __u64 mmap_flags;
 __u64 mmap_fd;
 __u64 mmap_offset;
=20
+#if defined(bpf_target_s390)
+SEC("ksyscall/old_mmap")
+#else
 SEC("ksyscall/mmap")
+#endif
 int BPF_KSYSCALL(mmap_enter, void *addr, size_t length, int prot, int
flags,
                 int fd, off_t offset)
 {
        pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
+#if defined(bpf_target_s390)
+       unsigned long args[6] =3D {0};
+#endif
=20
        if (pid !=3D filter_pid)
                return 0;
=20
+#if defined(bpf_target_s390)
+       /* For __ARCH_WANT_SYS_OLD_MMAP, parse mmap_arg_struct. */
+       bpf_probe_read_user(args, sizeof(args), addr);
+       addr =3D (void *)args[0];
+       length =3D (size_t)args[1];
+       prot =3D (int)args[2];
+       flags =3D (int)args[3];
+       fd =3D (int)args[4];
+       offset =3D (off_t)args[5];
+#endif
+
        mmap_addr =3D (__u64)addr;
        mmap_length =3D length;
        mmap_prot =3D prot;

# ./test_progs -t syscall_macro
#19      bpf_syscall_macro:OK

Tested-by:=C2=A0Ilya Leoshkevich <iii@linux.ibm.com>  # s390x
