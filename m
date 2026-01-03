Return-Path: <bpf+bounces-77730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC248CEFAAF
	for <lists+bpf@lfdr.de>; Sat, 03 Jan 2026 05:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC555301587E
	for <lists+bpf@lfdr.de>; Sat,  3 Jan 2026 04:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E9421FF4D;
	Sat,  3 Jan 2026 04:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFYehaCi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693AD3A1E8B
	for <bpf@vger.kernel.org>; Sat,  3 Jan 2026 04:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767415274; cv=none; b=oL0kymR6S6bj5Gnk8bu4/I2QpIHZHQrwk7Zl2TQitpNi6UCt1AuxQ2eu7oRgwOSZg5QBgoSKb+TK/50jTixT9ht8cQ6UrJ4mlfHdx48T+yFgRDJ2x7YEI3bMeyRI//fqWr7WKrII+JZ0E/vl9tfCTcHk0CcesEf+B4nHP52fzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767415274; c=relaxed/simple;
	bh=0+LkSwSLxMfBSS6LmX+QdOh//xZ3eXwArE503ClxAC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXOQkqx4D7tw6BD1G+x+gGtp2xd2KOmoifBN4qafLHo2UHS5ZPHy2Pdtux0OesYQCcwB0OalMLMgeeP7sGuRk/3H36soCcpGh6Rx/lODWwKU3CVOpD1WGpH1RquFRf13bK5MhCcZLA0nvHuSyXvUO1O6vKeCAtJiIBYSq6ULB8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFYehaCi; arc=none smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-6466d8fd383so10038964d50.2
        for <bpf@vger.kernel.org>; Fri, 02 Jan 2026 20:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767415271; x=1768020071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u55nSpyWrrztdfEQVGRs1g73yYdmmd3y+S7959wC3Qw=;
        b=cFYehaCidioPmVUyVu+ysDON15flE+lJw5MzbWaxoqiyIUsyE0S316kBWfAxfONy0N
         2w5G3gG/R2+BbZhqkow7orlzcbWs366zOYMwsPNwblaKwAzVrAyaRumrdHrCuFtJSOrS
         HizLEvo8HAuXa0AVRn7YX0AjcMZMNLjjiOTUdvVe9zF9zFoYaPNfJRv6NW7Qq1bfaWcb
         T5LMe8AFy9EzveHnTaso7PQrnH8HcLmjU0/UYkaacL4mUFG7g5JlU1FZQhJ8Dt7E+fBI
         f8slCKCk6Om2LldGWuXqNf6arBqnJNgpcOcTx82ulFHmxVPuCDCXoxtL0PvfzczMvxUb
         irBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767415271; x=1768020071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u55nSpyWrrztdfEQVGRs1g73yYdmmd3y+S7959wC3Qw=;
        b=oGHyfqZix2lmAmu400t8l+IAismClfruENabpJj9vxrYSi3BceoHlHTtlIEbw81lo9
         Sqn4jKWZHTNoLMerb9QZIiqGH7tZY8UUoz1pV/CBNjyFRmZQQAHywFAByuRHeFch9dAS
         A3oYXLuRhKx4Dhnolgp/vy+YoU5JMMAr0npawR/S7zhaA3pS0QWOdn0o8aTv9NCwQCIk
         9qFa2X/JFs/n+unGiNYPqMjui3R9hBFGeJPvZxV6b/6LVhEqDO4zyiF0ohs8vmYvZmKI
         K4iLIu/6fwfGFcDQ01TKFdt4z9hm+riSbAQtchVCD6CJEpPg6yRThPF9Doktip6ijnNz
         s8Fw==
X-Forwarded-Encrypted: i=1; AJvYcCXqW1roE8RZ+QRJhDpCrQswk8L6jfLS25wmH6wgn77JR+oPmRuOpylzjQ6JAfQylrfv3NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVAm9eFrYrKFMTrOvEMbAPJo9XR0jGUKU2xcPdPWXDaCVPxJgv
	MWuEP53u3GQ+7OAaWGszmnETNRau2IbMXjvaBw00rEshXnrHInEZPn6ooynPQLPaGFOkT44wNtl
	vFt/HmDA5O6Z8+QoO3IMYyw9M25DILL4=
X-Gm-Gg: AY/fxX4UtXHuED4EQKMYYwl8r37xtv+lowtunXZ2FUY9YNIDYIfxDL2hx6lv6O7mwef
	IZDcz2HNQwG/CmB0x6zhhWH0IEeZXR1q/CHQ5dmeKi9YgJyQByzc/bZBjYnMPV6g4KMvWBj55yw
	A23Ajd3mExzpPQDojbGaSgQOcif2Dhj9760X5j5Yn3DRw5d1O/2yupKi5k2J6ZgPPhqsd98ADFd
	Y9MfkoCz4TeEHVzkq0ie8s3Z//7/OmDxz6EvNRJoyzPsrWyUDbUQUWmTaWVEDCx153OHok=
