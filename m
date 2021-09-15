Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9835E40C405
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 12:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhIOK4X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Sep 2021 06:56:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232313AbhIOK4X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Sep 2021 06:56:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631703304;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k6aRK0JmCvGFVEbgpz/kyUiWETl6aFzhRXtN8PVxUb8=;
        b=GO7C4To77CVdLvHWxAvdFMfWSMxSPCPvwrXyEsr73BfzsqaL9XffR6s4VPl+MXE4peLQ1Y
        WAwydLZyjjjsQ9nwY8EYpe/8dGivYclWIbyUsF3iK78d9tfkIAnZGVX5oVaBCw8BmSuWqy
        AiKqop3y31eNQJKHF9q8j6zagBgAvf0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-MGZhEXWPNqi9nzLVz5SAwA-1; Wed, 15 Sep 2021 06:55:03 -0400
X-MC-Unique: MGZhEXWPNqi9nzLVz5SAwA-1
Received: by mail-ej1-f69.google.com with SMTP id bi9-20020a170906a24900b005c74b30ff24so1311800ejb.5
        for <bpf@vger.kernel.org>; Wed, 15 Sep 2021 03:55:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k6aRK0JmCvGFVEbgpz/kyUiWETl6aFzhRXtN8PVxUb8=;
        b=kysq/GE+7fmixQqxHJjpLm+spOLOl81okQdL2VSn38YiajlJx9zMMwjc0xluigk67i
         u+m4C2SjpTCwhAuzp6YAyCg0jiXmWSnjizR25XxFPD0yypWh5nSP3DOS7jA/wA3ovthG
         5M3YstjcmgAVSB+0NQu758h9NU5xXfb6iXxrjrbYxJ1mVAh4mHdlyTSd2XTCHzvIZuED
         0GWTm1vLgeUu6/TSZpOHqkM7lx+qXn+TFLeF6BDP21Jac7sjneefTawoNYHGgAKO1f+J
         A1fkOlqujUPvbmnE/q+TzDnYCEyMlJ1hzUck6jwzASn0bK50NdHSPYn2bimBJZnCu+VT
         CvEg==
X-Gm-Message-State: AOAM533M4pEDgrgFv0Fpn26lCWz5hqh9FfM67elZk5k+TlGeKCgseZQd
        lqrm3ZhiF/M7ahvELzLf3LRIeTTN8jphoJqj3Q6ttUcxCt46RNjfS+6JJdhlqD10KLJspxDzMG/
        ou++PNL4WHjtq
X-Received: by 2002:aa7:cad0:: with SMTP id l16mr17582601edt.16.1631703301958;
        Wed, 15 Sep 2021 03:55:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz4t55aAkeNk6nM18qjvbS2OL7h+fFzS0jLz2fm5kg2tg67M4vRbbrMKMgG904mzqZi6lW0Xg==
X-Received: by 2002:aa7:cad0:: with SMTP id l16mr17582585edt.16.1631703301655;
        Wed, 15 Sep 2021 03:55:01 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id r16sm6963174edt.15.2021.09.15.03.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 03:55:00 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 38B8618033D; Wed, 15 Sep 2021 12:55:00 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andrii Nakryiko <andrii@kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH perf] perf: ignore deprecation warning when using
 libbpf's btf__get_from_id()
In-Reply-To: <CAEf4BzYzCQ4yuNKi3OCNqTXGXJQXt1XXNuhCT5oVF=khx85bXQ@mail.gmail.com>
References: <20210914170004.4185659-1-andrii@kernel.org>
 <YUDoNX0eUndsPCu+@krava>
 <CAEf4BzbU8Ok-7Fsp1uGZ4F6b5GPb58fk1YKgnGwx9+sUBq71tA@mail.gmail.com>
 <YUDxqnJhjnpdl6vv@kernel.org>
 <CAEf4BzYzCQ4yuNKi3OCNqTXGXJQXt1XXNuhCT5oVF=khx85bXQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 15 Sep 2021 12:55:00 +0200
Message-ID: <87y27y5csb.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

