Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3315920C
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2020 15:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgBKOhm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Feb 2020 09:37:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55034 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728508AbgBKOhm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Feb 2020 09:37:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581431861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f4p0T/nCSg8h1suF8dXHDOiEnRfyScsYDIYDBFuw/ss=;
        b=iq3nOO493C4+n/a9jqDumJ3tDPrug+89BEpEru1zX0E6s3aUSksKbA1KnqSb58iR5Oj3a/
        NdxtFUwDALFpsjF/yTE12T576z85ypdfOuzbdB8uSL6RqNRZE2N4SK2aWJKM5r9IOlczgQ
        b7ZdVpzBHBUSxfJrppz2lf14+BuvuWk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-_PJd-dntMx2zLlfUrJG3EQ-1; Tue, 11 Feb 2020 09:37:25 -0500
X-MC-Unique: _PJd-dntMx2zLlfUrJG3EQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E593C19057A1;
        Tue, 11 Feb 2020 14:37:23 +0000 (UTC)
Received: from [10.36.116.104] (ovpn-116-104.ams2.redhat.com [10.36.116.104])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F23210001AE;
        Tue, 11 Feb 2020 14:37:20 +0000 (UTC)
From:   "Eelco Chaudron" <echaudro@redhat.com>
To:     "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
        "Toke =?utf-8?b?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=" <toke@redhat.com>
Cc:     "Andrii Nakryiko" <andriin@fb.com>,
        Xdp <xdp-newbies@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: Need a way to modify the section name for a read program object
Date:   Tue, 11 Feb 2020 15:37:18 +0100
Message-ID: <0D7B2C92-FC75-4167-A973-EB0AD84FC878@redhat.com>
In-Reply-To: <CAEf4BzbWwseeKnGJCPj_VLLcQ-wkbhXWKAPsjQuy4LNDq8fvBg@mail.gmail.com>
References: <D0F8E306-ABEE-480E-BDFD-D43E3A98DC5A@redhat.com>
 <874kw664dy.fsf@toke.dk> <f1fa48b7-8096-b4f2-51cc-bcb4c1da0cd4@fb.com>
 <87zhdyduho.fsf@toke.dk>
 <CAEf4BzbWwseeKnGJCPj_VLLcQ-wkbhXWKAPsjQuy4LNDq8fvBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4 Feb 2020, at 20:32, Andrii Nakryiko wrote:

> On Tue, Feb 4, 2020 at 11:27 AM Toke H=C3=B8iland-J=C3=B8rgensen=20
> <toke@redhat.com> wrote:
>>
>> Andrii Nakryiko <andriin@fb.com> writes:
>>
>>> On 2/4/20 2:19 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> "Eelco Chaudron" <echaudro@redhat.com> writes:
>>>>
>>>>> Hi All,
>>>>>
>>>>> I'm trying to write an xdpdump like utility and have some missing=20
>>>>> part
>>>>> in libbpf to change the fentry/FUNCTION section name before=20
>>>>> loading the
>>>>> trace program.
>>>>>
>>>>> In short, I have an eBPF program that has a section name like
>>>>> "fentry/FUNCTION" where FUNCTION needs to be replaced by the name=20
>>>>> of the
>>>>> XDP program loaded in the interfaces its start function.
>>>>>
>>>>> The code for loading the ftrace part is something like:
>>>>>
>>>>>     open_opts.attach_prog_fd =3D bpf_prog_get_fd_by_id(info.id);
>>>>>     trace_obj =3D bpf_object__open_file("xdpdump_bpf.o",=20
>>>>> &open_opts);
>>>>>
>>>>>     trace_prog_fentry =3D=20
>>>>> bpf_object__find_program_by_title(trace_obj,
>>>>> "fentry/FUNCTION");
>>>>>
>>>>>     /* Here I need to replace the trace_prog_fentry->section_name=20
>>>>> =3D
>>>>> "fentry/<INTERFACE PROG NAME> */
>>>>>
>>>>>     bpf_object__load(trace_obj);
>>>>>     trace_link_fentry =3D=20
>>>>> bpf_program__attach_trace(trace_prog_fentry);
>>>>>
>>>>>
>>>>> See the above, I would like to change the section_name but there=20
>>>>> is no
>>>>> API to do this, and of course, the struct bpf_program is
>>>>> implementation-specific.
>>>>>
>>>>> Any idea how I would work around this, or what extension to libbpf=20
>>>>> can
>>>>> be suggested to support this?
>>>>
>>>> I think what's missing is a way for the caller to set the=20
>>>> attach_btf_id.
>>>> Currently, libbpf always tries to discover this based on the=20
>>>> section
>>>> name (see libbpf_find_attach_btf_id()). I think the right way to=20
>>>> let the
>>>> caller specify this is not to change the section name, though, but=20
>>>> just
>>>> to expose a way to explicitly set the btf_id (which the caller can=20
>>>> then
>>>> go find on its own).
>>>
>>> Yes, I agree, section name should be treated as an immutable=20
>>> identifier
>>> and a (overrideable) hint to libbpf.
>>>
>>>>
>>>> Not sure if it would be better with a new open_opt (to mirror
>>>> attach_prog_fd), or just a setter=20
>>>> (bpf_program__set_attach_btf_id()?).
>>>> Or maybe both? Andrii, WDYT?
>>>
>>> open_opts is definitely wrong way to do this, because open_opts=20
>>> apply to
>>> all BPF programs, while this should be per-program.
>>
>> Yes, of course; silly me :)
>>
>>> I'm also not sure having API that allows to specify BTF type ID is=20
>>> the
>>> best, probably better to let libbpf perform the search by name. So=20
>>> I'd
>>> say something like this:
>>>
>>> int bpf_program__set_attach_target(int attach_prog_fd, const char
>>> *attach_func_name)
>>>
>>> This should handle customizing all the tp_btf/fentry/fexit/freplace=20
>>> BPF
>>> programs we have.
>>
>> Right, that makes sense; I think that would cover it (apart from your
>> function signature missing a struct bpf_program argument).
>
> great! and, ha-ha, too object-oriented thinking ;)

Thanks for your feedback, assuming you are not working on it, I=E2=80=99l=
l=20
implement/test it and sent out a patch.

//Eelco

