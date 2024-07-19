Return-Path: <bpf+bounces-35085-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 082D293779C
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 14:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8978F1F227AE
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A913012D1FF;
	Fri, 19 Jul 2024 12:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="3b5IbfSq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B11412C530
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 12:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721391055; cv=none; b=D8FsQ2ymRg7uqYhLMtCS42v8XPXvrq7wVrMN6I8VZq8WWxxzqoGa4GjHZVcSY11DLnYZDfIyktspCkSHmMNIx3vl5HzttggTnSRUlhAFKiwTChcFZfalNyhx2xX7OQXVzaHk5enSivw2q7u+G8rzyM6s1RNEpKvb3K6+jBMx11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721391055; c=relaxed/simple;
	bh=JbKJBnKc8an/mUI5UnL+L24JtO318obtiq5Z8V1gXpY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MQj5NSXqBC3NxpowaxYkI/ZBVs2E8YVuyT+EqPG7kKkLVIizu9MyAAUIb6KUowNkMT8PwmjUPA3u15Zu7pE7ZInZd56TLNmQP/tU+jqHRKq+HHAWJPqHi9zbGzEidkMQuIXs+8dfNQ6HiQWkQG6FHqFWjAowEuRRm4iGfQZA4aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=3b5IbfSq; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a79f9a72a99so542059966b.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721391050; x=1721995850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDifd/m3fc9gPX6imrbVn+VMbE0v8XYmk4uAGHmy7B8=;
        b=3b5IbfSq0lT4y98DAkFBmxSqNWjStBkRAaRiWdzUJzJ17Z4qYf++pdpZozpFRDFlfY
         I61Zq3TM0iexhEmIHsKM7OmJHSMRB+Ay5y3dOMlPKKBU0x6DQ9HsPL0I40PB/l+Sn2KB
         ke8CNAEHH0+cdm/YAK7cK0x2t7GZG3a2gQPSEoLuzTqN2dahmJGAQEkX790vTTEIbS8h
         KYdwBghewgBW/2BgcZ2QaqHPQIQSnoWy2wb1bq449PWNXb5yefo+Cwx+0677Jr1goQho
         hm4Z/CHrb/rOY/QuoBlY5XpQ8rjl8ZlQ3QSKokuajUQpAK0PQt6jvr2Htbk3saoakGQ7
         M3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721391050; x=1721995850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDifd/m3fc9gPX6imrbVn+VMbE0v8XYmk4uAGHmy7B8=;
        b=cIOFEAPxLngIE6+QodfeGLRMSt3lUcm3W8b1gsA1kHd808iDO4ggp3s1B20BT7Qnl6
         dMF4XfDyuA6jIPSYSi6bEN6/6H8Fy8PDlngxcTfta15QhUlnEoi5pUqlgn/i63SaIail
         ChsjOMGGNVZu5+vn14EfNpW5QSgP5PHNPYHlKuY7xmSOUENiAL94JjgRgLf+7pLGNnmj
         y4SxZNeWfYpZu38HRXdA+L++iKULprYpre3eUCT9jrIk3n/UnhyYJT2mkFAnxjFZ1zyU
         5LOdo36Vk5cdL65qitwdtZrzrz0PcwrWoFpeDCkIlkt4Xpwh3rqoWURhA7ODo+3nc8gK
         UCWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVAF5rnlJPvLekwvK3awcdcmBApz68+MOho5zER3ENz8TdoutzFvVfN9+miuI9MMRxNAkg59Yz1jRS/ksyExfrSGZS
X-Gm-Message-State: AOJu0YwbKCa7iKCZDxc1yT6pHLrCX35RnbRqz0EE1Oj9QTUWb7BG6Ych
	vIY05n8b4QxXFvPcPzpuODZ18jpy3bxbATfnoYUeYnCbp6KTxJvSxGIRr6wwKm/qkBiOmtfUnyW
	L7DpUTl9Mv39g9kD6rblcbTF7I0eE9q/x62Gzww==
X-Google-Smtp-Source: AGHT+IFpWHMtPZNOH4GFZ/Qk9RhqcIGXP8rF8MVsaOGeuWjWNRsizmTMZDiNcrwEe6Q/C1QLW0uCCmiX3dfrDXR+uOg=
X-Received: by 2002:a17:907:101c:b0:a6f:e7a0:91cf with SMTP id
 a640c23a62f3a-a7a0f7754fcmr559028666b.24.1721391050260; Fri, 19 Jul 2024
 05:10:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717084102.150914-1-alexghiti@rivosinc.com> <a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com>
