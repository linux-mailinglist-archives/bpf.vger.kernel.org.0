Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E1A5964AA
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 23:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiHPVdS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 17:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237159AbiHPVdR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 17:33:17 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB620F68
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:33:13 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id b2so9133505qkh.12
        for <bpf@vger.kernel.org>; Tue, 16 Aug 2022 14:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3lLwwi5RsLIDxpvLcVjUn3nx/6xniKS7WDFY8JJmwU8=;
        b=JwfZ0JEkHlE3bmWawaW/92UGVsWfTwyqgausuxlysnwBGk0Y0eGnRSSAzSB8qIVwAJ
         +hmGkO/DiPWYOAsm2VEkou51pecMJjBtlyMnBHTda8/rhxFHMQMbNpBDmPcB4u05kf2b
         c4HVOKZGBUGHW9AkZpvEJNeCohssaygEeI2Hyh5yLD65H+Tmo9WHXBg5Uum1Op82WTfq
         O1ifv+DfpcNuvl9POMMTkOssyMI1bmUudoLYZdg0FSbdW5JfQkxcgwFm/CXnAD+P7sGp
         kvPFgecY/f7gFe6A+dbb/B+QOHlosEvZUplGOzIEZXt3P51agq11R48fUXHJckMJPogo
         70cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3lLwwi5RsLIDxpvLcVjUn3nx/6xniKS7WDFY8JJmwU8=;
        b=oH9RcKXc0t3oxAt9dYpJOi3YM3uDIBLPhjvffwEHqSn0so1SW+Zp3pFutOTjH+vp3a
         GSnUy4gVMInpaYqcByi3pv6VGxfHqZDDxR1D8rmLCyRCT+WO0g12HfR4Gwr2cagR4zJd
         //td+d0aGuWzyZGzQ6oknTDO6uCV/xV8jxuH8dxCNw/+Ep3hgDeTw5D601f5EdWrZJXF
         4j75vL0hcRACRlgSI3/XRTx3H+IME1HaztoOV8KHTDIni7+YH6a6plusoBLbL2AYMCmA
         OJkk1E2MARB/YPl9KB1PoW430yZ7s6YdS8Fb7SSF+1hodkXjKUsiXXX+gUGrhk5Z5x2o
         oaJA==
X-Gm-Message-State: ACgBeo03wFZgFnkFa2zUYvntYrC2okFqxlgzxbZUN0FBhJGVA5dedIWv
        A4910o3/dXx5vGwpiumoMfqx8qvToxzBx9CbEqXrCw==
X-Google-Smtp-Source: AA6agR5/Zpr7ET7EJw59zAVNAS+3jT1Q3nVe61AvHLJnDHYNKMX9TBwAHJHPkHHteCSOaXXa7G+gqvIxxk6y3Vvth1Y=
X-Received: by 2002:a05:620a:f0e:b0:6b5:48f6:91da with SMTP id
 v14-20020a05620a0f0e00b006b548f691damr15503795qkl.446.1660685592554; Tue, 16
 Aug 2022 14:33:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220816001929.369487-1-andrii@kernel.org> <20220816001929.369487-3-andrii@kernel.org>
In-Reply-To: <20220816001929.369487-3-andrii@kernel.org>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 16 Aug 2022 14:33:01 -0700
Message-ID: <CA+khW7g6GL7DwEwKfsszmKdW4562nd6MzuT640su2TmFfp6Y2g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] libbpf: streamline bpf_attr and
 perf_event_attr initialization
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 15, 2022 at 8:53 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Make sure that entire libbpf code base is initializing bpf_attr and
> perf_event_attr with memset(0). Also for bpf_attr make sure we
> clear and pass to kernel only relevant parts of bpf_attr. bpf_attr is
> a huge union of independent sub-command attributes, so there is no need
> to clear and pass entire union bpf_attr, which over time grows quite
> a lot and for most commands this growth is completely irrelevant.
>
> Few cases where we were relying on compiler initialization of BPF UAPI
> structs (like bpf_prog_info, bpf_map_info, etc) with `= {};` were
> switched to memset(0) pattern for future-proofing.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Looks good to me. I went over all the functions in this change and
verified the conversion is correct. There is only one question: I
noticed, for bpf_prog_load() and probe_memcg_account(), we only cover
up to fd_array and attach_btf_obj_fd. Should we cover up to the last
field i.e. core_relo_rec_size?

