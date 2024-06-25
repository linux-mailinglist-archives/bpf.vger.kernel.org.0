Return-Path: <bpf+bounces-33111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9401917514
	for <lists+bpf@lfdr.de>; Wed, 26 Jun 2024 01:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A009F2814BB
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2024 23:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0BEE17FAAA;
	Tue, 25 Jun 2024 23:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ndy0CAaA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C451494DE;
	Tue, 25 Jun 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719359808; cv=none; b=hPKKUK6Xv0C/vh5PqhuEz2OxnjWsrnJwuKbu9epl0V9FDGmEb6X/RqXrYolLYTdnMpWclDb37khqQvGZ5T7AlHfiA6fPkkP8SALAMpFU59X7FbkWUr3ZWiNp27PGyla0v5IFRw9Q2dIU9b8v3yEw1oPuGUISl0HtB/YYy6CMKjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719359808; c=relaxed/simple;
	bh=3kmG5XSJ5hljnFChnWgChhUNht6ShHJLQN7hrL7fUB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8GXgjIn6sicC0PBeco4wmYW7DV4gNk2yDgzyRy2TWPvzc1Ew2JFRqoS1zUXielCTzTBIgwnNzaWA48RZTsjBrlEINslfdXRfERZEQNrsrkLfy3wHO5CLtMG0vU6oxa/4LAuajuvMzEBsgFuulFCznFgV4q2x6FE0Aeyyx1FLNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ndy0CAaA; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-366edce6493so2243106f8f.3;
        Tue, 25 Jun 2024 16:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719359805; x=1719964605; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3kmG5XSJ5hljnFChnWgChhUNht6ShHJLQN7hrL7fUB4=;
        b=Ndy0CAaA9OPxPTUR8HfQ2YDqkGW/hE+2Mln1kPMsSW3CpgTpCrIcEHHNmRptXC/vt+
         uEzZ7foDEaNNDGsMOk8zLn8yvSrRqHiQt3fjfd8HKx8v5nBI8LIqkRistsQ47yALgNKQ
         qC8MdBxmfTxbXGiSErmMuA/1Qn3EJz+dlFgkbgwMKxk9UArpAB52bNF4aeaKkXLtcEtY
         82vqUsVgpxV1BOr4yhToDALIjxI/FDbvrgWJQeWIm9D05iD1KnwaJfNyOnI2aEHS2jRp
         0GXTsEfKLkte0CnvMM8o1sG19bsq4KfuQCQMCFV1hSLa+r3KE3Du+O6fC2GbL/EiYe0H
         XiGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719359805; x=1719964605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3kmG5XSJ5hljnFChnWgChhUNht6ShHJLQN7hrL7fUB4=;
        b=fbw51t6F0NRQhkUfuf0q0gX1DJRZtCtTgFs8kc4efWLE5m01Chs1b09Aeg4pZwZw2q
         R7K9Iwoc7JxxKuPjEluYRr2m8jfJOAuTRNJU8PnfwYLjCdeBRUyzkKTnrRv5ejbjYZiG
         AbUI7+lWWl10J4IMUFzr7I8sLA59jjsG347mW+PhgEuSdWCw3pBPMAKGi+JPF8cW+piE
         Vv2cKVYtSu7wUPEqEaC+nIonVGa6b/y7sTxsEHKzQIdgYche6cc5trW+lbpRLAgWswfv
         DRTenA4eQOky1O8oMnUJ/oab1FyO88QPv+JlkN81GgvtVI/bH65SqV9IHfTPqLTFXRwk
         Qjmg==
X-Forwarded-Encrypted: i=1; AJvYcCVd2io5qOapFKNmaab/ctEdRyoP6AtZAxspPUBqfEagezYs1xzW1Cvaq8won71mDAak5MeUSkZU1do7gMfedqudWxCLlqONm6tkg3SZZP/gnaFIZFbnvMHDQqJsCLf5lXqp
X-Gm-Message-State: AOJu0YzPrmdIbiA0ll1AM48y9brTqjH0xUc6CY0BNdLJJ1GUsW6MiYmr
	pylyl4224aTz/PB9u4ahGrjdPyAyn/w/W+Hk0eZTdW0Bq20NWBlIjuHduspL5I6XkYdLMdd8DwW
	39Cp8sV+nAhJppN2Vy6kgi/RRMXM=
