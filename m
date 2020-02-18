Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE49B162C6E
	for <lists+bpf@lfdr.de>; Tue, 18 Feb 2020 18:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgBRRRg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Feb 2020 12:17:36 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36205 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgBRRRg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 18 Feb 2020 12:17:36 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so23868699ljg.3
        for <bpf@vger.kernel.org>; Tue, 18 Feb 2020 09:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FouI7HZ504bKO/T8FRzb/PQoWAg9U4L3BBBQW4sgHO0=;
        b=Ck2dHaLDo/DFp7OZTypsrXOmY6qZHdvkmANMDzfZlRoz8xl+m4guknHB0iuWN6vgk9
         rcYKC6t1OeiaBACzjmzn8ip6ORAcrxrxzmp3t9q7vCQgqszLNewnrtjJzQ+5BELgqfis
         vevZaPJw8vankicNryrPrNDtapBBJGhn7+EYqFJ6Ph0uU6vYPHJb1fM0Ms3MEAwFICwF
         DRqcae3C/bJF3v0B+uLGFbl99ETdrkPv1mkVAOGBnkI8Ivz1AQboNfH7WlwJW0LciaO+
         LQwNrUO99Of24kmvwH78imh859fGW/bI47VExAUtbah+9xkLiHtmrwfizCD9zgLAkmsc
         Odqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FouI7HZ504bKO/T8FRzb/PQoWAg9U4L3BBBQW4sgHO0=;
        b=RUCkacg+2m7ken1tmvAhlblk5715ayaRlwyoztJ2am/i/vOaB+ttcrhdwSA78DTti6
         2jEJ36hhQbcwUkRzd6Q7wilSzv4aVZOqWWo8T5MzkF5xCCAB4hzG8Ky5js7ygVe1v2f7
         0Ykn/zTLMKjvOtFJBYfnHCcoYUvba3Hy2WvBwToBwDdXCT71GxwIdhWklny+u6uQTNY8
         ctT79Xpy5IsMgm4Nt9JS9bfl+VT3B9hWIAKW8Edp3wZbM8wgJ5G/yzkEMbzbvzSBUmVt
         Uo59IOAMRF0XBk09btTp8WnJ6f8ep4JLrZx0om1RxEtefk81SNrwP8iz6WnL4MgZRpov
         jWRA==
X-Gm-Message-State: APjAAAW5HNdfBOSFOzdTZ3IoDwcbVeNac9LDwhaM9BdW2ehslEoLFKey
        yfjJIG9J52PSXSGfgIkv1SyDjNDdr7izUk5D22XeMQ==
X-Google-Smtp-Source: APXvYqzFEGNfOz4BXFj8Qxqlu14OZvZjH/IwTtO7j/I4FsZeggmMZjLG1hUnvzsj6gD2JNQbf2bSou6TT8eeUu5yRcI=
X-Received: by 2002:a2e:b00f:: with SMTP id y15mr13939354ljk.290.1582046254568;
 Tue, 18 Feb 2020 09:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20200214224302.229920-1-brianvv@google.com> <8ac06749-491f-9a77-3899-641b4f40afe2@fb.com>
 <63fa17bf-a109-65c1-6cc5-581dd84fc93b@iogearbox.net> <c8a8d5ca-9b97-68dc-4483-926fd6bddc95@fb.com>
In-Reply-To: <c8a8d5ca-9b97-68dc-4483-926fd6bddc95@fb.com>
From:   Brian Vazquez <brianvv@google.com>
Date:   Tue, 18 Feb 2020 09:17:23 -0800
Message-ID: <CAMzD94TkwcJrybpmscCdF3OyQ=hcrGOs7QQONSrSMFzXK6otNA@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Do not grab the bucket spinlock by default on
 htab batch ops
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Linux NetDev <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 18, 2020 at 8:34 AM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/18/20 7:56 AM, Daniel Borkmann wrote:
> > On 2/18/20 4:43 PM, Yonghong Song wrote:
> >> On 2/14/20 2:43 PM, Brian Vazquez wrote:
> >>> Grabbing the spinlock for every bucket even if it's empty, was causing
> >>> significant perfomance cost when traversing htab maps that have only a
> >>> few entries. This patch addresses the issue by checking first the
> >>> bucket_cnt, if the bucket has some entries then we go and grab the
> >>> spinlock and proceed with the batching.
> >>>
> >>> Tested with a htab of size 50K and different value of populated entries.
> >>>
> >>> Before:
> >>>    Benchmark             Time(ns)        CPU(ns)
> >>>    ---------------------------------------------
> >>>    BM_DumpHashMap/1       2759655        2752033
> >>>    BM_DumpHashMap/10      2933722        2930825
> >>>    BM_DumpHashMap/200     3171680        3170265
> >>>    BM_DumpHashMap/500     3639607        3635511
> >>>    BM_DumpHashMap/1000    4369008        4364981
> >>>    BM_DumpHashMap/5k     11171919       11134028
> >>>    BM_DumpHashMap/20k    69150080       69033496
> >>>    BM_DumpHashMap/39k   190501036      190226162
> >>>
> >>> After:
> >>>    Benchmark             Time(ns)        CPU(ns)
> >>>    ---------------------------------------------
> >>>    BM_DumpHashMap/1        202707         200109
> >>>    BM_DumpHashMap/10       213441         210569
> >>>    BM_DumpHashMap/200      478641         472350
> >>>    BM_DumpHashMap/500      980061         967102
> >>>    BM_DumpHashMap/1000    1863835        1839575
> >>>    BM_DumpHashMap/5k      8961836        8902540
> >>>    BM_DumpHashMap/20k    69761497       69322756
> >>>    BM_DumpHashMap/39k   187437830      186551111
> >>>
> >>> Fixes: 057996380a42 ("bpf: Add batch ops to all htab bpf map")
> >>> Cc: Yonghong Song <yhs@fb.com>
> >>> Signed-off-by: Brian Vazquez <brianvv@google.com>
> >>
> >> Acked-by: Yonghong Song <yhs@fb.com>
> >
> > I must probably be missing something, but how is this safe? Presume we
> > traverse in the walk with bucket_cnt = 0. Meanwhile a different CPU added
> > entries to this bucket since not locked. Same reader on the other CPU with
> > bucket_cnt = 0 then starts to traverse the second
> > hlist_nulls_for_each_entry_safe() unlocked e.g. deleting entries?
>
> Thanks for pointing this out. Yes, you are correct. If bucket_cnt is 0
> and buck->lock is not held, we should skip the
>     hlist_nulls_for_each_entry_safe(l, n, head, hash_node) {
>        ...
>     }
> as another cpu may traverse the bucket in parallel by adding/deleting
> the elements.

Makes sense. Let me fix it in the next version, thanks for reviewing it!
