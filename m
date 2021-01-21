Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 116012FEE83
	for <lists+bpf@lfdr.de>; Thu, 21 Jan 2021 16:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732608AbhAUPYv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 21 Jan 2021 10:24:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731887AbhAUNYx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 21 Jan 2021 08:24:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA44D206A3;
        Thu, 21 Jan 2021 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611235453;
        bh=JqP2Oo4Z9DKZhCgctkjTNeYNZJSQEIKDv2pP1IWf0zE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VIZSZUvHtcoqJlB/V7JgohFFpEJyjK4uTzSTyizBLQiVxJ5XGovq84oYLyUlIIaX8
         F3EIw2VXNSHr6AstmAgmwx78xqhpHOq80k2Mvi8RTQflGCXNRSrYIrvDl3U44VEqzt
         ZKNWVrKWkpTYQCxMeYAwxt5Eg+tdQBklu1UDB1p88df8kvyDoLAmld7Rybv/btQUUO
         qy56gZsJnEJQkSiKx/6MIOpsTuMbRa7G65YTQzlf4pIBRtZ5DJBEaSOOn+T6o+Gzxo
         i5GPMzB5JylIcNNVxoiFhdjD16aNwYa/eQK4orimopkbMUQGeeqDchPpcfxIsdmpsn
         HhibZk1L3gg8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CF3DF40513; Thu, 21 Jan 2021 10:24:10 -0300 (-03)
Date:   Thu, 21 Jan 2021 10:24:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Giuliano Procida <gprocida@google.com>
Cc:     dwarves@vger.kernel.org, kernel-team@android.com,
        maennich@google.com, ast@kernel.org, andrii@kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH dwarves v2 2/3] btf_encoder: Improve error-handling
 around objcopy
Message-ID: <20210121132410.GZ12699@kernel.org>
References: <20210118160139.1971039-1-gprocida@google.com>
 <20210121113520.3603097-1-gprocida@google.com>
 <20210121113520.3603097-3-gprocida@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121113520.3603097-3-gprocida@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Jan 21, 2021 at 11:35:19AM +0000, Giuliano Procida escreveu:
> * Report the correct filename when objcopy fails.
> * Unlink the temporary file on error.

Thanks, applied.

- Arnaldo

 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Giuliano Procida <gprocida@google.com>
> ---
>  libbtf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/libbtf.c b/libbtf.c
> index 3709087..7552d8e 100644
> --- a/libbtf.c
> +++ b/libbtf.c
> @@ -786,18 +786,19 @@ static int btf_elf__write(const char *filename, struct btf *btf)
>  		if (write(fd, raw_btf_data, raw_btf_size) != raw_btf_size) {
>  			fprintf(stderr, "%s: write of %d bytes to '%s' failed: %d!\n",
>  				__func__, raw_btf_size, tmp_fn, errno);
> -			goto out;
> +			goto unlink;
>  		}
>  
>  		snprintf(cmd, sizeof(cmd), "%s --add-section .BTF=%s %s",
>  			 llvm_objcopy, tmp_fn, filename);
>  		if (system(cmd)) {
>  			fprintf(stderr, "%s: failed to add .BTF section to '%s': %d!\n",
> -				__func__, tmp_fn, errno);
> -			goto out;
> +				__func__, filename, errno);
> +			goto unlink;
>  		}
>  
>  		err = 0;
> +	unlink:
>  		unlink(tmp_fn);
>  	}
>  
> -- 
> 2.30.0.296.g2bfb1c46d8-goog
> 

-- 

- Arnaldo
