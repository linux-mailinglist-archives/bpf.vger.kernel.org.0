Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835BD5742DA
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 06:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235658AbiGNE1N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 00:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234939AbiGNE0i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 00:26:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDBA2AC6E
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 21:23:47 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bp15so1238549ejb.6
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 21:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+FD+ZoyOFDRl+p7CKGL6xX7v32Ezc47RplJfYciA3Q=;
        b=Qoy3+XwIicxtwNr9VHXzOD2QwNAvQH1umP3m3Lg6rn9vuo2s5E9DC6dI1zw6BKcalf
         QIjCr0F7VV8d4HgLMtvfy1h6/oi+qk9TBYRNDidPBj+hpRKkbwdk6MVRhb3CpSEfRhXq
         UhnXnRpx0nxkec1C0H9/8SFonRpBLGkvciza7mnRHPfn3XIRTwbb/8HmmmZGVVbQ9JiR
         QizDdVE30ZTbmXV0iQHutvXwIY5SkIb/wvkMFq51woVK5i+uJ7I4dMDiVS6OwB//qHpr
         tLeS7SIW2e3cKrUP/ISOoMGFb7pUu2YDyz+q6pkoZe/1N/rOkHgkRVwp8M2lLDLwoN/R
         hGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+FD+ZoyOFDRl+p7CKGL6xX7v32Ezc47RplJfYciA3Q=;
        b=5pnMcIdpBzJXr4ZnanW+zwWgx3cqk/9tmInCWU8xeHIZ4nG2w9IfCS+kgrTOfYtVeG
         fnlkURdKM8JlVgRVY0j31S1DenNzEpsE49hxX17yD/93htrdJzXmPZrwkNKSaNpnt7u+
         pwnCq6sQkD2AQ1pdt1Epru8JohBzQq5EkkBPHPWIQ6DRFa16Azzg0MlrmbOk26fKbeDx
         0659A6DFqpzR6XY4v3LzGTAPJj17hqKtKomD7OLLpcg7ORQ3MOw3keeLDzkp7ADwW0UT
         MKnM0qM7BDWoTftSnlHR3+z0P79FZJ0p0oZ13o9FoQuBN7qYcWpAubT8qJX+B2oZVjbr
         KogA==
X-Gm-Message-State: AJIora9n0+vb/29YHMyLG1UKPuRFKO0OGPX+vU+/bjgH5f8QBae89VBa
        n7hsMO+1wwGLx/An8OvmD8N/+ieFfd/46UiWDDM=
X-Google-Smtp-Source: AGRyM1s5EocNWIhTnlfuFCB/XGWLS4hPhYDuAfQPvbKKtNIcgpWFvoRhJ9HfED6kwvz2Jum+L11jdLiH0NQjfQLLOqg=
X-Received: by 2002:a17:907:2ccc:b0:72b:6907:fce6 with SMTP id
 hg12-20020a1709072ccc00b0072b6907fce6mr6658787ejc.115.1657772626272; Wed, 13
 Jul 2022 21:23:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657576063.git.delyank@fb.com> <37859ca03aaaba23f60288de044a3a10d52a79b4.1657576063.git.delyank@fb.com>
In-Reply-To: <37859ca03aaaba23f60288de044a3a10d52a79b4.1657576063.git.delyank@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 13 Jul 2022 21:23:35 -0700
Message-ID: <CAEf4BzbSVL_aQ2kBT4785Y_30NZ9gVP8zPbaY=Kpi7Q8AbvgOQ@mail.gmail.com>
Subject: Re: [PATCH RFC bpf-next 1/3] bpf: allow maps to hold bpf_delayed_work fields
To:     Delyan Kratunov <delyank@fb.com>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
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

