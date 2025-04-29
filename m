Return-Path: <bpf+bounces-56968-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA394AA1399
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 19:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187EC1600C9
	for <lists+bpf@lfdr.de>; Tue, 29 Apr 2025 17:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC29D2517A4;
	Tue, 29 Apr 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IWziuHuh"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B525D22A81D;
	Tue, 29 Apr 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946213; cv=none; b=K0J4jDO2zGDzrlKaBmHbRLTE/0vbzVv3Vi7c+gHNn/CaDY0ZBoz+cRLJFco5bsEO+jx30m0+2KW9QHJUCRuChWi0wjLEnMaRs+bk/ncfd5CcwF9zPnbxh0sD4npZGQ4hqGrtYvgmCXpLcupJg2wV2mjmdvEJ5VtRF6CsmWjyS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946213; c=relaxed/simple;
	bh=2UIGaiSS4EiTjYknzSmDmdcW/VL6maRJ5xAjJu5iDZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoOjDO3Squ9MM7lpj+imdgFBeKac0Ps9N22NnbURNrzy+szyvSeF5mQITnYo0P6Rn7EcrGXLhhaKHnkcpq0dEI+1qhBAseEfcdjX59u/FvQYpKzGy1YAxqNSlYbRtwGMkAvgTzupoV3ujKZ5YJP1BGzf5nkC9nLIqPnN5iko2LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IWziuHuh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53TFGGrH026768;
	Tue, 29 Apr 2025 17:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=x4Aiot
	cCiqsHzDgP9wNrx/KUPfVbyHFIbn2WF+lZY4c=; b=IWziuHuhUoDu4OnaKB8aSg
	9vAkUH9CKpZvETmpIGEhPsf616ATsqzP1c1FBDCfciEAkFRiIUty4DyAFU3WYtW9
	7yo7wV4YT51l3FFEY/Zmh+9b/VE+I/kJGIRNYgiiao0Omvbbnf8P2VvdLEAF7rjF
	w3/Fe4cC0BPZ6mhcnntzZpxpWevmzSQfskkUrZnfDymmnHpdZcPS2c2tohzf5eaF
	Mobw2qiHC5na/gLpLQU3c1sLRJ+M3v2NvnQz/YgMgOc8xvkMVODvJunY26a3XIkj
	tpu3KXYkPKgULNL2A5vIDxzdCcwr9d4T3UT5KMPpCWwFjrjDzgbeM0nt4zoKQxcw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwm8hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:02:52 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53TH2ptH027244;
	Tue, 29 Apr 2025 17:02:51 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ahtwm8hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:02:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53TGqWW0031680;
	Tue, 29 Apr 2025 17:02:50 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4699tu4b8f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Apr 2025 17:02:50 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53TH2kuL17039726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Apr 2025 17:02:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBA1120043;
	Tue, 29 Apr 2025 17:02:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6155C20040;
	Tue, 29 Apr 2025 17:02:41 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.43.48.161])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 29 Apr 2025 17:02:41 +0000 (GMT)
Date: Tue, 29 Apr 2025 22:32:34 +0530
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, hbathini@linux.ibm.com,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
        haoluo@google.com, jolsa@kernel.org, naveen@kernel.org,
        maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com
Subject: Re: [PATCH 2/2] powerpc, bpf: Inline bpf_get_smp_processor_id()
Message-ID: <aBEGKrZVFHjIgNcl@linux.ibm.com>
References: <20250311160955.825647-1-skb99@linux.ibm.com>
 <20250311160955.825647-3-skb99@linux.ibm.com>
 <61e746ca-456f-4824-9678-85399b450bce@csgroup.eu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61e746ca-456f-4824-9678-85399b450bce@csgroup.eu>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI5MDEyMyBTYWx0ZWRfX8ZH6swjfaJck cWeNEKj8/snGXktdL73/dcusgEp0UWtEPyMJ36sKvBLgV8khVbtuhNqhG7I82ppjZXawfbSPul6 oOcL8OyZ5IMuEJHDsn0dHiCQJxAm3m1kwNb8HJ2l+YBT068+5GdLQZaeMOCwrcDkF+9Iu+Pik//
 ZiPHHitaZ+uHoUMAW/dYkq7/hqarLxj8sTCNyPagi5XRJcmnZ84s+xOqxDoUmyZmleFFZFQFGuZ GHFpOqwJeLduaUVif4lUhVbIh6aWuY3UGhfvlj1cIYOS7mQTOE6y8vx517a7tcMcu/5pL4Zg4fG UwNOQ1NFHbGMdselhjBqNdH6hd2TZS2Vqy5wiTZ4cLNk5jeOESeZlk7/k2tCDPnvuNxE6JKP0Gm
 ce+OUjStVFGx3mxgM0yhwLfQKtxsIO0FCPMgrjr8EjGKNemyqoHlGvypuovmI4OTcT8PvaHO
