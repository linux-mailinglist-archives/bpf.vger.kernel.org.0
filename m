Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEF45F2738
	for <lists+bpf@lfdr.de>; Mon,  3 Oct 2022 01:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiJBXg2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 2 Oct 2022 19:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJBXg1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 2 Oct 2022 19:36:27 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E875303CE;
        Sun,  2 Oct 2022 16:36:26 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c11so5591425qtw.8;
        Sun, 02 Oct 2022 16:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PLoYxhA83z3tzclf1TbK2qiAemSmsBSASwT6ikdX+io=;
        b=ZA/fEsgY0DH4DNzrTs74tKFVylpyAp7vGFAlo9UGpQijIE9G18lQsNSTHjZ1w2qTXM
         BYGASP7H7zOGlF0QF2Ei33Bdae5RYuQ3Xp8xJfsKYWGjSvMKR2TvIBGHDxg7LgYAqk+6
         xu3H7PulVpfmwMN5N1fYEzC0E1UoAxgV8XJAp/NrazNvNv3p8PuBbTxiu5nkbx9ZDWdI
         4m21LIwAeldWAdcLoWJACw7AinCaNaB3+LwbkiNmY9RAGKLhmosc4afpNA+Id+M1Ykbf
         jii8sD1jpPO6848wZSHVfI/jvORilgD0P3bKPgRir+akJCqymZhM3mlN2eLTv99PM7bi
         zi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PLoYxhA83z3tzclf1TbK2qiAemSmsBSASwT6ikdX+io=;
        b=dYLg7igsE53+cq2XcnvOEdC7wvDONqjHBDHvVBiQc2PoQoJvfTUToJR36xhxLVKkJf
         DRdUl6akku6ESeXNBG50DqJ0Yaz65Ap5j45Rms84S+EMQTbKWQ6WpG5fw+QGArdmqwAJ
         Hb1UhRydKi122nbFQacEV2TLN3PswpoDJcTepagmcEhS/25HNP5vviiXFq2b1Q0a4CGi
         LC+3i8DiixtwOgzEWjCggtMiorfMHc+xjP6MTp0U/a7vIs/FM6YeeBxkop1bukrJ5PjT
         UZmKgKdlSSzOmpql6be4OG2el33iscV5mlkbS5G1Pr4r4KvKwjlT8i2LjdpQp6fB49H7
         kVcA==
X-Gm-Message-State: ACrzQf0pAZLbw+0tTMatrIzeMlRFN3IMzjtDrEdqxfkkWrz2I2NF+x3p
        RYhRRsFLvvYjIMlyewDKLaUhmWDnPApva6b67JU=
X-Google-Smtp-Source: AMsMyM4omraTr2K4nm74mjpdwVEPm1NJ028D3VIN1bJxwf6z5q6T2oRLlViRFdhp7I9zoxxXPfM747p5Mk5PZVcRCn0=
X-Received: by 2002:a05:622a:1007:b0:35d:1ef4:ed10 with SMTP id
 d7-20020a05622a100700b0035d1ef4ed10mr14022902qte.525.1664753785251; Sun, 02
 Oct 2022 16:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221002171012.3529521-1-void@manifault.com>
