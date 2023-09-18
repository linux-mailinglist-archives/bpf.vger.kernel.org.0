Return-Path: <bpf+bounces-10286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D09A7A4C81
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 17:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A188E1C20CB9
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 15:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5781DA24;
	Mon, 18 Sep 2023 15:35:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF01D6A3;
	Mon, 18 Sep 2023 15:35:01 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB8F1992;
	Mon, 18 Sep 2023 08:31:03 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-401d80f4ef8so51543515e9.1;
        Mon, 18 Sep 2023 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050852; x=1695655652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuLF0NvbwToNsG1bWW8zEx69CIzPNK8/jCp548nd8p8=;
        b=IkKc8r++2KiOePmDZq2aHXJuP3MA2dbB/XP1a/vzg41jeYGfe/vknT7fFb9gd+DMtM
         qbFgAjdblMVywJDL41qM8aImwFdg/D22YTyytBG8HYDru8BGvqYsvUBI4z0fmVfmgrLG
         uuSUzujRXp4n0ghqvse5mi8iJJI5cJh/uo2WoriziD7R7s7JRkwt0Nb3fziHLAz5OV/o
         0XJNKc38bQ3k/FD4USz1EZPvKlxW3VlJv70XnaTwPQRiety4e5eCDkTICr+R3hHRFqSj
         /n/2TM37qbYz76hBLMCHchWQzIVfzrhBCpq0+R81NY6F0LMCy8TXSrt3bJ2kUIHFsdXV
         CPQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050852; x=1695655652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuLF0NvbwToNsG1bWW8zEx69CIzPNK8/jCp548nd8p8=;
        b=GYuyfAKcE3WM32wIceEubcqUMYJm+OGkmFNzxG11Pjgjk9dlz9gofiTECyLozzJ+B5
         qoRrYHN4F5hNNXgaI3JWTO1R8s4LkQCH1iVpH+XnyCDby6JKaqG5+Kp1WVBWJHUKKesv
         sdN8ABn14yxVWrkisJcPjWHhK69YzjT+UU0F53CKTlkUozGpXDTkYcxDHSjd7P2+Wzzg
         z8QHjsNansG6BRxq3FDeiu9WbDliMBaFznd4Q0woX7c0yHD+kpdgG/mQAFzg8ydGiIkL
         975qkyETe7+3k5cC7WIexIikzpAdcrHPZ1A5+5ytlI2ek/UWVO+htczmun4YFlFtrGBt
         /7Ag==
X-Gm-Message-State: AOJu0YyGQN9osMGzdHPw+84ISEwCPIAfRLV1pQrDvNhwv2hu5HnjsSAa
	cR6o2bER8j9LI39GLZO0tZWf/jy6Rt5AFvtESQFPMbBMSbsbqA==
X-Google-Smtp-Source: AGHT+IGO97pbSBpKHQWHVIveaWLI7eR/KWbBTQ6gcLoS7Vp7Pwrn041sruReb6qw7KsFtUK5fYEOCJ6Osel6pFnSz/Y=
X-Received: by 2002:a5d:4e46:0:b0:31a:d2f9:7372 with SMTP id
 r6-20020a5d4e46000000b0031ad2f97372mr7660203wrt.29.1695044468840; Mon, 18 Sep
 2023 06:41:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230916165853.15153-1-alexei.starovoitov@gmail.com> <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
In-Reply-To: <CANn89iK_367bq4Gv+AuA-H5UgXNuM=N3XCp7N8nkeMik0Kwp+Q@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 18 Sep 2023 06:40:57 -0700
Message-ID: <CAADnVQL14y5=eXp=KwAjOYeLuu8DTbL_GDkGxNoHjhy498yBqw@mail.gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 6:25=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Sep 16, 2023 at 6:59=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > Hi David, hi Jakub, hi Paolo, hi Eric,
> >
> > The following pull-request contains BPF updates for your *net-next* tre=
e.
> >
> > We've added 73 non-merge commits during the last 9 day(s) which contain
> > a total of 79 files changed, 5275 insertions(+), 600 deletions(-).
> >
> > The main changes are:
> >
> > 1) Basic BTF validation in libbpf, from Andrii Nakryiko.
> >
> > 2) bpf_assert(), bpf_throw(), exceptions in bpf progs, from Kumar Karti=
keya Dwivedi.
> >
> > 3) next_thread cleanups, from Oleg Nesterov.
> >
> > 4) Add mcpu=3Dv4 support to arm32, from Puranjay Mohan.
> >
> > 5) Add support for __percpu pointers in bpf progs, from Yonghong Song.
> >
> > 6) Fix bpf tailcall interaction with bpf trampoline, from Leon Hwang.
> >
> > 7) Raise irq_work in bpf_mem_alloc while irqs are disabled to improve r=
efill probabablity, from Hou Tao.
> >
> > Please consider pulling these changes from:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
> >
>
> This might have been raised already, but bpf on x86 now depends on
> CONFIG_UNWINDER_ORC ?
>
> $ grep CONFIG_UNWINDER_ORC .config
> # CONFIG_UNWINDER_ORC is not set
>
> $ make ...
> arch/x86/net/bpf_jit_comp.c:3022:58: error: no member named 'sp' in
> 'struct unwind_state'
>                 if (!addr || !consume_fn(cookie, (u64)addr,
> (u64)state.sp, (u64)state.bp))
>                                                                  ~~~~~ ^
> 1 error generated.

Kumar,
can probably explain better,
but no the bpf as whole doesn't depend.
One feature needs either ORC or frame unwinder.
It won't work with unwinder_guess.
The build error is a separate issue.
It hasn't been reported before.

