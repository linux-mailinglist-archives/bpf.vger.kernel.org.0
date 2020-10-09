Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EE3288D41
	for <lists+bpf@lfdr.de>; Fri,  9 Oct 2020 17:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbgJIPrv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Oct 2020 11:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbgJIPrv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Oct 2020 11:47:51 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92D7D2225D;
        Fri,  9 Oct 2020 15:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602258470;
        bh=xAgnsnvhm1RZoOPPGKAdrj4OFZpiyERphzPOiP4RC/Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAnVwkDPy/8MPci2vhUziaS632YJURXNU+vBmpftby4bIRhz2Ib2OwH0AjrNtfHMQ
         bDdAw4YBDAyWkgLe12kRLyMbJqKenwtV85C+p+WRzvVkhImbifFiBLH7uyY9rMaFN7
         PI4IaQwGQmHSBqrAJcuXzFyOwdzQTGmdrZvw4uf0=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F2C1C403AC; Fri,  9 Oct 2020 12:47:47 -0300 (-03)
Date:   Fri, 9 Oct 2020 12:47:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org, kernel-team@fb.com,
        ast@kernel.org, Andrii Nakryiko <andriin@fb.com>
Subject: Re: [PATCH v2 dwarves 4/8] btf_encoder: discard CUs after BTF
 encoding
Message-ID: <20201009154747.GB322246@kernel.org>
References: <20201008234000.740660-1-andrii@kernel.org>
 <20201008234000.740660-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008234000.740660-5-andrii@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 08, 2020 at 04:39:56PM -0700, Andrii Nakryiko escreveu:
> From: Andrii Nakryiko <andriin@fb.com>
> 
> When doing BTF encoding/deduping, DWARF CUs are never used after BTF encoding
> is done, so there is no point in wasting memory and keeping them in memory. So
> discard them immediately.

Right now, yes, but DW_TAG_partial_unit may require we keep them around.

I'm applying the patch since the common case, the kernel, is not yet
using that DWARF compression technique.

- Arnaldo
 
> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  pahole.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/pahole.c b/pahole.c
> index 61522175519e..bd9b993777ee 100644
> --- a/pahole.c
> +++ b/pahole.c
> @@ -2384,7 +2384,7 @@ static enum load_steal_kind pahole_stealer(struct cu *cu,
>  			fprintf(stderr, "Encountered error while encoding BTF.\n");
>  			exit(1);
>  		}
> -		return LSK__KEEPIT;
> +		return LSK__DELETE;
>  	}
>  
>  	if (ctf_encode) {
> -- 
> 2.24.1
> 

-- 

- Arnaldo
