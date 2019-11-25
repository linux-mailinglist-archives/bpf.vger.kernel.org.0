Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF5DC108ABA
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2019 10:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKYJXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Nov 2019 04:23:01 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33682 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfKYJXA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Nov 2019 04:23:00 -0500
Received: by mail-lj1-f194.google.com with SMTP id t5so14954942ljk.0
        for <bpf@vger.kernel.org>; Mon, 25 Nov 2019 01:22:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=faK4WL392GqdckW0uyVwjIQdx7tJEVyd6BibPewC/yc=;
        b=uvnNoSEXIuP18d6+Y3p+e0tTXitJun+UB9p4/VP7uWVwZEOY00tGAHl1xNkcofvNVr
         LONkwGkcCZ5Z7eINwotWRNm7VTEJih3MS/a+Dyn9OzUkISr5tsjw5SGlIuJNYSB5g/Br
         Dq4oJARqWusN5j1OVILos2xpth3Z3nFWDamSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=faK4WL392GqdckW0uyVwjIQdx7tJEVyd6BibPewC/yc=;
        b=HIJ6hCGiEdM0QuNJM4REhBrLDwDdnfktScM9UBKKrls9mFLpTQfnT20PwQHauGzBDW
         XpSNGK0rB7gjlrQnrNV9chYS2xYjjPh5LibfznfHkDtygDU3370s3j6Og76A8rj84Ol7
         QmPvTfcPb6X8zwtP5InyTOrnw3/OwJbREOb0R3TVUMIYvSnzdYdo5V5hnu2WI4NQgbZ/
         XjRmarBlnigwx0zXqsCv+XE+q4ibiPBrWG/LmRGx2L9Lm/4qJfFDBS4maUvjLAROtBOw
         soN66oYYV70dNZyf7u5/DDtl5E+g8oggxHy1E5HI7CHY6SsjktHOAGe7GtrLknXN4kAW
         e4WA==
X-Gm-Message-State: APjAAAUTM7J9ghE8fCC81zWGoNnIFIcWs0b1QFY8LnzUJ/6A6dFgv5TI
        wNTNpigOvvhKgCBNMyl0l5fSkg==
X-Google-Smtp-Source: APXvYqwBGzTQDFC0/5QhmSGtRSkaqEzOBQru0EJmfLBRysmMv2dIUwZgqZcuvUGtr6u58HT7OS8FyA==
X-Received: by 2002:a05:651c:209:: with SMTP id y9mr20871356ljn.65.1574673776940;
        Mon, 25 Nov 2019 01:22:56 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id x29sm3710096lfg.45.2019.11.25.01.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 01:22:56 -0800 (PST)
References: <20191123110751.6729-1-jakub@cloudflare.com> <5dda1ed3e7f5d_62c72ad877f985c42f@john-XPS-13-9370.notmuch>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        kernel-team@cloudflare.com, Martin KaFai Lau <kafai@fb.com>
Subject: Re: [PATCH bpf-next 0/8] Extend SOCKMAP to store listening sockets
In-reply-to: <5dda1ed3e7f5d_62c72ad877f985c42f@john-XPS-13-9370.notmuch>
Date:   Mon, 25 Nov 2019 10:22:55 +0100
Message-ID: <87pnhgnwcw.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Nov 24, 2019 at 07:10 AM CET, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> This patch set makes SOCKMAP more flexible by allowing it to hold TCP
>> sockets that are either in established or listening state. With it SOCKMAP
>> can act as a drop-in replacement for REUSEPORT_SOCKARRAY which reuseport
>> BPF programs use. Granted, it is limited to only TCP sockets.
>>
>> The idea started out at LPC '19 as feedback from John Fastabend to our
>> troubles with repurposing REUSEPORT_SOCKARRAY as a collection of listening
>> sockets accessed by a BPF program ran on socket lookup [1]. Without going
>> into details, REUSEPORT_SOCKARRAY proved to be tightly coupled with
>> reuseport logic. Talk from LPC (see slides [2] or video [3]) highlights
>> what problems we ran into when trying to make REUSEPORT_SOCKARRAY work for
>> our use-case.
>>
>> Patches have evolved quite a bit since the RFC series from a month ago
>> [4]. To recap the RFC feedback, John pointed out that BPF redirect helpers
>> for SOCKMAP need sane semantics when used with listening sockets [5], and
>> that SOCKMAP lookup from BPF would be useful [6]. While Martin asked for
>> UDP support [7].
>
> Curious if you've started looking into UDP support. I had hoped to do
> it but haven't got there yet.

No, not yet. I only made sure the newly added tests were easy to modify
to cover UDP by not hard-coding the socket type.

I expect to break ground with UDP work soon, though. Right after I push
out another iteration of programmable socket lookup [1] patches adapted for
SOCKMAP, which we've been testing internally.

>> As it happens, patches needed more work to get SOCKMAP to actually behave
>> correctly with listening sockets. It turns out flexibility has its
>> price. Change log below outlines them all.
>>
>
> But looks pretty clean to me, only major change here is to add an extra
> hook to remove psock from the child socket. And that looks fine to me and
> cleaner than any other solution I had in mind.
>
> Changes +/- looks good as well most the updates are in selftests to update
> tests and add some new ones. +1

Thanks for taking a look at the patches so quickly. I appreciate it.

-Jakub

[1] https://lore.kernel.org/bpf/20190828072250.29828-1-jakub@cloudflare.com/
