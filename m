Return-Path: <bpf+bounces-47156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B069F5BDE
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 01:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B606188C014
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32CE35963;
	Wed, 18 Dec 2024 00:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKdeyfPr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4B72572;
	Wed, 18 Dec 2024 00:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734482875; cv=none; b=VK81JG3+khTuYs820d99XhtU4HqaodFTktjVgX+VY0j69H4zWvuQw7tYCy8nSbdJhrDLJ2lJgYodZwk+CVbC6CKfKr/KJqclSsYkWHAWtyyq6r6dyhMt9bWr1/Thfbh/HNQzaJYOXBaVrS1ojV7g25jK1Ulc0ggLZIWqXruSaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734482875; c=relaxed/simple;
	bh=KQ+HBAGERRr/yp9OBPyiFOJec3Xp4ePEwJ2LYGf/aHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twwm1rBJf/OjZbgROrJY3oKkb9GaxrHpcUdMPurHb9lqVT6lo1cKetiI+CHDzTUaxIfxP7m9O/vYb60KD6IH2utXr0zqW7FG2AKjSmieVf805dxnW5hMFch7mxL5bVygfX2xIN5xn9mtw/XRYisTgEgFmbr5XtqweiYK7wsZ05E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKdeyfPr; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4364a37a1d7so14092505e9.3;
        Tue, 17 Dec 2024 16:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734482872; x=1735087672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASOdFS0cu/fXgaUOX6iTEniwsKliNWJnjKj8jwFHdkM=;
        b=aKdeyfPrkPx+z4D8LWbsfWZVtZTzENLa4R78wUlFekoka3o1V1ezDitJ43BPve5mG+
         B42y8Hs4InHoHnfsn+QOusnU0lCMEuRggfM+R9+DJl74Km2QsFn1o5qbUinoR+y74DJq
         QUdD5tTL9/xqrJOOsxuz0BoNbRV4kmfwkVAmLV3wHomCpV+9RpnA8OxFE7WjW5Sf5s07
         dVqlmkqiYW2naDhHt3JUPmdUmlzJ4O4yJ0eKUx/otxHoS3PIP+iJIcS2RxNnUFgXcZgt
         7NdFt5B11/L2jOifi0zqLJr4g79vmEi2/z39oysDreAbo9yyrLUx7aHAZANeUDRSWtz+
         /Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734482872; x=1735087672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASOdFS0cu/fXgaUOX6iTEniwsKliNWJnjKj8jwFHdkM=;
        b=T/s9z5bPITFP/h7TpB3nI42jnvdG0QUDqehkyz+Nh93wq/GdaZ1stDi27RaRkkE13F
         JplGdfIb+0uJM3PtCxgXF92SVon1E/GiMdz3ThKF6+ynbR1CwsdNYv+DzJaFfDuf6+uX
         oAJGLKLl4ElsgexTzdpIuQX5GJl/WRVzQIWJCV5/9mCRRGtSSPGynLACW09CiEMY2lni
         m1ShMWsOnMxL2rIemQWEo01DpCRED+kIUapoex+iImQ2fRxc9Cha3P3DkMXzXT9x2j22
         eS3//ntNeeYpT/j0cEfPR/rDoCZkZNzdGZmc+5YWUcKVFhtWZdj3RMD6rhsbXXr/hnja
         Vq6A==
X-Forwarded-Encrypted: i=1; AJvYcCUBeqvoKd3ddOaIJinB163XfJa7L/preSYGX0aj4ined/hfEKgqww9CrkhYYVbPnng3lrJM04Rm@vger.kernel.org, AJvYcCVyXWFF8TqcGfSLgFig0xnH8GwC317tLPn9j1E+QXKs4JOsYDZVFP/A/W7vzbXPriaSoo6LJuKjpiyvdTky@vger.kernel.org, AJvYcCWsi8kRajz+CXiSiEE98qfv7CFtq48WaJ1KEjO1nrdMLqv5FhnZ0JWIr7lrgeev8e3SBOQ=@vger.kernel.org, AJvYcCXIxUrRNcjb1Nmg+XejwaT0jYe7szNG0rW335EKCa2VK4W3pT8i7FwDZWmwrJgVv082Hp0PRijXbXOcbmoIyKDqm9gR@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2FpoZaxwii7lmWaV/gBtnsGVN7FVB8W+cvGVcRPOWMX8er/95
	L55Qn2IrpnZdzZwNTsqLcdLcxFoCr0rnEYnZKr7hqWXAo21OMSdJznWWLtvzjLeG/3aEB6SLQvx
	/qHYa+2p8frvOHmbyZTrAwEX1BJ4=
