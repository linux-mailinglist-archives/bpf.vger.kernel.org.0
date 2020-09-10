Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD6A26415D
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbgIJJSm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 05:18:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726600AbgIJJSk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 05:18:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08A92CvH115571;
        Thu, 10 Sep 2020 05:18:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=EeDDpNvonc90t2crCaE6RawxxNE8KQaqxx3oisAXETc=;
 b=ineqouRWtBc/0tVxBe4cD8kqdV2ks7QldAbIVoOFslT39ZKQuA0s4qa9Tl+gODPWz1Ec
 O3bd1Ns70xJQi+kbPDtNSvCefy6UucyiIJYpv6QRRyK6WoIIqHFPXUJmLSbGEFj1QHWf
 hXZYUgT20pGWDVd345exwzYGnkdxRYnpfBDOz7el+4TgZ3x7afMsZ164IGffAy8abWkR
 1SymoFra4qbjE5M5jQRQ96JoSnY+Mrxylcw/YJdRBDUhO8cs2EGgXeqCNxL7zMPR4peT
 OBxBmmXgDiIwFnT/tWRT6QqVWa0j2a8DiyVyvoovqDxEfmUPHQPoa98WDEHNPKZzRIyd kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fgkf9t9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 05:18:27 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 08A93A5o120280;
        Thu, 10 Sep 2020 05:18:27 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 33fgkf9t8d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 05:18:27 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 08A9D3Ia021573;
        Thu, 10 Sep 2020 09:18:25 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 33dxdr31xv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Sep 2020 09:18:24 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 08A9IMuM35324340
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Sep 2020 09:18:22 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2708411C04C;
        Thu, 10 Sep 2020 09:18:22 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C108211C050;
        Thu, 10 Sep 2020 09:18:21 +0000 (GMT)
Received: from sig-9-145-5-224.uk.ibm.com (unknown [9.145.5.224])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Sep 2020 09:18:21 +0000 (GMT)
Message-ID: <f1bbf540493c9ebd153281c587c94d0be2f78343.camel@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn
 in zext patchlet
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Date:   Thu, 10 Sep 2020 11:18:21 +0200
In-Reply-To: <xuny363qazhe.fsf@redhat.com>
References: <20200909233439.3100292-1-iii@linux.ibm.com>
         <20200909233439.3100292-6-iii@linux.ibm.com> <xuny363qazhe.fsf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_01:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100080
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 2020-09-10 at 09:59 +0300, Yauheni Kaliuta wrote:
> Hi, Ilya!
> 
> Cool, thanks!
> 
> Shouldn't the rnd patch be done the same way for completeness?
> Even if it is unlikely there to hit the problem.

Ah, I haven't noticed that this pattern used elsewhere as well -
I just checked and found 4 places. Let's wait and see whether the whole
approach is acceptable, if yes, then I'll make patches that clean up
these occurrences.

> 
> > > > > > On Thu, 10 Sep 2020 01:34:39 +0200, Ilya
> > > > > > Leoshkevich  wrote:
> 
>  > If the original insn is a jump, then it is not subjected to branch
>  > adjustment, which is incorrect. As discovered by Yauheni in
> 
>  > 
> https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/
> 
>  > this causes `test_progs -t global_funcs` failures on s390.
> 
>  > Most likely, the current code includes the original insn in the
>  > patchlet, because there was no infrastructure to insert new insns,
> only
>  > to replace the existing ones. Now that bpf_patch_insns_data() can
> do
>  > insertions, stop including the original insns in zext patchlets.
> 
>  > Fixes: a4b1d3c1ddf6 ("bpf: verifier: insert zero extension
> according
>  > to analysis result")
>  > Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
>  > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
>  > ---
>  >  kernel/bpf/verifier.c | 20 +++++++++++---------
>  >  1 file changed, 11 insertions(+), 9 deletions(-)
> 
>  > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>  > index 17c2e926e436..64a04953c631 100644
>  > --- a/kernel/bpf/verifier.c
>  > +++ b/kernel/bpf/verifier.c
>  > @@ -9911,7 +9911,7 @@ static int opt_remove_nops(struct
> bpf_verifier_env *env)
>  >  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env
> *env,
>  >  					 const union bpf_attr *attr)
>  >  {
>  > -	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
>  > +	struct bpf_insn *patch, zext_patch, rnd_hi32_patch[4];
>  >  	struct bpf_insn_aux_data *aux = env->insn_aux_data;
>  >  	int i, patch_len, delta = 0, len = env->prog->len;
>  >  	struct bpf_insn *insns = env->prog->insnsi;
>  > @@ -9919,13 +9919,14 @@ static int
> opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  >  	bool rnd_hi32;
>  
>  >  	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
>  > -	zext_patch[1] = BPF_ZEXT_REG(0);
>  > +	zext_patch = BPF_ZEXT_REG(0);
>  >  	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
>  >  	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
>  >  	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
>  >  	for (i = 0; i < len; i++) {
>  >  		int adj_idx = i + delta;
>  >  		struct bpf_insn insn;
>  > +		int len_old = 1;
>  
>  >  		insn = insns[adj_idx];
>  >  		if (!aux[adj_idx].zext_dst) {
>  > @@ -9968,20 +9969,21 @@ static int
> opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
>  >  		if (!bpf_jit_needs_zext())
>  >  			continue;
>  
>  > -		zext_patch[0] = insn;
>  > -		zext_patch[1].dst_reg = insn.dst_reg;
>  > -		zext_patch[1].src_reg = insn.dst_reg;
>  > -		patch = zext_patch;
>  > -		patch_len = 2;
>  > +		zext_patch.dst_reg = insn.dst_reg;
>  > +		zext_patch.src_reg = insn.dst_reg;
>  > +		patch = &zext_patch;
>  > +		patch_len = 1;
>  > +		adj_idx++;
>  > +		len_old = 0;
>  >  apply_patch_buffer:
>  > -		new_prog = bpf_patch_insns_data(env, adj_idx, 1, patch,
>  > +		new_prog = bpf_patch_insns_data(env, adj_idx, len_old,
> patch,
>  >  						patch_len);
>  >  		if (!new_prog)
>  >  			return -ENOMEM;
>  env-> prog = new_prog;
>  >  		insns = new_prog->insnsi;
>  >  		aux = env->insn_aux_data;
>  > -		delta += patch_len - 1;
>  > +		delta += patch_len - len_old;
>  >  	}
>  
>  >  	return 0;
>  > -- 
> 
>  > 2.25.4
> 
> 

