Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6829C6E9781
	for <lists+bpf@lfdr.de>; Thu, 20 Apr 2023 16:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjDTOrH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 20 Apr 2023 10:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjDTOrG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 20 Apr 2023 10:47:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1724F420C
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682001981;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UuarXWhrCLw27r1idqrDlI5FLRv5+VGgQS+BQN+kySE=;
        b=bICqiBEwYCMI15DXiqVcEVjRTbPEF3gptU6SLJQG23pwv2V0HzBZThGBy1iw/FMncyR5pl
        HuEvB65+Ndlsj5GD8VKmurN7Eu62w1DHizplJ+YFdaW57ByiTIl8M+XK1/60J3pBspRBC4
        bTU7D2X/jPil+KRpeACF8z2sus7o2hE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-V90lZNE5MLavb0XVCe0lkQ-1; Thu, 20 Apr 2023 10:46:19 -0400
X-MC-Unique: V90lZNE5MLavb0XVCe0lkQ-1
Received: by mail-ed1-f70.google.com with SMTP id u19-20020a50a413000000b0050670a8cb7dso1680019edb.13
        for <bpf@vger.kernel.org>; Thu, 20 Apr 2023 07:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682001978; x=1684593978;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UuarXWhrCLw27r1idqrDlI5FLRv5+VGgQS+BQN+kySE=;
        b=RIxBlAi9EINP3sKjydSZxkfTcDJw7Q6sKKdRpugc8V643a201oF2NoiuGLJ/DmbebS
         VZcJVeDIv5Rtmk160luRaBCJ/Ffvpk92CQgoN9KNFlkI5DXCmIyOEq0bTgcFvXMd8xdA
         7xVHKy9gSGIh0oJmj493eXevZNW/mO18vrL851cbI3aczPB6ycZeI0ZjvEM5tQzYqcin
         VwWWel51xg1Mwd8SGUA+iF+KkIeumkOkKJUiBatoHkGLDDz7WhWDKZSZbphglbXSU7uJ
         6vaHfKcJw26W65SpoFRUDXwzo2W9t/lXophuYG19xNHfU8u9EM8kRms4UVSOoKrZUCk5
         LWLg==
X-Gm-Message-State: AAQBX9dSn2K5yZLuD7RcjItckH5DQWnNhgmI/8lvLeRLBCBoJetBk2dw
        Gfi8SJIPxqLzcn8hTDXZLWrhuUknAMzvc+2u+hrMHQ+AfOpkmODnTUvMfqXQB+kN9gB0mThgD7v
        3HYfBIY+ObvzR
X-Received: by 2002:a17:906:111b:b0:94f:3b29:e0a5 with SMTP id h27-20020a170906111b00b0094f3b29e0a5mr1943155eja.20.1682001977143;
        Thu, 20 Apr 2023 07:46:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVKyRQEQS1oQMnyp1eKSRd3tU543f3P9723XA6YozXKkR6Y2hnYcF7OayZptFCnUqdPKZ6IQ==
X-Received: by 2002:a17:906:111b:b0:94f:3b29:e0a5 with SMTP id h27-20020a170906111b00b0094f3b29e0a5mr1943092eja.20.1682001976345;
        Thu, 20 Apr 2023 07:46:16 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d20-20020a05640208d400b00504ecc4fa96sm815127edz.95.2023.04.20.07.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 07:46:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 23388AA8E17; Thu, 20 Apr 2023 16:46:15 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Shung-Hsi Yu <shung-hsi.yu@suse.com>,
        Quentin Monnet <quentin@isovalent.com>, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Tony Jones <tonyj@suse.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        David Miller <davem@davemloft.net>,
        Mahe Tardy <mahe.tardy@gmail.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Subject: Re: Packaging bpftool and libbpf: GitHub or kernel?
In-Reply-To: <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
References: <ZDfKBPXDQxH8HeX9@syu-laptop>
 <CACdoK4L5A-qdUyQwVbe-KE+0NBPbgqYC1v0uf0i1U_S7KSnmuw@mail.gmail.com>
 <20230414095007.GF63923@kunlun.suse.cz>
 <b933fad3-7759-00d4-94cb-f20dd363b794@isovalent.com>
 <20230414161520.GJ63923@kunlun.suse.cz>
 <CAEf4Bzaw6DBHn=S9zKCXTSh7jW8xL9K6bzi1Q-e8j93thi2hmg@mail.gmail.com>
 <20230418112454.GA15906@kitsune.suse.cz>
 <CAEf4BzZf50fX7T9k47u+9YQrMbSLxLeA1qWwrdWToCZkMhynjg@mail.gmail.com>
 <20230418174132.GE15906@kitsune.suse.cz> <ZD/3Ll7UPucyOYkk@syu-laptop.lan>
 <CAEf4BzZfGewUgYsNNqCgES5Y5-pqbSRDbhtKiuSC7=G_83tyig@mail.gmail.com>
 <87zg73tvm1.fsf@toke.dk>
 <CAEf4BzY9Hr2M7dZXaTZCP4SRat+KpN42c89LG1Msn4PB+1O1YA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 20 Apr 2023 16:46:15 +0200
