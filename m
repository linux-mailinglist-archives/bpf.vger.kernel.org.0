Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6593645008
	for <lists+bpf@lfdr.de>; Wed,  7 Dec 2022 01:10:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLGAKh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 19:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLGAKg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 19:10:36 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1D3965C8
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 16:10:35 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id b21so15528949plc.9
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 16:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=upOw4s5DkkMLkXQKBwflnE5JhO+xxsKJLqppZopin2k=;
        b=k29qWDhrLxn3JKlMc+RJeWDYJUpla+/9LXToSCcR7w7WTwwum5t1sNTLWpcHyF66yt
         953NkvhbQnu1Fz6u9VnQSLk+4rJmdGkNM+OiXyv2nu11bWwEHOxn4j8GL9EFu1l/5pOr
         PP2lVqvu2Yo0/hjVLnOl7FLT3rXwX7xdK9YJbxloJvG94176VUlZllKcFwCmF8i0y51v
         JX7Inz0qy37jSZvHLRlVNCgybIM8VFSUDzmanFrPhEgbBks/AWqXGlgA2tJcieFsgrVD
         Pf4a3IgzmJL40yFksR85bzdWgFi1FeY3bBJaqs2C6sUPf3BaFqykMWOdn0Y0RLNeoXx+
         CmpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=upOw4s5DkkMLkXQKBwflnE5JhO+xxsKJLqppZopin2k=;
        b=jJhtLdKy1WnEfg/+i9/VyHdtyS4Ap8KmeLHsGTOQEXGFWHNOjHURjpPa1fFeEolGhZ
         ZMQgj72+OHwcSXzKtb5I2eYf/WeH0OCKgvQylHvwSuOTt2+CtXZCX9VcEDC28z8AKM2Z
         1P33qGXTGZN5LHfpX6GSx+6oiEqZ1p3pIHw3IERqiJjrrzwyEbHkDDRm6vVKMzi2Xam7
         WfBH8qrf41URa0imWD7pqaQOESLSejDZr8ncvJKpKdNJz27YZQiH0dG0uFFF+nE7+lUN
         Y2Z4CHYqQ82Q9ZlW60aQfZFfXSey6Z96m5tm9Qno2ogdAYvRik5ztG5+K1xjgMv4Dyef
         0aVQ==
X-Gm-Message-State: ANoB5plzWOinMiCkrEmJFFs/Bqo5wnuQRvXFRfdZmdZ6CQuborZelP6f
        P0WVQDp9rZDCe6aI+/ZFRrA=
X-Google-Smtp-Source: AA0mqf7kiue6/Fe6olrUaYbVkvF1Vj+Q6nLB/PcVfxMpD6O5RXjPkp2ZvId4y/fEkAcXGxBKLzjRFg==
X-Received: by 2002:a17:90a:304b:b0:218:f8a6:7bda with SMTP id q11-20020a17090a304b00b00218f8a67bdamr477361pjl.48.1670371834848;
        Tue, 06 Dec 2022 16:10:34 -0800 (PST)
Received: from macbook-pro-6.dhcp.thefacebook.com ([2620:10d:c090:400::5:11da])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002192db1f8e8sm11406795pjb.23.2022.12.06.16.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 16:10:34 -0800 (PST)
Date:   Tue, 6 Dec 2022 16:10:29 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Viktor Malik <vmalik@redhat.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Message-ID: <Y4/Z9dq4EqH76ke5@macbook-pro-6.dhcp.thefacebook.com>
References: <cover.1670249590.git.vmalik@redhat.com>
 <c4f71d66eff216097b63d8a73ac203cb689567b4.1670249590.git.vmalik@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f71d66eff216097b63d8a73ac203cb689567b4.1670249590.git.vmalik@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Dec 05, 2022 at 04:26:05PM +0100, Viktor Malik wrote:
> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
> module without specifying the target program, the verifier tries to find
> the address to attach to in kallsyms. This is always done by searching
> the entire kallsyms, not respecting the module in which the function is
> located.
> 
> This approach causes an incorrect attachment address to be computed if
> the function to attach to is shadowed by a function of the same name
> located earlier in kallsyms.
> 
> Since the attachment must contain the BTF of the program to attach to,
> we may extract the module name from it (if the attach target is a
> module) and search for the function address in the correct module.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> Acked-by: Hao Luo <haoluo@google.com>
> ---
>  include/linux/btf.h   | 1 +
>  kernel/bpf/btf.c      | 5 +++++
>  kernel/bpf/verifier.c | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/btf.h b/include/linux/btf.h
> index cbd6e4096f8c..b7b791d1f3d6 100644
> --- a/include/linux/btf.h
> +++ b/include/linux/btf.h
> @@ -188,6 +188,7 @@ u32 btf_obj_id(const struct btf *btf);
>  bool btf_is_kernel(const struct btf *btf);
>  bool btf_is_module(const struct btf *btf);
>  struct module *btf_try_get_module(const struct btf *btf);
> +const char *btf_module_name(const struct btf *btf);
>  u32 btf_nr_types(const struct btf *btf);
>  bool btf_member_is_reg_int(const struct btf *btf, const struct btf_type *s,
>  			   const struct btf_member *m,
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index c80bd8709e69..f78e8060efa6 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7208,6 +7208,11 @@ bool btf_is_module(const struct btf *btf)
>  	return btf->kernel_btf && strcmp(btf->name, "vmlinux") != 0;
>  }
>  
> +const char *btf_module_name(const struct btf *btf)
> +{
> +	return btf->name;
> +}

It feels that btf->name is leaking a bit of implementation detail.
How about doing:

struct module *btf_find_module(const struct btf *btf)
{
        reutrn find_module(btf->name);
}

> +
>  enum {
>  	BTF_MODULE_F_LIVE = (1 << 0),
>  };
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 1d51bd9596da..0c533db51f92 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16483,7 +16483,10 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  			else
>  				addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>  		} else {
> -			addr = kallsyms_lookup_name(tname);
> +			if (btf_is_module(btf))
> +				addr = kallsyms_lookup_name_in_module(btf_module_name(btf), tname);

and use find_kallsyms_symbol_value() here
(with preempt_disable dance).
There won't be a need for patch 1 too.

wdyt?

> +			else
> +				addr = kallsyms_lookup_name(tname);
>  			if (!addr) {
>  				bpf_log(log,
>  					"The address of function %s cannot be found\n",
> -- 
> 2.38.1
> 
