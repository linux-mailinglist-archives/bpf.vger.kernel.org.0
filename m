Return-Path: <bpf+bounces-76920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63418CC9994
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 22:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 952593009FD2
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307230F53B;
	Wed, 17 Dec 2025 21:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iDckZeEh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7341DDA18
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006838; cv=none; b=PUh9thti65rJ6tUrmjbV8fOcjxfZKoHfSxb7+MWo8gp5Oc4JTz/G0LOYkH6Gzk2j08LdHEJA/z+6/If7wzLCp6P84uBYY2lmWufGlMpsWJxDK6LfEs3uid324cpvhTYJSJ6jc1pIoDlJxnqgiTCdr+zcY8ArS0Efc6MGCagmnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006838; c=relaxed/simple;
	bh=K7iZWdtW2/w62DwgtSL7SxQLAuGUNCmkD7+Ao/Izk2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzQrJDFYPhvXF3gIx/ekCqAj3gWXLou0dSCb9mHUzxK0rHyDzk4l7FNCETH/u7cSzZF8lJxahu8TCU+czTEhq6EOohB4bLzKeTVwk1SWSYJD2CpwQcq/HIzOLkhqG87A0Oa11XIraSFa2kbQHexjic+GukeCYvDQCSu98JLecCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iDckZeEh; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbc305552so3802966f8f.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 13:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766006835; x=1766611635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7iZWdtW2/w62DwgtSL7SxQLAuGUNCmkD7+Ao/Izk2c=;
        b=iDckZeEh5TKLLsYNSvjbgcJb1m9Q/iUgZWTOfZ+Q3y+N8ufL7IVFq40Nx2aWYBN9od
         qjWaSyDzV9KCXyKkzCLM8d0XFNVDhMXKgE55kY8MhadmljQkv0B2VaKJfULEdhWsLIMK
         rCwRc3OacXiUsnt6PrHOdGsiD9S6ka2sjRjvvTj1DyT3qRaEy76KXkvNN14Y2mmf2/EJ
         DmnKE/wHB/Q2DuvqAR6RcOwzRQaRX27uqWdiJEquAOrDvS12PUb9llzL2N9HOdIx7GSk
         Lku/9IvQ7/CaxHL7v9LFP6+URqFzUpgURj8vHsXys2GjEpewNpf1wDoWLdJmW2FNHZyV
         CM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766006835; x=1766611635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K7iZWdtW2/w62DwgtSL7SxQLAuGUNCmkD7+Ao/Izk2c=;
        b=mcJvUVCS9WGonZsTMk9A5EeJfsrzIafpxRFNgB09J5Wm7CrM6tYVHOrWARahJKXrXX
         aXu11gd6vWoGKsrZpT6Ni2JDy7G6LVhv3RxwAcKBTt1cRmmc5h3L8t7Ae9we8Rk278Xw
         DokfTj6uRCMfi01j+96LlLXiBACoUgwzYaBCw7+LmW72t39zQwz2c4Jj9l8VwG/ktYoD
         4QE842RcJhFPhXbsdg+3nGfCiPfwVXiVN0XmViNgeXqiP0p82GVDCBBQE099POCot6E3
         KHU2XJbuffrF97saPHS4ntIMicUaDNQIDuXdYdwj7NNyIKP7BEp6CkfuDyJR+UPcLzhC
         z4QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAKI1T2Rjh72PhNM4O4BfZXoX9xuaZpanAGCmi1uawnH5EDjItr6U6yYERqLgkIr9Y228=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn9SPS5cLTKvM1i25182VSIYTeaRpXgiWpLiMkDgz23o3B4f6y
	MOuBNnovQWS/5s+8SX/6gnTLrAk7XSGuF4Opha8hyDdVpTbjbkC6Wcuq8eQkNl+zwojE3VNCC8R
	LCzENks512PAFGkcuBOGOWP5HV8AypTM=
X-Gm-Gg: AY/fxX6+0Dd0VSvVgcRKInG0zJEAVlb+Qv6nPQ02Wq1oMkdM8ZLvTG/0YuZGH4y1jzM
	+CVecWCtqvbfhJKYWTadP4S5w0Wh9MuZbbR4SBewR9qXvbK6DsYOmgyzECI1DvX7tPm291ILpnJ
	2ai/P90s0+GpsmtkHdsLqjSh1qd8klILlea8kKw+zBYqDJ9ovWdY+v3oAPxfp214Vs3NZjAfH5f
	OrMPpdknYr+KmAXVTyTMQnOJJcaPEsQuVwE88CH20hfZ+nO5QDg5GFAclkhQQSLrf0CLWIJ+lq3
	cyu0a+UFkLYxUfJBUuZObLiFXvwn
