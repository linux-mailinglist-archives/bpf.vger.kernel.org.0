Return-Path: <bpf+bounces-3684-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 380E3741ECF
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 05:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E650B280D64
	for <lists+bpf@lfdr.de>; Thu, 29 Jun 2023 03:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26BD1FD9;
	Thu, 29 Jun 2023 03:42:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582CC1FAD;
	Thu, 29 Jun 2023 03:42:46 +0000 (UTC)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552312728;
	Wed, 28 Jun 2023 20:42:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b6a084a34cso2881171fa.1;
        Wed, 28 Jun 2023 20:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688010162; x=1690602162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wr149jZoNPWXuN3QHy5A1rvPR4vA8OIAR36UxjCf/SA=;
        b=rwSqMVC8T5Rx1SRIA3yNto/INYUm6JZvH+MR2NTn3iYgnmO2idbdBrZTPXjC9eAQRk
         NwKLWhQ3HmWcJTnKqnhkRYWlJfAbzVnSX5aL5rarctM1LxX6XjHMoveXJ1tVZqRUVCZz
         j/EM+oc/QWq5MwD+NRtTCm0mm2KqPKReEV+aX7gt+riaLM1R+5pGchjKTGaqEvfZPwRL
         tDr/qojRO/wp4dt55E6ZorMn5oImdLLQ2hmyS1sjcH9kbgS+QqQ/820n3vvNDlYpLcaS
         +6AzDw5nFWt0majLak73aaIaOhHvMpZQ4E2qkIHTRnsHftsxjEMgnBpcgdZP6Q1U6ZQr
         Gzww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688010162; x=1690602162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wr149jZoNPWXuN3QHy5A1rvPR4vA8OIAR36UxjCf/SA=;
        b=JBfFKKVgAOQyL8eRsKLYUj94ZZuUiagjWbUtICeqBp/G6GmHCceizDKe9OogcrGAYZ
         AA7PdtrCnVJ7GlE7pw0LO6dtOrqmhQVAcJoKt6+Qwgex30WhROlgeG/u/SPnqyd1uu0D
         PjYP7qTzD4LWkxC8eZwPZslpUwF50tLV/cst5uRmyaRD/10LThtPd4o4dEeMqXmVbLg3
         AROJSJlAwM+fTsU95tBFP8AvTe0g1j/y6IYj/8hDUr2cJjz6j6HhzFZvaBylnRdnvurz
         3hQno10VX/2hzfyxtXZiqZTqrfLAfVWymGDV3NkzFdiOxwHDP3VWANazqHBEoR5zjyUh
         AQ5Q==
X-Gm-Message-State: AC+VfDyhbuaWkm3ODisa0JR7DhGXdVstq9f/Jx8/sNA91P6I9E/WqBx4
	z1oCJFCcDHF52IVQw4yVG2WFaoQ/bJY7i0qdVxA=
X-Google-Smtp-Source: ACHHUZ75OV1yg39k+UNCOrVGppDdjMiIKg9L95G0FO/zmcjy6aEDejVpRZNUf6xxTI9Ie721nq7UOLqJqfdqbuJ1crA=
X-Received: by 2002:a2e:b602:0:b0:2b5:7f93:b3ae with SMTP id
 r2-20020a2eb602000000b002b57f93b3aemr17941211ljn.38.1688010162270; Wed, 28
 Jun 2023 20:42:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628015634.33193-1-alexei.starovoitov@gmail.com>
 <20230628015634.33193-13-alexei.starovoitov@gmail.com> <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
In-Reply-To: <57ceda87-e882-54b0-057a-2767c4395122@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 28 Jun 2023 20:42:31 -0700
Message-ID: <CAADnVQ+V_SiZynZfGMWjSqkKb+8xggvBUmy7oTFUcvGq_2CcLg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 12/13] bpf: Introduce bpf_mem_free_rcu()
 similar to kfree_rcu().
To: Hou Tao <houtao@huaweicloud.com>
Cc: Tejun Heo <tj@kernel.org>, rcu@vger.kernel.org, 
	Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Kernel Team <kernel-team@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 28, 2023 at 7:24=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 6/28/2023 9:56 AM, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Introduce bpf_mem_[cache_]free_rcu() similar to kfree_rcu().
> > Unlike bpf_mem_[cache_]free() that links objects for immediate reuse in=
to
> > per-cpu free list the _rcu() flavor waits for RCU grace period and then=
 moves
> > objects into free_by_rcu_ttrace list where they are waiting for RCU
> > task trace grace period to be freed into slab.
> >
> > The life cycle of objects:
> > alloc: dequeue free_llist
> > free: enqeueu free_llist
> > free_rcu: enqueue free_by_rcu -> waiting_for_gp
> > free_llist above high watermark -> free_by_rcu_ttrace
> > after RCU GP waiting_for_gp -> free_by_rcu_ttrace
> > free_by_rcu_ttrace -> waiting_for_gp_ttrace -> slab
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> SNIP
> >
> > +static void __free_by_rcu(struct rcu_head *head)
> > +{
> > +     struct bpf_mem_cache *c =3D container_of(head, struct bpf_mem_cac=
he, rcu);
> > +     struct bpf_mem_cache *tgt =3D c->tgt;
> > +     struct llist_node *llnode;
> > +
> > +     llnode =3D llist_del_all(&c->waiting_for_gp);
> > +     if (!llnode)
> > +             goto out;
> > +
> > +     llist_add_batch(llnode, c->waiting_for_gp_tail, &tgt->free_by_rcu=
_ttrace);
> > +
> > +     /* Objects went through regular RCU GP. Send them to RCU tasks tr=
ace */
> > +     do_call_rcu_ttrace(tgt);
>
> I still got report about leaked free_by_rcu_ttrace without adding any
> extra hack except using bpf_mem_cache_free_rcu() in htab.

Please share the steps to repro.

> When bpf ma is freed through free_mem_alloc(), the following sequence
> may lead to leak of free_by_rcu_ttrace:
>
> P1: bpf_mem_alloc_destroy()
>     P2: __free_by_rcu()
>
>     // got false
>     P2: read c->draining
>
> P1: c->draining =3D true
> P1: llist_del_all(&c->free_by_rcu_ttrace)
>
>     // add to free_by_rcu_ttrace again
>     P2: llist_add_batch(..., &tgt->free_by_rcu_ttrace)
>         P2: do_call_rcu_ttrace()
>             // call_rcu_ttrace_in_progress is 1, so xchg return 1
>             // and it doesn't being moved to waiting_for_gp_ttrace
>             P2: atomic_xchg(&c->call_rcu_ttrace_in_progress, 1)
>
> // got 1
> P1: atomic_read(&c->call_rcu_ttrace_in_progress)
> // objects in free_by_rcu_ttrace is leaked
>
> I think the race could be fixed by checking c->draining in
> do_call_rcu_ttrace() when atomic_xchg() returns 1 as shown below:

If the theory of the bug holds true then the fix makes sense,
but did you repro without fix and cannot repro with the fix?
We should not add extra code based on a hunch.

