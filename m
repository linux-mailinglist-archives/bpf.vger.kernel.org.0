Return-Path: <bpf+bounces-18262-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E9981809B
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 05:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37BB11F24DC2
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 04:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958B5393;
	Tue, 19 Dec 2023 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AphmGxK5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7976881E;
	Tue, 19 Dec 2023 04:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50bce78f145so4661359e87.0;
        Mon, 18 Dec 2023 20:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702960474; x=1703565274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQnVdT8TAqanmt9KBHWN/7vTsZ0/DmtNv9yeyjWpDJk=;
        b=AphmGxK59HcP/eNge6zw+GjZCxhhtDdnQN2hYQvc0gzPkWwfeHew9gS0nmCSPFTGp/
         +UasiIb1sPcWZsQtqN0MDz14Zk8TFVI/vaCklNrvpALfb5Sb8iyXSNu2tvsq9xt/70D9
         gLWDcxmHFQizKBkYtftZGU0NDYbkDJVmlaf88P/nI6m+w4w3NtdpIzFdc9tN9ylN0SAo
         +BCfLdWfUbYk+NO6HXszyAKFeBTRBQNSHKgRVKso8yHWx47AQh3OyJjQqYYjWf+5TK+f
         ZLEVV8j4doFhIq2Pm/dB8J6D+E4rmyIxI7tLsunlqiQ3N/pfLOJsa/T98hR+Ql6uzq1S
         LVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702960474; x=1703565274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQnVdT8TAqanmt9KBHWN/7vTsZ0/DmtNv9yeyjWpDJk=;
        b=ll41nOvPLHfCGvoUAQmm0pPg9YYmgfbm1DvieZAA7vRe//DaikENFbWMc+lOVByuN/
         5zPefh3i2SyrlRhl46waS80yUOgpNREfLtJsF/LZ3y71HpJXUoyuxQ2loeayag7j2Cad
         Mc4P61sOD383Sc0ic/PFJHZK2zv/4uivdyueCJ/6+nCVGQb/smIzw/325ZMKUAynzXnN
         284o7L2WQOD/fuyLbnNUgFcJjmWzQrEyFfPFNci7t/h8OBZHMjHt3v0qsjjANPkdtnig
         qXAMfrKymevY3+ms2iaZDB0lGwITnaIHP0KNfZYYV/W+BhMvJtwHlJfdWx9GH7QmoesH
         v55g==
X-Gm-Message-State: AOJu0YyAoeTqaRnZRw6XbAhqnAOaEllA2CP9dMDjUpkewr5ppA0X+nXH
	m6IIQ8vZ8eg+QwVOiACWegDtcLP4oJzGyIgXgiE=
X-Google-Smtp-Source: AGHT+IFkNiKbTthddsll2o4N0tmJMZVLkWD/G9YLsvH/D/cWDRfvkvjL7tfXbSF1LakP94wjB1T8SuajZO7EYKMpudI=
X-Received: by 2002:ac2:5931:0:b0:50e:3f39:69f3 with SMTP id
 v17-20020ac25931000000b0050e3f3969f3mr389386lfi.195.1702960473569; Mon, 18
 Dec 2023 20:34:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com> <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
In-Reply-To: <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 20:34:20 -0800
Message-ID: <CAEf4BzYtD+bp8f+NvGMfVK=nL=E+EGsvz1MGySa1h4P8vA=bPw@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-12-18
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Christian Brauner <brauner@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 18, 2023 at 7:58=E2=80=AFPM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Mon, 18 Dec 2023 at 17:48, Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> >
> > Point taken.
> > We can do s/__u32 token_fd/__u64 token/
> > and waste upper 32-bit as flags that indicate that lower 32-bit is an F=
D
> > or
> > are you ok with __u32 token that is 'fd + 1'.
>
> No, you make it follow the standard pattern that Unix has always had:
> file descriptors are _signed_ integer, and negative means error (or
> special cases).
>
> Now, traditionally a 'fd' is literally just of type "int", but for
> structures it's actually good to make it be a sized entity, so just
> make it be __s32, and make any special cases be actual negative
> numbers.
>
> Because I'll just go out on a limb and say that two billion file
> descriptors is enough for anybody, and if we ever were to hit that
> number, we'll have *way* more serious problems elsewhere long long
> before. And in practice, "int" is 32-bit on all current and
> near-future architectures, so "__s32" really is the same as "int" in
> all practical respects, and making the size explicit is just a good
> idea.
>
> You might want to perhaps pre-reserve a few negative numbers for
> actual special cases, eg "openat()" uses
>
>     #define AT_FDCWD -100
>
> which I don't think is a great example to follow in the details: it
> should have parenthesis, and "100" is a rather odd number to choose,
> but it's certainly an example of a not-fundamentally-broken "not a
> file descriptor, but a special case".
>
> Now, if you have a 'flags' or 'cmd' field for *other* reasons, then
> you can certainly just use one of the flags for "I have a file
> descriptor". But don't do some odd "translate values", and don't add
> 32 bits just for that.
>

Makes sense. Yes, we do have flags for all commands accepting token
FD, except for one, BPF_BTF_LOAD, but it's trivial to add flags there
as well. I'll prepare a patch.

> That's also a perfectly fine traditional unix use (example: socket
> control messages - "struct cmsghdr" with "cmsg_type =3D SCM_RIGHTS" in
> unix domain sockets).
>
> But if you don't have some other reason for having a separate flag for
> "I also have a file descriptor you should use", then just make a
> negative number mean "no file descriptor".
>
> It's easy to test for the number being negative, but it's also just
> easy to *not* test for, ie it's also perfectly fine to just do
> something like
>
>         struct fd f =3D fdget(fd);
>
> without ever even bothering to test whether 'fd' is negative or not.
> It is guaranteed to fail for negative numbers and just look exactly
> like the "not open" case, so if you don't care about the difference
> between "invalid" and "not open", then a negative fd also works just
> as-is with no extra code at all.
>
>                    Linus
>
>                      Linus

