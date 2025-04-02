Return-Path: <bpf+bounces-55168-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C0BA792DF
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 18:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C46118913B5
	for <lists+bpf@lfdr.de>; Wed,  2 Apr 2025 16:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AACD18D65E;
	Wed,  2 Apr 2025 16:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFL/D/73"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20314BFA2
	for <bpf@vger.kernel.org>; Wed,  2 Apr 2025 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743610528; cv=none; b=jG97lM+fxIHay0Znr2+dmoNoAmvieoGueR8k3SOc8a1IRXyhCBwdmNoAjJougQryuSpEmQvJqalna6AseK7O3QjqRzGWGRLTNEiyOf3hE0zrAa4RYRj4ljx0X5LuOFPUVxJhC4MY44pd/WMhP09SlByxu149XzPNh5r3ZppkgyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743610528; c=relaxed/simple;
	bh=iX3roq9NcI2xhypJmK2yEC4w7t4mBDJXvijSgxok7RQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uh2o07uFFcU8VB8xVDMnwOmxk6AsunNVSGQLBIxw/7ty7rN5w2aRbWcTJExce53XTrIwR3tU1lH7Ugnd/9VEgMsPRWRc3GbaAKC3a/QLP/6oM8geCng003XNdjCX0cdqay25Ta3rpo1q2cYCrC0o2ukf436pZmOgG3F+H12pakw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFL/D/73; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7376dd56f60so271231b3a.3
        for <bpf@vger.kernel.org>; Wed, 02 Apr 2025 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743610526; x=1744215326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQAcNj2AeEMzKjCXHAqNMbMssSJD8pSUk92NDD6MiGk=;
        b=AFL/D/731qigUBJTsXmUWNXs/alxvz4oVyjXCOwynYpdtOggYm+CsuoAEAtDCyPoaB
         fbCo+SiDgkju/2CjL6wZuXiizP5RZx723MITjHWDnwgRweC1e0SRyd327NJH+f7cO3fi
         S7Cv5FrUuQ6hYuJjVTY9eRyZrzW5thAn2g6q0QHW1hLayNlikGUHV6dKf+wY4NKGnuf2
         nkXUJ+xBxuY7GWtFRckL+1OAhfzXwq/Io/L3h+caho9eo7gME1s+cw/Wn7aGEKpUMeGI
         KC/Up9GNLr2YkY0DlvZ7cvEu+tQvhiIs2hflsVhxx5gqX0sF5sTL0/RqOjMkFIuFad+k
         lsqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743610526; x=1744215326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQAcNj2AeEMzKjCXHAqNMbMssSJD8pSUk92NDD6MiGk=;
        b=fy6MhK0inSj//Wn4C0I6NOoIFcr4BwiPykaMrNBZ3SeYuVYI1Ylpyy/tVSr21dzVYn
         ctVU2llbFinKNYozzFloVkeG5qbL92KGjs+vq45tKFgbj1SMiVCh+shulafR0PTBszSW
         AMxfa5DkU8VWpVvN2vssdO+bIaFSJRGRWRGtRLMkl0gNcgDl2/ThA+qkvVeO1cZbsz3e
         EbqY5yFXqk236DMdJTwxTYA204aQw61bjinI+oySNBt84pzCXqivLcnFS2bObGwusZ7U
         8W2rkp/I/5d2LTvrE1VGgJlxKX7uBlnDpmtwCxIeYKqreQax3/ZH4AmovVtqYYbkIebK
         pjfA==
X-Forwarded-Encrypted: i=1; AJvYcCXjiaIdHrXvoI4eLE8po+ZQLBPtUreKPpLtYbzUFFN27qgE0U4iCZqgmAK7C2bh73DSiT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKRnSO6a4wpi1XmES2l8LBOoSLkX8vmTSP9AdJ49I0Dz2wfgvN
	46CY6QRCm5U4qFNxthLR0CbySd6X618xbzrlO2v2bC9fjKxd2uiNX7g/4OSt6FJPJ/S3xO7oHY8
	QmPeK84Fz71lshY1SUJGkPR8ptPYFnw==
