Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B2D2FD5D6
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 17:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbhATQiM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 11:38:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47137 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391500AbhATQbm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 11:31:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611160215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HWEm9l+Fw77ui1b4c+Aizii9SYhFgNLuUIBsDhLc5/I=;
        b=E8oLFBFcOMJo37Ogen1bI+d7oruwJQWTX+BV70aDNX+htLXAknZpAxvFQhN7Oybg/s9wlA
        sNvSWlzb+nDwWAWxPLLPM57nh0mntlO2saF0aISt4LdobukMgFLvklm/OVf8LKuqGrn4i1
        klmR2EZOvnP0i+udszSHn8dBZOKbLTI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-DTexw1v2N_KlD-omyYapxg-1; Wed, 20 Jan 2021 11:30:11 -0500
X-MC-Unique: DTexw1v2N_KlD-omyYapxg-1
Received: by mail-ed1-f70.google.com with SMTP id w4so7567501edu.0
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 08:30:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HWEm9l+Fw77ui1b4c+Aizii9SYhFgNLuUIBsDhLc5/I=;
        b=X5tz5q6lr70Vyn9g8nrcy8QeVUaU9Z/YyvQYE3ZVzwmaw97NdU1lw9IpnFl3JaIXwn
         YB2r8NuwfAiGOGRJK7rqh1ObdJSrK1e8aT3/WsK1F3GSgi3fL1i5Oy+yL4ijbTpCqx3v
         Tl/0pl15OwiivhXm3hBAYJLN6stKX/miTTcOnuzA3tGNdRkurph4TSyiQVyKvXpMIiyj
         1DaeBocfddV9voKtfAtyTMFsYrS1m4PcLntmgnzSSfsxkTgQDkjVPyY0B1ob1EOWUCIm
         gapMklvwB2gtf8ZKGMEBkEoIVLrzjKq6959xs6ppFTcl/EqmuKRzC5+I/vnMiiuX2ycq
         uCTw==
X-Gm-Message-State: AOAM5312e1s6UvLtUUC/eY9M/G/6VkQJ9gR82qjmvutDNujs84TclzU6
        8GziPRZaTrt9hL+K4T7nJmOzGU4Wv18CD6/yuX/VarTaDkypdJr1SRyTigQ8XeXIK3Xs3QKozk4
        xCtZ3LtpLRuHx
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr8206044eds.328.1611160210625;
        Wed, 20 Jan 2021 08:30:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXwH7VEwgQS8Dcshv8QzzgTXA6+377docK5Eq2A/xU5tlEOH81mMXGrnSjXxlNGjwIqhgWsg==
X-Received: by 2002:aa7:c7d8:: with SMTP id o24mr8206028eds.328.1611160210419;
        Wed, 20 Jan 2021 08:30:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id x25sm1349302edv.65.2021.01.20.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 08:30:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 171DF180331; Wed, 20 Jan 2021 17:30:09 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com
Subject: Re: [PATCH bpf-next v2 1/8] xdp: restructure redirect actions
In-Reply-To: <0a7d1a0b-de2e-b973-a807-b9377bb89737@intel.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-2-bjorn.topel@gmail.com> <87bldjeq1j.fsf@toke.dk>
 <996f1ff7-5891-fd4a-ee3e-fefd7e93879d@intel.com> <87mtx34q48.fsf@toke.dk>
 <0a7d1a0b-de2e-b973-a807-b9377bb89737@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 17:30:09 +0100
