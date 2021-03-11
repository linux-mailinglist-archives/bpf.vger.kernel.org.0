Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1A2337167
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 12:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhCKLbs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 06:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232701AbhCKLbd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 06:31:33 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94AB0C061574
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:31:33 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id bm21so45500316ejb.4
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=shReJa4AgIfLUWHCUqyNFfkucc6ll1o83cioDojSEyA=;
        b=SJ91y3ZGCR0RFq8qvq85hLkFV4sjQqqRxEU5t5tG1dZnpQb+nlWYnss+cjWkDE3ZR8
         z419v0HZmfWW5SIxUCi4m7Z4+vlvpCXUWARQQDMLQpsiwO0f8uJGg8x+g3Mur++BIADA
         qPAaL5ZJ/T0Txr9PUJzEpZNL6j4hNQddtuYGS+XgCLmYNOTvNdERkYyrb6dm3WgxFN8x
         FQu0mEN5D3WJSzM/qiaI6fMdY7IxLr6dvT5I0KJiYQiC2nEB/2uH34svn2U6KZ4YyHOD
         jouGcrvY4muUxX/M7AYMtnDaMMoQyjt6Au/zACBH+zEeRkhq+4yTqZGCtMD1bdKEEL2V
         K8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=shReJa4AgIfLUWHCUqyNFfkucc6ll1o83cioDojSEyA=;
        b=o7jzZce3ngedvrvpFb+OvTPYCULwIBnIeEKByzNnSd621pNSzSjS4gBxr8rh8OKg/t
         4DLwXblioQss/2924BDXzRr8YbnRjeyCwPzjDqpwyAlR/ibxI3OfMWhWl9OnwLu0BObi
         8FGzAoNqtWktmcrV5ACLaVoyP47RVNJQkv3zQulyeCHITr97G23DGcNH1TjY25+LAS9S
         zWCvhcsZ4ABVmFOA7rUpsvycl3nRomb6mpfVDhmLwc+hNXbMQRSGgNlaf0FY8uR4q8qB
         cjRI3H2+dFy6zjOD2r/WMUfQSA9DUILnpWgcVx0Az5wpOm2jm9VkdPAyuwmz8xdSpdBG
         DVQQ==
X-Gm-Message-State: AOAM5304zhD5XHVK3DvvwvUrs5LS4aLCgLj6oUIOv6xscPo2JSuWubDI
        Mzu43QSBB8dzHDwNouZqMGXPEw==
X-Google-Smtp-Source: ABdhPJy9h2zVYQA3nuvS/DToLhBm7WYxTe7009GkSPpP34Jvb1tvjRR7hFIGd+yDMPlrhXb20m106g==
X-Received: by 2002:a17:906:cb11:: with SMTP id lk17mr2511315ejb.405.1615462292335;
        Thu, 11 Mar 2021 03:31:32 -0800 (PST)
Received: from [192.168.1.8] ([194.35.119.86])
        by smtp.gmail.com with ESMTPSA id i6sm1168932ejz.95.2021.03.11.03.31.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 03:31:31 -0800 (PST)
Subject: Re: [PATCH bpf-next 07/10] bpftool: add `gen bpfo` command to perform
 BPF static linking
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, ast@fb.com, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20210310040431.916483-1-andrii@kernel.org>
 <20210310040431.916483-8-andrii@kernel.org>
From:   Quentin Monnet <quentin@isovalent.com>
Message-ID: <9f44eedf-79a3-0025-0f31-ee70f2f7d98b@isovalent.com>
Date:   Thu, 11 Mar 2021 11:31:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210310040431.916483-8-andrii@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2021-03-09 20:04 UTC-0800 ~ Andrii Nakryiko <andrii@kernel.org>
> Add `bpftool gen bpfo <output-file> <input_file>...` command to statically
> link multiple BPF object files into a single output BPF object file.
> 
> Similarly to existing '*.o' convention, bpftool is establishing a '*.bpfo'
> convention for statically-linked BPF object files. Both .o and .bpfo suffixes
> will be stripped out during BPF skeleton generation to infer BPF object name.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/bpf/bpftool/gen.c | 46 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 4033c46d83e7..8b1ed6c0a62f 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> +static int do_bpfo(int argc, char **argv)

> +{
> +	struct bpf_linker *linker;
> +	const char *output_file, *file;
> +	int err;
> +
> +	if (!REQ_ARGS(2)) {
> +		usage();
> +		return -1;
> +	}
> +
> +	output_file = GET_ARG();
> +
> +	linker = bpf_linker__new(output_file, NULL);
> +	if (!linker) {
> +		p_err("failed to create BPF linker instance");
> +		return -1;
> +	}
> +
> +	while (argc) {
> +		file = GET_ARG();
> +
> +		err = bpf_linker__add_file(linker, file);
> +		if (err) {
> +			p_err("failed to link '%s': %d", file, err);

I think you mentioned before that your preference was for having just
the error code instead of using strerror(), but I think it would be more
user-friendly for the majority of users who don't know the error codes
if we had something more verbose? How about having both strerror()
output and the error code?

> +			goto err_out;
> +		}
> +	}
> +
> +	err = bpf_linker__finalize(linker);
> +	if (err) {
> +		p_err("failed to finalize ELF file: %d", err);
> +		goto err_out;
> +	}
> +
> +	return 0;
> +err_out:
> +	bpf_linker__free(linker);
> +	return -1;

Should you call bpf_linker__free() even on success? I see that
bpf_linker__finalize() frees some of the resources, but it seems that
bpf_linker__free() does a more thorough job?

> +}
> +
>  static int do_help(int argc, char **argv)
>  {
>  	if (json_output) {
> @@ -611,6 +654,7 @@ static int do_help(int argc, char **argv)
>  
>  static const struct cmd cmds[] = {
>  	{ "skeleton",	do_skeleton },
> +	{ "bpfo",	do_bpfo },
>  	{ "help",	do_help },
>  	{ 0 }
>  };
> 

Please update the usage help message, man page, and bash completion,
thanks. Especially because what "bpftool gen bpfo" does is not intuitive
(but I don't have a better name suggestion at the moment).

Great work!

Quentin
