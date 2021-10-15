Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DE142F173
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 14:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239031AbhJOMyO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 08:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239291AbhJOMyH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 08:54:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32C8C60ED4;
        Fri, 15 Oct 2021 12:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302321;
        bh=Xc/QwLh4lpZWDyacqoAIE1hYNsKJzWckAbVJdtS63aQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KyHg0XkWvurtSz3ckZ9DhZGfCVzVop1VLBdWmXF/oRHtR7GlSsERhzJZVN4gmaxk8
         qSYl1DS0TODbxj5kkMCaMo6+SOCBHLuyteRBqOUfV2WN1DFCknSf1Z3Aquxd2F3iZN
         c4WVsHtQ8OJzb+TyKLLINabxX3h/fbhQNURFK5PeS88Gn5HakMxnl5BbulWy5sLHW3
         3Y9NNDnEHwyCo22AFvBzjsZq33omtftHqhQu6cgiY0Zcdf/NVsfuH0xCxs5VMnCZjv
         eHVceE148PoRSYdMxm869kiErQFQGTlNtDeMXQ4fGWxZepH2Sop5LA+wBM1d2m6fS8
         Wh23cyXlpbRUA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 74FDB410A1; Fri, 15 Oct 2021 09:51:58 -0300 (-03)
Date:   Fri, 15 Oct 2021 09:51:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>,
        Petar Penkov <ppenkov@google.com>
Subject: Re: [PATCH] btf_encoder: Make BTF_KIND_TAG conditional
Message-ID: <YWl5bq4m60EGo0JY@kernel.org>
References: <20211014212049.1010192-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211014212049.1010192-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Oct 14, 2021 at 02:20:49PM -0700, Ian Rogers escreveu:
> BTF_KIND_TAG is present in libbtf 6.0 but not libbtf in 5.15rc4. Make
> the code requiring it conditionally compiled in.

Thanks, applied.

I just removed the part updating lib/bpf, as I have updated it recently:

⬢[acme@toolbox pahole]$ git show cc6c7d473d51832490aa7b743a0ed7f7f9e05592
commit cc6c7d473d51832490aa7b743a0ed7f7f9e05592
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Thu Oct 14 16:27:07 2021 -0300

    Update libbpf to get API to combine BTF
    
    I.e. the one in:
    
     13ebb60ab66799ab libbpf: Add API that copies all BTF types from one BTF object to another
    
    This will be used to paralellize the BTF encoding phase.
    
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/lib/bpf b/lib/bpf
index 980777cc16db75d5..92c1e61a605410b1 160000
--- a/lib/bpf
+++ b/lib/bpf
@@ -1 +1 @@
-Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
+Subproject commit 92c1e61a605410b16d6330fdd4a7a4e03add86d4
⬢[acme@toolbox pahole]$ git log --oneline -3
cad8b8b840d621cd (HEAD -> master) btf_encoder: Make BTF_KIND_TAG conditional
a9c99e98815f06bd dwarves: Introduce conf_load->thread_exit() callback
cc6c7d473d518324 Update libbpf to get API to combine BTF
⬢[acme@toolbox pahole]$

- Arnaldo
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  btf_encoder.c | 7 +++++++
>  lib/bpf       | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index c341f95..400d64b 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -141,7 +141,9 @@ static const char * const btf_kind_str[NR_BTF_KINDS] = {
>  	[BTF_KIND_VAR]          = "VAR",
>  	[BTF_KIND_DATASEC]      = "DATASEC",
>  	[BTF_KIND_FLOAT]        = "FLOAT",
> +#ifdef BTF_KIND_TAG /* BTF_KIND_TAG was added in 6.0 */
>  	[BTF_KIND_TAG]          = "TAG",
> +#endif
>  };
>  
>  static const char *btf__printable_name(const struct btf *btf, uint32_t offset)
> @@ -648,6 +650,7 @@ static int32_t btf_encoder__add_datasec(struct btf_encoder *encoder, const char
>  static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *value, uint32_t type,
>  				    int component_idx)
>  {
> +#ifdef BTF_KIND_TAG /* Proxy for libbtf 6.0 */
>  	struct btf *btf = encoder->btf;
>  	const struct btf_type *t;
>  	int32_t id;
> @@ -663,6 +666,10 @@ static int32_t btf_encoder__add_tag(struct btf_encoder *encoder, const char *val
>  	}
>  
>  	return id;
> +#else
> +        fprintf(stderr, "error: unable to encode BTF_KIND_TAG due to old libbtf\n");
> +        return -ENOTSUP;
> +#endif
>  }
>  
>  /*
> diff --git a/lib/bpf b/lib/bpf
> index 980777c..986962f 160000
> --- a/lib/bpf
> +++ b/lib/bpf
> @@ -1 +1 @@
> -Subproject commit 980777cc16db75d5628a537c892aefc2640bb242
> +Subproject commit 986962fade5dfa89c2890f3854eb040d2a64ab38
> -- 
> 2.33.0.1079.g6e70778dc9-goog
