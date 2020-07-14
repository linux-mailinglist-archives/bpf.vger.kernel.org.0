Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D71D21FE47
	for <lists+bpf@lfdr.de>; Tue, 14 Jul 2020 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgGNUNK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jul 2020 16:13:10 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbgGNUNC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jul 2020 16:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594757579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=epQzRWmEJ0TEVMCJclQkMZjp6uajfCoJPt5RjKAabKg=;
        b=Upz8g/u6OkRZWKy0z25vZb8sOM91aegLaCXZ5ZcNv2bwAiqHQ/Vkp9Bbm55fZoj5Ff6dE+
        uc7LlTENxFIzoWEH0KlxNXw0aAiVQAzomOsOL3emh9pGRt/rSHwuWnmvrgn1rD0z0hcPBo
        M4jKo289dpu75nlxgDhd/hvUG76el58=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-N2Ed4zyrMEiLWFY_gm5ABQ-1; Tue, 14 Jul 2020 16:12:58 -0400
X-MC-Unique: N2Ed4zyrMEiLWFY_gm5ABQ-1
Received: by mail-qk1-f199.google.com with SMTP id j79so13889581qke.5
        for <bpf@vger.kernel.org>; Tue, 14 Jul 2020 13:12:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=epQzRWmEJ0TEVMCJclQkMZjp6uajfCoJPt5RjKAabKg=;
        b=SF4KRD1uzk9kz6pr9cyK0J8lJjMqK47YaDvl2Te9h7WSh3qYe5Q6Ad52cnDbqwjuBS
         AnORyOKkLTExaq2Lw92yTiSpxl9ZeZrh8i1AgvoRcozOJBTmqmFOwviitYnO9+RyZ1rV
         qDsqU98eorriuqEUWqAjf3CbQUnbF43+4VXt5pqg1YbNAVpC9ZA9maKbHPEEalYqKa/F
         DUxKrE20cJ/vzCaJDg4lusUe+2E4RTU6a+kKCIg16PZKlo38HVrBEn9VaAsFA3WPaVcr
         zfFeDYZXxs5itN/cV0uTz15K0q4cMsGpTTiNM+5vV2OdD38pJ8NhfRdw5M719Blnrrg3
         u1GQ==
X-Gm-Message-State: AOAM530EbTZ/0hw1K9luy/XHxAjeH0+wONjPEJzjbGvs6mR4umSqJMgT
        nOcDg4o7Nzo53fjr0hqM76PvkXW+FQXk32AnstXM4MYEdV8nCKDww1ITNtdmKyU9Lb2djGb1/Lb
        EGU89xuO3xl5X
X-Received: by 2002:ad4:424a:: with SMTP id l10mr6393534qvq.29.1594757577602;
        Tue, 14 Jul 2020 13:12:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+y9aS9yXrgvbZCrNrOp/eSMCyejrZWDa1jSC0/SGQAeR7GIrBilIVGztv4Wg0bXvSF6r/nQ==
X-Received: by 2002:ad4:424a:: with SMTP id l10mr6393505qvq.29.1594757577273;
        Tue, 14 Jul 2020 13:12:57 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r2sm53431qtn.27.2020.07.14.13.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:12:56 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8A0CC1804F0; Tue, 14 Jul 2020 22:12:54 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kicinski@fb.com>, Andrey Ignatov <rdna@fb.com>,
        Takshak Chahande <ctakshak@fb.com>
