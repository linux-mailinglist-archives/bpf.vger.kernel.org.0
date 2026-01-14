Return-Path: <bpf+bounces-78929-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 541A5D20106
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 17:06:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 94DEC3003FC0
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6483A1D1B;
	Wed, 14 Jan 2026 16:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwdjZ+3j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356952459D9
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406692; cv=none; b=FmDKjhlTcUAZqTxXUW+geZrOb3rsNv3F6f+AQbuP2S5Ahk8OOLJaABS2+YlgDaxrHZDFud4qSZwq7Y6m+hXcKAl+3lLfs/8ASr2tS7JuHIxZIbqn872BOBbGbFz4QxkXgrxPLa+ymy7hakmCpIyPKBr6cIYvkVIiuauI//nnANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406692; c=relaxed/simple;
	bh=AOAKPHneUH2k+u5Nki0rOk/2j6zn7hjEd1n2qbAL9Jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvqM9FOmBfk6mY/Vwg4+vs0BRrtZ4OTm1/rA/Es6LM7p9RMvxAGb2vUTXIQ2sKXEILJT7TCrXCB6TflSMYa6F8mZw/RGxyN3OQYnYpjWmTC2kgFMhQeUS21tIyIZzlknOx91DarZgpF34S8EJ7uWWmE578zfG9l/f2vcthIdSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UwdjZ+3j; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-430f2ee2f00so5279601f8f.3
        for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768406689; x=1769011489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFL3Ab0hoeKdAkXw+EXhrpvZ7ps8U7iR9VnnL8zsKgI=;
        b=UwdjZ+3ja9U6LW28eu4yE/EjY0CLNQj1/LyosjrARrgKRuawfoB0RLZWH2fjSSGA4m
         9kq6TrgWBLDsTKM6ZlrqoYy82B82MsIdHWUjJ0vf461eb6L36XKlfS5JmERGKyNbNsU2
         vXNgBR7vSWtIEcBhFoLvJlXHRI38iwMoOStziJhvW0wKi2lapDkCCXlBqWIpy5aeKShr
         k0aFIUrNz7w+px7SmBIpax4DatWuzvPP87tHpftBqH0DGuPprUgpycoUlfT8lnFjtfca
         aUKMnJZvsPQ2hHUYeh1lygu01X0XsFppKt0AtrBQvv/hM6/1OpYsBdDy9cPSlZJmJOIQ
         YkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768406689; x=1769011489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DFL3Ab0hoeKdAkXw+EXhrpvZ7ps8U7iR9VnnL8zsKgI=;
        b=YrbNDSL2egnvY7ndvukmzxrGnVCCNGltFojS9mreRG3sHng/rCbLhusW0QLOBCkisH
         +pFGv93R6InF80B7le4+dkPs8+8jAI3On+iLsypStOhvIrJhMwJR/GVloMFLddo+5X2U
         n0vDyds29eRc+RsYOC+zYKNym4kBZweoumum6q9FqpKjNng0raPEe03fW81LRvFfLCdQ
         vL/CR7zFGKsQhG3HOgxfR5viWiNOB1a0CMIFBFFNUu1IQwsKhz4shlbfNhfuWOl85l5+
         oe8BndwD326VXCMYexx3gQ0Mh5szKlU+N67iz14o3TlkobrPNPTrYbd/KSPvYMbu/AKt
         i2zw==
X-Forwarded-Encrypted: i=1; AJvYcCUzovITDfUdfxCQ1t6AdQZkRerNSx82YO5jKrHR3kBbKF9NuBTeOkmUIzMIqyYgimEbPig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6rPzXHv5lkX+xkhOYH2/v9mmFYk4u7S2T85/E5jdeuruBlxq
	q4/PZyco+HYiphemDWd2mIgt7nJuPmdF1e0i17xVy6rSS7l8rK5BLA0Xo7lI+Oz1ayNr3vcmnKs
	qLglAn4BW4DdqoW1zVPlkit/eysfD92k=
