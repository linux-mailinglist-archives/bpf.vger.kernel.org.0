Return-Path: <bpf+bounces-56967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B2AA1355
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FD9518970A6
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC3248893;
	Tue, 29 Apr 2025 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MUTSWKki"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BF7E110;
	Tue, 29 Apr 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946025; cv=none; b=r4VNc7MOPOnlnqlKzzqCnJNYrzlVPyEUEEf4xTwCarmpY5L0lWkeiMfaNgC4KS2uTt1JCN06YyVi//MzEOyvz1bQrovb6fqGKvlkpaoq3mbLH677cJtzm3Rf9AQJCUSazmxq7nK3O64G+8zNf2H3fys9vKSyyrBUbgdUs5ubWvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946025; c=relaxed/simple;
	bh=2lqSX6Ajf/I9uQJY/+sUlVszYxE+8Lkizv8Z6+u7YKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VeHFYXP5rzZ+fiPmaWd96dqN0kB67HSNShQjB45MOx/NWQaO/PadqSIxypYELtJIL7VtHnAMOahDXdH/zmbDy4E0/acy8uONUrV/+BXNZ+rKlM68jtVgc1mwyL6LvLUNWTYkSSbc4cv16RwW2E08sQn7OYNzF+m+Q0zIy9X9fWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MUTSWKki; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TE44W1007252;
	Tue, 29 Apr 2025 16:59:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iabThc
	/RTrklIheipJi/J7fdXCPmTsddw22gg8+Lo4w=; b=MUTSWKkiz05Qs5o4vgG++Q
	UvikwGV1ZiqCfM+Py9jM3KlVOgNxoxi7/Rb3+8C3rJKq0hDGlZXvdrekGWN9NClg
	l+MFrYguHqrV6++8aPbQjZGY+/vgOHBXYBFyPrtvY1oGfwcf/vvbNR02jwoNw9gx
	dUcmMJJaHdj8j6aiDTCk4kTH+265aKTrOdrZdAFnsptu/A+i57v5N/PCoDYU8Ssc
	AJC13yP9jfMA17ZQQFQz6N20zysgCrD/bn1HktvdRvDA9Uv3rX4w3aLzOVNpSooy
	BgTzjNdZIenyZyJtd6z52sQ0sqkWrnGx0vExiMmOdICDxTB5rIq2ynLM59tEhLbQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46akn0uw7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:59:54 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53TGxrvb011665;
	Tue, 29 Apr 2025 16:59:53 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46akn0uw7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:59:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TDXUqY000717;
	Tue, 29 Apr 2025 16:59:52 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 469atpc695-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 16:59:52 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TGxnVJ49414620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 16:59:49 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F094720043;
	Tue, 29 Apr 2025 16:59:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3B7820040;
	Tue, 29 Apr 2025 16:59:43 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.48.161])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Apr 2025 16:59:43 +0000 (GMT)
Date: Tue, 29 Apr 2025 22:29:31 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Subject: Re: [PATCH 1/2] powerpc, bpf: Support internal-only MOV instruction
 to resolve per-CPU addrs
Message-ID: <aBEFc8YnuGozsdvD@linux.ibm.com>
References: <20250311160955.825647-1-skb99@linux.ibm.com>
 <20250311160955.825647-2-skb99@linux.ibm.com>
 <ab2a370d-3e71-41f1-9afc-6e2c47db87d9@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab2a370d-3e71-41f1-9afc-6e2c47db87d9@csgroup.eu>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AeCxH2XG c=1 sm=1 tr=0 ts=6811058a cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=_EeEMxcBAAAA:8 a=UqCG9HQmAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8
 a=jmxt0n9hSfPpTpQn_gkA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: 3UoRz_JwbcG3_m6sO-a6_GSVdILx7oVW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMyBTYWx0ZWRfXzywwOgZPiYJ7 L3TfGFs4LRAC9/Vgs9sIjk1hSA1MONELY+bjCbIh3FhfQ3XGKA3bq4Nx5dkCHz7AeXPaZ31Z9Um sAqpbZqCC+9Lgh/AgoUIEsfRVNb1IO7S6K+TiIVzbFu/1LPpVML6Q2A2IAqL5HzL0DN16XLgY42
 x8NX0mlBRcfEtl0LSScuSczzQGOq6+TavFlv+17bAaqQwg0iKFGJSgHEyyCA1Sf4fRYLbS1g0FN rt5TUgOW0DF3++LZL0MCYhiRi1y7UOhm9OWo+68HJRSeRCfq1rmrl2/JgWPEBj4Xv9tQgGluC7C J9g3KTG27GGbOIYhdwWLpxEuLOqgIRFUeY1u2pwyZquLMlLrzpVBk2sQnzH/IS8QIEmBD+h1/Qe
 e6XxrruTN3NsnrcSljAs6SVKKKGjoSED6eIa+UkLSpgaSYAUquZ0LnOsJhvescsUA/ddGFHd
