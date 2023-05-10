Return-Path: <bpf+bounces-275-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47B96FD703
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 08:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C5592813F8
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 06:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F3C6131;
	Wed, 10 May 2023 06:30:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB29168B2
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D7C1C433A0
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683700235;
	bh=i1TbUcxluEkCGpolKZZVwxRETesvQ9Sc5NjH3pBTtoQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=h39yWFCxTSLaEQ0FN9gxtj/fZ0IjBN54MFgk1JSzVm4UgCJ0zAXVZeR7I+SexCd8P
	 8XbDMGxgJEw9bdyv2iBrxamj/GKXsA1TfBaFbLYlT/n7X0JYVZM9RbvuQf7heVkagF
	 3xjZRWni1rgzbgtVVseKMeH5+7QRT0iXFZjOqn2kBeZJGhDVujIo4rQGUEMxO/M1sT
	 +0rONmPksxUPjK+4DVLB+Ls+bpZj4P6wpoobzwuEb0SoZ4V/3asAAy4/s7ttvJNsb0
	 svRov4dHVj0PzerLwy2ZXdAmClS66IvnGzSFgDFFgbGM4yJngo//5fofRoVwRNc+LC
	 lr4IJzoi4Xi1A==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-4f137dbaa4fso7857023e87.2
        for <bpf@vger.kernel.org>; Tue, 09 May 2023 23:30:34 -0700 (PDT)
X-Gm-Message-State: AC+VfDwm8DWRH9mv3/N59vyoL9d5+Xo6nYoWy/oA1aU8XLOHsp81OhMC
	noKTtPvasxFMSOUAPKFuZk22lRZvEAyOwBXv7kg=
X-Google-Smtp-Source: ACHHUZ7vcKeNob8NsKwa7goflQundjLYQxReaFs+6r70w3gn2+4p+9Z6zJcP9uxmIO3uXHddlCW8lkXDDcguGqdm3mk=
X-Received: by 2002:a05:6512:390f:b0:4ed:b048:b98a with SMTP id
 a15-20020a056512390f00b004edb048b98amr1497240lfu.6.1683700233089; Tue, 09 May
 2023 23:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230509151511.3937-1-laoar.shao@gmail.com> <20230509151511.3937-3-laoar.shao@gmail.com>
 <CAPhsuW6qXXgGkp1DVvHEQCVHvM=yw8nFFhA8LLHgCazwyaoXhA@mail.gmail.com> <CALOAHbCZfCbGP-gaVKnG_9HGkbVnArCn+EcqweGtA8+wRmJDvQ@mail.gmail.com>
In-Reply-To: <CALOAHbCZfCbGP-gaVKnG_9HGkbVnArCn+EcqweGtA8+wRmJDvQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 9 May 2023 23:30:20 -0700
X-Gmail-Original-Message-ID: <CAPhsuW55iK4i_dYsbszkqAdDz4gpwgWU4LATw3Tzj9O63GfOmA@mail.gmail.com>
Message-ID: <CAPhsuW55iK4i_dYsbszkqAdDz4gpwgWU4LATw3Tzj9O63GfOmA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Show total linked progs cnt instead of
 selector in trampoline ksym
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 9, 2023 at 7:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> w=
rote:
>
> On Wed, May 10, 2023 at 1:43=E2=80=AFAM Song Liu <song@kernel.org> wrote:
> >
> > On Tue, May 9, 2023 at 8:15=E2=80=AFAM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> > >
> > > After commit e21aa341785c ("bpf: Fix fexit trampoline."), the selecto=
r
> > > is only used to indicate how many times the bpf trampoline image are
> > > updated and been displayed in the trampoline ksym name. After the
> > > trampoline is freed, the count will start from 0 again.
> > > So the count is a useless value to the user, we'd better
> > > show a more meaningful value like how many progs are linked to this
> > > trampoline. After that change, the selector can be removed eventally.
> > > If the user want to check whether the bpf trampoline image has been u=
pdated
> > > or not, the user can also compare the address. Each time the trampoli=
ne
> > > image is updated, the address will change consequently.
> >
> > I wonder whether this will cause confusion to some users. Maybe the sav=
ing
> > doesn't worth the churn.
>
> The trampoline ksym name as such:
> ffffffffc06c3000 t bpf_trampoline_6442453466_1  [bpf]
>
> I don't know what the user may use the selector for. It seems that the
> selector is meaningless. While the cnt of linked progs can really help
> users, with which the user can easily figure out how many progs are
> linked to a kernel function.

Hmm, agreed that the chance to break user space is low. Maybe we can just
remove it? IOW, only keep bpf_trampoline_6442453466

Thanks,
Song