X-Gm-Gg: AY/fxX53h+5AR1sV4ZUk1rdELKpxh5T7Zp4eIOOoecJDr1whHGhPRpqjSr+9CHMDhbR
	lE2QJcTlypQVA9Kb39qVFqUDNplvpUbgoqA+Z0RT2SO5nePaRrY3oyLkG/UJrj3rAfXeLs6J+jd
	BQ9OLYgIdGq8EgdNxNEhNxTGFu0mPjE6CeabWRl0QAtkX49/art8PAM0oN7Zovv3i3+QAgVg4Z+
	Yr2Uq22mMu+eM3oGITFZW9/FUswojQFFAvfph2aOxKw4xvzlF6jTYsKlPhsFQSAgTQBcRrUjGgL
	WnvrBpUQd/73eH60M8FMokA3Relp
X-Received: by 2002:a05:6000:2409:b0:432:84f9:9802 with SMTP id
 ffacd0b85a97d-4342c5483a3mr3996169f8f.49.1768406689407; Wed, 14 Jan 2026
 08:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102150032.53106-1-leon.hwang@linux.dev> <CAADnVQJugf_t37MJbmvhrgPXmC700kJ25Q2NVGkDBc7dZdMTEQ@mail.gmail.com>
 <aWd9z8GVYO12YsaH@krava>
In-Reply-To: <aWd9z8GVYO12YsaH@krava>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 14 Jan 2026 08:04:38 -0800
X-Gm-Features: AZwV_QhBzgwavE9dCvsyPnD3846iYc1-CBAq5_FLY28uDU4ys3fEyjL92GFBT_8
Message-ID: <CAADnVQLxo1uPbutGNKrv=f=bSVkzxOfSof0ea8n7VvqsaU+S3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/4] bpf: tailcall: Eliminate max_entries and
 bpf_func access at runtime
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 3:28=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jan 02, 2026 at 04:10:01PM -0800, Alexei Starovoitov wrote:
> > On Fri, Jan 2, 2026 at 7:01=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev=
> wrote:
> > >
> > > This patch series optimizes BPF tail calls on x86_64 and arm64 by
> > > eliminating runtime memory accesses for max_entries and 'prog->bpf_fu=
nc'
> > > when the prog array map is known at verification time.
> > >
> > > Currently, every tail call requires:
> > >   1. Loading max_entries from the prog array map
> > >   2. Dereferencing 'prog->bpf_func' to get the target address
> > >
> > > This series introduces a mechanism to precompute and cache the tail c=
all
> > > target addresses (bpf_func + prologue_offset) in the prog array itsel=
f:
> > >   array->ptrs[max_entries + index] =3D prog->bpf_func + prologue_offs=
et
> > >
> > > When a program is added to or removed from the prog array, the cached
> > > target is atomically updated via xchg().
> > >
> > > The verifier now encodes additional information in the tail call
> > > instruction's imm field:
> > >   - bits 0-7:   map index in used_maps[]
> > >   - bits 8-15:  dynamic array flag (1 if map pointer is poisoned)
> > >   - bits 16-31: poke table index + 1 for direct tail calls
> > >
> > > For static tail calls (map known at verification time):
> > >   - max_entries is embedded as an immediate in the comparison instruc=
tion
> > >   - The cached target from array->ptrs[max_entries + index] is used
> > >     directly, avoiding the 'prog->bpf_func' dereference
> > >
> > > For dynamic tail calls (map pointer poisoned):
> > >   - Fall back to runtime lookup of max_entries and prog->bpf_func
> > >
> > > This reduces cache misses and improves tail call performance for the
> > > common case where the prog array is statically known.
> >
> > Sorry, I don't like this. tail_calls are complex enough and
> > I'd rather let them be as-is and deprecate their usage altogether
> > instead of trying to optimize them in certain conditions.
> > We have indirect jumps now. The next step is indirect calls.
> > When it lands there will be no need to use tail_calls.
> > Consider tail_calls to be legacy. No reason to improve them.
>
> hi,
> I'd like to make tail calls available in sleepable programs. I still
> need to check if there's technical reason we don't have that, but seeing
> this answer I wonder you'd be against that anyway ?

tail_calls are not allowed in sleepable progs?
I don't remember such a limitation.
What prevents it?
prog_type needs to match, so all sleepable progs should be fine.
The mix and match is problematic due to rcu vs srcu life times.

> fyi I briefly discussed that with Andrii indicating that it might not
> be worth the effort at this stage.

depending on complexity of course.

