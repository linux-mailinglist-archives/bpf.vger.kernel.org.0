Return-Path: <bpf+bounces-70534-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1495BC29C9
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 22:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A152D3C3BE6
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 20:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F441FDE39;
	Tue,  7 Oct 2025 20:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPM/uPKs"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533F5226D14
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 20:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868296; cv=none; b=FOWbSmu93nxxe7Ampzdf3rHPV2mHGH1Oy1sWOGxQ7c606vnpFQI0ZeC3fI9sh3axHWT8O6UXQKwkBmB8gGuRbaY8uY8RbLlRGEUCzlX7W9PuTW9ewP0RUiKkdd/D3KCV/P5gSFDNx1aAXG1YIJGgNye/2SU4IeZIIJCApTnJC54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868296; c=relaxed/simple;
	bh=kP0l/EpYN+BGYqY3giAsBnkCg6+Vpcf2+tp5Lov4bN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c108aM8zz5mVuIoK7k+HLtTRaPMOJVzNcb88Zcy3cHwt3uIxQeLmsAGCvHQqOSIoyJPuldktKCs72wuL1CEphfmf6cZVERr7nlhrNxJaCp8RAg8RxFJhKWs+z0q2udA2miu4Kx+TS2TTzH4ycTTtvX/SMEJwYh5Upm0fuErnw2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPM/uPKs; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-62fc89cd68bso14041342a12.0
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 13:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759868292; x=1760473092; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TixKzkx2F+0D3jkB/5WfreYWjjv6e7rb57YxsOa2614=;
        b=jPM/uPKsv3yT4H0GK+auzgwe9D0oHQfv3VptMGUhsx6Cix+cwGIaeNYIpxIfY5NlN7
         QtYT53RdcpCtvADa2BVgTSxxgT1Q2hRvFXYWx4SmyRSRAohLYYVDtTzSxeQYLPnm/A2p
         FVF9RpofjRaawlF4ccUdD/4AwjhqhV005BHHJfV4db1ji4uinagAnDh5+WnxRwCHJ2cH
         1chieOE4J594CoA6MCg7iXQGxlqNSIwFGy2IydV9I+nCAJDnOErO8hiulmoGlXTP8t5j
         57F+PYb0rBHSrdAGMVMixmjKYkEqulCUjXbrE9S2hGPd2gSJNFhX/EMnc17s4pIaRL9C
         Qgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759868292; x=1760473092;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TixKzkx2F+0D3jkB/5WfreYWjjv6e7rb57YxsOa2614=;
        b=sJgeTECYa1SR3IOsBuHu1/TxHYx0wu0rBdz83GAyr5N8lV9GZUvyh6SvSrTg3mYSfE
         p7FBQA0P+jrmeC1XUqIfJoT8faU+C2PnqvrO8G3Rw0rmaHgMPaG1ztqVIVZt5NoSWyGx
         7Li/ynHqiSoLTA9VM/kg7RtjlamfMmINLHA146wMYd0OyVP3qgso8prI1TSG9LSvKb5w
         6qP25ocUsV4/7ubt0di0DXjTiN/Cot7zy3UVkFW+fV7XGPiO6i5fN8oUMmt4bqVOEBSZ
         7Jli+RwhUhJ2M5uS+xvX235Bc5GOOhmzaOK1JXUReqgaz0VDUwy7r3i62/ogW9RudzWK
         cwRg==
X-Gm-Message-State: AOJu0Yxal8QYbQ14ONZ9mDZBrVKV9L82ftLEYYRy6wz+alEkY07vbaYE
	jM0DOBt/1jMoiAf+q6Rad6VRqR0Sgp7218K5BZNxEfRKgYFnq2xJtHBmbbhZe4ClSHgFVL58jla
	0RIzNITiLn68tP21aSiar3TVTWl3uCpI=
X-Gm-Gg: ASbGnctvvDQq/KG6i4iYThyZFyAzxpB7Ai5GPbkt91eGJyETwfHFu+ZcuU38uG2mBxs
	WgBwir91roeDEuBbhE2zRsb0sqVM9SgxVSg/aqEAAhmdcfKncgIC7eGWXe4o5ZPZV2uKyyB/9qj
	L36Wt3vqqshceE6X7YKs/jRTf9JsguWqKqlG4FdDwBBwu3F6f3RxsyAhGmRIBVHY20U6jwL8rij
	WvduxhUXXB+aCEpxkdywZ68GmxGG2QSpJlh/a2ifVnlsFw4NNellp19f4x9is5Q4wkRF1Tt5RgW
	e0cqhP/UpWKsRG3ozJJSLw==
