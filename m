Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E451319BE8
	for <lists+bpf@lfdr.de>; Fri, 12 Feb 2021 10:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhBLJc4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 12 Feb 2021 04:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230134AbhBLJcx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 12 Feb 2021 04:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613122286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fqsCdtA/Qg+W/+yKT3VPOJTrlKvqKYGCCqSKPJdznjo=;
        b=K/eTiH4Hv5QRalIYSuKPkNSisysnLxFMn3qoMUZxRT7yiuQw2CmlaDKEL2eULkzCWyyOiM
        WayVYTRw+1V5C0AkYmRvGcV2HRWXQTvl9iDOABc6t7cm0L4KCYTJQ8iz19SI7lbDeUVqng
        KkWsxylERGuWbkFHpb94Zw2qvF787c0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-rzhGTSFdOPuCKcp33Q9j1A-1; Fri, 12 Feb 2021 04:31:24 -0500
X-MC-Unique: rzhGTSFdOPuCKcp33Q9j1A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE1CE1005501;
        Fri, 12 Feb 2021 09:31:22 +0000 (UTC)
Received: from astarta.redhat.com (ovpn-112-218.ams2.redhat.com [10.36.112.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2045C2A31E;
        Fri, 12 Feb 2021 09:31:20 +0000 (UTC)
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH bpf-next] bpf: Clear subreg_def for global function
 return values
References: <20210212040408.90109-1-iii@linux.ibm.com>
Date:   Fri, 12 Feb 2021 11:31:19 +0200
In-Reply-To: <20210212040408.90109-1-iii@linux.ibm.com> (Ilya Leoshkevich's
        message of "Fri, 12 Feb 2021 05:04:08 +0100")
Message-ID: <xunytuqhtyxk.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi, Ilya!

>>>>> On Fri, 12 Feb 2021 05:04:08 +0100, Ilya Leoshkevich  wrote:

 > test_global_func4 fails on s390 as reported by Yauheni in [1].
 > The immediate problem is that the zext code includes the instruction,
 > whose result needs to be zero-extended, into the zero-extension
 > patchlet, and if this instruction happens to be a branch, then its
 > delta is not adjusted. As a result, the verifier rejects the program
 > later.

Thank you for addressing that!

 > However, according to [2], as far as the verifier's algorithm is
 > concerned and as specified by the insn_no_def() function, branching
 > insns do not define anything. This includes call insns, even though
 > one might argue that they define %r0.

I still think that the patching code should be fixed as well,
even if it's a separate issue.

But I got the attitude.

 > This means that the real problem is that zero extension kicks in at
 > all. This happens because clear_caller_saved_regs() sets BPF_REG_0's
 > subreg_def after global function calls. This can be fixed in many
 > ways; this patch mimics what helper function call handling already
 > does.

 > [1] https://lore.kernel.org/bpf/20200903140542.156624-1-yauheni.kaliuta@redhat.com/
 > [2]
 > https://lore.kernel.org/bpf/CAADnVQ+2RPKcftZw8d+B1UwB35cpBhpF5u3OocNh90D9pETPwg@mail.gmail.com/

 > Fixes: 51c39bb1d5d1 ("bpf: Introduce function-by-function verification")
 > Reported-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
 > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
 > ---
 >  kernel/bpf/verifier.c | 3 ++-
 >  1 file changed, 2 insertions(+), 1 deletion(-)

 > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
 > index beae700bb56e..183fae996ad0 100644
 > --- a/kernel/bpf/verifier.c
 > +++ b/kernel/bpf/verifier.c
 > @@ -5211,8 +5211,9 @@ static int check_func_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 >  					subprog);
 >  			clear_caller_saved_regs(env, caller->regs);
 
 > -			/* All global functions return SCALAR_VALUE */
 > +			/* All global functions return a 64-bit SCALAR_VALUE */
 >  			mark_reg_unknown(env, caller->regs, BPF_REG_0);
 > +			caller->regs[BPF_REG_0].subreg_def = DEF_NOT_SUBREG;
 
 >  			/* continue with next insn after call */
 >  			return 0;
 > -- 

 > 2.29.2


-- 
WBR,
Yauheni Kaliuta

