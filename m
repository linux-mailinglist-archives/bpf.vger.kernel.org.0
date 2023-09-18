Return-Path: <bpf+bounces-10309-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A67A4E50
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E53AF282063
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084D6241E3;
	Mon, 18 Sep 2023 16:08:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A9122EF9
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:08:06 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8349D5
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:07:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-502d9ce31cbso7808699e87.3
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053271; x=1695658071; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3mK8C7VlBkNEZPoL7UlANLlRR5/3w2XO9j+UjJcCw0=;
        b=Er4Q7omybGMbVQZB/PDA9JnqesQk7zHwg+9iTj9DksYywLCuUm3iASDuGX2aMcxX/2
         DIwZ+YZutYqikOVnEcDE/eKMoRFguU5A/8Hu+phwascIDst8rLGqFhOTxx36Bo3SC9QY
         efnNfmCh4K1IKQ4YJ2s34eiU5VauxUcYxdptA/ysOOoillwD6NANelyxjTkp5nj4qCst
         DA6eAeG41Yi8DvNimcsufiEE16IXOy2YWMZ4+w2kB6jrBK2QRcXArqEr3NzbL1Jwiiwa
         2Qr8MRqj+pCA7b4zv5P94ca4A8Yl4D8ahN6SGExFdQO5mG6u1NeWgF+m2BXkmqofXr59
         90LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053271; x=1695658071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3mK8C7VlBkNEZPoL7UlANLlRR5/3w2XO9j+UjJcCw0=;
        b=dk+tpiuSH8phjxMjdkqA7XPpOiYNSLcGQJTOzf72139S17D2cQ2+Yvf5bVAMKR/GAJ
         pwuVv+c1yWm9zyuD3B9isoUSeSeFFaa9jj4sEKOqiEqbYZzcrE7QmyYjeDBO4AWlpGAh
         e6Qn/AZYYqUtAk2Hc4XlVn7HfP3ZFq56tpUsdZct8CaxyZ3RiAZyYaKB6bqrQpgwRIhq
         MDnDFhlaYstLDHHi+LqHIo63WWYqvTeXWf2bGxjusZBIK9A6rbQBdUsXoqdOQOP7vopj
         5/4Ef6KfDxGMMOnM6l1V4Z1mf13J36MbbA5JkJK78EnyJ5hEjaLyO/YRb6Qa2c7p1T95
         Gwnw==
X-Gm-Message-State: AOJu0YxQDeX5/tpeplppcYtwE9HBEVSzSM5E5JKJpbbodBgXM/AVlc6D
	Q69u5/O9Rx8BK75T2q0K+3eQf16TZf077x69Y4JDCyHcVSg=
X-Google-Smtp-Source: AGHT+IGSwF6GdgtCjjRKwWlb8nV+py5vXI1mtKCFnxtTAu6vhRfs/6DH0lUskHX8lC4Z1GtZu6v1kt3hDj32ovizPB8=
X-Received: by 2002:a05:6402:14c8:b0:52f:bd60:b54b with SMTP id
 f8-20020a05640214c800b0052fbd60b54bmr9571055edx.37.1695052580204; Mon, 18 Sep
 2023 08:56:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230918143914.292526-1-memxor@gmail.com> <20230918143914.292526-4-memxor@gmail.com>
 <CAADnVQLX6BBzQuFS8bcP2ucfSDFGZT3C+N+yagxUiMPtnsra-Q@mail.gmail.com>
In-Reply-To: <CAADnVQLX6BBzQuFS8bcP2ucfSDFGZT3C+N+yagxUiMPtnsra-Q@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Mon, 18 Sep 2023 17:55:44 +0200
Message-ID: <CAP01T77-JhKRYTC95Ek74Mgp5PNLZnah3bY4NCUhf9t1oEu51A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 3/3] bpf: Disable exceptions when CONFIG_UNWINDER_FRAME_POINTER=y
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, David Vernet <void@manifault.com>, 
	Puranjay Mohan <puranjay12@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 18 Sept 2023 at 17:48, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Sep 18, 2023 at 7:39=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > The build with CONFIG_UNWINDER_FRAME_POINTER=3Dy is broken for
> > current exceptions feature as it assumes ORC unwinder specific fields i=
n
> > the unwind_state. Disable exceptions when frame_pointer unwinder is
> > enabled for now.
> >
> > Fixes: fd5d27b70188 ("arch/x86: Implement arch_bpf_stack_walk")
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>
> Very weird that only this patch reached patchwork.
> Could you resend and trim cc list significantly?

I have resent it with just BPF and you in To:.
But I think it's not with this patch, a lot of emails are not
appearing on the list.