X-Google-Smtp-Source: AGHT+IFRwcZ3Lm8OVVQcUR9cowObsgcNZNmE+94Cn/W/urXR0kNauRPiCUH5HdNm3q7rs/1MUPxwQqGt997ovqK9hwI=
X-Received: by 2002:a17:906:c105:b0:b3e:907c:9e26 with SMTP id
 a640c23a62f3a-b50ac5cfaf7mr104022366b.59.1759868292218; Tue, 07 Oct 2025
 13:18:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007014310.2889183-1-memxor@gmail.com> <20251007014310.2889183-3-memxor@gmail.com>
 <5ab5aa0dd0a769cfcee7fe9407f95d3956947794.camel@gmail.com>
 <CAP01T77cYTG8v8LrviWFcptdTh5XanqSvUp5Wx9Hvf-LUGQzBA@mail.gmail.com> <2e99de696f5a910714100d9e4408d0bf61c55c45.camel@gmail.com>
In-Reply-To: <2e99de696f5a910714100d9e4408d0bf61c55c45.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 7 Oct 2025 22:17:35 +0200
X-Gm-Features: AS18NWCfjldeqWYtfqNvOopjRuROtMBHwZOYYicNGuAI0OCs1ecnSHhHHP0gwq8
Message-ID: <CAP01T76cbaNi4p-y8E0sjE2NXSra2S=Uja8G4hSQDu_SbXxREQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Fix GFP flags for non-sleepable
 async callbacks
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com, 
	mykyta.yatsenko5@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 21:32, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Tue, 2025-10-07 at 21:26 +0200, Kumar Kartikeya Dwivedi wrote:
> > On Tue, 7 Oct 2025 at 21:14, Eduard Zingerman <eddyz87@gmail.com> wrote:
> > >
> > > On Tue, 2025-10-07 at 01:43 +0000, Kumar Kartikeya Dwivedi wrote:
> > >
> > > [...]
> > >
> > > > @@ -11460,10 +11460,17 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> > > >                       return -EINVAL;
> > > >               }
> > > >
> > > > -             if (in_sleepable(env) && is_storage_get_function(func_id))
> > > > +             if (is_storage_get_function(func_id))
> > > >                       env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> > > >       }
> > > >
> > > > +     /*
> > > > +      * Non-sleepable contexts in sleepable programs (e.g., timer callbacks)
> > > > +      * are atomic and must use GFP_ATOMIC for storage_get helpers.
> > > > +      */
> > > > +     if (!in_sleepable(env) && is_storage_get_function(func_id))
> > > > +             env->insn_aux_data[insn_idx].storage_get_func_atomic = true;
> > > > +
> > >
> > > Note this discussion:
> > > https://lore.kernel.org/bpf/8e1e6e4e3ae2eb9454a37613f30d883d3f4a7270.camel@gmail.com/
> > >
> > > It appears there is already a need to have a flag in struct
> > > subprog_info, indicating whether subprogram might run in a sleepable
> > > context. Maybe add this flag and remove .storage_get_func_atomic
> > > altogether? (And check subprog_info in the do_misc_fixups()).
> >
> > Ok, I can add a subprog field and check it that way.
>
> To be useful both here and in Mykyta's case I think the flag should be
> tri-state:
> - never sleeps
> - always sleeps [Mykyta's case]
> - sometimes sleeps [this case]
>
> Wdyt?

We discussed offline, in summary:
The current flag is per instruction, which means it can accurately
reflect cases where a sleepable subprog may have delineated atomic
sections where the helper is called, and the subprog_info flag applies
to the whole subprog, so the information they provide is a bit
different. The agreement is to replace func_atomic bit with a
non_sleepable bit to record whether the helper is ever called in
atomic context (if not set, it is always called in non-atomic /
sleepable context, otherwise it may be called at least once in atomic
/ non-sleepable context).

