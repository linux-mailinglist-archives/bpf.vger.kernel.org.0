Return-Path: <bpf+bounces-17513-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE0080EA8D
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 12:39:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DABF81F21D07
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A175D4B8;
	Tue, 12 Dec 2023 11:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="SQ6tjqvM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29FCF3
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 03:39:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40c29f7b068so52633435e9.0
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 03:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1702381174; x=1702985974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3eTpG9+Sp30KtcMXJiTaWbmd8wwOfc4qawWrG0WCSqM=;
        b=SQ6tjqvM2f38vE8yK7ly3C64yXbzwhCt0UCp6iL4kGmUvagpPztmiYR5vPBEmOqBOj
         ZSn81eHzoXezNS7DZwYe/xAc84QSc1a80+nxeJvKfu51l6QgnRJHdoVznUYjV9epXa9x
         wdB7GIBHRAiN7485kS+mBTA9uk72NwBNz7JUuIkfQIjgIjBSIkG+9Ud3/68cCCAPnNvX
         BBKYdiqZ6fh5Ad9QUtLiAbL0xeglGd2xSw41sIrhJbL/tF/T9hJIpujm5yFA3uOaA0Mt
         RoH4tTLMGZDIlEj452ZfJllapesSc819c8h8f0uwL8KLqTx4oguXLJtwERrpq6pouykN
         Ri5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702381174; x=1702985974;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3eTpG9+Sp30KtcMXJiTaWbmd8wwOfc4qawWrG0WCSqM=;
        b=hLq/T2+UCab/4J9DtSmEjnNEC7Svj2hmiAXijd9q/34WkhcetIslTgCaiDormb6nES
         MDe2lEhdxBRRSedf/oZVRU3lyCxCpjXbynaNbWgpHRLRVQcyUK+bE+aNZheXe/uRPdmc
         cskRQK1PnRqA2dIUzpnuQYRL1rK7cFXzDD7GNzMNqUNbApn1nxOBbYnO98gHEK5IL+m8
         O1ylx8eaq7+CMCCdiTzYecDrMYCPlSkcVsMcJNrjwRSVolUcRbtKCMydjN2Y20zJFCMP
         GHQfYWuxMAUPb39DpNWCZNOVs/WU0ktF0HzTl9UV80IaGGP5Nq2rcdTcQBg0UCBw0xy3
         yQbg==
X-Gm-Message-State: AOJu0YwRpPkaiuhIGZtFMPmQG4xjVpKkCXx5nyHt0RUGAEceu4WQtEfE
	cKHxciRPfySXBlRagHVqKgKFaoUk5vhLGj3kzwgd9vfo
X-Google-Smtp-Source: AGHT+IETBcqiPG0mrVhv9oGgE6f4kCQYtTvinJ5pqo6t5/v7+VoUMVhZKIcBBRgrjJngbf7/CXE/Qg==
X-Received: by 2002:a05:600c:4f11:b0:40c:295f:1195 with SMTP id l17-20020a05600c4f1100b0040c295f1195mr2975341wmq.55.1702381174336;
        Tue, 12 Dec 2023 03:39:34 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:dd4d:f876:85f4:3d21? ([2a02:8011:e80c:0:dd4d:f876:85f4:3d21])
        by smtp.gmail.com with ESMTPSA id f11-20020a5d664b000000b003333e71ef9asm10611768wrw.115.2023.12.12.03.39.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Dec 2023 03:39:33 -0800 (PST)
Message-ID: <baee9fb4-7559-4ba2-a254-7388bb6caa63@isovalent.com>
Date: Tue, 12 Dec 2023 11:39:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 2/3] bpftool: add attribute preserve_static_offset for
 context types
Content-Language: en-GB
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, ast@kernel.org
Cc: andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 kernel-team@fb.com, yonghong.song@linux.dev, alan.maguire@oracle.com
References: <20231212023136.7021-1-eddyz87@gmail.com>
 <20231212023136.7021-3-eddyz87@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20231212023136.7021-3-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2023-12-12 02:32 UTC+0000 ~ Eduard Zingerman <eddyz87@gmail.com>
> When printing vmlinux.h emit attribute preserve_static_offset [0] for
> types that are used as context parameters for BPF programs. To avoid
> hacking libbpf dump logic emit forward declarations annotated with
> attribute. Such forward declarations have to come before structure
> definitions.
> 
> Only emit such forward declarations when context types are present in
> target BTF (identified by name).
> 
> C language standard wording in section "6.7.2.1 Structure and union
> specifiers" [1] is vague, but example in 6.7.2.1.21 explicitly allows
> such notation, and it matches clang behavior.
> 
> Here is how 'bpftool btf gen ... format c' looks after this change:
> 
>     #ifndef __VMLINUX_H__
>     #define __VMLINUX_H__
> 
>     #if !defined(BPF_NO_PRESERVE_STATIC_OFFSET) && \
>         __has_attribute(preserve_static_offset)
>     #pragma clang attribute push \
>               (__attribute__((preserve_static_offset)), apply_to = record)
> 
>     struct bpf_cgroup_dev_ctx;
>     ...
> 
>     #pragma clang attribute pop
>     #endif
> 
>     ... rest of the output unchanged ...
> 
> This is a follow up for discussion in thread [2].
> 
> [0] https://clang.llvm.org/docs/AttributeReference.html#preserve-static-offset
> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
> [2] https://lore.kernel.org/bpf/20231208000531.19179-1-eddyz87@gmail.com/
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/bpf/bpftool/btf.c | 131 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index 91fcb75babe3..2abe71194afb 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -460,11 +460,118 @@ static void __printf(2, 0) btf_dump_printf(void *ctx,
>  	vfprintf(stdout, fmt, args);
>  }
>  
> +static const char * const context_types[] = {
> +	"bpf_cgroup_dev_ctx",
> +	"bpf_nf_ctx",
> +	"bpf_perf_event_data",
> +	"bpf_raw_tracepoint_args",
> +	"bpf_sk_lookup",
> +	"bpf_sock",
> +	"bpf_sock_addr",
> +	"bpf_sock_ops",
> +	"bpf_sockopt",
> +	"bpf_sysctl",
> +	"__sk_buff",
> +	"sk_msg_md",
> +	"sk_reuseport_md",
> +	"xdp_md",
> +	"pt_regs",
> +};

Hi, and thanks for this!

Apologies for missing the discussion on v1. Reading through the previous
thread I see that they were votes in favour of the hard-coded approach,
but I would ask folks to please reconsider.

I'm not keen on taking this list in bpftool, it doesn't seem to be the
right place for that. I understand there's no plan to add new mirror
context structs, but if we change policy for whatever reason, we're sure
to miss the update in this list and that's a bug in bpftool. If bpftool
ever gets ported to Windows and Windows needs support for new structs,
that's more juggling to do to support multiple platforms. And if any
tool other than bpftool needs to generate vmlinux.h headers in the
future, it's back to square one - although by then there might be extra
pushback for changing the BTF, if bpftool already does the work.

Like Alan, I rather share your own inclination towards the more generic
declaration tags approach, if you don't mind the additional work.

Quentin

