Return-Path: <bpf+bounces-34573-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 609B392EB4A
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 17:06:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ADDA28508D
	for <lists+bpf@lfdr.de>; Thu, 11 Jul 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2E16B3BF;
	Thu, 11 Jul 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IXLaNSMS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3156715E5BA
	for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710404; cv=none; b=ih6BaFe4gZ7MiaXbwcmRuUEoP6/dZTy4s8hmVclAySx77dy8ZT68FJmEqFxFUitCNeSva3/i8WDxWiKjy0TIzTPGtgWpWTTXqzAq2OgwW8T51+E0UDn47dofy+uGCW8R0m7W3As+DDD/nPU7bioOftiq2goYJDyls1zeumIg4ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710404; c=relaxed/simple;
	bh=Ced6ybPGisXJqSKs6IdsxgEGc4hpnsMluyuCU7JTP4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=umWbO5nZhAcAhwp72Bf7p5bXUjap86HYevayvJ5QPa23q2QxSw8cCNgch48fyHwAkkN6vsyKBJpwVxTyi7mTBz9KHCwvLHAlv+9i1zyYILq2JoSm2UOBj879S1qwEMK+b6a2CwPYEk3LUUGFvfLNQImIdqB7GOBqMG8cakfAUfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IXLaNSMS; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2eec7e431d9so11964931fa.2
        for <bpf@vger.kernel.org>; Thu, 11 Jul 2024 08:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1720710400; x=1721315200; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z+GWok8s1qNSZ43H0zJtaT7i5kLiby+rUtJ3vmkCF6Y=;
        b=IXLaNSMS1HwA0/I//A4qt5cUHJ4o+i8J1vI6Dc4Tg9hWwMX1WhcT5sGON9SSTc1Itg
         53hMmXhzyaDiycZyhrAqUXvzrregmPDkYgbcFHSIF5wrBuQ07DUicg6KqtMWrr9QFVbM
         7prQgIwomS2Uy7s4iXQTIW3rkRDgsTVD3coc66URGoij0z9AZ+vcDWLbX5oOSDExJutc
         NKAyciYi2Jtop7uudWkQdTyLtHp8RMmV029nIWO6PAYwLCXjkjvrDy/AKEe4W4hhlupV
         EXzqoqBEQ7dK09qlxkstoD67/HOwYzaAyCWzCLyXIXmY/Gv98Y03hjd774izhkwahXyB
         ay7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720710400; x=1721315200;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z+GWok8s1qNSZ43H0zJtaT7i5kLiby+rUtJ3vmkCF6Y=;
        b=AR0yM5zOiuUNrwJRCKN3e1xW7UGv5HMmOuRhqw6LGkIgZhpSOxfBju2/s3UcByBMDR
         cMNJO+1bTLA8St6BdfpL9gsA7Sx2t0vZo/UflKDVWVx64aWXyCYgzYreAZZPQ3vOCeab
         Dzdf0GSeNA4kB3geHlCmDs3+J/JFPTyUVuUkBMwsTl+req2VFur6XO7W7X8eW5BT4dhV
         t7kz3TPbRcFOwZqP50AGsXx95SFH+IW8Xk6+RuOKL3IdEKh+VS4r/PBT3una9kK4tr+D
         oS0zBNrCkUH2m+wuUSmmd+4Ex/BMdSBTGTb2kBYDOGt/ql/fRZDE4M8I3ezxH4I88uo/
         lz0Q==
X-Gm-Message-State: AOJu0YyvyfpnAYyjThTmFWeoY4hRO9So3PP4aw1TAgdESc+YnBCKMxtK
	vdcf0mtNXXpTi12t1TpfzUiE2weMTf/KZegGA0GVTOTBr/3zQ8Asmz1c6Uc0sNU=
X-Google-Smtp-Source: AGHT+IGWbA5wWsKHre4wQvQ1N75uximnEcIVeQJvN/fOOM2gnvHKumiOBBIRSLxf+F0ROH43RzpAag==
X-Received: by 2002:a2e:9048:0:b0:2ec:2314:3465 with SMTP id 38308e7fff4ca-2eeb30b9fe3mr54348981fa.11.1720710400204;
        Thu, 11 Jul 2024 08:06:40 -0700 (PDT)
