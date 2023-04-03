Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9D86D3B98
	for <lists+bpf@lfdr.de>; Mon,  3 Apr 2023 03:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjDCBso (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Apr 2023 21:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCBsn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Apr 2023 21:48:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9772D6E86
        for <bpf@vger.kernel.org>; Sun,  2 Apr 2023 18:48:41 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id iw3so26551992plb.6
        for <bpf@vger.kernel.org>; Sun, 02 Apr 2023 18:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680486521; x=1683078521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xEfuOZqUioaUNjpYH146oBmHEwYliPKQXkMHIAaZDWY=;
        b=TpCNhGt7GkIYr6YQXefLCU7EYG7dhZonsD0JCG/HQbrwrWUeUZ2XbdCOP/+92vtz4m
         tjZcM2l/Kmcp4wCej33nvryUF69lRKsievF8ViV+MkyFkSMDtXDshxRZ3S1cnGkt++wQ
         OFHwN5FjCeFrY5wIokp7klfAYuCVj3E6VyoKydMgG3B4sLcU8c4tBe1vHBdswdetuJKi
         wlheIagY1mg5cQvwQdNhtpDMuOA7rYMem59/ChvZ4C70U/1lQusTlRXiao24fVUaNWvq
         b88eMYSEcsXFw7zK1Xx3eFZ6XdMv4iIfPUkbWL6XJL6Qm/pGMg98j9CZQ/54uW9yrXOq
         ZL2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680486521; x=1683078521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xEfuOZqUioaUNjpYH146oBmHEwYliPKQXkMHIAaZDWY=;
        b=ywQKxj55wxVu3FGyun/HCP1VbOZGQOGZjOTzbomPKfpb4j6rxDL3HU/mervqO5FsE+
         B4RcDYwZg+VXp4Ds7dftzZ/8fI7wgB1rcwz/hUq1Y28Kf0XlqBbrAxyEjieZZDYkJ5os
         Gg3GimobfJaxeFFEg9/w0w3AyPtJZ43SOI6xr4IuPYhlTEiWztC7+Zap81IRMlpqx8B5
         r2M+HvHBl03wj6UplsILDv9sYayIEAZHiEm+20VHaNna2ch3z+eIAaPbeJqgSauW9aje
         DiLIeFQWHer7X0aVgs9hIQOFZ16LTK9Ix78ixqjFUvB8JfNhpwT2+cyXFUsUYTtbj1kY
         mS6A==
X-Gm-Message-State: AAQBX9dsYq8iJbZV6oMIM8qFdCb5xyHDzITTrNRQuHe2/IMtXajekn4J
        BQSyhe61QmsdZnRDmK7H+BU=
X-Google-Smtp-Source: AKy350bNiK3YYJupgEBrHqQWxDR4bx/cin2hivcMEDzDTAERf1GjqUAf6nOqNaSc+DzuELP38r6BfA==
X-Received: by 2002:a17:903:1106:b0:1a2:7afc:7cd with SMTP id n6-20020a170903110600b001a27afc07cdmr20638676plh.22.1680486520903;
        Sun, 02 Apr 2023 18:48:40 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:3c8])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902988900b001a1dc2be791sm1408312plp.259.2023.04.02.18.48.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 18:48:40 -0700 (PDT)
Date:   Sun, 2 Apr 2023 18:48:38 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next 5/7] bpf: Mark potential spilled loop index
 variable as precise
Message-ID: <20230403014838.vzkfeq7qjqrp2rbr@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230330055600.86870-1-yhs@fb.com>
 <20230330055625.92148-1-yhs@fb.com>
 <7a5563bbbb29288588413c551effa6bca90e0670.camel@gmail.com>
 <8adcc374-8128-501a-555c-5f26f7e44746@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8adcc374-8128-501a-555c-5f26f7e44746@meta.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 31, 2023 at 04:39:29PM -0700, Yonghong Song wrote:
