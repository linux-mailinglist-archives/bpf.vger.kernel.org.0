Return-Path: <bpf+bounces-77271-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 20494CD43C2
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 19:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1CAA23001612
	for <lists+bpf@lfdr.de>; Sun, 21 Dec 2025 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB901304BB3;
	Sun, 21 Dec 2025 18:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3oFNKHp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9A817A30A
	for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766341048; cv=none; b=jW1VxlimlAaDHlVNEE+izqXk62KIfJqiBiWDObLwKQpzS+NUbfeQEi7/dbQNsOGJ0sDwHH7AX1PwBgSqyY5h3sd5B8PPmRTTPbV1qnR3sKEXjX2bOgn+mTp6t4LDUzrFeDXI0FVRZI6vNvmtBp2Nv+TqLvnQ44TUAZ1o6AUKTxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766341048; c=relaxed/simple;
	bh=uHRfbitN7sQkFHaxmgdiNxAyrck3DPOn6qnRCpV3KOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiZUUOGluaK3MX2t/esI0Reuqn2zpUraaekAC+smSI/MOC37hP21LplDTaN97K5saT1z8XrUof8Aa/o76NySepvVbn4OtVSKEn7IyoatU1fsLPvLo+tz7cHZgXWhhiQb2cGI2qrqBKBQ9DiCQfb0+OyerQ+d3qfFY6FGMzSxpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3oFNKHp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4775895d69cso13635595e9.0
        for <bpf@vger.kernel.org>; Sun, 21 Dec 2025 10:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766341044; x=1766945844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wybj2InSTMZw+DWETHA9CYe6yiXqA72n4l3D7u5Rn4U=;
        b=j3oFNKHpUkbGyV7oKm9fCOK9MLEioYunW/DQgIVhfEbiNdYFQeAcxgt61khw0GX4pT
         5VO+z3Ro1hyaDRGemXqOKHyndZ2+UFaDREEoAI+bcg0ZGxZHETqBCKd2hWEvyaPpO4DC
         ShE/9FKGDUzDa8hpEJRtxWVXp8gwlrkg6hKRH/l4QgWA7uuqXvsbZzrZoRpgOqvfq7HX
         QHBGdQQix0rOCS+gYBDyuIyFVH6kX2J0teDH9h8CyBalO738zT/hFNq7Q3XLYKvZh02g
         LVmlgmHt6e8klH1alj0aV26/qy7xLyT3LTkBJVsnMuR/hQ8YciH6gG6p1HH2T1jugHqU
         XTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766341044; x=1766945844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Wybj2InSTMZw+DWETHA9CYe6yiXqA72n4l3D7u5Rn4U=;
        b=e68cswHDNIq+LtzIlYGAY+P1XGZrZyQBH6Vonf4DWzEu/ZraiCiK/FN2QUJGQhmv1B
         5yQOjf1I0Cw+P0eQ6x6UI0nq7VPyeC7b6T1BQehgvK0vqgt6Bp0n3n9/y++AuThqno1i
         y3fQYLnBIyHKd+FcHVi2h1/Z+EhrFG7Y3xJ64hSkKsUicY827ZlHwKERoszhXi0k2Xxf
         3B9pGa1emCLKV3bu0a0CHPqgHQaFCNj+z22swXa1F7r1kaUBzIqIErnddOAvWpsAdBMf
         n2huoGp5ITWZzZgXGl6CvCd8o5Jy9voTrbfGEiJ71mBV4E4gtYlF2wrM6V5m/bSFcecC
         4KPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPkPAbw9oQQLgtuYyVxoLiutra10oICS1d3XRyWi1j3ZpuP1pCZeBkMRIvHLucKYWfkBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXiK7YbJWmky/MgdstHjbsdVB+AnMbPqdW/tVninC4qWJe3QC
	OB+zVcq+jFq+rR69Oj1HMio1S+jrXmPPiDrYxPOak+3VarpmtxhrCdECZGjmYfTWwhdPbB047VL
	HhbocvE3PD8lhfmg1Cm28mbhW3CGXfMY=
X-Gm-Gg: AY/fxX6gbemUkr2sjAzaZNNBPOx1B1kpeqsDhN1C2pvFMqLz++hz/MOs75RebyvBxF6
	eZKS1pHoxpRxWpdWKXD7Z4/Fn0qwArfTPjgDG4iTsUvzIYklr5pwO/8hTFWgFXqcdQbn5cwWe8p
	1Cr2AUYuh6PFTPDZWcmh4FuMSav2Nbkd+rm8GWIyvJFldRmU8PYw7W1IZKvDzdbhcFWyTdMUVPG
	xSUTI0uOqcjHLIakf3fBj5rYv4aneU2Ys66L4Q/oiaFdUc1qPUGvQyywf/hEvGFwUeI5iPVAYQz
	B55xLpk=
X-Google-Smtp-Source: AGHT+IEWxYtN8bhMen+3R1R+PcYh/0HpDpBpZsXdNVj0Qpz5ExzAeNU0BU+cwPXz7lZEg0lgbogSfei2Gp8m9xD1JRM=
X-Received: by 2002:a05:6000:24c9:b0:430:fc63:8d3 with SMTP id
 ffacd0b85a97d-4324e4fe005mr8657076f8f.30.1766341043663; Sun, 21 Dec 2025
 10:17:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251220181838.63242-1-mhi@mailbox.org> <20251220181838.63242-3-mhi@mailbox.org>
In-Reply-To: <20251220181838.63242-3-mhi@mailbox.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 21 Dec 2025 10:17:12 -0800
X-Gm-Features: AQt7F2p21hbACZO-a8vTUQw8teBVXAYtcRJmUxymX_zCYAqeTsyxwEAd5nA6uwA
Message-ID: <CAADnVQK6D94P9Gz6SMYTijGea2dLdBQ1AinU6N5-VWoEGEDUvA@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] kallsyms: Always initialize modbuildid on bpf address
To: Maurice Hieronymus <mhi@mailbox.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	georges.aureau@hpe.com, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 20, 2025 at 8:19=E2=80=AFAM Maurice Hieronymus <mhi@mailbox.org=
> wrote:
>
> modbuildid is never set when kallsyms_lookup_buildid is returning via
> successful bpf_address_lookup.
>
> This leads to an uninitialized pointer dereference on x86 when
> CONFIG_STACKTRACE_BUILD_ID=3Dy inside __sprint_symbol.
>
> Prevent this by always initializing modbuildid.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220717
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
> ---
>  include/linux/filter.h | 6 ++++--
>  kernel/kallsyms.c      | 2 +-
>  2 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index fd54fed8f95f..eb1d1c876503 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1384,12 +1384,14 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long=
 addr);
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname, const unsigned cha=
r **modbuildid, char *sym)
>  {
>         int ret =3D __bpf_address_lookup(addr, size, off, sym);
>
>         if (ret && modname)
>                 *modname =3D NULL;
> +       if (ret && modbuildid)
> +               *modbuildid =3D NULL;
>         return ret;
>  }
>
> @@ -1455,7 +1457,7 @@ static inline struct bpf_prog *bpf_prog_ksym_find(u=
nsigned long addr)
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname, const unsigned cha=
r **modbuildid, char *sym)

No.
Please search the earlier threads where this was discussed.
The patches to fix this were posted and I think they landed
in some tree already.

pw-bot: cr

