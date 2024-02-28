Return-Path: <bpf+bounces-22951-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 80ED886BC1B
	for <lists+bpf@lfdr.de>; Thu, 29 Feb 2024 00:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21A73B256C0
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 23:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A774432;
	Wed, 28 Feb 2024 23:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDTKoU00"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECD92261D
	for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709162494; cv=none; b=i3YcDZHI45U0aNoxQEMSuIzsVMpMQi2MZcLrKe7903nvUUPAUuTrcQL2TpmihLURs3PRzLBIfofQsjfwiHh9Am6CGgOX2ajGED9T1bOwrOHmh/e/z8UDGXMmOa3jSYgfcIvi/GEVLA7cSkcsaj6XsTGUC5BYLihRGNANpOiYKN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709162494; c=relaxed/simple;
	bh=c971Ik+5Ti49szxEJcRJ0amftbDE96hy849XysfBQqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uA5Ca+hyVOZ60IGkSp5+x3tMo1yt87+43VaYHMqBKvFZyhtd7NYb+/Po2aEhbved51oZ3P80Rjb1K/riCh3VAH48Mc/tOYZJdM1TNo3RRBtAy7NV9U7gwGBgriB9f1VQroYMQMubOUsv8yXBBcZ+dI2q5vkR69JdX0oJImza2s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDTKoU00; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1dca160163dso3451805ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Feb 2024 15:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709162492; x=1709767292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c971Ik+5Ti49szxEJcRJ0amftbDE96hy849XysfBQqY=;
        b=LDTKoU00Z14V9/RFwluhdC4/JaxQDO7hs2H0yE4hxulW8rid0ZUBecBxnbTH52wJOI
         zjfg1VOETbfeTzmafr+ISpr6ML8cKKuUPdzgzARjpfhaHVyiM1idhRTHBcfqshxwvz6j
         0U25HFdX9F3KB1NUVs7t1fRBQaeQCBvhWvzNjBHUCUZ87XKWNgLvUfoZOFUPUA98bkdw
         5IwtS1EsJKQNTLZj8P/hRr5n4XhfQQP2+CYwcRNNiuVxdbR0a7mrZkM28Wukgto2tQhz
         NC84BAWb6d9pUlKeXDCUdhkeQzzpiGLuNTTRmPTeeWoVZIOewb6gqghC7wayQvgRhnDe
         3pdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709162492; x=1709767292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c971Ik+5Ti49szxEJcRJ0amftbDE96hy849XysfBQqY=;
        b=P/6AkQn/b6fQ151dPengUu1c8ZJWV2PrlpRvLzYJN66z4Kpn5/WpjjL/Pys1HZQUdw
         NybmG0AEOiW3AhXdLXjVcPM5voOs+1euPOZ7FtbESRFD5xIeRymu+4WPdiveu2mE52M1
         GZYixNI1BU7X2aQSOChjBEXtGHLrCWvs2m2a7xQxH0OgOwmXeJSXqH5XU5XiFrzSScS/
         PVPsGTNzWR03b2mc+Mr2Ygt2+AGh7GaxqMy7aTS2ua+vDVXalDwgy915O0KLbrfJTD+6
         04Utn0cS793W/W3L7j2yuBqvvUZTSOvghdGmMz+RTVCLGxfoyT664Pp/OtQlBHTPnT02
         DLVw==
X-Forwarded-Encrypted: i=1; AJvYcCXazs0YwKPYAUGaJuN2OJOcJ+gU4O5LOBvTBALNvC3mzLoDpEaFsserVM4kYTGXeSD2mKpA0NOnlxsv8cYJML5G17aj
X-Gm-Message-State: AOJu0YxpVdV5/3qJw8cW5hsmjITszqRomF37Sjs+DL0anpCwByxYoQc7
	EtquWy/ll9lBVc5n97Nfa/PlHHHdcczDiaKegQspI27yv7BlUSvwRcKs7EIJ2zwsW7Ludz0/6uI
	TPiGsOajWjga3HJauGMzubFJSYwHNiLmA
X-Google-Smtp-Source: AGHT+IG4jJMhibsZzVd4V+86jgnUsBKVx304fWsvhKvsxJZEm6qJTDhHTYetrU9g9JEMLduTfQY1QVldloVqmPn2QeA=
X-Received: by 2002:a17:902:a3c3:b0:1dc:ccd3:29e5 with SMTP id
 q3-20020a170902a3c300b001dcccd329e5mr443599plb.2.1709162491890; Wed, 28 Feb
 2024 15:21:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227204556.17524-1-eddyz87@gmail.com> <20240227204556.17524-2-eddyz87@gmail.com>
 <20240228162936.GA148327@maniforge> <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
In-Reply-To: <a369e0b2cd129cbfc8e33d2c61ed78265c21982d.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 28 Feb 2024 15:21:20 -0800
Message-ID: <CAEf4BzZ33ZuMFG_tmL-O0tKBx1GMSNY3uJyp425ZXpbywqiZ2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] libbpf: allow version suffixes (___smth)
 for struct_ops types
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: David Vernet <void@manifault.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev, 
	kernel-team@fb.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 9:29=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2024-02-28 at 10:29 -0600, David Vernet wrote:
> [...]
>
> > Modulo the leak pointed out by Kui-Feng in another thread. It would be =
nice if
> > we could just do this on the stack, but I guess there's no static max s=
ize for
> > a tname.
>
> GCC documents [0] that it does not impose name length limits.
> Skimming through libbpf's btf.c it looks like it does not impose limits e=
ither.
> I can add a name buffer and a fallback to strdup logic if tname is too lo=
ng,
> but I don't think this code would ever be on the hot path.

It would still be nice to avoid allocation even if for the sake of
simplifying error handling. I think it's reasonable to have `char
name[256]` on the stack and snprintf() into it. Let's keep it simple.

>
> [0] https://gcc.gnu.org/onlinedocs/gcc/Identifiers-implementation.html#Id=
entifiers-implementation

