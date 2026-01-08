Return-Path: <bpf+bounces-78244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A52D058ED
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 19:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 452B430537A0
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 18:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C381531326B;
	Thu,  8 Jan 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+nsCcUw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910D330F7E8
	for <bpf@vger.kernel.org>; Thu,  8 Jan 2026 18:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767896931; cv=none; b=uRumIymfznU4X0p/dMrPsvIi0Yko7Y3LBR7Ujf7H+sNhUrB2a38Fri0EBssxPiqT2jYWT1DUBUNE/sZsu8n9BIgz7usCa0nGG4q2K7iZ1/sphsARJlQzeegcf/R9NUIGieiyJ+/mu9r3jB6aWgAAN7kgyedm1qUVQ3tU3EohWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767896931; c=relaxed/simple;
	bh=8s2JMPvj3seXrHZOd2ri0cCgv0uQomBHGcpFMqML/bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MIPXUf0AqGNKhiznsAfsaAxQtkeThCQhXUpvrvRj99l0ecTjlLS/q8fhgrW+jZn/2dW5No4WMPI1lKDg5SWPYWavf1cXozb1tMJCnVvwYsu9tJCAT0LQEG2c0+8EKmdUi3TJSfVf+IUyBLYTGX6nNHfz+bEzR2Hs8bGp3MltrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J+nsCcUw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8052725de4so489833866b.0
        for <bpf@vger.kernel.org>; Thu, 08 Jan 2026 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767896928; x=1768501728; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vdmP2Kw/hHYYv9cvUSxpu24BUomG1HqL2ISBo+CyrM=;
        b=J+nsCcUwZFSHyEIrQ1528SxN3hvm39HyIE4t7xwvasIXUBAlyDayCKoiHTFYN3GxRA
         tjOq3n/FIqqokZVHgwuT99j+nVt7HqjVldjuQanmxAvVn5OzC1+4kvJ4EWp1wajmHDOb
         zlN9VdPThdtww1AFkdtS3o3/zc23MFQwOvTNLl50VqV/A2wL9cLvZ9U3Txzbw+5cT8BR
         Y6lGKs8YyeW0NweBOC7rwxVbTDP7SGGspa7pQxztDktRJB2l9/1FjsEEQ4J3ZSDhaEVK
         fe5ngQXTeCAwADL2OeFth/WsWVHWypohSL3280+mF1A2LBLt32B5B5QkMRZq3U7jd5hB
         dw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767896928; x=1768501728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5vdmP2Kw/hHYYv9cvUSxpu24BUomG1HqL2ISBo+CyrM=;
        b=UmOMNiQvW9x/P9a2c86O5BDpvRdwVtOxdYhnrRwOkujnGtKDO3oy/OoFAuJl8rf+W+
         pzhxD2kEF+Hjdxh8CGYPxhm3xxjZXumfkG9oKTsF6i/GdX8x1FtA+A5WBZ+77jwh4GYq
         FbnB3bH5aeZGkuBXbukoNeCOcg3LH8/A/aQEWA7rVQ1rsWMuOkvsbxxXCrmZQCwcRko6
         9gtrnQfR68ikXOXN5nh81blC4gpUU8DsUYCdd03WwO+EpLFnKfLGeBqy3y40cdWWgy3j
         lD6bHZU1R4EJNLI+vcFMPedm1RSKWSVmWUEoeUf4kbo0Hc7m8lFOhiQSqc5wti2J7qRX
         SGww==
X-Gm-Message-State: AOJu0YzJrW3RRCg7g18eNSwliSnowZJ7J+L8c1IMxswIIuXkB+whh+IS
	cmOTS1P+D2lajS532bqvv+9G5E718ZoOP73t2bcLtECuFT/ataN3Yvn01Tnu2/0Jw9ED8JGbMIS
	BxyXVgZW43aGUaodaHHIEAL3eWJE+qKc=
X-Gm-Gg: AY/fxX6AKKSTvSOiQsd/tx654xOY4HpwkNOqoFepSNubCOQKhgyyNXX8TM3MM7o6wSb
	xGfAfrNy7O+XXgXXdai9+u+8z8GlOF66okHrsxGvxE1/osxRAm5echSC20C8T/tNdAf12InAy+G
	btmdEqAjjqLifJcxln0+HT+MXnlVgoSh/VIqW14jGwwjsEqTilSra6WlcdKSGO6m5g8C+7e0r1f
	06/blwo6sbigBsXdq3oQiKdzu7ewP1kMHqx+cK6hF+EW7dhIBW4YdmVR2AbUhjvfTcJZOQ8Wjk6
	4mnM4ZiBSJf0XnlOpsx2jg==
X-Google-Smtp-Source: AGHT+IGgRglr3/tqPTOH6oyogUHc3Ppspwvof351FjUqK+avtAK/hTRDCr+78SgSo0QnH/7RZY8Tv0L2Z5SaYUP46KE=
X-Received: by 2002:a17:906:c103:b0:b72:d56f:3468 with SMTP id
 a640c23a62f3a-b8444fc5b06mr698072266b.50.1767896927684; Thu, 08 Jan 2026
 10:28:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260103022310.935686-1-puranjay@kernel.org> <20260103022310.935686-2-puranjay@kernel.org>
 <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
