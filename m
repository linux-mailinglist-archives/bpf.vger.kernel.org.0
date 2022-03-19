Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524B4E18EA
	for <lists+bpf@lfdr.de>; Sat, 19 Mar 2022 23:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiCSW7K (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Mar 2022 18:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiCSW7K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Mar 2022 18:59:10 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7571C18F218
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 15:57:48 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so11401326pjl.4
        for <bpf@vger.kernel.org>; Sat, 19 Mar 2022 15:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sJHuv5usLAA/v+e63iOmGiYL9g/TWUNP37AY5T8kxRA=;
        b=lqRPbxRM46ws0qTrjntwVIAmbd45ot0zAgX2zj6GCTZHIqoNzpyIeJT4ZHDRGeHTPE
         /ECahtAB20wPTIcEKtsEJU2cUflLYQLpjCpeLjcHdsvfE3SYOP7MYwOhb+/ah4XKKKQ2
         d3qssu0JIgIuBD2u/B5sDwJzj1Z7RjnCeFgoV4h00s9VoS61xq2MV+DXDiFl8YZDp4HB
         oAk20a82ZmbSqYRhpiSdA+KTlJxOv96O3DI/rBBWAwNSKpKOaHZkz3Re2rH/Hj7GJjHw
         kGlN0NX4T5nA9EgdsPd0CvX0Vs2eiIXUxIZmOSuGNlN9r3rFijctToba7NEBgkcWeiFj
         qaJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJHuv5usLAA/v+e63iOmGiYL9g/TWUNP37AY5T8kxRA=;
        b=grFPtpVGCu7z3qJ4Bwx8ewbM9tVx77WanF16L8uAShd45MLj5Id23ZLZdK9qg1UNEF
         +idgm9mvpkFgZOayqeObKYQuTbnttuCZ5xTmqgWvVgxD6dY4SH54TLK2MM1zSUZJg+T3
         1aBLhPmASpB7Kr4/Na1/vM5M7rQdhJ1dE95wF2q5czn6KvvT6q6c98ZIwDyq+zJLAtHQ
         Tbm3CeS6Ei3PfMNaEX0S1Rsl+y3Ksov8xqLlR3GLQcrkh2aHNwxhjgsVhs9z93m+prnb
         1CWvg+5fSvX1HZpO2z3NKUUs4fPhNN8f6XsGwyxbcyJXF3F0SuigZJ/4Jcuo4iSqcBlY
         p1kw==
X-Gm-Message-State: AOAM531YSaqu9E/oWxv/+Dpmnv8vaI6SRA9z+qqZhVIhEZyuU6t+9i0J
        rznvBTj+OZjcEl6uvQGPipCeSsEj2bk=
X-Google-Smtp-Source: ABdhPJxPO2kLsZIQc117l1STp6rOKeL9v0rOmeK8ItZFnmF9pgSsHDz4FmRssp+tg6USe4HNt5Y1mg==
X-Received: by 2002:a17:90a:b798:b0:1bd:652a:97b5 with SMTP id m24-20020a17090ab79800b001bd652a97b5mr18690314pjr.6.1647730667838;
        Sat, 19 Mar 2022 15:57:47 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:be42])
        by smtp.gmail.com with ESMTPSA id d5-20020a636805000000b003822c1305b6sm4747677pgc.23.2022.03.19.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 15:57:47 -0700 (PDT)
Date:   Sat, 19 Mar 2022 15:57:44 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH bpf-next v2 03/15] bpf: Allow storing unreferenced kptr
 in map
Message-ID: <20220319225744.xlebrwxerrw3isds@ast-mbp.dhcp.thefacebook.com>
References: <20220317115957.3193097-1-memxor@gmail.com>
 <20220317115957.3193097-4-memxor@gmail.com>
 <20220319181538.nbqdkprjrzkxk7v4@ast-mbp.dhcp.thefacebook.com>
 <20220319185251.4xqsrvjxeb7w5pwm@apollo>
 <20220319211754.rvekobxqd7ik2dsc@ast-mbp.dhcp.thefacebook.com>
 <20220319213920.m467eqze3iv4zfby@apollo>
 <20220319215046.u6fttplj5znzgoaf@apollo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319215046.u6fttplj5znzgoaf@apollo>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 20, 2022 at 03:20:46AM +0530, Kumar Kartikeya Dwivedi wrote:
