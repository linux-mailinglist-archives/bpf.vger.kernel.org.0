Return-Path: <bpf+bounces-46063-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F2B9E36D6
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 10:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA7D285407
	for <lists+bpf@lfdr.de>; Wed,  4 Dec 2024 09:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587111AB52F;
	Wed,  4 Dec 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XMTjujnp"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E201ABEB0
	for <bpf@vger.kernel.org>; Wed,  4 Dec 2024 09:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733305279; cv=none; b=sZO5ImEdiPS0ipbRDWUMN6RUYG5v8XT4hNfLfI5iS+ee1NRPfRWXQpdHkOUh++h77RDG5IyhDbf/1ywBuJLaPqOLND2Ib7W21TZ8JqN8w/4olg1Rd8lYAEr5pAf9ZNDTFutMtIeYoWbI8RjUqOwk30i7/cxKWj+y+aDzd2lwvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733305279; c=relaxed/simple;
	bh=jlf3pbjU/cbelUYT6g+zK+ctUklDDfnRgu9HcuRVEUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5MgK6FZGBO2Q8hDvFpYTNla10nO4olDbmsO51cPtwNOPaIBAciSBB54HSOdHQXbW2irPYawW4XuPxC3KSptotnBGxSBhg/1tKDp7ISacEBAfQ1lKTRacmgfsG24UoTtKr5F1juo/9echHAsPEPQpXKUVZ5WNUr+AP+6NtqVmQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XMTjujnp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733305276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNQhvLF91pUzTo1JqNQWXkop/5sbIuwvGYBk0yDFL0c=;
	b=XMTjujnplWC8x5vSyY5keRyhgxN2QMmN2/j2xvHIQS0kQ4AT0/E4P7/1rRRPb7Nx1LJ8Uo
	i+O3u/LnuHj8UO1Fai5bmv+zj7Zi2pubaDTFSRCkhlFA3HgkE6/xqRXGHj8+MQz/sguuFR
	74PTOWMgBVB0zKgy9iK/C5pE1GO+RG8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-1c50-lTxNg-8EMsYWo7JEA-1; Wed, 04 Dec 2024 04:41:15 -0500
X-MC-Unique: 1c50-lTxNg-8EMsYWo7JEA-1
X-Mimecast-MFC-AGG-ID: 1c50-lTxNg-8EMsYWo7JEA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43499c1342aso46592405e9.1
        for <bpf@vger.kernel.org>; Wed, 04 Dec 2024 01:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733305274; x=1733910074;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNQhvLF91pUzTo1JqNQWXkop/5sbIuwvGYBk0yDFL0c=;
        b=YHftz2KE06cK4E4FO3BZ5twj+4xK325LHm00yKoZbfCOe4MFDCpEs31d8icPyb+ec1
         LI87KwrIDX8JlghkfQnB8VjMkacQUhvTiwhg73/MfZfgW04dHaGi0BGZDr9qYc0ZpvHD
         TmSu5QD5PeGy5zc6Sd7dEFcOHR+CBZx+0jrvWW1mFilaD3HRcU+4j0evccemy1Gj9oO9
         0EnNDrKzlaV/EUxXG5llMiNGrJhDap227vdUXBtTmqs2l2H+JFSrivBJEt4V9ihSbGsc
         H+nZerAUmgd8Lj5WeG9nmbgkoVI2CJjmZgUhFtYb5Oe8OUTJwZ+IUahOlU+FYJkRNCTQ
         DQpg==
X-Forwarded-Encrypted: i=1; AJvYcCWbzXSZ5jU38qWwRqBUKnfWwvIKse8LiKTY7p0Ga1Zu8XwgeO2sRyFDZAKFYTHnzBZUX2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPJ/qTrJTetqBcMo2neIewB+dfSMaB4WJN4zko5vExPaBhlTUT
	BuDbH6oWkHPNurO+n9MdBKV2IR70Q+jYulrmCk28/CUNIEOC+Mepuf/GUvttJTtr0trLT5G9868
	H/O/w7IN+2jOAreZs5R2HzSLeJxRtkqoHQ5bJwV6LdiUi12WA
