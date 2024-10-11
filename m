Return-Path: <bpf+bounces-41757-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1C999A91A
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 18:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75399B22040
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2024 16:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B0B199381;
	Fri, 11 Oct 2024 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1WCf18c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78EE7F9
	for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728665253; cv=none; b=Sn1tjLTRQ3rLEvhAJ+V4AX51MUXcYK92OU9WnTe7mhpgURJxm/Owm0BMbjdOrQ+mTktgIgMo2iGHNKS3CF+TEspR3TNYuah0ANqasljlvXIc7q8TX4tgZsP+EfIc+KqzIzfyWkAtCJ9z2nhkQeTQ+EpIVnhP2COUBeopfVG4iE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728665253; c=relaxed/simple;
	bh=h9Ac9c9/ip2lir6yiQg0hK2UFtvFAj4rvLJ+d3cFAfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mz4cYbovus+3KVTzDCvXGcMiUSpQr7WqSngDwS/3uvSzv+k2B4BJKI4pcWVKz2VJlNBU08J26sThBnHVPh6Dhl+IpUIQfcbD6Huq5t8tyxnElrM5aLaRufXs0XkogYmZU9sCJJgYYk8ndZFKiUWfpyhXkjVQP8sLxyPZuReZHEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1WCf18c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4311695c6c2so16359715e9.1
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2024 09:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728665250; x=1729270050; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DNmbv5K8xdeySNir4SFWw1md7ABqBBpHH0JNULbZK8A=;
        b=l1WCf18cXNSgpbiRqn23j7l4iN67X2puPlgFlary740RUQnShnQbaYn7iygz7NLnf7
         CeWK9G39MZ/ZUcMf0PyWgbRw58jgZL3464o57ZndlbquisZnsYkM6Ny7sBmcAwPTFeAL
         lEdvDHRNnIL43if3r7N3Q6RW1IghLuuH+JAMmwwYo0E4KaxGJy4H0/C/gvyhbQonIEEg
         JAD4m5WTuXkOW+obSJuKyxbRV8ttHLnXGx5hLC2PfmKF8zWWuvUmg06sBVQJ8+ArwYdI
         Dc0Yt2EFxFcoqU3MibHYVKtqO8D5E9CGBHrXKmPCG52GOwrYQYIPaoqB9yf7X06Tu0X2
         cAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728665250; x=1729270050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DNmbv5K8xdeySNir4SFWw1md7ABqBBpHH0JNULbZK8A=;
        b=nhk5s5FQvcx0MECZ9mXHWZjNeIxYrxUytNxRa9eko7Cqe4LfHYfO1qi8PBQt/Gyqn4
         jmw5l7TgbpQGWEfZ7WoE9BgpTMtSl06nS9xSAN3m6YGMvL1cdzmfKFC21xff3NohQz/d
         mD0bkRzuP/Fvl9lvLL7S0EbkMpXpxPvTv1ZKP98JzqgLcGxOqlje49pCPzAmx82cDlqN
         VOhqXtMAwh1rT2IX8CJOistjnOKd9xfJQSw10Pfz/6BC/WBnwJYgZsgZo2kCDzDThQdM
         dEO4YysGpfsPkNH6CuGgiQTndDAdKhXrxjlDBi2sk13RQsgzyVfuhqtNIrp5Q1UbQodg
         jrpw==
X-Gm-Message-State: AOJu0Yz6SjGuuqpuTc0k089zkRodFTYRwgTMF+3ttNpEQnaCiNqQGzok
	2snnChDwWQB7oFb8jgpYrISKUtYmBoldo1gGlf3WTJ9XpmJpJcEMz0fzDS9NaTjh50k68weAvKF
	KBboqzOH40t4i+2xSs1yLY6IVsFg=
