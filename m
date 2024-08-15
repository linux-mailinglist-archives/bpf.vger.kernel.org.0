Return-Path: <bpf+bounces-37326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDA6953D3A
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91EF11F21EEC
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF623154BFC;
	Thu, 15 Aug 2024 22:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avb4nxsN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104C24211
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760079; cv=none; b=Sx2Wk3OvBqlmMaKH+gxiiQtJi/ilAQWt+mnV5Jp4HnApuELyW+xjZimrOL7DVftPGlPGwhsfKnYd26ujAhmsrAe1nAu3raF/LxK951FHsKRPx0eVauQVXhuU2aEgumclRnHZUy1i3Ij44MBPlvKatUWqNoKvC+KW+cVp9BaEsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760079; c=relaxed/simple;
	bh=JyEei10cv0TWj4QOkMDZ9zhl9h3EKMH1qU/7kZmDEVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLbSsPU6/NFmtA+coYOQY+2nQHBic4eV949i3nO8yzaAwYWbi7EwpEj3C2ZR/sUBTNVsK7qvvy84Dxbkh9Th1TtxGI68/V18R/oFJkLB3BQCiuZv7ioJoMO2bTLEL3Qm+Ap0ARGxEjSkHcm4kzlYpInbnIQTrbpcY0vyDE2QyYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=avb4nxsN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so1061241a91.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760077; x=1724364877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyEei10cv0TWj4QOkMDZ9zhl9h3EKMH1qU/7kZmDEVs=;
        b=avb4nxsNgF748vpW8atbt9Jkvy2si0Aj5cJGaF13Kc0MdWwGkwV2FW9i6b3NYOzcSo
         IFXf5B7mF4dKZ4iI014gLoGdhZlHkgETBwWyQxqbbpNaUKKYiOay0+5yPP84Fp9Qz1RW
         L4ASUvPRR6jWZaY0fZWai2YsU1IHlZbiVryH1pYFb4eHfgYBBy0qQs+3jsEWcpATR+J0
         OjZOEstipXhXxocwq4T2XrQ9S7c5I6yxBqdRt7/yjM+3htQOPF37NyFW7gyHDxaTXNrK
         fJh//vl1Jue4J7iHFrLUqq3HUy+l/UxV1s2P08aO+FuIoCUsioEGjOxArJpoSMR5JUMF
         Tw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760077; x=1724364877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JyEei10cv0TWj4QOkMDZ9zhl9h3EKMH1qU/7kZmDEVs=;
        b=KIm5kipr6us/zB9wdhswTX9nR7UVwgAvkazcAQBqdacWU1FdzOFWkDWGgeq42Ds+r+
         stZ96Nhbgk2+jOvU750VOgIGDJpYddkezKIL9ddGs0ucBIoYdUf5WbLsMZlnNw0K/Kmp
         2zSWkybdvZ926SwXVe+E76P+fAUeJJP58qQSdKMVxy+UeMhP0Cnsm9ZoIdFk+1UrGe5P
         7Oiwm0HBQbhhhbNKkVoazgb8Zys4Lh2wv0vie7+wZvtH6yQmfIl32zo576hz9GPcwRae
         DcxT9FYOHQNCrmtkz6ZLigeeHodXDY/D8DdgkPZq/JaExL/Uwv4haOswBfpRlpJW4mxO
         qYZg==
X-Gm-Message-State: AOJu0Yxw2vstLaHOUIrZ99fyZrM22mbBTxLLpaA29QKsaVHr0RFEIw+9
	te/IJOKNc2uYVpu6H4hXtVbTJWKRRnUlynWqUmV4Ih+Wh529t1vKRy4IYqKBbYWxYhgwaJBQlWD
	eE8VMKFD6onnhppNOb6/JtSAfyu0=
X-Google-Smtp-Source: AGHT+IGe51t05PaunfbcReAKZnrroZNYIIcQxYywMefZDC3sWaOwp25+4TQr8ff2VStLox+i8Q9p1yvsOlW35iBfmsI=
X-Received: by 2002:a17:90a:f483:b0:2c9:8105:483 with SMTP id
 98e67ed59e1d1-2d3dfc6ada6mr1239847a91.14.1723760077332; Thu, 15 Aug 2024
 15:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809010518.1137758-1-eddyz87@gmail.com> <20240809010518.1137758-5-eddyz87@gmail.com>
 <CAEf4Bza97Ksce2XYiQrvzYC5Lnqz68xWM+JvDeKMfj5M3pr+Rg@mail.gmail.com>
 <7925b20a052588f5b7b911ed10e23ba9fd56d4a4.camel@gmail.com>
 <CAEf4BzZNN4YViWtv_LR996T4uw86MhcOLLkNFPMgb=Y8qpxK8w@mail.gmail.com> <6d40ddcfbdf1bfecd7280d2a69f96eb66f20e692.camel@gmail.com>
In-Reply-To: <6d40ddcfbdf1bfecd7280d2a69f96eb66f20e692.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:14:25 -0700
Message-ID: <CAEf4BzbvT7PO7ejSrH7JPPuYxDzXeK_E=3UNPVcTX9UhWN_hvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: validate jit behaviour for
 tail calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev, hffilwlqm@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 3:11=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Thu, 2024-08-15 at 15:07 -0700, Andrii Nakryiko wrote:
>
> [...]
>
> > > > Isn't that a bit counter-intuitive and potentially dangerous behavi=
or
> > > > for checking disassembly? If my assumption is correct, maybe we sho=
uld
> > > > add some sort of `__jit_x86("...")` placeholder to explicitly mark
> > > > that we allow some amount of lines to be skipped, but otherwise be
> > > > strict and require matching line-by-line?
> > >
> > > This is a valid concern.
> > > What you suggest with "..." looks good.
> >
> > I'd add just that for now. _not and _next might be useful in the
> > future, but meh.
>
> If we commit to "..." now and decide to add _not and _next in the
> future this would make __jit macro special. Which is not ideal, imo.
> (on the other hand, tests can always be adjusted).
>

It is already special with a different flavor of regex. And I assume
we won't have that many jit-testing tests, so yeah, could be adjusted,
if necessary. But just in general, while __msg() works with large
verifier logs, __jit() is much more narrow-focused, so even if it
behaves differently from __msg() I don't really see much difference.

But we also have __xlated() with similar semantics, so I'd say we
should keep __jit() and __xlated() behaving similarly.

> [...]
>

