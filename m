Return-Path: <bpf+bounces-71848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF141BFE2E9
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9886E3A5287
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 20:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56CA22A7E9;
	Wed, 22 Oct 2025 20:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g3u53QTw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BF2F549F
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 20:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761165304; cv=none; b=SQTOVr2sAijUOv2gQQYhmZLQWOyLRzCJKe9YGaw+14f02aymlvlMNpz0UbXMpYodwt888ASEkOGKEuQZDcSNIeV5bgEsdu4r4l8v9Ic0tsDNOzQnFy8mRIkj5pkjWqfBe0Ro6WUv81shOQkat/h9QgRdallVSHpaY3Jn11klfYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761165304; c=relaxed/simple;
	bh=aE4lNlQa4crgHUTDnM2pWT9TstB26PhmDMUEJMxtbwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FGTCpJo/RL+2OAbeeZXh8szxLugvShh6m0+aK3bWkcnBBV1iOjoh+U5FejQar5E4dAwbxl1VWfohJ41ke6nXHm5t9EdZSkdrh+0g62Sz3vJWAlK1Vvc69PqpA3oMkMu+JEMxj45bNn2UVRxT286/epaFgwvn6UgpiS5YllTPWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g3u53QTw; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-428564f8d16so15503f8f.1
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761165301; x=1761770101; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOCMQL/wAiBi4J6RjJqrNFgNKIjmwY+37aLo+8bEb54=;
        b=g3u53QTwbcsU78OrsxOdrfVsGrznvCx7HZXYb60JXpCO2XRS59hpwxxI2Vqic4fUmq
         YejUJJejKh1fGZvJeH0lvYIOAs0pKp5WiTXJC+jcon6j8x6SMzVeXF3IAER5r+sk7FhO
         yqVT4oYmcLyQeyvWs6zbpMosKvuiWF8tvc8B7bCEEQV74XicMjKCkTnk8wYEUqhCd2Wc
         rV6AjG2jbtxlBiPkKK0tGxypQ9SLdOo3i/FLx5n2MgfhnHCmEVPfRM4K1GKBqorffIUY
         IytST1S8c04xU0sGhQFH1UFbtw/P7OejwhA1YbaYd7rANh/UtLF6OQa5dFIb0IpiXJkG
         eMgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761165301; x=1761770101;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gOCMQL/wAiBi4J6RjJqrNFgNKIjmwY+37aLo+8bEb54=;
        b=I0OwdpR1m5mYeZnZl77l8dwW+8E30aks35uCQvFKX2HRxmge5etokZmH3cAzFgJpNj
         SuOlWtmM3rJ3tkZyDZI+F0t7YdPrDgDeWSww0Gujic7Dy/WYZrhG6HzzPnKARdZbA1Cv
         cUdBGeHQEFi3KTmBGBsJv1R3+jgqTEJlRHAK+snDNQ8Z5METZJHMJYpHYvgqUV7ZWZOM
         gKTUJO1Hs6dh18P9QeQk830EncaWj6DAMQUlpLW8k1iR1OqW9l8kwjFFo9Vi2GhLRDTp
         /gNqickMngpwEpUhL30hN2WW4fZw8y+ccajkjtu9xRgLKOJtQnFqPdeJgFgh8BwzEmEV
         Wp2A==
X-Forwarded-Encrypted: i=1; AJvYcCWWbFMAqibIvjXQNm9FpACyeYIUgR8+xRznUA3StietkOYvhdupJKbBgRUV6DGesSkAkXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhi6EFPQUgDM0QX0cXTRe7zYshNPkOB6mDMB6axVXD3CnboRvb
	G+691oYG0FZcjvEGGMrpKPD0JLrvI6shEA0FfQvbYB6YyqlZU9gIIcDilp1wFadaEe0iMf6Cz/7
	KJ/S0iWtZ0TnSKS7eRVvco6lrVBep1Zs=