X-Google-Smtp-Source: AGHT+IGJz9NQG4XDhgAep98KzJO4ILukF07lwLye/21Ks9Q03FxZcgRMp7caVJb+CsaIRVcjLdznHngf3Lft2JexGkk=
X-Received: by 2002:a05:6000:18a:b0:37d:41c5:a527 with SMTP id
 ffacd0b85a97d-37d5feaa088mr178860f8f.13.1728665249671; Fri, 11 Oct 2024
 09:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008091501.8302-1-houtao@huaweicloud.com> <20241008091501.8302-13-houtao@huaweicloud.com>
In-Reply-To: <20241008091501.8302-13-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 11 Oct 2024 09:47:18 -0700
Message-ID: <CAADnVQKSYzEVA2fPLOhZs6Bdz492wmVU9DAp4q0qLdTHYAhEEQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 12/16] bpf: Support basic operations for dynptr
 key in hash map
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 2:02=E2=80=AFAM Hou Tao <houtao@huaweicloud.com> wro=
te:
>
> From: Hou Tao <houtao1@huawei.com>
>
> The patch supports lookup, update, delete and lookup_delete operations
> for hash map with dynptr map. There are two major differences between
> the implementation of normal hash map and dynptr-keyed hash map:
>
> 1) dynptr-keyed hash map doesn't support pre-allocation.
> The reason is that the dynptr in map key is allocated dynamically
> through bpf mem allocator. The length limitation for these dynptrs is
> 4088 bytes now. Because there dynptrs are allocated dynamically, the
> consumption of memory will be smaller compared with normal hash map when
> there are big differences between the length of these dynptrs.
>
> 2) the freed element in dynptr-key map will not be reused immediately
> For normal hash map, the freed element may be reused immediately by the
> newly-added element, so the lookup may return an incorrect result due to
> element deletion and element reuse. However dynptr-key map could not do
> that, there are pointers (dynptrs) in the map key and the updates of
> these dynptrs are not atomic: both the address and the length of the
> dynptr will be updated. If the element is reused immediately, the access
> of the dynptr in the freed element may incur invalid memory access due
> to the mismatch between the address and the size of dynptr, so reuse the
> freed element after one RCU grace period.
>
> Beside the differences above, dynptr-keyed hash map also needs to handle
> the maybe-nullified dynptr in the map key.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/hashtab.c | 283 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 257 insertions(+), 26 deletions(-)
>
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index b14b87463ee0..edf19d36a413 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -88,6 +88,7 @@ struct bpf_htab {
>         struct bpf_map map;
>         struct bpf_mem_alloc ma;
>         struct bpf_mem_alloc pcpu_ma;
> +       struct bpf_mem_alloc dynptr_ma;
>         struct bucket *buckets;
>         void *elems;
>         union {
> @@ -425,6 +426,7 @@ static int htab_map_alloc_check(union bpf_attr *attr)
>         bool percpu_lru =3D (attr->map_flags & BPF_F_NO_COMMON_LRU);
>         bool prealloc =3D !(attr->map_flags & BPF_F_NO_PREALLOC);
>         bool zero_seed =3D (attr->map_flags & BPF_F_ZERO_SEED);
> +       bool dynptr_in_key =3D (attr->map_flags & BPF_F_DYNPTR_IN_KEY);
>         int numa_node =3D bpf_map_attr_numa_node(attr);
>
>         BUILD_BUG_ON(offsetof(struct htab_elem, fnode.next) !=3D
> @@ -438,6 +440,14 @@ static int htab_map_alloc_check(union bpf_attr *attr=
)
>             !bpf_map_flags_access_ok(attr->map_flags))
>                 return -EINVAL;
>
> +       if (dynptr_in_key) {
> +               if (percpu || lru || prealloc || !attr->map_extra)
> +                       return -EINVAL;
> +               if ((attr->map_extra >> 32) || bpf_dynptr_check_size(attr=
->map_extra) ||
> +                   bpf_mem_alloc_check_size(percpu, attr->map_extra))
> +                       return -E2BIG;
> +       }
> +
>         if (!lru && percpu_lru)
>                 return -EINVAL;
>
> @@ -482,6 +492,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
>          */
>         bool percpu_lru =3D (attr->map_flags & BPF_F_NO_COMMON_LRU);
>         bool prealloc =3D !(attr->map_flags & BPF_F_NO_PREALLOC);
> +       bool dynptr_in_key =3D (attr->map_flags & BPF_F_DYNPTR_IN_KEY);
>         struct bpf_htab *htab;
>         int err, i;
>
> @@ -598,6 +609,11 @@ static struct bpf_map *htab_map_alloc(union bpf_attr=
 *attr)
>                         if (err)
>                                 goto free_map_locked;
>                 }
> +               if (dynptr_in_key) {
> +                       err =3D bpf_mem_alloc_init(&htab->dynptr_ma, 0, f=
alse);
> +                       if (err)
> +                               goto free_map_locked;
> +               }
>         }
>
>         return &htab->map;
> @@ -610,6 +626,7 @@ static struct bpf_map *htab_map_alloc(union bpf_attr =
*attr)
>         for (i =3D 0; i < HASHTAB_MAP_LOCK_COUNT; i++)
>                 free_percpu(htab->map_locked[i]);
>         bpf_map_area_free(htab->buckets);
> +       bpf_mem_alloc_destroy(&htab->dynptr_ma);
>         bpf_mem_alloc_destroy(&htab->pcpu_ma);
>         bpf_mem_alloc_destroy(&htab->ma);
>  free_elem_count:
> @@ -620,13 +637,55 @@ static struct bpf_map *htab_map_alloc(union bpf_att=
r *attr)
>         return ERR_PTR(err);
>  }
>
> -static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrn=
d)
> +static inline u32 __htab_map_hash(const void *key, u32 key_len, u32 hash=
rnd)
>  {
>         if (likely(key_len % 4 =3D=3D 0))
>                 return jhash2(key, key_len / 4, hashrnd);
>         return jhash(key, key_len, hashrnd);
>  }
>
> +static u32 htab_map_dynptr_hash(const void *key, u32 key_len, u32 hashrn=
d,
> +                               const struct btf_record *rec)
> +{
> +       unsigned int i, cnt =3D rec->cnt;
> +       unsigned int hash =3D hashrnd;
> +       unsigned int offset =3D 0;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               const struct btf_field *field =3D &rec->fields[i];
> +               const struct bpf_dynptr_kern *kptr;
> +               unsigned int len;
> +
> +               if (field->type !=3D BPF_DYNPTR)
> +                       continue;
> +
> +               /* non-dynptr part ? */
> +               if (offset < field->offset)
> +                       hash =3D jhash(key + offset, field->offset - offs=
et, hash);
> +
> +               /* Skip nullified dynptr */
> +               kptr =3D key + field->offset;
> +               if (kptr->data) {
> +                       len =3D __bpf_dynptr_size(kptr);
> +                       hash =3D jhash(__bpf_dynptr_data(kptr, len), len,=
 hash);
> +               }
> +               offset =3D field->offset + field->size;
> +       }
> +
> +       if (offset < key_len)
> +               hash =3D jhash(key + offset, key_len - offset, hash);
> +
> +       return hash;
> +}
> +
> +static inline u32 htab_map_hash(const void *key, u32 key_len, u32 hashrn=
d,
> +                               const struct btf_record *rec)
> +{
> +       if (!rec)
> +               return __htab_map_hash(key, key_len, hashrnd);
> +       return htab_map_dynptr_hash(key, key_len, hashrnd, rec);
> +}
> +
>  static inline struct bucket *__select_bucket(struct bpf_htab *htab, u32 =
hash)
>  {
>         return &htab->buckets[hash & (htab->n_buckets - 1)];
> @@ -637,15 +696,68 @@ static inline struct hlist_nulls_head *select_bucke=
t(struct bpf_htab *htab, u32
>         return &__select_bucket(htab, hash)->head;
>  }
>
> +static bool is_same_dynptr_key(const void *key, const void *tgt, unsigne=
d int key_size,
> +                              const struct btf_record *rec)
> +{
> +       unsigned int i, cnt =3D rec->cnt;
> +       unsigned int offset =3D 0;
> +
> +       for (i =3D 0; i < cnt; i++) {
> +               const struct btf_field *field =3D &rec->fields[i];
> +               const struct bpf_dynptr_kern *kptr, *tgt_kptr;
> +               const void *data, *tgt_data;
> +               unsigned int len;
> +
> +               if (field->type !=3D BPF_DYNPTR)
> +                       continue;
> +
> +               if (offset < field->offset &&
> +                   memcmp(key + offset, tgt + offset, field->offset - of=
fset))
> +                       return false;
> +
> +               /*
> +                * For a nullified dynptr in the target key, __bpf_dynptr=
_size()
> +                * will return 0, and there will be no match for the targ=
et key.
> +                */
> +               kptr =3D key + field->offset;
> +               tgt_kptr =3D tgt + field->offset;
> +               len =3D __bpf_dynptr_size(kptr);
> +               if (len !=3D __bpf_dynptr_size(tgt_kptr))
> +                       return false;
> +
> +               data =3D __bpf_dynptr_data(kptr, len);
> +               tgt_data =3D __bpf_dynptr_data(tgt_kptr, len);
> +               if (memcmp(data, tgt_data, len))
> +                       return false;
> +
> +               offset =3D field->offset + field->size;
> +       }
> +
> +       if (offset < key_size &&
> +           memcmp(key + offset, tgt + offset, key_size - offset))
> +               return false;
> +
> +       return true;
> +}
> +
> +static inline bool htab_is_same_key(const void *key, const void *tgt, un=
signed int key_size,
> +                                   const struct btf_record *rec)
> +{
> +       if (!rec)
> +               return !memcmp(key, tgt, key_size);
> +       return is_same_dynptr_key(key, tgt, key_size, rec);
> +}
> +
>  /* this lookup function can only be called with bucket lock taken */
>  static struct htab_elem *lookup_elem_raw(struct hlist_nulls_head *head, =
u32 hash,
> -                                        void *key, u32 key_size)
> +                                        void *key, u32 key_size,
> +                                        const struct btf_record *record)
>  {
>         struct hlist_nulls_node *n;
>         struct htab_elem *l;
>
>         hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -               if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> +               if (l->hash =3D=3D hash && htab_is_same_key(l->key, key, =
key_size, record))
>                         return l;
>
>         return NULL;
> @@ -657,14 +769,15 @@ static struct htab_elem *lookup_elem_raw(struct hli=
st_nulls_head *head, u32 hash
>   */
>  static struct htab_elem *lookup_nulls_elem_raw(struct hlist_nulls_head *=
head,
>                                                u32 hash, void *key,
> -                                              u32 key_size, u32 n_bucket=
s)
> +                                              u32 key_size, u32 n_bucket=
s,
> +                                              const struct btf_record *r=
ecord)
>  {
>         struct hlist_nulls_node *n;
>         struct htab_elem *l;
>
>  again:
>         hlist_nulls_for_each_entry_rcu(l, n, head, hash_node)
> -               if (l->hash =3D=3D hash && !memcmp(&l->key, key, key_size=
))
> +               if (l->hash =3D=3D hash && htab_is_same_key(l->key, key, =
key_size, record))
>                         return l;

If I'm reading this correctly the support for dynptr in map keys
adds two map->key_record !=3D NULL checks in the fast path,
hence what you said in cover letter:

> It seems adding dynptr key support in hash map degrades the lookup
> performance about 12% and degrades the update performance about 7%. Will
> investigate these degradation first.
>
> a) lookup
> max_entries =3D 8K
>
> before:
> 0:hash_lookup 72347325 lookups per sec
>
> after:
> 0:hash_lookup 64758890 lookups per sec

is surprising.

Two conditional branches contribute to 12% performance loss?
Something fishy.
Try unlikely() to hopefully recover most of it.
After analyzing 'perf report/annotate', of course.

Worst case we can specialize htab_map_gen_lookup() to
call into different helpers.

