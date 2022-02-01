Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56B84A6510
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 20:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiBATcs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 14:32:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiBATcs (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 14:32:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82AC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 11:32:48 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cq9-20020a17090af98900b001b8262fe2d5so496770pjb.0
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 11:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Nowegv2OshyN6XYfmwxnTW+oSzihW0wNJWXbHMJZlo=;
        b=qu8zegJ2lRQEhmMt6gz8FmduA5n1bp6LVj2SP+WI7Fs0i5DEv2W5s5KcQrTqmhb4qB
         ikblf6Oyn3+u7/rUYq/Ca7ZzqRBOj8odB3hWI99kKCSDjfBmznKIIyRIBb4+qBNW4kgY
         utSK6+zmzerZqaW9rIxkstQESFp4viTEt08G+b1pcRszoYlom4MZCtRhZl4nmteuHNru
         hJIiTxeoJtpIJ87kclP7KawhwVWACfI9vvEPPIjzUeZ77OTZnDLov8j0VimrJUk6vFRt
         BDKu8tA3SW1KNyY9N74UcgijMItyQk29YT/6WziyXJm1n56Z38IKs0Q8zkqhRh+FuTr2
         KAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Nowegv2OshyN6XYfmwxnTW+oSzihW0wNJWXbHMJZlo=;
        b=DC1tEmTuwR0x3vy7j6rQz04EnZtYOoL9PkpIfMRf4mulWfVWdZi59mfJBgM7lZz/93
         J/xXsMZd1NzTjvDoogdabYCQhWxUaj1ulzXP/uzBZbFJwIt/N8ttd2A+FmdX58bE9RPf
         chRMB3/D58P0gvE5hnx0FjssAyHomlf5oTXCxr+pPS5sYiTGE48OZ5piTbcaXY5b1uG/
         U4hm78aeCVPVULi6Zj/W96WNbb/IuqEFk56kFlVLpNMFmb6hF8klNflX+Wvfp0nJyGY/
         Ag12llsrxGppXzSsdqTQvTw/Qtj3Pt/rNQbq/ilMwhw/hHmdlpw5czgOTQlgV1FO6Z4D
         8baw==
X-Gm-Message-State: AOAM531wE5JapbiXTJmh+ybvIA7LljBFryIKTrL06ap1LkwLg2KEM+AF
        DjSFui5cminIP4wfTdksywA=
X-Google-Smtp-Source: ABdhPJzM6YOZ1uTTmaRIXWl59Wzkg3osYhMBgbYM2h3K+AyCG5yHfPmFSk/5kwKWs6gyB6aD/XwK/A==
X-Received: by 2002:a17:90b:4b90:: with SMTP id lr16mr4076338pjb.52.1643743967842;
        Tue, 01 Feb 2022 11:32:47 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::569f])
        by smtp.gmail.com with ESMTPSA id a19sm23167176pfv.116.2022.02.01.11.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 11:32:47 -0800 (PST)
Date:   Tue, 1 Feb 2022 11:32:45 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
Message-ID: <20220201193245.w6ucelz6hbrmzyqt@ast-mbp.dhcp.thefacebook.com>
References: <20220126214809.3868787-1-kuifeng@fb.com>
 <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
 <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jan 31, 2022 at 10:45:53PM -0800, Andrii Nakryiko wrote:
> 
> As Jiri mentioned, for multi-attach kprobes the idea was to keep a
> sorted array of ips and associated cookies to do log(N) search in
> bpf_get_attach_cookie() helper.
> 
> For multi-attach fentry, we could use the same approach if we let
> either bpf_link or bpf_prog available to fentry/fexit program at
> runtime.

Makes sense to me.
It's probably better to land multi-attach kprobe and fentry first,
so we don't need to refactor trampolines once again.
iirc the trampolines were not easy to refactor for Jiri.
I'm afraid that adding prog_id or a pointer to the trampoline
will complicate things even more for multi attach.

It's easy to store hard coded bpf_tramp_image pointer in the generated
trampoline. Storing prog_id or bpf_prog pointer there is a bit
harder, since the [sp-X] store needs to happen right in there invoke_bpf_prog()
(since there can be multiple progs per trampoline).

From there bpf_get_attach_cookie() can either do binary search
in the ip->cookie array or single load in case of non-multi attach.

Anyway the cookie support in trampoline seems to be easier to design
when there is a clarity on multi-attach fentry.

I would probably add support for cookie in raw_tp/tp_btf first,
since that part is not going to be affected by multi-* work.

> We don't need all BPF program types, but anything that's useful for
> generic tracing is much more powerful with cookies. We have them for
> kprobe, uprobe and perf_event programs already. For multi-attach
> kprobe/kretprobe and fentry/fexit they are essentially a must to let
> users use those BPF program types to their fullest.

agree. I missed the part that cookie is already supported with kuprobes
when attach is done via bpf_link_create.
