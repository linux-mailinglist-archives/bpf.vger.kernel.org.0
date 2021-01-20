Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17CE2FDAF3
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 21:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391182AbhATUgX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 15:36:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732169AbhATU2m (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 15:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611174416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JU1eLhW0j33QPCa8V2Glay0rWrYplRUA4Gz2IU/7jhs=;
        b=MtG6sjurfKHOqvkI8qKH0mOl7EYZwrznYDu+E6TIwfk3oNEKQZ5t/+KgurEYBRGkyLqJs7
        Yqg+dvWfV/R0tgpze5qzUjVVYffWnbplO9eE50sP1jouNVQjTpobKL/tZp2EcPhIYXgcjD
        0VnTRuoLV1vHj39uCV172Mp5pcT5dbs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-lNgIxnI9O2e-HE-eMp5X4g-1; Wed, 20 Jan 2021 15:26:54 -0500
X-MC-Unique: lNgIxnI9O2e-HE-eMp5X4g-1
Received: by mail-ej1-f69.google.com with SMTP id rl8so7665846ejb.8
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 12:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=JU1eLhW0j33QPCa8V2Glay0rWrYplRUA4Gz2IU/7jhs=;
        b=bPWJFcEh13f6XvgzSLorkJDr1aoG+XlWNl5oPCdCE5Dm8estJRX68LIVIv8Px7xjE/
         MirczMw3VzXeYafegnCvbK/IIbhz7an53A0RnZiGDUnV4mOGU/vI+duPjST/IGMNkRpI
         RpHnSwLgcsptcXoDQXr/9/5xwhs6yoMDgpmH97laUd4qZ15IsVWE4ZSuVBTtVmKS68fq
         nN/4sXgFTYaQOPvui+DYGM6OeAE4ZlqmXym4uW54z6hzTVYN46jeKtNl2z3GVNqw0h05
         RtoxGWVjFBovTPrbj7wAzv3/MTe7PBG8Ywow1tsDahFTJlYtdZOYidmR7AGL1axxm8xK
         M1Yw==
X-Gm-Message-State: AOAM531FYP2taz80TAodIrjNPTzgNkYfQn32h36fc6jYvLMgRewJusz4
        /bMoo/4oXLlQmWn9oY6N3c8XltL7mTg0XHDxgAvjMzZJuzsQU3P2sb/4Lqhz0HbIUSEFA6/Tzq3
        hj4ud8eQ2nrVV
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr8386368edu.22.1611174412739;
        Wed, 20 Jan 2021 12:26:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWTV977qLeayzq21XIgUQyFsvOTpc3ncWXO2Yj25LmA4Y5thCtUF2ihh5Y52GVlkE9pB0spA==
X-Received: by 2002:aa7:dcc9:: with SMTP id w9mr8386347edu.22.1611174412544;
        Wed, 20 Jan 2021 12:26:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id i13sm1708131edu.22.2021.01.20.12.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 12:26:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 762FF180331; Wed, 20 Jan 2021 21:26:51 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com
Subject: Re: [PATCH bpf-next v2 4/8] xsk: register XDP sockets at bind(),
 and add new AF_XDP BPF helper
In-Reply-To: <ca8cbe21-f020-e5c0-5f09-19260e95839f@intel.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-5-bjorn.topel@gmail.com> <878s8neprj.fsf@toke.dk>
 <46162f5f-5b3c-903b-8b8d-7c1afc74cb05@intel.com> <87k0s74q1a.fsf@toke.dk>
 <3c6feb0d-6a64-2251-3cac-c79cff29d85c@intel.com> <8735yv4iv1.fsf@toke.dk>
 <ca8cbe21-f020-e5c0-5f09-19260e95839f@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 21:26:51 +0100
Message-ID: <87pn1z2w38.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-01-20 18:29, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:
>>=20
>>> On 2021-01-20 15:54, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:
>>>>
>>>>> On 2021-01-20 13:50, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>>>>>
>>>>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>>>>> index c001766adcbc..bbc7d9a57262 100644
>>>>>>> --- a/include/uapi/linux/bpf.h
>>>>>>> +++ b/include/uapi/linux/bpf.h
>>>>>>> @@ -3836,6 +3836,12 @@ union bpf_attr {
>>>>>>>      *	Return
>>>>>>>      *		A pointer to a struct socket on success or NULL if the file=
 is
>>>>>>>      *		not a socket.
>>>>>>> + *
>>>>>>> + * long bpf_redirect_xsk(struct xdp_buff *xdp_md, u64 action)
>>>>>>> + *	Description
>>>>>>> + *		Redirect to the registered AF_XDP socket.
>>>>>>> + *	Return
>>>>>>> + *		**XDP_REDIRECT** on success, otherwise the action parameter is=
 returned.
>>>>>>>      */
>>>>>>
>>>>>> I think it would be better to make the second argument a 'flags'
>>>>>> argument and make values > XDP_TX invalid (like we do in
>>>>>> bpf_xdp_redirect_map() now). By allowing any value as return you lose
>>>>>> the ability to turn it into a flags argument later...
>>>>>>
>>>>>
>>>>> Yes, but that adds a run-time check. I prefer this non-checked versio=
n,
>>>>> even though it is a bit less futureproof.
>>>>
>>>> That...seems a bit short-sighted? :)
>>>> Can you actually see a difference in your performance numbers?
>>>>
>>>
>>> I would rather add an additional helper *if* we see the need for flags,
>>> instead of paying for that upfront. For me, BPF is about being able to
>>> specialize, and not having one call with tons of checks.
>>=20
>> I get that, I'm just pushing back because omitting a 'flags' argument is
>> literally among the most frequent reasons for having to replace a
>> syscall (see e.g., [0]) instead of extending it. And yeah, I do realise
>> that the performance implications are different for XDP than for
>> syscalls, but maintainability of the API is also important; it's all a
>> tradeoff. This will be the third redirect helper variant for XDP and I'd
>> hate for the fourth one to have to be bpf_redirect_xsk_flags() because
>> it did turn out to be needed...
>>=20
>> (One potential concrete reason for this: I believe Magnus was talking
>> about an API that would allow a BPF program to redirect a packet into
>> more than one socket (cloning it in the process), or to redirect to a
>> socket+another target. How would you do that with this new helper?)
>>=20
>> [0] https://lwn.net/Articles/585415/
>>
>
> I have a bit of different view. One of the really nice parts about BPF
> is exactly specialization. A user can tailor the kernel do a specific
> thing. I *don't* see an issue with yet another helper, if that is needed
> in the future. I think that is better than bloated helpers trying to
> cope for all scenarios. I don't mean we should just add helpers all over
> the place, but I do see more lightly on adding helpers, than adding
> syscalls.
>
> Elaborating a bit on this: many device drivers try to handle all the
> things in the fast-path. I see BPF as one way forward to moving away
> from that. Setup what you need, and only run what you currently need,
> instead of the current "Is bleh on, then baz? Is this on, then that."
>
> So, I would like to avoid "future proofing" the helpers, if that makes
> sense. Use what you need. That's why BPF is so good (one of the
> things)!

Well, it's a tradeoff. We're still defining an API that should not be
(too) confusing...

> As for bpf_redirect_xsk() it's a leaner version of bpf_redirect_map().
> You want flags/shared sockets/...? Well go use bpf_redirect_map() and
> XSKMAP. bpf_redirect_xsk() is not for you.

This argument, however, I buy: bpf_redirect() is the single-purpose
helper for redirecting to an ifindex, bpf_redirect_xsk() is the
single-purpose helper for redirecting to an XSK, and bpf_redirect_map()
is the generic one that does both of those and more. Fair enough,
consider me convinced :)

> A lot of back-and-forth for *one* if-statement, but it's kind of a
> design thing for me. ;-)

Surely you don't mean to imply that you have *better* things to do with
your time than have a 10-emails-long argument over a single if
statement? ;)

-Toke

