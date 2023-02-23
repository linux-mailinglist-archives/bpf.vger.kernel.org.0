Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C416A03FE
	for <lists+bpf@lfdr.de>; Thu, 23 Feb 2023 09:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbjBWIkK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Feb 2023 03:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233456AbjBWIkJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Feb 2023 03:40:09 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8544AFE6
        for <bpf@vger.kernel.org>; Thu, 23 Feb 2023 00:40:08 -0800 (PST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31N6WBT2009853;
        Thu, 23 Feb 2023 08:39:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=QyXcbGD4Ur7hhsBakuhrsJdmACBzGvXvAonrrk0Xf6w=;
 b=B8XT5hKK5kBxvcgihOIlsnU3wY55MSeun9LF+ZLfq0CPtFTJeFYZFKlkCqt2OlcQZ2A7
 dfJi+UsBZhS4Mk9LR0vOil5fF8CUBlplGPaFPIwsN2wo/NtphWPVkZsKuo0VYpzycmhH
 RmoI5Rz3BWF5uO/+2z3T7clk6tSVF+FCvE4WUG68mRsFD6UjNG8CzWvZUjLl/sTUBjXO
 zsfOVhBzHDrgN28N5NdkVXtKgmG2Qp4GuTJQWlFE9QYt2aW8pAsUK4I0Am1n2tFOmap2
 5kQA3m0R5DrRTB6g3iLuSsfQQQQzc00cEpkRL7bh5+ujL8O04cNpBlDtH55zEY20sF1L jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2y72x7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:39:53 +0000
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31N8Kc5L003113;
        Thu, 23 Feb 2023 08:39:53 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nx2y72x6g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:39:53 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31N6UBnm031888;
        Thu, 23 Feb 2023 08:39:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3ntpa6cvg9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Feb 2023 08:39:51 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31N8dlYC56099122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Feb 2023 08:39:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B03A2004B;
        Thu, 23 Feb 2023 08:39:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1BA820043;
        Thu, 23 Feb 2023 08:39:46 +0000 (GMT)
Received: from [9.171.53.11] (unknown [9.171.53.11])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 23 Feb 2023 08:39:46 +0000 (GMT)
Message-ID: <196da641abe62edf472f36be7eff9916b818831c.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next v3 11/12] bpf: Support 64-bit pointers to kfuncs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Jiri Olsa <jolsa@kernel.org>
Date:   Thu, 23 Feb 2023 09:39:46 +0100
In-Reply-To: <CAKH8qBsB0jgeODqhOwiJB1vUZZfWD27VU0nN+Bo8b4aJLBgESg@mail.gmail.com>
References: <20230222223714.80671-1-iii@linux.ibm.com>
         <20230222223714.80671-12-iii@linux.ibm.com>
         <CAKH8qBsB0jgeODqhOwiJB1vUZZfWD27VU0nN+Bo8b4aJLBgESg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3syp8RVr_gH9WcKD5HMUNIuMOuoqlTCg
