Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F673BAD11
	for <lists+bpf@lfdr.de>; Sun,  4 Jul 2021 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhGDNNI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 4 Jul 2021 09:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhGDNNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 4 Jul 2021 09:13:08 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77259C061574
        for <bpf@vger.kernel.org>; Sun,  4 Jul 2021 06:10:32 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a6so20723941ljq.3
        for <bpf@vger.kernel.org>; Sun, 04 Jul 2021 06:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=tPLRcPv1NPR6kIfLhu4yXv2ZwM15Pog1toqV70W4KYE=;
        b=N4Kw4GeICx4+Zu9hyCCs76JNuh7wl1BEd9ztGYKRYT6pMLcjuZOrtrlJfgzVz0WTlf
         ZQDOc74c6hFyOgi1mubaU4YbGqF9jfEZmTsgtQrmJJr+bKei7xyQ46enkwGyJOPvvH+Y
         ior284G4ZnJjY2Bx4ytJa1Igy1RL2YrCOG7t4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=tPLRcPv1NPR6kIfLhu4yXv2ZwM15Pog1toqV70W4KYE=;
        b=k8JWcuMrFfifU+X9DI4qAyJ4ZXuple30gcgiuqBYKJrvrTcwKxvsUWYkp+2pKxtrkf
         yB4udCYx1E994oBwt9lzCn1liIGc6g7UMIwJnU/gJ2ND2oOkPRnAv2YYHr8oGekrMfH7
         udpL33yF8YJMDeVskzBXVUUX8C0buVgB+HlvIkNtno897WnBIbx/uiO9kaZjG+110yxH
         J6PzHQMK+b7W6JztRN0BUsZSVxdLoIpOZR5KTOV/QNrzzxyKNNmS65KLJqSyEgIUclHA
         X8HNbxKh5FaygX+jwpsH8hv3JsJz6Pp+OOKoKKLUxfVs94CFe0LvLtfX4kU/q6drN6z+
         3zlA==
X-Gm-Message-State: AOAM530c68iwdv/pv0eWrZ9JUKbpudZOXFUXuRQ4yKna+KhgLHtBHXUP
        PPY134E9Re+w/cwoNPZ9CZV/5w==
X-Google-Smtp-Source: ABdhPJwkVdg15dhviQ6aL0BGjXPAMwRLO3qZKcPrCox1F3IRe/RxVQ3CtUrPZAXV4srMl/JkAXZC+Q==
X-Received: by 2002:a05:651c:4ce:: with SMTP id e14mr7145630lji.176.1625404230671;
        Sun, 04 Jul 2021 06:10:30 -0700 (PDT)
Received: from cloudflare.com (79.191.58.233.ipv4.supernova.orange.pl. [79.191.58.233])
        by smtp.gmail.com with ESMTPSA id s17sm368594ljg.28.2021.07.04.06.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 06:10:29 -0700 (PDT)
References: <20210701061656.34150-1-xiyou.wangcong@gmail.com>
 <60ddec01c651b_3fe24208dc@john-XPS-13-9370.notmuch>
 <875yxrs2sc.fsf@cloudflare.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Cong Wang <xiyou.wangcong@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Cong Wang <cong.wang@bytedance.com>,
        Jiang Wang <jiang.wang@bytedance.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Lorenz Bauer" <lmb@cloudflare.com>
Subject: Re: [Patch bpf v2] skmsg: check sk_rcvbuf limit before queuing to
 ingress_skb
In-reply-to: <875yxrs2sc.fsf@cloudflare.com>
Date:   Sun, 04 Jul 2021 15:10:28 +0200
Message-ID: <874kdarzqz.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jul 03, 2021 at 07:52 PM CEST, Jakub Sitnicki wrote:

[...]

> Then there is the case when a parser prog is attached. In this case the
> skb is really gone if we drop it on redirect.
>
> In sk_psock_strp_read, we ignore the -EIO error from
> sk_psock_verdict_apply, and return to tcp_read_sock how many bytes have
> been parsed.
>
>   sk->sk_data_ready
>     sk_psock_verdict_data_ready
>       ->read_sock(..., sk_psock_verdict_recv)
>         tcp_read_sock (used = copied = eaten)
>           strp_recv -> ret = eaten
>             __strp_recv -> ret = eaten
>               strp->cb.rcv_msg -> -EIO
>                 sk_psock_verdict_apply -> -EIO
>                   sk_psock_redirect -> -EIO

Copy-paste error. The call chain for the parser case goes as so:

  sk->sk_data_ready
    sk_psock_strp_data_ready
      strp_data_ready
        strp_read_sock
          ->read_sock(..., strp_recv)
            tcp_read_sock (used = copied = skb->len)
              strp_recv -> ret = skb->len
                __strp_recv -> ret = skb->len (dummy parser case)
                  strp->cb.rcv_msg -> -EIO
                    sk_psock_verdict_apply -> -EIO
                      sk_psock_redirect -> -EIO