In-Reply-To: <20221002171012.3529521-1-void@manifault.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Mon, 3 Oct 2022 01:35:49 +0200
Message-ID: <CAP01T76SFT7TM02RaR9CMtBww34swXZotS2FkGKVBE6+o5XqBw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests/bpf: Update map_kptr examples to reflect
 real use-cases
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, kernel-team@fb.com, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, yhs@fb.com, song@kernel.org,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2 Oct 2022 at 19:10, David Vernet <void@manifault.com> wrote:
>
> In the map_kptr selftest, the bpf_kfunc_call_test_kptr_get() kfunc is used
> to verify and illustrate a typical use case of kptrs wherein an additional
> reference is taken on a referenced kptr that is already stored in a map.
> This would be useful for programs that, for example, want to pass the
> referenced kptr to a kfunc without removing it from the map.
>
> Unfortunately, the implementation of bpf_kfunc_call_test_kptr_get() isn't
> representative of a real kfunc that needs to guard against possible
> refcounting races by BPF program callers. bpf_kfunc_call_test_kptr_get()
> does a READ_ONCE() on the struct prog_test_ref_kfunc **pp passed by the
> user and then calls refcount_inc() if the pointer is nonzero, but this
> can race with another callback in the same program that removes the kptr
> from the map  and frees it:
>
> 1. A BPF program with a referenced kptr in a map passes the kptr to
>    bpf_kfunc_call_test_kptr_get() as:
>
>    p = bpf_kfunc_call_test_kptr_get(&v->ref_ptr, 0, 0);
>
>    from CPU 0.
>
> 2. bpf_kfunc_call_test_kptr_get() does READ_ONCE(), and sees that the
>    struct prog_test_ref_kfunc **pp contains a non-NULL pointer.
>
> 3. Another BPF handler on CPU 1 then invokes bpf_kptr_xchg() to remove
>    the kptr from the map, and frees it with a call to
>    bpf_kfunc_call_test_release(). This drops the final refcount on the
>    kptr.
>
> 4. CPU 0 then issues refcount_inc() on the kptr with refcount 0, causing
>    a use-after-free.
>
> In the map_kptr selftest, this doesn't cause a use-after-free because
> the structure being refcounted is statically allocated, and the
> refcounts aren't actually used to control the object lifecycle. In a
> kfunc supporting a real use case, the refcount going to 0 would likely
> cause the object to be freed, as it does for e.g. struct task_struct.
>
> A more realistic use-case would use something like RCU in the kfunc
> handler to ensure that the kptr object can be safely accessed, and then
> issuing a refcount_inc_not_zero() to acquire a refcount on the object.
> This patch updates the map_kptr selftest to do this.
>
> Signed-off-by: David Vernet <void@manifault.com>
> ---

In my defense, I did note all this in the commit adding support for
kptr_get, so it seemed overkill to do it for a static struct.
But it's probably not a bad idea to have a real example, given it's a
necessity that such a helper requires reclamation of the object
through RCU, and people probably won't go and read the commit message.

However, some questions below...

>  net/bpf/test_run.c                            | 31 ++++++++++++++++---
>  .../selftests/bpf/prog_tests/map_kptr.c       |  4 +--
>  .../testing/selftests/bpf/verifier/map_kptr.c |  4 +--
>  3 files changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
> index 13d578ce2a09..3fe9495abcbe 100644
> --- a/net/bpf/test_run.c
> +++ b/net/bpf/test_run.c
> @@ -565,6 +565,8 @@ struct prog_test_ref_kfunc {
>         int b;
>         struct prog_test_member memb;
>         struct prog_test_ref_kfunc *next;
> +       struct rcu_head rcu;
> +       atomic_t destroyed;
>         refcount_t cnt;
>  };
>
> @@ -572,12 +574,14 @@ static struct prog_test_ref_kfunc prog_test_struct = {
>         .a = 42,
>         .b = 108,
>         .next = &prog_test_struct,
> +       .destroyed = ATOMIC_INIT(0),
>         .cnt = REFCOUNT_INIT(1),
>  };
>
>  noinline struct prog_test_ref_kfunc *
>  bpf_kfunc_call_test_acquire(unsigned long *scalar_ptr)
>  {
> +       WARN_ON_ONCE(atomic_read(&prog_test_struct.destroyed));
>         refcount_inc(&prog_test_struct.cnt);
>         return &prog_test_struct;
>  }
> @@ -589,12 +593,22 @@ bpf_kfunc_call_memb_acquire(void)
>         return NULL;
>  }
>
> +static void delayed_destroy_test_ref_struct(struct rcu_head *rhp)
> +{
> +       struct prog_test_ref_kfunc *p = container_of(rhp, struct prog_test_ref_kfunc, rcu);
> +
> +       WARN_ON_ONCE(refcount_read(&p->cnt) > 0);
> +       atomic_set(&p->destroyed, true);
> +}
> +
>  noinline void bpf_kfunc_call_test_release(struct prog_test_ref_kfunc *p)
>  {
>         if (!p)
>                 return;
>
> -       refcount_dec(&p->cnt);
> +       WARN_ON_ONCE(atomic_read(&p->destroyed));
> +       if (refcount_dec_and_test(&p->cnt))
> +               call_rcu(&p->rcu, delayed_destroy_test_ref_struct);

I wonder whether this is ever called, I haven't really given this
patch a shot, but I don't see how the refcount can ever drop back to
zero. It's initialized as 1, and then only acquired after that, so
pairing all releases should still preserve refcount as 1.

Also, even if you made it work, wouldn't you have the warning once you
run more selftests using prog_test_run, if you just set the  destroyed
bit on each test run?