X-Gm-Gg: ASbGncs3fJw6tjkIC+9AUAZ66XRL1anjqd+W06gBx7TKAc0zWcUBooKodqNcfuibc+n
	of7Y8yc0cG0WqTkufgOpCt/vwvCjj0zOpUqEJ6NzwfuuuZYvKZ2uX13D4aC4QPf51RRrgfg09z5
	v8Zz8I5W6TmR3oinVENCVTzrbfedk1izxVIIGLY/CcjADAyNO5TEzWjYlmO1R2fcSj/LFSahqzI
	GRvDgCc3M5Yd6lMYeoHPoj5RkuA8b1BC9GCTPgxsimeHyeIjWWgEUYeNfWDxQ1FLhJrYktp
X-Received: by 2002:a05:6000:1fab:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-385fd3f237cmr5239532f8f.9.1733305274058;
        Wed, 04 Dec 2024 01:41:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFtAIP/DIjf6uApzozS17BII5+mElg1o+Q09YfBmLiPDunEAG1nnoVJEpyaW4BBtrf4I/KbOQ==
X-Received: by 2002:a05:6000:1fab:b0:385:f9db:3c4c with SMTP id ffacd0b85a97d-385fd3f237cmr5239447f8f.9.1733305272467;
        Wed, 04 Dec 2024 01:41:12 -0800 (PST)
Received: from [10.43.17.17] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e940fef3sm11508916f8f.42.2024.12.04.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 01:41:11 -0800 (PST)
Message-ID: <778668f2-bb1a-438e-b075-05a12db726af@redhat.com>
Date: Wed, 4 Dec 2024 10:41:11 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v3] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 martin.lau@linux.dev, kernel-team@fb.com, yonghong.song@linux.dev,
 masahiroy@kernel.org, Stanislav Fomichev <sdf@fomichev.me>
