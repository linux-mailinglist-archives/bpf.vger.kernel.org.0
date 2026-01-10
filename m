Return-Path: <bpf+bounces-78447-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E54B3D0CECF
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 05:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E61DD301F23A
	for <lists+bpf@lfdr.de>; Sat, 10 Jan 2026 04:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FA2773F4;
	Sat, 10 Jan 2026 04:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ap4wVykx"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1694274B23
	for <bpf@vger.kernel.org>; Sat, 10 Jan 2026 04:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017865; cv=none; b=drK23lggl85QSnctU/doxnvpzeDf5ygNH4Z2XzdHkBDyDqusZbtRALNRUi2qxMS0Z3bgOHZLOWfTdKg8CPPxY4D4bGA2U3uk2m8L7EDBy6L5pZ6pOGWQwZpX/M1ZTN5pm9q5GPtdg9W+5ja7e2E807QMX8tamKv8UUTGyqd663U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017865; c=relaxed/simple;
	bh=RuvbIvw2NqCibI37H+OxSzBuDzFZJky1Zs/JoE79A44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urtq/lOtus96/Hj0+vh26xCdtGWT6ejFxYfa1wD9Ywej6pEiNhaD1RQbM6qdxYu0UeC4CufLzW+h1tGeL4ZPi3zGpEKkJzLTR85Ct9IfSF0Tzg8zcZbdB/ev2UsPuoqE548XzJax9Xi6tk6k9x2m1U6Akz9+xMDOFKrEPK99hNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ap4wVykx; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-6447743ce90so5075581d50.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 20:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768017862; x=1768622662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WVxIntMlBs0ySdA8Un2AaznZD95MeZBJNv/gf6NUZc=;
        b=ap4wVykxl8jF+5FXEylR/jolZPTWkMkC1KIf0bEv8sGTeB2Q17j4JZefmxG0663OKy
         Pp3mYKpCeoac3yq1Sk1txtXX8Xuif9VE5VlWJB/aUlqdyjmXI7DGBJbvWzMkVFehLNzM
         5yrkl5ZercvRodqunIPfdIKfc2Fj9JW2bvXOIfIZwyeoklz9R/JQLjbvAkSJzVlCLJ2b
         5p2W+lRKzgvyCvFTWPUcgExaACOOH4Rp7R0V/i+LYo8xSzsBLQCl1BD4fTLomu77shte
         RuIJIt3YGUmFpiX0IQWTtChWZs1Oz/g3WG88KqE7N16osl10/Md4MreEun8IpjhfT4va
         1Ipw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768017862; x=1768622662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8WVxIntMlBs0ySdA8Un2AaznZD95MeZBJNv/gf6NUZc=;
        b=w/Ldt8iubyp4UZ8oNqn+4h38X8NnoORxbTqTL6BoMNH3b2Ao8oy+68vMW0kwzr4oUt
         ZU3a8nEi3Q296Y9Nf5xk4jElfgMZkLSt/EG98dMS4q+ibND4G4cTWBEA+zcwS5KmMYRj
         Cwed06V7p8r8j1FmblQXwhZBRXrBNENaSASG6YzU41Kv6ckCh5RW5yojSxFfEtw4q6GB
         4zCQ1lCszxLjBXsvryWrLTABQTfncSQ02/aodlkPZgLIp5JzOSUHdn6RqlvwW+4sod6v
         m2oWTGn55i3hV40b3t4ABdIQyiZKQRPIGkJmHteNURXoCCcbq/zHH7rtNZchnjSDPwCh
         sFUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2dJc0bqoy2WsUWnME3wEc8mgzu5WaQZLpkdPnxOhYBUG0lVINXDiWzO2R7W3tBA/RaNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6C86qI2JNqfrMdIOiB513LuZhTFbwve/t91mIS3BwJOA3WnX9
	ihEsPLRPvPJe4IyoWCctBliowfbpRbVw3KVImEsjLSoEPgMR0NrmVe6/wpJE1RynF1TdqfrA3aT
	z/6WU6m00yGLWWpppZq8GnsA2uL1mAIE=
