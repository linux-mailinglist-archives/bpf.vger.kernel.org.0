Return-Path: <bpf+bounces-9308-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E2779331C
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 02:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B757F1C2096D
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 00:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE6363C;
	Wed,  6 Sep 2023 00:57:40 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B062B
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 00:57:40 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B5ACE5
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 17:57:37 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3860bqLb031308;
	Wed, 6 Sep 2023 00:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AQUfjDymnEzHcEkEyx14iTM1gkXiOrKvp8oMWmdg9mY=;
 b=LPe4SmSRf6D9CFpy6sdg+RioEk2La1pKL3IvJ253NTs7DbeVjcRw7QkRJWYsLduGr9Ob
 gmLcIDZAZuh9T5odzUtILRTDUomDYMhPPxmgPJEPMre3uwqNO6XVXjf9mAqjjkjpBgwr
 n6A5PCWlXSuq+Ft6izoH3xMSDR4S+coLX2C53H0YwpMUb2Hl4SylvVc4/XthwtFQ9xNs
 QbbLsl4+MDsp2xrOt7tbn/k5Y4/ZvCmmPPSc/NUxl2ZXkJhkB5ZqFLNGfpuTiGXaBkg6
 MgT+t+h6LQ1+vBvIyR0QRh1qOr+q4Mguu4lXXr8zTvxrna+b3cdOFWFKnG/CyQH+AKaM KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxerqrkut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:57:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3860c3Pv000667;
	Wed, 6 Sep 2023 00:57:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxerqrkuj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:57:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3860DXjZ006611;
	Wed, 6 Sep 2023 00:57:20 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgvkeybd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Sep 2023 00:57:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3860vIZY18481774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 6 Sep 2023 00:57:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC09B2004B;
	Wed,  6 Sep 2023 00:57:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BCA820040;
	Wed,  6 Sep 2023 00:57:18 +0000 (GMT)
Received: from [9.171.26.12] (unknown [9.171.26.12])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  6 Sep 2023 00:57:17 +0000 (GMT)
Message-ID: <63746615ed810c4178014e572320d137692ac29a.camel@linux.ibm.com>
Subject: Re: [RFC PATCH bpf-next v4 0/4] bpf, x64: Fix tailcall infinite loop
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Leon Hwang <hffilwlqm@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, maciej.fijalkowski@intel.com
Cc: song@kernel.org, jakub@cloudflare.com, bpf@vger.kernel.org
Date: Wed, 06 Sep 2023 02:57:17 +0200
In-Reply-To: <6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com>
References: <20230903151448.61696-1-hffilwlqm@gmail.com>
	 <aa14035136254ce08bd605242173432394103abd.camel@linux.ibm.com>
	 <6203dd01-789d-f02c-5293-def4c1b18aef@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0tQDvnivGpFE0eb52NhBby7b98zuSENS
