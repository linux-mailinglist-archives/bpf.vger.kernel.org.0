Return-Path: <bpf+bounces-39381-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1CC49725D1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 01:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918EF1F2476B
	for <lists+bpf@lfdr.de>; Mon,  9 Sep 2024 23:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69F918E744;
	Mon,  9 Sep 2024 23:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a3hAc4dq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2018E36D;
	Mon,  9 Sep 2024 23:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725925484; cv=none; b=nhlBTuk5CIDOC2c+RwixyFIIVjit7Yv+8SZJTHDFRFyauMtLx1i/DlcnCsgJq9XlgbKQyVpgVM0WuH10xHRsgT/1VQWYmHdzksEWpH1+PlSTTg9FTHAbCKB+ZzQ6E8YmVoG2gIUV1VyETMqEZyjGMUs5Pn8zqnQqfmF3DU7upCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725925484; c=relaxed/simple;
	bh=kYZ/I57SsA/W5+gi6v/qa5xHJSNC+sdzU5GnYWnTkFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sgg1VtTf8SB3uPpw3kiXN9Euqain9zraY2IPvmOMThwzrBX9G5lLy6z5kXuNFO9w9Z6F/TUqHo2t5OTdFg94MrASITDjGyRKiKeW7cUsfa3QFxMtoSAECFmwceKphhuafQjYL898WcYzFiuhVCv877sAr5UU5WcAugA10OwqRHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a3hAc4dq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso1009696a12.1;
        Mon, 09 Sep 2024 16:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725925482; x=1726530282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NN7AlekWXlDucnAch14oF/iRabhy/qPu+UaSN7WN82c=;
        b=a3hAc4dq6fVuIUIAYAqHOz0N0AZ6ImPN5zaMNUYg7yHYVOFPKPcvfBVqa7QM2Ml6Xu
         ZvEr6xv0CTd4Nc0G5aerN7G3MJuaehOhMzbSv3AOqPvyVA2o2S6wtaK3muvfeEl8tvMz
         FLeOh56fzfsPbnh6seSJbWQQdYIXFZ5ohFct9nAQCs4jT0j1kwAPBXzhODOazlSlmxE1
         vWHXXU0+ihHYwZNtfQNCBmkpN0/jASsCJFotx3F5DTuE9YhWiigaOlFzRFmjvpov3aLv
         AAsSLGoAkdMR/f2hxTh44Ud0dbEYATz65PZqJTFUC7u8ZSZ0QZuy/730V1RNwxLfQXGD
         gQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725925482; x=1726530282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NN7AlekWXlDucnAch14oF/iRabhy/qPu+UaSN7WN82c=;
        b=vsRYRdYHpSwHYOqywb0SrONsKL8NToDCCLg+s4usqa0NiNC01v4M2Bkzd7RMpqcaWo
         gZYFvRllqy1+xLVdupv5YxgZHaHwXp2IDo+x0GYUp/2WfeUYjFpzd2aBVhLQJjFrlIa9
         48PfQrvU5lJC4KwKaDffni+YNjrHI78j0DUSqDWfv6V7KJOiHC3noH4XZB9+ecyB1LqO
         9ezA86V+9OUt8W0yVSav6GlR+8QkM+7m61WKO1qvIrUIWokVML0y9lC36K46214Weurd
         J/CbSeYK/zND0tTBGKMteZOVgg9YFJSUYKgyosvCdfZckG5RRs7S/4Z7/l1J4I8y4A7S
         +iNw==
X-Forwarded-Encrypted: i=1; AJvYcCUKrq4m8hDVjtjZP/JAlfpfYAuGlyeTrP0ZcRgVngnxcubL1rG+n3PaYFAtXDPZuswKvc1oPQjkCJPCR8Fu@vger.kernel.org, AJvYcCWccZ/Kv7SPZzEtL3QT4niwZMEe/WU7k2h7FCnPPQEfpG+2a7bObLNo9IkW4v96wqzsfIErUo7DkqzbdGfzlzviNFAu@vger.kernel.org, AJvYcCXDuvrxeIdbU6ZoNN/p9xkOnQCmqbLDkkf4Sr7o9hs6seAZgMuX4M0g8NwJOF6CTSL0IAU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXBWXhSOIv8MK+fTsahGJcBp6XHpr5W+9YkQwLaVe9JjTZwUt/
	v/5Tz9+GClSD8NWdVA5zL4uOhI6aJcJIpr7jDAnq8K2L4L/jJrr+0tOyJhfDOnB/Lh8nWF3vDbR
	OWbUOpZ3CK5/KH6Aq22+M51Mc6io=
X-Google-Smtp-Source: AGHT+IH0nhAzCOz+EPKUSOiwhx9jUyM5vroObeCxkkupswdTP3tG3lrod2iMsF62YrbOCAOiFRkHoK2WmtCUU/MQRXE=
X-Received: by 2002:a17:90a:c903:b0:2d8:8c82:10a with SMTP id
 98e67ed59e1d1-2dad5083417mr12302805a91.5.1725925482084; Mon, 09 Sep 2024
 16:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909074554.2339984-1-jolsa@kernel.org> <20240909074554.2339984-3-jolsa@kernel.org>
In-Reply-To: <20240909074554.2339984-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 9 Sep 2024 16:44:29 -0700
Message-ID: <CAEf4BzZ0+4Hd1xESWgE2WhSsNEuNuxtTju+OQeGiY0_iZsZbXQ@mail.gmail.com>
Subject: Re: [PATCHv3 2/7] bpf: Add support for uprobe multi session attach
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 12:46=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding support to attach bpf program for entry and return probe
> of the same function. This is common use case which at the moment
> requires to create two uprobe multi links.
>
> Adding new BPF_TRACE_UPROBE_SESSION attach type that instructs
> kernel to attach single link program to both entry and exit probe.
>
> It's possible to control execution of the bpf program on return
> probe simply by returning zero or non zero from the entry bpf
> program execution to execute or not the bpf program on return
> probe respectively.
>

pedantic nit: bpf -> BPF

> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           |  9 +++++++--
>  kernel/trace/bpf_trace.c       | 32 ++++++++++++++++++++++++--------
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/libbpf.c         |  1 +
>  5 files changed, 34 insertions(+), 10 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

[...]

> @@ -3336,9 +3347,13 @@ uprobe_multi_link_handler(struct uprobe_consumer *=
con, struct pt_regs *regs,
>                           __u64 *data)
>  {
>         struct bpf_uprobe *uprobe;
> +       int ret;
>
>         uprobe =3D container_of(con, struct bpf_uprobe, consumer);
> -       return uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +       ret =3D uprobe_prog_run(uprobe, instruction_pointer(regs), regs);
> +       if (uprobe->consumer.session)
> +               return ret ? UPROBE_HANDLER_IGNORE : 0;

Should we restrict the return range to [0, 1] for UPROBE_SESSION
programs on the verifier side (given it's a new program type and we
can do that)?

> +       return ret;
>  }
>

[...]

