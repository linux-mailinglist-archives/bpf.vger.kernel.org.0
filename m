Return-Path: <bpf+bounces-79347-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF494D3893E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 23:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BB6863034F8E
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D53313E18;
	Fri, 16 Jan 2026 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD0S73rG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E25311C06
	for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768602612; cv=none; b=NUx60ruL6C0nZi3e3VXSg+tpVOWWo22LijASQ5ydtfAmql5qEvbjBrIj0K+pkVy0y9rpkbIvYMDUKLq9NiP0ICAl+beIzLVx5iJOj8i6kmJ+j45onT4lZ/wymj6+gMI6gh/oii+wOUTNhd9bTFN0l1JPozKbK5GIP4dglGFApDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768602612; c=relaxed/simple;
	bh=ac6u8bc+wG4neFqEUvKXAUAp0GSnqi8XVHMCZOPtVy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlkQ25izRAgs2PsLd5IPczu1IxEwaTJ9BtX/Z6YFRiMSEiwKE+pqdpkR0hjP0EZnoYyVVrwb9vxZiGnEf/ZCHbA1CVrBihwwbdt0JNcN0NIvUYBn390Q9goIZdrahoeuqSWLwS+JKeyiDkOeGU/wMCL7cZ8aRLLv+9AFUD1l85A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD0S73rG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a0a33d0585so16087885ad.1
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 14:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768602609; x=1769207409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KL3h3XPj79+qCH1TXE9xv0DwmENH0Pp+6mUWFaWCMv0=;
        b=WD0S73rGsCGcoGiixRH4Q6L9pQB6EkWt0nCt38a3KJKXYbJwhBye4rxWnu8xfkdFSH
         BdZVtky3x4eaVH284DkVIo1Noo1ZoM7bvc2wHvuMmwGmH3lHIOIzUoCSntVZT/nJFkdE
         0t3oxOSktLQBdIlVYoj4EaSt5ubWwKAC0hP5TZ4HYb7vxeN7z1JcOSpBV/ObMTArCtpp
         Rm5GLi6NpOn7/KCrZxZQPQtk/9Op123+ar96ZrBcKZcQ4A2+SdId4hnXncfEjgkbGvyv
         dSus6VaQZQCnBYATn2jQNwfShOUJqWSJSwfPGIVjKlh8pWFcQYe8oXp0X2KLTO7j92Gu
         ggtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768602609; x=1769207409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KL3h3XPj79+qCH1TXE9xv0DwmENH0Pp+6mUWFaWCMv0=;
        b=ADfa3ijFA24x0hpmFI/ieTdyiJ48xZjSfqJRnNSbLL8pwLTk2FDlcSJiiii2zJipZv
         AWjBKAAwKIb4VlDsseya7fmX5Kks3j/r3AyR0bu4uv2+2RgSI94cWt9VvUgDYM/BAe6R
         BbLrSrxFwt68s3pcmYL9hB9apeI3IF+griJnXLmxJoVy1/THqTgCSCKlff3QFakOEYMx
         Yw0tAHYh89ix4ijF1rLNYIfLmex68m42g0sXQ3WJ9onQ5i2lH+3t+FZ+wNG/rkWF+m6z
         bMuHesJXBYh2GBNPBi5PrZwJZQKNGhqz0WCbS/Ac4Ea68nmjx64OBwutYdOLfuhKdwG2
         KlCw==
X-Gm-Message-State: AOJu0YzjMqYDBruwQxMdNzVLpcT95kx2tQfyrnmQxzlXLYuoMGAcdIGj
	qkGT2kehNvxMx/7mETxwGLt/cMDX1EakpZ15u6r68UXmOVl7fS4gelSHFGb9WcraRUuc+Sr3ycb
	2hl4BptB5TkYg+IDpXbjRNjhYK1hwf8I=
X-Gm-Gg: AY/fxX64Oz6hE0kcArQ7ANMntg656O3wVvNicdeiOXeWxOlTS30ZDFdv9KUD1TaJ296
	BVvN0OVqIy1Zm7QSCFpB6DOHh0FvUPECBG7XRR2tM9eTyhtnFjynG7cgw+FP8k//BtoP55jt1oN
	XNJTmuVymIM9PEVgbcjQUi4/8cwqt0zVjol+AOIGYs78vayaljbA6+fZjK4tdWqSiM9Sqjqm3mZ
	oT/AjJB8FUJnjl1fSy0WPRAXsCqp4AZnXprzTgbtYxfSTqyCWLvTpZGzI/2KfqbdYX7WDYA7cTx
	gMNpoppJoIg=
X-Received: by 2002:a17:903:1ca:b0:295:ceaf:8d76 with SMTP id
 d9443c01a7336-2a71893cf55mr43059635ad.47.1768602609202; Fri, 16 Jan 2026
 14:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260112145616.44195-1-leon.hwang@linux.dev> <20260112145616.44195-5-leon.hwang@linux.dev>
 <CAEf4BzZbcA2T8+OR1_68sxq9Chukmh8beyz+018O22U=SsafrA@mail.gmail.com> <36cf80a8-a224-4191-b235-50c2b3dd73f6@linux.dev>