On Mon, Jul 11, 2022 at 2:48 PM Delyan Kratunov <delyank@fb.com> wrote:
>
> Similarly to bpf_timer, bpf_delayed_work represents a callback that will
> be executed at a later time, in a different execution context.
>
> Its treatment in maps is practically the same as timers (to a degree
> that perhaps calls for refactoring), except releasing the work does not
> need to release any resources - we will wait for pending executions in
> the program destruction path.
>
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  include/linux/bpf.h            |  9 ++++++++-
>  include/linux/btf.h            |  1 +
>  include/uapi/linux/bpf.h       |  8 ++++++++
>  kernel/bpf/btf.c               | 21 +++++++++++++++++++++
>  kernel/bpf/syscall.c           | 24 ++++++++++++++++++++++--
>  kernel/bpf/verifier.c          |  9 +++++++++
>  tools/include/uapi/linux/bpf.h |  8 ++++++++
>  7 files changed, 77 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 0edd7d2c0064..ad9d2cfb0411 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -164,7 +164,8 @@ enum {
>         BPF_MAP_VALUE_OFF_MAX = 8,
>         BPF_MAP_OFF_ARR_MAX   = BPF_MAP_VALUE_OFF_MAX +
>                                 1 + /* for bpf_spin_lock */
> -                               1,  /* for bpf_timer */
> +                               1 + /* for bpf_timer */
> +                               1,  /* for bpf_delayed_work */
>  };
>
>  enum bpf_kptr_type {
> @@ -212,6 +213,7 @@ struct bpf_map {
>         int spin_lock_off; /* >=0 valid offset, <0 error */
>         struct bpf_map_value_off *kptr_off_tab;
>         int timer_off; /* >=0 valid offset, <0 error */
> +       int delayed_work_off; /* >=0 valid offset, <0 error */
>         u32 id;
>         int numa_node;
>         u32 btf_key_type_id;
> @@ -256,6 +258,11 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
>         return map->timer_off >= 0;
>  }
>
> +static inline bool map_value_has_delayed_work(const struct bpf_map *map)
> +{
> +       return map->delayed_work_off >= 0;
> +}
> +
>  static inline bool map_value_has_kptrs(const struct bpf_map *map)
>  {
>         return !IS_ERR_OR_NULL(map->kptr_off_tab);
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index 1bfed7fa0428..2b8f473a6aa0 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -132,6 +132,7 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>                            u32 expected_offset, u32 expected_size);
>  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
>  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> +int btf_find_delayed_work(const struct btf *btf, const struct btf_type *t);
>  struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>                                           const struct btf_type *t);
>  bool btf_type_is_void(const struct btf_type *t);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e81362891596..d68fc4f472f1 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6691,6 +6691,14 @@ struct bpf_dynptr {
>         __u64 :64;
>  } __attribute__((aligned(8)));
>
> +struct bpf_delayed_work {
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +} __attribute__((aligned(8)));
> +
>  struct bpf_sysctl {
>         __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
>                                  * Allows 1,2,4-byte read, but no write.
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index f08037c31dd7..e4ab52cc25fe 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3196,6 +3196,7 @@ enum btf_field_type {
>         BTF_FIELD_SPIN_LOCK,
>         BTF_FIELD_TIMER,
>         BTF_FIELD_KPTR,
> +       BTF_FIELD_DELAYED_WORK,
>  };
>
>  enum {
> @@ -3283,6 +3284,7 @@ static int btf_find_struct_field(const struct btf *btf, const struct btf_type *t
>                 switch (field_type) {
>                 case BTF_FIELD_SPIN_LOCK:
>                 case BTF_FIELD_TIMER:
> +               case BTF_FIELD_DELAYED_WORK:
>                         ret = btf_find_struct(btf, member_type, off, sz,
>                                               idx < info_cnt ? &info[idx] : &tmp);
>                         if (ret < 0)
> @@ -3333,6 +3335,7 @@ static int btf_find_datasec_var(const struct btf *btf, const struct btf_type *t,
>                 switch (field_type) {
>                 case BTF_FIELD_SPIN_LOCK:
>                 case BTF_FIELD_TIMER:
> +               case BTF_FIELD_DELAYED_WORK:
>                         ret = btf_find_struct(btf, var_type, off, sz,
>                                               idx < info_cnt ? &info[idx] : &tmp);
>                         if (ret < 0)
> @@ -3375,6 +3378,11 @@ static int btf_find_field(const struct btf *btf, const struct btf_type *t,
>                 sz = sizeof(struct bpf_timer);
>                 align = __alignof__(struct bpf_timer);
>                 break;
> +       case BTF_FIELD_DELAYED_WORK:
> +               name = "bpf_delayed_work";
> +               sz = sizeof(struct bpf_delayed_work);
> +               align = __alignof__(struct bpf_delayed_work);
> +               break;
>         case BTF_FIELD_KPTR:
>                 name = NULL;
>                 sz = sizeof(u64);
> @@ -3421,6 +3429,19 @@ int btf_find_timer(const struct btf *btf, const struct btf_type *t)
>         return info.off;
>  }
>
> +int btf_find_delayed_work(const struct btf *btf, const struct btf_type *t)
> +{
> +       struct btf_field_info info;
> +       int ret;
> +
> +       ret = btf_find_field(btf, t, BTF_FIELD_DELAYED_WORK, &info, 1);
> +       if (ret < 0)
> +               return ret;
> +       if (!ret)
> +               return -ENOENT;
> +       return info.off;
> +}
> +
>  struct bpf_map_value_off *btf_parse_kptrs(const struct btf *btf,
>                                           const struct btf_type *t)
>  {
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7d5af5b99f0d..041972305344 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -914,10 +914,11 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
>         bool has_spin_lock = map_value_has_spin_lock(map);
>         bool has_timer = map_value_has_timer(map);
>         bool has_kptrs = map_value_has_kptrs(map);
> +       bool has_delayed_work = map_value_has_delayed_work(map);
>         struct bpf_map_off_arr *off_arr;
>         u32 i;
>
> -       if (!has_spin_lock && !has_timer && !has_kptrs) {
> +       if (!has_spin_lock && !has_timer && !has_kptrs && !has_delayed_work) {
>                 map->off_arr = NULL;
>                 return 0;
>         }
> @@ -953,6 +954,13 @@ static int bpf_map_alloc_off_arr(struct bpf_map *map)
>                 }
>                 off_arr->cnt += tab->nr_off;
>         }
> +       if (has_delayed_work) {
> +               i = off_arr->cnt;
> +
> +               off_arr->field_off[i] = map->delayed_work_off;
> +               off_arr->field_sz[i] = sizeof(struct bpf_delayed_work);
> +               off_arr->cnt++;
> +       }
>
>         if (off_arr->cnt == 1)
>                 return 0;
> @@ -1014,6 +1022,16 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
>                         return -EOPNOTSUPP;
>         }
>
> +       map->delayed_work_off = btf_find_delayed_work(btf, value_type);
> +       if (map_value_has_delayed_work(map)) {
> +               if (map->map_flags & BPF_F_RDONLY_PROG)
> +                       return -EACCES;
> +               if (map->map_type != BPF_MAP_TYPE_HASH &&
> +                   map->map_type != BPF_MAP_TYPE_LRU_HASH &&
> +                   map->map_type != BPF_MAP_TYPE_ARRAY)
> +                       return -EOPNOTSUPP;
> +       }
> +
>         map->kptr_off_tab = btf_parse_kptrs(btf, value_type);
>         if (map_value_has_kptrs(map)) {
>                 if (!bpf_capable()) {
> @@ -1095,6 +1113,7 @@ static int map_create(union bpf_attr *attr)
>
>         map->spin_lock_off = -EINVAL;
>         map->timer_off = -EINVAL;
> +       map->delayed_work_off = -EINVAL;
>         if (attr->btf_key_type_id || attr->btf_value_type_id ||
>             /* Even the map's value is a kernel's struct,
>              * the bpf_prog.o must have BTF to begin with
> @@ -1863,7 +1882,8 @@ static int map_freeze(const union bpf_attr *attr)
>                 return PTR_ERR(map);
>
>         if (map->map_type == BPF_MAP_TYPE_STRUCT_OPS ||
> -           map_value_has_timer(map) || map_value_has_kptrs(map)) {
> +           map_value_has_timer(map) || map_value_has_kptrs(map) ||
> +           map_value_has_delayed_work(map)) {

not introduced by you, but shouldn't this check also check
map_value_has_spinlock()?

>                 fdput(f);
>                 return -ENOTSUPP;
>         }

Also check if you need to modify bpf_map_mmap?


> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2859901ffbe3..9fd311b7a1ff 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3817,6 +3817,15 @@ static int check_map_access(struct bpf_verifier_env *env, u32 regno,
>                         return -EACCES;
>                 }
>         }
> +       if (map_value_has_delayed_work(map) && src == ACCESS_DIRECT) {
> +               u32 t = map->delayed_work_off;
> +
> +               if (reg->smin_value + off < t + sizeof(struct bpf_delayed_work) &&
> +                    t < reg->umax_value + off + size) {
> +                       verbose(env, "bpf_delayed_work cannot be accessed directly by load/store regno=%d off=%d\n", regno, off);
> +                       return -EACCES;
> +               }
> +       }
>         if (map_value_has_kptrs(map)) {
>                 struct bpf_map_value_off *tab = map->kptr_off_tab;
>                 int i;
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index e81362891596..d68fc4f472f1 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6691,6 +6691,14 @@ struct bpf_dynptr {
>         __u64 :64;
>  } __attribute__((aligned(8)));
>
> +struct bpf_delayed_work {
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +       __u64 :64;
> +} __attribute__((aligned(8)));
> +
>  struct bpf_sysctl {
>         __u32   write;          /* Sysctl is being read (= 0) or written (= 1).
>                                  * Allows 1,2,4-byte read, but no write.
> --
> 2.36.1
