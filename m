Return-Path: <bpf+bounces-68473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF299B58F54
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 09:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F15B2A3D45
	for <lists+bpf@lfdr.de>; Tue, 16 Sep 2025 07:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43A8F2E9ECE;
	Tue, 16 Sep 2025 07:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEy/056y"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CA215F5C
	for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758008346; cv=none; b=nogDVLJw+NaonmpblyXbXtauA+e7/0oJcwRuSfuN/bfOU6xmpbv++oxlzHDvwD5Y20ljkSqQx0ihcPtaI5df7/PYHiZgU1ke4mjMMbYate1ecI2yBl64yPguXO3tBDNcjLGTYBaoU6sn+UXMaGB+a+LtgWc9ijZY7XCyd4FgXME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758008346; c=relaxed/simple;
	bh=kmgtCKcaGq1TS6gN6oAVKXRK6ildMc3mt0pNGRwRZ74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=En1tSOZPgEO6OWe+r5SqhfZUj50K4T1fW5SGcUytsIZcO0bqqnHZH0exOOc6wGJVnYvM2URlx/PgXg7AUpROHLZoLVQyu5URvTpAiiNcwYfdaLLlFQU4dvRLbDf81uYZdqlFruorgB7ZEmx212nqaZ95Pj2A11XElC4K1EpRW+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SEy/056y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45dd7b15a64so44489005e9.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 00:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758008343; x=1758613143; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRl4H4nkKCFdr5azPJlArKLA0wO/GJIj4KkP3viY6UQ=;
        b=SEy/056ye+DOCLN/SYPytqFIPCYfaKq2rYOToMk9fq5XZ8+3r0bEhsjcavbtvCzezw
         3RdtxvsxyLsYhLrhyw8P/ksGDOMV/ltWriIxGGAiyYswfWVW/XqJBHuGhUu8pLF5NakW
         ab4utn2N5j9JarQ2oy9bz10WGifYvKXvTb535ulpv6euyhIO8qtV2gSfBeU3AGGmM3cI
         SKCct7XNBCDwMEFNGRX/s9p0YEJofWwjgqRBB+TC4IKlAOcQQKV/oU6xTnCXlLbz+kWK
         2EiXaJi8pyp7CJp/hAqPXbAtxeJX8tDN8NftAEWv35oug7400Ey6bhPFj1gzbFRkN4Y4
         LMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758008343; x=1758613143;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRl4H4nkKCFdr5azPJlArKLA0wO/GJIj4KkP3viY6UQ=;
        b=l6ZOzq5Zd+cg7l5bV0247TvoMCgDjrrtHJ50VsI/ao9o9mFOr+M6+ZezI+mRAI5H4O
         JepVNW4NQZxGWPb/4/zMc3yN2RiavYxVntqqJU1eVBefkRRIyuEUj1tAtCJ0DpnUff3Q
         TJTOzYA+OK4ZJNW7PRzpT6JDMdHfkr5X/By70GPzseflQLDfnAOKyI8L+cPolJ+PN4xq
         mYcPE6bQ3FGEdZJLw3LXWAlg/bjwhMVlG9/TSPumb+79U2kml6Cf3oB9EvrvZsIrFo9L
         gT5zEPROPZYrOsXZJFkyAINrnsCX0JdsrhGRzWuSVuXgzEkC2scVY6GCldWFPJbm2U9+
         UUpA==
X-Forwarded-Encrypted: i=1; AJvYcCV8imbXPXgW2CB2rTtoWXDGr/AwxW1G2WmEQNE+hWZqhv/fHslQvG3k0HaijoC+uEPhjoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YziY8t0i4JBF2V/EZzAmXKIy+9fPUY0N28Ro1QDNTSDXM4Zo6sR
	NdlfNjc7hrN7DNdO3y2CWWp/fz+zeVvGsaoHdWCeZ3VPUGtOway8Lsxq
X-Gm-Gg: ASbGncuOl2dLA3X9obm17azr5dcEQr2WM9iJo6PzkFb2hdT3r800InzS2PkSmxRrv7Z
	WNhRkmEMVpVtNzBjPu4omIzlA2SJJx2YN5B2ekycrSHFsyHnpsvUEDwT4lWsHHpXNOkscALT5T3
	Fx9CsWHAbDE+gXIimLlNhRfeNh0gpULNO1isBaJGxkRDF3LXueqxToMYl1FRpZunfGLI+po1pzr
	hRUqYughji3i58BGoy+WebWSa9rOuhBiNUiGHXSdisEVnR20bAnXy5o6/paS/8JwPrNXnx38nru
	sTMRS7Fk4hw1SuSFtT6ZuIb6CgtuFbTCdrg/hhTE7IIQVNJ6FIlAS5BzKSs1Hn1PYMJpzCpGu5v
	cndm/Pd8OlLIM7azjcyjo5KKHxweTYxlsgRg3kCR9Pi4EWvOVVPrkw3voXYhhZCZIOfuAa/8Tlq
	hMOql0jH7z/oOosUkZZEXnUoiajtFhfM8=
