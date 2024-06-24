Return-Path: <bpf+bounces-32918-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69541914FB4
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 16:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22CFC2820E5
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 14:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EFF143733;
	Mon, 24 Jun 2024 14:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="MWpGz8h/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECEB12FF84
	for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719238557; cv=none; b=N2iI2RAqrEQjG4zPpPfPXwyAYW+6AJy3m2jXPvi0YvaxMRvkb03A9SeNRaoBETmqN6J8kkRBcCYOZd1SDnMqQpReBF9x7li+QO39RNFVqRq2QzLTkXkjZosWOyumneLH7f79GhYz+uKnjlOfAyR4h+/xZirxqhptcuUNkI2489I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719238557; c=relaxed/simple;
	bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nowY6Jxpv+9geZ5vtn9g3HeBVZ6IGDHCZRiZTjp8+DwPpP0zxgWYdJSDxTbC2kTIDkhutVEL2bqsaifXm1Ty3tgmKCGLbSgyZJRXQ+Py1xxAYQQn3g+GUaLwU+hfMuai7el6rKTv1aDs+RzYIoF0mY9h64lfiBPst1J7bNy5l20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=MWpGz8h/; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a72420e84feso232737166b.0
        for <bpf@vger.kernel.org>; Mon, 24 Jun 2024 07:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1719238552; x=1719843352; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
        b=MWpGz8h/K50vTi4PBRNp3Bbnr+A+Jt8r/PWvLao49oIyhLfzSIG+b3ZC9oz2L1xeSi
         kvQJZo5wQYFb54ihY3Spwxf3vpbpwFSMeewfs1iC6pDId2cGgO3v3ZZ9vl8xxeO6FbuI
         cYZO4Z1zi3sVsmVF/Fvj7ZlYOh6ZfBOu0QEE/jx6ZjjUQB+ALex+cCmiNQt52cE4ITMy
         USxy9qTJZRyYLxhb2MzH2o+7JUqVT5NTN0qhgstg7Sy+dbVUmxW98wkn51Mr0WBgI06G
         1EIBl+FjfTsm+o2RfgXlpH53Waxk3/Co0LwNADtNtQyFTVdwRIHFzyAncVNvB3g0irQl
         h0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719238552; x=1719843352;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVHqXy9ZInCaWH01/8bWggSAo5eLlmc2jeeEEydVT3Y=;
        b=Nt3eKa5tZ9Y+c5oQgFCdKQWIiluscH97FPvuoMBAtY6NxEWzu7SRsnC0UkYZDZ7mSc
         eFN/5MJ/4NTIql5a3SKAFIwAGW5fDn1ss+r7PKJNu8pMgq3J4YQMN/bQh63aTtH9TKYd
         9PKlA0f5dDpDF3H4V9/4IRV3lazT8cxBEl3BlUEpse5fwx24iI8vQKBsrEiS/kBQ4mEp
         iK2GdNfamCoMeW66l1z6XtoevTKmLmKNnT9FbjPrdI+l0eaxYbqbsSX3Buw8hANrvmHo
         A6L1GyfU7/6y87RT65u+6rFoFuDdmj7w03IclLDQ+R5Ha92LkwBz+ATYF07D71l/dUiG
         pVZw==
X-Forwarded-Encrypted: i=1; AJvYcCU+UFV2sCwyQx1f/Qc0+khMPN6OG/7gAC+3eTlDliZX0zlk1Q1/RJ0bJlNJIl61XCyZzd3FLZSnerZPJagaXocRVvd8
X-Gm-Message-State: AOJu0Yyi4B+pxmXA8n+g+0a0wB/S+wH1o6/hwueARgElUIAKF1BejQuA
	84a4YMHimca0l/HSwJZvVphk4DT7+zLr1qBkCg7SG20EqRE3Lqq0AiuGNwi1p/EUeE+mZYTfz0Z
	r
X-Google-Smtp-Source: AGHT+IGOFPUZG0DHZAYy6V/GZR1AuVwIqcOt9IZJ+hY+ERpVLG4G+3pJU5NB/1fgzXE8F1KYVann4g==
X-Received: by 2002:a17:907:104c:b0:a72:455f:e8b with SMTP id a640c23a62f3a-a724599a00cmr356126066b.0.1719238552027;
        Mon, 24 Jun 2024 07:15:52 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:27])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7263a345f6sm20137766b.46.2024.06.24.07.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 07:15:51 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org,  bpf@vger.kernel.org,  davem@davemloft.net,
  edumazet@google.com,  kuba@kernel.org,  pabeni@redhat.com,
  john.fastabend@gmail.com,  kuniyu@amazon.com,  Rao.Shoaib@oracle.com,
 Cong Wang <cong.wang@bytedance.com>
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
In-Reply-To: <20240622223324.3337956-1-mhal@rbox.co> (Michal Luczaj's message
	of "Sun, 23 Jun 2024 00:25:12 +0200")
References: <20240622223324.3337956-1-mhal@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Mon, 24 Jun 2024 16:15:49 +0200
Message-ID: <874j9ijuju.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
> with an `oob_skb` pointer. BPF redirecting does not account for that: when
> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
> results in a single skb that may be accessed from two different sockets.
>
> Take the easy way out: silently drop MSG_OOB data targeting any socket that
> is in a sockmap or a sockhash. Note that such silent drop is akin to the
> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>
> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>
> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---

[+CC Cong who authored ->read_skb]

I'm guessing you have a test program that you're developing the fix
against. Would you like to extend the test case for sockmap redirect
from unix stream [1] to incorporate it?

Sadly unix_inet_redir_to_connected needs a fix first because it
hardcodes sotype to SOCK_DGRAM.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c#n1884

