Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6DE1CD481
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 11:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgEKJIU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 05:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgEKJIU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 May 2020 05:08:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0224C05BD09
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:08:19 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i15so9886855wrx.10
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=rNORn63xqMXkBEqaVD2YWfy0SAq9m0rRouvmymHM0XM=;
        b=eDGPh8VyzS6siQjHoSre664uGN1zMMOyXQXBHZWeTx8ymioipQEeWpUSrNWs6VCtr7
         z+LleB5T7uyikm/9o9q6Wd38c1UPyiH1d9Q4XWq6JOJPQbeh2mNx8wCjVUUQaEwSO+7G
         FJZpGFFn4+3PjiBd3KMLXJHs4X23oWEXW6ciY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=rNORn63xqMXkBEqaVD2YWfy0SAq9m0rRouvmymHM0XM=;
        b=etzjnNjHx4P3/KrgmNsgfhM7gE3pNsE0c6NzmpaPxCpnrZRspTyZmSjCmHDCYsYZQG
         kddBATlcvLOscCs/d18EabiMbtLCISBQLVLeDDTtyzQnsWK4ZuPcjcYoMpxrQiN6YfVo
         3EGQ/DqDsEpTSXeQstDCCVFPeB+4k8vhnoj+xpBSDQM5Ggjbjm+r80gzsnTAEGWD85bL
         laIv9F1kb139RTGsOCaz+RxZVvr6tAyuyYSARkQGPH9kKhUo/t/ri+7142pnIB1b1YQv
         u52f17id9TvpJzfdKxJ3+36ZgMNLHINyRlfiChOOeUl2mxRM5tsuSyXLEVzas9OE1aCk
         h5kQ==
X-Gm-Message-State: AGi0Pual2zkJdBuJOKSH63E7I3ifao4srixrY5I1xSN3Dx3EzxJ18Rbm
        cCDR01oPIzSYJXT1+K1EbCOSgg==
X-Google-Smtp-Source: APiQypKgLydNuiou6XiVQ+N9uLYeVHZFpWaev44LH0qc8jQLw5LCNKmpmUYvrOtM/kMk/On2bv4dlA==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr17790975wrp.300.1589188097101;
        Mon, 11 May 2020 02:08:17 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id t71sm27141441wmt.31.2020.05.11.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 02:08:16 -0700 (PDT)
References: <20200506125514.1020829-1-jakub@cloudflare.com> <20200506125514.1020829-3-jakub@cloudflare.com> <20200508070638.pqe73q4v3paxpkq5@kafai-mbp.dhcp.thefacebook.com> <87a72ivh6t.fsf@cloudflare.com> <20200508183928.ofudkphlb3vgpute@kafai-mbp.dhcp.thefacebook.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org, dccp@vger.kernel.org,
        kernel-team@cloudflare.com, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next 02/17] bpf: Introduce SK_LOOKUP program type with a dedicated attach point
In-reply-to: <20200508183928.ofudkphlb3vgpute@kafai-mbp.dhcp.thefacebook.com>
Date:   Mon, 11 May 2020 11:08:15 +0200
Message-ID: <877dxivny8.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, May 08, 2020 at 08:39 PM CEST, Martin KaFai Lau wrote:
> On Fri, May 08, 2020 at 12:45:14PM +0200, Jakub Sitnicki wrote:
>> On Fri, May 08, 2020 at 09:06 AM CEST, Martin KaFai Lau wrote:
>> > On Wed, May 06, 2020 at 02:54:58PM +0200, Jakub Sitnicki wrote:

[...]

>> >> +		return -ESOCKTNOSUPPORT;
>> >> +
>> >> +	/* Check if socket is suitable for packet L3/L4 protocol */
>> >> +	if (sk->sk_protocol != ctx->protocol)
>> >> +		return -EPROTOTYPE;
>> >> +	if (sk->sk_family != ctx->family &&
>> >> +	    (sk->sk_family == AF_INET || ipv6_only_sock(sk)))
>> >> +		return -EAFNOSUPPORT;
>> >> +
>> >> +	/* Select socket as lookup result */
>> >> +	ctx->selected_sk = sk;
>> > Could sk be a TCP_ESTABLISHED sk?
>>
>> Yes, and what's worse, it could be ref-counted. This is a bug. I should
>> be rejecting ref counted sockets here.
> Agree. ref-counted (i.e. checking rcu protected or not) is the right check
> here.
>
> An unrelated quick thought, it may still be fine for the
> TCP_ESTABLISHED tcp_sk returned from sock_map because of the
> "call_rcu(&psock->rcu, sk_psock_destroy);" in sk_psock_drop().
> I was more thinking about in the future, what if this helper can take
> other sk not coming from sock_map.

I see, psock holds a sock reference and will not release it until a full
grace period has elapsed.

Even if holding a ref wasn't a problem, I'm not sure if returning a
TCP_ESTABLISHED socket wouldn't trip up callers of inet_lookup_listener
(tcp_v4_rcv and nf_tproxy_handle_time_wait4), that look for a listener
when processing a SYN to TIME_WAIT socket.
