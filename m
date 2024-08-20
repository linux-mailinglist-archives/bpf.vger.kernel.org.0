Return-Path: <bpf+bounces-37635-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C53958964
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 16:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCF31F22EDD
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 14:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CE7191466;
	Tue, 20 Aug 2024 14:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZuly/OC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1012E5B;
	Tue, 20 Aug 2024 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724164443; cv=none; b=DSHy9NiZxHDow/5Iwg/SOIJDH2JP1Y/MvGwtslX+n3XC+F8H947di+3x6xe0ks9mgLt+zxk6Zq0zDSAMYRzeF603baICppp66QQd2Zj2tSDv9AiEIyxCOHsDTxo288M5T5E2GMuMVQcOOT4eRpw/B8LNOVpqfFT5xMV2lukRth8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724164443; c=relaxed/simple;
	bh=QKWYUjgkdySkXi1BPr281uIlpu0P55qZTipA7vFzcDs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e05lQM6lXHUqmlplxLZahN4Lwpp8l30n55DGX+FVIECd5Ca6PmNDrvPqdk5bWtMK46MhDR/rzlAdZijuXCdJt6yFrUJLoVUo0XCiOf18TCGs968LfMJgm0l2Quj5yFkQUBt3fztvx70BwlKLn8DCjjHL5zMNXXg3k3b4n4JmtCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZuly/OC; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so961294666b.0;
        Tue, 20 Aug 2024 07:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724164438; x=1724769238; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JFEf+YZTsp2U0MqW9b++unhQczVRgDZLMKo2QlWpPZw=;
        b=RZuly/OCH0f6sDX0KiG0Cis3aJYSJUqV/ZQcu4o1Xrjd5dBMztS+VE/Zk9FSxLLjiZ
         B9Ee4V3FOx6TUXCh4lbqnzwEboJizlmBfvWPAros8NcgHgUmaNGwYDQlEmI/Z4Cumlrl
         Wr0LR73VLwq+S3cugpEpAmfqedXUx88QwxKrpe2vC4GoLahRfGSN5O2HsxOzarLceYgU
         8fbX5a18nhwoJ4UmTafyy49iNuEhu/Jq0ebzx2aa5He5P9jAHsg1TXxEjZK6+6S6g+Zj
         V4Sa9AIzrXeDPVbmIzvwMnwt2ol2hmj/jAnU41+qE2Q6UFNbQUGfZKcVe7cJN+fqdhBm
         USew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724164438; x=1724769238;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFEf+YZTsp2U0MqW9b++unhQczVRgDZLMKo2QlWpPZw=;
        b=FQ/vEPNCzb34FCLxXyYzv/YZVjEQztslvFp05ZCYtifXi2+RH6346bPN4kWKzLqHIn
         4qIxPmRw6WlJdn0zUqCVNQ4LfZ0QOT2ZpmgWNT8CKDcAkQzzoU7NpA+PQEvUl4dQFk/7
         LlLKugGmHrbhpUsawb1rbfco4g+FkxSKduhfx2dV3N7Q1VlsuGBW64n+0/LkECISwvoA
         al9HgpSaGPi5oSWodj01NWQukp0hn15WBvxAAjY0FS+OnWkmxVCeq5WGtRdo6DWTBhWV
         smkxRi7i8Ys5dyRnlH3lmOGwuDWN/s21TKZo8I39yFnsnwDbpYYdRtJp8ELzL0PHlTCr
         Z9mg==
X-Forwarded-Encrypted: i=1; AJvYcCUsEn4g5cGOTlcvahxH3f499CnUczKk+70v480F2q5jGtC3gdKlcqBrqmLRW+vy3gr5hnjvIiUkIWQK3bNw6G3zEK0qMdOTdcZryvXvfM5mGnNy1K1VNfELlTp6Mvo2EVY+bwKKSKbKZTAUFwU+GqrzdLXewwW0Aa8/kGgxyNYb
X-Gm-Message-State: AOJu0YzQdA8/AudnMG/4Wkp4SCZl3FgZiyymaQ+Axo+LV5sWY8WACJ14
	X72htxPvxx/RNEskwsm8Oh5f/aIsZBG9Jq39wXqhy+KLeCgqLrjS
