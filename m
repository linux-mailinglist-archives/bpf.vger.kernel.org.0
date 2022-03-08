Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDD454D0D9D
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 02:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbiCHBmg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Mar 2022 20:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234625AbiCHBmg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Mar 2022 20:42:36 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A813968B
        for <bpf@vger.kernel.org>; Mon,  7 Mar 2022 17:41:36 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c23so19357269ioi.4
        for <bpf@vger.kernel.org>; Mon, 07 Mar 2022 17:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EG54DKSzq6Jf2jDUykHYPBLic80C3YQKSrmYYm3Oi4k=;
        b=F8zUUJbIaMDq44rDVRlN6f1UPuVJeELr0re2sd4bhNr6PLEM0VMvJ8ZXhsL+pxiI/Z
         76S5J2+k6cbzOwDIc8QbhJj8hK6EaFG/ilnlZzzhFRor0t6pm4lscyMo22u9nyb6lX5M
         R6n87ul0f+EbOoHZD4UVLj6LnCrKxaP2oWN3IFAfBAgFsz4L8tlln32rUnqCo7jrsP8n
         EVsNgyk9pewN1pzdvLhNO9psk95V9901pZRU2uw+2S0NsSnuJFtQWRhKPM7Hmu+9LNt6
         FVcjZMYfAK+36tQbvIILN2aUwUvLGYWuA6BavVtQQssiZf57jysI5ymeVZZ431lGS9b+
         JPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EG54DKSzq6Jf2jDUykHYPBLic80C3YQKSrmYYm3Oi4k=;
        b=digqYi9kqLfam0uCNKaVqxNjm1x/+nRVynzENxu0lPrffYZuLKrAtUdbmzr31CmXbL
         1z8stcFRt/OvQZrzoGjnanhczy9yPQSdCwrpx2ulbmUJSNS5tv1qo+7uEfYSjjualp5I
         FyH+Um8Y5q2v+LaHIxABhAfRUDHwVEOrWfas8JPzkXMlimwao0oOT/AjGaC5ZqBQJWlg
         xO4JRJs8BydSFzoG+q4WYox1GFYgIPDzG155LHLmObVBOOa8g/TdWLE1zefUU8xs13Z0
         w4w5C4Dh6tHx3qeEgGdGgFvEsYPSX6aIi8HqmJONichGpT1UB22L1r+CodnzseBQcO3o
         sMiw==
X-Gm-Message-State: AOAM531qjqVlFAGIvZTG4K4q4e9qqnuzmlKDA58zTVlIBKWvp7PBJLQe
        Z5vBocg2YCy9Thn2dsHSwtaGQea5WgqIlG5kJRfGRvPpCU0=
X-Google-Smtp-Source: ABdhPJyfsRHJ8PJS38XxdZHiiVE/aIlfnPLBNqMxYW1Ds4n4IhU6WUWznNKUapbTBIICzo6bTNtSGLGJdcbpvozkp+M=
X-Received: by 2002:a6b:8bd7:0:b0:646:2804:5c73 with SMTP id
 n206-20020a6b8bd7000000b0064628045c73mr189462iod.112.1646703695759; Mon, 07
 Mar 2022 17:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20220304143610.10796-1-9erthalion6@gmail.com>
In-Reply-To: <20220304143610.10796-1-9erthalion6@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 7 Mar 2022 17:41:24 -0800
Message-ID: <CAEf4BzbmU-94rTp2zhfp8W6u-Tjcdsk45653UyrQ5bNKFc7jLw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
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

