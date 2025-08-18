Return-Path: <bpf+bounces-65894-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF8EB2AD58
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 17:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8588B5653B2
	for <lists+bpf@lfdr.de>; Mon, 18 Aug 2025 15:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD61326D6F;
	Mon, 18 Aug 2025 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgbpjmBU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F6E31813A
	for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755532236; cv=none; b=uVOrfWHkyg3MsRDcacdd/J3XTkSL4YOTVs8ySXcV8XkF4ETh1ZHWm59sRzFxJ0EYBZMGpqt6cgUogoicYlHv5FAmbT1tJchQ1VEwwUeiAKzzp9fzJtFsAhawhkxq/dvHG0qnKrLewBoN/1JfX1IUeJjaKA9p/f87JztI+akUGpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755532236; c=relaxed/simple;
	bh=eNCWzduP7Yf5DfJq5II+J/PaYC/0Dg64B5EfKOT72cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux45T4Ibu9jm6WsQJR4yxHzoj8CNnVEQuG+YYdaIw4Yi49zWYi8ENoR4wLrw9fU6wEBCk+MQuOBCcUUaF5ckp5QgusR8xTPK1ZnSr26STagPvmH32EoMEnIFc4BwsIWLyG5PlD+zmPHyZ30Sn/EplRUCxl25yT3Tfx3oWZGBIfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bgbpjmBU; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b134a5b217so16807901cf.1
        for <bpf@vger.kernel.org>; Mon, 18 Aug 2025 08:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755532233; x=1756137033; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nq9PmEn4rdBwaZCZ0pnfS2T+4YeQ38R7gE2ChrjoR50=;
        b=bgbpjmBUntHl2gWRwytvgh06qz60ZIyuuo/eA1dDIqYOK0KFDAdMW497D3hpRYJ/xr
         flX0sd3cgDLnq8+NnQ5EjyhQ+B+84oLheMOuH86fJDyuHFzREzGD/LzMci+9fWxz1f14
         P4+2lukmyxaSYRDsqvZNyWFrT4tqS29doSzbudaZ9ve3lyavJVnIuGN6hnFj8jVf12l5
         OL9v2N85+vO0+sas9gpRL5iKsx9viVkCjzUCnLYkIpxniRPf+X6/gJLDYJGYV3V+UHm0
         ndDy2urc59veVTbQDghmP+pxaNwNJyJR9VAjusRNGvFlH3UhhkohXE7MqM6fOMyAwwLG
         txmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755532233; x=1756137033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nq9PmEn4rdBwaZCZ0pnfS2T+4YeQ38R7gE2ChrjoR50=;
        b=csGeiorzvg9/GtNEjft0YNYRQ32+xm5y6EoCPYDvt+9MkFfN2/0pyyvTf+BOLqgB47
         ptMfcXA4e5R27ge/nFEJb7tv1cPqUkbIOvOAEaBGdYv+smA5S4B4gR3m4GRxhaYKIHve
         H5fFiAiHxt7+ez2v6qo/rS3nMpXZOBrVQ+0LHQ93nH8F+f7qIcoKka8dPzggxx+0izAx
         0LaveKcnpyG5Y1h/7ZB/X6w/++VTRyPXm0wsVRN5Mfulnz6IY9CTpDHVN243p3fodg/f
         0MyGwAXpC6ZpYynb2UnByWix3HLmz1PgpD0OokuMOhvTQ//2T/yPdHqGmXl5yk5ekWrM
         qlAw==
X-Forwarded-Encrypted: i=1; AJvYcCX2+EaBUv+TMkEbPD6U8sy2H7EPV/wrLx29XpoF/K3nYuaxDTuTe7/sjAaz0Oyc2wKAgYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3k1p6ylFCgpmnXuKWSObtA1iNWYUndJYZ+u5/TklLXzhb39Zb
	HK0S1Ta5o812uJJyoNIz8YRho36mwR9H7S1+qdjXbtWkoXxkXlqcJiBqaaZZJVQasnCFFYQdV//
	rhCqhPkW+hW9IvZgDqfuT5t48/zMEpoaDCw==
X-Gm-Gg: ASbGncsWTLCYzkbDWU7EPnKi8WzbLNQVbbxXRA3XwnJ3dUhmsUkPDfs/Bu6996HcGRu
	flTCfzuvqfDTFjVGP9JfGuR1YLmVjgYtqJzuHtcTZdPfNBBld6IO9uWumR2gP0lE4rHBBJIvh7e
	mIkj5/IiIroBiUxKkiUQ3KHCZPRWIbR6gLDM76EwhW79g6dnFDsci1+kFg+kSYPZYMf6iHAPRMk
	r9T534=
