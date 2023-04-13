Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C26E17D7
	for <lists+bpf@lfdr.de>; Fri, 14 Apr 2023 01:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjDMXEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Apr 2023 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjDMXEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Apr 2023 19:04:11 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C979A2
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:04:10 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id h24-20020a17090a9c1800b002404be7920aso16921890pjp.5
        for <bpf@vger.kernel.org>; Thu, 13 Apr 2023 16:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681427050; x=1684019050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fqC0FVfhOhqDc94ayEDEASDdt1g+dMscheybO9OfO8o=;
        b=AyOua4FsuCRIiXkoZckNAK/+NfzkFPYuGWEASGWWGLROVIs5SftfF/y98C2wC+tgxH
         FeLjW8/rw/fiB0WUXqOBMqUazB8BznnmTXmdehqvP3bhtGvUJJQ+J4V1kXIwSeYMJ0lG
         xgo9NEtZITQeK55hHMBW73MPWuo5b3K0q5Iac9COpjnRWLRECJbx1ihGyK5FPnM31Hw/
         6jFmaukD3u5yUjY2Qf+Hf//hTb2nYzPE8znjjrdkinx11vdy7fgQkbB/Jax4AaI1FDX7
         z+ZIcB9n4w6QahalqlJI4G5uMVEJBN011a4DgRpgvCdctWzJlYCv4KHgV58roxx7EQZj
         v8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681427050; x=1684019050;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqC0FVfhOhqDc94ayEDEASDdt1g+dMscheybO9OfO8o=;
        b=Wa8xZuf165sDnaXhMuDHpka5ff78he14HALWmvOmgfSJiE6DRiel3noum+Y5j4bLy7
         MXudmA42/Efr0shca871Ef9731qdE/CfgO+zY7xX3owaWn8rEnVAvWKamLx/eROPSGe8
         3LJJ0b9wwdVhaiGyeDXLN/qvBdYK1isaivosVHysBxVxOjaQ0q5l+DeC6w0lCKxI5sUF
         1EZ5UdqjaW4v2+XX1QTWJaus6Y0P1tBX1YZUz1Jn5Mhl3fZpvcLBOrG0gdvK9jqadnxv
         qPXzL/gpRkirvPd9r3QHz+oso2Fid9tD64Y32TMSM34eAv5HP8jdNhHOyz3U8dRgws7i
         z0+A==
X-Gm-Message-State: AAQBX9dOIlIqlTV1SEivLG4O+GON17+fgbpD6Yh4z/bjEQ2QYAAqV8I5
        2SrjTaAcial87p51t8MiDCI=
X-Google-Smtp-Source: AKy350ZCmBZ05Yf2kC5OunqB+qBbVIYzeYb+VYVnVNZxGJFyFaNg2fFJ191LZdEfNItzponmhy7+XQ==
X-Received: by 2002:a17:90a:6b01:b0:246:896a:40a3 with SMTP id v1-20020a17090a6b0100b00246896a40a3mr3444736pjj.45.1681427049802;
        Thu, 13 Apr 2023 16:04:09 -0700 (PDT)
Received: from dhcp-172-26-102-232.dhcp.thefacebook.com ([2620:10d:c090:400::5:5f5b])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902ead200b001a63d8902b6sm1967341pld.93.2023.04.13.16.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 16:04:09 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:04:07 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v1 bpf-next 8/9] bpf: Centralize btf_field-specific
 initialization logic
Message-ID: <20230413230407.zlpuoqi3h263this@dhcp-172-26-102-232.dhcp.thefacebook.com>
References: <20230410190753.2012798-1-davemarchevsky@fb.com>
 <20230410190753.2012798-9-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410190753.2012798-9-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 10, 2023 at 12:07:52PM -0700, Dave Marchevsky wrote:
