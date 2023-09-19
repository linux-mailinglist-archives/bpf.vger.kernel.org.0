Return-Path: <bpf+bounces-10367-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90A7A5D75
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73E0228209D
	for <lists+bpf@lfdr.de>; Tue, 19 Sep 2023 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ABE83D3B7;
	Tue, 19 Sep 2023 09:10:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D4E38DCC;
	Tue, 19 Sep 2023 09:10:11 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E43DA;
	Tue, 19 Sep 2023 02:10:09 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so4862415f8f.3;
        Tue, 19 Sep 2023 02:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695114608; x=1695719408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IN8c89KGGiOO/1Wlub1Hir5fqSrnxwvLD1PDnHio1bs=;
        b=i9edXzKctiITlGpv5uWoDIHEgMSKV03b8PaLqS6TJ2SfjsydTPHiErT9OaNwe2R9Hx
         0YLMgZDfhQbBwz+JDvhj8AXYeuDRXJJSjl5W9YfAPyNHBLEp9QgDJ8ogUgpkEWYEgDMo
         i2LIDz+CqdMxf1nExrXBsSAJre03BkJdcdJUoqWLKH7/lFjPu58Hev4rymMJCyNB1oPh
         ANlqMoKBcaIq85tQYFYyW8yxNRPtXssWhqETCMeJhGlgLsTzB5YtWXCfCBWUmVhqThAe
         aD4X4JCSVUvGvr2qsM0mDk9T25u/CjlDezhXLj/c1jotieBw1oMqwih4Knj4L0edn/qw
         JfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695114608; x=1695719408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IN8c89KGGiOO/1Wlub1Hir5fqSrnxwvLD1PDnHio1bs=;
        b=eRPTLnTq8YV1AYDJDAB963vVqa7uWFMWGIyMOouD13rXlsc0zJ0MjkRDXdtjhgsuf3
         Mdi0z3W/EaXRoxpyFTcYGHNp9h/lEIZlVOrpA6HGqt2suGsODtCWXZXEC6LKl8gBfH/8
         yOP1GCJg9VrmFBQp/NCeEyF2Bc1ZsEiG6hRHY9PH+ayOf6G/6oFt263nZuUrUC3AOKTv
         V08VkFuFfUdPSIzi/E2OvGmxqZ/dp57SfStX5dCQEkOlRy6+sbgcFq1FZlNsFmqqnZlr
         tIIY+VTH7cYtC/fzmZWS4C+ztls/rUYH+Fv1oTlSKcuTK7wA57bx5i6N9qhhc6+3svsW
         LOWw==
X-Gm-Message-State: AOJu0Yxsy+urxKz7jYSGa0HOJauvAYIPEMoTcRLqBcdRUUAUDZteV0gM
	1bdg+KPZ2b4mRw0F7f6/EUrOyh5wb5/bgjKzPUs=
X-Google-Smtp-Source: AGHT+IHUc2uWOf2Jd61ZVTlsg+9+0qIweUqmfYYkhoy52u9+4Hpn2UgAA0tmEel4pOm7LR5PU/wpTJE/w/Ih5a6kExk=
X-Received: by 2002:a5d:5745:0:b0:319:6caa:ada2 with SMTP id
 q5-20020a5d5745000000b003196caaada2mr8682315wrw.47.1695114607991; Tue, 19 Sep
 2023 02:10:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com>
 <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
 <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com> <CAADnVQLMYMLyBDFkoVemFOEsFW+_=-RXm9vYzpYTO2G612HtnQ@mail.gmail.com>
In-Reply-To: <CAADnVQLMYMLyBDFkoVemFOEsFW+_=-RXm9vYzpYTO2G612HtnQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Sep 2023 02:09:55 -0700
Message-ID: <CAADnVQ+fX-_Y4efStz5_898hnMZrQz2x0YuQ_MCiYwG73g12PA@mail.gmail.com>
Subject: Re: pull-request: bpf-next 2023-09-16
To: Eric Dumazet <edumazet@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 6:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
> > > >
> > >
> > > This might have been raised already, but bpf on x86 now depends on
> > > CONFIG_UNWINDER_ORC ?
> > >
> > > $ grep CONFIG_UNWINDER_ORC .config
> > > # CONFIG_UNWINDER_ORC is not set
> > >
> > > $ make ...
> > > arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
> > > 'struct unwind_state'
> > >                 if (!addr || !consume_fn(cookie, (u64)addr,
> > > (u64)state.sp, (u64)state.bp))
> > >                                                                  ~~~~=
~ ^
> > > 1 error generated.
> >
> > Kumar,
> > can probably explain better,
> > but no the bpf as whole doesn't depend.
> > One feature needs either ORC or frame unwinder.
> > It won't work with unwinder_guess.
> > The build error is a separate issue.
> > It hasn't been reported before.
>
> I see the error with CONFIG_UNWINDER_FRAME_POINTER.
> That's unexpected.
> Kumar,
> looks like this config path wasn't tested.
>
> Eric, Paolo, Dave, Kuba,
> please ignore this PR.
> We need to fix this first.

Sorry, wifi is slow here. I didn't notice that it got merged
and pw-bot didn't notice it either (no emails).
We'll send another bpf-next PR with fixes right away.
Sorry about the build breakage.

