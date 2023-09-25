Return-Path: <bpf+bounces-10732-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 610527AD32C
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 10:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 430AE28178F
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 08:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11111C99;
	Mon, 25 Sep 2023 08:19:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EF711C8D
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 08:19:11 +0000 (UTC)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB5ACC0
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 01:19:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5041d6d8b10so9541813e87.2
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695629948; x=1696234748; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VTlR1LwL+VFEFEYXu2kaz4IK2E1xFexX8tm4532GLl8=;
        b=Lapzvuqav5qZZwrcPOqra+j6/S0AbwPnywEXFtycRZjeLyAfV3t8EoXQrHJFtSGDS6
         NTw/kinEQto0TY+ryoz62u/tsQB97Zp0y3TyjGVq+7+HMsvQP2CtNhcR3eRc/oxSd2mj
         i8KjqYSzvZXKPWlykon78zHWkU8qIL5VkiRYZcjCIK9nvbu82ODR3J0lYA0TthLsSmnx
         0en9j7i6f6TZl/zCsSmBTAZvHPkPt9tNKtlEdj2V/SL9+v0tPJR3Fa3diDACxom6/bO5
         NsTaL/q7RAS+RxDQbLYv0sQokIrCDrIrgK+7YnrtZHKG75gVDLHMN5TyPoZD5PYbMu60
         L1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695629948; x=1696234748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTlR1LwL+VFEFEYXu2kaz4IK2E1xFexX8tm4532GLl8=;
        b=Tf+hm/8BWiOrTzULPWzfNE6cOr4MLbDItsPSaUGDM21++phdKRNAvHvVe8S6EVryO/
         YlHMWhQXpaun/rCchJ/56Ub2P4BoSZ7s0cRNOiKcdgr0dOxxmtDlzn+jq6pneqoKb8x4
         aQF8uas6Xdipw5sFclOhC0CJNCcmklSB3TPJf8T0Je+KPE5KWkGf7ucoJGExef9Eex0x
         0tdG/M9LJyOANqNCLdxCgot1KA+/K4R8CzRcTMaLHUaZ5ZGLaKEoCG2jT7Ww9ht9GUFb
         bKuBNHpI5ndpxlLuUBd1f1OPJIJtsI+Qu4OhUgaIiKIxVQ46q6Y1/i99wNkRV8WzrN83
         Mp9Q==
X-Gm-Message-State: AOJu0YxP7N1NtL0qiRmTZNZ3YlhfNlNBpsaB6FoH65PFLOVGH5xjIp5p
	2cmsZGiZ/HjLd2Ck90I0wCU=
X-Google-Smtp-Source: AGHT+IEH3UPtVhNyhDXgsSeZTzkU+Yp9RC8CjvU7u9Jaeyg/BNPG+/5OtAeZRhWmrYTmAJ90VuMlEA==
X-Received: by 2002:a05:6512:110f:b0:502:ab7b:e480 with SMTP id l15-20020a056512110f00b00502ab7be480mr5987432lfg.36.1695629947435;
        Mon, 25 Sep 2023 01:19:07 -0700 (PDT)
Received: from krava (37-188-188-137.red.o2.cz. [37.188.188.137])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c1d9300b0040531f5c51asm11646575wms.5.2023.09.25.01.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 01:19:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 Sep 2023 10:19:03 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow Golang symbols in uprobe secdef
Message-ID: <ZRFCd6sY5bp29JRB@krava>
References: <20230925025722.46580-1-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925025722.46580-1-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 25, 2023 at 02:57:22AM +0000, Hengqi Chen wrote:
> Golang symbols in ELF files are different from C/C++
> which contains special characters like '*', '(' and ')'.
> With generics, things get more complicated, there are
> symbols like:
> 
>   github.com/cilium/ebpf/internal.(*Deque[go.shape.interface {
>    Format(fmt.State, int32); TypeName() string;
>   github.com/cilium/ebpf/btf.copy() github.com/cilium/ebpf/btf.Type
>   }]).Grow
> 
> Add " ()*,-/;[]{}" (in alphabetical order) to support matching
> against such symbols. Note that ']' and '-' should be the first
> and last characters in the %m range as sscanf required.
> 
> A working example can be found at this repo ([0]).
> 
>   [0]: https://github.com/chenhengqi/libbpf-go-symbols
> 
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b4758e54a815..de0e068195ab 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
>  
>  	*link = NULL;
>  
> -	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li",
> +	n = sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[]a-zA-Z0-9 ()*,./;@[_{}-]+%li",
>  		   &probe_type, &binary_path, &func_name, &offset);

could you please make that work for uprobe.multi (attach_uprobe_multi)
as well?

it uses %ms at the moment and it seems it won't get pass the space
in the symbol name

thanks,
jirka

>  	switch (n) {
>  	case 1:
> -- 
> 2.34.1
> 
> 