X-Google-Smtp-Source: AGHT+IGdtAtaha7dzZVZxOBoUqaxo1MNQ1P24x6wp+VwE5kFQDbxK5Gn+a00McK0tI3tzXEjhLhvhO6QhVqB8D6TAVA=
X-Received: by 2002:a05:6000:b44:b0:35f:11c5:5c74 with SMTP id
 ffacd0b85a97d-366e94cc54amr5128737f8f.36.1719359804898; Tue, 25 Jun 2024
 16:56:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <345098dc-8cb4-4808-98cf-fa9ab3af4fc4@I-love.SAKURA.ne.jp>
 <87ed8lxg1c.fsf@jogness.linutronix.de> <60704acc-61bd-4911-bb96-bd1cdd69803d@I-love.SAKURA.ne.jp>
 <87ikxxxbwd.fsf@jogness.linutronix.de> <ea56efca-552f-46d7-a7eb-4213c23a263b@I-love.SAKURA.ne.jp>
 <CAADnVQ+hxHsQpfOkQvq4d5AEQsH41BHL+e_RtuxUzyh-vNyYEQ@mail.gmail.com> <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
In-Reply-To: <7edb0e39-a62e-4aac-a292-3cf7ae26ccbd@I-love.SAKURA.ne.jp>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Jun 2024 16:56:33 -0700
Message-ID: <CAADnVQKoHk5FTN=jywBjgdTdLwv-c76nCzyH90Js-41WxPK_Tw@mail.gmail.com>
Subject: Re: [PATCH] bpf: defer printk() inside __bpf_prog_run()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Mladek <pmladek@suse.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 4:52=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/06/26 4:32, Alexei Starovoitov wrote:
> >>>>> On 2024-06-25, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp> wr=
ote:
> >>>>>> syzbot is reporting circular locking dependency inside __bpf_prog_=
run(),
> >>>>>> for fault injection calls printk() despite rq lock is already held=
.
> >
> > If you want to add printk_deferred_enter() it
> > probably should be in should_fail_ex(). Not here.
> > We will not be wrapping all bpf progs this way.
>
> should_fail_ex() is just an instance.
> Three months ago you said "bpf never calls printk()" at
> https://lkml.kernel.org/r/CAADnVQLmLMt2bF9aAB26dtBCvy2oUFt+AAKDRgTTrc7Xk_=
zxJQ@mail.gmail.com ,
> but bpf does indirectly call printk() due to debug functionality.
>
> We will be able to stop wrapping with printk_deferred_enter() after the p=
rintk
> rework completes ( https://lkml.kernel.org/r/ZXBCB2Gv1O-1-T6f@alley ). Bu=
t we
> can't predict how long we need to wait for all console drivers to get con=
verted.
>
> Until the printk rework completes, it is responsibility of the caller to =
guard
> whatever possible printk() with rq lock already held. If you think that o=
nly
> individual function that may call printk() (e.g. should_fail_ex()) should=
 be
> wrapped, just saying "We will not be wrapping all bpf progs this way" doe=
s not
> help, for we need to scatter migrate_{disable,enable}() overhead as well =
as
> printk_deferred_{enter,exit}() to individual function despite majority of=
 callers
> do not call e.g. should_fail_ex() with rq lock already held. Only who nee=
ds to
> call e.g. should_fail_ex() with rq lock already held should pay the cost.=
 In this
> case, the one who should pay the cost is tracing hooks that are called wi=
th rq
> lock already held. I don't think that it is reasonable to add overhead to=
 all
> users because tracing hooks might not be enabled or bpf program might not=
 call
> e.g. should_fail_ex().
>
> If you have a method that we can predict whether e.g. should_fail_ex() is=
 called,
> you can wrap only bpf progs that call e.g. should_fail_ex(). But it is yo=
ur role
> to maintain list of functions that might trigger printk(). I think that y=
ou don't
> want such burden (as well as all users don't want burden/overhead of addi=
ng
> migrate_{disable,enable}() only for the sake of bpf subsystem).

You are missing the point. The bug has nothing to do with bpf.
It can happen without any bpf loaded. Exactly the same way.
should_fail_usercopy() is called on all user accesses.

