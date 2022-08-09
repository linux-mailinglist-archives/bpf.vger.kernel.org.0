Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33B258DF55
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 20:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245235AbiHISrB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 14:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347170AbiHISpw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 14:45:52 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BDC48C8F
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:20:05 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id BCF9D240029
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 20:19:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660069175; bh=sEkmUijSzri/2YFuSr7hrT1VKhBgjLmd11jEikhP4rs=;
        h=Date:From:To:Cc:Subject:From;
        b=Gjo98Eb6UC1WttuMhado9zk0OupkaXhJLwnr4GA1hsP1k5kNNlW2xmYmSMg3A0cW2
         oU7rmQZjZuQkh3bLO1YpyK0JeFgNjLQ08P4HAGe69RJyNoMshgTLfRwnSpNh+Gm3/N
         Y6Czng+sEWFeJzcWJUsJtAF351EeaFXbjnjNVDu3Uepbqpbcx1NA9SyR22I+yD/y16
         /CGGZljqiFw71QbzYJPl2/3HLY+Q/UrKcOu7EP0oi1NY2fkVFTxBOlvMP0MsKTjJCA
         2/H/hBTOzxVfEQ+HlAJrIksAjVFo4orRpcUqaUhWlTwBblIC/IUl3LzZVM9n3iJexj
         Crb2Q2Zg4va/g==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2Lv91Z90z6tmr;
        Tue,  9 Aug 2022 20:19:33 +0200 (CEST)
Date:   Tue,  9 Aug 2022 18:19:29 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Fix vmtest.sh -h to not
 require root
Message-ID: <20220809181929.qtbhr637dpwhr244@muellerd-fedora-PC2BDTX9>
References: <cover.1660064925.git.dxu@dxuuu.xyz>
 <6a802aa37758e5a7e6aa5de294634f5518005e2b.1660064925.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a802aa37758e5a7e6aa5de294634f5518005e2b.1660064925.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:11:09AM -0600, Daniel Xu wrote:
> Set the exit trap only after argument parsing is done. This way argument
> parse failure or `-h` will not require sudo.
> 
> Reasoning is that it's confusing that a help message would require root
> access.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 32 +++++++++++++--------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index b86ae4a2e5c5..976ef7585b33 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -307,6 +307,20 @@ update_kconfig()
>  	fi
>  }
>  
> +catch()
> +{
> +	local exit_code=$1
> +	local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
> +	# This is just a cleanup and the directory may
> +	# have already been unmounted. So, don't let this
> +	# clobber the error code we intend to return.
> +	unmount_image || true
> +	if [[ -f "${exit_status_file}" ]]; then
> +		exit_code="$(cat ${exit_status_file})"
> +	fi
> +	exit ${exit_code}
> +}
> +
>  main()
>  {
>  	local script_dir="$(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
> @@ -353,6 +367,8 @@ main()
>  	done
>  	shift $((OPTIND -1))
>  
> +	trap 'catch "$?"' EXIT
> +
>  	if [[ $# -eq 0  && "${debug_shell}" == "no" ]]; then
>  		echo "No command specified, will run ${DEFAULT_COMMAND} in the vm"
>  	else
> @@ -409,20 +425,4 @@ main()
>  	fi
>  }
>  
> -catch()
> -{
> -	local exit_code=$1
> -	local exit_status_file="${OUTPUT_DIR}/${EXIT_STATUS_FILE}"
> -	# This is just a cleanup and the directory may
> -	# have already been unmounted. So, don't let this
> -	# clobber the error code we intend to return.
> -	unmount_image || true
> -	if [[ -f "${exit_status_file}" ]]; then
> -		exit_code="$(cat ${exit_status_file})"
> -	fi
> -	exit ${exit_code}
> -}
> -
> -trap 'catch "$?"' EXIT
> -
>  main "$@"
> -- 
> 2.37.1
> 

Makes sense and looks good to me.

Acked-by: Daniel Müller <deso@posteo.net>