X-Gm-Gg: ASbGncuxxBfpDko4cakRJDxerZpxuX0UzY1/uv86wYuLlqjcb+0cym7GJRYcaieL3U7
	BRm8ujhv6WBPkQHRDijDQ1+Y1tFNYTTwnomBVUol1CDS8y5nnfp4M6c3h1k0koLusUxjOrob8wG
	Mg89ZSWDDBRLJDDkXG8/uzKsaUXVbbzgKQZz8110Jz7IGD1KWvOw1u
X-Google-Smtp-Source: AGHT+IE6LVgS9ZGsk7mONxSUYDIHzIljrYhZZWCvf7eNoMXJ0obSM51hkXV5aQDzf1q06N1Sq4xs1E5gXJKSVqMZ++A=
X-Received: by 2002:a05:6a00:39aa:b0:736:50c4:3e0f with SMTP id
 d2e1a72fcca58-7398037c9f2mr23254304b3a.10.1743610526507; Wed, 02 Apr 2025
 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQLLOHZmPO4X_dQ+cTaSDvzdWHzA0qUqQDhLFYL3D6xPxg@mail.gmail.com>
 <20250401172225.06b01b22@gandalf.local.home> <CAEf4BzbVmUfDVEs1ndy5hr2YYA5xgt7NODjNhy4x+Syfbr1yaA@mail.gmail.com>
 <20250402103326.GD22091@redhat.com>
In-Reply-To: <20250402103326.GD22091@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 2 Apr 2025 09:15:14 -0700
X-Gm-Features: AQ5f1JpFLCEJ5LRYRWVu-Kk0PXgviRVvcA2AmozOfV8OZUpcwAg96Gtim5G60Z0
Message-ID: <CAEf4Bzb-61gDHhacpUQRJ86Fg_uiugk5MOGv8bshaxqQiABLHA@mail.gmail.com>
Subject: Re: uprobe splat in PREEMP_RT
To: Oleg Nesterov <oleg@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Peter Ziljstra <peterz@infradead.org>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	bpf <bpf@vger.kernel.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Jiri Olsa <jolsa@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 2, 2025 at 3:34=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 04/01, Andrii Nakryiko wrote:
> >
> > On Tue, Apr 1, 2025 at 2:21=E2=80=AFPM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> > >
> > > Hmm,
> > >
> > >         write_seqcount_begin(&utask->ri_seqcount);
> > >
> > >         for_each_ret_instance_rcu(ri, utask->return_instances)
> > >                 hprobe_expire(&ri->hprobe, false);
> > >
> > >         write_seqcount_end(&utask->ri_seqcount);
> > >
> > > How big can that loop be?
> > >
> > > Of course, we could just say not to use uprobes on PREEMPT_RT kernels=
?
> > > Otherwise, they could cause an unspecified latency.
> >
> > There can't be more than 64 nested uretprobes, so it will be (in a
> > very-very unlikely event) at most 64 items. And that hprobe_expire()
> > operation is very fast. So I don't think latency is a big concert
> > here.
>
> I still didn't read this code, but after the quick glance I don't
> understand why do we actually need utask->ri_seqcount.
>
> The "writer" ri_timer() can't race with itself, right?
>
> The "reader" free_ret_instance() uses raw_seqcount_try_begin() without
> the "retry" logic.
>
> I have no idea if this logic is correct or not, but it seems that (apart
> from the necessary barriers) we could use the utask->ri_timer_is_running
> boolean instead with the same effect? Set/cleared in ri_timer(), checked
> in free_ret_instance().

"Apart from the necessary barriers" is exactly what I didn't want to
deal with, tbh... Which is why I went with (ab)using seqcount lock.

Other than that, yes, the reader logic is very simple and just wants
to make sure that ri_timer (writer) couldn't have seen the
return_instance we are about to immediately reuse (which would pose a
problem).

>
> I must have missed something...
>
> Oleg.
>

