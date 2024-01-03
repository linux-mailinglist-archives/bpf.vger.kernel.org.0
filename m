Return-Path: <bpf+bounces-18878-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12DA8233DD
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 18:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D77C91C23CED
	for <lists+bpf@lfdr.de>; Wed,  3 Jan 2024 17:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C411C2AC;
	Wed,  3 Jan 2024 17:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJBpSxEA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A911C680;
	Wed,  3 Jan 2024 17:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d3f3ee00a2so40042935ad.3;
        Wed, 03 Jan 2024 09:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704304340; x=1704909140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1u+y8thQpwuQt5r3QOSdLTyH/3CCtpM+csiirjZfe8=;
        b=RJBpSxEAwP7g/gMhc8FryRXDTGR3Ay9QT0Et9M9Rn6g7wTpKLAvTGYWFn+LjzLinBz
         9RK3/C27suYj1Ir0G9/hnEaymjrHwqaEZ63I2FGgjvz6a3/wVryzO7+jFjpjGGvZK23C
         zWgrsRrVgMojtnM2By9KE7tsD5ClO3pTCHYIVmDbf+ewPDbYe8GOQM46uwIqn9oROpX8
         5MgOaheFc6cyTkovmnGMrgdNwX2Ox9ZFuRGUG9hOs9U/X5LQaA6d+OmbbCvw/upM9TC7
         8caClk6nBaksf4XYTKQj+bJOOYzQUEdUQm72eQn8l2dfyE0Une4or7O0NsqiQ+Ig08Gi
         VvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704304340; x=1704909140;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=c1u+y8thQpwuQt5r3QOSdLTyH/3CCtpM+csiirjZfe8=;
        b=AThDDugukD92LawujO9Pu3bwvWyh7d9QoYEOEVRbtM8B5lgWHAkZvYtx3cse+Q/SUy
         8pu6pF8V41CXqtF08wY89VL1S29u1KxPRoWklCqn37qogWFmjAj58b30JD4NlF1YNGLo
         OVxZtSOMK6q0Jwlqe73qBVyyIwniZ51WIpwSAO8DMzB0Ra3enCV2SDb4mN8o4z5bx+4J
         HIR5zIUq5tyijqEGzdP3OA4tEAAqUqjDVUEmkxdW6av55+M5526WlR6GGki7yLf+YwG2
         tRrDjQq3BshoeF0ApmPsJmuVpDjL4Y4YVLodE9ppeyynCmj0Nq0GdOY9V0471PluYTNk
         IVDw==
X-Gm-Message-State: AOJu0YxMHuXdl6kVBfJO3/ErRHAmzG3uD6/JsdDvZeryAhbnDS43KfM/
	gDUaOppJAjq5+A9hBAneH2w=
X-Google-Smtp-Source: AGHT+IGPI4IYkJpmKzd/vlE3pMbbzTO/+YgqjMtRcr9CXG2OJtYN798ILdz85NK5WgyY8279XJidWg==
X-Received: by 2002:a17:902:d545:b0:1d4:a81b:9cc with SMTP id z5-20020a170902d54500b001d4a81b09ccmr4067078plf.90.1704304339755;
        Wed, 03 Jan 2024 09:52:19 -0800 (PST)
Received: from localhost ([98.97.37.198])
        by smtp.gmail.com with ESMTPSA id z21-20020a1709028f9500b001d46d9953a3sm15702643plo.241.2024.01.03.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 09:52:18 -0800 (PST)