In-Reply-To: <CAEf4BzYeF2sUqEzfT6aLuBVuh1W8fkxHoFjBf-e5nvJW9UgQLw@mail.gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Thu, 8 Jan 2026 18:28:33 +0000
X-Gm-Features: AQt7F2qCR8WR5YVEW2vl19BSHXKZKEpu2ZAF0MfjsMR6COjRoIK8JYetbNfmCbI
Message-ID: <CANk7y0j_BW_t7Y6rPm-UaCsamJ6G3S9i5_0cYLWZ56xp1Dehkw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Recognize special arithmetic shift
 in the verifier
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com, 
	sunhao.th@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 6, 2026 at 5:22=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jan 2, 2026 at 6:24=E2=80=AFPM Puranjay Mohan <puranjay@kernel.or=
g> wrote:
> >
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > cilium bpf_wiregard.bpf.c when compiled with -O1 fails to load
> > with the following verifier log:
> >
> > 192: (79) r2 =3D *(u64 *)(r10 -304)     ; R2=3Dpkt(r=3D40) R10=3Dfp0 fp=
-304=3Dpkt(r=3D40)
> > ...
> > 227: (85) call bpf_skb_store_bytes#9          ; R0=3Dscalar()
> > 228: (bc) w2 =3D w0                     ; R0=3Dscalar() R2=3Dscalar(smi=
n=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff))
> > 229: (c4) w2 s>>=3D 31                  ; R2=3Dscalar(smin=3D0,smax=3Du=
max=3D0xffffffff,smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> > 230: (54) w2 &=3D -134                  ; R2=3Dscalar(smin=3D0,smax=3Du=
max=3Dumax32=3D0xffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
> > ...
> > 232: (66) if w2 s> 0xffffffff goto pc+125     ; R2=3Dscalar(smin=3Dumin=
=3Dumin32=3D0x80000000,smax=3Dumax=3Dumax32=3D0xffffff7a,smax32=3D-134,var_=
off=3D(0x80000000; 0x7fffff7a))
> > ...
> > 238: (79) r4 =3D *(u64 *)(r10 -304)     ; R4=3Dscalar() R10=3Dfp0 fp-30=
4=3Dscalar()
> > 239: (56) if w2 !=3D 0xffffff78 goto pc+210     ; R2=3D0xffffff78 // -1=
36
> > ...
> > 258: (71) r1 =3D *(u8 *)(r4 +0)
> > R4 invalid mem access 'scalar'
> >
> > The error might confuse most bpf authors, since fp-304 slot had 'pkt'
> > pointer at insn 192 and became 'scalar' at 238. That happened because
> > bpf_skb_store_bytes() clears all packet pointers including those in
> > the stack. On the first glance it might look like a bug in the source
> > code, since ctx->data pointer should have been reloaded after the call
> > to bpf_skb_store_bytes().
> >
> > The relevant part of cilium source code looks like this:
> >
> > // bpf/lib/nodeport.h
> > int dsr_set_ipip6()
> > {
> >         if (ctx_adjust_hroom(...))
> >                 return DROP_INVALID; // -134
> >         if (ctx_store_bytes(...))
> >                 return DROP_WRITE_ERROR; // -141
> >         return 0;
> > }
> >
> > bool dsr_fail_needs_reply(int code)
> > {
> >         if (code =3D=3D DROP_FRAG_NEEDED) // -136
> >                 return true;
> >         return false;
> > }
> >
> > tail_nodeport_ipv6_dsr()
> > {
> >         ret =3D dsr_set_ipip6(...);
> >         if (!IS_ERR(ret)) {
> >                 ...
> >         } else {
> >                 if (dsr_fail_needs_reply(ret))
> >                         return dsr_reply_icmp6(...);
> >         }
> > }
> >
> > The code doesn't have arithmetic shift by 31 and it reloads ctx->data
> > every time it needs to access it. So it's not a bug in the source code.
> >
> > The reason is DAGCombiner::foldSelectCCToShiftAnd() LLVM transformation=
:
> >
> >   // If this is a select where the false operand is zero and the compar=
e is a
> >   // check of the sign bit, see if we can perform the "gzip trick":
> >   // select_cc setlt X, 0, A, 0 -> and (sra X, size(X)-1), A
> >   // select_cc setgt X, 0, A, 0 -> and (not (sra X, size(X)-1)), A
> >
> > The conditional branch in dsr_set_ipip6() and its return values
> > are optimized into BPF_ARSH plus BPF_AND:
> >
> > 227: (85) call bpf_skb_store_bytes#9
> > 228: (bc) w2 =3D w0
> > 229: (c4) w2 s>>=3D 31   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3D0xfffffff=
f,smin32=3D-1,smax32=3D0,var_off=3D(0x0; 0xffffffff))
> > 230: (54) w2 &=3D -134   ; R2=3Dscalar(smin=3D0,smax=3Dumax=3Dumax32=3D=
0xffffff7a,smax32=3D0x7fffff7a,var_off=3D(0x0; 0xffffff7a))
> >
> > after insn 230 the register w2 can only be 0 or -134,
> > but the verifier approximates it, since there is no way to
> > represent two scalars in bpf_reg_state.
> > After fallthough at insn 232 the w2 can only be -134,
> > hence the branch at insn
> > 239: (56) if w2 !=3D -136 goto pc+210
> > should be always taken, and trapping insn 258 should never execute.
> > LLVM generated correct code, but the verifier follows impossible
> > path and rejects valid program. To fix this issue recognize this
> > special LLVM optimization and fork the verifier state.
> > So after insn 229: (c4) w2 s>>=3D 31
> > the verifier has two states to explore:
> > one with w2 =3D 0 and another with w2 =3D 0xffffffff
> > which makes the verifier accept bpf_wiregard.c
> >
> > Note there are 20+ such patterns in bpf_wiregard.o compiled
> > with -O1 and -O2, but they're rarely seen in other production
> > bpf programs, so push_stack() approach is not a concern.
> >
> > Reported-by: Hao Sun <sunhao.th@gmail.com>
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> > Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> > ---
> >  kernel/bpf/verifier.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c9da70dd3e72..6dbcfae5615b 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -15490,6 +15490,35 @@ static bool is_safe_to_compute_dst_reg_range(s=
truct bpf_insn *insn,
> >         }
> >  }
> >
> > +static int maybe_fork_scalars(struct bpf_verifier_env *env, struct bpf=
_insn *insn,
> > +                             struct bpf_reg_state *dst_reg)
> > +{
> > +       struct bpf_verifier_state *branch;
> > +       struct bpf_reg_state *regs;
> > +       bool alu32;
> > +
> > +       if (dst_reg->smin_value =3D=3D -1 && dst_reg->smax_value =3D=3D=
 0)
> > +               alu32 =3D false;
> > +       else if (dst_reg->s32_min_value =3D=3D -1 && dst_reg->s32_max_v=
alue =3D=3D 0)
> > +               alu32 =3D true;
> > +       else
> > +               return 0;
> > +
> > +       branch =3D push_stack(env, env->insn_idx + 1, env->insn_idx, fa=
lse);
> > +       if (IS_ERR(branch))
> > +               return PTR_ERR(branch);
> > +
> > +       regs =3D branch->frame[branch->curframe]->regs;
> > +       if (alu32) {
> > +               __mark_reg32_known(&regs[insn->dst_reg], 0);
> > +               __mark_reg32_known(dst_reg, -1ull);
>
> Did you get a chance to run veristat with these changes against
> selftests, scx, maybe also Meta BPF objects? Curious if there are any
> noticeable differences.
>
> Also, the choice of which branch gets zero vs one set might have
> meaningful differences (heuristically, "linear path" should preferably
> explore conditions that lead to more complete and complex states), so
> I'd be interested to see if and what difference does it make in
> practice.


I have data using selftests, meta, and sched-ext bpf objects. I
compared baselined (bpf-next/master), previous version of this patch
(fork after arsh), and this patch (fork before and), here are the
results:

I used this command: ./veristat -C -e file,prog,states,insns -f
"insns_pct>1" before.csv after.csv

I did not see any change from baseline -> fork_after_arsh ->
fork_before_and for all selftests and meta bpf programs.

But for one sched_ext program I saw this:

../../veristat/src/veristat -C -e file,prog,states,insns -f
"insns_pct>1" sched_baseline.csv sched_fork_after_arsh.csv
File          Program              States (A)  States (B)  States
(DIFF)  Insns (A)  Insns (B)  Insns (DIFF)
------------  -------------------  ----------  ----------
-------------  ---------  ---------  ------------
scxtop.bpf.o  schedule_stop_trace           1           1    +0
(+0.00%)         14         16  +2 (+14.29%)


../../veristat/src/veristat -C -e file,prog,states,insns -f
"insns_pct>1" sched_fork_after_arsh.csv sched_fork_before_and.csv
File          Program              States (A)  States (B)  States
(DIFF)  Insns (A)  Insns (B)  Insns (DIFF)
------------  -------------------  ----------  ----------
-------------  ---------  ---------  ------------
scxtop.bpf.o  schedule_stop_trace           1           1    +0
(+0.00%)         16         15   -1 (-6.25%)


So, I think we should go with the fork before and version (this patch)
because the sequence we want to detect is arsh -> and and therefore
forking after arsh not optimal because every such arsh will not be
followed by an AND operation with a constant.

This is what you see when you compare this version (fork before and)
and previous (fork after arsh) on the selftests added in this set:

../../veristat/src/veristat -C -e file,prog,states,insns -f
"insns_pct>1" fork_after_arsh fork_before_and
File                   Program  States (A)  States (B)  States (DIFF)
Insns (A)  Insns (B)  Insns (DIFF)
---------------------  -------  ----------  ----------  -------------
---------  ---------  ------------
verifier_subreg.bpf.o  arsh_31           1           1    +0 (+0.00%)
       12         11   -1 (-8.33%)
verifier_subreg.bpf.o  arsh_63           1           1    +0 (+0.00%)
       12         11   -1 (-8.33%)

Thanks,
Puranjy

