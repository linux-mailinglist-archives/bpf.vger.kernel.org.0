Return-Path: <bpf+bounces-27246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE4B8AB4A9
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 19:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05C89B24452
	for <lists+bpf@lfdr.de>; Fri, 19 Apr 2024 17:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53A213AD3D;
	Fri, 19 Apr 2024 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ba/GJ4gK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE77D131E5D;
	Fri, 19 Apr 2024 17:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713549564; cv=none; b=Nvgwcb+9Ah/CK9Vvgzl8LmhWEd3jc/OTvQJvUstRGdfxkBaRXCDKIA8kZf9nN8gTAVmAUmiHubDI3a6Bty4C7ZB8uJgjtTK3HFtqbDB1/h6A412yYTNJbreeKcdO7CLbeWRPHs9vuereaSPogiB1zgqIIRwKPemwl6mqQSbFoxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713549564; c=relaxed/simple;
	bh=quGDQ16xu9ymkCvK120cEfDS9OH1lkQ+IAA2POqQIkE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TyHtCDBEwmTwa+DA061fqhpefbBmULuTmwczNMVuC3ELCXfWPcdGXm2/O7r4ZIx6gaz4AKDULjxiikdDEbR2p9Cog/FB742l8PYqdySB8afM6sM01hM+aHo4VhVBHzK8QPQMocc5FhcB+SicE2bDcTeqgVT97Haqn8+M6ULwYmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ba/GJ4gK; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6eced6fd98aso2175656b3a.0;
        Fri, 19 Apr 2024 10:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713549562; x=1714154362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqtwiGdYPuaFKzZYkiBX1chFcNHZHPLN6Ck7LzgMubI=;
        b=ba/GJ4gKoJ78GGNNzy6tsc5Goowntt2Yxk8vRpX+29zJBj3FDPLU+DEY6MKQ7Ai4oo
         nl8OgbZDgsWRmNmLnm6sKb3XYvWy57LRnaMktPXMWnGNECIMWVX2f5bXVLcFT2HjSpoH
         ljxLGezqmFo9KNbwg+xO0AYjLxW9QHuWIXUOKbYV0c4v13i3nlp1PebAeYlmtOvFX7cD
         otIfZXAaUIa0/0mA1fyHBHEI/4tE5KjuZecbjQ2HIYpZeF0OvsVCfQAZLruTIwVMaSdY
         Rk8KoMef7P/77ruXlhJG9oo9cuSMJObuwG2G7fkc94OWB5lFoGMC0g1dMK1zljExqkqu
         vbug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713549562; x=1714154362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qqtwiGdYPuaFKzZYkiBX1chFcNHZHPLN6Ck7LzgMubI=;
        b=csucUacecGpjKoHL9D0MN97nQ3D1thNs7blyqvhZHvLaLjBCI59yBGwQNyDKyedM2S
         UmIkR9i4AYbXYblM5TW5KlJQ0EwTQgjSYJ1f/M/ZlnYQYwxr8CjtWOLdNs8U8hePpCCz
         opwtJAZ19Lb7IlOEEoHHHX5rS9z+eHwGXgm98QCLxFGdZYwS40boBrBwUKRraUpfZH3k
         qL/5BpVfU8wD3qYF0qMX1vptcW7wt0ZsGN/jGTLf7xfP938TgBbo/uz/l3QeiOK3w8A5
         vLvBkb4AlTKvwZ/1AZgKnieQjCa0sN8WJNczMOIleIn+i5rJUwHeEuF35xi1AmJZnOIa
         M+GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWBlsf8MEfC3VLImefPFV/d55DABaMly1MDXYGMYlYhLd3S8A6kb8yzeSFvTQkh/g7PctRNVzIOYqYFb0QVmBnt8WKIADaMfQYOAexOG3iwrGxqilPp+AW3Tgfb3mQre/olEr9dy6d
X-Gm-Message-State: AOJu0Yysx++RzuClaMZduh5va6QQQ57Xm8zM4AupVmDvKRj4ryfUuQMG
	nRaEVHezV555Eulk9vsc5Kt2WElKR+cutiCNX6Pd7jULXn/CYEeOx99nkyglnU9buSmZKAi+h6a
	4jMqQmy41hEQWwPXh4dVzO48AvIIY7g==
X-Google-Smtp-Source: AGHT+IGng/9Fs2bcka9QRlG9K7ZwnCl6FngpqGaUXn9Zm1MVXRDwznLLhIMbYDeTIXL/If3ay2Rtr5GW9XV76ptciHI=
X-Received: by 2002:a05:6a20:244d:b0:1a8:4266:3d02 with SMTP id
 t13-20020a056a20244d00b001a842663d02mr4220926pzc.30.1713549562129; Fri, 19
 Apr 2024 10:59:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418190909.704286-1-andrii@kernel.org> <20240418190909.704286-2-andrii@kernel.org>
 <20240419100041.87152aa873cbf25e52b8bd4f@kernel.org>
In-Reply-To: <20240419100041.87152aa873cbf25e52b8bd4f@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Apr 2024 10:59:09 -0700
Message-ID: <CAEf4BzbpgaL771QC+uz22R5vpLSO+qeQ7RQbdZzLu7aNn22aug@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] rethook: honor CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
 in rethook_try_get()
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, bpf@vger.kernel.org, jolsa@kernel.org, 
	"Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 6:00=E2=80=AFPM Masami Hiramatsu <mhiramat@kernel.o=
rg> wrote:
>
> On Thu, 18 Apr 2024 12:09:09 -0700
> Andrii Nakryiko <andrii@kernel.org> wrote:
>
> > Take into account CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING when validatin=
g
> > that RCU is watching when trying to setup rethooko on a function entry.
> >
> > One notable exception when we force rcu_is_watching() check is
> > CONFIG_KPROBE_EVENTS_ON_NOTRACE=3Dy case, in which case kretprobes will=
 use
> > old-style int3-based workflow instead of relying on ftrace, making RCU
> > watching check important to validate.
> >
> > This further (in addition to improvements in the previous patch)
> > improves BPF multi-kretprobe (which rely on rethook) runtime throughput
> > by 2.3%, according to BPF benchmarks ([0]).
> >
> >   [0] https://lore.kernel.org/bpf/CAEf4BzauQ2WKMjZdc9s0rBWa01BYbgwHN6aN=
DXQSHYia47pQ-w@mail.gmail.com/
> >
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>
>
> Thanks for update! This looks good to me.

Thanks, Masami! Will you take it through your tree, or you'd like to
route it through bpf-next?

>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Thanks,
>
> > ---
> >  kernel/trace/rethook.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
> > index fa03094e9e69..a974605ad7a5 100644
> > --- a/kernel/trace/rethook.c
> > +++ b/kernel/trace/rethook.c
> > @@ -166,6 +166,7 @@ struct rethook_node *rethook_try_get(struct rethook=
 *rh)
> >       if (unlikely(!handler))
> >               return NULL;
> >
> > +#if defined(CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING) || defined(CONFIG_=
KPROBE_EVENTS_ON_NOTRACE)
> >       /*
> >        * This expects the caller will set up a rethook on a function en=
try.
> >        * When the function returns, the rethook will eventually be recl=
aimed
> > @@ -174,6 +175,7 @@ struct rethook_node *rethook_try_get(struct rethook=
 *rh)
> >        */
> >       if (unlikely(!rcu_is_watching()))
> >               return NULL;
> > +#endif
> >
> >       return (struct rethook_node *)objpool_pop(&rh->pool);
> >  }
> > --
> > 2.43.0
> >
>
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

