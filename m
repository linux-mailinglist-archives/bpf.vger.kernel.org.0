Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB12C663B8D
	for <lists+bpf@lfdr.de>; Tue, 10 Jan 2023 09:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjAJIpX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Jan 2023 03:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJIox (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Jan 2023 03:44:53 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E70038AC0;
        Tue, 10 Jan 2023 00:44:52 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A8gAPX007099;
        Tue, 10 Jan 2023 08:44:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=bPbVLnrZeHjCvgCyG+9ZQ+MmOB41TCBedqDoORx88c8=;
 b=cKETTAOyvt9K1taRwRf2EAht24kLfEqOmWXTB2V1N9wnmnQHUTN2IvHuHPvSnWLk2Byc
 TZOQ6JXgVWqd26KQpowMnfS/f2Hnajuk4PISqatpz6bv2nZgMg/mY+Vq0CB1LHuDaxV2
 b44T6INTdDl/TjGhouARGn8Nrlse8wadhOiDPuBmcIN2o0a5z+ASfNv/LLmApPAFK3tG
 cirRJYiPDUAAd70d2MyMkEhMp0Q2jYsRxW02OLukZfG/7gwmTS8JN8YauqRVneiYGBZj
 o9GHOKlCcIkNe0HLkHOhq2kx7LAhFxnCgLF+fbd3hRppbfonVG8KqcffIU/sntOHzqUj eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n14qx01gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 08:44:24 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30A8iDtF012748;
        Tue, 10 Jan 2023 08:44:24 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3n14qx01fk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 08:44:23 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 309Nedo1022493;
        Tue, 10 Jan 2023 08:44:21 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3my0c6u735-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 08:44:21 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30A8iIPl16580940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jan 2023 08:44:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDDF12004F;
        Tue, 10 Jan 2023 08:44:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7492420040;
        Tue, 10 Jan 2023 08:44:18 +0000 (GMT)
Received: from localhost (unknown [9.124.31.92])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 10 Jan 2023 08:44:18 +0000 (GMT)
Date:   Tue, 10 Jan 2023 14:14:17 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v1 06/10] powerpc/bpf: Perform complete extra passes to
 update addresses
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>,
        =?iso-8859-1?q?Yonghong=0A?= Song <yhs@fb.com>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
        <c13ebeb4d5d169bda6d1d60ccaa6cc956308308d.1669881248.git.christophe.leroy@csgroup.eu>
        <1670926819.9nqhz2fj7v.naveen@linux.ibm.com>
        <57406145-4199-00f7-8593-da2f498116f1@csgroup.eu>
In-Reply-To: <57406145-4199-00f7-8593-da2f498116f1@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1673339740.lyeaje9o3l.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5GlDzDdghBRO1dRuKdtsYrLZ3eZ64pI1
X-Proofpoint-GUID: ubhntUnEakEvEpFPP0ZiK6Y0MHgLRnX9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_02,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
>=20
>=20
> Le 13/12/2022 =C3=A0 11:23, Naveen N. Rao a =C3=A9crit=C2=A0:
>> Christophe Leroy wrote:
>>> BPF core calls the jit compiler again for an extra pass in order
>>> to properly set subprog addresses.
>>>
>>> Unlike other architectures, powerpc only updates the addresses
>>> during that extra pass. It means that holes must have been left
>>> in the code in order to enable the maximum possible instruction
>>> size.
>>>
>>> In order avoid waste of space, and waste of CPU time on powerpc
>>> processors on which the NOP instruction is not 0-cycle, perform
>>> two real additional passes.
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>> =C2=A0arch/powerpc/net/bpf_jit_comp.c | 85 ----------------------------=
-----
>>> =C2=A01 file changed, 85 deletions(-)
>>>
>>> diff --git a/arch/powerpc/net/bpf_jit_comp.c=20
>>> b/arch/powerpc/net/bpf_jit_comp.c
>>> index 43e634126514..8833bf23f5aa 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>>> @@ -23,74 +23,6 @@ static void bpf_jit_fill_ill_insns(void *area,=20
>>> unsigned int size)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 memset32(area, BREAKPOINT_INSTRUCTION, size / =
4);
>>> =C2=A0}
>>>
>>> -/* Fix updated addresses (for subprog calls, ldimm64, et al) during=20
>>> extra pass */
>>> -static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct codegen_context *ctx, u32 *a=
ddrs)
>>> -{
>>> -=C2=A0=C2=A0=C2=A0 const struct bpf_insn *insn =3D fp->insnsi;
>>> -=C2=A0=C2=A0=C2=A0 bool func_addr_fixed;
>>> -=C2=A0=C2=A0=C2=A0 u64 func_addr;
>>> -=C2=A0=C2=A0=C2=A0 u32 tmp_idx;
>>> -=C2=A0=C2=A0=C2=A0 int i, j, ret;
>>> -
>>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < fp->len; i++) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * During the extra pa=
ss, only the branch target addresses for
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the subprog calls n=
eed to be fixed. All other instructions
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can left untouched.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * The JITed image len=
gth does not change because we already
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * ensure that the JIT=
ed instruction sequence for these calls
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * are of fixed length=
 by padding them with NOPs.
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (insn[i].code =3D=3D (BP=
F_JMP | BPF_CALL) &&
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ins=
n[i].src_reg =3D=3D BPF_PSEUDO_CALL) {
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
 =3D bpf_jit_get_func_addr(fp, &insn[i], true,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &func_addr,
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 &func_addr_fixed);
>>=20
>> I don't see you updating calls to bpf_jit_get_func_addr() in=20
>> bpf_jit_build_body() to set extra_pass to true. Afaics, that's required=20
>> to get the correct address to be branched to for subprogs.
>>=20
>=20
> I don't understand what you mean.

I am referring to the third parameter we pass to=20
bpf_jit_get_func_addr().

In bpf_jit_build_body(), we do:

		case BPF_JMP | BPF_CALL:
			ctx->seen |=3D SEEN_FUNC;

			ret =3D bpf_jit_get_func_addr(fp, &insn[i], false,
						    &func_addr, &func_addr_fixed);


The third parameter (extra_pass) to bpf_jit_get_func_addr() is set to=20
false. In bpf_jit_get_func_addr(), we have:

	*func_addr_fixed =3D insn->src_reg !=3D BPF_PSEUDO_CALL;
	if (!*func_addr_fixed) {
		/* Place-holder address till the last pass has collected
		 * all addresses for JITed subprograms in which case we
		 * can pick them up from prog->aux.
		 */
		if (!extra_pass)
			addr =3D NULL;

Before this patch series, in bpf_jit_fixup_addresses(), we were calling=20
bpf_jit_get_func_addr() with the third parameter set to true.


- Naveen

