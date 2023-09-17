Return-Path: <bpf+bounces-10214-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E2A7A3392
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 03:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1FC62816FA
	for <lists+bpf@lfdr.de>; Sun, 17 Sep 2023 01:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522B1ED1;
	Sun, 17 Sep 2023 01:50:43 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CAEEA2
	for <bpf@vger.kernel.org>; Sun, 17 Sep 2023 01:50:41 +0000 (UTC)
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5661BC;
	Sat, 16 Sep 2023 18:50:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-9adb9fa7200so661790566b.0;
        Sat, 16 Sep 2023 18:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694915439; x=1695520239; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K7XVCsxjT9Eqyov05GGtDOauPf8IAuRphc/aPK0/kl8=;
        b=Qxl2S/yl3onsSIGoGKi9EYjs77oMh3X/oWK+t2saqtS7TzQSDNmmQq3AWue9ccfsnP
         zmWhRfSU8Z/Wr44zf6q5k0pbPB+EEazSAtnCmLFu9aDe541d/Hk7f/AAnmbah6ZMUz57
         V1exzpww1BQoetH0zGh0VdeX/1JtmmYhCWg3M9ejyoqbX8rx2qwKXpOACnFKsCgrvvYq
         j8BNz01eC6V7uuPmRJN1xmG2J+Goa3UvGIRe4kCowPlZdRVGj8mv4TvTO+XBH5FmR4/j
         62h5WvrFqc1nDDyMev2qD9CPZ2eQWnFHpT6s0UzTahZUrQFAKL0navVlz/x1pFjMpLWE
         JrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694915439; x=1695520239;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7XVCsxjT9Eqyov05GGtDOauPf8IAuRphc/aPK0/kl8=;
        b=kREEtKwraKvJAiQWGTS8Awb55zPo0tK4HyiEPWkvZRy15T/wmkAnxRDJwPpy0pJo/z
         CNJ8E/gfcw0zc69xLhGeDebaGJnBlSaLxCmONiDlVVw8fvzVq7uJbhNlitb4TkL5vDSH
         CDMRRbgDpwIpqlEARC4AlcH/4lfH3uogj8mVWo07w/bCVDbhGG6pmF26EYcitIsEiL4v
         8ZI+8cx8aENJJaWchODsS2WoHyAh0PE5JdWOtQlynG7XxXLv0TtSoogaUjvRyoP4ET+m
         X/wXZtkpNc/jjcXzpDvUTXRHgRQbY3u1fci8F+fgcDpZ4mYt8zKfzTTq6xRfXEYwZfpL
         bP2w==
X-Gm-Message-State: AOJu0YzLIQDmoOz4FCJtQqVsacHLm9eIUOo08va9PMV/m/HcdNg/91eU
	3eZUpL9dLWPvoxREESIx3sg9SHepAQezrKnmbVY=
X-Google-Smtp-Source: AGHT+IEPOyF9D2sSR+0QYZt+2F4BWNz1/VJ6CCqkrpmcZnr/+SEVxki0dQA2sU1iVDaJaHYSw6HflqRJ3Ty+JxSyzsU=
X-Received: by 2002:a17:906:5a4a:b0:9ad:e62c:4517 with SMTP id
 my10-20020a1709065a4a00b009ade62c4517mr3326879ejc.34.1694915438553; Sat, 16
 Sep 2023 18:50:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230917000045.56377-1-puranjay12@gmail.com> <20230917000045.56377-2-puranjay12@gmail.com>
In-Reply-To: <20230917000045.56377-2-puranjay12@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sun, 17 Sep 2023 03:50:02 +0200
Message-ID: <CAP01T77remDtP9pq8pofXvHgzBKAw8MdGQhyp9Jp+qFt6x9zJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/1] bpf, arm64: support exceptions
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Zi Shen Lim <zlim.lnx@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, 17 Sept 2023 at 02:01, Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Implement arch_bpf_stack_walk() for the ARM64 JIT. This will be used
> by bpf_throw() to unwind till the program marked as exception boundary and
> run the callback with the stack of the main program.
>
> The prologue generation code has been modified to make the callback
> program use the stack of the program marked as exception boundary where
> callee-saved registers are already pushed.
>
> As the bpf_throw function never returns, if it clobbers any callee-saved
> registers, they would remain clobbered. So, the prologue of the
> exception-boundary program is modified to push R23 and R24 as well,
> which the callback will then recover in its epilogue.
>
> The Procedure Call Standard for the Arm 64-bit Architecture[1] states
> that registers r19 to r28 should be saved by the callee. BPF programs on
> ARM64 already save all callee-saved registers except r23 and r24. This
> patch adds an instruction in prologue of the  program to save these
> two registers and another instruction in the epilogue to recover them.
>
> These extra instructions are only added if bpf_throw() used. Otherwise
> the emitted prologue/epilogue remains unchanged.
>
> [1] https://github.com/ARM-software/abi-aa/blob/main/aapcs64/aapcs64.rst
>
> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> ---

We need reviews from arm64 JIT experts, but otherwise, given we've
discussed this offline as well:

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

