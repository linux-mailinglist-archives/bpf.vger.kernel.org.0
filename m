Return-Path: <bpf+bounces-77154-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D144CD032F
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 15:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A8743050CC9
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 14:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745032824A;
	Fri, 19 Dec 2025 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKyIuDnj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8862D3225
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 14:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153086; cv=none; b=fwFEScevLXFhwgs7OFvsPUFqqlKuyOgncrimDfibMEjt5sEGaosqaKYz7CVjtlhh+3gF4Pb6dbHshf9hrt6CnAMb98OMrTdmtoGgbckh3sjPmwJIFQ0S7MlD+XLlLY8xRYHzUpUWyoFDkRu/pzTmhsNRz6mkP1PNhepvPkSWrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153086; c=relaxed/simple;
	bh=xrwer0i51j+vK7w8PnSsMSuWOOnWfVvIOvT/dSmKgHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMZxNi3YgQXP0z6S6o6PYXvJuQMqWwSRrwWZwMdckCQy8P5AIcR9KDe2LHHdfJ+LzFB4RXdtpyeaN9E1Obd0qwq1NsRhWLbjk0cdCxMSh3SQQu+JlTlgBrZLen0MESz9ps8ndKAIcOozZRuhP8+cT8z6xuhS/c6PTGCvEPEAtjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKyIuDnj; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-64669a2ecb5so1216765d50.1
        for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 06:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766153084; x=1766757884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EGxqoB7Y4Q+aOAQo4uC0e9A1qBgkvdCsyCbyewI9lPY=;
        b=UKyIuDnjHvcT9KPr4vzCfz5FXEu9NIYs8k+ax4Tbo/2MYPxnEPuWwxQDq47op7tvOt
         t/l/hvcaksGlB/5tN1EpdF2+b47noPbj+ljlf0QSFagjslEaVLMVlGBfGMG5Ng0iis3z
         rHfyF/nC7MK9gU1E7sJn6OawwB5dY891zk7T3PLrFCylbhhWFlahNJiQJNEX+I4J8loC
         EaxUfuByQ0XfzYoXUU/Hh7oKlkT31q3lbrA07sbttUlARITvhtTS7RRzED7xjmhfR7D5
         ZUT2/PL3dPi/kgQ30k/MrmYbq6cPiZNV4P5KZx50aT45kDFyrha1If9Sg/5fPezRtPdn
         yYdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766153084; x=1766757884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EGxqoB7Y4Q+aOAQo4uC0e9A1qBgkvdCsyCbyewI9lPY=;
        b=rIDLIoR7zUiQ2G23hSqGIiw1rWpbyfrzSvezKmzJejsk2Ff8qg1tJPJAaacFrJR/iH
         MGlHV5vgHm4brCeB4aL1uFxWdZuSHjRp61V2xwksAtTs28eqadCCWBygqt5Wj+zua8vl
         3nMYM7lgpR1tVDeosd/VwdgR4G3oiiknyALHKsnYkpQMcCt2XKvVYNdIcIYtWG5aaXo8
         KCRZKrObOPDqqWNdawf+2up2BCREtDn9n6N3M+iX2vi67+vOMg2On9MgvR4dOscdjVEt
         HdmRGQ5APP8wM9OnIkio2fqQxJoBD4tkGwtTmJD19OydjPVERrqKyjEJydgJJGBs+5lB
         7wEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKCRwTdA7GJSBbuO21uINx1bF9bIRp2nRE/MnsxNRP6dsbiWZ0fg1b+egptHYRja51usg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbJXcOmN9vP50Dd8Y/RtDQUFZtDJzc2qGKdCHZ0zdWl/BpcDpx
	uV+Tbswi2GfW4sPFyf5jxppK/jhGr7+4OhiIFgEGG3CTqvNUQfgzAjl6ZaoCuSaWM7uFkoT9lJU
	+lZ/NkQSDLX2yKHLWSFvyJjbVHFEQoL4=
