Return-Path: <bpf+bounces-71843-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76711BFE146
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 21:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9415B18C4E5F
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 19:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976C62ECEA8;
	Wed, 22 Oct 2025 19:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IbM8fVV1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445F6229B38
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 19:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162410; cv=none; b=Dn2xjrvq1S+3ycinHweNlJnpm4L90NlqjPuSd01eZxzheoJGq54t2NjpqxKO3p8ngSyzJZwNfS4hSGbL2HAUq2zLPN88FZD1Ca6hk88faoLVBV/Zfc3Dc3SIdGJnTJYUThyw/amS0Bua2t5OeEN1V7527T7uDPH7coq24Y0eqws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162410; c=relaxed/simple;
	bh=S/hh9/DeowLYEhJeBCNJoewLIAtZFWUGUe4gp+FIQNQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ms4JgGPZhaaohDg6ObOjVIsXUQa2Is5tjmv5e0vTyfC5GudUN3IAGK+vwcegm7wrus41SP42/r0Z8BhVLJ1dPG5n0d6m/TiI5/1P7628ajGAGA9+D2dIq5h1ave57PWnpBnA+2W1OV/r1L8+UsjN88ceMjoii1ZpVgwEgAhLPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IbM8fVV1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781010ff051so24047b3a.0
        for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 12:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761162408; x=1761767208; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EWn78QyuKi/0YAncXLY/1r1sZ48dyDwTSq2IyjTdbM4=;
        b=IbM8fVV1zuPqLXj4M1QiSk1ZDYtworO0iJ5/1xagQXq6xDPvb0Wus8fxudHszkJDY6
         gM9LBYBaav+FTqvowQsX14r7mrSFMXoAhCZDC+ZdK6f7qcKYN5TEMlJKLsXwE6JC3ySx
         1ZUnmuytvEDZw7X3p4RbszLAXTcOgYXM7WXnSOTA0PuKs8jLyAuWAHcnEapEUf/aCCPp
         1W//b/8fE+FoFBMpcGOri3RBvIXHEk3x60453n8IoMh3tU+Y+lnJBrVBrD0CFGoODy35
         zaZZGPZWNQABhKMAkGcN93yY08l30MFr1sxWhs8Q7XHP4b7bRvTJMKQTGR73eI8LtnhI
         wf3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761162408; x=1761767208;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EWn78QyuKi/0YAncXLY/1r1sZ48dyDwTSq2IyjTdbM4=;
        b=OnSKu6XKePtqGo9L5ABuLGEBkWN3CX7oZEWltmspvE192vgXOMXVNYujnYZkcniJJZ
         GioXkTI7m3ZbUbW+ooh3ORj4P4JJ4s7ml5kYslbGsNm0vqiH8TZqk/EvRz7K040DkPwX
         uNmhFn/TLYck0GNOsh2Fapb9nx9bBj/VS8sh1ygYDr+99n1ZNkNXQtCk/y6AAObFNLSk
         7Ja9NQTtXLcQHLqPdt33nD8L0XrGv4Noon9dJhwO4AR2TbEa6gTEzinVemSLJ3KsLaL7
         LTcVTaYw89wJK2V/Irs79umJTrzkw0o8Ao/xrA3p6fFr5rcjO/Ymc8L10ZMiflO/YgIi
         uGmQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6RMGHhKdFtrAGwxiW8ia1Qe9GLnF4f+KPsCUX2IivC2Xf+8JEaEKszsRAoNp+c9FcQWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjQLA8i0xtbI2T5ueLoYjQpyjNNTjTDWniWKSEBVkzBzqUo/kS
	xRRsLlhQrwoiLXdd/I0oNRGkihsy0BMprNNncYv8DyGn35vZsYyAUYiMOf7kidOumkQ=
X-Gm-Gg: ASbGncuzBbDYLIYiBm844qvlHSyq2ORJb6ssGI+IfEV8XqpjoAE0QYn9A+G7gxKAmvl
	24KNgqkRjYfhTJNFb1v3TGRPpJMjzlLIFpIhVzsU/595e9F2XeKU8nbzsGI4i8h4o3BTsvaXNtW
	lkrYlCs2xEVQqkHhNuTnf8Hs3V61c66FxCRlDXdbfKslqrEZcz/3Hsyx08nnFPZvsgdlQFQrgWy
	NvaXg5tE0uNXsIvtdo0XRXBH9MYkJT2XF7VwDuhHo1qBFbWJY8eyOFvRuaF7zqLyhTchbnET3TQ
	6fF9S/GsMKHpytpJTFvcctsxBi6VhmkV/JO6mdAxYJUYDTC0/2oSxfYQpn4e37Xn4LMwohbEQTn
	VkyLLAE7dBhjWQcGd5sqhqPywmYvDtquHQTByi6jf7e+qC//KftSG6MverZKWa8zukJypZO7wTI
	7L5lFdkrZARMDw/GwWZ7w9rXQ+
X-Google-Smtp-Source: AGHT+IHymbTcbH235aXvQeVtJWuH5sno4WRQtI5oIYoYQBt9QK1TA5w0gykjqr/O4pXkL3QYwNj9hA==
X-Received: by 2002:a05:6a20:939d:b0:250:1407:50a1 with SMTP id adf61e73a8af0-334a85763b5mr27844617637.24.1761162407500;
        Wed, 22 Oct 2025 12:46:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fa8d:1a05:3c71:d71? ([2620:10d:c090:500::7:b877])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b5a007sm13513736a12.31.2025.10.22.12.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 12:46:47 -0700 (PDT)
