Return-Path: <bpf+bounces-9610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7256A799D93
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 11:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03541281475
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 09:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F997257E;
	Sun, 10 Sep 2023 09:53:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8AA49
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 09:53:29 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B84CCD
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:27 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-31adc5c899fso3629609f8f.2
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694339606; x=1694944406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=instIEKq+uD1AghMVaKEvO9/7oGWL8WlAyTf55PpG44=;
        b=hXRob6MDdWOFrnbUXI0wHqzubBjlEr00zEovLb/UxUBtUfCxH1w3hCu+zxb0E3rBHO
         i0ei8UQorUXS0T3kcRk39S9GsprQjI33OrrgqzhCI6NZyIDTcD/yH8qwIZkF6siR+IH3
         vx5Ep2zEFxjxjnMFsSn+UecdgylT7mpMFFQVaqPMyIRbIPPhRtuOSCrLOxAAZ0SIyjDC
         +iEzGlHvrw5ZjHHH30wn5EzOEFQ/HtQu40tK91ZGHUfKxIkSC6VKeGnyC2waIkNHds5O
         sbhUzDE27uB3vvcG30Mh9h/2zuTs0LgItDz34o/0SZ6Fcg9Q1cdD5K8e+I8IX9+suPmh
         rm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694339606; x=1694944406;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=instIEKq+uD1AghMVaKEvO9/7oGWL8WlAyTf55PpG44=;
        b=v1qgmomcB5dhPHpAUcwvrlZ/BgwVtdtVcR+sXciPsWD7e61UBP+mEIzO1/9/o7gBrN
         Rtal/TyYGB8LnolLc21kAc4ku+QyMv3kvbbdP1FsIP2fb3mrpYhQQDGpZhFCwGDM/WcK
         3bSJ1qHadv1g9gOm/5w2OgJBOgKuq3gieG2SeCLsr8U8SuWqPqS6Tmhmv1+vd4OUjdl3
         cZvNq8+kfRZfJz5SNTZ1t1UonlCLY1bMhM5iVBb8Eis4ey5AkcJFaww5XmRwuxgGBAa3
         4WjbKGYfUXNNayQHvcsFsC5Vvzc+lPWzQrj/5iIw3E0IgSeM6kjgNkC3jmNVPmA5nJ3s
         IqqA==
X-Gm-Message-State: AOJu0YyGV3zhhxh0BTSDt8Nz0loLJpqphoz4miS2KavSw5K5HGZsWtaO
	+a1oqdU/6ymDFoUjp2Q7gV3eQfRNTw8=
X-Google-Smtp-Source: AGHT+IGIvdW4KvH3XybJJJM/Yqvpi+8Z0sFiBqiSvVWOzAHkC+C3T+D4AU4ic3SFLBXE3L1ngOicYQ==
X-Received: by 2002:a5d:6952:0:b0:319:854f:7b02 with SMTP id r18-20020a5d6952000000b00319854f7b02mr5751628wrw.51.1694339606159;
        Sun, 10 Sep 2023 02:53:26 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id g8-20020a5d4888000000b0031912c0ffebsm6879417wrq.23.2023.09.10.02.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:53:25 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 11:53:23 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v2 2/3] libbpf: Support symbol versioning for
 uprobe
Message-ID: <ZP2SEyyS5RFdZzaY@krava>
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-3-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905151257.729192-3-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 03:12:56PM +0000, Hengqi Chen wrote:
> In current implementation, we assume that symbol found in .dynsym section
> would have a version suffix and use it to compare with symbol user supplied.
> According to the spec ([0]), this assumption is incorrect, the version info
> of dynamic symbols are stored in .gnu.version and .gnu.version_d sections
> of ELF objects. For example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>       706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>       2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>       2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> In this case, specify pthread_rwlock_wrlock@@GLIBC_2.34 or
> pthread_rwlock_wrlock@GLIBC_2.2.5 in bpf_uprobe_opts::func_name won't work.
> Because the qualified name does NOT match `pthread_rwlock_wrlock` (without
> version suffix) in .dynsym sections.
> 
> This commit implements the symbol versioning for dynsym and allows user to
> specify symbol in the following forms:
>   - func
>   - func@LIB_VERSION
>   - func@@LIB_VERSION
> 
> In case of symbol conflicts, error out and users should resolve it by
> specifying a qualified name.
> 
>   [0]: https://refspecs.linuxfoundation.org/LSB_5.0.0/LSB-Core-generic/LSB-Core-generic/symversion.html
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

I have a question below, but other than that

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


SNIP

> @@ -119,6 +148,7 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
>  	struct elf_sym *ret = &iter->sym;
>  	GElf_Sym *sym = &ret->sym;
>  	const char *name = NULL;
> +	GElf_Versym versym;
>  	Elf_Scn *sym_scn;
>  	size_t idx;
> 
> @@ -138,12 +168,112 @@ static struct elf_sym *elf_sym_iter_next(struct elf_sym_iter *iter)
> 
>  		iter->next_sym_idx = idx + 1;
>  		ret->name = name;
> +		ret->ver = 0;
> +		ret->hidden = false;
> +
> +		if (iter->versyms) {
> +			if (!gelf_getversym(iter->versyms, idx, &versym))
> +				continue;
> +			ret->ver = versym & VERSYM_VERSION;
> +			ret->hidden = versym & VERSYM_HIDDEN;

the doc mentions value 1 being special, also I can see readelf
code checking on that.. is that taken into account?

> +		}
>  		return ret;
>  	}
> 
>  	return NULL;
>  }
> 

SNIP