X-Proofpoint-GUID: yGmgQsTk_ygCOzWREPyHpBM02md3naV_
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-23_04,2023-02-22_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302230074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 2023-02-22 at 15:43 -0800, Stanislav Fomichev wrote:
> On Wed, Feb 22, 2023 at 2:37 PM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> >=20
> > test_ksyms_module fails to emit a kfunc call targeting a module on
> > s390x, because the verifier stores the difference between kfunc
> > address and __bpf_call_base in bpf_insn.imm, which is s32, and
> > modules
> > are roughly (1 << 42) bytes away from the kernel on s390x.
> >=20
> > Fix by keeping BTF id in bpf_insn.imm for BPF_PSEUDO_KFUNC_CALLs,
> > and storing the absolute address in bpf_kfunc_desc, which JITs
> > retrieve
> > as usual by calling bpf_jit_get_func_addr().
> >=20
> > Introduce bpf_get_kfunc_addr() instead of exposing both
> > find_kfunc_desc() and struct bpf_kfunc_desc.
> >=20
> > This also fixes the problem with XDP metadata functions outlined in
> > the description of commit 63d7b53ab59f ("s390/bpf: Implement
> > bpf_jit_supports_kfunc_call()") by replacing address lookups with
> > BTF
> > id lookups. This eliminates the inconsistency between "abstract"
> > XDP
> > metadata functions' BTF ids and their concrete addresses.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>=20
> Acked-by: Stanislav Fomichev <sdf@google.com>
>=20
> With a nit below (and an unrelated question).
>=20
> I'll wait a bit for the buildbots to finish until ack'ing the rest.
> But the jit (except sparc quirks) and selftest changes also make
> sense to me.
>=20
> > ---
> > =C2=A0include/linux/bpf.h=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0kernel/bpf/core.c=C2=A0=C2=A0=C2=A0=C2=A0 | 21 ++++++++++--
> > =C2=A0kernel/bpf/verifier.c | 79 +++++++++++++--------------------------
> > ----
> > =C2=A03 files changed, 44 insertions(+), 58 deletions(-)
> >=20
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 520b238abd5a..e521eae334ea 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -2234,6 +2234,8 @@ bool bpf_prog_has_kfunc_call(const struct
> > bpf_prog *prog);
> > =C2=A0const struct btf_func_model *
> > =C2=A0bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 const struct bpf_insn *insn);
> > +int bpf_get_kfunc_addr(const struct bpf_prog *prog, u32 func_id,
> > u16 offset,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 **func_addr);
> > =C2=A0struct bpf_core_ctx {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_verifier_log *log;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct btf *btf;
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 933869983e2a..4d51782f17ab 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -1185,10 +1185,12 @@ int bpf_jit_get_func_addr(const struct
> > bpf_prog *prog,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s16 off =3D insn->off;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 imm =3D insn->imm;
>=20
> [..]
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool fixed;
>=20
> nit: do we really need that extra fixed bool? Why not directly
> *func_addr_fixes =3D true/false in all the places?

I introduced it in order to avoid touching func_addr_fixed if there
is an error, but actually that's not necessary - it's assigned after
all checks. I will drop it in v4.

> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u8 *addr;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int err;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *func_addr_fixed =3D insn->src_re=
g !=3D BPF_PSEUDO_CALL;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!*func_addr_fixed) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 switch (insn->src_reg) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BPF_PSEUDO_CALL:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Place-holder address till the last pass has
> > collected
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * all addresses for JITed subprograms in which
> > case we
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can pick them up from prog->aux.
> > @@ -1200,15 +1202,28 @@ int bpf_jit_get_func_addr(const struct
> > bpf_prog *prog,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addr =
=3D (u8 *)prog->aux->func[off]-
> > >bpf_func;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retur=
n -EINVAL;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fixed =3D false;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Address of a BPF helper call. Since part of the
> > core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * kernel, it's always at a fixed location.
> > __bpf_call_base
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * and the helper with imm relative to it are bo=
th
> > in core
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 * kernel.
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 addr =3D (u8 *)__bpf_call_base + imm;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fixed =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case BPF_PSEUDO_KFUNC_CALL:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 err =3D bpf_get_kfunc_addr(prog, imm, off, &addr);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 if (err)
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 fixed =3D true;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 break;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -EINVAL;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *func_addr_fixed =3D fixed;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *func_addr =3D (unsigned lon=
g)addr;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> > =C2=A0}
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 574d2dfc6ada..6d4632476c9c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -2115,8 +2115,8 @@ static int add_subprog(struct
> > bpf_verifier_env *env, int off)
> > =C2=A0struct bpf_kfunc_desc {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct btf_func_model func_m=
odel;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 func_id;
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 imm;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u16 offset;
>=20
> [..]
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long addr;
>=20
> Do we have some canonical type to store the address? I was using void
> * in bpf_dev_bound_resolve_kfunc, but we are doing ulong here. We
> seem
> to be doing u64/void */unsigned long inconsistently.

IIUC u64 is for BPF progs [1]. I've seen unsigned long in a number of
places, e.g. kallsyms. My personal heuristic is that if we don't
dereference it on the C side, it can be unsigned long. But I don't have
a strong opinion on this.

> Also, maybe move it up a bit? To turn u32+u16+gap+u64 into
> u64+u32+u16+padding ?

You are right, we can do better here w.r.t. space efficiency:

struct bpf_kfunc_desc {
        struct btf_func_model      func_model;           /*     0    27
*/

        /* XXX 1 byte hole, try to pack */

        u32                        func_id;              /*    28     4
*/
        u16                        offset;               /*    32     2
*/

        /* XXX 6 bytes hole, try to pack */

        long unsigned int          addr;                 /*    40     8
*/


[1]
https://lore.kernel.org/bpf/CAEf4BzaQJfB0Qh2Wn5wd9H0ZSURbzWBfKkav8xbkhozqTW=
Xndw@mail.gmail.com/

Best regards,
Ilya
