Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4F65894D
	for <lists+bpf@lfdr.de>; Thu, 29 Dec 2022 05:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiL2EAh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 23:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL2EAf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 23:00:35 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753C012A98
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 20:00:32 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso21829391pjt.0
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 20:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrA6cKhB4WvkXwHTg5ca+fMUBMcOy4D+eqWDjGwfUFE=;
        b=eQYAWD45VZK3J3aTXUjXea+GK1Kge1alYuI8ih/oSbPcyUu6ZtB4Hla0uu1zif/UGC
         tIyLBHQ05bv/x6Az8Mu/a7+FUN/0eTQ3PAHgEc8c+9FkjwFAPa8h9S92AyEKX1IyaB+R
         Bj7E2LDcYqwGsUnkVj5KtKUXF9jmtEtOaQCHikxLqiCTBLZznl4GG+f8CjdazX8LTjLu
         j4SMMaupOjP2ad/0ZZiCr7T6IHVuMBMfM6XdJhZ4e2EBU5qbmi+30BzU3APj/rud9kfj
         ua3ecjU+GHNIB1QVfsNZSSq67MVo3/iivO8TY/JcpQWE5rriVTRW/3GuH0/FGC56pySn
         rwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrA6cKhB4WvkXwHTg5ca+fMUBMcOy4D+eqWDjGwfUFE=;
        b=gJlSV5YOHeoauAvIGgH3wux9LPHuh2tSRJk7FjQ2u/fBonJV7XROh+6WuKEXdvw8xZ
         /MfxqFOiOmvO44IclEk90smaa8KIK9Nj48S2NE7MjhY+f3hF6+GiELOh/09GPhSjuRk1
         RCrB5TpwAt1lu2VQ2d4itS5rX4Ccl0ym+sEBf2s7aTDb8feA8D2A/vkCGxT33DRL7MPv
         pfu3Zmni0lEXDdbDn2PvlExfxX4hNMalduslGeyISRzfKfkiOn+dYhaydWKkgrs8zU9I
         mgtuH5gqSd74z+uvEFa3l+ZaiSXMoc2CiLj5Mq6M0CHjSd/1cxSroIvBOi6HrXdg6SIv
         ivwQ==
X-Gm-Message-State: AFqh2kq5QSs1nK50dMc4Z1BF6IUsdA+ijImko91c4g0f+m+f3F2fhuCv
        rHC6WB+D4E0UOz+skA/bzdg=
X-Google-Smtp-Source: AMrXdXuWS/DT4OtadzQYUo6STM28rhEfKboMuS52ssE4u9nMVjjXyX2+IptLeHNwH8eUtOjq0qxIOw==
X-Received: by 2002:a17:903:451:b0:192:820d:d1 with SMTP id iw17-20020a170903045100b00192820d00d1mr14139724plb.25.1672286432057;
        Wed, 28 Dec 2022 20:00:32 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:e38b])
        by smtp.gmail.com with ESMTPSA id iw2-20020a170903044200b00183e2a96414sm11743014plb.121.2022.12.28.20.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 20:00:31 -0800 (PST)
Date:   Wed, 28 Dec 2022 20:00:29 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 bpf-next 07/13] bpf: Add support for bpf_rb_root and
 bpf_rb_node in kfunc args
