Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2FF26998D
	for <lists+bpf@lfdr.de>; Tue, 15 Sep 2020 01:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726035AbgINXPz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Sep 2020 19:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgINXPy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Sep 2020 19:15:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5F1C06174A
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 16:15:54 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id a2so1119610ybj.2
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2020 16:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfeAeKQwxp7sxbIV0MewFOa6hvSC81E50da5Sz/vqkY=;
        b=cOAY02+l2WVFxV4ZIwRwqiQmIaq59a4M6b4gBCD5A1rSemFvE8mTh4zuwuvX+Jn3k4
         AD+uHOGD2rwYwQCLQqP+3ZvdOGfMcd1hOlaXBYlZoXgVM7XMed37jS99r72PJmZri4zS
         cr2deXY1b48ts4vb/C7cX82WBTP1Kj0ASpHiYPIxwR1HnnZhOEEDkaaOU0YCe4H87PbG
         o3FvrYxJYTfoNLfOTIEEtxgSlxfB7O+3Bbi9B46Y23jRwrAvahVHa8cWC7tTaNs6jAvH
         NxXs97/XUli8qIif4rOF3rVBARpnnq1psqFzd19XyXyFG/w1VjDJbMxFfi67Tl+hASEf
         aVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfeAeKQwxp7sxbIV0MewFOa6hvSC81E50da5Sz/vqkY=;
        b=ZeKHDMt9HisQlbPCzrO16KfRuESlHAUoY1rPns5PPhejE5d7TOA2ZFA8dezQcnPUrg
         SVRk6V9CIAZFQ4JRDF6PAhFN1Ak7r2uQXMyny8jBw6yxSLZ4EXlGo6hOp012Ouqz1bPR
         kPRYC3Xh7Na0M1cFFaMC6NjZb0gOy2FIVDr1/0c5hK4u2qmEo57Sgcqlyx0a9v0uQ9n0
         6+z+yPDgTRs/1h1VxHd6fTAsn1KUnHtw0VBsohRjIwxofxTS/GLXj5x3wNeI4viGzAeb
         HZRJ2LWu+m8Nx95lGbtJtt9keEOzpRE8+4OsEZE3gAEIcMSoJ+dNHNVYe8qgJ2WziwrV
         HdXQ==
X-Gm-Message-State: AOAM532uT4SyFqGTDTgYUqOlBL/fCktkyS9xZAefdihCiPh9HccgQLys
        HsDwWElS4SkKHakO7jzNkOKv5Z/lXaDXuwyp5lt9bsYz0cc=
X-Google-Smtp-Source: ABdhPJw8keWcG7kFK/8tW0+240Q64ohoBL0lYh3jAg4lW7rxd21yabqqXWDEnlu86SQ0lX0TBLy17GA4PQQf5Pi+9hM=
X-Received: by 2002:a25:aa8f:: with SMTP id t15mr24227710ybi.459.1600125353433;
 Mon, 14 Sep 2020 16:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAGeTCaXCwN6XLNM6u6r+2_DuqQ+GFbqdZah345P38U9xOntMeQ@mail.gmail.com>
In-Reply-To: <CAGeTCaXCwN6XLNM6u6r+2_DuqQ+GFbqdZah345P38U9xOntMeQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 14 Sep 2020 16:15:42 -0700
Message-ID: <CAEf4BzaoXN9HfUmZ-3HdCyS4+ykey2Mz4vrdz9jWe9r7rwSG6g@mail.gmail.com>
Subject: Re: map_lookup_and_delete_elem for BPF_MAP_TYPE_HASH
To:     Borna Cafuk <borna.cafuk@sartura.hr>
Cc:     bpf <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 11, 2020 at 10:03 AM Borna Cafuk <borna.cafuk@sartura.hr> wrote:
>
> Hello everyone,
>
> As far as I can see, `map_lookup_and_delete_elem` is implemented only for
> `BPF_MAP_TYPE_QUEUE` and `BPF_MAP_TYPE_STACK` [0]. It might be useful to be
> able to do this operation on other kinds of maps, e.g. `BPF_MAP_TYPE_HASH`.
>
> If I'm not mistaken, it would have benefits over `bpf_map_lookup_elem` followed
> by `bpf_map_delete_elem` in regards to avoiding race conditions.

Yes, for a case when you know the key. But for the more general
iteration cases, in which you go over all elements, read, and later
remove element, not so much, because removing element would
essentially break iteration. But I do agree, for some cases it should
be quite useful.

>
> Is there a reason this functionality wasn't implemented?

Probably no one had a specific use case for this.

> Is it planned for any time soon?
>

No, as far as I'm aware.

> I'm looking forward to your input.

Feel free to implement this and send a patch. It doesn't seem to
impose any extra limitations on use of BPF_MAP_TYPE_HASH, so I don't
see why this can't be done.

>
> Best regards,
> Borna Cafuk
>
> [0] https://elixir.bootlin.com/linux/v5.9-rc4/source/kernel/bpf/syscall.c#L1501
