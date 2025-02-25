Return-Path: <bpf+bounces-52541-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D84BDA44733
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 18:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D84A189738F
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 17:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7018DB10;
	Tue, 25 Feb 2025 17:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xmiizzf/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03960154449;
	Tue, 25 Feb 2025 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502922; cv=none; b=pk2qhI2jBqKnE0va9r7STOXfVVastbhRHr4BLb0J6YUkhCKkelemHDG7p/G77mDHNk/z3mDK/whqvzCMzy/a4YVOW6mE90vGqAZjZAIqa9X71ll60T5Ds9BJL2Xy3uwwlXE8Ixl/V6xCk820ghu5Gt6xcW+uawKb3AztJOSz4lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502922; c=relaxed/simple;
	bh=1XKPLKXieZqVO6U2+kaiBJjTQv8Cc4ryBlaA1fZmkRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzeem4C50zrgtqYU+XLyaz9bqkpC4EFjSgcasK9hTlW9/leXzhjdeWzzUbvm3H4J7uEm3HJjeCSzPmIgxhQbVT8gK808IhgTUpxAeRCaHDXZIHvPWRsbBuZZTQlhL3lgCf6O3keIE4w5eeGHu77/tRvZxPGNBnz+voPntLzr5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xmiizzf/; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2fcc99efe9bso9118247a91.2;
        Tue, 25 Feb 2025 09:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740502920; x=1741107720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRHXRyZ3W2PAcFwsCJB47bwsyJQ62xezF8ymu4F7sao=;
        b=Xmiizzf/Mkadp8R2E1skOZUHvB7ELVN6B7ISDfwnvqIaOUZGFB8j+RlVzDNOMhgMfB
         1GK3e/w7vYjP1m+X2/B/jzC8PLjD0pxkHJSkYT/zU4BTz3ucSZD3IGNZvd2sXiLabjXC
         xqc8pC4ItDDB2sgT0AcGP9qsN6il+YBj4xpoUp3/h8ptAGWDZqkyheO4m7hQ1CcnJ+LS
         D6xfhHqyi0MmK9fqj7zm5hB6GUmQE0H9nDuEqJt7GosgJjLx6HdWx8oSMnmuTVkyhymk
         2uGFJqnBs99M2CCYVe3pfyxW9qbz/zJvGiezIGxIH0W92svlR6ioMC1VD2I5CjRoPKaD
         yL6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502920; x=1741107720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRHXRyZ3W2PAcFwsCJB47bwsyJQ62xezF8ymu4F7sao=;
        b=qUlvseAZWpAzw87gwcAKemaTqSmYhy9FbpY7TbfsMqUL+DuPL+y9/jAJEmTVWzqep+
         woidWytL8O7oH67PkkZiptUaSJuBVVmrYOYfnluJQSEx+/WTLc+BcN8w/9G0vlB7LC6J
         a5gUXzindEEBizJqCSIAQ8QK84bn4NsZI7epF2JVyb+0V+XXKqTRISmEyHoVuogdv3rJ
         ks+evT219xzJEcqhjsuimDSil+kn7db7s8xqCgnFLoSA8X8+LfFHfR2IV0qG7x8w/BB+
         2sHlGqgMtKiyleFYXTByVWF+rb2Hcy1GOVIKUK5CJ9bhy/J/azuU65lxGJSeRv6uCdjx
         nwWg==
X-Forwarded-Encrypted: i=1; AJvYcCW67KwcpQnFzYJadmVmIIbWW+eh1NHeDYntrQhM7Ug6Hw77ju3W/bE1MtUKJZFl47hzFSI=@vger.kernel.org, AJvYcCWK7NAvpFj26eIwslcMGwC2gfF3n6yStUm7Nqd+ycovTxw2swJ+2jbTVAuRCNHJUjmSS+2NT7/LpxHpO5ws@vger.kernel.org
X-Gm-Message-State: AOJu0YzypuzNNi14dqyFqVWw6ywMHplczbzpfDKof4JpgGdiCdPNWJgq
	tdmLBUtUSrZOrZcHzCkAtOgIjMwAZdiShfkVOZ0J0t+EsLLd4z76BsR+wlkNhqB81O41vA+hAab
	e5p0XGspoRjPsAVcQYq76BajwtKo=
X-Gm-Gg: ASbGnctigPvZhADFzv/JvBsyCQ37t+UyTCPwDxxj5t47a7lrUygH3WscrrUtWKMt2V/
	84t4w4/KqjP4puG2S6pV5AM7FtZfIgs+oQU78nKlYSfY6GuIv49t/1hbDjk4u7iVOznJhXN14X7
	vhPTwc3CyEbyPQa1qPtItam5g=
