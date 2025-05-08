Return-Path: <bpf+bounces-57746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BFCAAF6F1
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E816F4E5E81
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E12F264A9E;
	Thu,  8 May 2025 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x3P+h+XL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A281A263F4E
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 09:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746697328; cv=none; b=tUu1zyKjxlAxYWDFsZW56DKv4+2Q76WUP+R0xzgl6FA/Oa6doP242uFd/BuPi+pFhF2MSY0vb1mT1ls26ZRfVDsIzJ7RqiRiOEAX5BRYEfKuuGNyQQ/CNqHi97m69qwwSjKSCMIy0HgQf4HXEVhNSXFbBSbIoyUpifHOgz06dk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746697328; c=relaxed/simple;
	bh=J067uXZvi44Be/SgOzzTwDN+a6z8Q/IT4jrx7NJWnK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOlIQEsSNgeBvkA1H6UAOiqyHNBOakXJlo2zF3b7CixyxuFkwclZHIki84f9yOPitDEEApCZ7cqHqF/+YWqNwPbpPpGaQPQaP4KYGFzCGj9kCNs9rUvZRTdmmbbybqIYtFAJgae6bHTfz1Z3zGkd4ucArIPp+YUvpjGiMLv053A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x3P+h+XL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5f6fb95f431so3590452a12.0
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 02:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746697324; x=1747302124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=liejZjw7pIEpAq6TRxpWI/WghoIaNsbactZpU4edoXU=;
        b=x3P+h+XLWedDcb8dOkmRs+T1r59v6m/A7+q+9jgkTZwqT3DGC8PoGuWwUujTGSL5qD
         dko9H/tP4YpXnvLL2oMaMTnj3rSGISDVdxbg7z+Z7cHSCOLxqFsoOTvwOyYmIUJnYJIR
         ahY96dlbUPrM+f+PW8i+tQyRzLalO+45MViMBKf+DZSxPPu8lvvVxuMiWuzqfHg0Dno0
         VakbSGVIOpSA0LcaRm9LJWA69ab+LxjgmytrV/q+PYk8TD84DSmxYOB/1O7KkFuEZ6wM
         yVn0GJFUze6ISlMvugeAVoUMHtKSsJWIqOzbnlEeGL5JgkCR8/SyOW3MHraQEE9fAuZd
         NUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746697324; x=1747302124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liejZjw7pIEpAq6TRxpWI/WghoIaNsbactZpU4edoXU=;
        b=UPbAujTf3jBImaNV0uqVZ9FbDGta+ZO1UGu0yH9TfYctxFqc/YHeWp0bZDAvu/4C7b
         GjC/70pzfg6iHqQ9LeDCZWR4vRSc7boXmuukgSaSRsQAPceiLvZ4+5oojDdtnE6pWOCv
         /Hh4c6n4oElwBbIq1eSYhAGEOSSlHGXbRNNAfjB3GQwoRXbHyOktCNpOeWf5SF4Elx8+
         PUb7cQMe/ZzVaObm7HOJadDE/3DCwuZlhDyuVEmJHO4NTTapeE4W5FfgYb2ra1qHVcXa
         K/gn62K3kQXwYfstm6/XdFlYiqBhW0p94HyynhmnHf9HR/WCBQd7VdYrLFTSSxZwfN+j
         90hg==
X-Gm-Message-State: AOJu0YxqIBL6Lb9rVgypMy5XpLcz+Gkzx9yiHKPEyHK/BVBRSUo1W9pf
	4yAs7wJnmf2OwUHihYC88P4HMD+KJRVQjrEWq4l81rZOI0+aSbzuZ63wBhEmzA==
X-Gm-Gg: ASbGncudJaYmo0ZGEcwjfl4AExIFL4s4zSROQPv3yfnxcZJiAIZW3DZJBvOyypLXYPo
	Bll6dv69PofSC6nSP0UspcR0kBbx8V0goYFN/QCQ1KaoVJyqvrr71Ehs1Uq7l/gGXw8HPG0L0jQ
	vuOT9cau4DY79UGymWJ4aZiCeJy2BRCA+G6h2V2Gj8P17tMHjr+2NRPwrRSIKFNjYj+J6WpjeTw
	UHfYHLi0P8ahQiW/NHkTKWwEgsGvlcApl4rBPWGJaIfnQ9kLwgPvGvypqbBmd7ee8sEoSL76cXD
	KhBK8mmAMAg84HNl0msyzcoOQ4VNlY31U7HVYcm+TM+8vmiimR0Rl6cZkwPR83XevQDF25odjUW
	ipLsarMrPtuLvaGpgrg==
