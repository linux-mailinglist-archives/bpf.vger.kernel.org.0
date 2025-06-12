Return-Path: <bpf+bounces-60550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51E97AD7F41
	for <lists+bpf@lfdr.de>; Fri, 13 Jun 2025 01:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E7B1897448
	for <lists+bpf@lfdr.de>; Thu, 12 Jun 2025 23:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2512D8DAE;
	Thu, 12 Jun 2025 23:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3c7QWtS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AA01B0F19;
	Thu, 12 Jun 2025 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772610; cv=none; b=Srfet6okB3FRmFX7jwXuQyzFvDoUXTO9/T0//OBlHWVvlPecyMvpF4TCqGTE442cxQ5Dglia1cch64emFMFNOYmLMIIKC+/DoUikqQPVnkBrFdiTJeAiThmI9FkoHq28Lvd5/bBs1T/r4ynZb6LPp5NGpZA6rlqXllIagWtyEQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772610; c=relaxed/simple;
	bh=XpXzmFLbZEL2tGyKDgGWORGNARTe6Z7i23Dzsc/2GdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY9PoR98n2hSXmp8lAp32wppMXXmSApyqbbIJ0Qu5a+T5AiT8VqYv6CsawC6Gyt3+6enZJl6lqJ14zNsEuQLy+CbKAl8w/pQjADQwTX7t0dTTZEJAdsC99VY4maHlsW40/p7C6TDoDOf2Z9DXmSpBsY+03W7nwY2/XkyXRNbqjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3c7QWtS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a4fea34e07so947816f8f.1;
        Thu, 12 Jun 2025 16:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749772607; x=1750377407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpXzmFLbZEL2tGyKDgGWORGNARTe6Z7i23Dzsc/2GdE=;
        b=B3c7QWtSxbidwfS8QuoJ87DkEWiv6acN+VvtSSVZaaXWKXMGzltVhCg5Sa4wLlck4k
         7JTKhMzJozyzfFT24E0oLYNnOEyjSO4suaXMKGF7kWiaPKkaw9bH+812S8d5Yp0PaTSP
         96CvXFpl5OSqkulZ4/iqpJLIV41Uz7bysNl2BFMTLTwab9rgbCZ5OYETkoZX/0Ai/ngF
         JftcUrK2moxjDl0jEzyIRHTHEl5/KkLGbgmWy5SwQPj8fWQ/DD1Y17eLtR7djPgI2mQX
         ALzAkm8EPWswpQ1TDGN6GFmLdjijE5G6idBLr322jB9Grso3qmrxuvkmobtwYV0qNcR0
         uKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749772607; x=1750377407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpXzmFLbZEL2tGyKDgGWORGNARTe6Z7i23Dzsc/2GdE=;
        b=GExZ5zE7SBVcNOoTvzj5bNXX4jUCpXLgMDw4ppe39NINlzKK+svpjvH8s7SpkHXDMh
         HqgVueWlzHxorEPe0TK6WNGLoJExckyeaUwcGeLqQwZTd333kioXZlnegxgdHzVZ88lv
         PiX7RxfxRYuiwk6T6wQF5uqe/5SoFnVIkV24A/bzAJ7wUNi46vAR30TxWwBXfq9zbUtC
         2uR/AzFBByGtgmnh61RMulIxl1IPpR5yn0se96wcIYMc4+CT/A7lY0CbOLtNCddC9ha9
         H2zRnH5ElADaXnxix4V7g23UZWtwadgyFhMTEbXpuIFJs3RfXoe14v6UQQ7Wk0C+HtwM
         6HFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd0YJSe2ZGgKglSBoNq9Qm8abyiGhR6fdTUU94i1RBBVPYGQujhbO3DlO3b+V9YctGpohJ4yARf/4ONSUB@vger.kernel.org, AJvYcCWfmy2erZ+jkml4yjPaTs/zRuwdl41A7mMAjJ/7zmQgOUPAWsZQODMQQj2XsjMHum1DyD8=@vger.kernel.org, AJvYcCXIIER0aUtaB3RpxVuATyD5Ybzi42eLVCxBb7Od+W06GeYdFonqoRqky2b9h3J6Kx/TmniibJrbIbqoafm4ECGXOZSp@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkl4cY7nWcI/o7w+3VF8dcClFz3ZVt23eGE5OnHW9X7Mh6wu3
	ANJW4zMT7Vh2Q1fAI3/2gAgr9vksQ0Row/zBE5mM9hxPs68Z3xV8BQ8a9O5/pJhAxxc6MK7U+JK
	i0IT9Yu89Zazhvv2BbxRAgrdPPqYnOVM=
