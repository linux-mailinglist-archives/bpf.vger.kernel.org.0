Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB924E872
	for <lists+bpf@lfdr.de>; Sat, 22 Aug 2020 18:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHVQBF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Aug 2020 12:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727893AbgHVQBE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Aug 2020 12:01:04 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2310C061573
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 09:01:03 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id x2so2725772ybf.12
        for <bpf@vger.kernel.org>; Sat, 22 Aug 2020 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KfPngkPp2GG16nCgQIkGSGUPAKP4FGAcIYzfMvdkWgg=;
        b=stoc6eeZVJVPFYMLL4tLOwn84dQmYGBLrX/fj+RHzh7PCz9cCRI0gtaIRMjzCN7O6f
         egzwxc7oNCR12nbgEFPZ9BbApbjbSlIgITZyhuvTw9rPJXuvlr33e8paiZVHdNWpJ/vo
         vwb4B4pJlNGCY38PRdDldxHSn6aVkiySUUE8BEcRnbhXPeL8odxnAN2bC2IVNBIsoQIX
         NEkkDISciwi29v6BiCQ4M78JyK9E/bKwePBSI77RLJZhJQOeWnBvoSinib3YsaGTdbTj
         7p7Q+RW/HqbnMxVUDuHYjDsFW8J1E+uHNiPKWRSdzzqSK5CoDJBKZKgH81jLhi3Angqa
         EF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KfPngkPp2GG16nCgQIkGSGUPAKP4FGAcIYzfMvdkWgg=;
        b=GBYdSySkfE85g1muFQD7Hf5T7llB08Fo4P289tink/gEaVR0KlOQ60q/TM3JPIMceZ
         JuOKUW3ciNh8CzQJ76ZA9NjmsCDpUIWwJ8xB+CJA7Ph8yLl319IRuIRHX2wR50dfyria
         GPm6/MFvFYnl4vPnDDXmEwKQuqqIMZOm7JnDeQ+snQSerrjTV+yPmnoP800pFCSsEieR
         iI6HHKTY+36ugTBFZuFQYvRioQGWV7dulOR5Yzgi/syNOdjGJT1abanyfSzAU26V8sru
         KvNbVYV7Xa+N8llpIXw4OxkJCI0nL+QikweYQhqxdqmyCkOkvQ6YKUpBge2ecEQBa8Cc
         1cJA==
X-Gm-Message-State: AOAM533+xBSBZoNQuzz3s8+KFxERWyixYqTPUNdjPDb/Uyu2F0D/uCeU
        9i+tBDlSlANtox9I9nBlLj+Pb81Ap1hg81kz9MYaAks/Z3c=
X-Google-Smtp-Source: ABdhPJxctzyrTsnfDmphDkXUpWecb+T7O62EqSapbj0T5BygD0IK10AvS7yZLrmQzaj5Rm+pHzpORkwYkg1QgWCi+IQ=
X-Received: by 2002:a25:d84a:: with SMTP id p71mr11227072ybg.347.1598112062570;
 Sat, 22 Aug 2020 09:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <99122200-5308-25c0-cc4f-145847ef7edb@fb.com> <20200822112713.317226-1-liorribak@gmail.com>
In-Reply-To: <20200822112713.317226-1-liorribak@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sat, 22 Aug 2020 09:00:51 -0700
Message-ID: <CAEf4BzYzu5uxRCCpEiBS5BVxPaDKZydws=nkRUAat--a5ZoNHw@mail.gmail.com>
Subject: Re: [PATCH] samples/bpf: Support both enter and exit kprobes in helper
To:     Lior Ribak <liorribak@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        john fastabend <john.fastabend@gmail.com>,
        Martin Lau <kafai@fb.com>, KP Singh <kpsingh@chromium.org>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 22, 2020 at 4:30 AM Lior Ribak <liorribak@gmail.com> wrote:
>
> On 8/15/20 11:02 PM, Yonghong Song wrote:
> >On 8/15/20 12:57 PM, Lior Ribak wrote:
> >> Currently, in bpf_load.c, the function write_kprobe_events sets
> >> the function name to probe as the probe name.
> >> Even though it's valid to set one kprobe on enter and another on exit,
> >> bpf_load.c won't handle it, and will return an error 'File exists'.
> >>
> >> Add a prefix to the event name to indicate if it's on enter or exit,
> >> so both an enter and an exit kprobes can be attached.
>
> >
> >Only bpf_load.c change and no users here. So do you imply that
> >use use this piece code in your own environment some how? But in
> >that case, not sure whether this patch is necessary or not.
> >
> >The change here is for legacy bpf_load which may go away in the future.
> >I understand this is for debugfs based kprobe_events where current
> >libbpf does not support. But if possible, you should upgrade to use
> >fd-based kprobe which is introduced roughly in/around 4.17 and libbpf
> >has proper support.
>
> I used the samples and it's toolchain to write my own bpf, so i wrote this
> patch to save the trouble to the next one who will try to register 2
> kprobes on the same function.
> I still suggest to apply the patch because it solves a bug.
>
> As I see it, all the wrappers around ebpf are duplicated everywhere, and
> fd-based krpobe is already wrapped in the bcc project, so if you suggest
> to switch and use it, maybe it's better to import some of the code from
> bcc instead
>

What Yonghong suggested is to deprecate bpf_load.c completely,
including a legacy way to attach kprobe, which will stay connected
without proper clean up, if the application crashes. This has been a
reason for multiple production problems so far and we've moved away
from that, as a community.

There is no need to import anything from BCC, libbpf already supports
this and much more. samples/bpf unfortunately are a bit outdated (and
any help to bring them more in line with modern libbpf usage would be
greatly appreciated!), the best place to look at better and more
modern examples would be tools/testing/selftests/bpf in Linux repo, or
for more realistic examples of building tracing tools, please check
[0].

  [0] https://github.com/iovisor/bcc/tree/master/libbpf-tools

> >
> >>
> >> Signed-off-by: Lior Ribak <liorribak@gmail.com>
> >> ---
> >>   samples/bpf/bpf_load.c | 20 +++++++++++++-------
> >>   1 file changed, 13 insertions(+), 7 deletions(-)
> >>

[...]
