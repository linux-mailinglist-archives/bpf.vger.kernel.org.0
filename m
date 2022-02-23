Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C901A4C1DEC
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241267AbiBWVrj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 16:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbiBWVrh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 16:47:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AFA47068
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 13:47:08 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id y5so195499ill.13
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 13:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zeAe1YWkrG5sY9V7Oz+vaaqIlWn8szkRcfgG1CiLftI=;
        b=TzrLRv/FVyCN9hGpcAG5LMFgaaP6aGS/bkXv1oeqH1UBARFfs9tZp5xE6EXEe2xB6o
         YfDkuVzLJ5WUAtkijZsSBE3Y5SHe68dgDJc/mZMt0gpp8k7EWucTLjOVbQB9blWK5fU+
         H/tNsp/Fj2t+1L3Iabo+FALr4BCsRFACrvdOgdKsHCzge1XoT/Ij5fxSu4aylTOTCWo3
         3GMHJyCTAO7CJWRecQHDfJOr7YW0wt3TSd9m/eaUwJjGCbZ3MwBPxvQ0qoEGKygyZAO6
         TxmbFz722vI7dfSaz/o23iURUvQRtglQlgVW8w0MR3haNlCRWeV7JHe/vagqeKGSGQp6
         e6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zeAe1YWkrG5sY9V7Oz+vaaqIlWn8szkRcfgG1CiLftI=;
        b=jYohjar+gx9X746obu8Q1m5ZzstFlwlB82qmccSxS8oHbMsG9uBmu/xnaO0eAMhBPG
         RZrX7P13EV+2h5VVxjnjxcIvKFnY+Cpmvwwv4vvKKJOjEbMPY1GIrFZWLdBX2QPHUGuQ
         VkwCfJsC2zPZPwadqyg/DTYHKAakoiLdwgVTCLYUGLsYJwzVKoG3qWah+CuGQvjO8P1B
         lZkgMHZE5AfyaCN6yjXakgL1f4N76TSFjGNd43NfHRgkTvp+547DJGxzKqkcum+PTXNL
         gjNjAiICBDFd3siR2q5+pSQ2gdsXoziqrRFA/QQP9NAYQg8mDlp9tnSUrNoR0H2Ufuhj
         DP7w==
X-Gm-Message-State: AOAM530BdI8sTMWuvJFKx5xpJhr7kOwmW1rJzVr0J04Gwy9wjpEYXwtL
        UOEkDj6eqX/ARi8biUMYbYl5X7k4Y7Xz90zaHTUieirw1+g=
X-Google-Smtp-Source: ABdhPJzShYQ4h46a87h5uKKkj3fT1sj5ot3177JLfKwiy11XuofXRa/ZmEUFuGBJhb7ix6z1lZk2pDlGsItFAWGLZvM=
X-Received: by 2002:a05:6e02:1a88:b0:2be:a472:90d9 with SMTP id
 k8-20020a056e021a8800b002bea47290d9mr1374915ilv.239.1645652827834; Wed, 23
 Feb 2022 13:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20220218075103.10002-1-9erthalion6@gmail.com>
