Return-Path: <bpf+bounces-50130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4215BA231D1
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF5A3A280C
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 16:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2381EE7A5;
	Thu, 30 Jan 2025 16:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKBUF8Kf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201221EBFF5;
	Thu, 30 Jan 2025 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254579; cv=none; b=ho4dGrMMTpV5IxmqhAnYu2ogkSMqv/GCzlFxdTLzuVPMUhT1UmNSaLvuFYuQir/sFScsSvKSErmllI/mCZplfJIEhYVevSKsggpy7pKDGbKl2JhtJ6m9kcfj0lxwku/4oZLl6b3QtMl6Q5CEjsm7HIxWmOUx4zkyrkoqZMUCkFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254579; c=relaxed/simple;
	bh=wV/Q4iMIyNa09eZLXS9ucj44Nq4AD7AejWCP2xM+dVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfY+rU+yXvvbF4CPwiAJlI5f/NFrYzI7aMETgHSt+F8SEZXs1Rrk/jn2y+Eh5rs7lStY1cXMHDdbmLDWSQoTHQcDQZiOWZSWVPswZcBjYEBXp5+XFMInXDHQ981qjjkKOOMJPTE0Ct45boxM6cvxrnnGACj9T+oGNbQHhhnfIaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKBUF8Kf; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-2b33aabfe46so388002fac.2;
        Thu, 30 Jan 2025 08:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738254577; x=1738859377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wV/Q4iMIyNa09eZLXS9ucj44Nq4AD7AejWCP2xM+dVo=;
        b=LKBUF8KfJs+mGVroF5YcSvUhHCs8X7IKB+CzGesqhxu14K0HF+lyw6Mjq9dQcK27I7
         lP4VRAQTpMqVRrfR5s4wjW6EEQ6ZiHwhuDiVxYK7uVhmQCJvoe3Z9jwG+MkvOGL90xRo
         HE3VVo/CnSgLrwVC6v/Huio8sZbgUX9ROAZuhbcMTeZQ/gE4QrQ87IjqciF7ReyRznXr
         kcURbIvQJd9+RB/LDlXkhKOYABYKi7PWOhy+Gtzko2tbq31fiO3H84GV6CkgHNh3YSDE
         42GHJmNQa3MkO3Z8q5NdOgksIylqDrXn+vw9rchxZtAH50svW1jHD55ArfvGpxylDsXv
         znaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738254577; x=1738859377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wV/Q4iMIyNa09eZLXS9ucj44Nq4AD7AejWCP2xM+dVo=;
        b=aqBSue2j8/xT0eNjMNysFVGx19xrg6Rgb30lmsYRZmupaAQsjBdStApqOmm87OQ8Jd
         1TGjqPmw0XrU2DcAu5oRje19m9aTdfwZYD28wH1q3SzYtEiCp9RN5yxSJ9cMFdOhDfPD
         8eRyH1hdB8cEM0FPRgp9d48DR0SLZynktstBVLGwSjzDKLy5W2+gmvXkVOtLtnP2mHs8
         kEtCkzS65GOfJsxqVhZMlm3MYntwO+tkIhLXK+1WbtXRTBTCWgWWvz4gQB3a68Vs6PUB
         9QdTZBfRNA/iCQ48IIFndhlQICh7S/FV0DCk7GriG9dx3g45bG8K7Ev8nCabaAatw6oF
         MGwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3G6OJka3A7DySYse+evSaqi8DH4TXMhFjH1517bX2OJ71RAhZ7L31KUYWLiCHvLFi8qRdRPWIX4PVvodw@vger.kernel.org, AJvYcCUHGWeX+n5sbZ1YIlwoCXCiY5zBzGBmFt+mFCVqbZGXk8LE1ARTbNJO8kj1x6PfegvVEOo=@vger.kernel.org, AJvYcCW2Pf7MZMLagU2cu4/xfWIhnkGH2JHlipMq58mf/sd+e2IcotJzSvx+O9HGWtZW09NkB8SgGCJjc/Pt@vger.kernel.org, AJvYcCWTt92WVHqA6URj7omATtFpg1NadXUwIJBQKFeo4v+yHV+FTC2+Zvxfb/+dxYzZBow7P8r7XqAf@vger.kernel.org, AJvYcCXc7ttGFgykYGtBMI+zIfFiHQ0bsVy/vVThLWpJ2hn/wxhKyFt8seH+q06gSwTDDdu9OKUTmGbl+LdiF3IenOUwVp2+@vger.kernel.org
