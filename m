Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB7A102EBF
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 23:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfKSWAn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 17:00:43 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34447 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfKSWAn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 17:00:43 -0500
Received: by mail-pf1-f196.google.com with SMTP id n13so13044379pff.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 14:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sxycmZ+qbtHYaJWmWxttfxgOO0zpNtTDXfwuq92qy6Y=;
        b=tFC7Y+qmiFFPbz6I0UoKGffSgCuDhNbHe0Mc+4V1afI7bakIqDzybxSPTVmr1AAUQY
         P1+TKLJWdMvEtT3xo1Kd1mYr/Wrx3xELI106SoveC/SFa37umv2xCJgFVbUJkzD6KyaP
         azY+rNfoTXVMDv3MXngvvpDaDXaor6Xaq6pd6wUNESQkTSiwDog6CZ8W/EvEd0z2Oq27
         xB3f90FXllsG1UnqVCljvJujFxEfObtMAr7Cb7mzrOeDoPXzhFmCQIdkYM6TGMyHc1KU
         YqSN+QQuIGg9YJcaGYrfZOf7JC8tmpQD1r2HERzS45DpcgQMbn+3C5GmbFlawmr3TaD1
         ivJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sxycmZ+qbtHYaJWmWxttfxgOO0zpNtTDXfwuq92qy6Y=;
        b=D5BoxkMQ+YQNrA/RmKNyn9iM0NksReAyjGrwCNiovQkUU23FMoUCn7QbYHF6895Dcu
         QrFW5tZyJ3yiqf8PJ8c+Viap0ZHDKqF3W1DnjNWO/1AWvsXtvaycNLRA1G0IWeXF5ROS
         jbegm4lVeYex9svdzB4UX9Cj2N3XMEMRQjWAVfBnqDsJDdiXUN4vXabb+iuYkat9NSg/
         Ls8qoR4+9/wkVcvylVJuIA2obF+NFU2w1mPHyEq8jSUre70/9ueVjAo+mBHV9qZSSDIS
         NUfYr96HmGrpbXbRptWZ9wvQNYEBa2jVxFf2Rg5GO0ojmKTf65JMLcrEs6OO2s2NdMoE
         FW4Q==
X-Gm-Message-State: APjAAAWWMqp/ewgQ0n42jo5UVVvk5uy9bmcoMUNclOH3b7LGHeDob5wr
        C/Kr3wi6eKUsyuYRgYb79I1F5PqH
X-Google-Smtp-Source: APXvYqzF1fJTDmXjC3U6AkbponPpAvve4hwfBe3kyb3ttBS+Q359Z7GbrpiMfsbynsMphXOqE6+LEQ==
X-Received: by 2002:a65:5cc1:: with SMTP id b1mr8032384pgt.36.1574200842654;
        Tue, 19 Nov 2019 14:00:42 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:72f7])
        by smtp.gmail.com with ESMTPSA id v10sm24289602pgr.37.2019.11.19.14.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 14:00:41 -0800 (PST)
Date:   Tue, 19 Nov 2019 14:00:40 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
Subject: Re: [PATCH bpf-next v2 2/3] bpf: allow s32/u32 return types in
 verifier for bpf helpers
Message-ID: <20191119220038.6q2y7lwum5liie4e@ast-mbp.dhcp.thefacebook.com>
References: <20191119195711.3691681-1-yhs@fb.com>
 <20191119195712.3692027-1-yhs@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119195712.3692027-1-yhs@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 19, 2019 at 11:57:12AM -0800, Yonghong Song wrote:
>  #define TNUM(_v, _m)	(struct tnum){.value = _v, .mask = _m}
> -/* A completely unknown value */
> +/* completely unknown 32-bit and 64-bit values */
> +const struct tnum tnum_unknown32 = { .value = 0, .mask = 0xffffffffULL };
>  const struct tnum tnum_unknown = { .value = 0, .mask = -1 };
>  
>  struct tnum tnum_const(u64 value)
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a344b08aef77..945827351758 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -1024,6 +1024,15 @@ static void __mark_reg_unbounded(struct bpf_reg_state *reg)
>  	reg->umax_value = U64_MAX;
>  }
>  
> +/* Reset the min/max bounds of a sub register */
> +static void __mark_subreg_unbounded(struct bpf_reg_state *subreg)
> +{
> +	subreg->smin_value = S32_MIN;
> +	subreg->smax_value = S32_MAX;
> +	subreg->umin_value = 0;
> +	subreg->umax_value = U32_MAX;
> +}

when int32 is returned the above feels correct, but I think it conflicts with
definition of tnum_unknown32, since it says that upper 32-bit should be zero.
The typical verifier action after processing alu32 insn:
        if (BPF_CLASS(insn->code) != BPF_ALU64) {
                /* 32-bit ALU ops are (32,32)->32 */
                coerce_reg_to_size(dst_reg, 4);
        }

        __reg_deduce_bounds(dst_reg);
        __reg_bound_offset(dst_reg);

And that is correct behavior for alu32, but here the helper is returning
'int', so if the verifier says subreg->smin_value = S32_MIN;
it means that upper bits will be non-zero.
The helper can return (u64)-1 with all 64-bits being set to 1.
If next insn after w0 = call helper; is w0 += imm;
the verifier will do above coerce+deduce logic and clear upper bits.
That's correct, but without extra alu32 operation on w0 the state
of r0 is technically correct, but doesn't match r0->var_reg
which is tnum_unknown32.
I wonder whether it should be tnum_unknown instead with above
__mark_subreg_unbounded() ?

>+
>  /* Mark a register as having a completely unknown (scalar) value. */
>  static void __mark_reg_unknown(struct bpf_reg_state *reg)
>  {
> @@ -1038,6 +1047,20 @@ static void __mark_reg_unknown(struct bpf_reg_state *reg)
>  	__mark_reg_unbounded(reg);
>  }
>  
> +/* Mark a sub register as having a completely unknown (scalar) value. */
> +static void __mark_subreg_unknown(struct bpf_reg_state *subreg)
> +{
> +	/*
> +	 * Clear type, id, off, and union(map_ptr, range) and
> +	 * padding between 'type' and union
> +	 */
> +	memset(subreg, 0, offsetof(struct bpf_reg_state, var_off));
> +	subreg->type = SCALAR_VALUE;
> +	subreg->var_off = tnum_unknown32;
> +	subreg->frameno = 0;
> +	__mark_subreg_unbounded(subreg);
> +}

