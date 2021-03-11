Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6506B337192
	for <lists+bpf@lfdr.de>; Thu, 11 Mar 2021 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbhCKLm3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 06:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbhCKLmU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Mar 2021 06:42:20 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E0C061574
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:42:20 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v15so1494273wrx.4
        for <bpf@vger.kernel.org>; Thu, 11 Mar 2021 03:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=lTuAlmKpzGDKQ5EMwcLuGVUtBW+trFeNE8cI/WVzAcA=;
        b=TIjaaIlN8eH10HrJ5INRoJwQg/W4Y9Rd5FFY1XPldeMbfP7y6jPeagvhpdVErliaXj
         ODt1L7GhjOyvQYIpqTFJ06OFhvstQy9+Gx2jgaw5M/TSkbWxZTb71JVrhMj0qGSJELUh
         JDciJ0iInSQHz5rVIsAIbmQ7dsnWOBD4l48sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=lTuAlmKpzGDKQ5EMwcLuGVUtBW+trFeNE8cI/WVzAcA=;
        b=YOQTKFDj4oZAzwjqHGHjt4bYahGNG3BPZH771HBa6g90OINwzVJE+3xcVAoXuYf8QJ
         K+A1CGXv5rEutQfzYgqZLUloQUPxjfeeFa+HXAJYlQ8y07EAf92HGSxZaT6Fm7WelP4/
         ohXNWFAB+PHf7l1SI5Ie2wbp6/xeOXDxqbg2Ihq4MMFFPKFQb5YBU7gsbUHJ18WTqnaz
         KVdEiz99YqUOrKeJ/UUYWzlL2uTU1mfk2upaWYOeQkg8o9vAzFiRwAJOMgikOEU9vcsP
         JzrC4NfcJVJmBlQU7diJtqf47imRCTB7obnDXMfU++IiK792mITm0wrIXECb7+8xDc3p
         VJiw==
X-Gm-Message-State: AOAM532Fi4KuzONTIqcy2PgpMhMpgAlBy3C0P8OZw0e0IDvd/k25GhN3
        WI24Ncyd4d7ljbwL8VbhX0SDGw==
X-Google-Smtp-Source: ABdhPJwJMWt5V23DvcfEfkkSZTv2GTu9OzXvPD6JXbWgh3Btxltrh6szbPUtatAKIXZuEm3Ut1akoA==
X-Received: by 2002:a5d:55c4:: with SMTP id i4mr8346085wrw.84.1615462939042;
        Thu, 11 Mar 2021 03:42:19 -0800 (PST)
Received: from cloudflare.com (79.184.34.53.ipv4.supernova.orange.pl. [79.184.34.53])
        by smtp.gmail.com with ESMTPSA id j20sm2987755wmp.30.2021.03.11.03.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 03:42:17 -0800 (PST)
References: <20210310053222.41371-1-xiyou.wangcong@gmail.com>
 <20210310053222.41371-4-xiyou.wangcong@gmail.com>
User-agent: mu4e 1.1.0; emacs 27.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        duanxiongchun@bytedance.com, wangdongdong.6@bytedance.com,
        jiang.wang@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [Patch bpf-next v4 03/11] skmsg: introduce skb_send_sock() for
 sock_map
In-reply-to: <20210310053222.41371-4-xiyou.wangcong@gmail.com>
Date:   Thu, 11 Mar 2021 12:42:16 +0100
Message-ID: <87zgz93oiv.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 10, 2021 at 06:32 AM CET, Cong Wang wrote:
> From: Cong Wang <cong.wang@bytedance.com>
>
> We only have skb_send_sock_locked() which requires callers
> to use lock_sock(). Introduce a variant skb_send_sock()
> which locks on its own, callers do not need to lock it
> any more. This will save us from adding a ->sendmsg_locked
> for each protocol.
>
> To reuse the code, pass function pointers to __skb_send_sock()
> and build skb_send_sock() and skb_send_sock_locked() on top.
>
> Cc: John Fastabend <john.fastabend@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Jakub Sitnicki <jakub@cloudflare.com>
> Cc: Lorenz Bauer <lmb@cloudflare.com>
> Signed-off-by: Cong Wang <cong.wang@bytedance.com>
> ---
>  include/linux/skbuff.h |  1 +
>  net/core/skbuff.c      | 52 ++++++++++++++++++++++++++++++++++++------
>  2 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> index 0503c917d773..2fc8c3657c53 100644
> --- a/include/linux/skbuff.h
> +++ b/include/linux/skbuff.h
> @@ -3626,6 +3626,7 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>  		    unsigned int flags);
>  int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
>  			 int len);
> +int skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset, int len);
>  void skb_copy_and_csum_dev(const struct sk_buff *skb, u8 *to);
>  unsigned int skb_zerocopy_headlen(const struct sk_buff *from);
>  int skb_zerocopy(struct sk_buff *to, struct sk_buff *from,
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 545a472273a5..396586bd6ae3 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2500,9 +2500,12 @@ int skb_splice_bits(struct sk_buff *skb, struct sock *sk, unsigned int offset,
>  }
>  EXPORT_SYMBOL_GPL(skb_splice_bits);
>
> -/* Send skb data on a socket. Socket must be locked. */
> -int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
> -			 int len)
> +typedef int (*sendmsg_func)(struct sock *sk, struct msghdr *msg,
> +			    struct kvec *vec, size_t num, size_t size);
> +typedef int (*sendpage_func)(struct sock *sk, struct page *page, int offset,
> +			   size_t size, int flags);
> +static int __skb_send_sock(struct sock *sk, struct sk_buff *skb, int offset,
> +			   int len, sendmsg_func sendmsg, sendpage_func sendpage)
>  {
>  	unsigned int orig_len = len;
>  	struct sk_buff *head = skb;
> @@ -2522,7 +2525,7 @@ int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
>  		memset(&msg, 0, sizeof(msg));
>  		msg.msg_flags = MSG_DONTWAIT;
>
> -		ret = kernel_sendmsg_locked(sk, &msg, &kv, 1, slen);
> +		ret = sendmsg(sk, &msg, &kv, 1, slen);


Maybe use INDIRECT_CALLABLE_DECLARE() and INDIRECT_CALL_2() since there
are just two possibilities? Same for sendpage below.

>  		if (ret <= 0)
>  			goto error;
>
> @@ -2553,9 +2556,9 @@ int skb_send_sock_locked(struct sock *sk, struct sk_buff *skb, int offset,
>  		slen = min_t(size_t, len, skb_frag_size(frag) - offset);
>
>  		while (slen) {
> -			ret = kernel_sendpage_locked(sk, skb_frag_page(frag),
> -						     skb_frag_off(frag) + offset,
> -						     slen, MSG_DONTWAIT);
> +			ret = sendpage(sk, skb_frag_page(frag),
> +				       skb_frag_off(frag) + offset,
> +				       slen, MSG_DONTWAIT);
>  			if (ret <= 0)
>  				goto error;
>

[...]
