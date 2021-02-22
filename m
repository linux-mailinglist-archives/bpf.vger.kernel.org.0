Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E6C32125C
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 09:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBVIxD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 22 Feb 2021 03:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhBVIwx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 22 Feb 2021 03:52:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41B6C061574
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 00:52:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o82so12739466wme.1
        for <bpf@vger.kernel.org>; Mon, 22 Feb 2021 00:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HF95ndbA7nNPDRh4S+2W0IHRdkwjz+dgoM5gTSFUR/k=;
        b=cN6+Xxd+3QOT0mU3bzZH0snj8lTWrwz+u48GEKD9es587bph7N9cFCaCQMn6O7luGM
         hv9/o8gTqmE1jI2VRva2Nj8v3A53/CPvQO56v/DUaqumpBQaOtwzBqAZ6Gl+Jky/t0kr
         qimhd6AsGmSxkf9jV767ZdvnYxQcKYRWZpWcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HF95ndbA7nNPDRh4S+2W0IHRdkwjz+dgoM5gTSFUR/k=;
        b=Kv2y9Zugnwtn0KYs0XsXIkpcOh1CL6q5entrUdZuvLMWZnUz1VIT2aYHcR7h45lCVo
         fJu/9osmxKe95s5tuknfZ9l5AS5Q+Uc8XyTt1DjUv0qpVzyFZskV4tb5MEhLb3FNWown
         m9BR4DBIIE7aaJAv67+EScdyVe2H3ceaSceASnvSaScuZqIz+3gpZ+yEhUDKnyMk62EQ
         BiAUsvTOoTdifRPhJ2MkXpkO2/p8Qdte8lEHPJgnmeS2N3iullH3JoJdf+9ASF6NYirC
         ekUIZaii8aScw+gK0MkdChtf29hoqaz/xuhszsh575UdQbhWKKVg/vpFRf9MqcUFe4CQ
         fraQ==
X-Gm-Message-State: AOAM531YqrcckCU9oAylA05QmgwN7ADV4OQtcu5zCSEOBSNCSZyfrStA
        APdFUf4fNYzl/h1DrjsSxaXQcvJT1a/UaOR2
X-Google-Smtp-Source: ABdhPJwBJbXCMnh3ExP5xAF5iwSCCczkYxIZ6o0asK+I6HfOdBNyFk2bs+eGvUkKnrG7ZH9ICmg0Zg==
X-Received: by 2002:a1c:7e4e:: with SMTP id z75mr19355059wmc.168.1613983921204;
        Mon, 22 Feb 2021 00:52:01 -0800 (PST)
Received: from cloudflare.com ([83.31.182.249])
        by smtp.gmail.com with ESMTPSA id w11sm5560165wru.3.2021.02.22.00.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 00:52:00 -0800 (PST)
References: <20210220052924.106599-1-xiyou.wangcong@gmail.com>
 <20210220052924.106599-2-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>
Subject: Re: [Patch bpf-next v6 1/8] bpf: clean up sockmap related Kconfigs
In-reply-to: <20210220052924.106599-2-xiyou.wangcong@gmail.com>
Date:   Mon, 22 Feb 2021 09:51:59 +0100
Message-ID: <87ft1o4h8w.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 20, 2021 at 06:29 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> As suggested by John, clean up sockmap related Kconfigs:
>
> Reduce the scope of CONFIG_BPF_STREAM_PARSER down to TCP stream
> parser, to reflect its name.
>
> Make the rest sockmap code simply depend on CONFIG_BPF_SYSCALL
> and CONFIG_INET, the latter is still needed at this point because
> of TCP/UDP proto update. And leave CONFIG_NET_SOCK_MSG untouched,
> as it is used by non-sockmap cases.
>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---

Couple comments:

1. sk_psock_done_strp() could be static to skmsg.c, as mentioned
   earlier.

2. udp_bpf.c is built when CONFIG_BPF_SYSCALL is enabled, while its API
   declarations in udp.h are guarded on CONFIG_NET_SOCK_MSG.

   This works because BPF_SYSCALL now selects NET_SOCK_MSG if INET, and
   INET has to be enabled when using udp, but seems confusing to me.

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
