Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9171B13ADFB
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 16:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgANPs1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 10:48:27 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35168 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728695AbgANPs1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 10:48:27 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so14889241lja.2
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 07:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=dLbjHKuyCSdvL37+hmsui6qZ9EwBG7rzByZNk6nyh4c=;
        b=tgvoiZI6l59IuleGfm//PJpb7gertpUzKN0IamEWqiPPgE7T6kOWTwbagxp6E6QbM0
         El87f6PJCR/8kNUiNtFEDg844zxQ+8jQatF31Q+lVOJU5CbgKexiKpjLKetg/ucrRlv6
         wWhIm2NVvymkm9FPkmM9lpie7t4w7ECSEbxaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=dLbjHKuyCSdvL37+hmsui6qZ9EwBG7rzByZNk6nyh4c=;
        b=lgypx7OK+EWrnGfbKLnQi5C+laaEpAB8kFcIpYvGtfSPaSiP4xkVEizQjSxmj+oZ4n
         bsmak+gGnKmEwwW6nvIlSh6HAVw57+nCW2RSM8RMA/iJZkc2PiOCjWwc09p0G4zCNMjl
         jbz+8U35hsd00zF62iQ7jBQxQVfwmKpktJjqylIcRf2ZGag+nbOKzsIof69+Lp3g6gsi
         A/j036nnoB24dBAIbdQdMmffF5FY3zR3bVXISQwGgGsSakcsNQpb/kg6Y0iVyilUXPnq
         GzImNPT0jMG4ybtpjf+31YP+FYE+CvdxjL8w+3K0ejcsJ9qnZR0oE47Rw1J1dwGQzrhp
         p0gw==
X-Gm-Message-State: APjAAAWFfM3PgSpr1NvvkWqzfelAUER2U7lXME1UtR8LFUJN1Sl0PH9q
        sGNYad+c9SkX/Stkh5ItXLEd1Q==
X-Google-Smtp-Source: APXvYqx+CUX33laMHA9Cyf1lrkU3CChvyiNtZzGRhKUGdEVMwLMOUGDWk4EK/dVmL5gl2ebKdd0+wA==
X-Received: by 2002:a2e:81c3:: with SMTP id s3mr14991096ljg.168.1579016905323;
        Tue, 14 Jan 2020 07:48:25 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id w19sm7378995lfl.55.2020.01.14.07.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 07:48:24 -0800 (PST)
References: <20200110105027.257877-1-jakub@cloudflare.com> <20200110105027.257877-8-jakub@cloudflare.com> <20200113231223.cl77bxxs44bl6uhw@kafai-mbp.dhcp.thefacebook.com> <5e1d328d760e_78752af1940225b4b7@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Martin Lau <kafai@fb.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev\@vger.kernel.org" <netdev@vger.kernel.org>,
        "kernel-team\@cloudflare.com" <kernel-team@cloudflare.com>,
        Eric Dumazet <edumazet@google.com>,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: Re: [PATCH bpf-next v2 07/11] bpf, sockmap: Return socket cookie on lookup from syscall
In-reply-to: <5e1d328d760e_78752af1940225b4b7@john-XPS-13-9370.notmuch>
Date:   Tue, 14 Jan 2020 16:48:23 +0100
Message-ID: <87blr6rqd4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 14, 2020 at 04:16 AM CET, John Fastabend wrote:
> Martin Lau wrote:
>> On Fri, Jan 10, 2020 at 11:50:23AM +0100, Jakub Sitnicki wrote:
>> > Tooling that populates the SOCKMAP with sockets from user-space needs a way
>> > to inspect its contents. Returning the struct sock * that SOCKMAP holds to
>> > user-space is neither safe nor useful. An approach established by
>> > REUSEPORT_SOCKARRAY is to return a socket cookie (a unique identifier)
>> > instead.
>> >
>> > Since socket cookies are u64 values SOCKMAP needs to support such a value
>> > size for lookup to be possible. This requires special handling on update,
>> > though. Attempts to do a lookup on SOCKMAP holding u32 values will be met
>> > with ENOSPC error.
>> >
>> > Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
>> > ---
>
> [...]
>
>> > +static void *sock_map_lookup_sys(struct bpf_map *map, void *key)
>> > +{
>> > +	struct sock *sk;
>> > +
>> > +	WARN_ON_ONCE(!rcu_read_lock_held());
>> It seems unnecessary.  It is only called by syscall.c which
>> holds the rcu_read_lock().  Other than that,
>>
>
> +1 drop it. The normal rcu annotations/splats should catch anything
> here.

Oh, okay. Thanks for pointing it out.

I noticed __sock_map_lookup_elem called from sock_map_lookup_sys has the
same WARN_ON_ONCE check. Looks like it can be cleaned up.

Granted, __sock_map_lookup_elem also gets invoked by sockmap BPF helpers
for redirecting (bpf_msg_redirect_map, bpf_sk_redirect_map). But we
always run sk_skb and sk_msg progs RCU read lock held.
