Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DF952471
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 09:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfFYH2M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 03:28:12 -0400
Received: from mail-lj1-f173.google.com ([209.85.208.173]:37659 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfFYH2M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jun 2019 03:28:12 -0400
Received: by mail-lj1-f173.google.com with SMTP id 131so15168521ljf.4
        for <bpf@vger.kernel.org>; Tue, 25 Jun 2019 00:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=fhMQBII1i8TqYdZm3nYoWajnTZAZNea+HydYBEMLSVM=;
        b=q7YZtnD54QLv3xfmNo5Eh2f5de1f1Pn/CmtBc41D2ZV1hsTvS8LAaxX9KeoywEAGvt
         ACDeyfWK5ucRxVu9C/Mp5q+M7DAai4JF7Gm0PaxBvL3tF06cHFOPuS6dY4ntdRP2jzof
         cPXsG3Qx6luRRR+twILGKMwuMTdm7VOhuvWl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=fhMQBII1i8TqYdZm3nYoWajnTZAZNea+HydYBEMLSVM=;
        b=tDcf0OMaoIWd4mkQW4+95RV25XEmS0aPnJx5hS5Zi4eFRH70jgpMjFvLf3AAme0sTX
         EIgxqeZF38EgoEIIkht6W6N3eLPywhj8STbqX/sd2P5a8nv+5GfsCbmvB7IQoM6QxVas
         b3ue2CWaaMhzS5fdQ60QdRVp2gEQPtACTfWTLTWLYCxrUzoIHgzXTc84gXIMcF7VRCZz
         S3gce/UhfpFwDFm+d9fzlohRj/Quw/Z7CS25bvFKfSxaSMIjEI9K/iD5vUr5kBgA7TSx
         oqdIcdj+P4/op9uQixqnW5cZmXPq3TM1im/YJEKLKQb9kpkPCu+CNwpHwaAguuT9UU37
         sKgA==
X-Gm-Message-State: APjAAAWRuM3JC6fc8dKiKGdkhBDIha5I+c7fCUGwRiQzecalUO4bIjjt
        lzD4c4yAQ68x37Hmu4biPrq0nJfW2NQVaA==
X-Google-Smtp-Source: APXvYqwLbVzuVMiOjlEqk+IiNo71mo2VcOIOWR5mITTFluF/RL+cOlVf/ykmsrWFCC3hJWEslyxXrg==
X-Received: by 2002:a2e:2993:: with SMTP id p19mr54766840ljp.202.1561447690649;
        Tue, 25 Jun 2019 00:28:10 -0700 (PDT)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id a9sm1796911lfj.79.2019.06.25.00.28.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 25 Jun 2019 00:28:09 -0700 (PDT)
References: <20190618130050.8344-1-jakub@cloudflare.com> <20190618135258.spo6c457h6dfknt2@breakpoint.cc> <87sgs6ey43.fsf@cloudflare.com> <CAOftzPj6NWyWnz4JL-mXBaQUKAvQDtKJTrjZmrN4W5rqoy-W0A@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Joe Stringer <joe@wand.net.nz>
Cc:     Florian Westphal <fw@strlen.de>, netdev <netdev@vger.kernel.org>,
        bpf@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [RFC bpf-next 0/7] Programming socket lookup with BPF
In-reply-to: <CAOftzPj6NWyWnz4JL-mXBaQUKAvQDtKJTrjZmrN4W5rqoy-W0A@mail.gmail.com>
Date:   Tue, 25 Jun 2019 09:28:09 +0200
Message-ID: <878stqceeu.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[Reposting with correct format this time. Sorry.]

On Fri, Jun 21, 2019 at 12:20 AM CEST, Joe Stringer wrote:
> On Wed, Jun 19, 2019 at 2:14 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>
>> Hey Florian,
>>
>> Thanks for taking a look at it.
>>
>> On Tue, Jun 18, 2019 at 03:52 PM CEST, Florian Westphal wrote:
>> > Jakub Sitnicki <jakub@cloudflare.com> wrote:
>> >>  - XDP programs using bpf_sk_lookup helpers, like load balancers, can't
>> >>    find the listening socket to check for SYN cookies with TPROXY redirect.
>> >
>> > Sorry for the question, but where is the problem?
>> > (i.e., is it with TPROXY or bpf side)?
>>
>> The way I see it is that the problem is that we have mappings for
>> steering traffic into sockets split between two places: (1) the socket
>> lookup tables, and (2) the TPROXY rules.
>>
>> BPF programs that need to check if there is a socket the packet is
>> destined for have access to the socket lookup tables, via the mentioned
>> bpf_sk_lookup helper, but are unaware of TPROXY redirects.
>>
>> For TCP we're able to look up from BPF if there are any established,
>> request, and "normal" listening sockets. The listening sockets that
>> receive connections via TPROXY are invisible to BPF progs.
>>
>> Why are we interested in finding all listening sockets? To check if any
>> of them had SYN queue overflow recently and if we should honor SYN
>> cookies.
>
> Why are they invisible? Can't you look them up with bpf_skc_lookup_tcp()?

They are invisible in that sense that you can't look them up using the
packet 4-tuple. You have to somehow make the XDP/TC progs aware of the
TPROXY redirects to find the target sockets.

-Jakub
