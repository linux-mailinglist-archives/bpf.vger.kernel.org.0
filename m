Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9C36920A9
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 15:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjBJOSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 09:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232434AbjBJOSW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 09:18:22 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDEA30E98
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:18:20 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id fi26so4836066edb.7
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuZsVNSNo7wg8UTPxpuHXZJSgHI2v8msj2ITKl1Ovc8=;
        b=QhJStUT0+AG825S2iFuvcyv6o0+v+vCc1vNIAWxggVG4ggCxBgntpDzRe6f01gxhWF
         tgbgwVt7mOVrisGIhvEo1ilDhFD5moiD2YiL4QC2Ak2sCimQPqxguxEis9KmtwdK7pYr
         RjZ0Yc24ydLhuqyyZDz+UnSxvHd4MtKIGerMafaZmgOulaSz2WK1SClJMDWkUQboVdtB
         0oe0TgBaR5/58YvAcajT9/gj+0D9YRQq4La133rIF/xHMtv66KxRoFSsfnxNuTP5nb6B
         BGbYBjSEcYCqOXhJU6zmmv9cbKLb1SFtStN/ESceaFHz0Kv+LNE8bLJgt0By8vROht7W
         guPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuZsVNSNo7wg8UTPxpuHXZJSgHI2v8msj2ITKl1Ovc8=;
        b=qIpBtLc4aaVGaupgjfLznn02kUUwo2oB03kyYYN8UAoG+JgqQtYS0swyPK4qmIbk20
         SDEgREoN6X04oQ+gYGPC0kUu0pwPF7GXVfSiYCaJtVKA3SCWvJlxQJJOvqXtOZ2AH//z
         n1H65TgUANGGX0+1QO0YTFTycaTLYtZqfOS+srVdzlifvyHGJBXfIvmJxMRVgoVmzRLX
         4Xbx7+sUuptPnhx9UAAG3peCtetf7qjubrlSXGUIlquW7IUY39aIlXarc8wT5R5wBrgo
         7zYLjaJD3xZxDwO/Rmn1tdpd3H2ySdRn4cCXBmbco1/I9zSx9Af1mOWhVzOgY3YmvYnt
         Snmg==
X-Gm-Message-State: AO0yUKXGSvlrBPKeUb8BkO4EkYSM9hj79+ctaU2MYBl9fjO5mh1MnGLC
        PRhJW8hrNeTSGQ7PDqQTlc1elHn11gYPQQ==
X-Google-Smtp-Source: AK7set/rLpRu0Vah+yK87qkkU0oy3mg7ZWYdUTHbgiOHjvgRWnDoDoKjPtwFulecUbgL+tfq18FH8Q==
X-Received: by 2002:a50:cdc2:0:b0:4ab:d0de:f7ec with SMTP id h2-20020a50cdc2000000b004abd0def7ecmr1135764edj.5.1676038699265;
        Fri, 10 Feb 2023 06:18:19 -0800 (PST)
Received: from localhost ([2001:620:618:580:2:80b3:0:2d0])
        by smtp.gmail.com with ESMTPSA id n2-20020a5099c2000000b0048ecd372fc9sm2289326edb.2.2023.02.10.06.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 06:18:18 -0800 (PST)
Date:   Fri, 10 Feb 2023 15:18:17 +0100
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v4 bpf-next 04/11] bpf: Add basic bpf_rb_{root,node}
 support
Message-ID: <20230210141817.idcbotzn4uof4yfu@apollo>
References: <20230209174144.3280955-1-davemarchevsky@fb.com>
 <20230209174144.3280955-5-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230209174144.3280955-5-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 09, 2023 at 06:41:37PM CET, Dave Marchevsky wrote:
