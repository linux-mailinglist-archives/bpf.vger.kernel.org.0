Return-Path: <bpf+bounces-4613-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED34174DBD2
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 19:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 293831C20B20
	for <lists+bpf@lfdr.de>; Mon, 10 Jul 2023 17:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9537C13AD7;
	Mon, 10 Jul 2023 16:59:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B4C107B4
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 16:59:57 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBED6BB
	for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 09:59:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c850943cf9aso1440711276.1
        for <bpf@vger.kernel.org>; Mon, 10 Jul 2023 09:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689008395; x=1691600395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8IXAb3iaaLismNCSvGaug+VhwaghR+0TR8PTy1djqGg=;
        b=5MprCN+26L/J5fITpFQKx78/NUJRTqonZMU37iNDKshPesJ+QNzukYoAK+iYlQKLzm
         MF4Ek3KtXWyI5ZDB6Ka5AQ0drhW+in1sRizb+aP//3x1Nejs7cAkdYFXpoY1X9SqknI3
         fDXlRwKWEZWKrHinViSBD/NPqNb0JX2QhZjwYS/VY/vdYA7uslXEHTZO2knRHnZjAoAe
         paVClNmS2g11XxCyGyMUShNuDMrPf1FLABOAs5JzuKyCzhienA0uQ5vFHEuDI4l3qvgb
         /tHJO7WB4QcfynapRn4Ah3zaJV2uYQ+HQLbWGYwldByjiFUe7j5sOE/W0zW7jkTSLOQ0
         Zpgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689008395; x=1691600395;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8IXAb3iaaLismNCSvGaug+VhwaghR+0TR8PTy1djqGg=;
        b=JlE4IZjvHWwSjskT1VElYzt1CYYcTNkafDZ3X9kNVUVZQYnVt8/g7+IkHzym1nx7dL
         t7I9o1hbBut1q10pytGde0UhAhgos+VUc4lB4wVGlcQRsYKF8V5XjYuljjhbwJwZcMTP
         450MNn90A9tu4MEr387Jo8GPtKbjja4nsG+JvHYbMecJbf3Eg+oAPoNgGeTorlyz0CcQ
         cJ8buUj91cHh9++IIUOUcXJU8J//VYUjXfjWBPY5TZfWKTTI7pw9JfW0oaD6wATtL7Y+
         a44WRhJzCPH8VKMyyuqCWpsmFzddQ9vl4QYm3GBRzF4BbDVX6w7C9s36+lCgHQLuMZQN
         eAzA==
X-Gm-Message-State: ABy/qLZEXF7RLZWTUbfrFdYQeHQAeYc3yhRLRuYkrKRGGRie7NtH3Edv
	akgaxLGvhk0i9Ml2QgFOovbC+5I=
X-Google-Smtp-Source: APBJJlEZ2bQH4ZmyLLMvXPXDe3CW48r+mNOmyL0ouNcy2GZBNv44m5kvp56ifCTi24fD1u92bFUJp34=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a5b:749:0:b0:c11:d5a9:d25f with SMTP id
 s9-20020a5b0749000000b00c11d5a9d25fmr75899ybq.0.1689008394977; Mon, 10 Jul
 2023 09:59:54 -0700 (PDT)
Date: Mon, 10 Jul 2023 09:59:53 -0700
In-Reply-To: <20230709025912.3837-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230709025912.3837-1-laoar.shao@gmail.com> <20230709025912.3837-2-laoar.shao@gmail.com>
Message-ID: <ZKw5CdD/TMnPHFQC@google.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Introduce BTF_TYPE_SAFE_TRUSTED_UNION
From: Stanislav Fomichev <sdf@google.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yhs@fb.com, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/09, Yafang Shao wrote:
> When we are verifying a field in a union, we may unexpectedly verify
> another field which has the same offset in this union. So in such case,
> we should annotate that field as PTR_UNTRUSTED. However, in some cases
> we are sure some fields in a union is safe and then we can add them into
> BTF_TYPE_SAFE_TRUSTED_UNION allow list.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/btf.c      | 20 +++++++++-----------
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 3dd47451f097..fae6fc24a845 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -6133,7 +6133,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  	const char *tname, *mname, *tag_value;
>  	u32 vlen, elem_id, mid;
>  
> -	*flag = 0;
>  again:
>  	if (btf_type_is_modifier(t))
>  		t = btf_type_skip_modifiers(btf, t->type, NULL);
> @@ -6144,6 +6143,14 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  	}
>  
>  	vlen = btf_type_vlen(t);
> +	if (BTF_INFO_KIND(t->info) == BTF_KIND_UNION && vlen != 1 && !(*flag & PTR_UNTRUSTED))
> +		/*
> +		 * walking unions yields untrusted pointers
> +		 * with exception of __bpf_md_ptr and other
> +		 * unions with a single member
> +		 */
> +		*flag |= PTR_UNTRUSTED;
> +
>  	if (off + size > t->size) {
>  		/* If the last element is a variable size array, we may
>  		 * need to relax the rule.
> @@ -6304,15 +6311,6 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
>  		 * of this field or inside of this struct
>  		 */
>  		if (btf_type_is_struct(mtype)) {
> -			if (BTF_INFO_KIND(mtype->info) == BTF_KIND_UNION &&
> -			    btf_type_vlen(mtype) != 1)
> -				/*
> -				 * walking unions yields untrusted pointers
> -				 * with exception of __bpf_md_ptr and other
> -				 * unions with a single member
> -				 */
> -				*flag |= PTR_UNTRUSTED;
> -
>  			/* our field must be inside that union or struct */
>  			t = mtype;
>  
> @@ -6478,7 +6476,7 @@ bool btf_struct_ids_match(struct bpf_verifier_log *log,
>  			  bool strict)
>  {
>  	const struct btf_type *type;
> -	enum bpf_type_flag flag;
> +	enum bpf_type_flag flag = 0;
>  	int err;
>  
>  	/* Are we already done? */
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 11e54dd8b6dd..1fb0a64f5bce 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -5847,6 +5847,7 @@ static int bpf_map_direct_read(struct bpf_map *map, int off, int size, u64 *val)
>  #define BTF_TYPE_SAFE_RCU(__type)  __PASTE(__type, __safe_rcu)
>  #define BTF_TYPE_SAFE_RCU_OR_NULL(__type)  __PASTE(__type, __safe_rcu_or_null)
>  #define BTF_TYPE_SAFE_TRUSTED(__type)  __PASTE(__type, __safe_trusted)
> +#define BTF_TYPE_SAFE_TRUSTED_UNION(__type)  __PASTE(__type, __safe_trusted_union)
>  
>  /*
>   * Allow list few fields as RCU trusted or full trusted.
> @@ -5914,6 +5915,11 @@ BTF_TYPE_SAFE_TRUSTED(struct socket) {
>  	struct sock *sk;
>  };
>  


[..]

> +/* union trusted: these fields are trusted even in a uion */
> +BTF_TYPE_SAFE_TRUSTED_UNION(struct sk_buff) {
> +	struct sock *sk;
> +};

Does it say that sk member of sk_buff is always dereferencable?
Why is it universally safe?
In general, I don't really understand why it's safe to statically
mark the members this way. Shouldn't it depend on the context?