Message-ID: <1d03174dfe2a7eab1166596c85a6b586a660dffc.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Skip bounds adjustment for
 conditional jumps on same register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, KaFai Wan
 <kafai.wan@linux.dev>, 	ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, 	martin.lau@linux.dev,
 song@kernel.org, kpsingh@kernel.org, sdf@fomichev.me, 	haoluo@google.com,
 jolsa@kernel.org, shuah@kernel.org, paul.chaignon@gmail.com, 
	m.shachnai@gmail.com, luis.gerhorst@fau.de, colin.i.king@gmail.com, 
	harishankar.vishwanathan@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Kaiyan Mei <M202472210@hust.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>
Date: Wed, 22 Oct 2025 12:46:45 -0700
In-Reply-To: <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
References: <20251022164457.1203756-1-kafai.wan@linux.dev>
	 <20251022164457.1203756-2-kafai.wan@linux.dev>
	 <39af9321-fb9b-4cee-84f1-77248a375e85@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-22 at 11:14 -0700, Yonghong Song wrote:
>=20
> On 10/22/25 9:44 AM, KaFai Wan wrote:
> > When conditional jumps are performed on the same register (e.g., r0 <=
=3D r0,
> > r0 > r0, r0 < r0) where the register holds a scalar with range, the ver=
ifier
> > incorrectly attempts to adjust the register's min/max bounds. This lead=
s to
> > invalid range bounds and triggers a BUG warning:
> >=20
> > verifier bug: REG INVARIANTS VIOLATION (true_reg1): range bounds violat=
ion u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s32=3D[0x1, 0x0] var=
_off=3D(0x0, 0x0)
> > WARNING: CPU: 0 PID: 93 at kernel/bpf/verifier.c:2731 reg_bounds_sanity=
_check+0x163/0x220
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 93 Comm: repro-x-3 Tainted: G        W           6.1=
8.0-rc1-ge7586577b75f-dirty #218 PREEMPT(full)
> > Tainted: [W]=3DWARN
> > Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-=
debian-1.16.3-2 04/01/2014
> > RIP: 0010:reg_bounds_sanity_check+0x163/0x220
> > Call Trace:
> >   <TASK>
> >   reg_set_min_max.part.0+0x1b1/0x360
> >   check_cond_jmp_op+0x1195/0x1a60
> >   do_check_common+0x33ac/0x33c0
> >   ...
> >=20
> > The issue occurs in reg_set_min_max() function where bounds adjustment =
logic
> > is applied even when both registers being compared are the same. Compar=
ing a
> > register with itself should not change its bounds since the comparison =
result
> > is always known (e.g., r0 =3D=3D r0 is always true, r0 < r0 is always f=
alse).
> >=20
> > Fix this by adding an early return in reg_set_min_max() when false_reg1=
 and
> > false_reg2 point to the same register, skipping the unnecessary bounds
> > adjustment that leads to the verifier bug.
> >=20
> > Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> > Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> > Closes: https://lore.kernel.org/all/1881f0f5.300df.199f2576a01.Coremail=
.kaiyanm@hust.edu.cn/
> > Fixes: 0df1a55afa83 ("bpf: Warn on internal verifier errors")
> > Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
> > ---
> >   kernel/bpf/verifier.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 6d175849e57a..420ad512d1af 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16429,6 +16429,10 @@ static int reg_set_min_max(struct bpf_verifier=
_env *env,
> >   	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCAL=
AR_VALUE)
> >   		return 0;
> >  =20
> > +	/* If conditional jumps on the same register, skip the adjustment */
> > +	if (false_reg1 =3D=3D false_reg2)
> > +		return 0;
>=20
> Your change looks good. But this is a special case and it should not
> happen for any compiler generated code. So could you investigate
> why regs_refine_cond_op() does not work? Since false_reg1 and false_reg2
> is the same, so register refinement should keep the same. Probably
> some minor change in regs_refine_cond_op(...) should work?
>=20
> > +
> >   	/* fallthrough (FALSE) branch */
> >   	regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_j=
mp32);
> >   	reg_bounds_sync(false_reg1);

I think regs_refine_cond_op() is not written in a way to handle same
registers passed as reg1 and reg2. E.g. in this particular case the
condition is reformulated as "r0 < r0", and then the following branch
is taken:

   static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
                                 u8 opcode, bool is_jmp32)
   {
 	...
         case BPF_JLT: // condition is rephrased as r0 < r0
                 if (is_jmp32) {
                         ...
                 } else {
                         reg1->umax_value =3D min(reg1->umax_value, reg2->u=
max_value - 1);
                         reg2->umin_value =3D max(reg1->umin_value + 1, reg=
2->umin_value);
                 }
                 break;
 	...
   }

Note that intent is to adjust umax of the LHS (reg1) register and umin
of the RHS (reg2) register. But here it ends up adjusting the same register=
.

(a) before refinement: u64=3D[0x0, 0x80000000] s64=3D[0x0, 0x80000000] u32=
=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
(b) after  refinement: u64=3D[0x1, 0x7fffffff] s64=3D[0x0, 0x80000000] u32=
=3D[0x0, 0x80000000] s32=3D[0x80000000, 0x0]
(c) after  sync      : u64=3D[0x1, 0x0] s64=3D[0x1, 0x0] u32=3D[0x1, 0x0] s=
32=3D[0x1, 0x0]

At (b) the u64 range translated to s32 is > 0, while s32 range is <=3D 0,
hence the invariant violation.

I think it's better to move the reg1 =3D=3D reg2 check inside
regs_refine_cond_op(), or to handle this case in is_branch_taken().

