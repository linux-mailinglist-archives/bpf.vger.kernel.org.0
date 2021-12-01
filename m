Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8AB465737
	for <lists+bpf@lfdr.de>; Wed,  1 Dec 2021 21:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352944AbhLAUib (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 15:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352955AbhLAUiD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Dec 2021 15:38:03 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A904AC061756
        for <bpf@vger.kernel.org>; Wed,  1 Dec 2021 12:34:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id x5so25792968pfr.0
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 12:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d3zifY62PAYZtUVi5OWBlQlDus7C9JKEjDNlCp6bCAU=;
        b=Jab05EpQnKjBIlE4KQR6ZwU1HVVVaV9BB8djV8bxQHd9qb8VkZVumeSLhma9gZz927
         R9mWzHFQ32JQ1enihxENMcxz4+VRilGR/fnOtWafVU7yF5cmjaTXQZhD/MZC3jxO7pqT
         CWpJxv5QxOjIKd2sYjSffbvuikNzh+8z1j6esm9/lMJbWmsY8dNqQcugtT8DbEfeB/OX
         G9swxjEAi8Jkxd8zPv+j2HFtnANJOdBBpWfS5854bXLjU4s1BJAuaXCL55OtWK7fSB0g
         SaW7Zc9Cvw1AkmAv9KmN4h0nHR3bfFsI2/DJgE03mWzoeMmZF+Nvn86tJd505LFmXgiy
         LevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d3zifY62PAYZtUVi5OWBlQlDus7C9JKEjDNlCp6bCAU=;
        b=GDk3kFUkr7Wk/UVBetFzC/Ba8wdjSfm4AKRv8tfoD/xQ7zXn7CEd7bi0rdL5You+RV
         8IUbkGU3ZZo7W7yru/eeCVBv04FJbXhvy5BXLP8GIAtrz0ub1tVGboY8A8V1T3EBN6z6
         F+otWMS44rqNH4G4beLUWqs3BdGv9MvDUJUGFd6YIkc4UA5O0oS8nWiHPzruPmnxtwH1
         6V+ZNasDcsodWylmgXaqkByfwBMYxBUmILe1HP67ogv3DhuG29AHUYzWF2PX8Edp86sA
         VbZu0w3+wRIIyK6U34uzU+KjfUxCSw/1deL4w4PK2LsYiP6PAP0XquPiZUJG9NZo2Azn
         6CsQ==
X-Gm-Message-State: AOAM531/GZXA1ricqh/h96v+XaBTyoGg1j4loPdnz5lFUmtZuppuuSNw
        7l0rjP7kX3n6VjLLz4zpg58=
X-Google-Smtp-Source: ABdhPJzVMMUsNg8zVzHC7XcIjlEYqRLyGO3TWJVBLlgQt8j+r4nXKxeHFmOM7z3CJAeIeNP4ftqPsw==
X-Received: by 2002:a05:6a00:2391:b0:4a2:cb64:2e01 with SMTP id f17-20020a056a00239100b004a2cb642e01mr8368762pfc.45.1638390876230;
        Wed, 01 Dec 2021 12:34:36 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:620c])
        by smtp.gmail.com with ESMTPSA id f185sm704175pfg.39.2021.12.01.12.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 12:34:35 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:34:33 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>, bpf@vger.kernel.org
Subject: Re: [RFC PATCH bpf-next v2 8/9] bpf: Add MEM_RDONLY for helper args
 that are pointers to rdonly mem.
Message-ID: <20211201203433.ioj3jsksaw3aoie2@ast-mbp.dhcp.thefacebook.com>
References: <20211130012948.380602-1-haoluo@google.com>
 <20211130012948.380602-9-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130012948.380602-9-haoluo@google.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 29, 2021 at 05:29:47PM -0800, Hao Luo wrote:
>  
> +
>  struct bpf_reg_types {
>  	const enum bpf_reg_type types[10];
>  	u32 *btf_id;
> +
> +	/* Certain types require customized type matching function. */
> +	bool (*type_match_fn)(enum bpf_arg_type arg_type,
> +			      enum bpf_reg_type type,
> +			      enum bpf_reg_type expected);
>  };
>  
>  static const struct bpf_reg_types map_key_value_types = {
> @@ -5013,6 +5019,19 @@ static const struct bpf_reg_types btf_id_sock_common_types = {
>  };
>  #endif
>  
> +static bool mem_type_match(enum bpf_arg_type arg_type,
> +			   enum bpf_reg_type type, enum bpf_reg_type expected)
> +{
> +	/* If arg_type is tagged with MEM_RDONLY, type is compatible with both
> +	 * RDONLY and RDWR mem, fold the MEM_RDONLY flag in 'type' before
> +	 * comparison.
> +	 */
> +	if ((arg_type & MEM_RDONLY) != 0)
> +		type &= ~MEM_RDONLY;
> +
> +	return type == expected;
> +}
> +
>  static const struct bpf_reg_types mem_types = {
>  	.types = {
>  		PTR_TO_STACK,
> @@ -5022,8 +5041,8 @@ static const struct bpf_reg_types mem_types = {
>  		PTR_TO_MAP_VALUE,
>  		PTR_TO_MEM,
>  		PTR_TO_BUF,
> -		PTR_TO_BUF | MEM_RDONLY,
>  	},
> +	.type_match_fn = mem_type_match,

why add a callback for this logic?
Isn't it a universal rule for MEM_RDONLY?
