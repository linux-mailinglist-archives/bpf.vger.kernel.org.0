Return-Path: <bpf+bounces-55563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C600A82E7D
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 20:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B107C886359
	for <lists+bpf@lfdr.de>; Wed,  9 Apr 2025 18:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C382777F4;
	Wed,  9 Apr 2025 18:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip+45C5X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0B276040;
	Wed,  9 Apr 2025 18:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744222791; cv=none; b=q2H/+aqm9Pc6bKjvUdKhUTg/+rz4A6CNXemzavCebLV99ClTKhkuhZUb/7sFGryfzF5GUDUbKnfhYeogt/RAj63y5DFlbin0r+c4y7uPa8gqYGfEH3JL4fwe8d3VCs12GHfbrdKfQDve4+qa98QvAPpqFsceMGgN435ZDFf8rys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744222791; c=relaxed/simple;
	bh=CiUXsDTkyIepg9q0LVYKmGp89q68e5F5CZNEXrM1bQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AiHu/1isR6U0tQj2VY0o8cEu3y9LJOCj7L0TmTO0lG1G/TRJLeLxeEQksMc9CGt6YeccVUbAGVJZy+5DGMAPvc1H5o4Js/sPbjQNwWdVvx4uf74D2LyzX74wOgAAfQsN1yerOnF5+khVmWMuRSazS/mmKYuYCagEmSfb7SRMXgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip+45C5X; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2254e0b4b79so91841025ad.2;
        Wed, 09 Apr 2025 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744222789; x=1744827589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lj2pdvd0SPlmcQ64DOUFkCqLGht2nTzMPaNLIIAOzV0=;
        b=ip+45C5X3hJP1Y15j1v0TA05uHv2z8tCGdPncQXaev2PF4ZwkiQyQbPugX4zZ/gLrB
         A2mMMKG9bdKPd5LL+eRM1OvegSv/Q5c5eW0INzJoGW2OaD2NoVwDBABqgnfiP4HwTDiN
         WFYjuPxxBfFOhwqhsddFu3/gII+AgvrtTHTKGbPdYl3nCZuFSgRbtxHPA2wJkDOX0eLO
         Qa1ROU+mSU3qQ0hIuT6g/zvjhnFrG0NK60Ppugr4gOaJWSHNmwTm37jXW1ZzRWrAqdbA
         k6qJ8nRGDEhUL68nRa9BjoqUFABlWvOnkspJiPIAXr+seVSb0uciix6Pt4HBhEUt7L+v
         h4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744222789; x=1744827589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lj2pdvd0SPlmcQ64DOUFkCqLGht2nTzMPaNLIIAOzV0=;
        b=jooLs3e7dBlODJXl9Aa0zKgBa9N36OrqHkIGIArkfl//Rd+8B6f/ezQ3GNIQZfhzZz
         31n7zpYjx+3tbIU/6T1l2QN+cRnBW9GoDaJzZrxSuOWqlYMKusTXB06TP43tvRF/5nh6
         ru/SHfiGM5b+Hu8QJ0hYJBqxEyigswPZy/EW+MiOyMYTgxc+Z/+5oYJKzd894TRx68zm
         5rU6mWYgh+p3dR0P183H3q4LEwGKTe3T4Qj/3giXhlfh8MfC7TeuqjAAxjrmQrkzQ84X
         gJjxtmvkprVgGbamZShGLCnW/OeLrAPU7mBlEOch8C0tI61rxvQpzhUgUc5Qj6wK8tBT
         hrrw==
X-Forwarded-Encrypted: i=1; AJvYcCU93Xz9lCXMwENNM/p9HtzM4TPa/dR7/IWVZdRbR9OGbqcl4NdXqAlHi2vLmTStN7rSJboIoI+KsCNf4P6Jok1uGDHC@vger.kernel.org, AJvYcCX/YC5Szou2ltADOsCxMvqNgz4kUXxHTtvupBIUj9yXrHT/XbaqVm3ZQH/cmaUPmevtk4M=@vger.kernel.org, AJvYcCXV+hIjphG5flpGvPNBnTt/AwNreVfcHAFM5sciKvGotwcLx6AfENm6xQeRzYLmH3yvR+bHCcpXueRyrIw/@vger.kernel.org
X-Gm-Message-State: AOJu0YwoHlUOGpd+uVtr9tya8JapOyF990o7RUGmQL+r28wl+fwvPvmS
	GdBTvEtfoG+hMJ99Iw1l/RYGt0mfxmZ9Uy2tZPCIsxPodTuvZ4LVgMCzzDI/81pQeMd/gXYMIvX
	gbWSdee9kJZ+d0XJlye4G5h9pkCg=
X-Gm-Gg: ASbGncsS5+osq82V2GAVYZcB8hq8e3L7BXFfF/9eEyzq7VlkHFFMm0CIRFuH/kmBfO2
	O+1AkNzS2OyBJ7mPPD/4cd9bPyCE7f1kuNZfvzqAbJimRHqlYOwvw8lGhRc1T1y2Oq+icK2KTyB
	eoGvono/8HJec/4KnhYF4qx68swhfOinO2CmXzmw==
