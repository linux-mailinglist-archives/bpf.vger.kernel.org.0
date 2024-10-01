Return-Path: <bpf+bounces-40698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FE398C448
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 19:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32741C21AFE
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6360E1CB317;
	Tue,  1 Oct 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mH2ZyUJU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A223C1C6F54
	for <bpf@vger.kernel.org>; Tue,  1 Oct 2024 17:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802973; cv=none; b=uTpbdx5jYVfBthUeFkVZstbamjY6kG48oOAc63k8vwyzNVzRRSXGRJG/9G2lwyUu8C50kmdPGomFOfPI1M6kZ5fVDmIHXjrRXAmjdJ4prLheYxONUZvddnwXyz6cTaYEEuw/P2AUheK2Dlf7nZbMpBpG3pc79z4f44Ta/cnsUHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802973; c=relaxed/simple;
	bh=y/IsXrlNLlhrgxuWnzh8HyOnKc8NHmI9PROm2fuuY4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Irscem63/0qa+CkSfjM38XbFdsCwAWc7NnPXWbZ0jq2BkOjpUc/5uyjyVtAXQBhXY03O3AhBZfFsi1UvMBQGHJh5mghpDtBM8q5LEae67XN2dZlEzBcOUgT5gqgyggQdaf8j+gjR4hiE7UOjO9mTduJPE0JZI2NLGqzKfI1NHHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mH2ZyUJU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso10744a91.1
        for <bpf@vger.kernel.org>; Tue, 01 Oct 2024 10:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727802971; x=1728407771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/IsXrlNLlhrgxuWnzh8HyOnKc8NHmI9PROm2fuuY4E=;
        b=mH2ZyUJUISdI3lkAZQC1sJxZgS7vAOor1JhJbfbcOINKn6J8zEcqmN2LBowN9GsP2U
         wvGgI9xX+qgnTJKGyxl7iEvZPYPnmrIs+75RPYzdKZdUMDgsfSEBP7tCqVQOv4l6gqfe
         utKdF4pk1EWakrCX3QVkHia3DNyRMc6k6bnQL6jMKv9eF8RK7CFPa8QwoTV6iRGiyPaT
         Fl6EkmT364jj9dXKhyggwmOy/1XXh1/BV4ukkOwiGb3aybOuNugwKTrDyxB6C8vmRnwc
         BG+IMuux/bsKxcpW0FAYhJ2gIow9bmvRiE6dERS9tZh0Ry2esscR9Avaz83Pf79Ca+k3
         Ti4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727802971; x=1728407771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/IsXrlNLlhrgxuWnzh8HyOnKc8NHmI9PROm2fuuY4E=;
        b=rh1G4pX7CsRL70VFzqLRFXRhrvGKiGw5oIynB6dyDVKEGT+ENM6UL3c4FUw3IiItuE
         Ozf/V5oonYTz5a5Bfx9wabH0IODcgzRDT0WvjGcrIZ9yTmEpp6HnhJcNdPP1xtqT5Qpm
         6LIvcaJho+Dd+RquoJZqU/0VrPCNHj5LVLzb3HtG2g3eoDM0gP+fQyhiMxWXCMw4Y1Xg
         BxKytCK5LmsZ1oUeY/TuRryPPRvkyC/F3/J7CzRVxmQl3k9uKky0BrkACrSrsSFKmkR5
         r2Lj6sGK8IHtdhI2S57KhD6r/cQOxDBa+Oi2FqmYPnNWoj5iwg1qgQSpSjGzH21Fxxv0
         SWhw==
X-Gm-Message-State: AOJu0YxYQ8HtUxRz6hDP2SXeKDnCLlEJMVlA/v5v7fQJwLncEF426wkC
	GYtXSd7hxdr7TJf4+ZKsFDmxBBP/BgsL96TtpEUN739L0+0PRoqK9qBz3k7apXkK98JzuzkL3L/
	lv0EwRCflB8a2QAQexhLDLuHW7URK8w==