X-Gm-Gg: AY/fxX4zzvfYMkDAclOiuOkImUAPgckJW3Th+QgcPbnNR2WWq02iKfqo3MTHPIS2L4W
	itvBfqKWBhV4uXMFllkZz58BHCEFvGOyznZMb7cXzYW6PbHJn8w3q5Vci28LmR6MqGls2atbXV0
	WRxeIHoZNKCm/wpG5+OUJka0mEz6MQdtaQ2zpKXoRmOhmAMIMuCrGkxbPufeQsdU/F1IolrVNxa
	1lM09YIG10xpo4boLo4rvILy3Yy54DxRhcpjQlz3H672C0p48voTsgzBN+oRC8N6lwZmsERRNU=
X-Google-Smtp-Source: AGHT+IFe5VQEy4+st1yZpJ90yvWkO9sdYhLBqjXP1Svo3qIeSORvrFBH7F5HtDjDOBbEu4XaMNwh4a68BzkqLovyvi0=
X-Received: by 2002:a05:690e:1242:b0:63f:c019:23b2 with SMTP id
 956f58d0204a3-6466329e6b7mr4564629d50.28.1766153084263; Fri, 19 Dec 2025
 06:04:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
 <875xa2g0m0.fsf@igel.home> <5070743.31r3eYUQgx@7950hx> <1948844.tdWV9SEqCh@7950hx>
 <87cy4aeg56.fsf@igel.home>
In-Reply-To: <87cy4aeg56.fsf@igel.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 19 Dec 2025 22:04:32 +0800
X-Gm-Features: AQt7F2ruKyHMhyl2Amo3LqNoWlaqpaF_0zgXhcG3nHKrhX2LjLD44Yver_XU5ik
Message-ID: <CADxym3Y098836fHHRSjeryxCp=CPB8sDU19TBBVs07VZOERJXw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: fix the usage of BPF_TRAMP_F_SKIP_FRAME
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Menglong Dong <menglong.dong@linux.dev>, ast@kernel.org, rostedt@goodmis.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, 
	haoluo@google.com, jolsa@kernel.org, mhiramat@kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, jiang.biao@linux.dev, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 9:49=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> On Dez 19 2025, Menglong Dong wrote:
>
> > diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_c=
omp64.c
> > index 5f9457e910e8..09b70bf362d3 100644
> > --- a/arch/riscv/net/bpf_jit_comp64.c
> > +++ b/arch/riscv/net/bpf_jit_comp64.c
> > @@ -1134,7 +1134,7 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im,
> >       store_args(nr_arg_slots, args_off, ctx);
> >
> >       /* skip to actual body of traced function */
> > -     if (flags & BPF_TRAMP_F_ORIG_STACK)
> > +     if (flags & BPF_TRAMP_F_CALL_ORIG)
> >               orig_call +=3D RV_FENTRY_NINSNS * 4;
>
> There are now three occurrences of that condition, and only the third
> one uses orig_call.  How about merging them?

Yeah, I think we can merge it to the third one, like this:

diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp6=
4.c
index 5f9457e910e8..37888abee70c 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1133,10 +1133,6 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im,

        store_args(nr_arg_slots, args_off, ctx);

-       /* skip to actual body of traced function */
-       if (flags & BPF_TRAMP_F_ORIG_STACK)
-               orig_call +=3D RV_FENTRY_NINSNS * 4;
-
        if (flags & BPF_TRAMP_F_CALL_ORIG) {
                emit_imm(RV_REG_A0, ctx->insns ? (const s64)im :
RV_MAX_COUNT_IMM, ctx);
                ret =3D emit_call((const u64)__bpf_tramp_enter, true, ctx);
@@ -1171,6 +1167,8 @@ static int __arch_prepare_bpf_trampoline(struct
bpf_tramp_image *im,
        }

        if (flags & BPF_TRAMP_F_CALL_ORIG) {
+               /* skip to actual body of traced function */
+               orig_call +=3D RV_FENTRY_NINSNS * 4;
                restore_args(min_t(int, nr_arg_slots,
RV_MAX_REG_ARGS), args_off, ctx);
                restore_stack_args(nr_arg_slots - RV_MAX_REG_ARGS,
args_off, stk_arg_off, ctx);
                ret =3D emit_call((const u64)orig_call, true, ctx);

>
> --
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint =3D 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC=
1
> "And now for something completely different."

