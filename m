Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B079F631585
	for <lists+bpf@lfdr.de>; Sun, 20 Nov 2022 18:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiKTR2Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Nov 2022 12:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiKTR2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Nov 2022 12:28:20 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1B4E0E2;
        Sun, 20 Nov 2022 09:28:20 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so8904190pjb.0;
        Sun, 20 Nov 2022 09:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=56iG5xde7iR3SelY1GqM0W6IeVhpKyYN/iqlpudpwMA=;
        b=IWYBIJW7BZoacdR2c+yFNKJ9unUoVQEUpLxFPQYrpejse96ibkowPzxC8lBXzZxrlG
         Ifs/chr1XumJGASPPmmismfKCWyH27FVvxY0OmvadH10zbbk8u0/yV6WnUzz1lwXvJpH
         cIOQ7o9nQTbyD9niTWnflOTmteoVY1QLAftXjtpCug/RuvvCdQtR1E5vJVab1H8fTO3q
         wqlth531VU/w4ob0F+eFpKcq2PbOdj+iHdQx6JLPC6nQQc1LQvv4za3sPBXJy7U37B8a
         UHOaNIeRP50Da5Yo1uEg8gW+gbgEC2Pru7tsNTJcZdLVyjQ40cNcFbiyYm8BozzBxhIT
         aL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56iG5xde7iR3SelY1GqM0W6IeVhpKyYN/iqlpudpwMA=;
        b=w8Cr2tO+KJp1PZZf0DWtAhAYKPWUidPcvn7zTnO0OtDhORJdjMVbFJh3Px4NYm5AEe
         i7lPQoEYASB41z74WBbh7dKB0EqQ9Xxi+wtcfgNMEB9ornTq/97D4l0XlsCVXGmMjeVp
         tCwfvScEHDKMJe4RL/hcJe1J1Ztw4byP3nu5wcBWH0DmQiq3CUjfZnKhE1uyEMtWR8VY
         gjI6btL+cdyKwM8gDV0MPGYzSL7OxsVGYC1ywi3IxUZhH/L8OMB77bYeNsxsHQLJ1GKU
         KRXeawSrzayunydlqfyzEeSeefwoXUDslmBJS6nJOhl6Eg4ujHrs0n3rT7yuDM0fbPTt
         +18g==
X-Gm-Message-State: ANoB5pnoZKc9pMxGbm5e98Fw8slvxMw4AN43okK7U2NX8hMi4OPW6JJ4
        awn8Ee/UDT691KzWkOtL3f0=
X-Google-Smtp-Source: AA0mqf4NzmGumXYOi4GFCyNAfuNYqPdry5wM+WB9hNad8qkTenPKf8nwwP9HD4Q7q4T5eJdBUcoZJQ==
X-Received: by 2002:a17:902:680e:b0:188:d552:fb02 with SMTP id h14-20020a170902680e00b00188d552fb02mr8310307plk.76.1668965299566;
        Sun, 20 Nov 2022 09:28:19 -0800 (PST)
Received: from macbook-pro-5.dhcp.thefacebook.com ([2620:10d:c090:400::5:7165])
        by smtp.gmail.com with ESMTPSA id g8-20020aa79f08000000b0056bc5ad4862sm6909827pfr.28.2022.11.20.09.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 09:28:18 -0800 (PST)
Date:   Sun, 20 Nov 2022 09:28:15 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     David Vernet <void@manifault.com>
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        martin.lau@linux.dev, yhs@fb.com, song@kernel.org, sdf@google.com,
        john.fastabend@gmail.com, haoluo@google.com, jolsa@kernel.org,
        kpsingh@kernel.org, memxor@gmail.com, tj@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next v9 2/4] bpf: Allow trusted pointers to be passed
 to KF_TRUSTED_ARGS kfuncs
Message-ID: <20221120172815.godn2rt22yk7j22z@macbook-pro-5.dhcp.thefacebook.com>
References: <20221120051004.3605026-1-void@manifault.com>
 <20221120051004.3605026-3-void@manifault.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221120051004.3605026-3-void@manifault.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 19, 2022 at 11:10:02PM -0600, David Vernet wrote:
>  		case KF_ARG_PTR_TO_BTF_ID:
>  			/* Only base_type is checked, further checks are done here */
> -			if (reg->type != PTR_TO_BTF_ID &&
> -			    (!reg2btf_ids[base_type(reg->type)] || type_flag(reg->type))) {
> -				verbose(env, "arg#%d expected pointer to btf or socket\n", i);
> +			if ((base_type(reg->type) != PTR_TO_BTF_ID ||
> +			     bpf_type_has_unsafe_modifiers(reg->type)) &&
> +			    !reg2btf_ids[base_type(reg->type)]) {
> +				verbose(env, "arg#%d is %s ", i, reg_type_str(env, reg->type));
> +				verbose(env, "expected %s or socket\n",
> +					reg_type_str(env, base_type(reg->type) |
> +							  (type_flag(reg->type) & BPF_REG_TRUSTED_MODIFIERS)));
...
> diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
> index 86d6fef2e3b4..3193915c5ee6 100644
> --- a/tools/testing/selftests/bpf/verifier/calls.c
> +++ b/tools/testing/selftests/bpf/verifier/calls.c
> @@ -109,7 +109,7 @@
>  	},
>  	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
>  	.result = REJECT,
> -	.errstr = "arg#0 expected pointer to btf or socket",
> +	.errstr = "arg#0 is ptr_or_null_ expected ptr_ or socket",

Nice.
I missed the fact that reg_type_str() prints only the type.
We see more verbose prints in print_verifier_state():
  verbose(env, "%s", reg_type_str(env, t));
  if (base_type(t) == PTR_TO_BTF_ID)
          verbose(env, "%s", kernel_type_name(reg->btf, reg->btf_id));
Since reg_type_str() prints into a buffer maybe we can enhance it with
struct name printing too?
Not urgent.
The set looks great. Applied.
There is an odd arm64 failure in bonding test reported by CI, but looks unrelated.
