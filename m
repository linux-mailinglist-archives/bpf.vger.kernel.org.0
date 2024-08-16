Return-Path: <bpf+bounces-37374-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B116D954DF4
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 17:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 326D41F2697F
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 15:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A575C1BDAA0;
	Fri, 16 Aug 2024 15:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A141WcLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BAE1DDF5;
	Fri, 16 Aug 2024 15:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723822802; cv=none; b=lszQjG+ShfrEFB0Gwb4Yj6YWYdoMGEwiInQkkbnvNF0cI7lowabPqVOhBkoSGLrhj/aOftKPS7C1V1I8sE9Ef6Zl8VUgHtq2ADvsdoc8TmWUXayvYFKX/bjDWiWGgcpZdLaUv3kobEqLiahii+wHOSZ0GQ1AU6X8DyTjbtIHNP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723822802; c=relaxed/simple;
	bh=SodHBwOnb0Y1f+oSByMA9Ox5MHwmXJ4juOcn37B0Bno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3ZOuj7Q0TukRRSx6LYY3pN56C6U+CzRqW9AotkcLhP2l90RuKYLz3sRi45J5UaPNWGbMKszf5p2GF7iZ7Vf7FuY5TqSUhvrJGmghXMpqCwJsD7+c2LXnS1AFhXptenZeJlbgmbmRaEgLSl2+qYDtORuAErb1scvdlK5UnY1hgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A141WcLa; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-429da8b5feaso21544335e9.2;
        Fri, 16 Aug 2024 08:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723822798; x=1724427598; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6S2acSozC6mYzCkGcCYQNmohIFTorTmXouK8gd9clk=;
        b=A141WcLa7hBVeECajN5AzYpS3vGfU9rwCDOld3NDiy4VgCSM+tOWjOW3LuguUd5erb
         +7+y1sF4VDlffPkYcDZTtNrXu8TvuZyia7b2A+0KQnoPaAR5/ANyhiZiqcgTQy+kljWw
         2VS5TEuxIj/b/AsTzbVbTpCnDFnYIEYb19PXcLJ0OMccO5dhYtni6fYGWtrlFURvTGA5
         wdlWh9QM1Q4zbS3OgAXdUR8dKD8eNTWBnlwUjrxYp0VX3UgFuzW1O7fTVZjhS1m9oOVq
         aFZgD90n0HXUMyVgikI23VBP2y1kd5TBkZsgru3uQ8Kfs3hSh+Zmlkkj9zOdk7Ha8+wu
         fmCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723822798; x=1724427598;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6S2acSozC6mYzCkGcCYQNmohIFTorTmXouK8gd9clk=;
        b=aY4gCs4Twmk+7WUCXlIn29dySt+HIhe++mal/pVopv/WRJ7TS8oRN83Ofn7lMG887w
         bvM9YSrUer2AhmBSPH7TwlZ1Fo75FpFEwB8z+wggQ3Y2eI9qmUcqTRawL7rT7/IA1+lZ
         rifkJPV+s7vejBEkAqzvEJYeDEmL+O7owSSNUiX1OqWoqW4cuYF5PhDvp6HL7JE489qM
         WEaXzCXfraoUG8t5duMa7s1IevQW5ofiuz4012Di38APtoEUPPPgk9qaPddM+v3nTg/1
         TGoquDu91abrpDfnYXfWYai10mWS390Zvr25a4WaYwRCCrDn5LAU+j7n/KgmY9fm/v7k
         UFaw==
X-Forwarded-Encrypted: i=1; AJvYcCWomSdinyQBPGcn+Uk6IQk09DWw9pOO7TJ3zfTklJayaiEX5CzOs6eJ93s8LkkesQXxvRUUa/VqMmf462VIZcQ2wo76zhiDyLv34gOuYTUFtM5rPRWi4z4+01F7hZbt7Uee
X-Gm-Message-State: AOJu0YzlX6GMdOHZm9sGeBVY2JvyAmmYPZiKY4B5x6v/5JzRaT+3Ab/M
	Ah6vVJ6h9i/xHg6zbdEw6gd0DnEfnOCvo3V3HgECixSR+eDqmtbPb8NY1+p/ZEfbdtYwxpnSj7a
	oR+JP9N8w0NqIGl3K1GTPaUPeE+lRdEZcIqA=
