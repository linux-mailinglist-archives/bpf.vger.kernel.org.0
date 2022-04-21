Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB3450A9E1
	for <lists+bpf@lfdr.de>; Thu, 21 Apr 2022 22:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392300AbiDUUZQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Apr 2022 16:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiDUUZP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Apr 2022 16:25:15 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A3F49F06
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 13:22:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t6so4763745wra.4
        for <bpf@vger.kernel.org>; Thu, 21 Apr 2022 13:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aaIkKZOqS4lEgJqlujdOZHeOPI75SpYejiJYXyplkEE=;
        b=lf8H3RuIO/OeekOLseCoM3WiUT/MxPgMTcB9/v+Qj3Ha0OPgQz65Dp1jy9BcPUwQ1X
         3iBrYIImXktssQXefUrcSLxzDALp74B3kSzkgs1jsR2XcsGcy33jJ1LgZauJPTn8Zg2x
         cPMSVi7jeCXlm/eLYX7JGQlC8/yQ2Hy+Zrwr7ALH9sbgwXSychTV+xiJjDkLG/8zJvNL
         SwIEwgPRnS16X/xXmaP/+Jphb7B/3ND9uLeiWZVY6Gr6aQTTRLzTkROStegU7QjKrpUC
         w17hZsCrQso12x9ccoayO2EJk1DMUAbJQ3WXMctLwbzhWXGky5trWFx6xuOFDfMedSqc
         nXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aaIkKZOqS4lEgJqlujdOZHeOPI75SpYejiJYXyplkEE=;
        b=XRYIezJNnK3UrDRdepuRpyEZkeF4z/6R0//n2lAhXbdQJONti3jaNfIn83K2ZtdNXC
         fPgm7pWr101Sf9h6gb+xZ4xigditFMloWF0R0FgWsBy7Mt5TMwL9/qtcB4czjq84U5c7
         j632SH5haztLSrMHCcuTQzWhZ/UlodcYasfSLZnbMSYI02jakiEGCXhExMr0AUCz4Nn3
         fkDbxH86clf46Di/q1SlXR+cJ4Y9XZ3JP36PIBo/iVvbZD67rSVQ45h/c3OScKwtGqde
         4zyC2TdCVRxtI4PR8niIK2VhA+q4Ic3es5q2og64v5eu5xGO3oZhRBYZg+BZD2CSauFC
         /URQ==
X-Gm-Message-State: AOAM531nTwyD7rpVC/kIHAjCkHt2JFQpc0eV9uTXdzoy7DBH7wlYPL4z
        gKqNqKzgnta/WL/MTwc+Bhohasgdq+UBI62BSFCrtA==
X-Google-Smtp-Source: ABdhPJxEvOrvwQ9gyDHQdCN1vvRO76B6gq2XgqiHdKIZWU1G45gcwsGjAjiWJ1XRR62DnDiYSg0QxyHs5nDLXGjgSJ8=
X-Received: by 2002:a05:6000:168c:b0:20a:84ea:6647 with SMTP id
 y12-20020a056000168c00b0020a84ea6647mr1016928wrd.191.1650572542808; Thu, 21
 Apr 2022 13:22:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220405214342.1968262-1-sdf@google.com> <20220405214342.1968262-3-sdf@google.com>
 <20220421194650.q5ada2zdyzvayu4a@apollo.legion>
