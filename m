Return-Path: <bpf+bounces-49300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D874A17265
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 18:50:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBA81161460
	for <lists+bpf@lfdr.de>; Mon, 20 Jan 2025 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3F51EBFF5;
	Mon, 20 Jan 2025 17:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oheu+hJq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AD7C2FB
	for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 17:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395415; cv=none; b=dYSyQTHiGkKPfWZktfmhoRQGw83u4gP8X1x9CU2JqwDxJBlZzpRhzhoNihM2CPbyvj46a/GeboAl0Yg19NxYkU/7s0wroCpjEU1NDFUvsFzYDdOFfqQTOCWcjMHgXHKSI18/Gnf/cKJ/Ko/YXqWbTtBCbJiVfe+a2KVbikhkaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395415; c=relaxed/simple;
	bh=0GVGRpRpEGqCen6v+UgdQcz7Sabz0vyLHAJXmgew5tI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cUGwZf7WhVRiHdnZTNffU6mrVV5TQ0Y6SvfQaJ7AhIbXZOYvhEdmDUsxGZ4o5B+JBDlaqpaXngrMhh/vVUyleiPICCjZVvahmIzid3MruMv5KS82ceznVJrY4e3hDm6BPjPkToB0Cpv9b0OIyDZus6cEK5qjijere/dKb6KlsrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oheu+hJq; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863494591bso2570763f8f.1
        for <bpf@vger.kernel.org>; Mon, 20 Jan 2025 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737395411; x=1738000211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1gI+/6/JL4iRGOWNCgoURmj7yUgso4gs9wByUbK154=;
        b=Oheu+hJqtUhDuyRS1bUvcM649TZfQIV37+s2CzazzXaI9yDFQQqyaAdK2iGwUkYEE6
         jZcQ60TvF6V8deZnzF4ZS0U2pVSnnnLcO0cFX/Kxl90Et5yRwBQbxssRWqkpLrbCeJIy
         86GIBjwIFSVcCugpZJ6q3aN8DAj5OkT/f82qulBvczuXeWA6XH9+Ozs5rU/upfb4jr2x
         xiz97kr1xkyqJzM/yI2Ow/oOMJQtvfCUN8aKg3hldwXoa+KR51jRfWcTdM4cr2Lj4mr6
         C04Mez2Wgc5Xk/lrXCwaBjE6OU/SAP80DJx9NKHeSSCOktEjlHjMsEnFH7wHbARB91qX
         O1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737395411; x=1738000211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1gI+/6/JL4iRGOWNCgoURmj7yUgso4gs9wByUbK154=;
        b=jwQ6C+u7uXu/igvLsAIWymbQCrpIOgd+xyJIdO9VpHopYEB2bTYBCfqsXDiytRumwH
         9RjS2u0QvhJeue2EKopDFxKCKnISJ4lmZYajbgyNb+LTFtcMdBCCA3E1ITlvoZqDLSga
         6knMOk4Muzkn3xb7Fe/1/CYc/OsQZFd2+FCvhkH/9rP20ENvE4jDvgp2r8fXM1a/+5ES
         yD7j0bJTzgctGdQDx4UFLpGZ/rXASLsKQV7gEsnbbbEdSusjEDYUW0Z0IERJdniZHQEA
         TXyGlGfG8OW+1o2wIfB0rMlupcXAOcmR8ACI6v1O1WtqdoPCwz7XVDREsCryd55tDhnj
         MFqA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkJiALYADi/RoxYO4uUkf/AuF9QFBxCs66mG4/zltPYLxlv+8KukbUhNPPZpb/yEYH44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9gYixfxyMxkDTWXYmCPepP/0j0vcYTcSQuyyMt/B8Aq+ZIwk
	eCS4pLnP4Jafij86/T2n/yPh4nVt7rq4NATY4GxJWb20waNLqo88oc91dhcO4s0pej+P6pwd+PU
	cj3CzRPJ+PcDTWCkR/tYGdiD3b+0=
X-Gm-Gg: ASbGncvGoM9mPsdIXZ3f6qzmDdI5d+IlASv0K7o0CgoYpMJbCAvAVo1qo1XH0c/3tyP
	Gj5ngXDggRgFHQ0nbJ4QJj/8uCYqSWoQvaxKiiBwkf6AnQFSAC//Z+f9CWVMpuA7hedc=