X-Gm-Gg: AY/fxX53Sy3SzOgujNedSLPXEcPCEWCnW1j1WrngbgzBVXAhanHDCCGRyHh0E1I8gZ9
	S4ZWSWaWarrAKZlXtie7pBNznTmC3IyYFLD3pBxyUhweFOO6FYBac2hhs9Y6X2VuKMvjaT91UyI
	WrPpOJI1Mzt/qCd+Y3JsIk8gDV+ioXBjdf+X8S5KrrSe7X9G5Kd3j1FN/DIiKWMZadncZ6SvjqX
	1igumWlhEwUfnWkZ/DHIo8GBzx4T6EvnXYNdUh3hZB2IJ5uiJfCKCcqSy3TgLnajG6K6ng=
X-Google-Smtp-Source: AGHT+IHtbog5VwGJhCAd+Xx56EnWFj9zq679lQ/SYwMv7Nxmks2n8+hBmm9sSzyFScp5sSSIDt7W5P7DvQDS818kd/g=
X-Received: by 2002:a05:690e:10c:b0:644:4b86:e7d1 with SMTP id
 956f58d0204a3-64716bbb915mr7884976d50.10.1768017861920; Fri, 09 Jan 2026
 20:04:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
 <20260108022450.88086-5-dongml2@chinatelecom.cn> <CAADnVQLj4c-nc6gLbBiaT24KXWEpG3AzFT=P1tszu_akXhyD=Q@mail.gmail.com>
 <5075208.31r3eYUQgx@7950hx>
In-Reply-To: <5075208.31r3eYUQgx@7950hx>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 10 Jan 2026 12:04:11 +0800
X-Gm-Features: AZwV_QhydPjR2gj4qZAUo1kuoFwZGFBEoaurqLGgE-_VGTEItdt2KQLoEYaN3-M
Message-ID: <CADxym3YkfSju-mcLSA5_44e-rdQ935Pt_sv75M_BGm3RiDcq2w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 04/11] bpf: support fsession for bpf_session_is_return
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, jiang.biao@linux.dev, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, bpf <bpf@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 10, 2026 at 11:38=E2=80=AFAM Menglong Dong <menglong.dong@linux=
.dev> wrote:
>
> On 2026/1/10 10:40, Alexei Starovoitov wrote:
> > On Wed, Jan 7, 2026 at 6:25=E2=80=AFPM Menglong Dong <menglong8.dong@gm=
ail.com> wrote:
> > >
> > > +       } else if (func_id =3D=3D special_kfunc_list[KF_bpf_session_i=
s_return]) {
> > > +               if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESS=
ION)
> > > +                       addr =3D (unsigned long)bpf_fsession_is_retur=
n;
> >
> > ...
> >
> > > +bool bpf_fsession_is_return(void *ctx)
> > > +{
> > > +       /* This helper call is inlined by verifier. */
> > > +       return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> > > +}
> > > +
> >
> > Why do this specialization and introduce a global function
> > that will never be called, since it will be inlined anyway?
>
> Ah, the specialization and the definition of the global function
> is not unnecessary. I thought that it's kinda fallback solution
      ^
typo: is not necessary

> that we define the function even if it is inlined by the verifier.
>
> >
> > Remove the first hunk and make the 2nd a comment instead of a real func=
tion?
>
> Agree. So it will be:
>
> +static bool bpf_fsession_is_return(void *ctx)
> +{
> +       /* This helper call is implemented and inlined by the verifier, a=
nd the logic is:
> +         *   return !!(((u64 *)ctx)[-1] & (1 << BPF_TRAMP_M_IS_RETURN));
> +         */
> +        return false;
> +}
>
> >
> >
>
>
>
>

