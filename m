Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3587726692E
	for <lists+bpf@lfdr.de>; Fri, 11 Sep 2020 21:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725770AbgIKTvJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Sep 2020 15:51:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51410 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725778AbgIKTvD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Sep 2020 15:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599853862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pZ6qUu/QKaEuieocaK2Spc9px44OIGxBz6Y+cybHbJA=;
        b=KSwkXPqwOpRmVhN1xGAhb2/Ga7kpztzspQcwUIJLGeirLpTvx08nuId5GikBKr8tJNtZCt
        q7YXqDlJL5zVr2a1WYnxCyvdY7pOInO81J5TD0AFCFO/er90tbiBAWwkRe+mxR89zH6t3Q
        dBcnRDXh/WB0c/U61qaU23XP/qePWjU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-YIsAkX0dOLmHcGXXVax5DQ-1; Fri, 11 Sep 2020 15:51:00 -0400
X-MC-Unique: YIsAkX0dOLmHcGXXVax5DQ-1
Received: by mail-wm1-f71.google.com with SMTP id p20so201181wmg.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2020 12:51:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=pZ6qUu/QKaEuieocaK2Spc9px44OIGxBz6Y+cybHbJA=;
        b=ff30PhGyP/9ClYR3+iLD1kNKFTecSugIEAYpJvsyjn7Kuk24fIYbasUF5WDr6Pjqb2
         1RKH7iQ0Zs4fQYItrx3vUchCxMf9bQQU0alD8gXV53/D+fA9m1CX69jNsk5vwq0RXKCy
         mwgoTzdXU0dvZLGvUOac0XU5uW4GvEjAlUiS4+Z1ISTzU+DkQ4SH/b/TRbZ/LoObgPrN
         CcrLVwlPb0Jz+DAjKCkbjEjLvq8ge7MbTsfJgJAXX1Txbx2Zc7pOQHC7wUkzEBARy1s4
         esnj9drI3Kb8Kl0iwuRbQ1SEIqseo4DaFOXTAgvMu2TU8XYJ+WgMVYQbOITCMi8koJkJ
         RPMQ==
X-Gm-Message-State: AOAM530yJNJOwmBSIOCAkv/WahicdjReNQGCMCI8YUFwj8INUjyRUFFK
        Bn8KDHEfwKnGLywH3tPnXC1l4ujojg1FcCj697DHOnF7aOGwyH4VAfoG4ah9mks/SA95PHEudNO
        SQkTIfhy/G0XG
X-Received: by 2002:a1c:2086:: with SMTP id g128mr3795324wmg.89.1599853858564;
        Fri, 11 Sep 2020 12:50:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdOS8jZ0ZCW1gg7iTvWNcvMeg7ihojZKyLCfJHH9OQPMkEgJ4f3ygnZ140KHNQCyu/5vZzXg==
X-Received: by 2002:a1c:2086:: with SMTP id g128mr3795298wmg.89.1599853858154;
        Fri, 11 Sep 2020 12:50:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2sm110781wmf.25.2020.09.11.12.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 12:50:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DB90F1829D4; Fri, 11 Sep 2020 21:50:55 +0200 (CEST)
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
Subject: Re: [PATCH RESEND bpf-next v3 2/9] bpf: verifier: refactor
 check_attach_btf_id()
In-Reply-To: <CAEf4BzYNpOjt=Ua1hg3jAEe07a9mEd1UF2CZPys05O+ReaLo+Q@mail.gmail.com>
References: <159981835466.134722.8652987144251743467.stgit@toke.dk>
 <159981835693.134722.13561339671142530897.stgit@toke.dk>
 <CAEf4BzYNpOjt=Ua1hg3jAEe07a9mEd1UF2CZPys05O+ReaLo+Q@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Sep 2020 21:50:55 +0200
Message-ID: <878sdg9jog.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Fri, Sep 11, 2020 at 3:00 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
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
>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>> ---
>
> I can't tell if there are any functional changes or not, tbh. The
> logic is quite complicated and full of intricate details. I did leave
> some suggestions on hopefully simplifying code flow in some places
> (and ensuring it's harder to break it on future changes), but I hope
> Alexei will give it a very thorough review and check that none of the
> subtle details broke.

Yeah, totally agree this is gnarly... :/
Which is also why I chickened out of doing any further changes in an
attempt to simplify the flow, but rather kept as much as the existing
structure as possible (with somewhat mixed results, I suppose).

Let's see what Alexei thinks. I guess I can take another crack at it, in
which case, thank you for the suggestions for simplifying things!

-Toke

