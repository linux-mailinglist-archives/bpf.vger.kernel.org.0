Return-Path: <bpf+bounces-11576-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 961167BC110
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 23:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74261C20981
	for <lists+bpf@lfdr.de>; Fri,  6 Oct 2023 21:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154D644487;
	Fri,  6 Oct 2023 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HfrIIaae"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8F638FA6
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 21:17:59 +0000 (UTC)
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B46BC2
	for <bpf@vger.kernel.org>; Fri,  6 Oct 2023 14:17:57 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-56fb25fdf06so2000654a12.1
        for <bpf@vger.kernel.org>; Fri, 06 Oct 2023 14:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696627076; x=1697231876; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z8YyZNdSqKiy5DzZ/PIG6aNvb3OwzQTDwFSCpe0do0I=;
        b=HfrIIaaeG6ZvdsF5OrF+ECo8MaHyzuchjI1AMOtJwDfiR+5av1Hs68gj1ZcNWLXTnk
         jAk8cSEMYWr+7C2fRmFbadWnotGqYKgpOMRcy9LAKW3vzruv89qoLob8/YX3lSzwKWQw
         HdckU35LLE9t/ogFw8/vBM/afrJ4VBsgL6vhr5VIPWDNc/E2l1h+uSAYwhZvPR3kaEzi
         sn4RUx60bVtkWMJiB2dsHiSgtt10+h6HGFMf9oj2qlQnWsNNL0fDqb0QDtv1fSWJiU91
         w77WpllBCrYQH7SCkXEZfRV6VaJkV/ZgKged5gmO1oDVHUvPVxed6DKE8QxuC1S+Jv3Z
         Z0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696627076; x=1697231876;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z8YyZNdSqKiy5DzZ/PIG6aNvb3OwzQTDwFSCpe0do0I=;
        b=p+xUnAPxaJv1jklz+3SsUY8laklUG3STl0sH02u0HPe7uL6SJxNY8QMG/BZl/zp8sE
         yPTCCr3HnhLSxembicvwQpIy+sCFX6Pxl1KogScnxGhx3woHufIvPhDcep1G53pS/ddk
         Zu1YphyO5uancsgDxQ79YoPiuXuhwMhwbJVzOn96c/Zp3q8R5Gtndkj1fgENmjxX+kPe
         PwcRtnv0HxbjcpmqCs3274kpTfUFA+k/jT1BA0oY9R2kVUEGHCxMz1q1W808Quzifb4i
         n9P0nTxV561oYCv9wx+U/ppJ+XstBitQ4x1LQp6pwFZe2FQN3MlGW7agxRI7YlPXuSZB
         PA3A==
X-Gm-Message-State: AOJu0Yz7/M0VLsN37kaemLmgv0DI25rzcZ4akXs7+up8S47H+2sv46oq
	Uq2otCPf5TuTj9O9sp1fYsMqnFM=
X-Google-Smtp-Source: AGHT+IGnmD6XCIMe/EZKQtEqPeVmzgwcfi0GavAMqiLOd1teM7yDtIh3f0wNuZUWye4WBFumI9XzkvY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:4e4d:0:b0:589:86ae:2107 with SMTP id
 o13-20020a634e4d000000b0058986ae2107mr57778pgl.9.1696627076618; Fri, 06 Oct
 2023 14:17:56 -0700 (PDT)
Date: Fri, 6 Oct 2023 14:17:55 -0700
In-Reply-To: <20231006201657.work.531-kees@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231006201657.work.531-kees@kernel.org>
Message-ID: <ZSB5g6CmpjS-l5nK@google.com>
Subject: Re: [PATCH] bpf: Annotate struct bpf_stack_map with __counted_by
From: Stanislav Fomichev <sdf@google.com>
To: Kees Cook <keescook@chromium.org>
Cc: Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, bpf@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/06, Kees Cook wrote:
> Prepare for the coming implementation by GCC and Clang of the __counted_by
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time via CONFIG_UBSAN_BOUNDS (for
> array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
> 
> As found with Coccinelle[1], add __counted_by for struct bpf_stack_map.
> 
> Cc: Song Liu <song@kernel.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Martin KaFai Lau <martin.lau@linux.dev>
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Hao Luo <haoluo@google.com>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: bpf@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Link: https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>

TIL about __counted_by :-)

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  kernel/bpf/stackmap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 458bb80b14d5..d6b277482085 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
> @@ -28,7 +28,7 @@ struct bpf_stack_map {
>  	void *elems;
>  	struct pcpu_freelist freelist;
>  	u32 n_buckets;
> -	struct stack_map_bucket *buckets[];
> +	struct stack_map_bucket *buckets[] __counted_by(n_buckets);
>  };
>  
>  static inline bool stack_map_use_build_id(struct bpf_map *map)
> -- 
> 2.34.1
> 