In-Reply-To: <20220421194650.q5ada2zdyzvayu4a@apollo.legion>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Thu, 21 Apr 2022 13:22:11 -0700
Message-ID: <CAKH8qBtjHr9Lcg=0VEEX1kAXEep4KVK-2ZNSTCGhYyC5i94qiw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/7] bpf: per-cgroup lsm flavor
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Apr 21, 2022 at 12:46 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, Apr 06, 2022 at 03:13:37AM IST, Stanislav Fomichev wrote:
> > Allow attaching to lsm hooks in the cgroup context.
> >
> > Attaching to per-cgroup LSM works exactly like attaching
> > to other per-cgroup hooks. New BPF_LSM_CGROUP is added
> > to trigger new mode; the actual lsm hook we attach to is
> > signaled via existing attach_btf_id.
> >
> > For the hooks that have 'struct socket' as its first argument,
> > we use the cgroup associated with that socket. For the rest,
> > we use 'current' cgroup (this is all on default hierarchy == v2 only).
> > Note that for the hooks that work on 'struct sock' we still
> > take the cgroup from 'current' because most of the time,
> > the 'sock' argument is not properly initialized.
> >
> > Behind the scenes, we allocate a shim program that is attached
> > to the trampoline and runs cgroup effective BPF programs array.
> > This shim has some rudimentary ref counting and can be shared
> > between several programs attaching to the same per-cgroup lsm hook.
> >
> > Note that this patch bloats cgroup size because we add 211
> > cgroup_bpf_attach_type(s) for simplicity sake. This will be
> > addressed in the subsequent patch.
> >
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> >  include/linux/bpf-cgroup-defs.h |   6 ++
> >  include/linux/bpf.h             |  13 +++
> >  include/linux/bpf_lsm.h         |  14 ++++
> >  include/uapi/linux/bpf.h        |   1 +
> >  kernel/bpf/bpf_lsm.c            |  92 ++++++++++++++++++++
> >  kernel/bpf/btf.c                |  11 +++
> >  kernel/bpf/cgroup.c             | 116 ++++++++++++++++++++++---
> >  kernel/bpf/syscall.c            |  10 +++
> >  kernel/bpf/trampoline.c         | 144 ++++++++++++++++++++++++++++++++
> >  kernel/bpf/verifier.c           |   1 +
> >  tools/include/uapi/linux/bpf.h  |   1 +
> >  11 files changed, 397 insertions(+), 12 deletions(-)
> >
> > diff --git a/include/linux/bpf-cgroup-defs.h b/include/linux/bpf-cgroup-defs.h
> > index 695d1224a71b..6c661b4df9fa 100644
> > --- a/include/linux/bpf-cgroup-defs.h
> > +++ b/include/linux/bpf-cgroup-defs.h
> > @@ -10,6 +10,8 @@
> >
> >  struct bpf_prog_array;
> >
> > +#define CGROUP_LSM_NUM 211 /* will be addressed in the next patch */
> > +
> >  enum cgroup_bpf_attach_type {
> >       CGROUP_BPF_ATTACH_TYPE_INVALID = -1,
> >       CGROUP_INET_INGRESS = 0,
> > @@ -35,6 +37,10 @@ enum cgroup_bpf_attach_type {
> >       CGROUP_INET4_GETSOCKNAME,
> >       CGROUP_INET6_GETSOCKNAME,
> >       CGROUP_INET_SOCK_RELEASE,
> > +#ifdef CONFIG_BPF_LSM
> > +     CGROUP_LSM_START,
> > +     CGROUP_LSM_END = CGROUP_LSM_START + CGROUP_LSM_NUM - 1,
> > +#endif
> >       MAX_CGROUP_BPF_ATTACH_TYPE
> >  };
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 487aba40ce52..17bbe2f7b2be 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -807,6 +807,9 @@ static __always_inline __nocfi unsigned int bpf_dispatcher_nop_func(
> >  #ifdef CONFIG_BPF_JIT
> >  int bpf_trampoline_link_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
> >  int bpf_trampoline_unlink_prog(struct bpf_prog *prog, struct bpf_trampoline *tr);
> > +int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> > +                                 struct bpf_attach_target_info *tgt_info);
> > +void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog);
> >  struct bpf_trampoline *bpf_trampoline_get(u64 key,
> >                                         struct bpf_attach_target_info *tgt_info);
> >  void bpf_trampoline_put(struct bpf_trampoline *tr);
> > @@ -865,6 +868,14 @@ static inline int bpf_trampoline_unlink_prog(struct bpf_prog *prog,
> >  {
> >       return -ENOTSUPP;
> >  }
> > +static inline int bpf_trampoline_link_cgroup_shim(struct bpf_prog *prog,
> > +                                               struct bpf_attach_target_info *tgt_info)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +static inline void bpf_trampoline_unlink_cgroup_shim(struct bpf_prog *prog)
> > +{
> > +}
> >  static inline struct bpf_trampoline *bpf_trampoline_get(u64 key,
> >                                                       struct bpf_attach_target_info *tgt_info)
> >  {
> > @@ -980,6 +991,7 @@ struct bpf_prog_aux {
> >       u64 load_time; /* ns since boottime */
> >       u32 verified_insns;
> >       struct bpf_map *cgroup_storage[MAX_BPF_CGROUP_STORAGE_TYPE];
> > +     int cgroup_atype; /* enum cgroup_bpf_attach_type */
> >       char name[BPF_OBJ_NAME_LEN];
> >  #ifdef CONFIG_SECURITY
> >       void *security;
> > @@ -2383,6 +2395,7 @@ void *bpf_arch_text_copy(void *dst, void *src, size_t len);
> >
> >  struct btf_id_set;
> >  bool btf_id_set_contains(const struct btf_id_set *set, u32 id);
> > +int btf_id_set_index(const struct btf_id_set *set, u32 id);
> >
> >  #define MAX_BPRINTF_VARARGS          12
> >
> > diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
> > index 479c101546ad..7f0e59f5f9be 100644
> > --- a/include/linux/bpf_lsm.h
> > +++ b/include/linux/bpf_lsm.h
> > @@ -42,6 +42,9 @@ extern const struct bpf_func_proto bpf_inode_storage_get_proto;
> >  extern const struct bpf_func_proto bpf_inode_storage_delete_proto;
> >  void bpf_inode_storage_free(struct inode *inode);
> >
> > +int bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog, bpf_func_t *bpf_func);
> > +int bpf_lsm_hook_idx(u32 btf_id);
> > +
> >  #else /* !CONFIG_BPF_LSM */
> >
> >  static inline bool bpf_lsm_is_sleepable_hook(u32 btf_id)
> > @@ -65,6 +68,17 @@ static inline void bpf_inode_storage_free(struct inode *inode)
> >  {
> >  }
> >
> > +static inline int bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
> > +                                        bpf_func_t *bpf_func)
> > +{
> > +     return -ENOENT;
> > +}
> > +
> > +static inline int bpf_lsm_hook_idx(u32 btf_id)
> > +{
> > +     return -EINVAL;
> > +}
> > +
> >  #endif /* CONFIG_BPF_LSM */
> >
> >  #endif /* _LINUX_BPF_LSM_H */
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index d14b10b85e51..bbe48a2dd852 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -998,6 +998,7 @@ enum bpf_attach_type {
> >       BPF_SK_REUSEPORT_SELECT_OR_MIGRATE,
> >       BPF_PERF_EVENT,
> >       BPF_TRACE_KPROBE_MULTI,
> > +     BPF_LSM_CGROUP,
> >       __MAX_BPF_ATTACH_TYPE
> >  };
> >
> > diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> > index 064eccba641d..eca258ba71d8 100644
> > --- a/kernel/bpf/bpf_lsm.c
> > +++ b/kernel/bpf/bpf_lsm.c
> > @@ -35,6 +35,98 @@ BTF_SET_START(bpf_lsm_hooks)
> >  #undef LSM_HOOK
> >  BTF_SET_END(bpf_lsm_hooks)
> >
> > +static unsigned int __cgroup_bpf_run_lsm_socket(const void *ctx,
> > +                                             const struct bpf_insn *insn)
> > +{
> > +     const struct bpf_prog *prog;
> > +     struct socket *sock;
> > +     struct cgroup *cgrp;
> > +     struct sock *sk;
> > +     int ret = 0;
> > +     u64 *regs;
> > +
> > +     regs = (u64 *)ctx;
> > +     sock = (void *)(unsigned long)regs[BPF_REG_0];
> > +     /*prog = container_of(insn, struct bpf_prog, insnsi);*/
> > +     prog = (const struct bpf_prog *)((void *)insn - offsetof(struct bpf_prog, insnsi));
> > +
> > +     if (unlikely(!sock))
> > +             return 0;
> > +
> > +     sk = sock->sk;
> > +     if (unlikely(!sk))
> > +             return 0;
> > +
> > +     cgrp = sock_cgroup_ptr(&sk->sk_cgrp_data);
> > +     if (likely(cgrp))
> > +             ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[prog->aux->cgroup_atype],
> > +                                         ctx, bpf_prog_run, 0);
> > +     return ret;
> > +}
> > +
> > +static unsigned int __cgroup_bpf_run_lsm_current(const void *ctx,
> > +                                              const struct bpf_insn *insn)
> > +{
> > +     const struct bpf_prog *prog;
> > +     struct cgroup *cgrp;
> > +     int ret = 0;
> > +
> > +     if (unlikely(!current))
> > +             return 0;
> > +
> > +     /*prog = container_of(insn, struct bpf_prog, insnsi);*/
> > +     prog = (const struct bpf_prog *)((void *)insn - offsetof(struct bpf_prog, insnsi));
> > +
> > +     rcu_read_lock();
> > +     cgrp = task_dfl_cgroup(current);
> > +     if (likely(cgrp))
> > +             ret = BPF_PROG_RUN_ARRAY_CG(cgrp->bpf.effective[prog->aux->cgroup_atype],
> > +                                         ctx, bpf_prog_run, 0);
> > +     rcu_read_unlock();
> > +     return ret;
> > +}
> > +
> > +int bpf_lsm_find_cgroup_shim(const struct bpf_prog *prog,
> > +                          bpf_func_t *bpf_func)
> > +{
> > +     const struct btf_type *first_arg_type;
> > +     const struct btf_type *sock_type;
> > +     const struct btf *btf_vmlinux;
> > +     const struct btf_param *args;
> > +     s32 type_id;
> > +
> > +     if (!prog->aux->attach_func_proto ||
> > +         !btf_type_is_func_proto(prog->aux->attach_func_proto))
> > +             return -EINVAL;
> > +
> > +     if (btf_type_vlen(prog->aux->attach_func_proto) < 1)
> > +             return -EINVAL;
> > +
> > +     args = (const struct btf_param *)(prog->aux->attach_func_proto + 1);
> > +
> > +     btf_vmlinux = bpf_get_btf_vmlinux();
> > +     if (!btf_vmlinux)
>
> We should use IS_ERR_OR_NULL to check the result, e.g. see:
> 7ada3787e91c ("bpf: Check for NULL return from bpf_get_btf_vmlinux").

Oh, thanks, will do!
