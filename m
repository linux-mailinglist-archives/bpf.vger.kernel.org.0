Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9984422EF
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 22:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhKAV7L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 17:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhKAV7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 17:59:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A5AC061714;
        Mon,  1 Nov 2021 14:56:36 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id s24so12860361plp.0;
        Mon, 01 Nov 2021 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kYC8dIm2Gf/ftQVcpAh9z+ZO6rzaykoUcFaBLm2ROnU=;
        b=iaiy/GX8Safi6YSeXhrHCfClpJguoYG3WdplgPjMJyC9EJIiLyeU6pCjV7LolyiEuB
         8YLHPhpYOP38SSM87sjYqULmURZzbPjLitEsHj7A7ey5XMZjnWqYZQrYKn8iJ0U1ml1P
         aE6jhMgKKg40/lKsu7Vt2Z62efgCNFdPyJxJIKXu2/D3A7hhC7Vvjv4t/keqTNmDf425
         GL2uujG71iSeE3OW5ldFjoDtllqOKeoPbdriG9wAR3mg0OJbc/ZcbOwioaQEzhzoaRtG
         +m10yJa7YBgKKbrCtLZrCxrIQxlqKD0nEQY1aK6GaOp8wxtozqSVeIS00lFlzGmbKaZo
         QrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kYC8dIm2Gf/ftQVcpAh9z+ZO6rzaykoUcFaBLm2ROnU=;
        b=INybljuNcAD0eOoPVVVd8Pc7CxnYKX6ucFV1exU5+n3NMgst3k7p+nsp2tH9poQ5F4
         FYaG5fQ4CPsXzSlzeJG/kPhFYuiAc3VMIPaCypUrxQhfHzZ+5nI2/U8nYm9AAJlKs2si
         6wHbU8JHYE5ulPLSHGxAedNMMx9eXNMIenJkVKCz4fzWZbWohuJSGtkWpNZ+ccGXT5sW
         xyPdh8jrvbHPcYdAk7LLReyFY4mC4uVLSsyiRc4qg4XOcWR3L8Lm/LiySFVWywtHc+le
         YqmGhHMr11qmkmx6mRWsLynYKHpVPIXJhNaRZ50BteHizfflELBnnGvRnSlg4mVIKcn/
         Zzjw==
X-Gm-Message-State: AOAM532BTDthpeURJ+UHnj6ZBKJ8Ejo2YO14p/zS2oxRB8UGu769kcZw
        Rir8Uoh7zxS9u9tdiD+UB5Of8O2L9lpzRyeMBsg=
X-Google-Smtp-Source: ABdhPJwr+Utlc5u8p4egYPhZH51siUSOkx/KuxiyLZiItzjKAUYZFN+0n8QuDrNBbtM6y3RhMTjTLu6r/yxDnQX72VY=
X-Received: by 2002:a17:902:f542:b0:141:fa0e:1590 with SMTP id
 h2-20020a170902f54200b00141fa0e1590mr4716232plf.20.1635803796237; Mon, 01 Nov
 2021 14:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20211025082925.1459427-1-zhudi2@huawei.com>
In-Reply-To: <20211025082925.1459427-1-zhudi2@huawei.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 1 Nov 2021 14:56:24 -0700
Message-ID: <CAADnVQL8smdMDVB5TrbDP6r9ZmJZibO7C1d+6k=xs7urfGgFwQ@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: support BPF_PROG_QUERY for progs attached to sockmap
To:     Di Zhu <zhudi2@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Oct 25, 2021 at 1:29 AM Di Zhu <zhudi2@huawei.com> wrote:
>
> Right now there is no way to query whether BPF programs are
> attached to a sockmap or not.
>
> we can use the standard interface in libbpf to query, such as:
> bpf_prog_query(mapFd, BPF_SK_SKB_STREAM_PARSER, 0, NULL, ...);
> the mapFd is the fd of sockmap.
>
> Signed-off-by: Di Zhu <zhudi2@huawei.com>
> ---
> /* v2 */
> - John Fastabend <john.fastabend@gmail.com>
>   - add selftest code
> ---
>  include/linux/bpf.h                           |  9 ++
>  kernel/bpf/syscall.c                          |  5 ++
>  net/core/sock_map.c                           | 82 ++++++++++++++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 85 +++++++++++++++++++
>  .../bpf/progs/test_sockmap_progs_query.c      | 25 ++++++