References: <20241203182222.3915763-1-eddyz87@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20241203182222.3915763-1-eddyz87@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/3/24 19:22, Eduard Zingerman wrote:
> Commit [0] breaks samples/bpf build:
> 
>     $ make M=samples/bpf
>     ...
>     make -C /path/to/kernel/samples/bpf/../../tools/lib/bpf \
>      ...
>      EXTRA_CFLAGS=" \
>      ...
>      -fsanitize=bounds \
>      -I/path/to/kernel/usr/include \
>      ...
>     	/path/to/kernel/samples/bpf/libbpf/libbpf.a install_headers
>       CC      /path/to/kernel/samples/bpf/libbpf/staticobjs/libbpf.o
>     In file included from libbpf.c:29:
>     /path/to/kernel/tools/include/linux/err.h:35:8: error: 'inline' can only appear on functions
>        35 | static inline void * __must_check ERR_PTR(long error_)
>           |        ^
> 
> The error is caused by `objtree` variable changing definition from `.`
> (dot) to an absolute path:
> - The variable TPROGS_CFLAGS is constructed as follows:
>   ...
>   TPROGS_CFLAGS += -I$(objtree)/usr/include
> - It is passed as EXTRA_CFLAGS for libbpf compilation:
>   $(LIBBPF): ...
>     ...
> 	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)"
> - Before commit [0], the line passed to libbpf makefile was
>   '-I./usr/include', where '.' referred to LIBBPF_SRC due to -C flag.
>   The directory $(LIBBPF_SRC)/usr/include does not exist and thus
>   was never resolved by C compiler.
> - After commit [0], the line passed to libbpf makefile became:
>   '<output-dir>/usr/include', this directory exists and is resolved by
>   C compiler.
> - Both 'tools/include' and 'usr/include' define files err.h and types.h.
> - libbpf expects headers like 'linux/err.h' and 'linux/types.h'
>   defined in 'tools/include', not 'usr/include', hence the compilation
>   error.
> 
> This commit removes unnecessary -I flags from libbpf compilation.
> (libbpf sets up the necessary includes at lib/bpf/Makefile:63).
> 
> Changes v1 [1] -> v2:
> - dropped unnecessary replacement of KBUILD_OUTPUT with $(objtree)
>   (Andrii)
> Changes v2 [2] -> v3:
> - make sure --sysroot option is set for libbpf's EXTRA_CFLAGS,
>   if $(SYSROOT) is set (Stanislav)
> 
> [0] commit 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> [1] https://lore.kernel.org/bpf/20241202212154.3174402-1-eddyz87@gmail.com/
> [2] https://lore.kernel.org/bpf/20241202234741.3492084-1-eddyz87@gmail.com/
> 
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  samples/bpf/Makefile | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index bcf103a4c14f..96a05e70ace3 100644
> --- a/samples/bpf/Makefile
> +++ b/samples/bpf/Makefile
> @@ -146,13 +146,14 @@ ifeq ($(ARCH), x86)
>  BPF_EXTRA_CFLAGS += -fcf-protection
>  endif
>  
> -TPROGS_CFLAGS += -Wall -O2
> -TPROGS_CFLAGS += -Wmissing-prototypes
> -TPROGS_CFLAGS += -Wstrict-prototypes
> -TPROGS_CFLAGS += $(call try-run,\
> +COMMON_CFLAGS += -Wall -O2
> +COMMON_CFLAGS += -Wmissing-prototypes
> +COMMON_CFLAGS += -Wstrict-prototypes
> +COMMON_CFLAGS += $(call try-run,\
>  	printf "int main() { return 0; }" |\
>  	$(CC) -Werror -fsanitize=bounds -x c - -o "$$TMP",-fsanitize=bounds,)
>  
> +TPROGS_CFLAGS += $(COMMON_CFLAGS)
>  TPROGS_CFLAGS += -I$(objtree)/usr/include
>  TPROGS_CFLAGS += -I$(srctree)/tools/testing/selftests/bpf/
>  TPROGS_CFLAGS += -I$(LIBBPF_INCLUDE)
> @@ -162,7 +163,7 @@ TPROGS_CFLAGS += -I$(srctree)/tools/lib
>  TPROGS_CFLAGS += -DHAVE_ATTR_TEST=0
>  
>  ifdef SYSROOT
> -TPROGS_CFLAGS += --sysroot=$(SYSROOT)
> +COMMON_CFLAGS += --sysroot=$(SYSROOT)
>  TPROGS_LDFLAGS := -L$(SYSROOT)/usr/lib
>  endif
>  
> @@ -229,7 +230,7 @@ clean:
>  
>  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
>  # Fix up variables inherited from Kbuild that tools/ build system won't like
> -	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
> +	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \

I was not quick enough to reply before this got merged, sorry about that.

This will break situations when we want to pass extra flags to the
libbpf sub-make from the command line, e.g. to build samples as PIE:

    $ make TPROGS_USER_CFLAGS="-fpie" TPROGS_USER_LDFLAGS="-pie"
    [...]
    /usr/bin/ld: /bpf/samples/bpf/libbpf/libbpf.a(libbpf-in.o):
relocation R_X86_64_32 against `.rodata.str1.1' can not be used when
making a PIE object; recompile with -fPIE
    /usr/bin/ld: failed to set dynamic section sizes: bad value

I think that we should add

COMMON_CFLAGS = $(TPROGS_USER_CFLAGS)

somewhere to the top of the Makefile.

Viktor


>  		LDFLAGS="$(TPROGS_LDFLAGS)" srctree=$(BPF_SAMPLES_PATH)/../../ \
>  		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>  		$@ install_headers


