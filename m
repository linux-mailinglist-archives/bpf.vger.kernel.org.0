Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD7B176E2C
	for <lists+bpf@lfdr.de>; Tue,  3 Mar 2020 05:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgCCEtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Mar 2020 23:49:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41393 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727312AbgCCEtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 Mar 2020 23:49:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id j9so816554pfa.8
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2020 20:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Sics0B7EoHCtat3/CO1pwyp/swYRXD7UJx80Cjp454c=;
        b=iHnPg7BcPecEdHYB95AV1YGmFaTE8e6ruVjUoK73IQbKQmU1NJROEx6/7ho6yrgcVX
         plBRasUX+u9rqCk4siHPbGty2/YnfeBVzIAx+ckfm8TTZvumSLIIwdkS9803ZCkUgIZz
         OPdz/MnVjYzXW3pMqrOU9QbDB7LjmXePfmKgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Sics0B7EoHCtat3/CO1pwyp/swYRXD7UJx80Cjp454c=;
        b=lLiSDyCMKzaY+dd7JyUNlcs3Ib8y3g7ykChL4b2DT72O7ET4XDGienFWJUXavHfT+r
         0yNWZ+O1tLqEE7lNhb7Xvh9SxQGETtSrZ8EzUsJ4zpFFtO+qrvCpW0wsu77n13R0OFCn
         tSf+C0xFax80h1vSdFS69gorkaYcWZUGfSCgwgUMebkvA9ZCgBlFCbrhHDTS9T4ZY+if
         MW4QeG/6TsXDhq4E7+3Kh+hA+mUazStrmLa3nZKXzd/HY8EX+TlteHoareCMzhwNXz5F
         SGCp4AVKTEVGCCXAZPNx0v+WeWalLt+kptrAPAoPwlb3WCSc7rpjC5sFzFxCFxLXI4sM
         Y/2Q==
X-Gm-Message-State: ANhLgQ2zzp1HzJUIzkooAmWghjNVJkrb2xV3pDvTZiMzGABHS30r/I9L
        JECIcvxlth35MR3neULuQ82IXWdNRag=
X-Google-Smtp-Source: ADFU+vt2+qrCj2iXmaEVSCgXbvrK/ZVYtlXXb3TycWpDX8A69+F5QF37dyu0h7y6sOHRsE/xRKnU4A==
X-Received: by 2002:a62:342:: with SMTP id 63mr2377981pfd.19.1583210938225;
        Mon, 02 Mar 2020 20:48:58 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q3sm13264664pgj.92.2020.03.02.20.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:48:57 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:48:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] kbuild: Remove debug info from kallsyms linking
Message-ID: <202003022046.4185359A@keescook>
References: <202002242114.CBED7F1@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202002242114.CBED7F1@keescook>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 24, 2020 at 09:16:17PM -0800, Kees Cook wrote:
> When CONFIG_DEBUG_INFO is enabled, the two kallsyms linking steps spend
> time collecting and writing the dwarf sections to the temporary output
> files. kallsyms does not need this information, and leaving it off
> halves their linking time. This is especially noticeable without
> CONFIG_DEBUG_INFO_REDUCED. The BTF linking stage, however, does still
> need those details.
> 
> Refactor the BTF and kallsyms generation stages slightly for more
> regularized temporary names. Skip debug during kallsyms links.
> 
> For a full debug info build with BTF, my link time goes from 1m06s to
> 0m54s, saving about 12 seconds, or 18%.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Ping. Masahiro what do you think of this? It saves me a fair bit of time
on the link stage... I bet the BPF folks would be interested too. :)

-Kees

