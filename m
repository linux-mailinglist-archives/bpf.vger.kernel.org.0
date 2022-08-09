Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D692C58DF48
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344184AbiHISoG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 14:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344412AbiHISnp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 14:43:45 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDACB2CE29
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:18:55 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 5774E240106
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 20:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1660069133; bh=NGCo6G97/D+DFJHZEJlgWxPMh8d5YJ9QKfmC0rdGXPg=;
        h=Date:From:To:Cc:Subject:From;
        b=P/mxWtIU+OhwQ0G3Uxiusi2rd9Vegpev4L6kn5k0jNSHX+CTLlDbfJdyydrracDuO
         qBnDiDVSl6RxS9ARPNktSNfOR0BWvRDacnPGj4Y79+ADCB1zg8chRQ5CxjZtbBIqHs
         UaOau8SAS0EPEY0qMGuhaNl2krDGRS5oS0x1zTGtae70imGR51kU7xU5wanB9q/26V
         f/nkyghmxfyOcmS128S7yA/UKAK2IQspLtEi/5TXWLXlFFEsM4t1bcGJsNdtZXE1+2
         pBQB0k0Tty7yXZt+CTJue2oqXl2HfrVcmX3j6fpiAKlM9kpFVhWNGRmcE8VZw3LzJa
         7L4WDsRPTyVow==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4M2LtL13Xqz6tn7;
        Tue,  9 Aug 2022 20:18:49 +0200 (CEST)
Date:   Tue,  9 Aug 2022 18:18:45 +0000
From:   Daniel =?utf-8?Q?M=C3=BCller?= <deso@posteo.net>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, kpsingh@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Fix vmtest.sh getopts
 optstring
Message-ID: <20220809181845.bkmrgogdgd3divfj@muellerd-fedora-PC2BDTX9>
References: <cover.1660064925.git.dxu@dxuuu.xyz>
 <0f93b56198328b6b4da7b4cf4662d05c3edb5fd2.1660064925.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f93b56198328b6b4da7b4cf4662d05c3edb5fd2.1660064925.git.dxu@dxuuu.xyz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:11:10AM -0600, Daniel Xu wrote:
> Before, you could see the following errors:
> 
> ```
> $ ./vmtest.sh -j
> ./vmtest.sh: option requires an argument -- j
> ./vmtest.sh: line 357: OPTARG: unbound variable
> 
> $ ./vmtest.sh -z
> ./vmtest.sh: illegal option -- z
> ./vmtest.sh: line 357: OPTARG: unbound variable
> ```
> 
> Fix by adding ':' as first character of optstring. Reason is that
> getopts requires ':' as the first character for OPTARG to be set in the
> `?` and `:` error cases.
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/testing/selftests/bpf/vmtest.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index 976ef7585b33..a29aa05ebb3e 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -333,7 +333,7 @@ main()
>  	local exit_command="poweroff -f"
>  	local debug_shell="no"
>  
> -	while getopts 'hskid:j:' opt; do
> +	while getopts ':hskid:j:' opt; do
>  		case ${opt} in
>  		i)
>  			update_image="yes"
> -- 
> 2.37.1
> 

I tested with this change and it worked fine for me. One thing to consider
pointing out more clearly in the description is that ':' as the first character
of the optstring switches getopts to silent mode. The desire to run in this mode
seems to have been there all along, as the script takes care of reporting
errors.

Acked-by: Daniel Müller <deso@posteo.net>
