Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C446CB521
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 05:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjC1Dv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 23:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjC1Dv1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 23:51:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD1FDE
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:51:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q27so7286291oiw.0
        for <bpf@vger.kernel.org>; Mon, 27 Mar 2023 20:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679975484; x=1682567484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KP4aDBVaEurwa7zB1mnYWNVHY7VQcr+WbJQXh8HfTXg=;
        b=eRc9EeOxSxdQoToUZRHLYzp59dSb0zLytEUHQQF9TmeEhumhNeCNSTdzRxb7lvojGw
         jRF4iPD7PQDcxweDlNVEDnom+EtvBpuKG/oHZrWotwp3PTTQLHXIN+c3m6Z8FNnMOKB5
         Vmq5MP1s0x7pIplZPADZtljvnPK9Q4ddqgQnSQSkh0GdBxNvSeHxrwBQdlduoSd/99DX
         D8Rx6pLvhzHap80XbHmdBBOdAITVoSZ6vMBiXR3QDHFIiCV6q71GBcRU4Bjl9EArAq80
         iyhnPmpFHhKRjQOQYLDymTVs+Eroq0hTf7737DNWPF3pz6Holgvd2Ya2S7gIGGum2uR1
         Z+rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679975484; x=1682567484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KP4aDBVaEurwa7zB1mnYWNVHY7VQcr+WbJQXh8HfTXg=;
        b=iz/VGPSt2hxO8PL9/7wJlMLJ/OSAF/ICprza9m6LgIaxqS3xZ4RkQFy85D7N4o6JmR
         1XSbiaX0vc+/7tQtW51q8P0FWRL9bXS5Vvm2aTtnDdQmDCJC29x8p2M1d/VU9hmZU+3G
         z1dKY3RC2BM4ADPTNvfZe1RpKvhUIi9XCp2QEArvbJAjluNnW1rQJB3bnlE1nB+9wulF
         gEdFwEy2jmFgxvxMB58eSddwVQEI9RHHIXaXcKpeJcWekXTtEBuxwV2EXaHcGLrRn64J
         8vkjLS5gfiTHgAXasABP/W3FtJaoX95AKf/QQSh4xA5ywW0c/DdTXJ0V8U1hxuv/QLHB
         HTFA==
X-Gm-Message-State: AAQBX9dP1x5mTLAgwSTJAfK39FC6kc302Clawj+H2ocH5/blMI+LVxxl
        zkaFV1wFA3OftP4GlMuKI5CK/he5uScekB93m8I=
X-Google-Smtp-Source: AKy350afjskApT40qEyTRF/b7ECNRFUER+rJ5qRqRbRzgrjKjtybAQvGuwThj08MAhhhXfgmpnLJEqJMQCUlirasS4o=
X-Received: by 2002:a54:450a:0:b0:389:53dc:cdf2 with SMTP id
 l10-20020a54450a000000b0038953dccdf2mr203238oil.4.1679975484498; Mon, 27 Mar
 2023 20:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230322215246.1675516-1-martin.lau@linux.dev> <20230322215246.1675516-6-martin.lau@linux.dev>