> On Tue, Sep 14, 2021 at 12:02 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
>>
>> Em Tue, Sep 14, 2021 at 11:28:28AM -0700, Andrii Nakryiko escreveu:
>> > On Tue, Sep 14, 2021 at 11:21 AM Jiri Olsa <jolsa@redhat.com> wrote:
>> > >
>> > > On Tue, Sep 14, 2021 at 10:00:04AM -0700, Andrii Nakryiko wrote:
>> > > > Perf code re-implements libbpf's btf__load_from_kernel_by_id() API=
 as
>> > > > a weak function, presumably to dynamically link against old versio=
n of
>> > > > libbpf shared library. Unfortunately this causes compilation warni=
ng
>> > > > when perf is compiled against libbpf v0.6+.
>> > > >
>> > > > For now, just ignore deprecation warning, but there might be a bet=
ter
>> > > > solution, depending on perf's needs.
>> > >
>> > > HI,
>> > > the problem we tried to solve is when perf is using symbols
>> > > which are not yet available in released libbpf.. but it all
>> > > linkes in default perf build because it's linked statically
>> > > libbpf.a in the tree
>> > >
>> >
>> > If you are always statically linking libbpf into perf, there is no
>> > need to implement this __weak shim. Libbpf is never going to deprecate
>> > an API if a new/replacement API hasn't been at least in a previous
>> > released version. So in this case btf__load_from_kernel_by_id() was
>> > added in libbpf 0.5, and btf__get_from_id() was marked deprecated in
>> > libbpf 0.6 (not yet released, of course). So with that, do you still
>> > think we need this __weak re-implementation?
>> >
>> > I was wondering if this was done to make latest perf code compile
>> > against some old libbpf source code or dynamically linked against old
>> > libbpf. But if that's not the case, the fix should be a removal of
>> > __weak btf__load_from_kernel_by_id().
>>
>> It was made to build against the libbpf that comes with fedora 34, the
>> distro I'm using, which is:
>>
>> =E2=AC=A2[acme@toolbox perf]$ sudo dnf install libbpf-devel
>> Package libbpf-devel-2:0.4.0-1.fc34.x86_64 is already installed.
>> Dependencies resolved.
>> Nothing to do.
>> Complete!
>> =E2=AC=A2[acme@toolbox perf]$ cat /etc/redhat-release
>> Fedora release 34 (Thirty Four)
>>
>> And we have 'make -C tools/perf build-test' that has one entry to build
>> with LIBBPF_EXTERNAL=3D1, i.e. using whatever libbpf-devel package is
>> installed in the distro, in addtion to statically linking with the
>> libbpf in the kernel sources.
>>
>> That is done because several distros are linking perf with the libbpf
>> they ship.
>>
>> When I merged the latest upstream this test failed, and I realized that
>> some files in tools/perf/ had changed to make use of a new function and
>> that was the reason for the build test failure.
>>
>> So I tried to provide a transition help for these cases, initially as a
>> feature test that would look if that new function was available and if
>> not, provide the fallback, but then ended up following Jiri's suggestion
>> for a __weak function, as that involved less coding.
>>
>
> Ok, that's cool, then my "fix" should be fine for now. Can you please
> land it in perf/core to unblock Stephen's (cc'ed) build failure when
> merging perf and bpf-next trees?
>
> Also it's good to keep in mind that libbpf is now providing
> LIBBPF_MAJOR_VERSION and LIBBPF_MINOR_VERSION macro, so when
> statically linking you should be able to use that to detect libbpf
> version. For shared library cases we should probably also add runtime
> APIs (e.g., int libbpf_major_version(void), int
> libbpf_minor_version(void), const char *libbpf_version(void)) so that
> you can do more detection based on libbpf version at runtime. Let me
> know if it's something that would be helpful.

Yes, please! We're currently using this horror to be able to print the
libbpf version being used by xdp-tools:

https://github.com/xdp-project/xdp-tools/blob/master/lib/util/util.c#L100

Would be awesome to have an API function we could just call instead :)

-Toke

