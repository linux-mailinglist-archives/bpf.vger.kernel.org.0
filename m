Return-Path: <bpf+bounces-8387-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3031F785D24
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 18:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0CBB2812C7
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DC0CA41;
	Wed, 23 Aug 2023 16:20:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8AFC2CB
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 16:20:42 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A151B0
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:20:40 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b703a0453fso96873751fa.3
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 09:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692807639; x=1693412439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgsf86BNhMX3GiCgge0P9KHFW3xNlPFln9yO2+fzkpc=;
        b=TScK7YE7AktEE4CTIDh43pbKJXfsRq6sr+NBuLZoNJ4q6uN7Tn3upLbMDkm6Vuw04s
         q2QPpWMnh+kccXqJqwCD7Sim372dqPbrLxWjxVu7qgr5Ra8mwnh9TFcusEX40ZQnZST4
         o9YBH8biEVZJO9yQTx2yPdJH4cK46FVgdtqJArqC6QMzuc8NF00ApZrDEhSFYgNsVdZR
         TBuLS//2FYM0uBOV2eDNZgvaMOToSIHqau6ggktOMYpc2RPcsRP1jJ9tNJbieDB8sOFW
         Cf5Fsawsh6t1ZZBmb7KSeM8zW/E9wPnmLA9KtUEijxXy8fFysjea8eRZYSVnZDR/lEgl
         0IzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692807639; x=1693412439;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgsf86BNhMX3GiCgge0P9KHFW3xNlPFln9yO2+fzkpc=;
        b=hSaIQls+aTEA8ttITpQsqVLeDLnB3XC6DAYrHR3RZ2+ZQDngFGGw5wO4whpmaStbYP
         T+Gi7Hpa4eUK485VuUL/O477L2n3qW5D1Gus6D0i4b9B5b1obep7/xrN26SDGUBg76i3
         tOhCavtqV6DedMuXnSZ+SoiXUbW7he1RBVz4ko/Jdqq4CJYS9xhXJ7ach1ho0E5FU+Ys
         qtQyitYuoRlypQ4BkAtuF7Vu1Bwvqj3Vz3q+J9xRiLEyhzQ17BuB+ctbKrV0wtUdDk36
         vuG4Saiw+FhxpeWrA2JGNWwHV0QFO/MoRI7MOiVjjJaC/mnHcxni6WfiPMOEVeh/WpSX
         mIfw==
X-Gm-Message-State: AOJu0YwF8prFJ3T0BmRfj3iyTkL0eBG8EryZhKXE7dPSrHyqyAcJbfZ6
	VoG2wD+BbFDpelmpUXfem+64eIW1PbbDU+7/ZnA=
X-Google-Smtp-Source: AGHT+IGsYP434fnXPgNzOFsFJhZo72LnE3fLNNOqSgTjY0uH57qOwm9tlqeEIHQTHT8LKophk0dEBHlNKV14F+B5JNs=
X-Received: by 2002:a2e:380a:0:b0:2b6:d13a:8e34 with SMTP id
 f10-20020a2e380a000000b002b6d13a8e34mr9569429lja.46.1692807638746; Wed, 23
 Aug 2023 09:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230821193311.3290257-1-davemarchevsky@fb.com>
 <20230821193311.3290257-4-davemarchevsky@fb.com> <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
In-Reply-To: <01367775-1be4-a344-60d7-6b2b1e48b77e@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 23 Aug 2023 09:20:27 -0700
Message-ID: <CAADnVQK-6A08+OCtOK20yRebBP_N1hKgfmHxtMgokM67LZrcEQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/7] bpf: Use bpf_mem_free_rcu when
 bpf_obj_dropping refcounted nodes
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 22, 2023 at 11:26=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 8/21/23 12:33 PM, Dave Marchevsky wrote:
> > This is the final fix for the use-after-free scenario described in
> > commit 7793fc3babe9 ("bpf: Make bpf_refcount_acquire fallible for
> > non-owning refs"). That commit, by virtue of changing
> > bpf_refcount_acquire's refcount_inc to a refcount_inc_not_zero, fixed
> > the "refcount incr on 0" splat. The not_zero check in
> > refcount_inc_not_zero, though, still occurs on memory that could have
> > been free'd and reused, so the commit didn't properly fix the root
> > cause.
> >
> > This patch actually fixes the issue by free'ing using the recently-adde=
d
> > bpf_mem_free_rcu, which ensures that the memory is not reused until
> > RCU grace period has elapsed. If that has happened then
> > there are no non-owning references alive that point to the
> > recently-free'd memory, so it can be safely reused.
> >
> > Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
> > ---
> >   kernel/bpf/helpers.c | 6 +++++-
> >   1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > index eb91cae0612a..945a85e25ac5 100644
> > --- a/kernel/bpf/helpers.c
> > +++ b/kernel/bpf/helpers.c
> > @@ -1913,7 +1913,11 @@ void __bpf_obj_drop_impl(void *p, const struct b=
tf_record *rec)
> >
> >       if (rec)
> >               bpf_obj_free_fields(rec, p);
>
> During reviewing my percpu kptr patch with link
>
> https://lore.kernel.org/bpf/20230814172809.1361446-1-yonghong.song@linux.=
dev/T/#m2f7631b8047e9f5da60a0a9cd8717fceaf1adbb7
> Kumar mentioned although percpu memory itself is freed under rcu.
> But its record fields are freed immediately. This will cause
> the problem since there may be some active uses of these fields
> within rcu cs and after bpf_obj_free_fields(), some fields may
> be re-initialized with new memory but they do not have chances
> to free any more.
>
> Do we have problem here as well?

I think it's not an issue here or in your percpu patch,
since bpf_obj_free_fields() calls __bpf_obj_drop_impl() which will
call bpf_mem_free_rcu() (after this patch set lands).

In other words all bpf pointers are either properly life time
checked through the verifier and freed via immediate bpf_mem_free()
or they're bpf_mem_free_rcu().


>
> I am thinking whether I could create another flavor of bpf_mem_free_rcu
> with a pre_free_callback function, something like
>    bpf_mem_free_rcu_cb2(struct bpf_mem_alloc *ma, void *ptr,
>        void (*cb)(void *, void *), void *arg1, void *arg2)
>
> The cb(arg1, arg2) will be called right before the real free of "ptr".
>
> For example, for this patch, the callback function can be
>
> static bpf_obj_free_fields_cb(void *rec, void *p)
> {
>         if (rec)
>                 bpf_obj_free_fields(rec, p);
>                 /* we need to ensure recursive freeing fields free
>                  * needs to be done immediately, which means we will
>                  * add a parameter to __bpf_obj_drop_impl() to
>                  * indicate whether bpf_mem_free or bpf_mem_free_rcu
>                  * should be called.
>                  */
> }
>
> bpf_mem_free_rcu_cb2(&bpf_global_ma, p, bpf_obj_free_fields_cb, rec, p);

It sounds nice in theory, but will be difficult to implement.
bpf_ma would need to add extra two 8 byte pointers for every object,
but there is no room at present. So to free after rcu gp with a callback
it would need to allocate 16 byte (at least) which might fail and so on.
bpf_mem_free_rcu_cb2() would be the last resort.