X-Google-Smtp-Source: AGHT+IGuKUU80V7/RqdSWiD1gVldkH+8Q41Ea7DXCHadDImi2rnlHnzU9m8HZdmqyjWrsElFRb+79VS5qgDJJF9t890=
X-Received: by 2002:a17:90b:3e8a:b0:2f1:4715:5987 with SMTP id
 98e67ed59e1d1-2fce86ae503mr31188653a91.9.1740502920194; Tue, 25 Feb 2025
 09:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224165912.599068-1-chen.dylane@linux.dev>
 <20250224165912.599068-4-chen.dylane@linux.dev> <CAEf4BzYr9WzYbmyq8=nVETDqYvmYmObhD6x+_TQYpSUWxxGLLg@mail.gmail.com>
 <edec731d-3370-46b8-baad-b8bf181bcce3@linux.dev>
In-Reply-To: <edec731d-3370-46b8-baad-b8bf181bcce3@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 25 Feb 2025 09:01:48 -0800
X-Gm-Features: AWEUYZlDayhglWM-oFpbbZoJ5MjHSy8YzMkPUfkQQJOY5jTnB4r_XVM2tRI4PNE
Message-ID: <CAEf4Bzb1Epj9QdSeA02hAypqcbu3a_Nx9Gvj_o-RjukeNrWWeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 3/5] libbpf: Add libbpf_probe_bpf_kfunc API
To: Tao Chen <chen.dylane@linux.dev>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chen.dylane@gmail.com, 
	Tao Chen <dylane.chen@didiglobal.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 9:47=E2=80=AFPM Tao Chen <chen.dylane@linux.dev> wr=
ote:
>
> =E5=9C=A8 2025/2/25 09:15, Andrii Nakryiko =E5=86=99=E9=81=93:
> > On Mon, Feb 24, 2025 at 9:02=E2=80=AFAM Tao Chen <chen.dylane@linux.dev=
> wrote:
> >>
> >> Similarly to libbpf_probe_bpf_helper, the libbpf_probe_bpf_kfunc
> >> used to test the availability of the different eBPF kfuncs on the
> >> current system.
> >>
> >> Cc: Tao Chen <dylane.chen@didiglobal.com>
> >> Reviewed-by: Jiri Olsa <jolsa@kernel.org>
> >> Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
> >> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> >> ---
> >>   tools/lib/bpf/libbpf.h        | 19 ++++++++++++-
> >>   tools/lib/bpf/libbpf.map      |  1 +
> >>   tools/lib/bpf/libbpf_probes.c | 51 +++++++++++++++++++++++++++++++++=
++
> >>   3 files changed, 70 insertions(+), 1 deletion(-)
> >>
> >
> > [...]
> >
> >> +       buf[0] =3D '\0';
> >> +       ret =3D probe_prog_load(prog_type, insns, insn_cnt, btf_fd >=
=3D 0 ? fd_array : NULL,
> >> +                             buf, sizeof(buf));
> >> +       if (ret < 0)
> >> +               return libbpf_err(ret);
> >> +
> >> +       if (ret > 0)
> >> +               return 1; /* assume supported */
> >> +
> >> +       /* If BPF verifier recognizes BPF kfunc but it's not supported=
 for
> >> +        * given BPF program type, it will emit "calling kernel functi=
on
> >> +        * <name> is not allowed". If the kfunc id is invalid,
> >> +        * it will emit "kernel btf_id <id> is not a function". If BTF=
 fd
> >> +        * invalid in module BTF, it will emit "invalid module BTF fd =
specified" or
> >> +        * "negative offset disallowed for kernel module function call=
". If
> >> +        * kfunc prog not dev buound, it will emit "metadata kfuncs re=
quire
> >> +        * device-bound program".
> >> +        */
> >> +       if (strstr(buf, "not allowed") || strstr(buf, "not a function"=
) ||
> >> +          strstr(buf, "invalid module BTF fd") ||
> >
> > why is invalid module BTF FD not an error (negative return)?
> >
> >> +          strstr(buf, "negative offset disallowed") ||
> >> +          strstr(buf, "device-bound program"))
> >> +               return 0;
> >> +
> >> +       return 1;
> >> +}
> >> +
> >>   int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_f=
unc_id helper_id,
> >>                              const void *opts)
> >>   {
> >> --
> >> 2.43.0
> >>
>
> In probe_prog_load, err will be checked and converted into either 0 or 1.

I guess what I was getting at is that providing invalid module BTF FD
is not a "not supported" case, it's an error case (and so should
result in negative return)

>
> --
> Best Regards
> Tao Chen