X-Google-Smtp-Source: AGHT+IG7DJB9cUO+osLhAoq3IySoK2mY9FdYwabTmKFpJmDR/sIiqT7ZeJyi1ak7fQcVEpvvJAMaIwzmbeF5VL9pb6M=
X-Received: by 2002:a17:90a:e397:b0:2d8:8a3a:7b88 with SMTP id
 98e67ed59e1d1-2e15a1e61c5mr5965276a91.6.1727802970922; Tue, 01 Oct 2024
 10:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+KXx0WsH1en-DNXLf4mc4bC7apK_U9js0KbFSfp8Jdm8K8W9w@mail.gmail.com>
 <CAEf4BzZjmz7dqOe--MYAV8F=h-RAhfnhHmW66W56GZeCKjVOww@mail.gmail.com> <CA+KXx0WOmany6RdE8uaYMiCHd6FPNfXC3RxUfd-zE4UBaiO5Rw@mail.gmail.com>
In-Reply-To: <CA+KXx0WOmany6RdE8uaYMiCHd6FPNfXC3RxUfd-zE4UBaiO5Rw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 1 Oct 2024 10:15:58 -0700
Message-ID: <CAEf4Bza-u3McAGryqsYvNFULBH0DEsEEveDV7AdQWBCNJG4VxA@mail.gmail.com>
Subject: Re: QUERY: Regarding bpf link cleanup for invalid binary path
To: Abhik Sen <abhikisraina@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 9:06=E2=80=AFPM Abhik Sen <abhikisraina@gmail.com> =
wrote:
>
> Thanks for the reply.
>
> Yes you did understand the concern I was having, more precisely if I
> have a bpf_link from libbpf's bpf_program__attach_uprobe_opts(), on a
> binary path say "proc/<PID_12>/root/lib64/libpam.so", and the
> namespace containing <PID_12> is terminated, thereby killing the
> process <PID_12>, what happens to the bpf_link?
>
> If I understood you correctly then even in this scenario one should
> explicitly call the bpf_link__destroy on that link?

Yes, because the file is still there, and the BPF program is still
attached. It's just that the file is not visible in the file system
anymore.

> Thanks.
>
> On Sat, Sep 28, 2024 at 4:50=E2=80=AFAM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Sun, Sep 22, 2024 at 10:18=E2=80=AFPM Abhik Sen <abhikisraina@gmail.=
com> wrote:
> > >
> > > Hello Team!
> > >
> > > We were looking into the bpf-link and bpf-program-attach-uprobe-opts
> >
> > Is the API actually called "bpf-program-attach-uprobe-opts" or we are
> > talking about libbpf's bpf_program__attach_uprobe_opts()? In the
> > former case, which library and API are we talking about? In the latter
> > case, why rewrite API names and cause unnecessary confusion?
> >
> > > implementation and wanted to know if a bpf-link on a binary path
> > > resulted out of bpf-program-attach-uprobe-opts([a binary path]),
> > > remains valid and leaks memory post the binary path getting invalid
> > > (say due to the file getting deleted or path does not exist anymore).
> >
> > I'll try to guess what you are asking. If you attached uprobe to some
> > binary that was present at the time of attachment successfully, and
> > then binary was removed from the file system *while uprobe is still
> > attached*, then that binary is still there in the kernel and uprobe is
> > still, technically active (there could be processes that were loaded
> > from that binary that are still running). It's not considered a leak,
> > that's how Linux object refcounting works.
> >
> > >
> > > Does calling bpf-link-destroy on that link give any additional safety
> > > w.r.t the invalid binary path, or is it not needed to invoke and the
> > > internal implementation of the bpf-link takes care of the essential
> > > cleanup?
> >
> > bpf_link__destroy() (that's libbpf API name) will detach uprobe, and
> > if that uprobe was the last thing to keep reference to that deleted
> > file, it will be truly removed and destroyed at that point. So you
> > might want to do that, but it has nothing to do with safety.
> >
> > >
> > > Thanks,
> > > Abhik
> > >

