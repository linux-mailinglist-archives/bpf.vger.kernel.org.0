Return-Path: <bpf+bounces-67375-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EE0B42F49
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 03:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184691BC69C1
	for <lists+bpf@lfdr.de>; Thu,  4 Sep 2025 01:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00A51DF75A;
	Thu,  4 Sep 2025 01:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpuG0gXu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2BC1D416E
	for <bpf@vger.kernel.org>; Thu,  4 Sep 2025 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756950968; cv=none; b=gDPDf1+u13YYA/jfBtu+0dZ++/Ij/l1OV4yNj+DCZgfCURh6CV0KF9RgBtk3ZRFbKqM0Ef6165ZNqhIAkMA3nxollQtxVXHahdE5tVqSr5Exa9C8mpdg7oCppTKJQPc7LG6WVOp1e65duiOcsrEGsb9uPeeDalOH59wC3lW0kBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756950968; c=relaxed/simple;
	bh=ljELCZ3EEuD72BQeb9rp/6Kd4VYAUpMiq0p9928L3jQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozytyulpy2SR7mvn5DlqrsftV8vQWi6P3GTU0Lm1lcW/cikz3CXYmh0NWPRer7a2FRuyw0tk0uY0M3Jsgt8IIAEiQWjXHeV1k3jykRdpk/IW4e1hQWMkF1Y2+WTg5HSzcEjQROHIiELERjOZkj3wPLAXHA/iU1L9mVG1o8Y6w4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpuG0gXu; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-315aedbb286so221224fac.1
        for <bpf@vger.kernel.org>; Wed, 03 Sep 2025 18:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756950966; x=1757555766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vl5wa7S4775+BI6Ww5C2U24DXhwcJOmu5ZWRFqiYorA=;
        b=kpuG0gXur4wn5WEezSn2Tmd5QYcLu4Nlx2gQN2Sw+w6HR/6CggdvKgpi+PemsRECjW
         /1n5d24lkg9jvUyAuvaI/YLqBWNsIcJ6nc/yQiinBUFFOSKIA0Sk2nRDBT+kAt4grtbD
         XubTBxozVegz3IuUr5CAXoVX3Ko7n2+lpItWqEvHLSQXg9RIlXg1i6k3bXkqzQ5iV5Zw
         nezg4c6zpwEHD6aPEwfJiak0hYjm7NK3db1TBz0IWO8WZhzrldTwBRyUgKdG+1s7I3jv
         JLWlbkLVVpFqAV6TEsEFoe05KYOHN2JXoaw9YaU9T0VgW5btXMpuN8FO7UIDB51dr5Ev
         WVzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756950966; x=1757555766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vl5wa7S4775+BI6Ww5C2U24DXhwcJOmu5ZWRFqiYorA=;
        b=pkCbmK4gbgcvNOURparC7AWyMK4Pfw87wD80AHyOYL8lEuZ/fvpnLpwn3ND59ybgrW
         4s54uECI/1M9eXTmAvuF4BdBGAq573pUOSG2qDd2B+HWvGhYa/sRjHShcCDaor5gfN2j
         WV4WtDgAxdcnBmy83xfI5LLZtPFJVb9kybkTXVFjUJnMHVmMnjTfFoCXo/Ez3YL8cqc3
         B2SHiHZnr+GTQmPBxd4jyW2b1XRsspLBrL7oL+mXkBgm1mIcc5nrblPkGqWHHxNq52kh
         wc+7KDalDy6xacH0OGhlupTQ5SX8JEkb9vP/d5FdJAmppii9VqtZDIJFqAZ856v1L8XZ
         p1rg==
