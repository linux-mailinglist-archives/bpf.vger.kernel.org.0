Return-Path: <bpf+bounces-45981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8BE9E10B1
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620A1B22492
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C621D2500C5;
	Tue,  3 Dec 2024 01:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMQvsM5a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE87518B03
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 01:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733188333; cv=none; b=NYey8JO5fppP0+iJNN/x31PwVeoiLPsjqLq+TnmSNi4rBqhbqcKXODurGEZlKNatt5RTzXOUw7BuwQZktzMs4q2jfJ0RRmMhBqmWIBkac72cWhsy6xMRkEEmwY25PThI7lODg1bKjpozn/T/uuLVZgk3VEix+CP619GnagI7dWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733188333; c=relaxed/simple;
	bh=X1mk5uvviP9sHx09zwR33IHp7J/x4UGJm7faa++XMa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JZNundPCMXWiWPO07Y8GIbV33pavjOYx+an77O3ATpx9wSJMI6t/hP3uim6qsfvD44NZoEGTSLjujR+xD49EubSSQqMHz3k2VpL5lMW8qRmBP1yYVkgG+xP97h2maxJmusoEalZHSD2qcMUTu6UtkO2BMoTspEoBgkQnsBEDNR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMQvsM5a; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0374so3857592a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 17:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733188330; x=1733793130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zD/UkF/f1UbK+W/pGwxF96S3vCLbTGXj/G374qkDj1I=;
        b=SMQvsM5a4f58wsi/emYaoIl2FkS2nVI4FLCMqGYyDOPSnJUyM7o3DzmdRdeNq07JD9
         8BvWpbu/Mqs1fvz1zn1YAjf2F490StOAha/3uIWcsAHQKsRto8HJkJkbWKb0Ljrj7JZf
         +kYffSMfUgT1mwJocJp4FPUCb2nSTe5S7gXwldeZJoGKxgFFGiDMtwA6+iRvnROa8LTL
         /x08y0KUVPc4BTIT9sQ9QqXTRERDSMne/PFbMMng9tA0iPaBfbfZBdpkQ/94gHFXhJhD
         aJC+on5jqtMx8aTzGIy8l7mvC2K8Etqx7+izMkPRWZMmbG/HI0FX7rl+GdMRGrM8SmLZ
         ejAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733188330; x=1733793130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zD/UkF/f1UbK+W/pGwxF96S3vCLbTGXj/G374qkDj1I=;
        b=p/i+w7ZN+SWf45qIsdvCnI8pFuH5BMIFwF3e7ltpdALChpb3rDbFJrPz+RYA4/iKyP
         bX2k8fBG+O1wM9oOkdF3hWr0H+MyHctiL99t5s9mtvz5u3xcohLGEGW8vZPjBQ6J5/V8
         NgmWcWwH8cuAN4PPN8M9jHyx8P028KPEsunZHgK09vecInyYwalyvQ92Tu24fexZOF0v
         iIkWL2KBGzx7bcLiN2fyTksA60b6UtUA5qyY7YUFxmqz3lybWUAd0s1otT+dhLCCbJaw
         4f2ZtZuuMJMyL6e8nSRXAFxTillYgiWvzKydog8CMupJPuBtNNPHFJAcpswBGQypmECY
         jGdw==
X-Gm-Message-State: AOJu0Yx9saOMXnWQqElGebWuwjwFlNne/WhnR0LNv0qqBam7QNXmO1hr
	cJuJDCEFIX5Iclty0ZEMDgv0xpE3x5MnQe2Xt3nqzYUIC0RdLe3IytnCL/XHEh2RaJlmTZ0q8I/
	xNQXqjwbzF/S/xiKy2c9f4qcp5d4=
X-Gm-Gg: ASbGncsnNS8mW71eKZbHX3OEVlmh3zvX99FVXp8+rWmsBxvSPnbU7GEPEChzrj8BGlN
	hqAY1NwGXu27ZG/wjFEjNnLSWi8lRVTpt3hzFmyMP6zixy67i4rxAs7JOcca8vOz5
X-Google-Smtp-Source: AGHT+IHIa5uXdrTc1T1+svr985RvnkkH6zrDnfZOCPITanafO6Dk9rxXaIB7A0y5yF2Cpgo8bHgo3506hPadzwer6Js=
X-Received: by 2002:a05:6402:210c:b0:5cf:9e5:7d20 with SMTP id
 4fb4d7f45d1cf-5d10cb5b94emr277929a12.17.1733188329880; Mon, 02 Dec 2024
 17:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129001632.3828611-1-memxor@gmail.com> <20241129001632.3828611-3-memxor@gmail.com>
 <CAADnVQLXvLj7US=cEtdFF5N0vESEKUTJKC72zDAev9_GXnqmcg@mail.gmail.com>
In-Reply-To: <CAADnVQLXvLj7US=cEtdFF5N0vESEKUTJKC72zDAev9_GXnqmcg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Dec 2024 02:11:33 +0100
Message-ID: <CAP01T76nWq6fFiZQSQtEzaW8ZTDi30agoj-kDZqeo8Qp5xnt2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 2/7] bpf: Refactor {acquire,release}_reference_state
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 3 Dec 2024 at 01:03, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Nov 28, 2024 at 4:16=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > +static struct bpf_reference_state *acquire_reference_state(struct bpf_=
verifier_env *env, int insn_idx, bool gen_id)
> >  {
> >         struct bpf_verifier_state *state =3D env->cur_state;
> >         int new_ofs =3D state->acquired_refs;
> > -       int id, err;
> > +       int err;
> >
> >         err =3D resize_reference_state(state, state->acquired_refs + 1)=
;
> >         if (err)
> > -               return err;
> > -       id =3D ++env->id_gen;
> > -       state->refs[new_ofs].type =3D REF_TYPE_PTR;
> > -       state->refs[new_ofs].id =3D id;
> > +               return NULL;
> > +       if (gen_id)
> > +               state->refs[new_ofs].id =3D ++env->id_gen;
>
> ...
>
> > +static int acquire_reference(struct bpf_verifier_env *env, int insn_id=
x)
> > +{
> > +       struct bpf_reference_state *s;
> > +
> > +       s =3D acquire_reference_state(env, insn_idx, true);
> > +       if (!s)
> > +               return -ENOMEM;
> > +       s->type =3D REF_TYPE_PTR;
> > +       return s->id;
>
> Small nit.
> I think 'bool gen_id' is not very readable, since
> the callsite is not obvious.
> Let's drop the flag and instead do:
>   s->id =3D ++env->id_gen;
>   return s->id;

Ok.

>
> > +       s =3D acquire_reference_state(env, insn_idx, false);
> > +       s->type =3D type;
> > +       s->id =3D id;
> > +       s->ptr =3D ptr;
>
> this bit will be easier to read too.

Ok.