In-Reply-To: <20220218075103.10002-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 23 Feb 2022 13:46:56 -0800
Message-ID: <CAEf4BzaD4FJw9_45v0-N5MbSKMCDcENQPzUDwo1FWoX-5ixzsg@mail.gmail.com>
Subject: Re: [RFC PATCH v3] bpftool: Add bpf_cookie to link output
To:     Dmitrii Dolgov <9erthalion6@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 17, 2022 at 11:51 PM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
>
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
>
> Implemented using the pid iterator BPF program to actually fetch
> bpf_cookies, which allows constraining code changes only to bpftool.
>
> $ bpftool link
> 1: type 7  prog 5
>         bpf_cookie 123
>         pids bootstrap(81)
>
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> ---
> Changes in v3:
>     - Use pid iterator to fetch bpf_cookie
>
> Changes in v2:
>     - Display bpf_cookie in bpftool link command instead perf
>
> Previous discussion: https://lore.kernel.org/bpf/20220204181146.8429-1-9erthalion6@gmail.com/
>
>  tools/bpf/bpftool/main.h                  |  2 ++
>  tools/bpf/bpftool/pids.c                  | 15 +++++++++++++--
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 16 ++++++++++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.h     |  1 +
>  4 files changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0c3840596b5a..c0042bd56139 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -114,6 +114,8 @@ struct obj_ref {
>  struct obj_refs {
>         int ref_cnt;
>         struct obj_ref *refs;
> +       enum bpf_obj_type type;
> +       __u64 bpf_cookie;
>  };
>
>  struct btf;
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 7c384d10e95f..d4db4049d94b 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -28,7 +28,8 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id, json_writer_t *json_write
>
>  #include "pid_iter.skel.h"
>
> -static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
> +static void add_ref(struct hashmap *map, struct pid_iter_entry *e,
> +                               enum bpf_obj_type type)
>  {
>         struct hashmap_entry *entry;
>         struct obj_refs *refs;
> @@ -55,6 +56,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>                 ref->pid = e->pid;
>                 memcpy(ref->comm, e->comm, sizeof(ref->comm));
>                 refs->ref_cnt++;
> +               refs->type = type;
> +               refs->bpf_cookie = e->bpf_cookie;
>
>                 return;
>         }
> @@ -78,6 +81,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>         ref->pid = e->pid;
>         memcpy(ref->comm, e->comm, sizeof(ref->comm));
>         refs->ref_cnt = 1;
> +       refs->type = type;
> +       refs->bpf_cookie = e->bpf_cookie;
>
>         err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>         if (err)
> @@ -161,7 +166,7 @@ int build_obj_refs_table(struct hashmap **map, enum bpf_obj_type type)
>
>                 e = (void *)buf;
>                 for (i = 0; i < ret; i++, e++) {
> -                       add_ref(*map, e);
> +                       add_ref(*map, e, type);
>                 }
>         }
>         err = 0;
> @@ -205,6 +210,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>                 if (refs->ref_cnt == 0)
>                         break;
>
> +               if (refs->type == BPF_OBJ_LINK)
> +                       jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
> +
>                 jsonw_name(json_writer, "pids");
>                 jsonw_start_array(json_writer);
>                 for (i = 0; i < refs->ref_cnt; i++) {
> @@ -234,6 +242,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
>                 if (refs->ref_cnt == 0)
>                         break;
>
> +               if (refs->type == BPF_OBJ_LINK)
> +                       printf("\n\tbpf_cookie %llu", refs->bpf_cookie);
> +
>                 printf("%s", prefix);
>                 for (i = 0; i < refs->ref_cnt; i++) {
>                         struct obj_ref *ref = &refs->refs[i];
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index f70702fcb224..afdfdfbf305d 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -38,6 +38,17 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
>         }
>  }
>
> +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
> +{
> +       struct bpf_perf_link *perf_link;
> +       struct perf_event *event;
> +
> +       perf_link = container_of(link, struct bpf_perf_link, link);
> +       event = BPF_CORE_READ(perf_link, perf_file, private_data);
> +       return BPF_CORE_READ(event, bpf_cookie);

not every bpf_link is bpf_perf_link, you can't do it for every
instance of bpf_link.

> +}
> +
> +
>  SEC("iter/task_file")
>  int iter(struct bpf_iter__task_file *ctx)
>  {
> @@ -71,6 +82,11 @@ int iter(struct bpf_iter__task_file *ctx)
>
>         e.pid = task->tgid;
>         e.id = get_obj_id(file->private_data, obj_type);
> +       e.bpf_cookie = 0;
> +
> +       if (obj_type == BPF_OBJ_LINK)
> +               e.bpf_cookie = get_bpf_cookie((struct bpf_link *) file->private_data);
> +
>         bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
>                                   task->group_leader->comm);
>         bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
> index 5692cf257adb..a631640f6fe4 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.h
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.h
> @@ -7,6 +7,7 @@ struct pid_iter_entry {
>         __u32 id;
>         int pid;
>         char comm[16];
> +       __u64 bpf_cookie;
>  };
>
>  #endif
> --
> 2.32.0
>