please split into two patches. One for core code and one for selftest.
Make sure to mark the patches with [PATCH bpf-next] in subj.

>  5 files changed, 199 insertions(+), 7 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_progs_query.c
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index d604c8251d88..db7d0e5115b7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1961,6 +1961,9 @@ int bpf_prog_test_run_syscall(struct bpf_prog *prog,
>  int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
>  int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
>  int sock_map_update_elem_sys(struct bpf_map *map, void *key, void *value, u64 flags);
> +int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +                                union bpf_attr __user *uattr);
> +
>  void sock_map_unhash(struct sock *sk);
>  void sock_map_close(struct sock *sk, long timeout);
>  #else
> @@ -2014,6 +2017,12 @@ static inline int sock_map_update_elem_sys(struct bpf_map *map, void *key, void
>  {
>         return -EOPNOTSUPP;
>  }
> +
> +static inline int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +                                              union bpf_attr __user *uattr)
> +{
> +       return -EINVAL;
> +}
>  #endif /* CONFIG_BPF_SYSCALL */
>  #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4e50c0bfdb7d..17faeff8f85f 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3275,6 +3275,11 @@ static int bpf_prog_query(const union bpf_attr *attr,
>         case BPF_FLOW_DISSECTOR:
>         case BPF_SK_LOOKUP:
>                 return netns_bpf_prog_query(attr, uattr);
> +       case BPF_SK_SKB_STREAM_PARSER:
> +       case BPF_SK_SKB_STREAM_VERDICT:
> +       case BPF_SK_MSG_VERDICT:
> +       case BPF_SK_SKB_VERDICT:
> +               return sockmap_bpf_prog_query(attr, uattr);
>         default:
>                 return -EINVAL;
>         }
> diff --git a/net/core/sock_map.c b/net/core/sock_map.c
> index e252b8ec2b85..269349bd05a8 100644
> --- a/net/core/sock_map.c
> +++ b/net/core/sock_map.c
> @@ -1412,38 +1412,50 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
>         return NULL;
>  }
>
> -static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> -                               struct bpf_prog *old, u32 which)
> +static int sock_map_prog_lookup(struct bpf_map *map, struct bpf_prog **pprog[],

what [] is for?
'struct bpf_prog **pprog' should be enough?

> +                               u32 which)
>  {
>         struct sk_psock_progs *progs = sock_map_progs(map);
> -       struct bpf_prog **pprog;
>
>         if (!progs)
>                 return -EOPNOTSUPP;
>
>         switch (which) {
>         case BPF_SK_MSG_VERDICT:
> -               pprog = &progs->msg_parser;
> +               *pprog = &progs->msg_parser;
>                 break;
>  #if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>         case BPF_SK_SKB_STREAM_PARSER:
> -               pprog = &progs->stream_parser;
> +               *pprog = &progs->stream_parser;
>                 break;
>  #endif
>         case BPF_SK_SKB_STREAM_VERDICT:
>                 if (progs->skb_verdict)
>                         return -EBUSY;
> -               pprog = &progs->stream_verdict;
> +               *pprog = &progs->stream_verdict;
>                 break;
>         case BPF_SK_SKB_VERDICT:
>                 if (progs->stream_verdict)
>                         return -EBUSY;
> -               pprog = &progs->skb_verdict;
> +               *pprog = &progs->skb_verdict;
>                 break;
>         default:
>                 return -EOPNOTSUPP;
>         }
>
> +       return 0;
> +}
> +
> +static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
> +                               struct bpf_prog *old, u32 which)

