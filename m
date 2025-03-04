Return-Path: <bpf+bounces-53156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B040AA4D169
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 03:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24F3A3AD25F
	for <lists+bpf@lfdr.de>; Tue,  4 Mar 2025 02:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05596155326;
	Tue,  4 Mar 2025 02:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coBIWmTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1766333D8;
	Tue,  4 Mar 2025 02:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741054141; cv=none; b=VHtEgo2E55Lr6OJCZgifmaviWWeq/plb9lyli2uXofNMb5WZZfX5vdP3DhAC9LCwb9Y2mh+on09tP9hpA5x2NoX2n1yDQbwCz/G+FmHMXe8rr8fJaiDn+1pI5TI5D7eDSFPSL+AaVexnwnrBxO/0tcWzaE+mwjnmGtekuzhIBwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741054141; c=relaxed/simple;
	bh=CMTlN2042F1cPygssJ1pVpNt6nZSTMZWYy14BylY0bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SqjnS2VxhdgMdPiYLCRlgHYKgyI+QYWkXoy57NtCAgkRLqPh48vU8xnA7ZXfmK8WXWCboZgZvE9i+0fRduyQi3B/ID4mGvW+mDuIRtF1GUQgoSCi1dgUikTV3/7578w6Eunb2/VA8g64Ppwk4AQi3islRzHidd/IXSgMzrSazvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coBIWmTA; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6fd719f9e0dso15598267b3.1;
        Mon, 03 Mar 2025 18:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741054139; x=1741658939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uprm3w7QSLW+3a1cofYW+cceQk8H3e14YKGxf9c5SEc=;
        b=coBIWmTA++2Am+Yb5/Wxl4cm/Jmd8m4m6FMZ3EU37r7vDTJAvpm7ziCv3+rmw9K3gw
         OdEhi3sg/4S3L/iu1+lLP6LSALH0vndwY7h3EFlCwlTf9RyImP3w1IfyyqXiCqOD0KLJ
         3VKyQ3iraRg3hRdFjG5r49RCHg6rzaBN/x1TC8/sxpHuPwq/lZ558R6BkGNXrHBMJKOb
         VgQAgSaDRs4+5Zr8APidXL7xOPl50Falf5WzkhJyq1zhoPcMk1V0iKt7IB5HNfTYuNF0
         y441qjbaUiLUjxMj0AwLIinLWJytg9eEmkD2Y959ymiuBmMx9dI5DtgdQC/z0iygVdeW
         7mnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741054139; x=1741658939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uprm3w7QSLW+3a1cofYW+cceQk8H3e14YKGxf9c5SEc=;
        b=H4jeAMbLpXjGJ9Py9jceEIPbwhvkqX8k0QC1akzVr5lXRpgO86WFOmLynK5J0tJEjB
         sDT1P3M7Ur6LjFwor3E/OcWzoFGPqEshcvRQVFNVN8biuPLEudHQ7xdCGoighd/AQyrn
         c1J0o7uysMorADPRDTdzwzmWQdRgW+lJABkmFTKom+jqGwddl+QbIgz6VCIvj4OhLiNl
         KQ4imv1xExhm9OB8dpntzzJCH2eoiFBIcsmnJ0DsD2Ryc1WAVdhKwu1STxbIrAShyPRb
         pnjs5MHXEZwA7Yo2V9ku3SlnqQ7yuJnQ0urBCwqY8NdxZ0ydOaQH/4btUZe0VHvdruOJ
         3qTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUry5J3y7bRbaYJgjqK42QOYX38gj1GeuNKTGPd6NLwILxk2CrMwq9lQZplz4nOWHpI6oE=@vger.kernel.org, AJvYcCVYx1fj34nogjAVt/HHdvy0+XDE7BARJrFnQ6qIXqpIboU5P6Atvuz+XHCRephGl8e4sxYJf1XBp1Tk89yk@vger.kernel.org, AJvYcCVur22qSBFFnkFaffuTJP/jc583ny2BNarDOP8muztHvMY+ZGbJYyzKc00a6EADxfz+R/WhHbHx@vger.kernel.org, AJvYcCWbb0Amakf9gd9rseVdy9scwyRRqsHV3AUfEP/5zV3osIeJnDvhRFEbPRmURTdqJ1lIjBNrSpE9uvxHWjuKWj2YNSuL@vger.kernel.org
