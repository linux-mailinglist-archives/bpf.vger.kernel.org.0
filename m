Return-Path: <bpf+bounces-33667-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E6492499D
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 22:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE97F1F2640A
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 20:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BD720125A;
	Tue,  2 Jul 2024 20:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCM55eYi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A839A200134;
	Tue,  2 Jul 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719953572; cv=none; b=C5PzytFs0MI+glqi+UcGdsRR4oa92kNYwDLtQLIPCvtCagmbrQTxkqnhseT2wnhiNG7Im1iszhjZOQtcJ6Qfs8wT617Pj8ggNzqST82BgmtSA/i1F01hpPy25sYKmkUk0MIpjatXyy9pvAhEi1zM35xzadSfUUKxt3LDAJORdaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719953572; c=relaxed/simple;
	bh=gepoO6cOPMo/DOI3XgZGN8LXNSfcCbsIJ5EA8atVg1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kWB+Z/K2dUYrdBmA910MBn23WXq41eqIWlMLk6PEkrra2fM3BAH37vrP43jtBA9m2wsiN+Kgw5NrcUJrJuck356xtE/Lymum7A1D1QmbwbbiYEGLdZJJ2+8zHILeRbIW7VzuhpGeRwczzJzbR6R192qEe2WI+j2X67/7pwIz9H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCM55eYi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70670188420so3235575b3a.2;
        Tue, 02 Jul 2024 13:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719953571; x=1720558371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ka8cDyPF3TtOuN3B8pP21oZz+Ld8yxRwwPYf5j+KImo=;
        b=RCM55eYi8JAVIOea5wemE3hvm++gZYoC9eeubG12G41UpJ5EgdpyEspWxRvyF0HfMV
         eVKtaHwAHVwgnvLcPlLSK0HGuuTVhlLgxLkfUgqUwVapwjPJkGORKb574HVyyJHtEO2f
         iyZIf66otUUdgs/iL0no2V89VTqvG5Shd/Zeq82tWZ3w2sp+ezdzLfmTWeQAxHct4l1m
         egIfLHa4mafSdjTkfY1iumUELx2MMZ6tyzn5hPvy8Hb4lrRGlz1hIMmg9D58ryEGQku1
         hFsZi0hunhLnc/efyc1WOKA3z0FjgSLLs4ZaudS00qdsj1eXt8RVY/KjS6NLmfj8IdXb
         v43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719953571; x=1720558371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ka8cDyPF3TtOuN3B8pP21oZz+Ld8yxRwwPYf5j+KImo=;
        b=DYjRCHkbN6Z8OC4sAcQUYO1QQIfgWAORd3sgiBRG3izblogmjUK8Rsjat0zWPw04OT
         P2hj713xUsAm3RrMlEQSj5Ow3gz8EwMOA/TodLuNhaK0oYYU9CmLoTn/7nwbgsvhF/QF
         ZmVIw51sFomDajUYjA9uqCyxLusMsVwBoZvnl0OK+WdYJlO0jxxwY/A6XZhfsAId0K9G
         kYjz4A3i1g+wnbupprisWlYi2fwNdWzlntQtg0WcvvDcXEKNcQKkW/m4DThrMoNYZzjD
         XbsEePTKmcyPB5UZ2+ik9/dcPnrySqDkgbsW8CCZrZ+msHBLB6a/2HwH0zy5wbNwnSsU
         nqAg==
X-Forwarded-Encrypted: i=1; AJvYcCWIIGAEyPxiHDodYBr2wrAyIMaVUcKtEOBfAaMlrEJg05mU6W0GHvo6x7ifRXBQTRACh9JgsDOkvkQ5/aPBpnXYyX4bhEqt7zLQNKiY6dTmfHiRpImxmounUqsQHVylW4hyS6sjL+thwSNWMJnHXvtO5IBpP9ZW2HfJ6L3BBuw38fbb838U
X-Gm-Message-State: AOJu0YyaK72HicELZve+kMoUnLUveRC1ZNZYCbRXYK+qxK3wBvZdfcjS
	0hfw3cM76gpUoDvgDtGSwuplqXWmhS4boJ8+i8523fXNJKKuJFujHF2OHGp6SMqirO7Jjn9Ycpm
	3UIejkT5zY7CCZP2/JOdHoLCRTFg=
X-Google-Smtp-Source: AGHT+IFqZ1uKSZfEUZonCPz2t787Re0NvZrqmMdWo3PXwBwPuZFGxuO2RROLpCXOi61Hl3aS+dPea5xciO2dgWvjKkU=
X-Received: by 2002:a05:6a00:4614:b0:705:a450:a993 with SMTP id
 d2e1a72fcca58-70aaad51cccmr9567542b3a.17.1719953570968; Tue, 02 Jul 2024
 13:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701164115.723677-1-jolsa@kernel.org> <20240701164115.723677-2-jolsa@kernel.org>
 <20240702130408.GH11386@noisy.programming.kicks-ass.net> <ZoQmkiKwsy41JNt4@krava>
In-Reply-To: <ZoQmkiKwsy41JNt4@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 2 Jul 2024 13:52:38 -0700
Message-ID: <CAEf4BzYz-4eeNb1621LugDtm7NFshGJUgPzrVL7p4Wg+mq4Aqg@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 1/9] uprobe: Add support for session consumer
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 9:11=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Tue, Jul 02, 2024 at 03:04:08PM +0200, Peter Zijlstra wrote:
> > On Mon, Jul 01, 2024 at 06:41:07PM +0200, Jiri Olsa wrote:
> >
> > > +static void
> > > +uprobe_consumer_account(struct uprobe *uprobe, struct uprobe_consume=
r *uc)
> > > +{
> > > +   static unsigned int session_id;
> > > +
> > > +   if (uc->session) {
> > > +           uprobe->sessions_cnt++;
> > > +           uc->session_id =3D ++session_id ?: ++session_id;
> > > +   }
> > > +}
> >
> > The way I understand this code, you create a consumer every time you do
> > uprobe_register() and unregister makes it go away.
> >
> > Now, register one, then 4g-1 times register+unregister, then register
> > again.
> >
> > The above seems to then result in two consumers with the same
> > session_id, which leads to trouble.
> >
> > Hmm?
>
> ugh true.. will make it u64 :)
>
> I think we could store uprobe_consumer pointer+ref in session_consumer,
> and that would make the unregister path more interesting.. will check

More interesting how? It's actually a great idea, uprobe_consumer
pointer itself is a unique ID and 64-bit. We can still use lowest bit
for RC (see my other reply).

>
> thanks,
> jirka

