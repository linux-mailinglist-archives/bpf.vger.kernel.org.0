Return-Path: <bpf+bounces-29646-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B3C8C4532
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 18:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A99F1F22663
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 16:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C971817565;
	Mon, 13 May 2024 16:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtNnHQ5c"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00F81864C;
	Mon, 13 May 2024 16:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715618374; cv=none; b=JrlNvrhBx8lU6RmIJKryrzgz1CfWJ1V+hdNznhBai3aLrvsH9rScf1LmDzv98E56BI7VroZ3jBWN+dVEXYwOKh0IH3dTBwgMmsA3vNsaeTiBZ8PGtYBUyfCZiPoDt6/zD6cLaaIHzFmBXn4BE/xUJpevWfwM7H0ObVrtsMbQwIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715618374; c=relaxed/simple;
	bh=FXjTIu7Javcp57PGJ37+TMBH2Efe81br2mmREIXkSTU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZPqgGxZmUDIOw532MS63rL4FIGRJEPY0Sjbsa3oNFmlbcrp9PCKtwrJvBynBeZGCfvuww2MSiXQs94DjAHGP4u7Pc3XKU8Tbhn/L462VaCCASk+judofbtXN1bdOgWl2eBtLR0RB7A0xSysyCglKnXUWOdMj3F64GN0CTg2bGkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LtNnHQ5c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-420180b5838so6811545e9.2;
        Mon, 13 May 2024 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715618371; x=1716223171; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JlL47WvthT5p4/6Hq0zcLfQwW5agcsSiG76b2RdCPO8=;
        b=LtNnHQ5cWHgNVzUA18Y58DxfeI1IUuVEr/7P5nHgG6WbIGPomfTfR7eoh1FQuMrgRy
         4Jz9JGl817Qs+HTxs84xCKFikmhrHniBkSyMH1IYfEUpj5NDpB6RymYjEhnaYjt5kJFt
         JsizPvQ1TfUvqCigtz5nJHI+WJsCFzYzLCcXXZu4sq9rqg4vbdliZOFYIwEeOA+JjN8q
         J+yQeW1c4Sf64sVKPdr43U0bSJDyUx0aRqoRtXvJ7Cw9CowIBtR+VHhEyxN+HURvONkt
         ZeAfgeli+OwTRhz4233tehFEOyPcQTMcRgtz6E2TcjEJWhZS7tiG2YMd9NZJAA5ipz8F
         3V+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715618371; x=1716223171;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JlL47WvthT5p4/6Hq0zcLfQwW5agcsSiG76b2RdCPO8=;
        b=wuk6q6tf3LWbS8q1hPfuIhJSWeaONcemD49e1tpih1Ek5OLbI0YUrfhkGRldCPD0pQ
         OfukWLwOoCgxhIFU1Qi9BeKe9NQ/qWCoXkTxyxHqQ7IG6229QrlgFQ8ONjE56IjEUUDx
         7YIXwNpNFB09BkPzig/bd/bFtuBIFxQBxpPs4WVCPIvM/rr+BFA65aMg2zcR5NQ6GuRI
         Up1XgsvmUB1x/i3Bo1AKDR8ZHxgez46seIf1fnSgkSIfbEm5LdsRBSLegzWyXStocdV1
         HyZA8WFysuTyaKDo4CJtqNUlQS+NNKtzaEvp4qhl5FW17DmneVEMzwCBaCC6e/DoXTs9
         csoQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB3wL7jpheRl4qU200ftHQwEPSWuXKhUkwBIb9vOfDaLntRBUnGE0bnNQ1PKCdUKxUGVX1cKmNM3uDeklONUm1cqB0Yq0BeP0fw/xTxg3SWCCYOTOVjTTAwJ+E+Nh/4QQI
X-Gm-Message-State: AOJu0YwHqfrZx+dJTHLnxGSplibyHekp1043ZYF3OC7jZ2+gl13Y7PtC
	qx4bMv/4ZhkanYfpSB6vJzUUtua+kXxIjRBOmEzCEzjLPMsmHSWq
