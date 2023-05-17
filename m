Return-Path: <bpf+bounces-684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C3C705C1E
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 02:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 829B81C20C2F
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 00:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622C217CD;
	Wed, 17 May 2023 00:56:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE1617C8
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 00:56:23 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7193
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-965e4be7541so18705066b.1
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684284980; x=1686876980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=fWfQzjT/a/W1aF+AI66pq44cnSK6DKe87HrPDjKntdGAlAeeqcQZdzpQFTXY/VnO52
         Q0gGzt92aCWleq7n34HLgFArWwvN4JHtsksq8Etk/ZWDDQ5nbKaiadoFODiP6hm6QzSL
         ABcce4oHzPibW4ZSudoP+IHJp2z2zxPdfAZ0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684284980; x=1686876980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u19sBi6Gx4oX3ZUtePL5RNvvMU7eDU7T5lpZ8DtlLqE=;
        b=f9ASE3I455Gt5FcAWVFLz63O3ZHoHy62qNuNinoT4GnWtvxGZfRX85JHx/rAKv2sOK
         qoE9hHVxfEXQAekkris0mtLcRWxbYe+Xt/g8O09Q4+MAPYtzmGje07x70rdDHx9jeJgC
         kNphyOM/1F8S5SW/VpdjxvYf6pAgvhIjRAbBc63A222Vg56WoRzR7XbgWIzDgfwvfaP3
         KlwnoY+Jzxn17f6EsqSmkvuiqArWy+nHo1bYoiAPZSmxmBhAOazfAEXgYW1HksUWsbS1
         nC7G8Fx/pE4ZVIpHcguQD7nJTf/h/DrN6HFJGLRTh7kAMfaLzHToO9cQkZDW8E1KspTC
         CM+g==
X-Gm-Message-State: AC+VfDxmcZ6h1Qdwa8Z2M+h2mRv+Ty3ptT6z6ivQIhxk5eGcKmbBxVq6
	AwCgGZSe5cpx8MS+v3Iw3YmeEW4lSToa/WxIePsy7g==
X-Google-Smtp-Source: ACHHUZ6hEq2WoVlFQVe/Uu9ewmYvOnetF/YDzKuO23WhtyKy3RsacxUVVl5izeuSzbxw43PKec8ytw==
X-Received: by 2002:a17:907:98e:b0:962:9ffa:be02 with SMTP id bf14-20020a170907098e00b009629ffabe02mr35370982ejc.36.1684284980473;
        Tue, 16 May 2023 17:56:20 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id p8-20020a170906a00800b009658264076asm11363103ejy.45.2023.05.16.17.56.19
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 17:56:19 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-966287b0f72so19991366b.0
        for <bpf@vger.kernel.org>; Tue, 16 May 2023 17:56:19 -0700 (PDT)
X-Received: by 2002:a17:907:3e13:b0:948:b9ea:3302 with SMTP id
 hp19-20020a1709073e1300b00948b9ea3302mr44683119ejc.1.1684284979144; Tue, 16
 May 2023 17:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230508163751.841-1-beaub@linux.microsoft.com>
 <CAADnVQLYL-ZaP_2vViaktw0G4UKkmpOK2q4ZXBa+f=M7cC25Rg@mail.gmail.com>
 <20230509130111.62d587f1@rorschach.local.home> <20230509163050.127d5123@rorschach.local.home>
 <20230515165707.hv65ekwp2djkjj5i@MacBook-Pro-8.local> <20230515192407.GA85@W11-BEAU-MD.localdomain>
 <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
In-Reply-To: <20230517003628.aqqlvmzffj7fzzoj@MacBook-Pro-8.local>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 May 2023 17:56:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Message-ID: <CAHk-=whBKoovtifU2eCeyuBBee-QMcbxdXDLv0mu0k2DgxiaOw@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: Run BPF program if attached
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	David Vernet <void@manifault.com>, dthaler@microsoft.com, brauner@kernel.org, 
	hch@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 16, 2023 at 5:36=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, May 15, 2023 at 12:24:07PM -0700, Beau Belgrave wrote:
> > > >
> > > >   ret =3D pin_user_pages_remote(mm->mm, uaddr, 1, FOLL_WRITE | FOLL=
_NOFAULT,
> > > >                               &page, NULL, NULL);
> > >
> > > ... which will call pin_user_pages_remote() in RCU CS.
> > > This looks buggy, since pin_user_pages_remote() may schedule.
> > >
> >
> > If it's possible to schedule, I can change this to cache the probe
> > callbacks under RCU then drop it. However, when would
> > pin_user_pages_remote() schedule with FOLL_NOFAULT?
>
> Are you saying that passing FOLL_NOFAULT makes it work in atomic context?

Absolutely not.

It may not fault missing pages in, but that does *not* make it atomic.

That code depends on all the usual MM locking, and it does not work at
all in the same way that "pagefault_disable()" does, for example. That
will fail on any fault and never take locks, and is designed to work
in atomic contexts. Very different.

So no, don't think you can call pin_user_pages_remote() or any other
GUP function from atomic context.

We do have "get_user_page[s]_fast_only()" and that is the only version
of GUP that is actually lock-free.

Also, just FYI, those special gup_user*fast_only()" functions simply
will not work on some architectures at all.

               Linus

