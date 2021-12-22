Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC347D3FF
	for <lists+bpf@lfdr.de>; Wed, 22 Dec 2021 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343598AbhLVOz6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Dec 2021 09:55:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237161AbhLVOz6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 22 Dec 2021 09:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640184957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nkcjVw5y18pCBW7twaTfbXiufW/aX23gdHn1VVALoHM=;
        b=MFa2fq4qRxD69s14UFffnjuw95703hZ9kTFNGERaypYxD4i0yXXPn+trTPz3QcfjNuOLs8
        kHL2pKWxw4+PEYk94hS9m79I+eafIoc2nlmnJmafGqAB+IjhHPu2ovhXIeiw3xSoYt0lBO
        UfdQC5dzDO3sg8fER2HAPqej7gPgZu0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-151-YsKO8MaSPUq1ckW8zdgudg-1; Wed, 22 Dec 2021 09:55:56 -0500
X-MC-Unique: YsKO8MaSPUq1ckW8zdgudg-1
Received: by mail-wm1-f71.google.com with SMTP id az35-20020a05600c602300b00345812649ddso830708wmb.8
        for <bpf@vger.kernel.org>; Wed, 22 Dec 2021 06:55:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nkcjVw5y18pCBW7twaTfbXiufW/aX23gdHn1VVALoHM=;
        b=Qs0SNfjxUlz13fRFTBSmiqqAtsFcw46lU9PlbFMLqkiQiWN5/shdwQq4bYAbQjYgSb
         njFvAu2GtOZ+YpohAW9b47oRo3agDvtOHxfRlG2Lo0NtTp/HGL31zH53UEzqYPMebVD6
         vwI2wjl7BOjZyIGpOdJywmW54ddYipIyYY77GACzffPk6kw6N72IVbWU3wEYUkNZwJE7
         qTbvWJ29GlaujLxyPLJ1b0f7LFugTJkXTrtRPnjGKQCbp/48JIYJ88eNotRIlMIJB3Gr
         6+QsDhjZrhuw2uBS7SD2KtMFC4mmlmCbHBOFkHxvh2eXX6HX8gLNQomoo3m7xGDMc8WJ
         qGcw==
X-Gm-Message-State: AOAM531YPxeLFlN9dTuB8p6FjZhjaKjetRNFTSoq83IT4MhaKeklhMJb
        Ulu2DVAD9H318eccNG6v3o2EqET+AXlUTB65hO7Rrt0uxN1+CdVBfe5WhtbBbOBh88n46M86v+z
        hfvn4UCGzKBxI
X-Received: by 2002:a05:600c:3583:: with SMTP id p3mr1199524wmq.180.1640184954931;
        Wed, 22 Dec 2021 06:55:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwLc7RwzSjL/80WBJG1n0biyiRv2yFlANjarJDEnXGWFzq54S0uBOLI1V92R09MH0grQXy0PQ==
X-Received: by 2002:a05:600c:3583:: with SMTP id p3mr1199508wmq.180.1640184954684;
        Wed, 22 Dec 2021 06:55:54 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id u19sm2049256wmq.30.2021.12.22.06.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:55:54 -0800 (PST)
Date:   Wed, 22 Dec 2021 15:55:52 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH v2 bpf-next 4/9] libbpf: ensure btf_dump__new() and
 btf_dump_opts are future-proof
Message-ID: <YcM8eAFRIlLZmE59@krava>
References: <20211111053624.190580-1-andrii@kernel.org>
 <20211111053624.190580-5-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111053624.190580-5-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 10, 2021 at 09:36:19PM -0800, Andrii Nakryiko wrote:
