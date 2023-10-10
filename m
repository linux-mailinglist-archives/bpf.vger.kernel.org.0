Return-Path: <bpf+bounces-11841-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A917C41DF
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 22:49:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1E41C20C57
	for <lists+bpf@lfdr.de>; Tue, 10 Oct 2023 20:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153F7315BD;
	Tue, 10 Oct 2023 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PnRcJxGT"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7772186C
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 20:49:09 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C150294
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 13:49:07 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKkYOq007124;
	Tue, 10 Oct 2023 20:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LMaT7dIsL38zXXEa9WcASf113UIPTZP3HUT9X+blXhA=;
 b=PnRcJxGTRaRuBTxcEGGYPmOmCK0yRW7/LeiZis4ZwqAMLsBHQOiqRzrVTwAGcVfWimE+
 wvFVSlWs+8WWfCLFKZ20Kskph1n6tPNTzvjFEmKcV9pHBiOpBPCOFSEaekI8EgENUvRr
 O6nooMlLIR8DWN12h6vvji24vSXNNyGav1+PENJF5vvTT1VZFDP/jO/xunmI/R3cF8V2
 t5C2fAgnzYc7hjwkfjP0kMC6Mg89H4eIQkDQtmStDPvMBf/6dW8ecXAPS0xXj7sE4Dxh
 2m/3HKXJd3ggs8U196b/9CIfmN7q44nnR3EIHOejhDcuXVv3nVhMWDnwN0n8hLnqJnld jA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndr08d2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:48:51 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39AKl8PE010071;
	Tue, 10 Oct 2023 20:48:50 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tndr08d2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:48:50 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39AKdGof023021;
	Tue, 10 Oct 2023 20:48:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkmc1jhu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Oct 2023 20:48:49 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39AKmlT343975096
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Oct 2023 20:48:47 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72CDA2004B;
	Tue, 10 Oct 2023 20:48:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B83392004D;
	Tue, 10 Oct 2023 20:48:46 +0000 (GMT)
Received: from [9.171.0.76] (unknown [9.171.0.76])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Oct 2023 20:48:46 +0000 (GMT)
Message-ID: <7a9576222aa40b1c84ad3a9ba3e64011d1a04d41.camel@linux.ibm.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Avoid unnecessary -EBUSY from
 htab_lock_bucket
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Song Liu <songliubraving@meta.com>,
        Andrii Nakryiko
	 <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Song Liu
 <song@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko
 <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team
 <kernel-team@meta.com>, Tejun Heo <tj@kernel.org>
Date: Tue, 10 Oct 2023 22:48:46 +0200
In-Reply-To: <92BDCF92-3219-4EDA-A6F8-1EA8D88BEE41@fb.com>
References: <20231004004350.533234-1-song@kernel.org>
	 <CAEf4BzbM6yvBwT3-_7NkzKgqdoXc_G3+_5Fnv96b_2U68=Hunw@mail.gmail.com>
	 <CAADnVQKMxUg3Djh8UjRPdw7RE6yOiNUgYGjG_eCPqMtnguO+fA@mail.gmail.com>
	 <095DCE9A-BC4D-415F-81F6-B6C20BA08B9A@fb.com>
	 <FCAD3D3A-B230-40D8-A422-DED507B95C89@fb.com>
	 <A53BABCE-A22D-40B0-91BA-009B54AB8F09@fb.com>
	 <92BDCF92-3219-4EDA-A6F8-1EA8D88BEE41@fb.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iehmkd-DHl6WwefumDRSos2KZuVDR1OP