> ---
>  scripts/link-vmlinux.sh | 28 +++++++++++++++++++---------
>  1 file changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index dd484e92752e..ac569e197bfa 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -63,12 +63,18 @@ vmlinux_link()
>  	local lds="${objtree}/${KBUILD_LDS}"
>  	local output=${1}
>  	local objects
> +	local strip_debug
>  
>  	info LD ${output}
>  
>  	# skip output file argument
>  	shift
>  
> +	# The kallsyms linking does not need debug symbols included.
> +	if [ "$output" != "${output#.tmp_vmlinux.kallsyms}" ] ; then
> +		strip_debug=-Wl,--strip-debug
> +	fi
> +
>  	if [ "${SRCARCH}" != "um" ]; then
>  		objects="--whole-archive			\
>  			${KBUILD_VMLINUX_OBJS}			\
> @@ -79,6 +85,7 @@ vmlinux_link()
>  			${@}"
>  
>  		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\
> +			${strip_debug#-Wl,}			\
>  			-o ${output}				\
>  			-T ${lds} ${objects}
>  	else
> @@ -91,6 +98,7 @@ vmlinux_link()
>  			${@}"
>  
>  		${CC} ${CFLAGS_vmlinux}				\
> +			${strip_debug}				\
>  			-o ${output}				\
>  			-Wl,-T,${lds}				\
>  			${objects}				\
> @@ -106,6 +114,8 @@ gen_btf()
>  {
>  	local pahole_ver
>  	local bin_arch
> +	local bin_format
> +	local bin_file
>  
>  	if ! [ -x "$(command -v ${PAHOLE})" ]; then
>  		echo >&2 "BTF: ${1}: pahole (${PAHOLE}) is not available"
> @@ -118,8 +128,9 @@ gen_btf()
>  		return 1
>  	fi
>  
> -	info "BTF" ${2}
>  	vmlinux_link ${1}
> +
> +	info "BTF" ${2}
>  	LLVM_OBJCOPY=${OBJCOPY} ${PAHOLE} -J ${1}
>  
>  	# dump .BTF section into raw binary file to link with final vmlinux
> @@ -127,11 +138,12 @@ gen_btf()
>  		cut -d, -f1 | cut -d' ' -f2)
>  	bin_format=$(LANG=C ${OBJDUMP} -f ${1} | grep 'file format' | \
>  		awk '{print $4}')
> +	bin_file=.btf.vmlinux.bin
>  	${OBJCOPY} --change-section-address .BTF=0 \
>  		--set-section-flags .BTF=alloc -O binary \
> -		--only-section=.BTF ${1} .btf.vmlinux.bin
> +		--only-section=.BTF ${1} $bin_file
>  	${OBJCOPY} -I binary -O ${bin_format} -B ${bin_arch} \
> -		--rename-section .data=.BTF .btf.vmlinux.bin ${2}
> +		--rename-section .data=.BTF $bin_file ${2}
>  }
>  
>  # Create ${2} .o file with all symbols from the ${1} object file
> @@ -166,8 +178,8 @@ kallsyms()
>  kallsyms_step()
>  {
>  	kallsymso_prev=${kallsymso}
> -	kallsymso=.tmp_kallsyms${1}.o
> -	kallsyms_vmlinux=.tmp_vmlinux${1}
> +	kallsyms_vmlinux=.tmp_vmlinux.kallsyms${1}
> +	kallsymso=${kallsyms_vmlinux}.o
>  
>  	vmlinux_link ${kallsyms_vmlinux} "${kallsymso_prev}" ${btf_vmlinux_bin_o}
>  	kallsyms ${kallsyms_vmlinux} ${kallsymso}
> @@ -190,7 +202,6 @@ cleanup()
>  {
>  	rm -f .btf.*
>  	rm -f .tmp_System.map
> -	rm -f .tmp_kallsyms*
>  	rm -f .tmp_vmlinux*
>  	rm -f System.map
>  	rm -f vmlinux
> @@ -257,9 +268,8 @@ tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
>  
>  btf_vmlinux_bin_o=""
>  if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
> -	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
> -		btf_vmlinux_bin_o=.btf.vmlinux.bin.o
> -	else
> +	btf_vmlinux_bin_o=.btf.vmlinux.bin.o
> +	if ! gen_btf .tmp_vmlinux.btf $btf_vmlinux_bin_o ; then
>  		echo >&2 "Failed to generate BTF for vmlinux"
>  		echo >&2 "Try to disable CONFIG_DEBUG_INFO_BTF"
>  		exit 1
> -- 
> 2.20.1
> 
> 
> -- 
> Kees Cook

-- 
Kees Cook
