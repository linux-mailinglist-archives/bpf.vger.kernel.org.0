Return-Path: <bpf+bounces-11006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56B67B0F89
	for <lists+bpf@lfdr.de>; Thu, 28 Sep 2023 01:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4B58C282158
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 23:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902EA4CFDE;
	Wed, 27 Sep 2023 23:21:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1E1C6B3
	for <bpf@vger.kernel.org>; Wed, 27 Sep 2023 23:20:59 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251AF4;
	Wed, 27 Sep 2023 16:20:57 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9adca291f99so1526335666b.2;
        Wed, 27 Sep 2023 16:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695856856; x=1696461656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmrgC3kiMjmQ6SkAMsL82ZSNHcLV8JzvXRoTFPoIZ0s=;
        b=af6hQN497eFjOAH2zCY3sSZfJcDpODKOsZxce/KVIea5zO5pYF5AGnW+Kn60N/94Gc
         GVBDXzdsX6O/0u+MQE7tRIJOwIZU++aXzsbUdW89NkqqdwBLwqQ+ycXJt/YepDMjUWO3
         9lw3mN2VM/mGU1CizWbQuLOFZlSD+cxostN14wiW2z96zdfk9+1iNmcf1kUHaMicIrhB
         4ZVC9V4B4trwMFG1IwTSDl6P9tiTDA0ntSe5F7FTd2ogejFTQQZlvvLNkxF8OLAgnbYg
         4heit1Z6zdju7Zg3HFLkwsLz61+GO+QG/HMTqXuklSqOQLbVZzQwWsO1mCSi4H2Epbw3
         f9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695856856; x=1696461656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmrgC3kiMjmQ6SkAMsL82ZSNHcLV8JzvXRoTFPoIZ0s=;
        b=BfGPXgT5OR8A0vdOuDYEDekzXUCpOuqEbc2/1VthqgJJKZ4mnaX1jLTOUaPsINRyw8
         WhVXgD8AySGwYYyidi69Vn0TECPV2cLY0CN4r6ViIA6AsIN6DOL7Q7SUteY8DWv+D9nK
         ktnHciRehm93e4RLGpcOJ0zqENKbmBVCpgtwIpLtjRHwZo0dHS4DNzJMhr0T6HnQKTTR
         fVBAKUNDSsNPg9q0Lh2xA3gu+r6ieFMFQwVgoNOvLS8SwNYca7u5MOOUrKpab8vmd/gY
         BiIpWSm2XmtuOXZPGsLdmpNpfA0ym9DAt0GajGmpat0JpcGCTqqLK35G1ef4twpSnhbj
         i5vA==
X-Gm-Message-State: AOJu0YyR/dWiVIP8FywEhG35qmz2RDindp3B+uUUuzbeWCCIV4We5sze
	+VT5CtJViRGqIHqNLEhJQIxVT1v6SX0vuhR5NZw=
X-Google-Smtp-Source: AGHT+IGLhRnMiQxHokAESTwZcv4kyN1BigNUr8uRO6KqYSpCSEFn+TXR43g5ngemi4pFIuVc/VZtq/Ph1X6Iju/3JyI=
X-Received: by 2002:a17:906:847c:b0:9a5:d095:a8e1 with SMTP id
 hx28-20020a170906847c00b009a5d095a8e1mr2621922ejc.11.1695856855470; Wed, 27
 Sep 2023 16:20:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925105552.817513-1-zhouchuyi@bytedance.com> <20230925105552.817513-4-zhouchuyi@bytedance.com>
In-Reply-To: <20230925105552.817513-4-zhouchuyi@bytedance.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Sep 2023 16:20:43 -0700
Message-ID: <CAEf4BzZFBFPMBs6t4GM7GRt-c-Po9KkQqxQ_Zo9vuG=KuqeLzQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/7] bpf: Introduce task open coded iterator kfuncs
To: Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 3:56=E2=80=AFAM Chuyi Zhou <zhouchuyi@bytedance.com=
> wrote:
>
> This patch adds kfuncs bpf_iter_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_task in open-coded iterator
> style. BPF programs can use these kfuncs or through bpf_for_each macro to
> iterate all processes in the system.
>
> The API design keep consistent with SEC("iter/task"). bpf_iter_task_new()
> accepts a specific task and iterating type which allows:
> 1. iterating all process in the system
>
> 2. iterating all threads in the system
>
> 3. iterating all threads of a specific task
> Here we also resuse enum bpf_iter_task_type and rename BPF_TASK_ITER_TID
> to BPF_TASK_ITER_THREAD, rename BPF_TASK_ITER_TGID to BPF_TASK_ITER_PROC.
>
> The newly-added struct bpf_iter_task has a name collision with a selftest
> for the seq_file task iter's bpf skel, so the selftests/bpf/progs file is
> renamed in order to avoid the collision.
>
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> ---
>  include/linux/bpf.h                           |  8 +-
>  kernel/bpf/helpers.c                          |  3 +
>  kernel/bpf/task_iter.c                        | 96 ++++++++++++++++---
>  .../testing/selftests/bpf/bpf_experimental.h  |  5 +
>  .../selftests/bpf/prog_tests/bpf_iter.c       | 18 ++--
>  .../{bpf_iter_task.c =3D> bpf_iter_tasks.c}     |  0
>  6 files changed, 106 insertions(+), 24 deletions(-)
>  rename tools/testing/selftests/bpf/progs/{bpf_iter_task.c =3D> bpf_iter_=
tasks.c} (100%)
>

[...]