X-Forwarded-Encrypted: i=1; AJvYcCWBcOhM/HOP+Smm0uUp4YKr6ZAonudqhra3+k9UbRfsy81/yBykSP6SBc2z7suLAmD/K0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBjSE6oegDpJjTqnk73fY24nWGP3T+IE15O/HunlCl72b6XXJ
	RUOECJZa/jlWcpVkWQ5Y9WWRHilARNro0V360JCPT/isyebSLKBHXVrFQcE0+xUaObbUkpWCQtS
	MiExCyKIMkjpomb76rMIjWGFTPbm1+kfH/4Xmug3hmw==
X-Gm-Gg: ASbGncvRJ8xDJBKd7JbzG278o8ysoG5Dix7oLnplwIL/RZiQAveZVIginIcnEPit89N
	Wp1jcZ7n0eKkNd+djG+A+bAMWHWf2gtdHdga0lSBD8yjasPou8oGRyaEzmPncMwjq2oxCghZbke
	/+rS4LstjCR3jzFB3xnHUqZC9Q2WRSyaMNfi+Wq79PM+hZSDXP3qKS8UQHp/wSwOjMWtKKyLNa2
	4t8aX8=
X-Google-Smtp-Source: AGHT+IGos+nk0g/lQcrsyfKTlcAtBLk/ikuaZedRHSZrcnPOcXKoiRVg/i57Aqv9IIkqYI5tUZMA676fxWb4NqcG+Gg=
X-Received: by 2002:a05:6871:4e49:b0:315:2fcc:327f with SMTP id
 586e51a60fabf-319633463acmr8274318fac.31.1756950965883; Wed, 03 Sep 2025
 18:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250903070113.42215-1-hengqi.chen@gmail.com> <20250903070113.42215-6-hengqi.chen@gmail.com>
 <CAAhV-H5PkWkhnBWEynxJki3rbN6rh_HW1hmVUY+ixY0Gx+ot+w@mail.gmail.com>
In-Reply-To: <CAAhV-H5PkWkhnBWEynxJki3rbN6rh_HW1hmVUY+ixY0Gx+ot+w@mail.gmail.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 4 Sep 2025 09:55:54 +0800
X-Gm-Features: Ac12FXwAJXTGUvQfoxWFnhx5LkhtAjav7g_EZqKjMBMtoowQERfPsuqTZbDGVZY
Message-ID: <CAEyhmHTsnLmQy2ShLKwnsrPforzVCA0rGFs0RPQYFOkXgErcmg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] LoongArch: BPF: Don't assume trampoline size is
 page aligned
To: Huacai Chen <chenhuacai@kernel.org>
Cc: yangtiezhu@loongson.cn, vincent.mc.li@gmail.com, hejinyang@loongson.cn, 
	loongarch@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 10:56=E2=80=AFPM Huacai Chen <chenhuacai@kernel.org>=
 wrote:
>
> Hi, Hengqi,
>
> On Wed, Sep 3, 2025 at 8:06=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
> >
> > Currently, arch_alloc_bpf_trampoline() use bpf_prog_pack_alloc()
> > which will pack multiple trampolines into a huge page. So no need
> > to assume the trampoline size is page aligned.
> We do the alignment because larch_insn_text_copy() changes page attrs.
> If there is other data and BPF trampoline is in the same page,
> changing page attrs may cause errors.
>

Doesn't stop_machine() prevent this side effect?

> Huacai
>
> >
> > Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> > ---
> >  arch/loongarch/net/bpf_jit.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 35b13d91a979..43628b5e1553 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -1747,8 +1747,7 @@ int arch_bpf_trampoline_size(const struct btf_fun=
c_model *m, u32 flags,
> >
> >         ret =3D __arch_prepare_bpf_trampoline(&ctx, &im, m, tlinks, fun=
c_addr, flags);
> >
> > -       /* Page align */
> > -       return ret < 0 ? ret : round_up(ret * LOONGARCH_INSN_SIZE, PAGE=
_SIZE);
> > +       return ret < 0 ? ret : ret * LOONGARCH_INSN_SIZE;
> >  }
> >
> >  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
> > --
> > 2.43.5
> >

