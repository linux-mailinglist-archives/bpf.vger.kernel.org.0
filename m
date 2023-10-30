Return-Path: <bpf+bounces-13592-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F1A7DB5E7
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 10:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7E92281455
	for <lists+bpf@lfdr.de>; Mon, 30 Oct 2023 09:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A1D52F;
	Mon, 30 Oct 2023 09:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XT+h0i7N"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15ED2F3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 09:12:30 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F16AD3
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:12:28 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53dd3f169d8so6355896a12.3
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 02:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1698657147; x=1699261947; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=zs9Jp9Umn+28ekdNRcU3k/2uuYw3/HAMrWbbU3oSYBc=;
        b=XT+h0i7NNsDWUifDgAe9BlHY/37GhEv+a3lbvAZBPL2s73tbeNSSWO2xIzcNCLkOJO
         +/2R2mZG4loWjXJAYfDUnmopp/1pPqdixqA6fOS2AhRxTDImc+2FEv5fYqqcU3X+4Byb
         2vlgWZJjvy0FadHAZCQU/30SA57iLkGaVaqxpmviyTob8864nbImUIdZYZ7SXLMpsxPN
         2rmmEzEj9gILM3zuJwQj6Ceks6wb+OUxM7a8u1q282EkZOhuyWSpuzQk7Fc0XDAsx6JQ
         tad0Ep4Ydk4LbYJvHfzexlFYd84J0Ro0Q9ShVUzhcH9k1kZ6aa/U2A3OvosT5AWvUZwe
         txrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698657147; x=1699261947;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zs9Jp9Umn+28ekdNRcU3k/2uuYw3/HAMrWbbU3oSYBc=;
        b=T5JEjx07GLFK21idaNlQ1qU+TOL+t6IPWaP/rZ6r9xwgIf8ke28DqEVZa5+QDWi8qc
         ZDLZ5y/Y4ShAdveoGZrCuwWxqu+x7lJoAXp7McIXhiFPWQpO04En6JNnWkY5wGYowdn+
         NwlDJgf9rd82WUx1ldJ5zBNjiJVpKCEU1v58hgyHUzO2D7smUrQ7AV+UfqAM5nYlSk1I
         3az7UfCvV8a/EcADBiw39psitTnZ/mYZZIovIvsQMFEQrdtJPeWPHi1KWcnxF/dVUpYL
         1i956EVcE3ApdGUx8+St+60DfHMSJ/3monZY9WhCCKaEFG8paGYiPpU8qbCf8FZUDVyh
         J3Lw==
X-Gm-Message-State: AOJu0Yyz+wKwdDaQX/n3lDeKGzD4/MdWbeIN/A4X2NlO8g9CcLlF4kot
	ZMHMnbJknkU0+WV7lIMlN2tQhQ==
X-Google-Smtp-Source: AGHT+IFfQprEGPQ1kTNCsRQhi7/e/RFjn0xIpGcDBtliFbKg3HZxoy1h7ZnFvc7A/zwISzicuGRzSQ==
X-Received: by 2002:a50:d5d4:0:b0:53e:98c6:5100 with SMTP id g20-20020a50d5d4000000b0053e98c65100mr7627581edj.30.1698657146943;
        Mon, 30 Oct 2023 02:12:26 -0700 (PDT)
Received: from cloudflare.com (79.184.209.104.ipv4.supernova.orange.pl. [79.184.209.104])
        by smtp.gmail.com with ESMTPSA id k10-20020aa7d8ca000000b0053d9f427a6bsm5777732eds.71.2023.10.30.02.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 02:12:26 -0700 (PDT)
References: <20231028100552.2444158-1-liujian56@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Liu Jian <liujian56@huawei.com>
Cc: john.fastabend@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 0/7] add BPF_F_PERMANENT flag for sockmap
 skmsg redirect
Date: Mon, 30 Oct 2023 10:12:03 +0100
In-reply-to: <20231028100552.2444158-1-liujian56@huawei.com>
Message-ID: <87bkcg1nk2.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Oct 28, 2023 at 06:05 PM +08, Liu Jian wrote:
> v6->v7: Rebase to latest bpf-next tree, and no changes.
> v5->v6: Modified the description of the helper function.
> v4->v5: Fix one refcount bug caused by patch1.
> v3->v4: Change the two helpers's description.
> 	Let BPF_F_PERMANENT takes precedence over apply/cork_bytes.
>
> Liu Jian (7):
>   bpf, sockmap: add BPF_F_PERMANENT flag for skmsg redirect
>   selftests/bpf: Add txmsg permanently test for sockmap
>   selftests/bpf: Add txmsg redir permanently test for sockmap
>   selftests/bpf: add skmsg verdict tests
>   selftests/bpf: add two skmsg verdict tests for BPF_F_PERMANENT flag
>   selftests/bpf: add tests for verdict skmsg to itself
>   selftests/bpf: add tests for verdict skmsg to closed socket
>
>  include/linux/skmsg.h                         |   1 +
>  include/uapi/linux/bpf.h                      |  45 +++++--
>  net/core/skmsg.c                              |   6 +-
>  net/core/sock_map.c                           |   4 +-
>  net/ipv4/tcp_bpf.c                            |  12 +-
>  tools/include/uapi/linux/bpf.h                |  45 +++++--
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 122 ++++++++++++++++++
>  .../selftests/bpf/progs/test_sockmap_kern.h   |   3 +-
>  .../bpf/progs/test_sockmap_msg_verdict.c      |  25 ++++
>  tools/testing/selftests/bpf/test_sockmap.c    |  41 +++++-
>  10 files changed, 272 insertions(+), 32 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/test_sockmap_msg_verdict.c

I gave it one last look. For the series:

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

