Return-Path: <bpf+bounces-65581-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60674B256B0
	for <lists+bpf@lfdr.de>; Thu, 14 Aug 2025 00:36:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 089441C82FEE
	for <lists+bpf@lfdr.de>; Wed, 13 Aug 2025 22:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142112EBDEC;
	Wed, 13 Aug 2025 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi12Kvmo"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3770E1ADFFB;
	Wed, 13 Aug 2025 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755124606; cv=none; b=fMpI4EEIeeZKDnXKByHt2EL2rC8BedQR8yhcGMrGJoCmwyDC8NblaYOVlzB/Au/NrPbpxhcucmcldUfzhYKPB5UlGnI4X5sABxLw3bAImKVmz1fYlIvlWJQf3L1Z2HRAzhtnLj8zNnrpzOkCMH4yIPzcpHLpF2PlcjFvOInVMBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755124606; c=relaxed/simple;
	bh=8WDF16UHLPLkD9bq6fiJ0up9Q0UkX8dnRy9s+B5Dr94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6aQFlseyOGTEYicFCNnEv0+SWkaq1xKTwCprJwV2E0x7ORfRaTfad+Zvk61f+544idpw7WyLHfkXeCNX6rNFxvY+YwxlCT4jRsu2rJ8fCae+Chj9Tp6iLXS+Nry67K/vYgL7B7/hLZEMNpwD8ZX/a2rmdZbCHGaX6LmpKW25tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi12Kvmo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-321cf75482fso1388625a91.0;
        Wed, 13 Aug 2025 15:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755124604; x=1755729404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCXE23J92w0shhoW6wOysOInO2fO7s55w5V3gu+8sJ8=;
        b=Qi12KvmoMhsqCQY3Q8vPEqtbox26O57sYTEyZKdXulibJ4N/q20qW3pPTVjyQBsQ4E
         2WzYAzSqOQkiAX7nyhEHg19OMAHs9HugVlQ/nOrFFk0ULvrNCLa4eVB/FSGvPPok1hhy
         K3QL2xXf/rbrEMnpYcWWaPxh7mz1t1mclwkoKRGKIHcyffIonanSuNX8GCVkYybDGotU
         o6LWVD4ZVeHI5tTa/D2rtPAyIvV6zXMwFYS1ekj0A5GIr0TYsn9sg7cmFY5x5U50bDNl
         C0GXY6g4TGdN8AOY5Uo73+I85ygYJhCJteKRuSPbIhprSTLHqKk0LafMRfq0HgPJ4AR+
         E8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755124604; x=1755729404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCXE23J92w0shhoW6wOysOInO2fO7s55w5V3gu+8sJ8=;
        b=J1tEiihCJLcuKu28YSZMcpcgRE3F5ClgCE8IbhBUcePPC42hJXeVHV/sJZa+KnmtxY
         zgbldIVc5rusJB1J+eD1MwMMB4k0YDOGJRi8qVD2wyjqR+oCWMmsEk9r8vK6WF89ycxd
         jvF5PYxueW1+DAxxA8A6zJQsTx6SlNnTgnk6iKK1Xjvf/+rH0147TsJaoIHnDQ1jnBPP
         c9SzVhqq7ya215RtaK3UwuIAy5I5bBVX+C2I7hJN2vqyznFiIUn1a7e88hrEVTjTsY4Y
         /JA+5++JIwC7AS4sV2sfF4ZkVkgE2zqqOYu/2e1UU++DG3dmNw2ViiA+JTjfVAqf4f+E
         cnWw==
X-Forwarded-Encrypted: i=1; AJvYcCW9bvjXGVvhbbzA9JGb5OEuOpkUQkm3WjlbN9OW93fkdng4T1aGjDGyTJGcq1OxJuiL7B8=@vger.kernel.org, AJvYcCXlVhENHS7buGnZQAdZOWw4yzOGauqd/mvQynbDta+fbDfhu/TjVs++dUtmK/NVvD01rd1IXPp40NiPD72d@vger.kernel.org
X-Gm-Message-State: AOJu0YwaAgJSX6SbD77TfSL5bZIfgcoX3r+VE5O5JWPAukOUzgVvXAur
	9lsesqxL3QV43YTmgBCygkpZ5gKNTcIS2j7T3MO+mOJ0ot90/4WUa1JPnbVm2yR886LtAUVZm8G
	TXxI9bWSEeQWRG7oo+XZnNqJdg4PJVx0=