X-Google-Smtp-Source: AGHT+IEi63bHrvyONMU7Ex8SzkeDjhpiTNyFyFSg0cNe1CO72132FRtReCABy9+Q7+5KVmdQCOL7Jw==
X-Received: by 2002:a17:906:dc95:b0:a7a:81ba:8eb3 with SMTP id a640c23a62f3a-a8643ffb8d7mr283495066b.27.1724164438004;
        Tue, 20 Aug 2024 07:33:58 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838eef05sm767986666b.96.2024.08.20.07.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 07:33:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 20 Aug 2024 16:33:55 +0200
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc: masahiroy@kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jslaby@suse.cz>, Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, linux-kbuild@vger.kernel.org,
	bpf@vger.kernel.org, shung-hsi.yu@suse.com, msuchanek@suse.com
Subject: Re: [RFC] kbuild: bpf: Do not run pahole with -j on 32bit userspace
Message-ID: <ZsSpU5DqT3sRDzZy@krava>
References: <20240820085950.200358-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820085950.200358-1-jirislaby@kernel.org>

On Tue, Aug 20, 2024 at 10:59:50AM +0200, Jiri Slaby (SUSE) wrote:
> From: Jiri Slaby <jslaby@suse.cz>
> 
> == WARNING ==
> This is only a PoC. There are deficiencies like CROSS_COMPILE or LLVM
> are completely unhandled.
> 
> The simple version is just do there:
>   ifeq ($(CONFIG_64BIT,y)
> but it has its own deficiencies, of course.
> 
> So any ideas, inputs?
> == WARNING ==
> 
> When pahole is run with -j on 32bit userspace (32bit pahole in
> particular), it randomly fails with OOM:
> > btf_encoder__tag_kfuncs: Failed to get ELF section(62) data: out of memory.
> > btf_encoder__encode: failed to tag kfuncs!
> 
> or simply SIGSEGV (failed to allocate the btf encoder).
> 
> It very depends on how many threads are created.
> 
> So do not invoke pahole with -j on 32bit.

could you share more details about your setup?

does it need to run on pure 32bit to reproduce? I can't reproduce when
doing cross build and running 32 bit pahole on x86_64.. I do see some
errors though

  [667939] STRUCT bpf_prog_aux Error emitting BTF type
  Encountered error while encoding BTF.

thanks,
jirka

> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: b4f72786429c ("scripts/pahole-flags.sh: Parse DWARF and generate BTF with multithreading.")
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1229450
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas@fjasle.eu>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Song Liu <song@kernel.org>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Hao Luo <haoluo@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: shung-hsi.yu@suse.com
> Cc: msuchanek@suse.com
> ---
>  init/Kconfig            |  4 ++++
>  scripts/Makefile.btf    |  2 ++
>  scripts/pahole-class.sh | 21 +++++++++++++++++++++
>  3 files changed, 27 insertions(+)
>  create mode 100644 scripts/pahole-class.sh
> 
> diff --git a/init/Kconfig b/init/Kconfig
> index f36ca8a0e209..f5e80497eef0 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -113,6 +113,10 @@ config PAHOLE_VERSION
>  	int
>  	default $(shell,$(srctree)/scripts/pahole-version.sh $(PAHOLE))
>  
> +config PAHOLE_CLASS
> +	string
> +	default $(shell,$(srctree)/scripts/pahole-class.sh $(PAHOLE))
> +
>  config CONSTRUCTORS
>  	bool
>  
> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
> index b75f09f3f424..f7de8e922bce 100644
> --- a/scripts/Makefile.btf
> +++ b/scripts/Makefile.btf
> @@ -12,7 +12,9 @@ endif
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 121)	+= --btf_gen_floats
>  
> +ifeq ($(CONFIG_PAHOLE_CLASS),ELF64)
>  pahole-flags-$(call test-ge, $(pahole-ver), 122)	+= -j
> +endif
>  
>  pahole-flags-$(call test-ge, $(pahole-ver), 125)	+= --skip_encoding_btf_inconsistent_proto --btf_gen_optimized
>  
> diff --git a/scripts/pahole-class.sh b/scripts/pahole-class.sh
> new file mode 100644
> index 000000000000..d15a92077f76
> --- /dev/null
> +++ b/scripts/pahole-class.sh
> @@ -0,0 +1,21 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Usage: $ ./pahole-class.sh pahole
> +#
> +# Prints pahole's ELF class, such as ELF64
> +
> +if [ ! -x "$(command -v "$@")" ]; then
> +	echo 0
> +	exit 1
> +fi
> +
> +PAHOLE="$(which "$@")"
> +CLASS="$(readelf -h "$PAHOLE" 2>/dev/null | sed -n 's/.*Class: *// p')"
> +
> +# Scripts like scripts/dummy-tools/pahole
> +if [ -n "$CLASS" ]; then
> +	echo "$CLASS"
> +else
> +	echo ELF64
> +fi
> -- 
> 2.46.0
> 