Acked-by: Hao Luo <haoluo@google.com>


>  tools/lib/bpf/bpf.c           | 173 ++++++++++++++++++++--------------
>  tools/lib/bpf/libbpf.c        |  43 ++++++---
>  tools/lib/bpf/netlink.c       |   3 +-
>  tools/lib/bpf/skel_internal.h |  10 +-
>  4 files changed, 138 insertions(+), 91 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 575867d69496..e3a0bd7efa2f 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -105,7 +105,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned int size, int attempts)
>   */
>  int probe_memcg_account(void)
>  {
> -       const size_t prog_load_attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
> +       const size_t attr_sz = offsetofend(union bpf_attr, attach_btf_obj_fd);
>         struct bpf_insn insns[] = {
>                 BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
>                 BPF_EXIT_INSN(),
> @@ -115,13 +115,13 @@ int probe_memcg_account(void)
>         int prog_fd;
>
>         /* attempt loading freplace trying to use custom BTF */
> -       memset(&attr, 0, prog_load_attr_sz);
> +       memset(&attr, 0, attr_sz);
>         attr.prog_type = BPF_PROG_TYPE_SOCKET_FILTER;
>         attr.insns = ptr_to_u64(insns);
>         attr.insn_cnt = insn_cnt;
>         attr.license = ptr_to_u64("GPL");
>
> -       prog_fd = sys_bpf_fd(BPF_PROG_LOAD, &attr, prog_load_attr_sz);
> +       prog_fd = sys_bpf_fd(BPF_PROG_LOAD, &attr, attr_sz);
>         if (prog_fd >= 0) {
>                 close(prog_fd);
>                 return 1;
> @@ -232,6 +232,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>                   const struct bpf_insn *insns, size_t insn_cnt,
>                   const struct bpf_prog_load_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, fd_array);
>         void *finfo = NULL, *linfo = NULL;
>         const char *func_info, *line_info;
>         __u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
> @@ -251,7 +252,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>         if (attempts == 0)
>                 attempts = PROG_LOAD_ATTEMPTS;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>
>         attr.prog_type = prog_type;
>         attr.expected_attach_type = OPTS_GET(opts, expected_attach_type, 0);
> @@ -314,7 +315,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>                 attr.log_level = log_level;
>         }
>
> -       fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> +       fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
>         if (fd >= 0)
>                 return fd;
>
> @@ -354,7 +355,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>                         break;
>                 }
>
> -               fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> +               fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
>                 if (fd >= 0)
>                         goto done;
>         }
> @@ -368,7 +369,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>                 attr.log_size = log_size;
>                 attr.log_level = 1;
>
> -               fd = sys_bpf_prog_load(&attr, sizeof(attr), attempts);
> +               fd = sys_bpf_prog_load(&attr, attr_sz, attempts);
>         }
>  done:
>         /* free() doesn't affect errno, so we don't need to restore it */
> @@ -380,127 +381,136 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>  int bpf_map_update_elem(int fd, const void *key, const void *value,
>                         __u64 flags)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.value = ptr_to_u64(value);
>         attr.flags = flags;
>
> -       ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_lookup_elem(int fd, const void *key, void *value)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.value = ptr_to_u64(value);
>
> -       ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_lookup_elem_flags(int fd, const void *key, void *value, __u64 flags)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.value = ptr_to_u64(value);
>         attr.flags = flags;
>
> -       ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_LOOKUP_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_lookup_and_delete_elem(int fd, const void *key, void *value)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.value = ptr_to_u64(value);
>
> -       ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_lookup_and_delete_elem_flags(int fd, const void *key, void *value, __u64 flags)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.value = ptr_to_u64(value);
>         attr.flags = flags;
>
> -       ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_LOOKUP_AND_DELETE_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_delete_elem(int fd, const void *key)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>
> -       ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_delete_elem_flags(int fd, const void *key, __u64 flags)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.flags = flags;
>
> -       ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_DELETE_ELEM, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_get_next_key(int fd, const void *key, void *next_key)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, next_key);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>         attr.key = ptr_to_u64(key);
>         attr.next_key = ptr_to_u64(next_key);
>
> -       ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_GET_NEXT_KEY, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_map_freeze(int fd)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, map_fd);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_fd = fd;
>
> -       ret = sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_MAP_FREEZE, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
> @@ -509,13 +519,14 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>                                 __u32 *count,
>                                 const struct bpf_map_batch_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, batch);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_map_batch_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.batch.map_fd = fd;
>         attr.batch.in_batch = ptr_to_u64(in_batch);
>         attr.batch.out_batch = ptr_to_u64(out_batch);
> @@ -525,7 +536,7 @@ static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
>         attr.batch.elem_flags  = OPTS_GET(opts, elem_flags, 0);
>         attr.batch.flags = OPTS_GET(opts, flags, 0);
>
> -       ret = sys_bpf(cmd, &attr, sizeof(attr));
> +       ret = sys_bpf(cmd, &attr, attr_sz);
>         *count = attr.batch.count;
>
>         return libbpf_err_errno(ret);
> @@ -564,14 +575,15 @@ int bpf_map_update_batch(int fd, const void *keys, const void *values, __u32 *co
>
>  int bpf_obj_pin(int fd, const char *pathname)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, file_flags);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.pathname = ptr_to_u64((void *)pathname);
>         attr.bpf_fd = fd;
>
> -       ret = sys_bpf(BPF_OBJ_PIN, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_OBJ_PIN, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
> @@ -582,17 +594,18 @@ int bpf_obj_get(const char *pathname)
>
>  int bpf_obj_get_opts(const char *pathname, const struct bpf_obj_get_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, file_flags);
>         union bpf_attr attr;
>         int fd;
>
>         if (!OPTS_VALID(opts, bpf_obj_get_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.pathname = ptr_to_u64((void *)pathname);
>         attr.file_flags = OPTS_GET(opts, file_flags, 0);
>
> -       fd = sys_bpf_fd(BPF_OBJ_GET, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_OBJ_GET, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
> @@ -610,20 +623,21 @@ int bpf_prog_attach_opts(int prog_fd, int target_fd,
>                           enum bpf_attach_type type,
>                           const struct bpf_prog_attach_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_prog_attach_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.target_fd     = target_fd;
>         attr.attach_bpf_fd = prog_fd;
>         attr.attach_type   = type;
>         attr.attach_flags  = OPTS_GET(opts, flags, 0);
>         attr.replace_bpf_fd = OPTS_GET(opts, replace_prog_fd, 0);
>
> -       ret = sys_bpf(BPF_PROG_ATTACH, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_ATTACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
> @@ -634,28 +648,30 @@ int bpf_prog_attach_xattr(int prog_fd, int target_fd,
>
>  int bpf_prog_detach(int target_fd, enum bpf_attach_type type)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.target_fd   = target_fd;
>         attr.attach_type = type;
>
> -       ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_prog_detach2(int prog_fd, int target_fd, enum bpf_attach_type type)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, replace_bpf_fd);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.target_fd   = target_fd;
>         attr.attach_bpf_fd = prog_fd;
>         attr.attach_type = type;
>
> -       ret = sys_bpf(BPF_PROG_DETACH, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_DETACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
> @@ -663,6 +679,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                     enum bpf_attach_type attach_type,
>                     const struct bpf_link_create_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, link_create);
>         __u32 target_btf_id, iter_info_len;
>         union bpf_attr attr;
>         int fd, err;
> @@ -681,7 +698,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                         return libbpf_err(-EINVAL);
>         }
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.link_create.prog_fd = prog_fd;
>         attr.link_create.target_fd = target_fd;
>         attr.link_create.attach_type = attach_type;
> @@ -725,7 +742,7 @@ int bpf_link_create(int prog_fd, int target_fd,
>                 break;
>         }
>  proceed:
> -       fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_LINK_CREATE, &attr, attr_sz);
>         if (fd >= 0)
>                 return fd;
>         /* we'll get EINVAL if LINK_CREATE doesn't support attaching fentry
> @@ -761,44 +778,47 @@ int bpf_link_create(int prog_fd, int target_fd,
>
>  int bpf_link_detach(int link_fd)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, link_detach);
>         union bpf_attr attr;
>         int ret;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.link_detach.link_fd = link_fd;
>
> -       ret = sys_bpf(BPF_LINK_DETACH, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_LINK_DETACH, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_link_update(int link_fd, int new_prog_fd,
>                     const struct bpf_link_update_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, link_update);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_link_update_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.link_update.link_fd = link_fd;
>         attr.link_update.new_prog_fd = new_prog_fd;
>         attr.link_update.flags = OPTS_GET(opts, flags, 0);
>         attr.link_update.old_prog_fd = OPTS_GET(opts, old_prog_fd, 0);
>
> -       ret = sys_bpf(BPF_LINK_UPDATE, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_LINK_UPDATE, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
>
>  int bpf_iter_create(int link_fd)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, iter_create);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.iter_create.link_fd = link_fd;
>
> -       fd = sys_bpf_fd(BPF_ITER_CREATE, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_ITER_CREATE, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
> @@ -806,13 +826,14 @@ int bpf_prog_query_opts(int target_fd,
>                         enum bpf_attach_type type,
>                         struct bpf_prog_query_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, query);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_prog_query_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>
>         attr.query.target_fd    = target_fd;
>         attr.query.attach_type  = type;
> @@ -821,7 +842,7 @@ int bpf_prog_query_opts(int target_fd,
>         attr.query.prog_ids     = ptr_to_u64(OPTS_GET(opts, prog_ids, NULL));
>         attr.query.prog_attach_flags = ptr_to_u64(OPTS_GET(opts, prog_attach_flags, NULL));
>
> -       ret = sys_bpf(BPF_PROG_QUERY, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_QUERY, &attr, attr_sz);
>
>         OPTS_SET(opts, attach_flags, attr.query.attach_flags);
>         OPTS_SET(opts, prog_cnt, attr.query.prog_cnt);
> @@ -850,13 +871,14 @@ int bpf_prog_query(int target_fd, enum bpf_attach_type type, __u32 query_flags,
>
>  int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, test);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_test_run_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.test.prog_fd = prog_fd;
>         attr.test.batch_size = OPTS_GET(opts, batch_size, 0);
>         attr.test.cpu = OPTS_GET(opts, cpu, 0);
> @@ -872,7 +894,7 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
>         attr.test.data_in = ptr_to_u64(OPTS_GET(opts, data_in, NULL));
>         attr.test.data_out = ptr_to_u64(OPTS_GET(opts, data_out, NULL));
>
> -       ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_TEST_RUN, &attr, attr_sz);
>
>         OPTS_SET(opts, data_size_out, attr.test.data_size_out);
>         OPTS_SET(opts, ctx_size_out, attr.test.ctx_size_out);
> @@ -884,13 +906,14 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
>
>  static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int err;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.start_id = start_id;
>
> -       err = sys_bpf(cmd, &attr, sizeof(attr));
> +       err = sys_bpf(cmd, &attr, attr_sz);
>         if (!err)
>                 *next_id = attr.next_id;
>
> @@ -919,80 +942,84 @@ int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
>
>  int bpf_prog_get_fd_by_id(__u32 id)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.prog_id = id;
>
> -       fd = sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_PROG_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
>  int bpf_map_get_fd_by_id(__u32 id)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.map_id = id;
>
> -       fd = sys_bpf_fd(BPF_MAP_GET_FD_BY_ID, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_MAP_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
>  int bpf_btf_get_fd_by_id(__u32 id)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.btf_id = id;
>
> -       fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
>  int bpf_link_get_fd_by_id(__u32 id)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.link_id = id;
>
> -       fd = sys_bpf_fd(BPF_LINK_GET_FD_BY_ID, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_LINK_GET_FD_BY_ID, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
>  int bpf_obj_get_info_by_fd(int bpf_fd, void *info, __u32 *info_len)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, info);
>         union bpf_attr attr;
>         int err;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.info.bpf_fd = bpf_fd;
>         attr.info.info_len = *info_len;
>         attr.info.info = ptr_to_u64(info);
>
> -       err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, sizeof(attr));
> -
> +       err = sys_bpf(BPF_OBJ_GET_INFO_BY_FD, &attr, attr_sz);
>         if (!err)
>                 *info_len = attr.info.info_len;
> -
>         return libbpf_err_errno(err);
>  }
>
>  int bpf_raw_tracepoint_open(const char *name, int prog_fd)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, raw_tracepoint);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.raw_tracepoint.name = ptr_to_u64(name);
>         attr.raw_tracepoint.prog_fd = prog_fd;
>
> -       fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
> @@ -1048,16 +1075,18 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
>                       __u32 *prog_id, __u32 *fd_type, __u64 *probe_offset,
>                       __u64 *probe_addr)
>  {
> -       union bpf_attr attr = {};
> +       const size_t attr_sz = offsetofend(union bpf_attr, task_fd_query);
> +       union bpf_attr attr;
>         int err;
>
> +       memset(&attr, 0, attr_sz);
>         attr.task_fd_query.pid = pid;
>         attr.task_fd_query.fd = fd;
>         attr.task_fd_query.flags = flags;
>         attr.task_fd_query.buf = ptr_to_u64(buf);
>         attr.task_fd_query.buf_len = *buf_len;
>
> -       err = sys_bpf(BPF_TASK_FD_QUERY, &attr, sizeof(attr));
> +       err = sys_bpf(BPF_TASK_FD_QUERY, &attr, attr_sz);
>
>         *buf_len = attr.task_fd_query.buf_len;
>         *prog_id = attr.task_fd_query.prog_id;
> @@ -1070,30 +1099,32 @@ int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf, __u32 *buf_len,
>
>  int bpf_enable_stats(enum bpf_stats_type type)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, enable_stats);
>         union bpf_attr attr;
>         int fd;
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.enable_stats.type = type;
>
> -       fd = sys_bpf_fd(BPF_ENABLE_STATS, &attr, sizeof(attr));
> +       fd = sys_bpf_fd(BPF_ENABLE_STATS, &attr, attr_sz);
>         return libbpf_err_errno(fd);
>  }
>
>  int bpf_prog_bind_map(int prog_fd, int map_fd,
>                       const struct bpf_prog_bind_opts *opts)
>  {
> +       const size_t attr_sz = offsetofend(union bpf_attr, prog_bind_map);
>         union bpf_attr attr;
>         int ret;
>
>         if (!OPTS_VALID(opts, bpf_prog_bind_opts))
>                 return libbpf_err(-EINVAL);
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, attr_sz);
>         attr.prog_bind_map.prog_fd = prog_fd;
>         attr.prog_bind_map.map_fd = map_fd;
>         attr.prog_bind_map.flags = OPTS_GET(opts, flags, 0);
>
> -       ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, sizeof(attr));
> +       ret = sys_bpf(BPF_PROG_BIND_MAP, &attr, attr_sz);
>         return libbpf_err_errno(ret);
>  }
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 5f0281e61437..89f192a3ef77 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -4284,11 +4284,12 @@ int bpf_map__set_autocreate(struct bpf_map *map, bool autocreate)
>
>  int bpf_map__reuse_fd(struct bpf_map *map, int fd)
>  {
> -       struct bpf_map_info info = {};
> +       struct bpf_map_info info;
>         __u32 len = sizeof(info), name_len;
>         int new_fd, err;
>         char *new_name;
>
> +       memset(&info, 0, len);
>         err = bpf_obj_get_info_by_fd(fd, &info, &len);
>         if (err && errno == EINVAL)
>                 err = bpf_get_map_info_from_fdinfo(fd, &info);
> @@ -4830,13 +4831,12 @@ bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
>
>  static bool map_is_reuse_compat(const struct bpf_map *map, int map_fd)
>  {
> -       struct bpf_map_info map_info = {};
> +       struct bpf_map_info map_info;
>         char msg[STRERR_BUFSIZE];
> -       __u32 map_info_len;
> +       __u32 map_info_len = sizeof(map_info);
>         int err;
>
> -       map_info_len = sizeof(map_info);
> -
> +       memset(&map_info, 0, map_info_len);
>         err = bpf_obj_get_info_by_fd(map_fd, &map_info, &map_info_len);
>         if (err && errno == EINVAL)
>                 err = bpf_get_map_info_from_fdinfo(map_fd, &map_info);
> @@ -8994,11 +8994,12 @@ int libbpf_find_vmlinux_btf_id(const char *name,
>
>  static int libbpf_find_prog_btf_id(const char *name, __u32 attach_prog_fd)
>  {
> -       struct bpf_prog_info info = {};
> +       struct bpf_prog_info info;
>         __u32 info_len = sizeof(info);
>         struct btf *btf;
>         int err;
>
> +       memset(&info, 0, info_len);
>         err = bpf_obj_get_info_by_fd(attach_prog_fd, &info, &info_len);
>         if (err) {
>                 pr_warn("failed bpf_obj_get_info_by_fd for FD %d: %d\n",
> @@ -9826,13 +9827,16 @@ static int determine_uprobe_retprobe_bit(void)
>  static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>                                  uint64_t offset, int pid, size_t ref_ctr_off)
>  {
> -       struct perf_event_attr attr = {};
> +       const size_t attr_sz = sizeof(struct perf_event_attr);
> +       struct perf_event_attr attr;
>         char errmsg[STRERR_BUFSIZE];
>         int type, pfd;
>
>         if (ref_ctr_off >= (1ULL << PERF_UPROBE_REF_CTR_OFFSET_BITS))
>                 return -EINVAL;
>
> +       memset(&attr, 0, attr_sz);
> +
>         type = uprobe ? determine_uprobe_perf_type()
>                       : determine_kprobe_perf_type();
>         if (type < 0) {
> @@ -9853,7 +9857,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
>                 }
>                 attr.config |= 1 << bit;
>         }
> -       attr.size = sizeof(attr);
> +       attr.size = attr_sz;
>         attr.type = type;
>         attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
>         attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
> @@ -9952,7 +9956,8 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
>  static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
>                                          const char *kfunc_name, size_t offset, int pid)
>  {
> -       struct perf_event_attr attr = {};
> +       const size_t attr_sz = sizeof(struct perf_event_attr);
> +       struct perf_event_attr attr;
>         char errmsg[STRERR_BUFSIZE];
>         int type, pfd, err;
>
> @@ -9971,7 +9976,9 @@ static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
>                         libbpf_strerror_r(err, errmsg, sizeof(errmsg)));
>                 goto err_clean_legacy;
>         }
> -       attr.size = sizeof(attr);
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.size = attr_sz;
>         attr.config = type;
>         attr.type = PERF_TYPE_TRACEPOINT;
>
> @@ -10428,6 +10435,7 @@ static int determine_uprobe_perf_type_legacy(const char *probe_name, bool retpro
>  static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
>                                          const char *binary_path, size_t offset, int pid)
>  {
> +       const size_t attr_sz = sizeof(struct perf_event_attr);
>         struct perf_event_attr attr;
>         int type, pfd, err;
>
> @@ -10445,8 +10453,8 @@ static int perf_event_uprobe_open_legacy(const char *probe_name, bool retprobe,
>                 goto err_clean_legacy;
>         }
>
> -       memset(&attr, 0, sizeof(attr));
> -       attr.size = sizeof(attr);
> +       memset(&attr, 0, attr_sz);
> +       attr.size = attr_sz;
>         attr.config = type;
>         attr.type = PERF_TYPE_TRACEPOINT;
>
> @@ -10985,7 +10993,8 @@ static int determine_tracepoint_id(const char *tp_category,
>  static int perf_event_open_tracepoint(const char *tp_category,
>                                       const char *tp_name)
>  {
> -       struct perf_event_attr attr = {};
> +       const size_t attr_sz = sizeof(struct perf_event_attr);
> +       struct perf_event_attr attr;
>         char errmsg[STRERR_BUFSIZE];
>         int tp_id, pfd, err;
>
> @@ -10997,8 +11006,9 @@ static int perf_event_open_tracepoint(const char *tp_category,
>                 return tp_id;
>         }
>
> +       memset(&attr, 0, attr_sz);
>         attr.type = PERF_TYPE_TRACEPOINT;
> -       attr.size = sizeof(attr);
> +       attr.size = attr_sz;
>         attr.config = tp_id;
>
>         pfd = syscall(__NR_perf_event_open, &attr, -1 /* pid */, 0 /* cpu */,
> @@ -11618,12 +11628,15 @@ struct perf_buffer *perf_buffer__new(int map_fd, size_t page_cnt,
>                                      void *ctx,
>                                      const struct perf_buffer_opts *opts)
>  {
> +       const size_t attr_sz = sizeof(struct perf_event_attr);
>         struct perf_buffer_params p = {};
> -       struct perf_event_attr attr = {};
> +       struct perf_event_attr attr;
>
>         if (!OPTS_VALID(opts, perf_buffer_opts))
>                 return libbpf_err_ptr(-EINVAL);
>
> +       memset(&attr, 0, attr_sz);
> +       attr.size = attr_sz;
>         attr.config = PERF_COUNT_SW_BPF_OUTPUT;
>         attr.type = PERF_TYPE_SOFTWARE;
>         attr.sample_type = PERF_SAMPLE_RAW;
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 6c013168032d..35104580870c 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -587,11 +587,12 @@ static int get_tc_info(struct nlmsghdr *nh, libbpf_dump_nlmsg_t fn,
>
>  static int tc_add_fd_and_name(struct libbpf_nla_req *req, int fd)
>  {
> -       struct bpf_prog_info info = {};
> +       struct bpf_prog_info info;
>         __u32 info_len = sizeof(info);
>         char name[256];
>         int len, ret;
>
> +       memset(&info, 0, info_len);
>         ret = bpf_obj_get_info_by_fd(fd, &info, &info_len);
>         if (ret < 0)
>                 return ret;
> diff --git a/tools/lib/bpf/skel_internal.h b/tools/lib/bpf/skel_internal.h
> index bd6f4505e7b1..365d769e0357 100644
> --- a/tools/lib/bpf/skel_internal.h
> +++ b/tools/lib/bpf/skel_internal.h
> @@ -285,6 +285,8 @@ static inline int skel_link_create(int prog_fd, int target_fd,
>
>  static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>  {
> +       const size_t prog_load_attr_sz = offsetofend(union bpf_attr, fd_array);
> +       const size_t test_run_attr_sz = offsetofend(union bpf_attr, test);
>         int map_fd = -1, prog_fd = -1, key = 0, err;
>         union bpf_attr attr;
>
> @@ -302,7 +304,7 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>                 goto out;
>         }
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, prog_load_attr_sz);
>         attr.prog_type = BPF_PROG_TYPE_SYSCALL;
>         attr.insns = (long) opts->insns;
>         attr.insn_cnt = opts->insns_sz / sizeof(struct bpf_insn);
> @@ -313,18 +315,18 @@ static inline int bpf_load_and_run(struct bpf_load_and_run_opts *opts)
>         attr.log_size = opts->ctx->log_size;
>         attr.log_buf = opts->ctx->log_buf;
>         attr.prog_flags = BPF_F_SLEEPABLE;
> -       err = prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
> +       err = prog_fd = skel_sys_bpf(BPF_PROG_LOAD, &attr, prog_load_attr_sz);
>         if (prog_fd < 0) {
>                 opts->errstr = "failed to load loader prog";
>                 set_err;
>                 goto out;
>         }
>
> -       memset(&attr, 0, sizeof(attr));
> +       memset(&attr, 0, test_run_attr_sz);
>         attr.test.prog_fd = prog_fd;
>         attr.test.ctx_in = (long) opts->ctx;
>         attr.test.ctx_size_in = opts->ctx->sz;
> -       err = skel_sys_bpf(BPF_PROG_RUN, &attr, sizeof(attr));
> +       err = skel_sys_bpf(BPF_PROG_RUN, &attr, test_run_attr_sz);
>         if (err < 0 || (int)attr.test.retval < 0) {
>                 opts->errstr = "failed to execute loader prog";
>                 if (err < 0) {
> --
> 2.30.2
>