> On Sun, Mar 20, 2022 at 03:09:20AM IST, Kumar Kartikeya Dwivedi wrote:
> > On Sun, Mar 20, 2022 at 02:47:54AM IST, Alexei Starovoitov wrote:
> > > On Sun, Mar 20, 2022 at 12:22:51AM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > On Sat, Mar 19, 2022 at 11:45:38PM IST, Alexei Starovoitov wrote:
> > > > > On Thu, Mar 17, 2022 at 05:29:45PM +0530, Kumar Kartikeya Dwivedi wrote:
> > > > > > This commit introduces a new pointer type 'kptr' which can be embedded
> > > > > > in a map value as holds a PTR_TO_BTF_ID stored by a BPF program during
> > > > > > its invocation. Storing to such a kptr, BPF program's PTR_TO_BTF_ID
> > > > > > register must have the same type as in the map value's BTF, and loading
> > > > > > a kptr marks the destination register as PTR_TO_BTF_ID with the correct
> > > > > > kernel BTF and BTF ID.
> > > > > >
> > > > > > Such kptr are unreferenced, i.e. by the time another invocation of the
> > > > > > BPF program loads this pointer, the object which the pointer points to
> > > > > > may not longer exist. Since PTR_TO_BTF_ID loads (using BPF_LDX) are
> > > > > > patched to PROBE_MEM loads by the verifier, it would safe to allow user
> > > > > > to still access such invalid pointer, but passing such pointers into
> > > > > > BPF helpers and kfuncs should not be permitted. A future patch in this
> > > > > > series will close this gap.
> > > > > >
> > > > > > The flexibility offered by allowing programs to dereference such invalid
> > > > > > pointers while being safe at runtime frees the verifier from doing
> > > > > > complex lifetime tracking. As long as the user may ensure that the
> > > > > > object remains valid, it can ensure data read by it from the kernel
> > > > > > object is valid.
> > > > > >
> > > > > > The user indicates that a certain pointer must be treated as kptr
> > > > > > capable of accepting stores of PTR_TO_BTF_ID of a certain type, by using
> > > > > > a BTF type tag 'kptr' on the pointed to type of the pointer. Then, this
> > > > > > information is recorded in the object BTF which will be passed into the
> > > > > > kernel by way of map's BTF information. The name and kind from the map
> > > > > > value BTF is used to look up the in-kernel type, and the actual BTF and
> > > > > > BTF ID is recorded in the map struct in a new kptr_off_tab member. For
> > > > > > now, only storing pointers to structs is permitted.
> > > > > >
> > > > > > An example of this specification is shown below:
> > > > > >
> > > > > > 	#define __kptr __attribute__((btf_type_tag("kptr")))
> > > > > >
> > > > > > 	struct map_value {
> > > > > > 		...
> > > > > > 		struct task_struct __kptr *task;
> > > > > > 		...
> > > > > > 	};
> > > > > >
> > > > > > Then, in a BPF program, user may store PTR_TO_BTF_ID with the type
> > > > > > task_struct into the map, and then load it later.
> > > > > >
> > > > > > Note that the destination register is marked PTR_TO_BTF_ID_OR_NULL, as
> > > > > > the verifier cannot know whether the value is NULL or not statically, it
> > > > > > must treat all potential loads at that map value offset as loading a
> > > > > > possibly NULL pointer.
> > > > > >
> > > > > > Only BPF_LDX, BPF_STX, and BPF_ST with insn->imm = 0 (to denote NULL)
> > > > > > are allowed instructions that can access such a pointer. On BPF_LDX, the
> > > > > > destination register is updated to be a PTR_TO_BTF_ID, and on BPF_STX,
> > > > > > it is checked whether the source register type is a PTR_TO_BTF_ID with
> > > > > > same BTF type as specified in the map BTF. The access size must always
> > > > > > be BPF_DW.
> > > > > >
> > > > > > For the map in map support, the kptr_off_tab for outer map is copied
> > > > > > from the inner map's kptr_off_tab. It was chosen to do a deep copy
> > > > > > instead of introducing a refcount to kptr_off_tab, because the copy only
> > > > > > needs to be done when paramterizing using inner_map_fd in the map in map
> > > > > > case, hence would be unnecessary for all other users.
> > > > > >
> > > > > > It is not permitted to use MAP_FREEZE command and mmap for BPF map
> > > > > > having kptr, similar to the bpf_timer case.
> > > > > >
> > > > > > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > > > > ---
> > > > > >  include/linux/bpf.h     |  29 +++++-
> > > > > >  include/linux/btf.h     |   2 +
> > > > > >  kernel/bpf/btf.c        | 151 +++++++++++++++++++++++++----
> > > > > >  kernel/bpf/map_in_map.c |   5 +-
> > > > > >  kernel/bpf/syscall.c    | 110 ++++++++++++++++++++-
> > > > > >  kernel/bpf/verifier.c   | 207 ++++++++++++++++++++++++++++++++--------
> > > > > >  6 files changed, 442 insertions(+), 62 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > > > > > index 88449fbbe063..f35920d279dd 100644
> > > > > > --- a/include/linux/bpf.h
> > > > > > +++ b/include/linux/bpf.h
> > > > > > @@ -155,6 +155,22 @@ struct bpf_map_ops {
> > > > > >  	const struct bpf_iter_seq_info *iter_seq_info;
> > > > > >  };
> > > > > >
> > > > > > +enum {
> > > > > > +	/* Support at most 8 pointers in a BPF map value */
> > > > > > +	BPF_MAP_VALUE_OFF_MAX = 8,
> > > > > > +};
> > > > > > +
> > > > > > +struct bpf_map_value_off_desc {
> > > > > > +	u32 offset;
> > > > > > +	u32 btf_id;
> > > > > > +	struct btf *btf;
> > > > > > +};
> > > > > > +
> > > > > > +struct bpf_map_value_off {
> > > > > > +	u32 nr_off;
> > > > > > +	struct bpf_map_value_off_desc off[];
> > > > > > +};
> > > > > > +
> > > > > >  struct bpf_map {
> > > > > >  	/* The first two cachelines with read-mostly members of which some
> > > > > >  	 * are also accessed in fast-path (e.g. ops, max_entries).
> > > > > > @@ -171,6 +187,7 @@ struct bpf_map {
> > > > > >  	u64 map_extra; /* any per-map-type extra fields */
> > > > > >  	u32 map_flags;
> > > > > >  	int spin_lock_off; /* >=0 valid offset, <0 error */
> > > > > > +	struct bpf_map_value_off *kptr_off_tab;
> > > > > >  	int timer_off; /* >=0 valid offset, <0 error */
> > > > > >  	u32 id;
> > > > > >  	int numa_node;
> > > > > > @@ -184,7 +201,7 @@ struct bpf_map {
> > > > > >  	char name[BPF_OBJ_NAME_LEN];
> > > > > >  	bool bypass_spec_v1;
> > > > > >  	bool frozen; /* write-once; write-protected by freeze_mutex */
> > > > > > -	/* 14 bytes hole */
> > > > > > +	/* 6 bytes hole */
> > > > > >
> > > > > >  	/* The 3rd and 4th cacheline with misc members to avoid false sharing
> > > > > >  	 * particularly with refcounting.
> > > > > > @@ -217,6 +234,11 @@ static inline bool map_value_has_timer(const struct bpf_map *map)
> > > > > >  	return map->timer_off >= 0;
> > > > > >  }
> > > > > >
> > > > > > +static inline bool map_value_has_kptr(const struct bpf_map *map)
> > > > > > +{
> > > > > > +	return !IS_ERR_OR_NULL(map->kptr_off_tab);
> > > > > > +}
> > > > > > +
> > > > > >  static inline void check_and_init_map_value(struct bpf_map *map, void *dst)
> > > > > >  {
> > > > > >  	if (unlikely(map_value_has_spin_lock(map)))
> > > > > > @@ -1497,6 +1519,11 @@ void bpf_prog_put(struct bpf_prog *prog);
> > > > > >  void bpf_prog_free_id(struct bpf_prog *prog, bool do_idr_lock);
> > > > > >  void bpf_map_free_id(struct bpf_map *map, bool do_idr_lock);
> > > > > >
> > > > > > +struct bpf_map_value_off_desc *bpf_map_kptr_off_contains(struct bpf_map *map, u32 offset);
> > > > > > +void bpf_map_free_kptr_off_tab(struct bpf_map *map);
> > > > > > +struct bpf_map_value_off *bpf_map_copy_kptr_off_tab(const struct bpf_map *map);
> > > > > > +bool bpf_map_equal_kptr_off_tab(const struct bpf_map *map_a, const struct bpf_map *map_b);
> > > > > > +
> > > > > >  struct bpf_map *bpf_map_get(u32 ufd);
> > > > > >  struct bpf_map *bpf_map_get_with_uref(u32 ufd);
> > > > > >  struct bpf_map *__bpf_map_get(struct fd f);
> > > > > > diff --git a/include/linux/btf.h b/include/linux/btf.h
> > > > > > index 36bc09b8e890..5b578dc81c04 100644
> > > > > > --- a/include/linux/btf.h
> > > > > > +++ b/include/linux/btf.h
> > > > > > @@ -123,6 +123,8 @@ bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
> > > > > >  			   u32 expected_offset, u32 expected_size);
> > > > > >  int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
> > > > > >  int btf_find_timer(const struct btf *btf, const struct btf_type *t);
> > > > > > +struct bpf_map_value_off *btf_find_kptr(const struct btf *btf,
> > > > > > +					const struct btf_type *t);
> > > > > >  bool btf_type_is_void(const struct btf_type *t);
> > > > > >  s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
> > > > > >  const struct btf_type *btf_type_skip_modifiers(const struct btf *btf,
> > > > > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > > > > index 5b2824332880..9ac9364ef533 100644
> > > > > > --- a/kernel/bpf/btf.c
> > > > > > +++ b/kernel/bpf/btf.c
> > > > > > @@ -3164,33 +3164,79 @@ static void btf_struct_log(struct btf_verifier_env *env,
> > > > > >  enum {
> > > > > >  	BTF_FIELD_SPIN_LOCK,
> > > > > >  	BTF_FIELD_TIMER,
> > > > > > +	BTF_FIELD_KPTR,
> > > > > > +};
> > > > > > +
> > > > > > +enum {
> > > > > > +	BTF_FIELD_IGNORE = 0,
> > > > > > +	BTF_FIELD_FOUND  = 1,
> > > > > >  };
> > > > > >
> > > > > >  struct btf_field_info {
> > > > > > +	const struct btf_type *type;
> > > > > >  	u32 off;
> > > > > >  };
> > > > > >
> > > > > >  static int btf_find_field_struct(const struct btf *btf, const struct btf_type *t,
> > > > > > -				 u32 off, int sz, struct btf_field_info *info)
> > > > > > +				 u32 off, int sz, struct btf_field_info *info,
> > > > > > +				 int info_cnt, int idx)
> > > > > >  {
> > > > > >  	if (!__btf_type_is_struct(t))
> > > > > > -		return 0;
> > > > > > +		return BTF_FIELD_IGNORE;
> > > > > >  	if (t->size != sz)
> > > > > > -		return 0;
> > > > > > -	if (info->off != -ENOENT)
> > > > > > -		/* only one such field is allowed */
> > > > > > +		return BTF_FIELD_IGNORE;
> > > > > > +	if (idx >= info_cnt)
> > > > >
> > > > > No need to pass info_cnt, idx into this function.
> > > > > Move idx >= info_cnt check into the caller and let
> > > > > caller do 'info++' and pass that.
> > > >
> > > > That was what I did initially, but this check actually needs to happen after we
> > > > see that the field is of interest (i.e. not ignored by btf_find_field_*). Doing
> > > > it in caller limits total fields to info_cnt. Moving those checks out into the
> > > > caller may be the other option, but I didn't like that. I can add a comment if
> > > > it makes things clear.
> > >
> > > don't increment info unconditionally?
> > > only when field is found.
> > >
> >
> > Right now the j++ happens only when we find a field. What I'm saying is that if
> > you now move the idx (which is j in caller) >= info_cnt out into the loop, later
> > iteration will return error even if it is not a timer, spin_lock, or kptr field,
> > so actual check is done inside the function after we know that for this specific
> > case it can only be a timer, spin_lock, or kptr, and we already have no more room
> > to record their info.
> >
> > e.g. there can be a case when we end up at j == info_cnt (all infos used), but
> > we still find a kptr, so we should only return error on seeing j == info_cnt
> > once we know that field is a kptr, because we reached the total limit of kptrs
> > in a map value.
> >
> 
> One other option might be doing the check in caller _after_ we see
> BTF_FIELD_FOUND, but this would require bumping the size to max + 1, so that the
> write to info inside the function doesn't write past the end of the array.

yep. Extra element in the array will work.
Or split btf_find_field_struct() into find and populate.