X-Google-Smtp-Source: AGHT+IFXf3OXjpp1bAbtieu4tH51zXmjNjFzAg0ttv8og4VaLQHya+wB+tZu8pzUjXHO5nrszkIQxdBrBOAN9wFmvtI=
X-Received: by 2002:a17:902:e78f:b0:224:179a:3b8f with SMTP id
 d9443c01a7336-22ac29a97ecmr58322535ad.23.1744222789505; Wed, 09 Apr 2025
 11:19:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320114200.14377-1-jolsa@kernel.org> <20250320114200.14377-11-jolsa@kernel.org>
 <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>
 <Z_Ox7ibkULkJ_2Lx@krava> <Z_WFZT3rZtjts3u-@krava>
In-Reply-To: <Z_WFZT3rZtjts3u-@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 9 Apr 2025 11:19:36 -0700
X-Gm-Features: ATxdqUHS_5Yyi_chN455DBi3vtOfUgKg8FdWzgpPJ84Ricjb7dycy7aYQdQjWsY
Message-ID: <CAEf4BzZRe8qEjd1KjwV9y25QhDwkfTd7mnknLNm2pR7ArnAhMQ@mail.gmail.com>
Subject: Re: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5 instruction
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 1:22=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Mon, Apr 07, 2025 at 01:07:26PM +0200, Jiri Olsa wrote:
> > On Fri, Apr 04, 2025 at 01:33:11PM -0700, Andrii Nakryiko wrote:
> > > On Thu, Mar 20, 2025 at 4:43=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> =
wrote:
> > > >
> > > > Adding support to emulate nop5 as the original uprobe instruction.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
> > > >  1 file changed, 16 insertions(+)
> > > >
> > >
> > > This optimization is independent from the sys_uprobe, right? Maybe
> > > send it as a stand-alone patch and let's land it sooner?
> >
> > ok, will send it separately
> >
> > > Also, how hard would it be to do the same for other nopX instructions=
?
> >
> > will check, might be easy
>
> we can't do all at the moment, nop1-nop8 are fine, but uprobe won't
> attach on nop9/10/11 due unsupported prefix.. I guess insn decode
> would need to be updated first
>
> I'll send the nop5 emulation change, because of above and also I don't
> see practical justification to emulate other nops
>

Well, let me counter this approach: if we had nop5 emulation from the
day one, then we could have just transparently switched USDT libraries
to use nop5 because they would work well both before and after your
sys_uprobe changes. But we cannot, and that WILL cause problems and
headaches to work around that limitation.

See where I'm going with this? I understand the general "don't build
feature unless you have a use case", but in this case it's just a
matter of generality and common sense: we emulate nop1 and nop5, what
reasons do we have to not emulate all the other nops? Within reason,
of course. If it's hard to do some nopX, then it would be hard to
justify without a specific use case. But it doesn't seem so, at least
for nop1-nop8, so why not?

tl;dr, let's add all the nops we can emulate now, in one go, instead
of spoon-feeding this support through the years (with lots of
unnecessary backwards compatibility headaches associated with that
approach).


> jirka
>
>
> ---
> diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> index 9194695662b2..6616cc9866cc 100644
> --- a/arch/x86/kernel/uprobes.c
> +++ b/arch/x86/kernel/uprobes.c
> @@ -608,6 +608,21 @@ static void riprel_post_xol(struct arch_uprobe *aupr=
obe, struct pt_regs *regs)
>                 *sr =3D utask->autask.saved_scratch_register;
>         }
>  }
> +
> +static bool emulate_nop_insn(struct arch_uprobe *auprobe)
> +{
> +       unsigned int i;
> +
> +       /*
> +        * Uprobe is only allowed to be attached on nop1 through nop8. Fu=
rther nop
> +        * instructions have unsupported prefix and uprobe fails to attac=
h on them.
> +        */
> +       for (i =3D 1; i < 9; i++) {
> +               if (!memcmp(&auprobe->insn, x86_nops[i], i))
> +                       return true;
> +       }
> +       return false;
> +}
>  #else /* 32-bit: */
>  /*
>   * No RIP-relative addressing on 32-bit
> @@ -621,6 +636,10 @@ static void riprel_pre_xol(struct arch_uprobe *aupro=
be, struct pt_regs *regs)
>  static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs =
*regs)
>  {
>  }
> +static bool emulate_nop_insn(struct arch_uprobe *auprobe)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_X86_64 */
>
>  struct uprobe_xol_ops {
> @@ -840,6 +859,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *a=
uprobe, struct insn *insn)
>         insn_byte_t p;
>         int i;
>
> +       if (emulate_nop_insn(auprobe))
> +               goto setup;
> +
>         switch (opc1) {
>         case 0xeb:      /* jmp 8 */
>         case 0xe9:      /* jmp 32 */