X-Google-Smtp-Source: AGHT+IGykmfUKli6phhTxdOxBn5HgeYWHuY3ueRidHGG1DUJpaEk/3LscYz8m56j9vI9mueBy2Wkm88SoZfjLzw18Wk=
X-Received: by 2002:a05:690e:bce:b0:644:7b59:4219 with SMTP id
 956f58d0204a3-6466a87ecc6mr32492107d50.10.1767415271290; Fri, 02 Jan 2026
 20:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251224130735.201422-1-dongml2@chinatelecom.cn> <CAADnVQJRXWtt3MY+Z+mZerYjir-735z9_mbLJQF-TyUL9pFt5g@mail.gmail.com>
In-Reply-To: <CAADnVQJRXWtt3MY+Z+mZerYjir-735z9_mbLJQF-TyUL9pFt5g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 3 Jan 2026 12:41:00 +0800
X-Gm-Features: AQt7F2olmvAh-RSX3Ph-HRL35i6uoxOqGSgbb7YMhYeBqMxy_u8ecmMmivLfQqs
Message-ID: <CADxym3Ztg28LwFsZ8K_RSmBxHuzwKcL8Q339WDoid8H95QwJGA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 00/10] bpf: fsession support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 7:21=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Dec 24, 2025 at 5:07=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Hi, all.
> >
> > In this version, I did some modifications according to Andrii's
> > suggestion.
> >
> > overall
> > -------
> > Sometimes, we need to hook both the entry and exit of a function with
> > TRACING. Therefore, we need define a FENTRY and a FEXIT for the target
> > function, which is not convenient.
> >
> > Therefore, we add a tracing session support for TRACING. Generally
> > speaking, it's similar to kprobe session, which can hook both the entry
> > and exit of a function with a single BPF program.
> >
> > We allow the usage of bpf_get_func_ret() to get the return value in the
> > fentry of the tracing session, as it will always get "0", which is safe
> > enough and is OK.
> >
> > Session cookie is also supported with the kfunc bpf_fsession_cookie().
> > In order to limit the stack usage, we limit the maximum number of cooki=
es
> > to 4.
> >
> > kfunc design
> > ------------
> > The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are
> > introduced, and they are both inlined in the verifier.
> >
> > In current solution, we can't reuse the existing bpf_session_cookie() a=
nd
> > bpf_session_is_return(), as their prototype is different from
> > bpf_fsession_is_return() and bpf_fsession_cookie(). In
> > bpf_fsession_cookie(), we need the function argument "void *ctx" to get
> > the cookie. However, the prototype of bpf_session_cookie() is "void".
> >
> > Maybe it's possible to reuse the existing bpf_session_cookie() and
> > bpf_session_is_return(). First, we move the nr_regs from stack to struc=
t
> > bpf_tramp_run_ctx, as Andrii suggested before. Then, we define the sess=
ion
> > cookies as flexible array in bpf_tramp_run_ctx like this:
> >     struct bpf_tramp_run_ctx {
> >         struct bpf_run_ctx run_ctx;
> >         u64 bpf_cookie;
> >         struct bpf_run_ctx *saved_run_ctx;
> >         u64 func_meta; /* nr_args, cookie_index, etc */
> >         u64 fsession_cookies[];
> >     };
> >
> > The problem of this approach is that we can't inlined the bpf helper
> > anymore, such as get_func_arg, get_func_ret, get_func_arg_cnt, etc, as
> > we can't use the "current" in BPF assembly.
> >
> > So maybe it's better to use the new kfunc for now? And I'm analyzing th=
at
> > if it is possible to inline "current" in verifier. Maybe we can convert=
 to
> > the solution above if it success.
>
> I suspect your separate patch set to inline get_current addresses
>  this concern?

Yeah. I'm hesitating if we should do it this way. I found that
even though we can inline the "current", which can be done by
using the "call bpf_get_current_task" in verifier, it's still hard to inlin=
e
the following function:

__bpf_kfunc void *bpf_fsession_cookie(void)
{
    ......
    return run_ctx->fsession_cookies[run_ctx->func_meta >> BPF_TRAMP_M_COOK=
IE];
}

We can only use the r0 register during the inline, and we
need at least another one register to finish the logic above. Do we
have a temporary register that can be used here?

I'm not sure if the effort is worth it, so I think maybe it's better
to keep the current approach. As for the inline of get_current,
it's an optimization that we can do anyway.

>
> > architecture
> > ------------
> > The fsession stuff is arch related, so the -EOPNOTSUPP will be returned=
 if
> > it is not supported yet by the arch. In this series, we only support
> > x86_64. And later, other arch will be implemented.
> >
> > Changes since v4:
>
> v5 looks to be in good shape. It needs a rebase now due to conflicts.

OK, I'll rebase and send it later.

Thanks!
Menglong Dong

