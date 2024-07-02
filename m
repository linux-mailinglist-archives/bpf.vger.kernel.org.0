Return-Path: <bpf+bounces-33674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 555E19249C4
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 23:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E70691F230BB
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 21:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBD8201266;
	Tue,  2 Jul 2024 21:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZ5TLTzP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E051BA87F
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719954721; cv=none; b=EuKD4oCmCQlkpHLb6NIWha7RJgm6DRDYkL0LJInB4uZDydY+UoPwvTgdz52dsP7wtOGonsGD7+M7P1N7mhZfL4XAf0ZGXhBcqScohD5So4ryXhA4/WoPLEhiWSq7XPB0c6bwmVKVnCMyZKMialdBdOdvc5FlnSjuWU8CaTt5xcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719954721; c=relaxed/simple;
	bh=/7hB1M7eerqHT6gklUbXyTG68Lbt6P4zbbx10u3y9kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aSdKnopZtMqogU8HWbca4ElQND8xFGxnm9riG8AKkSTCkcpXrqnYmXi+xRtltWwmV4DvrYBJ8Mx8iN40GAMUSHtKCu7XH8gYp7a0B1zHhE480GYyAEzubQLiGj3xukNwtmrUWRKWTP69J+AWSZYKd7FocTMuHfJU7HBrbAwhXSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZ5TLTzP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-701b0b0be38so3806304b3a.0
        for <bpf@vger.kernel.org>; Tue, 02 Jul 2024 14:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719954720; x=1720559520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snw8ylCKUzAXGyhYnWQStQ01u7bbXm/4d50DBClZnWE=;
        b=eZ5TLTzPCTlNj+vCVVQp4tuwSlqkiDoBERrcJHT7Heh3vD3grbg/D1NFzYqrBfWF6W
         FPkrfOlDTTMdzK9zq4ZRaJcXV/F6R2APrScJKVf9HrgJ0VjfHBwzCELmYVGBf5+r+xqL
         sqcKNpXgCqp+HV1CrhKrA5N3ttJdpkkMBrEvpBsRZReB6rw5U94ugzblFU1dBG0urbHX
         Xa+NyL3In3myiinEpzCk3WnllHmjH18UasxOB3TnzraWq8G/Gv5BNcJEASK0m4rybVHD
         BAqd739S0KrkDEOlaVoPySTHWlfgJO4HqhJhx7luyBBxXqByqKsuYdPGpkwaQlibNW9h
         x6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719954720; x=1720559520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snw8ylCKUzAXGyhYnWQStQ01u7bbXm/4d50DBClZnWE=;
        b=ZVo2r90FHFjbHDPaT32blZqoV/Tud3LIRabIaApy2xeBG6lVINciHK+HHACfLzUJdW
         jH+7iMgoWse/v64+kS5ZnbADow8BbVxEJFWD9+fjmTWW9qomAWJZJfU4OSnJTrIcJro4
         IE1JylKQVcBa6YicH28wpFLdPq2lvauwaYGRd/atLYTZCCDpoU1A/kadW+u5XQ+Dwe+o
         DXWeEb1tDU45h8LS8iEcMB8nSHYCJAIeNEMcu9sbzHfjsfvsFR5K8TMaEbiV4r/GCOvW
         dO9lAVM9BRCLIxD6fu/SqpsZ7oVqlK5nLYHvG1A+dS6kKqa0X98RHyqPYHDlg3CAU5BH
         OnkA==
X-Gm-Message-State: AOJu0YxN0yDA8fzG18zSvTqsakGYDRG2ck0CPujys77rOrd4omoKrxhM
	CJwKZaRDm7nIxQP3fQhWt0VynaQ3M9s9AACuymnCUMftL7LECGFYUuY+MVDIuSEgyUcz3/JVGl9
	9aiy7hJkq76UE1SHQl+Q1JqJiR7w=
X-Google-Smtp-Source: AGHT+IGUiGYqZvKHUQfP2l+d7DJPbQMDwEpeHQyPInwQL3RgnO8PP5Q6fabiYETldOkCmacJJW0cnZm5gs9/UqdVe/g=
X-Received: by 2002:a05:6a20:748a:b0:1bd:1fb9:37c1 with SMTP id
 adf61e73a8af0-1bef611c565mr14254559637.23.1719954719736; Tue, 02 Jul 2024
 14:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629094733.3863850-1-eddyz87@gmail.com> <20240629094733.3863850-4-eddyz87@gmail.com>
 <CAEf4BzangPmSY3thz6MW5rMzcA+eOgjD4QNfg2b594u8Qx-45A@mail.gmail.com> <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
In-Reply-To: <ab7694e6802ddab1ea49994663ca787e98aa25a1.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 14:11:47 -0700
Message-ID: <CAEf4Bza7nmnFDvuPLU2xRQ-mZifUKLSiq3ZuE91MCaPoTqtBXw@mail.gmail.com>
Subject: Re: [RFC bpf-next v1 3/8] bpf, x86: no_caller_saved_registers for bpf_get_smp_processor_id()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:44=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Mon, 2024-07-01 at 17:41 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > @@ -158,6 +158,7 @@ const struct bpf_func_proto bpf_get_smp_processor=
_id_proto =3D {
> > >         .func           =3D bpf_get_smp_processor_id,
> > >         .gpl_only       =3D false,
> > >         .ret_type       =3D RET_INTEGER,
> > > +       .nocsr          =3D true,
> >
> > I'm wondering if we should call this flag in such a way that it's
> > clear that this is more of an request, while the actual nocsr cleanup
> > and stuff is done only if BPF verifier/BPF JIT support that for
> > specific architecture/config/etc?
>
> Can change to .allow_nocsr. On the other hand, can remove this flag
> completely and rely on call_csr_mask().

I like the declaration that helper is eligible to be close to helper
definition, so I'd definitely keep it, but yeah "allow_nocsr" seems
betterto me

>
> [...]
>
> > > @@ -16030,7 +16030,14 @@ static u8 get_helper_reg_mask(const struct b=
pf_func_proto *fn)
> > >   */
> > >  static bool verifier_inlines_helper_call(struct bpf_verifier_env *en=
v, s32 imm)
> > >  {
> > > -       return false;
> > > +       switch (imm) {
> > > +#ifdef CONFIG_X86_64
> > > +       case BPF_FUNC_get_smp_processor_id:
> > > +               return env->prog->jit_requested && bpf_jit_supports_p=
ercpu_insn();
> > > +#endif
> >
> > please see bpf_jit_inlines_helper_call(), arm64 and risc-v inline it
> > in JIT, so we need to validate they don't assume any of R1-R5 register
> > to be a scratch register
>
> At the moment I return false for this archs.
> Or do you suggest these to be added in the current patch-set?

I'd add them from the get go. CC Puranjay to double-check?

>
> [...]

