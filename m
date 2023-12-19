Return-Path: <bpf+bounces-18265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED13E818111
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 06:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D77282DA9
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 05:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612886FB4;
	Tue, 19 Dec 2023 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQD2WQin"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96C6FAD;
	Tue, 19 Dec 2023 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so2533745a12.0;
        Mon, 18 Dec 2023 21:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702964336; x=1703569136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOEZ/kyAcw5E7IQIZS6eZwGzJ5Za2VNbYxiFG0sVqhw=;
        b=NQD2WQinp7xADIHDzGX5hQpHpcBtaLAceVmsVbr1gdiqimfrFLvT4BD9bPPymrR88z
         oGhA44WuoKa9N1xXBqXNrTbmcQ0k5JVDxAOCOSdbK9n0lWWznS6zVqINrJDyUOgye89W
         +aDJbmGMDBvOC60g4/yy73nLwwzTQxuhPlEL5faMkRUHt6VWUBtSxDWn9stBIV7j5h95
         q5twIk5A94Er3t2YbtKSZqF70O5RIJHcKlgpMP8xDxE+8Zy4QE8beGeFgQK6Ky3YD94m
         6RcxM64FSdAk2yo+zMBYwK1kaoowuDX2SZ5HxzsgpfP/psSxTuyEW5XFKpIEH4NLB+p+
         Ak5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702964336; x=1703569136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOEZ/kyAcw5E7IQIZS6eZwGzJ5Za2VNbYxiFG0sVqhw=;
        b=jZcOlY3hzLPUbAwwlVil3d2R31EvVkDauUV+JZzb2aztw62vienMMZloMnaYtbe4sl
         wRv78dgS27G9szn3zUKV+D7e36YRsX7CdIGDvqAMmzGhlJ94HAeksKx/2svU65gCg+6M
         YAZM8kUqNt2FC9fTzPEYv5www3Nw8BCPJAjHXU/ns2/E89LxqE+XOjUi5dp5G91tpm0Z
         fa5qAAuni1ZA0yXTLkTXzqJk/0ZY0ETm+Icgr80uPqWDDlshxI4+2jLnMZXS0tYjtrif
         Js0PoIU4mGCnWSFDWCwWm5As/kOO+yJT0AZJ8HxKpqUV4PVHqOcyrz6WPJEPK3iLcu7u
         7LYA==
X-Gm-Message-State: AOJu0YxWL+LmZvIgoux9fFKIDLEuPvj6p0p2YGdK81v5C4rgSc6LLdGd
	8niODp83O3+Z+ore4emb3AgbBz5ykVJGFR5ZiDA=
X-Google-Smtp-Source: AGHT+IGYhykWO8fnsFDYKQHVJkekHNirjDR5gqBHYGvREq/hhrlgID9yoDptdmNNKwe848u8aW4oOkD1B+TkBcKoFcI=
X-Received: by 2002:a50:c8cb:0:b0:551:f72c:ff4e with SMTP id
 k11-20020a50c8cb000000b00551f72cff4emr5625552edh.68.1702964336236; Mon, 18
 Dec 2023 21:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231219000520.34178-1-alexei.starovoitov@gmail.com>
 <CAHk-=wg7JuFYwGy=GOMbRCtOL+jwSQsdUaBsRWkDVYbxipbM5A@mail.gmail.com>
 <CAADnVQJfyfbpEVHnBy2DDGEJvUm8K25b9NHCzu08Uv96OS8NaA@mail.gmail.com>
 <CAHk-=wh5qvbPDXUxnawwVWvoRi6fSwFM6h5rYkKmetovmOxjOg@mail.gmail.com> <CAEf4BzYtD+bp8f+NvGMfVK=nL=E+EGsvz1MGySa1h4P8vA=bPw@mail.gmail.com>
In-Reply-To: <CAEf4BzYtD+bp8f+NvGMfVK=nL=E+EGsvz1MGySa1h4P8vA=bPw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 18 Dec 2023 21:38:43 -0800
Message-ID: <CAEf4BzZDFgDOV9dxfC7g+b9QVQtA4j-_dnqnKOYWPwHbzQ5nJw@mail.gmail.com>
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

On Mon, Dec 18, 2023 at 8:34=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Dec 18, 2023 at 7:58=E2=80=AFPM Linus Torvalds
> <torvalds@linuxfoundation.org> wrote:
> >
> > On Mon, 18 Dec 2023 at 17:48, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > >
> > > Point taken.
> > > We can do s/__u32 token_fd/__u64 token/
> > > and waste upper 32-bit as flags that indicate that lower 32-bit is an=
 FD
> > > or
> > > are you ok with __u32 token that is 'fd + 1'.
> >
> > No, you make it follow the standard pattern that Unix has always had:
> > file descriptors are _signed_ integer, and negative means error (or
> > special cases).
> >
> > Now, traditionally a 'fd' is literally just of type "int", but for
> > structures it's actually good to make it be a sized entity, so just
> > make it be __s32, and make any special cases be actual negative
> > numbers.
> >
> > Because I'll just go out on a limb and say that two billion file
> > descriptors is enough for anybody, and if we ever were to hit that
> > number, we'll have *way* more serious problems elsewhere long long
> > before. And in practice, "int" is 32-bit on all current and
> > near-future architectures, so "__s32" really is the same as "int" in
> > all practical respects, and making the size explicit is just a good
> > idea.
> >
> > You might want to perhaps pre-reserve a few negative numbers for
> > actual special cases, eg "openat()" uses
> >
> >     #define AT_FDCWD -100
> >
> > which I don't think is a great example to follow in the details: it
> > should have parenthesis, and "100" is a rather odd number to choose,
> > but it's certainly an example of a not-fundamentally-broken "not a
> > file descriptor, but a special case".
> >
> > Now, if you have a 'flags' or 'cmd' field for *other* reasons, then
> > you can certainly just use one of the flags for "I have a file
> > descriptor". But don't do some odd "translate values", and don't add
> > 32 bits just for that.
> >
>
> Makes sense. Yes, we do have flags for all commands accepting token
> FD, except for one, BPF_BTF_LOAD, but it's trivial to add flags there
> as well. I'll prepare a patch.

The patch is at [0], thanks.

  [0] https://patchwork.kernel.org/project/netdevbpf/patch/20231219053150.3=
36991-1-andrii@kernel.org/

>
> > That's also a perfectly fine traditional unix use (example: socket
> > control messages - "struct cmsghdr" with "cmsg_type =3D SCM_RIGHTS" in
> > unix domain sockets).
> >
> > But if you don't have some other reason for having a separate flag for
> > "I also have a file descriptor you should use", then just make a
> > negative number mean "no file descriptor".
> >
> > It's easy to test for the number being negative, but it's also just
> > easy to *not* test for, ie it's also perfectly fine to just do
> > something like
> >
> >         struct fd f =3D fdget(fd);
> >
> > without ever even bothering to test whether 'fd' is negative or not.
> > It is guaranteed to fail for negative numbers and just look exactly
> > like the "not open" case, so if you don't care about the difference
> > between "invalid" and "not open", then a negative fd also works just
> > as-is with no extra code at all.
> >
> >                    Linus
> >
> >                      Linus

