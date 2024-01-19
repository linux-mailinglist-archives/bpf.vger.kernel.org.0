Return-Path: <bpf+bounces-19918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA14833067
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 22:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D880228928D
	for <lists+bpf@lfdr.de>; Fri, 19 Jan 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF285821D;
	Fri, 19 Jan 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REXQXrRP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BB658200
	for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705700580; cv=none; b=MleM34oSGbWwrY3VNOTovVTjaBJ87fsOaXLTXGwGx976k6SXeHLJcY0HC873nAcwB1YXrq3U9omN826uevKCzUnKiwipFx8GJauy5L2Ijtfse2ZqusGZ+z8/MwwY0vQXWo8ydpNUFlhztKaW2p5NslehPKenP9aGDhiQC7jyTBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705700580; c=relaxed/simple;
	bh=+1XkQ4doD1JxlrJ9jB0JSSGlOuEpiDnVM/o1jKZJQ1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ink2Aw2lQ/V+K8Hjx9QApeuS8AflazBT0BOycJOaPYKUw9JvlkC2Mnko2H/vGN+zAXpN2jJ3d0a6yhfqUNE4kexftNSeDaW/JgNYPF5PNRVvGSavTc3QIc5evsW7rCHTmuIbY58YLQpriu3MeBl6n5eDYjAr+2Bpag/FIvmJjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REXQXrRP; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6da4a923b1bso1062454b3a.2
        for <bpf@vger.kernel.org>; Fri, 19 Jan 2024 13:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705700578; x=1706305378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1rtBU5hKZtCQN0lLjQJXyAbr0HUVriCBstUPsOi4hg=;
        b=REXQXrRPHYfaIcF7pfiER23aADEvDuQvVM/bf7MYBGGECXT8jaNwYX+B7HYJdlpIy7
         hZvQx+DJ9V6cJgSYNz5z8nHbyW8O60F4I2/mKWlY0DoWkzBrGBLStW6nwaJVDYipLSOH
         LiERXKYuG3V1a5rRBi+spiDOSf6KrCpAy6yp2MQvpzGE4ECvAFVm0QjAsqAGIufZBg6S
         mTmKCOoRS1pVGzTQ8Gx595Er3tKrQU4hyypvuMcIkho+42hbiP8RQkS0/zuwGhvzipYD
         Zqlbwj8sVAQHtyUQl9MKnVOrjUE8Z77yo414DVZwlY9PcuA9gBGpsPts+lNmJQC7cG+7
         ZJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705700578; x=1706305378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1rtBU5hKZtCQN0lLjQJXyAbr0HUVriCBstUPsOi4hg=;
        b=GzXRhu92zrBfXo4UzJy8zYOittilCd8nVWsXi9Uyr4kpOBSBYEC30Zw/jLfe9jWOnd
         7y1FkTbp5vQpauueLcggn3KfpkJfJksyII+RlIsGye77wOTPNo1Mc4YRFHbmRKzzFibk
         6iuH47y8nGaKFw3SsvvOqKQr2bseU0jbfH2GuwqrBQ3UxrdNQunJI935ckfbZGjVQWuS
         FJpOb1g7D0YeUbAFboj33sxqn3IbEVUl/bszN8RjW83MQgDzLhaQQtZV2PzTXC26HnHA
         BGsW1SJt+P4zZVFSkJfNVsjx0s444QqNKZYlztIavl0+i5TM6KeEhh/b4odMcmFkoVjY
         UXKQ==
X-Gm-Message-State: AOJu0YzPmHFB8ptvFp6sPH0z/lUxUHl+QIYQM7NQw3OXV0SlxgkVJ2fC
	6ukY8kwHT+j4vGiHA7d9sTtEGHFXi/GlM22Hw+rPKjMSlHq91xHSeGK0ZtYkFrOQ0zov7KsgZ22
	9vaX1pN6npJAIhNAzOGY7+F/orccDzMbOTsg=
