Return-Path: <bpf+bounces-15672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C65327F4BB4
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5311C20873
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED8A58110;
	Wed, 22 Nov 2023 15:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="iQd77CTu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E72C109
	for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:55:41 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5caf387f2aaso31154767b3.3
        for <bpf@vger.kernel.org>; Wed, 22 Nov 2023 07:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700668541; x=1701273341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HArRuhEJbPWUB0W1o682njJUc9wD7yRdaDevvOmIv4A=;
        b=iQd77CTuYh9bDrTj04rT1kZKWpdPENP2kLzACJ6e9YAvQ5lJxOsIwWebscrCkoEVJm
         QQbfSDZdCQ3UDxhVzPT15ULy552ms8Ert26n76q06rtTi10yyrq4gTSaOtNpS/H8i5pA
         cvH8Q3oQGW+E2CtaBJtmXmlx/y5n1kSR+RJTLKU7zsRwULjVhk1c05xDbNnREAGlv2gt
         CZeS0EcG9muwjUTE4Ty+mNKib8GFpbO1+lM3+0y4QJCkDZj2QMvkJwzw585gIWtag1A0
         7vmKE1jQMbwlodIp7iqL5J8lFz73r8q/Jskq9Pyuh7zoeGHpOVPhU4LX6xjpokAiPFF3
         RFgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700668541; x=1701273341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HArRuhEJbPWUB0W1o682njJUc9wD7yRdaDevvOmIv4A=;
        b=hNuH9jGlGbhxdLMqTJ5ZHZcXjY5iMoS1DImr9BMPuzrfXn53NxRlnPMW7+WroRLuJF
         7EAhSEenHRNVk0JH3yy0q9CpdOCeD6d5oUSK4OikWziiA6OSipacRIKFiQLM4HepOg1o
         CYtciCN2yx6c1EZLyXCO20fq+GABZVt3kIfAhbwKAVerJlLDxnCl3Z4qA/N8PeyHKou+
         EVfxKq6osO3zf56Gr3oPlgM5ey6P5qkfhiDD6kfVNhUrLlnswDnCfS5Qeo6YfGKnjKae
         /rjmyNoMQMSxodVLW5Jq3H32j5zj1JA4AMV/lCnZ+WzslXnJhsrd/1Uz8JdKMPBgVvvf
         ataA==
X-Gm-Message-State: AOJu0YyigpfJqcamyHXtW9/XDDJtvgVXoPUaiVFFxodhnK/FoSXe8a2+
	Z3/X5CBCUm4oyFGRoraE6GjWuwKUZjYtJpYG0byOHw==
X-Google-Smtp-Source: AGHT+IEatp29tETsY/z/USG4bCMF0FNTFq9EcKk6EQSgLqW7OdflPc+5AsvOvVB9eY2hZF924Cg6DLUnnnLMemc93og=
X-Received: by 2002:a81:658a:0:b0:5a7:aece:7e59 with SMTP id
 z132-20020a81658a000000b005a7aece7e59mr2546769ywb.50.1700668540835; Wed, 22
 Nov 2023 07:55:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231121175640.9981-1-mkoutny@suse.com> <CAM0EoM=id7xo1=F5SY2f+hy8a8pkXQ5a0xNJ+JKd9e6o=--RQg@mail.gmail.com>
 <yerqczxbz6qlrslkfbu6u2emb5esqe7tkrexdbneite2ah2a6i@l6arp7nzyj75> <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
In-Reply-To: <CAM0EoMk_OgpjV7Huh-NHF_WxkJtQYGAMY+kutsL=qD9oYthh_w@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 22 Nov 2023 10:55:29 -0500
Message-ID: <CAM0EoM=Pq02p-sbkMSQBg8=dwTC5z+AeLjeXdzeHTA1AFSLuRg@mail.gmail.com>
Subject: Re: [PATCH] net/sched: cls: Load net classifier modules via alias
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Petr Pavlu <ppavlu@suse.cz>, Michal Kubecek <mkubecek@suse.cz>, 
	Martin Wilck <mwilck@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 22, 2023 at 10:33=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Wed, Nov 22, 2023 at 5:41=E2=80=AFAM Michal Koutn=C3=BD <mkoutny@suse.=
com> wrote:
> >
> > On Tue, Nov 21, 2023 at 05:37:37PM -0500, Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > What's speacial about the "tcf- '' that makes it work
> > > better for filtering than existing "cls_" prefix?
> >
> > tcf-foo is an alias.
> > cls_foo is the canonical name of the kernel module.
> >
> > request_module() + blacklist (as described in modprobe.d(5)) works only
> > when calling with the alias. The actual string is not important, being
> > an alias is the crux.
> >
>
> Thanks for the explanation.
>

Out of curiosity - how did you end up looking at this? Was there
someone who complained or is it just standard procedure to add aliases
to all modules and it was on a todo list somewhere?

cheers,
jamal

> > > What about actions (prefix "act_") etc?
> >
> > I focused only on "cls_" for the first iteration. Do you want me to loo=
k
> > at other analogous loads?
>
> Yes, look at act_ and sch_
>
> cheers,
> jamal
> > Thanks,
> > Michal

