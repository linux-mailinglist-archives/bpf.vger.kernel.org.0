Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075432B6C9E
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 19:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgKQSJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 13:09:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:53248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725808AbgKQSJr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 13:09:47 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F5762462E;
        Tue, 17 Nov 2020 18:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605636586;
        bh=ba1jxnREVtGGxG5sOJgs3Q5ynpcW1c5uZnFTmBA7y0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dIVaPqn5H0XWWRPqmzSnqm7AXUUBETg8LMEXRJ+uHcSHQ01Ur5F5TUNlRI5aOffLP
         OovfYwyaUuPrDUAMrPOz0ku3BYTcoj5WaW+hm/TOKEGbVi/V8zULYcZxeewsJOScWl
         umZA+KjbEEv1trrv1B5MwE2x8j4mgKi8jhIZFnCA=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E2FA340E29; Tue, 17 Nov 2020 15:09:43 -0300 (-03)
Date:   Tue, 17 Nov 2020 15:09:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH] btf_encoder: Use better fallback message
Message-ID: <20201117180943.GW614220@kernel.org>
References: <20201116202458.1228654-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116202458.1228654-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 16, 2020 at 09:24:58PM +0100, Jiri Olsa escreveu:
> Using more suitable fallback message for the case when the
> ftrace filter can't be used because of missing symbols.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 4f856cfd5577..592b31e2cdc9 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -510,7 +510,7 @@ static int collect_symbols(struct btf_elf *btfe, bool collect_percpu_vars)
>  			printf("Found %d functions!\n", functions_cnt);
>  	} else {
>  		if (btf_elf__verbose)
> -			printf("vmlinux not detected, falling back to dwarf data\n");
> +			printf("ftrace symbols not detected, falling back to DWARF data\n");
>  		delete_functions();
>  	}
>  
> -- 
> 2.26.2
> 

-- 

- Arnaldo
