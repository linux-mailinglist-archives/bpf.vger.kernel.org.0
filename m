Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0874C4D8A
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 19:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbiBYSV7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Feb 2022 13:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbiBYSV6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Feb 2022 13:21:58 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484051F83F1
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:21:25 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id i1so5505608plr.2
        for <bpf@vger.kernel.org>; Fri, 25 Feb 2022 10:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o73SABIBFtAxvfFTd1s2FGduvuui0fyh4xUXuTH4Yuc=;
        b=HU5scDEG/zziLD5/kTvATQf01uJvtdxaNS+XL1eImFUd7ZLdm9BSbWRBGJizo/bT6E
         ko0OL/ibDkilwn7XPG2QVla9rGUbPPR2QYQM+jlXrJG3oGSrOpsHLYPFmjdlHGZcvgau
         w2QS4A21A+ls9nwvBAi+RCt+cgLLPauaI+obUGID9tTPHup54f8Hkh2SQH+fur8u70m4
         610EEi8azsfb3BsiCox/Qa0CyW73gcbpMxK0yljwWEIrb1RLuAk0FPmEmK6xDuskNEIM
         W5qPKsXV8M4lo4d8fH+ekLRUUSZP4lh45XEq6tWhLi1t750YN9Znu5ktvXEUf6GFWEm2
         O6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o73SABIBFtAxvfFTd1s2FGduvuui0fyh4xUXuTH4Yuc=;
        b=sJe+n6i5Nk3oJBM9x8ecqmKxmVjGN5d6zzoAR/AfFTNZetVdgwhYpwTqjo1ggk5oqT
         6SLjZ/8fusvxzZwJLi7l9YAsqB2uzYpdrQ9qLpby5yJ8tdYu2t+UsA1AWonmXHiYZK6v
         eRV8t2oPXEswVkUed8x1360jFzvsVM8VgHexuUw+BbXrqrZxTr6aM9A7pQx860hwSV+q
         CwdhTkV92Kvaj8zmCzb1B5evFsafjbwb2cOTNFbIYCrDpsEf6YNv9mostWwQTxBjTWR/
         T5ybqFmWwY3FDvSGwJiOrEcciypB4wI1XlQHC6YArk3xgl2T1c2XgBwVoI0QvyMVCBlK
         qHNA==
X-Gm-Message-State: AOAM531xmV+an1+U8ScsYYhwyFYv8PeI2Vk43zrDkIXsg/q2rVahXZl3
        sXuySgODdaHPDi0yEW9UigNhd6+O+WL9Yjt5xNw=
X-Google-Smtp-Source: ABdhPJxlTTmxIuQCD2ynI4e9pmcwFq4pa0cwtzrRaQkQoiuIhUFe/c7EKh2iYot+/wH02YBQW1oNfubqeFRguaJzmJo=
X-Received: by 2002:a17:902:76c5:b0:14e:e325:9513 with SMTP id
 j5-20020a17090276c500b0014ee3259513mr8577209plt.55.1645813284531; Fri, 25 Feb
 2022 10:21:24 -0800 (PST)
MIME-Version: 1.0
References: <20220225175229.2206420-1-fallentree@fb.com>
In-Reply-To: <20220225175229.2206420-1-fallentree@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 25 Feb 2022 10:21:13 -0800
Message-ID: <CAADnVQLTSk9f-RhoxU2A=0qtgdVSFhW228aO0K70fBHwL2S7Vw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Yucong Sun <sunyucong@gmail.com>,
        Kernel Team <kernel-team@fb.com>
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