X-Google-Smtp-Source: AGHT+IFxgn2tebM4X1AucuO0ZQREUl+nzh/ddBxxqDgJVt6QLUfVKhqOUgFvOomAG6kN1y9vgP2ngOIww01AqumR3Sk=
X-Received: by 2002:a05:600c:190e:b0:426:5e8e:aa48 with SMTP id
 5b1f17b1804b1-429ed7b8878mr31018735e9.22.1723822797442; Fri, 16 Aug 2024
 08:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB58489794C158C438B04FD0E599802@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CAEf4Bzb3XbGx+N5yrYELNAkaABP9fyifAQhTP1VHSvVycG36TQ@mail.gmail.com> <AM6PR03MB584807BFB29105F1D7FDC89E99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB584807BFB29105F1D7FDC89E99812@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Aug 2024 17:39:46 +0200
Message-ID: <CAADnVQKvt2uUsvFbYnEmApj9ZzeL0on1zM4zKBJEFmzuoTtzhg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Make the pointer returned by iter next
 method valid
To: Juntong Deng <juntong.deng@outlook.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eddy Z <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 3:43=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> On 8/15/24 18:15, Andrii Nakryiko wrote:
> > On Thu, Aug 15, 2024 at 9:11=E2=80=AFAM Juntong Deng <juntong.deng@outl=
ook.com> wrote:
> >>
> >> Currently we cannot pass the pointer returned by iter next method as
> >> argument to KF_TRUSTED_ARGS kfuncs, because the pointer returned by
> >> iter next method is not "valid".
> >>
> >> This patch sets the pointer returned by iter next method to be valid.
> >>
> >> This is based on the fact that if the iterator is implemented correctl=
y,
> >> then the pointer returned from the iter next method should be valid.
> >>
> >> This does not make NULL pointer valid. If the iter next method has
> >> KF_RET_NULL flag, then the verifier will ask the ebpf program to
> >> check NULL pointer.
> >>
> >> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
> >> ---
> >>   kernel/bpf/verifier.c | 4 ++++
> >>   1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index ebec74c28ae3..35a7b7c6679c 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -12832,6 +12832,10 @@ static int check_kfunc_call(struct bpf_verifi=
er_env *env, struct bpf_insn *insn,
> >>                          /* For mark_ptr_or_null_reg, see 93c230e3f5bd=
6 */
> >>                          regs[BPF_REG_0].id =3D ++env->id_gen;
> >>                  }
> >> +
> >> +               if (is_iter_next_kfunc(&meta))
> >> +                       regs[BPF_REG_0].type |=3D PTR_TRUSTED;
> >> +
> >
> > It seems a bit too generic to always assign PTR_TRUSTED to anything
> > returned from any iterator. Let's maybe add KF_RET_TRUSTED or
> > KF_ITER_TRUSTED or something along those lines to mark such iter_next
> > kfuncs explicitly?
> >
> > For the numbers iterator, for instance, this PTR_TRUSTED makes no sense=
.
> >
>
> I had the same idea (KF_RET_TRUSTED) before, but Kumar thought it should
> be avoided and pointers returned by iter next method should be trusted
> by default [0].
>
> The following are previous related discussions:
>
>  >> For iter_next(), I currently have an idea to add new flags to allow
>  >> iter_next() to decide whether the return value is trusted or not,
>  >> such as KF_RET_TRUSTED.
>  >>
>  >> What do you think?
>  >
>  > Why shouldn't the return value always be trusted?
>  > We eventually want to switch over to trusted by default everywhere.
>  > It would be nice not to go further in the opposite direction (i.e.
>  > having to manually annotate trusted) if we can avoid it.
>
> [0]:
> https://lore.kernel.org/bpf/CAP01T75na=3Dfz7EhrP4Aw0WZ33R7jTbZ4BcmY56S1xT=
WczxHXWw@mail.gmail.com/
>
> Maybe we can have more discussion?
>
> (This email has been CC Kumar)

+1
pointer from iterator should always be trusted except
the case of KF_RCU_PROTECTED iterators.
Those iters clear iter itself outside of RCU CS,
so a pointer returned from iter_next should probably be
PTR_TO_BTF_ID | MEM_RCU | PTR_MAYBE_NULL.

For all other iters it should be safe to return
PTR_TO_BTF_ID | PTR_TRUSTED | PTR_MAYBE_NULL

> For the numbers iterator, for instance, this PTR_TRUSTED makes no sense

I see no conflict. It's a trusted pointer to u32.

