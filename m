Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB32B5AE2
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 09:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgKQIVT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 03:21:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgKQIVT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 03:21:19 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F03C0613CF
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 00:21:18 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id l1so22219981wrb.9
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2020 00:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=2QfRbjyq/5Ui8ziC4JJDxMSvSzbR5wNJzqv+patod/M=;
        b=rkbGawN6KRjyLGyglJxl9jaSZzRFsuihOWBjxfg8Cbn7rMdLgnM/lJAX4ekg+lgfo4
         mLcIMLfbQFrpGrNkpWuPLtkNy769hgxCxb24n57UhaJcalVLah7Z/6ZLv0y3Ow2b5eit
         1milTm/KBz/8sZCvopxEJ01Aasu3Cgh4lSHa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=2QfRbjyq/5Ui8ziC4JJDxMSvSzbR5wNJzqv+patod/M=;
        b=aEOxMXKSDwlV9q2ebDmJhYW9nSm+E4NNt59BIRzY3N00oW6NywDkHPYg4UEAGBJIz/
         dc4nxtg3SeNDgCXjWCfSySq75OTCbIo5Z/4yFPbPUlS7uuWSIstcyXnIM+aHF+CRLL8L
         vZazNBHArz5HxdkCvGewA7aY6oZveIUsvvSI1pN5EwFeaWVVRVfiGsGcnhPMXW3reA4s
         Mse5kg3927hrIF2WdVLOLx4HF6uXh0anpYECa5n6teo6bmcplcKn+pRrgT7mMo9zdape
         SHnPdtP2paGw6CE57ErQNIUi90ae4yGVNnvzGjxmYssNWLnrBMG/yPn56JgZQjQROc90
         0Igg==
X-Gm-Message-State: AOAM532WyIV1uf5fFSpu/k4t/rqaPA6Aow+RMmETBWL1jMHz1j5lFi3b
        zq73RsKM8mJ3KN5WYorCm5ekgQ==
X-Google-Smtp-Source: ABdhPJyRkghLfCyuJoTltSJLSnxohzm6b8OP1ESCLNk8LRsAdikIWL0dbPW2a4/wP10CwnIJj31K3Q==
X-Received: by 2002:a5d:5701:: with SMTP id a1mr23278045wrv.120.1605601277324;
        Tue, 17 Nov 2020 00:21:17 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w17sm2207015wru.82.2020.11.17.00.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:21:16 -0800 (PST)
References: <160556562395.73229.12161576665124541961.stgit@john-XPS-13-9370> <160556574804.73229.11328201020039674147.stgit@john-XPS-13-9370>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [bpf PATCH v3 5/6] bpf, sockmap: Handle memory acct if skb_verdict prog redirects to self
In-reply-to: <160556574804.73229.11328201020039674147.stgit@john-XPS-13-9370>
Date:   Tue, 17 Nov 2020 09:21:15 +0100
Message-ID: <878sb0wg04.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 11:29 PM CET, John Fastabend wrote:
> If the skb_verdict_prog redirects an skb knowingly to itself, fix your
> BPF program this is not optimal and an abuse of the API please use
> SK_PASS. That said there may be cases, such as socket load balancing,
> where picking the socket is hashed based or otherwise picks the same
> socket it was received on in some rare cases. If this happens we don't
> want to confuse userspace giving them an EAGAIN error if we can avoid
> it.
>
> To avoid double accounting in these cases. At the moment even if the
> skb has already been charged against the sockets rcvbuf and forward
> alloc we check it again and do set_owner_r() causing it to be orphaned
> and recharged. For one this is useless work, but more importantly we
> can have a case where the skb could be put on the ingress queue, but
> because we are under memory pressure we return EAGAIN. The trouble
> here is the skb has already been accounted for so any rcvbuf checks
> include the memory associated with the packet already. This rolls
> up and can result in unecessary EAGAIN errors in userspace read()
> calls.
>
> Fix by doing an unlikely check and skipping checks if skb->sk == sk.
>
> Fixes: 51199405f9672 ("bpf: skb_verdict, support SK_PASS on RX BPF path")
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> ---
>  net/core/skmsg.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/net/core/skmsg.c b/net/core/skmsg.c
> index 9aed5a2c7c5b..514bc9f6f8ae 100644
> --- a/net/core/skmsg.c
> +++ b/net/core/skmsg.c
> @@ -442,11 +442,19 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
>  	return copied;
>  }
>  
> +static int sk_psock_skb_ingress_self(struct sk_psock *psock, struct sk_buff *skb);
> +
>  static int sk_psock_skb_ingress(struct sk_psock *psock, struct sk_buff *skb)
>  {
>  	struct sock *sk = psock->sk;
>  	struct sk_msg *msg;
>  
> +	/* If we are receiving on the same sock skb->sk is already assigned,
> +	 * skip memory accounting and owner transition seeing it already set
> +	 * correctly.
> +	 */
> +	if (unlikely(skb->sk == sk))
> +		return sk_psock_skb_ingress_self(psock, skb);
>  	msg = sk_psock_create_ingress_msg(sk, skb);
>  	if (!msg)
>  		return -EAGAIN;

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
