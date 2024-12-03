Return-Path: <bpf+bounces-45979-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FAB79E0F9B
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 01:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3C60B2270E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BE8136E;
	Tue,  3 Dec 2024 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPL/BmeE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E5710E3
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733185430; cv=none; b=dO3bzBy8IrQ0ZGaQ52Wi29+QR/QEeex2yQ6IMY5tH3trdDe0O0OhZ6q9V0116Z0qWbLJ9OWdWQ3x14KlSpIXvcmWS3uwWYqjwPikYPnmhgpmA2FetE6MESfwZq07w7fzD7+daMRegq1TvIquGpFYJxT9WAT3OJG3e1orzlqOv4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733185430; c=relaxed/simple;
	bh=y4CUNfEmwH0E00I3ohUbkmSGcLt2EaS5tFEhO9c9kP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLlVRjdYectVS1tMfZEj2XKQNyEEH0SJw3EMHxg6aZP3jmHAeJtEs5JhamfqhGHvebLT4LWrpoSVkWsx5bumshgWzkOHL/bEKM+R1q57/0fD9dimEXdFDb6SwZMpmpvAMjMOJLqrpLE1UdJwwmgbQzQf4xfYTuzJjxJWZc1n9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPL/BmeE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee6abf124aso2742290a91.3
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 16:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733185428; x=1733790228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J3wATiAjetczSx8tEBcmp0NvmNilVMC4LlqW9PSnJQM=;
        b=JPL/BmeEFJAhkqV4wO0lq3UHRS2Ct6ZBgia40y9nIlOBlVofMrThrb12/YdGBI89ui
         iFj/C4NUmtXSk9GIFfINgDPmmG0gUOrgvbJhGx6nWnrX6LOXCSF1NrIrQvidBalWXIXi
         CEcVDTWUZreOl6+b88B53z+3e6DEXrecOF79JEj0NJC+Sy8camFEhiR1lsX6OYsfQBtz
         T3e8qfwwD/oRBRWbB3caYgUXFyrArWpYRY6xDRwCg0Iw9f77XOpzsYO2EN2PtjeUlQbW
         QVko3ySlspclnX6pMsI6dFeh+Y/f0DC3RHQgPME0Aphy8EK1CswVgpSd+atBD0rfVZrO
         D+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733185428; x=1733790228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J3wATiAjetczSx8tEBcmp0NvmNilVMC4LlqW9PSnJQM=;
        b=o9fBTdh2957isJDI2zRWbN555SIThvj/wyzYpWWKsfZ6/hDl4arbAw0zcuqWoWaJcT
         sm+z342BKTKJEHAvIm773PVGy4A1TuyNllLzG7RrA/DpSMN9nI0fZNUr2/g7io0GN48z
         yevmKWUlADvkP7cJ2vPESEyY7jxWJVdnw6/V1RYR9v3uZlEENW4zUNUlY5ACVsXdxbhN
         G4nIIGST+x5VsGpi0LJ4LijnE0ECTptV+hPk4myyPHvQAucY0kFCmJ4S9miQtCQEMJwx
         jVDoREDPj6s920OBuxUW1H3+Ni9ZLQFyZK6oY60+Whh7DGbzm1j7+m8aRxxRO4r0vJSy
         0Npw==
X-Gm-Message-State: AOJu0Yx9tomOSfqdq8rK0Vb30RILofMbu0Y73LLhqbQ+qit3UASAq2Bh
	MKUGryyOVSpvBw3olBJV//2+IaNxvlLndoIEDs4ZuY62HilAv2ITnQnVux0=
X-Gm-Gg: ASbGncuYJjn7Qsu34TVssAQuL5GlomzXHzfqFsA7AVItCMIi2Mzex5r8iU/g8oHzPy6
	cJMr1/bPYwRkjRgqxM4DjU9J0M7w6t+YiDS2DzLJP+X8Du2nEwOZpM9vWNah+8q0diNlObRbWsj
	SZGjxg1fZ3aLJJ8Ed6M4z3wdBIVUpelSYIW48GjLCAYwYDbdEts3Xjo86K7qSnLdaWHfBeQIfTt
	n6ZlXFrbMcyfFU5qZRO9yPCuK4QJKlKtp5oSrU4RYuPzlVo2g==
X-Google-Smtp-Source: AGHT+IE1IbqjBWxsK2q1kGlSQX44hs84M/7oh29QmK0WAtpKBahcqpi/A0WAGiYtgedUa/U8c7FnWw==
X-Received: by 2002:a17:90b:3a92:b0:2ee:9d49:3aef with SMTP id 98e67ed59e1d1-2ef01241e85mr738211a91.23.1733185427831;
        Mon, 02 Dec 2024 16:23:47 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee4955ad05sm7517637a91.47.2024.12.02.16.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 16:23:47 -0800 (PST)
Date: Mon, 2 Dec 2024 16:23:46 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com,
	yonghong.song@linux.dev, masahiroy@kernel.org
Subject: Re: [PATCH bpf v2] samples/bpf: remove unnecessary -I flags from
 libbpf EXTRA_CFLAGS
Message-ID: <Z05PkpUCQb7T_rk3@mini-arch>
References: <20241202234741.3492084-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241202234741.3492084-1-eddyz87@gmail.com>

On 12/02, Eduard Zingerman wrote:
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
> 
> [0] commit 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> [1] https://lore.kernel.org/bpf/20241202212154.3174402-1-eddyz87@gmail.com/
> 
> Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
> 
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  samples/bpf/Makefile | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
> index bcf103a4c14f..44f7e05973de 100644
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
> @@ -229,7 +230,7 @@ clean:
>  
>  $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
>  # Fix up variables inherited from Kbuild that tools/ build system won't like
> -	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
> +	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(COMMON_CFLAGS)" \
>  		LDFLAGS="$(TPROGS_LDFLAGS)" srctree=$(BPF_SAMPLES_PATH)/../../ \
>  		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
>  		$@ install_headers
> -- 
> 2.47.0
> 

Naive question: why pass EXTRA_CFLAGS to libbpf at all? Can we drop it?

