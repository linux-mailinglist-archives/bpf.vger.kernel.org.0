Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67562139463
	for <lists+bpf@lfdr.de>; Mon, 13 Jan 2020 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgAMPJu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Jan 2020 10:09:50 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41383 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgAMPJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Jan 2020 10:09:49 -0500
Received: by mail-wr1-f68.google.com with SMTP id c9so8939262wrw.8
        for <bpf@vger.kernel.org>; Mon, 13 Jan 2020 07:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ScqIMW/ZuA4+mryk/Y5OCnzbnoTHNJOtXEPLhT1giFk=;
        b=K1PNmBm2lgkvDZh2jm81EF4WzLkIHdADaBY6ljeuktfa9GAciHFkTA4LzrnpmH8uEQ
         QXZXTZ+1jEFOoz+RkO0y52uSJuXan/ZEJV94rVD59QlZZPoyR8pevV5flEJlrWeYRK47
         0nyAZi5TuXmklryPv785EdBJsJTxnACSu5oKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ScqIMW/ZuA4+mryk/Y5OCnzbnoTHNJOtXEPLhT1giFk=;
        b=ERyNu5ZSBTMTXzFirzMBk+AVrZaKnSw6i1YsfRsPhTY4nXKxwUU6LaX5fafUZTDKI4
         WRjLNLA0pj9Po5YG6wzSb5JgRmr93m+n6c4HuXasGg1AOr29Rxhy8CtYxDzkJPKXRCHE
         RZCX944GWt3gAJ8kuFAhckoVzUYxjdSPR2cms7ggWVZADuCPkYd1vxOuudyhdgjjNIA7
         A0KBZE6LVihTt50csvedv1wtqBCIryjVClqgTmolKdyaqLroC9SqhOeTvybc3SrvBxnZ
         hEiuavYERsxJZpJ4aVArE1qO5SrFEtmejJ31gPsjf9jTlFGWtQpEN2dTHNt4XmKw+z6k
         N05w==
X-Gm-Message-State: APjAAAXN3aqhJIcBgyuw6wcfEep8Rc8/h34Js0IIOn5G0Hg1bNAbBfD5
        EPs2nYbKi97vwTzDxoJvWtVhTg==
X-Google-Smtp-Source: APXvYqxy4hA8z/zHhR8+1uXsR2hLIf3WeMd0g1E+0HS17wbL82rVXeT92WAhFiF3znTZMX23ceam8Q==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr19152226wrx.66.1578928188541;
        Mon, 13 Jan 2020 07:09:48 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id x10sm15180463wrp.58.2020.01.13.07.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 07:09:48 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-3-jakub@cloudflare.com> <5e1a56e630ee1_1e7f2b0c859c45c0c4@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v2 02/11] net, sk_msg: Annotate lockless access to sk_prot on clone
In-reply-to: <5e1a56e630ee1_1e7f2b0c859c45c0c4@john-XPS-13-9370.notmuch>
Date:   Mon, 13 Jan 2020 16:09:47 +0100
Message-ID: <87muars890.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 12, 2020 at 12:14 AM CET, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> sk_msg and ULP frameworks override protocol callbacks pointer in
>> sk->sk_prot, while TCP accesses it locklessly when cloning the listening
>> socket.
>>
>> Once we enable use of listening sockets with sockmap (and hence sk_msg),
>> there can be shared access to sk->sk_prot if socket is getting cloned while
>> being inserted/deleted to/from the sockmap from another CPU. Mark the
>> shared access with READ_ONCE/WRITE_ONCE annotations.
>>
>> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>
> In sockmap side I fixed this by wrapping the access in a lock_sock[0]. So
> Do you think this is still needed with that in mind? The bpf_clone call
> is using sk_prot_creater and also setting the newsk's proto field. Even
> if the listening parent sock was being deleted in parallel would that be
> a problem? We don't touch sk_prot_creator from the tear down path. I've
> only scanned the 3..11 patches so maybe the answer is below. If that is
> the case probably an improved commit message would be helpful.

I think it is needed. Not because of tcp_bpf_clone or that we access
listener's sk_prot_creator from there, if I'm grasping your question.

Either way I'm glad this came up. Let's go though my reasoning and
verify it. tcp stack accesses the listener sk_prot while cloning it:

tcp_v4_rcv
  sk = __inet_lookup_skb(...)
  tcp_check_req(sk)
    inet_csk(sk)->icsk_af_ops->syn_recv_sock
      tcp_v4_syn_recv_sock
        tcp_create_openreq_child
          inet_csk_clone_lock
            sk_clone_lock
              READ_ONCE(sk->sk_prot)

It grabs a reference to the listener, but doesn't grab the sk_lock.

On another CPU we can be inserting/removing the listener socket from the
sockmap and writing to its sk_prot. We have the update and the remove
path:

sock_map_ops->map_update_elem
  sock_map_update_elem
    sock_map_update_common
      sock_map_link_no_progs
        tcp_bpf_init
          tcp_bpf_update_sk_prot
            sk_psock_update_proto
              WRITE_ONCE(sk->sk_prot, ops)

sock_map_ops->map_delete_elem
  sock_map_delete_elem
    __sock_map_delete
     sock_map_unref
       sk_psock_put
         sk_psock_drop
           sk_psock_restore_proto
             tcp_update_ulp
               WRITE_ONCE(sk->sk_prot, proto)

Following the guidelines from KTSAN project [0], sk_prot looks like a
candidate for annotating it. At least on these 3 call paths.

If that sounds correct, I can add it to the patch description.

Thanks,
-jkbs

[0] https://github.com/google/ktsan/wiki/READ_ONCE-and-WRITE_ONCE
