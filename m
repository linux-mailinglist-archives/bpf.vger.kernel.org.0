Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE27A67ECBE
	for <lists+bpf@lfdr.de>; Fri, 27 Jan 2023 18:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjA0Rv3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Jan 2023 12:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjA0Rv3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 27 Jan 2023 12:51:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B854532E51
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674841843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RarnUZmgGrdj5Ch7o10+iw6It6xaO5Haieq0TeSQgqE=;
        b=KPgZqNok4OqjYXb4mkBE637zpoFhlDzjKpB/yMY/j6JxD7azMDTWourPp8gXh7Itefzzvq
        sq1H4Fg2D+JnzbKE7V1eLRDXLWp9ch4ehm0EKF8F+pfvgDNO4PPxNbLI23wUuZ7GwrO7lW
        ROPAQkTOPnwDcOCSfh0+jwUKlqdu4o0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-206-G6yyOLRVNJq3ayjVj2WdNg-1; Fri, 27 Jan 2023 12:50:42 -0500
X-MC-Unique: G6yyOLRVNJq3ayjVj2WdNg-1
Received: by mail-ej1-f70.google.com with SMTP id nd38-20020a17090762a600b00871ff52c6b5so3861834ejc.0
        for <bpf@vger.kernel.org>; Fri, 27 Jan 2023 09:50:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RarnUZmgGrdj5Ch7o10+iw6It6xaO5Haieq0TeSQgqE=;
        b=JpQvzVJs1R7vRK1ilojE+Yd53zGjCf8ZQx0K/l79NcpkCm1Q//CLp9uktHxT9Bin28
         Fs8L/r9sptSWKWsDtFblAJzQl6j6/a2LV+wdmU0MYLiDKLTGUkQMvXgqm8iVy+vxsuvP
         PdUEtJznlYUjMNOZwL/ZeNpEHbT9bKGO20dJtZa5YeyrLzfoHJUWOvCCNFsposWIdCCX
         svi2QTm0m7zRC7/7renfCLnsYREdZnoUhFxzhxND+2gOKs2pm72g8R8Q+wqp6vGxsQxf
         PMlH+4U9oYN1g5Cwj+6QBKli1tgo/wqz7eGjZS+z6WneiNCzHKrQPoTZasfwKgZVZPq2
         fL8g==
X-Gm-Message-State: AO0yUKVqU5YepVepU4dGpAJ87Ytv+8FUgmOgnuQt3D6L9qOVnrOaZVmT
        mxwB0x1RdtCeo0HTrKi/xwsCkHeOUwqzFd+KhhXOn7aQAFzPXaUHXhi70ng/xatawuhQDUNi1y1
        REZ1dYCTyfFa1
X-Received: by 2002:a05:6402:298c:b0:49f:a3d7:b84d with SMTP id eq12-20020a056402298c00b0049fa3d7b84dmr17235663edb.34.1674841841064;
        Fri, 27 Jan 2023 09:50:41 -0800 (PST)
X-Google-Smtp-Source: AK7set+YR53FUX+QaLNJOzJIdDZa1s3qs56XXyNtZ6sesDxF7jVw1etyocD/q28nbyy6YR8LgbRMXA==
X-Received: by 2002:a05:6402:298c:b0:49f:a3d7:b84d with SMTP id eq12-20020a056402298c00b0049fa3d7b84dmr17235605edb.34.1674841840395;
        Fri, 27 Jan 2023 09:50:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7c6d4000000b004704658abebsm2662652eds.54.2023.01.27.09.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 09:50:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0102F9432A0; Fri, 27 Jan 2023 18:50:38 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        David Vernet <void@manifault.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [RFC PATCH v2] Documentation/bpf: Add a description of "stable
 kfuncs"
