Return-Path: <bpf+bounces-9370-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBC979441C
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 22:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE3191C20A9F
	for <lists+bpf@lfdr.de>; Wed,  6 Sep 2023 20:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420EB11C8E;
	Wed,  6 Sep 2023 20:00:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B811C83
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 20:00:26 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E90B1992
	for <bpf@vger.kernel.org>; Wed,  6 Sep 2023 13:00:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bd0bc8b429so4384111fa.2
        for <bpf@vger.kernel.org>; Wed, 06 Sep 2023 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694030423; x=1694635223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xy88EBeuQMEwFqL1xHDEhtNpBzsGGmSDUJdc6Sb/udE=;
        b=Ri2hGYwJKf0iV+93hHDLpAhJSKuOurCp5IpuhQDVag624TOi0zImdBgXReFo1KTEI/
         t9gJnh2PH05nGTfUjci5tVi9VnEhtfgg1nGj7H989tYtbc8x5uxoCvxyzRQZuavDMmbB
         0lh6h9mAlwtzcObdYfpUC5yMqgCYOuKxM6zmv6N6cUYpV0w0ttehyJFqVd6tw/6rNOEb
         H8BrI+6wlsUj/Uhz39qcK4TAPhBFzzT/pHQFfy+iB0SOKXZEpmRV8PPHzXDDt8jdDW9S
         oYzCfMGaqWY2lhF3HAyTu6l6FJJA3lQz67dKY0UrVps5wwurNqE2sz0lkHSamgixBIVk
         jS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694030423; x=1694635223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xy88EBeuQMEwFqL1xHDEhtNpBzsGGmSDUJdc6Sb/udE=;
        b=j18tXlS3rR94yBHC2UtUH6I0uRJ3n3mzxZy4iU/LQO3U6Lw6p9Mtcib4DCgUwgeFSm
         YLwUL/FcyAIaFmqPZxr4CWw2gU94pD1MDyHCDx6+Q0HRFZdG1oCy3NLUgeCIs+ZzsJqg
         aNhpByZsb9y70eRiZ+RSa/gyQiFtFKVr//y7J9ODAK9Ji8Hkk4FgAhsxdua5xBIRD4aR
         5+2eWvLe4YWpOi4iJJ7iugyGpWAXtLJyoH6/BzUKZo+0JVBI5cCiaCWGW8w7fOuzoKwn
         lwVytLJ65tkBIVzP5SWaFKnyZr0JnE2xzqEDj/CQXj9U+hvt7etUzkQOngQrf1q/1lMW
         JjNA==
X-Gm-Message-State: AOJu0YwltOHLVXZDixidmto6GL0Alqb0fL4+yjPyl+7pgTYg3RxGXlX0
	nLW+oKipMzeaR2cW/xsNDaWrhjVoCYd8xzRnVHM5CuZ7
X-Google-Smtp-Source: AGHT+IFItm974jpiFCfHWehtiN4XHj6YFvOONC8zrfZn4Z1L/TAMwGZi/VmtW8SVVnd6NprCjAACfuVhL6nQp/4JXHk=
X-Received: by 2002:a2e:7007:0:b0:2bd:bc9:30aa with SMTP id
 l7-20020a2e7007000000b002bd0bc930aamr2613919ljc.23.1694030423062; Wed, 06 Sep
 2023 13:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230905154612.GA24872@redhat.com> <20230905195829.GA8002@redhat.com>
In-Reply-To: <20230905195829.GA8002@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Sep 2023 13:00:11 -0700
Message-ID: <CAADnVQJw81i+Qe0fveT07K39YkMA4xocQGZBmu=FbT+17sjxdg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/5] bpf: task_group_seq_get_next: misc cleanups
To: Oleg Nesterov <oleg@redhat.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, "Eric W. Biederman" <ebiederm@xmission.com>, 
	Kui-Feng Lee <sinquersw@gmail.com>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 5, 2023 at 12:59=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> sorry for noise, forgot to mention...
>
> this (hopefully simple) series was only compile-tested.
>
> On 09/05, Oleg Nesterov wrote:
> >
> > Yonghong,
> >
> > I am resending 1-5 of 6 as you suggested with your acks included.
> >
> > The next (final) patch will change this code to use __next_thread when
> >
> >       https://lore.kernel.org/all/20230824143142.GA31222@redhat.com/
> >
> > is merged.

The patch set looks fine.
What is the next step?
Should we merge it now in bpf-next and then during the next merge window
you'll follow up with __next_thread clean up?

