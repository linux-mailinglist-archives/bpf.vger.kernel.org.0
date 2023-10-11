Return-Path: <bpf+bounces-11851-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 724A17C471F
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 03:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A551281AA2
	for <lists+bpf@lfdr.de>; Wed, 11 Oct 2023 01:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7A73FED;
	Wed, 11 Oct 2023 01:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LP1jYPry"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C85819
	for <bpf@vger.kernel.org>; Wed, 11 Oct 2023 01:17:42 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BCDDB4
	for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 18:17:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4180f5c51f8so4101711cf.1
        for <bpf@vger.kernel.org>; Tue, 10 Oct 2023 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696987060; x=1697591860; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8hWLrD7SZl7TcacLOoTzuq06tk7AIygH3knhMFZNLVY=;
        b=LP1jYPrySdmcYIqz24G/z7HiNmPRF8cmS0U/6KreUKDy9RJVarN4ypctVgY090bW6q
         fhpfuGNfDgfeovb7gAFFBZdlh8R9AbNYShl5we7SshmvTGlEgLg1acHUe1MiV2kjaLlV
         0VZwP9PIFauZn4nFaKWYccQAL1cuIX924g7VIP3ps/lqDRp0r13Mbknv0dP1i7ACZud1
         0B9Omw8ZnH2dpr31MuIlXcIcPJ+1AeKxBcTTeUTD9mZ8s6TRKBNKjubGFW0/Q/eA9uUv
         AMVbQYgBfVa0uZ2q16BpfkPStm/ziDEw1/V/AuYxJ/aWZOsPYkeL/o5gDWpzhehCYTjx
         0dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696987060; x=1697591860;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8hWLrD7SZl7TcacLOoTzuq06tk7AIygH3knhMFZNLVY=;
        b=TVYYnqxqsf9nATL2qO/ugQ8jdFKGpeyyqBMKRPNoY29ftuKfEsK5jeznsRRdP71uUs
         mwGrTU7MqE1VmAWsEEt9fwvBTO/LYH/kI92JXWI+P4cXs73VxVrH5qZQbEdoRa6OIF4z
         Zu8VnyQYzfMVa+q/dxGBQQixZHOzb8qMmCCz15plKH3RX23CxHa8y0MggJvjVXmfEb2C
         J8u+w9cgi9JQxYxZBLD+h1Tw7ZwTqEqeNpPLxHdyRVRfAg5hyK4RHtwDthGHIfzsXq+D
         +cyp/LOxDT9O6+4w4tLLK6iXe272ibsers6F5BS9xtXrHfPldVXtg15iuU5W+lGDtRtC
         +CgA==
X-Gm-Message-State: AOJu0YwxCTjnRqk9ugv21u/ABsNYKxVWCTNKy9MzFlaXCCFeRQJQ623V
	kibspD3nG3Ujpk1lbeLfCna8
X-Google-Smtp-Source: AGHT+IFMjRoxd6M6UkenLBrMtcmhXpeM+27NBW05bCx4rgaZT2JbFycWyJjjBn8NtpEiwf7yP+QXbA==
X-Received: by 2002:ac8:5bc8:0:b0:418:11c9:ddb5 with SMTP id b8-20020ac85bc8000000b0041811c9ddb5mr23034732qtb.25.1696987060155;
        Tue, 10 Oct 2023 18:17:40 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id v2-20020ac873c2000000b00419576c7b75sm4898801qtp.23.2023.10.10.18.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 18:17:39 -0700 (PDT)
Date: Tue, 10 Oct 2023 21:17:39 -0400
Message-ID: <9fe88aef7deabbe87d3fc38c4aea3c69.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>, <linux-security-module@vger.kernel.org>, <keescook@chromium.org>, <brauner@kernel.org>, <lennart@poettering.net>, <kernel-team@meta.com>, <sargun@sargun.me>, selinux@vger.kernel.org
Subject: Re: [PATCH v6 6/13] bpf: add BPF token support to BPF_PROG_LOAD  command
References: <20230927225809.2049655-7-andrii@kernel.org>
In-Reply-To: <20230927225809.2049655-7-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

On Sep 27, 2023 Andrii Nakryiko <andrii@kernel.org> wrote:
> 
> Add basic support of BPF token to BPF_PROG_LOAD. Wire through a set of
> allowed BPF program types and attach types, derived from BPF FS at BPF
> token creation time. Then make sure we perform bpf_token_capable()
> checks everywhere where it's relevant.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/bpf.h                           |  6 ++
>  include/uapi/linux/bpf.h                      |  2 +
>  kernel/bpf/core.c                             |  1 +
>  kernel/bpf/inode.c                            |  6 +-
>  kernel/bpf/syscall.c                          | 87 ++++++++++++++-----
>  kernel/bpf/token.c                            | 25 ++++++
>  tools/include/uapi/linux/bpf.h                |  2 +
>  .../selftests/bpf/prog_tests/libbpf_probes.c  |  2 +
>  .../selftests/bpf/prog_tests/libbpf_str.c     |  3 +
>  9 files changed, 108 insertions(+), 26 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 5c5c2b6648b2..d0b219f09bcc 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -2685,6 +2718,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
>  	prog->aux->sleepable = attr->prog_flags & BPF_F_SLEEPABLE;
>  	prog->aux->xdp_has_frags = attr->prog_flags & BPF_F_XDP_HAS_FRAGS;
>  
> +	/* move token into prog->aux, reuse taken refcnt */
> +	prog->aux->token = token;
> +	token = NULL;
> +
>  	err = security_bpf_prog_alloc(prog->aux);
>  	if (err)
>  		goto free_prog;

As we discussed in the earlier thread, let's tweak/rename/move the
security_bpf_prog_alloc() call down to just before the bpf_check() call
so it looks something like this:

  err = security_bpf_prog_load(prog, &attr, token);
  if (err)
    goto proper_jump_label;
  
  err = bpf_check(...);

With the idea being that LSMs which implement the token hooks would
skip any BPF_PROG_LOAD access controls in security_bpf() and instead
implement them in security_bpf_prog_load().

We should also do something similar for map_create() and
security_bpf_map_alloc() in patch 4/13.

--
paul-moore.com