In-Reply-To: <CAADnVQ+q3uq6ex7NHZmP=x9rfsLCydE=97=V=cBcbO8yS0eySg@mail.gmail.com>
References: <20230117212731.442859-1-toke@redhat.com>
 <CAKH8qBuvBomTXqNB+a6n_PbJKSNFazrAxEWsVT-=4XfztuJ7dw@mail.gmail.com>
 <87v8l4byyb.fsf@toke.dk>
 <CAKH8qBs=nEhhy2Qu7CpyAHx6gOaWR25tRF7aopti5-TSuw66HQ@mail.gmail.com>
 <CAADnVQKy1QzM+wg1BxfYA30QsTaM4M5RRCi+VHN6A7ah2BeZZw@mail.gmail.com>
 <CAKH8qBvZgoOe24MMY+Jn-6guJzGVuJS9zW4v6H+fhgcp7X_9jQ@mail.gmail.com>
 <3500bace-de87-0335-3fe3-6a5c0b4ce6ad@iogearbox.net>
 <20230119043247.tktxsztjcr3ckbby@MacBook-Pro-6.local>
 <875ycvo1im.fsf@toke.dk>
 <CAADnVQ+q3uq6ex7NHZmP=x9rfsLCydE=97=V=cBcbO8yS0eySg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 27 Jan 2023 18:50:38 +0100
Message-ID: <877cx7lvdd.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jan 24, 2023 at 5:18 PM Toke H=C3=B8iland-J=C3=B8rgensen <toke@re=
dhat.com> wrote:
>>
>> Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:
>>
>> > The bpf developers adding new kfunc should assume that it's stable and=
 proceed
>> > to use it in bpf progs and production applications.
>>
>> "Assume all kfuncs are stable" is fine by me, but that is emphatically
>> not what we have been saying thus far, quite the opposite...
>>
>> > The bpf maintainers will keep this stability promise. They obviously w=
ill not
>> > reap it out of the kernel on the whim, but they will nuke it if this k=
func
>> > will be in the way of the kernel innovation.
>>
>> ...and it is contradicted by this last bit. I mean "it's stable, but
>> we'll remove it if it's in the way" is not, well, stable.
>
> Schrodinger's kfuncs :)

Heh, yeah. There's a reason it's called Schrodinger's *uncertainty*
principle, though. Documenting it is about removing some of that
uncertainty so users of can actually know what to expect.

Otherwise, there is a subset of potential users who will shy away from
using kfuncs because it's perceived as "totally unstable, may change at
any time". Which is a shame, because there are many such users who could
benefit from using BPF.

So in other words, even if we don't commit to a stability promise I
think it's worth documenting expectations as precisely as we can.

[...]

>> > Back to deprecation...
>> > I think KF_DEPRECATED is a good idea.
>> > When kfunc will be auto emitted into vmlinux.h (or whatever other file)
>> > or shipped in libbpf header we can emit
>> > __attribute__((deprecated("reason", "replacement")));
>> > to that header file (so it's seen during bpf prog build) and
>> > start dmesg warn on them in the verifier.
>> > Kernel splats do get noticed. The users would have to act quickly.
>>
>> So how about documenting that bit? Something like:
>>
>> "We promise that kfuncs will not be removed without going through a
>> deprecation phase. The length of the deprecation will be proportional to
>> how long that kfunc has existed in the kernel, but will be no shorter
>> than XX kernel releases." ?
>
> That's not something we can promise.
> Take conntrack kfuncs. If netfilter folks decide to sunset
> conntrack tomorrow we won't be standing in their way.

Well, we could do one of two things:

- Make a promise to commit to the deprecation procedure and tell
  subsystems not to add kfuncs unless they are OK with that (getting
  suitable ACKs for the existing users first, of course)

or

- Document that core-BPF kfuncs won't go away without a deprecation
  procedure, and have each subsystem using them document their own
  policies.

I believe the latter is more in line what you and others have set as an
expectation when discussing this previously?

> On the other side the dynptr kfuncs are going to stay as-is for
> foreseeable future because they don't rely on other kernel
> subsystems to do the job.
> Both cases may still change if users themselves
> (after using it in prod) come back with reasons to change it.
>
> In the past the kernel devs were dictating the helper uapi to
> users and users had no option, but to shut up and use what's available.
> Now they will be able to use new apis and request changes.
> At that point it will be a set of users X vs a set of users Y.
> If ten users say that this kfunc sucks while one user
> wants to keep it as-is we will introduce another kfunc and
> will start deprecating the one that lost the vote.

"Lost the vote"? This seems like a can of worms (who can vote? how are
we counting them? etc). I think what you really mean here is something
like "maintainers will take into consideration the opinions of users of
the API and make a call as to whether the benefits of changing a kfunc
outweighs the costs"?

> The deprecation time window will depend on case by case
> considering maintenance cost, etc.

Right, that's not too far from what I proposed above. I still think it
would be useful to commit to a minimum number of releases, though.
Again, to set expectations.

-Toke

