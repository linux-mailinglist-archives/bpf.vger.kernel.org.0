Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFE142F188
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 14:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235793AbhJOMz0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 08:55:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:54580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234376AbhJOMzZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 15 Oct 2021 08:55:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D24860F56;
        Fri, 15 Oct 2021 12:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634302399;
        bh=I7fuA6e/iDc9aNOqvdYlh5qnta1s26Zw+3KRiQBcCP0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KNUi1JVaxaWjTYIXeKW/w/UHL2bYnGqaKVGjbD1XitZZktrkA8tmowsq3xpzxgKSW
         CXRkpvTMHO+7BFFf/mn4XlU9N0xRdpwhjJq849QQ1zhfS7Acs2IQZa25tVxBbHSDb/
         LHOBbgB/1pA8fLY7xQAZ2KAQHHdqQEPFeq2S2G2erxvL6+9BWZLP9zZGQvBXFEHStb
         GDnrZiObjDpI8ChBixjwzVZY1A9T64q2PZoYIhcVut5aGfDN5is6ihUnCbB7k/tVEP
         kq+LSOfZfsA4ALF7gqcFKNQZ9S8ft67X9VICLP0bCi7SChmiUHY2gQ5UuCYnSCg062
         H8D8B6J8ZgMVA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EEAE8410A1; Fri, 15 Oct 2021 09:53:15 -0300 (-03)
Date:   Fri, 15 Oct 2021 09:53:15 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH dwarves] dwarf_loader: Fix heap overflow when accessing
 variable specification
Message-ID: <YWl5u2j7kHNLIbPT@kernel.org>
References: <20211012022521.399302-1-iii@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012022521.399302-1-iii@linux.ibm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Tue, Oct 12, 2021 at 04:25:21AM +0200, Ilya Leoshkevich escreveu:
> Variables can be allocated with or without specification, however,
> tag__recode_dwarf_type() always tries accessing it, leading to heap
> read overflows and subsequent logic bugs.
> 
> Fix by introducing a bit that tracks whether or not specification is
> present.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  dwarf_loader.c | 15 ++++++++++-----
>  dwarves.h      |  1 +
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/dwarf_loader.c b/dwarf_loader.c
> index 48e1bf0..60bdca3 100644
> --- a/dwarf_loader.c
> +++ b/dwarf_loader.c
> @@ -723,6 +723,7 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu, struct conf
>  		var->external = dwarf_hasattr(die, DW_AT_external);
>  		/* non-defining declaration of an object */
>  		var->declaration = dwarf_hasattr(die, DW_AT_declaration);
> +		var->has_specification = has_specification;
>  		var->scope = VSCOPE_UNKNOWN;
>  		INIT_LIST_HEAD(&var->annots);
>  		var->ip.addr = 0;
> @@ -2291,12 +2292,16 @@ static int tag__recode_dwarf_type(struct tag *tag, struct cu *cu)
>  		goto find_type;
>  	case DW_TAG_variable: {
>  		struct variable *var = tag__variable(tag);
> -		dwarf_off_ref specification = dwarf_tag__spec(dtag);
>  
> -		if (specification.off) {
> -			dtype = dwarf_cu__find_tag_by_ref(cu->priv, &specification);
> -			if (dtype)
> -				var->spec = tag__variable(dtype->tag);
> +		if (var->has_specification) {
> +			dwarf_off_ref specification = dwarf_tag__spec(dtag);
> +
> +			if (specification.off) {
> +				dtype = dwarf_cu__find_tag_by_ref(cu->priv,
> +								  &specification);
> +				if (dtype)
> +					var->spec = tag__variable(dtype->tag);
> +			}
>  		}
>  	}
>  
> diff --git a/dwarves.h b/dwarves.h
> index 30d33fa..20608dd 100644
> --- a/dwarves.h
> +++ b/dwarves.h
> @@ -691,6 +691,7 @@ struct variable {
>  	const char	 *name;
>  	uint8_t		 external:1;
>  	uint8_t		 declaration:1;
> +	uint8_t		 has_specification:1;
>  	enum vscope	 scope;
>  	struct location	 location;
>  	struct hlist_node tool_hnode;
> -- 
> 2.31.1

-- 

- Arnaldo