X-Google-Smtp-Source: AGHT+IFheMWHt8UUqBv97Se6r51eErnibj4jwd2Xsi4g0uCOA5f0VLNA4AbqyY41m1+pDF9RqD9t8Q==
X-Received: by 2002:a05:600c:4714:b0:41b:13d5:7da9 with SMTP id 5b1f17b1804b1-41fead643famr128548145e9.38.1715618370680;
        Mon, 13 May 2024 09:39:30 -0700 (PDT)
Received: from localhost (54-240-197-231.amazon.com. [54.240.197.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee94dasm163110125e9.32.2024.05.13.09.39.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2024 09:39:30 -0700 (PDT)
From: Puranjay Mohan <puranjay12@gmail.com>
To: Maxwell Bland <mbland@motorola.com>, "open list:BPF [GENERAL] (Safe
 Dynamic Programs and Tools)" <bpf@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, Mark
 Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, open
 list <linux-kernel@vger.kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] arm64/cfi,bpf: Support kCFI + BPF on arm64
In-Reply-To: <ub6a7msv36rhotqez3usccexkn7kdqqnsyklrnqy7znqas7fhe@cry4jnw3baky>
References: <wtb6czzpvtqq23t4g6hf7on257dtxzdb4fa4nuq3dtq32odmli@xoyyrtthafar>
 <ub6a7msv36rhotqez3usccexkn7kdqqnsyklrnqy7znqas7fhe@cry4jnw3baky>
Date: Mon, 13 May 2024 16:39:28 +0000
Message-ID: <mb61pttj1k6nz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxwell Bland <mbland@motorola.com> writes:

This patch has a subtle difference from the patch that I sent in v2[1]

Unfortunately, you didn't test this. :(

It will break BPF on an ARM64 kernel compiled with CONFIG_CFI_CLANG=y

See below:

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index 76b91f36c729..703247457409 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -17,6 +17,7 @@
>  #include <asm/asm-extable.h>
>  #include <asm/byteorder.h>
>  #include <asm/cacheflush.h>
> +#include <asm/cfi.h>
>  #include <asm/debug-monitors.h>
>  #include <asm/insn.h>
>  #include <asm/patching.h>
> @@ -162,6 +163,12 @@ static inline void emit_bti(u32 insn, struct jit_ctx *ctx)
>  		emit(insn, ctx);
>  }
>  
> +static inline void emit_kcfi(u32 hash, struct jit_ctx *ctx)
> +{
> +	if (IS_ENABLED(CONFIG_CFI_CLANG))
> +		emit(hash, ctx);
> +}
> +
>  /*
>   * Kernel addresses in the vmalloc space use at most 48 bits, and the
>   * remaining bits are guaranteed to be 0x1. So we can compose the address
> @@ -337,6 +344,7 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
>  	 *
>  	 */

In my original patch the hunk here looked something like:

--- >8 ---

-	const int idx0 = ctx->idx;
 	int cur_offset;
 
 	/*
@@ -332,6 +338,8 @@ static int build_prologue(struct jit_ctx *ctx, bool ebpf_from_cbpf,
 	 *
 	 */
 
+	emit_kcfi(is_subprog ? cfi_bpf_subprog_hash : cfi_bpf_hash, ctx);
+	const int idx0 = ctx->idx;

--- 8< ---

moving idx0 = ctx->idx; after emit_kcfi() is important because later
this 'idx0' is used like:

   cur_offset = ctx->idx - idx0;
   if (cur_offset != PROLOGUE_OFFSET) {
           pr_err_once("PROLOGUE_OFFSET = %d, expected %d!\n",
                       cur_offset, PROLOGUE_OFFSET);
           return -1;
   }

With the current version, when I boot the kernel I get:

[    0.499207] bpf_jit: PROLOGUE_OFFSET = 13, expected 12!

and now no BPF program can be JITed!

Please fix this in the next version and test it by running:

./tools/testing/selftests/bpf/test_progs

Pay attention to the `rbtree_success` and the `dummy_st_ops` tests, they
are the important ones for this change.

[1] https://lore.kernel.org/all/20240324211518.93892-2-puranjay12@gmail.com/

Thanks,
Puranjay

