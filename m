Return-Path: <bpf+bounces-48973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C498A12B27
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 19:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262953A67C9
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 18:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4052C1D63D8;
	Wed, 15 Jan 2025 18:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPdGizaL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2EB3BB54;
	Wed, 15 Jan 2025 18:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736966902; cv=none; b=kFycJaGrXoSYABHeJrOd47Goit87JcKXG6g1CjORc3hti9pnK4tgWGGilYHM2iA8WIbBBiC57VkJtsbqDmz8BZg0GaJq8E06AAe72O19K0BXOKscEvmr1/q03NiDTl/5msh0Uephp/1Kt7QY7LMa6vdZDRDUf7GAEHrJMIU8WRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736966902; c=relaxed/simple;
	bh=qNyy6ok9GK7t7XO1Jz+EmDrM+LXbZdzw/rlvdwtChLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JiMs6facnlQNI7ce8Flz4KhnLq0DV/X4E6e+qkBYtv+Qlo/ie6c50WsmCZzmPBCzrL24ZolrZym223+Nqh2WOQCtHy9nzXzm/NxtAdmci7+ywCovvARcIubDnNTeYrn6CxzVGusR9Gemy/8XN8oVkpZt9u5W+OKDbg2j4NfVXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPdGizaL; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5f31b3db5ecso28667eaf.0;
        Wed, 15 Jan 2025 10:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736966898; x=1737571698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0dVoO48qKoAlnATlkfyLSA/8rC2ni0iFyw41Fh9ALU=;
        b=iPdGizaLwp795FtFAIMBd1JH/uUIf1Sga9jOQpWDbrrWAC0hXEaSYWFBXQRWz5P2lR
         oQtWHQF5yonJzroOllO8MZauqMmRjSRV5rRd6GT/73whGR1EkkI84JGTnSUjgZv+LjWf
         HqFiAYK5EcwyApp89kIMYVN/0Hpu9n+OZuG4TLUUzhyWok7gYnqzWhLJpAV92wbwHv7+
         zNts596YPEn20TIC69Wfg39aKCX4rQXkxXBv2i0j9kyDTa0y3nzlub6Byixi4MKh+rYZ
         MoJBN0obO5Ndag5R3JH+/4Of777QX6AJyWfRSjXMmb1/LFQUIxN+VYlJ1Cmys8Ub3t5K
         B1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736966898; x=1737571698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0dVoO48qKoAlnATlkfyLSA/8rC2ni0iFyw41Fh9ALU=;
        b=J0EiqBg4D7ywDtonrW8ETzQupg9SaTbZWU4tMBoBYjE774kW8JPuiAcHB9V0ktiGGY
         r7Y2wK9GKIMDx2+K3sbZ8kTde9J+rMEQLOb1Xg85qq4/xsvDaVtC8i8Dlb36irS5+/Yt
         Jn7LqVTO5ZNWH/ofDm46tz8Yt6q53W1It7gPOUt2hptK+FW1xcZof6CJTQZBoxHHruaW
         QsrEXE7pMPGBQ/ZBg57fckoNBOT1w7nR+e30xBxqefm4loQ3Cm/LRQ/k5Eqbf9S48GxN
         DSfJ27yrjnLf9uStKfgZ32QX5IGJ4ghUWQyTLR5GWsV/pcGqhOaDL8fM3kuVKagWBCqQ
         oT2g==
X-Forwarded-Encrypted: i=1; AJvYcCUGQaHuSvkIEj5BFUbZaf77C2a7jGHd9UcwVj4NKClkaPwDl1HlpVs/xV7XuKAIATN7wfvBrgkGY4r0vVBU8U6CQ3yl@vger.kernel.org, AJvYcCUgmvJXaF/pOlIdizcUOJUW1nEYpbEQYHyc4MbqpSNw6x8jbwSmrbt+5by4XS33FxV3pyt0ZwvKoDgX9CwT@vger.kernel.org, AJvYcCUq0tfgsc8Y1yBkhHBmP05qX+tBtb1YKAtMFbB7FLjDed8acidi99ZlQjTF0WRPXO12PvE9dDscRyJF@vger.kernel.org, AJvYcCXVA8ocOYv644jLndP8hhgJWlpCGowevBsBYCZ3kNdB8InJ9m0k/pmYB31+b6bAmT4qRHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMTb0ZUceiApE94Sv7Ef723OPXo3KKoYaWCJXDQ8sJ9XsKGab7
	CzfVBb2qFMAFA1KVelI24PgFVtUBhqNs0ZSmUuHCV0/TL/FTyAeSbf5HLHDt+DWCYPpYO1nyIMv
	OM1gMMdOcgpectimii1cLAJuHop4=
