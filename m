Return-Path: <bpf+bounces-33205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F6919B6C
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 01:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F35BB219FE
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 23:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240FA1946A1;
	Wed, 26 Jun 2024 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jej5LGXt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A32F16DC02;
	Wed, 26 Jun 2024 23:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445962; cv=none; b=e75zhzErJjQSi+dapCWLUvxtfN6rLgy4esM3gfUrSuJTLEjbrjNEaHSN73n6NK4FTZ845o+qMuPESLic+IP3UjV5MyQyYzft1fv+2fTWAHPn8nymuQiECFT84pbvImX9VEXJ6QN+76NqnbD8g0QEE5h8CnXL0RXdKacs0Jq2VEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445962; c=relaxed/simple;
	bh=eXSVMa9ZuGhU5Zc7b9bA7AKEgXdN1amXW0Cfbus4K54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFu6cL1Ax0Klan9U8beTgoe+gucxkc+JAHCX1bEXkJt6tQpAlIjR47lqhON/L9kVBtnnd4fsXC1XFgWklGQvQB9UP21mgmPcDgmuD8NK4Lrxg+wvW1HrKjOmzDhdhSgmuzfB/RAeZjbkRLlOoa3NxdtQAlmPJz6VhIZDFBG53P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jej5LGXt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36743abace4so9591f8f.1;
        Wed, 26 Jun 2024 16:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719445959; x=1720050759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMXhWUzOZmgUOn1YwRUYJlzcPBfHyRxlCCVEehfQ2t4=;
        b=jej5LGXtFYKv2TCGVaxx1l2/hrLuvNoBCSrNgOF9MttSnThZh0XDvTYPnhN3RfElr+
         fSce67jHwC9ODXvr5EVzkHBfMXmpeQAGKuYNyRjHq1YfvjUOO4slvd4CbugbBlUqDUDE
         Wcr4F97yFzIwvzzthFyAzKKxrPorPO8tw3PwJCIYPNh6ncU20i8yNVHDgSysI6OubIEv
         QgIMJvIfiZ9uULxDWTYRwHxpsDxQPA2OxszuIlHhB52cmJFWi7YBuX/Nup3Z95QXdOyk
         yavhaNK7zISMYSTft9oQJUM1tQLFUHCIgp4i3aWt/9cXO7XfweDG4zJnRqrW+4dMfMGJ
         gP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719445959; x=1720050759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMXhWUzOZmgUOn1YwRUYJlzcPBfHyRxlCCVEehfQ2t4=;
        b=k3q5FZsKtyU6Sng6aot0fkkXoUqxz+5Xo/QmWyRVxHyc5xaJZiSgWYdK91mznN7KSl
         txGMlpNoNnn43kCCtAbVpU61xpVFStG/mUbW7FVclp2ug5brq3TUj7Y96wiIM09+vFBh
         RLffGipsjgnWJt924WnJIPOPFyHhMjgA6l2IJJ1R+UakmygHn7CNxAIaFBFLkk8B0WXp
         ZFDosyd5OVTsg8eQdh7wbCQGPkWvyC5bU/sDbNvGQR6BIyIBE47FZ4KTFZp9/0PChxHg
         OFlKpbwNDKHM6/yU7v18qltcgjuXCDh/XrNBbiIBzq1WqoLjDn0FbCb/nkROLLjL53WX
         dmFg==
X-Forwarded-Encrypted: i=1; AJvYcCW295bnEzNRtx9YotBFo+TziW1H2fybanpq6LwjZ4PhRiuitLmSOinfgnthAm8p4vDwrGdX4LqG3Bq8kCjZz9b0XQv1F/1s0sjDYnjjmraqAxd72n9JwHLp50+fFrfMaKw5
X-Gm-Message-State: AOJu0YzfaBDgN8iAcCMTxwwCO+AMhZuG52xY2gaZ7vKtFZv0m4kX11vX
	91kfrV/A+j8oyo973Hws/vBkA6cpLmJpjwhQqgLxctCAr6JgnHdQ7x8FQ44QRZTpmuFQO4iO7++
	u/Tn0oVZC+UZ64O8Nd4KjXxuKGvY=
X-Google-Smtp-Source: AGHT+IEw+d6UF8o9wW6PP5hCb7Yi7hDQqEZZpibIcHoZXKTmFmTLguJhRgy+c3KS13Th3zEBTWT7dWWftytyJTtImaw=
X-Received: by 2002:adf:f70e:0:b0:367:42ce:f004 with SMTP id
 ffacd0b85a97d-36742cef648mr173224f8f.23.1719445959275; Wed, 26 Jun 2024
 16:52:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de> <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de> <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com>
 <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
 <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
 <744c9c43-9e4f-4069-9773-067036237bff@I-love.SAKURA.ne.jp>
 <20240626122748.065a903b@rorschach.local.home> <f6c23073-dc0d-4b3f-b37d-1edb82737b5b@I-love.SAKURA.ne.jp>
 <20240626183311.05eaf091@rorschach.local.home> <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
In-Reply-To: <6264da10-b6a0-40b8-ac26-c044b7f7529c@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 26 Jun 2024 16:52:27 -0700
Message-ID: <CAADnVQJo=FksArWw+m-wb1zKmRTVhJrKWBOiT0wmyK8uvZ268w@mail.gmail.com>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 4:09=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/27 7:33, Steven Rostedt wrote:
> > So you are saying that because a BPF hook can attach to a tracepoint
> > that is called with rq locks held, it should always disable preemption
> > and call printk_deferred_enter(), because it *might* hit an error path
> > that will call printk?? In other words, how the BPF hook is used
> > determines if the rq lock is held or not when it is called.
>
> Yes.
>
> >
> > I can use that same argument for should_fail_ex(). Because how it is
> > used determines if the rq lock is held or not when it is called. And it
> > is the function that actually calls printk().
>
> Strictly speaking, KASAN/KMSAN/KCSAN etc. *might* call printk() at any lo=
cation.
> In that aspect, just wrapping individual function that explicitly calls p=
rintk()
> might not be sufficient. We will need to widen section for deferring prin=
tk(),
> but we don't want to needlessly call migrate_disable()/preempt_disable()/
> printk_deferred_enter() due to performance reason. We need to find a bala=
nced
> location for calling migrate_disable()/preempt_disable()/printk_deferred_=
enter().
> I consider __bpf_prog_run() as a balanced location.

Tetsuo,
your repeated invalid arguments are not making this thread productive.
Told you already that the same can happen without bpf in the picture.

> >
> > Sorry, but it makes no sense to put the burden of the
> > printk_deferred_enter() on the BPF hook logic. It should sit solely
> > with the code that actually calls printk().
>
> How do you respond to Petr Mladek's comment
>
>   Yeah, converting printk() into printk_deferred() or using
>   printk_deferred_enter() around particular code paths is a whac-a-mole
>   game.

Exactly. wrapping bpf with printk_deferred_enter() is such a whac-a-mole.
It doesn't fix an issue.

