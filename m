Return-Path: <bpf+bounces-76227-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEF1CAB2F8
	for <lists+bpf@lfdr.de>; Sun, 07 Dec 2025 10:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1A5E8300385C
	for <lists+bpf@lfdr.de>; Sun,  7 Dec 2025 09:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556542EAB71;
	Sun,  7 Dec 2025 09:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0t8uh75s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567922C21DD
	for <bpf@vger.kernel.org>; Sun,  7 Dec 2025 09:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765098747; cv=none; b=nrdt19gWAbiYc10W+q8dWzGMDFsdNqfX0sSE3liJGf4GhK2vd89vMDlJCQ0tgUgvBzOWJhlORD+kzvEuV2I1onCybxlDIvDfZNLHmQBtgabMx7NxTUd2MX37DUTnoK3RK/Y+4uPEzIM/IREycRk6rZs69EoPH1/Q9Daqqpjgg98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765098747; c=relaxed/simple;
	bh=7XFUfxwKYl6Qe3Gn8LqJInArs7NCQoi59i2Z/yDtdQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AoOJ7rWX3RD8qbUk1QoUp3rfAlsJjleYG5fIpmnQdtLWXr5j5ftLn4mdshqLfK9m2ywDjQ0H9AQMXnvwO4mRMcbCLxaAT401QDKeSgKVOlyv7fkfYgcO2ZgJOxo55oAcH1zeLoLORs9m/w+0lLi2V/fh4n7MhcTzodEKaOFYgL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0t8uh75s; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779a4fc916so49425e9.1
        for <bpf@vger.kernel.org>; Sun, 07 Dec 2025 01:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765098745; x=1765703545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKz+hdI2fDCUvtlWJ9Sh5U1IZqOAwl/nanCQNGRPFEw=;
        b=0t8uh75sxwXj4TY1zclqxnYR3wpq3wv8TTEVC4tlkasdKit4SaRInu755wm5gheOVC
         yfWLw+ottY+1EbK/KMUJBT6SipoS7yIH96QeyS/wJL2aHaT3/s/MjJE2IHz3wHF0dKay
         FktuL2SjszCwLnBMX+4a2ClHbG4MDFybwFVpEV4kwK4C24ogDQSwbHkMklFoZnCAMvBZ
         3lK4x3H/c6OUETQrr3oUpqn8EEfRqmUrg69X9RZMx5DppYNQVW7zxhTCu37t3tKM6IMJ
         ujdbufUdZuCVxJo+34bi7fr3mnQBNrhLKOaBg+QXxfUi02cDn8lNeIQRQ55RUJuFxGga
         E/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765098745; x=1765703545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WKz+hdI2fDCUvtlWJ9Sh5U1IZqOAwl/nanCQNGRPFEw=;
        b=AIl/cg7WD8cTcN/8ubGCj+5sOKe5qNQ+CYuk2aAuuUIJS2Z3LlSC8UaQO8qOcIU+m3
         WZjoeaC4/K48CHrL1rFgerBg71NWYju46mi9xwJ6/06hwr5B9HirKsgXXWWkVnBLQXyW
         10GJftvDVvl9Jh2CRVY49q92KNPKC480CDGiqOrRB76w1KPOMPYdxDUBwntCoIyCqwMp
         Uq7emmkKjYeJoDi20DJy09Vy38O3agemum72uBuxijo6yLPsvvZ+XmO1hN/mjKjcG+GP
         MqI+l02DyJaH6WTwZLUhQGG3OyDP/1F2KmxO51yQitQ6PqlsBQmrA0mL2Ih6DCResk3F
         zDkg==
X-Forwarded-Encrypted: i=1; AJvYcCUrZZj/NkYXFeI0iit+8V/9L1aNG3Wxl7sVbP7QedmtWUcURTfYfppJffmqdKK6vyois/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUv/bCoAzr4JopUak+jQWI/Qf2N+TsoACyQ4Fwj0b3ptoloNQC
	G5crr7wQQOSNqY61uVXdlwe8ytiYLt0OD8inURJarqlcqIrTRv00DH4x2KfpeNg/HxCbNIlIXqs
	Hv9JjjeyxrZfQ2eHpJFzipHJ0kKrImjmbebNJE2Oc