In-Reply-To: <20230322215246.1675516-6-martin.lau@linux.dev>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 27 Mar 2023 21:51:13 -0600
Message-ID: <CADvTj4rP3kPODxARVTEs2HsNFOof-BZtr8OsEKdjgcGVOTqKaA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/5] selftests/bpf: Add bench for task storage creation
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@meta.com,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        David Faust <david.faust@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 27, 2023 at 9:42=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> From: Martin KaFai Lau <martin.lau@kernel.org>
>
> This patch adds a task storage benchmark to the existing
> local-storage-create benchmark.
>
> For task storage,
> ./bench --storage-type task --batch-size 32:
>    bpf_ma: Summary: creates   30.456 =C2=B1 0.507k/s ( 30.456k/prod), 6.0=
8 kmallocs/create
> no bpf_ma: Summary: creates   31.962 =C2=B1 0.486k/s ( 31.962k/prod), 6.1=
3 kmallocs/create
>
> ./bench --storage-type task --batch-size 64:
>    bpf_ma: Summary: creates   30.197 =C2=B1 1.476k/s ( 30.197k/prod), 6.0=
8 kmallocs/create
> no bpf_ma: Summary: creates   31.103 =C2=B1 0.297k/s ( 31.103k/prod), 6.1=
3 kmallocs/create
>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---
>  tools/testing/selftests/bpf/bench.c           |   2 +
>  .../bpf/benchs/bench_local_storage_create.c   | 151 ++++++++++++++++--
>  .../bpf/progs/bench_local_storage_create.c    |  25 +++
>  3 files changed, 164 insertions(+), 14 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftest=
s/bpf/bench.c
> index dc3827c1f139..d9c080ac1796 100644
> --- a/tools/testing/selftests/bpf/bench.c
> +++ b/tools/testing/selftests/bpf/bench.c
> @@ -278,6 +278,7 @@ extern struct argp bench_local_storage_argp;
>  extern struct argp bench_local_storage_rcu_tasks_trace_argp;
>  extern struct argp bench_strncmp_argp;
>  extern struct argp bench_hashmap_lookup_argp;
> +extern struct argp bench_local_storage_create_argp;
>
>  static const struct argp_child bench_parsers[] =3D {
>         { &bench_ringbufs_argp, 0, "Ring buffers benchmark", 0 },
> @@ -288,6 +289,7 @@ static const struct argp_child bench_parsers[] =3D {
>         { &bench_local_storage_rcu_tasks_trace_argp, 0,
>                 "local_storage RCU Tasks Trace slowdown benchmark", 0 },
>         { &bench_hashmap_lookup_argp, 0, "Hashmap lookup benchmark", 0 },
> +       { &bench_local_storage_create_argp, 0, "local-storage-create benc=
hmark", 0 },
>         {},
>  };
>
> diff --git a/tools/testing/selftests/bpf/benchs/bench_local_storage_creat=
e.c b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
> index f8b2a640ccbe..abb0321d4f34 100644
> --- a/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
> +++ b/tools/testing/selftests/bpf/benchs/bench_local_storage_create.c
> @@ -3,19 +3,71 @@
>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <pthread.h>
> +#include <argp.h>
>
>  #include "bench.h"
>  #include "bench_local_storage_create.skel.h"
>
> -#define BATCH_SZ 32
> -
>  struct thread {
> -       int fds[BATCH_SZ];
> +       int *fds;
> +       pthread_t *pthds;
> +       int *pthd_results;
>  };
>
>  static struct bench_local_storage_create *skel;
>  static struct thread *threads;
> -static long socket_errs;
> +static long create_owner_errs;
> +static int storage_type =3D BPF_MAP_TYPE_SK_STORAGE;
> +static int batch_sz =3D 32;
> +
> +enum {
> +       ARG_BATCH_SZ =3D 9000,
> +       ARG_STORAGE_TYPE =3D 9001,
> +};
> +
> +static const struct argp_option opts[] =3D {
> +       { "batch-size", ARG_BATCH_SZ, "BATCH_SIZE", 0,
> +         "The number of storage creations in each batch" },
> +       { "storage-type", ARG_STORAGE_TYPE, "STORAGE_TYPE", 0,
> +         "The type of local storage to test (socket or task)" },
> +       {},
> +};
> +
> +static error_t parse_arg(int key, char *arg, struct argp_state *state)
> +{
> +       int ret;
> +
> +       switch (key) {
> +       case ARG_BATCH_SZ:
> +               ret =3D atoi(arg);
> +               if (ret < 1) {
> +                       fprintf(stderr, "invalid batch-size\n");
> +                       argp_usage(state);
> +               }
> +               batch_sz =3D ret;
> +               break;
> +       case ARG_STORAGE_TYPE:
> +               if (!strcmp(arg, "task")) {
> +                       storage_type =3D BPF_MAP_TYPE_TASK_STORAGE;
> +               } else if (!strcmp(arg, "socket")) {
> +                       storage_type =3D BPF_MAP_TYPE_SK_STORAGE;
> +               } else {
> +                       fprintf(stderr, "invalid storage-type (socket or =
task)\n");
> +                       argp_usage(state);
> +               }
> +               break;
> +       default:
> +               return ARGP_ERR_UNKNOWN;
> +       }
> +
> +       return 0;
> +}
> +
> +const struct argp bench_local_storage_create_argp =3D {
> +       .options =3D opts,
> +       .parser =3D parse_arg,
> +};
>
>  static void validate(void)
>  {
> @@ -28,6 +80,8 @@ static void validate(void)
>
>  static void setup(void)
>  {
> +       int i;
> +
>         skel =3D bench_local_storage_create__open_and_load();
>         if (!skel) {
>                 fprintf(stderr, "error loading skel\n");
> @@ -35,10 +89,16 @@ static void setup(void)
>         }
>
>         skel->bss->bench_pid =3D getpid();
> -
> -       if (!bpf_program__attach(skel->progs.socket_post_create)) {
> -               fprintf(stderr, "Error attaching bpf program\n");
> -               exit(1);
> +       if (storage_type =3D=3D BPF_MAP_TYPE_SK_STORAGE) {
> +               if (!bpf_program__attach(skel->progs.socket_post_create))=
 {
> +                       fprintf(stderr, "Error attaching bpf program\n");
> +                       exit(1);
> +               }
> +       } else {
> +               if (!bpf_program__attach(skel->progs.fork)) {
> +                       fprintf(stderr, "Error attaching bpf program\n");
> +                       exit(1);
> +               }
>         }
>
>         if (!bpf_program__attach(skel->progs.kmalloc)) {
> @@ -52,6 +112,29 @@ static void setup(void)
>                 fprintf(stderr, "cannot alloc thread_res\n");
>                 exit(1);
>         }
> +
> +       for (i =3D 0; i < env.producer_cnt; i++) {
> +               struct thread *t =3D &threads[i];
> +
> +               if (storage_type =3D=3D BPF_MAP_TYPE_SK_STORAGE) {
> +                       t->fds =3D malloc(batch_sz * sizeof(*t->fds));
> +                       if (!t->fds) {
> +                               fprintf(stderr, "cannot alloc t->fds\n");
> +                               exit(1);
> +                       }
> +               } else {
> +                       t->pthds =3D malloc(batch_sz * sizeof(*t->pthds))=
;
> +                       if (!t->pthds) {
> +                               fprintf(stderr, "cannot alloc t->pthds\n"=
);
> +                               exit(1);
> +                       }
> +                       t->pthd_results =3D malloc(batch_sz * sizeof(*t->=
pthd_results));
> +                       if (!t->pthd_results) {
> +                               fprintf(stderr, "cannot alloc t->pthd_res=
ults\n");
> +                               exit(1);
> +                       }
> +               }
> +       }
>  }
>
>  static void measure(struct bench_res *res)
> @@ -65,20 +148,20 @@ static void *consumer(void *input)
>         return NULL;
>  }
>
> -static void *producer(void *input)
> +static void *sk_producer(void *input)
>  {
>         struct thread *t =3D &threads[(long)(input)];
>         int *fds =3D t->fds;
>         int i;
>
>         while (true) {
> -               for (i =3D 0; i < BATCH_SZ; i++) {
> +               for (i =3D 0; i < batch_sz; i++) {
>                         fds[i] =3D socket(AF_INET6, SOCK_DGRAM, 0);
>                         if (fds[i] =3D=3D -1)
> -                               atomic_inc(&socket_errs);
> +                               atomic_inc(&create_owner_errs);
>                 }
>
> -               for (i =3D 0; i < BATCH_SZ; i++) {
> +               for (i =3D 0; i < batch_sz; i++) {
>                         if (fds[i] !=3D -1)
>                                 close(fds[i]);
>                 }
> @@ -87,6 +170,42 @@ static void *producer(void *input)
>         return NULL;
>  }
>
> +static void *thread_func(void *arg)
> +{
> +       return NULL;
> +}
> +
> +static void *task_producer(void *input)
> +{
> +       struct thread *t =3D &threads[(long)(input)];
> +       pthread_t *pthds =3D t->pthds;
> +       int *pthd_results =3D t->pthd_results;
> +       int i;
> +
> +       while (true) {
> +               for (i =3D 0; i < batch_sz; i++) {
> +                       pthd_results[i] =3D pthread_create(&pthds[i], NUL=
L, thread_func, NULL);
> +                       if (pthd_results[i])
> +                               atomic_inc(&create_owner_errs);
> +               }
> +
> +               for (i =3D 0; i < batch_sz; i++) {
> +                       if (!pthd_results[i])
> +                               pthread_join(pthds[i], NULL);;
> +               }
> +       }
> +
> +       return NULL;
> +}
> +
> +static void *producer(void *input)
> +{
> +       if (storage_type =3D=3D BPF_MAP_TYPE_SK_STORAGE)
> +               return sk_producer(input);
> +       else
> +               return task_producer(input);
> +}
> +
>  static void report_progress(int iter, struct bench_res *res, long delta_=
ns)
>  {
>         double creates_per_sec, kmallocs_per_create;
> @@ -123,14 +242,18 @@ static void report_final(struct bench_res res[], in=
t res_cnt)
>         printf("Summary: creates %8.3lf \u00B1 %5.3lfk/s (%7.3lfk/prod), =
",
>                creates_mean, creates_stddev, creates_mean / env.producer_=
cnt);
>         printf("%4.2lf kmallocs/create\n", (double)total_kmallocs / total=
_creates);
> -       if (socket_errs || skel->bss->create_errs)
> -               printf("socket() errors %ld create_errs %ld\n", socket_er=
rs,
> +       if (create_owner_errs || skel->bss->create_errs)
> +               printf("%s() errors %ld create_errs %ld\n",
> +                      storage_type =3D=3D BPF_MAP_TYPE_SK_STORAGE ?
> +                      "socket" : "pthread_create",
> +                      create_owner_errs,
>                        skel->bss->create_errs);
>  }
>
>  /* Benchmark performance of creating bpf local storage  */
>  const struct bench bench_local_storage_create =3D {
>         .name =3D "local-storage-create",
> +       .argp =3D &bench_local_storage_create_argp,
>         .validate =3D validate,
>         .setup =3D setup,
>         .producer_thread =3D producer,
> diff --git a/tools/testing/selftests/bpf/progs/bench_local_storage_create=
.c b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> index 2814bab54d28..7c851c9d5e47 100644
> --- a/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> +++ b/tools/testing/selftests/bpf/progs/bench_local_storage_create.c
> @@ -22,6 +22,13 @@ struct {
>         __type(value, struct storage);
>  } sk_storage_map SEC(".maps");
>
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, struct storage);
> +} task_storage_map SEC(".maps");
> +
>  SEC("raw_tp/kmalloc")
>  int BPF_PROG(kmalloc, unsigned long call_site, const void *ptr,
>              size_t bytes_req, size_t bytes_alloc, gfp_t gfp_flags,
> @@ -32,6 +39,24 @@ int BPF_PROG(kmalloc, unsigned long call_site, const v=
oid *ptr,
>         return 0;
>  }
>
> +SEC("tp_btf/sched_process_fork")
> +int BPF_PROG(fork, struct task_struct *parent, struct task_struct *child=
)

Apparently fork is a built-in function in bpf-gcc:

In file included from progs/bench_local_storage_create.c:6:
progs/bench_local_storage_create.c:43:14: error: conflicting types for
built-in function 'fork'; expected 'int(void)'
[-Werror=3Dbuiltin-declaration-mismatch]
   43 | int BPF_PROG(fork, struct task_struct *parent, struct
task_struct *child)
      |              ^~~~

I haven't been able to find this documented anywhere however.

> +{
> +       struct storage *stg;
> +
> +       if (parent->tgid !=3D bench_pid)
> +               return 0;
> +
> +       stg =3D bpf_task_storage_get(&task_storage_map, child, NULL,
> +                                  BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       if (stg)
> +               __sync_fetch_and_add(&create_cnts, 1);
> +       else
> +               __sync_fetch_and_add(&create_errs, 1);
> +
> +       return 0;
> +}
> +
>  SEC("lsm.s/socket_post_create")
>  int BPF_PROG(socket_post_create, struct socket *sock, int family, int ty=
pe,
>              int protocol, int kern)
> --
> 2.34.1
>
>
