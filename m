Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A45A3EE8
	for <lists+bpf@lfdr.de>; Sun, 28 Aug 2022 19:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiH1Rgl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 28 Aug 2022 13:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiH1Rgl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 28 Aug 2022 13:36:41 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46ABE32AA3
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 10:36:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u6so7671629eda.12
        for <bpf@vger.kernel.org>; Sun, 28 Aug 2022 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc;
        bh=6aEi9sGsKYzyV+EPu0jnl/8R1OHSRxD7Wt/ZKOb4VfI=;
        b=fkVg/izSAbzBQrgZFGV9qJlhnmb044TBEyojI+HdFl+oWWjmg39a+c3WNJUsDQhS44
         W3K0mcXdk8QAB+MDXxUaxRnbvOssEPa92lf97Qpj9m6L3YToTpRw2M8m/QG69A2oE6QW
         IIBaUSAn4XXeNhtQWZMAnbXL4pgVDjjXmNVXS5VNqLmJ2fCDpsT3FZ4+cq7bXAS56hp3
         06lMwa8E8JI9NUTOQPf9Rcrmjzhhz/9IJKh7A2SqWsG7tl8tpsbmOyyvOG/znqQHSe4r
         BBbLuVe3Ct35rFDIM1SP37wdDqCTNM8qfVdQauJhFVD+5DOHNG6iB8TI54xomRetgoSn
         Bveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc;
        bh=6aEi9sGsKYzyV+EPu0jnl/8R1OHSRxD7Wt/ZKOb4VfI=;
        b=CzgTZW+J17J/y226Wb75WntDjLt3J7iTGRSM8HiFXRhnqSjQUBdWSYQ6YdOhWZ9XwI
         M6erD6lc/gd5QouMGvwg5IKREVAx02eF+BuuMQog+PPWAzdP9+biXZkyqfJlQSsYPg0h
         tEl475/hucgOXnu0TvQWNXG/EKSs7Sl1auHJSrLZx3oB7U+jAYXH2BmId+H02l0zZ8P+
         hrKQ+rH8XQSdYYiznoxlsyYdJMw408NCD16nveOpjOqVJaNs4vhzeIoKNZrcmUEs7gPB
         urhi6fSzyNG92/J/3RR3pUnBVd5Qc7AffI0381fDKFcTZVAgFWMRF+bJ/3cuQHZcsz+R
         fhuw==
X-Gm-Message-State: ACgBeo3cxuaxBQUoho3j5FulNO4ttNIJuQ52K9cFV/f7K43Pt8WrnVsN
        nNTRB1Wlgywb/iOruHvU0Nk=
X-Google-Smtp-Source: AA6agR4ZNiB98XhaAiFweCETcaEltTaBwW3n9nveoFoJkMRLEPeehjSSQNFl0s9cD4GE4qkyQsoXiQ==
X-Received: by 2002:aa7:d9da:0:b0:447:b14a:e47e with SMTP id v26-20020aa7d9da000000b00447b14ae47emr13256250eds.352.1661708198792;
        Sun, 28 Aug 2022 10:36:38 -0700 (PDT)
Received: from krava ([83.240.60.103])
        by smtp.gmail.com with ESMTPSA id r21-20020aa7d155000000b0043cc66d7accsm4689039edo.36.2022.08.28.10.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 10:36:38 -0700 (PDT)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Sun, 28 Aug 2022 19:36:37 +0200
To:     Martin Reboredo <yakoyoku@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: Add config for skipping BTF enum64s
Message-ID: <Ywunpcdf3CZTghIt@krava>
References: <20220828165124.20261-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828165124.20261-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Aug 28, 2022 at 01:51:24PM -0300, Martin Reboredo wrote:
> From: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> 
> After the release of pahole 1.24 some people in the dwarves mailing list
> notified issues related to building the kernel with the BTF_DEBUG_INFO
> option toggled. They seem to be happenning due to the kernel and
> resolve_btfids interpreting btf types erroneously. In the dwarves list
> I've proposed a change to the scripts that I've written while testing
> the Rust kernel, it simply passes the --skip_encoding_btf_enum64 to
> pahole if it has version 1.24, but it might be desirable to have the
> option to pass said flag.

as I wrote in the original thread, I think we need to do this just for
stable kernels that don't have enum64 support and use pahole 1.24

I think we should switch it off there by default without config option

jirka

> 
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
>  lib/Kconfig.debug       | 14 ++++++++++++++
>  scripts/pahole-flags.sh |  7 +++++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 072e4b289c13..638a33cf9e57 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -356,6 +356,20 @@ config PAHOLE_HAS_BTF_TAG
>  	  btf_decl_tag) or not. Currently only clang compiler implements
>  	  these attributes, so make the config depend on CC_IS_CLANG.
>  
> +config PAHOLE_HAS_SKIP_ENCODING_BTF_ENUM64
> +	def_bool PAHOLE_VERSION >= 124
> +	help
> +	  Encoding BTF enum64s can be skipped with the
> +	  --skip_encoding_btf_enum64 pahole option.
> +
> +config DEBUG_INFO_BTF_SKIP_ENCODING_ENUM64
> +	def_bool n
> +	depends on DEBUG_INFO_BTF && PAHOLE_HAS_SKIP_ENCODING_BTF_ENUM64
> +	help
> +	  Omit the encoding of 64 bits enum values with pahole. With certain
> +	  kernel configurations having ENUM64s enabled may result in malformed
> +	  output binaries.
> +
>  config DEBUG_INFO_BTF_MODULES
>  	def_bool y
>  	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a5..e44bc2a947ce 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -9,6 +9,10 @@ fi
>  
>  pahole_ver=$($(dirname $0)/pahole-version.sh ${PAHOLE})
>  
> +is_enabled() {
> +	grep -q "^$1=y" include/config/auto.conf
> +}
> +
>  if [ "${pahole_ver}" -ge "118" ] && [ "${pahole_ver}" -le "121" ]; then
>  	# pahole 1.18 through 1.21 can't handle zero-sized per-CPU vars
>  	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_vars"
> @@ -19,5 +23,8 @@ fi
>  if [ "${pahole_ver}" -ge "122" ]; then
>  	extra_paholeopt="${extra_paholeopt} -j"
>  fi
> +if is_enabled DEBUG_INFO_BTF_SKIP_ENCODING_ENUM64; then
> +	extra_paholeopt="${extra_paholeopt} --skip_encoding_btf_enum64"
> +fi
>  
>  echo ${extra_paholeopt}
> -- 
> 2.37.2
> 
