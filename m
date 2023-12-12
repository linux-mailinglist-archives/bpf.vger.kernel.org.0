Return-Path: <bpf+bounces-17504-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A264F80E8BF
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 11:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C6F2B20B2C
	for <lists+bpf@lfdr.de>; Tue, 12 Dec 2023 10:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718FC5B5C0;
	Tue, 12 Dec 2023 10:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ctJFeN6W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962BFD9
	for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 02:10:05 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54f4f7e88feso5425927a12.3
        for <bpf@vger.kernel.org>; Tue, 12 Dec 2023 02:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1702375804; x=1702980604; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=uHaTRxRyLv7/yiIgXr1TfZzs8xAqS4kO7LTDaQBlb7c=;
        b=ctJFeN6WTQe1ItffKwuVXOAFCSWVgqLg8EV9jywWen7CaTF62EttxtbqSi9OuiwICV
         MLKZYWFPn6gKBdoDuZAi88oB6HEuwda8h2JRy5I0kDtDgsNLcb03u7SO2RI3HloV/n94
         MRYjIYEQJQNTGiD3Fx8yTbOEqsF0BK0Kf7W2o32NvGh2TLe2Pd+GBr/WMvlfsRVMGmKG
         MnY93KK8s6xTvdfaAcukJJt4EHaDVO88fKF7hc2RN6SnK9CsJ+AkntE4bj341rRdyEza
         /Esv+FrTRLv6zvCuhCN4doJr2za4SdV1YX7ymaMGyQn8mPgzRAn4zx/FIVwiaxGE7B+F
         J3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702375804; x=1702980604;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHaTRxRyLv7/yiIgXr1TfZzs8xAqS4kO7LTDaQBlb7c=;
        b=LjMlfvbYbAIQYGJeU5VH4zTGQQWGusJRnmMoQIA5qHU+IV7/6hdgnEqB6nyGeuoxtD
         BN/SE5crNsahg92Up1mQgiXpmO6UlEelHYEeWV8ae9mV4zEwmXCR91yu3dUitlTnnmEb
         jFwj9aeF8zMVQ38yAzyBN6XF+cTe60HR47VXAmo28Z3Aqb4sEry8OtGMfZE5J4qIl0o2
         n8Z6Bkank07+ITaj5+MBZBzrTGw+o+87o9qJVNJ24ewk5+2yu6uUzgkBfNMwJibCCd+n
         TSDfq6nxn70OEKUtD+fbejFEg34lpbLRZm+wxrjStzg2/tZFVezAXnG6FKpPoMjM2+M1
         Tvug==
X-Gm-Message-State: AOJu0YzkdfXrUNNl4GpKYB5AfzLoR6BYH4fttZKKiCodwl1iQgNgAjiJ
	lfR+yBPv38jtlHCBCn7nI3ltyRgpr94mbjWUy0mNGw==
X-Google-Smtp-Source: AGHT+IEmSmQR3yM+snpCqYj0exuWRJzJ/MbXpjvCDBhBOG2SlCeXCFB2wst2urjDnOjXQ+xGmsZfcQ==
X-Received: by 2002:a17:907:d92:b0:a1b:7b6f:7aad with SMTP id go18-20020a1709070d9200b00a1b7b6f7aadmr4113760ejc.92.1702375804053;
        Tue, 12 Dec 2023 02:10:04 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1d2])
        by smtp.gmail.com with ESMTPSA id so7-20020a170907390700b00a1f7ae3dfbcsm4998578ejc.174.2023.12.12.02.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 02:10:03 -0800 (PST)
References: <20231201180139.328529-1-john.fastabend@gmail.com>
User-agent: mu4e 1.6.10; emacs 28.3
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>, Daniel Borkmann
 <borkmann@iogearbox.net>
Cc: martin.lau@kernel.org, edumazet@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH bpf v2 0/2]  bpf fix for unconnect af_unix socket
Date: Tue, 12 Dec 2023 11:09:36 +0100
In-reply-to: <20231201180139.328529-1-john.fastabend@gmail.com>
Message-ID: <878r5zrati.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Dec 01, 2023 at 10:01 AM -08, John Fastabend wrote:
> Eric reported a syzbot splat from a null ptr deref from recent fix to
> resolve a use-after-free with af-unix stream sockets and BPF sockmap
> usage.
>
> The issue is I missed is we allow unconnected af_unix STREAM sockets to
> be added to the sockmap. Fix this by blocking unconnected sockets.
>
> v2: change sk_is_unix to sk_is_stream_unix (Eric) and remove duplicate
>     ASSERTS in selftests the xsocket helper already marks FAIL (Jakub)
>
> John Fastabend (2):
>   bpf: syzkaller found null ptr deref in unix_bpf proto add
>   bpf: sockmap, test for unconnected af_unix sock
>
>  include/net/sock.h                            |  5 +++
>  net/core/sock_map.c                           |  2 ++
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 34 +++++++++++++++++++
>  3 files changed, 41 insertions(+)

For the series:

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