> All btf_fields in an object are 0-initialized by memset in
> bpf_obj_init. This might not be a valid initial state for some field
> types, in which case kfuncs that use the type will properly initialize
> their input if it's been 0-initialized. Some BPF graph collection types
> and kfuncs do this: bpf_list_{head,node} and bpf_rb_node.
> 
> An earlier patch in this series added the bpf_refcount field, for which
> the 0 state indicates that the refcounted object should be free'd.
> bpf_obj_init treats this field specially, setting refcount to 1 instead
> of relying on scattered "refcount is 0? Must have just been initialized,
> let's set to 1" logic in kfuncs.
> 
> This patch extends this treatment to list and rbtree field types,
> allowing most scattered initialization logic in kfuncs to be removed.
> 
> Note that bpf_{list_head,rb_root} may be inside a BPF map, in which case
> they'll be 0-initialized without passing through the newly-added logic,
> so scattered initialization logic must remain for these collection root
> types.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
>  include/linux/bpf.h  | 38 ++++++++++++++++++++++++++++++++++----
>  kernel/bpf/helpers.c | 17 +++++++----------
>  2 files changed, 41 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4fc29f9aeaac..8e69948c4adb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -355,6 +355,39 @@ static inline u32 btf_field_type_align(enum btf_field_type type)
>  	}
>  }
>  
> +static inline void __bpf_obj_init_field(enum btf_field_type type, u32 size, void *addr)
> +{
> +	memset(addr, 0, size);
> +
> +	switch (type) {
> +	case BPF_REFCOUNT:
> +		refcount_set((refcount_t *)addr, 1);
> +		break;
> +	case BPF_RB_NODE:
> +		RB_CLEAR_NODE((struct rb_node *)addr);
> +		break;
> +	case BPF_LIST_HEAD:
> +	case BPF_LIST_NODE:
> +		INIT_LIST_HEAD((struct list_head *)addr);
> +		break;
> +	case BPF_RB_ROOT:
> +		/* RB_ROOT_CACHED 0-inits, no need to do anything after memset */
> +	case BPF_SPIN_LOCK:
> +	case BPF_TIMER:
> +	case BPF_KPTR_UNREF:
> +	case BPF_KPTR_REF:
> +		break;
> +	default:
> +		WARN_ON_ONCE(1);
> +		return;
> +	}
> +}
> +
> +static inline void bpf_obj_init_field(const struct btf_field *field, void *addr)
> +{
> +	__bpf_obj_init_field(field->type, field->size, addr);
> +}
> +
>  static inline bool btf_record_has_field(const struct btf_record *rec, enum btf_field_type type)
>  {
>  	if (IS_ERR_OR_NULL(rec))
> @@ -369,10 +402,7 @@ static inline void bpf_obj_init(const struct btf_record *rec, void *obj)
>  	if (IS_ERR_OR_NULL(rec))
>  		return;
>  	for (i = 0; i < rec->cnt; i++)
> -		memset(obj + rec->fields[i].offset, 0, rec->fields[i].size);
> -
> -	if (rec->refcount_off >= 0)
> -		refcount_set((refcount_t *)(obj + rec->refcount_off), 1);
> +		bpf_obj_init_field(&rec->fields[i], obj + rec->fields[i].offset);

this part make sense.

>  }
>  
>  /* 'dst' must be a temporary buffer and should not point to memory that is being
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6adbf99dc27f..1208fd8584c9 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1931,15 +1931,16 @@ __bpf_kfunc void *bpf_refcount_acquire_impl(void *p__refcounted_kptr, void *meta
>  	return (void *)p__refcounted_kptr;
>  }
>  
> +#define __init_field_infer_size(field_type, addr)\
> +	__bpf_obj_init_field(field_type, btf_field_type_size(field_type), addr)
> +
>  static int __bpf_list_add(struct bpf_list_node *node, struct bpf_list_head *head,
>  			  bool tail, struct btf_record *rec, u64 off)
>  {
>  	struct list_head *n = (void *)node, *h = (void *)head;
>  
>  	if (unlikely(!h->next))
> -		INIT_LIST_HEAD(h);
> -	if (unlikely(!n->next))
> -		INIT_LIST_HEAD(n);
> +		__init_field_infer_size(BPF_LIST_HEAD, h);

but this part is dubious.
What's the value? I think it's cleaner to keep it open coded with INIT_LIST_HEAD()
instead of hiding it through the helper.

>  	if (!list_empty(n)) {
>  		/* Only called from BPF prog, no need to migrate_disable */
>  		__bpf_obj_drop_impl(n - off, rec);
> @@ -1976,7 +1977,7 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
>  	struct list_head *n, *h = (void *)head;
>  
>  	if (unlikely(!h->next))
> -		INIT_LIST_HEAD(h);
> +		__init_field_infer_size(BPF_LIST_HEAD, h);

same here.

>  	if (list_empty(h))
>  		return NULL;
>  	n = tail ? h->prev : h->next;
> @@ -1984,6 +1985,8 @@ static struct bpf_list_node *__bpf_list_del(struct bpf_list_head *head, bool tai
>  	return (struct bpf_list_node *)n;
>  }
>  
> +#undef __init_field_infer_size
> +
>  __bpf_kfunc struct bpf_list_node *bpf_list_pop_front(struct bpf_list_head *head)
>  {
>  	return __bpf_list_del(head, false);
> @@ -2000,9 +2003,6 @@ __bpf_kfunc struct bpf_rb_node *bpf_rbtree_remove(struct bpf_rb_root *root,
>  	struct rb_root_cached *r = (struct rb_root_cached *)root;
>  	struct rb_node *n = (struct rb_node *)node;
>  
> -	if (!n->__rb_parent_color)
> -		RB_CLEAR_NODE(n);
> -
>  	if (RB_EMPTY_NODE(n))
>  		return NULL;
>  
> @@ -2022,9 +2022,6 @@ static int __bpf_rbtree_add(struct bpf_rb_root *root, struct bpf_rb_node *node,
>  	bpf_callback_t cb = (bpf_callback_t)less;
>  	bool leftmost = true;
>  
> -	if (!n->__rb_parent_color)
> -		RB_CLEAR_NODE(n);
> -
>  	if (!RB_EMPTY_NODE(n)) {
>  		/* Only called from BPF prog, no need to migrate_disable */
>  		__bpf_obj_drop_impl(n - off, rec);
> -- 
> 2.34.1
> 