> Change btf_dump__new() and corresponding struct btf_dump_ops structure
> to be extensible by using OPTS "framework" ([0]). Given we don't change
> the names, we use a similar approach as with bpf_prog_load(), but this
> time we ended up with two APIs with the same name and same number of
> arguments, so overloading based on number of arguments with
> ___libbpf_override() doesn't work.
> 
> Instead, use "overloading" based on types. In this particular case,
> print callback has to be specified, so we detect which argument is
> a callback. If it's 4th (last) argument, old implementation of API is
> used by user code. If not, it must be 2nd, and thus new implementation
> is selected. The rest is handled by the same symbol versioning approach.
> 
> btf_ext argument is dropped as it was never used and isn't necessary
> either. If in the future we'll need btf_ext, that will be added into
> OPTS-based struct btf_dump_opts.
> 
> struct btf_dump_opts is reused for both old API and new APIs. ctx field
> is marked deprecated in v0.7+ and it's put at the same memory location
> as OPTS's sz field. Any user of new-style btf_dump__new() will have to
> set sz field and doesn't/shouldn't use ctx, as ctx is now passed along
> the callback as mandatory input argument, following the other APIs in
> libbpf that accept callbacks consistently.
> 
> Again, this is quite ugly in implementation, but is done in the name of
> backwards compatibility and uniform and extensible future APIs (at the
> same time, sigh). And it will be gone in libbpf 1.0.
> 
>   [0] Closes: https://github.com/libbpf/libbpf/issues/283
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/btf.h      | 51 ++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/btf_dump.c | 31 +++++++++++++++++-------
>  tools/lib/bpf/libbpf.map |  2 ++
>  3 files changed, 71 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 6aae4f62ee0b..45310c65e865 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -267,15 +267,58 @@ LIBBPF_API int btf__dedup_deprecated(struct btf *btf, struct btf_ext *btf_ext, c
>  struct btf_dump;
>  
>  struct btf_dump_opts {
> -	void *ctx;
> +	union {
> +		size_t sz;
> +		void *ctx; /* DEPRECATED: will be gone in v1.0 */
> +	};
>  };
>  
>  typedef void (*btf_dump_printf_fn_t)(void *ctx, const char *fmt, va_list args);
>  
>  LIBBPF_API struct btf_dump *btf_dump__new(const struct btf *btf,
> -					  const struct btf_ext *btf_ext,
> -					  const struct btf_dump_opts *opts,
> -					  btf_dump_printf_fn_t printf_fn);
> +					  btf_dump_printf_fn_t printf_fn,
> +					  void *ctx,
> +					  const struct btf_dump_opts *opts);
> +
> +LIBBPF_API struct btf_dump *btf_dump__new_v0_6_0(const struct btf *btf,
> +						 btf_dump_printf_fn_t printf_fn,
> +						 void *ctx,
> +						 const struct btf_dump_opts *opts);
> +
> +LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
> +						     const struct btf_ext *btf_ext,
> +						     const struct btf_dump_opts *opts,
> +						     btf_dump_printf_fn_t printf_fn);
> +
> +/* Choose either btf_dump__new() or btf_dump__new_deprecated() based on the
> + * type of 4th argument. If it's btf_dump's print callback, use deprecated
> + * API; otherwise, choose the new btf_dump__new(). ___libbpf_override()
> + * doesn't work here because both variants have 4 input arguments.
> + *
> + * (void *) casts are necessary to avoid compilation warnings about type
> + * mismatches, because even though __builtin_choose_expr() only ever evaluates
> + * one side the other side still has to satisfy type constraints (this is
> + * compiler implementation limitation which might be lifted eventually,
> + * according to the documentation). So passing struct btf_ext in place of
> + * btf_dump_printf_fn_t would be generating compilation warning.  Casting to
> + * void * avoids this issue.
> + *
> + * Also, two type compatibility checks for a function and function pointer are
> + * required because passing function reference into btf_dump__new() as
> + * btf_dump__new(..., my_callback, ...) and as btf_dump__new(...,
> + * &my_callback, ...) (not explicit ampersand in the latter case) actually
> + * differs as far as __builtin_types_compatible_p() is concerned. Thus two
> + * checks are combined to detect callback argument.
> + *
> + * The rest works just like in case of ___libbpf_override() usage with symbol
> + * versioning.
> + */
> +#define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(				\
> +	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||		\
> +	__builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),	\
> +	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),	\
> +	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))

hi,
this change breaks bpftrace g++ build that includes btf.h,
because there's no typeof and __builtin_types_compatible_p in c++

I guess there could be some c++ solution doing similar check,
but I wonder we want to polute btf.h with that, I'll need to
check on that

I think I can add some detection code to bpftrace, to find out
which version of btf_dump__new to use

the build error can be generated with test_cpp.cpp below,
so far I'm using __cplusplus ifdef in btf.h to workaround
the issue 

thoughts?

thanks,
jirka


---
diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
index 742a2bf71c5e..bd2d77979571 100644
--- a/tools/lib/bpf/btf.h
+++ b/tools/lib/bpf/btf.h
@@ -314,11 +314,13 @@ LIBBPF_API struct btf_dump *btf_dump__new_deprecated(const struct btf *btf,
  * The rest works just like in case of ___libbpf_override() usage with symbol
  * versioning.
  */
+#ifndef __cplusplus
 #define btf_dump__new(a1, a2, a3, a4) __builtin_choose_expr(				\
 	__builtin_types_compatible_p(typeof(a4), btf_dump_printf_fn_t) ||		\
 	__builtin_types_compatible_p(typeof(a4), void(void *, const char *, va_list)),	\
 	btf_dump__new_deprecated((void *)a1, (void *)a2, (void *)a3, (void *)a4),	\
 	btf_dump__new((void *)a1, (void *)a2, (void *)a3, (void *)a4))
+#endif
 
 LIBBPF_API void btf_dump__free(struct btf_dump *d);
 
diff --git a/tools/testing/selftests/bpf/test_cpp.cpp b/tools/testing/selftests/bpf/test_cpp.cpp
index a8d2e9a87fbf..e00201de2890 100644
--- a/tools/testing/selftests/bpf/test_cpp.cpp
+++ b/tools/testing/selftests/bpf/test_cpp.cpp
@@ -7,9 +7,15 @@
 
 /* do nothing, just make sure we can link successfully */
 
+static void dump_printf(void *ctx, const char *fmt, va_list args)
+{
+}
+
 int main(int argc, char *argv[])
 {
+	struct btf_dump_opts opts = { };
 	struct test_core_extern *skel;
+	struct btf *btf;
 
 	/* libbpf.h */
 	libbpf_set_print(NULL);
@@ -18,7 +24,8 @@ int main(int argc, char *argv[])
 	bpf_prog_get_fd_by_id(0);
 
 	/* btf.h */
-	btf__new(NULL, 0);
+	btf = btf__new(NULL, 0);
+	btf_dump__new(btf, dump_printf, nullptr, &opts);
 
 	/* BPF skeleton */
 	skel = test_core_extern__open_and_load();