X-Google-Smtp-Source: AGHT+IFVkO48ehe9jh0t7Bs7msdSn9xoh8j+AbhH9spLI8J10SOVC795RwzfUps1US0K/zCU3WnNMA==
X-Received: by 2002:a17:907:3cc2:b0:ace:be7c:11df with SMTP id a640c23a62f3a-ad1fcb5aa75mr286359166b.6.1746697323617;
        Thu, 08 May 2025 02:42:03 -0700 (PDT)
Received: from google.com (201.31.90.34.bc.googleusercontent.com. [34.90.31.201])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1895087d1sm1054180766b.128.2025.05.08.02.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 02:42:02 -0700 (PDT)
Date: Thu, 8 May 2025 09:41:58 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf-next v4 3/4] bpf: Add kfuncs for read-only string
 operations
Message-ID: <aBx8Zjux0bSgtV04@google.com>
References: <cover.1746598898.git.vmalik@redhat.com>
 <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19913411da8c08170d959207e28262efc0a5d813.1746598898.git.vmalik@redhat.com>

On Wed, May 07, 2025 at 08:40:38AM +0200, Viktor Malik wrote:
> String operations are commonly used so this exposes the most common ones
> to BPF programs. For now, we limit ourselves to operations which do not
> copy memory around.
> 
> Unfortunately, most in-kernel implementations assume that strings are
> %NUL-terminated, which is not necessarily true, and therefore we cannot
> use them directly in the BPF context. Instead, we open-code them using
> __get_kernel_nofault instead of plain dereference to make them safe and
> limit the strings length to XATTR_SIZE_MAX to make sure the functions
> terminate. When __get_kernel_nofault fails, functions return -EFAULT.
> Similarly, when the size bound is reached, the functions return -E2BIG.

Curious, why was XATTR_SIZE_MAX chosen as the upper bounds here? Just
an arbitrary value that felt large enough?

> At the moment, strings can be passed to the kfuncs in three forms:
> - string literals (i.e. pointers to read-only maps)
> - global variables (i.e. pointers to read-write maps)
> - stack-allocated buffers
> 
> Note that currently, it is not possible to pass strings from the BPF
> program context (like function args) as the verifier doesn't treat them
> as neither PTR_TO_MEM nor PTR_TO_BTF_ID.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  kernel/bpf/helpers.c | 440 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 440 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index e3a2662f4e33..8fb7c2ca7ac0 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/btf_ids.h>
>  #include <linux/bpf_mem_alloc.h>
>  #include <linux/kasan.h>
> +#include <linux/uaccess.h>
>  
>  #include "../../lib/kstrtox.h"
>  
> @@ -3194,6 +3195,433 @@ __bpf_kfunc void bpf_local_irq_restore(unsigned long *flags__irq_flag)
>  	local_irq_restore(*flags__irq_flag);
>  }
>  
> +/* Kfuncs for string operations.
> + *
> + * Since strings are not necessarily %NUL-terminated, we cannot directly call
> + * in-kernel implementations. Instead, we open-code the implementations using
> + * __get_kernel_nofault instead of plain dereference to make them safe.
> + */

Returning an -EFAULT error code for supplied arguments which are
deemed to be invalid is just a very weird semantic IMO. As a BPF
program author, I totally wouldn't expect a BPF kfunc to return
-EINVAL if I had supplied it something that it couldn't quite possibly
handle to begin with. Look at the prior art, being pre-existing BPF
kfuncs, and you'll see how they handle invalidly supplied arguments. I
totally understand that attempting to dereference a NULL-pointer would
ultimately result in a fault being raised, so it may feel rather
natural to also report an -EFAULT error code upon doing some
NULL-pointer checks that hold true, but from an API usability POV it
just seems awkward and wrong.

Another thing that I noticed was that none of these BPF kfunc
arguments make use of the parameter suffixes i.e. __str, __sz. Why is
that exactly? Will leaning on those break you in some way?