Received: from u94a (2001-b011-fa04-3639-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:3639:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11a41sm51775695ad.62.2024.07.11.08.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 08:06:39 -0700 (PDT)
Date: Thu, 11 Jul 2024 23:06:32 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Jiri Olsa <jolsa@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: use check_add_overflow() to check
 for addition overflows
Message-ID: <wc4r4owrama24tgtzxir3yn3cocg4ebapygqmw7yv3eifqamnl@5kxz5f6wghal>
References: <20240701055907.82481-1-shung-hsi.yu@suse.com>
 <20240701055907.82481-2-shung-hsi.yu@suse.com>
 <CAADnVQ+Ou-kxp2XKo2HHZL1xhBZt-XJfoRhwm+v3FY52HxJ2Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+Ou-kxp2XKo2HHZL1xhBZt-XJfoRhwm+v3FY52HxJ2Kg@mail.gmail.com>

On Tue, Jul 09, 2024 at 07:08:31PM GMT, Alexei Starovoitov wrote:
> On Sun, Jun 30, 2024 at 10:59 PM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > signed_add*_overflows() was added back when there was no overflow-check
> > helper. With the introduction of such helpers in commit f0907827a8a91
> > ("compiler.h: enable builtin overflow checkers and add fallback code"), we
> > can drop signed_add*_overflows() in kernel/bpf/verifier.c and use the
> > generic check_add_overflow() instead.
> >
> > This will make future refactoring easier, and takes advantage of
> > compiler-emitted hardware instructions that efficiently implement these
> > checks.
> >
> > After the change GCC 13.3.0 generates cleaner assembly on x86_64:
> >
> >         err = adjust_scalar_min_max_vals(env, insn, dst_reg, *src_reg);
> >    13625:       mov    0x28(%rbx),%r9  /*  r9 = src_reg->smin_value */
> >    13629:       mov    0x30(%rbx),%rcx /* rcx = src_reg->smax_value */
> >    ...
> >         if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
> >    141c1:       mov    %r9,%rax
> >    141c4:       add    0x28(%r12),%rax
> >    141c9:       mov    %rax,0x28(%r12)
> >    141ce:       jo     146e4 <adjust_reg_min_max_vals+0x1294>
> >             check_add_overflow(*dst_smax, src_reg->smax_value, dst_smax)) {
> >    141d4:       add    0x30(%r12),%rcx
> >    141d9:       mov    %rcx,0x30(%r12)
> >         if (check_add_overflow(*dst_smin, src_reg->smin_value, dst_smin) ||
> >    141de:       jo     146e4 <adjust_reg_min_max_vals+0x1294>
> >    ...
> >                 *dst_smin = S64_MIN;
> >    146e4:       movabs $0x8000000000000000,%rax
> >    146ee:       mov    %rax,0x28(%r12)
> >                 *dst_smax = S64_MAX;
> >    146f3:       sub    $0x1,%rax
> >    146f7:       mov    %rax,0x30(%r12)
> >
> > Before the change it gives:
> >
> >         s64 smin_val = src_reg->smin_value;
> >      675:       mov    0x28(%rsi),%r8
> >         s64 smax_val = src_reg->smax_value;
> >         u64 umin_val = src_reg->umin_value;
> >         u64 umax_val = src_reg->umax_value;
> >      679:       mov    %rdi,%rax /* rax = dst_reg */
> >         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
> >      67c:       mov    0x28(%rdi),%rdi /* rdi = dst_reg->smin_value */
> >         u64 umin_val = src_reg->umin_value;
> >      680:       mov    0x38(%rsi),%rdx
> >         u64 umax_val = src_reg->umax_value;
> >      684:       mov    0x40(%rsi),%rcx
> >         s64 res = (s64)((u64)a + (u64)b);
> >      688:       lea    (%r8,%rdi,1),%r9 /* r9 = dst_reg->smin_value + src_reg->smin_value */
> >         return res < a;
> >      68c:       cmp    %r9,%rdi
> >      68f:       setg   %r10b /* r10b = (dst_reg->smin_value + src_reg->smin_value) > dst_reg->smin_value */
> >         if (b < 0)
> >      693:       test   %r8,%r8
> >      696:       js     72b <scalar_min_max_add+0xbb>
> >             signed_add_overflows(dst_reg->smax_value, smax_val)) {
> >                 dst_reg->smin_value = S64_MIN;
> >                 dst_reg->smax_value = S64_MAX;
> >      69c:       movabs $0x7fffffffffffffff,%rdi
> >         s64 smax_val = src_reg->smax_value;
> >      6a6:       mov    0x30(%rsi),%r8
> >                 dst_reg->smin_value = S64_MIN;
> >      6aa:       00 00 00        movabs $0x8000000000000000,%rsi
> >         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
> >      6b4:       test   %r10b,%r10b /* (dst_reg->smin_value + src_reg->smin_value) > dst_reg->smin_value ? goto 6cb */
> >      6b7:       jne    6cb <scalar_min_max_add+0x5b>
> >             signed_add_overflows(dst_reg->smax_value, smax_val)) {
> >      6b9:       mov    0x30(%rax),%r10   /* r10 = dst_reg->smax_value */
> >         s64 res = (s64)((u64)a + (u64)b);
> >      6bd:       lea    (%r10,%r8,1),%r11 /* r11 = dst_reg->smax_value + src_reg->smax_value */
> >         if (b < 0)
> >      6c1:       test   %r8,%r8
> >      6c4:       js     71e <scalar_min_max_add+0xae>
> >         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
> >      6c6:       cmp    %r11,%r10 /* (dst_reg->smax_value + src_reg->smax_value) <= dst_reg->smax_value ? goto 723 */
> >      6c9:       jle    723 <scalar_min_max_add+0xb3>
> >         } else {
> >                 dst_reg->smin_value += smin_val;
> >                 dst_reg->smax_value += smax_val;
> >         }
> >      6cb:       mov    %rsi,0x28(%rax)
> >      ...
> >      6d5:       mov    %rdi,0x30(%rax)
> >      ...
> >         if (signed_add_overflows(dst_reg->smin_value, smin_val) ||
> >      71e:       cmp    %r11,%r10
> >      721:       jl     6cb <scalar_min_max_add+0x5b>
> >                 dst_reg->smin_value += smin_val;
> >      723:       mov    %r9,%rsi
> >                 dst_reg->smax_value += smax_val;
> >      726:       mov    %r11,%rdi
> >      729:       jmp    6cb <scalar_min_max_add+0x5b>
> >                 return res > a;
> >      72b:       cmp    %r9,%rdi
> >      72e:       setl   %r10b
> >      732:       jmp    69c <scalar_min_max_add+0x2c>
> >      737:       nopw   0x0(%rax,%rax,1)
> >
> > Suggested-by: Jiri Olsa <jolsa@kernel.org>
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> >  kernel/bpf/verifier.c | 94 +++++++++++++------------------------------
> >  1 file changed, 28 insertions(+), 66 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index d3927d819465..26c2b7527942 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -12725,26 +12725,6 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >         return 0;
> >  }
> >
> > -static bool signed_add_overflows(s64 a, s64 b)
> > -{
> > -       /* Do the add in u64, where overflow is well-defined */
> > -       s64 res = (s64)((u64)a + (u64)b);
> > -
> > -       if (b < 0)
> > -               return res > a;
> > -       return res < a;
> > -}
> > -
> > -static bool signed_add32_overflows(s32 a, s32 b)
> > -{
> > -       /* Do the add in u32, where overflow is well-defined */
> > -       s32 res = (s32)((u32)a + (u32)b);
> > -
> > -       if (b < 0)
> > -               return res > a;
> > -       return res < a;
> > -}
> 
> Looks good,
> unfortunately it gained conflict while sitting in the queue.
> signed_add16_overflows() was introduced.
> Could you please respin replacing signed_add16_overflows()
> with check_add_overflow() ?

Ack, will send respin a v3 patchset tomorrow.