Message-ID: <87bldj4lm6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-01-20 15:52, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:
>>=20
>>> On 2021-01-20 13:44, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>>>
>>>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>>>>
>>>>> The XDP_REDIRECT implementations for maps and non-maps are fairly
>>>>> similar, but obviously need to take different code paths depending on
>>>>> if the target is using a map or not. Today, the redirect targets for
>>>>> XDP either uses a map, or is based on ifindex.
>>>>>
>>>>> Future commits will introduce yet another redirect target via the a
>>>>> new helper, bpf_redirect_xsk(). To pave the way for that, we introduce
>>>>> an explicit redirect type to bpf_redirect_info. This makes the code
>>>>> easier to follow, and makes it easier to add new redirect targets.
>>>>>
>>>>> Further, using an explicit type in bpf_redirect_info has a slight
>>>>> positive performance impact by avoiding a pointer indirection for the
>>>>> map type lookup, and instead use the hot cacheline for
>>>>> bpf_redirect_info.
>>>>>
>>>>> The bpf_redirect_info flags member is not used by XDP, and not
>>>>> read/written any more. The map member is only written to when
>>>>> required/used, and not unconditionally.
>>>>
>>>> I like the simplification. However, the handling of map clearing becom=
es
>>>> a bit murky with this change:
>>>>
>>>> You're not changing anything in bpf_clear_redirect_map(), and you're
>>>> removing most of the reads and writes of ri->map. Instead,
>>>> bpf_xdp_redirect_map() will store the bpf_dtab_netdev pointer in
>>>> ri->tgt_value, which xdp_do_redirect() will just read and use without
>>>> checking. But if the map element (or the entire map) has been freed in
>>>> the meantime that will be a dangling pointer. I *think* the RCU callba=
ck
>>>> in dev_map_delete_elem() and the rcu_barrier() in dev_map_free()
>>>> protects against this, but that is by no means obvious. So confirming
>>>> this, and explaining it in a comment would be good.
>>>>
>>>
>>> Yes, *most* of the READ_ONCE(ri->map) are removed, it's pretty much only
>>> the bpf_redirect_map(), and as you write, the tracepoints.
>>>
>>> The content/element of the map is RCU protected, and actually even the
>>> map will be around until the XDP processing is complete. Note the
>>> synchronize_rcu() followed after all bpf_clear_redirect_map() calls.
>>>
>>> I'll try to make it clearer in the commit message! Thanks for pointing
>>> that out!
>>>
>>>> Also, as far as I can tell after this, ri->map is only used for the
>>>> tracepoint. So how about just storing the map ID and getting rid of the
>>>> READ/WRITE_ONCE() entirely?
>>>>
>>>
>>> ...and the bpf_redirect_map() helper. Don't you think the current
>>> READ_ONCE(ri->map) scheme is more obvious/clear?
>>=20
>> Yeah, after your patch we WRITE_ONCE() the pointer in
>> bpf_redirect_map(), but the only place it is actually *read* is in the
>> tracepoint. So the only purpose of bpf_clear_redirect_map() is to ensure
>> that an invalid pointer is not read in the tracepoint function. Which
>> seems a bit excessive when we could just store the map ID for direct use
>> in the tracepoint and get rid of bpf_clear_redirect_map() entirely, no?
>>=20
>> Besides, from a UX point of view, having the tracepoint display the map
>> ID even if that map ID is no longer valid seems to me like it makes more
>> sense than just displaying a map ID of 0 and leaving it up to the user
>> to figure out that this is because the map was cleared. I mean, at the
>> time the redirect was made, that *was* the map ID that was used...
>>
>
> Convinced! Getting rid of bpf_clear_redirect_map() would be good! I'll
> take a stab at this for v3!

Cool!

>> Oh, and as you say due to the synchronize_rcu() call in dev_map_free() I
>> think this whole discussion is superfluous anyway, since it can't
>> actually happen that the map gets freed between the setting and reading
>> of ri->map, no?
>>
>
> It can't be free'd but, ri->map can be cleared via
> bpf_clear_redirect_map(). So, between the helper (setting) and the
> tracepoint in xdp_do_redirect() it can be cleared (say if the XDP
> program is swapped out, prior running xdp_do_redirect()).

But xdp_do_redirect() should be called on driver flush before exiting
the NAPI cycle, so how can the XDP program be swapped out?

> Moving to the scheme you suggested, does make the discussion
> superfluous. :-)

Yup, awesome :)

-Toke