In-Reply-To: <36cf80a8-a224-4191-b235-50c2b3dd73f6@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 16 Jan 2026 14:29:56 -0800
X-Gm-Features: AZwV_QhREjZrlt_T4TPev8twBuNbBw-Dl_zIzGq4NZXpJRupKLBBg3imviOODsA
Message-ID: <CAEf4BzZboCfG_DTnJkdi8+VSV14fm==w4kh9zacmyqjHMtm=DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/9] bpf: Add syscall common attributes
 support for prog_load
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>, 
	Andrey Albershteyn <aalbersh@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	Jason Xing <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>, 
	Mykyta Yatsenko <yatsenko@meta.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Rong Tao <rongtao@cestc.cn>, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 6:10=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
>
>
> On 2026/1/16 08:54, Andrii Nakryiko wrote:
> > On Mon, Jan 12, 2026 at 6:59=E2=80=AFAM Leon Hwang <leon.hwang@linux.de=
v> wrote:
> >>
> >> The log buffer of common attributes would be confusing with the one in
> >> 'union bpf_attr' for BPF_PROG_LOAD.
> >>
> >> In order to clarify the usage of these two log buffers, they both can =
be
> >> used for logging if:
> >>
> >> * They are same, including 'log_buf', 'log_level' and 'log_size'.
> >> * One of them is missing, then another one will be used for logging.
> >>
> >> If they both have 'log_buf' but they are not same totally, return -EUS=
ERS.
> >
> > why use this special error code that we don't seem to use in BPF
> > subsystem at all? What's wrong with -EINVAL. This shouldn't be an easy
> > mistake to do, tbh.
> >
>
> -EUSERS was suggested by Alexei.
>
> However, I agree with you that it is better to use -EINVAL here.

I don't know what the context was, if you can find it that would be
great. Maybe special error makes sense for what Alexei had in mind.

>
> >>
> >> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> >> ---
> >>  include/linux/bpf_verifier.h |  4 +++-
> >>  kernel/bpf/log.c             | 29 ++++++++++++++++++++++++++---
> >>  kernel/bpf/syscall.c         |  9 ++++++---
> >>  3 files changed, 35 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index 4c9632c40059..da2d37ca60e7 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -637,9 +637,11 @@ struct bpf_log_attr {
> >>         u32 log_level;
> >>         struct bpf_attrs *attrs;
> >>         u32 offsetof_log_true_size;
> >> +       struct bpf_attrs *attrs_common;
> >>  };
> >>
> >> -int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct=
 bpf_attrs *attrs);
> >> +int bpf_prog_load_log_attr_init(struct bpf_log_attr *log_attr, struct=
 bpf_attrs *attrs,
> >> +                               struct bpf_attrs *attrs_common);
> >>  int bpf_log_attr_finalize(struct bpf_log_attr *log_attr, struct bpf_v=
erifier_log *log);
> >>
> >>  #define BPF_MAX_SUBPROGS 256
> >> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> >> index 457b724c4176..eba60a13e244 100644
> >> --- a/kernel/bpf/log.c
> >> +++ b/kernel/bpf/log.c
> >> @@ -865,23 +865,41 @@ void print_insn_state(struct bpf_verifier_env *e=
nv, const struct bpf_verifier_st
> >>  }
> >>
> >>  static int bpf_log_attr_init(struct bpf_log_attr *log_attr, struct bp=
f_attrs *attrs, u64 log_buf,
> >> -                            u32 log_size, u32 log_level, int offsetof=
_log_true_size)
> >> +                            u32 log_size, u32 log_level, int offsetof=
_log_true_size,
> >> +                            struct bpf_attrs *attrs_common)
> >>  {
> >> +       const struct bpf_common_attr *common_attr =3D attrs_common ? a=
ttrs_common->attr : NULL;
> >> +
> >
> > There is something to be said about naming choices here :) it's easy
> > to get lost in attrs_common being actually bpf_attrs, which contains
> > attr field, which is actually of bpf_common_attr type... It's a bit
> > disorienting. :)
> >
>
> I see your point about the naming being confusing.
>
> The original intent of 'struct bpf_attrs' was to provide a shared
> wrapper for both 'union bpf_attr' and 'struct bpf_common_attr'. However,
> I agree that using 'attrs_common' here makes the layering harder to follo=
w.
>
> If that approach is undesirable, how about introducing a dedicated
> structure instead, e.g.:
>
> struct bpf_common_attrs {
>         const struct bpf_common_attr *attr;
>         bpfptr_t uattr;
>         u32 size;
> };
>
> This should make the ownership and intent clearer.

I don't know and it's not that important, as it's pretty content. But
I'd just try to shorten some names, maybe just "common" for internal
helpers would make sense. common->log_buf, seems to work.

>
> Thanks,
> Leon
>
> [...]
>