X-Gm-Gg: ASbGncvWR/p8xH8JjU04o+xqkJb/iRF0VYt2B/+YFd9VbNTf+KyFeRpeman3aJECFoP
	gTtmYKNXKr7FlR+Futl39iSRnZBh4RwX6xZlSONDcSX98QQsjYnx5zCB+k4dfXGFdaVvndtki2n
	s1bXRZlckyTYNvDS3lRLYsEWlHYEejvV4CgAx6PR6tu1Z559Ox5lmvaka8wRcj97QeezFHpzxio
	buYOTCdkI0=
X-Google-Smtp-Source: AGHT+IHeRAAifYf+ljSgH6/oKOJK6Y/hkLqmasJbneu7HU1u9BPrDR5QXhcT6XKGgiDZMLD93vIESy1R4qAwez7ZvGQ=
X-Received: by 2002:a05:6000:1889:b0:3a4:ea1f:3534 with SMTP id
 ffacd0b85a97d-3a5686e4504mr811554f8f.5.1749772607087; Thu, 12 Jun 2025
 16:56:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611154859.259682-1-chen.dylane@linux.dev>
 <CAEf4Bzbn=RVhMOR7RapYwi+s8gbVS=1msOuZ7MhPvgz8zHiE9w@mail.gmail.com>
 <CAADnVQJ8cVi4KyJqWgEfyWYs+zSYQ73PevrNszPkisrdPSjYMg@mail.gmail.com> <CAEf4BzayBd9e5c9fiEPgDKPoRm-E4uB_u__xKcRpXDz18kNnkA@mail.gmail.com>
In-Reply-To: <CAEf4BzayBd9e5c9fiEPgDKPoRm-E4uB_u__xKcRpXDz18kNnkA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Jun 2025 16:56:36 -0700
X-Gm-Features: AX0GCFvzDp5b7L5pNMYWkvU4e4tmq2DN8N5PdOM6XoTqTHMKEVfcYvUDafKwKfg
Message-ID: <CAADnVQKw2u9y-Cf+8idB0bZ0v-p6BtuyRV=JpmN4to3_1Z6GEA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: clear user buf when bpf_d_path failed
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Tao Chen <chen.dylane@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:27=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Jun 12, 2025 at 2:40=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu, Jun 12, 2025 at 2:29=E2=80=AFPM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Wed, Jun 11, 2025 at 8:49=E2=80=AFAM Tao Chen <chen.dylane@linux.d=
ev> wrote:
> > > >
> > > > The bpf_d_path() function may fail. If it does,
> > > > clear the user buf, like bpf_probe_read etc.
> > > >
> > >
> > > But that doesn't mean we *have to* do memset(0) for bpf_d_path(),
> > > though. Especially given that path buffer can be pretty large (4KB).
> > >
> > > Is there an issue you are trying to address with this, or is it more
> > > of a consistency clean up? Note, that more or less recently we made
> > > this zero filling behavior an option with an extra flag
> > > (BPF_F_PAD_ZEROS) for newer APIs. And if anything, bpf_d_path() is
> > > more akin to variable-sized string probing APIs rather than
> > > fixed-sized bpf_probe_read* family.
> >
> > All old helpers had this BPF_F_PAD_ZEROS behavior
> > (or rather should have had).
> > So it makes sense to zero in this helper too for consistency.
> > I don't share performance concerns. This is an error path.
>
> It's just a bizarre behavior as it stands right now.
>
> On error, you'll have a zeroed out buffer, OK, good so far.
>
> On success, though, you'll have a buffer where first N bytes are
> filled out with good path information, but then the last sizeof(buf) -
> N bytes would be, effectively, garbage.
>
> All in all, you can't use that buffer as a key for hashmap looking
> (because of leftover non-zeroed bytes at the end), yet on error we
> still zero out bytes for no apparently useful reason.
>
> And then for the bpf_path_d_path(). What do we do about that one? It
> doesn't have zeroing out either in the error path, nor in the success
> path. So just more inconsistency all around.

Consistency with bpf_path_d_path() kfunc is indeed missing.

Ok, since you insist, dropped this patch, and force pushed.

