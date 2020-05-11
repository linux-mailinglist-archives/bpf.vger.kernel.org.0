Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC33E1CE38E
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 21:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbgEKTGZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729215AbgEKTGY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 15:06:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0AC061A0E
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 12:06:24 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j5so12376947wrq.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 12:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=QZEthipVzVjMeKxHpjAKSEM3ksmG1aLvz13r/CgdtzI=;
        b=F7M6GHvDBD0Dy9yb/TCTMOgThiMwv6EnAazuIF0KlP9eJwTau1TvINq+9FmwmyuTg1
         oZO7srSSVj7j0BgfqtXitVJYQ/jPrE1/ekYAi4d8ZZrf2upsoM/YS1uKsy1LGLudQdx3
         Ehwmv4wOEat5kIDbFshog0X4EQ9denYri3IRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=QZEthipVzVjMeKxHpjAKSEM3ksmG1aLvz13r/CgdtzI=;
        b=tADAKaHbKrvzHA4ChZTG4edjPn8cs8/iDUnv7p1Hb3igJjL/VVA15RhcuJlt2+7rJJ
         sWUGGYCMxvkhXysqrC088Bw2/MI8h7OpQ10xouUeM7eW+Jt9Q1sRlBtQC4UjBzlJlYf4
         KgqDxSM/020A6Kvv2r8OU2l1pX1jeeeHDuJgbld2lQHGLMWMOBj8saMycV5AcAJyrFcj
         pu/y5Yb8l0gqL63t1uvI7ZKHPNho2vCqcqGYZVLfASKA/DBPN6O6w2/doeRG73A48nAJ
         DGvtF4rDysFZbhCSTz/rmscGvasnUTOzKb3Xz9GySyTVecNryU6nJ6+fEVj2jWj/aijO
         R8Sw==
X-Gm-Message-State: AGi0Pub4F2augYybXMWZ8BlZflXvJ16cO1Dsi/6di+SuwetYsj/hs28v
        lkEX8f50QlcWYNjkoMZyyCWreg==
X-Google-Smtp-Source: APiQypKsnYNoRfI9lWAIqqCYoV5QKs3dC1DDBLJgfyMTQyzwdNKfzX/6hX3HHmJftuZl0sR5SM50aA==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr20192276wru.62.1589223982638;
        Mon, 11 May 2020 12:06:22 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id i1sm18799199wrx.22.2020.05.11.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:06:22 -0700 (PDT)
References: <20200511185218.1422406-1-jakub@cloudflare.com> <20200511185218.1422406-3-jakub@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 02/17] bpf: Introduce SK_LOOKUP program type with a dedicated attach point
In-reply-to: <20200511185218.1422406-3-jakub@cloudflare.com>
Date:   Mon, 11 May 2020 21:06:21 +0200
Message-ID: <875zd2uw9e.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 11, 2020 at 08:52 PM CEST, Jakub Sitnicki wrote:
> Add a new program type BPF_PROG_TYPE_SK_LOOKUP and a dedicated attach type
> called BPF_SK_LOOKUP. The new program kind is to be invoked by the
> transport layer when looking up a socket for a received packet.
>
> When called, SK_LOOKUP program can select a socket that will receive the
> packet. This serves as a mechanism to overcome the limits of what bind()
> API allows to express. Two use-cases driving this work are:
>
>  (1) steer packets destined to an IP range, fixed port to a socket
>
>      192.0.2.0/24, port 80 -> NGINX socket
>
>  (2) steer packets destined to an IP address, any port to a socket
>
>      198.51.100.1, any port -> L7 proxy socket
>
> In its run-time context, program receives information about the packet that
> triggered the socket lookup. Namely IP version, L4 protocol identifier, and
> address 4-tuple. Context can be further extended to include ingress
> interface identifier.
>
> To select a socket BPF program fetches it from a map holding socket
> references, like SOCKMAP or SOCKHASH, and calls bpf_sk_assign(ctx, sk, ...)
> helper to record the selection. Transport layer then uses the selected
> socket as a result of socket lookup.
>
> This patch only enables the user to attach an SK_LOOKUP program to a
> network namespace. Subsequent patches hook it up to run on local delivery
> path in ipv4 and ipv6 stacks.
>
> Suggested-by: Marek Majkowski <marek@cloudflare.com>
> Reviewed-by: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>
> Notes:
>     v2:
>     - Make bpf_sk_assign reject sockets that don't use RCU freeing.
>       Update bpf_sk_assign docs accordingly. (Martin)
>     - Change bpf_sk_assign proto to take PTR_TO_SOCKET as argument. (Martin)
>     - Fix broken build when CONFIG_INET is not selected. (Martin)
>     - Rename bpf_sk_lookup{} src_/dst_* fields remote_/local_*. (Martin)

I forgot to call out one more change in v2 to this patch:

      - Enforce BPF_SK_LOOKUP attach point on load & attach. (Martin)

[...]
