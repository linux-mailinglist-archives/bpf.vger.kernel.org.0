Return-Path: <bpf+bounces-270-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D94E16FD3F0
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 04:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E96281322
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 02:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36806634;
	Wed, 10 May 2023 02:56:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B7C361
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 02:56:06 +0000 (UTC)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A08830FB
	for <bpf@vger.kernel.org>; Tue,  9 May 2023 19:56:02 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-61b8faaa8daso32799786d6.3
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 19:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683687361; x=1686279361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79gxakGJCh3jYG7uTZc/fT3rB4f5EGGFQBHhIC6aUJA=;
        b=GFRSYtHPKx/PYQMSjoTtDkuecTqRVN+j6y8Re2zPsczWqnUZsiilpuauIyE35J8Gck
         da1dp79fPG+YdRXvSSzKoGXKpuCvFNyW3ddPm+kfPGDH4yX6SRpVPMSeooUREAKr2BSb
         vPhcqjrfEcmVDEkH5nDh8x54CAiiTh+8xPfg02uFEZ+JbJXuarK03b0WRpPtzRQrjFjp
         qx8Q9VVkGygLy0xpzExujkRk+1agdnA5XAgRoagd+GyI8jpHk4IOzVQUDPCU4DKnOtIj
         Cw1+8bylbGTIlK8wHY+B/SbPoSXxrEluk6G+SKCTYI3XIRIEevMy4M/jIQdhymttFuAZ
         qLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683687361; x=1686279361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79gxakGJCh3jYG7uTZc/fT3rB4f5EGGFQBHhIC6aUJA=;
        b=FW39stzo4rBX4OmzJHaL3BNduMzGe3Pq5aYVFnj8u29IN91sgZW8ty3pZZpw3Xl41t
         2rDKdh7qo7s+PmnhHc6+Ykgd865AacW2XR+M9jxPxBpuySycQ3A8SVI3AO2lkQ98IRju
         am3tKgVaF/Y5CvPLYK45RXzgOh0v+iDLGz4BGYrHBe9pdz19KUatPp0O7KfsZ3H6GKOB
         LJhx8qlkLvidEQsS53y4m7T5R7V1pyQt6+YwXZQ2FGechNQseCgE78es96Q7h9+P/7Qf
         ha4U7P6NHQF5euln5dzce0fcwcMg/OgJmReZ/+he9mU7Ce4k0nN8LHNzW1fnRnrjc2Fe
         WSVA==
X-Gm-Message-State: AC+VfDyTmgasM9NSK/dn7su/Lbnds9Y4QCSWgmZ1bHOor6OHnTH2VvP8
	tI1YQVYHDhxlC4ZUCHDAV7nmJuc2+h1CBwToE54=
X-Google-Smtp-Source: ACHHUZ4tvlCxnmXYJdh2rzZvQnaXFxoKQr5Ic43d5U6QV7+h3uCvwO608CzbjKJ7po+CAYl6PW6LtDZxwTZa+AI8zG8=
X-Received: by 2002:ad4:5f8e:0:b0:61a:197b:605 with SMTP id
 jp14-20020ad45f8e000000b0061a197b0605mr24240280qvb.1.1683687361584; Tue, 09
 May 2023 19:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-3-laoar.shao@gmail.com>
 <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
In-Reply-To: <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 10 May 2023 10:55:25 +0800
Message-ID: <CALOAHbCZfCbGP-gaVKnG_9HGkbVnArCn+EcqweGtA8+wRmJDvQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of
 selector in trampoline ksym
To: Song Liu <song@kernel.org>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 10, 2023 at 1:43=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Tue, May 9, 2023 at 8:15=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> >
> > After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selector
> > is only used to indicate how many times the bpf trampoline image are
> > updated and been displayed in the trampoline ksym name. After the
> > trampoline is freed, the count will start from 0 again.
> > So the count is a useless value to the user, we'd better
> > show a more meaningful value like how many progs are linked to this
> > trampoline. After that change, the selector can be removed eventally.
> > If the user want to check whether the bpf trampoline image has been upd=
ated
> > or not, the user can also compare the address. Each time the trampoline
> > image is updated, the address will change consequently.
>
> I wonder whether this will cause confusion to some users. Maybe the savin=
g
> doesn't worth the churn.

The trampoline ksym name as such:
ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]

I don't know what the user may use the selector for. It seems that the
selector is meaningless. While the cnt of linked progs can really help
users, with which the user can easily figure out how many progs are
linked to a kernel function.

However the key in the ksym name really confused me before, because
its meaning was changed.

In the old kernel(for example, the 4.19), it is
  bpf_trampoline_[BTF_ID]
while in the new kernel, it is
  bpf_trampoline_[ OBJ_ID | BTF_ID ]_[ SELECTOR ]

But I think that is not a big problem, because the user tools can be
changed to (key & 0x7fffffff) to make it backward compatible.

Currently there's no document on the name, so we can choose what we
prefer. After we doc it, we have to keep it backward compatible.
BTW, I think we should add a document on the name, otherwise the user
has to read the kernel code to parse it.

--=20
Regards
Yafang