X-Gm-Gg: ASbGncseAz1T8kr2RN6yWS9QC7sQ8fzhYl3dk2HJllPs0R3d3YEbzkcqU0WZMJfuTxU
	795LYJhw2612DYIdGF8DrAB+JniorbTe1XyAbcyvDLw2clrOH+VMcB8WRoK72KK4rXf2XaEiLeD
	JIrZ1/6mwDjBdmUnbCVABgqRy0/pMC1FVHL8HcH16Wn2zzwJH2aHXs4YH8PFk08RFcgmH+My5Pz
	1XYjLIpbMI919iVIiv8my2ltE+EDq4gfh26rY6fkyiuD9X5/2JcMCYnm3EzXh1Xip5zuXDC01NG
	2GjRUsWJ2MY69WXC3Ic4pMVlyRVH
X-Google-Smtp-Source: AGHT+IHNTfNn1xIfZYbnIWtYBzNd2ecMfDDl7vgqcZKx0cQQ7OSVPss9Q/ulrQl/beyvLokaEORrcgTO26r+UteMcEU=
X-Received: by 2002:a5d:5847:0:b0:3e7:428f:d33 with SMTP id
 ffacd0b85a97d-42853264c37mr3549219f8f.16.1761165300670; Wed, 22 Oct 2025
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022164457.1203756-1-kafai.wan@linux.dev> <20251022164457.1203756-2-kafai.wan@linux.dev>
 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev> <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
 <CAADnVQKdMcOkkqNa3LbGWqsz9iHAODFSinokj6htbGi0N66h_Q@mail.gmail.com> <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
In-Reply-To: <abe1bd5def7494653d52425818815baa54a3628a.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 22 Oct 2025 13:34:49 -0700
X-Gm-Features: AS18NWCOUOIN10upBo9tUClQOlsY7bKB4bVpcv4wyU222Jqj1i0GptAsFooHk0M
Message-ID: <CAADnVQKzWzgUpdtv+Qe0pJ7kc4zBvG0GkKWz0btv3-WZ3cPfVw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for conditional
 jumps on same register
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan <kafai.wan@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Matan Shachnai <m.shachnai@gmail.com>, Luis Gerhorst <luis.gerhorst@fau.de>, colin.i.king@gmail.com, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, Kaiyan Mei <M202472210@hust.edu.cn>, 
	Yinhao Hu <dddddd@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 1:30=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2025-10-22 at 13:12 -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 22, 2025 at 12:46=E2=80=AFPM Eduard Zingerman <eddyz87@gmai=
l.com> wrote:
> > >
> > > On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
> > > >
> > > > On 10/22/25 9:44 AM, KaFai Wan wrote:
> > > > > When conditional jumps are performed on the same register (e.g., =
r0 <=3D r0,
> > > > > r0 > r0, r0 < r0) where the register holds a scalar with range, t=
he verifier
> > > > > incorrectly attempts to adjust the register's min/max bounds. Thi=
s leads to
> > > > > invalid range bounds and triggers a BUG warning:
> > > > >
> > > > > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds =
violation u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x=
0] var_off=3D(0x0, 0x0)
> > > > > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_=
sanity_check+0x163/0x220
> > > > > Modules linked in:
> > > > > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W        =
   6.18.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > > > > Tainted: [W]=3DWARN
> > > > > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1=
.16.3-debian-1.16.3-2 04/01/2014
> > > > > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > > > > Call Trace:
> > > > >   <TASK>
> > > > >   reg_set_min_max.part.0+0x1b1/0x360
> > > > >   check_cond_jmp_op+0x1195/0x1a60
> > > > >   do_check_common+0x33ac/0x33c0
> > > > >   ...
> > > > >
> > > > > The issue occurs in reg_set_min_max() function where bounds adjus=
tment logic
> > > > > is applied even when both registers being compared are the same. =
Comparing a
> > > > > register with itself should not change its bounds since the compa=
rison result
> > > > > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is al=
ways false).
> > > > >
> > > > > Fix this by adding an early return in reg_set_min_max() when fals=
e_reg1 and
> > > > > false_reg2 point to the same register, skipping the unnecessary b=
ounds
> > > > > adjustment that leads to the verifier bug.
> > > > >
> > > > > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > > > > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > > > > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Co=
remail.kaiyanm@hust.edu.cn/
> > > > > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > > > > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > > > > ---
> > > > >   kernel/bpf/verifier.c | 4 ++++
> > > > >   1 file changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > > > > index 6d175849e57a..420ad512d1af 100644
> > > > > --- a/kernel/bpf/verifier.c
> > > > > +++ b/kernel/bpf/verifier.c
> > > > > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_ve=
rifier_env *env,
> > > > >     if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=
=3D SCALAR_VALUE)
> > > > >             return 0;
> > > > >
> > > > > +   /* If conditional jumps on the same register, skip the adjust=
ment */
> > > > > +   if (false_reg1 =3D=3D false_reg2)
> > > > > +           return 0;
> > > >
> > > > Your change looks good. But this is a special case and it should no=
t
> > > > happen for any compiler generated code. So could you investigate
> > > > why regs_refine_cond_op() does not work? Since false_reg1 and false=
_reg2
> > > > is the same, so register refinement should keep the same. Probably
> > > > some minor change in regs_refine_cond_op(...) should work?
> > > >
> > > > > +
> > > > >     /* fallthrough (FALSE) branch */
> > > > >     regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode=
), is_jmp32);
> > > > >     reg_bounds_sync(false_reg1);
> > >
> > > I think regs_refine_cond_op() is not written in a way to handle same
> > > registers passed as reg1 and reg2. E.g. in this particular case the
> > > condition is reformulated as "r0 < r0", and then the following branch
> > > is taken:
> > >
> > >    static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct=
 bpf_reg_state *reg2,
> > >                                  u8 opcode, bool is_jmp32)
> > >    {
> > >         ...
> > >          case BPF_JLT: // condition is rephrased as r0 < r0
> > >                  if (is_jmp32) {
> > >                          ...
> > >                  } else {
> > >                          reg1->umax_value =3D min(reg1->umax_value, r=
eg2->umax_value - 1);
> > >                          reg2->umin_value =3D max(reg1->umin_value + =
1, reg2->umin_value);
> > >                  }
> > >                  break;
> > >         ...
> > >    }
> > >
> > > Note that intent is to adjust umax of the LHS (reg1) register and umi=
n
> > > of the RHS (reg2) register. But here it ends up adjusting the same re=
gister.
> > >
> > > (a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000=
] u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000=
] u32=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
> > > (c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, =
0x0] s32=3D[0x1, 0x0]
> > >
> > > At (b) the u64 range translated to s32 is > 0, while s32 range is <=
=3D 0,
> > > hence the invariant violation.
> > >
> > > I think it's better to move the reg1 =3D=3D reg2 check inside
> > > regs_refine_cond_op(), or to handle this case in is_branch_taken().
> >
> > hmm. bu then regs_refine_cond_op() will skip it, yet reg_set_min_max()
> > will still be doing pointless work with reg_bounds_sync() and sanity ch=
eck.
> > The current patch makes more sense to me.
>
> Well, if we want to avoid useless work, we need something like:
>
> @@ -16173,6 +16173,25 @@ static int is_pkt_ptr_branch_taken(struct bpf_re=
g_state *dst_reg,
>  static int is_branch_taken(struct bpf_reg_state *reg1, struct bpf_reg_st=
ate *reg2,
>                            u8 opcode, bool is_jmp32)
>  {
> +       if (reg1 =3D=3D reg2) {
> +               switch (opcode) {
> +               case BPF_JGE:
> +               case BPF_JLE:
> +               case BPF_JSGE:
> +               case BPF_JSLE:
> +               case BPF_JEQ:
> +               case BPF_JSET:
> +                       return 1;
> +               case BPF_JGT:
> +               case BPF_JLT:
> +               case BPF_JSGT:
> +               case BPF_JSLT:
> +               case BPF_JNE:
> +                       return 0;
> +               default:
> +                       return -1;
> +               }
> +       }
>
> But that's too much code for an artificial case.
> Idk, either way is fine with me.

Makes sense to me.

