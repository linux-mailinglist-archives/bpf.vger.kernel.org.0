Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2BB64B684
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 14:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234969AbiLMNpg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 08:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234932AbiLMNpf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 08:45:35 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53162B23;
        Tue, 13 Dec 2022 05:45:34 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDD2QXT010257;
        Tue, 13 Dec 2022 13:45:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : subject :
 to : cc : references : in-reply-to : mime-version : message-id :
 content-type : content-transfer-encoding; s=pp1;
 bh=eUgPrthoCID6QwmABsTsBu6qOsnjoUKBNQdpMF81+W4=;
 b=DOTv2MvLjSpqYEV438WPXJiOF4v3r4AoVwb1uUsd5r0e6lA18xhhWnG9bMNEkfmV9wIZ
 fFGHaVU/S2fft1VGalvyFSyHfdNhqoEyO5sMBULsooW3/OpAF7AD7I8fohteDEjEvVrT
 h/Rqo3pd9Ark/i08dPipDXsTYEQkPMZhl1XdO8n1EyJYcVKoF4U55qxEA5IuSaDlBB3V
 DjW08B6oItIGOhHccxEexQCQd48n6XEceJU0wGHkyYgs73kQoXE8pnE4EVyE4av8h856
 E568UdMl2kBazEjen3i7ycjnJPamSiSjtyc5mU8enec4Tm6xfVs6bz9D07KgPqkoD7uz 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mejre449n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:45:06 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BDD6KLS019710;
        Tue, 13 Dec 2022 13:45:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mejre448u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:45:05 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD5UCPh028384;
        Tue, 13 Dec 2022 13:45:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mchr648eq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:45:03 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BDDj1Bv46793140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 13:45:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB79D2004B;
        Tue, 13 Dec 2022 13:45:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4711C20043;
        Tue, 13 Dec 2022 13:45:01 +0000 (GMT)
Received: from localhost (unknown [9.43.37.38])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 13 Dec 2022 13:45:01 +0000 (GMT)
Date:   Tue, 13 Dec 2022 15:53:48 +0530
From:   "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: [PATCH v1 06/10] powerpc/bpf: Perform complete extra passes to
 update addresses
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Hao Luo <haoluo@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>
References: <fa025537f584599c0271fc129c5cf4f57fbe7505.1669881248.git.christophe.leroy@csgroup.eu>
        <c13ebeb4d5d169bda6d1d60ccaa6cc956308308d.1669881248.git.christophe.leroy@csgroup.eu>
In-Reply-To: <c13ebeb4d5d169bda6d1d60ccaa6cc956308308d.1669881248.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
User-Agent: astroid/4d6b06ad (https://github.com/astroidmail/astroid)
Message-Id: <1670926819.9nqhz2fj7v.naveen@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7UTJ-JytMBoZWiQz5BZHWlwz3MrF3EJl
X-Proofpoint-ORIG-GUID: 3yIsWCYYIwCAqrzqIKaNf220JG_gsuBE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1011 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212130120
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christophe Leroy wrote:
> BPF core calls the jit compiler again for an extra pass in order
> to properly set subprog addresses.
>=20
> Unlike other architectures, powerpc only updates the addresses
> during that extra pass. It means that holes must have been left
> in the code in order to enable the maximum possible instruction
> size.
>=20
> In order avoid waste of space, and waste of CPU time on powerpc
> processors on which the NOP instruction is not 0-cycle, perform
> two real additional passes.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/net/bpf_jit_comp.c | 85 ---------------------------------
>  1 file changed, 85 deletions(-)
>=20
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_c=
omp.c
> index 43e634126514..8833bf23f5aa 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -23,74 +23,6 @@ static void bpf_jit_fill_ill_insns(void *area, unsigne=
d int size)
>  	memset32(area, BREAKPOINT_INSTRUCTION, size / 4);
>  }
> =20
> -/* Fix updated addresses (for subprog calls, ldimm64, et al) during extr=
a pass */
> -static int bpf_jit_fixup_addresses(struct bpf_prog *fp, u32 *image,
> -				   struct codegen_context *ctx, u32 *addrs)
> -{
> -	const struct bpf_insn *insn =3D fp->insnsi;
> -	bool func_addr_fixed;
> -	u64 func_addr;
> -	u32 tmp_idx;
> -	int i, j, ret;
> -
> -	for (i =3D 0; i < fp->len; i++) {
> -		/*
> -		 * During the extra pass, only the branch target addresses for
> -		 * the subprog calls need to be fixed. All other instructions
> -		 * can left untouched.
> -		 *
> -		 * The JITed image length does not change because we already
> -		 * ensure that the JITed instruction sequence for these calls
> -		 * are of fixed length by padding them with NOPs.
> -		 */
> -		if (insn[i].code =3D=3D (BPF_JMP | BPF_CALL) &&
> -		    insn[i].src_reg =3D=3D BPF_PSEUDO_CALL) {
> -			ret =3D bpf_jit_get_func_addr(fp, &insn[i], true,
> -						    &func_addr,
> -						    &func_addr_fixed);

I don't see you updating calls to bpf_jit_get_func_addr() in=20
bpf_jit_build_body() to set extra_pass to true. Afaics, that's required=20
to get the correct address to be branched to for subprogs.


- Naveen

