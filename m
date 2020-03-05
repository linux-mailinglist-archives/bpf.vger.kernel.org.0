Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4519F17A3A4
	for <lists+bpf@lfdr.de>; Thu,  5 Mar 2020 12:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCELFc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Mar 2020 06:05:32 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60299 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbgCELFc (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Mar 2020 06:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583406331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5NbMjAjfqmwFcQtN3QgY76hhfj66R2EMybjcy19Lm8I=;
        b=WeiwIdA24Q5WLGlRSHXJJypMVQecqSMLJRHA/hvoKvQ5bXQLW8ARhVO5Qx1EqDNo954AY1
        VRVw2oTfDaN2SR0GPrSTQKsAifJLcUWK9a4mqbs71Kxo7QUm+zIplYcjbHpKUpuD2Olbdz
        66Gv4BUiTxvTsOvp9NyMpHae2GPfarc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-aFZjOgOoNy2h1Od3rM3kRw-1; Thu, 05 Mar 2020 06:05:30 -0500
X-MC-Unique: aFZjOgOoNy2h1Od3rM3kRw-1
Received: by mail-wm1-f70.google.com with SMTP id g26so1427591wmk.6
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2020 03:05:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=5NbMjAjfqmwFcQtN3QgY76hhfj66R2EMybjcy19Lm8I=;
        b=IMKA5HMWjnJvwB6XT2JaFd8L37daKwczVZ5iBLmf5vP2UzaFddo2x05JXQnKznrUMK
         /tL/HdnZLprl8mXLimdTAoWnsF97rp0soE+pBcglbHwldGlMloz+XtljPD/hid72gahR
         ohQP7vhuqR/5MAw46JG/xygzrcqidjYFil3zQHngCVLTqH0/wXmOn9SwoamJYdPMgKtS
         Wz3KNq0YUffr1EZEC7VKKbB3P49Ll1Ql4RnCkZFjVsZbaillVogKbKZJKwP9R8B8Qjtu
         c7ftQwluIBvwnTjF0xU0qOi1sPQR5CavhxtuF1hkQC/h8zuW78Cy+QukSrey7RA66j/f
         mNFA==
X-Gm-Message-State: ANhLgQ2WEQ4TWGNRa22+qxoQCM2iJQJRnf8UDY5vGloWy1X1v515MQ4l
        mf2z/+/fkg/MnrPgKg/khDeWLb+z4WDi4NC6Tq89Ca2DjXiCT/P+AVqD2hNPJ7BsLqQauZYsnnf
        k1LkOXGp/FBkY
X-Received: by 2002:a5d:6948:: with SMTP id r8mr7356578wrw.73.1583406328948;
        Thu, 05 Mar 2020 03:05:28 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuAzQekKvGVJsRQMKX0DZku9jQA7VBEISgAFfEH1M1k2Pe1lXtqbPQwNZt5D3FdV0eMl+R8jQ==
X-Received: by 2002:a5d:6948:: with SMTP id r8mr7356251wrw.73.1583406325186;
        Thu, 05 Mar 2020 03:05:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y7sm9040828wmd.1.2020.03.05.03.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 03:05:24 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BDE5D18034F; Thu,  5 Mar 2020 12:05:23 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next 0/3] Introduce pinnable bpf_link kernel abstraction
In-Reply-To: <20200305001620.204c292e@cakuba.hsd1.ca.comcast.net>
References: <8083c916-ac2c-8ce0-2286-4ea40578c47f@iogearbox.net> <CAEf4BzbokCJN33Nw_kg82sO=xppXnKWEncGTWCTB9vGCmLB6pw@mail.gmail.com> <87pndt4268.fsf@toke.dk> <ab2f98f6-c712-d8a2-1fd3-b39abbaa9f64@iogearbox.net> <ccbc1e49-45c1-858b-1ad5-ee503e0497f2@fb.com> <87k1413whq.fsf@toke.dk> <20200304043643.nqd2kzvabkrzlolh@ast-mbp> <20200304114000.56888dac@kicinski-fedora-PC1C0HJN> <20200304204506.wli3enu5w25b35h7@ast-mbp> <20200304132439.6abadbe3@kicinski-fedora-PC1C0HJN> <20200305010706.dk7zedpyj5pb5jcv@ast-mbp> <20200305001620.204c292e@cakuba.hsd1.ca.comcast.net>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 05 Mar 2020 12:05:23 +0100
Message-ID: <87tv332hak.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jakub Kicinski <kuba@kernel.org> writes:

> On Wed, 4 Mar 2020 17:07:08 -0800, Alexei Starovoitov wrote:
>> > Maybe also the thief should not have CAP_ADMIN in the first place?
>> > And ask a daemon to perform its actions..  
>> 
>> a daemon idea keeps coming back in circles.
>> With FD-based kprobe/uprobe/tracepoint/fexit/fentry that problem is gone,
>> but xdp, tc, cgroup still don't have the owner concept.
>> Some people argued that these three need three separate daemons.
>> Especially since cgroups are mainly managed by systemd plus container
>> manager it's quite different from networking (xdp, tc) where something
>> like 'networkd' might makes sense.
>> But if you take this line of thought all the ways systemd should be that
>> single daemon to coordinate attaching to xdp, tc, cgroup because
>> in many cases cgroup and tc progs have to coordinate the work.
>
> The feature creep could happen, but Toke's proposal has a fairly simple
> feature set, which should be easy to cover by a stand alone daemon.
>
> Toke, I saw that in the library discussion there was no mention of 
> a daemon, what makes a daemon solution unsuitable?

Quoting from the last discussion[0]:

> - Introducing a new, separate code base that we'll have to write, support
>   and manage updates to.
> 
> - Add a new dependency to using XDP (now you not only need the kernel
>   and libraries, you'll also need the daemon).
> 
> - Have to duplicate or wrap functionality currently found in the kernel;
>   at least:
>   
>     - Keeping track of which XDP programs are loaded and attached to
>       each interface (as well as the "new state" of their attachment
>       order).
> 
>     - Some kind of interface with the verifier; if an app does
>       xdpd_rpc_load(prog), how is the verifier result going to get back
>       to the caller?
> 
> - Have to deal with state synchronisation issues (how does xdpd handle
>   kernel state changing from underneath it?).
> 
> While these are issues that are (probably) all solvable, I think the
> cost of solving them is far higher than putting the support into the
> kernel. Which is why I think kernel support is the best solution :)

The context was slightly different, since this was before we had
freplace support in the kernel. But apart from the point about the
verifier, I think the arguments still stand. In fact, now that we have
that, we don't even need userspace linking, so basically a daemon's only
task would be to arbitrate access to the XDP hook? In my book,
arbitrating access to resources is what the kernel is all about...

-Toke

[0] https://lore.kernel.org/bpf/m/874l07fu61.fsf@toke.dk

