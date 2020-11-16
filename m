Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685382B5172
	for <lists+bpf@lfdr.de>; Mon, 16 Nov 2020 20:46:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgKPTqE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 14:46:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgKPTqE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 14:46:04 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B2E012075A;
        Mon, 16 Nov 2020 19:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605555963;
        bh=/+xXvI2ETifngASo+n380WxmfkRkW6lYKn5v2q9WRhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HWue5QrPF8iXpZanFb3wu7K2KraHU25NKW3MDLT7mWUQlPX4oNYg2fCNSNNMSvp0z
         y7bq/p1wI1jwKkKpUiHIqp6L9G2V3ndMzyztEdBe0/mZh17j/FtvKE/HlGmlN0imv7
         9SOUwKKRH/PsSwlTPw8F59jiVht1kgh5WWYYM+UU=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F7C140E29; Mon, 16 Nov 2020 16:46:01 -0300 (-03)
Date:   Mon, 16 Nov 2020 16:46:01 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCH] btf_encoder: Move btf_elf__verbose/btf_elf__force setup
Message-ID: <20201116194601.GH614220@kernel.org>
References: <20201116193348.1222960-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116193348.1222960-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Nov 16, 2020 at 08:33:48PM +0100, Jiri Olsa escreveu:
> With introduction of collect_symbols function, we moved the
> percpu variables code before btf_elf__verbose/btf_elf__force
> setup, so they don't have any effect in that code anymore.
> 
> Also btf_elf__verbose is used in code that prepares ftrace
> filter for functions generations, also called within
> collect_symbols function.
> 
> Moving btf_elf__verbose/btf_elf__force setup early in the
> cu__encode_btf function, so we can get verbose messages
> and see the effect of the force option.



Thanks, applied.

- Arnaldo

 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  btf_encoder.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index f3f6291391ee..4f856cfd5577 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -540,6 +540,9 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  	struct tag *pos;
>  	int err = 0;
>  
> +	btf_elf__verbose = verbose;
> +	btf_elf__force = force;
> +
>  	if (btfe && strcmp(btfe->filename, cu->filename)) {
>  		err = btf_encoder__encode();
>  		if (err)
> @@ -579,8 +582,6 @@ int cu__encode_btf(struct cu *cu, int verbose, bool force,
>  		}
>  	}
>  
> -	btf_elf__verbose = verbose;
> -	btf_elf__force = force;
>  	type_id_off = btf__get_nr_types(btfe->btf);
>  
>  	cu__for_each_type(cu, core_id, pos) {
> -- 
> 2.26.2
> 

-- 

- Arnaldo
