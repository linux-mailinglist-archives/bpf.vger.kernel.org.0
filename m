Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F686AAC67
	for <lists+bpf@lfdr.de>; Sat,  4 Mar 2023 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCDUVu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 4 Mar 2023 15:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjCDUVs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 4 Mar 2023 15:21:48 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBB31ACFA
        for <bpf@vger.kernel.org>; Sat,  4 Mar 2023 12:21:47 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p20so6201665plw.13
        for <bpf@vger.kernel.org>; Sat, 04 Mar 2023 12:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xNZ4zLTxrcCE4wKLCAFb8ZPEc/iWwUVXQLautltVLu8=;
        b=fj8uNf84WFzDrw4vDgpAwP48K2Y9ZFFtvcfJeVU7KwBWnBxPjbZUCWEpGcm5fYJBvB
         634Za0DcGktvsye2xBIh0xkZ1t+mbd2OE4W9URJ69E5YOTKfpfW3zgGGx/uo8O+5vcNw
         /rJ7qcpvOKvqvvjWLm1cdHjkW6UAs+2WUv6p8Ll+ho414iiyJko6rrP4c6hmXxmJhR2O
         BNrSKapRaYQQk11EfR7U1gmQoZgPpbmZZyZoHJ953vai6/tEWRpngIAQtzgcTPlWBL1h
         gveWV8qy9roGvSjBXj28PPh0GgQQbzvZaj09NGjwBRkrI19QDP64uyL6PTX0jGMKQMDB
         w3vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNZ4zLTxrcCE4wKLCAFb8ZPEc/iWwUVXQLautltVLu8=;
        b=0hOO5ew9FDsYUqBZsL7qSJuObz5hOyM5Xyd4REjPqYGFbw0VbsT2FppJ6agmPhNMHj
         f1GNXINyFgYruX22pww05tMdJYB9YXpbWXr5bD5a8z4CNqOxIUDN57LHloVTZdzzqzPr
         hvriuCLVzO/1Fzjw+zbgkHxNK2NwGNByJm+syr2GwrHtZemVHMI5aUxKfGbD+F+c/GjV
         d3cYfbimI++kBi4lRo17OcfF3oyew1KvqySgbCWwWx8LtyI8JCF/M/90EPQ1VszTBWl4
         c9JRLOg2qFAfgJLDan6hUB7ivJp3TdE6X9q4ywHZyKDjLMOYe1wefzXj78A7i2qOjbNr
         8FgA==
X-Gm-Message-State: AO0yUKV5KruGIiwuidTyhy5etGG3ZXzNWuDQSB186mdUrElx9PHad2n0
        Z58ZoqAE10CjvhIEHRyBk1M=
X-Google-Smtp-Source: AK7set/vjNZO09D8iqIeb52fUTpX7vJloHCiH4QfnEtTyteLVL0JrQj9ykvBPn1n6xlNSFmpOudv9w==
X-Received: by 2002:a05:6a20:6f57:b0:cc:b662:9e7c with SMTP id gu23-20020a056a206f5700b000ccb6629e7cmr5224677pzb.46.1677961306688;
        Sat, 04 Mar 2023 12:21:46 -0800 (PST)
Received: from MacBook-Pro-6.local ([2620:10d:c090:400::5:59fc])
        by smtp.gmail.com with ESMTPSA id s9-20020aa78d49000000b00593baab06dcsm3620743pfe.198.2023.03.04.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 12:21:46 -0800 (PST)
Date:   Sat, 4 Mar 2023 12:21:43 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 14/17] bpf: implement number iterator
Message-ID: <20230304202143.6d7dif64nhybxf6h@MacBook-Pro-6.local>
References: <20230302235015.2044271-1-andrii@kernel.org>
 <20230302235015.2044271-15-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302235015.2044271-15-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 02, 2023 at 03:50:12PM -0800, Andrii Nakryiko wrote:
>  
>  static enum kfunc_ptr_arg_type
> @@ -10278,7 +10288,17 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>  			if (is_kfunc_arg_uninit(btf, &args[i]))
>  				iter_arg_type |= MEM_UNINIT;
>  
> -			ret = process_iter_arg(env, regno, insn_idx, iter_arg_type,  meta);
> +			if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_new] ||
> +			    meta->func_id == special_kfunc_list[KF_bpf_iter_num_next]) {
> +				iter_arg_type |= ITER_TYPE_NUM;
> +			} else if (meta->func_id == special_kfunc_list[KF_bpf_iter_num_destroy]) {
> +				iter_arg_type |= ITER_TYPE_NUM | OBJ_RELEASE;

Since OBJ_RELEASE is set pretty late here and kfuncs are not marked with KF_RELEASE,
the arg_type_is_release() in check_func_arg_reg_off() won't trigger.
So I'm confused why there is:
+               if (arg_type_is_iter(arg_type))
+                       return 0;
in the previous patch.
Will it ever trigger?

Separate question: What happens when the user does:
bpf_iter_destroy(&it);
bpf_iter_destroy(&it);

+               if (!is_iter_reg_valid_init(env, reg)) {
+                       verbose(env, "expected an initialized iter as arg #%d\n", regno);
will trigger, right?
I didn't find such selftest.
