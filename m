Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9733527408C
	for <lists+bpf@lfdr.de>; Tue, 22 Sep 2020 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgIVLQR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Sep 2020 07:16:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54854 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726506AbgIVLQQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Sep 2020 07:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600773374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dtujSmMB6nTw7h5UTnW9OabKvVTDf3TP6d+sgwQFf7Q=;
        b=AJf2cQ5VML3nlrNpnu5yS8O6rNbrUP/Ex/24G1d9+63NKnwz7MO4Fh6XzcCpyJlkNVqRcm
        nQH2jiiSE38+He3RthMWhLPbzTTDVvTcSjjsA6sreSlQCdjo0ExJ76OI599MGCPEe6qd9Z
        Xi8zR3adEJ+YCCgAA6NcOjmHI/s/KQk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-xPkpQbtoP1uEw8xqPTbhZA-1; Tue, 22 Sep 2020 07:16:13 -0400
X-MC-Unique: xPkpQbtoP1uEw8xqPTbhZA-1
Received: by mail-wm1-f72.google.com with SMTP id a7so784118wmc.2
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2020 04:16:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=dtujSmMB6nTw7h5UTnW9OabKvVTDf3TP6d+sgwQFf7Q=;
        b=NMEhXgUVqgkENrVNYYFxVpbcbyr2LUJOMr+lgJp8mTFygb+4qjVpnuUoGbGc9klygA
         xyk6FnKJN1icd0kLKrmhKzmIYZE3Q/JHxEIt5EIn/5n6CYy4vnieIdhPQm9Xq2OuZNPw
         h2mRvjqNUW5+Yjc00Ey/avGNb1keELYQz2qfB373ZHIxlfIMS0N4/X40Zwi3lctgzVMY
         34iRfC/CdZX8eJyKdWsOAZwKQXVhy7YpU/+oK9/qijkT+GWNUrjcYVxmBSuu0ZMfh/ls
         Eoiks0meX9xpxJMbU+IN93PVHvM/TJXjLMcSEYhe5+EkR9QUyWkIHmQ5Lm3zXwc9d5A8
         Z0QA==
X-Gm-Message-State: AOAM5315W9bUNuwd8dapHB5k6RP/LyJPlIOd/mYpVPfneY+oxL+uwp5j
        HlRD1JwSzyytQVV2p+jk+rw89fuRuGpixmSB0ejX8+UZ61nHtGH3DojaI02cHzkP8WEi+iF8TmM
        l47I+YtF8qmoJ
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr4910906wrx.67.1600773371606;
        Tue, 22 Sep 2020 04:16:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDLh49J2igFsBPt8GTl/dJj7UTzsBsHQ8nK/1AvF2774elWuJah9Mr401GPU/xFxj8r77Cug==
X-Received: by 2002:a05:6000:118a:: with SMTP id g10mr4910864wrx.67.1600773371307;
        Tue, 22 Sep 2020 04:16:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d5sm27935960wrb.28.2020.09.22.04.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 04:16:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 36273183A99; Tue, 22 Sep 2020 13:16:10 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        KP Singh <kpsingh@chromium.org>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v7 03/10] bpf: verifier: refactor
 check_attach_btf_id()
In-Reply-To: <CAEf4BzY4UR+KjZ3bY6ykyW5CPNwAzwgKVhYHGdgDuMT2nntmTg@mail.gmail.com>
References: <160051618267.58048.2336966160671014012.stgit@toke.dk>
 <160051618622.58048.13304507277053169557.stgit@toke.dk>
 <CAEf4BzY4UR+KjZ3bY6ykyW5CPNwAzwgKVhYHGdgDuMT2nntmTg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 22 Sep 2020 13:16:10 +0200
Message-ID: <87a6xioydh.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Sat, Sep 19, 2020 at 4:50 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> The check_attach_btf_id() function really does three things:
>>
>> 1. It performs a bunch of checks on the program to ensure that the
>>    attachment is valid.
>>
>> 2. It stores a bunch of state about the attachment being requested in
>>    the verifier environment and struct bpf_prog objects.
>>
>> 3. It allocates a trampoline for the attachment.
>>
>> This patch splits out (1.) and (3.) into separate functions in preparati=
on
>> for reusing them when the actual attachment is happening (in the
>> raw_tracepoint_open syscall operation), which will allow tracing programs
>> to have multiple (compatible) attachments.
>>
>> No functional change is intended with this patch.
>>
>> Acked-by: Andrii Nakryiko <andriin@fb.com>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> Ok, so bad news: you broke another selftest (test_overhead). Please,
> do run test_progs and make sure everything succeeds, every time before
> you post a new version.

Right, so I looked into this, and it seems the only reason it was
succeeding before were those skipped checks you pointed out that are now
fixed. I.e., __set_task_comm() is not actually supposed to be
fmod_ret'able according to check_attach_modify_return(). So I'm not sure
what the right way to fix this is?

The fmod_ret bit was added to test_overhead by:

4eaf0b5c5e04 ("selftest/bpf: Fmod_ret prog and implement test_overhead as p=
art of bench")

so the obvious thing is to just do a (partial) revert of that? WDYT?

-Toke