Subject: Re: [PATCH bpf-next 2/7] bpf, xdp: add bpf_link-based XDP attachment API
In-Reply-To: <CAEf4BzY7qRsdcdhzf2--Bfgo-GB=ZoKKizOb+OHO7o2PMiNubA@mail.gmail.com>
References: <20200710224924.4087399-1-andriin@fb.com> <20200710224924.4087399-3-andriin@fb.com> <877dv6gpxd.fsf@toke.dk> <CAEf4BzY7qRsdcdhzf2--Bfgo-GB=ZoKKizOb+OHO7o2PMiNubA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Jul 2020 22:12:54 +0200
Message-ID: <87v9ipg8jd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Jul 14, 2020 at 6:57 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>> > Add bpf_link-based API (bpf_xdp_link) to attach BPF XDP program through
>> > BPF_LINK_CREATE command.
>>
>> I'm still not convinced this is a good idea. As far as I can tell, at
>> this point adding this gets you three things:
>>
>> 1. The ability to 'lock' an attachment in place.
>>
>> 2. Automatic detach on fd close
>>
>> 3. API unification with other uses of BPF_LINK_CREATE.
>>
>>
>> Of those, 1. is certainly useful, but can be trivially achieved with the
>> existing netlink API (add a flag on attach that prevents removal unless
>> the original prog_fd is supplied as EXPECTED_FD).
>
> Given it's trivial to discover attached prog FD on a given ifindex, it
> doesn't add much of a peace of mind to the application that installs
> bpf_link. Any other XDP-enabled program (even some trivial test
> program) can unknowingly break other applications by deciding to
> "auto-cleanup" it's previous instance on restart ("what's my previous
> prog FD? let's replace it with my up-to-date program FD! What do you
> mean it wasn't my prog FD before?). We went over this discussion many
> times already: relying on the correct behavior of *other*
> applications, which you don't necessarily control, is not working well
> in real production use cases.

It's trivial to discover the attached *ID*. But the id-to-fd transition
requires CAP_SYS_ADMIN, which presumably you're not granting these
not-necessarily-well-behaved programs. Because if you are, what's
stopping them from just killing the owner of the bpf_link to clear it
("oh, must be a previous instance of myself that's still running, let's
clear that up")? Or what else am I missing here?

>> 2. is IMO the wrong model for XDP, as I believe I argued the last time
>> we discussed this :)
>> In particular, in a situation with multiple XDP programs attached
>> through a dispatcher, the 'owner' application of each program don't
>> 'own' the interface attachment anyway, so if using bpf_link for that it
>> would have to be pinned somewhere anyway. So the 'automatic detach'
>> feature is only useful in the "xdpd" deployment scenario, whereas in the
>> common usage model of command-line attachment ('ip link set xdp...') it
>> is something that needs to be worked around.
>
> Right, nothing changed since we last discussed. There are cases where
> one or another approach is more convenient. Having bpf_link for XDP
> finally gives an option to have an auto-detaching (on last FD close)
> approach, but you still insist there shouldn't be such an option. Why?

Because the last time we discussed this, it was in the context of me
trying to extend the existing API and being told "no, don't do that, use
bpf_link instead". So I'm objecting to bpf_link being a *replacement*
for the exiting API; if that's not what you're intending, and we can
agree to keep both around and actively supported (including things like
adding that flag to the netlink API I talked about above), then that's a
totally different matter :)

>> 3. would be kinda nice, I guess, if we were designing the API from
>> scratch. But we already have an existing API, so IMO the cost of
>> duplication outweighs any benefits of API unification.
>
> Not unification of BPF_LINK_CREATE, but unification of bpf_link
> infrastructure in general, with its introspection and discoverability
> APIs. bpftool can show which programs are attached where and it can
> show PIDs of processes that own the BPF link.

Right, sure, I was using BPF_LINK_CREATE as a shorthand for bpf_link in
general.

> With CAP_BPF you have also more options now how to control who can
> mess with your bpf_link.

What are those, exactly?

[...]

>> I was under the impression that forcible attachment of bpf_links was
>> already possible, but looking at the code now it doesn't appear to be?
>> Wasn't that the whole point of BPF_LINK_GET_FD_BY_ID? I.e., that a
>> sysadmin with CAP_SYS_ADMIN privs could grab the offending bpf_link FD
>> and force-remove it? I certainly think this should be added before we
>> expand bpf_link usage any more...
>
> I still maintain that killing processes that installed the bpf_link is
> the better approach. Instead of letting the process believe and act as
> if it has an active XDP program, while it doesn't, it's better to
> altogether kill/restart the process.

Killing the process seems like a very blunt tool, though. Say it's a
daemon that attaches XDP programs to all available interfaces, but you
want to bring down an interface for some one-off maintenance task, but
the daemon authors neglected to provide an interface to tell the daemon
to detach from specific interfaces. If your only option is to kill the
daemon, you can't bring down that interface without disrupting whatever
that daemon is doing with XDP on all the other interfaces.

-Toke