In-Reply-To: <a28ddc26-d77a-470a-a33f-88144f717e86@sifive.com>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 19 Jul 2024 14:10:39 +0200
Message-ID: <CAHVXubh8Adb4=-vN4cSh0FrZ16TeOKJbLj4AF09QC241bRk1Jg@mail.gmail.com>
Subject: Re: [PATCH] riscv: patch: Remove redundant functions
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 3:56=E2=80=AFAM Samuel Holland
<samuel.holland@sifive.com> wrote:
>
> Hi Alex,
>
> On 2024-07-17 3:41 AM, Alexandre Ghiti wrote:
> > Commit edf2d546bfd6f5c4 ("riscv: patch: Flush the icache right after
> > patching to avoid illegal insns") removed the last differences between
> > patch_text_set_nosync() and patch_insn_set(), and between
> > patch_text_nosync() and patch_insn_write().
> >
> > So remove the redundant *_nosync() functions.
>
> My understanding was that we would eventually revert that patch, once we =
are
> sure we never non-atomically patch the text patching code. So it's helpfu=
l to
> keep the semantic distinction between the two sets of functions.
>
> And looking at this closer, I think the original patch should not have re=
moved
> the calls to flush_icache_range() anyway. It replaces a global icache flu=
sh with
> a local icache flush, which is wrong if there is more than one CPU online=
, and
> there are a couple of places (bpf_jit_core.c, kprobes.c) where those func=
tions
> are called at runtime.

Ouch, thanks for catching this, I agree the global icache flush should
not have been removed.

I'll fix that right now,

Thanks,

Alex

>
> Regards,
> Samuel
>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > Closes: https://lore.kernel.org/linux-riscv/CAMuHMdUwx=3DrU2MWhFTE6KhYH=
m64phxx2Y6u05-aBLGfeG5696A@mail.gmail.com/
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/errata/sifive/errata.c |  4 ++--
> >  arch/riscv/errata/thead/errata.c  |  2 +-
> >  arch/riscv/include/asm/patch.h    |  3 +--
> >  arch/riscv/kernel/alternative.c   |  4 ++--
> >  arch/riscv/kernel/cpufeature.c    |  2 +-
> >  arch/riscv/kernel/jump_label.c    |  2 +-
> >  arch/riscv/kernel/patch.c         | 24 +-----------------------
> >  arch/riscv/net/bpf_jit_core.c     |  4 ++--
> >  8 files changed, 11 insertions(+), 34 deletions(-)
> >
> > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifi=
ve/errata.c
> > index 716cfedad3a2..5253b205aa17 100644
> > --- a/arch/riscv/errata/sifive/errata.c
> > +++ b/arch/riscv/errata/sifive/errata.c
> > @@ -112,8 +112,8 @@ void sifive_errata_patch_func(struct alt_entry *beg=
in, struct alt_entry *end,
> >               tmp =3D (1U << alt->patch_id);
> >               if (cpu_req_errata & tmp) {
> >                       mutex_lock(&text_mutex);
> > -                     patch_text_nosync(ALT_OLD_PTR(alt), ALT_ALT_PTR(a=
lt),
> > -                                       alt->alt_len);
> > +                     patch_insn_write(ALT_OLD_PTR(alt), ALT_ALT_PTR(al=
t),
> > +                                      alt->alt_len);
> >                       mutex_unlock(&text_mutex);
> >                       cpu_apply_errata |=3D tmp;
> >               }
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead=
/errata.c
> > index bf6a0a6318ee..0ce280a190b6 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -182,7 +182,7 @@ void thead_errata_patch_func(struct alt_entry *begi=
n, struct alt_entry *end,
> >                               memcpy(oldptr, altptr, alt->alt_len);
> >                       } else {
> >                               mutex_lock(&text_mutex);
> > -                             patch_text_nosync(oldptr, altptr, alt->al=
t_len);
> > +                             patch_insn_write(oldptr, altptr, alt->alt=
_len);
> >                               mutex_unlock(&text_mutex);
> >                       }
> >               }
> > diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/pa=
tch.h
> > index 9f5d6e14c405..6b0e9b8a321b 100644
> > --- a/arch/riscv/include/asm/patch.h
> > +++ b/arch/riscv/include/asm/patch.h
> > @@ -6,9 +6,8 @@
> >  #ifndef _ASM_RISCV_PATCH_H
> >  #define _ASM_RISCV_PATCH_H
> >
> > +int patch_insn_set(void *addr, u8 c, size_t len);
> >  int patch_insn_write(void *addr, const void *insn, size_t len);
> > -int patch_text_nosync(void *addr, const void *insns, size_t len);
> > -int patch_text_set_nosync(void *addr, u8 c, size_t len);
> >  int patch_text(void *addr, u32 *insns, int ninsns);
> >
> >  extern int riscv_patch_in_stop_machine;
> > diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/altern=
ative.c
> > index 0128b161bfda..a8b508d99cf8 100644
> > --- a/arch/riscv/kernel/alternative.c
> > +++ b/arch/riscv/kernel/alternative.c
> > @@ -83,7 +83,7 @@ static void riscv_alternative_fix_auipc_jalr(void *pt=
r, u32 auipc_insn,
> >       riscv_insn_insert_utype_itype_imm(&call[0], &call[1], imm);
> >
> >       /* patch the call place again */
> > -     patch_text_nosync(ptr, call, sizeof(u32) * 2);
> > +     patch_insn_write(ptr, call, sizeof(u32) * 2);
> >  }
> >
> >  static void riscv_alternative_fix_jal(void *ptr, u32 jal_insn, int pat=
ch_offset)
> > @@ -98,7 +98,7 @@ static void riscv_alternative_fix_jal(void *ptr, u32 =
jal_insn, int patch_offset)
> >       riscv_insn_insert_jtype_imm(&jal_insn, imm);
> >
> >       /* patch the call place again */
> > -     patch_text_nosync(ptr, &jal_insn, sizeof(u32));
> > +     patch_insn_write(ptr, &jal_insn, sizeof(u32));
> >  }
> >
> >  void riscv_alternative_fix_offsets(void *alt_ptr, unsigned int len,
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeat=
ure.c
> > index 5ef48cb20ee1..4c040a857c7e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -795,7 +795,7 @@ void __init_or_module riscv_cpufeature_patch_func(s=
truct alt_entry *begin,
> >               altptr =3D ALT_ALT_PTR(alt);
> >
> >               mutex_lock(&text_mutex);
> > -             patch_text_nosync(oldptr, altptr, alt->alt_len);
> > +             patch_insn_write(oldptr, altptr, alt->alt_len);
> >               riscv_alternative_fix_offsets(oldptr, alt->alt_len, oldpt=
r - altptr);
> >               mutex_unlock(&text_mutex);
> >       }
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_la=
bel.c
> > index e6694759dbd0..74b5ebfacf4a 100644
> > --- a/arch/riscv/kernel/jump_label.c
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -36,6 +36,6 @@ void arch_jump_label_transform(struct jump_entry *ent=
ry,
> >       }
> >
> >       mutex_lock(&text_mutex);
> > -     patch_text_nosync(addr, &insn, sizeof(insn));
> > +     patch_insn_write(addr, &insn, sizeof(insn));
> >       mutex_unlock(&text_mutex);
> >  }
> > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > index ab03732d06c4..bf45b507f900 100644
> > --- a/arch/riscv/kernel/patch.c
> > +++ b/arch/riscv/kernel/patch.c
> > @@ -177,7 +177,7 @@ static int __patch_insn_write(void *addr, const voi=
d *insn, size_t len)
> >  NOKPROBE_SYMBOL(__patch_insn_write);
> >  #endif /* CONFIG_MMU */
> >
> > -static int patch_insn_set(void *addr, u8 c, size_t len)
> > +int patch_insn_set(void *addr, u8 c, size_t len)
> >  {
> >       size_t patched =3D 0;
> >       size_t size;
> > @@ -198,17 +198,6 @@ static int patch_insn_set(void *addr, u8 c, size_t=
 len)
> >  }
> >  NOKPROBE_SYMBOL(patch_insn_set);
> >
> > -int patch_text_set_nosync(void *addr, u8 c, size_t len)
> > -{
> > -     u32 *tp =3D addr;
> > -     int ret;
> > -
> > -     ret =3D patch_insn_set(tp, c, len);
> > -
> > -     return ret;
> > -}
> > -NOKPROBE_SYMBOL(patch_text_set_nosync);
> > -
> >  int patch_insn_write(void *addr, const void *insn, size_t len)
> >  {
> >       size_t patched =3D 0;
> > @@ -230,17 +219,6 @@ int patch_insn_write(void *addr, const void *insn,=
 size_t len)
> >  }
> >  NOKPROBE_SYMBOL(patch_insn_write);
> >
> > -int patch_text_nosync(void *addr, const void *insns, size_t len)
> > -{
> > -     u32 *tp =3D addr;
> > -     int ret;
> > -
> > -     ret =3D patch_insn_write(tp, insns, len);
> > -
> > -     return ret;
> > -}
> > -NOKPROBE_SYMBOL(patch_text_nosync);
> > -
> >  static int patch_text_cb(void *data)
> >  {
> >       struct patch_insn *patch =3D data;
> > diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_cor=
e.c
> > index 0a96abdaca65..b053ae5c4191 100644
> > --- a/arch/riscv/net/bpf_jit_core.c
> > +++ b/arch/riscv/net/bpf_jit_core.c
> > @@ -226,7 +226,7 @@ void *bpf_arch_text_copy(void *dst, void *src, size=
_t len)
> >       int ret;
> >
> >       mutex_lock(&text_mutex);
> > -     ret =3D patch_text_nosync(dst, src, len);
> > +     ret =3D patch_insn_write(dst, src, len);
> >       mutex_unlock(&text_mutex);
> >
> >       if (ret)
> > @@ -240,7 +240,7 @@ int bpf_arch_text_invalidate(void *dst, size_t len)
> >       int ret;
> >
> >       mutex_lock(&text_mutex);
> > -     ret =3D patch_text_set_nosync(dst, 0, len);
> > +     ret =3D patch_insn_set(dst, 0, len);
> >       mutex_unlock(&text_mutex);
> >
> >       return ret;
>