X-Gm-Gg: ASbGncu9nlcYI9VRNhijkXf42sgfaCKq44fd3jsFLg8Ls+Z3Sw7tfEHhJbF0W2okyC8
	lCRJfhmYvn5CGP18TRr5WnYneOnYXqh5ZZ5VUY/lFc1YVfhEis5dHuR5/lpv4lhdAEpKvnAufWI
	pgRno+dBPQeRmKLaI605GTu8+o5cRfr798Op2Otzg4rwRHrPDl3xAH6uyouClNN7Swut+HNWPOj
	cyxe5AvofwGs4gRNMwg7j4CPnjCxJLiSLmUcRntOzYjR+xUOJbVOA0iioYR0ipx/6GPkfdnNyaK
	Vs+I+jZGjKr6AwFJSl0/TcN+5hc=
X-Google-Smtp-Source: AGHT+IHFKOa62qA2OHYqZDP0T+kf4IdrY7Zu6P/guCGLrViPsbQATKkUWy3l59FIawJGnHYsLBf7VCWCwP9QESiaofc=
X-Received: by 2002:a05:600c:47d3:b0:477:974e:2b34 with SMTP id
 5b1f17b1804b1-4793a2be5e8mr639525e9.16.1765098744567; Sun, 07 Dec 2025
 01:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251207005854.2708338-1-tjmercier@google.com> <5964481.DvuYhMxLoT@7950hx>
In-Reply-To: <5964481.DvuYhMxLoT@7950hx>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Sun, 7 Dec 2025 18:12:12 +0900
X-Gm-Features: AQt7F2qJWV0o9nTEr4l6jdoVmDhTIYjMIJUW-_-VmuCXiG_iysWc6MR7lzdb6IE
Message-ID: <CABdmKX0QUE7+sJy7CHfrZmBAZAsnpHNrVM6N7MvQO7n76MJoCg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix bpf_seq_read docs for increased buffer size
To: Menglong Dong <menglong.dong@linux.dev>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 7, 2025 at 2:08=E2=80=AFPM Menglong Dong <menglong.dong@linux.d=
ev> wrote:
>
> On 12/7/25 8:58=E2=80=AFAM, T.J. Mercier wrote:
> > Commit af65320948b8 ("bpf: Bump iter seq size to support BTF
> > representation of large data structures") increased the fixed buffer
> > size from PAGE_SIZE to PAGE_SIZE << 3, but the docs for the function
> > didn't get updated at the same time. Update them.
> >
> > Fixes: af65320948b8 ("bpf: Bump iter seq size to support BTF representa=
tion of large data structures")
>
> I think we don't need the "Fixes" tag for the document fix?
> Therefore, it's better to go to the "bpf-next" tree with the
> corresponding tag:
>   [PATCH bpf-next]
>
> Thanks!
> Menglong Dong

SGTM, resent to bpf-next at:
https://lore.kernel.org/bpf/20251207091005.2829703-1-tjmercier@google.com/T=
/#u

Thanks!
-T.J.

> > Signed-off-by: T.J. Mercier <tjmercier@google.com>
> > ---
> >  kernel/bpf/bpf_iter.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> > index eec60b57bd3d..4b58d56ecab1 100644
> > --- a/kernel/bpf/bpf_iter.c
> > +++ b/kernel/bpf/bpf_iter.c
> > @@ -86,7 +86,7 @@ static bool bpf_iter_support_resched(struct seq_file =
*seq)
> >
> >  /* bpf_seq_read, a customized and simpler version for bpf iterator.
> >   * The following are differences from seq_read():
> > - *  . fixed buffer size (PAGE_SIZE)
> > + *  . fixed buffer size (PAGE_SIZE << 3)
> >   *  . assuming NULL ->llseek()
> >   *  . stop() may call bpf program, handling potential overflow there
> >   */
> >
>
>
>
>

