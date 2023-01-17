Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4442966DA54
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 10:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236109AbjAQJwo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 04:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236019AbjAQJwn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 04:52:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989FE2A9AB
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 01:52:40 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H92rls023993;
        Tue, 17 Jan 2023 09:51:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=o4kP+DIs7EUDO6dBqD1YhcerybZlwtCAUWxnCzqN8GE=;
 b=LvoOjwk3qXk1U8BftdpNREMJyFG06cJrwWVsUhnwKLL4tfO0G4cq7x7hTyTFcrDEMQP5
 hOlEkZCDzpw9ZDV+uWtGheYmgtqgLxJvt4NIFGQqoLfHqiV24l2B0sP7iC8OPC+GzWt4
 O4D/EEpWzVnAOBSxYYcROB6Ikzl4oft0Ytml2RuESx7/dLQ7eiD/l3BloGcHfcKCtr+3
 LdjkBaDDEQX+JXcmQp+9gh69Jmvpgn0ToKFaNFrnoleU5I9/5Y45bJb4Dej+1YDPmgMn
 v+ti29Zet74L3xNNzC7yXTJ/IPysEVjlDhhgedkE24NurRiOvQspk+EgwaFN2a/JGnXV AA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5kcaqr0a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:51:44 +0000
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30H9m1an008033;
        Tue, 17 Jan 2023 09:51:44 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n5kcaqqyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:51:43 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30GFTS35002145;
        Tue, 17 Jan 2023 09:51:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3n3m16jme9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 09:51:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30H9pd3o46596570
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 09:51:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0333020040;
        Tue, 17 Jan 2023 09:51:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 474CE2004B;
        Tue, 17 Jan 2023 09:51:38 +0000 (GMT)
Received: from [9.171.3.141] (unknown [9.171.3.141])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 17 Jan 2023 09:51:38 +0000 (GMT)
Message-ID: <5f212c293e08e91147b240e2ea41e168344897c9.camel@linux.ibm.com>
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
Date:   Tue, 17 Jan 2023 10:51:37 +0100
In-Reply-To: <ed8ce036cd61741170dffe3fa733cd98d1970302.camel@linux.ibm.com>
References: <20230113083404.4015489-1-andrii@kernel.org>
         <f810f5c6a43af954464cedbe25d523896a59d500.camel@linux.ibm.com>
         <ed8ce036cd61741170dffe3fa733cd98d1970302.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5tAxUrMs9moCrX3k_18GT-DF6HCw46p0