Date: Wed, 03 Jan 2024 09:52:17 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Barret Rhoden <brho@google.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>
Cc: mattbobrowski@google.com, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <65959ed1b9e86_2384720818@john.notmuch>
In-Reply-To: <20240103153307.553838-3-brho@google.com>
References: <20240103153307.553838-1-brho@google.com>
 <20240103153307.553838-3-brho@google.com>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: add inline assembly helpers
 to access array elements
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Barret Rhoden wrote:
> When accessing an array, even if you insert your own bounds check,
> sometimes the compiler will remove the check, or modify it such that the
> verifier no longer knows your access is within bounds.
> 
> The compiler is even free to make a copy of a register, check the copy,
> and use the original to access the array.  The verifier knows the *copy*
> is within bounds, but not the original register!
> 
> Signed-off-by: Barret Rhoden <brho@google.com>
> ---
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  .../bpf/prog_tests/test_array_elem.c          | 112 ++++++++++
>  .../selftests/bpf/progs/array_elem_test.c     | 195 ++++++++++++++++++
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |  43 ++++
>  4 files changed, 351 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/test_array_elem.c
>  create mode 100644 tools/testing/selftests/bpf/progs/array_elem_test.c
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 617ae55c3bb5..651d4663cc78 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -34,7 +34,7 @@ LIBELF_CFLAGS	:= $(shell $(PKG_CONFIG) libelf --cflags 2>/dev/null)
>  LIBELF_LIBS	:= $(shell $(PKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>  
>  CFLAGS += -g $(OPT_FLAGS) -rdynamic					\
> -	  -Wall -Werror 						\
> +	  -dicks -Wall -Werror 						\
>  	  $(GENFLAGS) $(SAN_CFLAGS) $(LIBELF_CFLAGS)			\
>  	  -I$(CURDIR) -I$(INCLUDE_DIR) -I$(GENDIR) -I$(LIBDIR)		\
>  	  -I$(TOOLSINCDIR) -I$(APIDIR) -I$(OUTPUT)
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_array_elem.c b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
> new file mode 100644
> index 000000000000..c953636f07c9
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/test_array_elem.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2024 Google LLC. */
> +#include <test_progs.h>
> +#include "array_elem_test.skel.h"
> +
> +#define NR_MAP_ELEMS 100

[...]

> diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
> index 2fd59970c43a..002bab44cde2 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_misc.h
> +++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
> @@ -135,4 +135,47 @@
>  /* make it look to compiler like value is read and written */
>  #define __sink(expr) asm volatile("" : "+g"(expr))
>  
> +/*
> + * Access an array element within a bound, such that the verifier knows the
> + * access is safe.
> + *
> + * This macro asm is the equivalent of:
> + *
> + *	if (!arr)
> + *		return NULL;
> + *	if (idx >= arr_sz)
> + *		return NULL;
> + *	return &arr[idx];
> + *
> + * The index (___idx below) needs to be a u64, at least for certain versions of
> + * the BPF ISA, since there aren't u32 conditional jumps.
> + */

This is nice, but in practice what we've been doing is making
our maps power of 2 and then just masking them as needed. I think
this is more efficient if you care about performance.

FWIW I'm not opposed to having this though.

> +#define bpf_array_elem(arr, arr_sz, idx) ({				\
> +	typeof(&(arr)[0]) ___arr = arr;					\
> +	__u64 ___idx = idx;						\
> +	if (___arr) {							\
> +		asm volatile("if %[__idx] >= %[__bound] goto 1f;	\
> +			      %[__idx] *= %[__size];		\
> +			      %[__arr] += %[__idx];		\
> +			      goto 2f;				\

+1 for using asm goto :)

> +			      1:;				\
> +			      %[__arr] = 0;			\
> +			      2:				\
> +			      "						\
> +			     : [__arr]"+r"(___arr), [__idx]"+r"(___idx)	\
> +			     : [__bound]"r"((arr_sz)),		        \
> +			       [__size]"i"(sizeof(typeof((arr)[0])))	\
> +			     : "cc");					\
> +	}								\
> +	___arr;								\
> +})
> +
> +/*
> + * Convenience wrapper for bpf_array_elem(), where we compute the size of the
> + * array.  Be sure to use an actual array, and not a pointer, just like with the
> + * ARRAY_SIZE macro.
> + */
> +#define bpf_array_sz_elem(arr, idx) \
> +	bpf_array_elem(arr, sizeof(arr) / sizeof((arr)[0]), idx)
> +
>  #endif
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
> 