On Fri, Feb 25, 2022 at 9:52 AM Yucong Sun <fallentree@fb.com> wrote:
>
> In a previous commit (1), BPF preload process was switched from user
> mode process to use in-kernel light skeleton instead. However, in the
> kernel context the available fd starts from 0, instead of normally 3 for
> user mode process. and the preload process leaked two FDs, taking over
> FD 0 and 1. This  which later caused issues when kernel trys to setup
> stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
>
> As seen here:
>
> Before fix:
> ls -lah /proc/1/fd/*
>
> lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
>
> After Fix / Normal:
>
> ls -lah /proc/1/fd/*
>
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
>
> In this patch:
>   - skel_closenz was changed to skel_closegez to correctly handle
>     FD=0 case.
>   - various places detecting FD > 0 was changed to FD >= 0.
>   - Call iterators_skel__detach() funciton to release FDs after links
>   are obtained.
>
> 1: commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")
>
> Fixes: commit cb80ddc67152 ("bpf: Convert bpf_preload.ko to use light skeleton.")
> Signed-off-by: Yucong Sun <fallentree@fb.com>
>
> V2 -> V1: rename skel_closenez to skel_closegez, added comment as
> requested.
> ---
>  kernel/bpf/preload/bpf_preload_kern.c          |  4 ++++
>  kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
>  tools/bpf/bpftool/gen.c                        |  9 +++++----
>  tools/lib/bpf/skel_internal.h                  |  8 ++++----
>  4 files changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 30207c048d36..3cc8bbfd15b1 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -14,6 +14,8 @@ static void free_links_and_skel(void)
>                 bpf_link_put(maps_link);
>         if (!IS_ERR_OR_NULL(progs_link))
>                 bpf_link_put(progs_link);
> +       /* __detach() was already called before this, __destory() will call it again, but
> +         with no effect. */
>         iterators_bpf__destroy(skel);
>  }
>
> @@ -54,6 +56,8 @@ static int load_skel(void)
>                 err = PTR_ERR(progs_link);
>                 goto out;
>         }
> +       /* Release all FDs */
> +       iterators_bpf__detach(skel);
>         return 0;
>  out:
>         free_links_and_skel();
> diff --git a/kernel/bpf/preload/iterators/iterators.lskel.h b/kernel/bpf/preload/iterators/iterators.lskel.h
> index 70f236a82fe1..6a93538fa69f 100644
> --- a/kernel/bpf/preload/iterators/iterators.lskel.h
> +++ b/kernel/bpf/preload/iterators/iterators.lskel.h
> @@ -28,7 +28,7 @@ iterators_bpf__dump_bpf_map__attach(struct iterators_bpf *skel)
>         int prog_fd = skel->progs.dump_bpf_map.prog_fd;
>         int fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
>
> -       if (fd > 0)
> +       if (fd >= 0)
>                 skel->links.dump_bpf_map_fd = fd;
>         return fd;
>  }
> @@ -39,7 +39,7 @@ iterators_bpf__dump_bpf_prog__attach(struct iterators_bpf *skel)
>         int prog_fd = skel->progs.dump_bpf_prog.prog_fd;
>         int fd = skel_link_create(prog_fd, 0, BPF_TRACE_ITER);
>
> -       if (fd > 0)
> +       if (fd >= 0)
>                 skel->links.dump_bpf_prog_fd = fd;
>         return fd;
>  }
> @@ -57,8 +57,10 @@ iterators_bpf__attach(struct iterators_bpf *skel)
>  static inline void
>  iterators_bpf__detach(struct iterators_bpf *skel)
>  {
> -       skel_closenz(skel->links.dump_bpf_map_fd);
> -       skel_closenz(skel->links.dump_bpf_prog_fd);
> +       skel_closegez(skel->links.dump_bpf_map_fd);
> +       skel->links.dump_bpf_map_fd = -1;
> +       skel_closegez(skel->links.dump_bpf_prog_fd);
> +       skel->links.dump_bpf_prog_fd = -1;
>  }
>  static void
>  iterators_bpf__destroy(struct iterators_bpf *skel)
> @@ -66,10 +68,10 @@ iterators_bpf__destroy(struct iterators_bpf *skel)
>         if (!skel)
>                 return;
>         iterators_bpf__detach(skel);
> -       skel_closenz(skel->progs.dump_bpf_map.prog_fd);
> -       skel_closenz(skel->progs.dump_bpf_prog.prog_fd);
> +       skel_closegez(skel->progs.dump_bpf_map.prog_fd);
> +       skel_closegez(skel->progs.dump_bpf_prog.prog_fd);
>         skel_free_map_data(skel->rodata, skel->maps.rodata.initial_value, 4096);
> -       skel_closenz(skel->maps.rodata.map_fd);
> +       skel_closegez(skel->maps.rodata.map_fd);
>         skel_free(skel);
>  }
>  static inline struct iterators_bpf *
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 145734b4fe41..e5e65f507e00 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -469,7 +469,7 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
>                 codegen("\
>                         \n\
>                                                                                     \n\
> -                               if (fd > 0)                                         \n\
> +                               if (fd >= 0)                                        \n\
>                                         skel->links.%1$s_fd = fd;                   \n\
>                                 return fd;                                          \n\
>                         }                                                           \n\
> @@ -506,7 +506,8 @@ static void codegen_attach_detach(struct bpf_object *obj, const char *obj_name)
>         bpf_object__for_each_program(prog, obj) {
>                 codegen("\
>                         \n\
> -                               skel_closenz(skel->links.%1$s_fd);          \n\
> +                               skel_closegez(skel->links.%1$s_fd);         \n\
> +                               skel->links.%1$s_fd = -1;           \n\
>                         ", bpf_program__name(prog));
>         }
>
> @@ -536,7 +537,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>         bpf_object__for_each_program(prog, obj) {
>                 codegen("\
>                         \n\
> -                               skel_closenz(skel->progs.%1$s.prog_fd);     \n\
> +                               skel_closegez(skel->progs.%1$s.prog_fd);            \n\
>                         ", bpf_program__name(prog));
>         }
>
> @@ -549,7 +550,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>                                ident, bpf_map_mmap_sz(map));
>                 codegen("\
>                         \n\
> -                               skel_closenz(skel->maps.%1$s.map_fd);       \n\
> +                               skel_closegez(skel->maps.%1$s.map_fd);      \n\
>                         ", ident);
>         }
>         codegen("\
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index bd6f4505e7b1..89c0b8632254 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -204,11 +204,11 @@ static inline void *skel_finalize_map_data(__u64 *init_val, size_t mmap_sz, int
>  }
>  #endif
>
> -static inline int skel_closenz(int fd)
> +static inline int skel_closegez(int fd)
>  {
> -       if (fd > 0)
> -               return close(fd);
> -       return -EINVAL;
> +       if (fd < 0)
> +               return -EINVAL;
> +       return close(fd);
>  }

Unfortunately this won't work. Many places in gen_loader.c
rely on fd == 0 being a signal that fd wasn't allocated.
The global data, stack, loader_ctx, etc. All are zero initialized.
Thankfully no need to do any of these changes.
Just closing two link_fd in load_skel() is enough.