X-Google-Smtp-Source: AGHT+IFIuA/YGnAo2MMqjJ6OKOz5D8aEK5K+VJJantZ/1V3Q0dW2gA0XT5qXdFr3jhNUK3JPrdJnIg==
X-Received: by 2002:a05:600c:c8d:b0:45d:dc10:a5ee with SMTP id 5b1f17b1804b1-45f32d4906emr9146175e9.15.1758008343014;
        Tue, 16 Sep 2025 00:39:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e007ab5a3c32e2e7a7c.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7ab5:a3c3:2e2e:7a7c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3eb35e4fbafsm5922616f8f.41.2025.09.16.00.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 00:39:01 -0700 (PDT)
Date: Tue, 16 Sep 2025 09:39:00 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org,
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: Re: [PATCH] bpf: verifier: fix WARNING in reg_bounds_sanity_check (2)
Message-ID: <aMkUFNr-0kYLfMNH@mail.gmail.com>
References: <20250913222323.894182-1-kriish.sharma2006@gmail.com>
 <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com>

On Mon, Sep 15, 2025 at 12:54:20PM -0700, Andrii Nakryiko wrote:
> On Sat, Sep 13, 2025 at 3:24 PM Kriish Sharma
> <kriish.sharma2006@gmail.com> wrote:
> >
> > syzbot reported a "REG INVARIANTS VIOLATION" triggered in reg_bounds_sanity_check()
> > due to inconsistent umin/umax and var_off state after min/max updates.
> >
> > reg_set_min_max() and adjust_reg_min_max_vals() could leave a register state
> > partially updated before syncing the bounds, causing verifier_bug() to fire.
> >
> > This patch ensures reg_bounds_sync() is called after updates, and additionally
> > marks registers unbounded if min/max values are inconsistent, so that umin/umax,
> > smin/smax, and var_off remain consistent.
> >
> > Fixes: d69eb204c255 ("Merge tag 'net-6.17-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> > Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=c950cc277150935cc0b5
> > Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> > ---
> >  kernel/bpf/verifier.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index c4f69a9e9af6..8f5f02d39005 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -16299,6 +16299,19 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
> >         }
> >  }
> >
> > +/* Ensure that a register's min/max bounds are sane.
> > + * If any of the unsigned/signed bounds are inconsistent, mark the
> > + * register as unbounded to prevent verifier invariant violations.
> > + */
> > +static void __maybe_normalize_reg(struct bpf_reg_state *reg)
> > +{
> > +       if (reg->umin_value > reg->umax_value ||
> > +               reg->smin_value > reg->smax_value ||
> > +               reg->u32_min_value > reg->u32_max_value ||
> > +               reg->s32_min_value > reg->s32_max_value)
> > +                       __mark_reg_unbounded(reg);
> > +}
> > +
> >  /* Adjusts the register min/max values in the case that the dst_reg and
> >   * src_reg are both SCALAR_VALUE registers (or we are simply doing a BPF_K
> >   * check, in which case we have a fake SCALAR_VALUE representing insn->imm).
> > @@ -16325,11 +16338,15 @@ static int reg_set_min_max(struct bpf_verifier_env *env,
> >         regs_refine_cond_op(false_reg1, false_reg2, rev_opcode(opcode), is_jmp32);
> >         reg_bounds_sync(false_reg1);
> >         reg_bounds_sync(false_reg2);
> > +       __maybe_normalize_reg(false_reg1);
> > +       __maybe_normalize_reg(false_reg2);
> >
> >         /* jump (TRUE) branch */
> >         regs_refine_cond_op(true_reg1, true_reg2, opcode, is_jmp32);
> >         reg_bounds_sync(true_reg1);
> >         reg_bounds_sync(true_reg2);
> > +       __maybe_normalize_reg(true_reg1);
> > +       __maybe_normalize_reg(true_reg2);
> 
> We are actually taking a different approach to this problem. Eduard is
> going to modify verifier logic to use the fact that register' tnum and
> range bounds are incompatible to detect branches that cannot be taken,
> and process it as dead code. This way we don't lose information (like
> with the approach in this patch), but rather take advantage of it to
> improve verification performance.
> 
> Thanks for your patch, but I think we should go with the more generic
> solution I outlined above.

Agree with Andrii here. And even without Eduard's approach, there's a
better fix for the specific invariant violations reported here. The
reproducers end with:

  5: (1f) r3 -= r0                ; R0=0x8000050 R3_w=scalar(smin=0xffffffffefffff60,smax=smax32=0,umin=umin32=32,umax=0xffffffffffffffe0,smin32=0xf7ffffe0,umax32=0xffffffe0,var_off=(0x20; 0xffffffffffffffc0))
  6: (2e) if w3 > w0 goto pc+2
  REG INVARIANTS VIOLATION (false_reg1): range bounds violation u64=[0x20, 0xffffffff08000050] s64=[0xffffffffefffff60, 0x0] u32=[0x20, 0x8000050] s32=[0x20, 0x0] var_off=(0x20, 0xffffffff0fffffc0)

We can see that on instruction 5, the smin32 and umin32 ranges can
actually be improved for R3 because they overlap. They're not currently
updated because they cross the sign boundary, so a patch like
00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign boundary"),
but for 32-bits would be needed. Once those ranges are updated, it's
clear the jump is never taken.

We can reconsider this after Eduard's patch lands, but I doubt such a
fix will still be needed at that point :)

> 
> pw-bot: cr
> 
> 
> >
> >         err = reg_bounds_sanity_check(env, true_reg1, "true_reg1");
> >         err = err ?: reg_bounds_sanity_check(env, true_reg2, "true_reg2");
> > --
> > 2.34.1
> >
> 

