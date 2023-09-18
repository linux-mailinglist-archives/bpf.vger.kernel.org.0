Return-Path: <bpf+bounces-10292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 965367A4CF6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B153E1C2138E
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DEF1F60B;
	Mon, 18 Sep 2023 15:44:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96CE1D686;
	Mon, 18 Sep 2023 15:44:03 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09122116;
	Mon, 18 Sep 2023 08:42:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-530fa34ab80so2873184a12.0;
        Mon, 18 Sep 2023 08:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695051444; x=1695656244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rj4c9AMW+lHnbdnbbz2179vv+UZJDmD5B/irdAQLI6A=;
        b=jSRXO7U3ZXNMTQ+jBtwhedxCiC+c1bSuZRRinckSwjLXNS7BxQovOrEnmKVgQS34A4
         0xLuIY+ZTYcF4KSl8vYeXhjBx3X9v6fmwZ9Uc9KAAHJ3cqBZjeGGaU95kUoyddqqK+7H
         4JZ7YFhDrz4CICv5yOOyMoxUfxxxbYoyZ+5Zqxik+QL04pkLEn2eAnEYomqm9hTEI4UW
         VFwMYtXOJnv6ejdPMmuYYZSph2y/YtglbLDmM1K3lUuA4PMZd6QFK7Q8EHGGy0Vor2/N
         s5HmMiJ562kDsuSAsQcSpX6e+cC/KUQ3PNhCd9rDKNlgvn2H1YK27xpouLqdVT++eozM
         qENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051444; x=1695656244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rj4c9AMW+lHnbdnbbz2179vv+UZJDmD5B/irdAQLI6A=;
        b=AUHtRx0wJM17qzvgVrbA0ASmMgXXIUvTCNI9/LaC470hvDbMasbFuQnSwgAf0wCT4V
         wUs5pIhu5MI52h9O3rjT7wJyvsB3XY1K8tp8D0N8D/XTwQLkE2ldX9qb3NP2boKlfuLq
         fz7qR0RgiZicfwW+opTXuDrQzD+SwBbee6+kWLfO2yiroE/yZZBiSbFQJ+mv5CojRPZg
         vN0Su97FQdwAE9UaD8rdg9YTWTVrs1iWlcpdLy1Yq5Gy709AJYwe7GViWpCfmbp8uQEY
         W1SnjAJ4EPpmSfoKRzZsB0sE6GigOJUrbwcjjmyK0RGUaCnw+b0eAmDCOuYdYpBwAgqp
         dLtQ==
X-Gm-Message-State: AOJu0YyW6ubo0Xnngt3VWaaSGRmUPVnY9gkPtJ/ySCMF3YkWl0283Ne8
	LsKDpDWXxu2mbLlLUKXzl0hQHqOlRV/DYFKZAHYLMliWuoI=
X-Google-Smtp-Source: AGHT+IEXjZ3C5NwEYwz0xRr1OAYeh8IP8riDS+f3m5/CyZNNgzA6mCtpfFGH7HkWzTfVb+VmLSSbfU6xhX6KCRgTeU8=
X-Received: by 2002:a7b:cd0d:0:b0:3ff:516b:5c4c with SMTP id
 f13-20020a7bcd0d000000b003ff516b5c4cmr7531273wmj.18.1695047609042; Mon, 18
 Sep 2023 07:33:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
 <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
 <CANn89iKkEcsaEQRNmxdEHAkTbPVgVekUcjJvDsd-_fs0M9Qszw@mail.gmail.com>
 <CAADnVQLn1dtBNyywZO38WyWtUyomKJDdMefpkj3mkR=+fOh+tg@mail.gmail.com>
 <CAP01T75C3qHe3OuXcbFqDjLtb+M8UixVYxHA-Gf=c6xrNQvVAA@mail.gmail.com> <CAP01T77KpyhUByzBmz+g12GgB7SEm0qr4BGJMrkFw5DXC+_Vdw@mail.gmail.com>
In-Reply-To: <CAP01T77KpyhUByzBmz+g12GgB7SEm0qr4BGJMrkFw5DXC+_Vdw@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Sep 2023 07:33:17 -0700
Message-ID: <CAADnVQLSgPV0xWHj0QXgNoE4CkmDH0WESAkH_XwOHr8_jvOZ9w@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 7:24=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 18 Sept 2023 at 16:15, Kumar Kartikeya Dwivedi <memxor@gmail.com>=
 wrote:
