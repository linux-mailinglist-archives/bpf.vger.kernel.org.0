Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DED5442111
	for <lists+bpf@lfdr.de>; Mon,  1 Nov 2021 20:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbhKATwc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 15:52:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42817 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229896AbhKATwb (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 1 Nov 2021 15:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635796197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qqc178qZXVlRBTkSP0Y4vQlYfIbVccbQXGvB2hKE2bQ=;
        b=Hte8Sl8ZxkVsb7GvAr17GBppIZdeUck9yV9UO2Y7jGKQkhMWbKlzQ+gx3qCI7sx/ooQKr5
        lVDUJwAJ0H4oM7WJd0/8M3fTfkiT3Qy+qYcO0dGXxP+3UZwLkaUAz2mr9WM9ZuSZzHhh+h
        oxzZEC0yKoeUpanFdC4e0dkfyZGAcHw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-g5Fuw74JNiiK2sg8dtM6rQ-1; Mon, 01 Nov 2021 15:49:56 -0400
X-MC-Unique: g5Fuw74JNiiK2sg8dtM6rQ-1
Received: by mail-ed1-f69.google.com with SMTP id m16-20020a056402431000b003dd2005af01so16562129edc.5
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 12:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qqc178qZXVlRBTkSP0Y4vQlYfIbVccbQXGvB2hKE2bQ=;
        b=P+3wnfFUA4eVUL4Oy70uia6iDQ9HAWXZ4ivQsQNLshkSONGke2eHRcq087/H0OeBcJ
         NC7R12DTh+GOsix8SP1yGBSU572U/rDEhMibAEhCsfp3xcTnipTIKU8oML22rIp/b++H
         f3o0ImeUMmd3KQ642ycBChsSLaxIU0Na48XmGi/Ea2jdFZaN7Ro4wPxoV0B33IQuHrv4
         9iffMqOoY+7HnRA89FAXWI7m0FRCK1j8q2CXGvAHz8IkRznPh1QxuaUgorCnK5w/K734
         p01pShk5h4YSJlDnKjDVC7yE8+v03QUp+DQ9yV/ibQcPAvbywQ7p7CxsFNjX3c/BjR9u
         QM1A==
X-Gm-Message-State: AOAM533hFjnS46E1p7+2sHO2qjwxKsrPjCwAr3iXUvR0dMXCeCSqfjNW
        xU6diPBgutshm8lFerXzXzxco5H1wcRgS7E8L1/cI7LiITK4oDfVbzU027+xNgSgwvLsO1JKi3u
        gbSgKcAk0gIvK
X-Received: by 2002:a50:8744:: with SMTP id 4mr43744782edv.100.1635796195598;
        Mon, 01 Nov 2021 12:49:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgHydV0CV/xhpm8QAcsGfvxbZrz1g8h+fAKTtFLxBddFuMKEdw4igXKgtcQv3rCUwkr499hA==
X-Received: by 2002:a50:8744:: with SMTP id 4mr43744738edv.100.1635796195291;
        Mon, 01 Nov 2021 12:49:55 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t6sm9565835edj.27.2021.11.01.12.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:49:54 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 30EE4180248; Mon,  1 Nov 2021 20:49:54 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Florian Westphal <fw@strlen.de>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v1 5/6] net: netfilter: Add unstable CT
 lookup helper for XDP and TC-BPF
In-Reply-To: <20211031191045.GA19266@breakpoint.cc>
References: <20211030144609.263572-1-memxor@gmail.com>
 <20211030144609.263572-6-memxor@gmail.com>
 <20211031191045.GA19266@breakpoint.cc>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 01 Nov 2021 20:49:54 +0100
Message-ID: <87y2677j19.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Florian Westphal <fw@strlen.de> writes:

> Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>> This change adds conntrack lookup helpers using the unstable kfunc call
>> interface for the XDP and TC-BPF hooks.
>> 
>> Also add acquire/release functions (randomly returning NULL), and also
>> exercise the RET_PTR_TO_BTF_ID_OR_NULL path so that BPF program caller
>> has to check for NULL before dereferencing the pointer, for the TC hook.
>> These will be used in selftest.
>> 
>> Export get_net_ns_by_id and btf_type_by_id as nf_conntrack needs to call
>> them.
>
> It would be good to get a summary on how this is useful.
>
> I tried to find a use case but I could not.
> Entry will time out soon once packets stop appearing, so it can't be
> used for stack bypass.  Is it for something else?  If so, what?

I think Maxim's use case was to implement a SYN proxy in XDP, where the
XDP program just needs to answer the question "do I have state for this
flow already". For TCP flows terminating on the local box this can be
done via a socket lookup, but for a middlebox, a conntrack lookup is
useful. Maxim, please correct me if I got your use case wrong.

> For UDP it will work to let a packet pass through classic forward
> path once in a while, but this will not work for tcp, depending
> on conntrack settings (lose mode, liberal pickup etc. pp).

The idea is certainly to follow up with some kind of 'update' helper. At
a minimum a "keep this entry alive" update, but potentially more
complicated stuff as well. Details TBD, input welcome :)

>> +/* Unstable Kernel Helpers for XDP hook */
>> +static struct nf_conn *__bpf_nf_ct_lookup(struct net *net,
>> +					  struct bpf_sock_tuple *bpf_tuple,
>> +					  u32 tuple_len, u8 protonum,
>> +					  u64 netns_id, u64 flags)
>> +{
>> +	struct nf_conntrack_tuple_hash *hash;
>> +	struct nf_conntrack_tuple tuple;
>> +
>> +	if (flags != IP_CT_DIR_ORIGINAL && flags != IP_CT_DIR_REPLY)
>> +		return ERR_PTR(-EINVAL);
>
> The flags argument is not needed.
>
>> +	tuple.dst.dir = flags;
>
> .dir can be 0, its not used by nf_conntrack_find_get().
>
>> +	hash = nf_conntrack_find_get(net, &nf_ct_zone_dflt, &tuple);
>
> Ok, so default zone. Depending on meaning of "unstable helper" this
> is ok and can be changed in incompatible way later.

I'm not sure about the meaning of "unstable" either, TBH, but in either
case I'd rather avoid changing things if we don't have to, so I think
adding the zone as an argument from the get-go may be better...

-Toke