> +/**
> + * bpf_strcmp - Compare two strings
> + * @s1: One string
> + * @s2: Another string
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1 is smaller
> + * * %1       - @s2 is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + */
> +__bpf_kfunc int bpf_strcmp(const char *s1, const char *s2)
> +{
> +	char c1, c2;
> +	int i;
> +
> +	if (!s1 || !s2)
> +		return -EFAULT;
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c1, s1, char, err_out);
> +		__get_kernel_nofault(&c2, s2, char, err_out);
> +		if (c1 != c2)
> +			return c1 < c2 ? -1 : 1;
> +		if (c1 == '\0')
> +			return 0;
> +		s1++;
> +		s2++;
> +	}
> +	return -E2BIG;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strchr - Find the first occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and can
> + * be searched for.
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @c within @s
> + * * %NULL        - @c not found in @s
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strchr(const char *s, char c)
> +{
> +	char sc;
> +	int i;
> +
> +	if (!s)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&sc, s, char, err_out);
> +		if (sc == c)
> +			return s;
> +		if (sc == '\0')
> +			return NULL;
> +		s++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strnchr - Find a character in a length limited string
> + * @s: The string to be searched
> + * @count: The number of characters to be searched
> + * @c: The character to search for
> + *
> + * Note that the %NUL-terminator is considered part of the string, and can
> + * be searched for.
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @c within @s
> + * * %NULL        - @c not found in the first @count characters of @s
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strnchr(const char *s, size_t count, char c)
> +{
> +	char sc;
> +	int i;
> +
> +	if (!s)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&sc, s, char, err_out);
> +		if (sc == c)
> +			return s;
> +		if (sc == '\0')
> +			return NULL;
> +		s++;
> +	}
> +	return i == XATTR_SIZE_MAX ? ERR_PTR(-E2BIG) : NULL;
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strchrnul - Find and return a character in a string, or end of string
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @c within @s or pointer
> + *                  to the null byte at the end of @s when @c is not found
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strchrnul(const char *s, char c)
> +{
> +	char sc;
> +	int i;
> +
> +	if (!s)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&sc, s, char, err_out);
> +		if (sc == '\0' || sc == c)
> +			return s;
> +		s++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strrchr - Find the last occurrence of a character in a string
> + * @s: The string to be searched
> + * @c: The character to search for
> + *
> + * Return:
> + * * const char * - Pointer to the last occurrence of @c within @s
> + * * %NULL        - @c not found in @s
> + * * %-EFAULT     - Cannot read @s
> + * * %-E2BIG      - @s too large
> + */
> +__bpf_kfunc const char *bpf_strrchr(const char *s, int c)
> +{
> +	const char *last = NULL;
> +	char sc;
> +	int i;
> +
> +	if (!s)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&sc, s, char, err_out);
> +		if (sc == '\0')
> +			return last;
> +		if (sc == c)
> +			last = s;
> +		s++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strlen - Calculate the length of a string
> + * @s: The string
> + *
> + * Return:
> + * * >=0      - The length of @s
> + * * %-EFAULT - Cannot read @s
> + * * %-E2BIG  - @s too large
> + */
> +__bpf_kfunc int bpf_strlen(const char *s)
> +{
> +	char c;
> +	int i;
> +
> +	if (!s)
> +		return -EFAULT;
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c, s, char, err_out);
> +		if (c == '\0')
> +			return i;
> +		s++;
> +	}
> +	return -E2BIG;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strlen - Calculate the length of a length-limited string
> + * @s: The string
> + * @count: The maximum number of characters to count
> + *
> + * Return:
> + * * >=0      - The length of @s
> + * * %-EFAULT - Cannot read @s
> + * * %-E2BIG  - @s too large
> + */
> +__bpf_kfunc int bpf_strnlen(const char *s, size_t count)
> +{
> +	char c;
> +	int i;
> +
> +	if (!s)
> +		return -EFAULT;
> +
> +	guard(pagefault)();
> +	for (i = 0; i < count && i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c, s, char, err_out);
> +		if (c == '\0')
> +			return i;
> +		s++;
> +	}
> +	return i == XATTR_SIZE_MAX ? -E2BIG : i;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strspn - Calculate the length of the initial substring of @s which only
> + *              contains letters in @accept
> + * @s: The string to be searched
> + * @accept: The string to search for
> + *
> + * Return:
> + * * >=0      - The length of the initial substring of @s which only contains
> + *              letter in @accept
> + * * %-EFAULT - Cannot read @s
> + * * %-E2BIG  - @s too large
v> + */
> +__bpf_kfunc int bpf_strspn(const char *s, const char *accept)
> +{
> +	const char *p;
> +	char c;
> +	int i;
> +
> +	if (!s || !accept)
> +		return -EFAULT;
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c, s, char, err_out);
> +		p = bpf_strchr(accept, c);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +		if (c == '\0' || !p)
> +			return i;
> +		s++;
> +	}
> +	return -E2BIG;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * strcspn - Calculate the length of the initial substring of @s which does not
> + *           contain letters in @reject
> + * @s: The string to be searched
> + * @reject: The string to avoid
> + *
> + * Return:
> + * * >=0      - The length of the initial substring of @s which does not contain
> + *              letters from @reject
> + * * %-EFAULT - Cannot read @s
> + * * %-E2BIG  - @s too large
> + */
> +__bpf_kfunc int bpf_strcspn(const char *s, const char *reject)
> +{
> +	const char *p;
> +	char c;
> +	int i;
> +
> +	if (!s || !reject)
> +		return -EFAULT;
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c, s, char, err_out);
> +		p = bpf_strchr(reject, c);
> +		if (IS_ERR(p))
> +			return PTR_ERR(p);
> +		if (c == '\0' || p)
> +			return i;
> +		s++;
> +	}
> +	return -E2BIG;
> +err_out:
> +	return -EFAULT;
> +}
> +
> +/**
> + * bpf_strpbrk - Find the first occurrence of a set of characters
> + * @s: The string to be searched
> + * @accept: The characters to search for
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of a character from @accept
> + *                  within @s
> + * * %NULL        - No character from @accept found in @s
> + * * %-EFAULT     - Cannot read one of the strings
> + * * %-E2BIG      - One of the strings is too large
> + */
> +__bpf_kfunc const char *bpf_strpbrk(const char *s, const char *accept)
> +{
> +	const char *p;
> +	char c;
> +	int i;
> +
> +	if (!s || !accept)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		__get_kernel_nofault(&c, s, char, err_out);
> +		if (c == '\0')
> +			return NULL;
> +		p = bpf_strchr(accept, c);
> +		if (IS_ERR(p))
> +			return p;
> +		if (p)
> +			return s;
> +		s++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strstr - Find the first substring in a string
> + * @s1: The string to be searched
> + * @s2: The string to search for
> + *
> + * Return:
> + * * const char * - Pointer to the first occurrence of @s2 within @s1
> + * * %NULL        - @s2 is not a substring of @s1
> + * * %-EFAULT     - Cannot read one of the strings
> + * * %-E2BIG      - One of the strings is too large
> + */
> +__bpf_kfunc const char *bpf_strstr(const char *s1, const char *s2)
> +{
> +	char c1, c2;
> +	int i, j;
> +
> +	if (!s1 || !s2)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		for (j = 0; j < XATTR_SIZE_MAX; j++) {
> +			__get_kernel_nofault(&c1, s1 + j, char, err_out);
> +			__get_kernel_nofault(&c2, s2 + j, char, err_out);
> +			if (c2 == '\0')
> +				return s1;
> +			if (c1 == '\0')
> +				return NULL;
> +			if (c1 != c2)
> +				break;
> +		}
> +		if (j == XATTR_SIZE_MAX)
> +			return ERR_PTR(-E2BIG);
> +		s1++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
> +/**
> + * bpf_strnstr - Find the first substring in a length-limited string
> + * @s1: The string to be searched
> + * @s2: The string to search for
> + * @len: the maximum number of characters to search

Return: ...?

> + */
> +__bpf_kfunc const char *bpf_strnstr(const char *s1, const char *s2, size_t len)
> +{
> +	char c1, c2;
> +	int i, j;
> +
> +	if (!s1 || !s2)
> +		return ERR_PTR(-EFAULT);
> +
> +	guard(pagefault)();
> +	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +		for (j = 0; i + j < len && j < XATTR_SIZE_MAX; j++) {
> +			__get_kernel_nofault(&c1, s1 + j, char, err_out);
> +			__get_kernel_nofault(&c2, s2 + j, char, err_out);
> +			if (c2 == '\0')
> +				return s1;
> +			if (c1 == '\0')
> +				return NULL;
> +			if (c1 != c2)
> +				break;
> +		}
> +		if (j == XATTR_SIZE_MAX)
> +			return ERR_PTR(-E2BIG);
> +		if (i + j == len)
> +			return NULL;
> +		s1++;
> +	}
> +	return ERR_PTR(-E2BIG);
> +err_out:
> +	return ERR_PTR(-EFAULT);
> +}
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3294,6 +3722,18 @@ BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLE
>  BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, bpf_local_irq_save)
>  BTF_ID_FLAGS(func, bpf_local_irq_restore)
> +BTF_ID_FLAGS(func, bpf_strcmp);
> +BTF_ID_FLAGS(func, bpf_strchr, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_strchrnul);
> +BTF_ID_FLAGS(func, bpf_strnchr, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_strrchr, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_strlen);
> +BTF_ID_FLAGS(func, bpf_strnlen);
> +BTF_ID_FLAGS(func, bpf_strspn);
> +BTF_ID_FLAGS(func, bpf_strcspn);
> +BTF_ID_FLAGS(func, bpf_strpbrk, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_strstr, KF_RET_NULL);
> +BTF_ID_FLAGS(func, bpf_strnstr, KF_RET_NULL);
>  BTF_KFUNCS_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> -- 
> 2.49.0
> 

