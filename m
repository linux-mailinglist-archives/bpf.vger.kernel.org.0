Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C889139CBB
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 23:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgAMWmq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 17:42:46 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36758 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgAMWmq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 17:42:46 -0500
Received: by mail-lf1-f68.google.com with SMTP id n12so8188456lfe.3
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 14:42:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=hYezfZM0vvLS3M5s++Lru0Dkzvjkxpc7Nto24AAXinM=;
        b=dwIyPyXfHowi/NcCWY7Kzdsig1ZmvIYBKaA6gNstjR8jNNxmJx2c576/8dzckEkosV
         eaOuv/hEFh3DkSjIX2Jn/e9unPzOGTq8ZA9AuVJKjP3uccUYN+5qftkqJI6nbeVrhU/o
         lAeuVVdROABPeu9c/HJPTRY7S93wUYdPgMFv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=hYezfZM0vvLS3M5s++Lru0Dkzvjkxpc7Nto24AAXinM=;
        b=GVQSQtq2Kr6FXmwHmrmPYyP0CbUeVlbTZYzaH3wueYjx9Va/Cf+Meauc8j7H+TBCPG
         dSpc3R3xg7PPG9oXfi4JLdCVHGvbXR4JKjrh1Oh1f3sbhf3J8K05W+jfEW7dEcE6IF6z
         Z1GhYsTps0gzDCBLAzDNL8utmyaUtqJXpx6Z/MxnBYKw2anWi0ul8F6gO5FMupgeNypo
         SBPM+6xCKXEt1ytynheXUEGzf4ctdW/Iqtt8DGHmNhcGXgmkiBoy7Bz7Yu7Rq7O9jILF
         dM+8zfP5IFCJZ/StiTBg75qPdUwJQ8UXXLVQJLoMGfEdylH4ew435gktEMenlYGBmxEE
         XXrw==
X-Gm-Message-State: APjAAAWJFg3I+iIjbcNL4ezFrZygEItb8K+4IHsSBWMus2U4c8vMUHuI
        GuQ70PSgRhOL1VmIHdRFi/OMYg==
X-Google-Smtp-Source: APXvYqyQ+1cE+sTLxxgen+bJhJ8btjNu7hFcEEIPyCQ4ipolBW/T7Sv6MsE3yO+8YIebAk0PpFJpNQ==
X-Received: by 2002:a19:5212:: with SMTP id m18mr11046342lfb.7.1578955364322;
        Mon, 13 Jan 2020 14:42:44 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id y25sm6279571lfy.59.2020.01.13.14.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 14:42:43 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-5-jakub@cloudflare.com> <20200113222342.suypc3rgib7xbkjl@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        "John Fastabend" <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 04/11] tcp_bpf: Don't let child socket inherit parent protocol ops on copy
In-reply-to: <20200113222342.suypc3rgib7xbkjl@kafai-mbp.dhcp.thefacebook.com>
Date:   Mon, 13 Jan 2020 23:42:42 +0100
Message-ID: <87ftgjrna5.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 13, 2020 at 11:23 PM CET, Martin Lau wrote:
> On Fri, Jan 10, 2020 at 11:50:20AM +0100, Jakub Sitnicki wrote:
>> Prepare for cloning listening sockets that have their protocol callbacks
>> overridden by sk_msg. Child sockets must not inherit parent callbacks that
>> access state stored in sk_user_data owned by the parent.
>>
>> Restore the child socket protocol callbacks before the it gets hashed and
>> any of the callbacks can get invoked.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> ---
>>  include/net/tcp.h        |  1 +
>>  net/ipv4/tcp_bpf.c       | 13 +++++++++++++
>>  net/ipv4/tcp_minisocks.c |  2 ++
>>  3 files changed, 16 insertions(+)
>>
>> diff --git a/include/net/tcp.h b/include/net/tcp.h
>> index 9dd975be7fdf..7cbf9465bb10 100644
>> --- a/include/net/tcp.h
>> +++ b/include/net/tcp.h
>> @@ -2181,6 +2181,7 @@ int tcp_bpf_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
>>  		    int nonblock, int flags, int *addr_len);
>>  int __tcp_bpf_recvmsg(struct sock *sk, struct sk_psock *psock,
>>  		      struct msghdr *msg, int len, int flags);
>> +void tcp_bpf_clone(const struct sock *sk, struct sock *child);
>>
>>  /* Call BPF_SOCK_OPS program that returns an int. If the return value
>>   * is < 0, then the BPF op failed (for example if the loaded BPF
>> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>> index f6c83747c71e..6f96320fb7cf 100644
>> --- a/net/ipv4/tcp_bpf.c
>> +++ b/net/ipv4/tcp_bpf.c
>> @@ -586,6 +586,19 @@ static void tcp_bpf_close(struct sock *sk, long timeout)
>>  	saved_close(sk, timeout);
>>  }
>>
>> +/* If a child got cloned from a listening socket that had tcp_bpf
>> + * protocol callbacks installed, we need to restore the callbacks to
>> + * the default ones because the child does not inherit the psock state
>> + * that tcp_bpf callbacks expect.
>> + */
>> +void tcp_bpf_clone(const struct sock *sk, struct sock *newsk)
>> +{
>> +	struct proto *prot = newsk->sk_prot;
>> +
>> +	if (prot->recvmsg == tcp_bpf_recvmsg)
> A question not related to this patch (may be it is more for patch 6).
>
> How tcp_bpf_recvmsg may be used for a listening sock (sk here)?

It can't be used. It's a way of checking if sock has tcp_bpf callbacks
that I copied from sk_psock_get_checked:

static inline struct sk_psock *sk_psock_get_checked(struct sock *sk)
{
	struct sk_psock *psock;

	rcu_read_lock();
	psock = sk_psock(sk);
	if (psock) {
		if (sk->sk_prot->recvmsg != tcp_bpf_recvmsg) {
			psock = ERR_PTR(-EBUSY);
			goto out;
		}
        ...

This makes me think that perhaps it deserves a well-named helper.

>
>> +		newsk->sk_prot = sk->sk_prot_creator;
>> +}
>> +
