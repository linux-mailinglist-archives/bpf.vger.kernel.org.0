Return-Path: <bpf+bounces-9148-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91315790B32
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 10:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AC71C20757
	for <lists+bpf@lfdr.de>; Sun,  3 Sep 2023 08:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A432B17F7;
	Sun,  3 Sep 2023 08:17:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BEF17E3
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 08:17:17 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A356136
	for <bpf@vger.kernel.org>; Sun,  3 Sep 2023 01:17:15 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3838D97k016979;
	Sun, 3 Sep 2023 08:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=5RYNiS6dZCyllbCbc3GRMuRHbC2TWPy+COaJvZW4lKo=;
 b=cStEbFkCOY93ot/bDXT0fTyOheLyDzr1U/+QWQGA82dRZTJiKjXKnwAsYHMWX/xSkPdH
 2xzxJwYoxNmEMux965vtHNl7C3PlldXr1x0E4ekLbtCTc8Zpl9u+OPvaHNyjWLU7Oi6A
 up60iCE4rQkDM+h2ja+rZG/QQ+L2VMBa8poIk8LZwrE8rjoAooRPxISFP9uVSfUeTN18
 CJuplrHdEGxN2vMYpo+D+UUfcuveCD5BAQrmJoGFeMWLB9TuKSwXPTFsbSj70rt4F06B
 sqZyHZQxPGhNVXWweXn5kKJKBX/Ow8q1OcTlyYF6h2kHcbbSNhsBwpYX5ED9nd/dIVB9 3A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svpee818g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Sep 2023 08:16:55 +0000
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3838En7r019262;
	Sun, 3 Sep 2023 08:16:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3svpee818e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Sep 2023 08:16:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3837SD0J026826;
	Sun, 3 Sep 2023 08:16:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3svgcmsyry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 03 Sep 2023 08:16:54 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3838Gpwk36635374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 3 Sep 2023 08:16:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 183A320049;
	Sun,  3 Sep 2023 08:16:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D98720040;
	Sun,  3 Sep 2023 08:16:50 +0000 (GMT)
Received: from [9.171.29.233] (unknown [9.171.29.233])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  3 Sep 2023 08:16:50 +0000 (GMT)
Message-ID: <969c49716416d9ba9e03f1fd7e8234d9d0740fd5.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 01/11] bpf: Disable zero-extension for BPF_MEMSX
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Sun, 03 Sep 2023 10:16:50 +0200
In-Reply-To: <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
References: <20230830011128.1415752-1-iii@linux.ibm.com>
	 <20230830011128.1415752-2-iii@linux.ibm.com>
	 <CANk7y0iNnOCZ_KmXBH_xJTG=BKzkDM_jZ+hc_NXcQbbZj-c33Q@mail.gmail.com>
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
X-Proofpoint-GUID: e0jJ1_NAT8AbP1Tg9UnUk2SGPE10UUSQ
X-Proofpoint-ORIG-GUID: 6XRvG-HXIRCnProBE40SKYZZilzNss-u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-03_05,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=582 priorityscore=1501 malwarescore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309030074
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-09-01 at 16:19 +0200, Puranjay Mohan wrote:
> Hi Ilya
>=20
> On Wed, Aug 30, 2023 at 3:12=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.c=
om>
> wrote:
> >=20
> > On the architectures that use bpf_jit_needs_zext(), e.g., s390x,
> > the
> > verifier incorrectly inserts a zero-extension after BPF_MEMSX,
> > leading
> > to miscompilations like the one below:
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
89 1a ff fe 00 00 00 00 "r1 =3D *(s16 *)(r10 -
> > 2);"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # zext_dst set
> > =C2=A0=C2=A0 0x3ff7fdb910e:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lgh=C2=
=A0=C2=A0=C2=A0=C2=A0 %r2,-
> > 2(%r13,%r0)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 # load halfword
> > =C2=A0=C2=A0 0x3ff7fdb9114:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 llgfr=
=C2=A0=C2=A0
> > %r2,%r2=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # wrong!
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 25:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
65 10 00 03 00 00 7f ff if r1 s> 32767 goto +3
> > <l0_1>=C2=A0=C2=A0 # check_cond_jmp_op()
> >=20
> > Disable such zero-extensions. The JITs need to insert sign-
> > extension
> > themselves, if necessary.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0kernel/bpf/verifier.c | 4 +++-
> > =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index bb78212fa5b2..097985a46edc 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -3110,7 +3110,9 @@ static void mark_insn_zext(struct
> > bpf_verifier_env *env,
> > =C2=A0{
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s32 def_idx =3D reg->subreg_=
def;
> >=20
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (def_idx =3D=3D DEF_NOT_SUBREG=
)
>=20
> The problem here is that reg->subreg_def should be set as
> DEF_NOT_SUBREG for
> registers that are used as destination registers of BPF_LDX |
> BPF_MEMSX. I am seeing
> the same problem on ARM32 and was going to send a patch today.
>=20
> The problem is that is_reg64() returns false for destination
> registers
> of BPF_LDX | BPF_MEMSX.
> But BPF_LDX | BPF_MEMSX always loads a 64 bit value because of the
> sign extension so
> is_reg64() should return true.
>=20
> I have written a patch that I will be sending as a reply to this.
> Please let me know if that makes sense.
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (def_idx =3D=3D DEF_NOT_SUBREG=
 ||
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (BPF_CLAS=
S(env->prog->insnsi[def_idx - 1].code) =3D=3D
> > BPF_LDX &&
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BPF=
_MODE(env->prog->insnsi[def_idx - 1].code) =3D=3D
> > BPF_MEMSX))
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->insn_aux_data[def_idx -=
 1].zext_dst =3D true;
> > --
> > 2.41.0
> >=20
> >=20
>=20
> Thanks,
> Puranjay

Hi,

I also considered doing this, and I think both approaches are
functionally equivalent and work in practice.

However, I can envision that, just like we have the zext_dst=C2=A0
optimization today, we might want a sext_dst optimization in the
future. Therefore I think it's better to fix this by not setting
zext_dst instead of not setting subreg_def.

Best regards,
Ilya