X-Google-Smtp-Source: AGHT+IF8GcumNRiYNSyxAsi2OWBrFQjbMjOYYG+FeCxM8wviyL248Wu0c0cs44Jf8Nk8m4QXMS7XZPiB5B0KcSFJ18A=
X-Received: by 2002:a5d:5848:0:b0:38b:dbf0:34f2 with SMTP id
 ffacd0b85a97d-38bf59f03c7mr13486945f8f.52.1737395411286; Mon, 20 Jan 2025
 09:50:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250118192019.2123689-1-yonghong.song@linux.dev>
 <20250118192029.2124584-1-yonghong.song@linux.dev> <0056055b-338a-49f1-b6bf-fa11440cb959@iogearbox.net>
In-Reply-To: <0056055b-338a-49f1-b6bf-fa11440cb959@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 20 Jan 2025 09:49:58 -0800
X-Gm-Features: AbW1kvZmFEzIfzEaZr290OKBHtb_fz2KTdldy3nz3zcDlAc80OEct-2f8S_wVGo
Message-ID: <CAADnVQLsxF22fs5yE7t4=wR=oygDWSsS+NEasZ3Ps8QzWP0Hbw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Remove 'may_goto 0' instruction in opt_remove_nops()
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 20, 2025 at 7:29=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 1/18/25 8:20 PM, Yonghong Song wrote:
> > Since 'may_goto 0' insns are actually no-op, let us remove them.
> > Otherwise, verifier will generate code like
> >     /* r10 - 8 stores the implicit loop count */
> >     r11 =3D *(u64 *)(r10 -8)
> >     if r11 =3D=3D 0x0 goto pc+2
> >     r11 -=3D 1
> >     *(u64 *)(r10 -8) =3D r11
> >
> > which is the pure overhead.
> >
> > The following code patterns (from the previous commit) are also
> > handled:
> >     may_goto 2
> >     may_goto 1
> >     may_goto 0
> >
> > With this commit, the above three 'may_goto' insns are all
> > eliminated.
> >
> > Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >   kernel/bpf/verifier.c | 9 +++++++--
> >   1 file changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 963dfda81c06..784547aa40a8 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -20187,20 +20187,25 @@ static const struct bpf_insn NOP =3D BPF_JMP_=
IMM(BPF_JA, 0, 0, 0);
> >
> >   static int opt_remove_nops(struct bpf_verifier_env *env)
> >   {
> > +     const struct bpf_insn may_goto_0 =3D BPF_RAW_INSN(BPF_JMP | BPF_J=
COND, 0, 0, 0, 0);
> >       const struct bpf_insn ja =3D NOP;
> >       struct bpf_insn *insn =3D env->prog->insnsi;
> >       int insn_cnt =3D env->prog->len;
> > +     bool is_may_goto_0, is_ja;
> >       int i, err;
> >
> >       for (i =3D 0; i < insn_cnt; i++) {
> > -             if (memcmp(&insn[i], &ja, sizeof(ja)))
> > +             is_may_goto_0 =3D !memcmp(&insn[i], &may_goto_0, sizeof(m=
ay_goto_0));
> > +             is_ja =3D !memcmp(&insn[i], &ja, sizeof(ja));
> > +
> > +             if (!is_may_goto_0 && !is_ja)
> >                       continue;
>
> Why the extra may_goto_0 stack var?
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 245f1f3f1aec..16ba26295ec7 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -20185,16 +20185,19 @@ static int opt_remove_dead_code(struct bpf_veri=
fier_env *env)
>   }
>
>   static const struct bpf_insn NOP =3D BPF_JMP_IMM(BPF_JA, 0, 0, 0);
> +static const struct bpf_insn MAY_GOTO_0 =3D BPF_RAW_INSN(BPF_JMP | BPF_J=
COND, 0, 0, 0, 0);
>
>   static int opt_remove_nops(struct bpf_verifier_env *env)
>   {
> -       const struct bpf_insn ja =3D NOP;
>          struct bpf_insn *insn =3D env->prog->insnsi;
>          int insn_cnt =3D env->prog->len;
> +       bool is_ja, is_may_goto_0;
>          int i, err;
>
>          for (i =3D 0; i < insn_cnt; i++) {
> -               if (memcmp(&insn[i], &ja, sizeof(ja)))
> +               is_may_goto_0 =3D !memcmp(&insn[i], &MAY_GOTO_0, sizeof(M=
AY_GOTO_0));
> +               is_ja         =3D !memcmp(&insn[i], &NOP, sizeof(NOP));
> +               if (!is_may_goto_0 && !is_ja)
>                          continue;
>
> >               err =3D verifier_remove_insns(env, i, 1);
> >               if (err)
> >                       return err;
> >               insn_cnt--;
> > -             i--;
> > +             i -=3D (is_may_goto_0 && i > 0) ? 2 : 1;
>
> Maybe add a comment for this logic?

Adjusted both while applying.
Thanks!

