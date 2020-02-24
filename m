Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA516A7C7
	for <lists+bpf@lfdr.de>; Mon, 24 Feb 2020 14:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbgBXN7e (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Feb 2020 08:59:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbgBXN7d (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Feb 2020 08:59:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id l5so6244782wrx.4
        for <bpf@vger.kernel.org>; Mon, 24 Feb 2020 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HsNww3eoGF597P4AbuzJSPTd6DaevE09nhmftcgasMo=;
        b=ltBuCrF4FNh5l3PCkUMpAYISca6TS4xx1L529XkEj9hw31ZkZQJk8KkRU1AhLVJ3Vk
         fEBEVdM/yC6+hMzm7796DoZEkn3bsQSh45bRS/inI5uGdDZMKXPnqkm8iJY5fzDY1v69
         5MzejOvrNfkvcGQkPUBz99Ecp0CT0ESKlATO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HsNww3eoGF597P4AbuzJSPTd6DaevE09nhmftcgasMo=;
        b=UUMKa27U5tu56CidLL3enhVH1YZzi6CQk/r+4mGg0AX9eG+5z5d+g+BMuFSeCm47lp
         S7LhjiCsJFuB3pv4NGfQJwqQtFhACU5pasB7jcrAsaaoeVQUoo9/m1vNOuZvYPGjMQX9
         lGat86Y/nXy2m6SzIOleYRd+QWY0QtqI+yyHh6NF4TNjykDQ+cj3ejHBB1hGvKtvlTXj
         hhdPxwcp4XSZCY6lM7AP3V035itWSrwuZL4yzTPw7cqcPOOB882LIEBSdOaARq5rqWKo
         2AP+S+SvYylmFuwsHQjAWcmc+xCfZZ9kZElhQJSohtAYqvepkTzRcfimFFzu2LDjGB9x
         rXuw==
X-Gm-Message-State: APjAAAXI9p9ovpJwx89CDk8dnar/ax4AFbA+P63UEy/XZRCnUGepPOIV
        IB7zp8tlfMxz+mQn/rBDfATjLw==
X-Google-Smtp-Source: APXvYqwrwDrg4IYw+IWldpEdEG8zpipOCRzr3q8Z9sxRRdsSGp801SlRA8j64EekvCxqlhbNP8wVtw==
X-Received: by 2002:a5d:56ca:: with SMTP id m10mr69483615wrw.313.1582552769884;
        Mon, 24 Feb 2020 05:59:29 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id n13sm18776323wmd.21.2020.02.24.05.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:59:29 -0800 (PST)
References: <20200218171023.844439-1-jakub@cloudflare.com> <c86784f5-ef2c-cfd6-cb75-a67af7e11c3c@iogearbox.net> <CAADnVQJrsfpsT47SqyCTM6=MSkeMESZACZR12Kx+0kRGBnRbvg@mail.gmail.com> <87d0a668an.fsf@cloudflare.com> <20200223214329.2djcyztfze3d34g5@ast-mbp>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next v7 00/11] Extend SOCKMAP/SOCKHASH to store listening sockets
In-reply-to: <20200223214329.2djcyztfze3d34g5@ast-mbp>
Date:   Mon, 24 Feb 2020 14:59:28 +0100
Message-ID: <87ftf0cchr.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Feb 23, 2020 at 10:43 PM CET, Alexei Starovoitov wrote:
> On Sat, Feb 22, 2020 at 01:49:52PM +0000, Jakub Sitnicki wrote:
>> Hi Alexei,
>> 
>> On Sat, Feb 22, 2020 at 12:47 AM GMT, Alexei Starovoitov wrote:
>> > On Fri, Feb 21, 2020 at 1:41 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> >>
>> >> On 2/18/20 6:10 PM, Jakub Sitnicki wrote:
>> >> > This patch set turns SOCK{MAP,HASH} into generic collections for TCP
>> >> > sockets, both listening and established. Adding support for listening
>> >> > sockets enables us to use these BPF map types with reuseport BPF programs.
>> >> >
>> >> > Why? SOCKMAP and SOCKHASH, in comparison to REUSEPORT_SOCKARRAY, allow the
>> >> > socket to be in more than one map at the same time.
>> >> >
>> >> > Having a BPF map type that can hold listening sockets, and gracefully
>> >> > co-exist with reuseport BPF is important if, in the future, we want
>> >> > BPF programs that run at socket lookup time [0]. Cover letter for v1 of
>> >> > this series tells the full story of how we got here [1].
>> >> >
>> >> > Although SOCK{MAP,HASH} are not a drop-in replacement for SOCKARRAY just
>> >> > yet, because UDP support is lacking, it's a step in this direction. We're
>> >> > working with Lorenz on extending SOCK{MAP,HASH} to hold UDP sockets, and
>> >> > expect to post RFC series for sockmap + UDP in the near future.
>> >> >
>> >> > I've dropped Acks from all patches that have been touched since v6.
>> >> >
>> >> > The audit for missing READ_ONCE annotations for access to sk_prot is
>> >> > ongoing. Thus far I've found one location specific to TCP listening sockets
>> >> > that needed annotating. This got fixed it in this iteration. I wonder if
>> >> > sparse checker could be put to work to identify places where we have
>> >> > sk_prot access while not holding sk_lock...
>> >> >
>> >> > The patch series depends on another one, posted earlier [2], that has been
>> >> > split out of it.
>> >> >
>> >> > Thanks,
>> >> > jkbs
>> >> >
>> >> > [0] https://lore.kernel.org/bpf/20190828072250.29828-1-jakub@cloudflare.com/
>> >> > [1] https://lore.kernel.org/bpf/20191123110751.6729-1-jakub@cloudflare.com/
>> >> > [2] https://lore.kernel.org/bpf/20200217121530.754315-1-jakub@cloudflare.com/
>> >> >
>> >> > v6 -> v7:
>> >> >
>> >> > - Extended the series to cover SOCKHASH. (patches 4-8, 10-11) (John)
>> >> >
>> >> > - Rebased onto recent bpf-next. Resolved conflicts in recent fixes to
>> >> >    sk_state checks on sockmap/sockhash update path. (patch 4)
>> >> >
>> >> > - Added missing READ_ONCE annotation in sock_copy. (patch 1)
>> >> >
>> >> > - Split out patches that simplify sk_psock_restore_proto [2].
>> >>
>> >> Applied, thanks!
>> >
>> > Jakub,
>> >
>> > what is going on here?
>> > # test_progs -n 40
>> > #40 select_reuseport:OK
>> > Summary: 1/126 PASSED, 30 SKIPPED, 0 FAILED
>> >
>> > Does it mean nothing was actually tested?
>> > I really don't like to see 30 skipped tests.
>> > Is it my environment?
>> > If so please make them hard failures.
>> > I will fix whatever I need to fix in my setup.
>> 
>> The UDP tests for sock{map,hash} are marked as skipped, because UDP
>> support is not implemented yet. Sorry for the confusion.
>> 
>> Having read the recent thread about BPF selftests [0] I now realize that
>> this is not the best idea. It sends the wrong signal to the developer.
>> 
>> I propose to exclude the UDP tests w/ sock{map,hash} by not registering
>> them with test__start_subtest at all. Failing them would indicate a
>> regression, which is not true. While skipping them points to a potential
>> problem with the test environment, which isn't true, either.
>
> So the tests are ready, but kernel support is missing?

Yes, correct.

> Please don't run those tests then since they're guaranteed to fail atm.

Just posted [0] to rectify this situation.

[0] https://lore.kernel.org/bpf/20200224135327.121542-1-jakub@cloudflare.com/T/#t
