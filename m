Return-Path: <bpf+bounces-8663-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5E9788DB1
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 19:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7212816FF
	for <lists+bpf@lfdr.de>; Fri, 25 Aug 2023 17:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604D18030;
	Fri, 25 Aug 2023 17:16:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4E6107A8
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 17:16:32 +0000 (UTC)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E242119
	for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:16:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2bcb89b4767so17385331fa.3
        for <bpf@vger.kernel.org>; Fri, 25 Aug 2023 10:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692983789; x=1693588589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCKnyxnS+KLnRxq9cOu8Y+IzoMZmPJRSE2Q/RiRYz20=;
        b=FU4etC+mMA1XPqkYqWShGWkYBoHeBjOaBW3CT33BiuIE32oLFW/+GKwXk8GFpK8R9l
         fFTwQUw5bCxUWzjAIB97kJhW7/2LXkdrrmnXA5g9MFKKL5ClV9VJZoSi3hLaKYcwjUEs
         q0Kb2Pk/3cKIP32EEN2mqCBJKX0l7rgrHuxiZSNn+fmXFv4cwp5OYrQRpCX3J+go/S0i
         1wxaeKLDIAVgxfMSZyzApZGsDP3n5vCLTUYz8a3jldkEG0kK4IOzwCxq+6YPBBFdWVU3
         1YXejHLFBc6Sm+qciYQtC5SRVRPbSI7XG5h1Spsr610CHlRtFnPB2P7YK1VeY2W+xbcl
         d0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692983789; x=1693588589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CCKnyxnS+KLnRxq9cOu8Y+IzoMZmPJRSE2Q/RiRYz20=;
        b=bBQiFhSVj37w36FXdsaJ/IU0WMM/CN8SXOTWK8H130j2qQlAdiNxgc9TJchgftxZJY
         29ISYuaBBsoQhDq0VHWniupRblspvC6RxYupkzGNNF9T21ez+e7t+HiHhTKWwfoMG2+f
         N4AqMpZu2cCkBvSelwnaC7vl5xmUf7LNn1CHmeaVHeHr+WOxEVqnorVGKo7Ks4W/3FA/
         wuDBsWC9BqfMIMp/WUWjmeD+9NRCGxOAacyh8C6zbOO3jzGDEyXakMg+x9adFTYBnYQw
         0OSaXcZIlcgZNhJDKAdX/ppbC8fA/TNR4uPv1GJA3Vv6BDU2icsZObuVXaoz50gQBJCf
         59rQ==
X-Gm-Message-State: AOJu0Yxd+7uaGy7pLYgLLdcXETH8bBqDCXqlHnuTutK1yL9a3GA6GGP/
	1Axa6nKb54mJIJ3K+TUpH2PSwxTyZWJ9nAe+lIc=
X-Google-Smtp-Source: AGHT+IHhjGkf4jakBBbh5x2oT2TLKZS+V2PJBFavcN2ZbC/zexIm4cpUFLFjjLf3lk2Sf/YLSa/l1lSJlag0ot3ipqs=
X-Received: by 2002:a2e:9007:0:b0:2b9:e701:ac48 with SMTP id
 h7-20020a2e9007000000b002b9e701ac48mr16274774ljg.32.1692983788709; Fri, 25
 Aug 2023 10:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230822133807.3198625-1-houtao@huaweicloud.com>
 <20230822133807.3198625-2-houtao@huaweicloud.com> <CAADnVQKFh9pWp1abrG2KKiZanb+4rzRb3HmzX0snggah3Lq-yg@mail.gmail.com>
 <bf4faa34-019c-bb3d-a451-a067bbe027a4@huaweicloud.com> <CAADnVQJfpxk3dsjYdH8DUarJHu0wFXa24XFxvn+F5mseMKTAhQ@mail.gmail.com>
 <3c30289a-d683-d1c8-b18d-c87a5ecebe3b@huaweicloud.com> <CAADnVQLHPx-0dR7nBXAfBHOpF09Jr6+cqGjfGf9mT2BHCid5YA@mail.gmail.com>
 <5fe435aa-526f-4b54-b0d2-e0ae1c6c234c@huaweicloud.com> <CAADnVQLtJBOTueuGZHM0PUhskMZY-uaaehvgfx7pkpq0qfhvVA@mail.gmail.com>
 <a6a78ccf-4a48-be46-f2c7-aa0a5a3285d8@huaweicloud.com>
In-Reply-To: <a6a78ccf-4a48-be46-f2c7-aa0a5a3285d8@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Aug 2023 10:16:17 -0700
Message-ID: <CAADnVQ+NyR-d-P3fdw14ehy2fficAhPikJ2ZrQi1Db-yGNTiCQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Enable preemption after
 irq_work_raise() in unit_alloc()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 11:04=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> w=
rote:
>
> > Could you try the following:
> > diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> > index 9c49ae53deaf..ee8262f58c5a 100644
> > --- a/kernel/bpf/memalloc.c
> > +++ b/kernel/bpf/memalloc.c
> > @@ -442,7 +442,10 @@ static void bpf_mem_refill(struct irq_work *work)
> >
> >  static void notrace irq_work_raise(struct bpf_mem_cache *c)
> >  {
> > -       irq_work_queue(&c->refill_work);
> > +       if (!irq_work_queue(&c->refill_work)) {
> > +               preempt_disable_notrace();
> > +               preempt_enable_notrace();
> > +       }
> >  }
> >
> > The idea that it will ask for resched if preemptible.
> > will it address the issue you're seeing?
> >
> > .
>
> No. It didn't work.

why?

> If you are concerning about the overhead of
> preempt_enabled_notrace(), we could use local_irq_save() and
> local_irq_restore() instead.

That's much better.
Moving local_irq_restore() after irq_work_raise() in process ctx
would mean that irq_work will execute immediately after local_irq_restore()
which would make bpf_ma to behave like sync allocation.
Which is the ideal situation. preempt disable/enable game is more fragile.

