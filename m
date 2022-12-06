Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 718C9644BB0
	for <lists+bpf@lfdr.de>; Tue,  6 Dec 2022 19:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLFSYK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Dec 2022 13:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiLFSXg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Dec 2022 13:23:36 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B957429A2
        for <bpf@vger.kernel.org>; Tue,  6 Dec 2022 10:21:21 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id e189so10273031iof.1
        for <bpf@vger.kernel.org>; Tue, 06 Dec 2022 10:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNsrgktQf590sYBrNYcupAeuiRqMUo7PmRbZTzg2EYA=;
        b=Ik534o+EiJUrpShJ1G/jaUl+A6JiRbnzwlNgN3hG3JUrcbojFHknf6tBwKw5cdAfNZ
         bj4TppBN1OgGEGPFNljd9KDkdg3xhkl647ML48tBZHBpiFbED1MsKxhVW7pqwsmec5QK
         ZY5S3ruBFXeJdGvcawTpVkNAnf+uMpvCJsE/+QZLnkfSoLobjROB7PiHDnFxQ0pLMFHK
         s3LgYmUvW7bpZku5Y5LsBAw4PRq6x6g+fOBjCpeTj0E3r4euT8aXuf60Sfs6keAZA5a3
         od1Z80I/NrebUnlRDLT24GMq7QTDURVf63sqsIeF3/vlhwc/uDJmR6v0a8NdLnNWpQxc
         zcyQ==
X-Gm-Message-State: ANoB5pmzO/exRLP3pnRMnGRIo9daUHXyAY1ry/B3vShyCxNzA8XemXQF
        1xx4/NosmKik8idRFkvJmv2fBF3KuO5hvJ6HQYw=
X-Google-Smtp-Source: AA0mqf7b8NsYyS0azJ+OAqwQyezasHpys2zrEqJg8dJOILMc5CurjKjJt3I9mjC0S1RYLtY957kAnBEOyUf5xcNawbw=
X-Received: by 2002:a5d:87c8:0:b0:6e0:1ddd:7da6 with SMTP id
 q8-20020a5d87c8000000b006e01ddd7da6mr3300859ios.145.1670350839722; Tue, 06
 Dec 2022 10:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20221121213123.1373229-1-jolsa@kernel.org> <bcdac077-3043-a648-449d-1b60037388de@iogearbox.net>
 <Y388m6wOktvZo1d4@krava> <CAADnVQJ5knvWaxVa=9_Ag3DU_qewGBbHGv_ZH=K+ETUWM1qAmA@mail.gmail.com>
 <Y4CMbTeVud0WfPtK@krava> <CAEf4BzZP9z3kdzn=04EvAprG-Ldrsegy5JkzvoBPvcdMG_vvGg@mail.gmail.com>
 <Y4uOSrXBxVwnxZkX@google.com> <Y43j3IGvLKgshuhR@krava> <CAM9d7cj2QGH2x=J=7LVEEOfcDUYLU0Cmd_O7KEHZM-9FRmX3OA@mail.gmail.com>
 <Y4750mbd7XEzue0r@krava>
In-Reply-To: <Y4750mbd7XEzue0r@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 6 Dec 2022 10:20:28 -0800
Message-ID: <CAM9d7cj-QRCk-1TnHj0YGteRupjPR4-=pCMO-dDNya_M3X38cw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Restrict attachment of bpf program to some tracepoints
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Hao Sun <sunhao.th@gmail.com>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 6, 2022 at 12:14 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Mon, Dec 05, 2022 at 08:00:16PM -0800, Namhyung Kim wrote:
> > On Mon, Dec 5, 2022 at 4:28 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > On Sat, Dec 03, 2022 at 09:58:34AM -0800, Namhyung Kim wrote:
> > > > What about contention_begin?  I wonder if we can disallow recursions
> > > > for those in the deny list like using bpf_prog_active..
> > >
> > > I was testing change below which allows to check recursion just
> > > for contention_begin tracepoint
> > >
> > > for the reported issue we might be ok with the change that Andrii
> > > suggested, but we could have the change below as extra precaution
> >
> > Looks ok to me.  But it seems it'd add the recursion check to every
>
> hm, it should allocate recursion variable just for the contention_begin
> tracepoint, rest should see NULL pointer

Oh, right.  I meant the NULL check.

>
> > tracepoint.  Can we just change the affected tracepoints only by
> > using a kind of wrapped btp->bpf_func with some macro magic? ;-)
>
> I tried that and the only other ways I found are:
>
>   - add something like TRACE_EVENT_FLAGS macro and have __init call
>     for specific tracepoint that sets the flag
>
>   - add extra new 'bpf_func' that checks the re-entry, but that'd mean
>     around 1000 extra mostly unused small functions

Hmm.. ok, that's not what I want.  I'm fine with the patch then.
With the 'likely' change,

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
