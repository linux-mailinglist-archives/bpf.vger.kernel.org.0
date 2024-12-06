Return-Path: <bpf+bounces-46318-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 846CD9E7897
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517A41886585
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 19:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87721D61A3;
	Fri,  6 Dec 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvwL8Plw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE17D22069F
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512197; cv=none; b=bKxT5unM9ieni96tNCwUfu2Hle3J8LU/oT0exkNzy8fvi91rJaLL2/xbRO69WPRuP+U0DOoXqChq/mPb0UFs7s/qTFF/PLLqFvYlisLiPQ5q2UVFSHJsA0vRZ7BJrWpjqiZ2XL9dveMxteqFRO7e1+52W31bdIUSwgGB3Q6wAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512197; c=relaxed/simple;
	bh=M+0bej2RwysPlBJMhst5e+vBUfhaolesdLs+7s5XfiY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/vBfkDij1qBtWD+AyH5K1v4GzmSh6KgpGv/Rz8URJEOex/xPBHotv8Ij8Lj42Zsr+eConlf77kxuFt/a7QZGV1kJh91u8PN21SaU6TJjFlvR5ZuUDVLqVjWVl7CWyLuim0DzBeluL+NHn0xbd+o2NtaYsNTz8WAQ5II5CVLhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvwL8Plw; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5cf6f804233so2896102a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 11:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733512194; x=1734116994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+0bej2RwysPlBJMhst5e+vBUfhaolesdLs+7s5XfiY=;
        b=QvwL8Plwo7He0cC+jWkYqop3MpFolAFvchBsK69qPcYJWnBYspMoVtqAXRZWcXSevT
         +hl6gfh8LdGW1kY1+6NAbyoGtjbmUwHktgyHSaUqetkxAHCpGpEpxnubBiuX8WXfEF/v
         ZtfLOR/ST6Obbg7SxwYX7THfV1kYGOuzOgl/6lhVQs9h7+pQFcdCPwnfS2WUFpZca7HL
         ehtoTSIDnLS9/cnDge8/wCfowmTuX0HAx4ap1uNQXrUBY12nfu6KAAJxtPR0L1CWS6gB
         cH5km0TOFMtn/08YnDTeMOfH9QQ3p45UT01pKtZbfnbXB8c7nWcvEpxRA6isSoWxqa6M
         PjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512194; x=1734116994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M+0bej2RwysPlBJMhst5e+vBUfhaolesdLs+7s5XfiY=;
        b=t4ZIpuLaSZwFpZW+miC1XdihTN1cb1PSr4gwnJaYiuY/JxQhVwsIQ5Hrc6gr6Lz1LK
         AS4nUlZ9g4px356kBVPU5qIV9Watk0bIJFTntIwsKkzX4JG0wv9taMV3fXzZoiJdKmX3
         H9SRnXVd8pjmWXvgKBy5/1kxG2muB/EocK0KnksON6+dSxBcJdy6du9uG/n0WzWKgAUk
         E+MvWVR1ovMOUWehpUTkX8Ed5pCp2xbc3SBKT0ExZpNGdKqJQt/faOGmj0JiSpp0Lkhv
         NBF4+nu5MdnuJY9fbVXHzdzxSmk7jezIdmjlmTZK+k0ns7IZz3rrgyl2cKiTgQkBsRfB
         tGmA==
X-Forwarded-Encrypted: i=1; AJvYcCXHN3kObRcDh8uw0cOPIr6Dsq8YGnComScNgT2GPljUu4Co1RKfF7/tyrmQQYKNjbFYKWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIosCBwt6ssel8smBMMcfwNtHVIDzDMKy6oyecaaGfAuZUmD1+
	lr3Sw3PoxNnOQgqvKHAF6TZVqQq1ErJVMZcswaWk4xQznWPR/mPQ/bs51H3yPv/L7x9YHXYaDtc
	6VbidNoMNLoR6wVoXbDThtbT8g08=
X-Gm-Gg: ASbGnctiNNKgyl/xAU5lc7clXSKUfoDdnLLIWci6qGRbga/je7Prf4d0MBVAP3zfIl7
	fK3yYDPRb9eVaeFD+TEIQKQKecRws8SVcNXwoy+eC7d5RMn7yU0t9KX1qJIvYWpyd
X-Google-Smtp-Source: AGHT+IE5QX5BjXK3+P5yXRoy1wN9CZkJhYmz06guJy/dyc0+sv+lzGb0x8zdI1OFFYp85oSOxza4dvvNgrBQrO7JY0o=
X-Received: by 2002:a05:6402:458a:b0:5d3:ba42:ea03 with SMTP id
 4fb4d7f45d1cf-5d3be67ff8amr4325500a12.8.1733512193785; Fri, 06 Dec 2024
 11:09:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206161053.809580-1-memxor@gmail.com> <20241206161053.809580-3-memxor@gmail.com>
 <CAADnVQ+_XGVsxYji3WYNj1-KhYZwKaFCgQ6aN=yFB3YWpRT78A@mail.gmail.com>
 <CAP01T75PQ3RENtQMD+JkB9DZcsUYp+AH6VJURGO730DkuLUMmA@mail.gmail.com> <CAADnVQLrPWQe__jPWN3SPvJkOQc=7LxfesB74XH8Er052_wixA@mail.gmail.com>
In-Reply-To: <CAADnVQLrPWQe__jPWN3SPvJkOQc=7LxfesB74XH8Er052_wixA@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Fri, 6 Dec 2024 20:09:17 +0100
Message-ID: <CAP01T76fOtcpif8m81KrX7VTCM-tecAcDWHrhH3ipfOmiuHhKA@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Do not mark NULL-checked raw_tp arg as scalar
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, kkd@meta.com, 
	Manu Bretelle <chantra@meta.com>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 6 Dec 2024 at 19:37, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Dec 6, 2024 at 10:11=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> > > I think we need to revert the raw_tp masking hack and
> > > go with denylist the way Jiri proposed:
> > > https://lore.kernel.org/bpf/ZrIj9jkXqpKXRuS7@krava/
>
> ...
>
> > Jiri, do you have the diff around for that attempt? Could you post a
> > revert of the patches and then the diff you shared?
>
> the link above.

The link only has information about one tracepoint, but further down
the thread Jiri found more examples and the case of IS_ERR.
https://lore.kernel.org/bpf/Zr3q8ihbe8cUdpfp@krava
It would probably be good to add all of them? Or did I misunderstand
and you just add PTR_MAYBE_NULL for the scheduler tracepoint in the
report?