> This patch adds special BPF_RB_{ROOT,NODE} btf_field_types similar to
> BPF_LIST_{HEAD,NODE}, adds the necessary plumbing to detect the new
> types, and adds bpf_rb_root_free function for freeing bpf_rb_root in
> map_values.
>
> structs bpf_rb_root and bpf_rb_node are opaque types meant to
> obscure structs rb_root_cached rb_node, respectively.
>
> btf_struct_access will prevent BPF programs from touching these special
> fields automatically now that they're recognized.
>
> btf_check_and_fixup_fields now groups list_head and rb_root together as
> "graph root" fields and {list,rb}_node as "graph node", and does same
> ownership cycle checking as before. Note that this function does _not_
> prevent ownership type mixups (e.g. rb_root owning list_node) - that's
> handled by btf_parse_graph_root.
>
> After this patch, a bpf program can have a struct bpf_rb_root in a
> map_value, but not add anything to nor do anything useful with it.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---
> [...]
> +#define GRAPH_ROOT_MASK (BPF_LIST_HEAD | BPF_RB_ROOT)
> +#define GRAPH_NODE_MASK (BPF_LIST_NODE | BPF_RB_NODE)
> +
>  int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>  {
>  	int i;
>
> -	/* There are two owning types, kptr_ref and bpf_list_head. The former
> -	 * only supports storing kernel types, which can never store references
> -	 * to program allocated local types, atleast not yet. Hence we only need
> -	 * to ensure that bpf_list_head ownership does not form cycles.
> +	/* There are three types that signify ownership of some other type:
> +	 *  kptr_ref, bpf_list_head, bpf_rb_root.
> +	 * kptr_ref only supports storing kernel types, which can't store
> +	 * references to program allocated local types.
> +	 *
> +	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
> +	 * does not form cycles.
>  	 */
> -	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_LIST_HEAD))
> +	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & GRAPH_ROOT_MASK))
>  		return 0;
>  	for (i = 0; i < rec->cnt; i++) {
>  		struct btf_struct_meta *meta;
>  		u32 btf_id;
>
> -		if (!(rec->fields[i].type & BPF_LIST_HEAD))
> +		if (!(rec->fields[i].type & GRAPH_ROOT_MASK))
>  			continue;
>  		btf_id = rec->fields[i].graph_root.value_btf_id;
>  		meta = btf_find_struct_meta(btf, btf_id);
> @@ -3762,39 +3803,47 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>  			return -EFAULT;
>  		rec->fields[i].graph_root.value_rec = meta->record;
>
> -		if (!(rec->field_mask & BPF_LIST_NODE))
> +		/* We need to set value_rec for all root types, but no need
> +		 * to check ownership cycle for a type unless it's also a
> +		 * node type.
> +		 */
> +		if (!(rec->field_mask & GRAPH_NODE_MASK))
>  			continue;
>
>  		/* We need to ensure ownership acyclicity among all types. The
>  		 * proper way to do it would be to topologically sort all BTF
>  		 * IDs based on the ownership edges, since there can be multiple
> -		 * bpf_list_head in a type. Instead, we use the following
> -		 * reasoning:
> +		 * bpf_{list_head,rb_node} in a type. Instead, we use the
> +		 * following resaoning:
>  		 *
>  		 * - A type can only be owned by another type in user BTF if it
> -		 *   has a bpf_list_node.
> +		 *   has a bpf_{list,rb}_node. Let's call these node types.
>  		 * - A type can only _own_ another type in user BTF if it has a
> -		 *   bpf_list_head.
> +		 *   bpf_{list_head,rb_root}. Let's call these root types.
>  		 *
> -		 * We ensure that if a type has both bpf_list_head and
> -		 * bpf_list_node, its element types cannot be owning types.
> +		 * We ensure that if a type is both a root and node, its
> +		 * element types cannot be root types.
>  		 *
>  		 * To ensure acyclicity:
>  		 *
> -		 * When A only has bpf_list_head, ownership chain can be:
> +		 * When A is an root type but not a node, its ownership
> +		 * chain can be:
>  		 *	A -> B -> C
>  		 * Where:
> -		 * - B has both bpf_list_head and bpf_list_node.
> -		 * - C only has bpf_list_node.
> +		 * - A is an root, e.g. has bpf_rb_root.
> +		 * - B is both a root and node, e.g. has bpf_rb_node and
> +		 *   bpf_list_head.
> +		 * - C is only an root, e.g. has bpf_list_node
>  		 *
> -		 * When A has both bpf_list_head and bpf_list_node, some other
> -		 * type already owns it in the BTF domain, hence it can not own
> -		 * another owning type through any of the bpf_list_head edges.
> +		 * When A is both a root and node, some other type already
> +		 * owns it in the BTF domain, hence it can not own
> +		 * another root type through any of the ownership edges.
>  		 *	A -> B
>  		 * Where:
> -		 * - B only has bpf_list_node.
> +		 * - A is both an root and node.
> +		 * - B is only an node.
>  		 */
> -		if (meta->record->field_mask & BPF_LIST_HEAD)
> +		if (meta->record->field_mask & GRAPH_ROOT_MASK)
>  			return -ELOOP;

While you are at it, can you include BTF selftests (similar to what linked list
tests are doing in test_btf) to ensure all of this being correctly rejected for
rbtree and mixed rbtree + list cases?
