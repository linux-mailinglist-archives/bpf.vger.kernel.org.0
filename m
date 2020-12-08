Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0A2D2A22
	for <lists+bpf@lfdr.de>; Tue,  8 Dec 2020 13:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgLHMA2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Dec 2020 07:00:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLHMA2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Dec 2020 07:00:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607428741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X3UiVLhoBn0QxGbQIaE3lfbb23sxxLlKxWSYI9eyG3I=;
        b=ZeDSW4CPzGdJi4bXnWMxMoerpkbmnRdXSMdi3LOuHLdzkitUdt3QuhZBGvC47/SwcmAoyx
        DZaKT4fj/USH8CsFfqzDtel+Gskv72gMLI4hQuNH05gkMj4sExrnpaWM0ShmRSYXSiFG/F
        Vbeaz0IoZmyJrLJwd36zst4NhHgqwcQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-NEbmAsioO2WzJSvzxt1HAw-1; Tue, 08 Dec 2020 06:58:59 -0500
X-MC-Unique: NEbmAsioO2WzJSvzxt1HAw-1
Received: by mail-wm1-f72.google.com with SMTP id d16so548855wmd.1
        for <bpf@vger.kernel.org>; Tue, 08 Dec 2020 03:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=X3UiVLhoBn0QxGbQIaE3lfbb23sxxLlKxWSYI9eyG3I=;
        b=oxrHrSYoyf/NugH2P+J9yKZ0zhowMNxWqXQiAvp9sL6YfGF1Nc7G/m3QGgO/BZxEVf
         yh49Dle4YbRN+AdYTKuEk0wWmAX54nQ/El1N58hfGQWi9EGYoxm4MrslKwbdeObD5/Ga
         TPt0tf+88XjBY25lwGNMPKGpCuj60Fz7+FasgTYhLJRJJPdkrhBDQxPQJfjb7ZUJ2Pkg
         oTiYOHfc+dkoxlofLglohXa8TrIWg+erGNpyO/G1M7HXHJjiypSxuGfkshfUVw2/gtjj
         exmxS6nNQ04H2QlF4KQyi+tcI+hL5P37a1fqz4eq1qu00sX7YLNdyD2e8HqmWiYzlP6A
         Xa0A==
X-Gm-Message-State: AOAM530QgTt/leN4t4za7UGNkAr3yc2eNCMSX+PT9X+z84VKSiDfv/pz
        MpUeAHEnF5V0TYWyP+iZLd5RS6Jc5hwLdie/uNpWNpjkwJtXWSJ9W3Y9DWbeMVhs1+cTys1kFkK
        8H299npCCfPAy
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3532621wmi.164.1607428738542;
        Tue, 08 Dec 2020 03:58:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztnhlMopB/tBeUjOLv6knn4JP4rwNtEk3g6zzAXTDTjNarHkAPjHiVgYn2NYy0BbdBqs0ZzA==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3532576wmi.164.1607428737875;
        Tue, 08 Dec 2020 03:58:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 94sm11113339wrq.22.2020.12.08.03.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 03:58:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6E42118060F; Tue,  8 Dec 2020 12:58:55 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <jbrouer@redhat.com>,
        David Ahern <dsahern@gmail.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        alardam@gmail.com, magnus.karlsson@intel.com,
        bjorn.topel@intel.com, andrii.nakryiko@gmail.com, kuba@kernel.org,
        ast@kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
        hawk@kernel.org, jonathan.lemon@gmail.com, bpf@vger.kernel.org,
        jeffrey.t.kirsher@intel.com, maciejromanfijalkowski@gmail.com,
        intel-wired-lan@lists.osuosl.org,
        Marek Majtyka <marekx.majtyka@intel.com>
Subject: Re: [PATCH v2 bpf 1/5] net: ethtool: add xdp properties flag set
In-Reply-To: <20201208092803.05b27db3@carbon>
References: <20201204102901.109709-1-marekx.majtyka@intel.com>
 <20201204102901.109709-2-marekx.majtyka@intel.com>
 <878sad933c.fsf@toke.dk> <20201204124618.GA23696@ranger.igk.intel.com>
 <048bd986-2e05-ee5b-2c03-cd8c473f6636@iogearbox.net>
 <20201207135433.41172202@carbon>
 <5fce960682c41_5a96208e4@john-XPS-13-9370.notmuch>
 <431a53bd-25d7-8535-86e1-aa15bf94e6c3@gmail.com>
 <20201208092803.05b27db3@carbon>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 08 Dec 2020 12:58:55 +0100
Message-ID: <87lfe8ik5c.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <jbrouer@redhat.com> writes:

> On Mon, 7 Dec 2020 18:01:00 -0700
> David Ahern <dsahern@gmail.com> wrote:
>
>> On 12/7/20 1:52 PM, John Fastabend wrote:
>> >>
>> >> I think we need to keep XDP_TX action separate, because I think that
>> >> there are use-cases where the we want to disable XDP_TX due to end-user
>> >> policy or hardware limitations.  
>> > 
>> > How about we discover this at load time though. 
>
> Nitpick at XDP "attach" time. The general disconnect between BPF and
> XDP is that BPF can verify at "load" time (as kernel knows what it
> support) while XDP can have different support/features per driver, and
> cannot do this until attachment time. (See later issue with tail calls).
> (All other BPF-hooks don't have this issue)
>
>> > Meaning if the program
>> > doesn't use XDP_TX then the hardware can skip resource allocations for
>> > it. I think we could have verifier or extra pass discover the use of
>> > XDP_TX and then pass a bit down to driver to enable/disable TX caps.
>> >   
>> 
>> This was discussed in the context of virtio_net some months back - it is
>> hard to impossible to know a program will not return XDP_TX (e.g., value
>> comes from a map).
>
> It is hard, and sometimes not possible.  For maps the workaround is
> that BPF-programmer adds a bound check on values from the map. If not
> doing that the verifier have to assume all possible return codes are
> used by BPF-prog.
>
> The real nemesis is program tail calls, that can be added dynamically
> after the XDP program is attached.  It is at attachment time that
> changing the NIC resources is possible.  So, for program tail calls the
> verifier have to assume all possible return codes are used by BPF-prog.

We actually had someone working on a scheme for how to express this for
programs some months ago, but unfortunately that stalled out (Jesper
already knows this, but FYI to the rest of you). In any case, I view
this as a "next step". Just exposing the feature bits to userspace will
help users today, and as a side effect, this also makes drivers declare
what they support, which we can then incorporate into the core code to,
e.g., reject attachment of programs that won't work anyway. But let's
do this in increments and not make the perfect the enemy of the good
here.

> BPF now have function calls and function replace right(?)  How does
> this affect this detection of possible return codes?

It does have the same issue as tail calls, in that the return code of
the function being replaced can obviously change. However, the verifier
knows the target of a replace, so it can propagate any constraints put
upon the caller if we implement it that way.

-Toke