X-Proofpoint-GUID: gSHK4nhg36kY9AAUJR5nTIIPV1Qwdi0M
X-Authority-Analysis: v=2.4 cv=KtxN2XWN c=1 sm=1 tr=0 ts=6811063c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=8nJEP1OIZ-IA:10 a=XR8D0OoHHMoA:10 a=_EeEMxcBAAAA:8 a=UqCG9HQmAAAA:8 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=1UX6Do5GAAAA:8
 a=BnCqiL5p1_9I5edH014A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=Et2XPkok5AAZYJIKzHr1:22
X-Proofpoint-ORIG-GUID: wUWVvOcDmkRmWwyhWRBIlNj9UsrhsoaU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-29_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504290123

On Tue, Mar 11, 2025 at 06:51:28PM +0100, Christophe Leroy wrote:
> 
> 
> Le 11/03/2025 à 17:09, Saket Kumar Bhaskar a écrit :
> > [Vous ne recevez pas souvent de courriers de skb99@linux.ibm.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> > 
> > Inline the calls to bpf_get_smp_processor_id() in the powerpc bpf jit.
> > 
> > powerpc saves the Logical processor number (paca_index) in paca.
> > 
> > Here is how the powerpc JITed assembly changes after this commit:
> > 
> > Before:
> > 
> > cpu = bpf_get_smp_processor_id();
> > 
> > addis 12, 2, -517
> > addi 12, 12, -29456
> > mtctr 12
> > bctrl
> > mr      8, 3
> > 
> > After:
> > 
> > cpu = bpf_get_smp_processor_id();
> > 
> > lhz 8, 8(13)
> > 
> > To evaluate the performance improvements introduced by this change,
> > the benchmark described in [1] was employed.
> > 
> > +---------------+-------------------+-------------------+--------------+
> > |      Name     |      Before       |        After      |   % change   |
> > |---------------+-------------------+-------------------+--------------|
> > | glob-arr-inc  | 41.580 ± 0.034M/s | 54.137 ± 0.019M/s |   + 30.20%   |
> > | arr-inc       | 39.592 ± 0.055M/s | 54.000 ± 0.026M/s |   + 36.39%   |
> > | hash-inc      | 25.873 ± 0.012M/s | 26.334 ± 0.058M/s |   + 1.78%    |
> > +---------------+-------------------+-------------------+--------------+
> > 
> 
> Nice improvement.
> 
> I see that bpf_get_current_task() could be inlined as well, on PPC32 it is
> in r2, on PPC64 it is in paca.
> 
Working on it to inline bpf_get_current_task as well. Will send with v2.
> > [1] https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2Fanakryiko%2Flinux%2Fcommit%2F8dec900975ef&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C1d1f40ce41344cf1ecf508dd60b73ae0%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C638773062267813839%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=T%2BG206FHtW7hhFT1%2BXxRwN7pc%2BRzu8SiMlZ5njIlhB8%3D&reserved=0
> > 
> > Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> > ---
> >   arch/powerpc/net/bpf_jit_comp.c   | 10 ++++++++++
> >   arch/powerpc/net/bpf_jit_comp64.c |  5 +++++
> >   2 files changed, 15 insertions(+)
> > 
> > diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> > index 3d4bd45a9a22..4b79b2d95469 100644
> > --- a/arch/powerpc/net/bpf_jit_comp.c
> > +++ b/arch/powerpc/net/bpf_jit_comp.c
> > @@ -445,6 +445,16 @@ bool bpf_jit_supports_percpu_insn(void)
> >          return true;
> >   }
> > 
> > +bool bpf_jit_inlines_helper_call(s32 imm)
> > +{
> > +       switch (imm) {
> > +       case BPF_FUNC_get_smp_processor_id:
> > +               return true;
> > +       default:
> > +               return false;
> > +       }
> > +}
> 
> What about PPC32 ?
> 
Will send v2 for PPC64 as of now.
> 
> > +
> >   void *arch_alloc_bpf_trampoline(unsigned int size)
> >   {
> >          return bpf_prog_pack_alloc(size, bpf_jit_fill_ill_insns);
> > diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> > index 06f06770ceea..a8de12c026da 100644
> > --- a/arch/powerpc/net/bpf_jit_comp64.c
> > +++ b/arch/powerpc/net/bpf_jit_comp64.c
> > @@ -1087,6 +1087,11 @@ int bpf_jit_build_body(struct bpf_prog *fp, u32 *image, u32 *fimage, struct code
> >                  case BPF_JMP | BPF_CALL:
> >                          ctx->seen |= SEEN_FUNC;
> > 
> > +                       if (insn[i].src_reg == 0 && imm == BPF_FUNC_get_smp_processor_id) {
> 
> Please use BPF_REG_0 instead of just 0.
> 
Acknowledged
> > +                               EMIT(PPC_RAW_LHZ(bpf_to_ppc(BPF_REG_0), _R13, offsetof(struct paca_struct, paca_index)));
> 
> Can just use 'src_reg' instead of 'bpf_to_ppc(BPF_REG_0)'
> 
Will include this in v2.
> > +                               break;
> > +                       }
> > +
> >                          ret = bpf_jit_get_func_addr(fp, &insn[i], extra_pass,
> >                                                      &func_addr, &func_addr_fixed);
> >                          if (ret < 0)
> > --
> > 2.43.5
> > 
> 
Thanks for reviewing Chris.