X-Google-Smtp-Source: AGHT+IGH6d32suJR5RTJvONFyMAj0m5dnb8B/ISbjiQUvmGZjGBDOf/b+obz4T98Wugkomrm/buopUVCYXk5zyASyN0=
X-Received: by 2002:a05:622a:4a89:b0:4b1:1351:e3e7 with SMTP id
 d75a77b69052e-4b11e05a6a2mr185458131cf.8.1755532233341; Mon, 18 Aug 2025
 08:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808145133.404799-1-vincent.mc.li@gmail.com>
 <d9e524a6-6296-4a5a-941e-65cca7d72bcd@kernel.org> <729e6325-da97-4f01-97b7-3fc966c3fda7@iogearbox.net>
In-Reply-To: <729e6325-da97-4f01-97b7-3fc966c3fda7@iogearbox.net>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Mon, 18 Aug 2025 08:50:20 -0700
X-Gm-Features: Ac12FXwWXCnDzXVypSMzOYRJfjVP38QCQCEETILXsUE7TnENkoHa64G8-tNdkmE
Message-ID: <CAK3+h2ysLOfFyJC-O-jJDBawDOqPynHNYzVGvHL-jTkZqrUj5A@mail.gmail.com>
Subject: Re: [PATCH] bpftool: add kernel.kptr_restrict hint for no instructions
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Quentin Monnet <qmo@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 18, 2025 at 7:50=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/8/25 5:49 PM, Quentin Monnet wrote:
> > Please run ./scripts/get_maintainer.pl and Cc all maintainers for your
> > future submissions, in this case: all BPF maintainers/reviewers.
> >
> > On 08/08/2025 15:51, Vincent Li wrote:
> >> from bpftool github repo issue [0], when Linux distribution
> >> kernel.kptr_restrict is set to 2, bpftool prog dump jited returns "no
> >> instructions returned", this message can be puzzling to bpftool users
> >> who is not familiar with kernel BPF internal, so add small hint for
> >> bpftool users to check kernel.kptr_restrict setting. Set
> >> kernel.kptr_restrict to expose kernel address to allow bpftool prog
> >> dump jited to dump the jited bpf program instructions.
> >>
> >> [0]: https://github.com/libbpf/bpftool/issues/184
> >>
> >> Signed-off-by: Vincent Li <vincent.mc.li@gmail.com.
> >> ---
> >>   tools/bpf/bpftool/prog.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> >> index 9722d841abc0..7d2337511284 100644
> >> --- a/tools/bpf/bpftool/prog.c
> >> +++ b/tools/bpf/bpftool/prog.c
> >> @@ -714,7 +714,7 @@ prog_dump(struct bpf_prog_info *info, enum dump_mo=
de mode,
> >>
> >>      if (mode =3D=3D DUMP_JITED) {
> >>              if (info->jited_prog_len =3D=3D 0 || !info->jited_prog_in=
sns) {
> >> -                    p_info("no instructions returned");
> >> +                    p_info("no instructions returned: set kernel.kptr=
_restrict to expose kernel addresses");
>
> Can we align this to sth similar as we have further below in that same fu=
nction?
>
>    p_err("error retrieving jit dump: no instructions returned or kernel.k=
ptr_restrict set?");

Ok.

>
> (I presume the former we'll see for interpreter-only case.)
>
> >>                      return -1;
> >>              }
> >>              buf =3D u64_to_ptr(info->jited_prog_insns);
> >
> >
> > Thank you Vincent!
> >
> > We have the same hint for the xlated dump some 7 lines further in the
> > file. As we discussed off-list, this hint was initially printed for bot=
h
> > cases, JITed and xlated dump, since commit 7105e828c087 ("bpf: allow fo=
r
> > correlation of maps and helpers in dump") from Daniel, back in 2017. It
> > was kept for the xlated dump only after commit cae73f233923 ("bpftool:
> > use bpf_program__get_prog_info_linear() in prog.c:do_dump()"), I believ=
e
> > by accident.
> >
> >  From what I understand, the kptr restriction should not be relevant in
> > the case of xlated dump (it does change the information we can print -
> > it prevents us from retrieving __bpf_call_base from ksyms - but should
> > not prevent bpftool from retrieving instructions entirely). Daniel, it'=
s
> > been a while, but do you remember why you printed it for xlated dumps
> > too? If not, we should probably just keep the hint for the JITed case.
>
> Indeed been a while - my understanding is that we don't return xlated in
> case of not having the right capabilities or when the program got constan=
t
> blinded so we don't want to expose the latter from the kernel back to use=
r
> space when kptr_restrict is set.

So my understanding is to  keep the error log for xlated then. will
send the suggested patch.

Thanks!

