Return-Path: <bpf+bounces-48454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A17A081E3
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 22:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EF5B3A7605
	for <lists+bpf@lfdr.de>; Thu,  9 Jan 2025 21:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9428720103A;
	Thu,  9 Jan 2025 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTPEYpWP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5D784039;
	Thu,  9 Jan 2025 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456456; cv=none; b=DbdKfxJarnAYHB8mrEHDXjssK8/uFMz0hFBPFvqlSzjB5grdgNe7OcWBSzRmcPSbe0pA+NROKhmliLI145B0LlRIZewyHoGH5UOvrltfX4mHio5jRBRQ1SDpveu1xCC99zYga3jfUiylLNvinP9W3ypcCDZiMtfshmMKtUofAig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456456; c=relaxed/simple;
	bh=Q5sloWC0XD3XntFZ+G6y8whzzMkPZYU9nX/Tc1fuumE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag5FESxe9qVhxS6yFLCJ72MRLNlvQtAKmGaxeym+DOCXHcAwviW0x96XV6UP1MXXofZFU756utNSdrxSsPIt24rCgCbv8GqprR2LnCvU1aFAcuekd3DKb95DP+aknoiWguSABYFbgHpuZ/mChneFsSWLhAocVW9xWF7/HuFzc3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTPEYpWP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-436341f575fso15266615e9.1;
        Thu, 09 Jan 2025 13:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736456453; x=1737061253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5sloWC0XD3XntFZ+G6y8whzzMkPZYU9nX/Tc1fuumE=;
        b=LTPEYpWPpC4TeFJ2iQ4PQR4AtUogpflkHDybKGwBNWyQ1i6csrvbsWwcPlNg3ns3Fz
         /M6j1+moefqOPDa97mrjVRusb8a6Jhz0/B59Dz4Plox8C19ovjR3FojEvLN7ke8hlRM0
         h7234YJ6g0v0Tk7XQnLu1K5mq4vTUTbhVPkSBkAFPcURnMW6MxRw/8MbOvJwwwosi5Uy
         RLjSDJHmDTP6bfT/ynGm2RrNK/0nfkDerht7HwtzR7BUMyOR3HRmNnukTXs7jXZqovUf
         yqH+H/+pgKPHRS9MGIq41Vihj4GIyGYSBGRg33rUCXPvxPMielFBnRpi0P8UNYPajzAv
         NFBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736456453; x=1737061253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5sloWC0XD3XntFZ+G6y8whzzMkPZYU9nX/Tc1fuumE=;
        b=gq5eHDPNrc9aGqLRSUCa1lpAwD9wuAGHiZ/gwmdk1BW3smG7zL8cY3awHCYjpOX+9z
         uKAferoE8ae3yvBswCUoMf2kfB1ZF7x1GJ562j+Z5tQy2J+GAlPSvf1qWP9M8b2phRdx
         pHMagZIUpqgNLJmvGVOfgs9EDZzoioNK7859Cwujzv2j53L5biduUbzYzR+D77v+ASDv
         YzHdLvP30mmmDCP3eawsVLSEjrnHAcDWU/uRueBDnaJ3i0hNpqc5Qqj4up9K/rjfJdAm
         vwwuaQwXVyeQV7/7kdgMFMqj35ybRB+7Mm5sxmvY7Py+BiDfrAEzcXMj9s/iqGqs+FHm
         TqaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2ebKwqO+xGezFN7dQ3K53NOwPCMjozznaocvXXybj2GuT0klQGVn//NW4lfMvkEFPJbg=@vger.kernel.org, AJvYcCVxXEqW0Kh/g0PZ8jEtMnuI9bQsiRjBHXjA7b7zRN8lY3Gy2LObLt9JRO/0fNr6SWuMxFWdO7oEY8CMihdtoHSPrLdQ@vger.kernel.org, AJvYcCWdkXiJAsRecU4XDGWE7MBhOuG3z+0B+W0XaBWT3rsZu6cgmLNx+yEFyU01aogV+At7uAIVwP+TtJWz/Jc7@vger.kernel.org
X-Gm-Message-State: AOJu0YxJQyiW/g17wjf68HZ0raULFCMaCJeQdj56g8rwl4qza/jxxWn/
	AFaUropcstUk2k2v1x8p6RTrskIGlUiF//llgagBHkv/M8CCjlJtIWHvSTArs1Yg62DXQkwKdvN
	UHfNR8huA1vTvoiS0uZOTtDAOoOA=
X-Gm-Gg: ASbGncuvSjLXiRRfPJ1oVPGubUAZ0A2sl8UHV8ImzM4ZsXYpCIKsPKLtvA6GBkrmF02
	axbNNpzpzCr/mpVjg87V1gWJMp+LYrXx5H5XfML2VzL0Nz5gUDVmzxA==
X-Google-Smtp-Source: AGHT+IFqq8ZZKVIvBprE7am6E802LxnowU0hGPFr3qUga79evU5JYCqCqEg/h6Wmc85upJJwdEnvXZJRaFKm01iO29A=
X-Received: by 2002:a05:600c:6b6f:b0:436:e86e:e4ab with SMTP id
 5b1f17b1804b1-436e86ee529mr55756995e9.30.1736456452479; Thu, 09 Jan 2025
 13:00:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250108090457.512198-1-bigeasy@linutronix.de>
 <20250108090457.512198-26-bigeasy@linutronix.de> <CAADnVQJPf9N1THd4DXbOC=UthYvaPmOm5xQD2rcFunGXp6h5_g@mail.gmail.com>
 <20250109205440.J5EYqOuu@linutronix.de>
In-Reply-To: <20250109205440.J5EYqOuu@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 9 Jan 2025 13:00:41 -0800
X-Gm-Features: AbW1kvYt4BfX6nA9Vnj0VAXl12Kutd__cQawh9YzS37vxfskr-yUK4kBtLFi0qg
Message-ID: <CAADnVQKOB0AB+VGuO5aG6LCMdfkEp3ACyDmqkX0fk9nFNeUmDw@mail.gmail.com>
Subject: Re: [PATCH v3 25/28] bpf: Use RCU in all users of __module_text_address().
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-modules@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 9, 2025 at 12:54=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-01-09 10:38:03 [-0800], Alexei Starovoitov wrote:
> > lgtm.
> > Should we take into bpf-next or the whole set is handled together
> > somewhere?
>
> If you don't mind, I would hope to route the whole series via the
> modules tree. Some of the lower functions (__module_address()) check for
> disabled preemption and will trigger warnings at runtime if this gets
> applied before (earlier in the series) the check gets replaced.

I see. Then

Acked-by: Alexei Starovoitov <ast@kernel.org>

