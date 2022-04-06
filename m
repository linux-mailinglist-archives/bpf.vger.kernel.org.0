Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4A4F6927
	for <lists+bpf@lfdr.de>; Wed,  6 Apr 2022 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbiDFSTe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Apr 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiDFSTX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Apr 2022 14:19:23 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37D152B34
        for <bpf@vger.kernel.org>; Wed,  6 Apr 2022 10:01:05 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id r2so3660757iod.9
        for <bpf@vger.kernel.org>; Wed, 06 Apr 2022 10:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQmsmv68UG6DKv2+gyQX4cE4e7Zo/mxsyxBr5/Z7QXU=;
        b=BiAjfx8f8buoCYzD1X60nGI4GGl7FMsguIMUx7PtkBoodpdSg0TOrZQYMbKLArZkWh
         82R6LbLGolkQGEIwsnkQO4jtH41S0ZCCpnmuFNZVo6cJKY7rHjE6mCUZWWyQCBj/fTUg
         +ImlhculIHRBLsCyBiktWgqm4afzZ7IXKAF+2bqkFilY1wY4+v+tIeiSROHbfk1EvPQT
         QleCa791BVMdFDcpqIXbylD/sRSoDgw9r9p2fOo2jINV8kgJY+ulOk2a1dVtAmu5UQIK
         OT+MN9slBZFCeAPFfa3WYWiXCzvK8VUiW/x7SP+NeW4RhjV8+mOaginVtNxe44NSj+7g
         CSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQmsmv68UG6DKv2+gyQX4cE4e7Zo/mxsyxBr5/Z7QXU=;
        b=qL32qW8fBK07Sfk05gucXD+GY2CkDnwK9NeTl9sDUQfYWTF1bKaNjp22OU4ZRujGJr
         4aQFF2M6LZN75ybB6DjxaEoO8UzT0AC750k7lfcZwf/pompLOh9w2QrL75lAarPNUjmk
         q/teK4T6/ApLxRg1A5hiDra6vgF8qqru7ams5+E5juufWFPRmNgtH9HMIgEDp462n1od
         h1qOb9lOptTSTgTY4i3QSzM+UpJkPzFUrPt5DC2GQNVo+aMjgqAHxpls/BSBHlliKFup
         CLSop4NulwHz4Ibtcl9uu0fh8KIsMi93mhUQkImPuU/IbEepMyjYZzUmZwvkWXOlqvLi
         DIYA==
X-Gm-Message-State: AOAM531jhT7tgp+bh/k+lGnpZTh42Zeiq47hgg5ZwizLFTmjE8jVoMKk
        U3CkJkf3HFL/m/BALyJpXBIYED3d2+uHl0N0m5ps3+Ox
X-Google-Smtp-Source: ABdhPJxrIYnNk1KxO5AtEg0QeFh+EsoXIO8Kkuq5CcfdsZKy2c01ojmyYnm3HG6pG1M0DLLX64TkSjmd+bsOSv6zaI8=
X-Received: by 2002:a05:6638:3395:b0:323:8a00:7151 with SMTP id
 h21-20020a056638339500b003238a007151mr5027215jav.93.1649264465228; Wed, 06
 Apr 2022 10:01:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
 <20220318191332.7qsztafrjyu7bjtc@ast-mbp> <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
 <CAADnVQKo2xiOYrUG_Mb9OTAO_Sa7uahkYL-UEbu02GD=Sr8BJA@mail.gmail.com>
 <CAEf4BzbL0SBN_1MG4r3boErrz73DRMK5v_6mEjHgMMXgix_b9Q@mail.gmail.com> <9052649c76d7198f805424c34d145ce964cadb5c.camel@fb.com>
In-Reply-To: <9052649c76d7198f805424c34d145ce964cadb5c.camel@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 6 Apr 2022 10:00:54 -0700
Message-ID: <CAEf4BzZECm6wobtH6tyBxd+PYrYmYZoKya8F6A+Vubkw30AFAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     "alexei.starovoitov@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 5, 2022 at 10:35 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> On Mon, 2022-03-21 at 21:32 -0700, Andrii Nakryiko wrote:
> > On Mon, Mar 21, 2022 at 6:15 PM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Mar 21, 2022 at 4:24 PM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > I remember I brought this up earlier, but I forgot the outcome.
> > > > What
> > > > if don't touch BPF_RAW_TRACEPOINT_OPEN and instead allow to
> > > > create all
> > > > the same links through more universal BPF_LINK_CREATE command.
> > > > And
> > > > only there we add bpf_cookie? There are few advantages:
> > > >
> > > > 1. We can separate raw_tracepoint and trampoline-based programs
> > > > more
> > > > cleanly in UAPI (it will be two separate structs:
> > > > link_create.raw_tp
> > > > with raw tracepoint name vs link_create.trampoline, or whatever
> > > > the
> > > > name, with cookie and stuff). Remember that raw_tp won't support
> > > > bpf_cookie for now, so it would be another advantage not to
> > > > promise
> > > > cookie in UAPI.
> > >
> > > What would it look like?
> > > Technically link_create has prog_fd and perf_event.bpf_cookie
> > > already.
> > >
> > >         case BPF_PROG_TYPE_TRACING:
> > >                 ret = tracing_bpf_link_attach(attr, uattr, prog);
> > > would just gain a few more checks for prog->expected_attach_type ?
> > >
> > > Then link_create cmd will be equivalent to raw_tp_open.
> > > With and without bpf_cookie.
> > > ?
> >
> > Yes, except I'd leave perf_event for perf_event-based attachments
> > (kprobe, uprobe, tracepoint) and would define a separate substruct
> > for
> > trampoline-based programs. Something like this (I only compile-tested
> > it, of course). I've also simplified prog_type/expected_attach_type
> > logic a bit because it felt like a total maze to me and I was getting
> > lost all the time. Gmail will probably corrupt all the whitespaces,
> > sorry about that in advance.
> >
> > Seems like we could already attach BPF_PROG_TYPE_EXT both through
> > RAW_TRACEPOINT_OPEN and LINK_CREATE, I didn't realize that. The
> > "patch" below leaves raw_tp handling
> > (BPF_PROG_TYPE_TRACING+BPF_TRACE_RAW_TP,
> > BPF_PROG_TYPE_RAW_TRACEPOINT,
> > and BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE) in RAW_TRACEPOINT_OPEN. If
> > we want to completely unify all the bpf_link creations under
> > LINK_CREATE, see extra small "patch" at the very bottom.
>
> I just implemented and tested a patch of tracing links with
> bpf_link_create, so it can be done with both raw_tp_open and
> bpf_link_create.
>

Nice, please send it as part of your cookie patch set in a separate patch.

> Do we want to remove raw_tp_open() eventually?  Should I remove
> raw_tp_open() supports of cookies?

We can't remove existing Linux UAPI, but we can stop extending them.
So I'd say let's add cookie only through CREATE_LINK and leave
RAW_TRACEPOINT_OPEN as is.

>
>