X-Proofpoint-GUID: svi2yXWA5Dt1AVQW6StEcBUYVq0HW0AY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_04,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170080
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-01-16 at 23:37 +0100, Ilya Leoshkevich wrote:
> On Mon, 2023-01-16 at 23:09 +0100, Ilya Leoshkevich wrote:
> > On Fri, 2023-01-13 at 00:33 -0800, Andrii Nakryiko wrote:
> > > This patch set fixes and extends libbpf's bpf_tracing.h support
> > > for
> > > tracing
> > > arguments of kprobes/uprobes, and syscall as a special case.
> > >=20
> > > Depending on the architecture, anywhere between 3 and 8 arguments
> > > can
> > > be
> > > passed to a function in registers (so relevant to kprobes and
> > > uprobes), but
> > > before this patch set libbpf's macros in bpf_tracing.h only
> > > supported
> > > up to
> > > 5 arguments, which is limiting in practice. This patch set
> > > extends
> > > bpf_tracing.h to support up to 8 arguments, if architecture
> > > allows.
> > > This
> > > includes explicit PT_REGS_PARMx() macro family, as well as
> > > BPF_KPROBE() macro.
> > >=20
> > > Now, with tracing syscall arguments situation is sometimes quite
> > > different.
> > > For a lot of architectures syscall argument passing through
> > > registers
> > > differs
> > > from function call sequence at least a little. For i386 it
> > > differs
> > > *a
> > > lot*.
> > > This patch set addresses this issue across all currently
> > > supported
> > > architectures and hopefully fixes existing issues. syscall(2)
> > > manpage
> > > defines
> > > that either 6 or 7 arguments can be supported, depending on
> > > architecture, so
> > > libbpf defines 6 or 7 registers per architecture to be used to
> > > fetch
> > > syscall
> > > arguments.
> > >=20
> > > Also, BPF_UPROBE and BPF_URETPROBE are introduced as part of this
> > > patch set.
> > > They are aliases for BPF_KPROBE and BPF_KRETPROBE (as mechanics
> > > of
> > > argument
> > > fetching of kernel functions and user-space functions are
> > > identical),
> > > but it
> > > allows BPF users to have less confusing BPF-side code when
> > > working
> > > with
> > > uprobes.
> > >=20
> > > For both sets of changes selftests are extended to test these new
> > > register
> > > definitions to architecture-defined limits. Unfortunately I don't
> > > have ability
> > > to test it on all architectures, and BPF CI only tests 3
> > > architecture
> > > (x86-64,
> > > arm64, and s390x), so it would be greatly appreciated if CC'ed
> > > people
> > > can help
> > > review and test changes on architectures they are familiar with
> > > (and
> > > maybe
> > > have direct access to for testing). Thank you.
> > >=20
> > > Cc: Alan Maguire <alan.maguire@oracle.com>
> > > Cc: Ilya Leoshkevich <iii@linux.ibm.com>
> > > Cc: Pu Lehui <pulehui@huawei.com>
> > > Cc: Hengqi Chen <hengqi.chen@gmail.com>
> > > Cc: Vladimir Isaev <isaev@synopsys.com>
> > > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> > > Cc: Kenta Tada <Kenta.Tada@sony.com>
> > > Cc: Florent Revest <revest@chromium.org>
> > >=20
> > > Andrii Nakryiko (25):
> > > =C2=A0 libbpf: add support for fetching up to 8 arguments in kprobes
> > > =C2=A0 libbpf: add 6th argument support for x86-64 in bpf_tracing.h
> > > =C2=A0 libbpf: fix arm and arm64 specs in bpf_tracing.h
> > > =C2=A0 libbpf: complete mips spec in bpf_tracing.h
> > > =C2=A0 libbpf: complete powerpc spec in bpf_tracing.h
> > > =C2=A0 libbpf: complete sparc spec in bpf_tracing.h
> > > =C2=A0 libbpf: complete riscv arch spec in bpf_tracing.h
> > > =C2=A0 libbpf: fix and complete ARC spec in bpf_tracing.h
> > > =C2=A0 libbpf: complete LoongArch (loongarch) spec in bpf_tracing.h
> > > =C2=A0 libbpf: add BPF_UPROBE and BPF_URETPROBE macro aliases
> > > =C2=A0 selftests/bpf: validate arch-specific argument registers limit=
s
> > > =C2=A0 libbpf: improve syscall tracing support in bpf_tracing.h
> > > =C2=A0 libbpf: define x86-64 syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define i386 syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define s390x syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define arm syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define arm64 syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define mips syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define powerpc syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define sparc syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define riscv syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define arc syscall regs spec in bpf_tracing.h
> > > =C2=A0 libbpf: define loongarch syscall regs spec in bpf_tracing.h
> > > =C2=A0 selftests/bpf: add 6-argument syscall tracing test
> > > =C2=A0 libbpf: clean up now not needed __PT_PARM{1-6}_SYSCALL_REG
> > > defaults
> > >=20
> > > =C2=A0tools/lib/bpf/bpf_tracing.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | =
301
> > > +++++++++++++++-
> > > --
> > > =C2=A0.../bpf/prog_tests/test_bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0=
 18 +-
> > > =C2=A0.../bpf/prog_tests/uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 33 +-
> > > =C2=A0tools/testing/selftests/bpf/progs/bpf_misc.h=C2=A0 |=C2=A0 25 +=
+
> > > =C2=A0.../selftests/bpf/progs/bpf_syscall_macro.c=C2=A0=C2=A0 |=C2=A0=
 26 ++
> > > =C2=A0.../bpf/progs/test_uprobe_autoattach.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 48 ++-
> > > =C2=A06 files changed, 405 insertions(+), 46 deletions(-)
> > >=20
> >=20
> > With the following fixup for 24/25:

[...]

> > Tested-by:=C2=A0Ilya Leoshkevich <iii@linux.ibm.com>=C2=A0 # s390x
>=20
> While the above fixup works, I realized that it's ugly. It's better
> to
> admit that mmap and old_mmap are different syscalls and create a
> different probe, even if it means duplicating pid filtering code:

[...]

Sorry, I'm being dense. Both fixups defeat the purpose of having this
test, because they don't use all 6 register arguments. We need to
choose a different syscall; I believe splice() fits the bill. The other
alternatives that I rejected were:

- clone() - argument order is messy;
- recvfrom() - s390x uses socketcall instead;
- ipc() - doesn't seem to be available on aarch64.

The following worked for me:

diff --git
a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
index e18dd82eb801..2900c5e9a016 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpf_syscall_macro.c
@@ -1,20 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright 2022 Sony Group Corporation */
+#define _GNU_SOURCE
+#include <fcntl.h>
 #include <sys/prctl.h>
-#include <sys/mman.h>
 #include <test_progs.h>
 #include "bpf_syscall_macro.skel.h"
