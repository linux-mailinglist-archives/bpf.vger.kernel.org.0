Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1732957D3
	for <lists+bpf@lfdr.de>; Thu, 22 Oct 2020 07:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507878AbgJVFTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 22 Oct 2020 01:19:37 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:44389 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502343AbgJVFTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 22 Oct 2020 01:19:37 -0400
Received: by mail-ej1-f68.google.com with SMTP id a3so371759ejy.11;
        Wed, 21 Oct 2020 22:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qns1Di2gUaT1LMZhyFK8HVEVWemvvafkn9xT3plcb9k=;
        b=oKM+yZdG3NzZSFixUuYA73h1OoDCELbFDWCiUtLvSrXd4WIDiTJMTvyiT8c+oKPQcj
         KO9VVf+DUQ78OzcA9qYkjRspHQ6U+CBTEsW/Uxz3nZimh+fTymh93GGzd4yF4mSX9503
         XXvVpMM8YfEJSr3Qb8agA6VmS2yn+jb6/z8AKa5M+HpnOsZQTBgJTQ46G6oL5kRTFJBK
         JqxzlYQjJytjil3eu7BSVJnBRWCVyRWiwFq4tpD/HP7Ia8PviidpiVjhqZiUv/gYaUCq
         RgleH1uHT648EkkrsfVPbpVFbbyXl5UV6usLZmPluEGmSjmXrsOj75Qcfi7SZ93hgPAN
         5wgQ==
X-Gm-Message-State: AOAM530uM3S/BLZ4vrlWJbFER3mVYWXeJR8pKyhX98NMmHiuGQDeIBBT
        LuNGrLTj+nrN2KRqPEgWKHvWCslxtBU=
X-Google-Smtp-Source: ABdhPJyGqvzN3+vi3NgM9307vrZSvygecZqBvhEH2ycWRfrf9vfxouVttJuWCCw/S/aEeqkemfDT9A==
X-Received: by 2002:a17:906:a00d:: with SMTP id p13mr589698ejy.183.1603343974803;
        Wed, 21 Oct 2020 22:19:34 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id j11sm180790ejk.63.2020.10.21.22.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:19:33 -0700 (PDT)
Subject: Re: [PATCH dwarves] btf_encoder: ignore zero-sized ELF symbols
To:     Andrii Nakryiko <andrii@kernel.org>, dwarves@vger.kernel.org,
        acme@kernel.org
Cc:     bpf@vger.kernel.org
References: <20201021155220.1737964-1-andrii@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <9633d29b-887c-46ec-b131-adda8f69d722@kernel.org>
Date:   Thu, 22 Oct 2020 07:19:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021155220.1737964-1-andrii@kernel.org>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 21. 10. 20, 17:52, Andrii Nakryiko wrote:
> It's legal for ELF symbol to have size 0, if it's size is unknown or
> unspecified. Instead of erroring out, just ignore such symbols, as they can't
> be a valid per-CPU variable anyways.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Tested-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   btf_encoder.c | 12 ++++--------
>   1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 2a6455be4c52..2af1fe447834 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -287,6 +287,10 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
>   		if (!addr)
>   			continue;
>   
> +		size = elf_sym__size(&sym);
> +		if (!size)
> +			continue; /* ignore zero-sized symbols */
> +
>   		sym_name = elf_sym__name(&sym, btfe->symtab);
>   		if (!btf_name_valid(sym_name)) {
>   			dump_invalid_symbol("Found symbol of invalid name when encoding btf",
> @@ -295,14 +299,6 @@ static int find_all_percpu_vars(struct btf_elf *btfe)
>   				continue;
>   			return -1;
>   		}
> -		size = elf_sym__size(&sym);
> -		if (!size) {
> -			dump_invalid_symbol("Found symbol of zero size when encoding btf",
> -					    sym_name, btf_elf__verbose, btf_elf__force);
> -			if (btf_elf__force)
> -				continue;
> -			return -1;
> -		}
>   
>   		if (btf_elf__verbose)
>   			printf("Found per-CPU symbol '%s' at address 0x%lx\n", sym_name, addr);
> 


-- 
js
suse labs