X-Gm-Message-State: AOJu0YxavZHDTTAfQJfG9VT7CtIs1U6XhgRO4TIaGicNMK3yP9Oj/+0h
	goVZ+iZ5n73eCvfzFEA/lVpYYSZjdnrJbhHRjmV9x9ISbKDmUOXERmM6cXqL97EgpXaqKfrbhIz
	IFlLNjD3i5NC89eceMcHEjcUm3fI=
X-Gm-Gg: ASbGncvsRb7vqQpplHYn4XZX4YneMwBnTiJywvkf9G8Q1uFePQWBKUmomy6st78A+PT
	F4LZtXs+nMPhcZexwM5xjzOoL/Fehki6aLOO1a3eCyY5MnHGObkZcR6p1Bz44jL+p7MaWr0M/
X-Google-Smtp-Source: AGHT+IFLXKEHXdRPQKtUlKTpFBClwElqtFujRaNDgCR0uhVSeBfcTyfd9C16ez7NSn2yoATksDGc2lFC57sQlENrOYs=
X-Received: by 2002:a05:6870:3d97:b0:29e:5894:9de7 with SMTP id
 586e51a60fabf-2b32f2db94dmr5035404fac.33.1738254577059; Thu, 30 Jan 2025
 08:29:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com>
 <202501281634.7F398CEA87@keescook> <CAHsH6Gsv3DB0O5oiEDsf2+Go4O1+tnKm-Ab0QPyohKSaroSxxA@mail.gmail.com>
 <Z5s3S5X8FYJDAHfR@krava> <CAHsH6GvsGbZ4a=-oSpD1j8jx11T=Y4SysAtkzAu+H4_Gh7v3Qg@mail.gmail.com>
 <202501300756.E473D10@keescook>
In-Reply-To: <202501300756.E473D10@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Thu, 30 Jan 2025 08:29:26 -0800
X-Gm-Features: AWEUYZkFf6jiFjy1lLBN3N8px6ZFQpM6-6omMJVzu5RFALoYk-pKTHZMkVyiPjY
Message-ID: <CAHsH6GtmcDFzxtju1qpE9nyXya3JkKXcyGfvE1MS4UtdyRsHnw@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>, luto@amacapital.net, wad@chromium.org, 
	oleg@redhat.com, mhiramat@kernel.org, andrii@kernel.org, 
	alexei.starovoitov@gmail.com, cyphar@cyphar.com, songliubraving@fb.com, 
	yhs@fb.com, john.fastabend@gmail.com, peterz@infradead.org, 
	tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, ast@kernel.org, 
	andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 7:57=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> On Thu, Jan 30, 2025 at 07:05:42AM -0800, Eyal Birger wrote:
> > So if we go with the suggestion above, we'll support the theoretical
> > __NR_uretprobe_32 for filtered seccomp, but not for strict seccomp, and
> > that's ok because strict seccomp is less common?
>
> It's so uncommon I regularly consider removing it entirely. :)
>
> > Personally I'd prefer to limit the scope of this fix to the problem we
> > are aware of, and not possible problems should someone decide to reimpl=
ement
> > uretprobes on different archs in a different way. Especially as this fi=
x needs
> > to be backmerged to stable kernels.
> > So my personal preference would be to avoid __NR_uretprobe_32 in this p=
atch
> > and deal with it if it ever gets implemented.
>
> That's fine, but I want the exception to be designed to fail closed
> instead of failing open. I think my proposed future-proof check does
> this.

I think it does. I think the code in the patch does too, since it
avoids the special handling for compat, so defaults to the existing
behavior which blocks the syscall.

Eyal.