formatting looks off.
pls run it with checkpatch.pl

> +{
> +       struct bpf_prog **pprog;
> +       int ret;
> +
> +       ret = sock_map_prog_lookup(map, &pprog, which);
> +       if (ret)
> +               return ret;
> +
>         if (old)
>                 return psock_replace_prog(pprog, prog, old);
>
> @@ -1451,6 +1463,62 @@ static int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
>         return 0;
>  }
>
> +int sockmap_bpf_prog_query(const union bpf_attr *attr,
> +                          union bpf_attr __user *uattr)
> +{
> +       __u32 __user *prog_ids = u64_to_user_ptr(attr->query.prog_ids);
> +       u32 prog_cnt = 0, flags = 0;
> +       u32 ufd = attr->target_fd;
> +       struct bpf_prog **pprog;
> +       struct bpf_prog *prog;
> +       struct bpf_map *map;
> +       struct fd f;
> +       int ret;
> +
> +       if (attr->query.query_flags)
> +               return -EINVAL;
> +
> +       if (copy_to_user(&uattr->query.attach_flags, &flags, sizeof(flags)))
> +               return -EFAULT;
> +
> +       f = fdget(ufd);
> +       map = __bpf_map_get(f);
> +       if (IS_ERR(map))
> +               return PTR_ERR(map);
> +
> +       rcu_read_lock();
> +
> +       ret = sock_map_prog_lookup(map, &pprog, attr->query.attach_type);
> +       if (ret)
> +               goto end;
> +
> +       prog = *pprog;
> +       prog_cnt = (!prog) ? 0 : 1;
> +       if (copy_to_user(&uattr->query.prog_cnt, &prog_cnt, sizeof(prog_cnt))) {

copy_to_user under rcu is broken.
Pls turn on kernel debugging and observe the splat.

> +               ret = -EFAULT;
> +               goto end;
> +       }
> +
> +       if (!attr->query.prog_cnt || !prog_ids || !prog_cnt)
> +               goto end;
> +
> +       prog = bpf_prog_inc_not_zero(prog);
> +       if (IS_ERR(prog)) {
> +               ret = PTR_ERR(prog);
> +               goto end;
> +       }
> +
> +       if (copy_to_user(prog_ids, &prog->aux->id, sizeof(u32)))
> +               ret = -EFAULT;
> +
> +       bpf_prog_put(prog);
> +
> +end:
> +       rcu_read_unlock();
> +       fdput(f);
> +       return ret;
> +}
> +
>  static void sock_map_unlink(struct sock *sk, struct sk_psock_link *link)
>  {
>         switch (link->map->map_type) {
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index 1352ec104149..23fd89661ef5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -8,6 +8,7 @@
>  #include "test_sockmap_update.skel.h"
>  #include "test_sockmap_invalid_update.skel.h"
>  #include "test_sockmap_skb_verdict_attach.skel.h"
> +#include "test_sockmap_progs_query.skel.h"
>  #include "bpf_iter_sockmap.skel.h"
>
>  #define TCP_REPAIR             19      /* TCP sock is under repair right now */
> @@ -315,6 +316,84 @@ static void test_sockmap_skb_verdict_attach(enum bpf_attach_type first,
>         test_sockmap_skb_verdict_attach__destroy(skel);
>  }
>
> +static __u32 query_prog_id(int prog)
> +{
> +       struct bpf_prog_info info = {};
> +       __u32 info_len = sizeof(info);
> +       int err;
> +
> +       err = bpf_obj_get_info_by_fd(prog, &info, &info_len);
> +       if (CHECK_FAIL(err || info_len != sizeof(info))) {

CHECK* is deprecated. Pls use ASSERT*

> +               perror("bpf_obj_get_info_by_fd");
> +               return 0;
> +       }
