Return-Path: <bpf+bounces-3298-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A8873BDBC
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 19:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04189281C88
	for <lists+bpf@lfdr.de>; Fri, 23 Jun 2023 17:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EE05100CD;
	Fri, 23 Jun 2023 17:20:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15DB100C6
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 17:20:49 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741DC7
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:20:39 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51a2de3385fso999564a12.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 10:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687540838; x=1690132838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jva581xTdKOAbvoCMTPQnSwgcX8d75cq5oIDn514bpA=;
        b=DtWmdQg13U/jLc1nkI6fYn/gXvVRTo3mJStnBrPs4v5EZ2AEzOXJoEyRlrZzv9onDA
         b+5xKoXgisJA+uGWEt6jNoFYd6OALvNXB9hhl8B1DUjvEpBkFYjt6jEn7w/KQ+E6Z7LZ
         1afzp5Ef9dK1xWx747j24U+EjsQwp8TugaLAKZzqALobAnrbQ114S1bZ9rXht231kgnu
         pwlArHnEouei/ZQBOafFBRjPFoEwODeJL9h1KDamGzaLmN2wtNE/uqQWY155Jx2xlkwk
         p1wj51XK4s3Z5qMHMs96g07PTsiVapm643jPYm2sDfKSJzfYqwUdU2U+pZL6hrmKlWNE
         WTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687540838; x=1690132838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jva581xTdKOAbvoCMTPQnSwgcX8d75cq5oIDn514bpA=;
        b=cBTf5F4WGedZMyaGkW2uE63uAmhvq09XvnEFAjajg2HwD2vE9TEtAj9o79aKqfVRXD
         EFPkaUwq62V1COzyZSW3zSnGAObLcYpF04ryxz6I5Lh7MhaQu6V/9XKa+sdtJ6MXZsuU
         su8J9jRlb8Xi7vduxA6ZQrldbnM2C1NbUqpYMsYUpmYXd53/JivesEcb1z9inlyKFe7b
         /zdRkHaVFJpfEsLxPXm9JoOKegHAFwiKT+y105wWDvJVnYcU1jFfPIPbZbKOEt23dSJP
         p0NkUdssIldM6C+swG79y1wWlcB6drfb9Fn1sPTc2BmGDJf6O7ClLdwwkFKsZGPMs6wW
         WZxQ==
X-Gm-Message-State: AC+VfDyKondQwe+0hL08LYyaALH/s6G6YmJyCNA+t+/ZXcQbdSKAtcy2
	293i7KKUh8CeFKuxp32Pr7LWJ/ojUDG0EBKd6F8=
X-Google-Smtp-Source: ACHHUZ6X2QMaCakowsLQLZ4lW9nC1n23j4GPJZr4CtdZ1yNK9q5vdIgoovZ1VoUWqF9LmtRt21oba3ZjsCHc3HcTMiM=
X-Received: by 2002:aa7:db47:0:b0:51a:512b:1b2 with SMTP id
 n7-20020aa7db47000000b0051a512b01b2mr11818311edt.5.1687540837790; Fri, 23 Jun
 2023 10:20:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620083550.690426-1-jolsa@kernel.org> <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava> <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
 <CAADnVQKT2=MHXj4RD9TXwqnPqau94UMHgjspYGgyGpz_aUQjCg@mail.gmail.com> <CAEf4BzZRwsPK1mHDob4ROWjFyxaGM7vcQ7xZ8xQgEuY-7hFu_w@mail.gmail.com>
In-Reply-To: <CAEf4BzZRwsPK1mHDob4ROWjFyxaGM7vcQ7xZ8xQgEuY-7hFu_w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 10:20:26 -0700
Message-ID: <CAADnVQ+DVo2a6bCqzV3ipDVLEaVmiUgziM9im1ovG9S5epR5VQ@mail.gmail.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 10:11=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Jun 23, 2023 at 9:39=E2=80=AFAM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 9:24=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > > > > +
> > > > > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > > > > +                          unsigned long entry_ip,
> > > > > > +                          struct pt_regs *regs)
> > > > > > +{
> > > > > > +       struct bpf_uprobe_multi_link *link =3D uprobe->link;
> > > > > > +       struct bpf_uprobe_multi_run_ctx run_ctx =3D {
> > > > > > +               .entry_ip =3D entry_ip,
> > > > > > +       };
> > > > > > +       struct bpf_prog *prog =3D link->link.prog;
> > > > > > +       struct bpf_run_ctx *old_run_ctx;
> > > > > > +       int err =3D 0;
> > > > > > +
> > > > > > +       might_fault();
> > > > > > +
> > > > > > +       rcu_read_lock_trace();
> > > > >
> > > > > we don't need this if uprobe is not sleepable, right? why uncondi=
tional then?
> > > >
> > > > I won't pretend I understand what rcu_read_lock_trace does ;-)
> > > >
> > > > I tried to follow bpf_prog_run_array_sleepable where it's called
> > > > unconditionally for both sleepable and non-sleepable progs
> > > >
> > > > there are conditional rcu_read_un/lock calls later on
> > > >
> > > > I will check
> > >
> > > hm... Alexei can chime in here, but given here we actually are trying
> > > to run one BPF program (not entire array of them), we do know whether
> > > it's going to be sleepable or not. So we can avoid unnecessary
> > > rcu_read_{lock,unlock}_trace() calls. rcu_read_lock_trace() is used
> > > when there is going to be sleepable BPF program executed to protect
> > > BPF maps and other resources from being freed too soon. But if we kno=
w
> > > that we don't need sleepable, we can avoid that.
> >
> > We can add more checks and bool flags to avoid rcu_read_{lock,unlock}_t=
race(),
> > but it will likely be slower. These calls are very fast.
>
> that's ok then. But seeing how we do
>
> rcu_read_lock_trace();
> if (!sleepable)
>     rcu_read_lock();
>
> it felt like we might as well just do
>
> if (sleepable)
>     rcu_read_lock_trace();
> else
>     rcu_read_lock();
>
>
> As I mentioned, in this case we have a single bpf_prog, not a
> bpf_prog_array, so that changes things a bit.

Ahh. It's only one prog. I missed that. Above makes sense then.
But why is it not an array? We can attach multiple uprobes to the same
location. Anyway that can be dealt with later.