X-Gm-Gg: ASbGncslnZMxgbCpRIE28+oMfJh+HYGtaUHTRqADmXlEhKML+EMJASZujhqW3HCfXEY
	Z0d5dIiXLhPykdNEU7Hft71uIh7RRXEIfI1glNSvIe7aSDlwLnWgliA==
X-Google-Smtp-Source: AGHT+IHJDqFahN/Bu5F0MoDExKrwJ4OswuvdxiA3Bb0fdGQ/+sKuZObznFi3CtsnRFTbe/QjjqG5tHF/QC4+1CnYnSI=
X-Received: by 2002:a05:600c:474d:b0:436:51bb:7a53 with SMTP id
 5b1f17b1804b1-4365535eb12mr5328575e9.12.1734482871993; Tue, 17 Dec 2024
 16:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217173237.836878448@goodmis.org> <20241217173520.314190793@goodmis.org>
 <CAHk-=wg5Kcr=sBuZcWs90CSGbJuKy0QsLaCC5oD15gS+Hk8j1A@mail.gmail.com>
 <20241217130454.5bb593e8@gandalf.local.home> <CAHk-=whLJW1SWvJTHYmdVAL2yL=dh4RzMuxgT7rnksSpkfUVaA@mail.gmail.com>
 <20241217133318.06f849c9@gandalf.local.home> <CAHk-=wgi1z85Cs4VmxTqFiG75qzoS_h_nszg6qP1ennEpdokkw@mail.gmail.com>
 <20241217140153.22ac28b0@gandalf.local.home> <CAHk-=wgpjLhSv9_rnAGS1adekEHMHbjVFvmZEuEmVftuo2sJBw@mail.gmail.com>
 <20241217144411.2165f73b@gandalf.local.home> <CAHk-=whWfmZbwRmySSpOyYEZJgcKG3d-qheYidnwu+b+rk6THg@mail.gmail.com>
 <20241217175301.03d25799@gandalf.local.home> <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
In-Reply-To: <CAHk-=wg9x1Xt2cmiBbCz5XTppDQ=RNkjkmegwaF6=QghG6kBtA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 16:47:40 -0800
Message-ID: <CAADnVQJy65oOubjxM-378O3wDfhuwg8TGa9hc-cTv6NmmUSykQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] ring-buffer: Add uname to match criteria for
 persistent ring buffer
To: Linus Torvalds <torvalds@linux-foundation.org>, Florent Revest <revest@google.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Alexei Starovoitov <ast@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 3:32=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> If the *only* thing that accesses that word array is vbin_printf and
> bstr_printf, then I could just change the packing to act like va_list
> does (ie the word array would *actually* be a word array, and char and
> short values would get individual words).
>
> But at least the bpf cde seems to know about the crazy packing, and
> also does that
>
>         tmp_buf =3D PTR_ALIGN(tmp_buf, sizeof(u32));
>
> in bpf_bprintf_prepare() because it knows that it's not *actually* an
> array of words despite it being documented as such.
>
> Of course, the bpf code only does the packed access thing for '%c',
> and doesn't seem to know that the same is true of '%hd' and '%hhd',
> presumably because nobody actually uses that.
>
> Let's add Alexei to the participants. I think bpf too would actually
> prefer that the odd char/short packing *not* be done, if only because
> it clearly does the wrong thing as-is for non-%c argument (ie those
> %hd/%hhd cases).

We reject %hd case as EINVAL and do byte copy for %c.
All that was done as part of
commit 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_pri=
ntf")
that cleaned things up greatly.
The byte copy for %c wasn't deliberate to save space.
Just happen to work with bstr_printf().
We can totally switch to u32 if that's the direction for bstr_printf.
To handle %s we use bpf_trace_copy_string(tmp_buf, )
which does _nofault() underneath.
Since the tmp_buf is byte packed because of strings the %c case
just adds a byte too. Strings and %c can be made u32 aligned.

Since we're on this topic, Daniel is looking to reuse format_decode()
in bpf_bprintf_prepare() to get rid of our manual format validation.

