Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7EF1CE461
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 21:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731404AbgEKT0I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 15:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731334AbgEKT0H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 15:26:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB97C061A0E
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 12:26:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id h4so19261984wmb.4
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 12:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=VnlGODx8zKx0jNEgXnN8NaGm9XOxSct1OSoBMXmlJ2o=;
        b=iOH4zL7BJiCQUgR8mo61pMkH2ZTVJs0hh/A5/PYhmIq/1+8mxLODJhnT4fJ+CgHC4H
         IRb4gOU9ldifKiMnDL5VIxTVfdcuW7roYaC/dLfTxu0hvEBc25j3p1oK67HUl9YbPDqF
         TiwKkjuVTRj602CtAlRtsqXwph4vATzcFWAx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=VnlGODx8zKx0jNEgXnN8NaGm9XOxSct1OSoBMXmlJ2o=;
        b=RwKliaY+iOUATDPp+ZxTJVnSZvXe8Xf3Y+n04GExP5IuSn01M4O+8ElXIDWNjF1QCX
         eT2X0wlZGH3W6smj6DQkUs6IJkH9Subi9omsapnJLN48+vBNCHWfcQZZcZBqYdLZ4mK+
         je5xMuVtkf5tl6ixVaO4WMomhXaxOfuR1m/Q7cPLy1AF6zFYOufjt9e2dTvIh0N5QwVl
         wveonemJf+QbdZ+LalVusTivFvb6s/AavqTiBk1QzV9D/0MkmzSX9XrJlK3zc16xYuY6
         fDQXsYuf3B0gUdNj1B/wC5L5t0VMiGsiWM/yHeaFUWEUpp+0fr2T9/hBtWV17vAiqmjX
         zufA==
X-Gm-Message-State: AGi0PuYDAoLB57qB1wKfYZd65l40xecvMazN6bxmfLO2GKcvGQ/qBJVx
        LVWj/KH1PUngoxYjJCH1p1hhIA==
X-Google-Smtp-Source: APiQypLdHIhBr6/ZX4/UaHb00LdhOGXT/D9KRnwdAKunEDrecNikCJMQcW/vf6S/yVqOQ9Tezcn5pg==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr34689890wmm.174.1589225164459;
        Mon, 11 May 2020 12:26:04 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j2sm19333010wrp.47.2020.05.11.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:26:03 -0700 (PDT)
References: <20200506125514.1020829-1-jakub@cloudflare.com> <20200506125514.1020829-3-jakub@cloudflare.com> <20200508070638.pqe73q4v3paxpkq5@kafai-mbp.dhcp.thefacebook.com> <87a72ivh6t.fsf@cloudflare.com> <20200508183928.ofudkphlb3vgpute@kafai-mbp.dhcp.thefacebook.com> <877dxivny8.fsf@cloudflare.com> <20200511185914.4oma2wbia4ukpfdr@kafai-mbp.dhcp.thefacebook.com>
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
In-reply-to: <20200511185914.4oma2wbia4ukpfdr@kafai-mbp.dhcp.thefacebook.com>
Date:   Mon, 11 May 2020 21:26:02 +0200
Message-ID: <874ksmuvcl.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, May 11, 2020 at 08:59 PM CEST, Martin KaFai Lau wrote:
> On Mon, May 11, 2020 at 11:08:15AM +0200, Jakub Sitnicki wrote:
>> On Fri, May 08, 2020 at 08:39 PM CEST, Martin KaFai Lau wrote:
>> > On Fri, May 08, 2020 at 12:45:14PM +0200, Jakub Sitnicki wrote:
>> >> On Fri, May 08, 2020 at 09:06 AM CEST, Martin KaFai Lau wrote:
>> >> > On Wed, May 06, 2020 at 02:54:58PM +0200, Jakub Sitnicki wrote:
>>
>> [...]
>>
>> >> >> +		return -ESOCKTNOSUPPORT;
>> >> >> +
>> >> >> +	/* Check if socket is suitable for packet L3/L4 protocol */
>> >> >> +	if (sk->sk_protocol != ctx->protocol)
>> >> >> +		return -EPROTOTYPE;
>> >> >> +	if (sk->sk_family != ctx->family &&
>> >> >> +	    (sk->sk_family == AF_INET || ipv6_only_sock(sk)))
>> >> >> +		return -EAFNOSUPPORT;
>> >> >> +
>> >> >> +	/* Select socket as lookup result */
>> >> >> +	ctx->selected_sk = sk;
>> >> > Could sk be a TCP_ESTABLISHED sk?
>> >>
>> >> Yes, and what's worse, it could be ref-counted. This is a bug. I should
>> >> be rejecting ref counted sockets here.
>> > Agree. ref-counted (i.e. checking rcu protected or not) is the right check
>> > here.
>> >
>> > An unrelated quick thought, it may still be fine for the
>> > TCP_ESTABLISHED tcp_sk returned from sock_map because of the
>> > "call_rcu(&psock->rcu, sk_psock_destroy);" in sk_psock_drop().
>> > I was more thinking about in the future, what if this helper can take
>> > other sk not coming from sock_map.
>>
>> I see, psock holds a sock reference and will not release it until a full
>> grace period has elapsed.
>>
>> Even if holding a ref wasn't a problem, I'm not sure if returning a
>> TCP_ESTABLISHED socket wouldn't trip up callers of inet_lookup_listener
>> (tcp_v4_rcv and nf_tproxy_handle_time_wait4), that look for a listener
>> when processing a SYN to TIME_WAIT socket.
> Not suggesting the sk_assign helper has to support TCP_ESTABLISHED in TCP
> if there is no use case for it.

Ack, I didn't think you were. Just explored the consequences.

> Do you have a use case on supporting TCP_ESTABLISHED sk in UDP?
> From the cover letter use cases, it is not clear to me it is
> required.
>
> or both should only support unconnected sk?

No, we don't have a use case for selecting a connected UDP socket.

I left it as a possiblity because __udp[46]_lib_lookup, where BPF
sk_lookup is invoked from, can return one.

Perhaps the user would like to connect the selected receiving socket
(for instance to itself) to ensure its not used for TX?

I've pulled this scenario out of the hat. Happy to limit bpf_sk_assign
to select only unconnected UDP sockets, if returning a connected one
doesn't make sense.

> Regardless, this details will be useful in the helper's doc.

I've reworded the helper doc in v2 to say:

        Description
                ...

                Only TCP listeners and UDP sockets, that is sockets
                which have *SOCK_RCU_FREE* flag set, can be selected.

                ...
        Return
                ...

                **-ESOCKTNOSUPPORT** if socket does not use RCU freeing.
