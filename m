Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FE0349B1A
	for <lists+bpf@lfdr.de>; Thu, 25 Mar 2021 21:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhCYUj2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Mar 2021 16:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCYUjV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Mar 2021 16:39:21 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49460C06174A
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 13:39:21 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 8so3597181ybc.13
        for <bpf@vger.kernel.org>; Thu, 25 Mar 2021 13:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UVU5LIJYCDhojSVhBk+mTM70PPq6E7JHswt+DlmLO7E=;
        b=ZUBOAC4Z/6qi55ywLvgQMM82vL8LZ7TOrvmcQXt5UnxkL6cRM0jRRr8SWd5FPYUjrc
         tb4VlOMDsBZ61I91gCIQCjFC5jtqVgE0kLH6Hu7hmhIIa32dyTlVpsH1o1egWxEPS04t
         d+bIFICe8bMIgnSzpHsSA2fsrTIKASJOmDvQ9FRpAzYdHr8DRD6cNDadUhJAMm8A+fN1
         WTwhTxocFypJNUnhu34nFg0bu6nKlDxWofA034sEaOJPkLl3SA+msTjxfiTNEctsb0T/
         xxNjMXj+wWPJS02RWdEmuE3wXfK3zXBGrFpifO3MKZDQE0IwBSJZ9yaeSC4aoZMckQgS
         1tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UVU5LIJYCDhojSVhBk+mTM70PPq6E7JHswt+DlmLO7E=;
        b=CgEOFDpgQZU4VZ8y5g8nMMaw0UDYZXOwm6yf047PY+G6akw8lwiLJsiPnLrKN6rXXb
         qRMcnNMaFX9RgB8OM1gCzzR3AJuf/fan+wTaRcL8ssPNecod1q9JsJjMmVQ14owo+i5Q
         rTCUfIFf22SaY5nqt6Mh0rbT/dJrsHtv/y7+19af7kh0eCxdIqZauxp5V/qm9DViY6O+
         Bv/4FC20ZKDHOrPX8ZCakuVxu0BFBHsqpEaRkidRs8M09sG4kT7DA3yaHZbj9QcjW/lD
         NCXdSdbSB0xmAU5nwA2uoUToBP5MsA7J0786+T0tb8qyJd89BG8WZ7X7OtTdh3iSaziT
         3ofA==
X-Gm-Message-State: AOAM533EW3YN9XibRWYTv671GTtsFcTl9GApHJWFyp1v8J3luAMsxhVO
        soCCdP548npg35uI7xmxiEKIVEiTTBetEOaU5zk=
X-Google-Smtp-Source: ABdhPJwsO0h0VdYvwNV59a1tmqFwLAEl404G93NMe2Vz4oJhQXoqCampLnF7ZwPonP4C0LDPzS6a/Ht0tSPjeci2NHc=
X-Received: by 2002:a25:9942:: with SMTP id n2mr14467044ybo.230.1616704760541;
 Thu, 25 Mar 2021 13:39:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210323040952.2118241-1-rafaeldtinoco@ubuntu.com>
 <60597d21d7eed_45ba42086@john-XPS-13-9370.notmuch> <a286bddf-8217-57e3-30bf-a09f3de2592e@ubuntu.com>
In-Reply-To: <a286bddf-8217-57e3-30bf-a09f3de2592e@ubuntu.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Mar 2021 13:39:09 -0700
Message-ID: <CAEf4BzYjyppFCS02n-+VyNbj8-FHMyFMtV7-+_ttkroceEjLbg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] libbpf: add bpf object kern_version attribute setter
To:     Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 25, 2021 at 1:01 PM Rafael David Tinoco
<rafaeldtinoco@ubuntu.com> wrote:
>
> >> Unfortunately some distros don't have their kernel version defined
> >> accurately in <linux/version.h> due to different long term support
> >> reasons.
> >>
> >> It is important to have a way to override the bpf kern_version
> >> attribute during runtime: some old kernels might still check for
> >> kern_version attribute during bpf_prog_load().
> >>
> >> Signed-off-by: Rafael David Tinoco <rafaeldtinoco@ubuntu.com>
> >> ---
> >>   tools/lib/bpf/libbpf.c   | 10 ++++++++++
> >>   tools/lib/bpf/libbpf.h   |  1 +
> >>   tools/lib/bpf/libbpf.map |  1 +
> >>   3 files changed, 12 insertions(+)
> >>
> >
> > Hi Andrii and Rafael,
> >
> > Did you consider making kernel version an attribute of the load
> > API, bpf_prog_load_xattr()? This feels slightly more natural
> > to me, to tell the API the kernel you need at load time.
>
> Hi John,
>
> This is how I'm using:
> https://github.com/rafaeldtinoco/portablebpf/blob/master/mine.c#L285
>
> > Although, I don't use the skeleton pieces so maybe it would be
> > awkward for that usage.
>
> having a xxx_bpf object:
>
> xxx_bpf__open_and_load() -> xxx_bpf__load() ->
> bpf_object__load_skeleton() -> bpf_object_load() -> bpf_object__loadxattr()
>
> We would have to add kern_version to 'bpf_object_skeleton' struct, to be
> passed to 'bpf_object__load_skeleton()' to have it passed on.
>
> I'll let Andrii to see what he prefers.

See my reply to John. What he asked for already exists. Having a test
would be nice, but selftests/bpf don't have an infrastructure to even
perform this test, so I don't think it's worth it.

So in summary, LGTM. I'll apply it once bpf-next is ready to accept new patches.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Note:
>
> Reason for all this (including the legacy kprobe logic, in other commit)
> is to continue the
> https://github.com/rafaeldtinoco/conntracker/tree/poc-cmd project,
> making sure it supports 4.x kernels. Still adding bpf support to it
> (identify task/pid per flow) and will replace the libnf* usage with bpf
> after that.
>
> Thanks
> -rafaeldtinoco
