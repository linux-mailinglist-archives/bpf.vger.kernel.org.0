Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41B053C6BB0
	for <lists+bpf@lfdr.de>; Tue, 13 Jul 2021 09:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234211AbhGMHuC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Jul 2021 03:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbhGMHuC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Jul 2021 03:50:02 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57009C0613DD
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 00:47:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y42so48702827lfa.3
        for <bpf@vger.kernel.org>; Tue, 13 Jul 2021 00:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=emdbnyUhfw2a0Ns3i70tVYGh6po0wTEptY3Eo42rynY=;
        b=cDwkAx9LJ6suKDJVfiNDvYcnYULiOKCgp6VJswtL8oNqKWqBltQ9wcHpc7BDs6SXyi
         a21wb03GPYHpof39go9+YNFX4QgvG6Npm8sKLvn3lfLUJA9bXGNfeghGCSa3H5NSEpjK
         JNwNDYXwLvDxYWYi2TDGBuTdFLudLXB7pBPVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=emdbnyUhfw2a0Ns3i70tVYGh6po0wTEptY3Eo42rynY=;
        b=RPgZaibFgGtLV+NVGmP5daXXcM9gKHgCzq7+qeHvUgKWuKDLMBi1cMPklcgdqySCS6
         yDZdjbq8S9K8uQr3DBgVkzSbDSuoX+B6rVwq4tSS3UpHVvYj1xDho+d0fGn6EOJtXC2E
         OGjzT8qcaV2qfK6a4IjmrIy2FeLaITCB1Jd/+DiP/dW4o71577txnPidX7IaZstkw9Ql
         QHs4ApTQAY/Yax/nhq6cf6pY9LbTDO7G1GuuyqQc2+QfjXNLgw8WspZE6enyDW9qMr5M
         7XCNwnQgToDOTN1iBThyWKUB8zjRfNf243a/v8PP6pRaoqxll9RcEERyL6tVhVGUQ5uL
         bV9w==
X-Gm-Message-State: AOAM532/gLbGwZNxGeeI0kx+T0EfRTDbDk4QAkUs/ZWyfSEyiy9Xsh/9
        biw0lqjE8LC0TZGOeYRjJjewIQ==
X-Google-Smtp-Source: ABdhPJyugIDRnoARCLmBo/cA9TdslqB59IIGM46NFHa+4MAyt5XhbMlQrle0lhS17h4k9JQmQgrn6g==
X-Received: by 2002:a05:6512:238b:: with SMTP id c11mr2558060lfv.548.1626162430712;
        Tue, 13 Jul 2021 00:47:10 -0700 (PDT)
Received: from cloudflare.com (79.191.183.149.ipv4.supernova.orange.pl. [79.191.183.149])
        by smtp.gmail.com with ESMTPSA id g20sm1367057ljm.54.2021.07.13.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 00:47:10 -0700 (PDT)
References: <20210712195546.423990-1-john.fastabend@gmail.com>
 <20210712195546.423990-3-john.fastabend@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andriin@fb.com,
        xiyou.wangcong@gmail.com, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH bpf v4 2/2] bpf, sockmap: sk_prot needs inuse_idx set
 for proc stats
In-reply-to: <20210712195546.423990-3-john.fastabend@gmail.com>
Date:   Tue, 13 Jul 2021 09:47:09 +0200
Message-ID: <87zguqr6yq.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 12, 2021 at 09:55 PM CEST, John Fastabend wrote:
> Proc socket stats use sk_prot->inuse_idx value to record inuse sock stats.
> We currently do not set this correctly from sockmap side. The result is
> reading sock stats '/proc/net/sockstat' gives incorrect values. The
> socket counter is incremented correctly, but because we don't set the
> counter correctly when we replace sk_prot we may omit the decrement.
>
> To get the correct inuse_idx value move the core_initcall that initializes
> the tcp/udp proto handlers to late_initcall. This way it is initialized
> after TCP/UDP has the chance to assign the inuse_idx value from the
> register protocol handler.
>
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Fixes: 604326b41a6fb ("bpf, sockmap: convert to generic sk_msg interface")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/ipv4/tcp_bpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index f26916a62f25..d3e9386b493e 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -503,7 +503,7 @@ static int __init tcp_bpf_v4_build_proto(void)
>  	tcp_bpf_rebuild_protos(tcp_bpf_prots[TCP_BPF_IPV4], &tcp_prot);
>  	return 0;
>  }
> -core_initcall(tcp_bpf_v4_build_proto);
> +late_initcall(tcp_bpf_v4_build_proto);
>
>  static int tcp_bpf_assert_proto_ops(struct proto *ops)
>  {

Respective change for udp_bpf is missing. I've posted it separately [1]
to save us an iteration. Hope you don't mind.

[1] https://lore.kernel.org/bpf/20210713074401.475209-1-jakub@cloudflare.com/