X-Proofpoint-GUID: 0hdGjLRblERTODxi7Uv9JtBvTAEGZ8cm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-10_16,2023-10-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 mlxscore=0 suspectscore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310100162
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-10-06 at 01:15 +0000, Song Liu wrote:
> > On Oct 4, 2023, at 6:50 PM, Song Liu <songliubraving@meta.com>
> > wrote:
> > > On Oct 4, 2023, at 5:11 PM, Song Liu <songliubraving@meta.com>
> > > wrote:
>=20
> [...]
>=20
> > > > > >=20
> > > > > > > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > > > > > index a8c7e1c5abfa..fd8d4b0addfc 100644
> > > > > > > --- a/kernel/bpf/hashtab.c
> > > > > > > +++ b/kernel/bpf/hashtab.c
> > > > > > > @@ -155,13 +155,15 @@ static inline int
> > > > > > > htab_lock_bucket(const struct bpf_htab *htab,
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 hash =3D hash & min_t(u32, HASHTAB_M=
AP_LOCK_MASK,
> > > > > > > htab->n_buckets - 1);
> > > > > > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 preempt_disable();
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_save(flags);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 if (unlikely(__this_cpu_inc_return(*=
(htab-
> > > > > > > >map_locked[hash])) !=3D 1)) {
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 __this_cpu_dec(*(htab->map_locked[hash]));
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 local_irq_restore(flags);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 preempt_enable();
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return -EBUSY;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > >=20
> > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raw_spin_lock_irqsave(&=
b->raw_lock, flags);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 raw_spin_lock(&b->raw_l=
ock);
> > > > >=20
> > > > > Song,
> > > > >=20
> > > > > take a look at s390 crash in BPF CI.
> > > > > I suspect this patch is causing it.
> > > >=20
> > > > It indeed looks like triggered by this patch. But I haven't
> > > > figured
> > > > out why it happens. v1 seems ok for the same tests.=20
>=20
> Update my findings today:
>=20
> I tried to reproduce the issue locally with qemu on my server
> (x86_64).=20
> I got the following artifacts:
>=20
> 1. bzImage and selftests from CI: (need to login to GitHub)
> https://github.com/kernel-patches/bpf/suites/16885416280/artifacts/964765=
766
>=20
> 2. cross compiler:
> https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/13.2=
.0/x86_64-gcc-13.2.0-nolibc-s390-linux.tar.gz
>=20
> 3. root image:
> https://libbpf-ci.s3.us-west-1.amazonaws.com/libbpf-vmtest-rootfs-2022.10=
.23-bullseye-s390x.tar.zst
>=20
> With bzImage compiled in CI, I can reproduce the issue with qemu.=20
> However, if I compile the kernel locally with the cross compiler
> (with .config from CI, and then olddefconfig), the issue cannot=20
> be reproduced. I have attached the two .config files here. They=20
> look very similar, except the compiler version:
>=20
> -CONFIG_CC_VERSION_TEXT=3D"gcc (Ubuntu 9.4.0-1ubuntu1~20.04.2) 9.4.0"
> +CONFIG_CC_VERSION_TEXT=3D"s390-linux-gcc (GCC) 13.2.0"
>=20
> So far, I still think v2 is the right patch. But I really cannot
> explain the issue on the bzImage from the CI. I cannot make much=20
> sense out of the s390 assembly code either. (TIL: gdb on my x86
> server can disassem s390 binary).=20
>=20
> Ilya,=20
>=20
> Could you please take a look at this?
>=20
> Thanks,
> Song
>=20
> PS: the root image from the CI is not easy to use. Hopefully you
> have something better than that.

Hi,

Thanks for posting the analysis and links to the artifacts, that saved
me quite some time. The crash is caused by a backchain issue in the
trampoline code and has nothing to do with your patch; I've posted the
fix here [1].

The difference between compilers is most likely caused by different
inlining decisions around lookup_elem_raw(). When it's inlined, the
test becomes a no-op.

Regarding GDB, Debian and Ubuntu have gdb-multiarch package. On Fedora
one has to build it from source; the magic binutils-gdb configure flag
is --enable-targets=3Dall.

Regarding the development environment, in this case I've sidestepped
the need for a proper image by putting everything into initramfs:

workdir=3D$(mktemp -d)
tar -C "$workdir" -xf libbpf-vmtest-rootfs-2022.10.23-bullseye-
s390x.tar.zst
rsync -a selftests "$workdir"
(cd "$workdir" && find . | cpio -o --format=3Dnewc -R root:root)
>initrd.cpio
qemu-system-s390x -accel kvm -smp 2 -m 4G -kernel kbuild-
output/arch/s390/boot/bzImage -nographic -append 'nokaslr console=3DttyS1
rdinit=3D/bin/sh' -initrd initrd.cpio -s

For the regular development I have a different setup, with a
non-minimal Debian install inside the guest, and the testcases mounted
from the host using 9p.

Best regards,
Ilya

[1]
https://lore.kernel.org/bpf/20231010203512.385819-1-iii@linux.ibm.com/