> 
> 
> On 3/31/23 2:54 PM, Eduard Zingerman wrote:
> > On Wed, 2023-03-29 at 22:56 -0700, Yonghong Song wrote:
> > > For a loop, if loop index variable is spilled and between loop
> > > iterations, the only reg/spill state difference is spilled loop
> > > index variable, then verifier may assume an infinite loop which
> > > cause verification failure. In such cases, we should mark
> > > spilled loop index variable as precise to differentiate states
> > > between loop iterations.
> > > 
> > > Since verifier is not able to accurately identify loop index
> > > variable, add a heuristic such that if both old reg state and
> > > new reg state are consts, mark old reg state as precise which
> > > will trigger constant value comparison later.
> > > 
> > > Signed-off-by: Yonghong Song <yhs@fb.com>
> > > ---
> > >   kernel/bpf/verifier.c | 20 ++++++++++++++++++--
> > >   1 file changed, 18 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > index d070943a8ba1..d1aa2c7ae7c0 100644
> > > --- a/kernel/bpf/verifier.c
> > > +++ b/kernel/bpf/verifier.c
> > > @@ -14850,6 +14850,23 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> > >   		/* Both old and cur are having same slot_type */
> > >   		switch (old->stack[spi].slot_type[BPF_REG_SIZE - 1]) {
> > >   		case STACK_SPILL:
> > > +			/* sometime loop index variable is spilled and the spill
> > > +			 * is not marked as precise. If only state difference
> > > +			 * between two iterations are spilled loop index, the
> > > +			 * "infinite loop detected at insn" error will be hit.
> > > +			 * Mark spilled constant as precise so it went through value
> > > +			 * comparison.
> > > +			 */
> > > +			old_reg = &old->stack[spi].spilled_ptr;
> > > +			cur_reg = &cur->stack[spi].spilled_ptr;
> > > +			if (!old_reg->precise) {
> > > +				if (old_reg->type == SCALAR_VALUE &&
> > > +				    cur_reg->type == SCALAR_VALUE &&
> > > +				    tnum_is_const(old_reg->var_off) &&
> > > +				    tnum_is_const(cur_reg->var_off))
> > > +					old_reg->precise = true;
> > > +			}
> > > +
> > >   			/* when explored and current stack slot are both storing
> > >   			 * spilled registers, check that stored pointers types
> > >   			 * are the same as well.
> > > @@ -14860,8 +14877,7 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
> > >   			 * such verifier states are not equivalent.
> > >   			 * return false to continue verification of this path
> > >   			 */
> > > -			if (!regsafe(env, &old->stack[spi].spilled_ptr,
> > > -				     &cur->stack[spi].spilled_ptr, idmap))
> > > +			if (!regsafe(env, old_reg, cur_reg, idmap))
> > >   				return false;
> > >   			break;
> > >   		case STACK_DYNPTR:
> > 
> > Hi Yonghong,
> > 
> > If you are going for v2 of this patch-set, could you please consider
> > adding a parameter to regsafe() instead of modifying old state?
> > Maybe it's just me, but having old state immutable seems simpler to understand.
> > E.g., as in the patch in the end of this email (it's a patch on top of your series).
> > 
> > Interestingly, the version without old state modification also performs
> > better in veristat, although I did not analyze the reasons for this.
> 
> Thanks for suggestion. Agree that my change may cause other side effects
> as I explicit marked 'old_reg' as precise. Do not mark 'old_reg' with
> precise should minimize the impact.
> Will make the change in the next revision.

Could you also post veristat before/after difference after patch 1, 3 and 5.
I suspect there should be minimal delta for 1 and 3, but 5 can make both positive
and negative effect.

> > +		if (!rold->precise && !(force_precise_const &&
> > +					tnum_is_const(rold->var_off) &&
> > +					tnum_is_const(rcur->var_off)))

... and if there are negative consequences for patch 5 we might tighten this heuristic.
Like check that rcur->var_off.value - rold->var_off.value == 1 or -1 or bounded
by some small number. If it's truly index var it shouldn't have enormous delta.
But if patch 5 doesn't cause negative effect it would be better to keep it as-is.