X-Google-Smtp-Source: AGHT+IHlfoHdO06Pgh+7m0we4Wt/mQUH3+EIxfhZS5NhRZ2ZL4N2CSh82y2j1DAFqzeAzMYB6QfO1EsxEcx7TxyrvGQ=
X-Received: by 2002:a05:6a20:a823:b0:19a:41ff:5f21 with SMTP id
 cb35-20020a056a20a82300b0019a41ff5f21mr412115pzb.67.1705700578571; Fri, 19
 Jan 2024 13:42:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119210201.1295511-1-andrii@kernel.org> <CAPhsuW75zzq5W4yVOpuS9LcWV9koFrHPi+z72w1zGhCr0KKoVQ@mail.gmail.com>
 <CAEf4BzZRaKsJ0T3LGxeCchSgLi6Gvs5-0pe0Ba6DQpFFSiF66w@mail.gmail.com>
 <CAEf4BzaHz3VRUs=vHC7u5rZmTHE7CTs78oYcOHripWM266QA+A@mail.gmail.com> <CAPhsuW7PZ4aMmtZrTHx-R9yyU6aJbHhmEVhxL=CB6L+4Og9BAw@mail.gmail.com>
In-Reply-To: <CAPhsuW7PZ4aMmtZrTHx-R9yyU6aJbHhmEVhxL=CB6L+4Og9BAw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 19 Jan 2024 13:42:46 -0800
Message-ID: <CAEf4BzaFrS-iM9hLngmrRzT5RR-xDLXXGSvnivuC2FRa0uTF=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: call dup2() syscall directly
To: Song Liu <song@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 1:34=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
> On Fri, Jan 19, 2024 at 1:30=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jan 19, 2024 at 1:21=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Fri, Jan 19, 2024 at 1:18=E2=80=AFPM Song Liu <song@kernel.org> wr=
ote:
> > > >
> > > > On Fri, Jan 19, 2024 at 1:02=E2=80=AFPM Andrii Nakryiko <andrii@ker=
nel.org> wrote:
> > > > >
> > > > > We've ran into issues with using dup2() API in production setting=
, where
> > > > > libbpf is linked into large production environment and ends up ca=
lling
> > > > > uninteded custom implementations of dup2(). These custom implemen=
tations
> > > >
> > > > typo: unintended
> > >
> > > oops, but probably doesn't warrant respinning
> > >
> > > >
> > > > > don't provide atomic FD replacement guarantees of dup2() syscall,
> > > > > leading to subtle and hard to debug issues.
> > > > >
> > > > > To prevent this in the future and guarantee that no libc implemen=
tation
> > > > > will do their own custom non-atomic dup2() implementation, call d=
up2()
> > > > > syscall directly with syscall(SYS_dup2).
> > > > >
> > > > > Note that some architectures don't seem to provide dup2 and have =
dup3
> > > > > instead. Try to detect and pick best syscall.
> > > >
> > > > I wonder whether we can just always use dup3().
> > >
> > > dup3() (according to my git foo) was added in 4.17, which is more
> > > modern than some other usable BPF, so I don't want to just randomly
> > > bump the minimal supported (by libbpf) kernel for something like this=
.
> > >
>
> I believe dup3() was added in 3.7.

True, my git-foo isn't careful enough, 4.17 is when dup3 kernel
refactoring happened. bpf() syscall was added in 3.17, right? In that
case, yep, I could have just gone with __NR_dup3 directly, I suppose,
but this version should work well anyways, so I wouldn't bother
changing it.

>
> >
> > Btw, this #ifdef check is the same as what glibc does for its
> > implementation of dup2() (except for fd equality check which isn't
> > necessary for libbpf), see [0]
> >
> >   [0] https://github.com/bminor/glibc/blob/master/sysdeps/unix/sysv/lin=
ux/dup2.c
>
> Yep, this looks good.
>
> Thanks,
> Song