X-Proofpoint-GUID: Ghe-LPIqerF4t-tFTRmZiRN92D1MQZMw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 mlxscore=0 phishscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290123

On Tue, Mar 11, 2025 at 06:38:23PM +0100, Christophe Leroy wrote:
> 
> 
> Le 11/03/2025 � 17:09, Saket Kumar Bhaskar a �crit�:
> > [Vous ne recevez pas souvent de courriers de skb99@linux.ibm.com. D�couvrez pourquoi ceci est important � https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > With the introduction of commit 7bdbf7446305 ("bpf: add special
> > internal-only MOV instruction to resolve per-CPU addrs"),
> > a new BPF instruction BPF_MOV64_PERCPU_REG has been added to
> > resolve absolute addresses of per-CPU data from their per-CPU
> > offsets. This update requires enabling support for this
> > instruction in the powerpc JIT compiler.
> > 
> > As of commit 7a0268fa1a36 ("[PATCH] powerpc/64: per cpu data
> > optimisations"), the per-CPU data offset for the CPU is stored in
> > the paca.
> > 
> > To support this BPF instruction in the powerpc JIT, the following
> > powerpc instructions are emitted:
> > 
> > mr dst_reg, src_reg             //Move src_reg to dst_reg, if src_reg != dst_reg
> > ld tmp1_reg, 48(13)             //Load per-CPU data offset from paca(r13) in tmp1_reg.
> > add dst_reg, dst_reg, tmp1_reg  //Add the per cpu offset to the dst.
> 
> Why not do:
> 
>   add dst_reg, src_reg, tmp1_reg
> 
> instead of a combination of 'mr' and 'add' ?
> 
Will do it in v2. 
> > 
> > To evaluate the performance improvements introduced by this change,
> > the benchmark described in [1] was employed.
> > 
> > Before Change:
> > glob-arr-inc   :   41.580 � 0.034M/s
> > arr-inc        :   39.592 � 0.055M/s
> > hash-inc       :   25.873 � 0.012M/s
> > 
> > After Change:
> > glob-arr-inc   :   42.024 � 0.049M/s
> > arr-inc        :   55.447 � 0.031M/s
> > hash-inc       :   26.565 � 0.014M/s
> > 
> > [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7Ca4bc35a9cb49457fb5cc08dd60b73783%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638773062200197453%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=1t2Bc3w6Ye0u33UNEjsSAv114HDOGNXmk1I%2Fxt7K2sc%3D&reserved=0
> > 
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >   arch/powerpc/net/bpf_jit_comp.c   | 5 +++++
> >   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++++++
> >   2 files changed, 13 insertions(+)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 2991bb171a9b..3d4bd45a9a22 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -440,6 +440,11 @@ bool bpf_jit_supports_far_kfunc_call(void)
> >          return IS_ENABLED(CONFIG_PPC64);
> >   }
> > 
> > +bool bpf_jit_supports_percpu_insn(void)
> > +{
> > +       return true;
> > +}
> > +
> 
> What about PPC32 ?
> 
Right now we will enable it for PPC64. So will modify the return statement accordingly.
> >   void *arch_alloc_bpf_trampoline(unsigned int size)
> >   {
> >          return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 233703b06d7c..06f06770ceea 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -679,6 +679,14 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >                   */
> >                  case BPF_ALU | BPF_MOV | BPF_X: /* (u32) dst = src */
> >                  case BPF_ALU64 | BPF_MOV | BPF_X: /* dst = src */
> > +                       if (insn_is_mov_percpu_addr(&insn[i])) {
> > +                               if (dst_reg != src_reg)
> > +                                       EMIT(PPC_RAW_MR(dst_reg, src_reg));
> 
> Shouldn't be needed except for the non-SMP case maybe.
> 
Acknowledged.
> > +#ifdef CONFIG_SMP
> > +                               EMIT(PPC_RAW_LD(tmp1_reg, _R13, offsetof(struct paca_struct, data_offset)));
> > +                               EMIT(PPC_RAW_ADD(dst_reg, dst_reg, tmp1_reg));
> 
> Can use src_reg as first operand instead of dst_reg
> 
Will include this in v2.
> > +#endif
> 
> data_offset always exists in paca_struct, please use IS_ENABLED(CONFIG_SMP)
> instead of #ifdef
> 
> > +                       }
> >                          if (imm == 1) {
> >                                  /* special mov32 for zext */
> >                                  EMIT(PPC_RAW_RLWINM(dst_reg, dst_reg, 0, 0, 31));
> > --
> > 2.43.5
> > 
> 
Thanks for reviewing Chris.