> @@ -692,9 +692,9 @@ static int bpf_iter_fill_link_info(const struct bpf_i=
ter_aux_info *aux, struct b
>  static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *au=
x, struct seq_file *seq)
>  {
>         seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->tas=
k.type]);
> -       if (aux->task.type =3D=3D BPF_TASK_ITER_TID)
> +       if (aux->task.type =3D=3D BPF_TASK_ITER_THREAD)
>                 seq_printf(seq, "tid:\t%u\n", aux->task.pid);
> -       else if (aux->task.type =3D=3D BPF_TASK_ITER_TGID)
> +       else if (aux->task.type =3D=3D BPF_TASK_ITER_PROC)
>                 seq_printf(seq, "pid:\t%u\n", aux->task.pid);
>  }
>
> @@ -856,6 +856,80 @@ __bpf_kfunc void bpf_iter_css_task_destroy(struct bp=
f_iter_css_task *it)
>         bpf_mem_free(&bpf_global_ma, kit->css_it);
>  }
>
> +struct bpf_iter_task {
> +       __u64 __opaque[2];
> +       __u32 __opaque_int[1];

this should be __u64 __opaque[3], because struct takes full 24 bytes

> +} __attribute__((aligned(8)));
> +
> +struct bpf_iter_task_kern {
> +       struct task_struct *task;
> +       struct task_struct *pos;
> +       unsigned int type;
> +} __attribute__((aligned(8)));
> +
> +__bpf_kfunc int bpf_iter_task_new(struct bpf_iter_task *it, struct task_=
struct *task, unsigned int type)

nit: type -> flags, so we can add a bit more stuff, if necessary

> +{
> +       struct bpf_iter_task_kern *kit =3D (void *)it;

empty line after variable declarations

> +       BUILD_BUG_ON(sizeof(struct bpf_iter_task_kern) !=3D sizeof(struct=
 bpf_iter_task));
> +       BUILD_BUG_ON(__alignof__(struct bpf_iter_task_kern) !=3D
> +                                       __alignof__(struct bpf_iter_task)=
);

and I'd add empty line here to keep BUILD_BUG_ON block separate

> +       kit->task =3D kit->pos =3D NULL;
> +       switch (type) {
> +       case BPF_TASK_ITER_ALL:
> +       case BPF_TASK_ITER_PROC:
> +       case BPF_TASK_ITER_THREAD:
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       if (type =3D=3D BPF_TASK_ITER_THREAD)
> +               kit->task =3D task;
> +       else
> +               kit->task =3D &init_task;
> +       kit->pos =3D kit->task;
> +       kit->type =3D type;
> +       return 0;
> +}
> +
> +__bpf_kfunc struct task_struct *bpf_iter_task_next(struct bpf_iter_task =
*it)
> +{
> +       struct bpf_iter_task_kern *kit =3D (void *)it;
> +       struct task_struct *pos;
> +       unsigned int type;
> +
> +       type =3D kit->type;
> +       pos =3D kit->pos;
> +
> +       if (!pos)
> +               goto out;
> +
> +       if (type =3D=3D BPF_TASK_ITER_PROC)
> +               goto get_next_task;
> +
> +       kit->pos =3D next_thread(kit->pos);
> +       if (kit->pos =3D=3D kit->task) {
> +               if (type =3D=3D BPF_TASK_ITER_THREAD) {
> +                       kit->pos =3D NULL;
> +                       goto out;
> +               }
> +       } else
> +               goto out;
> +
> +get_next_task:
> +       kit->pos =3D next_task(kit->pos);
> +       kit->task =3D kit->pos;
> +       if (kit->pos =3D=3D &init_task)
> +               kit->pos =3D NULL;

I can't say I completely follow the logic (e.g., for
BPF_TASK_ITER_PROC, why do we do next_task() on first next() call)?
Can you elabore the expected behavior for various combinations of
types and starting task argument?

> +
> +out:
> +       return pos;
> +}
> +
> +__bpf_kfunc void bpf_iter_task_destroy(struct bpf_iter_task *it)
> +{
> +}
> +
>  DEFINE_PER_CPU(struct mmap_unlock_irq_work, mmap_unlock_work);
>
>  static void do_mmap_read_unlock(struct irq_work *entry)
> diff --git a/tools/testing/selftests/bpf/bpf_experimental.h b/tools/testi=
ng/selftests/bpf/bpf_experimental.h
> index d3ea90f0e142..d989775dbdb5 100644
> --- a/tools/testing/selftests/bpf/bpf_experimental.h
> +++ b/tools/testing/selftests/bpf/bpf_experimental.h
> @@ -169,4 +169,9 @@ extern int bpf_iter_css_task_new(struct bpf_iter_css_=
task *it,
>  extern struct task_struct *bpf_iter_css_task_next(struct bpf_iter_css_ta=
sk *it) __weak __ksym;
>  extern void bpf_iter_css_task_destroy(struct bpf_iter_css_task *it) __we=
ak __ksym;
>
> +struct bpf_iter_task;
> +extern int bpf_iter_task_new(struct bpf_iter_task *it, struct task_struc=
t *task, unsigned int type) __weak __ksym;
> +extern struct task_struct *bpf_iter_task_next(struct bpf_iter_task *it) =
__weak __ksym;
> +extern void bpf_iter_task_destroy(struct bpf_iter_task *it) __weak __ksy=
m;
> +
>  #endif
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c

please split out selftests changes from kernel-side changes. We only
combine them if kernel changes break selftests, preventing bisection.

[...]

