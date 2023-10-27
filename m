Return-Path: <bpf+bounces-13411-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F8C7D930C
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 11:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57D6282068
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 09:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4F3156E0;
	Fri, 27 Oct 2023 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=epfl.ch header.i=@epfl.ch header.b="fJZvNwSm"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B4E156C8
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 09:06:45 +0000 (UTC)
Received: from smtp5.epfl.ch (smtp5.epfl.ch [IPv6:2001:620:618:1e0:1:80b2:e034:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2361793
	for <bpf@vger.kernel.org>; Fri, 27 Oct 2023 02:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=epfl.ch;
      s=epfl; t=1698397595;
      h=From:To:CC:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
      bh=F2K3pWIfH43bq8/JbURV5Rgivts8nuQvamDePMRWdIc=;
      b=fJZvNwSmQjv4VMLLP27K1rVg8kQotriJ4SgvUPlcJ2lwDIsliI6zl1Bfvk3Wmh8Oe
        PsxFjjr6EH9Cljn/ihdGlH8H8sErx2o2zrK170vXl1Upi65l8ssyaVtyuaTCk+eZh
        0guKaHo+n3sAavRo1Dnv9r+kYSYl2o8oEpzuTZjfc=
Received: (qmail 27896 invoked by uid 107); 27 Oct 2023 09:06:35 -0000
Received: from ax-snat-224-158.epfl.ch (HELO ewa01.intranet.epfl.ch) (192.168.224.158) (TLS, AES256-GCM-SHA384 cipher)
  by mail.epfl.ch (AngelmatoPhylax SMTP proxy) with ESMTPS; Fri, 27 Oct 2023 11:06:35 +0200
X-EPFL-Auth: rEMj2ymelelJDBr08IL1bcN2s9meCtg2ov3OCykhANRg3zYyCNQ=
Received: from ewa07.intranet.epfl.ch (128.178.224.178) by
 ewa01.intranet.epfl.ch (128.178.224.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 27 Oct 2023 11:06:34 +0200
Received: from ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a]) by
 ewa07.intranet.epfl.ch ([fe80::f470:9b62:7382:7f3a%4]) with mapi id
 15.01.2507.031; Fri, 27 Oct 2023 11:06:34 +0200
From: Tao Lyu <tao.lyu@epfl.ch>
To: "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>
CC: "ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "song@kernel.org"
	<song@kernel.org>, "yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>, "sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "mykolal@fb.com" <mykolal@fb.com>, "bpf@vger.kernel.org"
	<bpf@vger.kernel.org>, Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>,
	"mathias.payer@nebelwelt.net" <mathias.payer@nebelwelt.net>,
	"meng.xu.cs@uwaterloo.ca" <meng.xu.cs@uwaterloo.ca>
Subject: Re: [PATCH] Accept program in priv mode when returning from subprog
 with r10 marked as precise
Thread-Topic: [PATCH] Accept program in priv mode when returning from subprog
 with r10 marked as precise
Thread-Index: AQHaA6Ed/LIYTErb00uqRqdGvRmit7BVIVoAgAg8zTA=
Date: Fri, 27 Oct 2023 09:06:34 +0000
Message-ID: <a1c717381a0049da9f5472f691477ba8@epfl.ch>
References: <20231020220216.263948-1-tao.lyu@epfl.ch>,<CAEf4Bzb6uXiKK4=1++9Lu=GyfU1Co6VcqRwNO8PsQL=TzGzs-A@mail.gmail.com>
In-Reply-To: <CAEf4Bzb6uXiKK4=1++9Lu=GyfU1Co6VcqRwNO8PsQL=TzGzs-A@mail.gmail.com>
Accept-Language: en-US, fr-CH
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-originating-ip: [128.178.116.141]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>>
>> There is another issue about the backtracking.
>> When uploading the following program under privilege mode,
>> the verifier reports a "verifier backtracking bug".
>>
>> 0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>> 0: (85) call pc+2
>> caller:
>>=A0 R10=3Dfp0
>> callee:
>>=A0 frame1: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>> 3: frame1:
>> 3: (bf) r3 =3D r10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ; frame1: R3_w=3Dfp0 R10=3Dfp0
>> 4: (bc) w0 =3D w10=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0 ; frame1: R0_w=3Dscalar(umax=3D4294967295,var_off=3D(0x0; 0xfffff=
fff)) R10=3Dfp0
>> 5: (0f) r3 +=3D r0
>> mark_precise: frame1: last_idx 5 first_idx 0 subseq_idx -1
>> mark_precise: frame1: regs=3Dr0 stack=3D before 4: (bc) w0 =3D w10
>> mark_precise: frame1: regs=3Dr10 stack=3D before 3: (bf) r3 =3D r10
>> mark_precise: frame1: regs=3Dr10 stack=3D before 0: (85) call pc+2
>> BUG regs 400
>>
>> This bug is manifested by the following check:
>>
>> if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>>=A0=A0=A0=A0 verbose(env, "BUG regs %x\n", bt_reg_mask(bt));
>>=A0=A0=A0=A0 WARN_ONCE(1, "verifier backtracking bug");
>>=A0=A0=A0=A0 return -EFAULT;
>> }
>>
>> Since the verifier allows add operation on stack pointers,
>> it shouldn't show this WARNING and reject the program.
>>
>> I fixed it by skipping the warning if it's privilege mode and only r10 i=
s marked as precise.
>>
>
>See my reply to your other email. It would be nice if you can rewrite
>your tests in inline assembly, it would be easier to follow and debug.
>