Message-ID: <878remtxvs.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko <andrii.nakryiko@gmail.com> writes:

>> >> > > > > By switching up actual libbpf used to compile with bpftool, you are
>> >> > > > > potentially introducing subtle problems that your users will be quite
>> >> > > > > unhappy about, if they run into them. Let's work together to make it
>> >> > > > > easier for you to package bpftool properly. We can't switch bpftool to
>> >> > > > > reliably use system-wide libbpf (either static or shared, doesn't
>> >> > > > > matter) because of dependency on internal functionality.
>> >> > > > >
>> >> > > > >
>> >> > > > >   [0] https://github.com/libbpf/veristat/releases/tag/v0.1
>> >> > > >
>> >> > > > So how many copies of libbpf do I need for having a CO-RE toolchain?
>> >> > >
>> >> > > What do you mean by "CO-RE toolchain"? bpftool, veristat, retsnoop,
>> >> > > etc are tools. The fact they are using statically linked libbpf
>> >> > > through Git submodule is irrelevant to end users. You need one libbpf
>> >> > > in the system (for those who link dynamically against libbpf), the
>> >> > > rest are just tools.
>> >> > >
>> >> > > >
>> >> > > > Will different tools have different view of the kernel because they each
>> >> > > > use different private copy of libbpf with different features?
>> >> > >
>> >> > > That's up to tools, not libbpf. You are over pivoting on libbpf here.
>> >> > > There is one view of the kernel, it depends on what features the
>> >> > > kernel supports. If the tool requires some specific functionality of
>> >> > > libbpf, it will update its Git submodule reference to get a version of
>> >> > > libbpf that provides that feature. That's the point, an
>> >> > > application/tool is in control of what kind of features it gets from
>> >> > > libbpf.
>> >>
>> >> Since libbpf has a stable API & ABI, is it theoretically possible for
>> >> bpftool, veristat, retsnoop, etc. all share the same version of libbpf?
>> >
>> > No, because libbpf is not just a set of APIs. Newer libbpf versions
>> > support more BPF-side features, more kernel features, etc, etc. Libbpf
>> > is not a typical user-space library, it is a BPF loader, and even if
>> > user-visible API doesn't change, libbpf's support for various BPF-side
>> > features is extended. Which is important for tools like bpftool,
>> > retsnoop, veristat which rely on loading and working with BPF object
>> > files.
>>
>> The converse of this is also true: if your system is upgraded to a new
>> kernel version with new BPF features, the libbpf version should follow
>> it, and all applications linked against it will automatically take
>> advantage of any bugfixes regardless without having to wait for each
>> application to be updated.
>
> No, if my application was not developed to take advantage of a new
> kernel feature, newer libbpf will do nothing for me. If my application
> wants to support that feature, I'll update my application and
> correspondingly update libbpf embedded in it. If my application is
> affected by some bug fix, I'll update libbpf even faster than distros
> will get to it.

You may do that, but you're also someone who is following the
development of libbpf closely and pay attention to when bugs appear. Not
all applications developers have the same vigilance for all the
libraries they rely on. Which is the reason distros generally take on
the responsibility of ensuring their users receive timely library
updates.

> I've heard all such arguments over the last few years. They are not
> convincing and my own practical experience shows irrelevance of the
> above argument.

I don't doubt your personal experience, I'm just objecting to you
dismissing other points of view just because you haven't experienced
them yourself.

>> Libbpf is really no different from any other library here, and I really
>> don't get why you keep insisting it's "special"...
>
> It's special in the sense that it provides two sets of APIs -- for
> user-space (typical libraries) and BPF object files. Besides that, for
> BPF-side it's not even a set of APIs (headers, helpers, etc), it also
> provides some set of functionality that can improve or be extended
> over time. E.g., libbpf used to not support non-inlined BPF
> subprograms, and then it started supporting them. In terms of API/ABI
> -- nothing changed. Yet the change is very important.

Lots of libraries do that. File format libraries support new format
features without changing their API, networking libraries support new
protocol features, etc. So again, libbpf is not special in this
respect.

> Now, I build a tool that is using libbpf and some BPF functionality,
> e.g., retsnoop. Libbpf just got SEC("ksyscall") support. Retsnoop
> wants to take advantage of it. I just go and use SEC("ksyscall")
> programs in .bpf.c files that are embedded inside retsnoop.
> I don't have to *and don't want to* do feature detection of whether a
> particular libbpf version that happens to be installed/packaged on the
> system supports this version. I *know* it does, because I control it,
> through a submodule. That's what I care about.

Right, so just require a minimum version of the library where the API
you want to use is available. That is pretty standard and distros deal
with this all the time. This is not an argument for static linking or
vendoring...

> Whether some distro insists on libbpf being shared across any
> libbpf-using application or not is none of my concern. Libbpf is an
> implementation detail of my application (retsnoop), it's not for the
> packager to decide how I develop and structure my tool.

Right, well, you don't *have* to be cooperative with the wider
ecosystem, of course. Just as packagers don't have to follow your
recommendations if they have good reasons not to. I believe we've had
this discussion before, and I don't think we're going to agree this time
around either, so let's not waste any more virtual ink on rehashing it :)

-Toke