X-Gm-Gg: ASbGncvxh+rzFnmPnoKyiMp8epHB4DP5lMFTwE4uJc5GcWDHJW4Nh838IGFJ8n+K5U1
	2OhQbSH31O2FAPoj+6tq9WvbYThxDc9P9UwMtCQ==
X-Google-Smtp-Source: AGHT+IHPGhXK8x8KgwqvTJrcJ1onKT1g57vu5dxwW5YSEn/ZJTvtQtiQN3kas6cCvxefZvJvaZdS+gaps9zPKHCAVfI=
X-Received: by 2002:a05:6871:650f:b0:29e:3c90:148b with SMTP id
 586e51a60fabf-2aa0690ed2bmr18418985fac.26.1736966898261; Wed, 15 Jan 2025
 10:48:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava> <Z4YszJfOvFEAaKjF@krava> <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com> <Z4Z7OkrtXBauaLcm@krava>
 <20250114172519.GB29305@redhat.com> <Z4eBs0-kJ3iVZjXL@krava>
 <20250115150607.GA11980@redhat.com> <CAADnVQJjroiR0SRp69f1NbomEH-riw53e_-TioqT4aEt3GSKGg@mail.gmail.com>
 <20250115184011.GA21801@redhat.com>
In-Reply-To: <20250115184011.GA21801@redhat.com>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Wed, 15 Jan 2025 10:48:06 -0800
X-Gm-Features: AbW1kvZB-bbg5FPfu0HE40BmnKMT3itURLiZLNpXb_1sZSBCNezAOUVUOaEPLug
Message-ID: <CAHsH6Gu1kXZ=m3eoTeZcZ9n=n2scxw7z074PnY5oTsXfTqZ=vQ@mail.gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
To: Oleg Nesterov <oleg@redhat.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, BPF-dev-list <bpf@vger.kernel.org>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>, 
	Linux API <linux-api@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii.nakryiko@gmail.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io, 
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:40=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wr=
ote:
>
> On 01/15, Alexei Starovoitov wrote:
> >
> > On Wed, Jan 15, 2025 at 7:06=E2=80=AFAM Oleg Nesterov <oleg@redhat.com>=
 wrote:
> > >
> > > Or we can change __secure_computing() to do nothing if
> > > this_syscall =3D=3D __NR_uretprobe.
> >
> > I think that's the best way forward.
> > seccomp already allowlists sigreturn syscall.
>
> Only if SECCOMP_MODE_STRICT. But it won't help if we add __NR_uretprobe
> into into mode1_syscalls/mode1_syscalls_32.
>
> SECCOMP_MODE_FILTER can do anything. Just I guess nobody tries to offend
> sigreturn for obvious reasons.
>
> But yes, perhaps we do not have a better solution.
>

Indeed - doing the check in __secure_computing_strict() doesn't seem to be
enough.

In __secure_computing(), i.e. the below hack it works.

Eyal.

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 385d48293a5f..5739482036ce 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1359,6 +1359,9 @@ int __secure_computing(const struct seccomp_data *sd)
        this_syscall =3D sd ? sd->nr :
                syscall_get_nr(current, current_pt_regs());

+       if (this_syscall =3D=3D __NR_uretprobe)
+               return 0;
+
        switch (mode) {
        case SECCOMP_MODE_STRICT:
                __secure_computing_strict(this_syscall);  /* may call do_ex=
it */