X-Gm-Message-State: AOJu0YxRdQmUmgePLcIXqiT23pghEYv2HAN1dw7RvUSGR2RXS3lLnHa7
	zlepg2sWDbiFeaIq2gFD1WuJLWWYVr1ISiCHamQFVqjKkSmiyJ0HfeaRxn59hS9oCkRtGJe02aY
	VyffLLseZaKzNhuAf6yXRCxokpYI=
X-Gm-Gg: ASbGncuOxRlUvluJsHHSBAjLiwKdzIFr+j+3tfuIa3B5pYY7kEW4IRMzWnH+Xiyu2yw
	9EokWH2gbspCe+zWTmWG5SeaEwZEMn+mKaqc8V0IFQQ+MHRzkpdOqmXGQ0HP6vfxLdJ4euTTmZ+
	is1c9Shphhgxn/E+si5SQPQY3peg==
X-Google-Smtp-Source: AGHT+IGNh2K54VaqDxAbwZPq6ghZwf/0d9iTd28qnutLtwuc/n0G9myX7k8yUwefwHhFhOUKlgvRS6Iy3hX/wt2iX1c=
X-Received: by 2002:a05:690c:3506:b0:6ef:6fef:4cb6 with SMTP id
 00721157ae682-6fd49ea038fmr219227267b3.0.1741054138974; Mon, 03 Mar 2025
 18:08:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303065345.229298-1-dongml2@chinatelecom.cn>
 <20250303065345.229298-4-dongml2@chinatelecom.cn> <20250303110559.5a584602@gandalf.local.home>
In-Reply-To: <20250303110559.5a584602@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 4 Mar 2025 10:07:22 +0800
X-Gm-Features: AQ5f1JqbmerWbAPhQH3CompG0G6GUmmcqJsAR9G321CVuef2yZdxRX3kR81QiyY
Message-ID: <CADxym3ZJf3TEMwCy4JVT1gs9GP=U1n1qss3ycnuMZVyp9TfDdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] x86: implement per-function metadata
 storage for x86
To: Steven Rostedt <rostedt@goodmis.org>
Cc: peterz@infradead.org, mark.rutland@arm.com, alexei.starovoitov@gmail.com, 
	catalin.marinas@arm.com, will@kernel.org, mhiramat@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, davem@davemloft.net, 
	dsahern@kernel.org, mathieu.desnoyers@efficios.com, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, samitolvanen@google.com, 
	kees@kernel.org, dongml2@chinatelecom.cn, akpm@linux-foundation.org, 
	riel@surriel.com, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 12:05=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Mon,  3 Mar 2025 14:53:44 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > In the third case, we make the kernel function 32 bytes aligned, and th=
ere
> > will be 32 bytes padding before the functions. According to my testing,
> > the text size didn't increase on this case, which is weird.
> >
> > With 16-bytes padding:
> >
> > -rwxr-xr-x 1 401190688  x86-dev/vmlinux*
> > -rw-r--r-- 1    251068  x86-dev/vmlinux.a
> > -rw-r--r-- 1 851892992  x86-dev/vmlinux.o
> > -rw-r--r-- 1  12395008  x86-dev/arch/x86/boot/bzImage
> >
> > With 32-bytes padding:
> >
> > -rwxr-xr-x 1 401318128 x86-dev/vmlinux*
> > -rw-r--r-- 1    251154 x86-dev/vmlinux.a
> > -rw-r--r-- 1 853636704 x86-dev/vmlinux.o
> > -rw-r--r-- 1  12509696 x86-dev/arch/x86/boot/bzImage
>
> Use the "size" command to see the differences in sizes and not the file s=
ize.
>
> $ size vmlinux
>    text    data     bss     dec     hex filename
> 36892658        9798658 16982016        63673332        3cb93f4 vmlinux

Great! It seems that the way I tested has something wrong. I'll
compare the text size with "size" command later.

Thanks!
Menglong Dong

>
> -- Steve

