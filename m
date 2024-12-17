Return-Path: <bpf+bounces-47149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B05229F5ABE
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 00:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 010441646B8
	for <lists+bpf@lfdr.de>; Tue, 17 Dec 2024 23:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E171FA826;
	Tue, 17 Dec 2024 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ox9+NMbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F41DF969;
	Tue, 17 Dec 2024 23:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734479408; cv=none; b=jxcjQW1tu7Cb8glvz71AkuOXRAllHydJUXZvGd2/YhsCzVRig+6aCu0E0uADJ4OSbPAE2Hfkd7jlxaa8I/dUQNiSA8ZQ5a4qp7DJHx//Hp6hxAzqoICm53BLm3CtoCsKttkkSzc9zaL9BGG1mp7t9+om29ug4JSKHA50IwLbKTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734479408; c=relaxed/simple;
	bh=8MYmdseBPLBEhe2c0PLfxMKJVCcmK2Q2VVftzdN2s5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNA5kIkmGeZ+D/7+u33rnlc3h3N7ST9zNyrRsoM0OkqCtAzuqiy1x1zaFFuSvN3kvb/5MxCMMqYfwzpr82XQNUUcCBZN+ZDXlSv5PqlQ759TRpo9esym9VVBMSfiOKa1A8cuLzuOcyeVsns7eDJ5vNWFnqGgt+4EwzIvP+ngmbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ox9+NMbQ; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so144919f8f.0;
        Tue, 17 Dec 2024 15:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734479405; x=1735084205; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMVWY5KAONPdMPCJ9sRPZS5LWqY32aaYf8BaOPVdR7Y=;
        b=Ox9+NMbQyTGbSiMDu/Rqk0q3yYwPYJarjarzSdlndTyhDPQHzuFa6NX5Eq6TjCW8EQ
         1fnanHB7fDokYl3CONeO3oLhgN067XHM+QOtzzG/ym+w3JVsBSbTtrw/Kh+XTC4hTcG5
         L4vYj2Tf1xmOsHuzFRVRAh6Z5Nd2ye/wgJR/emle6pYxo/Fg+56tCY1cZOgj3jWAi3A7
         C4MmBu3I0c4iZRkvg7CBVX8WbPD3/VBZgdZ8wlNHyeDVxQyiG4qf06/Trcf2NNatZIu6
         tS4CNk6EYXhaogGumO4x0cbTIk1AMFeTI4YryQ2JZ1OEM5lgUQ0PLpT4hWc/E8QpWpYN
         ldzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734479405; x=1735084205;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMVWY5KAONPdMPCJ9sRPZS5LWqY32aaYf8BaOPVdR7Y=;
        b=Li+ybFIAigH2vYIXBTv2s4iraoXzSbYfjHK9fm/jk8Ami0pFMRgU1RZegxEA49YiMM
         1d73+6TUthHsm59R3ZB5IPoz+ph2eBnSBfWSxabvhtAAPs8AefgVo0gkY11gVeI3noz3
         9SujVQSevY/mkf3+e7j2YATa3pUJ9GCJXec2Y2purwflqv7plvluLVLxwJgmDVURM0Xt
         mb2JlTa7SOZCj7QILf2iLhxUDMEd1qvk+Z2wieIrGr+fQBXtxYurH++DfGgavNiMhOEC
         SEFy4f70mF+0lYzzn2RzqjBBkKCd88EWtcUMdkQxC0BMrICR9dL5zJ6++yvRhlgYjyGc
         /X+A==
X-Forwarded-Encrypted: i=1; AJvYcCUy1jhP3Y7gVg20Yz3jFbAzO38QEqSKMrNtPQfPXT2klfbHORcy3w6y+bVrsd9216mfk6K+L2hmBo1gus5Q@vger.kernel.org, AJvYcCVbQyxMVr6MPTcABXfb8M08+x8memxgc9FPsUlUE8PFVRBmopnaJCBEAlG4BhIQiE9ohD2osfZBdpcryoZaSAisP3Me@vger.kernel.org, AJvYcCWYzjjLTHbFyo217uZpUi/IbEaYiZYe7cpapmSu7wgfvu7iN/1yGaR5Mh7crS0vWllV6q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjV7z1o3ahSJdLCgV9lifNSRAmN7Rqf0lva4QGT1O4e+AcF3B
	8spy7Yvo5WfeddDbnffo3/CUXrXdnd3tDFGllkB/cL+ZqKauQi+39BQHTSp2ecV/6r9M2hlxVJS
	5qU5SSzgKkaJbI72EGQ5yiL0gLCw=
X-Gm-Gg: ASbGnctqHiOlX6bBnuw7vzJOsfBvbNx6aDyubvzXh3obj5z/8hVYY1YdllQfYHkIkkV
	kmo18/KeTaH8QJbesnir2k9J+S8rMpihlAzRA60kesDkJQGuFT0ZDYQ==
X-Google-Smtp-Source: AGHT+IF8VTbcA8keGtmi6GH73HN4RLr7iXAdcWKrFkAUuHwNLi6Rvfz5iqO7wbJbV38OgBRP99JxyD+n6+vFFC8Ruao=
X-Received: by 2002:a05:6000:1f85:b0:385:fa30:4f87 with SMTP id
 ffacd0b85a97d-388e4dcddafmr526563f8f.0.1734479405084; Tue, 17 Dec 2024
 15:50:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67486b09.050a0220.253251.0084.GAE@google.com> <CAADnVQKdRWA1zG6X4XNwOWtKiUHN-SRREYN_DCNU59LsK8S5LA@mail.gmail.com>
 <mb61p8qsymf3i.fsf@kernel.org>
In-Reply-To: <mb61p8qsymf3i.fsf@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 15:49:53 -0800
Message-ID: <CAADnVQ+_TUjJ6Ytn96QqtHnBB--muefbbOoAsRw4z=40Pf1+tA@mail.gmail.com>
Subject: Re: [syzbot] [bpf?] [trace?] WARNING: locking bug in __lock_task_sighand
To: Puranjay Mohan <puranjay@kernel.org>
Cc: syzbot <syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eddy Z <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 4:42=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org>=
 wrote:
>
> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>
> > Puranjay, Andrii and All,
> >
> > looks like if (irqs_disabled()) is not enough.
> > Should we change it to preemptible() ?
> >
> > It will likely make it async all the time,
> > but in this it's an ok trade off?
> >
>
> Yes, as BPF programs can run in all kinds of contexts.
>
> We should replace 'if (irqs_disabled())' with 'if (!preemptible())'
>
> because the definition is:
>
> #define preemptible()   (preempt_count() =3D=3D 0 && !irqs_disabled())
>
> and we need if ((preempt_count() !=3D 0) || irqs_disabled()), in both
> these cases we want to make it async.
>
> I will try to test the fix as Syzbot has now found a reproducer.

Puranjay,

Any progress on a patch ?

