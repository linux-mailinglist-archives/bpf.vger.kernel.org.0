Return-Path: <bpf+bounces-3475-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 869C573E706
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 19:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B865C1C20982
	for <lists+bpf@lfdr.de>; Mon, 26 Jun 2023 17:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FA5134A3;
	Mon, 26 Jun 2023 17:55:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8212B69;
	Mon, 26 Jun 2023 17:55:44 +0000 (UTC)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9177D1A1;
	Mon, 26 Jun 2023 10:55:42 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-76547539775so300326585a.3;
        Mon, 26 Jun 2023 10:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687802141; x=1690394141;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q1aWm7CYMYf91fezZegL6NDuEeSHI4TSYthfhMF0R4Q=;
        b=i8wJaBeELo4UQxo+pedm8JVuE8GwMCRlt4l8iWdbcz+PBWm+yhyjdcDMsSGGzix56j
         h9CRiLTfMeNT7yKBiAGeSsCkpH+wurMBABCL5Q+5Nm2Hi6xI6VmX1hhzKl5s6yANgk46
         i0v9yZkC1pQeKYqJ1EG5x5XmIXUBZTnk0uHbcAxAQN8/I7GXJyWOJ1C3OtOsimI7f3sF
         yRXLNocVO5+kvvjci8HiXqzkqkM6f/jW3AUzE711Rg/iw1ZfRS0qaOWpfCLyVwxTgjrF
         kBYjCo3vfGddj+c2UsksMsmdnRJwoWB6BR+qXN6Q3z+3s0rs01uC/HHRs4dG/wO+giQy
         eJyw==
X-Gm-Message-State: AC+VfDyUdetsluNzTjDDCdpS9pt9hwKa1sb5bb0dL4sX1q5rhPIlTXv1
	dpaGxST/BqfT+q0Ev1nXXqA=
X-Google-Smtp-Source: ACHHUZ4oi2iebUmEekyYAuUBfjJWMQn6ilRyZYMAchVqMu9D61Ama9j/HGpvXoTEzM8bNs/3iwuO/Q==
X-Received: by 2002:a05:620a:4114:b0:766:fd7c:f52e with SMTP id j20-20020a05620a411400b00766fd7cf52emr1197768qko.66.1687802141445;
        Mon, 26 Jun 2023 10:55:41 -0700 (PDT)
Received: from maniforge ([2620:10d:c091:400::5:58aa])
        by smtp.gmail.com with ESMTPSA id x13-20020a05620a14ad00b00759554bbe48sm1057474qkj.4.2023.06.26.10.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 10:55:41 -0700 (PDT)
Date: Mon, 26 Jun 2023 12:55:38 -0500
From: David Vernet <void@manifault.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Hou Tao <houtao@huaweicloud.com>,
	"Paul E. McKenney" <paulmck@kernel.org>, Tejun Heo <tj@kernel.org>,
	rcu@vger.kernel.org, Network Development <netdev@vger.kernel.org>,
	bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 13/13] bpf: Convert bpf_cpumask to
 bpf_mem_cache_free_rcu.
Message-ID: <20230626175538.GA6750@maniforge>
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
 <20230624031333.96597-14-alexei.starovoitov@gmail.com>
 <20230626154228.GA6798@maniforge>
 <CAADnVQK7rgcSevdyrG8t-rPqg-n8=Eic8K63q-q3SPtOR0VP2Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK7rgcSevdyrG8t-rPqg-n8=Eic8K63q-q3SPtOR0VP2Q@mail.gmail.com>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 26, 2023 at 09:09:20AM -0700, Alexei Starovoitov wrote:
> On Mon, Jun 26, 2023 at 8:42 AM David Vernet <void@manifault.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 08:13:33PM -0700, Alexei Starovoitov wrote:
> > > From: Alexei Starovoitov <ast@kernel.org>
> > >
> > > Convert bpf_cpumask to bpf_mem_cache_free_rcu.
> > >
> > > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> >
> > Acked-by: David Vernet <void@manifault.com>
> >
> > LGTM, thanks for cleaning this up. I left one drive-by comment /
> > observation below, but it's not a blocker for this patch / series.
> >
> > > ---
> > >  kernel/bpf/cpumask.c | 20 ++++++--------------
> > >  1 file changed, 6 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/kernel/bpf/cpumask.c b/kernel/bpf/cpumask.c
> > > index 938a60ff4295..6983af8e093c 100644
> > > --- a/kernel/bpf/cpumask.c
> > > +++ b/kernel/bpf/cpumask.c
> > > @@ -9,7 +9,6 @@
> > >  /**
> > >   * struct bpf_cpumask - refcounted BPF cpumask wrapper structure
> > >   * @cpumask: The actual cpumask embedded in the struct.
> > > - * @rcu:     The RCU head used to free the cpumask with RCU safety.
> > >   * @usage:   Object reference counter. When the refcount goes to 0, the
> > >   *           memory is released back to the BPF allocator, which provides
> > >   *           RCU safety.
> > > @@ -25,7 +24,6 @@
> > >   */
> > >  struct bpf_cpumask {
> > >       cpumask_t cpumask;
> > > -     struct rcu_head rcu;
> > >       refcount_t usage;
> > >  };
> > >
> > > @@ -82,16 +80,6 @@ __bpf_kfunc struct bpf_cpumask *bpf_cpumask_acquire(struct bpf_cpumask *cpumask)
> > >       return cpumask;
> > >  }
> > >
> > > -static void cpumask_free_cb(struct rcu_head *head)
> > > -{
> > > -     struct bpf_cpumask *cpumask;
> > > -
> > > -     cpumask = container_of(head, struct bpf_cpumask, rcu);
> > > -     migrate_disable();
> > > -     bpf_mem_cache_free(&bpf_cpumask_ma, cpumask);
> > > -     migrate_enable();
> > > -}
> > > -
> > >  /**
> > >   * bpf_cpumask_release() - Release a previously acquired BPF cpumask.
> > >   * @cpumask: The cpumask being released.
> > > @@ -102,8 +90,12 @@ static void cpumask_free_cb(struct rcu_head *head)
> > >   */
> > >  __bpf_kfunc void bpf_cpumask_release(struct bpf_cpumask *cpumask)
> > >  {
> > > -     if (refcount_dec_and_test(&cpumask->usage))
> > > -             call_rcu(&cpumask->rcu, cpumask_free_cb);
> > > +     if (!refcount_dec_and_test(&cpumask->usage))
> > > +             return;
> > > +
> > > +     migrate_disable();
> > > +     bpf_mem_cache_free_rcu(&bpf_cpumask_ma, cpumask);
> > > +     migrate_enable();
> >
> > The fact that callers have to disable migration like this in order to
> > safely free the memory feels a bit leaky. Is there any reason we can't
> > move this into bpf_mem_{cache_}free_rcu()?
> 
> migrate_disable/enable() are actually not necessary here.
> We can call bpf_mem_cache_free_rcu() directly from any kfunc.

Could you please clarify why? Can't we migrate if the kfunc is called
from a sleepable struct_ops callback? If migration is always disabled
for any kfunc then I agree these migrate_{en,dis}able() calls can be
removed. Otherwise from my reading of the code we'd race between calling
this_cpu_ptr() and the local_irq_save() in unit_free().

Thanks,
David

> Explicit migrate_disable() is only necessary from syscall.
>
> I believe rcu callbacks also cannot migrate, so the existing
> code probably doesn't need them either.

