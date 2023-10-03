Return-Path: <bpf+bounces-11297-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF01C7B70CF
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6BDE62813DE
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F513C6A2;
	Tue,  3 Oct 2023 18:29:47 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F19347CD
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:29:45 +0000 (UTC)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BE990;
	Tue,  3 Oct 2023 11:29:42 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-690d8fb3b7eso973644b3a.1;
        Tue, 03 Oct 2023 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357782; x=1696962582;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8sQRY8roqNIFk3L84KXVcV0uLeEhN7pGXERpmeZkvg=;
        b=tSsnzmPHOEL25bHOw6FAZ/iyMLFWSzFn/0rVtdyQqhPzBhipYpdLw9mwwpMyKj++Kx
         sBzK7kSWJMrjgDnf848dEsO35fjwFu2ACbPW2IfwCTMRQ5eWkZyTysloipwVBdt66eB4
         uD9Fjnm9tzfrTTT8y4dRSbuHZn6SrH4NaOUqm1LIXrLGWtVhVqDFh0eVzl4dLZIBnyVI
         bBBzlbRLeOUEV7SJaC7mjlp/xHiZmKUhvd46KvRnQk9NpGuUidoM1bGG5vDCN+uHaFX2
         P1hznFHTEp61W+3wmKhgP6GZAE2emxYsNsaLErp1v8Y2szdB+gxd7QJfo8izesjngFuT
         tJ1g==
X-Gm-Message-State: AOJu0YyjczOMTF9vzGSBVxMNuFd9CsHwHOCJ+Gh+QjdY9bwMeFSjJBoq
	DxrmbrjwxigBvz8rkhtzEbw=
X-Google-Smtp-Source: AGHT+IG6HIs+20OBGFQ3lm7n7+ND1W09MC3dl849h2sUlCWqAAFTtkCxzugKEheYLuy2Iq/oRGCZLg==
X-Received: by 2002:a05:6a20:144c:b0:13c:ca8b:7e29 with SMTP id a12-20020a056a20144c00b0013cca8b7e29mr345308pzi.12.1696357782138;
        Tue, 03 Oct 2023 11:29:42 -0700 (PDT)
Received: from maniforge ([2620:10d:c090:400::4:d6ec])
        by smtp.gmail.com with ESMTPSA id c9-20020a62e809000000b00690b8961bf4sm1724032pfi.146.2023.10.03.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:29:41 -0700 (PDT)
Date: Tue, 3 Oct 2023 13:29:36 -0500
From: David Vernet <void@manifault.com>
To: Song Liu <songliubraving@meta.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>,
	"song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>,
	"kpsingh@kernel.org" <kpsingh@kernel.org>,
	"sdf@google.com" <sdf@google.com>,
	"haoluo@google.com" <haoluo@google.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kernel Team <kernel-team@meta.com>,
	"himadrispandya@gmail.com" <himadrispandya@gmail.com>,
	"julia.lawall@inria.fr" <julia.lawall@inria.fr>
Subject: Re: [PATCH bpf-next 2/2] bpf/selftests: Test pinning bpf timer to a
 core
Message-ID: <20231003182936.GC5902@maniforge>
References: <20231002234708.331192-1-void@manifault.com>
 <20231002234708.331192-2-void@manifault.com>
 <4EC94A6E-B3C5-4D2D-BD4B-FF7C4F149FD1@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4EC94A6E-B3C5-4D2D-BD4B-FF7C4F149FD1@fb.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 03, 2023 at 06:15:03PM +0000, Song Liu wrote:
> 
> 
> > On Oct 2, 2023, at 4:47 PM, David Vernet <void@manifault.com> wrote:
> > 
> > Now that we support pinning a BPF timer to the current core, we should
> > test it with some selftests. This patch adds two new testcases to the
> > timer suite, which verifies that a BPF timer both with and without
> > BPF_F_TIMER_ABS, can be pinned to the calling core with
> > BPF_F_TIMER_CPU_PIN.
> > 
> > Signed-off-by: David Vernet <void@manifault.com>
> 
> Acked-by: Song Liu <song@kernel.org>
> 
> With one nit/question below. 
> 
> > ---
> > .../testing/selftests/bpf/prog_tests/timer.c  |  4 +
> > tools/testing/selftests/bpf/progs/timer.c     | 75 +++++++++++++++++++
> > 2 files changed, 79 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
> > index 290c21dbe65a..d8bc838445ec 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/timer.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/timer.c
> > @@ -14,6 +14,7 @@ static int timer(struct timer *timer_skel)
> > 
> > ASSERT_EQ(timer_skel->data->callback_check, 52, "callback_check1");
> > ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");
> > + ASSERT_EQ(timer_skel->bss->pinned_callback_check, 0, "pinned_callback_check1");
> > 
> > prog_fd = bpf_program__fd(timer_skel->progs.test1);
> > err = bpf_prog_test_run_opts(prog_fd, &topts);
> > @@ -32,6 +33,9 @@ static int timer(struct timer *timer_skel)
> > /* check that timer_cb3() was executed twice */
> > ASSERT_EQ(timer_skel->bss->abs_data, 12, "abs_data");
> > 
> > + /* check that timer_cb_pinned() was executed twice */
> > + ASSERT_EQ(timer_skel->bss->pinned_callback_check, 2, "pinned_callback_check");
> > +
> > /* check that there were no errors in timer execution */
> > ASSERT_EQ(timer_skel->bss->err, 0, "err");
> > 
> > diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
> > index 9a16d95213e1..0112b9c038b4 100644
> > --- a/tools/testing/selftests/bpf/progs/timer.c
> > +++ b/tools/testing/selftests/bpf/progs/timer.c
> > @@ -53,12 +53,28 @@ struct {
> > __type(value, struct elem);
> > } abs_timer SEC(".maps");
> > 
> > +struct {
> > + __uint(type, BPF_MAP_TYPE_ARRAY);
> > + __uint(max_entries, 1);
> > + __type(key, int);
> > + __type(value, struct elem);
> > +} soft_timer_pinned SEC(".maps");
> > +
> > +struct {
> > + __uint(type, BPF_MAP_TYPE_ARRAY);
> > + __uint(max_entries, 1);
> > + __type(key, int);
> > + __type(value, struct elem);
> > +} abs_timer_pinned SEC(".maps");
> 
> nit: I think we can also do something like the following, but I am not 
> sure whether this style is not recommended. 
> 
> diff --git i/tools/testing/selftests/bpf/progs/timer.c w/tools/testing/selftests/bpf/progs/timer.c
> index 9a16d95213e1..638eeebcd6c9 100644
> --- i/tools/testing/selftests/bpf/progs/timer.c
> +++ w/tools/testing/selftests/bpf/progs/timer.c
> @@ -51,7 +51,7 @@ struct {
>         __uint(max_entries, 1);
>         __type(key, int);
>         __type(value, struct elem);
> -} abs_timer SEC(".maps");
> +} abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps");

This looks like a nice readability improvement / cleanup to me. If
nobody objects, I'd say let's apply it.

Thanks,
David