On Fri, Mar 4, 2022 at 6:36 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
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
> Changes in v5:
>     - Remove unneeded cookie assigns
>
> Changes in v4:
>     - Fetch cookies only for bpf_perf_link
>     - Signal about bpf_cookie via the flag, instead of deducing it from
>       the object and link type
>     - Reset pid_iter_entry to avoid invalid indirect read from stack
>
> Changes in v3:
>     - Use pid iterator to fetch bpf_cookie
>
> Changes in v2:
>     - Display bpf_cookie in bpftool link command instead perf
>
> Previous discussion: https://lore.kernel.org/bpf/20220225152802.20957-1-9erthalion6@gmail.com/
>
>
>  tools/bpf/bpftool/main.h                  |  2 ++
>  tools/bpf/bpftool/pids.c                  |  8 ++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 25 +++++++++++++++++++++++
>  tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
>  4 files changed, 37 insertions(+)
>
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0c3840596b5a..1bb76aa1f3b2 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -114,6 +114,8 @@ struct obj_ref {
>  struct obj_refs {
>         int ref_cnt;
>         struct obj_ref *refs;
> +       bool bpf_cookie_set;
> +       __u64 bpf_cookie;
>  };
>
>  struct btf;
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 7c384d10e95f..6c6e7c90cc3d 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>         ref->pid = e->pid;
>         memcpy(ref->comm, e->comm, sizeof(ref->comm));
>         refs->ref_cnt = 1;
> +       refs->bpf_cookie_set = e->bpf_cookie_set;
> +       refs->bpf_cookie = e->bpf_cookie;
>
>         err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>         if (err)
> @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>                 if (refs->ref_cnt == 0)
>                         break;
>
> +               if (refs->bpf_cookie_set)
> +                       jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);
> +
>                 jsonw_name(json_writer, "pids");
>                 jsonw_start_array(json_writer);
>                 for (i = 0; i < refs->ref_cnt; i++) {
> @@ -234,6 +239,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
>                 if (refs->ref_cnt == 0)
>                         break;
>
> +               if (refs->bpf_cookie_set)
> +                       printf("\n\tbpf_cookie %llu", refs->bpf_cookie);

__u64 is not always %llu on all architectures. Best to cast it to
(unsigned long long) here to avoid compilation warnings.

> +
>                 printf("%s", prefix);
>                 for (i = 0; i < refs->ref_cnt; i++) {
>                         struct obj_ref *ref = &refs->refs[i];
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index f70702fcb224..91366ce33717 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
>         }
>  }
>
> +/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)

no need for __always_inline

> +{
> +       struct bpf_perf_link *perf_link;
> +       struct perf_event *event;
> +
> +       perf_link = container_of(link, struct bpf_perf_link, link);
> +       event = BPF_CORE_READ(perf_link, perf_file, private_data);
> +       return BPF_CORE_READ(event, bpf_cookie);
> +}
> +
> +

nit: why double empty line?


>  SEC("iter/task_file")
>  int iter(struct bpf_iter__task_file *ctx)
>  {
> @@ -69,8 +81,21 @@ int iter(struct bpf_iter__task_file *ctx)
>         if (file->f_op != fops)
>                 return 0;
>
> +       __builtin_memset(&e, 0, sizeof(e));
>         e.pid = task->tgid;
>         e.id = get_obj_id(file->private_data, obj_type);
> +       e.bpf_cookie = 0;
> +       e.bpf_cookie_set = false;
> +
> +       if (obj_type == BPF_OBJ_LINK) {
> +               struct bpf_link *link = (struct bpf_link *) file->private_data;
> +
> +               if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
> +                       e.bpf_cookie_set = true;
> +                       e.bpf_cookie = get_bpf_cookie(link);
> +               }
> +       }
> +
>         bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
>                                   task->group_leader->comm);
>         bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
> index 5692cf257adb..2676cece58d7 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.h
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.h
> @@ -6,6 +6,8 @@
>  struct pid_iter_entry {
>         __u32 id;
>         int pid;
> +       __u64 bpf_cookie;
> +       bool bpf_cookie_set;

naming nit: either "bpf_cookie_is_set" or "has_bpf_cookie"?
"bpf_cookie_set" is read either as a verb or as "a set of bpf_cookies"

>         char comm[16];
>  };
>
> --
> 2.32.0
>
