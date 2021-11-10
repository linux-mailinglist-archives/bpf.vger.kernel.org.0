Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52B4F44C01E
	for <lists+bpf@lfdr.de>; Wed, 10 Nov 2021 12:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbhKJLax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Nov 2021 06:30:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230440AbhKJLaw (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 10 Nov 2021 06:30:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636543684;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yy8X/nNTlW/us5XEVCcNQ+a76b6anMgOpn+9RDa9uBM=;
        b=do6ZCS+YdG58y19B5FK4SO8Y0iyMOmdHayZOS5nDfnV9TM6RYmxHtp0V8jbV3HHwwiCy1d
        Q35njNP32tv544cLurWCN11iN/CHkiLeRILUBodJ4vNYg+BwIgOrzNSWwmBwZIbZLvheSu
        WsX0VcXoA6YTDuktIkUuo3aWeikwE9c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-dh3PHn3AOY-2EK3NVyWX6A-1; Wed, 10 Nov 2021 06:28:03 -0500
X-MC-Unique: dh3PHn3AOY-2EK3NVyWX6A-1
Received: by mail-ed1-f72.google.com with SMTP id f20-20020a0564021e9400b003e2ad3eae74so2069863edf.5
        for <bpf@vger.kernel.org>; Wed, 10 Nov 2021 03:28:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yy8X/nNTlW/us5XEVCcNQ+a76b6anMgOpn+9RDa9uBM=;
        b=a1bFXmPrNzgA8B+RL/y9fXGF8fHKkrHlC5LUdnpMtOFXze3eFL7geohYEh0xTVnJI8
         CLredOhnjrA1ojquInh9fpGx1ZP1tAkDuPFeroDEuuoS+PlkEKNt6yG3JovRUSwLGpFZ
         wD2OeJH5V1bvooyNczPP5Sb18trRVk84KSTgJNcuVO2g0Ti/RRtU0sxcaXyr9roPzaHy
         obSrTID0bSuXUtOH7m9zpWsvlj7eUHiraDubigxYlnzOc4TIc8Ay73nEblXRsGEHa3aM
         Fk9Je9/mwxahmnBRXn1ybQoA5X/OUwhZd9VwSs9ydxyjiQ3KMSWZj1F6qKaaaKEugFj1
         PXYQ==
X-Gm-Message-State: AOAM5331hBqHuGFb3rEuzeJ9kDJCy0LEfQbJ3f0JOiJ7+8j9WgHUNLyT
        2+SfLU9lInZgI1gx8pdLmmpmIy4sklZxvaqcgHvHg0nZhVTN6yS9BA5wgHaQCFGm850iGJL2LjG
        SSNLwpqbGqR7T
X-Received: by 2002:a17:906:a10c:: with SMTP id t12mr19310175ejy.429.1636543681397;
        Wed, 10 Nov 2021 03:28:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlXG0JR9BaSSXxYNbhobNEmdzy7EYQA9mpHkSp+FeD1FdoaTeUox55TncdB8AXaJIUhxmxqw==
X-Received: by 2002:a17:906:a10c:: with SMTP id t12mr19309959ejy.429.1636543679692;
        Wed, 10 Nov 2021 03:27:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u4sm10779606ejc.19.2021.11.10.03.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 03:27:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 4BFAA18026D; Wed, 10 Nov 2021 12:27:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Ciara Loftus <ciara.loftus@intel.com>
Subject: Re: [PATCH bpf-next] libbpf: demote log message about unrecognised
 data sections back down to debug
In-Reply-To: <CAEf4BzbysA058zK8wvnxeA=rrqCb+x3bP2X7wOqCj90tAHeFXQ@mail.gmail.com>
References: <20211104122911.779034-1-toke@redhat.com>
 <CAEf4BzYGjV5DQB7tqRkSKz6pz-3QtU7uSWQVNJMW4eSjnpF98A@mail.gmail.com>
 <87a6iismca.fsf@toke.dk>
 <CAEf4BzY9WxjBX65sa=8SJh4XGLGfHgxGKciRGiSUMJAxbQWWYg@mail.gmail.com>
 <87pmrargfc.fsf@toke.dk>
 <CAEf4BzbysA058zK8wvnxeA=rrqCb+x3bP2X7wOqCj90tAHeFXQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 10 Nov 2021 12:27:57 +0100
Message-ID: <87ilx0p7wi.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Mon, Nov 8, 2021 at 4:16 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>>
>> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>>
>> > On Fri, Nov 5, 2021 at 7:34 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@=
redhat.com> wrote:
>> >>
>> >> Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:
>> >>
>> >> > On Thu, Nov 4, 2021 at 5:29 AM Toke H=C3=B8iland-J=C3=B8rgensen <to=
ke@redhat.com> wrote:
>> >> >>
>> >> >> When loading a BPF object, libbpf will output a log message when it
>> >> >> encounters an unrecognised data section. Since commit
>> >> >> 50e09460d9f8 ("libbpf: Skip well-known ELF sections when iterating=
 ELF")
>> >> >> they are printed at "info" level so they will show up on the conso=
le by
>> >> >> default.
>> >> >>
>> >> >> The rationale in the commit cited above is to "increase visibility=
" of such
>> >> >> errors, but there can be legitimate, and completely harmless, uses=
 of extra
>> >> >> data sections. In particular, libxdp uses custom data sections to =
store
>> >> >
>> >> > What if we make those extra sections to be ".rodata.something" and
>> >> > ".data.something", but without ALLOC flag in ELF, so that libbpf wo=
n't
>> >> > create maps for them. Libbpf also will check that program code never
>> >> > references anything from those sections.
>> >> >
>> >> > The worry I have about allowing arbitrary sections is that if in the
>> >> > future we want to add other special sections, then we might run int=
o a
>> >> > conflict with some applications. So having some enforced naming
>> >> > convention would help prevent this. WDYT?
>> >>
>> >> Hmm, I see your point, but as the libxdp example shows, this has not
>> >> really been "disallowed" before. I.e., having these arbitrary sections
>> >> has worked just fine.
>> >
>> > A bunch of things were not disallowed, but that is changing for libbpf
>> > 1.0, so now is the right time :)
>> >
>> >>
>> >> How about we do the opposite: claim a namespace for future libbpf
>> >> extensions and disallow (as in, hard fail) if anything unrecognised is
>> >> in those sections? For instance, this could be any section names
>> >> starting with .BPF?
>> >
>> > Looking at what we added (.maps, .kconfig, .ksym), there is no common
>> > prefix besides ".". I'd be ok to reserve anything starting with "."
>> > for future use by libbpf. We can allow any non-dot section without a
>> > warning (but it would have to be non-allocatable section). Would that
>> > work?
>>
>> Not really :(
>>
>> We already use .xdp_run_config as one of the section names in libxdp, so
>
> Are any of those sections allocatable? What if libbpf complains about
> allocatable ones only?

They are:
  5 .xdp_run_config 00000010  0000000000000000  0000000000000000  00000e70 =
 2**3
                  CONTENTS, ALLOC, LOAD, DATA

They are just defined using the SEC() macro, like:

#define _CONCAT(x,y) x ## y
#define XDP_RUN_CONFIG(f) _CONCAT(_,f) SEC(".xdp_run_config")
struct {
	__uint(priority, 10);
	__uint(XDP_PASS, 1);
} XDP_RUN_CONFIG(FUNCNAME);

Is there a way to avoid the sections being marked as allocatable using
such macros?

> Also, how widely libxdp is used so that it's already impossible to
> change anything?

Well, we've been shipping it in three or four RHEL point releases at
this point, but I don't think we have any actual usage data, so I
honestly don't know.

I'm not against changing it, though; the XDP_RUN_CONFIG macro above is
defined in a header file we ship with libxdp, so it's straight-forward
to redefine it. I don't mind being strict by default either, I just want
to be able to do something like:

obj =3D bpf_object__open_file(filename, opts);
if (!obj && errno =3D=3D EINVALIDSECTION) { /* or some other way of discove=
ring this */
  warn("found invalid section, consider recompiling program; continuing any=
way\n");
  opts.allow_arbitrary_sections=3Dtrue;
  obj =3D bpf_object__open_file(filename, opts);
}

This is similar to how iproute2 sets relaxed_maps when opening a file so
it can deal with its old map definition types, so there is some precedent...

-Toke

