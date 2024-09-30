Return-Path: <bpf+bounces-40610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1F498AF3D
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 23:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E905281D82
	for <lists+bpf@lfdr.de>; Mon, 30 Sep 2024 21:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B441862B3;
	Mon, 30 Sep 2024 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoHFOyuO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090B1185B6C;
	Mon, 30 Sep 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727732177; cv=none; b=OXogrGmuGOjsG+3BWpPBlWLXbI0GVHRyx9DJQ3HkUJEJFsw8XS4yrlb3xhAR0bE4MFEVnVuco2UFd7kpR8L0GbjYe12XDHhb4f2qUr6cw1jMN0CWU2zjLMmLKcsdICbqjIrrB6BUKob7tCQM0ysMHyV4fzhHbAvk08T5CVpFcSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727732177; c=relaxed/simple;
	bh=k02XUBa9+wpX2FZnkvoUVuInnmEJ6y/+XBW0GCOsVwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZYOEsfWOQCuxIx3+zGroc/fYsczmMxj/4zVXv8A7n2tAd/GEtkMiO7iVvEtkBBJYHShms8JMSb8tdFFT1JBsdm6g352R7G/Srdv6xq0JP/ESMydpSxQYssZjmTRKZIquM8G0QoQLBT2FDtPw8OBjN42HiuikYtoO09g5VMQatvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoHFOyuO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e091682cfbso3576615a91.0;
        Mon, 30 Sep 2024 14:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727732175; x=1728336975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FsFd/z51CGvNHeNsX3BxpzyCmfKTQ8xbZ+AL7OjH0Q=;
        b=XoHFOyuOK7yG8Y+ia7lZm93/rljRZMFBLZTCPkBWDUfx6Van3bp6YAZIL4W/kyCrwt
         Qtpn/9v9aH9B2q0FYwSULiWeshEAbeeflpebvxrX9mefJnMlP0Hm+sD9z22TNB0eju+q
         peh9EKcCOWkzG1NnwJuAgemaOcetMsEcbp1jbhD9KOzVPovNFsmmkuunGDBEeM2ilWdc
         ORnmrY8c/cHv6YFfYx6BNYSBLzstaF81CeBtFqD29AMUE8SQZkiucr1sytGETXaCUKgp
         +Y/WDCIPAzlkayGuoQnG690a6+q0y3etf0CW6pPv3PtvYDaibPyf8SwfHviFvh25RY+r
         UZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727732175; x=1728336975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FsFd/z51CGvNHeNsX3BxpzyCmfKTQ8xbZ+AL7OjH0Q=;
        b=WcIHSF3xdpkR+/Su4SfU9q2AQtx5albzujHt4o+gn8wNjuU6Y+OOLI1U5pAdlKdgt7
         WPj5eDXglYrHaP1oj1bXEg0zAuLblND/mPFX5iqrNU+WMqz2T+pl4VdYHPlxZCCuZWM1
         A+1OMmeC39ITULLgdKV0w8dH4i8Hnilo1T/xAuiHRX061ocDsXfFpJRNHXuJ0panY3/C
         SNbHYD2xNBlI05qNKFx1GzJLQlDscNdfK0ADaV2AAAK2B4ZcsUdigK6MzZHMtAqX7Ujm
         Guk/pZNPely+OkDiXqJWJfBXEZJhD38jJ22ZEbQQSdiYmWMhwWOQWWhWQwi4KUQMzJqD
         c6Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVVnrTHQPqWDuPUuwHCIOrlyrZlcRZc7MSSwa+pRTbYC7FGHM+XZdpnw+Tz/rDvLxlWmjo=@vger.kernel.org, AJvYcCVgViIBbZKe/GTOnVl44ArSuRW3yIDvntweFdCbI7rk2ibkvyJ6XBO5fc1/AIs0ZGFsWMPbR6uoiljaTrHY9X32fnuj@vger.kernel.org, AJvYcCXurtDVtXLihAEnsRVrfDD9WM5WYXRAhBMAoo0b74enUP0im9CLCIdw+EBj6qGe4wIsYu60T3UmJMI7gFL6@vger.kernel.org
X-Gm-Message-State: AOJu0YzSTdzpUNppBJHeG2ZNj1ZmQ18L7pJrAQE01N+k6tjiuaYhcCQI
	vsXJrPcW22/eBDhNOEpyB+rscNKUXbOZgg2gqOa58CUL1LwhXFFPLQZ75Im7fGDHJyDfxCkHC/X
	7VKLrZ51hIEEyUgcehzw5jyxNiRQ=
X-Google-Smtp-Source: AGHT+IE+gX2bZJRRGt1uxiOW8vIdtiimL0DQdSWo23zdCEzRNMBIFwf9WyrGEmiBXORXnFuNv1HG4UA5jmEH61kIbWs=
X-Received: by 2002:a17:90a:8a8c:b0:2cf:c9ab:e747 with SMTP id
 98e67ed59e1d1-2e0b8872f4fmr16887408a91.1.1727732175343; Mon, 30 Sep 2024
 14:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929205717.3813648-1-jolsa@kernel.org> <20240929205717.3813648-3-jolsa@kernel.org>
In-Reply-To: <20240929205717.3813648-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 30 Sep 2024 14:36:03 -0700
Message-ID: <CAEf4BzZ+1=YU=61mVup8pAc80SOvNuYtMzNdz4miH+Sm4qV4ig@mail.gmail.com>
Subject: Re: [PATCHv5 bpf-next 02/13] uprobe: Add support for session consumer
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 1:57=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> This change allows the uprobe consumer to behave as session which
> means that 'handler' and 'ret_handler' callbacks are connected in
> a way that allows to:
>
>   - control execution of 'ret_handler' from 'handler' callback
>   - share data between 'handler' and 'ret_handler' callbacks
>
> The session concept fits to our common use case where we do filtering
> on entry uprobe and based on the result we decide to run the return
> uprobe (or not).
>
> It's also convenient to share the data between session callbacks.
>
> To achive this we are adding new return value the uprobe consumer
> can return from 'handler' callback:
>
>   UPROBE_HANDLER_IGNORE
>   - Ignore 'ret_handler' callback for this consumer.
>
> And store cookie and pass it to 'ret_handler' when consumer has both
> 'handler' and 'ret_handler' callbacks defined.
>
> We store shared data in the return_consumer object array as part of
> the return_instance object. This way the handle_uretprobe_chain can
> find related return_consumer and its shared data.
>
> We also store entry handler return value, for cases when there are
> multiple consumers on single uprobe and some of them are ignored and
> some of them not, in which case the return probe gets installed and
> we need to have a way to find out which consumer needs to be ignored.
>
> The tricky part is when consumer is registered 'after' the uprobe
> entry handler is hit. In such case this consumer's 'ret_handler' gets
> executed as well, but it won't have the proper data pointer set,
> so we can filter it out.
>
> Suggested-by: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/uprobes.h |  21 +++++-
>  kernel/events/uprobes.c | 148 +++++++++++++++++++++++++++++++---------
>  2 files changed, 137 insertions(+), 32 deletions(-)
>

LGTM,

Acked-by: Andrii Nakryiko <andrii@kernel.org>


Note also that I just resent the last patch from my patch set ([0]),
hopefully it will get applied, in which case you'd need to do a tiny
rebase.

  [0] https://lore.kernel.org/linux-trace-kernel/20240930212246.1829395-1-a=
ndrii@kernel.org/


[...]

