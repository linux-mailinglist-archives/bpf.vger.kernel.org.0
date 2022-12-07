Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6BB64516E
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 02:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiLGBsK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 20:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLGBsJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 20:48:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670763057E
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 17:48:08 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id c7so12845159pfc.12
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 17:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mtzdkcORb1EnsyeAJY/81Q9kxUpdOUTXZJGpAb9Bb+A=;
        b=NoZTzgQc0EblOzS+d0vIFFbuMdqTnFTRpKXBFbHKuzYd5J+lXFQiGmnUG4y+7htlAi
         zAfvnwnmCC6gqfJKQvoRcxOpAPxIJcxYqaz1Q19Oq3HrNJxI8Vwbxn0oaraJm59kjll+
         Qinp+W+ryOp5dVk6EFDpfEDKt/R6nl2Uld18M1jfhQTAiI580G0fzkjwSrEjX0mbKcfk
         WCPbN6vOwNQeoBsjyZIk0r7v8WcwzVYvRg+m1M5RIR8cRLjLaO5xMxoKi91PsJfvmt11
         7RkAQliyg/lXYoF16yima8FD81+Nei5Fxb7dwLnixeAcU26lWnhD69Y1Nz/6UOl9SzU/
         8eqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtzdkcORb1EnsyeAJY/81Q9kxUpdOUTXZJGpAb9Bb+A=;
        b=trpCV6wBdlB8Nj7h9SN57702ryj4TSrfguLPqikzxW+JVZeFLI5h/xtpyvNnlKnKhY
         4laGF6eB8j42q4eVK0wcaMHMK6UyJuZegvd+J/h9Mr9RJOysBwqBK3blb3fMlb+ewI+5
         8Yt+MyCi6HdAk/oTNSat0cihE9IDf+nHel9BmCQ4oVAjCUu3Li5We38P/9RtbnGzrGxJ
         kLxjhP1MqiPWl9b/h6o6sVEG/1GwlAQXSfeC8v0sXTjXGglhoNZXekY1oq6rx9thS8Dk
         VU4x1DEDmhkQxfNC8eRPQnDZojMemWPk9pot/J//1uCvWj4KugtI8uKK8Xl9ZPVmVo6H
         r9/A==
X-Gm-Message-State: ANoB5pmGbxvcwMvL0+ftUWXeW5mpdH2iC+UqQmal8Iz4AII+wP7cr1vH
        sBaTSqoED+QJYDIg4ms09lE=
X-Google-Smtp-Source: AA0mqf4Wq98J0sRxP2a8oP1yyM+/I7Y/Nhx4qdc2DPu0XAcPN68mJpVOhmKqyMRkSL0J7ygWZqWCVg==
X-Received: by 2002:a62:f251:0:b0:577:ad:49c5 with SMTP id y17-20020a62f251000000b0057700ad49c5mr297653pfl.9.1670377687801;
        Tue, 06 Dec 2022 17:48:07 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id e9-20020aa79809000000b0056d98e31439sm12741166pfl.140.2022.12.06.17.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 17:48:07 -0800 (PST)
Date:   Tue, 6 Dec 2022 17:48:03 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 05/13] bpf: Add basic bpf_rb_{root,node} support
Message-ID: <Y4/w05hy7AF9RMLg@macbook-pro-6.dhcp.thefacebook.com>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-6-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-6-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 06, 2022 at 03:09:52PM -0800, Dave Marchevsky wrote:
>  
> +#define OWNER_FIELD_MASK (BPF_LIST_HEAD | BPF_RB_ROOT)
> +#define OWNEE_FIELD_MASK (BPF_LIST_NODE | BPF_RB_NODE)

One letter difference makes it so hard to review.
How about
GRAPH_ROOT_MASK
GRAPH_NODE_MASK
?

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
> +	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & OWNER_FIELD_MASK))
>  		return 0;
>  	for (i = 0; i < rec->cnt; i++) {
>  		struct btf_struct_meta *meta;
>  		u32 btf_id;
>  
> -		if (!(rec->fields[i].type & BPF_LIST_HEAD))
> +		if (!(rec->fields[i].type & OWNER_FIELD_MASK))
>  			continue;
>  		btf_id = rec->fields[i].datastructure_head.value_btf_id;
>  		meta = btf_find_struct_meta(btf, btf_id);
> @@ -3742,39 +3783,47 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>  			return -EFAULT;
>  		rec->fields[i].datastructure_head.value_rec = meta->record;
>  
> -		if (!(rec->field_mask & BPF_LIST_NODE))
> +		/* We need to set value_rec for all owner types, but no need
> +		 * to check ownership cycle for a type unless it's also an
> +		 * ownee type.
> +		 */
> +		if (!(rec->field_mask & OWNEE_FIELD_MASK))
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
> +		 *   has a bpf_{list,rb}_node. Let's call these ownee types.
>  		 * - A type can only _own_ another type in user BTF if it has a
> -		 *   bpf_list_head.
> +		 *   bpf_{list_head,rb_root}. Let's call these owner types.
>  		 *
> -		 * We ensure that if a type has both bpf_list_head and
> -		 * bpf_list_node, its element types cannot be owning types.
> +		 * We ensure that if a type is both an owner and ownee, its
> +		 * element types cannot be owner types.
>  		 *
>  		 * To ensure acyclicity:
>  		 *
> -		 * When A only has bpf_list_head, ownership chain can be:
> +		 * When A is an owner type but not an ownee, its ownership

and that would become:
When A is a root type, but not a node type...

reads easier.

> +		 * chain can be:
>  		 *	A -> B -> C
>  		 * Where:
> -		 * - B has both bpf_list_head and bpf_list_node.
> -		 * - C only has bpf_list_node.
> +		 * - A is an owner, e.g. has bpf_rb_root.
> +		 * - B is both an owner and ownee, e.g. has bpf_rb_node and
> +		 *   bpf_list_head.
> +		 * - C is only an owner, e.g. has bpf_list_node
>  		 *
> -		 * When A has both bpf_list_head and bpf_list_node, some other
> -		 * type already owns it in the BTF domain, hence it can not own
> -		 * another owning type through any of the bpf_list_head edges.
> +		 * When A is both an owner and ownee, some other type already
> +		 * owns it in the BTF domain, hence it can not own
> +		 * another owner type through any of the ownership edges.
>  		 *	A -> B
>  		 * Where:
> -		 * - B only has bpf_list_node.
> +		 * - A is both an owner and ownee.
> +		 * - B is only an ownee.
