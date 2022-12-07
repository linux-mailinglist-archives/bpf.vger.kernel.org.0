Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47453645F1F
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 17:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLGQl1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Dec 2022 11:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiLGQlZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Dec 2022 11:41:25 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281EB55AAB
        for <bpf@vger.kernel.org>; Wed,  7 Dec 2022 08:41:25 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id u5so8776305pjy.5
        for <bpf@vger.kernel.org>; Wed, 07 Dec 2022 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hEIbAtM7R5ttHdICkfEPEkDGz8USwjI77vhmymkjFao=;
        b=i95kT0E1miiLCGLZl+EmaqzOI7vOlOIqg919pb+K+t9dd8SYstcIsapdbcFaN5w6tS
         2Bz7V/1Bv2LqrcF5OEPUf3CAXR6QQ27j9Y4n8j1TPAcWY9T/cUCT9acR7OawZdIZkc8V
         dW5BkrLQ+ewu+yzx17rPi+xXr3gJNfNaJroCqe1am3EBZTrRT9hQZErAfE6UbzR5ruax
         pbUlKdxuEtmVPFjbkYCTwlYGregHMtFtEsmMoOs5Pi3IFo011+PpDbCVHX45HlKOjzP4
         KjB9dl95KmwxW+n1+iw5C562vqcz2Ef9zddoj7iIkNy0QmmNSv59Ln/fbiaWYWdQMKc4
         ld3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEIbAtM7R5ttHdICkfEPEkDGz8USwjI77vhmymkjFao=;
        b=2oDCuRiKH7PURgESz2LrvhFMCVjWN71w9cEZdNoymhaBL+lvL3YW4weoYTH+3Hy752
         x9/KuXjRMiNExZ6IMyjwJh1wMKeM236kJUMYhbAvPSrTcQijAIYsA8TCFU1UKJ4eZKU8
         daGBDZ6MVc/TAowazjT5S2LzX2nDZasz1OlsU2CzYQ7bvrB8YtLxzVJH2ZfsNRT/claK
         qZk1jC6iOANBPr1QsavhA/8w9wiWzMe9AgGbpL6w/UT/PKl4I677seeGHa70W8oSRt/1
         gkEVdUOMHMFPMK0fg6jwZ2w1R/4t5Bp2SSqIDjBclZDj4G7TYntA30/j5XGOxbadxVcM
         rD9Q==
X-Gm-Message-State: ANoB5pmRWyQFACQXeotgvM0MIsJJ5uCoBnTwqcRwfN2JiUwSt9Dqod/D
        IEsTN0Oz9Hixb8CDep5CAiyGCap4GKDStpDE
X-Google-Smtp-Source: AA0mqf5VZIhIk+5jfgD/PvWCfpFXShoIF1hKJ4Bjd2OJMX8FaDhf8OWyL6swyk0MysDz0Bzfysc3UA==
X-Received: by 2002:a17:902:e886:b0:185:4ec3:c703 with SMTP id w6-20020a170902e88600b001854ec3c703mr76261544plg.165.1670431284513;
        Wed, 07 Dec 2022 08:41:24 -0800 (PST)
Received: from localhost ([2405:201:6014:d8bc:6259:1a87:ebdd:30a7])
        by smtp.gmail.com with ESMTPSA id 40-20020a17090a09ab00b00212735c8898sm1416861pjo.30.2022.12.07.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 08:41:24 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:11:21 +0530
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 01/13] bpf: Loosen alloc obj test in verifier's
 reg_btf_record
Message-ID: <20221207164121.h6wm5crfhhvekqvd@apollo>
References: <20221206231000.3180914-1-davemarchevsky@fb.com>
 <20221206231000.3180914-2-davemarchevsky@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206231000.3180914-2-davemarchevsky@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 07, 2022 at 04:39:48AM IST, Dave Marchevsky wrote:
> btf->struct_meta_tab is populated by btf_parse_struct_metas in btf.c.
> There, a BTF record is created for any type containing a spin_lock or
> any next-gen datastructure node/head.
>
> Currently, for non-MAP_VALUE types, reg_btf_record will only search for
> a record using struct_meta_tab if the reg->type exactly matches
> (PTR_TO_BTF_ID | MEM_ALLOC). This exact match is too strict: an
> "allocated obj" type - returned from bpf_obj_new - might pick up other
> flags while working its way through the program.
>

Not following. Only PTR_TO_BTF_ID | MEM_ALLOC is the valid reg->type that can be
passed to helpers. reg_btf_record is used in helpers to inspect the btf_record.
Any other flag combination (the only one possible is PTR_UNTRUSTED right now)
cannot be passed to helpers in the first place. The reason to set PTR_UNTRUSTED
is to make then unpassable to helpers.

> Loosen the check to be exact for base_type and just use MEM_ALLOC mask
> for type_flag.
>
> This patch is marked Fixes as the original intent of reg_btf_record was
> unlikely to have been to fail finding btf_record for valid alloc obj
> types with additional flags, some of which (e.g. PTR_UNTRUSTED)
> are valid register type states for alloc obj independent of this series.

That was the actual intent, same as how check_ptr_to_btf_access uses the exact
reg->type to allow the BPF_WRITE case.

I think this series is the one introducing this case, passing bpf_rbtree_first's
result to bpf_rbtree_remove, which I think is not possible to make safe in the
first place. We decided to do bpf_list_pop_front instead of bpf_list_entry ->
bpf_list_del due to this exact issue. More in [0].

 [0]: https://lore.kernel.org/bpf/CAADnVQKifhUk_HE+8qQ=AOhAssH6w9LZ082Oo53rwaS+tAGtOw@mail.gmail.com

> However, I didn't find a specific broken repro case outside of this
> series' added functionality, so it's possible that nothing was
> triggering this logic error before.
>
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Fixes: 4e814da0d599 ("bpf: Allow locking bpf_spin_lock in allocated objects")
> ---
>  kernel/bpf/verifier.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1d51bd9596da..67a13110bc22 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -451,6 +451,11 @@ static bool reg_type_not_null(enum bpf_reg_type type)
>  		type == PTR_TO_SOCK_COMMON;
>  }
>
> +static bool type_is_ptr_alloc_obj(u32 type)
> +{
> +	return base_type(type) == PTR_TO_BTF_ID && type_flag(type) & MEM_ALLOC;
> +}
> +
>  static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>  {
>  	struct btf_record *rec = NULL;
> @@ -458,7 +463,7 @@ static struct btf_record *reg_btf_record(const struct bpf_reg_state *reg)
>
>  	if (reg->type == PTR_TO_MAP_VALUE) {
>  		rec = reg->map_ptr->record;
> -	} else if (reg->type == (PTR_TO_BTF_ID | MEM_ALLOC)) {
> +	} else if (type_is_ptr_alloc_obj(reg->type)) {
>  		meta = btf_find_struct_meta(reg->btf, reg->btf_id);
>  		if (meta)
>  			rec = meta->record;
> --
> 2.30.2
>
