Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270242415C1
	for <lists+bpf@lfdr.de>; Tue, 11 Aug 2020 06:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgHKEfD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Aug 2020 00:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgHKEfD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Aug 2020 00:35:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07826C06174A
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 21:35:02 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so1381039wmk.3
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2020 21:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nP8dbRroDGIPGp7jAupRHH/oNcvJSA92eebXYkMhZFI=;
        b=wQw9APkEtpZSn7Lv+sD0nBuTa9XydjRwIDEFpalAVkbqHi/OtUTAKBikdTnxfO+r44
         UGxggvTf6ioGuMNXWtO3e3ipxArQyoJdOL+t9/yAQ70ha+VGWg/YtDn2R7wr3Tl+VRVZ
         Fs0XVA+ZgjgUPyHkT3WhptS5kx1Uq0hEO8nfcuqKBpjSQfQjY68+wkt5eMfsSlRILa3A
         ZXxtsbdVY0mS9SsGch12QH3ecJAOzKb6aiZqqCxuMmowgLeCfDawuYCHagyMZ0j7YhgK
         KYGjqsQb26SgK0JGbxy/n+4CWw0xfRrRrKTxZ0vQm4dUE/lMtB3qBUMS7lUlePMLe3mg
         aI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nP8dbRroDGIPGp7jAupRHH/oNcvJSA92eebXYkMhZFI=;
        b=cRIdzUvgEK6a7VT3kF7gDAnRxloPWXEQZxrK2dwCup2QlauA7fq3a1OHjaLByRI//Y
         G63ozXbJB32/T+33nc3+8JBe4MWg2MscvB2D6kXpXB4ePKYNQiDe+L/gUFQQcMjEWEQj
         V83MvOnu6KYMuWYjW0gXGjjuMTWQdbyLlbMF8pjewl+gwOpa4/ea5Q7W3qZ9C+KUpkx1
         VzSVdmHROK9uA0SefDNbPtVOy8F3cotRT43uo5ke1/PwBO5DvIc5lkDsEJWUIxAJ9+d0
         QvRG/IXlEGxYS+5BMoLrUxVJZ3t3tH0PYMwyhAhtCSW9XID30Q+Ud9tkTd/md1Xd3Qrd
         5FJw==
X-Gm-Message-State: AOAM5309ILFjqmFRkaefvWaKiDaG4dOzOHyiHkC1nKS9gVvuO7xcQwNY
        gqLpbmtTDJsOzqYRdqPf1aUHo8s1V6cqPeit3+XXjzp8
X-Google-Smtp-Source: ABdhPJxYR48MUAKfa2Po5OAojprZiX2nTCGBCwceEEf5KKMmWptUq8EYrWq3BWC3XZUweTFIKQ6PmXVfzfn+OVo1t48=
X-Received: by 2002:a7b:cf0c:: with SMTP id l12mr2209464wmg.77.1597120501388;
 Mon, 10 Aug 2020 21:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200811030852.3396929-1-yhs@fb.com> <CAEf4Bzaa5rj0a+NVVjZNxD9+MueCuaOwt0kZP7-7eJxkH7df7g@mail.gmail.com>
In-Reply-To: <CAEf4Bzaa5rj0a+NVVjZNxD9+MueCuaOwt0kZP7-7eJxkH7df7g@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 10 Aug 2020 21:34:50 -0700
Message-ID: <CAP-5=fXNVctKxAqQN=ARDjx7YRErdWaBdSZMHB-HMNpe36ckCg@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: do not use __builtin_offsetof for offsetof
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 10, 2020 at 9:33 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Aug 10, 2020 at 8:09 PM Yonghong Song <yhs@fb.com> wrote:
> >
> > Commit 5fbc220862fc ("tools/libpf: Add offsetof/container_of macro
> > in bpf_helpers.h") added a macro offsetof() to get the offset of a
> > structure member:
> >    #define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
> >
> > In certain use cases, size_t type may not be available so
> > Commit da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof
> > for offsetof") changed to use __builtin_offsetof which removed
> > the dependency on type size_t, which I suggested.
> >
> > But using __builtin_offsetof will prevent CO-RE relocation
> > generation in case that, e.g., TYPE is annotated with "preserve_access_info"
> > where a relocation is desirable in case the member offset is changed
> > in a different kernel version. So this patch reverted back to
> > the original macro but using "unsigned long" instead of "site_t".
> >
> > Cc: Ian Rogers <irogers@google.com>
> > Fixes: da7a35062bcc ("libbpf bpf_helpers: Use __builtin_offsetof for offsetof")
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> LGTM.
>
> Acked-by: Andrii Nakryiko <andriin@fb.com>

Acked-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> >  tools/lib/bpf/bpf_helpers.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> > index bc14db706b88..e9a4ecddb7a5 100644
> > --- a/tools/lib/bpf/bpf_helpers.h
> > +++ b/tools/lib/bpf/bpf_helpers.h
> > @@ -40,7 +40,7 @@
> >   * Helper macro to manipulate data structures
> >   */
> >  #ifndef offsetof
> > -#define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
> > +#define offsetof(TYPE, MEMBER) ((unsigned long)&((TYPE *)0)->MEMBER)
> >  #endif
> >  #ifndef container_of
> >  #define container_of(ptr, type, member)                                \
> > --
> > 2.24.1
> >