Message-ID: <20221229040029.e335sm3zqgasyw62@MacBook-Pro-6.local>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-8-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217082506.1570898-8-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Dec 17, 2022 at 12:25:00AM -0800, Dave Marchevsky wrote:
>  
> +static int
> +__process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
> +				   struct bpf_reg_state *reg, u32 regno,
> +				   struct bpf_kfunc_call_arg_meta *meta,
> +				   enum btf_field_type head_field_type,
> +				   enum btf_field_type node_field_type,
> +				   struct btf_field **node_field)
> +{
> +	const char *node_type_name;
>  	const struct btf_type *et, *t;
>  	struct btf_field *field;
> -	u32 list_node_off;
> +	u32 node_off;
>  
> -	if (meta->btf != btf_vmlinux ||
> -	    (meta->func_id != special_kfunc_list[KF_bpf_list_push_front] &&
> -	     meta->func_id != special_kfunc_list[KF_bpf_list_push_back])) {
> -		verbose(env, "verifier internal error: bpf_list_node argument for unknown kfunc\n");
> +	if (meta->btf != btf_vmlinux) {
> +		verbose(env, "verifier internal error: unexpected btf mismatch in kfunc call\n");
>  		return -EFAULT;
>  	}
>  
> +	if (!check_kfunc_is_graph_node_api(env, node_field_type, meta->func_id))
> +		return -EFAULT;
> +
> +	node_type_name = btf_field_type_name(node_field_type);
>  	if (!tnum_is_const(reg->var_off)) {
>  		verbose(env,
> -			"R%d doesn't have constant offset. bpf_list_node has to be at the constant offset\n",
> -			regno);
> +			"R%d doesn't have constant offset. %s has to be at the constant offset\n",
> +			regno, node_type_name);
>  		return -EINVAL;
>  	}
>  
> -	list_node_off = reg->off + reg->var_off.value;
> -	field = reg_find_field_offset(reg, list_node_off, BPF_LIST_NODE);
> -	if (!field || field->offset != list_node_off) {
> -		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
> +	node_off = reg->off + reg->var_off.value;
> +	field = reg_find_field_offset(reg, node_off, node_field_type);
> +	if (!field || field->offset != node_off) {
> +		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
>  		return -EINVAL;
>  	}
>  
> -	field = meta->arg_list_head.field;
> +	field = *node_field;
>  
>  	et = btf_type_by_id(field->graph_root.btf, field->graph_root.value_btf_id);
>  	t = btf_type_by_id(reg->btf, reg->btf_id);
>  	if (!btf_struct_ids_match(&env->log, reg->btf, reg->btf_id, 0, field->graph_root.btf,
>  				  field->graph_root.value_btf_id, true)) {
> -		verbose(env, "operation on bpf_list_head expects arg#1 bpf_list_node at offset=%d "
> +		verbose(env, "operation on %s expects arg#1 %s at offset=%d "
>  			"in struct %s, but arg is at offset=%d in struct %s\n",
> +			btf_field_type_name(head_field_type),
> +			btf_field_type_name(node_field_type),
>  			field->graph_root.node_offset,
>  			btf_name_by_offset(field->graph_root.btf, et->name_off),
> -			list_node_off, btf_name_by_offset(reg->btf, t->name_off));
> +			node_off, btf_name_by_offset(reg->btf, t->name_off));
>  		return -EINVAL;
>  	}
>  
> -	if (list_node_off != field->graph_root.node_offset) {
> -		verbose(env, "arg#1 offset=%d, but expected bpf_list_node at offset=%d in struct %s\n",
> -			list_node_off, field->graph_root.node_offset,
> +	if (node_off != field->graph_root.node_offset) {
> +		verbose(env, "arg#1 offset=%d, but expected %s at offset=%d in struct %s\n",
> +			node_off, btf_field_type_name(node_field_type),
> +			field->graph_root.node_offset,
>  			btf_name_by_offset(field->graph_root.btf, et->name_off));
>  		return -EINVAL;
>  	}
> @@ -8932,6 +9053,24 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>  	return 0;
>  }

and with suggestion in patch 2 the single __process_kf_arg_ptr_to_graph_node helper
called as:

> +static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
> +					   struct bpf_reg_state *reg, u32 regno,
> +					   struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
> +						  BPF_LIST_HEAD, BPF_LIST_NODE,
> +						  &meta->arg_list_head.field);
> +}
> +
> +static int process_kf_arg_ptr_to_rbtree_node(struct bpf_verifier_env *env,
> +					     struct bpf_reg_state *reg, u32 regno,
> +					     struct bpf_kfunc_call_arg_meta *meta)
> +{
> +	return __process_kf_arg_ptr_to_graph_node(env, reg, regno, meta,
> +						  BPF_RB_ROOT, BPF_RB_NODE,
> +						  &meta->arg_rbtree_root.field);
> +}

would convert the arg from owning to non-owning.
