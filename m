Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E09F813B443
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 22:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgANV1F (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 16:27:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31852 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728757AbgANV1E (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jan 2020 16:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579037223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WQzb35NsyS3GXmNQNK71Fh1Dt7Fa9cHgnvIOIY+3fZw=;
        b=Eww5+yF5gcVlrdgxG+/4eSss99fWkjolcfSnlJwIsLJpmdlhoIRp/bLtMHNqFyNAUfncVJ
        sa2rOgl5edbRkdxFWrvCRgSoZEDRAcCYaIN7P6QGzcKBTneNAiiquNsDRd4f0R8Y7ItgCH
        lltkQZkAbzodfca/0hY8c9nJrqbFnPU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Csdv-mZnNgyAMEruph3M3g-1; Tue, 14 Jan 2020 16:27:01 -0500
X-MC-Unique: Csdv-mZnNgyAMEruph3M3g-1
Received: by mail-lj1-f199.google.com with SMTP id k25so3392451lji.4
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 13:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WQzb35NsyS3GXmNQNK71Fh1Dt7Fa9cHgnvIOIY+3fZw=;
        b=gHC3APSZcoc6qNuHFQWsubiX7QotFQ/jxYxRkdP3heGmKaJL5dgnht/ETPlIDl+oyj
         s1TLyxQTH/8kHVNffC2bGr6puhIx4CAvcjZ4GxUHtmcUDZQx/DtATuD8w1Cp0Bs0B/3+
         1Tckcpx1rfOS/9vcb39nc2FsChAz2lQDXrNa0iBtI1aMmRhlJuGu9oAxxvWIl29b+jLY
         56I5bojRh8ajNj8Vcefb4FFeF4H7bJVxmtC326Geebq0DBwVr+nOyH1z+6CDW+MWxhm/
         N30EE4fMqFEmVh5jHB7DwDyzNw1Lu2EdmCFou6s8tXh0GLw6kYL8ZiJKDjrJXpgXzGfS
         DXlg==
X-Gm-Message-State: APjAAAVQbPw+GdjdzALxSLdNKbe3nShZKiooiNBU9EfmH8NzwbHCPuJl
        3pUl6i1e78WcFvGCirwN4/MbZCtxsLSApLSdbrAOqaBstcKQ6F4XcV0DSm8DzLzd08/zJ6NdqUo
        dAWtflkZG7xzX
X-Received: by 2002:ac2:5549:: with SMTP id l9mr2933765lfk.53.1579037219936;
        Tue, 14 Jan 2020 13:26:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqwJQ06h3KjQea7X/023FVmNesshffHEIjTOOVdi11XNOFCXDqaSwEwqZDPU2Cwko7wgR2kNOQ==
X-Received: by 2002:ac2:5549:: with SMTP id l9mr2933755lfk.53.1579037219747;
        Tue, 14 Jan 2020 13:26:59 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d24sm7871439lfb.94.2020.01.14.13.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 13:26:59 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 332E21804D6; Tue, 14 Jan 2020 22:26:57 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: Fix include of bpf_helpers.h when libbpf is installed on system
In-Reply-To: <CAEf4Bzaqi6Wt4oPyd=ygTwBNzczAaF-7boKB025-6H=DDtsuqQ@mail.gmail.com>
References: <20200114164250.922192-1-toke@redhat.com> <CAEf4Bzb9sTF4BWA1wyWM-3jsMUnbwYi1XtkDj8ZXdyHk7C4_mQ@mail.gmail.com> <CAEf4Bzaqi6Wt4oPyd=ygTwBNzczAaF-7boKB025-6H=DDtsuqQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 14 Jan 2020 22:26:57 +0100
Message-ID: <87sgkhvie6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Jan 14, 2020 at 11:07 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Tue, Jan 14, 2020 at 8:43 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@r=
edhat.com> wrote:
>> >
>> > The change to use angled includes for bpf_helper_defs.h breaks compila=
tion
>> > against libbpf when it is installed in the include path, since the fil=
e is
>> > installed in the bpf/ subdirectory of $INCLUDE_PATH. Fix this by addin=
g the
>> > bpf/ prefix to the #include directive.
>> >
>> > Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are take=
n from selftests dir")
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> > ---
>> > Not actually sure this fix works for all the cases you originally trie=
d to
>>
>> This does break selftests/bpf. Have you tried building selftests, does
>> it work for you? We need to fix selftests simultaneously with this
>> change.
>>
>> > fix with the referred commit; please check. Also, could we please stop=
 breaking
>> > libbpf builds? :)
>>
>> Which libbpf build is failing right now? Both github and in-kernel
>> libbpf builds are fine. You must be referring to something else. What
>> exactly?
>
> I think it's better to just ensure that when compiling BPF programs,
> they have -I/usr/include/bpf specified, so that all BPF-side headers
> can be simply included as #include <bpf_helpers.h>, #include
> <bpf_tracing.h>, etc

And break all programs that don't have that already? Just to make the
kernel build env slightly more convenient? Hardly friendly to the
library users, is it? :)

As far as selftests are concerned, I finally managed to get an LLVM
version that will build them all; so I'll test that tomorrow and send a
v2 that doesn't break them...

-Toke

