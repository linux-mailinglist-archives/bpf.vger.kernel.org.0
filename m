Return-Path: <bpf+bounces-58262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2B2AB792B
	for <lists+bpf@lfdr.de>; Thu, 15 May 2025 00:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622A13AFBC1
	for <lists+bpf@lfdr.de>; Wed, 14 May 2025 22:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACA61F9F73;
	Wed, 14 May 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OV5AWqoX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58834DDC1
	for <bpf@vger.kernel.org>; Wed, 14 May 2025 22:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747262805; cv=none; b=Y+peYaim8MUtgknOEdmAJe8POGiHHKbws4wdi9hBR2km5lxUXvzHiM6NiWHey7Da7s7c0s+ihqQu9iC3P/YSbP116Va5d0NY7WNcNf2f83U71sMEiZcyUkdWUr4tCxVuNMUmd9WHrnTtHiOHt59VLDEcscclPQ784NZseeOY1go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747262805; c=relaxed/simple;
	bh=76qce7WRABtUdPdV7Ezj0Fs+iV7yU2Eh0FH5IvUa+u8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cZE65bNitcCAxuUgEY+fkFKFWs+ypTrpPuHUXAepuOJosC6EUC3c7T/P4/AKyixtj81qVxw8IMWzNgYeh+17HoRfaYBT4Zai/wGFFbaBvsMXsNuEsCB4zgVdiGIcFc/L3btnZ07EKwnS+6BsfvM+e2WVIe2Vm3fBQoD2VlFuavU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OV5AWqoX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EHFIP7012707;
	Wed, 14 May 2025 22:46:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=We5f1D
	URRQ8+HWOBM3jGcBFUjH8wFkcgrCvcT35atZo=; b=OV5AWqoXirb4echoIrMIdk
	7tmcyNxyViodGnmb9iUfAb1or4SWzZVCO7iEbvwiO6oCGGWheB5j1Ad6Xcmq7yb3
	RVSCzXYhwRae2D9sGg+4fP/QLAXdRmzOtW5zx2H79qfI88183RaBwBO4UrIcAKRx
	zi48hWyeC5knDrA1EXuSzjiytH6vLGZ/vjjeRydDZMEu6ZLNr2tNPsICiQcKKakW
	dklS2lqsuU6OxP/ttdjYV/tAdHyUXHtvMYCAp5UOp4xyz1p8bDMQLnYrZu+uEbOP
	iKXrfFk1GK/JyQcCki8Y4GZGkdkhqBzrPau6tJJYPBmFuAQ4UGID9QGrJyJRusYQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mrcjbybj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 22:46:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJqP18027008;
	Wed, 14 May 2025 22:46:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfpeww0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 22:46:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54EMkNh558917296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 22:46:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281542004F;
	Wed, 14 May 2025 22:46:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AB0C2004B;
	Wed, 14 May 2025 22:46:22 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 22:46:22 +0000 (GMT)
Message-ID: <07d1180a55dc2a589bc0df0895447ba52284cabc.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Pass the same orig_call value to
 trampoline functions
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
 <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Date: Thu, 15 May 2025 00:46:22 +0200
In-Reply-To: <ab1d5047-7926-43ae-9dd7-0824b75af8b7@linux.dev>
References: <20250512221911.61314-1-iii@linux.ibm.com>
	 <20250512221911.61314-2-iii@linux.ibm.com>
	 <ab1d5047-7926-43ae-9dd7-0824b75af8b7@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYgdNtVA c=1 sm=1 tr=0 ts=68251d43 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=D5SdwCiipJaV5mQGH7YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WgMMi0P_g_nE1R-xK43utxyeRi1iibxM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDIwOSBTYWx0ZWRfX9hHh4fh1mZqE OSyDOlv1r4pSn9/zDyCfIFCe7lzjjZNJx/nuSs9ekQn4KRHzdGVJdp6ua6bj7/rYarhWUJpQPkq 7SvqC8iFn+kE6PLF3RV8QeGyfHVO3QQVdeUFtAJAUcA7KgHPBKuDvtrXT1aNp3bu77i/0+7VPTo
 zRDR8snjRHBTmRuCyuZkpt18QbWcXWjR4+DY8NLAUa7WNeEa96+aalU5Su8UPoB3R8ZxeTBXM31 fbofvWYDScupQBecVDrtHl9q+XQ8lTEUMCELnVlz2d05x0QMwzLPljyRT0GQCDF20pnfpYKEpPY 3qqINfHPzPquvYVPJI570t9Uo5iLWnPTYHyogKY8k/DGC8h6cuH+jsCFPlWeC+F6tveafTQra/K
 ZDoCNuAsdAAhuLOHrTxjWdRMTRNlBPBkreT4ITYHR0VeS0HuRKOsJSrgMf5xHaxlzDMMZ2O7
