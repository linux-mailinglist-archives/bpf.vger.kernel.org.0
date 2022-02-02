Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C224A698E
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 02:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbiBBBQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 20:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiBBBQG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 20:16:06 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4208EC061714
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 17:16:06 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z199so23510511iof.10
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 17:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G31TeZUAFKBxWwgAxTza1nQItrffBhUCDy4AHvldAT4=;
        b=AnT4qU+uu+IrsEZqC3a3nbU2HnVOnxfdPDNIcPYQ0QYGUcZczPvN3rNng+BQz7O9to
         LDlynH7b+IYPXLRYIiW81yZx6ihBaDJNP72nmZvTTiXbcB6ggPstcKnV+ZG0KOz3BFFZ
         n9D3Df42zSWjgSYbcz2Wly9zyMjz3Se/0yYkYjnmNrdwd31PgZmFqX98meQTAYAES6A/
         xI0z4L9Fbn22Q16+xXZLxLJTgmAY4dcdheTDJy/1cVPHSX3etdChMjPcz0ONp0sglEpX
         nulsHMYgGlXhexKV5EE1QMnBxLfKWQyZB114uEi/EkTF9c/j9CYReBTUCTdQYgeYIV0Y
         HdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G31TeZUAFKBxWwgAxTza1nQItrffBhUCDy4AHvldAT4=;
        b=vESvXvGodCoBjL4+UQlAVsjq4YU8e6yB8XloIYRIUKO/WI7pgtseFPWaWKKhS3ZXHG
         n4kqoI7WnPoaMzk4+QDrna8OMEwR20W3RAW8n47Wu/nP8NJtHGlSziuVTexK08U0+tj7
         usMApEyTsvOr5mUfTEljoEznmtQpQVaFnepTK1GT35qcc2LV/XZgZWmAh0VH5veLNL9N
         8jWo7wFVfKubAcOUVnDstEtZb8lkvEwy82L6AS69vBjIQz4RsWgJMtzbNyHBxlEZB3o2
         ZsGUxpel1aw4uXMYu7Niz8PeJStKk1rXzEx7BohcIGNQVsjT/i1qvxr3bq70oo5HC5As
         /GuQ==
X-Gm-Message-State: AOAM533KWz4m622f4IwvBleG7GM/RPmnuIyX3P+us+ErGc5QVoo/DKTq
        LyJiF0QzubFyeNatCfcWCzxC7o3rFMwQmo40zfA=
X-Google-Smtp-Source: ABdhPJybi9KgLmEBmXc7FKtqM3C/NSsuD4DkDvzd2T/G1GiBbQNJsj9k3o91iYFlRW/U2X4Eah9cqcfBL0a++Cvz898=
X-Received: by 2002:a02:2422:: with SMTP id f34mr14464346jaa.237.1643764565664;
 Tue, 01 Feb 2022 17:16:05 -0800 (PST)
MIME-Version: 1.0
References: <20220126214809.3868787-1-kuifeng@fb.com> <CAADnVQKkJCj+_aoJN2YtS3-Hc68uk1S2vN=5+0M0Q9KRVuxqoQ@mail.gmail.com>
 <CAEf4BzYFFnBnLu0ue8HoeZDD6V3DBKZFFKSA7VnL=duQgqc-nQ@mail.gmail.com> <20220201193245.w6ucelz6hbrmzyqt@ast-mbp.dhcp.thefacebook.com>
In-Reply-To: <20220201193245.w6ucelz6hbrmzyqt@ast-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Feb 2022 17:15:54 -0800
Message-ID: <CAEf4BzamtpsEpi_jnstEY0QLmq+PMUYq0nDhYjQ0dDg4wjLP9A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/5] Attach a cookie to a tracing program.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 1, 2022 at 11:32 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Jan 31, 2022 at 10:45:53PM -0800, Andrii Nakryiko wrote:
> >
> > As Jiri mentioned, for multi-attach kprobes the idea was to keep a
> > sorted array of ips and associated cookies to do log(N) search in
> > bpf_get_attach_cookie() helper.
> >
> > For multi-attach fentry, we could use the same approach if we let
> > either bpf_link or bpf_prog available to fentry/fexit program at
> > runtime.
>
> Makes sense to me.
> It's probably better to land multi-attach kprobe and fentry first,
> so we don't need to refactor trampolines once again.
> iirc the trampolines were not easy to refactor for Jiri.
> I'm afraid that adding prog_id or a pointer to the trampoline
> will complicate things even more for multi attach.

Yep, sure, makes sense to me.

>
> It's easy to store hard coded bpf_tramp_image pointer in the generated
> trampoline. Storing prog_id or bpf_prog pointer there is a bit
> harder, since the [sp-X] store needs to happen right in there invoke_bpf_prog()
> (since there can be multiple progs per trampoline).
>
> From there bpf_get_attach_cookie() can either do binary search
> in the ip->cookie array or single load in case of non-multi attach.
>
> Anyway the cookie support in trampoline seems to be easier to design
> when there is a clarity on multi-attach fentry.
>

True. bpf_tramp_image pointer probably won't work for multi-attach
fentry because one bpf_tramp_image will be shared by multiple
attachments (bpf_links), right?

Ideally we should provide a way to lookup "current bpf_link" at
runtime from BPF helpers (given fentry ctx) and do that binary search
there. There could be few other options (e.g., bpf_tramp_image +
binary search based on prog_id or bpf_prog pointer), but it's a bit
more cumbersome. It still feels like something per-program would need
to come from the context to be able to distinguish between multiple
attachments. But as you said, more clarity on multi-attach fentry
first would be best.

> I would probably add support for cookie in raw_tp/tp_btf first,
> since that part is not going to be affected by multi-* work.

Yep, let's try that first.

>
> > We don't need all BPF program types, but anything that's useful for
> > generic tracing is much more powerful with cookies. We have them for
> > kprobe, uprobe and perf_event programs already. For multi-attach
> > kprobe/kretprobe and fentry/fexit they are essentially a must to let
> > users use those BPF program types to their fullest.
>
> agree. I missed the part that cookie is already supported with kuprobes
> when attach is done via bpf_link_create.
