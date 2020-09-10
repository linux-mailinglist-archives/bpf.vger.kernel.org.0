Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E921F263DDD
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgIJHCC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 03:02:02 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45692 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730127AbgIJG7u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 02:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599721189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g/dN2Mc0YhDZG8/fW6zj0Wql29qoTWx3jdFpwth6400=;
        b=fbyGtF6kWjrO648yJaKoNEs9hN1GY9lmRqmzhPDqtylwKCIoDpIcOxS69b0P1KNDkjoWLD
        pMo6JptZKq1grlhQ9Xqa6GEoqO265dy3kwMvLyAM1/3sfbvRl7av9zjnBdJPeXK5o+3P+I
        cCyKB1WYc4ltVz6pbPmxi9NG0ZayNAU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-572-Hd3nEurbMn-jh5G_q973aA-1; Thu, 10 Sep 2020 02:59:47 -0400
X-MC-Unique: Hd3nEurbMn-jh5G_q973aA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4D518015C6;
        Thu, 10 Sep 2020 06:59:45 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-127.ams2.redhat.com [10.36.112.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CFF7060C07;
        Thu, 10 Sep 2020 06:59:43 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH RFC bpf-next 5/5] bpf: Do not include the original insn
 in zext patchlet
References: <20200909233439.3100292-1-iii@linux.ibm.com>
        <20200909233439.3100292-6-iii@linux.ibm.com>
Date:   Thu, 10 Sep 2020 09:59:41 +0300
In-Reply-To: <20200909233439.3100292-6-iii@linux.ibm.com> (Ilya Leoshkevich's
        message of "Thu, 10 Sep 2020 01:34:39 +0200")
Message-ID: <xuny363qazhe.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya!

Cool, thanks!

Shouldn't the rnd patch be done the same way for completeness?
Even if it is unlikely there to hit the problem.

>>>>> On Thu, 10 Sep 2020 01:34:39 +0200, Ilya Leoshkevich  wrote:

 > If the original insn is a jump, then it is not subjected to branch
 > adjustment, which is incorrect. As discovered by Yauheni in

 > https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/

 > this causes `test_progs -t global_funcs` failures on s390.

 > Most likely, the current code includes the original insn in the
 > patchlet, because there was no infrastructure to insert new insns, only
 > to replace the existing ones. Now that bpf_patch_insns_data() can do
 > insertions, stop including the original insns in zext patchlets.

 > Fixes: a4b1d3c1ddf6 ("bpf: verifier: insert zero extension according
 > to analysis result")
 > Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
 > ---
 >  kernel/bpf/verifier.c | 20 +++++++++++---------
 >  1 file changed, 11 insertions(+), 9 deletions(-)

 > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
 > index 17c2e926e436..64a04953c631 100644
 > --- a/kernel/bpf/verifier.c
 > +++ b/kernel/bpf/verifier.c
 > @@ -9911,7 +9911,7 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 >  static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 >  					 const union bpf_attr *attr)
 >  {
 > -	struct bpf_insn *patch, zext_patch[2], rnd_hi32_patch[4];
 > +	struct bpf_insn *patch, zext_patch, rnd_hi32_patch[4];
 >  	struct bpf_insn_aux_data *aux = env->insn_aux_data;
 >  	int i, patch_len, delta = 0, len = env->prog->len;
 >  	struct bpf_insn *insns = env->prog->insnsi;
 > @@ -9919,13 +9919,14 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 >  	bool rnd_hi32;
 
 >  	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
 > -	zext_patch[1] = BPF_ZEXT_REG(0);
 > +	zext_patch = BPF_ZEXT_REG(0);
 >  	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
 >  	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
 >  	rnd_hi32_patch[3] = BPF_ALU64_REG(BPF_OR, 0, BPF_REG_AX);
 >  	for (i = 0; i < len; i++) {
 >  		int adj_idx = i + delta;
 >  		struct bpf_insn insn;
 > +		int len_old = 1;
 
 >  		insn = insns[adj_idx];
 >  		if (!aux[adj_idx].zext_dst) {
 > @@ -9968,20 +9969,21 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 >  		if (!bpf_jit_needs_zext())
 >  			continue;
 
 > -		zext_patch[0] = insn;
 > -		zext_patch[1].dst_reg = insn.dst_reg;
 > -		zext_patch[1].src_reg = insn.dst_reg;
 > -		patch = zext_patch;
 > -		patch_len = 2;
 > +		zext_patch.dst_reg = insn.dst_reg;
 > +		zext_patch.src_reg = insn.dst_reg;
 > +		patch = &zext_patch;
 > +		patch_len = 1;
 > +		adj_idx++;
 > +		len_old = 0;
 >  apply_patch_buffer:
 > -		new_prog = bpf_patch_insns_data(env, adj_idx, 1, patch,
 > +		new_prog = bpf_patch_insns_data(env, adj_idx, len_old, patch,
 >  						patch_len);
 >  		if (!new_prog)
 >  			return -ENOMEM;
 env-> prog = new_prog;
 >  		insns = new_prog->insnsi;
 >  		aux = env->insn_aux_data;
 > -		delta += patch_len - 1;
 > +		delta += patch_len - len_old;
 >  	}
 
 >  	return 0;
 > -- 

 > 2.25.4


-- 
WBR,
Yauheni Kaliuta