X-Google-Smtp-Source: AGHT+IH7DwtjRqxznRVZn2F83/UvTVe0KFXw+W5+esMXJztC1ZJkvpI2tcp0w2q0v9Y9yC/zIKx+sHWOE75qkBrBCxc=
X-Received: by 2002:a05:6000:24c9:b0:431:327:5dd4 with SMTP id
 ffacd0b85a97d-43103275fe5mr10536706f8f.46.1766006834558; Wed, 17 Dec 2025
 13:27:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251216171854.2291424-1-alan.maguire@oracle.com>
 <20251216171854.2291424-2-alan.maguire@oracle.com> <d5a578c01f8a2d4d95ca16e0a9ee5b9bfce1c30e.camel@gmail.com>
 <9a096b2a16d552031a12f3f4f5a2c725212df5e6.camel@gmail.com>
 <b535b47a-519e-4138-861b-c16ed7fa0bcd@oracle.com> <CAADnVQ+EyYO+aOZewNQwETr5rphOCp6jJQH_fw9GqjVFdQd19A@mail.gmail.com>
 <CAEf4BzbWZtRdKCGwhjRV9MOufTC-coWFSU5sRtk4gdm9S_bg+w@mail.gmail.com>
 <6ae6dfd8-3f73-4318-93c1-97541d267a28@oracle.com> <CAADnVQ+wNPbbA0e4+6kx+LtOH=09jJyiYcEKZfc8kt6UPnq=EQ@mail.gmail.com>
 <535846f7-4cc7-4b12-aab4-52e530d04706@oracle.com> <ae6c6e50b3176d4ee4cce4cda09807a05d103fbf.camel@gmail.com>
 <3071012cc1e8d6bdf16b13d371a12cb201c502a7.camel@gmail.com>
 <b65fd7dc-fbad-4a96-8eb8-f36f8f518d44@oracle.com> <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+3cryZAEwC_O7xgm3=cthZU-SNsUWfGH8OpSwc+3vaw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 17 Dec 2025 13:27:03 -0800
X-Gm-Features: AQt7F2o_YLM5wjOwN-IHTvPFcGS_WMZ6ruGJZxi6x0CBXRB9nS50a9ouLrLbF90
Message-ID: <CAADnVQJ1V1vwPVnhyE4OfOSQt_BnB3wRW9g9_bhkdu-QZyuQkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: add option to force-anonymize nested
 structs for BTF dump
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 17, 2025 at 1:02=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Dec 17, 2025 at 12:50=E2=80=AFPM Alan Maguire <alan.maguire@oracl=
e.com> wrote:
> >
> > On 17/12/2025 19:35, Eduard Zingerman wrote:
> > > On Wed, 2025-12-17 at 11:34 -0800, Eduard Zingerman wrote:
> > >> On Wed, 2025-12-17 at 18:41 +0000, Alan Maguire wrote:
> > >>
> > >> [...]
> > >>
> > >>> So maybe the best we can do here is something like the following at=
 the top
> > >>> of vmlinux.h:
> > >>>
> > >>> #ifndef BPF_USE_MS_EXTENSIONS
> > >>> #if __has_builtin(__builtin_FUNCSIG) || defined(_MSC_EXTENSIONS)
> > >>> #define BPF_USE_MS_EXTENSIONS
> > >>> #endif
> > >>> #endif
> > >>>
> > >>> ...and then guard using #ifdef BPF_USE_MS_EXTENSIONS
> > >>>
> > >>> That will work on clang and perhaps at some point work on gcc, but =
also
> > >>> gives the user the option to supply a macro to force use in cases w=
here
> > >>> there is no detection available.
> > >>
> > >> Are we sure we need such flexibility?
> > >> Maybe just stick with current implementation and unroll the structur=
es
> > >> unconditionally?
> > >
> > > I mean, the point of the extension is to make the code smaller.
> > > But here we are expanding it instead, so why bother?
> >
> > Yeah, I'm happy either way; if we have agreement that we just use the n=
ested anon
> > struct without macro complications I'll send an updated patch.
>
> There is a little bit of semantic meaning being lost when we inline
> the struct, but I guess that can't be helped. Let's just
> unconditionally inline then. Still better than having extra emit
> option, IMO.

tbh I'm concerned about information loss.

If it's not too hard I would do
#ifndef BPF_USE_MS_EXTENSIONS
#if __has_builtin(__builtin_FUNCSIG)
#define BPF_USE_MS_EXTENSIONS
#endif

and it will guarantee to work for clang while gcc will have structs inlined=
.

In one of the clang selftests they have this comment:
clang/test/Preprocessor/feature_tests.c:
#elif __has_builtin(__builtin_FUNCSIG)
#error Clang should not have this without '-fms-extensions'
#endif

so this detection is a known approach.

