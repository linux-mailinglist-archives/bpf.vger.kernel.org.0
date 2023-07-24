Return-Path: <bpf+bounces-5740-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB4775FFAC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 21:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED80E1C20BCC
	for <lists+bpf@lfdr.de>; Mon, 24 Jul 2023 19:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C798101CC;
	Mon, 24 Jul 2023 19:16:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334AA100CE
	for <bpf@vger.kernel.org>; Mon, 24 Jul 2023 19:16:02 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2133594;
	Mon, 24 Jul 2023 12:16:00 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b702319893so68083991fa.3;
        Mon, 24 Jul 2023 12:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690226158; x=1690830958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lucQsWRSX3kyNqfS6Jdqh+QWBRhNPWGEWAKdO35kj3s=;
        b=Oec2qNUXaD7VMmc08stO00SOxRtFT1l9vmjA/5kamiYXlUckT/B2gMY6GqBRW8VVTU
         g1FhZtR7sLtxwqxnJ1UKBgRX/2uc3MjkdRHda6EWo+WvfoAI+MZtTKlfsvGF3dlH5sdM
         Sk1jAFCus6VW1kAY1OcjqFRMrfHe4ssQ1zoa64xUO9pN28K8D5utZoJ1Z7oEJrrdp1iZ
         VF42uNCT+aOeXtr7j9D2/srvTB865a8d8CLZmis/YGC5W8bKTMRqXr1V1qhJTc0bx3r0
         8x9xnUB6dTZ2G/DSKyC2xPc8g3Bbu1owZtGBuVZFoPJURKKsNBUckionvxX07v8CKKZY
         u7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690226158; x=1690830958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lucQsWRSX3kyNqfS6Jdqh+QWBRhNPWGEWAKdO35kj3s=;
        b=A8BDWSA+tmW5r5M/fNjgflSJiwSshGQs/JXdKXq/cs0OERc7ODaVdKmoI4J5HTVs8X
         7GZcI/goJ2vf3i2jN7yHWXynxEAJgfC6ukgTVnlsAKjC+YZ99Skftbp8w8f8V268hJvK
         r0DLFzUfDg8G9u49jIvze10tDXxf8JzTerdoeDwUiBfuDj2LE1b4HOTgUyFUvAhSBhQp
         LWXJd7+enBYIzs/i4+q9lKTs/j20Z3PBvNW3thR9XmanYO3BjOUSTnGr42tq+xmiSuo6
         ECveZVrucOEwuL1RoCshaTeUSgMcp3O9BPtvt7HnbxRwCJd6hmvE1/AZgEtZq6QvaUqo
         7rjA==
X-Gm-Message-State: ABy/qLbWtV/UdsMrPyal2nCNZ7Bua1osNDDYxT6W/zqBoYo6sFKDOQOa
	k33M3r6j+1UxBXbb8G/q7+v1DnYN5ckfSgnx7HM=
X-Google-Smtp-Source: APBJJlErYvymETL1cV4rq9ZBNUF/0/nHQCcNB5oe2z4y78XFXKvafW1wsesMYaNZIX9iSDOEmguquVRSWn5i8KIvyWs=
X-Received: by 2002:a2e:6a11:0:b0:2b9:4c17:7939 with SMTP id
 f17-20020a2e6a11000000b002b94c177939mr6515964ljc.12.1690226158102; Mon, 24
 Jul 2023 12:15:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230722074753.568696-1-arnd@kernel.org> <CALOAHbCV2v3X7g1TD42yve0juhRD2vhq=DMtDz9P6+mX8Dae_w@mail.gmail.com>
 <CAADnVQKGe8DN+Zs387UVwpij3ROGqNEnc5r940h5ueqQYHTYCA@mail.gmail.com>
 <fa5e9098-d6f9-48a2-bb77-2620b6bb6556@app.fastmail.com> <CAADnVQ+p4wpd=tKJAiwB34O1y5vv4mibtkt9D-F7sG=rQapcew@mail.gmail.com>
 <679d8d63-ce92-4294-8620-e98c82365b2c@app.fastmail.com> <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
In-Reply-To: <39444a4e-70da-4d17-a40a-b51e05236d23@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 24 Jul 2023 12:15:45 -0700
Message-ID: <CAADnVQ+zdV9+UNV9NeEzY2rWd8qvW3cvHxS9mYwfhnqZOV+9=A@mail.gmail.com>
Subject: Re: [PATCH] bpf: force inc_active()/dec_active() to be inline functions
To: Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yafang Shao <laoar.shao@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Hou Tao <houtao1@huawei.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 24, 2023 at 11:30=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wr=
ote:
>
> On Mon, Jul 24, 2023, at 20:13, Arnd Bergmann wrote:
>
> >>> One difference between gcc and clang is that gcc tries to
> >>> be smart about warnings by using information from inlining
> >>> to produce better warnings, while clang never uses information
> >>> across function boundaries for generated warnings, so it won't
> >>> find this one, but also would ignore an unconditional use
> >>> of the uninitialized variable.
> >>>
> >>> >> If we have to change the kernel, what about the change below?
> >>> >
> >>> > To workaround the compiler bug we can simply init flag=3D0 to silen=
ce
> >>> > the warn, but even that is silly. Passing flag=3D0 into irqrestore =
is buggy.
> >>>
> >>> Maybe inc_active() could return the flags instead of modifying
> >>> the stack variable? that would also result in slightly better
> >>> code when it's not inlined.
> >>
> >> Which gcc are we talking about here that is so buggy?
> >
> > I think I only tried versions 8 through 13 for this one, but
> > can check others as well.
>
> I have a minimized test case at https://godbolt.org/z/hK4ev17fv
> that shows the problem happening with all versions of gcc
> (4.1 through 14.0) if I force the dec_active() function to be
> inline and force inc_active() to be non-inline.

That's a bit of cheating, but I see your point now.
How about we do:
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 51d6389e5152..3fa0944cb975 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -183,11 +183,11 @@ static void inc_active(struct bpf_mem_cache *c,
unsigned long *flags)
        WARN_ON_ONCE(local_inc_return(&c->active) !=3D 1);
 }

-static void dec_active(struct bpf_mem_cache *c, unsigned long flags)
+static void dec_active(struct bpf_mem_cache *c, unsigned long *flags)
 {
        local_dec(&c->active);
        if (IS_ENABLED(CONFIG_PREEMPT_RT))
-               local_irq_restore(flags);
+               local_irq_restore(*flags);
 }

 static void add_obj_to_free_list(struct bpf_mem_cache *c, void *obj)
@@ -197,7 +197,7 @@ static void add_obj_to_free_list(struct
bpf_mem_cache *c, void *obj)
        inc_active(c, &flags);
        __llist_add(obj, &c->free_llist);
        c->free_cnt++;
-       dec_active(c, flags);
+       dec_active(c, &flags);


It's symmetrical and there is no 'flags =3D 0' ugliness.