X-Proofpoint-ORIG-GUID: bsIVa7SpMF-yS55XTyiyj5JjzapGeiOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 adultscore=0
 mlxlogscore=923 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309060003
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-09-04 at 23:15 +0800, Leon Hwang wrote:
>=20
>=20
> On 2023/9/4 21:10, Ilya Leoshkevich wrote:
> > On Sun, 2023-09-03 at 23:14 +0800, Leon Hwang wrote:
> > > This patch series fixes a tailcall infinite loop on x64.
> > >=20
> > > From commit ebf7d1f508a73871 ("bpf, x64: rework pro/epilogue and
> > > tailcall
> > > handling in JIT"), the tailcall on x64 works better than before.
> > >=20
> > > From commit e411901c0b775a3a ("bpf: allow for tailcalls in BPF
> > > subprograms
> > > for x64 JIT"), tailcall is able to run in BPF subprograms on x64.
> > >=20
> > > From commit 5b92a28aae4dd0f8 ("bpf: Support attaching tracing BPF
> > > program
> > > to other BPF programs"), BPF program is able to trace other BPF
> > > programs.
> > >=20
> > > How about combining them all together?
> > >=20
> > > 1. FENTRY/FEXIT on a BPF subprogram.
> > > 2. A tailcall runs in the BPF subprogram.
> > > 3. The tailcall calls the subprogram's caller.
> > >=20
> > > As a result, a tailcall infinite loop comes up. And the loop
> > > would
> > > halt
> > > the machine.
> > >=20
> > > As we know, in tail call context, the tail_call_cnt propagates by
> > > stack
> > > and rax register between BPF subprograms. So do in trampolines.
> > >=20
> > > How did I discover the bug?
> > >=20
> > > From commit 7f6e4312e15a5c37 ("bpf: Limit caller's stack depth
> > > 256
> > > for
> > > subprogs with tailcalls"), the total stack size limits to around
> > > 8KiB.
> > > Then, I write some bpf progs to validate the stack consuming,
> > > that
> > > are
> > > tailcalls running in bpf2bpf and FENTRY/FEXIT tracing on
> > > bpf2bpf[1].
> > >=20
> > > At that time, accidently, I made a tailcall loop. And then the
> > > loop
> > > halted
> > > my VM. Without the loop, the bpf progs would consume over 8KiB
> > > stack
> > > size.
> > > But the _stack-overflow_ did not halt my VM.
> > >=20
> > > With bpf_printk(), I confirmed that the tailcall count limit did
> > > not
> > > work
> > > expectedly. Next, read the code and fix it.
> > >=20
> > > Finally, unfortunately, I only fix it on x64 but other arches. As
> > > a
> > > result, CI tests failed because this bug hasn't been fixed on
> > > s390x.
> > >=20
> > > Some helps on s390x are requested.
> >=20
> > I will take a look, thanks for letting me know.
>=20
> Great.
>=20
> > I noticed there was something peculiar in this area when
> > implementing
> > the trampoline:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Note 1: The callee c=
an increment the tail call counter,
> > but
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * we do not load it ba=
ck, since the x86 JIT does not do
> > this
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * either.>
> > but I thought that this was intentional.
>=20
> I do think so.
>=20
> But wait, should we load it back?
>=20
> Let me show a demo:
>=20
> struct {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__uint(type, BPF_MAP_TYPE=
_PROG_ARRAY);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__uint(max_entries, 4);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__uint(key_size, sizeof(_=
_u32));
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0__uint(value_size, sizeof=
(__u32));
> } jmp_table SEC(".maps");
>=20
> static __noinline
> int subprog_tail_01(struct __sk_buff *skb)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (load_byte(skb, 0))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call_static(skb, &jmp_table, 1);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call_static(skb, &jmp_table, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> }
>=20
> static __noinline
> int subprog_tail_23(struct __sk_buff *skb)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (load_byte(skb, 0))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call_static(skb, &jmp_table, 3);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call_static(skb, &jmp_table, 2);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 1;
> }
>=20
> int count0 =3D 0;
>=20
> SEC("tc")
> int classifier_01(struct __sk_buff *skb)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0count0++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return subprog_tail_01(sk=
b);
> }
>=20
> int count1 =3D 0;
>=20
> SEC("tc")
> int classifier_23(struct __sk_buff *skb)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0count1++;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return subprog_tail_23(sk=
b);
> }
>=20
> static __noinline
> int subprog_tailcall(struct __sk_buff *skb, int index)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0volatile int retval =3D 0=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bpf_tail_call(skb, &jmp_t=
able, index);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return retval;
> }
>=20
> SEC("tc")
> int entry(struct __sk_buff *skb)
> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subprog_tailcall(skb, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0subprog_tailcall(skb, 2);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
> }
>=20
> Finally, count0 is 33. And count1 is 33, too. It breaks the
> MAX_TAIL_CALL_CNT limit by the way tailcall in subprog.

Thanks for coming up with an example, I could not create something like
this back then and just left a note for the future.

> From 04fd61ab36ec065e ("bpf: allow bpf programs to tail-call other
> bpf
> programs"):
> The chain of tail calls can form unpredictable dynamic loops
> therefore
> tail_call_cnt is used to limit the number of calls and currently is
> set
> to 32.
>=20
> It seems like that MAX_TAIL_CALL_CNT limits the max tailcall
> hierarchy
> layers.
>=20
> So, should we load it back?

I wonder if the current behavior can lead to high system load in some
cases. The current limit on the number of instructions is 1M; with tail
calls it goes up to MAX_TAIL_CALL_CNT * 1M. If one uses the technique
above to the fullest extent, i.e., on each tail call hierarchy level,
can't one execute (2 ** MAX_TAIL_CALL_CNT) * 1M instructions as a
result?

> Thanks,
> Leon


