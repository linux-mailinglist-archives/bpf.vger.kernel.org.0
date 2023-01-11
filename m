Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7D2665EFF
	for <lists+bpf@lfdr.de>; Wed, 11 Jan 2023 16:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbjAKPYD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Jan 2023 10:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjAKPX6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Jan 2023 10:23:58 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622AA17590;
        Wed, 11 Jan 2023 07:23:56 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id 203so15329799yby.10;
        Wed, 11 Jan 2023 07:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ScXchrZhHaMfOyWhgGbERboGk+ZwayTCLY0Jfe3kxjM=;
        b=iWcOuCggMRNQ6gvg0kVgo3ZwzUGvgRTc+h80/OJDTpG2B00sPBaL9wKeFeQhSTi9m0
         Hmz2MI5aZcpbfYNWcNYjVc7WkxAyqwK4A+MqRuRx/O3SZlqrN38LOo8SchaNSYlNU879
         Ul8CMudGM6xQlyfPek4JfzOSFDj7NqY04FPPDxlsAAroewIy0mLNarrLfiCh6SvbNLzU
         Sv6jtcBykcpTV2WzZL32EWWfXkhXg5B94fJ+xeoGSwxE64DT/XnToqjticiuY8PxMn+9
         bL3RLi6oDwaO8ntpYZZxtOZHXVotJEY9x0jStoHFV4C+PzG5XcSst24BrUzRMmb5GQ9H
         QlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScXchrZhHaMfOyWhgGbERboGk+ZwayTCLY0Jfe3kxjM=;
        b=wt3p6oltG10Cq2GaJVCyuTeuThfPrjAuiScGdFHe6+8pDuChU5YaRwjwYmPt6eu2wr
         ocJYkXTaaqgKC+XKUCTxcCtd83LOPvXdnOM++kf23XM/N8XfNz1+fXUA5FRjzUJ4G5S8
         cEsfIBTWeSEcOw9Yi5STxd9qFbMVgxizhTB055WGdqJYs9bIBd/orj/daCXDa4BJX/hX
         pfOWI+veHYVDBzbHoM/bEA2xpPeWs9FjvQGweMVMw3nb7mvT7T/g2BGr0RDyK9khltAK
         EnozKwwJ7pKaS3RLaKJgmV4gOON/q6VRNtfJECBiedLDJGjTYwMDVzbZINKvLhXCOA7v
         qwxg==
X-Gm-Message-State: AFqh2kqboDtLLWpY2W9e47rWdbJyU7wqYANmmIyHMqMzpbMYTZf7Xxg1
        1SeEuP2I7aHnx15PFQaCkcrSWISfkJROw/7GzHk=
X-Google-Smtp-Source: AMrXdXuW8mdV/9TigUxZZwsVg8uixUL0NrJSiX3zuDN8DSzMgAhRTXvIzgjyFsEr3/DsCEdl0HayfDA05acQ6GwKr5E=
X-Received: by 2002:a25:ac08:0:b0:73b:23cf:ad63 with SMTP id
 w8-20020a25ac08000000b0073b23cfad63mr8879587ybi.323.1673450635438; Wed, 11
 Jan 2023 07:23:55 -0800 (PST)
MIME-Version: 1.0
References: <20230108021450.120791-1-yakoyoku@gmail.com> <CAOgh=Fzc3_bCLCKE+6KVzyMbBUOcQ_s9ef6Rw33amD5+yu-_WA@mail.gmail.com>
 <CAOgh=FxxXQ0UV_3PEGS-_575WNfR2SpKp+i78HtSVX4XO4eC0A@mail.gmail.com> <68c81196-5421-8731-52be-b9b620837eb5@gmail.com>
In-Reply-To: <68c81196-5421-8731-52be-b9b620837eb5@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 Jan 2023 16:23:44 +0100
Message-ID: <CANiq72kMfL08r2fJstcfXs3ruzCGTPUkXpWi7hVm5=N9XbuD5w@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Eric Curtin <ecurtin@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Neal Gompa <neal@gompa.dev>, bpf@vger.kernel.org,
        rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 11, 2023 at 4:02 PM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> From my POV I don't like this way due to it being set regardless whether
> or not you are building the kernel with Rust. Though, because it doesn't
> affect non `CONFIG_RUST` builds, I _think_ it won't hurt if we use that
> way for now. Gonna send v3.

One advantage (in general, i.e. not talking about this case in
particular) of having something always done is that it is one less
moving part, so less complexity, everyone will test it all the time,
etc.

So if it is not expected to hurt, but it does for an unknown reason,
then it would be nice to know as soon as possible, regardless of
whether it is gated under `CONFIG_RUST` or not.

Of course, it can always happen that something changes over time, and
thus it may start to hurt in the future only, and therefore breaking
everybody instead of a subset of people. But then again, the sooner we
would know about that unexpected change, the better; especially since
the goal is to eventually get to a point where `CONFIG_RUST` can start
to be routinely enabled by common configurations etc.

Cheers,
Miguel