=20
 void test_bpf_syscall_macro(void)
 {
 	struct bpf_syscall_macro *skel =3D NULL;
-	int err, page_size =3D getpagesize();
+	int err;
 	int exp_arg1 =3D 1001;
 	unsigned long exp_arg2 =3D 12;
 	unsigned long exp_arg3 =3D 13;
 	unsigned long exp_arg4 =3D 14;
 	unsigned long exp_arg5 =3D 15;
-	void *r;
+	loff_t off_in, off_out;
+	ssize_t r;
=20
 	/* check whether it can open program */
 	skel =3D bpf_syscall_macro__open();
@@ -71,18 +73,17 @@ void test_bpf_syscall_macro(void)
 	ASSERT_EQ(skel->bss->arg4_syscall, exp_arg4,
"BPF_KPROBE_SYSCALL_arg4");
 	ASSERT_EQ(skel->bss->arg5_syscall, exp_arg5,
"BPF_KPROBE_SYSCALL_arg5");
=20
-	r =3D mmap((void *)0x12340000, 3 * page_size, PROT_READ |
PROT_WRITE,
-		 MAP_PRIVATE, -42, 5 * page_size);
+	r =3D splice(-42, &off_in, 42, &off_out, 0x12340000,
SPLICE_F_NONBLOCK);
 	err =3D -errno;
-	ASSERT_EQ(r, MAP_FAILED, "mmap_res");
-	ASSERT_EQ(err, -EBADF, "mmap_err");
+	ASSERT_EQ(r, -1, "splice_res");
+	ASSERT_EQ(err, -EBADF, "splice_err");
=20
-	ASSERT_EQ(skel->bss->mmap_addr, 0x12340000, "mmap_arg1");
-	ASSERT_EQ(skel->bss->mmap_length, 3 * page_size, "mmap_arg2");
-	ASSERT_EQ(skel->bss->mmap_prot, PROT_READ | PROT_WRITE,
"mmap_arg3");
-	ASSERT_EQ(skel->bss->mmap_flags, MAP_PRIVATE, "mmap_arg4");
-	ASSERT_EQ(skel->bss->mmap_fd, -42, "mmap_arg5");
-	ASSERT_EQ(skel->bss->mmap_offset, 5 * page_size, "mmap_arg6");
+	ASSERT_EQ(skel->bss->splice_fd_in, -42, "splice_arg1");
+	ASSERT_EQ(skel->bss->splice_off_in, (__u64)&off_in,
"splice_arg2");
+	ASSERT_EQ(skel->bss->splice_fd_out, 42, "splice_arg3");
+	ASSERT_EQ(skel->bss->splice_off_out, (__u64)&off_out,
"splice_arg4");
+	ASSERT_EQ(skel->bss->splice_len, 0x12340000, "splice_arg5");
+	ASSERT_EQ(skel->bss->splice_flags, SPLICE_F_NONBLOCK,
"splice_arg6");
=20
 cleanup:
 	bpf_syscall_macro__destroy(skel);
diff --git a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
index c07c5c52d5fc..1a476d8ed354 100644
--- a/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
+++ b/tools/testing/selftests/bpf/progs/bpf_syscall_macro.c
@@ -81,28 +81,28 @@ int BPF_KSYSCALL(prctl_enter, int option, unsigned
long arg2,
 	return 0;
 }
=20
-__u64 mmap_addr;
-__u64 mmap_length;
-__u64 mmap_prot;
-__u64 mmap_flags;
-__u64 mmap_fd;
-__u64 mmap_offset;
-
-SEC("ksyscall/mmap")
-int BPF_KSYSCALL(mmap_enter, void *addr, size_t length, int prot, int
flags,
-		 int fd, off_t offset)
+__u64 splice_fd_in;
+__u64 splice_off_in;
+__u64 splice_fd_out;
+__u64 splice_off_out;
+__u64 splice_len;
+__u64 splice_flags;
+
+SEC("ksyscall/splice")
+int BPF_KSYSCALL(splice_enter, int fd_in, loff_t *off_in, int fd_out,
+		 loff_t *off_out, size_t len, unsigned int flags)
 {
 	pid_t pid =3D bpf_get_current_pid_tgid() >> 32;
=20
 	if (pid !=3D filter_pid)
 		return 0;
=20
-	mmap_addr =3D (__u64)addr;
-	mmap_length =3D length;
-	mmap_prot =3D prot;
-	mmap_flags =3D flags;
-	mmap_fd =3D fd;
-	mmap_offset =3D offset;
+	splice_fd_in =3D fd_in;
+	splice_off_in =3D (__u64)off_in;
+	splice_fd_out =3D fd_out;
+	splice_off_out =3D (__u64)off_out;
+	splice_len =3D len;
+	splice_flags =3D flags;
=20
 	return 0;
 }
--=20
2.39.0

Best regards,
Ilya
