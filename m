Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCCE17F752
	for <lists+bpf@lfdr.de>; Tue, 10 Mar 2020 13:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCJMWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 10 Mar 2020 08:22:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60055 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgCJMWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 10 Mar 2020 08:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583842959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HUqaOQyD8111sqhLYIu3c8eoonnzyP/fK860jh3cL6c=;
        b=c6P3EHQtTCzj1bGmaC5ifbMHb6r3yXPHlyXA/ZQHImykHasFkEzZFfhIOGFK1vzt1NAK+N
        6j6qiZDYERIYDTJGcHgeYQwwbED/s+hkBGMwCGLGvhzT/4l/Do5t2KwqzgGQJNLbsjjokM
        2sNBcP8v2VlADH+Srsqo33WUAhr5dWs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-TcznSHApOdyNBOxkcphdig-1; Tue, 10 Mar 2020 08:22:38 -0400
X-MC-Unique: TcznSHApOdyNBOxkcphdig-1
Received: by mail-wm1-f72.google.com with SMTP id e26so327991wmk.8
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2020 05:22:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=HUqaOQyD8111sqhLYIu3c8eoonnzyP/fK860jh3cL6c=;
        b=GoXiQQvsZZuyTGYV4OlGPllKkmH+Vioee5T4pBX3cK5iNmWKu7yVcGuWDNvXPxQd0Y
         ddAg4zqmnv+KlVfgpRcrTezYflu6HlfNKZwZbw1URQ4BfpPYFMvuStXzJAq6PSnGDsMF
         ZoVRPNGhUbr4kTrhQO1262H8hkTPD+mS2eRmTTC3hCsIZ3+q6Eb3qLArDD9v6iddhrHS
         0ZMqqdpBby/jdk9IzSPSk8x/Ezvr6oU2i2LOGb7UhXPIRB8wa7WiUcU/sDCqk/m7JWkU
         KpFEbl4e5YTUD3fycblTIWu5j1Qd26fgvnmOLYVQ61UaKIRYIIKc4cArJ/feZcZCtiYJ
         KsOg==
X-Gm-Message-State: ANhLgQ0/wpmH7cZzTraESSiO/Gk5zQyB/WveIVqXU2Whickcz9PLxuDe
        I060EKTFRxeGDA8Qre1YXKLsZfLiVQa3N9AStxurb1BW/gbQrpDwb1MuXtxmD4pnNKs877RjVUf
        ++veP79RkjwI+
X-Received: by 2002:a5d:498a:: with SMTP id r10mr10682362wrq.278.1583842956396;
        Tue, 10 Mar 2020 05:22:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsg/VdLmQ4q9p8wwcZWAaHayMPNd/mPl7prf66OYmQX/nTuUFxqyoxMN+qlt4+MP0mLt0jX3Q==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr10682350wrq.278.1583842956163;
        Tue, 10 Mar 2020 05:22:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id f9sm14526225wrc.71.2020.03.10.05.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 05:22:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id AEDA318033D; Tue, 10 Mar 2020 13:22:34 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <20200309115043.17b2d6ef@kicinski-fedora-PC1C0HJN>
References: <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp> <20200304114000.56888dac@kicinski-fedora-PC1C0HJN> <20200304204506.wli3enu5w25b35h7@ast-mbp> <20200304132439.6abadbe3@kicinski-fedora-PC1C0HJN> <20200305010706.dk7zedpyj5pb5jcv@ast-mbp> <20200305001620.204c292e@cakuba.hsd1.ca.comcast.net> <87tv332hak.fsf@toke.dk> <20200305101342.01427a2a@kicinski-fedora-PC1C0HJN> <87d09l21t1.fsf@toke.dk> <20200309115043.17b2d6ef@kicinski-fedora-PC1C0HJN>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 10 Mar 2020 13:22:34 +0100
Message-ID: <87eeu0qu0l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Mon, 09 Mar 2020 12:41:14 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> > You said that like the library doesn't arbitrate access and manage
>> > resources.. It does exactly the same work the daemon would do.=20=20
>>=20
>> Sure, the logic is in the library, but the state (which programs are
>> loaded) and synchronisation primitives (atomic replace of attached
>> program) are provided by the kernel.=20
>
> I see your point of view. The state in the kernel which the library has
> to read out every time is what I was thinking of as deserialization.

Ohh, right. I consider the BTF-embedded data as 'configuration data'
which is different to 'state' in my mind. So hence my confusion about
what you were talking about re: state :)

> The library has to take some lock, and then read the state from the
> kernel, and then construct its internal state based on that. I think
> you have some cleverness there to stuff everything in BTF so far, but
> I'd expect if the library grows that may become cumbersome and
> wasteful (it's pinned memory after all).
>
> Parsing the packet once could be an example of something that could be
> managed by the library to avoid wasted cycles. Then programs would have
> to describe their requirements, and library may need to do rewrites of
> the bytecode.

Hmm, I've been trying to make libxdp fairly minimal in scope. It seems
like you are assuming that we'll end up with lots of additional
functionality? Do you have anything in particular in mind, or are you
talking in general terms here?

> I guess everything can be stuffed into BTF, but I'm not 100% sure
> kernel is supposed to be a database either.

I actually started out with the BTF approach because I wanted something
that could be part of the program bytecode (instead of, say, an external
config file that had to be carried along with the .o file). That it
survives a round-trip into the kernel turned out to be a nice bonus :)

I do agree with you in general terms, though: There's probably a limit
to how much stuff we can stick into this. The obvious better-suited
storage mechanism for more data is a BPF map, isn't it? I'm not sure
there's any point in moving to that before we have actual use cases for
richer state/metadata, though?

> Note that the atomic replace may not sufficient for safe operation, as
> reading the state from the kernel is also not atomic.

Yeah, there's a potential for read-update-write races. However, assuming
that the dispatcher program itself is not modified after initial setup
(i.e., we build a new one every time), I think this can be solved with a
"cmpxchg" operation where userspace includes the fd of the program it
thinks it is replacing, and the kernel refuses the operation if this
doesn't match. Do you disagree that this would be sufficient?

-Toke

