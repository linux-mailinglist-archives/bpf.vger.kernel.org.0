Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CED2FD3A7
	for <lists+bpf@lfdr.de>; Wed, 20 Jan 2021 16:15:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731468AbhATPOv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 Jan 2021 10:14:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20364 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387649AbhATPNQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 20 Jan 2021 10:13:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611155498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+rVDjZfYpOTzxpMpGoQtnQ9qnYqt/faYycyF0O3r+U=;
        b=CGGSN6u5IfGWDYSF8SKuqdmvjBIz3IvN6fN9AD4xg7c806J107tQZzTnZj1wIWV9phBaQb
        nobHJ9O5LST3BAqCZhNaj5Fa4xNu0bgxK3mzsbQImtRDZHD5NoYlwLxGV15IQnOm4BDImG
        aEoPQnieOMdiaEZmQk4IWhRYcvilFTg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-frsuZuXnOZOxJdpXvqnfkg-1; Wed, 20 Jan 2021 10:11:36 -0500
X-MC-Unique: frsuZuXnOZOxJdpXvqnfkg-1
Received: by mail-ed1-f69.google.com with SMTP id g14so11261440edt.12
        for <bpf@vger.kernel.org>; Wed, 20 Jan 2021 07:11:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=2+rVDjZfYpOTzxpMpGoQtnQ9qnYqt/faYycyF0O3r+U=;
        b=Os7z9w+/UhNv4RgDvfzNEBtYP9QmLHrKKY32utp0xsH4k/bFPEUY+rw1p/CjqF0r3L
         8cCSKWn9wrlpnwt18wm/pfL9RqE/Va3363tXEBVzS/3DM0u9Apga1qdk8ZQrSd04iapF
         f2rrNuCs37lBWBOBTBINWNVtl8fukwpHg/bIRRQ0Ps7OYDFRwz8BO46YOqG6kmyMIPCa
         1aJsILm3ae1hBFLOBeesw7kbKQcL+UfuAE8jR9vQHfItgVZ3vBtVXQhgL1OWh+WTQfqB
         JLA1RpnGQovPJ0riPCnPfSvDOFHwikcBeWbtD3fmYwF+tr4YFLcvyZkhngga+gvRfzcr
         4VcA==
X-Gm-Message-State: AOAM531w56u7RU2OKcBGIdBXZQmWX5HxGp6T9TLoDcBAhLvwWDGYMTlm
        C2I7HBbzS+hftbxoraT/qpPsvnr8yvq/cMxWyBivnNYbULihau2KY1YT59KUW4CA7Bko84mvBGU
        RW38in4OjgZgl
X-Received: by 2002:a17:906:a88d:: with SMTP id ha13mr4210034ejb.124.1611155495550;
        Wed, 20 Jan 2021 07:11:35 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzMH8OfR2oiso+P02cm92BqsOlWFkxgDeiMDUFbzrwe0aRKPY9yM+U2yA5t5scMBcIpEFNY5w==
X-Received: by 2002:a17:906:a88d:: with SMTP id ha13mr4210009ejb.124.1611155495149;
        Wed, 20 Jan 2021 07:11:35 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qk1sm1016341ejb.86.2021.01.20.07.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 07:11:34 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28979180331; Wed, 20 Jan 2021 16:11:33 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Cc:     magnus.karlsson@intel.com, maciej.fijalkowski@intel.com,
        kuba@kernel.org, jonathan.lemon@gmail.com, maximmi@nvidia.com,
        davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        ciara.loftus@intel.com, weqaar.a.janjua@intel.com,
        Marek Majtyka <alardam@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/8] libbpf, xsk: select AF_XDP BPF program
 based on kernel version
In-Reply-To: <6cda7383-663e-ed92-45dd-bbf87ca45eef@intel.com>
References: <20210119155013.154808-1-bjorn.topel@gmail.com>
 <20210119155013.154808-6-bjorn.topel@gmail.com> <875z3repng.fsf@toke.dk>
 <6c7da700-700d-c7f6-fe0a-c42e55e81c8a@intel.com>
 <6cda7383-663e-ed92-45dd-bbf87ca45eef@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 20 Jan 2021 16:11:33 +0100
Message-ID: <87eeif4p96.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com> writes:

> On 2021-01-20 14:25, Bj=C3=B6rn T=C3=B6pel wrote:
>> On 2021-01-20 13:52, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>> Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:
>>>
>>>> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>>>>
>>>> Add detection for kernel version, and adapt the BPF program based on
>>>> kernel support. This way, users will get the best possible performance
>>>> from the BPF program.
>>>
>>> Please do explicit feature detection instead of relying on the kernel
>>> version number; some distro kernels are known to have a creative notion
>>> of their own version, which is not really related to the features they
>>> actually support (I'm sure you know which one I'm referring to ;)).
>>>
>>=20
>> Right. For a *new* helper, like bpf_redirect_xsk, we rely on rejection
>> from the verifier to detect support. What about "bpf_redirect_map() now
>> supports passing return value as flags"? Any ideas how to do that in a
>> robust, non-version number-based scheme?
>>
>
> Just so that I understand this correctly. Red^WSome distro vendors
> backport the world, and call that franken kernel, say, 3.10. Is that
> interpretation correct? My hope was that wasn't the case. :-(

Yup, indeed. All kernels shipped for the entire lifetime of RHEL8 think
they are v4.18.0... :/

I don't think we're the only ones doing it (there are examples in the
embedded world as well, for instance, and not sure about the other
enterprise distros), but RHEL is probably the most extreme example.

We could patch the version check in the distro-supplied version of
libbpf, of course, but that doesn't help anyone using upstream versions,
and given the prevalence of vendoring libbpf, I fear that going with the
version check will just result in a bad user experience...

> Would it make sense with some kind of BPF-specific "supported
> features" mechanism? Something else with a bigger scope (whole
> kernel)?

Heh, in my opinion, yeah. Seems like we'll finally get it for XDP, but
for BPF in general the approach has always been probing AFAICT.

For the particular case of arguments to helpers, I suppose the verifier
could technically validate value ranges for flags arguments, say. That
would be nice as an early reject anyway, but I'm not sure if it is
possible to add after-the-fact without breaking existing programs
because the verifier can't prove the argument is within the valid range.
And of course it doesn't help you with compatibility with
already-released kernels.

-Toke