X-Gm-Gg: ASbGncuLlsCK3FMdy/Pt5TSXzOD7f3h4ZSuDDVs/nGaqt+bw+jC+766UVFDC7vmlvDV
	eT+Gp1VXdHXqjNNY6TWbj4/9PXCpR34ojibJoVmUByaJMQaHUTnPqoL4MLL/wz13cdZx8lba8BX
	EQccyi0yBRUHxcFEkmw1eSA87ii3bU1L2cjIv8MLyFt2yTKD7IhWToJ0Y2g04iJXxncBffVZQy7
	wd+c44TFTxxSMiMVwB4wEg=
X-Google-Smtp-Source: AGHT+IEBW6aH86BTLfVBovezdXkCHimR/CDDqOcr//2P7BeLaNHGYqb1nh+e2L5sP5xSbXWoCOOvT1vbZYlNRZJ1l/s=
X-Received: by 2002:a17:90b:3ec6:b0:321:3715:9a3 with SMTP id
 98e67ed59e1d1-32329de1640mr543273a91.17.1755124604284; Wed, 13 Aug 2025
 15:36:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811-restricted-pointers-bpf-v1-1-a1d7cc3cb9e7@linutronix.de>
 <CAEf4Bzb7DFwvh6J8sPv34U+M=prFKQ8QZiJAk2SE5hPvy7DG1g@mail.gmail.com> <20250813072929-5c7eb9fd-bdc9-4fe3-b885-bfff31def14f@linutronix.de>
In-Reply-To: <20250813072929-5c7eb9fd-bdc9-4fe3-b885-bfff31def14f@linutronix.de>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 13 Aug 2025 15:36:30 -0700
X-Gm-Features: Ac12FXylJGaEM5L75gyB71PlbZd1U0-CarytY1Ro8hx3BTCFmZR_-YEHqG9D7WM
Message-ID: <CAEf4BzbHdtvz5J3c6C6=3bkax4e4m8jE8yKVx+MPj+MPkJ=ghg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Don't use %pK through printk
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2025 at 10:34=E2=80=AFPM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> On Tue, Aug 12, 2025 at 03:19:45PM -0700, Andrii Nakryiko wrote:
> > On Mon, Aug 11, 2025 at 5:08=E2=80=AFAM Thomas Wei=C3=9Fschuh
> > <thomas.weissschuh@linutronix.de> wrote:
> > >
> > > In the past %pK was preferable to %p as it would not leak raw pointer
> > > values into the kernel log.
> > > Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> > > the regular %p has been improved to avoid this issue.
> > > Furthermore, restricted pointers ("%pK") were never meant to be used
> > > through printk(). They can still unintentionally leak raw pointers or
> > > acquire sleeping locks in atomic contexts.
> > >
> > > Switch to the regular pointer formatting which is safer and
> > > easier to reason about.
> > >
> > > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de=
>
> > > ---
> > >  include/linux/filter.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > > index 1e7fd3ee759e07534eee7d8b48cffa1dfea056fb..52fecb7a1fe36d233328a=
abbe5eadcbd7e07cc5a 100644
> > > --- a/include/linux/filter.h
> > > +++ b/include/linux/filter.h
> > > @@ -1296,7 +1296,7 @@ void bpf_jit_prog_release_other(struct bpf_prog=
 *fp, struct bpf_prog *fp_other);
> > >  static inline void bpf_jit_dump(unsigned int flen, unsigned int prog=
len,
> > >                                 u32 pass, void *image)
> > >  {
> > > -       pr_err("flen=3D%u proglen=3D%u pass=3D%u image=3D%pK from=3D%=
s pid=3D%d\n", flen,
> > > +       pr_err("flen=3D%u proglen=3D%u pass=3D%u image=3D%p from=3D%s=
 pid=3D%d\n", flen,
> > >                proglen, pass, image, current->comm, task_pid_nr(curre=
nt));
> >
> > this particular printk won't ever be called from atomic context, so I
> > don't think the leak from atomic context matters much here. On the
> > other hand, %pK behavior is controlled by kptr_restrict and that might
> > be useful for debugging, so not sure there is much of a benefit to
> > switching to always obfuscated %p? Or am I missing something else
> > here?
>
> As %pK is so easy to abuse and the breakage is very non-obvious, I want t=
o
> rework it to enforce its usage from "file context".
> For that, the printk users need to be gone first.
> For debugging, there is still "no_hash_pointers".
>
> How would the image pointer be used for debugging?

I chatted with Daniel about this offline, and it seems like this is
not that critical nowadays. So I went ahead and applied the patch to
bpf-next.

> It is logged from nowhere else.
> And the raw image is dumped right after anyways.
>
> >
> > >
> > >         if (image)
> > >
> > > ---
> > > base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> > > change-id: 20250811-restricted-pointers-bpf-04da04ea1b8a
> > >
> > > Best regards,
> > > --
> > > Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> > >

