Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F17C66C998
	for <lists+bpf@lfdr.de>; Mon, 16 Jan 2023 17:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjAPQwN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 11:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbjAPQvq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 11:51:46 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03222B285;
        Mon, 16 Jan 2023 08:37:12 -0800 (PST)
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSTt-000MVK-MS; Mon, 16 Jan 2023 17:37:09 +0100
Received: from [85.1.206.226] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1pHSTt-000Hk1-8R; Mon, 16 Jan 2023 17:37:09 +0100
Subject: Re: [PATCH v3] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, Eric Curtin <ecurtin@redhat.com>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
References: <20230111152050.559334-1-yakoyoku@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <aaf97a61-73c9-ff90-422d-9f3a79b0acd6@iogearbox.net>
Date:   Mon, 16 Jan 2023 17:37:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20230111152050.559334-1-yakoyoku@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.7/26783/Mon Jan 16 09:28:30 2023)
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/11/23 4:20 PM, Martin Rodriguez Reboredo wrote:
> Version 1.24 of pahole has the capability to exclude compilation units
> (CUs) of specific languages [1] [2]. Rust, as of writing, is not
> currently supported by pahole and if it's used with a build that has
> BTF debugging enabled it results in malformed kernel and module
> binaries [3]. So it's better for pahole to exclude Rust CUs until
> support for it arrives.
> 
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f [1]
> Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4 [2]
> Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]
> 
> Co-developed-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Eric Curtin <ecurtin@redhat.com>
> Signed-off-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> ---
> V2 -> V3: Enable pahole option upon comparing with version 1.24
> V1 -> V2: Removed dependency on auto.conf
> 
>   init/Kconfig            | 2 +-
>   lib/Kconfig.debug       | 9 +++++++++
>   scripts/pahole-flags.sh | 4 ++++
>   3 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index 694f7c160c9c..360aef8d7292 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1913,7 +1913,7 @@ config RUST
>   	depends on !MODVERSIONS
>   	depends on !GCC_PLUGINS
>   	depends on !RANDSTRUCT
> -	depends on !DEBUG_INFO_BTF
> +	depends on !DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE
>   	select CONSTRUCTORS
>   	help
>   	  Enables Rust support in the kernel.
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ea4c903c9868..d473d491e709 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -364,6 +364,15 @@ config PAHOLE_HAS_BTF_TAG
>   	  btf_decl_tag) or not. Currently only clang compiler implements
>   	  these attributes, so make the config depend on CC_IS_CLANG.
>   
> +config PAHOLE_HAS_LANG_EXCLUDE
> +	def_bool PAHOLE_VERSION >= 124
> +	help
> +	  Support for the --lang_exclude flag which makes pahole exclude
> +	  compilation units from the supplied language. Used in Kbuild to
> +	  omit Rust CUs which are not supported in version 1.24 of pahole,
> +	  otherwise it would emit malformed kernel and module binaries when
> +	  using DEBUG_INFO_BTF_MODULES.
> +
>   config DEBUG_INFO_BTF_MODULES
>   	def_bool y
>   	depends on DEBUG_INFO_BTF && MODULES && PAHOLE_HAS_SPLIT_BTF
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index 0d99ef17e4a5..1f1f1d397c39 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -19,5 +19,9 @@ fi
>   if [ "${pahole_ver}" -ge "122" ]; then
>   	extra_paholeopt="${extra_paholeopt} -j"
>   fi
> +if [ "${pahole_ver}" -ge "124" ]; then
> +	# see PAHOLE_HAS_LANG_EXCLUDE
> +	extra_paholeopt="${extra_paholeopt} --lang_exclude=rust"
> +fi
>   
>   echo ${extra_paholeopt}

I presume Miguel will pick this up via rust tree? (Either way, would be nice to
also get an Ack from Arnaldo.)

Thanks,
Daniel
