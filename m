Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31D821520FD
	for <lists+bpf@lfdr.de>; Tue,  4 Feb 2020 20:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBDT0j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Feb 2020 14:26:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48233 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbgBDT0j (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 4 Feb 2020 14:26:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580844398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cK4kk9KTG8BWaRuBvs8XbBF2ptu8HKpXaRe/RR/WOiY=;
        b=KhDHCx3l5rgoJ3mQ+FVWA5SD2tRcAc+YBDoS+IAF1oLrTyRqTVbYQid0eFZQBvFf1yKmrd
        xDJwUvjbbjO+U0ECNzOiitidtnuKpqA5gaZh9W6cg79LhE0DreRaz9pTHHx4qmllzMkD8R
        2C2hODicraV89zuYhTIBS4bjFMdHBIw=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-d9PiS4aAMd--XzuvSZydMw-1; Tue, 04 Feb 2020 14:26:33 -0500
X-MC-Unique: d9PiS4aAMd--XzuvSZydMw-1
Received: by mail-lj1-f198.google.com with SMTP id y15so5508120ljh.22
        for <bpf@vger.kernel.org>; Tue, 04 Feb 2020 11:26:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=cK4kk9KTG8BWaRuBvs8XbBF2ptu8HKpXaRe/RR/WOiY=;
        b=n0l1D4emlehuOB0CUgdOcUmZppgQqzwCdMyRggy0o3c9v4exf0812QavQ/sQnm7EWy
         +93luOykb8XD4AGWOHVanm5TZvkL8xCcTtsDDXaaYB0uSMPrA8pTkZha2vHj2GTKnjHS
         6VjxmyvJCYSXwBI7pbWw9OLT9/y6Z17XlMsrXUTAiRf1yBNN5WsJxHsZ8cOJEa6c381b
         /eMOI3RmhxH5ufZYkjM6eYELmiZd9eUsxVEGMlI5XlRRw0soCCc25zCaJhybokIdWzCZ
         nr8AnLo8+AM57oVaR/ykFYHB9HW2HnwQmk1TMa8RFN2ukhnsj3JyWZKo4dg8b8YNxYEh
         xjAw==
X-Gm-Message-State: APjAAAXi8evO7PGzrsKrZ2unJLJEfQ+++WAHdXvhoBu7tx75Du6lPzwB
        mM4IaxKL/OcZ8OorAX7JjDCoSwTCyvcFb0/YAXwFWMiXTc3R9eXPpDk970PVqIL7RmNRToud1gr
        k16YBexPj3byF
X-Received: by 2002:a2e:8490:: with SMTP id b16mr18432406ljh.282.1580844392057;
        Tue, 04 Feb 2020 11:26:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqwvfvrqkwYpIaL9OAVxaJzuQfBr7IoIkRwk5o0R2IIVGFCIbsigjFjq5mfDfNs75pDaOUSY8w==
X-Received: by 2002:a2e:8490:: with SMTP id b16mr18432399ljh.282.1580844391819;
        Tue, 04 Feb 2020 11:26:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id v9sm12662518lfe.18.2020.02.04.11.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 11:26:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 50B201802D4; Tue,  4 Feb 2020 20:26:27 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        xdp-newbies@vger.kernel.org,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>
Subject: Re: Need a way to modify the section name for a read program object
In-Reply-To: <f1fa48b7-8096-b4f2-51cc-bcb4c1da0cd4@fb.com>
References: <D0F8E306-ABEE-480E-BDFD-D43E3A98DC5A@redhat.com> <874kw664dy.fsf@toke.dk> <f1fa48b7-8096-b4f2-51cc-bcb4c1da0cd4@fb.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 04 Feb 2020 20:26:27 +0100
Message-ID: <87zhdyduho.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andriin@fb.com> writes:

> On 2/4/20 2:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> "Eelco Chaudron" <echaudro@redhat.com> writes:
>>=20
>>> Hi All,
>>>
>>> I'm trying to write an xdpdump like utility and have some missing part
>>> in libbpf to change the fentry/FUNCTION section name before loading the
>>> trace program.
>>>
>>> In short, I have an eBPF program that has a section name like
>>> "fentry/FUNCTION" where FUNCTION needs to be replaced by the name of the
>>> XDP program loaded in the interfaces its start function.
>>>
>>> The code for loading the ftrace part is something like:
>>>
>>> 	open_opts.attach_prog_fd =3D bpf_prog_get_fd_by_id(info.id);
>>> 	trace_obj =3D bpf_object__open_file("xdpdump_bpf.o", &open_opts);
>>>
>>> 	trace_prog_fentry =3D bpf_object__find_program_by_title(trace_obj,
>>> "fentry/FUNCTION");
>>>
>>> 	/* Here I need to replace the trace_prog_fentry->section_name =3D
>>> "fentry/<INTERFACE PROG NAME> */
>>>
>>> 	bpf_object__load(trace_obj);
>>> 	trace_link_fentry =3D bpf_program__attach_trace(trace_prog_fentry);
>>>
>>>
>>> See the above, I would like to change the section_name but there is no
>>> API to do this, and of course, the struct bpf_program is
>>> implementation-specific.
>>>
>>> Any idea how I would work around this, or what extension to libbpf can
>>> be suggested to support this?
>>=20
>> I think what's missing is a way for the caller to set the attach_btf_id.
>> Currently, libbpf always tries to discover this based on the section
>> name (see libbpf_find_attach_btf_id()). I think the right way to let the
>> caller specify this is not to change the section name, though, but just
>> to expose a way to explicitly set the btf_id (which the caller can then
>> go find on its own).
>
> Yes, I agree, section name should be treated as an immutable identifier=20
> and a (overrideable) hint to libbpf.
>
>>=20
>> Not sure if it would be better with a new open_opt (to mirror
>> attach_prog_fd), or just a setter (bpf_program__set_attach_btf_id()?).
>> Or maybe both? Andrii, WDYT?
>
> open_opts is definitely wrong way to do this, because open_opts apply to=
=20
> all BPF programs, while this should be per-program.

Yes, of course; silly me :)

> I'm also not sure having API that allows to specify BTF type ID is the
> best, probably better to let libbpf perform the search by name. So I'd
> say something like this:
>
> int bpf_program__set_attach_target(int attach_prog_fd, const char=20
> *attach_func_name)
>
> This should handle customizing all the tp_btf/fentry/fexit/freplace BPF=20
> programs we have.

Right, that makes sense; I think that would cover it (apart from your
function signature missing a struct bpf_program argument).

> We might add extra attach_target_ops for future extensibility, if we
> anticipate that we'll need more knobs in the future, I haven't thought
> too much about that.

Good question, me neither. Will see if I can think of anything...

-Toke

