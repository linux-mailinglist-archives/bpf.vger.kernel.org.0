Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37EB26911B
	for <lists+bpf@lfdr.de>; Mon, 14 Sep 2020 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgINQJx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 12:09:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40815 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726416AbgINQIu (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 14 Sep 2020 12:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600099728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ia4ewCI4oFF+VxRjo3xc7IuSBeMatuSZAzdFNZ3n8es=;
        b=PXuS2RonbcDYfNpe2WcqmHoziN3wJb2QYMxSoO6U7CDcM7vp9VAkdLI56/9+VyZNgKV8xj
        N6bnw2ss08JFnosFdWBFB/3JsDb28Pec+K1RDNW47N4cWXHCQgkO5vJzn/uUK+hxEUvB3Q
        gkuXJSg67kqNdlcDX2iMaCSzlA5v45c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-326-7rkcg_V8NQOBBj4yWfzqtQ-1; Mon, 14 Sep 2020 12:08:46 -0400
X-MC-Unique: 7rkcg_V8NQOBBj4yWfzqtQ-1
Received: by mail-wr1-f71.google.com with SMTP id n15so39840wrv.23
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Ia4ewCI4oFF+VxRjo3xc7IuSBeMatuSZAzdFNZ3n8es=;
        b=LOlNx0kluHg0r37LDynt4uwshxMIPyb6QwJQiF7JtY62v6iABi2g+HU3e5Xuo5kCM5
         fkIal3FP2eBlndVIQyqaPseT2KjZM1mBrlirnymCHImhPSnMCwgYW0troFan3+E1wPWF
         EUORXEGMzO9tRwEHzTujE+4G07t53ZbRRdmbw0goB0WxabQxqPF2dp1941GYxbyk2X0q
         V6iiWdfES7H1ihdgDx5tTujnzplR++iSGSp+JB3WaROEQNtAQIL0tmyUOgfGWtK6/FK8
         bw74kaNN93haEVMm5es+4u5SW1v0ACwnp4r41icp5Io/Q3WuI1U+0rB3FrT4/KcQDXIF
         MA8w==
X-Gm-Message-State: AOAM531lWcjkoSK3oKlTx44famnN5651olr5KXYvJ7hREzP7FuSDLw2h
        0qCNGtRAr3FrrjNFShHZAIxdxUG6WWLTEtSK4ud11/9DVkYoXnXYLI1BqSO6H8tCf4HEB4ft71K
        8Aw5XTKXAjkpb
X-Received: by 2002:adf:ec86:: with SMTP id z6mr17050111wrn.109.1600099725017;
        Mon, 14 Sep 2020 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx59XZFvjJGkQOQQ/Xp1rTDTlbN5frlh+8ObEF+trFc4NjRO84bjSN9y0ME8NW/KtApm95dng==
X-Received: by 2002:adf:ec86:: with SMTP id z6mr17050088wrn.109.1600099724708;
        Mon, 14 Sep 2020 09:08:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t188sm21796643wmf.41.2020.09.14.09.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 09:08:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 871DC1829CB; Mon, 14 Sep 2020 18:08:43 +0200 (CEST)
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
Subject: Re: [PATCH RESEND bpf-next v3 4/9] bpf: support attaching freplace
 programs to multiple attach points
In-Reply-To: <CAEf4BzZMj0sPisgUZ+3qKvqaAxfzzRNHZTpoR-zuDXvKcY3URQ@mail.gmail.com>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
 <159981835908.134722.4550898174324943652.stgit@toke.dk>
 <CAEf4BzZMj0sPisgUZ+3qKvqaAxfzzRNHZTpoR-zuDXvKcY3URQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 14 Sep 2020 18:08:43 +0200
Message-ID: <87imcgz6gk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 11, 2020 at 3:01 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> From: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>
>> This enables support for attaching freplace programs to multiple attach
>> points. It does this by amending UAPI for bpf_raw_tracepoint_open with a
>> target prog fd and btf ID pair that can be used to supply the new
>> attachment point. The target must be compatible with the target that was
>> supplied at program load time.
>>
>> The implementation reuses the checks that were factored out of
>> check_attach_btf_id() to ensure compatibility between the BTF types of t=
he
>> old and new attachment. If these match, a new bpf_tracing_link will be
>> created for the new attach target, allowing multiple attachments to
>> co-exist simultaneously.
>>
>> The code could theoretically support multiple-attach of other types of
>> tracing programs as well, but since I don't have a use case for any of
>> those, the bpf_tracing_prog_attach() function will reject new targets for
>> anything other than PROG_TYPE_EXT programs.
>>
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> It feels like using a semi-constructed bpf_tracing_link inside
> prog->aux->tgt_link is just an unnecessary complication, after reading
> this and previous patches. Seems more straightforward and simpler to
> store tgt_attach_type/tgt_prog_type (permanently) and
> tgt_prog/tgt_trampoline (until first attachment) in prog->aux and then
> properly create bpf_link on attach.

I updated v4 with your comments, but kept the link in prog->aux; the
reason being that having a container for the two pointers makes it
possible to atomically swap it out with xchg() as you suggested
previously. Could you please take a look at v4? If you still think it's
better to just keep two separate pointers (and add a lock) in prog->aux,
I can change it to that. But I'd rather avoid the lock if possible...

-Toke