> >
> > On Mon, 18 Sept 2023 at 15:56, Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 6:54=E2=80=AFAM Eric Dumazet <edumazet@google=
.com> wrote:
> > > >
> > > > On Mon, Sep 18, 2023 at 3:41=E2=80=AFPM Alexei Starovoitov
> > > > <alexei.starovoitov@gmail.com> wrote:
> > > > >
> > > > > On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@go=
ogle.com> wrote:
> > > > > >
> > > > > > On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> > > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi David, hi Jakub, hi Paolo, hi Eric,
> > > > > > >
> > > > > > > The following pull-request contains BPF updates for your *net=
-next* tree.
> > > > > > >
> > > > > > > We've added 73 non-merge commits during the last 9 day(s) whi=
ch contain
> > > > > > > a total of 79 files changed, 5275 insertions(+), 600 deletion=
s(-).
> > > > > > >
> > > > > > > The main changes are:
> > > > > > >
> > > > > > > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> > > > > > >
> > > > > > > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from K=
umar Kartikeya Dwivedi.
> > > > > > >
> > > > > > > 3) next_thread cleanups, from Oleg Nesterov.
> > > > > > >
> > > > > > > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> > > > > > >
> > > > > > > 5) Add support for __percpu pointers in bpf progs, from Yongh=
ong Song.
> > > > > > >
> > > > > > > 6) Fix bpf tailcall interaction with bpf trampoline, from Leo=
n Hwang.
> > > > > > >
> > > > > > > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to=
 improve refill probabablity, from Hou Tao.
> > > > > > >
> > > > > > > Please consider pulling these changes from:
> > > > > > >
> > > > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.=
git
> > > > > > >
> > > > > >
> > > > > > This might have been raised already, but bpf on x86 now depends=
 on
> > > > > > CONFIG_UNWINDER_ORC ?
> > > > > >
> > > > > > $ grep CONFIG_UNWINDER_ORC .config
> > > > > > # CONFIG_UNWINDER_ORC is not set
> > > > > >
> > > > > > $ make ...
> > > > > > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp=
' in
> > > > > > 'struct unwind_state'
> > > > > >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > > > > > (u64)state.sp, (u64)state.bp))
> > > > > >                                                                =
  ~~~~~ ^
> > > > > > 1 error generated.
> > > > >
> > > > > Kumar,
> > > > > can probably explain better,
> > > > > but no the bpf as whole doesn't depend.
> > > > > One feature needs either ORC or frame unwinder.
> > > > > It won't work with unwinder_guess.
> > > > > The build error is a separate issue.
> > > > > It hasn't been reported before.
> > > >
> > > > In my builds, I do have CONFIG_UNWINDER_FRAME_POINTER=3Dy
> > > >
> > > > $ grep UNWIND .config
> > > > # CONFIG_UNWINDER_ORC is not set
> > > > CONFIG_UNWINDER_FRAME_POINTER=3Dy
> > > >
> > > >
> > > > I note state.sp is only available to CONFIG_UNWINDER_ORC
> > > >
> > > > arch/x86/include/asm/unwind.h
> > > >
> > > > #if defined(CONFIG_UNWINDER_ORC)
> > > >     bool signal, full_regs;
> > > >     unsigned long sp, bp, ip;
> > > >     struct pt_regs *regs, *prev_regs;
> > > > #elif defined(CONFIG_UNWINDER_FRAME_POINTER)
> > > >    bool got_irq;
> > > >    unsigned long *bp, *orig_sp, ip;   // this is orig_sp , not sp.
> > >
> > > Right. Our replies crossed.
> > > Please ignore this PR. We need to fix this first.
> >
> > Hello,
> > This is my bad. I totally missed it since I initially wrote this patch
> > and never looked at it again.
> > I suggest that I send a fix to disable this feature with
> > CONFIG_UNWINDER_FRAME_POINTER=3Dy, while I work on reenabling it again
> > for it with a follow up.
>
> Hi, I've attached a fix that should disable it for now. I'll work on a
> follow up to reenable it for this config option.
> Really sorry about this, I'll try to be more careful going forward.

Patchwork doesn't recognize patches this way.
Pls submit it properly.