X-Proofpoint-GUID: WgMMi0P_g_nE1R-xK43utxyeRi1iibxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140209

On Wed, 2025-05-14 at 14:26 -0700, Martin KaFai Lau wrote:
> On 5/12/25 1:57 PM, Ilya Leoshkevich wrote:
> > There is currently some confusion in the s390x JIT regarding
> > whether
> > orig_call can be NULL and what that means. Originally the NULL
> > value
> > was used to distinguish the struct_ops case, but this was
> > superseded by
> > BPF_TRAMP_F_INDIRECT (see commit 0c970ed2f87c ("s390/bpf: Fix
> > indirect
> > trampoline generation").
> >=20
> > The remaining reason to have this check is that NULL can actually
> > be
> > passed to the arch_bpf_trampoline_size() call - but not to the
> > respective arch_prepare_bpf_trampoline()! call - by
> > bpf_struct_ops_prepare_trampoline().
> >=20
> > Remove this asymmetry by passing stub_func to both functions, so
> > that
> > JITs may rely on orig_call never being NULL.
> >=20
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> > =C2=A0 kernel/bpf/bpf_struct_ops.c | 2 +-
> > =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/bpf_struct_ops.c
> > b/kernel/bpf/bpf_struct_ops.c
> > index db13ee70d94d..96113633e391 100644
> > --- a/kernel/bpf/bpf_struct_ops.c
> > +++ b/kernel/bpf/bpf_struct_ops.c
> > @@ -601,7 +601,7 @@ int bpf_struct_ops_prepare_trampoline(struct
> > bpf_tramp_links *tlinks,
> > =C2=A0=C2=A0	if (model->ret_size > 0)
> > =C2=A0=C2=A0		flags |=3D BPF_TRAMP_F_RET_FENTRY_RET;
> > =C2=A0=20
> > -	size =3D arch_bpf_trampoline_size(model, flags, tlinks,
> > NULL);
> > +	size =3D arch_bpf_trampoline_size(model, flags, tlinks,
> > stub_func);
>=20
> The change looks ok but not sure why it is needed.
>=20
> I can see why stub_func is needed to generate the final image in=20
> arch_prepare_bpf_trampoline() in x86. The
> "arch_bpf_trampoline_size()" here is=20
> generating a temporary image, so NULL or not doesn't seem to matter.
>=20
> Does the s390 jit need to use the actual stub_func address somewhere
> in the=20
> temporary and/or final image?

Not right now, however, in the future I would like to check whether
orig_call points to a BPF prog. I have explained the rationale behind
this in the series description.

Purely practical issues aside, currently it's unclear what
orig_func =3D=3D NULL means. It had meaning in the past, but not anymore.
I think it would be good to remove this uncertainty and state that
today orig_func is never NULL.

Furthermore, a hypothetical JIT may produce different instruction
sequences for loading certain constants. Suppose we wanted to load
the value of orig_call into a register. Then in the NULL case a JIT
could generate:

  xgr %r1,%r1

and in the non-NULL case:

  llihf %r1,<high>
  oilf %r1,<low>

As you mentioned, arch_bpf_trampoline_size() generates a temporary
image, and in this case it would have a different size. So this
asymmetry can be a potential footgun.