Sorry, I'm new to this community.=20
Could you explain a little bit more about what the inline assembly is?
I wrote the test confirming to the test cases under "tools/testing/selftest=
s/bpf".

>I think your fix is papering over the fact that we don't recognize
>non-r10 stack access. Once we fix that, we shouldn't need extra hacks.
>So let's solve the underlying problem first.

Sure, we can fix the non-r10 stack access first.

However, the bug here is not related to the r10 stack access tracking, as t=
here is no stack access in the test case.
The root cause is that when meeting subprog calling instruction, the verifi=
er asserts that r10 can't be marked as precise.
However, under privileged mode, the verifier allows arithmetic operations (=
e.g., sub and add) on stack pointers, and thus, it's legal that r10 can be =
marked as precise.
In this situation, the verifier might incorrectly reject programs.

Solutions for this issue:
1) Never mark r10 as precise during backtracking
2) Modify this assertion so that under privileged mode, even if the verifie=
r sees r10 is marked as precise, it does throw the WARNING.

The patch I provided is the second solution.

>> Signed-off-by: Tao Lyu <tao.lyu@epfl.ch>
>> ---
>>=A0 kernel/bpf/verifier.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 4 +++-
>>=A0 .../bpf/verifier/ret-without-checing-r10.c=A0=A0=A0=A0=A0=A0 | 16 +++=
+++++++++++++
>>=A0 2 files changed, 19 insertions(+), 1 deletion(-)
>>=A0 create mode 100644 tools/testing/selftests/bpf/verifier/ret-without-c=
hecing-r10.c
>>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index e777f50401b6..1ce80cdc4f1d 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -3495,6 +3495,7 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>>=A0=A0=A0=A0=A0=A0=A0=A0 u32 dreg =3D insn->dst_reg;
>>=A0=A0=A0=A0=A0=A0=A0=A0 u32 sreg =3D insn->src_reg;
>>=A0=A0=A0=A0=A0=A0=A0=A0 u32 spi, i;
>> +=A0=A0=A0=A0=A0=A0 u32 reg_mask;
>>
>>=A0=A0=A0=A0=A0=A0=A0=A0 if (insn->code =3D=3D 0)
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
>> @@ -3621,7 +3622,8 @@ static int backtrack_insn(struct bpf_verifier_env =
*env, int idx, int subseq_idx,
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * precise, r0 and r6-r10 or any stack slot in
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 * the current frame should be zero by now
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if (bt_reg_mask(bt) & ~BPF_REGMASK_ARGS) {
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 reg_mask =3D bt_reg_mask(bt) & ~BPF_REGMASK_ARGS;
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 if (reg_mask && !((reg_mask =3D=3D 1 << BPF_REG_10) &=
& env->allow_ptr_leaks)) {
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 verbose(env, "BUG regs %x\=
n", bt_reg_mask(bt));
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ONCE(1, "verifier bac=
ktracking bug");
>>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EFAULT;
>> diff --git a/tools/testing/selftests/bpf/verifier/ret-without-checing-r1=
0.c b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
>> new file mode 100644
>> index 000000000000..56e529cf922b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/verifier/ret-without-checing-r10.c
>> @@ -0,0 +1,16 @@
>> +{
>> +=A0 "pointer arithmetic: when returning from subprog in priv, do not ch=
ecking r10",
>> +=A0 .insns =3D {
>> +=A0=A0=A0=A0=A0=A0 BPF_CALL_REL(2),
>> +=A0=A0=A0=A0=A0=A0 BPF_MOV64_IMM(BPF_REG_0, 0),
>> +=A0=A0=A0=A0=A0=A0 BPF_EXIT_INSN(),
>> +=A0=A0=A0=A0=A0=A0 BPF_MOV64_REG(BPF_REG_3, BPF_REG_10),
>> +=A0=A0=A0=A0=A0=A0 BPF_MOV32_REG(BPF_REG_0, BPF_REG_10),
>> +=A0=A0=A0=A0=A0=A0 BPF_ALU64_REG(BPF_ADD, BPF_REG_3, BPF_REG_0),
>> +=A0=A0=A0=A0=A0=A0 BPF_MOV64_IMM(BPF_REG_0, 0),
>> +=A0=A0=A0=A0=A0=A0 BPF_EXIT_INSN(),
>> +=A0 },
>> +=A0 .result=A0 =3D ACCEPT,
>> +=A0 .result_unpriv =3D REJECT,
>> +=A0 .errstr_unpriv =3D "loading/calling other bpf or kernel functions a=
re allowed for CAP_BPF and CAP_SYS_ADMIN",
>> +},
>> --
>> 2.25.1
>>

