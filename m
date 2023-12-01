Return-Path: <bpf+bounces-16383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FC8800D2D
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 15:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8630B2130E
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C04D22305;
	Fri,  1 Dec 2023 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LuHKOrva"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B9310F3
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 06:32:25 -0800 (PST)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1EUfIF024642;
	Fri, 1 Dec 2023 14:32:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=4tLagUnOMdekCY60heBr/HX29EYimT3PFCkGgoz/pgk=;
 b=LuHKOrvarHli5UMYSFBEHEZA8UCoPd45Kd+/lq/H8tC8GEKvjfPS8TKzUvoghqe0aQX1
 lw15jUzPI2f1bqraSFS5BLVeww2OnQ+R4asrGAudyRNK+TNeSqPaSM+StnERF9GCLxse
 XzHwW156HrxLwb3j+fAIogyUpsQfFnbedb5WLjqDAuXy3VN4NAp0yY0+CYsr0YMMH5sg
 Q6uog1PZ3ZeKcHsPjlnZ9Kxq64E8KivYFBqyMhvU29+rVpzpgfetvqQfEM+/pPgnlPkP
 DOtCnNuzwuFSj7N+L6M2LrggCwlS9R8MrY1JvZ1r6xdfeQYNPgjOuorezq8k8d0b4gtR VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqh1v0js5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:32:01 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1EUgdO024812;
	Fri, 1 Dec 2023 14:32:00 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uqh1v0jrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:32:00 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B1Dp4Rp000739;
	Fri, 1 Dec 2023 14:31:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3uku8tnu2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 14:31:59 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B1EVvhd22348376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Dec 2023 14:31:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C93402004D;
	Fri,  1 Dec 2023 14:31:57 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EAC520043;
	Fri,  1 Dec 2023 14:31:57 +0000 (GMT)
Received: from [9.155.200.166] (unknown [9.155.200.166])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  1 Dec 2023 14:31:57 +0000 (GMT)
Message-ID: <a3e9cb8d96b663e9c110bdd6b90bdd37b92028d7.camel@linux.ibm.com>
Subject: Re: [PATCHv2 bpf 0/2] bpf: Fix prog_array_map_poke_run map poke
 update
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>, Song Liu
 <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, John Fastabend
 <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Stanislav
 Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Xu Kuohai
 <xukuohai@huawei.com>,
        Will Deacon <will@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>,
        Pu Lehui <pulehui@huawei.com>,
        =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
        Lee Jones
 <lee@kernel.org>
Date: Fri, 01 Dec 2023 15:31:57 +0100
In-Reply-To: <ZWnb8ptRW1DW6JLp@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
	 <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>
	 <ZWc7OHnLux47RpOr@krava> <ZWnb8ptRW1DW6JLp@krava>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3IXZQY5BSG55KhLhJETqZTqoJAwQaKK0
X-Proofpoint-ORIG-GUID: kyngso6S9ZpCa7liIQAxEJ-F1PFBCQ88
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_12,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxlogscore=820
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312010100

On Fri, 2023-12-01 at 14:13 +0100, Jiri Olsa wrote:
> On Wed, Nov 29, 2023 at 02:23:04PM +0100, Jiri Olsa wrote:
> > On Tue, Nov 28, 2023 at 11:44:33PM +0100, Ilya Leoshkevich wrote:
> > > On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> > > > hi,
> > > > this patchset fixes the issue reported in [0].
> > > >=20
> > > > For the actual fix in patch 2 I'm changing bpf_arch_text_poke
> > > > to
> > > > allow to skip
> > > > ip address check in patch 1. I considered adding separate
> > > > function
> > > > for that,
> > > > but because each arch implementation is bit different, adding
> > > > extra
> > > > arg seemed
> > > > like better option.
> > > >=20
> > > > v2 changes:
> > > > =C2=A0 - make it work for other archs
> > > >=20
> > > > thanks,
> > > > jirka
> > > >=20
> > > >=20
> > > > [0]
> > > > https://syzkaller.appspot.com/bug?extid=3D97a4fe20470e9bc30810
> > > > ---
> > > > Jiri Olsa (2):
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf: Add checkip argument to bpf_arc=
h_text_poke
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bpf, x64: Fix prog_array_map_poke_ru=
n map poke update
> > > >=20
> > > > =C2=A0arch/arm64/net/bpf_jit_comp.c=C2=A0=C2=A0 |=C2=A0 3 ++-
> > > > =C2=A0arch/riscv/net/bpf_jit_comp64.c |=C2=A0 5 +++--
> > > > =C2=A0arch/s390/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> > > > =C2=A0arch/x86/net/bpf_jit_comp.c=C2=A0=C2=A0=C2=A0=C2=A0 | 24 ++++=
+++++++++-----------
> > > > =C2=A0include/linux/bpf.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0kernel/bpf/arraymap.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 31 +++++++++++--------------
> > > > ------
> > > > =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0kernel/bpf/trampoline.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 12 ++++++------
> > > > =C2=A08 files changed, 39 insertions(+), 43 deletions(-)
> > >=20
> > > Would it be possible to add a minimized version of the reproducer
> > > as a
> > > testcase?
> >=20
> > there's reproducer I used in here:
> > =C2=A0 https://syzkaller.appspot.com/text?tag=3DReproC&x=3D1397180f6800=
00
> >=20
> > I can try, but not sure I'll be able to come up with something that
> > would fit as testcase.. I'll check
>=20
> the test below reproduces it for me.. the only tricky part is that
> I need to repeat the loop 10 times to trigger that on my setup..
> which is not terrible, but not great for a test I think
>=20
> jirka

The test looks useful to me. I think having magic repetition counts
like this 10 here is almost inevitable when trying to reproduce race
conditions. The test also runs quickly for me. You can have my

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>

in case you decide to make a formal patch.

